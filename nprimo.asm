
;Pedir un numero del 1 al 5 y ver si es primo o no

section .data	
	msj db 10, 'no Es primo', 10, 0
	len equ $- msj
	msj2 db 10, ' Es primo', 10, 0
	len2 equ $- msj2
	msgTitulo db 10, 'Numero Primo'
	len_titulo equ $-msgTitulo
	msgNumero1 db 10, 'Ingrese un numero',10
	len_numero1 equ $-msgNumero1
	msgSaliendo db 10, 'Saliendo',10
	len_saliendo equ $-msgSaliendo
	
section .bss
	n1 resb 2
	
	 

section .text
global _start
 
_start:

mov eax, 4
mov ebx, 1
mov ecx, msgTitulo
mov edx, len_titulo
int 80h




;--------Ingreso numero------------
mov eax, 4
mov ebx, 1
mov ecx, msgNumero1
mov edx, len_numero1
int 80h

;----------leo numero------------
mov eax, 3
mov ebx, 2
mov ecx, n1
mov edx, 2
int 80h
jmp proceso

;--------verificar si esta dentro del rango----
mov al, [n1]
add al, '0'
cmp al, '1'
jz proceso
cmp al, '2'
jz proceso
cmp al, '3'
jz proceso
cmp al, '4'
jz proceso
cmp al, '5'
jz proceso
jmp salir

proceso:
	mov al, [n1]
	sub al, '0'
	cmp al, 4
	je esprimo
	jz noprimo
	
noprimo:
	mov eax, 4
	mov ebx, 1
	mov ecx, msj2
	mov edx, len2
	int 80h
	jmp salir
	
esprimo:
	mov eax, 4
	mov ebx, 1
	mov ecx, msj
	mov edx, len
	int 80h
	jmp salir

mov eax, 4
	mov ebx, 1
	mov ecx, msj2
	mov edx, len2
	int 80h
	jmp salir

salir:
mov eax,1
int 80h
