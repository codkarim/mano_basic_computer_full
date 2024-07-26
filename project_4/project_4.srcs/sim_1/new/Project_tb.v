`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/06/2024 02:37:02 PM
// Design Name: 
// Module Name: Project_tb
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


module Project_tb;
reg CLK_TB;

wire [15:0] T_TB ;
wire [3:0] SC_TB ;
wire [7:0] IR_TB ;
wire [3:0] PC_TB ;
wire [3:0] AR_TB ;
wire [7:0] DR_TB ;
wire [7:0] AC_TB ;
wire [7:0] D_TB  ;   
wire  E_TB  ; 


project D0(.CLK(CLK_TB),
           .T(T_TB),  
           .SC(SC_TB), 
           .IR(IR_TB),
           .PC(PC_TB), 
           .AR(AR_TB),
           .DR(DR_TB),
           .AC(AC_TB),
           .D(D_TB),
           .E(E_TB));




always begin
  #5 CLK_TB=~CLK_TB ;
end



initial begin
CLK_TB=0;



end


endmodule
