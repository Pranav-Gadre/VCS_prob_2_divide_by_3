`timescale 1ns/1ps
`include "div_by_three.v"

module div_by_3_tb();
    
    parameter DL105 = 105,
              DL200 = 200;
    reg clk,
        reset,
        x_i;
    wire div_o;
    integer i;
    
    initial begin 
    reset <= 1;
    #50; 
    reset <= 0;
    end 
    
    initial begin 
    clk = 0;
    x_i   = 0;
    end 
    
    always #5 clk = ~clk;
    
    task par_to_ser_in(
        input [15:0] number
        );
        begin 
            for (i = 0; i<=15; i=i+1) begin
                @(posedge clk);
                x_i <= number[i];
            end 
        end 
    endtask
    
    initial begin 
        #DL105;
        par_to_ser_in(3);
        #DL200;
        par_to_ser_in(15);
        #DL200;
        par_to_ser_in(75);
        #DL200;
        par_to_ser_in(375);
        #DL200;
        par_to_ser_in(47);
    end 
    
    property same_cycle_changes;
        @(posedge clk) disable iff (reset)
        ($fell(x_i) | $rose(x_i)) |-> ($fell(div_o) | $fell(div_o));
    endproperty
    
    div_by_three dbt0(
    .clk      (    clk      ),
    .reset    (    reset    ),
    .x_i      (    x_i      ),
    .div_o    (    div_o    )
    
    );  

endmodule