Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63192C624A4
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 08:14:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 896FC10F474;
	Thu,  3 Sep 2026 08:14:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="joy4Dvsu";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2416B10F475
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 08:14:00 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id EEE761A1977;
 Thu,  3 Sep 2026 08:13:58 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id C29D8602B8;
 Thu,  3 Sep 2026 08:13:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 9C81511C79F4D; 
 Thu,  3 Sep 2026 10:13:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1788423237; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=vORuoC/aTMjJ6OFUp5Ev/u9tXQDSUB5OaimxdHQ6l84=;
 b=joy4Dvsufc+gpstKlVcGUlbZ7jfGmNamOuM+emrEhKgzrJPhMDaLqyCn+Ogqs2QTZS9Wdp
 seXYV+ADfJwKruC2w2EWWb0iiPZ2uXOB2xIe5uczq44pq4OqJg8vrx+/ZQrVFEv5LWLGlp
 jtMQBc3G+d9fvBJUd2Lny/BDKoBnQUSieuebiLNTpG5adk84OGy4l5uU1T6jS1dxcSVZ9M
 Zazkw4h94G16M/GjxjKoutLD6iJr89UYmd+3YdPvo3zqbrlehVqAf+xy3ifdagLiLkYcJ4
 c1QL0g/j44p2yqSTVek1e8rrdYaOenhupqv/6NDlTlg0mt4432bWzypm8OQijg==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Thu, 03 Sep 2026 10:11:22 +0200
Subject: [PATCH RFC v2 19/19] drm/bridge: analogix_dp: don't create a
 panel_bridge
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-drm-bridge-every-panel-v2-19-2ab8ee24538e@bootlin.com>
References: <20260903-drm-bridge-every-panel-v2-0-2ab8ee24538e@bootlin.com>
In-Reply-To: <20260903-drm-bridge-every-panel-v2-0-2ab8ee24538e@bootlin.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Linus Walleij <linusw@kernel.org>, 
 Inki Dae <inki.dae@samsung.com>, Jagan Teki <jagan@amarulasolutions.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Albert Esteve <aesteve@redhat.com>, 
 Anusha Srivatsa <asrivats@redhat.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3
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

Now a panel_bridge is automatically created for every drm_panel, so this
call to devm_drm_panel_bridge_add() would lead to creating a second bridge
for the same panel.

Update and simplify the code by just getting a reference to the
already-existing bridge.

as of_drm_get_bridge_by_endpoint() returns a refcounted bridge, take care
of putting the bridge reference. This is not easily done in the remove path
due to the different probe paths of the user drivers, so add a devm action
to ensure the reference is put only when it was taken.

Assisted-by: opencode:deepseek-v4-flash-0731
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/gpu/drm/bridge/analogix/Kconfig            |  2 --
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 40 +++++++++++++---------
 drivers/gpu/drm/exynos/exynos_dp.c                 | 36 ++-----------------
 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c    |  9 -----
 include/drm/bridge/analogix_dp.h                   |  1 -
 5 files changed, 25 insertions(+), 63 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/Kconfig b/drivers/gpu/drm/bridge/analogix/Kconfig
index d07431788fcb..1e7726c76361 100644
--- a/drivers/gpu/drm/bridge/analogix/Kconfig
+++ b/drivers/gpu/drm/bridge/analogix/Kconfig
@@ -34,8 +34,6 @@ config DRM_ANALOGIX_DP
 	depends on DRM
 	depends on OF
 	select DRM_DISPLAY_DP_AUX_BUS
-	select DRM_PANEL
-	select DRM_PANEL_BRIDGE
 
 config DRM_ANALOGIX_ANX7625
 	tristate "Analogix Anx7625 MIPI to DP interface support"
diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index 566f1e5eb8cd..233bdaea8012 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -29,7 +29,6 @@
 #include <drm/drm_device.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_of.h>
-#include <drm/drm_panel.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
 
@@ -1491,15 +1490,6 @@ int analogix_dp_bind(struct analogix_dp_device *dp, struct drm_device *drm_dev)
 	if (ret)
 		goto err_unregister_aux;
 
-	if (dp->plat_data->panel) {
-		dp->plat_data->next_bridge = devm_drm_panel_bridge_add(dp->dev,
-								       dp->plat_data->panel);
-		if (IS_ERR(dp->plat_data->next_bridge)) {
-			ret = PTR_ERR(dp->plat_data->next_bridge);
-			goto err_unregister_aux;
-		}
-	}
-
 	ret = drm_bridge_attach(dp->encoder, bridge, NULL, DRM_BRIDGE_ATTACH_NO_CONNECTOR);
 	if (ret) {
 		DRM_ERROR("failed to create bridge (%d)\n", ret);
@@ -1571,6 +1561,11 @@ struct drm_dp_aux *analogix_dp_get_aux(struct analogix_dp_device *dp)
 }
 EXPORT_SYMBOL_GPL(analogix_dp_get_aux);
 
+static void analogix_dp_put_bridge(void *data)
+{
+	drm_bridge_put(data);
+}
+
 static int analogix_dp_aux_done_probing(struct drm_dp_aux *aux)
 {
 	struct analogix_dp_device *dp = to_dp(aux);
@@ -1579,14 +1574,25 @@ static int analogix_dp_aux_done_probing(struct drm_dp_aux *aux)
 	int ret;
 
 	/*
-	 * If drm_of_find_panel_or_bridge() returns -ENODEV, there may be no valid panel
-	 * or bridge nodes. The driver should go on for the driver-free bridge or the DP
-	 * mode applications.
+	 * If of_drm_get_bridge_by_endpoint() returns -ENODEV, there may be no
+	 * valid panel or bridge nodes. The driver should go on for the
+	 * driver-free bridge or the DP mode applications.
 	 */
-	ret = drm_of_find_panel_or_bridge(dp->dev->of_node, port, 0,
-					  &plat_data->panel, &plat_data->next_bridge);
-	if (ret && ret != -ENODEV)
-		return ret;
+	plat_data->next_bridge = of_drm_get_bridge_by_endpoint(dp->dev->of_node,
+							       port, 0);
+	if (IS_ERR(plat_data->next_bridge)) {
+		if (PTR_ERR(plat_data->next_bridge) == -ENODEV)
+			plat_data->next_bridge = NULL;
+		else
+			return PTR_ERR(plat_data->next_bridge);
+	}
+
+	if (plat_data->next_bridge) {
+		ret = devm_add_action_or_reset(dp->dev, analogix_dp_put_bridge,
+					       plat_data->next_bridge);
+		if (ret)
+			return ret;
+	}
 
 	return component_add(dp->dev, plat_data->ops);
 }
diff --git a/drivers/gpu/drm/exynos/exynos_dp.c b/drivers/gpu/drm/exynos/exynos_dp.c
index e1c9e2946b8a..82c238829921 100644
--- a/drivers/gpu/drm/exynos/exynos_dp.c
+++ b/drivers/gpu/drm/exynos/exynos_dp.c
@@ -26,7 +26,6 @@
 #include <drm/drm_crtc.h>
 #include <drm/drm_encoder.h>
 #include <drm/drm_of.h>
-#include <drm/drm_panel.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
 #include <drm/exynos_drm.h>
@@ -147,7 +146,6 @@ static const struct component_ops exynos_dp_ops = {
 static int exynos_dp_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct device_node *np;
 	struct exynos_dp_device *dp;
 
 	dp = devm_kzalloc(&pdev->dev, sizeof(struct exynos_dp_device),
@@ -163,18 +161,6 @@ static int exynos_dp_probe(struct platform_device *pdev)
 	 */
 	platform_set_drvdata(pdev, dp);
 
-	/* This is for the backward compatibility. */
-	np = of_parse_phandle(dev->of_node, "panel", 0);
-	if (np) {
-		dp->plat_data.panel = of_drm_find_panel(np);
-
-		of_node_put(np);
-		if (IS_ERR(dp->plat_data.panel))
-			return PTR_ERR(dp->plat_data.panel);
-
-		goto out;
-	}
-
 	if (of_get_display_timings(dev->of_node)) {
 		dp->plat_data.next_bridge = devm_drm_of_display_mode_bridge(dp->dev,
 									dp->dev->of_node,
@@ -189,19 +175,11 @@ static int exynos_dp_probe(struct platform_device *pdev)
 	dp->plat_data.power_off = exynos_dp_poweroff;
 	dp->plat_data.ops = &exynos_dp_ops;
 
-out:
 	dp->adp = analogix_dp_probe(dev, &dp->plat_data);
-	if (IS_ERR(dp->adp)) {
-		/*
-		 * The driver core does not invoke remove() for failed probes,
-		 * so release the probe-time panel reference here.
-		 */
-		if (dp->plat_data.panel)
-			drm_panel_put(dp->plat_data.panel);
+	if (IS_ERR(dp->adp))
 		return PTR_ERR(dp->adp);
-	}
 
-	if (dp->plat_data.panel || dp->plat_data.next_bridge)
+	if (dp->plat_data.next_bridge)
 		return component_add(&pdev->dev, &exynos_dp_ops);
 	else
 		return analogix_dp_finish_probe(dp->adp);
@@ -209,16 +187,6 @@ static int exynos_dp_probe(struct platform_device *pdev)
 
 static void exynos_dp_remove(struct platform_device *pdev)
 {
-	struct exynos_dp_device *dp = platform_get_drvdata(pdev);
-
-	/*
-	 * Release the probe-time reference from of_drm_find_panel(). If bind
-	 * ran, the panel_bridge holds a second reference that devm cleanup
-	 * will release when the bridge is destroyed after remove() returns.
-	 */
-	if (dp->plat_data.panel)
-		drm_panel_put(dp->plat_data.panel);
-
 	component_del(&pdev->dev, &exynos_dp_ops);
 }
 
diff --git a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
index 587e60232ec7..071d31aa5288 100644
--- a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
@@ -28,7 +28,6 @@
 #include <drm/drm_bridge_connector.h>
 #include <drm/bridge/analogix_dp.h>
 #include <drm/drm_of.h>
-#include <drm/drm_panel.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
 
@@ -488,14 +487,6 @@ static void rockchip_dp_remove(struct platform_device *pdev)
 {
 	struct rockchip_dp_device *dp = platform_get_drvdata(pdev);
 
-	/*
-	 * Release the probe-time reference from of_drm_find_panel(). If bind
-	 * ran, the panel_bridge holds a second reference that devm cleanup
-	 * will release when the bridge is destroyed after remove() returns.
-	 */
-	if (dp->plat_data.panel)
-		drm_panel_put(dp->plat_data.panel);
-
 	component_del(&pdev->dev, &rockchip_dp_component_ops);
 }
 
diff --git a/include/drm/bridge/analogix_dp.h b/include/drm/bridge/analogix_dp.h
index 0e0b87abee59..6033137b651e 100644
--- a/include/drm/bridge/analogix_dp.h
+++ b/include/drm/bridge/analogix_dp.h
@@ -35,7 +35,6 @@ static inline bool analogix_dp_is_rockchip(enum analogix_dp_devtype type)
 
 struct analogix_dp_plat_data {
 	enum analogix_dp_devtype dev_type;
-	struct drm_panel *panel;
 	struct drm_bridge *next_bridge;
 	struct drm_encoder *encoder;
 	struct drm_connector *connector;

-- 
2.55.0

