; Ultra-Small Operating System - USOS version 1.1.0
; Boot Loader
; Released into the public domain under CC0

org 0x7c00
use16

jmp start
nop
db 'USOS'
db ' Public Domain Software'

start:

cli
xor ax, ax
mov ds, ax
mov es, ax
mov ss, ax
mov sp, 0xFFFF
sti

mov ax,0002h
int 10h

mov ah,0x0e
mov al,'U'
int 10h
mov al,'S'
int 10h
mov al,'O'
int 10h
mov al,'S'
int 10h

load_kernel:

mov ax,0000h
mov es,ax
mov bx,1000h
mov ch,0
mov cl,02h
mov dh,0
mov al,01h
mov ah,02h
int 13h
jc error
jmp 0000:1000h

error:

mov ah,0x0e
mov al,0x0A
int 10h
mov al,0x0D
int 10h
mov al,'E'
int 10h
mov al,'!'
int 10h
mov ah,10h
int 16h
jmp rst

rst:
mov ax,0002h
int 10h
int 19h

times 510 - ($ - $$) db 0
db 0x55,0xAA