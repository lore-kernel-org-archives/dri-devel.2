Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06CC60A2614
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 13:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=LTSFCUnf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C542D10F50C;
	Tue, 27 Oct 2026 13:28:36 +0000 (UTC)
Received: from mail-m81223.xmail.ntesmail.com (mail-m81223.xmail.ntesmail.com
 [156.224.81.223])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A82CD10F4EB
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 13:28:20 +0000 (UTC)
Received: from zyb-HP-ProDesk-680-G2-MT.. (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 528777a24;
 Tue, 27 Oct 2026 21:28:16 +0800 (GMT+08:00)
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
 Sandy Huang <hjc@rock-chips.com>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-rockchip@lists.infradead.org, Damon Ding <damon.ding@rock-chips.com>
Subject: [PATCH v5 02/18] drm/bridge: analogix_dp: Use bridge->next_bridge
 instead of plat_data field
Date: Tue, 27 Oct 2026 21:27:54 +0800
Message-Id: <20261027132810.1746118-3-damon.ding@rock-chips.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261027132810.1746118-1-damon.ding@rock-chips.com>
References: <20261027132810.1746118-1-damon.ding@rock-chips.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa17d8c1bc603a8kunm87c266213d56da
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZHxgfVklOGE5JGRhKQ09PGVYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSE
 pKQk1VSktLVUpCWQY+
DKIM-Signature: a=rsa-sha256;
 b=LTSFCUnfOrwXNfn6vfO42sY83HFDQb6l1MtQtkarQpCcFLCEhNwzRyk2f6aMOVsTDsNB8T6+R2CNw+Eo460CHJVR2K5kCQynPTgweudxyNs5jzaTvW4b7ODAfd2yL0bwN/hnlQxkgzatikPDyj814bqpHinOdUB/WrTfeNxTNfU=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=v9WUGyGZ+GPpo6rTg1cKFsNj7Hhgu8T0h9yJn2ON8FE=;
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

The DRM bridge core provides a standard next_bridge field in struct
drm_bridge for chaining downstream bridges. Use dp->bridge.next_bridge
consistently inside the analogix_dp driver and drop the separate
dp->plat_data->next_bridge field.

The next bridge is now resolved in analogix_dp_aux_done_probing(): a
display mode bridge is created for the legacy display-timings on the
Exynos platforms, while the remote endpoint bridge (panel or bridge)
is looked up via of_drm_get_bridge_by_endpoint() otherwise. The
obtained references are transferred to bridge->next_bridge, which the
bridge core automatically puts at bridge destroy time.

Also select DRM_OF_DISPLAY_MODE_BRIDGE for DRM_ANALOGIX_DP and drop
the now redundant select from the Exynos Kconfig, as the core now
creates the display mode bridge itself.

Suggested-by: Heiko Stuebner <heiko@sntech.de>
Link: https://lore.kernel.org/all/5609825.iZASKD2KPV@diego/
Tested-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Damon Ding <damon.ding@rock-chips.com>

---

Changes in v4:
- Add Tested-by tag.

Changes in v5:
- Move this patch to the front of the patch series, as the
  following patches rely on the dp->bridge.next_bridge field it
  introduces.
- Select DRM_OF_DISPLAY_MODE_BRIDGE for DRM_ANALOGIX_DP and drop the
  redundant select from the Exynos Kconfig, to fix the undefined
  reference build error. (kernel test robot)
- Check the presence of the display-timings node with
  of_get_child_by_name() instead of of_get_display_timings(), to
  avoid leaking the allocated display timings. (Sashiko)
---
 drivers/gpu/drm/bridge/analogix/Kconfig       |  1 +
 .../drm/bridge/analogix/analogix_dp_core.c    | 50 +++++++++++--------
 drivers/gpu/drm/exynos/Kconfig                |  1 -
 drivers/gpu/drm/exynos/exynos_dp.c            | 15 +-----
 include/drm/bridge/analogix_dp.h              |  1 -
 5 files changed, 30 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/Kconfig b/drivers/gpu/drm/bridge/analogix/Kconfig
index 5672d83cb4a1..293d7b443163 100644
--- a/drivers/gpu/drm/bridge/analogix/Kconfig
+++ b/drivers/gpu/drm/bridge/analogix/Kconfig
@@ -33,6 +33,7 @@ config DRM_ANALOGIX_DP
 	depends on DRM
 	depends on OF
 	select DRM_DISPLAY_DP_AUX_BUS
+	select DRM_OF_DISPLAY_MODE_BRIDGE
 
 config DRM_ANALOGIX_ANX7625
 	tristate "Analogix Anx7625 MIPI to DP interface support"
diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index 8bb4c48aa3b4..19f3cec5a691 100644
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
 
@@ -902,7 +905,7 @@ analogix_dp_bridge_detect(struct drm_bridge *bridge, struct drm_connector *conne
 	struct analogix_dp_device *dp = to_dp(bridge);
 	enum drm_connector_status status = connector_status_disconnected;
 
-	if (dp->plat_data->next_bridge)
+	if (dp->bridge.next_bridge)
 		return connector_status_connected;
 
 	if (!analogix_dp_detect_hpd(dp))
@@ -923,8 +926,8 @@ static int analogix_dp_bridge_attach(struct drm_bridge *bridge,
 		return -EINVAL;
 	}
 
-	if (dp->plat_data->next_bridge) {
-		ret = drm_bridge_attach(dp->encoder, dp->plat_data->next_bridge, bridge,
+	if (dp->bridge.next_bridge) {
+		ret = drm_bridge_attach(dp->encoder, dp->bridge.next_bridge, bridge,
 					DRM_BRIDGE_ATTACH_NO_CONNECTOR);
 		if (ret) {
 			dev_err(dp->dev, "failed to attach following panel or bridge (%d)\n", ret);
@@ -1638,37 +1641,40 @@ struct drm_dp_aux *analogix_dp_get_aux(struct analogix_dp_device *dp)
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
+	struct device_node *timings_np;
 	int port = plat_data->dev_type == EXYNOS_DP ? 0 : 1;
-	int ret;
+
+	if (plat_data->dev_type == EXYNOS_DP) {
+		timings_np = of_get_child_by_name(dp->dev->of_node, "display-timings");
+		of_node_put(timings_np);
+		if (timings_np) {
+			next_bridge = devm_drm_of_display_mode_bridge(dp->dev,
+								      dp->dev->of_node,
+								      DRM_MODE_CONNECTOR_eDP);
+			if (IS_ERR(next_bridge))
+				return PTR_ERR(next_bridge);
+			bridge->next_bridge = drm_bridge_get(next_bridge);
+
+			return component_add(dp->dev, plat_data->ops);
+		}
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
diff --git a/drivers/gpu/drm/exynos/Kconfig b/drivers/gpu/drm/exynos/Kconfig
index a59131ae122c..d63db6c36eb3 100644
--- a/drivers/gpu/drm/exynos/Kconfig
+++ b/drivers/gpu/drm/exynos/Kconfig
@@ -74,7 +74,6 @@ config DRM_EXYNOS_DP
 	select DRM_BRIDGE_CONNECTOR
 	select DRM_DISPLAY_DP_HELPER
 	default DRM_EXYNOS
-	select DRM_OF_DISPLAY_MODE_BRIDGE
 	select DRM_PANEL
 	help
 	  This enables support for DP device.
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
index e05ff4bd689c..7b5615ae0dc1 100644
--- a/include/drm/bridge/analogix_dp.h
+++ b/include/drm/bridge/analogix_dp.h
@@ -37,7 +37,6 @@ static inline bool analogix_dp_is_rockchip(enum analogix_dp_devtype type)
 
 struct analogix_dp_plat_data {
 	enum analogix_dp_devtype dev_type;
-	struct drm_bridge *next_bridge;
 	struct drm_encoder *encoder;
 	struct drm_connector *connector;
 	const struct component_ops *ops;
-- 
2.34.1

