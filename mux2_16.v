`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.09.2024 21:52:30
// Design Name: 
// Module Name: mux2_16
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

//16-bit 2to1 mux
module mux2_16 (I0,I1,sel,out );

    input [15:0]I0,I1;
    input sel;
    output [15:0]out;
    
    assign out = (sel == 1'b0) ? I0 : I1;

endmodule
