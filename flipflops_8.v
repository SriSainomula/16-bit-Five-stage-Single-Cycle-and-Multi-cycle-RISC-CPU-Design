`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.09.2024 21:59:46
// Design Name: 
// Module Name: flipflops_8
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

//8-bit REGISTER

module flipflops_8(D,clk,rst,en,Q);
  input [7:0]D;
  input clk,rst,en;
  output reg [7:0]Q;

    always @(posedge clk)
        begin
            if (rst)
                Q <= 8'b0;
            else if (en)
                Q <= D;
        end
 endmodule
