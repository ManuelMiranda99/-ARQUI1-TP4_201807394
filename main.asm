include macros.asm

.model small

; STACK SEGMENT
.stack

; DATA SEGMENT
; ON THIS SEGMENT WE CREATE THE "VARIABLES" THAT WE ARE GOING TO USE IN THE PROGRAM
.data

    ; HEADER AND MENU
header db 9, 9, 'UNIVERSIDAD DE SAN CARLOS DE GUATEMALA', 13, 10, 9, 9, 'FACULTAD DE INGENIERIA', 13, 10, 9, 9, 'CIENCIAS Y SISTEMAS', 13, 10, 9, 9, 'ARQUITECTURA DE COMPUTADORES Y ENSAMBLADORES 1', 13, 10, 9, 9, 'NOMBRE: ANGEL MANUEL MIRANDA ASTURIAS', 13, 10, 9, 9, 'CARNET: 201807394', 13, 10, 9, 9, 'SECCION: A', 13, 10, '$'
menu db 13, 10, 9, 9, '-_-MENU-_-', 13, 10, 9, 9, '1) Iniciar Juego', 13, 10, 9, 9, '2) Cargar Juego', 13, 10, 9, 9, '3) Salir', 13, 10, '$'
    ; END HEADER AND MENU

; CODE SEGMENT
; ON THIS SEGMENT WE START TO WRITE THE CODE
.code

main proc

    ; BEGGINIG OF THE PROGRAM
    Start:
        PrincipalMenu

    ; PRINCIPAL MENU
    PrincipalMenu:
        print header
        print menu
        getChar
        ; COMPARE THE CHAR THAT THE USER WRITE IN THE PROGRAM
        cmp al, '1'         ; START GAME
            je Game
        cmp al, '2'         ; LOAD GAME
            je LoadGame
        cmp al, '3'         ; EXIT
            je Exit
    
    Game:

    LoadGame:

    Exit:
        mov ah, 4ch     ; END PROGRAM
        xor al, al
        int 21h

main endp
end main