SYS_EXIT	equ	1
SYS_READ	equ	3
SYS_WRITE	equ 4
STDIN		equ	0
STDOUT		equ 1

section .data
	msg1	db	"Enter a digit ", 0xA, 0xD
	len1	equ	$ - msg1

	msg2	db	"Please enter a second digit", 0xA, 0xD
	len2	equ	$ - msg2

	msg3	db	"The sum is: "
	len3	equ	$ - msg3

section .bss
	num1	resb	2
	num2	resb	2
	res		resb	1

section	.text
	global	_start			;должно быть объявлено для использования gcc

_start:						;сообщаем линкеру входную точку
	mov	eax,SYS_WRITE
	mov	ebx,STDOUT
	mov	ecx,msg1
	mov	edx,len1
	int	0x80

	mov	eax,SYS_READ
	mov	ebx,STDIN
	mov	ecx,num1
	mov	edx,2
	int	0x80

	mov	eax,SYS_WRITE
	mov	ebx,STDOUT
	mov	ecx,msg2
	mov	edx,len2
	int	0x80

	mov	eax,SYS_READ
	mov	ebx,STDIN
	mov	ecx,num2
	mov	edx,2
	int	0x80

	mov	eax,SYS_WRITE
	mov	ebx,STDOUT
	mov	ecx,msg3
	mov	edx,len3
	int	0x80

	;перемещаем первое число в регистр eax, второе в ebx
	;и вычитаем ASCII '0' для конвертации в десятичное число

	mov	eax,[num1]
	sub	eax,'0'

	mov	ebx,[num2]
	sub	ebx,'0'

	;добавляем eax и ebx
	add	eax,ebx
	;добавляем '0' для конвертации из десятичной системы в ASCII
	add	eax,'0'

	;сохраняем сумму в ячейке памяти res
	mov	[res],eax

	;выводим сумму
	mov	eax,SYS_WRITE
	mov	ebx,STDOUT
	mov	ecx,res
	mov	edx,1
	int	0x80

exit:
	mov	eax,SYS_EXIT
	xor	ebx,ebx
	int	0x80
