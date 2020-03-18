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
getCommand macro Nrow, Ncolumn
    local getCharacter, EndGC, Backspace, Error
    xor Nrow, Nrow
    xor Ncolumn, Ncolumn
    xor si, si

    getCharacter:
        getChar
        ; -------A/a-------
            cmp al, 41h     ; A
                mov Ncolumn, 03h
            cmp al, 61h     ; a
                mov Ncolumn, 03h
        ; -------B/b-------
            cmp al, 42h     ; B
                mov Ncolumn, 08h
            cmp al, 62h     ; b
                mov Ncolumn, 08h
        ; -------C/c-------
            cmp al, 43h     ; C
                mov Ncolumn, 0dh
            cmp al, 63h     ; c
                mov Ncolumn, 0dh
        ; -------D/d-------
            cmp al, 44h     ; D
                mov Ncolumn, 12h
            cmp al, 64h     ; d
                mov Ncolumn, 12h
        ; -------E/e-------
            cmp al, 45h     ; E
                mov Ncolumn, 23h
            cmp al, 65h     ; e
                mov Ncolumn, 23h
        ; -------F/f-------
            cmp al, 46h     ; F
                mov Ncolumn, 1ch
            cmp al, 66h     ; f
                mov Ncolumn, 1ch
        ; -------G/g-------
            cmp al, 47h     ; G
                mov Ncolumn, 21h
            cmp al, 67h     ; g
                mov Ncolumn, 21h
        ; -------H/h-------
            cmp al, 48h     ; H
                mov Ncolumn, 26h
            cmp al, 68h     ; h
                mov Ncolumn, 26h
        ; -------I/i-------
            cmp al, 49h     ; I
                mov Ncolumn, 2bh
            cmp al, 69h     ; i
                mov Ncolumn, 2bh
    Backspace:

    Error:

    EndGC:
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
