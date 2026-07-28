Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A67DAC53219
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 13:57:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DAA8510E909;
	Tue, 28 Jul 2026 13:57:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="moftx0hP";
	dkim-atps=neutral
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com
 [45.254.49.197])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45F4810E599
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 13:57:21 +0000 (UTC)
Received: from LAPTOP-99KJFSET (unknown [221.228.238.82])
 by smtp.qiye.163.com (Hmail) with ESMTP id 47e2b3614;
 Tue, 28 Jul 2026 21:52:16 +0800 (GMT+08:00)
From: Hongyan Xu <getshell@seu.edu.cn>
To: andrzej.hajda@intel.com,
	neil.armstrong@linaro.org,
	rfoss@kernel.org
Cc: Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, luca.ceresoli@bootlin.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn,
 Hongyan Xu <getshell@seu.edu.cn>
Subject: [PATCH] drm/bridge: cdns-mhdp8546: cancel work before teardown
Date: Tue, 28 Jul 2026 21:52:14 +0800
Message-ID: <20260728135214.1850-1-getshell@seu.edu.cn>
X-Mailer: git-send-email 2.50.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9fa8ff5d3903a1kunmb0506542f1410
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaGUJPVkgeSxkYSB1JSkxPSlYeHw
 5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUpVSUlDVUlIQ1VDSVlXWRYaDxIVHRRZQVlPS0hVSktJSE
 5DQ1VKS0tVS1kG
DKIM-Signature: a=rsa-sha256;
 b=moftx0hPgsJZmDe49FXD+dH3hLjKO+rZbFu35egT2UKFGwGQgR1x6cn5o31x+k8z5KRJ4lPONbnIdwr3nMYnFaKcaAbdQF1dDj4GAm1IcMqelpQi+LS80wLn9LmOg0hrhYd0fgSCeMq9KtwNCkgKd+4efis/s3qPNFZspNU+x+k=;
 s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1; 
 bh=qMDP7e7mG4Q/3VHmDx5WRLDWHw6Dh0nzupaaJtoxg5k=;
 h=date:mime-version:subject:message-id:from;
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

The interrupt handler can queue hpd_work, while link training and HDCP
can queue modeset_retry_work, check_work and prop_work. The remove path
currently tears down the DRM bridge, firmware, PHY and runtime PM state
before synchronizing only the first two work items. It explicitly leaves
the HDCP work items alone.

Consequently, hpd_work can notify a bridge whose HPD mutex has already
been destroyed, and the other work items can access connector or device
state after teardown.

Mark the bridge detached and mask interrupts before freeing the IRQ, so
no interrupt handler can queue new HPD work. Then cancel all four work
items before removing the bridge or stopping the hardware. Cancel the
self-rearming HDCP check work before the property work because the check
path can queue a property update.

This issue was found by a static analysis tool.

Fixes: fb43aa0acdfd ("drm: bridge: Add support for Cadence MHDP8546 DPI/DP bridge")
Fixes: 6a3608eae6d3 ("drm: bridge: cdns-mhdp8546: Enable HDCP")
Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
---
 .../drm/bridge/cadence/cdns-mhdp8546-core.c   | 24 ++++++++++++-------
 .../drm/bridge/cadence/cdns-mhdp8546-core.h   |  1 +
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
index 36c07b71f..aa8d12bb8 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
@@ -2265,7 +2265,6 @@ static int cdns_mhdp_probe(struct platform_device *pdev)
 	unsigned long rate;
 	struct clk *clk;
 	int ret;
-	int irq;
 
 	mhdp = devm_drm_bridge_alloc(dev, struct cdns_mhdp_device, bridge,
 				     &cdns_mhdp_bridge_funcs);
@@ -2338,12 +2337,12 @@ static int cdns_mhdp_probe(struct platform_device *pdev)
 
 	writel(~0, mhdp->regs + CDNS_APB_INT_MASK);
 
-	irq = platform_get_irq(pdev, 0);
-	ret = devm_request_threaded_irq(mhdp->dev, irq, NULL,
+	mhdp->irq = platform_get_irq(pdev, 0);
+	ret = devm_request_threaded_irq(mhdp->dev, mhdp->irq, NULL,
 					cdns_mhdp_irq_handler, IRQF_ONESHOT,
 					"mhdp8546", mhdp);
 	if (ret) {
-		dev_err(dev, "cannot install IRQ %d\n", irq);
+		dev_err(dev, "cannot install IRQ %d\n", mhdp->irq);
 		ret = -EIO;
 		goto plat_fini;
 	}
@@ -2406,6 +2405,19 @@ static void cdns_mhdp_remove(struct platform_device *pdev)
 	unsigned long timeout = msecs_to_jiffies(100);
 	int ret;
 
+	spin_lock(&mhdp->start_lock);
+	mhdp->bridge_attached = false;
+	spin_unlock(&mhdp->start_lock);
+	writel(~0, mhdp->regs + CDNS_APB_INT_MASK);
+	devm_free_irq(mhdp->dev, mhdp->irq, mhdp);
+
+	cancel_work_sync(&mhdp->hpd_work);
+	cancel_work_sync(&mhdp->modeset_retry_work);
+	if (mhdp->hdcp_supported) {
+		cancel_delayed_work_sync(&mhdp->hdcp.check_work);
+		cancel_work_sync(&mhdp->hdcp.prop_work);
+	}
+
 	drm_bridge_remove(&mhdp->bridge);
 
 	ret = wait_event_timeout(mhdp->fw_load_wq,
@@ -2432,10 +2444,6 @@ static void cdns_mhdp_remove(struct platform_device *pdev)
 
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-
-	cancel_work_sync(&mhdp->modeset_retry_work);
-	flush_work(&mhdp->hpd_work);
-	/* Ignoring mhdp->hdcp.check_work and mhdp->hdcp.prop_work here. */
 }
 
 static const struct of_device_id mhdp_ids[] = {
diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.h b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.h
index b53335b0d..2d09df8d2 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.h
+++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.h
@@ -359,6 +359,7 @@ struct cdns_mhdp_device {
 	struct device *dev;
 	struct clk *clk;
 	struct phy *phy;
+	int irq;
 
 	const struct cdns_mhdp_platform_info *info;
 
-- 
2.50.1.windows.1

