Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D56E7CCF2D6
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 09:04:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF69F10E8BC;
	Mon, 19 Oct 2026 09:04:37 +0000 (UTC)
X-Greylist: delayed 302 seconds by postgrey-1.36 at gabe;
 Mon, 19 Oct 2026 09:04:19 UTC
Received: from mail-m1973194.qiye.163.com (mail-m1973194.qiye.163.com
 [220.197.31.94])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C502710E8BC
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 09:04:19 +0000 (UTC)
Received: from zyb-HP-ProDesk-680-G2-MT.. (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 5189b861e;
 Mon, 19 Oct 2026 16:59:14 +0800 (GMT+08:00)
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
Subject: [PATCH v4 11/14] drm/bridge: analogix_dp: Use bridge->next_bridge
 instead of plat_data field
Date: Mon, 19 Oct 2026 16:58:33 +0800
Message-Id: <20261019085836.3065008-12-damon.ding@rock-chips.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261019085836.3065008-1-damon.ding@rock-chips.com>
References: <20261019085836.3065008-1-damon.ding@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa15362eafb03a8kunm6ee755052eac64
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaSRoaVkNNGh8aSksYSBpLGVYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
 JDQkpVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
 b=WXzQAJes27wfwxftcunwf/Og3fbICg3DLFa4Inlr4bwgvWoOg7gzUvIq6fQjeY0gPlhi0mXrXSjVBGBbjqnWA8HRx+1lb/D0uXwjKY4cxTNUQ5VaxV1qnDNvTXDCYbki6WEU3kdHAGOhBM1RKmnqZ9YJqv72M+KMHGflOp5D3u4=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=QQ/t5/morG+FeG8K/3jeaH15CUfk6LVk7izlHOvpWZA=;
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

The DRM bridge core provides a standard next_bridge field in struct
drm_bridge for chaining downstream bridges. Use dp->bridge.next_bridge
consistently inside the analogix_dp driver and drop the separate
dp->plat_data->next_bridge field.

The next bridge is now resolved in analogix_dp_aux_done_probing(): for
Exynos platforms with legacy display-timings a display mode bridge is
created and used directly, skipping the endpoint lookup; otherwise the
remote endpoint bridge (panel or bridge) is looked up via
of_drm_get_bridge_by_endpoint().

The reference returned by of_drm_get_bridge_by_endpoint() is transferred
to bridge->next_bridge, and an explicit reference is taken for the
devm-managed display mode bridge; the bridge core automatically puts
bridge->next_bridge at bridge destroy time, pairing with both.

Suggested-by: Heiko Stuebner <heiko@sntech.de>
Link: https://lore.kernel.org/all/5609825.iZASKD2KPV@diego/
Tested-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Damon Ding <damon.ding@rock-chips.com>

---

Changes in v4:
- Add Tested-by tag.
---
 .../drm/bridge/analogix/analogix_dp_core.c    | 44 +++++++++----------
 drivers/gpu/drm/exynos/exynos_dp.c            | 15 +------
 include/drm/bridge/analogix_dp.h              |  1 -
 3 files changed, 23 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index 38857508d939..853b6a6a7fe4 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -21,6 +21,7 @@
 #include <linux/platform_device.h>
 
 #include <drm/bridge/analogix_dp.h>
+#include <drm/bridge/of-display-mode-bridge.h>
 #include <drm/display/drm_dp_aux_bus.h>
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
@@ -32,6 +33,8 @@
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
 
+#include <video/of_display_timing.h>
+
 #include "analogix_dp_core.h"
 #include "analogix_dp_reg.h"
 
@@ -909,7 +912,7 @@ analogix_dp_bridge_detect(struct drm_bridge *bridge, struct drm_connector *conne
 	struct analogix_dp_device *dp = to_dp(bridge);
 	enum drm_connector_status status = connector_status_disconnected;
 
-	if (dp->plat_data->next_bridge)
+	if (dp->bridge.next_bridge)
 		return connector_status_connected;
 
 	if (!analogix_dp_detect_hpd(dp))
@@ -930,8 +933,8 @@ static int analogix_dp_bridge_attach(struct drm_bridge *bridge,
 		return -EINVAL;
 	}
 
-	if (dp->plat_data->next_bridge) {
-		ret = drm_bridge_attach(dp->encoder, dp->plat_data->next_bridge, bridge,
+	if (dp->bridge.next_bridge) {
+		ret = drm_bridge_attach(dp->encoder, dp->bridge.next_bridge, bridge,
 					DRM_BRIDGE_ATTACH_NO_CONNECTOR);
 		if (ret) {
 			dev_err(dp->dev, "failed to attach following panel or bridge (%d)\n", ret);
@@ -1655,37 +1658,34 @@ struct drm_dp_aux *analogix_dp_get_aux(struct analogix_dp_device *dp)
 }
 EXPORT_SYMBOL_GPL(analogix_dp_get_aux);
 
-static void analogix_dp_put_bridge(void *data)
-{
-	drm_bridge_put(data);
-}
-
 static int analogix_dp_aux_done_probing(struct drm_dp_aux *aux)
 {
 	struct analogix_dp_device *dp = to_dp(aux);
 	struct analogix_dp_plat_data *plat_data = dp->plat_data;
+	struct drm_bridge *bridge = &dp->bridge, *next_bridge;
 	int port = plat_data->dev_type == EXYNOS_DP ? 0 : 1;
-	int ret;
+
+	if (plat_data->dev_type == EXYNOS_DP && of_get_display_timings(dp->dev->of_node)) {
+		next_bridge = devm_drm_of_display_mode_bridge(dp->dev, dp->dev->of_node,
+							      DRM_MODE_CONNECTOR_eDP);
+		if (IS_ERR(next_bridge))
+			return PTR_ERR(next_bridge);
+		bridge->next_bridge = drm_bridge_get(next_bridge);
+
+		return component_add(dp->dev, plat_data->ops);
+	}
 
 	/*
 	 * If of_drm_get_bridge_by_endpoint() returns -ENODEV, there may be no
 	 * valid panel or bridge nodes. The driver should go on for the
 	 * driver-free bridge or the DP mode applications.
 	 */
-	plat_data->next_bridge = of_drm_get_bridge_by_endpoint(dp->dev->of_node,
-							       port, 0);
-	if (IS_ERR(plat_data->next_bridge)) {
-		if (PTR_ERR(plat_data->next_bridge) == -ENODEV)
-			plat_data->next_bridge = NULL;
+	bridge->next_bridge = of_drm_get_bridge_by_endpoint(dp->dev->of_node, port, 0);
+	if (IS_ERR(bridge->next_bridge)) {
+		if (PTR_ERR(bridge->next_bridge) == -ENODEV)
+			bridge->next_bridge = NULL;
 		else
-			return PTR_ERR(plat_data->next_bridge);
-	}
-
-	if (plat_data->next_bridge) {
-		ret = devm_add_action_or_reset(dp->dev, analogix_dp_put_bridge,
-					       plat_data->next_bridge);
-		if (ret)
-			return ret;
+			return PTR_ERR(bridge->next_bridge);
 	}
 
 	return component_add(dp->dev, plat_data->ops);
diff --git a/drivers/gpu/drm/exynos/exynos_dp.c b/drivers/gpu/drm/exynos/exynos_dp.c
index 82c238829921..b1e130278ecc 100644
--- a/drivers/gpu/drm/exynos/exynos_dp.c
+++ b/drivers/gpu/drm/exynos/exynos_dp.c
@@ -14,12 +14,10 @@
 #include <linux/of_graph.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
-#include <video/of_display_timing.h>
 #include <video/of_videomode.h>
 #include <video/videomode.h>
 
 #include <drm/bridge/analogix_dp.h>
-#include <drm/bridge/of-display-mode-bridge.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_bridge.h>
 #include <drm/drm_bridge_connector.h>
@@ -161,14 +159,6 @@ static int exynos_dp_probe(struct platform_device *pdev)
 	 */
 	platform_set_drvdata(pdev, dp);
 
-	if (of_get_display_timings(dev->of_node)) {
-		dp->plat_data.next_bridge = devm_drm_of_display_mode_bridge(dp->dev,
-									dp->dev->of_node,
-									DRM_MODE_CONNECTOR_eDP);
-		if (IS_ERR(dp->plat_data.next_bridge))
-			return PTR_ERR(dp->plat_data.next_bridge);
-	}
-
 	/* The remote port can be either a panel or a bridge */
 	dp->plat_data.dev_type = EXYNOS_DP;
 	dp->plat_data.power_on = exynos_dp_poweron;
@@ -179,10 +169,7 @@ static int exynos_dp_probe(struct platform_device *pdev)
 	if (IS_ERR(dp->adp))
 		return PTR_ERR(dp->adp);
 
-	if (dp->plat_data.next_bridge)
-		return component_add(&pdev->dev, &exynos_dp_ops);
-	else
-		return analogix_dp_finish_probe(dp->adp);
+	return analogix_dp_finish_probe(dp->adp);
 }
 
 static void exynos_dp_remove(struct platform_device *pdev)
diff --git a/include/drm/bridge/analogix_dp.h b/include/drm/bridge/analogix_dp.h
index 6033137b651e..f152ca8c3218 100644
--- a/include/drm/bridge/analogix_dp.h
+++ b/include/drm/bridge/analogix_dp.h
@@ -35,7 +35,6 @@ static inline bool analogix_dp_is_rockchip(enum analogix_dp_devtype type)
 
 struct analogix_dp_plat_data {
 	enum analogix_dp_devtype dev_type;
-	struct drm_bridge *next_bridge;
 	struct drm_encoder *encoder;
 	struct drm_connector *connector;
 	const struct component_ops *ops;
-- 
2.34.1

