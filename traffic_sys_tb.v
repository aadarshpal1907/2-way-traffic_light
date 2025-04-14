`timescale 1ns / 1ps
module traffic_light_tb;
    // Testbench signals
    reg clock;
    reg reset;
    wire [2:0] light_A;
    wire [2:0] light_B;
    
    // To monitor the counter and state
    wire [4:0] counter;
    wire [1:0] state;
    
    // Instantiate the Unit Under Test (UUT)
    traffic_light uut (
        .clock(clock),
        .reset(reset),
        .light_A(light_A),
        .light_B(light_B)
    );
    
    // Access internal signals for monitoring
    assign counter = uut.counter;
    assign state = uut.state;
    
    // Clock generation
    initial begin
        clock = 0;
        forever #10 clock = ~clock; // 20ns period clock
    end
    
    // Test sequence
    initial begin
        // Initialize and reset
        reset = 1;
        #30;
        reset = 0;
        
        // Run for enough cycles to see complete sequence
        #1000;
        
        $finish;
    end
    
    // Monitor lights and counter
    initial begin
        $monitor("Time=%0t, State=%0d, Counter=%0d, Road A: %b, Road B: %b", 
                 $time, state, counter, light_A, light_B);
    end
    
endmodule
