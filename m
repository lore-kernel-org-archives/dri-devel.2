Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6ADAC55ABF
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 00:39:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A0A010F06A;
	Thu,  6 Aug 2026 00:39:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="BeHnzgsM";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8651910E258
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 00:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1785976751;
 bh=PhI/zPp4Sbc++6BDdoGyNtD3qMDbtTLfNKGUXYpti9o=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=BeHnzgsMV+2Hyd/hFnrbv0GsclMSuddq6I1VC1dbarZoTl/irm7+IGc0D4XXhkreu
 56ASp+3N8lESQ6DamxILeTXj79GPz5eKFzUcCfq6FC0XHP+oQ3Aj7vOsdoVjYMVMWo
 KD0V8g9qt7MhkuTj4fnIR/Xw8njihpPX5PaWnBPcbsei2MaC2TNe58I+wPCHUB+plR
 pxYeU9iBpHiB4HW5veB8IsFM6PCh58PtNqpd/CjkV22Z3ZkRa0DQEPxnAz5ey80RWt
 BREINjB5F3O24dyw7okI3JHAIR87AhM86AfWXcccAKlUP1EBiRR5dV5yZzEuFz5nfy
 dKQi2jlb74iCA==
Received: from jupiter.universe (unknown [100.64.1.62])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519) (No client certificate requested)
 (Authenticated sender: sre)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 6037E17E0829;
 Thu, 06 Aug 2026 02:39:11 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
 id 9B425480052; Thu, 06 Aug 2026 02:39:10 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Thu, 06 Aug 2026 02:39:20 +0200
Subject: [PATCH v10 14/21] drm/bridge: synopsys: dw-dp: Add Runtime PM support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-synopsys-dw-dp-improvements-v10-14-d84a26c303d6@collabora.com>
References: <20260806-synopsys-dw-dp-improvements-v10-0-d84a26c303d6@collabora.com>
In-Reply-To: <20260806-synopsys-dw-dp-improvements-v10-0-d84a26c303d6@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=13579;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=PhI/zPp4Sbc++6BDdoGyNtD3qMDbtTLfNKGUXYpti9o=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGpz164fLWL5ddP21JHzfQOeDNGXI1D3OkPUk
 r9eFT1+8iJjv4kCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJqc9euAAoJENju1/PI
 O/qaVHkP/iVGTDXMmgqx/E8qiMln9QnbsrFhcxji4EWYSorK8RdmTl4CeYsflTJVMObdDZMv83J
 wdel3sKbOQR/YMFGqrznx8Nrh5Rn2QaFBCtGX7ofkyy9LKgA77NID3GvGHMfVbaumADi6JdjARC
 gSuh3agxOU4BqTD0xyqCIa006C93wEBvs9PyNObwh85dizdLdqvu6og/u2ntol9D4zsFKVvZVYC
 5EAlcSlxCbYXU7WKon2rQkSt4OrrnKqXA4Xd9TYYrIM9xLkQh9CzUSY+m6qup01d//TZeZZJY0L
 J7SuJpfp+YNFPe5+sVg5DRwovHZNNkI/Ckg15N2EqR6Lfl6BXTzH5IcW/AUmJvGyxTXL+WTm3Nr
 ihgI9tpJfEE0I46yzQg5OAStIKriaLITsCgoNyySne3JALTXAfiRH/gkmBWrYSbLW/znJXPK8/M
 CpAnU8mNb4LSx2zRq1q+CsYux9LN1YU075QpwReBC/VkshuUBVvBpkiEV9NcEvbg25lvs7wEVVX
 +SUoWg/+g119iv3Jhju0FjzmW/il1KDKqgAHT+75gbnDJW5oOgL89MFEzogDzaQoJX0A0DH143X
 Dt4mufzrLUpglvAoaKvKnpH5rhQJ/nYiesOEMszhqOzf60pZIGeQYsd1CKqL9N5FYQXr5T/oj4a
 uEYgn0Op5rgmhM6QxJyksoA==
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
 drivers/gpu/drm/bridge/synopsys/dw-dp.c   | 198 +++++++++++++++++++++++++-----
 drivers/gpu/drm/rockchip/dw_dp-rockchip.c |   8 +-
 include/drm/bridge/dw_dp.h                |   7 +-
 3 files changed, 181 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
index d0538e60ac5c..b8ba884d04ed 100644
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
@@ -1681,6 +1689,13 @@ static void dw_dp_bridge_atomic_enable(struct drm_bridge *bridge,
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
@@ -1731,10 +1746,15 @@ static void dw_dp_bridge_atomic_disable(struct drm_bridge *bridge,
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
@@ -1755,6 +1775,10 @@ static enum drm_connector_status dw_dp_bridge_detect(struct drm_bridge *bridge,
 {
 	struct dw_dp *dp = bridge_to_dp(bridge);
 
+	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(dp->dev, pm);
+	if (PM_RUNTIME_ACQUIRE_ERR(&pm))
+		return connector_status_disconnected;
+
 	if (!dw_dp_hpd_detect(dp))
 		return connector_status_disconnected;
 
@@ -1900,6 +1924,10 @@ static int dw_dp_bridge_attach(struct drm_bridge *bridge,
 	dp->aux.name = dev_name(dev);
 	dp->aux.transfer = dw_dp_aux_transfer;
 
+	ret = pm_runtime_get_active(dp->dev, RPM_TRANSPARENT);
+	if (ret)
+		return ret;
+
 	enable_irq(dp->irq);
 
 	ret = drm_dp_aux_register(&dp->aux);
@@ -1922,11 +1950,15 @@ static int dw_dp_bridge_attach(struct drm_bridge *bridge,
 		goto err_put_next_bridge;
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
@@ -1940,6 +1972,9 @@ static int dw_dp_bridge_attach(struct drm_bridge *bridge,
 err_disable_irq:
 	disable_irq(dp->irq);
 	cancel_work_sync(&dp->hpd_work);
+
+	pm_runtime_put_autosuspend(dp->dev);
+
 	return ret;
 }
 
@@ -1951,6 +1986,8 @@ static void dw_dp_bridge_detach(struct drm_bridge *bridge)
 	drm_dp_aux_unregister(&dp->aux);
 	disable_irq(dp->irq);
 	cancel_work_sync(&dp->hpd_work);
+	if (!dp->usbc_mode)
+		pm_runtime_put_autosuspend(dp->dev);
 }
 
 static void dw_dp_bridge_oob_notify(struct drm_bridge *bridge,
@@ -1959,6 +1996,14 @@ static void dw_dp_bridge_oob_notify(struct drm_bridge *bridge,
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
@@ -2018,6 +2063,11 @@ static void dw_dp_hpd_work(struct work_struct *work)
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
@@ -2128,13 +2178,24 @@ static void dw_dp_phy_exit(void *data)
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
+static void dw_dp_enable_irq(void *data)
+{
+	struct dw_dp *dp = data;
+
+	enable_irq(dp->irq);
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
@@ -2147,58 +2208,71 @@ struct dw_dp *dw_dp_probe(struct platform_device *pdev, const struct dw_dp_plat_
 	dp->plat_data.hpd_sw_cfg = plat_data->hpd_sw_cfg;
 	dp->plat_data.data = plat_data->data;
 	dp->plat_data.max_link_rate = plat_data->max_link_rate;
+	dp->plat_data.autosuspend_delay = plat_data->autosuspend_delay;
 
 	INIT_WORK(&dp->hpd_work, dw_dp_hpd_work);
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
+	int ret;
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
@@ -2208,31 +2282,57 @@ struct dw_dp *dw_dp_probe(struct platform_device *pdev, const struct dw_dp_plat_
 	dp->rstc = devm_reset_control_get(dev, NULL);
 	if (IS_ERR(dp->rstc)) {
 		dev_err_probe(dev, PTR_ERR(dp->rstc), "failed to get reset control\n");
-		return ERR_CAST(dp->rstc);
+		return PTR_ERR(dp->rstc);
 	}
 
 	dp->irq = platform_get_irq(pdev, 0);
 	if (dp->irq < 0)
-		return ERR_PTR(dp->irq);
+		return dp->irq;
 
 	ret = devm_request_threaded_irq(dev, dp->irq, NULL, dw_dp_irq,
 					IRQF_ONESHOT | IRQF_NO_AUTOEN, dev_name(dev), dp);
 	if (ret) {
 		dev_err_probe(dev, ret, "failed to request irq\n");
-		return ERR_PTR(ret);
+		return ret;
 	}
 
-	dw_dp_init_hw(dp);
+	/*
+	 * Disable IRQ a second time; this ensures the interrupt is only
+	 * enabled when the bridge is attached AND runtime PM is enabled.
+	 * Also register a devm action to restore the correct balance during
+	 * device removal.
+	 */
+	disable_irq(dp->irq);
+
+	ret = devm_add_action_or_reset(dev, dw_dp_enable_irq, dp);
+	if (ret)
+		return ret;
+
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
@@ -2240,13 +2340,53 @@ struct dw_dp *dw_dp_probe(struct platform_device *pdev, const struct dw_dp_plat_
 	bridge->type = DRM_MODE_CONNECTOR_DisplayPort;
 	bridge->ycbcr_420_allowed = true;
 
-	ret = devm_drm_bridge_add(dev, bridge);
+	return devm_drm_bridge_add(dev, bridge);
+}
+EXPORT_SYMBOL_GPL(dw_dp_probe);
+
+int dw_dp_runtime_suspend(struct dw_dp *dp)
+{
+	disable_irq(dp->irq);
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
 	if (ret)
-		return ERR_PTR(ret);
+		return ret;
 
-	return dp;
+	ret = clk_prepare_enable(dp->aux_clk);
+	if (ret) {
+		clk_disable_unprepare(dp->apb_clk);
+		return ret;
+	}
+
+	if (dp->plat_data.hpd_sw_sel)
+		dp->plat_data.hpd_sw_sel(dp->plat_data.data, dp->usbc_mode);
+	if (dp->plat_data.hpd_sw_cfg)
+		dp->plat_data.hpd_sw_cfg(dp->plat_data.data, dp->usbc_hpd);
+
+	dw_dp_init_hw(dp);
+
+	enable_irq(dp->irq);
+
+	/*
+	 * HPD_HOT_PLUG bit is asserted only after the sink holds HPD
+	 * high for at least 100ms.
+	 */
+	msleep(110);
+
+	return 0;
 }
-EXPORT_SYMBOL_GPL(dw_dp_probe);
+EXPORT_SYMBOL_GPL(dw_dp_runtime_resume);
 
 MODULE_AUTHOR("Andy Yan <andyshrk@163.com>");
 MODULE_DESCRIPTION("DW DP Core Library");
diff --git a/drivers/gpu/drm/rockchip/dw_dp-rockchip.c b/drivers/gpu/drm/rockchip/dw_dp-rockchip.c
index 9e49e7dbf420..ffcfb887d0d2 100644
--- a/drivers/gpu/drm/rockchip/dw_dp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_dp-rockchip.c
@@ -194,7 +194,7 @@ static int dw_dp_rockchip_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct rockchip_dw_dp *dp;
 	struct resource *res;
-	int id;
+	int id, ret;
 
 	plat_data_const = device_get_match_data(dev);
 	if (!plat_data_const)
@@ -237,10 +237,14 @@ static int dw_dp_rockchip_probe(struct platform_device *pdev)
 	plat_data->hpd_sw_cfg = dw_dp_rockchip_hpd_sw_cfg;
 	plat_data->data = dp;
 
-	dp->base = dw_dp_probe(pdev, plat_data);
+	dp->base = dw_dp_alloc(pdev, plat_data);
 	if (IS_ERR(dp->base))
 		return PTR_ERR(dp->base);
 
+	ret = dw_dp_probe(dp->base);
+	if (ret)
+		return ret;
+
 	return component_add(&pdev->dev, &dw_dp_rockchip_component_ops);
 }
 
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

