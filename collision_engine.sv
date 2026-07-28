`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.06.2026 21:45:53
// Design Name: 
// Module Name: collision_engine
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


module collision_engine(

    input wire [9:0] player_y,

    input wire [10:0] obs0_x,
    input wire [10:0] obs1_x,
    input wire [10:0] obs2_x,
    input wire [10:0] obs3_x,

    output wire collision
);

parameter PLAYER_X    = 100;
parameter PLAYER_W    = 50;
parameter PLAYER_H    = 50;

parameter OBS_WIDTH   = 20;
parameter OBS_HEIGHT  = 20;

parameter GROUND_Y    = 230;

wire c0,c1,c2,c3;

assign c0 =
    (PLAYER_X < obs0_x + OBS_WIDTH) &&
    (PLAYER_X + PLAYER_W > obs0_x) &&
    (player_y < GROUND_Y) &&
    (player_y + PLAYER_H > GROUND_Y-OBS_HEIGHT);

assign c1 =
    (PLAYER_X < obs1_x + OBS_WIDTH) &&
    (PLAYER_X + PLAYER_W > obs1_x) &&
    (player_y < GROUND_Y) &&
    (player_y + PLAYER_H > GROUND_Y-OBS_HEIGHT);

assign c2 =
    (PLAYER_X < obs2_x + OBS_WIDTH) &&
    (PLAYER_X + PLAYER_W > obs2_x) &&
    (player_y < GROUND_Y) &&
    (player_y + PLAYER_H > GROUND_Y-OBS_HEIGHT);

assign c3 =
    (PLAYER_X < obs3_x + OBS_WIDTH) &&
    (PLAYER_X + PLAYER_W > obs3_x) &&
    (player_y < GROUND_Y) &&
    (player_y + PLAYER_H > GROUND_Y-OBS_HEIGHT);

assign collision = c0 | c1 | c2 | c3;

endmodule
