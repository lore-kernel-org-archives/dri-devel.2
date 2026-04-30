Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35341CD13D2
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 22:20:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 735EC10E495;
	Thu, 30 Apr 2026 22:20:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="fB2UmN0R";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9800B10E495
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 22:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1777587637;
 bh=jWWdxoAr7kMuTAhnw7bDZpM00SQYOvDz25/7MfyrqZc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=fB2UmN0RkdD17aFgrOrSniJh+hpFPJ5VF+cIYMWge40eB9glM9/J2kvNYUWOe8DDe
 f3jEb6cIoEsJbpIdbMweycP6arLc412FFxi5XDrJiiX+kDsKrwXdckooWItjdrBJdd
 s3tfU9m5E0LIduddmG7jyPlnt0PaET1gczQm1e8TbN8mtzq4TMvkx5kptQ/MwI5bNk
 MuAxHGyMiEJFRSxccMnJucRDxCKB0B2MnoYwpcEWFppCLja6frRnJc8Q/VSzgtkbD9
 i/WVxKYdleBvzvJFnugCYyY5MENJ4KbXcQuea/sX9daISrusiBcIy3TPx6Degz2Dur
 XQJoxloxVi5SQ==
Received: from jupiter.universe (unknown [100.64.1.62])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested) (Authenticated sender: sre)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id B0A4217E157E;
 Fri,  1 May 2026 00:20:37 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
 id 157C2480038; Fri, 01 May 2026 00:20:37 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Fri, 01 May 2026 00:20:32 +0200
Subject: [PATCH v2 05/12] drm/bridge: synopsys: dw-dp: Add follow-up bridge
 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260501-synopsys-dw-dp-improvements-v2-5-d7e7f6bac77f@collabora.com>
References: <20260501-synopsys-dw-dp-improvements-v2-0-d7e7f6bac77f@collabora.com>
In-Reply-To: <20260501-synopsys-dw-dp-improvements-v2-0-d7e7f6bac77f@collabora.com>
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
 Alexey Charkov <alchark@gmail.com>, dri-devel@lists.freedesktop.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, kernel@collabora.com, 
 linux-arm-kernel@lists.infradead.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2142;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=jWWdxoAr7kMuTAhnw7bDZpM00SQYOvDz25/7MfyrqZc=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGnz1bTQsb9vG0AQ72XiT7okzCgQzKb3rRkNV
 wvTDjDaOyah7IkCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJp89W0AAoJENju1/PI
 O/qaBCwP/RmumpuXZh6J0Dzcy/NkNy/U9JB1aBBxqqjKCfK7sGotqh3U+i21ylt+w+GqJPcCLjc
 dK+9TwypW8cCIFclnx1rUpD1otkICHtT0NNQEPpzJ+XWIsVCUtgGTHjmlfU7IyxVp7EfUeI7S2d
 0D3oSKeGrqQ2ryjYluMlcwNLbTP3jUsb9OdE/P9Gt7ZGw6hEdn70ovQC5WyW7F8uYNpPHdyN05b
 6JEJPya9di/F5AV2xMhIrejhm+LICtvjuY18dLuHbN756ifjLpf8uckAQ7qR1z7Zlupp2bnow5U
 pwJ7zw0AGLxpB/I7h4y7zuZPUwHCwK0BGxX3X45A3OPgAMH6KxQ1vX59jYcDwKoi8N0giaNSQEY
 0YI+09Wm8LLk0KsL2kZGMskNdC4cU+YFQl7EMuv2DgYD3+pQu1h4U4A8s9LkxUJo0xHYIhTdqSh
 i8wqEdl1ZLriPAjsEnDsn8b7Jpfci8sHpcZRrV7cmKXhGVtjUADIwtEPCQIhQfu0Q2c3AsIelk5
 sAOPFRfNuyJrkruLkDTnRYWhAwUXJ45L5Lmhooynt60fuxJM3H4BtEmY+UaIaJV+8iQWfQJX4yL
 3+kbIe+jnP00ZGugsMc6LEbovq34Ik/kIkYnA1g3huNgZvAh1f5luXGcSTWaFNo99ijf4M0k1X7
 W9kcP7f/d8DIghFVTWf4wEw==
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

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-dp.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
index fc4ddb7792d7..ccc55e40e81c 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
@@ -1970,7 +1970,7 @@ struct dw_dp *dw_dp_bind(struct device *dev, struct drm_encoder *encoder,
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct dw_dp *dp;
-	struct drm_bridge *bridge;
+	struct drm_bridge *bridge, *next_bridge;
 	void __iomem *res;
 	int ret;
 
@@ -2064,6 +2064,20 @@ struct dw_dp *dw_dp_bind(struct device *dev, struct drm_encoder *encoder,
 		goto unregister_aux;
 	}
 
+	next_bridge = devm_drm_of_get_bridge(dev, dev->of_node, 1, 0);
+	if (IS_ERR(next_bridge)) {
+		ret = PTR_ERR(next_bridge);
+		dev_err_probe(dev, ret, "failed to get follow-up bridge.\n");
+		goto unregister_aux;
+	}
+
+	ret = drm_bridge_attach(encoder, next_bridge, bridge,
+				DRM_BRIDGE_ATTACH_NO_CONNECTOR);
+	if (ret) {
+		dev_err_probe(dev, ret, "Failed to attach next bridge\n");
+		goto unregister_aux;
+	}
+
 	dw_dp_init_hw(dp);
 
 	ret = phy_init(dp->phy);

-- 
2.53.0

