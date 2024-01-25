
 
[org 0x0100] 
 jmp start 
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
	 
	printnum: push bp 
	 mov bp, sp 
	 push es 
	 push ax 
	 push bx 
	 push cx 
	 push dx 
	 push di 
	 mov ax, 0xb800 
	 mov es, ax 
	 mov al, 80 		
	 mul byte [bp+10] 	
	 add ax, [bp+12] 	
	 shl ax, 1 			
	 mov di,ax	
	 mov ax, [bp+6] ; num loading
	 mov bx, 10 
	 mov cx, 0   
	nextdigit: mov dx, 0
	 div bx 			
	 add dl, 0x30 		
	 push dx 			
	 inc cx 			
	 cmp ax, 0 			
	 jnz nextdigit 		
	 nextpos: pop dx 	
	 mov dh, 0x70  		
	 mov [es:di], dx 	
	 add di, 2 			
	 loop nextpos 		
	 pop di 
	 pop dx 
	 pop cx 
	 pop bx 
	 pop ax 
	 pop es 
	 pop bp 
	 ret 2 
start: call clrscr 
mov ax, 30
	 push ax				
	 mov ax, 10
	 push ax 				
	 mov ax, 0x70 			
	 push ax 				
	 mov ax, statement
	 push ax 				
	 push word [length1] 	
	 call printstr 
     mov ax, 42
	 push ax				
	 mov ax,10
	 push ax 				
	 mov ax, 0x70 			
	 push ax 		
 mov ax, [ALPHA]
 push ax ; no. on stack
mov ax,0
 push ax
 call printnum  
 mov ax, 0x4c00
 int 0x21 
 ALPHA: dw 36
 statement:dw 'ALPHA is : '
 length1:dw 11
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 