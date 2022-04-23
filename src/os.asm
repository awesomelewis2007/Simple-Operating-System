bits 16
org 0x7c00

jmp main

Message1 db "This is a simple operating system made in assembly", 0x0
AnyKey db "Press any key to Shutdown", 0x0

Println:
	lodsb
	or al, al
	jz complete
	mov ah, 0x0e
	int 0x10
	jmp Println
complete:
	call PrintNwl

PrintNwl:
	mov al, 0
	stosb
	mov ah, 0x0E
	mov al, 0x0D
	int 0x10
	mov al, 0x0A
	int 0x10
		ret
setColors:
	;This sets the screen colours
    mov ah, 0x06    
    xor cx, cx      
    mov dx, 0x1AAA  
    mov bh, 0x0A ; This sets the colour
    int 10H         
    ret             

Shutdown:
	; This tells the system to shutdown
    mov ax, 0x1000
    mov ax, ss
    mov sp, 0xf000
    mov ax, 0x5307
    mov bx, 0x0001
    mov cx, 0x0003
    int 0x15
	ret

Reboot:
	; This tells the system to reboot
    db 0x0ea 
    dw 0x0000 
    dw 0xffff 	
Boot:
	; This is the boot script
	call setColors
    mov si, Message1
    call Println
	mov si, AnyKey
	call Println
	call GetPressedKey
	call Shutdown
	;call Reboot
GetPressedKey:
	; This waits till a key is pressed
	mov ah, 0
	int 0x16
	ret

main:
	cli
	int 10h - 0x0E
	mov ax,cs
	mov ds,ax
	mov es,ax
	mov ss,ax
	sti
	call Boot
	times 510 - ($-$$) db 0
	dw 0xAA55