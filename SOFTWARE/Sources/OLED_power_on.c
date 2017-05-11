// Projet OLED PR214
// Xavier Marino, Clovis Durand
// Ecdt : Y. Bornat
// 2017

#include "../Headers/def.h"


void init_OLED(void)
// fonction d'initialisation de l'OLED
{
	OLED_SPI_STATUS = OLED_SPI_SELECT;
	// Bring Data/Command control (pin 7) logic low
	OLED_DC = CLEAR;
	send_char('1');
	send_nl();

	// Bring the CLEAR pin (pin 8) logic high
	OLED_RES = SET;
	send_char('2');
	send_nl();

	// Bring the Vcc Enable (pin 9) logic low 
	// VCC controlé par VCCEN ie VBATC
	OLED_VBATC = CLEAR;
	send_char('3');
	send_nl();

	// Bring Pmod Enable (pin 10) to logic high and delay 20 ms to allow the 3.3V rail to become stable 
	//VDDC ie Pmod Enable controle VDD/VDDIO
	OLED_VDDC = SET;
	wait_ms(100);
	send_char('4');
	send_nl();

	// Bring RES (pin 8) logic low, wait for at least 3 us, 
	// and then bring it back to logic high to CLEAR the display controller
	OLED_RES = CLEAR;
	wait_us(15); // On majore 3us par 5us
	OLED_RES = SET;
	send_char('5');
	send_nl();

	// Wait for the CLEAR display operation to complete; 
	// this takes a maximum of 3 us to complete
	wait_us(15); // On majore 3us par 5us
	send_char('6');
	send_nl();

	// Enable the driver IC to accept commands by sending the unlock command over SPI – 0xFD, 0x12
	OLED_spi_sendchar(0xFD); //MISO = 0xFD;

	OLED_spi_sendchar(0x12); //MISO = 0x12;
	send_char('7');
	send_nl();


	// Send the display off command – 0xAE
	OLED_spi_sendchar(0xAE); // Display Off (Sleep Mode)
	send_char('8');
	send_nl();


	// Set the Remap and Data formats – 0xA0, 0x72 for setting 
	// the orientation of how the controller interfaces with the display. 
	//Page 29 of the datasheet lists the 7 options that are affected by this command.
		// -DATASHEET- : After VCC become stable, send command AFh for display ON

	if (!LEFT_O)
	{	// For Right side screen
		OLED_spi_sendchar(0xA0); // -DATASHEET- : Commencer par cette commande avant de regler REMAP
		OLED_spi_sendchar(0x72); // 0111 0010
		/* -DATASHEET- : A[7:6] = 01; 65k color format
						 A[5]=1, Enable COM Split Odd Even
						 A[4]=1, Scan from COM [N-1] to COM0. Where N is the multiplex ratio.
						 A[3]=0, Disable left-right swapping on COM
						 A[2]=0, normal order SA,SB,SC (e.g. RGB)
						 A[1]=1, RAM Column 0 to 95 maps to Pin Seg (SA,SB,SC) 95 to 0
						 A[0]=0, Horizontal address increment*/
	}
	else
	{	// For Left side screen
		OLED_spi_sendchar(0xA0);
		OLED_spi_sendchar(0x60); // 0110 0000
		/* -DATASHEET- : A[7:6] = 01; 65k color format
						 A[5]=1, Enable COM Split Odd Even
						 A[4]=0, Scan from COM [N-1] to COM0. Where N is the multiplex ratio.	// -------- Changement -------- //
						 A[3]=0, Enable left-right swapping on COM 								// -------- Changement -------- //
						 A[2]=0, normal order SA,SB,SC (e.g. RGB)
						 A[1]=0, RAM Column 0 to 95 maps to Pin Seg (SA,SB,SC) 95 to 0
						 A[0]=0, Horizontal address increment*/
	}
	send_char('9');
	send_nl();

	// Set the Display start Line – 0xA1, 0x00 to set the starting line in the upper left corner
	OLED_spi_sendchar(0xA1); 
	OLED_spi_sendchar(0x00); // Start line register at 0. 
	send_char('1');
	send_char('0');
	send_nl();

	// Set the Display Offset – 0xA2, 0x00 for no offset
	OLED_spi_sendchar(0xA2);
	OLED_spi_sendchar(0X00); // No offset
	send_char('1');
	send_char('1');
	send_nl();

	// Make it a normal display – 0xA4 for a normal display, i.e. no funky settings like all pixels being on/off or the color inverted
	OLED_spi_sendchar(0xA4); // Normal Display
	send_char('1');
	send_char('2');
	send_nl();

	// Set the Multiplex Ratio – 0xA8, 0x3F to enable all of the common pins
	OLED_spi_sendchar(0xA8);
	OLED_spi_sendchar(0x3F);
	send_char('1');
	send_char('3');
	send_nl();

	// Set Master Configuration – 0xAD, 0x8E to force bit 0 of this register to be a zero after a CLEAR to make the datasheet happy
	OLED_spi_sendchar(0xAD);
	OLED_spi_sendchar(0x8E); //A[0]=0b, Select external VCC supply
	send_char('1');
	send_char('4');
	send_nl();

	// Set Power Saving Mode – 0xB0, 0x0B to disable power saving mode
	OLED_spi_sendchar(0xB0);
	OLED_spi_sendchar(0x0B); // Disable power saving mode
	send_char('1');
	send_char('5');
	send_nl();

	// Set Phase Length – 0xB1, 0x31 to set the period of the display clock (DCLK) 
	// where the lower four bits set the period of phase 1 in units of DCLK 
	// to discharge the previous charge in an OLED pixel and the upper four bits 
	// set the period of phase 2 in units of DCLK to charge an OLED pixel to 
	// an initial pre-charge voltage. See page 26 of the datasheet for more details
	OLED_spi_sendchar(0xB1);
	OLED_spi_sendchar(0x31);
	send_char('1');
	send_char('6');
	send_nl();



	// Set the Display Clock Divide Ratio and Oscillator Frequency 
	// – 0xB3, 0xF0 to set the oscillator frequency to the maximum value 
	// in the upper four bits (Figure 28, pg 26 of the datasheet for 
	// an approximate value) and set the display clock divide ratio to 1 
	// via the lower four bits (clock divider calculated by 
	// lower four bits + 1 for a divide ratio between 1 and 16)
	OLED_spi_sendchar(0xB3);
	OLED_spi_sendchar(0xF0);
	send_char('1');
	send_char('7');
	send_nl();


	// Set the Second Pre-Charge Speed of Color A¹ 
	// – 0x8A, 0x64 to set the period of phase 3 to drive color A, 
	//red by default, to a target driving voltage
	OLED_spi_sendchar(0x8A);
	OLED_spi_sendchar(0x64);
	send_char('1');
	send_char('8');
	send_nl();


	// Set the Second Pre-Charge Speed of Color B¹ 
	// – 0x8B, 0x78 to set the period of phase 3 
	// to drive color B, green by default, to a target driving voltage
	OLED_spi_sendchar(0x8B);
	OLED_spi_sendchar(0x78);
	send_char('1');
	send_char('9');
	send_nl();

	// Set the Second Pre-Charge Speed of Color C¹ 
	// – 0x8C, 0x64 to set the period of phase 3 to drive color C, 
	// blue by default, to a target driving voltage
	OLED_spi_sendchar(0x8C);
	OLED_spi_sendchar(0x64);
	send_char('2');
	send_char('0');
	send_nl();


	// Set the Pre-Charge Voltage 
	// – 0xBB, 0x3A to set the precharge driving voltage 
	// referenced multiple times previously to approximately
	// 45% of Vcc
	OLED_spi_sendchar(0xBB);
	OLED_spi_sendchar(0x3A);
	send_char('2');
	send_char('1');
	send_nl();

	// Set the VCOMH Deselect Level 
	// – 0xBE, 0x3E to set the deselection voltage level 
	// of the common pins to 83% of Vcc
	OLED_spi_sendchar(0xBE);
	OLED_spi_sendchar(0x3E);
	send_char('2');
	send_char('2');
	send_nl();

	// Set Master Current Attenuation Factor 
	// (0x87, 0x06 to set a scaling factor of 6 
	// to control the amount of reference current 
	// for the segment current drivers. 
	// See page 23 of the datasheet for the equation and more details.
	OLED_spi_sendchar(0x87);
	OLED_spi_sendchar(0x06);
	send_char('2');
	send_char('3');
	send_nl();

	// Set the Contrast for Color A 
	// – 0x81, 0x91 to set a contrast value 
	// of 0x91 (out of 0xFF) for color A (default red) 
	// effectively setting the brightness level. 
	// See page 23 of the datasheet for the equation and more details.
	OLED_spi_sendchar(0x81);
	OLED_spi_sendchar(0xFF);
	send_char('2');
	send_char('4');
	send_nl();

	// Set the Contrast for Color A 
	// – 0x82, 0x50 to set a contrast value 
	// of 0x50 (out of 0xFF) for color B (default green) 
	//effectively setting the brightness level. 
	//See page 23 of the datasheet for the equation and more details.
	OLED_spi_sendchar(0x82);
	OLED_spi_sendchar(0xFF);
	send_char('2');
	send_char('5');
	send_nl();

	// Set the Contrast for Color A
	// – 0x83, 0x7D to set a contrast value 
	// of 0x7D (out of 0xFF) for color C (default blue) 
	// effectively setting the brightness level. 
	// See page 23 of the datasheet for the equation and more details.
	OLED_spi_sendchar(0x83);
	OLED_spi_sendchar(0xFF);
	send_char('2');
	send_char('6');
	send_nl();

	// Disable Scrolling – 0x2E
	OLED_spi_sendchar(0x2E);
	send_char('2');
	send_char('7');
	send_nl();

	// Enable Fill for rectangle
	OLED_spi_sendchar(0x26);
	OLED_spi_sendchar(0x01);
	send_char('2');
	send_char('8');
	send_nl();

	// Clear the screen
	//  – 0x25, 0x00, 0x00, 0x5F, 0x3F to send the clear window command 
	// and then define the window size 
	// (col start, row start, col end, row end)
	OLED_spi_sendchar(0x25);
	OLED_spi_sendchar(0x00);
	OLED_spi_sendchar(0x00);
	OLED_spi_sendchar(0x5F);
	OLED_spi_sendchar(0x3F);
	send_char('2');
	send_char('9');
	send_nl();

	// Bring VCCEN (pin 9) logic high and wait 25 ms
	OLED_VBATC = SET;
	wait_ms(125);
	send_char('3');
	send_char('0');
	send_nl();

	// Turn the display on (0xAF) 
	// and wait at least 100 ms before further operation
	OLED_spi_sendchar(0xAF);
	wait_ms(200);
	send_char('3');
	send_char('1');
	send_nl();

	// Note¹ – when changing any of the second pre-charge speeds, all three registers must be updated sequentially with 6 bytes total (address A, value A, address B, value B, address C, value C), even if their values do not change.

	send_char('F');
	send_char('i');
	send_char('n');
	send_char(' ');
	send_char('I');
	send_char('n');
	send_char('i');
	send_char('t');
	send_char(' ');
	send_char('O');
	send_char('L');
	send_char('E');
	send_char('D');
	send_char(' ');
	send_nl();

}