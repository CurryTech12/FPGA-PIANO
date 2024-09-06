`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/20/2024 02:22:48 PM
// Design Name: 
// Module Name: display_number
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


  module display_number(
    input clk,
    input [19:0] number,
    output reg [7:0] cathode,
    output reg [7:0] anode
    );
    
    reg [26:0] current_number, tick = 0;
    reg [26:0] MAX_NUMBER = 27'b101111101011110000011111111; // 99,999,999 //HGFEDCBA
    reg [3:0] seg0, seg1, seg2, seg3, seg4, seg5, seg6, seg7;
    wire [7:0] cathode0, cathode1, cathode2, cathode3;
    //, cathode4, cathode5, cathode6, cathode7;
    wire [26:0] out;
    
    always@ (*) begin
        current_number <= number;
        if (number > MAX_NUMBER) begin
            current_number <= number % MAX_NUMBER;
        end
        seg0 = current_number % 10;
        seg1 = current_number / 10 % 10;
        seg2 = current_number / 100 % 10;
        seg3 = current_number / 1000 % 10;
//        seg4 = current_number / 10000 % 10;
//        seg5 = current_number / 100000 % 10;
//        seg6 = current_number / 1000000 % 10;
//        seg7 = current_number / 10000000 % 10;
    end
    
    BCD_To_7seg BCD_0(.Q(seg0), .cathode(cathode0));
    BCD_To_7seg BCD_1(.Q(seg1), .cathode(cathode1));
    BCD_To_7seg BCD_2(.Q(seg2), .cathode(cathode2));
    BCD_To_7seg BCD_3(.Q(seg3), .cathode(cathode3));

    
    always@(posedge clk) begin
//        if(reset) begin
//            tick <= 27'b0;
//        end
        //461
        if(tick % 461 == 0) begin // first digit
            tick <= tick + 1'b1;
            anode <= 8'b1111_1110;
            cathode <= cathode0;
        end
        //773
        else if(tick %  661 == 0 && number >= 10) begin // second digit
            tick <= tick + 1'b1;
            anode <= 8'b1111_1101;
            cathode <= cathode1;
        end
        //1031
        else if(tick % 861 == 0 && number >= 100) begin // third digit
            tick <= tick + 1'b1;
            anode <= 8'b1111_1011;
            cathode <= cathode2;
        end
        else if(tick % 1061 == 0 && number >= 1000) begin // fourth digit
            tick <= tick + 1'b1;
            anode <= 8'b1111_0111;
            cathode <= cathode3;
        end
//        else if(tick % 13 == 0) begin // fifth digit
//            tick <= tick + 1'b1;
//            anode <= 8'b1110_1111;
//            cathode <= cathode4;
//        end
//        else if(tick % 17 == 0) begin // sixth digit
//            tick <= tick + 1'b1;
//            anode = 8'b1101_1111;
//            cathode = cathode5;
//        end
//        else if(tick % 19 == 0) begin // seventh digit
//            tick <= tick + 1'b1;
//            anode <= 8'b1011_1111;
//            cathode <= cathode6;
//        end
//        else if(tick % 23 == 0) begin // eigth digit
//            tick <= tick + 1'b1;
//            anode <= 8'b0111_1111;
//            cathode <= cathode7;
//        end
        else if(tick == 100000000) begin // if it reaches max
            tick <= 27'b0;
        end
        else begin
            tick <= tick + 1'b1;
        end
    end
endmodule
