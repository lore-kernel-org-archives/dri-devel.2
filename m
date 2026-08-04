Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B611C55172
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 08:17:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E7B710E8DF;
	Tue,  4 Aug 2026 08:17:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="MUekaK+1";
	dkim-atps=neutral
Received: from mail-m103131191178.xmail.ntesmail.com
 (mail-m103131191178.xmail.ntesmail.com [103.131.191.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D29A10E8DC
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 08:17:34 +0000 (UTC)
Received: from zyb-HP-ProDesk-680-G2-MT.. (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 48b4ffeed;
 Tue, 4 Aug 2026 16:17:29 +0800 (GMT+08:00)
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
Subject: [PATCH v2 05/10] drm/bridge: analogix_dp: Extend mute/unmute HPD
 interrupts to accept irq bitmask
Date: Tue,  4 Aug 2026 16:17:12 +0800
Message-Id: <20260804081717.741404-6-damon.ding@rock-chips.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260804081717.741404-1-damon.ding@rock-chips.com>
References: <20260804081717.741404-1-damon.ding@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9fcbd9651703a8kunma7b8cbe762b0a5
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaQxlKVktCH0MdTRgYGBoaGFYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
 9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
 b=MUekaK+18EXfj0gEqQzJILeHV9JnC1vyY21k7DDS/ahSwctVmuZbMIiEV5sdNqXQiHKJppjWKTey6WTNWN54lC/2mCgmps+pov1DeCwzuDMEwNq4jnkD6WNsSeCq61sfngTnaq53GfTJLg4Kz1MtZfmFg4ZlbwKgV2g3X5r/YVk=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=dCxGMX+jTS1vNiY9tKHG6shVsMrbE7xWUPx/wK0vypY=;
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

Signed-off-by: Damon Ding <damon.ding@rock-chips.com>

---

Changes in v2:
- Update commit messages to align with newly added IRQF_ONESHOT related
  commit.
---
 .../drm/bridge/analogix/analogix_dp_core.h    |  4 +-
 .../gpu/drm/bridge/analogix/analogix_dp_reg.c | 59 ++++++++++++++-----
 2 files changed, 46 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
index ecb86a6c1fc3..2066e575ce10 100644
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
index 024f342da461..816be79a8da6 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
@@ -197,30 +197,59 @@ void analogix_dp_config_interrupt(struct analogix_dp_device *dp)
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

