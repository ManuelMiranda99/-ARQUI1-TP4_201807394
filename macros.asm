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

; CLEAN ROWS
CleanRows macro
    Clean fileContent9, 09h, 56h
    Clean fileContent8, 09h, 56h
    Clean fileContent7, 09h, 56h
    Clean fileContent6, 09h, 56h
    Clean fileContent5, 09h, 56h
    Clean fileContent4, 09h, 56h
    Clean fileContent3, 09h, 56h
    Clean fileContent2, 09h, 56h
    Clean fileContent1, 09h, 56h
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
PutCoinMacro macro char, coin
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
            CellIsEmpty fileContent1[si], char
            jmp EndGC
        Row2:
            CellIsEmpty fileContent2[si], char
            jmp EndGC
        Row3:
            CellIsEmpty fileContent3[si], char
            jmp EndGC
        Row4:
            CellIsEmpty fileContent4[si], char
            jmp EndGC
        Row5:
            CellIsEmpty fileContent5[si], char
            jmp EndGC
        Row6:
            CellIsEmpty fileContent6[si], char
            jmp EndGC
        Row7:
            CellIsEmpty fileContent7[si], char
            jmp EndGC
        Row8:
            CellIsEmpty fileContent8[si], char
            jmp EndGC
        Row9:
            CellIsEmpty fileContent9[si], char
            jmp EndGC
    
    EndGC:
        PrintCoin coin
        Popear        
endm

CellIsEmpty macro string, char
    local PutChar
    cmp string, 56h
        je PutChar
    jmp invalidCellM
    PutChar:
        mov string, char
endm

CheckLiberties macro

endm

PrintCoin macro coin
    moveCursor row, column
    print coin
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
            mov al, fileContent9[di]
            mov string[si], al
            inc si
            inc di
        Loop RepeatRow9
    Row8:
        xor di, di
        mov cx, 0bh
        RepeatRow8:
            mov al, fileContent8[di]
            mov string[si], al
            inc si
            inc di
        Loop RepeatRow8
    Row7:
        xor di, di
        mov cx, 0bh
        RepeatRow7:
            mov al, fileContent7[di]
            mov string[si], al
            inc si
            inc di
        Loop RepeatRow7
    Row6:
        xor di, di
        mov cx, 0bh
        RepeatRow6:
            mov al, fileContent6[di]
            mov string[si], al
            inc si
            inc di
        Loop RepeatRow6
    Row5:
        xor di, di
        mov cx, 0bh
        RepeatRow5:
            mov al, fileContent5[di]
            mov string[si], al
            inc si
            inc di
        Loop RepeatRow5
    Row4:
        xor di, di
        mov cx, 0bh
        RepeatRow4:
            mov al, fileContent4[di] 
            mov string[si], al
            inc si
            inc di
        Loop RepeatRow4
    Row3:
        xor di, di
        mov cx, 0bh
        RepeatRow3:
            mov al, fileContent3[di]
            mov string[si], al
            inc si
            inc di
        Loop RepeatRow3
    Row2:
        xor di, di
        mov cx, 0bh
        RepeatRow2:
            mov al, fileContent2[di]
            mov string[si], al
            inc si
            inc di
        Loop RepeatRow2
    Row1:
        xor di, di
        mov cx, 0bh
        RepeatRow1:
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

                cmp al, 42h
                    je PrintBlackCoinRow9
                
                cmp al, 57h
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
            mov fileContent9[di], 42h

            jmp ReturnRepeat9
        PrintWhiteCoinRow9:
                ; Put the coin in the console
                moveCursor Prow, Pcolumn            
                print whiteCoin

                ; Put the coin in the content that we save
                mov fileContent9[di], 57h
                jmp ReturnRepeat9
    Row8:
        ; Repeat 11 times the reading of the file
        mov cx, 0bh
        ; For the content of the file that we generate
        xor di, di

        RepeatRow8:            
                
                mov al, string[si]

                cmp al, 42h
                    je PrintBlackCoinRow8
                
                cmp al, 57h
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
            mov fileContent8[di], 42h

            jmp ReturnRepeat8
        PrintWhiteCoinRow8:
            ; Put the coin in the console
            moveCursor Prow, Pcolumn            
            print whiteCoin

            ; Put the coin in the content that we save
            mov fileContent8[di], 57h
            jmp ReturnRepeat8
    Row7:
        ; Repeat 11 times the reading of the file
        mov cx, 0bh
        ; For the content of the file that we generate
        xor di, di

        RepeatRow7:
            
            mov al, string[si]

            cmp al, 42h
                je PrintBlackCoinRow7
            
            cmp al, 57h
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
            mov fileContent7[di], 42h

            jmp ReturnRepeat7
        PrintWhiteCoinRow7:
            ; Put the coin in the console
            moveCursor Prow, Pcolumn            
            print whiteCoin

            ; Put the coin in the content that we save
            mov fileContent7[di], 57h
            jmp ReturnRepeat7
    Row6:
        ; Repeat 11 times the reading of the file
        mov cx, 0bh
        ; For the content of the file that we generate
        xor di, di

        RepeatRow6:            
            
            mov al, string[si]

            cmp al, 42h
                je PrintBlackCoinRow6
            
            cmp al, 57h
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
            mov fileContent6[di], 42h

            jmp ReturnRepeat6
        PrintWhiteCoinRow6:
            ; Put the coin in the console
            moveCursor Prow, Pcolumn            
            print whiteCoin

            ; Put the coin in the content that we save
            mov fileContent6[di], 57h
            jmp ReturnRepeat6
    Row5:
        ; Repeat 11 times the reading of the file
        mov cx, 0bh
        ; For the content of the file that we generate
        xor di, di

        RepeatRow5:

            
                mov al, string[si]

                cmp al, 42h
                    je PrintBlackCoinRow5
                
                cmp al, 57h
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
            mov fileContent5[di], 42h

            jmp ReturnRepeat5
        PrintWhiteCoinRow5:
            ; Put the coin in the console
            moveCursor Prow, Pcolumn            
            print whiteCoin

            ; Put the coin in the content that we save
            mov fileContent5[di], 57h
            jmp ReturnRepeat5
    Row4:
        ; Repeat 11 times the reading of the file
        mov cx, 0bh
        ; For the content of the file that we generate
        xor di, di

        RepeatRow4:
            
                mov al, string[si]

                cmp al, 42h
                    je PrintBlackCoinRow4
                
                cmp al, 57h
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
            mov fileContent4[di], 42h

            jmp ReturnRepeat4
        PrintWhiteCoinRow4:
            ; Put the coin in the console
            moveCursor Prow, Pcolumn            
            print whiteCoin

            ; Put the coin in the content that we save
            mov fileContent4[di], 57h
            jmp ReturnRepeat4
    Row3:
        ; Repeat 11 times the reading of the file
        mov cx, 0bh
        ; For the content of the file that we generate
        xor di, di

        RepeatRow3:

            
                mov al, string[si]

                cmp al, 42h
                    je PrintBlackCoinRow3
                
                cmp al, 57h
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
            mov fileContent3[di], 42h

            jmp ReturnRepeat3
        PrintWhiteCoinRow3:
            ; Put the coin in the console
            moveCursor Prow, Pcolumn            
            print whiteCoin

            ; Put the coin in the content that we save
            mov fileContent3[di], 57h
            jmp ReturnRepeat3
    Row2:
        ; Repeat 11 times the reading of the file
        mov cx, 0bh
        ; For the content of the file that we generate
        xor di, di

        RepeatRow2:

            
                mov al, string[si]

                cmp al, 42h
                    je PrintBlackCoinRow2
                
                cmp al, 57h
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
            mov fileContent2[di], 42h

            jmp ReturnRepeat2
        PrintWhiteCoinRow2:
            ; Put the coin in the console
            moveCursor Prow, Pcolumn            
            print whiteCoin

            ; Put the coin in the content that we save
            mov fileContent2[di], 57h
            jmp ReturnRepeat2
    Row1:
        ; Repeat 11 times the reading of the file
        mov cx, 0bh
        ; For the content of the file that we generate
        xor di, di

        RepeatRow1:

            
                mov al, string[si]

                cmp al, 42h
                    je PrintBlackCoinRow1
                
                cmp al, 57h
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
            mov fileContent1[di], 42h

            jmp ReturnRepeat1
        PrintWhiteCoinRow1:
            ; Put the coin in the console
            moveCursor Prow, Pcolumn            
            print whiteCoin

            ; Put the coin in the content that we save
            mov fileContent1[di], 57h
            jmp ReturnRepeat1    
    EndGC:
        Popear
endm

;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
;\\\\\\\\\\\\\\\\\     HTML    \\\\\\\\\\\\\\\\\\\\\\\
;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

    ; Generate HTML
    GenerateHTML macro  
        local RepeatHTMLHeader1, RepeatHTMLHeader2, RepeatHTMLDate, RepeatHTMLEnd

        Pushear

        ; For the htmlContent
        xor si, si    
        ; HTML HEADER
            mov cx, SIZEOF htmlHeader1
            ; For the htmlHeader1
            xor di, di
            RepeatHTMLHeader1:
                mov al, htmlHeader1[di]
                inc di
                mov htmlContent[si], al
                inc si
            Loop RepeatHTMLHeader1        

            ; For the date
            mov cx, SIZEOF date
            ; For the date
            xor di, di
            RepeatHTMLDate:
                mov al, date[di]
                inc di
                mov htmlContent[si], al
                inc si
            Loop RepeatHTMLDate

            mov cx, SIZEOF htmlHeader2
            ; For the htmlHeader2
            xor di, di
            RepeatHTMLHeader2:
                mov al, htmlHeader2[di]
                inc di
                mov htmlContent[si], al
                inc si
            Loop RepeatHTMLHeader2 

        ; Beggining of Row 9

            RepeatRow htmlContent, fileContent9

        ; Beggining of Row 8
            
            RepeatRow htmlContent, fileContent8
        ; Beggining of Row 7
        
            RepeatRow htmlContent, fileContent7
        ; Beggining of Row 6
            
            RepeatRow htmlContent, fileContent6
        ; Beggining of Row 5

            RepeatRow htmlContent, fileContent5
        ; Beggining of Row 4

            RepeatRow htmlContent, fileContent4
        ; Beggining of Row 3

            RepeatRow htmlContent, fileContent3
        ; Beggining of Row 2

            RepeatRow htmlContent, fileContent2
        ; Beggining of Row 1

            RepeatRow htmlContent, fileContent1

        ; HTML END
            mov cx, SIZEOF htmlEnd
            ; For the End
            xor di, di        
            RepeatHTMLEnd:
                mov al, htmlEnd[di]
                inc di
                mov htmlContent[si], al
                inc si
            Loop RepeatHTMLEnd        

        Popear

    endm

    ;htmlBeginRow db '<tr>'

    ;htmlEndRow db '</tr>'    

    RepeatRow macro stringHtml, fileContentX
        local RepeatHTMLRow1, RepeatHTMLRow2, RepeatAnalize, ReturnAnalize, PNormalCell, PWhiteCell, PBlackCell
        local ReturnC1, ReturnC2, ReturnC3, ReturnC4, ReturnC5, ReturnC6, ReturnC7, ReturnC8, ReturnC9
        local NormalC1, WhiteC1, BlackC1, NormalTC1, WhiteTC1, BlackTC1
        local NormalC2, WhiteC2, BlackC2, NormalTC2, WhiteTC2, BlackTC2
        local NormalC3, WhiteC3, BlackC3, NormalTC3, WhiteTC3, BlackTC3
        local NormalC4, WhiteC4, BlackC4, NormalTC4, WhiteTC4, BlackTC4
        local NormalC5, WhiteC5, BlackC5, NormalTC5, WhiteTC5, BlackTC5
        local NormalC6, WhiteC6, BlackC6, NormalTC6, WhiteTC6, BlackTC6
        local NormalC7, WhiteC7, BlackC7, NormalTC7, WhiteTC7, BlackTC7
        local NormalC8, WhiteC8, BlackC8, NormalTC8, WhiteTC8, BlackTC8
        local NormalC9, WhiteC9, BlackC9, NormalTC9, WhiteTC9, BlackTC9
        local Fin
        mov cx, SIZEOF htmlBeginRow
        xor di, di
        RepeatHTMLRow1:
            mov al, htmlBeginRow[di]
            inc di
            mov stringHtml[si], al
            inc si
        Loop RepeatHTMLRow1

        ; ANALIZE fileContentX
        ; COLUMN 1
            ; Empty Cell
            cmp fileContentX[00h], 56h
                je NormalC1
            ; White Coin
            cmp fileContentX[00h], 57h
                je WhiteC1
            ; Black Coin
            cmp fileContentX[00h], 42h
                je BlackC1
            ; Neutral Territory
            cmp fileContentX[00h], 55h
                je NormalTC1
            ; White Territory
            cmp fileContentX[00h], 58h
                je WhiteTC1
            ; Black Territory
            cmp fileContentX[00h], 43h
                je BlackTC1

            NormalC1:
                NormalCell stringHtml
                jmp ReturnC1

            WhiteC1:
                WhiteCell stringHtml
                jmp ReturnC1

            BlackC1:
                BlackCell stringHtml
                jmp ReturnC1

            NormalTC1:
                NormalTCell stringHtml
                jmp ReturnC1

            WhiteTC1:
                WhiteTCell stringHtml
                jmp ReturnC1

            BlackTC1:
                BlackTCell stringHtml
                jmp ReturnC1

        ReturnC1:
        ; COLUMN 2
            ; Empty Cell
            cmp fileContentX[01h], 56h
                je NormalC2
            ; White Coin
            cmp fileContentX[01h], 57h
                je WhiteC2
            ; Black Coin
            cmp fileContentX[01h], 42h
                je BlackC2
            ; Neutral Territory
            cmp fileContentX[01h], 55h
                je NormalTC2
            ; White Territory
            cmp fileContentX[01h], 58h
                je WhiteTC2
            ; Black Territory
            cmp fileContentX[01h], 43h
                je BlackTC2

            NormalC2:
                NormalCell stringHtml
                jmp ReturnC2

            WhiteC2:
                WhiteCell stringHtml
                jmp ReturnC2

            BlackC2:
                BlackCell stringHtml
                jmp ReturnC2

            NormalTC2:
                NormalTCell stringHtml
                jmp ReturnC2

            WhiteTC2:
                WhiteTCell stringHtml
                jmp ReturnC2

            BlackTC2:
                BlackTCell stringHtml
                jmp ReturnC2

        ReturnC2:
        ; COLUMN 3
            ; Empty Cell
            cmp fileContentX[02h], 56h
                je NormalC3
            ; White Coin
            cmp fileContentX[02h], 57h
                je WhiteC3
            ; Black Coin
            cmp fileContentX[02h], 42h
                je BlackC3
            ; Neutral Territory
            cmp fileContentX[02h], 55h
                je NormalTC3
            ; White Territory
            cmp fileContentX[02h], 58h
                je WhiteTC3
            ; Black Territory
            cmp fileContentX[02h], 43h
                je BlackTC3

            NormalC3:
                NormalCell stringHtml
                jmp ReturnC3

            WhiteC3:
                WhiteCell stringHtml
                jmp ReturnC3

            BlackC3:
                BlackCell stringHtml
                jmp ReturnC3

            NormalTC3:
                NormalTCell stringHtml
                jmp ReturnC3

            WhiteTC3:
                WhiteTCell stringHtml
                jmp ReturnC3

            BlackTC3:
                BlackTCell stringHtml
                jmp ReturnC3

        ReturnC3:
        ; COLUMN 4
            ; Empty Cell
            cmp fileContentX[03h], 56h
                je NormalC4
            ; White Coin
            cmp fileContentX[03h], 57h
                je WhiteC4
            ; Black Coin
            cmp fileContentX[03h], 42h
                je BlackC4
            ; Neutral Territory
            cmp fileContentX[03h], 55h
                je NormalTC4
            ; White Territory
            cmp fileContentX[03h], 58h
                je WhiteTC4
            ; Black Territory
            cmp fileContentX[03h], 43h
                je BlackTC4

            NormalC4:
                NormalCell stringHtml
                jmp ReturnC4

            WhiteC4:
                WhiteCell stringHtml
                jmp ReturnC4

            BlackC4:
                BlackCell stringHtml
                jmp ReturnC4

            NormalTC4:
                NormalTCell stringHtml
                jmp ReturnC4

            WhiteTC4:
                WhiteTCell stringHtml
                jmp ReturnC4

            BlackTC4:
                BlackTCell stringHtml
                jmp ReturnC4

        ReturnC4:
        ; COLUMN 5
            ; Empty Cell
            cmp fileContentX[04h], 56h
                je NormalC5
            ; White Coin
            cmp fileContentX[04h], 57h
                je WhiteC5
            ; Black Coin
            cmp fileContentX[04h], 42h
                je BlackC5
            ; Neutral Territory
            cmp fileContentX[04h], 55h
                je NormalTC5
            ; White Territory
            cmp fileContentX[04h], 58h
                je WhiteTC5
            ; Black Territory
            cmp fileContentX[04h], 43h
                je BlackTC5

            NormalC5:
                NormalCell stringHtml
                jmp ReturnC5

            WhiteC5:
                WhiteCell stringHtml
                jmp ReturnC5

            BlackC5:
                BlackCell stringHtml
                jmp ReturnC5

            NormalTC5:
                NormalTCell stringHtml
                jmp ReturnC5

            WhiteTC5:
                WhiteTCell stringHtml
                jmp ReturnC5

            BlackTC5:
                BlackTCell stringHtml
                jmp ReturnC5

        ReturnC5:
        ; COLUMN 6
            ; Empty Cell
            cmp fileContentX[05h], 56h
                je NormalC6
            ; White Coin
            cmp fileContentX[05h], 57h
                je WhiteC6
            ; Black Coin
            cmp fileContentX[05h], 42h
                je BlackC6
            ; Neutral Territory
            cmp fileContentX[05h], 55h
                je NormalTC6
            ; White Territory
            cmp fileContentX[05h], 58h
                je WhiteTC6
            ; Black Territory
            cmp fileContentX[05h], 43h
                je BlackTC6

            NormalC6:
                NormalCell stringHtml
                jmp ReturnC6

            WhiteC6:
                WhiteCell stringHtml
                jmp ReturnC6

            BlackC6:
                BlackCell stringHtml
                jmp ReturnC6

            NormalTC6:
                NormalTCell stringHtml
                jmp ReturnC6

            WhiteTC6:
                WhiteTCell stringHtml
                jmp ReturnC6

            BlackTC6:
                BlackTCell stringHtml
                jmp ReturnC6

        ReturnC6:
        ; COLUMN 7
            ; Empty Cell
            cmp fileContentX[06h], 56h
                je NormalC7
            ; White Coin
            cmp fileContentX[06h], 57h
                je WhiteC7
            ; Black Coin
            cmp fileContentX[06h], 42h
                je BlackC7
            ; Neutral Territory
            cmp fileContentX[06h], 55h
                je NormalTC7
            ; White Territory
            cmp fileContentX[06h], 58h
                je WhiteTC7
            ; Black Territory
            cmp fileContentX[06h], 43h
                je BlackTC7

            NormalC7:
                NormalCell stringHtml
                jmp ReturnC7

            WhiteC7:
                WhiteCell stringHtml
                jmp ReturnC7

            BlackC7:
                BlackCell stringHtml
                jmp ReturnC7

            NormalTC7:
                NormalTCell stringHtml
                jmp ReturnC7

            WhiteTC7:
                WhiteTCell stringHtml
                jmp ReturnC7

            BlackTC7:
                BlackTCell stringHtml
                jmp ReturnC7

        ReturnC7:
        ; COLUMN 8
            ; Empty Cell
            cmp fileContentX[07h], 56h
                je NormalC8
            ; White Coin
            cmp fileContentX[07h], 57h
                je WhiteC8
            ; Black Coin
            cmp fileContentX[07h], 42h
                je BlackC8
            ; Neutral Territory
            cmp fileContentX[07h], 55h
                je NormalTC8
            ; White Territory
            cmp fileContentX[07h], 58h
                je WhiteTC8
            ; Black Territory
            cmp fileContentX[07h], 43h
                je BlackTC8

            NormalC8:
                NormalCell stringHtml
                jmp ReturnC8

            WhiteC8:
                WhiteCell stringHtml
                jmp ReturnC8

            BlackC8:
                BlackCell stringHtml
                jmp ReturnC8

            NormalTC8:
                NormalTCell stringHtml
                jmp ReturnC8

            WhiteTC8:
                WhiteTCell stringHtml
                jmp ReturnC8

            BlackTC8:
                BlackTCell stringHtml
                jmp ReturnC8

        ReturnC8:
        ; COLUMN 9
            ; Empty Cell
            cmp fileContentX[09h], 56h
                je NormalC9
            ; White Coin
            cmp fileContentX[09h], 57h
                je WhiteC9
            ; Black Coin
            cmp fileContentX[09h], 42h
                je BlackC9
            ; Neutral Territory
            cmp fileContentX[09h], 55h
                je NormalTC9
            ; White Territory
            cmp fileContentX[09h], 58h
                je WhiteTC9
            ; Black Territory
            cmp fileContentX[09h], 43h
                je BlackTC9

            NormalC9:
                NormalCell stringHtml
                jmp ReturnC9

            WhiteC9:
                WhiteCell stringHtml
                jmp ReturnC9

            BlackC9:
                BlackCell stringHtml
                jmp ReturnC9

            NormalTC9:
                NormalTCell stringHtml
                jmp ReturnC9

            WhiteTC9:
                WhiteTCell stringHtml
                jmp ReturnC9

            BlackTC9:
                BlackTCell stringHtml
                jmp ReturnC9

        ReturnC9:

        mov cx, SIZEOF htmlEndRow
        xor di, di
        
        RepeatHTMLRow2:
            mov al, htmlEndRow[di]
            inc di
            mov stringHtml[si], al
            inc si
        Loop RepeatHTMLRow2

    endm

    ; NORMAL
        ;htmlNormalCell db '<td></td>'

        ;htmlWhiteCell db '<td><img src="white.png"></td>'

        ;htmlBlackCell db '<td><img src="black.png"></td>'
        NormalCell macro stringHtml
            local RepeatNormal

            mov cx, SIZEOF htmlNormalCell
            xor di, di

            RepeatNormal:
                mov al, htmlNormalCell[di]
                inc di
                mov stringHtml[si], al
                inc si
            Loop RepeatNormal

        endm

        WhiteCell macro stringHtml
            local RepeatWhite

            mov cx, SIZEOF htmlWhiteCell
            xor di, di

            RepeatWhite:
                mov al, htmlWhiteCell[di]
                inc di
                mov stringHtml[si], al
                inc si
            Loop RepeatWhite

        endm

        BlackCell macro stringHtml
            local RepeatBlack

            mov cx, SIZEOF htmlBlackCell
            xor di, di

            RepeatBlack:
                mov al, htmlBlackCell[di]
                inc di
                mov stringHtml[si], al
                inc si
            Loop RepeatBlack

        endm

    ; TERRITORY
        
        ;htmlBlackTCell db '<td><img src="tblack.png"></td>'

        ;htmlWhiteTCell db '<td><img src="twhite.png"></td>'

        ;htmlNeutralTCell db '<td><img src="tneutral.png"></td>'
        NormalTCell macro stringHtml
            local RepeatNeutral

            mov cx, SIZEOF htmlNeutralTCell
            xor di, di

            RepeatNeutral:
                mov al, htmlNeutralTCell[di]
                inc di
                mov stringHtml[si], al
                inc si
            Loop RepeatNeutral
        endm

        WhiteTCell macro stringHtml
            local RepeatWhiteT

            mov cx, SIZEOF htmlWhiteTCell
            xor di, di

            RepeatWhiteT:
                mov al, htmlWhiteTCell[di]
                inc di
                mov stringHtml[si], al
                inc si
            Loop RepeatWhiteT
        endm

        BlackTCell macro stringHtml
            local RepeatBlackT

            mov cx, SIZEOF htmlBlackTCell
            xor di, di

            RepeatBlackT:
                mov al, htmlBlackTCell[di]
                inc di
                mov stringHtml[si], al
                inc si
            Loop RepeatBlackT
        endm

;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
;\\\\\\\\\\\\\\\\     FILES     \\\\\\\\\\\\\\\\\\\\\\
;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

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
        mov al, 020h
        lea dx, route
        int 21h
        mov handler, ax
        ; JUMP IF AN ERROR OCCURRED WHILE OPENING THE FILE
        jc OpenError    
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
        mov handler, ax
        ; JUMP IF AN ERROR OCCURS WHILE CREATING THE FILE
        jc CreateError    
    endm

    ; WRITE ON FILE
    WriteOnFile macro handler, info, numBytes
        PUSH ax
        PUSH bx
        PUSH cx
        PUSh dx
        
        mov ah, 40h
        mov bx, handler
        mov cx, numBytes
        lea dx, info
        int 21h
        ; JUMP IF AN ERROR OCCURS DURING WRITING IN THE FILE
        jc WriteError

        POP dx
        POP cx
        POP bx
        POP ax
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