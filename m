Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4849EC5DF82
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 08:49:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89E9D10EF5F;
	Thu, 20 Aug 2026 08:49:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=snu.ac.kr header.i=@snu.ac.kr header.b="c4EJ1gnN";
	dkim-atps=neutral
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com
 [209.85.210.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39B6310EE9C
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 19:19:25 +0000 (UTC)
Received: by mail-pf1-f176.google.com with SMTP id
 d2e1a72fcca58-8487b7b3fc8so1456554b3a.3
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 12:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=snu.ac.kr; s=google; t=1787167165; x=1787771965; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=b8qznyhwBApth9eVh7FP4ShjzHB4e+MMQJXm8koFEzo=;
 b=c4EJ1gnN2En5jBFbY09a4+r2/CVyFHJxqy5H5gt6XWxqS5nbpNqc1NWr6iHVjo2j0J
 /IvMmUd9IQNibpjBXLVmWvjCqOCDuiSa+UAkfG+kX+dMAFoi9ZtL4uaFWe8R+ro5+pUm
 d/WPtEn3vmMQhnejuF03R3YufGltMJWuAX1iQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787167165; x=1787771965;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=b8qznyhwBApth9eVh7FP4ShjzHB4e+MMQJXm8koFEzo=;
 b=RVRD3cEH+sz/FVKn52L0iNXHYyK10vxbb1+hDnatkF5mm+eK0BGcguS5AYIw6Oeg4d
 lQizyqkYEBx0ggAvmS4u5hXeOOpr+Gs7xXF21GbbVFqcY8AGZYglzht4O0UpZic+3QMs
 cwh+mboE690mcHAnZ5qX4uQ0eqZwoM4tVRu7xfSadSVjwef+CA6tiRW/P563kpv2bs1R
 eCFv8U7ct2ImkGLyR7pIqJsQhy52T2rjp1mGHMqyPbZqJwh7wodjCKMdf84LODqkNDzo
 YYduRfhbEKbt0AsCL4rHaecrYD7w+TymWtLg95Et66hbQtPBrDBoBKiFw9OoTyhGTtKG
 5paQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpvrpwF3CYiV3KZK0ZBPxj9L8DzwcOHXYc3cCGKIcGaOlZIxDXmXtmcfwGqB4D6OUdhYvgxEmb+/EI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxhOZtI4qwMKuAQUkll0jfzwvu+MdVRIXY0btN9HJ9trllKbut6
 P4d+MGKhQTGE9DxO6ZRMQEOcSyi1jvNyFQKrvNa9AELXRSLhMy0AVLhSChudWKR1kN0=
X-Gm-Gg: AR+sD12OKmP/wGGZjbo9kc8z2GYuCnnQpYjQqI1t34pAUeLGlHOy2DwusOJ8FGcGq6o
 gZTo/ZteTKgnPeqkR5ghvEauQgmTiM/zKnJfcDgbhhVK47mb0EHGcAFqGhTl44fXi70l7MyNiga
 YQVisFgPzw0ebOxJMawZNRHeS0t1xlBmhTM2OWUR0jr19IWUzcWj7bCPseGqN4gtkxTVXHOSFhr
 UQ3c5DCn560cn6NHuazyzq+Zg3Japv7ehfTz/uYmDKvJ/G+uqbCHQu/U3BAYDcFhC1F/0ZX2l9x
 b/UwJr/P3ux1TQIcaleZMXWxRAizNeL0UgV+V9d/Pvv+Bw4rZ2cESgdhpsp6KzcfC4mrnyDb4DZ
 kmaNLQFUxEGRvG1GeObAB8VvjwlmJwVZtDwI7oRD6klaD9lzNfJ2+mZF3MMmIheiQ6GbqfBHX/c
 +TPhFyXu8vt7KE1l7WsM+/+pfk1HRkOwmwQ+fBvLSfxHUONve4gLFuBSnEj1elbFH5PZrHCEzrk
 P6RXxs17vignjP3qoyfcbSL7xKMnKZyGaWGXfC+MFJ33jYT7oor2MVFlJkPMzzo97vQYP9di+r7
 915sEVqJgqEGnAqCuca0/UVdqJ/mvKtmd0lVaciDxeljLdKNmApuV+VUsVxGfmvJ
X-Received: by 2002:a05:6a00:2301:b0:847:7ffd:ce35 with SMTP id
 d2e1a72fcca58-851d382e720mr11285759b3a.8.1787167164497; 
 Wed, 19 Aug 2026 12:19:24 -0700 (PDT)
Received: from leesin ([147.46.121.37]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-851d36185d3sm964366b3a.31.2026.08.19.12.19.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 12:19:20 -0700 (PDT)
From: Jaeyoung Chung <jjy600901@snu.ac.kr>
To: deller@gmx.de, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, simona@ffwll.ch, soci@c64.rulez.org
Cc: linux-kernel@vger.kernel.org,
	eulgyukim@snu.ac.kr,
	jjy600901@snu.ac.kr
Subject: [BUG] KASAN: vmalloc-out-of-bounds Write in fillrect
Date: Thu, 20 Aug 2026 04:18:48 +0900
Message-ID: <20260819191849.46929-1-jjy600901@snu.ac.kr>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 20 Aug 2026 08:48:42 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Hello,

We found a "KASAN: vmalloc-out-of-bounds Write in fillrect" on Linux v7.2.
The issue was found by our own race fuzzer. We have not analyzed the root cause,
so we do not have a proposed fix to offer.

To reproduce the race reliably, we applied the delay patch below to the
kernel and ran the C reproducer as root inside an x86_64 QEMU guest. The
crash log we observed, the delay patch and the reproducer are all included
below.

The following kernel config options are required to reproduce the issue:
    CONFIG_VT=y
    CONFIG_FB=y
    CONFIG_FB_CORE=y
    CONFIG_FRAMEBUFFER_CONSOLE=y
    CONFIG_DRM=y
    CONFIG_DRM_FBDEV_EMULATION=y
    CONFIG_DRM_BOCHS=y
    CONFIG_DRM_UDL=y
    CONFIG_USB_SUPPORT=y
    CONFIG_USB=y
    CONFIG_USB_GADGET=y
    CONFIG_USB_DUMMY_HCD=y
    CONFIG_USB_RAW_GADGET=y
    # CONFIG_DRM_VKMS is not set
    CONFIG_KASAN=y
    CONFIG_KASAN_VMALLOC=y

We hope this report is useful. Please let us know if any further
information would help.

Reported-by: Eulgyu Kim <eulgyukim@snu.ac.kr>
Reported-by: Jaeyoung Chung <jjy600901@snu.ac.kr>

Kernel delay patch:
==================================================================
diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 8f467b22b799..bf68bba39b55 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -73,6 +73,7 @@
 
 #include <linux/module.h>
 #include <linux/types.h>
+#include <linux/delay.h>
 #include <linux/sched/signal.h>
 #include <linux/tty.h>
 #include <linux/tty_flip.h>
@@ -3272,6 +3273,7 @@ static int vc_con_write_normal(struct vc_data *vc, int tc, int c,
 	return 0;
 }
 
+static int syz_dcw_hits;
 /* acquires console_lock */
 static int do_con_write(struct tty_struct *tty, const u8 *buf, int count)
 {
@@ -3287,6 +3289,10 @@ static int do_con_write(struct tty_struct *tty, const u8 *buf, int count)
 	if (in_interrupt())
 		return count;
 
+	if (syz_dcw_hits < 256 && strncmp(current->comm, "syzrepro2", 9) == 0) {
+		syz_dcw_hits++;
+		mdelay(5);
+	}
 	guard(console_lock)();
 	currcons = vc->vc_num;
 	if (!vc_cons_allocated(currcons)) {
diff --git a/drivers/video/fbdev/core/bitblit.c b/drivers/video/fbdev/core/bitblit.c
index 39f44258d793..f2cb909c8e5b 100644
--- a/drivers/video/fbdev/core/bitblit.c
+++ b/drivers/video/fbdev/core/bitblit.c
@@ -16,9 +16,13 @@
 #include <linux/fb.h>
 #include <linux/vt_kern.h>
 #include <linux/console.h>
+#include <linux/delay.h>
+#include <linux/printk.h>
+#include <linux/sched.h>
 #include <asm/types.h>
 #include "fbcon.h"
 
+static int syz_bc_hits;
 /*
  * Accelerated handlers.
  */
@@ -69,6 +73,10 @@ static void bit_clear(struct vc_data *vc, struct fb_info *info, int sy,
 	region.height = height * vc->vc_font.height;
 	region.rop = ROP_COPY;
 
+	if (syz_bc_hits < 96 && strncmp(current->comm, "syzrepro", 8) == 0) {
+		syz_bc_hits++;
+		mdelay(5);
+	}
 	info->fbops->fb_fillrect(info, &region);
 }
 
diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 23b3c536d53d..75a14ee4ca13 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -62,6 +62,7 @@
 #include <linux/fs.h>
 #include <linux/kernel.h>
 #include <linux/delay.h>	/* MSch: for IRQ probe */
+#include <linux/sched.h>
 #include <linux/console.h>
 #include <linux/string.h>
 #include <linux/kd.h>
@@ -1492,6 +1493,9 @@ static void fbcon_set_disp(struct fb_info *info, struct fb_var_screeninfo *var,
 	rows /= vc->vc_font.height;
 	ret = vc_resize(vc, cols, rows);
 
+	if (strncmp(current->comm, "syzrepro", 8) == 0) {
+		mdelay(10);
+	}
 	if (con_is_visible(vc) && !ret)
 		update_screen(vc);
 }
@@ -2082,6 +2086,7 @@ static void updatescrollmode(struct fbcon_display *p,
 	updatescrollmode_accel(p, info, vc);
 }
 
+static int syz_fr_hits;
 static int fbcon_resize(struct vc_data *vc, unsigned int width,
 			unsigned int height, bool from_user)
 {
@@ -2091,6 +2096,10 @@ static int fbcon_resize(struct vc_data *vc, unsigned int width,
 	struct fb_var_screeninfo var = info->var;
 	int x_diff, y_diff, virt_w, virt_h, virt_fw, virt_fh;
 
+	if (syz_fr_hits < 32 && strncmp(current->comm, "syzrepro", 8) == 0) {
+		syz_fr_hits++;
+		mdelay(5);
+	}
 	if (font_data_size(p->fontdata)) {
 		unsigned int size = vc_font_size(&vc->vc_font);
 
@@ -2119,6 +2128,9 @@ static int fbcon_resize(struct vc_data *vc, unsigned int width,
 
 		pr_debug("attempting resize %ix%i\n", var.xres, var.yres);
 		mode = fb_find_best_mode(&var, &info->modelist);
+		if (strncmp(current->comm, "syzrepro", 8) == 0) {
+			mdelay(5);
+		}
 		if (mode == NULL)
 			return -EINVAL;
 		display_to_var(&var, p);
==================================================================

C reproducer:
==================================================================
#include <errno.h>
#include <fcntl.h>
#include <pthread.h>
#include <stdarg.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/ioctl.h>
#include <sys/prctl.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <time.h>
#include <unistd.h>

#include <linux/types.h>
#include <linux/fb.h>

#define UDC_NAME_LENGTH_MAX 128

struct usb_raw_init {
	__u8 driver_name[UDC_NAME_LENGTH_MAX];
	__u8 device_name[UDC_NAME_LENGTH_MAX];
	__u8 speed;
};

enum usb_raw_event_type {
	USB_RAW_EVENT_INVALID = 0,
	USB_RAW_EVENT_CONNECT = 1,
	USB_RAW_EVENT_CONTROL = 2,
	USB_RAW_EVENT_SUSPEND = 3,
	USB_RAW_EVENT_RESUME = 4,
	USB_RAW_EVENT_RESET = 5,
	USB_RAW_EVENT_DISCONNECT = 6,
};

struct usb_raw_event {
	__u32 type;
	__u32 length;
	__u8 data[0];
};

struct usb_raw_ep_io {
	__u16 ep;
	__u16 flags;
	__u32 length;
	__u8 data[0];
};

#define USB_RAW_IOCTL_INIT		_IOW('U', 0, struct usb_raw_init)
#define USB_RAW_IOCTL_RUN		_IO('U', 1)
#define USB_RAW_IOCTL_EVENT_FETCH	_IOR('U', 2, struct usb_raw_event)
#define USB_RAW_IOCTL_EP0_WRITE		_IOW('U', 3, struct usb_raw_ep_io)
#define USB_RAW_IOCTL_EP0_READ		_IOWR('U', 4, struct usb_raw_ep_io)
#define USB_RAW_IOCTL_EP_ENABLE		_IOW('U', 5, struct usb_endpoint_descriptor)
#define USB_RAW_IOCTL_EP_DISABLE	_IOW('U', 6, __u32)
#define USB_RAW_IOCTL_EP_WRITE		_IOW('U', 7, struct usb_raw_ep_io)
#define USB_RAW_IOCTL_EP_READ		_IOWR('U', 8, struct usb_raw_ep_io)
#define USB_RAW_IOCTL_CONFIGURE		_IO('U', 9)
#define USB_RAW_IOCTL_VBUS_DRAW		_IOW('U', 10, __u32)
#define USB_RAW_IOCTL_EP0_STALL		_IO('U', 12)

#define RAW_IO_MAX	4096

struct usb_ctrlrequest {
	__u8 bRequestType;
	__u8 bRequest;
	__u16 wValue;
	__u16 wIndex;
	__u16 wLength;
} __attribute__((packed));

struct usb_endpoint_descriptor {
	__u8 bLength;
	__u8 bDescriptorType;
	__u8 bEndpointAddress;
	__u8 bmAttributes;
	__u16 wMaxPacketSize;
	__u8 bInterval;
} __attribute__((packed));

#define USB_DIR_OUT			0x00
#define USB_DIR_IN			0x80
#define USB_TYPE_VENDOR			0x40
#define USB_REQ_GET_STATUS		0x00
#define USB_REQ_SET_ADDRESS		0x05
#define USB_REQ_GET_DESCRIPTOR		0x06
#define USB_REQ_GET_CONFIGURATION	0x08
#define USB_REQ_SET_CONFIGURATION	0x09
#define USB_REQ_SET_INTERFACE		0x0b
#define USB_DT_DEVICE			0x01
#define USB_DT_CONFIG			0x02
#define USB_DT_STRING			0x03
#define USB_SPEED_HIGH			3

#define UDL_REQ_EDID			0x02
#define UDL_EDID_REQTYPE		0xc0
#define UDL_EDID_WINDEX			0x00a1

#ifndef FBIOPUT_CON2FBMAP
#define FBIOGET_CON2FBMAP	0x460F
#define FBIOPUT_CON2FBMAP	0x4610
#endif

#define TTY_PATH	"/dev/tty1"
#define VT_INDEX	1

#define UDL_W		640
#define UDL_H		480

#define OOB_ROW_DEFAULT	30

#define FONT_H		16

#define FB0_PIXEL_ROWS	768

static int g_raw_fd = -1;
static volatile int g_ep_bulk = -1;
static volatile int g_stop;
static volatile int g_armed;
static int g_tty_fd = -1;
static unsigned char g_edid[128];
static volatile unsigned int g_edid_reads;
static volatile unsigned int g_ctrl_reqs;

static void set_name(const char *n)
{
	prctl(PR_SET_NAME, (unsigned long)n, 0UL, 0UL, 0UL);
}

static void msleep_(int ms)
{
	struct timespec ts;

	ts.tv_sec = ms / 1000;
	ts.tv_nsec = (long)(ms % 1000) * 1000000L;
	nanosleep(&ts, NULL);
}

static void rlog(const char *fmt, ...)
{
	va_list ap;

	va_start(ap, fmt);
	vfprintf(stdout, fmt, ap);
	va_end(ap);
	fputc('\n', stdout);
	fflush(stdout);
}

static void build_edid(void)
{
	unsigned char *d;
	int i, sum;

	memset(g_edid, 0, sizeof(g_edid));

	g_edid[0] = 0x00;
	g_edid[1] = 0xff; g_edid[2] = 0xff; g_edid[3] = 0xff;
	g_edid[4] = 0xff; g_edid[5] = 0xff; g_edid[6] = 0xff;
	g_edid[7] = 0x00;

	g_edid[8] = 0x4f; g_edid[9] = 0x3a;
	g_edid[10] = 0x01; g_edid[11] = 0x00;
	g_edid[16] = 1;
	g_edid[17] = 30;
	g_edid[18] = 1; g_edid[19] = 3;
	g_edid[20] = 0x80;
	g_edid[21] = 32; g_edid[22] = 24;
	g_edid[23] = 120;
	g_edid[24] = 0x0a;

	g_edid[35] = 0x20;

	for (i = 38; i < 54; i++)
		g_edid[i] = 0x01;

	d = &g_edid[54];
	d[0] = 0xd5; d[1] = 0x09;
	d[2] = 0x80;
	d[3] = 0xa0;
	d[4] = 0x20;
	d[5] = 0xe0;
	d[6] = 0x2d;
	d[7] = 0x10;
	d[8] = 0x10;
	d[9] = 0x60;
	d[10] = 0xa2;
	d[11] = 0x00;
	d[12] = 0x00; d[13] = 0x00; d[14] = 0x00;
	d[15] = 0x00; d[16] = 0x00;
	d[17] = 0x18;

	d = &g_edid[72];
	d[3] = 0xfd;
	d[5] = 50; d[6] = 70;
	d[7] = 30; d[8] = 60;
	d[9] = 10;
	d[11] = 0x0a;
	for (i = 12; i < 18; i++)
		d[i] = 0x20;

	d = &g_edid[90];
	d[3] = 0xfc;
	d[5] = 'S'; d[6] = 'Y'; d[7] = 'Z'; d[8] = 0x0a;
	for (i = 9; i < 18; i++)
		d[i] = 0x20;

	d = &g_edid[108];
	d[3] = 0x10;

	g_edid[126] = 0;

	sum = 0;
	for (i = 0; i < 127; i++)
		sum += g_edid[i];
	g_edid[127] = (unsigned char)((0x100 - (sum & 0xff)) & 0xff);
}

static const unsigned char dev_desc[18] = {
	18, USB_DT_DEVICE,
	0x00, 0x02,
	0x00, 0x00, 0x00,
	64,
	0xe9, 0x17,
	0x01, 0x43,
	0x00, 0x01,
	0, 0, 0,
	1,
};

static const unsigned char cfg_desc[25] = {

	9, USB_DT_CONFIG,
	25, 0,
	1,
	1,
	0,
	0xa0,
	0x32,

	9, 0x04,
	0,
	0,
	1,
	0xff, 0x00, 0x00,
	0,

	7, 0x05,
	0x01,
	0x02,
	0x00, 0x02,
	0,
};

static struct usb_endpoint_descriptor bulk_ep_desc = {
	.bLength = 7,
	.bDescriptorType = 0x05,
	.bEndpointAddress = 0x01,
	.bmAttributes = 0x02,
	.wMaxPacketSize = 512,
	.bInterval = 0,
};

struct ep_io_buf {
	struct usb_raw_ep_io inner;
	unsigned char data[RAW_IO_MAX];
};

static void ep0_stall(int fd)
{
	if (ioctl(fd, USB_RAW_IOCTL_EP0_STALL, 0) < 0)
		rlog("repro: ep0 stall failed: %s", strerror(errno));
}

static void ep0_in(int fd, const void *buf, int len, int wlen)
{
	static struct ep_io_buf io;

	if (len > wlen)
		len = wlen;
	if (len > RAW_IO_MAX)
		len = RAW_IO_MAX;
	memset(&io.inner, 0, sizeof(io.inner));
	io.inner.ep = 0;
	io.inner.flags = 0;
	io.inner.length = len;
	if (len)
		memcpy(io.data, buf, len);
	if (ioctl(fd, USB_RAW_IOCTL_EP0_WRITE, &io) < 0)
		rlog("repro: ep0 IN write(%d) failed: %s", len, strerror(errno));
}

static void ep0_out(int fd, int wlen)
{
	static struct ep_io_buf io;

	if (wlen < 0)
		wlen = 0;
	if (wlen > RAW_IO_MAX)
		wlen = RAW_IO_MAX;
	memset(&io.inner, 0, sizeof(io.inner));
	io.inner.ep = 0;
	io.inner.flags = 0;
	io.inner.length = wlen;
	if (ioctl(fd, USB_RAW_IOCTL_EP0_READ, &io) < 0)
		rlog("repro: ep0 OUT read(%d) failed: %s", wlen, strerror(errno));
}

static void *bulk_thread(void *unused)
{
	static struct ep_io_buf io;

	(void)unused;
	set_name("syzrepro3");
	while (!g_stop) {
		int ep = g_ep_bulk;

		if (ep < 0) {
			msleep_(20);
			continue;
		}
		memset(&io.inner, 0, sizeof(io.inner));
		io.inner.ep = ep;
		io.inner.flags = 0;
		io.inner.length = RAW_IO_MAX;
		if (ioctl(g_raw_fd, USB_RAW_IOCTL_EP_READ, &io) < 0) {
			if (errno == EINTR)
				continue;
			msleep_(2);
		}
	}
	return NULL;
}

static void handle_control(int fd, struct usb_ctrlrequest *ctrl)
{
	int wlen = ctrl->wLength;
	unsigned char rep[2];
	int idx, ep;

	if (g_ctrl_reqs < 24)
		rlog("repro: ctrl bRT=%02x bR=%02x wV=%04x wI=%04x wL=%u",
		     ctrl->bRequestType, ctrl->bRequest, ctrl->wValue,
		     ctrl->wIndex, ctrl->wLength);
	g_ctrl_reqs++;

	if (ctrl->bRequestType & USB_DIR_IN) {
		switch (ctrl->bRequestType) {
		case 0x80:
			if (ctrl->bRequest == USB_REQ_GET_DESCRIPTOR) {
				switch (ctrl->wValue >> 8) {
				case USB_DT_DEVICE:
					ep0_in(fd, dev_desc, sizeof(dev_desc), wlen);
					return;
				case USB_DT_CONFIG:
					ep0_in(fd, cfg_desc, sizeof(cfg_desc), wlen);
					return;
				case USB_DT_STRING: {
					unsigned char s[4] = { 4, USB_DT_STRING, 0x09, 0x04 };

					ep0_in(fd, s, sizeof(s), wlen);
					return;
				}
				default:

					ep0_stall(fd);
					return;
				}
			}
			if (ctrl->bRequest == USB_REQ_GET_STATUS) {
				rep[0] = 0; rep[1] = 0;
				ep0_in(fd, rep, 2, wlen);
				return;
			}
			if (ctrl->bRequest == USB_REQ_GET_CONFIGURATION) {
				rep[0] = 1;
				ep0_in(fd, rep, 1, wlen);
				return;
			}
			ep0_stall(fd);
			return;
		case UDL_EDID_REQTYPE:
			if (ctrl->bRequest == UDL_REQ_EDID &&
			    ctrl->wIndex == UDL_EDID_WINDEX) {
				idx = (ctrl->wValue >> 8) & 0xff;
				rep[0] = 0x00;
				rep[1] = (idx < 128) ? g_edid[idx] : 0x00;
				g_edid_reads++;
				ep0_in(fd, rep, 2, wlen);
				return;
			}
			ep0_stall(fd);
			return;
		default:
			ep0_stall(fd);
			return;
		}
	}

	switch (ctrl->bRequestType) {
	case 0x00:
		if (ctrl->bRequest == USB_REQ_SET_CONFIGURATION) {
			if (ioctl(fd, USB_RAW_IOCTL_VBUS_DRAW, 0x32) < 0)
				rlog("repro: vbus_draw failed: %s", strerror(errno));
			if (ioctl(fd, USB_RAW_IOCTL_CONFIGURE, 0) < 0)
				rlog("repro: configure failed: %s", strerror(errno));

			ep0_out(fd, wlen);
			ep = ioctl(fd, USB_RAW_IOCTL_EP_ENABLE, &bulk_ep_desc);
			if (ep < 0)
				rlog("repro: ep_enable failed: %s (udl URBs will "
				     "fail with -EPIPE, harmless here)",
				     strerror(errno));
			else
				g_ep_bulk = ep;
			return;
		}
		ep0_out(fd, wlen);
		return;
	case 0x01:
	case 0x02:
		ep0_out(fd, wlen);
		return;
	case (USB_DIR_OUT | USB_TYPE_VENDOR):
		ep0_out(fd, wlen);
		return;
	default:
		ep0_stall(fd);
		return;
	}
}

static void *usb_thread(void *unused)
{
	struct usb_raw_init init;
	struct {
		struct usb_raw_event inner;
		struct usb_ctrlrequest ctrl;
	} ev;
	int fd;

	(void)unused;
	set_name("syzrepro0");

	fd = open("/dev/raw-gadget", O_RDWR);
	if (fd < 0) {
		return NULL;
	}
	g_raw_fd = fd;

	memset(&init, 0, sizeof(init));
	strcpy((char *)init.driver_name, "dummy_udc");
	strcpy((char *)init.device_name, "dummy_udc.0");
	init.speed = USB_SPEED_HIGH;
	if (ioctl(fd, USB_RAW_IOCTL_INIT, &init) < 0) {
		return NULL;
	}
	if (ioctl(fd, USB_RAW_IOCTL_RUN, 0) < 0) {
		return NULL;
	}

	while (!g_stop) {
		memset(&ev, 0, sizeof(ev));
		ev.inner.type = 0;
		ev.inner.length = sizeof(ev.ctrl);
		if (ioctl(fd, USB_RAW_IOCTL_EVENT_FETCH, &ev) < 0) {
			if (errno == EINTR)
				continue;
			break;
		}
		if (ev.inner.type != USB_RAW_EVENT_CONTROL)
			continue;
		handle_control(fd, &ev.ctrl);
	}
	return NULL;
}

static const char scroll_seq[] = "\033[H\033[M";

static void tty_write(const char *s)
{
	if (g_tty_fd >= 0)
		(void)!write(g_tty_fd, s, strlen(s));
}

static void *writer_thread(void *unused)
{
	int i;

	(void)unused;
	set_name("syzrepro2");

	for (i = 0; i < 2000 && !g_stop; i++) {
		tty_write(scroll_seq);
		msleep_(20);
	}
	return NULL;
}

static int open_udl_fb(int *node_out, unsigned int *buf_rows_out)
{
	char path[64];
	int i;

	for (i = 1; i < 8; i++) {
		struct fb_var_screeninfo var;
		struct fb_fix_screeninfo fix;
		int fd;

		snprintf(path, sizeof(path), "/dev/fb%d", i);
		fd = open(path, O_RDWR);
		if (fd < 0)
			continue;
		memset(&var, 0, sizeof(var));
		memset(&fix, 0, sizeof(fix));
		if (ioctl(fd, FBIOGET_VSCREENINFO, &var) == 0 &&
		    ioctl(fd, FBIOGET_FSCREENINFO, &fix) == 0) {
			if (strstr(fix.id, "udl") ||
			    (var.xres == UDL_W && var.yres == UDL_H)) {
				*node_out = i;

				*buf_rows_out = fix.line_length ?
					fix.smem_len / fix.line_length : 0;
				return fd;
			}
		}
		close(fd);
	}
	return -1;
}

static int shrink_fb_var(int fd)
{
	struct fb_var_screeninfo var;

	memset(&var, 0, sizeof(var));
	if (ioctl(fd, FBIOGET_VSCREENINFO, &var) < 0) {
		return -1;
	}
	var.xres = 8;
	var.yres = 8;
	var.xres_virtual = 8;
	var.yres_virtual = 8;
	var.xoffset = 0;
	var.yoffset = 0;
	var.activate = FB_ACTIVATE_NOW;
	if (ioctl(fd, FBIOPUT_VSCREENINFO, &var) < 0) {
		return -1;
	}
	memset(&var, 0, sizeof(var));
	ioctl(fd, FBIOGET_VSCREENINFO, &var);
	return 0;
}

static int bind_console(int fd, int node)
{
	struct fb_con2fbmap c2f;

	memset(&c2f, 0, sizeof(c2f));
	c2f.console = VT_INDEX;
	c2f.framebuffer = node;
	if (ioctl(fd, FBIOPUT_CON2FBMAP, &c2f) < 0) {
		return -1;
	}
	memset(&c2f, 0, sizeof(c2f));
	c2f.console = VT_INDEX;
	if (ioctl(fd, FBIOGET_CON2FBMAP, &c2f) == 0)
		rlog("repro: vt%d is now mapped to fb%d", VT_INDEX, c2f.framebuffer);
	return 0;
}

int main(void)
{
	pthread_t th_usb, th_bulk, th_writer;
	unsigned int buf_rows = UDL_H, oob_row;
	int fb_fd, fb_node = -1;
	char seq[64];
	int i;


	setvbuf(stdout, NULL, _IOLBF, 0);
	set_name("syzrepro1");
	build_edid();

	g_tty_fd = open(TTY_PATH, O_RDWR | O_NOCTTY);
	if (g_tty_fd < 0) {
		return 1;
	}

	tty_write("\033c");
	msleep_(50);
	tty_write("\033[2J\033[H");

	pthread_create(&th_usb, NULL, usb_thread, NULL);
	pthread_create(&th_bulk, NULL, bulk_thread, NULL);

	fb_fd = -1;
	for (i = 0; i < 100 && fb_fd < 0; i++) {
		msleep_(200);
		fb_fd = open_udl_fb(&fb_node, &buf_rows);
	}

	if (fb_fd < 0) {
		g_stop = 1;
		msleep_(200);
		return 0;
	}

	if (buf_rows == 0 || buf_rows >= FB0_PIXEL_ROWS) {
		g_stop = 1;
		msleep_(200);
		return 0;
	}

	if (shrink_fb_var(fb_fd) < 0) {
		g_stop = 1;
		return 1;
	}

	oob_row = buf_rows / FONT_H;
	if (oob_row < 1 || oob_row > 46)
		oob_row = OOB_ROW_DEFAULT;

	snprintf(seq, sizeof(seq), "\033[2J\033[1;%ur\033[H", oob_row + 1);
	tty_write(seq);
	msleep_(50);

	if (bind_console(fb_fd, fb_node) < 0) {
		g_stop = 1;
		return 1;
	}
	g_armed = 1;

	pthread_create(&th_writer, NULL, writer_thread, NULL);

	for (i = 0; i < 400; i++) {
		tty_write(scroll_seq);
		msleep_(20);
	}

	g_stop = 1;
	msleep_(200);
	return 0;
}
==================================================================

Crash log:
==================================================================
BUG: KASAN: vmalloc-out-of-bounds in fb_write_offset drivers/video/fbdev/core/sysmem.h:30 [inline]
BUG: KASAN: vmalloc-out-of-bounds in bitfill drivers/video/fbdev/core/fb_fillrect.h:133 [inline]
BUG: KASAN: vmalloc-out-of-bounds in fb_fillrect_static drivers/video/fbdev/core/fb_fillrect.h:219 [inline]
BUG: KASAN: vmalloc-out-of-bounds in fb_fillrect drivers/video/fbdev/core/fb_fillrect.h:278 [inline]
BUG: KASAN: vmalloc-out-of-bounds in sys_fillrect+0x134b/0x1920 drivers/video/fbdev/core/sysfillrect.c:24
Write of size 8 at addr ffffc90002707000 by task syzrepro1/400

CPU: 0 UID: 0 PID: 400 Comm: syzrepro1 Not tainted 7.2.0-dirty #4 PREEMPT 
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x5e/0x80 lib/dump_stack.c:120
 print_address_description+0x77/0x200 mm/kasan/report.c:378
 print_report+0x64/0x70 mm/kasan/report.c:482
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 fb_write_offset drivers/video/fbdev/core/sysmem.h:30 [inline]
 bitfill drivers/video/fbdev/core/fb_fillrect.h:133 [inline]
 fb_fillrect_static drivers/video/fbdev/core/fb_fillrect.h:219 [inline]
 fb_fillrect drivers/video/fbdev/core/fb_fillrect.h:278 [inline]
 sys_fillrect+0x134b/0x1920 drivers/video/fbdev/core/sysfillrect.c:24
 drm_fbdev_shmem_defio_fillrect+0x26/0x110 drivers/gpu/drm/drm_fbdev_shmem.c:39
 bit_clear+0x12c/0x1d0 drivers/video/fbdev/core/bitblit.c:80
 __fbcon_clear+0x7ee/0xd00 drivers/video/fbdev/core/fbcon.c:-1
 fbcon_scroll+0x2a8/0x6e0 drivers/video/fbdev/core/fbcon.c:1931
 con_scroll+0x62b/0x8a0 drivers/tty/vt/vt.c:617
 csi_M drivers/tty/vt/vt.c:2192 [inline]
 csi_ECMA+0x58c/0x6610 drivers/tty/vt/vt.c:2615
 do_con_trol drivers/tty/vt/vt.c:-1 [inline]
 do_con_write+0x3452/0x4960 drivers/tty/vt/vt.c:3331
 con_write+0x13/0x30 drivers/tty/vt/vt.c:3667
 process_output_block drivers/tty/n_tty.c:557 [inline]
 n_tty_write+0xd4c/0x10c0 drivers/tty/n_tty.c:2366
 iterate_tty_write drivers/tty/tty_io.c:1006 [inline]
 file_tty_write+0x4f2/0x870 drivers/tty/tty_io.c:1081
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x7a2/0xa10 fs/read_write.c:687
 ksys_write+0xb0/0x170 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf7/0x370 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x7ae99dec038f
Code: 89 54 24 18 48 89 74 24 10 89 7c 24 08 e8 a9 d4 f8 ff 48 8b 54 24 18 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 31 44 89 c7 48 89 44 24 08 e8 fc d4 f8 ff 48
RSP: 002b:00007ffe8ce95bd0 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000190 RCX: 00007ae99dec038f
RDX: 0000000000000006 RSI: 0000594d1e9ad1c0 RDI: 0000000000000003
RBP: 0000594d1e9ad1c0 R08: 0000000000000000 R09: 00007ffe8ce95b27
R10: 0000000000000008 R11: 0000000000000293 R12: 000000000000001e
R13: 00007ffe8ce95d20 R14: 0000000000000000 R15: 00007ae99dfef020
 </TASK>

The buggy address belongs to a vmalloc virtual mapping
Memory state around the buggy address:
 ffffc90002706f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffc90002706f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffffc90002707000: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
                   ^
 ffffc90002707080: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
 ffffc90002707100: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
==================================================================


