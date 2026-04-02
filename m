Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56375D39403
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 09:29:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B54210F0E0;
	Thu,  2 Apr 2026 09:29:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="OZGQ6oD6";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4C5B10F0D9
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Apr 2026 09:29:40 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id BDB3C4E428AF;
 Thu,  2 Apr 2026 09:29:39 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 8A1B05FDEB;
 Thu,  2 Apr 2026 09:29:39 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id B197A104511F1; 
 Thu,  2 Apr 2026 11:29:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1775122176; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=RWUsNAX4qkcAdj0Wcj9Oo2se6gzwrm1zu3SjMpebEPg=;
 b=OZGQ6oD6EU8Zs5LJVlj3e/KmgME6+PZOYfQXqFJHgC7xxHJIQkrL85tWduXD2/1tYPVsnE
 zJcse1//4PtucQREZIF9n0GfidQU0ZTFvGISKF5BuYN7iVjTpXvUtFOrGSXprEhDqdjdEC
 WNHfqas7dZiOQWfAVwKe33lvJeGx/4b4Msz0SgtOdwAeCb5BqXPGy8zlpVovW3onAjtrnC
 hsOr9Y0nMUS+a73uZfaW8pARKlgBDJT1+KyD3dfGwcJJmjejH0/cG0/JU/aunkeEAM6t02
 KQ/dhAgY484m42SlGauX1/cYxWtz3q3SeoQY7bVBflLXBAn0k9h/8TV0ralnJg==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Thu, 02 Apr 2026 11:26:06 +0200
Subject: [PATCH v3 11/11] drm/mxsfb/lcdif: use
 DRM_BRIDGE_ATTACH_NO_CONNECTOR and the bridge-connector
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260402-drm-lcdif-dbanc-v3-11-27cd247a0847@bootlin.com>
References: <20260402-drm-lcdif-dbanc-v3-0-27cd247a0847@bootlin.com>
In-Reply-To: <20260402-drm-lcdif-dbanc-v3-0-27cd247a0847@bootlin.com>
To: Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Liu Ying <victor.liu@nxp.com>, Rob Herring <robh@kernel.org>, 
 Saravana Kannan <saravanak@kernel.org>
Cc: Damon Ding <damon.ding@rock-chips.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 =?utf-8?q?Herv=C3=A9_Codina?= <herve.codina@bootlin.com>, 
 Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Adam Ford <aford173@gmail.com>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>, 
 Christopher Obbard <christopher.obbard@linaro.org>, 
 Daniel Scally <dan.scally@ideasonboard.com>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
 Fabio Estevam <festevam@denx.de>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Gilles Talis <gilles.talis@gmail.com>, 
 =?utf-8?q?Goran_Ra=C4=91enovi=C4=87?= <goran.radni@gmail.com>, 
 Heiko Schocher <hs@denx.de>, Josua Mayer <josua@solid-run.com>, 
 Kieran Bingham <kieran.bingham@ideasonboard.com>, 
 Marco Felsch <m.felsch@pengutronix.de>, 
 Martyn Welch <martyn.welch@collabora.com>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, Peng Fan <peng.fan@nxp.com>, 
 Richard Hu <richard.hu@technexion.com>, 
 Shengjiu Wang <shengjiu.wang@nxp.com>, 
 Stefan Eichenberger <stefan.eichenberger@toradex.com>, 
 Vitor Soares <vitor.soares@toradex.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.15.1
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

Convert this driver to DRM_BRIDGE_ATTACH_NO_CONNECTOR and to the
drm_bridge_connector framework which is the current DRM bridge best
practice.

Tested-by: Martyn Welch <martyn.welch@collabora.com>
Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com> # TQMa8MPxL/MBa8MPxL
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

---

Changes in v2:
- Added missing select DRM_DISPLAY_HELPER in Kconfig
- Rebased on previous patch changes
---
 drivers/gpu/drm/mxsfb/Kconfig     |  2 ++
 drivers/gpu/drm/mxsfb/lcdif_drv.c | 16 +++++++++++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mxsfb/Kconfig b/drivers/gpu/drm/mxsfb/Kconfig
index 264e74f45554..31db7a824a93 100644
--- a/drivers/gpu/drm/mxsfb/Kconfig
+++ b/drivers/gpu/drm/mxsfb/Kconfig
@@ -33,6 +33,8 @@ config DRM_IMX_LCDIF
 	select DRM_GEM_DMA_HELPER
 	select DRM_PANEL
 	select DRM_PANEL_BRIDGE
+	select DRM_DISPLAY_HELPER
+	select DRM_BRIDGE_CONNECTOR
 	help
 	  Choose this option if you have an LCDIFv3 LCD controller.
 	  Those devices are found in various i.MX SoC (i.MX8MP,
diff --git a/drivers/gpu/drm/mxsfb/lcdif_drv.c b/drivers/gpu/drm/mxsfb/lcdif_drv.c
index c8ba8f9b1da8..7f07ae24e0dc 100644
--- a/drivers/gpu/drm/mxsfb/lcdif_drv.c
+++ b/drivers/gpu/drm/mxsfb/lcdif_drv.c
@@ -18,6 +18,7 @@
 #include <drm/clients/drm_client_setup.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_bridge.h>
+#include <drm/drm_bridge_connector.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_encoder.h>
 #include <drm/drm_fbdev_dma.h>
@@ -57,6 +58,7 @@ static int lcdif_attach_bridge(struct lcdif_drm_private *lcdif)
 		struct of_endpoint of_ep;
 		struct drm_bridge *bridge;
 		struct drm_encoder *encoder;
+		struct drm_connector *connector;
 		int ret;
 
 		if (!of_device_is_available(remote))
@@ -86,11 +88,23 @@ static int lcdif_attach_bridge(struct lcdif_drm_private *lcdif)
 					     "Failed to initialize encoder for endpoint%u\n",
 					     of_ep.id);
 
-		ret = drm_bridge_attach(encoder, bridge, NULL, 0);
+		ret = drm_bridge_attach(encoder, bridge, NULL, DRM_BRIDGE_ATTACH_NO_CONNECTOR);
 		if (ret)
 			return dev_err_probe(dev, ret,
 					     "Failed to attach bridge for endpoint%u\n",
 					     of_ep.id);
+
+		connector = drm_bridge_connector_init(lcdif->drm, encoder);
+		if (IS_ERR(connector))
+			return dev_err_probe(dev, PTR_ERR(connector),
+					     "Failed to init bridge_connector for endpoint%u\n",
+					     of_ep.id);
+
+		ret = drm_connector_attach_encoder(connector, encoder);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "Failed to attach connector for endpoint%u\n",
+					     of_ep.id);
 	}
 
 	return 0;

-- 
2.53.0

