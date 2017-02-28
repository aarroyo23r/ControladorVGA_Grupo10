`timescale 10ns / 10ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 02/24/2017 09:05:10 PM
// Design Name:
// Module Name: tb_SincronizadorVGA
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


module tb_SincronizadorVGA();
     reg clk,reset;
     wire hsync,vsync,video_on,tick;
     wire [9:0] pixelx,pixely;


 SincronizadorVGA uut(
           .clk(clk),.reset(reset),
           .hsync(hsync),.vsync(vsync),.video_on(video_on),.tick(tick),
           .pixelx(pixelx),.pixely(pixely)
           );
           

 initial begin
 clk=0;
 reset=0;
 #16000000; // Duración de una impresión de pantalla
 #20; //Inicio de otra impresión
 reset=1;//Interrupcion por el reset
 #10;//Duración del reset
 reset=0;// Se vuelve a hacer otro ciclo completo de impresión
 #16000000;
 $finish;
 end

 always 
 begin
clk=~clk;
#10;
 end



 endmodule
