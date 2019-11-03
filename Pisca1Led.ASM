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
	
	__CONFIG _CP_OFF & _WDT_OFF & _BODEN_OFF & _PWRTE_ON & _HS_OSC & _WRT_OFF & _LVP_OFF & _CPD_OFF

; '__CONFIG' directive is used to embed configuration data within .asm file.
; The lables following the directive are located in the respective .inc file.
; See respective data sheet for additional information on configuration word.






;***** VARIABLE DEFINITIONS
w_temp		EQU	0x7D		; variable used for context saving 
status_temp	EQU	0x7E		; variable used for context saving
pclath_temp	EQU	0x7F		; variable used for context saving	
PDel0 		EQU 0x20		; variavel pra delay
PDel1  		EQU 0x21		; variavel pra delay






;**********************************************************************
	ORG     0x000             

	nop			  
  	goto    main             
	ORG     0x004            
	movwf   w_temp            
	movf	STATUS,w          
	movwf	status_temp       
	movf	PCLATH,w	  
	movwf	pclath_temp	  
	movf	pclath_temp,w	 
	movwf	PCLATH		 
	movf    status_temp,w     
	movwf	STATUS            
	swapf   w_temp,f
	swapf   w_temp,w          
	retfie                    
main	
	BCF STATUS,RP1
	BSF STATUS,RP0
	MOVLW 0X00 
	MOVWF TRISB ; set for trisb
	BCF STATUS,RP0;volta para o banco 0
loop
	BSF PORTB,RB0;
	CALL DELAY; chama funcao delay
	BCF PORTB,RB0;limpa porta b
	CALL DELAY
	GOTO loop
DELAY
	movlw .239 
	movwf PDel0 
PLoop1
	movlw .232 
	movwf PDel1 
PLoop2
	clrwdt ; limpa watchdog
PDelL1
	goto PDelL2 
PDelL2
	goto PDelL3 
PDelL3
	clrwdt 
	decfsz PDel1, 1 
	goto PLoop2 
	decfsz PDel0, 1 
	goto PLoop1 
PDelL4
	goto PDelL5 
PDelL5
	goto PDelL6 
PDelL6
	goto PDelL7 
PDelL7
	clrwdt 

	END  

