module vga_p
(

	input clk,
	input rst,
	input wea,
	input [3:0] addra,
	input [31:0] dina,
	output reg [31:0] douta,
	
	output hsync,
	output vsync,
	
	output [11:0] rgb

);

	wire vga_ctrl_idle;
	wire [7:0] data_received;
	reg [31:0] vga_p_r [0:15]; // registers of vga peripheral (control, register address, register data)

	always@(posedge clk) begin
	
		douta <= vga_p_r[addra];

		if(rst) begin
			vga_p_r[0] <= 0;
			vga_p_r[1] <= 0;
			vga_p_r[2] <= 0;
			vga_p_r[3] <= 0;
			vga_p_r[4] <= 0;
			vga_p_r[5] <= 0;
			vga_p_r[6] <= 0;
			vga_p_r[7] <= 0;
			vga_p_r[8] <= 0;
			vga_p_r[9] <= 0;
			vga_p_r[10] <= 0;
			vga_p_r[11] <= 0;
			vga_p_r[12] <= 0;
			vga_p_r[13] <= 0;
			vga_p_r[14] <= 0;
			vga_p_r[15] <= 0;
		end
		else if(wea) begin
			vga_p_r[addra] <= dina;
		end
		else begin
			vga_p_r[0] <= {31'b0,vga_ctrl_idle};
		end
	
	end
	
	text_screen_top text_screen_unit(
		.clk(clk),
		.rst(rst),
		.vga_cmd_word(vga_p_r[0][7:0]),
		.vga_char_code(vga_p_r[1][6:0]),
		.vga_cursor_x_pos(vga_p_r[2][6:0]),
		.vga_cursor_y_pos(vga_p_r[3][4:0]),
		.vga_ctrl_idle(vga_ctrl_idle),
		.hsync(hsync),
		.vsync(vsync),
		.rgb(rgb)
	);
	
endmodule
