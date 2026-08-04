Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49B07C56201
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 07:24:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84FCB10ED29;
	Wed,  5 Aug 2026 07:24:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="BWtjAnYD";
	dkim-atps=neutral
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E162310E141
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 17:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=8a
 Yz02xTyJO/l2KmFoJ/kQQG+Rq6gIOacd76mSB09Qk=; b=BWtjAnYD8GplBU5YLB
 D7vS+gmHa6gM1MOj3tA17OJs97AqUSNy9PZk1BQP4QfdBZVAF0WfZgtp6MH0KCk8
 2mSNKtByYsWjSphnzOIbM/g7pwpqLA+Cir/uHLC/vyZ+Go6pSH/WWmZ9i8Z1Ul1U
 FPY3ymMYBR5fUVBcKXI25eQoQ=
Received: from localhost (unknown [])
 by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id
 _____wDnb91UI3JqCyemNA--.22856S2; 
 Wed, 05 Aug 2026 01:37:25 +0800 (CST)
From: sh_def@163.com
To: andy@kernel.org,
	gregkh@linuxfoundation.org
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
 sh_def@163.com, thomas.petazzoni@free-electrons.com, notro@tronnes.org
Subject: [PATCH] staging: fbtft: make dirty_lock IRQ-safe
Date: Wed,  5 Aug 2026 01:37:12 +0800
Message-ID: <20260804173712.176017-1-sh_def@163.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDnb91UI3JqCyemNA--.22856S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGF15ZF48WF48urW8GFWkCrg_yoW5ury7pa
 12qa45Ar4kWa1Fv3y3Gr4UZF4ak39Fkr4DKryIkw1xZ3W5Crs7Wr97JFyrXF1FyrZayrn5
 AFWrK347Jw4UGw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRdhliUUUUU=
X-Originating-IP: [183.192.100.171]
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbCwRUVdGpyI1VzCgAA3i
X-Mailman-Approved-At: Wed, 05 Aug 2026 07:24:24 +0000
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

From: Hui Su <sh_def@163.com>

fbtft_mkdirty() can be reached from the fbcon rendering path while
processing printk() in hardirq context. Meanwhile, dirty_lock is also
taken by fbtft_deferred_io() in workqueue context with local interrupts
enabled.

Lockdep reports a possible IRQ lock inversion involving dirty_lock and
console_owner. A hardirq can interrupt a CPU holding dirty_lock and
enter the console rendering path, which can attempt to acquire
dirty_lock again.

The following lockdep report was observed on an RK3566 system with
CONFIG_PROVE_LOCKING enabled:

  WARNING: possible irq lock inversion dependency detected
  swapper/2/0 just changed the state of lock:
  (console_owner){-...}-{0:0}
  but this lock took another, HARDIRQ-unsafe lock in the past:
  (&par->dirty_lock){+.+.}-{2:2}

  CPU0                    CPU1
  ----                    ----
  lock(&par->dirty_lock);
                         local_irq_disable();
                         lock(console_owner);
                         lock(&par->dirty_lock);
  <Interrupt>
    lock(console_owner);

  *** DEADLOCK ***

Use spin_lock_irqsave() for both dirty_lock critical sections. They
only access the dirty line range, so the IRQ-off regions remain short.

Fixes: c296d5f9957c ("staging: fbtft: core support")
Signed-off-by: Hui Su <sh_def@163.com>
---
 drivers/staging/fbtft/fbtft-core.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
index ca0c38221c16..193643d0329d 100644
--- a/drivers/staging/fbtft/fbtft-core.c
+++ b/drivers/staging/fbtft/fbtft-core.c
@@ -298,14 +298,20 @@ static void fbtft_mkdirty(struct fb_info *info, int y, int height)
 {
 	struct fbtft_par *par = info->par;
 	struct fb_deferred_io *fbdefio = info->fbdefio;
+	unsigned long flags;
 
 	/* Mark display lines/area as dirty */
-	spin_lock(&par->dirty_lock);
+	/*
+	 * fbcon takes dirty_lock while holding console_owner. Disable local
+	 * interrupts here so a printk hardirq cannot acquire console_owner
+	 * while dirty_lock is held and create the inverse lock ordering.
+	 */
+	spin_lock_irqsave(&par->dirty_lock, flags);
 	if (y < par->dirty_lines_start)
 		par->dirty_lines_start = y;
 	if (y + height - 1 > par->dirty_lines_end)
 		par->dirty_lines_end = y + height - 1;
-	spin_unlock(&par->dirty_lock);
+	spin_unlock_irqrestore(&par->dirty_lock, flags);
 
 	/* Schedule deferred_io to update display (no-op if already on queue)*/
 	schedule_delayed_work(&info->deferred_work, fbdefio->delay);
@@ -317,14 +323,15 @@ static void fbtft_deferred_io(struct fb_info *info, struct list_head *pagereflis
 	unsigned int dirty_lines_start, dirty_lines_end;
 	struct fb_deferred_io_pageref *pageref;
 	unsigned int y_low = 0, y_high = 0;
+	unsigned long flags;
 
-	spin_lock(&par->dirty_lock);
+	spin_lock_irqsave(&par->dirty_lock, flags);
 	dirty_lines_start = par->dirty_lines_start;
 	dirty_lines_end = par->dirty_lines_end;
 	/* set display line markers as clean */
 	par->dirty_lines_start = par->info->var.yres - 1;
 	par->dirty_lines_end = 0;
-	spin_unlock(&par->dirty_lock);
+	spin_unlock_irqrestore(&par->dirty_lock, flags);
 
 	/* Mark display lines as dirty */
 	list_for_each_entry(pageref, pagereflist, list) {
-- 
2.43.0

