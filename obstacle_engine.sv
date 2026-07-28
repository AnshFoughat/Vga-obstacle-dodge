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
    input  wire clk,
    input  wire reset,
    input  wire game_end,

    input  wire [9:0] pixel_x,
    input  wire [9:0] pixel_y,

    output wire obstacle_on,

    output wire [10:0] obs0_x,
    output wire [10:0] obs1_x,
    output wire [10:0] obs2_x,
    output wire [10:0] obs3_x
);

parameter OBS_WIDTH  = 20;
parameter OBS_HEIGHT = 20;

parameter SCREEN_W = 640;
parameter GROUND_Y = 230;

parameter SPACING = 150;

reg [10:0] obs_x [0:3];

assign obs0_x = obs_x[0];
assign obs1_x = obs_x[1];
assign obs2_x = obs_x[2];
assign obs3_x = obs_x[3];

reg [19:0] div;//12 to 23

always @(posedge clk or posedge reset)
begin
    if(reset)
        div <= 0;
//    else if(div == 4095)////3 from 4095
//        div <= 0;
    else
        div <= div + 1;
end

wire move_tick = (div == 20'd1000000);////3 from 4095

integer i;
//reg [1:0] i; 
always @(posedge clk or posedge reset)
begin
    if(reset || game_end)
    begin
//        obs_x[0] <= 640;
//        obs_x[1] <= 790;
//        obs_x[2] <= 940;
//        obs_x[3] <= 1090;
        obs_x[0] <= 11'd1200;
        obs_x[1] <= 11'd1400;
        obs_x[2] <= 11'd1600;
        obs_x[3] <= 11'd1800;
    end
    else if(move_tick && !game_end)
    begin

        for(i=0;i<4;i=i+1)
        begin

            if(obs_x[i] <= OBS_WIDTH)////from 1 to OBS_WIDTH
                obs_x[i] <= 1090;
            else
                obs_x[i] <= obs_x[i] - 1;

        end
    end
end

wire hit0,hit1,hit2,hit3;

assign hit0 =
    (pixel_x >= obs_x[0]) &&
    (pixel_x <  obs_x[0]+OBS_WIDTH) &&
    (pixel_y >= GROUND_Y-OBS_HEIGHT) &&
    (pixel_y <  GROUND_Y);

assign hit1 =
    (pixel_x >= obs_x[1]) &&
    (pixel_x <  obs_x[1]+OBS_WIDTH) &&
    (pixel_y >= GROUND_Y-OBS_HEIGHT) &&
    (pixel_y <  GROUND_Y);

assign hit2 =
    (pixel_x >= obs_x[2]) &&
    (pixel_x <  obs_x[2]+OBS_WIDTH) &&
    (pixel_y >= GROUND_Y-OBS_HEIGHT) &&
    (pixel_y <  GROUND_Y);

assign hit3 =
    (pixel_x >= obs_x[3]) &&
    (pixel_x <  obs_x[3]+OBS_WIDTH) &&
    (pixel_y >= GROUND_Y-OBS_HEIGHT) &&
    (pixel_y <  GROUND_Y);

assign obstacle_on = hit0 | hit1 | hit2 | hit3;

endmodule
