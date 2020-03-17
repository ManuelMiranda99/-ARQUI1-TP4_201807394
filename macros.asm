; Archivo que contendra los macros utilizados
; para la practica 4 de arqui. Esto para tener un orden mejor en el codigo

; Macro para imprimir
print macro string
    mov ax, @data
    mov ds, ax
    mov ah, 09h             ; Numero de funcion para imprimir cadena en pantalla
    mov dx, offset string   ; Equivalente a lea dx, cadena. Inicializa en dx la posicion donde comienza la cadena
    int 21h
endm

; Macro para leer caracter
getChar macro
    mov ah, 01h
    int 21h
endm