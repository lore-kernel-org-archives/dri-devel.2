Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66EAE108B8F1
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 10:47:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C24FC10EA75;
	Fri, 20 Mar 2026 10:47:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="b0usys/h";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97EF210EA75
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 10:47:09 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 897421A2F0E;
 Fri, 20 Mar 2026 10:47:08 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 5C00C601A0;
 Fri, 20 Mar 2026 10:47:08 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 4215310450B9C; Fri, 20 Mar 2026 11:46:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1774003625; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=uqivpiK0EZCZ1GJzIO6qlD0UY/zTX2jimlhOlJX9+J8=;
 b=b0usys/hnRS2Fr9NfUVkW6SirYB8SXTdJjTxeH9MM7GK4qT2fXIU3RFMZbWCK0ZoGW5zLo
 oN+2nl4hoV9mgyOKb3anTMfGFYXucRrfsJprsxnNSH2U4xaFfS8vNxUe48cOBI+BP1Y+DT
 E1DVv8d3lYXpeik3x7rqaHbQ0o+f3AG2r07ukYuEe5Ohs8Ax/3U4KuVfiuCT0f9HjzAoN6
 als/m0eQya/PgWGchzytujlX9enQAxkDRCx17CILGjWOJUN+9/wZ2/5vYmYyWaEHCRAMhm
 4XEDoFZl5NnnBeQ4a6FKLJZNBMfFduE7Linncvc47zw2GUbAzoBBRCjOmuX+VA==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Fri, 20 Mar 2026 11:46:14 +0100
Subject: [PATCH 3/8] drm/mxsfb/lcdif: use dev_err_probe() consistently in
 lcdif_attach_bridge
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260320-drm-lcdif-dbanc-v1-3-479a04133e70@bootlin.com>
References: <20260320-drm-lcdif-dbanc-v1-0-479a04133e70@bootlin.com>
In-Reply-To: <20260320-drm-lcdif-dbanc-v1-0-479a04133e70@bootlin.com>
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
Cc: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 =?utf-8?q?Herv=C3=A9_Codina?= <herve.codina@bootlin.com>, 
 Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Adam Ford <aford173@gmail.com>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>, 
 Anson Huang <Anson.Huang@nxp.com>, 
 Christopher Obbard <christopher.obbard@linaro.org>, 
 Daniel Scally <dan.scally@ideasonboard.com>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
 Fabio Estevam <festevam@denx.de>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Gilles Talis <gilles.talis@gmail.com>, 
 =?utf-8?q?Goran_Ra=C4=91enovi=C4=87?= <goran.radni@gmail.com>, 
 Heiko Schocher <hs@denx.de>, 
 Joao Paulo Goncalves <joao.goncalves@toradex.com>, 
 Josua Mayer <josua@solid-run.com>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Kieran Bingham <kieran.bingham@ideasonboard.com>, 
 Marco Felsch <m.felsch@pengutronix.de>, 
 Martyn Welch <martyn.welch@collabora.com>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, Peng Fan <peng.fan@nxp.com>, 
 Philippe Schenker <philippe.schenker@toradex.com>, 
 Richard Hu <richard.hu@technexion.com>, 
 Shengjiu Wang <shengjiu.wang@nxp.com>, 
 Stefan Eichenberger <stefan.eichenberger@toradex.com>, 
 Vitor Soares <vitor.soares@toradex.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.14.3
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

lcdif_attach_bridge() uses dev_err_probe() in some error paths, dev_err() +
return in others. Use dev_err_probe() for all of them to make code
consistent and simpler.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/gpu/drm/mxsfb/lcdif_drv.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/mxsfb/lcdif_drv.c b/drivers/gpu/drm/mxsfb/lcdif_drv.c
index 83e134c04882..e40253ad607b 100644
--- a/drivers/gpu/drm/mxsfb/lcdif_drv.c
+++ b/drivers/gpu/drm/mxsfb/lcdif_drv.c
@@ -63,18 +63,14 @@ static int lcdif_attach_bridge(struct lcdif_drm_private *lcdif)
 		return dev_err_probe(dev, PTR_ERR(bridge), "Failed to get bridge\n");
 
 	encoder = devm_kzalloc(dev, sizeof(*encoder), GFP_KERNEL);
-	if (!encoder) {
-		dev_err(dev, "Failed to allocate encoder\n");
-		return -ENOMEM;
-	}
+	if (!encoder)
+		return dev_err_probe(dev, -ENOMEM, "Failed to allocate encoder\n");
 
 	encoder->possible_crtcs = drm_crtc_mask(&lcdif->crtc);
 	ret = drm_encoder_init(lcdif->drm, encoder, &lcdif_encoder_funcs,
 			       DRM_MODE_ENCODER_NONE, NULL);
-	if (ret) {
-		dev_err(dev, "Failed to initialize encoder: %d\n", ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to initialize encoder\n");
 
 	ret = drm_bridge_attach(encoder, bridge, NULL, 0);
 	if (ret)

-- 
2.53.0

