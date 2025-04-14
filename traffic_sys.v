`timescale 1ns / 1ps
    

module traffic_light (
    input wire clock,
    input wire reset,
    output reg [2:0] light_A,  // Road A light [R,Y,G]
    output reg [2:0] light_B   // Road B light [R,Y,G]
);

    // Define the light colors
    parameter RED    = 3'b100;
    parameter YELLOW = 3'b010;
    parameter GREEN  = 3'b001;
    
    parameter A_GREEN  = 0;
    parameter A_YELLOW = 1;
    parameter B_GREEN  = 2;
    parameter B_YELLOW = 3;
    
    // How long each light stays on
    parameter GREEN_TIME  = 10;
    parameter YELLOW_TIME = 3;
    
    // Variables
    reg [1:0] state;
    reg [4:0] counter;
    
    // Main logic
    always @(posedge clock or posedge reset) begin
        if (reset) begin
            // Reset everything to starting position
            state <= A_GREEN;
            counter <= 0;
            light_A <= GREEN;
            light_B <= RED;
        end
        else begin
            case (state)
           A_GREEN: begin
               // Road A has green light
               light_A <= GREEN;
               light_B <= RED;
               
               // Count time
               if (counter == GREEN_TIME - 1) begin
               state <= A_YELLOW;
                   counter <= 0;               // Wanting robustness to counter overshoot ">="     
               end                                 //Clean, controlled FSM logic	==
               else 
                    counter <= counter + 1;
           end
           
           A_YELLOW: begin
               // Road A has yellow light
               light_A <= YELLOW;
               light_B <= RED;
               
               // Count time
               if (counter == YELLOW_TIME - 1)begin
                  state <= B_GREEN;
                  counter <= 0; 
                  end  
                   else 
                    counter <= counter + 1;
           end
           
           B_GREEN: begin
               // Road B has green light
               light_A <= RED;
               light_B <= GREEN;
               
               // Count time
               if (counter == GREEN_TIME - 1)
               begin
                   state <= B_YELLOW;
                   counter <= 0;
               end
           else
                counter <= counter + 1;
           end
           
           B_YELLOW: begin
               // Road B has yellow light
               light_A <= RED;
               light_B <= YELLOW;
               
               // Count time
               if (counter == YELLOW_TIME - 1)
                begin
                   state <= A_GREEN;
                   counter <= 0;
               end
                   
               else counter <= counter + 1;
                end
            endcase
        end
    end
    
endmodule
