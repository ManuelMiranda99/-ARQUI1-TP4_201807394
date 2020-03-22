; FILE THAT CONTAINS ALL THE MACROS FOR THE PROGRAM

; PRINT ON THE SCREEN
print macro string
    Pushear
    mov ax, @data
    mov ds, ax
    mov ah, 09h             ; PRINT
    mov dx, offset string
    int 21h
    Popear
endm

; GET CHARACTER
getChar macro    
    mov ah, 01h
    int 21h
endm

; CLEAN STRING
Clean macro string, numBytes, char
    local RepeatLoop
    Pushear
    xor si, si
    xor cx, cx
    mov cx, numBytes
    RepeatLoop:
        mov string[si], char
        inc si
    Loop RepeatLoop
    Popear
endm

; DrawTable Macro
DrawTable macro
    Pushear
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
    Popear
endm

; GET TEXT UNTIL THE USER WRITE ENTER
getText macro string
    local getCharacter, EndGC, Backspace
    Pushear
    xor si, si

    getCharacter:
        getChar
        cmp al, 0dh
            je EndGC
        cmp al, 08h
            je Backspace
        mov string[si], al
        inc si
        jmp getCharacter
    Backspace:
        mov al, 24h
        dec si
        mov string[si], al
        jmp getCharacter
    EndGC:        
        mov al, 24h
        mov string[si], al
        Popear
endm

; GET COMMAND THAT THE USER USE
getCommand macro string, Nrow, Ncolumn
    local Case0, Case1, Case2, Case3, Case4, Case5, Case6, Case7, Case8, Case9, Case10, Case11
    local A, B, C, D, E, F, G, H, I, Num1, Num2, Num3, Num4, Num5, Num6, Num7, Num8, Num9
    local ErrorL, EXITcmd, PASScmd, SAVEcmd, SHOWcmd, EndGC
    
    Pushear
    
    mov Nrow, 00h
    mov Ncolumn, 00h
    xor si, si    
    ; Cases
        Case0:
            ; ------A------
            cmp string[si], 41h
                je A
            ; ------B------
            cmp string[si], 42h
                je B
            ; ------C------
            cmp string[si], 43h
                je C
            ; ------D------
            cmp string[si], 44h
                je D
            ; ------E------
            cmp string[si], 45h
                je E
            ; ------F------
            cmp string[si], 46h
                je F
            ; ------G------
            cmp string[si], 47h
                je G
            ; ------H------
            cmp string[si], 48h
                je H
            ; ------I------
            cmp string[si], 49h
                je I
            ; ------P------
            cmp string[si], 50h
                je Case4
            ; ------S------
            cmp string[si], 53h
                je Case7    
            jmp ErrorL
            ; ASSIGN VALUES TO THE COLUMN DEPENDING ON WHAT THEY WROTE
                A:
                    mov Ncolumn, 03h
                    inc si
                    jmp Case1
                B:
                    mov Ncolumn, 08h
                    inc si
                    jmp Case1
                C:
                    mov Ncolumn, 0dh
                    inc si
                    jmp Case1
                D:
                    mov Ncolumn, 12h
                    inc si
                    jmp Case1
                E:
                    mov Ncolumn, 17h
                    inc si
                    jmp Case1
                F:
                    mov Ncolumn, 1ch
                    inc si
                    jmp Case1
                G:
                    mov Ncolumn, 21h
                    inc si
                    jmp Case1
                H:
                    mov Ncolumn, 26h
                    inc si
                    jmp Case1
                I:
                    mov Ncolumn, 2bh
                    inc si
                    jmp Case1
        ;
        ;
        Case1:
            ; ------1------
            cmp string[si], 31h
                je Num1
            ; ------2------
            cmp string[si], 32h
                je Num2
            ; ------3------
            cmp string[si], 33h
                je Num3
            ; ------4------
            cmp string[si], 34h
                je Num4
            ; ------5------
            cmp string[si], 35h
                je Num5
            ; ------6------
            cmp string[si], 36h
                je Num6
            ; ------7------
            cmp string[si], 37h
                je Num7
            ; ------8------
            cmp string[si], 38h
                je Num8
            ; ------9------
            cmp string[si], 39h
                je Num9
            ; ------X------
            cmp string[si], 58h
                je Case2
            ; else
            jmp ErrorL
            ; ASSIGN VALUES TO THE ROW DEPENDING ON WHAT THEY WROTE
                Num1:
                    mov Nrow, 12h
                    jmp EndGC
                Num2:
                    mov Nrow, 10h
                    jmp EndGC
                Num3:
                    mov Nrow, 0eh
                    jmp EndGC
                Num4:
                    mov Nrow, 0ch
                    jmp EndGC
                Num5:
                    mov Nrow, 0ah
                    jmp EndGC
                Num6:
                    mov Nrow, 08h
                    jmp EndGC
                Num7:
                    mov Nrow, 06h
                    jmp EndGC
                Num8:
                    mov Nrow, 04h
                    jmp EndGC
                Num9:
                    mov Nrow, 02h
                    jmp EndGC
        ;
        ;
        Case2:
            inc si
            ; ------I------
            cmp string[si], 49h
                je Case3
            ; else
            jmp ErrorL
        ;
        ;
        Case3:
            inc si
            ; ------T------
            cmp string[si], 54h
                je EXITcmd
            ; else
            jmp ErrorL
        ;
        ;
        Case4:
            inc si
            ; ------A------
            cmp string[si], 41h
                je Case5
            ; else
            jmp ErrorL
        ;
        ;
        Case5:
            inc si
            ;------S------
            cmp string[si], 53h
                je Case6
            ; else
            jmp ErrorL
        ;
        ;
        Case6:
            inc si
            ; ------S------
            cmp string[si], 53h
                je PASScmd
            ; else
            jmp ErrorL
        ;
        ;
        Case7:
            inc si
            ; ------A------
            cmp string[si], 41h
                je Case8
            ; ------H------
            cmp string[si], 48h
                je Case10
            ; else
            jmp ErrorL
        ;
        ;
        Case8:
            inc si
            ; ------V------
            cmp string[si], 56h
                je Case9
            ; else
            jmp ErrorL
        ;
        ;
        Case9:
            inc si
            ; ------E------
            cmp string[si], 45h
                je SAVEcmd
            ; else
            jmp ErrorL
        ;
        ;
        Case10:
            inc si
            ; ------O------
            cmp string[si], 4fh
                je Case11
            ; else
            jmp ErrorL
        ;
        ;    
        Case11:
            inc si
            ; ------W------
            cmp string[si], 57h
                je SHOWcmd
            ; else
            jmp ErrorL
        ;
        ;
    ; ENDING PART WHERE I PUT A SPECIAL VALUE TO THE ROW AND THE COLUMN TO MAKE A COMMAND
        ErrorL:
            mov nRow, 43h
            mov Ncolumn, 43h
            jmp EndGC
        EXITcmd:
            mov nRow, 4fh
            mov Ncolumn, 4fh
            jmp EndGC
        PASScmd:
            mov nRow, 54h
            mov Ncolumn, 54h
            jmp EndGC
        SAVEcmd:
            mov nRow, 45h
            mov Ncolumn, 45h
            jmp EndGC
        SHOWcmd:
            mov nRow, 53h
            mov Ncolumn, 53h
            jmp EndGC
    EndGC:
        Popear
endm

; PUT COIN IN A PLACE
PutCoinMacro macro char
    local Row1, Row2, Row3, Row4, Row5, Row6, Row7, Row8, Row9
    local Column1, Column2, Column3, Column4, Column5, Column6, Column7, Column8, Column9
    local CompareColumns, CompareRows
    local EndGC
    Pushear
    ; COLUMNs
        CompareColumns:
            cmp column, 03h
                je Column1
            cmp column, 08h
                je Column2
            cmp column, 0dh
                je Column3
            cmp column, 12h
                je Column4
            cmp column, 17h
                je Column5
            cmp column, 1ch
                je Column6
            cmp column, 21h
                je Column7
            cmp column, 26h
                je Column8
            cmp column, 2bh
                je Column9
    ; ASSIGN VALUES FOR COLUMNS
        Column1:
            mov si, 00h
            jmp CompareRows
        Column2:
            mov si, 01h
            jmp CompareRows
        Column3:
            mov si, 02h
            jmp CompareRows
        Column4:
            mov si, 03h
            jmp CompareRows
        Column5:
            mov si, 04h
            jmp CompareRows
        Column6:
            mov si, 05h
            jmp CompareRows
        Column7:
            mov si, 06h
            jmp CompareRows
        Column8:
            mov si, 07h
            jmp CompareRows
        Column9:
            mov si, 08h
            jmp CompareRows
    ; ROWs
    CompareRows:
        ; ----1----
        cmp row, 12h
            je Row1
        ; ----2----        
        cmp row, 10h
            je Row2
        ; ----3----
        cmp row, 0eh
            je Row3
        ; ----4----
        cmp row, 0ch
            je Row4
        ; ----5----
        cmp row, 0ah
            je Row5
        ; ----6----
        cmp row, 08h
            je Row6
        ; ----7----
        cmp row, 06h
            je Row7
        ; ----8----
        cmp row, 04h
            je Row8
        ; ----9----
        cmp row, 02h
            je Row9
    ; ASSIGN VALUES FOR ROWs
        Row1:
            mov fileContent1[si], char
            jmp EndGC
        Row2:
            mov fileContent2[si], char
            jmp EndGC
        Row3:
            mov fileContent3[si], char
            jmp EndGC
        Row4:
            mov fileContent4[si], char
            jmp EndGC
        Row5:
            mov fileContent5[si], char
            jmp EndGC
        Row6:
            mov fileContent6[si], char
            jmp EndGC
        Row7:
            mov fileContent7[si], char
            jmp EndGC
        Row8:
            mov fileContent8[si], char
            jmp EndGC
        Row9:
            mov fileContent9[si], char
            jmp EndGC
    
    EndGC:
        Popear        
endm

; Move cursor
; The screen in text mode have 25 rows and 80 columns
moveCursor macro row, column
    Pushear
    mov ah, 02h
    mov dh, row
    mov dl, column
    int 10h
    Popear
endm

; CLEAN CONSOLE
ClearConsole macro
    local ClearConsoleRepeat
    Pushear
    mov dx, 50h
    ClearConsoleRepeat:
        print newLine
    Loop ClearConsoleRepeat
    Popear
endm

ConcatenateRows macro string
    local Row1, Row2, Row3, Row4, Row5, Row6, Row7, Row8, Row9
    local RepeatRow1, RepeatRow2, RepeatRow3, RepeatRow4, RepeatRow5, RepeatRow6, RepeatRow7, RepeatRow8, RepeatRow9
    local EndGC
    Pushear
    xor si, si    
    xor cx, cx    
    Row9:     
        xor di, di   
        mov cx, 0bh
        RepeatRow9:
            moveCursor 01h, 00h
            print repeatMsg9
            getChar
            mov al, fileContent9[di]
            mov string[si], al
            inc si
            inc di
        Loop RepeatRow9
    Row8:
        xor di, di
        mov cx, 0bh
        RepeatRow8:
            moveCursor 01h, 00h
            print repeatMsg8
            getChar            
            mov al, fileContent8[di]
            mov string[si], al
            inc si
            inc di
        Loop RepeatRow8
    Row7:
        xor di, di
        mov cx, 0bh
        RepeatRow7:
            moveCursor 01h, 00h
            print repeatMsg7
            getChar            
            mov al, fileContent7[di]
            mov string[si], al
            inc si
            inc di
        Loop RepeatRow7
    Row6:
        xor di, di
        mov cx, 0bh
        RepeatRow6:
            moveCursor 01h, 00h
            print repeatMsg6
            getChar            
            mov al, fileContent6[di]
            mov string[si], al
            inc si
            inc di
        Loop RepeatRow6
    Row5:
        xor di, di
        mov cx, 0bh
        RepeatRow5:
            moveCursor 01h, 00h
            print repeatMsg5
            getChar            
            mov al, fileContent5[di]
            mov string[si], al
            inc si
            inc di
        Loop RepeatRow5
    Row4:
        xor di, di
        mov cx, 0bh
        RepeatRow4:
            moveCursor 01h, 00h
            print repeatMsg4
            getChar           
            mov al, fileContent4[di] 
            mov string[si], al
            inc si
            inc di
        Loop RepeatRow4
    Row3:
        xor di, di
        mov cx, 0bh
        RepeatRow3:
            moveCursor 01h, 00h
            print repeatMsg3
            getChar            
            mov al, fileContent3[di]
            mov string[si], al
            inc si
            inc di
        Loop RepeatRow3
    Row2:
        xor di, di
        mov cx, 0bh
        RepeatRow2:
            moveCursor 01h, 00h
            print repeatMsg2
            getChar            
            mov al, fileContent2[di]
            mov string[si], al
            inc si
            inc di
        Loop RepeatRow2
    Row1:
        xor di, di
        mov cx, 0bh
        RepeatRow1:
            moveCursor 01h, 00h
            print repeatMsg1
            getChar            
            mov al, fileContent1[di]
            mov string[si], al
            inc si
            inc di
        Loop RepeatRow1
    EndGC:
        Popear
endm

AnalizeText macro string, Prow, Pcolumn
    local Row1, Row2, Row3, Row4, Row5, Row6, Row7, Row8, Row9
    local RepeatRow1, RepeatRow2, RepeatRow3, RepeatRow4, RepeatRow5, RepeatRow6, RepeatRow7, RepeatRow8, RepeatRow9
    local EndGC
    Pushear    
    ; For the file 
    xor si, si    
    
    xor cx, cx
    ; Initializing the values of the row and column (Position in the table) to Move the cursor and print somethin
    mov Prow, 02h
    mov Pcolumn, 03h
    Row9:
        ; Repeat 11 times the reading of the file
        mov cx, 0bh
        ; For the content of the file that we generate
        xor di, di
        RepeatRow9:
            
                mov al, string[si]

                cmp al, '42h'
                    je PrintBlackCoinRow9
                
                cmp al, '57h'
                    je PrintWhiteCoinRow9
                ReturnRepeat9:
                    add Pcolumn, 05h
                    inc di
                    inc si
        Loop RepeatRow9        
            
        add Prow, 02h
        mov Pcolumn, 03h
        jmp Row8

        PrintBlackCoinRow9:
            ; Put the coin in the console
            moveCursor Prow, Pcolumn            
            print blackCoin

            ; Put the coin in the content that we save
            mov fileContent9[di], '42h'

            jmp ReturnRepeat9
        PrintWhiteCoinRow9:
                ; Put the coin in the console
                moveCursor Prow, Pcolumn            
                print whiteCoin

                ; Put the coin in the content that we save
                mov fileContent9[di], '57h'
                jmp ReturnRepeat9
    Row8:
        ; Repeat 11 times the reading of the file
        mov cx, 0bh
        ; For the content of the file that we generate
        xor di, di

        RepeatRow8:            
                
                mov al, string[si]

                cmp al, '42h'
                    je PrintBlackCoinRow8
                
                cmp al, '57h'
                    je PrintWhiteCoinRow8                
                ReturnRepeat8:
                    add Pcolumn, 05h
                    inc di
                    inc si
        Loop RepeatRow8
        
        add Prow, 02h
        mov Pcolumn, 03h
        jmp Row7

        PrintBlackCoinRow8:
            ; Put the coin in the console
            moveCursor Prow, Pcolumn            
            print blackCoin

            ; Put the coin in the content that we save
            mov fileContent8[di], '42h'

            jmp ReturnRepeat8
        PrintWhiteCoinRow8:
            ; Put the coin in the console
            moveCursor Prow, Pcolumn            
            print whiteCoin

            ; Put the coin in the content that we save
            mov fileContent8[di], '57h'
            jmp ReturnRepeat8
    Row7:
        ; Repeat 11 times the reading of the file
        mov cx, 0bh
        ; For the content of the file that we generate
        xor di, di

        RepeatRow7:
            
            mov al, string[si]

            cmp al, '42h'
                je PrintBlackCoinRow7
            
            cmp al, '57h'
                je PrintWhiteCoinRow7
            ReturnRepeat7:
                add Pcolumn, 05h
                inc di
                inc si
        Loop RepeatRow7
        
        add Prow, 02h
        mov Pcolumn, 03h
        jmp Row6

        PrintBlackCoinRow7:
            ; Put the coin in the console
            moveCursor Prow, Pcolumn            
            print blackCoin

            ; Put the coin in the content that we save
            mov fileContent7[di], '42h'

            jmp ReturnRepeat7
        PrintWhiteCoinRow7:
            ; Put the coin in the console
            moveCursor Prow, Pcolumn            
            print whiteCoin

            ; Put the coin in the content that we save
            mov fileContent7[di], '57h'
            jmp ReturnRepeat7
    Row6:
        ; Repeat 11 times the reading of the file
        mov cx, 0bh
        ; For the content of the file that we generate
        xor di, di

        RepeatRow6:            
            
            mov al, string[si]

            cmp al, '42h'
                je PrintBlackCoinRow6
            
            cmp al, '57h'
                je PrintWhiteCoinRow6
            ReturnRepeat6:
                add Pcolumn, 05h
                inc di
                inc si
        Loop RepeatRow6
        
        add Prow, 02h
        mov Pcolumn, 03h
        jmp Row5

        PrintBlackCoinRow6:
            ; Put the coin in the console
            moveCursor Prow, Pcolumn            
            print blackCoin

            ; Put the coin in the content that we save
            mov fileContent6[di], '42h'

            jmp ReturnRepeat6
        PrintWhiteCoinRow6:
            ; Put the coin in the console
            moveCursor Prow, Pcolumn            
            print whiteCoin

            ; Put the coin in the content that we save
            mov fileContent6[di], '57h'
            jmp ReturnRepeat6
    Row5:
        ; Repeat 11 times the reading of the file
        mov cx, 0bh
        ; For the content of the file that we generate
        xor di, di

        RepeatRow5:

            
                mov al, string[si]

                cmp al, '42h'
                    je PrintBlackCoinRow5
                
                cmp al, '57h'
                    je PrintWhiteCoinRow5
                ReturnRepeat5:
                    add Pcolumn, 05h
                    inc di
                    inc si
            Loop RepeatRow5
        
        add Prow, 02h
        mov Pcolumn, 03h
        jmp Row4

        PrintBlackCoinRow5:
            ; Put the coin in the console
            moveCursor Prow, Pcolumn            
            print blackCoin

            ; Put the coin in the content that we save
            mov fileContent5[di], '42h'

            jmp ReturnRepeat5
        PrintWhiteCoinRow5:
            ; Put the coin in the console
            moveCursor Prow, Pcolumn            
            print whiteCoin

            ; Put the coin in the content that we save
            mov fileContent5[di], '57h'
            jmp ReturnRepeat5
    Row4:
        ; Repeat 11 times the reading of the file
        mov cx, 0bh
        ; For the content of the file that we generate
        xor di, di

        RepeatRow4:
            
                mov al, string[si]

                cmp al, '42h'
                    je PrintBlackCoinRow4
                
                cmp al, '57h'
                    je PrintWhiteCoinRow4
                ReturnRepeat4:
                    add Pcolumn, 05h
                    inc di
                    inc si
        Loop RepeatRow4
        
        add Prow, 02h
        mov Pcolumn, 03h
        jmp Row3

        PrintBlackCoinRow4:
            ; Put the coin in the console
            moveCursor Prow, Pcolumn            
            print blackCoin

            ; Put the coin in the content that we save
            mov fileContent4[di], '42h'

            jmp ReturnRepeat4
        PrintWhiteCoinRow4:
            ; Put the coin in the console
            moveCursor Prow, Pcolumn            
            print whiteCoin

            ; Put the coin in the content that we save
            mov fileContent4[di], '57h'
            jmp ReturnRepeat4
    Row3:
        ; Repeat 11 times the reading of the file
        mov cx, 0bh
        ; For the content of the file that we generate
        xor di, di

        RepeatRow3:

            
                mov al, string[si]

                cmp al, '42h'
                    je PrintBlackCoinRow3
                
                cmp al, '57h'
                    je PrintWhiteCoinRow3
                ReturnRepeat3:
                    add Pcolumn, 05h
                    inc di
                    inc si
        Loop RepeatRow3

        add Prow, 02h
        mov Pcolumn, 03h
        jmp Row2

        PrintBlackCoinRow3:
            ; Put the coin in the console
            moveCursor Prow, Pcolumn            
            print blackCoin

            ; Put the coin in the content that we save
            mov fileContent3[di], '42h'

            jmp ReturnRepeat9
        PrintWhiteCoinRow3:
            ; Put the coin in the console
            moveCursor Prow, Pcolumn            
            print whiteCoin

            ; Put the coin in the content that we save
            mov fileContent3[di], '57h'
            jmp ReturnRepeat3
    Row2:
        ; Repeat 11 times the reading of the file
        mov cx, 0bh
        ; For the content of the file that we generate
        xor di, di

        RepeatRow2:

            
                mov al, string[si]

                cmp al, '42h'
                    je PrintBlackCoinRow2
                
                cmp al, '57h'
                    je PrintWhiteCoinRow2
                ReturnRepeat2:
                    add Pcolumn, 05h
                    inc di
                    inc si
        Loop RepeatRow2
        
        add Prow, 02h
        mov Pcolumn, 03h
        jmp Row1

        PrintBlackCoinRow2:
            ; Put the coin in the console
            moveCursor Prow, Pcolumn            
            print blackCoin

            ; Put the coin in the content that we save
            mov fileContent2[di], '42h'

            jmp ReturnRepeat2
        PrintWhiteCoinRow2:
            ; Put the coin in the console
            moveCursor Prow, Pcolumn            
            print whiteCoin

            ; Put the coin in the content that we save
            mov fileContent2[di], '57h'
            jmp ReturnRepeat2
    Row1:
        ; Repeat 11 times the reading of the file
        mov cx, 0bh
        ; For the content of the file that we generate
        xor di, di

        RepeatRow1:

            
                mov al, string[si]

                cmp al, '42h'
                    je PrintBlackCoinRow1
                
                cmp al, '57h'
                    je PrintWhiteCoinRow1
                ReturnRepeat1:
                    add Pcolumn, 05h
                    inc di
                    inc si
            Loop RepeatRow1
        
        jmp EndGC

        PrintBlackCoinRow1:
            ; Put the coin in the console
            moveCursor Prow, Pcolumn            
            print blackCoin

            ; Put the coin in the content that we save
            mov fileContent1[di], '42h'

            jmp ReturnRepeat1
        PrintWhiteCoinRow1:
            ; Put the coin in the console
            moveCursor Prow, Pcolumn            
            print whiteCoin

            ; Put the coin in the content that we save
            mov fileContent1[di], '57h'
            jmp ReturnRepeat1    
    EndGC:
        Popear
endm

AnalizeRow macro string, Prow

endm

;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
;\\\\\\\\\\\\\\\\     FILES     \\\\\\\\\\\\\\\\\\\\\\
;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

; RESET FILE CONTENT
resetFileContent macro

endm


; GET ROUTE OF A FILE
getRoute macro string
    local getCharacter, EndGC, Backspace
    Pushear
    xor si, si
    getCharacter:
        getChar
        ; If al == \n
        cmp al, 0dh
            je EndGC
        ; If al == \b
        cmp al, 08h
            je Backspace
        ; else
        mov string[si], al
        inc si
        jmp getCharacter
    Backspace:
        mov al, 24h
        dec si
        mov string[si], al
        jmp getCharacter
    EndGC:        
        mov al, 00h
        mov string[si], al
        Popear
endm

; OPEN FILE
OpenFile macro route, handler
    Pushear
    mov ah, 3dh
    mov al, 00h
    lea dx, route
    int 21h
    ; JUMP IF AN ERROR OCCURRED WHILE OPENING THE FILE
    jc OpenError
    mov handler, ax
    Popear
endm

; CLOSE FILE
CloseFile macro handler
    mov ah, 3eh
    mov bx, handler
    int 21h
    ; JUMP IF THE FILE DOESNT CLOSE FINE
    jc CloseError
endm

; CREATE FILE
CreateFile macro string, handler
    mov ah, 3ch
    mov cx, 00h
    lea dx, string
    int 21h
    ; JUMP IF AN ERROR OCCURS WHILE CREATING THE FILE
    jc CreateError
    mov handler, ax
endm

; WRITE ON FILE
WriteOnFile macro handler, info, numBytes
    mov ah, 40h
    mov bx, handler
    mov cx, numBytes
    lea dx, info
    int 21h
    ; JUMP IF AN ERROR OCCURS DURING WRITING IN THE FILE
    jc WriteError
endm

; READ FILE
ReadFile macro handler, info, numBytes    
    mov ah, 3fh
    mov bx, handler
    mov cx, numBytes
    lea dx, info
    int 21h    
    jc ReadError
endm

;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
;\\\\\\\\\\\\\\\\\\\\\ GET DATE \\\\\\\\\\\\\\\\\\\\\
;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

; PRINCIPAL MACRO FOR DATE AND HOUR
getDateAndHour macro stringDate
    
    Pushear
    xor si, si

    getDate
    ; DL = DAY. DH = MONTH

    NumberToString stringDate, dl ; NUMBER -> STRING. DAY

    mov stringDate[si], 2fh ; /
    inc si

    NumberToString stringDate, dh ; NUMBER -> STRING. MONTH

    mov stringDate[si], 2fh ; /
    inc si

    mov stringDate[si], 32h ; 2
    inc si

    mov stringDate[si], 30h ; 0
    inc si

    mov stringDate[si], 32h ; 2
    inc si

    mov stringDate[si], 30h ; 0
    inc si

    mov stringDate[si],20h
	inc si
	mov stringDate[si],20h
	inc si

    getHour
    ; CH = HOUR. CL = MINUTES.
    
    NumberToString stringDate, ch ; NUMBER -> STRING. HOUR

    mov stringDate[si],3ah ; :
	inc si

    NumberToString stringDate, cl ; NUMBER -> STRING. MINUTES

    mov stringDate[si],3ah ; :
	inc si

    NumberToString stringDate, dh ; NUMBER -> STRING. SECONDS

    Popear
endm

NumberToString macro string, numberToConvert
    Push ax
    Push bx

    xor ax, ax
    xor bx, bx
    mov bl, 0ah
    mov al, numberToConvert
    div bl

    getNumber string, al
    getNumber string, ah

    Pop ax
    Pop bx
endm

getNumber macro string, numberToConvert
    local zero, one, two, three, four, five, six, seven, eight, nine
    local EndGC

    cmp numberToConvert, 00h
	    je zero
	cmp numberToConvert, 01h
	    je one
	cmp numberToConvert, 02h
	    je two
	cmp numberToConvert, 03h
	    je three
	cmp numberToConvert, 04h
	    je four
	cmp numberToConvert, 05h
	    je five
	cmp numberToConvert, 06h
	    je six
	cmp numberToConvert, 07h
	    je seven
	cmp numberToConvert, 08h
	    je eight
	cmp numberToConvert, 09h
	    je nine
	jmp EndGC

	zero:
		mov string[si], 30h
		inc si
		jmp EndGC
	one:
		mov string[si], 31h
		inc si
		jmp EndGC
	two:
		mov string[si], 32h
		inc si
		jmp EndGC
	three:
		mov string[si], 33h
		inc si
		jmp EndGC
	four:
		mov string[si], 34h
		inc si
		jmp EndGC
	five:
		mov string[si], 35h
		inc si
		jmp EndGC
	six:
		mov string[si], 36h
		inc si
		jmp EndGC
	seven:
		mov string[si], 37h
		inc si
		jmp EndGC
	eight:
		mov string[si], 38h
		inc si
		jmp EndGC
	nine:
		mov string[si], 39h
		inc si
		jmp EndGC
	EndGC:
endm

; GET DATE
getDate macro 
    mov ah, 2ah
    int 21h
endm

; GET HOUR
getHour macro
    mov ah, 2ch
    int 21h
endm

;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
;\\\\\\\\\\\\\\\\\\ RECOVER THINGS \\\\\\\\\\\\\\\\\\
;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

Pushear macro
    push ax
    push bx
    push cx
    push dx
    push si
    push di
endm

Popear macro                    
    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
endm