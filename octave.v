`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/29/2024 12:30:33 PM
// Design Name: 
// Module Name: octave
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


module octave(
    input octave_0,octave_1,octave_2,octave_3,octave_4,octave_5
    ,octave_6,octave_7,
    input [19:0]counter_value1,
    input [19:0]LED_Update,
    output reg [19:0]counter_updated,
    output reg [19:0]new_led
    );
    reg [19:0] value;
    reg [19:0] buffer;
    wire [19:0] octave_all;
    
    assign octave_all = {octave_7,octave_6,octave_5,octave_4,octave_3,octave_2,octave_1,octave_0};
    
    always@(octave_all)begin
    if(octave_all == 8'b00000000)begin
        value = counter_value1;
        buffer = (LED_Update/1000);
     end else if(octave_all == 8'b00000001)begin
              value = counter_value1 * 16;
              buffer = (LED_Update/1000) / 16;
          end else if({octave_all} == 8'b00000010)begin
              value = counter_value1 * 8;
              buffer = (LED_Update/1000) / 8;
          end else if({octave_all} == 8'b00000100)begin
              value = counter_value1 * 4;
              buffer = (LED_Update/1000) / 4;
          end else if({octave_all} == 8'b00001000)begin
                value = counter_value1 * 2;
                buffer = (LED_Update/1000) / 2;
           end else if({octave_all} == 8'b00010000)begin
                 value = counter_value1;//default normal when this switch goes up
                 buffer = (LED_Update/1000);
            end else if({octave_all} == 8'b00100000)begin
                 value = counter_value1 / 2;//default normal when this switch goes up
                 buffer = (LED_Update * 2)/ 1000;
             end else if({octave_all} == 8'b01000000)begin
                  value = counter_value1 / 4;//default normal when this switch goes up
                  buffer =(LED_Update * 4)/ 1000;
             end else if({octave_all} == 8'b10000000)begin
                   value = counter_value1 / 8;//default normal when this switch goes up
                   buffer = (LED_Update * 8)/ 1000;
              end else begin
              value = 0;
              buffer = 0;
              end
              
           new_led <= buffer;
           counter_updated <= value;
        end
endmodule
