Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BE1EC55174
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 00:39:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0B5510F03C;
	Thu,  6 Aug 2026 00:39:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="QAy2JK5k";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D02B10E1D3
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 00:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1785976750;
 bh=+kI5bMPxmKszrrlmZRhrrwGKt5vlPS+riQK99NPB3wM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=QAy2JK5kux4tSxZVKkdlsIDYAt7+WrjtAEZEmG7zWFvKVCZhfyXLKtKdaZ7hmrAbI
 6Zl5yn4lGVeCEtbusiDza0XLFhx3oiT4wZpoKCuRjqxA43477vYfHgLCJeZEcRQZlR
 zAUg8cdIbCaq+D/kledrJrK0+6JJs/nLPhE1vl3zR+mktG7lO9Oo4GvGjpnxNAAA9r
 JPjlwFMr10VXhKs125Rno7ibhXhvooix3YaWuYx7Hge9KcrAKVKbU9oxrHD8NgaCdg
 SJfO0BnJqs5J2A/OubrbYh1cKeF64Eq7G6MCcEsoxAd5DGLBVPM1od5FTeIkti/JGE
 6ppiV8naz62oQ==
Received: from jupiter.universe (unknown [100.64.1.62])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: sre)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id D29D517E052F;
 Thu, 06 Aug 2026 02:39:10 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
 id 87D1E480028; Thu, 06 Aug 2026 02:39:10 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Thu, 06 Aug 2026 02:39:07 +0200
Subject: [PATCH v10 01/21] drm/bridge: synopsys: dw-dp: Register DP AUX on
 bridge attach
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-synopsys-dw-dp-improvements-v10-1-d84a26c303d6@collabora.com>
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
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3652;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=+kI5bMPxmKszrrlmZRhrrwGKt5vlPS+riQK99NPB3wM=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGpz161XxASkSlzZQXOp8/+GsmxmqBn+xiC0U
 8UxrMEnInKOXIkCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJqc9etAAoJENju1/PI
 O/qa4y4QAIFJsqPdLNa8OBIaOQF6MJkQIkC8pcs6SK/c4+xA023pmhhGsLWhhj/khwNfrxnNJ3s
 iEODziZZIezGptie9elbk12yG/rGOnyfC9f0XL9j+GZVXtpQUGcU67q0UvOWl3V0o8JvsdFr0UV
 9KdTzWv3X5BSPWSOfFSUNSNt5XZ3gytoOPJzfJyE81EG7nzKqPuD6O3buyMi0/vyo/kvcqC3yhN
 gzKLEntc/h0Ct8+sWFtPWSo0Hn+zuCbnTIxfZuKMnL9hZ4U3L4nGIIPkEpKC2pCaIp4XuRR9xbF
 SgnGLgMG6sJ8uR7n8hEX04UpCJBis6ectLD/2yR7j9CH+NyyrlXnwMbFywJ6BG8JnwXv/LGh4OV
 RUfb0lbPYWGYW/r6ls2KPCOM20RJna2QIZlFYGUZo1Upzu1D85Mu/LDR8MP1zj2osV18G98AnTU
 5Z34W7rr3BHZMvtpFcCbOd9pJDnCi4JKZkwWEWRxcmeDnk1bjwygfy99kmzm6eVqiaVeugaeo4W
 kehok619CAuHlga9+l5WLGDFdmTCGzYoOiNumryEO+Fsj8F+maytlnHASNcBnm5lV6Y/8dNMcpP
 r+/ZQSu9QkVECHhRjbFXWmRawNSRU2KSh4wD8ZLr1yANMYdMSXtzuEnR4yfU8y0Hn53o2dKeOpJ
 ZCCiL1kOu6GJ7mD6femcy7A==
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

Unregister the DP AUX device at the right spot as documented in the
drm_dp_aux_register() function description. This helps that it is
only accessed when the DRM device is ready and the bridge is powered
and initialized (further fixes are required for that).

Fixes: 86eecc3a9c2e ("drm/bridge: synopsys: Add DW DPTX Controller support library")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-dp.c | 55 +++++++++++++++++++++------------
 1 file changed, 35 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
index 8b8529e1723c..60feb3d1e14b 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
@@ -1813,7 +1813,36 @@ static struct drm_bridge_state *dw_dp_bridge_atomic_duplicate_state(struct drm_b
 	return &state->base;
 }
 
+static int dw_dp_bridge_attach(struct drm_bridge *bridge,
+			       struct drm_encoder *encoder,
+			       enum drm_bridge_attach_flags flags)
+{
+	struct dw_dp *dp = bridge_to_dp(bridge);
+	struct device *dev = dp->dev;
+	int ret;
+
+	dp->aux.dev = dev;
+	dp->aux.drm_dev = encoder->dev;
+	dp->aux.name = dev_name(dev);
+	dp->aux.transfer = dw_dp_aux_transfer;
+
+	ret = drm_dp_aux_register(&dp->aux);
+	if (ret)
+		dev_err(dev, "Aux register failed: %d\n", ret);
+
+	return ret;
+}
+
+static void dw_dp_bridge_detach(struct drm_bridge *bridge)
+{
+	struct dw_dp *dp = bridge_to_dp(bridge);
+
+	drm_dp_aux_unregister(&dp->aux);
+}
+
 static const struct drm_bridge_funcs dw_dp_bridge_funcs = {
+	.attach = dw_dp_bridge_attach,
+	.detach = dw_dp_bridge_detach,
 	.atomic_duplicate_state = dw_dp_bridge_atomic_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
 	.atomic_create_state = drm_atomic_helper_bridge_create_state,
@@ -2043,20 +2072,10 @@ struct dw_dp *dw_dp_bind(struct device *dev, struct drm_encoder *encoder,
 	if (ret)
 		return ERR_PTR(ret);
 
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
 	ret = drm_bridge_attach(encoder, bridge, NULL, DRM_BRIDGE_ATTACH_NO_CONNECTOR);
 	if (ret) {
 		dev_err_probe(dev, ret, "Failed to attach bridge\n");
-		goto unregister_aux;
+		return ERR_PTR(ret);
 	}
 
 	dw_dp_init_hw(dp);
@@ -2064,37 +2083,33 @@ struct dw_dp *dw_dp_bind(struct device *dev, struct drm_encoder *encoder,
 	ret = phy_init(dp->phy);
 	if (ret) {
 		dev_err_probe(dev, ret, "phy init failed\n");
-		goto unregister_aux;
+		return ERR_PTR(ret);
 	}
 
 	ret = devm_add_action_or_reset(dev, dw_dp_phy_exit, dp);
 	if (ret)
-		goto unregister_aux;
+		return ERR_PTR(ret);
 
 	dp->irq = platform_get_irq(pdev, 0);
 	if (dp->irq < 0) {
 		ret = dp->irq;
-		goto unregister_aux;
+		return ERR_PTR(ret);
 	}
 
 	ret = devm_request_threaded_irq(dev, dp->irq, NULL, dw_dp_irq,
 					IRQF_ONESHOT, dev_name(dev), dp);
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
 EXPORT_SYMBOL_GPL(dw_dp_bind);
 
 void dw_dp_unbind(struct dw_dp *dp)
 {
-	drm_dp_aux_unregister(&dp->aux);
+	/* nothing to do */
 }
 EXPORT_SYMBOL_GPL(dw_dp_unbind);
 

-- 
2.53.0

