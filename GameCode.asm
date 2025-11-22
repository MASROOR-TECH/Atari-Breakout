org 0x100
jmp main
paddlePos: dw 3760
ballPos: dw 3604,3604
ballAngle: dw 90 ;135 90 45 225 ,270 ,315
ballMovementUpwardDownWard: dw 1
oldIsr: dd 0
clrscr:
    push bp
    mov bp,sp
    push ax
    push es
    push di
    push cx
    xor di,di
    mov ax,0xb800
    mov es,ax
    mov ax,0x0720
    mov cx,2000
    cld
    rep stosw
    pop cx
    pop di
    pop es
    pop ax
    pop bp
    ret 
BasicStructure:
    push bp
    mov bp,sp
    pusha
    mov ax,0xb800
    mov es,ax
    ;print boundary
    mov ax,0x07DB
    mov di,0
    mov cx,80
    cld
    rep stosw
    ;print side wals
    mov di,158
    mov bx,24
againLoopForPrint:
    mov cx,2
    cld 
    rep stosw
    add di,156
    dec bx
    cmp bx,0
    jne againLoopForPrint
    ;print last row 
    mov di,3840
    mov cx,80
    cld
    rep stosw
    popa
    pop bp
    ret
erasePaddle:
    push bp
    mov bp, sp
    push ax
    push es
    push cx
    push di

    mov ax, 0xb800
    mov es, ax
    mov ax, 0x0720
    mov di, [paddlePos]
    mov cx, 6

    paddleLoop:
    sub di, 2
    mov [es:di], ax
    loop paddleLoop
    mov [paddlePos], di

    pop di
    pop cx
    pop es
    pop ax
    pop bp
    ret
printPaddle:
    push bp
    mov bp, sp
    push ax
    push es
    push cx
    push di

    mov ax, 0xb800
    mov es, ax
    mov ax, 0x07DF
    mov di, [paddlePos]
    mov cx, 6

    cld
    rep stosw
    mov [paddlePos], di

    pop di
    pop cx
    pop es
    pop ax
    pop bp
    ret
CheckBoundaryforPaddle:
    push bp
    mov bp,sp
    push di
    mov di,[paddlePos]
    cmp di,3686
    jae newCmp
    add word[paddlePos],4
    jmp exit
    newCmp:
    cmp di,3820
    jle exit
    sub word[paddlePos],4
    exit:
    pop di
    pop bp
    ret

paddleMove: ;
    pusha
    push ds
    push es
    mov ax,0xb800
    mov es,ax
    in al,0x60
    cmp al, 4Bh        ; Left Arrow
    je  key_left

    cmp al, 4Dh        ; Right Arrow
    je  key_right
    jne nomatch
key_left:
    call erasePaddle
    call CheckBoundaryforPaddle
    mov di, [paddlePos]
    sub di, 4
    mov [paddlePos], di
    call printPaddle
    jmp nomatch

key_right:
    call erasePaddle
    call CheckBoundaryforPaddle
    mov di, [paddlePos]
    add di, 4
    mov [paddlePos], di
    call printPaddle
    jmp nomatch
    nomatch: 
    pop es
    pop ds
    popa
    jmp far [oldIsr]
    

readKeyBoard:
    push bp
    mov bp,sp
    xor ax,ax
    mov es,ax
    mov ax,[es:9*4]
    mov word[oldIsr],ax
    mov ax,[es:9*4+2]
    mov word[oldIsr+2],ax
    cli
    mov word[es:9*4],paddleMove
    mov [es:9*4+2],cs
    sti
    pop bp
    ret
eraseBall:
    push bp
    mov bp,sp
    push ax
    push es
    push di
    mov ax,0xb800
    mov es,ax
    mov di,[ballPos]
    mov ax,0x0720
    mov [es:di],ax
    pop di
    pop es
    pop ax
    pop bp
    ret

PrintBall:
    push bp
    mov bp,sp
    push ax
    push es
    push di
    mov ax,0xb800
    mov es,ax
    mov di,[ballPos]
    mov ax,0x07DF
    mov [es:di],ax
    pop di
    pop es
    pop ax
    pop bp
    ret
UpwardDownWardPrintBall:
    push bp
    mov bp,sp
    cmp word[ballAngle],90
    jne nextCmp45
    sub word[ballPos],160
    jmp exit1
    nextCmp45:
    cmp word[ballAngle],45
    jne newCmp135
    sub word[ballPos],156
    jmp exit1
    newCmp135:
    cmp word[ballAngle],135
    jne nextCmpfor270
    sub word[ballPos],164
    jmp exit1
    nextCmpfor270:
    cmp word[ballAngle],270
    jne nextcmp225
    add word[ballPos],160
    jmp exit1
    nextcmp225:
    cmp word[ballAngle],225
    jne nextCmp315
    add word[ballPos],156
    jmp exit1
    nextCmp315:
    cmp word[ballAngle],315
    jne exit1
    add word[ballPos],164
    exit1:
    pop bp
    ret
ballAngleUpdate:
    push bp
    mov bp,sp
    cmp word[ballAngle],90
    jne nextCmp451
    mov word[ballPos],270
    jmp exit2
    nextCmp451:
    cmp word[ballAngle],45
    jne newCmp1351
    mov word[ballPos],315
    jmp exit2
    newCmp1351:
    cmp word[ballAngle],135
    jne nextCmpfor2701
    mov word[ballPos],225
    jmp exit2
    nextCmpfor2701:
    cmp word[ballAngle],270
    jne nextcmp2251
    mov word[ballPos],90
    jmp exit2
    nextcmp2251:
    cmp word[ballAngle],225
    jne nextCmp3151
    mov word[ballPos],135
    jmp exit2
    nextCmp3151:
    cmp word[ballAngle],315
    jne exit2
    mov word[ballPos],45
    exit2:
    pop bp
    ret
    
CollisionCheckForBall:
    push bp
    mov bp,sp
    puaha
    mov ax,0xb800
    mov es,ax
    mov di,[ballPos]
    cmp di,160
    jae nextCmpcollision1
    ;call ballAngleUpdate
    ;jmp exit3
    nextCmpcollision1:
    mov ax,[ballPos]
    mov bx,10
    div bx
    cmp dl,0
    ;jne nextCmpcollision2
    ;left side wall
    ;jmp exit3
    
    
    escape:

BallMovement:
    push bp
    mov bp,sp
    call eraseBall
    call UpwardDownWardPrintBall
    ;call CollisionCheckForBall
    call PrintBall
    pop bp
    ret
main:
    call clrscr
    call BasicStructure
    call printPaddle
    call PrintBall
    call readKeyBoard
    call BallMovement
excloop: 
    mov ah, 0 ; service 0 – get keystroke
    int 0x16 ; call BIOS keyboard service
    cmp al, 27 ; is the Esc key pressed
jne excloop

mov ax,0x4c00
int 21h
