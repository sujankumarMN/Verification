interface mul_interface(input clk);
	logic [1:0]A;
	logic [1:0]B;
	logic [3:0]product;
	logic loadA,loadB,decB,loadF,clear,zero,start;
	logic [1:0]P;
	logic [1:0]Q;
	
	modport data_path(input clk,A,B,P,Q,loadA,loadB,decB,loadF,clear,output zero,product);
	modport controlpath(input clk,zero,start,output loadA,loadB,decB);
endinterface
