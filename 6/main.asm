section .text
	global _start				;должно быть объявлено для линкера
_start:							;сообщаем линкеру входную точку

	;пишем имя Zara Ali
	mov	edx,15					;длина сообщения
	mov	ecx,name				;сообщение для написания
	mov	ebx,1					;файловый дискриптор (std_out)
	mov	eax,4					;номер системного вызова (sys_write)
	int	0x80					;вызов ядра

	mov	[name],dword'N'		;изменяем имя на Nuha Ali
	
	;пишемм имя Nuha Ali
	mov	edx,15					;длина сообщения
	mov	ecx,name				;сообщение для написания
	mov	ebx,1					;файловый дискриптор (std_out)
	mov	eax,4					;системный вызов (sys_write)
	int	0x80					;вызов ядра

	mov	eax,1					;номер системного вызова (sys_exit)
	int	0x80					;вызов ядра

section .data
name db 'Zara Ali Borad '
