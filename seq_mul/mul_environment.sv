`include "mul_generator.sv"
`include "mul_driver.sv"
program mul_environment(mul_interface m);
	mailbox gen2drv=new();
	mul_generator mulGen=new(gen2drv);
	mul_driver mulDrv=new(gen2drv,m);
	
	initial begin
	fork
		mulGen.run();
		mulDrv.run();
	join
	end
endprogram
	
	
