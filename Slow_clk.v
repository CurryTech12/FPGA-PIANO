`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/19/2024 11:13:44 PM
// Design Name: 
// Module Name: Slow_clk
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


//module Slow_clk #(parameter div_value = 1)(
//input wire clk_in,
//output reg clk_out = 0
//);

module Slow_clk(
input clk_in,
output reg clk_out = 0//updates this out register to be either one or zero after 2 cycles
);
 reg[26:0] counter = 0;//updates counter value 
 always@(posedge clk_in)begin//checks at posedge of fast clock
 counter <= counter + 1; // increment counter by one
 if(counter == 1)begin//every 20 ns it flips so a full period 20ns high 20ns low = 40ns 
 //1/40ns = 25mhz clock each tick is 40ns
 counter <= 0;//restarts the counter
 clk_out = ~clk_out;//toggles the output register to either one or zero after two clock 
 end 
 end

endmodule
