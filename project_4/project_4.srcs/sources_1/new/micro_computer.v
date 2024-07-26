`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/05/2024 09:51:28 AM
// Design Name: 
// Module Name: memory
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


module memory(
    input clk,
    input r_wn,        // write (actve low) and read active(high)
    input [3:0] ar,  //address regester 4-bit
    inout  [7:0] databus
    );
    
    reg [7:0] temp_data;
    
    reg [7:0] m [15:0] ; //16 memory locatins and 8 word length
    // PC and AR=4_BIT , THE REST OF REGESTERS IS 8_BIT
    initial begin
    
      m[0]=8'h0a;
      m[1]=8'h1b;
      m[2]=8'h2c;
      m[3]=8'h3d;
      m[4]=8'h4e;
      m[5]=8'h5f;
      m[6]=8'h60;
      m[7]=8'h81;
      m[8]=8'h92;
      m[9]=8'ha3;
      m[10]=8'hb4;
      m[11]=8'hc5;
      m[12]=8'h78;
      m[13]=8'h74;
      m[14]=8'h72;
      m[15]=8'h71;
      
     end
    
    always@ (posedge clk)
    begin
        if(!r_wn)
        begin
           m[ar] = databus;
        end
        else
        begin
           temp_data =  m[ar];
        end
     end  
    
    assign databus = r_wn ? temp_data : 'hzz;
    
endmodule
