`timescale 1ns / 1ps

module Registros(
    input wire clk,
    input wire [1:0] selec,
    output reg [6:0] direc //más significativo de direcciones
    );
reg [2:0] selec_reg;

always @(posedge clk)
     selec_reg <= selec;
always @*
   case(selec_reg)
           3'b00: direc = 7'b0000000;
           3'b01: direc = 7'b1000101;
           3'b10: direc = 7'b1000001;
           3'b11: direc = 7'b1001010;    
    endcase
endmodule
