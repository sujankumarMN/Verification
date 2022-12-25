`include "ram_package.sv"
import ram_package::*;
`include "ram.sv"
`include "ram_interface.sv"
`include "ram_environment.sv"


module ram_tb();
	bit clk;
	
	ram_interface ram_int(clk);
	ram dut(ram_int);
	ram_env renv(ram_int);
	
	initial begin 
	  clk=1'b0;
	end
	
	always #5 clk=~clk;
	

	initial begin 
	#1000 $finish;
	end
endmodule
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	/*initial begin
		if($test$plusargs("reset"))
			reset=1;
		else if ($test$plusargs("write"))
			begin ram_int.cs=1;ram_int.we=1;ram_int.data_in=4'b1010; ram_int.address=10'd120; end
		else if ($test$plusargs("read"))
			begin ram_int.cs=1;ram_int.we=1;ram_int.data_in=4'b1010; ram_int.address=10'd120;#10;
				ram_int.cs=1;ram_int.we=0;#10;
				ram_int.oe=1;#20; 
			end
		else if ($test$plusargs("self"))
			begin 
				ram_int.cs=1;ram_int.we=1;ram_int.data_in=4'b1111; ram_int.address=10'd111; #10;
				ram_int.cs=1;ram_int.we=0;#10;
				ram_int.oe=1;#20;
				reset=1;#10;
				//reset=0;
			end
	end
	*/


