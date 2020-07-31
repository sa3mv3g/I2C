 
 //`include "main.v"
 
 module testbench;
	
	reg scl;
	reg sda;
	reg tb_flag;
	
	wire [7:0] data;
	wire ack;
	wire tb_sda;
	
	I2C _i2c(scl, tb_sda, ack, data);
		
	initial begin
		$dumpfile("main.vcd");
		$dumpvars(0,testbench);
	end
	/*
	always #5 scl = ~scl;
	
	initial begin
		tb_flag = 0;
		scl = 1;
		sda = 1;
		#1 sda=0; //start bit
		
		#5 sda=1;
		#10 sda=1;
		#10 sda=0;
		#10 sda=0;
		
		#10 sda=0;
		#10 sda=1;
		#10 sda=1;
		#10 sda=0;
		#9 tb_flag = 1;
		#10 sda = 0;
		#100 $finish;
	end
	
	assign tb_sda = tb_flag ? 'bz : sda;
	*/
	assign tb_sda = sda;
	
initial begin
#1 scl = 1; sda = 1;
#1 scl = 1; sda = 1;
#1 scl = 1; sda = 1;
#1 scl = 1; sda = 0;
#1 scl = 1; sda = 0;
#1 scl = 0; sda = 0;
#1 scl = 0; sda = 0;
#1 scl = 0; sda = 1;
#1 scl = 0; sda = 1;
#1 scl = 0; sda = 1;
#1 scl = 1; sda = 1;
#1 scl = 1; sda = 1;
#1 scl = 1; sda = 1;
#1 scl = 1; sda = 1;
#1 scl = 1; sda = 1;
#1 scl = 0; sda = 1;
#1 scl = 0; sda = 1;
#1 scl = 0; sda = 1;
#1 scl = 0; sda = 1;
#1 scl = 0; sda = 1;
#1 scl = 1; sda = 1;
#1 scl = 1; sda = 1;
#1 scl = 1; sda = 1;
#1 scl = 1; sda = 1;
#1 scl = 1; sda = 1;
#1 scl = 0; sda = 1;
#1 scl = 0; sda = 1;
#1 scl = 0; sda = 1;
#1 scl = 0; sda = 0;
#1 scl = 0; sda = 0;
#1 scl = 1; sda = 0;
#1 scl = 1; sda = 0;
#1 scl = 1; sda = 0;
#1 scl = 1; sda = 0;
#1 scl = 1; sda = 0;
#1 scl = 0; sda = 0;
#1 scl = 0; sda = 0;
#1 scl = 0; sda = 0;
#1 scl = 0; sda = 0;
#1 scl = 0; sda = 0;
#1 scl = 1; sda = 0;
#1 scl = 1; sda = 0;
#1 scl = 1; sda = 0;
#1 scl = 1; sda = 0;
#1 scl = 1; sda = 0;
#1 scl = 0; sda = 0;
#1 scl = 0; sda = 0;
#1 scl = 0; sda = 0;
#1 scl = 0; sda = 0;
#1 scl = 0; sda = 0;
#1 scl = 1; sda = 0;
#1 scl = 1; sda = 0;
#1 scl = 1; sda = 0;
#1 scl = 1; sda = 0;
#1 scl = 1; sda = 0;
#1 scl = 0; sda = 0;
#1 scl = 0; sda = 0;
#1 scl = 0; sda = 0;
#1 scl = 0; sda = 1;
#1 scl = 0; sda = 1;
#1 scl = 1; sda = 1;
#1 scl = 1; sda = 1;
#1 scl = 1; sda = 1;
#1 scl = 1; sda = 1;
#1 scl = 1; sda = 1;
#1 scl = 0; sda = 1;
#1 scl = 0; sda = 1;
#1 scl = 0; sda = 1;
#1 scl = 0; sda = 1;
#1 scl = 0; sda = 1;
#1 scl = 1; sda = 1;
#1 scl = 1; sda = 1;
#1 scl = 1; sda = 1;
#1 scl = 1; sda = 1;
#1 scl = 1; sda = 1;
#1 scl = 0; sda = 1;
#1 scl = 0; sda = 1;
#1 scl = 0; sda = 1;
#1 scl = 0; sda = 0;
#1 scl = 0; sda = 0;
#1 scl = 1; sda = 0;
#1 scl = 1; sda = 0;
#1 scl = 1; sda = 0;
#1 scl = 1; sda = 0;
#1 scl = 1; sda = 0;
#1 scl = 0; sda = 'bz;
#1 scl = 0; sda = 'bz;
#1 scl = 0; sda = 'bz;
#1 scl = 0; sda = 'bz;
#1 scl = 0; sda = 'bz;
#1 scl = 1; sda = 'bz;
#1 scl = 1; sda = 'bz;
#1 scl = 1; sda = 'bz;
#1 scl = 1; sda = 'bz;
#1 scl = 1; sda = 'bz;
#1 scl = 0; sda = 0;
#1 scl = 0; sda = 0;
#1 scl = 0; sda = 0;
#1 scl = 0; sda = 0;
#1 scl = 0; sda = 0;
#1 scl = 1; sda = 0;
#1 scl = 1; sda = 0;
#1 scl = 1; sda = 0;
#1 scl = 1; sda = 0;
#1 scl = 1; sda = 0;
#1 scl = 0; sda = 0;
#1 scl = 0; sda = 0;
#1 scl = 0; sda = 1;
#1 scl = 0; sda = 1;
#1 scl = 0; sda = 1;
#1 scl = 1; sda = 1;
#1 scl = 1; sda = 1;
#1 scl = 1; sda = 1;
#1 scl = 1; sda = 1;
#1 scl = 1; sda = 1;
#1 scl = 0; sda = 1;
#1 scl = 0; sda = 1;
#1 scl = 0; sda = 0;
#1 scl = 0; sda = 0;
#1 scl = 0; sda = 0;
#1 scl = 1; sda = 0;
#1 scl = 1; sda = 0;
#1 scl = 1; sda = 0;
#1 scl = 1; sda = 0;
#1 scl = 1; sda = 0;
#1 scl = 0; sda = 0;
#1 scl = 0; sda = 0;
#1 scl = 0; sda = 1;
#1 scl = 0; sda = 1;
#1 scl = 0; sda = 1;
#1 scl = 1; sda = 1;
#1 scl = 1; sda = 1;
#1 scl = 1; sda = 1;
#1 scl = 1; sda = 1;
#1 scl = 1; sda = 1;
#1 scl = 0; sda = 1;
#1 scl = 0; sda = 1;
#1 scl = 0; sda = 0;
#1 scl = 0; sda = 0;
#1 scl = 0; sda = 0;
#1 scl = 1; sda = 0;
#1 scl = 1; sda = 0;
#1 scl = 1; sda = 0;
#1 scl = 1; sda = 0;
#1 scl = 1; sda = 0;
#1 scl = 0; sda = 0;
#1 scl = 0; sda = 0;
#1 scl = 0; sda = 0;
#1 scl = 0; sda = 0;
#1 scl = 0; sda = 0;
#1 scl = 1; sda = 0;
#1 scl = 1; sda = 0;
#1 scl = 1; sda = 0;
#1 scl = 1; sda = 0;
#1 scl = 1; sda = 0;
#1 scl = 0; sda = 0;
#1 scl = 0; sda = 0;
#1 scl = 0; sda = 1;
#1 scl = 0; sda = 1;
#1 scl = 0; sda = 1;
#1 scl = 1; sda = 1;
#1 scl = 1; sda = 1;
#1 scl = 1; sda = 1;
#1 scl = 1; sda = 1;
#1 scl = 1; sda = 1;
#1 scl = 0; sda = 1;
#1 scl = 0; sda = 1;
#1 scl = 0; sda = 1;
#1 scl = 0; sda = 1;
#1 scl = 0; sda = 1;
#1 scl = 1; sda = 1;
#1 scl = 1; sda = 1;
#1 scl = 1; sda = 1;
#1 scl = 1; sda = 1;
#1 scl = 1; sda = 1;
#1 scl = 0; sda = 'bz;
#1 scl = 0; sda = 'bz;
#1 scl = 0; sda = 'bz;
#1 scl = 0; sda = 'bz;
#1 scl = 0; sda = 'bz;
#1 scl = 1; sda = 'bz;
#1 scl = 1; sda = 'bz;
#1 scl = 1; sda = 'bz;
#1 scl = 1; sda = 'bz;
#1 scl = 1; sda = 'bz;
#1 scl = 0; sda = 1;
#1 scl = 0; sda = 1;
#1 scl = 0; sda = 1;
#1 scl = 0; sda = 1;
#1 scl = 0; sda = 1;
#1 scl = 1; sda = 1;
#1 scl = 1; sda = 1;
#1 scl = 1; sda = 1;
#1 scl = 1; sda = 1;
#1 scl = 1; sda = 1;
#1 scl = 0; sda = 1;
#1 scl = 0; sda = 1;
#1 scl = 0; sda = 1;
#1 scl = 0; sda = 1;
#1 scl = 0; sda = 1;
end
 endmodule 