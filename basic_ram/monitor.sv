
class ram_monitor;
	ram_transaction rmon;
	mailbox mon2mbox;
	virtual ram_interface ram_interface_monitor;
	function new(mailbox mon2mbox, virtual ram_interface ram_interface_monitor);
		 this.mon2mbox=mon2mbox;
		 this.ram_interface_monitor=ram_interface_monitor;
	endfunction
	
	extern task run();
endclass

 task ram_monitor::run();
  begin
  rmon = new;
  begin
  //always@ (*)
  @(posedge ram_interface_monitor.clk)
  
   rmon.cs=ram_interface_monitor.cs;
   rmon.we=ram_interface_monitor.we;
   rmon.oe=ram_interface_monitor.oe;
   rmon.reset=ram_interface_monitor.reset;
   rmon.data_in=ram_interface_monitor.data_in;
   rmon.data_out=ram_interface_monitor.data_out;
   rmon.address=ram_interface_monitor.address;
//   rmon.rtype=ram_interface_monitor.rtype;
  $display($time,"[MONITOR] DUT to Monitor data_in=%d, address = %d, data_out=%b", rmon.data_in, rmon.address, rmon.data_out);
   mon2mbox.put(rmon);
 end
 end
endtask
