// This file is a minimal bootlader for the SDSPI project (but may be reused)
// it is intended to be used with MPLAB X v3.05 and compiled with XC8 v1.35
// converted from Brainbow bootloader V1.3.9 by YB (2015/08/31)

#include	<pic.h>				//  macros
#define CLK_100MHZ
#include    "../Headers/OLED_up_header.h"	// SOC definitions


#define SOFT_VERSION    0x01 //V1.0

unsigned char tmpg;
unsigned char Display[8]; // Chacun des octet est une case de seven seg
unsigned char Disp_idx;
unsigned char sys_cnt;

unsigned char last_R7_resp[4];


#define OLED_SPI_SELECT  (SPI_SPEED_1_064MHz | 0x01)
#define OLED_SPI_RELEASE (SPI_SPEED_1_064MHz)
//#define OLED_SPI_SELECT  (SPI_SPEED_10_00MHz | 0x01)
//#define OLED_SPI_RELEASE (SPI_SPEED_10_00MHz)


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

unsigned char recv_char(void) // recieve Char de la part de l'ordi
{
	while (UART_RXRDY==0) {  }
	return(UART_RXR);
}

void send_char(unsigned char c) // Envoie Char a l'ordi - code ASCII
{
	while (UART_TXBSY==1) {  }
	UART_TXR = c;
}


void send_hex(unsigned char c) // Envoie un octet en hexa a l'ordi
{
	char n;
	n=(c>>4)+'0';
	if (n>'9') n=n+7;
	while (UART_TXBSY==1) {  }
	UART_TXR = n;
	n=(c & 0x0F)+'0';
	if (n>'9') n=n+7;
	while (UART_TXBSY==1) {  }
	UART_TXR = n;
}


void send_nl(void) // newline - saut a la ligne
{
    send_char(10);
    send_char(13);
}    

unsigned char gethex(void) // permet de recevoir de l'hexa, entre 0 et 15
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

unsigned char getbyte(void) // permet de recevoir de l'hexa, entre 0 et 255
{
	unsigned char tmp;
	tmp = gethex();
	tmp <<=4;
	return (tmp + gethex() );
}

unsigned char OLED_spi_exc(unsigned char c) // envoie une donnée et lit la donnée simultanement
{
    NEX4_RGBL0_RED = 1;
	OLED_SPI_FILE   = c;
	while (OLED_SPI_BSY) { }	
    NEX4_RGBL1_RED = 0;
    return OLED_SPI_FILE;
}

unsigned char OLED_spi_getchar(void) // Envoie "VOID" et lit la reponse. // Warning : Pour l'instant envoie 0xFF. Vérifier que cela signifie bien "VOID"
{
	OLED_SPI_FILE   = 0;
	while (OLED_SPI_BSY) { }	
    return OLED_SPI_FILE;
}

void OLED_spi_sendchar(unsigned char c) // envoie un octet sur le SPI en ignorant la reponse
{
	OLED_SPI_FILE   = c;
	while (OLED_SPI_BSY) { }	
    send_hex(c);
    send_char(' ');
    //send_char(c);
    //send_char(' ');
}


// Fonctions "wait". 

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
// Attention : une us est plus courte qu'une vraie us. (cf donction wait_ms)
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
// Attends que l'ordi ai envoyé un saut de ligne via UART. 
{	
	unsigned char c;
	do
	{
		c=recv_char();
	} while(c!=0x0A);
}



void init(void)
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

    // envoie "OLEDrgb \n" a l'ordinateur via UART pour debug.
    send_char('\n'); 
    send_char('0');
    send_char('L');
    send_char('E');
    send_char('D');
    send_char('r');
    send_char('g');
    send_char('b');
    send_nl();
    
}


void OLED_init(void)
// WARNING : ancienne commande d'init pour l'OLED monochrome. 
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
    
    // set mux ratio
    OLED_SPI_STATUS = OLED_SPI_SELECT;
    OLED_DC = 0;
    OLED_spi_sendchar(0xA8);
    OLED_spi_sendchar(0x3F);
    
    // set display offset
    OLED_SPI_STATUS = OLED_SPI_SELECT;
    OLED_DC = 0;
    OLED_spi_sendchar(0xD3);
    OLED_spi_sendchar(0x00);
    
    // Set display start line
    OLED_SPI_STATUS = OLED_SPI_SELECT;
    OLED_DC = 0;
    OLED_spi_sendchar(0x40);
    
    // set segment remap
    OLED_SPI_STATUS = OLED_SPI_SELECT;
    OLED_DC = 0;
    OLED_spi_sendchar(0xA0); // 0xA0 (left) or 0xA1 (right)

    // Set COM output scan direction
    OLED_SPI_STATUS = OLED_SPI_SELECT;
    OLED_DC = 0;
    OLED_spi_sendchar(0xC0); // 0xC8 OLED on the right / 0xC0 if OLED on the left (vertical twist)

    // set COM pins hardware configuration
    OLED_SPI_STATUS = OLED_SPI_SELECT;
    OLED_DC = 0;
    OLED_spi_sendchar(0xDA);
    OLED_spi_sendchar(0x02); //0x02 to display pages 4 to 7 / 0x22 to display pages 0 to 3
                             // switch values if screen on the left...

    // Set Contrast
    OLED_SPI_STATUS = OLED_SPI_SELECT;
    OLED_DC = 0;
    OLED_spi_sendchar(0x81);
    OLED_spi_sendchar(0x1F);

    // Disable entire Display ON
    OLED_SPI_STATUS = OLED_SPI_SELECT;
    OLED_DC = 0;
    OLED_spi_sendchar(0xA4); // A4:set / A5:disable

    // Set Normal Display 
    OLED_SPI_STATUS = OLED_SPI_SELECT;
    OLED_DC = 0;
    OLED_spi_sendchar(0xA6);
    
    // Set OSC freq.
    OLED_SPI_STATUS = OLED_SPI_SELECT;
    OLED_DC = 0;
    OLED_spi_sendchar(0xD5);
    OLED_spi_sendchar(0x80);

    // Enable Charge Pump Reg
    OLED_SPI_STATUS = OLED_SPI_SELECT;
    OLED_DC = 0;
    OLED_spi_sendchar(0x8D);
    OLED_spi_sendchar(0x14);    

    // set pre-charge pump
    OLED_SPI_STATUS = OLED_SPI_SELECT;
    OLED_DC = 0;
    OLED_spi_sendchar(0xD9);
    OLED_spi_sendchar(0xF1);    

    
    // here we should clear screen

    
    // Apply Power to VBAT
    OLED_VBATC = 0;
    
    // Delay 100ms
    wait_ms(100);
    
    
    
    
    // Display On
    OLED_SPI_STATUS = OLED_SPI_SELECT;
    OLED_DC = 0;
    OLED_spi_sendchar(0xAF);


    // set page addressing
    OLED_SPI_STATUS = OLED_SPI_SELECT;
    OLED_DC = 0;
    OLED_spi_sendchar(0x20);
    OLED_spi_sendchar(0x02);

    // set addressing parameters for Horizontal/vertical addressing
    OLED_SPI_STATUS = OLED_SPI_SELECT;
    OLED_DC = 0;
    OLED_spi_sendchar(0xB0);  // start page 0

    
    
}

void OLED_init_rgb(void)
{
    OLED_DC = 0;
    send_char('1');
    send_char(' ');
    send_char('\n');


    OLED_RES = 1;
    send_char('2');
    send_char(' ');
    send_char('\n');


    OLED_VBATC = 0;
    send_char('3');
    send_char(' ');
    send_char('\n');


    OLED_VDDC = 1;
    wait_ms(100);
    send_char('4');
    send_char(' ');
    send_char('\n');


    OLED_RES = 0;
    wait_us(15);
    OLED_RES = 1;
    send_char('5');
    send_char(' ');
    send_char('\n');

    wait_us(15);
    send_char('6');
    send_char(' ');
    send_char('\n');

    OLED_SPI_STATUS = OLED_SPI_SELECT;
    OLED_DC = 0;
    OLED_spi_sendchar(0xFD);
    OLED_spi_sendchar(0x12);
    send_char('7');
    send_char(' ');
    send_char('\n');

    OLED_SPI_STATUS = OLED_SPI_SELECT;
    OLED_DC = 0;
    OLED_spi_sendchar(0xAE);
    send_char('8');
    send_char(' ');
    send_char('\n');

    OLED_SPI_STATUS = OLED_SPI_SELECT;
    OLED_DC = 0;
    OLED_spi_sendchar(0xA0);
    OLED_spi_sendchar(0x72);
    send_char('9');
    send_char(' ');
    send_char('\n');

    OLED_SPI_STATUS = OLED_SPI_SELECT;
    OLED_DC = 0;
    OLED_spi_sendchar(0xA1);
    OLED_spi_sendchar(0x00);
    send_char('1');
    send_char('0');
    send_char(' ');
    send_char('\n');

    OLED_SPI_STATUS = OLED_SPI_SELECT;
    OLED_DC = 0;
    OLED_spi_sendchar(0xA2);
    OLED_spi_sendchar(0x00);
    send_char('1');
    send_char('1');
    send_char(' ');
    send_char('\n');

    OLED_SPI_STATUS = OLED_SPI_SELECT;
    OLED_DC = 0;
    OLED_spi_sendchar(0xA4);
    send_char('1');
    send_char('2');
    send_char(' ');
    send_char('\n');

    OLED_SPI_STATUS = OLED_SPI_SELECT;
    OLED_DC = 0;
    OLED_spi_sendchar(0xA8);
    OLED_spi_sendchar(0x3F);
    send_char('1');
    send_char('3');
    send_char(' ');
    send_char('\n');

    OLED_SPI_STATUS = OLED_SPI_SELECT;
    OLED_DC = 0;
    OLED_spi_sendchar(0xAD);
    OLED_spi_sendchar(0x8E);
    send_char('1');
    send_char('4');
    send_char(' ');
    send_char('\n');

    OLED_SPI_STATUS = OLED_SPI_SELECT;
    OLED_DC = 0;
    OLED_spi_sendchar(0xB0);
    OLED_spi_sendchar(0x0B);
    send_char('1');
    send_char('5');
    send_char(' ');
    send_char('\n');

    OLED_SPI_STATUS = OLED_SPI_SELECT;
    OLED_DC = 0;
    OLED_spi_sendchar(0xB1);
    OLED_spi_sendchar(0x31);
    send_char('1');
    send_char('6');
    send_char(' ');
    send_char('\n');

    OLED_SPI_STATUS = OLED_SPI_SELECT;
    OLED_DC = 0;
    OLED_spi_sendchar(0xB3);
    OLED_spi_sendchar(0xF0);
    send_char('1');
    send_char('7');
    send_char(' ');
    send_char('\n');

    OLED_SPI_STATUS = OLED_SPI_SELECT;
    OLED_DC = 0;
    OLED_spi_sendchar(0x8A);
    OLED_spi_sendchar(0x64);
    send_char('1');
    send_char('8');
    send_char(' ');
    send_char('\n');

    OLED_SPI_STATUS = OLED_SPI_SELECT;
    OLED_DC = 0;
    OLED_spi_sendchar(0x8B);
    OLED_spi_sendchar(0x78);
    send_char('1');
    send_char('9');
    send_char(' ');
    send_char('\n');

    OLED_SPI_STATUS = OLED_SPI_SELECT;
    OLED_DC = 0;
    OLED_spi_sendchar(0x8C);
    OLED_spi_sendchar(0x64);
    send_char('2');
    send_char('0');
    send_char(' ');
    send_char('\n');

    OLED_SPI_STATUS = OLED_SPI_SELECT;
    OLED_DC = 0;
    OLED_spi_sendchar(0xBB);
    OLED_spi_sendchar(0x3A);
    send_char('2');
    send_char('1');
    send_char(' ');
    send_char('\n');

    OLED_SPI_STATUS = OLED_SPI_SELECT;
    OLED_DC = 0;
    OLED_spi_sendchar(0xBE);
    OLED_spi_sendchar(0x3E);
    send_char('2');
    send_char('2');
    send_char(' ');
    send_char('\n');

    OLED_SPI_STATUS = OLED_SPI_SELECT;
    OLED_DC = 0;
    OLED_spi_sendchar(0x87);
    OLED_spi_sendchar(0x06);
    send_char('2');
    send_char('3');
    send_char(' ');
    send_char('\n');

    OLED_SPI_STATUS = OLED_SPI_SELECT;
    OLED_DC = 0;
    OLED_spi_sendchar(0x81);
    OLED_spi_sendchar(0x91);
    send_char('2');
    send_char('4');
    send_char(' ');
    send_char('\n');

    OLED_SPI_STATUS = OLED_SPI_SELECT;
    OLED_DC = 0;
    OLED_spi_sendchar(0x82);
    OLED_spi_sendchar(0x50);
    send_char('2');
    send_char('5');
    send_char(' ');
    send_char('\n');

    OLED_SPI_STATUS = OLED_SPI_SELECT;
    OLED_DC = 0;
    OLED_spi_sendchar(0x83);
    OLED_spi_sendchar(0x7D);
    send_char('2');
    send_char('6');
    send_char(' ');
    send_char('\n');

    OLED_SPI_STATUS = OLED_SPI_SELECT;
    OLED_DC = 0;
    OLED_spi_sendchar(0x25);
    send_char('2');
    send_char('7');
    send_char(' ');
    send_char('\n');

    OLED_SPI_STATUS = OLED_SPI_SELECT;
    OLED_DC = 0;
    OLED_spi_sendchar(0x25);
    OLED_spi_sendchar(0x00);
    OLED_spi_sendchar(0x00);
    OLED_spi_sendchar(0x5F);
    OLED_spi_sendchar(0x3F);
    send_char('2');
    send_char('8');
    send_char(' ');
    send_char('\n');

    OLED_VBATC = 1;
    wait_ms(125);
    send_char('2');
    send_char('9');
    send_char(' ');
    send_char('\n');

    OLED_SPI_STATUS = OLED_SPI_SELECT;
    OLED_DC = 0;
    OLED_spi_sendchar(0xAF);
    send_char('3');
    send_char('0');
    send_char(' ');
    send_char('\n');

    wait_ms(500);

    OLED_SPI_STATUS = OLED_SPI_SELECT;
    OLED_DC = 0;
    OLED_spi_sendchar(0x82);
}

void main (void)			
{ 

    char command;
    init();
   // OLED_SPI_STATUS = OLED_SPI_SELECT;
/*    while(1)
    {

    //OLED_SPI_STATUS = OLED_SPI_RELEASE;
    //wait_ms(1000);
    //OLED_SPI_STATUS = OLED_SPI_SELECT;
    OLED_spi_sendchar(0x00);
    wait_ms(1000);
    //OLED_SPI_STATUS = OLED_SPI_RELEASE;
    //wait_ms(1000);
    //OLED_SPI_STATUS = OLED_SPI_SELECT;
    OLED_spi_sendchar(0xFF);
    wait_ms(1000);
    }*/

    //OLED_DC = 0;
    //OLED_spi_sendchar(0x2E);
    OLED_init_rgb();

    OLED_DC = 1;
    while (1)
    {
        command = 0;
        if (UART_RXRDY) { command = UART_RXR; }
          
        if (command == 'R') 
        // Reset du systeme. Ne veut pas dire qu'on reset notre programme. 
        {
            //OLED_off();
            NEX4_7SEG_VAL = 0xBF;
            NEX4_7SEG_SEL = 0x00;
            RAM_MODE = 0;
        }




    }
}
