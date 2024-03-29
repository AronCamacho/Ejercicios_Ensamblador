;UNIVERSIDAD NACIONAL DE LOJA
;LENGUAJE ENSAMBLADOR
;ARON CAMACHO 6TO "A"

%macro escribir 2
	mov eax, 4
	mov ebx, 1
	mov ecx, %1
	mov edx, %2
	int 80H
%endmacro

%macro leer 2 
	mov eax,3
	mov ebx,2
	mov ecx,%1   
	mov edx,%2   
	int 80h
%endmacro

section .data
	texto db "MATRIZ 3X5", 10
	len equ $ -texto
	espacio db " ", 10
	len_espacio equ $ -espacio
	numero db "Ingrese un numero", 10
	len_numero equ $ -numero
	
section .bss
	n resb 1

section .text
	global _start

_start:
	escribir texto, len
	escribir numero, len_numero 
	leer n,1
	mov ecx, 5
	mov ebx, 3
	
fila:
	push ebx
	push 5
	escribir espacio, len_espacio
	pop ecx

	mov eax,1
	add eax,'0'

columna:
	
	push ecx
    mov [n],eax
    escribir n,1
    mov eax,[n]
    inc eax
    pop ecx
    loop columna

    pop ecx
    mov ebx, ecx
    dec ebx
    loop fila
	
salir:
	mov eax, 1
	int 80H
