Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 444D3C54FCD
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 03:28:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2A4610E0DF;
	Thu, 30 Jul 2026 03:28:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="iN22kAvV";
	dkim-atps=neutral
Received: from mail-m20521016456.xmail.ntesmail.com
 (mail-m20521016456.xmail.ntesmail.com [205.210.164.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF72410E0DF
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 03:28:01 +0000 (UTC)
Received: from zyb-HP-ProDesk-680-G2-MT.. (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 481c5dbc6;
 Thu, 30 Jul 2026 11:27:57 +0800 (GMT+08:00)
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
Subject: [PATCH v1 1/7] drm/bridge: analogix_dp: Manage pm runtime and IRQ for
 native HPD pin detection
Date: Thu, 30 Jul 2026 11:27:38 +0800
Message-Id: <20260730032744.381566-2-damon.ding@rock-chips.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260730032744.381566-1-damon.ding@rock-chips.com>
References: <20260730032744.381566-1-damon.ding@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9fb110839103a8kunm040f79123746d0
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaTUpDVhkfTx9KThoYSRlOHVYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
 9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
 b=iN22kAvV7y9P3Y4nkAsRqaTHyg9Fnsmxj+NKbYFGlbJTivI+FhlKAaonlRq6saPIelsRuKKfNR775t+Rxj8hJ/V6F3p+qPpJy3movN6X+toIEIeYL7EPjUy+wwQTzj8RmDzsIdfrLcUfBwW90UA8rFfZJFo/V8fRbpuUya7aSx8=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=ZOGfkFQw9P09ICYq3dP7Cmnkm3UbspD2UKIejaJKRIY=;
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

On Rockchip platforms, the Analogix DP native HPD pin IRQ functionality
requires the DP controller to be powered, clocked and initialized to
generate plug/unplug interrupts correctly.

To keep HPD detection active, move enable_irq()/disable_irq() from
bridge enabling/disabling handlers into analogix_dp_bind() and
analogix_dp_unbind(). Call pm_runtime_resume_and_get() before enabling
IRQ and pm_runtime_put_sync() after disabling IRQ for symmetric power
management.

Persistent power is only necessary for native HPD pin mode. It is not
required for force-HPD or GPIO HPD modes. Add helper to handle this
special case exclusively for Rockchip native HPD pin configurations.

Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
---
 .../drm/bridge/analogix/analogix_dp_core.c    | 22 ++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index 8d3d4a6e6ca2..d414f4ff40c8 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -40,6 +40,12 @@
 
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
@@ -1014,7 +1020,6 @@ static int analogix_dp_set_bridge(struct analogix_dp_device *dp)
 		goto out_dp_init;
 	}
 
-	enable_irq(dp->irq);
 	return 0;
 
 out_dp_init:
@@ -1156,8 +1161,6 @@ static void analogix_dp_bridge_disable(struct drm_bridge *bridge)
 	if (dp->dpms_mode != DRM_MODE_DPMS_ON)
 		return;
 
-	disable_irq(dp->irq);
-
 	analogix_dp_set_analog_power_down(dp, POWER_ALL, 1);
 
 	pm_runtime_put_sync(dp->dev);
@@ -1504,6 +1507,14 @@ int analogix_dp_bind(struct analogix_dp_device *dp, struct drm_device *drm_dev)
 		goto err_unregister_aux;
 	}
 
+	if (analogix_dp_require_pm_for_hpd_irq(dp)) {
+		ret = pm_runtime_resume_and_get(dp->dev);
+		if (ret)
+			goto err_unregister_aux;
+	}
+
+	enable_irq(dp->irq);
+
 	return 0;
 
 err_unregister_aux:
@@ -1515,6 +1526,11 @@ EXPORT_SYMBOL_GPL(analogix_dp_bind);
 
 void analogix_dp_unbind(struct analogix_dp_device *dp)
 {
+	disable_irq(dp->irq);
+
+	if (analogix_dp_require_pm_for_hpd_irq(dp))
+		pm_runtime_put_sync(dp->dev);
+
 	drm_dp_aux_unregister(&dp->aux);
 }
 EXPORT_SYMBOL_GPL(analogix_dp_unbind);
-- 
2.34.1

