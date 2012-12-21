// 1-bit Adder 
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

//7-bit adder used in the final calculation after the 3:2 adders have done there thing
module adder7(s, co, a, b, ci);
   
   output [6:0] s;	//7-bit Sum output
   output co;		//Output bit of Carry out
   
   input [6:0] 	a, b;	//7-bit Input A and B
   input ci;			//Input bit of Carry in
   
   wire 	c1, c2, c3, c4, c5, c6;	

   adder a0(s[0], c1, a[0], b[0], ci);	
   adder a1(s[1], c2, a[1], b[1], c1);	
   adder a2(s[2], c3, a[2], b[2], c2);
   adder a3(s[3], c4, a[3], b[3], c3);
   adder a4(s[4], c5, a[4], b[4], c4);
   adder a5(s[5], c6, a[5], b[5], c5);
   adder a6(s[6], co, a[6], b[6], c6);
   
endmodule // adder8

//3:2 adder with all inputs and outputs 7-bit wide
module adder3_2(s, co, a, b, c);
   
   output [6:0] s,co;	//7-bit Sum output and 7-bit carry in where co[0] = 0 (Carry In will be added in later)
   input [6:0] 	a, b, c;	//7-bit Input A and B
	
   wire 	c1;		//the last carry bit is not used so assign to bogus entiry
  
   assign co[0] = 0;	//assingment of co[0] to 0, this causes the Carry vector to be shifted over to left by 1
   
   adder a0(s[0], co[1], a[0], b[0], c[0] );	
   adder a1(s[1], co[2], a[1], b[1], c[1]);	
   adder a2(s[2], co[3], a[2], b[2], c[2]);
   adder a3(s[3], co[4], a[3], b[3], c[3]);
   adder a4(s[4], co[5], a[4], b[4], c[4]);
   adder a5(s[5], co[6], a[5], b[5], c[5]);
   adder a6(s[6], c1, a[6], b[6], c[6]);
   
  
   
endmodule // adder8

//7-operand adder utilizing the 3:2 adders
module adder_lin(s, co, a, b, c, d, e, f, g, h, ci);

	output [6:0] s;
	output co;
	input  [6:0] a, b, c, d, e, f, g, h;
	input ci; 

	wire [6:0] s1,s2,s3,s4,s5,s6;
	wire [6:0]co1, co2, co3, co4, co5, co6;
	
	//3:2 adders in linear fashion
	adder3_2 a0(s1, co1, a, b, c);
	adder3_2 a1(s2, co2, s1, co1, d);
	adder3_2 a2(s3, co3, s2, co2, e);
	adder3_2 a3(s4, co4, s3, co3, f);
	adder3_2 a4(s5, co5, s4, co4, g);
	adder3_2 a5(s6, co6, s5, co5, h);

	adder7 a6(s, co, s6, co6, ci);		//normal FA implementation, adds in ci 

endmodule //7-operand adder
	
