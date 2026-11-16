%include "../../lib/pc_io.inc"  


%macro PROTOENTRADA 0
	push ebp
	mov ebp,esp
%endmacro

%macro PROTOSALIDA 0
	mov esp,ebp
	pop ebp
%endmacro


section	.text
    global _setbit   
    global _getbit  
	
    _setbit:
    
    PROTOENTRADA
    push ebx
    push ecx

    mov ebx, dword [ebp+8]    
    mov ecx, dword [ebp+12]   

    mov eax, 1
    shl eax, cl               
    or  [ebx], al             

    pop ecx
    pop ebx
    PROTOSALIDA
    ret

    _getbit:
        PROTOENTRADA
        sub esp,4
        push ebx
        push ecx
        
        mov ebx,dword[ebp+8] ;flags
        mov ecx,dword[ebp+12] ;posicion

        mov  eax, 1
        shl  eax, cl
        and  eax, ebx
        shr  eax, cl 
        
       
        pop ecx
        pop ebx
        PROTOSALIDA
        ret