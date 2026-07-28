`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.06.2026 21:49:44
// Design Name: 
// Module Name: score_display
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


module score_display (

    input  logic [7:0] score,

    input  logic [9:0] pixel_x,
    input  logic [9:0] pixel_y,

    output logic score_on

);

    localparam int SCALE  = 4;
    localparam int ORIG_X = 540;
    localparam int ORIG_Y = 20;

    logic [3:0] tens;
    logic [3:0] ones;

    logic [14:0] font;

    integer row;
    integer col;
    integer bit_index;

    assign tens = score / 10;
    assign ones = score % 10;

    //--------------------------------------------------
    // Digit ROM (3x5)
    //--------------------------------------------------
    function automatic logic [14:0] digit_font(
        input logic [3:0] digit
    );

        case(digit)

            4'd0: digit_font = 15'b111_101_101_101_111;
            4'd1: digit_font = 15'b010_110_010_010_111;
            4'd2: digit_font = 15'b111_001_111_100_111;
            4'd3: digit_font = 15'b111_001_111_001_111;
            4'd4: digit_font = 15'b101_101_111_001_001;
            4'd5: digit_font = 15'b111_100_111_001_111;
            4'd6: digit_font = 15'b111_100_111_101_111;
            4'd7: digit_font = 15'b111_001_001_001_001;
            4'd8: digit_font = 15'b111_101_111_101_111;
            4'd9: digit_font = 15'b111_101_111_001_111;

            default:
                digit_font = 15'b000_000_000_000_000;

        endcase

    endfunction

    //--------------------------------------------------
    // Draw score
    //--------------------------------------------------
    always_comb begin

        score_on = 1'b0;

        //--------------------------------------
        // TENS DIGIT
        //--------------------------------------
        if(pixel_x >= ORIG_X &&
           pixel_x < ORIG_X + 3*SCALE &&
           pixel_y >= ORIG_Y &&
           pixel_y < ORIG_Y + 5*SCALE)
        begin

            col = (pixel_x - ORIG_X) / SCALE;
            row = (pixel_y - ORIG_Y) / SCALE;

            bit_index = 14 - (row*3 + col);

            font = digit_font(tens);

            score_on = font[bit_index];

        end

        //--------------------------------------
        // ONES DIGIT
        //--------------------------------------
        else if(pixel_x >= ORIG_X + 3*SCALE + 4 &&
                pixel_x < ORIG_X + 6*SCALE + 4 &&
                pixel_y >= ORIG_Y &&
                pixel_y < ORIG_Y + 5*SCALE)
        begin

            col = (pixel_x - (ORIG_X + 3*SCALE + 4))
                    / SCALE;

            row = (pixel_y - ORIG_Y)
                    / SCALE;

            bit_index = 14 - (row*3 + col);

            font = digit_font(ones);

            score_on = font[bit_index];

        end

    end

endmodule

