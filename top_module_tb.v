`timescale 1ns / 1ps
module top_module_tb();

wire[2:0] rgb;
reg [7:0] switch;
reg clk, reset;
wire hsync, vsync;

Top_Module toptb (
    .clk(clk), .reset(reset), .switch(switch), .hsync(hsync), .vsync(vsync), .rgb(rgb));
initial 
    begin
    clk=0;
    switch = 8'b00001000;
    reset = 1'b0;
    end

always
    begin
        #5 clk = ~clk;
    end


endmodule
