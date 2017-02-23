module SincronizadorVGA(
  input wire clk,reset,
  output wire hsync,vsync,video_on,tick,
  output wire [9:0] pixelx,pixely
  );

  //Declaracion de constantes
  //Parametros VGA 640*480

localparam HD=640; // Area horizontal de la pantalla en la que se puede escribir
localparam HF=48;//Porch frontal horizontal
localparam HB=16;//Porch trasero horizontal
localparam HR=96;//Retraso horizontal

localparam VD=480;//Area vertical de la pantalla en la que se puede escribir
localparam VF=10;//Porch frontal vertical
localparam VB=33;//Porch trasero vertical
localparam VR=2;//Retraso vertical

//Contador mod 4 para generar el clock de 25Mhz
reg [1:0] mod4_reg; //Registro para almacenar la cuenta
reg [1:0] mod4_next;//Registro para aumentar la cuenta

//Contadores de sincronizacion, eje x y eje y
reg [9:0] hcount_reg,hcount_next;//Registros para almacenar y aumentar la cuenta
reg [9:0] vcount_reg,vcount_next;//Registros para almacenar y aumentar la cuenta

//Buffers de salida
reg vsync_reg,hsync_reg;
wire vsync_next,hsync_next;

//Señales de estado
wire h_end,v_end, pixel_tick;//Señales para establecer el tick que genera el clock de 25Mhz y determinar si los contadores de sincronizacion finalizaron su cuenta


//Cuerpo
//Escritura de datos en los Registros
always @(posedge clk,posedge reset)
if (reset)//Si hay una señal en alto de reset, pone todas las señales del modulo en 0
begin
mod4_reg<=2'b00;
vcount_reg<=0;
hcount_reg<=0;
vsync_reg<=1'b0;
hsync_reg<=1'b0;
end

else//Si no, le asigna datos a los registros
begin
mod4_reg<=mod4_next;
vcount_reg<=vcount_next;
hcount_reg<=hcount_next;
vsync_reg<=vsync_next;
hsync_reg<=hsync_next;
end

//Contador mod 4
