Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C47C1CCF2D6
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 09:04:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7E8410E8C3;
	Mon, 19 Oct 2026 09:04:16 +0000 (UTC)
Received: from mail-m12799.qiye.163.com (mail-m12799.qiye.163.com
 [115.236.127.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB49B10E8B1
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 09:04:10 +0000 (UTC)
Received: from zyb-HP-ProDesk-680-G2-MT.. (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 5189b85e3;
 Mon, 19 Oct 2026 16:59:03 +0800 (GMT+08:00)
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
Subject: [PATCH v4 03/14] drm/bridge: analogix_dp: Add IRQF_ONESHOT and
 simplify IRQ handling
Date: Mon, 19 Oct 2026 16:58:25 +0800
Message-Id: <20261019085836.3065008-4-damon.ding@rock-chips.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261019085836.3065008-1-damon.ding@rock-chips.com>
References: <20261019085836.3065008-1-damon.ding@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa15362c34e03a8kunm6ee755052eac0c
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCTEtDVkMfSRkdQ0lLGhoYGFYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
 9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
 b=V1piAwZ4pFZNkca7Quy0wrZqJ16Yv55AMW2BD0JHFk3gwaX1J/TOnS4zgEgUwakPbe/E2xoP0QOJj7b9+dBlontTlwd9Iy8x5bqsk1Bz7IbItDBEDbE1aAh1VNPc3DPDpaZZlrjcTgt9qaWJIFMLiRICbdWMgRH/YI3PecW3P6o=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=2L+09F9hyYJBtW2+9gGxzTO7Q7byd/UcjK8R6Uj43ZY=;
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

The threaded IRQ is requested without IRQF_ONESHOT, allowing hardirq to
preempt the threaded handler. This creates a read-modify-write race on
HPD interrupt mask registers between the hardirq mute and thread unmute
operations.

Add IRQF_ONESHOT to keep the IRQ line masked during thread execution,
which eliminates the race and makes the per-event mute/unmute calls in
hardirq and thread handlers redundant. Move interrupt status clearing
to the beginning of the threaded handler, before
drm_helper_hpd_irq_event(), to avoid losing events that arrive during
the event handling.

Tested-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Damon Ding <damon.ding@rock-chips.com>

---

Changes in v3:
- Split out a separate commit to improve the return value checking for
  &analogix_dp_device.irq.(Sashiko)

Changes in v4:
- Add Tested-by tag.
---
 .../gpu/drm/bridge/analogix/analogix_dp_core.c  | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index 27c9a764e25f..974be5b702dc 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -704,10 +704,8 @@ static irqreturn_t analogix_dp_hardirq(int irq, void *arg)
 	u32 irq_type;
 
 	irq_type = analogix_dp_get_irq_type(dp);
-	if (irq_type) {
-		analogix_dp_mute_hpd_interrupt(dp);
+	if (irq_type)
 		ret = IRQ_WAKE_THREAD;
-	}
 
 	return ret;
 }
@@ -718,6 +716,9 @@ static irqreturn_t analogix_dp_irq_thread(int irq, void *arg)
 	u32 irq_type;
 
 	irq_type = analogix_dp_get_irq_type(dp);
+	if (irq_type)
+		analogix_dp_clear_hotplug_interrupts(dp);
+
 	if (irq_type & DP_IRQ_TYPE_HP_CABLE_IN ||
 	    irq_type & DP_IRQ_TYPE_HP_CABLE_OUT) {
 		dev_dbg(dp->dev, "Detected cable status changed!\n");
@@ -725,11 +726,6 @@ static irqreturn_t analogix_dp_irq_thread(int irq, void *arg)
 			drm_helper_hpd_irq_event(dp->drm_dev);
 	}
 
-	if (irq_type) {
-		analogix_dp_clear_hotplug_interrupts(dp);
-		analogix_dp_unmute_hpd_interrupt(dp);
-	}
-
 	return IRQ_HANDLED;
 }
 
@@ -1474,10 +1470,11 @@ analogix_dp_probe(struct device *dev, struct analogix_dp_plat_data *plat_data)
 		 * that we can get the current state of the GPIO.
 		 */
 		dp->irq = gpiod_to_irq(dp->hpd_gpiod);
-		irq_flags = IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING | IRQF_NO_AUTOEN;
+		irq_flags = IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING | IRQF_NO_AUTOEN |
+			    IRQF_ONESHOT;
 	} else {
 		dp->irq = platform_get_irq(pdev, 0);
-		irq_flags = IRQF_NO_AUTOEN;
+		irq_flags = IRQF_NO_AUTOEN | IRQF_ONESHOT;
 	}
 
 	if (dp->irq < 0) {
-- 
2.34.1

