
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
//	DESIGN THINKING SECTION: https://chipmunklogic.com/digital-logic-design/micro-architecture-to-check-divisibility-by-n/
///////////////////////////
	
	QUESTIONS:
	
	Givens and Observations:
	
	Assumptions:
	
	CAVEATS:
	
	EDGE CASES:
	
	Design SPEC:
	
*/


module div_by_three (
  input   wire    clk,
  input   wire    reset,

  input   wire    x_i,

  output  wire    div_o

);

  // Write your logic here...
    parameter   R0 = 0,
                R1 = 1,
                R2 = 2;
    
    reg  [1:0] state;
    // assign div_o = (state == R0);
    
    // assign div_o = (state == R0) ? (x_i == 1) ? 0 : 1 : 
    //                (state == R1) ? (x_i == 1) ? 1 : 0 : 
    //                (state == R2) ? (x_i == 1) ? 0 : 0 : 
    //                0;
    
    assign div_o = ((state == R0 & (~x_i)) | (state == R1 & (x_i))) ? 1 : 0;
    
    always @ (posedge clk, posedge reset) begin 
        if (reset) begin 
            state <= R0;
        end else begin
            case (state) 
            default: state <= R0;
            R0:      state <= (x_i) ? R1 : R0;
            R1:      state <= (x_i) ? R0 : R2;
            R2:      state <= (x_i) ? R2 : R1;
            endcase
        end 
    end 

    // K-map based equaitons, for some reason it does not work 
    // Y  is state[1], Z is state[0], x is input 
    // Dy is Din equation to Y DFF or state[1]
    // Dz is Din equation to Z DFF or state[0] 
    // Dy  = y.x  + z.x'
    // state[1] <= (state[1] & (x_i))   | (state[0] & (~x_i));
    // Dz  = y.x' + y'.z'
    // state[0] <= (state[1] & (~x_i)) | ((~state[1]) & (~state[0]));
    // Out = z.x  + y'.z'.x'
    // assign div_o = (state[0] & x_i) | ((~state[1]) & (~state[0]) & (~x_i));
    

endmodule
