(*blackbox*)
module sram_mem #(
  parameter int Width           = 32, // bit
  parameter int Depth           = 1 << 15,

  parameter bit PreloadELF = 1,
  parameter logic [63:0] RelocateRequestUp = '0,

  // Derived parameters.
  localparam int WidthBytes = Width >> 3,
  localparam int Aw         = $clog2(Depth),
  localparam bit [Aw-1:0] AddrMask = {Aw{1'b1}}
) (
  input  logic             clk_i,
  input  logic             rst_ni,

  input  logic             req_i,
  input  logic             write_i,
  input  logic [Aw-1:0]    addr_i,
  input  logic [Width-1:0] wdata_i,
  input  logic [WidthBytes-1:0] wmask_i,
  output logic [Width-1:0] rdata_o
);

    assign rdata_o = '0;

endmodule
