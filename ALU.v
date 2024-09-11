`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.09.2024 20:26:27
// Design Name: 
// Module Name: ALU
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

module ALU (SrcA, SrcB, ALUControl, zero_flag, greater_flag, ALUResult);
   
    input [15:0] SrcA, SrcB;
    input [1:0]  ALUControl;
    output zero_flag, greater_flag;
    output reg [15:0] ALUResult;

    assign zero_flag = (ALUResult== 16'h0000) ? 1'b1 : 1'b0; // Zero Flag
    assign greater_flag = (ALUResult[15] == 1'b0) ? 1'b1 : 1'b0; // Greater Flag 
    //[We will perform SrcA - SrcB, if Result is +ve it means SrcA is greater than SrcB 
    //                              else if Result is -ve it means SrcA is less than SrcB

    always @(*)
        begin
            case (ALUControl)
                2'b00: // ADD
                    ALUResult = SrcA + SrcB;
                2'b01: // SUB
                    ALUResult = SrcA + (~SrcB) + 1'b1;
                2'b10: // AND
                    ALUResult = SrcA & SrcB;
                2'b11: // OR
                    ALUResult = SrcA | SrcB;
                default:
                    ALUResult = 16'b0;
            endcase
        end

endmodule
