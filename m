Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2322AC55ABE
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 18:05:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A361D10E75D;
	Mon,  3 Aug 2026 18:05:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="GafNpU8Q";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74B2610E741
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 18:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1785780304;
 bh=IGNH4yVISBHE4rmc5YtMF+b8znVZwlT7smSmILDU9AU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=GafNpU8Q6F8QC1jANUhszjUyBZziuUJal7vKyV31bT+e6jPW6Vp4/32KuHTIJSIcQ
 WbHH0aqYAk5ruvJb2GPRaYFErcNAUmVtqlSp7mMxvkQzFx4+xCmhk2i6v5U8NY7GqK
 x6FUyMZDnsWg5E1VXGYfQTuGK/QZu4ozEw9dHsZ1nTkVYKqs5nRtaOyZ94lWaB8BSI
 CdKGAU/OcHTGc4YuGX1xWSbJArxgUq+bW4Cjxk1oTZC20pxVIBHo78KdecsmGHO1AC
 A6jj8QQHSePCNseDueeZZhAzO6aJWkFrQHBghTTQSnTSd5dTPqTKR5jKaQn9OVNDrr
 u4rouBEPZXBFQ==
Received: from jupiter.universe (unknown [100.64.1.62])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519) (No client certificate requested)
 (Authenticated sender: sre)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 7313E17E121D;
 Mon, 03 Aug 2026 20:05:04 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
 id 768FD480055; Mon, 03 Aug 2026 20:05:03 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Mon, 03 Aug 2026 20:05:16 +0200
Subject: [PATCH v9 15/22] drm/bridge: synopsys: dw-dp: Add Runtime PM support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-synopsys-dw-dp-improvements-v9-15-2e6e46135312@collabora.com>
References: <20260803-synopsys-dw-dp-improvements-v9-0-2e6e46135312@collabora.com>
In-Reply-To: <20260803-synopsys-dw-dp-improvements-v9-0-2e6e46135312@collabora.com>
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
 Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=13502;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=IGNH4yVISBHE4rmc5YtMF+b8znVZwlT7smSmILDU9AU=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGpw2E8qGKKFENr8hDjjNLL5CvXBToCuStyEI
 uVjtvQSn2t77YkCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJqcNhPAAoJENju1/PI
 O/qaVUAP/1D4D5cWOdkcN12zoKBhAPj92wPQqpY4t4JUjbWkchObOlKlVrSW+A5Z24Lzdi45lCH
 BmsOv4Ntt3qi523Ovt+oDzRQWvdOp2y7ljvXR82K0en82OICpsTL2pbyezl5RkBmjIBIstw/BPe
 Ia53Spc75FobEa0LMxMKgQGL416EmkaKTkeSskB3S6TrINTSRt8mjU8OW2UobwBRTdF+j3T19WU
 hOuQiffgUpSpNAobHNysDjy6URFzxxr02DUx1zueGnaH8jDOvZb5AO+t6pmGb9+Kfe1Smvvb74U
 3mWtIetb7OCE3J2j3fEJ9ngIdtty1bMdLM5DxflOF69hNXH3d6pkvdeeeEfOLF5xRag9+62rLV6
 dPahQi6kI35B4TwEPBNYRM/iJdN6n2c9+ji6aWvzjMpk5QfWbzTWvgFEngPH8B6SFOJGudN7MhD
 5LuoZXzARQaoot/RqAXAgD3xwrZnqqmRS4D5MddneQV+DoREEEuBDXMYGUglVL07zZc6I8U5DTm
 pnMz1eT8sQpwSf1FdHuovh3V5BwM1iRfR3a3jqNaiLQVWgGQ24TPVHJolRyafNZR/StJP/yBZDh
 bnYutk2PboVBQqgFfDR3eQOgzMtrgQQ51IY/mm25B4reLGfm3+l08laLA7sPt57vb3dmWBrpyQd
 FScx3xy69ux/iwW0Mfqo04A==
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

Add runtime PM stubs to the Synopsys DesignWare DisplayPort bridge
driver. Support is not enabled automatically and must be hooked up
in the platform specific glue code.

The early bits of the dw_dp_probe function are split into a new
function called dw_dp_alloc, so that the platform driver can assign
it before running dw_dp_probe. This is necessary because the runtime
PM resume/suspend events land at the platform driver and must be
forwarded to the helper once runtime PM is enabled in the middle
of the probe function.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-dp.c | 233 ++++++++++++++++++++++++++------
 include/drm/bridge/dw_dp.h              |   7 +-
 2 files changed, 201 insertions(+), 39 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
index 7b8a9855ceae..501b28abeca2 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
@@ -329,6 +329,9 @@ struct dw_dp {
 	struct dw_dp_link link;
 	struct dw_dp_plat_data plat_data;
 	u8 pixel_mode;
+	bool usbc_mode;
+	bool usbc_hpd;
+	bool pm_active;
 
 	struct drm_bridge *next_bridge;
 
@@ -1468,6 +1471,11 @@ static ssize_t dw_dp_aux_transfer(struct drm_dp_aux *aux,
 	if (WARN_ON(msg->size > 16))
 		return -E2BIG;
 
+	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(dp->dev, pm);
+	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
+	if (ret)
+		return ret;
+
 	reinit_completion(&dp->complete);
 
 	switch (msg->request & ~DP_AUX_I2C_MOT) {
@@ -1675,6 +1683,13 @@ static void dw_dp_bridge_atomic_enable(struct drm_bridge *bridge,
 	struct drm_connector_state *conn_state;
 	int ret;
 
+	ret = pm_runtime_get_active(dp->dev, RPM_TRANSPARENT);
+	if (ret) {
+		dev_err(dp->dev, "runtime PM failure\n");
+		return;
+	}
+	dp->pm_active = true;
+
 	connector = drm_atomic_get_new_connector_for_encoder(state, bridge->encoder);
 	if (!connector) {
 		dev_err(dp->dev, "failed to get connector\n");
@@ -1725,10 +1740,15 @@ static void dw_dp_bridge_atomic_disable(struct drm_bridge *bridge,
 {
 	struct dw_dp *dp = bridge_to_dp(bridge);
 
+	if (!dp->pm_active)
+		return;
+	dp->pm_active = false;
+
 	dw_dp_video_disable(dp);
 	dw_dp_link_disable(dp);
 	bitmap_zero(dp->sdp_reg_bank, SDP_REG_BANK_SIZE);
 	dw_dp_reset(dp);
+	pm_runtime_put_autosuspend(dp->dev);
 }
 
 static bool dw_dp_hpd_detect_link(struct dw_dp *dp, struct drm_connector *connector)
@@ -1749,6 +1769,10 @@ static enum drm_connector_status dw_dp_bridge_detect(struct drm_bridge *bridge,
 {
 	struct dw_dp *dp = bridge_to_dp(bridge);
 
+	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(dp->dev, pm);
+	if (PM_RUNTIME_ACQUIRE_ERR(&pm))
+		return connector_status_disconnected;
+
 	if (!dw_dp_hpd_detect(dp))
 		return connector_status_disconnected;
 
@@ -1901,6 +1925,14 @@ static void dw_dp_bridge_oob_notify(struct drm_bridge *bridge,
 {
 	bool hpd_high = status != connector_status_disconnected;
 	struct dw_dp *dp = bridge_to_dp(bridge);
+	int ret;
+
+	dp->usbc_hpd = hpd_high;
+
+	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(dp->dev, pm);
+	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
+	if (ret)
+		return;
 
 	if (dp->plat_data.hpd_sw_cfg)
 		dp->plat_data.hpd_sw_cfg(dp->plat_data.data, hpd_high);
@@ -1960,6 +1992,11 @@ static void dw_dp_hpd_work(struct work_struct *work)
 	bool long_hpd;
 	int ret;
 
+	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(dp->dev, pm);
+	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
+	if (ret)
+		return;
+
 	mutex_lock(&dp->irq_lock);
 	long_hpd = dp->hotplug.long_hpd;
 	mutex_unlock(&dp->irq_lock);
@@ -2074,14 +2111,21 @@ int dw_dp_bind(struct dw_dp *dp, struct drm_encoder *encoder)
 	struct device *dev = dp->dev;
 	int ret;
 
-	ret = drm_bridge_attach(encoder, bridge, NULL, DRM_BRIDGE_ATTACH_NO_CONNECTOR);
+	ret = pm_runtime_get_active(dp->dev, RPM_TRANSPARENT);
 	if (ret)
-		return dev_err_probe(dev, ret, "Failed to attach bridge\n");
+		return ret;
+
+	ret = drm_bridge_attach(encoder, bridge, NULL, DRM_BRIDGE_ATTACH_NO_CONNECTOR);
+	if (ret) {
+		dev_err_probe(dev, ret, "Failed to attach bridge\n");
+		goto put_runtime_pm;
+	}
 
 	dp->next_bridge = of_drm_get_bridge_by_endpoint(dev->of_node, 1, 0);
 	if (IS_ERR(dp->next_bridge)) {
 		ret = PTR_ERR(dp->next_bridge);
-		return dev_err_probe(dev, ret, "failed to get follow-up bridge.\n");
+		dev_err_probe(dev, ret, "failed to get follow-up bridge.\n");
+		goto put_runtime_pm;
 	}
 
 	ret = drm_bridge_attach(encoder, dp->next_bridge, bridge,
@@ -2091,11 +2135,15 @@ int dw_dp_bind(struct dw_dp *dp, struct drm_encoder *encoder)
 		goto put_next_bridge;
 	}
 
-	if (dw_dp_is_routed_to_usb_c(encoder)) {
-		dev_dbg(dev, "USB-C mode\n");
+	dp->usbc_mode = dw_dp_is_routed_to_usb_c(encoder);
+
+	if (dp->plat_data.hpd_sw_sel)
+		dp->plat_data.hpd_sw_sel(dp->plat_data.data, dp->usbc_mode);
 
-		if (dp->plat_data.hpd_sw_sel)
-			dp->plat_data.hpd_sw_sel(dp->plat_data.data, 1);
+	/* USB-C has out-of-band hotplug detection, so device may runtime suspend */
+	if (dp->usbc_mode) {
+		dev_dbg(dev, "USB-C mode\n");
+		pm_runtime_put_autosuspend(dp->dev);
 	}
 
 	return 0;
@@ -2103,6 +2151,9 @@ int dw_dp_bind(struct dw_dp *dp, struct drm_encoder *encoder)
 put_next_bridge:
 	drm_bridge_put(dp->next_bridge);
 
+put_runtime_pm:
+	pm_runtime_put_autosuspend(dp->dev);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(dw_dp_bind);
@@ -2110,6 +2161,9 @@ EXPORT_SYMBOL_GPL(dw_dp_bind);
 void dw_dp_unbind(struct dw_dp *dp)
 {
 	drm_bridge_put(dp->next_bridge);
+
+	if (!dp->usbc_mode)
+		pm_runtime_put_autosuspend(dp->dev);
 }
 EXPORT_SYMBOL_GPL(dw_dp_unbind);
 
@@ -2120,76 +2174,125 @@ static void dw_dp_phy_exit(void *data)
 	phy_exit(dp->phy);
 }
 
-struct dw_dp *dw_dp_probe(struct platform_device *pdev, const struct dw_dp_plat_data *plat_data)
+static void dw_dp_manual_suspend(void *data)
+{
+	struct dw_dp *dp = data;
+
+	dw_dp_runtime_suspend(dp);
+}
+
+static void dw_dp_irq_free(void *data)
+{
+	struct dw_dp *dp = data;
+
+	/* ignore error as the interrupt needs to be free'd in any case */
+	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(dp->dev, pm);
+
+	free_irq(dp->irq, dp);
+	dp->irq = -1;
+}
+
+static int dw_dp_irq_request(struct dw_dp *dp, int irq)
+{
+	int ret;
+
+	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(dp->dev, pm);
+
+	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
+	if (ret)
+		return ret;
+
+	ret = request_threaded_irq(irq, NULL, dw_dp_irq,
+				   IRQF_ONESHOT, dev_name(dp->dev), dp);
+	if (ret)
+		return dev_err_probe(dp->dev, ret, "failed to request irq\n");
+
+	dp->irq = irq;
+
+	return devm_add_action_or_reset(dp->dev, dw_dp_irq_free, dp);
+}
+
+struct dw_dp *dw_dp_alloc(struct platform_device *pdev, const struct dw_dp_plat_data *plat_data)
 {
 	struct device *dev = &pdev->dev;
-	struct drm_bridge *bridge;
-	void __iomem *res;
 	struct dw_dp *dp;
-	int ret;
 
 	dp = devm_drm_bridge_alloc(dev, struct dw_dp, bridge, &dw_dp_bridge_funcs);
 	if (IS_ERR(dp))
 		return ERR_CAST(dp);
 
 	dp->dev = dev;
+	dp->irq = -1;
 	dp->pixel_mode = plat_data->pixel_mode;
 
 	dp->plat_data.hpd_sw_sel = plat_data->hpd_sw_sel;
 	dp->plat_data.hpd_sw_cfg = plat_data->hpd_sw_cfg;
 	dp->plat_data.data = plat_data->data;
 	dp->plat_data.max_link_rate = plat_data->max_link_rate;
+	dp->plat_data.autosuspend_delay = plat_data->autosuspend_delay;
 
 	init_completion(&dp->complete);
 
+	return dp;
+}
+EXPORT_SYMBOL_GPL(dw_dp_alloc);
+
+int dw_dp_probe(struct dw_dp *dp)
+{
+	struct device *dev = dp->dev;
+	struct platform_device *pdev = to_platform_device(dev);
+	struct drm_bridge *bridge;
+	void __iomem *res;
+	int irq, ret;
+
 	ret = devm_mutex_init(dev, &dp->irq_lock);
 	if (ret)
-		return ERR_PTR(ret);
+		return ret;
 
 	res = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(res))
-		return ERR_CAST(res);
+		return PTR_ERR(res);
 
 	dp->regmap = devm_regmap_init_mmio(dev, res, &dw_dp_regmap_config);
 	if (IS_ERR(dp->regmap)) {
 		dev_err_probe(dev, PTR_ERR(dp->regmap), "failed to create regmap\n");
-		return ERR_CAST(dp->regmap);
+		return PTR_ERR(dp->regmap);
 	}
 
 	dp->phy = devm_of_phy_get(dev, dev->of_node, NULL);
 	if (IS_ERR(dp->phy)) {
 		dev_err_probe(dev, PTR_ERR(dp->phy), "failed to get phy\n");
-		return ERR_CAST(dp->phy);
+		return PTR_ERR(dp->phy);
 	}
 
-	dp->apb_clk = devm_clk_get_enabled(dev, "apb");
+	dp->apb_clk = devm_clk_get(dev, "apb");
 	if (IS_ERR(dp->apb_clk)) {
 		dev_err_probe(dev, PTR_ERR(dp->apb_clk), "failed to get apb clock\n");
-		return ERR_CAST(dp->apb_clk);
+		return PTR_ERR(dp->apb_clk);
 	}
 
-	dp->aux_clk = devm_clk_get_enabled(dev, "aux");
+	dp->aux_clk = devm_clk_get(dev, "aux");
 	if (IS_ERR(dp->aux_clk)) {
 		dev_err_probe(dev, PTR_ERR(dp->aux_clk), "failed to get aux clock\n");
-		return ERR_CAST(dp->aux_clk);
+		return PTR_ERR(dp->aux_clk);
 	}
 
 	dp->i2s_clk = devm_clk_get_optional(dev, "i2s");
 	if (IS_ERR(dp->i2s_clk)) {
 		dev_err_probe(dev, PTR_ERR(dp->i2s_clk), "failed to get i2s clock\n");
-		return ERR_CAST(dp->i2s_clk);
+		return PTR_ERR(dp->i2s_clk);
 	}
 
 	dp->spdif_clk = devm_clk_get_optional(dev, "spdif");
 	if (IS_ERR(dp->spdif_clk)) {
 		dev_err_probe(dev, PTR_ERR(dp->spdif_clk), "failed to get spdif clock\n");
-		return ERR_CAST(dp->spdif_clk);
+		return PTR_ERR(dp->spdif_clk);
 	}
 
 	dp->hdcp_clk = devm_clk_get(dev, "hdcp");
 	if (IS_ERR(dp->hdcp_clk)) {
 		dev_err_probe(dev, PTR_ERR(dp->hdcp_clk), "failed to get hdcp clock\n");
-		return ERR_CAST(dp->hdcp_clk);
+		return PTR_ERR(dp->hdcp_clk);
 	}
 
 	/*
@@ -2199,20 +2302,34 @@ struct dw_dp *dw_dp_probe(struct platform_device *pdev, const struct dw_dp_plat_
 	dp->rstc = devm_reset_control_get(dev, NULL);
 	if (IS_ERR(dp->rstc)) {
 		dev_err_probe(dev, PTR_ERR(dp->rstc), "failed to get reset control\n");
-		return ERR_CAST(dp->rstc);
+		return PTR_ERR(dp->rstc);
 	}
 
-	dw_dp_init_hw(dp);
+	if (dp->plat_data.autosuspend_delay > 0) {
+		pm_runtime_use_autosuspend(dev);
+		pm_runtime_set_autosuspend_delay(dev, dp->plat_data.autosuspend_delay);
+		ret = devm_pm_runtime_enable(dev);
+		if (ret)
+			return ret;
+	}
+
+	if (!pm_runtime_enabled(dev)) {
+		dw_dp_runtime_resume(dp);
+
+		ret = devm_add_action_or_reset(dev, dw_dp_manual_suspend, dp);
+		if (ret)
+			return ret;
+	}
 
 	ret = phy_init(dp->phy);
 	if (ret) {
 		dev_err_probe(dev, ret, "phy init failed\n");
-		return ERR_PTR(ret);
+		return ret;
 	}
 
 	ret = devm_add_action_or_reset(dev, dw_dp_phy_exit, dp);
 	if (ret)
-		return ERR_PTR(ret);
+		return ret;
 
 	bridge = &dp->bridge;
 	bridge->of_node = dev->of_node;
@@ -2222,26 +2339,66 @@ struct dw_dp *dw_dp_probe(struct platform_device *pdev, const struct dw_dp_plat_
 
 	ret = devm_drm_bridge_add(dev, bridge);
 	if (ret)
-		return ERR_PTR(ret);
-
-	dp->irq = platform_get_irq(pdev, 0);
-	if (dp->irq < 0)
-		return ERR_PTR(dp->irq);
+		return ret;
 
 	ret = devm_work_autocancel(dev, &dp->hpd_work, dw_dp_hpd_work);
 	if (ret)
-		return ERR_PTR(ret);
+		return ret;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	return dw_dp_irq_request(dp, irq);
+}
+EXPORT_SYMBOL_GPL(dw_dp_probe);
+
+int dw_dp_runtime_suspend(struct dw_dp *dp)
+{
+	if (dp->irq >= 0)
+		disable_irq(dp->irq);
+
+	clk_disable_unprepare(dp->aux_clk);
+	clk_disable_unprepare(dp->apb_clk);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(dw_dp_runtime_suspend);
+
+int dw_dp_runtime_resume(struct dw_dp *dp)
+{
+	int ret;
+
+	ret = clk_prepare_enable(dp->apb_clk);
+	if (ret)
+		return ret;
 
-	ret = devm_request_threaded_irq(dev, dp->irq, NULL, dw_dp_irq,
-					IRQF_ONESHOT, dev_name(dev), dp);
+	ret = clk_prepare_enable(dp->aux_clk);
 	if (ret) {
-		dev_err_probe(dev, ret, "failed to request irq\n");
-		return ERR_PTR(ret);
+		clk_disable_unprepare(dp->apb_clk);
+		return ret;
 	}
 
-	return dp;
+	if (dp->plat_data.hpd_sw_sel)
+		dp->plat_data.hpd_sw_sel(dp->plat_data.data, dp->usbc_mode);
+	if (dp->plat_data.hpd_sw_cfg)
+		dp->plat_data.hpd_sw_cfg(dp->plat_data.data, dp->usbc_hpd);
+
+	dw_dp_init_hw(dp);
+
+	if (dp->irq >= 0) {
+		/*
+		 * HPD_HOT_PLUG bit is asserted only after the sink holds HPD
+		 * high for at least 100ms.
+		 */
+		msleep(110);
+
+		enable_irq(dp->irq);
+	}
+
+	return 0;
 }
-EXPORT_SYMBOL_GPL(dw_dp_probe);
+EXPORT_SYMBOL_GPL(dw_dp_runtime_resume);
 
 MODULE_AUTHOR("Andy Yan <andyshrk@163.com>");
 MODULE_DESCRIPTION("DW DP Core Library");
diff --git a/include/drm/bridge/dw_dp.h b/include/drm/bridge/dw_dp.h
index 79b2cdf0df99..1e23180b565e 100644
--- a/include/drm/bridge/dw_dp.h
+++ b/include/drm/bridge/dw_dp.h
@@ -18,6 +18,7 @@ enum {
 };
 
 struct dw_dp_plat_data {
+	int autosuspend_delay;
 	u32 max_link_rate;
 	u8 pixel_mode;
 	void *data;
@@ -28,5 +29,9 @@ struct dw_dp_plat_data {
 int dw_dp_bind(struct dw_dp *dp, struct drm_encoder *encoder);
 void dw_dp_unbind(struct dw_dp *dp);
 
-struct dw_dp *dw_dp_probe(struct platform_device *pdev, const struct dw_dp_plat_data *plat_data);
+struct dw_dp *dw_dp_alloc(struct platform_device *pdev, const struct dw_dp_plat_data *plat_data);
+int dw_dp_probe(struct dw_dp *dp);
+
+int dw_dp_runtime_suspend(struct dw_dp *dp);
+int dw_dp_runtime_resume(struct dw_dp *dp);
 #endif /* __DW_DP__ */

-- 
2.53.0

