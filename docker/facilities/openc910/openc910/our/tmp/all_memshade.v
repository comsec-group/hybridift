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

// &Depend("my_fpga_ram.v"); @23

// &ModuleBeg; @25
module ct_f_spsram_1024x128(
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

input   [9  :0]  A_t0;           
input            CEN_t0;         
input   [127:0]  D_t0;           
input            GWEN_t0;        
output  [127:0]  Q_t0;           
input   [127:0]  WEN_t0;         
wire    [9  :0]  A_t0;           
wire             CEN_t0;         
wire    [127:0]  D_t0;           
wire             GWEN_t0;        
wire    [127:0]  Q_t0;           
wire    [127:0]  WEN_t0;         
assign Q_t0 = '0;

// &Ports; @26
input   [9  :0]  A;           
input            CEN;         
input            CLK;         
input   [127:0]  D;           
input            GWEN;        
input   [127:0]  WEN;         
output  [127:0]  Q;           

// &Regs; @27
reg     [9  :0]  addr_holding; 

// &Wires; @28
wire    [9  :0]  A;           
wire             CEN;         
wire             CLK;         
wire    [127:0]  D;           
wire             GWEN;        
wire    [127:0]  Q;           
wire    [127:0]  WEN;         
wire    [9  :0]  addr;        
wire    [127:0]  ram_din;     
wire    [127:0]  ram_dout;    
wire             ram_wen;     


parameter ADDR_WIDTH = 10;
parameter WRAP_SIZE  = 128;

//write enable
// &Force("nonport","ram_wen"); @34
// &Force("bus","WEN",127,0); @35
assign ram_wen = !CEN && !WEN[127] && !GWEN;
//din
// &Force("nonport","ram_din"); @38
// &Force("bus","D",WRAP_SIZE-1,0); @39
assign ram_din[WRAP_SIZE-1:0] = D[WRAP_SIZE-1:0];
//address
// &Force("nonport","addr"); @42
always@(posedge CLK)
begin
  if(!CEN) begin
    addr_holding[ADDR_WIDTH-1:0] <= A[ADDR_WIDTH-1:0];
  end
end

assign addr[ADDR_WIDTH-1:0] = CEN ? addr_holding[ADDR_WIDTH-1:0]
                                  : A[ADDR_WIDTH-1:0];
//dout
// &Force("nonport","ram_dout"); @53
assign Q[WRAP_SIZE-1:0]                = ram_dout[WRAP_SIZE-1:0];
my_fpga_ram #(WRAP_SIZE,ADDR_WIDTH) ram(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram_din),
  .PortAWriteEnable(ram_wen),
  .PortADataOut(ram_dout));

// &ModuleEnd; @62
endmodule


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
module ct_f_spsram_1024x144(
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

parameter ADDR_WIDTH = 10;
parameter DATA_WIDTH = 144;
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
    my_fpga_ram #(WRAP_SIZE,ADDR_WIDTH) ram_instance(
      .PortAClk (CLK),
      .PortAAddr(addr),
      .PortADataIn (D[i]),
      .PortAWriteEnable(ram_wen_vec[i]),
      .PortADataOut(Q[i]));
  end
endgenerate

endmodule

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

// &Depend("my_fpga_ram.v"); @23

// &ModuleBeg; @25
module ct_f_spsram_1024x32(
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

input   [9 :0]  A_t0;           
input           CEN_t0;         
input   [31:0]  D_t0;           
input           GWEN_t0;        
output  [31:0]  Q_t0;           
input   [31:0]  WEN_t0;         
wire    [9 :0]  A_t0;           
wire            CEN_t0;         
wire    [31:0]  D_t0;           
wire            GWEN_t0;        
wire    [31:0]  Q_t0;           
wire    [31:0]  WEN_t0;         
assign Q_t0 = '0;

// &Ports; @26
input   [9 :0]  A;           
input           CEN;         
input           CLK;         
input   [31:0]  D;           
input           GWEN;        
input   [31:0]  WEN;         
output  [31:0]  Q;           

// &Regs; @27
reg     [9 :0]  addr_holding; 

// &Wires; @28
wire    [9 :0]  A;           
wire            CEN;         
wire            CLK;         
wire    [31:0]  D;           
wire            GWEN;        
wire    [31:0]  Q;           
wire    [31:0]  WEN;         
wire    [9 :0]  addr;        
wire    [7 :0]  ram0_din;    
wire    [7 :0]  ram0_dout;   
wire            ram0_wen;    
wire    [7 :0]  ram1_din;    
wire    [7 :0]  ram1_dout;   
wire            ram1_wen;    
wire    [7 :0]  ram2_din;    
wire    [7 :0]  ram2_dout;   
wire            ram2_wen;    
wire    [7 :0]  ram3_din;    
wire    [7 :0]  ram3_dout;   
wire            ram3_wen;    


parameter ADDR_WIDTH = 10;
parameter WRAP_SIZE  = 8;

//write enable
// &Force("nonport","ram0_wen"); @34
// &Force("nonport","ram1_wen"); @35
// &Force("nonport","ram2_wen"); @36
// &Force("nonport","ram3_wen"); @37
// &Force("bus","WEN",31,0); @38
assign ram0_wen = !CEN && !WEN[ 7] && !GWEN;
assign ram1_wen = !CEN && !WEN[15] && !GWEN;
assign ram2_wen = !CEN && !WEN[23] && !GWEN;
assign ram3_wen = !CEN && !WEN[31] && !GWEN;

//din
// &Force("nonport","ram0_din"); @45
// &Force("nonport","ram1_din"); @46
// &Force("nonport","ram2_din"); @47
// &Force("nonport","ram3_din"); @48
// &Force("bus","D",4*WRAP_SIZE-1,0); @49
assign ram0_din[WRAP_SIZE-1:0] = D[WRAP_SIZE-1:0];
assign ram1_din[WRAP_SIZE-1:0] = D[2*WRAP_SIZE-1:WRAP_SIZE];
assign ram2_din[WRAP_SIZE-1:0] = D[3*WRAP_SIZE-1:2*WRAP_SIZE];
assign ram3_din[WRAP_SIZE-1:0] = D[4*WRAP_SIZE-1:3*WRAP_SIZE];
//address
// &Force("nonport","addr"); @55
always@(posedge CLK)
begin
  if(!CEN) begin
    addr_holding[ADDR_WIDTH-1:0] <= A[ADDR_WIDTH-1:0];
  end
end

assign addr[ADDR_WIDTH-1:0] = CEN ? addr_holding[ADDR_WIDTH-1:0]
                                  : A[ADDR_WIDTH-1:0];
//dout
// &Force("nonport","ram0_dout"); @66
// &Force("nonport","ram1_dout"); @67
// &Force("nonport","ram2_dout"); @68
// &Force("nonport","ram3_dout"); @69

assign Q[WRAP_SIZE-1:0]             = ram0_dout[WRAP_SIZE-1:0];
assign Q[2*WRAP_SIZE-1:WRAP_SIZE]   = ram1_dout[WRAP_SIZE-1:0];
assign Q[3*WRAP_SIZE-1:2*WRAP_SIZE] = ram2_dout[WRAP_SIZE-1:0];
assign Q[4*WRAP_SIZE-1:3*WRAP_SIZE] = ram3_dout[WRAP_SIZE-1:0];


my_fpga_ram #(WRAP_SIZE,ADDR_WIDTH) ram0(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram0_din),
  .PortAWriteEnable(ram0_wen),
  .PortADataOut(ram0_dout));

my_fpga_ram #(WRAP_SIZE,ADDR_WIDTH) ram1(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram1_din),
  .PortAWriteEnable(ram1_wen),
  .PortADataOut(ram1_dout));

my_fpga_ram #(WRAP_SIZE,ADDR_WIDTH) ram2(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram2_din),
  .PortAWriteEnable(ram2_wen),
  .PortADataOut(ram2_dout));

my_fpga_ram #(WRAP_SIZE,ADDR_WIDTH) ram3(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram3_din),
  .PortAWriteEnable(ram3_wen),
  .PortADataOut(ram3_dout));

// &ModuleEnd; @105
endmodule





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

// &Depend("my_fpga_ram.v"); @23

// &ModuleBeg; @25
module ct_f_spsram_1024x59(
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

input   [9 :0]  A_t0;           
input           CEN_t0;         
input   [58:0]  D_t0;           
input           GWEN_t0;        
output  [58:0]  Q_t0;           
input   [58:0]  WEN_t0;         
wire    [9 :0]  A_t0;           
wire            CEN_t0;         
wire    [58:0]  D_t0;           
wire            GWEN_t0;        
wire    [58:0]  Q_t0;           
wire    [58:0]  WEN_t0;         
assign Q_t0 = '0;

// &Ports; @26
input   [9 :0]  A;           
input           CEN;         
input           CLK;         
input   [58:0]  D;           
input           GWEN;        
input   [58:0]  WEN;         
output  [58:0]  Q;           

// &Regs; @27
reg     [9 :0]  addr_holding; 

// &Wires; @28
wire    [9 :0]  A;           
wire            CEN;         
wire            CLK;         
wire    [58:0]  D;           
wire            GWEN;        
wire    [58:0]  Q;           
wire    [58:0]  WEN;         
wire    [9 :0]  addr;        
wire    [0 :0]  ram0_din;    
wire    [0 :0]  ram0_dout;   
wire            ram0_wen;    
wire    [28:0]  ram1_din;    
wire    [28:0]  ram1_dout;   
wire            ram1_wen;    
wire    [28:0]  ram2_din;    
wire    [28:0]  ram2_dout;   
wire            ram2_wen;    


parameter ADDR_WIDTH   = 10;
parameter WRAP_SIZE_1  = 1;
parameter WRAP_SIZE_2  = 29;

//write enable
// &Force("nonport","ram0_wen"); @35
// &Force("nonport","ram1_wen"); @36
// &Force("nonport","ram2_wen"); @37
// &Force("bus","WEN",58,0); @38
assign ram0_wen = !CEN && !WEN[58] && !GWEN;
assign ram1_wen = !CEN && !WEN[57] && !GWEN;
assign ram2_wen = !CEN && !WEN[28] && !GWEN;

//din
// &Force("nonport","ram0_din"); @44
// &Force("nonport","ram1_din"); @45
// &Force("nonport","ram2_din"); @46
// &Force("bus","D",WRAP_SIZE_1+2*WRAP_SIZE_2-1,0); @47
assign ram0_din[WRAP_SIZE_1-1:0] = D[2*WRAP_SIZE_2:2*WRAP_SIZE_2];
assign ram1_din[WRAP_SIZE_2-1:0] = D[2*WRAP_SIZE_2-1:WRAP_SIZE_2];
assign ram2_din[WRAP_SIZE_2-1:0] = D[WRAP_SIZE_2-1:0];
//address
// &Force("nonport","addr"); @52
always@(posedge CLK)
begin
  if(!CEN) begin
    addr_holding[ADDR_WIDTH-1:0] <= A[ADDR_WIDTH-1:0];
  end
end

assign addr[ADDR_WIDTH-1:0] = CEN ? addr_holding[ADDR_WIDTH-1:0]
                                  : A[ADDR_WIDTH-1:0];
//dout
// &Force("nonport","ram0_dout"); @63
// &Force("nonport","ram1_dout"); @64
// &Force("nonport","ram2_dout"); @65

assign Q[2*WRAP_SIZE_2:2*WRAP_SIZE_2] = ram0_dout[WRAP_SIZE_1-1:0];
assign Q[2*WRAP_SIZE_2-1:WRAP_SIZE_2] = ram1_dout[WRAP_SIZE_2-1:0];
assign Q[WRAP_SIZE_2-1:0]             = ram2_dout[WRAP_SIZE_2-1:0];


my_fpga_ram #(WRAP_SIZE_1,ADDR_WIDTH) ram0(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram0_din),
  .PortAWriteEnable(ram0_wen),
  .PortADataOut(ram0_dout));

my_fpga_ram #(WRAP_SIZE_2,ADDR_WIDTH) ram1(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram1_din),
  .PortAWriteEnable(ram1_wen),
  .PortADataOut(ram1_dout));

my_fpga_ram #(WRAP_SIZE_2,ADDR_WIDTH) ram2(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram2_din),
  .PortAWriteEnable(ram2_wen),
  .PortADataOut(ram2_dout));

// &ModuleEnd; @93
endmodule





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
module ct_f_spsram_1024x64(
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

parameter ADDR_WIDTH = 10;
parameter DATA_WIDTH = 64;
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

// &ModuleBeg; @3
module ct_f_spsram_1024x92(
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

input   [9 :0]  A_t0;           
input           CEN_t0;         
input   [91:0]  D_t0;           
input           GWEN_t0;        
output  [91:0]  Q_t0;           
input   [91:0]  WEN_t0;         
wire    [9 :0]  A_t0;           
wire            CEN_t0;         
wire    [91:0]  D_t0;           
wire            GWEN_t0;        
wire    [91:0]  Q_t0;           
wire    [91:0]  WEN_t0;         
assign Q_t0 = '0;

// &Ports; @4
input   [9 :0]  A;           
input           CEN;         
input           CLK;         
input   [91:0]  D;           
input           GWEN;        
input   [91:0]  WEN;         
output  [91:0]  Q;           

// &Regs; @5
reg     [9 :0]  addr_holding; 

// &Wires; @6
wire    [9 :0]  A;           
wire            CEN;         
wire            CLK;         
wire    [91:0]  D;           
wire            GWEN;        
wire    [91:0]  Q;           
wire    [91:0]  WEN;         
wire    [9 :0]  addr;        
wire    [22:0]  ram_din0;    
wire    [22:0]  ram_din1;    
wire    [22:0]  ram_din2;    
wire    [22:0]  ram_din3;    
wire    [22:0]  ram_dout0;   
wire    [22:0]  ram_dout1;   
wire    [22:0]  ram_dout2;   
wire    [22:0]  ram_dout3;   
wire            ram_wen0;    
wire            ram_wen1;    
wire            ram_wen2;    
wire            ram_wen3;    

// &Force("bus","Q",91,0); @7

parameter ADDR_WIDTH = 10;
parameter WRAP_SIZE  = 23;

//write enable
// &Force("nonport","ram_wen0"); @13
// &Force("nonport","ram_wen1"); @14
// &Force("nonport","ram_wen2"); @15
// &Force("nonport","ram_wen3"); @16

// &Force("bus","WEN",91,0); @18
assign ram_wen0 = !CEN && !WEN[22] && !GWEN;
assign ram_wen1 = !CEN && !WEN[45] && !GWEN;
assign ram_wen2 = !CEN && !WEN[68] && !GWEN;
assign ram_wen3 = !CEN && !WEN[91] && !GWEN;

//din
// &Force("nonport","ram_din0"); @25
// &Force("nonport","ram_din1"); @26
// &Force("nonport","ram_din2"); @27
// &Force("nonport","ram_din3"); @28
// &Force("bus","D",4*WRAP_SIZE-1,0); @29
assign ram_din0[WRAP_SIZE-1:0] = D[WRAP_SIZE-1:0];
assign ram_din1[WRAP_SIZE-1:0] = D[2*WRAP_SIZE-1:WRAP_SIZE];
assign ram_din2[WRAP_SIZE-1:0] = D[3*WRAP_SIZE-1:2*WRAP_SIZE];
assign ram_din3[WRAP_SIZE-1:0] = D[4*WRAP_SIZE-1:3*WRAP_SIZE];
//address
// &Force("nonport","addr"); @35
always@(posedge CLK)
begin
  if(!CEN) begin
    addr_holding[ADDR_WIDTH-1:0] <= A[ADDR_WIDTH-1:0];
  end
end

assign addr[ADDR_WIDTH-1:0] = CEN ? addr_holding[ADDR_WIDTH-1:0]
                                  : A[ADDR_WIDTH-1:0];

//dout
// &Force("nonport","ram_dout0"); @47
// &Force("nonport","ram_dout1"); @48
// &Force("nonport","ram_dout2"); @49
// &Force("nonport","ram_dout3"); @50
assign Q[WRAP_SIZE-1:0]                = ram_dout0[WRAP_SIZE-1:0];
assign Q[2*WRAP_SIZE-1:WRAP_SIZE]      = ram_dout1[WRAP_SIZE-1:0];
assign Q[3*WRAP_SIZE-1:2*WRAP_SIZE]    = ram_dout2[WRAP_SIZE-1:0];
assign Q[4*WRAP_SIZE-1:3*WRAP_SIZE]    = ram_dout3[WRAP_SIZE-1:0];

my_fpga_ram #(WRAP_SIZE,ADDR_WIDTH) ram0(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram_din0),
  .PortAWriteEnable(ram_wen0),
  .PortADataOut(ram_dout0));

my_fpga_ram #(WRAP_SIZE,ADDR_WIDTH) ram1(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram_din1),
  .PortAWriteEnable(ram_wen1),
  .PortADataOut(ram_dout1));

my_fpga_ram #(WRAP_SIZE,ADDR_WIDTH) ram2(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram_din2),
  .PortAWriteEnable(ram_wen2),
  .PortADataOut(ram_dout2));

my_fpga_ram #(WRAP_SIZE,ADDR_WIDTH) ram3(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram_din3),
  .PortAWriteEnable(ram_wen3),
  .PortADataOut(ram_dout3));

// &ModuleEnd; @84
endmodule



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

// &ModuleBeg; @3
module ct_f_spsram_128x104(
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

input   [6  :0]  A_t0;           
input            CEN_t0;         
input   [103:0]  D_t0;           
input            GWEN_t0;        
output  [103:0]  Q_t0;           
input   [103:0]  WEN_t0;         
wire    [6  :0]  A_t0;           
wire             CEN_t0;         
wire    [103:0]  D_t0;           
wire             GWEN_t0;        
wire    [103:0]  Q_t0;           
wire    [103:0]  WEN_t0;         
assign Q_t0 = '0;

// &Ports; @4
input   [6  :0]  A;           
input            CEN;         
input            CLK;         
input   [103:0]  D;           
input            GWEN;        
input   [103:0]  WEN;         
output  [103:0]  Q;           

// &Regs; @5
reg     [6  :0]  addr_holding; 

// &Wires; @6
wire    [6  :0]  A;           
wire             CEN;         
wire             CLK;         
wire    [103:0]  D;           
wire             GWEN;        
wire    [103:0]  Q;           
wire    [103:0]  WEN;         
wire    [6  :0]  addr;        
wire    [25 :0]  ram_din0;    
wire    [25 :0]  ram_din1;    
wire    [25 :0]  ram_din2;    
wire    [25 :0]  ram_din3;    
wire    [25 :0]  ram_dout0;   
wire    [25 :0]  ram_dout1;   
wire    [25 :0]  ram_dout2;   
wire    [25 :0]  ram_dout3;   
wire             ram_wen0;    
wire             ram_wen1;    
wire             ram_wen2;    
wire             ram_wen3;    

// &Force("bus","Q",103,0); @7

parameter ADDR_WIDTH = 7;
parameter WRAP_SIZE  = 26;

//write enable
// &Force("nonport","ram_wen0"); @13
// &Force("nonport","ram_wen1"); @14
// &Force("nonport","ram_wen2"); @15
// &Force("nonport","ram_wen3"); @16

// &Force("bus","WEN",103,0); @18
assign ram_wen0 = !CEN && !WEN[25] && !GWEN;
assign ram_wen1 = !CEN && !WEN[51] && !GWEN;
assign ram_wen2 = !CEN && !WEN[77] && !GWEN;
assign ram_wen3 = !CEN && !WEN[103] && !GWEN;

//din
// &Force("nonport","ram_din0"); @25
// &Force("nonport","ram_din1"); @26
// &Force("nonport","ram_din2"); @27
// &Force("nonport","ram_din3"); @28
// &Force("bus","D",4*WRAP_SIZE-1,0); @29
assign ram_din0[WRAP_SIZE-1:0] = D[WRAP_SIZE-1:0];
assign ram_din1[WRAP_SIZE-1:0] = D[2*WRAP_SIZE-1:WRAP_SIZE];
assign ram_din2[WRAP_SIZE-1:0] = D[3*WRAP_SIZE-1:2*WRAP_SIZE];
assign ram_din3[WRAP_SIZE-1:0] = D[4*WRAP_SIZE-1:3*WRAP_SIZE];
//address
// &Force("nonport","addr"); @35
always@(posedge CLK)
begin
  if(!CEN) begin
    addr_holding[ADDR_WIDTH-1:0] <= A[ADDR_WIDTH-1:0];
  end
end

assign addr[ADDR_WIDTH-1:0] = CEN ? addr_holding[ADDR_WIDTH-1:0]
                                  : A[ADDR_WIDTH-1:0];

//dout
// &Force("nonport","ram_dout0"); @47
// &Force("nonport","ram_dout1"); @48
// &Force("nonport","ram_dout2"); @49
// &Force("nonport","ram_dout3"); @50
assign Q[WRAP_SIZE-1:0]                = ram_dout0[WRAP_SIZE-1:0];
assign Q[2*WRAP_SIZE-1:WRAP_SIZE]      = ram_dout1[WRAP_SIZE-1:0];
assign Q[3*WRAP_SIZE-1:2*WRAP_SIZE]    = ram_dout2[WRAP_SIZE-1:0];
assign Q[4*WRAP_SIZE-1:3*WRAP_SIZE]    = ram_dout3[WRAP_SIZE-1:0];

my_fpga_ram #(WRAP_SIZE,ADDR_WIDTH) ram0(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram_din0),
  .PortAWriteEnable(ram_wen0),
  .PortADataOut(ram_dout0));

my_fpga_ram #(WRAP_SIZE,ADDR_WIDTH) ram1(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram_din1),
  .PortAWriteEnable(ram_wen1),
  .PortADataOut(ram_dout1));

my_fpga_ram #(WRAP_SIZE,ADDR_WIDTH) ram2(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram_din2),
  .PortAWriteEnable(ram_wen2),
  .PortADataOut(ram_dout2));

my_fpga_ram #(WRAP_SIZE,ADDR_WIDTH) ram3(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram_din3),
  .PortAWriteEnable(ram_wen3),
  .PortADataOut(ram_dout3));

// &ModuleEnd; @84
endmodule



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
module ct_f_spsram_128x144(
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

parameter ADDR_WIDTH = 7;
parameter DATA_WIDTH = 144;
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
    my_fpga_ram #(WRAP_SIZE,ADDR_WIDTH) ram_instance(
      .PortAClk (CLK),
      .PortAAddr(addr),
      .PortADataIn (D[i]),
      .PortAWriteEnable(ram_wen_vec[i]),
      .PortADataOut(Q[i]));
  end
endgenerate

endmodule

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

// &Depend("my_fpga_ram.v"); @23

// &ModuleBeg; @25
module ct_f_spsram_128x16(
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

input   [6 :0]  A_t0;           
input           CEN_t0;         
input   [15:0]  D_t0;           
input           GWEN_t0;        
output  [15:0]  Q_t0;           
input   [15:0]  WEN_t0;         
wire    [6 :0]  A_t0;           
wire            CEN_t0;         
wire    [15:0]  D_t0;           
wire            GWEN_t0;        
wire    [15:0]  Q_t0;           
wire    [15:0]  WEN_t0;         
assign Q_t0 = '0;

// &Ports; @26
input   [6 :0]  A;           
input           CEN;         
input           CLK;         
input   [15:0]  D;           
input           GWEN;        
input   [15:0]  WEN;         
output  [15:0]  Q;           

// &Regs; @27
reg     [6 :0]  addr_holding; 

// &Wires; @28
wire    [6 :0]  A;           
wire            CEN;         
wire            CLK;         
wire    [15:0]  D;           
wire            GWEN;        
wire    [15:0]  Q;           
wire    [15:0]  WEN;         
wire    [6 :0]  addr;        
wire            ram0_din;    
wire            ram0_dout;   
wire            ram0_wen;    
wire            ram10_din;   
wire            ram10_dout;  
wire            ram10_wen;   
wire            ram11_din;   
wire            ram11_dout;  
wire            ram11_wen;   
wire            ram12_din;   
wire            ram12_dout;  
wire            ram12_wen;   
wire            ram13_din;   
wire            ram13_dout;  
wire            ram13_wen;   
wire            ram14_din;   
wire            ram14_dout;  
wire            ram14_wen;   
wire            ram15_din;   
wire            ram15_dout;  
wire            ram15_wen;   
wire            ram1_din;    
wire            ram1_dout;   
wire            ram1_wen;    
wire            ram2_din;    
wire            ram2_dout;   
wire            ram2_wen;    
wire            ram3_din;    
wire            ram3_dout;   
wire            ram3_wen;    
wire            ram4_din;    
wire            ram4_dout;   
wire            ram4_wen;    
wire            ram5_din;    
wire            ram5_dout;   
wire            ram5_wen;    
wire            ram6_din;    
wire            ram6_dout;   
wire            ram6_wen;    
wire            ram7_din;    
wire            ram7_dout;   
wire            ram7_wen;    
wire            ram8_din;    
wire            ram8_dout;   
wire            ram8_wen;    
wire            ram9_din;    
wire            ram9_dout;   
wire            ram9_wen;    


parameter ADDR_WIDTH = 7;

//write enable
// &Force("nonport","ram0_wen"); @33
// &Force("nonport","ram1_wen"); @34
// &Force("nonport","ram2_wen"); @35
// &Force("nonport","ram3_wen"); @36
// &Force("nonport","ram4_wen"); @37
// &Force("nonport","ram5_wen"); @38
// &Force("nonport","ram6_wen"); @39
// &Force("nonport","ram7_wen"); @40
// &Force("nonport","ram8_wen"); @41
// &Force("nonport","ram9_wen"); @42
// &Force("nonport","ram10_wen"); @43
// &Force("nonport","ram11_wen"); @44
// &Force("nonport","ram12_wen"); @45
// &Force("nonport","ram13_wen"); @46
// &Force("nonport","ram14_wen"); @47
// &Force("nonport","ram15_wen"); @48
// &Force("bus","WEN",15,0); @49
assign ram0_wen  = !CEN && !WEN[0] && !GWEN;
assign ram1_wen  = !CEN && !WEN[1] && !GWEN;
assign ram2_wen  = !CEN && !WEN[2] && !GWEN;
assign ram3_wen  = !CEN && !WEN[3] && !GWEN;
assign ram4_wen  = !CEN && !WEN[4] && !GWEN;
assign ram5_wen  = !CEN && !WEN[5] && !GWEN;
assign ram6_wen  = !CEN && !WEN[6] && !GWEN;
assign ram7_wen  = !CEN && !WEN[7] && !GWEN;
assign ram8_wen  = !CEN && !WEN[8] && !GWEN;
assign ram9_wen  = !CEN && !WEN[9] && !GWEN;
assign ram10_wen = !CEN && !WEN[10] && !GWEN;
assign ram11_wen = !CEN && !WEN[11] && !GWEN;
assign ram12_wen = !CEN && !WEN[12] && !GWEN;
assign ram13_wen = !CEN && !WEN[13] && !GWEN;
assign ram14_wen = !CEN && !WEN[14] && !GWEN;
assign ram15_wen = !CEN && !WEN[15] && !GWEN;

//din
// &Force("nonport","ram0_din"); @68
// &Force("nonport","ram1_din"); @69
// &Force("nonport","ram2_din"); @70
// &Force("nonport","ram3_din"); @71
// &Force("nonport","ram4_din"); @72
// &Force("nonport","ram5_din"); @73
// &Force("nonport","ram6_din"); @74
// &Force("nonport","ram7_din"); @75
// &Force("nonport","ram8_din"); @76
// &Force("nonport","ram9_din"); @77
// &Force("nonport","ram10_din"); @78
// &Force("nonport","ram11_din"); @79
// &Force("nonport","ram12_din"); @80
// &Force("nonport","ram13_din"); @81
// &Force("nonport","ram14_din"); @82
// &Force("nonport","ram15_din"); @83
// &Force("bus","D",15,0); @84
assign ram0_din = D[0];
assign ram1_din = D[1];
assign ram2_din = D[2];
assign ram3_din = D[3];
assign ram4_din = D[4];
assign ram5_din = D[5];
assign ram6_din = D[6];
assign ram7_din = D[7];
assign ram8_din = D[8];
assign ram9_din = D[9];
assign ram10_din = D[10];
assign ram11_din = D[11];
assign ram12_din = D[12];
assign ram13_din = D[13];
assign ram14_din = D[14];
assign ram15_din = D[15];

//address
// &Force("nonport","addr"); @103
always@(posedge CLK)
begin
  if(!CEN) begin
    addr_holding[ADDR_WIDTH-1:0] <= A[ADDR_WIDTH-1:0];
  end
end

assign addr[ADDR_WIDTH-1:0] = CEN ? addr_holding[ADDR_WIDTH-1:0]
                                  : A[ADDR_WIDTH-1:0];

//dout
// &Force("nonport","ram0_dout"); @115
// &Force("nonport","ram1_dout"); @116
// &Force("nonport","ram2_dout"); @117
// &Force("nonport","ram3_dout"); @118
// &Force("nonport","ram4_dout"); @119
// &Force("nonport","ram5_dout"); @120
// &Force("nonport","ram6_dout"); @121
// &Force("nonport","ram7_dout"); @122
// &Force("nonport","ram8_dout"); @123
// &Force("nonport","ram9_dout"); @124
// &Force("nonport","ram10_dout"); @125
// &Force("nonport","ram11_dout"); @126
// &Force("nonport","ram12_dout"); @127
// &Force("nonport","ram13_dout"); @128
// &Force("nonport","ram14_dout"); @129
// &Force("nonport","ram15_dout"); @130
assign Q[0] = ram0_dout;
assign Q[1] = ram1_dout;
assign Q[2] = ram2_dout;
assign Q[3] = ram3_dout;
assign Q[4] = ram4_dout;
assign Q[5] = ram5_dout;
assign Q[6] = ram6_dout;
assign Q[7] = ram7_dout;
assign Q[8] = ram8_dout;
assign Q[9] = ram9_dout;
assign Q[10] = ram10_dout;
assign Q[11] = ram11_dout;
assign Q[12] = ram12_dout;
assign Q[13] = ram13_dout;
assign Q[14] = ram14_dout;
assign Q[15] = ram15_dout;

my_fpga_ram #(1,ADDR_WIDTH) ram0(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram0_din),
  .PortAWriteEnable(ram0_wen),
  .PortADataOut(ram0_dout));

my_fpga_ram #(1,ADDR_WIDTH) ram1(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram1_din),
  .PortAWriteEnable(ram1_wen),
  .PortADataOut(ram1_dout));

my_fpga_ram #(1,ADDR_WIDTH) ram2(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram2_din),
  .PortAWriteEnable(ram2_wen),
  .PortADataOut(ram2_dout));

my_fpga_ram #(1,ADDR_WIDTH) ram3(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram3_din),
  .PortAWriteEnable(ram3_wen),
  .PortADataOut(ram3_dout));

my_fpga_ram #(1,ADDR_WIDTH) ram4(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram4_din),
  .PortAWriteEnable(ram4_wen),
  .PortADataOut(ram4_dout));

my_fpga_ram #(1,ADDR_WIDTH) ram5(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram5_din),
  .PortAWriteEnable(ram5_wen),
  .PortADataOut(ram5_dout));

my_fpga_ram #(1,ADDR_WIDTH) ram6(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram6_din),
  .PortAWriteEnable(ram6_wen),
  .PortADataOut(ram6_dout));

my_fpga_ram #(1,ADDR_WIDTH) ram7(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram7_din),
  .PortAWriteEnable(ram7_wen),
  .PortADataOut(ram7_dout));

my_fpga_ram #(1,ADDR_WIDTH) ram8(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram8_din),
  .PortAWriteEnable(ram8_wen),
  .PortADataOut(ram8_dout));

my_fpga_ram #(1,ADDR_WIDTH) ram9(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram9_din),
  .PortAWriteEnable(ram9_wen),
  .PortADataOut(ram9_dout));

my_fpga_ram #(1,ADDR_WIDTH) ram10(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram10_din),
  .PortAWriteEnable(ram10_wen),
  .PortADataOut(ram10_dout));

my_fpga_ram #(1,ADDR_WIDTH) ram11(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram11_din),
  .PortAWriteEnable(ram11_wen),
  .PortADataOut(ram11_dout));

my_fpga_ram #(1,ADDR_WIDTH) ram12(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram12_din),
  .PortAWriteEnable(ram12_wen),
  .PortADataOut(ram12_dout));

my_fpga_ram #(1,ADDR_WIDTH) ram13(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram13_din),
  .PortAWriteEnable(ram13_wen),
  .PortADataOut(ram13_dout));

my_fpga_ram #(1,ADDR_WIDTH) ram14(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram14_din),
  .PortAWriteEnable(ram14_wen),
  .PortADataOut(ram14_dout));

my_fpga_ram #(1,ADDR_WIDTH) ram15(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram15_din),
  .PortAWriteEnable(ram15_wen),
  .PortADataOut(ram15_dout));


// &ModuleEnd; @261
endmodule




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

// &Depend("my_fpga_ram.v"); @23

// &ModuleBeg; @25
module ct_f_spsram_16384x128(
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

input   [13 :0]  A_t0;           
input            CEN_t0;         
input   [127:0]  D_t0;           
input            GWEN_t0;        
output  [127:0]  Q_t0;           
input   [127:0]  WEN_t0;         
wire    [13 :0]  A_t0;           
wire             CEN_t0;         
wire    [127:0]  D_t0;           
wire             GWEN_t0;        
wire    [127:0]  Q_t0;           
wire    [127:0]  WEN_t0;         
assign Q_t0 = '0;

// &Ports; @26
input   [13 :0]  A;           
input            CEN;         
input            CLK;         
input   [127:0]  D;           
input            GWEN;        
input   [127:0]  WEN;         
output  [127:0]  Q;           

// &Regs; @27
reg     [13 :0]  addr_holding; 

// &Wires; @28
wire    [13 :0]  A;           
wire             CEN;         
wire             CLK;         
wire    [127:0]  D;           
wire             GWEN;        
wire    [127:0]  Q;           
wire    [127:0]  WEN;         
wire    [13 :0]  addr;        
wire    [127:0]  ram_din;     
wire    [127:0]  ram_dout;    
wire             ram_wen;     


parameter ADDR_WIDTH = 14;
parameter WRAP_SIZE  = 128;

//write enable
// &Force("nonport","ram_wen"); @34
// &Force("bus","WEN",127,0); @35
assign ram_wen = !CEN && !WEN[127] && !GWEN;
//din
// &Force("nonport","ram_din"); @38
// &Force("bus","D",WRAP_SIZE-1,0); @39
assign ram_din[WRAP_SIZE-1:0] = D[WRAP_SIZE-1:0];
//address
// &Force("nonport","addr"); @42
always@(posedge CLK)
begin
  if(!CEN) begin
    addr_holding[ADDR_WIDTH-1:0] <= A[ADDR_WIDTH-1:0];
  end
end

assign addr[ADDR_WIDTH-1:0] = CEN ? addr_holding[ADDR_WIDTH-1:0]
                                  : A[ADDR_WIDTH-1:0];
//dout
// &Force("nonport","ram_dout"); @53
assign Q[WRAP_SIZE-1:0]                = ram_dout[WRAP_SIZE-1:0];
my_fpga_ram #(WRAP_SIZE,ADDR_WIDTH) ram(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram_din),
  .PortAWriteEnable(ram_wen),
  .PortADataOut(ram_dout));

// &ModuleEnd; @62
endmodule


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

// &Depend("my_fpga_ram.v"); @23

// &ModuleBeg; @25
module ct_f_spsram_2048x128(
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

input   [10 :0]  A_t0;           
input            CEN_t0;         
input   [127:0]  D_t0;           
input            GWEN_t0;        
output  [127:0]  Q_t0;           
input   [127:0]  WEN_t0;         
wire    [10 :0]  A_t0;           
wire             CEN_t0;         
wire    [127:0]  D_t0;           
wire             GWEN_t0;        
wire    [127:0]  Q_t0;           
wire    [127:0]  WEN_t0;         
assign Q_t0 = '0;

// &Ports; @26
input   [10 :0]  A;           
input            CEN;         
input            CLK;         
input   [127:0]  D;           
input            GWEN;        
input   [127:0]  WEN;         
output  [127:0]  Q;           

// &Regs; @27
reg     [10 :0]  addr_holding; 

// &Wires; @28
wire    [10 :0]  A;           
wire             CEN;         
wire             CLK;         
wire    [127:0]  D;           
wire             GWEN;        
wire    [127:0]  Q;           
wire    [127:0]  WEN;         
wire    [10 :0]  addr;        
wire    [127:0]  ram_din;     
wire    [127:0]  ram_dout;    
wire             ram_wen;     


parameter ADDR_WIDTH = 11;
parameter WRAP_SIZE  = 128;

//write enable
// &Force("nonport","ram_wen"); @34
// &Force("bus","WEN",127,0); @35
assign ram_wen = !CEN && !WEN[127] && !GWEN;
//din
// &Force("nonport","ram_din"); @38
// &Force("bus","D",WRAP_SIZE-1,0); @39
assign ram_din[WRAP_SIZE-1:0] = D[WRAP_SIZE-1:0];
//address
// &Force("nonport","addr"); @42
always@(posedge CLK)
begin
  if(!CEN) begin
    addr_holding[ADDR_WIDTH-1:0] <= A[ADDR_WIDTH-1:0];
  end
end

assign addr[ADDR_WIDTH-1:0] = CEN ? addr_holding[ADDR_WIDTH-1:0]
                                  : A[ADDR_WIDTH-1:0];
//dout
// &Force("nonport","ram_dout"); @53
assign Q[WRAP_SIZE-1:0]                = ram_dout[WRAP_SIZE-1:0];
my_fpga_ram #(WRAP_SIZE,ADDR_WIDTH) ram(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram_din),
  .PortAWriteEnable(ram_wen),
  .PortADataOut(ram_dout));

// &ModuleEnd; @62
endmodule


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
module ct_f_spsram_2048x144(
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

parameter ADDR_WIDTH = 11;
parameter DATA_WIDTH = 144;
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

// &Depend("my_fpga_ram.v"); @23

// &ModuleBeg; @25
module ct_f_spsram_2048x32(
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

input   [10:0]  A_t0;           
input           CEN_t0;         
input   [31:0]  D_t0;           
input           GWEN_t0;        
output  [31:0]  Q_t0;           
input   [31:0]  WEN_t0;         
wire    [10:0]  A_t0;           
wire            CEN_t0;         
wire    [31:0]  D_t0;           
wire            GWEN_t0;        
wire    [31:0]  Q_t0;           
wire    [31:0]  WEN_t0;         
assign Q_t0 = '0;

// &Ports; @26
input   [10:0]  A;           
input           CEN;         
input           CLK;         
input   [31:0]  D;           
input           GWEN;        
input   [31:0]  WEN;         
output  [31:0]  Q;           

// &Regs; @27
reg     [10:0]  addr_holding; 

// &Wires; @28
wire    [10:0]  A;           
wire            CEN;         
wire            CLK;         
wire    [31:0]  D;           
wire            GWEN;        
wire    [31:0]  Q;           
wire    [31:0]  WEN;         
wire    [10:0]  addr;        
wire    [7 :0]  ram0_din;    
wire    [7 :0]  ram0_dout;   
wire            ram0_wen;    
wire    [7 :0]  ram1_din;    
wire    [7 :0]  ram1_dout;   
wire            ram1_wen;    
wire    [7 :0]  ram2_din;    
wire    [7 :0]  ram2_dout;   
wire            ram2_wen;    
wire    [7 :0]  ram3_din;    
wire    [7 :0]  ram3_dout;   
wire            ram3_wen;    


parameter ADDR_WIDTH = 11;
parameter WRAP_SIZE  = 8;

//write enable
// &Force("nonport","ram0_wen"); @34
// &Force("nonport","ram1_wen"); @35
// &Force("nonport","ram2_wen"); @36
// &Force("nonport","ram3_wen"); @37
// &Force("bus","WEN",31,0); @38
assign ram0_wen = !CEN && !WEN[ 7] && !GWEN;
assign ram1_wen = !CEN && !WEN[15] && !GWEN;
assign ram2_wen = !CEN && !WEN[23] && !GWEN;
assign ram3_wen = !CEN && !WEN[31] && !GWEN;

//din
// &Force("nonport","ram0_din"); @45
// &Force("nonport","ram1_din"); @46
// &Force("nonport","ram2_din"); @47
// &Force("nonport","ram3_din"); @48
// &Force("bus","D",4*WRAP_SIZE-1,0); @49
assign ram0_din[WRAP_SIZE-1:0] = D[WRAP_SIZE-1:0];
assign ram1_din[WRAP_SIZE-1:0] = D[2*WRAP_SIZE-1:WRAP_SIZE];
assign ram2_din[WRAP_SIZE-1:0] = D[3*WRAP_SIZE-1:2*WRAP_SIZE];
assign ram3_din[WRAP_SIZE-1:0] = D[4*WRAP_SIZE-1:3*WRAP_SIZE];
//address
// &Force("nonport","addr"); @55
always@(posedge CLK)
begin
  if(!CEN) begin
    addr_holding[ADDR_WIDTH-1:0] <= A[ADDR_WIDTH-1:0];
  end
end

assign addr[ADDR_WIDTH-1:0] = CEN ? addr_holding[ADDR_WIDTH-1:0]
                                  : A[ADDR_WIDTH-1:0];
//dout
// &Force("nonport","ram0_dout"); @66
// &Force("nonport","ram1_dout"); @67
// &Force("nonport","ram2_dout"); @68
// &Force("nonport","ram3_dout"); @69

assign Q[WRAP_SIZE-1:0]             = ram0_dout[WRAP_SIZE-1:0];
assign Q[2*WRAP_SIZE-1:WRAP_SIZE]   = ram1_dout[WRAP_SIZE-1:0];
assign Q[3*WRAP_SIZE-1:2*WRAP_SIZE] = ram2_dout[WRAP_SIZE-1:0];
assign Q[4*WRAP_SIZE-1:3*WRAP_SIZE] = ram3_dout[WRAP_SIZE-1:0];


my_fpga_ram #(WRAP_SIZE,ADDR_WIDTH) ram0(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram0_din),
  .PortAWriteEnable(ram0_wen),
  .PortADataOut(ram0_dout));

my_fpga_ram #(WRAP_SIZE,ADDR_WIDTH) ram1(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram1_din),
  .PortAWriteEnable(ram1_wen),
  .PortADataOut(ram1_dout));

my_fpga_ram #(WRAP_SIZE,ADDR_WIDTH) ram2(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram2_din),
  .PortAWriteEnable(ram2_wen),
  .PortADataOut(ram2_dout));

my_fpga_ram #(WRAP_SIZE,ADDR_WIDTH) ram3(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram3_din),
  .PortAWriteEnable(ram3_wen),
  .PortADataOut(ram3_dout));

// &ModuleEnd; @105
endmodule





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

// &Depend("my_fpga_ram.v"); @23

// &ModuleBeg; @25
module ct_f_spsram_2048x59(
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

input   [10:0]  A_t0;           
input           CEN_t0;         
input   [58:0]  D_t0;           
input           GWEN_t0;        
output  [58:0]  Q_t0;           
input   [58:0]  WEN_t0;         
wire    [10:0]  A_t0;           
wire            CEN_t0;         
wire    [58:0]  D_t0;           
wire            GWEN_t0;        
wire    [58:0]  Q_t0;           
wire    [58:0]  WEN_t0;         
assign Q_t0 = '0;

// &Ports; @26
input   [10:0]  A;           
input           CEN;         
input           CLK;         
input   [58:0]  D;           
input           GWEN;        
input   [58:0]  WEN;         
output  [58:0]  Q;           

// &Regs; @27
reg     [10:0]  addr_holding; 

// &Wires; @28
wire    [10:0]  A;           
wire            CEN;         
wire            CLK;         
wire    [58:0]  D;           
wire            GWEN;        
wire    [58:0]  Q;           
wire    [58:0]  WEN;         
wire    [10:0]  addr;        
wire    [0 :0]  ram0_din;    
wire    [0 :0]  ram0_dout;   
wire            ram0_wen;    
wire    [28:0]  ram1_din;    
wire    [28:0]  ram1_dout;   
wire            ram1_wen;    
wire    [28:0]  ram2_din;    
wire    [28:0]  ram2_dout;   
wire            ram2_wen;    


parameter ADDR_WIDTH   = 11;
parameter WRAP_SIZE_1  = 1;
parameter WRAP_SIZE_2  = 29;

//write enable
// &Force("nonport","ram0_wen"); @35
// &Force("nonport","ram1_wen"); @36
// &Force("nonport","ram2_wen"); @37
// &Force("bus","WEN",58,0); @38
assign ram0_wen = !CEN && !WEN[58] && !GWEN;
assign ram1_wen = !CEN && !WEN[57] && !GWEN;
assign ram2_wen = !CEN && !WEN[28] && !GWEN;

//din
// &Force("nonport","ram0_din"); @44
// &Force("nonport","ram1_din"); @45
// &Force("nonport","ram2_din"); @46
// &Force("bus","D",WRAP_SIZE_1+2*WRAP_SIZE_2-1,0); @47
assign ram0_din[WRAP_SIZE_1-1:0] = D[2*WRAP_SIZE_2:2*WRAP_SIZE_2];
assign ram1_din[WRAP_SIZE_2-1:0] = D[2*WRAP_SIZE_2-1:WRAP_SIZE_2];
assign ram2_din[WRAP_SIZE_2-1:0] = D[WRAP_SIZE_2-1:0];
//address
// &Force("nonport","addr"); @52
always@(posedge CLK)
begin
  if(!CEN) begin
    addr_holding[ADDR_WIDTH-1:0] <= A[ADDR_WIDTH-1:0];
  end
end

assign addr[ADDR_WIDTH-1:0] = CEN ? addr_holding[ADDR_WIDTH-1:0]
                                  : A[ADDR_WIDTH-1:0];
//dout
// &Force("nonport","ram0_dout"); @63
// &Force("nonport","ram1_dout"); @64
// &Force("nonport","ram2_dout"); @65

assign Q[2*WRAP_SIZE_2:2*WRAP_SIZE_2] = ram0_dout[WRAP_SIZE_1-1:0];
assign Q[2*WRAP_SIZE_2-1:WRAP_SIZE_2] = ram1_dout[WRAP_SIZE_2-1:0];
assign Q[WRAP_SIZE_2-1:0]             = ram2_dout[WRAP_SIZE_2-1:0];


my_fpga_ram #(WRAP_SIZE_1,ADDR_WIDTH) ram0(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram0_din),
  .PortAWriteEnable(ram0_wen),
  .PortADataOut(ram0_dout));

my_fpga_ram #(WRAP_SIZE_2,ADDR_WIDTH) ram1(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram1_din),
  .PortAWriteEnable(ram1_wen),
  .PortADataOut(ram1_dout));

my_fpga_ram #(WRAP_SIZE_2,ADDR_WIDTH) ram2(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram2_din),
  .PortAWriteEnable(ram2_wen),
  .PortADataOut(ram2_dout));

// &ModuleEnd; @93
endmodule





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
module ct_f_spsram_2048x88(
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

parameter ADDR_WIDTH = 11;
parameter DATA_WIDTH = 88;
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

// &ModuleBeg; @3
module ct_f_spsram_256x100(
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

input   [7 :0]  A_t0;           
input           CEN_t0;         
input   [99:0]  D_t0;           
input           GWEN_t0;        
output  [99:0]  Q_t0;           
input   [99:0]  WEN_t0;         
wire    [7 :0]  A_t0;           
wire            CEN_t0;         
wire    [99:0]  D_t0;           
wire            GWEN_t0;        
wire    [99:0]  Q_t0;           
wire    [99:0]  WEN_t0;         
assign Q_t0 = '0;

// &Ports; @4
input   [7 :0]  A;           
input           CEN;         
input           CLK;         
input   [99:0]  D;           
input           GWEN;        
input   [99:0]  WEN;         
output  [99:0]  Q;           

// &Regs; @5
reg     [7 :0]  addr_holding; 

// &Wires; @6
wire    [7 :0]  A;           
wire            CEN;         
wire            CLK;         
wire    [99:0]  D;           
wire            GWEN;        
wire    [99:0]  Q;           
wire    [99:0]  WEN;         
wire    [7 :0]  addr;        
wire    [24:0]  ram_din0;    
wire    [24:0]  ram_din1;    
wire    [24:0]  ram_din2;    
wire    [24:0]  ram_din3;    
wire    [24:0]  ram_dout0;   
wire    [24:0]  ram_dout1;   
wire    [24:0]  ram_dout2;   
wire    [24:0]  ram_dout3;   
wire            ram_wen0;    
wire            ram_wen1;    
wire            ram_wen2;    
wire            ram_wen3;    

// &Force("bus","Q",99,0); @7

parameter ADDR_WIDTH = 8;
parameter WRAP_SIZE  = 25;

//write enable
// &Force("nonport","ram_wen0"); @13
// &Force("nonport","ram_wen1"); @14
// &Force("nonport","ram_wen2"); @15
// &Force("nonport","ram_wen3"); @16

// &Force("bus","WEN",99,0); @18
assign ram_wen0 = !CEN && !WEN[24] && !GWEN;
assign ram_wen1 = !CEN && !WEN[49] && !GWEN;
assign ram_wen2 = !CEN && !WEN[74] && !GWEN;
assign ram_wen3 = !CEN && !WEN[99] && !GWEN;

//din
// &Force("nonport","ram_din0"); @25
// &Force("nonport","ram_din1"); @26
// &Force("nonport","ram_din2"); @27
// &Force("nonport","ram_din3"); @28
// &Force("bus","D",4*WRAP_SIZE-1,0); @29
assign ram_din0[WRAP_SIZE-1:0] = D[WRAP_SIZE-1:0];
assign ram_din1[WRAP_SIZE-1:0] = D[2*WRAP_SIZE-1:WRAP_SIZE];
assign ram_din2[WRAP_SIZE-1:0] = D[3*WRAP_SIZE-1:2*WRAP_SIZE];
assign ram_din3[WRAP_SIZE-1:0] = D[4*WRAP_SIZE-1:3*WRAP_SIZE];
//address
// &Force("nonport","addr"); @35
always@(posedge CLK)
begin
  if(!CEN) begin
    addr_holding[ADDR_WIDTH-1:0] <= A[ADDR_WIDTH-1:0];
  end
end

assign addr[ADDR_WIDTH-1:0] = CEN ? addr_holding[ADDR_WIDTH-1:0]
                                  : A[ADDR_WIDTH-1:0];

//dout
// &Force("nonport","ram_dout0"); @47
// &Force("nonport","ram_dout1"); @48
// &Force("nonport","ram_dout2"); @49
// &Force("nonport","ram_dout3"); @50
assign Q[WRAP_SIZE-1:0]                = ram_dout0[WRAP_SIZE-1:0];
assign Q[2*WRAP_SIZE-1:WRAP_SIZE]      = ram_dout1[WRAP_SIZE-1:0];
assign Q[3*WRAP_SIZE-1:2*WRAP_SIZE]    = ram_dout2[WRAP_SIZE-1:0];
assign Q[4*WRAP_SIZE-1:3*WRAP_SIZE]    = ram_dout3[WRAP_SIZE-1:0];

my_fpga_ram #(WRAP_SIZE,ADDR_WIDTH) ram0(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram_din0),
  .PortAWriteEnable(ram_wen0),
  .PortADataOut(ram_dout0));

my_fpga_ram #(WRAP_SIZE,ADDR_WIDTH) ram1(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram_din1),
  .PortAWriteEnable(ram_wen1),
  .PortADataOut(ram_dout1));

my_fpga_ram #(WRAP_SIZE,ADDR_WIDTH) ram2(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram_din2),
  .PortAWriteEnable(ram_wen2),
  .PortADataOut(ram_dout2));

my_fpga_ram #(WRAP_SIZE,ADDR_WIDTH) ram3(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram_din3),
  .PortAWriteEnable(ram_wen3),
  .PortADataOut(ram_dout3));

// &ModuleEnd; @84
endmodule



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
module ct_f_spsram_256x144(
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

parameter ADDR_WIDTH = 8;
parameter DATA_WIDTH = 144;
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
    my_fpga_ram #(WRAP_SIZE,ADDR_WIDTH) ram_instance(
      .PortAClk (CLK),
      .PortAAddr(addr),
      .PortADataIn (D[i]),
      .PortAWriteEnable(ram_wen_vec[i]),
      .PortADataOut(Q[i]));
  end
endgenerate

endmodule

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

// &ModuleBeg; @24
module ct_f_spsram_256x196(
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

input   [7  :0]  A_t0;           
input            CEN_t0;         
input   [195:0]  D_t0;           
input            GWEN_t0;        
output  [195:0]  Q_t0;           
input   [195:0]  WEN_t0;         
wire    [7  :0]  A_t0;           
wire             CEN_t0;         
wire    [195:0]  D_t0;           
wire             GWEN_t0;        
wire    [195:0]  Q_t0;           
wire    [195:0]  WEN_t0;         
assign Q_t0 = '0;

// &Ports; @25
input   [7  :0]  A;           
input            CEN;         
input            CLK;         
input   [195:0]  D;           
input            GWEN;        
input   [195:0]  WEN;         
output  [195:0]  Q;           

// &Regs; @26
reg     [7  :0]  addr_holding; 

// &Wires; @27
wire    [7  :0]  A;           
wire             CEN;         
wire             CLK;         
wire    [195:0]  D;           
wire             GWEN;        
wire    [195:0]  Q;           
wire    [195:0]  WEN;         
wire    [7  :0]  addr;        
wire    [3  :0]  ram0_din;    
wire    [3  :0]  ram0_dout;   
wire             ram0_wen;    
wire    [47 :0]  ram1_din;    
wire    [47 :0]  ram1_dout;   
wire             ram1_wen;    
wire    [47 :0]  ram2_din;    
wire    [47 :0]  ram2_dout;   
wire             ram2_wen;    
wire    [47 :0]  ram3_din;    
wire    [47 :0]  ram3_dout;   
wire             ram3_wen;    
wire    [47 :0]  ram4_din;    
wire    [47 :0]  ram4_dout;   
wire             ram4_wen;    


parameter ADDR_WIDTH   = 8;
parameter WRAP_SIZE_1  = 4;
parameter WRAP_SIZE_2  = 48;

//write enable
// &Force("nonport","ram0_wen"); @34
// &Force("nonport","ram1_wen"); @35
// &Force("nonport","ram2_wen"); @36
// &Force("nonport","ram3_wen"); @37
// &Force("nonport","ram4_wen"); @38
// &Force("bus","WEN",195,0); @39
assign ram0_wen = !CEN && !WEN[195] && !GWEN;
assign ram1_wen = !CEN && !WEN[191] && !GWEN;
assign ram2_wen = !CEN && !WEN[143] && !GWEN;
assign ram3_wen = !CEN && !WEN[ 95] && !GWEN;
assign ram4_wen = !CEN && !WEN[ 47] && !GWEN;

//din
// &Force("nonport","ram0_din"); @47
// &Force("nonport","ram1_din"); @48
// &Force("nonport","ram2_din"); @49
// &Force("nonport","ram3_din"); @50
// &Force("nonport","ram4_din"); @51
// &Force("bus","D",WRAP_SIZE_1+4*WRAP_SIZE_2-1,0); @52
assign ram0_din[WRAP_SIZE_1-1:0] = D[WRAP_SIZE_1+4*WRAP_SIZE_2-1:4*WRAP_SIZE_2];
assign ram1_din[WRAP_SIZE_2-1:0] = D[4*WRAP_SIZE_2-1:3*WRAP_SIZE_2];
assign ram2_din[WRAP_SIZE_2-1:0] = D[3*WRAP_SIZE_2-1:2*WRAP_SIZE_2];
assign ram3_din[WRAP_SIZE_2-1:0] = D[2*WRAP_SIZE_2-1:1*WRAP_SIZE_2];
assign ram4_din[WRAP_SIZE_2-1:0] = D[1*WRAP_SIZE_2-1:0*WRAP_SIZE_2];
//address
// &Force("nonport","addr"); @59
always@(posedge CLK)
begin
  if(!CEN) begin
    addr_holding[ADDR_WIDTH-1:0] <= A[ADDR_WIDTH-1:0];
  end
end

assign addr[ADDR_WIDTH-1:0] = CEN ? addr_holding[ADDR_WIDTH-1:0]
                                  : A[ADDR_WIDTH-1:0];
//dout
// &Force("nonport","ram0_dout"); @70
// &Force("nonport","ram1_dout"); @71
// &Force("nonport","ram2_dout"); @72
// &Force("nonport","ram3_dout"); @73
// &Force("nonport","ram4_dout"); @74

assign Q[WRAP_SIZE_1+4*WRAP_SIZE_2-1:4*WRAP_SIZE_2] = ram0_dout[WRAP_SIZE_1-1:0];
assign Q[4*WRAP_SIZE_2-1:3*WRAP_SIZE_2]             = ram1_dout[WRAP_SIZE_2-1:0];
assign Q[3*WRAP_SIZE_2-1:2*WRAP_SIZE_2]             = ram2_dout[WRAP_SIZE_2-1:0];
assign Q[2*WRAP_SIZE_2-1:1*WRAP_SIZE_2]             = ram3_dout[WRAP_SIZE_2-1:0];
assign Q[1*WRAP_SIZE_2-1:0*WRAP_SIZE_2]             = ram4_dout[WRAP_SIZE_2-1:0];


my_fpga_ram #(WRAP_SIZE_1,ADDR_WIDTH) ram0(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram0_din),
  .PortAWriteEnable(ram0_wen),
  .PortADataOut(ram0_dout));

my_fpga_ram #(WRAP_SIZE_2,ADDR_WIDTH) ram1(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram1_din),
  .PortAWriteEnable(ram1_wen),
  .PortADataOut(ram1_dout));

my_fpga_ram #(WRAP_SIZE_2,ADDR_WIDTH) ram2(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram2_din),
  .PortAWriteEnable(ram2_wen),
  .PortADataOut(ram2_dout));

my_fpga_ram #(WRAP_SIZE_2,ADDR_WIDTH) ram3(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram3_din),
  .PortAWriteEnable(ram3_wen),
  .PortADataOut(ram3_dout));

my_fpga_ram #(WRAP_SIZE_2,ADDR_WIDTH) ram4(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram4_din),
  .PortAWriteEnable(ram4_wen),
  .PortADataOut(ram4_dout));

// &ModuleEnd; @118
endmodule


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

// &Depend("my_fpga_ram.v"); @23

// &ModuleBeg; @25
module ct_f_spsram_256x23(
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

input   [7 :0]  A_t0;           
input           CEN_t0;         
input   [22:0]  D_t0;           
input           GWEN_t0;        
output  [22:0]  Q_t0;           
input   [22:0]  WEN_t0;         
wire    [7 :0]  A_t0;           
wire            CEN_t0;         
wire    [22:0]  D_t0;           
wire            GWEN_t0;        
wire    [22:0]  Q_t0;           
wire    [22:0]  WEN_t0;         
assign Q_t0 = '0;

// &Ports; @26
input   [7 :0]  A;           
input           CEN;         
input           CLK;         
input   [22:0]  D;           
input           GWEN;        
input   [22:0]  WEN;         
output  [22:0]  Q;           

// &Regs; @27
reg     [7 :0]  addr_holding; 

// &Wires; @28
wire    [7 :0]  A;           
wire            CEN;         
wire            CLK;         
wire    [22:0]  D;           
wire            GWEN;        
wire    [22:0]  Q;           
wire    [22:0]  WEN;         
wire    [7 :0]  addr;        
wire    [22:0]  ram0_din;    
wire    [22:0]  ram0_dout;   
wire            ram0_wen;    


parameter ADDR_WIDTH = 8;
parameter WRAP_SIZE  = 23;

//write enable
// &Force("nonport","ram0_wen"); @34
// &Force("bus","WEN",22,0); @35
assign ram0_wen = !CEN && !WEN[0] && !GWEN;

//din
// &Force("nonport","ram0_din"); @39
// &Force("bus","D",WRAP_SIZE-1,0); @40
assign ram0_din[WRAP_SIZE-1:0] = D[WRAP_SIZE-1:0];
//address
// &Force("nonport","addr"); @43
always@(posedge CLK)
begin
  if(!CEN) begin
    addr_holding[ADDR_WIDTH-1:0] <= A[ADDR_WIDTH-1:0];
  end
end

assign addr[ADDR_WIDTH-1:0] = CEN ? addr_holding[ADDR_WIDTH-1:0]
                                  : A[ADDR_WIDTH-1:0];
//dout
// &Force("nonport","ram0_dout"); @54

assign Q[WRAP_SIZE-1:0]             = ram0_dout[WRAP_SIZE-1:0];


my_fpga_ram #(WRAP_SIZE,ADDR_WIDTH) ram0(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram0_din),
  .PortAWriteEnable(ram0_wen),
  .PortADataOut(ram0_dout));

// &ModuleEnd; @66
endmodule





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

// &Depend("my_fpga_ram.v"); @23

// &ModuleBeg; @25
module ct_f_spsram_256x52(
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

input   [7 :0]  A_t0;           
input           CEN_t0;         
input   [51:0]  D_t0;           
input           GWEN_t0;        
output  [51:0]  Q_t0;           
input   [51:0]  WEN_t0;         
wire    [7 :0]  A_t0;           
wire            CEN_t0;         
wire    [51:0]  D_t0;           
wire            GWEN_t0;        
wire    [51:0]  Q_t0;           
wire    [51:0]  WEN_t0;         
assign Q_t0 = '0;

// &Ports; @26
input   [7 :0]  A;           
input           CEN;         
input           CLK;         
input   [51:0]  D;           
input           GWEN;        
input   [51:0]  WEN;         
output  [51:0]  Q;           

// &Regs; @27
reg     [7 :0]  addr_holding; 

// &Wires; @28
wire    [7 :0]  A;           
wire            CEN;         
wire            CLK;         
wire    [51:0]  D;           
wire            GWEN;        
wire    [51:0]  Q;           
wire    [51:0]  WEN;         
wire    [7 :0]  addr;        
wire    [25:0]  ram0_din;    
wire    [25:0]  ram0_dout;   
wire            ram0_wen;    
wire    [25:0]  ram1_din;    
wire    [25:0]  ram1_dout;   
wire            ram1_wen;    


parameter ADDR_WIDTH = 8;
parameter WRAP_SIZE  = 26;

//write enable
// &Force("nonport","ram0_wen"); @34
// &Force("nonport","ram1_wen"); @35
// &Force("bus","WEN",51,0); @36
assign ram0_wen = !CEN && !WEN[25] && !GWEN;
assign ram1_wen = !CEN && !WEN[51] && !GWEN;

//din
// &Force("nonport","ram0_din"); @41
// &Force("nonport","ram1_din"); @42
// &Force("bus","D",2*WRAP_SIZE-1,0); @43
assign ram0_din[WRAP_SIZE-1:0] = D[WRAP_SIZE-1:0];
assign ram1_din[WRAP_SIZE-1:0] = D[2*WRAP_SIZE-1:WRAP_SIZE];
//address
// &Force("nonport","addr"); @47
always@(posedge CLK)
begin
  if(!CEN) begin
    addr_holding[ADDR_WIDTH-1:0] <= A[ADDR_WIDTH-1:0];
  end
end

assign addr[ADDR_WIDTH-1:0] = CEN ? addr_holding[ADDR_WIDTH-1:0]
                                  : A[ADDR_WIDTH-1:0];
//dout
// &Force("nonport","ram0_dout"); @58
// &Force("nonport","ram1_dout"); @59

assign Q[WRAP_SIZE-1:0]             = ram0_dout[WRAP_SIZE-1:0];
assign Q[2*WRAP_SIZE-1:WRAP_SIZE]   = ram1_dout[WRAP_SIZE-1:0];


my_fpga_ram #(WRAP_SIZE,ADDR_WIDTH) ram0(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram0_din),
  .PortAWriteEnable(ram0_wen),
  .PortADataOut(ram0_dout));

my_fpga_ram #(WRAP_SIZE,ADDR_WIDTH) ram1(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram1_din),
  .PortAWriteEnable(ram1_wen),
  .PortADataOut(ram1_dout));

// &ModuleEnd; @79
endmodule





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

// &Depend("my_fpga_ram.v"); @23

// &ModuleBeg; @25
module ct_f_spsram_256x54(
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

input   [7 :0]  A_t0;           
input           CEN_t0;         
input   [53:0]  D_t0;           
input           GWEN_t0;        
output  [53:0]  Q_t0;           
input   [53:0]  WEN_t0;         
wire    [7 :0]  A_t0;           
wire            CEN_t0;         
wire    [53:0]  D_t0;           
wire            GWEN_t0;        
wire    [53:0]  Q_t0;           
wire    [53:0]  WEN_t0;         
assign Q_t0 = '0;

// &Ports; @26
input   [7 :0]  A;           
input           CEN;         
input           CLK;         
input   [53:0]  D;           
input           GWEN;        
input   [53:0]  WEN;         
output  [53:0]  Q;           

// &Regs; @27
reg     [7 :0]  addr_holding; 

// &Wires; @28
wire    [7 :0]  A;           
wire            CEN;         
wire            CLK;         
wire    [53:0]  D;           
wire            GWEN;        
wire    [53:0]  Q;           
wire    [53:0]  WEN;         
wire    [7 :0]  addr;        
wire    [26:0]  ram0_din;    
wire    [26:0]  ram0_dout;   
wire            ram0_wen;    
wire    [26:0]  ram1_din;    
wire    [26:0]  ram1_dout;   
wire            ram1_wen;    


parameter ADDR_WIDTH = 8;
parameter WRAP_SIZE  = 27;

//write enable
// &Force("nonport","ram0_wen"); @34
// &Force("nonport","ram1_wen"); @35
// &Force("bus","WEN",53,0); @36
assign ram0_wen = !CEN && !WEN[26] && !GWEN;
assign ram1_wen = !CEN && !WEN[53] && !GWEN;

//din
// &Force("nonport","ram0_din"); @41
// &Force("nonport","ram1_din"); @42
// &Force("bus","D",2*WRAP_SIZE-1,0); @43
assign ram0_din[WRAP_SIZE-1:0] = D[WRAP_SIZE-1:0];
assign ram1_din[WRAP_SIZE-1:0] = D[2*WRAP_SIZE-1:WRAP_SIZE];
//address
// &Force("nonport","addr"); @47
always@(posedge CLK)
begin
  if(!CEN) begin
    addr_holding[ADDR_WIDTH-1:0] <= A[ADDR_WIDTH-1:0];
  end
end

assign addr[ADDR_WIDTH-1:0] = CEN ? addr_holding[ADDR_WIDTH-1:0]
                                  : A[ADDR_WIDTH-1:0];
//dout
// &Force("nonport","ram0_dout"); @58
// &Force("nonport","ram1_dout"); @59

assign Q[WRAP_SIZE-1:0]             = ram0_dout[WRAP_SIZE-1:0];
assign Q[2*WRAP_SIZE-1:WRAP_SIZE]   = ram1_dout[WRAP_SIZE-1:0];


my_fpga_ram #(WRAP_SIZE,ADDR_WIDTH) ram0(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram0_din),
  .PortAWriteEnable(ram0_wen),
  .PortADataOut(ram0_dout));

my_fpga_ram #(WRAP_SIZE,ADDR_WIDTH) ram1(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram1_din),
  .PortAWriteEnable(ram1_wen),
  .PortADataOut(ram1_dout));

// &ModuleEnd; @79
endmodule





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

// &Depend("my_fpga_ram.v"); @23

// &ModuleBeg; @25
module ct_f_spsram_256x59(
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

input   [7 :0]  A_t0;           
input           CEN_t0;         
input   [58:0]  D_t0;           
input           GWEN_t0;        
output  [58:0]  Q_t0;           
input   [58:0]  WEN_t0;         
wire    [7 :0]  A_t0;           
wire            CEN_t0;         
wire    [58:0]  D_t0;           
wire            GWEN_t0;        
wire    [58:0]  Q_t0;           
wire    [58:0]  WEN_t0;         
assign Q_t0 = '0;

// &Ports; @26
input   [7 :0]  A;           
input           CEN;         
input           CLK;         
input   [58:0]  D;           
input           GWEN;        
input   [58:0]  WEN;         
output  [58:0]  Q;           

// &Regs; @27
reg     [7 :0]  addr_holding; 

// &Wires; @28
wire    [7 :0]  A;           
wire            CEN;         
wire            CLK;         
wire    [58:0]  D;           
wire            GWEN;        
wire    [58:0]  Q;           
wire    [58:0]  WEN;         
wire    [7 :0]  addr;        
wire    [0 :0]  ram0_din;    
wire    [0 :0]  ram0_dout;   
wire            ram0_wen;    
wire    [28:0]  ram1_din;    
wire    [28:0]  ram1_dout;   
wire            ram1_wen;    
wire    [28:0]  ram2_din;    
wire    [28:0]  ram2_dout;   
wire            ram2_wen;    


parameter ADDR_WIDTH   = 8;
parameter WRAP_SIZE_1  = 1;
parameter WRAP_SIZE_2  = 29;

//write enable
// &Force("nonport","ram0_wen"); @35
// &Force("nonport","ram1_wen"); @36
// &Force("nonport","ram2_wen"); @37
// &Force("bus","WEN",58,0); @38
assign ram0_wen = !CEN && !WEN[58] && !GWEN;
assign ram1_wen = !CEN && !WEN[57] && !GWEN;
assign ram2_wen = !CEN && !WEN[28] && !GWEN;

//din
// &Force("nonport","ram0_din"); @44
// &Force("nonport","ram1_din"); @45
// &Force("nonport","ram2_din"); @46
// &Force("bus","D",WRAP_SIZE_1+2*WRAP_SIZE_2-1,0); @47
assign ram0_din[WRAP_SIZE_1-1:0] = D[2*WRAP_SIZE_2:2*WRAP_SIZE_2];
assign ram1_din[WRAP_SIZE_2-1:0] = D[2*WRAP_SIZE_2-1:WRAP_SIZE_2];
assign ram2_din[WRAP_SIZE_2-1:0] = D[WRAP_SIZE_2-1:0];
//address
// &Force("nonport","addr"); @52
always@(posedge CLK)
begin
  if(!CEN) begin
    addr_holding[ADDR_WIDTH-1:0] <= A[ADDR_WIDTH-1:0];
  end
end

assign addr[ADDR_WIDTH-1:0] = CEN ? addr_holding[ADDR_WIDTH-1:0]
                                  : A[ADDR_WIDTH-1:0];
//dout
// &Force("nonport","ram0_dout"); @63
// &Force("nonport","ram1_dout"); @64
// &Force("nonport","ram2_dout"); @65

assign Q[2*WRAP_SIZE_2:2*WRAP_SIZE_2] = ram0_dout[WRAP_SIZE_1-1:0];
assign Q[2*WRAP_SIZE_2-1:WRAP_SIZE_2] = ram1_dout[WRAP_SIZE_2-1:0];
assign Q[WRAP_SIZE_2-1:0]             = ram2_dout[WRAP_SIZE_2-1:0];


my_fpga_ram #(WRAP_SIZE_1,ADDR_WIDTH) ram0(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram0_din),
  .PortAWriteEnable(ram0_wen),
  .PortADataOut(ram0_dout));

my_fpga_ram #(WRAP_SIZE_2,ADDR_WIDTH) ram1(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram1_din),
  .PortAWriteEnable(ram1_wen),
  .PortADataOut(ram1_dout));

my_fpga_ram #(WRAP_SIZE_2,ADDR_WIDTH) ram2(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram2_din),
  .PortAWriteEnable(ram2_wen),
  .PortADataOut(ram2_dout));

// &ModuleEnd; @93
endmodule





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

// &Depend("my_fpga_ram.v"); @23

// &ModuleBeg; @25
module ct_f_spsram_256x7(
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

input   [7:0]  A_t0;           
input          CEN_t0;         
input   [6:0]  D_t0;           
input          GWEN_t0;        
output  [6:0]  Q_t0;           
input   [6:0]  WEN_t0;         
wire    [7:0]  A_t0;           
wire           CEN_t0;         
wire    [6:0]  D_t0;           
wire           GWEN_t0;        
wire    [6:0]  Q_t0;           
wire    [6:0]  WEN_t0;         
assign Q_t0 = '0;

// &Ports; @26
input   [7:0]  A;           
input          CEN;         
input          CLK;         
input   [6:0]  D;           
input          GWEN;        
input   [6:0]  WEN;         
output  [6:0]  Q;           

// &Regs; @27
reg     [7:0]  addr_holding; 

// &Wires; @28
wire    [7:0]  A;           
wire           CEN;         
wire           CLK;         
wire    [6:0]  D;           
wire           GWEN;        
wire    [6:0]  Q;           
wire    [6:0]  WEN;         
wire    [7:0]  addr;        
wire           ram0_din;    
wire           ram0_dout;   
wire           ram0_wen;    
wire           ram1_din;    
wire           ram1_dout;   
wire           ram1_wen;    
wire           ram2_din;    
wire           ram2_dout;   
wire           ram2_wen;    
wire           ram3_din;    
wire           ram3_dout;   
wire           ram3_wen;    
wire           ram4_din;    
wire           ram4_dout;   
wire           ram4_wen;    
wire           ram5_din;    
wire           ram5_dout;   
wire           ram5_wen;    
wire           ram6_din;    
wire           ram6_dout;   
wire           ram6_wen;    


parameter ADDR_WIDTH = 8;

//write enable
// &Force("nonport","ram0_wen"); @33
// &Force("nonport","ram1_wen"); @34
// &Force("nonport","ram2_wen"); @35
// &Force("nonport","ram3_wen"); @36
// &Force("nonport","ram4_wen"); @37
// &Force("nonport","ram5_wen"); @38
// &Force("nonport","ram6_wen"); @39
// &Force("bus","WEN",6,0); @40
assign ram0_wen = !CEN && !WEN[0] && !GWEN;
assign ram1_wen = !CEN && !WEN[1] && !GWEN;
assign ram2_wen = !CEN && !WEN[2] && !GWEN;
assign ram3_wen = !CEN && !WEN[3] && !GWEN;
assign ram4_wen = !CEN && !WEN[4] && !GWEN;
assign ram5_wen = !CEN && !WEN[5] && !GWEN;
assign ram6_wen = !CEN && !WEN[6] && !GWEN;

//din
// &Force("nonport","ram0_din"); @50
// &Force("nonport","ram1_din"); @51
// &Force("nonport","ram2_din"); @52
// &Force("nonport","ram3_din"); @53
// &Force("nonport","ram4_din"); @54
// &Force("nonport","ram5_din"); @55
// &Force("nonport","ram6_din"); @56
// &Force("bus","D",6,0); @57
assign ram0_din = D[0];
assign ram1_din = D[1];
assign ram2_din = D[2];
assign ram3_din = D[3];
assign ram4_din = D[4];
assign ram5_din = D[5];
assign ram6_din = D[6];

//address
// &Force("nonport","addr"); @67
always@(posedge CLK)
begin
  if(!CEN) begin
    addr_holding[ADDR_WIDTH-1:0] <= A[ADDR_WIDTH-1:0];
  end
end

assign addr[ADDR_WIDTH-1:0] = CEN ? addr_holding[ADDR_WIDTH-1:0]
                                  : A[ADDR_WIDTH-1:0];

//dout
// &Force("nonport","ram0_dout"); @79
// &Force("nonport","ram1_dout"); @80
// &Force("nonport","ram2_dout"); @81
// &Force("nonport","ram3_dout"); @82
// &Force("nonport","ram4_dout"); @83
// &Force("nonport","ram5_dout"); @84
// &Force("nonport","ram6_dout"); @85
assign Q[0] = ram0_dout;
assign Q[1] = ram1_dout;
assign Q[2] = ram2_dout;
assign Q[3] = ram3_dout;
assign Q[4] = ram4_dout;
assign Q[5] = ram5_dout;
assign Q[6] = ram6_dout;

my_fpga_ram #(1,ADDR_WIDTH) ram0(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram0_din),
  .PortAWriteEnable(ram0_wen),
  .PortADataOut(ram0_dout));

my_fpga_ram #(1,ADDR_WIDTH) ram1(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram1_din),
  .PortAWriteEnable(ram1_wen),
  .PortADataOut(ram1_dout));

my_fpga_ram #(1,ADDR_WIDTH) ram2(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram2_din),
  .PortAWriteEnable(ram2_wen),
  .PortADataOut(ram2_dout));

my_fpga_ram #(1,ADDR_WIDTH) ram3(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram3_din),
  .PortAWriteEnable(ram3_wen),
  .PortADataOut(ram3_dout));

my_fpga_ram #(1,ADDR_WIDTH) ram4(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram4_din),
  .PortAWriteEnable(ram4_wen),
  .PortADataOut(ram4_dout));

my_fpga_ram #(1,ADDR_WIDTH) ram5(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram5_din),
  .PortAWriteEnable(ram5_wen),
  .PortADataOut(ram5_dout));

my_fpga_ram #(1,ADDR_WIDTH) ram6(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram6_din),
  .PortAWriteEnable(ram6_wen),
  .PortADataOut(ram6_dout));

// &ModuleEnd; @143
endmodule




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

// &ModuleBeg; @24
module ct_f_spsram_256x84(
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

input   [7 :0]  A_t0;           
input           CEN_t0;         
input   [83:0]  D_t0;           
input           GWEN_t0;        
output  [83:0]  Q_t0;           
input   [83:0]  WEN_t0;         
wire    [7 :0]  A_t0;           
wire            CEN_t0;         
wire    [83:0]  D_t0;           
wire            GWEN_t0;        
wire    [83:0]  Q_t0;           
wire    [83:0]  WEN_t0;         
assign Q_t0 = '0;

// &Ports; @25
input   [7 :0]  A;           
input           CEN;         
input           CLK;         
input   [83:0]  D;           
input           GWEN;        
input   [83:0]  WEN;         
output  [83:0]  Q;           

// &Regs; @26
reg     [7 :0]  addr_holding; 

// &Wires; @27
wire    [7 :0]  A;           
wire            CEN;         
wire            CLK;         
wire    [83:0]  D;           
wire            GWEN;        
wire    [83:0]  Q;           
wire    [83:0]  WEN;         
wire    [7 :0]  addr;        
wire    [41:0]  ram0_din;    
wire    [41:0]  ram0_dout;   
wire            ram0_wen;    
wire    [41:0]  ram1_din;    
wire    [41:0]  ram1_dout;   
wire            ram1_wen;    


parameter ADDR_WIDTH = 8;
parameter WRAP_SIZE  = 42;

//write enable
// &Force("nonport","ram0_wen"); @33
// &Force("nonport","ram1_wen"); @34
// &Force("bus","WEN",83,0); @35
assign ram0_wen = !CEN && !WEN[41] && !GWEN;
assign ram1_wen = !CEN && !WEN[83] && !GWEN;

//din
// &Force("nonport","ram0_din"); @40
// &Force("nonport","ram1_din"); @41
// &Force("bus","D",2*WRAP_SIZE-1,0); @42
assign ram0_din[WRAP_SIZE-1:0] = D[WRAP_SIZE-1:0];
assign ram1_din[WRAP_SIZE-1:0] = D[2*WRAP_SIZE-1:WRAP_SIZE];
//address
// &Force("nonport","addr"); @46
always@(posedge CLK)
begin
  if(!CEN) begin
    addr_holding[ADDR_WIDTH-1:0] <= A[ADDR_WIDTH-1:0];
  end
end

assign addr[ADDR_WIDTH-1:0] = CEN ? addr_holding[ADDR_WIDTH-1:0]
                                  : A[ADDR_WIDTH-1:0];
//dout
// &Force("nonport","ram0_dout"); @57
// &Force("nonport","ram1_dout"); @58

assign Q[WRAP_SIZE-1:0]             = ram0_dout[WRAP_SIZE-1:0];
assign Q[2*WRAP_SIZE-1:WRAP_SIZE]   = ram1_dout[WRAP_SIZE-1:0];


my_fpga_ram #(WRAP_SIZE,ADDR_WIDTH) ram0(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram0_din),
  .PortAWriteEnable(ram0_wen),
  .PortADataOut(ram0_dout));

my_fpga_ram #(WRAP_SIZE,ADDR_WIDTH) ram1(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram1_din),
  .PortAWriteEnable(ram1_wen),
  .PortADataOut(ram1_dout));

// &ModuleEnd; @78
endmodule


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
module ct_f_spsram_32768x128(
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

parameter ADDR_WIDTH = 15;
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

// &Depend("my_fpga_ram.v"); @23

// &ModuleBeg; @25
module ct_f_spsram_4096x128(
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

input   [11 :0]  A_t0;           
input            CEN_t0;         
input   [127:0]  D_t0;           
input            GWEN_t0;        
output  [127:0]  Q_t0;           
input   [127:0]  WEN_t0;         
wire    [11 :0]  A_t0;           
wire             CEN_t0;         
wire    [127:0]  D_t0;           
wire             GWEN_t0;        
wire    [127:0]  Q_t0;           
wire    [127:0]  WEN_t0;         
assign Q_t0 = '0;

// &Ports; @26
input   [11 :0]  A;           
input            CEN;         
input            CLK;         
input   [127:0]  D;           
input            GWEN;        
input   [127:0]  WEN;         
output  [127:0]  Q;           

// &Regs; @27
reg     [11 :0]  addr_holding; 

// &Wires; @28
wire    [11 :0]  A;           
wire             CEN;         
wire             CLK;         
wire    [127:0]  D;           
wire             GWEN;        
wire    [127:0]  Q;           
wire    [127:0]  WEN;         
wire    [11 :0]  addr;        
wire    [127:0]  ram_din;     
wire    [127:0]  ram_dout;    
wire             ram_wen;     


parameter ADDR_WIDTH = 12;
parameter WRAP_SIZE  = 128;

//write enable
// &Force("nonport","ram_wen"); @34
// &Force("bus","WEN",127,0); @35
assign ram_wen = !CEN && !WEN[127] && !GWEN;
//din
// &Force("nonport","ram_din"); @38
// &Force("bus","D",WRAP_SIZE-1,0); @39
assign ram_din[WRAP_SIZE-1:0] = D[WRAP_SIZE-1:0];
//address
// &Force("nonport","addr"); @42
always@(posedge CLK)
begin
  if(!CEN) begin
    addr_holding[ADDR_WIDTH-1:0] <= A[ADDR_WIDTH-1:0];
  end
end

assign addr[ADDR_WIDTH-1:0] = CEN ? addr_holding[ADDR_WIDTH-1:0]
                                  : A[ADDR_WIDTH-1:0];
//dout
// &Force("nonport","ram_dout"); @53
assign Q[WRAP_SIZE-1:0]                = ram_dout[WRAP_SIZE-1:0];
my_fpga_ram #(WRAP_SIZE,ADDR_WIDTH) ram(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram_din),
  .PortAWriteEnable(ram_wen),
  .PortADataOut(ram_dout));

// &ModuleEnd; @62
endmodule


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
module ct_f_spsram_4096x144(
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

parameter ADDR_WIDTH = 12;
parameter DATA_WIDTH = 144;
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

// &Depend("my_fpga_ram.v"); @23

// &ModuleBeg; @25
module ct_f_spsram_4096x32(
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

input   [11:0]  A_t0;           
input           CEN_t0;         
input   [31:0]  D_t0;           
input           GWEN_t0;        
output  [31:0]  Q_t0;           
input   [31:0]  WEN_t0;         
wire    [11:0]  A_t0;           
wire            CEN_t0;         
wire    [31:0]  D_t0;           
wire            GWEN_t0;        
wire    [31:0]  Q_t0;           
wire    [31:0]  WEN_t0;         
assign Q_t0 = '0;

// &Ports; @26
input   [11:0]  A;           
input           CEN;         
input           CLK;         
input   [31:0]  D;           
input           GWEN;        
input   [31:0]  WEN;         
output  [31:0]  Q;           

// &Regs; @27
reg     [11:0]  addr_holding; 

// &Wires; @28
wire    [11:0]  A;           
wire            CEN;         
wire            CLK;         
wire    [31:0]  D;           
wire            GWEN;        
wire    [31:0]  Q;           
wire    [31:0]  WEN;         
wire    [11:0]  addr;        
wire    [7 :0]  ram0_din;    
wire    [7 :0]  ram0_dout;   
wire            ram0_wen;    
wire    [7 :0]  ram1_din;    
wire    [7 :0]  ram1_dout;   
wire            ram1_wen;    
wire    [7 :0]  ram2_din;    
wire    [7 :0]  ram2_dout;   
wire            ram2_wen;    
wire    [7 :0]  ram3_din;    
wire    [7 :0]  ram3_dout;   
wire            ram3_wen;    


parameter ADDR_WIDTH = 12;
parameter WRAP_SIZE  = 8;

//write enable
// &Force("nonport","ram0_wen"); @34
// &Force("nonport","ram1_wen"); @35
// &Force("nonport","ram2_wen"); @36
// &Force("nonport","ram3_wen"); @37
// &Force("bus","WEN",31,0); @38
assign ram0_wen = !CEN && !WEN[ 7] && !GWEN;
assign ram1_wen = !CEN && !WEN[15] && !GWEN;
assign ram2_wen = !CEN && !WEN[23] && !GWEN;
assign ram3_wen = !CEN && !WEN[31] && !GWEN;

//din
// &Force("nonport","ram0_din"); @45
// &Force("nonport","ram1_din"); @46
// &Force("nonport","ram2_din"); @47
// &Force("nonport","ram3_din"); @48
// &Force("bus","D",4*WRAP_SIZE-1,0); @49
assign ram0_din[WRAP_SIZE-1:0] = D[WRAP_SIZE-1:0];
assign ram1_din[WRAP_SIZE-1:0] = D[2*WRAP_SIZE-1:WRAP_SIZE];
assign ram2_din[WRAP_SIZE-1:0] = D[3*WRAP_SIZE-1:2*WRAP_SIZE];
assign ram3_din[WRAP_SIZE-1:0] = D[4*WRAP_SIZE-1:3*WRAP_SIZE];
//address
// &Force("nonport","addr"); @55
always@(posedge CLK)
begin
  if(!CEN) begin
    addr_holding[ADDR_WIDTH-1:0] <= A[ADDR_WIDTH-1:0];
  end
end

assign addr[ADDR_WIDTH-1:0] = CEN ? addr_holding[ADDR_WIDTH-1:0]
                                  : A[ADDR_WIDTH-1:0];
//dout
// &Force("nonport","ram0_dout"); @66
// &Force("nonport","ram1_dout"); @67
// &Force("nonport","ram2_dout"); @68
// &Force("nonport","ram3_dout"); @69

assign Q[WRAP_SIZE-1:0]             = ram0_dout[WRAP_SIZE-1:0];
assign Q[2*WRAP_SIZE-1:WRAP_SIZE]   = ram1_dout[WRAP_SIZE-1:0];
assign Q[3*WRAP_SIZE-1:2*WRAP_SIZE] = ram2_dout[WRAP_SIZE-1:0];
assign Q[4*WRAP_SIZE-1:3*WRAP_SIZE] = ram3_dout[WRAP_SIZE-1:0];


my_fpga_ram #(WRAP_SIZE,ADDR_WIDTH) ram0(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram0_din),
  .PortAWriteEnable(ram0_wen),
  .PortADataOut(ram0_dout));

my_fpga_ram #(WRAP_SIZE,ADDR_WIDTH) ram1(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram1_din),
  .PortAWriteEnable(ram1_wen),
  .PortADataOut(ram1_dout));

my_fpga_ram #(WRAP_SIZE,ADDR_WIDTH) ram2(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram2_din),
  .PortAWriteEnable(ram2_wen),
  .PortADataOut(ram2_dout));

my_fpga_ram #(WRAP_SIZE,ADDR_WIDTH) ram3(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram3_din),
  .PortAWriteEnable(ram3_wen),
  .PortADataOut(ram3_dout));

// &ModuleEnd; @105
endmodule





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
module ct_f_spsram_4096x84(
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

parameter ADDR_WIDTH = 12;
parameter DATA_WIDTH = 84;
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
module ct_f_spsram_512x144(
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

parameter ADDR_WIDTH = 9;
parameter DATA_WIDTH = 144;
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
    my_fpga_ram #(WRAP_SIZE,ADDR_WIDTH) ram_instance(
      .PortAClk (CLK),
      .PortAAddr(addr),
      .PortADataIn (D[i]),
      .PortAWriteEnable(ram_wen_vec[i]),
      .PortADataOut(Q[i]));
  end
endgenerate

endmodule

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

// &Depend("my_fpga_ram.v"); @23

// &ModuleBeg; @25
module ct_f_spsram_512x22(
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

input   [8 :0]  A_t0;           
input           CEN_t0;         
input   [21:0]  D_t0;           
input           GWEN_t0;        
output  [21:0]  Q_t0;           
input   [21:0]  WEN_t0;         
wire    [8 :0]  A_t0;           
wire            CEN_t0;         
wire    [21:0]  D_t0;           
wire            GWEN_t0;        
wire    [21:0]  Q_t0;           
wire    [21:0]  WEN_t0;         
assign Q_t0 = '0;

// &Ports; @26
input   [8 :0]  A;           
input           CEN;         
input           CLK;         
input   [21:0]  D;           
input           GWEN;        
input   [21:0]  WEN;         
output  [21:0]  Q;           

// &Regs; @27
reg     [8 :0]  addr_holding; 

// &Wires; @28
wire    [8 :0]  A;           
wire            CEN;         
wire            CLK;         
wire    [21:0]  D;           
wire            GWEN;        
wire    [21:0]  Q;           
wire    [21:0]  WEN;         
wire    [8 :0]  addr;        
wire    [10:0]  ram0_din;    
wire    [10:0]  ram0_dout;   
wire            ram0_wen;    
wire    [10:0]  ram1_din;    
wire    [10:0]  ram1_dout;   
wire            ram1_wen;    


parameter ADDR_WIDTH = 9;
parameter WRAP_SIZE  = 11;

//write enable
// &Force("nonport","ram0_wen"); @34
// &Force("nonport","ram1_wen"); @35
// &Force("bus","WEN",21,0); @36
assign ram0_wen = !CEN && !WEN[10] && !GWEN;
assign ram1_wen = !CEN && !WEN[21] && !GWEN;

//din
// &Force("nonport","ram0_din"); @41
// &Force("nonport","ram1_din"); @42
// &Force("bus","D",2*WRAP_SIZE-1,0); @43
assign ram0_din[WRAP_SIZE-1:0] = D[WRAP_SIZE-1:0];
assign ram1_din[WRAP_SIZE-1:0] = D[2*WRAP_SIZE-1:WRAP_SIZE];
//address
// &Force("nonport","addr"); @47
always@(posedge CLK)
begin
  if(!CEN) begin
    addr_holding[ADDR_WIDTH-1:0] <= A[ADDR_WIDTH-1:0];
  end
end

assign addr[ADDR_WIDTH-1:0] = CEN ? addr_holding[ADDR_WIDTH-1:0]
                                  : A[ADDR_WIDTH-1:0];
//dout
// &Force("nonport","ram0_dout"); @58
// &Force("nonport","ram1_dout"); @59

assign Q[WRAP_SIZE-1:0]             = ram0_dout[WRAP_SIZE-1:0];
assign Q[2*WRAP_SIZE-1:WRAP_SIZE]   = ram1_dout[WRAP_SIZE-1:0];


my_fpga_ram #(WRAP_SIZE,ADDR_WIDTH) ram0(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram0_din),
  .PortAWriteEnable(ram0_wen),
  .PortADataOut(ram0_dout));

my_fpga_ram #(WRAP_SIZE,ADDR_WIDTH) ram1(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram1_din),
  .PortAWriteEnable(ram1_wen),
  .PortADataOut(ram1_dout));

// &ModuleEnd; @79
endmodule





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

// &Depend("my_fpga_ram.v"); @23

// &ModuleBeg; @25
module ct_f_spsram_512x44(
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

input   [8 :0]  A_t0;           
input           CEN_t0;         
input   [43:0]  D_t0;           
input           GWEN_t0;        
output  [43:0]  Q_t0;           
input   [43:0]  WEN_t0;         
wire    [8 :0]  A_t0;           
wire            CEN_t0;         
wire    [43:0]  D_t0;           
wire            GWEN_t0;        
wire    [43:0]  Q_t0;           
wire    [43:0]  WEN_t0;         
assign Q_t0 = '0;

// &Ports; @26
input   [8 :0]  A;           
input           CEN;         
input           CLK;         
input   [43:0]  D;           
input           GWEN;        
input   [43:0]  WEN;         
output  [43:0]  Q;           

// &Regs; @27
reg     [8 :0]  addr_holding; 

// &Wires; @28
wire    [8 :0]  A;           
wire            CEN;         
wire            CLK;         
wire    [43:0]  D;           
wire            GWEN;        
wire    [43:0]  Q;           
wire    [43:0]  WEN;         
wire    [8 :0]  addr;        
wire    [21:0]  ram0_din;    
wire    [21:0]  ram0_dout;   
wire            ram0_wen;    
wire    [21:0]  ram1_din;    
wire    [21:0]  ram1_dout;   
wire            ram1_wen;    


parameter ADDR_WIDTH = 9;
parameter WRAP_SIZE  = 22;

//write enable
// &Force("nonport","ram0_wen"); @34
// &Force("nonport","ram1_wen"); @35
// &Force("bus","WEN",43,0); @36
assign ram0_wen = !CEN && !WEN[21] && !GWEN;
assign ram1_wen = !CEN && !WEN[43] && !GWEN;

//din
// &Force("nonport","ram0_din"); @41
// &Force("nonport","ram1_din"); @42
// &Force("bus","D",2*WRAP_SIZE-1,0); @43
assign ram0_din[WRAP_SIZE-1:0] = D[WRAP_SIZE-1:0];
assign ram1_din[WRAP_SIZE-1:0] = D[2*WRAP_SIZE-1:WRAP_SIZE];
//address
// &Force("nonport","addr"); @47
always@(posedge CLK)
begin
  if(!CEN) begin
    addr_holding[ADDR_WIDTH-1:0] <= A[ADDR_WIDTH-1:0];
  end
end

assign addr[ADDR_WIDTH-1:0] = CEN ? addr_holding[ADDR_WIDTH-1:0]
                                  : A[ADDR_WIDTH-1:0];
//dout
// &Force("nonport","ram0_dout"); @58
// &Force("nonport","ram1_dout"); @59

assign Q[WRAP_SIZE-1:0]             = ram0_dout[WRAP_SIZE-1:0];
assign Q[2*WRAP_SIZE-1:WRAP_SIZE]   = ram1_dout[WRAP_SIZE-1:0];

my_fpga_ram #(WRAP_SIZE,ADDR_WIDTH) ram0(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram0_din),
  .PortAWriteEnable(ram0_wen),
  .PortADataOut(ram0_dout));

my_fpga_ram #(WRAP_SIZE,ADDR_WIDTH) ram1(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram1_din),
  .PortAWriteEnable(ram1_wen),
  .PortADataOut(ram1_dout));

// &ModuleEnd; @78
endmodule





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

// &Depend("my_fpga_ram.v"); @23

// &ModuleBeg; @25
module ct_f_spsram_512x52(
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

input   [8 :0]  A_t0;           
input           CEN_t0;         
input   [51:0]  D_t0;           
input           GWEN_t0;        
output  [51:0]  Q_t0;           
input   [51:0]  WEN_t0;         
wire    [8 :0]  A_t0;           
wire            CEN_t0;         
wire    [51:0]  D_t0;           
wire            GWEN_t0;        
wire    [51:0]  Q_t0;           
wire    [51:0]  WEN_t0;         
assign Q_t0 = '0;

// &Ports; @26
input   [8 :0]  A;           
input           CEN;         
input           CLK;         
input   [51:0]  D;           
input           GWEN;        
input   [51:0]  WEN;         
output  [51:0]  Q;           

// &Regs; @27
reg     [8 :0]  addr_holding; 

// &Wires; @28
wire    [8 :0]  A;           
wire            CEN;         
wire            CLK;         
wire    [51:0]  D;           
wire            GWEN;        
wire    [51:0]  Q;           
wire    [51:0]  WEN;         
wire    [8 :0]  addr;        
wire    [25:0]  ram0_din;    
wire    [25:0]  ram0_dout;   
wire            ram0_wen;    
wire    [25:0]  ram1_din;    
wire    [25:0]  ram1_dout;   
wire            ram1_wen;    


parameter ADDR_WIDTH = 9;
parameter WRAP_SIZE  = 26;

//write enable
// &Force("nonport","ram0_wen"); @34
// &Force("nonport","ram1_wen"); @35
// &Force("bus","WEN",51,0); @36
assign ram0_wen = !CEN && !WEN[25] && !GWEN;
assign ram1_wen = !CEN && !WEN[51] && !GWEN;

//din
// &Force("nonport","ram0_din"); @41
// &Force("nonport","ram1_din"); @42
// &Force("bus","D",2*WRAP_SIZE-1,0); @43
assign ram0_din[WRAP_SIZE-1:0] = D[WRAP_SIZE-1:0];
assign ram1_din[WRAP_SIZE-1:0] = D[2*WRAP_SIZE-1:WRAP_SIZE];
//address
// &Force("nonport","addr"); @47
always@(posedge CLK)
begin
  if(!CEN) begin
    addr_holding[ADDR_WIDTH-1:0] <= A[ADDR_WIDTH-1:0];
  end
end

assign addr[ADDR_WIDTH-1:0] = CEN ? addr_holding[ADDR_WIDTH-1:0]
                                  : A[ADDR_WIDTH-1:0];
//dout
// &Force("nonport","ram0_dout"); @58
// &Force("nonport","ram1_dout"); @59

assign Q[WRAP_SIZE-1:0]             = ram0_dout[WRAP_SIZE-1:0];
assign Q[2*WRAP_SIZE-1:WRAP_SIZE]   = ram1_dout[WRAP_SIZE-1:0];


my_fpga_ram #(WRAP_SIZE,ADDR_WIDTH) ram0(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram0_din),
  .PortAWriteEnable(ram0_wen),
  .PortADataOut(ram0_dout));

my_fpga_ram #(WRAP_SIZE,ADDR_WIDTH) ram1(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram1_din),
  .PortAWriteEnable(ram1_wen),
  .PortADataOut(ram1_dout));

// &ModuleEnd; @79
endmodule





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

// &Depend("my_fpga_ram.v"); @23

// &ModuleBeg; @25
module ct_f_spsram_512x54(
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

input   [8 :0]  A_t0;           
input           CEN_t0;         
input   [53:0]  D_t0;           
input           GWEN_t0;        
output  [53:0]  Q_t0;           
input   [53:0]  WEN_t0;         
wire    [8 :0]  A_t0;           
wire            CEN_t0;         
wire    [53:0]  D_t0;           
wire            GWEN_t0;        
wire    [53:0]  Q_t0;           
wire    [53:0]  WEN_t0;         
assign Q_t0 = '0;

// &Ports; @26
input   [8 :0]  A;           
input           CEN;         
input           CLK;         
input   [53:0]  D;           
input           GWEN;        
input   [53:0]  WEN;         
output  [53:0]  Q;           

// &Regs; @27
reg     [8 :0]  addr_holding; 

// &Wires; @28
wire    [8 :0]  A;           
wire            CEN;         
wire            CLK;         
wire    [53:0]  D;           
wire            GWEN;        
wire    [53:0]  Q;           
wire    [53:0]  WEN;         
wire    [8 :0]  addr;        
wire    [26:0]  ram0_din;    
wire    [26:0]  ram0_dout;   
wire            ram0_wen;    
wire    [26:0]  ram1_din;    
wire    [26:0]  ram1_dout;   
wire            ram1_wen;    


parameter ADDR_WIDTH = 9;
parameter WRAP_SIZE  = 27;

//write enable
// &Force("nonport","ram0_wen"); @34
// &Force("nonport","ram1_wen"); @35
// &Force("bus","WEN",53,0); @36
assign ram0_wen = !CEN && !WEN[26] && !GWEN;
assign ram1_wen = !CEN && !WEN[53] && !GWEN;

//din
// &Force("nonport","ram0_din"); @41
// &Force("nonport","ram1_din"); @42
// &Force("bus","D",2*WRAP_SIZE-1,0); @43
assign ram0_din[WRAP_SIZE-1:0] = D[WRAP_SIZE-1:0];
assign ram1_din[WRAP_SIZE-1:0] = D[2*WRAP_SIZE-1:WRAP_SIZE];
//address
// &Force("nonport","addr"); @47
always@(posedge CLK)
begin
  if(!CEN) begin
    addr_holding[ADDR_WIDTH-1:0] <= A[ADDR_WIDTH-1:0];
  end
end

assign addr[ADDR_WIDTH-1:0] = CEN ? addr_holding[ADDR_WIDTH-1:0]
                                  : A[ADDR_WIDTH-1:0];
//dout
// &Force("nonport","ram0_dout"); @58
// &Force("nonport","ram1_dout"); @59

assign Q[WRAP_SIZE-1:0]             = ram0_dout[WRAP_SIZE-1:0];
assign Q[2*WRAP_SIZE-1:WRAP_SIZE]   = ram1_dout[WRAP_SIZE-1:0];


my_fpga_ram #(WRAP_SIZE,ADDR_WIDTH) ram0(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram0_din),
  .PortAWriteEnable(ram0_wen),
  .PortADataOut(ram0_dout));

my_fpga_ram #(WRAP_SIZE,ADDR_WIDTH) ram1(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram1_din),
  .PortAWriteEnable(ram1_wen),
  .PortADataOut(ram1_dout));

// &ModuleEnd; @79
endmodule





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

// &Depend("my_fpga_ram.v"); @23

// &ModuleBeg; @25
module ct_f_spsram_512x59(
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

input   [8 :0]  A_t0;           
input           CEN_t0;         
input   [58:0]  D_t0;           
input           GWEN_t0;        
output  [58:0]  Q_t0;           
input   [58:0]  WEN_t0;         
wire    [8 :0]  A_t0;           
wire            CEN_t0;         
wire    [58:0]  D_t0;           
wire            GWEN_t0;        
wire    [58:0]  Q_t0;           
wire    [58:0]  WEN_t0;         
assign Q_t0 = '0;

// &Ports; @26
input   [8 :0]  A;           
input           CEN;         
input           CLK;         
input   [58:0]  D;           
input           GWEN;        
input   [58:0]  WEN;         
output  [58:0]  Q;           

// &Regs; @27
reg     [8 :0]  addr_holding; 

// &Wires; @28
wire    [8 :0]  A;           
wire            CEN;         
wire            CLK;         
wire    [58:0]  D;           
wire            GWEN;        
wire    [58:0]  Q;           
wire    [58:0]  WEN;         
wire    [8 :0]  addr;        
wire    [0 :0]  ram0_din;    
wire    [0 :0]  ram0_dout;   
wire            ram0_wen;    
wire    [28:0]  ram1_din;    
wire    [28:0]  ram1_dout;   
wire            ram1_wen;    
wire    [28:0]  ram2_din;    
wire    [28:0]  ram2_dout;   
wire            ram2_wen;    


parameter ADDR_WIDTH   = 9;
parameter WRAP_SIZE_1  = 1;
parameter WRAP_SIZE_2  = 29;

//write enable
// &Force("nonport","ram0_wen"); @35
// &Force("nonport","ram1_wen"); @36
// &Force("nonport","ram2_wen"); @37
// &Force("bus","WEN",58,0); @38
assign ram0_wen = !CEN && !WEN[58] && !GWEN;
assign ram1_wen = !CEN && !WEN[57] && !GWEN;
assign ram2_wen = !CEN && !WEN[28] && !GWEN;

//din
// &Force("nonport","ram0_din"); @44
// &Force("nonport","ram1_din"); @45
// &Force("nonport","ram2_din"); @46
// &Force("bus","D",WRAP_SIZE_1+2*WRAP_SIZE_2-1,0); @47
assign ram0_din[WRAP_SIZE_1-1:0] = D[2*WRAP_SIZE_2:2*WRAP_SIZE_2];
assign ram1_din[WRAP_SIZE_2-1:0] = D[2*WRAP_SIZE_2-1:WRAP_SIZE_2];
assign ram2_din[WRAP_SIZE_2-1:0] = D[WRAP_SIZE_2-1:0];
//address
// &Force("nonport","addr"); @52
always@(posedge CLK)
begin
  if(!CEN) begin
    addr_holding[ADDR_WIDTH-1:0] <= A[ADDR_WIDTH-1:0];
  end
end

assign addr[ADDR_WIDTH-1:0] = CEN ? addr_holding[ADDR_WIDTH-1:0]
                                  : A[ADDR_WIDTH-1:0];
//dout
// &Force("nonport","ram0_dout"); @63
// &Force("nonport","ram1_dout"); @64
// &Force("nonport","ram2_dout"); @65

assign Q[2*WRAP_SIZE_2:2*WRAP_SIZE_2] = ram0_dout[WRAP_SIZE_1-1:0];
assign Q[2*WRAP_SIZE_2-1:WRAP_SIZE_2] = ram1_dout[WRAP_SIZE_2-1:0];
assign Q[WRAP_SIZE_2-1:0]             = ram2_dout[WRAP_SIZE_2-1:0];


my_fpga_ram #(WRAP_SIZE_1,ADDR_WIDTH) ram0(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram0_din),
  .PortAWriteEnable(ram0_wen),
  .PortADataOut(ram0_dout));

my_fpga_ram #(WRAP_SIZE_2,ADDR_WIDTH) ram1(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram1_din),
  .PortAWriteEnable(ram1_wen),
  .PortADataOut(ram1_dout));

my_fpga_ram #(WRAP_SIZE_2,ADDR_WIDTH) ram2(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram2_din),
  .PortAWriteEnable(ram2_wen),
  .PortADataOut(ram2_dout));

// &ModuleEnd; @93
endmodule





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

// &Depend("my_fpga_ram.v"); @23

// &ModuleBeg; @25
module ct_f_spsram_512x7(
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

input   [8:0]  A_t0;           
input          CEN_t0;         
input   [6:0]  D_t0;           
input          GWEN_t0;        
output  [6:0]  Q_t0;           
input   [6:0]  WEN_t0;         
wire    [8:0]  A_t0;           
wire           CEN_t0;         
wire    [6:0]  D_t0;           
wire           GWEN_t0;        
wire    [6:0]  Q_t0;           
wire    [6:0]  WEN_t0;         
assign Q_t0 = '0;

// &Ports; @26
input   [8:0]  A;           
input          CEN;         
input          CLK;         
input   [6:0]  D;           
input          GWEN;        
input   [6:0]  WEN;         
output  [6:0]  Q;           

// &Regs; @27
reg     [8:0]  addr_holding; 

// &Wires; @28
wire    [8:0]  A;           
wire           CEN;         
wire           CLK;         
wire    [6:0]  D;           
wire           GWEN;        
wire    [6:0]  Q;           
wire    [6:0]  WEN;         
wire    [8:0]  addr;        
wire           ram0_din;    
wire           ram0_dout;   
wire           ram0_wen;    
wire           ram1_din;    
wire           ram1_dout;   
wire           ram1_wen;    
wire           ram2_din;    
wire           ram2_dout;   
wire           ram2_wen;    
wire           ram3_din;    
wire           ram3_dout;   
wire           ram3_wen;    
wire           ram4_din;    
wire           ram4_dout;   
wire           ram4_wen;    
wire           ram5_din;    
wire           ram5_dout;   
wire           ram5_wen;    
wire           ram6_din;    
wire           ram6_dout;   
wire           ram6_wen;    


parameter ADDR_WIDTH = 9;

//write enable
// &Force("nonport","ram0_wen"); @33
// &Force("nonport","ram1_wen"); @34
// &Force("nonport","ram2_wen"); @35
// &Force("nonport","ram3_wen"); @36
// &Force("nonport","ram4_wen"); @37
// &Force("nonport","ram5_wen"); @38
// &Force("nonport","ram6_wen"); @39
// &Force("bus","WEN",6,0); @40
assign ram0_wen = !CEN && !WEN[0] && !GWEN;
assign ram1_wen = !CEN && !WEN[1] && !GWEN;
assign ram2_wen = !CEN && !WEN[2] && !GWEN;
assign ram3_wen = !CEN && !WEN[3] && !GWEN;
assign ram4_wen = !CEN && !WEN[4] && !GWEN;
assign ram5_wen = !CEN && !WEN[5] && !GWEN;
assign ram6_wen = !CEN && !WEN[6] && !GWEN;

//din
// &Force("nonport","ram0_din"); @50
// &Force("nonport","ram1_din"); @51
// &Force("nonport","ram2_din"); @52
// &Force("nonport","ram3_din"); @53
// &Force("nonport","ram4_din"); @54
// &Force("nonport","ram5_din"); @55
// &Force("nonport","ram6_din"); @56
// &Force("bus","D",6,0); @57
assign ram0_din = D[0];
assign ram1_din = D[1];
assign ram2_din = D[2];
assign ram3_din = D[3];
assign ram4_din = D[4];
assign ram5_din = D[5];
assign ram6_din = D[6];

//address
// &Force("nonport","addr"); @67
always@(posedge CLK)
begin
  if(!CEN) begin
    addr_holding[ADDR_WIDTH-1:0] <= A[ADDR_WIDTH-1:0];
  end
end

assign addr[ADDR_WIDTH-1:0] = CEN ? addr_holding[ADDR_WIDTH-1:0]
                                  : A[ADDR_WIDTH-1:0];

//dout
// &Force("nonport","ram0_dout"); @79
// &Force("nonport","ram1_dout"); @80
// &Force("nonport","ram2_dout"); @81
// &Force("nonport","ram3_dout"); @82
// &Force("nonport","ram4_dout"); @83
// &Force("nonport","ram5_dout"); @84
// &Force("nonport","ram6_dout"); @85
assign Q[0] = ram0_dout;
assign Q[1] = ram1_dout;
assign Q[2] = ram2_dout;
assign Q[3] = ram3_dout;
assign Q[4] = ram4_dout;
assign Q[5] = ram5_dout;
assign Q[6] = ram6_dout;

my_fpga_ram #(1,ADDR_WIDTH) ram0(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram0_din),
  .PortAWriteEnable(ram0_wen),
  .PortADataOut(ram0_dout));

my_fpga_ram #(1,ADDR_WIDTH) ram1(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram1_din),
  .PortAWriteEnable(ram1_wen),
  .PortADataOut(ram1_dout));

my_fpga_ram #(1,ADDR_WIDTH) ram2(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram2_din),
  .PortAWriteEnable(ram2_wen),
  .PortADataOut(ram2_dout));

my_fpga_ram #(1,ADDR_WIDTH) ram3(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram3_din),
  .PortAWriteEnable(ram3_wen),
  .PortADataOut(ram3_dout));

my_fpga_ram #(1,ADDR_WIDTH) ram4(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram4_din),
  .PortAWriteEnable(ram4_wen),
  .PortADataOut(ram4_dout));

my_fpga_ram #(1,ADDR_WIDTH) ram5(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram5_din),
  .PortAWriteEnable(ram5_wen),
  .PortADataOut(ram5_dout));

my_fpga_ram #(1,ADDR_WIDTH) ram6(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram6_din),
  .PortAWriteEnable(ram6_wen),
  .PortADataOut(ram6_dout));

// &ModuleEnd; @143
endmodule




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

// &ModuleBeg; @3
module ct_f_spsram_512x96(
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

input   [8 :0]  A_t0;           
input           CEN_t0;         
input   [95:0]  D_t0;           
input           GWEN_t0;        
output  [95:0]  Q_t0;           
input   [95:0]  WEN_t0;         
wire    [8 :0]  A_t0;           
wire            CEN_t0;         
wire    [95:0]  D_t0;           
wire            GWEN_t0;        
wire    [95:0]  Q_t0;           
wire    [95:0]  WEN_t0;         
assign Q_t0 = '0;

// &Ports; @4
input   [8 :0]  A;           
input           CEN;         
input           CLK;         
input   [95:0]  D;           
input           GWEN;        
input   [95:0]  WEN;         
output  [95:0]  Q;           

// &Regs; @5
reg     [8 :0]  addr_holding; 

// &Wires; @6
wire    [8 :0]  A;           
wire            CEN;         
wire            CLK;         
wire    [95:0]  D;           
wire            GWEN;        
wire    [95:0]  Q;           
wire    [95:0]  WEN;         
wire    [8 :0]  addr;        
wire    [23:0]  ram_din0;    
wire    [23:0]  ram_din1;    
wire    [23:0]  ram_din2;    
wire    [23:0]  ram_din3;    
wire    [23:0]  ram_dout0;   
wire    [23:0]  ram_dout1;   
wire    [23:0]  ram_dout2;   
wire    [23:0]  ram_dout3;   
wire            ram_wen0;    
wire            ram_wen1;    
wire            ram_wen2;    
wire            ram_wen3;    

// &Force("bus","Q",95,0); @7

parameter ADDR_WIDTH = 9;
parameter WRAP_SIZE  = 24;

//write enable
// &Force("nonport","ram_wen0"); @13
// &Force("nonport","ram_wen1"); @14
// &Force("nonport","ram_wen2"); @15
// &Force("nonport","ram_wen3"); @16

// &Force("bus","WEN",95,0); @18
assign ram_wen0 = !CEN && !WEN[23] && !GWEN;
assign ram_wen1 = !CEN && !WEN[47] && !GWEN;
assign ram_wen2 = !CEN && !WEN[71] && !GWEN;
assign ram_wen3 = !CEN && !WEN[95] && !GWEN;

//din
// &Force("nonport","ram_din0"); @25
// &Force("nonport","ram_din1"); @26
// &Force("nonport","ram_din2"); @27
// &Force("nonport","ram_din3"); @28
// &Force("bus","D",4*WRAP_SIZE-1,0); @29
assign ram_din0[WRAP_SIZE-1:0] = D[WRAP_SIZE-1:0];
assign ram_din1[WRAP_SIZE-1:0] = D[2*WRAP_SIZE-1:WRAP_SIZE];
assign ram_din2[WRAP_SIZE-1:0] = D[3*WRAP_SIZE-1:2*WRAP_SIZE];
assign ram_din3[WRAP_SIZE-1:0] = D[4*WRAP_SIZE-1:3*WRAP_SIZE];
//address
// &Force("nonport","addr"); @35
always@(posedge CLK)
begin
  if(!CEN) begin
    addr_holding[ADDR_WIDTH-1:0] <= A[ADDR_WIDTH-1:0];
  end
end

assign addr[ADDR_WIDTH-1:0] = CEN ? addr_holding[ADDR_WIDTH-1:0]
                                  : A[ADDR_WIDTH-1:0];

//dout
// &Force("nonport","ram_dout0"); @47
// &Force("nonport","ram_dout1"); @48
// &Force("nonport","ram_dout2"); @49
// &Force("nonport","ram_dout3"); @50
assign Q[WRAP_SIZE-1:0]                = ram_dout0[WRAP_SIZE-1:0];
assign Q[2*WRAP_SIZE-1:WRAP_SIZE]      = ram_dout1[WRAP_SIZE-1:0];
assign Q[3*WRAP_SIZE-1:2*WRAP_SIZE]    = ram_dout2[WRAP_SIZE-1:0];
assign Q[4*WRAP_SIZE-1:3*WRAP_SIZE]    = ram_dout3[WRAP_SIZE-1:0];

my_fpga_ram #(WRAP_SIZE,ADDR_WIDTH) ram0(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram_din0),
  .PortAWriteEnable(ram_wen0),
  .PortADataOut(ram_dout0));

my_fpga_ram #(WRAP_SIZE,ADDR_WIDTH) ram1(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram_din1),
  .PortAWriteEnable(ram_wen1),
  .PortADataOut(ram_dout1));

my_fpga_ram #(WRAP_SIZE,ADDR_WIDTH) ram2(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram_din2),
  .PortAWriteEnable(ram_wen2),
  .PortADataOut(ram_dout2));

my_fpga_ram #(WRAP_SIZE,ADDR_WIDTH) ram3(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram_din3),
  .PortAWriteEnable(ram_wen3),
  .PortADataOut(ram_dout3));

// &ModuleEnd; @84
endmodule



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

// &ModuleBeg; @3
module ct_f_spsram_64x108(
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

input   [5  :0]  A_t0;           
input            CEN_t0;         
input   [107:0]  D_t0;           
input            GWEN_t0;        
output  [107:0]  Q_t0;           
input   [107:0]  WEN_t0;         
wire    [5  :0]  A_t0;           
wire             CEN_t0;         
wire    [107:0]  D_t0;           
wire             GWEN_t0;        
wire    [107:0]  Q_t0;           
wire    [107:0]  WEN_t0;         
assign Q_t0 = '0;

// &Ports; @4
input   [5  :0]  A;           
input            CEN;         
input            CLK;         
input   [107:0]  D;           
input            GWEN;        
input   [107:0]  WEN;         
output  [107:0]  Q;           

// &Regs; @5
reg     [5  :0]  addr_holding; 

// &Wires; @6
wire    [5  :0]  A;           
wire             CEN;         
wire             CLK;         
wire    [107:0]  D;           
wire             GWEN;        
wire    [107:0]  Q;           
wire    [107:0]  WEN;         
wire    [5  :0]  addr;        
wire    [26 :0]  ram_din0;    
wire    [26 :0]  ram_din1;    
wire    [26 :0]  ram_din2;    
wire    [26 :0]  ram_din3;    
wire    [26 :0]  ram_dout0;   
wire    [26 :0]  ram_dout1;   
wire    [26 :0]  ram_dout2;   
wire    [26 :0]  ram_dout3;   
wire             ram_wen0;    
wire             ram_wen1;    
wire             ram_wen2;    
wire             ram_wen3;    

// &Force("bus","Q",107,0); @7

parameter ADDR_WIDTH = 6;
parameter WRAP_SIZE  = 27;

//write enable
// &Force("nonport","ram_wen0"); @13
// &Force("nonport","ram_wen1"); @14
// &Force("nonport","ram_wen2"); @15
// &Force("nonport","ram_wen3"); @16

// &Force("bus","WEN",107,0); @18
assign ram_wen0 = !CEN && !WEN[26] && !GWEN;
assign ram_wen1 = !CEN && !WEN[53] && !GWEN;
assign ram_wen2 = !CEN && !WEN[80] && !GWEN;
assign ram_wen3 = !CEN && !WEN[107] && !GWEN;

//din
// &Force("nonport","ram_din0"); @25
// &Force("nonport","ram_din1"); @26
// &Force("nonport","ram_din2"); @27
// &Force("nonport","ram_din3"); @28
// &Force("bus","D",4*WRAP_SIZE-1,0); @29
assign ram_din0[WRAP_SIZE-1:0] = D[WRAP_SIZE-1:0];
assign ram_din1[WRAP_SIZE-1:0] = D[2*WRAP_SIZE-1:WRAP_SIZE];
assign ram_din2[WRAP_SIZE-1:0] = D[3*WRAP_SIZE-1:2*WRAP_SIZE];
assign ram_din3[WRAP_SIZE-1:0] = D[4*WRAP_SIZE-1:3*WRAP_SIZE];
//address
// &Force("nonport","addr"); @35
always@(posedge CLK)
begin
  if(!CEN) begin
    addr_holding[ADDR_WIDTH-1:0] <= A[ADDR_WIDTH-1:0];
  end
end

assign addr[ADDR_WIDTH-1:0] = CEN ? addr_holding[ADDR_WIDTH-1:0]
                                  : A[ADDR_WIDTH-1:0];

//dout
// &Force("nonport","ram_dout0"); @47
// &Force("nonport","ram_dout1"); @48
// &Force("nonport","ram_dout2"); @49
// &Force("nonport","ram_dout3"); @50
assign Q[WRAP_SIZE-1:0]                = ram_dout0[WRAP_SIZE-1:0];
assign Q[2*WRAP_SIZE-1:WRAP_SIZE]      = ram_dout1[WRAP_SIZE-1:0];
assign Q[3*WRAP_SIZE-1:2*WRAP_SIZE]    = ram_dout2[WRAP_SIZE-1:0];
assign Q[4*WRAP_SIZE-1:3*WRAP_SIZE]    = ram_dout3[WRAP_SIZE-1:0];

my_fpga_ram #(WRAP_SIZE,ADDR_WIDTH) ram0(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram_din0),
  .PortAWriteEnable(ram_wen0),
  .PortADataOut(ram_dout0));

my_fpga_ram #(WRAP_SIZE,ADDR_WIDTH) ram1(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram_din1),
  .PortAWriteEnable(ram_wen1),
  .PortADataOut(ram_dout1));

my_fpga_ram #(WRAP_SIZE,ADDR_WIDTH) ram2(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram_din2),
  .PortAWriteEnable(ram_wen2),
  .PortADataOut(ram_dout2));

my_fpga_ram #(WRAP_SIZE,ADDR_WIDTH) ram3(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram_din3),
  .PortAWriteEnable(ram_wen3),
  .PortADataOut(ram_dout3));

// &ModuleEnd; @84
endmodule



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

// &Depend("my_fpga_ram.v"); @23

// &ModuleBeg; @25
module ct_f_spsram_8192x128(
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

input   [12 :0]  A_t0;           
input            CEN_t0;         
input   [127:0]  D_t0;           
input            GWEN_t0;        
output  [127:0]  Q_t0;           
input   [127:0]  WEN_t0;         
wire    [12 :0]  A_t0;           
wire             CEN_t0;         
wire    [127:0]  D_t0;           
wire             GWEN_t0;        
wire    [127:0]  Q_t0;           
wire    [127:0]  WEN_t0;         
assign Q_t0 = '0;

// &Ports; @26
input   [12 :0]  A;           
input            CEN;         
input            CLK;         
input   [127:0]  D;           
input            GWEN;        
input   [127:0]  WEN;         
output  [127:0]  Q;           

// &Regs; @27
reg     [12 :0]  addr_holding; 

// &Wires; @28
wire    [12 :0]  A;           
wire             CEN;         
wire             CLK;         
wire    [127:0]  D;           
wire             GWEN;        
wire    [127:0]  Q;           
wire    [127:0]  WEN;         
wire    [12 :0]  addr;        
wire    [127:0]  ram_din;     
wire    [127:0]  ram_dout;    
wire             ram_wen;     


parameter ADDR_WIDTH = 13;
parameter WRAP_SIZE  = 128;

//write enable
// &Force("nonport","ram_wen"); @34
// &Force("bus","WEN",127,0); @35
assign ram_wen = !CEN && !WEN[127] && !GWEN;
//din
// &Force("nonport","ram_din"); @38
// &Force("bus","D",WRAP_SIZE-1,0); @39
assign ram_din[WRAP_SIZE-1:0] = D[WRAP_SIZE-1:0];
//address
// &Force("nonport","addr"); @42
always@(posedge CLK)
begin
  if(!CEN) begin
    addr_holding[ADDR_WIDTH-1:0] <= A[ADDR_WIDTH-1:0];
  end
end

assign addr[ADDR_WIDTH-1:0] = CEN ? addr_holding[ADDR_WIDTH-1:0]
                                  : A[ADDR_WIDTH-1:0];
//dout
// &Force("nonport","ram_dout"); @53
assign Q[WRAP_SIZE-1:0]                = ram_dout[WRAP_SIZE-1:0];
my_fpga_ram #(WRAP_SIZE,ADDR_WIDTH) ram(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram_din),
  .PortAWriteEnable(ram_wen),
  .PortADataOut(ram_dout));

// &ModuleEnd; @62
endmodule


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

// &Depend("my_fpga_ram.v"); @23

// &ModuleBeg; @25
module ct_f_spsram_8192x32(
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

input   [12:0]  A_t0;           
input           CEN_t0;         
input   [31:0]  D_t0;           
input           GWEN_t0;        
output  [31:0]  Q_t0;           
input   [31:0]  WEN_t0;         
wire    [12:0]  A_t0;           
wire            CEN_t0;         
wire    [31:0]  D_t0;           
wire            GWEN_t0;        
wire    [31:0]  Q_t0;           
wire    [31:0]  WEN_t0;         
assign Q_t0 = '0;

// &Ports; @26
input   [12:0]  A;           
input           CEN;         
input           CLK;         
input   [31:0]  D;           
input           GWEN;        
input   [31:0]  WEN;         
output  [31:0]  Q;           

// &Regs; @27
reg     [12:0]  addr_holding; 

// &Wires; @28
wire    [12:0]  A;           
wire            CEN;         
wire            CLK;         
wire    [31:0]  D;           
wire            GWEN;        
wire    [31:0]  Q;           
wire    [31:0]  WEN;         
wire    [12:0]  addr;        
wire    [7 :0]  ram0_din;    
wire    [7 :0]  ram0_dout;   
wire            ram0_wen;    
wire    [7 :0]  ram1_din;    
wire    [7 :0]  ram1_dout;   
wire            ram1_wen;    
wire    [7 :0]  ram2_din;    
wire    [7 :0]  ram2_dout;   
wire            ram2_wen;    
wire    [7 :0]  ram3_din;    
wire    [7 :0]  ram3_dout;   
wire            ram3_wen;    


parameter ADDR_WIDTH = 13;
parameter WRAP_SIZE  = 8;

//write enable
// &Force("nonport","ram0_wen"); @34
// &Force("nonport","ram1_wen"); @35
// &Force("nonport","ram2_wen"); @36
// &Force("nonport","ram3_wen"); @37
// &Force("bus","WEN",31,0); @38
assign ram0_wen = !CEN && !WEN[ 7] && !GWEN;
assign ram1_wen = !CEN && !WEN[15] && !GWEN;
assign ram2_wen = !CEN && !WEN[23] && !GWEN;
assign ram3_wen = !CEN && !WEN[31] && !GWEN;

//din
// &Force("nonport","ram0_din"); @45
// &Force("nonport","ram1_din"); @46
// &Force("nonport","ram2_din"); @47
// &Force("nonport","ram3_din"); @48
// &Force("bus","D",4*WRAP_SIZE-1,0); @49
assign ram0_din[WRAP_SIZE-1:0] = D[WRAP_SIZE-1:0];
assign ram1_din[WRAP_SIZE-1:0] = D[2*WRAP_SIZE-1:WRAP_SIZE];
assign ram2_din[WRAP_SIZE-1:0] = D[3*WRAP_SIZE-1:2*WRAP_SIZE];
assign ram3_din[WRAP_SIZE-1:0] = D[4*WRAP_SIZE-1:3*WRAP_SIZE];
//address
// &Force("nonport","addr"); @55
always@(posedge CLK)
begin
  if(!CEN) begin
    addr_holding[ADDR_WIDTH-1:0] <= A[ADDR_WIDTH-1:0];
  end
end

assign addr[ADDR_WIDTH-1:0] = CEN ? addr_holding[ADDR_WIDTH-1:0]
                                  : A[ADDR_WIDTH-1:0];
//dout
// &Force("nonport","ram0_dout"); @66
// &Force("nonport","ram1_dout"); @67
// &Force("nonport","ram2_dout"); @68
// &Force("nonport","ram3_dout"); @69

assign Q[WRAP_SIZE-1:0]             = ram0_dout[WRAP_SIZE-1:0];
assign Q[2*WRAP_SIZE-1:WRAP_SIZE]   = ram1_dout[WRAP_SIZE-1:0];
assign Q[3*WRAP_SIZE-1:2*WRAP_SIZE] = ram2_dout[WRAP_SIZE-1:0];
assign Q[4*WRAP_SIZE-1:3*WRAP_SIZE] = ram3_dout[WRAP_SIZE-1:0];


my_fpga_ram #(WRAP_SIZE,ADDR_WIDTH) ram0(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram0_din),
  .PortAWriteEnable(ram0_wen),
  .PortADataOut(ram0_dout));

my_fpga_ram #(WRAP_SIZE,ADDR_WIDTH) ram1(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram1_din),
  .PortAWriteEnable(ram1_wen),
  .PortADataOut(ram1_dout));

my_fpga_ram #(WRAP_SIZE,ADDR_WIDTH) ram2(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram2_din),
  .PortAWriteEnable(ram2_wen),
  .PortADataOut(ram2_dout));

my_fpga_ram #(WRAP_SIZE,ADDR_WIDTH) ram3(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram3_din),
  .PortAWriteEnable(ram3_wen),
  .PortADataOut(ram3_dout));

// &ModuleEnd; @105
endmodule





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

// &ModuleBeg; @22
module ct_spsram_1024x128(
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

input   [9  :0]  A_t0;   
input            CEN_t0; 
input   [127:0]  D_t0;   
input            GWEN_t0; 
output  [127:0]  Q_t0;   
input   [127:0]  WEN_t0; 
wire    [9  :0]  A_t0;   
wire             CEN_t0; 
wire    [127:0]  D_t0;   
wire             GWEN_t0; 
wire    [127:0]  Q_t0;   
wire    [127:0]  WEN_t0; 
assign Q_t0 = '0;

// &Ports; @23
input   [9  :0]  A;   
input            CEN; 
input            CLK; 
input   [127:0]  D;   
input            GWEN; 
input   [127:0]  WEN; 
output  [127:0]  Q;   

// &Regs; @24

// &Wires; @25
wire    [9  :0]  A;   
wire             CEN; 
wire             CLK; 
wire    [127:0]  D;   
wire             GWEN; 
wire    [127:0]  Q;   
wire    [127:0]  WEN; 


//**********************************************************
//                  Parameter Definition
//**********************************************************
parameter ADDR_WIDTH = 10;
parameter DATA_WIDTH = 128;
parameter WE_WIDTH   = 128;

// &Force("bus","Q",DATA_WIDTH-1,0); @34
// &Force("bus","WEN",WE_WIDTH-1,0); @35
// &Force("bus","A",ADDR_WIDTH-1,0); @36
// &Force("bus","D",DATA_WIDTH-1,0); @37

//  //********************************************************
//  //*                        FPGA memory                   *
//  //********************************************************
//   &Instance("ct_f_spsram_1024x128"); @43
ct_f_spsram_1024x128  x_ct_f_spsram_1024x128 (
  .A    (A   ),
  .CEN  (CEN ),
  .CLK  (CLK ),
  .D    (D   ),
  .GWEN (GWEN),
  .Q    (Q   ),
  .WEN  (WEN )
);

//   &Instance("ct_tsmc_spsram_1024x128"); @49

// &ModuleEnd; @65
endmodule


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

// &ModuleBeg; @22
module ct_spsram_1024x144(
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

input   [9  :0]  A_t0;   
input            CEN_t0; 
input   [143:0]  D_t0;   
input            GWEN_t0; 
output  [143:0]  Q_t0;   
input   [143:0]  WEN_t0; 
wire    [9  :0]  A_t0;   
wire             CEN_t0; 
wire    [143:0]  D_t0;   
wire             GWEN_t0; 
wire    [143:0]  Q_t0;   
wire    [143:0]  WEN_t0; 
assign Q_t0 = '0;

// &Ports; @23
input   [9  :0]  A;   
input            CEN; 
input            CLK; 
input   [143:0]  D;   
input            GWEN; 
input   [143:0]  WEN; 
output  [143:0]  Q;   

// &Regs; @24

// &Wires; @25
wire    [9  :0]  A;   
wire             CEN; 
wire             CLK; 
wire    [143:0]  D;   
wire             GWEN; 
wire    [143:0]  Q;   
wire    [143:0]  WEN; 


//**********************************************************
//                  Parameter Definition
//**********************************************************
parameter ADDR_WIDTH = 10;
parameter DATA_WIDTH = 144;
parameter WE_WIDTH   = 144;

// &Force("bus","Q",DATA_WIDTH-1,0); @34
// &Force("bus","WEN",WE_WIDTH-1,0); @35
// &Force("bus","A",ADDR_WIDTH-1,0); @36
// &Force("bus","D",DATA_WIDTH-1,0); @37

  //********************************************************
  //*                        FPGA memory                   *
  //********************************************************
//   &Instance("ct_f_spsram_1024x144"); @43
ct_f_spsram_1024x144  x_ct_f_spsram_1024x144 (
  .A    (A   ),
  .CEN  (CEN ),
  .CLK  (CLK ),
  .D    (D   ),
  .GWEN (GWEN),
  .Q    (Q   ),
  .WEN  (WEN )
);

//   &Instance("ct_tsmc_spsram_1024x144"); @49

// &ModuleEnd; @65
endmodule


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

// &ModuleBeg; @22
module ct_spsram_1024x32(
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

input   [9 :0]  A_t0;   
input           CEN_t0; 
input   [31:0]  D_t0;   
input           GWEN_t0; 
output  [31:0]  Q_t0;   
input   [31:0]  WEN_t0; 
wire    [9 :0]  A_t0;   
wire            CEN_t0; 
wire    [31:0]  D_t0;   
wire            GWEN_t0; 
wire    [31:0]  Q_t0;   
wire    [31:0]  WEN_t0; 
assign Q_t0 = '0;

// &Ports; @23
input   [9 :0]  A;   
input           CEN; 
input           CLK; 
input   [31:0]  D;   
input           GWEN; 
input   [31:0]  WEN; 
output  [31:0]  Q;   

// &Regs; @24

// &Wires; @25
wire    [9 :0]  A;   
wire            CEN; 
wire            CLK; 
wire    [31:0]  D;   
wire            GWEN; 
wire    [31:0]  Q;   
wire    [31:0]  WEN; 


//**********************************************************
//                  Parameter Definition
//**********************************************************
parameter ADDR_WIDTH = 10;
parameter DATA_WIDTH = 32;
parameter WE_WIDTH   = 32;

// &Force("bus","Q",DATA_WIDTH-1,0); @34
// &Force("bus","WEN",WE_WIDTH-1,0); @35
// &Force("bus","A",ADDR_WIDTH-1,0); @36
// &Force("bus","D",DATA_WIDTH-1,0); @37

  //********************************************************
  //*                        FPGA memory                   *
  //********************************************************
  //{WEN[31:24],WEN[23:16],WEN[15:8],WEN[7:0]}
//   &Instance("ct_f_spsram_1024x32"); @44
ct_f_spsram_1024x32  x_ct_f_spsram_1024x32 (
  .A    (A   ),
  .CEN  (CEN ),
  .CLK  (CLK ),
  .D    (D   ),
  .GWEN (GWEN),
  .Q    (Q   ),
  .WEN  (WEN )
);

//   &Instance("ct_tsmc_spsram_1024x32"); @50

// &ModuleEnd; @66
endmodule


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

// &ModuleBeg; @22
module ct_spsram_1024x59(
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

input   [9 :0]  A_t0;   
input           CEN_t0; 
input   [58:0]  D_t0;   
input           GWEN_t0; 
output  [58:0]  Q_t0;   
input   [58:0]  WEN_t0; 
wire    [9 :0]  A_t0;   
wire            CEN_t0; 
wire    [58:0]  D_t0;   
wire            GWEN_t0; 
wire    [58:0]  Q_t0;   
wire    [58:0]  WEN_t0; 
assign Q_t0 = '0;

// &Ports; @23
input   [9 :0]  A;   
input           CEN; 
input           CLK; 
input   [58:0]  D;   
input           GWEN; 
input   [58:0]  WEN; 
output  [58:0]  Q;   

// &Regs; @24

// &Wires; @25
wire    [9 :0]  A;   
wire            CEN; 
wire            CLK; 
wire    [58:0]  D;   
wire            GWEN; 
wire    [58:0]  Q;   
wire    [58:0]  WEN; 


//**********************************************************
//                  Parameter Definition
//**********************************************************
parameter ADDR_WIDTH = 10;
parameter DATA_WIDTH = 59;
parameter WE_WIDTH   = 59;

// &Force("bus","Q",DATA_WIDTH-1,0); @34
// &Force("bus","WEN",WE_WIDTH-1,0); @35
// &Force("bus","A",ADDR_WIDTH-1,0); @36
// &Force("bus","D",DATA_WIDTH-1,0); @37

  //********************************************************
  //*                        FPGA memory                   *
  //********************************************************
  //{WEN[58],WEN[57:29],WEN[28:0]}
//   &Instance("ct_f_spsram_1024x59"); @44
ct_f_spsram_1024x59  x_ct_f_spsram_1024x59 (
  .A    (A   ),
  .CEN  (CEN ),
  .CLK  (CLK ),
  .D    (D   ),
  .GWEN (GWEN),
  .Q    (Q   ),
  .WEN  (WEN )
);

//   &Instance("ct_tsmc_spsram_512x59"); @50

// &ModuleEnd; @66
endmodule


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

// &ModuleBeg; @22
module ct_spsram_1024x64(
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

input   [9 :0]  A_t0;   
input           CEN_t0; 
input   [63:0]  D_t0;   
input           GWEN_t0; 
output  [63:0]  Q_t0;   
input   [63:0]  WEN_t0; 
wire    [9 :0]  A_t0;   
wire            CEN_t0; 
wire    [63:0]  D_t0;   
wire            GWEN_t0; 
wire    [63:0]  Q_t0;   
wire    [63:0]  WEN_t0; 
assign Q_t0 = '0;

// &Ports; @23
input   [9 :0]  A;   
input           CEN; 
input           CLK; 
input   [63:0]  D;   
input           GWEN; 
input   [63:0]  WEN; 
output  [63:0]  Q;   

// &Regs; @24

// &Wires; @25
wire    [9 :0]  A;   
wire            CEN; 
wire            CLK; 
wire    [63:0]  D;   
wire            GWEN; 
wire    [63:0]  Q;   
wire    [63:0]  WEN; 

// &Depend("cpu_cfig.h"); @26
//**********************************************************
//                  Parameter Definition
//**********************************************************
parameter ADDR_WIDTH = 10;
parameter DATA_WIDTH = 64;
parameter WE_WIDTH   = 64;

// &Force("bus","Q",DATA_WIDTH-1,0); @34
// &Force("bus","WEN",WE_WIDTH-1,0); @35
// &Force("bus","A",ADDR_WIDTH-1,0); @36
// &Force("bus","D",DATA_WIDTH-1,0); @37

  //********************************************************
  //*                        FPGA memory                   *
  //********************************************************
  //{WEN[63:62],WEN[61:60],WEN[59:58],WEN[57:56],WEN[55:54],WEN[53:52],WEN[51:50],WEN[49:48],
  // WEN[47:46],WEN[45:44],WEN[43:42],WEN[41:40],WEN[39:38],WEN[37:36],WEN[35:34],WEN[33:32],
  // WEN[31:30],WEN[29:28],WEN[27:26],WEN[25:24],WEN[23:22],WEN[21:20],WEN[19:18],WEN[17:16],
  // WEN[15:14],WEN[13:12],WEN[11:10],WEN[ 9: 8],WEN[ 7: 6],WEN[ 5: 4],WEN[ 3: 2],WEN[ 1: 0]}
//   &Instance("ct_f_spsram_1024x64"); @47
ct_f_spsram_1024x64  x_ct_f_spsram_1024x64 (
  .A    (A   ),
  .CEN  (CEN ),
  .CLK  (CLK ),
  .D    (D   ),
  .GWEN (GWEN),
  .Q    (Q   ),
  .WEN  (WEN )
);

//   &Instance("ct_tsmc_spsram_1024x64"); @53

// &ModuleEnd; @69
endmodule


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

// &ModuleBeg; @22
module ct_spsram_1024x92(
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

input   [9 :0]  A_t0;   
input           CEN_t0; 
input   [91:0]  D_t0;   
input           GWEN_t0; 
output  [91:0]  Q_t0;   
input   [91:0]  WEN_t0; 
wire    [9 :0]  A_t0;   
wire            CEN_t0; 
wire    [91:0]  D_t0;   
wire            GWEN_t0; 
wire    [91:0]  Q_t0;   
wire    [91:0]  WEN_t0; 
assign Q_t0 = '0;

// &Ports; @23
input   [9 :0]  A;   
input           CEN; 
input           CLK; 
input   [91:0]  D;   
input           GWEN; 
input   [91:0]  WEN; 
output  [91:0]  Q;   

// &Regs; @24

// &Wires; @25
wire    [9 :0]  A;   
wire            CEN; 
wire            CLK; 
wire    [91:0]  D;   
wire            GWEN; 
wire    [91:0]  Q;   
wire    [91:0]  WEN; 


//**********************************************************
//                  Parameter Definition
//**********************************************************
parameter ADDR_WIDTH = 10;
parameter DATA_WIDTH = 92;
parameter WE_WIDTH   = 92;

// &Force("bus","Q",DATA_WIDTH-1,0); @34
// &Force("bus","WEN",WE_WIDTH-1,0); @35
// &Force("bus","A",ADDR_WIDTH-1,0); @36
// &Force("bus","D",DATA_WIDTH-1,0); @37

//  //********************************************************
//  //*                        FPGA memory                   *
//  //********************************************************
//   &Instance("ct_f_spsram_1024x92"); @43
ct_f_spsram_1024x92  x_ct_f_spsram_1024x92 (
  .A    (A   ),
  .CEN  (CEN ),
  .CLK  (CLK ),
  .D    (D   ),
  .GWEN (GWEN),
  .Q    (Q   ),
  .WEN  (WEN )
);

//   &Instance("ct_tsmc_spsram_1024x92"); @49

// &ModuleEnd; @65
endmodule


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

// &ModuleBeg; @22
module ct_spsram_128x104(
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

input   [6  :0]  A_t0;   
input            CEN_t0; 
input   [103:0]  D_t0;   
input            GWEN_t0; 
output  [103:0]  Q_t0;   
input   [103:0]  WEN_t0; 
wire    [6  :0]  A_t0;   
wire             CEN_t0; 
wire    [103:0]  D_t0;   
wire             GWEN_t0; 
wire    [103:0]  Q_t0;   
wire    [103:0]  WEN_t0; 
assign Q_t0 = '0;

// &Ports; @23
input   [6  :0]  A;   
input            CEN; 
input            CLK; 
input   [103:0]  D;   
input            GWEN; 
input   [103:0]  WEN; 
output  [103:0]  Q;   

// &Regs; @24

// &Wires; @25
wire    [6  :0]  A;   
wire             CEN; 
wire             CLK; 
wire    [103:0]  D;   
wire             GWEN; 
wire    [103:0]  Q;   
wire    [103:0]  WEN; 


//**********************************************************
//                  Parameter Definition
//**********************************************************
parameter ADDR_WIDTH = 7;
parameter DATA_WIDTH = 104;
parameter WE_WIDTH   = 104;

// &Force("bus","Q",DATA_WIDTH-1,0); @34
// &Force("bus","WEN",WE_WIDTH-1,0); @35
// &Force("bus","A",ADDR_WIDTH-1,0); @36
// &Force("bus","D",DATA_WIDTH-1,0); @37

//  //********************************************************
//  //*                        FPGA memory                   *
//  //********************************************************
//   &Instance("ct_f_spsram_128x104"); @43
ct_f_spsram_128x104  x_ct_f_spsram_128x104 (
  .A    (A   ),
  .CEN  (CEN ),
  .CLK  (CLK ),
  .D    (D   ),
  .GWEN (GWEN),
  .Q    (Q   ),
  .WEN  (WEN )
);

//   &Instance("ct_tsmc_spsram_128x104"); @49

// &ModuleEnd; @65
endmodule


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

// &ModuleBeg; @22
module ct_spsram_128x144(
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

input   [6  :0]  A_t0;   
input            CEN_t0; 
input   [143:0]  D_t0;   
input            GWEN_t0; 
output  [143:0]  Q_t0;   
input   [143:0]  WEN_t0; 
wire    [6  :0]  A_t0;   
wire             CEN_t0; 
wire    [143:0]  D_t0;   
wire             GWEN_t0; 
wire    [143:0]  Q_t0;   
wire    [143:0]  WEN_t0; 
assign Q_t0 = '0;

// &Ports; @23
input   [6  :0]  A;   
input            CEN; 
input            CLK; 
input   [143:0]  D;   
input            GWEN; 
input   [143:0]  WEN; 
output  [143:0]  Q;   

// &Regs; @24

// &Wires; @25
wire    [6  :0]  A;   
wire             CEN; 
wire             CLK; 
wire    [143:0]  D;   
wire             GWEN; 
wire    [143:0]  Q;   
wire    [143:0]  WEN; 


//**********************************************************
//                  Parameter Definition
//**********************************************************
parameter ADDR_WIDTH = 7;
parameter DATA_WIDTH = 144;
parameter WE_WIDTH   = 144;

// &Force("bus","Q",DATA_WIDTH-1,0); @34
// &Force("bus","WEN",WE_WIDTH-1,0); @35
// &Force("bus","A",ADDR_WIDTH-1,0); @36
// &Force("bus","D",DATA_WIDTH-1,0); @37

//  //********************************************************
//  //*                        FPGA memory                   *
//  //********************************************************
//   &Instance("ct_f_spsram_128x144"); @43
ct_f_spsram_128x144  x_ct_f_spsram_128x144 (
  .A    (A   ),
  .CEN  (CEN ),
  .CLK  (CLK ),
  .D    (D   ),
  .GWEN (GWEN),
  .Q    (Q   ),
  .WEN  (WEN )
);

//   &Instance("ct_tsmc_spsram_128x144"); @49

// &ModuleEnd; @65
endmodule


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

// &ModuleBeg; @22
module ct_spsram_128x16(
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

input   [6 :0]  A_t0;   
input           CEN_t0; 
input   [15:0]  D_t0;   
input           GWEN_t0; 
output  [15:0]  Q_t0;   
input   [15:0]  WEN_t0; 
wire    [6 :0]  A_t0;   
wire            CEN_t0; 
wire    [15:0]  D_t0;   
wire            GWEN_t0; 
wire    [15:0]  Q_t0;   
wire    [15:0]  WEN_t0; 
assign Q_t0 = '0;

// &Ports; @23
input   [6 :0]  A;   
input           CEN; 
input           CLK; 
input   [15:0]  D;   
input           GWEN; 
input   [15:0]  WEN; 
output  [15:0]  Q;   

// &Regs; @24

// &Wires; @25
wire    [6 :0]  A;   
wire            CEN; 
wire            CLK; 
wire    [15:0]  D;   
wire            GWEN; 
wire    [15:0]  Q;   
wire    [15:0]  WEN; 


//**********************************************************
//                  Parameter Definition
//**********************************************************
parameter ADDR_WIDTH = 7;
parameter DATA_WIDTH = 16;
parameter WE_WIDTH   = 16;

// &Force("bus","Q",DATA_WIDTH-1,0); @34
// &Force("bus","WEN",WE_WIDTH-1,0); @35
// &Force("bus","A",ADDR_WIDTH-1,0); @36
// &Force("bus","D",DATA_WIDTH-1,0); @37

  //********************************************************
  //*                        FPGA memory                   *
  //********************************************************
  //{WEN[15:14],WEN[13:12],WEN[11:10],WEN[ 9: 8],
  // WEN[ 7: 6],WEN[ 5: 4],WEN[ 3: 2],WEN[ 1: 0]}
//   &Instance("ct_f_spsram_128x16"); @45
ct_f_spsram_128x16  x_ct_f_spsram_128x16 (
  .A    (A   ),
  .CEN  (CEN ),
  .CLK  (CLK ),
  .D    (D   ),
  .GWEN (GWEN),
  .Q    (Q   ),
  .WEN  (WEN )
);

//   &Instance("ct_tsmc_spsram_128x16"); @51

// &ModuleEnd; @67
endmodule


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

// &ModuleBeg; @22
module ct_spsram_16384x128(
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

input   [13 :0]  A_t0;   
input            CEN_t0; 
input   [127:0]  D_t0;   
input            GWEN_t0; 
output  [127:0]  Q_t0;   
input   [127:0]  WEN_t0; 
wire    [13 :0]  A_t0;   
wire             CEN_t0; 
wire    [127:0]  D_t0;   
wire             GWEN_t0; 
wire    [127:0]  Q_t0;   
wire    [127:0]  WEN_t0; 
assign Q_t0 = '0;

// &Ports; @23
input   [13 :0]  A;   
input            CEN; 
input            CLK; 
input   [127:0]  D;   
input            GWEN; 
input   [127:0]  WEN; 
output  [127:0]  Q;   

// &Regs; @24

// &Wires; @25
wire    [13 :0]  A;   
wire             CEN; 
wire             CLK; 
wire    [127:0]  D;   
wire             GWEN; 
wire    [127:0]  Q;   
wire    [127:0]  WEN; 


//**********************************************************
//                  Parameter Definition
//**********************************************************
parameter ADDR_WIDTH = 14;
parameter DATA_WIDTH = 128;
parameter WE_WIDTH   = 128;

// &Force("bus","Q",DATA_WIDTH-1,0); @34
// &Force("bus","WEN",WE_WIDTH-1,0); @35
// &Force("bus","A",ADDR_WIDTH-1,0); @36
// &Force("bus","D",DATA_WIDTH-1,0); @37

  //********************************************************
  //*                        FPGA memory                   *
  //********************************************************
//   &Instance("ct_f_spsram_16384x128"); @43
ct_f_spsram_16384x128  x_ct_f_spsram_16384x128 (
  .A    (A   ),
  .CEN  (CEN ),
  .CLK  (CLK ),
  .D    (D   ),
  .GWEN (GWEN),
  .Q    (Q   ),
  .WEN  (WEN )
);

//   &Instance("ct_tsmc_spsram_16384x128"); @49

// &ModuleEnd; @65
endmodule


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

// &ModuleBeg; @22
module ct_spsram_2048x128(
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

input   [10 :0]  A_t0;   
input            CEN_t0; 
input   [127:0]  D_t0;   
input            GWEN_t0; 
output  [127:0]  Q_t0;   
input   [127:0]  WEN_t0; 
wire    [10 :0]  A_t0;   
wire             CEN_t0; 
wire    [127:0]  D_t0;   
wire             GWEN_t0; 
wire    [127:0]  Q_t0;   
wire    [127:0]  WEN_t0; 
assign Q_t0 = '0;

// &Ports; @23
input   [10 :0]  A;   
input            CEN; 
input            CLK; 
input   [127:0]  D;   
input            GWEN; 
input   [127:0]  WEN; 
output  [127:0]  Q;   

// &Regs; @24

// &Wires; @25
wire    [10 :0]  A;   
wire             CEN; 
wire             CLK; 
wire    [127:0]  D;   
wire             GWEN; 
wire    [127:0]  Q;   
wire    [127:0]  WEN; 


//**********************************************************
//                  Parameter Definition
//**********************************************************
parameter ADDR_WIDTH = 11;
parameter DATA_WIDTH = 128;
parameter WE_WIDTH   = 128;

// &Force("bus","Q",DATA_WIDTH-1,0); @34
// &Force("bus","WEN",WE_WIDTH-1,0); @35
// &Force("bus","A",ADDR_WIDTH-1,0); @36
// &Force("bus","D",DATA_WIDTH-1,0); @37

//  //********************************************************
//  //*                        FPGA memory                   *
//  //********************************************************
//   &Instance("ct_f_spsram_2048x128"); @43
ct_f_spsram_2048x128  x_ct_f_spsram_2048x128 (
  .A    (A   ),
  .CEN  (CEN ),
  .CLK  (CLK ),
  .D    (D   ),
  .GWEN (GWEN),
  .Q    (Q   ),
  .WEN  (WEN )
);

//   &Instance("ct_tsmc_spsram_2048x128"); @49

// &ModuleEnd; @65
endmodule


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

// &ModuleBeg; @22
module ct_spsram_2048x144(
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

input   [10 :0]  A_t0;   
input            CEN_t0; 
input   [143:0]  D_t0;   
input            GWEN_t0; 
output  [143:0]  Q_t0;   
input   [143:0]  WEN_t0; 
wire    [10 :0]  A_t0;   
wire             CEN_t0; 
wire    [143:0]  D_t0;   
wire             GWEN_t0; 
wire    [143:0]  Q_t0;   
wire    [143:0]  WEN_t0; 
assign Q_t0 = '0;

// &Ports; @23
input   [10 :0]  A;   
input            CEN; 
input            CLK; 
input   [143:0]  D;   
input            GWEN; 
input   [143:0]  WEN; 
output  [143:0]  Q;   

// &Regs; @24

// &Wires; @25
wire    [10 :0]  A;   
wire             CEN; 
wire             CLK; 
wire    [143:0]  D;   
wire             GWEN; 
wire    [143:0]  Q;   
wire    [143:0]  WEN; 


//**********************************************************
//                  Parameter Definition
//**********************************************************
parameter ADDR_WIDTH = 11;
parameter DATA_WIDTH = 144;
parameter WE_WIDTH   = 144;

// &Force("bus","Q",DATA_WIDTH-1,0); @34
// &Force("bus","WEN",WE_WIDTH-1,0); @35
// &Force("bus","A",ADDR_WIDTH-1,0); @36
// &Force("bus","D",DATA_WIDTH-1,0); @37

  //********************************************************
  //*                        FPGA memory                   *
  //********************************************************
//   &Instance("ct_f_spsram_2048x144"); @43
ct_f_spsram_2048x144  x_ct_f_spsram_2048x144 (
  .A    (A   ),
  .CEN  (CEN ),
  .CLK  (CLK ),
  .D    (D   ),
  .GWEN (GWEN),
  .Q    (Q   ),
  .WEN  (WEN )
);

//   &Instance("ct_tsmc_spsram_2048x144"); @49

// &ModuleEnd; @65
endmodule


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

// &ModuleBeg; @22
module ct_spsram_2048x32(
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

input   [10:0]  A_t0;   
input           CEN_t0; 
input   [31:0]  D_t0;   
input           GWEN_t0; 
output  [31:0]  Q_t0;   
input   [31:0]  WEN_t0; 
wire    [10:0]  A_t0;   
wire            CEN_t0; 
wire    [31:0]  D_t0;   
wire            GWEN_t0; 
wire    [31:0]  Q_t0;   
wire    [31:0]  WEN_t0; 
assign Q_t0 = '0;

// &Ports; @23
input   [10:0]  A;   
input           CEN; 
input           CLK; 
input   [31:0]  D;   
input           GWEN; 
input   [31:0]  WEN; 
output  [31:0]  Q;   

// &Regs; @24

// &Wires; @25
wire    [10:0]  A;   
wire            CEN; 
wire            CLK; 
wire    [31:0]  D;   
wire            GWEN; 
wire    [31:0]  Q;   
wire    [31:0]  WEN; 


//**********************************************************
//                  Parameter Definition
//**********************************************************
parameter ADDR_WIDTH = 11;
parameter DATA_WIDTH = 32;
parameter WE_WIDTH   = 32;

// &Force("bus","Q",DATA_WIDTH-1,0); @34
// &Force("bus","WEN",WE_WIDTH-1,0); @35
// &Force("bus","A",ADDR_WIDTH-1,0); @36
// &Force("bus","D",DATA_WIDTH-1,0); @37

  //********************************************************
  //*                        FPGA memory                   *
  //********************************************************
  //{WEN[31:24],WEN[23:16],WEN[15:8],WEN[7:0]}
//   &Instance("ct_f_spsram_2048x32"); @44
ct_f_spsram_2048x32  x_ct_f_spsram_2048x32 (
  .A    (A   ),
  .CEN  (CEN ),
  .CLK  (CLK ),
  .D    (D   ),
  .GWEN (GWEN),
  .Q    (Q   ),
  .WEN  (WEN )
);

//   &Instance("ct_tsmc_spsram_2048x32"); @50

// &ModuleEnd; @66
endmodule


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

// &ModuleBeg; @22
module ct_spsram_2048x32_split(
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

input   [10:0]  A_t0;   
input           CEN_t0; 
input   [31:0]  D_t0;   
input           GWEN_t0; 
output  [31:0]  Q_t0;   
input   [31:0]  WEN_t0; 
wire    [10:0]  A_t0;   
wire            CEN_t0; 
wire    [31:0]  D_t0;   
wire            GWEN_t0; 
wire    [31:0]  Q_t0;   
wire    [31:0]  WEN_t0; 
assign Q_t0 = '0;

// &Ports; @23
input   [10:0]  A;   
input           CEN; 
input           CLK; 
input   [31:0]  D;   
input           GWEN; 
input   [31:0]  WEN; 
output  [31:0]  Q;   

// &Regs; @24

// &Wires; @25
wire    [10:0]  A;   
wire            CEN; 
wire            CLK; 
wire    [31:0]  D;   
wire            GWEN; 
wire    [31:0]  Q;   
wire    [31:0]  WEN; 


//**********************************************************
//                  Parameter Definition
//**********************************************************
parameter ADDR_WIDTH = 11;
parameter DATA_WIDTH = 32;
parameter WE_WIDTH   = 32;

// &Force("bus","Q",DATA_WIDTH-1,0); @34
// &Force("bus","WEN",WE_WIDTH-1,0); @35
// &Force("bus","A",ADDR_WIDTH-1,0); @36
// &Force("bus","D",DATA_WIDTH-1,0); @37

  //********************************************************
  //*                        FPGA memory                   *
  //********************************************************
  //{WEN[31:24],WEN[23:16],WEN[15:8],WEN[7:0]}
//   &Instance("ct_f_spsram_2048x32"); @44
ct_f_spsram_2048x32  x_ct_f_spsram_2048x32 (
  .A    (A   ),
  .CEN  (CEN ),
  .CLK  (CLK ),
  .D    (D   ),
  .GWEN (GWEN),
  .Q    (Q   ),
  .WEN  (WEN )
);

//   &Instance("ct_tsmc_spsram_2048x32_split"); @50

// &ModuleEnd; @66
endmodule


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

// &ModuleBeg; @22
module ct_spsram_2048x59(
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

input   [10:0]  A_t0;   
input           CEN_t0; 
input   [58:0]  D_t0;   
input           GWEN_t0; 
output  [58:0]  Q_t0;   
input   [58:0]  WEN_t0; 
wire    [10:0]  A_t0;   
wire            CEN_t0; 
wire    [58:0]  D_t0;   
wire            GWEN_t0; 
wire    [58:0]  Q_t0;   
wire    [58:0]  WEN_t0; 
assign Q_t0 = '0;

// &Ports; @23
input   [10:0]  A;   
input           CEN; 
input           CLK; 
input   [58:0]  D;   
input           GWEN; 
input   [58:0]  WEN; 
output  [58:0]  Q;   

// &Regs; @24

// &Wires; @25
wire    [10:0]  A;   
wire            CEN; 
wire            CLK; 
wire    [58:0]  D;   
wire            GWEN; 
wire    [58:0]  Q;   
wire    [58:0]  WEN; 


//**********************************************************
//                  Parameter Definition
//**********************************************************
parameter ADDR_WIDTH = 11;
parameter DATA_WIDTH = 59;
parameter WE_WIDTH   = 59;

// &Force("bus","Q",DATA_WIDTH-1,0); @34
// &Force("bus","WEN",WE_WIDTH-1,0); @35
// &Force("bus","A",ADDR_WIDTH-1,0); @36
// &Force("bus","D",DATA_WIDTH-1,0); @37

  //********************************************************
  //*                        FPGA memory                   *
  //********************************************************
  //{WEN[58],WEN[57:29],WEN[28:0]}
//   &Instance("ct_f_spsram_2048x59"); @44
ct_f_spsram_2048x59  x_ct_f_spsram_2048x59 (
  .A    (A   ),
  .CEN  (CEN ),
  .CLK  (CLK ),
  .D    (D   ),
  .GWEN (GWEN),
  .Q    (Q   ),
  .WEN  (WEN )
);

//   &Instance("ct_f_spsram_2048x59"); @50

// &ModuleEnd; @67
endmodule


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

// &ModuleBeg; @22
module ct_spsram_2048x88(
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

input   [10:0]  A_t0;   
input           CEN_t0; 
input   [87:0]  D_t0;   
input           GWEN_t0; 
output  [87:0]  Q_t0;   
input   [87:0]  WEN_t0; 
wire    [10:0]  A_t0;   
wire            CEN_t0; 
wire    [87:0]  D_t0;   
wire            GWEN_t0; 
wire    [87:0]  Q_t0;   
wire    [87:0]  WEN_t0; 
assign Q_t0 = '0;

// &Ports; @23
input   [10:0]  A;   
input           CEN; 
input           CLK; 
input   [87:0]  D;   
input           GWEN; 
input   [87:0]  WEN; 
output  [87:0]  Q;   

// &Regs; @24

// &Wires; @25
wire    [10:0]  A;   
wire            CEN; 
wire            CLK; 
wire    [87:0]  D;   
wire            GWEN; 
wire    [87:0]  Q;   
wire    [87:0]  WEN; 


//**********************************************************
//                  Parameter Definition
//**********************************************************
parameter ADDR_WIDTH = 11;
parameter DATA_WIDTH = 88;
parameter WE_WIDTH   = 88;

// &Force("bus","Q",DATA_WIDTH-1,0); @34
// &Force("bus","WEN",WE_WIDTH-1,0); @35
// &Force("bus","A",ADDR_WIDTH-1,0); @36
// &Force("bus","D",DATA_WIDTH-1,0); @37

  //********************************************************
  //*                        FPGA memory                   *
  //********************************************************
//   &Instance("ct_f_spsram_2048x88"); @43
ct_f_spsram_2048x88  x_ct_f_spsram_2048x88 (
  .A    (A   ),
  .CEN  (CEN ),
  .CLK  (CLK ),
  .D    (D   ),
  .GWEN (GWEN),
  .Q    (Q   ),
  .WEN  (WEN )
);

//   &Instance("ct_tsmc_spsram_2048x88"); @49

// &ModuleEnd; @65
endmodule


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

// &ModuleBeg; @22
module ct_spsram_256x100(
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

input   [7 :0]  A_t0;   
input           CEN_t0; 
input   [99:0]  D_t0;   
input           GWEN_t0; 
output  [99:0]  Q_t0;   
input   [99:0]  WEN_t0; 
wire    [7 :0]  A_t0;   
wire            CEN_t0; 
wire    [99:0]  D_t0;   
wire            GWEN_t0; 
wire    [99:0]  Q_t0;   
wire    [99:0]  WEN_t0; 
assign Q_t0 = '0;

// &Ports; @23
input   [7 :0]  A;   
input           CEN; 
input           CLK; 
input   [99:0]  D;   
input           GWEN; 
input   [99:0]  WEN; 
output  [99:0]  Q;   

// &Regs; @24

// &Wires; @25
wire    [7 :0]  A;   
wire            CEN; 
wire            CLK; 
wire    [99:0]  D;   
wire            GWEN; 
wire    [99:0]  Q;   
wire    [99:0]  WEN; 


//**********************************************************
//                  Parameter Definition
//**********************************************************
parameter ADDR_WIDTH = 8;
parameter DATA_WIDTH = 100;
parameter WE_WIDTH   = 100;

// &Force("bus","Q",DATA_WIDTH-1,0); @34
// &Force("bus","WEN",WE_WIDTH-1,0); @35
// &Force("bus","A",ADDR_WIDTH-1,0); @36
// &Force("bus","D",DATA_WIDTH-1,0); @37

//  //********************************************************
//  //*                        FPGA memory                   *
//  //********************************************************
//   &Instance("ct_f_spsram_256x100"); @43
ct_f_spsram_256x100  x_ct_f_spsram_256x100 (
  .A    (A   ),
  .CEN  (CEN ),
  .CLK  (CLK ),
  .D    (D   ),
  .GWEN (GWEN),
  .Q    (Q   ),
  .WEN  (WEN )
);

//   &Instance("ct_tsmc_spsram_256x100"); @49

// &ModuleEnd; @65
endmodule


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

// &ModuleBeg; @22
module ct_spsram_256x144(
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

input   [7  :0]  A_t0;   
input            CEN_t0; 
input   [143:0]  D_t0;   
input            GWEN_t0; 
output  [143:0]  Q_t0;   
input   [143:0]  WEN_t0; 
wire    [7  :0]  A_t0;   
wire             CEN_t0; 
wire    [143:0]  D_t0;   
wire             GWEN_t0; 
wire    [143:0]  Q_t0;   
wire    [143:0]  WEN_t0; 
assign Q_t0 = '0;

// &Ports; @23
input   [7  :0]  A;   
input            CEN; 
input            CLK; 
input   [143:0]  D;   
input            GWEN; 
input   [143:0]  WEN; 
output  [143:0]  Q;   

// &Regs; @24

// &Wires; @25
wire    [7  :0]  A;   
wire             CEN; 
wire             CLK; 
wire    [143:0]  D;   
wire             GWEN; 
wire    [143:0]  Q;   
wire    [143:0]  WEN; 


//**********************************************************
//                  Parameter Definition
//**********************************************************
parameter ADDR_WIDTH = 8;
parameter DATA_WIDTH = 144;
parameter WE_WIDTH   = 144;

// &Force("bus","Q",DATA_WIDTH-1,0); @34
// &Force("bus","WEN",WE_WIDTH-1,0); @35
// &Force("bus","A",ADDR_WIDTH-1,0); @36
// &Force("bus","D",DATA_WIDTH-1,0); @37

//  //********************************************************
//  //*                        FPGA memory                   *
//  //********************************************************
//   &Instance("ct_f_spsram_256x144"); @43
ct_f_spsram_256x144  x_ct_f_spsram_256x144 (
  .A    (A   ),
  .CEN  (CEN ),
  .CLK  (CLK ),
  .D    (D   ),
  .GWEN (GWEN),
  .Q    (Q   ),
  .WEN  (WEN )
);

//   &Instance("ct_tsmc_spsram_256x144"); @49

// &ModuleEnd; @65
endmodule


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

// &ModuleBeg; @22
module ct_spsram_256x196(
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

input   [7  :0]  A_t0;   
input            CEN_t0; 
input   [195:0]  D_t0;   
input            GWEN_t0; 
output  [195:0]  Q_t0;   
input   [195:0]  WEN_t0; 
wire    [7  :0]  A_t0;   
wire             CEN_t0; 
wire    [195:0]  D_t0;   
wire             GWEN_t0; 
wire    [195:0]  Q_t0;   
wire    [195:0]  WEN_t0; 
assign Q_t0 = '0;

// &Ports; @23
input   [7  :0]  A;   
input            CEN; 
input            CLK; 
input   [195:0]  D;   
input            GWEN; 
input   [195:0]  WEN; 
output  [195:0]  Q;   

// &Regs; @24

// &Wires; @25
wire    [7  :0]  A;   
wire             CEN; 
wire             CLK; 
wire    [195:0]  D;   
wire             GWEN; 
wire    [195:0]  Q;   
wire    [195:0]  WEN; 


//**********************************************************
//                  Parameter Definition
//**********************************************************
parameter ADDR_WIDTH = 8;
parameter DATA_WIDTH = 196;
parameter WE_WIDTH   = 196;

// &Force("bus","Q",DATA_WIDTH-1,0); @34
// &Force("bus","WEN",WE_WIDTH-1,0); @35
// &Force("bus","A",ADDR_WIDTH-1,0); @36
// &Force("bus","D",DATA_WIDTH-1,0); @37

  //********************************************************
  //*                        FPGA memory                   *
  //********************************************************
  //{WEN[111:56],WEN[55:0]}
//   &Instance("ct_f_spsram_256x196"); @44
ct_f_spsram_256x196  x_ct_f_spsram_256x196 (
  .A    (A   ),
  .CEN  (CEN ),
  .CLK  (CLK ),
  .D    (D   ),
  .GWEN (GWEN),
  .Q    (Q   ),
  .WEN  (WEN )
);

//   &Instance("ct_tsmc_spsram_256x196"); @50

// &ModuleEnd; @66
endmodule


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

// &ModuleBeg; @22
module ct_spsram_256x23(
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

input   [7 :0]  A_t0;   
input           CEN_t0; 
input   [22:0]  D_t0;   
input           GWEN_t0; 
output  [22:0]  Q_t0;   
input   [22:0]  WEN_t0; 
wire    [7 :0]  A_t0;   
wire            CEN_t0; 
wire    [22:0]  D_t0;   
wire            GWEN_t0; 
wire    [22:0]  Q_t0;   
wire    [22:0]  WEN_t0; 
assign Q_t0 = '0;

// &Ports; @23
input   [7 :0]  A;   
input           CEN; 
input           CLK; 
input   [22:0]  D;   
input           GWEN; 
input   [22:0]  WEN; 
output  [22:0]  Q;   

// &Regs; @24

// &Wires; @25
wire    [7 :0]  A;   
wire            CEN; 
wire            CLK; 
wire    [22:0]  D;   
wire            GWEN; 
wire    [22:0]  Q;   
wire    [22:0]  WEN; 


//**********************************************************
//                  Parameter Definition
//**********************************************************
parameter ADDR_WIDTH = 8;
parameter DATA_WIDTH = 23;
parameter WE_WIDTH   = 23;

// &Force("bus","Q",DATA_WIDTH-1,0); @34
// &Force("bus","WEN",WE_WIDTH-1,0); @35
// &Force("bus","A",ADDR_WIDTH-1,0); @36
// &Force("bus","D",DATA_WIDTH-1,0); @37

  //********************************************************
  //*                        FPGA memory                   *
  //********************************************************
  //{WEN[20:0]}
//   &Instance("ct_f_spsram_256x23"); @44
ct_f_spsram_256x23  x_ct_f_spsram_256x23 (
  .A    (A   ),
  .CEN  (CEN ),
  .CLK  (CLK ),
  .D    (D   ),
  .GWEN (GWEN),
  .Q    (Q   ),
  .WEN  (WEN )
);

//   &Instance("ct_tsmc_spsram_256x23"); @50

// &ModuleEnd; @66
endmodule


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

// &ModuleBeg; @22
module ct_spsram_256x52(
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

input   [7 :0]  A_t0;   
input           CEN_t0; 
input   [51:0]  D_t0;   
input           GWEN_t0; 
output  [51:0]  Q_t0;   
input   [51:0]  WEN_t0; 
wire    [7 :0]  A_t0;   
wire            CEN_t0; 
wire    [51:0]  D_t0;   
wire            GWEN_t0; 
wire    [51:0]  Q_t0;   
wire    [51:0]  WEN_t0; 
assign Q_t0 = '0;

// &Ports; @23
input   [7 :0]  A;   
input           CEN; 
input           CLK; 
input   [51:0]  D;   
input           GWEN; 
input   [51:0]  WEN; 
output  [51:0]  Q;   

// &Regs; @24

// &Wires; @25
wire    [7 :0]  A;   
wire            CEN; 
wire            CLK; 
wire    [51:0]  D;   
wire            GWEN; 
wire    [51:0]  Q;   
wire    [51:0]  WEN; 


//**********************************************************
//                  Parameter Definition
//**********************************************************
parameter ADDR_WIDTH = 8;
parameter DATA_WIDTH = 52;
parameter WE_WIDTH   = 52;

// &Force("bus","Q",DATA_WIDTH-1,0); @34
// &Force("bus","WEN",WE_WIDTH-1,0); @35
// &Force("bus","A",ADDR_WIDTH-1,0); @36
// &Force("bus","D",DATA_WIDTH-1,0); @37

  //********************************************************
  //*                        FPGA memory                   *
  //********************************************************

//   &Instance("ct_f_spsram_256x52"); @44
ct_f_spsram_256x52  x_ct_f_spsram_256x52 (
  .A    (A   ),
  .CEN  (CEN ),
  .CLK  (CLK ),
  .D    (D   ),
  .GWEN (GWEN),
  .Q    (Q   ),
  .WEN  (WEN )
);

//   &Instance("ct_tsmc_spsram_256x52"); @51

// &ModuleEnd; @67
endmodule


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

// &ModuleBeg; @22
module ct_spsram_256x54(
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

input   [7 :0]  A_t0;   
input           CEN_t0; 
input   [53:0]  D_t0;   
input           GWEN_t0; 
output  [53:0]  Q_t0;   
input   [53:0]  WEN_t0; 
wire    [7 :0]  A_t0;   
wire            CEN_t0; 
wire    [53:0]  D_t0;   
wire            GWEN_t0; 
wire    [53:0]  Q_t0;   
wire    [53:0]  WEN_t0; 
assign Q_t0 = '0;

// &Ports; @23
input   [7 :0]  A;   
input           CEN; 
input           CLK; 
input   [53:0]  D;   
input           GWEN; 
input   [53:0]  WEN; 
output  [53:0]  Q;   

// &Regs; @24

// &Wires; @25
wire    [7 :0]  A;   
wire            CEN; 
wire            CLK; 
wire    [53:0]  D;   
wire            GWEN; 
wire    [53:0]  Q;   
wire    [53:0]  WEN; 


//**********************************************************
//                  Parameter Definition
//**********************************************************
parameter ADDR_WIDTH = 8;
parameter DATA_WIDTH = 54;
parameter WE_WIDTH   = 54;

// &Force("bus","Q",DATA_WIDTH-1,0); @34
// &Force("bus","WEN",WE_WIDTH-1,0); @35
// &Force("bus","A",ADDR_WIDTH-1,0); @36
// &Force("bus","D",DATA_WIDTH-1,0); @37

  //********************************************************
  //*                        FPGA memory                   *
  //********************************************************

//   &Instance("ct_f_spsram_256x54"); @44
ct_f_spsram_256x54  x_ct_f_spsram_256x54 (
  .A    (A   ),
  .CEN  (CEN ),
  .CLK  (CLK ),
  .D    (D   ),
  .GWEN (GWEN),
  .Q    (Q   ),
  .WEN  (WEN )
);

//   &Instance("ct_tsmc_spsram_256x54"); @51

// &ModuleEnd; @67
endmodule


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

// &ModuleBeg; @22
module ct_spsram_256x59(
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

input   [7 :0]  A_t0;   
input           CEN_t0; 
input   [58:0]  D_t0;   
input           GWEN_t0; 
output  [58:0]  Q_t0;   
input   [58:0]  WEN_t0; 
wire    [7 :0]  A_t0;   
wire            CEN_t0; 
wire    [58:0]  D_t0;   
wire            GWEN_t0; 
wire    [58:0]  Q_t0;   
wire    [58:0]  WEN_t0; 
assign Q_t0 = '0;

// &Ports; @23
input   [7 :0]  A;   
input           CEN; 
input           CLK; 
input   [58:0]  D;   
input           GWEN; 
input   [58:0]  WEN; 
output  [58:0]  Q;   

// &Regs; @24

// &Wires; @25
wire    [7 :0]  A;   
wire            CEN; 
wire            CLK; 
wire    [58:0]  D;   
wire            GWEN; 
wire    [58:0]  Q;   
wire    [58:0]  WEN; 


//**********************************************************
//                  Parameter Definition
//**********************************************************
parameter ADDR_WIDTH = 8;
parameter DATA_WIDTH = 59;
parameter WE_WIDTH   = 59;

// &Force("bus","Q",DATA_WIDTH-1,0); @34
// &Force("bus","WEN",WE_WIDTH-1,0); @35
// &Force("bus","A",ADDR_WIDTH-1,0); @36
// &Force("bus","D",DATA_WIDTH-1,0); @37

  //********************************************************
  //*                        FPGA memory                   *
  //********************************************************
  //{WEN[58],WEN[57:29],WEN[28:0]}
//   &Instance("ct_f_spsram_256x59"); @44
ct_f_spsram_256x59  x_ct_f_spsram_256x59 (
  .A    (A   ),
  .CEN  (CEN ),
  .CLK  (CLK ),
  .D    (D   ),
  .GWEN (GWEN),
  .Q    (Q   ),
  .WEN  (WEN )
);

//   &Instance("ct_tsmc_spsram_256x59"); @50

// &ModuleEnd; @66
endmodule


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

// &ModuleBeg; @22
module ct_spsram_256x7(
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

input   [7:0]  A_t0;   
input          CEN_t0; 
input   [6:0]  D_t0;   
input          GWEN_t0; 
output  [6:0]  Q_t0;   
input   [6:0]  WEN_t0; 
wire    [7:0]  A_t0;   
wire           CEN_t0; 
wire    [6:0]  D_t0;   
wire           GWEN_t0; 
wire    [6:0]  Q_t0;   
wire    [6:0]  WEN_t0; 
assign Q_t0 = '0;

// &Ports; @23
input   [7:0]  A;   
input          CEN; 
input          CLK; 
input   [6:0]  D;   
input          GWEN; 
input   [6:0]  WEN; 
output  [6:0]  Q;   

// &Regs; @24

// &Wires; @25
wire    [7:0]  A;   
wire           CEN; 
wire           CLK; 
wire    [6:0]  D;   
wire           GWEN; 
wire    [6:0]  Q;   
wire    [6:0]  WEN; 


//**********************************************************
//                  Parameter Definition
//**********************************************************
parameter ADDR_WIDTH = 8;
parameter DATA_WIDTH = 7;
parameter WE_WIDTH   = 7;

// &Force("bus","Q",DATA_WIDTH-1,0); @34
// &Force("bus","WEN",WE_WIDTH-1,0); @35
// &Force("bus","A",ADDR_WIDTH-1,0); @36
// &Force("bus","D",DATA_WIDTH-1,0); @37

  //********************************************************
  //*                        FPGA memory                   *
  //********************************************************
  //{WEN[6],WEN[5],WEN[4],WEN[3],WEN[2],WEN[1],WEN[0]}
//   &Instance("ct_f_spsram_256x7"); @44
ct_f_spsram_256x7  x_ct_f_spsram_256x7 (
  .A    (A   ),
  .CEN  (CEN ),
  .CLK  (CLK ),
  .D    (D   ),
  .GWEN (GWEN),
  .Q    (Q   ),
  .WEN  (WEN )
);

//   &Instance("ct_tsmc_spsram_256x7"); @50

// &ModuleEnd; @66
endmodule


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

// &ModuleBeg; @22
module ct_spsram_256x84(
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

input   [7 :0]  A_t0;   
input           CEN_t0; 
input   [83:0]  D_t0;   
input           GWEN_t0; 
output  [83:0]  Q_t0;   
input   [83:0]  WEN_t0; 
wire    [7 :0]  A_t0;   
wire            CEN_t0; 
wire    [83:0]  D_t0;   
wire            GWEN_t0; 
wire    [83:0]  Q_t0;   
wire    [83:0]  WEN_t0; 
assign Q_t0 = '0;

// &Ports; @23
input   [7 :0]  A;   
input           CEN; 
input           CLK; 
input   [83:0]  D;   
input           GWEN; 
input   [83:0]  WEN; 
output  [83:0]  Q;   

// &Regs; @24

// &Wires; @25
wire    [7 :0]  A;   
wire            CEN; 
wire            CLK; 
wire    [83:0]  D;   
wire            GWEN; 
wire    [83:0]  Q;   
wire    [83:0]  WEN; 


//**********************************************************
//                  Parameter Definition
//**********************************************************
parameter ADDR_WIDTH = 8;
parameter DATA_WIDTH = 84;
parameter WE_WIDTH   = 84;

// &Force("bus","Q",DATA_WIDTH-1,0); @34
// &Force("bus","WEN",WE_WIDTH-1,0); @35
// &Force("bus","A",ADDR_WIDTH-1,0); @36
// &Force("bus","D",DATA_WIDTH-1,0); @37

  //********************************************************
  //*                        FPGA memory                   *
  //********************************************************
  //{WEN[135:132],WEN[131:99],WEN[98:66],WEN[65:33],WEN[32:0]}
//   &Instance("ct_f_spsram_256x84"); @44
ct_f_spsram_256x84  x_ct_f_spsram_256x84 (
  .A    (A   ),
  .CEN  (CEN ),
  .CLK  (CLK ),
  .D    (D   ),
  .GWEN (GWEN),
  .Q    (Q   ),
  .WEN  (WEN )
);

//   &Instance("ct_tsmc_spsram_256x84"); @50

// &ModuleEnd; @66
endmodule


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

// &ModuleBeg; @22
module ct_spsram_32768x128(
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

input   [14 :0]  A_t0;   
input            CEN_t0; 
input   [127:0]  D_t0;   
input            GWEN_t0; 
output  [127:0]  Q_t0;   
input   [127:0]  WEN_t0; 
wire    [14 :0]  A_t0;   
wire             CEN_t0; 
wire    [127:0]  D_t0;   
wire             GWEN_t0; 
wire    [127:0]  Q_t0;   
wire    [127:0]  WEN_t0; 
assign Q_t0 = '0;

// &Ports; @23
input   [14 :0]  A;   
input            CEN; 
input            CLK; 
input   [127:0]  D;   
input            GWEN; 
input   [127:0]  WEN; 
output  [127:0]  Q;   

// &Regs; @24

// &Wires; @25
wire    [14 :0]  A;   
wire             CEN; 
wire             CLK; 
wire    [127:0]  D;   
wire             GWEN; 
wire    [127:0]  Q;   
wire    [127:0]  WEN; 


//**********************************************************
//                  Parameter Definition
//**********************************************************
parameter ADDR_WIDTH = 15;
parameter DATA_WIDTH = 128;
parameter WE_WIDTH   = 128;

// &Force("bus","Q",DATA_WIDTH-1,0); @34
// &Force("bus","WEN",WE_WIDTH-1,0); @35
// &Force("bus","A",ADDR_WIDTH-1,0); @36
// &Force("bus","D",DATA_WIDTH-1,0); @37

  //********************************************************
  //*                        FPGA memory                   *
  //********************************************************
//   &Instance("ct_f_spsram_32768x128"); @43
ct_f_spsram_32768x128  x_ct_f_spsram_32768x128 (
  .A    (A   ),
  .CEN  (CEN ),
  .CLK  (CLK ),
  .D    (D   ),
  .GWEN (GWEN),
  .Q    (Q   ),
  .WEN  (WEN )
);

//   &Instance("ct_tsmc_spsram_32768x128"); @49

// &ModuleEnd; @65
endmodule


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

// &ModuleBeg; @22
module ct_spsram_4096x128(
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

input   [11 :0]  A_t0;   
input            CEN_t0; 
input   [127:0]  D_t0;   
input            GWEN_t0; 
output  [127:0]  Q_t0;   
input   [127:0]  WEN_t0; 
wire    [11 :0]  A_t0;   
wire             CEN_t0; 
wire    [127:0]  D_t0;   
wire             GWEN_t0; 
wire    [127:0]  Q_t0;   
wire    [127:0]  WEN_t0; 
assign Q_t0 = '0;

// &Ports; @23
input   [11 :0]  A;   
input            CEN; 
input            CLK; 
input   [127:0]  D;   
input            GWEN; 
input   [127:0]  WEN; 
output  [127:0]  Q;   

// &Regs; @24

// &Wires; @25
wire    [11 :0]  A;   
wire             CEN; 
wire             CLK; 
wire    [127:0]  D;   
wire             GWEN; 
wire    [127:0]  Q;   
wire    [127:0]  WEN; 


//**********************************************************
//                  Parameter Definition
//**********************************************************
parameter ADDR_WIDTH = 12;
parameter DATA_WIDTH = 128;
parameter WE_WIDTH   = 128;

// &Force("bus","Q",DATA_WIDTH-1,0); @34
// &Force("bus","WEN",WE_WIDTH-1,0); @35
// &Force("bus","A",ADDR_WIDTH-1,0); @36
// &Force("bus","D",DATA_WIDTH-1,0); @37

//  //********************************************************
//  //*                        FPGA memory                   *
//  //********************************************************
//   &Instance("ct_f_spsram_4096x128"); @43
ct_f_spsram_4096x128  x_ct_f_spsram_4096x128 (
  .A    (A   ),
  .CEN  (CEN ),
  .CLK  (CLK ),
  .D    (D   ),
  .GWEN (GWEN),
  .Q    (Q   ),
  .WEN  (WEN )
);

//   &Instance("ct_tsmc_spsram_4096x128"); @49

// &ModuleEnd; @65
endmodule


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

// &ModuleBeg; @22
module ct_spsram_4096x144(
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

input   [11 :0]  A_t0;   
input            CEN_t0; 
input   [143:0]  D_t0;   
input            GWEN_t0; 
output  [143:0]  Q_t0;   
input   [143:0]  WEN_t0; 
wire    [11 :0]  A_t0;   
wire             CEN_t0; 
wire    [143:0]  D_t0;   
wire             GWEN_t0; 
wire    [143:0]  Q_t0;   
wire    [143:0]  WEN_t0; 
assign Q_t0 = '0;

// &Ports; @23
input   [11 :0]  A;   
input            CEN; 
input            CLK; 
input   [143:0]  D;   
input            GWEN; 
input   [143:0]  WEN; 
output  [143:0]  Q;   

// &Regs; @24

// &Wires; @25
wire    [11 :0]  A;   
wire             CEN; 
wire             CLK; 
wire    [143:0]  D;   
wire             GWEN; 
wire    [143:0]  Q;   
wire    [143:0]  WEN; 


//**********************************************************
//                  Parameter Definition
//**********************************************************
parameter ADDR_WIDTH = 12;
parameter DATA_WIDTH = 144;
parameter WE_WIDTH   = 144;

// &Force("bus","Q",DATA_WIDTH-1,0); @34
// &Force("bus","WEN",WE_WIDTH-1,0); @35
// &Force("bus","A",ADDR_WIDTH-1,0); @36
// &Force("bus","D",DATA_WIDTH-1,0); @37

  //********************************************************
  //*                        FPGA memory                   *
  //********************************************************
//   &Instance("ct_f_spsram_4096x144"); @43
ct_f_spsram_4096x144  x_ct_f_spsram_4096x144 (
  .A    (A   ),
  .CEN  (CEN ),
  .CLK  (CLK ),
  .D    (D   ),
  .GWEN (GWEN),
  .Q    (Q   ),
  .WEN  (WEN )
);

//   &Instance("ct_tsmc_spsram_4096x144"); @49

// &ModuleEnd; @65
endmodule


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

// &ModuleBeg; @22
module ct_spsram_4096x32(
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

input   [11:0]  A_t0;   
input           CEN_t0; 
input   [31:0]  D_t0;   
input           GWEN_t0; 
output  [31:0]  Q_t0;   
input   [31:0]  WEN_t0; 
wire    [11:0]  A_t0;   
wire            CEN_t0; 
wire    [31:0]  D_t0;   
wire            GWEN_t0; 
wire    [31:0]  Q_t0;   
wire    [31:0]  WEN_t0; 
assign Q_t0 = '0;

// &Ports; @23
input   [11:0]  A;   
input           CEN; 
input           CLK; 
input   [31:0]  D;   
input           GWEN; 
input   [31:0]  WEN; 
output  [31:0]  Q;   

// &Regs; @24

// &Wires; @25
wire    [11:0]  A;   
wire            CEN; 
wire            CLK; 
wire    [31:0]  D;   
wire            GWEN; 
wire    [31:0]  Q;   
wire    [31:0]  WEN; 


//**********************************************************
//                  Parameter Definition
//**********************************************************
parameter ADDR_WIDTH = 12;
parameter DATA_WIDTH = 32;
parameter WE_WIDTH   = 32;

// &Force("bus","Q",DATA_WIDTH-1,0); @34
// &Force("bus","WEN",WE_WIDTH-1,0); @35
// &Force("bus","A",ADDR_WIDTH-1,0); @36
// &Force("bus","D",DATA_WIDTH-1,0); @37

  //********************************************************
  //*                        FPGA memory                   *
  //********************************************************
  //{WEN[31:24],WEN[23:16],WEN[15:8],WEN[7:0]}
//   &Instance("ct_f_spsram_4096x32"); @44
ct_f_spsram_4096x32  x_ct_f_spsram_4096x32 (
  .A    (A   ),
  .CEN  (CEN ),
  .CLK  (CLK ),
  .D    (D   ),
  .GWEN (GWEN),
  .Q    (Q   ),
  .WEN  (WEN )
);

//   &Instance("ct_tsmc_spsram_1024x32"); @50

// &ModuleEnd; @66
endmodule


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

// &ModuleBeg; @22
module ct_spsram_4096x84(
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

input   [11:0]  A_t0;   
input           CEN_t0; 
input   [83:0]  D_t0;   
input           GWEN_t0; 
output  [83:0]  Q_t0;   
input   [83:0]  WEN_t0; 
wire    [11:0]  A_t0;   
wire            CEN_t0; 
wire    [83:0]  D_t0;   
wire            GWEN_t0; 
wire    [83:0]  Q_t0;   
wire    [83:0]  WEN_t0; 
assign Q_t0 = '0;

// &Ports; @23
input   [11:0]  A;   
input           CEN; 
input           CLK; 
input   [83:0]  D;   
input           GWEN; 
input   [83:0]  WEN; 
output  [83:0]  Q;   

// &Regs; @24

// &Wires; @25
wire    [11:0]  A;   
wire            CEN; 
wire            CLK; 
wire    [83:0]  D;   
wire            GWEN; 
wire    [83:0]  Q;   
wire    [83:0]  WEN; 


//**********************************************************
//                  Parameter Definition
//**********************************************************
parameter ADDR_WIDTH = 12;
parameter DATA_WIDTH = 84;
parameter WE_WIDTH   = 84;

// &Force("bus","Q",DATA_WIDTH-1,0); @34
// &Force("bus","WEN",WE_WIDTH-1,0); @35
// &Force("bus","A",ADDR_WIDTH-1,0); @36
// &Force("bus","D",DATA_WIDTH-1,0); @37

//  //********************************************************
//  //*                        FPGA memory                   *
//  //********************************************************
//   &Instance("ct_f_spsram_4096x84"); @43
ct_f_spsram_4096x84  x_ct_f_spsram_4096x84 (
  .A    (A   ),
  .CEN  (CEN ),
  .CLK  (CLK ),
  .D    (D   ),
  .GWEN (GWEN),
  .Q    (Q   ),
  .WEN  (WEN )
);

//   &Instance("ct_tsmc_spsram_4096x84"); @49

// &ModuleEnd; @65
endmodule


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

// &ModuleBeg; @22
module ct_spsram_512x144(
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

input   [8  :0]  A_t0;   
input            CEN_t0; 
input   [143:0]  D_t0;   
input            GWEN_t0; 
output  [143:0]  Q_t0;   
input   [143:0]  WEN_t0; 
wire    [8  :0]  A_t0;   
wire             CEN_t0; 
wire    [143:0]  D_t0;   
wire             GWEN_t0; 
wire    [143:0]  Q_t0;   
wire    [143:0]  WEN_t0; 
assign Q_t0 = '0;

// &Ports; @23
input   [8  :0]  A;   
input            CEN; 
input            CLK; 
input   [143:0]  D;   
input            GWEN; 
input   [143:0]  WEN; 
output  [143:0]  Q;   

// &Regs; @24

// &Wires; @25
wire    [8  :0]  A;   
wire             CEN; 
wire             CLK; 
wire    [143:0]  D;   
wire             GWEN; 
wire    [143:0]  Q;   
wire    [143:0]  WEN; 


//**********************************************************
//                  Parameter Definition
//**********************************************************
parameter ADDR_WIDTH = 9;
parameter DATA_WIDTH = 144;
parameter WE_WIDTH   = 144;

// &Force("bus","Q",DATA_WIDTH-1,0); @34
// &Force("bus","WEN",WE_WIDTH-1,0); @35
// &Force("bus","A",ADDR_WIDTH-1,0); @36
// &Force("bus","D",DATA_WIDTH-1,0); @37

  //********************************************************
  //*                        FPGA memory                   *
  //********************************************************
//   &Instance("ct_f_spsram_512x144"); @43
ct_f_spsram_512x144  x_ct_f_spsram_512x144 (
  .A    (A   ),
  .CEN  (CEN ),
  .CLK  (CLK ),
  .D    (D   ),
  .GWEN (GWEN),
  .Q    (Q   ),
  .WEN  (WEN )
);

//   &Instance("ct_tsmc_spsram_512x144"); @49

// &ModuleEnd; @65
endmodule


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

// &ModuleBeg; @22
module ct_spsram_512x22(
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

input   [8 :0]  A_t0;   
input           CEN_t0; 
input   [21:0]  D_t0;   
input           GWEN_t0; 
output  [21:0]  Q_t0;   
input   [21:0]  WEN_t0; 
wire    [8 :0]  A_t0;   
wire            CEN_t0; 
wire    [21:0]  D_t0;   
wire            GWEN_t0; 
wire    [21:0]  Q_t0;   
wire    [21:0]  WEN_t0; 
assign Q_t0 = '0;

// &Ports; @23
input   [8 :0]  A;   
input           CEN; 
input           CLK; 
input   [21:0]  D;   
input           GWEN; 
input   [21:0]  WEN; 
output  [21:0]  Q;   

// &Regs; @24

// &Wires; @25
wire    [8 :0]  A;   
wire            CEN; 
wire            CLK; 
wire    [21:0]  D;   
wire            GWEN; 
wire    [21:0]  Q;   
wire    [21:0]  WEN; 


//**********************************************************
//                  Parameter Definition
//**********************************************************
parameter ADDR_WIDTH = 9;
parameter DATA_WIDTH = 22;
parameter WE_WIDTH   = 22;

// &Force("bus","Q",DATA_WIDTH-1,0); @34
// &Force("bus","WEN",WE_WIDTH-1,0); @35
// &Force("bus","A",ADDR_WIDTH-1,0); @36
// &Force("bus","D",DATA_WIDTH-1,0); @37

  //********************************************************
  //*                        FPGA memory                   *
  //********************************************************
  //{WEN[21:11],WEN[10:0]}
//   &Instance("ct_f_spsram_512x22"); @44
ct_f_spsram_512x22  x_ct_f_spsram_512x22 (
  .A    (A   ),
  .CEN  (CEN ),
  .CLK  (CLK ),
  .D    (D   ),
  .GWEN (GWEN),
  .Q    (Q   ),
  .WEN  (WEN )
);

//   &Instance("ct_tsmc_spsram_512x22"); @50

// &ModuleEnd; @66
endmodule


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

// &ModuleBeg; @22
module ct_spsram_512x44(
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

input   [8 :0]  A_t0;   
input           CEN_t0; 
input   [43:0]  D_t0;   
input           GWEN_t0; 
output  [43:0]  Q_t0;   
input   [43:0]  WEN_t0; 
wire    [8 :0]  A_t0;   
wire            CEN_t0; 
wire    [43:0]  D_t0;   
wire            GWEN_t0; 
wire    [43:0]  Q_t0;   
wire    [43:0]  WEN_t0; 
assign Q_t0 = '0;

// &Ports; @23
input   [8 :0]  A;   
input           CEN; 
input           CLK; 
input   [43:0]  D;   
input           GWEN; 
input   [43:0]  WEN; 
output  [43:0]  Q;   

// &Regs; @24

// &Wires; @25
wire    [8 :0]  A;   
wire            CEN; 
wire            CLK; 
wire    [43:0]  D;   
wire            GWEN; 
wire    [43:0]  Q;   
wire    [43:0]  WEN; 


//**********************************************************
//                  Parameter Definition
//**********************************************************
parameter ADDR_WIDTH = 9;
parameter DATA_WIDTH = 44;
parameter WE_WIDTH   = 44;

// &Force("bus","Q",DATA_WIDTH-1,0); @34
// &Force("bus","WEN",WE_WIDTH-1,0); @35
// &Force("bus","A",ADDR_WIDTH-1,0); @36
// &Force("bus","D",DATA_WIDTH-1,0); @37

  //********************************************************
  //*                        FPGA memory                   *
  //********************************************************
  //{WEN[43,22],WEN[21:0}}
//   &Instance("ct_f_spsram_512x44"); @44
ct_f_spsram_512x44  x_ct_f_spsram_512x44 (
  .A    (A   ),
  .CEN  (CEN ),
  .CLK  (CLK ),
  .D    (D   ),
  .GWEN (GWEN),
  .Q    (Q   ),
  .WEN  (WEN )
);

//   &Instance("ct_tsmc_spsram_512x44"); @50

// &ModuleEnd; @66
endmodule


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

// &ModuleBeg; @22
module ct_spsram_512x52(
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

input   [8 :0]  A_t0;   
input           CEN_t0; 
input   [51:0]  D_t0;   
input           GWEN_t0; 
output  [51:0]  Q_t0;   
input   [51:0]  WEN_t0; 
wire    [8 :0]  A_t0;   
wire            CEN_t0; 
wire    [51:0]  D_t0;   
wire            GWEN_t0; 
wire    [51:0]  Q_t0;   
wire    [51:0]  WEN_t0; 
assign Q_t0 = '0;

// &Ports; @23
input   [8 :0]  A;   
input           CEN; 
input           CLK; 
input   [51:0]  D;   
input           GWEN; 
input   [51:0]  WEN; 
output  [51:0]  Q;   

// &Regs; @24

// &Wires; @25
wire    [8 :0]  A;   
wire            CEN; 
wire            CLK; 
wire    [51:0]  D;   
wire            GWEN; 
wire    [51:0]  Q;   
wire    [51:0]  WEN; 


//**********************************************************
//                  Parameter Definition
//**********************************************************
parameter ADDR_WIDTH = 9;
parameter DATA_WIDTH = 52;
parameter WE_WIDTH   = 52;

// &Force("bus","Q",DATA_WIDTH-1,0); @34
// &Force("bus","WEN",WE_WIDTH-1,0); @35
// &Force("bus","A",ADDR_WIDTH-1,0); @36
// &Force("bus","D",DATA_WIDTH-1,0); @37

  //********************************************************
  //*                        FPGA memory                   *
  //********************************************************
  //{WEN[35:18],WEN[17:0]}
//   &Instance("ct_f_spsram_512x52"); @44
ct_f_spsram_512x52  x_ct_f_spsram_512x52 (
  .A    (A   ),
  .CEN  (CEN ),
  .CLK  (CLK ),
  .D    (D   ),
  .GWEN (GWEN),
  .Q    (Q   ),
  .WEN  (WEN )
);

//   &Instance("ct_tsmc_spsram_512x52"); @50

// &ModuleEnd; @66
endmodule


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

// &ModuleBeg; @22
module ct_spsram_512x54(
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

input   [8 :0]  A_t0;   
input           CEN_t0; 
input   [53:0]  D_t0;   
input           GWEN_t0; 
output  [53:0]  Q_t0;   
input   [53:0]  WEN_t0; 
wire    [8 :0]  A_t0;   
wire            CEN_t0; 
wire    [53:0]  D_t0;   
wire            GWEN_t0; 
wire    [53:0]  Q_t0;   
wire    [53:0]  WEN_t0; 
assign Q_t0 = '0;

// &Ports; @23
input   [8 :0]  A;   
input           CEN; 
input           CLK; 
input   [53:0]  D;   
input           GWEN; 
input   [53:0]  WEN; 
output  [53:0]  Q;   

// &Regs; @24

// &Wires; @25
wire    [8 :0]  A;   
wire            CEN; 
wire            CLK; 
wire    [53:0]  D;   
wire            GWEN; 
wire    [53:0]  Q;   
wire    [53:0]  WEN; 


//**********************************************************
//                  Parameter Definition
//**********************************************************
parameter ADDR_WIDTH = 9;
parameter DATA_WIDTH = 54;
parameter WE_WIDTH   = 54;

// &Force("bus","Q",DATA_WIDTH-1,0); @34
// &Force("bus","WEN",WE_WIDTH-1,0); @35
// &Force("bus","A",ADDR_WIDTH-1,0); @36
// &Force("bus","D",DATA_WIDTH-1,0); @37

  //********************************************************
  //*                        FPGA memory                   *
  //********************************************************
  //{WEN[37:19],WEN[18:0]}
//   &Instance("ct_f_spsram_512x54"); @44
ct_f_spsram_512x54  x_ct_f_spsram_512x54 (
  .A    (A   ),
  .CEN  (CEN ),
  .CLK  (CLK ),
  .D    (D   ),
  .GWEN (GWEN),
  .Q    (Q   ),
  .WEN  (WEN )
);

//   &Instance("ct_tsmc_spsram_512x54"); @50

// &ModuleEnd; @66
endmodule


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

// &ModuleBeg; @22
module ct_spsram_512x59(
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

input   [8 :0]  A_t0;   
input           CEN_t0; 
input   [58:0]  D_t0;   
input           GWEN_t0; 
output  [58:0]  Q_t0;   
input   [58:0]  WEN_t0; 
wire    [8 :0]  A_t0;   
wire            CEN_t0; 
wire    [58:0]  D_t0;   
wire            GWEN_t0; 
wire    [58:0]  Q_t0;   
wire    [58:0]  WEN_t0; 
assign Q_t0 = '0;

// &Ports; @23
input   [8 :0]  A;   
input           CEN; 
input           CLK; 
input   [58:0]  D;   
input           GWEN; 
input   [58:0]  WEN; 
output  [58:0]  Q;   

// &Regs; @24

// &Wires; @25
wire    [8 :0]  A;   
wire            CEN; 
wire            CLK; 
wire    [58:0]  D;   
wire            GWEN; 
wire    [58:0]  Q;   
wire    [58:0]  WEN; 


//**********************************************************
//                  Parameter Definition
//**********************************************************
parameter ADDR_WIDTH = 9;
parameter DATA_WIDTH = 59;
parameter WE_WIDTH   = 59;

// &Force("bus","Q",DATA_WIDTH-1,0); @34
// &Force("bus","WEN",WE_WIDTH-1,0); @35
// &Force("bus","A",ADDR_WIDTH-1,0); @36
// &Force("bus","D",DATA_WIDTH-1,0); @37

  //********************************************************
  //*                        FPGA memory                   *
  //********************************************************
  //{WEN[58],WEN[57:29],WEN[28:0]}
//   &Instance("ct_f_spsram_512x59"); @44
ct_f_spsram_512x59  x_ct_f_spsram_512x59 (
  .A    (A   ),
  .CEN  (CEN ),
  .CLK  (CLK ),
  .D    (D   ),
  .GWEN (GWEN),
  .Q    (Q   ),
  .WEN  (WEN )
);

//   &Instance("ct_tsmc_spsram_512x59"); @50

// &ModuleEnd; @66
endmodule


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

// &ModuleBeg; @22
module ct_spsram_512x7(
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

input   [8:0]  A_t0;   
input          CEN_t0; 
input   [6:0]  D_t0;   
input          GWEN_t0; 
output  [6:0]  Q_t0;   
input   [6:0]  WEN_t0; 
wire    [8:0]  A_t0;   
wire           CEN_t0; 
wire    [6:0]  D_t0;   
wire           GWEN_t0; 
wire    [6:0]  Q_t0;   
wire    [6:0]  WEN_t0; 
assign Q_t0 = '0;

// &Ports; @23
input   [8:0]  A;   
input          CEN; 
input          CLK; 
input   [6:0]  D;   
input          GWEN; 
input   [6:0]  WEN; 
output  [6:0]  Q;   

// &Regs; @24

// &Wires; @25
wire    [8:0]  A;   
wire           CEN; 
wire           CLK; 
wire    [6:0]  D;   
wire           GWEN; 
wire    [6:0]  Q;   
wire    [6:0]  WEN; 


//**********************************************************
//                  Parameter Definition
//**********************************************************
parameter ADDR_WIDTH = 9;
parameter DATA_WIDTH = 7;
parameter WE_WIDTH   = 7;

// &Force("bus","Q",DATA_WIDTH-1,0); @34
// &Force("bus","WEN",WE_WIDTH-1,0); @35
// &Force("bus","A",ADDR_WIDTH-1,0); @36
// &Force("bus","D",DATA_WIDTH-1,0); @37

  //********************************************************
  //*                        FPGA memory                   *
  //********************************************************
  //{WEN[6],WEN[5],WEN[4],WEN[3],WEN[2],WEN[1],WEN[0]}
//   &Instance("ct_f_spsram_512x7"); @44
ct_f_spsram_512x7  x_ct_f_spsram_512x7 (
  .A    (A   ),
  .CEN  (CEN ),
  .CLK  (CLK ),
  .D    (D   ),
  .GWEN (GWEN),
  .Q    (Q   ),
  .WEN  (WEN )
);

//   &Instance("ct_tsmc_spsram_512x7"); @50

// &ModuleEnd; @66
endmodule


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

// &ModuleBeg; @22
module ct_spsram_512x96(
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

input   [8 :0]  A_t0;   
input           CEN_t0; 
input   [95:0]  D_t0;   
input           GWEN_t0; 
output  [95:0]  Q_t0;   
input   [95:0]  WEN_t0; 
wire    [8 :0]  A_t0;   
wire            CEN_t0; 
wire    [95:0]  D_t0;   
wire            GWEN_t0; 
wire    [95:0]  Q_t0;   
wire    [95:0]  WEN_t0; 
assign Q_t0 = '0;

// &Ports; @23
input   [8 :0]  A;   
input           CEN; 
input           CLK; 
input   [95:0]  D;   
input           GWEN; 
input   [95:0]  WEN; 
output  [95:0]  Q;   

// &Regs; @24

// &Wires; @25
wire    [8 :0]  A;   
wire            CEN; 
wire            CLK; 
wire    [95:0]  D;   
wire            GWEN; 
wire    [95:0]  Q;   
wire    [95:0]  WEN; 


//**********************************************************
//                  Parameter Definition
//**********************************************************
parameter ADDR_WIDTH = 9;
parameter DATA_WIDTH = 96;
parameter WE_WIDTH   = 96;

// &Force("bus","Q",DATA_WIDTH-1,0); @34
// &Force("bus","WEN",WE_WIDTH-1,0); @35
// &Force("bus","A",ADDR_WIDTH-1,0); @36
// &Force("bus","D",DATA_WIDTH-1,0); @37

  //********************************************************
  //*                        FPGA memory                   *
  //********************************************************
//   &Instance("ct_f_spsram_512x96"); @43
ct_f_spsram_512x96  x_ct_f_spsram_512x96 (
  .A    (A   ),
  .CEN  (CEN ),
  .CLK  (CLK ),
  .D    (D   ),
  .GWEN (GWEN),
  .Q    (Q   ),
  .WEN  (WEN )
);

//   &Instance("ct_tsmc_spsram_512x96"); @49

// &ModuleEnd; @65
endmodule


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

// &ModuleBeg; @22
module ct_spsram_64x108(
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

input   [5  :0]  A_t0;   
input            CEN_t0; 
input   [107:0]  D_t0;   
input            GWEN_t0; 
output  [107:0]  Q_t0;   
input   [107:0]  WEN_t0; 
wire    [5  :0]  A_t0;   
wire             CEN_t0; 
wire    [107:0]  D_t0;   
wire             GWEN_t0; 
wire    [107:0]  Q_t0;   
wire    [107:0]  WEN_t0; 
assign Q_t0 = '0;

// &Ports; @23
input   [5  :0]  A;   
input            CEN; 
input            CLK; 
input   [107:0]  D;   
input            GWEN; 
input   [107:0]  WEN; 
output  [107:0]  Q;   

// &Regs; @24

// &Wires; @25
wire    [5  :0]  A;   
wire             CEN; 
wire             CLK; 
wire    [107:0]  D;   
wire             GWEN; 
wire    [107:0]  Q;   
wire    [107:0]  WEN; 


//**********************************************************
//                  Parameter Definition
//**********************************************************
parameter ADDR_WIDTH = 6;
parameter DATA_WIDTH = 108;
parameter WE_WIDTH   = 108;

// &Force("bus","Q",DATA_WIDTH-1,0); @34
// &Force("bus","WEN",WE_WIDTH-1,0); @35
// &Force("bus","A",ADDR_WIDTH-1,0); @36
// &Force("bus","D",DATA_WIDTH-1,0); @37

//  //********************************************************
//  //*                        FPGA memory                   *
//  //********************************************************
//   &Instance("ct_f_spsram_64x108"); @43
ct_f_spsram_64x108  x_ct_f_spsram_64x108 (
  .A    (A   ),
  .CEN  (CEN ),
  .CLK  (CLK ),
  .D    (D   ),
  .GWEN (GWEN),
  .Q    (Q   ),
  .WEN  (WEN )
);

//   &Instance("ct_tsmc_spsram_64x108"); @49

// &ModuleEnd; @65
endmodule


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

// &ModuleBeg; @22
module ct_spsram_65536x128(
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

input   [15 :0]  A_t0;   
input            CEN_t0; 
input   [127:0]  D_t0;   
input            GWEN_t0; 
output  [127:0]  Q_t0;   
input   [127:0]  WEN_t0; 
wire    [15 :0]  A_t0;   
wire             CEN_t0; 
wire    [127:0]  D_t0;   
wire             GWEN_t0; 
wire    [127:0]  Q_t0;   
wire    [127:0]  WEN_t0; 
assign Q_t0 = '0;

// &Ports; @23
input   [15 :0]  A;   
input            CEN; 
input            CLK; 
input   [127:0]  D;   
input            GWEN; 
input   [127:0]  WEN; 
output  [127:0]  Q;   

// &Regs; @24

// &Wires; @25
wire    [15 :0]  A;   
wire             CEN; 
wire             CLK; 
wire    [127:0]  D;   
wire             GWEN; 
wire    [127:0]  Q;   
wire    [127:0]  WEN; 


//**********************************************************
//                  Parameter Definition
//**********************************************************
parameter ADDR_WIDTH = 16;
parameter DATA_WIDTH = 128;
parameter WE_WIDTH   = 128;

// &Force("bus","Q",DATA_WIDTH-1,0); @34
// &Force("bus","WEN",WE_WIDTH-1,0); @35
// &Force("bus","A",ADDR_WIDTH-1,0); @36
// &Force("bus","D",DATA_WIDTH-1,0); @37

  //********************************************************
  //*                        FPGA memory                   *
  //********************************************************
//   &Instance("ct_f_spsram_65536x128"); @43
ct_f_spsram_65536x128  x_ct_f_spsram_65536x128 (
  .A    (A   ),
  .CEN  (CEN ),
  .CLK  (CLK ),
  .D    (D   ),
  .GWEN (GWEN),
  .Q    (Q   ),
  .WEN  (WEN )
);

//   &Instance("ct_tsmc_spsram_65536x128"); @49

// &ModuleEnd; @65
endmodule


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

// &ModuleBeg; @22
module ct_spsram_8192x128(
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

input   [12 :0]  A_t0;   
input            CEN_t0; 
input   [127:0]  D_t0;   
input            GWEN_t0; 
output  [127:0]  Q_t0;   
input   [127:0]  WEN_t0; 
wire    [12 :0]  A_t0;   
wire             CEN_t0; 
wire    [127:0]  D_t0;   
wire             GWEN_t0; 
wire    [127:0]  Q_t0;   
wire    [127:0]  WEN_t0; 
assign Q_t0 = '0;

// &Ports; @23
input   [12 :0]  A;   
input            CEN; 
input            CLK; 
input   [127:0]  D;   
input            GWEN; 
input   [127:0]  WEN; 
output  [127:0]  Q;   

// &Regs; @24

// &Wires; @25
wire    [12 :0]  A;   
wire             CEN; 
wire             CLK; 
wire    [127:0]  D;   
wire             GWEN; 
wire    [127:0]  Q;   
wire    [127:0]  WEN; 


//**********************************************************
//                  Parameter Definition
//**********************************************************
parameter ADDR_WIDTH = 13;
parameter DATA_WIDTH = 128;
parameter WE_WIDTH   = 128;

// &Force("bus","Q",DATA_WIDTH-1,0); @34
// &Force("bus","WEN",WE_WIDTH-1,0); @35
// &Force("bus","A",ADDR_WIDTH-1,0); @36
// &Force("bus","D",DATA_WIDTH-1,0); @37

  //********************************************************
  //*                        FPGA memory                   *
  //********************************************************
//   &Instance("ct_f_spsram_8192x128"); @43
ct_f_spsram_8192x128  x_ct_f_spsram_8192x128 (
  .A    (A   ),
  .CEN  (CEN ),
  .CLK  (CLK ),
  .D    (D   ),
  .GWEN (GWEN),
  .Q    (Q   ),
  .WEN  (WEN )
);

//   &Instance("ct_tsmc_spsram_8192x128"); @49

// &ModuleEnd; @65
endmodule


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

// &ModuleBeg; @22
module ct_spsram_8192x32(
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

input   [12:0]  A_t0;   
input           CEN_t0; 
input   [31:0]  D_t0;   
input           GWEN_t0; 
output  [31:0]  Q_t0;   
input   [31:0]  WEN_t0; 
wire    [12:0]  A_t0;   
wire            CEN_t0; 
wire    [31:0]  D_t0;   
wire            GWEN_t0; 
wire    [31:0]  Q_t0;   
wire    [31:0]  WEN_t0; 
assign Q_t0 = '0;

// &Ports; @23
input   [12:0]  A;   
input           CEN; 
input           CLK; 
input   [31:0]  D;   
input           GWEN; 
input   [31:0]  WEN; 
output  [31:0]  Q;   

// &Regs; @24

// &Wires; @25
wire    [12:0]  A;   
wire            CEN; 
wire            CLK; 
wire    [31:0]  D;   
wire            GWEN; 
wire    [31:0]  Q;   
wire    [31:0]  WEN; 


//**********************************************************
//                  Parameter Definition
//**********************************************************
parameter ADDR_WIDTH = 13;
parameter DATA_WIDTH = 32;
parameter WE_WIDTH   = 32;

// &Force("bus","Q",DATA_WIDTH-1,0); @34
// &Force("bus","WEN",WE_WIDTH-1,0); @35
// &Force("bus","A",ADDR_WIDTH-1,0); @36
// &Force("bus","D",DATA_WIDTH-1,0); @37

  //********************************************************
  //*                        FPGA memory                   *
  //********************************************************
  //{WEN[31:24],WEN[23:16],WEN[15:8],WEN[7:0]}
//   &Instance("ct_f_spsram_8192x32"); @44
ct_f_spsram_8192x32  x_ct_f_spsram_8192x32 (
  .A    (A   ),
  .CEN  (CEN ),
  .CLK  (CLK ),
  .D    (D   ),
  .GWEN (GWEN),
  .Q    (Q   ),
  .WEN  (WEN )
);

//   &Instance("ct_tsmc_spsram_1024x32"); @50

// &ModuleEnd; @66
endmodule


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























module f_spsram_large(
A,
A_t0,
CEN,
CEN_t0,
CLK,
D,
D_t0,
Q,
Q_t0,
WEN,
WEN_t0
);

input   [ADDR_WIDTH-1:0]  A_t0;           
input           CEN_t0;         
input   [127:0] D_t0;           
output  [127:0] Q_t0;           
input   [15:0]  WEN_t0;         
wire    [ADDR_WIDTH-1:0]  A_t0;           
wire            CEN_t0;         
wire    [127:0] D_t0;           
wire    [127:0] Q_t0;           
wire    [15:0]  WEN_t0;         
assign Q_t0 = '0;

parameter ADDR_WIDTH = 21;	// 2MB per ram, 16MB at all for f_spsram_large
parameter WRAP_WIDTH = 8;

input   [ADDR_WIDTH-1:0]  A;           
input           CEN;         
input           CLK;         
input   [127:0] D;           
input   [15:0]  WEN;         
output  [127:0] Q;           

reg     [ADDR_WIDTH-1:0]  addr_holding; 


wire    [ADDR_WIDTH-1:0]  A;           
wire            CEN;         
wire            CLK;         
wire    [127:0] D;           
wire    [127:0] Q;           
wire    [15:0]  WEN;         
wire    [ADDR_WIDTH-1:0]  addr;        
wire    [7 :0]  ram0_din;    
wire    [7 :0]  ram0_dout;   
wire            ram0_wen;    
wire    [7 :0]  ram1_din;    
wire    [7 :0]  ram1_dout;   
wire            ram1_wen;    
wire    [7 :0]  ram2_din;    
wire    [7 :0]  ram2_dout;   
wire            ram2_wen;    
wire    [7 :0]  ram3_din;    
wire    [7 :0]  ram3_dout;   
wire            ram3_wen;    
wire    [7 :0]  ram4_din;    
wire    [7 :0]  ram4_dout;   
wire            ram4_wen;    
wire    [7 :0]  ram5_din;    
wire    [7 :0]  ram5_dout;   
wire            ram5_wen;    
wire    [7 :0]  ram6_din;    
wire    [7 :0]  ram6_dout;   
wire            ram6_wen;    
wire    [7 :0]  ram7_din;    
wire    [7 :0]  ram7_dout;   
wire            ram7_wen;    
wire    [7 :0]  ram8_din;    
wire    [7 :0]  ram8_dout;   
wire            ram8_wen;    
wire    [7 :0]  ram9_din;    
wire    [7 :0]  ram9_dout;   
wire            ram9_wen;    
wire    [7 :0]  ram10_din;    
wire    [7 :0]  ram10_dout;   
wire            ram10_wen;    
wire    [7 :0]  ram11_din;    
wire    [7 :0]  ram11_dout;   
wire            ram11_wen;    
wire    [7 :0]  ram12_din;    
wire    [7 :0]  ram12_dout;   
wire            ram12_wen;    
wire    [7 :0]  ram13_din;    
wire    [7 :0]  ram13_dout;   
wire            ram13_wen;    
wire    [7 :0]  ram14_din;    
wire    [7 :0]  ram14_dout;   
wire            ram14_wen;    
wire    [7 :0]  ram15_din;    
wire    [7 :0]  ram15_dout;   
wire            ram15_wen;    







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






assign ram0_din[WRAP_WIDTH-1:0] = D[WRAP_WIDTH-1:0];
assign ram1_din[WRAP_WIDTH-1:0] = D[2*WRAP_WIDTH-1:WRAP_WIDTH];
assign ram2_din[WRAP_WIDTH-1:0] = D[3*WRAP_WIDTH-1:2*WRAP_WIDTH];
assign ram3_din[WRAP_WIDTH-1:0] = D[4*WRAP_WIDTH-1:3*WRAP_WIDTH];
assign ram4_din[WRAP_WIDTH-1:0] = D[5*WRAP_WIDTH-1:4*WRAP_WIDTH];
assign ram5_din[WRAP_WIDTH-1:0] = D[6*WRAP_WIDTH-1:5*WRAP_WIDTH];
assign ram6_din[WRAP_WIDTH-1:0] = D[7*WRAP_WIDTH-1:6*WRAP_WIDTH];
assign ram7_din[WRAP_WIDTH-1:0] = D[8*WRAP_WIDTH-1:7*WRAP_WIDTH];
assign ram8_din[WRAP_WIDTH-1:0] = D[9*WRAP_WIDTH-1:8*WRAP_WIDTH];
assign ram9_din[WRAP_WIDTH-1:0] = D[10*WRAP_WIDTH-1:9*WRAP_WIDTH];
assign ram10_din[WRAP_WIDTH-1:0] = D[11*WRAP_WIDTH-1:10*WRAP_WIDTH];
assign ram11_din[WRAP_WIDTH-1:0] = D[12*WRAP_WIDTH-1:11*WRAP_WIDTH];
assign ram12_din[WRAP_WIDTH-1:0] = D[13*WRAP_WIDTH-1:12*WRAP_WIDTH];
assign ram13_din[WRAP_WIDTH-1:0] = D[14*WRAP_WIDTH-1:13*WRAP_WIDTH];
assign ram14_din[WRAP_WIDTH-1:0] = D[15*WRAP_WIDTH-1:14*WRAP_WIDTH];
assign ram15_din[WRAP_WIDTH-1:0] = D[16*WRAP_WIDTH-1:15*WRAP_WIDTH];


always@(posedge CLK)
begin
  if(!CEN) begin
    addr_holding[ADDR_WIDTH-1:0] <= A[ADDR_WIDTH-1:0];
  end
end

assign addr[ADDR_WIDTH-1:0] = CEN ? addr_holding[ADDR_WIDTH-1:0]
                                  : A[ADDR_WIDTH-1:0];





assign Q[WRAP_WIDTH-1:0]               = ram0_dout[WRAP_WIDTH-1:0];
assign Q[2*WRAP_WIDTH-1:WRAP_WIDTH]    = ram1_dout[WRAP_WIDTH-1:0];
assign Q[3*WRAP_WIDTH-1:2*WRAP_WIDTH]  = ram2_dout[WRAP_WIDTH-1:0];
assign Q[4*WRAP_WIDTH-1:3*WRAP_WIDTH]  = ram3_dout[WRAP_WIDTH-1:0];
assign Q[5*WRAP_WIDTH-1:4*WRAP_WIDTH]  = ram4_dout[WRAP_WIDTH-1:0];
assign Q[6*WRAP_WIDTH-1:5*WRAP_WIDTH]  = ram5_dout[WRAP_WIDTH-1:0];
assign Q[7*WRAP_WIDTH-1:6*WRAP_WIDTH]  = ram6_dout[WRAP_WIDTH-1:0];
assign Q[8*WRAP_WIDTH-1:7*WRAP_WIDTH]  = ram7_dout[WRAP_WIDTH-1:0];
assign Q[9*WRAP_WIDTH-1:8*WRAP_WIDTH]  = ram8_dout[WRAP_WIDTH-1:0];
assign Q[10*WRAP_WIDTH-1:9*WRAP_WIDTH]  = ram9_dout[WRAP_WIDTH-1:0];
assign Q[11*WRAP_WIDTH-1:10*WRAP_WIDTH]  = ram10_dout[WRAP_WIDTH-1:0];
assign Q[12*WRAP_WIDTH-1:11*WRAP_WIDTH]  = ram11_dout[WRAP_WIDTH-1:0];
assign Q[13*WRAP_WIDTH-1:12*WRAP_WIDTH]  = ram12_dout[WRAP_WIDTH-1:0];
assign Q[14*WRAP_WIDTH-1:13*WRAP_WIDTH]  = ram13_dout[WRAP_WIDTH-1:0];
assign Q[15*WRAP_WIDTH-1:14*WRAP_WIDTH]  = ram14_dout[WRAP_WIDTH-1:0];
assign Q[16*WRAP_WIDTH-1:15*WRAP_WIDTH]  = ram15_dout[WRAP_WIDTH-1:0];

ram #(WRAP_WIDTH,ADDR_WIDTH) ram0(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram0_din),
  .PortAWriteEnable(ram0_wen),
  .PortADataOut(ram0_dout));


ram #(WRAP_WIDTH,ADDR_WIDTH) ram1(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram1_din),
  .PortAWriteEnable(ram1_wen),
  .PortADataOut(ram1_dout));

ram #(WRAP_WIDTH,ADDR_WIDTH) ram2(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram2_din),
  .PortAWriteEnable(ram2_wen),
  .PortADataOut(ram2_dout));

ram #(WRAP_WIDTH,ADDR_WIDTH) ram3(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram3_din),
  .PortAWriteEnable(ram3_wen),
  .PortADataOut(ram3_dout));

ram #(WRAP_WIDTH,ADDR_WIDTH) ram4(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram4_din),
  .PortAWriteEnable(ram4_wen),
  .PortADataOut(ram4_dout));


ram #(WRAP_WIDTH,ADDR_WIDTH) ram5(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram5_din),
  .PortAWriteEnable(ram5_wen),
  .PortADataOut(ram5_dout));

ram #(WRAP_WIDTH,ADDR_WIDTH) ram6(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram6_din),
  .PortAWriteEnable(ram6_wen),
  .PortADataOut(ram6_dout));

ram #(WRAP_WIDTH,ADDR_WIDTH) ram7(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram7_din),
  .PortAWriteEnable(ram7_wen),
  .PortADataOut(ram7_dout));

ram #(WRAP_WIDTH,ADDR_WIDTH) ram8(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram8_din),
  .PortAWriteEnable(ram8_wen),
  .PortADataOut(ram8_dout));

ram #(WRAP_WIDTH,ADDR_WIDTH) ram9(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram9_din),
  .PortAWriteEnable(ram9_wen),
  .PortADataOut(ram9_dout));

ram #(WRAP_WIDTH,ADDR_WIDTH) ram10(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram10_din),
  .PortAWriteEnable(ram10_wen),
  .PortADataOut(ram10_dout));

ram #(WRAP_WIDTH,ADDR_WIDTH) ram11(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram11_din),
  .PortAWriteEnable(ram11_wen),
  .PortADataOut(ram11_dout));

ram #(WRAP_WIDTH,ADDR_WIDTH) ram12(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram12_din),
  .PortAWriteEnable(ram12_wen),
  .PortADataOut(ram12_dout));

ram #(WRAP_WIDTH,ADDR_WIDTH) ram13(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram13_din),
  .PortAWriteEnable(ram13_wen),
  .PortADataOut(ram13_dout));

ram #(WRAP_WIDTH,ADDR_WIDTH) ram14(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram14_din),
  .PortAWriteEnable(ram14_wen),
  .PortADataOut(ram14_dout));

ram #(WRAP_WIDTH,ADDR_WIDTH) ram15(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram15_din),
  .PortAWriteEnable(ram15_wen),
  .PortADataOut(ram15_dout));


endmodule


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























module f_spsram_32768x128(
A,
A_t0,
CEN,
CEN_t0,
CLK,
D,
D_t0,
Q,
Q_t0,
WEN,
WEN_t0
);

input   [14:0]  A_t0;           
input           CEN_t0;         
input   [127:0] D_t0;           
output  [127:0] Q_t0;           
input   [15:0]  WEN_t0;         
wire    [14:0]  A_t0;           
wire            CEN_t0;         
wire    [127:0] D_t0;           
wire    [127:0] Q_t0;           
wire    [15:0]  WEN_t0;         
assign Q_t0 = '0;


input   [14:0]  A;           
input           CEN;         
input           CLK;         
input   [127:0] D;           
input   [15:0]  WEN;         
output  [127:0] Q;           


reg     [14:0]  addr_holding; 


wire    [14:0]  A;           
wire            CEN;         
wire            CLK;         
wire    [127:0] D;           
wire    [127:0] Q;           
wire    [15:0]  WEN;         
wire    [14:0]  addr;        
wire    [7 :0]  ram0_din;    
wire    [7 :0]  ram0_dout;   
wire            ram0_wen;    
wire    [7 :0]  ram1_din;    
wire    [7 :0]  ram1_dout;   
wire            ram1_wen;    
wire    [7 :0]  ram2_din;    
wire    [7 :0]  ram2_dout;   
wire            ram2_wen;    
wire    [7 :0]  ram3_din;    
wire    [7 :0]  ram3_dout;   
wire            ram3_wen;    
wire    [7 :0]  ram4_din;    
wire    [7 :0]  ram4_dout;   
wire            ram4_wen;    
wire    [7 :0]  ram5_din;    
wire    [7 :0]  ram5_dout;   
wire            ram5_wen;    
wire    [7 :0]  ram6_din;    
wire    [7 :0]  ram6_dout;   
wire            ram6_wen;    
wire    [7 :0]  ram7_din;    
wire    [7 :0]  ram7_dout;   
wire            ram7_wen;    
wire    [7 :0]  ram8_din;    
wire    [7 :0]  ram8_dout;   
wire            ram8_wen;    
wire    [7 :0]  ram9_din;    
wire    [7 :0]  ram9_dout;   
wire            ram9_wen;    
wire    [7 :0]  ram10_din;    
wire    [7 :0]  ram10_dout;   
wire            ram10_wen;    
wire    [7 :0]  ram11_din;    
wire    [7 :0]  ram11_dout;   
wire            ram11_wen;    
wire    [7 :0]  ram12_din;    
wire    [7 :0]  ram12_dout;   
wire            ram12_wen;    
wire    [7 :0]  ram13_din;    
wire    [7 :0]  ram13_dout;   
wire            ram13_wen;    
wire    [7 :0]  ram14_din;    
wire    [7 :0]  ram14_dout;   
wire            ram14_wen;    
wire    [7 :0]  ram15_din;    
wire    [7 :0]  ram15_dout;   
wire            ram15_wen;    

parameter ADDR_WIDTH = 15;
parameter WRAP_WIDTH = 8;






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






assign ram0_din[WRAP_WIDTH-1:0] = D[WRAP_WIDTH-1:0];
assign ram1_din[WRAP_WIDTH-1:0] = D[2*WRAP_WIDTH-1:WRAP_WIDTH];
assign ram2_din[WRAP_WIDTH-1:0] = D[3*WRAP_WIDTH-1:2*WRAP_WIDTH];
assign ram3_din[WRAP_WIDTH-1:0] = D[4*WRAP_WIDTH-1:3*WRAP_WIDTH];
assign ram4_din[WRAP_WIDTH-1:0] = D[5*WRAP_WIDTH-1:4*WRAP_WIDTH];
assign ram5_din[WRAP_WIDTH-1:0] = D[6*WRAP_WIDTH-1:5*WRAP_WIDTH];
assign ram6_din[WRAP_WIDTH-1:0] = D[7*WRAP_WIDTH-1:6*WRAP_WIDTH];
assign ram7_din[WRAP_WIDTH-1:0] = D[8*WRAP_WIDTH-1:7*WRAP_WIDTH];
assign ram8_din[WRAP_WIDTH-1:0] = D[9*WRAP_WIDTH-1:8*WRAP_WIDTH];
assign ram9_din[WRAP_WIDTH-1:0] = D[10*WRAP_WIDTH-1:9*WRAP_WIDTH];
assign ram10_din[WRAP_WIDTH-1:0] = D[11*WRAP_WIDTH-1:10*WRAP_WIDTH];
assign ram11_din[WRAP_WIDTH-1:0] = D[12*WRAP_WIDTH-1:11*WRAP_WIDTH];
assign ram12_din[WRAP_WIDTH-1:0] = D[13*WRAP_WIDTH-1:12*WRAP_WIDTH];
assign ram13_din[WRAP_WIDTH-1:0] = D[14*WRAP_WIDTH-1:13*WRAP_WIDTH];
assign ram14_din[WRAP_WIDTH-1:0] = D[15*WRAP_WIDTH-1:14*WRAP_WIDTH];
assign ram15_din[WRAP_WIDTH-1:0] = D[16*WRAP_WIDTH-1:15*WRAP_WIDTH];


always@(posedge CLK)
begin
  if(!CEN) begin
    addr_holding[ADDR_WIDTH-1:0] <= A[ADDR_WIDTH-1:0];
  end
end

assign addr[ADDR_WIDTH-1:0] = CEN ? addr_holding[ADDR_WIDTH-1:0]
                                  : A[ADDR_WIDTH-1:0];





assign Q[WRAP_WIDTH-1:0]               = ram0_dout[WRAP_WIDTH-1:0];
assign Q[2*WRAP_WIDTH-1:WRAP_WIDTH]    = ram1_dout[WRAP_WIDTH-1:0];
assign Q[3*WRAP_WIDTH-1:2*WRAP_WIDTH]  = ram2_dout[WRAP_WIDTH-1:0];
assign Q[4*WRAP_WIDTH-1:3*WRAP_WIDTH]  = ram3_dout[WRAP_WIDTH-1:0];
assign Q[5*WRAP_WIDTH-1:4*WRAP_WIDTH]  = ram4_dout[WRAP_WIDTH-1:0];
assign Q[6*WRAP_WIDTH-1:5*WRAP_WIDTH]  = ram5_dout[WRAP_WIDTH-1:0];
assign Q[7*WRAP_WIDTH-1:6*WRAP_WIDTH]  = ram6_dout[WRAP_WIDTH-1:0];
assign Q[8*WRAP_WIDTH-1:7*WRAP_WIDTH]  = ram7_dout[WRAP_WIDTH-1:0];
assign Q[9*WRAP_WIDTH-1:8*WRAP_WIDTH]  = ram8_dout[WRAP_WIDTH-1:0];
assign Q[10*WRAP_WIDTH-1:9*WRAP_WIDTH]  = ram9_dout[WRAP_WIDTH-1:0];
assign Q[11*WRAP_WIDTH-1:10*WRAP_WIDTH]  = ram10_dout[WRAP_WIDTH-1:0];
assign Q[12*WRAP_WIDTH-1:11*WRAP_WIDTH]  = ram11_dout[WRAP_WIDTH-1:0];
assign Q[13*WRAP_WIDTH-1:12*WRAP_WIDTH]  = ram12_dout[WRAP_WIDTH-1:0];
assign Q[14*WRAP_WIDTH-1:13*WRAP_WIDTH]  = ram13_dout[WRAP_WIDTH-1:0];
assign Q[15*WRAP_WIDTH-1:14*WRAP_WIDTH]  = ram14_dout[WRAP_WIDTH-1:0];
assign Q[16*WRAP_WIDTH-1:15*WRAP_WIDTH]  = ram15_dout[WRAP_WIDTH-1:0];

ram #(WRAP_WIDTH,ADDR_WIDTH) ram0(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram0_din),
  .PortAWriteEnable(ram0_wen),
  .PortADataOut(ram0_dout));


ram #(WRAP_WIDTH,ADDR_WIDTH) ram1(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram1_din),
  .PortAWriteEnable(ram1_wen),
  .PortADataOut(ram1_dout));

ram #(WRAP_WIDTH,ADDR_WIDTH) ram2(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram2_din),
  .PortAWriteEnable(ram2_wen),
  .PortADataOut(ram2_dout));

ram #(WRAP_WIDTH,ADDR_WIDTH) ram3(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram3_din),
  .PortAWriteEnable(ram3_wen),
  .PortADataOut(ram3_dout));

ram #(WRAP_WIDTH,ADDR_WIDTH) ram4(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram4_din),
  .PortAWriteEnable(ram4_wen),
  .PortADataOut(ram4_dout));


ram #(WRAP_WIDTH,ADDR_WIDTH) ram5(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram5_din),
  .PortAWriteEnable(ram5_wen),
  .PortADataOut(ram5_dout));

ram #(WRAP_WIDTH,ADDR_WIDTH) ram6(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram6_din),
  .PortAWriteEnable(ram6_wen),
  .PortADataOut(ram6_dout));

ram #(WRAP_WIDTH,ADDR_WIDTH) ram7(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram7_din),
  .PortAWriteEnable(ram7_wen),
  .PortADataOut(ram7_dout));

ram #(WRAP_WIDTH,ADDR_WIDTH) ram8(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram8_din),
  .PortAWriteEnable(ram8_wen),
  .PortADataOut(ram8_dout));

ram #(WRAP_WIDTH,ADDR_WIDTH) ram9(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram9_din),
  .PortAWriteEnable(ram9_wen),
  .PortADataOut(ram9_dout));

ram #(WRAP_WIDTH,ADDR_WIDTH) ram10(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram10_din),
  .PortAWriteEnable(ram10_wen),
  .PortADataOut(ram10_dout));

ram #(WRAP_WIDTH,ADDR_WIDTH) ram11(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram11_din),
  .PortAWriteEnable(ram11_wen),
  .PortADataOut(ram11_dout));

ram #(WRAP_WIDTH,ADDR_WIDTH) ram12(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram12_din),
  .PortAWriteEnable(ram12_wen),
  .PortADataOut(ram12_dout));

ram #(WRAP_WIDTH,ADDR_WIDTH) ram13(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram13_din),
  .PortAWriteEnable(ram13_wen),
  .PortADataOut(ram13_dout));

ram #(WRAP_WIDTH,ADDR_WIDTH) ram14(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram14_din),
  .PortAWriteEnable(ram14_wen),
  .PortADataOut(ram14_dout));

ram #(WRAP_WIDTH,ADDR_WIDTH) ram15(
  .PortAClk (CLK),
  .PortAAddr(addr),
  .PortADataIn (ram15_din),
  .PortAWriteEnable(ram15_wen),
  .PortADataOut(ram15_dout));


endmodule


