Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EF0ECA5FA5
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 13:41:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E70E10EEDE;
	Tue, 29 Sep 2026 13:40:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="TvEnfhr4";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53EA210EEDE
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 13:40:57 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 22BE34E410B8;
 Tue, 29 Sep 2026 13:40:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id E8C1D601BD;
 Tue, 29 Sep 2026 13:40:55 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 01C0B10328354; 
 Tue, 29 Sep 2026 15:40:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1790689250; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=53MH9p9KsQnEH2oRW0dLdKIc6Yu/y/Sp7Zguh36Zgnk=;
 b=TvEnfhr4t6igcjamNAkj6qhRUV7KKh2aTtg3RdnMQuoOQA2iV1XqcsoIdnJJ/QxvGhMkuW
 9Ft3Vk2pduigyuKDvRzg7aFFqVkLH+MWX/Vnj4TlJWFska8w9diRihWDu//lbZPoN65DQP
 UZb8BQJRoWs0qwPLTBMAfmJAHx7eo8NqE+lxqpIl9shYn2YVTX12cKOQWHnYgL9h9yqCoP
 6p3vn4CdSH2rY5QwNqvrdUqXkft/Ahs9GTzwSt4KAShfQVXJJEDCLtJuqQNKsSofrrm6SE
 mwR1tzZRa/8qMgUM9DC2Wz0/eR4DmUghVEYRFAQ/M0gYyf4SvLsYzZzpuJz+xg==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Tue, 29 Sep 2026 15:39:55 +0200
Subject: [PATCH v2 6/7] drm/vc4: dsi: stop using deprecated
 drmm_of_get_bridge()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-drm-fix-of_get_bridge-build-regression-v2-6-6da431d8f180@bootlin.com>
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

drmm_of_get_bridge() is deprecated, switch to
of_drm_get_bridge_by_endpoint(). As of_drm_get_bridge_by_endpoint() returns
a refcounted bridge, ensure it is put by using bridge.next_bridge.

drm_panel.h becomes unused, drop the include.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/gpu/drm/vc4/vc4_dsi.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_dsi.c b/drivers/gpu/drm/vc4/vc4_dsi.c
index 0148f2befed1..30598738cfcf 100644
--- a/drivers/gpu/drm/vc4/vc4_dsi.c
+++ b/drivers/gpu/drm/vc4/vc4_dsi.c
@@ -35,7 +35,6 @@
 #include <drm/drm_edid.h>
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_of.h>
-#include <drm/drm_panel.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
 #include <drm/drm_simple_kms_helper.h>
@@ -555,7 +554,6 @@ struct vc4_dsi {
 
 	struct platform_device *pdev;
 
-	struct drm_bridge *out_bridge;
 	struct drm_bridge bridge;
 
 	void __iomem *regs;
@@ -1165,7 +1163,7 @@ static int vc4_dsi_bridge_attach(struct drm_bridge *bridge,
 	struct vc4_dsi *dsi = bridge_to_vc4_dsi(bridge);
 
 	/* Attach the panel or bridge to the dsi bridge */
-	return drm_bridge_attach(encoder, dsi->out_bridge,
+	return drm_bridge_attach(encoder, dsi->bridge.next_bridge,
 				 &dsi->bridge, flags);
 }
 
@@ -1749,9 +1747,9 @@ static int vc4_dsi_bind(struct device *dev, struct device *master, void *data)
 		return ret;
 	}
 
-	dsi->out_bridge = drmm_of_get_bridge(drm, dev->of_node, 0, 0);
-	if (IS_ERR(dsi->out_bridge))
-		return PTR_ERR(dsi->out_bridge);
+	dsi->bridge.next_bridge = of_drm_get_bridge_by_endpoint(dev->of_node, 0, 0);
+	if (IS_ERR(dsi->bridge.next_bridge))
+		return PTR_ERR(dsi->bridge.next_bridge);
 
 	/* The esc clock rate is supposed to always be 100Mhz. */
 	ret = clk_set_rate(dsi->escape_clock, 100 * 1000000);

-- 
2.55.0

