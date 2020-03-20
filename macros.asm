; FILE THAT CONTAINS ALL THE MACROS FOR THE PROGRAM

; PRINT ON THE SCREEN
print macro string
    mov ax, @data
    mov ds, ax
    mov ah, 09h             ; PRINT
    mov dx, offset string
    int 21h
endm

; GET CHARACTER
getChar macro
    mov ah, 01h
    int 21h
endm

; CLEAN STRING
Clean macro string, numBytes, char
    local RepeatLoop
    xor si, si
    xor cx, cx
    mov cx, numBytes
    RepeatLoop:
        mov string[si], char
        inc si
    Loop RepeatLoop
endm

; GET TEXT UNTIL THE USER WRITE ENTER
getText macro string
    local getCharacter, EndGC, Backspace
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
endm

; GET COMMAND THAT THE USER USE
getCommand macro string, Nrow, Ncolumn, Pstate
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
                    mov Ncolumn, 23h
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

; Move cursor
; The screen in text mode have 25 rows and 80 columns
moveCursor macro row, column
    mov ah, 02h
    mov dh, row
    mov dl, column
    int 10h
endm

; CLEAN CONSOLE
ClearConsole macro
    local ClearConsoleRepeat
    mov dx, 50h
    ClearConsoleRepeat:
        print newLine
    Loop ClearConsoleRepeat
endm

;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
;\\\\\\\\\\\\\\\\     FILES     \\\\\\\\\\\\\\\\\\\\\\
;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

; GET ROUTE OF A FILE
getRoute macro string
    local getCharacter, EndGC, Backspace
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
    EndGC
        mov al, 00h
        mov string[si], al
endm

; OPEN FILE
Open macro route, handler
    mov ah, 3dh
    mov al, 00h
    lea dx, route
    int 21h
    ; JUMP IF AN ERROR OCCURRED WHILE OPENING THE FILE
    ; jc Error de abrir archivo
    mov handler, ax
endm

; CLOSE FILE
Close macro handler
    mov ah, 3eh
    mov bx, handler
    int 21h
    ; JUMP IF THE FILE DOESNT CLOSE FINE
    ; jc No cerro bien
endm

; CREATE FILE
Create macro string, handler
    mov ah, 3ch
    mov cx, 00h
    lea dx, string
    int 21h
    ; JUMP IF AN ERROR OCCURS CREATING THE FILE
    ; jc Error de crear
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
    ; jc Error de escribir
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