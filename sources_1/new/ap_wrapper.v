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
    input         io_req_bits_write,
    input  [31:0] io_req_bits_wdata,
    input  [3:0]  io_req_bits_eccMask,
    output [31:0] io_resp_0 
  );

  parameter CAM_A_START_REGION = 0;
  parameter CAM_B_START_REGION = CELL_QUANT * 2;
  parameter CAM_C_START_REGION = CELL_QUANT * 4;
  parameter SETTINGS_REGS_START_REGION = CELL_QUANT * 6;

  reg ap_rst;
  reg ap_if_state; // It controls the configuration interface
                  // It is able to block the memory feature
  reg ap_op_direction; // 0 -> vertical | 1 -> horizontal
  reg [2:0] ap_cmd;
  reg [1:0] ap_sel_col;
  reg ap_sel_internal_col;
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
    ap_cmd <= 0;
    ap_sel_col <= 0;
    ap_sel_internal_col <= 0;
    ap_addr_in <= 0;
    ap_data_in <= 0;
    ap_trigger_ap <= 0;
  end
  
  // Defining the outputs
  assign io_resp_0 = (io_req_bits_addr == (SETTINGS_REGS_START_REGION + 8) || ap_trigger_ap == 1) ? ap_ap_state_irq_w : ap_data_out_w;
  
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

    if(ap_if_state == 0) begin
    // if(io_req_bits_addr < SETTINGS_REGS_START_REGION) begin
      // Memory enable, data and addr
      if(io_req_valid) begin
        ap_addr_in <= io_req_bits_addr;
        ap_data_in <= io_req_bits_wdata;

        // Memory settings
        if(io_req_bits_addr <  CAM_B_START_REGION) begin
          ap_sel_col <= 0;
          if(io_req_bits_addr < CELL_QUANT) begin
            ap_sel_internal_col <= 0;
          end else begin
            ap_sel_internal_col <= 1;
          end
        end else if(io_req_bits_addr <  CAM_C_START_REGION) begin
          ap_sel_col <= 1;
          if(io_req_bits_addr < (CAM_B_START_REGION + CELL_QUANT)) begin
            ap_sel_internal_col <= 0;
          end else begin
            ap_sel_internal_col <= 1;
          end
        end else if(io_req_bits_addr < SETTINGS_REGS_START_REGION) begin 
          ap_sel_col <= 2;
          if(io_req_bits_addr < (CAM_C_START_REGION + CELL_QUANT)) begin
            ap_sel_internal_col <= 0;
          end else begin
            ap_sel_internal_col <= 1;
          end
        end


      end else if(read_async) begin
        ap_addr_in <= io_req_bits_addr;
      end

      if(io_req_bits_write) begin
        ap_data_in <= io_req_bits_wdata;
      end

      ap_write_enable <= io_req_bits_write;

      /* // Memory settings */
      /* if(io_req_bits_addr <  CAM_B_START_REGION) begin */
      /*   ap_sel_col <= 0; */
      /*   if(io_req_bits_addr < CELL_QUANT) begin */
      /*     ap_sel_internal_col <= 0; */
      /*   end else begin */
      /*     ap_sel_internal_col <= 1; */
      /*   end */
      /* end else if(io_req_bits_addr <  CAM_C_START_REGION) begin */
      /*   ap_sel_col <= 1; */
      /*   if(io_req_bits_addr < (CAM_B_START_REGION + CELL_QUANT)) begin */
      /*     ap_sel_internal_col <= 0; */
      /*   end else begin */
      /*     ap_sel_internal_col <= 1; */
      /*   end */
      /* end else if(io_req_bits_addr < SETTINGS_REGS_START_REGION) begin */ 
      /*   ap_sel_col <= 2; */
      /*   if(io_req_bits_addr < (CAM_C_START_REGION + CELL_QUANT)) begin */
      /*     ap_sel_internal_col <= 0; */
      /*   end else begin */
      /*     ap_sel_internal_col <= 1; */
      /*   end */
      /* end */

    end 
    
    /* else begin */
	      // AP configuration
        if(settings_write_en) begin 
          if(io_req_bits_addr == SETTINGS_REGS_START_REGION) begin
            ap_cmd <= io_req_bits_wdata[7:0];
            ap_op_direction <= io_req_bits_wdata[15:8];
            ap_sel_col <= io_req_bits_wdata[23:16];
            ap_sel_internal_col <= io_req_bits_wdata[31:24];
            // ap_mode_reg_out <= io_req_bits_wdata;
          end else begin 
              if(io_req_bits_addr == SETTINGS_REGS_START_REGION + 4) begin
                  ap_rst <= io_req_bits_wdata[7:0];
                  ap_trigger_ap <= io_req_bits_wdata[15:8];
                  ap_if_state <= io_req_bits_wdata[23:16]; 
                  // ap_control_reg_out <= io_req_bits_wdata;
                  /* reserved <= io_req_bits_write[31:24]; */
              end
          end
        /* end */ 
    end
	end

  AP_s #(.WORD_SIZE(WORD_SIZE), .CELL_QUANT(CELL_QUANT)) AP (
       .addr_in(ap_addr_in), // 7f mask for 128 cells
       .data_in(ap_data_in),     
       .rst(ap_rst),
       .op_direction(ap_op_direction),
       .ap_mode(ap_trigger_ap), // trigger ap computation
       .cmd(ap_cmd),
       .sel_col(ap_sel_col),
       .sel_internal_col(ap_sel_internal_col),
       .clock(clock),                       
       .write_en(ap_write_enable),
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
