section .data
	msg	db	'Тут может храниться бесконечный текст, как я понял, потому, что конца или так сказать емкости такого типа данных я не нашел. Тестить буду по ходу дела',0xa
	len	equ	$ - msg

section	.text
	global	_start

_start:
	mov	eax,4
	mov	ebx,1
	mov	ecx,msg
	mov	edx,len
	int 0x80

	mov	eax,1
	int	0x80
