
class ram_generator;
    ram_transaction rgen;
	mailbox rgen2mbox;
	
	function new(mailbox rgen2mbox);
		this.rgen2mbox= rgen2mbox;
	endfunction
	
	extern task run(string stringname);
endclass

	task ram_generator::run(string stringname);
		begin
			if(stringname=="reset")
			begin
				rgen = new;
				/*rgen.data_in=8'b1000_1000;
				rgen.address=10'd100;*/
				rgen.rtype=reset;
				rgen.randomize();
				$display("[GENERATOR] Reset operation is in progress");
				rgen2mbox.put(rgen);
			end
			if(stringname=="write")
			begin
				rgen = new;
				/*rgen.data_in=8'b1000_1000;
				rgen.address=10'd100;*/
				rgen.rtype=write;
				rgen.randomize();
				
				$display($time, "[GENERATOR] Write operation is in progress data_in = %0d", rgen.data_in);
				rgen2mbox.put(rgen);
				//$display("[GENERATOR] Write operation is in progress data_in = %0h", rgen.data_in);
			end
			if(stringname=="read")
			begin
				rgen = new;
				/*rgen.data_in=8'b1000_1000;
				rgen.address=10'd100;*/
				rgen.rtype=read;
				rgen.randomize();
				$display("[GENERATOR] Read operation is in progress, data_in= %d  address= %d",rgen.data_in,rgen.address);
				
				rgen2mbox.put(rgen);
			end
			if(stringname=="self")
			begin
				rgen = new;
				/*rgen.data_in=8'b1000_1000;
				rgen.address=10'd100;*/
				rgen.rtype=self;
				rgen.randomize();
				$display("[GENERATOR] Self testing is in progress");
				rgen2mbox.put(rgen);
			end
		end
	endtask


		
