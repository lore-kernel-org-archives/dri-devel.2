Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C9E606A33F
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 11:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=Ejrds9D5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 826F510FB85;
	Wed, 25 Nov 2026 11:22:47 +0000 (UTC)
Received: from mail-m128109.netease.com (mail-m128109.netease.com
 [103.209.128.109])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6F5C10FB7D
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 11:22:22 +0000 (UTC)
Received: from zyb-HP-ProDesk-680-G2-MT.. (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 55f81607f;
 Wed, 25 Nov 2026 19:22:19 +0800 (GMT+08:00)
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
Subject: [PATCH v7 19/20] drm/bridge: analogix_dp: Handle HPD notification
 from downstream bridge
Date: Wed, 25 Nov 2026 19:21:40 +0800
Message-Id: <20261125112141.1434903-20-damon.ding@rock-chips.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261125112141.1434903-1-damon.ding@rock-chips.com>
References: <20261125112141.1434903-1-damon.ding@rock-chips.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa21271380603a8kunm17c230507758f6
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDGUtPVkpNH0lPTUtOTBhMGlYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSE
 pKQk1VSktLVUpCWQY+
DKIM-Signature: a=rsa-sha256;
 b=Ejrds9D5wYOBATNMWR0mTHKf47hx8FsSosmTPjcEo+oHjtQZghc4AswjC1vaaJziNWWWXr4QSC5/BTdRtdin4amAd/yOrZCIcObr4+IYEXQTQo5geBwko8K6oh1CqQVWzAs8UARabNQfKn23wkK+Gl29rSIsMAOQZkak91gvWjQ=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=cTfxT3xlB0htyDQySiEht6C44WMHe7UJpV/KrZ87X98=;
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
(DRM_BRIDGE_OP_DETECT). When found, switch to hpd notify mode: mute
the controller's native HPD interrupts and skip their initialization,
and use the downstream notifications only as a trigger to probe the
sink over the AUX channel, treating it as connected when its DPCD can
be read back. The probe result is cached and refreshed by both the
notify and the detect paths, so that the reported state always comes
from the hardware and the stale echo cannot overwrite it.

Suggested-by: Heiko Stuebner <heiko@sntech.de>
Link: https://lore.kernel.org/all/5609825.iZASKD2KPV@diego/
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

Changes in v7:
- Probe the sink over the AUX channel in the hpd notify mode instead
  of relying on the notified status, refreshing the cached state in
  both the .hpd_notify and the detect path. (Sashiko)
- Exclude the hpd notify mode from analogix_dp_supports_hpd(), so
  that neither DRM_BRIDGE_OP_HPD is declared nor the hotplug IRQ is
  enabled for the muted native interrupts. (Sashiko)
- Skip the HPD polling and the AUX probe where they are not needed in
  the hpd notify mode and the other modes respectively.
- Drop the Tested-by tag, as the design of this patch changed
  significantly in this version.
---
 .../drm/bridge/analogix/analogix_dp_core.c    | 56 ++++++++++++++++++-
 .../drm/bridge/analogix/analogix_dp_core.h    |  2 +
 .../gpu/drm/bridge/analogix/analogix_dp_reg.c | 21 ++++---
 3 files changed, 67 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index 7ab183f72eb6..49d0eba74e7f 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -48,7 +48,7 @@ static const bool verify_fast_training;
  */
 static bool analogix_dp_supports_hpd(struct analogix_dp_device *dp)
 {
-	if (dp->force_connected_mode || dp->force_hpd)
+	if (dp->force_connected_mode || dp->force_hpd || dp->hpd_notify_mode)
 		return false;
 
 	if (dp->hpd_gpiod)
@@ -86,10 +86,29 @@ static void analogix_dp_init_dp(struct analogix_dp_device *dp)
 	analogix_dp_init_aux(dp);
 }
 
+static bool analogix_dp_probe_sink(struct analogix_dp_device *dp)
+{
+	u8 dpcd_rev = 0;
+	int ret;
+
+	ret = pm_runtime_resume_and_get(dp->dev);
+	if (ret)
+		return false;
+
+	ret = drm_dp_dpcd_readb(&dp->aux, DP_DPCD_REV, &dpcd_rev);
+
+	pm_runtime_put_autosuspend(dp->dev);
+
+	return ret == 1 && dpcd_rev != 0;
+}
+
 static int analogix_dp_detect_hpd(struct analogix_dp_device *dp)
 {
 	int timeout_loop = 0;
 
+	if (dp->hpd_notify_mode)
+		return 0;
+
 	while (timeout_loop < DP_TIMEOUT_LOOP_COUNT) {
 		if (analogix_dp_get_plug_in_status(dp) == 0)
 			return 0;
@@ -940,6 +959,13 @@ analogix_dp_bridge_detect(struct drm_bridge *bridge, struct drm_connector *conne
 	struct analogix_dp_device *dp = to_dp(bridge);
 	enum drm_connector_status status = connector_status_disconnected;
 
+	if (dp->hpd_notify_mode) {
+		dp->connection_notified = analogix_dp_probe_sink(dp);
+
+		return dp->connection_notified ? connector_status_connected :
+						 connector_status_disconnected;
+	}
+
 	if (dp->force_connected_mode)
 		return connector_status_connected;
 
@@ -972,6 +998,21 @@ static bool analogix_dp_bridge_force_connected(struct analogix_dp_device *dp)
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
@@ -1000,6 +1041,7 @@ static int analogix_dp_bridge_attach(struct drm_bridge *bridge,
 		 * accurate hotplug state.
 		 */
 		dp->force_connected_mode = analogix_dp_bridge_force_connected(dp);
+		dp->hpd_notify_mode = analogix_dp_has_downstream_hpd(dp);
 	}
 
 	return 0;
@@ -1296,6 +1338,17 @@ static void analogix_dp_bridge_atomic_post_disable(struct drm_bridge *bridge,
 		DRM_ERROR("Failed to enable psr (%d)\n", ret);
 }
 
+static void analogix_dp_bridge_notify(struct drm_bridge *bridge, struct drm_connector *connector,
+				      enum drm_connector_status status)
+{
+	struct analogix_dp_device *dp = to_dp(bridge);
+
+	if (!dp->hpd_notify_mode)
+		return;
+
+	dp->connection_notified = analogix_dp_probe_sink(dp);
+}
+
 static void analogix_dp_bridge_hpd_enable(struct drm_bridge *bridge)
 {
 }
@@ -1316,6 +1369,7 @@ static const struct drm_bridge_funcs analogix_dp_bridge_funcs = {
 	.attach = analogix_dp_bridge_attach,
 	.edid_read = analogix_dp_bridge_edid_read,
 	.detect = analogix_dp_bridge_detect,
+	.hpd_notify = analogix_dp_bridge_notify,
 	.hpd_enable = analogix_dp_bridge_hpd_enable,
 	.hpd_disable = analogix_dp_bridge_hpd_disable,
 };
diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
index 17ebb96d66ca..ebd0662aed5c 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
@@ -172,6 +172,8 @@ struct analogix_dp_device {
 	bool			psr_supported;
 	bool			force_connected_mode;
 	bool			hpd_irq_enabled;
+	bool			hpd_notify_mode;
+	bool			connection_notified;
 
 	u8 dpcd[DP_RECEIVER_CAP_SIZE];
 
diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
index af5e5a8ec88d..125f4fecbaa2 100644
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
@@ -533,16 +533,15 @@ int analogix_dp_get_plug_in_status(struct analogix_dp_device *dp)
 {
 	u32 reg;
 
-	if (dp->hpd_gpiod) {
-		if (gpiod_get_value(dp->hpd_gpiod))
-			return 0;
-	} else {
-		reg = readl(dp->reg_base + ANALOGIX_DP_SYS_CTL_3);
-		if (reg & HPD_STATUS)
-			return 0;
-	}
+	if (dp->hpd_gpiod)
+		return gpiod_get_value(dp->hpd_gpiod) ? 0 : -EINVAL;
+
+	if (dp->hpd_notify_mode)
+		return dp->connection_notified ? 0 : -EINVAL;
+
+	reg = readl(dp->reg_base + ANALOGIX_DP_SYS_CTL_3);
 
-	return -EINVAL;
+	return (reg & HPD_STATUS) ? 0 : -EINVAL;
 }
 
 void analogix_dp_enable_sw_function(struct analogix_dp_device *dp)
-- 
2.34.1

