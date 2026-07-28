`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.06.2026 21:42:28
// Design Name: 
// Module Name: vga_timing
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


module vga_timing(
    input  clk,
    output reg  h_sync,
    output reg  v_sync,
    output video_on,
    output [9:0] x,
    output  [9:0] y
);



assign x = h_count;
assign y = v_count;

endmodule
