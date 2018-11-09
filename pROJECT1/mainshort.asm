.data 
temp45 dw 0 


.code 
main proc
    mov ax, @data
    mov ds, ax
    mov es, ax

    ;PRINT StringUp52 
    MOV AH,9
    LEA DX, String525252 
    INT 21H
    ;PRINT NEW LINE
    MOV AH,2
    MOV DL, 0DH; CARRIAGE RETURN
    INT 21H
    
    MOV DL, 0AH; lINE FEED
    INT 21H
    ;NEWLINE CLOSED
    ;/****enter the inputs 1st*****/
    call TakeInput
    ;PRINT NEW LINE
    MOV AH,2
    MOV DL, 0DH; CARRIAGE RETURN
    INT 21H
    
    MOV DL, 0AH; lINE FEED
    INT 21H
    ;NEWLINE CLOSED 
    call InputBackUp        ;/*************New line added **************/
    
    call place_corner_1
    
    call place_another_corner
    call place_another_corner   
    call place_another_corner
    
    call do_oll
    call do_pll
    ;PRINT NEW LINE
    MOV AH,2
    MOV DL, 0DH; CARRIAGE RETURN
    INT 21H
    
    MOV DL, 0AH; lINE FEED
    INT 21H
    ;NEWLINE CLOSED
    call printer
    ;PRINT NEW LINE
    MOV AH,2
    MOV DL, 0DH; CARRIAGE RETURN
    INT 21H
    
    MOV DL, 0AH; lINE FEED
    INT 21H
    ;NEWLINE CLOSED
    ;PRINT StringUp52 
    MOV AH,9
    LEA DX, StringAlgo52 
    INT 21H
    ;PRINT NEW LINE
    MOV AH,2
    MOV DL, 0DH; CARRIAGE RETURN
    INT 21H
    
    MOV DL, 0AH; lINE FEED
    INT 21H
    ;NEWLINE CLOSED
    
    call showmoves
    ;PRINT NEW LINE
    MOV AH,2
    MOV DL, 0DH; CARRIAGE RETURN
    INT 21H
    
    MOV DL, 0AH; lINE FEED
    INT 21H
    ;NEWLINE CLOSED
    
    mov Ax, index
    Mov temp45, Ax 
    mov cl, 1 
    SHR ax, cl
    call OUTDEC
    
    ;
    call  InputRestor ;/***********new line added ****************/
    call printer 
    call EfficientSolver       ;/**********new line added*****************/
    call printer      ;/****new line ******/
    mov Ax, temp45    ;/****new line ******/
    mov cl, 1         ;/****new line ******/
    SHR ax, cl        ;/****new line ******/
    call outdec       ;/****new line ******/
    mov ah,4ch
    int 21h
main endp
