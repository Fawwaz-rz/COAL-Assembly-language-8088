
	; [org 0x0100]
	 ; jmp start
	; message: db 'Enter a number between (0 - 9) :',0x33
	; length1: dw 33
	; message2:db 'Enter a number between (0 - ',0x20,') :',0x32
	; length2:dw 33
	; sum:db 'Sum : ',0x32
	; lsum:dw 7
	; minus:db 'Difference : ',0x32
	; lminus:dw 14
	; multi:db 'Product : ',0x32
	; lmulti:dw 11
	; divisi:db 'Division : ',0x32
	; ldivisi:dw 12
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
	; printstr: push bp
	 ; mov bp, sp
	 ; push es
	 ; push ax
	 ; push cx
	 ; push si
	 ; push di
	 ; mov ax, 0xb800
	 ; mov es, ax ; point es to video base
	 ; mov al, 80 ; load al with columns per row
	 ; mul byte [bp+10] ; multiply with y position
	 ; add ax, [bp+12] ; add x position
	 ; shl ax, 1 ; turn into byte offset
	 ; mov di,ax ; point di to required location
	 ; mov si, [bp+6] ; point si to string
	 ; mov cx, [bp+4] ; load length of string in cx
	 ; mov ah, [bp+8] ; load attribute in ah
	 
	; nextchar: mov al, [si] 	
	 ; mov [es:di], ax 		
	 ; add di, 2 
	; add si, 1 			
	 ; loop nextchar 	
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
    ; mov bx, 0x39
    ; mov al, [message+32]
    ; mov ah, [message2+32]

    ; ; Check if num1 > num2
    ; cmp al, ah
    ; jl not_greater

    ; ; Check if num1 + num2 < 10
	; sub al,0x30
	; sub ah,0x30
    ; add al, ah
    ; cmp al, 10
    ; jae not_greater
	; sub al,ah
    ; ; Check if num1 * num2 < 10
	; mov bl,al
    ; mul ah  ; Multiply AL by AH
    ; cmp ax, 10
    ; jae not_greater
    ; mov [message2+28], al
    ; pop bp
    ; ret

; not_greater:
    
	; mov word[temp],1
    ; pop bp
    ; ret

	; start: 
	; call clrscr 	
	 ; mov ax, 10
	 ; push ax 			; push x position
	 ; mov ax, 10
	 ; push ax			 ; push y position
	 ; mov ax, 0x70 		; blue on black attribute
	 ; push ax 			; push attribute
	 ; mov ax, message
	 ; push ax 				; push address of message
	 ; push word [length1] ; push message length
	 ; call range
	 ; call printstr  
	  ; mov ax, 10
	 ; push ax 			; push x position
	 ; mov ax, 11
	 ; push ax			 ; push y position
	 ; mov ax, 0x70 		
	 ; push ax 			
	 ; mov ax, message2
	 ; push ax 			
	 ; push word [length2] 
	 ; call printstr 
	 ; mov ax, 10
	 ; push ax 			; push x position
	 ; mov ax, 12
	 ; push ax			 ; push y position
	 ; mov ax, 0x70 		
	 ; push ax 
	; mov al,[message+32]
	; sub al,0x30
	; mov bl,[message2+32]
	; sub bl,0x30
	; add al,bl
	; add al,0x30
	; mov [sum+6],al
	 ; mov ax, sum
	 ; push ax 			
	 ; push word [lsum] 
	 ; call printstr 
	 ; mov ax, 10
	 ; push ax 			; push x position
	 ; mov ax, 13
	 ; push ax			 ; push y position
	 ; mov ax, 0x70 		
	 ; push ax 
	; mov al,[message+32]
	; sub al,0x30
	; mov bl,[message2+32]
	; sub bl,0x30
	; sub al,bl
	; add al,0x30
	; mov [minus+13],al	 
	 ; mov ax, minus
	 ; push ax 			
	 ; push word [lminus] 
	 ; call printstr 
	 ; mov ax, 10
	 ; push ax 			; push x position
	 ; mov ax, 14
	 ; push ax			 ; push y position
	 ; mov ax, 0x70 		
	 ; push ax 
	; mov al,[message+32]
	; sub al,0x30
	; mov bl,[message2+32]
	; sub bl,0x30
	; mul bl
	; add al,0x30
	; mov [multi+10],al	 
	 ; mov ax, multi
	 ; push ax 			
	 ; push word [lmulti] 
	 ; call printstr
	 ; mov ax, 10
	 ; push ax 			; push x position
	 ; mov ax, 15
	 ; push ax			 ; push y position
	 ; mov ax, 0x70 		
	 ; push ax 	
	; mov al,[message+32]
	; sub al,0x30
	; mov bl,[message2+32]
	; sub bl,0x30
	; div bl
	; add al,0x30
	; mov [divisi+11],al	 
	 ; mov ax, divisi
	 ; push ax 			
	 ; push word [ldivisi] 
	 ; call printstr
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
	 
	 
	 ;/////////////////////////////////////////////////////////////////////////////////////
	 	 
[org 0x0100]
 jmp start
message: db 'Enter a number between (0 - 9) :',0x20
length1: dw 33
message2:db 'Enter a number between (0 - ',0x39 ,') :',0x20;28,32
length2:dw 33
mess_y_pos:dw 1
mess_x_pos:dw 1
sum:db 'Sum is : ',0x32;16=A
lsum:dw 10
	minus:db 'Difference : ',0x20
	lminus:dw 14
	multi:db 'Product : ',0x20
	lmulti:dw 11
	divisi:db 'Division : ',0x20
	ldivisi:dw 12
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
	 cmp al,0x32
	 jb  ret_false
	 cmp al,0x39
	 ja ret_false
	 mov [message+32],al
	 sub al,0x30
	 mov dl,al
	  mov bl,0x09
check_ex:
	mov al,dl
	 mul bl
	 xor ah,ah
	 cmp al,0x0A
	 jae sub_ax
	 mov cl,[message+32]
	  sub cl,0x30
	  cmp bl,cl
	 jae sub_ax
	 add bl,0x30
	 mov [message2+28],bl
		ret
 endl: mov ax, 0x4c00 
	 int 0x21 
sub_ax: 
cmp bl,0x00
jb endl
dec bl
jmp check_ex
ret_false:call printwarning
	  mov ah,0
	 int 0x16
	jmp  check_invalid1	

  check_invalid2:
	 cmp al,0x31
	 jb  ret_false2
	  cmp al,0x39
	 ja ret_false
	 mov dl,[message+32]
	 cmp dl,0x30
	 je endl
	 cmp al,[message2+28]
	 ja ret_false2
	
	 cmp al,[message+32]
	 ja ret_false2
   mov [message2+28],al
	 templ:mov [message2+32],al
	
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

	minusfoo:
	mov al,[message+32]	
sub al,0x30	
mov bl,[message2+32]
sub bl,0x30
sub al,bl
add al,0x30
mov [minus+13],al
ret	

mulfoo:
	mov al,[message+32]	
sub al,0x30	
mov bl,[message2+32]
sub bl,0x30
mul bl
add al,0x30
mov [multi+10],al
ret

divfoo:
	mov al,[message+32]	
sub al,0x30	
mov bl,[message2+32]
sub bl,0x30
 xor ah, ah 
 xor bh, bh 
div bl
add al,0x30
mov [divisi+11],al
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
 call minusfoo

 add word[mess_y_pos],1
  push word[mess_x_pos] 			
 push word[mess_y_pos] 				
 mov ax, 0x70 			
 push ax 				
 mov ax, minus
 push ax 				
 push word [lminus] 	
 call printstr
 
   call divfoo
   add word[mess_y_pos],1
  push word[mess_x_pos] 			
 push word[mess_y_pos] 				
 mov ax, 0x70 			
 push ax 				
 mov ax, divisi
 push ax 				
 push word [ldivisi] 	
 call printstr
 
  call mulfoo

 add word[mess_y_pos],1
  push word[mess_x_pos] 			
 push word[mess_y_pos] 				
 mov ax, 0x70 			
 push ax 				
 mov ax, multi
 push ax 				
 push word [lmulti] 	
 call printstr
 mov ax, 0x4c00 
	 int 0x21 