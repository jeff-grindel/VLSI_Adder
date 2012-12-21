// Adder 

module adder(s, co, a, b, ci);

   output s, co;	//Outputs of Sum and Carry Out
   input  a, b, ci;	//Inputs of A, b and Carry In
   
   wire   o0, o1, o2;	//Internal wiring
   	
   xor(s, a, b, ci);	//Calculation of Sum
   
   or(o0, a, b);	//Calculation of Carry Out
   or(o1, b, ci);
   or(o2, ci, a);
   and(co, o0, o1, o2);
   
endmodule // adder

//adder 7
module adder7(s, co, a, b, ci);
   
   output [6:0] s;	//7-bit Sum output
   output co;		//Output bit of Carry out
   
   input [6:0] 	a, b;	//7-bit Input A and B
   input ci;		//Input bit of Carry in
   
   wire 	c1, c2, c3, c4, c5, c6;
   adder a0(s[0], c1, a[0], b[0], ci);
   adder a1(s[1], c2, a[1], b[1], c1);	
   adder a2(s[2], c3, a[2], b[2], c2);
   adder a3(s[3], c4, a[3], b[3], c3);
   adder a4(s[4], c5, a[4], b[4], c4);
   adder a5(s[5], c6, a[5], b[5], c5);
   adder a6(s[6], co, a[6], b[6], c6);
   
endmodule // adder8

//7-operand adder
module adder7_8(s, co, a, b, c, d, e, f, g, h, ci);

	output [6:0] s;
	output co;
	input  [6:0] a, b, c, d, e, f, g, h;
	input ci; 

	wire [6:0] s1,s2,s3,s4,s5,s6;
	wire co1, co2, co3, co4, co5, co6;
	
	adder7 a0(s1, co1, a, b, ci);
	adder7 a1(s2, co2, c, s1, co1);
	adder7 a2(s3, co3, d, s2, co2);
	adder7 a3(s4, co4, e, s3, co3);
	adder7 a4(s5, co5, f, s4, co4);
	adder7 a5(s6, co6, g, s5, co5);
	adder7 a6(s, co, h, s6, co6);

endmodule //7-operand adder
	
