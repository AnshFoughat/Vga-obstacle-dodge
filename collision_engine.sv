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

//// logic//

assign collision = c0 | c1 | c2 | c3;

endmodule
