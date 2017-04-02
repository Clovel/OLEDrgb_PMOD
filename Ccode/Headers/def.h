// Projet OLED PR214
// Xavier Marino, Clovis Durand
// Ecdt : Y. Bornat
// 2017

#ifndef DEF_H
#define DEF_H

#define CLK_100MHZ

#define SOFT_VERSION    0x01 //V1.0

#include <pic.h>
#include "OLED_up_header.h"
//#include <string.h>

#define SET  	1       // Allow ENABLE to equal 1.
#define CLEAR	0		// Allow DISABLE to equal 0.

#define OLED_SPI_SELECT  (SPI_SPEED_25_00MHz | 0x01) //(SPI_SPEED_1_064MHz | 0x01)
#define OLED_SPI_RELEASE (SPI_SPEED_25_00MHz)        //(SPI_SPEED_1_064MHz)

#define LEFT_O 1 // 0 pour cote droit, 1 cote gauche de la carte 

typedef unsigned char uChar;		// uChar means unsigned Char (8-bit)
typedef unsigned short int uInt;	// uInt means unsigned short Int (16-bit)

volatile uChar tmpg;
volatile uChar Display[8]; // Chacun des octet est une case de seven seg
volatile uChar Disp_idx;
volatile uChar sys_cnt;

volatile uChar last_R7_resp[4];

// A mettre en dernier pour 
#include "OLED_power_on.h"
#include "OLED_functions.h"

#endif

