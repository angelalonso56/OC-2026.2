%include "../../lib/pc_io.inc"   ; incluir declaraciones de procedimiento externos

section .text
    global _start         ; referencia para inicio de programa
    
_start:   
    ; --- IMPRIMIR CADENA COMPLETA ---
    mov edx, msg          ; edx = dirección de la cadena msg
    call puts             ; imprime cadena

    mov byte[msg],'Z'
    mov edx, msg
    call puts

    mov ebx, msg
    add ebx, 23           
    mov byte[ebx], 'X'
    call puts

    mov byte[msg+26],'@'
    call puts


    mov esi, 25
    mov byte [edx + esi],'Z'
    call puts

    mov byte [edx + esi - 10],'P'
    call puts

    mov esi, 2
    add edx, 15
    mov byte [edx + (esi*2)],'%'
    call puts

    ; --- FIN DE PROGRAMA ---
    mov eax, 1            ; Llamada sys_exit
	xor ebx, ebx          ; return 0
    int 0x80              ; Fin de programa

section .data
    msg db 'abcdefghijklmnopqrstuvwxyz0123456789', 0xa, 0
    salto db 0xa