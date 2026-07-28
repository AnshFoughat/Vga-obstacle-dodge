`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.06.2026 21:42:28
// Design Name: 
// Module Name: player_controller
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


module player_controller(
    input wire clk,
    input wire rst,
    input wire btn_up,
    input wire btn_down,

    output reg [9:0] player_y
);

always @(posedge clk or posedge rst) begin
    if(rst)
        player_y <= 180;
    else begin

        if(btn_up && player_y > 5)
            player_y <= player_y - 20;

        else if(btn_down && player_y < 180)
            player_y <= player_y + 20;
    end
end

endmodule
