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
   
endmodule // adder7

module adder4_2(s, co, a, b, c, d); //used as second level in tree structure
   
   output [6:0] s,co;	//7-bit Sum output and 7-bit carry in where co[0] = 0 (Carry In will be added in later)
   input [6:0] 	a, b, c, d ;	//7-bit Input A, B, C, D

   wire [6:0] ts;
   wire [6:0] tc;
   wire c1,c2;//crap 1 and 2
  
  assign co[0] = 0;
  assign tc[0] = 0;
  
   adder s00(ts[0],tc[1],a[0],b[0],c[0]);
   adder s01(ts[1],tc[2],a[1],b[1],c[1]);
   adder s02(ts[2],tc[3],a[2],b[2],c[2]);
   adder s03(ts[3],tc[4],a[3],b[3],c[3]);
   adder s04(ts[4],tc[5],a[4],b[4],c[4]);
   adder s05(ts[5],tc[6],a[5],b[5],c[5]);
   adder s06(ts[6],c1,   a[6],b[6],c[6]);
     
   adder s10(s[0],co[1],ts[0],d[0],tc[0]);
   adder s11(s[1],co[2],ts[1],d[1],tc[1]);
   adder s12(s[2],co[3],ts[2],d[2],tc[2]);
   adder s13(s[3],co[4],ts[3],d[3],tc[3]);
   adder s14(s[4],co[5],ts[4],d[4],tc[4]);
   adder s15(s[5],co[6],ts[5],d[5],tc[5]);
   adder s16(s[6],c2,  ts[6],d[6],tc[6]);
     
endmodule

//5:2 adder with all inputs and outputs 7-bit wide
module adder5_2(s, co, a, b, c, d, e);
   
   output [6:0] s,co;	//7-bit Sum output and 7-bit carry in where co[0] = 0 (Carry In will be added in later)
   input [6:0] 	a, b, c, d, e;	//7-bit Input A, B, C, D, E

   wire [6:0] ts0, ts1;
   wire [6:0] tc0, tc1;
   wire c1,c2, c3, c4;//crap 1 and 2
   wire t1, t2;

  assign tc0[0] = 0;
  assign tc1[0] = 0;
  assign co[0] = 0;  
   
   adder s00(ts0[0],tc0[1],a[0],b[0],c[0]);
   adder s01(ts0[1],tc0[2],a[1],b[1],c[1]);
   adder s02(ts0[2],tc0[3],a[2],b[2],c[2]);
   adder s03(ts0[3],tc0[4],a[3],b[3],c[3]);
   adder s04(ts0[4],tc0[5],a[4],b[4],c[4]);
   adder s05(ts0[5],tc0[6],a[5],b[5],c[5]);
   adder s06(ts0[6],c1,a[6],b[6],c[6]);
   
   adder s10(ts1[0],tc1[1],ts0[0],d[0],e[0]);
   adder s11(ts1[1],tc1[2],ts0[1],d[1],e[1]);
   adder s12(ts1[2],tc1[3],ts0[2],d[2],e[2]);
   adder s13(ts1[3],tc1[4],ts0[3],d[3],e[3]);
   adder s14(ts1[4],tc1[5],ts0[4],d[4],e[4]);
   adder s15(ts1[5],tc1[6],ts0[5],d[5],e[5]);
   adder s16(ts1[6],c2, ts0[6],d[6],e[6]);   
   
   adder s20(s[0],co[1],ts1[0],tc0[0],tc1[0]);
   adder s21(s[1],co[2],ts1[1],tc0[1],tc1[1]);
   adder s22(s[2],co[3],ts1[2],tc0[2],tc1[2]);
   adder s23(s[3],co[4],ts1[3],tc0[3],tc1[3]);
   adder s24(s[4],co[5],ts1[4],tc0[4],tc1[4]);
   adder s25(s[5],co[6],ts1[5],tc0[5],tc1[5]);
   adder s26(s[6],  c3, ts1[6],tc0[6],tc1[6]);
 
endmodule // adder8

//7-operand adder utilizing the 3:2 adders
module adder_tree5(s, co, a, b, c, d, e, f, g, h, i, j, ci);

	output [6:0] s;
	output co;
	input  [6:0] a, b, c, d, e, f, g, h, i, j;
	input ci; 

	wire [6:0] ts1, ts2, ts3;
	wire [6:0] tc1, tc2, tc3;
	
	//3:2 adders in linear fashion
	adder5_2 a1(ts1, tc1, a, b, c, d, e);
	adder5_2 a2(ts2, tc2, f, g, h, i, j);
	adder4_2 a3(ts3, tc3, ts1, tc1, ts2, tc2);

	adder7 a4(s, co, ts3, tc3, ci);		//normal FA implementation, adds in ci 

endmodule //7-operand adder
	
