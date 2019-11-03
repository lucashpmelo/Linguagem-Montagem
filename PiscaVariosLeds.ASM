;**********************************************************************
;   This file is a basic code template for assembly code generation   *
;   on the PIC16F877A. This file contains the basic code              *
;   building blocks to build upon.                                    *  
;                                                                     *
;   Refer to the MPASM User's Guide for additional information on     *
;   features of the assembler (Document DS33014).                     *
;                                                                     *
;   Refer to the respective PIC data sheet for additional             *
;   information on the instruction set.                               *
;                                                                     *
;**********************************************************************
;                                                                     *
;    Filename:	    xxx.asm                                           *
;    Date:                                                            *
;    File Version:                                                    *
;                                                                     *
;    Author:                                                          *
;    Company:                                                         *
;                                                                     * 
;                                                                     *
;**********************************************************************
;                                                                     *
;    Files Required: P16F877A.INC                                     *
;                                                                     *
;**********************************************************************
;                                                                     *
;    Notes:                                                           *
;                                                                     *
;**********************************************************************


	list		p=16f877A	; list directive to define processor
	#include	<p16f877A.inc>	; processor specific variable definitions
	
	__CONFIG _CP_OFF & _WDT_OFF & _BODEN_ON & _PWRTE_ON & _HS_OSC & _WRT_OFF & _LVP_OFF & _CPD_OFF

; '__CONFIG' directive is used to embed configuration data within .asm file.
; The lables following the directive are located in the respective .inc file.
; See respective data sheet for additional information on configuration word.






;***** VARIABLE DEFINITIONS
w_temp		EQU	0x7D		; variable used for context saving 
status_temp	EQU	0x7E		; variable used for context saving
pclath_temp	EQU	0x7F		; variable used for context saving			

	cblock 0x20
		d1
		d2
		d3
	endc
;**********************************************************************
	ORG     0x000             ; processor reset vector

	nop			  ; nop required for icd
  	goto    main              ; go to beginning of program


	ORG     0x004             ; interrupt vector location

	movwf   w_temp            ; save off current W register contents
	movf	STATUS,w          ; move status register into W register
	movwf	status_temp       ; save off contents of STATUS register
	movf	PCLATH,w	  ; move pclath register into w register
	movwf	pclath_temp	  ; save off contents of PCLATH register

; isr code can go here or be located as a call subroutine elsewhere

	movf	pclath_temp,w	  ; retrieve copy of PCLATH register
	movwf	PCLATH		  ; restore pre-isr PCLATH register contents
	movf    status_temp,w     ; retrieve copy of STATUS register
	movwf	STATUS            ; restore pre-isr STATUS register contents
	swapf   w_temp,f
	swapf   w_temp,w          ; restore pre-isr W register contents
	retfie                    ; return from interrupt



main

; remaining code goes here

 ;banksel	TRISB		;Vai para bank 1
						;Alteramos os bits do STATUS para mudar de banco --> BANK1
 bcf		STATUS,RP1	;Coloca 0 no bit RO1 do Registrador STATUS
 bsf		STATUS,RP0	;Coloca 1 no bit RP0 do Registrador STATUS

 bcf		TRISB,TRISB0 ;Bit 0 portb como saida
 bcf		TRISB,TRISB1
 bcf		TRISB,TRISB2
 bcf		TRISB,TRISB3
 bcf		TRISB,TRISB4
 bcf		TRISB,TRISB5
 bcf		TRISB,TRISB6
 bcf		TRISB,TRISB7
 ;banksel	PORTB		;Vai para o bank 0
						;Retornamos para o BANK0
 bcf		STATUS,RP1	;Coloca 0 no bit RO1 do Registrador STATUS
 bcf		STATUS,RP0	;Coloca 1 no bit RP0 do Registrador STATUS

loop				;Inicio do laço principal
	bsf	PORTB,RB0	;Coloca nivel alto do bit 0 da porta B
	call delay		;Aguarda 0,5 segundos
	bcf	PORTB,RB0	;Coloca nivel baixo no bit 0 do port B
	bsf	PORTB,RB1
	call delay
	bcf PORTB,RB1
	bsf	PORTB,RB2
	call delay
	bcf PORTB,RB2
	bsf	PORTB,RB3
	call delay
	bcf PORTB,RB3
	bsf	PORTB,RB4
	call delay
	bcf PORTB,RB4
	bsf	PORTB,RB5
	call delay
	bcf PORTB,RB5
	bsf	PORTB,RB6
	call delay
	bcf PORTB,RB6
	bsf	PORTB,RB7
	call delay
	bcf PORTB,RB7
	call delay
	goto loop		;Fim do laço principal

;------------------------------------------------------------------------------
; Subrotinas - delay 0,5 segundos
;------------------------------------------------------------------------------
delay
			;2499992 cycles
	movlw	0x15
	movwf	d1
	movlw	0x74
	movwf	d2
	movlw	0x06
	movwf	d3
delay_0
	decfsz	d1,	f
	goto	$+2
	decfsz	d2,	f
	goto	$+2
	decfsz	d3,	f
	goto	delay_0

			;4 cycles
	goto	$+1
	goto	$+1

			;4 cycles (including call)
	return

	END                       ; directive 'end of program'

