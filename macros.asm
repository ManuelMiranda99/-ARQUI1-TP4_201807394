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

; GET TEXT UNTIL THE USER WRITE ENTER
getText macro string
    xor si, si

    getCharacter:
        getChar
        cmp al, 0dh
            je EndGC
        mov string[si], al
        inc si
        jmp getCharacter
    EndGC:
        mov al, 24h
        mov string[si], al
endm