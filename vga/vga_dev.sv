
module vga_dev(clk, x, y, hsync, vsync);

input clk;
output[7:0] x;
output[7:0] y;
output hsync;
output vsync;
wire pixel_clk;

reg[15:0] h_fp = 16'd16;
reg[15:0] h_pulse = 96;
reg[15:0] h_bp = 48;

reg[15:0] v_fp = 10;  //in lines
reg[15:0] v_pulse = 2;//in lines
reg[15:0] v_bp = 33;  //in lines

reg[15:0] h_res = 640;
reg[15:0] v_res = 480;

reg[15:0] h_counter = 0;
reg[15:0] v_counter = 0;

pxlclk pl(clk, pixel_clk);

always @(posedge pixel_clk)

begin
   //counters
	if (h_counter > (h_res+h_fp+h_pulse+h_bp-1))
	begin
		v_counter += 1;
		h_counter = 0;
	end
	else
	begin
		h_counter += 1;
	end
	
	if (v_counter > (v_res+v_fp+v_pulse+v_bp-1))
	begin
		v_counter = 0;
	end


	
	//horizontal pulse
	if ((h_counter > (h_res+h_fp-1)) && (h_counter < (h_res+h_fp+h_pulse-1)))
	begin
		hsync = 1;
	end
	else	
	begin
		hsync = 0;
	end
	
	//vertical pulse
	if ((v_counter > (v_res+v_fp-1)) && (v_counter < v_res+v_fp+v_pulse-1))
	begin
		vsync = 1;
	end
	else
	begin
		vsync = 0;
	end
	
	
end
	


endmodule