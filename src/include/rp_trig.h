#ifndef W7X_TIMING_H
#define W7X_TIMING_H

#include <linux/types.h>
#include <asm/ioctl.h>

#ifdef __cplusplus
extern "C" {
#endif

#define C_OK           0
#define C_DEV_ERROR    1
#define C_PARAM_ERROR  2
//                            SGPWActE
#define STATUS_MASK    254 // 11111110
#define IDLE             6 // 00000110
#define ARMED           14 // 00001110
#define WAITING_DELAY   22 // 00010110
#define WAITING_SAMPLE 114 // 01110010
#define WAITING_LOW     82 // 01010010
#define WAITING_HIGH   210 // 11010010
#define WAITING_REPEAT  50 // 00110010

#define DEVICE_NAME "rp_trig"  /* Dev name as it appears in /proc/devices */
#define MODULE_NAME "rp_trig"
#define MAX_SAMPLES 54272
#define MAX_TIME    0xFFFFFFFFFF // (1<<40)-1
#define MAX_STATUS  8
#define W7X_TIMING_IOCTL_BASE	'W'
#define W7X_TIMING_RESOFFSET _IO(W7X_TIMING_IOCTL_BASE, 0)

#define INIT_ON		0x1
#define	INIT_ARM	0x3// + INIT_ON
#define	INIT_REARM	0x7// + INIT_ARM
#define	INIT_REINIT	0xf// + INIT_REARM

typedef unsigned char		uint8_t;
typedef unsigned short		uint16_t;
typedef unsigned int		uint32_t;
typedef unsigned long long	uint64_t;

# pragma pack(1)
struct rp_trig
{	// manual packing 64 bit
	uint8_t  r_status[MAX_STATUS];//0x00 ++0x01
	uint8_t  w_init;              //0x08 &1:on,&2:arm,&4:rearm,&8:reinit
	uint8_t  w_trig;              //0x09
	uint8_t  w_clear;             //0x0A
	uint8_t  w_save;              //0x0B
	uint8_t  w_extclk;            //0x0C
	uint8_t  w_invert;            //0x0D
	uint8_t  w_gate;              //0x0E
	uint8_t  w_gate2;             //0x0F
	uint64_t w_delay;             //0x10
	uint64_t w_width;             //0x18
	uint64_t w_period;            //0x20
	uint64_t w_burst;             //0x28
	uint64_t w_cycle;             //0x30
	uint32_t w_repeat;            //0x38
	uint32_t w_count;             //0x3C
	uint64_t w_times[MAX_SAMPLES];//0x40 ++0x08
};


#ifndef __KERNEL__
// api functions here //

#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/mman.h>


struct rp_trig *rp_trig_get_device(const char *dev_file)
{
	static struct rp_trig *dev = NULL;
	int fd;
	if(!dev)
	{
		if(dev_file)
			fd = open(dev_file, O_RDWR | O_SYNC);
		else
			fd = open("/dev/"DEVICE_NAME, O_RDWR | O_SYNC);
		if(fd < 0)
		{
			printf("ERROR: failed to open device file\n");
			return NULL;
		}
		fprintf(stderr, "trying to allocate %u bytes of data\n", (uint32_t)sizeof(struct rp_trig));
		dev = mmap(NULL, sizeof(struct rp_trig), PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
	}
	if(!dev)
	{
		printf("ERROR: failed to mmap device memory\n");
		return NULL;
	}
	return dev;
}

int rp_trig_release_device()
{
	struct rp_trig *dev = rp_trig_get_device(0);
	int c_status;
	if(dev)
	{// release
		c_status = munmap(dev, sizeof(struct rp_trig));
		if(c_status == C_OK) dev = NULL;
	}
	return c_status;
}


#endif // __KERNEL__




#ifdef __cplusplus
}
#endif
#endif // W7X_TIMING_H
