section .rodata
align 4
gdt:
    times 8 db 0                ; null descriptor
    ; kernel mode code segment
    times 2 db 0xff             ; two bytes of limit
    times 3 db 0                ; three bytes of zero base
    db 0b10011010               ; access byte
    db 0xff                     ; third byte of limit
    db 0b00001100               ; last byte of base and flag
    ; kernel mode data segment
    times 2 db 0xff             ; two bytes of limit
    times 3 db 0                ; three bytes of zero base
    db 0b10010010               ; access byte
    db 0xff                     ; third byte of limit
    db 0b00001100               ; last byte of base and flag
    ; user mode code segment
    times 2 db 0xff             ; two bytes of limit
    times 3 db 0                ; three bytes of zero base
    ; TODO: fix below
    db 0b11111110               ; access byte
    db 0xff                     ; third byte of limit
    db 0b00001100               ; last byte of base and flag
