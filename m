Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AA04CA5FA5
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 13:40:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F05F10EED2;
	Tue, 29 Sep 2026 13:40:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="i3ZFWXZq";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03D1F10EEDE
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 13:40:40 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id CB26A1A1065;
 Tue, 29 Sep 2026 13:40:38 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 95BD2601BD;
 Tue, 29 Sep 2026 13:40:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 7006F10328354; 
 Tue, 29 Sep 2026 15:40:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1790689236; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=a2mAnH30tOLESjy5Nk7FCbi4j+awq6b8+7/1aE04H/E=;
 b=i3ZFWXZqMTVa12tLxSdYrUnRM2VYTxp6SX6rUjPHCRc2lDncRqeKhxMc69AUh/ku/OxFpi
 Da1t6YNr9WvDWoRgPQHHtd8XaGGznhNr7FIvKQqR6is+pugp11QMKDFsqKWjJgz8vW8wvW
 LJ1WdqQTOsRMQvzuVTjVuEAN09Vf1ZSS53EKFLeWlkeTXHdmfHIuS97WbBZYbbXUcyzTkE
 BRSUTGWTs+7BfvXzpdWxM6yFObbxCR1t3UNdr5jTxmisVo/KAIEZp9J58gQegBDfeKAB/y
 KmXtAoU4mranNk6h1E3jB/rcZ4R39Jfs8+a4Evd4NHbK92f/bU5LU5es2ynLvA==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Tue, 29 Sep 2026 15:39:53 +0200
Subject: [PATCH v2 4/7] drm/bridge: dw-mipi-dsi2: stop using deprecated
 devm_drm_of_get_bridge()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-drm-fix-of_get_bridge-build-regression-v2-4-6da431d8f180@bootlin.com>
References: <20260929-drm-fix-of_get_bridge-build-regression-v2-0-6da431d8f180@bootlin.com>
In-Reply-To: <20260929-drm-fix-of_get_bridge-build-regression-v2-0-6da431d8f180@bootlin.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Icenowy Zheng <zhengxingda@iscas.ac.cn>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Arnd Bergmann <arnd@kernel.org>, Doug Anderson <dianders@chromium.org>, 
 Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3
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

devm_drm_of_get_bridge() is deprecated, switch to
of_drm_get_bridge_by_endpoint(). As of_drm_get_bridge_by_endpoint() returns
a refcounted bridge, ensure it is put by using bridge.next_bridge.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

---

Changes in v2:
- fix bridge reference leak on attach error and detach paths
---
 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi2.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi2.c b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi2.c
index 7fd2f1e60654..eb7d5713bd28 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi2.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi2.c
@@ -192,7 +192,6 @@ struct cmd_header {
 struct dw_mipi_dsi2 {
 	struct drm_bridge bridge;
 	struct mipi_dsi_host dsi_host;
-	struct drm_bridge *panel_bridge;
 	struct device *dev;
 	struct regmap *regmap;
 	struct clk *pclk;
@@ -528,12 +527,12 @@ static int dw_mipi_dsi2_host_attach(struct mipi_dsi_host *host,
 	dsi2->format = device->format;
 	dsi2->mode_flags = device->mode_flags;
 
-	bridge = devm_drm_of_get_bridge(dsi2->dev, dsi2->dev->of_node, 1, 0);
+	bridge = of_drm_get_bridge_by_endpoint(dsi2->dev->of_node, 1, 0);
 	if (IS_ERR(bridge))
 		return PTR_ERR(bridge);
 
 	bridge->pre_enable_prev_first = true;
-	dsi2->panel_bridge = bridge;
+	dsi2->bridge.next_bridge = bridge;
 
 	drm_bridge_add(&dsi2->bridge);
 
@@ -547,6 +546,7 @@ static int dw_mipi_dsi2_host_attach(struct mipi_dsi_host *host,
 
 err_remove_bridge:
 	drm_bridge_remove(&dsi2->bridge);
+	drm_bridge_clear_and_put(&dsi2->bridge.next_bridge);
 	return ret;
 }
 
@@ -564,8 +564,7 @@ static int dw_mipi_dsi2_host_detach(struct mipi_dsi_host *host,
 	}
 
 	drm_bridge_remove(&dsi2->bridge);
-
-	drm_of_panel_bridge_remove(host->dev->of_node, 1, 0);
+	drm_bridge_clear_and_put(&dsi2->bridge.next_bridge);
 
 	return 0;
 }
@@ -884,7 +883,7 @@ static int dw_mipi_dsi2_bridge_attach(struct drm_bridge *bridge,
 	encoder->encoder_type = DRM_MODE_ENCODER_DSI;
 
 	/* Attach the panel-bridge to the dsi bridge */
-	return drm_bridge_attach(encoder, dsi2->panel_bridge, bridge,
+	return drm_bridge_attach(encoder, dsi2->bridge.next_bridge, bridge,
 				 flags);
 }
 

-- 
2.55.0

