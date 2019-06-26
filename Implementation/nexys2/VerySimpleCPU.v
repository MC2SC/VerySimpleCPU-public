module VerySimpleCPU(clk, rst, data_fromRAM, wrEn, addr_toRAM, data_toRAM, interrupt);

parameter SIZE = 14;

input clk, rst;
input interrupt;
input [31:0] data_fromRAM;
output reg wrEn;
output reg [SIZE-1:0] addr_toRAM;
output reg [31:0] data_toRAM;

endmodule
