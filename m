Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C12606A333
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 16:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=aM/xKKxj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B879710FE99;
	Wed, 18 Nov 2026 16:53:31 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9AE210FE98
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 16:53:25 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id AC2701A16DA;
 Wed, 18 Nov 2026 16:53:24 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 72B275FE9B;
 Wed, 18 Nov 2026 16:53:24 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D321711BC2937; Wed, 18 Nov 2026 17:53:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795020798; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=VcG30sa+93pw9ClhwzPfhT8lh5QnjKv4zrX533cn6l0=;
 b=aM/xKKxjopE+Un5pt3rwL4bpxQPJBEFkuGVgKiqIOb6YhHHag/yNUmZvbYEenYPRG+3XuS
 rHvbA+f2lEzwesExwsKoOgYlQKez5kYzTwmyTr2IpUAlg7gPaS89LogdlBPwBqqAXRBhxr
 X9mJJC6w2ZcI1XLqR1FCqxndSFDuj6bMYSDLyAg/O+Kqelo9TBdXBJEsINJJ6Z0ZOmuraN
 Rc8oWhcPQ8y9nnbs7Yn16lCGOD4MH9LHnC1dIkgvNTyxWlfU0RgTNO2XNS0GzI+epE/LXA
 ltVhAceUE/E/nOyNvzvq0pWVa6fZsgIeBTKjvGBTueDyNn4uvsbjahWtlkmeVg==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Wed, 18 Nov 2026 17:50:13 +0100
Subject: [PATCH RFC v3 30/31] drm: drm_hotplug_helper: new helper to
 implement bridge hotplug
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-drm-bridge-hotplug-v3-30-44bb3b4a828f@bootlin.com>
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

Add a new helper to support cards implementing hotpluggable drm_bridges.

drmm_hotplug_helper_init() registers to get notified of relevant events and
react by creating a bridge (if the pipeline is complete in the hardware)
and destroying it on bridge removal.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

---

Changes in v3:
- Do not require the first bridge is non-hotpluggable
- Support non-DSI bridges too
- Add callback to report connector add/remove
- Do not store the drm_device pointer, get it from the encoder
- use new v3 notifier API name

Changes in v2:
- Add callback to report connector addition/removal
- Sanity-check drmm_hotplug_helper_init() parameters
- Reformat kdoc comment
---
 MAINTAINERS                                  |   8 +
 drivers/gpu/drm/display/Kconfig              |   7 +
 drivers/gpu/drm/display/Makefile             |   2 +
 drivers/gpu/drm/display/drm_hotplug_helper.c | 325 +++++++++++++++++++++++++++
 include/drm/drm_hotplug_helper.h             |  30 +++
 5 files changed, 372 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fc404918c938..86a08dc33a16 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8218,6 +8218,14 @@ F:	Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.yaml
 F:	drivers/accel/rocket/
 F:	include/uapi/drm/rocket_accel.h
 
+DRM BRIDGE HOTPLUG HELPER
+M:	Luca Ceresoli <luca.ceresoli@bootlin.com>
+S:	Maintained
+T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
+F:	Documentation/devicetree/bindings/display/bridge/
+F:	drivers/gpu/drm/display/drm_hotplug_helper.c
+F:	include/drm/drm_hotplug_helper.h
+
 DRM COMPUTE ACCELERATORS DRIVERS AND FRAMEWORK
 M:	Oded Gabbay <ogabbay@kernel.org>
 L:	dri-devel@lists.freedesktop.org
diff --git a/drivers/gpu/drm/display/Kconfig b/drivers/gpu/drm/display/Kconfig
index df09cf9a8ca1..e086e2fd08a4 100644
--- a/drivers/gpu/drm/display/Kconfig
+++ b/drivers/gpu/drm/display/Kconfig
@@ -22,6 +22,13 @@ config DRM_BRIDGE_CONNECTOR
 	help
 	  DRM connector implementation terminating DRM bridge chains.
 
+config DRM_HOTPLUG_HELPER
+	bool
+	depends on OF
+	select DRM_BRIDGE_CONNECTOR
+	help
+	  Helper code to implement a card supporting hotpluggable bridges.
+
 config DRM_DISPLAY_DP_AUX_CEC
 	bool "Enable DisplayPort CEC-Tunneling-over-AUX HDMI support"
 	select DRM_DISPLAY_DP_HELPER
diff --git a/drivers/gpu/drm/display/Makefile b/drivers/gpu/drm/display/Makefile
index 0ff4a1ad0222..ce6dbd65833b 100644
--- a/drivers/gpu/drm/display/Makefile
+++ b/drivers/gpu/drm/display/Makefile
@@ -5,6 +5,8 @@ obj-$(CONFIG_DRM_DISPLAY_DP_AUX_BUS) += drm_dp_aux_bus.o
 drm_display_helper-y := drm_display_helper_mod.o
 drm_display_helper-$(CONFIG_DRM_BRIDGE_CONNECTOR) += \
 	drm_bridge_connector.o
+drm_display_helper-$(CONFIG_DRM_HOTPLUG_HELPER) += \
+	drm_hotplug_helper.o
 drm_display_helper-$(CONFIG_DRM_DISPLAY_DP_HELPER) += \
 	drm_dp_dual_mode_helper.o \
 	drm_dp_helper.o \
diff --git a/drivers/gpu/drm/display/drm_hotplug_helper.c b/drivers/gpu/drm/display/drm_hotplug_helper.c
new file mode 100644
index 000000000000..ea32bdb0af8f
--- /dev/null
+++ b/drivers/gpu/drm/display/drm_hotplug_helper.c
@@ -0,0 +1,325 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 GE HealthCare
+ * Author: Luca Ceresoli <luca.ceresoli@bootlin.com>
+ */
+
+#include <linux/of.h>
+#include <linux/of_graph.h>
+
+#include <drm/drm_bridge.h>
+#include <drm/drm_bridge_connector.h>
+#include <drm/drm_hotplug_event_notifier.h>
+#include <drm/drm_hotplug_helper.h>
+#include <drm/drm_managed.h>
+#include <drm/drm_print.h>
+
+struct drm_hotplug_helper {
+	/**
+	 * @encoder: The encoder at the start of the bridges chain
+	 */
+	struct drm_encoder *encoder;
+	/**
+	 * @event_cb: Callback to report connector addition/removal
+	 */
+	drm_hotplug_helper_event_cb event_cb;
+	/**
+	 * @drm_event_nb: Notifier to receive DRM hotplug-related events
+	 */
+	struct notifier_block drm_event_nb;
+	/**
+	 * @connector: The drm_connector added/removed on plug/unplug
+	 */
+	struct drm_connector *connector;
+	/**
+	 * @event_mutex: Protect entry points (init, fini, event notifier)
+	 * from concurrent attach and connector creation or destruction
+	 */
+	struct mutex event_mutex;
+	/**
+	 * @first_bridge_ep: Device tree node of the encoder endpoint
+	 * connected to the first bridge
+	 */
+	struct device_node *first_bridge_ep;
+};
+
+/*
+ * True if the encoder bridge chain is complete, i.e. the last bridge in
+ * the chain is the last bridge expected in the hardware (e.g. a panel).
+ */
+static bool drm_hotplug_helper_bridge_chain_is_complete(struct drm_hotplug_helper *hotplug_helper)
+{
+	struct drm_bridge *last_bridge __free(drm_bridge_put) =
+		drm_bridge_chain_get_last_bridge(hotplug_helper->encoder);
+	struct drm_device *drm = hotplug_helper->encoder->dev;
+
+	/* We expect at least one bridge */
+	if (!last_bridge) {
+		drm_dbg_driver(drm, "no bridges in pipeline (yet)\n");
+		return false;
+	}
+
+	struct drm_bridge *next_bridge __free(drm_bridge_put) =
+		drm_bridge_get_next(last_bridge);
+
+	/* No next bridge expected, pipeline is complete */
+	if (!next_bridge) {
+		drm_dbg_driver(drm, "pipeline complete\n");
+		return true;
+	}
+
+	/* Next bridge expected but not there now, pipeline incomplete */
+	if (next_bridge == ERR_PTR(-ENODEV)) {
+		drm_dbg_driver(drm, "pipeline not (yet) complete\n");
+		return false;
+	}
+
+	/* Unexpected error */
+	if (IS_ERR(next_bridge))
+		drm_warn(drm, "%s error %pe\n", __func__, next_bridge);
+
+	/* next_bridge is valid, but not (yet|anymore) in chain */
+	return false;
+}
+
+/**
+ * drm_hotplug_helper_connector_add - add the drm_connector
+ * @hotplug_helper: drm_hotplug_helper to add the drm_connector to
+ *
+ * Returns 0 on success or a negative error otherwise.
+ */
+static int drm_hotplug_helper_connector_add(struct drm_hotplug_helper *hotplug_helper)
+{
+	struct drm_device *drm = hotplug_helper->encoder->dev;
+	struct drm_connector *connector;
+
+	if (drm_WARN_ON(drm, hotplug_helper->connector))
+		return -EBUSY;
+
+	connector = drm_bridge_connector_dynamic_add(drm, hotplug_helper->encoder);
+	if (IS_ERR(connector))
+		return PTR_ERR(connector);
+
+	hotplug_helper->connector = connector;
+	hotplug_helper->event_cb(DRM_HOTPLUG_HELPER_CONNECTOR_ADDED, connector);
+
+	dev_dbg(drm->dev, "added bridge connector\n");
+
+	return 0;
+}
+
+/*
+ * Removes the connector, which must be present.
+ *
+ * Must be called with the hotplug_helper->event_mutex locked.
+ */
+static void drm_hotplug_helper_connector_remove(struct drm_hotplug_helper *hotplug_helper)
+{
+	struct drm_device *drm = hotplug_helper->encoder->dev;
+
+	if (drm_WARN_ON(drm, !hotplug_helper->connector))
+		return;
+
+	dev_dbg(drm->dev, "removing bridge connector\n");
+
+	hotplug_helper->event_cb(DRM_HOTPLUG_HELPER_CONNECTOR_REMOVING, hotplug_helper->connector);
+	drm_bridge_connector_dynamic_remove(hotplug_helper->connector);
+	hotplug_helper->connector = NULL;
+}
+
+/*
+ * Propagate the attach chain and possibly add a drm_bridge_connector after
+ * a new drm_bridge is hot-plugged.
+ *
+ * The connector is added only if the pipeline is now complete. This could
+ * not be the case for various reasons:
+ *
+ * - the new bridge is just unrelated to our encoder
+ * - the new bridge is not the next one in the pipeline
+ * - the new bridge is the next in the pipeline but the pipeline is not yet
+ *   complete
+ *
+ * All these cases are normal, not an error.
+ *
+ * Must be called with the hotplug_helper->event_mutex locked.
+ */
+static void drm_hotplug_helper_try_complete(struct drm_hotplug_helper *hotplug_helper)
+{
+	struct device *dev = hotplug_helper->encoder->dev->dev;
+	int err;
+
+	WARN_ON(!mutex_is_locked(&hotplug_helper->event_mutex));
+
+	/*
+	 * drm_connector already present, the new bridge must be for
+	 * another card
+	 */
+	if (hotplug_helper->connector)
+		return;
+
+	struct drm_bridge *last_bridge __free(drm_bridge_put) =
+		drm_bridge_chain_get_last_bridge(hotplug_helper->encoder);
+
+	if (last_bridge) {
+		/*
+		 * Some bridge(s) already in the chain, propagate the
+		 * attach call chain from the current chain tail to newly
+		 * hotplugged bridge(s)
+		 */
+		dev_dbg(dev, "propagate attach after %ps\n", last_bridge->funcs);
+
+		err = last_bridge->funcs->attach(last_bridge, hotplug_helper->encoder,
+						 DRM_BRIDGE_ATTACH_NO_CONNECTOR);
+		if (err)
+			return;
+	} else {
+		/* Bridge chain still empty, find first bridge and attach */
+
+		const struct device_node *first_bridge_node __free(device_node) =
+			of_graph_get_remote_port_parent(hotplug_helper->first_bridge_ep);
+		if (!of_device_is_available(first_bridge_node))
+			return;
+
+		struct drm_bridge *first_bridge __free(drm_bridge_put) =
+			of_drm_find_and_get_bridge(first_bridge_node);
+		if (!first_bridge)
+			return;
+
+		dev_dbg(dev, "attach chain starting at %ps\n", first_bridge->funcs);
+
+		err = drm_bridge_attach(hotplug_helper->encoder, first_bridge, NULL,
+					DRM_BRIDGE_ATTACH_NO_CONNECTOR);
+		if (err)
+			return;
+	}
+
+	/* Add the connector if the encoder chain is now complete */
+	if (drm_hotplug_helper_bridge_chain_is_complete(hotplug_helper))
+		drm_hotplug_helper_connector_add(hotplug_helper);
+}
+
+static int drm_hotplug_helper_handle_event(struct notifier_block *nb,
+					   unsigned long event, void *data)
+{
+	struct drm_hotplug_helper *hotplug_helper =
+		container_of(nb, struct drm_hotplug_helper, drm_event_nb);
+	struct device *dev = hotplug_helper->encoder->dev->dev;
+
+	guard(mutex)(&hotplug_helper->event_mutex);
+
+	dev_dbg(dev, "received event %lu\n", event);
+
+	switch (event) {
+	case DRM_BRIDGE_ADDED:
+	case DRM_MIPI_DSI_ATTACHED:
+		/*
+		 * A bridges hot-plugged, try adding the
+		 * drm_bridge_connector
+		 */
+		drm_hotplug_helper_try_complete(hotplug_helper);
+		break;
+	case DRM_BRIDGE_DETACHED:
+	{
+		/*
+		 * A bridge was unplugged, remove the drm_bridge_connector
+		 * if it's part of the same pipeline
+		 */
+		struct drm_bridge *bridge = (struct drm_bridge *)data;
+
+		if (hotplug_helper->connector &&
+		    bridge->encoder == hotplug_helper->encoder)
+			drm_hotplug_helper_connector_remove(hotplug_helper);
+		break;
+	}
+	default:
+	}
+
+	return NOTIFY_DONE;
+}
+
+static void drmm_hotplug_helper_fini(struct drm_device *dev, void *res)
+{
+	struct drm_hotplug_helper *hotplug_helper = (struct drm_hotplug_helper *)res;
+
+	guard(mutex)(&hotplug_helper->event_mutex);
+
+	if (hotplug_helper->connector)
+		drm_hotplug_helper_connector_remove(hotplug_helper);
+
+	of_node_put(hotplug_helper->first_bridge_ep);
+}
+
+static void drmm_hotplug_helper_notifier_unregister(struct drm_device *dev, void *res)
+{
+	struct notifier_block *nb = (struct notifier_block *)res;
+
+	drm_hotplug_event_notifier_unregister(nb);
+}
+
+/**
+ * drmm_hotplug_helper_init - Initialise the hotplug helper for an encoder
+ * @encoder: the encoder where the bridge chain starts; must be already
+ *           associated to the drm_device (e.g. by drm_encoder_init())
+ * @event_cb: callback invoked when a drm_connector is added or removed
+ * @first_bridge_ep: device tree node of the encoder endpoint connected to
+ *                   the first bridge
+ *
+ * Register to receive hotplug-related events and react to them:
+ * - when a new bridge appears: tries to attach the whole bridge chain,
+ *   then checks if the pipeline is now complete, and if it is it adds a
+ *   drm_bridge_connector (which in turn will add a drm_connector)
+ * - when a bridge disappears, remove the drm_bridge_connector (which in
+ *   turn will remove the drm_connector)
+ *
+ * When a connector is added or removed, the @event_cb will be called.
+ *
+ * The caller does not need to attach the bridge(s) anymore because the
+ * hotplug_helper will do it, including at init time in case all bridges
+ * are present already.
+ *
+ * Returns a pointer to the new &drm_hotplug_helper on success, or a
+ * negative error pointer otherwise.
+ */
+struct drm_hotplug_helper *drmm_hotplug_helper_init(struct drm_encoder *encoder,
+						    drm_hotplug_helper_event_cb event_cb,
+						    struct device_node *first_bridge_ep)
+{
+	struct drm_hotplug_helper *hotplug_helper;
+	int ret;
+
+	if (!encoder || !event_cb || !first_bridge_ep)
+		return ERR_PTR(-EINVAL);
+
+	struct drm_device *drm = encoder->dev;
+	if (WARN_ON(IS_ERR_OR_NULL(drm)))
+		return ERR_PTR(-EINVAL);
+
+	hotplug_helper = drmm_kzalloc(drm, sizeof(*hotplug_helper), GFP_KERNEL);
+	if (!hotplug_helper)
+		return ERR_PTR(-ENOMEM);
+
+	mutex_init(&hotplug_helper->event_mutex);
+	hotplug_helper->encoder = encoder;
+	hotplug_helper->event_cb = event_cb;
+	hotplug_helper->drm_event_nb.notifier_call = drm_hotplug_helper_handle_event;
+	hotplug_helper->first_bridge_ep = of_node_get(first_bridge_ep);
+
+	ret = drmm_add_action_or_reset(drm, drmm_hotplug_helper_fini, hotplug_helper);
+	if (ret)
+		return ERR_PTR(ret);
+
+	ret = drm_hotplug_event_notifier_register(&hotplug_helper->drm_event_nb);
+	if (ret)
+		return ERR_PTR(ret);
+
+	ret = drmm_add_action_or_reset(drm, drmm_hotplug_helper_notifier_unregister,
+				       &hotplug_helper->drm_event_nb);
+	if (ret)
+		return ERR_PTR(ret);
+
+	guard(mutex)(&hotplug_helper->event_mutex);
+	drm_hotplug_helper_try_complete(hotplug_helper);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(drmm_hotplug_helper_init);
diff --git a/include/drm/drm_hotplug_helper.h b/include/drm/drm_hotplug_helper.h
new file mode 100644
index 000000000000..ba14d547f8ff
--- /dev/null
+++ b/include/drm/drm_hotplug_helper.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2026 GE HealthCare
+ * Author: Luca Ceresoli <luca.ceresoli@bootlin.com>
+ */
+
+#ifndef __DRM_HOTPLUG_HELPER_H__
+#define __DRM_HOTPLUG_HELPER_H__
+
+/**
+ * enum drm_hotplug_helper_event - DRM hotplug helper connector events
+ */
+enum drm_hotplug_helper_event {
+	/** @DRM_HOTPLUG_HELPER_CONNECTOR_ADDED: A drm_connector has just been added */
+	DRM_HOTPLUG_HELPER_CONNECTOR_ADDED,
+	/** @DRM_HOTPLUG_HELPER_CONNECTOR_REMOVING: A drm_connector is about to be removed */
+	DRM_HOTPLUG_HELPER_CONNECTOR_REMOVING,
+};
+
+/**
+ * drm_hotplug_helper_event_cb - Callback to report connector addition and removal.
+ */
+typedef void (*drm_hotplug_helper_event_cb)(enum drm_hotplug_helper_event event,
+					    struct drm_connector *connector);
+
+struct drm_hotplug_helper *drmm_hotplug_helper_init(struct drm_encoder *encoder,
+						    drm_hotplug_helper_event_cb event_cb,
+						    struct device_node *next_bridge_ep);
+
+#endif /* __DRM_HOTPLUG_HELPER_H__ */

-- 
2.56.1

