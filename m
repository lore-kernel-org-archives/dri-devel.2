Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AA3FCA5FA1
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 16:22:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67AD610EB1A;
	Mon, 28 Sep 2026 16:22:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="M+zThmMz";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3C4010EB17
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 16:22:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A169744009;
 Mon, 28 Sep 2026 16:22:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 741221F000FF;
 Mon, 28 Sep 2026 16:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790612543;
 bh=Tqgsh7ezBrCiF/e0GkvssqPeCJvqCBDQzBUaw0XcIro=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=M+zThmMzTERby8av/lDezTU9D0Jnr9mNiFLFLf/KUBdC4PVZRIct8rvfqjnxayIsG
 yvu9qDeukxBg5/r1DWGIql5Wi+Y88au3wsvad1hc9YxvoWCGOFccVQqpy4rSowzJXH
 BX6rhQXleMhYQr/Ao/5hSxq58Te5JMxwckB+nElXovWXoODRrVkG5jUVqzGjyW3FvQ
 1y2EyXeOZltbsn3e/YQA6odCIiaoMxbaOEg1oTnigpGso9uYp2jVjbaI+BjY8CgZ3T
 rY8fIaRHqL/J385t2U0IbFZq/JG6NCT9+FrCo+cRZc7Jv7lKcmgAh0WNrnKufNIIpW
 DmseDD1giKDVw==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 28 Sep 2026 18:22:02 +0200
Subject: [PATCH 2/6] drm/panel: Add generic MIPI-DSI panel driver with BPF
 init sequences
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260928-drm-mipi-dsi-panel-ebpf-v1-2-5244926aace4@kernel.org>
References: <20260928-drm-mipi-dsi-panel-ebpf-v1-0-5244926aace4@kernel.org>
In-Reply-To: <20260928-drm-mipi-dsi-panel-ebpf-v1-0-5244926aace4@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Albert Esteve <aesteve@redhat.com>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, llvm@lists.linux.dev, 
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 Maxime Ripard <mripard@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=52734; i=mripard@kernel.org;
 h=from:subject:message-id; bh=Sq7nSAYIRm06azl54O3bdnaM/2w84alz0rWLGc/+Dz0=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm7phi+vVv36+CC0jnu1+3k9K/K8/9i3Nv3OFZkYtGhb
 4Jmb0/e7pjKwiDMySArpsjyRCbs9PL2xVUO9it/wMxhZQIZwsDFKQAT6WBmrDNZoys14V+xTvOe
 1r1Gjrb5sRKsBv4zk6+2Rd55O2kex+Ujk0T0gzq8XXluXyj1z2GTZawvZXj2Ytnr7CmfdhdnljA
 x7GB/udtsedTyrfkfD3xcWZih33ZXi19v4lb5nXcdwm/+1y4GAA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
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

Most MIPI-DSI panel drivers reimplement the same boilerplate with
only the init sequence and power-on/off timing varying. However,
each new panel still requires a kernel driver, creating a tension
between OEMs and distributions. OEMs need to support new panels
swiftly to accommodate sourcing and production issues, while
distributions can take years to ship a new kernel.

Replace per-panel modules with a single generic driver whose
panel-specific behavior is provided by BPF programs loaded from
userspace, following the HID-BPF model (drivers/hid/bpf/).

The driver registers a drm_bridge that remains disconnected until
a BPF program attaches, at which point the connector appears and
the display pipeline comes up. This also allows users to force-
enable the pipeline when it makes sense for their setup.

Sleepable kfuncs are exposed to control regulators, GPIOs, and
send and receive DSI data. The rest of the boilerplate is handled
by the driver directly.

Sysfs attributes expose the link configuration so that a
userspace BPF loader can match programs to panels without parsing
the device tree.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/panel/Kconfig                      |   3 +
 drivers/gpu/drm/panel/Makefile                     |   1 +
 drivers/gpu/drm/panel/bpf/Kconfig                  |  28 ++
 drivers/gpu/drm/panel/bpf/Makefile                 |  10 +
 .../gpu/drm/panel/bpf/panel-bpf-mipi-dsi-core.c    | 452 +++++++++++++++++++++
 .../gpu/drm/panel/bpf/panel-bpf-mipi-dsi-kfuncs.c  | 278 +++++++++++++
 drivers/gpu/drm/panel/bpf/panel-bpf-mipi-dsi-ops.c | 242 +++++++++++
 .../gpu/drm/panel/bpf/panel-bpf-mipi-dsi-trace.c   |   4 +
 .../gpu/drm/panel/bpf/panel-bpf-mipi-dsi-trace.h   | 246 +++++++++++
 drivers/gpu/drm/panel/bpf/panel-bpf-mipi-dsi.h     | 264 ++++++++++++
 include/drm/drm_panel_dsi_bpf.h                    |  50 +++
 11 files changed, 1578 insertions(+)

diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index 747f47347521..d885fc4a8eb7 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -1438,6 +1438,9 @@ config DRM_PANEL_XINPENG_XPP055C272
 	depends on BACKLIGHT_CLASS_DEVICE
 	help
 	  Say Y here if you want to enable support for the Xinpeng
 	  XPP055C272 controller for 720x1280 LCD panels with MIPI/RGB/SPI
 	  system interfaces.
+
+source "drivers/gpu/drm/panel/bpf/Kconfig"
+
 endmenu
diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
index f2c9c80a218f..729394961101 100644
--- a/drivers/gpu/drm/panel/Makefile
+++ b/drivers/gpu/drm/panel/Makefile
@@ -8,10 +8,11 @@ obj-$(CONFIG_DRM_PANEL_BOE_BF060Y8M_AJ0) += panel-boe-bf060y8m-aj0.o
 obj-$(CONFIG_DRM_PANEL_BOE_HIMAX8279D) += panel-boe-himax8279d.o
 obj-$(CONFIG_DRM_PANEL_BOE_TD4320) += panel-boe-td4320.o
 obj-$(CONFIG_DRM_PANEL_BOE_TH101MB31UIG002_28A) += panel-boe-th101mb31ig002-28a.o
 obj-$(CONFIG_DRM_PANEL_BOE_TV101WUM_LL2) += panel-boe-tv101wum-ll2.o
 obj-$(CONFIG_DRM_PANEL_BOE_TV101WUM_NL6) += panel-boe-tv101wum-nl6.o
+obj-$(CONFIG_DRM_PANEL_BPF) += bpf/
 obj-$(CONFIG_DRM_PANEL_CHIPONE_ICNA35XX) += panel-chipone-icna35xx.o
 obj-$(CONFIG_DRM_PANEL_CHIPWEALTH_CH13726A) += panel-chipwealth-ch13726a.o
 obj-$(CONFIG_DRM_PANEL_DSI_CM) += panel-dsi-cm.o
 obj-$(CONFIG_DRM_PANEL_LVDS) += panel-lvds.o
 obj-$(CONFIG_DRM_PANEL_SIMPLE) += panel-simple.o
diff --git a/drivers/gpu/drm/panel/bpf/Kconfig b/drivers/gpu/drm/panel/bpf/Kconfig
new file mode 100644
index 000000000000..2331e9fc26cc
--- /dev/null
+++ b/drivers/gpu/drm/panel/bpf/Kconfig
@@ -0,0 +1,28 @@
+# SPDX-License-Identifier: GPL-2.0
+
+config DRM_PANEL_BPF
+	tristate "eBPF-backed panels"
+	depends on DRM && DRM_PANEL
+	depends on BPF_SYSCALL
+	help
+	  TODO
+
+menu "eBPF Display Panels"
+	depends on DRM_PANEL_BPF
+
+config DRM_PANEL_BPF_MIPI_DSI
+	tristate "Generic BPF-based MIPI-DSI panel"
+	depends on BACKLIGHT_CLASS_DEVICE
+	depends on BPF_SYSCALL
+	depends on DRM_MIPI_DSI
+	depends on OF
+	select VIDEOMODE_HELPERS
+	help
+	  Generic MIPI-DSI panel driver that delegates panel-specific
+	  power sequencing and DSI init commands to BPF programs loaded
+	  from userspace.
+
+	  Enable this if you want to support MIPI-DSI panels without
+	  panel-specific kernel drivers.
+
+endmenu
diff --git a/drivers/gpu/drm/panel/bpf/Makefile b/drivers/gpu/drm/panel/bpf/Makefile
new file mode 100644
index 000000000000..07c68ca2eb69
--- /dev/null
+++ b/drivers/gpu/drm/panel/bpf/Makefile
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_DRM_PANEL_BPF_MIPI_DSI) += panel-bpf-mipi-dsi.o
+
+panel-bpf-mipi-dsi-y := panel-bpf-mipi-dsi-core.o \
+			 panel-bpf-mipi-dsi-kfuncs.o \
+			 panel-bpf-mipi-dsi-ops.o \
+			 panel-bpf-mipi-dsi-trace.o
+
+CFLAGS_panel-bpf-mipi-dsi-trace.o := -I$(src)
diff --git a/drivers/gpu/drm/panel/bpf/panel-bpf-mipi-dsi-core.c b/drivers/gpu/drm/panel/bpf/panel-bpf-mipi-dsi-core.c
new file mode 100644
index 000000000000..585f3cc5fda9
--- /dev/null
+++ b/drivers/gpu/drm/panel/bpf/panel-bpf-mipi-dsi-core.c
@@ -0,0 +1,452 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Generic MIPI-DSI panel driver with BPF-based init sequences
+ *
+ * Copyright (C) 2026
+ *
+ * A single generic MIPI-DSI panel driver where the panel-specific
+ * power sequencing and DSI init commands are provided by BPF
+ * struct_ops programs loaded from userspace, following the HID-BPF
+ * model (drivers/hid/bpf/).
+ *
+ * This file handles DT resource acquisition, drm_bridge registration,
+ * and dispatching bridge callbacks to BPF programs. Panel DT nodes
+ * use a fallback compatible:
+ *
+ *   compatible = "elida,kd35t133", "panel-mipi-dsi-bpf";
+ *
+ * The driver matches on "panel-mipi-dsi-bpf". The panel's OF node
+ * path is stored as panel_id for BPF matching. New panels only need
+ * a DT overlay and a BPF program — no kernel driver.
+ *
+ * See panel-bpf-mipi-dsi-ops.c for the struct_ops binding logic and
+ * panel-bpf-mipi-dsi-kfuncs.c for the kfunc interface.
+ */
+
+#include <linux/backlight.h>
+#include <linux/bpf.h>
+#include <linux/gpio/consumer.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/regulator/consumer.h>
+
+#include <video/of_display_timing.h>
+#include <video/videomode.h>
+
+#include <drm/drm_atomic_state_helper.h>
+#include <drm/drm_bridge_connector.h>
+#include <drm/drm_mipi_dsi.h>
+#include <drm/drm_modes.h>
+#include <drm/drm_of.h>
+
+#include "panel-bpf-mipi-dsi.h"
+#include "panel-bpf-mipi-dsi-trace.h"
+
+static LIST_HEAD(panel_bpf_mipi_dsi_list);
+DEFINE_MUTEX(panel_bpf_mipi_dsi_list_lock);
+
+struct panel_bpf_mipi_dsi_entry {
+	struct list_head		list;
+	struct panel_bpf_mipi_dsi	*panel;
+};
+
+static void panel_bpf_mipi_dsi_list_cleanup(void *data)
+{
+	struct panel_bpf_mipi_dsi_entry *entry = data;
+
+	scoped_guard(mutex, &panel_bpf_mipi_dsi_list_lock)
+		list_del(&entry->list);
+}
+
+int panel_bpf_mipi_dsi_list_add(struct panel_bpf_mipi_dsi *panel)
+{
+	struct device *dev = &panel->dsi->dev;
+	struct panel_bpf_mipi_dsi_entry *entry;
+
+	entry = devm_kzalloc(dev, sizeof(*entry), GFP_KERNEL);
+	if (!entry)
+		return -ENOMEM;
+
+	entry->panel = panel;
+
+	scoped_guard(mutex, &panel_bpf_mipi_dsi_list_lock)
+		list_add_tail(&entry->list, &panel_bpf_mipi_dsi_list);
+
+	return devm_add_action_or_reset(dev, panel_bpf_mipi_dsi_list_cleanup,
+					entry);
+}
+
+struct panel_bpf_mipi_dsi *
+panel_bpf_mipi_dsi_find_panel_unlocked(const char *panel_id)
+{
+	struct panel_bpf_mipi_dsi_entry *entry;
+
+	lockdep_assert_held(&panel_bpf_mipi_dsi_list_lock);
+
+	list_for_each_entry(entry, &panel_bpf_mipi_dsi_list, list)
+		if (!strcmp(entry->panel->panel_id, panel_id))
+			return entry->panel;
+
+	return NULL;
+}
+
+#define call_bpf_op(p, op, c)						\
+	({								\
+		struct panel_bpf_mipi_dsi *__bpf_panel = (p);		\
+		int __result = 0;					\
+									\
+		lockdep_assert_held(&__bpf_panel->bpf_lock);		\
+									\
+		if (__bpf_panel->bpf_ops && __bpf_panel->bpf_ops->op) {	\
+			trace_panel_bpf_mipi_dsi_callback(__bpf_panel->panel_id, #op); \
+			__result = __bpf_panel->bpf_ops->op(c);		\
+			trace_panel_bpf_mipi_dsi_callback_done(__bpf_panel->panel_id, #op, \
+							       __result); \
+		}							\
+									\
+		__result;						\
+	})
+
+static void panel_bpf_mipi_dsi_bridge_atomic_pre_enable(struct drm_bridge *bridge,
+							struct drm_atomic_commit *commit)
+{
+	struct panel_bpf_mipi_dsi *panel = drm_bridge_to_bpf_panel(bridge);
+	struct panel_bpf_mipi_dsi_ctx ctx = { .bridge = bridge };
+
+	scoped_guard(mutex, &panel->bpf_lock)
+		call_bpf_op(panel, panel_prepare, &ctx);
+}
+
+static void panel_bpf_mipi_dsi_bridge_atomic_enable(struct drm_bridge *bridge,
+						    struct drm_atomic_commit *commit)
+{
+	struct panel_bpf_mipi_dsi *panel = drm_bridge_to_bpf_panel(bridge);
+	struct panel_bpf_mipi_dsi_ctx ctx = { .bridge = bridge };
+
+	scoped_guard(mutex, &panel->bpf_lock)
+		call_bpf_op(panel, panel_enable, &ctx);
+
+	backlight_enable(panel->backlight);
+}
+
+static void panel_bpf_mipi_dsi_bridge_atomic_disable(struct drm_bridge *bridge,
+						     struct drm_atomic_commit *commit)
+{
+	struct panel_bpf_mipi_dsi *panel = drm_bridge_to_bpf_panel(bridge);
+	struct panel_bpf_mipi_dsi_ctx ctx = { .bridge = bridge };
+
+	backlight_disable(panel->backlight);
+
+	scoped_guard(mutex, &panel->bpf_lock)
+		call_bpf_op(panel, panel_disable, &ctx);
+}
+
+static void panel_bpf_mipi_dsi_bridge_atomic_post_disable(struct drm_bridge *bridge,
+							  struct drm_atomic_commit *commit)
+{
+	struct panel_bpf_mipi_dsi *panel = drm_bridge_to_bpf_panel(bridge);
+	struct panel_bpf_mipi_dsi_ctx ctx = { .bridge = bridge };
+
+	scoped_guard(mutex, &panel->bpf_lock)
+		call_bpf_op(panel, panel_unprepare, &ctx);
+}
+
+static int panel_bpf_mipi_dsi_bridge_get_modes(struct drm_bridge *bridge,
+					       struct drm_connector *connector)
+{
+	struct panel_bpf_mipi_dsi *panel = drm_bridge_to_bpf_panel(bridge);
+	struct drm_display_mode *mode;
+	struct videomode vm;
+
+	videomode_from_timing(&panel->dt, &vm);
+
+	mode = drm_mode_create(connector->dev);
+	if (!mode)
+		return -ENOMEM;
+
+	drm_display_mode_from_videomode(&vm, mode);
+	mode->type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED;
+
+	connector->display_info.width_mm = panel->width_mm;
+	connector->display_info.height_mm = panel->height_mm;
+	drm_connector_set_panel_orientation(connector, panel->orientation);
+
+	drm_mode_probed_add(connector, mode);
+
+	return 1;
+}
+
+/*
+ * Report connected only when a BPF program is attached. This lets
+ * userspace see the connector come up when the BPF loader runs.
+ */
+static enum drm_connector_status
+panel_bpf_mipi_dsi_bridge_detect(struct drm_bridge *bridge,
+				 struct drm_connector *connector)
+{
+	struct panel_bpf_mipi_dsi *panel = drm_bridge_to_bpf_panel(bridge);
+	enum drm_connector_status status;
+
+	scoped_guard(mutex, &panel->bpf_lock)
+		status = panel->bpf_ops ? connector_status_connected :
+			connector_status_disconnected;
+
+	return status;
+}
+
+static int panel_bpf_mipi_dsi_bridge_attach(struct drm_bridge *bridge,
+					    struct drm_encoder *encoder,
+					    enum drm_bridge_attach_flags flags)
+{
+	struct drm_connector *connector;
+
+	if (flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR)
+		return 0;
+
+	connector = drm_bridge_connector_init(bridge->dev, encoder);
+	if (IS_ERR(connector))
+		return PTR_ERR(connector);
+
+	return drm_connector_attach_encoder(connector, encoder);
+}
+
+static const struct drm_bridge_funcs panel_bpf_mipi_dsi_bridge_funcs = {
+	.attach			= panel_bpf_mipi_dsi_bridge_attach,
+	.atomic_create_state	= drm_atomic_helper_bridge_create_state,
+	.atomic_duplicate_state	= drm_atomic_helper_bridge_duplicate_state,
+	.atomic_destroy_state	= drm_atomic_helper_bridge_destroy_state,
+	.detect			= panel_bpf_mipi_dsi_bridge_detect,
+	.atomic_pre_enable	= panel_bpf_mipi_dsi_bridge_atomic_pre_enable,
+	.atomic_enable		= panel_bpf_mipi_dsi_bridge_atomic_enable,
+	.atomic_disable		= panel_bpf_mipi_dsi_bridge_atomic_disable,
+	.atomic_post_disable	= panel_bpf_mipi_dsi_bridge_atomic_post_disable,
+	.get_modes		= panel_bpf_mipi_dsi_bridge_get_modes,
+};
+
+/*
+ * Sysfs attributes exposing the DSI link configuration. These mirror
+ * the DT properties and let userspace (e.g. the BPF loader) read
+ * back the panel's link parameters without parsing the device tree.
+ */
+static const char * const pixel_format_names[] = {
+	[MIPI_DSI_FMT_RGB888]		= "rgb888",
+	[MIPI_DSI_FMT_RGB666]		= "rgb666",
+	[MIPI_DSI_FMT_RGB666_PACKED]	= "rgb666-packed",
+	[MIPI_DSI_FMT_RGB565]		= "rgb565",
+	[MIPI_DSI_FMT_RGB101010]	= "rgb101010",
+};
+
+static ssize_t pixel_format_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	struct mipi_dsi_device *dsi = to_mipi_dsi_device(dev);
+
+	if (dsi->format >= ARRAY_SIZE(pixel_format_names))
+		return sysfs_emit(buf, "unknown(%u)\n", dsi->format);
+
+	return sysfs_emit(buf, "%s\n", pixel_format_names[dsi->format]);
+}
+static DEVICE_ATTR_RO(pixel_format);
+
+static ssize_t lanes_show(struct device *dev,
+			  struct device_attribute *attr, char *buf)
+{
+	struct mipi_dsi_device *dsi = to_mipi_dsi_device(dev);
+
+	return sysfs_emit(buf, "%u\n", dsi->lanes);
+}
+static DEVICE_ATTR_RO(lanes);
+
+static ssize_t mode_flags_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	struct mipi_dsi_device *dsi = to_mipi_dsi_device(dev);
+
+	return sysfs_emit(buf, "0x%lx\n", dsi->mode_flags);
+}
+static DEVICE_ATTR_RO(mode_flags);
+
+static ssize_t hs_rate_show(struct device *dev,
+			    struct device_attribute *attr, char *buf)
+{
+	struct mipi_dsi_device *dsi = to_mipi_dsi_device(dev);
+
+	return sysfs_emit(buf, "%lu\n", dsi->hs_rate);
+}
+static DEVICE_ATTR_RO(hs_rate);
+
+static ssize_t lp_rate_show(struct device *dev,
+			    struct device_attribute *attr, char *buf)
+{
+	struct mipi_dsi_device *dsi = to_mipi_dsi_device(dev);
+
+	return sysfs_emit(buf, "%lu\n", dsi->lp_rate);
+}
+static DEVICE_ATTR_RO(lp_rate);
+
+static struct attribute *panel_bpf_mipi_dsi_attrs[] = {
+	&dev_attr_pixel_format.attr,
+	&dev_attr_lanes.attr,
+	&dev_attr_mode_flags.attr,
+	&dev_attr_hs_rate.attr,
+	&dev_attr_lp_rate.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(panel_bpf_mipi_dsi);
+
+static const char * const panel_bpf_mipi_dsi_supply_names[] = {
+	[PANEL_BPF_MIPI_DSI_SUPPLY_VCC]		= "vcc",
+	[PANEL_BPF_MIPI_DSI_SUPPLY_IOVCC]	= "iovcc",
+	[PANEL_BPF_MIPI_DSI_SUPPLY_AVDD]	= "avdd",
+	[PANEL_BPF_MIPI_DSI_SUPPLY_AVEE]	= "avee",
+	[PANEL_BPF_MIPI_DSI_SUPPLY_ELVDD]	= "elvdd",
+	[PANEL_BPF_MIPI_DSI_SUPPLY_ELVSS]	= "elvss",
+};
+
+static int panel_bpf_mipi_dsi_parse_regulators(struct panel_bpf_mipi_dsi *panel)
+{
+	int i;
+
+	for (i = 0; i < PANEL_BPF_MIPI_DSI_SUPPLY_COUNT; i++)
+		panel->supplies[i].supply = panel_bpf_mipi_dsi_supply_names[i];
+
+	return devm_regulator_bulk_get(&panel->dsi->dev, PANEL_BPF_MIPI_DSI_SUPPLY_COUNT,
+				       panel->supplies);
+}
+
+static int panel_bpf_mipi_dsi_probe(struct mipi_dsi_device *dsi)
+{
+	struct device *dev = &dsi->dev;
+	struct panel_bpf_mipi_dsi *panel;
+	u32 val;
+	int ret;
+
+	panel = devm_drm_bridge_alloc(dev, struct panel_bpf_mipi_dsi, bridge,
+				      &panel_bpf_mipi_dsi_bridge_funcs);
+	if (IS_ERR(panel))
+		return PTR_ERR(panel);
+
+	panel->dsi = dsi;
+	mutex_init(&panel->bpf_lock);
+
+	panel->gpios[PANEL_BPF_MIPI_DSI_GPIO_RESET] =
+		devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(panel->gpios[PANEL_BPF_MIPI_DSI_GPIO_RESET]))
+		return dev_err_probe(dev,
+				     PTR_ERR(panel->gpios[PANEL_BPF_MIPI_DSI_GPIO_RESET]),
+				     "Failed to get reset GPIO\n");
+
+	panel->gpios[PANEL_BPF_MIPI_DSI_GPIO_ENABLE] =
+		devm_gpiod_get_optional(dev, "enable", GPIOD_OUT_LOW);
+	if (IS_ERR(panel->gpios[PANEL_BPF_MIPI_DSI_GPIO_ENABLE]))
+		return dev_err_probe(dev,
+				     PTR_ERR(panel->gpios[PANEL_BPF_MIPI_DSI_GPIO_ENABLE]),
+				     "Failed to get enable GPIO\n");
+
+	ret = panel_bpf_mipi_dsi_parse_regulators(panel);
+	if (ret)
+		return ret;
+
+	ret = drm_of_get_panel_orientation(dev->of_node, &panel->orientation);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to get orientation\n");
+
+	ret = of_get_display_timing(dev->of_node, "panel-timing", &panel->dt);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to get panel-timing\n");
+
+	of_property_read_u32(dev->of_node, "width-mm", &panel->width_mm);
+	of_property_read_u32(dev->of_node, "height-mm", &panel->height_mm);
+
+	panel->backlight = devm_of_find_backlight(dev);
+	if (IS_ERR(panel->backlight))
+		return dev_err_probe(dev, PTR_ERR(panel->backlight),
+				     "Failed to get backlight\n");
+
+	if (!of_property_read_u32(dev->of_node, "dsi-lanes", &val))
+		dsi->lanes = val;
+	else
+		dsi->lanes = 4;
+
+	dsi->format = MIPI_DSI_FMT_RGB888;
+
+	if (of_property_read_bool(dev->of_node, "mode-video"))
+		dsi->mode_flags |= MIPI_DSI_MODE_VIDEO;
+	if (of_property_read_bool(dev->of_node, "mode-video-burst"))
+		dsi->mode_flags |= MIPI_DSI_MODE_VIDEO_BURST;
+	if (of_property_read_bool(dev->of_node, "mode-lpm"))
+		dsi->mode_flags |= MIPI_DSI_MODE_LPM;
+	if (of_property_read_bool(dev->of_node, "mode-no-eot"))
+		dsi->mode_flags |= MIPI_DSI_MODE_NO_EOT_PACKET;
+	if (of_property_read_bool(dev->of_node, "clock-non-continuous"))
+		dsi->mode_flags |= MIPI_DSI_CLOCK_NON_CONTINUOUS;
+
+	if (!of_property_read_u32(dev->of_node, "hs-rate", &val))
+		dsi->hs_rate = val;
+	if (!of_property_read_u32(dev->of_node, "lp-rate", &val))
+		dsi->lp_rate = val;
+
+	mipi_dsi_set_drvdata(dsi, panel);
+
+	panel->bridge.type = DRM_MODE_CONNECTOR_DSI;
+	panel->bridge.ops = DRM_BRIDGE_OP_DETECT | DRM_BRIDGE_OP_MODES;
+	panel->bridge.of_node = dev->of_node;
+	panel->bridge.pre_enable_prev_first = true;
+
+	snprintf(panel->panel_id, sizeof(panel->panel_id), "%pOF",
+		 dev->of_node);
+
+	ret = panel_bpf_mipi_dsi_list_add(panel);
+	if (ret)
+		return ret;
+
+	ret = devm_drm_bridge_add(dev, &panel->bridge);
+	if (ret)
+		return ret;
+
+	ret = devm_mipi_dsi_attach(dev, dsi);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "mipi_dsi_attach failed\n");
+
+	return 0;
+}
+
+static const struct of_device_id panel_bpf_mipi_dsi_of_match[] = {
+	{ .compatible = "panel-mipi-dsi-bpf" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, panel_bpf_mipi_dsi_of_match);
+
+static struct mipi_dsi_driver panel_bpf_mipi_dsi_driver = {
+	.driver = {
+		.name		= "panel-bpf-mipi-dsi",
+		.of_match_table	= panel_bpf_mipi_dsi_of_match,
+		.dev_groups	= panel_bpf_mipi_dsi_groups,
+	},
+	.probe	= panel_bpf_mipi_dsi_probe,
+};
+
+static int __init panel_bpf_mipi_dsi_init(void)
+{
+	int ret;
+
+	ret = panel_bpf_mipi_dsi_register_struct_ops();
+	if (ret)
+		return ret;
+
+	ret = panel_bpf_mipi_dsi_register_kfuncs();
+	if (ret)
+		return ret;
+
+	return mipi_dsi_driver_register(&panel_bpf_mipi_dsi_driver);
+}
+module_init(panel_bpf_mipi_dsi_init);
+
+static void __exit panel_bpf_mipi_dsi_exit(void)
+{
+	mipi_dsi_driver_unregister(&panel_bpf_mipi_dsi_driver);
+}
+module_exit(panel_bpf_mipi_dsi_exit);
+
+MODULE_DESCRIPTION("Generic MIPI-DSI panel driver with BPF init sequences");
+MODULE_LICENSE("GPL");
diff --git a/drivers/gpu/drm/panel/bpf/panel-bpf-mipi-dsi-kfuncs.c b/drivers/gpu/drm/panel/bpf/panel-bpf-mipi-dsi-kfuncs.c
new file mode 100644
index 000000000000..d44c61382c77
--- /dev/null
+++ b/drivers/gpu/drm/panel/bpf/panel-bpf-mipi-dsi-kfuncs.c
@@ -0,0 +1,278 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <linux/btf.h>
+#include <linux/btf_ids.h>
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/regulator/consumer.h>
+
+#include <drm/drm_mipi_dsi.h>
+
+#include "panel-bpf-mipi-dsi.h"
+#include "panel-bpf-mipi-dsi-trace.h"
+
+static const char * const panel_bpf_mipi_dsi_gpio_names[] = {
+	[PANEL_BPF_MIPI_DSI_GPIO_ENABLE]	= "enable",
+	[PANEL_BPF_MIPI_DSI_GPIO_RESET]		= "reset",
+};
+
+__bpf_kfunc_start_defs();
+
+/**
+ * panel_bpf_mipi_dsi_regulator_enable_and_wait - Enable a supply and wait
+ * @ctx: Panel context passed to the BPF callback
+ * @supply: Which supply to enable (VCC, IOVCC, AVDD, ...)
+ * @settle_ms: Milliseconds to sleep after enabling
+ *
+ * Enable the regulator identified by @supply and optionally sleep for
+ * @settle_ms to let the voltage stabilize.
+ *
+ * If the regulator was not specified in the DT, this function is a
+ * no-op.
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+__bpf_kfunc int panel_bpf_mipi_dsi_regulator_enable_and_wait(struct panel_bpf_mipi_dsi_ctx *ctx,
+							     enum panel_bpf_mipi_dsi_supply supply,
+							     u32 settle_ms)
+{
+	struct panel_bpf_mipi_dsi *panel = bpf_ctx_to_bpf_panel(ctx);
+	int ret;
+
+	if (supply >= PANEL_BPF_MIPI_DSI_SUPPLY_COUNT)
+		return -EINVAL;
+
+	trace_panel_bpf_mipi_dsi_regulator_enable_and_wait(panel->panel_id,
+							   panel->supplies[supply].supply,
+							   settle_ms);
+
+	ret = regulator_enable(panel->supplies[supply].consumer);
+
+	if (settle_ms)
+		msleep(settle_ms);
+
+	return ret;
+}
+
+/**
+ * panel_bpf_mipi_dsi_regulator_disable - Disable a supply
+ * @ctx: Panel context passed to the BPF callback
+ * @supply: Which supply to disable (VCC, IOVCC, AVDD, ...)
+ *
+ * Disable the regulator identified by @supply. Typically called
+ * from panel_unprepare after the panel has been put to sleep.
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+__bpf_kfunc int panel_bpf_mipi_dsi_regulator_disable(struct panel_bpf_mipi_dsi_ctx *ctx,
+						     enum panel_bpf_mipi_dsi_supply supply)
+{
+	struct panel_bpf_mipi_dsi *panel = bpf_ctx_to_bpf_panel(ctx);
+
+	if (supply >= PANEL_BPF_MIPI_DSI_SUPPLY_COUNT)
+		return -EINVAL;
+
+	trace_panel_bpf_mipi_dsi_regulator_disable(panel->panel_id,
+						   panel->supplies[supply].supply);
+
+	return regulator_disable(panel->supplies[supply].consumer);
+}
+
+/**
+ * panel_bpf_mipi_dsi_gpio_cycle_and_wait - Pulse a GPIO high then low
+ * @ctx: Panel context passed to the BPF callback
+ * @gpio: Which GPIO to cycle (RESET, ENABLE)
+ * @assert_ms: Milliseconds to hold the GPIO asserted
+ * @settle_ms: Milliseconds to sleep after deasserting
+ *
+ * Assert @gpio (set to 1), hold for @assert_ms, deassert (set to 0),
+ * then sleep for @settle_ms. This is the standard reset pulse
+ * sequence used by most MIPI-DSI panels.
+ *
+ * If the GPIO was not specified in the DT, this function is a no-op.
+ */
+__bpf_kfunc void panel_bpf_mipi_dsi_gpio_cycle_and_wait(struct panel_bpf_mipi_dsi_ctx *ctx,
+							enum panel_bpf_mipi_dsi_gpio gpio,
+							u32 assert_ms, u32 settle_ms)
+{
+	struct panel_bpf_mipi_dsi *panel = bpf_ctx_to_bpf_panel(ctx);
+
+	if (gpio >= PANEL_BPF_MIPI_DSI_GPIO_COUNT)
+		return;
+
+	trace_panel_bpf_mipi_dsi_gpio_cycle_and_wait(panel->panel_id,
+						     panel_bpf_mipi_dsi_gpio_names[gpio],
+						     assert_ms, settle_ms);
+
+	gpiod_set_value_cansleep(panel->gpios[gpio], 1);
+
+	if (assert_ms)
+		msleep(assert_ms);
+
+	gpiod_set_value_cansleep(panel->gpios[gpio], 0);
+
+	if (settle_ms)
+		msleep(settle_ms);
+}
+
+/**
+ * panel_bpf_mipi_dsi_gpio_enable - Assert a GPIO
+ * @ctx: Panel context passed to the BPF callback
+ * @gpio: Which GPIO to assert (RESET, ENABLE)
+ *
+ * Set @gpio to its active state (logical 1). Typically used in
+ * panel_unprepare to hold reset asserted while the panel is off.
+ */
+__bpf_kfunc void panel_bpf_mipi_dsi_gpio_enable(struct panel_bpf_mipi_dsi_ctx *ctx,
+						 enum panel_bpf_mipi_dsi_gpio gpio)
+{
+	struct panel_bpf_mipi_dsi *panel = bpf_ctx_to_bpf_panel(ctx);
+
+	if (gpio >= PANEL_BPF_MIPI_DSI_GPIO_COUNT)
+		return;
+
+	trace_panel_bpf_mipi_dsi_gpio_enable(panel->panel_id,
+					     panel_bpf_mipi_dsi_gpio_names[gpio]);
+
+	gpiod_set_value_cansleep(panel->gpios[gpio], 1);
+}
+
+/**
+ * panel_bpf_mipi_dsi_gpio_disable - Deassert a GPIO
+ * @ctx: Panel context passed to the BPF callback
+ * @gpio: Which GPIO to deassert (RESET, ENABLE)
+ *
+ * Set @gpio to its inactive state (logical 0).
+ */
+__bpf_kfunc void panel_bpf_mipi_dsi_gpio_disable(struct panel_bpf_mipi_dsi_ctx *ctx,
+						 enum panel_bpf_mipi_dsi_gpio gpio)
+{
+	struct panel_bpf_mipi_dsi *panel = bpf_ctx_to_bpf_panel(ctx);
+
+	if (gpio >= PANEL_BPF_MIPI_DSI_GPIO_COUNT)
+		return;
+
+	trace_panel_bpf_mipi_dsi_gpio_disable(panel->panel_id,
+					      panel_bpf_mipi_dsi_gpio_names[gpio]);
+
+	gpiod_set_value_cansleep(panel->gpios[gpio], 0);
+}
+
+/**
+ * panel_bpf_mipi_dsi_dcs_write_and_wait - Send a DCS command and wait
+ * @ctx: Panel context passed to the BPF callback
+ * @cmd: DCS command byte
+ * @data__nullable: Payload bytes following the command, or NULL
+ * @data__nullable__sz: Size of @data__nullable in bytes
+ * @settle_ms: Milliseconds to sleep after sending
+ *
+ * Send a MIPI DCS command with optional payload over the DSI link, with
+ * a post-send sleep of @settle_ms. Typically used for commands like
+ * MIPI_DCS_EXIT_SLEEP_MODE.
+ *
+ * Return: Number of bytes written on success, negative errno on
+ * failure.
+ */
+__bpf_kfunc int panel_bpf_mipi_dsi_dcs_write_and_wait(struct panel_bpf_mipi_dsi_ctx *ctx,
+						      u8 cmd, const u8 *data__nullable,
+						      u32 data__nullable__sz,
+						      u32 settle_ms)
+{
+	struct panel_bpf_mipi_dsi *panel = bpf_ctx_to_bpf_panel(ctx);
+	int ret;
+
+	trace_panel_bpf_mipi_dsi_dcs_write_and_wait(panel->panel_id, cmd, data__nullable,
+						    data__nullable__sz, settle_ms);
+
+	ret = mipi_dsi_dcs_write(panel->dsi, cmd, data__nullable,
+				 data__nullable__sz);
+
+	if (settle_ms)
+		msleep(settle_ms);
+
+	return ret;
+}
+
+/**
+ * panel_bpf_mipi_dsi_generic_write_and_wait - Send a generic DSI write and wait
+ * @ctx: Panel context passed to the BPF callback
+ * @data: Payload bytes to send
+ * @data__sz: Size of @data in bytes
+ * @settle_ms: Milliseconds to sleep after sending
+ *
+ * Send a generic (non-DCS) MIPI DSI write over the DSI link, then
+ * sleep for @settle_ms. Used for vendor-specific commands that do
+ * not follow the DCS command format.
+ *
+ * Return: Number of bytes written on success, negative errno on
+ * failure.
+ */
+__bpf_kfunc int panel_bpf_mipi_dsi_generic_write_and_wait(struct panel_bpf_mipi_dsi_ctx *ctx,
+							  const u8 *data, u32 data__sz,
+							  u32 settle_ms)
+{
+	struct panel_bpf_mipi_dsi *panel = bpf_ctx_to_bpf_panel(ctx);
+	int ret;
+
+	trace_panel_bpf_mipi_dsi_generic_write_and_wait(panel->panel_id,
+							data, data__sz,
+							settle_ms);
+
+	ret = mipi_dsi_generic_write(panel->dsi, data, data__sz);
+	if (settle_ms)
+		msleep(settle_ms);
+
+	return ret;
+}
+
+/**
+ * panel_bpf_mipi_dsi_dcs_read - Read a DCS register
+ * @ctx: Panel context passed to the BPF callback
+ * @cmd: DCS command byte to read
+ * @data: Buffer to store the response
+ * @data__sz: Size of @data in bytes
+ *
+ * Send a DCS read command and store the response in @data. Useful for
+ * reading panel identification registers or status during init.
+ *
+ * Return: Number of bytes read on success, negative errno on failure.
+ */
+__bpf_kfunc int panel_bpf_mipi_dsi_dcs_read(struct panel_bpf_mipi_dsi_ctx *ctx,
+					    u8 cmd, u8 *data, u32 data__sz)
+{
+	struct panel_bpf_mipi_dsi *panel = bpf_ctx_to_bpf_panel(ctx);
+	int ret;
+
+	trace_panel_bpf_mipi_dsi_dcs_read(panel->panel_id, cmd, data__sz);
+
+	ret = mipi_dsi_dcs_read(panel->dsi, cmd, data, data__sz);
+
+	trace_panel_bpf_mipi_dsi_dcs_read_done(panel->panel_id, cmd, data__sz, ret);
+
+	return ret;
+}
+
+__bpf_kfunc_end_defs();
+
+BTF_KFUNCS_START(panel_bpf_mipi_dsi_kfunc_ids)
+BTF_ID_FLAGS(func, panel_bpf_mipi_dsi_regulator_enable_and_wait, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, panel_bpf_mipi_dsi_regulator_disable, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, panel_bpf_mipi_dsi_gpio_cycle_and_wait, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, panel_bpf_mipi_dsi_gpio_enable, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, panel_bpf_mipi_dsi_gpio_disable, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, panel_bpf_mipi_dsi_dcs_write_and_wait, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, panel_bpf_mipi_dsi_generic_write_and_wait, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, panel_bpf_mipi_dsi_dcs_read, KF_SLEEPABLE)
+BTF_KFUNCS_END(panel_bpf_mipi_dsi_kfunc_ids)
+
+static const struct btf_kfunc_id_set panel_bpf_mipi_dsi_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set   = &panel_bpf_mipi_dsi_kfunc_ids,
+};
+
+int panel_bpf_mipi_dsi_register_kfuncs(void)
+{
+	return register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
+					 &panel_bpf_mipi_dsi_kfunc_set);
+}
diff --git a/drivers/gpu/drm/panel/bpf/panel-bpf-mipi-dsi-ops.c b/drivers/gpu/drm/panel/bpf/panel-bpf-mipi-dsi-ops.c
new file mode 100644
index 000000000000..345b9aadaae7
--- /dev/null
+++ b/drivers/gpu/drm/panel/bpf/panel-bpf-mipi-dsi-ops.c
@@ -0,0 +1,242 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * BPF struct_ops for the generic MIPI-DSI panel driver
+ *
+ * Implements the struct_ops callbacks that let BPF programs provide
+ * drm_panel_dsi_bpf_ops.
+ */
+
+#include <linux/bpf.h>
+#include <linux/btf.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/string.h>
+
+#include <drm/drm_mipi_dsi.h>
+
+#include "panel-bpf-mipi-dsi.h"
+#include "panel-bpf-mipi-dsi-trace.h"
+
+/* Required by bpf_struct_ops_desc_init(), which calls it unconditionally. */
+static int panel_bpf_mipi_dsi_bpf_init(struct btf *btf)
+{
+	return 0;
+}
+
+/*
+ * Copy non-function fields from the userspace struct_ops map into the
+ * kernel instance. The BPF verifier rejects non-zero values in fields
+ * that are not explicitly handled here, so every data field must have
+ * a case. Return 1 to indicate the field was consumed.
+ */
+static int panel_bpf_mipi_dsi_bpf_init_member(const struct btf_type *t,
+					      const struct btf_member *member,
+					      void *kdata, const void *udata)
+{
+	const struct drm_panel_dsi_bpf_ops *uops =
+		(const struct drm_panel_dsi_bpf_ops *)udata;
+	struct drm_panel_dsi_bpf_ops *kops =
+		(struct drm_panel_dsi_bpf_ops *)kdata;
+	u32 moff;
+
+	moff = __btf_member_bit_offset(t, member) / 8;
+
+	switch (moff) {
+	case offsetof(struct drm_panel_dsi_bpf_ops, panel_id):
+		memcpy(kops->panel_id, uops->panel_id,
+		       sizeof(kops->panel_id));
+		return 1;
+	case offsetof(struct drm_panel_dsi_bpf_ops, compatible):
+		memcpy(kops->compatible, uops->compatible,
+		       sizeof(kops->compatible));
+		return 1;
+	case offsetof(struct drm_panel_dsi_bpf_ops, format):
+		kops->format = uops->format;
+		return 1;
+	case offsetof(struct drm_panel_dsi_bpf_ops, lanes):
+		kops->lanes = uops->lanes;
+		return 1;
+	case offsetof(struct drm_panel_dsi_bpf_ops, mode_flags):
+		kops->mode_flags = uops->mode_flags;
+		return 1;
+	case offsetof(struct drm_panel_dsi_bpf_ops, hs_rate):
+		kops->hs_rate = uops->hs_rate;
+		return 1;
+	case offsetof(struct drm_panel_dsi_bpf_ops, lp_rate):
+		kops->lp_rate = uops->lp_rate;
+		return 1;
+	}
+
+	return 0;
+}
+
+/*
+ * Validate that the DSI link parameters compiled into the BPF program
+ * match what the DT describes. Rejects mismatches early so a BPF
+ * program built for a different panel variant cannot silently attach.
+ */
+static int panel_bpf_mipi_dsi_bpf_check_config(struct panel_bpf_mipi_dsi *panel,
+					       struct drm_panel_dsi_bpf_ops *ops)
+{
+	struct mipi_dsi_device *dsi = panel->dsi;
+	struct device *dev = &dsi->dev;
+
+	if (!of_device_is_compatible(dev->of_node, ops->compatible)) {
+		dev_err(dev,
+			"BPF compatible \"%s\" doesn't match panel\n",
+			ops->compatible);
+		return -EINVAL;
+	}
+
+	if (ops->format != dsi->format) {
+		dev_err(dev,
+			"BPF pixel format %u doesn't match DT format %u\n",
+			ops->format, dsi->format);
+		return -EINVAL;
+	}
+
+	if (ops->lanes != dsi->lanes) {
+		dev_err(dev,
+			"BPF lanes %u doesn't match DT lanes %u\n",
+			ops->lanes, dsi->lanes);
+		return -EINVAL;
+	}
+
+	if (ops->mode_flags != dsi->mode_flags) {
+		dev_err(dev,
+			"BPF mode_flags 0x%lx doesn't match DT mode_flags 0x%lx\n",
+			ops->mode_flags, dsi->mode_flags);
+		return -EINVAL;
+	}
+
+	if (ops->hs_rate != dsi->hs_rate) {
+		dev_err(dev,
+			"BPF hs_rate %lu doesn't match DT hs_rate %lu\n",
+			ops->hs_rate, dsi->hs_rate);
+		return -EINVAL;
+	}
+
+	if (ops->lp_rate != dsi->lp_rate) {
+		dev_err(dev,
+			"BPF lp_rate %lu doesn't match DT lp_rate %lu\n",
+			ops->lp_rate, dsi->lp_rate);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/*
+ * Bind a BPF program to its target panel. Called when the struct_ops
+ * link is activated. Returns -ENODEV if no panel matches, -EBUSY if
+ * a program is already attached.
+ */
+static int panel_bpf_mipi_dsi_bpf_reg(void *kdata, struct bpf_link *link)
+{
+	struct drm_panel_dsi_bpf_ops *ops = kdata;
+	struct panel_bpf_mipi_dsi *panel;
+	int ret;
+
+	trace_panel_bpf_mipi_dsi_reg(ops->panel_id);
+
+	guard(mutex)(&panel_bpf_mipi_dsi_list_lock);
+
+	panel = panel_bpf_mipi_dsi_find_panel_unlocked(ops->panel_id);
+	if (!panel)
+		return -ENODEV;
+
+	guard(mutex)(&panel->bpf_lock);
+
+	if (panel->bpf_ops)
+		return -EBUSY;
+
+	ret = panel_bpf_mipi_dsi_bpf_check_config(panel, ops);
+	if (ret)
+		return ret;
+
+	ops->bridge = &panel->bridge;
+	panel->bpf_ops = ops;
+
+	return 0;
+}
+
+/*
+ * Detach a BPF program from its panel. The bridge stays registered so
+ * the display pipeline is not torn down — callbacks become no-ops
+ * until a new program attaches.
+ */
+static void panel_bpf_mipi_dsi_bpf_unreg(void *kdata, struct bpf_link *link)
+{
+	struct drm_panel_dsi_bpf_ops *ops = kdata;
+	struct panel_bpf_mipi_dsi *panel;
+
+	trace_panel_bpf_mipi_dsi_unreg(ops->panel_id);
+
+	if (!ops->bridge)
+		return;
+
+	panel = drm_bridge_to_bpf_panel(ops->bridge);
+
+	scoped_guard(mutex, &panel->bpf_lock) {
+		panel->bpf_ops = NULL;
+		ops->bridge = NULL;
+	}
+}
+
+static bool panel_bpf_mipi_dsi_verifier_is_valid_access(int off, int size,
+							enum bpf_access_type type,
+							const struct bpf_prog *prog,
+							struct bpf_insn_access_aux *info)
+{
+	return bpf_tracing_btf_ctx_access(off, size, type, prog, info);
+}
+
+static const struct bpf_verifier_ops panel_bpf_mipi_dsi_bpf_verifier_ops = {
+	.get_func_proto		= bpf_base_func_proto,
+	.is_valid_access	= panel_bpf_mipi_dsi_verifier_is_valid_access,
+};
+
+/* CFI stubs — no-op targets for indirect call validation (CONFIG_CFI_CLANG). */
+static int panel_bpf_mipi_dsi_cfi_stub_prepare(struct panel_bpf_mipi_dsi_ctx *ctx)
+{
+	return 0;
+}
+
+static int panel_bpf_mipi_dsi_cfi_stub_unprepare(struct panel_bpf_mipi_dsi_ctx *ctx)
+{
+	return 0;
+}
+
+static int panel_bpf_mipi_dsi_cfi_stub_enable(struct panel_bpf_mipi_dsi_ctx *ctx)
+{
+	return 0;
+}
+
+static int panel_bpf_mipi_dsi_cfi_stub_disable(struct panel_bpf_mipi_dsi_ctx *ctx)
+{
+	return 0;
+}
+
+static struct drm_panel_dsi_bpf_ops panel_bpf_mipi_dsi_bpf_struct_ops_cfi_stubs = {
+	.panel_prepare		= panel_bpf_mipi_dsi_cfi_stub_prepare,
+	.panel_unprepare	= panel_bpf_mipi_dsi_cfi_stub_unprepare,
+	.panel_enable		= panel_bpf_mipi_dsi_cfi_stub_enable,
+	.panel_disable		= panel_bpf_mipi_dsi_cfi_stub_disable,
+};
+
+static struct bpf_struct_ops panel_bpf_mipi_dsi_bpf_struct_ops = {
+	.verifier_ops	= &panel_bpf_mipi_dsi_bpf_verifier_ops,
+	.init		= panel_bpf_mipi_dsi_bpf_init,
+	.init_member	= panel_bpf_mipi_dsi_bpf_init_member,
+	.reg		= panel_bpf_mipi_dsi_bpf_reg,
+	.unreg		= panel_bpf_mipi_dsi_bpf_unreg,
+	.name		= "drm_panel_dsi_bpf_ops",
+	.cfi_stubs	= &panel_bpf_mipi_dsi_bpf_struct_ops_cfi_stubs,
+	.owner		= THIS_MODULE,
+};
+
+int panel_bpf_mipi_dsi_register_struct_ops(void)
+{
+	return register_bpf_struct_ops(&panel_bpf_mipi_dsi_bpf_struct_ops,
+				       drm_panel_dsi_bpf_ops);
+}
diff --git a/drivers/gpu/drm/panel/bpf/panel-bpf-mipi-dsi-trace.c b/drivers/gpu/drm/panel/bpf/panel-bpf-mipi-dsi-trace.c
new file mode 100644
index 000000000000..0822494b0be1
--- /dev/null
+++ b/drivers/gpu/drm/panel/bpf/panel-bpf-mipi-dsi-trace.c
@@ -0,0 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define CREATE_TRACE_POINTS
+#include "panel-bpf-mipi-dsi-trace.h"
diff --git a/drivers/gpu/drm/panel/bpf/panel-bpf-mipi-dsi-trace.h b/drivers/gpu/drm/panel/bpf/panel-bpf-mipi-dsi-trace.h
new file mode 100644
index 000000000000..5a64ba4509a5
--- /dev/null
+++ b/drivers/gpu/drm/panel/bpf/panel-bpf-mipi-dsi-trace.h
@@ -0,0 +1,246 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#if !defined(_PANEL_BPF_MIPI_DSI_TRACE_H_) || defined(TRACE_HEADER_MULTI_READ)
+#define _PANEL_BPF_MIPI_DSI_TRACE_H_
+
+#include <linux/tracepoint.h>
+#include <linux/types.h>
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM panel_bpf
+#define TRACE_INCLUDE_FILE panel-bpf-mipi-dsi-trace
+
+TRACE_EVENT(panel_bpf_mipi_dsi_callback,
+	    TP_PROTO(const char *panel, const char *name),
+	    TP_ARGS(panel, name),
+	    TP_STRUCT__entry(
+		__string(panel, panel)
+		__string(name, name)
+	    ),
+	    TP_fast_assign(
+		__assign_str(panel);
+		__assign_str(name);
+	    ),
+	    TP_printk("panel=%s callback=%s",
+		      __get_str(panel), __get_str(name))
+);
+
+TRACE_EVENT(panel_bpf_mipi_dsi_callback_done,
+	    TP_PROTO(const char *panel, const char *name, int ret),
+	    TP_ARGS(panel, name, ret),
+	    TP_STRUCT__entry(
+		__string(panel, panel)
+		__string(name, name)
+		__field(int, ret)
+	    ),
+	    TP_fast_assign(
+		__assign_str(panel);
+		__assign_str(name);
+		__entry->ret = ret;
+	    ),
+	    TP_printk("panel=%s callback=%s ret=%d",
+		      __get_str(panel), __get_str(name), __entry->ret)
+);
+
+TRACE_EVENT(panel_bpf_mipi_dsi_reg,
+	    TP_PROTO(const char *panel),
+	    TP_ARGS(panel),
+	    TP_STRUCT__entry(
+		__string(panel, panel)
+	    ),
+	    TP_fast_assign(
+		__assign_str(panel);
+	    ),
+	    TP_printk("panel=%s", __get_str(panel))
+);
+
+TRACE_EVENT(panel_bpf_mipi_dsi_unreg,
+	    TP_PROTO(const char *panel),
+	    TP_ARGS(panel),
+	    TP_STRUCT__entry(
+		__string(panel, panel)
+	    ),
+	    TP_fast_assign(
+		__assign_str(panel);
+	    ),
+	    TP_printk("panel=%s", __get_str(panel))
+);
+
+TRACE_EVENT(panel_bpf_mipi_dsi_dcs_write_and_wait,
+	    TP_PROTO(const char *panel, u8 cmd, const u8 *data, u32 len,
+		     int ret),
+	    TP_ARGS(panel, cmd, data, len, ret),
+	    TP_STRUCT__entry(
+		__string(panel, panel)
+		__field(u8, cmd)
+		__field(u32, len)
+		__field(int, ret)
+		__array(u8, data, 8)
+	    ),
+	    TP_fast_assign(
+		unsigned int n = min_t(u32, len, 8);
+
+		__assign_str(panel);
+		__entry->cmd = cmd;
+		__entry->len = len;
+		__entry->ret = ret;
+		memset(__entry->data, 0, 8);
+		if (n && data)
+			memcpy(__entry->data, data, n);
+	    ),
+	    TP_printk("panel=%s cmd=0x%02x len=%u data=%s ret=%d",
+		      __get_str(panel), __entry->cmd, __entry->len,
+		      __print_hex(__entry->data, min_t(u32, __entry->len, 8)),
+		      __entry->ret)
+);
+
+TRACE_EVENT(panel_bpf_mipi_dsi_generic_write_and_wait,
+	    TP_PROTO(const char *panel, const u8 *data, u32 len, int ret),
+	    TP_ARGS(panel, data, len, ret),
+	    TP_STRUCT__entry(
+		__string(panel, panel)
+		__field(u32, len)
+		__field(int, ret)
+		__array(u8, data, 8)
+	    ),
+	    TP_fast_assign(
+		unsigned int n = min_t(u32, len, 8);
+
+		__assign_str(panel);
+		__entry->len = len;
+		__entry->ret = ret;
+		memset(__entry->data, 0, 8);
+		if (n && data)
+			memcpy(__entry->data, data, n);
+	    ),
+	    TP_printk("panel=%s len=%u data=%s ret=%d",
+		      __get_str(panel), __entry->len,
+		      __print_hex(__entry->data, min_t(u32, __entry->len, 8)),
+		      __entry->ret)
+);
+
+TRACE_EVENT(panel_bpf_mipi_dsi_dcs_read,
+	    TP_PROTO(const char *panel, u8 cmd, u32 len),
+	    TP_ARGS(panel, cmd, len),
+	    TP_STRUCT__entry(
+		__string(panel, panel)
+		__field(u8, cmd)
+		__field(u32, len)
+	    ),
+	    TP_fast_assign(
+		__assign_str(panel);
+		__entry->cmd = cmd;
+		__entry->len = len;
+	    ),
+	    TP_printk("panel=%s cmd=0x%02x len=%u",
+		      __get_str(panel), __entry->cmd, __entry->len)
+);
+
+TRACE_EVENT(panel_bpf_mipi_dsi_dcs_read_done,
+	    TP_PROTO(const char *panel, u8 cmd, u32 len, int ret),
+	    TP_ARGS(panel, cmd, len, ret),
+	    TP_STRUCT__entry(
+		__string(panel, panel)
+		__field(u8, cmd)
+		__field(u32, len)
+		__field(int, ret)
+	    ),
+	    TP_fast_assign(
+		__assign_str(panel);
+		__entry->cmd = cmd;
+		__entry->len = len;
+		__entry->ret = ret;
+	    ),
+	    TP_printk("panel=%s cmd=0x%02x len=%u ret=%d",
+		      __get_str(panel), __entry->cmd, __entry->len,
+		      __entry->ret)
+);
+
+TRACE_EVENT(panel_bpf_mipi_dsi_gpio_cycle_and_wait,
+	    TP_PROTO(const char *panel, const char *name, u32 assert_ms, u32 wait_ms),
+	    TP_ARGS(panel, name, assert_ms, wait_ms),
+	    TP_STRUCT__entry(
+		__string(panel, panel)
+		__string(name, name)
+		__field(u32, assert_ms)
+		__field(u32, wait_ms)
+	    ),
+	    TP_fast_assign(
+		__assign_str(panel);
+		__assign_str(name);
+		__entry->assert_ms = assert_ms;
+		__entry->wait_ms = wait_ms;
+	    ),
+	    TP_printk("panel=%s gpio=%s assert_ms=%u wait_ms=%u",
+		      __get_str(panel), __get_str(name),
+		      __entry->assert_ms, __entry->wait_ms)
+);
+
+TRACE_EVENT(panel_bpf_mipi_dsi_gpio_enable,
+	    TP_PROTO(const char *panel, const char *name),
+	    TP_ARGS(panel, name),
+	    TP_STRUCT__entry(
+		__string(panel, panel)
+		__string(name, name)
+	    ),
+	    TP_fast_assign(
+		__assign_str(panel);
+		__assign_str(name);
+	    ),
+	    TP_printk("panel=%s gpio=%s",
+		      __get_str(panel), __get_str(name))
+);
+
+TRACE_EVENT(panel_bpf_mipi_dsi_gpio_disable,
+	    TP_PROTO(const char *panel, const char *name),
+	    TP_ARGS(panel, name),
+	    TP_STRUCT__entry(
+		__string(panel, panel)
+		__string(name, name)
+	    ),
+	    TP_fast_assign(
+		__assign_str(panel);
+		__assign_str(name);
+	    ),
+	    TP_printk("panel=%s gpio=%s",
+		      __get_str(panel), __get_str(name))
+);
+
+TRACE_EVENT(panel_bpf_mipi_dsi_regulator_enable_and_wait,
+	    TP_PROTO(const char *panel, const char *name, u32 wait_ms),
+	    TP_ARGS(panel, name, wait_ms),
+	    TP_STRUCT__entry(
+		__string(panel, panel)
+		__string(name, name)
+		__field(u32, wait_ms)
+	    ),
+	    TP_fast_assign(
+		__assign_str(panel);
+		__assign_str(name);
+		__entry->wait_ms = wait_ms;
+	    ),
+	    TP_printk("panel=%s supply=%s wait_ms=%u",
+		      __get_str(panel), __get_str(name),
+		      __entry->wait_ms)
+);
+
+TRACE_EVENT(panel_bpf_mipi_dsi_regulator_disable,
+	    TP_PROTO(const char *panel, const char *name),
+	    TP_ARGS(panel, name),
+	    TP_STRUCT__entry(
+		__string(panel, panel)
+		__string(name, name)
+	    ),
+	    TP_fast_assign(
+		__assign_str(panel);
+		__assign_str(name);
+	    ),
+	    TP_printk("panel=%s supply=%s",
+		      __get_str(panel), __get_str(name))
+);
+
+#endif /* _PANEL_BPF_MIPI_DSI_TRACE_H_ */
+
+/* This part must be outside protection */
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH ../../drivers/gpu/drm/panel/bpf
+#include <trace/define_trace.h>
diff --git a/drivers/gpu/drm/panel/bpf/panel-bpf-mipi-dsi.h b/drivers/gpu/drm/panel/bpf/panel-bpf-mipi-dsi.h
new file mode 100644
index 000000000000..5e51e2883fa4
--- /dev/null
+++ b/drivers/gpu/drm/panel/bpf/panel-bpf-mipi-dsi.h
@@ -0,0 +1,264 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __PANEL_BPF_MIPI_DSI_H__
+#define __PANEL_BPF_MIPI_DSI_H__
+
+#include <drm/drm_bridge.h>
+#include <drm/drm_connector.h>
+
+#include <linux/backlight.h>
+#include <linux/gpio/consumer.h>
+#include <linux/list.h>
+#include <linux/mutex.h>
+#include <linux/regulator/consumer.h>
+
+#include <video/display_timing.h>
+
+struct mipi_dsi_device;
+
+#define PANEL_BPF_MIPI_DSI_ID_LEN		128
+#define PANEL_BPF_MIPI_DSI_COMPATIBLE_LEN	64
+
+enum panel_bpf_mipi_dsi_gpio {
+	PANEL_BPF_MIPI_DSI_GPIO_ENABLE,
+	PANEL_BPF_MIPI_DSI_GPIO_RESET,
+	PANEL_BPF_MIPI_DSI_GPIO_COUNT,
+};
+
+enum panel_bpf_mipi_dsi_supply {
+	PANEL_BPF_MIPI_DSI_SUPPLY_VCC,
+	PANEL_BPF_MIPI_DSI_SUPPLY_IOVCC,
+	PANEL_BPF_MIPI_DSI_SUPPLY_AVDD,
+	PANEL_BPF_MIPI_DSI_SUPPLY_AVEE,
+	PANEL_BPF_MIPI_DSI_SUPPLY_ELVDD,
+	PANEL_BPF_MIPI_DSI_SUPPLY_ELVSS,
+	PANEL_BPF_MIPI_DSI_SUPPLY_COUNT,
+};
+
+/**
+ * struct panel_bpf_mipi_dsi - Per-panel instance state
+ */
+struct panel_bpf_mipi_dsi {
+	/**
+	 * @bridge:
+	 *
+	 * The drm_bridge registered with DRM
+	 */
+	struct drm_bridge		bridge;
+
+	/**
+	 * @dsi:
+	 *
+	 * Our parent MIPI-DSI device
+	 */
+	struct mipi_dsi_device		*dsi;
+
+	/**
+	 * @panel_id:
+	 *
+	 * Full OF node path, used for BPF matching and tracing
+	 */
+	char				panel_id[PANEL_BPF_MIPI_DSI_ID_LEN];
+
+	/**
+	 * @gpios:
+	 *
+	 * Optional GPIOs indexed by &enum panel_bpf_mipi_dsi_gpio
+	 */
+	struct gpio_desc		*gpios[PANEL_BPF_MIPI_DSI_GPIO_COUNT];
+
+	/**
+	 * @supplies:
+	 *
+	 * Regulators indexed by &enum panel_bpf_mipi_dsi_supply
+	 */
+	struct regulator_bulk_data	supplies[PANEL_BPF_MIPI_DSI_SUPPLY_COUNT];
+
+	/**
+	 * @backlight:
+	 *
+	 * Optional backlight device
+	 */
+	struct backlight_device		*backlight;
+
+	/**
+	 * @dt:
+	 *
+	 * Display timing parsed from the panel-timing node
+	 */
+	struct display_timing		dt;
+
+	/**
+	 * @width_mm:
+	 *
+	 * Physical panel width in millimeters
+	 */
+	u32				width_mm;
+
+	/**
+	 * @height_mm:
+	 *
+	 * Physical panel height in millimeters
+	 */
+	u32				height_mm;
+
+	/**
+	 * @orientation:
+	 *
+	 * Panel orientation
+	 */
+	enum drm_panel_orientation	orientation;
+
+	/**
+	 * @bpf_ops:
+	 *
+	 * Currently attached BPF struct_ops, or NULL if none attached.
+	 * Protected by @bpf_lock.
+	 */
+	struct drm_panel_dsi_bpf_ops	*bpf_ops;
+
+	/**
+	 * @bpf_lock: Protects @bpf_ops against concurrent attach/detach/use
+	 */
+	struct mutex			bpf_lock;
+};
+
+#define drm_bridge_to_bpf_panel(b)					\
+	container_of_const(b, struct panel_bpf_mipi_dsi, bridge)
+
+int panel_bpf_mipi_dsi_list_add(struct panel_bpf_mipi_dsi *panel);
+struct panel_bpf_mipi_dsi *panel_bpf_mipi_dsi_find_panel_unlocked(const char *panel_id);
+
+extern struct mutex panel_bpf_mipi_dsi_list_lock;
+
+/**
+ * struct panel_bpf_mipi_dsi_ctx - Context passed to BPF panel programs
+ */
+struct panel_bpf_mipi_dsi_ctx {
+	/**
+	 * @bridge:
+	 *
+	 * The drm_bridge this callback operates on (private)
+	 */
+	struct drm_bridge *bridge;
+};
+
+#define bpf_ctx_to_bpf_panel(c)			\
+	drm_bridge_to_bpf_panel((c)->bridge)
+
+/**
+ * struct drm_panel_dsi_bpf_ops - BPF struct_ops for MIPI-DSI panels
+ */
+struct drm_panel_dsi_bpf_ops {
+	/**
+	 * @bridge:
+	 *
+	 * TODO.
+	 *
+	 * Private, used for internal book-keeping.
+	 */
+	struct drm_bridge	*bridge;
+
+	/**
+	 * @panel_id:
+	 *
+	 * Target panel OF node path for instance matching. Set by the
+	 * userspace loader before registration. Immutable after.
+	 */
+	char			panel_id[PANEL_BPF_MIPI_DSI_ID_LEN];
+
+	/**
+	 * @compatible:
+	 *
+	 * DT compatible string this program supports. Set at compile
+	 * time. The kernel does not use this for matching but is
+	 * metadata for the userspace loader, which uses it to decide
+	 * which file to load for a given panel's compatible list.
+	 */
+	char			compatible[PANEL_BPF_MIPI_DSI_COMPATIBLE_LEN];
+
+	/**
+	 * @format:
+	 *
+	 * MIPI DSI pixel format for the panel link.
+	 */
+	enum mipi_dsi_pixel_format format;
+
+	/**
+	 * @lanes:
+	 *
+	 * Number of DSI data lanes.
+	 */
+	u32			lanes;
+
+	/**
+	 * @mode_flags:
+	 *
+	 * DSI mode flags (MIPI_DSI_MODE_VIDEO, etc).
+	 */
+	unsigned long		mode_flags;
+
+	/**
+	 * @hs_rate:
+	 *
+	 * Maximum lane frequency for high speed mode in hertz.
+	 */
+	unsigned long		hs_rate;
+
+	/**
+	 * @lp_rate:
+	 *
+	 * Maximum lane frequency for low power mode in hertz.
+	 */
+	unsigned long		lp_rate;
+
+	/**
+	 * @panel_prepare:
+	 *
+	 * Optional. Called after the DSI host has been pre-enabled. The
+	 * DSI link is up in LP (Low Power) mode, so DSI commands can be
+	 * sent via the dcs_write and generic_write kfuncs.
+	 *
+	 * This is where BPF programs should enable regulators, cycle
+	 * the reset GPIO, and send the panel init sequence. Most panels
+	 * only need this callback. Sleepable.
+	 */
+	int (*panel_prepare)(struct panel_bpf_mipi_dsi_ctx *ctx);
+
+	/**
+	 * @panel_enable:
+	 *
+	 * Optional. Called after the DSI host has switched the link to
+	 * HS (High Speed) mode and started the video stream. For panels
+	 * that need DSI commands sent after the video stream is active.
+	 * Sleepable.
+	 */
+	int (*panel_enable)(struct panel_bpf_mipi_dsi_ctx *ctx);
+
+	/**
+	 * @panel_disable:
+	 *
+	 * Optional. Called while the DSI link is still active in HS
+	 * mode and the video stream is still running. For panels that
+	 * need DSI commands sent before the video stream stops.
+	 * Sleepable.
+	 */
+	int (*panel_disable)(struct panel_bpf_mipi_dsi_ctx *ctx);
+
+	/**
+	 * @panel_unprepare:
+	 *
+	 * Optional. Called after the DSI host has stopped the video
+	 * stream and torn down the HS link. The link may still be in LP
+	 * mode at this point, allowing shutdown commands (display off,
+	 * enter sleep) to be sent.
+	 *
+	 * This is where BPF programs should send shutdown commands,
+	 * assert reset, and disable regulators. Sleepable.
+	 */
+	int (*panel_unprepare)(struct panel_bpf_mipi_dsi_ctx *ctx);
+};
+
+int panel_bpf_mipi_dsi_register_kfuncs(void);
+int panel_bpf_mipi_dsi_register_struct_ops(void);
+
+#endif /* __PANEL_BPF_MIPI_DSI_H__ */
diff --git a/include/drm/drm_panel_dsi_bpf.h b/include/drm/drm_panel_dsi_bpf.h
new file mode 100644
index 000000000000..02d4707fd0a0
--- /dev/null
+++ b/include/drm/drm_panel_dsi_bpf.h
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __DRM_PANEL_DSI_BPF_H__
+#define __DRM_PANEL_DSI_BPF_H__
+
+#include <linux/bpf.h>
+
+struct mipi_dsi_device;
+struct drm_panel;
+
+#define DSI_BPF_PANEL_ID_LEN	64
+
+/**
+ * struct dsi_bpf_ctx - Context passed to BPF panel programs
+ * @panel: The drm_panel this callback operates on (private)
+ */
+struct dsi_bpf_ctx {
+	struct drm_panel *panel;
+};
+
+/**
+ * struct drm_panel_dsi_bpf_ops - BPF struct_ops for MIPI-DSI panels
+ * @panel_id: Device identifier for matching. On DT systems this holds
+ *	the panel's compatible string. Firmware-agnostic to allow future
+ *	ACPI support. Written before load, immutable after.
+ * @panel_prepare: Called to power on the panel and send init commands.
+ *	Must enable regulators, toggle GPIOs, and send the DSI init
+ *	sequence. Sleepable.
+ * @panel_unprepare: Called to power off the panel. Must send shutdown
+ *	commands, assert reset, and disable regulators. Sleepable.
+ * @panel_enable: Optional. Called after video stream starts, for panels
+ *	that need post-video-start DSI commands. Sleepable.
+ * @panel_disable: Optional. Called before video stream stops. Sleepable.
+ * @set_brightness: Optional. Called to set backlight brightness via DSI
+ *	commands. Sleepable.
+ */
+struct drm_panel_dsi_bpf_ops {
+	char			panel_id[DSI_BPF_PANEL_ID_LEN];
+
+	/* private: internal bookkeeping */
+	struct drm_panel	*panel;
+
+	/* public: */
+	int (*panel_prepare)(struct dsi_bpf_ctx *ctx);
+	int (*panel_unprepare)(struct dsi_bpf_ctx *ctx);
+	int (*panel_enable)(struct dsi_bpf_ctx *ctx);
+	int (*panel_disable)(struct dsi_bpf_ctx *ctx);
+	int (*set_brightness)(struct dsi_bpf_ctx *ctx, u32 brightness);
+};
+
+#endif /* __DRM_PANEL_DSI_BPF_H__ */

-- 
2.55.0

