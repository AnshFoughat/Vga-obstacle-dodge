# Vga-obstacle-dodge

A real-time obstacle-dodging arcade game rendered live over VGA on FPGA, written in Verilog.
The player moves a sprite up/down to avoid incoming obstacles; collision detection, scoring,
and game state are all handled in hardware, with VGA timing generated from scratch
(no framebuffer/soft IP).

📹 Demo video, 📈 simulation waveforms, and a 🗺️ RTL architecture diagram are linked.

---

## Features

- VGA timing generator (640x480 or your configured resolution) driving sync + RGB output
- Debounced push-button input for player control (up / down)
- FSM-driven game states (idle / playing / collision / game over, etc.)
- Hardware collision detection between player sprite and obstacles
- Procedurally advancing obstacles via a dedicated obstacle engine
- On-screen score rendering, driven by a score engine + score display module
- Fully synchronous design driven off a single divided clock

---

## Architecture

```
real_vga_top
├── u_clk_div         : clock_divider      – generates the pixel/game clock from the board clock
├── u_vga             : vga_timing         – generates hsync/vsync/blanking + pixel coordinates
├── db_up             : debounce           – debounces the "move up" button
├── db_down           : debounce           – debounces the "move down" button
├── u_player_ctrl     : player_controller  – updates player position from debounced input
├── u_player_renderer : player_renderer    – draws the player sprite at the current pixel
├── u_obstacles       : obstacle_engine    – spawns/advances obstacles across the screen
├── u_collision       : collision_engine   – detects player/obstacle overlap
├── u_score           : score_engine       – tracks and increments score
├── u_score_display   : score_display      – renders the score digits on screen
└── u_game_fsm        : game_fsm           – top-level game state machine (idle/play/game over)
```

---

## Synthesis / Hardware

1. Add all files under `rtl/` to your FPGA vendor project (Vivado).
2. Constrain `clk` and `rst` to your board's clock and reset pins.
3. Map `hsync`, `vsync`, `vga_r`, `vga_g`, `vga_b` to the VGA connector pins.
4. Map `btn_up` / `btn_down` to your board's push buttons.
5. Generate bitstream and program the board.

---

## Media

- 🗺️ **RTL Architecture Diagram:** `docs/architecture.png`
- 📈 **Simulation Waveform:** `docs/waveform.png`
- 📹 **Gameplay Video:** `media/gameplay_demo.mp4`

---

## License

MIT License

Copyright (c) 2026 Ansh_Foughat

Permission is hereby granted, free of charge, to any person obtaining a copy of this
software and associated documentation files (the "Software"), to deal in the Software
without restriction, including without limitation the rights to use, copy, modify, merge,
publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons
to whom the Software is furnished to do so.

The above copyright notice and this permission notice shall be included in all copies or
substantial portions of the Software.
