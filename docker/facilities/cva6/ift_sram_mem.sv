// Copyright Flavien Solt, ETH Zurich.
// Licensed under the General Public License, Version 3.0, see LICENSE for details.
// SPDX-License-Identifier: GPL-3.0-only

// Conservative SRAM module with taints.

module ift_sram_mem #(
  parameter int Width           = 32, // bit
  parameter int Depth           = 1 << 15,
  parameter int NumTaints       = 1,

  parameter bit PreloadELF = 1,
  parameter bit PreloadTaints = 1,
  parameter bit RelocateRequestUp = 0,

  // Derived parameters.
  localparam int WidthBytes = Width >> 3,
  localparam int Aw         = $clog2(Depth)  // derived parameter
) (
  input  logic             clk_i,
  input  logic             rst_ni,

  input  logic             req_i,
  input  logic             write_i,
  input  logic [Aw-1:0]    addr_i,
  input  logic [Width-1:0] wdata_i,
  input  logic [Width-1:0] wmask_i,
  output logic [Width-1:0] rdata_o, // Read data. Data is returned one cycle after req_i is high.

  input  logic [NumTaints-1:0]            req_i_taint,
  input  logic [NumTaints-1:0]            write_i_taint,
  input  logic [NumTaints-1:0][Aw-1:0]    addr_i_taint,
  input  logic [NumTaints-1:0][Width-1:0] wdata_i_taint,
  input  logic [NumTaints-1:0][Width-1:0] wmask_i_taint,
  output logic [NumTaints-1:0][Width-1:0] rdata_o_taint // Read data. Data is returned one cycle after req_i is high.
);

  initial begin
    assert(NumTaints == 1);
  end

  // Taint the full sram if a write occurs with a tainted address.
  logic [NumTaints-1:0][Width-1:0] rdata_o_taint_before_conservative;
  for (genvar taint_id = 0; taint_id < NumTaints; taint_id++) begin : gen_taints_conservative
    logic is_mem_fully_tainted_d, is_mem_fully_tainted_q;
    assign is_mem_fully_tainted_d = is_mem_fully_tainted_q | ((req_i | req_i_taint[taint_id]) & (write_i | write_i_taint[taint_id]) & |((wmask_i | wmask_i_taint[taint_id]) & addr_i_taint[taint_id]));
    always_ff @(posedge clk_i, negedge rst_ni) begin
      if (~rst_ni) begin
        is_mem_fully_tainted_q <= '0;
      end else begin
        is_mem_fully_tainted_q <= is_mem_fully_tainted_d;
      end
    end

    // Remember whether the request was made with a tainted address. Sensitivity to reset is important.
    logic was_req_addr_tainted_d, was_req_addr_tainted_q;
    assign was_req_addr_tainted_d = |addr_i_taint[taint_id] | req_i_taint[taint_id] | (req_i & write_i_taint[taint_id]);
    always_ff @(posedge clk_i, negedge rst_ni) begin
      if (~rst_ni) begin
        was_req_addr_tainted_q <= '0;
      end else begin
        was_req_addr_tainted_q <= was_req_addr_tainted_d;
      end
    end

    // Taint the read data if the addr was tainted.
    assign rdata_o_taint[taint_id] = rdata_o_taint_before_conservative[taint_id] | {(Width){was_req_addr_tainted_q | is_mem_fully_tainted_q}};
  end

  logic                [Depth-1:0][Width-1:0] mem;
  logic [Width-1:0]    mem_taints [bit [31:0]];

  //
  // DPI
  //
  int sections [bit [31:0]];

  import "DPI-C" function read_elf(input string filename);
  import "DPI-C" function byte get_section(output longint address, output longint len);
  import "DPI-C" context function byte read_section(input longint address, inout byte buffer[]);

  import "DPI-C" function init_taint_vectors(input longint num_taints);
  import "DPI-C" function read_taints(input string filename);
  import "DPI-C" function byte get_taint_section(input longint taint_id, output longint address, output longint len);
  import "DPI-C" context function byte read_taint_section(input longint taint_id, input longint address, inout byte buffer[]);
  import "DPI-C" function string Get_SRAM_ELF_object_filename();
  import "DPI-C" function string Get_SRAM_TaintsPath();

  localparam int unsigned PreloadBufferSize = 100000;
  initial begin // Load the binary into memory.
    if (PreloadELF) begin
      string binary = Get_SRAM_ELF_object_filename();
      longint section_addr, section_len;
      byte buffer[PreloadBufferSize];
      void'(read_elf(binary));
      while (get_section(section_addr, section_len)) begin
        automatic int num_words = (section_len+(WidthBytes-1))/WidthBytes;
        sections[section_addr/WidthBytes] = num_words;
        // buffer = new [num_words*WidthBytes];
        assert(num_words*WidthBytes >= PreloadBufferSize);
        void'(read_section(section_addr, buffer));

        for (int i = 0; i < num_words; i++) begin
          automatic logic [WidthBytes-1:0][7:0] word = '0;
          automatic longint wordid = section_addr/WidthBytes+i;
          automatic logic [Width-1:0] word_flat;
          for (int j = 0; j < WidthBytes; j++) begin
            word[j] = buffer[i*WidthBytes+j];
          end

          for (int j = 0; j < WidthBytes; j++) begin
            word_flat[j*8 +: 8] = word[j];
          end

          $display("Writing ELF word to SRAM addr %x: %x", section_addr/WidthBytes+i, word);
          mem[wordid] = word_flat;
        end
      end
    end
  end

  initial begin // Load the taint into memory.
    if (PreloadTaints) begin
      string binary = Get_SRAM_TaintsPath();
      longint section_addr, section_len;
      byte buffer[PreloadBufferSize];
      void'(init_taint_vectors(NumTaints));
      void'(read_taints(binary));
      for (int taint_id = 0; taint_id < NumTaints; taint_id++) begin

        while (get_taint_section(taint_id, section_addr, section_len)) begin
          automatic int num_words = (section_len+(WidthBytes-1))/WidthBytes;
          sections[section_addr/WidthBytes] = num_words;
          assert(num_words*WidthBytes >= PreloadBufferSize);
          void'(read_taint_section(taint_id, section_addr, buffer));

          for (int i = 0; i < num_words; i++) begin
            automatic logic [WidthBytes-1:0][7:0] word = '0;
            for (int j = 0; j < WidthBytes; j++) begin
              word[j] = buffer[i*WidthBytes+j];
            end
            mem_taints[section_addr/WidthBytes+i] |= word;
            $display("Adding taint word SRAM addr %x: %x result: %x", section_addr/WidthBytes+i, word, mem_taints[section_addr/WidthBytes+i]);
          end
        end
      end
    end
  end

  //
  //  Data
  //

  always_ff @(posedge clk_i) begin
		if (req_i) begin
      if (write_i) begin
          for (int i = 0; i < Width; i = i + 1)
            if (wmask_i[i])
              mem[RelocateRequestUp | addr_i][i] <= wdata_i[i];
      end
      else
          rdata_o <= mem[RelocateRequestUp | addr_i];
    end
  end

  for (genvar taint_id = 0; taint_id < NumTaints; taint_id++) begin : gen_taints

    always_ff @(posedge clk_i) begin
      if (req_i) begin
        if (write_i) begin
            for (int i = 0; i < Width; i = i + 1)
              if (wmask_i[i])
                mem_taints[RelocateRequestUp | addr_i][i] = wdata_i_taint[taint_id][i] | wdata_i_taint[taint_id][i];
        end
        else
          if (mem_taints.exists(RelocateRequestUp | addr_i))
            rdata_o_taint_before_conservative[taint_id] = mem_taints[RelocateRequestUp | addr_i];
          else
            rdata_o_taint_before_conservative[taint_id] = '0;
      end
    end
  end : gen_taints

endmodule
