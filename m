Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B6EBD39403
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 09:29:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB3BF10F207;
	Thu,  2 Apr 2026 09:29:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="Wguvos85";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11A9310F207
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Apr 2026 09:29:20 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id ECE5D4E428B0;
 Thu,  2 Apr 2026 09:29:18 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id BDC045FDEB;
 Thu,  2 Apr 2026 09:29:18 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 5FEF410450A10; 
 Thu,  2 Apr 2026 11:29:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1775122155; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=X+H+4X9YO3ipcewDk33OUw1syajC8W/mpHu58zrzCFo=;
 b=Wguvos85FtP7hFlO1w79zsU2QzeInIa49kEb9DKt3uykgHq+0Lbq4Ab2fEzROzjsDVmwwY
 jdIT/tSPgkvwZ20u5bRSe/XbdMCPxGacdcE5nWJD9WCG4D5E0b9gtmaqwl7uKcH/6JysZ3
 CvFEpU/zQVYz2unYTGxEBq8iNL7XHvHVGp5f5O38NItiGSp4gMqbmmJi9Rl+denoyyLoJz
 ftvbPVEhEHM6twxCctx0OeOQvIIvCLjbiZfQzwnyEro4HoNMgazRNTVHnSAtuerafFSEYo
 ynRy2jkLpRtaqRJOpkmZ3dlM0sEd7f/H4ICTaCU7dpoC1mBf/Upy+XUBZMLl2Q==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Thu, 02 Apr 2026 11:26:04 +0200
Subject: [PATCH v3 09/11] drm/bridge: imx8mp-hdmi-tx-connector-fixup: show
 a warning when adding the overlay
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260402-drm-lcdif-dbanc-v3-9-27cd247a0847@bootlin.com>
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

Describing the HDMI connector in device tree is recommended. While the
overlay insertion is a workaround to avoid breaking existing devices, every
dts should be improved by adding a connector description.

Add a warning to make users aware as far as possible.

As a warning line cannot hold all the relevant info, add a detailed comment
in the code so it easy to find when the warning is seen.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

---

Patch added in v3. Kept as a separate comment w.r.t. the patch adding the
overlay to let it be added in a later moment in case we want to convert
existing dts files before adding the warning.
---
 .../gpu/drm/bridge/imx/imx8mp-hdmi-tx-connector-fixup.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx-connector-fixup.c b/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx-connector-fixup.c
index dc1736bfc3ac..f6190d86abd0 100644
--- a/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx-connector-fixup.c
+++ b/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx-connector-fixup.c
@@ -44,6 +44,23 @@ static int __init imx8mp_hdmi_tx_connector_fixup_init(void)
 	if (endpoint)
 		return 0;
 
+	/*
+	 * Boards with an HDMI connector should describe it in a device
+	 * tree node with compatible = "hdmi-connector".
+	 *
+	 * If you see this warning, it means such a node was not found and
+	 * a fallback one is added using a device tree overlay. Please add
+	 * one in your device tree, also describing the exact connector
+	 * type (the added overlay assumes Type A as a fallback, but it
+	 * might be wrong).
+	 *
+	 * This node is necessary for modern DRM, where bridge drivers do
+	 * not create a connector (see the DRM_BRIDGE_ATTACH_NO_CONNECTOR
+	 * flag). See https://docs.kernel.org/gpu/drm-kms-helpers.html for
+	 * more info.
+	 */
+	pr_warn("Please add a hdmi-connector DT node for imx8mp-hdmi-tx.");
+
 	dtbo_start = __dtbo_imx8mp_hdmi_tx_connector_fixup_begin;
 	dtbo_size = __dtbo_imx8mp_hdmi_tx_connector_fixup_end -
 		    __dtbo_imx8mp_hdmi_tx_connector_fixup_begin;

-- 
2.53.0

