Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20313CC6B3A
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 07:57:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1447811217B;
	Thu, 15 Oct 2026 07:57:02 +0000 (UTC)
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com
 [113.46.200.220])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9D2B10FC4F
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 09:09:42 +0000 (UTC)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=no8UksaLDXaLjS5OYlOdeSrGlrw0y7An++0sfqkG2yk=;
 b=S6sbRlMk7yfHk2lzfRo5iWjIj8e7rtJiRuB3reuV3SxWnwZCcStXOeZLHuVm4zRIHzarmQ4m2
 V9VM1ZtIFdjW9Zf2kD+c7Fomdx0w05uaYhHuJo2etMdetKqS8wkq+6gt0/3Qav9NzVnNwhYJBED
 riv4Jlitu9KHPsKkB9TEb3o=
Received: from mail.maildlp.com (unknown [172.19.162.144])
 by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4j4Q895GCVz12LHj;
 Wed, 14 Oct 2026 16:57:45 +0800 (CST)
Received: from whupemp100012.china.huawei.com (unknown [7.152.185.135])
 by mail.maildlp.com (Postfix) with ESMTPS id BFD8C4056D;
 Wed, 14 Oct 2026 17:09:39 +0800 (CST)
Received: from huawei.com (10.67.174.121) by whupemp100012.china.huawei.com
 (7.152.185.135) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 14 Oct
 2026 17:09:38 +0800
From: Yao Yiqi <yaoyiqi3@huawei.com>
To: <deller@gmx.de>, <tzimmermann@suse.de>, <simona@ffwll.ch>
CC: <dri-devel@lists.freedesktop.org>, <linux-fbdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] fbcon: Rebuild rotated font buffer on font change
Date: Wed, 14 Oct 2026 08:51:01 +0000
Message-ID: <20261014085102.497789-1-yaoyiqi3@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.67.174.121]
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 whupemp100012.china.huawei.com (7.152.185.135)
X-Mailman-Approved-At: Thu, 15 Oct 2026 07:56:36 +0000
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

fbcon_rotate_font() caches a rotated copy of the console font in
par->rotated.buf. The buffer is sized from the font's width, height and
charcount, and is rebuilt in fbcon_init(), fbcon_switch() and
fbcon_modechanged(), but not in fbcon_do_set_font().

When the console font is changed through KDFONTOP/KD_FONT_OP_SET, the new
font data and geometry are installed and vc_resize() is called. The
resulting redraw reaches the rotated bitops before the buffer is rebuilt:
hide_cursor() drives both con_cursor() -> soft_cursor() and fbcon_putc()
-> *_putcs(), and they index par->rotated.buf with the new cell size and
character codes. A stale, too-small buffer is read out of bounds.

KASAN reports, for example:

  BUG: KASAN: slab-out-of-bounds in soft_cursor
  Read of size 64 at addr ...
   memcpy
   soft_cursor
   cw_cursor
   fbcon_cursor
   hide_cursor
   redraw_screen
   vc_do_resize
   fbcon_do_set_font
   fbcon_set_font
   con_font_op
   vt_ioctl

Rebuild the buffer for the visible console right after the new font
geometry has been installed and before any redraw, as fbcon_switch() and
fbcon_modechanged() already do.

Unlike those callers, this one does not fall back to unrotated rendering
on failure. The "par->rotate = FB_ROTATE_UR; set_blitting_type(vc, info);"
fallback they use does not actually switch to unrotated rendering:
set_blitting_type() calls fbcon_set_rotation(), which immediately
re-derives par->rotate from par->p->con_rotate. Replicating that pattern
here would not change the outcome; a failed rebuild leaves
par->rotated.buf NULL, so the rotated ops skip drawing, and the following
patch retries the allocation on the next call.

Fixes: 6cc50e1c5b57 ("[PATCH] fbcon: Console Rotation - Add support to rotate font bitmap")
Cc: stable@vger.kernel.org
Signed-off-by: Yao Yiqi <yaoyiqi3@huawei.com>
---
 drivers/video/fbdev/core/fbcon.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 01715873ea49..5cef18043bdb 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2432,6 +2432,17 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
 	else if (!vc->vc_hi_font_mask && charcount == 512)
 		set_vc_hi_font(vc, true);
 
+	/*
+	 * The rotated font buffer is sized from the new font's width, height
+	 * and charcount. Rebuild it for the visible console before the redraw
+	 * below, as fbcon_switch() and fbcon_modechanged() already do. The
+	 * redraw reaches the rotated bitops through hide_cursor(), and those
+	 * index the buffer with the new cell size and character codes, so a
+	 * stale, too-small buffer is read out of bounds.
+	 */
+	if (con_is_visible(vc) && par->bitops->rotate_font)
+		par->bitops->rotate_font(info, vc);
+
 	if (resize) {
 		int cols, rows;
 
-- 
2.34.1

