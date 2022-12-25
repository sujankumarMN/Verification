class ram_scoreboard;
 ram_transaction rsb;
 ram_transaction rsb_gen;
 mailbox mbox2sb;
 mailbox gen2sb;
 
 function new(mailbox mbox2sb, mailbox gen2sb);//);
  this.mbox2sb = mbox2sb;
  this.gen2sb = gen2sb;
 endfunction
 
 extern task run();
endclass

task ram_scoreboard::run();
 begin
	 //integer i=10'd100;
	 //integer address;
	 rsb = new;
	 rsb_gen = new;
	 
	 fork
	 mbox2sb.get(rsb);
	 gen2sb.get(rsb_gen);
	 join
	 //#200;	
	 $display($time,"[SCOREBOARD] DATA_IN %d, DATA_IN_GEN %d ",rsb.data_in, rsb_gen.data_in);
 end
endtask

//",,
