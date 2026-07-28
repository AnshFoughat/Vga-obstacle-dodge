`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.06.2026 21:45:53
// Design Name: 
// Module Name: obstacle_engine
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


module obstacle_engine(
    input clk, reset, game_end,

    input [9:0] pixel_x,
    input [9:0] pixel_y,

    output obstacle_on,

    output [10:0] obs0_x, obs1_x, obs2_x, obs3_x
);

endmodule

assign obstacle_on = hit0 | hit1 | hit2 | hit3;

endmodule
