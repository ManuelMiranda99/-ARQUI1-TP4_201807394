include macros.asm

.model small

; STACK SEGMENT
.stack

; DATA SEGMENT
; ON THIS SEGMENT WE CREATE THE "VARIABLES" THAT WE ARE GOING TO USE IN THE PROGRAM
.data

; SPECIAL CHARACTERS
    newLine db 13, 10, '$'
    cleanChar db '             ', '$'
    errorCmd db 'Comando de juego invalido', '$'

    invalidCell db 'Movimiento invalido, celda ocupada', '$'
    suicideMove db 'Movimiento suicida no valido', '$'
    koRule db 'Violacion a la regla ko', '$'

    removeCoin db '  ', '$'
    countT dw 00h
; END SPECIAL CHARACTER

; TESTING
    testingM db 'Prueba...', '$'
; END TESTING

; HEADER AND MENU
    header db 9, 9, 'UNIVERSIDAD DE SAN CARLOS DE GUATEMALA', 13, 10, 9, 9, 'FACULTAD DE INGENIERIA', 13, 10, 9, 9, 'CIENCIAS Y SISTEMAS', 13, 10, 9, 9, 'ARQUITECTURA DE COMPUTADORES Y ENSAMBLADORES 1', 13, 10, 9, 9, 'NOMBRE: ANGEL MANUEL MIRANDA ASTURIAS', 13, 10, 9, 9, 'CARNET: 201807394', 13, 10, 9, 9, 'SECCION: A', 13, 10, '$'
    menu db 13, 10, 9, 9, '-_-MENU-_-', 13, 10, 9, 9, '1) Iniciar Juego', 13, 10, 9, 9, '2) Cargar Juego', 13, 10, 9, 9, '3) Salir', 13, 10, '$'
    msgRoute db 'Ingrese la ruta (.arq): ', '$'
    endGameMsg db 'Juego terminado', 13, 10, '$'
; END HEADER AND MENU

; HTML
    htmlFileName db 'p4/est.html', 00h
    
    htmlHeader1 db '<!DOCTYPE html><html><header><title>Reporte HTML</title><link rel="StyleSheet" href="style.css" type="text/css"></header><body><h1 align="center">'
    
    htmlHeader2 db '</h1><br><div class="tablero"><table>'

    htmlBeginRow db '<tr>'

    htmlEndRow db '</tr>'    

    htmlNormalCell db '<td></td>'

    htmlWhiteCell db '<td><img src="white.png"></td>'

    htmlBlackCell db '<td><img src="black.png"></td>'

    htmlBlackTCell db '<td><img src="tblack.png"></td>'

    htmlWhiteTCell db '<td><img src="twhite.png"></td>'

    htmlNeutralTCell db '<td><img src="tneutral.png"></td>'

    htmlEnd db '</table></div></body></html>  '
    
    htmlContent db 2500 dup('$')

    date db '00/00/0000  00:00:00'
    
; END HTML

; TURN (15 POSITIONS)

    actualTurn db 66 ; Black

    blacksTurn db 'Turno Negras: ', 13, 10, '$'
    blackCoin db 'FN', '$'
    ;blacksWin db '¡¡¡Ganaron las Negras!!!', '$'

    whitesTurn db 'Turno Blancas: ', 13, 10, '$'
    whiteCoin db 'FB', '$'
    ;whitesWin db '¡¡¡Ganaron las Blancas!!!', '$'
; END OF TURN

; POSITION (VARIABLES FOR THE POSITION WHERE WE ARE GOING TO PUT A COIN)
    row db 00h
    column db 00h

    rowFile db 00h
    columnFile db 00h

; END POSITION

; COMMAND
    command db 5 dup('$')

; ROUTES
    route db 50 dup('$')
    Entryhandler dw ?
    htmlHandler dw ?
; END ROUTES

; ERRORS
    msgErrorWrite db 'Error al escribir en el archivo', '$'
    msgErrorOpen db 'Error al abrir el archivo', '$'
    msgErrorCreate db 'Error al crear el archivo', '$'
    msgErrorClose db 'Error al cerrar el archivo', '$'
    msgErrorRead db 'Error al leer el archivo', '$'
; END ERRORS

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

; MATRIX. 56h -> Empty. 55h -> Neutral Territory | 57h -> White. 58h -> White Territory | 42h -> Black. 43h -> Black Territoy
    fileContent9 db 56h, 56h, 56h, 56h, 56h, 56h, 56h, 56h, 56h, 0dh, 0ah
    fileContent8 db 56h, 56h, 56h, 56h, 56h, 56h, 56h, 56h, 56h, 0dh, 0ah
    fileContent7 db 56h, 56h, 56h, 56h, 56h, 56h, 56h, 56h, 56h, 0dh, 0ah
    fileContent6 db 56h, 56h, 56h, 56h, 56h, 56h, 56h, 56h, 56h, 0dh, 0ah
    fileContent5 db 56h, 56h, 56h, 56h, 56h, 56h, 56h, 56h, 56h, 0dh, 0ah
    fileContent4 db 56h, 56h, 56h, 56h, 56h, 56h, 56h, 56h, 56h, 0dh, 0ah
    fileContent3 db 56h, 56h, 56h, 56h, 56h, 56h, 56h, 56h, 56h, 0dh, 0ah
    fileContent2 db 56h, 56h, 56h, 56h, 56h, 56h, 56h, 56h, 56h, 0dh, 0ah
    fileContent1 db 56h, 56h, 56h, 56h, 56h, 56h, 56h, 56h, 56h, 0dh, 0ah

    fileContent db 99 dup('$')

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
        ;CleanRows
        ClearConsole
        moveCursor 00h, 00h
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
        ; Cleaning the count of passing when a person plays
        mov countT, 00h
        print newLine
        DrawTable
        jmp Playing
    ; Probado
    LoadGame:
        mov countT, 00h
        print newLine
        print msgRoute

        Clean route, SIZEOF route, 24h

        getRoute route

        OpenFile route, Entryhandler

        Clean fileContent, SIZEOF fileContent, 56h

        ReadFile Entryhandler, fileContent, SIZEOF fileContent

        CloseFile Entryhandler

        DrawTable        

        AnalizeText fileContent, rowFile, columnFile

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
        
        ; COMPARE WHO IS PLAYING
        cmp actualTurn, 66
            je PutBlackCoin
        jmp PutWhiteCoin
    PutBlackCoin:        
        ; VALIDATE THE POSITION AND PRINT IN THE POSITION THE COIN
        PutCoinMacro 42h, blackCoin
        ; Cleaning the count of passing when a person plays
        mov countT, 00h
        ; PASSING THE TURN TO THE OTHER PLAYER
        mov actualTurn, 87
        moveCursor 00h, 00h
        print whitesTurn
        jmp Playing
    PutWhiteCoin:        
        ; VALIDATE THE POSITION AND PRINT IN THE POSITION THE COIN
        PutCoinMacro 57h, whiteCoin
        ; Cleaning the count of passing when a person plays
        mov countT, 00h
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
        getDateAndHour date

        Clean htmlContent, SIZEOF htmlContent, '$'
        
        CreateFile htmlFileName, htmlHandler

        GenerateHTML
        
        WriteOnFile htmlHandler, htmlContent, SIZEOF htmlContent

        CloseFile htmlHandler

        jmp Playing
    SAVEGAME:
                
        print msgRoute

        Clean route, SIZEOF route, 24h

        getRoute route
        
        CreateFile route, Entryhandler                  

        ConcatenateRows fileContent
    
        WriteOnFile Entryhandler, fileContent, SIZEOF fileContent

        CloseFile Entryhandler

        moveCursor 01h, 00h
        print cleanChar
        print cleanChar
        print cleanChar
        print cleanChar

        jmp Playing
    PASSTURN:
        inc countT
        cmp countT, 02h
            je EndGame
        
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
    EndGame:
        ClearConsole
        moveCursor 10h, 1ah
        print endGameMsg
        getChar

        ; Generation of the HTML

        getDateAndHour date

        Clean htmlContent, SIZEOF htmlContent, '$'
        
        CreateFile htmlFileName, htmlHandler

        GenerateHTML
        
        WriteOnFile htmlHandler, htmlContent, SIZEOF htmlContent

        CloseFile htmlHandler

        jmp PrincipalMenu
    EXITGAME:
        moveCursor 00h, 00h
        jmp PrincipalMenu    
    Exit:
        mov ah, 4ch     ; END PROGRAM
        xor al, al
        int 21h
    ; Errors
        WriteError:
            moveCursor 01h, 00h
            print msgErrorWrite
            getChar
            moveCursor 01h, 00h
            print cleanChar
            print cleanChar
            print cleanChar        
            jmp Playing
        OpenError:
            moveCursor 01h, 00h
            print msgErrorOpen
            getChar
            moveCursor 01h, 00h
            print cleanChar
            print cleanChar
            print cleanChar        
            jmp PrincipalMenu
        CreateError:
            moveCursor 01h, 00h
            print msgErrorCreate
            getChar
            moveCursor 01h, 00h
            print cleanChar
            print cleanChar
            print cleanChar        
            jmp Playing
        CloseError:
            moveCursor 01h, 00h
            print msgErrorClose
            getChar
            moveCursor 01h, 00h
            print cleanChar
            print cleanChar
            print cleanChar        
            jmp Playing
        ReadError:
            moveCursor 01h, 00h
            print msgErrorRead
            getChar
            moveCursor 01h, 00h
            print cleanChar
            print cleanChar
            print cleanChar        
            jmp PrincipalMenu
        SuicidalMove:
            moveCursor 01h, 00h
            print suicideMove
            getChar
            moveCursor 01h, 00h
            print cleanChar
            print cleanChar
            print cleanChar     
            print cleanChar   
            jmp Playing
        KoRuleMsg:
            moveCursor 01h, 00h
            print koRule            
            getChar
            moveCursor 01h, 00h
            print cleanChar
            print cleanChar
            print cleanChar
            print cleanChar
            jmp Playing
        invalidCellM:
            moveCursor 01h, 00h
            print invalidCell
            getChar
            moveCursor 01h, 00h
            print cleanChar
            print cleanChar
            print cleanChar   
            print cleanChar     
            jmp Playing
main endp

end