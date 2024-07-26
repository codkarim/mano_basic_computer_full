`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/05/2024 05:22:40 PM
// Design Name: 
// Module Name: instruction_regester
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
module decoder(
input[2:0] decoder_input,
input en,
output[7:0] decoder_output);

 assign decoder_output=en<<decoder_input;

endmodule





module instruction_regester(
    input clk_ir,
    input LD,
    input [7:0] IR, //DATA_IN
    output reg [7:0] data_out
    );
    integer J;
          
    always @(posedge clk_ir)
        begin
       
             if(LD) 
                data_out <= IR;
            
        end    
    
    
endmodule
