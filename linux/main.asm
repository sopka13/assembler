%define	SETUP_SEG 	0x07e0
%define	SETUP_SECTS	10

%define	KERNEL_SEG	0x1000
%define	KERNEL_SECTS	1000

section	.text
	BITS	16
	org		0x7c00

entry_point:
	mov		ax,cs
	cli
	mov		ss,ax
	mov		sp,entry_point
	sti
	mov		ds,ax

	;Сохраняем форму курсора
	mov		ah,3
	xor		bh,bh
	int		0x10

	push	cx

	;Отключаем курсор
	mov		ah,1
	mov		ch,0x20
	int		0x10

	;Згружаем setup
	mov		ax,SETUP_SEG
	mov		es,ax

	mov		ax,1
	mov		cx,SETUP_SECTS

	mov		si,load_setup_msg
	call	load_block
	
	call	outstring

	mov		si,complete_msg
	call	outstring

	;Загружаем ядро
	mov		ax,KERNEL_SEG
	mov		es,ax

	mov		ax,1+SETUP_SECTS
	mov		cx,KERNEL_SECTS

	mov		si,load_kernel_msg
	call	load_block

	call	outstring

	mov		si,complete_msg
	call	outstring

	;Восстанавливаем курсор
	pop		cx
	mov		ah,1
	int		0x10

	;Передаем управление на setup
	jmp		SETUP_SEG:0

load_block:
	;Сохраняем количество блоков
	mov		di,cx

.loading:
	xor		bx,bx
	call	load_sector
	inc		ax
	mov		bx,es
	add		bx,0x20
	mov		es,bx

	;Выводим сообщение о загрузке
	call	outstring

	push	ax

	;Выводим проценты
	;((di-cx)/di)*100
	mov		ax,di
	sub		ax,cx
	mov		bx,100
	mul		bx
	div		di

	call	outdec

	push	si
	mov		si,persent_msg
	call	outstring
	pop		si

	pop		ax

	loop	.loading

	ret
