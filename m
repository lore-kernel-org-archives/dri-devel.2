Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E854C53200
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 22:18:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4ABC710F234;
	Thu, 23 Jul 2026 22:18:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="F8kQ2ssz";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8896D10F22E
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 22:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1784845042;
 bh=hcdsBF0i36H1vzEIUAoDhRmTZkK3f6r23/Cn46dhBxI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=F8kQ2sszP9ffpJxbnPQyboXJm6BhEqUukYwn7+zK1T/BO+H2Q8v2tbKFY8Toe1VWI
 d/fWk8OkGOHwtmflhw/7vVDqJDT2QkrMv4F13gwHMxwnbDxJ/WF6/oW/slByTpXo5P
 d1cCgw/TUu3oE3lcRSPTr5LuC0YvS+Tf3lIPsFx3ZasIkC/t1OlkLojaNpDJZoQyZB
 x8ANw6V3YvNldFADfR66lUcjbxHzyKzqrL0GacLgoB0qj6nKoHJoXzNbjx3fomU20x
 xbTv6v3ep4gm8uJoRFQaZukiI4WpAfs6N94vvBx+DcSGcZrQ3loFSYOrAYyMUZdgEw
 fXR74MjfropkA==
Received: from jupiter.universe (unknown [100.64.1.62])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519) (No client certificate requested)
 (Authenticated sender: sre)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id BC24717E399D;
 Fri, 24 Jul 2026 00:17:22 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
 id 1AA59480047; Fri, 24 Jul 2026 00:17:22 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Fri, 24 Jul 2026 00:17:18 +0200
Subject: [PATCH v5 10/15] drm/bridge: synopsys: dw-dp: Add Runtime PM support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-synopsys-dw-dp-improvements-v5-10-9445c2e87441@collabora.com>
References: <20260724-synopsys-dw-dp-improvements-v5-0-9445c2e87441@collabora.com>
In-Reply-To: <20260724-synopsys-dw-dp-improvements-v5-0-9445c2e87441@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5440;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=hcdsBF0i36H1vzEIUAoDhRmTZkK3f6r23/Cn46dhBxI=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGpikvHO88jUfcvf5FWk2GuXt6aUZuWTK1Fgb
 dea2Bvfj9VkhokCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJqYpLxAAoJENju1/PI
 O/qaSxUP/AsT3SSoeBasg34KtlE+8B4kXgSXT+xwuPZYfdnuias3cyLutVRuw0k10DujEtFYqxn
 pw7iLKsXaQsUpOZ1U+31V1lzWRunRJX9ggozwy/zEOI1YHy8/ddrrlpvCaE+/C/cdnMr/C7kG0R
 KWARk1psjuFftCv1mnuX+g13g1EKAyIybsRczV6qyCYeYDxsmgX8BNyUCcG6cgLR7ZtWhQccSXT
 ZriEwjfqnuJfWHU8vFlNlOFLlEMvIKIocv5CysfHB20EBcVvdzgavsB2FYOLyXiSkSB+3CBYUc2
 1i1pQXHr6AEPowxJpzg7/XUzNcRcW0O1M+pHzXfbdtt0sLvtsDfwM128CJf/9Ey5UCI0PZGCAcL
 Xl0p9otK/05YB+63lPt7Rc3dxe7jeLqF+PIZ1q3QsqkaI9Drv9EA4d6N5FIEH9LrxL+P1ohju2y
 w0V7WaQuoPoGrUgJYjafZlDUmzkR9OB4tTsYuBsUjmsG6vOUIiNYRnSEHs9ZFCS87cIvXDmwQJg
 +8s6gj6yxRR+v4FO2Xq1e8eTQzB2+LK0LDhw5ofPO7yjmHhiLbnUfaWabqQrELf75WTOxkkYZbv
 rdYWzhWtzqv1ny/w2XPZEAc4m6o2hyql8fE6+w/PwbeqKF5VhUfsivLiSP+ZngEWkMsuJDE+usG
 7p5bfInidiLqbI5idG5062A==
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
 drivers/gpu/drm/bridge/synopsys/dw-dp.c | 71 ++++++++++++++++++++++++++++++++-
 include/drm/bridge/dw_dp.h              |  3 ++
 2 files changed, 72 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
index 9975df8ea37e..bcf7ad84f217 100644
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
 
+	PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(dp->dev, pm);
+	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
+	if (ret)
+		return ret;
+
 	switch (msg->request & ~DP_AUX_I2C_MOT) {
 	case DP_AUX_NATIVE_WRITE:
 	case DP_AUX_I2C_WRITE:
@@ -1720,6 +1726,8 @@ static void dw_dp_bridge_atomic_enable(struct drm_bridge *bridge,
 	struct drm_connector_state *conn_state;
 	int ret;
 
+	pm_runtime_get_sync(dp->dev);
+
 	connector = drm_atomic_get_new_connector_for_encoder(state, bridge->encoder);
 	if (!connector) {
 		dev_err(dp->dev, "failed to get connector\n");
@@ -1774,6 +1782,7 @@ static void dw_dp_bridge_atomic_disable(struct drm_bridge *bridge,
 	dw_dp_link_disable(dp);
 	bitmap_zero(dp->sdp_reg_bank, SDP_REG_BANK_SIZE);
 	dw_dp_reset(dp);
+	pm_runtime_put_autosuspend(dp->dev);
 }
 
 static bool dw_dp_hpd_detect_link(struct dw_dp *dp, struct drm_connector *connector)
@@ -1794,6 +1803,10 @@ static enum drm_connector_status dw_dp_bridge_detect(struct drm_bridge *bridge,
 {
 	struct dw_dp *dp = bridge_to_dp(bridge);
 
+	PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(dp->dev, pm);
+	if (PM_RUNTIME_ACQUIRE_ERR(&pm))
+		return connector_status_disconnected;
+
 	if (!dw_dp_hpd_detect(dp))
 		return connector_status_disconnected;
 
@@ -1973,10 +1986,17 @@ static irqreturn_t dw_dp_irq(int irq, void *data)
 {
 	struct dw_dp *dp = data;
 	u32 value;
+	int ret;
+
+	ret = pm_runtime_get_if_active(dp->dev);
+	if (ret <= 0)
+		return IRQ_NONE;
 
 	regmap_read(dp->regmap, DW_DP_GENERAL_INTERRUPT, &value);
-	if (!value)
+	if (!value) {
+		pm_runtime_put_autosuspend(dp->dev);
 		return IRQ_NONE;
+	}
 
 	if (value & HPD_EVENT)
 		dw_dp_handle_hpd_event(dp);
@@ -1986,6 +2006,7 @@ static irqreturn_t dw_dp_irq(int irq, void *data)
 		complete(&dp->complete);
 	}
 
+	pm_runtime_put_autosuspend(dp->dev);
 	return IRQ_HANDLED;
 }
 
@@ -2073,10 +2094,15 @@ int dw_dp_bind(struct dw_dp *dp, struct drm_encoder *encoder)
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
@@ -2084,13 +2110,17 @@ int dw_dp_bind(struct dw_dp *dp, struct drm_encoder *encoder)
 	ret = phy_init(dp->phy);
 	if (ret) {
 		dev_err_probe(dev, ret, "phy init failed\n");
-		goto put_next_bridge;
+		goto put_runtime_pm;
 	}
 
 	enable_irq(dp->irq);
 
 	return 0;
 
+put_runtime_pm:
+	if (!dp->usbc_mode)
+		pm_runtime_put_sync(dp->dev);
+
 put_next_bridge:
 	drm_bridge_put(dp->next_bridge);
 
@@ -2106,6 +2136,8 @@ EXPORT_SYMBOL_GPL(dw_dp_bind);
 
 void dw_dp_unbind(struct dw_dp *dp)
 {
+	if (!dp->usbc_mode)
+		pm_runtime_put_sync(dp->dev);
 	disable_irq(dp->irq);
 	cancel_work_sync(&dp->hpd_work);
 	phy_exit(dp->phy);
@@ -2208,6 +2240,41 @@ struct dw_dp *dw_dp_probe(struct platform_device *pdev, const struct dw_dp_plat_
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

