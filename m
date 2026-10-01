Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25A71CA5FCB
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 12:45:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81FB610F668;
	Thu,  1 Oct 2026 12:45:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="WvQsyz7O";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1037410F668
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 12:45:04 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id D12BA1A24E0;
 Thu,  1 Oct 2026 12:45:02 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id A36D660341;
 Thu,  1 Oct 2026 12:45:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 174E91032809F; 
 Thu,  1 Oct 2026 14:44:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1790858700; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=Gb6DQci2OJE3fPWjB9h1DWNGvWr0sk2KsrQyQNIzEGQ=;
 b=WvQsyz7Ox2R5ZvHlx9iXZXPRLguYQTpHWeE+gTLmuPDrAdl3Ppnq4BO0B3L8p+bMmbgzMc
 YROA+OS3Zcq592yFjzGddpLm8lDw7XQUD32ZppvPsG8YuIIg0TYXBtyV+AzfKbawsgjwBO
 m8pxTjnothKF8YxE8OmzGFDFr3CczyF2fPHwZtnKxjDBsCmIn0E/h9auK8YtTdkp7M8oUQ
 M2vf+gqoFce0VjYmlP8CwOsbKvUpdvqfMt6FY8KEKhM2pMwKmGvl3oRCS+EP7g4+ryqHiU
 Q4TQPEqmLkNvsvSMV+N/sXCoIlZJ1opjl+nAFKFjeZG07lJluKGcpW5tCRFG/w==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Thu, 01 Oct 2026 14:42:45 +0200
Subject: [PATCH RFC v2 23/24] drm: drm_hotplug_helper: new helper to
 implement bridge hotplug
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261001-drm-bridge-hotplug-v2-23-8e34986dcb68@bootlin.com>
References: <20261001-drm-bridge-hotplug-v2-0-8e34986dcb68@bootlin.com>
In-Reply-To: <20261001-drm-bridge-hotplug-v2-0-8e34986dcb68@bootlin.com>
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
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Add a new helper to support cards implementing hotpluggable drm_bridges.

drmm_hotplug_helper_init() registers to get notified of relevant events and
react by creating a bridge (if the pipeline is complete in the hardware)
and destroying it on bridge removal.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 MAINTAINERS                                  |   8 +
 drivers/gpu/drm/display/Kconfig              |   6 +
 drivers/gpu/drm/display/Makefile             |   2 +
 drivers/gpu/drm/display/drm_hotplug_helper.c | 243 +++++++++++++++++++++++++++
 include/drm/drm_hotplug_helper.h             |  13 ++
 5 files changed, 272 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c5ae9f2f408a..611790c175c4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8019,6 +8019,14 @@ F:	Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.yaml
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
index df09cf9a8ca1..f1a6ffcd4c63 100644
--- a/drivers/gpu/drm/display/Kconfig
+++ b/drivers/gpu/drm/display/Kconfig
@@ -22,6 +22,12 @@ config DRM_BRIDGE_CONNECTOR
 	help
 	  DRM connector implementation terminating DRM bridge chains.
 
+config DRM_HOTPLUG_HELPER
+	bool
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
index 000000000000..1b89b14b52aa
--- /dev/null
+++ b/drivers/gpu/drm/display/drm_hotplug_helper.c
@@ -0,0 +1,243 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 GE HealthCare
+ * Author: Luca Ceresoli <luca.ceresoli@bootlin.com>
+ */
+
+#include <drm/drm_bridge.h>
+#include <drm/drm_bridge_connector.h>
+#include <drm/drm_event_notifier.h>
+#include <drm/drm_hotplug_helper.h>
+#include <drm/drm_managed.h>
+#include <drm/drm_print.h>
+
+struct drm_hotplug_helper {
+	/**
+	 * @drm: The DRM device we belong to
+	 */
+	struct drm_device *drm;
+	/**
+	 * @encoder:
+	 *
+	 * The encoder at the start of the bridges chain.
+	 */
+	struct drm_encoder *encoder;
+	/**
+	 * @drm_event_nb: notifier to receive DRM hotplug-related events
+	 */
+	struct notifier_block drm_event_nb;
+	/**
+	 * @connector: the drm_connector added/removed on plug/unplug
+	 */
+	struct drm_connector *connector;
+	/**
+	 * @connector_mutex: Protect @connector from concurrent creation and
+	 * destruction
+	 */
+	struct mutex connector_mutex;
+};
+
+static bool drm_hotplug_helper_pipeline_is_complete(struct drm_hotplug_helper *hotplug_helper)
+{
+	struct drm_bridge *last_bridge __free(drm_bridge_put) =
+		drm_bridge_chain_get_last_bridge(hotplug_helper->encoder);
+
+	/* We expect at least one bridge */
+	if (!last_bridge) {
+		drm_dbg_driver(hotplug_helper->drm, "no bridges in pipeline (yet)\n");
+		return false;
+	}
+
+	struct drm_bridge *next_bridge __free(drm_bridge_put) =
+		drm_bridge_get_next(last_bridge);
+
+	/* No next bridge expected, pipeline is complete */
+	if (!next_bridge) {
+		drm_dbg_driver(hotplug_helper->drm, "pipeline complete\n");
+		return true;
+	}
+
+	/* Next bridge expected but not there now, pipeline incomplete */
+	if (next_bridge == ERR_PTR(-ENODEV)) {
+		drm_dbg_driver(hotplug_helper->drm, "pipeline not (yet) complete\n");
+		return false;
+	}
+
+	/* Unexpected error */
+	if (IS_ERR(next_bridge))
+		drm_warn(hotplug_helper->drm, "%s error %pe\n", __func__, next_bridge);
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
+	struct drm_connector *connector;
+
+	guard(mutex)(&hotplug_helper->connector_mutex);
+
+	if (drm_WARN_ON(hotplug_helper->drm, hotplug_helper->connector))
+		return -EBUSY;
+
+	connector = drm_bridge_connector_dynamic_add(hotplug_helper->drm,
+						     hotplug_helper->encoder);
+	if (IS_ERR(connector))
+		return PTR_ERR(connector);
+
+	hotplug_helper->connector = connector;
+
+	return 0;
+}
+
+static void drm_hotplug_helper_connector_remove(struct drm_hotplug_helper *hotplug_helper)
+{
+	guard(mutex)(&hotplug_helper->connector_mutex);
+
+	if (drm_WARN_ON(hotplug_helper->drm, !hotplug_helper->connector))
+		return;
+
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
+ * - the new bridge is not be the next one in the pipeline
+ * - the new bridge is the next in the pipeline but the pipeline is not yet
+ *   complete
+ *
+ * All these cases are normal, not an error.
+ */
+static void drm_hotplug_helper_try_complete(struct drm_hotplug_helper *hotplug_helper)
+{
+	int err;
+
+	/*
+	 * drm_connector already present, the new bridge must be for
+	 * another card
+	 */
+	if (hotplug_helper->connector)
+		return;
+
+	/* Propagate the attach call chain to newly hotplugged bridge(s) */
+	struct drm_bridge *last_bridge __free(drm_bridge_put) =
+		drm_bridge_chain_get_last_bridge(hotplug_helper->encoder);
+	err = last_bridge->funcs->attach(last_bridge, hotplug_helper->encoder,
+					 DRM_BRIDGE_ATTACH_NO_CONNECTOR);
+	if (err)
+		return;
+
+	/* Add the connector if the pipeline is now complete */
+	if (drm_hotplug_helper_pipeline_is_complete(hotplug_helper))
+		drm_hotplug_helper_connector_add(hotplug_helper);
+}
+
+static int drm_hotplug_helper_handle_event(struct notifier_block *nb,
+					   unsigned long event, void *data)
+{
+	struct drm_hotplug_helper *hotplug_helper =
+		container_of(nb, struct drm_hotplug_helper, drm_event_nb);
+
+	switch (event) {
+	case DRM_MIPI_DSI_ATTACHED:
+		/* One or more bridges hot-plugged, try adding the drm_bridge_connector */
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
+static void drm_hotplug_helper_fini(struct drm_device *dev, void *res)
+{
+	struct drm_hotplug_helper *hotplug_helper = (struct drm_hotplug_helper *)res;
+
+	drm_hotplug_helper_connector_remove(hotplug_helper);
+}
+
+static void drm_hotplug_helper_notifier_unregister(struct drm_device *dev, void *res)
+{
+	struct notifier_block *nb = (struct notifier_block *)res;
+
+	drm_event_notifier_unregister(nb);
+}
+
+/**
+ * drmm_hotplug_helper_init - Initialise the hotplug helper for an encoder
+ * @drm: the DRM device
+ * @encoder: the encoder where the bridge chain starts
+ *
+ * Register to receive hotplug-related events and react to them:
+ * - when a new bridge appears, check if the pipeline is now complete in
+ *   the hardware, and if it is add a drm_bridge_connector which will add a
+ *   drm_connector
+ * - when a bridge dispears, remove the drm_bridge_connector which will
+ *   remove the drm_connector
+ *
+ * Returns a pointer to the new &drm_hotplug_helper on success, or a
+ * negative error pointer otherwise.
+ */
+struct drm_hotplug_helper *drmm_hotplug_helper_init(struct drm_device *drm,
+						    struct drm_encoder *encoder)
+{
+	struct drm_hotplug_helper *hotplug_helper;
+	int ret;
+
+	hotplug_helper = drmm_kzalloc(drm, sizeof(*hotplug_helper), GFP_KERNEL);
+	if (!hotplug_helper)
+		return ERR_PTR(-ENOMEM);
+
+	mutex_init(&hotplug_helper->connector_mutex);
+	hotplug_helper->drm = drm;
+	hotplug_helper->encoder = encoder;
+	hotplug_helper->drm_event_nb.notifier_call = drm_hotplug_helper_handle_event;
+
+	if (drm_hotplug_helper_pipeline_is_complete(hotplug_helper)) {
+		ret = drm_hotplug_helper_connector_add(hotplug_helper);
+		if (ret)
+			return ERR_PTR(ret);
+	}
+
+	ret = drmm_add_action_or_reset(drm, drm_hotplug_helper_fini, hotplug_helper);
+	if (ret)
+		return ERR_PTR(ret);
+
+	ret = drm_event_notifier_register(&hotplug_helper->drm_event_nb);
+	if (ret)
+		return ERR_PTR(ret);
+
+	ret = drmm_add_action_or_reset(drm, drm_hotplug_helper_notifier_unregister,
+				       &hotplug_helper->drm_event_nb);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(drmm_hotplug_helper_init);
diff --git a/include/drm/drm_hotplug_helper.h b/include/drm/drm_hotplug_helper.h
new file mode 100644
index 000000000000..26779a0b6554
--- /dev/null
+++ b/include/drm/drm_hotplug_helper.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2026 GE HealthCare
+ * Author: Luca Ceresoli <luca.ceresoli@bootlin.com>
+ */
+
+#ifndef __DRM_HOTPLUG_HELPER_H__
+#define __DRM_HOTPLUG_HELPER_H__
+
+struct drm_hotplug_helper *drmm_hotplug_helper_init(struct drm_device *drm,
+						    struct drm_encoder *encoder);
+
+#endif /* __DRM_HOTPLUG_HELPER_H__ */

-- 
2.55.0

