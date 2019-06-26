`timescale 1ns / 1ns

module tb;
parameter SIZE = 14, DEPTH = 1024;

reg clk;
initial begin
  clk = 1;
  forever
	  #5 clk = ~clk;
end

reg rst;
initial begin
  rst = 1;
  repeat (10) @(posedge clk);
  rst <= #1 0;
  repeat (600) @(posedge clk);
  // uncomment the following line to display the content at address 50 in console
  // $display("Content of address 50 is %d.", inst_blram.memory[50]);
  $finish;
end

wire wrEn;
wire [SIZE-1:0] addr_toRAM;
wire [31:0] data_toRAM, data_fromRAM;

VerySimpleCPU inst_VerySimpleCPU(
  .clk(clk),
  .rst(rst),
  .wrEn(wrEn),
  .data_fromRAM(data_fromRAM),
  .addr_toRAM(addr_toRAM),
  .data_toRAM(data_toRAM)
);

blram #(SIZE, DEPTH) inst_blram(
  .clk(clk),
  .rst(rst),
  .i_we(wrEn),
  .i_addr(addr_toRAM),
  .i_ram_data_in(data_toRAM),
  .o_ram_data_out(data_fromRAM)
);

endmodule

module blram(clk, rst, i_we, i_addr, i_ram_data_in, o_ram_data_out);

parameter SIZE = 10, DEPTH = 1024;

input clk;
input rst;
input i_we;
input [SIZE-1:0] i_addr;
input [31:0] i_ram_data_in;
output reg [31:0] o_ram_data_out;

reg [31:0] memory[0:DEPTH-1];

always @(posedge clk) begin
  o_ram_data_out <= #1 memory[i_addr[SIZE-1:0]];
  if (i_we)
		memory[i_addr[SIZE-1:0]] <= #1 i_ram_data_in;
end 

initial begin
//////////////////////////
// write BRAM content here

//////////////////////////
end

endmodule
