;UNIVERSIDAD NACIONAL DE LOJA
;LENGUAJE ENSAMBLADOR
;ARON CAMACHO 6TO "A"

%macro escribir 2

	mov eax,4
	mov ebx,1
	mov ecx,%1
	mov edx,%2
	int 80h
%endmacro

section .data

	mensaje1 db 'numero1',10
	len_mensaje1 equ $-mensaje1

	mensaje2 db 'numero2',10
	len_mensaje2 equ $-mensaje2

	msj db 'La suma es:'
	len equ $-msj

	suma db '  '


	archivo2 db "/home/aron/Documentos/Programacion/ensamblador/archs1.txt",0
	archivo1 db "/home/aron/Documentos/Programacion/ensamblador/arch2.txt",0 

section .bss

	texto resb 25		; variable que almacena el contenido del archivo
	texto2 resb 25

	idarchivo1 resd 1 	; identificador que se obtiene del archivo, el archivo es el fisico
	idarchivo2 resd 1

section .text

	global _start

_start:

	;LECTURA DEL PRIMER ARCHIVO 1	

	mov eax, 5		;servicio 5 para leer el archivo
	mov ebx, archivo1	;direccion del archivo
	mov ecx,0 		;modo de acceso-->leer=0, escribir=1, leer y escribir=2
	mov edx,0 		;permite leer si esta craeado
	int 80h 

	test eax,eax		;instruccion de comparacion-->modifica el valor de las banderas
	jz salir

	mov dword[idarchivo1], eax

	escribir mensaje1, len_mensaje1

	mov eax,3		;servicio 3 lectura	
	mov ebx,[idarchivo1]	;unidad de entrada
	mov ecx,texto
	mov edx,25
	int 80h
	
	escribir texto , 25

	mov eax,6		;servicio 6 cerrar el archivo
	mov ebx,[idarchivo1]
	mov ecx,0
	mov edx,0
	int 80h

	;LECTURA ARCHIVO 2

	mov eax, 5		;servicio 5 para leer el archivo
	mov ebx, archivo2	;direccion del archivo
	mov ecx,0 		;modo de acceso-->leer=0, escribir=1, leer y escribir=2
	mov edx,0 		;permite leer si esta craeado
	int 80h 

	test eax,eax		;instruccion de comparacion-->modifica el valor de las banderas
	jz salir

	mov dword[idarchivo2], eax

	escribir mensaje2, len_mensaje2

	mov eax,3		;servicio 3 lectura	
	mov ebx,[idarchivo2]	;unidad de entrada
	mov ecx,texto2
	mov edx,25
	int 80h
	
	escribir texto2 , 25

	mov eax,6		;servicio 6 cerrar el archivo
	mov ebx,[idarchivo2]
	mov ecx,0
	mov edx,0
	int 80h

	;SUMA DE LOS DOS ARCHIVOS
	
	mov ecx, 3		;numero de operaciones
	mov esi, 2		;posicion del numero
	clc			;permite poner la bandera del carry en 0(cf=0)

operacion_resta:

	mov al, [texto + esi]
	sbb al, [texto2 + esi]	; suma normal + carry(esta en binario)
	
	aas;       		; toda operacion que conlleve acarreo hay que ajustar, aaa suma 6 digitos a la parte baja del registro
				; y un digito a la parte alta  

	pushf			;push flag--->envia el estado de las banderas a la pila

	or al,30h		; coveritirde un caracter a un decimal(similar a sub al, '0'
 	popf			; restaura el estado de las banderas almacenadas temporalmente en la pila hacia las banderas	
	
	mov [suma + esi], al	
	dec esi
	loop operacion_resta
	escribir msj, len
	escribir suma, 3


salir:

	mov eax,1
	int 80h
