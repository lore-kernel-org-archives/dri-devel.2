Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4258EC5CFC1
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 14:06:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D43210F5F4;
	Fri, 14 Aug 2026 14:06:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="dcI2YOqT";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 213D510F5F8
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 14:06:54 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id EA3901A163D;
 Fri, 14 Aug 2026 14:06:52 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id BECCA6046D;
 Fri, 14 Aug 2026 14:06:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 7A2F611C4EDA1; 
 Fri, 14 Aug 2026 16:06:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1786716407; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=/yjuBpwVLWPQyhvydWW+FG8ndzG0jMVfxEkaLMcgJ+o=;
 b=dcI2YOqTafKRmtij0ULH2nyMrUlXdeAACRHbQYdXQeX+C9pTxZ3g2TIZ57JrYC6WGqWfwe
 vSp4hCeacVVcZa81NOkxQgkVt/AigfKRk6EhBH09/98ddfA5cNav802CL8xYSSQTta9zj8
 N0nbMuN/zKh8xJvJ4BzdcJWW+WCvgLymMsHc1jbH27LsgSXFJQGxFT20ujInbpfB7qqoTa
 0owKzNtr1RJQkS39ocK8O0QKLc0AOUaRrBF+Ctfpr7ZYRX6942wkqDnEsUdaXda4LGN1kb
 Yx7ZqNH750COOEyW2fxcW0vL8VnuOTGKJTkx6n+ejOLt4/99eXl/hVfqtBE0fQ==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Fri, 14 Aug 2026 16:05:53 +0200
Subject: [PATCH 05/11] drm/bridge: panel: add a panel_bridge to every panel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-drm-bridge-every-panel-v1-5-19cd5277cc8d@bootlin.com>
References: <20260814-drm-bridge-every-panel-v1-0-19cd5277cc8d@bootlin.com>
In-Reply-To: <20260814-drm-bridge-every-panel-v1-0-19cd5277cc8d@bootlin.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Linus Walleij <linusw@kernel.org>, 
 Inki Dae <inki.dae@samsung.com>, Jagan Teki <jagan@amarulasolutions.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
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

Adding a panel does currently not add a panel_bridge wrapping it. Usually
the panel_bridge creation happens later, when some other driver (e.g. the
previous bridge or the encoder) calls *_of_get_bridge() and the following
element in the pipeline is a panel.

This has some drawbacks:

 * hte bridge API is currently the best practice to access various
   components of the pipeline, especially with complex cards where bridges
   can be combined in different ways on different hardware
 * the panel_bridge is not created in the context of the driver of the
   underlying physical device (the panel driver), but of some other driver
 * that other driver is not aware of whether the returned drm_bridge
   pointer is a panel_bridge created on the fly, a pre-existing
   panel_bridge or a non-panel bridge
 * removal of a panel_bridge requires calling drm_panel_bridge_remove(),
   but the other driver doesn't know whether this is needed because it
   doesn't know whether it has created a panel_bridge or not

So far the current approach has been working because devm and drmm ensure
the panel bridge would be dealloacted at some later point. However with the
upcoming implementation of dynamic bridge lifetime this will get more
complicated.

Switch to the new approach: always create a panel_bridge with a drm_panel,
thus matching the lifetime of the drm_panel and the panel_bridge wrapping
it. This makes lifetime much more straightforward to understand and to
further develop on.

As a consequence devm_drm_of_get_bridge() and drmm_of_get_bridge() don't
need to look for a panel anymore and become simple wrappers to
of_drm_get_bridge_by_endpoint(). Also deprecate them as they can be
replaced by of_drm_get_bridge_by_endpoint() which also handles refcount.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/gpu/drm/bridge/panel.c | 47 +++++++++++++++++++++---------------------
 drivers/gpu/drm/drm_panel.c    |  3 +++
 include/drm/drm_panel.h        |  8 +++++++
 3 files changed, 34 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/bridge/panel.c b/drivers/gpu/drm/bridge/panel.c
index 02388a3de626..d86555254aa9 100644
--- a/drivers/gpu/drm/bridge/panel.c
+++ b/drivers/gpu/drm/bridge/panel.c
@@ -412,6 +412,11 @@ struct drm_bridge *devm_drm_panel_bridge_add_typed(struct device *dev,
 {
 	struct drm_bridge **ptr, *bridge;
 
+	if (panel->bridge) {
+		dev_dbg(dev, "returning existing bridge=%p\n", panel->bridge);
+		return panel->bridge;
+	}
+
 	ptr = devres_alloc(devm_drm_panel_bridge_release, sizeof(*ptr),
 			   GFP_KERNEL);
 	if (!ptr)
@@ -495,9 +500,12 @@ EXPORT_SYMBOL(drm_panel_bridge_connector);
  * @port: port in the device tree node
  * @endpoint: endpoint in the device tree node
  *
+ * This function is deprecated and should not be used in new drivers. The
+ * returned bridge refcount is not incremented! Replace by
+ * of_drm_get_bridge_by_endpoint() and handle bridge refcount.
+ *
  * Given a DT node's port and endpoint number, finds the connected node
- * and returns the associated bridge if any, or creates and returns a
- * drm panel bridge instance if a panel is connected.
+ * and returns the associated bridge if any.
  *
  * Returns a pointer to the bridge if successful, or an error pointer
  * otherwise.
@@ -507,18 +515,12 @@ struct drm_bridge *devm_drm_of_get_bridge(struct device *dev,
 					  u32 port, u32 endpoint)
 {
 	struct drm_bridge *bridge;
-	struct drm_panel *panel;
-	int ret;
 
-	ret = drm_of_find_panel_or_bridge(np, port, endpoint,
-					  &panel, &bridge);
-	if (ret)
-		return ERR_PTR(ret);
+	bridge = of_drm_get_bridge_by_endpoint(np, port, endpoint);
+	if (IS_ERR(bridge))
+		return bridge;
 
-	if (panel) {
-		bridge = devm_drm_panel_bridge_add(dev, panel);
-		drm_panel_put(panel);
-	}
+	drm_bridge_put(bridge);
 
 	return bridge;
 }
@@ -531,9 +533,12 @@ EXPORT_SYMBOL(devm_drm_of_get_bridge);
  * @port: port in the device tree node
  * @endpoint: endpoint in the device tree node
  *
+ * This function is deprecated and should not be used in new drivers. The
+ * returned bridge refcount is not incremented! Replace by
+ * of_drm_get_bridge_by_endpoint() and handle bridge refcount.
+ *
  * Given a DT node's port and endpoint number, finds the connected node
- * and returns the associated bridge if any, or creates and returns a
- * drm panel bridge instance if a panel is connected.
+ * and returns the associated bridge if any.
  *
  * Returns a drmm managed pointer to the bridge if successful, or an error
  * pointer otherwise.
@@ -543,18 +548,12 @@ struct drm_bridge *drmm_of_get_bridge(struct drm_device *drm,
 				      u32 port, u32 endpoint)
 {
 	struct drm_bridge *bridge;
-	struct drm_panel *panel;
-	int ret;
 
-	ret = drm_of_find_panel_or_bridge(np, port, endpoint,
-					  &panel, &bridge);
-	if (ret)
-		return ERR_PTR(ret);
+	bridge = of_drm_get_bridge_by_endpoint(np, port, endpoint);
+	if (IS_ERR(bridge))
+		return bridge;
 
-	if (panel) {
-		bridge = drmm_panel_bridge_add(drm, panel);
-		drm_panel_put(panel);
-	}
+	drm_bridge_put(bridge);
 
 	return bridge;
 }
diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
index f8f6082e637f..95fc95d1b4b7 100644
--- a/drivers/gpu/drm/drm_panel.c
+++ b/drivers/gpu/drm/drm_panel.c
@@ -453,6 +453,9 @@ void *__devm_drm_panel_alloc(struct device *dev, size_t size, size_t offset,
 
 	drm_panel_init(panel, dev, funcs, connector_type);
 
+	panel->bridge = devm_drm_panel_bridge_add(dev, panel);
+	WARN_ON(!panel->bridge);
+
 	return container;
 }
 EXPORT_SYMBOL(__devm_drm_panel_alloc);
diff --git a/include/drm/drm_panel.h b/include/drm/drm_panel.h
index b87323443f49..9a042675eb3e 100644
--- a/include/drm/drm_panel.h
+++ b/include/drm/drm_panel.h
@@ -210,6 +210,14 @@ struct drm_panel {
 	 */
 	struct device *dev;
 
+	/**
+	 * @bridge:
+	 *
+	 * Pointer to the panel bridge giving access to the panel using the
+	 * DRM bridge API.
+	 */
+	struct drm_bridge *bridge;
+
 	/**
 	 * @backlight:
 	 *

-- 
2.55.0

