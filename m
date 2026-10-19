Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54133CCF2DB
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 08:59:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95FC610E88E;
	Mon, 19 Oct 2026 08:59:20 +0000 (UTC)
Received: from mail-m49228.qiye.163.com (mail-m49228.qiye.163.com
 [45.254.49.228])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBB4B10E88E
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 08:59:13 +0000 (UTC)
Received: from zyb-HP-ProDesk-680-G2-MT.. (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 5189b860c;
 Mon, 19 Oct 2026 16:59:10 +0800 (GMT+08:00)
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
Subject: [PATCH v4 08/14] drm/bridge: analogix_dp: Skip native HPD interrupt
 ops for GPIO HPD
Date: Mon, 19 Oct 2026 16:58:30 +0800
Message-Id: <20261019085836.3065008-9-damon.ding@rock-chips.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261019085836.3065008-1-damon.ding@rock-chips.com>
References: <20261019085836.3065008-1-damon.ding@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa15362dcad03a8kunm6ee755052eac4a
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaGBlLVhgdTkhNTEIZHxlLSFYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
 JDQ0xVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
 b=hk3A1/Kl1OQ9FnfocQX7UYVDnkPSMJdD6ryZb3YNshPp8xdjErKlCjdhuNmdGtY2/WRUCaetl7HLC2B8AZyf7cFHTCVzIwktrTzgWGIlVil/BnDCFT2hw3wLU2Ke63DgSOGxALoD1zryxMBFxL/+uv/IMtxFVIrrzJKA0rGq6/E=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=w/AHABs7lpo2wt8m91XWoj05K09t8me1OuP0cukEO70=;
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

GPIO HPD does not rely on DP controller internal native HPD interrupts.
Skip native HPD register manipulations to avoid irrelevant operations.

Move the hpd_gpiod guard to its caller so the helper operates purely on
the given bitmask, and mute all native HPD interrupts for GPIO mode.

Tested-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Damon Ding <damon.ding@rock-chips.com>

---

Changes in v2:
- Adapt to the newly added IRQF_ONESHOT related commit and expand the
  commit msg.

Changes in v3:
- Reorganize the branch layout for hpd_gpiod check.
- Simplify the commit msg.

Changes in v4:
- Add Tested-by tag.
---
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 2 +-
 drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c  | 7 ++++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index 287fc16125ef..b92d28546192 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -717,7 +717,7 @@ static irqreturn_t analogix_dp_irq_thread(int irq, void *arg)
 	bool hpd_detected;
 
 	irq_type = analogix_dp_get_irq_type(dp);
-	if (irq_type)
+	if (!dp->hpd_gpiod && irq_type)
 		analogix_dp_clear_hotplug_interrupts(dp, irq_type);
 
 	if (!dp->hpd_gpiod && analogix_dp_is_rockchip(dp->plat_data->dev_type))
diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
index 025da25463a8..af5e5a8ec88d 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
@@ -193,6 +193,11 @@ void analogix_dp_config_interrupt(struct analogix_dp_device *dp)
 	writel(0, dp->reg_base + ANALOGIX_DP_COMMON_INT_MASK_2);
 	writel(0, dp->reg_base + ANALOGIX_DP_COMMON_INT_MASK_3);
 
+	if (dp->hpd_gpiod) {
+		analogix_dp_mute_hpd_interrupt(dp, HPD_IRQ_ALL);
+		return;
+	}
+
 	/*
 	 * Either HOTPLUG_CHG interrupt or PLUG + HPD_LOST interrupt
 	 * pair can be used to implement hotplug detection.
@@ -415,7 +420,7 @@ void analogix_dp_clear_hotplug_interrupts(struct analogix_dp_device *dp, u32 irq
 {
 	u32 reg;
 
-	if (dp->hpd_gpiod || !irq_type)
+	if (!irq_type)
 		return;
 
 	reg = analogix_dp_irq_type_to_common_int_sta4(irq_type);
-- 
2.34.1

