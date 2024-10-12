; Drawing on the screen using interruptions:
;	- Set Video Mode: basically enters the video Mode
;	- Write Pixel: literally writes a pixel

; Cleaning the registers
xor ax, ax
mov es, ax
mov ds, ax
mov ss, ax


; ah is already with 0 (Set Video Mode Code)
mov al, 0x13		; Defiined Mode
int 0x10			; Calling the interruption

mov ah, 0x0c		; Write Pixel Code
mov al, 0x0f		; Pixel color (write)
mov cx, 0x7c		; Horizontal position of the Pixel
mov dx, 0x45		; Vertical position of the Pixel
mov bh, 0			; Page
int 0x10

mov cx, 0x83
mov dx, 0x45
int 0x10

mov cx, 0x8F
mov dx, 0x45
int 0x10


jmp $


; Filling the program to be 512B
times 510 - ($ - $$) db 0
dw 0xaa55