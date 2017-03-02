`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.02.2017 21:17:23
// Design Name: 
// Module Name: Top_Module_tb
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


module Top_Module_tb(
    );

    reg clk, reset;
    reg [7:0] switch_tb;
    wire hsync_tb, vsync_tb;
    wire [2:0] rgb_tb;
    
    Top_Module Top_Module(
        .clk(clk),
        .reset(reset),
        .switch(switch_tb),
        .hsync(hsync_tb),
        .vsync(vsync_tb),
        .rgb(rgb_tb)
        );
     
     initial
     begin
     clk=0;
     reset=1;
     #10 reset=0;
     end
     
     always 
     begin
     #10 switch_tb=8'b00000001;
     #10 switch_tb=8'b00000010;
     #10 switch_tb=8'b00000100;
     #10 switch_tb=8'b00001000;
     #10 switch_tb=8'b00010000;
     #10 switch_tb=8'b00100000;
     #10 switch_tb=8'b01000000;
     #10 switch_tb=8'b10000000;
     end   
     
     always 
     begin
        #5 clk = ~clk;
     end
endmodule
