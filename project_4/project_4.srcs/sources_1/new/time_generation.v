`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/05/2024 05:58:16 PM
// Design Name: 
// Module Name: timer
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


module timer(
    input clk,
    //input t0,t1,t2,t3,t4,t5,t6,t7,
    input clr_SC,
    input inc_SC,
    output reg [3:0] T
    );
    initial T = 0;
    always@(posedge clk)begin
    if(clr_SC)
      T=0;
    else if (inc_SC)
    
      T=T +1;
        
    end
endmodule
