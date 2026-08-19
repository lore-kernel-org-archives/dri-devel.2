Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE7B4C5DF81
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 08:49:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4C2B10EF65;
	Thu, 20 Aug 2026 08:49:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=snu.ac.kr header.i=@snu.ac.kr header.b="RxF0ZiKa";
	dkim-atps=neutral
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com
 [209.85.210.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6285C10E02D
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 19:25:34 +0000 (UTC)
Received: by mail-pf1-f173.google.com with SMTP id
 d2e1a72fcca58-84a2dcede83so1668020b3a.3
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 12:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=snu.ac.kr; s=google; t=1787167534; x=1787772334; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/hAsqKeBKalXBMmx+oiuGsjP6yvX3Ib9m0iErNCoBJI=;
 b=RxF0ZiKaKHR/znbS7V/rba8cJCTzs9jnKcwatBj+dU3SaJxznGHYJZjxe4X59NUQaf
 x0yEIb+FBWVzrof3ejduLn3Fe5+jVS71xwjpf/CrJ3zZG5ZbaMMu03pJfZ6RVbuyxBUw
 UtbdSsE3YXAQ9l53oiM+Lweba+bWzWsQ4ReIE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787167534; x=1787772334;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/hAsqKeBKalXBMmx+oiuGsjP6yvX3Ib9m0iErNCoBJI=;
 b=AajEsbY6uFAo5NJcz2wvXhx6LcUq/721SP10doZLyvOZ8VdE9zbW+MnSjr3yBuANgy
 H4JoDxzPGYfz3H32CCBMhk4sIUaHcA69bgfUFfHEkNbDZYhweYu6XT9S1QkORWPNbyUH
 DUORl16SPZ3O2u4N1kfFnOtJMNIxj+NwXZ0xz8pxvAwAP5CRk75kmTN0OD8ACFg22pcb
 MrQfmAd5C7g/RwwTixzLDwVwwqD4la+DlnF6n7YLDx7iegp4+ZRw4Y8dxrKcLCrFgk8F
 aOyFqV3WZpKXqLNTsse7E6zTuTfR2WsWwm5e1v+fSjpu9yLhNezr5oehUR/FMaGFGJ/h
 ZPZQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqJwNXJIDVMpRZAULPASV1jcLKXEJRnHA4k4XuT82rfnb5DttBc6dREOwtjvAUjIrrGijTy3Gc9uUc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw4JTIoR+i699zrWfEDDSdaaXQnlDqMEbs/xSo/Bd/7bFFI66qb
 rA5+piOpJEOuPhkpkb3eCKfNCKK8L4wVwI85XFXxM4MTk+IsQPkxhMPqgllD6IXjb5o=
X-Gm-Gg: AR+sD11M8Kf2PC/K+Odp0bTR49YpaBLYingeAdzR0lmtp3sV8BXO9j9TAGf+iR2/DQY
 Kn1HDmGgTmU/orGpxj6hosdIs71LArcZK5tQToHpm/Kdg5t68N3wuYCB+LNgtvpfwUzeZnlQ7p4
 mOWxZvaE4mti/DRQbT0rptOZR5xoK/2epxsG5xs4FUVqLtpHqmpAkDtwd4vzVE1QHNSOuMewndG
 g6+X95FAxYFOEJtvYQbHPWDnnVwXfmEqE5Cil+TGiZvEWI5G4WsYs2IUWNQoAf02G/GbBSde2r8
 oCENofF8EH3SPj1U7ojYSDYign7hJxcJ2PbPfTP4Q1seZ5XVFFgg7Tl5NL25siqUse5U6mFIvtE
 sF921UrKnNfMOJxV1pxHdBcwCvtvYi6vv3Rd3jzWlsv1l0qcGF/V+y28O5Ht6fQqQR7S6lq13mA
 EkzEYarXk6OqNLFugUDXmSNpHQDdUvE26pcOkHWipAjBeQ/IFOjXJde+4HGjrotqXnHhMybhDJp
 nrF9yTD63GUe+5cUqpPUErDRfWK6yWaQsK3M5MrGpuP/IoHhmG32bnbgehQmP5qPPx1eDIF2x6p
 dJJU+4Hb3ZVaHPjqfYYyeeTeCqnKvUPKlEEHvOh3eNlQ4xzeOLU1k5Zkpe+ORCuDVw==
X-Received: by 2002:a05:6a00:139c:b0:848:2c2e:c7a3 with SMTP id
 d2e1a72fcca58-851d3965b23mr11071026b3a.16.1787167533700; 
 Wed, 19 Aug 2026 12:25:33 -0700 (PDT)
Received: from leesin ([147.46.121.37]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-851d3392a96sm957693b3a.20.2026.08.19.12.25.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 12:25:33 -0700 (PDT)
From: Jaeyoung Chung <jjy600901@snu.ac.kr>
To: deller@gmx.de, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, simona@ffwll.ch, soci@c64.rulez.org
Cc: linux-kernel@vger.kernel.org,
	eulgyukim@snu.ac.kr,
	jjy600901@snu.ac.kr
Subject: [BUG] KASAN: vmalloc-out-of-bounds Read in imageblit
Date: Thu, 20 Aug 2026 04:25:15 +0900
Message-ID: <20260819192516.57820-1-jjy600901@snu.ac.kr>
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

We found a "KASAN: vmalloc-out-of-bounds Read in imageblit" on Linux v7.2.
The issue was found by our own race fuzzer. We have not analyzed the root cause,
so we do not have a proposed fix to offer.

To reproduce the race reliably, we applied the delay patch below to the
kernel and ran the C reproducer as root inside an x86_64 QEMU guest. The
crash log we observed, the delay patch and the reproducer are all included
below.

The following kernel config options are required to reproduce the issue:
    CONFIG_VT=y
    CONFIG_VT_CONSOLE=y
    CONFIG_FB=y
    CONFIG_FB_CORE=y
    CONFIG_FRAMEBUFFER_CONSOLE=y
    CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
    CONFIG_FONT_SUPPORT=y
    CONFIG_FONT_8x16=y
    CONFIG_DRM=y
    CONFIG_DRM_BOCHS=y
    CONFIG_DRM_FBDEV_EMULATION=y
    CONFIG_KASAN=y
    CONFIG_KASAN_VMALLOC=y

We hope this report is useful. Please let us know if any further
information would help.

Reported-by: Eulgyu Kim <eulgyukim@snu.ac.kr>
Reported-by: Jaeyoung Chung <jjy600901@snu.ac.kr>

Kernel delay patch:
==================================================================
diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 23b3c536d53d..774a38378aa5 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -84,6 +84,8 @@
 #include "fbcon.h"
 #include "fbcon_rotate.h"
 #include "fb_internal.h"
+#include <linux/sched.h>	/* syz_rg: current->comm for the comm gates */
+#include <linux/delay.h>	/* syz_rg: mdelay */
 
 /*
  * FIXME: Locking
@@ -1231,6 +1233,13 @@ static void fbcon_init(struct vc_data *vc, bool init)
 		set_blitting_type(vc, info);
 	}
 
+	if (strncmp(current->comm, "syzrepro0", 9) == 0) {
+		pr_info("syz_rg: fbcon_init arm vc=%u fg=%d par_rotate=%d fg_con_rotate=%d var=%ux%u\n",
+			vc->vc_num, fg_console, par->rotate,
+			fb_display[fg_console].con_rotate,
+			info->var.xres, info->var.yres);
+		mdelay(30);
+	}
 	par->p = &fb_display[fg_console];
 }
 
@@ -2432,6 +2441,13 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
 		rows = FBCON_SWAP(par->rotate, info->var.yres, info->var.xres);
 		cols /= w;
 		rows /= h;
+		if (strncmp(current->comm, "syzrepro1", 9) == 0) {
+			pr_info("syz_rg: set_font rot=%d cols=%d rows=%d font=%dx%d var=%ux%u vc=%ux%u\n",
+				par->rotate, cols, rows, w, h,
+				info->var.xres, info->var.yres,
+				vc->vc_cols, vc->vc_rows);
+			mdelay(10);
+		}
 		ret = vc_resize(vc, cols, rows);
 		if (ret)
 			goto err_out;
diff --git a/drivers/video/fbdev/core/fbcon_cw.c b/drivers/video/fbdev/core/fbcon_cw.c
index bde820967eb9..f93a4364f89c 100644
--- a/drivers/video/fbdev/core/fbcon_cw.c
+++ b/drivers/video/fbdev/core/fbcon_cw.c
@@ -15,6 +15,8 @@
 #include <linux/font.h>
 #include <linux/vt_kern.h>
 #include <linux/console.h>
+#include <linux/sched.h>	/* syz_rg: current->comm for the comm gates */
+#include <linux/delay.h>	/* syz_rg: mdelay */
 #include <asm/types.h>
 #include "fbcon.h"
 #include "fbcon_rotate.h"
@@ -137,6 +139,14 @@ static void cw_putcs(struct vc_data *vc, struct fb_info *info,
 	image.width = vc->vc_font.height;
 	image.depth = 1;
 
+	if (strncmp(current->comm, "syzrepro", 8) == 0 &&
+	    vc->vc_cols * vc->vc_font.width > info->var.yres) {
+		pr_info("syz_rg: cw_putcs pre-oob yy=%d xx=%d dx=%u dy=%u iw=%u cols=%u font=%ux%u yres=%u yvirt=%u vxres=%u\n",
+			yy, xx, image.dx, image.dy, image.width,
+			vc->vc_cols, vc->vc_font.width, vc->vc_font.height,
+			info->var.yres, info->var.yres_virtual, vxres);
+		mdelay(5);
+	}
 	if (attribute) {
 		buf = kmalloc(cellsize, GFP_KERNEL);
 		if (!buf)

==================================================================

C reproducer:
==================================================================
#define _GNU_SOURCE
#include <fcntl.h>
#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/ioctl.h>
#include <sys/prctl.h>
#include <unistd.h>

#define SYSCHK(x) ({ long __r = (long)(x); if (__r == -1L) { perror(#x); exit(1); } __r; })

#define FBIOGET_VSCREENINFO 0x4600
#define KDFONTOP            0x4B72
#define KD_FONT_OP_SET      0
#define VT_ACTIVATE         0x5606
#define VT_WAITACTIVE       0x5607
#define VT_DISALLOCATE      0x5608
#define VT_RESIZEX          0x560A

struct kfont_op {
	unsigned int op, flags, width, height, charcount;
	unsigned char *data;
};

struct vt_consize {
	unsigned short v_rows, v_cols, v_vlin, v_clin, v_vcol, v_ccol;
};

static const unsigned int heights[] = { 17, 19, 21, 23, 25, 27, 29, 31, 9, 11, 13, 15 };
static unsigned char font[8192];
static unsigned int xres = 1024, yres = 768;
static int tty0, fresh_vt = -1;
static volatile int phase, stop;

static void wait_phase(int want)
{
	while (phase != want && !stop)
		usleep(200);
}

static void *arm_thread(void *arg)
{
	char path[32];
	int round, fd, n;

	prctl(PR_SET_NAME, "syzrepro0", 0, 0, 0);
	for (round = 0; round < 120 && !stop; round++) {
		wait_phase(0);

		fd = open("/sys/class/graphics/fbcon/rotate", O_WRONLY);
		if (fd >= 0) {
			write(fd, "1\n", 2);
			close(fd);
		}

		n = 8 + (round % 50);
		snprintf(path, sizeof(path), "/dev/tty%d", n);
		fd = open(path, O_RDWR | O_NOCTTY);
		if (fd >= 0) {
			close(fd);
			fresh_vt = n;
		} else {
			fresh_vt = -1;
		}
		phase = 1;

		wait_phase(2);
		if (fresh_vt > 0)
			ioctl(tty0, VT_DISALLOCATE, (unsigned long)fresh_vt);
		fresh_vt = -1;
		phase = 0;
	}
	stop = 1;
	return NULL;
}

static void *trigger_thread(void *arg)
{
	unsigned int h;
	int round;

	prctl(PR_SET_NAME, "syzrepro1", 0, 0, 0);
	for (round = 0; round < 120 && !stop; round++) {
		h = heights[round % 12];
		wait_phase(1);

		if ((round % 4) == 3) {
			struct vt_consize cs;

			memset(&cs, 0, sizeof(cs));
			cs.v_cols = xres / 8;
			cs.v_rows = yres / h ? yres / h : 1;
			ioctl(tty0, VT_RESIZEX, &cs);
		} else {
			struct kfont_op op;

			memset(&op, 0, sizeof(op));
			op.op = KD_FONT_OP_SET;
			op.width = 8;
			op.height = h;
			op.charcount = 256;
			op.data = font;
			ioctl(tty0, KDFONTOP, &op);
		}
		phase = 2;
	}
	stop = 1;
	return NULL;
}

int main(void)
{
	unsigned int var[40];
	pthread_t t0, t1;
	int i, fd;

	for (i = 0; i < (int)sizeof(font); i++)
		font[i] = (unsigned char)(0x55 ^ i);

	fd = open("/dev/fb0", O_RDONLY);
	if (fd >= 0) {
		if (ioctl(fd, FBIOGET_VSCREENINFO, var) == 0) {
			xres = var[0];
			yres = var[1];
		}
		close(fd);
	}

	tty0 = SYSCHK(open("/dev/tty0", O_RDWR | O_NOCTTY));
	if (ioctl(tty0, VT_ACTIVATE, 1) == 0)
		ioctl(tty0, VT_WAITACTIVE, 1);

	pthread_create(&t0, NULL, arm_thread, NULL);
	pthread_create(&t1, NULL, trigger_thread, NULL);
	pthread_join(t0, NULL);
	pthread_join(t1, NULL);
	return 0;
}
==================================================================

Crash log:
==================================================================
BUG: KASAN: vmalloc-out-of-bounds in fb_read_offset drivers/video/fbdev/core/sysmem.h:38 [inline]
BUG: KASAN: vmalloc-out-of-bounds in fb_bitblit drivers/video/fbdev/core/fb_imageblit.h:137 [inline]
BUG: KASAN: vmalloc-out-of-bounds in fb_bitmap1x_imageblit drivers/video/fbdev/core/fb_imageblit.h:275 [inline]
BUG: KASAN: vmalloc-out-of-bounds in fb_bitmap_imageblit drivers/video/fbdev/core/fb_imageblit.h:477 [inline]
BUG: KASAN: vmalloc-out-of-bounds in fb_imageblit drivers/video/fbdev/core/fb_imageblit.h:492 [inline]
BUG: KASAN: vmalloc-out-of-bounds in sys_imageblit+0x10ab/0x1c50 drivers/video/fbdev/core/sysimgblt.c:24
Read of size 8 at addr ffffc90000a81fb8 by task syzrepro1/408

CPU: 2 UID: 0 PID: 408 Comm: syzrepro1 Not tainted 7.2.0-dirty #1 PREEMPT 
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x5e/0x80 lib/dump_stack.c:120
 print_address_description+0x77/0x200 mm/kasan/report.c:378
 print_report+0x64/0x70 mm/kasan/report.c:482
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 fb_read_offset drivers/video/fbdev/core/sysmem.h:38 [inline]
 fb_bitblit drivers/video/fbdev/core/fb_imageblit.h:137 [inline]
 fb_bitmap1x_imageblit drivers/video/fbdev/core/fb_imageblit.h:275 [inline]
 fb_bitmap_imageblit drivers/video/fbdev/core/fb_imageblit.h:477 [inline]
 fb_imageblit drivers/video/fbdev/core/fb_imageblit.h:492 [inline]
 sys_imageblit+0x10ab/0x1c50 drivers/video/fbdev/core/sysimgblt.c:24
 drm_fbdev_shmem_defio_imageblit+0x26/0x110 drivers/gpu/drm/drm_fbdev_shmem.c:39
 cw_putcs_aligned drivers/video/fbdev/core/fbcon_cw.c:113 [inline]
 cw_putcs+0x48c/0x1aa0 drivers/video/fbdev/core/fbcon_cw.c:169
 fbcon_putcs+0x616/0xa50 drivers/video/fbdev/core/fbcon.c:1401
 do_update_region+0x387/0x470 drivers/tty/vt/vt.c:656
 redraw_screen+0x652/0xcb0 drivers/tty/vt/vt.c:1008
 vc_do_resize+0xe4f/0x1490 drivers/tty/vt/vt.c:1309
 vc_resize include/linux/vt_kern.h:49 [inline]
 fbcon_do_set_font+0x693/0x1a90 drivers/video/fbdev/core/fbcon.c:2451
 fbcon_set_font+0x50c/0x750 drivers/video/fbdev/core/fbcon.c:2534
 con_font_set drivers/tty/vt/vt.c:4992 [inline]
 con_font_op+0x8a4/0xce0 drivers/tty/vt/vt.c:5032
 vt_k_ioctl drivers/tty/vt/vt_ioctl.c:474 [inline]
 vt_ioctl+0x719/0x1660 drivers/tty/vt/vt_ioctl.c:745
 tty_ioctl+0x89c/0xa40 drivers/tty/tty_io.c:2792
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xb6/0x100 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf7/0x370 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x79ef7f990d6b
Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 28 00 00
RSP: 002b:000079ef7f08de10 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 000079ef7f990d6b
RDX: 000079ef7f08de70 RSI: 0000000000004b72 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000000 R09: 00007ffe35b301e7
R10: 0000000000000000 R11: 0000000000000246 R12: 000079ef7f08de70
R13: 0000000000000011 R14: 0000583e9d2d80a0 R15: 0000583e9d2da060
 </TASK>

The buggy address belongs to a vmalloc virtual mapping
Memory state around the buggy address:
 ffffc90000a81e80: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
 ffffc90000a81f00: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
>ffffc90000a81f80: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
                                        ^
 ffffc90000a82000: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
 ffffc90000a82080: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
==================================================================
BUG: unable to handle page fault for address: ffffc90000a81fb8
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 100000067 P4D 100000067 PUD 1003ad067 PMD 102b57067 PTE 0
Oops: Oops: 0000 [#1] SMP KASAN PTI
CPU: 2 UID: 0 PID: 408 Comm: syzrepro1 Tainted: G    B               7.2.0-dirty #1 PREEMPT 
Tainted: [B]=BAD_PAGE
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
RIP: 0010:fb_read_offset drivers/video/fbdev/core/sysmem.h:38 [inline]
RIP: 0010:fb_bitblit drivers/video/fbdev/core/fb_imageblit.h:137 [inline]
RIP: 0010:fb_bitmap1x_imageblit drivers/video/fbdev/core/fb_imageblit.h:275 [inline]
RIP: 0010:fb_bitmap_imageblit drivers/video/fbdev/core/fb_imageblit.h:477 [inline]
RIP: 0010:fb_imageblit drivers/video/fbdev/core/fb_imageblit.h:492 [inline]
RIP: 0010:sys_imageblit+0x10d6/0x1c50 drivers/video/fbdev/core/sysimgblt.c:24
Code: 8b 54 24 38 4c 8b 4c 24 20 4c 8b 44 24 10 48 8b 7c 24 08 48 be 00 00 00 00 00 fc ff df 49 c7 c5 ff ff ff ff 44 89 c9 49 d3 e5 <48> 8b 0f 49 f7 d5 48 89 4c 24 50 49 21 cd eb 0c 45 31 ed 48 c7 44
RSP: 0018:ffffc900028ef5f0 EFLAGS: 00010287
RAX: ffff88810a328001 RBX: 0000000000000000 RCX: 0000000000000020
RDX: 0000000000000001 RSI: dffffc0000000000 RDI: ffffc90000a81fb8
RBP: ffffc900028ef6c8 R08: 0000000000000020 R09: 0000000000000020
R10: ffff888102858900 R11: fffffbfff54aabb9 R12: 0000000000000100
R13: ffffffff00000000 R14: 0000000000000000 R15: 0000000000000000
FS:  000079ef7f08e6c0(0000) GS:ffff888170830000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc90000a81fb8 CR3: 0000000108fc6000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 drm_fbdev_shmem_defio_imageblit+0x26/0x110 drivers/gpu/drm/drm_fbdev_shmem.c:39
 cw_putcs_aligned drivers/video/fbdev/core/fbcon_cw.c:113 [inline]
 cw_putcs+0x48c/0x1aa0 drivers/video/fbdev/core/fbcon_cw.c:169
 fbcon_putcs+0x616/0xa50 drivers/video/fbdev/core/fbcon.c:1401
 do_update_region+0x387/0x470 drivers/tty/vt/vt.c:656
 redraw_screen+0x652/0xcb0 drivers/tty/vt/vt.c:1008
 vc_do_resize+0xe4f/0x1490 drivers/tty/vt/vt.c:1309
 vc_resize include/linux/vt_kern.h:49 [inline]
 fbcon_do_set_font+0x693/0x1a90 drivers/video/fbdev/core/fbcon.c:2451
 fbcon_set_font+0x50c/0x750 drivers/video/fbdev/core/fbcon.c:2534
 con_font_set drivers/tty/vt/vt.c:4992 [inline]
 con_font_op+0x8a4/0xce0 drivers/tty/vt/vt.c:5032
 vt_k_ioctl drivers/tty/vt/vt_ioctl.c:474 [inline]
 vt_ioctl+0x719/0x1660 drivers/tty/vt/vt_ioctl.c:745
 tty_ioctl+0x89c/0xa40 drivers/tty/tty_io.c:2792
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xb6/0x100 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf7/0x370 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x79ef7f990d6b
Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 28 00 00
RSP: 002b:000079ef7f08de10 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 000079ef7f990d6b
RDX: 000079ef7f08de70 RSI: 0000000000004b72 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000000 R09: 00007ffe35b301e7
R10: 0000000000000000 R11: 0000000000000246 R12: 000079ef7f08de70
R13: 0000000000000011 R14: 0000583e9d2d80a0 R15: 0000583e9d2da060
 </TASK>
Modules linked in:
CR2: ffffc90000a81fb8
---[ end trace 0000000000000000 ]---
RIP: 0010:fb_read_offset drivers/video/fbdev/core/sysmem.h:38 [inline]
RIP: 0010:fb_bitblit drivers/video/fbdev/core/fb_imageblit.h:137 [inline]
RIP: 0010:fb_bitmap1x_imageblit drivers/video/fbdev/core/fb_imageblit.h:275 [inline]
RIP: 0010:fb_bitmap_imageblit drivers/video/fbdev/core/fb_imageblit.h:477 [inline]
RIP: 0010:fb_imageblit drivers/video/fbdev/core/fb_imageblit.h:492 [inline]
RIP: 0010:sys_imageblit+0x10d6/0x1c50 drivers/video/fbdev/core/sysimgblt.c:24
Code: 8b 54 24 38 4c 8b 4c 24 20 4c 8b 44 24 10 48 8b 7c 24 08 48 be 00 00 00 00 00 fc ff df 49 c7 c5 ff ff ff ff 44 89 c9 49 d3 e5 <48> 8b 0f 49 f7 d5 48 89 4c 24 50 49 21 cd eb 0c 45 31 ed 48 c7 44
RSP: 0018:ffffc900028ef5f0 EFLAGS: 00010287
RAX: ffff88810a328001 RBX: 0000000000000000 RCX: 0000000000000020
RDX: 0000000000000001 RSI: dffffc0000000000 RDI: ffffc90000a81fb8
RBP: ffffc900028ef6c8 R08: 0000000000000020 R09: 0000000000000020
R10: ffff888102858900 R11: fffffbfff54aabb9 R12: 0000000000000100
R13: ffffffff00000000 R14: 0000000000000000 R15: 0000000000000000
FS:  000079ef7f08e6c0(0000) GS:ffff888170830000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc90000a81fb8 CR3: 0000000108fc6000 CR4: 00000000000006f0
----------------
Code disassembly (best guess):
   0:	8b 54 24 38          	mov    0x38(%rsp),%edx
   4:	4c 8b 4c 24 20       	mov    0x20(%rsp),%r9
   9:	4c 8b 44 24 10       	mov    0x10(%rsp),%r8
   e:	48 8b 7c 24 08       	mov    0x8(%rsp),%rdi
  13:	48 be 00 00 00 00 00 	movabs $0xdffffc0000000000,%rsi
  1a:	fc ff df
  1d:	49 c7 c5 ff ff ff ff 	mov    $0xffffffffffffffff,%r13
  24:	44 89 c9             	mov    %r9d,%ecx
  27:	49 d3 e5             	shl    %cl,%r13
* 2a:	48 8b 0f             	mov    (%rdi),%rcx <-- trapping instruction
  2d:	49 f7 d5             	not    %r13
  30:	48 89 4c 24 50       	mov    %rcx,0x50(%rsp)
  35:	49 21 cd             	and    %rcx,%r13
  38:	eb 0c                	jmp    0x46
  3a:	45 31 ed             	xor    %r13d,%r13d
  3d:	48                   	rex.W
  3e:	c7                   	.byte 0xc7
  3f:	44                   	rex.R
==================================================================


