module controlpath(mul_interface m);
	//logic clk,zero,start,loadA,loadF,loadB,decB;
  typedef enum {s0,s1,s2,s3,s4} State;
	State state;
	always @(posedge m.clk)
	begin
		case(state)
			s0:  if(m.start) state=s1;
			s1:  state=s2;
			s2:  state=s3;
			s3:  if(m.zero) state=s4;
			s4:  state=s0;
			default: state=s0;
		endcase
	end
  always @(state)
	begin
		case(state)
				s0:  begin m.loadA=0; m.loadB=0; m.decB=0; end
				s1:  begin m.loadA=1;end
				s2:  begin m.loadA=0;m.loadB=1;m.decB=0; end
				s3:  begin m.loadA=0;m.loadB=0;m.decB=1;m.loadF=1; end
				s4:  begin m.loadA=0;m.loadB=0; m.decB=0; end
				default: state=s0;
		endcase
    end
endmodule
			  

