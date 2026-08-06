Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0E81C5AC9F
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 17:02:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AD2D10F23A;
	Thu,  6 Aug 2026 17:02:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="aKY0QhF+";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F4B610E34F
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 17:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1786035745;
 bh=0/orRffv/Cn+zND2DpEnzFi3gVTog7rNUSC9EJYlZpQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=aKY0QhF+/O95SXEDbKxHc+QJ3l4pk24GRxzpX8kVw9UuDONO4tre92mypeCIJVNDT
 dTJKNi7oWfSRTikL4Yy3sSb4HqDZa/G4anwDcwVNquWRvbkcDqnlRhwDMDVQ68cIqy
 z1ZwZDKrbAY2BBS/j91bucbm4mffzNesMuNbaT8lCEs4tcJoErtBNjNx0Pxv55mzc9
 em1WYJJTPTCimQLSDeZAinSxHXKszZGwh6lQoe3Gnp7ATvgbEXIOynUbggjzdsBbzY
 zFDTv5Nv4FBEbdtAL5c38kwUaZ7FSKN/Kh6AiaRGmKRyF/hikdNzoFjniPMIyigaty
 CexwCXK8qUHaw==
Received: from jupiter.universe (unknown [100.64.1.62])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: sre)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 42B6E17E051A;
 Thu, 06 Aug 2026 19:02:25 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
 id EE8F748002B; Thu, 06 Aug 2026 19:02:24 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Thu, 06 Aug 2026 19:02:08 +0200
Subject: [PATCH v11 02/21] drm/bridge: synopsys: dw-dp: Fix incorrect
 resource lifetimes in bind callback
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-synopsys-dw-dp-improvements-v11-2-0d508505f383@collabora.com>
References: <20260806-synopsys-dw-dp-improvements-v11-0-0d508505f383@collabora.com>
In-Reply-To: <20260806-synopsys-dw-dp-improvements-v11-0-0d508505f383@collabora.com>
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
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, 
 Damon Ding <damon.ding@rock-chips.com>, Dmitry Baryshkov <lumag@kernel.org>, 
 Alexey Charkov <alchark@flipper.net>, dri-devel@lists.freedesktop.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, kernel@collabora.com, 
 linux-arm-kernel@lists.infradead.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=9399;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=0/orRffv/Cn+zND2DpEnzFi3gVTog7rNUSC9EJYlZpQ=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGp0viC60fbYCR9t77uFVSo3QuoYBUqb0hm6a
 gezqtjGmU2pRIkCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJqdL4gAAoJENju1/PI
 O/qa0H0P/1x0KC/MohJK4IxjS5g2DUtUQINxQcItJg0nQjwlY7naLYMwSYO9qxY+KXaORmg29aB
 3XmOLk3PucCLsR652Tv6EnGW7lCGRK5vGEF5qw/IBrHtbykZHxJKwdspfmp3FIo9VnpFLdfdO9I
 TACfN2/SVAyVgN2oJI7+9pB+sJuyC9fBjp/IpOZN6H/yd9xGO/4UCf89x4SBvbU58iYkbGvLEgc
 Q/UCnfSHvIFtCeVv20gqw8VSU45dgMETqqJiz50gtcsFZUdsKVmiUsjeoudRAlsKOXimMRmeBms
 xFYN8n37X1PwWxxaOoG7C9BfA5ETTgWcwdQdkYCmpW41BZK2G1hrt7eWYmXbNDnD8Pw+oEQdlGr
 x6/Sa5OcJCb1MpnpKVH/VFy0nHNGtE1frrzyEE5GKwCanz7qVeWYGrnWX0DEfnV0BozqbprGCKb
 3uwS33QSP7lV2Cq0pvURW07z1ESs+Kx3qbC8Yctwy+DYePchKiyMk7m8q/fbn1eeuIQgOExDxER
 49+PHveAdaZpSyrcYgoboBqWiyhl2My/2cKMyljQfJSoq5q0XnbvbKQVh58xGhPpGvtN07HFyl8
 FFzxGgVoRGhaDQMUsGPA3ork/SS6q/SqR74+ebalGrbaTcOME5kPLgX8UTLp7aUQ3ydrdE358B/
 hkhmiK+GQAckeqgG4cFIixQ==
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
by introducing a new probe helper function and moving over the whole
bind function. This results in a fully functional DRM bridge once probe
succeeded. The only thing still happening when the component is bound
is the bridge attachment, which requires the encoder.

The interrupt is kept disabled while the bridge is detached to ensure no
spurious interrupts can arrive as the interrupt handler triggers a
worker, which accesses the DRM device.

Fixes: 86eecc3a9c2e ("drm/bridge: synopsys: Add DW DPTX Controller support library")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-dp.c   | 73 ++++++++++++++++---------------
 drivers/gpu/drm/rockchip/dw_dp-rockchip.c | 53 ++++++++++++----------
 include/drm/bridge/dw_dp.h                |  5 ++-
 3 files changed, 72 insertions(+), 59 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
index 60feb3d1e14b..d7945f7fe9f0 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
@@ -1827,16 +1827,22 @@ static int dw_dp_bridge_attach(struct drm_bridge *bridge,
 	dp->aux.transfer = dw_dp_aux_transfer;
 
 	ret = drm_dp_aux_register(&dp->aux);
-	if (ret)
+	if (ret) {
 		dev_err(dev, "Aux register failed: %d\n", ret);
+		return ret;
+	}
 
-	return ret;
+	enable_irq(dp->irq);
+
+	return 0;
 }
 
 static void dw_dp_bridge_detach(struct drm_bridge *bridge)
 {
 	struct dw_dp *dp = bridge_to_dp(bridge);
 
+	disable_irq(dp->irq);
+	cancel_work_sync(&dp->hpd_work);
 	drm_dp_aux_unregister(&dp->aux);
 }
 
@@ -1982,6 +1988,18 @@ static const struct regmap_config dw_dp_regmap_config = {
 	.rd_table = &dw_dp_readable_table,
 };
 
+int dw_dp_bind(struct dw_dp *dp, struct drm_encoder *encoder)
+{
+	return drm_bridge_attach(encoder, &dp->bridge, NULL, DRM_BRIDGE_ATTACH_NO_CONNECTOR);
+}
+EXPORT_SYMBOL_GPL(dw_dp_bind);
+
+void dw_dp_unbind(struct dw_dp *dp)
+{
+	/* nothing to do as bridge is detached automatically */
+}
+EXPORT_SYMBOL_GPL(dw_dp_unbind);
+
 static void dw_dp_phy_exit(void *data)
 {
 	struct dw_dp *dp = data;
@@ -1989,13 +2007,12 @@ static void dw_dp_phy_exit(void *data)
 	phy_exit(dp->phy);
 }
 
-struct dw_dp *dw_dp_bind(struct device *dev, struct drm_encoder *encoder,
-			 const struct dw_dp_plat_data *plat_data)
+struct dw_dp *dw_dp_probe(struct platform_device *pdev, const struct dw_dp_plat_data *plat_data)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct dw_dp *dp;
+	struct device *dev = &pdev->dev;
 	struct drm_bridge *bridge;
 	void __iomem *res;
+	struct dw_dp *dp;
 	int ret;
 
 	dp = devm_drm_bridge_alloc(dev, struct dw_dp, bridge, &dw_dp_bridge_funcs);
@@ -2004,9 +2021,8 @@ struct dw_dp *dw_dp_bind(struct device *dev, struct drm_encoder *encoder,
 
 	dp->dev = dev;
 	dp->pixel_mode = plat_data->pixel_mode;
-
 	dp->plat_data.max_link_rate = plat_data->max_link_rate;
-	bridge = &dp->bridge;
+
 	mutex_init(&dp->irq_lock);
 	INIT_WORK(&dp->hpd_work, dw_dp_hpd_work);
 	init_completion(&dp->complete);
@@ -2063,18 +2079,14 @@ struct dw_dp *dw_dp_bind(struct device *dev, struct drm_encoder *encoder,
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
+	dp->irq = platform_get_irq(pdev, 0);
+	if (dp->irq < 0)
+		return ERR_PTR(dp->irq);
 
-	ret = drm_bridge_attach(encoder, bridge, NULL, DRM_BRIDGE_ATTACH_NO_CONNECTOR);
+	ret = devm_request_threaded_irq(dev, dp->irq, NULL, dw_dp_irq,
+					IRQF_ONESHOT | IRQF_NO_AUTOEN, dev_name(dev), dp);
 	if (ret) {
-		dev_err_probe(dev, ret, "Failed to attach bridge\n");
+		dev_err_probe(dev, ret, "failed to request irq\n");
 		return ERR_PTR(ret);
 	}
 
@@ -2090,28 +2102,19 @@ struct dw_dp *dw_dp_bind(struct device *dev, struct drm_encoder *encoder,
 	if (ret)
 		return ERR_PTR(ret);
 
-	dp->irq = platform_get_irq(pdev, 0);
-	if (dp->irq < 0) {
-		ret = dp->irq;
-		return ERR_PTR(ret);
-	}
+	bridge = &dp->bridge;
+	bridge->of_node = dev->of_node;
+	bridge->ops = DRM_BRIDGE_OP_DETECT | DRM_BRIDGE_OP_EDID | DRM_BRIDGE_OP_HPD;
+	bridge->type = DRM_MODE_CONNECTOR_DisplayPort;
+	bridge->ycbcr_420_allowed = true;
 
-	ret = devm_request_threaded_irq(dev, dp->irq, NULL, dw_dp_irq,
-					IRQF_ONESHOT, dev_name(dev), dp);
-	if (ret) {
-		dev_err_probe(dev, ret, "failed to request irq\n");
+	ret = devm_drm_bridge_add(dev, bridge);
+	if (ret)
 		return ERR_PTR(ret);
-	}
 
 	return dp;
 }
-EXPORT_SYMBOL_GPL(dw_dp_bind);
-
-void dw_dp_unbind(struct dw_dp *dp)
-{
-	/* nothing to do */
-}
-EXPORT_SYMBOL_GPL(dw_dp_unbind);
+EXPORT_SYMBOL_GPL(dw_dp_probe);
 
 MODULE_AUTHOR("Andy Yan <andyshrk@163.com>");
 MODULE_DESCRIPTION("DW DP Core Library");
diff --git a/drivers/gpu/drm/rockchip/dw_dp-rockchip.c b/drivers/gpu/drm/rockchip/dw_dp-rockchip.c
index b23efb153c9e..38e8fe75718e 100644
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
+		return dev_err_probe(dev, ret, "failed to bind DW-DP bridge\n");
 
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

