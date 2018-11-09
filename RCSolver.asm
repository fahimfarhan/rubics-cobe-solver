; 1. this language is case insensitive, but we are NOT :|
; 2. damn indexing. array indexes should be 0,2,4,6-- after all, we have word array >_<
org 100h
.model small
.stack 100h

.data
up      dw 'w','w','w','w'
left    dw 'r','r','r','r'
front   dw 'b','b','b','b'
right   dw 'o','o','o','o'
back    dw 'g','g','g','g'
down    dw 'y','y','y','y'
backup  dw 24 dup(0)
moves   dw 256 dup(0)

temp0   dw 0
temp1   dw 0
temp2   dw 0
index   dw 0
temp45  dw 0
count52 dw 0
father_of_index dw 0

error1_52           db "array out of range! $"
StringAlgo52        db " press SPACE to see output step by step                                         Algorithm: $"
String525252        db "Please enter the inputs! $"
StringUp52          db "Enter Up face: $"
Stringleft52        db "Enter left face: $"
Stringfront52       db "Enter front face: $"
Stringright52       db "Enter right face: $"
StringBack52        db "Enter back face: $"
StringDown52        db "Enter down face: $"
StringNumberOfMoves db "Number of moves: $"

;used by nobel
bool  dw 0
temp4 dw 0
oll_prompt_sym             db 'oll symmetric',0dh,0ah,'$'
oll_prompt_nonsym          db 'oll non-symmetric',0dh,0ah,'$'
oll_prompt_sune            db 'oll sune',0dh,0ah,'$'
oll_prompt_antisune        db 'oll antisune',0dh,0ah,'$'
oll_prompt_diagonalcorners db 'oll diagonal corners',0dh,0ah,'$'
oll_prompt_chameleon       db 'oll chameleon',0dh,0ah,'$'
oll_prompt_headlight       db 'oll headlight',0dh,0ah,'$'
oll_prompt_skip            db 'oll skip!',0dh,0ah,'$'
pll_prompt_adjacent        db 'pll adjacent',0dh,0ah,'$'
pll_prompt_diagonal        db 'pll diagonal',0dh,0ah,'$'
pll_prompt_skip            db 'pll skip!',0dh,0ah,'$'

;variables for graphics
cube_square_size        dw 15
cube_square_margin      dw 2
cube_square_row_end     dw 0
cube_square_col_end     dw 0
cube_square_initial_col dw 130
cube_square_initial_row dw 65
cover_page_text         db '                                               2x2x2 RUBIKS CUBE SOLVER                                                                                               press any key to continue...$'
cover_page_quitext      db '          press ESC to quit $'
cube_solved_string      db '               Solved!$'
number_of_moves_string  db 'Number of moves: $'
play_again_string       db '       press ENTER for main menu $'

.code
main proc
    mov ax, @data
    mov ds, ax
    
    till_kingdom_comes:
        ;initialize variables
        xor ax,ax
        mov index,ax
        mov father_of_index,ax
        
        ;display cover page
        call a_clear_vga_page
        call display_cover_page
        
        ;wait for a key to press
            push ax
            mov ah,1
            int 21h
            cmp al,1bh ;is it esc?
                je return_main
            ;else
            pop ax
            
        ;display input page
        call a_clear_vga_page
        call start_formal_prompts
        call InputBackup
        
        ;calculate
        call place_corner_1
        call place_another_corner
        call place_another_corner   
        call place_another_corner
        call do_oll
        call do_pll
        
        ;restore inpute
        call InputRestor
        
        ;output page
        call a_clear_vga_page
        call VGAdisplay
        
        ;wait for another key to press
        call wait_for_an_enter_to_press
    jmp till_kingdom_comes
    
    return_main:
    mov ah,4ch
    int 21h
main endp
jmp mainexit52_1

;Display procedures...................................................................................

a_clear_vga_page proc
    ;Input : none
    ;Output: a clear vga page
    ;Uses  : none
    
    push ax
    push bx
    push cx
    push dx
    
    ;set mode
    mov ah,0
    mov al,13h
    int 10h
    
    ;call display_cube_array_and_texts
    ;call EfficientSolver
    
    return_a_clear_vga_page:
        pop dx
        pop cx
        pop bx
        pop ax
        ret
a_clear_vga_page endp

VGAdisplay proc
    ;Input : none
    ;Output: display the cube and other texts
    ;Uses  : display_square_at_cxdx
    
    push ax
    push bx
    push cx
    push dx
    
    ;set mode
    mov ah,0
    mov al,13h
    int 10h
    
    call display_cube_array_and_texts
    call EfficientSolver
    
    return_VGAdisplay:
        pop dx
        pop cx
        pop bx
        pop ax
        ret
VGAdisplay endp

display_character_stuffs proc
    ;Input : Offset of string in si
    ;        dh = desired row
    ;        dl = desired column
    ;Output: Printed string
    ;Uses  : None
    
    push ax
    push bx
    push cx
    ;Wont push dx. I need this value for farther prints
    
    ;probably for backgorund colour
    mov ah,0bh
    mov bh,00h ;select background colour
    mov bl,0 ;which color? :|
    int 10h
    
    display_character_stuffs_while:
        ;check condition
        cmp byte ptr [si],'$'
        je display_character_stuffs_while_end
        ;inside the loop
        ;set cursor
            mov ah,02 ;set cursor
            mov bh,0 ;page
            ;dx already has desired value
            int 10h
        ;display character
            mov ah,9 ;char function
            mov al, byte ptr [si] ;char to display
            mov bl,1111b ;colour of char
            mov cx,1 ;write a char
            int 10h
        inc si ;to the next character
        inc dl ;to the next column
        cmp dl,40 ;end of the line?
            jne okay_display_character_continue_loop
            ;yap, end of the line
            inc dh ;to the next row
            xor dl,dl ;0'th column of next row
        okay_display_character_continue_loop:
        jmp display_character_stuffs_while
    display_character_stuffs_while_end:
    
    ;pop dx
    pop cx
    pop bx
    pop ax
    ret
display_character_stuffs endp

display_cube_array_and_texts proc
    push ax
    push bx
    push cx
    push dx
    
    mov ah,0ch  ;write pixel function
    mov bh,0    ;page 0
    
    ;display characters
    push si
    push ax
    push bx
    push cx
    push dx
    lea si,StringAlgo52 ;offset address of string
    mov dh,0 ;row of first char
    mov dl,0 ;column of first char
    call display_character_stuffs
    ;display algorithms till current
    lea si,moves
    xor cx,cx ;cx is to count whether it is equal to index
    haha_hihi_algorithm_output_loop:
        cmp cx,index
            jne continue_haha_hihi_algorithm_output_loop
            jmp haha_hihi_algorithm_output_loop_end
        continue_haha_hihi_algorithm_output_loop:
        ;set cursor
            mov ah,02 ;set cursor
            mov bh,0 ;page
            ;dx already has desired value
            int 10h
        ;display character
            mov ah,9 ;char function
            mov al, byte ptr [si] ;char to display
            mov bl,1111b ;colour of char
            push cx ;we need it to compare with index
            mov cx,1 ;write a char
            int 10h
            pop cx ;we need it to compare with index
        add si,2 ;to the next move character
        add cx,2 ;next index
        inc dl ;to the next column
        cmp dl,40 ;end of the line?
            jne okay_continue_haha_hihi_algorithm_output_loop
            ;yap, end of the line
            inc dh ;to the next row
            xor dl,dl ;0'th column of next row
        okay_continue_haha_hihi_algorithm_output_loop:
        jmp haha_hihi_algorithm_output_loop
    haha_hihi_algorithm_output_loop_end:

    pop dx
    pop cx
    pop bx
    pop ax
    pop si
    
    ;display up[0]
        ;put colour
            push bx
            mov bx,up[0]
            call put_colour_in_al
            pop bx
        mov cx,cube_square_initial_col
        mov dx,cube_square_initial_row
        call display_square_at_cxdx 
    ;display up[1]
        ;put colour
            push bx
            mov bx,up[2]
            call put_colour_in_al
            pop bx
        mov cx,cube_square_initial_col
            add cx,cube_square_size
            add cx,cube_square_margin
        mov dx,cube_square_initial_row
        call display_square_at_cxdx
    ;display up[2]
        ;put colour
            push bx
            mov bx,up[4]
            call put_colour_in_al
            pop bx
        mov cx,cube_square_initial_col
            add cx,cube_square_size
            add cx,cube_square_margin
        mov dx,cube_square_initial_row
            add dx,cube_square_size
            add dx,cube_square_margin
        call display_square_at_cxdx
    ;display up[3]
        ;put colour
            push bx
            mov bx,up[6]
            call put_colour_in_al
            pop bx
        mov cx,cube_square_initial_col
        mov dx,cube_square_initial_row
            add dx,cube_square_size
            add dx,cube_square_margin
        call display_square_at_cxdx
        
        
    ;display left[0]
        ;put colour
            push bx
            mov bx,left[0]
            call put_colour_in_al
            pop bx
        mov cx,cube_square_initial_col
            sub cx,cube_square_size
            sub cx,cube_square_margin
            sub cx,cube_square_size
            sub cx,cube_square_margin
        mov dx,cube_square_initial_row
            add dx,cube_square_size
            add dx,cube_square_margin
            add dx,cube_square_size
            add dx,cube_square_margin
        call display_square_at_cxdx 
    ;display left[1]
        ;put colour
            push bx
            mov bx,left[2]
            call put_colour_in_al
            pop bx
        mov cx,cube_square_initial_col
            sub cx,cube_square_size
            sub cx,cube_square_margin
        mov dx,cube_square_initial_row
            add dx,cube_square_size
            add dx,cube_square_margin
            add dx,cube_square_size
            add dx,cube_square_margin
        call display_square_at_cxdx 
    ;display left[2]
        ;put colour
            push bx
            mov bx,left[4]
            call put_colour_in_al
            pop bx
        mov cx,cube_square_initial_col
            sub cx,cube_square_size
            sub cx,cube_square_margin
        mov dx,cube_square_initial_row
            add dx,cube_square_size
            add dx,cube_square_margin
            add dx,cube_square_size
            add dx,cube_square_margin
            add dx,cube_square_size
            add dx,cube_square_margin
        call display_square_at_cxdx
    ;display left[3]
        ;put colour
            push bx
            mov bx,left[6]
            call put_colour_in_al
            pop bx
        mov cx,cube_square_initial_col
            sub cx,cube_square_size
            sub cx,cube_square_margin
            sub cx,cube_square_size
            sub cx,cube_square_margin
        mov dx,cube_square_initial_row
            add dx,cube_square_size
            add dx,cube_square_margin
            add dx,cube_square_size
            add dx,cube_square_margin
            add dx,cube_square_size
            add dx,cube_square_margin
        call display_square_at_cxdx
        
    ;display front[0]
        ;put colour
            push bx
            mov bx,front[0]
            call put_colour_in_al
            pop bx
        mov cx,cube_square_initial_col
        mov dx,cube_square_initial_row
            add dx,cube_square_size
            add dx,cube_square_margin
            add dx,cube_square_size
            add dx,cube_square_margin
        call display_square_at_cxdx 
    ;display front[1]
        ;put colour
            push bx
            mov bx,front[2]
            call put_colour_in_al
            pop bx
        mov cx,cube_square_initial_col
            add cx,cube_square_size
            add cx,cube_square_margin
        mov dx,cube_square_initial_row
            add dx,cube_square_size
            add dx,cube_square_margin
            add dx,cube_square_size
            add dx,cube_square_margin
        call display_square_at_cxdx 
    ;display front[2]
        ;put colour
            push bx
            mov bx,front[4]
            call put_colour_in_al
            pop bx
        mov cx,cube_square_initial_col
            add cx,cube_square_size
            add cx,cube_square_margin
        mov dx,cube_square_initial_row
            add dx,cube_square_size
            add dx,cube_square_margin
            add dx,cube_square_size
            add dx,cube_square_margin
            add dx,cube_square_size
            add dx,cube_square_margin
        call display_square_at_cxdx
    ;display front[3]
        ;put colour
            push bx
            mov bx,front[6]
            call put_colour_in_al
            pop bx
        mov cx,cube_square_initial_col
        mov dx,cube_square_initial_row
            add dx,cube_square_size
            add dx,cube_square_margin
            add dx,cube_square_size
            add dx,cube_square_margin
            add dx,cube_square_size
            add dx,cube_square_margin
        call display_square_at_cxdx
        
        
    ;display right[0]
        ;put colour
            push bx
            mov bx,right[0]
            call put_colour_in_al
            pop bx
        mov cx,cube_square_initial_col
            add cx,cube_square_size
            add cx,cube_square_margin
            add cx,cube_square_size
            add cx,cube_square_margin
        mov dx,cube_square_initial_row
            add dx,cube_square_size
            add dx,cube_square_margin
            add dx,cube_square_size
            add dx,cube_square_margin
        call display_square_at_cxdx 
    ;display right[1]
        ;put colour
            push bx
            mov bx,right[2]
            call put_colour_in_al
            pop bx
        mov cx,cube_square_initial_col
            add cx,cube_square_size
            add cx,cube_square_margin
            add cx,cube_square_size
            add cx,cube_square_margin
            add cx,cube_square_size
            add cx,cube_square_margin
        mov dx,cube_square_initial_row
            add dx,cube_square_size
            add dx,cube_square_margin
            add dx,cube_square_size
            add dx,cube_square_margin
        call display_square_at_cxdx 
    ;display right[2]
        ;put colour
            push bx
            mov bx,right[4]
            call put_colour_in_al
            pop bx
        mov cx,cube_square_initial_col
            add cx,cube_square_size
            add cx,cube_square_margin
            add cx,cube_square_size
            add cx,cube_square_margin
            add cx,cube_square_size
            add cx,cube_square_margin
        mov dx,cube_square_initial_row
            add dx,cube_square_size
            add dx,cube_square_margin
            add dx,cube_square_size
            add dx,cube_square_margin
            add dx,cube_square_size
            add dx,cube_square_margin
        call display_square_at_cxdx
    ;display right[3]
        ;put colour
            push bx
            mov bx,right[6]
            call put_colour_in_al
            pop bx
        mov cx,cube_square_initial_col
            add cx,cube_square_size
            add cx,cube_square_margin
            add cx,cube_square_size
            add cx,cube_square_margin
        mov dx,cube_square_initial_row
            add dx,cube_square_size
            add dx,cube_square_margin
            add dx,cube_square_size
            add dx,cube_square_margin
            add dx,cube_square_size
            add dx,cube_square_margin
        call display_square_at_cxdx
        
        
    ;display back[0]
        ;put colour
            push bx
            mov bx,back[0]
            call put_colour_in_al
            pop bx
        mov cx,cube_square_initial_col
            add cx,cube_square_size
            add cx,cube_square_margin
            add cx,cube_square_size
            add cx,cube_square_margin
            add cx,cube_square_size
            add cx,cube_square_margin
            add cx,cube_square_size
            add cx,cube_square_margin
        mov dx,cube_square_initial_row
            add dx,cube_square_size
            add dx,cube_square_margin
            add dx,cube_square_size
            add dx,cube_square_margin
        call display_square_at_cxdx 
    ;display back[1]
        ;put colour
            push bx
            mov bx,back[2]
            call put_colour_in_al
            pop bx
        mov cx,cube_square_initial_col
            add cx,cube_square_size
            add cx,cube_square_margin
            add cx,cube_square_size
            add cx,cube_square_margin
            add cx,cube_square_size
            add cx,cube_square_margin
            add cx,cube_square_size
            add cx,cube_square_margin
            add cx,cube_square_size
            add cx,cube_square_margin
        mov dx,cube_square_initial_row
            add dx,cube_square_size
            add dx,cube_square_margin
            add dx,cube_square_size
            add dx,cube_square_margin
        call display_square_at_cxdx 
    ;display back[2]
        ;put colour
            push bx
            mov bx,back[4]
            call put_colour_in_al
            pop bx
        mov cx,cube_square_initial_col
            add cx,cube_square_size
            add cx,cube_square_margin
            add cx,cube_square_size
            add cx,cube_square_margin
            add cx,cube_square_size
            add cx,cube_square_margin
            add cx,cube_square_size
            add cx,cube_square_margin
            add cx,cube_square_size
            add cx,cube_square_margin
        mov dx,cube_square_initial_row
            add dx,cube_square_size
            add dx,cube_square_margin
            add dx,cube_square_size
            add dx,cube_square_margin
            add dx,cube_square_size
            add dx,cube_square_margin
        call display_square_at_cxdx
    ;display back[3]
        ;put colour
            push bx
            mov bx,back[6]
            call put_colour_in_al
            pop bx
        mov cx,cube_square_initial_col
            add cx,cube_square_size
            add cx,cube_square_margin
            add cx,cube_square_size
            add cx,cube_square_margin
            add cx,cube_square_size
            add cx,cube_square_margin
            add cx,cube_square_size
            add cx,cube_square_margin
        mov dx,cube_square_initial_row
            add dx,cube_square_size
            add dx,cube_square_margin
            add dx,cube_square_size
            add dx,cube_square_margin
            add dx,cube_square_size
            add dx,cube_square_margin
        call display_square_at_cxdx
        
        
    ;display down[0]
        ;put colour
            push bx
            mov bx,down[0]
            call put_colour_in_al
            pop bx
        mov cx,cube_square_initial_col
        mov dx,cube_square_initial_row
            add dx,cube_square_size
            add dx,cube_square_margin
            add dx,cube_square_size
            add dx,cube_square_margin
            add dx,cube_square_size
            add dx,cube_square_margin
            add dx,cube_square_size
            add dx,cube_square_margin
        call display_square_at_cxdx
    ;display down[1]
        ;put colour
            push bx
            mov bx,down[2]
            call put_colour_in_al
            pop bx
        mov cx,cube_square_initial_col
            add cx,cube_square_size
            add cx,cube_square_margin
        mov dx,cube_square_initial_row
            add dx,cube_square_size
            add dx,cube_square_margin
            add dx,cube_square_size
            add dx,cube_square_margin
            add dx,cube_square_size
            add dx,cube_square_margin
            add dx,cube_square_size
            add dx,cube_square_margin
        call display_square_at_cxdx 
   ;display down[2]
        ;put colour
            push bx
            mov bx,down[4]
            call put_colour_in_al
            pop bx
        mov cx,cube_square_initial_col
            add cx,cube_square_size
            add cx,cube_square_margin
        mov dx,cube_square_initial_row
            add dx,cube_square_size
            add dx,cube_square_margin
            add dx,cube_square_size
            add dx,cube_square_margin
            add dx,cube_square_size
            add dx,cube_square_margin
            add dx,cube_square_size
            add dx,cube_square_margin
            add dx,cube_square_size
            add dx,cube_square_margin
        call display_square_at_cxdx
   ;display down[3]
        ;put colour
            push bx
            mov bx,down[6]
            call put_colour_in_al
            pop bx
        mov cx,cube_square_initial_col
        mov dx,cube_square_initial_row
            add dx,cube_square_size
            add dx,cube_square_margin
            add dx,cube_square_size
            add dx,cube_square_margin
            add dx,cube_square_size
            add dx,cube_square_margin
            add dx,cube_square_size
            add dx,cube_square_margin
            add dx,cube_square_size
            add dx,cube_square_margin
        call display_square_at_cxdx
    
        
    return_display_cube_array_and_texts:
        pop dx
        pop cx
        pop bx
        pop ax
        ret
display_cube_array_and_texts endp

display_cover_page proc
    push ax
    push bx
    push cx
    push dx
    
    mov ah,0ch  ;write pixel function
    mov bh,0    ;page 0
    
    ;display characters
    push si
    push ax
    push bx
    push cx
    push dx
    ;display upper strings
    lea si,cover_page_text ;offset address of string
    mov dh,0 ;row of first char
    mov dl,0 ;column of first char
    call display_character_stuffs
    ;display string to quit
    lea si,cover_page_quitext
    mov dh,22 ;row of first char
    mov dl,0 ;column of first char
    call display_character_stuffs
    pop dx
    pop cx
    pop bx
    pop ax
    pop si
    
    ;display up[0]
        ;put colour
            push bx
            mov bx,up[0]
            call put_colour_in_al
            pop bx
        mov cx,cube_square_initial_col
        mov dx,cube_square_initial_row
        call display_square_at_cxdx 
    ;display up[1]
        ;put colour
            push bx
            mov bx,up[2]
            call put_colour_in_al
            pop bx
        mov cx,cube_square_initial_col
            add cx,cube_square_size
            add cx,cube_square_margin
        mov dx,cube_square_initial_row
        call display_square_at_cxdx
    ;display up[2]
        ;put colour
            push bx
            mov bx,up[4]
            call put_colour_in_al
            pop bx
        mov cx,cube_square_initial_col
            add cx,cube_square_size
            add cx,cube_square_margin
        mov dx,cube_square_initial_row
            add dx,cube_square_size
            add dx,cube_square_margin
        call display_square_at_cxdx
    ;display up[3]
        ;put colour
            push bx
            mov bx,up[6]
            call put_colour_in_al
            pop bx
        mov cx,cube_square_initial_col
        mov dx,cube_square_initial_row
            add dx,cube_square_size
            add dx,cube_square_margin
        call display_square_at_cxdx
        
        
    ;display left[0]
        ;put colour
            push bx
            mov bx,left[0]
            call put_colour_in_al
            pop bx
        mov cx,cube_square_initial_col
            sub cx,cube_square_size
            sub cx,cube_square_margin
            sub cx,cube_square_size
            sub cx,cube_square_margin
        mov dx,cube_square_initial_row
            add dx,cube_square_size
            add dx,cube_square_margin
            add dx,cube_square_size
            add dx,cube_square_margin
        call display_square_at_cxdx 
    ;display left[1]
        ;put colour
            push bx
            mov bx,left[2]
            call put_colour_in_al
            pop bx
        mov cx,cube_square_initial_col
            sub cx,cube_square_size
            sub cx,cube_square_margin
        mov dx,cube_square_initial_row
            add dx,cube_square_size
            add dx,cube_square_margin
            add dx,cube_square_size
            add dx,cube_square_margin
        call display_square_at_cxdx 
    ;display left[2]
        ;put colour
            push bx
            mov bx,left[4]
            call put_colour_in_al
            pop bx
        mov cx,cube_square_initial_col
            sub cx,cube_square_size
            sub cx,cube_square_margin
        mov dx,cube_square_initial_row
            add dx,cube_square_size
            add dx,cube_square_margin
            add dx,cube_square_size
            add dx,cube_square_margin
            add dx,cube_square_size
            add dx,cube_square_margin
        call display_square_at_cxdx
    ;display left[3]
        ;put colour
            push bx
            mov bx,left[6]
            call put_colour_in_al
            pop bx
        mov cx,cube_square_initial_col
            sub cx,cube_square_size
            sub cx,cube_square_margin
            sub cx,cube_square_size
            sub cx,cube_square_margin
        mov dx,cube_square_initial_row
            add dx,cube_square_size
            add dx,cube_square_margin
            add dx,cube_square_size
            add dx,cube_square_margin
            add dx,cube_square_size
            add dx,cube_square_margin
        call display_square_at_cxdx
        
    ;display front[0]
        ;put colour
            push bx
            mov bx,front[0]
            call put_colour_in_al
            pop bx
        mov cx,cube_square_initial_col
        mov dx,cube_square_initial_row
            add dx,cube_square_size
            add dx,cube_square_margin
            add dx,cube_square_size
            add dx,cube_square_margin
        call display_square_at_cxdx 
    ;display front[1]
        ;put colour
            push bx
            mov bx,front[2]
            call put_colour_in_al
            pop bx
        mov cx,cube_square_initial_col
            add cx,cube_square_size
            add cx,cube_square_margin
        mov dx,cube_square_initial_row
            add dx,cube_square_size
            add dx,cube_square_margin
            add dx,cube_square_size
            add dx,cube_square_margin
        call display_square_at_cxdx 
    ;display front[2]
        ;put colour
            push bx
            mov bx,front[4]
            call put_colour_in_al
            pop bx
        mov cx,cube_square_initial_col
            add cx,cube_square_size
            add cx,cube_square_margin
        mov dx,cube_square_initial_row
            add dx,cube_square_size
            add dx,cube_square_margin
            add dx,cube_square_size
            add dx,cube_square_margin
            add dx,cube_square_size
            add dx,cube_square_margin
        call display_square_at_cxdx
    ;display front[3]
        ;put colour
            push bx
            mov bx,front[6]
            call put_colour_in_al
            pop bx
        mov cx,cube_square_initial_col
        mov dx,cube_square_initial_row
            add dx,cube_square_size
            add dx,cube_square_margin
            add dx,cube_square_size
            add dx,cube_square_margin
            add dx,cube_square_size
            add dx,cube_square_margin
        call display_square_at_cxdx
        
        
    ;display right[0]
        ;put colour
            push bx
            mov bx,right[0]
            call put_colour_in_al
            pop bx
        mov cx,cube_square_initial_col
            add cx,cube_square_size
            add cx,cube_square_margin
            add cx,cube_square_size
            add cx,cube_square_margin
        mov dx,cube_square_initial_row
            add dx,cube_square_size
            add dx,cube_square_margin
            add dx,cube_square_size
            add dx,cube_square_margin
        call display_square_at_cxdx 
    ;display right[1]
        ;put colour
            push bx
            mov bx,right[2]
            call put_colour_in_al
            pop bx
        mov cx,cube_square_initial_col
            add cx,cube_square_size
            add cx,cube_square_margin
            add cx,cube_square_size
            add cx,cube_square_margin
            add cx,cube_square_size
            add cx,cube_square_margin
        mov dx,cube_square_initial_row
            add dx,cube_square_size
            add dx,cube_square_margin
            add dx,cube_square_size
            add dx,cube_square_margin
        call display_square_at_cxdx 
    ;display right[2]
        ;put colour
            push bx
            mov bx,right[4]
            call put_colour_in_al
            pop bx
        mov cx,cube_square_initial_col
            add cx,cube_square_size
            add cx,cube_square_margin
            add cx,cube_square_size
            add cx,cube_square_margin
            add cx,cube_square_size
            add cx,cube_square_margin
        mov dx,cube_square_initial_row
            add dx,cube_square_size
            add dx,cube_square_margin
            add dx,cube_square_size
            add dx,cube_square_margin
            add dx,cube_square_size
            add dx,cube_square_margin
        call display_square_at_cxdx
    ;display right[3]
        ;put colour
            push bx
            mov bx,right[6]
            call put_colour_in_al
            pop bx
        mov cx,cube_square_initial_col
            add cx,cube_square_size
            add cx,cube_square_margin
            add cx,cube_square_size
            add cx,cube_square_margin
        mov dx,cube_square_initial_row
            add dx,cube_square_size
            add dx,cube_square_margin
            add dx,cube_square_size
            add dx,cube_square_margin
            add dx,cube_square_size
            add dx,cube_square_margin
        call display_square_at_cxdx
        
        
    ;display back[0]
        ;put colour
            push bx
            mov bx,back[0]
            call put_colour_in_al
            pop bx
        mov cx,cube_square_initial_col
            add cx,cube_square_size
            add cx,cube_square_margin
            add cx,cube_square_size
            add cx,cube_square_margin
            add cx,cube_square_size
            add cx,cube_square_margin
            add cx,cube_square_size
            add cx,cube_square_margin
        mov dx,cube_square_initial_row
            add dx,cube_square_size
            add dx,cube_square_margin
            add dx,cube_square_size
            add dx,cube_square_margin
        call display_square_at_cxdx 
    ;display back[1]
        ;put colour
            push bx
            mov bx,back[2]
            call put_colour_in_al
            pop bx
        mov cx,cube_square_initial_col
            add cx,cube_square_size
            add cx,cube_square_margin
            add cx,cube_square_size
            add cx,cube_square_margin
            add cx,cube_square_size
            add cx,cube_square_margin
            add cx,cube_square_size
            add cx,cube_square_margin
            add cx,cube_square_size
            add cx,cube_square_margin
        mov dx,cube_square_initial_row
            add dx,cube_square_size
            add dx,cube_square_margin
            add dx,cube_square_size
            add dx,cube_square_margin
        call display_square_at_cxdx 
    ;display back[2]
        ;put colour
            push bx
            mov bx,back[4]
            call put_colour_in_al
            pop bx
        mov cx,cube_square_initial_col
            add cx,cube_square_size
            add cx,cube_square_margin
            add cx,cube_square_size
            add cx,cube_square_margin
            add cx,cube_square_size
            add cx,cube_square_margin
            add cx,cube_square_size
            add cx,cube_square_margin
            add cx,cube_square_size
            add cx,cube_square_margin
        mov dx,cube_square_initial_row
            add dx,cube_square_size
            add dx,cube_square_margin
            add dx,cube_square_size
            add dx,cube_square_margin
            add dx,cube_square_size
            add dx,cube_square_margin
        call display_square_at_cxdx
    ;display back[3]
        ;put colour
            push bx
            mov bx,back[6]
            call put_colour_in_al
            pop bx
        mov cx,cube_square_initial_col
            add cx,cube_square_size
            add cx,cube_square_margin
            add cx,cube_square_size
            add cx,cube_square_margin
            add cx,cube_square_size
            add cx,cube_square_margin
            add cx,cube_square_size
            add cx,cube_square_margin
        mov dx,cube_square_initial_row
            add dx,cube_square_size
            add dx,cube_square_margin
            add dx,cube_square_size
            add dx,cube_square_margin
            add dx,cube_square_size
            add dx,cube_square_margin
        call display_square_at_cxdx
        
        
    ;display down[0]
        ;put colour
            push bx
            mov bx,down[0]
            call put_colour_in_al
            pop bx
        mov cx,cube_square_initial_col
        mov dx,cube_square_initial_row
            add dx,cube_square_size
            add dx,cube_square_margin
            add dx,cube_square_size
            add dx,cube_square_margin
            add dx,cube_square_size
            add dx,cube_square_margin
            add dx,cube_square_size
            add dx,cube_square_margin
        call display_square_at_cxdx
    ;display down[1]
        ;put colour
            push bx
            mov bx,down[2]
            call put_colour_in_al
            pop bx
        mov cx,cube_square_initial_col
            add cx,cube_square_size
            add cx,cube_square_margin
        mov dx,cube_square_initial_row
            add dx,cube_square_size
            add dx,cube_square_margin
            add dx,cube_square_size
            add dx,cube_square_margin
            add dx,cube_square_size
            add dx,cube_square_margin
            add dx,cube_square_size
            add dx,cube_square_margin
        call display_square_at_cxdx 
   ;display down[2]
        ;put colour
            push bx
            mov bx,down[4]
            call put_colour_in_al
            pop bx
        mov cx,cube_square_initial_col
            add cx,cube_square_size
            add cx,cube_square_margin
        mov dx,cube_square_initial_row
            add dx,cube_square_size
            add dx,cube_square_margin
            add dx,cube_square_size
            add dx,cube_square_margin
            add dx,cube_square_size
            add dx,cube_square_margin
            add dx,cube_square_size
            add dx,cube_square_margin
            add dx,cube_square_size
            add dx,cube_square_margin
        call display_square_at_cxdx
   ;display down[3]
        ;put colour
            push bx
            mov bx,down[6]
            call put_colour_in_al
            pop bx
        mov cx,cube_square_initial_col
        mov dx,cube_square_initial_row
            add dx,cube_square_size
            add dx,cube_square_margin
            add dx,cube_square_size
            add dx,cube_square_margin
            add dx,cube_square_size
            add dx,cube_square_margin
            add dx,cube_square_size
            add dx,cube_square_margin
            add dx,cube_square_size
            add dx,cube_square_margin
        call display_square_at_cxdx
    
        
        return_cover_page_end:
        pop dx
        pop cx
        pop bx
        pop ax
        ret
display_cover_page endp

put_colour_in_al proc
    ;Input  : color character in bx
    ;Output : color code in al
    
    ;Colours: Yellow: 00001110b
    ;         Orange: 00101011b == 43 ==2B
    ;         Blue  : 00001001b
    ;         Red   : 00001100b
    ;         Green : 00001010b
    ;         White : 00001111b
    
    cmp bx,'y'
    je put_colour_in_al_yellow
    cmp bx,'o'
    je put_colour_in_al_orange
    cmp bx,'b'
    je put_colour_in_al_blue
    cmp bx,'r'
    je put_colour_in_al_red
    cmp bx,'g'
    je put_colour_in_al_green
    cmp bx,'w'
    je put_colour_in_al_white
    ;default
    mov al,0000b
    jmp return_put_colour_in_al
    
    put_colour_in_al_yellow:
        mov al,1110b
        jmp return_put_colour_in_al
        
    put_colour_in_al_orange:
        mov al,43
        jmp return_put_colour_in_al
        
    put_colour_in_al_blue:
        mov al,1001b
        jmp return_put_colour_in_al
        
    put_colour_in_al_red:
        mov al,1100b
        jmp return_put_colour_in_al
        
    put_colour_in_al_green:
        mov al,1010b
        jmp return_put_colour_in_al
        
    put_colour_in_al_white:
        mov al,1111b
        jmp return_put_colour_in_al
    
    return_put_colour_in_al:
        ret
put_colour_in_al endp

display_square_at_cxdx proc
    ;Input : display function in ah
    ;        square colour in al
    ;        page in bh
    ;        square position (x,y) as (cx,dx)
    ;        square size in variable cube_square_size
    ;Output: a square displayed in (cx,dx)
    ;Uses  : none
    push ax
    push bx
    push cx
    push dx
    push cube_square_size
    
    ;initialize cube_square_row_end
    push cx
    add cx,cube_square_size
    mov cube_square_row_end,cx
    pop cx
    ;initialize cube_square_col_end
    push dx
    add dx,cube_square_size
    mov cube_square_col_end,dx
    pop dx
    
    ;and display
    display_square_at_cxdx_while_loop1:
        push dx ;because dx is going to change in the very next loop :3
        display_square_at_cxdx_while_loop2:
            int 10h
            inc dx
            cmp dx,cube_square_col_end
            je display_square_at_cxdx_while_loop2_end
            jmp display_square_at_cxdx_while_loop2
        display_square_at_cxdx_while_loop2_end:
        pop dx ;recover dx
        inc cx
        cmp cx,cube_square_row_end
        je display_square_at_cxdx_while_loop1_end
        jmp display_square_at_cxdx_while_loop1
    display_square_at_cxdx_while_loop1_end:
    
    return_display_square_at_cxdx:
        pop cube_square_size
        pop dx
        pop cx
        pop bx
        pop ax
        ret
display_square_at_cxdx endp

;Some more procedures..................................................................................

TakeInput proc 
    push Ax 
    push Bx 
    push Cx 
    push Dx 
    push Si 
    Push Di 

    ;PRINT StringUp52 
    MOV AH,9
    LEA DX, StringUp52 
    INT 21H
    ;/**********/
    ;1
    mov cx, 0 
    mov bx, 0 
    ; INPUT
    MOV AH, 1 ; CIN<<AL
    INT 21H   
    MOV cl, AL ; A = AL
    mov up[bx], cx 
    add bx, 2 
    ;2
        ; INPUT
    MOV AH, 1 ; CIN<<AL
    INT 21H   
    MOV cl, AL ; A = AL
    mov up[bx], cx 
    add bx, 2 
    ;3 
        ; INPUT
    MOV AH, 1 ; CIN<<AL
    INT 21H   
    MOV cl, AL ; A = AL
    mov up[bx], cx 
    add bx, 2 
    ;4
        ; INPUT
    MOV AH, 1 ; CIN<<AL
    INT 21H   
    MOV cl, AL ; A = AL
    mov up[bx], cx 
    add bx, 2 
    ;/****** left *******/
    call print_new_line
    ;PRINT Stringleft52 
    MOV AH,9
    LEA DX, Stringleft52 
    INT 21H
    ;/**********/
    ;1
    mov cx, 0 
    mov bx, 0 
    ; INPUT
    MOV AH, 1 ; CIN<<AL
    INT 21H   
    MOV cl, AL ; A = AL
    mov left[bx], cx 
    add bx, 2 
    ;2
        ; INPUT
    MOV AH, 1 ; CIN<<AL
    INT 21H   
    MOV cl, AL ; A = AL
    mov left[bx], cx 
    add bx, 2 
    ;3 
        ; INPUT
    MOV AH, 1 ; CIN<<AL
    INT 21H   
    MOV cl, AL ; A = AL
    mov left[bx], cx 
    add bx, 2 
    ;4
        ; INPUT
    MOV AH, 1 ; CIN<<AL
    INT 21H   
    MOV cl, AL ; A = AL
    mov left[bx], cx 
    add bx, 2
    ;/***** front ******/
    call print_new_line
    ;PRINT Stringfront52 
    MOV AH,9
    LEA DX, Stringfront52 
    INT 21H
    ;/**********/
    ;1
    mov cx, 0 
    mov bx, 0 
    ; INPUT
    MOV AH, 1 ; CIN<<AL
    INT 21H   
    MOV cl, AL ; A = AL
    mov front[bx], cx 
    add bx, 2 
    ;2
        ; INPUT
    MOV AH, 1 ; CIN<<AL
    INT 21H   
    MOV cl, AL ; A = AL
    mov front[bx], cx 
    add bx, 2 
    ;3 
        ; INPUT
    MOV AH, 1 ; CIN<<AL
    INT 21H   
    MOV cl, AL ; A = AL
    mov front[bx], cx 
    add bx, 2 
    ;4
        ; INPUT
    MOV AH, 1 ; CIN<<AL
    INT 21H   
    MOV cl, AL ; A = AL
    mov front[bx], cx 
    add bx, 2
    ;/*****right*****/ 
    call print_new_line
    ;PRINT Stringright52 
    MOV AH,9
    LEA DX, Stringright52 
    INT 21H
    ;/**********/
    ;1
    mov cx, 0 
    mov bx, 0 
    ; INPUT
    MOV AH, 1 ; CIN<<AL
    INT 21H   
    MOV cl, AL ; A = AL
    mov right[bx], cx 
    add bx, 2 
    ;2
        ; INPUT
    MOV AH, 1 ; CIN<<AL
    INT 21H   
    MOV cl, AL ; A = AL
    mov right[bx], cx 
    add bx, 2 
    ;3 
        ; INPUT
    MOV AH, 1 ; CIN<<AL
    INT 21H   
    MOV cl, AL ; A = AL
    mov right[bx], cx 
    add bx, 2 
    ;4
        ; INPUT
    MOV AH, 1 ; CIN<<AL
    INT 21H   
    MOV cl, AL ; A = AL
    mov right[bx], cx 
    add bx, 2   
    ;/****back****/
    call print_new_line
    ;PRINT Stringback52 
    MOV AH,9
    LEA DX, Stringback52 
    INT 21H
    ;/**********/
    ;1
    mov cx, 0 
    mov bx, 0 
    ; INPUT
    MOV AH, 1 ; CIN<<AL
    INT 21H   
    MOV cl, AL ; A = AL
    mov back[bx], cx 
    add bx, 2 
    ;2
        ; INPUT
    MOV AH, 1 ; CIN<<AL
    INT 21H   
    MOV cl, AL ; A = AL
    mov back[bx], cx 
    add bx, 2 
    ;3 
        ; INPUT
    MOV AH, 1 ; CIN<<AL
    INT 21H   
    MOV cl, AL ; A = AL
    mov back[bx], cx 
    add bx, 2 
    ;4
        ; INPUT
    MOV AH, 1 ; CIN<<AL
    INT 21H   
    MOV cl, AL ; A = AL
    mov back[bx], cx 
    add bx, 2
    ;/*******down*********/ 
    call print_new_line
    ;PRINT Stringdown52 
    MOV AH,9
    LEA DX, Stringdown52 
    INT 21H
    ;/**********/
    ;1
    mov cx, 0 
    mov bx, 0 
    ; INPUT
    MOV AH, 1 ; CIN<<AL
    INT 21H   
    MOV cl, AL ; A = AL
    mov down[bx], cx 
    add bx, 2 
    ;2
        ; INPUT
    MOV AH, 1 ; CIN<<AL
    INT 21H   
    MOV cl, AL ; A = AL
    mov down[bx], cx 
    add bx, 2 
    ;3 
        ; INPUT
    MOV AH, 1 ; CIN<<AL
    INT 21H   
    MOV cl, AL ; A = AL
    mov down[bx], cx 
    add bx, 2 
    ;4
        ; INPUT
    MOV AH, 1 ; CIN<<AL
    INT 21H   
    MOV cl, AL ; A = AL
    mov down[bx], cx 
    add bx, 2
    
    Pop Di 
    pop Si 
    pop Dx 
    pop cx 
    pop bx 
    pop Ax 
    Ret 
TakeInput Endp
mainexit52_1:  
jmp mainexit9

;Logic Functions by Nobel................................................................................
place_corner_1 proc
    ;Input : Cube Array
    ;Output: Corner 1 placed correctly in cube array
    ;        Success or failure as bool = 1 or 0
    ;Uses  : place_corner_1_from_upper_side proc
    
    push ax
    
    call place_corner_1_from_upper_side
    
    ;bool == 0 if failed
    cmp bool,0
    jne return_pc1 ;okay bool==1. so direct return.

    ;now, when bool==0, check if corner 1 is already placed
    cmp down[6],'w'
    jne else_pc1_1
    cmp left[6],'o'
    jne else_pc1_1
        ;yap corner 1 is placed already! make bool=1 and return
        mov ax,1
        mov bool,ax
        jmp return_pc1
    else_pc1_1:
        ;let's have a x2 move and place corner 1 from upper side :3
        call R
        call R
        call L
        call L
        call place_corner_1_from_upper_side
    
    return_pc1:
    pop ax
    ret
place_corner_1 endp

place_corner_1_from_upper_side proc
    ;Input : Cube Array
    ;Output: Corner placed correctly in cube array if it is in upper side
    ;        Success or failure as bool = 1 or 0
    ;Uses  : None
    
    push ax
    push cx
    
    ;for return value
    mov ax,0
    mov bool,ax
    
    ;if in upperface
    mov cx,4
    for_pc1fus_1:
        cmp up[0],'w'
        jne else_pc1fus_1
        cmp left[0],'g'
        jne else_pc1fus_1
            call U
            call B
            call B
            mov ax,1
            mov bool,ax ;for return value
            pop cx
            pop ax
            ret
        else_pc1fus_1:
            call U
            loop for_pc1fus_1
        
    ;if in left face
    mov cx,4
    for_pc1fus_2:
        cmp left[0],'w'
        jne else_pc1fus_2
        cmp back[2],'g'
        jne else_pc1fus_2
            call B
            mov ax,1
            mov bool,ax ;for return value
            pop cx
            pop ax
            ret
        else_pc1fus_2:
            call U
            loop for_pc1fus_2
        
    ;if in right face
    mov cx,4
    for_pc1fus_3:
        cmp back[2],'w'
        jne else_pc1fus_3
        cmp up[0],'g'
        jne else_pc1fus_3
            call Li
            mov ax,1
            mov bool,ax ;for return value
            pop cx
            pop ax
            ret
        else_pc1fus_3:
            call U
            loop for_pc1fus_3
    
    ;if it comes down here, false (bool=0) will be returned
    pop cx
    pop ax
    ret
place_corner_1_from_upper_side endp

place_another_corner proc
    ;Input : Cube Array
    ;Output: Another corner placed correctly in cube array
    ;        Success or failure as bool = 1 or 0
    ;Uses  : place_another_corner_from_upper_side
    
    push ax
    
    call place_another_corner_from_upper_side
    
    ;now bool==1 if another corner is placed correctly
    cmp bool,1
    jne try_recovering
    jmp return_pac ;okay bool==1. so direct return
    
    try_recovering:
    ;try recovering FLD
    cmp front[6],'w'
    je  if_pac_11
    cmp left[4],'w'
    je  if_pac_11
    ;else
    jmp if_pac_12   
    if_pac_11:
        call Li
        call Ui
        call L
        call place_another_corner_from_upper_side
        jmp return_pac
        
    if_pac_12:
        cmp down[0],'w'
        jne if_pac_13
        cmp front[6],'b'
        je  if_pac_13
            call Li
            call Ui
            call L
            call place_another_corner_from_upper_side
            jmp return_pac
    
    ;try recovering FRD
    if_pac_13:
        cmp front[4],'w'
        je  if_pac_14
        cmp right[6],'w'
        je  if_pac_14
        ;else
            jmp if_pac_15
    
    if_pac_14:
        call R
        call U
        call Ri
        call place_another_corner_from_upper_side
        jmp return_pac
    
    if_pac_15:
        cmp down[2],'w'
        jne if_pac_16
        cmp right[6],'r'
        je  if_pac_16
            call Fi
            call Ui
            call F
            call U
            call place_another_corner_from_upper_side
            jmp return_pac
    
    ;try recovering RBD
    if_pac_16:
        cmp right[4],'w'
        je  if_pac_17
        cmp back[6],'w'
        je  if_pac_17
        ;else
            jmp if_pac_18
    
    if_pac_17:
        call Ri
        call U
        call R
        call U
        call place_another_corner_from_upper_side
        jmp return_pac
    
    if_pac_18:
        cmp down[4],'w'
        jne if_pac_19
        cmp back[6],'g'
        je  if_pac_19
            call Ri
            call Ui
            call Ui
            call R
            call U
            call place_another_corner_from_upper_side
            jmp return_pac
                
    if_pac_19:
    return_pac:
        pop ax
        ret
place_another_corner endp

place_another_corner_from_upper_side proc
    ;Input : Cube Array
    ;Output: Another corner placed correctly in cube array if it is in upper side
    ;        Success or failure as bool = 1 or 0
    ;Uses  : None
    
    push ax
    push cx
    
    xor ax,ax
    mov bool,ax ; bool = 0 initially
    
    ;search for a RURi
    mov cx,4
    for_pacfus_1:
        cmp right[0],'w'
        jne else_pacfus_1
            cmp up[4],'b'
            jne else_pacfus_11
                call U
                call F
                call U
                call Fi
                ;yao, return true
                mov ax,1
                mov bool,ax
                jmp return_pacfus
            else_pacfus_11:
            cmp up[4],'g'
            jne else_pacfus_12
                call Ui
                call B
                call U
                call Bi
                ;yao, return true
                mov ax,1
                mov bool,ax
                jmp return_pacfus
            else_pacfus_12:
            cmp up[4],'r'
            jne else_pacfus_13
                call R
                call U
                call Ri
                ;yao, return true
                mov ax,1
                mov bool,ax
                jmp return_pacfus
            else_pacfus_13:
        else_pacfus_1:
            call U
            loop for_pacfus_1
        
    ;search for the mirror of previous one
    mov cx,4
    for_pacfus_2:
        cmp front[2],'w'
        jne else_pacfus_2
            cmp up[4],'o'
            jne else_pacfus_21
                call U
                call Li
                call Ui
                call L
                ;yao, return true
                mov ax,1
                mov bool,ax
                jmp return_pacfus
            else_pacfus_21:
            cmp up[4],'r'
            jne else_pacfus_22
                call Ui
                call Ri
                call Ui
                call R
                ;yao, return true
                mov ax,1
                mov bool,ax
                jmp return_pacfus
            else_pacfus_22:
            cmp up[4],'b'
            jne else_pacfus_23
                call Fi
                call Ui
                call F
                ;yao, return true
                mov ax,1
                mov bool,ax
                jmp return_pacfus
            else_pacfus_23:
        else_pacfus_2:
            call U
            loop for_pacfus_2
        
    ;search in the upper side
    mov cx,4
    for_pacfus_3:
        cmp up[4],'w'
        jne else_pacfus_3
            cmp front[2],'b'
            jne else_pacfus_31
                call U
                call Li
                call U
                call L
                call U
                call U
                call Li
                call Ui ;SHOW SOME RESPECT TO THIS UP INVERSE!
                call L
                ;yao, return true
                mov ax,1
                mov bool,ax
                jmp return_pacfus
            else_pacfus_31:
            cmp front[2],'r'
            jne else_pacfus_32
                call R
                call Ui
                call Ri
                call U
                call U
                call R
                call U
                call Ri
                ;yao, return true
                mov ax,1
                mov bool,ax
                jmp return_pacfus
            else_pacfus_32:
            cmp front[2],'g'
            jne else_pacfus_33
                call Ui
                call Ri
                call U
                call R
                call U
                call U
                call Ri
                call Ui
                call R
                ;yao, return true
                mov ax,1
                mov bool,ax
                jmp return_pacfus
            else_pacfus_33:
        else_pacfus_3:
            call U
            ;loop for_pacfus_3
            dec cx
            cmp cx,0
                je return_pacfus
            ;else
            jmp for_pacfus_3
    
    return_pacfus:
        pop cx
        pop ax
        ret
place_another_corner_from_upper_side endp

do_oll proc
    ;Input : Cube Array
    ;Output: OLL done in Cube Array
    ;        Success or failure as bool = 1 or 0
    ;Uses  : 
    
    push ax
    push dx
    
    ;make bool=0 and look for the number of yellows on upper side
    xor ax,ax
    mov bool,ax  ;bool  = 0
    mov temp4,ax ;temp4 = 0
    
    cmp up[0],'y'
    jne oll_cmp2
        inc temp4
    
    oll_cmp2:
    cmp up[2],'y'
    jne oll_cmp3
        inc temp4
    
    oll_cmp3:
    cmp up[4],'y'
    jne oll_cmp4
        inc temp4
    
    oll_cmp4:
    cmp up[6],'y'
    jne oll_cmp_end
        inc temp4
    
    oll_cmp_end: ;now temp4 == number of yellows on up
    
    cmp temp4,0
    je  no_yellow_on_up
    jmp one_or_more_yellows_on_up
    
    no_yellow_on_up:
        ;move yellow on front[2]
        while_oll_1:
            cmp  front[2],'y'
            je   end_while_oll_1
            call U
            jmp  while_oll_1
        end_while_oll_1:
        
        ;look for case symmetric
        cmp back[2],'y'
        jne nonsym_oll
            ;case sym
            mov ah,9
            lea dx,oll_prompt_sym
            int 21h
            ;algo for symmetric
            call R
            call R
            call U
            call U
            call R
            call U
            call U
            call R
            call R
            ;return true
            mov ax,1
            mov bool,ax
            jmp return_do_oll           
        nonsym_oll:
            ;case nonsym
            mov ah,9
            lea dx,oll_prompt_nonsym
            int 21h
            ;setup move
            cmp front[0],'y'
            jne no_setup_move_for_nonsym
                call U
            no_setup_move_for_nonsym:
            ;algo for non symmetric
            call F
            call R
            call U
            call Ri
            call Ui
            call R
            call U
            call Ri
            call Ui
            call Fi
            ;return true
            mov ax,1
            mov bool,ax
            jmp return_do_oll
    
    one_or_more_yellows_on_up:
        cmp temp4,1
        je  one_yellow_on_up
        jmp two_or_more_yellows_on_up
        
        one_yellow_on_up:
            ;search for sune and antisune
            ;first search for sune
            cmp front[2],'y'
            jne again_search_for_sune
                mov ah,9
                lea dx,oll_prompt_sune
                int 21h
                ;setup moves
                oll_sune_while1:
                    cmp up[6],'y'
                    je oll_sune_while_end1
                    call Ui
                    jmp oll_sune_while1
                oll_sune_while_end1:
                ;algo for sune
                call R
                call U
                call Ri
                call U 
                call R
                call U
                call U
                call Ri
                ;return true
                mov ax,1
                mov bool,ax
                jmp return_do_oll
            again_search_for_sune:
                call U
                cmp front[2],'y'
                jne surely_antisune
                    mov ah,9
                    lea dx,oll_prompt_sune
                    int 21h
                    ;setup moves
                    oll_sune_while2:
                        cmp up[6],'y'
                        je oll_sune_while_end2
                        call Ui
                        jmp oll_sune_while2
                    oll_sune_while_end2:
                    ;algo for sune
                    call R
                    call U
                    call Ri
                    call U 
                    call R
                    call U
                    call U
                    call Ri
                    ;return true
                    mov ax,1
                    mov bool,ax
                    jmp return_do_oll
            ;if still not returned, the case is surely antisune
            surely_antisune:
                mov ah,9
                lea dx,oll_prompt_antisune
                int 21h
                ;setup moves
                oll_antisune_while:
                    cmp up[0],'y'
                    je oll_antisune_while_end
                    call U
                    jmp oll_antisune_while
                oll_antisune_while_end:
                ;algo for antisune
                call Ri
                call Ui
                call R
                call Ui
                call Ri
                call Ui
                call Ui
                call R
                ;return true
                mov ax,1
                mov bool,ax
                jmp return_do_oll
        
        two_or_more_yellows_on_up:
            cmp temp4,2
            je  two_yellows_on_up
            jmp four_yellows_on_up
            
            two_yellows_on_up:
                ;search for headlight, chameleon or diagonal corners
                oll_tyup_while:
                    cmp front[2],'y'
                    je oll_tyup_while_end
                    call U
                    jmp oll_tyup_while
                oll_tyup_while_end:
                
                cmp left[0],'y'
                je  oll_diagonal_corners
                jmp oll_chameleon_or_headlight
                
                oll_diagonal_corners:
                    mov ah,9
                    lea dx,oll_prompt_diagonalcorners
                    int 21h
                    ;algo for diagonal corners
                    call Fi 
                    call R
                    call U
                    call Ri
                    call Ui
                    call Ri
                    call F
                    call R
                    ;return true
                    mov ax,1
                    mov bool,ax
                    jmp return_do_oll
                
                oll_chameleon_or_headlight:
                    cmp back[0],'y'
                    je oll_chameleon
                    jmp oll_headlight
                    
                    oll_chameleon:
                        mov ah,9
                        lea dx,oll_prompt_chameleon
                        int 21h
                        ;setup moves
                        call U
                        call U
                        ;algo for chameleon
                        call R
                        call U
                        call Ri
                        call Ui
                        call Ri
                        call F
                        call R
                        call Fi
                        ;return true
                        mov ax,1
                        mov bool,ax
                        jmp return_do_oll
                    
                    oll_headlight:
                        mov ah,9
                        lea dx,oll_prompt_headlight
                        int 21h
                        ;setup move
                        call Ui
                        ;algo for headlight
                        call F
                        call U
                        call R
                        call Ui
                        call Ri
                        call Fi
                        ;return true
                        mov ax,1
                        mov bool,ax
                        jmp return_do_oll
                
        four_yellows_on_up:
            ;this is necessarily oll skip! :D
            mov ah,9
            lea dx,oll_prompt_skip
            int 21h
            mov ax,1
            mov bool,ax
            jmp return_do_oll
            
    return_do_oll:
        pop dx
        pop ax
        ret 
do_oll endp

do_pll proc
    ;Input : Cube Array
    ;Output: PLL done in Cube Array
    ;        Success or failure as bool = 1 or 0
    ;Uses  : Move functions only
    
    push ax
    push cx
    push dx
    
    ;make bool=0 initially
    xor ax,ax
    mov bool,ax
    
    ;first look for adjacent (tperm)
    mov cx,4
    pll_adjacent_for_loop:
        mov ax,left[0]
        cmp ax,left[2]
        jne else_pll_adjacent_try_again
            mov ax,right[0]
            cmp ax,right[2]
            jne pll_t_perm
                ;it is the pll skip case
                mov ah,9
                lea dx,pll_prompt_skip
                int 21h
                ;finish with ups
                till_up_move_needed_1:
                    mov ax,front[0]
                    cmp ax,front[6]
                    je end_till_up_move_needed_1
                    call U
                    jmp till_up_move_needed_1
                end_till_up_move_needed_1:
                ;return true
                mov ax,1
                mov bool,ax
                jmp return_do_pll
            pll_t_perm:
                ;yap adjacent. apply t perm
                mov ah,9
                lea dx,pll_prompt_adjacent
                int 21h
                ;algo for t perm
                call R
                call U
                call Ri
                call Ui
                call Ri
                call F
                call R
                call R
                call Ui
                call Ri
                call Ui
                call R
                call U
                call Ri
                call Fi
                ;finish with ups
                till_up_move_needed_2:
                    mov ax,front[0]
                    cmp ax,front[6]
                    je end_till_up_move_needed_2
                    call U
                    jmp till_up_move_needed_2
                end_till_up_move_needed_2:
                ;return true
                mov ax,1
                mov bool,ax
                jmp return_do_pll               
        else_pll_adjacent_try_again:
            call U          
        loop pll_adjacent_for_loop
        
    ;as still not returned, it must be the diagonal case
    mov ah,9
    lea dx,pll_prompt_diagonal
    int 21h
    ;algo for diagonal case
    call R
    call Ui
    call Ri
    call Ui
    call F 
    call F
    call Ui
    call R
    call U
    call Ri
    call D
    call R
    call R
    ;and yeah, finish with ups
    till_up_move_needed_3:
        mov ax,front[0]
        cmp ax,front[6]
        je end_till_up_move_needed_3
        call U
        jmp till_up_move_needed_3
    end_till_up_move_needed_3:
    ;return true
    mov ax,1
    mov bool,ax
    jmp return_do_pll
    
    return_do_pll:
    pop dx
    pop cx
    pop ax
    ret
do_pll endp

;Procedures by Fahim...................................................................................
outdec proc
    ;input ax
    push ax
    push bx
    push cx
    push dx
    or ax,ax
    jge @end_if1
    push ax
    mov dl,'-'
    mov ah,2
    int 21h
    pop ax
    neg ax
    
    @end_if1:
    xor cx,cx
    mov bx,10d
    
    @repeat1:
    xor dx,dx
    div bx
    push dx
    inc cx
    or ax,ax
    jne @repeat1
    
    mov ah,2
    
    @print_loop:
    
    pop dx
    or dl,30h
    int 21h
    loop @print_loop
    
    pop dx
    pop cx
    pop bx
    pop ax
    ret
outdec endp

mainexit9:
jmp mainexit1 

showmoves proc
    push ax
    push bx
    push cx
    push dx
    push si
    push di 
    
    ;PRINT StringUp52 
    MOV AH,9
    LEA DX, StringAlgo52 ;will display **Solving algorithm: **
    INT 21H
    
    lea si, moves 
    mov cx, 0 
    loop_printershowmoves:
        cmp cx, index 
        jge exitshowmoves 
        mov bx, 0
        mov bx, [si]
        mov dl, bl
        mov ah,2
        int 21h
        add si, 2 
        add cx, 2 
        jmp loop_printershowmoves
    
    call print_new_line
    ;print s
    mov ah,9
    lea dx, error1_52
    int 21h
    call print_new_line
    
    exitshowmoves:
    pop di
    pop si
    pop dx 
    pop cx 
    pop bx 
    pop ax
    ret 
showmoves endp

show_number_of_moves proc
    push ax
    push bx
    push cx
    push dx
    
    mov ah,9
    lea dx,stringnumberofmoves
    int 21h
    mov Ax, index
    mov cl, 1 
    SHR ax, cl
    call OUTDEC
    
    pop dx
    pop cx
    pop bx
    pop ax
    ret
show_number_of_moves endp

;arrray moves has the f, u, ... and index points to the last pos
; count52 has the count 
backchecker proc
    push ax 
    push bx 
    push cx 
    push dx 
    push si 
    push di 
    
    mov ax, index 
    cmp ax, 4 
    jle exit_backchecker1
    call counter1 
    mov ax, count52 
    cmp ax, 3 
    jne exit_backchecker1 
    mov bx, index
    sub bx, 2  
    mov ax, 0 
    mov moves[bx], ax 
    sub bx, 2
    mov moves[bx], ax
    mov index, bx
    sub bx, 2 
    mov ax, moves[bx] 
    cmp ax, 96 
    jg u_to_u 
    add ax, 32 
    mov moves[bx], ax 
    jmp exit_backchecker1
    
    u_to_u: 
    sub ax, 32 
    mov moves[bx], ax 
    exit_backchecker1: 
    
    mov ax, index 
    cmp ax, 4 
    jl exit_backcheccker2
    ; else 
    mov bx, index 
    sub bx, 2 
    mov ax, moves[bx] 
    sub bx, 2 
    sub ax, moves[bx] 
    cmp ax, 32 
    je backcheckercaseuui 
    
    cmp ax,  0ffe0h;-32  
    jne exit_backcheccker2
    backcheckercaseuui:
        mov ax, 0 
        mov moves[bx], ax 
        mov index, bx 
        add bx, 2 
        mov moves[bx], 0 
    exit_backcheccker2:
    
    pop di 
    pop si 
    pop dx 
    pop cx 
    pop bx 
    pop ax 
    ret
backchecker endp
mainexit1:
jmp mainexit2

checker proc 
    push ax
    push bx
    push cx
    push dx
    push si
    push di              
    call backchecker 
    call backchecker
    pop di
    pop si
    pop dx 
    pop cx 
    pop bx 
    pop ax
    ret   
checker endp


 

;/************/ 
;user manual
; mov ax, 'f'
;call savemoves
savemoves proc
    push ax
    push bx
    push cx
    push dx
    push si
    push di
    
    mov bx, index 
    cmp bx, 500
    jge arrayoutofbondexceptioninshowmoves
    ;let ax has the name( f, f, u, d, d ... ...) 
    mov moves[bx], ax 
    add bx, 2 
    mov index, bx 
    arrayoutofbondexceptioninshowmoves:
    pop di
    pop si
    pop dx 
    pop cx 
    pop bx 
    pop ax
    ret   
savemoves endp 


counter1 proc 
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
    counter_for_loop: 
        
    mov ax, moves[bx]
    cmp bx, 2 
    jl counter_for_loop_break   
    sub bx, 2 
    cmp ax, moves[bx] 
    jne counter_for_loop_break
    add cx, 1 
    cmp cx, 4 
    jge counter_for_loop_break 
    jmp  counter_for_loop
    
    counter_for_loop_break:
    
    mov count52 , cx 
    pop di 
    pop si 
    pop dx 
    pop cx 
    pop bx 
    pop ax 
    ret
counter1 endp

;basic move functions.................................................................................
fi proc
    push ax
    push bx
    push cx
    push dx
    push si
    push di
    ;/********/
    ;/********/
    mov ax, 0 
    lea si, up
    mov ax, [si+6] 
    mov temp0 , ax 
    mov ax, [si+4] 
    mov temp1 , ax 
    ;/**********/
    ;/**********/
    lea di, right
    mov ax, [di] 
    mov [si+6], ax 
    mov ax, [di+6]
    mov [si+4], ax
    ;/*****************/
    ;/*****************/
        
    lea si, down
    mov ax, [si+2] 
    mov [di], ax 
    mov ax, [si]
    mov [di+6], ax
    ;/**
    ;/**
    lea di, left
    mov ax, [di+2] 
    mov [si], ax 
    mov ax, [di+4]
    mov [si+2], ax
;/**;/**
;/**;/**
    mov ax, temp0 
    mov [di+4], ax 
    mov ax, temp1 
    mov [di+2], ax
;/****************/
    
;/left side rotate*/
    lea si, front
    mov ax, [si] 
    mov temp1, ax ; temp1 = u0 
    mov ax, [si+2] ; ax = u1
    mov [si], ax  ; u0 = ax = u1
    mov ax, [si+4] ; ax = u2
    mov  [si+2], ax ; u1 = u2 = ax 
    mov ax, [si+6]
    mov [si+4], ax ; u2 = u3 = ax 
    mov ax, temp1 ; ax = t1 = u0 
    mov [si+6], ax ; u3 = u0 = ax 
    ;/********/
    mov ax, 'f' 
    call savemoves
    call checker
    ;/********/
    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret
fi endp;/***********/
mainexit2:
jmp mainexit3
f proc
    push ax
    push bx
    push cx
    push dx
    push si
    push di
    ;/********/
    ;/********/
    mov ax, 0 
    lea si, up
    mov ax, [si+6] 
    mov temp0 , ax 
    mov ax, [si+4] 
    mov temp1 , ax 
    ;/**********/
    ;/**********/
    lea di, left
    mov ax, [di+4] 
    mov [si+6], ax 
    mov ax, [di+2]
    mov [si+4], ax
    ;/*****************/
        
    lea si, down
    mov ax, [si] 
    mov [di+2], ax 
    mov ax, [si+2]
    mov [di+4], ax
    ;/**
    lea di, right 
    mov ax, [di+6] 
    mov [si], ax 
    mov ax, [di]
    mov [si+2], ax
;/**;/**
;/**;/**
    mov ax, temp0 
    mov [di], ax 
    mov ax, temp1 
    mov [di+6], ax
;/****************/

;/*****************/
;/left side rotate*/
    lea si, front
    mov ax, [si] 
    mov temp1, ax ; temp1 = u0 
    mov ax, [si+6] ; ax = u1
    mov [si], ax  ; u0 = ax = u1
    mov ax, [si+4] ; ax = u2
    mov  [si+6], ax ; u1 = u2 = ax 
    mov ax, [si+2]
    mov [si+4], ax ; u2 = u3 = ax 
    mov ax, temp1 ; ax = t1 = u0 
    mov [si+2], ax ; u3 = u0 = ax 
    ;/********/
           mov ax, 'F' 
    call savemoves
    call checker
    ;/********/
    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret
f endp
;/***********/
b proc
    push ax
    push bx
    push cx
    push dx
    push si
    push di
    ;/********/
    ;/********/
    mov ax, 0 
    lea si, up 
    mov ax, [si] 
    mov temp0 , ax 
    mov ax, [si+2] 
    mov temp1 , ax 
    ;/**********/
    ;/**********/
    lea di, right
    mov ax, [di+2] 
    mov [si], ax 
    mov ax, [di+4]
    mov [si+2], ax
;/*****************/
;/*****************/
        
    lea si, down
    mov ax, [si+6] 
    mov [di+4], ax 
    mov ax, [si+4]
    mov [di+2], ax
;/****************/
;/**
    lea di, left 
    mov ax, [di] 
    mov [si+6], ax 
    mov ax, [di+6]
    mov [si+4], ax
;/**;/**
;/**;/**
    mov ax, temp0 
    mov [di+6], ax 
    mov ax, temp1 
    mov [di], ax
    ;/left side rotate*/
    lea si, back
    mov ax, [si] 
    mov temp1, ax ; temp1 = u0 
    mov ax, [si+6] ; ax = u1
    mov [si], ax  ; u0 = ax = u1
    mov ax, [si+4] ; ax = u2
    mov  [si+6], ax ; u1 = u2 = ax 
    mov ax, [si+2]
    mov [si+4], ax ; u2 = u3 = ax 
    mov ax, temp1 ; ax = t1 = u0 
    mov [si+2], ax ; u3 = u0 = ax 
    ;/********/ 
    mov ax, 'B' 
    call savemoves
    call checker
    ;/********/
    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret
b endp
;/***********/
mainexit3:
jmp mainexit4
bi proc 

    push ax
    push bx
    push cx
    push dx
    push si
    push di
    ;/********/
    ;/********/
    mov ax, 0 
    lea si, up 
    mov ax, [si] 
    mov temp0 , ax 
    mov ax, [si+2] 
    mov temp1 , ax 
    ;/**********/
    ;/**********/
    lea di, left
    mov ax, [di+6] 
    mov [si], ax 
    mov ax, [di]
    mov [si+2], ax
;/*****************/
;/*****************/
        
    lea si, down
    mov ax, [si+6] 
    mov [di], ax 
    mov ax, [si+4]
    mov [di+6], ax
;/****************/
;/**
    lea di, right
    mov ax, [di+4] 
    mov [si+6], ax 
    mov ax, [di+2]
    mov [si+4], ax
;/**;/**
;/**;/**
    mov ax, temp0 
    mov [di+2], ax 
    mov ax, temp1 
    mov [di+4], ax
    ;/*right side rotate*/


    
    ;/*right side rotate*/  
    lea si, back  
    mov ax, [si] 
    mov temp1, ax ; temp1 = u0 
    mov ax, [si+2] ; ax = u1
    mov [si], ax  ; u0 = ax = u1
    mov ax, [si+4] ; ax = u2
    mov  [si+2], ax ; u1 = u2 = ax 
    mov ax, [si+6]
    mov [si+4], ax ; u2 = u3 = ax 
    mov ax, temp1 ; ax = t1 = u0 
    mov [si+6], ax ; u3 = u0 = ax 
    
;/********/ 
mov ax, 'b' 
    call savemoves
    call checker
    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret
bi endp
;/***********/
ri proc 

    push ax
    push bx
    push cx
    push dx
    push si
    push di
    ;/********/
    ;/********/
    mov ax, 0 
    lea si, back 
    mov ax, [si] 
    mov temp0 , ax 
    mov ax, [si+6] 
    mov temp1 , ax 
    ;/**********/
    ;/**********/
    lea di, down
    mov ax, [di+4] 
    mov [si], ax 
    mov ax, [di+2]
    mov [si+6], ax
;/*****************/

;/*****************/
        
    lea si, front 
    mov ax, [si+2] 
    mov [di+2], ax 
    mov ax, [si+4]
    mov [di+4], ax
;/****************/
;/**
    lea di, up
    mov ax, [di+2] 
    mov [si+2], ax 
    mov ax, [di+4]
    mov [si+4], ax
;/**;/**
;/**;/**
    mov ax, temp0 
    mov [di+4], ax 
    mov ax, temp1 
    mov [di+2], ax
    ;/*right side rotate*/
    
    lea si, right  
    mov ax, [si] 
    mov temp1, ax ; temp1 = u0 
    mov ax, [si+2] ; ax = u1
    mov [si], ax  ; u0 = ax = u1
    mov ax, [si+4] ; ax = u2
    mov  [si+2], ax ; u1 = u2 = ax 
    mov ax, [si+6]
    mov [si+4], ax ; u2 = u3 = ax 
    mov ax, temp1 ; ax = t1 = u0 
    mov [si+6], ax ; u3 = u0 = ax 
    ;/********/
    mov ax, 'r' 
    call savemoves
    call checker
    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret
ri endp
;/***********/
mainexit4:
jmp mainexit5

r proc
    push ax
    push bx
    push cx
    push dx
    push si
    push di
    ;/********/
    ;/********/
    mov ax, 0 
    lea si, back 
    mov ax, [si] 
    mov temp0 , ax 
    mov ax, [si+6] 
    mov temp1 , ax 
    ;/**********/
    ;/**********/
    lea di, up
    mov ax, [di+4] 
    mov [si], ax 
    mov ax, [di+2]
    mov [si+6], ax
;/*****************/
;/*****************/
        
    lea si, front 
    mov ax, [si+2] 
    mov [di+2], ax 
    mov ax, [si+4]
    mov [di+4], ax
;/****************/
;/**
    lea di, down
    mov ax, [di+2] 
    mov [si+2], ax 
    mov ax, [di+4]
    mov [si+4], ax
;/**;/**
    mov ax, temp0 
    mov [di+4], ax 
    mov ax, temp1 
    mov [di+2], ax
    
    ;/left side rotate*/
    lea si, right
    mov ax, [si] 
    mov temp1, ax ; temp1 = u0 
    mov ax, [si+6] ; ax = u1
    mov [si], ax  ; u0 = ax = u1
    mov ax, [si+4] ; ax = u2
    mov  [si+6], ax ; u1 = u2 = ax 
    mov ax, [si+2]
    mov [si+4], ax ; u2 = u3 = ax 
    mov ax, temp1 ; ax = t1 = u0 
    mov [si+2], ax ; u3 = u0 = ax 
    ;/********/
    mov ax, 'R' 
    call savemoves
    call checker
    ;/********/
    
    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret
r endp

;/********/
l proc
    push ax
    push bx
    push cx
    push dx
    push si
    push di
    ;/********/
    ;/********/
    mov ax, 0 
    lea si, back 
    mov ax, [si+2] 
    mov temp0 , ax 
    mov ax, [si+4] 
    mov temp1 , ax 
    ;/**********/
    ;/**********/
    lea di, down
    mov ax, [di] 
    mov [si+4], ax 
    mov ax, [di+6]
    mov [si+2], ax
;/*****************/
;/*****************/
        
    lea si, front 
    mov ax, [si] 
    mov [di], ax 
    mov ax, [si+6]
    mov [di+6], ax
;/**;/**
    lea di, up
    mov ax, [di] 
    mov [si], ax 
    mov ax, [di+6]
    mov [si+6], ax
;/**
;/**
    mov ax, temp0 
    mov [di+6], ax 
    mov ax, temp1 
    mov [di], ax
    ;/left side rotate*/
    lea si, left 
    mov ax, [si] 
    mov temp1, ax ; temp1 = u0 
    mov ax, [si+6] ; ax = u1
    mov [si], ax  ; u0 = ax = u1
    mov ax, [si+4] ; ax = u2
    mov  [si+6], ax ; u1 = u2 = ax 
    mov ax, [si+2]
    mov [si+4], ax ; u2 = u3 = ax 
    mov ax, temp1 ; ax = t1 = u0 
    mov [si+2], ax ; u3 = u0 = ax 
    ;/********/
    mov ax, 'L' 
    call savemoves
    call checker
;/********/
    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret
l endp
;/********/
mainexit5:
jmp mainexit6
li proc 

    push ax
    push bx
    push cx
    push dx
    push si
    push di
    ;/********/
    ;/********/
    mov ax, 0 
    lea si, back 
    mov ax, [si+2] 
    mov temp0 , ax 
    mov ax, [si+4] 
    mov temp1 , ax 
    ;/**********/
    ;/**********/
    lea di, up 
    mov ax, [di] 
    mov [si+4], ax 
    mov ax, [di+6]
    mov [si+2], ax
;/*****************/;/*****************/
        
    lea si, front 
    mov ax, [si] 
    mov [di], ax 
    mov ax, [si+6]
    mov [di+6], ax
;/**;/**
    lea di, down 
    mov ax, [di] 
    mov [si], ax 
    mov ax, [di+6]
    mov [si+6], ax
;/**;/**
    mov ax, temp0 
    mov [di+6], ax 
    mov ax, temp1 
    mov [di], ax
    
;/*up side rotate*/
    
    lea si, left 
    mov ax, [si] 
    mov temp1, ax ; temp1 = u0 
    mov ax, [si+2] ; ax = u1
    mov [si], ax  ; u0 = ax = u1
    mov ax, [si+4] ; ax = u2
    mov  [si+2], ax ; u1 = u2 = ax 
    mov ax, [si+6]
    mov [si+4], ax ; u2 = u3 = ax 
    mov ax, temp1 ; ax = t1 = u0 
    mov [si+6], ax ; u3 = u0 = ax 

    ;/********/
    mov ax, 'l' 
    call savemoves
    call checker
    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret
li endp

;/**********/
id proc 

    push ax
    push bx
    push cx
    push dx
    push si
    push di
    ;/********/
    mov ax, 0 
    lea si, back 
    mov ax, [si+6] 
    mov temp0 , ax 
    mov ax, [si+4] 
    mov temp1 , ax 
    ;/*************/
    
    ;/**********/
    lea di, left  
    mov ax, [di+6] 
    mov [si+6], ax 
    mov ax, [di+4]
    mov [si+4], ax
    ;/*****************/
        
    lea si, front 
    mov ax, [si+6] 
    mov [di+6], ax 
    mov ax, [si+4]
    mov [di+4], ax
;/**;/**
    lea di, right
    mov ax, [di+6] 
    mov [si+6], ax 
    mov ax, [di+4]
    mov [si+4], ax
;/**;/**
    mov ax, temp0 
    mov [di+6], ax 
    mov ax, temp1 
    mov [di+4], ax
    
    ;/*up side rotate*/
    
    lea si, down 
    mov ax, [si] 
    mov temp1, ax ; temp1 = u0 
    mov ax, [si+2] ; ax = u1
    mov [si], ax  ; u0 = ax = u1
    mov ax, [si+4] ; ax = u2
    mov  [si+2], ax ; u1 = u2 = ax 
    mov ax, [si+6]
    mov [si+4], ax ; u2 = u3 = ax 
    mov ax, temp1 ; ax = t1 = u0 
    mov [si+6], ax ; u3 = u0 = ax 

;/********/
mov ax, 'd' 
    call savemoves
    call checker
    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret
id endp
mainexit6:
jmp mainexit7
  ;/********/
ui proc 

    push ax
    push bx
    push cx
    push dx
    push si
    push di
    ;/********/
    mov ax, 0
    ;mov si, 0
    lea si, back ; si = &b
    mov ax, [si] ; 
    mov temp0, ax; temp0 = b[0]
    
    mov ax, [si+2] ; ax = b[1]
    mov temp1, ax ; temp1 = b[1]

    ;mov di, 0
    lea di, right 
    mov ax, [di]
    mov [si], ax; b[0] = r[0]
    mov ax, [di+2]
    mov [si+2], ax ;b1 = r1
    
    ;mov si, 0
    lea si, front 
    mov ax, [si] 
    mov [di], ax ; r0 = f0
    
    mov ax, [si+2]
    mov [di+2], ax ; r1 = f1
    
    lea di, left 
    mov ax, [di] ; ax = l0
    mov [si], ax ; f0 = l0
    mov ax, [di+2]
    mov [si+2], ax
    
    mov ax, temp0
    mov [di], ax; l0 = temp0
    mov ax, temp1 
    mov [di+2], ax ; l1 = temp1 
    ;/*up side rotate*/
    
    lea si, up 
    mov ax, [si] 
    mov temp1, ax ; temp1 = u0 
    mov ax, [si+2] ; ax = u1
    mov [si], ax  ; u0 = ax = u1
    mov ax, [si+4] ; ax = u2
    mov  [si+2], ax ; u1 = u2 = ax 
    mov ax, [si+6]
    mov [si+4], ax ; u2 = u3 = ax 
    mov ax, temp1 ; ax = t1 = u0 
    mov [si+6], ax ; u3 = u0 = ax 

    ;/********/
    mov ax, 'u' 
    call savemoves
    call checker
    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret
ui endp

u proc 

    push ax
    push bx
    push cx
    push dx
    push si
    push di
    ;/********/
    mov ax, 0
    mov ax, 0
    ;mov si, 0
    lea si, back ; si = &b
    mov ax, [si] ; 
    mov temp0, ax; temp0 = b[0]
    
    mov ax, [si+2] ; ax = b[1]
    mov temp1, ax ; temp1 = b[1]
    ;/***********/
    ;mov di, 0
    lea di, left 
    mov ax, [di]
    mov [si], ax; b[0] = r[0]
    mov ax, [di+2]
    mov [si+2], ax ;b1 = r1
    ;/******/
    
    lea si, front 
    mov ax, [si] 
    mov [di], ax ; r0 = f0
    
    mov ax, [si+2]
    mov [di+2], ax ; r1 = f1
    ;/*********/
    lea di, right
    mov ax, [di] ; ax = l0
    mov [si], ax ; f0 = l0
    mov ax, [di+2]
    mov [si+2], ax
    
    mov ax, temp0
    mov [di], ax; r0 = temp0
    mov ax, temp1 
    mov [di+2], ax ; r1 = temp1 
    
    
    ;/*up side rotate*/
    
    lea si, up 
    mov ax, [si] 
    mov temp1, ax ; temp1 = u0 
    mov ax, [si+6] ; ax = u1
    mov [si], ax  ; u0 = ax = u1
    mov ax, [si+4] ; ax = u2
    mov  [si+6], ax ; u1 = u2 = ax 
    mov ax, [si+2]
    mov [si+4], ax ; u2 = u3 = ax 
    mov ax, temp1 ; ax = t1 = u0 
    mov [si+2], ax ; u3 = u0 = ax 
    ;/********/
    mov ax, 'U' 
    call savemoves
    call checker
    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret
u endp
mainexit7:
jmp mainexit8

printer proc
    push ax 
    push bx 
    push cx 
    push dx 
    push si 
    push di 
    call print_new_line
     
    ;up 
    lea si, up 
    mov bx, [si]
    ;ouput
        mov dl, bl
        mov ah,2
        int 21h
    mov bx, [si+2]
    ;ouput
        mov dl, bl
        mov ah,2
        int 21h
    mov bx, [si+4]
    ;ouput
        mov dl, bl
        mov ah,2
        int 21h
    mov bx, [si+6]
    ;ouput
        mov dl, bl
        mov ah,2
        int 21h
    ; left
    call print_new_line
    lea si, left 
    mov bx, [si]
    ;ouput
        mov dl, bl
        mov ah,2
        int 21h
    mov bx, [si+2]
    ;ouput
        mov dl, bl
        mov ah,2
        int 21h
    mov bx, [si+4]
    ;ouput
        mov dl, bl
        mov ah,2
        int 21h
    mov bx, [si+6]
    ;ouput
        mov dl, bl
        mov ah,2
        int 21h
        
    ;front 
    call print_new_line
    lea si, front 
    mov bx, [si]
    ;ouput
        mov dl, bl
        mov ah,2
        int 21h
    mov bx, [si+2]
    ;ouput
        mov dl, bl
        mov ah,2
        int 21h
    mov bx, [si+4]
    ;ouput
        mov dl, bl
        mov ah,2
        int 21h
    mov bx, [si+6]
    ;ouput
        mov dl, bl
        mov ah,2
        int 21h
        
    ;right
    call print_new_line
    lea si, right  
    mov bx, [si]
    ;ouput
        mov dl, bl
        mov ah,2
        int 21h
    mov bx, [si+2]
    ;ouput
        mov dl, bl
        mov ah,2
        int 21h
    mov bx, [si+4]
    ;ouput
        mov dl, bl
        mov ah,2
        int 21h
    mov bx, [si+6]
    ;ouput
        mov dl, bl
        mov ah,2
        int 21h
    
        ;back
        call print_new_line
    lea si, back 
    mov bx, [si]
    ;ouput
        mov dl, bl
        mov ah,2
        int 21h
    mov bx, [si+2]
    ;ouput
        mov dl, bl
        mov ah,2
        int 21h
    mov bx, [si+4]
    ;ouput
        mov dl, bl
        mov ah,2
        int 21h
    mov bx, [si+6]
    ;ouput
        mov dl, bl
        mov ah,2
        int 21h
        ;down
       call print_new_line
    lea si, down 
    mov bx, [si]
    ;ouput
        mov dl, bl
        mov ah,2
        int 21h
    mov bx, [si+2]
    ;ouput
        mov dl, bl
        mov ah,2
        int 21h
    mov bx, [si+4]
    ;ouput
        mov dl, bl
        mov ah,2
        int 21h
    mov bx, [si+6]
    ;ouput
        mov dl, bl
        mov ah,2
        int 21h
        
        call print_new_line
        
        pop di 
        pop si 
        pop dx 
        pop cx 
        pop bx 
        pop ax 
        ret 
printer endp

d proc 

    push ax
    push bx
    push cx
    push dx
    push si
    push di
    ;/********/
    mov ax, 0 
    lea si, back 
    mov ax, [si+6] 
    mov temp0 , ax 
    mov ax, [si+4] 
    mov temp1 , ax 
    
    ;/**********/
    lea di, right 
    mov ax, [di+6] 
    mov [si+6], ax 
    mov ax, [di+4]
    mov [si+4], ax
;/*****************/
        
    lea si, front 
    mov ax, [si+6] 
    mov [di+6], ax 
    mov ax, [si+4]
    mov [di+4], ax
;/**
    lea di, left 
    mov ax, [di+6] 
    mov [si+6], ax 
    mov ax, [di+4]
    mov [si+4], ax
;/**
    mov ax, temp0 
    mov [di+6], ax 
    mov ax, temp1 
    mov [di+4], ax
    
    ;/down side rotate*/
    lea si, down 
    mov ax, [si] 
    mov temp1, ax ; temp1 = u0 
    mov ax, [si+6] ; ax = u1
    mov [si], ax  ; u0 = ax = u1
    mov ax, [si+4] ; ax = u2
    mov  [si+6], ax ; u1 = u2 = ax 
    mov ax, [si+2]
    mov [si+4], ax ; u2 = u3 = ax 
    mov ax, temp1 ; ax = t1 = u0 
    mov [si+2], ax ; u3 = u0 = ax 
    ;/********/
    mov ax, 'D' 
    call savemoves
    call checker
    ;/********/
    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret
d endp  
;/*********/
start_formal_prompts proc
    push ax
    push dx
    ;PRINT StringUp52 
    MOV AH,9
    LEA DX, String525252 
    INT 21H
    call print_new_line
    ;/****enter the inputs 1st*****/
    call TakeInput
    call print_new_line
    call print_new_line
    pop dx
    pop ax
    ret
start_formal_prompts endp

print_new_line proc
    push ax
    push dx
    
    mov ah,2
    mov dl,0dh
    int 21h
    mov dl,0ah
    int 21h
    
    pop dx
    pop ax
    ret
print_new_line endp

;Some more magical functions by fahim..................................................................
EfficientSolver proc 
    push ax 
    push bx 
    push cx 
    push dx 
    push si 
    push di 
    ;moves 
    ;index 
    mov cx, 0 
    lea si, moves
    sub cx,2
    sub si,2
    EfficientSolverStart: 
        ;call the cube drawing function here
            ;wait for the user to hit a space
            we_are_talking_about_the_space_between_us:
                push ax
                mov ah,1
                int 21h
                cmp al,' '
                    jne not_space_hit
                    jmp space_hit
                not_space_hit:
                    ;call clear_one_char
                    pop ax
                    call a_clear_vga_page
                    call display_cube_array_and_texts
                jmp we_are_talking_about_the_space_between_us
                ;cmp al,'a'
                ;    jne not_all_hit
                ;    jmp all_hit
                ;not_all_hit:
                ;cmp al,'U'
                ;    je U_hit
                ;cmp al,'u'
                ;    je Ui_hit
                ;cmp al,'D'
                ;    je D_hit
                ;cmp al,'d'
                ;    je Di_hit
                ;cmp al,'F'
                ;    je F_hit
                ;cmp al,'f'
                ;    je Fi_hit
                ;cmp al,'B'
                ;    je B_hit
                ;cmp al,'b'
                ;    je Bi_hit
                ;cmp al,'R'
                ;    je R_hit
                ;cmp al,'r'
                ;    je Ri_hit
                ;cmp al,'L'
                ;    je L_hit
                ;cmp al,'l'
                ;    je  Li_hit
                pop ax
                jmp after_user_hits
                U_hit:
                    pop ax
                    call U
                    jmp after_user_hits
                Ui_hit:
                    pop ax
                    call Ui
                    jmp after_user_hits
                D_hit:
                    pop ax
                    call D
                    jmp after_user_hits
                Di_hit:
                    pop ax
                    call iD
                    jmp after_user_hits
                F_hit:
                    pop ax
                    call F
                    jmp after_user_hits
                Fi_hit:
                    pop ax
                    call Fi
                    jmp after_user_hits
                B_hit:
                    pop ax
                    call B
                    jmp after_user_hits
                Bi_hit:
                    pop ax
                    call Bi
                    jmp after_user_hits
                R_hit:
                    pop ax
                    call R
                    jmp after_user_hits
                Ri_hit:
                    pop ax
                    call Ri
                    jmp after_user_hits
                L_hit:
                    pop ax
                    call L
                    jmp after_user_hits
                Li_hit:
                    pop ax
                    call Li
                    jmp after_user_hits
                space_hit:
                    pop ax
                    ;call printer
                    
                    jmp after_user_hits
                all_hit:
                    pop ax
                    ;call R
                    jmp after_user_hits
        after_user_hits:
            add cx,2
            add si,2
            cmp cx,father_of_index
            je EfficientSolverEnd ;is cx equal?
            call updater_of_efficient_solver
            call display_cube_array_and_texts
            add cx,2
            cmp cx,father_of_index ;cx not equal to father, but will it be equal in the next loop?
                je EfficientSolverEnd ;yeah it will. so exit.
            sub cx,2 ;no it won't. continue.
        ;drawing function end
        ;mov dx, temp45
        ;cmp cx, dx
        ;jge  EfficientSolverEnd
        jmp EfficientSolverStart

    EfficientSolverEnd:
    call display_cube_array_and_texts
    ;display when the cube is solved
        ;display string solved
            mov dh,5 ;row
            xor dl,dl ;0'th column of that row
            lea si,cube_solved_string
            call display_character_stuffs
        ;display string to go back to the main menu
            mov dh,22 ;row
            xor dl,dl ;0'th column of that row
            lea si,play_again_string
            call display_character_stuffs
    
    mov temp45, cx 
    pop di 
    pop si 
    pop dx 
    pop cx 
    pop bx 
    pop ax 
    ret
EfficientSolver endp

updater_of_efficient_solver proc
    ;just a minuit. :| this procedures expects something from si.
    ;se be aware!
    push ax
    push si
    
    mov ax, [si] 
    EfficientSolverCaseChecker:
        EfficientSolvercaseU:
            cmp ax, 'U' 
            jne EfficientSolvercaseUi
                call U 
                jmp EfficientSolvercaseCheckerEnd 
        EfficientSolvercaseUi:
            cmp ax, 'u' 
            jne EfficientSolvercaseD
                call Ui
                jmp EfficientSolvercaseCheckerEnd 
        EfficientSolvercaseD:
            cmp ax, 'D' 
            jne EfficientSolvercaseDi
                call D  
                jmp EfficientSolvercaseCheckerEnd                
        EfficientSolvercaseDi:
            cmp ax, 'd' 
            jne EfficientSolvercaseF
                call iD
                jmp EfficientSolvercaseCheckerEnd
        EfficientSolvercaseF:
            cmp ax, 'F' 
            jne EfficientSolvercaseFi 
                call F   
                jmp EfficientSolvercaseCheckerEnd
        EfficientSolvercaseFi:
            cmp ax, 'f'
            jne EfficientSolvercaseB
                call Fi   
                jmp EfficientSolvercaseCheckerEnd
        EfficientSolvercaseB:
            cmp ax, 'B' 
            jne EfficientSolvercaseBi
                call B   
                jmp EfficientSolvercaseCheckerEnd
        EfficientSolvercaseBi:
            cmp ax, 'b' 
            jne EfficientSolvercaseL
                call bi   
                jmp EfficientSolvercaseCheckerEnd
        EfficientSolvercaseL:
            cmp ax, 'L' 
            jne EfficientSolvercaseLi
                call L   
                jmp EfficientSolvercaseCheckerEnd
        EfficientSolvercaseLi:
            cmp ax, 'l' 
            jne EfficientSolvercaseR
                call li   
                jmp EfficientSolvercaseCheckerEnd
        EfficientSolvercaseR:
            cmp ax, 'R' 
            jne EfficientSolvercaseRi
                call R  
                jmp EfficientSolvercaseCheckerEnd
        EfficientSolvercaseRi:
            cmp ax, 'r' 
            jne EfficientSolvercasecheckerend 
                call Ri   
                jmp EfficientSolvercaseCheckerEnd
        EfficientSolverCaseCheckerEnd:
    
    return_updater_of_efficient_solver:
        pop si
        pop ax
        ret
updater_of_efficient_solver endp

InputRestor proc  
    push ax 
    push bx 
    push cx 
    push dx 
    push si 
    push di 

    lea si, backup 
    lea di, up 
    mov ax, [si]
    mov [di], ax 
    add si,2 
    add di, 2
    mov ax, [si]
    mov [di], ax 
    add si,2 
    add di, 2
    mov ax, [si]
    mov [di], ax 
    add si,2 
    add di, 2
    mov ax, [si]
    mov [di], ax 
    lea di, left 
    add si, 2 
    mov ax, [si]
    mov [di], ax 
    add si,2 
    add di, 2
    mov ax, [si]
    mov [di], ax 
    add si,2 
    add di, 2
    mov ax, [si]
    mov [di], ax 
    add si,2 
    add di, 2
    mov ax, [si]
    mov [di], ax 
    lea di, front 
    add si, 2
    mov ax, [si]
    mov [di], ax 
    add si,2 
    add di, 2
    mov ax, [si]
    mov [di], ax 
    add si,2 
    add di, 2
    mov ax, [si]
    mov [di], ax 
    add si,2 
    add di, 2
    mov ax, [si]
    mov [di], ax 
    lea di, right 
    add si, 2
    mov ax, [si]
    mov [di], ax 
    add si,2 
    add di, 2
    mov ax, [si]
    mov [di], ax 
    add si,2 
    add di, 2
    mov ax, [si]
    mov [di], ax 
    add si,2 
    add di, 2
    mov ax, [si]
    mov [di], ax 
    lea di, back 
    add si, 2
    mov ax, [si]
    mov [di], ax 
    add si,2 
    add di, 2
    mov ax, [si]
    mov [di], ax 
    add si,2 
    add di, 2
    mov ax, [si]
    mov [di], ax 
    add si,2 
    add di, 2
    mov ax, [si]
    mov [di], ax 
    lea di, down 
    add si, 2
    mov ax, [si]
    mov [di], ax 
    add si,2 
    add di, 2
    mov ax, [si]
    mov [di], ax 
    add si,2 
    add di, 2
    mov ax, [si]
    mov [di], ax 
    add si,2 
    add di, 2
    mov ax, [si]
    mov [di], ax 
    
    ;initialize father of index
    mov ax,index
    mov father_of_index,ax
    
    ;make index 0
    mov ax,0
    mov index,ax
    
    pop di 
    pop si 
    pop dx 
    pop cx 
    pop bx 
    pop ax 
    RET 
InputRestor endp 

InputBackUp proc
    push ax 
    push bx 
    push cx 
    push dx 
    push si 
    push di 
    
    lea Si, backup
    lea di, up 
    mov ax, [di]
    mov [si], ax 
    add si, 2 
    add di, 2 
    mov ax, [di]
    mov [si], ax 
    add si, 2 
    add di, 2 
    mov ax, [di]
    mov [si], ax 
    add si, 2 
    add di, 2 
    mov ax, [di]
    mov [si], ax 
    add si, 2 
    lea di, left 
    mov ax, [di]
    mov [si], ax 
    add si, 2 
    add di, 2 
    mov ax, [di]
    mov [si], ax 
    add si, 2 
    add di, 2 
    mov ax, [di]
    mov [si], ax 
    add si, 2 
    add di, 2 
    mov ax, [di]
    mov [si], ax 
    add si, 2 
    lea di, front 
    mov ax, [di]
    mov [si], ax 
    add si, 2 
    add di, 2 
    mov ax, [di]
    mov [si], ax 
    add si, 2 
    add di, 2 
    mov ax, [di]
    mov [si], ax 
    add si, 2 
    add di, 2 
    mov ax, [di]
    mov [si], ax 
    add si, 2 
    lea di, right 
    mov ax, [di]
    mov [si], ax 
    add si, 2 
    add di, 2 
    mov ax, [di]
    mov [si], ax 
    add si, 2 
    add di, 2 
    mov ax, [di]
    mov [si], ax 
    add si, 2 
    add di, 2 
    mov ax, [di]
    mov [si], ax 
    add si, 2 
    lea di, back 
    mov ax, [di]
    mov [si], ax 
    add si, 2 
    add di, 2 
    mov ax, [di]
    mov [si], ax 
    add si, 2 
    add di, 2 
    mov ax, [di]
    mov [si], ax 
    add si, 2 
    add di, 2 
    mov ax, [di]
    mov [si], ax 
    add si, 2 
    lea di, down 
    mov ax, [di]
    mov [si], ax 
    add si, 2 
    add di, 2 
    mov ax, [di]
    mov [si], ax 
    add si, 2 
    add di, 2 
    mov ax, [di]
    mov [si], ax 
    add si, 2 
    add di, 2 
    mov ax, [di]
    mov [si], ax 
    ;add si, 2 
    ;add di, 2 
     pop di 
    pop si 
    pop dx 
    pop cx 
    pop bx
    pop ax 
    RET 
InputBackUp endp

wait_for_a_key_to_press proc
    push ax
    push dx
    
    mov ah,1
    int 21h
    
    pop dx
    pop ax
    ret
wait_for_a_key_to_press endp

wait_for_an_enter_to_press proc
    push ax
    push dx
    
    wait_for_an_enter_to_press_repeat:
        mov ah,1
        int 21h
        call clear_one_char
        cmp al,0dh
        je wait_for_an_enter_to_press_repeat_end
        jmp wait_for_an_enter_to_press_repeat
    wait_for_an_enter_to_press_repeat_end:
    
    pop dx
    pop ax
    ret
wait_for_an_enter_to_press endp

clear_one_char proc
    push ax
    push dx
    
    mov ah,2
    mov dl,8h
    int 21h ;print backspace
    mov dl,' '
    int 21h ;print space to clear previos char
    mov dl,8h
    int 21h ;again print backspace!
    
    pop dx
    pop ax
    ret
clear_one_char endp

mainexit8:
;/********/
end main