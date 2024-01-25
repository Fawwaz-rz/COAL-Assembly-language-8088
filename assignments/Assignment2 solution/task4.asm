
; [org 0x0100]
 ; jmp start
; message: db 'Enter a number between (0 - 9) :',0x32 
; length1: dw 33
; message2:db 'Enter a number between (0 - ',0x31 ,') :',0x34
; length2:dw 33
; sum:db 'Sum is : ',0x32;16=A
; lsum:dw 10
	; temp:dw 0
	; Warning:db ' Wrong input '
	; lwarning:dw 13
	; clrscr: push es
	 ; push ax
	 ; push di
	; mov ax, 0xb800
	 ; mov es, ax ; point es to video base
	 ; mov di, 0 ; point di to top left column
	; nextloc: mov word [es:di], 0x7420 ; clear next char on screen
	 ; add di, 2 ; move to next screen location
	 ; cmp di, 4000 ; has the whole screen cleared
	 ; jne nextloc ; if no clear next position
	 ; pop di
	 ; pop ax
	 ; pop es
	 ; ret 



; l1:
; mov dx,[length2]
; mov [bp+4],dx
; mov word[bp+6],message2
; mov dx,[bp+10] 
; add dx,1
; mov [bp+10],dx
; cmp dx,[bp+10]
; je again
; printstr: push bp
 ; mov bp, sp
 ; push es
 ; push ax
 ; push cx
 ; push si
 ; push di
 ; again:mov ax, 0xb800
 ; mov es, ax ; point es to video base
 ; mov al, 80 ; load al with columns per row
 ; mul byte [bp+10] ; multiply with y position
 ; add ax, [bp+12] ; add x position
 ; shl ax, 1 ; turn into byte offset
 ; mov di,ax ; point di to required location
 ; mov si, [bp+6] ; point si to string
 ; mov cx, [bp+4] ; load length of string in cx
 ; mov ah, [bp+8] ; load attribute in ah
; nextchar: mov al, [si] ; load next char of string
 ; mov [es:di], ax ; show this char on screen
 ; add di, 2 
; add si, 1 ; move to next char in string
 ; loop nextchar ; repeat the operation cx times
; cmp dx,2
; je loopret
; cmp dx,[bp+10]
; jne l1
; loopsum:
; mov dx,[lsum]
; mov [bp+4],dx
; mov word[bp+6],sum
; mov dx,[bp+10] 
; add dx,1
; mov [bp+10],dx
 ; mov al,[message+32]
 ; mov bl,[message2+32]
 ; add bl,al
 ; sub bl,0x30
 ; mov [sum+9],bl
; mov dx,0
; add dx,2
; cmp dx,2
; je again

; loopret:
; pop di
 ; pop si
 ; pop cx
 ; pop ax
 ; pop es
 ; pop bp
 ; ret 10
; range:
    ; push bp
    ; mov bp, sp
    ; mov al, [message+32]
	; mov bl,0x39
    ; sub bl,al
	; add bl,0x30
    ; mov [message2+28], bl
	; mov al,[message2+32]
	; cmp al,bl
	; ja check_greater
    ; pop bp
    ; ret
; check_greater:
; mov word[temp],1
	 ; pop bp
    ; ret	
 ; start: 
 ; call clrscr ; call the clrscr subroutine
 ; mov ax, 10
 ; push ax ; push x position
 ; mov ax, 10
 ; push ax ; push y position
 ; mov ax, 0x70 ; blue on black attribute
 ; push ax ; push attribute
 ; mov ax, message
 ; push ax ; push address of message
 ; push word [length1] ; push message length
 ; call range
 ; call printstr ; call the printstr subroutine
	 ; cmp word[temp],1
	 ; jne endl
	; call clrscr
	 ; mov ax, 30
	 ; push ax 			; push x position
	 ; mov ax, 11
	 ; push ax			 ; push y position
	 ; mov ax, 0x47 		
	 ; push ax 	 
	 ; mov ax, Warning
	 ; push ax 			
	 ; push word [lwarning] 
	 ; call printstr
	; endl: mov ax, 0x4c00 
	 ; int 0x21 
	 
	 ;//////////////////////////////////////////////////////////////////////////
	 
[org 0x0100]
 jmp start
message: db 'Enter a number between (0 - 9) :',0x20
length1: dw 33
message2:db 'Enter a number between (0 - ',0x31 ,') :',0x20;28,32
length2:dw 33
mess_y_pos:dw 1
mess_x_pos:dw 1
sum:db 'Sum is : ',0x32;16=A
lsum:dw 10
	temp:dw 0
	Warning:db ' Wrong input '
	lwarning:dw 13
	
	clrscr: 
			 push es 
			 push ax 
			 push cx 
			 push di 
			 mov ax, 0xb800 
			 mov es, ax 	
			 xor di, di 	 
			 mov ax, 0x7720  
			 mov cx, 2000 	
			 cld 			
			 rep stosw 		
			 pop di 
			pop cx 
			 pop ax 
			 pop es 
			 ret 




printstr: push bp
 mov bp, sp
 push es
 push ax
 push cx
 push si
 push di
 again:mov ax, 0xb800
 mov es, ax 			
 mov al, 80 			
 mul byte [bp+10]		
 add ax, [bp+12] 		
 shl ax, 1 				
 mov di,ax 				
 mov si, [bp+6] 		
 mov cx, [bp+4] 		
 mov ah, [bp+8] 		
nextchar: mov al, [si] 	
 mov [es:di], ax 		
 add di, 2 
add si, 1 				
 loop nextchar 			
pop di
 pop si
 pop cx
 pop ax
 pop es
 pop bp
 ret 10
 
 

		
	
    printwarning:
			  mov ax, [mess_x_pos]
		 push ax 	
		 
		 add word[mess_y_pos],1
		 mov ax, [mess_y_pos]
		 push ax 			
		 mov ax, 0x4F 		
		 push ax 			
		 mov ax, Warning
		 push ax 			
		 push word [lwarning]
		 call printstr
		 ret	


  check_invalid1:
	 cmp al,0x30
	 jb  ret_false
	 cmp al,0x39
	 ja ret_false
	 mov [message+32],al
	 mov bl,0x39
	 sub bl,al
	 add bl,0x30
	 mov al,bl
	 mov [message2+28],al
		ret
ret_false:call printwarning
	  mov ah,0
	 int 0x16
	jmp  check_invalid1	

  check_invalid2:
	 cmp al,0x30
	 jb  ret_false2
	  cmp al,0x39
	 ja ret_false
	 cmp al,[message2+28]
	 ja ret_false2
	 mov [message2+32],al
	
		ret
ret_false2:call printwarning
	  mov ah,0
	 int 0x16
	jmp  check_invalid2		 
		

sum_var:
mov al,[message+32]	
sub al,0x30	
mov bl,[message2+32]
sub bl,0x30
add al,bl
add al,0x30
mov [sum+9],al
ret	

	
 start: 
 call clrscr 			
 push word[mess_x_pos] 			
 push word[mess_y_pos] 				
 mov ax, 0x70 			
 push ax 				
 mov ax, message
 push ax 				
 push word [length1] 	
 call printstr 			
 mov ah,0
 int 0x16
 call  check_invalid1
 push word[mess_x_pos] 			
 push word[mess_y_pos] 				
 mov ax, 0x70 			
 push ax 				
 mov ax, message
 push ax 				
 push word [length1] 	
 call printstr 
  add word[mess_y_pos],1
  push word[mess_x_pos] 			
 push word[mess_y_pos] 				
 mov ax, 0x70 			
 push ax 				
 mov ax, message2
 push ax 				
 push word [length2] 	
 call printstr 	
mov ah,0
 int 0x16
 call  check_invalid2
  push word[mess_x_pos] 			
 push word[mess_y_pos] 				
 mov ax, 0x70 			
 push ax 				
 mov ax, message2
 push ax 				
 push word [length2] 	
 call printstr 
 call sum_var
 add word[mess_y_pos],1
  push word[mess_x_pos] 			
 push word[mess_y_pos] 				
 mov ax, 0x70 			
 push ax 				
 mov ax, sum
 push ax 				
 push word [lsum] 	
 call printstr 	
  mov ax, 0x4c00 
	 int 0x21 