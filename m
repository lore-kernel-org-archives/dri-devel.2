Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45BD7CD4851
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 10:38:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4F6910EC26;
	Tue, 19 May 2026 10:38:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="hVK9PFdC";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 880FB10EC26
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 10:38:54 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 79FC11A3619;
 Tue, 19 May 2026 10:38:53 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 4C791606E9;
 Tue, 19 May 2026 10:38:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 08D0B107E8AD3; 
 Tue, 19 May 2026 12:38:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1779187131; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=f8PX3xqkM3heELg2F4nk1n3EZygfl3IAuY8PxbEGuV8=;
 b=hVK9PFdCFanPiC++87SKl4nRw4HidvStVJOu7ExZ13QI0X1ADjMwDSo5cskAGsbtTTuD5f
 x5vdeQb0pA9gzASKtJIO1aF+bdcgw9JHF0aUWz/iYFMg2RK0uvJei1tk1gMUo8+VceDpOw
 jKf8FeZTIHUTY/R3TRwSe1C5EBmZlOPq5AryjSrXfoB1Pm+nO+lH0EknflBYVBoLEvgkzb
 qheTh7C8sYPnbu6d3KvjGxYM3Gb3m9Up8DRNmVpcwf72nHtCaukRsT/p0C0Hk2TNsPIQ62
 9UslQ35QoYXaQImhYCIldCD1bUwZkM9G3y1pUU0+bOG1Fxbgg9CScMFTUmhNUg==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Tue, 19 May 2026 12:37:28 +0200
Subject: [PATCH 11/37] drm/display: bridge-connector: return int from
 drm_bridge_connector_add_connector()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-drm-bridge-hotplug-v1-11-45e2bdb3dfb4@bootlin.com>
References: <20260519-drm-bridge-hotplug-v1-0-45e2bdb3dfb4@bootlin.com>
In-Reply-To: <20260519-drm-bridge-hotplug-v1-0-45e2bdb3dfb4@bootlin.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Inki Dae <inki.dae@samsung.com>, Jagan Teki <jagan@amarulasolutions.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, Marek Vasut <marex@denx.de>, 
 Stefan Agner <stefan@agner.ch>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.15.2
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

This function returns a struct drm_bridge_connector * because this was the
case in the origin of its code. In current code it does not make sense: it
can only return either the same pointer it received as input or a negative
ERR_PTR.

This forces users to an unnecessarily complex error management code.

Clean up error management by just returning an int (0 or negative error).

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/gpu/drm/display/drm_bridge_connector.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu/drm/display/drm_bridge_connector.c
index 6066ca0c5624..982bc64d8361 100644
--- a/drivers/gpu/drm/display/drm_bridge_connector.c
+++ b/drivers/gpu/drm/display/drm_bridge_connector.c
@@ -991,11 +991,9 @@ static int drm_bridge_connector_init_hdmi_audio_cec(struct drm_bridge_connector
  * @bridge_connector->drm and @bridge_connector->encoder fields are
  * assigned at least)
  *
- * Returns a pointer to @bridge_connector on success, or a negative error
- * pointer otherwise.
+ * Returns 0 on success or a negative error otherwise.
  */
-static struct drm_bridge_connector *
-drm_bridge_connector_add_connector(struct drm_bridge_connector *bridge_connector)
+static int drm_bridge_connector_add_connector(struct drm_bridge_connector *bridge_connector)
 {
 	struct drm_connector *connector;
 	struct i2c_adapter *ddc = NULL;
@@ -1012,7 +1010,7 @@ drm_bridge_connector_add_connector(struct drm_bridge_connector *bridge_connector
 					       &supported_formats, &max_bpc, &ddc,
 					       &panel_bridge, &support_hdcp);
 	if (ret)
-		return ERR_PTR(ret);
+		return ret;
 
 	if (bridge_connector->bridge_hdmi) {
 		if (!connector->ycbcr_420_allowed)
@@ -1041,18 +1039,18 @@ drm_bridge_connector_add_connector(struct drm_bridge_connector *bridge_connector
 					       supported_formats,
 					       max_bpc);
 		if (ret)
-			return ERR_PTR(ret);
+			return ret;
 	} else {
 		ret = drmm_connector_init(bridge_connector->drm, connector,
 					  &drm_bridge_connector_funcs,
 					  connector_type, ddc);
 		if (ret)
-			return ERR_PTR(ret);
+			return ret;
 	}
 
 	ret = drm_bridge_connector_init_hdmi_audio_cec(bridge_connector);
 	if (ret)
-		return ERR_PTR(ret);
+		return ret;
 
 	drm_connector_helper_add(connector, &drm_bridge_connector_helper_funcs);
 
@@ -1071,9 +1069,9 @@ drm_bridge_connector_add_connector(struct drm_bridge_connector *bridge_connector
 
 	ret = drm_connector_attach_encoder(connector, bridge_connector->encoder);
 	if (ret)
-		return ERR_PTR(ret);
+		return ret;
 
-	return bridge_connector;
+	return 0;
 }
 
 /**
@@ -1110,9 +1108,9 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 	bridge_connector->drm = drm;
 	bridge_connector->encoder = encoder;
 
-	bridge_connector = drm_bridge_connector_add_connector(bridge_connector);
-	if (IS_ERR(bridge_connector))
-		return ERR_CAST(bridge_connector);
+	ret = drm_bridge_connector_add_connector(bridge_connector);
+	if (ret)
+		return ERR_PTR(ret);
 
 	return &bridge_connector->base;
 }

-- 
2.54.0

