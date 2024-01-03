data segment
msg1 db 13,10, "Enter string 1 $"
msg2 db 13,10,"Enter string 2 $"
not_found db 13,10,"String not found $"
found db 13,10,"String found $"
str1 db 30 dup("$")
str2 db 30 dup("$")
data ends

code segment
assume ds:data,cs:code

print_string proc
	mov ah,09h
	int 21h
	ret
print_string endp

input_string proc
input_loop:
	mov ah,01h
	int 21h
	cmp al,13
	je exit_input
	mov [si],al
	inc si
	jmp input_loop
exit_input:
	ret
input_string endp

start:
mov ax,data
mov ds,ax

lea dx,msg1
call print_string

lea si,str1
call input_string

lea dx,msg2
call print_string

lea si,str2
call input_string

lea si,str1
lea di,str2

compare_string:
	mov al,[si]
	cmp al,[di]
	je equal_char
	inc si
	cmp byte ptr [si],"$"
	je string_not_found
	jmp compare_string
	

equal_char:
	inc si
	inc di
	cmp byte ptr[di], "$"
	je string_found
	jmp compare_string

string_found:
	lea dx,found
	call print_string
	jmp end_prgm

string_not_found:
	lea dx,not_found
	call print_string
	jmp end_prgm

;end
end_prgm:
	mov ah,4ch
	int 21h

code ends
end start
