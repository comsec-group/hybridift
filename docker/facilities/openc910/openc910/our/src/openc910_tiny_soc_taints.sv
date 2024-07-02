// Copyright Flavien Solt, ETH Zurich.
// Licensed under the General Public License, Version 3.0, see LICENSE for details.
// SPDX-License-Identifier: GPL-3.0-only

// Toplevel module.

module openc910_tiny_soc #(
  // Must be the same parameters as openc910_mem_top
  localparam int unsigned SRAM_ADDR_WIDTH = 21,
  localparam int unsigned SRAM_DATA_WIDTH = 128
  ) (
  input  wire          i_pad_clk,
  input  wire          i_pad_jtg_tclk,
  input  wire          i_pad_jtg_tdi,
  input  wire          i_pad_jtg_tms,
  input  wire          i_pad_jtg_trst_b,
  input  wire          i_pad_rst_b,
  input  wire          i_pad_uart0_sin,
  output wire          o_pad_jtg_tdo,
  output wire          o_pad_uart0_sout,
  inout  wire [7  :0]  b_pad_gpio_porta,

  // Additional debug signals
  output logic mem_req_o,
  output logic [SRAM_ADDR_WIDTH-1:0] mem_addr_o,
  output logic [SRAM_DATA_WIDTH-1:0] mem_wdata_o,
  output logic [SRAM_DATA_WIDTH-1:0] mem_strb_o,
  output logic mem_we_o,
  output logic [SRAM_DATA_WIDTH-1:0] mem_rdata_o
);

  logic  [39 :0]  araddr_s0;
  logic  [1  :0]  arburst_s0;
  logic  [3  :0]  arcache_s0;
  logic  [7  :0]  arid_s0;
  logic  [7  :0]  arlen_s0;
  logic  [2  :0]  arprot_s0;
  logic  [2  :0]  arsize_s0;
  logic           arvalid_s0;
  logic  [39 :0]  awaddr_s0;
  logic  [1  :0]  awburst_s0;
  logic  [3  :0]  awcache_s0;
  logic  [7  :0]  awid_s0;
  logic  [7  :0]  awlen_s0;
  logic  [2  :0]  awprot_s0;
  logic  [2  :0]  awsize_s0;
  logic           awvalid_s0;
  logic           bready_s0;
  logic           pll_core_cpuclk;
  logic           rready_s0;
  logic  [127:0]  wdata_s0;
  logic  [7  :0]  wid_s0;
  logic           wlast_s0;
  logic  [15 :0]  wstrb_s0;
  logic           wvalid_s0;
  logic           arready_s0;
  logic           awready_s0;
  logic  [7  :0]  bid_s0;
  logic  [1  :0]  bresp_s0;
  logic           bvalid_s0;
  logic  [127:0]  rdata_s0;
  logic  [7  :0]  rid_s0;
  logic           rlast_s0;
  logic  [1  :0]  rresp_s0;
  logic           rvalid_s0;
  logic           wready_s0;

  /////////////////////
  // Taint signals
  /////////////////////

  logic          i_pad_clk_t0;
  logic          i_pad_jtg_tclk_t0;
  logic          i_pad_jtg_tdi_t0;
  logic          i_pad_jtg_tms_t0;
  logic          i_pad_jtg_trst_b_t0;
  logic          i_pad_rst_b_t0;
  logic          i_pad_uart0_sin_t0;
  logic          o_pad_jtg_tdo_t0;
  logic          o_pad_uart0_sout_t0;
  logic [7  :0]  b_pad_gpio_porta_t0;

  logic  [39 :0]  araddr_s0_t0;
  logic  [1  :0]  arburst_s0_t0;
  logic  [3  :0]  arcache_s0_t0;
  logic  [7  :0]  arid_s0_t0;
  logic  [7  :0]  arlen_s0_t0;
  logic  [2  :0]  arprot_s0_t0;
  logic  [2  :0]  arsize_s0_t0;
  logic           arvalid_s0_t0;
  logic  [39 :0]  awaddr_s0_t0;
  logic  [1  :0]  awburst_s0_t0;
  logic  [3  :0]  awcache_s0_t0;
  logic  [7  :0]  awid_s0_t0;
  logic  [7  :0]  awlen_s0_t0;
  logic  [2  :0]  awprot_s0_t0;
  logic  [2  :0]  awsize_s0_t0;
  logic           awvalid_s0_t0;
  logic           bready_s0_t0;
  logic           pll_core_cpuclk_t0;
  logic           rready_s0_t0;
  logic  [127:0]  wdata_s0_t0;
  logic  [7  :0]  wid_s0_t0;
  logic           wlast_s0_t0;
  logic  [15 :0]  wstrb_s0_t0;
  logic           wvalid_s0_t0;
  logic           arready_s0_t0;
  logic           awready_s0_t0;
  logic  [7  :0]  bid_s0_t0;
  logic  [1  :0]  bresp_s0_t0;
  logic           bvalid_s0_t0;
  logic  [127:0]  rdata_s0_t0;
  logic  [7  :0]  rid_s0_t0;
  logic           rlast_s0_t0;
  logic  [1  :0]  rresp_s0_t0;
  logic           rvalid_s0_t0;
  logic           wready_s0_t0;

  ///////
  // Other signals
  ///////

  logic pad_cpu_rst_b;

openc910_mem_top i_mem_top (
  .pad_cpu_rst_b_t0(pad_cpu_rst_b_t0),
  
  .i_pad_clk(i_pad_clk),
  .i_pad_jtg_tclk(i_pad_jtg_tclk),
  .i_pad_jtg_tdi(i_pad_jtg_tdi),
  .i_pad_jtg_tms(i_pad_jtg_tms),
  .i_pad_jtg_trst_b(i_pad_jtg_trst_b),
  .i_pad_rst_b(i_pad_rst_b),
  .i_pad_uart0_sin(i_pad_uart0_sin),
  .o_pad_jtg_tdo(o_pad_jtg_tdo),
  .o_pad_uart0_sout(o_pad_uart0_sout),
  .b_pad_gpio_porta(b_pad_gpio_porta),
  .i_pad_clk_t0(i_pad_clk_t0),
  .i_pad_jtg_tclk_t0(i_pad_jtg_tclk_t0),
  .i_pad_jtg_tdi_t0(i_pad_jtg_tdi_t0),
  .i_pad_jtg_tms_t0(i_pad_jtg_tms_t0),
  .i_pad_jtg_trst_b_t0(i_pad_jtg_trst_b_t0),
  .i_pad_rst_b_t0(i_pad_rst_b_t0),
  .i_pad_uart0_sin_t0(i_pad_uart0_sin_t0),
  .o_pad_jtg_tdo_t0(o_pad_jtg_tdo_t0),
  .o_pad_uart0_sout_t0(o_pad_uart0_sout_t0),
  .b_pad_gpio_porta_t0(b_pad_gpio_porta_t0),
  .araddr_s0_t0(araddr_s0_t0),
  .arburst_s0_t0(arburst_s0_t0),
  .arcache_s0_t0(arcache_s0_t0),
  .arid_s0_t0(arid_s0_t0),
  .arlen_s0_t0(arlen_s0_t0),
  .arprot_s0_t0(arprot_s0_t0),
  .arsize_s0_t0(arsize_s0_t0),
  .arvalid_s0_t0(arvalid_s0_t0),
  .awaddr_s0_t0(awaddr_s0_t0),
  .awburst_s0_t0(awburst_s0_t0),
  .awcache_s0_t0(awcache_s0_t0),
  .awid_s0_t0(awid_s0_t0),
  .awlen_s0_t0(awlen_s0_t0),
  .awprot_s0_t0(awprot_s0_t0),
  .awsize_s0_t0(awsize_s0_t0),
  .awvalid_s0_t0(awvalid_s0_t0),
  .bready_s0_t0(bready_s0_t0),
  .pll_core_cpuclk_t0(pll_core_cpuclk_t0),
  .rready_s0_t0(rready_s0_t0),
  .wdata_s0_t0(wdata_s0_t0),
  .wid_s0_t0(wid_s0_t0),
  .wlast_s0_t0(wlast_s0_t0),
  .wstrb_s0_t0(wstrb_s0_t0),
  .wvalid_s0_t0(wvalid_s0_t0),
  .arready_s0_t0(arready_s0_t0),
  .awready_s0_t0(awready_s0_t0),
  .bid_s0_t0(bid_s0_t0),
  .bresp_s0_t0(bresp_s0_t0),
  .bvalid_s0_t0(bvalid_s0_t0),
  .rdata_s0_t0(rdata_s0_t0),
  .rid_s0_t0(rid_s0_t0),
  .rlast_s0_t0(rlast_s0_t0),
  .rresp_s0_t0(rresp_s0_t0),
  .rvalid_s0_t0(rvalid_s0_t0),
  .wready_s0_t0(wready_s0_t0),
  .araddr_s0(araddr_s0),
  .arburst_s0(arburst_s0),
  .arcache_s0(arcache_s0),
  .arid_s0(arid_s0),
  .arlen_s0(arlen_s0),
  .arprot_s0(arprot_s0),
  .arsize_s0(arsize_s0),
  .arvalid_s0(arvalid_s0),
  .awaddr_s0(awaddr_s0),
  .awburst_s0(awburst_s0),
  .awcache_s0(awcache_s0),
  .awid_s0(awid_s0),
  .awlen_s0(awlen_s0),
  .awprot_s0(awprot_s0),
  .awsize_s0(awsize_s0),
  .awvalid_s0(awvalid_s0),
  .bready_s0(bready_s0),
  .pad_cpu_rst_b(pad_cpu_rst_b),
  .pll_core_cpuclk(pll_core_cpuclk),
  .rready_s0(rready_s0),
  .wdata_s0(wdata_s0),
  .wid_s0(wid_s0),
  .wlast_s0(wlast_s0),
  .wstrb_s0(wstrb_s0),
  .wvalid_s0(wvalid_s0),
  .arready_s0(arready_s0),
  .awready_s0(awready_s0),
  .bid_s0(bid_s0),
  .bresp_s0(bresp_s0),
  .bvalid_s0(bvalid_s0),
  .rdata_s0(rdata_s0),
  .rid_s0(rid_s0),
  .rlast_s0(rlast_s0),
  .rresp_s0(rresp_s0),
  .rvalid_s0(rvalid_s0),
  .wready_s0(wready_s0)
);

our_axi_slave128  x_our_axi_slave128 (
  .araddr_s0        (araddr_s0),       //(fifo_pad_araddr ),
  .arburst_s0       (arburst_s0),      //(fifo_pad_arburst),
  .arcache_s0       (arcache_s0),      //(fifo_pad_arcache),
  .arid_s0          (arid_s0),         //(fifo_pad_arid   ),
  .arlen_s0         (arlen_s0),        //(fifo_pad_arlen  ),
  .arprot_s0        (arprot_s0),       //(fifo_pad_arprot ),
  .arready_s0       (arready_s0),      //(arready_s0      ),
  .arsize_s0        (arsize_s0),       //(fifo_pad_arsize ),
  .arvalid_s0       (arvalid_s0),      //(arvalid_s0      ),
  .awaddr_s0        (awaddr_s0),       //(biu_pad_awaddr  ),
  .awburst_s0       (awburst_s0),      //(biu_pad_awburst ),
  .awcache_s0       (awcache_s0),      //(biu_pad_awcache ),
  .awid_s0          (awid_s0),         //(biu_pad_awid    ),
  .awlen_s0         (awlen_s0),        //(biu_pad_awlen   ),
  .awprot_s0        (awprot_s0),       //(biu_pad_awprot  ),
  .awready_s0       (awready_s0),      //(awready_s0      ),
  .awsize_s0        (awsize_s0),       //(biu_pad_awsize  ),
  .awvalid_s0       (awvalid_s0),      //(awvalid_s0      ),
  .bid_s0           (bid_s0),          //(bid_s0          ),
  .bready_s0        (bready_s0),       //(bready_s0       ),
  .bresp_s0         (bresp_s0),        //(bresp_s0        ),
  .bvalid_s0        (bvalid_s0),       //(bvalid_s0       ),
  .pad_cpu_rst_b    (pad_cpu_rst_b),   //(pad_cpu_rst_b   ),
  .pll_core_cpuclk  (pll_core_cpuclk), //(per_clk         ),
  .rdata_s0         (rdata_s0),        //(rdata_s0        ),
  .rid_s0           (rid_s0),          //(rid_s0          ),
  .rlast_s0         (rlast_s0),        //(rlast_s0        ),
  .rready_s0        (rready_s0),       //(rready_s0       ),
  .rresp_s0         (rresp_s0),        //(rresp_s0        ),
  .rvalid_s0        (rvalid_s0),       //(rvalid_s0       ),
  .wdata_s0         (wdata_s0),        //(biu_pad_wdata   ),
  .wid_s0           (wid_s0),          //(biu_pad_wid     ),
  .wlast_s0         (wlast_s0),        //(biu_pad_wlast   ),
  .wready_s0        (wready_s0),       //(wready_s0       ),
  .wstrb_s0         (wstrb_s0),        //(biu_pad_wstrb   ),
  .wvalid_s0        (wvalid_s0),       //(wvalid_s0       ),

  .mem_req_o        (mem_req_o       ),
  .mem_addr_o       (mem_addr_o      ),
  .mem_wdata_o      (mem_wdata_o     ),
  .mem_strb_o       (mem_strb_o      ),
  .mem_we_o         (mem_we_o        ),
  .mem_rdata_o      (mem_rdata_o     )
);

endmodule


