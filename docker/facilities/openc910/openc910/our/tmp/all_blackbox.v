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

// &Depend("fpga_ram.v"); @23

// &ModuleBeg; @25
(* blackbox *)
(* cellift_noinstrument *)
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
input CLK;
input   [9  :0]  A_t0;           
input   [9  :0]  A;           
input            CEN_t0;         
input            CEN;         
input   [127:0]  D_t0;           
input   [127:0]  D;           
input            GWEN_t0;        
input            GWEN;        
output  [127:0]  Q_t0;           
output  [127:0]  Q;           
input   [127:0]  WEN_t0;         
input   [127:0]  WEN;         
wire    [9  :0]  A_t0;           
wire    [9  :0]  A;           
wire             CEN_t0;         
wire             CEN;         
wire    [127:0]  D_t0;           
wire    [127:0]  D;           
wire             GWEN_t0;        
wire             GWEN;        
wire    [127:0]  Q_t0;           
wire    [127:0]  Q;           
wire    [127:0]  WEN_t0;         
wire    [127:0]  WEN;         
assign Q_t0 = '0;
assign Q = '0;

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
(* blackbox *)
(* cellift_noinstrument *)
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
input CLK;
input  [ADDR_WIDTH-1:0]   A_t0;
input  [ADDR_WIDTH-1:0]   A;
input                     CEN_t0;
input                     CEN;
input  [DATA_WIDTH-1:0]   D_t0;
input  [DATA_WIDTH-1:0]   D;
input                     GWEN_t0;
input                     GWEN;
output [DATA_WIDTH-1:0]   Q_t0;
output [DATA_WIDTH-1:0]   Q;
input  [DATA_WIDTH-1:0]   WEN_t0;
input  [DATA_WIDTH-1:0]   WEN;
wire  [ADDR_WIDTH-1:0]   A_t0;
wire  [ADDR_WIDTH-1:0]   A;
wire                     CEN_t0;
wire                     CEN;
wire  [DATA_WIDTH-1:0]   D_t0;
wire  [DATA_WIDTH-1:0]   D;
wire                     GWEN_t0;
wire                     GWEN;
wire  [DATA_WIDTH-1:0]   Q_t0;
wire  [DATA_WIDTH-1:0]   Q;
wire  [DATA_WIDTH-1:0]   WEN_t0;
wire  [DATA_WIDTH-1:0]   WEN;
assign Q_t0 = '0;
assign Q = '0;

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

// &Depend("fpga_ram.v"); @23

// &ModuleBeg; @25
(* blackbox *)
(* cellift_noinstrument *)
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
input CLK;
input   [9 :0]  A_t0;           
input   [9 :0]  A;           
input           CEN_t0;         
input           CEN;         
input   [31:0]  D_t0;           
input   [31:0]  D;           
input           GWEN_t0;        
input           GWEN;        
output  [31:0]  Q_t0;           
output  [31:0]  Q;           
input   [31:0]  WEN_t0;         
input   [31:0]  WEN;         
wire    [9 :0]  A_t0;           
wire    [9 :0]  A;           
wire            CEN_t0;         
wire            CEN;         
wire    [31:0]  D_t0;           
wire    [31:0]  D;           
wire            GWEN_t0;        
wire            GWEN;        
wire    [31:0]  Q_t0;           
wire    [31:0]  Q;           
wire    [31:0]  WEN_t0;         
wire    [31:0]  WEN;         
assign Q_t0 = '0;
assign Q = '0;

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

// &Depend("fpga_ram.v"); @23

// &ModuleBeg; @25
(* blackbox *)
(* cellift_noinstrument *)
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
input CLK;
input   [9 :0]  A_t0;           
input   [9 :0]  A;           
input           CEN_t0;         
input           CEN;         
input   [58:0]  D_t0;           
input   [58:0]  D;           
input           GWEN_t0;        
input           GWEN;        
output  [58:0]  Q_t0;           
output  [58:0]  Q;           
input   [58:0]  WEN_t0;         
input   [58:0]  WEN;         
wire    [9 :0]  A_t0;           
wire    [9 :0]  A;           
wire            CEN_t0;         
wire            CEN;         
wire    [58:0]  D_t0;           
wire    [58:0]  D;           
wire            GWEN_t0;        
wire            GWEN;        
wire    [58:0]  Q_t0;           
wire    [58:0]  Q;           
wire    [58:0]  WEN_t0;         
wire    [58:0]  WEN;         
assign Q_t0 = '0;
assign Q = '0;

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
(* blackbox *)
(* cellift_noinstrument *)
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
input CLK;
input  [ADDR_WIDTH-1:0]   A_t0;
input  [ADDR_WIDTH-1:0]   A;
input                     CEN_t0;
input                     CEN;
input  [DATA_WIDTH-1:0]   D_t0;
input  [DATA_WIDTH-1:0]   D;
input                     GWEN_t0;
input                     GWEN;
output [DATA_WIDTH-1:0]   Q_t0;
output [DATA_WIDTH-1:0]   Q;
input  [DATA_WIDTH-1:0]   WEN_t0;
input  [DATA_WIDTH-1:0]   WEN;
wire  [ADDR_WIDTH-1:0]   A_t0;
wire  [ADDR_WIDTH-1:0]   A;
wire                     CEN_t0;
wire                     CEN;
wire  [DATA_WIDTH-1:0]   D_t0;
wire  [DATA_WIDTH-1:0]   D;
wire                     GWEN_t0;
wire                     GWEN;
wire  [DATA_WIDTH-1:0]   Q_t0;
wire  [DATA_WIDTH-1:0]   Q;
wire  [DATA_WIDTH-1:0]   WEN_t0;
wire  [DATA_WIDTH-1:0]   WEN;
assign Q_t0 = '0;
assign Q = '0;

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
(* blackbox *)
(* cellift_noinstrument *)
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
input CLK;
input   [9 :0]  A_t0;           
input   [9 :0]  A;           
input           CEN_t0;         
input           CEN;         
input   [91:0]  D_t0;           
input   [91:0]  D;           
input           GWEN_t0;        
input           GWEN;        
output  [91:0]  Q_t0;           
output  [91:0]  Q;           
input   [91:0]  WEN_t0;         
input   [91:0]  WEN;         
wire    [9 :0]  A_t0;           
wire    [9 :0]  A;           
wire            CEN_t0;         
wire            CEN;         
wire    [91:0]  D_t0;           
wire    [91:0]  D;           
wire            GWEN_t0;        
wire            GWEN;        
wire    [91:0]  Q_t0;           
wire    [91:0]  Q;           
wire    [91:0]  WEN_t0;         
wire    [91:0]  WEN;         
assign Q_t0 = '0;
assign Q = '0;

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
(* blackbox *)
(* cellift_noinstrument *)
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
input CLK;
input   [6  :0]  A_t0;           
input   [6  :0]  A;           
input            CEN_t0;         
input            CEN;         
input   [103:0]  D_t0;           
input   [103:0]  D;           
input            GWEN_t0;        
input            GWEN;        
output  [103:0]  Q_t0;           
output  [103:0]  Q;           
input   [103:0]  WEN_t0;         
input   [103:0]  WEN;         
wire    [6  :0]  A_t0;           
wire    [6  :0]  A;           
wire             CEN_t0;         
wire             CEN;         
wire    [103:0]  D_t0;           
wire    [103:0]  D;           
wire             GWEN_t0;        
wire             GWEN;        
wire    [103:0]  Q_t0;           
wire    [103:0]  Q;           
wire    [103:0]  WEN_t0;         
wire    [103:0]  WEN;         
assign Q_t0 = '0;
assign Q = '0;

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
(* blackbox *)
(* cellift_noinstrument *)
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
input CLK;
input  [ADDR_WIDTH-1:0]   A_t0;
input  [ADDR_WIDTH-1:0]   A;
input                     CEN_t0;
input                     CEN;
input  [DATA_WIDTH-1:0]   D_t0;
input  [DATA_WIDTH-1:0]   D;
input                     GWEN_t0;
input                     GWEN;
output [DATA_WIDTH-1:0]   Q_t0;
output [DATA_WIDTH-1:0]   Q;
input  [DATA_WIDTH-1:0]   WEN_t0;
input  [DATA_WIDTH-1:0]   WEN;
wire  [ADDR_WIDTH-1:0]   A_t0;
wire  [ADDR_WIDTH-1:0]   A;
wire                     CEN_t0;
wire                     CEN;
wire  [DATA_WIDTH-1:0]   D_t0;
wire  [DATA_WIDTH-1:0]   D;
wire                     GWEN_t0;
wire                     GWEN;
wire  [DATA_WIDTH-1:0]   Q_t0;
wire  [DATA_WIDTH-1:0]   Q;
wire  [DATA_WIDTH-1:0]   WEN_t0;
wire  [DATA_WIDTH-1:0]   WEN;
assign Q_t0 = '0;
assign Q = '0;

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

// &Depend("fpga_ram.v"); @23

// &ModuleBeg; @25
(* blackbox *)
(* cellift_noinstrument *)
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
input CLK;
input   [6 :0]  A_t0;           
input   [6 :0]  A;           
input           CEN_t0;         
input           CEN;         
input   [15:0]  D_t0;           
input   [15:0]  D;           
input           GWEN_t0;        
input           GWEN;        
output  [15:0]  Q_t0;           
output  [15:0]  Q;           
input   [15:0]  WEN_t0;         
input   [15:0]  WEN;         
wire    [6 :0]  A_t0;           
wire    [6 :0]  A;           
wire            CEN_t0;         
wire            CEN;         
wire    [15:0]  D_t0;           
wire    [15:0]  D;           
wire            GWEN_t0;        
wire            GWEN;        
wire    [15:0]  Q_t0;           
wire    [15:0]  Q;           
wire    [15:0]  WEN_t0;         
wire    [15:0]  WEN;         
assign Q_t0 = '0;
assign Q = '0;

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

// &Depend("fpga_ram.v"); @23

// &ModuleBeg; @25
(* blackbox *)
(* cellift_noinstrument *)
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
input CLK;
input   [13 :0]  A_t0;           
input   [13 :0]  A;           
input            CEN_t0;         
input            CEN;         
input   [127:0]  D_t0;           
input   [127:0]  D;           
input            GWEN_t0;        
input            GWEN;        
output  [127:0]  Q_t0;           
output  [127:0]  Q;           
input   [127:0]  WEN_t0;         
input   [127:0]  WEN;         
wire    [13 :0]  A_t0;           
wire    [13 :0]  A;           
wire             CEN_t0;         
wire             CEN;         
wire    [127:0]  D_t0;           
wire    [127:0]  D;           
wire             GWEN_t0;        
wire             GWEN;        
wire    [127:0]  Q_t0;           
wire    [127:0]  Q;           
wire    [127:0]  WEN_t0;         
wire    [127:0]  WEN;         
assign Q_t0 = '0;
assign Q = '0;

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

// &Depend("fpga_ram.v"); @23

// &ModuleBeg; @25
(* blackbox *)
(* cellift_noinstrument *)
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
input CLK;
input   [10 :0]  A_t0;           
input   [10 :0]  A;           
input            CEN_t0;         
input            CEN;         
input   [127:0]  D_t0;           
input   [127:0]  D;           
input            GWEN_t0;        
input            GWEN;        
output  [127:0]  Q_t0;           
output  [127:0]  Q;           
input   [127:0]  WEN_t0;         
input   [127:0]  WEN;         
wire    [10 :0]  A_t0;           
wire    [10 :0]  A;           
wire             CEN_t0;         
wire             CEN;         
wire    [127:0]  D_t0;           
wire    [127:0]  D;           
wire             GWEN_t0;        
wire             GWEN;        
wire    [127:0]  Q_t0;           
wire    [127:0]  Q;           
wire    [127:0]  WEN_t0;         
wire    [127:0]  WEN;         
assign Q_t0 = '0;
assign Q = '0;

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
(* blackbox *)
(* cellift_noinstrument *)
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
input CLK;
input  [ADDR_WIDTH-1:0]   A_t0;
input  [ADDR_WIDTH-1:0]   A;
input                     CEN_t0;
input                     CEN;
input  [DATA_WIDTH-1:0]   D_t0;
input  [DATA_WIDTH-1:0]   D;
input                     GWEN_t0;
input                     GWEN;
output [DATA_WIDTH-1:0]   Q_t0;
output [DATA_WIDTH-1:0]   Q;
input  [DATA_WIDTH-1:0]   WEN_t0;
input  [DATA_WIDTH-1:0]   WEN;
wire  [ADDR_WIDTH-1:0]   A_t0;
wire  [ADDR_WIDTH-1:0]   A;
wire                     CEN_t0;
wire                     CEN;
wire  [DATA_WIDTH-1:0]   D_t0;
wire  [DATA_WIDTH-1:0]   D;
wire                     GWEN_t0;
wire                     GWEN;
wire  [DATA_WIDTH-1:0]   Q_t0;
wire  [DATA_WIDTH-1:0]   Q;
wire  [DATA_WIDTH-1:0]   WEN_t0;
wire  [DATA_WIDTH-1:0]   WEN;
assign Q_t0 = '0;
assign Q = '0;

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

// &Depend("fpga_ram.v"); @23

// &ModuleBeg; @25
(* blackbox *)
(* cellift_noinstrument *)
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
input CLK;
input   [10:0]  A_t0;           
input   [10:0]  A;           
input           CEN_t0;         
input           CEN;         
input   [31:0]  D_t0;           
input   [31:0]  D;           
input           GWEN_t0;        
input           GWEN;        
output  [31:0]  Q_t0;           
output  [31:0]  Q;           
input   [31:0]  WEN_t0;         
input   [31:0]  WEN;         
wire    [10:0]  A_t0;           
wire    [10:0]  A;           
wire            CEN_t0;         
wire            CEN;         
wire    [31:0]  D_t0;           
wire    [31:0]  D;           
wire            GWEN_t0;        
wire            GWEN;        
wire    [31:0]  Q_t0;           
wire    [31:0]  Q;           
wire    [31:0]  WEN_t0;         
wire    [31:0]  WEN;         
assign Q_t0 = '0;
assign Q = '0;

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

// &Depend("fpga_ram.v"); @23

// &ModuleBeg; @25
(* blackbox *)
(* cellift_noinstrument *)
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
input CLK;
input   [10:0]  A_t0;           
input   [10:0]  A;           
input           CEN_t0;         
input           CEN;         
input   [58:0]  D_t0;           
input   [58:0]  D;           
input           GWEN_t0;        
input           GWEN;        
output  [58:0]  Q_t0;           
output  [58:0]  Q;           
input   [58:0]  WEN_t0;         
input   [58:0]  WEN;         
wire    [10:0]  A_t0;           
wire    [10:0]  A;           
wire            CEN_t0;         
wire            CEN;         
wire    [58:0]  D_t0;           
wire    [58:0]  D;           
wire            GWEN_t0;        
wire            GWEN;        
wire    [58:0]  Q_t0;           
wire    [58:0]  Q;           
wire    [58:0]  WEN_t0;         
wire    [58:0]  WEN;         
assign Q_t0 = '0;
assign Q = '0;

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
(* blackbox *)
(* cellift_noinstrument *)
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
input CLK;
input  [ADDR_WIDTH-1:0]   A_t0;
input  [ADDR_WIDTH-1:0]   A;
input                     CEN_t0;
input                     CEN;
input  [DATA_WIDTH-1:0]   D_t0;
input  [DATA_WIDTH-1:0]   D;
input                     GWEN_t0;
input                     GWEN;
output [DATA_WIDTH-1:0]   Q_t0;
output [DATA_WIDTH-1:0]   Q;
input  [DATA_WIDTH-1:0]   WEN_t0;
input  [DATA_WIDTH-1:0]   WEN;
wire  [ADDR_WIDTH-1:0]   A_t0;
wire  [ADDR_WIDTH-1:0]   A;
wire                     CEN_t0;
wire                     CEN;
wire  [DATA_WIDTH-1:0]   D_t0;
wire  [DATA_WIDTH-1:0]   D;
wire                     GWEN_t0;
wire                     GWEN;
wire  [DATA_WIDTH-1:0]   Q_t0;
wire  [DATA_WIDTH-1:0]   Q;
wire  [DATA_WIDTH-1:0]   WEN_t0;
wire  [DATA_WIDTH-1:0]   WEN;
assign Q_t0 = '0;
assign Q = '0;

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
(* blackbox *)
(* cellift_noinstrument *)
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
input CLK;
input   [7 :0]  A_t0;           
input   [7 :0]  A;           
input           CEN_t0;         
input           CEN;         
input   [99:0]  D_t0;           
input   [99:0]  D;           
input           GWEN_t0;        
input           GWEN;        
output  [99:0]  Q_t0;           
output  [99:0]  Q;           
input   [99:0]  WEN_t0;         
input   [99:0]  WEN;         
wire    [7 :0]  A_t0;           
wire    [7 :0]  A;           
wire            CEN_t0;         
wire            CEN;         
wire    [99:0]  D_t0;           
wire    [99:0]  D;           
wire            GWEN_t0;        
wire            GWEN;        
wire    [99:0]  Q_t0;           
wire    [99:0]  Q;           
wire    [99:0]  WEN_t0;         
wire    [99:0]  WEN;         
assign Q_t0 = '0;
assign Q = '0;

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
(* blackbox *)
(* cellift_noinstrument *)
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
input CLK;
input  [ADDR_WIDTH-1:0]   A_t0;
input  [ADDR_WIDTH-1:0]   A;
input                     CEN_t0;
input                     CEN;
input  [DATA_WIDTH-1:0]   D_t0;
input  [DATA_WIDTH-1:0]   D;
input                     GWEN_t0;
input                     GWEN;
output [DATA_WIDTH-1:0]   Q_t0;
output [DATA_WIDTH-1:0]   Q;
input  [DATA_WIDTH-1:0]   WEN_t0;
input  [DATA_WIDTH-1:0]   WEN;
wire  [ADDR_WIDTH-1:0]   A_t0;
wire  [ADDR_WIDTH-1:0]   A;
wire                     CEN_t0;
wire                     CEN;
wire  [DATA_WIDTH-1:0]   D_t0;
wire  [DATA_WIDTH-1:0]   D;
wire                     GWEN_t0;
wire                     GWEN;
wire  [DATA_WIDTH-1:0]   Q_t0;
wire  [DATA_WIDTH-1:0]   Q;
wire  [DATA_WIDTH-1:0]   WEN_t0;
wire  [DATA_WIDTH-1:0]   WEN;
assign Q_t0 = '0;
assign Q = '0;

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
(* blackbox *)
(* cellift_noinstrument *)
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
input CLK;
input   [7  :0]  A_t0;           
input   [7  :0]  A;           
input            CEN_t0;         
input            CEN;         
input   [195:0]  D_t0;           
input   [195:0]  D;           
input            GWEN_t0;        
input            GWEN;        
output  [195:0]  Q_t0;           
output  [195:0]  Q;           
input   [195:0]  WEN_t0;         
input   [195:0]  WEN;         
wire    [7  :0]  A_t0;           
wire    [7  :0]  A;           
wire             CEN_t0;         
wire             CEN;         
wire    [195:0]  D_t0;           
wire    [195:0]  D;           
wire             GWEN_t0;        
wire             GWEN;        
wire    [195:0]  Q_t0;           
wire    [195:0]  Q;           
wire    [195:0]  WEN_t0;         
wire    [195:0]  WEN;         
assign Q_t0 = '0;
assign Q = '0;

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

// &Depend("fpga_ram.v"); @23

// &ModuleBeg; @25
(* blackbox *)
(* cellift_noinstrument *)
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
input CLK;
input   [7 :0]  A_t0;           
input   [7 :0]  A;           
input           CEN_t0;         
input           CEN;         
input   [22:0]  D_t0;           
input   [22:0]  D;           
input           GWEN_t0;        
input           GWEN;        
output  [22:0]  Q_t0;           
output  [22:0]  Q;           
input   [22:0]  WEN_t0;         
input   [22:0]  WEN;         
wire    [7 :0]  A_t0;           
wire    [7 :0]  A;           
wire            CEN_t0;         
wire            CEN;         
wire    [22:0]  D_t0;           
wire    [22:0]  D;           
wire            GWEN_t0;        
wire            GWEN;        
wire    [22:0]  Q_t0;           
wire    [22:0]  Q;           
wire    [22:0]  WEN_t0;         
wire    [22:0]  WEN;         
assign Q_t0 = '0;
assign Q = '0;

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

// &Depend("fpga_ram.v"); @23

// &ModuleBeg; @25
(* blackbox *)
(* cellift_noinstrument *)
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
input CLK;
input   [7 :0]  A_t0;           
input   [7 :0]  A;           
input           CEN_t0;         
input           CEN;         
input   [51:0]  D_t0;           
input   [51:0]  D;           
input           GWEN_t0;        
input           GWEN;        
output  [51:0]  Q_t0;           
output  [51:0]  Q;           
input   [51:0]  WEN_t0;         
input   [51:0]  WEN;         
wire    [7 :0]  A_t0;           
wire    [7 :0]  A;           
wire            CEN_t0;         
wire            CEN;         
wire    [51:0]  D_t0;           
wire    [51:0]  D;           
wire            GWEN_t0;        
wire            GWEN;        
wire    [51:0]  Q_t0;           
wire    [51:0]  Q;           
wire    [51:0]  WEN_t0;         
wire    [51:0]  WEN;         
assign Q_t0 = '0;
assign Q = '0;

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

// &Depend("fpga_ram.v"); @23

// &ModuleBeg; @25
(* blackbox *)
(* cellift_noinstrument *)
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
input CLK;
input   [7 :0]  A_t0;           
input   [7 :0]  A;           
input           CEN_t0;         
input           CEN;         
input   [53:0]  D_t0;           
input   [53:0]  D;           
input           GWEN_t0;        
input           GWEN;        
output  [53:0]  Q_t0;           
output  [53:0]  Q;           
input   [53:0]  WEN_t0;         
input   [53:0]  WEN;         
wire    [7 :0]  A_t0;           
wire    [7 :0]  A;           
wire            CEN_t0;         
wire            CEN;         
wire    [53:0]  D_t0;           
wire    [53:0]  D;           
wire            GWEN_t0;        
wire            GWEN;        
wire    [53:0]  Q_t0;           
wire    [53:0]  Q;           
wire    [53:0]  WEN_t0;         
wire    [53:0]  WEN;         
assign Q_t0 = '0;
assign Q = '0;

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

// &Depend("fpga_ram.v"); @23

// &ModuleBeg; @25
(* blackbox *)
(* cellift_noinstrument *)
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
input CLK;
input   [7 :0]  A_t0;           
input   [7 :0]  A;           
input           CEN_t0;         
input           CEN;         
input   [58:0]  D_t0;           
input   [58:0]  D;           
input           GWEN_t0;        
input           GWEN;        
output  [58:0]  Q_t0;           
output  [58:0]  Q;           
input   [58:0]  WEN_t0;         
input   [58:0]  WEN;         
wire    [7 :0]  A_t0;           
wire    [7 :0]  A;           
wire            CEN_t0;         
wire            CEN;         
wire    [58:0]  D_t0;           
wire    [58:0]  D;           
wire            GWEN_t0;        
wire            GWEN;        
wire    [58:0]  Q_t0;           
wire    [58:0]  Q;           
wire    [58:0]  WEN_t0;         
wire    [58:0]  WEN;         
assign Q_t0 = '0;
assign Q = '0;

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

// &Depend("fpga_ram.v"); @23

// &ModuleBeg; @25
(* blackbox *)
(* cellift_noinstrument *)
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
input CLK;
input   [7:0]  A_t0;           
input   [7:0]  A;           
input          CEN_t0;         
input          CEN;         
input   [6:0]  D_t0;           
input   [6:0]  D;           
input          GWEN_t0;        
input          GWEN;        
output  [6:0]  Q_t0;           
output  [6:0]  Q;           
input   [6:0]  WEN_t0;         
input   [6:0]  WEN;         
wire    [7:0]  A_t0;           
wire    [7:0]  A;           
wire           CEN_t0;         
wire           CEN;         
wire    [6:0]  D_t0;           
wire    [6:0]  D;           
wire           GWEN_t0;        
wire           GWEN;        
wire    [6:0]  Q_t0;           
wire    [6:0]  Q;           
wire    [6:0]  WEN_t0;         
wire    [6:0]  WEN;         
assign Q_t0 = '0;
assign Q = '0;

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
(* blackbox *)
(* cellift_noinstrument *)
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
input CLK;
input   [7 :0]  A_t0;           
input   [7 :0]  A;           
input           CEN_t0;         
input           CEN;         
input   [83:0]  D_t0;           
input   [83:0]  D;           
input           GWEN_t0;        
input           GWEN;        
output  [83:0]  Q_t0;           
output  [83:0]  Q;           
input   [83:0]  WEN_t0;         
input   [83:0]  WEN;         
wire    [7 :0]  A_t0;           
wire    [7 :0]  A;           
wire            CEN_t0;         
wire            CEN;         
wire    [83:0]  D_t0;           
wire    [83:0]  D;           
wire            GWEN_t0;        
wire            GWEN;        
wire    [83:0]  Q_t0;           
wire    [83:0]  Q;           
wire    [83:0]  WEN_t0;         
wire    [83:0]  WEN;         
assign Q_t0 = '0;
assign Q = '0;

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
(* blackbox *)
(* cellift_noinstrument *)
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
input CLK;
input  [ADDR_WIDTH-1:0]   A_t0;
input  [ADDR_WIDTH-1:0]   A;
input                     CEN_t0;
input                     CEN;
input  [DATA_WIDTH-1:0]   D_t0;
input  [DATA_WIDTH-1:0]   D;
input                     GWEN_t0;
input                     GWEN;
output [DATA_WIDTH-1:0]   Q_t0;
output [DATA_WIDTH-1:0]   Q;
input  [DATA_WIDTH-1:0]   WEN_t0;
input  [DATA_WIDTH-1:0]   WEN;
wire  [ADDR_WIDTH-1:0]   A_t0;
wire  [ADDR_WIDTH-1:0]   A;
wire                     CEN_t0;
wire                     CEN;
wire  [DATA_WIDTH-1:0]   D_t0;
wire  [DATA_WIDTH-1:0]   D;
wire                     GWEN_t0;
wire                     GWEN;
wire  [DATA_WIDTH-1:0]   Q_t0;
wire  [DATA_WIDTH-1:0]   Q;
wire  [DATA_WIDTH-1:0]   WEN_t0;
wire  [DATA_WIDTH-1:0]   WEN;
assign Q_t0 = '0;
assign Q = '0;

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

// &Depend("fpga_ram.v"); @23

// &ModuleBeg; @25
(* blackbox *)
(* cellift_noinstrument *)
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
input CLK;
input   [11 :0]  A_t0;           
input   [11 :0]  A;           
input            CEN_t0;         
input            CEN;         
input   [127:0]  D_t0;           
input   [127:0]  D;           
input            GWEN_t0;        
input            GWEN;        
output  [127:0]  Q_t0;           
output  [127:0]  Q;           
input   [127:0]  WEN_t0;         
input   [127:0]  WEN;         
wire    [11 :0]  A_t0;           
wire    [11 :0]  A;           
wire             CEN_t0;         
wire             CEN;         
wire    [127:0]  D_t0;           
wire    [127:0]  D;           
wire             GWEN_t0;        
wire             GWEN;        
wire    [127:0]  Q_t0;           
wire    [127:0]  Q;           
wire    [127:0]  WEN_t0;         
wire    [127:0]  WEN;         
assign Q_t0 = '0;
assign Q = '0;

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
(* blackbox *)
(* cellift_noinstrument *)
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
input CLK;
input  [ADDR_WIDTH-1:0]   A_t0;
input  [ADDR_WIDTH-1:0]   A;
input                     CEN_t0;
input                     CEN;
input  [DATA_WIDTH-1:0]   D_t0;
input  [DATA_WIDTH-1:0]   D;
input                     GWEN_t0;
input                     GWEN;
output [DATA_WIDTH-1:0]   Q_t0;
output [DATA_WIDTH-1:0]   Q;
input  [DATA_WIDTH-1:0]   WEN_t0;
input  [DATA_WIDTH-1:0]   WEN;
wire  [ADDR_WIDTH-1:0]   A_t0;
wire  [ADDR_WIDTH-1:0]   A;
wire                     CEN_t0;
wire                     CEN;
wire  [DATA_WIDTH-1:0]   D_t0;
wire  [DATA_WIDTH-1:0]   D;
wire                     GWEN_t0;
wire                     GWEN;
wire  [DATA_WIDTH-1:0]   Q_t0;
wire  [DATA_WIDTH-1:0]   Q;
wire  [DATA_WIDTH-1:0]   WEN_t0;
wire  [DATA_WIDTH-1:0]   WEN;
assign Q_t0 = '0;
assign Q = '0;

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

// &Depend("fpga_ram.v"); @23

// &ModuleBeg; @25
(* blackbox *)
(* cellift_noinstrument *)
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
input CLK;
input   [11:0]  A_t0;           
input   [11:0]  A;           
input           CEN_t0;         
input           CEN;         
input   [31:0]  D_t0;           
input   [31:0]  D;           
input           GWEN_t0;        
input           GWEN;        
output  [31:0]  Q_t0;           
output  [31:0]  Q;           
input   [31:0]  WEN_t0;         
input   [31:0]  WEN;         
wire    [11:0]  A_t0;           
wire    [11:0]  A;           
wire            CEN_t0;         
wire            CEN;         
wire    [31:0]  D_t0;           
wire    [31:0]  D;           
wire            GWEN_t0;        
wire            GWEN;        
wire    [31:0]  Q_t0;           
wire    [31:0]  Q;           
wire    [31:0]  WEN_t0;         
wire    [31:0]  WEN;         
assign Q_t0 = '0;
assign Q = '0;

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
(* blackbox *)
(* cellift_noinstrument *)
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
input CLK;
input  [ADDR_WIDTH-1:0]   A_t0;
input  [ADDR_WIDTH-1:0]   A;
input                     CEN_t0;
input                     CEN;
input  [DATA_WIDTH-1:0]   D_t0;
input  [DATA_WIDTH-1:0]   D;
input                     GWEN_t0;
input                     GWEN;
output [DATA_WIDTH-1:0]   Q_t0;
output [DATA_WIDTH-1:0]   Q;
input  [DATA_WIDTH-1:0]   WEN_t0;
input  [DATA_WIDTH-1:0]   WEN;
wire  [ADDR_WIDTH-1:0]   A_t0;
wire  [ADDR_WIDTH-1:0]   A;
wire                     CEN_t0;
wire                     CEN;
wire  [DATA_WIDTH-1:0]   D_t0;
wire  [DATA_WIDTH-1:0]   D;
wire                     GWEN_t0;
wire                     GWEN;
wire  [DATA_WIDTH-1:0]   Q_t0;
wire  [DATA_WIDTH-1:0]   Q;
wire  [DATA_WIDTH-1:0]   WEN_t0;
wire  [DATA_WIDTH-1:0]   WEN;
assign Q_t0 = '0;
assign Q = '0;

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
(* blackbox *)
(* cellift_noinstrument *)
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
input CLK;
input  [ADDR_WIDTH-1:0]   A_t0;
input  [ADDR_WIDTH-1:0]   A;
input                     CEN_t0;
input                     CEN;
input  [DATA_WIDTH-1:0]   D_t0;
input  [DATA_WIDTH-1:0]   D;
input                     GWEN_t0;
input                     GWEN;
output [DATA_WIDTH-1:0]   Q_t0;
output [DATA_WIDTH-1:0]   Q;
input  [DATA_WIDTH-1:0]   WEN_t0;
input  [DATA_WIDTH-1:0]   WEN;
wire  [ADDR_WIDTH-1:0]   A_t0;
wire  [ADDR_WIDTH-1:0]   A;
wire                     CEN_t0;
wire                     CEN;
wire  [DATA_WIDTH-1:0]   D_t0;
wire  [DATA_WIDTH-1:0]   D;
wire                     GWEN_t0;
wire                     GWEN;
wire  [DATA_WIDTH-1:0]   Q_t0;
wire  [DATA_WIDTH-1:0]   Q;
wire  [DATA_WIDTH-1:0]   WEN_t0;
wire  [DATA_WIDTH-1:0]   WEN;
assign Q_t0 = '0;
assign Q = '0;

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

// &Depend("fpga_ram.v"); @23

// &ModuleBeg; @25
(* blackbox *)
(* cellift_noinstrument *)
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
input CLK;
input   [8 :0]  A_t0;           
input   [8 :0]  A;           
input           CEN_t0;         
input           CEN;         
input   [21:0]  D_t0;           
input   [21:0]  D;           
input           GWEN_t0;        
input           GWEN;        
output  [21:0]  Q_t0;           
output  [21:0]  Q;           
input   [21:0]  WEN_t0;         
input   [21:0]  WEN;         
wire    [8 :0]  A_t0;           
wire    [8 :0]  A;           
wire            CEN_t0;         
wire            CEN;         
wire    [21:0]  D_t0;           
wire    [21:0]  D;           
wire            GWEN_t0;        
wire            GWEN;        
wire    [21:0]  Q_t0;           
wire    [21:0]  Q;           
wire    [21:0]  WEN_t0;         
wire    [21:0]  WEN;         
assign Q_t0 = '0;
assign Q = '0;

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

// &Depend("fpga_ram.v"); @23

// &ModuleBeg; @25
(* blackbox *)
(* cellift_noinstrument *)
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
input CLK;
input   [8 :0]  A_t0;           
input   [8 :0]  A;           
input           CEN_t0;         
input           CEN;         
input   [43:0]  D_t0;           
input   [43:0]  D;           
input           GWEN_t0;        
input           GWEN;        
output  [43:0]  Q_t0;           
output  [43:0]  Q;           
input   [43:0]  WEN_t0;         
input   [43:0]  WEN;         
wire    [8 :0]  A_t0;           
wire    [8 :0]  A;           
wire            CEN_t0;         
wire            CEN;         
wire    [43:0]  D_t0;           
wire    [43:0]  D;           
wire            GWEN_t0;        
wire            GWEN;        
wire    [43:0]  Q_t0;           
wire    [43:0]  Q;           
wire    [43:0]  WEN_t0;         
wire    [43:0]  WEN;         
assign Q_t0 = '0;
assign Q = '0;

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

// &Depend("fpga_ram.v"); @23

// &ModuleBeg; @25
(* blackbox *)
(* cellift_noinstrument *)
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
input CLK;
input   [8 :0]  A_t0;           
input   [8 :0]  A;           
input           CEN_t0;         
input           CEN;         
input   [51:0]  D_t0;           
input   [51:0]  D;           
input           GWEN_t0;        
input           GWEN;        
output  [51:0]  Q_t0;           
output  [51:0]  Q;           
input   [51:0]  WEN_t0;         
input   [51:0]  WEN;         
wire    [8 :0]  A_t0;           
wire    [8 :0]  A;           
wire            CEN_t0;         
wire            CEN;         
wire    [51:0]  D_t0;           
wire    [51:0]  D;           
wire            GWEN_t0;        
wire            GWEN;        
wire    [51:0]  Q_t0;           
wire    [51:0]  Q;           
wire    [51:0]  WEN_t0;         
wire    [51:0]  WEN;         
assign Q_t0 = '0;
assign Q = '0;

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

// &Depend("fpga_ram.v"); @23

// &ModuleBeg; @25
(* blackbox *)
(* cellift_noinstrument *)
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
input CLK;
input   [8 :0]  A_t0;           
input   [8 :0]  A;           
input           CEN_t0;         
input           CEN;         
input   [53:0]  D_t0;           
input   [53:0]  D;           
input           GWEN_t0;        
input           GWEN;        
output  [53:0]  Q_t0;           
output  [53:0]  Q;           
input   [53:0]  WEN_t0;         
input   [53:0]  WEN;         
wire    [8 :0]  A_t0;           
wire    [8 :0]  A;           
wire            CEN_t0;         
wire            CEN;         
wire    [53:0]  D_t0;           
wire    [53:0]  D;           
wire            GWEN_t0;        
wire            GWEN;        
wire    [53:0]  Q_t0;           
wire    [53:0]  Q;           
wire    [53:0]  WEN_t0;         
wire    [53:0]  WEN;         
assign Q_t0 = '0;
assign Q = '0;

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

// &Depend("fpga_ram.v"); @23

// &ModuleBeg; @25
(* blackbox *)
(* cellift_noinstrument *)
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
input CLK;
input   [8 :0]  A_t0;           
input   [8 :0]  A;           
input           CEN_t0;         
input           CEN;         
input   [58:0]  D_t0;           
input   [58:0]  D;           
input           GWEN_t0;        
input           GWEN;        
output  [58:0]  Q_t0;           
output  [58:0]  Q;           
input   [58:0]  WEN_t0;         
input   [58:0]  WEN;         
wire    [8 :0]  A_t0;           
wire    [8 :0]  A;           
wire            CEN_t0;         
wire            CEN;         
wire    [58:0]  D_t0;           
wire    [58:0]  D;           
wire            GWEN_t0;        
wire            GWEN;        
wire    [58:0]  Q_t0;           
wire    [58:0]  Q;           
wire    [58:0]  WEN_t0;         
wire    [58:0]  WEN;         
assign Q_t0 = '0;
assign Q = '0;

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

// &Depend("fpga_ram.v"); @23

// &ModuleBeg; @25
(* blackbox *)
(* cellift_noinstrument *)
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
input CLK;
input   [8:0]  A_t0;           
input   [8:0]  A;           
input          CEN_t0;         
input          CEN;         
input   [6:0]  D_t0;           
input   [6:0]  D;           
input          GWEN_t0;        
input          GWEN;        
output  [6:0]  Q_t0;           
output  [6:0]  Q;           
input   [6:0]  WEN_t0;         
input   [6:0]  WEN;         
wire    [8:0]  A_t0;           
wire    [8:0]  A;           
wire           CEN_t0;         
wire           CEN;         
wire    [6:0]  D_t0;           
wire    [6:0]  D;           
wire           GWEN_t0;        
wire           GWEN;        
wire    [6:0]  Q_t0;           
wire    [6:0]  Q;           
wire    [6:0]  WEN_t0;         
wire    [6:0]  WEN;         
assign Q_t0 = '0;
assign Q = '0;

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
(* blackbox *)
(* cellift_noinstrument *)
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
input CLK;
input   [8 :0]  A_t0;           
input   [8 :0]  A;           
input           CEN_t0;         
input           CEN;         
input   [95:0]  D_t0;           
input   [95:0]  D;           
input           GWEN_t0;        
input           GWEN;        
output  [95:0]  Q_t0;           
output  [95:0]  Q;           
input   [95:0]  WEN_t0;         
input   [95:0]  WEN;         
wire    [8 :0]  A_t0;           
wire    [8 :0]  A;           
wire            CEN_t0;         
wire            CEN;         
wire    [95:0]  D_t0;           
wire    [95:0]  D;           
wire            GWEN_t0;        
wire            GWEN;        
wire    [95:0]  Q_t0;           
wire    [95:0]  Q;           
wire    [95:0]  WEN_t0;         
wire    [95:0]  WEN;         
assign Q_t0 = '0;
assign Q = '0;

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
(* blackbox *)
(* cellift_noinstrument *)
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
input CLK;
input   [5  :0]  A_t0;           
input   [5  :0]  A;           
input            CEN_t0;         
input            CEN;         
input   [107:0]  D_t0;           
input   [107:0]  D;           
input            GWEN_t0;        
input            GWEN;        
output  [107:0]  Q_t0;           
output  [107:0]  Q;           
input   [107:0]  WEN_t0;         
input   [107:0]  WEN;         
wire    [5  :0]  A_t0;           
wire    [5  :0]  A;           
wire             CEN_t0;         
wire             CEN;         
wire    [107:0]  D_t0;           
wire    [107:0]  D;           
wire             GWEN_t0;        
wire             GWEN;        
wire    [107:0]  Q_t0;           
wire    [107:0]  Q;           
wire    [107:0]  WEN_t0;         
wire    [107:0]  WEN;         
assign Q_t0 = '0;
assign Q = '0;

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
(* blackbox *)
(* cellift_noinstrument *)
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
input CLK;
input  [ADDR_WIDTH-1:0]   A_t0;
input  [ADDR_WIDTH-1:0]   A;
input                     CEN_t0;
input                     CEN;
input  [DATA_WIDTH-1:0]   D_t0;
input  [DATA_WIDTH-1:0]   D;
input                     GWEN_t0;
input                     GWEN;
output [DATA_WIDTH-1:0]   Q_t0;
output [DATA_WIDTH-1:0]   Q;
input  [DATA_WIDTH-1:0]   WEN_t0;
input  [DATA_WIDTH-1:0]   WEN;
wire  [ADDR_WIDTH-1:0]   A_t0;
wire  [ADDR_WIDTH-1:0]   A;
wire                     CEN_t0;
wire                     CEN;
wire  [DATA_WIDTH-1:0]   D_t0;
wire  [DATA_WIDTH-1:0]   D;
wire                     GWEN_t0;
wire                     GWEN;
wire  [DATA_WIDTH-1:0]   Q_t0;
wire  [DATA_WIDTH-1:0]   Q;
wire  [DATA_WIDTH-1:0]   WEN_t0;
wire  [DATA_WIDTH-1:0]   WEN;
assign Q_t0 = '0;
assign Q = '0;

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

// &Depend("fpga_ram.v"); @23

// &ModuleBeg; @25
(* blackbox *)
(* cellift_noinstrument *)
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
input CLK;
input   [12 :0]  A_t0;           
input   [12 :0]  A;           
input            CEN_t0;         
input            CEN;         
input   [127:0]  D_t0;           
input   [127:0]  D;           
input            GWEN_t0;        
input            GWEN;        
output  [127:0]  Q_t0;           
output  [127:0]  Q;           
input   [127:0]  WEN_t0;         
input   [127:0]  WEN;         
wire    [12 :0]  A_t0;           
wire    [12 :0]  A;           
wire             CEN_t0;         
wire             CEN;         
wire    [127:0]  D_t0;           
wire    [127:0]  D;           
wire             GWEN_t0;        
wire             GWEN;        
wire    [127:0]  Q_t0;           
wire    [127:0]  Q;           
wire    [127:0]  WEN_t0;         
wire    [127:0]  WEN;         
assign Q_t0 = '0;
assign Q = '0;

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

// &Depend("fpga_ram.v"); @23

// &ModuleBeg; @25
(* blackbox *)
(* cellift_noinstrument *)
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
input CLK;
input   [12:0]  A_t0;           
input   [12:0]  A;           
input           CEN_t0;         
input           CEN;         
input   [31:0]  D_t0;           
input   [31:0]  D;           
input           GWEN_t0;        
input           GWEN;        
output  [31:0]  Q_t0;           
output  [31:0]  Q;           
input   [31:0]  WEN_t0;         
input   [31:0]  WEN;         
wire    [12:0]  A_t0;           
wire    [12:0]  A;           
wire            CEN_t0;         
wire            CEN;         
wire    [31:0]  D_t0;           
wire    [31:0]  D;           
wire            GWEN_t0;        
wire            GWEN;        
wire    [31:0]  Q_t0;           
wire    [31:0]  Q;           
wire    [31:0]  WEN_t0;         
wire    [31:0]  WEN;         
assign Q_t0 = '0;
assign Q = '0;

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
(* blackbox *)
(* cellift_noinstrument *)
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
input CLK;
input   [9  :0]  A_t0;   
input   [9  :0]  A;   
input            CEN_t0; 
input            CEN; 
input   [127:0]  D_t0;   
input   [127:0]  D;   
input            GWEN_t0; 
input            GWEN; 
output  [127:0]  Q_t0;   
output  [127:0]  Q;   
input   [127:0]  WEN_t0; 
input   [127:0]  WEN; 
wire    [9  :0]  A_t0;   
wire    [9  :0]  A;   
wire             CEN_t0; 
wire             CEN; 
wire    [127:0]  D_t0;   
wire    [127:0]  D;   
wire             GWEN_t0; 
wire             GWEN; 
wire    [127:0]  Q_t0;   
wire    [127:0]  Q;   
wire    [127:0]  WEN_t0; 
wire    [127:0]  WEN; 
assign Q_t0 = '0;
assign Q = '0;

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
(* blackbox *)
(* cellift_noinstrument *)
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
input CLK;
input   [9  :0]  A_t0;   
input   [9  :0]  A;   
input            CEN_t0; 
input            CEN; 
input   [143:0]  D_t0;   
input   [143:0]  D;   
input            GWEN_t0; 
input            GWEN; 
output  [143:0]  Q_t0;   
output  [143:0]  Q;   
input   [143:0]  WEN_t0; 
input   [143:0]  WEN; 
wire    [9  :0]  A_t0;   
wire    [9  :0]  A;   
wire             CEN_t0; 
wire             CEN; 
wire    [143:0]  D_t0;   
wire    [143:0]  D;   
wire             GWEN_t0; 
wire             GWEN; 
wire    [143:0]  Q_t0;   
wire    [143:0]  Q;   
wire    [143:0]  WEN_t0; 
wire    [143:0]  WEN; 
assign Q_t0 = '0;
assign Q = '0;

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
(* blackbox *)
(* cellift_noinstrument *)
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
input CLK;
input   [9 :0]  A_t0;   
input   [9 :0]  A;   
input           CEN_t0; 
input           CEN; 
input   [31:0]  D_t0;   
input   [31:0]  D;   
input           GWEN_t0; 
input           GWEN; 
output  [31:0]  Q_t0;   
output  [31:0]  Q;   
input   [31:0]  WEN_t0; 
input   [31:0]  WEN; 
wire    [9 :0]  A_t0;   
wire    [9 :0]  A;   
wire            CEN_t0; 
wire            CEN; 
wire    [31:0]  D_t0;   
wire    [31:0]  D;   
wire            GWEN_t0; 
wire            GWEN; 
wire    [31:0]  Q_t0;   
wire    [31:0]  Q;   
wire    [31:0]  WEN_t0; 
wire    [31:0]  WEN; 
assign Q_t0 = '0;
assign Q = '0;

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
(* blackbox *)
(* cellift_noinstrument *)
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
input CLK;
input   [9 :0]  A_t0;   
input   [9 :0]  A;   
input           CEN_t0; 
input           CEN; 
input   [58:0]  D_t0;   
input   [58:0]  D;   
input           GWEN_t0; 
input           GWEN; 
output  [58:0]  Q_t0;   
output  [58:0]  Q;   
input   [58:0]  WEN_t0; 
input   [58:0]  WEN; 
wire    [9 :0]  A_t0;   
wire    [9 :0]  A;   
wire            CEN_t0; 
wire            CEN; 
wire    [58:0]  D_t0;   
wire    [58:0]  D;   
wire            GWEN_t0; 
wire            GWEN; 
wire    [58:0]  Q_t0;   
wire    [58:0]  Q;   
wire    [58:0]  WEN_t0; 
wire    [58:0]  WEN; 
assign Q_t0 = '0;
assign Q = '0;

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
(* blackbox *)
(* cellift_noinstrument *)
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
input CLK;
input   [9 :0]  A_t0;   
input   [9 :0]  A;   
input           CEN_t0; 
input           CEN; 
input   [63:0]  D_t0;   
input   [63:0]  D;   
input           GWEN_t0; 
input           GWEN; 
output  [63:0]  Q_t0;   
output  [63:0]  Q;   
input   [63:0]  WEN_t0; 
input   [63:0]  WEN; 
wire    [9 :0]  A_t0;   
wire    [9 :0]  A;   
wire            CEN_t0; 
wire            CEN; 
wire    [63:0]  D_t0;   
wire    [63:0]  D;   
wire            GWEN_t0; 
wire            GWEN; 
wire    [63:0]  Q_t0;   
wire    [63:0]  Q;   
wire    [63:0]  WEN_t0; 
wire    [63:0]  WEN; 
assign Q_t0 = '0;
assign Q = '0;

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
(* blackbox *)
(* cellift_noinstrument *)
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
input CLK;
input   [9 :0]  A_t0;   
input   [9 :0]  A;   
input           CEN_t0; 
input           CEN; 
input   [91:0]  D_t0;   
input   [91:0]  D;   
input           GWEN_t0; 
input           GWEN; 
output  [91:0]  Q_t0;   
output  [91:0]  Q;   
input   [91:0]  WEN_t0; 
input   [91:0]  WEN; 
wire    [9 :0]  A_t0;   
wire    [9 :0]  A;   
wire            CEN_t0; 
wire            CEN; 
wire    [91:0]  D_t0;   
wire    [91:0]  D;   
wire            GWEN_t0; 
wire            GWEN; 
wire    [91:0]  Q_t0;   
wire    [91:0]  Q;   
wire    [91:0]  WEN_t0; 
wire    [91:0]  WEN; 
assign Q_t0 = '0;
assign Q = '0;

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
(* blackbox *)
(* cellift_noinstrument *)
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
input CLK;
input   [6  :0]  A_t0;   
input   [6  :0]  A;   
input            CEN_t0; 
input            CEN; 
input   [103:0]  D_t0;   
input   [103:0]  D;   
input            GWEN_t0; 
input            GWEN; 
output  [103:0]  Q_t0;   
output  [103:0]  Q;   
input   [103:0]  WEN_t0; 
input   [103:0]  WEN; 
wire    [6  :0]  A_t0;   
wire    [6  :0]  A;   
wire             CEN_t0; 
wire             CEN; 
wire    [103:0]  D_t0;   
wire    [103:0]  D;   
wire             GWEN_t0; 
wire             GWEN; 
wire    [103:0]  Q_t0;   
wire    [103:0]  Q;   
wire    [103:0]  WEN_t0; 
wire    [103:0]  WEN; 
assign Q_t0 = '0;
assign Q = '0;

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
(* blackbox *)
(* cellift_noinstrument *)
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
input CLK;
input   [6  :0]  A_t0;   
input   [6  :0]  A;   
input            CEN_t0; 
input            CEN; 
input   [143:0]  D_t0;   
input   [143:0]  D;   
input            GWEN_t0; 
input            GWEN; 
output  [143:0]  Q_t0;   
output  [143:0]  Q;   
input   [143:0]  WEN_t0; 
input   [143:0]  WEN; 
wire    [6  :0]  A_t0;   
wire    [6  :0]  A;   
wire             CEN_t0; 
wire             CEN; 
wire    [143:0]  D_t0;   
wire    [143:0]  D;   
wire             GWEN_t0; 
wire             GWEN; 
wire    [143:0]  Q_t0;   
wire    [143:0]  Q;   
wire    [143:0]  WEN_t0; 
wire    [143:0]  WEN; 
assign Q_t0 = '0;
assign Q = '0;

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
(* blackbox *)
(* cellift_noinstrument *)
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
input CLK;
input   [6 :0]  A_t0;   
input   [6 :0]  A;   
input           CEN_t0; 
input           CEN; 
input   [15:0]  D_t0;   
input   [15:0]  D;   
input           GWEN_t0; 
input           GWEN; 
output  [15:0]  Q_t0;   
output  [15:0]  Q;   
input   [15:0]  WEN_t0; 
input   [15:0]  WEN; 
wire    [6 :0]  A_t0;   
wire    [6 :0]  A;   
wire            CEN_t0; 
wire            CEN; 
wire    [15:0]  D_t0;   
wire    [15:0]  D;   
wire            GWEN_t0; 
wire            GWEN; 
wire    [15:0]  Q_t0;   
wire    [15:0]  Q;   
wire    [15:0]  WEN_t0; 
wire    [15:0]  WEN; 
assign Q_t0 = '0;
assign Q = '0;

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
(* blackbox *)
(* cellift_noinstrument *)
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
input CLK;
input   [13 :0]  A_t0;   
input   [13 :0]  A;   
input            CEN_t0; 
input            CEN; 
input   [127:0]  D_t0;   
input   [127:0]  D;   
input            GWEN_t0; 
input            GWEN; 
output  [127:0]  Q_t0;   
output  [127:0]  Q;   
input   [127:0]  WEN_t0; 
input   [127:0]  WEN; 
wire    [13 :0]  A_t0;   
wire    [13 :0]  A;   
wire             CEN_t0; 
wire             CEN; 
wire    [127:0]  D_t0;   
wire    [127:0]  D;   
wire             GWEN_t0; 
wire             GWEN; 
wire    [127:0]  Q_t0;   
wire    [127:0]  Q;   
wire    [127:0]  WEN_t0; 
wire    [127:0]  WEN; 
assign Q_t0 = '0;
assign Q = '0;

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
(* blackbox *)
(* cellift_noinstrument *)
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
input CLK;
input   [10 :0]  A_t0;   
input   [10 :0]  A;   
input            CEN_t0; 
input            CEN; 
input   [127:0]  D_t0;   
input   [127:0]  D;   
input            GWEN_t0; 
input            GWEN; 
output  [127:0]  Q_t0;   
output  [127:0]  Q;   
input   [127:0]  WEN_t0; 
input   [127:0]  WEN; 
wire    [10 :0]  A_t0;   
wire    [10 :0]  A;   
wire             CEN_t0; 
wire             CEN; 
wire    [127:0]  D_t0;   
wire    [127:0]  D;   
wire             GWEN_t0; 
wire             GWEN; 
wire    [127:0]  Q_t0;   
wire    [127:0]  Q;   
wire    [127:0]  WEN_t0; 
wire    [127:0]  WEN; 
assign Q_t0 = '0;
assign Q = '0;

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
(* blackbox *)
(* cellift_noinstrument *)
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
input CLK;
input   [10 :0]  A_t0;   
input   [10 :0]  A;   
input            CEN_t0; 
input            CEN; 
input   [143:0]  D_t0;   
input   [143:0]  D;   
input            GWEN_t0; 
input            GWEN; 
output  [143:0]  Q_t0;   
output  [143:0]  Q;   
input   [143:0]  WEN_t0; 
input   [143:0]  WEN; 
wire    [10 :0]  A_t0;   
wire    [10 :0]  A;   
wire             CEN_t0; 
wire             CEN; 
wire    [143:0]  D_t0;   
wire    [143:0]  D;   
wire             GWEN_t0; 
wire             GWEN; 
wire    [143:0]  Q_t0;   
wire    [143:0]  Q;   
wire    [143:0]  WEN_t0; 
wire    [143:0]  WEN; 
assign Q_t0 = '0;
assign Q = '0;

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
(* blackbox *)
(* cellift_noinstrument *)
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
input CLK;
input   [10:0]  A_t0;   
input   [10:0]  A;   
input           CEN_t0; 
input           CEN; 
input   [31:0]  D_t0;   
input   [31:0]  D;   
input           GWEN_t0; 
input           GWEN; 
output  [31:0]  Q_t0;   
output  [31:0]  Q;   
input   [31:0]  WEN_t0; 
input   [31:0]  WEN; 
wire    [10:0]  A_t0;   
wire    [10:0]  A;   
wire            CEN_t0; 
wire            CEN; 
wire    [31:0]  D_t0;   
wire    [31:0]  D;   
wire            GWEN_t0; 
wire            GWEN; 
wire    [31:0]  Q_t0;   
wire    [31:0]  Q;   
wire    [31:0]  WEN_t0; 
wire    [31:0]  WEN; 
assign Q_t0 = '0;
assign Q = '0;

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
(* blackbox *)
(* cellift_noinstrument *)
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
input CLK;
input   [10:0]  A_t0;   
input   [10:0]  A;   
input           CEN_t0; 
input           CEN; 
input   [31:0]  D_t0;   
input   [31:0]  D;   
input           GWEN_t0; 
input           GWEN; 
output  [31:0]  Q_t0;   
output  [31:0]  Q;   
input   [31:0]  WEN_t0; 
input   [31:0]  WEN; 
wire    [10:0]  A_t0;   
wire    [10:0]  A;   
wire            CEN_t0; 
wire            CEN; 
wire    [31:0]  D_t0;   
wire    [31:0]  D;   
wire            GWEN_t0; 
wire            GWEN; 
wire    [31:0]  Q_t0;   
wire    [31:0]  Q;   
wire    [31:0]  WEN_t0; 
wire    [31:0]  WEN; 
assign Q_t0 = '0;
assign Q = '0;

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
(* blackbox *)
(* cellift_noinstrument *)
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
input CLK;
input   [10:0]  A_t0;   
input   [10:0]  A;   
input           CEN_t0; 
input           CEN; 
input   [58:0]  D_t0;   
input   [58:0]  D;   
input           GWEN_t0; 
input           GWEN; 
output  [58:0]  Q_t0;   
output  [58:0]  Q;   
input   [58:0]  WEN_t0; 
input   [58:0]  WEN; 
wire    [10:0]  A_t0;   
wire    [10:0]  A;   
wire            CEN_t0; 
wire            CEN; 
wire    [58:0]  D_t0;   
wire    [58:0]  D;   
wire            GWEN_t0; 
wire            GWEN; 
wire    [58:0]  Q_t0;   
wire    [58:0]  Q;   
wire    [58:0]  WEN_t0; 
wire    [58:0]  WEN; 
assign Q_t0 = '0;
assign Q = '0;

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
(* blackbox *)
(* cellift_noinstrument *)
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
input CLK;
input   [10:0]  A_t0;   
input   [10:0]  A;   
input           CEN_t0; 
input           CEN; 
input   [87:0]  D_t0;   
input   [87:0]  D;   
input           GWEN_t0; 
input           GWEN; 
output  [87:0]  Q_t0;   
output  [87:0]  Q;   
input   [87:0]  WEN_t0; 
input   [87:0]  WEN; 
wire    [10:0]  A_t0;   
wire    [10:0]  A;   
wire            CEN_t0; 
wire            CEN; 
wire    [87:0]  D_t0;   
wire    [87:0]  D;   
wire            GWEN_t0; 
wire            GWEN; 
wire    [87:0]  Q_t0;   
wire    [87:0]  Q;   
wire    [87:0]  WEN_t0; 
wire    [87:0]  WEN; 
assign Q_t0 = '0;
assign Q = '0;

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
(* blackbox *)
(* cellift_noinstrument *)
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
input CLK;
input   [7 :0]  A_t0;   
input   [7 :0]  A;   
input           CEN_t0; 
input           CEN; 
input   [99:0]  D_t0;   
input   [99:0]  D;   
input           GWEN_t0; 
input           GWEN; 
output  [99:0]  Q_t0;   
output  [99:0]  Q;   
input   [99:0]  WEN_t0; 
input   [99:0]  WEN; 
wire    [7 :0]  A_t0;   
wire    [7 :0]  A;   
wire            CEN_t0; 
wire            CEN; 
wire    [99:0]  D_t0;   
wire    [99:0]  D;   
wire            GWEN_t0; 
wire            GWEN; 
wire    [99:0]  Q_t0;   
wire    [99:0]  Q;   
wire    [99:0]  WEN_t0; 
wire    [99:0]  WEN; 
assign Q_t0 = '0;
assign Q = '0;

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
(* blackbox *)
(* cellift_noinstrument *)
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
input CLK;
input   [7  :0]  A_t0;   
input   [7  :0]  A;   
input            CEN_t0; 
input            CEN; 
input   [143:0]  D_t0;   
input   [143:0]  D;   
input            GWEN_t0; 
input            GWEN; 
output  [143:0]  Q_t0;   
output  [143:0]  Q;   
input   [143:0]  WEN_t0; 
input   [143:0]  WEN; 
wire    [7  :0]  A_t0;   
wire    [7  :0]  A;   
wire             CEN_t0; 
wire             CEN; 
wire    [143:0]  D_t0;   
wire    [143:0]  D;   
wire             GWEN_t0; 
wire             GWEN; 
wire    [143:0]  Q_t0;   
wire    [143:0]  Q;   
wire    [143:0]  WEN_t0; 
wire    [143:0]  WEN; 
assign Q_t0 = '0;
assign Q = '0;

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
(* blackbox *)
(* cellift_noinstrument *)
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
input CLK;
input   [7  :0]  A_t0;   
input   [7  :0]  A;   
input            CEN_t0; 
input            CEN; 
input   [195:0]  D_t0;   
input   [195:0]  D;   
input            GWEN_t0; 
input            GWEN; 
output  [195:0]  Q_t0;   
output  [195:0]  Q;   
input   [195:0]  WEN_t0; 
input   [195:0]  WEN; 
wire    [7  :0]  A_t0;   
wire    [7  :0]  A;   
wire             CEN_t0; 
wire             CEN; 
wire    [195:0]  D_t0;   
wire    [195:0]  D;   
wire             GWEN_t0; 
wire             GWEN; 
wire    [195:0]  Q_t0;   
wire    [195:0]  Q;   
wire    [195:0]  WEN_t0; 
wire    [195:0]  WEN; 
assign Q_t0 = '0;
assign Q = '0;

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
(* blackbox *)
(* cellift_noinstrument *)
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
input CLK;
input   [7 :0]  A_t0;   
input   [7 :0]  A;   
input           CEN_t0; 
input           CEN; 
input   [22:0]  D_t0;   
input   [22:0]  D;   
input           GWEN_t0; 
input           GWEN; 
output  [22:0]  Q_t0;   
output  [22:0]  Q;   
input   [22:0]  WEN_t0; 
input   [22:0]  WEN; 
wire    [7 :0]  A_t0;   
wire    [7 :0]  A;   
wire            CEN_t0; 
wire            CEN; 
wire    [22:0]  D_t0;   
wire    [22:0]  D;   
wire            GWEN_t0; 
wire            GWEN; 
wire    [22:0]  Q_t0;   
wire    [22:0]  Q;   
wire    [22:0]  WEN_t0; 
wire    [22:0]  WEN; 
assign Q_t0 = '0;
assign Q = '0;

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
(* blackbox *)
(* cellift_noinstrument *)
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
input CLK;
input   [7 :0]  A_t0;   
input   [7 :0]  A;   
input           CEN_t0; 
input           CEN; 
input   [51:0]  D_t0;   
input   [51:0]  D;   
input           GWEN_t0; 
input           GWEN; 
output  [51:0]  Q_t0;   
output  [51:0]  Q;   
input   [51:0]  WEN_t0; 
input   [51:0]  WEN; 
wire    [7 :0]  A_t0;   
wire    [7 :0]  A;   
wire            CEN_t0; 
wire            CEN; 
wire    [51:0]  D_t0;   
wire    [51:0]  D;   
wire            GWEN_t0; 
wire            GWEN; 
wire    [51:0]  Q_t0;   
wire    [51:0]  Q;   
wire    [51:0]  WEN_t0; 
wire    [51:0]  WEN; 
assign Q_t0 = '0;
assign Q = '0;

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
(* blackbox *)
(* cellift_noinstrument *)
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
input CLK;
input   [7 :0]  A_t0;   
input   [7 :0]  A;   
input           CEN_t0; 
input           CEN; 
input   [53:0]  D_t0;   
input   [53:0]  D;   
input           GWEN_t0; 
input           GWEN; 
output  [53:0]  Q_t0;   
output  [53:0]  Q;   
input   [53:0]  WEN_t0; 
input   [53:0]  WEN; 
wire    [7 :0]  A_t0;   
wire    [7 :0]  A;   
wire            CEN_t0; 
wire            CEN; 
wire    [53:0]  D_t0;   
wire    [53:0]  D;   
wire            GWEN_t0; 
wire            GWEN; 
wire    [53:0]  Q_t0;   
wire    [53:0]  Q;   
wire    [53:0]  WEN_t0; 
wire    [53:0]  WEN; 
assign Q_t0 = '0;
assign Q = '0;

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
(* blackbox *)
(* cellift_noinstrument *)
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
input CLK;
input   [7 :0]  A_t0;   
input   [7 :0]  A;   
input           CEN_t0; 
input           CEN; 
input   [58:0]  D_t0;   
input   [58:0]  D;   
input           GWEN_t0; 
input           GWEN; 
output  [58:0]  Q_t0;   
output  [58:0]  Q;   
input   [58:0]  WEN_t0; 
input   [58:0]  WEN; 
wire    [7 :0]  A_t0;   
wire    [7 :0]  A;   
wire            CEN_t0; 
wire            CEN; 
wire    [58:0]  D_t0;   
wire    [58:0]  D;   
wire            GWEN_t0; 
wire            GWEN; 
wire    [58:0]  Q_t0;   
wire    [58:0]  Q;   
wire    [58:0]  WEN_t0; 
wire    [58:0]  WEN; 
assign Q_t0 = '0;
assign Q = '0;

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
(* blackbox *)
(* cellift_noinstrument *)
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
input CLK;
input   [7:0]  A_t0;   
input   [7:0]  A;   
input          CEN_t0; 
input          CEN; 
input   [6:0]  D_t0;   
input   [6:0]  D;   
input          GWEN_t0; 
input          GWEN; 
output  [6:0]  Q_t0;   
output  [6:0]  Q;   
input   [6:0]  WEN_t0; 
input   [6:0]  WEN; 
wire    [7:0]  A_t0;   
wire    [7:0]  A;   
wire           CEN_t0; 
wire           CEN; 
wire    [6:0]  D_t0;   
wire    [6:0]  D;   
wire           GWEN_t0; 
wire           GWEN; 
wire    [6:0]  Q_t0;   
wire    [6:0]  Q;   
wire    [6:0]  WEN_t0; 
wire    [6:0]  WEN; 
assign Q_t0 = '0;
assign Q = '0;

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
(* blackbox *)
(* cellift_noinstrument *)
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
input CLK;
input   [7 :0]  A_t0;   
input   [7 :0]  A;   
input           CEN_t0; 
input           CEN; 
input   [83:0]  D_t0;   
input   [83:0]  D;   
input           GWEN_t0; 
input           GWEN; 
output  [83:0]  Q_t0;   
output  [83:0]  Q;   
input   [83:0]  WEN_t0; 
input   [83:0]  WEN; 
wire    [7 :0]  A_t0;   
wire    [7 :0]  A;   
wire            CEN_t0; 
wire            CEN; 
wire    [83:0]  D_t0;   
wire    [83:0]  D;   
wire            GWEN_t0; 
wire            GWEN; 
wire    [83:0]  Q_t0;   
wire    [83:0]  Q;   
wire    [83:0]  WEN_t0; 
wire    [83:0]  WEN; 
assign Q_t0 = '0;
assign Q = '0;

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
(* blackbox *)
(* cellift_noinstrument *)
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
input CLK;
input   [14 :0]  A_t0;   
input   [14 :0]  A;   
input            CEN_t0; 
input            CEN; 
input   [127:0]  D_t0;   
input   [127:0]  D;   
input            GWEN_t0; 
input            GWEN; 
output  [127:0]  Q_t0;   
output  [127:0]  Q;   
input   [127:0]  WEN_t0; 
input   [127:0]  WEN; 
wire    [14 :0]  A_t0;   
wire    [14 :0]  A;   
wire             CEN_t0; 
wire             CEN; 
wire    [127:0]  D_t0;   
wire    [127:0]  D;   
wire             GWEN_t0; 
wire             GWEN; 
wire    [127:0]  Q_t0;   
wire    [127:0]  Q;   
wire    [127:0]  WEN_t0; 
wire    [127:0]  WEN; 
assign Q_t0 = '0;
assign Q = '0;

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
(* blackbox *)
(* cellift_noinstrument *)
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
input CLK;
input   [11 :0]  A_t0;   
input   [11 :0]  A;   
input            CEN_t0; 
input            CEN; 
input   [127:0]  D_t0;   
input   [127:0]  D;   
input            GWEN_t0; 
input            GWEN; 
output  [127:0]  Q_t0;   
output  [127:0]  Q;   
input   [127:0]  WEN_t0; 
input   [127:0]  WEN; 
wire    [11 :0]  A_t0;   
wire    [11 :0]  A;   
wire             CEN_t0; 
wire             CEN; 
wire    [127:0]  D_t0;   
wire    [127:0]  D;   
wire             GWEN_t0; 
wire             GWEN; 
wire    [127:0]  Q_t0;   
wire    [127:0]  Q;   
wire    [127:0]  WEN_t0; 
wire    [127:0]  WEN; 
assign Q_t0 = '0;
assign Q = '0;

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
(* blackbox *)
(* cellift_noinstrument *)
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
input CLK;
input   [11 :0]  A_t0;   
input   [11 :0]  A;   
input            CEN_t0; 
input            CEN; 
input   [143:0]  D_t0;   
input   [143:0]  D;   
input            GWEN_t0; 
input            GWEN; 
output  [143:0]  Q_t0;   
output  [143:0]  Q;   
input   [143:0]  WEN_t0; 
input   [143:0]  WEN; 
wire    [11 :0]  A_t0;   
wire    [11 :0]  A;   
wire             CEN_t0; 
wire             CEN; 
wire    [143:0]  D_t0;   
wire    [143:0]  D;   
wire             GWEN_t0; 
wire             GWEN; 
wire    [143:0]  Q_t0;   
wire    [143:0]  Q;   
wire    [143:0]  WEN_t0; 
wire    [143:0]  WEN; 
assign Q_t0 = '0;
assign Q = '0;

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
(* blackbox *)
(* cellift_noinstrument *)
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
input CLK;
input   [11:0]  A_t0;   
input   [11:0]  A;   
input           CEN_t0; 
input           CEN; 
input   [31:0]  D_t0;   
input   [31:0]  D;   
input           GWEN_t0; 
input           GWEN; 
output  [31:0]  Q_t0;   
output  [31:0]  Q;   
input   [31:0]  WEN_t0; 
input   [31:0]  WEN; 
wire    [11:0]  A_t0;   
wire    [11:0]  A;   
wire            CEN_t0; 
wire            CEN; 
wire    [31:0]  D_t0;   
wire    [31:0]  D;   
wire            GWEN_t0; 
wire            GWEN; 
wire    [31:0]  Q_t0;   
wire    [31:0]  Q;   
wire    [31:0]  WEN_t0; 
wire    [31:0]  WEN; 
assign Q_t0 = '0;
assign Q = '0;

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
(* blackbox *)
(* cellift_noinstrument *)
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
input CLK;
input   [11:0]  A_t0;   
input   [11:0]  A;   
input           CEN_t0; 
input           CEN; 
input   [83:0]  D_t0;   
input   [83:0]  D;   
input           GWEN_t0; 
input           GWEN; 
output  [83:0]  Q_t0;   
output  [83:0]  Q;   
input   [83:0]  WEN_t0; 
input   [83:0]  WEN; 
wire    [11:0]  A_t0;   
wire    [11:0]  A;   
wire            CEN_t0; 
wire            CEN; 
wire    [83:0]  D_t0;   
wire    [83:0]  D;   
wire            GWEN_t0; 
wire            GWEN; 
wire    [83:0]  Q_t0;   
wire    [83:0]  Q;   
wire    [83:0]  WEN_t0; 
wire    [83:0]  WEN; 
assign Q_t0 = '0;
assign Q = '0;

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
(* blackbox *)
(* cellift_noinstrument *)
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
input CLK;
input   [8  :0]  A_t0;   
input   [8  :0]  A;   
input            CEN_t0; 
input            CEN; 
input   [143:0]  D_t0;   
input   [143:0]  D;   
input            GWEN_t0; 
input            GWEN; 
output  [143:0]  Q_t0;   
output  [143:0]  Q;   
input   [143:0]  WEN_t0; 
input   [143:0]  WEN; 
wire    [8  :0]  A_t0;   
wire    [8  :0]  A;   
wire             CEN_t0; 
wire             CEN; 
wire    [143:0]  D_t0;   
wire    [143:0]  D;   
wire             GWEN_t0; 
wire             GWEN; 
wire    [143:0]  Q_t0;   
wire    [143:0]  Q;   
wire    [143:0]  WEN_t0; 
wire    [143:0]  WEN; 
assign Q_t0 = '0;
assign Q = '0;

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
(* blackbox *)
(* cellift_noinstrument *)
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
input CLK;
input   [8 :0]  A_t0;   
input   [8 :0]  A;   
input           CEN_t0; 
input           CEN; 
input   [21:0]  D_t0;   
input   [21:0]  D;   
input           GWEN_t0; 
input           GWEN; 
output  [21:0]  Q_t0;   
output  [21:0]  Q;   
input   [21:0]  WEN_t0; 
input   [21:0]  WEN; 
wire    [8 :0]  A_t0;   
wire    [8 :0]  A;   
wire            CEN_t0; 
wire            CEN; 
wire    [21:0]  D_t0;   
wire    [21:0]  D;   
wire            GWEN_t0; 
wire            GWEN; 
wire    [21:0]  Q_t0;   
wire    [21:0]  Q;   
wire    [21:0]  WEN_t0; 
wire    [21:0]  WEN; 
assign Q_t0 = '0;
assign Q = '0;

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
(* blackbox *)
(* cellift_noinstrument *)
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
input CLK;
input   [8 :0]  A_t0;   
input   [8 :0]  A;   
input           CEN_t0; 
input           CEN; 
input   [43:0]  D_t0;   
input   [43:0]  D;   
input           GWEN_t0; 
input           GWEN; 
output  [43:0]  Q_t0;   
output  [43:0]  Q;   
input   [43:0]  WEN_t0; 
input   [43:0]  WEN; 
wire    [8 :0]  A_t0;   
wire    [8 :0]  A;   
wire            CEN_t0; 
wire            CEN; 
wire    [43:0]  D_t0;   
wire    [43:0]  D;   
wire            GWEN_t0; 
wire            GWEN; 
wire    [43:0]  Q_t0;   
wire    [43:0]  Q;   
wire    [43:0]  WEN_t0; 
wire    [43:0]  WEN; 
assign Q_t0 = '0;
assign Q = '0;

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
(* blackbox *)
(* cellift_noinstrument *)
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
input CLK;
input   [8 :0]  A_t0;   
input   [8 :0]  A;   
input           CEN_t0; 
input           CEN; 
input   [51:0]  D_t0;   
input   [51:0]  D;   
input           GWEN_t0; 
input           GWEN; 
output  [51:0]  Q_t0;   
output  [51:0]  Q;   
input   [51:0]  WEN_t0; 
input   [51:0]  WEN; 
wire    [8 :0]  A_t0;   
wire    [8 :0]  A;   
wire            CEN_t0; 
wire            CEN; 
wire    [51:0]  D_t0;   
wire    [51:0]  D;   
wire            GWEN_t0; 
wire            GWEN; 
wire    [51:0]  Q_t0;   
wire    [51:0]  Q;   
wire    [51:0]  WEN_t0; 
wire    [51:0]  WEN; 
assign Q_t0 = '0;
assign Q = '0;

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
(* blackbox *)
(* cellift_noinstrument *)
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
input CLK;
input   [8 :0]  A_t0;   
input   [8 :0]  A;   
input           CEN_t0; 
input           CEN; 
input   [53:0]  D_t0;   
input   [53:0]  D;   
input           GWEN_t0; 
input           GWEN; 
output  [53:0]  Q_t0;   
output  [53:0]  Q;   
input   [53:0]  WEN_t0; 
input   [53:0]  WEN; 
wire    [8 :0]  A_t0;   
wire    [8 :0]  A;   
wire            CEN_t0; 
wire            CEN; 
wire    [53:0]  D_t0;   
wire    [53:0]  D;   
wire            GWEN_t0; 
wire            GWEN; 
wire    [53:0]  Q_t0;   
wire    [53:0]  Q;   
wire    [53:0]  WEN_t0; 
wire    [53:0]  WEN; 
assign Q_t0 = '0;
assign Q = '0;

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
(* blackbox *)
(* cellift_noinstrument *)
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
input CLK;
input   [8 :0]  A_t0;   
input   [8 :0]  A;   
input           CEN_t0; 
input           CEN; 
input   [58:0]  D_t0;   
input   [58:0]  D;   
input           GWEN_t0; 
input           GWEN; 
output  [58:0]  Q_t0;   
output  [58:0]  Q;   
input   [58:0]  WEN_t0; 
input   [58:0]  WEN; 
wire    [8 :0]  A_t0;   
wire    [8 :0]  A;   
wire            CEN_t0; 
wire            CEN; 
wire    [58:0]  D_t0;   
wire    [58:0]  D;   
wire            GWEN_t0; 
wire            GWEN; 
wire    [58:0]  Q_t0;   
wire    [58:0]  Q;   
wire    [58:0]  WEN_t0; 
wire    [58:0]  WEN; 
assign Q_t0 = '0;
assign Q = '0;

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
(* blackbox *)
(* cellift_noinstrument *)
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
input CLK;
input   [8:0]  A_t0;   
input   [8:0]  A;   
input          CEN_t0; 
input          CEN; 
input   [6:0]  D_t0;   
input   [6:0]  D;   
input          GWEN_t0; 
input          GWEN; 
output  [6:0]  Q_t0;   
output  [6:0]  Q;   
input   [6:0]  WEN_t0; 
input   [6:0]  WEN; 
wire    [8:0]  A_t0;   
wire    [8:0]  A;   
wire           CEN_t0; 
wire           CEN; 
wire    [6:0]  D_t0;   
wire    [6:0]  D;   
wire           GWEN_t0; 
wire           GWEN; 
wire    [6:0]  Q_t0;   
wire    [6:0]  Q;   
wire    [6:0]  WEN_t0; 
wire    [6:0]  WEN; 
assign Q_t0 = '0;
assign Q = '0;

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
(* blackbox *)
(* cellift_noinstrument *)
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
input CLK;
input   [8 :0]  A_t0;   
input   [8 :0]  A;   
input           CEN_t0; 
input           CEN; 
input   [95:0]  D_t0;   
input   [95:0]  D;   
input           GWEN_t0; 
input           GWEN; 
output  [95:0]  Q_t0;   
output  [95:0]  Q;   
input   [95:0]  WEN_t0; 
input   [95:0]  WEN; 
wire    [8 :0]  A_t0;   
wire    [8 :0]  A;   
wire            CEN_t0; 
wire            CEN; 
wire    [95:0]  D_t0;   
wire    [95:0]  D;   
wire            GWEN_t0; 
wire            GWEN; 
wire    [95:0]  Q_t0;   
wire    [95:0]  Q;   
wire    [95:0]  WEN_t0; 
wire    [95:0]  WEN; 
assign Q_t0 = '0;
assign Q = '0;

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
(* blackbox *)
(* cellift_noinstrument *)
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
input CLK;
input   [5  :0]  A_t0;   
input   [5  :0]  A;   
input            CEN_t0; 
input            CEN; 
input   [107:0]  D_t0;   
input   [107:0]  D;   
input            GWEN_t0; 
input            GWEN; 
output  [107:0]  Q_t0;   
output  [107:0]  Q;   
input   [107:0]  WEN_t0; 
input   [107:0]  WEN; 
wire    [5  :0]  A_t0;   
wire    [5  :0]  A;   
wire             CEN_t0; 
wire             CEN; 
wire    [107:0]  D_t0;   
wire    [107:0]  D;   
wire             GWEN_t0; 
wire             GWEN; 
wire    [107:0]  Q_t0;   
wire    [107:0]  Q;   
wire    [107:0]  WEN_t0; 
wire    [107:0]  WEN; 
assign Q_t0 = '0;
assign Q = '0;

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
(* blackbox *)
(* cellift_noinstrument *)
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
input CLK;
input   [15 :0]  A_t0;   
input   [15 :0]  A;   
input            CEN_t0; 
input            CEN; 
input   [127:0]  D_t0;   
input   [127:0]  D;   
input            GWEN_t0; 
input            GWEN; 
output  [127:0]  Q_t0;   
output  [127:0]  Q;   
input   [127:0]  WEN_t0; 
input   [127:0]  WEN; 
wire    [15 :0]  A_t0;   
wire    [15 :0]  A;   
wire             CEN_t0; 
wire             CEN; 
wire    [127:0]  D_t0;   
wire    [127:0]  D;   
wire             GWEN_t0; 
wire             GWEN; 
wire    [127:0]  Q_t0;   
wire    [127:0]  Q;   
wire    [127:0]  WEN_t0; 
wire    [127:0]  WEN; 
assign Q_t0 = '0;
assign Q = '0;

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
(* blackbox *)
(* cellift_noinstrument *)
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
input CLK;
input   [12 :0]  A_t0;   
input   [12 :0]  A;   
input            CEN_t0; 
input            CEN; 
input   [127:0]  D_t0;   
input   [127:0]  D;   
input            GWEN_t0; 
input            GWEN; 
output  [127:0]  Q_t0;   
output  [127:0]  Q;   
input   [127:0]  WEN_t0; 
input   [127:0]  WEN; 
wire    [12 :0]  A_t0;   
wire    [12 :0]  A;   
wire             CEN_t0; 
wire             CEN; 
wire    [127:0]  D_t0;   
wire    [127:0]  D;   
wire             GWEN_t0; 
wire             GWEN; 
wire    [127:0]  Q_t0;   
wire    [127:0]  Q;   
wire    [127:0]  WEN_t0; 
wire    [127:0]  WEN; 
assign Q_t0 = '0;
assign Q = '0;

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
(* blackbox *)
(* cellift_noinstrument *)
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
input CLK;
input   [12:0]  A_t0;   
input   [12:0]  A;   
input           CEN_t0; 
input           CEN; 
input   [31:0]  D_t0;   
input   [31:0]  D;   
input           GWEN_t0; 
input           GWEN; 
output  [31:0]  Q_t0;   
output  [31:0]  Q;   
input   [31:0]  WEN_t0; 
input   [31:0]  WEN; 
wire    [12:0]  A_t0;   
wire    [12:0]  A;   
wire            CEN_t0; 
wire            CEN; 
wire    [31:0]  D_t0;   
wire    [31:0]  D;   
wire            GWEN_t0; 
wire            GWEN; 
wire    [31:0]  Q_t0;   
wire    [31:0]  Q;   
wire    [31:0]  WEN_t0; 
wire    [31:0]  WEN; 
assign Q_t0 = '0;
assign Q = '0;

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























(* blackbox *)
(* cellift_noinstrument *)
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
input CLK;
input   [ADDR_WIDTH-1:0]  A_t0;           
input   [ADDR_WIDTH-1:0]  A;           
input           CEN_t0;         
input           CEN;         
input   [127:0] D_t0;           
input   [127:0] D;           
output  [127:0] Q_t0;           
output  [127:0] Q;           
input   [15:0]  WEN_t0;         
input   [15:0]  WEN;         
wire    [ADDR_WIDTH-1:0]  A_t0;           
wire    [ADDR_WIDTH-1:0]  A;           
wire            CEN_t0;         
wire            CEN;         
wire    [127:0] D_t0;           
wire    [127:0] D;           
wire    [127:0] Q_t0;           
wire    [127:0] Q;           
wire    [15:0]  WEN_t0;         
wire    [15:0]  WEN;         
assign Q_t0 = '0;
assign Q = '0;

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























(* blackbox *)
(* cellift_noinstrument *)
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
input CLK;
input   [14:0]  A_t0;           
input   [14:0]  A;           
input           CEN_t0;         
input           CEN;         
input   [127:0] D_t0;           
input   [127:0] D;           
output  [127:0] Q_t0;           
output  [127:0] Q;           
input   [15:0]  WEN_t0;         
input   [15:0]  WEN;         
wire    [14:0]  A_t0;           
wire    [14:0]  A;           
wire            CEN_t0;         
wire            CEN;         
wire    [127:0] D_t0;           
wire    [127:0] D;           
wire    [127:0] Q_t0;           
wire    [127:0] Q;           
wire    [15:0]  WEN_t0;         
wire    [15:0]  WEN;         
assign Q_t0 = '0;
assign Q = '0;

endmodule

