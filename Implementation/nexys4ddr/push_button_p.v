module push_button_p(

	input clk,
	input rst,
	input [3:0] addra,
	output reg [31:0] douta,
	input [2:0] push_button,
	output int_push_button
	
	);

	wire [2:0] db_push_button;
	reg [31:0] push_button_p_r [0:15];

	always@(posedge clk) begin
	
		douta <= push_button_p_r[addra];

		if(rst) begin
			push_button_p_r[0] <= 0;
			push_button_p_r[1] <= 0;
			push_button_p_r[2] <= 0;
			push_button_p_r[3] <= 0;
			push_button_p_r[4] <= 0;
			push_button_p_r[5] <= 0;
			push_button_p_r[6] <= 0;
			push_button_p_r[7] <= 0;
			push_button_p_r[8] <= 0;
			push_button_p_r[9] <= 0;
			push_button_p_r[10] <= 0;
			push_button_p_r[11] <= 0;
			push_button_p_r[12] <= 0;
			push_button_p_r[13] <= 0;
			push_button_p_r[14] <= 0;
			push_button_p_r[15] <= 0;
		end
		else begin
			push_button_p_r[0] <= db_push_button;
		end
	end
	  
	debounce inst_debounce_1(.clk(clk), .reset(rst), .db_in(push_button[0]), .db_out(db_push_button[0]));  
	debounce inst_debounce_2(.clk(clk), .reset(rst), .db_in(push_button[1]), .db_out(db_push_button[1]));
	debounce inst_debounce_3(.clk(clk), .reset(rst), .db_in(push_button[2]), .db_out(db_push_button[2]));
	
	assign int_push_button = |(db_push_button);

endmodule
