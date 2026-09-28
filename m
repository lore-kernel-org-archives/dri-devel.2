Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BFE3C9833E
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 08:15:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6435D10E7FC;
	Mon, 28 Sep 2026 08:15:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="FHR468bO";
	dkim-atps=neutral
Received: from mail-m935.xmail.ntesmail.com (mail-m935.xmail.ntesmail.com
 [103.126.93.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46C7910E7F1
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 08:15:17 +0000 (UTC)
Received: from zyb-HP-ProDesk-680-G2-MT.. (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 4f5398ea3;
 Mon, 28 Sep 2026 16:15:14 +0800 (GMT+08:00)
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
Subject: [PATCH v3 10/14] drm/bridge: analogix_dp: Manage pm runtime and IRQ
 for native HPD pin detection
Date: Mon, 28 Sep 2026 16:14:14 +0800
Message-Id: <20260928081418.3605775-11-damon.ding@rock-chips.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260928081418.3605775-1-damon.ding@rock-chips.com>
References: <20260928081418.3605775-1-damon.ding@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0e715167803a8kunm323e2b5437cf71
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZSEoeVk5DS09JGRlIGB1MH1YVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
 9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
 b=FHR468bOgqbhhO89sW6plrUIBNGprK8yYsnbhwl/HwN66rnW4hGl8VtzxBx68WybFuSZzy8j3qDfROdZCxkvRQ6vAzV8f/oAq+aB4t0IwrwwrfY+6QjEQaNJ508ExGLqC6LpAn4qYVRjMuO/H56CpbpVCrtGHnvHBXYvQ1Gt82w=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=QLzkxeakjSh54tUqTZOT4TJ34W2N82hCyBquIMOGQ6g=;
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

On Rockchip platforms, the Analogix DP native HPD pin IRQ requires the
DP controller to remain powered and clocked to generate plug/unplug
interrupts. Without a runtime PM reference, the controller suspends
when the display pipeline is inactive, disabling HPD detection.

Acquire a runtime PM reference in analogix_dp_bind() and release it in
analogix_dp_unbind() for native HPD pin mode. This keeps the controller
alive throughout the device lifecycle for continuous hotplug detection.

Persistent power is only necessary for native HPD pin mode. It is not
required for force-HPD or GPIO HPD modes, where hotplug detection does
not depend on the DP controller's internal interrupt logic. Add helper
analogix_dp_require_pm_for_hpd_irq() to identify Rockchip native HPD
pin configurations (non-GPIO, non-force-HPD).

Signed-off-by: Damon Ding <damon.ding@rock-chips.com>

---

Changes in v2:
- Split IRQ enable/disable logic, handle native HPD pin and
  GPIO/force-HPD modes separately to avoid unbalanced enable_irq()
  calls.(Sashiko)

Changes in v3:
- Modify the commit msg according to the previous commit for moving IRQ
  enabling/disabling.
---
 .../gpu/drm/bridge/analogix/analogix_dp_core.c   | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index addd319719de..38857508d939 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -39,6 +39,12 @@
 
 static const bool verify_fast_training;
 
+static bool analogix_dp_require_pm_for_hpd_irq(struct analogix_dp_device *dp)
+{
+	return analogix_dp_is_rockchip(dp->plat_data->dev_type) && !dp->hpd_gpiod &&
+	       !dp->force_hpd;
+}
+
 static void analogix_dp_init_dp(struct analogix_dp_device *dp)
 {
 	analogix_dp_reset(dp);
@@ -1571,6 +1577,12 @@ int analogix_dp_bind(struct analogix_dp_device *dp, struct drm_device *drm_dev)
 		goto err_unregister_aux;
 	}
 
+	if (analogix_dp_require_pm_for_hpd_irq(dp)) {
+		ret = pm_runtime_resume_and_get(dp->dev);
+		if (ret)
+			goto err_unregister_aux;
+	}
+
 	enable_irq(dp->irq);
 
 	return 0;
@@ -1585,6 +1597,10 @@ EXPORT_SYMBOL_GPL(analogix_dp_bind);
 void analogix_dp_unbind(struct analogix_dp_device *dp)
 {
 	disable_irq(dp->irq);
+
+	if (analogix_dp_require_pm_for_hpd_irq(dp))
+		pm_runtime_put_sync(dp->dev);
+
 	drm_dp_aux_unregister(&dp->aux);
 }
 EXPORT_SYMBOL_GPL(analogix_dp_unbind);
-- 
2.34.1

