// Projet OLED PR214
// Xavier Marino, Clovis Durand
// Ecdt : Y. Bornat
// 2017

#include "../Headers/def.h"

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

// Pour ecrire un pixel rgb, on utilise 16 bits : 0b rrrr rggg gggb bbbb
// Red   : 0xF800
// Green : 0x07E0
// Blue  : 0x001F

int main()
{
	uChar a;
	uChar command;
	init();
	init_OLED();

	clearScreen();
	wait_ms(50);
	setPixelAddrTo0(); // Reinitialisation de l'addresse d'ecriture

	// Test ecriture pixel
	/*writePixel(0xF8, 0x00);
    setPixelAddrTo0();*/

	// Test de drawline
/*	drawRect(0x00, 0x00, 0x5F, 0x3F, 0x00, 0x00, 0xFF, 0x00, 0xFF, 0x00);
	drawLine(0x01, 0x01, 0x5E, 0x3E, 0xFF, 0x00, 0x00);*/

	while (1)
	{
		command = 0;
		if (UART_RXRDY) command = UART_RXR;
		  
		if (command == 'R') 
		// Reset du systeme. Ne veut pas dire qu'on reset notre programme. 
		{
			//OLED_off();
			NEX4_7SEG_VAL = 0xBF;
			NEX4_7SEG_SEL = 0x00;
			RAM_MODE = 0;
		}
		if (command == 'I')
		// Envoi d'un fichier text contenant les données du bitmap en mode 65k
		{
			clearScreen();

			send_char('S');
			send_char('e');
			send_char('n');
			send_char('d');
			send_char(' ');
			send_char('b');
			send_char('i');
			send_char('t');
			send_char('m');
			send_char('a');
			send_char('p');
			send_char(' ');
			send_char('T');
			send_char('e');
			send_char('x');
			send_char('t');
			send_char('f');
			send_char('i');
			send_char('l');
			send_char('e');
			send_nl();

			OLED_DC = SET;
			for (int i = 0; i < 6144*2; i++)
			//while(1)
			{
				a = getbyte();
				OLED_spi_sendchar(a);
			}
			OLED_DC = CLEAR;
			send_char('D');
			send_char('O');
			send_char('N');
			send_char('E');
			send_nl();
			setPixelAddrTo0();
		}
		if (command == 'T')
		// Pour ecrire du texte sur l'écran
		{

		}
		if (command == 'C')
		{
			clearScreen();
			send_char('S');
			send_char('c');
			send_char('r');
			send_char('e');
			send_char('e');
			send_char('n');

			send_char('C');
			send_char('l');
			send_char('e');
			send_char('a');
			send_char('r');
			send_char('e');
			send_char('d');
			send_nl();
		}

		
		/*writePixels(0xF8, 0x00);
		wait_ms(1000);
		writePixels(0x07, 0xE0);
		wait_ms(1000);*/
	}
}