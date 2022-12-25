`include "mul_package.sv"
import mul_package::*;
`include "datapath.sv"
`include "controlpath.sv"
`include "mul_interface.sv"
`include "mul_environment.sv"
module regA_tb();
	/*logic [1:0]A;
	logic [1:0]P;
	logic clk,loadA;
	logic [1:0]B;
	logic [1:0]Q;
	logic loadB,decB,start;
	logic [3:0]product;
	logic loadF,clear;
	logic zero;*/
	bit clk;
	mul_interface intf(clk);
	data_path dut(intf);
	controlpath dut1(intf);
	mul_environment menv(intf); 
 	
	initial clk=1'b0;
	always #5 clk=~clk;
	initial begin
		//intf.A=2;intf.B=3;
      intf.start=1;
      
	end	
	initial begin
		$dumpfile("test.vcd");
		$dumpvars;
		#200 $finish;
	end
endmodule 

