	.ORIG x3000

	AND R0, R0, #0 ; Clear R0
	AND R1, R1, #0 ; Clear R1
	AND R2, R2, #0 ; Clear R2
	AND R3, R3, #0 ; Clear R3
	AND R4, R4, #0 ; Clear R4
	AND R5, R5, #0 ; Clear R5
	AND R6, R6, #0 ; Clear R6

	GETC
	ST R0, CHAR0 ; Bit 0
	GETC
	ST R0, CHAR1 ; Bit 1

	; Setup to read string
	LEA R5, STRING ; R5 Points To The STRING Buffer

FETCH_CHAR
	GETC
	ADD R4, R0, #-10 ; Check If Enter (x000A)
	BRz ROW_COUNTER ; If Enter, Branch To ROWCOUNTER
	STR R0, R5, #0 ; Store Character in STRING
	ADD R5, R5, #1 ; Increment pointer
	ADD R6, R6, #1 ; Increment String Counter
	ST R6, STRINGLEN ; Store String Length
	BRnzp FETCH_CHAR ; Loop For Next Character

ROW_COUNTER
	LD R2, SIXTEEN ; R2 Is Now The Counter For 16 Rows

NEXT_ROW
	LEA R4, STRING ; Reset Pointer To Start Of STRING Buffer
	LD R6, STRINGLEN ; Load string length

LOAD_CHAR
	LDR R0, R4, #0 ; Load character from STRING
	LD R3, FOUR ; R3 Is Counter For LS 4 Times

LS      ; LS 4 Times Gives The Location Of The Pixel Map
	ADD R0, R0, R0 ; Left-Shift Character
	ADD R3, R3, #-1 ; Decrement Counter
	BRp LS ; Loop 4 times
	LD R3, FONT_DATA ; Add FONT_DATA base
	ADD R0, R0, R3
	LD R3, LINE_OFFSET ; Add LINE offset
	ADD R0, R0, R3 
	ST R0, CHARADDRESS ; Store processed character address
	LD R3, CHARADDRESS

	LDR R1, R3, #0 ; Load pixel row
	LD R5, EIGHT ; Set column loop counter
	BRzp OUTPUT		

OUTPUT
	ADD R1, R1, #0 ; Check MSB is - (Bit 0 ) or + (Bit 1)
	BRn NEGATIVE
	BRzp POSITIVE

POSITIVE
	LD R0, CHAR0
	OUT
	BRnzp COLUMN_LOOP

NEGATIVE
	LD R0, CHAR1
	OUT
	BRnzp COLUMN_LOOP

COLUMN_LOOP
	ADD R1, R1, R1 ; Shift To Next Bit
	ADD R5, R5, #-1 ; Decrement Column Counter
	BRp OUTPUT
	ADD R4, R4, #1 ; Move To Next Character In STRING
	ADD R6, R6, #-1 ; Decrement String Counter
	BRp LOAD_CHAR ; Process Next Character
	LD R0, NEW_LINE ; Print NEW_LINE
	OUT
	LD R6, LINE_OFFSET
	ADD R6, R6, #1
	ST R6, LINE_OFFSET ; Increment Line Counter
	ADD R2, R2, #-1 ; Decrement ROW_COUNTER
	BRz STOP
	BRnzp NEXT_ROW ; New Row

STOP
	HALT


CHAR0   	.BLKW 1
CHAR1   	.BLKW 1
CHARADDRESS   	.BLKW 1
STRING  	.BLKW 10
STRINGLEN   	.FILL x0000
LINE_OFFSET   	.FILL x0000
FOUR    	.FILL x0004
EIGHT   	.FILL x0008
SIXTEEN 	.FILL x0010
FONT_DATA   	.FILL x4000
NEW_LINE      	.FILL x000A

.END

