`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.09.2024 21:57:48
// Design Name: 
// Module Name: mux2_8
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


//8-bit 2to1 mux
module mux2_8 (I0,I1,sel,out );

    input [7:0]I0,I1;
    input sel;
    output [7:0]out;
    
    assign out = (sel == 1'b0) ? I0 : I1;

endmodule
