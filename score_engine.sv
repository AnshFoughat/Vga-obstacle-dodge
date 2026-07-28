`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.06.2026 21:45:53
// Design Name: 
// Module Name: score_engine
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


module score_engine (

    input wire clk,
    input wire reset,
    input wire game_end,

    input wire [10:0] obs0_x,
    input wire [10:0] obs1_x,
    input wire [10:0] obs2_x,
    input wire [10:0] obs3_x,

    output reg [7:0] score
);

parameter PLAYER_X = 100;
parameter OBS_WIDTH = 20;

reg p0,p1,p2,p3;

always @(posedge clk or posedge reset)
begin

    if(reset)
    begin
        score <= 0;

        p0 <= 0;
        p1 <= 0;
        p2 <= 0;
        p3 <= 0;
    end

    else if(!game_end)
    begin

        if(obs0_x + OBS_WIDTH < PLAYER_X && !p0)
        begin
            score <= score + 1;
            p0 <= 1;
        end

        if(obs1_x + OBS_WIDTH < PLAYER_X && !p1)
        begin
            score <= score + 1;
            p1 <= 1;
        end

        if(obs2_x + OBS_WIDTH < PLAYER_X && !p2)
        begin
            score <= score + 1;
            p2 <= 1;
        end

        if(obs3_x + OBS_WIDTH < PLAYER_X && !p3)
        begin
            score <= score + 1;
            p3 <= 1;
        end

        if(obs0_x > 500) p0 <= 0;
        if(obs1_x > 500) p1 <= 0;
        if(obs2_x > 500) p2 <= 0;
        if(obs3_x > 500) p3 <= 0;

    end
end

endmodule
