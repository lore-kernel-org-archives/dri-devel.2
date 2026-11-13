Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021E4606A881
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 08:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=DniKXlZF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2487F110000;
	Fri, 13 Nov 2026 08:28:58 +0000 (UTC)
Received: from mail-m16023652229.xmail.ntesmail.com
 (mail-m16023652229.xmail.ntesmail.com [160.236.52.229])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2691D10FF8A
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 08:28:44 +0000 (UTC)
Received: from zyb-HP-ProDesk-680-G2-MT.. (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 54921be93;
 Fri, 13 Nov 2026 16:23:38 +0800 (GMT+08:00)
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
Subject: [PATCH v6 17/18] drm/bridge: analogix_dp: Handle HPD notification
 from downstream bridge
Date: Fri, 13 Nov 2026 16:23:04 +0800
Message-Id: <20261113082305.541652-18-damon.ding@rock-chips.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261113082305.541652-1-damon.ding@rock-chips.com>
References: <20261113082305.541652-1-damon.ding@rock-chips.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa1d40151bf03a8kunm073aab0481b09
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDT0hDVk4dHxgaGkxJQ0xPHVYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSE
 pKQk1VSktLVUpCWQY+
DKIM-Signature: a=rsa-sha256;
 b=DniKXlZFiSECkPl2KIyJI36033SPM52IeQ3GFmyPvR5sv2o7IwMShAZ2hnbdr4KfIRToFJaTQHS45e9LCsTb1O6nZquMgiBb07BJMtTNzn3qvrUSYiW3QlfZZILAOI+A3YAhOkIW8EbddPla3rkLn6AHuiLudrCRTbxJXeEDCiQ=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=71yHPsfM5QNzI+q6EnSKe6lKzIuWxTJ9Jr6MMOvQI/Q=;
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
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Damon Ding <damon.ding@rock-chips.com>

---

Changes in v3:
- Introduce hpd_notify_mode flag to skip native HPD operations when
  HPD comes from a downstream bridge.

Changes in v4:
- Add Tested-by tag.

Changes in v5:
- Return the connector status directly from analogix_dp_bridge_detect()
  in the hpd notify mode, to avoid the race where the hpd_notify() echo
  of the detect path overwrites a newer notification cached by
  analogix_dp_bridge_notify(). (Sashiko)

Changes in v6:
- Return the cached connection status instead of connector->status from
  analogix_dp_bridge_detect(), as connector->status may still be
  unknown before the first HPD notification or stale after the sysfs
  state forcing. (Sashiko)
- Add Tested-by tag.
---
 .../drm/bridge/analogix/analogix_dp_core.c    | 32 ++++++++++++++++++-
 .../drm/bridge/analogix/analogix_dp_core.h    |  2 ++
 .../gpu/drm/bridge/analogix/analogix_dp_reg.c |  7 ++--
 3 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index 9f50163aecf9..6db289344375 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -52,7 +52,8 @@ static const bool verify_fast_training;
 static bool analogix_dp_require_pm_for_hpd_irq(struct analogix_dp_device *dp)
 {
 	return (dp->plat_data->dev_type == RK3576_EDP || dp->plat_data->dev_type == RK3588_EDP) &&
-	       !dp->hpd_gpiod && !dp->force_hpd && !dp->force_connected_mode;
+	       !dp->hpd_gpiod && !dp->force_hpd && !dp->force_connected_mode &&
+	       !dp->hpd_notify_mode;
 }
 
 /*
@@ -946,6 +947,10 @@ analogix_dp_bridge_detect(struct drm_bridge *bridge, struct drm_connector *conne
 	enum drm_connector_status status = connector_status_disconnected;
 	int ret;
 
+	if (dp->hpd_notify_mode)
+		return dp->connection_notified ? connector_status_connected :
+						 connector_status_disconnected;
+
 	if (dp->force_connected_mode)
 		return connector_status_connected;
 
@@ -980,6 +985,21 @@ static bool analogix_dp_bridge_force_connected(struct analogix_dp_device *dp)
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
@@ -1008,6 +1028,7 @@ static int analogix_dp_bridge_attach(struct drm_bridge *bridge,
 		 * accurate hotplug state.
 		 */
 		dp->force_connected_mode = analogix_dp_bridge_force_connected(dp);
+		dp->hpd_notify_mode = analogix_dp_has_downstream_hpd(dp);
 	}
 
 	return 0;
@@ -1304,6 +1325,14 @@ static void analogix_dp_bridge_atomic_post_disable(struct drm_bridge *bridge,
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
 static void analogix_dp_bridge_hpd_enable(struct drm_bridge *bridge)
 {
 }
@@ -1324,6 +1353,7 @@ static const struct drm_bridge_funcs analogix_dp_bridge_funcs = {
 	.attach = analogix_dp_bridge_attach,
 	.edid_read = analogix_dp_bridge_edid_read,
 	.detect = analogix_dp_bridge_detect,
+	.hpd_notify = analogix_dp_bridge_notify,
 	.hpd_enable = analogix_dp_bridge_hpd_enable,
 	.hpd_disable = analogix_dp_bridge_hpd_disable,
 };
diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
index 2ac92b2bac0a..04db14a91074 100644
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
index af5e5a8ec88d..501360a175d5 100644
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
@@ -536,6 +536,9 @@ int analogix_dp_get_plug_in_status(struct analogix_dp_device *dp)
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

