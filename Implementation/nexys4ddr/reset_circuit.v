module reset_circuit(
	
	input clk,
	input rst,
	output rst_asserted
	
	);

	reg [4:0] rst_q;

	always@(posedge clk) begin
		rst_q[0] 		<= rst;
		rst_q[1] 		<= rst_q[0];
		rst_q[2] 		<= rst_q[1];
		rst_q[3] 		<= rst_q[2];
		rst_q[4] 		<= rst_q[3];
	end

	assign rst_asserted = (rst_q[4] && (!rst_q[3]) && (!rst_q[2]) && (!rst_q[1]) && (!rst_q[0]));

endmodule
