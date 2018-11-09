org 100h 
.stack 100h 
.model small 

.data
count52 dw 0 
.code 

main proc 

mov ax, 0
sub ax, 32
main endp

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
mnp cx, 4 
JE counter_for_loop_break 
jmp  Counter_for_loop

counter_for_loop_break:

mov count52 , Cx 
pop di 
pop si 
pop dx 
pop cx 
pop bx 
pop ax 

Counter1 endp

end main