include macros.asm

.model small

; STACK SEGMENT
.stack

; DATA SEGMENT
; ON THIS SEGMENT WE CREATE THE "VARIABLES" THAT WE ARE GOING TO USE IN THE PROGRAM
.data

    ; SPECIAL CHARACTERS
newLine db 13, 10, '$'
cleanChar db '           ', '$'
errorCmd db 'Comando de juego invalido', '$'
    ; TESTING
passMsg db 'PASS', '$'
exitMsg db 'EXIT', '$'
saveMsg db 'SAVE', '$'
showMsg db 'SHOW', '$'
rowMsg db 'ROW: ', '$'
columnMsg db 'COLUMN: ', '$'

    ; HEADER AND MENU
header db 9, 9, 'UNIVERSIDAD DE SAN CARLOS DE GUATEMALA', 13, 10, 9, 9, 'FACULTAD DE INGENIERIA', 13, 10, 9, 9, 'CIENCIAS Y SISTEMAS', 13, 10, 9, 9, 'ARQUITECTURA DE COMPUTADORES Y ENSAMBLADORES 1', 13, 10, 9, 9, 'NOMBRE: ANGEL MANUEL MIRANDA ASTURIAS', 13, 10, 9, 9, 'CARNET: 201807394', 13, 10, 9, 9, 'SECCION: A', 13, 10, '$'
menu db 13, 10, 9, 9, '-_-MENU-_-', 13, 10, 9, 9, '1) Iniciar Juego', 13, 10, 9, 9, '2) Cargar Juego', 13, 10, 9, 9, '3) Salir', 13, 10, '$'
msgRoute db 'Ingrese la ruta (.arq): ', '$'
    ; END HEADER AND MENU

    ; HTML
htmlFileName db 'estadoTablero.html'
htmlContent db 'GG'
    ; END HTML

    ; TURN (15 POSITIONS)

actualTurn db 66 ; Black

blacksTurn db 'Turno Negras: ', 13, 10, '$'
blackCoin db 'FN', '$'

whitesTurn db 'Turno Blancas: ', 13, 10, '$'
whiteCoin db 'FB', '$'
    ; END OF TURN

    ; POSITION (VARIABLES FOR THE POSITION WHERE WE ARE GOING TO PUT A COIN)
row db 00h
column db 00h
    ; END POSITION

    ; COMMAND
command db 5 dup('$')

    ; ROUTES
route db 50 dup('$')
Entryhandler dw ?
    ; END ROUTES

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

    ; MATRIX. 20h -> Empty. 57h -> White. 42h -> Black
m9 db 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h
m8 db 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h
m7 db 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h
m6 db 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h
m5 db 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h
m4 db 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h
m3 db 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h
m2 db 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h
m1 db 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h

fileContent db 82 dup('$')

    ; END OF MATRIX

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
        ; COMPARE THE CHAR THAT THE USER WRITE IN THE PROGRAM
        cmp al, 31h         ; START GAME            
            je Game
        cmp al, 32h         ; LOAD GAME
            je LoadGame
        cmp al, 33h         ; EXIT
            je Exit
    
    Game:
        print newLine
        jmp DrawTable
    LoadGame:
        print newLine
        ClearConsole
    DrawTable:
        ClearConsole
        moveCursor 00h, 00h
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
        jmp Playing
    Playing:
        ; MOVING THE CURSOR TO THE INPUT POSITION
        moveCursor 00h, 0fh
        
        ; CLEAN THE INPUT POSITION
        print cleanChar

        ; MOVING THE CURSOR TO THE INPUT POSITION
        moveCursor 00h, 0fh

        ; GET THE COMMAND THAT THE PLAYER PUT AND MOVE THE CURSOR TO THE POSITION
        getText command
        
        ; ANALIZE THE COMMAND
        getCommand command, row, column 

        ; EXIT: ROW = 4fh COLUMN = 4fh
        ; PASS: ROW = 54 COLUMN = 54
        ; SAVE: ROW = 45 COLUMN = 45
        ; SHOW: ROW = 53 COLUMN = 53
        ; ERROR: ROW = 43 COLUMN = 43

        ; EXIT. DONE
        cmp row, 4fh
            je EXITGAME
        ; PASS. DONE 0.5 (CHECK IF BOTH PLAYERS PASS)
        cmp row, 54h
            je PASSTURN
        ; SAVE GAME.
        cmp row, 45h
            je SAVEGAME
        ; SHOW GAME.
        cmp row, 53h
            je SHOWGAME
        ; INVALID COMMAND. DONE
        cmp row, 43h
            je INVALIDCOMMAND
        
        moveCursor row, column

        ; COMPARE WHO IS PLAYING
        cmp actualTurn, 66
            je PutBlackCoin
        jmp PutWhiteCoin  
    PutBlackCoin:
        ; PRINT IN THE POSITION THE COIN
        print blackCoin
        

        returnPutBlackCoin:
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
    INVALIDCOMMAND:
        moveCursor 01h, 00h
        print errorCmd
        getChar
        moveCursor 01h, 00h
        print cleanChar
        print cleanChar
        print cleanChar
        print cleanChar
        jmp Playing
    SHOWGAME:
        jmp Playing
    SAVEGAME:

        ; Se crea archivo pero no se genera bien en el texto

        print msgRoute

        Clean route, SIZEOF route, 24h

        getRoute route

        CreateFile route, Entryhandler

        ; CHECK THE GENERATION OF TEXT AND THE WRITE ON FILE MACRO

        ;GetFileText fileContent

        ;getChar

        ;WriteOnFile Entryhandler, fileContent, SIZEOF fileContent

        moveCursor 01h, 00h
        print cleanChar
        print cleanChar
        print cleanChar
        print cleanChar

        jmp Playing
    PASSTURN:
        cmp actualTurn, 66
            je PassBlack
        jmp PassWhite
        PassWhite:
            mov actualTurn, 66
            moveCursor 00h, 00h
            print blacksTurn
            jmp Playing
        PassBlack:
            mov actualTurn, 87
            moveCursor 00h, 00h
            print whitesTurn
            jmp Playing
    EXITGAME:
        ClearConsole
        moveCursor 00h, 00h
        jmp PrincipalMenu    
    Exit:
        mov ah, 4ch     ; END PROGRAM
        xor al, al
        int 21h

main endp

end