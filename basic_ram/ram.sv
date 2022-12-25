module ram(ram_interface r);
	logic [7:0]mem[127:0];
	
	always @(posedge r.clk)
	begin
		if(r.reset==1)
		  begin 
		   mem[r.address]=8'bzzzz_zzzz; 
			r.data_out=mem[r.address]; 
		end
		if(r.cs==1 && r.we==1 )
			mem[r.address]=r.data_in;
		else if(r.cs==1 && r.we== 0 && r.oe ==1)
			r.data_out=mem[r.address];
	end
endmodule
