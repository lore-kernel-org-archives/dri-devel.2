Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F528C4452B
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 17:52:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6981010E39E;
	Tue, 21 Jul 2026 17:52:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="Pt+YCKQD";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9162810E39E
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 17:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1784656358;
 bh=yqpVLOEejS7yByY/WZUm/x4WfYEFQ2/hVy7t4pQcRKc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=Pt+YCKQDFuazV2YP/mISTPWvqodVtSR3syjtxb/5rmN7rRM1FUQ9M2SBYYP8meOgr
 bP5cT8PcAdwiHBpHBCT/eX1G9FAZm81qwKD1QKYMkxnwtFJHy6GcaXCidZ22BDMNGd
 RWb3byBDvmEq7Z0tedti66OZxEmScA630rtyCydLUJ7m6FH7wsv1joMFB94n4GURSM
 /ZtNDwTvmymMXOa6mxS0ZWJlCj5+3jK0YOhQWwN0Ohm0w1JxtsycgrUl0faRZi5awB
 dATMXfezosn8g6/KEotYjHs52PNn9/A/pv6hEKc9sFLOhYLu6OvYIf3ykGCANm3UXQ
 uPkNNfkCEX31g==
Received: from jupiter.universe (unknown [100.64.1.62])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: sre)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id E0BEC17E0909;
 Tue, 21 Jul 2026 19:52:37 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
 id 95960480028; Tue, 21 Jul 2026 19:52:37 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Tue, 21 Jul 2026 19:52:31 +0200
Subject: [PATCH v4 01/10] drm/bridge: synopsys: dw-dp: Fix incorrect
 resource lifetimes in bind callback
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-synopsys-dw-dp-improvements-v4-1-f0f4a4ede712@collabora.com>
References: <20260721-synopsys-dw-dp-improvements-v4-0-f0f4a4ede712@collabora.com>
In-Reply-To: <20260721-synopsys-dw-dp-improvements-v4-0-f0f4a4ede712@collabora.com>
To: Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, 
 Damon Ding <damon.ding@rock-chips.com>, Dmitry Baryshkov <lumag@kernel.org>, 
 Alexey Charkov <alchark@flipper.net>, dri-devel@lists.freedesktop.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, kernel@collabora.com, 
 linux-arm-kernel@lists.infradead.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=9360;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=yqpVLOEejS7yByY/WZUm/x4WfYEFQ2/hVy7t4pQcRKc=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGpfseU9XxfDfQ/wHCKHTMPVKMxmMETcyld1v
 ljF5/WOYqa8Q4kCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJqX7HlAAoJENju1/PI
 O/qaIcQQAJHNIo3E8159QSmospxKXv9RinRzXEipAwiGBFbT47n3jb/k38wLBV3h7lrkH55yMJV
 l2VeH7f/680/NXZiI9cmCeedvQeEShND8FxY9wY/q8uoimCLvYvENXw3BLyBrXhJKDrLmVmwPIb
 ZDHljT2l4Q00vz7diRzJGw6DBzK8Gm9rLw6ROkx/yQhB03Y1I5KBfW5Gm3EC8zc2QLfzp4BdETe
 zqZMSfUbTdtLnA06W54Y3WimHbjYKi5qDl4E0Mths/U8XQaThhG6hN4u/6mDFg3A8boRTKmhC7B
 Gc7ebmIcYHclEQlamMsGteqFUOUR3NZx+/Q0CAE8dfeLLdiV6AYMrWtle3EnsEluB3hHChv3F6y
 TQe1U3qNc4Hox0jYZ3Y09EKpVkmbMo6IW8r3TxQkTXGfyErpbQIYJuW4/o0xR1Vu0+urrdKMFeC
 BZObxSAGXITDDaqf/tVFIdQU2AIWkHteklc0bXRFU7J08XNG4fUtm1zIv+k4wmnUOEnZwdEydJR
 3pkGlmuGD/TkmaJXOe8Vof50UkZpi7tIIwSy8ZlnX8CMAxCfRi1xXcKvuOxaNgPqjugtcSnI4pJ
 XiZePN5DrPWR5WkO08NreczSBsnrAK5U0cikw+TpVH/hjrIjCyzcByngsNkeOrDPzXOEJpuCtJk
 ULttGCfo1LPkLdBedP5AnAA==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A
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

Currently the Synopsys DesignWare DP controller driver's bind function
requests lots of resources using device managed functions. These are
free'd on driver removal instead of at unbind time. Fix this discrepancy
by introducing a new probe helper function and moving over most of the
early resource acquisitions.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-dp.c   | 128 +++++++++++++++---------------
 drivers/gpu/drm/rockchip/dw_dp-rockchip.c |  53 ++++++++-----
 include/drm/bridge/dw_dp.h                |   5 +-
 3 files changed, 99 insertions(+), 87 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
index 3445c82e6f50..368e1f85e625 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
@@ -1954,20 +1954,72 @@ static const struct regmap_config dw_dp_regmap_config = {
 	.rd_table = &dw_dp_readable_table,
 };
 
-static void dw_dp_phy_exit(void *data)
+int dw_dp_bind(struct dw_dp *dp, struct drm_encoder *encoder)
 {
-	struct dw_dp *dp = data;
+	struct device *dev = dp->dev;
+	struct drm_bridge *bridge;
+	int ret;
+
+	bridge = &dp->bridge;
+	bridge->of_node = dev->of_node;
+	bridge->ops = DRM_BRIDGE_OP_DETECT | DRM_BRIDGE_OP_EDID | DRM_BRIDGE_OP_HPD;
+	bridge->type = DRM_MODE_CONNECTOR_DisplayPort;
+	bridge->ycbcr_420_allowed = true;
+
+	drm_bridge_add(bridge);
+
+	dp->aux.dev = dev;
+	dp->aux.drm_dev = encoder->dev;
+	dp->aux.name = dev_name(dev);
+	dp->aux.transfer = dw_dp_aux_transfer;
+	ret = drm_dp_aux_register(&dp->aux);
+	if (ret) {
+		dev_err_probe(dev, ret, "Aux register failed\n");
+		goto unregister_bridge;
+	}
+
+	ret = drm_bridge_attach(encoder, bridge, NULL, DRM_BRIDGE_ATTACH_NO_CONNECTOR);
+	if (ret) {
+		dev_err_probe(dev, ret, "Failed to attach bridge\n");
+		goto unregister_aux;
+	}
+
+	dw_dp_init_hw(dp);
 
+	ret = phy_init(dp->phy);
+	if (ret) {
+		dev_err_probe(dev, ret, "phy init failed\n");
+		goto unregister_aux;
+	}
+
+	enable_irq(dp->irq);
+
+	return 0;
+
+unregister_aux:
+	drm_dp_aux_unregister(&dp->aux);
+
+unregister_bridge:
+	drm_bridge_remove(bridge);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(dw_dp_bind);
+
+void dw_dp_unbind(struct dw_dp *dp)
+{
+	disable_irq(dp->irq);
 	phy_exit(dp->phy);
+	drm_dp_aux_unregister(&dp->aux);
+	drm_bridge_remove(&dp->bridge);
 }
+EXPORT_SYMBOL_GPL(dw_dp_unbind);
 
-struct dw_dp *dw_dp_bind(struct device *dev, struct drm_encoder *encoder,
-			 const struct dw_dp_plat_data *plat_data)
+struct dw_dp *dw_dp_probe(struct platform_device *pdev, const struct dw_dp_plat_data *plat_data)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct dw_dp *dp;
-	struct drm_bridge *bridge;
+	struct device *dev = &pdev->dev;
 	void __iomem *res;
+	struct dw_dp *dp;
 	int ret;
 
 	dp = devm_drm_bridge_alloc(dev, struct dw_dp, bridge, &dw_dp_bridge_funcs);
@@ -1976,9 +2028,8 @@ struct dw_dp *dw_dp_bind(struct device *dev, struct drm_encoder *encoder,
 
 	dp->dev = dev;
 	dp->pixel_mode = plat_data->pixel_mode;
-
 	dp->plat_data.max_link_rate = plat_data->max_link_rate;
-	bridge = &dp->bridge;
+
 	mutex_init(&dp->irq_lock);
 	INIT_WORK(&dp->hpd_work, dw_dp_hpd_work);
 	init_completion(&dp->complete);
@@ -2035,69 +2086,20 @@ struct dw_dp *dw_dp_bind(struct device *dev, struct drm_encoder *encoder,
 		return ERR_CAST(dp->rstc);
 	}
 
-	bridge->of_node = dev->of_node;
-	bridge->ops = DRM_BRIDGE_OP_DETECT | DRM_BRIDGE_OP_EDID | DRM_BRIDGE_OP_HPD;
-	bridge->type = DRM_MODE_CONNECTOR_DisplayPort;
-	bridge->ycbcr_420_allowed = true;
-
-	ret = devm_drm_bridge_add(dev, bridge);
-	if (ret)
-		return ERR_PTR(ret);
-
-	dp->aux.dev = dev;
-	dp->aux.drm_dev = encoder->dev;
-	dp->aux.name = dev_name(dev);
-	dp->aux.transfer = dw_dp_aux_transfer;
-	ret = drm_dp_aux_register(&dp->aux);
-	if (ret) {
-		dev_err_probe(dev, ret, "Aux register failed\n");
-		return ERR_PTR(ret);
-	}
-
-	ret = drm_bridge_attach(encoder, bridge, NULL, DRM_BRIDGE_ATTACH_NO_CONNECTOR);
-	if (ret) {
-		dev_err_probe(dev, ret, "Failed to attach bridge\n");
-		goto unregister_aux;
-	}
-
-	dw_dp_init_hw(dp);
-
-	ret = phy_init(dp->phy);
-	if (ret) {
-		dev_err_probe(dev, ret, "phy init failed\n");
-		goto unregister_aux;
-	}
-
-	ret = devm_add_action_or_reset(dev, dw_dp_phy_exit, dp);
-	if (ret)
-		goto unregister_aux;
-
 	dp->irq = platform_get_irq(pdev, 0);
-	if (dp->irq < 0) {
-		ret = dp->irq;
-		goto unregister_aux;
-	}
+	if (dp->irq < 0)
+		return ERR_PTR(dp->irq);
 
 	ret = devm_request_threaded_irq(dev, dp->irq, NULL, dw_dp_irq,
-					IRQF_ONESHOT, dev_name(dev), dp);
+					IRQF_ONESHOT | IRQF_NO_AUTOEN, dev_name(dev), dp);
 	if (ret) {
 		dev_err_probe(dev, ret, "failed to request irq\n");
-		goto unregister_aux;
+		return ERR_PTR(ret);
 	}
 
 	return dp;
-
-unregister_aux:
-	drm_dp_aux_unregister(&dp->aux);
-	return ERR_PTR(ret);
 }
-EXPORT_SYMBOL_GPL(dw_dp_bind);
-
-void dw_dp_unbind(struct dw_dp *dp)
-{
-	drm_dp_aux_unregister(&dp->aux);
-}
-EXPORT_SYMBOL_GPL(dw_dp_unbind);
+EXPORT_SYMBOL_GPL(dw_dp_probe);
 
 MODULE_AUTHOR("Andy Yan <andyshrk@163.com>");
 MODULE_DESCRIPTION("DW DP Core Library");
diff --git a/drivers/gpu/drm/rockchip/dw_dp-rockchip.c b/drivers/gpu/drm/rockchip/dw_dp-rockchip.c
index b23efb153c9e..005938dc66c9 100644
--- a/drivers/gpu/drm/rockchip/dw_dp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_dp-rockchip.c
@@ -26,7 +26,7 @@
 struct rockchip_dw_dp {
 	struct dw_dp *base;
 	struct device *dev;
-	struct rockchip_encoder encoder;
+	struct rockchip_encoder *encoder;
 };
 
 static int dw_dp_encoder_atomic_check(struct drm_encoder *encoder,
@@ -73,37 +73,28 @@ static const struct drm_encoder_helper_funcs dw_dp_encoder_helper_funcs = {
 
 static int dw_dp_rockchip_bind(struct device *dev, struct device *master, void *data)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	const struct dw_dp_plat_data *plat_data;
+	struct rockchip_dw_dp *dp = dev_get_drvdata(dev);
 	struct drm_device *drm_dev = data;
-	struct rockchip_dw_dp *dp;
 	struct drm_encoder *encoder;
 	struct drm_connector *connector;
 	int ret;
 
-	dp = drmm_kzalloc(drm_dev, sizeof(*dp), GFP_KERNEL);
-	if (!dp)
+	dp->encoder = drmm_kzalloc(drm_dev, sizeof(*dp->encoder), GFP_KERNEL);
+	if (!dp->encoder)
 		return -ENOMEM;
 
-	dp->dev = dev;
-	platform_set_drvdata(pdev, dp);
-
-	plat_data = of_device_get_match_data(dev);
-	if (!plat_data)
-		return -ENODEV;
-
-	encoder = &dp->encoder.encoder;
+	encoder = &dp->encoder->encoder;
 	encoder->possible_crtcs = drm_of_find_possible_crtcs(drm_dev, dev->of_node);
-	rockchip_drm_encoder_set_crtc_endpoint_id(&dp->encoder, dev->of_node, 0, 0);
+	rockchip_drm_encoder_set_crtc_endpoint_id(dp->encoder, dev->of_node, 0, 0);
 
 	ret = drmm_encoder_init(drm_dev, encoder, NULL, DRM_MODE_ENCODER_TMDS, NULL);
 	if (ret)
 		return ret;
 	drm_encoder_helper_add(encoder, &dw_dp_encoder_helper_funcs);
 
-	dp->base = dw_dp_bind(dev, encoder, plat_data);
-	if (IS_ERR(dp->base))
-		return PTR_ERR(dp->base);
+	ret = dw_dp_bind(dp->base, encoder);
+	if (ret)
+		return ret;
 
 	connector = drm_bridge_connector_init(drm_dev, encoder);
 	if (IS_ERR(connector)) {
@@ -128,12 +119,30 @@ static const struct component_ops dw_dp_rockchip_component_ops = {
 	.unbind = dw_dp_rockchip_unbind,
 };
 
-static int dw_dp_probe(struct platform_device *pdev)
+static int dw_dp_rockchip_probe(struct platform_device *pdev)
 {
+	const struct dw_dp_plat_data *plat_data;
+	struct device *dev = &pdev->dev;
+	struct rockchip_dw_dp *dp;
+
+	plat_data = of_device_get_match_data(dev);
+	if (!plat_data)
+		return -ENODEV;
+
+	dp = devm_kzalloc(dev, sizeof(*dp), GFP_KERNEL);
+	if (!dp)
+		return -ENOMEM;
+	platform_set_drvdata(pdev, dp);
+	dp->dev = dev;
+
+	dp->base = dw_dp_probe(pdev, plat_data);
+	if (IS_ERR(dp->base))
+		return PTR_ERR(dp->base);
+
 	return component_add(&pdev->dev, &dw_dp_rockchip_component_ops);
 }
 
-static void dw_dp_remove(struct platform_device *pdev)
+static void dw_dp_rockchip_remove(struct platform_device *pdev)
 {
 	component_del(&pdev->dev, &dw_dp_rockchip_component_ops);
 }
@@ -161,8 +170,8 @@ static const struct of_device_id dw_dp_of_match[] = {
 MODULE_DEVICE_TABLE(of, dw_dp_of_match);
 
 struct platform_driver dw_dp_driver = {
-	.probe	= dw_dp_probe,
-	.remove = dw_dp_remove,
+	.probe	= dw_dp_rockchip_probe,
+	.remove = dw_dp_rockchip_remove,
 	.driver = {
 		.name = "dw-dp",
 		.of_match_table = dw_dp_of_match,
diff --git a/include/drm/bridge/dw_dp.h b/include/drm/bridge/dw_dp.h
index 22105c3e8e4d..a82412a9e769 100644
--- a/include/drm/bridge/dw_dp.h
+++ b/include/drm/bridge/dw_dp.h
@@ -22,7 +22,8 @@ struct dw_dp_plat_data {
 	u8 pixel_mode;
 };
 
-struct dw_dp *dw_dp_bind(struct device *dev, struct drm_encoder *encoder,
-			 const struct dw_dp_plat_data *plat_data);
+int dw_dp_bind(struct dw_dp *dp, struct drm_encoder *encoder);
 void dw_dp_unbind(struct dw_dp *dp);
+
+struct dw_dp *dw_dp_probe(struct platform_device *pdev, const struct dw_dp_plat_data *plat_data);
 #endif /* __DW_DP__ */

-- 
2.53.0

