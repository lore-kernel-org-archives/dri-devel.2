Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0425FC55ABA
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 08:17:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2823A10E8CD;
	Tue,  4 Aug 2026 08:17:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="COTTmiAC";
	dkim-atps=neutral
Received: from mail-m128196.netease.com (mail-m128196.netease.com
 [103.209.128.196])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C26010E660
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 08:17:28 +0000 (UTC)
Received: from zyb-HP-ProDesk-680-G2-MT.. (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 48b4ffecd;
 Tue, 4 Aug 2026 16:17:24 +0800 (GMT+08:00)
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
Subject: [PATCH v2 01/10] drm/bridge: analogix_dp: Manage pm runtime and IRQ
 for native HPD pin detection
Date: Tue,  4 Aug 2026 16:17:08 +0800
Message-Id: <20260804081717.741404-2-damon.ding@rock-chips.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260804081717.741404-1-damon.ding@rock-chips.com>
References: <20260804081717.741404-1-damon.ding@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9fcbd9516f03a8kunma7b8cbe762b076
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCH0pIVh9CHxpLSEoYHR9NGVYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
 9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
 b=COTTmiACHu7mxiymeHQGDhyj3CKtjMupOmAokxY9vQPfojYz1PeK6+IC7JVw6+ku/BzJqKTFN3thAcpABeAL8GYkHhNRatvoQCKzY/OeAoYY4cduEyTDiEacJnUtPyDpncmhvXh/tgKgo87RrFM4kDMbbtSiGn6NvttX+oLktVk=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=uv2XD3C+LzzidqmvYrqHbQN4LFdznI4u/re75CGmFaQ=;
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

To keep HPD detection active while the display is disabled, move
enable_irq()/disable_irq() out of bridge enable/disable handlers and
split IRQ management paths:
- Native HPD pin mode: enable IRQ in analogix_dp_bind() and disable
  in analogix_dp_unbind(). Hold runtime PM power to keep controller
  alive for hotplug interrupts.
- GPIO HPD and force-HPD modes: retain original logic, manage IRQ
  within bridge enable/disable callbacks.

Persistent power hold is only necessary for native HPD pin mode.
It is not required for force-HPD or GPIO HPD modes. Add helper
analogix_dp_require_pm_for_hpd_irq() to identify Rockchip native HPD
pin configurations and switch IRQ handling accordingly.

Signed-off-by: Damon Ding <damon.ding@rock-chips.com>

---

Change in v2:
- Split IRQ enable/disable logic, handle native HPD pin and
  GPIO/force-HPD modes separately to avoid unbalanced enable_irq()
  calls.(Sashiko)
---
 .../drm/bridge/analogix/analogix_dp_core.c    | 25 +++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index 8d3d4a6e6ca2..18f300b49644 100644
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
@@ -1014,7 +1020,8 @@ static int analogix_dp_set_bridge(struct analogix_dp_device *dp)
 		goto out_dp_init;
 	}
 
-	enable_irq(dp->irq);
+	if (!analogix_dp_require_pm_for_hpd_irq(dp))
+		enable_irq(dp->irq);
 	return 0;
 
 out_dp_init:
@@ -1156,7 +1163,8 @@ static void analogix_dp_bridge_disable(struct drm_bridge *bridge)
 	if (dp->dpms_mode != DRM_MODE_DPMS_ON)
 		return;
 
-	disable_irq(dp->irq);
+	if (!analogix_dp_require_pm_for_hpd_irq(dp))
+		disable_irq(dp->irq);
 
 	analogix_dp_set_analog_power_down(dp, POWER_ALL, 1);
 
@@ -1504,6 +1512,14 @@ int analogix_dp_bind(struct analogix_dp_device *dp, struct drm_device *drm_dev)
 		goto err_unregister_aux;
 	}
 
+	if (analogix_dp_require_pm_for_hpd_irq(dp)) {
+		ret = pm_runtime_resume_and_get(dp->dev);
+		if (ret)
+			goto err_unregister_aux;
+
+		enable_irq(dp->irq);
+	}
+
 	return 0;
 
 err_unregister_aux:
@@ -1515,6 +1531,11 @@ EXPORT_SYMBOL_GPL(analogix_dp_bind);
 
 void analogix_dp_unbind(struct analogix_dp_device *dp)
 {
+	if (analogix_dp_require_pm_for_hpd_irq(dp)) {
+		disable_irq(dp->irq);
+		pm_runtime_put_sync(dp->dev);
+	}
+
 	drm_dp_aux_unregister(&dp->aux);
 }
 EXPORT_SYMBOL_GPL(analogix_dp_unbind);
-- 
2.34.1

