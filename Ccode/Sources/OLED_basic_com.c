// This file is a minimal bootlader for the SDSPI project (but may be reused)
// it is intended to be used with MPLAB X v3.05 and compiled with XC8 v1.35
// converted from Brainbow bootloader V1.3.9 by YB (2015/08/31)

#include	<pic.h>				//  macros
#define CLK_100MHZ
#include    "..\OLED_up_header.h"	// SOC definitions


#define SOFT_VERSION    0x01 //V1.0

unsigned char tmpg;
unsigned char Display[8];
unsigned char Disp_idx;
unsigned char sys_cnt;

unsigned char last_R7_resp[4];


//#define OLED_SPI_SELECT  (SPI_SPEED_1_064MHz | 0x01)
//#define OLED_SPI_RELEASE (SPI_SPEED_1_064MHz)
#define OLED_SPI_SELECT  (SPI_SPEED_10_00MHz | 0x01)
#define OLED_SPI_RELEASE (SPI_SPEED_10_00MHz)


#define SD_RESP_PARAM_ERROR 0x40
#define SD_RESP_ADDR_ERROR  0x20
#define SD_RESP_ERASE_ERROR 0x10
#define SD_RESP_CRC_ERROR   0x08
#define SD_RESP_ILLEGAL_CMD 0x04
#define SD_RESP_ERASE_RESET 0x02
#define SD_RESP_IDLE        0x01



interrupt void IT(void)
{ 
    T0IF = 0;
    NEX4_7SEG_VAL = 0xFF;
    NEX4_7SEG_SEL <<= 1;
    if (NEX4_7SEG_SEL != 0xFE)  { NEX4_7SEG_SEL++; }
    Disp_idx = (Disp_idx+1) & 0x07;
    NEX4_7SEG_VAL = Display[Disp_idx];
    if (! Disp_idx) { sys_cnt++; }
}

unsigned char recv_char(void)
{
	while (UART_RXRDY==0) {  }
	return(UART_RXR);
}

void send_char(unsigned char c)
{
	while (UART_TXBSY==1) {  }
	UART_TXR = c;
}


void send_hex(unsigned char c)
{
    NEX4_RGBL1_RED = 1;
	char n;
	n=(c>>4)+'0';
	if (n>'9') n=n+7;
	while (UART_TXBSY==1) {  }
	UART_TXR = n;
	n=(c & 0x0F)+'0';
	if (n>'9') n=n+7;
	while (UART_TXBSY==1) {  }
	UART_TXR = n;
    NEX4_RGBL1_RED = 0;
}


void send_nl(void)
{
    send_char(10);
    send_char(13);
}    

unsigned char gethex(void)
{
	tmpg = recv_char();
	if (tmpg<'0') return (0xFF);
	if (tmpg<':') return (tmpg-'0');
	if (tmpg<'A') return (0xFF);
	if (tmpg<'G') return (tmpg- ('A'-10));
	if (tmpg<'a') return (0xFF);
	if (tmpg<'g') return (tmpg- ('a'-10));
    return (tmpg);
}

unsigned char getbyte(void)
{
	unsigned char tmp;
	tmp = gethex();
	tmp <<=4;
	return (tmp + gethex() );
}
//
//unsigned char OLED_spi_exc(unsigned char c)
//{
//    NEX4_RGBL0_RED = 1;
//	OLED_SPI_FILE   = c;
//	while (OLED_SPI_BSY) { }	
//    NEX4_RGBL1_RED = 0;
//    return OLED_SPI_FILE;
//}
//unsigned char OLED_spi_getchar()
//{
//	OLED_SPI_FILE   = 0;
//	while (OLED_SPI_BSY) { }	
//    return OLED_SPI_FILE;
//}

void OLED_spi_sendchar(unsigned char c)
{
	OLED_SPI_FILE   = c;
	while (OLED_SPI_BSY) { }	
}


void wait_c_us(unsigned char i)
{
    char c;
    c=i;
    while (c>0)
      {
      c--;
      asm("CLRWDT");
      }
}



void wait_us(unsigned short int i)
{
    unsigned short t;
    t=i;
    while (t>0)
    {
      t--;
      asm("CLRWDT");
    }
}


void wait_ms(unsigned short int i)
{
    unsigned short t;
    t=i;
    while (t>0)
    {
        t--;
        wait_us(1700);
    }
}


void waitnl(void)
{	
	unsigned char c;
	do
	{
		c=recv_char();
	} while(c!=0x0A);
}



init (void)
// initialization function
{
    Display[0]= D7SEG_BLANK;
    Display[1]= D7SEG_BLANK;
    Display[2]= D7SEG_BLANK;
    Display[3]= D7SEG_BLANK;
    Display[4]= D7SEG_D;
    Display[5]= D7SEG_E;
    Display[6]= D7SEG_L;
    Display[7]= D7SEG_O;
    
    NEX4_7SEG_SEL = 0xFE;
    INTCON = 0;
    T0IE = 1;
    GIE = 1;
    OPTION_REG = 7;
    send_char('O');
    send_char('L');
    send_char('E');
    send_char('D');
    send_char(' ');
    send_char('2');
    send_nl();
    
}


void OLED_init(void)
{
    
    NEX4_PMOD_B = 0xF0;
    OLED_RES = 0;
    wait_ms(10);
    OLED_RES = 1;
    OLED_VDDC = 0;
    
    // send DISPLAY OFF command
    OLED_SPI_STATUS = OLED_SPI_SELECT;
    OLED_DC = 0;
    OLED_spi_sendchar(0xAE);
//    OLED_SPI_STATUS = OLED_SPI_RELEASE;
    
    // setting Operating mode
    
    // set mux ratio
    OLED_SPI_STATUS = OLED_SPI_SELECT;
    OLED_DC = 0;
    OLED_spi_sendchar(0xA8);
    OLED_spi_sendchar(0x3F);
//    OLED_SPI_STATUS = OLED_SPI_RELEASE;
    
    // set display offset
    OLED_SPI_STATUS = OLED_SPI_SELECT;
    OLED_DC = 0;
    OLED_spi_sendchar(0xD3);
    OLED_spi_sendchar(0x00);
//    OLED_SPI_STATUS = OLED_SPI_RELEASE;
    
    // Set display start line
    OLED_SPI_STATUS = OLED_SPI_SELECT;
    OLED_DC = 0;
    OLED_spi_sendchar(0x40);
//    OLED_SPI_STATUS = OLED_SPI_RELEASE;
    
    // set segment remap
    OLED_SPI_STATUS = OLED_SPI_SELECT;
    OLED_DC = 0;
    OLED_spi_sendchar(0xA0); // 0xA0 (left) or 0xA1 (right)
//    OLED_SPI_STATUS = OLED_SPI_RELEASE;

    // Set COM output scan direction
    OLED_SPI_STATUS = OLED_SPI_SELECT;
    OLED_DC = 0;
    OLED_spi_sendchar(0xC0); // 0xC8 OLED on the right / 0xC0 if OLED on the left (vertical twist)
//    OLED_SPI_STATUS = OLED_SPI_RELEASE;

    // set COM pins hardware configuration
    OLED_SPI_STATUS = OLED_SPI_SELECT;
    OLED_DC = 0;
    OLED_spi_sendchar(0xDA);
    OLED_spi_sendchar(0x02); //0x02 to display pages 4 to 7 / 0x22 to display pages 0 to 3
                             // switch values if screen on the left...
//    OLED_SPI_STATUS = OLED_SPI_RELEASE;

    
    // Set Contrast
    OLED_SPI_STATUS = OLED_SPI_SELECT;
    OLED_DC = 0;
    OLED_spi_sendchar(0x81);
    OLED_spi_sendchar(0x1F);
//    OLED_SPI_STATUS = OLED_SPI_RELEASE;

    // Disable entire Display ON
    OLED_SPI_STATUS = OLED_SPI_SELECT;
    OLED_DC = 0;
    OLED_spi_sendchar(0xA4); // A4:set / A5:disable
//    OLED_SPI_STATUS = OLED_SPI_RELEASE;

    // Set Normal Display 
    OLED_SPI_STATUS = OLED_SPI_SELECT;
    OLED_DC = 0;
    OLED_spi_sendchar(0xA6);
//    OLED_SPI_STATUS = OLED_SPI_RELEASE;
    
    // Set OSC freq.
    OLED_SPI_STATUS = OLED_SPI_SELECT;
    OLED_DC = 0;
    OLED_spi_sendchar(0xD5);
    OLED_spi_sendchar(0x80);
//    OLED_SPI_STATUS = OLED_SPI_RELEASE;

    // Enable Charge Pump Reg
    OLED_SPI_STATUS = OLED_SPI_SELECT;
    OLED_DC = 0;
    OLED_spi_sendchar(0x8D);
    OLED_spi_sendchar(0x14);    
//    OLED_SPI_STATUS = OLED_SPI_RELEASE;

    // set pre-charge pump
    OLED_SPI_STATUS = OLED_SPI_SELECT;
    OLED_DC = 0;
    OLED_spi_sendchar(0xD9);
    OLED_spi_sendchar(0xF1);    
//    OLED_SPI_STATUS = OLED_SPI_RELEASE;

    
    // here we should clear screen
    
    // Apply Power to VBAT
    OLED_VBATC = 0;
    
    // Delay 100ms
    wait_ms(100);
    
    
    
    
    // Display On
    OLED_SPI_STATUS = OLED_SPI_SELECT;
    OLED_DC = 0;
    OLED_spi_sendchar(0xAF);
//    OLED_SPI_STATUS = OLED_SPI_RELEASE;

/*
    // Horizontal addressing
    OLED_SPI_STATUS = OLED_SPI_SELECT;
    OLED_DC = 0;
    OLED_spi_sendchar(0x20);
    OLED_spi_sendchar(0x00);
    OLED_SPI_STATUS = OLED_SPI_RELEASE;
    // set addressing parameters for Horizontal/vertical addressing
    OLED_SPI_STATUS = OLED_SPI_SELECT;
    OLED_DC = 0;
    OLED_spi_sendchar(0x21);
    OLED_spi_sendchar(0x00);
    OLED_spi_sendchar(0x7F);
    OLED_spi_sendchar(0x22);
    OLED_spi_sendchar(0x00);
    OLED_spi_sendchar(0x07);
    OLED_SPI_STATUS = OLED_SPI_RELEASE;
    */

    // set page addressing
    OLED_SPI_STATUS = OLED_SPI_SELECT;
    OLED_DC = 0;
    OLED_spi_sendchar(0x20);
    OLED_spi_sendchar(0x02);
//    OLED_SPI_STATUS = OLED_SPI_RELEASE;
    // set addressing parameters for Horizontal/vertical addressing
    OLED_SPI_STATUS = OLED_SPI_SELECT;
    OLED_DC = 0;
    OLED_spi_sendchar(0xB0);  // start page 0
//    OLED_SPI_STATUS = OLED_SPI_RELEASE;

    
    
}


void OLED_off(void)
{
   
    // Display OFF
    OLED_SPI_STATUS = OLED_SPI_SELECT;
    OLED_DC = 0;
    OLED_spi_sendchar(0xAE);
    OLED_SPI_STATUS = OLED_SPI_RELEASE;
    
    // power off VBAT
    OLED_VBATC = 1;
    

    wait_ms(100);
    
    // power off VDD
    OLED_VDDC = 1;
}

void fake_OLED_init(void)
{
    char i;
    unsigned short LEDs;

    // Delay
    LEDs = 0;
    for (i=0; i<16; i++)
    {
        LEDs = LEDs + LEDs + 1;
        NEX4_LED_LSB_OUT = LEDs;
        NEX4_LED_MSB_OUT = (LEDs >> 8);
        wait_ms(20);
    }
    
}

void fake_OLED_off(void)
{
    char i;
    unsigned short LEDs;

    // wait 100ms
    LEDs = 0xFFFF;
    for (i=0; i<16; i++)
    {
        LEDs >>= 1;
        NEX4_LED_LSB_OUT = LEDs;
        NEX4_LED_MSB_OUT = (LEDs >> 8);
        wait_ms(20);
    }
}


void main (void)			
{ 
    unsigned short n;
    char c;
    char command;
    short addr;
    c=0;
    n=0;
    init ();
    OLED_init();
    OLED_DC = 1;
    while (1)
    {
        command = 0;
        if (UART_RXRDY) { command = UART_RXR; }
          
        if (command == 'R')
        {
            OLED_off();
            NEX4_7SEG_VAL = 0xBF;
            NEX4_7SEG_SEL = 0x00;
            RAM_MODE = 0;
        }
        if (command == 'F')
        {
            for (addr=1024; addr<2048; addr++)
            {
                CODE_ADDR   = addr;
                CODE_DATA_L = getbyte();
            }
        }
        if (command == 'T')
        {
            c = recv_char();
            addr = 1024 + ((short)c)*8;
            OLED_SPI_STATUS = OLED_SPI_SELECT;
            for (c=0; c<8; c++)
            {
                CODE_ADDR = addr;
                addr++;
                OLED_spi_sendchar(CODE_DATA_L);
                
            }
//            OLED_SPI_STATUS = OLED_SPI_RELEASE;      
        }
        if (command == 'C')
        {
            OLED_DC = 0;
            OLED_SPI_STATUS = OLED_SPI_SELECT;
            OLED_spi_sendchar(0x81);
            OLED_spi_sendchar(getbyte());
//            OLED_SPI_STATUS = OLED_SPI_RELEASE;
            OLED_DC = 1;
        }


/*
        n++;
        OLED_SPI_STATUS = OLED_SPI_SELECT;
        OLED_spi_sendchar(c);
        OLED_SPI_STATUS = OLED_SPI_RELEASE;
        if (n > 64)
        {
            c= c^0xFF;
            n=0;
            if (c) { n++; }
        }
        wait_us(100);
*/
    }
}
