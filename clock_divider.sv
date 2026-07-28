`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.06.2026 21:42:28
// Design Name: 
// Module Name: clock_divider
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


module clock_divider(
    input  wire clk_in,
    input  wire rst,
    output clk_out
);

reg [1:0] div_cnt;

always @(posedge clk_in or posedge rst) begin
    if (rst)
        div_cnt <= 2'b00;
    else
        div_cnt <= div_cnt + 1;
end

assign clk_out = div_cnt[1];

//always @(posedge clk_in or posedge rst) begin
//    if (rst) begin
//        div_cnt <= 0;
//        clk_out <= 0;
//    end
//    else if (div_cnt == 1) begin
//        div_cnt <= 0;
//        clk_out <= ~clk_out;
//    end
//    else begin
//        div_cnt <= div_cnt + 1;
//        clk_out <= clk_out;
//    end
//end
endmodule
