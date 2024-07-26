`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/05/2024 10:58:05 AM
// Design Name: 
// Module Name: memory_test
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


module memory_test ;
  reg clk_tb ;
  reg r_wn_tb ;
  reg [3:0] ar_tb;
  reg [7:0] datain_tb;          
  wire  [7:0] databus_tb;
  integer i ;
  
  memory i0(
  .clk(clk_tb),
  .r_wn(r_wn_tb),
  .ar(ar_tb),
  .databus(databus_tb)
  );
  
always begin
  #5 clk_tb =~clk_tb ;
end
  
assign databus_tb =! r_wn_tb ? datain_tb : 'hzz;  
  
initial begin  
  clk_tb=0;
  r_wn_tb=1;
  ar_tb=0;
  datain_tb=0;
  i=0;
  #10  r_wn_tb=0 ;
  #10  r_wn_tb=1 ;

  for (i=1;i<16;i=i+1)begin
     #10  ar_tb=i ;
 
  end

forever begin

 #10  ar_tb=1 ; #10  r_wn_tb=0 ;  datain_tb=16'h34;
 #10  ar_tb=2 ;                   datain_tb=16'h78;
 #10  ar_tb=3 ;                   datain_tb=16'hbc;
 #10  ar_tb=4 ;                   datain_tb=16'hf0;
 
 
 
end
end
endmodule
