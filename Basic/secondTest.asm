; Cleaning the registers
xor ax, ax
mov ds, ax
mov es, ax
mov ss, ax

; Writing the String itself
mov ah, 0x13		; Write Character String code
mov al, 0x01		; Subservice
mov bh, 0x00		; Selects the page
mov bl, 0x0a		; Selects the color
mov cx, 0x16		; Size of the defined string below
mov dh, 0x0a		; Line position
mov dl, 0x0a		; Column position
mov bp, sentence	; Offset address of the variable
add bp, 0x7c00		; Real address of the variable

int 0x10			; Call the interruption

mov ah, 0x13
mov al, 0x01
mov bh, 0x00
mov bl, 0x0a
mov cx, 0x15
mov dh, 0x0b
mov dl, 0x09
mov bp, sentence2
add bp, 0x7c00

int 0x10

; Stop to not enter the data part
jmp $

; 	Defines the sentence to be written, considering a variable using byte size of the memory
sentence: db 'My name is Fernando!', 0x0a, 0x0d
sentence2: db 'My name is Rossi!'

times 510 - ($ - $$) db 0

dw 0xAA55