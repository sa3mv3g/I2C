 module I2C(input scl, inout _sda, output reg [7:0] data);
 
	reg [7:0]reg0, bitscounter, bytecounter;
	reg startbit, flag, flag1;
	reg ack, do_read, bit_to_send;
	wire sda;
	
	// a very important block
	initial flag = 0;
	initial do_read = 1;
	
	// driving _sda line.
	/*
	do_read  |  flag | _sda
	---------+-------+-------
	   0     |   0   |  bit_to_send
	---------+-------+-------
	   0     |   1   |  1'bz
	---------+-------+-------
	   1     |   0   |	1'bz
	---------+-------+-------
	   1     |   1   |  ack
	*/
	assign _sda = (do_read ^ flag )? 1'bz : ((do_read & flag) ? ack : bit_to_send);
	assign sda = _sda;
	
	// detect START condition and
	// reset all reg on START detect
	always @(negedge sda) if(scl == 1'b1) begin
		startbit = 1'b1;
		bitscounter <= 0;
		bytecounter <= 0;
		flag <= 0;
		flag1 <= 0;
		reg0 <= 0;
		ack <= 0;
		do_read <= 1;
	end
	
	// detect STOP condition
	always @(posedge sda) if(scl == 1'b1) startbit = 1'b0;
	
	always @(scl) begin
	if(startbit == 1) begin	
		// following if statement will fire when 
		// scl positive edge will occure
		if(scl == 1) begin
			// increase no of bits
			bitscounter <= bitscounter + 1;
			// if not in ACK/NACK bit 
			if(flag == 0) begin
				// if in read mode
				if(do_read == 1)
					//shift in data
					reg0 <= (reg0<<1)|sda;
			end
		end
		// following if statement will fire when 
		// scl negative edge will occure
		if(scl == 0) begin
			// check if 8 bits has been received
			// because this is negative edge this
			// means now we are in starting of 9th bit
			if(bitscounter == 8) begin
				// stop shifting in the data
				flag <= 1;
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
					
				end else begin
					// this is not 1st byte so 
					// if ack has to be 1 or 0 should aready
					// be saved in flag1 
					ack <= flag1;
					//save the value of reg0 to data
					data <= reg0;
				end
			end
			
			// check if 9 bits has already been received
			// because this is at negative edge, this means
			// that, now, we are at the end of 9th bit
			else if(bitscounter == 9) begin
				// stop ack as the time is over
				ack <= 0;
				// start shifting in data
				flag <= 0;
				// reset the counter
				bitscounter <= 0;
				// if in read mode then 
				if(do_read == 1)
					// 1 byte of data has been received, increase byte counter
					bytecounter <= bytecounter + 1;
				// if this is the 1st byte to be received then 
				if(bytecounter == 0) begin
					// now determine if user wants to read or write data
					if(reg0 & 8'h01) do_read <= 1;
					else do_read <= 0;
					// this address byte has not to be saved,
					// hence, store last saved value to reg0
					reg0 <= data;
				end
				
				//
				bit_to_send <= data[7];
			end
			// if in write mode
			else if(do_read == 0)
				// shift out data
				bit_to_send <= data[8'd7 - bitscounter];	
		end
	end
	end
	
	// todo: remove next line 
	//always @(reg0) data <= reg0;
	
 endmodule 
 