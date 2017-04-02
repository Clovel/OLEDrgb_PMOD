/* Register definitions for central processor in multimed
Version 1.2 updated 2014/10/02 by yb
Version 1.1 updated 2014/05/21 by yb
*/

#ifdef _SDSPI_HEADER_
#warning several calls to SOC_header.h
#else
#define _SDSPI_HEADER_
// Byte definitions
static volatile unsigned char	FPGA_CONFIG_ID   @ 0x05;
static volatile unsigned char	FPGA_PROJECT_ID  @ 0x06;
static volatile unsigned char	FPGA_BOARD_ID    @ 0x07;


static volatile unsigned char	NEX4_RGB_LED_OUT @ 0x0C;
static volatile unsigned char	NEX4_DIR_BUT_IN  @ 0x0C;
static volatile unsigned char	SOC_MODES        @ 0x0D;
static volatile unsigned char	NEX4_SW_LSB_IN   @ 0x0E;
static volatile unsigned char	NEX4_LED_LSB_OUT @ 0x0E;
static volatile unsigned char	NEX4_SW_MSB_IN   @ 0x0F;
static volatile unsigned char	NEX4_LED_MSB_OUT @ 0x0F;
static volatile unsigned char	UART_STATUS      @ 0x10;
static volatile unsigned char	UART_RXR  	     @ 0x11;
static volatile unsigned char	UART_TXR  	     @ 0x11;
static volatile unsigned char	CRC_L	  	    @ 0x12;
static volatile unsigned char	CRC_H   	    @ 0x13;
//static volatile unsigned char   FSPI_STATUS   @ 0x14;
//static volatile unsigned char   FSPI_FILE	    @ 0x15;
static volatile unsigned char   OLED_SPI_STATUS  @ 0x16;
static volatile unsigned char   OLED_SPI_FILE	 @ 0x17;
static volatile unsigned char   NEX4_7SEG_VAL    @ 0x18;
static volatile unsigned char   NEX4_7SEG_SEL    @ 0x19;

static volatile unsigned char	CODE_ADDR_LSB   @ 0x8C;
static volatile unsigned char	CODE_ADDR_MSB   @ 0x8D;
static volatile unsigned char	CODE_DATA_L     @ 0x8E;
static volatile unsigned char	CODE_DATA_H     @ 0x8F;

static volatile unsigned short	CODE_ADDR       @ 0x8C;
static volatile unsigned short	CODE_DATA       @ 0x8E;


static volatile unsigned char	NEX4_PMOD_B     @ 0xC0;


//bit definitions

static volatile bit NEX4_RGBL0_BLUE   @ (unsigned)&NEX4_RGB_LED_OUT*8+0;
static volatile bit NEX4_RGBL0_GREEN  @ (unsigned)&NEX4_RGB_LED_OUT*8+1;
static volatile bit NEX4_RGBL0_RED    @ (unsigned)&NEX4_RGB_LED_OUT*8+2;
static volatile bit NEX4_RGBL1_BLUE   @ (unsigned)&NEX4_RGB_LED_OUT*8+3;
static volatile bit NEX4_RGBL1_GREEN  @ (unsigned)&NEX4_RGB_LED_OUT*8+4;
static volatile bit NEX4_RGBL1_RED    @ (unsigned)&NEX4_RGB_LED_OUT*8+5;

static volatile bit NEX4_PB_RIGHT    @ (unsigned)&NEX4_DIR_BUT_IN*8+0;
static volatile bit NEX4_PB_LEFT     @ (unsigned)&NEX4_DIR_BUT_IN*8+1;
static volatile bit NEX4_PB_DOWN     @ (unsigned)&NEX4_DIR_BUT_IN*8+2;
static volatile bit NEX4_PB_UP       @ (unsigned)&NEX4_DIR_BUT_IN*8+3;
static volatile bit NEX4_PB_CENT     @ (unsigned)&NEX4_DIR_BUT_IN*8+4;


static volatile bit RAM_MODE   @ (unsigned)&SOC_MODES*8+0;
static volatile bit WDTE       @ (unsigned)&SOC_MODES*8+1;

static volatile bit NEX4_SW_0    @ (unsigned)&NEX4_SW_LSB_IN*8+0;
static volatile bit NEX4_SW_1    @ (unsigned)&NEX4_SW_LSB_IN*8+1;
static volatile bit NEX4_SW_2    @ (unsigned)&NEX4_SW_LSB_IN*8+2;
static volatile bit NEX4_SW_3    @ (unsigned)&NEX4_SW_LSB_IN*8+3;
static volatile bit NEX4_SW_4    @ (unsigned)&NEX4_SW_LSB_IN*8+4;
static volatile bit NEX4_SW_5    @ (unsigned)&NEX4_SW_LSB_IN*8+5;
static volatile bit NEX4_SW_6    @ (unsigned)&NEX4_SW_LSB_IN*8+6;
static volatile bit NEX4_SW_7    @ (unsigned)&NEX4_SW_LSB_IN*8+7;
static volatile bit NEX4_SW_8    @ (unsigned)&NEX4_SW_MSB_IN*8+0;
static volatile bit NEX4_SW_9    @ (unsigned)&NEX4_SW_MSB_IN*8+1;
static volatile bit NEX4_SW_A    @ (unsigned)&NEX4_SW_MSB_IN*8+2;
static volatile bit NEX4_SW_B    @ (unsigned)&NEX4_SW_MSB_IN*8+3;
static volatile bit NEX4_SW_C    @ (unsigned)&NEX4_SW_MSB_IN*8+4;
static volatile bit NEX4_SW_D    @ (unsigned)&NEX4_SW_MSB_IN*8+5;
static volatile bit NEX4_SW_E    @ (unsigned)&NEX4_SW_MSB_IN*8+6;
static volatile bit NEX4_SW_F    @ (unsigned)&NEX4_SW_MSB_IN*8+7;


static volatile bit NEX4_LED_0    @ (unsigned)&NEX4_LED_LSB_OUT*8+0;
static volatile bit NEX4_LED_1    @ (unsigned)&NEX4_LED_LSB_OUT*8+1;
static volatile bit NEX4_LED_2    @ (unsigned)&NEX4_LED_LSB_OUT*8+2;
static volatile bit NEX4_LED_3    @ (unsigned)&NEX4_LED_LSB_OUT*8+3;
static volatile bit NEX4_LED_4    @ (unsigned)&NEX4_LED_LSB_OUT*8+4;
static volatile bit NEX4_LED_5    @ (unsigned)&NEX4_LED_LSB_OUT*8+5;
static volatile bit NEX4_LED_6    @ (unsigned)&NEX4_LED_LSB_OUT*8+6;
static volatile bit NEX4_LED_7    @ (unsigned)&NEX4_LED_LSB_OUT*8+7;
static volatile bit NEX4_LED_8    @ (unsigned)&NEX4_LED_MSB_OUT*8+0;
static volatile bit NEX4_LED_9    @ (unsigned)&NEX4_LED_MSB_OUT*8+1;
static volatile bit NEX4_LED_A    @ (unsigned)&NEX4_LED_MSB_OUT*8+2;
static volatile bit NEX4_LED_B    @ (unsigned)&NEX4_LED_MSB_OUT*8+3;
static volatile bit NEX4_LED_C    @ (unsigned)&NEX4_LED_MSB_OUT*8+4;
static volatile bit NEX4_LED_D    @ (unsigned)&NEX4_LED_MSB_OUT*8+5;
static volatile bit NEX4_LED_E    @ (unsigned)&NEX4_LED_MSB_OUT*8+6;
static volatile bit NEX4_LED_F    @ (unsigned)&NEX4_LED_MSB_OUT*8+7;



static volatile bit UART_RXRDY  @ (unsigned)&UART_STATUS*8+0;
static volatile bit UART_TXBSY  @ (unsigned)&UART_STATUS*8+1;
static volatile bit UART_TXMPTY @ (unsigned)&UART_STATUS*8+2;
static volatile bit UART_RXHIGH @ (unsigned)&UART_STATUS*8+3;
static volatile bit UART_RXFULL @ (unsigned)&UART_STATUS*8+4;
static volatile bit UART_RXDLSS @ (unsigned)&UART_STATUS*8+5;
static volatile bit UART_SPEEDL @ (unsigned)&UART_STATUS*8+6;
static volatile bit UART_SPEEDH @ (unsigned)&UART_STATUS*8+7;



//static volatile bit FSPI_BSY @ (unsigned)&FSPI_STATUS*8+5;

static volatile bit OLED_SPI_BSY @ (unsigned)&OLED_SPI_STATUS*8+0;

static volatile bit OLED_DC     @ (unsigned)&NEX4_PMOD_B*8+4; // Data/Command
static volatile bit OLED_RES    @ (unsigned)&NEX4_PMOD_B*8+5; // Reset
static volatile bit OLED_VBATC  @ (unsigned)&NEX4_PMOD_B*8+6; // VCC_Enable
static volatile bit OLED_VDDC   @ (unsigned)&NEX4_PMOD_B*8+7; // PMOD_Enable


#define INSTR_ALLFLASH_SLOW_READ 0
static volatile unsigned char	FSPI_STATUS   @ 0xC3;
static volatile unsigned char	FSPI_FILE     @ 0xC3;




// constants

#define UART_SPEED_115k		0x00
#define UART_SPEED_921k		0x40
#define UART_SPEED_2M		0x80
#define UART_SPEED_3M		0xC0


#ifdef CLK_50MHZ
    #define SPI_PREAMP	   0x82
    #define SPI_FLASH	   0x44
    #define SPI_FLASH_FAST 0x04
    #define SPI_ALT		   0x48
    #define SPI_EXT		   0x50
#endif

#ifdef CLK_100MHZ
    #define SPI_DAC		   0x01
    #define SPI_FLASH	   0x84
    #define SPI_FLASH_FAST 0x04
    #define SPI_ALT		   0xC8
#endif

#define SPI_FREE	   0x00


// specific IDs
#define BOARD_ID_MULTIMED_A     0x20
#define BOARD_ID_MULTIMED_B     0x21

#define PROJECT_ID_TEST         0x00
#define PROJECT_ID_GENERIC      0x01
#define PROJECT_ID_HYRENE       0x02
#define PROJECT_ID_BRAINBOW     0x03
#define PROJECT_ID_GLYCEMIA     0x04
#define PROJECT_ID_CENAVEX      0x05 


//7 seg display constants
#define D7SEG_0             0xC0
#define D7SEG_1             0xF9
#define D7SEG_2             0xA4
#define D7SEG_3             0xB0
#define D7SEG_4             0x99
#define D7SEG_5             0x92
#define D7SEG_6             0x82
#define D7SEG_7             0xF8
#define D7SEG_8             0x80
#define D7SEG_9             0x90
#define D7SEG_A             0x88
#define D7SEG_B             0x83
#define D7SEG_C             0xA7
#define D7SEG_D             0xA1
#define D7SEG_E             0x86
#define D7SEG_F             0x8E
#define D7SEG_G             0xC2
#define D7SEG_H             0x89
#define D7SEG_I             0xB0
#define D7SEG_J             0xE2
#define D7SEG_L             0xC7
#define D7SEG_N             0xAB
#define D7SEG_O             0xC0
#define D7SEG_P             0x8C
#define D7SEG_R             0xAF
#define D7SEG_S             0x92
#define D7SEG_T             0x8F
#define D7SEG_U             0xC1
#define D7SEG_Y             0x85


#define D7SEG_BLANK         0xFF
#define D7SEG_POINT         0x7F
#define D7SEG_CENTER        0xBF
#define D7SEG_SEG_SE        0xFB
#define D7SEG_SEG_NE        0xFD
#define D7SEG_SEG_N         0xFE
#define D7SEG_SEG_NW        0xDF
#define D7SEG_SEG_SW        0xEF
#define D7SEG_SEG_S         0xF7


#define SPI_SPEED_50_00MHz 0x00 // ne fonctionne pas
#define SPI_SPEED_25_00MHz 0x20 // fonctionne correctement
#define SPI_SPEED_16_67MHz 0x40
#define SPI_SPEED_12_50MHz 0x24
#define SPI_SPEED_10_00MHz 0x60
#define SPI_SPEED_8_333MHz 0x28
#define SPI_SPEED_7_143MHz 0x44
#define SPI_SPEED_6_250MHz 0x2C // d'apres datasheet
#define SPI_SPEED_5_555MHz 0x80 // on utilise une des deux freq
#define SPI_SPEED_5_000MHz 0x30
#define SPI_SPEED_4_545MHz 0x48
#define SPI_SPEED_4_167MHz 0x34
#define SPI_SPEED_3_846MHz 0x64
#define SPI_SPEED_3_571MHz 0x38
#define SPI_SPEED_3_333MHz 0x4C
#define SPI_SPEED_3_125MHz 0x3C
#define SPI_SPEED_2_777MHz 0xA0
#define SPI_SPEED_2_500MHz 0x50
#define SPI_SPEED_2_273MHz 0x68
#define SPI_SPEED_2_083MHz 0x54
#define SPI_SPEED_1_923MHz 0x84
#define SPI_SPEED_1_786MHz 0x58
#define SPI_SPEED_1_666MHz 0x6C
#define SPI_SPEED_1_562MHz 0x5C
#define SPI_SPEED_1_429MHz 0xC0
#define SPI_SPEED_1_282MHz 0x70
#define SPI_SPEED_1_163MHz 0x88
#define SPI_SPEED_1_064MHz 0x74
#define SPI_SPEED_962_0kHz 0xA4
#define SPI_SPEED_909_0kHz 0x78
#define SPI_SPEED_833_3kHz 0x8C
#define SPI_SPEED_781_2kHz 0x7C
#define SPI_SPEED_724_6kHz 0xE0
#define SPI_SPEED_649_4kHz 0x90
#define SPI_SPEED_581_4kHz 0xA8
#define SPI_SPEED_532_0kHz 0x94
#define SPI_SPEED_490_2kHz 0xC4 // 490kHz - Pour commencer
#define SPI_SPEED_450_4kHz 0x98
#define SPI_SPEED_416_7kHz 0xAC
#define SPI_SPEED_390_9kHz 0x9C
#define SPI_SPEED_324_7kHz 0xB0
#define SPI_SPEED_292_4kHz 0xC8
#define SPI_SPEED_266_0kHz 0xB4
#define SPI_SPEED_243_9kHz 0xE4
#define SPI_SPEED_225_2kHz 0xB8
#define SPI_SPEED_209_2kHz 0xCC
#define SPI_SPEED_195_3kHz 0xBC
#define SPI_SPEED_162_3kHz 0xD0
#define SPI_SPEED_146_2kHz 0xE8
#define SPI_SPEED_133_0kHz 0xD4
#define SPI_SPEED_112_6kHz 0xD8
#define SPI_SPEED_104_6kHz 0xEC
#define SPI_SPEED_97_66kHz 0xDC
#define SPI_SPEED_81_30kHz 0xF0
#define SPI_SPEED_66_67kHz 0xF4
#define SPI_SPEED_56_31kHz 0xF8
#define SPI_SPEED_48_83kHz 0xFC



//#define SPI_SPEED_25_000MHz 0x04
//#define SPI_SPEED_16_667MHz 0x08
//#define SPI_SPEED_12_500MHz 0x0C
//#define SPI_SPEED_10_000MHz 0x10
//#define SPI_SPEED_8_333MHz  0x14
//#define SPI_SPEED_7_143MHz  0x18
//#define SPI_SPEED_6_250MHz  0x1C



#endif
