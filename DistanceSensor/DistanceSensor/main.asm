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
	LDI R18, 0x00
	OUT PORTA, R16
	LDI R19, 0x35 ; Load immediate 53 into Register 19

; Loop to output for 10 microseconds
DELAY_1:
	DEC R19
	BRNE DELAY_1
	OUT PORTA, R18
	
ECHO:
; Receives input from signal sent by TRIG, open for input for 20 microseconds
	;OUT DDRB, R17 ; port B is ECHO input, dont need this because ddr is default 0
	LDI R20, 0x6B ; Load immediate 107 into Register 20

; Loop to listen for input for 20 microseconds
DELAY_2:
	DEC R20
	BRNE DELAY_2
	IN R17, PINB
	JMP TRIG

	; Find the time and make the distance calculation

DISPLAY: