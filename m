Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB273CD5BBF
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 08:28:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DDF510E5F4;
	Mon, 25 May 2026 08:28:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="Rniw1FlN";
	dkim-atps=neutral
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FF1410E5F4
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 08:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Lv
 ACdezaJFlYc8/KTHh3irWUTEDg1QmiaXKDHI/aTuA=; b=Rniw1FlNKuOkPC2s2p
 5iB3TBIi3J9EgW31D+0kQiss3+57X+HYFScsNUfpTpr+ThVJi/iP/WepUzqzc7vN
 ZSu40NAecn5cuDd6DVo8t+V28fRjkaICGgvnI4G4Bxxa5849ewBEevJI/iilS9pe
 Iz/HauwxrtvX00aWekT3nIGVo=
Received: from 163.com (unknown [])
 by gzsmtp5 (Coremail) with SMTP id QCgvCgAHGrD_BxRqrB9rFA--.116S2;
 Mon, 25 May 2026 16:27:47 +0800 (CST)
From: w15303746062@163.com
To: simona@ffwll.ch,
	deller@gmx.de
Cc: tzimmermann@suse.de, ville.syrjala@linux.intel.com, sam@ravnborg.org,
 kees@kernel.org, yanquanmin1@huawei.com, syoshida@redhat.com,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Mingyu Wang <25181214217@stu.xidian.edu.cn>
Subject: [PATCH 7.0] fbdev: fbcon: fix memory leak in error path of
 fbcon_do_set_font()
Date: Mon, 25 May 2026 16:27:41 +0800
Message-Id: <20260525082741.600003-1-w15303746062@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: QCgvCgAHGrD_BxRqrB9rFA--.116S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCrWrKrW5ArWkWw17Zr13urg_yoW5ZryrpF
 4rG34SkFn5JF1jka1v9w48ZF4rXa42kFW5WayxKa4Yqr45CryUCr4rtFyUZa98GrZ7WFyS
 vw1jy3yjgas8uaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j5SdkUUUUU=
X-Originating-IP: [113.200.174.100]
X-CM-SenderInfo: jzrvjiatxuliiws6il2tof0z/xtbDAAOhhWoUCAPvhAAA35
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

From: Mingyu Wang <25181214217@stu.xidian.edu.cn>

[ Note: This issue was discovered on the 7.0 kernel. While the current
  mainline has already been refactored to use `font_data_t` (which 
  inadvertently resolved this bug), this vulnerability still actively 
  affects the 7.0 branch and older stable trees that rely on the legacy 
  userfont logic. This patch provides a targeted fix for these stable 
  branches. ]

When fbcon_do_set_font() fails (e.g., due to a vc_resize() failure under
fault injection), it jumps to the `err_out` label to roll back the
console state.

However, the restoration of the previous font state (`p->userfont =
old_userfont`) is erroneously placed inside the `if (userfont)` block.
If the failed operation was attempting to set the default builtin font
(`userfont == 0`), the restoration is completely skipped.

This causes a state machine corruption where `p->userfont` remains `0`
while `p->fontdata` still points to the previously allocated user font
memory. Later, when the console is destroyed (e.g., via VT_DISALLOCATE),
fbcon_free_font() fails to free this memory because its `if (p->userfont)`
check fails, resulting in a memory leak caught by kmemleak:

  unreferenced object 0xffff888127ea0000 (size 33296):
    comm "syz.0.8726", pid 33224, jiffies 4297754643
    hex dump (first 32 bytes):
      a6 e4 f9 dd 00 00 00 00 00 82 00 00 01 00 00 00  ................
      d2 09 6c bf 52 8a 7d d4 ef 1d 59 16 51 86 32 bf  ..l.R.}...Y.Q.2.
    backtrace (crc 4a0a57dd):
      ___kmalloc_large_node+0xe7/0x180 mm/slub.c:5214
      __kmalloc_large_node_noprof+0x29/0x130 mm/slub.c:5232
      __do_kmalloc_node mm/slub.c:5248 [inline]
      __kmalloc_noprof+0x5fc/0x7c0 mm/slub.c:5272
      kmalloc_noprof include/linux/slab.h:954 [inline]
      fbcon_set_font+0x431/0xa60 drivers/video/fbdev/core/fbcon.c:2525
      con_font_set drivers/tty/vt/vt.c:4918 [inline]
      con_font_op+0x94d/0xe80 drivers/tty/vt/vt.c:4958
      vt_k_ioctl drivers/tty/vt/vt_ioctl.c:472 [inline]
      vt_ioctl+0x63c/0x2ee0 drivers/tty/vt/vt_ioctl.c:743

Fix this by moving the `p->userfont = old_userfont` assignment outside
the `if (userfont)` block so that the terminal state is unconditionally
and correctly restored regardless of which font setting triggered the
error.

Fixes: a5a923038d70 ("fbdev: fbcon: Properly revert changes when vc_resize() failed")
Signed-off-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>
---
 drivers/video/fbdev/core/fbcon.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 666261ae59d8..a38545dc8416 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2461,8 +2461,10 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
 	p->fontdata = old_data;
 	vc->vc_font.data = old_data;
 
+	/* Unconditionally restore the previous userfont state */
+	p->userfont = old_userfont;
+
 	if (userfont) {
-		p->userfont = old_userfont;
 		if (--REFCOUNT(data) == 0)
 			kfree(data - FONT_EXTRA_WORDS * sizeof(int));
 	}
-- 
2.34.1

