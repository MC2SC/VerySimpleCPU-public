module text_screen_top
  (
    input wire clk, rst,
	 input wire [7:0] vga_cmd_word,
	 input wire [6:0] vga_char_code,
	 input wire [6:0] vga_cursor_x_pos,
	 input wire [4:0] vga_cursor_y_pos,
	 output wire vga_ctrl_idle,
    output wire hsync, vsync,
    output wire [7:0] rgb
  );
   	
endmodule
