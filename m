Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB9C0FEEF29
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 12:26:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A36610E408;
	Tue,  7 Apr 2026 12:26:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="yT4C2/At";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97B0610E408
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 12:26:27 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 7B0D94E4295E;
 Tue,  7 Apr 2026 12:26:26 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 4D74C603C7;
 Tue,  7 Apr 2026 12:26:26 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 4B82C1045020E; 
 Tue,  7 Apr 2026 14:26:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1775564783; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=AlG/dcUK00yA1Ez4jPZ5YroPlq5ftafDx5ata3ZpRRs=;
 b=yT4C2/AtKdT+ZXrbA+JVrInH4/6v4Eikg+Qfvq9VuhOGFXjFJSK7iLnfW0p9lyMfBKSVzA
 4jD5KwyT0x1P16h4YrfpKhBRdxz3XR+avXD4wXj4kSKli5onB/8i/wUZ+F4Lnn/PlVuk2+
 w3NWXh/EhqUgfgupcFkiTLyvzdoxuGqveoXcNir2bWRxlIorKCr+K1OtpoBFgR4b+spfv2
 K8oB6lhFsHjVX8lsjfkjTq/xV8qiWNufi3J0qFpSrA1YTLcoBY9Q/fgfp3WEUJ6rZmNqCR
 +evP7IJ06KajPjM9LGC244WXgvVzm8CiuAAZUDXsYROUY+QqvBQ1h5ggNG2v+A==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Tue, 07 Apr 2026 14:24:25 +0200
Subject: [PATCH v4 11/11] drm/mxsfb/lcdif: use
 DRM_BRIDGE_ATTACH_NO_CONNECTOR and the bridge-connector
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260407-drm-lcdif-dbanc-v4-11-247a16e61ef9@bootlin.com>
References: <20260407-drm-lcdif-dbanc-v4-0-247a16e61ef9@bootlin.com>
In-Reply-To: <20260407-drm-lcdif-dbanc-v4-0-247a16e61ef9@bootlin.com>
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

Based on the in-tree dts[i] files this introduces no regression. Based on
the kernel doc of drm_bridge_connector.c:

 * To make use of this helper, all bridges in the chain shall report bridge
 * operation flags (&drm_bridge->ops) and bridge output type
 * (&drm_bridge->type), as well as the DRM_BRIDGE_ATTACH_NO_CONNECTOR attach
 * flag (none of the bridges shall create a DRM connector directly).

and each of the 3 LCDIF blocks in the i.MX8MP, all of them comply with the
above requirement:

 * For the LCDIF3, the pipeline is:

   LCDIF3 -> fsl,imx8mp-hdmi-pvi -> fsl,imx8mp-hdmi-tx -> HDMI connector

   And the involved bridges are:

   * fsl,imx8mp-hdmi-pvi has ops = 0 (it doesn't set it) because it
     implements none the optional features mentioned by those flags, and it
     honors the DRM_BRIDGE_ATTACH_NO_CONNECTOR by propagating it

   * fsl,imx8mp-hdmi-tx is implemented based on dw-hdmi, which sets ops as
     appropriate and also propagates the DRM_BRIDGE_ATTACH_NO_CONNECTOR flag

   * display-connector (enabled via the DT overlay if needed) sets ops and
     makes DRM_BRIDGE_ATTACH_NO_CONNECTOR mandatory

 * The LCDIF2 involves the panel-bridge, display-connector and lvds-decoder
   (even though only the pane-bridge is surrently supported), amd all these
   three also set ops as needed and propagate
   DRM_BRIDGE_ATTACH_NO_CONNECTOR or make it mandatory.

 * The LCDIF1 is used with the adv7511, tc358767 and the panel bridge
   drivers which also comply with the requirements.

Tested-by: Martyn Welch <martyn.welch@collabora.com>
Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com> # TQMa8MPxL/MBa8MPxL
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

---

Changes in v4:
- enhance commit message to list all involved peripherals based on my dts
  review

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

