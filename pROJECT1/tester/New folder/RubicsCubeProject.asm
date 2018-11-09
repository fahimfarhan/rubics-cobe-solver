ORG 100H
.STACK 100H
.MODEL SMALL
.DATA

UP 	  DW 'R','O','W','Y'
FRONT DW 'Y','G','B','G' 
LEFT  DW 'O','R','B','Y'
RIGHT DW 'B','W','R','O'
BACK  DW 'B','G','W','G'
DOWN  DW 'R','Y','W','O' 

TEMP1  DW  0
TEMP2  DW  0
TEMP0  DW  0  

count52 DW 0
error1_52 db "array out of range! $"
moves dw 256 dup(0) ; accha , eta ki 256 er beshi ki rakha jabe? say 500 ?
index dw 0

bool1 dw 0 
bool2 dw 0

.CODE

MAIN PROC
	MOV AX, @DATA
	MOV DS, AX
	MOV ES, AX
	;/*PORE EI KHANE CODE LEKHA HOBE*/ 
	CALL PRINTER
	call PlaceCorner1
	CALL PRINTER
	call PlaceAnotherCorner
	CALL PRINTER
	call PlaceAnotherCorner
	CALL PRINTER
	call PlaceAnotherCorner
	CALL PRINTER
	
	call ShowMoves
	mov Ax, index
	mov cl, 1 
	SHR ax, cl
	call OUTDEC
	
	
	;/*TO BE CONTINUED ...  ...  ...*/
MAIN ENDP  
PlaceCorner1FromUpperSide proc

push Ax 
push Bx 
Push cx 
Push Dx 
Push Si 
Push Di  
;/***************/ 
mov Cx, 0 
_1stForLoopPC1FUS: 

cmp cx, 4 
JGE _1stForEndInPC1FUS 

Mov bx, 0 
mov Ax, up[bx] 
cmp Ax, 'W' 

JNE _1stElseInPC1FUS 

mov Ax, left[bx] 
cmp Ax, 'G' 
JNE _2ndElseInPC1FUS
	
	call U 
	call B 
	call B 
	mov Ax, 1 
	mov bool1, Ax 
	jmp ExitPC1FUS
_2ndElseInPC1FUS:
	call U
jmp End1stForPC1FUS 	
_1stElseInPC1FUS:
	call U 
	jmp End1stForPC1FUS
End1stForPC1FUS: 
	add cx, 1 
	jmp _1stForLoopPC1FUS 
	
_1stForEndInPC1FUS: 
;/***************/
mov Cx, 0 
_2ndForLoopPC1FUS: 

cmp cx, 4 
JGE _2ndForEndInPC1FUS 

Mov bx, 0 
mov Ax, left[bx] 
cmp Ax, 'W' 

JNE _3rdElseInPC1FUS 
mov bx, 2
mov Ax, back[bx] 
cmp Ax, 'G' 
JNE _4thElseInPC1FUS
	
	call B 
	mov Ax, 1 
	mov bool1, Ax 
	jmp ExitPC1FUS
_4thElseInPC1FUS:
	call U
jmp End1stForPC1FUS 	
_3rdElseInPC1FUS:
	call U 
	jmp End1stForPC1FUS
End2ndForPC1FUS: 
	add cx, 1 
	jmp _2ndForLoopPC1FUS 
	
_2ndForEndInPC1FUS: 
;/*********************/
mov Cx, 0 
_3rdForLoopPC1FUS: 

cmp cx, 4 
JGE _3rdForEndInPC1FUS 

Mov bx, 2 
mov Ax, back[bx] 
cmp Ax, 'W' 

JNE _5thElseInPC1FUS 
mov bx, 0
mov Ax, up[bx] 
cmp Ax, 'G' 
JNE _6thElseInPC1FUS
	
	call Li  
	mov Ax, 1 
	mov bool1, Ax 
	jmp ExitPC1FUS
_6thElseInPC1FUS:
	call U
jmp End1stForPC1FUS 	
_5thElseInPC1FUS:
	call U 
	jmp End1stForPC1FUS
End3rdForPC1FUS: 
	add cx, 1 
	jmp _3rdForLoopPC1FUS 
	
_3rdForEndInPC1FUS: 

ExitPC1FUS:
	mov Ax, 0
	mov bool1, Ax
	
	pop Di 
	pop Si 
	pop Dx 
	pop Cx 
	pop Bx 
	pop Ax 
	ret
PlaceCorner1FromUpperSide Endp 

PlaceCorner1 proc 
push Ax 
push Bx 
Push cx 
Push Dx 
Push Si 
Push Di  
;/***************/ 
mov Ax, bool1 
cmp Ax, 1
JE exitPlaceCorner1

	mov bx, 6 
	mov ax, down[bx] 
	cmp Ax, 'W' 
	JNE ElsePlaceCorner1
	mov bx, 6 
	mov ax, left[bx] 
	cmp Ax, 'O' 
	JNE ElsePlaceCorner1
	mov Ax, 1 
	mov bool1, Ax 	
jmp exitPlaceCorner1 
ElsePlaceCorner1: 
call R 
call R 
call L 
call L 
call PlaceCorner1FromUpperSide 

exitPlaceCorner1:
;/***************/
	pop Di 
	pop Si 
	pop Dx 
	pop Cx 
	pop Bx 
	pop Ax 
	ret

PlaceCorner1 Endp 

PlaceAnotherCornerFromUpperSide proc 
push Ax 
push Bx 
Push cx 
Push Dx 
Push Si 
Push Di  
;/***************/ 

mov Cx, 0 
_1stForPACFUS: 
cmp cx, 4 
JGE End1stForPACFUS

	mov Bx, 0 
	mov Ax, right[Bx] 
	cmp Ax, 'W' 
	JNE Else1stForPACFUS
	
	mov Bx, 4 
	mov Ax, up[bx] 
	cmp Ax, 'B' 
	JNE _1stElseIf1stForPACFUS 
	call U
	call f 
	call u 
	call fi
	Mov Ax, 1 
	mov Bool2, Ax 
	Jmp ExitPACFUS 
	
_1stElseIf1stForPACFUS: 
mov Bx, 4 
	mov Ax, up[Bx] 
	cmp Ax,'G'
	JNE _2ndElseIf1stForPACFUS 
	call Ui 
	call B 
	call U 
	call Bi 
	Mov Ax, 1 
	mov Bool2, Ax 
	Jmp ExitPACFUS 
	
_2ndElseIf1stForPACFUS: 
	mov Bx, 4 
	mov Ax, up[Bx] 
	cmp Ax,'R' 
	call R 
	call U 
	call Ri 
	Mov Ax, 1 
	mov Bool2, Ax 
	Jmp ExitPACFUS 
	 
	
	
Else1stForPACFUS:
	call U 
	jmp _1stForPACFUS

End1stForPACFUS: 
;/****************/
;/**2nd loop **/
;/***************/ 

mov Cx, 0 
_2ndForPACFUS: 
cmp cx, 4 
JGE End2ndForPACFUS

	mov Bx, 2
	mov Ax, front[Bx] 
	cmp Ax, 'W' 
	JNE Else2ndForPACFUS
	
	mov Bx, 4 
	mov Ax, up[bx] 
	cmp Ax, 'O' 
	JNE _1stElseIf2ndForPACFUS 
	call U
	call Li 
	call ui 
	call L
	Mov Ax, 1 
	mov Bool2, Ax 
	Jmp ExitPACFUS 
	
_1stElseIf2ndForPACFUS: 
mov Bx, 4 
	mov Ax, up[Bx] 
	cmp Ax,'R'
	JNE _2ndElseIf2ndForPACFUS 
	call Ui 
	call Ri  
	call Ui  
	call R  
	Mov Ax, 1 
	mov Bool2, Ax 
	Jmp ExitPACFUS 
	
_2ndElseIf2ndForPACFUS: 
	mov Bx, 4 
	mov Ax, up[Bx] 
	cmp Ax,'B' 
	call Fi 
	call Ui  
	call F  
	Mov Ax, 1 
	mov Bool2, Ax 
	Jmp ExitPACFUS 
	 
	
	
Else2ndForPACFUS:
	call U 
	jmp _2ndForPACFUS

End2ndForPACFUS: 
;/**3rd for loop**/

mov Cx, 0 
_3rdForPACFUS: 
cmp cx, 4 
JGE End3rdForPACFUS

	mov Bx, 4
	mov Ax, up[Bx] 
	cmp Ax, 'W' 
	JNE Else3rdForPACFUS
	
	mov Bx, 2 
	mov Ax, front[bx] 
	cmp Ax, 'B' 
	JNE _1stElseIf3rdForPACFUS 
	call U
	call Li 
	call u 
	call L
	call u 
	call u 
	call li 
	call ui 
	call L 
	Mov Ax, 1 
	mov Bool2, Ax 
	Jmp ExitPACFUS 
	
_1stElseIf3rdForPACFUS: 
mov Bx, 2 
	mov Ax, front[Bx] 
	cmp Ax,'R'
	JNE _2ndElseIf3rdForPACFUS 
	call R 
	call ui  
	call ri  
	call u 
call u 
call r 
call u 
call ri 
	
	Mov Ax, 1 
	mov Bool2, Ax 
	Jmp ExitPACFUS 
	
_2ndElseIf3rdForPACFUS: 
	mov Bx, 2
	mov Ax, front[Bx] 
	cmp Ax,'G'  
	call ui 
	call ri  
	call u  
call r 
call u 
call u 
call ri 
call ui 
call r 
	
	Mov Ax, 1 
	mov Bool2, Ax 
	Jmp ExitPACFUS 
	 
	
	
Else3rdForPACFUS:
	call U 
	jmp _3rdForPACFUS

End3rdForPACFUS: 

ExitPACFUS:
Mov Ax, 0 
	mov Bool2, Ax 
;/***************/
	pop Di 
	pop Si 
	pop Dx 
	pop Cx 
	pop Bx 
	pop Ax 
	ret
PlaceAnotherCornerFromUpperSide Endp

PlaceAnotherCorner proc 

push Ax 
push Bx 
Push cx 
Push Dx 
Push Si 
Push Di  
;/***************/ 
call PlaceAnotherCornerFromUpperSide 
mov Ax, bool2 
cmp Ax, 1 
JE ExitPAC 
; 1st if 
	mov bx, 6 
	mov Ax, front[bx] 
	cmp Ax, 'W' 
	JE Do1stIfPAC
	mov bx, 4 
	mov Ax, left[bx] 
	cmp Ax, 'W' 
	JNE _1stElseIfPac
Do1stIfPAC:
		call Li 
		call Ui 
		call L 
		call PlaceAnotherCornerFromUpperSide 
		jmp ExitPac
		;1st else if 
_1stElseIfPac:

mov bx, 0 
	mov Ax, down[bx] 
	cmp Ax, 'W' 
	JNE _2ndElseIfPac
	mov bx, 6 
	mov Ax, front[bx] 
	cmp Ax, 'B' 
	JNE _2ndElseIfPac
Do1stElseIfPAC:
		call Li 
		call Ui 
		call L 
		call PlaceAnotherCornerFromUpperSide 
		jmp ExitPac

_2ndElseIfPac:
;2nd else if 

	mov bx, 4 
	mov Ax, front[bx] 
	cmp Ax, 'W' 
	JE Do2ndElseIfPAC
	mov bx, 6 
	mov Ax, right[bx] 
	cmp Ax, 'W' 
	JNE _3rdElseIfPac
Do2ndElseIfPAC:
		call r 
		call U 
		call ri 
		call PlaceAnotherCornerFromUpperSide 
		jmp ExitPac
		
_3rdElseIfPac: 
mov bx, 02
	mov Ax, down[bx] 
	cmp Ax, 'W' 
	JNE _4thElseIfPac
	mov bx, 6 
	mov Ax, right[bx] 
	cmp Ax, 'R' 
	JE _4thElseIfPac
Do3rdtElseIfPAC:
		call Fi  
		call Ui 
		call F 
		call U 
		call PlaceAnotherCornerFromUpperSide 
		jmp ExitPac
	_4thElseIfPac:
	;4nd else if 

	mov bx, 4 
	mov Ax, right[bx] 
	cmp Ax, 'W' 
	JE Do4thElseIfPAC
	mov bx, 6 
	mov Ax, back[bx] 
	cmp Ax, 'W' 
	JNE _5thElseIfPac
Do4thElseIfPAC:
		call ri  
		call U 
		call r 
call U 		
		call PlaceAnotherCornerFromUpperSide 
		jmp ExitPac
	_5thElseIfPac:
	mov bx, 4
	mov Ax, down[bx] 
	cmp Ax, 'W' 
	JNE ExitPac
	mov bx, 6 
	mov Ax, back[bx] 
	cmp Ax, 'G' 
	JE exitPac
Do5thtElseIfPAC:
		call ri  
		call Ui 
		call ui  
		call r 
call u 		
		call PlaceAnotherCornerFromUpperSide 
		jmp ExitPac
;/***************/
ExitPAC :

	pop Di 
	pop Si 
	pop Dx 
	pop Cx 
	pop Bx 
	pop Ax 
	ret
PlaceAnotherCorner Endp

jmp MAINEXIT9

OUTDEC PROC
;INPUT AX
PUSH AX
PUSH BX
PUSH CX
PUSH DX
OR AX,AX
JGE @END_IF1
PUSH AX
MOV DL,'-'
MOV AH,2
INT 21H
POP AX
NEG AX

@END_IF1:
XOR CX,CX
MOV BX,10D

@REPEAT1:
XOR DX,DX
DIV BX
PUSH DX
INC CX
OR AX,AX
JNE @REPEAT1

MOV AH,2

@PRINT_LOOP:

POP DX
OR DL,30H
INT 21H
LOOP @PRINT_LOOP

POP DX
POP CX
POP BX
POP AX
RET
OUTDEC ENDP

MAINEXIT9:
JMP MAINEXIT1 

ShowMoves proc
push ax
push bx
push cx
push dx
push si
push di 
;PRINT NEW LINE
    MOV AH,2
    MOV DL, 0DH; CARRIAGE RETURN
    INT 21H
    
    MOV DL, 0AH; lINE FEED
    INT 21H
    ;NEWLINE CLOSED

lea Si, moves 
mov cx, 0 
Loop_PrinterShowMoves:
cmp cx, index 
JGE ExitShowMoves 
mov bx, 0
mov bx, [si]
MOV DL, BL
MOV AH,2
INT 21H
add si, 2 
add cx, 2 
jmp Loop_PrinterShowMoves


;PRINT NEW LINE
    MOV AH,2
    MOV DL, 0DH; CARRIAGE RETURN
    INT 21H
    
    MOV DL, 0AH; lINE FEED
    INT 21H
    ;NEWLINE CLOSED
 ;PRINT S
    MOV AH,9
    LEA DX, error1_52
    INT 21H
    ;PRINT NEW LINE
    MOV AH,2
    MOV DL, 0DH; CARRIAGE RETURN
    INT 21H
    
    MOV DL, 0AH; lINE FEED
    INT 21H
    ;NEWLINE CLOSED
ExitShowMoves:	
pop di
pop si
pop dx 
pop cx 
pop bx 
pop ax
ret   
 
ShowMoves Endp

;arrray moves has the F, u, ... and index points to the last pos
; count52 has the count 
Backchecker proc
 push ax 
 push bx 
 push cx 
 push dx 
 push si 
 push di 
 
 mov ax, index 
 cmp ax, 4 
 JLE Exit_BackChecker1
 call counter1 
 mov Ax, count52 
 cmp Ax, 3 
 JNE Exit_BackChecker1 
 mov Bx, index
sub Bx, 2  
 mov Ax, 0 
 mov moves[bx], Ax 
 sub bx, 2
 mov moves[bx], Ax
 mov index, bx
 sub bx, 2 
 mov Ax, moves[Bx] 
 cmp Ax, 96 
 JG u_to_U 
 Add Ax, 32 
 mov moves[bx], ax 
 jmp Exit_BackChecker1

 u_to_U: 
 sub Ax, 32 
 mov moves[bx], Ax 
 Exit_BackChecker1: 
 
 mov ax, index 
 cmp Ax, 4 
 JL Exit_BackCheccker2
 ; else 
	mov bx, index 
	sub bx, 2 
	mov Ax, moves[bx] 
	sub Bx, 2 
	sub Ax, moves[bx] 
	cmp Ax, 32 
	JE BackCheckerCaseUUi 
	
	cmp Ax,  0FFE0h;-32  
	Jne Exit_BackCheccker2
	BackCheckerCaseUUi:
		mov ax, 0 
		mov moves[bx], ax 
		mov index, bx 
		add bx, 2 
		mov moves[bx], 0 
 Exit_BackCheccker2:
 
 pop di 
 pop si 
 pop dx 
 pop cx 
 pop bx 
 pop ax 
  RET
Backchecker endp
MAINEXIT1:
JMP MAINEXIT2

Checker proc 
  push ax
push bx
push cx
push dx
push si
push di              
call BackChecker 
call BackChecker
   pop di
pop si
pop dx 
pop cx 
pop bx 
pop ax
ret   
Checker endp


 

;/************/ 
;user manual
; mov ax, 'F'
;call savemoves
SaveMoves proc
push ax
push bx
push cx
push dx
push si
push di

mov Bx, index 
cmp bx, 500
JGE ArrayOutOfBondExceptionInShowMoves
;let Ax has the name( F, f, U, D, d ... ...) 
mov moves[Bx], Ax 
Add Bx, 2 
mov index, Bx 
ArrayOutOfBondExceptionInShowMoves:
pop di
pop si
pop dx 
pop cx 
pop bx 
pop ax
ret   
SaveMoves endp 


Counter1 proc 
push ax 
push bx 
push cx 
push dx 
push si 
push di 
; assuming index variable has the index pos; save output in the count52 var  
mov bx, index 
mov cx , 1
sub bx, 2 
Counter_for_loop: 
	
mov Ax, moves[bx]
cmp bx, 2 
JL counter_for_loop_break	
sub bx, 2 
cmp Ax, moves[bx] 
JNE counter_for_loop_break
Add Cx, 1 
cmp cx, 4 
JGE counter_for_loop_break 
jmp  Counter_for_loop

counter_for_loop_break:

mov count52 , Cx 
pop di 
pop si 
pop dx 
pop cx 
pop bx 
pop ax 
RET
Counter1 endp
;BASIC MOVE FUNCTIONS
FI PROC
	PUSH AX
	PUSH BX
	PUSH CX
	PUSH DX
	PUSH SI
	PUSH DI
	;/********/
	;/********/
	MOV AX, 0 
	LEA SI, UP
	MOV AX, [SI+6] 
	MOV TEMP0 , AX 
	MOV AX, [SI+4] 
	MOV TEMP1 , AX 
	;/**********/
	;/**********/
	LEA DI, RIGHT
	MOV AX, [DI] 
	MOV [SI+6], AX 
	MOV AX, [DI+6]
	MOV [SI+4], AX
	;/*****************/
	;/*****************/
		
	LEA SI, DOWN
	MOV AX, [SI+2] 
	MOV [DI], AX 
	MOV AX, [SI]
	MOV [DI+6], AX
	;/**
	;/**
	LEA DI, LEFT
	MOV AX, [DI+2] 
	MOV [SI], AX 
	MOV AX, [DI+4]
	MOV [SI+2], AX
;/**;/**
;/**;/**
	MOV AX, TEMP0 
	MOV [DI+4], AX 
	MOV AX, TEMP1 
	MOV [DI+2], AX
;/****************/
	
;/LEFT SIDE ROTATE*/
	LEA SI, FRONT
	MOV AX, [SI] 
	MOV TEMP1, AX ; TEMP1 = U0 
	MOV AX, [SI+2] ; AX = U1
	MOV [SI], AX  ; U0 = AX = U1
	MOV AX, [SI+4] ; AX = U2
	MOV  [SI+2], AX ; U1 = U2 = AX 
	MOV AX, [SI+6]
	MOV [SI+4], AX ; U2 = U3 = AX 
	MOV AX, TEMP1 ; AX = T1 = U0 
	MOV [SI+6], AX ; U3 = U0 = AX 
	;/********/
	mov Ax, 'f' 
	call SaveMoves
	call Checker
	;/********/
	POP DI
	POP SI
	POP DX
	POP CX
	POP BX
	POP AX
	RET
FI ENDP;/***********/
MAINEXIT2:
JMP MAINEXIT3
F PROC
	PUSH AX
	PUSH BX
	PUSH CX
	PUSH DX
	PUSH SI
	PUSH DI
	;/********/
	;/********/
	MOV AX, 0 
	LEA SI, UP
	MOV AX, [SI+6] 
	MOV TEMP0 , AX 
	MOV AX, [SI+4] 
	MOV TEMP1 , AX 
	;/**********/
	;/**********/
	LEA DI, LEFT
	MOV AX, [DI+4] 
	MOV [SI+6], AX 
	MOV AX, [DI+2]
	MOV [SI+4], AX
	;/*****************/
		
	LEA SI, DOWN
	MOV AX, [SI] 
	MOV [DI+2], AX 
	MOV AX, [SI+2]
	MOV [DI+4], AX
	;/**
	LEA DI, RIGHT 
	MOV AX, [DI+6] 
	MOV [SI], AX 
	MOV AX, [DI]
	MOV [SI+2], AX
;/**;/**
;/**;/**
	MOV AX, TEMP0 
	MOV [DI], AX 
	MOV AX, TEMP1 
	MOV [DI+6], AX
;/****************/

;/*****************/
;/LEFT SIDE ROTATE*/
	LEA SI, FRONT
	MOV AX, [SI] 
	MOV TEMP1, AX ; TEMP1 = U0 
	MOV AX, [SI+6] ; AX = U1
	MOV [SI], AX  ; U0 = AX = U1
	MOV AX, [SI+4] ; AX = U2
	MOV  [SI+6], AX ; U1 = U2 = AX 
	MOV AX, [SI+2]
	MOV [SI+4], AX ; U2 = U3 = AX 
	MOV AX, TEMP1 ; AX = T1 = U0 
	MOV [SI+2], AX ; U3 = U0 = AX 
	;/********/
	       mov Ax, 'F' 
	call SaveMoves
	call Checker
	;/********/
	POP DI
	POP SI
	POP DX
	POP CX
	POP BX
	POP AX
	RET
F ENDP
;/***********/
B PROC
	PUSH AX
	PUSH BX
	PUSH CX
	PUSH DX
	PUSH SI
	PUSH DI
	;/********/
	;/********/
	MOV AX, 0 
	LEA SI, UP 
	MOV AX, [SI] 
	MOV TEMP0 , AX 
	MOV AX, [SI+2] 
	MOV TEMP1 , AX 
	;/**********/
	;/**********/
	LEA DI, RIGHT
	MOV AX, [DI+2] 
	MOV [SI], AX 
	MOV AX, [DI+4]
	MOV [SI+2], AX
;/*****************/
;/*****************/
		
	LEA SI, DOWN
	MOV AX, [SI+6] 
	MOV [DI+4], AX 
	MOV AX, [SI+4]
	MOV [DI+2], AX
;/****************/
;/**
	LEA DI, LEFT 
	MOV AX, [DI] 
	MOV [SI+6], AX 
	MOV AX, [DI+6]
	MOV [SI+4], AX
;/**;/**
;/**;/**
	MOV AX, TEMP0 
	MOV [DI+6], AX 
	MOV AX, TEMP1 
	MOV [DI], AX
	;/LEFT SIDE ROTATE*/
	LEA SI, BACK
	MOV AX, [SI] 
	MOV TEMP1, AX ; TEMP1 = U0 
	MOV AX, [SI+6] ; AX = U1
	MOV [SI], AX  ; U0 = AX = U1
	MOV AX, [SI+4] ; AX = U2
	MOV  [SI+6], AX ; U1 = U2 = AX 
	MOV AX, [SI+2]
	MOV [SI+4], AX ; U2 = U3 = AX 
	MOV AX, TEMP1 ; AX = T1 = U0 
	MOV [SI+2], AX ; U3 = U0 = AX 
	;/********/ 
	mov Ax, 'B' 
	call SaveMoves
	call Checker
	;/********/
	POP DI
	POP SI
	POP DX
	POP CX
	POP BX
	POP AX
	RET
B ENDP
;/***********/
MAINEXIT3:
JMP MAINEXIT4
Bi PROC 

	PUSH AX
	PUSH BX
	PUSH CX
	PUSH DX
	PUSH SI
	PUSH DI
	;/********/
	;/********/
	MOV AX, 0 
	LEA SI, UP 
	MOV AX, [SI] 
	MOV TEMP0 , AX 
	MOV AX, [SI+2] 
	MOV TEMP1 , AX 
	;/**********/
	;/**********/
	LEA DI, LEFT
	MOV AX, [DI+6] 
	MOV [SI], AX 
	MOV AX, [DI]
	MOV [SI+2], AX
;/*****************/
;/*****************/
		
	LEA SI, DOWN
	MOV AX, [SI+6] 
	MOV [DI], AX 
	MOV AX, [SI+4]
	MOV [DI+6], AX
;/****************/
;/**
	LEA DI, RIGHT
	MOV AX, [DI+4] 
	MOV [SI+6], AX 
	MOV AX, [DI+2]
	MOV [SI+4], AX
;/**;/**
;/**;/**
	MOV AX, TEMP0 
	MOV [DI+2], AX 
	MOV AX, TEMP1 
	MOV [DI+4], AX
	;/*RIGHT SIDE ROTATE*/


	
	;/*RIGHT SIDE ROTATE*/	
	LEA SI, BACK  
	MOV AX, [SI] 
	MOV TEMP1, AX ; TEMP1 = U0 
	MOV AX, [SI+2] ; AX = U1
	MOV [SI], AX  ; U0 = AX = U1
	MOV AX, [SI+4] ; AX = U2
	MOV  [SI+2], AX ; U1 = U2 = AX 
	MOV AX, [SI+6]
	MOV [SI+4], AX ; U2 = U3 = AX 
	MOV AX, TEMP1 ; AX = T1 = U0 
	MOV [SI+6], AX ; U3 = U0 = AX 
	
;/********/ 
mov Ax, 'b' 
	call SaveMoves
	call Checker
	POP DI
	POP SI
	POP DX
	POP CX
	POP BX
	POP AX
	RET
Bi ENDP
;/***********/
Ri PROC 

	PUSH AX
	PUSH BX
	PUSH CX
	PUSH DX
	PUSH SI
	PUSH DI
	;/********/
	;/********/
	MOV AX, 0 
	LEA SI, BACK 
	MOV AX, [SI] 
	MOV TEMP0 , AX 
	MOV AX, [SI+6] 
	MOV TEMP1 , AX 
	;/**********/
	;/**********/
	LEA DI, DOWN
	MOV AX, [DI+4] 
	MOV [SI], AX 
	MOV AX, [DI+2]
	MOV [SI+6], AX
;/*****************/

;/*****************/
		
	LEA SI, FRONT 
	MOV AX, [SI+2] 
	MOV [DI+2], AX 
	MOV AX, [SI+4]
	MOV [DI+4], AX
;/****************/
;/**
	LEA DI, UP
	MOV AX, [DI+2] 
	MOV [SI+2], AX 
	MOV AX, [DI+4]
	MOV [SI+4], AX
;/**;/**
;/**;/**
	MOV AX, TEMP0 
	MOV [DI+4], AX 
	MOV AX, TEMP1 
	MOV [DI+2], AX
	;/*RIGHT SIDE ROTATE*/
	
	LEA SI, RIGHT  
	MOV AX, [SI] 
	MOV TEMP1, AX ; TEMP1 = U0 
	MOV AX, [SI+2] ; AX = U1
	MOV [SI], AX  ; U0 = AX = U1
	MOV AX, [SI+4] ; AX = U2
	MOV  [SI+2], AX ; U1 = U2 = AX 
	MOV AX, [SI+6]
	MOV [SI+4], AX ; U2 = U3 = AX 
	MOV AX, TEMP1 ; AX = T1 = U0 
	MOV [SI+6], AX ; U3 = U0 = AX 
	;/********/
	mov Ax, 'r' 
	call SaveMoves
	call Checker
	POP DI
	POP SI
	POP DX
	POP CX
	POP BX
	POP AX
	RET
Ri ENDP
;/***********/
MAINEXIT4:
JMP MAINEXIT5

R PROC
	PUSH AX
	PUSH BX
	PUSH CX
	PUSH DX
	PUSH SI
	PUSH DI
	;/********/
	;/********/
	MOV AX, 0 
	LEA SI, BACK 
	MOV AX, [SI] 
	MOV TEMP0 , AX 
	MOV AX, [SI+6] 
	MOV TEMP1 , AX 
	;/**********/
	;/**********/
	LEA DI, UP
	MOV AX, [DI+4] 
	MOV [SI], AX 
	MOV AX, [DI+2]
	MOV [SI+6], AX
;/*****************/
;/*****************/
		
	LEA SI, FRONT 
	MOV AX, [SI+2] 
	MOV [DI+2], AX 
	MOV AX, [SI+4]
	MOV [DI+4], AX
;/****************/
;/**
	LEA DI, DOWN
	MOV AX, [DI+2] 
	MOV [SI+2], AX 
	MOV AX, [DI+4]
	MOV [SI+4], AX
;/**;/**
	MOV AX, TEMP0 
	MOV [DI+4], AX 
	MOV AX, TEMP1 
	MOV [DI+2], AX
	
	;/LEFT SIDE ROTATE*/
	LEA SI, RIGHT
	MOV AX, [SI] 
	MOV TEMP1, AX ; TEMP1 = U0 
	MOV AX, [SI+6] ; AX = U1
	MOV [SI], AX  ; U0 = AX = U1
	MOV AX, [SI+4] ; AX = U2
	MOV  [SI+6], AX ; U1 = U2 = AX 
	MOV AX, [SI+2]
	MOV [SI+4], AX ; U2 = U3 = AX 
	MOV AX, TEMP1 ; AX = T1 = U0 
	MOV [SI+2], AX ; U3 = U0 = AX 
	;/********/
	mov Ax, 'R' 
	call SaveMoves
	call Checker
	;/********/
	
	POP DI
	POP SI
	POP DX
	POP CX
	POP BX
	POP AX
	RET
R ENDP

;/********/
L PROC
	PUSH AX
	PUSH BX
	PUSH CX
	PUSH DX
	PUSH SI
	PUSH DI
	;/********/
	;/********/
	MOV AX, 0 
	LEA SI, BACK 
	MOV AX, [SI+2] 
	MOV TEMP0 , AX 
	MOV AX, [SI+4] 
	MOV TEMP1 , AX 
	;/**********/
	;/**********/
	LEA DI, DOWN
	MOV AX, [DI] 
	MOV [SI+4], AX 
	MOV AX, [DI+6]
	MOV [SI+2], AX
;/*****************/
;/*****************/
		
	LEA SI, FRONT 
	MOV AX, [SI] 
	MOV [DI], AX 
	MOV AX, [SI+6]
	MOV [DI+6], AX
;/**;/**
	LEA DI, UP
	MOV AX, [DI] 
	MOV [SI], AX 
	MOV AX, [DI+6]
	MOV [SI+6], AX
;/**
;/**
	MOV AX, TEMP0 
	MOV [DI+6], AX 
	MOV AX, TEMP1 
	MOV [DI], AX
	;/LEFT SIDE ROTATE*/
	LEA SI, LEFT 
	MOV AX, [SI] 
	MOV TEMP1, AX ; TEMP1 = U0 
	MOV AX, [SI+6] ; AX = U1
	MOV [SI], AX  ; U0 = AX = U1
	MOV AX, [SI+4] ; AX = U2
	MOV  [SI+6], AX ; U1 = U2 = AX 
	MOV AX, [SI+2]
	MOV [SI+4], AX ; U2 = U3 = AX 
	MOV AX, TEMP1 ; AX = T1 = U0 
	MOV [SI+2], AX ; U3 = U0 = AX 
	;/********/
	mov Ax, 'L' 
	call SaveMoves
	call Checker
;/********/
	POP DI
	POP SI
	POP DX
	POP CX
	POP BX
	POP AX
	RET
L ENDP
;/********/
MAINEXIT5:
JMP MAINEXIT6
Li PROC 

	PUSH AX
	PUSH BX
	PUSH CX
	PUSH DX
	PUSH SI
	PUSH DI
	;/********/
	;/********/
	MOV AX, 0 
	LEA SI, BACK 
	MOV AX, [SI+2] 
	MOV TEMP0 , AX 
	MOV AX, [SI+4] 
	MOV TEMP1 , AX 
	;/**********/
	;/**********/
	LEA DI, UP 
	MOV AX, [DI] 
	MOV [SI+4], AX 
	MOV AX, [DI+6]
	MOV [SI+2], AX
;/*****************/;/*****************/
		
	LEA SI, FRONT 
	MOV AX, [SI] 
	MOV [DI], AX 
	MOV AX, [SI+6]
	MOV [DI+6], AX
;/**;/**
	LEA DI, DOWN 
	MOV AX, [DI] 
	MOV [SI], AX 
	MOV AX, [DI+6]
	MOV [SI+6], AX
;/**;/**
	MOV AX, TEMP0 
	MOV [DI+6], AX 
	MOV AX, TEMP1 
	MOV [DI], AX
	
;/*UP SIDE ROTATE*/
	
	LEA SI, LEFT 
	MOV AX, [SI] 
	MOV TEMP1, AX ; TEMP1 = U0 
	MOV AX, [SI+2] ; AX = U1
	MOV [SI], AX  ; U0 = AX = U1
	MOV AX, [SI+4] ; AX = U2
	MOV  [SI+2], AX ; U1 = U2 = AX 
	MOV AX, [SI+6]
	MOV [SI+4], AX ; U2 = U3 = AX 
	MOV AX, TEMP1 ; AX = T1 = U0 
	MOV [SI+6], AX ; U3 = U0 = AX 

	;/********/
	mov Ax, 'l' 
	call SaveMoves
	call Checker
	POP DI
	POP SI
	POP DX
	POP CX
	POP BX
	POP AX
	RET
Li ENDP

;/**********/
iD PROC 

	PUSH AX
	PUSH BX
	PUSH CX
	PUSH DX
	PUSH SI
	PUSH DI
	;/********/
	MOV AX, 0 
	LEA SI, BACK 
	MOV AX, [SI+6] 
	MOV TEMP0 , AX 
	MOV AX, [SI+4] 
	MOV TEMP1 , AX 
	;/*************/
	
	;/**********/
	LEA DI, LEFT  
	MOV AX, [DI+6] 
	MOV [SI+6], AX 
	MOV AX, [DI+4]
	MOV [SI+4], AX
	;/*****************/
		
	LEA SI, FRONT 
	MOV AX, [SI+6] 
	MOV [DI+6], AX 
	MOV AX, [SI+4]
	MOV [DI+4], AX
;/**;/**
	LEA DI, RIGHT
	MOV AX, [DI+6] 
	MOV [SI+6], AX 
	MOV AX, [DI+4]
	MOV [SI+4], AX
;/**;/**
	MOV AX, TEMP0 
	MOV [DI+6], AX 
	MOV AX, TEMP1 
	MOV [DI+4], AX
	
	;/*UP SIDE ROTATE*/
	
	LEA SI, DOWN 
	MOV AX, [SI] 
	MOV TEMP1, AX ; TEMP1 = U0 
	MOV AX, [SI+2] ; AX = U1
	MOV [SI], AX  ; U0 = AX = U1
	MOV AX, [SI+4] ; AX = U2
	MOV  [SI+2], AX ; U1 = U2 = AX 
	MOV AX, [SI+6]
	MOV [SI+4], AX ; U2 = U3 = AX 
	MOV AX, TEMP1 ; AX = T1 = U0 
	MOV [SI+6], AX ; U3 = U0 = AX 

;/********/
mov Ax, 'd' 
	call SaveMoves
	call Checker
	POP DI
	POP SI
	POP DX
	POP CX
	POP BX
	POP AX
	RET
iD ENDP
MAINEXIT6:
JMP MAINEXIT7
  ;/********/
Ui PROC 

	PUSH AX
	PUSH BX
	PUSH CX
	PUSH DX
	PUSH SI
	PUSH DI
	;/********/
	MOV AX, 0
	;MOV SI, 0
	LEA SI, BACK ; SI = &B
	MOV AX, [SI] ; 
	MOV TEMP0, AX; TEMP0 = B[0]
	
	MOV AX, [SI+2] ; AX = B[1]
	MOV TEMP1, AX ; TEMP1 = B[1]

	;MOV DI, 0
	LEA DI, RIGHT 
	MOV AX, [DI]
	MOV [SI], AX; B[0] = R[0]
	MOV AX, [DI+2]
	MOV [SI+2], AX ;B1 = R1
	
	;MOV SI, 0
	LEA SI, FRONT 
	MOV AX, [SI] 
	MOV [DI], AX ; R0 = F0
	
	MOV AX, [SI+2]
	MOV [DI+2], AX ; R1 = F1
	
	LEA DI, LEFT 
	MOV AX, [DI] ; AX = L0
	MOV [SI], AX ; F0 = L0
	MOV AX, [DI+2]
	MOV [SI+2], AX
	
	MOV AX, TEMP0
	MOV [DI], AX; L0 = TEMP0
	MOV AX, TEMP1 
	MOV [DI+2], AX ; L1 = TEMP1 
	;/*UP SIDE ROTATE*/
	
	LEA SI, UP 
	MOV AX, [SI] 
	MOV TEMP1, AX ; TEMP1 = U0 
	MOV AX, [SI+2] ; AX = U1
	MOV [SI], AX  ; U0 = AX = U1
	MOV AX, [SI+4] ; AX = U2
	MOV  [SI+2], AX ; U1 = U2 = AX 
	MOV AX, [SI+6]
	MOV [SI+4], AX ; U2 = U3 = AX 
	MOV AX, TEMP1 ; AX = T1 = U0 
	MOV [SI+6], AX ; U3 = U0 = AX 

	;/********/
	mov Ax, 'u' 
	call SaveMoves
	call Checker
	POP DI
	POP SI
	POP DX
	POP CX
	POP BX
	POP AX
	RET
Ui ENDP

U PROC 

	PUSH AX
	PUSH BX
	PUSH CX
	PUSH DX
	PUSH SI
	PUSH DI
	;/********/
	MOV AX, 0
	MOV AX, 0
	;MOV SI, 0
	LEA SI, BACK ; SI = &B
	MOV AX, [SI] ; 
	MOV TEMP0, AX; TEMP0 = B[0]
	
	MOV AX, [SI+2] ; AX = B[1]
	MOV TEMP1, AX ; TEMP1 = B[1]
	;/***********/
	;MOV DI, 0
	LEA DI, LEFT 
	MOV AX, [DI]
	MOV [SI], AX; B[0] = R[0]
	MOV AX, [DI+2]
	MOV [SI+2], AX ;B1 = R1
	;/******/
	
	LEA SI, FRONT 
	MOV AX, [SI] 
	MOV [DI], AX ; R0 = F0
	
	MOV AX, [SI+2]
	MOV [DI+2], AX ; R1 = F1
	;/*********/
	LEA DI, RIGHT
	MOV AX, [DI] ; AX = L0
	MOV [SI], AX ; F0 = L0
	MOV AX, [DI+2]
	MOV [SI+2], AX
	
	MOV AX, TEMP0
	MOV [DI], AX; R0 = TEMP0
	MOV AX, TEMP1 
	MOV [DI+2], AX ; R1 = TEMP1 
	
	
	;/*UP SIDE ROTATE*/
	
	LEA SI, UP 
	MOV AX, [SI] 
	MOV TEMP1, AX ; TEMP1 = U0 
	MOV AX, [SI+6] ; AX = U1
	MOV [SI], AX  ; U0 = AX = U1
	MOV AX, [SI+4] ; AX = U2
	MOV  [SI+6], AX ; U1 = U2 = AX 
	MOV AX, [SI+2]
	MOV [SI+4], AX ; U2 = U3 = AX 
	MOV AX, TEMP1 ; AX = T1 = U0 
	MOV [SI+2], AX ; U3 = U0 = AX 
	;/********/
	mov Ax, 'U' 
	call SaveMoves
	call Checker
	POP DI
	POP SI
	POP DX
	POP CX
	POP BX
	POP AX
	RET
U ENDP
MAINEXIT7:
JMP MAINEXIT8

PRINTER PROC
push ax 
push bx 
push cx 
push dx 
push si 
push di 
;PRINT NEW LINE
    MOV AH,2
    MOV DL, 0DH; CARRIAGE RETURN
    INT 21H
    
    MOV DL, 0AH; lINE FEED
    INT 21H
    ;NEWLINE CLOSED
 
;UP 
LEA SI, UP 
MOV BX, [SI]
;OUPUT
    MOV DL, BL
    MOV AH,2
    INT 21H
MOV BX, [SI+2]
;OUPUT
    MOV DL, BL
    MOV AH,2
    INT 21H
MOV BX, [SI+4]
;OUPUT
    MOV DL, BL
    MOV AH,2
    INT 21H
MOV BX, [SI+6]
;OUPUT
    MOV DL, BL
    MOV AH,2
    INT 21H
; LEFT

LEA SI, LEFT 
MOV BX, [SI]
;OUPUT
    MOV DL, BL
    MOV AH,2
    INT 21H
MOV BX, [SI+2]
;OUPUT
    MOV DL, BL
    MOV AH,2
    INT 21H
MOV BX, [SI+4]
;OUPUT
    MOV DL, BL
    MOV AH,2
    INT 21H
MOV BX, [SI+6]
;OUPUT
    MOV DL, BL
    MOV AH,2
    INT 21H
	
;FRONT 

LEA SI, FRONT 
MOV BX, [SI]
;OUPUT
    MOV DL, BL
    MOV AH,2
    INT 21H
MOV BX, [SI+2]
;OUPUT
    MOV DL, BL
    MOV AH,2
    INT 21H
MOV BX, [SI+4]
;OUPUT
    MOV DL, BL
    MOV AH,2
    INT 21H
MOV BX, [SI+6]
;OUPUT
    MOV DL, BL
    MOV AH,2
    INT 21H
	
;RIGHT
LEA SI, RIGHT  
MOV BX, [SI]
;OUPUT
    MOV DL, BL
    MOV AH,2
    INT 21H
MOV BX, [SI+2]
;OUPUT
    MOV DL, BL
    MOV AH,2
    INT 21H
MOV BX, [SI+4]
;OUPUT
    MOV DL, BL
    MOV AH,2
    INT 21H
MOV BX, [SI+6]
;OUPUT
    MOV DL, BL
    MOV AH,2
    INT 21H

	;BACK
LEA SI, BACK 
MOV BX, [SI]
;OUPUT
    MOV DL, BL
    MOV AH,2
    INT 21H
MOV BX, [SI+2]
;OUPUT
    MOV DL, BL
    MOV AH,2
    INT 21H
MOV BX, [SI+4]
;OUPUT
    MOV DL, BL
    MOV AH,2
    INT 21H
MOV BX, [SI+6]
;OUPUT
    MOV DL, BL
    MOV AH,2
    INT 21H
	;DOWN 
LEA SI, DOWN 
MOV BX, [SI]
;OUPUT
    MOV DL, BL
    MOV AH,2
    INT 21H
MOV BX, [SI+2]
;OUPUT
    MOV DL, BL
    MOV AH,2
    INT 21H
MOV BX, [SI+4]
;OUPUT
    MOV DL, BL
    MOV AH,2
    INT 21H
MOV BX, [SI+6]
;OUPUT
    MOV DL, BL
    MOV AH,2
    INT 21H
	;PRINT NEW LINE
    MOV AH,2
    MOV DL, 0DH; CARRIAGE RETURN
    INT 21H
    
    MOV DL, 0AH; lINE FEED
    INT 21H
    ;NEWLINE CLOSED
	
	pop di 
	pop si 
	pop dx 
	pop cx 
	pop bx 
	pop ax 
	RET 
PRINTER ENDP

D PROC 

	PUSH AX
	PUSH BX
	PUSH CX
	PUSH DX
	PUSH SI
	PUSH DI
	;/********/
	MOV AX, 0 
	LEA SI, BACK 
	MOV AX, [SI+6] 
	MOV TEMP0 , AX 
	MOV AX, [SI+4] 
	MOV TEMP1 , AX 
	
	;/**********/
	LEA DI, RIGHT 
	MOV AX, [DI+6] 
	MOV [SI+6], AX 
	MOV AX, [DI+4]
	MOV [SI+4], AX
;/*****************/
		
	LEA SI, FRONT 
	MOV AX, [SI+6] 
	MOV [DI+6], AX 
	MOV AX, [SI+4]
	MOV [DI+4], AX
;/**
	LEA DI, LEFT 
	MOV AX, [DI+6] 
	MOV [SI+6], AX 
	MOV AX, [DI+4]
	MOV [SI+4], AX
;/**
	MOV AX, TEMP0 
	MOV [DI+6], AX 
	MOV AX, TEMP1 
	MOV [DI+4], AX
	
	;/down SIDE ROTATE*/
	LEA SI, DOWN 
	MOV AX, [SI] 
	MOV TEMP1, AX ; TEMP1 = U0 
	MOV AX, [SI+6] ; AX = U1
	MOV [SI], AX  ; U0 = AX = U1
	MOV AX, [SI+4] ; AX = U2
	MOV  [SI+6], AX ; U1 = U2 = AX 
	MOV AX, [SI+2]
	MOV [SI+4], AX ; U2 = U3 = AX 
	MOV AX, TEMP1 ; AX = T1 = U0 
	MOV [SI+2], AX ; U3 = U0 = AX 
	;/********/
	mov Ax, 'D' 
	call SaveMoves
	call Checker
	;/********/
	POP DI
	POP SI
	POP DX
	POP CX
	POP BX
	POP AX
	RET
D ENDP  
;/*********/
MAINEXIT8:

;/********/
END MAIN




