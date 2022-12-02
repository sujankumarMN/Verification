class ram_scoreboard;
 ram_transaction rsb;
 mailbox mbox2sb;
 
 function new(mailbox mbox2sb);
  this.mbox2sb = mbox2sb;
 endfunction
 
 extern task run();
endclass

task ram_scoreboard::run();
 begin
	 integer i=10'd100;
	 integer address;
	 rsb = new;
	 mbox2sb.get(rsb);
	 #65;	
	 $display("\n[SCOREBOARD] Expected Address %d, Actual Address %d",i,rsb.address);
 end
endtask
