data segment
msg1 db 13,10,"Enter number 1: $"
msg2 db 13,10,"Enter number 2: $"
msg3 db 13,10,"Result is $"
data ends

code segment
assume ds:data,cs:code

input_num proc
    mov bx,0000h
    input_loop:
        mov ah,01h
        int 21h
        cmp al,13
        je exit_input
        sub al,'0'
        mov cl,al
        mov ax,10
        mul bl
        mov bl,al
        add bl,cl
        jmp input_loop
    exit_input:
        ret
        input_num endp

print_value proc
    mov cx, 0
    mov dx, 0

print_loop:
    cmp ax, 0
    je exit_print

    mov bx, 10
    div bx
    push dx
    inc cx
    xor dx, dx
    jmp print_loop

exit_print:
    cmp cx, 0
    je done_printing

    print1:
        pop dx
        add dl, '0'
        mov ah, 02
        int 21h
        dec cx
        jnz print1

done_printing:
    ret
    print_value endp

start:
mov ax,data
mov ds,ax

call input_num
mov ax,bx
mul bx
call print_value


mov ah,4ch
int 21h

code ends
end start
