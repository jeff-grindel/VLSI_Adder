`timescale 1ns/10ps

module stimulus;

   reg clk, ci;
   reg [6:0] a,b,c,d,e,f,g,h,i,j;
   
   wire co;
   wire [6:0] s;
//   adder7_8 adder1(s,co,a,b,c,d,e,f,g,h,ci);
   adder_tree5 adder1 (
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
   .i (i),
   .j (j),
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
	   	a=1;	//output should be 10
	 	b=1;
		c=1;
	 	d=1;
		e=1;
	 	f=1;
		g=1;
	 	h=1;
		i=1;
		j=1;
		ci=0;

	#100	$display("At Time: %d  Sum=%d Carry=%d" ,$time,s,co);
	
	  	a=1;	//output should be 55
	 	b=2;
		c=3;
	 	d=4;
		e=5;
	 	f=6;
		g=7;
	 	h=8;
		i=9;
		j=10;
		ci=0;

	#100	$display("At Time: %d  Sum=%d Carry=%d" ,$time,s,co);
	
	  	a=12;	//output should be 121 
	 	b=12;
		c=12;
	 	d=12;
		e=12;
	 	f=12;
		g=12;
	 	h=12;
		i=12;
		j=12;
		ci=1;

	#100	$display("At Time: %d  Sum=%d Carry=%d" ,$time,s,co);

	  	a=0;	//output should be 0
	 	b=0;
		c=0;
	 	d=0;
		e=0;
	 	f=0;
		g=0;
	 	h=0;
		i=0;
		j=0;
		ci=0;
	
	#100	$display("At Time: %d  Sum=%d Carry=%d" ,$time,s,co);

	  	a=1;	//output should be 44
	 	b=2;
		c=3;
	 	d=4;
		e=5;
	 	f=6;
		g=7;
	 	h=8;
		i=6;
		j=1;
		ci=1;

	#100	$display("At Time: %d  Sum=%d Carry=%d" ,$time,s,co);

	  	a=15;	//output should be 123
	 	b=15;
		c=15;
	 	d=15;
		e=15;
	 	f=15;
		g=15;
	 	h=15;
		i=1;
		j=1;
		ci=1;

	#100	$display("At Time: %d  Sum=%d Carry=%d" ,$time,s,co);

	  	a=10;	//output should be 128 (S=0 Carry=1)
	 	b=15;	//to check that Carry out works				//probably gonna not work
		c=15;
	 	d=15;
		e=7;
	 	f=12;
		g=13;
	 	h=15;
		i=15;
		j=10;
		ci=1;

	#100	$display("At Time: %d  Sum=%d Carry=%d" ,$time,s,co);

     end

endmodule // stimulus





