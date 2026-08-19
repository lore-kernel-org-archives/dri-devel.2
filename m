Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0458C5DF86
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 08:48:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAEC110EF5E;
	Thu, 20 Aug 2026 08:48:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=snu.ac.kr header.i=@snu.ac.kr header.b="GuyB54ee";
	dkim-atps=neutral
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C82710E166
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 16:34:50 +0000 (UTC)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-383b4a3755fso1205357a91.3
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 09:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=snu.ac.kr; s=google; t=1787157289; x=1787762089; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=SciAtpaFLHaXdN0fISEnWrIpHa6KFhRQKeuCrMjWs18=;
 b=GuyB54eemqhBiFfF0XInUfEvvqsVlfKipDZf+BBT7SApPT1CezSfSf4wp/9KPShq1p
 hkr3l+vDZQY9/PMu3sUJCT9FtgXSvz5DF6swbAc9w+BodG8GSu0nhJN56SkACOKaKaYh
 mzz6uzUQlG+6lwNNz0Vjudzej8YzD/KNVh0ZI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787157289; x=1787762089;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SciAtpaFLHaXdN0fISEnWrIpHa6KFhRQKeuCrMjWs18=;
 b=BReeeeZSvlKpGr3M8oxbF7QYQ/Yyr2fxsQzo1oTKI2HNmcpZocYvX72hw2dDzVNaCg
 5TjccbdbrxEWDwqMWDh77GXKSrq/Ygc/TxIyM3IorlY6KPSk6L1NvU4W6TMNBuTWlcQG
 aF+u14/+hCoWzH+PWY3T3uB5tQK+rJoZWS6dHkI6wCw4xVNmzc6pF/OBjA3cydejsCar
 HZKaEtcC0pVAKgwP61Pm6xpHTMxQfiusER//UrJhiosUFjNuuMkl0kOicSsVdlnAAbav
 JgTYsSFTSTpmRW+UOqI9P36ZCCNGf2M/Dw8pEjDVPZaWZ5TW56cZljf0cQHrULl8tvIC
 BKXA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoGLrQuPGyURnzmbEs12nMYV5l8N1BzUQ8ikjKs3RJaOWAQJszIPAitswjm55jjEMqRFaM7jIK1KiM=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nw2KXaXMI4HoxPy2RKl5K20Qz9RCdd2Vndiy3OppzuuWFGDOe7
 KhTXyQyqjiCFNrTT9QWWmWWz7iaBOy5N5Tjib7KRxeBV4vpzqg+Wp5ecRzwFV2bxW4s=
X-Gm-Gg: AR+sD116UV1ZwzF1gzukR1CEIXdpWX1U7JuNhebva76lXJW5nP8k/qc5G0PWbtIq6wZ
 OwV107/D/Qn71qKBRegloiDV5wuUmy4ICNW1hO4kwblUfr71vmj7fSXHVMis17IHkTmH3XYg/mJ
 ufVkWz79yMswbyqv3ehe/vLInZZOSkHrS4ifcKYoq4ZNJMT9FO9CxXgONg+NramBPOeYdsfCnqi
 LgIASM3qO6VI773tAjBsKQnURIC0DIT80EUHa899d/X1UVHgko7/aEpNRbBPvW1Obtgkc6rRnGy
 oymcb9gDDx1p6HONTBmULnWZYZGv5swe1dDsdepGCoVOsQahwM0Hj7a/EDlEkZsRGN6dZSXhcVD
 DfMzsLMQ4cnJG371x0Jo3bcUhjeafH4lBYWGZkqbfgLFJSDPaDoMcMDbeYOMtdFnXl9G6C5tMeu
 Vl3oGUCXeuMpsT1NajaCO4HyCttvV7YlrBABlHeRMVt2lyL7fXV0NLlO/i1UPIkeh0fTgqt/lRi
 1he/T4Wu1NPt/8pgv0jtJzyC0DlXG1L6wFGe7SJEQqQV4GKNHA+i6Lx8fCROw64LWFWXwhNi5Tk
 12HJ6X4zGM+AYKeW3IEVWgC+ZwPsrzelTb+NTylXyxPu6RtCz91/qw==
X-Received: by 2002:a17:90b:5684:b0:395:5eec:b932 with SMTP id
 98e67ed59e1d1-39580f6b704mr11763668a91.11.1787157289392; 
 Wed, 19 Aug 2026 09:34:49 -0700 (PDT)
Received: from leesin ([147.46.121.37]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3957f875f38sm1432887a91.4.2026.08.19.09.34.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 09:34:48 -0700 (PDT)
From: Jaeyoung Chung <jjy600901@snu.ac.kr>
To: deller@gmx.de, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, simona@ffwll.ch, tzimmermann@suse.de
Cc: linux-kernel@vger.kernel.org,
	eulgyukim@snu.ac.kr,
	jjy600901@snu.ac.kr
Subject: [BUG] KASAN: slab-out-of-bounds Read in soft_cursor
Date: Thu, 20 Aug 2026 01:34:39 +0900
Message-ID: <20260819163440.3702924-1-jjy600901@snu.ac.kr>
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

We found a "KASAN: slab-out-of-bounds Read in soft_cursor" on Linux v7.2.
The issue was found by our own race fuzzer. We have not analyzed the root
cause, so we do not have a proposed fix to offer.

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

We hope this report is useful. Please let us know if any further
information would help.

Reported-by: Eulgyu Kim <eulgyukim@snu.ac.kr>
Reported-by: Jaeyoung Chung <jjy600901@snu.ac.kr>

Kernel delay patch:
==================================================================
diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 8f467b22b799..e4d9233c4f5f 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -86,6 +86,7 @@
 #include <linux/major.h>
 #include <linux/mm.h>
 #include <linux/console.h>
+#include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/mutex.h>
 #include <linux/vt_kern.h>
@@ -4979,6 +4980,9 @@ static int con_font_set(struct vc_data *vc, const struct console_font_op *op)
 	font.width = op->width;
 	font.height = op->height;
 
+	if (!strncmp(current->comm, "syzrepro", 8) &&
+	    op->width == 32 && op->height == 30 && op->charcount == 512)
+		mdelay(100);
 	guard(console_lock)();
 
 	if (vc->vc_mode != KD_TEXT)
diff --git a/drivers/video/fbdev/core/fbcon_rotate.c b/drivers/video/fbdev/core/fbcon_rotate.c
index 6cdbc96eeca6..f4797dc2dd78 100644
--- a/drivers/video/fbdev/core/fbcon_rotate.c
+++ b/drivers/video/fbdev/core/fbcon_rotate.c
@@ -9,6 +9,8 @@
  */
 
 #include <linux/errno.h>
+#include <linux/delay.h>
+#include <linux/string.h>
 #include <linux/fb.h>
 #include <linux/font.h>
 
@@ -38,6 +40,9 @@ int fbcon_rotate_font(struct fb_info *info, struct vc_data *vc)
 		ret = PTR_ERR(buf);
 		goto err_kfree;
 	}
+	if (!strncmp(current->comm, "syzrepro", 8) &&
+	    par->rotated.bufsize == 4096)
+		mdelay(50);
 
 	par->rotated.buf = buf;
 
==================================================================

C reproducer:
==================================================================
#define _GNU_SOURCE
#include <fcntl.h>
#include <linux/kd.h>
#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/ioctl.h>
#include <sys/prctl.h>
#include <unistd.h>

#define SYSCHK(x) ({ long __r = (long)(x); if (__r == -1L) { perror(#x); exit(1); } __r; })

static pthread_barrier_t start;
static unsigned char font[4U * 32U * 512U];

static void *rotate_thread(void *arg)
{
	int fd;

	prctl(PR_SET_NAME, "syzrepro0", 0, 0, 0);
	pthread_barrier_wait(&start);
	fd = SYSCHK(open("/sys/class/graphics/fbcon/rotate_all", O_WRONLY));
	SYSCHK(write(fd, "1", 1));
	close(fd);
	return NULL;
}

static void *font_thread(void *arg)
{
	struct console_font_op op = { .op = KD_FONT_OP_SET, .width = 32,
				      .height = 30, .charcount = 512, .data = font };
	int fd;

	prctl(PR_SET_NAME, "syzrepro1", 0, 0, 0);
	pthread_barrier_wait(&start);
	fd = SYSCHK(open("/dev/tty1", O_RDWR | O_NOCTTY));
	ioctl(fd, KDFONTOP, &op);
	close(fd);
	return NULL;
}

int main(void)
{
	pthread_t t[2];

	memset(font, 0x5a, sizeof(font));
	pthread_barrier_init(&start, NULL, 2);
	pthread_create(&t[0], NULL, rotate_thread, NULL);
	pthread_create(&t[1], NULL, font_thread, NULL);
	pthread_join(t[0], NULL);
	pthread_join(t[1], NULL);
	return 0;
}
==================================================================


Crash log:
==================================================================
BUG: KASAN: slab-out-of-bounds in soft_cursor+0x3eb/0xb70 drivers/video/fbdev/core/softcursor.c:70
Read of size 128 at addr ffff88810792d000 by task syzrepro1/401

CPU: 2 UID: 0 PID: 401 Comm: syzrepro1 Not tainted 7.2.0-dirty #1 PREEMPT 
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x5e/0x80 lib/dump_stack.c:120
 print_address_description+0x77/0x200 mm/kasan/report.c:378
 print_report+0x64/0x70 mm/kasan/report.c:482
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 check_region_inline mm/kasan/generic.c:-1 [inline]
 kasan_check_range+0x2b0/0x2c0 mm/kasan/generic.c:200
 __asan_memcpy+0x29/0x70 mm/kasan/shadow.c:105
 soft_cursor+0x3eb/0xb70 drivers/video/fbdev/core/softcursor.c:70
 cw_cursor+0x1322/0x2080 drivers/video/fbdev/core/fbcon_cw.c:324
 hide_cursor+0x84/0x350 drivers/tty/vt/vt.c:884
 redraw_screen+0x3b9/0xcb0 drivers/tty/vt/vt.c:986
 vc_do_resize+0xe4f/0x1490 drivers/tty/vt/vt.c:1310
 vc_resize include/linux/vt_kern.h:49 [inline]
 fbcon_do_set_font+0x666/0x1980 drivers/video/fbdev/core/fbcon.c:2435
 fbcon_set_font+0x50c/0x750 drivers/video/fbdev/core/fbcon.c:2518
 con_font_set drivers/tty/vt/vt.c:4996 [inline]
 con_font_op+0x91b/0xdc0 drivers/tty/vt/vt.c:5036
 vt_k_ioctl drivers/tty/vt/vt_ioctl.c:474 [inline]
 vt_ioctl+0x719/0x1660 drivers/tty/vt/vt_ioctl.c:745
 tty_ioctl+0x89c/0xa40 drivers/tty/tty_io.c:2792
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xb6/0x100 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf7/0x370 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x7fa577d5ad6b
Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 28 00 00
RSP: 002b:00007fa577457e40 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007fa577d5ad6b
RDX: 00007fa577457ea0 RSI: 0000000000004b72 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000002
R10: 0000000000000000 R11: 0000000000000246 R12: ffffffffffffff80
R13: 0000000000000000 R14: 00007ffdf1422270 R15: 00007fa576c58000
 </TASK>

Allocated by task 400:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0x72/0x90 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __do_kmalloc_node mm/slub.c:5334 [inline]
 __kmalloc_noprof+0x20f/0x4b0 mm/slub.c:5359
 _kmalloc_noprof include/linux/slab.h:992 [inline]
 _kmalloc_array_noprof include/linux/slab.h:1208 [inline]
 font_data_rotate+0xc1/0x6f0 lib/fonts/font_rotate.c:231
 fbcon_rotate_font+0x2d5/0x520 drivers/video/fbdev/core/fbcon_rotate.c:35
 fbcon_modechanged+0x280/0x11f0 drivers/video/fbdev/core/fbcon.c:2664
 fbcon_rotate_all drivers/video/fbdev/core/fbcon.c:254 [inline]
 rotate_all_store+0x140/0x4c0 drivers/video/fbdev/core/fbcon.c:3218
 kernfs_fop_write_iter+0x289/0x3c0 fs/kernfs/file.c:345
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x7a2/0xa10 fs/read_write.c:687
 ksys_write+0xb0/0x170 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf7/0x370 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

The buggy address belongs to the object at ffff88810792c000
 which belongs to the cache kmalloc-4k of size 4096
The buggy address is located 0 bytes to the right of
 allocated 4096-byte region [ffff88810792c000, ffff88810792d000)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x107928
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x200000000000040(head|node=0|zone=2)
page_type: f5(slab)
raw: 0200000000000040 ffff888100043040 dead000000000100 dead000000000122
raw: 0000000000000000 0000000800040004 00000000f5000000 0000000000000000
head: 0200000000000040 ffff888100043040 dead000000000100 dead000000000122
head: 0000000000000000 0000000800040004 00000000f5000000 0000000000000000
head: 0200000000000003 fffffffffffffe01 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff88810792cf00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88810792cf80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff88810792d000: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                   ^
 ffff88810792d080: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88810792d100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


