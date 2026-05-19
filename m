Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14C75CD4851
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 10:40:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5937C10EC3F;
	Tue, 19 May 2026 10:40:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="fSmkf1oi";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A2CF10EC3F
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 10:40:00 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 1BD601A3628;
 Tue, 19 May 2026 10:39:59 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id E3D7D606E9;
 Tue, 19 May 2026 10:39:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E3D79107E8AF6; 
 Tue, 19 May 2026 12:39:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1779187197; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=McH6p8MthUvLmKOOPwvHkRFvWdztoV3IgrOCuYLQkWE=;
 b=fSmkf1oiSZdbQU3PVujEtU4uMo3qJ2HIxlul9PlIS/+Y7uJaublMm25d50dr44nUMj9WSG
 lhMzBf2aM+XomUtkNCyo4oJrNOB1MRX97xYv2gtuPbpDVXkGHf8k0bFd/OmSa3dc6NSQ9v
 v9JKrs9lIoI6vaZZCWa4kKtakvZTM9AKp7s+1GnOeCl3sLlIBGwxAWPK90ZgTQPJPbQOmo
 iXgi35cF5j4AFsv6BtHMkVL0VeYmFjBquiNL5GeA+v6Oc3yFIPGYubGiuxRS/V4VgMS3Y8
 yckuob23VPFmmBU12Pw+peqW+fxNXVd3Ps2/EzKRJt0VLAU6kdEZ1X6M63hNtg==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Tue, 19 May 2026 12:37:43 +0200
Subject: [PATCH 26/37] drm: event-notifier: add mechanism to notify about
 hotplug events
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-drm-bridge-hotplug-v1-26-45e2bdb3dfb4@bootlin.com>
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

In preparation for supporting DRM bridge hotplug, add an event notifier to
allow interested parties to be notified about events they need to react to.

For the initial implementation of bridge hotplug, two events are needed:
bridge detach (happening in drm_bridge.c) and MIPI device attach to MIPI
host (happening in drm_mipi_dsi.c).

For this reason implement the event notifier in a new common file that
event producers can easily use to send events.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

---

A different approach I have considered is keeping the event notifier in
drm_bridge.c (as in [0]) instead of a new centralized file. But then
another notifier would be needed in drm_mipi_dsi.c for the DSI attach
event. That would be particularly awkward because the designated component
to implement hotplug is the drm_bridge_connector, which would then need to
depend on DRM_MIPI_DSI even though it does nothing MIPI specific.

[0] https://lore.kernel.org/lkml/20250206-hotplug-drm-bridge-v6-12-9d6f2c9c3058@bootlin.com/
---
 drivers/gpu/drm/Kconfig              |  3 ++
 drivers/gpu/drm/Makefile             |  2 ++
 drivers/gpu/drm/drm_event_notifier.c | 58 ++++++++++++++++++++++++++++++++++++
 include/drm/drm_event_notifier.h     | 36 ++++++++++++++++++++++
 4 files changed, 99 insertions(+)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 8f5a8d3012e4..18eb33e0e5a0 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -33,6 +33,9 @@ endmenu
 
 if DRM
 
+config DRM_EVENT_NOTIFIER
+	tristate
+
 config DRM_MIPI_DBI
 	tristate
 	depends on DRM
diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index e97faabcd783..18c9cceacdaa 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -96,6 +96,8 @@ drm-$(CONFIG_DRM_PANIC_SCREEN_QR_CODE) += drm_panic_qr.o
 drm-$(CONFIG_DRM_RAS) += drm_ras.o drm_ras_nl.o drm_ras_genl_family.o
 obj-$(CONFIG_DRM)	+= drm.o
 
+obj-$(CONFIG_DRM_EVENT_NOTIFIER) += drm_event_notifier.o
+
 obj-$(CONFIG_DRM_PANEL_ORIENTATION_QUIRKS) += drm_panel_orientation_quirks.o
 obj-$(CONFIG_DRM_PANEL_BACKLIGHT_QUIRKS) += drm_panel_backlight_quirks.o
 
diff --git a/drivers/gpu/drm/drm_event_notifier.c b/drivers/gpu/drm/drm_event_notifier.c
new file mode 100644
index 000000000000..76af4dd4cdb0
--- /dev/null
+++ b/drivers/gpu/drm/drm_event_notifier.c
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Internal event notifier for DRM drivers
+ *
+ * Copyright (C) 2026 GE HealthCare
+ * Author: Luca Ceresoli <luca.ceresoli@bootlin.com>
+ */
+
+#include <linux/module.h>
+#include <linux/notifier.h>
+
+#include <drm/drm_event_notifier.h>
+
+static BLOCKING_NOTIFIER_HEAD(drm_event_notifier);
+
+/**
+ * drm_event_notifier_register - Register to be notified of DRM events
+ * @nb: the notifier block to be registered
+ *
+ * @nb will be notified of events defined in &drm_event_notifier_event
+ *
+ * Returns 0 on success, %-EEXIST on error.
+ */
+int drm_event_notifier_register(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_register(&drm_event_notifier, nb);
+}
+EXPORT_SYMBOL(drm_event_notifier_register);
+
+/**
+ * drm_event_notifier_unregister - Unregister from be notified of DRM events
+ * @nb: the notifier block to be unregistered
+ *
+ * @nb will stop being notified of events defined in &drm_event_notifier_event
+ *
+ * Returns zero on success or %-ENOENT on failure.
+ */
+int drm_event_notifier_unregister(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_unregister(&drm_event_notifier, nb);
+}
+EXPORT_SYMBOL(drm_event_notifier_unregister);
+
+/**
+ * drm_event_notifier_notify - Emit an event to be notified to registered
+ *                             entities
+ * @event: event ID as defined in &drm_event_notifier_event
+ * @data: metadata associated to the event
+ */
+void drm_event_notifier_notify(unsigned long event, void *data)
+{
+	blocking_notifier_call_chain(&drm_event_notifier, event, data);
+}
+EXPORT_SYMBOL(drm_event_notifier_notify);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Luca Ceresoli <luca.ceresoli@bootlin.com>");
+MODULE_DESCRIPTION("Notifier for DRM components addition/removal and attach/detach");
diff --git a/include/drm/drm_event_notifier.h b/include/drm/drm_event_notifier.h
new file mode 100644
index 000000000000..78afc014ec9a
--- /dev/null
+++ b/include/drm/drm_event_notifier.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Internal event notifier for DRM drivers
+ *
+ * Copyright (C) 2026 GE HealthCare
+ * Author: Luca Ceresoli <luca.ceresoli@bootlin.com>
+ */
+
+#ifndef _DRM_EVENT_NOTIFIER_H_
+#define _DRM_EVENT_NOTIFIER_H_
+
+/**
+ * enum drm_event_notifier_event - DRM bridge events
+ */
+enum drm_event_notifier_event {
+	/**
+	 * @DRM_MIPI_DSI_ATTACHED: A MIPI DSI device has just been attached
+	 * to its MIPI DSI host. @data is a pointer to the &struct
+	 * mipi_dsi_device that has just attached.
+	 */
+	DRM_MIPI_DSI_ATTACHED,
+	/**
+	 * @DRM_BRIDGE_NOTIFY_DETACHED: A bridge has just been detached
+	 * from the encoder bridge chain. Emitted at the end of
+	 * drm_bridge_detach(), after removing the bridge from the encoder
+	 * chain. @data is a pointer to the &struct drm_bridge that has
+	 * just been detached.
+	 */
+	DRM_BRIDGE_DETACHED,
+};
+
+int drm_event_notifier_register(struct notifier_block *nb);
+int drm_event_notifier_unregister(struct notifier_block *nb);
+void drm_event_notifier_notify(unsigned long event, void *data);
+
+#endif /* _DRM_EVENT_NOTIFIER_H_ */

-- 
2.54.0

