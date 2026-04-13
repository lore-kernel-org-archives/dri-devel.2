Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90857F34C55
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 13:26:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C55B410E43E;
	Mon, 13 Apr 2026 13:26:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="TEeqF7WQ";
	dkim-atps=neutral
Received: from mail-m21472.qiye.163.com (mail-m21472.qiye.163.com
 [117.135.214.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F78B10E43E
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 13:26:18 +0000 (UTC)
Received: from zyb-HP-ProDesk-680-G2-MT.. (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 3a8976af0;
 Mon, 13 Apr 2026 21:26:11 +0800 (GMT+08:00)
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
Subject: [PATCH v14 8/8] drm/bridge: analogix_dp: Apply panel_bridge helper
Date: Mon, 13 Apr 2026 21:25:51 +0800
Message-Id: <20260413132551.1049307-9-damon.ding@rock-chips.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260413132551.1049307-1-damon.ding@rock-chips.com>
References: <20260413132551.1049307-1-damon.ding@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9d870565b503a3kunmf5e06f40656e7b
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUxOH1ZJTR8aGk9JHh0ZSk1WFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpKQk
 1VSktLVUpCWQY+
DKIM-Signature: a=rsa-sha256;
 b=TEeqF7WQ7niCIEHc2cAobaVPLhm6c9pEpr2UhcpnXSqeZ7o2k0qiPDp95K2T28B+Kt6QNzVomNwHSkXEQ4WiT4cToTrQ/7YTx2bhNccwVZicySQJzpStLRCBk/nSKbBV/eCh+EbW9fxjNg/LzMGqPhTacsXTypg0FF9IMlxpw4Q=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=nfjij6qpBwC0eoezp02dNK98XjMr872rBbzAOyaM1/U=;
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

In order to unify the handling of the panel and bridge, apply
panel_bridge helpers for Analogix DP driver. With this patch, the
bridge support will also become available.

The following changes have ben made:
- Apply plane_bridge helper to wrap the panel as the bridge.
- Remove the explicit panel APIs calls, which can be replaced with
  the automic bridge APIs calls wrapped by the panel.
- Remove the unnecessary analogix_dp_bridge_get_modes().

Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Heiko Stuebner <heiko@sntech.de> # rk3588

---

Changes in v4:
- Rename the &analogix_dp_plat_data.bridge to
  &analogix_dp_plat_data.next_bridge.

Changes in v5:
- Move panel_bridge addition a little forward.
- Move next_bridge attachment from Analogix side to Rockchip/Exynos
  side.

Changes in v6
- Remove the unnecessary analogix_dp_bridge_get_modes().
- Not to set DRM_BRIDGE_OP_MODES if the next is a panel.
- Squash [PATCH v5 15/17]drm/bridge: analogix_dp: Remove panel
  disabling and enabling in analogix_dp_set_bridge() into this
  commit.
- Fix the &drm_bridge->ops to DRM_BRIDGE_OP_EDID | DRM_BRIDGE_OP_DETECT.

Changes in v9:
- Add Tested-by tag.

Changes in v13:
- Modify '(on rk3588)' to '# rk3588' for Tested-by tag.
---
 .../drm/bridge/analogix/analogix_dp_core.c    | 41 +++++--------------
 1 file changed, 11 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index ec56d900f899..460729fdcecd 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -750,9 +750,6 @@ static int analogix_dp_commit(struct analogix_dp_device *dp)
 {
 	int ret;
 
-	/* Keep the panel disabled while we configure video */
-	drm_panel_disable(dp->plat_data->panel);
-
 	ret = analogix_dp_train_link(dp);
 	if (ret) {
 		dev_err(dp->dev, "unable to do link train, ret=%d\n", ret);
@@ -772,9 +769,6 @@ static int analogix_dp_commit(struct analogix_dp_device *dp)
 		return ret;
 	}
 
-	/* Safe to enable the panel now */
-	drm_panel_enable(dp->plat_data->panel);
-
 	/* Check whether panel supports fast training */
 	ret = analogix_dp_fast_link_train_detection(dp);
 	if (ret)
@@ -859,17 +853,6 @@ static int analogix_dp_disable_psr(struct analogix_dp_device *dp)
 	return analogix_dp_send_psr_spd(dp, &psr_vsc, true);
 }
 
-static int analogix_dp_bridge_get_modes(struct drm_bridge *bridge, struct drm_connector *connector)
-{
-	struct analogix_dp_device *dp = to_dp(bridge);
-	int num_modes = 0;
-
-	if (dp->plat_data->panel)
-		num_modes += drm_panel_get_modes(dp->plat_data->panel, connector);
-
-	return num_modes;
-}
-
 static const struct drm_edid *analogix_dp_bridge_edid_read(struct drm_bridge *bridge,
 							   struct drm_connector *connector)
 {
@@ -910,7 +893,7 @@ analogix_dp_bridge_detect(struct drm_bridge *bridge, struct drm_connector *conne
 	struct analogix_dp_device *dp = to_dp(bridge);
 	enum drm_connector_status status = connector_status_disconnected;
 
-	if (dp->plat_data->panel || dp->plat_data->next_bridge)
+	if (dp->plat_data->next_bridge)
 		return connector_status_connected;
 
 	if (!analogix_dp_detect_hpd(dp))
@@ -996,8 +979,6 @@ static void analogix_dp_bridge_atomic_pre_enable(struct drm_bridge *bridge,
 	/* Don't touch the panel if we're coming back from PSR */
 	if (old_crtc_state && old_crtc_state->self_refresh_active)
 		return;
-
-	drm_panel_prepare(dp->plat_data->panel);
 }
 
 static int analogix_dp_set_bridge(struct analogix_dp_device *dp)
@@ -1169,16 +1150,12 @@ static void analogix_dp_bridge_disable(struct drm_bridge *bridge)
 	if (dp->dpms_mode != DRM_MODE_DPMS_ON)
 		return;
 
-	drm_panel_disable(dp->plat_data->panel);
-
 	disable_irq(dp->irq);
 
 	analogix_dp_set_analog_power_down(dp, POWER_ALL, 1);
 
 	pm_runtime_put_sync(dp->dev);
 
-	drm_panel_unprepare(dp->plat_data->panel);
-
 	dp->fast_train_enable = false;
 	dp->psr_supported = false;
 	dp->dpms_mode = DRM_MODE_DPMS_OFF;
@@ -1253,7 +1230,6 @@ static const struct drm_bridge_funcs analogix_dp_bridge_funcs = {
 	.atomic_post_disable = analogix_dp_bridge_atomic_post_disable,
 	.atomic_check = analogix_dp_bridge_atomic_check,
 	.attach = analogix_dp_bridge_attach,
-	.get_modes = analogix_dp_bridge_get_modes,
 	.edid_read = analogix_dp_bridge_edid_read,
 	.detect = analogix_dp_bridge_detect,
 };
@@ -1499,17 +1475,22 @@ int analogix_dp_bind(struct analogix_dp_device *dp, struct drm_device *drm_dev)
 		return ret;
 	}
 
-	if (dp->plat_data->panel)
-		bridge->ops = DRM_BRIDGE_OP_MODES | DRM_BRIDGE_OP_DETECT;
-	else
-		bridge->ops = DRM_BRIDGE_OP_EDID | DRM_BRIDGE_OP_DETECT;
-
+	bridge->ops = DRM_BRIDGE_OP_EDID | DRM_BRIDGE_OP_DETECT;
 	bridge->of_node = dp->dev->of_node;
 	bridge->type = DRM_MODE_CONNECTOR_eDP;
 	ret = devm_drm_bridge_add(dp->dev, &dp->bridge);
 	if (ret)
 		goto err_unregister_aux;
 
+	if (dp->plat_data->panel) {
+		dp->plat_data->next_bridge = devm_drm_panel_bridge_add(dp->dev,
+								       dp->plat_data->panel);
+		if (IS_ERR(dp->plat_data->next_bridge)) {
+			ret = PTR_ERR(bridge);
+			goto err_unregister_aux;
+		}
+	}
+
 	ret = drm_bridge_attach(dp->encoder, bridge, NULL, DRM_BRIDGE_ATTACH_NO_CONNECTOR);
 	if (ret) {
 		DRM_ERROR("failed to create bridge (%d)\n", ret);
-- 
2.34.1

