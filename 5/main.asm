section .data								;Сегмент данных
	userMsg	db	'Please enter a number: '	;Присвоение метке userMsg значения
	lenUserMsg	equ	$-userMsg				;Вычисление длины строки
	dispMsg	db	'You have entered: '
	lenDispMsg	equ $-dispMsg

section .bss								;Сегмент неинициализированных данных
	num	resb	5

section	.text								;Сегмент кода
	global _start

_start:										;Запрашиваем пользовательский ввод
	mov	eax,4
	mov	ebx,1
	mov	ecx,userMsg
	mov	edx,lenUserMsg
	int	80h

	mov	eax,3								;Считываем и сохраняем пользовательский ввод (sys_read = 3)
	mov	ebx,2
	mov	ecx,num
	mov	edx,5								;5 байт информации
	int	80h
	
	mov	eax,4								;Выводим сообщение 'The entered number is: '
	mov	ebx,1
	mov	ecx,dispMsg
	mov edx,lenDispMsg
	int	80h

	mov	eax,4								;Выводим введенное число
	mov	ebx,1
	mov	ecx,num
	mov	edx,5
	int	80h

	mov	eax,1								;Код выхода
	mov	ebx,0
	int	80h
