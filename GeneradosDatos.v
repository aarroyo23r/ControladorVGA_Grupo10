`timescale 1ns / 1ps

module Generador_datos
    (
    input wire clk,
    input wire video_on,
    input wire [9:0] pixel_x, pixel_y, //posición pixel actual
    output reg [2:0] rgb_text   // bit de color a VGA
    input wire[7:0] switch
 );

 //variables internas de conexió

 wire [10:0] rom_addr; //dirección de memoria completa
 wire [6:0] char_addr; //  bits mas significativos de dirreción de memoria
 wire [3:0] row_addr; // bit menos significativos de memoria, para variar filas
 wire [2:0] bit_addr; // señal de control MUX final
 wire [7:0] font_word; // datos de memoria
 wire font_bit;//variable de salida; antes de color
 wire bit5_y; //5to bit de posicion en y
 wire [4:0] bajos_x;
 reg [1:0] selecreg;
 reg [1:0] letra;

//body
assign bit_addr =pixel_x[2:0];
assign bit5_y = pixel_y[4];
assign row_addr= pixel_y[3:0]; //4 bits menos significatvos de y
assign bajos_x = pixel_x[4:0]; // menos significativos de x;

    always @(posedge clk)            // No se pueden mezclar partes conbinacionales y secuenciales en la lista de sensibilidad
    begin
        if (pixel_x < 10'b0000100000)         //Análisis de las filas
            letra = 2'b11;                     // si pixel_x es menor que 8; le asigna la letra E
        if (pixel_x < 10'b0000010000)
             letra = 2'b10;
        if (pixel_x < 10'b0000001000)
             letra = 2'b01;
        else begin
            letra = 2'b00;
            end
     end

    always @ (posedge clk)     // No se pueden mezclar partes conbinacionales y secuenciales en la lista de sensibilidad, creo que tiene que escribirlo algo asi (posedge bit5_y, posedge letra, posedge clk)
    begin                                         // asi cada vez que bit5_y o letra pasen de 0 a 1 entra en el always o cuando hay un flanco de reloj
       case(bit5_y)                        //Análisis por columnas con el 5to bit de pixel_y
       1'b1:selecreg <= 2'b00;           //No se bien la sintaxis del case pero me parece que esta combinando variables de distinto numero de bits
       1'b0:selecreg <= letra;
       endcase
    end

//Registros que almacenan direccionens
Registros register_unit
       (.clk(clk), .selec(selecreg), .direc(char_addr));

assign rom_addr ={char_addr, row_addr}; //concatena direcciones de registros y filas

//FONT ROM
Font_rom font_unit //modulo que crea las letras en memoria
   (.clk(clk), .dir(rom_addr), .data(font_word));

assign font_bit =font_word [~bit_addr];
 //rgb multiplexor
Color color_unir // modulo que determina si pasa o no rgb
    (.clk(clk), .switch(switch), .rgb(rgb_text), .bit_let(font_bit), .video_on(video_on)); // Aqui el switch no tiene nada asignado

endmodule //
