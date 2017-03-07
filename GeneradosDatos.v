`timescale 1ns / 1ps

module Generador_datos
    (
    input wire clk,
    input wire [9:0] pixel_x, //posición pixel actual
    input wire [9:0] pixel_y,
    output wire [10:0] rom_addr
 );

 //variables internas de conexió

 wire [6:0] char_addr; //  bits mas significativos de dirreción de memoria
 wire [3:0] row_addr; // bit menos significativos de memoria, para variar filas
 wire [2:0] bit_addr; // señal de control MUX final
 wire [7:0] font_word; // datos de memoria
 wire bit5_y; //5to bit de posicion en y
 reg [1:0] selecreg;
 reg [1:0] letra;// revisar
//body
assign row_addr= pixel_y[3:0]; //4 bits menos significatvos de y

always @(pixel_x or pixel_y)
    begin
        if ((pixel_x < 10'b0000011000) && (pixel_x>10'b0000001111))begin       //Análisis de las filas
            selecreg = 2'b11;end                                                                           // si pixel_x es menor que 8; le asigna la letra E
        if ((pixel_x < 10'b0000010000) && (pixel_x>10'b0000000111))begin
             selecreg = 2'b10;end
        if (pixel_x < 10'b0000001000)begin
             selecreg = 2'b01;end
        if ((pixel_x > 10'b0000010111) | (pixel_y>5'b0000001111))begin
             selecreg = 2'b00;end
     end    
   
    
//Registros que almacenan direccionens
Registros register_unit
       (.clk(clk), .selec(selecreg), .direc(char_addr));

assign rom_addr ={char_addr, row_addr}; //concatena direcciones de registros y filas


endmodule //
