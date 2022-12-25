class mul_driver;
	mul_transaction mdrv;
	mailbox mbox2drv;
	virtual mul_interface mul_interface_driver;
	
	function new(mailbox mbox2drv,virtual mul_interface mul_interface_driver)
		this.mbox2drv=mbox2drv;
		this.mul_interface_driver=mul_interface_driver;
	endfunction
	
	extern task run();
	extern task send_to_dut(mul_transaction mul_drive);
endclass

task mul_driver::run();
	begin
		@(posedge mul_interface_driver.clk);
		mdrv=new;
		mbox2drv.get(mdrv);
		send_to_dut(mdrv);
	end
endtask

task mul_driver::send_to_dut(input mul_transaction mul_drive);
	begin
		@(posedge mul_interface_driver.clk)
		begin
			mul_drive.A=mul_interface_driver.A;
			mul_drive.B=mul_interface_driver.B;
		end
	end
endtask
		
