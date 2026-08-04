Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE34FC5518F
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 08:17:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 264C210E8CC;
	Tue,  4 Aug 2026 08:17:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="H5i8vf53";
	dkim-atps=neutral
Received: from mail-m10185.netease.com (mail-m10185.netease.com
 [154.81.10.185])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D84C10E8CC
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 08:17:30 +0000 (UTC)
Received: from zyb-HP-ProDesk-680-G2-MT.. (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 48b4ffed3;
 Tue, 4 Aug 2026 16:17:26 +0800 (GMT+08:00)
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
Subject: [PATCH v2 02/10] drm/bridge: analogix_dp: Return bitmask from
 analogix_dp_get_irq_type()
Date: Tue,  4 Aug 2026 16:17:09 +0800
Message-Id: <20260804081717.741404-3-damon.ding@rock-chips.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260804081717.741404-1-damon.ding@rock-chips.com>
References: <20260804081717.741404-1-damon.ding@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9fcbd9564d03a8kunma7b8cbe762b080
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCThhLVk5PS0hMTx5KTkxMGFYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSE
 pKQk1VSktLVUpCWQY+
DKIM-Signature: a=rsa-sha256;
 b=H5i8vf53DsHE9nais/Pv+kAcfh/JZX3LR9TRWmXPNM2KVzF9dhdd8/STp9o0bKzm3EtHKAxLDPpHq++mJ/yfUA5Cn06FhOqONNJHADapr3cn2DtJecLn/vg8P2F8AFF8z7tZjVP+99YyjfaI+o8bUxPTA3jXUFPTzFDFcYx/Fq8=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=YGYojIb0fMEZEgKZbtpHU3IN7GPrQMf40SfosYPELAI=;
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

Analogix DP controllers support two sets of interrupts for hotplug
detection: HOTPLUG_CHG, and the pair PLUG / HPD_LOST. The current
driver logic relies on PLUG/HPD_LOST and does not consume HOTPLUG_CHG,
nor does it check for INT_HPD for IRQ_HPD events.

The existing analogix_dp_get_irq_type() returns on the first matched
interrupt flag. This causes the hardirq handler to unconditionally mute
all HPD interrupts, including HOTPLUG_CHG and INT_HPD, creating a
limitation for future extensions.

To prepare fine-grained interrupt handling, convert the return type
from enum dp_irq_type to a u32 bitmask. Accumulate all pending
interrupt flags instead of returning early, and add detection for
DP_IRQ_TYPE_IRQ_HPD. Remove DP_IRQ_TYPE_UNKNOWN sentinel; use zero
to indicate no pending interrupts, which simplifies code and
facilitates future extension for additional interrupt types.

This prepares subsequent changes to pass specific irq flags into
mute/unmute helpers for selective interrupt control.

Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
---
 .../gpu/drm/bridge/analogix/analogix_dp_core.c |  8 ++++----
 .../gpu/drm/bridge/analogix/analogix_dp_core.h |  4 ++--
 .../gpu/drm/bridge/analogix/analogix_dp_reg.c  | 18 ++++++++++--------
 3 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index 18f300b49644..7ef8ef812b55 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -704,10 +704,10 @@ static irqreturn_t analogix_dp_hardirq(int irq, void *arg)
 {
 	struct analogix_dp_device *dp = arg;
 	irqreturn_t ret = IRQ_NONE;
-	enum dp_irq_type irq_type;
+	u32 irq_type;
 
 	irq_type = analogix_dp_get_irq_type(dp);
-	if (irq_type != DP_IRQ_TYPE_UNKNOWN) {
+	if (irq_type) {
 		analogix_dp_mute_hpd_interrupt(dp);
 		ret = IRQ_WAKE_THREAD;
 	}
@@ -718,7 +718,7 @@ static irqreturn_t analogix_dp_hardirq(int irq, void *arg)
 static irqreturn_t analogix_dp_irq_thread(int irq, void *arg)
 {
 	struct analogix_dp_device *dp = arg;
-	enum dp_irq_type irq_type;
+	u32 irq_type;
 
 	irq_type = analogix_dp_get_irq_type(dp);
 	if (irq_type & DP_IRQ_TYPE_HP_CABLE_IN ||
@@ -728,7 +728,7 @@ static irqreturn_t analogix_dp_irq_thread(int irq, void *arg)
 			drm_helper_hpd_irq_event(dp->drm_dev);
 	}
 
-	if (irq_type != DP_IRQ_TYPE_UNKNOWN) {
+	if (irq_type) {
 		analogix_dp_clear_hotplug_interrupts(dp);
 		analogix_dp_unmute_hpd_interrupt(dp);
 	}
diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
index c7997677a286..c2eba77f9a81 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
@@ -120,7 +120,7 @@ enum dp_irq_type {
 	DP_IRQ_TYPE_HP_CABLE_IN  = BIT(0),
 	DP_IRQ_TYPE_HP_CABLE_OUT = BIT(1),
 	DP_IRQ_TYPE_HP_CHANGE    = BIT(2),
-	DP_IRQ_TYPE_UNKNOWN      = BIT(3),
+	DP_IRQ_TYPE_IRQ_HPD      = BIT(3),
 };
 
 struct video_info {
@@ -193,7 +193,7 @@ void analogix_dp_set_analog_power_down(struct analogix_dp_device *dp,
 int analogix_dp_init_analog_func(struct analogix_dp_device *dp);
 void analogix_dp_init_hpd(struct analogix_dp_device *dp);
 void analogix_dp_force_hpd(struct analogix_dp_device *dp);
-enum dp_irq_type analogix_dp_get_irq_type(struct analogix_dp_device *dp);
+u32 analogix_dp_get_irq_type(struct analogix_dp_device *dp);
 void analogix_dp_clear_hotplug_interrupts(struct analogix_dp_device *dp);
 void analogix_dp_reset_aux(struct analogix_dp_device *dp);
 void analogix_dp_init_aux(struct analogix_dp_device *dp);
diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
index ea8401293a23..f4f859cb2936 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
@@ -413,8 +413,9 @@ void analogix_dp_force_hpd(struct analogix_dp_device *dp)
 	writel(reg, dp->reg_base + ANALOGIX_DP_SYS_CTL_3);
 }
 
-enum dp_irq_type analogix_dp_get_irq_type(struct analogix_dp_device *dp)
+u32 analogix_dp_get_irq_type(struct analogix_dp_device *dp)
 {
+	u32 irq_type = 0;
 	u32 reg;
 
 	if (dp->hpd_gpiod) {
@@ -426,17 +427,18 @@ enum dp_irq_type analogix_dp_get_irq_type(struct analogix_dp_device *dp)
 	} else {
 		/* Parse hotplug interrupt status register */
 		reg = readl(dp->reg_base + ANALOGIX_DP_COMMON_INT_STA_4);
-
 		if (reg & PLUG)
-			return DP_IRQ_TYPE_HP_CABLE_IN;
-
+			irq_type |= DP_IRQ_TYPE_HP_CABLE_IN;
 		if (reg & HPD_LOST)
-			return DP_IRQ_TYPE_HP_CABLE_OUT;
-
+			irq_type |= DP_IRQ_TYPE_HP_CABLE_OUT;
 		if (reg & HOTPLUG_CHG)
-			return DP_IRQ_TYPE_HP_CHANGE;
+			irq_type |= DP_IRQ_TYPE_HP_CHANGE;
+
+		reg = readl(dp->reg_base + ANALOGIX_DP_INT_STA);
+		if (reg & INT_HPD)
+			irq_type |= DP_IRQ_TYPE_IRQ_HPD;
 
-		return DP_IRQ_TYPE_UNKNOWN;
+		return irq_type;
 	}
 }
 
-- 
2.34.1

