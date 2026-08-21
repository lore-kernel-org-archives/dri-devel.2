Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 490E7C5DF87
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 08:14:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A120110F273;
	Fri, 21 Aug 2026 08:14:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fR2oN5oO";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC8CC10F273
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 08:14:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E025660A7A;
 Fri, 21 Aug 2026 08:14:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 668BF1F000E9;
 Fri, 21 Aug 2026 08:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787300045;
 bh=mu3+VK3ISRUdF3OJOLxNYQ1Sn/6+qFNCbg3T5ZXJxBg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=fR2oN5oO0bRCmlosf1ulDx8FrDlOhXY0lC6fXO0//MqnH5HYKEz5Obeb2yl+vPW0m
 bVn/EbMftMn0Si5paf55JFUDHEEe0nf2FKcDkrGwyCluT5kyIHxNI8upSkG3Rn9asK
 JFKLIafU3DjC6/62w5o7oM/xlsh+4HGSdP88zO+Qs/RHTs2e9cxe64Ncqd1ioO0t0a
 We+AEV5ij0+T83XJ9I5An5Hjqy3rHJMNH8b8LTQmS/Cr9A5VOC8N7Cfjr4NPSC4yn2
 jYmDjTIQoLEPBRcbjOimsrlkcafGk4IOUdLe95TSfCRW3JVMzwTtWmHUqmY3AT4niR
 UfTKVrEVBOOsw==
Date: Fri, 21 Aug 2026 10:14:00 +0200
From: Helge Deller <deller@kernel.org>
To: Jaeyoung Chung <jjy600901@snu.ac.kr>
Cc: deller@gmx.de, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, simona@ffwll.ch, tzimmermann@suse.de,
 linux-kernel@vger.kernel.org, eulgyukim@snu.ac.kr
Subject: Re: [BUG] KASAN: slab-out-of-bounds Read in soft_cursor
Message-ID: <aogIyAk7AJ-uFP72@carbonx1>
References: <20260819163440.3702924-1-jjy600901@snu.ac.kr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260819163440.3702924-1-jjy600901@snu.ac.kr>
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

* Jaeyoung Chung <jjy600901@snu.ac.kr>:
> Hello,
> 
> We found a "KASAN: slab-out-of-bounds Read in soft_cursor" on Linux v7.2.
> The issue was found by our own race fuzzer. We have not analyzed the root
> cause, so we do not have a proposed fix to offer.
> 
> To reproduce the race reliably, we applied the delay patch below to the
> kernel and ran the C reproducer as root inside an x86_64 QEMU guest. The
> crash log we observed, the delay patch and the reproducer are all included
> below.
> 
> The following kernel config options are required to reproduce the issue:
>     CONFIG_VT=y
>     CONFIG_VT_CONSOLE=y
>     CONFIG_FB=y
>     CONFIG_FB_CORE=y
>     CONFIG_FRAMEBUFFER_CONSOLE=y
>     CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
>     CONFIG_FONT_SUPPORT=y
>     CONFIG_FONT_8x16=y
>     CONFIG_DRM=y
>     CONFIG_DRM_BOCHS=y
>     CONFIG_DRM_FBDEV_EMULATION=y
>     CONFIG_KASAN=y
> 
> We hope this report is useful. Please let us know if any further
> information would help.
> 
> Reported-by: Eulgyu Kim <eulgyukim@snu.ac.kr>
> Reported-by: Jaeyoung Chung <jjy600901@snu.ac.kr>
> 
> Kernel delay patch:
> ==================================================================
> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index 8f467b22b799..e4d9233c4f5f 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -86,6 +86,7 @@
>  #include <linux/major.h>
>  #include <linux/mm.h>
>  #include <linux/console.h>
> +#include <linux/delay.h>
>  #include <linux/init.h>
>  #include <linux/mutex.h>
>  #include <linux/vt_kern.h>
> @@ -4979,6 +4980,9 @@ static int con_font_set(struct vc_data *vc, const struct console_font_op *op)
>  	font.width = op->width;
>  	font.height = op->height;
>  
> +	if (!strncmp(current->comm, "syzrepro", 8) &&
> +	    op->width == 32 && op->height == 30 && op->charcount == 512)
> +		mdelay(100);
>  	guard(console_lock)();
>  
>  	if (vc->vc_mode != KD_TEXT)
> diff --git a/drivers/video/fbdev/core/fbcon_rotate.c b/drivers/video/fbdev/core/fbcon_rotate.c
> index 6cdbc96eeca6..f4797dc2dd78 100644
> --- a/drivers/video/fbdev/core/fbcon_rotate.c
> +++ b/drivers/video/fbdev/core/fbcon_rotate.c
> @@ -9,6 +9,8 @@
>   */
>  
>  #include <linux/errno.h>
> +#include <linux/delay.h>
> +#include <linux/string.h>
>  #include <linux/fb.h>
>  #include <linux/font.h>
>  
> @@ -38,6 +40,9 @@ int fbcon_rotate_font(struct fb_info *info, struct vc_data *vc)
>  		ret = PTR_ERR(buf);
>  		goto err_kfree;
>  	}
> +	if (!strncmp(current->comm, "syzrepro", 8) &&
> +	    par->rotated.bufsize == 4096)
> +		mdelay(50);
>  
>  	par->rotated.buf = buf;
>  
> ==================================================================
> 
> C reproducer:
> ==================================================================
> #define _GNU_SOURCE
> #include <fcntl.h>
> #include <linux/kd.h>
> #include <pthread.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <string.h>
> #include <sys/ioctl.h>
> #include <sys/prctl.h>
> #include <unistd.h>
> 
> #define SYSCHK(x) ({ long __r = (long)(x); if (__r == -1L) { perror(#x); exit(1); } __r; })
> 
> static pthread_barrier_t start;
> static unsigned char font[4U * 32U * 512U];
> 
> static void *rotate_thread(void *arg)
> {
> 	int fd;
> 
> 	prctl(PR_SET_NAME, "syzrepro0", 0, 0, 0);
> 	pthread_barrier_wait(&start);
> 	fd = SYSCHK(open("/sys/class/graphics/fbcon/rotate_all", O_WRONLY));
> 	SYSCHK(write(fd, "1", 1));
> 	close(fd);
> 	return NULL;
> }
> 
> static void *font_thread(void *arg)
> {
> 	struct console_font_op op = { .op = KD_FONT_OP_SET, .width = 32,
> 				      .height = 30, .charcount = 512, .data = font };
> 	int fd;
> 
> 	prctl(PR_SET_NAME, "syzrepro1", 0, 0, 0);
> 	pthread_barrier_wait(&start);
> 	fd = SYSCHK(open("/dev/tty1", O_RDWR | O_NOCTTY));
> 	ioctl(fd, KDFONTOP, &op);
> 	close(fd);
> 	return NULL;
> }
> 
> int main(void)
> {
> 	pthread_t t[2];
> 
> 	memset(font, 0x5a, sizeof(font));
> 	pthread_barrier_init(&start, NULL, 2);
> 	pthread_create(&t[0], NULL, rotate_thread, NULL);
> 	pthread_create(&t[1], NULL, font_thread, NULL);
> 	pthread_join(t[0], NULL);
> 	pthread_join(t[1], NULL);
> 	return 0;
> }
> ==================================================================
> 
> 
> Crash log:
> ==================================================================
> BUG: KASAN: slab-out-of-bounds in soft_cursor+0x3eb/0xb70 drivers/video/fbdev/core/softcursor.c:70
> Read of size 128 at addr ffff88810792d000 by task syzrepro1/401
> 
> CPU: 2 UID: 0 PID: 401 Comm: syzrepro1 Not tainted 7.2.0-dirty #1 PREEMPT 
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x5e/0x80 lib/dump_stack.c:120
>  print_address_description+0x77/0x200 mm/kasan/report.c:378
>  print_report+0x64/0x70 mm/kasan/report.c:482
>  kasan_report+0x118/0x150 mm/kasan/report.c:595
>  check_region_inline mm/kasan/generic.c:-1 [inline]
>  kasan_check_range+0x2b0/0x2c0 mm/kasan/generic.c:200
>  __asan_memcpy+0x29/0x70 mm/kasan/shadow.c:105
>  soft_cursor+0x3eb/0xb70 drivers/video/fbdev/core/softcursor.c:70
>  cw_cursor+0x1322/0x2080 drivers/video/fbdev/core/fbcon_cw.c:324
>  hide_cursor+0x84/0x350 drivers/tty/vt/vt.c:884
>  redraw_screen+0x3b9/0xcb0 drivers/tty/vt/vt.c:986
>  vc_do_resize+0xe4f/0x1490 drivers/tty/vt/vt.c:1310
>  vc_resize include/linux/vt_kern.h:49 [inline]
>  fbcon_do_set_font+0x666/0x1980 drivers/video/fbdev/core/fbcon.c:2435
>  fbcon_set_font+0x50c/0x750 drivers/video/fbdev/core/fbcon.c:2518
>  con_font_set drivers/tty/vt/vt.c:4996 [inline]
>  con_font_op+0x91b/0xdc0 drivers/tty/vt/vt.c:5036
>  vt_k_ioctl drivers/tty/vt/vt_ioctl.c:474 [inline]
>  vt_ioctl+0x719/0x1660 drivers/tty/vt/vt_ioctl.c:745
>  tty_ioctl+0x89c/0xa40 drivers/tty/tty_io.c:2792
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:597 [inline]
>  __se_sys_ioctl+0xb6/0x100 fs/ioctl.c:583
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xf7/0x370 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e

I think we need to hide the cursor (in addition to drop the selection).
The position of both may be outside the new screen limits when changing
font sizes.

Can you test the patch below?

Helge


From a383c7ac62d839a94ceb53ad363ccba541165c4a Mon Sep 17 00:00:00 2001
From: Helge Deller <deller@gmx.de>
Date: Fri, 21 Aug 2026 10:01:22 +0200
Subject: [PATCH] vt: hide cursor prior to font changes to avoid out-of-bound
 reads

When changing the size of a sceen font, the amount of columns and rows
on a screen may change and thus the current position of the cursor and
the selection may suddenly lay outside of the current screen limits.
This may lead to slab-out-of-bounds errors as reported by KASAN.

Reported-by: Jaeyoung Chung <jjy600901@snu.ac.kr>
Signed-off-by: Helge Deller <deller@gmx.de>
Link: https://lore.kernel.org/all/20260819163440.3702924-1-jjy600901@snu.ac.kr/

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 8f467b22b799..30c6ea48c338 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -4986,8 +4986,8 @@ static int con_font_set(struct vc_data *vc, const struct console_font_op *op)
 	if (!vc->vc_sw->con_font_set)
 		return -ENOSYS;
 
-	if (vc_is_sel(vc))
-		clear_selection();
+	/* hide selection and cursor - due to font size change they might be outside of screen afterwards */
+	hide_cursor(vc);
 
 	return vc->vc_sw->con_font_set(vc, &font, vpitch, op->flags);
 }
@@ -5011,8 +5011,9 @@ static int con_font_default(struct vc_data *vc, struct console_font_op *op)
 		if (!vc->vc_sw->con_font_default)
 			return -ENOSYS;
 
-		if (vc_is_sel(vc))
-			clear_selection();
+		/* hide selection and cursor - due to font size change they might be outside of screen afterwards */
+		hide_cursor(vc);
+
 		int ret = vc->vc_sw->con_font_default(vc, &font, s);
 		if (ret)
 			return ret;

