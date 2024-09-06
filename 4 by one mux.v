`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/01/2023 09:18:23 PM
// Design Name: 
// Module Name: 4 by one mux
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


module MUX_4_1(
    input button_1, button_2, button_3, button_4, button_5, button_6,
     button_7, button_8, button_9, button_10, button_11, button_12,//so far have 6 buttons
    //need 6 more total 12
    input checkOctaveSeven,
    output reg [19:0]counter_value,//is the reload value to make the square wave
    //led vaule is the frequency of that note that we send to octave mod then 7 seg
    output reg [19:0]led_vaule
    );
    reg [19:0] value;
    wire [19:0]button;
    reg [19:0]LED;
    //concnate all the buttons into one so I dont have to write it multiple times
   
    assign button = {button_12, button_11, button_10, button_9, button_8,
     button_7, button_6, button_5, button_4, button_3, button_2, button_1};
    
     always@({button})begin
        if({button} == 12'b111111111111)begin
            LED = 0;
            value = 0;
        end else if({button} == 12'b111111111110)begin //first button is pressed, so send the reload value and LED value to octave module
            LED = 440000;
            value = 28409; //a
        end else if({button} == 12'b111111111101)begin //same for the rest 
                LED = 466164;
                value = 26814; //a# LED and value are different numbers because different reload value for different frequency
            end else if({button} == 12'b111111111011)begin
                LED = 493883;
                value = 25309; //b   
            end else if({button} == 12'b111111110111)begin
                LED = 523251;
                value = 23889; //c5          
            end else if({button} == 12'b111111101111)begin
                if(checkOctaveSeven)begin
                    {LED,value} = 2'b00;
                end else begin
                    LED = 554365;
                    value = 22548; //c#
                end     
            end else if({button} == 12'b111111011111)begin
            if(checkOctaveSeven)begin
                {LED,value} = 2'b00;
            end else begin
                LED = 587330;
                value = 21282; //d5
            end
        end else if({button} == 12'b111110111111)begin
            if(checkOctaveSeven)begin
                {LED,value} = 2'b00;
            end else begin
                LED = 622254;
                value = 20088; //d#
            end
        end else if({button} == 12'b111101111111)begin
            if(checkOctaveSeven)begin
                {LED,value} = 2'b00;
            end else begin
             LED = 659255;
             value = 18960; //e5
            end
        end else if({button} == 12'b111011111111)begin
            if(checkOctaveSeven)begin
                {LED,value} = 2'b00;
            end else begin
                LED = 698456;
                value = 17896; //f5
            end
        end else if({button} == 12'b110111111111)begin
            if(checkOctaveSeven)begin
                {LED,value} = 2'b00;
            end else begin
                LED = 739989;
                value = 16889; //f#
            end
        end else if({button} == 12'b101111111111)begin
            if(checkOctaveSeven)begin
                {LED,value} = 2'b00;
            end else begin
                LED = 783991;
                value = 15944; //g5
            end
        end else if({button} == 12'b011111111111)begin
            if(checkOctaveSeven)begin
                {LED,value} = 2'b00;
            end else begin
                LED = 830609;
                value = 15049;//g#
            end
        end else begin 
        LED = 0;
        value = 0;
        end

    led_vaule <= LED;//update the output to be equal to freq we want to show on 7seg
    counter_value <= value;//update output for reload value going into octave
    end
endmodule
