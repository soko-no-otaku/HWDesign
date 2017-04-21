module mul(A,B,O,ck,start,fin);
   input [7:0] A,B;
   input       ck,start;
   output [16:0] O;
   output 	 fin;

   reg [7:0] 	 INA,INB;
   reg [3:0] 	 st;
   reg 		 fin;
   reg [16:0] 	 OUT;

   always @(posedge ck) begin
      if(start == 1) begin
	 INA <= A;
	 INB <= B;
	 st <= 0;
	 fin <= 0;
	 OUT <= 0;
      end else begin
	 case(st)
	   'b0000 : OUT <= (OUT<<1) + INA*(INB[7]);
	   'b0001 : OUT <= (OUT<<1) + INA*(INB[6]);
	   'b0010 : OUT <= (OUT<<1) + INA*(INB[5]);
	   'b0011 : OUT <= (OUT<<1) + INA*(INB[4]);
	   'b0100 : OUT <= (OUT<<1) + INA*(INB[3]);
	   'b0101 : OUT <= (OUT<<1) + INA*(INB[2]);
	   'b0110 : OUT <= (OUT<<1) + INA*(INB[1]);
	   'b0111 : begin
	      OUT <= (OUT<<1) + INA*(INB[0]);
	      fin <= 1;
	   end
	   'b1000:begin
	      fin <= 0;
	   end
	 endcase // case (st)
	 st <= st + 1;
      end
   end // always @ (posedge ck)
   assign O = OUT;
endmodule // mul
