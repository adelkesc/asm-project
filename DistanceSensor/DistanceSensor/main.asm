;
; DistanceSensor.asm
;
; Created: 14/11/2018 10.09.43
; Author : adand
;

; Main project, Distance Sensor
; Push Button LED code moved to separate file to prevent accidents.

START:
; Setup input and output registers
	LDI R16, 0x01
	OUT DDRA, R16 ; port A is TRIG output
	OUT DDRB, R16 ; port B is ECHO input
	;OUT DDRC, R16

TRIG:
; Outputs signal for 10 microseconds
	LDI R16, 0x01 ; Set TRIG pin to high and output signal, pin 1 in port A contains the high signal.
	OUT PORTA, R16
	; Delay goes here.
	
ECHO:
; Receives input from signal sent by TRIG
	IN R17, PINB
	;OUT PORTC, R17
	; Time and distance calculations
	; How to make these calcuations?

	;LDI R18, 0x00 ; zero until calculations are made
	;OUT DDRC, R18 ; nothing until calculations are made

MAIN:
	; Adjusts input from ECHO and outputs to LED (single LED or bar graph)
	;CLR R16, R17 ; clear registers?
	;JMP START ; Jump to START or TRIG and begin again.