Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4CABC54F54
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 14:43:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01FD410F2BF;
	Fri, 31 Jul 2026 14:43:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="MtNpxYUi";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E601510F2B1
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 14:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1785508929;
 bh=rrt5YOOAgulVloGhA8XYLb7XVQPmqKwIeo2+VJPjwtM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=MtNpxYUi9XbAo1fed4Wm2aqPkXCznUo6OhXX301G+SJSaRxPb0e3l9XeKWoH652dy
 Gpx7Fan3FW1D61d5RrMh/dWO7wK5e5b+3HtdtrjpsK+yTxOtkCeRZe/zzk/hLCI/Qi
 Byox237ZWOF+p1Frn/AAvUbWe0ItliE4h2qjGB+yuLcpHzwQRFSp9IJ3tVUM6Hl3ax
 z0fa8bnJZZjCnqg5K/bio+7PUdOD3EVWM06U3nCA2hJNUMn20g8z2YdJNjx7JHNVAF
 VCspQwGXQDVMvhMhdI9epD26zPBhvYMW+co6O4uBSk32fEm4MPeTcDZmFkdIlw2gsR
 xba/81lqTiUKQ==
Received: from jupiter.universe (unknown [100.64.1.62])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519) (No client certificate requested)
 (Authenticated sender: sre)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id AB91817E092C;
 Fri, 31 Jul 2026 16:42:09 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
 id 0B18A480047; Fri, 31 Jul 2026 16:42:09 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Fri, 31 Jul 2026 16:42:15 +0200
Subject: [PATCH v8 10/21] drm/bridge: synopsys: dw-dp: Add follow-up bridge
 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-synopsys-dw-dp-improvements-v8-10-ac1e6a75782f@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2515;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=rrt5YOOAgulVloGhA8XYLb7XVQPmqKwIeo2+VJPjwtM=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGpstECb1PZQPHkTUx0coHpDEhRO5v68sVK7Y
 xlXtNAk2100hokCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJqbLRAAAoJENju1/PI
 O/qa47gP/2cAZf9HKtm/2zrGPQmMiKs1452MaG+YQ7iDQ/J0w3uIbSckJDW0bVkFtGEmOw3CSYc
 9jDj0jFAljkb3viMlQnTvYaoCRXC94fPk88n19MfqILfD1+0LlhZnEsi0ulzTp67gSWNtPrRder
 nYDOu5P+fAJtjTTbtiep0yV6gz58BL9HRPzDDz1KgsD6EIu0wMqFk2MFxW61NUvo2jquZo6WyLJ
 Ybm6nlwM8c4JCoc9paTDOq/fZsP0sMe9uxnT6SPiW+2wNYpALLFkIwB3EdZoJwL8XLJQPwoJSqD
 h2B1AhQ+gEs1fQrgDy4tBBt9RhW7KYmXHDCfqm6BDt75pEK1jbZbKOKB/raIkr5anZgLXgc6ip8
 REx8MGSff0EPL8zxhtecJUkpcF62o6axLsZnE2kveIzJ8duJZbYqydrt9PlmRiSzgdGX6wV4Plv
 yoveYAlhUVk2R6iq3oemJEmYveTY7xxKjK5KRCxFItT7pijzjl+gnZzxZFuDtxrwY2Nipk9wATS
 9ebnEs9RR84UnAEfrQFSMzO1r3A6xbEk5wORNpg8KmFKfzr9cobeKTBnZ4bsVHYAn1t2x8qeTrn
 r4zlZh9KgiYwItaWjdQLjsjMJ2hcp+Rv1+YwC/dxtgu6f9kfLKbjGr2oON7KdvT32M/Tpz5uOJS
 tUgET7ma0mfDVukWFNvUuig==
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

Add support to use USB-C connectors with the DP altmode helper code on
devicetree based platforms. To get this working there must be a DRM
bridge chain from the DisplayPort controller to the USB-C connector.
E.g. on Rockchip RK3576:

root@rk3576 # cat /sys/kernel/debug/dri/0/encoder-0/bridges
bridge[0]: dw_dp_bridge_funcs
        refcount: 7
        type: [10] DP
        OF: /soc/dp@27e40000:rockchip,rk3576-dp
        ops: [0x47] detect edid hpd
bridge[1]: drm_aux_bridge_funcs
        refcount: 4
        type: [0] Unknown
        OF: /soc/phy@2b010000:rockchip,rk3576-usbdp-phy
        ops: [0x0]
bridge[2]: drm_aux_hpd_bridge_funcs
        refcount: 5
        type: [10] DP
        OF: /soc/i2c@2ac50000/typec-portc@22/connector:usb-c-connector
        ops: [0x4] hpd

It's fine to fatally error out when there is no follow-up bridge
as the Rockchip Designware Displayport controller is the only
user of the bridge helper and has the port marked as required
in its binding.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-dp.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
index 42927335f0fd..7d42067df2cf 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
@@ -330,6 +330,8 @@ struct dw_dp {
 	struct dw_dp_plat_data plat_data;
 	u8 pixel_mode;
 
+	struct drm_bridge *next_bridge;
+
 	DECLARE_BITMAP(sdp_reg_bank, SDP_REG_BANK_SIZE);
 };
 
@@ -2037,13 +2039,31 @@ int dw_dp_bind(struct dw_dp *dp, struct drm_encoder *encoder)
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to attach bridge\n");
 
+	dp->next_bridge = of_drm_get_bridge_by_endpoint(dev->of_node, 1, 0);
+	if (IS_ERR(dp->next_bridge)) {
+		ret = PTR_ERR(dp->next_bridge);
+		return dev_err_probe(dev, ret, "failed to get follow-up bridge.\n");
+	}
+
+	ret = drm_bridge_attach(encoder, dp->next_bridge, bridge,
+				DRM_BRIDGE_ATTACH_NO_CONNECTOR);
+	if (ret) {
+		dev_err_probe(dev, ret, "Failed to attach next bridge\n");
+		goto put_next_bridge;
+	}
+
 	return 0;
+
+put_next_bridge:
+	drm_bridge_put(dp->next_bridge);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(dw_dp_bind);
 
 void dw_dp_unbind(struct dw_dp *dp)
 {
-	/* nothing to do */
+	drm_bridge_put(dp->next_bridge);
 }
 EXPORT_SYMBOL_GPL(dw_dp_unbind);
 

-- 
2.53.0

