import "DPI-C" function string getenv(input string env_name);

module tb_top();

    localparam time CLK_PERIOD          = 50ns;
    localparam time APPL_DELAY          = 10ns;
    localparam time ACQ_DELAY           = 30ns;
    localparam unsigned RST_CLK_CYCLES  = 10;
    localparam unsigned TOT_STIMS       = 10000;
    localparam unsigned TIMEOUT_LIM     = 1000;

    localparam int unsigned SRAM_ADDR_WIDTH = 21;
    localparam int unsigned SRAM_DATA_WIDTH = 128;

    localparam type addr_t = logic [SRAM_ADDR_WIDTH-1:0];
    localparam type data_t = logic [SRAM_DATA_WIDTH-1:0];
    localparam type strb_t = logic [SRAM_DATA_WIDTH-1:0];

    localparam [63:0] ADDR_STOP_SIG = 0;
    localparam [63:0] ADDR_BHT_LOG_SIG_START = 8;
    localparam [63:0] ADDR_BHT_LOG_SIG_STOP = 16;

    logic clk;
    logic rst_n;

    bit do_log_bht;

    logic  mem_req;
    addr_t mem_addr;
    data_t mem_wdata;
    strb_t mem_strb;
    logic  mem_we;
    data_t mem_rdata;

    clk_rst_gen #(
        .ClkPeriod     (CLK_PERIOD),
        .RstClkCycles (RST_CLK_CYCLES)
    ) i_clk_rst_gen (
        .clk_o  (clk),
        .rst_no (rst_n)
    );

    openc910_tiny_soc i_dut (
        .i_pad_clk(clk),
        .i_pad_rst_b(rst_n),

        .i_pad_jtg_tclk(1'b0),
        .i_pad_jtg_tdi(1'b0),
        .i_pad_jtg_tms(1'b0),
        .i_pad_jtg_trst_b(1'b0),
        .i_pad_uart0_sin(1'b0),

        .o_pad_jtg_tdo(),
        .o_pad_uart0_sout(),
        .b_pad_gpio_porta(),

        .mem_req_o(mem_req),
        .mem_addr_o(mem_addr),
        .mem_wdata_o(mem_wdata),
        .mem_strb_o(mem_strb),
        .mem_we_o(mem_we),
        .mem_rdata_o(mem_rdata)
    );

    initial begin: application_block
        wait (rst_n);

        @(posedge clk);
        #(APPL_DELAY);
    end

    initial begin: acquisition_block
        bit got_stop_req;
        int remaining_before_stop;
        int step_id;
        int simlen;

        int int_req_dump_id = 1;
        int float_req_dump_id = 0;

        do_log_bht = 1'b0;

        wait (rst_n);

        got_stop_req = 0;
        step_id = 0;
        remaining_before_stop = 50;
        simlen = getenv("SIMLEN").atoi();

        forever begin
            @(posedge clk);
            #(ACQ_DELAY);

            // Check whether got a stop request
            if (!got_stop_req &&
                    mem_req &&
                    mem_we &&
                    // mem_wdata == 0 &&
                    mem_addr == ADDR_STOP_SIG) begin
                $display("Found a stop request. Stopping the benchmark after ", remaining_before_stop, " more ticks.");
                got_stop_req = 1;
            end

            // Start logging BHT
            if (!got_stop_req &&
                    mem_req &&
                    mem_we &&
                    mem_addr == ADDR_BHT_LOG_SIG_START) begin
                $display("Starting to log BHT operations.");
                do_log_bht = 1'b1;
            end
            // Start logging BHT
            if (!got_stop_req &&
                    mem_req &&
                    mem_we &&
                    mem_addr == ADDR_BHT_LOG_SIG_STOP) begin
                $display("Stopping logging BHT operations.");
                do_log_bht = 1'b0;
            end

            // Get the BHT log
            if (!got_stop_req && do_log_bht) begin
                if (!i_dut.i_cpu_sub_system_axi.x_rv_integration_platform.x_cpu_top.x_ct_top_0.x_ct_core.x_ct_ifu_top.x_ct_ifu_bht.bht_pred_array_cen_b) begin
                    $display("BHT clock enabled.");
                end else begin
                    $display("BHT clock disabled.");
                end
            end

            // Decrement if got a stop request.
            if (got_stop_req)
                if (remaining_before_stop-- == 0)
                    break;

            // "Natural" stop since SIMLEN has been reached
            if (step_id == simlen-1) begin
                $display("Reached SIMLEN (%d cycles). Stopping.", simlen);
                break;
            end

            step_id++;
        end

        $stop();
    end

endmodule
