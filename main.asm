include macros.asm

.model small

; SEGMENTO DE PILA
.stack

; SEGMENTO DE DATO
; En este segmento se deben de declarar todas las "variables" a utilizar.
.data

; SEGMENTO DE CODIGO
; Parte del codigo assembler donde se coloca el codigo
.code

main proc

    practica4:

    Salir:
        mov ah, 4ch     ; Numero de funcion para finalizar el programa
        xor al, al
        int 21h

main endp
end main