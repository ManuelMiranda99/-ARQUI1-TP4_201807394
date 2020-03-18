include macros.asm

.model small

; STACK SEGMENT
.stack

; DATA SEGMENT
; ON THIS SEGMENT WE CREATE THE "VARIABLES" THAT WE ARE GOING TO USE IN THE PROGRAM
.data

    ; SPECIAL CHARACTERS
newLine db 13, 10, '$'
cleanChar db '          ', '$'

    ; HEADER AND MENU
header db 9, 9, 'UNIVERSIDAD DE SAN CARLOS DE GUATEMALA', 13, 10, 9, 9, 'FACULTAD DE INGENIERIA', 13, 10, 9, 9, 'CIENCIAS Y SISTEMAS', 13, 10, 9, 9, 'ARQUITECTURA DE COMPUTADORES Y ENSAMBLADORES 1', 13, 10, 9, 9, 'NOMBRE: ANGEL MANUEL MIRANDA ASTURIAS', 13, 10, 9, 9, 'CARNET: 201807394', 13, 10, 9, 9, 'SECCION: A', 13, 10, '$'
menu db 13, 10, 9, 9, '-_-MENU-_-', 13, 10, 9, 9, '1) Iniciar Juego', 13, 10, 9, 9, '2) Cargar Juego', 13, 10, 9, 9, '3) Salir', 13, 10, '$'
    ; END HEADER AND MENU

    ; POSITION OF THE NEW STONE OR SPECIAL COMMAND
state db 00h

    ; HTML
htmlFileName db 'estadoTablero.html'
htmlContent db 'GG'
    ; END HTML

    ; TURN (15 POSITIONS)
actualTurn db 66 ; Black
blacksTurn db 'Turno Negras: ', 13, 10, '$'
blackCoin db 'FN', '$'
whiteCoin db 'FB', '$'
whitesTurn db 'Turno Blancas: ', 13, 10, '$'
    ; END OF TURN

    ; POSITION (VARIABLES FOR THE POSITION WHERE WE ARE GOING TO PUT A COIN)
row db 1 dup('$')
column db 1 dup('$')
    ; END POSITION

    ; TABLE
f9 db           '9    ---  ---  ---  ---  ---  ---  ---  ---', 13, 10, '$'
f8_5 db         '   :    :    :    :    :    :    :    :    :', 13, 10,'$'
f8 db           '8    ---  ---  ---  ---  ---  ---  ---  ---', 13, 10, '$'
f7_5 db         '   :    :    :    :    :    :    :    :    :', 13, 10,'$'
f7 db           '7    ---  ---  ---  ---  ---  ---  ---  ---', 13, 10, '$'
f6_5 db         '   :    :    :    :    :    :    :    :    :', 13, 10,'$'
f6 db           '6    ---  ---  ---  ---  ---  ---  ---  ---', 13, 10, '$'
f5_5 db         '   :    :    :    :    :    :    :    :    :', 13, 10,'$'
f5 db           '5    ---  ---  ---  ---  ---  ---  ---  ---', 13, 10, '$'
f4_5 db         '   :    :    :    :    :    :    :    :    :', 13, 10,'$'
f4 db           '4    ---  ---  ---  ---  ---  ---  ---  ---', 13, 10, '$'
f3_5 db         '   :    :    :    :    :    :    :    :    :', 13, 10,'$'
f3 db           '3    ---  ---  ---  ---  ---  ---  ---  ---', 13, 10, '$'
f2_5 db         '   :    :    :    :    :    :    :    :    :', 13, 10,'$'
f2 db           '2    ---  ---  ---  ---  ---  ---  ---  ---', 13, 10, '$'
f1_5 db         '   :    :    :    :    :    :    :    :    :', 13, 10,'$'
f1 db           '1    ---  ---  ---  ---  ---  ---  ---  ---', 13, 10, '$'
f0 db 13, 10,   '   A    B    C    D    E    F    G    H    I', 13, 10, '$'
    ; END OF TABLE

; CODE SEGMENT
; ON THIS SEGMENT WE START TO WRITE THE CODE
.code

main proc

    ; BEGGINIG OF THE PROGRAM
    Start:
        jmp PrincipalMenu

    ; PRINCIPAL MENU
    PrincipalMenu:
        print header
        print menu
        getChar
        print newLine
        ; COMPARE THE CHAR THAT THE USER WRITE IN THE PROGRAM
        cmp al, '1'         ; START GAME            
            je Game
        cmp al, '2'         ; LOAD GAME
            je LoadGame
        cmp al, '3'         ; EXIT
            je Exit
    
    Game:
        jmp DrawTable
    LoadGame:
        ClearConsole
    DrawTable:
        ClearConsole
        print blacksTurn
        print newLine
        print f9
        print f8_5
        print f8
        print f7_5
        print f7
        print f6_5
        print f6
        print f5_5
        print f5
        print f4_5
        print f4
        print f3_5
        print f3
        print f2_5
        print f2
        print f1_5
        print f1
        print f0
    Playing:
        ; MOVING THE CURSOR TO THE INPUT POSITION
        moveCursor 0fh, 00h
        
        ; CLEAN THE INPUT POSITION
        print cleanChar

        ; MOVING THE CURSOR TO THE INPUT POSITION
        moveCursor 0fh, 00h

        ; GET THE COMMAND THAT THE PLAYER PUT AND MOVE THE CURSOR TO THE POSITION
        getCommand row, column
        moveCursor row, column

        ; COMPARE WHO IS PLAYING
        cmp actualTurn, 66
            je PutBlackCoin
        jmp PutWhiteCoin  
    PutBlackCoin:
        ; PRINT IN THE POSITION THE COIN
        print blackCoin
        ; PASSING THE TURN TO THE OTHER PLAYER
        mov actualTurn, 87
        moveCursor 00h, 00h
        print whitesTurn
        jmp Playing
    PutWhiteCoin:
        ; PRINT IN THE POSITION THE COIN
        print whiteCoin
        ; PASSING THE TURN TO THE OTHER PLAYER
        mov actualTurn, 66
        moveCursor 00h, 00h
        print blacksTurn
        jmp Playing
    Exit:
        mov ah, 4ch     ; END PROGRAM
        xor al, al
        int 21h

main endp
end main