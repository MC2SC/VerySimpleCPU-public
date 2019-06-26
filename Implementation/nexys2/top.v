module top(
	
	input clk,
	input rst,
	
	input [7:0] sw,
	output [7:0] led,
	
	input [2:0] push_button,
	
	output hsync,
	output vsync,
	
	output [7:0] rgb

	);
	
	// reset interface
	wire rst_asserted;
	
	// interrupt interface
	wire interrupt;
	
	// processor interface
	wire mem_ctrl_we;
	wire [13:0] mem_ctrl_addr;
	wire [31:0] mem_ctrl_in;
	wire [31:0] mem_ctrl_out;

	// local memory interface
	wire local_mem_we;
	wire [11:0] local_mem_addr;
	wire [31:0] local_mem_in;
	wire [31:0] local_mem_out;

	// led peripheral interface
	wire led_p_we;
	wire [3:0] led_p_addr;
	wire [31:0] led_p_in;
	wire [31:0] led_p_out;
	
	// switch peripheral interface
	wire [3:0] sw_p_addr;
	wire [31:0] sw_p_out;
	
	// push button peripheral interface
	wire [3:0] push_button_p_addr;
	wire [31:0] push_button_p_out;
	
	// vga peripheral interface
	wire vga_p_we;
	wire [3:0] vga_p_addr;
	wire [31:0] vga_p_in;
	wire [31:0] vga_p_out;
	
	reset_circuit inst_reset_circuit(
	
		.clk(clk),
		.rst(rst),
		.rst_asserted(rst_asserted)
		
	);

	VerySimpleCPU inst_VerySimpleCPU(
		
		.clk(clk),
		.rst(rst_asserted),
		
		.interrupt(interrupt),
		
		.data_fromRAM(mem_ctrl_out),
		.wrEn(mem_ctrl_we),
		.addr_toRAM(mem_ctrl_addr),
		.data_toRAM(mem_ctrl_in)
		
	);

	memory_controller inst_memory_controller(

		.clk(clk),
		.rst(rst_asserted),
		.mem_ctrl_we(mem_ctrl_we),
		.mem_ctrl_addr(mem_ctrl_addr),
		.mem_ctrl_in(mem_ctrl_in),
		.mem_ctrl_out(mem_ctrl_out),

		.local_mem_we(local_mem_we),
		.local_mem_addr(local_mem_addr),
		.local_mem_in(local_mem_in),
		.local_mem_out(local_mem_out),

		.led_p_we(led_p_we),
		.led_p_addr(led_p_addr),
		.led_p_in(led_p_in),
		.led_p_out(led_p_out),
		
		.sw_p_addr(sw_p_addr),
		.sw_p_out(sw_p_out),
		
		.push_button_p_addr(push_button_p_addr),
		.push_button_p_out(push_button_p_out),
		
		.vga_p_we(vga_p_we),
		.vga_p_addr(vga_p_addr),
		.vga_p_in(vga_p_in),
		.vga_p_out(vga_p_out)
	
	);

	local_memory inst_local_memory(

		.clk(clk),
		.wea(local_mem_we),
		.addra(local_mem_addr),
		.dina(local_mem_in),
		.douta(local_mem_out)

	);

	led_p inst_led_p(

		.clk(clk),
		.rst(rst_asserted),
		.wea(led_p_we),
		.addra(led_p_addr),
		.dina(led_p_in),
		.douta(led_p_out),
		.led(led)

	);
	
	sw_p inst_sw_p(

		.clk(clk),
		.rst(rst_asserted),
		.addra(sw_p_addr),
		.douta(sw_p_out),
		.sw(sw)

	);
	
	push_button_p inst_push_button_p(

		.clk(clk),
		.rst(rst_asserted),
		.addra(push_button_p_addr),
		.douta(push_button_p_out),
		.push_button(push_button),
		.int_push_button(interrupt)

	);
	
	vga_p inst_vga_p(
	
		.clk(clk),
		.rst(rst_asserted),
		.wea(vga_p_we),
		.addra(vga_p_addr),
		.dina(vga_p_in),
		.douta(vga_p_out),
		.hsync(hsync),
		.vsync(vsync),
		.rgb(rgb)
	
	);
	
endmodule
