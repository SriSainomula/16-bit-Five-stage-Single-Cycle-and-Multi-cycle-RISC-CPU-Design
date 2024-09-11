`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.09.2024 21:55:23
// Design Name: 
// Module Name: mux4_16
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

//16-bit 4to1 mux
module mux4_16 (I0,I1,I2,I3,sel,out);

 input [15:0]I0,I1,I2,I3;
 input [1:0]sel;
 output reg [15:0]out;

    always @(*) 
        begin
            case (sel)
                2'b00: out = I0;
                2'b01: out = I1;
                2'b10: out = I2;
                2'b11: out = I3;
                default: out = I0;
            endcase
        end
endmodule
