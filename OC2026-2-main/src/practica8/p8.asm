extern canonical_off
extern canonical_on

section .data
    bskey equ 0x7F
    lencadena equ 255
    ln equ 0x0A
    nline db ln,0
    msg1 db ln,'Captura: ', 0
    msg2 db ln,'Cadena: ', 0

section .bss
    cadena resb lencadena

section .text
    global _start         ; referencia para inicio de programa
   
    
_start:   
    ; --- IMPRIMIR CADENA  ---
    mov edx, msg1        
    call puts   
    xor ebx,ebx

    .for:
    call captura    
    cmp al,ln
    jne .for

    mov byte [cadena + ebx], 0

    mov edx, msg2
    call puts             
    mov edx, cadena
    call puts
    
    mov esi, cadena
    call minuscula
    mov edx,cadena
    call puts

    mov esi, cadena
    call mayuscula
    mov edx,cadena
    call puts

    jmp .fin_programa  

    ; --- FIN DE PROGRAMA ---
    .fin_programa: 
        mov edx, nline    
        call puts     
        call puts     
        mov eax, 1            ; Llamada sys_exit
	    xor ebx, ebx          ; return 0
        int 0x80       ; Fin de programa


    putchar:
        push ebx
        push ecx
        push edx
        push eax  

        mov eax, 4 
        mov ebx, 1
        mov ecx, esp
        mov edx, 1 
        int 0x80 

        pop eax        
        pop edx
        pop ecx
        pop ebx
        ret
        

    puts:
        push edi
        xor edi,edi
        .phor: mov al, [edx + edi]
        cmp al, 0
        je .putsend

        call putchar
        inc edi
        jmp .phor
    .putsend:
        pop edi
        ret 

    getch:
        push ebx
        push ecx
        push edx
        call canonical_off
        push eax
        mov eax, 3 
        mov ebx, 0
        mov ecx, esp
        mov edx, 1 
        int 0x80 
        pop eax
        push eax
        call canonical_on
        pop eax
        pop edx
        pop ecx
        pop ebx
        ret


    getche:
        call getch
        call putchar
        ret

        minuscula:
        push esi
        push eax
.forl: mov al, [esi]
        cmp al, 0
        je .finl
        cmp al, 'A'
        jb .sigl
        cmp al, 'Z'
        ja .sigl
        add al, 32
        mov [esi], al
.sigl:   inc esi
        jmp .forl
.finl:  pop eax
        pop esi
        ret

mayuscula:
        push esi
        push eax
.foru: mov al, [esi]
        cmp al, 0
        je .finu
        cmp al, 'a'
        jb .sigu
        cmp al, 'z'
        ja .sigu
        sub al, 32
        mov [esi], al
.sigu:  inc esi
        jmp .foru
.finu:  pop eax
        pop esi
        ret

    captura:
            call getch
            cmp al, bskey
            je .atras

            mov [cadena + ebx], al
            inc ebx
    .sig:   call putchar
            ret

    .atras: cmp ebx,0
    je .end
    dec ebx
    call borrar
    .end: ret

    borrar:
        mov al,0x8
        call putchar    
        mov al,' '
        call putchar
        mov al,0x8
        call putchar   
        ret 