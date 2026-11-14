Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5A8606A335
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 05:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=SsABjCMJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F194110ECD4;
	Sat, 14 Nov 2026 05:01:18 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8C1A10E761
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 05:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1794632457;
 bh=FgOxOHxuGTimQajJvE6qfgRhaoxxWx9LRFhs3ec+Zns=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=SsABjCMJM0JZ0yQX/tlYfgYkFVNlRoT/pbOQ7DgzOayeQ3KrCFLlGlLaGhxq3PexF
 TKA++ckDyyNVbDPX0qAB7FHvF8JO7DzlaZh7umd/B3xauzocG5ZFhCAzYg7h+aDVHb
 fWRw+EASZZJRF9vmYAgRajf0B7uRcLEFY5xeEhAvzTp2YjlETb84fxWzkTo9XSezBz
 VYN72Evhg8FAQ0WBW6sGVpsNdB0en84SepebDjtcWhs+/cCW14XXu4QxmU1Wx7OltV
 94/dpC73lr8W9Ik/O4h6doMHgZaKHEjmcxgJJIlrqtaMva9ga7D10+Lx4/lPrRSvWW
 YWG0Bk89dBu5Q==
Received: from jupiter.universe (unknown [100.64.1.62])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519) (No client certificate requested)
 (Authenticated sender: sre)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id D2E3217E3BE9;
 Sat, 14 Nov 2026 06:00:56 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
 id 2078B480055; Sat, 14 Nov 2026 06:00:56 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Sat, 14 Nov 2026 06:00:47 +0100
Subject: [PATCH v12 14/23] drm/bridge: synopsys: dw-dp: Add Runtime PM support
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261114-synopsys-dw-dp-improvements-v12-14-d42d3dc5bdd4@collabora.com>
References: <20261114-synopsys-dw-dp-improvements-v12-0-d42d3dc5bdd4@collabora.com>
In-Reply-To: <20261114-synopsys-dw-dp-improvements-v12-0-d42d3dc5bdd4@collabora.com>
To: Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andyshrk@163.com>, 
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
 Igor Paunovic <royalnet026@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=14441;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=FgOxOHxuGTimQajJvE6qfgRhaoxxWx9LRFhs3ec+Zns=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGr36wfD+9VCzN6rAXFjXKxBF/wdvCjz+A+nq
 tSjfyxhQbsyeokCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJq9+sHAAoJENju1/PI
 O/qas58QAIKZu55T6C6eng/KZY2zSK2p7jESaQ1F/lEWgYZ8exJ7L3rIBWy3SMiHIhncSKKrw0S
 SPnw9Y+pB8h2SrmgKTPAdySN7WjJeUDUsF5IqhC2su+AsKVGR/O2jO7Jt5yND1lb5gZw7kTnjAU
 NbMwLExHFLsNBtImnT9ByQpQL1qsblFSDKGBoWn6qUX3iIUIvue5H6sEoPG4ghPnvQMEZ6cguTR
 l+RrKouKeM1E1GSkV3CKpkJqJizbrlR3rgXRT65qAd7ZwRfUUbKqkMN1YU87eTOggPVOVF/HwDk
 D1uALZc+yr0D6MkFgcfXPtV2NVz0le0k9gZ/n/PO2E2c4FtAygPZhFfvW4P0TXM8N7B7wxUTH7d
 ZhYA+vGGMRxxcx3c8aLAr3RSS4HR8FFxhdQ3e3vweWq8JVYGHKVQ7lmncrjtWiBYHpGMNnHyaIo
 X/KX7RWEJHJDxTCFAhO9WMywN+LREyT06RIN8oNwet5kr0QdHyfCMdYgz2E1eJ6TkHdh6QELpTT
 LA6Y7DQ46grL8+OvCMSPX84pxCiSbBpXTbpF5WzfmvnkWHv5h4uTdtcOZeClLZXM1mrl10gApcG
 ApFFsrv5B349YlJK9Tg1hOjJKZFjpY3YgDyy+eUKKj4cgkrTb7X+CmxbiVlGM1HOeb/7z29W7cH
 gBBpNeiHd4wg8qcQugqwbLQ==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A
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

Add runtime PM stubs to the Synopsys DesignWare DisplayPort bridge
driver. Support is not enabled automatically and must be hooked up
in the platform specific glue code.

The early bits of the dw_dp_probe function are split into a new
function called dw_dp_alloc, so that the platform driver can assign
it before running dw_dp_probe. This is necessary because the runtime
PM resume/suspend events land at the platform driver and must be
forwarded to the helper once runtime PM is enabled in the middle
of the probe function.

Tested-by: Igor Paunovic <royalnet026@gmail.com> # Orange Pi 5+
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-dp.c   | 207 +++++++++++++++++++++++++-----
 drivers/gpu/drm/rockchip/dw_dp-rockchip.c |   8 +-
 include/drm/bridge/dw_dp.h                |   7 +-
 3 files changed, 187 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
index b4eed4d0a520..4d61ca8f0174 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
@@ -329,6 +329,9 @@ struct dw_dp {
 	struct dw_dp_plat_data plat_data;
 	struct drm_bridge *next_bridge;
 	u8 pixel_mode;
+	bool usbc_mode;
+	bool usbc_hpd;
+	bool pm_active;
 
 	DECLARE_BITMAP(sdp_reg_bank, SDP_REG_BANK_SIZE);
 };
@@ -1466,6 +1469,11 @@ static ssize_t dw_dp_aux_transfer(struct drm_dp_aux *aux,
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
 
@@ -1896,6 +1920,10 @@ static int dw_dp_bridge_attach(struct drm_bridge *bridge,
 	struct device *dev = dp->dev;
 	int ret;
 
+	ret = pm_runtime_get_active(dp->dev, RPM_TRANSPARENT);
+	if (ret)
+		return ret;
+
 	dp->aux.dev = dev;
 	dp->aux.drm_dev = encoder->dev;
 	dp->aux.name = dev_name(dev);
@@ -1904,7 +1932,7 @@ static int dw_dp_bridge_attach(struct drm_bridge *bridge,
 	ret = drm_dp_aux_register(&dp->aux);
 	if (ret) {
 		dev_err(dev, "Aux register failed: %d\n", ret);
-		return ret;
+		goto err_runtime_pm_put;
 	}
 
 	enable_irq(dp->irq);
@@ -1916,11 +1944,15 @@ static int dw_dp_bridge_attach(struct drm_bridge *bridge,
 		goto err_disable_irq;
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
@@ -1931,6 +1963,9 @@ static int dw_dp_bridge_attach(struct drm_bridge *bridge,
 
 	drm_dp_aux_unregister(&dp->aux);
 
+err_runtime_pm_put:
+	pm_runtime_put_sync(dp->dev);
+
 	return ret;
 }
 
@@ -1941,6 +1976,9 @@ static void dw_dp_bridge_detach(struct drm_bridge *bridge)
 	disable_irq(dp->irq);
 	cancel_work_sync(&dp->hpd_work);
 	drm_dp_aux_unregister(&dp->aux);
+
+	if (!dp->usbc_mode)
+		pm_runtime_put_sync(dp->dev);
 }
 
 static void dw_dp_bridge_oob_notify(struct drm_bridge *bridge,
@@ -1949,12 +1987,20 @@ static void dw_dp_bridge_oob_notify(struct drm_bridge *bridge,
 {
 	bool hpd_high = status != connector_status_disconnected;
 	struct dw_dp *dp = bridge_to_dp(bridge);
+	int ret;
+
+	dp->usbc_hpd = hpd_high;
 
 	if (!dp->plat_data.hpd_sw_cfg) {
 		dev_err_once(dp->dev, "Missing platform handler for OOB HPD handling\n");
 		return;
 	}
 
+	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(dp->dev, pm);
+	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
+	if (ret)
+		return;
+
 	dev_dbg(dp->dev, "Force HPD connected=%s\n", str_yes_no(hpd_high));
 	dp->plat_data.hpd_sw_cfg(dp->plat_data.data, hpd_high);
 }
@@ -2011,6 +2057,11 @@ static void dw_dp_hpd_work(struct work_struct *work)
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
@@ -2128,13 +2179,24 @@ static void dw_dp_phy_exit(void *data)
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
@@ -2147,58 +2209,71 @@ struct dw_dp *dw_dp_probe(struct platform_device *pdev, const struct dw_dp_plat_
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
@@ -2208,39 +2283,67 @@ struct dw_dp *dw_dp_probe(struct platform_device *pdev, const struct dw_dp_plat_
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
 	if (ret)
-		return ERR_PTR(ret);
+		return ret;
+
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
 
 	dp->next_bridge = of_drm_get_bridge_by_endpoint(dev->of_node, 1, 0);
 	if (IS_ERR(dp->next_bridge)) {
 		dev_err_probe(dev, PTR_ERR(dp->next_bridge), "failed to get follow-up bridge\n");
-		return ERR_CAST(dp->next_bridge);
+		return PTR_ERR(dp->next_bridge);
 	}
 
 	ret = devm_add_action_or_reset(dev, dw_dp_put_next_bridge, dp);
 	if (ret)
-		return ERR_PTR(ret);
+		return ret;
 
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
+		ret = dw_dp_runtime_resume(dp);
+		if (ret)
+			return ret;
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
@@ -2248,13 +2351,53 @@ struct dw_dp *dw_dp_probe(struct platform_device *pdev, const struct dw_dp_plat_
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
index c5386653991d..1cc6cfad4104 100644
--- a/drivers/gpu/drm/rockchip/dw_dp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_dp-rockchip.c
@@ -192,7 +192,7 @@ static int dw_dp_rockchip_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct rockchip_dw_dp *dp;
 	struct resource *res;
-	int id;
+	int id, ret;
 
 	plat_data_const = device_get_match_data(dev);
 	if (!plat_data_const)
@@ -235,10 +235,14 @@ static int dw_dp_rockchip_probe(struct platform_device *pdev)
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

