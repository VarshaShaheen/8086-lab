data segment
msg1 db 13,10, "Enter first string $"
msg2 db 13,10, "Enter second string $"
msg3 db 13,10,"The concatenated string is: $"
newline db 13,10
buffer db 30 dup(8)
data ends

code segment
assume ds:data, cs:code

print_string proc
mov ah,09h
int 21h
ret
print_string endp

read_char proc
	mov ah,01h
	int 21h
	cmp al,13
	ret
read_char endp

input_string proc
	add si, 29
	mov byte ptr [si], '$'
	dec si

	input:
		call read_char
		je exit_from_input
		mov [si],al
		dec si
		jmp input
	exit_from_input:
		ret
input_string endp

start:
mov ax,data
mov ds,ax

lea dx,msg1
call print_string

lea si,buffer
call input_string

lea dx,buffer
call print_string
	
;exit
mov ah,4ch
int 21h

code ends
end start
