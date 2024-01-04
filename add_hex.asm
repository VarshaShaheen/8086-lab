data segment
msg1 db 13,10,"Enter number 1: $"
msg2 db 13,10,"Enter number 2: $"
msg3 db 13,10,"Result is $"
data ends

code segment
assume ds:data,cs:code

print_string proc
mov ah,09h
int 21h
ret
print_string endp

print_char proc
	mov al,bh
	and al,00F0h
	mov cl,04h
	ror al,cl
	cmp al,0Ah
	jc print_decimal
	jmp print_hex

print_decimal:
add al,30h
jmp out_char

print_hex:
add al,'A'
sub al,0Ah

out_char:
mov dl,al
mov ah,02
int 21h

mov al,bh
and al,000Fh
cmp al,0Ah
jc print_decimal2
jmp print_hex2

print_decimal2:
add al,30h
jmp out_char2

print_hex2:
add al,'A'
sub al,0Ah

out_char2:
mov dl,al
mov ah,02
int 21h

ret
print_char endp

input_number proc
	mov bx,0000h
	input_loop:
	mov ah,01h
	int 21h
	cmp al,13
	je exit_input
	cmp al,'A'
	jc number_is_decimal
	jmp number_is_hex
number_is_decimal:
	sub al,30h
	jmp convert
number_is_hex:
	sub al,'A'
	add al,0Ah
convert:
	mov dl,al
	mov cl,4h
	rol bx,cl
	and dl,000Fh
	add bl,dl
	jmp input_loop
exit_input:
ret
input_number endp

start:
mov ax,data
mov ds,ax

call input_number
push bx
call input_number
mov dx,bx
pop bx
add bx,dx

print_number:
call print_char
mov bh,bl
call print_char

; exit
mov ah,4ch
int 21h

code ends
end start

code segment
assume ds:data,cs:code

print_string proc
mov ah,09h
int 21h
ret
print_string endp

print_char proc
	mov al,bh
	and al,00F0h
	mov cl,04h
	ror al,cl
	cmp al,0Ah
	jc print_decimal
	jmp print_hex

print_decimal:
add al,30h
jmp out_char

print_hex:
add al,'A'
sub al,0Ah

out_char:
mov dl,al
mov ah,02
int 21h

mov al,bh
and al,000Fh
cmp al,0Ah
jc print_decimal2
jmp print_hex2

print_decimal2:
add al,30h
jmp out_char2

print_hex2:
add al,'A'
sub al,0Ah

out_char2:
mov dl,al
mov ah,02
int 21h

ret
print_char endp

input_number proc
	mov bx,0000h
	input_loop:
	mov ah,01h
	int 21h
	cmp al,13
	je exit_input
	cmp al,'A'
	jc number_is_decimal
	jmp number_is_hex
number_is_decimal:
	sub al,30h
	jmp convert
number_is_hex:
	sub al,'A'
	add al,0Ah
convert:
	mov dl,al
	mov cl,4h
	rol bx,cl
	and dl,000Fh
	add bl,dl
	jmp input_loop
exit_input:
ret
input_number endp

start:
mov ax,data
mov ds,ax

call input_number
push bx
call input_number
mov dx,bx
pop bx
add bx,dx

print_number:
call print_char
mov bh,bl
call print_char

; exit
mov ah,4ch
int 21h

code ends
end start
