Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5496DCD4851
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 21:51:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80FF610E434;
	Fri, 15 May 2026 21:51:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="QFiBFtX9";
	dkim-atps=neutral
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A79D610E434
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 21:51:04 +0000 (UTC)
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 2FA4E26F87;
 Fri, 15 May 2026 23:45:10 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OZtsbRREI8rp; Fri, 15 May 2026 23:45:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1778881509; bh=3sJl0Qt09rxEYSVKVcG7DazowGZnxFL0i9HaOoCC1Zk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=QFiBFtX9DU3wCiVblDqIzjcvlOdFzvKMe8VBVccCLVEDqanP8w+k9e0hBDQgKzmmh
 civGyTxkVwS6qS2Xd1m2+obcOW6bFWESD6Qd6sqx/F1DV0uUYc7slLnAvCe+1VREbJ
 eRTJDKOeQNwmRJqO/XRmqbrooVXkUH5e9e5FiNumPEoh7JfrUEKGDnvrdsqqMpUqtB
 wsQGczlOlHKNFLE92rCMR/uXDXBxjfbswHzb8u8xz5lEBt/VEQceSGts/B8X4D3jC0
 jlBXS592b4mRADaIoMXZyj00g88M3lSRh6vy6VP+SOh5nJvUq+MwQPHZLMPCV/4sMT
 n/4qtzEgs1UGQ==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Sat, 16 May 2026 03:14:31 +0530
Subject: [PATCH RESEND v2 2/2] drm/bridge: samsung-dsim: use DSIM interrupt
 to wait for PLL stability
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260516-exynos-dsim-fixes-v2-2-db9bf96ae641@disroot.org>
References: <20260516-exynos-dsim-fixes-v2-0-db9bf96ae641@disroot.org>
In-Reply-To: <20260516-exynos-dsim-fixes-v2-0-db9bf96ae641@disroot.org>
To: Inki Dae <inki.dae@samsung.com>, Jagan Teki <jagan@amarulasolutions.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Kaustabh Chakraborty <kauschluss@disroot.org>
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

Stabilizing PLL needs to be waited for. This is done using a loop,
checking the PLL_STABLE bit in the status register.

DSIM fires an interrupt when the PLL is stabilized. Rely on this
functionality for stabilization wait, getting rid of the implicit loop.

This has been tested on a Galaxy J6 (Exynos 7870). Unfortunately, since
testing on all supported devices is less feasible, introduce a stop-gap
measure where the timeout has a gracious lower bound of 100
microseconds. This will (hopefully) prevent regressions due to timeout
on other devices.

Suggested-by: Inki Dae <inki.dae@samsung.com>
Link: https://lore.kernel.org/r/CAAQKjZMLMbwDVZRb5+Xb_5yz3AEP4uuzFJMuuZy9NFDu13VU5w@mail.gmail.com
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 drivers/gpu/drm/bridge/samsung-dsim.c | 41 +++++++++++++++++++++++------------
 include/drm/bridge/samsung-dsim.h     |  1 +
 2 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/bridge/samsung-dsim.c
index 70f8946ad3b24..0ca6c6484c9a6 100644
--- a/drivers/gpu/drm/bridge/samsung-dsim.c
+++ b/drivers/gpu/drm/bridge/samsung-dsim.c
@@ -17,6 +17,7 @@
 #include <linux/export.h>
 #include <linux/irq.h>
 #include <linux/media-bus-format.h>
+#include <linux/minmax.h>
 #include <linux/of.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
@@ -788,7 +789,7 @@ static unsigned long samsung_dsim_set_pll(struct samsung_dsim *dsi,
 {
 	const struct samsung_dsim_driver_data *driver_data = dsi->driver_data;
 	unsigned long fin, fout;
-	int timeout;
+	unsigned int timeout;
 	u8 p, s;
 	u16 m;
 	u32 reg;
@@ -849,19 +850,26 @@ static unsigned long samsung_dsim_set_pll(struct samsung_dsim *dsi,
 	if (dsi->swap_dn_dp_data)
 		reg |= DSIM_PLL_DPDNSWAP_DAT;
 
+	/*
+	 * The PLL_TIMER value is the product of the timeout delay and the APB
+	 * bus clock rate. Calcutate the timeout delay on-the-fly here.
+	 * It is assumed that the bus clock is the first clock in the provided
+	 * bulk clock data.
+	 */
+	timeout = 100;
+	fin = clk_get_rate(dsi->driver_data->clk_data[0].clk) / HZ_PER_MHZ;
+	if (fin)
+		timeout = max(dsi->driver_data->reg_values[PLL_TIMER] / fin,
+			      timeout);
+
+	reinit_completion(&dsi->pll_stabilized);
 	samsung_dsim_write(dsi, DSIM_PLLCTRL_REG, reg);
 
-	timeout = 3000;
-	do {
-		if (timeout-- == 0) {
-			dev_err(dsi->dev, "PLL failed to stabilize\n");
-			return 0;
-		}
-		if (driver_data->has_legacy_status_reg)
-			reg = samsung_dsim_read(dsi, DSIM_STATUS_REG);
-		else
-			reg = samsung_dsim_read(dsi, DSIM_LINK_STATUS_REG);
-	} while ((reg & BIT(driver_data->pll_stable_bit)) == 0);
+	if (wait_for_completion_timeout(&dsi->pll_stabilized,
+					usecs_to_jiffies(timeout))) {
+		dev_err(dsi->dev, "PLL failed to stabilize\n");
+		return 0;
+	}
 
 	dsi->hs_clock = fout;
 
@@ -1596,8 +1604,12 @@ static irqreturn_t samsung_dsim_irq(int irq, void *dev_id)
 		return IRQ_HANDLED;
 	}
 
-	if (!(status & (DSIM_INT_RX_DONE | DSIM_INT_SFR_FIFO_EMPTY |
-			DSIM_INT_PLL_STABLE)))
+	if (status & DSIM_INT_PLL_STABLE) {
+		complete(&dsi->pll_stabilized);
+		return IRQ_HANDLED;
+	}
+
+	if (!(status & (DSIM_INT_RX_DONE | DSIM_INT_SFR_FIFO_EMPTY)))
 		return IRQ_HANDLED;
 
 	if (samsung_dsim_transfer_finish(dsi))
@@ -2146,6 +2158,7 @@ int samsung_dsim_probe(struct platform_device *pdev)
 		return PTR_ERR(dsi);
 
 	init_completion(&dsi->completed);
+	init_completion(&dsi->pll_stabilized);
 	spin_lock_init(&dsi->transfer_lock);
 	INIT_LIST_HEAD(&dsi->transfer_list);
 
diff --git a/include/drm/bridge/samsung-dsim.h b/include/drm/bridge/samsung-dsim.h
index 03005e474704b..e3433da21ad08 100644
--- a/include/drm/bridge/samsung-dsim.h
+++ b/include/drm/bridge/samsung-dsim.h
@@ -123,6 +123,7 @@ struct samsung_dsim {
 	int state;
 	struct drm_property *brightness;
 	struct completion completed;
+	struct completion pll_stabilized;
 
 	spinlock_t transfer_lock; /* protects transfer_list */
 	struct list_head transfer_list;

-- 
2.53.0

