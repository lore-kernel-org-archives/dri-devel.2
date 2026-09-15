Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17FC2C88E77
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 07:35:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3C2D10E490;
	Wed, 16 Sep 2026 07:35:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=tju.edu.cn header.i=@tju.edu.cn header.b="OqY9PXnF";
	dkim-atps=neutral
X-Greylist: delayed 302 seconds by postgrey-1.36 at gabe;
 Tue, 15 Sep 2026 14:50:43 UTC
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com
 [45.254.49.198])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B821310F80A
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 14:50:43 +0000 (UTC)
Received: from tju.edu.cn (gy-adaptive-ssl-proxy-3-entmail-virt135.gy.ntes
 [183.242.150.9])
 by smtp.qiye.163.com (Hmail) with ESMTP id 4ddceb521;
 Tue, 15 Sep 2026 22:45:34 +0800 (GMT+08:00)
From: Yibo Tan <lhfff@tju.edu.cn>
To: Nicolas Ferre <nicolas.ferre@microchip.com>, Helge Deller <deller@gmx.de>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v1] fbdev: atmel_lcdfb: Prevent FIFO work after removal
Date: Tue, 15 Sep 2026 22:45:28 +0800
Message-Id: <20260915144528.3464726-1-lhfff@tju.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0a587c6a003a1kunmb39ec71c2df824
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaGB1LVhhOTUhIHUoaHx5MQlYeHw
 5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKQ0hVSU9JVUpOS1VCWVdZFhoPEhUdFFlBWU9LSFVKS0hKTk
 xOVUpLS1VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=OqY9PXnFOEYsBrY58XRsakZ/d8919hvn1n6Ev5om59QW4+FMvm7VfjVtVqBmg6Z8T1jEGbSJQW2DRAk18hgz6sCCmegwOc5ocY+ngoRlDkrmOOHqA1n87PwUajgPcOTGZdFjQrtSnUY16cy407TTEUN9lK57an0zoHN831uMjJg=;
 c=relaxed/relaxed; s=default; d=tju.edu.cn; v=1; 
 bh=R/WqiFUDtj9hW8jTIp2hYqJBQvF/QvuI4kKPkm5/LJo=;
 h=date:mime-version:subject:message-id:from;
X-Mailman-Approved-At: Wed, 16 Sep 2026 07:35:16 +0000
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

The LCD controller IRQ schedules sinfo->task to recover from a FIFO
underflow.  Probe currently requests the IRQ before initializing the
work, so an early interrupt can schedule an uninitialized work item.

The probe error path and remove path cancel the work before freeing the
IRQ.  A FIFO-underflow interrupt can schedule the work again after that
cancellation.  framebuffer_release() may then free sinfo while the work
is still pending.

KASAN reported a use-after-free in atmel_lcdfb_task() when an underflow
interrupt occurred during removal.  With the IRQ freed before the work
was cancelled, the same test completed without a kernel diagnostic.

Initialize the work before requesting the IRQ.  In both cleanup paths,
free the IRQ before cancelling the work so that it cannot be scheduled
again after cancellation.

Fixes: d22579b83735 ("atmel_lcdfb: FIFO underflow management")
Cc: stable@vger.kernel.org
Assisted-by: Codex:GPT-5
Signed-off-by: Yibo Tan <lhfff@tju.edu.cn>
---
 drivers/video/fbdev/atmel_lcdfb.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/atmel_lcdfb.c b/drivers/video/fbdev/atmel_lcdfb.c
index 53f0156992e6..9a0cc09004b7 100644
--- a/drivers/video/fbdev/atmel_lcdfb.c
+++ b/drivers/video/fbdev/atmel_lcdfb.c
@@ -1146,6 +1146,9 @@ static int atmel_lcdfb_probe(struct platform_device *pdev)
 	/* Initialize PWM for contrast or backlight ("off") */
 	init_contrast(sinfo);
 
+	/* Some LCDC recovery operations require process context. */
+	INIT_WORK(&sinfo->task, atmel_lcdfb_task);
+
 	/* interrupt */
 	ret = request_irq(sinfo->irq_base, atmel_lcdfb_interrupt, 0, pdev->name, info);
 	if (ret) {
@@ -1153,10 +1156,6 @@ static int atmel_lcdfb_probe(struct platform_device *pdev)
 		goto unmap_mmio;
 	}
 
-	/* Some operations on the LCDC might sleep and
-	 * require a preemptible task context */
-	INIT_WORK(&sinfo->task, atmel_lcdfb_task);
-
 	ret = atmel_lcdfb_init_fbinfo(sinfo);
 	if (ret < 0) {
 		dev_err(dev, "init fbinfo failed: %d\n", ret);
@@ -1192,8 +1191,8 @@ static int atmel_lcdfb_probe(struct platform_device *pdev)
 	dev_set_drvdata(dev, NULL);
 	fb_dealloc_cmap(&info->cmap);
 unregister_irqs:
-	cancel_work_sync(&sinfo->task);
 	free_irq(sinfo->irq_base, info);
+	cancel_work_sync(&sinfo->task);
 unmap_mmio:
 	exit_backlight(sinfo);
 	iounmap(sinfo->mmio);
@@ -1230,6 +1229,7 @@ static void atmel_lcdfb_remove(struct platform_device *pdev)
 		return;
 	sinfo = info->par;
 
+	free_irq(sinfo->irq_base, info);
 	cancel_work_sync(&sinfo->task);
 	exit_backlight(sinfo);
 	atmel_lcdfb_power_control(sinfo, 0);
@@ -1238,7 +1238,6 @@ static void atmel_lcdfb_remove(struct platform_device *pdev)
 	clk_put(sinfo->lcdc_clk);
 	clk_put(sinfo->bus_clk);
 	fb_dealloc_cmap(&info->cmap);
-	free_irq(sinfo->irq_base, info);
 	iounmap(sinfo->mmio);
  	release_mem_region(info->fix.mmio_start, info->fix.mmio_len);
 	if (platform_get_resource(pdev, IORESOURCE_MEM, 1)) {
-- 
2.39.5

