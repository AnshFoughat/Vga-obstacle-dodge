`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.06.2026 21:51:22
// Design Name: 
// Module Name: real_vga_top
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


module real_vga_top(

    input  logic clk,
    input  logic rst,

    input  logic btn_up,
    input  logic btn_down,

    output logic h_sync,
    output logic v_sync,

    output logic [3:0] vgaRed,
    output logic [3:0] vgaGreen,
    output logic [3:0] vgaBlue

);

    //--------------------------------------------------
    // VGA Signals
    //--------------------------------------------------

    logic clk_25;

    logic [9:0] pixel_x;
    logic [9:0] pixel_y;

    logic video_on;

    //--------------------------------------------------
    // Player Signals
    //--------------------------------------------------

    logic [9:0] player_y;
    logic player_on;

    //--------------------------------------------------
    // Obstacle Signals
    //--------------------------------------------------

    logic obstacle_on;

    logic [10:0] obs0_x;
    logic [10:0] obs1_x;
    logic [10:0] obs2_x;
    logic [10:0] obs3_x;

    //--------------------------------------------------
    // Collision
    //--------------------------------------------------

    logic collision;

    //--------------------------------------------------
    // Score
    //--------------------------------------------------

    logic [7:0] score;
    logic score_on;

    //--------------------------------------------------
    // Game FSM
    //--------------------------------------------------

    logic game_end;
    logic soft_reset;

    logic soft_reset_r;

    always_ff @(posedge clk) 
        soft_reset_r <= soft_reset;
    
    assign combined_reset = rst | soft_reset_r;

    //--------------------------------------------------
    // RGB
    //--------------------------------------------------

    logic [2:0] rgb;

    //--------------------------------------------------
    // Clock Divider
    //--------------------------------------------------

    clock_divider u_clk_div (
        .clk_in (clk),
        .rst    (1'b0),
        .clk_out(clk_25)
    );

    //--------------------------------------------------
    // VGA Timing
    //--------------------------------------------------

    vga_timing u_vga (

        .clk      (clk_25),

        .h_sync   (h_sync),
        .v_sync   (v_sync),

        .video_on (video_on),

        .x        (pixel_x),
        .y        (pixel_y)
    );
/////////////////////////debouce 
    wire up_db,down_db;
    debounce #(.threshold(10)) db_up (.clk(clk),
                    .btn(btn_up),
                    .out(up_db)
                    );
     debounce #(.threshold(10))db_down (.clk(clk),
                    .btn(btn_down),
                    .out(down_db)
                    ); 
    //--------------------------------------------------
    // Player Controller
    //--------------------------------------------------

    player_controller u_player_ctrl (

        .clk      (clk),
        .rst      (combined_reset),

        .btn_up   (btn_up),///btn_up se    up_db
        .btn_down (btn_down),///btn_down    down_db
        .player_y (player_y)
    );

    //--------------------------------------------------
    // Player Renderer
    //--------------------------------------------------

    player_renderer u_player_renderer (

        .pixel_x  (pixel_x),
        .pixel_y  (pixel_y),

        .player_y (player_y),

        .player_on(player_on)
    );

    //--------------------------------------------------
    // Obstacles
    //--------------------------------------------------

    obstacle_engine u_obstacles (

        .clk        (clk),
        .reset      (combined_reset),
        .game_end   (game_end),

        .pixel_x    (pixel_x),
        .pixel_y    (pixel_y),

        .obstacle_on(obstacle_on),

        .obs0_x     (obs0_x),
        .obs1_x     (obs1_x),
        .obs2_x     (obs2_x),
        .obs3_x     (obs3_x)
    );
// obstacle_engine u_obstacles ( ... );

//assign obstacle_on = 1'b0;
//assign obs0_x = 11'd700;
//assign obs1_x = 11'd800;
//assign obs2_x = 11'd900;
//assign obs3_x = 11'd1000;
    //--------------------------------------------------
    // Collision Detection
    //--------------------------------------------------

    collision_engine u_collision (

        .player_y(player_y),

        .obs0_x(obs0_x),
        .obs1_x(obs1_x),
        .obs2_x(obs2_x),
        .obs3_x(obs3_x),

        .collision(collision)
    );

    //--------------------------------------------------
    // Score Counter
    //--------------------------------------------------

    score_engine u_score (

        .clk(clk),
        .reset(combined_reset),
        .game_end(game_end),

        .obs0_x(obs0_x),
        .obs1_x(obs1_x),
        .obs2_x(obs2_x),
        .obs3_x(obs3_x),

        .score(score)
    );

    //--------------------------------------------------
    // Score Display
    //--------------------------------------------------

    score_display u_score_display (

        .score(score),

        .pixel_x(pixel_x),
        .pixel_y(pixel_y),

        .score_on(score_on)
    );

    //--------------------------------------------------
    // Game FSM
    //--------------------------------------------------

    game_fsm u_game_fsm (

        .clk(clk),
        .rst(rst),

        .collision(collision),

        .game_end(game_end),
        .soft_reset(soft_reset)
    );
//assign game_end   = 1'b0;
//assign soft_reset = 1'b0;
    //--------------------------------------------------
    // Simple GAME OVER box
    //--------------------------------------------------

    logic gameover_on;

    assign gameover_on =
           game_end &&
           (pixel_x >= 220) &&
           (pixel_x <  420) &&
           (pixel_y >= 200) &&
           (pixel_y <  260);

    //--------------------------------------------------
    // RGB Priority
    //--------------------------------------------------

    always_comb begin

        if(!video_on)
            rgb = 3'b000;

        else if(gameover_on)
            rgb = 3'b110;

        else if(score_on)
            rgb = 3'b111;

        else if(player_on)
            rgb = 3'b010;

        else if(obstacle_on)
            rgb = 3'b100;

        else
            rgb = 3'b001;

    end

    //--------------------------------------------------
    // VGA Outputs
    //--------------------------------------------------

    assign vgaRed   = {4{rgb[2]}};
    assign vgaGreen = {4{rgb[1]}};
    assign vgaBlue  = {4{rgb[0]}};

endmodule