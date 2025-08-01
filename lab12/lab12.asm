	.ORIG x3000

	AND R0, R0, #0 ; Clear R0
	AND R1, R1, #0 ; Clear R1 
	AND R2, R2, #0 ; Clear R2
	AND R3, R3, #0 ; Clear R3
	AND R4, R4, #0 ; Clear R4
	AND R5, R5, #0 ; Clear R5
	AND R6, R6, #0 ; Clear R6

	GETC   
        ADD R1, R0, #0 ; Bit 0
	GETC            
	ADD R2, R0, #0 ; Bit 1
	GETC            
	ADD R3, R0, #0 ; Character To Print
    
	LD R5, FONT_DATA ; Load FONT_DATA

	ADD R4, R4, #4 ; R4 Is A Counter To Left-Shift 4 Times
		      
LEFT_SHIFT ; Left-Shifting 4 Times Gives The Location Of The Pixel Map
	ADD R3, R3, R3 
	ADD R4, R4, #-1
	BRp LEFT_SHIFT

ADDITION
	ADD R3, R3, R5 ; x4000 + ASCII (in hex) To Retrieve Location In FONT_DATA
	AND R5, R5, #0 
	ADD R5, R5, #15
	ADD R5, R5, #1 ; R5 Is Now The Counter For 16 Rows
	
RESET_COLUMN
	LDR R6, R3, #0 ; Load Memory Of Data In R3 => M[x4410] for Beginning Of "A"	
	AND R4, R4, #0
	ADD R4, R4, #8 ; R4 Is Now The Counter for 8 Columns

Column_LOOP ; Loop For 8 Columns
	ADD R6, R6, #0 
	BRzp POSITIVE
	BRn NEGATIVE
 
POSITIVE ; First Character Input
	AND R0, R0, #0
	ADD R0, R1, #0
	BR OUTPUT

Negative ; Second Character Input
	AND R0, R0, #0
	ADD R0, R2, #0
		
OUTPUT
	OUT ; Ouputs Character
	ADD R6, R6, R6 ; Used For Left Shifting To Check MSB 
		       ; + or 0 => First Character, - => Second Character 
	ADD R4, R4, #-1 ; Decrement Column Counter
	BRp Column_LOOP
	BRz NEXT_ROW

NEXT_ROW
	LD R0, NEW_LINE ; Ouputs Will Continue On a New Row
	OUT 
	ADD R3, R3, #1 ; Move To Next Line On Pixel Map
	ADD R5, R5, #-1 ; Decrement Row Counter
	BRp RESET_COLUMN
	
	HALT

FONT_DATA .FILL x4000
NEW_LINE .FILL x000A
	
    .END
