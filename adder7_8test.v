`timescale 1ns/10ps

module stimulus;

   reg clk, ci;
   reg [6:0] a,b,c,d,e,f,g,h;
   
   wire co;
   wire [6:0] s;
//   adder7_8 adder1(s,co,a,b,c,d,e,f,g,h,ci);
   adder7_8 adder1 (
   .s (s),
   .co (co),
   .a (a),
   .b (b),
   .c (c),
   .d (d),
   .e (e),
   .f (f),
   .g (g),
   .h (h),
   .ci (ci));
   
   initial 
     begin	
	clk = 1'b0;
	forever begin #5 clk = ~clk;
		//$display("At Time: %d  Sum=%b Carry=%d" ,$time,s,co); 	end
	end
     end

   initial
     begin
	$shm_open("shm.db",1); // Opens a waveform database
	$shm_probe("AS");    // Saves all signals to database
	#4000 $finish;		
	$shm_close();   // Closes the waveform database
     end


   // Stimulate the Input Signals
   initial
     begin
	   	a=1;	//output should be 8
	 	b=1;
		c=1;
	 	d=1;
		e=1;
	 	f=1;
		g=1;
	 	h=1;
		ci=0;

	#100	$display("At Time: %d  Sum=%d Carry=%d" ,$time,s,co);
	
	  	a=1;	//output should be 36
	 	b=2;
		c=3;
	 	d=4;
		e=5;
	 	f=6;
		g=7;
	 	h=8;
		ci=0;

	#100	$display("At Time: %d  Sum=%d Carry=%d" ,$time,s,co);
	
	  	a=15;	//output should be 120
	 	b=15;
		c=15;
	 	d=15;
		e=15;
	 	f=15;
		g=15;
	 	h=15;
		ci=0;

	#100	$display("At Time: %d  Sum=%d Carry=%d" ,$time,s,co);

	  	a=10;	//output should be 71
	 	b=14;
		c=15;
	 	d=0;
		e=4;
	 	f=6;
		g=9;
	 	h=13;
		ci=0;
	
	#100	$display("At Time: %d  Sum=%d Carry=%d" ,$time,s,co);

	  	a=1;	//output should be 37
	 	b=2;
		c=3;
	 	d=4;
		e=5;
	 	f=6;
		g=7;
	 	h=8;
		ci=1;

	#100	$display("At Time: %d  Sum=%d Carry=%d" ,$time,s,co);

	  	a=16;	//output should be 122
	 	b=15;
		c=15;
	 	d=15;
		e=15;
	 	f=15;
		g=15;
	 	h=15;
		ci=1;

	#100	$display("At Time: %d  Sum=%d Carry=%d" ,$time,s,co);

	  	a=16;	//output should be 128 (S=0 Carry=1)
	 	b=16;	//to check that Carry out works
		c=16;
	 	d=16;
		e=16;
	 	f=16;
		g=16;
	 	h=15;
		ci=1;

	#100	$display("At Time: %d  Sum=%d Carry=%d" ,$time,s,co);

     end

endmodule // stimulus





