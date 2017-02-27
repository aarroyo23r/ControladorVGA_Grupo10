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
        wire video_on, tick;
        
        
        
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
              .switch(switch)
           ); 
          
endmodule
