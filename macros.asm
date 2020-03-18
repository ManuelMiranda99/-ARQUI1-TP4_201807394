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

; Move cursor
; The screen in text mode have 25 rows and 80 columns
moveCursor macro row, column
    mov ah, 02h
    mov dh, row
    mov dl, column
    int 10h
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