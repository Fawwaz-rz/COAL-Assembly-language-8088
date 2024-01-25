
	; [org 0x0100]
	 ; jmp start
	; message: db 'I won $25000 in lottery but I lost $5000' 
	; length1: dw 40

	; clrscr: push es
	 ; push ax
	 ; push di
	; mov ax, 0xb800
	 ; mov es, ax 
	 ; mov di, 0 
	; nextloc: mov word [es:di], 0x7420 
	 ; add di, 2 
	 ; cmp di, 4000 
	 ; jne nextloc 
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
	 ; mov es, ax 		
	 ; mov al, 80 		
	 ; mul byte [bp+10] 	
	 ; add ax, [bp+12] 	
	 ; shl ax, 1 			
	 ; mov di,ax			
	 ; mov si, [bp+6] 	
	 ; mov cx, [bp+4] 	
	 ; mov ah, [bp+8] 	


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
	; start: call clrscr 		
	 ; mov ax, 20
	 ; push ax				
	 ; mov ax, 10
	 ; push ax 				
	 ; mov ax, 0x70 			
	 ; push ax 				
	 ; mov ax, message
	 ; push ax 				
	 ; push word [length1] 	
	 ; call printstr 
	 ; mov ax, 0x4c00
	 ; int 0x21
	 
	 
	 
;/////////////////////////////////////////////////////////////////////////////////////////////////////////////

	[org 0x0100]
	 jmp start
	message: db 'I won $25000 in lottery but I lost $5000' 
	length1: dw 40

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
	 mul byte [bp+6] 	
	 add ax, [bp+8] 	
	 shl ax, 1 			
	 mov di,ax			
	 mov si, message	
	 mov cx, [length1]	
	 mov ah, [bp+4] 	


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
	start: call clrscr 		
	 mov ax, 20
	 push ax				
	 mov ax, 10  
	 push ax 				
	 mov ax, 0x70 	
	 push ax 					
	 call printstr 
	 mov ax, 0x4c00
	 int 0x21	 
	 
	 
	 