`timescale 1ns / 1ps

module Generador_datos
    (
    input wire clk, reset,
    input wire video_on,
    input wire [2:0] btn,
    input wire [6:0] sw,
    input wire [9:0] pixel_x, pixel_y,
    output reg [2:0] rgb_text   
 );
 //declaración de la señal
 
 wire [10:0] rom_addr; //dirección de memoria completa
 wire [6:0] char_addr; //  bits mas significativos de memoria
 wire [3:0] row_addr; // bit menos significativos de memoria, para variar filas
 wire [2:0] bit_addr; // señal intermedia
 wire [7:0] font_word; // datos de memoria
 wire font_bit; //variable intermedia
 wire we;
 wire [11:0] addr_r, addr_w;
 wire [6:0] din, dout;
 //80 by 30 tile map
 localparam MAX_X = 80;
 localparam MAX_Y = 30;
 //cursor
 reg [6:0] cur_x_reg;
 wire [6:0] cur_x_next;
 reg [4:0] cur_y_reg;
 wire[4:0] cur_y_next;
 wire move_x_tick, move_y_tick, cursor_on;
 //delayed pixel count
 reg[9:0] pix_x1_reg, pix_y1_reg;
 reg[9:0] pix_x2_reg, pix_y2_reg;
 //object output signals
 wire[2:0] font_rgb, font_rev_rgb;
 
//body
//antirebote
debounce deb_unit0
    (.clk(clk), .reset(reset), .sw(btn[0]), .db_level(), .db_tick(move_x_tick));
debounce deb_unit1
        (.clk(clk), .reset(reset), .sw(btn[1]), .db_level(), .db_tick(move_y_tick)); 
 //FONT ROM
 font_rom font_unit //modulo que crea las letras en memoria
    (.clk(clk), .addr(rom_addr), .data(font_word));
 //RAM
 xilinx_dual_port_ram_sync
    #(.ADDR_WIDTH(12), .DATA_WIDTH(7)) video_ram
    (.clk(clk), .we(we), .addr_a(addr_w), .addr_b(addr_r), .din_a(din),
    .dout_a(), .dout_b(dout));
//registros
always @(posedge clk)
    begin
        cur_x_reg <= cur_x_next;
        cur_y_reg <= cur_y_next;
        pix_x1_reg <= pixel_x;
        pix_x2_reg <= pix_x1_reg;
        pix_y1_reg <= pixel_y;
        pix_y2_reg <= pix_y1_reg;
    end
//escritura de mosaico
 assign addr_w = {cur_y_reg , cur_x_reg};
 assign we = btn[2];
 assign din = sw;
//tile RAM read 
// nondelayed coordinates
assign addr_r ={pixel_y[8:4], pixel_x[9:3]};
assign char_addr = dout;
//font ROM
assign row_addr=pixel_y[3:0];
assign rom_addr ={char_addr, row_addr};
//use delayed coordinate to select a bit
assign bit_addr = pix_x2_reg[2:0];
assign font_bit = font_word[~bit_addr];
//new cursor position
assign cur_x_next =
    (move_x_tick && (cur_x_reg == MAX_X-1))? 0 : //wrap
    (move_x_tick)? cur_x_reg +1:
                   cur_x_reg;
assign cur_y_next = 
    (move_y_tick && (cur_x_reg == MAX_Y-1))? 0 : //wrap
    (move_y_tick)? cur_y_reg +1:
                   cur_y_reg;
//object signals
//green over black and reversed video for cursor
assign font_rgb = (font_bit) ? 3'b010 : 3'b000;
assign font_rev_rgb = (font_bit) ? 3'b000: 3'b010;
//use delayed coordinates for comparison
assign cursor_on = (pix_y2_reg[8:4] == cur_y_reg) &&
                   (pix_x2_reg[9:3] ==cur_x_reg);
 //rgb multiplexor
 always @*
    if(~video_on)
        rgb_text =3'b000; //blanck
    else
        if (cursor_on)
            rgb_text = font_rev_rgb;
         else
            rgb_text =font_rgb;
 endmodule             //



