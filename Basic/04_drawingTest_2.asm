; Drawing a box on the screen using interruptions:
;	- Set Video Mode: basically enters the video Mode
;	- Write Pixel: literally writes a pixel

; Cleaning the registers
xor ax, ax
mov es, ax
mov ds, ax
mov ss, ax

; ah is already with 0 (Set Video Mode Code)
mov al, 0x13
int 0x10

mov ah, 0x0c	; Write pixel Code
mov al, 0x0f	; Pixel color
mov bh, 0x00	; Page number

; Coordinates (0,0)
xor cx, cx		; X Coordinate
xor dx, dx		; Y Coordinate


; Important note, if a column number is higher than the size of columns, it jumps to the next line


; Builds the top Line in X axis
boxLoopTopX:
int 0x10
inc cx
cmp cx, 319			; Checks if cx is lower than 319 (selected size-mode)
jl boxLoopTopX		; If the previous condition is true, jumps to boxLoopTopX

mov al, 0x2f		; Changes the color

; Builds the left line in Y axis
boxLoopLeftY:
int 0x10
inc dx		
cmp dx, 200			; Checks if dx is lower than 200 (selected size-mode)
jl boxLoopLeftY		; If the previous condition is true, jumps to boxLoopLeftY

mov al, 0x4f		; Changes the color

; Builds the bottom Line in X axis
xor cx, cx			; Goes to the begging of the line
mov dx, 199			; Goes to the last row

boxLoopBottomX:
int 0x10
inc cx
cmp cx, 319			; Checks if cx is lower than 319 (selected size-mode)
jl boxLoopBottomX	; If the previous condition is true, jumps to boxLoopBottomX

mov al, 0xcf		; Changes the color

; Builds the right line in Y axis
xor cx, cx			; Goes to the first position of the line
xor dx, dx			; Goes to the first line
boxLoopRightY:
int 0x10
inc dx		
cmp dx, 200			; Checks if dx is lower than 200 (selected size-mode)
jl boxLoopRightY	; If the previous condition is true, jumps to boxLoopRightY


jmp $

; Filling the program to be 512B
times 510 - ($ - $$) db 0
dw 0xaa55