`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.02.2017 23:41:58
// Design Name: 
// Module Name: Color
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


module Color(
    input wire clk,
    input wire [7:0] switch,
    output wire [2:0] rgb,
    input wire bit_let,
    input wire video_on
    );
  
  reg [2:0] rgb_reg;
  
  always @(posedge clk)
    if (bit_let)
        case (switch)
            8'b00000001: rgb_reg = 3'b001;
            8'b00000010: rgb_reg = 3'b010;
            8'b00000100: rgb_reg = 3'b011;
            8'b00001000: rgb_reg = 3'b100;
            8'b00010000: rgb_reg = 3'b101;
            8'b00100000: rgb_reg = 3'b110;
            8'b01000000: rgb_reg = 3'b111;
            8'b10000000: rgb_reg = 3'b000;
        endcase
     else 
        rgb_reg <= 0;
   assign rgb = (video_on) ? rgb_reg : 3'b000;
endmodule
