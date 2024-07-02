/*Copyright 2019-2021 T-Head Semiconductor Co., Ltd.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/



// Modified by F Solt to use a single RAM instead of a whole bank of them.
// For sim it should not be detrimental and will help do nicer DPI calls.

module our_f_spsram_large #(
  parameter int unsigned ADDR_WIDTH = 21,	// 2MB per ram, 16MB at all for f_spsram_large
  parameter int unsigned WRAP_WIDTH = 128
  ) (
  input  logic [ADDR_WIDTH-1:0]  A,        
  input  logic         CEN,      
  input  logic         CLK,      
  input  logic [127:0] D,        
  input  logic [15:0]  WEN,      
  output logic [127:0] Q,        

  output logic mem_req_o,
  output logic [ADDR_WIDTH-1:0] mem_addr_o,
  output logic [WRAP_WIDTH-1:0] mem_wdata_o,
  output logic [WRAP_WIDTH-1:0] mem_strb_o,
  output logic mem_we_o,
  output logic [WRAP_WIDTH-1:0] mem_rdata_o
);

reg     [ADDR_WIDTH-1:0]  addr_holding; 


wire    [ADDR_WIDTH-1:0]  addr;        
wire    [WRAP_WIDTH-1 :0]  ram_din;    
wire    [WRAP_WIDTH-1 :0]  ram_dout;    

wire ram0_wen;
wire ram1_wen;
wire ram2_wen;
wire ram3_wen;
wire ram4_wen;
wire ram5_wen;
wire ram6_wen;
wire ram7_wen;
wire ram8_wen;
wire ram9_wen;
wire ram10_wen;
wire ram11_wen;
wire ram12_wen;
wire ram13_wen;
wire ram14_wen;
wire ram15_wen;
wire [WRAP_WIDTH-1:0] ram_wen_bitwise;

assign ram0_wen = !CEN && !WEN[0];
assign ram1_wen = !CEN && !WEN[1];
assign ram2_wen = !CEN && !WEN[2];
assign ram3_wen = !CEN && !WEN[3];
assign ram4_wen = !CEN && !WEN[4];
assign ram5_wen = !CEN && !WEN[5];
assign ram6_wen = !CEN && !WEN[6];
assign ram7_wen = !CEN && !WEN[7];
assign ram8_wen = !CEN && !WEN[8];
assign ram9_wen = !CEN && !WEN[9];
assign ram10_wen = !CEN && !WEN[10];
assign ram11_wen = !CEN && !WEN[11];
assign ram12_wen = !CEN && !WEN[12];
assign ram13_wen = !CEN && !WEN[13];
assign ram14_wen = !CEN && !WEN[14];
assign ram15_wen = !CEN && !WEN[15];

assign ram_wen_bitwise = {
  ram15_wen, ram15_wen, ram15_wen, ram15_wen, ram15_wen, ram15_wen, ram15_wen, ram15_wen,
  ram14_wen, ram14_wen, ram14_wen, ram14_wen, ram14_wen, ram14_wen, ram14_wen, ram14_wen,
  ram13_wen, ram13_wen, ram13_wen, ram13_wen, ram13_wen, ram13_wen, ram13_wen, ram13_wen,
  ram12_wen, ram12_wen, ram12_wen, ram12_wen, ram12_wen, ram12_wen, ram12_wen, ram12_wen,
  ram11_wen, ram11_wen, ram11_wen, ram11_wen, ram11_wen, ram11_wen, ram11_wen, ram11_wen,
  ram10_wen, ram10_wen, ram10_wen, ram10_wen, ram10_wen, ram10_wen, ram10_wen, ram10_wen,
  ram9_wen, ram9_wen, ram9_wen, ram9_wen, ram9_wen, ram9_wen, ram9_wen, ram9_wen,
  ram8_wen, ram8_wen, ram8_wen, ram8_wen, ram8_wen, ram8_wen, ram8_wen, ram8_wen,
  ram7_wen, ram7_wen, ram7_wen, ram7_wen, ram7_wen, ram7_wen, ram7_wen, ram7_wen,
  ram6_wen, ram6_wen, ram6_wen, ram6_wen, ram6_wen, ram6_wen, ram6_wen, ram6_wen,
  ram5_wen, ram5_wen, ram5_wen, ram5_wen, ram5_wen, ram5_wen, ram5_wen, ram5_wen,
  ram4_wen, ram4_wen, ram4_wen, ram4_wen, ram4_wen, ram4_wen, ram4_wen, ram4_wen,
  ram3_wen, ram3_wen, ram3_wen, ram3_wen, ram3_wen, ram3_wen, ram3_wen, ram3_wen,
  ram2_wen, ram2_wen, ram2_wen, ram2_wen, ram2_wen, ram2_wen, ram2_wen, ram2_wen,
  ram1_wen, ram1_wen, ram1_wen, ram1_wen, ram1_wen, ram1_wen, ram1_wen, ram1_wen,
  ram0_wen, ram0_wen, ram0_wen, ram0_wen, ram0_wen, ram0_wen, ram0_wen, ram0_wen
};

assign ram_din[WRAP_WIDTH-1:0] = D[WRAP_WIDTH-1:0];

always@(posedge CLK)
begin
  if(!CEN) begin
    addr_holding[ADDR_WIDTH-1:0] <= A[ADDR_WIDTH-1:0];
  end
end

assign addr[ADDR_WIDTH-1:0] = CEN ? addr_holding[ADDR_WIDTH-1:0]
                                  : A[ADDR_WIDTH-1:0];

assign Q[WRAP_WIDTH-1:0]               = ram_dout[WRAP_WIDTH-1:0];

// ram #(WRAP_WIDTH,ADDR_WIDTH) ram0(
//   .PortAClk (CLK),
//   .PortAAddr(addr),
//   .PortADataIn (ram0_din),
//   .PortAWriteEnable(ram0_wen),
//   .PortADataOut(ram0_dout));


sram_mem #(WRAP_WIDTH,1<<ADDR_WIDTH) i_sram_mem (
  .clk_i(CLK),
  .rst_ni(1'b1),
  .req_i(1'b1),
  .write_i(|ram_wen_bitwise),
  .addr_i(addr),
  .wdata_i(ram_din),
  .wmask_i(ram_wen_bitwise),
  .rdata_o(ram_dout)
);

assign mem_req_o = ~CEN;
assign mem_addr_o = addr;
assign mem_wdata_o = ram_din;
assign mem_strb_o = ram_wen_bitwise;
assign mem_we_o = |ram_wen_bitwise;
assign mem_rdata_o = ram_dout;

//   parameter int Width           = 32, // bit
//   parameter int Depth           = 1 << 21,

//   parameter bit PreloadELF = 1,
//   parameter logic [63:0] RelocateRequestUp = '0,

//   // Derived parameters.
//   localparam int WidthBytes = Width >> 3,
//   localparam int Aw         = $clog2(Depth),
//   localparam bit [Aw-1:0] AddrMask = {Aw{1'b1}}
// ) (
//   input  logic             clk_i,
//   input  logic             rst_ni,

//   input  logic             req_i,
//   input  logic             write_i,
//   input  logic [Aw-1:0]    addr_i,
//   input  logic [Width-1:0] wdata_i,
//   input  logic [Width-1:0] wmask_i,
//   output logic [Width-1:0] rdata_o
// );


endmodule


