xor ax, ax
mov es, ax
mov ds, ax
; mov cs, ax

; ax is already cleaned so does not need to be set to 0 (the code for Set Video Mode interruption is 0)
mov al, 0x13
int 0x10

; Video Memory starts on 0xA0000
xor di, di
mov ax, 0xA000
mov es, ax

mov cx, 0x140 ;mov to cs 320
mov ax, 0x0000

paintingLoop:
mov [es:di], al
inc di
inc al
add ax, 0x0101
dec cx
cmp cx, 0
jne paintingLoop
jmp $

times 510 - ($ - $$) db 0

dw 0xAA55