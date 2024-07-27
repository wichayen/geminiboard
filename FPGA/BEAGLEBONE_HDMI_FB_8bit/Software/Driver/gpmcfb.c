/*
 * linux/drivers/video/gpmcfb.c -- FB driver for gpmc LCD controller
 * Layout is based on skeletonfb.c by James Simmons and Geert Uytterhoeven.
 *
 * Copyright (C) 2011, Matt Porter
 *
 * This file is subject to the terms and conditions of the GNU General Public
 * License. See the file COPYING in the main directory of this archive for
 * more details.
 
 
/drivers/video/Kconfig
1. add

config gpmcfb
       bool "beaglebone gpmcfb"
       default n
       ---help---
       for beaglebone gpmcfb.
       
       
       
add Makefile

 
2. On menuconfig
Select the Displaylink display driver
 ( Device Drivers-> Graphics support -> Support for frame buffer devices-> Displaylink USB Framebuffer 
 
note :  Displaylink USB Framebuffer will enable config FB_VIRTUAL -> (for using sys_fillrect, etc)
 

 
 
 
 
 
 */

#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/errno.h>
#include <linux/string.h>
#include <linux/mm.h>
#include <linux/vmalloc.h>
#include <linux/slab.h>
#include <linux/init.h>
#include <linux/fb.h>
#include <linux/gpio.h>
//#include <linux/spi/spi.h>
#include <linux/delay.h>
#include <linux/uaccess.h>
#include <linux/platform_device.h>


#include <plat/board.h>
#include <plat/gpmc.h>

#include "gpmcfb.h"

//#define	GPMC_WR_SIZE	128

/*
static struct gpmc_timings fpga_timings = {

     .sync_clk   = 0, //mininum clock peroid for synchronous only

    .cs_on      = 0,
    .cs_rd_off  = 280,
    .cs_wr_off  = 259,

    .adv_on     = 30,
    .adv_rd_off = 60,
    .adv_wr_off = 60,
    .we_on      = 144,

    .we_off     = 249,   // fit time

    .oe_on      = 70,
    .oe_off     = 270,  //fit time

    .access     = 259,   //fit time

    .wr_access  = 249,   //fit time

    .rd_cycle   = 297,   //fit time

    .wr_cycle   = 297,  // fit time

    .wr_data_mux_bus =134,
};
*/

/*
static struct gpmc_timings fpga_timings = {

     .sync_clk   = 0, //mininum clock peroid for synchronous only

    .cs_on      = 0,
    .cs_rd_off  = 100,
    .cs_wr_off  = 100,

    .adv_on     = 0,
    .adv_rd_off = 40,
    .adv_wr_off = 40,
    .we_on      = 60,

    .we_off     = 100,   // fit time

    .oe_on      = 60,
    .oe_off     = 100,  //fit time

    .access     = 100,   //fit time

    .wr_access  = 100,   //fit time

    .rd_cycle   = 100,   //fit time

    .wr_cycle   = 100,  // fit time

    .wr_data_mux_bus =60,
};
*/

/*
static struct gpmc_timings fpga_timings = {

     .sync_clk   = 0, //mininum clock peroid for synchronous only

    .cs_on      = 0,
    .cs_rd_off  = 120,
    .cs_wr_off  = 120,

    .adv_on     = 20,
    .adv_rd_off = 60,
    .adv_wr_off = 60,
    .we_on      = 70,

    .we_off     = 120,   // fit time

    .oe_on      = 70,
    .oe_off     = 120,  //fit time

    .access     = 100,   //fit time

    .wr_access  = 100,   //fit time

    .rd_cycle   = 150,   //fit time

    .wr_cycle   = 150,  // fit time

    .wr_data_mux_bus =60,
};
*/


static struct gpmc_timings fpga_timings = {

     .sync_clk   = 0, //mininum clock peroid for synchronous only

    .cs_on      = 0,
    .cs_rd_off  = 110,
    .cs_wr_off  = 110,

    .adv_on     = 20,
    .adv_rd_off = 55,
    .adv_wr_off = 55,
    .we_on      = 65,

    .we_off     = 110,   // fit time

    .oe_on      = 65,
    .oe_off     = 110,  //fit time

    .access     = 110,   //fit time

    .wr_access  = 110,   //fit time

    .rd_cycle   = 110,   //fit time

    .wr_cycle   = 110,  // fit time

    .wr_data_mux_bus =55,
};


static struct fb_fix_screeninfo gpmcfb_fix __devinitdata = {
	.id =		"gpmc", 
	.type =		FB_TYPE_PACKED_PIXELS,
	.visual =	FB_VISUAL_PSEUDOCOLOR,
	//.visual =	FB_VISUAL_TRUECOLOR,
	.xpanstep =	0,
	.ypanstep =	0,
	.ywrapstep =	0, 
	.line_length =	WIDTH*BPP/8,
	.accel =	FB_ACCEL_NONE,
};

static struct fb_var_screeninfo gpmcfb_var __devinitdata = {
	.xres =			WIDTH,
	.yres =			HEIGHT,
	.xres_virtual =		WIDTH,
	.yres_virtual =		HEIGHT,
	.bits_per_pixel =	BPP,
	.nonstd	=		1,
};


static int gpmc_write_data_buf(struct gpmcfb_par *par,
					u8 *txbuf, int size)
{
	/* Set data mode */
	//gpio_set_value(par->dc, 1);

	/* Write entire buffer */
	//return spi_write(par->spi, txbuf, size);
	/*
	int i;
	for(i = 0; i>= size; i++){
		iowrite16(0x1234, fpga_pointer + 0x10000);
	}*/
	
	//struct gpmc_private *p;
	
	//int i;
	int bytesLeft = size;
	//int retval = 0;
	void __iomem *fpga_pointer;
	
	
	/*
	while (bytesLeft != 0) {
	  if (bytesLeft > 128) {
		iowrite16_rep(fpga_pointer + 0x10000, txbuf+(size-bytesLeft), 128);
		bytesLeft -= 128;
	  } else {
		iowrite16_rep(fpga_pointer + 0x10000, txbuf+(size-bytesLeft), bytesLeft);
		bytesLeft = 0;
	  }
	}
	
	*/
	
	fpga_pointer = ioremap_nocache(par->gpmc_adr, SZ_16M);
	
	iowrite8(0x00, fpga_pointer + 0x20);
	iowrite8(0x00, fpga_pointer + 0x24);
	iowrite8(0x00, fpga_pointer + 0x28);
	iowrite8(0x00, fpga_pointer + 0x2C);
	wmb();
	
	iowrite8_rep(fpga_pointer + 0x00, txbuf, size);
	
	/*
	while (bytesLeft != 0) {
	  if (bytesLeft > GPMC_WR_SIZE) {
		//iowrite16_rep(fpga_pointer + 0x10000, txbuf+(size-bytesLeft), 2048);
		iowrite8_rep(fpga_pointer + 0x00, txbuf+(size-bytesLeft), GPMC_WR_SIZE);
		//iowrite16(0x1234, fpga_pointer + 0x10000);
		//iowrite16(0x5678, fpga_pointer + 0x10000);
		//iowrite16_rep(fpga_pointer + 0x00000, txbuf+(size-bytesLeft), 2048);
		//__raw_writew
		//wmb();
		
		bytesLeft -= GPMC_WR_SIZE;
	  } else {
		//iowrite16_rep(fpga_pointer + 0x10000, txbuf+(size-bytesLeft), bytesLeft);
		iowrite8_rep(fpga_pointer + 0x00, txbuf+(size-bytesLeft), bytesLeft);
		//iowrite16(0x1234, fpga_pointer + 0x10000);
		//iowrite16(0x5678, fpga_pointer + 0x10000);
		//iowrite16_rep(fpga_pointer + 0x00000, txbuf+(size-bytesLeft), bytesLeft);
		bytesLeft = 0;
	  }
	}
	
	*/
	
	iounmap(fpga_pointer);
	
	
	return 0;
}

static void gpmc_set_addr_win(struct gpmcfb_par *par,
				int xs, int ys, int xe, int ye)
{
	/*
	gpmc_write_cmd(par, gpmc_CASET);
	gpmc_write_data(par, 0x00);
	gpmc_write_data(par, xs+2);
	gpmc_write_data(par, 0x00);
	gpmc_write_data(par, xe+2);
	gpmc_write_cmd(par, gpmc_RASET);
	gpmc_write_data(par, 0x00);
	gpmc_write_data(par, ys+1);
	gpmc_write_data(par, 0x00);
	gpmc_write_data(par, ye+1);
	*/
	// set windows address
	/*
	iowrite16(fpga_pointer + 0x0000, xs+2)	;	//	x start position
	iowrite16(fpga_pointer + 0x0002, xe+2)	;	//	x end position
	iowrite16(fpga_pointer + 0x0004, ys+1)	;	//	y start position
	iowrite16(fpga_pointer + 0x0006, ye+1)	;	//	y end position
	*/
}

static void gpmcfb_update_display(struct gpmcfb_par *par)
{
	int ret = 0;
	u8 *vmem = par->info->screen_base;
	//void __iomem *vmem = par->info->screen_base;
	
	/*
#ifdef __LITTLE_ENDIAN
	int i;
	u16 *vmem16 = (u16 *)vmem;
	u16 *ssbuf = par->ssbuf;

	for (i=0; i<WIDTH*HEIGHT*BPP/8/2; i++)
		ssbuf[i] = swab16(vmem16[i]);
#endif
*/
	/*
		TODO:
		Allow a subset of pages to be passed in
		(for deferred I/O).  Check pages against
		pan display settings to see if they
		should be updated.
	*/
	/* For now, just write the full 40KiB on each update */

	/* Set row/column data window */
	gpmc_set_addr_win(par, 0, 0, WIDTH-1, HEIGHT-1);

	/* Internal RAM write command */
	//gpmc_write_cmd(par, gpmc_RAMWR);

	/* Blast framebuffer to gpmc internal display RAM */
//#ifdef __LITTLE_ENDIAN
//	ret = gpmc_write_data_buf(par, (u8 *)ssbuf, WIDTH*HEIGHT*BPP/8);
//#else
	ret = gpmc_write_data_buf(par, vmem, WIDTH*HEIGHT*BPP/8);
//#endif
	if (ret < 0)
		pr_err("%s: spi_write failed to update display buffer\n",
			par->info->fix.id);
}

static void gpmcfb_deferred_io(struct fb_info *info,
				struct list_head *pagelist)
{
	gpmcfb_update_display(info->par);
}

/*
void gpmcfb_fillrect(struct fb_info *info, const struct fb_fillrect *rect)
{
	struct gpmcfb_par *par = info->par;

	sys_fillrect(info, rect);

	gpmcfb_update_display(par);
}

void gpmcfb_copyarea(struct fb_info *info, const struct fb_copyarea *area) 
{
	struct gpmcfb_par *par = info->par;

	sys_copyarea(info, area);

	gpmcfb_update_display(par);
}

void gpmcfb_imageblit(struct fb_info *info, const struct fb_image *image) 
{
	struct gpmcfb_par *par = info->par;

	sys_imageblit(info, image);

	gpmcfb_update_display(par);
}
*/

static ssize_t gpmcfb_write(struct fb_info *info, const char __user *buf,
		size_t count, loff_t *ppos)
{
	struct gpmcfb_par *par = info->par;
	unsigned long p = *ppos;
	void *dst;
	int err = 0;
	unsigned long total_size;

	if (info->state != FBINFO_STATE_RUNNING)
		return -EPERM;

	total_size = info->fix.smem_len;

	if (p > total_size)
		return -EFBIG;

	if (count > total_size) {
		err = -EFBIG;
		count = total_size;
	}

	if (count + p > total_size) {
		if (!err)
			err = -ENOSPC;

		count = total_size - p;
	}

	dst = (void __force *) (info->screen_base + p);

	if (copy_from_user(dst, buf, count))
		err = -EFAULT;

	if  (!err)
		*ppos += count;
	
	gpmcfb_update_display(par);

	return (err) ? err : count;
}


/*
static void vgatonicfb_deferred_io_touch(struct fb_info *info, const struct fb_fillrect *rect)
{
	struct fb_deferred_io *fbdefio = info->fbdefio;

	if (!fbdefio)
		return;

	if (rect) {
		struct vgatonicfb_par *par = info->par;
		unsigned long offset;
		int index_lo, index_hi, i;

		offset = rect->dy * info->fix.line_length;

		index_lo = offset >> PAGE_SHIFT;

		
		offset = (rect->dy + rect->height - 1) * info->fix.line_length;

		index_hi = offset >> PAGE_SHIFT;

		//for ( i=index_lo; i<=index_hi; i++ )
			//set_bit(i, &par->deferred_pages_mask);
	}

	schedule_delayed_work(&info->deferred_work, fbdefio->delay);
}


// No hardware acceleration for rects, use system 
void gpmcfb_fillrect(struct fb_info *info, const struct fb_fillrect *rect)
{
	sys_fillrect(info, rect);
	vgatonicfb_deferred_io_touch(info, rect);
}

// No hardware acceleration for copying, use system 
void gpmcfb_copyarea(struct fb_info *info, const struct fb_copyarea *area) 
{
	const struct fb_fillrect *rect = (const struct fb_fillrect *)area;
	sys_copyarea(info, area);
	vgatonicfb_deferred_io_touch(info, rect);
}

// No hardware acceleration for image blitting, use system 
void gpmcfb_imageblit(struct fb_info *info, const struct fb_image *image) 
{
	const struct fb_fillrect *rect = (const struct fb_fillrect *)image;
	sys_imageblit(info, image);
	vgatonicfb_deferred_io_touch(info, rect);
}


static ssize_t gpmcfb_write(struct fb_info *info, const char __user *buf, size_t count, loff_t *ppos)
{
	unsigned long p = *ppos;
	void *dst;
	int err = 0;
	unsigned long total_size;

	if (info->state != FBINFO_STATE_RUNNING)
		return -EPERM;

	total_size = info->fix.smem_len;

	if (p > total_size)
		return -EFBIG;

	if (count > total_size) {
		err = -EFBIG;
		count = total_size;
	}

	if (count + p > total_size) {
		if (!err)
			err = -ENOSPC;

		count = total_size - p;
	}

	dst = (void __force *) (info->screen_base + p);

	if (copy_from_user(dst, buf, count))
		err = -EFAULT;

	if  (!err)
		*ppos += count;

	vgatonicfb_deferred_io_touch(info, NULL); // TODO: pass dirty rect 

	return (err) ? err : count;
}
*/


/*
static struct fb_ops gpmcfb_ops = {
	.owner		= THIS_MODULE,
	//.fb_read	= fb_sys_read,
	.fb_write	= gpmcfb_write,
	.fb_fillrect	= gpmcfb_fillrect,
	.fb_copyarea	= gpmcfb_copyarea,
	.fb_imageblit	= gpmcfb_imageblit,
};
*/

static struct fb_ops gpmcfb_ops = {
	.owner		= THIS_MODULE,
	//.fb_read	= fb_sys_read,
	.fb_write	= gpmcfb_write,
	.fb_fillrect	= cfb_fillrect,
	.fb_copyarea	= cfb_copyarea,
	.fb_imageblit	= cfb_imageblit,
};


static struct fb_deferred_io gpmcfb_defio = {
	//.delay		= HZ/30,
	.delay		= HZ/30,
	.deferred_io	= gpmcfb_deferred_io,
};

static int __devinit gpmcfb_probe(struct platform_device *dev)
{
	//int chip = spi_get_device_id(spi)->driver_data;
	//struct gpmcfb_platform_data *pdata = spi->dev.platform_data;
	int vmem_size = WIDTH*HEIGHT*BPP/8;
	//u8 *vmem;
	void __iomem *vmem;
	struct fb_info *info;
	struct gpmcfb_par *par;
	int retval = -ENOMEM;
	
	
	//	--> gpmc initial
	void __iomem *fpga_pointer;
	int reg_val ;
    int ret_val ;
    int cs = 1; // Chip Select on GPMC bus
    unsigned long fpga_mem_addr;
	
	struct gpmc_devices_info  gpmc_device[1]={
        {NULL, GPMC_DEVICE_NOR},
    };

    omap_init_gpmc(gpmc_device, sizeof(gpmc_device));
    //platform_device_register(&fpga_mem_access);
    //fpga_gpmc_setup();
	
    //preparing GPMC_CONFIG1 (16 Asynchronous memory ,device size  16 bit,ADD-MUX device wait monitor)

    reg_val = GPMC_CONFIG1_READTYPE_ASYNC ;
    reg_val |= GPMC_CONFIG1_WRITETYPE_ASYNC;
    //reg_val |= GPMC_CONFIG1_DEVICESIZE_16 ;
	reg_val |= GPMC_CONFIG1_DEVICESIZE(0);
    reg_val |= GPMC_CONFIG1_MUXADDDATA ;
    reg_val |= GPMC_CONFIG1_DEVICETYPE_NOR ;
    //reg_val |= GPMC_CONFIG1_FCLK_DIV4;	//          (GPMC_CONFIG1_FCLK_DIV(3))
	reg_val |= GPMC_CONFIG1_FCLK_DIV2;	//          (GPMC_CONFIG1_FCLK_DIV(1))


    ret_val = gpmc_cs_request(cs, SZ_16M, &fpga_mem_addr);

    if (ret_val < 0) {
        printk(KERN_ERR "[fpga init]: gpmc_cs_request failed\n");
     }else{
        printk(KERN_INFO "fpga_gpmc CS %d membase 0x%lx", cs, fpga_mem_addr);
     }

    //fpga_mem_resources[0].start = fpga_mem_addr;
    //fpga_mem_resources[0].end = fpga_mem_addr + SZ_16M;
    //fpga_base = fpga_mem_addr;

    ret_val = gpmc_cs_configure(cs, GPMC_CONFIG_DEV_TYPE, GPMC_DEVICETYPE_NOR);
    if (ret_val < 0) {
        printk(KERN_ERR " platform init]: gpmc_cs_configure failed\n");
    }

    gpmc_cs_write_reg(cs, GPMC_CS_CONFIG1, reg_val);

   ret_val =  gpmc_cs_set_timings(cs, &fpga_timings);
       if (ret_val < 0) {
           printk(KERN_ERR "Failed gpmc_cs_set_timings fpga device\n");
           gpmc_cs_free(cs);
    }
	
	/*
	fpga_pointer = ioremap_nocache(fpga_mem_addr, SZ_16M);
	
	iowrite8(0xF0, fpga_pointer + 0x00);
	iowrite8(0xF1, fpga_pointer + 0x02);
	iowrite8(0xF2, fpga_pointer + 0x04);
	iowrite8(0xF3, fpga_pointer + 0x06);
	iowrite8(0xF4, fpga_pointer + 0x08);
	iowrite8(0xF5, fpga_pointer + 0x0a);
	iowrite8(0xF6, fpga_pointer + 0x0c);
	
	iounmap(fpga_pointer);
	//	<-- gpmc initial
	*/
	
	
	vmem = vzalloc(vmem_size);
	if (!vmem)
		return retval;

	info = framebuffer_alloc(sizeof(struct gpmcfb_par), &dev->dev);
	if (!info)
		goto fballoc_fail;

	//info->screen_base = (u8 __force __iomem *)vmem;
	//info->screen_base = (u16 __force __iomem *)vmem;
	//info->screen_base = vmem;
	info->screen_base = (void __iomem *)vmem;
	info->fbops = &gpmcfb_ops;
	info->fix = gpmcfb_fix;
	info->fix.smem_len = vmem_size;
	info->var = gpmcfb_var;
	/* Choose any packed pixel format as long as it's RGB565 */
	info->var.red.offset = 11;
	info->var.red.length = 5;
	info->var.green.offset = 5;
	info->var.green.length = 6;
	info->var.blue.offset = 0;
	info->var.blue.length = 5;
	info->var.transp.offset = 0;
	info->var.transp.length = 0;
	info->flags = FBINFO_FLAG_DEFAULT | FBINFO_VIRTFB;
	info->fbdefio = &gpmcfb_defio;
	info->fbdefio->delay	= HZ/30,
	fb_deferred_io_init(info);

	par = info->par;
	par->info = info;
	par->gpmc_adr = fpga_mem_addr;
	//par->spi = spi;
	//par->rst = pdata->rst_gpio;
	//par->dc = pdata->dc_gpio;

	
//#ifdef __LITTLE_ENDIAN
//	/* Allocate swapped shadow buffer */
//	vmem = vzalloc(vmem_size);
//	if (!vmem)
//		return retval;
//	par->ssbuf = vmem;
//#endif

	retval = register_framebuffer(info);
	if (retval < 0)
		goto fbreg_fail;

	//spi_set_drvdata(spi, info);

	/*
	retval = gpmcfb_init_display(par);
	if (retval < 0)
		goto init_fail;
	*/

	printk(KERN_INFO
		"fb%d: %s frame buffer device,\n\tusing %d KiB of video memory\n",
		info->node, info->fix.id, vmem_size);

	return 0;


	/* TODO: release gpios on fail */
//init_fail:
	//spi_set_drvdata(spi, NULL);

fbreg_fail:
	framebuffer_release(info);

fballoc_fail:
	vfree(vmem);

	return retval;
}

static int gpmcfb_remove(struct platform_device *dev)
{
	struct fb_info *info = platform_get_drvdata(dev);
	if (info) {
		unregister_framebuffer(info);
		vfree(info->screen_base);	
		framebuffer_release(info);
	}
	return 0;
}

static struct platform_driver gpmcfb_driver = {
	.probe = gpmcfb_probe,
	.remove = gpmcfb_remove,
	.driver = {
		   .name = "gpmcfb",
		   .owner  	= THIS_MODULE,
		   },
};

static struct platform_device gpmcfb_device = {
	.name = "gpmcfb",
	.id = 0,
};

static int __init gpmcfb_init(void)
{
	int ret = 0;

	ret = platform_driver_register(&gpmcfb_driver);

	if (!ret) {
		ret = platform_device_register(&gpmcfb_device);
		if (ret)
			platform_driver_unregister(&gpmcfb_driver);
	}
	return ret;
}

static void __exit gpmcfb_exit(void)
{
	platform_device_unregister(&gpmcfb_device);
	platform_driver_unregister(&gpmcfb_driver);
}


/*
static int __init gpmcfb_init(void)
{
	return spi_register_driver(&gpmcfb_driver);
}

static void __exit gpmcfb_exit(void)
{
	spi_unregister_driver(&gpmcfb_driver);
}
*/

/* ------------------------------------------------------------------------- */

module_init(gpmcfb_init);
module_exit(gpmcfb_exit);

MODULE_DESCRIPTION("FB driver for gpmc display controller");
MODULE_AUTHOR("Matt Porter");
MODULE_LICENSE("GPL");