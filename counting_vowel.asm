data segment
buffer db 30 dup("$")
oca db 0h
oce db 0h
oci db 0h
oco db 0h
ocu db 0h
data ends

code segment
assume cs:code,ds:data

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


print_number proc
    mov al,bh
    and al,00F0h
    mov cl,04h
    ror al,cl
    add al,30h
    cmp al,39h
    jle no_convertion1
    add al,07h
    no_convertion1:
    mov dl,al
    mov ah,02h
    int 21h

    mov al,bh
    and al,000Fh
    add al,30h
    cmp al,39h
    jle no_convertion2
    add al,07h
    no_convertion2:
    mov dl,al
    mov ah,02h
    int 21h

    ret
    print_number endp

start:
mov ax,data
mov ds,ax

lea si,buffer
call input_string

lea si,buffer

check_loop:
cmp byte ptr[si],'$'
je exit_loop

cmp byte ptr[si],'a'
je found_a

cmp byte ptr[si],'e'
je found_e

cmp byte ptr[si],'i'
je found_i

cmp byte ptr[si],'o'
je found_o

cmp byte ptr[si],'u'
je found_u

inc si
jmp check_loop

exit_loop:
mov bh,oca
call print_number
mov bh,oce
call print_number
mov bh,oci
call print_number
mov bh,oco
call print_number
mov bh,ocu
call print_number

mov ah,4ch
int 21h

found_a:
inc oca
inc si
jmp check_loop

found_e:
inc oce
inc si
jmp check_loop

found_i:
inc oci
inc si
jmp check_loop

found_o:
inc oco
inc si
jmp check_loop

found_u:
inc ocu
inc si
jmp check_loop

code ends
end start
