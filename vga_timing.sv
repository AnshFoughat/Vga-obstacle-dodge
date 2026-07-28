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
    input  wire clk,
    output reg  h_sync,
    output reg  v_sync,
    output wire video_on,
    output wire [9:0] x,
    output wire [9:0] y
);

localparam HD = 640;
localparam HF = 16;
localparam HS = 96;
localparam HB = 48;

localparam VD = 480;
localparam VF = 10;
localparam VS = 2;
localparam VB = 33;

reg [9:0] h_count = 0;
reg [9:0] v_count = 0;

always @(posedge clk) begin
    if(h_count == HD+HF+HS+HB-1) begin
        h_count <= 0;

        if(v_count == VD+VF+VS+VB-1)
            v_count <= 0;
        else
            v_count <= v_count + 1;
    end
    else
        h_count <= h_count + 1;
end

always @(*) begin
    h_sync = ~((h_count >= HD+HF) &&
               (h_count <  HD+HF+HS));

    v_sync = ~((v_count >= VD+VF) &&
               (v_count <  VD+VF+VS));
end

assign video_on = (h_count < HD) &&
                  (v_count < VD);

assign x = h_count;
assign y = v_count;

endmodule
