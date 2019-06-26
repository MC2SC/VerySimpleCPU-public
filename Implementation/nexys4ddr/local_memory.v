module local_memory(

	input clk,
	input wea,
	input [11:0] addra,
	input [31:0] dina,
	output [31:0] douta

	);
	
	instr_data_memory_v1 inst_instr_data_memory(

	  .clka(clk), // input clka
	  .wea(wea), // input [0 : 0] wea
	  .addra(addra), // input [11 : 0] addra
	  .dina(dina), // input [31 : 0] dina
	  .douta(douta) // output [31 : 0] douta
	
	);

endmodule
