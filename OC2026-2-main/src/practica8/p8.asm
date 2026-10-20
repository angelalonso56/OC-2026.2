section .text
    global _start
    
_start:  
    mov al,'2'
    call miputchar
    mov al,'e'
    call miputchar

miputchar:  
        push eax
        mov eax,4
        mov edx,1
        mov ecx,esp
        mov edx,1
        int 0x08
        pop eax
        




