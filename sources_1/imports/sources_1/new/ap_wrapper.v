`timescale 1ns / 1ps

/* Description				addr				array index	byte 3	byte 2	byte 1	byte 0 				*/
/* Mode configuration	0x80004000	0			sel_internal_col	sel_col	op_direction	cmd */
/* Control settings		0x80004004	1			reserved	reserved	ap_mode	ap_rst 					*/
/* AP irq							0x80004008	2			reserved	reserved	reserved	state_irq* 		*/

module APWrapper #(
   parameter WORD_SIZE = 8,
   parameter CELL_QUANT = 128
) (
    input         clock,
    input         reset,
    input         read_async,
    input         settings_write_en,
    input         io_req_valid,
    input  [clogb2(CELL_QUANT*3*2)-1:0] io_req_bits_addr, // 3 CAMs and Two Internal Columns 
    input  [clogb2(CELL_QUANT*3*2)-1:0] settings_io_req_bits_addr, // 3 CAMs and Two Internal Columns 
    input         io_req_bits_write,
    input  [31:0] io_req_bits_wdata,
    input  [3:0]  io_req_bits_eccMask,
    output [31:0] io_resp_0 
  );

  parameter CAM_A_START_REGION = 0;
  parameter CAM_B_START_REGION = CELL_QUANT * 2;
  parameter CAM_C_START_REGION = CELL_QUANT * 4;
 
  parameter CAM_A_I_START_REGION = CELL_QUANT;
  parameter CAM_B_I_START_REGION = CELL_QUANT * 3;
  parameter CAM_C_I_START_REGION = CELL_QUANT * 5;

  parameter SETTINGS_REGS_START_REGION = CELL_QUANT * 6;



  reg [2:0] ap_rst;
  reg ap_if_state; // It controls the configuration interface
                  // It is able to block the memory feature
  reg ap_op_direction; // 0 -> vertical | 1 -> horizontal
  reg op_target;    // 0 -> C | 1 -> A
  reg [3:0] ap_cmd;
  reg [1:0] ap_sel_col;
  reg [2:0] ap_sel_internal_col;
  wire [WORD_SIZE-1:0] ap_data_out_w;
  wire ap_ap_state_irq_w;
  
  reg [clogb2(CELL_QUANT)-1:0] ap_addr_in;
  reg [WORD_SIZE-1:0] ap_data_in;
  reg ap_write_enable;
  reg ap_trigger_ap;

  initial begin
    ap_rst <= 0;
    ap_if_state <= 0;
    ap_op_direction <= 0; // 0 -> vertical | 1 -> horizontal
    op_target <= 0;
    ap_cmd <= 0;
    ap_sel_col <= 0;
    ap_sel_internal_col <= 0;
    ap_addr_in <= 0;
    ap_data_in <= 0;
    ap_trigger_ap <= 0;
  end
  
  // Defining the outputs
  assign io_resp_0 = (io_req_bits_addr == (SETTINGS_REGS_START_REGION + 8) || ap_trigger_ap == 1) ? ap_ap_state_irq_w : ap_data_out_w;
  
  wire cam_a_region;
  wire cam_b_region;
  wire cam_c_region;
  wire [1:0] cam_sel;
  wire cam_internal_col;

  wire cam_a_i_region;
  wire cam_b_i_region;
  wire cam_c_i_region;

  assign cam_a_region = (io_req_bits_addr < CAM_B_START_REGION) ? 1 : 0;
  assign cam_b_region = (io_req_bits_addr >= CAM_B_START_REGION && io_req_bits_addr < CAM_C_START_REGION) ? 1 : 0;
  assign cam_c_region = (io_req_bits_addr >= CAM_C_START_REGION && io_req_bits_addr < SETTINGS_REGS_START_REGION) ? 1 : 0;
  assign cam_sel = (cam_a_region == 1) ? 0 : (cam_b_region == 1) ? 1 : (cam_c_region == 1) ? 2 : 0;

  assign cam_a_i_region = (cam_a_region == 1 && io_req_bits_addr >= CAM_A_I_START_REGION) ;
  assign cam_b_i_region = (cam_b_region == 1 && io_req_bits_addr >= CAM_B_I_START_REGION);
  assign cam_c_i_region = (cam_c_region == 1 && io_req_bits_addr >= CAM_C_I_START_REGION);

  assign cam_internal_col = ((cam_a_i_region == 1) ? 3'b001 : (cam_b_i_region == 1) ? 3'b010 : (cam_c_i_region == 1)) ? 3'b100 : 0;
  

  wire [1:0] final_cam_sel;
  wire [2:0] final_cam_internal_col;

  assign final_cam_sel = (ap_if_state == 1) ? ap_sel_col : cam_sel;
  assign final_cam_internal_col = (ap_if_state == 1) ? ap_sel_internal_col : cam_internal_col;
  
  // Add reset?
  always @ (posedge clock) begin
    if(reset) begin
      ap_rst <= 0;
      ap_if_state <= 0;
      ap_op_direction <= 0; // 0 -> vertical | 1 -> horizontal
      ap_cmd <= 0;
      ap_sel_col <= 0;
      ap_sel_internal_col <= 0;
      ap_addr_in <= 0;
      ap_data_in <= 0;
      ap_trigger_ap <= 0;
    end

    /* else begin */
	      // AP configuration
        if(settings_write_en) begin 
          if(settings_io_req_bits_addr == SETTINGS_REGS_START_REGION) begin
            ap_cmd <= io_req_bits_wdata[7:0];
            ap_op_direction <= io_req_bits_wdata[15:8];
            ap_sel_col <= io_req_bits_wdata[23:16];
            ap_sel_internal_col <= io_req_bits_wdata[31:24];
            // ap_mode_reg_out <= io_req_bits_wdata;
          end else begin 
              if(settings_io_req_bits_addr == SETTINGS_REGS_START_REGION + 4) begin
                  ap_rst <= io_req_bits_wdata[7:0];
                  ap_trigger_ap <= io_req_bits_wdata[15:8];
                  op_target <= io_req_bits_wdata[23:16];
                  ap_if_state <= io_req_bits_wdata[31:24]; 
              end
          end
        /* end */ 
    end
	end

  AP_s #(.WORD_SIZE(WORD_SIZE), .CELL_QUANT(CELL_QUANT)) AP (
       //.addr_in(ap_addr_in), // 7f mask for 128 cells
       .addr_in(io_req_bits_addr), // 7f mask for 128 cells

       //.data_in(ap_data_in),     
       .data_in(io_req_bits_wdata),           

       .rst(ap_rst),
       .op_direction(ap_op_direction),
       .op_target(op_target),
       .ap_mode(ap_trigger_ap), // trigger ap computation
       .cmd(ap_cmd),
       .sel_col(final_cam_sel),
       //.sel_internal_col(ap_sel_internal_col),
       .sel_internal_col(final_cam_internal_col),
       .clock(clock),                       
       //.write_en(ap_write_enable),
       .write_en(io_req_bits_write),
       .read_en(~io_req_bits_write),                           
       .data_out(ap_data_out_w),
       .ap_state_irq(ap_ap_state_irq_w)
  );

  function integer clogb2;
   input integer depth;
       for (clogb2=0; depth>0; clogb2=clogb2+1)
         depth = depth >> 1;
  endfunction
endmodule
