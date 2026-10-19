Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74DEECCF2DA
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 09:04:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A570A10E8C4;
	Mon, 19 Oct 2026 09:04:43 +0000 (UTC)
Received: from mail-m127102.qiye.163.com (mail-m127102.qiye.163.com
 [115.236.127.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 326DA10E8CA
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 09:04:21 +0000 (UTC)
Received: from zyb-HP-ProDesk-680-G2-MT.. (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 5189b8634;
 Mon, 19 Oct 2026 16:59:16 +0800 (GMT+08:00)
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
Subject: [PATCH v4 13/14] drm/bridge: analogix_dp: Handle HPD notification
 from downstream bridge
Date: Mon, 19 Oct 2026 16:58:35 +0800
Message-Id: <20261019085836.3065008-14-damon.ding@rock-chips.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261019085836.3065008-1-damon.ding@rock-chips.com>
References: <20261019085836.3065008-1-damon.ding@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa15362f4ce03a8kunm6ee755052eac82
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaT01KVk5MGklOThpKGktLHlYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
 JDQk1VSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
 b=W7ZRLWseXdUoGO1+miqThGBT8wv2rvGjxONBL091lcgTEK+2pS7w2gUkTzjg47Vjrx4ILSMF1fRv63ftpaTGBLHmbt62cadlk9wxVu/dVBwdUJm4j1pqc0avVvHPUbB3wrZrvIifSnuIxL5ON+V1itePIw9pfW7b8Dc7AJySNrY=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=K/O4+f7RawSwy8Rs/c1ysu/2IkMAn3RGhQhN7V+GUH8=;
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

When the display pipeline includes a display-connector bridge with
hpd-gpios configured, the connector's hotplug status is managed by the
display-connector bridge through its GPIO, not by the Analogix DP
controller's native HPD. In this configuration, the DP controller's
internal HPD polling in analogix_dp_detect_hpd() does not reflect the
actual connection state.

At attach time, detect whether a downstream bridge provides HPD events
(DRM_BRIDGE_OP_HPD) while none of them provides detection
(DRM_BRIDGE_OP_DETECT). When found, switch to hpd notify mode: cache
the connection status reported through the .hpd_notify callback, mute
the controller's native HPD interrupts and skip their initialization,
and trust the cached status instead of polling the typically
unconnected native HPD pin.

Suggested-by: Heiko Stuebner <heiko@sntech.de>
Link: https://lore.kernel.org/all/5609825.iZASKD2KPV@diego/
Tested-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Damon Ding <damon.ding@rock-chips.com>

---

Changes in v3:
- Introduce hpd_notify_mode flag to skip native HPD operations when
  HPD comes from a downstream bridge.

Changes in v4:
- Add Tested-by tag.
---
 .../drm/bridge/analogix/analogix_dp_core.c    | 27 ++++++++++++++++++-
 .../drm/bridge/analogix/analogix_dp_core.h    |  2 ++
 .../gpu/drm/bridge/analogix/analogix_dp_reg.c |  7 +++--
 3 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index df898f314254..90245d55d1d2 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -45,7 +45,7 @@ static const bool verify_fast_training;
 static bool analogix_dp_require_pm_for_hpd_irq(struct analogix_dp_device *dp)
 {
 	return analogix_dp_is_rockchip(dp->plat_data->dev_type) && !dp->hpd_gpiod &&
-	       !dp->force_hpd;
+	       !dp->force_hpd && !dp->hpd_notify_mode;
 }
 
 static void analogix_dp_init_dp(struct analogix_dp_device *dp)
@@ -936,6 +936,21 @@ static bool analogix_dp_bridge_force_connected(struct analogix_dp_device *dp)
 	return force_connected;
 }
 
+static bool analogix_dp_has_downstream_hpd(struct analogix_dp_device *dp)
+{
+	bool hpd_bridge = false;
+
+	drm_for_each_bridge_in_chain_from(dp->bridge.next_bridge, bridge) {
+		if (bridge->ops & DRM_BRIDGE_OP_DETECT)
+			return false;
+
+		if (bridge->ops & DRM_BRIDGE_OP_HPD)
+			hpd_bridge = true;
+	}
+
+	return hpd_bridge;
+}
+
 static int analogix_dp_bridge_attach(struct drm_bridge *bridge,
 				     struct drm_encoder *encoder,
 				     enum drm_bridge_attach_flags flags)
@@ -964,6 +979,7 @@ static int analogix_dp_bridge_attach(struct drm_bridge *bridge,
 		 * accurate hotplug state.
 		 */
 		dp->force_connected_mode = analogix_dp_bridge_force_connected(dp);
+		dp->hpd_notify_mode = analogix_dp_has_downstream_hpd(dp);
 	}
 
 	return 0;
@@ -1260,6 +1276,14 @@ static void analogix_dp_bridge_atomic_post_disable(struct drm_bridge *bridge,
 		DRM_ERROR("Failed to enable psr (%d)\n", ret);
 }
 
+static void analogix_dp_bridge_notify(struct drm_bridge *bridge, struct drm_connector *connector,
+				      enum drm_connector_status status)
+{
+	struct analogix_dp_device *dp = to_dp(bridge);
+
+	dp->connection_notified = (status == connector_status_connected);
+}
+
 static const struct drm_bridge_funcs analogix_dp_bridge_funcs = {
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
@@ -1272,6 +1296,7 @@ static const struct drm_bridge_funcs analogix_dp_bridge_funcs = {
 	.attach = analogix_dp_bridge_attach,
 	.edid_read = analogix_dp_bridge_edid_read,
 	.detect = analogix_dp_bridge_detect,
+	.hpd_notify = analogix_dp_bridge_notify,
 };
 
 static int analogix_dp_dt_parse_lanes_map(struct analogix_dp_device *dp)
diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
index 5f5698c73d88..9f25fb6545ad 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
@@ -171,6 +171,8 @@ struct analogix_dp_device {
 	bool			fast_train_enable;
 	bool			psr_supported;
 	bool			force_connected_mode;
+	bool			hpd_notify_mode;
+	bool			connection_notified;
 
 	u8 dpcd[DP_RECEIVER_CAP_SIZE];
 
diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
index abbcdba1a438..4c5e18d40dad 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
@@ -193,7 +193,7 @@ void analogix_dp_config_interrupt(struct analogix_dp_device *dp)
 	writel(0, dp->reg_base + ANALOGIX_DP_COMMON_INT_MASK_2);
 	writel(0, dp->reg_base + ANALOGIX_DP_COMMON_INT_MASK_3);
 
-	if (dp->hpd_gpiod) {
+	if (dp->hpd_gpiod || dp->hpd_notify_mode) {
 		analogix_dp_mute_hpd_interrupt(dp, HPD_IRQ_ALL);
 		return;
 	}
@@ -435,7 +435,7 @@ void analogix_dp_init_hpd(struct analogix_dp_device *dp)
 {
 	u32 reg;
 
-	if (dp->hpd_gpiod)
+	if (dp->hpd_gpiod || dp->hpd_notify_mode)
 		return;
 
 	analogix_dp_clear_hotplug_interrupts(dp, HPD_IRQ_ALL);
@@ -539,6 +539,9 @@ int analogix_dp_get_plug_in_status(struct analogix_dp_device *dp)
 	if (dp->hpd_gpiod) {
 		if (gpiod_get_value(dp->hpd_gpiod))
 			return 0;
+	} else if (dp->hpd_notify_mode) {
+		if (dp->connection_notified)
+			return 0;
 	} else {
 		reg = readl(dp->reg_base + ANALOGIX_DP_SYS_CTL_3);
 		if (reg & HPD_STATUS)
-- 
2.34.1

