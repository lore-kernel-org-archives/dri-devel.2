Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2684BCCF2DA
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 09:04:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E780810E8CC;
	Mon, 19 Oct 2026 09:04:23 +0000 (UTC)
Received: from mail-m127170.xmail.ntesmail.com
 (mail-m127170.xmail.ntesmail.com [115.236.127.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF33710E8BC
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 09:04:13 +0000 (UTC)
Received: from zyb-HP-ProDesk-680-G2-MT.. (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 5189b85f3;
 Mon, 19 Oct 2026 16:59:06 +0800 (GMT+08:00)
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
Subject: [PATCH v4 05/14] drm/bridge: analogix_dp: Extend mute/unmute HPD
 interrupts to accept irq bitmask
Date: Mon, 19 Oct 2026 16:58:27 +0800
Message-Id: <20261019085836.3065008-6-damon.ding@rock-chips.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261019085836.3065008-1-damon.ding@rock-chips.com>
References: <20261019085836.3065008-1-damon.ding@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa15362cd4703a8kunm6ee755052eac20
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDGEgdVk0ZGBlCHU4fHUxPTFYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
 9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
 b=K80nvsKhJZ+bj6K9S3rgnMSoAvBK9ts7C7Fd9slP6lYu3I5hoM0Vyjh0wvZhai99mMI2RkJHgcaFEEO0EWE8mseHmklFcSA1RG1hNibgy2smr+Zwo+JRPIcsnfJM/5LyDzP8ovE1sjPm1rnsBQPg5X2wbXIUJM3zstjJy96rOMI=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=Ib+2qnriz6dyrp57c/Zt7thWj09jat9644102uTcbYE=;
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

Update the HPD interrupt mute/unmute routines to accept an irq_type
bitmask parameter, allowing selective per-bit mask control instead of
operating on all HPD interrupt bits unconditionally.

With IRQF_ONESHOT handling IRQ line masking during threaded handler
execution, these helpers are no longer needed in the runtime IRQ path.
They are retained for init-time use by analogix_dp_config_interrupt()
to configure platform-specific HPD interrupt masks.

Also extract the irq_type-to-COMMON_INT_STA_4 bit mapping into a shared
helper to avoid duplication in the clear/mute/unmute paths, and drop
the now unused COMMON_INT_4_HPD_IRQ macro.

Tested-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Damon Ding <damon.ding@rock-chips.com>

---

Changes in v2:
- Update commit messages to align with newly added IRQF_ONESHOT related
  commit.

Changes in v3:
- Extract the irq_type bit mapping into a shared helper and document
  the mask register polarity once.
- Drop the unused COMMON_INT_4_HPD_IRQ macro.

Changes in v4:
- Add Tested-by tag.
---
 .../drm/bridge/analogix/analogix_dp_core.h    |  4 +-
 .../gpu/drm/bridge/analogix/analogix_dp_reg.c | 80 ++++++++++++-------
 2 files changed, 55 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
index 88fa538a5949..6a3566b2e8de 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
@@ -185,8 +185,8 @@ void analogix_dp_init_interrupt(struct analogix_dp_device *dp);
 void analogix_dp_reset(struct analogix_dp_device *dp);
 void analogix_dp_swreset(struct analogix_dp_device *dp);
 void analogix_dp_config_interrupt(struct analogix_dp_device *dp);
-void analogix_dp_mute_hpd_interrupt(struct analogix_dp_device *dp);
-void analogix_dp_unmute_hpd_interrupt(struct analogix_dp_device *dp);
+void analogix_dp_mute_hpd_interrupt(struct analogix_dp_device *dp, u32 irq_type);
+void analogix_dp_unmute_hpd_interrupt(struct analogix_dp_device *dp, u32 irq_type);
 int analogix_dp_wait_pll_locked(struct analogix_dp_device *dp);
 void analogix_dp_set_pll_power_down(struct analogix_dp_device *dp, bool enable);
 void analogix_dp_set_analog_power_down(struct analogix_dp_device *dp,
diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
index 2c1d4655114b..6ac03a1aa512 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
@@ -26,8 +26,20 @@
 
 #define HPD_IRQ_ALL		(DP_IRQ_TYPE_HP_CABLE_IN | DP_IRQ_TYPE_HP_CABLE_OUT | \
 				 DP_IRQ_TYPE_HP_CHANGE | DP_IRQ_TYPE_IRQ_HPD)
-#define COMMON_INT_4_HPD_IRQ	(DP_IRQ_TYPE_HP_CABLE_IN | DP_IRQ_TYPE_HP_CABLE_OUT | \
-				 DP_IRQ_TYPE_HP_CHANGE)
+
+static u32 analogix_dp_irq_type_to_common_int_sta4(u32 irq_type)
+{
+	u32 reg = 0;
+
+	if (irq_type & DP_IRQ_TYPE_HP_CABLE_IN)
+		reg |= PLUG;
+	if (irq_type & DP_IRQ_TYPE_HP_CABLE_OUT)
+		reg |= HPD_LOST;
+	if (irq_type & DP_IRQ_TYPE_HP_CHANGE)
+		reg |= HOTPLUG_CHG;
+
+	return reg;
+}
 
 void analogix_dp_enable_video_mute(struct analogix_dp_device *dp, bool enable)
 {
@@ -196,30 +208,50 @@ void analogix_dp_config_interrupt(struct analogix_dp_device *dp)
 	writel(reg, dp->reg_base + ANALOGIX_DP_INT_STA_MASK);
 }
 
-void analogix_dp_mute_hpd_interrupt(struct analogix_dp_device *dp)
+/*
+ * Both ANALOGIX_DP_COMMON_INT_MASK_4 and ANALOGIX_DP_INT_STA_MASK use
+ * 0 to mask and 1 to unmask the corresponding interrupt sources.
+ */
+void analogix_dp_mute_hpd_interrupt(struct analogix_dp_device *dp, u32 irq_type)
 {
-	u32 reg;
+	u32 reg, mask;
 
-	/* 0: mask, 1: unmask */
-	reg = readl(dp->reg_base + ANALOGIX_DP_COMMON_INT_MASK_4);
-	reg &= ~COMMON_INT_MASK_4;
-	writel(reg, dp->reg_base + ANALOGIX_DP_COMMON_INT_MASK_4);
+	if (!irq_type)
+		return;
 
-	reg = readl(dp->reg_base + ANALOGIX_DP_INT_STA_MASK);
-	reg &= ~INT_STA_MASK;
-	writel(reg, dp->reg_base + ANALOGIX_DP_INT_STA_MASK);
+	mask = analogix_dp_irq_type_to_common_int_sta4(irq_type);
+	if (mask) {
+		reg = readl(dp->reg_base + ANALOGIX_DP_COMMON_INT_MASK_4);
+		reg &= ~mask;
+		writel(reg, dp->reg_base + ANALOGIX_DP_COMMON_INT_MASK_4);
+	}
+
+	if (irq_type & DP_IRQ_TYPE_IRQ_HPD) {
+		reg = readl(dp->reg_base + ANALOGIX_DP_INT_STA_MASK);
+		reg &= ~INT_HPD;
+		writel(reg, dp->reg_base + ANALOGIX_DP_INT_STA_MASK);
+	}
 }
 
-void analogix_dp_unmute_hpd_interrupt(struct analogix_dp_device *dp)
+void analogix_dp_unmute_hpd_interrupt(struct analogix_dp_device *dp, u32 irq_type)
 {
-	u32 reg;
+	u32 reg, mask;
 
-	/* 0: mask, 1: unmask */
-	reg = COMMON_INT_MASK_4;
-	writel(reg, dp->reg_base + ANALOGIX_DP_COMMON_INT_MASK_4);
+	if (!irq_type)
+		return;
 
-	reg = INT_STA_MASK;
-	writel(reg, dp->reg_base + ANALOGIX_DP_INT_STA_MASK);
+	mask = analogix_dp_irq_type_to_common_int_sta4(irq_type);
+	if (mask) {
+		reg = readl(dp->reg_base + ANALOGIX_DP_COMMON_INT_MASK_4);
+		reg |= mask;
+		writel(reg, dp->reg_base + ANALOGIX_DP_COMMON_INT_MASK_4);
+	}
+
+	if (irq_type & DP_IRQ_TYPE_IRQ_HPD) {
+		reg = readl(dp->reg_base + ANALOGIX_DP_INT_STA_MASK);
+		reg |= INT_HPD;
+		writel(reg, dp->reg_base + ANALOGIX_DP_INT_STA_MASK);
+	}
 }
 
 int analogix_dp_wait_pll_locked(struct analogix_dp_device *dp)
@@ -382,20 +414,14 @@ int analogix_dp_init_analog_func(struct analogix_dp_device *dp)
 
 void analogix_dp_clear_hotplug_interrupts(struct analogix_dp_device *dp, u32 irq_type)
 {
-	u32 reg = 0;
+	u32 reg;
 
 	if (dp->hpd_gpiod || !irq_type)
 		return;
 
-	if (irq_type & COMMON_INT_4_HPD_IRQ) {
-		if (irq_type & DP_IRQ_TYPE_HP_CABLE_IN)
-			reg |= PLUG;
-		if (irq_type & DP_IRQ_TYPE_HP_CABLE_OUT)
-			reg |= HPD_LOST;
-		if (irq_type & DP_IRQ_TYPE_HP_CHANGE)
-			reg |= HOTPLUG_CHG;
+	reg = analogix_dp_irq_type_to_common_int_sta4(irq_type);
+	if (reg)
 		writel(reg, dp->reg_base + ANALOGIX_DP_COMMON_INT_STA_4);
-	}
 
 	if (irq_type & DP_IRQ_TYPE_IRQ_HPD)
 		writel(INT_HPD, dp->reg_base + ANALOGIX_DP_INT_STA);
-- 
2.34.1

