Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61B60C9833E
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 08:15:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3AE710E804;
	Mon, 28 Sep 2026 08:15:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="SjHYE+56";
	dkim-atps=neutral
Received: from mail-m254109.xmail.ntesmail.com
 (mail-m254109.xmail.ntesmail.com [103.129.254.109])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F91C10E80A
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 08:15:13 +0000 (UTC)
Received: from zyb-HP-ProDesk-680-G2-MT.. (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 4f5398e82;
 Mon, 28 Sep 2026 16:15:10 +0800 (GMT+08:00)
From: Damon Ding <damon.ding@rock-chips.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Jingoo Han <jingoohan1@gmail.com>,
 Inki Dae <inki.dae@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Peter Griffin <peter.griffin@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, Heiko Stuebner <heiko@sntech.de>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-rockchip@lists.infradead.org, Damon Ding <damon.ding@rock-chips.com>
Subject: [PATCH v3 07/14] drm/bridge: analogix_dp: Use platform-specific HPD
 detection scheme
Date: Mon, 28 Sep 2026 16:14:11 +0800
Message-Id: <20260928081418.3605775-8-damon.ding@rock-chips.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260928081418.3605775-1-damon.ding@rock-chips.com>
References: <20260928081418.3605775-1-damon.ding@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0e715079203a8kunm323e2b5437cf46
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCTBpJVh9LTx9ITkxOS0hMGVYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
 JDQ0xVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
 b=SjHYE+56N6njEMERlvA7CzIvvttQUj+1DqOl5N+7vYVCDHNks5/VwpLpJwipHXqLp27AMonjVyXtHBUV3JDbbesPg/M4G2sKJZjfQHq5QmuDyiVDEkhjX4WiYzH86vsGeQUUX2JJ8bcBXKZSs3ByfXFgNYt7AO4aiDq4aNMr7dA=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=7ov5ZAWTee/V9ZBPtOKDaozcrk5oFd5f7m81BucbP6I=;
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

The Analogix DP controller provides two sets of interrupt sources for
hotplug detection: HOTPLUG_CHG for any HPD level change, and the
PLUG/HPD_LOST pair for connect/disconnect transitions respectively.

On Rockchip platforms, configure the HPD deglitch filter and use
HOTPLUG_CHG interrupt for hotplug detection. Other platforms retain the
original PLUG + HPD_LOST scheme with unchanged deglitch values.

Move the HPD deglitch configuration into analogix_dp_reset() so that
platform-specific values are set alongside the existing register
defaults in a single location. Update the threaded IRQ handler to check
the corresponding interrupt flag based on platform type.

Signed-off-by: Damon Ding <damon.ding@rock-chips.com>

---

Changes in v2:
- Move ANALOGIX_DP_HPD_DEGLITCH_L/ANALOGIX_DP_HPD_DEGLITCH_H configs to
  analogix_dp_reset().

Changes in v3:
- Modify the commit msg.
- Replace macro HPD_IRQ with HPD_IRQ_ALL.
---
 .../drm/bridge/analogix/analogix_dp_core.c    |  9 ++++++--
 .../gpu/drm/bridge/analogix/analogix_dp_reg.c | 22 ++++++++++++++++---
 2 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index f88e3263ba0e..287fc16125ef 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -714,13 +714,18 @@ static irqreturn_t analogix_dp_irq_thread(int irq, void *arg)
 {
 	struct analogix_dp_device *dp = arg;
 	u32 irq_type;
+	bool hpd_detected;
 
 	irq_type = analogix_dp_get_irq_type(dp);
 	if (irq_type)
 		analogix_dp_clear_hotplug_interrupts(dp, irq_type);
 
-	if (irq_type & DP_IRQ_TYPE_HP_CABLE_IN ||
-	    irq_type & DP_IRQ_TYPE_HP_CABLE_OUT) {
+	if (!dp->hpd_gpiod && analogix_dp_is_rockchip(dp->plat_data->dev_type))
+		hpd_detected = irq_type & DP_IRQ_TYPE_HP_CHANGE;
+	else
+		hpd_detected = (irq_type & DP_IRQ_TYPE_HP_CABLE_IN) ||
+			       (irq_type & DP_IRQ_TYPE_HP_CABLE_OUT);
+	if (hpd_detected) {
 		dev_dbg(dp->dev, "Detected cable status changed!\n");
 		if (dp->drm_dev)
 			drm_helper_hpd_irq_event(dp->drm_dev);
diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
index 0f1406e4a5d3..025da25463a8 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
@@ -160,8 +160,13 @@ void analogix_dp_reset(struct analogix_dp_device *dp)
 	writel(0x0, dp->reg_base + ANALOGIX_DP_PKT_SEND_CTL);
 	writel(0x0, dp->reg_base + ANALOGIX_DP_HDCP_CTL);
 
-	writel(0x5e, dp->reg_base + ANALOGIX_DP_HPD_DEGLITCH_L);
-	writel(0x1a, dp->reg_base + ANALOGIX_DP_HPD_DEGLITCH_H);
+	if (analogix_dp_is_rockchip(dp->plat_data->dev_type)) {
+		writel(0x80, dp->reg_base + ANALOGIX_DP_HPD_DEGLITCH_L);
+		writel(0xbb, dp->reg_base + ANALOGIX_DP_HPD_DEGLITCH_H);
+	} else {
+		writel(0x5e, dp->reg_base + ANALOGIX_DP_HPD_DEGLITCH_L);
+		writel(0x1a, dp->reg_base + ANALOGIX_DP_HPD_DEGLITCH_H);
+	}
 
 	writel(0x10, dp->reg_base + ANALOGIX_DP_LINK_DEBUG_CTL);
 
@@ -188,7 +193,18 @@ void analogix_dp_config_interrupt(struct analogix_dp_device *dp)
 	writel(0, dp->reg_base + ANALOGIX_DP_COMMON_INT_MASK_2);
 	writel(0, dp->reg_base + ANALOGIX_DP_COMMON_INT_MASK_3);
 
-	analogix_dp_unmute_hpd_interrupt(dp, HPD_IRQ_ALL);
+	/*
+	 * Either HOTPLUG_CHG interrupt or PLUG + HPD_LOST interrupt
+	 * pair can be used to implement hotplug detection.
+	 *
+	 * On Rockchip platforms, configuring HPD deglitch to 2ms and
+	 * using HOTPLUG_CHG interrupt for hotplug detection is proven
+	 * as a better solution via engineering verification.
+	 */
+	if (analogix_dp_is_rockchip(dp->plat_data->dev_type))
+		analogix_dp_unmute_hpd_interrupt(dp, DP_IRQ_TYPE_HP_CHANGE);
+	else
+		analogix_dp_unmute_hpd_interrupt(dp, HPD_IRQ_ALL);
 }
 
 /*
-- 
2.34.1

