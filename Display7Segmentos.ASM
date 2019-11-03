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
	
	__CONFIG _CP_OFF & _WDT_OFF & _BODEN_OFF & _PWRTE_ON & _RC_OSC & _WRT_OFF & _LVP_ON & _CPD_OFF

; '__CONFIG' directive is used to embed configuration data within .asm file.
; The lables following the directive are located in the respective .inc file.
; See respective data sheet for additional information on configuration word.






;***** VARIABLE DEFINITIONS
w_temp		EQU	0x7D		; variable used for context saving 
status_temp	EQU	0x7E		; variable used for context saving
pclath_temp	EQU	0x7F		; variable used for context saving			

	CBLOCK H'20'
		w_temp
		UNIDADE
		DEZENA
        CONTADOR
	ENDC

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

; 
 dt0 equ "0b10000001
 dt1 equ "0b11001111
 dt2 equ "0b10010010
 dt3 equ "0b10000110
 dt4 equ "0b11001100
 dt5 equ "0b10100100
 dt6 equ "0b11100000
 dt7 equ "0b10001111
 dt8 equ "0b10000000
 dt9 equ "0b10001100
 org 0h ; Reseta
goto SAIDAS ; vai para as saidas


SAIDAS 
	clrf PORTB
	clrf PORTC ; Limpa as portas B e C para determinar quais sao as saidas
	bsf STATUS, RP0
	bcf STATUS, RP1
	movlw h'0'
	movwf TRISB
	movwf TRISC
	bcf STATUS, RP0 ; vai para o banco 0	

	
main		; Progama principal começa aqui

	clrf CONTADOR ;inicia as dezenas
	clrf PORTC	     


LOOP
	movlw dt0 ; carrega o valor 0 no w
	movlw PORTB
	call Delay ; funçao delay
	movlw dt1 ; carrega o valor 1 no w
	movlw PORTB
	call Delay ; funçao delay
	movlw dt2 ; carrega o valor 2 no w
	movlw PORTB
	call Delay ; funçao delay
	movlw dt3 ; carrega o valor 3 no w
	movlw PORTB
	call Delay ; funçao delay
	movlw dt4 ; carrega o valor 4 no w
	movlw PORTB
	call Delay ; funçao delay
	movlw dt5 ; carrega o valor 5 no w
	movlw PORTB
	call Delay ; funçao delay
	movlw dt6 ; carrega o valor 6 no w
	movlw PORTB
	call Delay ; funçao delay
	movlw dt7 ; carrega o valor 7 no w
	movlw PORTB
	call Delay ; funçao delay
	movlw dt8 ; carrega o valor 8 no w
	movlw PORTB
	call Delay ; funçao delay
	movlw dt9 ; carrega o valor 9 no w
	movlw PORTB
	call Delay ; funçao delay
	incf CONTADOR,1 ; icrementa o contador
	movlw .10 ; 
	xorwf CONTADOR, w
	btfsc STATUS,Z
	goto main

DEZENAS
	movlw .0 ; w = 0
	xorwf CONTADOR,W
	btfsc STATUS,Z ; verifica se o bit f está limpo
	goto MOATRA0
	movlw .1 ; w = 1
	xorwf CONTADOR,W
	btfsc STATUS,Z ; verifica se o bit f está limpo
	goto MOATRA1
	movlw .2  ; w = 2
	xorwf CONTADOR,W 
	btfsc STATUS,Z ; verifica se o bit f está limpo
	goto MOATRA2
	movlw .3  ; w = 3
	xorwf CONTADOR,W
	btfsc STATUS,Z ; verifica se o bit f está limpo
	goto MOATRA3
	movlw .4 ; w = 4
	xorwf CONTADOR,W
	btfsc STATUS,Z ; verifica se o bit f está limpo
	goto MOATRA4
	movlw .5 ; w = 5
	xorwf CONTADOR,W
	btfsc STATUS,Z ; verifica se o bit f está limpo
	goto MOATRA5
	movlw .6 ; w = 6
	xorwf CONTADOR,W
	btfsc STATUS,Z ; verifica se o bit f está limpo
	goto MOATRA6
	movlw .7 ; w = 7
	xorwf CONTADOR,W
	btfsc STATUS,Z ; verifica se o bit f está limpo
	goto MOATRA7
	movlw .8 ; w = 8
	xorwf CONTADOR,W
	btfsc STATUS,Z ; verifica se o bit f está limpo
	goto MOATRA8
	movlw .9 ; w = 9
	xorwf CONTADOR,W
	btfsc STATUS,Z ; verifica se o bit f está limpo
	goto MOATRA9


MOSTRA0
	movlw dt0
	movwf PORTC
	goto LOOP
MOSTRA1
	movlw dt1
	movwf PORTC
	goto LOOP
MOSTRA2
	movlw dt2
	movwf PORTC
	goto LOOP
MOSTRA3
	movlw dt3
	movwf PORTC
	goto LOOP
MOSTRA4
	movlw dt4
	movwf PORTC
	goto LOOP
MOSTRA5
	movlw dt5
	movwf PORTC
	goto LOOP
MOSTRA6
	movlw dt6
	movwf PORTC
	goto LOOP
MOSTRA7
	movlw dt7
	movwf PORTC
	goto LOOP
MOSTRA8
	movlw dt8
	movwf PORTC
	goto LOOP
MOSTRA9
	movlw dt9
	movwf PORTC
	goto LOOP

	Delay 
				movwf 		delay_mult 	
	Del_m10     movlw 	.10	
				Movwf		 delay_k50 	
	Del_50		movlw .10	
				movwf 		delay_k200	
	Del_200 	nop 				
				nop
				decfsz		 delay_k200,f	 
				goto 		Del_200 			
				decfsz 		delay_k50,f	 ;
				goto 		Del_50 	
				decfsz		 delay_mult,f	
				goto 	Del_m10	
				return


	END                      
