Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB037CA5FA5
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 10:37:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CB6310EE24;
	Tue, 29 Sep 2026 10:37:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="HcHZ/yEX";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AFC210EE24
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 10:37:00 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id B07851A1059;
 Tue, 29 Sep 2026 10:36:58 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 8237A601BD;
 Tue, 29 Sep 2026 10:36:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 24A22103295E3; 
 Tue, 29 Sep 2026 12:36:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1790678216; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=ZZa+gk1xSU87E90vuNj8MWoKLXAGcf4HT7mqh7DTZvU=;
 b=HcHZ/yEX0y7E/R4eLYri/8Prr889zeEqUolkRUUmUn5kGhl39HdVqBLC8bSIi62bnjYqz5
 cp4EEJl6hzscdE4OdsoTyh6Pa7r/W72cj45aI0cu52TeRj04MKLubTjd3wh5rRYafMCQzk
 COGUqU/I2TLpcSwwxhJuQySNiiUrqNdPYJNhMeuHgz10ioaAVJ70GkCRVigr4dCZZLosl6
 8hLdBTh2O3YyDKlRYKIz1Pxmz6537VudIAhCU7D3FoGRkwuQBB/iMsWJ7Aw/t4Wb0CPYPW
 qpct/PZ1nkwMBvJQtgC9oydIKlSChSGvj9gcHvzL3GIMwkdBJD3bm1S82l32Xg==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Tue, 29 Sep 2026 12:36:34 +0200
Subject: [PATCH 2/7] drm: verisilicon: stop using deprecated
 devm_drm_of_get_bridge()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-drm-fix-of_get_bridge-build-regression-v1-2-ccb7e602daad@bootlin.com>
References: <20260929-drm-fix-of_get_bridge-build-regression-v1-0-ccb7e602daad@bootlin.com>
In-Reply-To: <20260929-drm-fix-of_get_bridge-build-regression-v1-0-ccb7e602daad@bootlin.com>
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

Fixes build failure when CONFIG_OF is disabled.

Fixes: aa8a8c7e4641 ("drm/bridge: panel: move all code to drm_panel.c")
Reported-by: Arnd Bergmann <arnd@kernel.org>
Link: https://lore.kernel.org/r/20260928161605.2271412-1-arnd@kernel.org
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/gpu/drm/verisilicon/vs_bridge.c | 7 +++----
 drivers/gpu/drm/verisilicon/vs_bridge.h | 1 -
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/verisilicon/vs_bridge.c b/drivers/gpu/drm/verisilicon/vs_bridge.c
index dc7c85b07fe3..f1e8112f0ed2 100644
--- a/drivers/gpu/drm/verisilicon/vs_bridge.c
+++ b/drivers/gpu/drm/verisilicon/vs_bridge.c
@@ -29,7 +29,7 @@ static int vs_bridge_attach(struct drm_bridge *bridge,
 {
 	struct vs_bridge *vbridge = drm_bridge_to_vs_bridge(bridge);
 
-	return drm_bridge_attach(encoder, vbridge->next_bridge,
+	return drm_bridge_attach(encoder, vbridge->base.next_bridge,
 				 bridge, flags);
 }
 
@@ -303,8 +303,7 @@ struct vs_bridge *vs_bridge_init(struct drm_device *drm_dev,
 		return NULL;
 	}
 
-	next = devm_drm_of_get_bridge(drm_dev->dev, drm_dev->dev->of_node,
-				      output, intf);
+	next = of_drm_get_bridge_by_endpoint(drm_dev->dev->of_node, output, intf);
 	if (IS_ERR(next)) {
 		ret = PTR_ERR(next);
 		if (ret != -EPROBE_DEFER)
@@ -326,7 +325,7 @@ struct vs_bridge *vs_bridge_init(struct drm_device *drm_dev,
 
 	bridge->crtc = crtc;
 	bridge->intf = intf;
-	bridge->next_bridge = next;
+	bridge->base.next_bridge = next;
 
 	if (intf == VSDC_OUTPUT_INTERFACE_DPI)
 		enctype = DRM_MODE_ENCODER_DPI;
diff --git a/drivers/gpu/drm/verisilicon/vs_bridge.h b/drivers/gpu/drm/verisilicon/vs_bridge.h
index 70fee1749699..2b0ed94e4520 100644
--- a/drivers/gpu/drm/verisilicon/vs_bridge.h
+++ b/drivers/gpu/drm/verisilicon/vs_bridge.h
@@ -25,7 +25,6 @@ struct vs_bridge {
 	struct drm_connector *conn;
 
 	struct vs_crtc *crtc;
-	struct drm_bridge *next_bridge;
 	enum vs_bridge_output_interface intf;
 };
 

-- 
2.55.0

