set LIB work

# set VOPT_ARGS ""

set VOPT_ARGS "-voptargs= +acc -debugdb"

vsim $VOPT_ARGS -pedanticerrors -lib $LIB tb_top

log -r /tb_top/i_dut/*

# Toplevel
add wave /tb_top/i_dut/i_pad_clk 
add wave /tb_top/i_dut/mem_req_o 
add wave /tb_top/i_dut/mem_we_o 

# bht
add wave /tb_top/i_dut/x_cpu_sub_system_axi/x_rv_integration_platform/x_cpu_top/x_ct_top_0/x_ct_core/x_ct_ifu_top/x_ct_ifu_bht/bht_sel_array_clk_en
add wave /tb_top/i_dut/x_cpu_sub_system_axi/x_rv_integration_platform/x_cpu_top/x_ct_top_0/x_ct_core/x_ct_ifu_top/x_ct_ifu_bht/bht_pre_array_clk_en
add wave /tb_top/i_dut/x_cpu_sub_system_axi/x_rv_integration_platform/x_cpu_top/x_ct_top_0/x_ct_core/x_ct_ifu_top/x_ct_ifu_bht/bht_sel_bwen
add wave /tb_top/i_dut/x_cpu_sub_system_axi/x_rv_integration_platform/x_cpu_top/x_ct_top_0/x_ct_core/x_ct_ifu_top/x_ct_ifu_bht/bht_pred_bwen

add wave /tb_top/i_dut/x_cpu_sub_system_axi/x_rv_integration_platform/x_cpu_top/x_ct_top_0/x_ct_core/x_ct_ifu_top/x_ct_ifu_bht/bht_inval_cnt 

# btb
add wave /tb_top/i_dut/x_cpu_sub_system_axi/x_rv_integration_platform/x_cpu_top/x_ct_top_0/x_ct_core/x_ct_ifu_top/x_ct_ifu_btb/btb_tag_wen 
add wave /tb_top/i_dut/x_cpu_sub_system_axi/x_rv_integration_platform/x_cpu_top/x_ct_top_0/x_ct_core/x_ct_ifu_top/x_ct_ifu_btb/btb_data_wen 
add wave /tb_top/i_dut/x_cpu_sub_system_axi/x_rv_integration_platform/x_cpu_top/x_ct_top_0/x_ct_core/x_ct_ifu_top/x_ct_ifu_btb/btb_tag_clk_en 
add wave /tb_top/i_dut/x_cpu_sub_system_axi/x_rv_integration_platform/x_cpu_top/x_ct_top_0/x_ct_core/x_ct_ifu_top/x_ct_ifu_btb/btb_data_clk_en 

add wave /tb_top/i_dut/x_cpu_sub_system_axi/x_rv_integration_platform/x_cpu_top/x_ct_top_0/x_ct_core/x_ct_ifu_top/x_ct_ifu_btb/btb_index 
add wave /tb_top/i_dut/x_cpu_sub_system_axi/x_rv_integration_platform/x_cpu_top/x_ct_top_0/x_ct_core/x_ct_ifu_top/x_ct_ifu_btb/btb_inval_cnt 

# PC
add wave /tb_top/i_dut/x_cpu_sub_system_axi/x_rv_integration_platform/x_cpu_top/x_ct_top_0/x_ct_core/x_ct_ifu_top/x_ct_ifu_ipdp/ip_vpc 
add wave /tb_top/i_dut/x_cpu_sub_system_axi/x_rv_integration_platform/x_cpu_top/x_ct_top_0/x_ct_core/x_ct_ifu_top/x_ct_ifu_ipdp/bht_result 

# if {$DEBUG == "ON"} {
#     add wave -r /i_gift/*
# }

run -a

# if {$COVERAGE == "ON"} {
#     coverage report -summary -out myreport.txt
#     coverage report -html
# }
