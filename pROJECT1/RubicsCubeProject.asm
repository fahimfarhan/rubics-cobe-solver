ORG 100H
.STACK 100H
.MODEL SMALL
.DATA

UP 	  DW 'Y','Y','Y','Y'
FRONT DW 'G','G','G','G' 
LEFT  DW 'R','R','R','R'
RIGHT DW 'O','O','O','O'
BACK  DW 'B','B','B','B'
DOWN  DW 'W','W','W','W'

TEMP1  DW  0
TEMP2  DW  0
TEMP0  DW  0
.CODE

MAIN PROC
	MOV AX, @DATA
	MOV DS, AX
	MOV ES, AX
	;/*PORE EI KHANE CODE LEKHA HOBE*/ 
	CALL FI
	CALL PRINTER
	CALL BI 
	CALL PRINTER
	CALL D 
	CALL PRINTER
	CALL UI
	CALL PRINTER
	CALL R
	CALL PRINTER
	CALL LI
	CALL PRINTER
	;
	CALL L 
	CALL PRINTER
	CALL RI
	CALL PRINTER
	CALL U
	CALL PRINTER
	CALL ID
	CALL PRINTER
	CALL B
	CALL PRINTER
	CALL F
	CALL PRINTER
	
	
	;/*TO BE CONTINUED ...  ...  ...*/
MAIN ENDP 
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
	;/********/
	POP DI
	POP SI
	POP DX
	POP CX
	POP BX
	POP AX
	RET
FI ENDP;/***********/
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
	POP DI
	POP SI
	POP DX
	POP CX
	POP BX
	POP AX
	RET
Ri ENDP
;/***********/

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
	POP DI
	POP SI
	POP DX
	POP CX
	POP BX
	POP AX
	RET
iD ENDP

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
	POP DI
	POP SI
	POP DX
	POP CX
	POP BX
	POP AX
	RET
U ENDP

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


;/********/
END MAIN




