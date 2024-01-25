
	[org 0x0100]
	 jmp start
	message: db 'Enter a two digit number:',0x00,0x00 
	message2: db 'Enter an another two digit number:',0x00,0x00 
	length1: dw 27	
	length2: dw 37
	mess_y_pos:dw 1
mess_x_pos:dw 1
	message3: db 'Sum in ax is as :',0x00,0x00 
	length3: dw 19
	Warning:db ' Wrong input '
	lwarning:dw 13

		clrscr: push es 
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
	 mov ax, 0xb800
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
	 mov [message+25],al
		ret
ret_false:call printwarning
	  mov ah,0
	 int 0x16
	jmp  check_invalid1	

  check_invalid2:
	 cmp al,0x30
	 jb  ret_false2
	 cmp al,0x39
	 ja ret_false2
	 mov [message+26],al
		ret
ret_false2:call printwarning
	  mov ah,0
	 int 0x16
	jmp  check_invalid2	

  check_invalid3:
	 cmp al,0x30
	 jb  ret_false3
	 cmp al,0x39
	 ja ret_false3
	 mov [message2+35],al
		ret
ret_false3:call printwarning
	  mov ah,0
	 int 0x16
	jmp  check_invalid3	

  check_invalid4:
	 cmp al,0x30
	 jb  ret_false4
	 cmp al,0x39
	 ja ret_false4
	 mov [message2+36],al
		ret
ret_false4:call printwarning
	  mov ah,0
	 int 0x16
	jmp  check_invalid4	
	
	
	sum_ans:
	mov ax,[message+25]
	sub ax,0x30
	mov bl,0x0A
	mul bl
	mov dl,[message+26]
	sub dl,0x30
	add al,dl
	mov [message3+17],al
	
	mov ax,[message2+35]
	sub ax,0x30
	mov bl,0x0A
	mul bl
	mov dl,[message2+36]
	sub dl,0x30
	add al,dl
	mov [message3+18],al
	mov bl,[message3+17]
	mov dl,[message3+18]
	add bl,dl
	mov al,bl
	mov [message3+17],al
	mov byte[message3+18],0x00
	ret
	start: call clrscr 
 push word[mess_x_pos] 			
 push word[mess_y_pos] 			
 mov ax, 0x70 		
 push ax 			
 mov ax, message
 push ax 			
 push word [length1]
 call printstr 
 mov dx,0
 mov ah,0
 int 0x16
 call check_invalid1
 mov ah,0
 int 0x16
 call check_invalid2
 push word[mess_x_pos]
 push word[mess_y_pos] 			
 mov ax, 0x70 		
 push ax 			
 mov ax, message
 push ax 			
 push word [length1]
 call printstr  
 push word[mess_x_pos] 			
 add word[mess_y_pos],1			
 push word[mess_y_pos] 			
 mov ax, 0x70 		
 push ax 			
 mov ax, message2
 push ax 			
 push word [length2]
 call printstr 
 mov dx,0
 mov ah,0
 int 0x16
 call check_invalid3
 mov ah,0
 int 0x16
 call check_invalid4
 push word[mess_x_pos]
 push word[mess_y_pos] 			
 mov ax, 0x70 		
 push ax 			
 mov ax, message2
 push ax 			
 push word [length2]
 call printstr 
 call sum_ans
  push word[mess_x_pos] 			
 add word[mess_y_pos],1
 push word[mess_y_pos] 			
 mov ax, 0x70 		
 push ax 			
 mov ax, message3
 push ax 			
 push word [length3]
 call printstr 
	 mov ax, 0x4c00
	 int 0x21
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 ; mov ax,20
	; push ax	
	; mov bl,10
	; div bl
	; add al,0x30
	; add ah,0x30
	; mov [message+25],al
	; mov [message+26],ah
	; sub al,0x30
	; sub ah,0x30
	; mov dx,ax
	; mov al,dl
	; mov dl,0
	; mov bl,10
	; mul bl
	; add dx,ax 
	  ; call printstr 
	  ; mov ax, 20
	 ; push ax				
	 ; mov ax, 11
	 ; push ax 				
	 ; mov ax, 0x70 			
	 ; push ax 				
	 ; mov ax, message2
	 ; push ax 
	 ; push word [length2] 
	 ; mov ax,99
	; push ax	
	; mov bl,10
	; div bl
	; add al,0x30
	; add ah,0x30
	; mov [message2+35],al
	; mov [message2+36],ah
	; sub al,0x30
	; sub ah,0x30
	 ; call printstr 
	; mov cx,ax
	; mov al,cl
	; mov cl,0
	; mov bl,10
	; mul bl
	; add al,ch
	; add ax,dx
	; mov ax,[message+26]
	; mov bl,10
	; mul bl
	; mov bx,[message+25]
	; add ax,bx
	; mov dx,ax
	; mov ax,[message2+36]
	; mov bl,10
	; mul bl
	; mov bx,[message2+35]
	; add ax,bx
	; add ax,dx
	; mov dx,ax
	; mov bx,0xF0
	; and ax,bx
	; mov bx,0x0F
	; and dx,bx
	; add al,0x30
	; add dl,0x30
	; mov [message3+17],al
	; mov [message3+18],dl
	 ; mov ax, 20
	 ; push ax				
	 ; mov ax, 12
	 ; push ax 				
	 ; mov ax, 0x74 			
	 ; push ax 				
	 ; mov ax, message3
	 ; push ax 
	 ; push word [length3] 
	 ; mov ax,0
	; push ax	
	; call printstr