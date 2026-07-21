Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0AA1C44536
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 17:52:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73FC110EAE3;
	Tue, 21 Jul 2026 17:52:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="F780WKda";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD76B10E39E
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 17:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1784656358;
 bh=NX4+KWq/USnvfX2Z+8KC7w8NZPVfC1DqfIFgLgnsWAU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=F780WKdaVgS/clm9bLWexZ91c5oacFL+SwCFa5aPJHGmO28J9i6sv1pWiBDOD/XfR
 zIbW24ks+d65yUfJJv6/WQqsHmei79IbdlbM5kefNYgW3/tizOE1oTv+igL8yDoIWu
 EKjOzk2fKV06NVF84zAQXrC6zL0kSw4Lpmyyo7HBqQuDXDA+mxrr0R88xFyimBtKNJ
 TPukwuK+NVLu23vC/Su5QF/vnztbfJZg8KyF1yDMbk8bn26xoIJIBb/LRFZLNWxV4m
 xAiSkGn66UYzXnm+ZsySaJndJyBQzp+KT2vjNvYPVQV/K+/Y70i7y6JPwteMYqE58A
 bQI12m4v77ajg==
Received: from jupiter.universe (unknown [100.64.1.62])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519) (No client certificate requested)
 (Authenticated sender: sre)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 3D28317E10F4;
 Tue, 21 Jul 2026 19:52:38 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
 id 9B933480031; Tue, 21 Jul 2026 19:52:37 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Tue, 21 Jul 2026 19:52:35 +0200
Subject: [PATCH v4 05/10] drm/bridge: synopsys: dw-dp: Support software
 triggered OOB HPD
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-synopsys-dw-dp-improvements-v4-5-f0f4a4ede712@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3741;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=NX4+KWq/USnvfX2Z+8KC7w8NZPVfC1DqfIFgLgnsWAU=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGpfseVsqZrxg8hV5IpVVkA8sjIHj8/PO6Ob3
 XRKUxHpRP+FEYkCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJqX7HlAAoJENju1/PI
 O/qazq8P/juCssGTc22Ea2JnDCHk7N7/GzlOCIFfKkGf+T2dMg01JnpJb+XpZ38FBLo7t7RWVlH
 yymThavjEb0X7EohOcRtduFAVXg2HbCkz0QTg5DNxENvdJdLvhDakDk8FBFdMVBYVWxkEjFUxNC
 TCE7fkpduSObd7L0uaY2Ct/KzO3s4WnaiQUTnq6hmPQJfzxXTX7GGaUYWIEe+clMc1yjWNoeQgw
 1ldnrQkQWCJb2cS4tCVm2BFpu2cqlj2eK+hV+67ah3bVXHB+1M27v2/ex9aO0bl2E1BJGOPr2O9
 KCwb/uSDtP0Xca2Kxuex3I3Yw/vaORmQ303VqfrjpNrG1pB2Iq/ExxAlZIBYpPVDJAF4PjWqbUY
 k0JZjpTuXxWvGP4gv0f4sWK9YtUtHWdxBuQFWAwvvcBdvSMQMWbVJpsdK/379rz49xuWZIYaGfd
 Motx/n9IPeKaPpc8UdbG+xHlVAdiQXed+t+MQqIM0SBtWvObTDOMKabxFEnAJJAlytLRmqxIeXt
 Wlp1sCGl9O40JQwZXcoWubv2EDHp/BVNDyrrdS1+FWDlZ2GrVQscGSsjbQEVxZCyHZ/a8Y9AdNl
 RuM49j0Uu+LE8VScrK5gZBuW71RihOKpvCXWMDju4odVi938PdH8mFMr+6C34ncQsxPPzPrW1ft
 aaNFv/dCfRXNCMUguXew1nA==
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

Add support for USB-C DP AltMode out-of-band hotplug handling. The
handling itself is implemented in the platform specific driver as the
registers to force HPD state are not part of the Designware DisplayPort
IP itself. Instead the platform integration might provide the necessary
functionality to mux the HPD signal.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-dp.c | 38 +++++++++++++++++++++++++++++++++
 include/drm/bridge/dw_dp.h              |  3 +++
 2 files changed, 41 insertions(+)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
index 0e8ecd73a000..8eb2699dc7ab 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
@@ -1819,6 +1819,19 @@ static struct drm_bridge_state *dw_dp_bridge_atomic_duplicate_state(struct drm_b
 	return &state->base;
 }
 
+static void dw_dp_bridge_oob_notify(struct drm_bridge *bridge,
+				    struct drm_connector *connector,
+				    enum drm_connector_status status)
+{
+	bool hpd_high = status != connector_status_disconnected;
+	struct dw_dp *dp = bridge_to_dp(bridge);
+
+	if (dp->plat_data.hpd_sw_cfg)
+		dp->plat_data.hpd_sw_cfg(dp->plat_data.data, hpd_high);
+	else
+		dev_err_once(dp->dev, "Missing platform handler for OOB HPD handling\n");
+}
+
 static const struct drm_bridge_funcs dw_dp_bridge_funcs = {
 	.atomic_duplicate_state = dw_dp_bridge_atomic_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
@@ -1831,6 +1844,7 @@ static const struct drm_bridge_funcs dw_dp_bridge_funcs = {
 	.atomic_disable = dw_dp_bridge_atomic_disable,
 	.detect = dw_dp_bridge_detect,
 	.edid_read = dw_dp_bridge_edid_read,
+	.oob_notify = dw_dp_bridge_oob_notify,
 };
 
 static int dw_dp_link_retrain(struct dw_dp *dp)
@@ -1960,6 +1974,19 @@ static const struct regmap_config dw_dp_regmap_config = {
 	.rd_table = &dw_dp_readable_table,
 };
 
+static bool dw_dp_is_routed_to_usb_c(struct drm_encoder *encoder)
+{
+	struct drm_bridge *last_bridge __free(drm_bridge_put) = NULL;
+	struct fwnode_handle *fwnode;
+
+	last_bridge = drm_bridge_chain_get_last_bridge(encoder);
+	if (!last_bridge)
+		return false;
+
+	fwnode = of_fwnode_handle(last_bridge->of_node);
+	return fwnode_device_is_compatible(fwnode, "usb-c-connector");
+}
+
 int dw_dp_bind(struct dw_dp *dp, struct drm_encoder *encoder)
 {
 	struct device *dev = dp->dev;
@@ -2004,6 +2031,13 @@ int dw_dp_bind(struct dw_dp *dp, struct drm_encoder *encoder)
 		goto put_next_bridge;
 	}
 
+	if (dw_dp_is_routed_to_usb_c(encoder)) {
+		dev_dbg(dev, "USB-C mode\n");
+
+		if (dp->plat_data.hpd_sw_sel)
+			dp->plat_data.hpd_sw_sel(dp->plat_data.data, 1);
+	}
+
 	dw_dp_init_hw(dp);
 
 	ret = phy_init(dp->phy);
@@ -2052,6 +2086,10 @@ struct dw_dp *dw_dp_probe(struct platform_device *pdev, const struct dw_dp_plat_
 
 	dp->dev = dev;
 	dp->pixel_mode = plat_data->pixel_mode;
+
+	dp->plat_data.hpd_sw_sel = plat_data->hpd_sw_sel;
+	dp->plat_data.hpd_sw_cfg = plat_data->hpd_sw_cfg;
+	dp->plat_data.data = plat_data->data;
 	dp->plat_data.max_link_rate = plat_data->max_link_rate;
 
 	mutex_init(&dp->irq_lock);
diff --git a/include/drm/bridge/dw_dp.h b/include/drm/bridge/dw_dp.h
index a82412a9e769..79b2cdf0df99 100644
--- a/include/drm/bridge/dw_dp.h
+++ b/include/drm/bridge/dw_dp.h
@@ -20,6 +20,9 @@ enum {
 struct dw_dp_plat_data {
 	u32 max_link_rate;
 	u8 pixel_mode;
+	void *data;
+	void (*hpd_sw_sel)(void *data, bool hpd);
+	void (*hpd_sw_cfg)(void *data, bool hpd);
 };
 
 int dw_dp_bind(struct dw_dp *dp, struct drm_encoder *encoder);

-- 
2.53.0

