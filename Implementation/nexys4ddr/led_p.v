module led_p(

	input clk,
	input rst,
	input wea,
	input [3:0] addra,
	input [31:0] dina,
	output reg [31:0] douta,
	output [7:0] led

	);

	reg [31:0] led_p_r [0:15];

	always@(posedge clk) begin
	
		douta <= led_p_r[addra];

		if(rst) begin
			led_p_r[0] <= 0;
			led_p_r[1] <= 0;
			led_p_r[2] <= 0;
			led_p_r[3] <= 0;
			led_p_r[4] <= 0;
			led_p_r[5] <= 0;
			led_p_r[6] <= 0;
			led_p_r[7] <= 0;
			led_p_r[8] <= 0;
			led_p_r[9] <= 0;
			led_p_r[10] <= 0;
			led_p_r[11] <= 0;
			led_p_r[12] <= 0;
			led_p_r[13] <= 0;
			led_p_r[14] <= 0;
			led_p_r[15] <= 0;
		end
		else if(wea) begin
			led_p_r[addra] <= dina;
		end
	
	end
	
	assign led = led_p_r[0];

endmodule
