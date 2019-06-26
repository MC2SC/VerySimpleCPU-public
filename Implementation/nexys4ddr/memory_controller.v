module memory_controller(

	// clock and reset
	input clk, 
	input rst,
	
	// processor interface
	input mem_ctrl_we,
	input [13:0] mem_ctrl_addr,
	input [31:0] mem_ctrl_in,
	output reg [31:0] mem_ctrl_out,

	// local memory interface
	output reg local_mem_we,
	output reg [11:0] local_mem_addr,
	output reg [31:0] local_mem_in,
	input [31:0] local_mem_out,

	// led peripheral interface
	output reg led_p_we,
	output reg [3:0] led_p_addr,
	output reg [31:0] led_p_in,
	input [31:0] led_p_out,
	
	// switch peripheral interface
	output reg [3:0] sw_p_addr,
	input [31:0] sw_p_out,
	
	// push button peripheral interface
	output reg [3:0] push_button_p_addr,
	input [31:0] push_button_p_out,
	
	// vga peripheral interface
	output reg vga_p_we,
	output reg [3:0] vga_p_addr,
	output reg [31:0] vga_p_in,
	input [31:0] vga_p_out
 
	);
	
	reg [13:0] mem_ctrl_addr_r;

	//******************************************************
	// memory map
	localparam LOCAL_MEMORY_LOW_ADDR  			= 14'h0000;
	localparam LOCAL_MEMORY_HIGH_ADDR 			= 14'h0FFF;
	localparam LED_P_MEMORY_LOW_ADDR  			= 14'h1000;
	localparam LED_P_MEMORY_HIGH_ADDR 			= 14'h100F;
	localparam SW_P_MEMORY_LOW_ADDR  			= 14'h1010;
	localparam SW_P_MEMORY_HIGH_ADDR 			= 14'h101F;
	localparam PUSH_BUTTON_P_MEMORY_LOW_ADDR  	= 14'h1020;
	localparam PUSH_BUTTON_P_MEMORY_HIGH_ADDR 	= 14'h102F;
	localparam VGA_P_MEMORY_LOW_ADDR			= 14'h1030;
	localparam VGA_P_MEMORY_HIGH_ADDR			= 14'h103F;
	//******************************************************

	//******************************************************
	// memory controller
	always@(*) begin
				
		local_mem_we = 0;
		local_mem_addr = 0;
		local_mem_in = 0;
		
		led_p_we = 0;
		led_p_addr = 0;
		led_p_in = 0;
		
		sw_p_addr = 0;
		
		push_button_p_addr = 0;
		
		vga_p_we = 0;
		vga_p_addr = 0;
		vga_p_in = 0;

		mem_ctrl_out = 0;
		
		if((LOCAL_MEMORY_LOW_ADDR <= mem_ctrl_addr) && (mem_ctrl_addr <= LOCAL_MEMORY_HIGH_ADDR)) begin // local memory
		
			local_mem_addr = mem_ctrl_addr[11:0];
			
			if(mem_ctrl_we == 1) begin
				local_mem_we = 1;
				local_mem_in = mem_ctrl_in;
			end
			
		end
		else if((LED_P_MEMORY_LOW_ADDR <= mem_ctrl_addr) && (mem_ctrl_addr <= LED_P_MEMORY_HIGH_ADDR)) begin // led peripheral
		
			led_p_addr = mem_ctrl_addr[3:0];

			if(mem_ctrl_we == 1'b1) begin
				led_p_we = 1;
				led_p_in = mem_ctrl_in;
			end
		
		end
		else if((SW_P_MEMORY_LOW_ADDR <= mem_ctrl_addr) && (mem_ctrl_addr <= SW_P_MEMORY_HIGH_ADDR)) begin // sw peripheral
		
			sw_p_addr = mem_ctrl_addr[3:0];
	
		end
		else if((PUSH_BUTTON_P_MEMORY_LOW_ADDR <= mem_ctrl_addr) && (mem_ctrl_addr <= PUSH_BUTTON_P_MEMORY_HIGH_ADDR)) begin // push button peripheral
		
			push_button_p_addr = mem_ctrl_addr[3:0];
	
		end
		else if((VGA_P_MEMORY_LOW_ADDR <= mem_ctrl_addr) && (mem_ctrl_addr <= VGA_P_MEMORY_HIGH_ADDR)) begin // vga peripheral
		
			vga_p_addr = mem_ctrl_addr[3:0];

			if(mem_ctrl_we == 1'b1) begin
				vga_p_we = 1;
				vga_p_in = mem_ctrl_in;
			end
		
		end
		
		if((LOCAL_MEMORY_LOW_ADDR <= mem_ctrl_addr_r) && (mem_ctrl_addr_r <= LOCAL_MEMORY_HIGH_ADDR)) begin // local memory
			
			mem_ctrl_out = local_mem_out;
					
		end
		else if((LED_P_MEMORY_LOW_ADDR <= mem_ctrl_addr_r) && (mem_ctrl_addr_r <= LED_P_MEMORY_HIGH_ADDR)) begin // led peripheral
		
			mem_ctrl_out = led_p_out;
		
		end
		else if((SW_P_MEMORY_LOW_ADDR <= mem_ctrl_addr_r) && (mem_ctrl_addr_r <= SW_P_MEMORY_HIGH_ADDR)) begin // sw peripheral
		
			mem_ctrl_out = sw_p_out;
		
		end
		else if((PUSH_BUTTON_P_MEMORY_LOW_ADDR <= mem_ctrl_addr_r) && (mem_ctrl_addr_r <= PUSH_BUTTON_P_MEMORY_HIGH_ADDR)) begin // push button peripheral
		
			mem_ctrl_out = push_button_p_out;
		
		end
		else if((VGA_P_MEMORY_LOW_ADDR <= mem_ctrl_addr_r) && (mem_ctrl_addr_r <= VGA_P_MEMORY_HIGH_ADDR)) begin // vga peripheral
		
			mem_ctrl_out = vga_p_out;
		
		end
				
	end
	
	always@(posedge clk)	begin
		if(rst) begin
			mem_ctrl_addr_r <= 0;
		end
		else begin
			mem_ctrl_addr_r <= mem_ctrl_addr;
		end
				
	end
	//******************************************************
	
endmodule
