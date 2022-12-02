`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"
program ram_env(ram_interface r);

	mailbox gen2drv=new();
	mailbox mon2sb=new();
	ram_generator ramGen =  new(gen2drv);
	ram_driver ramDrv = new(gen2drv,r);
	ram_monitor ramMon = new(mon2sb,r);
	ram_scoreboard ramSb = new(mon2sb);
	initial begin
		
		if($test$plusargs("reset"))
			ramGen.run("reset");
		else if ($test$plusargs("write"))
			ramGen.run("write");
		else if ($test$plusargs("read"))
			ramGen.run("read");
		else if ($test$plusargs("self"))
			ramGen.run("self");
	end
	
	initial 
	fork
		
	ramDrv.run();
	ramMon.run();
	ramSb.run();
	join
endprogram




























/*

//if($test$plusargs("reset"))
			//ramGen.run("reset");

initial begin
		//if($test$plusargs("reset"))
			//begin //r.cs=1;r.we=1;r.data_in=4'b1010; r.address=10'd120; #20;
		//	#10 reset=1; #50; end
		if ($test$plusargs("write"))
			begin r.cs=1;r.we=1;r.data_in=8'b1010_0000; r.address=10'd120; end
		else if ($test$plusargs("read"))
			begin r.cs=1;r.we=1;r.data_in=8'b1010_0000; r.address=10'd120;#10;
				r.cs=1;r.we=0;#10;
				r.oe=1;#20; 
			end
		else if ($test$plusargs("self"))
			begin 
				r.cs=1;r.we=1;r.data_in=4'b1111_0000; r.address=10'd111; #10;
				r.cs=1;r.we=0;#10;
				r.oe=1;#20;
				//reset=1;#50;
				//reset=0;#20
			end
	end
endprogram*/
