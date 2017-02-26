`timescale 1ns / 1ps

module Registros(
    input wire clk,
    input wire [1:0] selec,  //Aqui corregi el numero de bits, tenia 3 bits y solo son necesarios 2
    output reg [6:0] direc //más significativo de direcciones
    );
reg [1:0] selec_reg;

always @(posedge clk)
     selec_reg <= selec;
always @*
   case(selec_reg)
           2'b00: direc = 7'b0000000;  //igual aqui
           2'b01: direc = 7'b1000101;
           2'b10: direc = 7'b1000001;
           2'b11: direc = 7'b1001010;
    endcase
endmodule
