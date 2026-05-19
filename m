Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36C81CD4F57
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 10:40:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6604110EC43;
	Tue, 19 May 2026 10:40:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="JyGilfpW";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5580110EC42
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 10:40:18 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 3BF884E42CF3;
 Tue, 19 May 2026 10:40:17 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 0734F606E9;
 Tue, 19 May 2026 10:40:17 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 259D8107E8AF0; 
 Tue, 19 May 2026 12:40:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1779187215; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=QjEyGA9Kg8mSbftaYSZM9v+ClyMwRZd6xLu2RTl/IwY=;
 b=JyGilfpW6FF1WDd5YDkDrD/vjp5+5QLCqzdWjH565wNY7ZdIU4yqAWiMG3RVEiHoG6NIDH
 pnG04pxYIb7esTWPif0QLgtjb63//f7fyHW8SYSTPFHH8Es8ZL39TGeZMIcu76hamGFwtz
 YMcTus4OewSgxrY3/OeIr48MuO/M7t5MUXlvyOFjNsyPi4fMKNC7k8vrkdGB8kEVn8LZOT
 ZitG3yNOnFvL50kshS60cHBnvkRXlMbRa4TWGEo5UwoH6efMX1//UHDeAGfj6fpoR3wuH4
 Xm7+S8pPdmQT5H5HQrUMymtpNFrU27vN2ktjMFgWxcJB6qQhMJS7Ys3w2Y3Hdw==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Tue, 19 May 2026 12:37:47 +0200
Subject: [PATCH 30/37] drm/bridge: add drm_bridge_is_tail() to know whether
 a bridge completes the pipeline
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-drm-bridge-hotplug-v1-30-45e2bdb3dfb4@bootlin.com>
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

For bridge hotplug we need to successfully probe a card with an incomplete
bridge chain, i.e. a chain whose last bridge currently in bridge_chain
needs a next_bridge to work. Such a card would have no connector, and be
able to add one as soon as the followong bridges are added up to the tail
bridge (e.g. a panel_bridge or a connector_bridge).

Currently common DRM code is unable to tell whether the last bridge
currently in the chain is the tail bridge (= the pipeline is complete) or
not.

Add drm_bridge_is_tail(), and a .is_tail func for it to rely on, so common
code can know whether a bridge is a tail bridge or needs a next_bridge.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/gpu/drm/drm_bridge.c | 28 ++++++++++++++++++++++++++++
 include/drm/drm_bridge.h     | 19 +++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index c62d17e84d4f..2b539c9749a6 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -646,6 +646,34 @@ void drm_bridge_detach(struct drm_bridge *bridge)
 	drm_bridge_put(bridge);
 }
 
+/**
+ * drm_bridge_is_tail - check whether the bridge is the last required to
+ *                      have a full pipeline
+ * @bridge: the bridge to check
+ *
+ * Tell whether this is a tail bridge, i.e. a bridge that does not need a
+ * next bridge to work. E.g. a panel_bridge is final, a DSI-to-LVDS bridge
+ * is not.
+ *
+ * In case of hotplug the last bridge currently in the chain (as in
+ * drm_bridge_chain_get_last_bridge()) might not be final, and be waiting
+ * for a pipeline tail to be connected.
+ *
+ * Return: true if this bridge does not need a next bridge to work, false
+ * otherwise
+ */
+bool drm_bridge_is_tail(struct drm_bridge *bridge)
+{
+	if (!(bridge->ops & DRM_BRIDGE_OP_IS_TAIL)) {
+		drm_warn_once(bridge->dev, "is_tail func not implemented by bridge %ps!",
+			      bridge->funcs);
+		return false;
+	}
+
+	return bridge->funcs->is_tail(bridge);
+}
+EXPORT_SYMBOL(drm_bridge_is_tail);
+
 /**
  * DOC: bridge operations
  *
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index 4ba3a5deef9a..d783a6fb93a0 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -78,6 +78,19 @@ struct drm_bridge_funcs {
 	int (*attach)(struct drm_bridge *bridge, struct drm_encoder *encoder,
 		      enum drm_bridge_attach_flags flags);
 
+	/**
+	 * @is_tail:
+	 *
+	 * Returns true if this is a tail bridge, i.e. it does not need a
+	 * next bridge to work. E.g. a panel_bridge is a tail bridge, a
+	 * DSI-to-LVDS bridge is not a tail bridge (no matter whether the
+	 * next bridge is present or not).
+	 *
+	 * The @is_tail callback is optional but it is required if the
+	 * bridge is part of a pipeline with hot-pluggable components.
+	 */
+	bool (*is_tail)(struct drm_bridge *bridge);
+
 	/**
 	 * @destroy:
 	 *
@@ -1092,6 +1105,11 @@ enum drm_bridge_ops {
 	 * &drm_bridge_funcs->hdmi_clear_spd_infoframe callbacks.
 	 */
 	DRM_BRIDGE_OP_HDMI_SPD_INFOFRAME = BIT(10),
+	/**
+	 * @DRM_BRIDGE_OP_IS_TAIL: The bridge implements the
+	 * &drm_bridge_funcs->is_tail callback.
+	 */
+	DRM_BRIDGE_OP_IS_TAIL = BIT(11),
 };
 
 /**
@@ -1323,6 +1341,7 @@ void drm_bridge_remove(struct drm_bridge *bridge);
 int drm_bridge_attach(struct drm_encoder *encoder, struct drm_bridge *bridge,
 		      struct drm_bridge *previous,
 		      enum drm_bridge_attach_flags flags);
+bool drm_bridge_is_tail(struct drm_bridge *bridge);
 
 #ifdef CONFIG_OF
 struct drm_bridge *of_drm_find_and_get_bridge(struct device_node *np);

-- 
2.54.0

