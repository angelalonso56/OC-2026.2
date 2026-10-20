;sudo apt-get update
;sudo apt-get install nasm

%include "../../lib/pc_io.inc"   ; incluir declaraciones de procedimiento externos

section .data
    bskey equ 0x7F
    lencadena equ 255
    ln equ 0x0A
    nline db ln,0
    msg1 db ln,'Entrando: ', 0
    msg2 db ln,'Saliendo: ', 0
    
section .bss
    cadena resb lencadena
    numero resb 4
    resultado resb 4 
    saver resb 4

section .text
    global _start         ; referencia para inicio de programa
    
_start:   
    mov edx, msg1        
    call puts   
    xor ebx,ebx

    .for:
    call captura    
    cmp al,ln
    jne .for
    mov byte [cadena + ebx], 0

        call contar
        call extraer
        call atoi
        add dword [resultado], 123
        call itoa


    mov edx, msg2
    call puts             
    mov edx, cadena
    call puts
    
    jmp .fin_programa  
    
    
    
    ; --- FIN DE PROGRAMA ---
    .fin_programa: 
        mov edx, nline    
        call puts     
        call puts     
        mov eax, 1            ; Llamada sys_exit
	    xor ebx, ebx          ; return 0
        int 0x80              ; Fin de programa

itoa: xor ecx,ecx 
      push ebx
      mov ebx,1
      mov edi,[saver]
      cmp dword [resultado], 0
      jl .signartwo
      
    .forit: cmp edi, 0
            je .endit
            mov ebx,1
            jmp .potencia
    .continue: 
            xor edx,edx
            mov eax,[resultado]
            div ebx
            mov [resultado], edx
            add eax,48
            mov [cadena + ecx],al
            inc ecx
            dec edi
            jmp .forit


.endit: mov byte [cadena + ecx],0
        pop ebx
        ret

.potencia: push esi
           mov esi,1
           .forpot: cmp esi,edi
                    je .endpot
                    imul ebx,10
                    inc esi
                    jmp .forpot
.endpot: pop esi
         jmp .continue



.signartwo: mov byte [cadena],'-'
inc ecx
neg dword [resultado]
jmp .forit




atoi:
    xor eax,eax
    xor edx,edx
    mov [saver],edi

    .foratoi: cmp edi,0
    je .signar

    xor ecx,ecx
    mov cl, [numero + edx]
    sub cl, 48
    imul eax, 10
    add eax,ecx
    inc edx 
    dec edi
    jmp .foratoi
.signar:
        cmp esi,0
        je .endatoi
        neg eax
.endatoi:        
        mov [resultado],eax 
        ret

extraer: 
        xor edx,edx

        .forextraer: cmp edi,edx
        je .endext
        mov al,[cadena + edx + esi]
        mov [numero + edx], al
        inc edx
        jmp .forextraer
    .endext:
    mov byte [numero+edx], 0
     ret


contar:
        xor edi,edi
        xor esi,esi
        xor edx,edx
        .for: cmp edi, 5
              je .invalido
              mov byte cl,[cadena + edx]
              cmp cl, 0
              je .invalido
              cmp cl, '-'
              jne .unsigned
              cmp edx,0
              jne .invalido
              mov esi,1
              inc edx
              jmp .for
        .unsigned: 
              cmp cl, '0'
              jb .invalido  
              cmp cl, '9'
              ja .invalido
              inc edi
              inc edx
              jmp .for
        .invalido: ret
        

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



