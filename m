Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77FCAC44512
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 06:50:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D197B10EC6B;
	Wed, 22 Jul 2026 06:50:22 +0000 (UTC)
X-Greylist: delayed 1165 seconds by postgrey-1.36 at gabe;
 Wed, 22 Jul 2026 06:50:21 UTC
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com
 [45.249.212.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 812DF10EC6A
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 06:50:21 +0000 (UTC)
Received: from mail.maildlp.com (unknown [172.19.163.198])
 by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4h4krd5Sz3zKHMLJ
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 14:30:09 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
 by mail.maildlp.com (Postfix) with ESMTP id 0C2A540836
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 14:30:53 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
 by APP1 (Coremail) with UTF8SMTPSA id cCh0CgCX8W2bY2BqWgB7CA--.42682S4;
 Wed, 22 Jul 2026 14:30:52 +0800 (CST)
From: Zizhi Wo <wozizhi@huaweicloud.com>
To: simona@ffwll.ch, deller@gmx.de, tzimmermann@suse.de, sam@ravnborg.org,
 ville.syrjala@linux.intel.com
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, yangerkun@huawei.com,
 chengzhihao1@huawei.com, wozizhi@huawei.com
Subject: [PATCH V2] fbdev: Fix out-of-bounds access when rotating console
 after font resize
Date: Wed, 22 Jul 2026 14:22:16 +0800
Message-ID: <20260722062216.2574546-1-wozizhi@huaweicloud.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgCX8W2bY2BqWgB7CA--.42682S4
X-Coremail-Antispam: 1UD129KBjvJXoWxKFy5AryUGry8JryfGF43Awb_yoW7trWUpF
 12kr17Krs0q3Z3Zr4qgr45uF1aqw4DJry5WrZ3t3WYya45ZFWvv3ZrJFyDurW8urn3Cryr
 Z3WrKrW2kayq9aDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
 6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
 vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
 xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x
 0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
 6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
 Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0E
 n4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
 0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWU
 tVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcV
 CY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAF
 wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
 7IU17KsUUUUUU==
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/
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

From: Zizhi Wo <wozizhi@huawei.com>

[BUG]
Recently, we encountered a KASAN warning as follows:

BUG: KASAN: slab-out-of-bounds in ccw_putcs+0x8bd/0xa80
Read of size 1 at addr ff11000110067100 by task bash/1209
CPU: 10 UID: 0 PID: 1209 Comm: bash Not tainted 7.2.0-rc3 #69 PREEMPT(full)
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-4.fc41 04/01/2014
 Call Trace:
  <TASK>
  ...
  kasan_report+0xf0/0x120
  ? ccw_putcs+0x8bd/0xa80
  ccw_putcs+0x8bd/0xa80
  ? __pfx_ccw_putcs+0x10/0x10
  fbcon_putcs+0x338/0x410
  ? __pfx_ccw_putcs+0x10/0x10
  do_update_region+0x21d/0x450
  invert_screen+0x29d/0x5e0
  ? __kmalloc_noprof+0x493/0x640
  ? vc_do_resize+0x17c/0xe50
  clear_selection+0x4c/0x60
  vc_do_resize+0xaee/0xe50
  fbcon_modechanged+0x2bd/0x640
  rotate_all_store+0x298/0x380
  ...

reproduce:
1) issue two ioctls: first a KDFONTOP ioctl with op.op = KD_FONT_OP_SET,
op.width = 1 and op.height = 1, then a TIOCL_SETSEL ioctl
2) echo 2 > /sys/devices/virtual/graphics/fbcon/rotate_all
3) issue two ioctls: first a KDFONTOP ioctl with op.op = KD_FONT_OP_SET,
op.width = 8 and op.height = 1, then a TIOCL_SETSEL ioctl
4) echo 3 > /sys/devices/virtual/graphics/fbcon/rotate_all

[CAUSE]
The root cause is that fbcon_modechanged() first sets the current rotate's
corresponding ops. Subsequently, during vc_resize(), it may trigger
clear_selection(), and in fbcon_putcs->ccw_putcs[rotate=3], this can result
in an out-of-bounds access to "src". This happens because par->rotated.buf
is reallocated in fbcon_rotate_font():
1) When rotate=2, its size is (width + 7) / 8 * height
2) When rotate=3, its size is (height + 7) / 8 * width

And the call to fbcon_rotate_font() occurs after clear_selection(). In
other words, the fontbuffer is allocated using the size calculated from the
previous rotation 2, but before reallocating it with the new size,
con_putcs is already using the new rotation 3:

rotate_all_store
 fbcon_rotate_all
  fbcon_set_all_vcs
   fbcon_modechanged
    set_blitting_type
    ...
     par->bitops = &ccw_fbcon_bitops
    vc_resize
    ...
     clear_selection
      highlight
      ...
       do_update_region
	fbcon_putcs
	...
	 image.dy = vyres - ((xx + count) * vc->vc_font.width) [1]  // overflow!
	 ccw_putcs_aligned
	  // old buf size is still being used during the read!
	  src = par->rotated.buf + (scr_readw(s--) & charmask) * cellsize
	  fb_pad_aligned_buffer----[src KASAN!!!]	[2]
	  info->fbops->fb_imageblit(info, image)
	   sys_imageblit
	    fb_imageblit
	     fb_address_forward
	      // offset: image->dy * bits_per_line + image->dx * bpp
	      unsigned int bits = (unsigned int)adr->bits + offset
	      adr->address += (bits & ~(BITS_PER_LONG - 1u)) / BITS_PER_BYTE	[3]
	     fb_bitmap_imageblit
	     ...
	      fb_read_offset	// page fault!	[4]
    update_screen
     redraw_screen
     ...
      ccw_cursor
       soft_cursor
        memcpy(src, image->data, dsize)----[src KASAN again!!!]	[5]
     fbcon_switch
      fbcon_rotate_font
       font_data_rotate
	dst = kmalloc_array(charcount, d_cellsize, GFP_KERNEL)
       // the new size is allocated only here!
       par->rotated.buf = buf	[6]

[FIX]
A fairly obvious approach is to follow fbcon_switch(): in
fbcon_modechanged(), call rotate_font() before vc_resize() so that a
correctly sized buffer is allocated in time, as done in [6]. This fix is
necessary, but it is not sufficient on its own.

In [1] it causes an image.dy overflow (ccw_putcs: vyres = 768,
image.dy = 4294967040), because vc_cols has not been updated in time at
this point (it is likewise only updated after clear_selection()). This
allows (xx + count) * width to exceed vyres, causing image.dy to overflow.
Subsequently, address in [3] is incremented by an even larger amount, which
triggers a page fault at [4].

Therefore, a second fix is required in combination with the first: move
clear_selection() earlier, before set_blitting_type() in
fbcon_set_all_vcs(), to prevent the out-of-bounds access. fbcon_rotate()
has a similar problem, so add the same clear there. Since vc_is_sel() is
not exported, the fbdev side is currently forced to call clear_selection()
unconditionally, causing the global selection to be cleared prematurely.
And this will not cause any other significant impact.

Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
---
v2:
Fixed the issue by calling clear_selection() earlier, and updated the
related description in the commit message.

v1: https://lore.kernel.org/all/20250905024340.337521-1-wozizhi@huaweicloud.com/
---
 drivers/video/fbdev/core/fbcon.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 9f5c4c101581..3361479d139d 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2639,13 +2639,20 @@ static void fbcon_modechanged(struct fb_info *info)
 	vc = vc_cons[par->currcon].d;
 	if (vc->vc_mode != KD_TEXT ||
 	    fbcon_info_from_console(par->currcon) != info)
 		return;
 
+	clear_selection();
+
 	p = &fb_display[vc->vc_num];
 	set_blitting_type(vc, info);
 
+	if (par->bitops->rotate_font && par->bitops->rotate_font(info, vc)) {
+		par->rotate = FB_ROTATE_UR;
+		set_blitting_type(vc, info);
+	}
+
 	if (con_is_visible(vc)) {
 		var_to_display(p, &info->var, info);
 		cols = FBCON_SWAP(par->rotate, info->var.xres, info->var.yres);
 		rows = FBCON_SWAP(par->rotate, info->var.yres, info->var.xres);
 		cols /= vc->vc_font.width;
@@ -2673,10 +2680,12 @@ static void fbcon_set_all_vcs(struct fb_info *info)
 	int i, rows, cols, fg = -1;
 
 	if (!par || par->currcon < 0)
 		return;
 
+	clear_selection();
+
 	for (i = first_fb_vc; i <= last_fb_vc; i++) {
 		vc = vc_cons[i].d;
 		if (!vc || vc->vc_mode != KD_TEXT ||
 		    fbcon_info_from_console(i) != info)
 			continue;
-- 
2.52.0

