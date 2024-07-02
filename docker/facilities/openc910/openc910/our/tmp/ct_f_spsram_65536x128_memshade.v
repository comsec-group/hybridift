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
module ct_f_spsram_65536x128(
A,
A_t0,
CEN,
CEN_t0,
CLK,
D,
D_t0,
GWEN,
GWEN_t0,
Q,
Q_t0,
WEN,
WEN_t0
);

input  [ADDR_WIDTH-1:0]   A_t0;
input                     CEN_t0;
input  [DATA_WIDTH-1:0]   D_t0;
input                     GWEN_t0;
output [DATA_WIDTH-1:0]   Q_t0;
input  [DATA_WIDTH-1:0]   WEN_t0;
wire  [ADDR_WIDTH-1:0]   A_t0;
wire                     CEN_t0;
wire  [DATA_WIDTH-1:0]   D_t0;
wire                     GWEN_t0;
wire  [DATA_WIDTH-1:0]   Q_t0;
wire  [DATA_WIDTH-1:0]   WEN_t0;
assign Q_t0 = '0;

parameter ADDR_WIDTH = 16;
parameter DATA_WIDTH = 128;
parameter WRAP_SIZE  = 1;

input  [ADDR_WIDTH-1:0]   A;
input                     CEN;
input                     CLK;
input  [DATA_WIDTH-1:0]   D;
input                     GWEN;
input  [DATA_WIDTH-1:0]   WEN;
output [DATA_WIDTH-1:0]   Q;

reg    [ADDR_WIDTH-1:0]   addr_holding;

wire  [ADDR_WIDTH-1:0]   A;
wire                     CEN;
wire                     CLK;
wire  [DATA_WIDTH-1:0]   D;
wire                     GWEN;
wire  [DATA_WIDTH-1:0]   WEN;
wire  [DATA_WIDTH-1:0]   Q;
wire  [ADDR_WIDTH-1:0]   addr;

always@(posedge CLK)
begin
  if(!CEN) begin
    addr_holding[ADDR_WIDTH-1:0] <= A[ADDR_WIDTH-1:0];
  end
end

assign addr[ADDR_WIDTH-1:0] = CEN ? addr_holding[ADDR_WIDTH-1:0]
                                  : A[ADDR_WIDTH-1:0];

wire [DATA_WIDTH-1:0] ram_wen_vec;
genvar i;
generate
  for(i=0; i<DATA_WIDTH; i=i+1) begin: RAM_DIN_VEC
    assign ram_wen_vec[i] = !CEN & !WEN[i]  & !GWEN;
  end
endgenerate
generate 
  for(i=0; i<DATA_WIDTH; i=i+1) begin: RAM_INSTANCE
    my_fpga_ram #(WRAP_SIZE,ADDR_WIDTH) ram_instance(
      .PortAClk (CLK),
      .PortAAddr(addr),
      .PortADataIn (D[i]),
      .PortAWriteEnable(ram_wen_vec[i]),
      .PortADataOut(Q[i]));
  end
endgenerate

endmodule

