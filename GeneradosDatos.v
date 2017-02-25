`timescale 1ns / 1ps

module Generador_datos
    (
    input wire clk,
    input wire video_on,
    input wire [9:0] pixel_x, pixel_y,
    output reg [2:0] rgb_text   
 );
 //declaración de la señal
 
 wire [10:0] rom_addr; //dirección de memoria completa
 wire [6:0] char_addr; //  bits mas significativos de memoria
 wire [3:0] row_addr; // bit menos significativos de memoria, para variar filas
 wire [2:0] bit_addr; // señal intermedia
 wire [7:0] font_word; // datos de memoria
 wire font_bit;//variable intermedia
 wire bit5_y; //5to bit de posicion en y
 wire [4:0] bajos_x;
 reg [6:0] direc0, direc1, direc2, direc3;
 
//body
assign bit5_y = pixel_y[4];
assign row_addr= pixel_y[3:0]; //4 bits menos significatvos de y
assign bajos_x = pixel_x[4:0]; // menos significativos de x;


//FONT ROM
font_rom font_unit //modulo que crea las letras en memoria
   (.clk(clk), .addr(rom_addr), .data(font_word));
                     
 //rgb multiplexor
 always @*
    if(~video_on)
        rgb_text =3'b000; //blanck
    else
        if (font_bit)
            rgb_text =3'b010;
         else
            rgb_text =3'b000;
 endmodule             //



