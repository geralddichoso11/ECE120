; This program calculates X! (X factorial). It can calculate
;   different numbers (4!, 6!, etc.) by changing the value of the first memory
;   location at the bottom of the code. 
;   The program does not account for zero or negative numbers as input.
 
; Register functions
; R0 - always x0 
; R1 - multiplication results
; R2 - always -1
; R3 - counter for outer loop
; R4 - counter for inner loop
; R5 - current sum
 


            .ORIG  x3000              ; Program starts at x3000
            LD    R0, ZERO
            LD    R1, ZERO
            LD    R2, ZERO
            LD    R3, ZERO
            LD    R4, ZERO
            LD    R5, ZERO
            LD    R2, NEG_ONE         ; Load -1 into R2
            LDI   R1, INPUT_ADDR      ; Load the value from x4000 into R1
            BRnz  LOL
            ADD   R3, R1, R2          ; R3 = INPUT - 1 (initialize outer count)
	    ADD   R3, R3,R2           ; R3 contains input number -2

OUTERLOOP   ADD   R4, R0, R3          ; Copy outer count into inner count

INNERLOOP   ADD   R5, R5, R1          ; Increment sum
            ADD   R4, R4, R2          ; Decrement inner count
            BRzp  INNERLOOP           ; Branch if inner count >= 0

            ADD   R1, R0, R5          ; R1 = sum (result from inner loop)
            AND   R5, R0, R0          ; Clear R5
            ADD   R3, R3, R2          ; Decrement outer count
            BRzp  OUTERLOOP           ; Branch to outer loop if outer count >= 0

            STI   R1, RESULT_ADDR     ; Store the result in x30FF

LOL         HALT

ZERO        .FILL x0000               ; Zero value
NEG_ONE     .FILL xFFFF               ; -1 (two's complement)
INPUT_ADDR  .FILL x4000               ; Address of input value
RESULT_ADDR .FILL x30FF               ; Address for storing the result

            .END

