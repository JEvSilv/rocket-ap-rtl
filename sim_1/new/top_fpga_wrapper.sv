`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.11.2024 21:05:44
// Design Name: 
// Module Name: top_fpga_wrapper
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top_fpga_wrapper();

  reg [1024 * 8 - 1:0] path_dtim;
  reg [31:0] dtim_input [0:4095];
  reg clock;
  reg reset;

 //reg CLK100MHZ; 
 //reg ck_rst; 
 wire led_0; 
 wire led_1; 
 wire led_2; 
 wire led_3; 
 wire led0_r; 
 wire led0_g; 
 wire led0_b; 
 wire led1_r; 
 wire led1_g; 
 wire led1_b; 
 wire led2_r; 
 wire led2_g; 
 wire led2_b; 
 wire sw_0; 
 wire sw_1; 
 wire sw_2; 
 wire sw_3; 
 wire btn_0; 
 wire btn_1; 
 wire btn_2; 
 wire btn_3; 
 wire qspi_cs; 
 wire qspi_sck; 
 wire qspi_dq_0; 
 wire qspi_dq_1; 
 wire qspi_dq_2; 
 wire qspi_dq_3; 
 wire uart_rxd_out; 
 wire uart_txd_in; 
 wire ja_0; 
 wire ja_1; 
 wire ja_2; 
 wire ja_3; 
 wire ja_4; 
 wire ja_5; 
 wire ja_6; 
 wire ja_7; 
 wire jd_0; 
 wire jd_1; 
 wire jd_2; 
 wire jd_4; 
 wire jd_5; 
 wire jd_6; 
 wire ck_io_0; 
 wire ck_io_1; 
 wire ck_io_2; 
 wire ck_io_3; 
 wire ck_io_4; 
 wire ck_io_5; 
 wire ck_io_6; 
 wire ck_io_7; 
 wire ck_io_8; 
 wire ck_io_9; 
 wire ck_io_10; 
 wire ck_io_11; 
 wire ck_io_12; 
 wire ck_io_13; 
 wire ck_io_14; 
 wire ck_io_15; 
 wire ck_io_16; 
 wire ck_io_17; 
 wire ck_io_18; 
 wire ck_io_19; 
 wire ck_miso; 
 wire ck_mosi; 
 wire ck_ss; 
 wire ck_sck;

E300ArtyDevKitFPGAChip chip( 
     clock, 
     reset, 
     led_0, 
     led_1, 
     led_2, 
     led_3, 
     led0_r, 
     led0_g, 
     led0_b, 
     led1_r, 
     led1_g, 
     led1_b, 
     led2_r, 
     led2_g, 
     led2_b, 
     sw_0, 
     sw_1, 
     sw_2, 
     sw_3, 
     btn_0, 
     btn_1, 
     btn_2, 
     btn_3, 
     qspi_cs, 
     qspi_sck, 
     qspi_dq_0, 
     qspi_dq_1, 
     qspi_dq_2, 
     qspi_dq_3, 
     uart_rxd_out, 
     uart_txd_in, 
     ja_0, 
     ja_1, 
     ja_2, 
     ja_3, 
     ja_4, 
     ja_5, 
     ja_6, 
     ja_7, 
     jd_0, 
     jd_1, 
     jd_2, 
     jd_4, 
     jd_5, 
     jd_6, 
     ck_io_0, 
     ck_io_1, 
     ck_io_2, 
     ck_io_3, 
     ck_io_4, 
     ck_io_5, 
     ck_io_6, 
     ck_io_7, 
     ck_io_8, 
     ck_io_9, 
     ck_io_10, 
     ck_io_11, 
     ck_io_12, 
     ck_io_13, 
     ck_io_14, 
     ck_io_15, 
     ck_io_16, 
     ck_io_17, 
     ck_io_18, 
     ck_io_19, 
     ck_miso, 
     ck_mosi, 
     ck_ss, 
     ck_sck 
);

  
  
  initial clock = 0;
  always #1 clock = ~clock;

  always @ (posedge clock) begin
    if (top_fpga_wrapper.chip.E300ArtyDevKitPlatform.sys.tile.dcache.data.data_arrays_0_0[0] == 8'hff) begin
      $finish;
    end
  end

  task init_dtim_input();
    for (int i = 0; i < 4096; i++) begin
        dtim_input[i] <= 0; 
    end
  endtask;
  
  task init_itim();
    path_dtim = "C:/Users/Jonin/rocket_chip_rv32im_arty/rocket_chip_rv32im_arty.srcs/sources_1/imports/jonathassilveira-riscv-design-e6861d42ba7e/e300artydevkit/hello_dtim.hex";
    $readmemh(path_dtim, dtim_input);

    for (int i = 0; i < 2048; i++) begin
        top_fpga_wrapper.chip.E300ArtyDevKitPlatform.sys.tile.frontend.icache.data_arrays_0_0[i] <= dtim_input[i];
        top_fpga_wrapper.chip.E300ArtyDevKitPlatform.sys.tile.frontend.icache.data_arrays_0_1[i + 2048] <= dtim_input[i + 2048];
    end
  endtask;

  int interval = 5;
  
  initial begin
    reset <= 1;
    // top_fpga_wrapper.chip.E300ArtyDevKitPlatform.sys_debug_ndreset = 0;
    #(interval * 1ns); 
    init_itim();
    #(interval * 1ns); 
    reset <= 0;
    // top_fpga_wrapper.chip.E300ArtyDevKitPlatform.sys_debug_ndreset = 1;
    top_fpga_wrapper.chip.E300ArtyDevKitPlatform.sys.tile.frontend.icache.scratchpadOn <= 1;
  end

endmodule