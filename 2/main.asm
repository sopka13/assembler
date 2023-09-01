text	segment				;начало сегмента команд
assume	CS:text, DS:data	;Сегментный регистр CS будет указывать на
							;сегмент команд, а сегментный регистр DS 
							;на сегмент данных
begin:	mov	AX, data		;Адрес сегмента данных загрузим в AX
		mov	DS, AX			;а затем перенесем из AX в DS
		mov	AH, 09h			;Функция DOS 9h вывода на экран
		mov	DX, offset mesg	;Адрес выводимого сообщения должен быть в DS
		int	21h				;Вызов DOS
		mov	AH, 4Ch			;Функция 4Ch заверщения программы
		mov AL, 0			;Код 0 успешного завершения
		int	21h				;Вызов DOS
text	ends				;конец сегмента команд
data	segment				;начало сегмента данных
mesg	db 'Начинаем!'		;Выводимый текст
data	ends				;Конец сегмента данных
stk		segment stack		;Начало сегмента стека
		db 256 dup (0)		;резервируем 256 байт для стека
stk		ends				;Конец сегмента стека
		end	begin			;Конец текста команды с точкой входа