Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D1060A2629
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 16:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=ICktNj0O
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBE2D10FE90;
	Wed, 18 Nov 2026 16:52:37 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C3B710FE7A
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 16:52:25 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 0A046C4F77B;
 Wed, 18 Nov 2026 16:52:29 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 228145FE9B;
 Wed, 18 Nov 2026 16:52:24 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id BA55211BC28D2; Wed, 18 Nov 2026 17:52:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795020738; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=PcycRmA0N7JwWG8IrfXbNLId07ZHA9iVWljKGyKyKAA=;
 b=ICktNj0OSa7aBFs7JNXrKsaVqoQllu4RRlLBKR6V7YXZjCe2+VTPd6UA9fab87prOFn/P1
 tZ3W5ZLA+hCFuHadhuqkn7f/LWmS2/AzuebHduciomiFXXEn+ONm7lRZXlc6kIBLIfje27
 71GaeAqBRMApmD957KJxSMMNoMZp7sWi+/yg+uGlKlC8i2ma1BPtOC44BBOQ9yoePvBew7
 gU+/psnY2o72LTz/AURjxXlWRSEWJ9B5fXjFyY6SyGmspsekeZ1kXOlZ/lQL/RVq5fvoKT
 R0py6dAnPDYizcbJuV4szv1tNXYz2fGmuWX7gQeGX7sAUnLTUJu0k3HyYt1sJQ==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Wed, 18 Nov 2026 17:50:04 +0100
Subject: [PATCH RFC v3 21/31] drm/bridge: display-connector: implement
 .get_next_bridge
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-drm-bridge-hotplug-v3-21-44bb3b4a828f@bootlin.com>
References: <20261118-drm-bridge-hotplug-v3-0-44bb3b4a828f@bootlin.com>
In-Reply-To: <20261118-drm-bridge-hotplug-v3-0-44bb3b4a828f@bootlin.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Inki Dae <inki.dae@samsung.com>, Jagan Teki <jagan@amarulasolutions.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Douglas Anderson <dianders@chromium.org>, Marek Vasut <marex@denx.de>, 
 Stefan Agner <stefan@agner.ch>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This bridge never has a next bridge. Add get_next_callback func to expose
this.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/gpu/drm/bridge/display-connector.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/bridge/display-connector.c b/drivers/gpu/drm/bridge/display-connector.c
index eb3412ec30a0..8b16ad89c7f1 100644
--- a/drivers/gpu/drm/bridge/display-connector.c
+++ b/drivers/gpu/drm/bridge/display-connector.c
@@ -36,6 +36,11 @@ to_display_connector(struct drm_bridge *bridge)
 	return container_of(bridge, struct display_connector, bridge);
 }
 
+static struct drm_bridge *display_connector_get_next_bridge(struct drm_bridge *bridge)
+{
+	return NULL;
+}
+
 static int display_connector_attach(struct drm_bridge *bridge,
 				    struct drm_encoder *encoder,
 				    enum drm_bridge_attach_flags flags)
@@ -214,6 +219,7 @@ static u32 *display_connector_get_input_bus_fmts(struct drm_bridge *bridge,
 }
 
 static const struct drm_bridge_funcs display_connector_bridge_funcs = {
+	.get_next_bridge = display_connector_get_next_bridge,
 	.attach = display_connector_attach,
 	.destroy = display_connector_destroy,
 	.detect = display_connector_bridge_detect,
@@ -412,6 +418,7 @@ static int display_connector_probe(struct platform_device *pdev)
 
 	conn->bridge.of_node = pdev->dev.of_node;
 
+	conn->bridge.ops = DRM_BRIDGE_OP_GET_NEXT_BRIDGE;
 	if (conn->bridge.ddc)
 		conn->bridge.ops |= DRM_BRIDGE_OP_EDID
 				 |  DRM_BRIDGE_OP_DETECT;

-- 
2.56.1

