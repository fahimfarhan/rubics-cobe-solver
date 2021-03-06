Di PROC 

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
Di ENDP
