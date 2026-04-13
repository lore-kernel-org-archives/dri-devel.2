Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E48AEF34C52
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 13:26:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D42EE89E1D;
	Mon, 13 Apr 2026 13:26:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="d6ZXj4Ab";
	dkim-atps=neutral
Received: from mail-m3298.qiye.163.com (mail-m3298.qiye.163.com
 [220.197.32.98])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10EE989E1D
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 13:26:02 +0000 (UTC)
Received: from zyb-HP-ProDesk-680-G2-MT.. (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 3a8976ada;
 Mon, 13 Apr 2026 21:25:58 +0800 (GMT+08:00)
From: Damon Ding <damon.ding@rock-chips.com>
To: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, inki.dae@samsung.com,
 sw0312.kim@samsung.com, kyungmin.park@samsung.com, krzk@kernel.org,
 jingoohan1@gmail.com, hjc@rock-chips.com, heiko@sntech.de,
 andy.yan@rock-chips.com
Cc: Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, alim.akhtar@samsung.com,
 dmitry.baryshkov@oss.qualcomm.com, luca.ceresoli@bootlin.com,
 nicolas.frattaroli@collabora.com, dianders@chromium.org,
 m.szyprowski@samsung.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-rockchip@lists.infradead.org,
 Damon Ding <damon.ding@rock-chips.com>
Subject: [PATCH v14 2/8] drm/bridge: analogix_dp: Apply drm_bridge_connector
 helper
Date: Mon, 13 Apr 2026 21:25:45 +0800
Message-Id: <20260413132551.1049307-3-damon.ding@rock-chips.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260413132551.1049307-1-damon.ding@rock-chips.com>
References: <20260413132551.1049307-1-damon.ding@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9d870533f803a3kunmf5e06f40656e4b
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGk5DTVZISRhPH0ofH0MaHk1WFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpKQk
 1VSktLVUpCWQY+
DKIM-Signature: a=rsa-sha256;
 b=d6ZXj4AbXRDrvfY5sFU5R1HouS0LcctrDCUAb1/4kpHYIwsOOmbtM5FTc0fotHLD9WuHwg4fsZX5yagAchWmVoet6lVNsEErv5PtJRXxrW9CUdM4ppFlzhMtNuOlOtRhTdw3zrXdVSQOiPhnPQ9B3Q5VrcCyId1rI19X54CFIi0=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=moiqijNlcjpf00K+vLN5gMkkVQ37b4reiK3V0F5Md4o=;
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

Initialize bridge_connector for both Rockchip and Exynos encoder sides.
Then, make DRM_BRIDGE_ATTACH_NO_CONNECTOR mandatory for Analogix bridge
side, as the private &drm_connector is no longer created.

The previous &drm_connector_funcs and &drm_connector_helper_funcs APIs
are replaced by the corresponding &drm_bridge_funcs APIs:

analogix_dp_atomic_check() -> analogix_dp_bridge_atomic_check()
analogix_dp_detect()       -> analogix_dp_bridge_detect()
analogix_dp_get_modes()    -> analogix_dp_bridge_get_modes()
                              analogix_dp_bridge_edid_read()

Additionally, the compatibilities of Analogix DP bridge based on whether
the next bridge is a 'panel'. If it is, OP_MODES and OP_DETECT are
supported; If not (the next bridge is a 'monitor' or a bridge chip),
OP_EDID and OP_DETECT are supported.

The devm_drm_bridge_add() is placed in analogix_dp_bind() instead of
analogix_dp_probe(), because the type of next bridge (the panel, monitor
or bridge chip) can only be determined after the probe process has fully
completed.

Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Heiko Stuebner <heiko@sntech.de> # rk3588

---

Changes in v2:
- For &drm_bridge.ops, remove DRM_BRIDGE_OP_HPD and add
  DRM_BRIDGE_OP_EDID.
- Add analogix_dp_bridge_edid_read().
- Move &analogix_dp_plat_data.skip_connector deletion to the previous
  patches.

Changes in v3:
- Rebase with the new devm_drm_bridge_alloc() related commit
  48f05c3b4b70 ("drm/bridge: analogix_dp: Use devm_drm_bridge_alloc()
  API").
- Expand the commit message.
- Call drm_bridge_get_modes() in analogix_dp_bridge_get_modes() if the
  bridge is available.
- Remove unnecessary parameter struct drm_connector* for callback
  &analogix_dp_plat_data.attach.
- In order to decouple the connector driver and the bridge driver, move
  the bridge connector initilization to the Rockchip and Exynos sides.

Changes in v4:
- Expand analogix_dp_bridge_detect() parameters to &drm_bridge and
  &drm_connector.
- Rename the &analogix_dp_plat_data.bridge to
  &analogix_dp_plat_data.next_bridge.

Changes in v5:
- Set the flag fo drm_bridge_attach() to DRM_BRIDGE_ATTACH_NO_CONNECTOR
  for next bridge attachment of Exynos side.
- Distinguish the &drm_bridge->ops of Analogix bridge based on whether
  the downstream device is a panel, a bridge or neither.
- Remove the calls to &analogix_dp_plat_data.get_modes().

Changes in v6:
- Select DRM_BRIDGE_CONNECTOR for both Rockchip and Exynos sides.
- Remove unnecessary drm_bridge_get_modes() in
  analogix_dp_bridge_get_modes().
- Simplify analogix_dp_bridge_edid_read().
- If the next is a bridge, set DRM_BRIDGE_OP_DETECT and return
  connector_status_connected in analogix_dp_bridge_detect().
- Set flag DRM_BRIDGE_ATTACH_NO_CONNECTOR for bridge attachment while
  binding. Meanwhile, make DRM_BRIDGE_ATTACH_NO_CONNECTOR unsuppported
  in analogix_dp_bridge_attach().
- Simplify the check of bridge capabilities.

Changes in v7:
- Remove temporary flag &exynos_dp_device.has_of_bridge.

Changes in v9
- Add Tested-by tag.

Changes in v10:
- Split this commit into serval smaller ones.
- Simplify the commit message.

Changes in v11:
- Move the removal of &analogix_dp_device.connector to this commit.
- In exynos_dp_bridge_attach(), set the bridge flag to 'flags |
  DRM_BRIDGE_ATTACH_NO_CONNECTOR' instead of fixed
  'DRM_BRIDGE_ATTACH_NO_CONNECTOR' for extensibility.

Changes in v12:
- Restore accidentally removed DRM_BRIDGE_CONNECTOR Kconfig in v10.

Changes in v13:
- Rebase after commit 01962a191242 ("drm/rockchip: analogix: Convert
  to drm_output_color_format")
- Modify '(on rk3588)' to '# rk3588' for Tested-by tag.

Changes in v14:
- Add Reviewed-by tags.
- Apply __free() to call drm_bridge_put() in CRC ralted functions.
---
 .../drm/bridge/analogix/analogix_dp_core.c    | 136 +++++++-----------
 .../drm/bridge/analogix/analogix_dp_core.h    |   1 -
 drivers/gpu/drm/exynos/Kconfig                |   1 +
 drivers/gpu/drm/exynos/exynos_dp.c            |  25 ++--
 drivers/gpu/drm/rockchip/Kconfig              |   1 +
 .../gpu/drm/rockchip/analogix_dp-rockchip.c   |  11 +-
 6 files changed, 79 insertions(+), 96 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index 84b994cce900..3c6eed9279d2 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -6,6 +6,7 @@
 * Author: Jingoo Han <jg1.han@samsung.com>
 */
 
+#include <linux/cleanup.h>
 #include <linux/clk.h>
 #include <linux/component.h>
 #include <linux/err.h>
@@ -856,44 +857,32 @@ static int analogix_dp_disable_psr(struct analogix_dp_device *dp)
 	return analogix_dp_send_psr_spd(dp, &psr_vsc, true);
 }
 
-static int analogix_dp_get_modes(struct drm_connector *connector)
+static int analogix_dp_bridge_get_modes(struct drm_bridge *bridge, struct drm_connector *connector)
 {
-	struct analogix_dp_device *dp = to_dp(connector);
-	const struct drm_edid *drm_edid;
+	struct analogix_dp_device *dp = to_dp(bridge);
 	int num_modes = 0;
 
-	if (dp->plat_data->panel) {
+	if (dp->plat_data->panel)
 		num_modes += drm_panel_get_modes(dp->plat_data->panel, connector);
-	} else {
-		drm_edid = drm_edid_read_ddc(connector, &dp->aux.ddc);
-
-		drm_edid_connector_update(&dp->connector, drm_edid);
-
-		if (drm_edid) {
-			num_modes += drm_edid_connector_add_modes(&dp->connector);
-			drm_edid_free(drm_edid);
-		}
-	}
 
 	return num_modes;
 }
 
-static struct drm_encoder *
-analogix_dp_best_encoder(struct drm_connector *connector)
+static const struct drm_edid *analogix_dp_bridge_edid_read(struct drm_bridge *bridge,
+							   struct drm_connector *connector)
 {
-	struct analogix_dp_device *dp = to_dp(connector);
+	struct analogix_dp_device *dp = to_dp(bridge);
 
-	return dp->encoder;
+	return drm_edid_read_ddc(connector, &dp->aux.ddc);
 }
 
-
-static int analogix_dp_atomic_check(struct drm_connector *connector,
-				    struct drm_atomic_state *state)
+static int analogix_dp_bridge_atomic_check(struct drm_bridge *bridge,
+					   struct drm_bridge_state *bridge_state,
+					   struct drm_crtc_state *crtc_state,
+					   struct drm_connector_state *conn_state)
 {
-	struct analogix_dp_device *dp = to_dp(connector);
-	struct drm_display_info *di = &connector->display_info;
-	struct drm_connector_state *conn_state;
-	struct drm_crtc_state *crtc_state;
+	struct analogix_dp_device *dp = to_dp(bridge);
+	struct drm_display_info *di = &conn_state->connector->display_info;
 	u32 mask = BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR444) | BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR422);
 
 	if (is_rockchip(dp->plat_data->dev_type)) {
@@ -905,38 +894,21 @@ static int analogix_dp_atomic_check(struct drm_connector *connector,
 		}
 	}
 
-	conn_state = drm_atomic_get_new_connector_state(state, connector);
-	if (WARN_ON(!conn_state))
-		return -ENODEV;
-
 	conn_state->self_refresh_aware = true;
 
-	if (!conn_state->crtc)
-		return 0;
-
-	crtc_state = drm_atomic_get_new_crtc_state(state, conn_state->crtc);
-	if (!crtc_state)
-		return 0;
-
 	if (crtc_state->self_refresh_active && !dp->psr_supported)
 		return -EINVAL;
 
 	return 0;
 }
 
-static const struct drm_connector_helper_funcs analogix_dp_connector_helper_funcs = {
-	.get_modes = analogix_dp_get_modes,
-	.best_encoder = analogix_dp_best_encoder,
-	.atomic_check = analogix_dp_atomic_check,
-};
-
 static enum drm_connector_status
-analogix_dp_detect(struct drm_connector *connector, bool force)
+analogix_dp_bridge_detect(struct drm_bridge *bridge, struct drm_connector *connector)
 {
-	struct analogix_dp_device *dp = to_dp(connector);
+	struct analogix_dp_device *dp = to_dp(bridge);
 	enum drm_connector_status status = connector_status_disconnected;
 
-	if (dp->plat_data->panel)
+	if (dp->plat_data->panel || dp->plat_data->next_bridge)
 		return connector_status_connected;
 
 	if (!analogix_dp_detect_hpd(dp))
@@ -945,51 +917,18 @@ analogix_dp_detect(struct drm_connector *connector, bool force)
 	return status;
 }
 
-static const struct drm_connector_funcs analogix_dp_connector_funcs = {
-	.fill_modes = drm_helper_probe_single_connector_modes,
-	.detect = analogix_dp_detect,
-	.destroy = drm_connector_cleanup,
-	.reset = drm_atomic_helper_connector_reset,
-	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
-	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
-};
-
 static int analogix_dp_bridge_attach(struct drm_bridge *bridge,
 				     struct drm_encoder *encoder,
 				     enum drm_bridge_attach_flags flags)
 {
 	struct analogix_dp_device *dp = to_dp(bridge);
-	struct drm_connector *connector = NULL;
 	int ret = 0;
 
-	if (flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR) {
-		DRM_ERROR("Fix bridge driver to make connector optional!");
+	if (!(flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR)) {
+		DRM_ERROR("Unsupported connector creation\n");
 		return -EINVAL;
 	}
 
-	if (!dp->plat_data->next_bridge) {
-		connector = &dp->connector;
-		connector->polled = DRM_CONNECTOR_POLL_HPD;
-
-		ret = drm_connector_init(dp->drm_dev, connector,
-					 &analogix_dp_connector_funcs,
-					 DRM_MODE_CONNECTOR_eDP);
-		if (ret) {
-			DRM_ERROR("Failed to initialize connector with drm\n");
-			return ret;
-		}
-
-		drm_connector_helper_add(connector,
-					 &analogix_dp_connector_helper_funcs);
-		drm_connector_attach_encoder(connector, encoder);
-	}
-
-	/*
-	 * NOTE: the connector registration is implemented in analogix
-	 * platform driver, that to say connector would be exist after
-	 * plat_data->attch return, that's why we record the connector
-	 * point after plat attached.
-	 */
 	if (dp->plat_data->attach) {
 		ret = dp->plat_data->attach(dp->plat_data, bridge);
 		if (ret) {
@@ -1309,7 +1248,11 @@ static const struct drm_bridge_funcs analogix_dp_bridge_funcs = {
 	.atomic_enable = analogix_dp_bridge_atomic_enable,
 	.atomic_disable = analogix_dp_bridge_atomic_disable,
 	.atomic_post_disable = analogix_dp_bridge_atomic_post_disable,
+	.atomic_check = analogix_dp_bridge_atomic_check,
 	.attach = analogix_dp_bridge_attach,
+	.get_modes = analogix_dp_bridge_get_modes,
+	.edid_read = analogix_dp_bridge_edid_read,
+	.detect = analogix_dp_bridge_detect,
 };
 
 static int analogix_dp_dt_parse_pdata(struct analogix_dp_device *dp)
@@ -1539,6 +1482,7 @@ EXPORT_SYMBOL_GPL(analogix_dp_resume);
 
 int analogix_dp_bind(struct analogix_dp_device *dp, struct drm_device *drm_dev)
 {
+	struct drm_bridge *bridge = &dp->bridge;
 	int ret;
 
 	dp->drm_dev = drm_dev;
@@ -1552,7 +1496,18 @@ int analogix_dp_bind(struct analogix_dp_device *dp, struct drm_device *drm_dev)
 		return ret;
 	}
 
-	ret = drm_bridge_attach(dp->encoder, &dp->bridge, NULL, 0);
+	if (dp->plat_data->panel)
+		bridge->ops = DRM_BRIDGE_OP_MODES | DRM_BRIDGE_OP_DETECT;
+	else
+		bridge->ops = DRM_BRIDGE_OP_EDID | DRM_BRIDGE_OP_DETECT;
+
+	bridge->of_node = dp->dev->of_node;
+	bridge->type = DRM_MODE_CONNECTOR_eDP;
+	ret = devm_drm_bridge_add(dp->dev, &dp->bridge);
+	if (ret)
+		goto err_unregister_aux;
+
+	ret = drm_bridge_attach(dp->encoder, bridge, NULL, DRM_BRIDGE_ATTACH_NO_CONNECTOR);
 	if (ret) {
 		DRM_ERROR("failed to create bridge (%d)\n", ret);
 		goto err_unregister_aux;
@@ -1570,7 +1525,6 @@ EXPORT_SYMBOL_GPL(analogix_dp_bind);
 void analogix_dp_unbind(struct analogix_dp_device *dp)
 {
 	analogix_dp_bridge_disable(&dp->bridge);
-	dp->connector.funcs->destroy(&dp->connector);
 
 	drm_panel_unprepare(dp->plat_data->panel);
 
@@ -1580,7 +1534,9 @@ EXPORT_SYMBOL_GPL(analogix_dp_unbind);
 
 int analogix_dp_start_crc(struct drm_connector *connector)
 {
-	struct analogix_dp_device *dp = to_dp(connector);
+	struct analogix_dp_device *dp;
+	struct drm_bridge *bridge __free(drm_bridge_put) =
+		drm_bridge_chain_get_first_bridge(connector->encoder);
 
 	if (!connector->state->crtc) {
 		DRM_ERROR("Connector %s doesn't currently have a CRTC.\n",
@@ -1588,13 +1544,25 @@ int analogix_dp_start_crc(struct drm_connector *connector)
 		return -EINVAL;
 	}
 
+	if (!bridge || bridge->type != DRM_MODE_CONNECTOR_eDP)
+		return -EINVAL;
+
+	dp = to_dp(bridge);
+
 	return drm_dp_start_crc(&dp->aux, connector->state->crtc);
 }
 EXPORT_SYMBOL_GPL(analogix_dp_start_crc);
 
 int analogix_dp_stop_crc(struct drm_connector *connector)
 {
-	struct analogix_dp_device *dp = to_dp(connector);
+	struct analogix_dp_device *dp;
+	struct drm_bridge *bridge __free(drm_bridge_put) =
+		drm_bridge_chain_get_first_bridge(connector->encoder);
+
+	if (!bridge || bridge->type != DRM_MODE_CONNECTOR_eDP)
+		return -EINVAL;
+
+	dp = to_dp(bridge);
 
 	return drm_dp_stop_crc(&dp->aux);
 }
diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
index 91b215c6a0cf..17347448c6b0 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
@@ -154,7 +154,6 @@ struct analogix_dp_device {
 	struct drm_encoder	*encoder;
 	struct device		*dev;
 	struct drm_device	*drm_dev;
-	struct drm_connector	connector;
 	struct drm_bridge	bridge;
 	struct drm_dp_aux	aux;
 	struct clk		*clock;
diff --git a/drivers/gpu/drm/exynos/Kconfig b/drivers/gpu/drm/exynos/Kconfig
index 380d9a8ce259..38bf070866f6 100644
--- a/drivers/gpu/drm/exynos/Kconfig
+++ b/drivers/gpu/drm/exynos/Kconfig
@@ -70,6 +70,7 @@ config DRM_EXYNOS_DP
 	bool "Exynos specific extensions for Analogix DP driver"
 	depends on DRM_EXYNOS_FIMD || DRM_EXYNOS7_DECON
 	select DRM_ANALOGIX_DP
+	select DRM_BRIDGE_CONNECTOR
 	select DRM_DISPLAY_DP_HELPER
 	default DRM_EXYNOS
 	select DRM_OF_DISPLAY_MODE_BRIDGE
diff --git a/drivers/gpu/drm/exynos/exynos_dp.c b/drivers/gpu/drm/exynos/exynos_dp.c
index 71a00ee97782..b2597fafd73d 100644
--- a/drivers/gpu/drm/exynos/exynos_dp.c
+++ b/drivers/gpu/drm/exynos/exynos_dp.c
@@ -22,6 +22,7 @@
 #include <drm/bridge/of-display-mode-bridge.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_bridge.h>
+#include <drm/drm_bridge_connector.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_of.h>
 #include <drm/drm_panel.h>
@@ -41,8 +42,6 @@ struct exynos_dp_device {
 
 	struct analogix_dp_device *adp;
 	struct analogix_dp_plat_data plat_data;
-
-	bool has_of_bridge;
 };
 
 static int exynos_dp_crtc_clock_enable(struct analogix_dp_plat_data *plat_data,
@@ -78,10 +77,8 @@ static int exynos_dp_bridge_attach(struct analogix_dp_plat_data *plat_data,
 
 	/* Pre-empt DP connector creation if there's a bridge */
 	if (plat_data->next_bridge) {
-		if (dp->has_of_bridge)
-			flags = DRM_BRIDGE_ATTACH_NO_CONNECTOR;
-
-		ret = drm_bridge_attach(&dp->encoder, plat_data->next_bridge, bridge, flags);
+		ret = drm_bridge_attach(&dp->encoder, plat_data->next_bridge, bridge,
+					flags | DRM_BRIDGE_ATTACH_NO_CONNECTOR);
 		if (ret)
 			return ret;
 	}
@@ -111,6 +108,7 @@ static int exynos_dp_bind(struct device *dev, struct device *master, void *data)
 	struct exynos_dp_device *dp = dev_get_drvdata(dev);
 	struct drm_encoder *encoder = &dp->encoder;
 	struct drm_device *drm_dev = data;
+	struct drm_connector *connector;
 	int ret;
 
 	dp->drm_dev = drm_dev;
@@ -126,10 +124,19 @@ static int exynos_dp_bind(struct device *dev, struct device *master, void *data)
 	dp->plat_data.encoder = encoder;
 
 	ret = analogix_dp_bind(dp->adp, dp->drm_dev);
-	if (ret)
+	if (ret) {
 		dp->encoder.funcs->destroy(&dp->encoder);
+		return ret;
+	}
+
+	connector = drm_bridge_connector_init(dp->drm_dev, dp->plat_data.encoder);
+	if (IS_ERR(connector)) {
+		ret = PTR_ERR(connector);
+		dev_err(dp->dev, "Failed to initialize bridge_connector\n");
+		return ret;
+	}
 
-	return ret;
+	return drm_connector_attach_encoder(connector, dp->plat_data.encoder);
 }
 
 static void exynos_dp_unbind(struct device *dev, struct device *master,
@@ -186,8 +193,6 @@ static int exynos_dp_probe(struct platform_device *pdev)
 									dp->dev->of_node,
 									DRM_MODE_CONNECTOR_eDP);
 		ret = IS_ERR(dp->plat_data.next_bridge) ? PTR_ERR(dp->plat_data.next_bridge) : 0;
-		if (!ret)
-			dp->has_of_bridge = true;
 	}
 	if (ret)
 		return ret;
diff --git a/drivers/gpu/drm/rockchip/Kconfig b/drivers/gpu/drm/rockchip/Kconfig
index 1479b8c4ed40..e7f49fe845ea 100644
--- a/drivers/gpu/drm/rockchip/Kconfig
+++ b/drivers/gpu/drm/rockchip/Kconfig
@@ -46,6 +46,7 @@ config ROCKCHIP_VOP2
 config ROCKCHIP_ANALOGIX_DP
 	bool "Rockchip specific extensions for Analogix DP driver"
 	depends on ROCKCHIP_VOP
+	select DRM_BRIDGE_CONNECTOR
 	select DRM_DISPLAY_HELPER
 	select DRM_DISPLAY_DP_HELPER
 	help
diff --git a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
index 48206a7b767f..99e739f4f583 100644
--- a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
@@ -25,6 +25,7 @@
 #include <drm/display/drm_dp_helper.h>
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
+#include <drm/drm_bridge_connector.h>
 #include <drm/bridge/analogix_dp.h>
 #include <drm/drm_of.h>
 #include <drm/drm_panel.h>
@@ -369,6 +370,7 @@ static int rockchip_dp_bind(struct device *dev, struct device *master,
 {
 	struct rockchip_dp_device *dp = dev_get_drvdata(dev);
 	struct drm_device *drm_dev = data;
+	struct drm_connector *connector;
 	int ret;
 
 	dp->drm_dev = drm_dev;
@@ -388,7 +390,14 @@ static int rockchip_dp_bind(struct device *dev, struct device *master,
 	if (ret)
 		goto err_cleanup_encoder;
 
-	return 0;
+	connector = drm_bridge_connector_init(dp->drm_dev, dp->plat_data.encoder);
+	if (IS_ERR(connector)) {
+		ret = PTR_ERR(connector);
+		dev_err(dp->dev, "Failed to initialize bridge_connector\n");
+		goto err_cleanup_encoder;
+	}
+
+	return drm_connector_attach_encoder(connector, dp->plat_data.encoder);
 err_cleanup_encoder:
 	dp->encoder.encoder.funcs->destroy(&dp->encoder.encoder);
 	return ret;
-- 
2.34.1

