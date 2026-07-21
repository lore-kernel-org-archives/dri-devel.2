Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 796A2C4452B
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 17:53:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDD9010EAED;
	Tue, 21 Jul 2026 17:53:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="NvTIfcpG";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1709510E696
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 17:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1784656358;
 bh=F1aUwDw1oCdiQKc4Mr/s1A9oQOTsJxibKKDasYb4aSk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=NvTIfcpGIqZItnMERhJzz+CX7sGlWe4jQ2a81A+J2aTIy2cRre17WJmP1ODad+a0/
 k9XM5UDR5kVQ4mjT802M23FHdmng+Sb49aJW0o2MP9WWucZmeU8gcKIkcFPdBhcLwd
 uZ87V/OPM63O7/bEaFlmCCJSnRdtgxkXLjTBvfp2GIVV9QFOMDEl0PQG7WmBU0huJv
 VFHCaUGy7PuBmkumanavrpBhG4hCFZTp1rvLOxc1fDqTfFjUta5j6Tby2b71Oo3dKG
 djxspBiIq1n7d1oLPziiwNXgkEvjwQpIo+bA3pujgK4/6nUPxH+A69AOv/b+WZHIQ7
 Ds3HUsl2KupTw==
Received: from jupiter.universe (unknown [100.64.1.62])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519) (No client certificate requested)
 (Authenticated sender: sre)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 46E1F17E11F5;
 Tue, 21 Jul 2026 19:52:38 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
 id 9ED71480038; Tue, 21 Jul 2026 19:52:37 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Tue, 21 Jul 2026 19:52:37 +0200
Subject: [PATCH v4 07/10] drm/bridge: synopsys: dw-dp: Add Runtime PM support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-synopsys-dw-dp-improvements-v4-7-f0f4a4ede712@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4278;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=F1aUwDw1oCdiQKc4Mr/s1A9oQOTsJxibKKDasYb4aSk=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGpfseXY5QIUTimL8C+WVfjzgs/9sWaQomIKU
 FoG4aHTFrd1f4kCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJqX7HlAAoJENju1/PI
 O/qahWsP+wZW8cZN0zpUMyr7/8wzhYujBUQMZPR/k9tP51OC6yrkwldFIDYh94xx7Dlt4RTOcCF
 kxFAypHCm/iQ5FCMOybC6Sr03oV75twQ7IsDcKlXK96E1VdRfSrOtNrVYVxSIbZNrLwk51VgT0Y
 mtPrc2d6ry6fP6E9NANrwG2EVL/j39rBMRcWX2ar6Yl3mVfS4MT2LGt6uq0bbPh5C0shjyL+hMC
 EgRhkTMU3d/25tpFuzE/M05cBCm3ED7deJwXbgD4teIe/Bw5OaNDQbF8B7fXNP9FitL5uyzRxAv
 IrO0vh/lb7QDmnoZWvnRthoYlmwiUwvXpkeIDn88Rt2aGUtcZ4HFaWUm8sfTQRgpX8TKcK5T7SA
 CWh6gnUZZuoJzMyPQeeF+OpX2+FHlOuVlnjKCeWkRnrPWXpnLgNEfMcXTKHKx1ig0cQYtF1uDSC
 kD6yU7K3Drrn9FibL43wT0/YVGuGN8vQl9PvC2cEFdKbycb16bYLJSSZp0wH6MxSBtg6BCXMvBq
 62G3enoe2N38kSk6mTdU4233xqxVmIJXS50e9r9uzsLrtXQ9ZsiDdGAg3Stti4m7eyud+EVPMyB
 +0FjDdEsvxeMpLq50k4EcKNphiiO6b37LOQOMwo4SxCKEPDjOKMHP0EN0T6ETVVnO0egQ0zf89Y
 S2G7ghW7JXwku0PV4lHUvlQ==
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
 drivers/gpu/drm/bridge/synopsys/dw-dp.c | 50 +++++++++++++++++++++++++++++++++
 include/drm/bridge/dw_dp.h              |  3 ++
 2 files changed, 53 insertions(+)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
index 8eb2699dc7ab..636b9e105297 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
@@ -328,6 +328,7 @@ struct dw_dp {
 	struct dw_dp_link link;
 	struct dw_dp_plat_data plat_data;
 	u8 pixel_mode;
+	bool usbc_mode;
 
 	struct drm_bridge *next_bridge;
 
@@ -1467,6 +1468,8 @@ static ssize_t dw_dp_aux_transfer(struct drm_dp_aux *aux,
 	if (WARN_ON(msg->size > 16))
 		return -E2BIG;
 
+	ACQUIRE(pm_runtime_active_auto, pm)(dp->dev);
+
 	switch (msg->request & ~DP_AUX_I2C_MOT) {
 	case DP_AUX_NATIVE_WRITE:
 	case DP_AUX_I2C_WRITE:
@@ -1657,6 +1660,8 @@ static void dw_dp_bridge_atomic_enable(struct drm_bridge *bridge,
 	struct drm_connector_state *conn_state;
 	int ret;
 
+	pm_runtime_get_sync(dp->dev);
+
 	connector = drm_atomic_get_new_connector_for_encoder(state, bridge->encoder);
 	if (!connector) {
 		dev_err(dp->dev, "failed to get connector\n");
@@ -1711,6 +1716,7 @@ static void dw_dp_bridge_atomic_disable(struct drm_bridge *bridge,
 	dw_dp_link_disable(dp);
 	bitmap_zero(dp->sdp_reg_bank, SDP_REG_BANK_SIZE);
 	dw_dp_reset(dp);
+	pm_runtime_put_autosuspend(dp->dev);
 }
 
 static bool dw_dp_hpd_detect_link(struct dw_dp *dp, struct drm_connector *connector)
@@ -1731,6 +1737,14 @@ static enum drm_connector_status dw_dp_bridge_detect(struct drm_bridge *bridge,
 {
 	struct dw_dp *dp = bridge_to_dp(bridge);
 
+	ACQUIRE(pm_runtime_active_auto, pm)(dp->dev);
+
+	/*
+	 * HPD_HOT_PLUG bit is asserted only after the sink holds HPD high for
+	 * at least 100ms. Thus we need to wait 100ms after runtime PM resume.
+	 */
+	msleep(110);
+
 	if (!dw_dp_hpd_detect(dp))
 		return connector_status_disconnected;
 
@@ -2032,10 +2046,15 @@ int dw_dp_bind(struct dw_dp *dp, struct drm_encoder *encoder)
 	}
 
 	if (dw_dp_is_routed_to_usb_c(encoder)) {
+		dp->usbc_mode = true;
 		dev_dbg(dev, "USB-C mode\n");
 
 		if (dp->plat_data.hpd_sw_sel)
 			dp->plat_data.hpd_sw_sel(dp->plat_data.data, 1);
+	} else {
+		dp->usbc_mode = false;
+		/* Keep runtime PM enabled to have working native HPD IRQ */
+		pm_runtime_get_sync(dp->dev);
 	}
 
 	dw_dp_init_hw(dp);
@@ -2065,6 +2084,8 @@ EXPORT_SYMBOL_GPL(dw_dp_bind);
 
 void dw_dp_unbind(struct dw_dp *dp)
 {
+	if (dp->usbc_mode)
+		pm_runtime_put_autosuspend(dp->dev);
 	disable_irq(dp->irq);
 	phy_exit(dp->phy);
 	drm_bridge_put(dp->next_bridge);
@@ -2163,6 +2184,35 @@ struct dw_dp *dw_dp_probe(struct platform_device *pdev, const struct dw_dp_plat_
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

