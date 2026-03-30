Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0B101061B1B
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 19:27:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1527910E7A8;
	Mon, 30 Mar 2026 19:27:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="JBxF/xwy";
	dkim-atps=neutral
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 999D610E7A8
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 19:27:06 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 06A54C4042D;
 Mon, 30 Mar 2026 19:27:34 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id C1AE35FFA8;
 Mon, 30 Mar 2026 19:27:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 1627810450B50; 
 Mon, 30 Mar 2026 21:26:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1774898820; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=jXjz4tZtuVEq+hWrmCAUagtFbybLj/9NWSGKn/xDMdU=;
 b=JBxF/xwyqBirTzI8n8ol6nz+o9gkOandjrcg/frbHTeby7fDWUjHok3DXcCOiImGk6zg6l
 p/OM7nRKrKDxCZa3v15dqNhpRqETfCvVbRIC/wDyrk4B5mwFoTpqpFBghryyudcxREO7oh
 jzswn3cu66i4wfKXiCxr5A7d2CvgZsfJMpHF9rHyjZVtXmqnA+9YmHMl88sJLYk717l6vD
 II4+eiaO5+Z1yzvskP6KT/TNs1sfFXQ1sbxe+TvCl04FWnpcO0t1jl/p9qtLPv8vEOBMLD
 3x6oWuLVoynrKX8q9IAYkqaKbIreGbnBbvgTHWoSW/3+PzlE3ZMLPrRbjoOaaQ==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Mon, 30 Mar 2026 21:25:44 +0200
Subject: [PATCH v2 03/10] drm/mxsfb/lcdif: use dev_err_probe() consistently
 in lcdif_attach_bridge
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260330-drm-lcdif-dbanc-v2-3-c7f2af536a24@bootlin.com>
References: <20260330-drm-lcdif-dbanc-v2-0-c7f2af536a24@bootlin.com>
In-Reply-To: <20260330-drm-lcdif-dbanc-v2-0-c7f2af536a24@bootlin.com>
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

lcdif_attach_bridge() uses dev_err_probe() in some error paths, dev_err() +
return in others. Use dev_err_probe() for all of them to make code
consistent, simpler and with bettere error reporting.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

---

Changes in v2:
- rewrote after removal of previous patch removing loop
- not added review/test trailers as the code is a bit different
---
 drivers/gpu/drm/mxsfb/lcdif_drv.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/mxsfb/lcdif_drv.c b/drivers/gpu/drm/mxsfb/lcdif_drv.c
index 8da8a265c05c..1c76709c4d94 100644
--- a/drivers/gpu/drm/mxsfb/lcdif_drv.c
+++ b/drivers/gpu/drm/mxsfb/lcdif_drv.c
@@ -63,10 +63,8 @@ static int lcdif_attach_bridge(struct lcdif_drm_private *lcdif)
 			continue;
 
 		ret = of_graph_parse_endpoint(ep, &of_ep);
-		if (ret < 0) {
-			dev_err(dev, "Failed to parse endpoint %pOF\n", ep);
-			return ret;
-		}
+		if (ret < 0)
+			return dev_err_probe(dev, ret, "Failed to parse endpoint %pOF\n", ep);
 
 		bridge = devm_drm_of_get_bridge(dev, dev->of_node, 0, of_ep.id);
 		if (IS_ERR(bridge))
@@ -75,20 +73,18 @@ static int lcdif_attach_bridge(struct lcdif_drm_private *lcdif)
 					     of_ep.id);
 
 		encoder = devm_kzalloc(dev, sizeof(*encoder), GFP_KERNEL);
-		if (!encoder) {
-			dev_err(dev, "Failed to allocate encoder for endpoint%u\n",
-				of_ep.id);
-			return -ENOMEM;
-		}
+		if (!encoder)
+			return dev_err_probe(dev, -ENOMEM,
+					     "Failed to allocate encoder for endpoint%u\n",
+					     of_ep.id);
 
 		encoder->possible_crtcs = drm_crtc_mask(&lcdif->crtc);
 		ret = drm_encoder_init(lcdif->drm, encoder, &lcdif_encoder_funcs,
 				       DRM_MODE_ENCODER_NONE, NULL);
-		if (ret) {
-			dev_err(dev, "Failed to initialize encoder for endpoint%u: %d\n",
-				of_ep.id, ret);
-			return ret;
-		}
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "Failed to initialize encoder for endpoint%u\n",
+					     of_ep.id);
 
 		ret = drm_bridge_attach(encoder, bridge, NULL, 0);
 		if (ret)

-- 
2.53.0

