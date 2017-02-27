`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/27/2017 11:04:08 AM
// Design Name: 
// Module Name: Top_Module
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


module Top_Module(
     input clk,reset,
     input wire [7:0] switch,
     output wire hsync,vsync,
     output wire [2:0] rgb
    );
    
     wire [9:0] pixel_x, pixel_y;
     wire video_on, tick, rom_addr, font_bit;
     wire [7:0] font_word;
//error corregido, font_word es de 8 bits        
        
        
SincronizadorVGA SincronizadorVGA_unit(
          .clk(clk),.reset(reset),
          .hsync(hsync),.vsync(vsync),.video_on(video_on),.tick(tick),
          .pixelx(pixel_x),.pixely(pixel_y)
          );
          
Generador_datos Generador_datos_unit
              (
              .clk(clk),
              .video_on(video_on),
              .pixel_x(pixel_x), .pixel_y(pixel_y[4:0]), //posición pixel actual
              .rgb_text(rgb),   // bit de color a VGA
              .rom_addr(rom_addr)
           ); 
     
Font_rom Font_memory
     (
          .dir(rom_addr),
          .clk(clk),
          .data(font_word)
     );

 assign font_bit =font_word [~pixel_x[2:0]];    
 Color color
     (
          .clk(clk),
          .switch(switch),
          .rgb(rgb),
          .bit_let(font_bit),
          .video_on(video_on)
     );
endmodule
