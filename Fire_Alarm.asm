;*******************************************************************************
; *
; Microchip licenses this software to you solely for use with Microchip *
; products. The software is owned by Microchip and/or its licensors, and is *
; protected under applicable copyright laws. All rights reserved. *
; *
; This software and any accompanying information is for suggestion only. *
; It shall not be deemed to modify Microchip?s standard warranty for its *
; products. It is your responsibility to ensure that this software meets *
; your requirements. *
; *
; SOFTWARE IS PROVIDED "AS IS". MICROCHIP AND ITS LICENSORS EXPRESSLY *
; DISCLAIM ANY WARRANTY OF ANY KIND, WHETHER EXPRESS OR IMPLIED, INCLUDING *
; BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS *
; FOR A PARTICULAR PURPOSE, OR NON-INFRINGEMENT. IN NO EVENT SHALL *
; MICROCHIP OR ITS LICENSORS BE LIABLE FOR ANY INCIDENTAL, SPECIAL, *
; INDIRECT OR CONSEQUENTIAL DAMAGES, LOST PROFITS OR LOST DATA, HARM TO *
; YOUR EQUIPMENT, COST OF PROCUREMENT OF SUBSTITUTE GOODS, TECHNOLOGY OR *
; SERVICES, ANY CLAIMS BY THIRD PARTIES (INCLUDING BUT NOT LIMITED TO ANY *
; DEFENSE THEREOF), ANY CLAIMS FOR INDEMNITY OR CONTRIBUTION, OR OTHER *
; SIMILAR COSTS. *
; *
; To the fullest extend allowed by law, Microchip and its licensors *
; liability shall not exceed the amount of fee, if any, that you have paid *
; directly to Microchip to use this software. *
; *
; MICROCHIP PROVIDES THIS SOFTWARE CONDITIONALLY UPON YOU
10
; File Version: 4 *
; Author: Arman Chowdhury and Chinmay Vaishnav *
; Company: Macquarie University *
; Description: Fire Alarm Program code for Assignment 2 of ELEC342, Session 1 of 2017. *
; *
;*******************************************************************************
; *
; Notes: In the MPLAB X Help, refer to the MPASM Assembler documentation *
; for information on assembly instructions. *
; *
;*******************************************************************************
; *
; Known Issues: This template is designed for relocatable code. As such, *
; build errors such as "Directive only allowed when generating an object *
; file" will result when the 'Build in Absolute Mode' checkbox is selected *
; in the project properties. Designing code in absolute mode is *
; antiquated - use relocatable mode. *
; *
;*******************************************************************************
; *
; Revision History:
Started on 6/4/17 by Arman Chowdhury
Lab session 1: 15/05/17 by Arman Chowdhury and Chinmay Vaishnav
Lab session 2: 22/05/17 by Arman Chowdhury and Chinmay Vaishnav
Lab session 3: 19/05/17 by Arman Chowdhury and Chinmay Vaishnav
Final Review: 04/06/17 by Arman Chowdhury and Chinmay Vaishnav *
AUTHOR: Arman Chowdhury
CO – AUTHOR: Chinmay Vaishnav
; *
;*******************************************************************************
11
;*******************************************************************************
; Processor Inclusion
;
; TODO Step #1 Open the task list under Window > Tasks. Include your
; device .inc file - e.g. #include <device_name>.inc. Available
; include files are in C:\Program Files\Microchip\MPLABX\mpasmx
; assuming the default installation path for MPLAB X. You may manually find
; the appropriate include file for your device here and include it, or
; simply copy the include generated by the configuration bits
; generator (see Step #2).
;
;*******************************************************************************
; TODO INSERT INCLUDE CODE HERE
 ; PIC18F14K22 Configuration Bit Settings
; Assembly source line config statements
#include "p18f14k22.inc"
; CONFIG1H
 CONFIG FOSC = IRC ; Oscillator Selection bits (Internal RC oscillator)
 CONFIG PLLEN = OFF ; 4 X PLL Enable bit (PLL is under software control)
 CONFIG PCLKEN = ON ; Primary Clock Enable bit (Primary clock enabled)
 CONFIG FCMEN = OFF ; Fail-Safe Clock Monitor Enable (Fail-Safe Clock Monitor disabled)
 CONFIG IESO = OFF ; Internal/External Oscillator Switchover bit (Oscillator Switchover mode disabled)
; CONFIG2L
 CONFIG PWRTEN = OFF ; Power-up Timer Enable bit (PWRT disabled)
 CONFIG BOREN = OFF ; Brown-out Reset Enable bits (Brown-out Reset disabled in hardware and software)
 CONFIG BORV = 19 ; Brown Out Reset Voltage bits (VBOR set to 1.9 V nominal)
; CONFIG2H
12
 CONFIG WDTEN = OFF ; Watchdog Timer Enable bit (WDT is controlled by SWDTEN bit of the WDTCON register)
 CONFIG WDTPS = 32768 ; Watchdog Timer Postscale Select bits (1:32768)
; CONFIG3H
 CONFIG HFOFST = OFF ; HFINTOSC Fast Start-up bit (The system clock is held off until the HFINTOSC is stable.)
 CONFIG MCLRE = OFF ; MCLR Pin Enable bit (RA3 input pin enabled; MCLR disabled)
; CONFIG4L
 CONFIG STVREN = OFF ; Stack Full/Underflow Reset Enable bit (Stack full/underflow will not cause Reset)
 CONFIG LVP = OFF ; Single-Supply ICSP Enable bit (Single-Supply ICSP disabled)
 CONFIG BBSIZ = OFF ; Boot Block Size Select bit (1kW boot block size)
 CONFIG XINST = OFF ; Extended Instruction Set Enable bit (Instruction set extension and Indexed Addressing mode disabled
(Legacy mode))
; CONFIG5L
 CONFIG CP0 = OFF ; Code Protection bit (Block 0 not code-protected)
 CONFIG CP1 = OFF ; Code Protection bit (Block 1 not code-prot
13
 CONFIG EBTR1 = OFF ; Table Read Protection bit (Block 1 not protected from table reads executed in other blocks)
; CONFIG7H
 CONFIG EBTRB = OFF ; Boot Block Table Read Protection bit (Boot block not protected from table reads executed in other
blocks)
 RADIX DEC

;*******************************************************************************
;
; TODO Step #2 - Configuration Word Setup
;
; The 'CONFIG' directive is used to embed the configuration word within the
; .asm file. MPLAB X requires users to embed their configuration words
; into source code. See the device datasheet for additional information
; on configuration word settings. Device configuration bits descriptions
; are in C:\Program Files\Microchip\MPLABX\mpasmx\P<device_name>.inc
; (may change depending on your MPLAB X installation directory).
;
; MPLAB X has a feature which generates configuration bits source code. Go to
; Window > PIC Memory Views > Configuration Bits. Configure each field as
; needed and select 'Generate Source Code to Output'. The resulting code which
; appears in the 'Output Window' > 'Config Bits Source' tab may be copied
; below.
;
;*******************************************************************************
; TODO INSERT CONFIG HERE
;*******************************************************************************
;
; TODO Step #3 - Variable Definitions
;
; Refer to datasheet for available data memory (RAM) organization assuming
14
; relocatible code organization (which is an option in project
; properties > mpasm (Global Options)). Absolute mode generally should
; be used sparingly.
;
; Example of using GPR Uninitialized Data
;
; GPR_VAR UDATA
; MYVAR1 RES 1 ; User variable linker places
; MYVAR2 RES 1 ; User variable linker places
; MYVAR3 RES 1 ; User variable linker places
;
; ; Example of using Access Uninitialized Data Section (when available)
; ; The variables for the context saving in the device datasheet may need
; ; memory reserved here.
INT_VAR UDATA_ACS
LED_State RES 1
XOR_Leds res 1
State res 1
Triggered res 1
Current res 1
ResetFlag res 1
Timer0Set res 1
; W_TEMP RES 1 ; w register for context saving (ACCESS)
; STATUS_TEMP RES 1 ; status used for context saving
; BSR_TEMP RES 1 ; bank select used for ISR context saving
;
;*******************************************************************************
; TODO PLACE VARIABLE DEFINITIONS GO HERE
;*******************************************************************************
; Reset Vector
;*******************************************************************************
15
RES_VECT CODE 0x0000 ; processor reset vector
 GOTO START ; go to beginning of program
;*******************************************************************************
; TODO Step #4 - Interrupt Service Routines
;
; There are a few different ways to structure interrupt routines in the 8
; bit device families. On PIC18's the high priority and low priority
; interrupts are located at 0x0008 and 0x0018, respectively. On PIC16's and
; lower the interrupt is at 0x0004. Between device families there is subtle
; variation in the both the hardware supporting the ISR (for restoring
; interrupt context) as well as the software used to restore the context
; (without corrupting the STATUS bits).
;
; General formats are shown below in relocatible format.
;
;------------------------------PIC16's and below--------------------------------
;
; ISR CODE 0x0004 ; interrupt vector location
;
; <Search the device datasheet for 'context' and copy interrupt
; context saving code here. Older devices need context saving code,
; but newer devices like the 16F#### don't need context saving code.>
;
; RETFIE
;
;----------------------------------PIC18's--------------------------------------
;
ISRHV CODE 0x0008
 GOTO HIGH_ISR
ISRLV CODE 0x0018
 GOTO LOW_ISR
16
ISRH CODE ; let linker place high ISR routine
HIGH_ISR
 btfsc INTCON, RABIF
 bra Button
 btfsc PIR1, TMR1IF
 call flashLeds
 btfsc INTCON, TMR0IF
 bra Timer
; <Insert High Priority ISR Here - no SW context saving>
 RETFIE FAST
ISRL CODE ; let linker place low ISR routine
LOW_ISR
; <Search the device datasheet for 'context' and copy interrupt
; context saving code here>
 RETFIE
;
;********************************************************
17
State_4 equ 4
State_5 equ 5
;*******************************************************************************
; MAIN PROGRAM
;*******************************************************************************
MAIN_PROG CODE ; let linker place main program
START
 clrf Timer0Set
 movlw B'00011100' ; Set clock to 250kHz
 movwf OSCCON
 CLRF PIE1
 CLRF PIE2
 clrf State ; go to State_Happy
 clrf LED_State
 clrf XOR_Leds
 clrf Triggered
 clrf PORTC
 clrf TRISC ; PORTC outputs
 movlw 0xff
 movwf TRISB ; PORTB inputs
 movwf TRISA
 clrf ANSEL
 clrf ANSELH
 movlw B'11110000' ; IOCB enabled on bits 4-7
 movwf IOCB
 movlw B'00100100' ; IOCA enabled RA2 and RA5
 movwf IOCA
 movf PORTB,W
 movf PORTA,W
18
 movlw B'00010111' ; config for stage 2
 movwf T0CON
 movlw B'10110000' ; initalise Timer 1, either fast or slow flash
 movwf T1CON
 bsf PIE1, 0 ; enables TMR1 interrupt on overflow
;
 CLRF RCON
 movlw B'11101000' ; enable INT0 and IOCB interrupts [ENABLE BIT 5 FOR STAGE 2]
 movwf INTCON
 movlw B'11110101' ; IOCB is high priority (Bit 0)
 movwf INTCON2
 clrf INTCON2 ; no INT1 or INT2
 clrf INTCON3 ; no INT1 or INT2

 movlw B'00111100' ; Buzzer Initialization
 movwf CCP1CON
 movlw B'00001111'
 movwf CCPR1L
 movlw B'01111000'
 movwf T2CON
 clrf ResetFlag

; TODO Step #5 - Insert Your Program Here
mainLoop
 nop
 bra mainLoop

Button
 movf State, W
 bnz NotState0Button
State0Button
19
 movf PORTA, W
 btfsc PORTA, 5
 bra doEvac

 btfss PORTA, 2
 setf ResetFlag
 btfss PORTA, 2
 bra Full_Reset

 btfsc ResetFlag, 1
 bra marker0

 swapf PORTB,W
 movwf Triggered
 iorwf LED_State
 movlw State_1
 movwf State
 call Set_Time_3Sec
 bsf LED_State, 7
 call displayLeds
marker0
 btfsc ResetFlag, 1
 clrf ResetFlag
 bcf INTCON, RABIF
 RETFIE FAST
NotState0Button ;Check for State_1
 movf State, W
 xorlw State_1
 btfss STATUS, 2
 bra NotState1Button
 bra State1Button
20
State1Button
 movf PORTA, W
 btfsc PORTA, 5
 bra doEvac

 btfss PORTA, 2
 setf ResetFlag
 btfss PORTA, 2
 bra Full_Reset

 btfsc ResetFlag, 1
 bra marker1
 bcf INTCON, RABIF

 swapf PORTB, W
 movwf Current

 comf Triggered, W
 andwf Current, W
 btfsc STATUS, 2
 RETFIE FAST

 swapf PORTB, W
 iorwf Triggered
 iorwf LED_State
 movlw State_2
 movwf State
 call interrupt_3Sec
 call Set_Time_3Sec
 call Slow_Flash
 bcf INTCON, RABIF
 bsf LED_State, 7
 call displayLeds
21
marker1
 btfsc ResetFlag, 1
 clrf ResetFlag
 RETFIE FAST
NotState1Button
 movf State, W
 xorlw State_2
 btfss STATUS, 2
 bra NotState2Button
 bra State2Button

State2Button
 movf PORTA, W
 btfsc PORTA, 5
 bra doEvac
 btfss PORTA, 2
 bra Semi_Reset
 bcf INTCON, RABIF

 swapf PORTB, W
 movwf Current

 comf Triggered, W
 andwf Current, W
 btfsc STATUS, 2
 RETFIE FAST

 swapf PORTB, W
 iorwf Triggered
 movwf Triggered
 iorwf LED_State
 movlw State_3
22
 movwf State
 bsf LED_State, 7
 bra doEvac
 RETFIE FAST

NotState2Button
 movf State, W
 xorlw State_3
 btfss STATUS, 2
 bra NotState3Button
 bra State3Button
State3Button
 movf PORTA, W
 btfss PORTA, 2
 bra Semi_Reset
 bcf INTCON, RABIF



 swapf PORTB, W
 movwf Current

 comf Triggered, W
 andwf Current, W
 btfsc STATUS, 2
 RETFIE FAST

 swapf PORTB, W
 iorwf Triggered
 movwf Triggered
 iorwf LED_State
 movlw State_3
23
 movwf State
 bsf LED_State, 7
 RETFIE FAST
NotState3Button
 movf State, W
 xorlw State_4
 btfss STATUS, 2
 bra NotState4Button
 bra State4Button

State4Button
 btfss Timer0Set, 1
 call Set_Time_3Sec
 btfss Timer0Set, 1
 setf Timer0Set

 movf PORTA, W
 btfsc PORTA, 5
 bra doEvac
 btfss PORTA, 2
 bra Semi_Reset
 bcf INTCON, RABIF
 movlw State_4
 movwf State
 call displayLeds
 RETFIE FAST
NotState4Button
 movf State, W
 xorlw State_5
 btfss STATUS, 2
 bra NotState5Button
24
 bra State5Button

State5Button
 call displayLeds

 movf PORTA, W
 btfsc PORTA, 5
 bra doEvac
 btfss PORTA, 2
 setf ResetFlag
 btfss PORTA, 2
 bra Full_Reset

 btfsc ResetFlag, 1
 bra marker5

marker5
 btfsc ResetFlag, 1
 clrf ResetFlag
 bcf INTCON, RABIF
 RETFIE FAST

NotState5Button
 movf PORTA,W
 swapf PORTB,W
 bcf INTCON, RABIF
 RETFIE FAST

Timer
 movf State, W
 xorlw State_1
 btfss STATUS, 2
 bra NotState1Timer
25
 bra State1Timer

State1Timer
 bcf INTCON, TMR0IF

 swapf PORTB, W
 iorlw 0x00
 btfss STATUS, 2
 bra Evacuate
 bra FalseAlarm
FalseAlarm
 movlw State_0
 movwf State
 call Stop_Flash
 clrf Triggered
 clrf Current
 clrf LED_State
 clrf XOR_Leds
 call displayLeds
 movlw B'00110000' ; Turns PWM module off.
 movwf CCP1CON ; So, Buzzer is off.
 bcf T2CON, 2
 RETFIE FAST
Evacuate
 movlw State_2
 movwf State
 swapf PORTB, W
 iorwf Triggered
 movwf Triggered
 iorwf LED_State
 call interrupt_3Sec
 call Set_Time_3Sec
 call Slow_Flash
26
 bcf INTCON, RABIF
 bsf LED_State, 7
 call displayLeds
 RETFIE FAST

NotState1Timer
 movf State, W
 xorlw State_2
 btfss STATUS, 2
 bra NotState2Timer
 bra State2Timer

State2Timer
 bcf INTCON, TMR0IF

 swapf PORTB, W
 iorlw 0x00
 btfss STATUS, 2
 bra doEvac
 bra StayHere
StayHere
 RETFIE FAST
NotState2Timer
 movf State, W
 xorlw State_4
 btfss STATUS, 2
 bra NotState4Timer
 bra State4Timer
State4Timer
 clrf Timer0Set
 bcf INTCON, TMR0IF
27
 movlw State_5
 movwf State
 call interrupt_3Sec
 RETFIE FAST
NotState4Timer
 movf PORTA, W
 swapf PORTB, W
 bcf INTCON, TMR0IF
 RETFIE FAST

Semi_Reset
 movlw State_4
 movwf State
 bcf INTCON, RABIF
 ;call interrupt_3Sec
 call Stop_Flash
 clrf Current
 clrf XOR_Leds
 movf Triggered, W
 iorwf LED_State
 bsf LED_State, 7
 call displayLeds
 movlw B'00110000' ; Turns PWM module off.
 movwf CCP1CON ; So, Buzzer is off.
 bcf T2CON, 2
 RETFIE FAST


Full_Reset
 bcf INTCON, RABIF
 call Stop_Flash
28
 clrf State
 clrf Triggered
 clrf Current
 clrf LED_State
 clrf XOR_Leds
 call displayLeds
 movlw B'00110000' ; Turns PWM module off.
 movwf CCP1CON ; So, Buzzer is off.
 bcf T2CON, 2
 RETFIE FAST
doEvac
 call interrupt_3Sec
 movlw State_Evac
 movwf State
 movlw 0x80
 iorwf LED_State
 bcf INTCON, RABIF
 call Fast_Flash
 call displayLeds
 RETFIE FAST
flashLeds
 bcf PIR1,TMR1IF
 movlw State_Warn
 cpfseq State
 bra NotStateWarn ; if (state == State_Warn) {
flash_State_Warn
 call Slow_Flash ; Slow_Flash();
 bra flashCommon ; } else {
NotStateWarn
 call Fast_Flash ; Fast_Flash();
 ; }
29
flashCommon ; both fast and slow flashing reach this point to invert and display the actual leds
 comf XOR_Leds
 call displayLeds
 return

interrupt_3Sec
 bcf INTCON,TMR0IF
 call Stop_Time_3Sec
 return

displayLeds
 movf LED_State, W
 xorwf XOR_Leds, W
 movwf PORTC
 return
Set_Buzzer_HighPitch
 movlw B'10000000'
 movwf PR2
 return

Set_Buzzer_LowPitch
 movlw B'11111110'
 movwf PR2
 return

Fast_Flash
 bcf PIR1,TMR1IF
 movlw 0xf8
 movwf TMR1H
 movlw 0x5f
 movwf TMR1L
 bsf T1CON, 0 ; turn timer on
30
 movlw B'00111100' ; PWM module enabled for Buzzer
 movwf CCP1CON
 call Set_Buzzer_HighPitch ; Sets High Pitch
 bsf T2CON, 2 ; Toggle Buzzer
 movf XOR_Leds
 btfsc STATUS, 2
 bcf T2CON, 2
 return
Slow_Flash
 bcf PIR1,TMR1IF
 movlw 0xf0
 movwf TMR1H
 movlw 0xbd
 movwf TMR1L
 bsf T1CON, 0 ; turn timer on
 movlw B'00111100' ; PWM module enabled for Buzzer
 movwf CCP1CON
 call Set_Buzzer_LowPitch ; Sets Low Pitch
 bsf T2CON, 2 ; Toggle Buzzer
 movf XOR_Leds
 btfsc STATUS, 2
 bcf T2CON, 2
 return

Stop_Flash
 bcf T1CON, 0
 bcf PIR1,TMR1IF
 return
Set_Time_3Sec
 movlw 0xfd
 movwf TMR0H
31
 movlw 0x24
 movwf TMR0L
 bsf T0CON,TMR0ON
 return

Stop_Time_3Sec
 call Stop_Flash
 bcf T0CON,TMR0ON
 ;clrf LED_State
 ;clrf XOR_Leds
 call displayLeds
 return

 END