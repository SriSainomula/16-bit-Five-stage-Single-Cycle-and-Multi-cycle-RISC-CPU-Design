`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.09.2024 22:02:01
// Design Name: 
// Module Name: flipflops_16
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

//16-bit REGISTER

module flipflops_16(D,clk,rst,en,Q);
  input [15:0]D;
  input clk,rst,en;
  output reg [15:0]Q;

    always @(posedge clk)
        begin
            if (rst)
                Q <= 16'b0;
            else if (en)
                Q <= D;
        end
 endmodule

