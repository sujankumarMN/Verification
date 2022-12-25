
class ram_driver;
	ram_transaction rdrv;
	mailbox mbox2drv;
	virtual ram_interface ram_interface_driver;
	function new (mailbox mbox2drv,virtual ram_interface ram_interface_driver);
	
		this.mbox2drv=mbox2drv;
		this.ram_interface_driver=ram_interface_driver;
	
	endfunction
   extern task run();
   extern task send_to_dut(ram_transaction ram_drive);
endclass
	
	
	task ram_driver::run();
		rdrv=new;
		@(posedge ram_interface_driver.clk);
			mbox2drv.get(rdrv);
		
			send_to_dut(rdrv);
		
   endtask
  
    task ram_driver::send_to_dut(input ram_transaction ram_drive);//specify direction
    	@(posedge ram_interface_driver.clk)
		begin
			if(ram_drive.rtype == reset)
			begin 
				#10 ram_interface_driver.cs=1;
				ram_interface_driver.we=1;
				ram_interface_driver.data_in=ram_drive.data_in;
				ram_interface_driver.address=ram_drive.address;#20;
				#10 ram_interface_driver.reset=1;
				ram_interface_driver.we=0; #50;
				$display("[DRIVER] Reset operation is initiated");
			end
			if(ram_drive.rtype== write)
			begin 
				#10 ram_interface_driver.cs=1;
				ram_interface_driver.we=1;
				ram_interface_driver.data_in=ram_drive.data_in;
				ram_interface_driver.address=ram_drive.address;#20;
				$display("[DRIVER] write operation is initiated. DATA_IN=%h, Address=%h",ram_interface_driver.data_in,ram_interface_driver.address);
			end
			if(ram_drive.rtype== read)
			begin 
				#10 ram_interface_driver.cs=1;
				ram_interface_driver.we=1;
				ram_interface_driver.data_in=ram_drive.data_in; 
				ram_interface_driver.address=ram_drive.address;#10;
				$display("[DRIVER] write operation is initiated. DATA_IN=%h, Address=%h",ram_interface_driver.data_in,ram_interface_driver.address);
				ram_interface_driver.cs=1;ram_interface_driver.we=0;#10;
				ram_interface_driver.oe=1;#20; 
				$display("[DRIVER] Read operation is initiated. DATA_IN=%h, Address=%h, DATA_OUT=%h",ram_interface_driver.data_in,ram_interface_driver.address,ram_interface_driver.data_out);
			end
			if(ram_drive.rtype== self)
			begin 
			
				#10 ram_interface_driver.cs=1;
				ram_interface_driver.we=1;#10;
				ram_interface_driver.data_in=ram_drive.data_in;
				ram_interface_driver.address=ram_drive.address; #10;
				ram_interface_driver.cs=1;
				ram_interface_driver.we=0;#10;
				ram_interface_driver.oe=1;#20;
				ram_interface_driver.reset=1;#50;
				ram_interface_driver.reset=0;#20;
				
				ram_interface_driver.cs=0; ram_interface_driver.we=0; ram_interface_driver.oe=0; 
			 	ram_interface_driver.cs=0; ram_interface_driver.we=0; ram_interface_driver.oe=1; #12;
			 	ram_interface_driver.cs=0; ram_interface_driver.we=1; ram_interface_driver.oe=0; #5;
			    ram_interface_driver.cs=0; ram_interface_driver.we=1; ram_interface_driver.oe=1;
			    ram_interface_driver.address=ram_drive.address; ram_interface_driver.data_in=ram_drive.data_in; #5;
				ram_interface_driver.cs=1; ram_interface_driver.we=0; ram_interface_driver.oe=0; #5
				ram_interface_driver.cs=1; ram_interface_driver.we=0; ram_interface_driver.oe=1; #10;
				ram_interface_driver.cs=1; ram_interface_driver.we=1; ram_interface_driver.oe=0; #13;
			 	ram_interface_driver.cs=1; ram_interface_driver.we=1; ram_interface_driver.oe=0; #13;
			 	ram_interface_driver.cs=1; ram_interface_driver.we=1; ram_interface_driver.oe=1; #10;
				ram_interface_driver.cs=1; ram_interface_driver.we=0; ram_interface_driver.oe=0; #10;
				ram_interface_driver.cs=1; ram_interface_driver.we=0; ram_interface_driver.oe=1; #10;
				ram_interface_driver.cs=1; ram_interface_driver.we=1; ram_interface_driver.oe=0;ram_interface_driver.data_in=ram_drive.data_in; #13;
				ram_interface_driver.cs=1; ram_interface_driver.we=0; ram_interface_driver.oe=1; #10; 
				 
				//bank_selector=1'b0;datain=4'b1110; addr_row=2'b00;addr_col=2'b11;#15;
				ram_interface_driver.cs=1; ram_interface_driver.we=0; ram_interface_driver.oe=0; #10;
				ram_interface_driver.cs=1; ram_interface_driver.we=0; ram_interface_driver.oe=1; #10;
				$display("[DRIVER] self testing is initiated. DATA_IN=%h, Address=%h",ram_interface_driver.data_in,ram_interface_driver.address);
			end
		end
	endtask











/*

task ram_driver::run();
	cdrv=new;
	@(posedge ram_interface_driver.clk);
		mbox2drv.get(cdrv);
	if(cdrv.name==reset)
		send_to_dut(cdrv);
	else if(cdrv.name==write)
		send_to_dut(cdrv);
	else if(cdrv.name==read)
	 	send_to_dut(cdrv);
	else if(cdrv.name==self)
	 	send_to_dut(cdrv); 	
endtask

task ram_driver::send_to_dut(ram_transaction ram_drive);
	@(posedge ram_interface_driver.clk)
		begin
			if(ram_drive.name == reset)
			begin 
				#10 ram_drive.reset=1; #50;
			end
			if(ram_drive.name == write)
			begin 
				#10 ram_drive.cs=1;ram_drive.we=1;ram_drive.data_in=8'b1010_0000; ram_drive.address=10'd120;#20;
			end
			if(ram_drive.name == read)
			begin 
				#10 ram_drive.cs=1;ram_drive.we=1;ram_drive.data_in=8'b1010_0000; ram_drive.address=10'd120;#10;
				ram_drive.cs=1;ram_drive.we=0;#10;
				ram_drive.oe=1;#20; 
			end
			if(ram_drive.name == self)
			begin 
				#10 ram_int.cs=1;ram_int.we=1;ram_int.data_in=8'b1111_0000; ram_int.address=10'd111; #10;
				ram_int.cs=1;ram_int.we=0;#10;
				ram_int.oe=1;#20;
				reset=1;#50;
				reset=0;#20
			end
		end
endtask*/
