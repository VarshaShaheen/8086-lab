data segment
    num db ?
data ends

code segment
    assume cs:code, ds:data

    input_num proc
        mov ah, 01
        int 21h
        mov bl, al

        mov ah, 01
        int 21h
        mov bh, al

        mov ah, 01
        int 21h
        mov cl, al

        mov ah, 01
        int 21h
        mov ch, al

        sub bl, '0'
        sub bh, '0'
        sub cl, '0'
        sub ch, '0'

        mov ax, 10
        mul bl
        mov bl, al
        add bl, bh

        mov ax, 10
        mul cl
        mov cl, al
        add cl, ch

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
    mov ax, data
    mov ds, ax

    call input_num
    mov al,cl
    add bl,al
    call print_value

    mov ah, 4ch
    int 21h

code ends
end start
