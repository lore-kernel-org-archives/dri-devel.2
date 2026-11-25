Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA1C606A699
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 11:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=YR5I2N+F
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 118B110FB7F;
	Wed, 25 Nov 2026 11:22:23 +0000 (UTC)
Received: from mail-m16023652120.xmail.ntesmail.com
 (mail-m16023652120.xmail.ntesmail.com [160.236.52.120])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18A4910FB6E
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 11:22:09 +0000 (UTC)
Received: from zyb-HP-ProDesk-680-G2-MT.. (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 55f81604e;
 Wed, 25 Nov 2026 19:22:06 +0800 (GMT+08:00)
From: Damon Ding <damon.ding@rock-chips.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Jingoo Han <jingoohan1@gmail.com>,
 Inki Dae <inki.dae@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Peter Griffin <peter.griffin@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, Heiko Stuebner <heiko@sntech.de>,
 Sandy Huang <hjc@rock-chips.com>, Andy Yan <andyshrk@163.com>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-rockchip@lists.infradead.org,
 Damon Ding <damon.ding@rock-chips.com>
Subject: [PATCH v7 09/20] drm/bridge: analogix_dp: Extend
 clear_hotplug_interrupts to accept IRQ bitmask
Date: Wed, 25 Nov 2026 19:21:30 +0800
Message-Id: <20261125112141.1434903-10-damon.ding@rock-chips.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261125112141.1434903-1-damon.ding@rock-chips.com>
References: <20261125112141.1434903-1-damon.ding@rock-chips.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa21271047903a8kunm17c230507758a2
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCHRpNVkpLSx4ZGU1JS0lITFYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSE
 pKQk1VSktLVUpCWQY+
DKIM-Signature: a=rsa-sha256;
 b=YR5I2N+Fgi84u5SZgmtXHoE0go3+8r9GCfExpBccCsK9iErLGzsAUw2iR1eQoXdWSPx0sN24hXsFqrUBZxGA7/fiYz2fkTSkFRq+ZirGCkU8J1/opeImt8pi/b9cExU9iEdMprkcQtt9ASnWH3y8u6JloxKp25tOQW0nmk+nvqQ=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=Tr1h0gj/3WopZjD3+EPQDL0RB8TRoQQwGu1QvSaUy0k=;
 h=date:mime-version:subject:message-id:from;
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Update analogix_dp_clear_hotplug_interrupts() to take an irq_type
bitmask argument. Instead of clearing all hotplug interrupt bits
unconditionally, only clear the interrupt flags corresponding to the
triggered events.

Pass the detected IRQ bitmask from the irq thread handler, and use the
full HPD_IRQ_ALL mask during HPD initialization.

Tested-by: Heiko Stuebner <heiko@sntech.de>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Damon Ding <damon.ding@rock-chips.com>

---

Changes in v2:
- Add separate patch for IRQF_ONESHOT to resolve interrupt mask issues
  triggered by interrupt preemption. (Sashiko)

Changes in v3:
- Rename newly added macro HPD_IRQ to HPD_IRQ_ALL.

Changes in v4:
- Add Tested-by tag.

Changes in v6:
- Add Tested-by tag.
---
 .../drm/bridge/analogix/analogix_dp_core.c    |  2 +-
 .../drm/bridge/analogix/analogix_dp_core.h    |  2 +-
 .../gpu/drm/bridge/analogix/analogix_dp_reg.c | 28 +++++++++++++------
 3 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index ecc10a01cb48..44ccdf496bac 100644
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
index cc3466304531..068be3464521 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
@@ -197,7 +197,7 @@ int analogix_dp_init_analog_func(struct analogix_dp_device *dp);
 void analogix_dp_init_hpd(struct analogix_dp_device *dp);
 void analogix_dp_force_hpd(struct analogix_dp_device *dp);
 u32 analogix_dp_get_irq_type(struct analogix_dp_device *dp);
-void analogix_dp_clear_hotplug_interrupts(struct analogix_dp_device *dp);
+void analogix_dp_clear_hotplug_interrupts(struct analogix_dp_device *dp, u32 irq_type);
 void analogix_dp_reset_aux(struct analogix_dp_device *dp);
 void analogix_dp_init_aux(struct analogix_dp_device *dp);
 int analogix_dp_get_plug_in_status(struct analogix_dp_device *dp);
diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
index 49c1961e4326..2c1d4655114b 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
@@ -24,6 +24,11 @@
 #define COMMON_INT_MASK_4	(HOTPLUG_CHG | HPD_LOST | PLUG)
 #define INT_STA_MASK		INT_HPD
 
+#define HPD_IRQ_ALL		(DP_IRQ_TYPE_HP_CABLE_IN | DP_IRQ_TYPE_HP_CABLE_OUT | \
+				 DP_IRQ_TYPE_HP_CHANGE | DP_IRQ_TYPE_IRQ_HPD)
+#define COMMON_INT_4_HPD_IRQ	(DP_IRQ_TYPE_HP_CABLE_IN | DP_IRQ_TYPE_HP_CABLE_OUT | \
+				 DP_IRQ_TYPE_HP_CHANGE)
+
 void analogix_dp_enable_video_mute(struct analogix_dp_device *dp, bool enable)
 {
 	u32 reg;
@@ -375,18 +380,25 @@ int analogix_dp_init_analog_func(struct analogix_dp_device *dp)
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
@@ -396,7 +408,7 @@ void analogix_dp_init_hpd(struct analogix_dp_device *dp)
 	if (dp->hpd_gpiod)
 		return;
 
-	analogix_dp_clear_hotplug_interrupts(dp);
+	analogix_dp_clear_hotplug_interrupts(dp, HPD_IRQ_ALL);
 
 	reg = readl(dp->reg_base + ANALOGIX_DP_SYS_CTL_3);
 	reg &= ~(F_HPD | HPD_CTRL);
-- 
2.34.1

