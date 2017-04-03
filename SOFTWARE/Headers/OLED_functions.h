// Projet OLED PR214
// Xavier Marino, Clovis Durand
// Ecdt : Y. Bornat
// 2017

#ifndef FUNCTIONLIB_H
#define FUNCTIONLIB_H

//#include <string.h>

// Si on ne redeclare pas le typedef ici, erreur de compil
// Pourquoi ?
//typedef unsigned char uChar;		// uChar means uChar (8-bit)
//typedef unsigned short int uInt;

interrupt void IT(void);
uChar recv_char(void); // recieve Char de la part de l'ordi
void send_char(uChar c); // Envoie Char a l'ordi - code ASCII
void send_string(const char s[], int len);
void send_hex(uChar c); // Envoie un octet en hexa a l'ordi
void send_nl(void); // newline - saut a la ligne
uChar gethex(void); // permet de recevoir de l'hexa, entre 0 et 15
uChar getbyte(void); // permet de recevoir de l'hexa, entre 0 et 255
uChar OLED_spi_exc(uChar c); // envoie une donnée et lit la donnée simultanement
uChar OLED_spi_getchar(void); // Envoie "VOID" et lit la reponse. // Warning : Pour l'instant envoie 0xFF. Vérifier que cela signifie bien "VOID"
void OLED_spi_sendchar(uChar c); // envoie un octet sur le SPI en ignorant la reponse
void wait_c_us(uChar i);
void wait_us(unsigned short int i);
void wait_ms(unsigned short int i);
void waitnl(void);
void init(void);
void clearScreen(void);
void drawLine(uChar sCol, uChar sRow, uChar eCol, uChar eRow, uChar r, uChar g, uChar b);
void drawRect(uChar sCol, uChar sRow, uChar eCol, uChar eRow, uChar r_out, uChar g_out, uChar b_out, uChar r_in, uChar g_in, uChar b_in);
void setPixelAddr(uChar col, uChar row);
void setPixelAddrTo0(void);
void writePixel(uChar c1, uChar c2);
void writePixels(uChar c1, uChar c2);
void writePixels2(uChar c1, uChar c2);

#endif