interface ram_interface(input clk);
	logic [7:0]data_in;
	logic [7:0]data_out;
	logic [6:0]address;
	logic cs,we,oe,reset;
	//logic [7:0]mem[127:0];
	modport ram(input cs,we,oe,reset,data_in,address,clk,output data_out);
endinterface
