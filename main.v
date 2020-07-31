 module I2C(input scl, inout _sda, output reg ack, output reg[7:0] dout);
 
	reg [7:0]reg0, bitscounter, bytecounter;
	reg startbit, flag, flag1;
	wire sda;
	
	initial flag = 0;
	
	assign _sda = flag == 1 ? ack : 'bz;
	assign sda = _sda;
	
	// detect START condition
	always @(negedge sda) if(scl == 1'b1) startbit = 1'b1;
	// detect STOP condition
	always @(posedge sda) if(scl == 1'b1) startbit = 1'b0;
	// reset all reg on START detect
	always @(posedge startbit) begin
		bitscounter <= 0;
		bytecounter <= 0;
		flag <= 0;
		flag1 <= 0;
		reg0 <= 0;
		ack <= 0;
	end
	
	always @(scl) begin
	if(startbit == 1) begin	
		// following if statement will fire when 
		// scl positive edge will occure
		if(scl == 1) begin
		// increase no of bits
		bitscounter <= bitscounter + 1;
		// if flag is zero or if not in ACK/NACK bit 
		// then shift in data
		if(flag == 0) reg0 <= (reg0<<1)|sda;
		
		end
		// following if statement will fire when 
		// scl negative edge will occure
		if(scl == 0) begin
			// check if 8 bits has been received
			if(bitscounter == 8) begin
				// stop shifting in the data
				flag <= 1;
				// 1 byte if data has been received
				bytecounter <= bytecounter + 1;
				// send out ack pulse
				// if this is 1st byte then 
				if(bytecounter == 0) begin
					// check if 1st byte received is 
					// correct address 
					if((reg0 & 8'hfe) == 8'hc6) begin 
						// address is correct 
						// save this info in flag1
						flag1 <= 1;
						// send ack pulse for now
						ack <= 1;
					end else begin
						//address is wrong
						// save this info in flag1
						flag1 <= 0;
						// keep ack low 
						ack <= 0;
					end
				end else
					// this is not 1st byte so 
					// if ack has to be 1 or 0 should aready
					// be saved in flag1 
					ack <= flag1;
			end
			
			// check if 9 bits has already been received
			if(bitscounter == 9) begin
				// stop ack as the time is over
				ack <= 0;
				// start shifting in data
				flag <= 0;
				// reset the counter
				bitscounter <= 0;
			end
		end
	end
	end
	// todo: remove next line 
	always @(reg0) dout <= reg0;
	
 endmodule 
 