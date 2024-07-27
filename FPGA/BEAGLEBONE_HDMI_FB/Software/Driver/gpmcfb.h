/*
 * linux/include/video/gpmcfb.h -- FB driver for gpmc LCD controller
 *
 * Copyright (C) 2011, Matt Porter
 *
 * This file is subject to the terms and conditions of the GNU General Public
 * License. See the file COPYING in the main directory of this archive for
 * more details.
 */

#define DRVNAME		"gpmcfb"
//#define WIDTH		640
#define WIDTH		800
#define HEIGHT		480
#define BPP		16

/* Supported display modules */
#define gpmc_DISPLAY_AF_TFT18		0	/* Adafruit SPI TFT 1.8" */

/* Init script function */
/*
struct gpmc_function {
	u16 cmd;
	u16 data;
};
*/
/* Init script commands */
/*
enum gpmc_cmd {
	gpmc_START,
	gpmc_END,
	gpmc_CMD,
	gpmc_DATA,
	gpmc_DELAY
};
*/

/*
struct gpmcfb_par {
	struct spi_device *spi;
	struct fb_info *info;
	u16 *ssbuf;
	int rst;
	int dc;
};
*/
struct gpmcfb_par {
	struct device *dev;
	struct fb_info *info;
	unsigned long gpmc_adr;
	//u16 *ssbuf;
};

/*
struct gpmcfb_platform_data {
	int rst_gpio;
	int dc_gpio;
};
*/




/* gpmc Commands */
/*
#define gpmc_NOP	0x0
#define gpmc_SWRESET	0x01
#define gpmc_RDDID	0x04
#define gpmc_RDDST	0x09
#define gpmc_SLPIN	0x10
#define gpmc_SLPOUT	0x11
#define gpmc_PTLON	0x12
#define gpmc_NORON	0x13
#define gpmc_INVOFF	0x20
#define gpmc_INVON	0x21
#define gpmc_DISPOFF	0x28
#define gpmc_DISPON	0x29
#define gpmc_CASET	0x2A
#define gpmc_RASET	0x2B
#define gpmc_RAMWR	0x2C
#define gpmc_RAMRD	0x2E
#define gpmc_COLMOD	0x3A
#define gpmc_MADCTL	0x36
#define gpmc_FRMCTR1	0xB1
#define gpmc_FRMCTR2	0xB2
#define gpmc_FRMCTR3	0xB3
#define gpmc_INVCTR	0xB4
#define gpmc_DISSET5	0xB6
#define gpmc_PWCTR1	0xC0
#define gpmc_PWCTR2	0xC1
#define gpmc_PWCTR3	0xC2
#define gpmc_PWCTR4	0xC3
#define gpmc_PWCTR5	0xC4
#define gpmc_VMCTR1	0xC5
#define gpmc_RDID1	0xDA
#define gpmc_RDID2	0xDB
#define gpmc_RDID3	0xDC
#define gpmc_RDID4	0xDD
#define gpmc_GMCTRP1	0xE0
#define gpmc_GMCTRN1	0xE1
#define gpmc_PWCTR6	0xFC
*/



