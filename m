Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6393BC55ABC
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 08:17:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4225F10E8D8;
	Tue,  4 Aug 2026 08:17:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="QU7AhU64";
	dkim-atps=neutral
Received: from mail-m12867.netease.com (mail-m12867.netease.com
 [103.209.128.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01DDF10E8C8
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 08:17:31 +0000 (UTC)
Received: from zyb-HP-ProDesk-680-G2-MT.. (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 48b4ffee5;
 Tue, 4 Aug 2026 16:17:28 +0800 (GMT+08:00)
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
Subject: [PATCH v2 04/10] drm/bridge: analogix_dp: Extend
 clear_hotplug_interrupts to accept IRQ bitmask
Date: Tue,  4 Aug 2026 16:17:11 +0800
Message-Id: <20260804081717.741404-5-damon.ding@rock-chips.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260804081717.741404-1-damon.ding@rock-chips.com>
References: <20260804081717.741404-1-damon.ding@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9fcbd9607703a8kunma7b8cbe762b09a
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCSEhCVhhPHUtCSBpKThkfSlYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
 9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
 b=QU7AhU643FcCKLOKXHEqJOzu5oal/dDH6dNQ+X1wvu8EnAuxNsO/BdUksmawjrUMcYV6fZKhvA1teQr6rK1wdWpoj0yUHELkS1CjPMy1TKZeU/pTIPIuOI1xzTQVe4JrNCiS4WyA8sGS0aF+UbHkuG4ESRYxToJ4pHjoxHEvxs8=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=wZ3Yx1pvPBwGiqSi0fnx71r627+5/VtLrTsEj4ffKDA=;
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

Update analogix_dp_clear_hotplug_interrupts() to take an irq_type
bitmask argument. Instead of clearing all hotplug interrupt bits
unconditionally, only clear the interrupt flags corresponding to the
triggered events.

Pass the detected IRQ bitmask from the irq thread handler, and use the
full HPD_IRQ mask during HPD initialization.

This implements fine-grained pending interrupt clearing logic and
removes limitations brought by unconditional register writes,
supporting improved accuracy for HPD event handling.

Signed-off-by: Damon Ding <damon.ding@rock-chips.com>

---

Changes in v2:
- Add separate patch for IRQF_ONESHOT to resolve interrupt mask issues
  triggered by interrupt preemption.(Sashiko)
---
 .../drm/bridge/analogix/analogix_dp_core.c    |  2 +-
 .../drm/bridge/analogix/analogix_dp_core.h    |  2 +-
 .../gpu/drm/bridge/analogix/analogix_dp_reg.c | 28 +++++++++++++------
 3 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index 4fe248e66515..603abd940a7c 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -720,7 +720,7 @@ static irqreturn_t analogix_dp_irq_thread(int irq, void *arg)
 
 	irq_type = analogix_dp_get_irq_type(dp);
 	if (irq_type)
-		analogix_dp_clear_hotplug_interrupts(dp);
+		analogix_dp_clear_hotplug_interrupts(dp, irq_type);
 
 	if (irq_type & DP_IRQ_TYPE_HP_CABLE_IN ||
 	    irq_type & DP_IRQ_TYPE_HP_CABLE_OUT) {
diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
index c2eba77f9a81..ecb86a6c1fc3 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
@@ -194,7 +194,7 @@ int analogix_dp_init_analog_func(struct analogix_dp_device *dp);
 void analogix_dp_init_hpd(struct analogix_dp_device *dp);
 void analogix_dp_force_hpd(struct analogix_dp_device *dp);
 u32 analogix_dp_get_irq_type(struct analogix_dp_device *dp);
-void analogix_dp_clear_hotplug_interrupts(struct analogix_dp_device *dp);
+void analogix_dp_clear_hotplug_interrupts(struct analogix_dp_device *dp, u32 irq_type);
 void analogix_dp_reset_aux(struct analogix_dp_device *dp);
 void analogix_dp_init_aux(struct analogix_dp_device *dp);
 int analogix_dp_get_plug_in_status(struct analogix_dp_device *dp);
diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
index f4f859cb2936..024f342da461 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
@@ -24,6 +24,11 @@
 #define COMMON_INT_MASK_4	(HOTPLUG_CHG | HPD_LOST | PLUG)
 #define INT_STA_MASK		INT_HPD
 
+#define HPD_IRQ			(DP_IRQ_TYPE_HP_CABLE_IN | DP_IRQ_TYPE_HP_CABLE_OUT | \
+				 DP_IRQ_TYPE_HP_CHANGE | DP_IRQ_TYPE_IRQ_HPD)
+#define COMMON_INT_4_HPD_IRQ	(DP_IRQ_TYPE_HP_CABLE_IN | DP_IRQ_TYPE_HP_CABLE_OUT | \
+				 DP_IRQ_TYPE_HP_CHANGE)
+
 void analogix_dp_enable_video_mute(struct analogix_dp_device *dp, bool enable)
 {
 	u32 reg;
@@ -376,18 +381,25 @@ int analogix_dp_init_analog_func(struct analogix_dp_device *dp)
 	return 0;
 }
 
-void analogix_dp_clear_hotplug_interrupts(struct analogix_dp_device *dp)
+void analogix_dp_clear_hotplug_interrupts(struct analogix_dp_device *dp, u32 irq_type)
 {
-	u32 reg;
+	u32 reg = 0;
 
-	if (dp->hpd_gpiod)
+	if (dp->hpd_gpiod || !irq_type)
 		return;
 
-	reg = HOTPLUG_CHG | HPD_LOST | PLUG;
-	writel(reg, dp->reg_base + ANALOGIX_DP_COMMON_INT_STA_4);
+	if (irq_type & COMMON_INT_4_HPD_IRQ) {
+		if (irq_type & DP_IRQ_TYPE_HP_CABLE_IN)
+			reg |= PLUG;
+		if (irq_type & DP_IRQ_TYPE_HP_CABLE_OUT)
+			reg |= HPD_LOST;
+		if (irq_type & DP_IRQ_TYPE_HP_CHANGE)
+			reg |= HOTPLUG_CHG;
+		writel(reg, dp->reg_base + ANALOGIX_DP_COMMON_INT_STA_4);
+	}
 
-	reg = INT_HPD;
-	writel(reg, dp->reg_base + ANALOGIX_DP_INT_STA);
+	if (irq_type & DP_IRQ_TYPE_IRQ_HPD)
+		writel(INT_HPD, dp->reg_base + ANALOGIX_DP_INT_STA);
 }
 
 void analogix_dp_init_hpd(struct analogix_dp_device *dp)
@@ -397,7 +409,7 @@ void analogix_dp_init_hpd(struct analogix_dp_device *dp)
 	if (dp->hpd_gpiod)
 		return;
 
-	analogix_dp_clear_hotplug_interrupts(dp);
+	analogix_dp_clear_hotplug_interrupts(dp, HPD_IRQ);
 
 	reg = readl(dp->reg_base + ANALOGIX_DP_SYS_CTL_3);
 	reg &= ~(F_HPD | HPD_CTRL);
-- 
2.34.1

