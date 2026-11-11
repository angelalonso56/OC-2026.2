%include "../../lib/pc_io.inc"  	

%macro PROTOENTRADA 0
	push ebp
	mov ebp,esp
%endmacro

%macro PROTOSALIDA 0
	mov esp,ebp
	pop ebp
%endmacro

%macro WHILE 4
       
       .%1:
            dec %3
            cmp %3,0
            jle .%4

            call %2
            jmp .%1          
        .%4:
            
%endmacro

%macro FOR 4
    push ecx
    push edx
    mov ecx,%1
    mov edx,%2
    .%4:
        call %3
    loop .%4
    pop edx
    pop ecx
%endmacro

section	.text
	global _startd       ;referencia para inicio de programa
    global _imprimir   
    global _minimo
    global _maximo
    global _sumatoria  
	

_minimo:
        PROTOENTRADA
        sub esp,4
        push ebx
        push ecx
        push edx
        mov ebx,dword [ebp+8] ;arreglo
        mov ecx,dword[ebp+12] ;len
        mov edx,dword [ebx] ;arreglo[0]
        mov dword[ebp-4],edx ;min
        
        WHILE ciclo1,Compararminus,ecx,finminus

        pop edx
        pop ecx
        pop ebx
        mov eax,dword[ebp-4]
        add esp,4
        PROTOSALIDA
        ret





Compararminus:
        mov edx, dword[ebx+ecx*4]
        mov eax, dword[ebp-4]

        cmp edx,eax
        jl .cambio
        jmp .endminus

.cambio: 
        mov dword[ebp-4],edx
        
.endminus: ret


_maximo:
        PROTOENTRADA
        sub esp,4
        push ebx
        push ecx
        push edx
        mov ebx,dword [ebp+8] ;arreglo
        mov ecx,dword[ebp+12] ;len
        mov edx,dword [ebx] ;arreglo[0]
        mov dword[ebp-4],edx ;min
        
        WHILE ciclo2,Compararmax,ecx,finmax

        pop edx
        pop ecx
        pop ebx
        mov eax,dword[ebp-4]
        add esp,4
        PROTOSALIDA
        ret

Compararmax:
        mov edx, dword[ebx+ecx*4]
        mov eax, dword[ebp-4]

        cmp edx,eax
        jg .cambiomax
        jmp .endmax

.cambiomax: 
        mov dword[ebp-4],edx
        
.endmax: ret


_sumatoria: 
        PROTOENTRADA
        sub esp,4
        push ebx
        push ecx
        push edx
        mov ebx,dword [ebp+8] ;arreglo
        mov ecx,dword[ebp+12] ;len
        mov edx,dword [ebx] ;arreglo[0]
        mov dword[ebp-4],edx ;min
        
        WHILE ciclo3,sumar,ecx,finsum

        pop edx
        pop ecx
        pop ebx
        mov eax,dword[ebp-4]
        add esp,4
        PROTOSALIDA
        ret

sumar:
        mov edx, dword[ebx+ecx*4]
        add dword [ebp-4], edx
        ret
