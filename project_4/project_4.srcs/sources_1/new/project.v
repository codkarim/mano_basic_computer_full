`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/05/2024 08:52:32 PM
// Design Name: 
// Module Name: project
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


module project(
    input  CLK,
    output  reg [15:0] T ,
    output  reg [3:0] SC,
    output  reg [7:0] IR,
    output  reg [3:0] PC,
    output  reg [3:0] AR,
    output  reg [7:0] DR,
    output  reg [7:0] AC,
    output  reg [7:0] D,    //for decoding
    output  reg    E       // extended flag
    );
    
    reg [7:0] m [15:0] ;   //memory(16 *8)
    integer J;     // for (direct or indirect)
    initial begin
     T  <= 0;
     SC <= 0;
     IR <= 0;
     PC <= 0;
     AR <= 0;
     DR <= 0;
     AC <= 0;
     D <=  0;
     E <=  0;  
     
// MEMORY REFERENCE(DIRECT):-
     m[0]=8'h0a;   //AND
     m[1]=8'h1b;   //ADD
     m[2]=8'h2c;   //LDA
     m[3]=8'h3d;   //STA
     m[4]=8'h4e;   //BUN
     m[5]=8'h5f;   //BSA
     m[6]=8'h60;   //ISZ
     
//MEMORY REFERENCE(INDIRECT):-
     m[7]=8'h81;   //AND
     m[8]=8'h92;   //ADD
     m[9]=8'ha3;   //LDA
     m[10]=8'hb4;  //STA
     m[11]=8'hc5;  //BUN
     
 // REGESTER REFERENCE   
     m[12]=8'h78;  //CLA
     m[13]=8'h74;  //CMA
     m[14]=8'h72;  //CIR
     m[15]=8'h71;  //CLA
    end
    
    always@(posedge CLK)
      begin
           SC <= SC + 1   ;//xx
       end   
    always@(SC)
    begin
    
      case(SC)   //= multiple if // Start Time Generation
      
        4'b0000 :T = 16'h0001;  //T0
        4'b0001 :T = 16'h0002;  //T1
        4'b0010 :T = 16'h0004;  //T2
        4'b0011 :T = 16'h0008;  //T3
        4'b0100 :T = 16'h0010;  //T4
        4'b0101 :T = 16'h0020;  //T5
        4'b0110 :T = 16'h0040;  //T6
        4'b0111 :T = 16'h0080;  //T7 
        4'b1000 :T = 16'h0100;  //T8 //XX
        4'b1001 :T = 16'h0200;  //T9
        4'b1010 :T = 16'h0400;  //T10
        4'b1011 :T = 16'h0800;  //T11
        4'b1100 :T = 16'h1000;  //T12
        4'b1101 :T = 16'h2000;  //T13
        4'b1110 :T = 16'h4000;  //T14
        4'b1111 :T = 16'h8000;  //T15
        endcase
        
        if(T[0])begin  //Fetch  The Next Instruction
         AR<= PC;
         end
         
         if (T[1])begin  // Decode
          IR<= m[AR];
          PC<=PC+1;
         end
         if (T[2])begin  
           J<=IR[7];
           
           case(IR[6:4])  // Choose The Operation By Decoder
             3'B000: D =8'h01;    //D0
             3'B001: D =8'h02;    //D1
             3'B010: D =8'h04;    //D2
             3'B011: D =8'h08;    //D3
             3'B100: D =8'h10;    //D4
             3'B101: D =8'h20;    //D5
             3'B110: D =8'h40;    //D6
             3'B111: D =8'h80;    //D7
        
           endcase
        
        AR<=IR[3:0]; //Check Indirect Flag
        end
        if(~D[7] && J && T[3])  begin //Indirect
            AR<=m[AR];
            end
  //Memory Instruction Reference             
        if (D[0]&&T[4])  begin //AND
        DR<= m[AR] ;
        end
         if (D[0]&&T[5])  begin //AND
             AC<=AC & DR ;
             SC<=0  ;          
          end
        
         
        if (D[1]&&T[4])  begin //ADD
              DR<=m[AR];
         end     
         if (D[1]&&T[5])  begin //ADD
               {E,AC} = AC+DR;
               SC<=0;         
         end
         
                
          
       if (D[2]&&T[4])  begin    //LDA
           DR<=m[AR];                      
        end
        if (D[2]&&T[5])  begin  //LDA
        AC<=DR;
        SC<=0;             
        end                         
         
         
         
         if (D[3]&&T[4])  begin  //STA
         m[AR]<=AC;
         SC<=0;
         end
        
        
        
        if (D[4]&&T[4])  begin   //BUN
        PC<=AR;
        SC<=0;
        end
        
        
        
        if (D[5]&&T[4])  begin  //BSA
         m[AR]<=PC;
         AR<=AR+1;
        end
        
        if (D[5]&&T[5])  begin  //BSA
        PC<=AR;
        SC<=0;
        end
        
        
        
        if (D[6]&&T[4])  begin  //ISZ
        DR<=m[AR];
        end
        
        if (D[6]&&T[5])  begin  //ISZ
        DR<=DR+1;
        end
        
        if (D[6]&&T[6])  begin  //ISZ
        m[AR]<= DR;
            if(DR==0)begin
              PC<=PC+1;
            end
         SC<=0;  
        end
        
 //Regester Instruction reference
        if (D[7] && ~J && T[3]) begin   // r
        SC<=0;
        end 
        if (D[7] && ~J && T[3]&&IR[3])begin  //CLA
        AC<=0;
        end
        
        
        if (D[7] && ~J && T[3]&&IR[2])begin  //CMA
         AC<=~AC;       
        end
                
                
        if (D[7] && ~J && T[3]&&IR[1])begin   //CIR
          AC <= AC>>>1;  //XX
          AC[7]<=E;
          E<=AC[0];           
        end
        
        if (D[7] && ~J && T[3]&&IR[0])begin  //CIL
          AC <= AC<<<1;  //XX
          AC[0] <= E;
          E <= AC[7];       
        end
        
        
        
    end
    
    
    

endmodule
