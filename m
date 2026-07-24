Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC28FC531C9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 18:03:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E89D610E0B1;
	Fri, 24 Jul 2026 18:03:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="ZmmsIIVn";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F1C110E06D
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 18:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1784916209;
 bh=Sb21u3BNR0bBte5cLcHkxQTLZNLzTlV8x9Hr4lta62A=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=ZmmsIIVn9mr+DPlqwRbYu3fJ44dJSXYBDZ8e6D0GNPg4RqdUCDlI9e5rTEt01Tqad
 cCqgsvqDGYoswrBBeaGfljhpGzBJnThr1Aihtevya4CgKC0dyrvrbummnaILsZcGJ5
 NT6TkuR0Jk6YoI/EB5b9W97KejsZDr2E6K64uPTlees6vhJnB33+w/185Y4kp0lJJW
 E6LVxAuiac/9E6WZhI2EjlcF0PDC8sIyEgpJca+sJUOa2yGSi0hxFxHuXhMDYNDD6w
 aJ6TGRrXQJEDh2l2/nP7NVVMF7eOBlGw7CVD0vVYXWAebpgtUcwUUFojeIYD2BnqbS
 7B5F+ZS3emI/Q==
Received: from jupiter.universe (unknown [100.64.1.62])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519) (No client certificate requested)
 (Authenticated sender: sre)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 9E4EE17E02B6;
 Fri, 24 Jul 2026 20:03:29 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
 id EC285480048; Fri, 24 Jul 2026 20:03:28 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Fri, 24 Jul 2026 20:03:33 +0200
Subject: [PATCH v6 11/16] drm/bridge: synopsys: dw-dp: Add Runtime PM support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-synopsys-dw-dp-improvements-v6-11-041d99a19c4e@collabora.com>
References: <20260724-synopsys-dw-dp-improvements-v6-0-041d99a19c4e@collabora.com>
In-Reply-To: <20260724-synopsys-dw-dp-improvements-v6-0-041d99a19c4e@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6907;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=Sb21u3BNR0bBte5cLcHkxQTLZNLzTlV8x9Hr4lta62A=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGpjqPA/sE7y0qSSAl0Zke+p0nmcK8ASN0Aeb
 UXvUipGAJjQtYkCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJqY6jwAAoJENju1/PI
 O/qacvYP/08UR0/e3lPD6mtBcYgFo+IHAY8bI2BsYuSuuHoef2qc1f39Yba1LsslvGBk/hpRllm
 OCWvhz/yB2LbG8Hi+CYSTuLi+tfQc0rfSgjxbFVYy1GdztdYErnBUORC63bcDn4LrXCifLVHpy5
 eVjJ551Wgk3mwVSXxGUYmo3q6XUjLfpiZaG6GcqRl2PEc/jN/nW/xqlTQlPdBP1fQKtmA3Baqe6
 AEi0rki9x9GIQhPCHpaRqwpNi8e+ApJz9db6ib16zuElnnTQ0iSyGECpyR+Dmxg7mr3rQ2KVU3l
 yWgdbgSPQqaOVcdMzfCacQRWH0217bqrYX3y3q9OLiYFEjaUgMGMd6Nx/FACz9DAzcUJkh/9EKb
 a6hPxj3aEak7MqVgd+1RYcokJC98NK7oUksP1ts4xs0RT/hAsk1Nas0ePVVPR89vpaB5uLBoYhb
 yywF2aQ1cLcq5RRMg+Gg1zWAgz7dSnkgEFN+gYMLnAfrvYXyhFg6OHsaZ5s5ptkOceJHbMgpA/Q
 kaRYvLVpnJ7zKM4SCRvwIn346bJSoAG5mdDoWbXlI4tk+IB+15psOD8FB9vGqP5hug94KL7zm4w
 eP80l6gY+Mn6cAjO9ABPTguWT1F9j870FUihDURKjlvYoND7uXC4eD/EwCBZaIFPAeGssppLdK7
 nqWtCitB8WmpdgOusk94uIQ==
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
in the vendor specific glue code.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-dp.c | 107 +++++++++++++++++++++++++++++---
 include/drm/bridge/dw_dp.h              |   3 +
 2 files changed, 102 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
index 2042bc00f906..1bbb39b8d0be 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
@@ -328,6 +328,7 @@ struct dw_dp {
 	struct dw_dp_link link;
 	struct dw_dp_plat_data plat_data;
 	u8 pixel_mode;
+	bool usbc_mode;
 
 	struct drm_bridge *next_bridge;
 
@@ -1467,6 +1468,11 @@ static ssize_t dw_dp_aux_transfer(struct drm_dp_aux *aux,
 	if (WARN_ON(msg->size > 16))
 		return -E2BIG;
 
+	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(dp->dev, pm);
+	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
+	if (ret)
+		return ret;
+
 	reinit_completion(&dp->complete);
 
 	switch (msg->request & ~DP_AUX_I2C_MOT) {
@@ -1659,6 +1665,12 @@ static void dw_dp_bridge_atomic_enable(struct drm_bridge *bridge,
 	struct drm_connector_state *conn_state;
 	int ret;
 
+	ret = pm_runtime_get_active(dp->dev, RPM_TRANSPARENT);
+	if (ret) {
+		dev_err(dp->dev, "runtime PM failure\n");
+		return;
+	}
+
 	connector = drm_atomic_get_new_connector_for_encoder(state, bridge->encoder);
 	if (!connector) {
 		dev_err(dp->dev, "failed to get connector\n");
@@ -1713,6 +1725,7 @@ static void dw_dp_bridge_atomic_disable(struct drm_bridge *bridge,
 	dw_dp_link_disable(dp);
 	bitmap_zero(dp->sdp_reg_bank, SDP_REG_BANK_SIZE);
 	dw_dp_reset(dp);
+	pm_runtime_put_autosuspend(dp->dev);
 }
 
 static bool dw_dp_hpd_detect_link(struct dw_dp *dp, struct drm_connector *connector)
@@ -1733,6 +1746,10 @@ static enum drm_connector_status dw_dp_bridge_detect(struct drm_bridge *bridge,
 {
 	struct dw_dp *dp = bridge_to_dp(bridge);
 
+	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(dp->dev, pm);
+	if (PM_RUNTIME_ACQUIRE_ERR(&pm))
+		return connector_status_disconnected;
+
 	if (!dw_dp_hpd_detect(dp))
 		return connector_status_disconnected;
 
@@ -1915,6 +1932,11 @@ static void dw_dp_hpd_work(struct work_struct *work)
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
@@ -1966,6 +1988,9 @@ static irqreturn_t dw_dp_irq(int irq, void *data)
 	struct dw_dp *dp = data;
 	u32 value;
 
+	/* interrupt can only trigger for running device */
+	guard(pm_runtime_noresume)(dp->dev);
+
 	regmap_read(dp->regmap, DW_DP_GENERAL_INTERRUPT, &value);
 	if (!value)
 		return IRQ_NONE;
@@ -2064,25 +2089,51 @@ int dw_dp_bind(struct dw_dp *dp, struct drm_encoder *encoder)
 		goto put_next_bridge;
 	}
 
-	if (dw_dp_is_routed_to_usb_c(encoder)) {
-		dev_dbg(dev, "USB-C mode\n");
+	dp->usbc_mode = dw_dp_is_routed_to_usb_c(encoder);
 
-		if (dp->plat_data.hpd_sw_sel)
-			dp->plat_data.hpd_sw_sel(dp->plat_data.data, 1);
+	ret = pm_runtime_get_active(dev, RPM_TRANSPARENT);
+	if (ret) {
+		dev_err_probe(dev, ret, "Failed to get runtime PM\n");
+		goto put_next_bridge;
 	}
 
-	dw_dp_init_hw(dp);
+	/* resume once if runtime PM is disabled */
+	if (!pm_runtime_enabled(dev)) {
+		ret = dw_dp_runtime_resume(dp);
+		if (ret)
+			goto put_runtime_pm;
+	}
+
+	if (dp->plat_data.hpd_sw_sel)
+		dp->plat_data.hpd_sw_sel(dp->plat_data.data, dp->usbc_mode);
 
 	ret = phy_init(dp->phy);
 	if (ret) {
 		dev_err_probe(dev, ret, "phy init failed\n");
-		goto put_next_bridge;
+		goto put_manual_pm;
 	}
 
 	enable_irq(dp->irq);
 
+	/*
+	 * USB-C has out-of-band hotplug detection, so device may enter
+	 * runtime suspend. Native mode needs to be resumed for working
+	 * hotplug detection.
+	 */
+	if (dp->usbc_mode) {
+		dev_dbg(dev, "USB-C mode\n");
+		pm_runtime_put_autosuspend(dp->dev);
+	}
+
 	return 0;
 
+put_manual_pm:
+	if (!pm_runtime_enabled(dev))
+		dw_dp_runtime_suspend(dp);
+
+put_runtime_pm:
+	pm_runtime_put_sync(dp->dev);
+
 put_next_bridge:
 	drm_bridge_put(dp->next_bridge);
 
@@ -2101,6 +2152,11 @@ void dw_dp_unbind(struct dw_dp *dp)
 	disable_irq(dp->irq);
 	cancel_work_sync(&dp->hpd_work);
 	phy_exit(dp->phy);
+	if (!dp->usbc_mode)
+		pm_runtime_put_sync(dp->dev);
+	/* suspend once if runtime PM is disabled */
+	if (!pm_runtime_enabled(dp->dev))
+		dw_dp_runtime_suspend(dp);
 	drm_bridge_put(dp->next_bridge);
 	drm_dp_aux_unregister(&dp->aux);
 	drm_bridge_remove(&dp->bridge);
@@ -2149,13 +2205,13 @@ struct dw_dp *dw_dp_probe(struct platform_device *pdev, const struct dw_dp_plat_
 		return ERR_CAST(dp->phy);
 	}
 
-	dp->apb_clk = devm_clk_get_enabled(dev, "apb");
+	dp->apb_clk = devm_clk_get(dev, "apb");
 	if (IS_ERR(dp->apb_clk)) {
 		dev_err_probe(dev, PTR_ERR(dp->apb_clk), "failed to get apb clock\n");
 		return ERR_CAST(dp->apb_clk);
 	}
 
-	dp->aux_clk = devm_clk_get_enabled(dev, "aux");
+	dp->aux_clk = devm_clk_get(dev, "aux");
 	if (IS_ERR(dp->aux_clk)) {
 		dev_err_probe(dev, PTR_ERR(dp->aux_clk), "failed to get aux clock\n");
 		return ERR_CAST(dp->aux_clk);
@@ -2200,6 +2256,41 @@ struct dw_dp *dw_dp_probe(struct platform_device *pdev, const struct dw_dp_plat_
 }
 EXPORT_SYMBOL_GPL(dw_dp_probe);
 
+int dw_dp_runtime_suspend(struct dw_dp *dp)
+{
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
+
+	ret = clk_prepare_enable(dp->aux_clk);
+	if (ret) {
+		clk_disable_unprepare(dp->apb_clk);
+		return ret;
+	}
+
+	dw_dp_init_hw(dp);
+
+	/*
+	 * HPD_HOT_PLUG bit is asserted only after the sink holds HPD
+	 * high for at least 100ms.
+	 */
+	msleep(110);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(dw_dp_runtime_resume);
+
 MODULE_AUTHOR("Andy Yan <andyshrk@163.com>");
 MODULE_DESCRIPTION("DW DP Core Library");
 MODULE_LICENSE("GPL");
diff --git a/include/drm/bridge/dw_dp.h b/include/drm/bridge/dw_dp.h
index 79b2cdf0df99..f20d2c2c40ca 100644
--- a/include/drm/bridge/dw_dp.h
+++ b/include/drm/bridge/dw_dp.h
@@ -29,4 +29,7 @@ int dw_dp_bind(struct dw_dp *dp, struct drm_encoder *encoder);
 void dw_dp_unbind(struct dw_dp *dp);
 
 struct dw_dp *dw_dp_probe(struct platform_device *pdev, const struct dw_dp_plat_data *plat_data);
+
+int dw_dp_runtime_suspend(struct dw_dp *dp);
+int dw_dp_runtime_resume(struct dw_dp *dp);
 #endif /* __DW_DP__ */

-- 
2.53.0

