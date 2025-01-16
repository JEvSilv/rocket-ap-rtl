// This file created by /root/freedom/rocket-chip/scripts/vlsi_rom_gen

module BootROM(
  input clock,
  input oe,
  input me,
  input [10:0] address,
  output [31:0] q
);
  reg [31:0] out;
  reg [31:0] rom [0:2047];


  // 1024 is the maximum length of $readmemh filename supported by Cadence Incisive
  reg [1024 * 8 - 1:0] path;

  integer i;
  initial begin
`ifdef RANDOMIZE
  `ifdef RANDOMIZE_MEM_INIT
    for (i = 0; i < 2048; i = i + 1) begin
      rom[i] = {1{$random}};
    end
  `endif
`endif
    if (!$value$plusargs("maskromhex=%s", path)) begin
      //path = "C:/Users/Jonin/rocket_chip_rv32im_arty/rocket_chip_rv32im_arty.srcs/sources_1/imports/jonathassilveira-riscv-design-e6861d42ba7e/e300artydevkit/xip.hex";
      //path = "C:/Users/Jonin/rocket_chip_rv32im_arty/rocket_chip_rv32im_arty.srcs/sources_1/imports/jonathassilveira-riscv-design-e6861d42ba7e/e300artydevkit/xip_load_dtim.hex";
      path = "C:/Users/Jonin/rocket-ap-arty/rocket-ap-arty.srcs/sources_1/imports/sources_1/imports/jonathassilveira-riscv-design-e6861d42ba7e/e300artydevkit/xip_modified.hex";
    end
    $readmemh(path, rom);
  end


  always @(posedge clock) begin
    if (me) begin
      out <= rom[address];
    end
  end

  assign q = oe ? out : 32'bZ;

endmodule

