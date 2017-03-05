`timescale 1ns / 1ps
module generador_tb();

    wire[2:0] rgb_tb;
    reg [7:0] switch;
    reg clk, video_on;
    integer i,x;
    reg [9:0] pixel_x,pixel_y;
    
GeneradosDatosTestbench Gd_tbunit(.clk(clk), .video_on (video_on), .pixel_x(pixel_x), .pixel_y(pixel_y), .rgb_text(rgb_tb), .switch(switch));
initial 
    begin
    clk = 0;
    switch = 8'b00001000;
    video_on =1;
    pixel_x = 10'b0000000000;
    pixel_y =  10'b0000000000;
    
    
    forever begin
    for(i=0;i<480;i=i+1)
        begin
  
        for(x=0;x<639; x=x+1)
        begin
        #40 pixel_x = pixel_x + 10'b0000000001;
        end
        if(pixel_x ==10'b1001111111)begin
        pixel_x = 10'b0000000000;end
        
        pixel_y = pixel_y +10'b0000000001;
        end
end
 if(pixel_y ==10'b0111011111)begin
        pixel_y = 10'b0000000000;end       
end
    always
    begin
        #5 clk = ~clk;
    end
endmodule




