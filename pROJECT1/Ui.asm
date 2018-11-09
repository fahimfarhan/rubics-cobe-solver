
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
