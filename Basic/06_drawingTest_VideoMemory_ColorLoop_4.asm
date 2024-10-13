; The objective is to fill a box with all the 256 possible colors 

;; Defines the video mode based on the set video mode interruption
mov ax, 0x13
int 0x10

; Put on the stack and take it out to es
push 0xa000
pop es

; Clean the registrators
xor ax, ax
xor bx, bx
xor cx, cx
xor dx, dx
xor di, di

; Push color to the stack
push ax


; Considering a 320/200 pixels for (divided by 16 because 16^2 is 256, which means the possible number of colors):
;;	Each color on the X axis is: 320/16 = 20 pixels per color
;;	Each color on the Y axis is: 200/16 = 12 pixels per color (192 lines)

;;; Counter: cl
;;;	Number of lines: ch
;;; Squares in y: dh
;;; Squares in x: dl
;;; Video memory: es:di
;;; Color: ax


mainLoop:
mov [es:di], ax
inc di
inc di
inc cl
inc cl
cmp cl, 0x14		; If counter is already 20, change the color
je changeColor
jmp mainLoop


changeColor:
add ax, 0x0101
inc dl
cmp dl, 0x10		; If you already have 16 square, go to the next line
je skipLine
xor cl, cl
jmp mainLoop


skipLine:
inc ch
cmp ch, 0x0c		; If counter is already 12, change the color
je incYSquare
pop ax
push ax				; Takes and put back the color on the stack
xor cl, cl
xor dl, dl
jmp mainLoop


incYSquare:
pop ax
add ax, 0x1010
push ax				; New base color
xor cx, cx			; Cleans the counter and number of lines (same register cx)
xor dl, dl			; Cleans the number of squares in a line
inc dh
cmp dh, 0x10
je endLoop			; If 16 vertical colors are already set
jmp mainLoop


endLoop:
jmp $

times 510 - ($ - $$) db 0
dw 0xA55