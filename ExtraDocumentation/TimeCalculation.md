## Logic for Time Calculation

TIME:
; 255 + 65 = 320 clock cycles for ECHO
	LDI R22, 0xFF		; Load immediate 255 into R22
	LDI R23, 0x41		; Load immediate 65 int R23

	SUB R22, R20		; Subtract R22 (255) - R20 (varies)
	ADD R22, R23		; Add R22 (result of previous calculation) + R23 (65)
; R22 should now hold the time in clock cycles taken for the ECHO to pull 1.
	
	CLR R23				; Clear R23 for reuse

DEFINITIONS:
; 16 clock cycles = 1 microsecond
	.DEF NUMERATOR = R22		; Define R22 as the numerator
	.DEF DENOMINATOR = R23		; Define R23 as the denominator
	.DEF QUOTIENT = R24			; Define R24 as the quotient

	LDI DENOMINATOR, 0x10		; Load immediate 16 into the register defined as the denominator
	CLR QUOTIENT				; Clear the the register defined as the quotient to ensure that it is 0

DIVIDE:
	INC QUOTIENT				; Increment the quotient for each loop for a remainder
	SUB NUMERATOR, DENOMINATOR	; Subtract R22 - R23
	BRCC DIVIDE					; Branch (if carry cleared) if the carry is cleared relative to the program counter

	DEC QUOTIENT				; Decrement quotient to prevent an additional loop from being added

; The quotient, R24, should now hold the result of the division
; The time in microseconds