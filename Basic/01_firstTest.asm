; Printing an "A" on the screen. 
;	AH -> 8 highest AX bits, the value for this interruption is 0x0e
;	AL -> 8 lowest AX bits, the ASCII value of the letter the value
;	BL -> 8 lowest BX bits, the value of the color - In the TTY mode does not make any difference
;	BH -> 8 highest BX bits, this is to display the page number
;	The "Write Character in Teletype (TTY) Mode" has the interruption number 0x10
mov ah, 0x0e
mov al, 0x41
mov bl, 0x07
mov bh, 0
int 0x10


; Do not need to write the other instructions because they are "default"
mov al, 'B'
int 0x10

mov al, 'C'
int 0x10

; Bootloader must have 512 bytes.
;	(512-2) -> Deduct the size of the current instruction
;	($ - $$) -> Deduct the size of the code from the current possition, subtracted from the beginning of the program
; The times funtion fills the space left with 0
times ((512-2) - ($ - $$)) db 0x00

; "Defining Word" -> defines a "variable" from the size of 2 bytes
dw 0xAA55