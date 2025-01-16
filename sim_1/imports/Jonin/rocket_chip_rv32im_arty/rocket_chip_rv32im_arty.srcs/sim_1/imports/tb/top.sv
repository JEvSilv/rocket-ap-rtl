`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.07.2024 09:56:14
// Design Name: 
// Module Name: top
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

module top ();

  reg test;
  `ifdef RANDOMIZE_GARBAGE_ASSIGN
      assign test = 1;
  `else
      assign test = 0;
  `endif
  
  reg io_success;
  reg clock;
  reg reset;

  reg [1024 * 8 - 1:0] path_dtim;
  reg [31:0] dtim_input [0:4095];
  
  // system regs
  reg debug_systemjtag_jtag_TCK;
  reg debug_systemjtag_jtag_TMS;
  reg debug_systemjtag_jtag_TDI;
  reg debug_systemjtag_jtag_TDO_data;
  reg debug_systemjtag_jtag_TDO_driven;
  reg debug_systemjtag_reset;
  reg debug_ndreset;
  reg uart_0_txd;
  reg uart_0_rxd;
  reg uart_1_txd;
  reg uart_1_rxd;
  reg spi_0_sck;
  reg spi_0_dq_0_i;
  reg spi_0_dq_0_o;
  reg spi_0_dq_0_oe;
  reg spi_0_dq_1_i;
  reg spi_0_dq_1_o;
  reg spi_0_dq_1_oe;
  reg spi_0_dq_2_i;
  reg spi_0_dq_3_i;
  reg spi_0_cs_0;
  reg spi_0_cs_2;
  reg spi_0_cs_3;
  reg spi_1_sck;
  reg spi_1_dq_0_i;
  reg spi_1_dq_0_o;
  reg spi_1_dq_0_oe;
  reg spi_1_dq_1_i;
  reg spi_1_dq_1_o;
  reg spi_1_dq_1_oe;
  reg spi_1_dq_2_i;
  reg spi_1_dq_2_o;
  reg spi_1_dq_2_oe;
  reg spi_1_dq_3_i;
  reg spi_1_dq_3_o;
  reg spi_1_dq_3_oe;
  reg spi_1_cs_0;
  reg gpio_0_pins_0_i_ival;
  reg gpio_0_pins_0_o_oval;
  reg gpio_0_pins_0_o_oe;
  reg gpio_0_pins_0_o_ie;
  reg gpio_0_pins_1_i_ival;
  reg gpio_0_pins_1_o_oval;
  reg gpio_0_pins_1_o_oe;
  reg gpio_0_pins_1_o_ie;
  reg gpio_0_pins_2_i_ival;
  reg gpio_0_pins_2_o_oval;
  reg gpio_0_pins_2_o_oe;
  reg gpio_0_pins_2_o_ie;
  reg gpio_0_pins_3_i_ival;
  reg gpio_0_pins_3_o_oval;
  reg gpio_0_pins_3_o_oe;
  reg gpio_0_pins_3_o_ie;
  reg gpio_0_pins_4_i_ival;
  reg gpio_0_pins_4_o_oval;
  reg gpio_0_pins_4_o_oe;
  reg gpio_0_pins_4_o_ie;
  reg gpio_0_pins_5_i_ival;
  reg gpio_0_pins_5_o_oval;
  reg gpio_0_pins_5_o_oe;
  reg gpio_0_pins_5_o_ie;
  reg gpio_0_pins_9_i_ival;
  reg gpio_0_pins_9_o_oval;
  reg gpio_0_pins_9_o_oe;
  reg gpio_0_pins_9_o_ie;
  reg gpio_0_pins_10_i_ival;
  reg gpio_0_pins_10_o_oval;
  reg gpio_0_pins_10_o_oe;
  reg gpio_0_pins_10_o_ie;
  reg gpio_0_pins_11_i_ival;
  reg gpio_0_pins_11_o_oval;
  reg gpio_0_pins_11_o_oe;
  reg gpio_0_pins_11_o_ie;
  reg gpio_0_pins_12_i_ival;
  reg gpio_0_pins_12_o_oval;
  reg gpio_0_pins_12_o_oe;
  reg gpio_0_pins_12_o_ie;
  reg gpio_0_pins_13_i_ival;
  reg gpio_0_pins_13_o_oval;
  reg gpio_0_pins_13_o_oe;
  reg gpio_0_pins_13_o_ie;
  reg gpio_0_pins_14_i_ival;
  reg gpio_0_pins_14_o_oval;
  reg gpio_0_pins_14_o_oe;
  reg gpio_0_pins_14_o_ie;
  reg gpio_0_pins_15_i_ival;
  reg gpio_0_pins_15_o_oval;
  reg gpio_0_pins_15_o_oe;
  reg gpio_0_pins_15_o_ie;
  reg gpio_0_pins_16_i_ival;
  reg gpio_0_pins_16_o_oval;
  reg gpio_0_pins_16_o_oe;
  reg gpio_0_pins_16_o_ie;
  reg gpio_0_pins_17_i_ival;
  reg gpio_0_pins_17_o_oval;
  reg gpio_0_pins_17_o_oe;
  reg gpio_0_pins_17_o_ie;
  reg gpio_0_pins_18_i_ival;
  reg gpio_0_pins_18_o_oval;
  reg gpio_0_pins_18_o_oe;
  reg gpio_0_pins_18_o_ie;
  reg gpio_0_pins_19_i_ival;
  reg gpio_0_pins_19_o_oval;
  reg gpio_0_pins_19_o_oe;
  reg gpio_0_pins_19_o_ie;
  reg gpio_0_pins_20_i_ival;
  reg gpio_0_pins_20_o_oval;
  reg gpio_0_pins_20_o_oe;
  reg gpio_0_pins_20_o_ie;
  reg gpio_0_pins_21_i_ival;
  reg gpio_0_pins_21_o_oval;
  reg gpio_0_pins_21_o_oe;
  reg gpio_0_pins_21_o_ie;
  reg gpio_0_pins_22_i_ival;
  reg gpio_0_pins_22_o_oval;
  reg gpio_0_pins_22_o_oe;
  reg gpio_0_pins_22_o_ie;
  reg gpio_0_pins_23_i_ival;
  reg gpio_0_pins_23_o_oval;
  reg gpio_0_pins_23_o_oe;
  reg gpio_0_pins_23_o_ie;
  reg gpio_0_pins_24_i_ival;
  reg gpio_0_pins_24_o_oval;
  reg gpio_0_pins_24_o_oe;
  reg gpio_0_pins_24_o_ie;
  reg gpio_0_pins_25_i_ival;
  reg gpio_0_pins_25_o_oval;
  reg gpio_0_pins_25_o_oe;
  reg gpio_0_pins_25_o_ie;
  reg gpio_0_pins_26_i_ival;
  reg gpio_0_pins_26_o_oval;
  reg gpio_0_pins_26_o_oe;
  reg gpio_0_pins_26_o_ie;
  reg gpio_0_pins_27_i_ival;
  reg gpio_0_pins_27_o_oval;
  reg gpio_0_pins_27_o_oe;
  reg gpio_0_pins_27_o_ie;
  reg gpio_0_pins_28_i_ival;
  reg gpio_0_pins_28_o_oval;
  reg gpio_0_pins_28_o_oe;
  reg gpio_0_pins_28_o_ie;
  reg gpio_0_pins_29_i_ival;
  reg gpio_0_pins_29_o_oval;
  reg gpio_0_pins_29_o_oe;
  reg gpio_0_pins_29_o_ie;
  reg gpio_0_pins_30_i_ival;
  reg gpio_0_pins_30_o_oval;
  reg gpio_0_pins_30_o_oe;
  reg gpio_0_pins_30_o_ie;
  reg gpio_0_pins_31_i_ival;
  reg gpio_0_pins_31_o_oval;
  reg gpio_0_pins_31_o_oe;
  reg gpio_0_pins_31_o_ie;
  reg gpio_0_iof_0_2_o_oval;
  reg gpio_0_iof_0_3_i_ival;
  reg gpio_0_iof_0_3_o_oval;
  reg gpio_0_iof_0_3_o_oe;
  reg gpio_0_iof_0_3_o_ie;
  reg gpio_0_iof_0_4_i_ival;
  reg gpio_0_iof_0_4_o_oval;
  reg gpio_0_iof_0_4_o_oe;
  reg gpio_0_iof_0_4_o_ie;
  reg gpio_0_iof_0_5_o_oval;
  reg gpio_0_iof_0_6_i_ival;
  reg gpio_0_iof_0_7_i_ival;
  reg gpio_0_iof_0_9_o_oval;
  reg gpio_0_iof_0_10_o_oval;
  reg gpio_0_iof_0_12_i_ival;
  reg gpio_0_iof_0_12_o_oe;
  reg gpio_0_iof_0_13_i_ival;
  reg gpio_0_iof_0_13_o_oe;
  reg gpio_0_iof_0_16_i_ival;
  reg gpio_0_iof_0_17_o_oval;
  reg gpio_0_iof_0_24_i_ival;
  reg gpio_0_iof_0_25_o_oval;
  reg gpio_0_iof_0_26_o_oval;
  reg gpio_0_iof_0_27_i_ival;
  reg gpio_0_iof_0_27_o_oval;
  reg gpio_0_iof_0_27_o_oe;
  reg gpio_0_iof_0_27_o_ie;
  reg gpio_0_iof_0_28_i_ival;
  reg gpio_0_iof_0_28_o_oval;
  reg gpio_0_iof_0_28_o_oe;
  reg gpio_0_iof_0_28_o_ie;
  reg gpio_0_iof_0_29_o_oval;
  reg gpio_0_iof_0_30_i_ival;
  reg gpio_0_iof_0_30_o_oval;
  reg gpio_0_iof_0_30_o_oe;
  reg gpio_0_iof_0_30_o_ie;
  reg gpio_0_iof_0_31_i_ival;
  reg gpio_0_iof_0_31_o_oval;
  reg gpio_0_iof_0_31_o_oe;
  reg gpio_0_iof_0_31_o_ie;
  reg gpio_0_iof_1_0_o_oval;
  reg gpio_0_iof_1_1_o_oval;
  reg gpio_0_iof_1_2_o_oval;
  reg gpio_0_iof_1_3_o_oval;
  reg gpio_0_iof_1_10_o_oval;
  reg gpio_0_iof_1_11_o_oval;
  reg gpio_0_iof_1_12_o_oval;
  reg gpio_0_iof_1_13_o_oval;
  reg gpio_0_iof_1_19_o_oval;
  reg gpio_0_iof_1_20_o_oval;
  reg gpio_0_iof_1_21_o_oval;
  reg gpio_0_iof_1_22_o_oval;
  reg qspi_0_sck;
  reg qspi_0_dq_0_i;
  reg qspi_0_dq_0_o;
  reg qspi_0_dq_0_oe;
  reg qspi_0_dq_1_i;
  reg qspi_0_dq_1_o;
  reg qspi_0_dq_1_oe;
  reg qspi_0_dq_2_i;
  reg qspi_0_dq_2_o;
  reg qspi_0_dq_2_oe;
  reg qspi_0_dq_3_i;
  reg qspi_0_dq_3_o;
  reg qspi_0_dq_3_oe;
  reg qspi_0_cs_0;
  reg aon_pins_erst_n_i_ival;
  reg aon_pins_lfextclk_i_ival;
  reg aon_pins_pmu_dwakeup_n_i_ival;
  reg aon_rsts_corerst;
  reg pwm_0_gpio_0;
  reg pwm_0_gpio_1;
  reg pwm_0_gpio_2;
  reg pwm_0_gpio_3;
  reg pwm_1_gpio_0;
  reg pwm_1_gpio_1;
  reg pwm_1_gpio_2;
  reg pwm_1_gpio_3;
  reg pwm_2_gpio_0;
  reg pwm_2_gpio_1;
  reg pwm_2_gpio_2;
  reg pwm_2_gpio_3;
  reg i2c_0_scl_in;
  reg i2c_0_scl_oe;
  reg i2c_0_sda_in;
  reg i2c_0_sda_oe;


  E300ArtyDevKitSystem sys (
      clock,
      reset,
      debug_systemjtag_jtag_TCK,
      debug_systemjtag_jtag_TMS,
      debug_systemjtag_jtag_TDI,
      debug_systemjtag_jtag_TDO_data,
      debug_systemjtag_jtag_TDO_driven,
      debug_systemjtag_reset,
      debug_ndreset,
      uart_0_txd,
      uart_0_rxd,
      uart_1_txd,
      uart_1_rxd,
      spi_0_sck,
      spi_0_dq_0_i,
      spi_0_dq_0_o,
      spi_0_dq_0_oe,
      spi_0_dq_1_i,
      spi_0_dq_1_o,
      spi_0_dq_1_oe,
      spi_0_dq_2_i,
      spi_0_dq_3_i,
      spi_0_cs_0,
      spi_0_cs_2,
      spi_0_cs_3,
      spi_1_sck,
      spi_1_dq_0_i,
      spi_1_dq_0_o,
      spi_1_dq_0_oe,
      spi_1_dq_1_i,
      spi_1_dq_1_o,
      spi_1_dq_1_oe,
      spi_1_dq_2_i,
      spi_1_dq_2_o,
      spi_1_dq_2_oe,
      spi_1_dq_3_i,
      spi_1_dq_3_o,
      spi_1_dq_3_oe,
      spi_1_cs_0,
      gpio_0_pins_0_i_ival,
      gpio_0_pins_0_o_oval,
      gpio_0_pins_0_o_oe,
      gpio_0_pins_0_o_ie,
      gpio_0_pins_1_i_ival,
      gpio_0_pins_1_o_oval,
      gpio_0_pins_1_o_oe,
      gpio_0_pins_1_o_ie,
      gpio_0_pins_2_i_ival,
      gpio_0_pins_2_o_oval,
      gpio_0_pins_2_o_oe,
      gpio_0_pins_2_o_ie,
      gpio_0_pins_3_i_ival,
      gpio_0_pins_3_o_oval,
      gpio_0_pins_3_o_oe,
      gpio_0_pins_3_o_ie,
      gpio_0_pins_4_i_ival,
      gpio_0_pins_4_o_oval,
      gpio_0_pins_4_o_oe,
      gpio_0_pins_4_o_ie,
      gpio_0_pins_5_i_ival,
      gpio_0_pins_5_o_oval,
      gpio_0_pins_5_o_oe,
      gpio_0_pins_5_o_ie,
      gpio_0_pins_9_i_ival,
      gpio_0_pins_9_o_oval,
      gpio_0_pins_9_o_oe,
      gpio_0_pins_9_o_ie,
      gpio_0_pins_10_i_ival,
      gpio_0_pins_10_o_oval,
      gpio_0_pins_10_o_oe,
      gpio_0_pins_10_o_ie,
      gpio_0_pins_11_i_ival,
      gpio_0_pins_11_o_oval,
      gpio_0_pins_11_o_oe,
      gpio_0_pins_11_o_ie,
      gpio_0_pins_12_i_ival,
      gpio_0_pins_12_o_oval,
      gpio_0_pins_12_o_oe,
      gpio_0_pins_12_o_ie,
      gpio_0_pins_13_i_ival,
      gpio_0_pins_13_o_oval,
      gpio_0_pins_13_o_oe,
      gpio_0_pins_13_o_ie,
      gpio_0_pins_14_i_ival,
      gpio_0_pins_14_o_oval,
      gpio_0_pins_14_o_oe,
      gpio_0_pins_14_o_ie,
      gpio_0_pins_15_i_ival,
      gpio_0_pins_15_o_oval,
      gpio_0_pins_15_o_oe,
      gpio_0_pins_15_o_ie,
      gpio_0_pins_16_i_ival,
      gpio_0_pins_16_o_oval,
      gpio_0_pins_16_o_oe,
      gpio_0_pins_16_o_ie,
      gpio_0_pins_17_i_ival,
      gpio_0_pins_17_o_oval,
      gpio_0_pins_17_o_oe,
      gpio_0_pins_17_o_ie,
      gpio_0_pins_18_i_ival,
      gpio_0_pins_18_o_oval,
      gpio_0_pins_18_o_oe,
      gpio_0_pins_18_o_ie,
      gpio_0_pins_19_i_ival,
      gpio_0_pins_19_o_oval,
      gpio_0_pins_19_o_oe,
      gpio_0_pins_19_o_ie,
      gpio_0_pins_20_i_ival,
      gpio_0_pins_20_o_oval,
      gpio_0_pins_20_o_oe,
      gpio_0_pins_20_o_ie,
      gpio_0_pins_21_i_ival,
      gpio_0_pins_21_o_oval,
      gpio_0_pins_21_o_oe,
      gpio_0_pins_21_o_ie,
      gpio_0_pins_22_i_ival,
      gpio_0_pins_22_o_oval,
      gpio_0_pins_22_o_oe,
      gpio_0_pins_22_o_ie,
      gpio_0_pins_23_i_ival,
      gpio_0_pins_23_o_oval,
      gpio_0_pins_23_o_oe,
      gpio_0_pins_23_o_ie,
      gpio_0_pins_24_i_ival,
      gpio_0_pins_24_o_oval,
      gpio_0_pins_24_o_oe,
      gpio_0_pins_24_o_ie,
      gpio_0_pins_25_i_ival,
      gpio_0_pins_25_o_oval,
      gpio_0_pins_25_o_oe,
      gpio_0_pins_25_o_ie,
      gpio_0_pins_26_i_ival,
      gpio_0_pins_26_o_oval,
      gpio_0_pins_26_o_oe,
      gpio_0_pins_26_o_ie,
      gpio_0_pins_27_i_ival,
      gpio_0_pins_27_o_oval,
      gpio_0_pins_27_o_oe,
      gpio_0_pins_27_o_ie,
      gpio_0_pins_28_i_ival,
      gpio_0_pins_28_o_oval,
      gpio_0_pins_28_o_oe,
      gpio_0_pins_28_o_ie,
      gpio_0_pins_29_i_ival,
      gpio_0_pins_29_o_oval,
      gpio_0_pins_29_o_oe,
      gpio_0_pins_29_o_ie,
      gpio_0_pins_30_i_ival,
      gpio_0_pins_30_o_oval,
      gpio_0_pins_30_o_oe,
      gpio_0_pins_30_o_ie,
      gpio_0_pins_31_i_ival,
      gpio_0_pins_31_o_oval,
      gpio_0_pins_31_o_oe,
      gpio_0_pins_31_o_ie,
      gpio_0_iof_0_2_o_oval,
      gpio_0_iof_0_3_i_ival,
      gpio_0_iof_0_3_o_oval,
      gpio_0_iof_0_3_o_oe,
      gpio_0_iof_0_3_o_ie,
      gpio_0_iof_0_4_i_ival,
      gpio_0_iof_0_4_o_oval,
      gpio_0_iof_0_4_o_oe,
      gpio_0_iof_0_4_o_ie,
      gpio_0_iof_0_5_o_oval,
      gpio_0_iof_0_6_i_ival,
      gpio_0_iof_0_7_i_ival,
      gpio_0_iof_0_9_o_oval,
      gpio_0_iof_0_10_o_oval,
      gpio_0_iof_0_12_i_ival,
      gpio_0_iof_0_12_o_oe,
      gpio_0_iof_0_13_i_ival,
      gpio_0_iof_0_13_o_oe,
      gpio_0_iof_0_16_i_ival,
      gpio_0_iof_0_17_o_oval,
      gpio_0_iof_0_24_i_ival,
      gpio_0_iof_0_25_o_oval,
      gpio_0_iof_0_26_o_oval,
      gpio_0_iof_0_27_i_ival,
      gpio_0_iof_0_27_o_oval,
      gpio_0_iof_0_27_o_oe,
      gpio_0_iof_0_27_o_ie,
      gpio_0_iof_0_28_i_ival,
      gpio_0_iof_0_28_o_oval,
      gpio_0_iof_0_28_o_oe,
      gpio_0_iof_0_28_o_ie,
      gpio_0_iof_0_29_o_oval,
      gpio_0_iof_0_30_i_ival,
      gpio_0_iof_0_30_o_oval,
      gpio_0_iof_0_30_o_oe,
      gpio_0_iof_0_30_o_ie,
      gpio_0_iof_0_31_i_ival,
      gpio_0_iof_0_31_o_oval,
      gpio_0_iof_0_31_o_oe,
      gpio_0_iof_0_31_o_ie,
      gpio_0_iof_1_0_o_oval,
      gpio_0_iof_1_1_o_oval,
      gpio_0_iof_1_2_o_oval,
      gpio_0_iof_1_3_o_oval,
      gpio_0_iof_1_10_o_oval,
      gpio_0_iof_1_11_o_oval,
      gpio_0_iof_1_12_o_oval,
      gpio_0_iof_1_13_o_oval,
      gpio_0_iof_1_19_o_oval,
      gpio_0_iof_1_20_o_oval,
      gpio_0_iof_1_21_o_oval,
      gpio_0_iof_1_22_o_oval,
      qspi_0_sck,
      qspi_0_dq_0_i,
      qspi_0_dq_0_o,
      qspi_0_dq_0_oe,
      qspi_0_dq_1_i,
      qspi_0_dq_1_o,
      qspi_0_dq_1_oe,
      qspi_0_dq_2_i,
      qspi_0_dq_2_o,
      qspi_0_dq_2_oe,
      qspi_0_dq_3_i,
      qspi_0_dq_3_o,
      qspi_0_dq_3_oe,
      qspi_0_cs_0,
      aon_pins_erst_n_i_ival,
      aon_pins_lfextclk_i_ival,
      aon_pins_pmu_dwakeup_n_i_ival,
      aon_rsts_corerst,
      pwm_0_gpio_0,
      pwm_0_gpio_1,
      pwm_0_gpio_2,
      pwm_0_gpio_3,
      pwm_1_gpio_0,
      pwm_1_gpio_1,
      pwm_1_gpio_2,
      pwm_1_gpio_3,
      pwm_2_gpio_0,
      pwm_2_gpio_1,
      pwm_2_gpio_2,
      pwm_2_gpio_3,
      i2c_0_scl_in,
      i2c_0_scl_oe,
      i2c_0_sda_in,
      i2c_0_sda_oe
  );

  initial clock = 0;
  always #1 clock = ~clock;

  always @ (posedge clock) begin
    if (top.sys.tile.dcache.data.data_arrays_0_0[0] == 8'hff) begin
      $finish;
    end
  end

  // reg [31:0] data_arrays_0_0 [0:2047];
  // /top/sys/tile/frontend/icache/data_arrays_0_0
  // /top/sys/tile/frontend/icache/data_arrays_0_1 
   
  task init_dtim_input();
    for (int i = 0; i < 4096; i++) begin
        dtim_input[i] <= 0; 
    end
  endtask;
  
  // reg [31:0] data_arrays_0_0 [0:2047];
  // /top/sys/tile/frontend/icache/data_arrays_0_0
  // /top/sys/tile/frontend/icache/data_arrays_0_1
  task init_itim();
    //path_dtim = "C:/Users/Jonin/rocket_chip_rv32im_arty/rocket_chip_rv32im_arty.srcs/sources_1/imports/jonathassilveira-riscv-design-e6861d42ba7e/e300artydevkit/dtim.hex";
    path_dtim = "C:/Users/Jonin/rocket_chip_rv32im_arty/rocket_chip_rv32im_arty.srcs/sources_1/imports/jonathassilveira-riscv-design-e6861d42ba7e/e300artydevkit/hello_dtim.hex";
    $readmemh(path_dtim, dtim_input);

    for (int i = 0; i < 2048; i++) begin
        top.sys.tile.frontend.icache.data_arrays_0_0[i] <= dtim_input[i];
        top.sys.tile.frontend.icache.data_arrays_0_1[i + 2048] <= dtim_input[i + 2048];
    end
  endtask;
  logic in_scratchpad;
  assign in_scratchpad = 1;
  
  task init_dtim();
    //path_dtim = "C:/Users/Jonin/rocket_chip_rv32im_arty/rocket_chip_rv32im_arty.srcs/sources_1/imports/jonathassilveira-riscv-design-e6861d42ba7e/e300artydevkit/dtim.hex";
    path_dtim = "C:/Users/Jonin/rocket_chip_rv32im_arty/rocket_chip_rv32im_arty.srcs/sources_1/imports/jonathassilveira-riscv-design-e6861d42ba7e/e300artydevkit/hello_dtim.hex";
    $readmemh(path_dtim, dtim_input);
    
    //top.sys.tile.dcache.inScratchpad <= 1;
    for (int i = 0; i < 4096; i++) begin
        top.sys.tile.dcache.data.data_arrays_0_0[i] <= dtim_input[i][7:0];
        top.sys.tile.dcache.data.data_arrays_0_1[i] <= dtim_input[i][15:8];
        top.sys.tile.dcache.data.data_arrays_0_2[i] <= dtim_input[i][23:16];
        top.sys.tile.dcache.data.data_arrays_0_3[i] <= dtim_input[i][31:24];
    end
  endtask;
  // /top/sys/tile/frontend/icache/scratchpadOn
  // /top/sys/tile/dcache/inScratchpad
  int interval = 5;
  
  initial begin
    init_dtim_input();
    reset <= 1;
    debug_ndreset <= 0;
    #(interval * 1ns); 
    init_dtim();
    //init_itim();
    #(interval * 1ns); 
    reset <= 0;
    debug_ndreset <= 1;
    //top.sys.tile.frontend.icache.scratchpadOn <= 1;
  end

endmodule