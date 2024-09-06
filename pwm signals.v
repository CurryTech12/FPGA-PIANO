`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/27/2024 09:38:40 AM
// Design Name: 
// Module Name: pwm signals
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


module pwm_signals(
    input new_clk_in,
    input [19:0]counter_value_button,
    output pwm_audio
    );
    reg [19:0]counter = 0;
    reg signal = 0;
    always@(posedge new_clk_in)begin
        if(counter < counter_value_button)begin
            counter <= counter + 1;
        end else begin
            counter = 0;
            signal <= ~signal;
        end
   end
    assign pwm_audio = signal;
endmodule