Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EDAEFF8875
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 10:11:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7189410EF31;
	Wed, 29 Apr 2026 10:11:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imd-tec.com header.i=@imd-tec.com header.b="c35S8cEZ";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F4F610E7B3
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 15:22:32 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-488b150559bso82589555e9.1
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 08:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=imd-tec.com; s=google; t=1777303351; x=1777908151; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pie8QbWldg5VNEJDsI0ovz0KroQYVuPXc4fMQ9N0ZIk=;
 b=c35S8cEZ07tvUmR8qjuXDG22112AWb+SUdaT6pFAPc96NWhu7V6YdhgBwbF5nAvScj
 Ay1vnFBTMLw73nxyO7BKldwVj7ZnV/hr9V+I/mWx1rwm+8V1V5H2sn/75At7MPK/4f93
 MkJYNN+5uajeX9eCJNfdH+wpKKcs8cRWP1KwAEZGBmUFKN6k+61blYS8xfazAxOPRMPe
 CrupCM/nSZzwob28h66nq/ewCsYu4WLnaHIbXEyK5pKYhp/qbiXst8bVowKxxTFCJEun
 yx1DXv1XQkrv8R+M3OEnf2bbMrmSGLxQRb1GIM6apO1bBF4PelPtltsLb4RJE3D51Slk
 dhGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777303351; x=1777908151;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=pie8QbWldg5VNEJDsI0ovz0KroQYVuPXc4fMQ9N0ZIk=;
 b=PhzFA2+uOWdUbLwQbwE3jkrQNxXUz3nRHW56OvSdGbQIqNg4D9+f1hvfW39AGQlg2q
 L4QciAvtukg4nh/MJsxGfq6JHwEf7JkEuJQSL3mDmG9kdoVSq9hc0XUNW+zphIk6u3Ds
 aubggNjX+VRs0n8h0GMoLPxBQUnafsIyyAQBR0NLI0OpIyX/9D9DzbSKVPGAbYfJyngI
 P1mU9Nh0tzA87g+K8lwvWYq93jb6phuwuc4XGCCOGdgXLyyWYQL/jyOmIgQcJHUTyjMG
 dIw+F9L67esstpmIa0auE2Z5N/ydCrAAqibC75jkN2R448z66eG/jOgh6zec3YHhsTBx
 zGNg==
X-Gm-Message-State: AOJu0Yw3RVJeVIAv9IqXq0rpFI4CKmXt1Fy6y5U7dfJPQ1mWb3zZPsQb
 7BtgJs2rwYqpEF58lw35gJ/SWA/8NRrOaFGDphRP5g9SER3t1vcycGPOVtwwrInUFSA=
X-Gm-Gg: AeBDiesxzUR4rJedDJnYZ1X5iM7kqIRVNpIanPPuZ5K0oJ+MTGvqaHcvvqOHzS39R9d
 wb68S5PKsp1lXV2AguNzb/TldpiX+svYCd7dfDl+38aDhICp8dFvC/JL2DakLulEMq8yHZ865uO
 KysX1YorKNJlOE6kNfQJHW+zXUKmPiU02vJN+1vFAQ09A/f1eodxhnbSrAPxgURanwsDPlmmUYJ
 GMU8QGazjs0wddwebR0S0aPGKh+sVe/ZtI2Jn+UBS1DgPP1weFEtTge/AmDqKbiMotV0BrYaGS1
 FWJ1ES9gs/Bs6LRrB9tZAGa7unFQRXHnFeVCcoGZOFxpSkQIBn/D8ghZrkfLxYwW3mcvLCqyTBN
 3S9XJQEXyFN37gfHPws9dUetgtCFM78bHfYcwL4aD7O0WPefOdB9FKd7nvrVuBt1ULafcd4+A0H
 wV55xuENT+Jd17dj53duV65+UPuKbiSGlbBXWC7al/cSkKcNBQ0Ap/hPavfY4fmvsS+oPI8reh5
 j3xkByIXMeAVLUSuIZY4FZwWYosNQ==
X-Received: by 2002:a05:600c:4509:b0:489:e126:b757 with SMTP id
 5b1f17b1804b1-489e126ba91mr422703385e9.25.1777303350864; 
 Mon, 27 Apr 2026 08:22:30 -0700 (PDT)
Received: from [127.0.1.1] ([82.71.135.85]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc0f8188sm861247695e9.2.2026.04.27.08.22.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 08:22:30 -0700 (PDT)
From: William Bright <william.bright@imd-tec.com>
Date: Mon, 27 Apr 2026 16:21:10 +0100
Subject: [PATCH 2/2] drm/panel: Add TSD TST070WSBE-196C 7" DSI panel driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-imdt-dsi-display-v1-2-bb2768de120b@imd-tec.com>
References: <20260427-imdt-dsi-display-v1-0-bb2768de120b@imd-tec.com>
In-Reply-To: <20260427-imdt-dsi-display-v1-0-bb2768de120b@imd-tec.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, William Bright <william.bright@imd-tec.com>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Wed, 29 Apr 2026 10:09:58 +0000
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

Add a dedicated panel driver for the TSD TST070WSBE-196C, a 7" 1024x600
MIPI-DSI TFT LCD panel using an EK79007AD controller.

The driver supports power supply control, reset and enable GPIOs, and
the backlight framework.

The initial driver was built mostly using
"linux-mdss-dsi-panel-driver-generator" [1], reading the downstream
file "dsi-panel-imdt-tst070wsbe165c-video.dtsi" [2].

[1] https://github.com/msm8916-mainline/linux-mdss-dsi-panel-driver-generator
[2] https://raw.githubusercontent.com/imd-tec/meta-imdt-qcom/refs/heads/kirkstone/recipes-display/displaydevicetree/displaydevicetree/0001-Initial-bringup-of-IMDT-Display-3.patch

Signed-off-by: William Bright <william.bright@imd-tec.com>
---
 MAINTAINERS                                       |   6 +
 drivers/gpu/drm/panel/Kconfig                     |   9 ++
 drivers/gpu/drm/panel/Makefile                    |   1 +
 drivers/gpu/drm/panel/panel-tsd-tst070wsbe-196c.c | 168 ++++++++++++++++++++++
 4 files changed, 184 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ae8a01f30ff4..6e80d9916a10 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8414,6 +8414,12 @@ T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
 F:	Documentation/devicetree/bindings/display/panel/tpo,tpg110.yaml
 F:	drivers/gpu/drm/panel/panel-tpo-tpg110.c
 
+DRM DRIVER FOR TSD TST070WSBE-196C PANEL
+M:	William Bright <william.bright@imd-tec.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/display/panel/tsd,tst070wsbe-196c.yaml
+F:	drivers/gpu/drm/panel/panel-tsd-tst070wsbe-196c.c
+
 DRM DRIVER FOR USB DISPLAYLINK VIDEO ADAPTERS
 M:	Dave Airlie <airlied@redhat.com>
 R:	Sean Paul <sean@poorly.run>
diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index d6863b28ddc5..aef00b43c1f1 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -1227,6 +1227,15 @@ config DRM_PANEL_TRULY_NT35597_WQXGA
 	  Say Y here if you want to enable support for Truly NT35597 WQXGA Dual DSI
 	  Video Mode panel
 
+config DRM_PANEL_TSD_TST070WSBE_196C
+	tristate "TSD TST070WSBE-196C DSI panel"
+	depends on OF
+	depends on DRM_MIPI_DSI
+	depends on BACKLIGHT_CLASS_DEVICE
+	help
+	  Say Y here if you want to enable support for the TSD TST070WSBE-196C
+	  1024x600 7" MIPI DSI panel with an EK79007AD controller.
+
 config DRM_PANEL_VISIONOX_G2647FB105
 	tristate "Visionox G2647FB105"
 	depends on OF
diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
index a4291dc3905b..1653fe7b45c5 100644
--- a/drivers/gpu/drm/panel/Makefile
+++ b/drivers/gpu/drm/panel/Makefile
@@ -121,6 +121,7 @@ obj-$(CONFIG_DRM_PANEL_TPO_TD028TTEC1) += panel-tpo-td028ttec1.o
 obj-$(CONFIG_DRM_PANEL_TPO_TD043MTEA1) += panel-tpo-td043mtea1.o
 obj-$(CONFIG_DRM_PANEL_TPO_TPG110) += panel-tpo-tpg110.o
 obj-$(CONFIG_DRM_PANEL_TRULY_NT35597_WQXGA) += panel-truly-nt35597.o
+obj-$(CONFIG_DRM_PANEL_TSD_TST070WSBE_196C) += panel-tsd-tst070wsbe-196c.o
 obj-$(CONFIG_DRM_PANEL_VISIONOX_G2647FB105) += panel-visionox-g2647fb105.o
 obj-$(CONFIG_DRM_PANEL_VISIONOX_RM69299) += panel-visionox-rm69299.o
 obj-$(CONFIG_DRM_PANEL_VISIONOX_RM692E5) += panel-visionox-rm692e5.o
diff --git a/drivers/gpu/drm/panel/panel-tsd-tst070wsbe-196c.c b/drivers/gpu/drm/panel/panel-tsd-tst070wsbe-196c.c
new file mode 100644
index 000000000000..7b639728b3bf
--- /dev/null
+++ b/drivers/gpu/drm/panel/panel-tsd-tst070wsbe-196c.c
@@ -0,0 +1,168 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Generated with linux-mdss-dsi-panel-driver-generator from vendor device tree.
+ * Copyright (c) 2026 IMD Technologies Ltd <william.bright@imd-tec.com>
+ */
+
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/regulator/consumer.h>
+
+#include <drm/drm_mipi_dsi.h>
+#include <drm/drm_modes.h>
+#include <drm/drm_panel.h>
+#include <drm/drm_probe_helper.h>
+
+struct tst070wsbe_196c {
+	struct drm_panel panel;
+	struct mipi_dsi_device *dsi;
+	struct regulator *supply;
+	struct gpio_desc *reset_gpio;
+};
+
+static inline struct tst070wsbe_196c *to_tst070wsbe_196c(struct drm_panel *panel)
+{
+	return container_of_const(panel, struct tst070wsbe_196c, panel);
+}
+
+static void tst070wsbe_196c_reset(struct tst070wsbe_196c *ctx)
+{
+	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
+	msleep(200);
+	gpiod_set_value_cansleep(ctx->reset_gpio, 0);
+	msleep(20);
+}
+
+static int tst070wsbe_196c_prepare(struct drm_panel *panel)
+{
+	struct tst070wsbe_196c *ctx = to_tst070wsbe_196c(panel);
+	int ret;
+
+	ret = regulator_enable(ctx->supply);
+	if (ret < 0)
+		return ret;
+
+	msleep(20);
+
+	tst070wsbe_196c_reset(ctx);
+
+	return 0;
+}
+
+static int tst070wsbe_196c_unprepare(struct drm_panel *panel)
+{
+	struct tst070wsbe_196c *ctx = to_tst070wsbe_196c(panel);
+
+	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
+	regulator_disable(ctx->supply);
+
+	return 0;
+}
+
+static const struct drm_display_mode tst070wsbe_196c_mode = {
+	.clock = (1024 + 160 + 12 + 160) * (600 + 12 + 10 + 23) * 60 / 1000,
+	.hdisplay = 1024,
+	.hsync_start = 1024 + 160,
+	.hsync_end = 1024 + 160 + 12,
+	.htotal = 1024 + 160 + 12 + 160,
+	.vdisplay = 600,
+	.vsync_start = 600 + 12,
+	.vsync_end = 600 + 12 + 10,
+	.vtotal = 600 + 12 + 10 + 23,
+	.width_mm = 190,
+	.height_mm = 121,
+	.type = DRM_MODE_TYPE_DRIVER,
+};
+
+static int tst070wsbe_196c_get_modes(struct drm_panel *panel,
+				   struct drm_connector *connector)
+{
+	return drm_connector_helper_get_modes_fixed(connector,
+						    &tst070wsbe_196c_mode);
+}
+
+static const struct drm_panel_funcs tst070wsbe_196c_panel_funcs = {
+	.prepare = tst070wsbe_196c_prepare,
+	.unprepare = tst070wsbe_196c_unprepare,
+	.get_modes = tst070wsbe_196c_get_modes,
+};
+
+static int tst070wsbe_196c_probe(struct mipi_dsi_device *dsi)
+{
+	struct device *dev = &dsi->dev;
+	struct tst070wsbe_196c *ctx;
+	int ret;
+
+	ctx = devm_drm_panel_alloc(dev, struct tst070wsbe_196c, panel,
+				   &tst070wsbe_196c_panel_funcs,
+				   DRM_MODE_CONNECTOR_DSI);
+	if (IS_ERR(ctx))
+		return PTR_ERR(ctx);
+
+	ctx->supply = devm_regulator_get(dev, "power");
+	if (IS_ERR(ctx->supply))
+		return dev_err_probe(dev, PTR_ERR(ctx->supply),
+				     "Failed to get power regulator\n");
+
+	ctx->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(ctx->reset_gpio))
+		return dev_err_probe(dev, PTR_ERR(ctx->reset_gpio),
+				     "Failed to get reset-gpios\n");
+
+	ctx->dsi = dsi;
+	mipi_dsi_set_drvdata(dsi, ctx);
+
+	dsi->lanes = 4;
+	dsi->format = MIPI_DSI_FMT_RGB888;
+	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_LPM;
+
+	ctx->panel.prepare_prev_first = true;
+
+	ret = drm_panel_of_backlight(&ctx->panel);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to get backlight\n");
+
+	drm_panel_add(&ctx->panel);
+
+	ret = mipi_dsi_attach(dsi);
+	if (ret < 0) {
+		drm_panel_remove(&ctx->panel);
+		return dev_err_probe(dev, ret, "Failed to attach to DSI host\n");
+	}
+
+	return 0;
+}
+
+static void tst070wsbe_196c_remove(struct mipi_dsi_device *dsi)
+{
+	struct tst070wsbe_196c *ctx = mipi_dsi_get_drvdata(dsi);
+	int ret;
+
+	ret = mipi_dsi_detach(dsi);
+	if (ret < 0)
+		dev_err(&dsi->dev, "Failed to detach from DSI host: %d\n", ret);
+
+	drm_panel_remove(&ctx->panel);
+}
+
+static const struct of_device_id tst070wsbe_196c_of_match[] = {
+	{ .compatible = "tsd,tst070wsbe-196c" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, tst070wsbe_196c_of_match);
+
+static struct mipi_dsi_driver tst070wsbe_196c_driver = {
+	.probe = tst070wsbe_196c_probe,
+	.remove = tst070wsbe_196c_remove,
+	.driver = {
+		.name = "panel-tsd-tst070wsbe-196c",
+		.of_match_table = tst070wsbe_196c_of_match,
+	},
+};
+module_mipi_dsi_driver(tst070wsbe_196c_driver);
+
+MODULE_AUTHOR("William Bright <william.bright@imd-tec.com>");
+MODULE_DESCRIPTION("DRM driver for TSD TST070WSBE-196C 7\" MIPI-DSI panel");
+MODULE_LICENSE("GPL");

-- 
2.43.0

