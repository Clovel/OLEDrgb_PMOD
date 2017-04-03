// Projet OLED PR214
// Xavier Marino, Clovis Durand
// Ecdt : Y. Bornat
// 2017

#include "../Headers/def.h"

uChar recv_char(void) // receive Char de la part de l'ordi
{
	while (UART_RXRDY==0) {  }
	return(UART_RXR);
}

void send_char(uChar c) // Envoie Char a l'ordi - code ASCII
{
	while (UART_TXBSY==1) {  }
	UART_TXR = c;
}

void send_hex(uChar c) // Envoie un octet en hexa a l'ordi
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

uChar gethex(void) // permet de recevoir de l'hexa, entre 0 et 15
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

uChar getbyte(void) // permet de recevoir de l'hexa, entre 0 et 255
{
	uChar tmp;
	tmp = gethex();
	tmp <<=4;
	return (tmp + gethex() );
}

uChar OLED_spi_exc(uChar c) // envoie une donnée et lit la donnée simultanement
{
    NEX4_RGBL0_RED = 1;
	OLED_SPI_FILE   = c;
	while (OLED_SPI_BSY) { }	
    NEX4_RGBL1_RED = 0;
    return OLED_SPI_FILE;
}

uChar OLED_spi_getchar(void) // Envoie "VOID" et lit la reponse. // Warning : Pour l'instant envoie 0xFF. Vérifier que cela signifie bien "VOID"
{
	OLED_SPI_FILE   = 0;
	while (OLED_SPI_BSY) { }	
    return OLED_SPI_FILE;
}

void OLED_spi_sendchar(uChar c) // envoie un octet sur le SPI en ignorant la reponse
{
	OLED_SPI_FILE   = c;
	while (OLED_SPI_BSY) { }	
}


// Fonctions "wait". 

void wait_c_us(uChar i)
{
    char c;
    c=i;
    while (c>0)
      {
      c--;
      asm("CLRWDT");
      }
}



void wait_us(uInt i)
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


void wait_ms(uInt i)
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
	uChar c;
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
    send_char('O');
    send_char('L');
    send_char('E');
    send_char('D');
    send_char('r');
    send_char('g');
    send_char('b');
    send_nl();
    
}

void clearScreen(void)
{
    // D/C = 0, R/W = 0
    OLED_DC = CLEAR;

    // Commande de ClearScreen
    OLED_spi_sendchar(0x25); // Start of clear command
    OLED_spi_sendchar(0x00); // A[6:0]: Column Address of Start
    OLED_spi_sendchar(0x00); // B[5:0]: Row Address of Start
    OLED_spi_sendchar(0x5F); // C[6:0]: Column Address of End
    OLED_spi_sendchar(0x3F); // D[5:0]: Row Address of End
}

void drawLine(uChar sCol, uChar sRow, uChar eCol, uChar eRow, uChar r, uChar g, uChar b)
{
    OLED_DC = CLEAR;
    OLED_spi_sendchar(0x21);
    OLED_spi_sendchar(sCol);
    OLED_spi_sendchar(sRow);
    OLED_spi_sendchar(eCol);
    OLED_spi_sendchar(eRow);
    OLED_spi_sendchar(r);
    OLED_spi_sendchar(g);
    OLED_spi_sendchar(b);
    wait_ms(1);
}

void drawRect(uChar sCol, uChar sRow, uChar eCol, uChar eRow, uChar r_out, uChar g_out, uChar b_out, uChar r_in, uChar g_in, uChar b_in)
{
    OLED_DC = CLEAR;
    OLED_spi_sendchar(0x22);
    OLED_spi_sendchar(sCol);
    OLED_spi_sendchar(sRow);
    OLED_spi_sendchar(eCol);
    OLED_spi_sendchar(eRow);
    OLED_spi_sendchar(r_out);
    OLED_spi_sendchar(g_out);
    OLED_spi_sendchar(b_out);
    OLED_spi_sendchar(r_in);
    OLED_spi_sendchar(g_in);
    OLED_spi_sendchar(b_in);
    wait_ms(1);
}

void setPixelAddr(uChar col, uChar row)
{
    OLED_DC = CLEAR; // Command Mode
    OLED_spi_sendchar(0x15); // Set Column
    OLED_spi_sendchar(col); // Set Column end to 
    OLED_spi_sendchar(0x5F);
    OLED_spi_sendchar(0x75); // Set Row
    OLED_spi_sendchar(row); // Set Row to 
    OLED_spi_sendchar(0x3F);
}

void setPixelAddrTo0(void)
{
    setPixelAddr(0x00, 0x00);
}

// Pour ecrire un pixel rgb, on utilise 16 bits : 0b rrrr rggg gggb bbbb
// Red   : 0xF800
// Green : 0x07E0
// Blue  : 0x001F

void writePixel(uChar c1, uChar c2)
{
    setPixelAddrTo0();
    OLED_DC = SET;
    OLED_spi_sendchar(c1); 
    OLED_spi_sendchar(c2);
    OLED_DC = CLEAR;
}

void writePixels(uChar c1, uChar c2)
{
    setPixelAddrTo0();
    OLED_DC = SET;

    for (int i = 0; i < 6144; i++)
    {
        OLED_spi_sendchar(c1); 
        OLED_spi_sendchar(c2);
    }
    OLED_DC = CLEAR;
}