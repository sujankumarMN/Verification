class mul_generator;
	mul_transaction mgen;
	mailbox gen2mbox;
	
	function new(mailbox gen2mbox)
		this.gen2mbox=gen2mbox;
	endfunction
	
	extern task run();
endclass

task mul_generator::run();
begin
	mgen=new;
	mgen.A=2;
	mgen.B=3;
	gen2mbox.put(mgen);
end
endtask
	
