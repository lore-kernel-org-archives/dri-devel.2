Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 895D7CA5FCE
	for <dri-devel@archiver.kernel.org>; Mon,  5 Oct 2026 09:50:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B23510E23E;
	Mon,  5 Oct 2026 09:50:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="s23sdf6D";
	dkim-atps=neutral
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C686710EA0A
 for <dri-devel@lists.freedesktop.org>; Mon,  5 Oct 2026 09:50:18 +0000 (UTC)
Received: from francesco-nb.. (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 91CB31FC87;
 Mon,  5 Oct 2026 11:50:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1791193817;
 bh=pi2r7OjkGEAZ0wO67OzCpQbJeH0O5Mv7/PTJZIcX/lU=; h=From:To:Subject;
 b=s23sdf6D/pfuFiFmWZwvqCaproR0HtEAQpMsLPosqQq2tFGv8S4n/tV/tSCRmd9A9
 tnh+KHEliC477oewJrzP6LofdawUIqkAf8+w/dc7tp2Y3UJykAGg80+vEWDwAhp6iv
 VIFUrdwOAQDZu+pbdT/doQbh6bddkKv3VcmwlZMiMJfPd+weLHszJPRuDhsa38NCCQ
 Nb0s8TPiZfRo4GhdihfYVwL9+SR0TpcnXiODz9GbMI6YJVtO3MxbDkhBivB7PraAFt
 2mVT1Wzi8+5PAVkzVRVA2CPicIhDjLWRGCOSx9QuRVNEJDEeVycWg2jgJKZGco5n2i
 4YPskWIuDqZsw==
From: Francesco Dolcini <francesco@dolcini.it>
To: Francesco Dolcini <francesco@dolcini.it>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 2/4] drm/bridge: Add THine THC63LVD827 LVDS encoder
Date: Mon,  5 Oct 2026 11:50:02 +0200
Message-ID: <20261005095006.20290-3-francesco@dolcini.it>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261005095006.20290-1-francesco@dolcini.it>
References: <20261005095006.20290-1-francesco@dolcini.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Francesco Dolcini <francesco.dolcini@toradex.com>

Add THC63LVD827 DPI to LVDS bridge driver. The driver supports
configuring the LVDS data mapping. As of now only single link LVDS is
supported, dual link support can be added if/when needed.

Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
v2:
 - use bridge.next_bridge with of_drm_get_bridge_by_endpoint() instead
   of a private pointer from devm_drm_of_get_bridge()
 - drop unused platform_set_drvdata()
 - add power supplies support
 - enforce the input pixel clock sampling edge via atomic_check
---
 MAINTAINERS                          |   1 +
 drivers/gpu/drm/bridge/Kconfig       |  11 ++
 drivers/gpu/drm/bridge/Makefile      |   1 +
 drivers/gpu/drm/bridge/thc63lvd827.c | 228 +++++++++++++++++++++++++++
 4 files changed, 241 insertions(+)
 create mode 100644 drivers/gpu/drm/bridge/thc63lvd827.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 32923e76252b..034a58929945 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8725,6 +8725,7 @@ DRM DRIVER FOR THINE THC63LVD827 DPI TO LVDS BRIDGE
 M:	Francesco Dolcini <francesco@dolcini.it>
 S:	Maintained
 F:	Documentation/devicetree/bindings/display/bridge/thine,thc63lvd827.yaml
+F:	drivers/gpu/drm/bridge/thc63lvd827.c
 
 DRM DRIVER FOR TI DLPC3433 MIPI DSI TO DMD BRIDGE
 M:	Jagan Teki <jagan@amarulasolutions.com>
diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index c7da6b02d7b6..75a40fd38ff1 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -362,6 +362,17 @@ config DRM_THINE_THC63LVD1024
 	help
 	  Thine THC63LVD1024 LVDS/parallel converter driver.
 
+config DRM_THINE_THC63LVD827
+	tristate "THine THC63LVD827 DPI/LVDS bridge"
+	depends on OF
+	select DRM_KMS_HELPER
+	help
+	  Enable support for the THine THC63LVD827 DPI to LVDS bridge.
+
+	  The device converts a parallel RGB display interface to an LVDS
+	  output for connection to LVDS display panels.
+	  The bridge supports configurable JEIDA and VESA LVDS data mapping.
+
 config DRM_THEAD_TH1520_DW_HDMI
 	tristate "T-Head TH1520 DesignWare HDMI bridge"
 	depends on OF
diff --git a/drivers/gpu/drm/bridge/Makefile b/drivers/gpu/drm/bridge/Makefile
index 15cc821d85b7..5d578f7112c8 100644
--- a/drivers/gpu/drm/bridge/Makefile
+++ b/drivers/gpu/drm/bridge/Makefile
@@ -33,6 +33,7 @@ obj-$(CONFIG_DRM_SIMPLE_BRIDGE) += simple-bridge.o
 obj-$(CONFIG_DRM_SOLOMON_SSD2825) += ssd2825.o
 obj-$(CONFIG_DRM_THEAD_TH1520_DW_HDMI) += th1520-dw-hdmi.o
 obj-$(CONFIG_DRM_THINE_THC63LVD1024) += thc63lvd1024.o
+obj-$(CONFIG_DRM_THINE_THC63LVD827) += thc63lvd827.o
 obj-$(CONFIG_DRM_TOSHIBA_TC358762) += tc358762.o
 obj-$(CONFIG_DRM_TOSHIBA_TC358764) += tc358764.o
 obj-$(CONFIG_DRM_TOSHIBA_TC358767) += tc358767.o
diff --git a/drivers/gpu/drm/bridge/thc63lvd827.c b/drivers/gpu/drm/bridge/thc63lvd827.c
new file mode 100644
index 000000000000..02b97d1cc71e
--- /dev/null
+++ b/drivers/gpu/drm/bridge/thc63lvd827.c
@@ -0,0 +1,228 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Toradex
+ * Author: Francesco Dolcini <francesco.dolcini@toradex.com>
+ */
+
+#include <linux/gpio/consumer.h>
+#include <linux/media-bus-format.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_graph.h>
+#include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
+#include <linux/slab.h>
+
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_bridge.h>
+
+static const struct regulator_bulk_data thc63lvd827_supplies[] = {
+	{ .supply = "vcc" },
+	{ .supply = "pllvcc" },
+	{ .supply = "lvdsvcc" },
+	{ .supply = "iovcc" },
+};
+
+struct thc63lvd827 {
+	struct device *dev;
+	struct drm_bridge bridge;
+	struct regulator_bulk_data *supplies;
+
+	struct gpio_desc *map_gpio;
+	struct gpio_desc *mode_gpio;
+	struct gpio_desc *b6b8_gpio;
+	struct gpio_desc *pd_gpio;
+
+	struct drm_bridge_timings timings;
+};
+
+static struct thc63lvd827 *bridge_to_thc63lvd827(struct drm_bridge *bridge)
+{
+	return container_of(bridge, struct thc63lvd827, bridge);
+}
+
+static int thc63lvd827_attach(struct drm_bridge *bridge,
+			      struct drm_encoder *encoder,
+			      enum drm_bridge_attach_flags flags)
+{
+	return drm_bridge_attach(encoder, bridge->next_bridge, bridge, flags);
+}
+
+static u32 *
+thc63lvd827_atomic_get_input_bus_fmts(struct drm_bridge *bridge,
+				      struct drm_bridge_state *bridge_state,
+				      struct drm_crtc_state *crtc_state,
+				      struct drm_connector_state *conn_state,
+				      u32 output_fmt,
+				      unsigned int *num_input_fmts)
+{
+	u32 *input_fmts;
+
+	*num_input_fmts = 0;
+
+	input_fmts = kmalloc_obj(*input_fmts);
+	if (!input_fmts)
+		return NULL;
+
+	input_fmts[0] = MEDIA_BUS_FMT_RGB888_1X24;
+	*num_input_fmts = 1;
+
+	return input_fmts;
+}
+
+static int thc63lvd827_atomic_check(struct drm_bridge *bridge,
+				    struct drm_bridge_state *bridge_state,
+				    struct drm_crtc_state *crtc_state,
+				    struct drm_connector_state *conn_state)
+{
+	struct thc63lvd827 *thc63lvd827 = bridge_to_thc63lvd827(bridge);
+
+	bridge_state->input_bus_cfg.flags = thc63lvd827->timings.input_bus_flags;
+
+	return 0;
+}
+
+static void thc63lvd827_atomic_pre_enable(struct drm_bridge *bridge,
+					  struct drm_atomic_commit *state)
+{
+	struct thc63lvd827 *thc63lvd827 = bridge_to_thc63lvd827(bridge);
+	const struct drm_bridge_state *bridge_state;
+	int b6b8_val, map_val, ret;
+
+	ret = regulator_bulk_enable(ARRAY_SIZE(thc63lvd827_supplies),
+				    thc63lvd827->supplies);
+	if (ret) {
+		dev_err(thc63lvd827->dev, "failed to enable regulators: %d\n", ret);
+		return;
+	}
+
+	bridge_state = drm_atomic_get_new_bridge_state(state, bridge);
+
+	/*
+	 * 6B/8B: H = 6-bit (21-bit) mode, L = 8-bit (27-bit) mode.
+	 * MAP: H = Mapping Mode 1, L = Mapping Mode 2.
+	 */
+	switch (bridge_state->output_bus_cfg.format) {
+	case MEDIA_BUS_FMT_RGB666_1X7X3_SPWG:
+		b6b8_val = 1;
+		map_val = 1;
+		break;
+	case MEDIA_BUS_FMT_RGB888_1X7X4_JEIDA:
+		b6b8_val = 0;
+		map_val = 1;
+		break;
+	default:
+	case MEDIA_BUS_FMT_RGB888_1X7X4_SPWG:
+		b6b8_val = 0;
+		map_val = 0;
+		break;
+	}
+
+	gpiod_set_value_cansleep(thc63lvd827->b6b8_gpio, b6b8_val);
+	gpiod_set_value_cansleep(thc63lvd827->map_gpio, map_val);
+	gpiod_set_value_cansleep(thc63lvd827->pd_gpio, 0);
+}
+
+static void thc63lvd827_atomic_post_disable(struct drm_bridge *bridge,
+					    struct drm_atomic_commit *state)
+{
+	struct thc63lvd827 *thc63lvd827 = bridge_to_thc63lvd827(bridge);
+	int ret;
+
+	gpiod_set_value_cansleep(thc63lvd827->pd_gpio, 1);
+
+	ret = regulator_bulk_disable(ARRAY_SIZE(thc63lvd827_supplies),
+				     thc63lvd827->supplies);
+	if (ret)
+		dev_err(thc63lvd827->dev, "failed to disable regulators: %d\n", ret);
+}
+
+static const struct drm_bridge_funcs thc63lvd827_bridge_funcs = {
+	.attach = thc63lvd827_attach,
+	.atomic_check = thc63lvd827_atomic_check,
+	.atomic_pre_enable = thc63lvd827_atomic_pre_enable,
+	.atomic_post_disable = thc63lvd827_atomic_post_disable,
+	.atomic_get_input_bus_fmts = thc63lvd827_atomic_get_input_bus_fmts,
+	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
+	.atomic_create_state = drm_atomic_helper_bridge_create_state,
+};
+
+static int thc63lvd827_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct thc63lvd827 *thc63lvd827;
+	struct device_node *ep;
+	u32 pclk_sample = 0;
+	int ret;
+
+	thc63lvd827 = devm_drm_bridge_alloc(dev, struct thc63lvd827, bridge,
+					    &thc63lvd827_bridge_funcs);
+	if (IS_ERR(thc63lvd827))
+		return PTR_ERR(thc63lvd827);
+
+	thc63lvd827->dev = dev;
+
+	ret = devm_regulator_bulk_get_const(dev, ARRAY_SIZE(thc63lvd827_supplies),
+					    thc63lvd827_supplies, &thc63lvd827->supplies);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to get regulators\n");
+
+	thc63lvd827->map_gpio = devm_gpiod_get_optional(dev, "map", GPIOD_OUT_LOW);
+	if (IS_ERR(thc63lvd827->map_gpio))
+		return dev_err_probe(dev, PTR_ERR(thc63lvd827->map_gpio),
+				     "failed to get MAP GPIO\n");
+
+	thc63lvd827->mode_gpio = devm_gpiod_get_optional(dev, "mode", GPIOD_OUT_HIGH);
+	if (IS_ERR(thc63lvd827->mode_gpio))
+		return dev_err_probe(dev, PTR_ERR(thc63lvd827->mode_gpio),
+				     "failed to get MODE GPIO\n");
+
+	thc63lvd827->b6b8_gpio = devm_gpiod_get_optional(dev, "b6b8", GPIOD_OUT_LOW);
+	if (IS_ERR(thc63lvd827->b6b8_gpio))
+		return dev_err_probe(dev, PTR_ERR(thc63lvd827->b6b8_gpio),
+				     "failed to get 6B/8B GPIO\n");
+
+	thc63lvd827->pd_gpio = devm_gpiod_get_optional(dev, "powerdown", GPIOD_OUT_HIGH);
+	if (IS_ERR(thc63lvd827->pd_gpio))
+		return dev_err_probe(dev, PTR_ERR(thc63lvd827->pd_gpio),
+				     "failed to get /PDWN GPIO\n");
+
+	thc63lvd827->bridge.next_bridge = of_drm_get_bridge_by_endpoint(dev->of_node, 1, 0);
+	if (IS_ERR(thc63lvd827->bridge.next_bridge))
+		return dev_err_probe(dev, PTR_ERR(thc63lvd827->bridge.next_bridge),
+				     "failed to get downstream bridge\n");
+
+	ep = of_graph_get_endpoint_by_regs(dev->of_node, 0, 0);
+	of_property_read_u32(ep, "pclk-sample", &pclk_sample);
+	of_node_put(ep);
+
+	if (pclk_sample == 1)
+		thc63lvd827->timings.input_bus_flags = DRM_BUS_FLAG_PIXDATA_SAMPLE_POSEDGE;
+	else
+		thc63lvd827->timings.input_bus_flags = DRM_BUS_FLAG_PIXDATA_SAMPLE_NEGEDGE;
+
+	thc63lvd827->bridge.of_node = dev->of_node;
+	thc63lvd827->bridge.timings = &thc63lvd827->timings;
+	thc63lvd827->bridge.type = DRM_MODE_CONNECTOR_LVDS;
+
+	return devm_drm_bridge_add(dev, &thc63lvd827->bridge);
+}
+
+static const struct of_device_id thc63lvd827_of_match[] = {
+	{ .compatible = "thine,thc63lvd827" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, thc63lvd827_of_match);
+
+static struct platform_driver thc63lvd827_driver = {
+	.probe = thc63lvd827_probe,
+	.driver = {
+		.name = "thc63lvd827",
+		.of_match_table = thc63lvd827_of_match,
+	},
+};
+module_platform_driver(thc63lvd827_driver);
+
+MODULE_DESCRIPTION("THine THC63LVD827 DPI to LVDS bridge driver");
+MODULE_LICENSE("GPL");
-- 
2.47.3

