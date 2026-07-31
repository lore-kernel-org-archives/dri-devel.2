Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD92AC55175
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 14:42:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24F4810F2AA;
	Fri, 31 Jul 2026 14:42:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="Hl2lEDCV";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 093A910F2B5
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 14:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1785508930;
 bh=Xrr78L9inY1ao+TGuIfSIsLe06DKCT3tq2pIYXzKzXw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=Hl2lEDCVQ9snBBUTnZdhZ87Tb8cmxDOm/fwmdWRpm0YXiZSXGdgrqzTW05K+qKEOp
 TbY1RLgRmqmjENKalGyrWXjITc1vWMvaRy/nq4mBZIS69PsEM41Y5n+zcwpJKoAC1D
 cb6wgg5PePxUMoWfo4rUAY3e3EfSgY/t2/BpnXpL1zlvbkxcmyOnLIhFDXJPmjhqFR
 fUsuSyZ3MBymovgBJXdrD0Gbs1zLuESQcqBquhxzIPhYSAuvDjrciSCNjDTRlLaud9
 fZ4Cm5WxJB3q9F5kSd9eH5XLo7Sdq2qhSx7vsGLH7rtZbiff9K4dG56aAvvJoHGK8w
 WMhTzWW12LNcA==
Received: from jupiter.universe (unknown [100.64.1.62])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519) (No client certificate requested)
 (Authenticated sender: sre)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id C31D917E0937;
 Fri, 31 Jul 2026 16:42:09 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
 id 1178D480052; Fri, 31 Jul 2026 16:42:09 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Fri, 31 Jul 2026 16:42:19 +0200
Subject: [PATCH v8 14/21] drm/bridge: synopsys: dw-dp: Add Runtime PM support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-synopsys-dw-dp-improvements-v8-14-ac1e6a75782f@collabora.com>
References: <20260731-synopsys-dw-dp-improvements-v8-0-ac1e6a75782f@collabora.com>
In-Reply-To: <20260731-synopsys-dw-dp-improvements-v8-0-ac1e6a75782f@collabora.com>
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
 bh=Xrr78L9inY1ao+TGuIfSIsLe06DKCT3tq2pIYXzKzXw=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGpstECBy/wZbx5hVJCBED9H97aYuiPHWfM4p
 kC827wzX/QhuIkCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJqbLRAAAoJENju1/PI
 O/qasQEP+wbQfOuxm49YDaTYqx720xQKVFFMol+5tfKsP1W6UyMd6BkOpcNwHKm+GGlqDjEuzxm
 IhrCVE6U9yHjb4dFvGjCCvZrGyUAzVQVvDrUFhaqzYNbVJeeKwwVJEhpSpHRtPX523Fd1tUUvhR
 lCsSqmUtqJixTl6eITfl0WtcmVBM2Ugwk4EYPbOm3YLgKYMOda/yyez59XX7qqcSpae7CDppTCe
 iz6ffjrtwQpTxSOvEB2UATPahFNcB8quqUADfWdkIb1nhtD4WOoQPRfuYRDNGna/jX9kk4hDw72
 EPPVHEs8IWgExanw8eL+soFvj9/WPnfDgoifE49AnVJ4GSDvO0guRQLvezdi8rOsudvuBJOKr01
 jCGr+msHdoIZ/XwgzHNMZb5uLW8FXWWtDIEfJ/AgRoHdcOYwAJPM/rZ/lXg9EnLwuWBoBExd+R4
 s5/TAt9OHy4p71nsY0Oj4m2q8SH2A7mAlrc0FJCJzIR2pbZ3e8KSlop03OG5x1Mj1H072A4jq8m
 xf1Rocgm6skqgjyur07V1cxI0bVqFdFZJ5WUgugeBrWEkMDE4ygEEqGXcuInRMw6oAm8kcdV8G5
 5n35hz9JnN4bGgkxI+p1Qrauc+dFir/VD7O6zRuGsyhYoQXZuPFZfc0kPy2LI0JZf0DZRBNepfO
 0Nd9J5y9SHzWCjNusXL0dYQ==
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
index b21c2016dbd2..c24a5436e8fe 100644
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
@@ -1666,6 +1674,13 @@ static void dw_dp_bridge_atomic_enable(struct drm_bridge *bridge,
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
@@ -1716,10 +1731,15 @@ static void dw_dp_bridge_atomic_disable(struct drm_bridge *bridge,
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
@@ -1740,6 +1760,10 @@ static enum drm_connector_status dw_dp_bridge_detect(struct drm_bridge *bridge,
 {
 	struct dw_dp *dp = bridge_to_dp(bridge);
 
+	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(dp->dev, pm);
+	if (PM_RUNTIME_ACQUIRE_ERR(&pm))
+		return connector_status_disconnected;
+
 	if (!dw_dp_hpd_detect(dp))
 		return connector_status_disconnected;
 
@@ -1892,6 +1916,14 @@ static void dw_dp_bridge_oob_notify(struct drm_bridge *bridge,
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
@@ -1951,6 +1983,11 @@ static void dw_dp_hpd_work(struct work_struct *work)
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
@@ -2062,14 +2099,21 @@ int dw_dp_bind(struct dw_dp *dp, struct drm_encoder *encoder)
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
@@ -2079,11 +2123,15 @@ int dw_dp_bind(struct dw_dp *dp, struct drm_encoder *encoder)
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
@@ -2091,6 +2139,9 @@ int dw_dp_bind(struct dw_dp *dp, struct drm_encoder *encoder)
 put_next_bridge:
 	drm_bridge_put(dp->next_bridge);
 
+put_runtime_pm:
+	pm_runtime_put_autosuspend(dp->dev);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(dw_dp_bind);
@@ -2098,6 +2149,9 @@ EXPORT_SYMBOL_GPL(dw_dp_bind);
 void dw_dp_unbind(struct dw_dp *dp)
 {
 	drm_bridge_put(dp->next_bridge);
+
+	if (!dp->usbc_mode)
+		pm_runtime_put_autosuspend(dp->dev);
 }
 EXPORT_SYMBOL_GPL(dw_dp_unbind);
 
@@ -2108,76 +2162,125 @@ static void dw_dp_phy_exit(void *data)
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
@@ -2187,20 +2290,34 @@ struct dw_dp *dw_dp_probe(struct platform_device *pdev, const struct dw_dp_plat_
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
@@ -2210,26 +2327,66 @@ struct dw_dp *dw_dp_probe(struct platform_device *pdev, const struct dw_dp_plat_
 
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

