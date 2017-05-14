opt subtitle "Microchip Technology Omniscient Code Generator v1.37 (Free mode) build 201603110536"

opt pagewidth 120

	opt lm

	processor	16F636
clrc	macro
	bcf	3,0
	endm
clrz	macro
	bcf	3,2
	endm
setc	macro
	bsf	3,0
	endm
setz	macro
	bsf	3,2
	endm
skipc	macro
	btfss	3,0
	endm
skipz	macro
	btfss	3,2
	endm
skipnc	macro
	btfsc	3,0
	endm
skipnz	macro
	btfsc	3,2
	endm
indf	equ	0
indf0	equ	0
pc	equ	2
pcl	equ	2
status	equ	3
fsr	equ	4
fsr0	equ	4
c	equ	1
z	equ	0
pclath	equ	10
# 51 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
INDF equ 00h ;# 
# 57 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
TMR0 equ 01h ;# 
# 63 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
PCL equ 02h ;# 
# 69 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
STATUS equ 03h ;# 
# 156 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
FSR equ 04h ;# 
# 162 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
PORTA equ 05h ;# 
# 211 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
PORTC equ 07h ;# 
# 260 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
PCLATH equ 0Ah ;# 
# 279 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
INTCON equ 0Bh ;# 
# 340 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
PIR1 equ 0Ch ;# 
# 396 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
TMR1 equ 0Eh ;# 
# 402 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
TMR1L equ 0Eh ;# 
# 408 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
TMR1H equ 0Fh ;# 
# 414 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
T1CON equ 010h ;# 
# 484 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
WDTCON equ 018h ;# 
# 536 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
CMCON0 equ 019h ;# 
# 605 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
CMCON1 equ 01Ah ;# 
# 630 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
OPTION_REG equ 081h ;# 
# 699 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
TRISA equ 085h ;# 
# 748 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
TRISC equ 087h ;# 
# 797 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
PIE1 equ 08Ch ;# 
# 853 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
PCON equ 08Eh ;# 
# 912 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
OSCCON equ 08Fh ;# 
# 976 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
OSCTUNE equ 090h ;# 
# 1027 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
LVDCON equ 094h ;# 
# 1079 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
WPUDA equ 095h ;# 
# 1123 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
IOCA equ 096h ;# 
# 1172 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
WDA equ 097h ;# 
# 1216 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
VRCON equ 099h ;# 
# 1275 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
EEDAT equ 09Ah ;# 
# 1280 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
EEDATA equ 09Ah ;# 
# 1328 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
EEADR equ 09Bh ;# 
# 1334 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
EECON1 equ 09Ch ;# 
# 1371 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
EECON2 equ 09Dh ;# 
# 1377 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
CRCON equ 0110h ;# 
# 1436 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
CRDAT0 equ 0111h ;# 
# 1455 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
CRDAT1 equ 0112h ;# 
# 1474 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
CRDAT2 equ 0113h ;# 
# 1493 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
CRDAT3 equ 0114h ;# 
# 51 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
INDF equ 00h ;# 
# 57 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
TMR0 equ 01h ;# 
# 63 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
PCL equ 02h ;# 
# 69 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
STATUS equ 03h ;# 
# 156 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
FSR equ 04h ;# 
# 162 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
PORTA equ 05h ;# 
# 211 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
PORTC equ 07h ;# 
# 260 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
PCLATH equ 0Ah ;# 
# 279 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
INTCON equ 0Bh ;# 
# 340 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
PIR1 equ 0Ch ;# 
# 396 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
TMR1 equ 0Eh ;# 
# 402 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
TMR1L equ 0Eh ;# 
# 408 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
TMR1H equ 0Fh ;# 
# 414 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
T1CON equ 010h ;# 
# 484 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
WDTCON equ 018h ;# 
# 536 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
CMCON0 equ 019h ;# 
# 605 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
CMCON1 equ 01Ah ;# 
# 630 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
OPTION_REG equ 081h ;# 
# 699 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
TRISA equ 085h ;# 
# 748 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
TRISC equ 087h ;# 
# 797 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
PIE1 equ 08Ch ;# 
# 853 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
PCON equ 08Eh ;# 
# 912 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
OSCCON equ 08Fh ;# 
# 976 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
OSCTUNE equ 090h ;# 
# 1027 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
LVDCON equ 094h ;# 
# 1079 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
WPUDA equ 095h ;# 
# 1123 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
IOCA equ 096h ;# 
# 1172 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
WDA equ 097h ;# 
# 1216 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
VRCON equ 099h ;# 
# 1275 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
EEDAT equ 09Ah ;# 
# 1280 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
EEDATA equ 09Ah ;# 
# 1328 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
EEADR equ 09Bh ;# 
# 1334 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
EECON1 equ 09Ch ;# 
# 1371 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
EECON2 equ 09Dh ;# 
# 1377 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
CRCON equ 0110h ;# 
# 1436 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
CRDAT0 equ 0111h ;# 
# 1455 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
CRDAT1 equ 0112h ;# 
# 1474 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
CRDAT2 equ 0113h ;# 
# 1493 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
CRDAT3 equ 0114h ;# 
# 51 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
INDF equ 00h ;# 
# 57 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
TMR0 equ 01h ;# 
# 63 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
PCL equ 02h ;# 
# 69 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
STATUS equ 03h ;# 
# 156 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
FSR equ 04h ;# 
# 162 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
PORTA equ 05h ;# 
# 211 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
PORTC equ 07h ;# 
# 260 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
PCLATH equ 0Ah ;# 
# 279 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
INTCON equ 0Bh ;# 
# 340 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
PIR1 equ 0Ch ;# 
# 396 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
TMR1 equ 0Eh ;# 
# 402 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
TMR1L equ 0Eh ;# 
# 408 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
TMR1H equ 0Fh ;# 
# 414 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
T1CON equ 010h ;# 
# 484 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
WDTCON equ 018h ;# 
# 536 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
CMCON0 equ 019h ;# 
# 605 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
CMCON1 equ 01Ah ;# 
# 630 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
OPTION_REG equ 081h ;# 
# 699 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
TRISA equ 085h ;# 
# 748 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
TRISC equ 087h ;# 
# 797 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
PIE1 equ 08Ch ;# 
# 853 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
PCON equ 08Eh ;# 
# 912 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
OSCCON equ 08Fh ;# 
# 976 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
OSCTUNE equ 090h ;# 
# 1027 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
LVDCON equ 094h ;# 
# 1079 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
WPUDA equ 095h ;# 
# 1123 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
IOCA equ 096h ;# 
# 1172 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
WDA equ 097h ;# 
# 1216 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
VRCON equ 099h ;# 
# 1275 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
EEDAT equ 09Ah ;# 
# 1280 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
EEDATA equ 09Ah ;# 
# 1328 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
EEADR equ 09Bh ;# 
# 1334 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
EECON1 equ 09Ch ;# 
# 1371 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
EECON2 equ 09Dh ;# 
# 1377 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
CRCON equ 0110h ;# 
# 1436 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
CRDAT0 equ 0111h ;# 
# 1455 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
CRDAT1 equ 0112h ;# 
# 1474 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
CRDAT2 equ 0113h ;# 
# 1493 "/Applications/Microchip/xc8/v1.37/include/pic16f636.h"
CRDAT3 equ 0114h ;# 
	FNCALL	_main,_OLED_spi_sendchar
	FNCALL	_main,_clearScreen
	FNCALL	_main,_getbyte
	FNCALL	_main,_init
	FNCALL	_main,_init_OLED
	FNCALL	_main,_send_char
	FNCALL	_main,_send_nl
	FNCALL	_main,_setPixelAddrTo0
	FNCALL	_main,_wait_ms
	FNCALL	_setPixelAddrTo0,_setPixelAddr
	FNCALL	_setPixelAddr,_OLED_spi_sendchar
	FNCALL	_init_OLED,_OLED_spi_sendchar
	FNCALL	_init_OLED,_send_char
	FNCALL	_init_OLED,_send_nl
	FNCALL	_init_OLED,_wait_ms
	FNCALL	_init_OLED,_wait_us
	FNCALL	_wait_ms,_wait_us
	FNCALL	_init,_send_char
	FNCALL	_init,_send_nl
	FNCALL	_send_nl,_send_char
	FNCALL	_getbyte,_gethex
	FNCALL	_gethex,_recv_char
	FNCALL	_clearScreen,_OLED_spi_sendchar
	FNROOT	_main
	FNCALL	intlevel1,_IT
	global	intlevel1
	FNROOT	intlevel1
	global	_Disp_idx
	global	_sys_cnt
	global	_tmpg
	global	_Display
	global	_last_R7_resp
	global	OLED_up_header@FSPI_FILE
psect	text0,local,class=CODE,delta=2,merge=1
global __ptext0
__ptext0:
	DABS	1,195,1,OLED_up_header@FSPI_FILE

	global	OLED_up_header@FSPI_FILE
	DABS	1,195,1,OLED_up_header@FSPI_FILE

	global	OLED_up_header@FSPI_STATUS
	DABS	1,195,1,OLED_up_header@FSPI_STATUS

	global	OLED_up_header@FSPI_STATUS
	DABS	1,195,1,OLED_up_header@FSPI_STATUS

	global	OLED_up_header@NEX4_PMOD_B
	DABS	1,192,1,OLED_up_header@NEX4_PMOD_B

	global	OLED_up_header@NEX4_PMOD_B
	DABS	1,192,1,OLED_up_header@NEX4_PMOD_B

	global	_FSPI_FILE
	DABS	1,195,1,_FSPI_FILE

	global	_FSPI_STATUS
	DABS	1,195,1,_FSPI_STATUS

	global	_NEX4_PMOD_B
	DABS	1,192,1,_NEX4_PMOD_B

	global	OLED_up_header@OLED_DC
	DABS	1,1540,0,OLED_up_header@OLED_DC
	DABS	1,192,1	;OLED_up_header@OLED_DC

	global	OLED_up_header@OLED_DC
	DABS	1,1540,0,OLED_up_header@OLED_DC
	DABS	1,192,1	;OLED_up_header@OLED_DC

	global	OLED_up_header@OLED_RES
	DABS	1,1541,0,OLED_up_header@OLED_RES
	DABS	1,192,1	;OLED_up_header@OLED_RES

	global	OLED_up_header@OLED_RES
	DABS	1,1541,0,OLED_up_header@OLED_RES
	DABS	1,192,1	;OLED_up_header@OLED_RES

	global	OLED_up_header@OLED_VBATC
	DABS	1,1542,0,OLED_up_header@OLED_VBATC
	DABS	1,192,1	;OLED_up_header@OLED_VBATC

	global	OLED_up_header@OLED_VBATC
	DABS	1,1542,0,OLED_up_header@OLED_VBATC
	DABS	1,192,1	;OLED_up_header@OLED_VBATC

	global	OLED_up_header@OLED_VDDC
	DABS	1,1543,0,OLED_up_header@OLED_VDDC
	DABS	1,192,1	;OLED_up_header@OLED_VDDC

	global	OLED_up_header@OLED_VDDC
	DABS	1,1543,0,OLED_up_header@OLED_VDDC
	DABS	1,192,1	;OLED_up_header@OLED_VDDC

	global	_OLED_DC
	DABS	1,1540,0,_OLED_DC
	DABS	1,192,1	;_OLED_DC

	global	_OLED_RES
	DABS	1,1541,0,_OLED_RES
	DABS	1,192,1	;_OLED_RES

	global	_OLED_VBATC
	DABS	1,1542,0,_OLED_VBATC
	DABS	1,192,1	;_OLED_VBATC

	global	_OLED_VDDC
	DABS	1,1543,0,_OLED_VDDC
	DABS	1,192,1	;_OLED_VDDC

	global	OLED_up_header@NEX4_7SEG_SEL
OLED_up_header@NEX4_7SEG_SEL	set	25
	global	OLED_up_header@OLED_SPI_FILE
OLED_up_header@OLED_SPI_FILE	set	23
	global	OLED_up_header@OLED_SPI_STATUS
OLED_up_header@OLED_SPI_STATUS	set	22
	global	OLED_up_header@UART_RXR
OLED_up_header@UART_RXR	set	17
	global	OLED_up_header@UART_TXR
OLED_up_header@UART_TXR	set	17
	global	_INTCON
_INTCON	set	0xB
	global	_NEX4_7SEG_SEL
_NEX4_7SEG_SEL	set	25
	global	_NEX4_7SEG_VAL
_NEX4_7SEG_VAL	set	24
	global	_UART_RXR
_UART_RXR	set	17
	global	OLED_up_header@NEX4_RGBL0_RED
OLED_up_header@NEX4_RGBL0_RED	set	98
	global	OLED_up_header@NEX4_RGBL1_RED
OLED_up_header@NEX4_RGBL1_RED	set	101
	global	OLED_up_header@OLED_SPI_BSY
OLED_up_header@OLED_SPI_BSY	set	176
	global	OLED_up_header@UART_RXRDY
OLED_up_header@UART_RXRDY	set	128
	global	OLED_up_header@UART_TXBSY
OLED_up_header@UART_TXBSY	set	129
	global	_GIE
_GIE	set	0x5F
	global	_RAM_MODE
_RAM_MODE	set	104
	global	_T0IE
_T0IE	set	0x5D
	global	_T0IF
_T0IF	set	0x5A
	global	_UART_RXRDY
_UART_RXRDY	set	128
	global	_OPTION_REG
_OPTION_REG	set	0x81
; #config settings
	file	"main.as"
	line	#
psect cinit,class=CODE,delta=2
global start_initialization
start_initialization:

global __initialization
__initialization:
psect	bssCOMMON,class=COMMON,space=1,noexec
global __pbssCOMMON
__pbssCOMMON:
_Disp_idx:
       ds      1

_sys_cnt:
       ds      1

_tmpg:
       ds      1

psect	bssBANK0,class=BANK0,space=1,noexec
global __pbssBANK0
__pbssBANK0:
_Display:
       ds      8

_last_R7_resp:
       ds      4

	file	"main.as"
	line	#
psect clrtext,class=CODE,delta=2
global clear_ram0
;	Called with FSR containing the base address, and
;	W with the last address+1
clear_ram0:
	clrwdt			;clear the watchdog before getting into this loop
clrloop0:
	clrf	indf		;clear RAM location pointed to by FSR
	incf	fsr,f		;increment pointer
	xorwf	fsr,w		;XOR with final address
	btfsc	status,2	;have we reached the end yet?
	retlw	0		;all done for this memory range, return
	xorwf	fsr,w		;XOR again to restore value
	goto	clrloop0		;do the next byte

; Clear objects allocated to COMMON
psect cinit,class=CODE,delta=2,merge=1
	clrf	((__pbssCOMMON)+0)&07Fh
	clrf	((__pbssCOMMON)+1)&07Fh
	clrf	((__pbssCOMMON)+2)&07Fh
; Clear objects allocated to BANK0
psect cinit,class=CODE,delta=2,merge=1
	bcf	status, 7	;select IRP bank0
	movlw	low(__pbssBANK0)
	movwf	fsr
	movlw	low((__pbssBANK0)+0Ch)
	fcall	clear_ram0
psect cinit,class=CODE,delta=2,merge=1
global end_of_initialization,__end_of__initialization

;End of C runtime variable initialization code

end_of_initialization:
__end_of__initialization:
clrf status
ljmp _main	;jump to C main() function
psect	cstackCOMMON,class=COMMON,space=1,noexec
global __pcstackCOMMON
__pcstackCOMMON:
?_init:	; 1 bytes @ 0x0
?_init_OLED:	; 1 bytes @ 0x0
?_clearScreen:	; 1 bytes @ 0x0
?_setPixelAddrTo0:	; 1 bytes @ 0x0
?_send_char:	; 1 bytes @ 0x0
?_send_nl:	; 1 bytes @ 0x0
?_getbyte:	; 1 bytes @ 0x0
?_OLED_spi_sendchar:	; 1 bytes @ 0x0
?_IT:	; 1 bytes @ 0x0
??_IT:	; 1 bytes @ 0x0
?_recv_char:	; 1 bytes @ 0x0
?_gethex:	; 1 bytes @ 0x0
?_main:	; 2 bytes @ 0x0
	ds	5
??_wait_ms:	; 1 bytes @ 0x5
??_send_char:	; 1 bytes @ 0x5
??_OLED_spi_sendchar:	; 1 bytes @ 0x5
??_recv_char:	; 1 bytes @ 0x5
??_gethex:	; 1 bytes @ 0x5
??_wait_us:	; 1 bytes @ 0x5
	global	send_char@c
send_char@c:	; 1 bytes @ 0x5
	global	OLED_spi_sendchar@c
OLED_spi_sendchar@c:	; 1 bytes @ 0x5
	ds	1
??_init_OLED:	; 1 bytes @ 0x6
??_clearScreen:	; 1 bytes @ 0x6
??_setPixelAddrTo0:	; 1 bytes @ 0x6
??_send_nl:	; 1 bytes @ 0x6
??_setPixelAddr:	; 1 bytes @ 0x6
psect	cstackBANK0,class=BANK0,space=1,noexec
global __pcstackBANK0
__pcstackBANK0:
??_init:	; 1 bytes @ 0x0
??_getbyte:	; 1 bytes @ 0x0
?_wait_us:	; 1 bytes @ 0x0
?_setPixelAddr:	; 1 bytes @ 0x0
	global	setPixelAddr@row
setPixelAddr@row:	; 1 bytes @ 0x0
	global	wait_us@i
wait_us@i:	; 2 bytes @ 0x0
	ds	1
	global	getbyte@tmp
getbyte@tmp:	; 1 bytes @ 0x1
	global	setPixelAddr@col
setPixelAddr@col:	; 1 bytes @ 0x1
	ds	1
	global	wait_us@t
wait_us@t:	; 2 bytes @ 0x2
	ds	2
?_wait_ms:	; 1 bytes @ 0x4
	global	wait_ms@i
wait_ms@i:	; 2 bytes @ 0x4
	ds	2
	global	wait_ms@t
wait_ms@t:	; 2 bytes @ 0x6
	ds	2
??_main:	; 1 bytes @ 0x8
	ds	1
	global	main@a
main@a:	; 1 bytes @ 0x9
	ds	1
	global	main@i
main@i:	; 2 bytes @ 0xA
	ds	2
	global	main@command
main@command:	; 1 bytes @ 0xC
	ds	1
;!
;!Data Sizes:
;!    Strings     0
;!    Constant    0
;!    Data        0
;!    BSS         15
;!    Persistent  0
;!    Stack       0
;!
;!Auto Spaces:
;!    Space          Size  Autos    Used
;!    COMMON           14      6       9
;!    BANK0            80     13      25
;!    BANK1            32      0       0

;!
;!Pointer List with Targets:
;!
;!    None.


;!
;!Critical Paths under _main in COMMON
;!
;!    _main->_OLED_spi_sendchar
;!    _main->_send_char
;!    _setPixelAddr->_OLED_spi_sendchar
;!    _init_OLED->_OLED_spi_sendchar
;!    _init_OLED->_send_char
;!    _init->_send_char
;!    _send_nl->_send_char
;!    _getbyte->_gethex
;!    _clearScreen->_OLED_spi_sendchar
;!
;!Critical Paths under _IT in COMMON
;!
;!    None.
;!
;!Critical Paths under _main in BANK0
;!
;!    _main->_wait_ms
;!    _setPixelAddrTo0->_setPixelAddr
;!    _init_OLED->_wait_ms
;!    _wait_ms->_wait_us
;!
;!Critical Paths under _IT in BANK0
;!
;!    None.
;!
;!Critical Paths under _main in BANK1
;!
;!    None.
;!
;!Critical Paths under _IT in BANK1
;!
;!    None.

;;
;;Main: autosize = 0, tempsize = 1, incstack = 0, save=0
;;

;!
;!Call Graph Tables:
;!
;! ---------------------------------------------------------------------------------
;! (Depth) Function   	        Calls       Base Space   Used Autos Params    Refs
;! ---------------------------------------------------------------------------------
;! (0) _main                                                 5     5      0    2357
;!                                              8 BANK0      5     5      0
;!                  _OLED_spi_sendchar
;!                        _clearScreen
;!                            _getbyte
;!                               _init
;!                          _init_OLED
;!                          _send_char
;!                            _send_nl
;!                    _setPixelAddrTo0
;!                            _wait_ms
;! ---------------------------------------------------------------------------------
;! (1) _setPixelAddrTo0                                      0     0      0     158
;!                       _setPixelAddr
;! ---------------------------------------------------------------------------------
;! (2) _setPixelAddr                                         2     1      1     158
;!                                              0 BANK0      2     1      1
;!                  _OLED_spi_sendchar
;! ---------------------------------------------------------------------------------
;! (1) _init_OLED                                            0     0      0    1059
;!                  _OLED_spi_sendchar
;!                          _send_char
;!                            _send_nl
;!                            _wait_ms
;!                            _wait_us
;! ---------------------------------------------------------------------------------
;! (1) _wait_ms                                              4     2      2     721
;!                                              4 BANK0      4     2      2
;!                            _wait_us
;! ---------------------------------------------------------------------------------
;! (2) _wait_us                                              4     2      2     263
;!                                              0 BANK0      4     2      2
;! ---------------------------------------------------------------------------------
;! (1) _init                                                 1     1      0      44
;!                                              0 BANK0      1     1      0
;!                          _send_char
;!                            _send_nl
;! ---------------------------------------------------------------------------------
;! (1) _send_nl                                              0     0      0      22
;!                          _send_char
;! ---------------------------------------------------------------------------------
;! (2) _send_char                                            1     1      0      22
;!                                              5 COMMON     1     1      0
;! ---------------------------------------------------------------------------------
;! (1) _getbyte                                              2     2      0      37
;!                                              0 BANK0      2     2      0
;!                             _gethex
;! ---------------------------------------------------------------------------------
;! (2) _gethex                                               1     1      0       0
;!                                              5 COMMON     1     1      0
;!                          _recv_char
;! ---------------------------------------------------------------------------------
;! (3) _recv_char                                            0     0      0       0
;! ---------------------------------------------------------------------------------
;! (1) _clearScreen                                          0     0      0      31
;!                  _OLED_spi_sendchar
;! ---------------------------------------------------------------------------------
;! (3) _OLED_spi_sendchar                                    1     1      0      31
;!                                              5 COMMON     1     1      0
;! ---------------------------------------------------------------------------------
;! Estimated maximum stack depth 3
;! ---------------------------------------------------------------------------------
;! (Depth) Function   	        Calls       Base Space   Used Autos Params    Refs
;! ---------------------------------------------------------------------------------
;! (4) _IT                                                   5     5      0       0
;!                                              0 COMMON     5     5      0
;! ---------------------------------------------------------------------------------
;! Estimated maximum stack depth 4
;! ---------------------------------------------------------------------------------
;!
;! Call Graph Graphs:
;!
;! _main (ROOT)
;!   _OLED_spi_sendchar
;!   _clearScreen
;!     _OLED_spi_sendchar
;!   _getbyte
;!     _gethex
;!       _recv_char
;!   _init
;!     _send_char
;!     _send_nl
;!       _send_char
;!   _init_OLED
;!     _OLED_spi_sendchar
;!     _send_char
;!     _send_nl
;!       _send_char
;!     _wait_ms
;!       _wait_us
;!     _wait_us
;!   _send_char
;!   _send_nl
;!     _send_char
;!   _setPixelAddrTo0
;!     _setPixelAddr
;!       _OLED_spi_sendchar
;!   _wait_ms
;!     _wait_us
;!
;! _IT (ROOT)
;!

;! Address spaces:

;!Name               Size   Autos  Total    Cost      Usage
;!BITCOMMON            E      0       0       0        0.0%
;!EEDATA             100      0       0       0        0.0%
;!NULL                 0      0       0       0        0.0%
;!CODE                 0      0       0       0        0.0%
;!COMMON               E      6       9       1       64.3%
;!BITSFR0              0      0       0       1        0.0%
;!SFR0                 0      0       0       1        0.0%
;!BITSFR1              0      0       0       2        0.0%
;!SFR1                 0      0       0       2        0.0%
;!STACK                0      0       0       2        0.0%
;!BITBANK0            50      0       0       3        0.0%
;!BANK0               50      D      19       4       31.2%
;!BITSFR3              0      0       0       4        0.0%
;!SFR3                 0      0       0       4        0.0%
;!BITBANK1            20      0       0       5        0.0%
;!BITSFR2              0      0       0       5        0.0%
;!SFR2                 0      0       0       5        0.0%
;!BANK1               20      0       0       6        0.0%
;!ABS                  0      0      22       7        0.0%
;!DATA                 0      0      22       8        0.0%

	global	_main

;; *************** function _main *****************
;; Defined at:
;;		line 24 in file "SOFTWARE/Sources/main.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;  i               2   10[BANK0 ] int 
;;  command         1   12[BANK0 ] unsigned char 
;;  a               1    9[BANK0 ] unsigned char 
;; Return value:  Size  Location     Type
;;                  2  209[None  ] int 
;; Registers used:
;;		wreg, status,2, status,0, btemp+1, pclath, cstack
;; Tracked objects:
;;		On entry : B00/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1
;;      Params:         0       0       0
;;      Locals:         0       4       0
;;      Temps:          0       1       0
;;      Totals:         0       5       0
;;Total ram usage:        5 bytes
;; Hardware stack levels required when called:    4
;; This function calls:
;;		_OLED_spi_sendchar
;;		_clearScreen
;;		_getbyte
;;		_init
;;		_init_OLED
;;		_send_char
;;		_send_nl
;;		_setPixelAddrTo0
;;		_wait_ms
;; This function is called by:
;;		Startup code after reset
;; This function uses a non-reentrant model
;;
psect	maintext,global,class=CODE,delta=2,split=1
	file	"SOFTWARE/Sources/main.c"
	line	24
global __pmaintext
__pmaintext:	;psect for function _main
psect	maintext
	file	"SOFTWARE/Sources/main.c"
	line	24
	global	__size_of_main
	__size_of_main	equ	__end_of_main-_main
	
_main:	
;incstack = 0
	opt	stack 4
; Regs used in _main: [wreg+status,2+status,0+btemp+1+pclath+cstack]
	line	28
	
l1914:	
	fcall	_init
	line	29
	fcall	_init_OLED
	line	31
	fcall	_clearScreen
	line	32
	movlw	032h
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(wait_ms@i)
	movlw	0
	movwf	((wait_ms@i))+1
	fcall	_wait_ms
	line	33
	fcall	_setPixelAddrTo0
	goto	l1916
	line	43
	
l210:	
	line	45
	
l1916:	
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	clrf	(main@command)
	line	46
	
l1918:	
	btfss	(128/8),(128)&7	;volatile
	goto	u631
	goto	u630
u631:
	goto	l1922
u630:
	
l1920:	
	movf	(17),w	;volatile
	movwf	(??_main+0)+0
	movf	(??_main+0)+0,w
	movwf	(main@command)
	goto	l1922
	
l211:	
	line	48
	
l1922:	
		movlw	82
	xorwf	((main@command)),w
	btfss	status,2
	goto	u641
	goto	u640
u641:
	goto	l1930
u640:
	line	52
	
l1924:	
	movlw	low(0BFh)
	movwf	(24)	;volatile
	line	53
	
l1926:	
	clrf	(25)	;volatile
	line	54
	
l1928:	
	bcf	(104/8),(104)&7	;volatile
	goto	l1930
	line	55
	
l212:	
	line	56
	
l1930:	
		movlw	73
	xorwf	((main@command)),w
	btfss	status,2
	goto	u651
	goto	u650
u651:
	goto	l1952
u650:
	line	59
	
l1932:	
	fcall	_clearScreen
	line	61
	movlw	low(053h)
	fcall	_send_char
	line	62
	movlw	low(065h)
	fcall	_send_char
	line	63
	movlw	low(06Eh)
	fcall	_send_char
	line	64
	movlw	low(064h)
	fcall	_send_char
	line	65
	movlw	low(020h)
	fcall	_send_char
	line	66
	movlw	low(062h)
	fcall	_send_char
	line	67
	movlw	low(069h)
	fcall	_send_char
	line	68
	movlw	low(074h)
	fcall	_send_char
	line	69
	movlw	low(06Dh)
	fcall	_send_char
	line	70
	movlw	low(061h)
	fcall	_send_char
	line	71
	movlw	low(070h)
	fcall	_send_char
	line	72
	movlw	low(020h)
	fcall	_send_char
	line	73
	movlw	low(054h)
	fcall	_send_char
	line	74
	movlw	low(065h)
	fcall	_send_char
	line	75
	movlw	low(078h)
	fcall	_send_char
	line	76
	movlw	low(074h)
	fcall	_send_char
	line	77
	movlw	low(066h)
	fcall	_send_char
	line	78
	movlw	low(069h)
	fcall	_send_char
	line	79
	movlw	low(06Ch)
	fcall	_send_char
	line	80
	movlw	low(065h)
	fcall	_send_char
	line	81
	fcall	_send_nl
	line	83
	
l1934:	
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	bsf	(1540/8)^080h,(1540)&7	;volatile
	line	84
	
l1936:	
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	clrf	(main@i)
	clrf	(main@i+1)
	
l1938:	
	movf	(main@i+1),w
	xorlw	80h
	movwf	btemp+1
	movlw	(030h)^80h
	subwf	btemp+1,w
	skipz
	goto	u665
	movlw	0
	subwf	(main@i),w
u665:

	skipc
	goto	u661
	goto	u660
u661:
	goto	l1942
u660:
	goto	l215
	
l1940:	
	goto	l215
	line	86
	
l214:	
	line	87
	
l1942:	
	fcall	_getbyte
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_main+0)+0
	movf	(??_main+0)+0,w
	movwf	(main@a)
	line	88
	movf	(main@a),w
	fcall	_OLED_spi_sendchar
	line	84
	
l1944:	
	movlw	01h
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	addwf	(main@i),f
	skipnc
	incf	(main@i+1),f
	movlw	0
	addwf	(main@i+1),f
	
l1946:	
	movf	(main@i+1),w
	xorlw	80h
	movwf	btemp+1
	movlw	(030h)^80h
	subwf	btemp+1,w
	skipz
	goto	u675
	movlw	0
	subwf	(main@i),w
u675:

	skipc
	goto	u671
	goto	u670
u671:
	goto	l1942
u670:
	
l215:	
	line	90
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	bcf	(1540/8)^080h,(1540)&7	;volatile
	line	91
	
l1948:	
	movlw	low(044h)
	fcall	_send_char
	line	92
	movlw	low(04Fh)
	fcall	_send_char
	line	93
	movlw	low(04Eh)
	fcall	_send_char
	line	94
	movlw	low(045h)
	fcall	_send_char
	line	95
	fcall	_send_nl
	line	96
	fcall	_setPixelAddrTo0
	goto	l1952
	line	97
	
l213:	
	goto	l1952
	line	98
	
l1950:	
	goto	l1952
	line	102
	
l216:	
	line	103
	
l1952:	
		movlw	67
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	xorwf	((main@command)),w
	btfss	status,2
	goto	u681
	goto	u680
u681:
	goto	l1916
u680:
	line	105
	
l1954:	
	fcall	_clearScreen
	line	106
	movlw	low(053h)
	fcall	_send_char
	line	107
	movlw	low(063h)
	fcall	_send_char
	line	108
	movlw	low(072h)
	fcall	_send_char
	line	109
	movlw	low(065h)
	fcall	_send_char
	line	110
	movlw	low(065h)
	fcall	_send_char
	line	111
	movlw	low(06Eh)
	fcall	_send_char
	line	113
	movlw	low(043h)
	fcall	_send_char
	line	114
	movlw	low(06Ch)
	fcall	_send_char
	line	115
	movlw	low(065h)
	fcall	_send_char
	line	116
	movlw	low(061h)
	fcall	_send_char
	line	117
	movlw	low(072h)
	fcall	_send_char
	line	118
	movlw	low(065h)
	fcall	_send_char
	line	119
	movlw	low(064h)
	fcall	_send_char
	line	120
	fcall	_send_nl
	goto	l1916
	line	121
	
l217:	
	goto	l1916
	line	128
	
l218:	
	line	43
	goto	l1916
	
l219:	
	line	129
	
l220:	
	global	start
	ljmp	start
	opt stack 0
GLOBAL	__end_of_main
	__end_of_main:
	signat	_main,90
	global	_setPixelAddrTo0

;; *************** function _setPixelAddrTo0 *****************
;; Defined at:
;;		line 220 in file "SOFTWARE/Sources/OLED_functions.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;                  1    wreg      void 
;; Registers used:
;;		wreg, status,2, status,0, pclath, cstack
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1
;;      Params:         0       0       0
;;      Locals:         0       0       0
;;      Temps:          0       0       0
;;      Totals:         0       0       0
;;Total ram usage:        0 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    3
;; This function calls:
;;		_setPixelAddr
;; This function is called by:
;;		_main
;;		_writePixel
;;		_writePixels
;; This function uses a non-reentrant model
;;
psect	text1,local,class=CODE,delta=2,merge=1
	file	"SOFTWARE/Sources/OLED_functions.c"
	line	220
global __ptext1
__ptext1:	;psect for function _setPixelAddrTo0
psect	text1
	file	"SOFTWARE/Sources/OLED_functions.c"
	line	220
	global	__size_of_setPixelAddrTo0
	__size_of_setPixelAddrTo0	equ	__end_of_setPixelAddrTo0-_setPixelAddrTo0
	
_setPixelAddrTo0:	
;incstack = 0
	opt	stack 4
; Regs used in _setPixelAddrTo0: [wreg+status,2+status,0+pclath+cstack]
	line	222
	
l1904:	
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	clrf	(setPixelAddr@row)
	movlw	low(0)
	fcall	_setPixelAddr
	line	223
	
l507:	
	return
	opt stack 0
GLOBAL	__end_of_setPixelAddrTo0
	__end_of_setPixelAddrTo0:
	signat	_setPixelAddrTo0,89
	global	_setPixelAddr

;; *************** function _setPixelAddr *****************
;; Defined at:
;;		line 209 in file "SOFTWARE/Sources/OLED_functions.c"
;; Parameters:    Size  Location     Type
;;  col             1    wreg     unsigned char 
;;  row             1    0[BANK0 ] unsigned char 
;; Auto vars:     Size  Location     Type
;;  col             1    1[BANK0 ] unsigned char 
;; Return value:  Size  Location     Type
;;                  1    wreg      void 
;; Registers used:
;;		wreg, status,2, status,0, pclath, cstack
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1
;;      Params:         0       1       0
;;      Locals:         0       1       0
;;      Temps:          0       0       0
;;      Totals:         0       2       0
;;Total ram usage:        2 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    2
;; This function calls:
;;		_OLED_spi_sendchar
;; This function is called by:
;;		_setPixelAddrTo0
;; This function uses a non-reentrant model
;;
psect	text2,local,class=CODE,delta=2,merge=1
	line	209
global __ptext2
__ptext2:	;psect for function _setPixelAddr
psect	text2
	file	"SOFTWARE/Sources/OLED_functions.c"
	line	209
	global	__size_of_setPixelAddr
	__size_of_setPixelAddr	equ	__end_of_setPixelAddr-_setPixelAddr
	
_setPixelAddr:	
;incstack = 0
	opt	stack 4
; Regs used in _setPixelAddr: [wreg+status,2+status,0+pclath+cstack]
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(setPixelAddr@col)
	line	211
	
l1806:	
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	bcf	(1540/8)^080h,(1540)&7	;volatile
	line	212
	
l1808:	
	movlw	low(015h)
	fcall	_OLED_spi_sendchar
	line	213
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(setPixelAddr@col),w
	fcall	_OLED_spi_sendchar
	line	214
	movlw	low(05Fh)
	fcall	_OLED_spi_sendchar
	line	215
	movlw	low(075h)
	fcall	_OLED_spi_sendchar
	line	216
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(setPixelAddr@row),w
	fcall	_OLED_spi_sendchar
	line	217
	movlw	low(03Fh)
	fcall	_OLED_spi_sendchar
	line	218
	
l504:	
	return
	opt stack 0
GLOBAL	__end_of_setPixelAddr
	__end_of_setPixelAddr:
	signat	_setPixelAddr,8313
	global	_init_OLED

;; *************** function _init_OLED *****************
;; Defined at:
;;		line 9 in file "SOFTWARE/Sources/OLED_power_on.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;                  1    wreg      void 
;; Registers used:
;;		wreg, status,2, status,0, pclath, cstack
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1
;;      Params:         0       0       0
;;      Locals:         0       0       0
;;      Temps:          0       0       0
;;      Totals:         0       0       0
;;Total ram usage:        0 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    3
;; This function calls:
;;		_OLED_spi_sendchar
;;		_send_char
;;		_send_nl
;;		_wait_ms
;;		_wait_us
;; This function is called by:
;;		_main
;; This function uses a non-reentrant model
;;
psect	text3,local,class=CODE,delta=2,merge=1
	file	"SOFTWARE/Sources/OLED_power_on.c"
	line	9
global __ptext3
__ptext3:	;psect for function _init_OLED
psect	text3
	file	"SOFTWARE/Sources/OLED_power_on.c"
	line	9
	global	__size_of_init_OLED
	__size_of_init_OLED	equ	__end_of_init_OLED-_init_OLED
	
_init_OLED:	
;incstack = 0
	opt	stack 4
; Regs used in _init_OLED: [wreg+status,2+status,0+pclath+cstack]
	line	12
	
l1836:	
	movlw	low(021h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(22)	;volatile
	line	14
	
l1838:	
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	bcf	(1540/8)^080h,(1540)&7	;volatile
	line	15
	
l1840:	
	movlw	low(031h)
	fcall	_send_char
	line	16
	
l1842:	
	fcall	_send_nl
	line	19
	
l1844:	
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	bsf	(1541/8)^080h,(1541)&7	;volatile
	line	20
	
l1846:	
	movlw	low(032h)
	fcall	_send_char
	line	21
	
l1848:	
	fcall	_send_nl
	line	25
	
l1850:	
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	bcf	(1542/8)^080h,(1542)&7	;volatile
	line	26
	
l1852:	
	movlw	low(033h)
	fcall	_send_char
	line	27
	
l1854:	
	fcall	_send_nl
	line	31
	
l1856:	
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	bsf	(1543/8)^080h,(1543)&7	;volatile
	line	32
	
l1858:	
	movlw	064h
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(wait_ms@i)
	movlw	0
	movwf	((wait_ms@i))+1
	fcall	_wait_ms
	line	33
	
l1860:	
	movlw	low(034h)
	fcall	_send_char
	line	34
	
l1862:	
	fcall	_send_nl
	line	38
	
l1864:	
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	bcf	(1541/8)^080h,(1541)&7	;volatile
	line	39
	
l1866:	
	movlw	0Fh
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(wait_us@i)
	movlw	0
	movwf	((wait_us@i))+1
	fcall	_wait_us
	line	40
	
l1868:	
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	bsf	(1541/8)^080h,(1541)&7	;volatile
	line	41
	
l1870:	
	movlw	low(035h)
	fcall	_send_char
	line	42
	
l1872:	
	fcall	_send_nl
	line	46
	
l1874:	
	movlw	0Fh
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(wait_us@i)
	movlw	0
	movwf	((wait_us@i))+1
	fcall	_wait_us
	line	47
	
l1876:	
	movlw	low(036h)
	fcall	_send_char
	line	48
	
l1878:	
	fcall	_send_nl
	line	51
	
l1880:	
	movlw	low(0FDh)
	fcall	_OLED_spi_sendchar
	line	53
	
l1882:	
	movlw	low(012h)
	fcall	_OLED_spi_sendchar
	line	54
	
l1884:	
	movlw	low(037h)
	fcall	_send_char
	line	55
	
l1886:	
	fcall	_send_nl
	line	59
	
l1888:	
	movlw	low(0AEh)
	fcall	_OLED_spi_sendchar
	line	60
	
l1890:	
	movlw	low(038h)
	fcall	_send_char
	line	61
	
l1892:	
	fcall	_send_nl
	line	69
	goto	l1896
	line	71
	
l1894:	
	movlw	low(0A0h)
	fcall	_OLED_spi_sendchar
	line	72
	movlw	low(072h)
	fcall	_OLED_spi_sendchar
	line	80
	goto	l711
	line	81
	
l710:	
	line	83
	
l1896:	
	movlw	low(0A0h)
	fcall	_OLED_spi_sendchar
	line	84
	movlw	low(060h)
	fcall	_OLED_spi_sendchar
	line	92
	
l711:	
	line	93
	movlw	low(039h)
	fcall	_send_char
	line	94
	fcall	_send_nl
	line	97
	movlw	low(0A1h)
	fcall	_OLED_spi_sendchar
	line	98
	movlw	low(0)
	fcall	_OLED_spi_sendchar
	line	99
	movlw	low(031h)
	fcall	_send_char
	line	100
	movlw	low(030h)
	fcall	_send_char
	line	101
	fcall	_send_nl
	line	104
	movlw	low(0A2h)
	fcall	_OLED_spi_sendchar
	line	105
	movlw	low(0)
	fcall	_OLED_spi_sendchar
	line	106
	movlw	low(031h)
	fcall	_send_char
	line	107
	movlw	low(031h)
	fcall	_send_char
	line	108
	fcall	_send_nl
	line	111
	movlw	low(0A4h)
	fcall	_OLED_spi_sendchar
	line	112
	movlw	low(031h)
	fcall	_send_char
	line	113
	movlw	low(032h)
	fcall	_send_char
	line	114
	fcall	_send_nl
	line	117
	movlw	low(0A8h)
	fcall	_OLED_spi_sendchar
	line	118
	movlw	low(03Fh)
	fcall	_OLED_spi_sendchar
	line	119
	movlw	low(031h)
	fcall	_send_char
	line	120
	movlw	low(033h)
	fcall	_send_char
	line	121
	fcall	_send_nl
	line	124
	movlw	low(0ADh)
	fcall	_OLED_spi_sendchar
	line	125
	movlw	low(08Eh)
	fcall	_OLED_spi_sendchar
	line	126
	movlw	low(031h)
	fcall	_send_char
	line	127
	movlw	low(034h)
	fcall	_send_char
	line	128
	fcall	_send_nl
	line	131
	movlw	low(0B0h)
	fcall	_OLED_spi_sendchar
	line	132
	movlw	low(0Bh)
	fcall	_OLED_spi_sendchar
	line	133
	movlw	low(031h)
	fcall	_send_char
	line	134
	movlw	low(035h)
	fcall	_send_char
	line	135
	fcall	_send_nl
	line	142
	movlw	low(0B1h)
	fcall	_OLED_spi_sendchar
	line	143
	movlw	low(031h)
	fcall	_OLED_spi_sendchar
	line	144
	movlw	low(031h)
	fcall	_send_char
	line	145
	movlw	low(036h)
	fcall	_send_char
	line	146
	fcall	_send_nl
	line	156
	movlw	low(0B3h)
	fcall	_OLED_spi_sendchar
	line	157
	movlw	low(0F0h)
	fcall	_OLED_spi_sendchar
	line	158
	movlw	low(031h)
	fcall	_send_char
	line	159
	movlw	low(037h)
	fcall	_send_char
	line	160
	fcall	_send_nl
	line	166
	movlw	low(08Ah)
	fcall	_OLED_spi_sendchar
	line	167
	movlw	low(064h)
	fcall	_OLED_spi_sendchar
	line	168
	movlw	low(031h)
	fcall	_send_char
	line	169
	movlw	low(038h)
	fcall	_send_char
	line	170
	fcall	_send_nl
	line	176
	movlw	low(08Bh)
	fcall	_OLED_spi_sendchar
	line	177
	movlw	low(078h)
	fcall	_OLED_spi_sendchar
	line	178
	movlw	low(031h)
	fcall	_send_char
	line	179
	movlw	low(039h)
	fcall	_send_char
	line	180
	fcall	_send_nl
	line	185
	movlw	low(08Ch)
	fcall	_OLED_spi_sendchar
	line	186
	movlw	low(064h)
	fcall	_OLED_spi_sendchar
	line	187
	movlw	low(032h)
	fcall	_send_char
	line	188
	movlw	low(030h)
	fcall	_send_char
	line	189
	fcall	_send_nl
	line	196
	movlw	low(0BBh)
	fcall	_OLED_spi_sendchar
	line	197
	movlw	low(03Ah)
	fcall	_OLED_spi_sendchar
	line	198
	movlw	low(032h)
	fcall	_send_char
	line	199
	movlw	low(031h)
	fcall	_send_char
	line	200
	fcall	_send_nl
	line	205
	movlw	low(0BEh)
	fcall	_OLED_spi_sendchar
	line	206
	movlw	low(03Eh)
	fcall	_OLED_spi_sendchar
	line	207
	movlw	low(032h)
	fcall	_send_char
	line	208
	movlw	low(032h)
	fcall	_send_char
	line	209
	fcall	_send_nl
	line	216
	movlw	low(087h)
	fcall	_OLED_spi_sendchar
	line	217
	movlw	low(06h)
	fcall	_OLED_spi_sendchar
	line	218
	movlw	low(032h)
	fcall	_send_char
	line	219
	movlw	low(033h)
	fcall	_send_char
	line	220
	fcall	_send_nl
	line	227
	movlw	low(081h)
	fcall	_OLED_spi_sendchar
	line	228
	movlw	low(0FFh)
	fcall	_OLED_spi_sendchar
	line	229
	movlw	low(032h)
	fcall	_send_char
	line	230
	movlw	low(034h)
	fcall	_send_char
	line	231
	fcall	_send_nl
	line	238
	movlw	low(082h)
	fcall	_OLED_spi_sendchar
	line	239
	movlw	low(0FFh)
	fcall	_OLED_spi_sendchar
	line	240
	movlw	low(032h)
	fcall	_send_char
	line	241
	movlw	low(035h)
	fcall	_send_char
	line	242
	fcall	_send_nl
	line	249
	movlw	low(083h)
	fcall	_OLED_spi_sendchar
	line	250
	movlw	low(0FFh)
	fcall	_OLED_spi_sendchar
	line	251
	movlw	low(032h)
	fcall	_send_char
	line	252
	movlw	low(036h)
	fcall	_send_char
	line	253
	fcall	_send_nl
	line	256
	movlw	low(02Eh)
	fcall	_OLED_spi_sendchar
	line	257
	movlw	low(032h)
	fcall	_send_char
	line	258
	movlw	low(037h)
	fcall	_send_char
	line	259
	fcall	_send_nl
	line	262
	movlw	low(026h)
	fcall	_OLED_spi_sendchar
	line	263
	movlw	low(01h)
	fcall	_OLED_spi_sendchar
	line	264
	movlw	low(032h)
	fcall	_send_char
	line	265
	movlw	low(038h)
	fcall	_send_char
	line	266
	fcall	_send_nl
	line	272
	movlw	low(025h)
	fcall	_OLED_spi_sendchar
	line	273
	movlw	low(0)
	fcall	_OLED_spi_sendchar
	line	274
	movlw	low(0)
	fcall	_OLED_spi_sendchar
	line	275
	movlw	low(05Fh)
	fcall	_OLED_spi_sendchar
	line	276
	movlw	low(03Fh)
	fcall	_OLED_spi_sendchar
	line	277
	movlw	low(032h)
	fcall	_send_char
	line	278
	movlw	low(039h)
	fcall	_send_char
	line	279
	fcall	_send_nl
	line	282
	
l1898:	
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	bsf	(1542/8)^080h,(1542)&7	;volatile
	line	283
	movlw	07Dh
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(wait_ms@i)
	movlw	0
	movwf	((wait_ms@i))+1
	fcall	_wait_ms
	line	284
	movlw	low(033h)
	fcall	_send_char
	line	285
	movlw	low(030h)
	fcall	_send_char
	line	286
	fcall	_send_nl
	line	290
	movlw	low(0AFh)
	fcall	_OLED_spi_sendchar
	line	291
	movlw	0C8h
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(wait_ms@i)
	movlw	0
	movwf	((wait_ms@i))+1
	fcall	_wait_ms
	line	292
	movlw	low(033h)
	fcall	_send_char
	line	293
	movlw	low(031h)
	fcall	_send_char
	line	294
	fcall	_send_nl
	line	298
	movlw	low(046h)
	fcall	_send_char
	line	299
	movlw	low(069h)
	fcall	_send_char
	line	300
	movlw	low(06Eh)
	fcall	_send_char
	line	301
	movlw	low(020h)
	fcall	_send_char
	line	302
	movlw	low(049h)
	fcall	_send_char
	line	303
	movlw	low(06Eh)
	fcall	_send_char
	line	304
	movlw	low(069h)
	fcall	_send_char
	line	305
	movlw	low(074h)
	fcall	_send_char
	line	306
	movlw	low(020h)
	fcall	_send_char
	line	307
	movlw	low(04Fh)
	fcall	_send_char
	line	308
	movlw	low(04Ch)
	fcall	_send_char
	line	309
	movlw	low(045h)
	fcall	_send_char
	line	310
	movlw	low(044h)
	fcall	_send_char
	line	311
	movlw	low(020h)
	fcall	_send_char
	line	312
	fcall	_send_nl
	line	314
	
l712:	
	return
	opt stack 0
GLOBAL	__end_of_init_OLED
	__end_of_init_OLED:
	signat	_init_OLED,89
	global	_wait_ms

;; *************** function _wait_ms *****************
;; Defined at:
;;		line 111 in file "SOFTWARE/Sources/OLED_functions.c"
;; Parameters:    Size  Location     Type
;;  i               2    4[BANK0 ] unsigned short 
;; Auto vars:     Size  Location     Type
;;  t               2    6[BANK0 ] unsigned short 
;; Return value:  Size  Location     Type
;;                  1    wreg      void 
;; Registers used:
;;		wreg, status,2, status,0, pclath, cstack
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1
;;      Params:         0       2       0
;;      Locals:         0       2       0
;;      Temps:          0       0       0
;;      Totals:         0       4       0
;;Total ram usage:        4 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    2
;; This function calls:
;;		_wait_us
;; This function is called by:
;;		_main
;;		_init_OLED
;;		_drawLine
;;		_drawRect
;; This function uses a non-reentrant model
;;
psect	text4,local,class=CODE,delta=2,merge=1
	file	"SOFTWARE/Sources/OLED_functions.c"
	line	111
global __ptext4
__ptext4:	;psect for function _wait_ms
psect	text4
	file	"SOFTWARE/Sources/OLED_functions.c"
	line	111
	global	__size_of_wait_ms
	__size_of_wait_ms	equ	__end_of_wait_ms-_wait_ms
	
_wait_ms:	
;incstack = 0
	opt	stack 5
; Regs used in _wait_ms: [wreg+status,2+status,0+pclath+cstack]
	line	114
	
l1756:	
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(wait_ms@i+1),w
	movwf	(wait_ms@t+1)
	movf	(wait_ms@i),w
	movwf	(wait_ms@t)
	line	115
	goto	l1762
	
l482:	
	line	117
	
l1758:	
	movlw	01h
	subwf	(wait_ms@t),f
	movlw	0
	skipc
	decf	(wait_ms@t+1),f
	subwf	(wait_ms@t+1),f
	line	118
	
l1760:	
	movlw	0A4h
	movwf	(wait_us@i)
	movlw	06h
	movwf	((wait_us@i))+1
	fcall	_wait_us
	goto	l1762
	line	119
	
l481:	
	line	115
	
l1762:	
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	((wait_ms@t)),w
iorwf	((wait_ms@t+1)),w
	btfss	status,2
	goto	u561
	goto	u560
u561:
	goto	l1758
u560:
	goto	l484
	
l483:	
	line	120
	
l484:	
	return
	opt stack 0
GLOBAL	__end_of_wait_ms
	__end_of_wait_ms:
	signat	_wait_ms,4217
	global	_wait_us

;; *************** function _wait_us *****************
;; Defined at:
;;		line 98 in file "SOFTWARE/Sources/OLED_functions.c"
;; Parameters:    Size  Location     Type
;;  i               2    0[BANK0 ] unsigned short 
;; Auto vars:     Size  Location     Type
;;  t               2    2[BANK0 ] unsigned short 
;; Return value:  Size  Location     Type
;;                  1    wreg      void 
;; Registers used:
;;		wreg, status,2, status,0
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1
;;      Params:         0       2       0
;;      Locals:         0       2       0
;;      Temps:          0       0       0
;;      Totals:         0       4       0
;;Total ram usage:        4 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    1
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_wait_ms
;;		_init_OLED
;; This function uses a non-reentrant model
;;
psect	text5,local,class=CODE,delta=2,merge=1
	line	98
global __ptext5
__ptext5:	;psect for function _wait_us
psect	text5
	file	"SOFTWARE/Sources/OLED_functions.c"
	line	98
	global	__size_of_wait_us
	__size_of_wait_us	equ	__end_of_wait_us-_wait_us
	
_wait_us:	
;incstack = 0
	opt	stack 5
; Regs used in _wait_us: [wreg+status,2+status,0]
	line	102
	
l1750:	
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(wait_us@i+1),w
	movwf	(wait_us@t+1)
	movf	(wait_us@i),w
	movwf	(wait_us@t)
	line	103
	goto	l1754
	
l476:	
	line	105
	
l1752:	
	movlw	01h
	subwf	(wait_us@t),f
	movlw	0
	skipc
	decf	(wait_us@t+1),f
	subwf	(wait_us@t+1),f
	line	106
# 106 "SOFTWARE/Sources/OLED_functions.c"
CLRWDT ;# 
psect	text5
	goto	l1754
	line	107
	
l475:	
	line	103
	
l1754:	
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	((wait_us@t)),w
iorwf	((wait_us@t+1)),w
	btfss	status,2
	goto	u551
	goto	u550
u551:
	goto	l1752
u550:
	goto	l478
	
l477:	
	line	108
	
l478:	
	return
	opt stack 0
GLOBAL	__end_of_wait_us
	__end_of_wait_us:
	signat	_wait_us,4217
	global	_init

;; *************** function _init *****************
;; Defined at:
;;		line 135 in file "SOFTWARE/Sources/OLED_functions.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;                  1    wreg      void 
;; Registers used:
;;		wreg, status,2, status,0, pclath, cstack
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1
;;      Params:         0       0       0
;;      Locals:         0       0       0
;;      Temps:          0       1       0
;;      Totals:         0       1       0
;;Total ram usage:        1 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    3
;; This function calls:
;;		_send_char
;;		_send_nl
;; This function is called by:
;;		_main
;; This function uses a non-reentrant model
;;
psect	text6,local,class=CODE,delta=2,merge=1
	line	135
global __ptext6
__ptext6:	;psect for function _init
psect	text6
	file	"SOFTWARE/Sources/OLED_functions.c"
	line	135
	global	__size_of_init
	__size_of_init	equ	__end_of_init-_init
	
_init:	
;incstack = 0
	opt	stack 4
; Regs used in _init: [wreg+status,2+status,0+pclath+cstack]
	line	138
	
l1810:	
	movlw	low(0FFh)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_init+0)+0
	movf	(??_init+0)+0,w
	movwf	(_Display)	;volatile
	line	139
	movlw	low(0FFh)
	movwf	(??_init+0)+0
	movf	(??_init+0)+0,w
	movwf	0+(_Display)+01h	;volatile
	line	140
	movlw	low(0FFh)
	movwf	(??_init+0)+0
	movf	(??_init+0)+0,w
	movwf	0+(_Display)+02h	;volatile
	line	141
	movlw	low(0FFh)
	movwf	(??_init+0)+0
	movf	(??_init+0)+0,w
	movwf	0+(_Display)+03h	;volatile
	line	142
	movlw	low(0A1h)
	movwf	(??_init+0)+0
	movf	(??_init+0)+0,w
	movwf	0+(_Display)+04h	;volatile
	line	143
	movlw	low(086h)
	movwf	(??_init+0)+0
	movf	(??_init+0)+0,w
	movwf	0+(_Display)+05h	;volatile
	line	144
	movlw	low(0C7h)
	movwf	(??_init+0)+0
	movf	(??_init+0)+0,w
	movwf	0+(_Display)+06h	;volatile
	line	145
	movlw	low(0C0h)
	movwf	(??_init+0)+0
	movf	(??_init+0)+0,w
	movwf	0+(_Display)+07h	;volatile
	line	147
	movlw	low(0FEh)
	movwf	(25)	;volatile
	line	148
	
l1812:	
	clrf	(11)	;volatile
	line	149
	
l1814:	
	bsf	(93/8),(93)&7	;volatile
	line	150
	
l1816:	
	bsf	(95/8),(95)&7	;volatile
	line	151
	
l1818:	
	movlw	low(07h)
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	movwf	(129)^080h	;volatile
	line	154
	
l1820:	
	movlw	low(04Fh)
	fcall	_send_char
	line	155
	
l1822:	
	movlw	low(04Ch)
	fcall	_send_char
	line	156
	
l1824:	
	movlw	low(045h)
	fcall	_send_char
	line	157
	
l1826:	
	movlw	low(044h)
	fcall	_send_char
	line	158
	
l1828:	
	movlw	low(072h)
	fcall	_send_char
	line	159
	
l1830:	
	movlw	low(067h)
	fcall	_send_char
	line	160
	
l1832:	
	movlw	low(062h)
	fcall	_send_char
	line	161
	
l1834:	
	fcall	_send_nl
	line	163
	
l492:	
	return
	opt stack 0
GLOBAL	__end_of_init
	__end_of_init:
	signat	_init,89
	global	_send_nl

;; *************** function _send_nl *****************
;; Defined at:
;;		line 34 in file "SOFTWARE/Sources/OLED_functions.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;                  1    wreg      void 
;; Registers used:
;;		wreg, status,2, status,0, pclath, cstack
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1
;;      Params:         0       0       0
;;      Locals:         0       0       0
;;      Temps:          0       0       0
;;      Totals:         0       0       0
;;Total ram usage:        0 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    2
;; This function calls:
;;		_send_char
;; This function is called by:
;;		_main
;;		_init
;;		_init_OLED
;; This function uses a non-reentrant model
;;
psect	text7,local,class=CODE,delta=2,merge=1
	line	34
global __ptext7
__ptext7:	;psect for function _send_nl
psect	text7
	file	"SOFTWARE/Sources/OLED_functions.c"
	line	34
	global	__size_of_send_nl
	__size_of_send_nl	equ	__end_of_send_nl-_send_nl
	
_send_nl:	
;incstack = 0
	opt	stack 5
; Regs used in _send_nl: [wreg+status,2+status,0+pclath+cstack]
	line	36
	
l1500:	
	movlw	low(0Ah)
	fcall	_send_char
	line	37
	movlw	low(0Dh)
	fcall	_send_char
	line	38
	
l436:	
	return
	opt stack 0
GLOBAL	__end_of_send_nl
	__end_of_send_nl:
	signat	_send_nl,89
	global	_send_char

;; *************** function _send_char *****************
;; Defined at:
;;		line 14 in file "SOFTWARE/Sources/OLED_functions.c"
;; Parameters:    Size  Location     Type
;;  c               1    wreg     unsigned char 
;; Auto vars:     Size  Location     Type
;;  c               1    5[COMMON] unsigned char 
;; Return value:  Size  Location     Type
;;                  1    wreg      void 
;; Registers used:
;;		wreg
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1
;;      Params:         0       0       0
;;      Locals:         1       0       0
;;      Temps:          0       0       0
;;      Totals:         1       0       0
;;Total ram usage:        1 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    1
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_main
;;		_send_nl
;;		_init
;;		_init_OLED
;; This function uses a non-reentrant model
;;
psect	text8,local,class=CODE,delta=2,merge=1
	line	14
global __ptext8
__ptext8:	;psect for function _send_char
psect	text8
	file	"SOFTWARE/Sources/OLED_functions.c"
	line	14
	global	__size_of_send_char
	__size_of_send_char	equ	__end_of_send_char-_send_char
	
_send_char:	
;incstack = 0
	opt	stack 5
; Regs used in _send_char: [wreg]
	movwf	(send_char@c)
	line	16
	
l1474:	
	goto	l419
	
l420:	
	
l419:	
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	btfsc	(129/8),(129)&7	;volatile
	goto	u311
	goto	u310
u311:
	goto	l419
u310:
	goto	l1476
	
l421:	
	line	17
	
l1476:	
	movf	(send_char@c),w
	movwf	(17)	;volatile
	line	18
	
l422:	
	return
	opt stack 0
GLOBAL	__end_of_send_char
	__end_of_send_char:
	signat	_send_char,4217
	global	_getbyte

;; *************** function _getbyte *****************
;; Defined at:
;;		line 52 in file "SOFTWARE/Sources/OLED_functions.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;  tmp             1    1[BANK0 ] unsigned char 
;; Return value:  Size  Location     Type
;;                  1    wreg      unsigned char 
;; Registers used:
;;		wreg, status,2, status,0, pclath, cstack
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1
;;      Params:         0       0       0
;;      Locals:         0       1       0
;;      Temps:          0       1       0
;;      Totals:         0       2       0
;;Total ram usage:        2 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    3
;; This function calls:
;;		_gethex
;; This function is called by:
;;		_main
;; This function uses a non-reentrant model
;;
psect	text9,local,class=CODE,delta=2,merge=1
	line	52
global __ptext9
__ptext9:	;psect for function _getbyte
psect	text9
	file	"SOFTWARE/Sources/OLED_functions.c"
	line	52
	global	__size_of_getbyte
	__size_of_getbyte	equ	__end_of_getbyte-_getbyte
	
_getbyte:	
;incstack = 0
	opt	stack 4
; Regs used in _getbyte: [wreg+status,2+status,0+pclath+cstack]
	line	55
	
l1906:	
	fcall	_gethex
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_getbyte+0)+0
	movf	(??_getbyte+0)+0,w
	movwf	(getbyte@tmp)
	line	56
	
l1908:	
swapf	(getbyte@tmp),f
	movlw	240
	andwf	(getbyte@tmp),f

	line	57
	
l1910:	
	fcall	_gethex
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	addwf	(getbyte@tmp),w
	goto	l448
	
l1912:	
	line	58
	
l448:	
	return
	opt stack 0
GLOBAL	__end_of_getbyte
	__end_of_getbyte:
	signat	_getbyte,89
	global	_gethex

;; *************** function _gethex *****************
;; Defined at:
;;		line 40 in file "SOFTWARE/Sources/OLED_functions.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;                  1    wreg      unsigned char 
;; Registers used:
;;		wreg, status,2, status,0, pclath, cstack
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1
;;      Params:         0       0       0
;;      Locals:         0       0       0
;;      Temps:          1       0       0
;;      Totals:         1       0       0
;;Total ram usage:        1 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    2
;; This function calls:
;;		_recv_char
;; This function is called by:
;;		_getbyte
;; This function uses a non-reentrant model
;;
psect	text10,local,class=CODE,delta=2,merge=1
	line	40
global __ptext10
__ptext10:	;psect for function _gethex
psect	text10
	file	"SOFTWARE/Sources/OLED_functions.c"
	line	40
	global	__size_of_gethex
	__size_of_gethex	equ	__end_of_gethex-_gethex
	
_gethex:	
;incstack = 0
	opt	stack 4
; Regs used in _gethex: [wreg+status,2+status,0+pclath+cstack]
	line	42
	
l1764:	
	fcall	_recv_char
	movwf	(??_gethex+0)+0
	movf	(??_gethex+0)+0,w
	movwf	(_tmpg)	;volatile
	line	43
	
l1766:	
	movlw	low(030h)
	subwf	(_tmpg),w	;volatile
	skipnc
	goto	u571
	goto	u570
u571:
	goto	l1772
u570:
	
l1768:	
	movlw	low(0FFh)
	goto	l440
	
l1770:	
	goto	l440
	
l439:	
	line	44
	
l1772:	
	movlw	low(03Ah)
	subwf	(_tmpg),w	;volatile
	skipnc
	goto	u581
	goto	u580
u581:
	goto	l1778
u580:
	
l1774:	
	movf	(_tmpg),w
	addlw	0D0h
	goto	l440
	
l1776:	
	goto	l440
	
l441:	
	line	45
	
l1778:	
	movlw	low(041h)
	subwf	(_tmpg),w	;volatile
	skipnc
	goto	u591
	goto	u590
u591:
	goto	l1784
u590:
	
l1780:	
	movlw	low(0FFh)
	goto	l440
	
l1782:	
	goto	l440
	
l442:	
	line	46
	
l1784:	
	movlw	low(047h)
	subwf	(_tmpg),w	;volatile
	skipnc
	goto	u601
	goto	u600
u601:
	goto	l1790
u600:
	
l1786:	
	movf	(_tmpg),w
	addlw	0C9h
	goto	l440
	
l1788:	
	goto	l440
	
l443:	
	line	47
	
l1790:	
	movlw	low(061h)
	subwf	(_tmpg),w	;volatile
	skipnc
	goto	u611
	goto	u610
u611:
	goto	l1796
u610:
	
l1792:	
	movlw	low(0FFh)
	goto	l440
	
l1794:	
	goto	l440
	
l444:	
	line	48
	
l1796:	
	movlw	low(067h)
	subwf	(_tmpg),w	;volatile
	skipnc
	goto	u621
	goto	u620
u621:
	goto	l1802
u620:
	
l1798:	
	movf	(_tmpg),w
	addlw	0A9h
	goto	l440
	
l1800:	
	goto	l440
	
l445:	
	line	49
	
l1802:	
	movf	(_tmpg),w	;volatile
	goto	l440
	
l1804:	
	line	50
	
l440:	
	return
	opt stack 0
GLOBAL	__end_of_gethex
	__end_of_gethex:
	signat	_gethex,89
	global	_recv_char

;; *************** function _recv_char *****************
;; Defined at:
;;		line 8 in file "SOFTWARE/Sources/OLED_functions.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;                  1    wreg      unsigned char 
;; Registers used:
;;		wreg
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1
;;      Params:         0       0       0
;;      Locals:         0       0       0
;;      Temps:          0       0       0
;;      Totals:         0       0       0
;;Total ram usage:        0 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    1
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_gethex
;;		_waitnl
;; This function uses a non-reentrant model
;;
psect	text11,local,class=CODE,delta=2,merge=1
	line	8
global __ptext11
__ptext11:	;psect for function _recv_char
psect	text11
	file	"SOFTWARE/Sources/OLED_functions.c"
	line	8
	global	__size_of_recv_char
	__size_of_recv_char	equ	__end_of_recv_char-_recv_char
	
_recv_char:	
;incstack = 0
	opt	stack 4
; Regs used in _recv_char: [wreg]
	line	10
	
l1744:	
	goto	l413
	
l414:	
	
l413:	
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	btfss	(128/8),(128)&7	;volatile
	goto	u541
	goto	u540
u541:
	goto	l413
u540:
	goto	l1746
	
l415:	
	line	11
	
l1746:	
	movf	(17),w	;volatile
	goto	l416
	
l1748:	
	line	12
	
l416:	
	return
	opt stack 0
GLOBAL	__end_of_recv_char
	__end_of_recv_char:
	signat	_recv_char,89
	global	_clearScreen

;; *************** function _clearScreen *****************
;; Defined at:
;;		line 165 in file "SOFTWARE/Sources/OLED_functions.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;                  1    wreg      void 
;; Registers used:
;;		wreg, status,2, status,0, pclath, cstack
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1
;;      Params:         0       0       0
;;      Locals:         0       0       0
;;      Temps:          0       0       0
;;      Totals:         0       0       0
;;Total ram usage:        0 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    2
;; This function calls:
;;		_OLED_spi_sendchar
;; This function is called by:
;;		_main
;; This function uses a non-reentrant model
;;
psect	text12,local,class=CODE,delta=2,merge=1
	line	165
global __ptext12
__ptext12:	;psect for function _clearScreen
psect	text12
	file	"SOFTWARE/Sources/OLED_functions.c"
	line	165
	global	__size_of_clearScreen
	__size_of_clearScreen	equ	__end_of_clearScreen-_clearScreen
	
_clearScreen:	
;incstack = 0
	opt	stack 5
; Regs used in _clearScreen: [wreg+status,2+status,0+pclath+cstack]
	line	168
	
l1900:	
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	bcf	(1540/8)^080h,(1540)&7	;volatile
	line	171
	
l1902:	
	movlw	low(025h)
	fcall	_OLED_spi_sendchar
	line	172
	movlw	low(0)
	fcall	_OLED_spi_sendchar
	line	173
	movlw	low(0)
	fcall	_OLED_spi_sendchar
	line	174
	movlw	low(05Fh)
	fcall	_OLED_spi_sendchar
	line	175
	movlw	low(03Fh)
	fcall	_OLED_spi_sendchar
	line	176
	
l495:	
	return
	opt stack 0
GLOBAL	__end_of_clearScreen
	__end_of_clearScreen:
	signat	_clearScreen,89
	global	_OLED_spi_sendchar

;; *************** function _OLED_spi_sendchar *****************
;; Defined at:
;;		line 76 in file "SOFTWARE/Sources/OLED_functions.c"
;; Parameters:    Size  Location     Type
;;  c               1    wreg     unsigned char 
;; Auto vars:     Size  Location     Type
;;  c               1    5[COMMON] unsigned char 
;; Return value:  Size  Location     Type
;;                  1    wreg      void 
;; Registers used:
;;		wreg
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1
;;      Params:         0       0       0
;;      Locals:         1       0       0
;;      Temps:          0       0       0
;;      Totals:         1       0       0
;;Total ram usage:        1 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    1
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_main
;;		_clearScreen
;;		_setPixelAddr
;;		_init_OLED
;;		_drawLine
;;		_drawRect
;;		_writePixel
;;		_writePixels
;; This function uses a non-reentrant model
;;
psect	text13,local,class=CODE,delta=2,merge=1
	line	76
global __ptext13
__ptext13:	;psect for function _OLED_spi_sendchar
psect	text13
	file	"SOFTWARE/Sources/OLED_functions.c"
	line	76
	global	__size_of_OLED_spi_sendchar
	__size_of_OLED_spi_sendchar	equ	__end_of_OLED_spi_sendchar-_OLED_spi_sendchar
	
_OLED_spi_sendchar:	
;incstack = 0
	opt	stack 4
; Regs used in _OLED_spi_sendchar: [wreg]
	movwf	(OLED_spi_sendchar@c)
	line	78
	
l1742:	
	movf	(OLED_spi_sendchar@c),w
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(23)	;volatile
	line	79
	goto	l463
	
l464:	
	
l463:	
	btfsc	(176/8),(176)&7	;volatile
	goto	u531
	goto	u530
u531:
	goto	l463
u530:
	goto	l466
	
l465:	
	line	80
	
l466:	
	return
	opt stack 0
GLOBAL	__end_of_OLED_spi_sendchar
	__end_of_OLED_spi_sendchar:
	signat	_OLED_spi_sendchar,4217
	global	_IT

;; *************** function _IT *****************
;; Defined at:
;;		line 8 in file "SOFTWARE/Sources/main.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;                  1    wreg      void 
;; Registers used:
;;		wreg, fsr0l, fsr0h, status,2, status,0
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1
;;      Params:         0       0       0
;;      Locals:         0       0       0
;;      Temps:          5       0       0
;;      Totals:         5       0       0
;;Total ram usage:        5 bytes
;; Hardware stack levels used:    1
;; This function calls:
;;		Nothing
;; This function is called by:
;;		Interrupt level 1
;; This function uses a non-reentrant model
;;
psect	text14,local,class=CODE,delta=2,merge=1
	file	"SOFTWARE/Sources/main.c"
	line	8
global __ptext14
__ptext14:	;psect for function _IT
psect	text14
	file	"SOFTWARE/Sources/main.c"
	line	8
	global	__size_of_IT
	__size_of_IT	equ	__end_of_IT-_IT
	
_IT:	
;incstack = 0
	opt	stack 4
; Regs used in _IT: [wreg-fsr0h+status,2+status,0]
psect	intentry,class=CODE,delta=2
global __pintentry
__pintentry:
global interrupt_function
interrupt_function:
	global saved_w
	saved_w	set	btemp+0
	movwf	saved_w
	swapf	status,w
	movwf	(??_IT+1)
	movf	fsr0,w
	movwf	(??_IT+2)
	movf	pclath,w
	movwf	(??_IT+3)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	btemp+1,w
	movwf	(??_IT+4)
	ljmp	_IT
psect	text14
	line	10
	
i1l1652:	
	bcf	(90/8),(90)&7	;volatile
	line	11
	
i1l1654:	
	movlw	low(0FFh)
	movwf	(24)	;volatile
	line	12
	clrc
	rlf	(25),f	;volatile

	line	13
	
i1l1656:	
		movlw	254
	xorwf	((25)),w	;volatile
	btfsc	status,2
	goto	u42_21
	goto	u42_20
u42_21:
	goto	i1l205
u42_20:
	
i1l1658:	
	movlw	low(01h)
	movwf	(??_IT+0)+0
	movf	(??_IT+0)+0,w
	addwf	(25),f	;volatile
	
i1l205:	
	line	14
	movf	(_Disp_idx),w	;volatile
	addlw	01h
	andlw	07h
	movwf	(??_IT+0)+0
	movf	(??_IT+0)+0,w
	movwf	(_Disp_idx)	;volatile
	line	15
	
i1l1660:	
	movf	(_Disp_idx),w
	addlw	low(_Display|((0x0)<<8))&0ffh
	movwf	fsr0
	bcf	status, 7	;select IRP bank0
	movf	indf,w
	movwf	(24)	;volatile
	line	16
	
i1l1662:	
	movf	((_Disp_idx)),w	;volatile
	btfss	status,2
	goto	u43_21
	goto	u43_20
u43_21:
	goto	i1l207
u43_20:
	
i1l1664:	
	movlw	low(01h)
	movwf	(??_IT+0)+0
	movf	(??_IT+0)+0,w
	addwf	(_sys_cnt),f	;volatile
	goto	i1l207
	
i1l206:	
	line	17
	
i1l207:	
	movf	(??_IT+4),w
	movwf	btemp+1
	movf	(??_IT+3),w
	movwf	pclath
	movf	(??_IT+2),w
	movwf	fsr0
	swapf	(??_IT+1)^0FFFFFF80h,w
	movwf	status
	swapf	saved_w,f
	swapf	saved_w,w
	retfie
	opt stack 0
GLOBAL	__end_of_IT
	__end_of_IT:
	signat	_IT,89
global	___latbits
___latbits	equ	0
	global	btemp
	btemp set 07Eh

	DABS	1,126,2	;btemp
	global	wtemp
	global	wtemp0
	wtemp set btemp
	wtemp0 set btemp
	global	wtemp1
	wtemp1 set btemp+2
	global	wtemp2
	wtemp2 set btemp+4
	global	wtemp3
	wtemp3 set btemp+6
	global	wtemp4
	wtemp4 set btemp+8
	global	wtemp5
	wtemp5 set btemp+10
	global	wtemp6
	wtemp6 set btemp+1
	global	ttemp
	global	ttemp0
	ttemp set btemp
	ttemp0 set btemp
	global	ttemp1
	ttemp1 set btemp+3
	global	ttemp2
	ttemp2 set btemp+6
	global	ttemp3
	ttemp3 set btemp+9
	global	ttemp4
	ttemp4 set btemp+1
	global	ltemp
	global	ltemp0
	ltemp set btemp
	ltemp0 set btemp
	global	ltemp1
	ltemp1 set btemp+4
	global	ltemp2
	ltemp2 set btemp+8
	global	ltemp3
	ltemp3 set btemp+2
	end
