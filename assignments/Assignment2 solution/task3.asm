
; [org 0x0100]
 ; jmp start
; message: db 'Enter three lowercase alphabets (a ~ z) :afd' ;42=a,
; length1: dw 44
; message2:db 'The output is :',0x00,0x00,0x00 ;16=A
; length2:dw 18
; temp:dw 0
	; Warning:db ' Wrong input '
	; lwarning:dw 13
		; clrscr: push es 
 ; push ax 
 ; push cx 
 ; push di 
 ; mov ax, 0xb800 
 ; mov es, ax 	
 ; xor di, di 	 
 ; mov ax, 0x7420  
 ; mov cx, 2000 	
 ; cld 			
 ; rep stosw 		
 ; pop di 
; pop cx 
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
	; je l2
	
	; printstr: push bp
	 ; mov bp, sp
	 ; push es
	 ; push ax
	 ; push cx
	 ; push si
	 ; push di
	 ; l2:mov ax, 0xb800
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

	; cmp dx,[bp+10]
	; jne l1
	 ; pop di
	 ; pop si
	 ; pop cx
	 ; pop ax
	 ; pop es
	 ; pop bp
	 ; ret 10
	 
	 
	 ; check_invalid:
	  ; push bp
	 ; mov bp, sp
	 ; mov si,0
	 ; mov cx,3
	 ; l7:
	 ; mov al,[message+si+41]
	; cmp al,0x61
	; jb false_check
	 ; cmp al,0x7A
	 ; ja false_check
	 ; add si,1
	 ; loop l7
	 ; pop bp
	 ; ret 
 
 ; false_check:
 ; mov word[temp],1
  ; pop bp
 ; ret 
 ; conversion:
 ; push bp
 ; mov bp, sp
 ; mov si,0
 ; mov cx,3
; l4: mov al,[message+si+41]
 ; sub al,32
 ; mov [message2+si+15],al
 ; add si,1
 ; loop l4
 ; pop bp
 ; ret 
 
; start: call clrscr 
 ; mov ax, 10
 ; push ax 			
 ; mov ax, 10
 ; push ax 			
 ; mov ax, 0x70 		
 ; push ax 			
 ; mov ax, message
 ; push ax 			
 ; push word [length1]
 ; call check_invalid
 ; call conversion
 ; call printstr 		
 ; cmp word[temp],1
	 ; jne endl
	; call clrscr
	 ; mov ax, 30
	 ; push ax 		
	 ; mov ax, 11
	 ; push ax		
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
message: db 'Enter three lowercase alphabets (a ~ z) :' 
length1: dw 41
mess_y_pos:dw 10
mess_x_pos:dw 10
message2:db 'The output is :',0x31,0x32,0x33 ;16=A
length2:dw 18
	Warning:db ' Wrong input '
	lwarning:dw 13
		clrscr: push es 
 push ax 
 push cx 
 push di 
 mov ax, 0xb800 
 mov es, ax 	
 xor di, di 	 
 mov ax, 0x7420  
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
	 l2:mov ax, 0xb800
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
 add word[mess_x_pos],1
 
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
	 
	 check_invalid:
	 cmp al,0x61
	 jb  ret_false
	 cmp al,0x7A
	 ja ret_false
	
	 sub al,0x20
	 mov si,dx
	 mov [message2+si+15],al
		ret
ret_false:call printwarning
	  mov ah,0
	 int 0x16
	jmp check_invalid
	
	
	
	
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
 call check_invalid
 mov dx,1
  mov ah,0
 int 0x16
  call check_invalid
  mov dx,2
  mov ah,0
 int 0x16
  call check_invalid
	call clrscr
	 mov ax, 30
	 push ax 		
	 mov ax, 11
	 push ax		
	 mov ax, 0x71 		
	 push ax 	 
	 mov ax, message2
	 push ax 			
	 push word [length2] 
	 call printstr
	endl: mov ax, 0x4c00 
	 int 0x21 
 
 
 
 

 
 
