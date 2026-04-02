Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98D32D39403
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 09:28:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 026CC10F206;
	Thu,  2 Apr 2026 09:28:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="gfh4Rf9k";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0414F10F204
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Apr 2026 09:28:50 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id DE4414E428AF;
 Thu,  2 Apr 2026 09:28:48 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id A94E65FDEB;
 Thu,  2 Apr 2026 09:28:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 69D6810451269; 
 Thu,  2 Apr 2026 11:28:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1775122126; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=+OKVbnh4D/eet/8za6HYYuOE7r3CKZI7MjkoaZhFD+M=;
 b=gfh4Rf9kOlkm0cnjFhVPxI4iXOBekB0zFv6omI9j0x9T4DOq3T9Qg76VTTRSW20XmfFKZZ
 kZbmLA18mQMo1DQeZl+Q2hroRsDCGD2PjtuWLBuBrtR7Vc3aibiNNNlFNuh5cEHldL2rJ3
 NRmemYC6aP3p6e7yLz79V0Buhpb9O2SDlj8FWioT273yi65yo4/Y2Ttd2GnFEXpqxiPmQ4
 GBALxjJnsLFQKspLnjKd+TrIkr6dn/7pC7yZpn0wtgHwEB1ZnhtNihWLFSmII+piEsnkNX
 FF0B1Sqt9npi9tnryVgugD/exHMgjFEF6JrQCjTiAv7c5UrMK99HJHxwnNFbnw==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Thu, 02 Apr 2026 11:26:01 +0200
Subject: [PATCH v3 06/11] drm/bridge: dw-hdmi: warn on unsupported attach
 combination
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260402-drm-lcdif-dbanc-v3-6-27cd247a0847@bootlin.com>
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

dw-hdmi can operate in two different modes, depending on the platform data
as set by the driver:

 A. hdmi->plat_data->output_port = 0:
    the HDMI output (port@1) in device tree is not used

 B. hdmi->plat_data->output_port = 1:
    the HDMI output (port@1) is parsed to find the next bridge

Only case B is supported when the DRM_BRIDGE_ATTACH_NO_CONNECTOR flag is
passed to the attach callback. Emit a warning when this is violated. Also
return -EINVAL which would be returned by drm_bridge_attach() right after
anyway.

Reviewed-by: Liu Ying <victor.liu@nxp.com>
Tested-by: Martyn Welch <martyn.welch@collabora.com>
Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com> # TQMa8MPxL/MBa8MPxL
Tested-by: Damon Ding <damon.ding@rock-chips.com> # rk3399
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
Note: Returning when the warning triggers does not change the functional
behaviour of this function. It is not strictly necessary in this patch but
it will have to be done anyway in the following patch.
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index 0296e110ce65..ab1a6a8783cd 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -2910,6 +2910,10 @@ static int dw_hdmi_bridge_attach(struct drm_bridge *bridge,
 {
 	struct dw_hdmi *hdmi = bridge->driver_private;
 
+	/* DRM_BRIDGE_ATTACH_NO_CONNECTOR requires a remote-endpoint to the next bridge */
+	if (WARN_ON((flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR) && !hdmi->plat_data->output_port))
+		return -EINVAL;
+
 	if (flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR)
 		return drm_bridge_attach(encoder, hdmi->bridge.next_bridge,
 					 bridge, flags);

-- 
2.53.0

