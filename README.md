# 🎮 Atari Breakout – x86 Assembly (COAL Lab)

A fully functional recreation of the classic **Atari Breakout Arcade Game**, written entirely in **8086 Assembly Language** using BIOS/DOS interrupts.  
This program runs in text mode and simulates ball physics, paddle control, brick breaking, scoring, sound effects, and real-time keyboard interaction.

---

## 📌 Features

### 🧱 **Game Layout**
- Four rows of character-based bricks at the top  
- Paddle at the bottom using a unique color/character  
- Ball rendered as a single text-cell  
- Text-mode visuals using `INT 10h`

### 🎮 **Controls**
- **Left Arrow** → Move paddle left  
- **Right Arrow** → Move paddle right  
- **Enter** → Start game from welcome screen  
- **Esc** → Exit  

Keyboard input handled via `INT 16h`.

---

## ⚙️ Gameplay Mechanics

### 🔵 **Ball Physics**
- Moves at **45° and 90°** angles  
- Bounces off walls, paddle, and bricks  
- Breaks bricks on collision  
- Automatically updates ball direction based on impact point  

### 🧱 **Brick Collision**
- Brick disappears when hit  
- Score increases dynamically  
- Optional colored bricks for varied points

### ❤️ **Lives & Score**
- Minimum **3 lives**  
- Lose a life when the ball touches the bottom  
- Game ends on:
  - All bricks destroyed (**WIN**)  
  - Lives reach zero (**GAME OVER**)  
- Score and lives displayed throughout gameplay  

### 🔊 **Sound Effects**
Produced using system interrupts:

- Paddle hit  
- Brick break  
- Life lost  

---

## 🖥️ Welcome Screen
On launch, a user-friendly welcome interface displays:

- Title  
- Rules  
- Score system  
- Controls  
- Lives info  
- Options:  
  - **Press Enter → Start**  
  - **Press Esc → Quit**

---

## 🛠️ Technical Details

### **Interrupts Used**
| Function | Interrupt | Purpose |
|---------|-----------|---------|
| Keyboard input | `INT 16h` | Real-time paddle movement |
| System services | `INT 21h` | Delay, file I/O |
| Timing / beep | `INT 1Ah` / PC Speaker | Audio and timing |

### **Assembly Concepts Applied**
- Direct memory access to video buffer  
- Keyboard interrupt-driven movement  
- Collision detection algorithms  
- Game loop handling  
- Condition-based logic flow  
- Real-time screen refresh  
- PC speaker sound control  

---

## 📁 File Structure

