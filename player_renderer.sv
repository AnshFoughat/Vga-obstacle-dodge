`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.06.2026 21:42:28
// Design Name: 
// Module Name: player_renderer
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


module player_renderer(
    input wire [9:0] pixel_x,
    input wire [9:0] pixel_y,
    input wire [9:0] player_y,

    output wire player_on
);

localparam PLAYER_X = 100;
localparam PLAYER_W = 50;
localparam PLAYER_H = 50;

assign player_on =
       (pixel_x >= PLAYER_X) &&
       (pixel_x <  PLAYER_X + PLAYER_W) &&
       (pixel_y >= player_y) &&
       (pixel_y <  player_y + PLAYER_H);

endmodule
