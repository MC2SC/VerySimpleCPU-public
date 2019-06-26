module sw_p(

	input clk,
	input rst,
	input [3:0] addra,
	output reg [31:0] douta,
	input [7:0] sw

	);

	reg [31:0] sw_p_r [0:15];

	always@(posedge clk) begin
	
		douta <= sw_p_r[addra];

		if(rst) begin
			sw_p_r[0] <= 0;
			sw_p_r[1] <= 0;
			sw_p_r[2] <= 0;
			sw_p_r[3] <= 0;
			sw_p_r[4] <= 0;
			sw_p_r[5] <= 0;
			sw_p_r[6] <= 0;
			sw_p_r[7] <= 0;
			sw_p_r[8] <= 0;
			sw_p_r[9] <= 0;
			sw_p_r[10] <= 0;
			sw_p_r[11] <= 0;
			sw_p_r[12] <= 0;
			sw_p_r[13] <= 0;
			sw_p_r[14] <= 0;
			sw_p_r[15] <= 0;
		end
		else begin
			sw_p_r[0] <= sw;
		end

	end

endmodule
