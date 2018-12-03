;
; DistanceSensor.asm
;
; Created: 14/11/2018 10.09.43
; Author : adand
;

; Main project, Distance Sensor
; Push Button LED code moved to separate file to prevent accidents.

TRIG:
; Outputs signal for 10 microseconds
	LDI R16, 0x01 ; Set TRIG pin to high and output signal, pin 1 in port A contains the high signal.
	OUT DDRA, R16 ; port A is TRIG output
	LDI R18, 0x00 ; zero value to set the trig back to low
	OUT PORTA, R16
	LDI R19, 0x35 ; Load immediate 53 into R19 for 10 microsecond delay

; Loop to output for 10 microseconds
DELAY_1:
	DEC R19
	BRNE DELAY_1
	OUT PORTA, R18
	
ECHO:
; Receives input from signal sent by TRIG, open for input for 20 microseconds
	LDI R20, 0x6B ; Load immediate 107 into Register 20

; Loop to listen for input for 20 microseconds
DELAY_2:
	INC R22 ; Increments R22 until R17 pulls high (trig output is detected)

	IN R17, PINB
	TST R17 ; Tests the zero flag
	BRNE DISTANCE ; Jumps to the DISTANCE label if the zero flag is false (checking for a 1, zero flag should be true most of the time)

	DEC R20 ; Decrements R20 for 20 microsecond loop
	BRNE DELAY_2 ; Jumps to DELAY_2 if the zero flag is false (delaying until count reaches zero, zero flag should be false until then)
	JMP TRIG

TIME:
	
	LDI R21, 0xFF ; 255
	LDI R23, 0x41 ; 65
	; 255 + 65 = 320 clock cycles

	SUB R21, R22
	ADD R21, R23
	; R21 should now hold the time in clock cycles taken for the ECHO to pull 1.
	
	CLR R23 ; clear R23 for reuse

	; 16 clock cycles = 1 microsecond
	; Take the value of R21 and divide it by 16 to get the microseconds
	.DEF NUMERATOR = R21
	.DEF DENOMINATOR = R23
	.DEF QUOTIENT = R24

	LDI DENOMINATOR, 16
	CLR QUOTIENT

DIVIDE:
	INC QUOTIENT
	SUB NUMBERATOR, DENOMINATOR
	BRCC DIVIDE

	DEC QUOTIENT
	; The quotient, R24, should now hold the result of the division
	; The time in microseconds
	
MAIN: