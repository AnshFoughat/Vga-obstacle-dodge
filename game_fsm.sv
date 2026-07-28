`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.06.2026 21:48:13
// Design Name: 
// Module Name: game_fsm
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


module game_fsm (

    input  logic clk,
    input  logic rst,

    input  logic collision,

    output logic game_end,
    output logic soft_reset

);

    typedef enum logic [1:0] {
        PLAY,
        GAME_OVER,
        RESET_GAME
    } state_t;

    state_t state, next_state;

    logic [31:0] timer;

    localparam int WAIT_COUNT = 30_000_000; // 3 sec @100MHz

    //------------------------------------------------
    // State register
    //------------------------------------------------
    always_ff @(posedge clk or posedge rst) begin

        if(rst)
            state <= RESET_GAME;
        else
            state <= next_state;

    end

    //------------------------------------------------
    // Timer
    //------------------------------------------------
//    always_ff @(posedge clk or posedge rst) begin

//        if(rst)
//            timer <= 0;

//        else if(state == GAME_OVER) begin

//            if(timer < WAIT_COUNT + 3)begin
//                timer <= timer + 1;
//            end
//        end

//        else
//            timer <= 0;

//    end
logic [31:0] reset_count;

always_ff @(posedge clk or posedge rst) begin
    if(rst) begin
        timer <= 0;
        reset_count <= 0;
    end
    else if(state == GAME_OVER) begin
        if(timer < WAIT_COUNT)
            timer <= timer + 1;
    end
    else begin
        if(timer > 0)
            reset_count <= reset_count + 1;
        timer <= 0;
    end
end
    //------------------------------------------------
    // Next state logic
    //------------------------------------------------
    always_comb begin

        next_state = state;

        case(state)

            PLAY:
                if(collision)
                    next_state = GAME_OVER;

            GAME_OVER:
                if(timer >= WAIT_COUNT)
                    next_state = RESET_GAME;

            RESET_GAME:
                next_state = PLAY;

            default:
                next_state = PLAY;

        endcase

    end

    //------------------------------------------------
    // Outputs
    //------------------------------------------------
    always_ff @(posedge clk or posedge rst) begin
        if(rst) begin
            soft_reset <= 0;
            game_end   <= 0;
        end
        else begin
            case(state)
                PLAY:        begin game_end<=0; soft_reset<=0; end
                GAME_OVER:   begin game_end<=1; soft_reset<=0; end
                RESET_GAME:  begin game_end<=0; soft_reset<=1; end
                default:     begin game_end<=0; soft_reset<=0; end
            endcase
        end
    end



endmodule
