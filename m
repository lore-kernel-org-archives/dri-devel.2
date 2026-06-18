Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AD42CD98ED
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 05:01:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5C8710EC46;
	Thu, 18 Jun 2026 05:01:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="C/9W3eDd";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59E2A10EC6D
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 05:01:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D2AF860120;
 Thu, 18 Jun 2026 05:01:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 989521F000E9;
 Thu, 18 Jun 2026 05:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781758888;
 bh=yBILmZJ1mWMro5TI/n+b/9wLCKhup6eLvhz9q9e2tc4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=C/9W3eDdjT41mXk2M3FKcq6C0SQEt8SeG2wVrE4xPllupJ4oVW769W0nrkyHCSG+D
 FFHzUt/S/NeDJSgaq/Z7M0zco6whPFyp/87Ow1BbGSCv08PQ4sz9/46tOcsufPnmbw
 wbH6YW32PEniu9ih2gGXNpeAB5EETxmyTF3T9cWT6RC4x2CzH1rnCerYid/fDOzFMb
 Opy41Kjae+ATzBoctKLnej5042YT1Zo1s/Wl8k5YFGwzPK1B1Jxoz5FmJU19ThclhP
 9lGYi+xn0FwFPllTIcr64AFzIMxZF93xawgi1BXIdA55qeiGJd/pWmPSeNg5ZNFfQs
 C4/OiRFvyxAuA==
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 18 Jun 2026 07:00:54 +0200
Subject: [PATCH 08/11] dmaengine: ste_dma40: Use power domain for LCLA SRAM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-ux500-power-domains-v7-1-v1-8-eb5e50b1a588@kernel.org>
References: <20260618-ux500-power-domains-v7-1-v1-0-eb5e50b1a588@kernel.org>
In-Reply-To: <20260618-ux500-power-domains-v7-1-v1-0-eb5e50b1a588@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
 Mark Brown <broonie@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Lee Jones <lee@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 dmaengine@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.14.3
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

Replace the LCLA ESRAM regulator with runtime PM.

Use the SRAM device that owns the ESRAM34 power domain.

Hold that domain while DMA transfers are active.

Assisted-by: Codex:gpt-5-5
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/dma/ste_dma40.c | 97 ++++++++++++++++++++++++++++---------------------
 1 file changed, 55 insertions(+), 42 deletions(-)

diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index 9b803c0aec25..6ca67ec446dc 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -21,8 +21,8 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_dma.h>
+#include <linux/of_platform.h>
 #include <linux/amba/bus.h>
-#include <linux/regulator/consumer.h>
 
 #include "dmaengine.h"
 #include "ste_dma40.h"
@@ -571,7 +571,8 @@ struct d40_gen_dmac {
  * to phy_chans entries.
  * @plat_data: Pointer to provided platform_data which is the driver
  * configuration.
- * @lcpa_regulator: Pointer to hold the regulator for the esram bank for lcla.
+ * @lcla_dev: SRAM device for the ESRAM bank used by LCLA.
+ * @lcla_pm_enabled: Whether runtime PM was enabled for LCLA by this driver.
  * @phy_res: Vector containing all physical channels.
  * @lcla_pool: lcla pool settings and data.
  * @lcpa_base: The virtual mapped address of LCPA.
@@ -607,7 +608,8 @@ struct d40_base {
 	struct d40_chan			**lookup_log_chans;
 	struct d40_chan			**lookup_phy_chans;
 	struct stedma40_platform_data	 *plat_data;
-	struct regulator		 *lcpa_regulator;
+	struct device			 *lcla_dev;
+	bool				  lcla_pm_enabled;
 	/* Physical half channels */
 	struct d40_phy_res		 *phy_res;
 	struct d40_lcla_pool		  lcla_pool;
@@ -628,6 +630,22 @@ static struct device *chan2dev(struct d40_chan *d40c)
 	return &d40c->chan.dev->device;
 }
 
+static void d40_transfer_runtime_get(struct d40_base *base)
+{
+	if (base->lcla_dev)
+		pm_runtime_get_sync(base->lcla_dev);
+
+	pm_runtime_get_sync(base->dev);
+}
+
+static void d40_transfer_runtime_put(struct d40_base *base)
+{
+	pm_runtime_put_autosuspend(base->dev);
+
+	if (base->lcla_dev)
+		pm_runtime_put_sync_suspend(base->lcla_dev);
+}
+
 static bool chan_is_physical(struct d40_chan *chan)
 {
 	return chan->log_num == D40_PHY_CHAN;
@@ -1516,7 +1534,7 @@ static struct d40_desc *d40_queue_start(struct d40_chan *d40c)
 	if (d40d != NULL) {
 		if (!d40c->busy) {
 			d40c->busy = true;
-			pm_runtime_get_sync(d40c->base->dev);
+			d40_transfer_runtime_get(d40c->base);
 		}
 
 		/* Remove from queue */
@@ -1579,7 +1597,7 @@ static void dma_tc_handle(struct d40_chan *d40c)
 		if (d40_queue_start(d40c) == NULL) {
 			d40c->busy = false;
 
-			pm_runtime_put_autosuspend(d40c->base->dev);
+			d40_transfer_runtime_put(d40c->base);
 		}
 
 		d40_desc_remove(d40d);
@@ -2052,7 +2070,7 @@ static int d40_free_dma(struct d40_chan *d40c)
 		d40c->base->lookup_phy_chans[phy->num] = NULL;
 
 	if (d40c->busy)
-		pm_runtime_put_autosuspend(d40c->base->dev);
+		d40_transfer_runtime_put(d40c->base);
 
 	d40c->busy = false;
 	d40c->phy_chan = NULL;
@@ -2613,7 +2631,7 @@ static int d40_terminate_all(struct dma_chan *chan)
 	d40_term_all(d40c);
 	pm_runtime_put_autosuspend(d40c->base->dev);
 	if (d40c->busy)
-		pm_runtime_put_autosuspend(d40c->base->dev);
+		d40_transfer_runtime_put(d40c->base);
 	d40c->busy = false;
 
 	spin_unlock_irqrestore(&d40c->lock, flags);
@@ -2916,29 +2934,11 @@ static int __init d40_dmaengine_init(struct d40_base *base,
 #ifdef CONFIG_PM_SLEEP
 static int dma40_suspend(struct device *dev)
 {
-	struct d40_base *base = dev_get_drvdata(dev);
-	int ret;
-
-	ret = pm_runtime_force_suspend(dev);
-	if (ret)
-		return ret;
-
-	if (base->lcpa_regulator)
-		ret = regulator_disable(base->lcpa_regulator);
-	return ret;
+	return pm_runtime_force_suspend(dev);
 }
 
 static int dma40_resume(struct device *dev)
 {
-	struct d40_base *base = dev_get_drvdata(dev);
-	int ret = 0;
-
-	if (base->lcpa_regulator) {
-		ret = regulator_enable(base->lcpa_regulator);
-		if (ret)
-			return ret;
-	}
-
 	return pm_runtime_force_resume(dev);
 }
 #endif
@@ -3492,7 +3492,10 @@ static int __init d40_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *np = pdev->dev.of_node;
 	struct device_node *np_lcpa;
+	struct device_node *np_lcla;
+	struct device_node *np_lcla_parent;
 	struct d40_base *base;
+	struct platform_device *lcla_pdev;
 	struct resource *res;
 	struct resource res_lcpa;
 	int num_reserved_chans;
@@ -3590,23 +3593,32 @@ static int __init d40_probe(struct platform_device *pdev)
 	}
 
 	if (base->plat_data->use_esram_lcla) {
+		np_lcla = of_parse_phandle(np, "sram", 1);
+		if (!np_lcla) {
+			dev_err(dev, "no LCLA SRAM node\n");
+			ret = -EINVAL;
+			goto destroy_cache;
+		}
 
-		base->lcpa_regulator = regulator_get(base->dev, "lcla_esram");
-		if (IS_ERR(base->lcpa_regulator)) {
-			d40_err(dev, "Failed to get lcpa_regulator\n");
-			ret = PTR_ERR(base->lcpa_regulator);
-			base->lcpa_regulator = NULL;
+		np_lcla_parent = of_get_parent(np_lcla);
+		of_node_put(np_lcla);
+		if (!np_lcla_parent) {
+			dev_err(dev, "no LCLA SRAM parent node\n");
+			ret = -EINVAL;
 			goto destroy_cache;
 		}
 
-		ret = regulator_enable(base->lcpa_regulator);
-		if (ret) {
-			d40_err(dev,
-				"Failed to enable lcpa_regulator\n");
-			regulator_put(base->lcpa_regulator);
-			base->lcpa_regulator = NULL;
+		lcla_pdev = of_find_device_by_node(np_lcla_parent);
+		of_node_put(np_lcla_parent);
+		if (!lcla_pdev) {
+			ret = -EPROBE_DEFER;
 			goto destroy_cache;
 		}
+		base->lcla_dev = &lcla_pdev->dev;
+		if (!pm_runtime_enabled(base->lcla_dev)) {
+			pm_runtime_enable(base->lcla_dev);
+			base->lcla_pm_enabled = true;
+		}
 	}
 
 	writel_relaxed(D40_DREG_GCC_ENABLE_ALL, base->virtbase + D40_DREG_GCC);
@@ -3642,16 +3654,17 @@ static int __init d40_probe(struct platform_device *pdev)
 				 SZ_1K * base->num_phy_chans,
 				 DMA_TO_DEVICE);
 
-	if (!base->lcla_pool.base_unaligned && base->lcla_pool.base)
+	if (!base->lcla_pool.base_unaligned && base->lcla_pool.base &&
+	    base->lcla_pool.pages)
 		free_pages((unsigned long)base->lcla_pool.base,
 			   base->lcla_pool.pages);
 
 	kfree(base->lcla_pool.base_unaligned);
 
-	if (base->lcpa_regulator) {
-		regulator_disable(base->lcpa_regulator);
-		regulator_put(base->lcpa_regulator);
-	}
+	if (base->lcla_pm_enabled)
+		pm_runtime_disable(base->lcla_dev);
+	if (base->lcla_dev)
+		put_device(base->lcla_dev);
 	pm_runtime_disable(base->dev);
 
  report_failure:

-- 
2.54.0

