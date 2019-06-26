module debounce (
	input clk,
	input reset,
	input db_in, 
	output db_out	
	);

	reg [4:0] db_q;

	always@ (posedge clk) begin
		if(reset) begin
			db_q <= 5'b0;
		end
		else begin
			db_q[0] 		<= db_in;
			db_q[1] 		<= db_q[0];
			db_q[2] 		<= db_q[1];
			db_q[3] 		<= db_q[2];
			db_q[4] 		<= db_q[3];
		end
	end

	assign db_out = (db_q[4] && (!db_q[3]) && (!db_q[2]) && (!db_q[1]) && (!db_q[0]));

endmodule
