
/*

	While going through your Grandma's old store, you come across an interesting machine 
	which takes an input x and gives an output whenever the number formed within the machine 
	is divisible by 3. Being intrigued with the machine, you start tinkering with it and 
	realise that the machine serially takes the input x and concatenates it to the least 
	significant bit (LSB) position of the currently seen inputs to form the new number.
	
	The table below shows the working of the machine for 5 clock cycles.
	
	Timestamp		Serial Input x		Formed Number in Binary		Divisible by Three
	t0				0					'b0							Yes
	t1				1					'b01						No
	t2				1					'b011						Yes
	t3				0					'b0110						Yes
	t4				1					'b01101						No
	
	Note: The above table is an example for 5-clocks only. 
	Though the machine could go on forever and the number would keep growing!
	
	Excited with your findings, you decide to model this on your FPGA board. 
	Design the machine as per the mentioned specifications. 
	All the flops should be positive edge triggered with asynchronous reset (if any).

	Interface Definition
	x_i   : Serial input to the machine
	div_o : Output which says the current number is divisible by three
	
	Interface Requirements:
	* The machine receives input every cycle
	* The machine should produce output on the same cycle when the input is seen
	* Assume that the machine gives a HIGH output when the current number is 0
	* The new input bit x_i is inserted on the LSB side of the current number
	
*/

/*
///////////////////////////
//	DESIGN THINKING SECTION:
///////////////////////////
	
	QUESTIONS:
	
	Givens and Observations:
	
	Assumptions:
	
	CAVEATS:
	
	EDGE CASES:
	
	Design SPEC:
	
*/


module div_by_three (
  input   logic    clk,
  input   logic    reset,

  input   logic    x_i,

  output  logic    div_o

);

  // Write your logic here...

endmodule