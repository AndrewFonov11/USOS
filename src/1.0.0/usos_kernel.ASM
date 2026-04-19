; Ultra-Small Operating System - USOS version 1.0.0
; Kernel
; Released into the public domain under CC0

use16

cmd:
xor si,si
mov ah,0x0e
mov al,0x0A
int 10h
mov al,0x0D
int 10h

mov ah,0x0e
mov al,' '
int 10h
mov al,'%'
int 10h
call inpt
cmp si,'r'
jz rst
cmp si,'v'
jz ver
cmp si,'l'
jz ld
cmp si,'d'
jz dss
cmp si,'c'
jz cls
cmp si,'t'
jz type
mov ah,0x0e
mov al,0x0A
int 10h
mov al,0x0D
int 10h
mov ah,0x0e
mov al,'E'
int 10h
mov al,'C'
int 10h
jmp cmd

inpt:
xor ax, ax
int 16h
mov ah,0x0e
int 10h
cmp al,0Dh
jz end_i
movzx si,al
jmp inpt
end_i:
ret

ld:
mov ah,0x0e
mov al,0x0A
int 10h
mov al,0x0D
int 10h
mov al,'L'
int 10h
mov al,'o'
int 10h
mov al,'a'
int 10h
mov al,'d'
int 10h
mov al,':'
int 10h

xor ax, ax
int 16h
mov ah,0x0e
int 10h
cmp al,'h'
jz hdd
sub al,0x30

mov dl,al
jmp next
hdd:
mov dl,80h
jmp next

next:
mov ah,0x0e
mov al,'s'
int 10h
mov al,':'
int 10h
mov ah,10h
int 16h

mov cl,al

mov ax,0000h
mov es,ax
mov bx,4000h
mov ch,0
mov dh,0
mov al,01h
mov ah,02h
int 13h
jc error
jmp 0000:4000h

dss:
mov ah,0x0e
mov al,0x0A
int 10h
mov al,0x0D
int 10h
mov al,'D'
int 10h

xor ax, ax
int 16h
mov ah,0x0e
int 10h
cmp al,'h'
jz d_hdd
sub al,0x30

mov dl,al
jmp n_d
d_hdd:
mov dl,80h

n_d:

mov ax,0000h
mov es,ax
mov bx,2000h
mov ch,0
mov cl,01h
mov dh,0
mov al,01h
mov ah,02h
int 13h
jc error
mov ah,0x0e
mov al,'G'
int 10h
jmp cmd

ver:
mov ah,0x0e
mov al,0x0A
int 10h
mov al,0x0D
int 10h
mov al,'U'
int 10h
mov al,'S'
int 10h
mov al,'O'
int 10h
mov al,'S'
int 10h
mov al,0x0A
int 10h
mov al,0x0D
int 10h
mov al,'1'
int 10h
mov al,'.'
int 10h
mov al,'0'
int 10h
mov al,'.'
int 10h
mov al,'0'
int 10h
mov al,0x0A
int 10h
mov al,0x0D
int 10h
mov al,'C'
int 10h
mov al,'C'
int 10h
mov al,'0'
int 10h
jmp cmd

cls:
mov ax,0002h
int 10h
jmp cmd

type:

mov ah,0x0e
mov al,0x0A
int 10h
mov al,0x0D
int 10h
mov al,'T'
int 10h
mov al,'y'
int 10h
mov al,'p'
int 10h
mov al,'e'
int 10h
mov al,':'
int 10h

xor ax, ax
int 16h
mov ah,0x0e
int 10h
cmp al,'h'
jz hdd_t
sub al,0x30

mov dl,al
jmp next_t
hdd_t:
mov dl,80h
jmp next_t

next_t:
mov ah,0x0e
mov al,'s'
int 10h
mov al,':'
int 10h
mov ah,10h
int 16h

mov cl,al

mov bx,3000h
mov ax,0000h
mov es,ax
mov ch,0
mov dh,0
mov al,01h
mov ah,02h
int 13h
jc error
mov ah,0x0e
mov al,0x0A
int 10h
mov al,0x0D
int 10h
xor si,si
mov si,bx
mov di,0
jmp ptd
ptd:
lodsb
mov ah,0x0e
int 10h
inc di
cmp di,0200h
jz cmd
jmp ptd

error:
mov al,0x0A
int 10h
mov al,0x0D
int 10h
mov ah,0x0e
mov al,'E'
int 10h
mov ah,10h
int 16h
jmp rst

rst:
mov ax,0002h
int 10h
int 19h

jmp $