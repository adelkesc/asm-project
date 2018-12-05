## Assembly Project Output Test Code

INIT:
	LDI R16, 0x01		; Load immediate 1 into R16
	LDI R17, 0x00		; Load immediate 0 into R17
	LDI R18, 0x35		; Load immediate 53 into R18 (for Trig and Echo test)
	LDI R19, 0x35		; Load immediate 53 into R19 (to extend Echo for 10 more microseconds (not used))

	OUT DDRA, R16		; Set PINA as an output
	OUT DDRC, R17		; Set PINC as an output
	OUT PORTA, R16		; Output R16 to PORTA
	OUT PORTC, R17		; Output R17 to PORTC

L1:
	IN R20, PINB		; Input the value of PINB into R20

TRIG_DELAY:
	INC R21				; Increment R21
	DEC R18				; Decrement R18
	TST R20				; Test R20 to check if it is 0
	BREQ L1				; Branch (if equal) to L1 if the zero flag is true (z = 1)
	BRNE MAIN			; Branch (if not equal) to MAIN if the zero flag is false (z = 0)

	JMP INIT			; Jump to INIT if the counter, R18, expires without R20 ever pulling 1

MAIN:
	OUT PORTC, R20		; Output the value of R20 to PORTC
	JMP INIT			; Jump to INIT