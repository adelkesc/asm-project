;
; DistanceSensor.asm
;
; Created: 14/11/2018 10.09.43
; Author : adand
;

; Main project, Distance Sensor

INIT:
	LDI R16, 0x01		; Set TRIG pin to high and output signal, pin 1 in port A contains the high signal.
	LDI R17, 0x00		; Load immediate 0 into R17 as TRIG signal cutoff
	LDI R18, 0x35		; Load immediate 53 into R18 for 10 microsecond delay counter
	OUT DDRA, R16		; Set PINA as an output for TRIG
	OUT DDRC, R17		; Set PINC as an output for the sensor calculation

TRIG:
; Outputs signal for 10 microseconds
	OUT PORTA, R16		; Output R16 to PORTA to start TRIG signal
	
; Loop to output for 10 microseconds
DELAY_1:
	DEC R18				; Decrement R18 counter
	BRNE DELAY_1		; Branch (if not equal) if the counter is not zero 
	OUT PORTA, R17		; Output R17 to PORTA to stop TRIG signal
	
ECHO:
; Receives input from signal sent by TRIG, open for input for 20 microseconds
	LDI R19, 0x6B		; Load immediate 107 into R19 for 20 microsecond delay counter

; Loop to listen for input for 20 microseconds
DELAY_2:
	INC R20				; Increments R20 until the DELAY_2 loop stops due to R17 pulling high
	DEC R19				; Decrement R19 counter

	IN R21, PINB		; Input the value of PINB into R21
	TST R21				; Tests R21 to check if the zero flag is 0
	BREQ DELAY_2		; Branch (if equal) to the DELAY_2 label if the zero flag is true (z = 1)
	
	BRNE MAIN			; Branch (if not equal) to MAIN if the zero flag is false (z = 0)
	JMP INIT			; Jumps to INIT if the DEC R20 counter reaches zero without R17 ever pulling high

; (moved to markdown)
; If R21 does receive a 1 from PINB then the value in R20 is calculated against the total amount of clock cycles for the ECHO
; The value of R22 is then divided by 16 to get the quotient, which should be the total clock cycles converted into microseconds
; (moved to markdown)

MAIN:
	OUT PORTC, R21		; Output the value of R21 to PORTC
	JMP INIT			; Jump to INIT