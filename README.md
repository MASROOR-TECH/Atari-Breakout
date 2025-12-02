# Brick Breaker – Classic Arcade Game in Assembly Language (NASM)

## Project Overview

*Brick Breaker* is a fully functional, classic arcade-style brick-breaking game written entirely in *16-bit x86 Assembly Language* using *NASM* for *DOS* (runs perfectly on DOSBox or real vintage hardware).

The game features:
- Smooth ball physics with 8-directional movement (45°, 90°, 135°, etc.)
- Paddle controlled by *Left & Right Arrow Keys* (press & hold)
- Multi-hit colored bricks (Red → Orange → Yellow → Green → Destroyed)
- 3 lives system
- Score tracking
- Sound effects using PC speaker (different tones for paddle hit, brick hits, game over)
- Beautiful ASCII-art welcome, win, and lose screens
- Game rules page
- Real-time collision detection with walls, paddle, corners, and bricks
- Keyboard interrupt hooking (IRQ1 – keyboard ISR) for responsive controls
- Clean exit with Esc key

This project was developed as a *two-member team effort* for a low-level systems/assembly programming course.

## Features

- Real-time keyboard input via *IRQ1 hooking* (no polling delays)
- Precise 8-direction ball movement using angle-based system
- Smart bounce physics:
  - Normal reflection on walls
  - 180° flip on corners
  - Directional bounce based on paddle hit position (left/middle/right → 135°/90°/45°)
- Multi-layered bricks with color progression on hits
- Lives system (3 hearts displayed)
- Score increases with every brick hit
- Sound feedback for all major events
- Multiple beautifully designed screens:
  - Welcome screen with "PLAY" in big letters
  - Rules page
  - Win screen ("YOU WIN")
  - Lose screen ("YOU LOSE")
- Press *Esc* anytime to exit
