; Parts of the CV bootloader:
;; 1. Define the video mode
;; 2. Draw the white background
;; 3. Write the "Hire me! :)" text
;; 4. Draw my picture

; It will be done with 3 calls for each part, except for the defining video mode


; Cleaning the registers
xor ax, ax
mov ds, ax
mov es, ax
mov ss, ax

;----------------------------------------------------------------------------------------

; 1. Define the video mode
;; 'ah' is already cleaned, so there's no need of setting 0 (the interruption code is 0x00)
;; Mode number = 13h, Text box = 40x25, Pixel Resolution = 320x200, Colors = 256/256x, Pages = 1, Buffer Address A000, System Adapter = VGA  MCGA

;; Video mode code
mov al, 0x13
int 0x10


; 2. Draw the white background - Call
call DrawWhiteBackground


; 3. Write the "Hire me! :)" text - Call
call WriteText


; 4. Draw my picture - Call
;call DrawPicture

; Eternal loop
jmp $

;----------------------------------------------------------------------------------------

DrawWhiteBackground:
push bp
mov bp, sp
pusha	; Stack all the registers in the Stack

; Writing pixel (interruption 10h, 0Ch)


xor cx, cx				; Horizontal position - starting at 0
mov dx, 0x1e			; Vertical position - starting at 0x1E, so there's space to write the text above it
mov ah, 0x0c			; Interruption code
mov al, 0x0f			; Pixel color - white
restart:
int 0x10
inc cx
cmp cx, 0x140 			; Compare if cx is already in the maximum value (320 in decimal)
je resetHorizontal		; If it's already reached the limit, reset the horizontal position
jmp restart				; If it hasn't reached, keep painting


endCode:
;; Setting back registers and stack
popa
mov sp, bp
pop bp
ret


; -------------


resetHorizontal:
;; Reset cx register (horizontal value) and go one line below
xor cx, cx
inc dx
cmp dx, 0xC8			; Compare to check if the vertical limit has been already reached (200 in decimal)
je endCode					; If it is at the vertical limit, end it
jmp restart


; -------------


WriteText:
push bp
mov bp, sp
pusha	; Stack all the registers in the Stack

; Write Character String (interruption 10h, 13h)
mov ah, 0x13
mov al, 0x01		; Subservice. The selected one is "Assign all characters the attribute in BL, do not update cursor"
xor bx, bx			; Attribute
mov bl, 0x0f
mov cx, 0x0b		; Length of the string
mov dh, 0x1c		; Row where the string will be printed
mov dl, 0x07		; Column that the text will be written
mov bp, message		; POINTER to string to write
add bp, 0x7c00		; As the pointer above is the offset, this needs to be added
int 0x10

;; Setting back registers and stack
popa
mov sp, bp
pop bp
ret



;----------------------------------------------------------------------------------------

; Variables
message: db 'Hire me! :)'




; Ending the file
times (510 - ($ - $$)) db 0x00
dw 0xAA55