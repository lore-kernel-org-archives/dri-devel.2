Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3930C55166
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 03:28:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08EDD10E640;
	Thu, 30 Jul 2026 03:28:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="gH0NLKYG";
	dkim-atps=neutral
Received: from mail-m20521016475.xmail.ntesmail.com
 (mail-m20521016475.xmail.ntesmail.com [205.210.164.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C5BA10E0EE
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 03:28:04 +0000 (UTC)
Received: from zyb-HP-ProDesk-680-G2-MT.. (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 481c5dbcd;
 Thu, 30 Jul 2026 11:27:59 +0800 (GMT+08:00)
From: Damon Ding <damon.ding@rock-chips.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Heiko Stuebner <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org,
 Damon Ding <damon.ding@rock-chips.com>
Subject: [PATCH v1 3/7] drm/bridge: analogix_dp: Extend mute/unmute HPD
 interrupts to accept irq bitmask
Date: Thu, 30 Jul 2026 11:27:40 +0800
Message-Id: <20260730032744.381566-4-damon.ding@rock-chips.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260730032744.381566-1-damon.ding@rock-chips.com>
References: <20260730032744.381566-1-damon.ding@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9fb1108c6303a8kunm040f79123746df
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZHUJMVh4fSkJMTUwaGRlNTlYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
 9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
 b=gH0NLKYGEtlfErzraVFzc8XiByToRrcYOTE7diDJCE1PHORXOOSha1N2w0+GqIMmQ0HehvhO5M4HygmwNJTLsP8QGj1hgfJ2fSUrrVBkKd4UzomJoxpxM2X/6XnYfKuj0JxbVP9HhX/MhcoKNFc8YIq1qhwdEDKCBSyMKugjE5A=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=Fqxh26PGSzlbZGlzsaQd1u/M1UXWpYygwb8WT4SoB1g=;
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

Update the global HPD interrupt mute/unmute routines to accept an IRQ
bitmask parameter. Instead of masking and restoring all HPD interrupts
unconditionally, only operate on flags triggered by the current IRQ
event.

Pass the detected interrupt bitmask from hardirq and thread handler
into the updated per-event interrupt control helpers.

This implements fine-grained per-interrupt masking logic, eliminates
the limitations of global interrupt mute, and prepares subsequent
improvements for accurate HPD event handling.

Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
---
 .../drm/bridge/analogix/analogix_dp_core.c    |  4 +-
 .../drm/bridge/analogix/analogix_dp_core.h    |  4 +-
 .../gpu/drm/bridge/analogix/analogix_dp_reg.c | 62 ++++++++++++++-----
 3 files changed, 51 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index c04af9fd4092..1671f388ef30 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -708,7 +708,7 @@ static irqreturn_t analogix_dp_hardirq(int irq, void *arg)
 
 	irq_type = analogix_dp_get_irq_type(dp);
 	if (irq_type) {
-		analogix_dp_mute_hpd_interrupt(dp);
+		analogix_dp_mute_hpd_interrupt(dp, irq_type);
 		ret = IRQ_WAKE_THREAD;
 	}
 
@@ -730,7 +730,7 @@ static irqreturn_t analogix_dp_irq_thread(int irq, void *arg)
 
 	if (irq_type) {
 		analogix_dp_clear_hotplug_interrupts(dp);
-		analogix_dp_unmute_hpd_interrupt(dp);
+		analogix_dp_unmute_hpd_interrupt(dp, irq_type);
 	}
 
 	return IRQ_HANDLED;
diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
index c2eba77f9a81..bc13ae45be69 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
@@ -183,8 +183,8 @@ void analogix_dp_init_interrupt(struct analogix_dp_device *dp);
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
index f4f859cb2936..42c1da160ad0 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
@@ -24,6 +24,9 @@
 #define COMMON_INT_MASK_4	(HOTPLUG_CHG | HPD_LOST | PLUG)
 #define INT_STA_MASK		INT_HPD
 
+#define COMMON_INT_4_HPD_IRQ	(DP_IRQ_TYPE_HP_CABLE_IN | DP_IRQ_TYPE_HP_CABLE_OUT | \
+				 DP_IRQ_TYPE_HP_CHANGE)
+
 void analogix_dp_enable_video_mute(struct analogix_dp_device *dp, bool enable)
 {
 	u32 reg;
@@ -192,30 +195,59 @@ void analogix_dp_config_interrupt(struct analogix_dp_device *dp)
 	writel(reg, dp->reg_base + ANALOGIX_DP_INT_STA_MASK);
 }
 
-void analogix_dp_mute_hpd_interrupt(struct analogix_dp_device *dp)
+void analogix_dp_mute_hpd_interrupt(struct analogix_dp_device *dp, u32 irq_type)
 {
-	u32 reg;
+	u32 reg, mask = 0;
 
-	/* 0: mask, 1: unmask */
-	reg = readl(dp->reg_base + ANALOGIX_DP_COMMON_INT_MASK_4);
-	reg &= ~COMMON_INT_MASK_4;
-	writel(reg, dp->reg_base + ANALOGIX_DP_COMMON_INT_MASK_4);
+	if (!irq_type)
+		return;
 
-	reg = readl(dp->reg_base + ANALOGIX_DP_INT_STA_MASK);
-	reg &= ~INT_STA_MASK;
-	writel(reg, dp->reg_base + ANALOGIX_DP_INT_STA_MASK);
+	if (irq_type & COMMON_INT_4_HPD_IRQ) {
+		/* 0: mask, 1: unmask */
+		reg = readl(dp->reg_base + ANALOGIX_DP_COMMON_INT_MASK_4);
+		if (irq_type & DP_IRQ_TYPE_HP_CABLE_IN)
+			mask |= PLUG;
+		if (irq_type & DP_IRQ_TYPE_HP_CABLE_OUT)
+			mask |= HPD_LOST;
+		if (irq_type & DP_IRQ_TYPE_HP_CHANGE)
+			mask |= HOTPLUG_CHG;
+		reg &= ~mask;
+		writel(reg, dp->reg_base + ANALOGIX_DP_COMMON_INT_MASK_4);
+	}
+
+	if (irq_type & DP_IRQ_TYPE_IRQ_HPD) {
+		/* 0: mask, 1: unmask */
+		reg = readl(dp->reg_base + ANALOGIX_DP_INT_STA_MASK);
+		reg &= ~INT_HPD;
+		writel(reg, dp->reg_base + ANALOGIX_DP_INT_STA_MASK);
+	}
 }
 
-void analogix_dp_unmute_hpd_interrupt(struct analogix_dp_device *dp)
+void analogix_dp_unmute_hpd_interrupt(struct analogix_dp_device *dp, u32 irq_type)
 {
 	u32 reg;
 
-	/* 0: mask, 1: unmask */
-	reg = COMMON_INT_MASK_4;
-	writel(reg, dp->reg_base + ANALOGIX_DP_COMMON_INT_MASK_4);
+	if (!irq_type)
+		return;
 
-	reg = INT_STA_MASK;
-	writel(reg, dp->reg_base + ANALOGIX_DP_INT_STA_MASK);
+	if (irq_type & COMMON_INT_4_HPD_IRQ) {
+		/* 0: mask, 1: unmask */
+		reg = readl(dp->reg_base + ANALOGIX_DP_COMMON_INT_MASK_4);
+		if (irq_type & DP_IRQ_TYPE_HP_CABLE_IN)
+			reg |= PLUG;
+		if (irq_type & DP_IRQ_TYPE_HP_CABLE_OUT)
+			reg |= HPD_LOST;
+		if (irq_type & DP_IRQ_TYPE_HP_CHANGE)
+			reg |= HOTPLUG_CHG;
+		writel(reg, dp->reg_base + ANALOGIX_DP_COMMON_INT_MASK_4);
+	}
+
+	if (irq_type & DP_IRQ_TYPE_IRQ_HPD) {
+		/* 0: mask, 1: unmask */
+		reg = readl(dp->reg_base + ANALOGIX_DP_INT_STA_MASK);
+		reg |= INT_HPD;
+		writel(reg, dp->reg_base + ANALOGIX_DP_INT_STA_MASK);
+	}
 }
 
 int analogix_dp_wait_pll_locked(struct analogix_dp_device *dp)
-- 
2.34.1

