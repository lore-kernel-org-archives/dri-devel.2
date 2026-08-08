Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 518D3C5AD44
	for <dri-devel@archiver.kernel.org>; Sat,  8 Aug 2026 19:01:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A972510E06F;
	Sat,  8 Aug 2026 19:01:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="c6h+kEih";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 645C510E04C
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 19:01:23 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id E62F743EA4;
 Sat,  8 Aug 2026 19:01:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BB4F1C2BCFA;
 Sat,  8 Aug 2026 19:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1786215682;
 bh=hYwxTD9WoX0xDSArh6fZKQD2SNXAMjCHETUSu6mXxL8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=c6h+kEihngyAupvnphG4twdJpoLoJJ3FXNGI6oiXFf63SjlL4xWpREZ1Ggg1H+WAN
 kdGHYzZ+2T10ymhaeD1vuucY8tRwf33AOy8KkBTVxT0+d+PwmKqXuLsHvYtxUaPUh4
 vvcdi5y1U4dHmh07hmAmzML6U9mJK1N4KC+sLP+MG6Kg5LlyEcAl1CaQ6b+4luukKT
 aeQSF+ANcieluan1y0WSc5G+f8zPeMul7/MQkF/OkcdPMICDDt2tzBNzq+lDKhLDaw
 YzyE0FNeYi6plEuatGYDUKXroVXa88uQccTRwQ7EkuoiubbR6OOcu4G4j8DJf79HO4
 F4NVTl7kQBzLg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id A0ED8C5AD55;
 Sat,  8 Aug 2026 19:01:22 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Sat, 08 Aug 2026 14:01:15 -0500
Subject: [PATCH 2/2] drm/panel: add Ilitek ILI7836A panel driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260808-ili7836a-v1-2-07a7becc5636@gmail.com>
References: <20260808-ili7836a-v1-0-07a7becc5636@gmail.com>
In-Reply-To: <20260808-ili7836a-v1-0-07a7becc5636@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Aaron Kling <webgeek1234@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786215681; l=10610;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=o1XtdrXdnPzlUMNUfoJNW0UDzz3bsr+IAfKa1R2/tjc=;
 b=2nh9FKq+EDA+BnC49V3guIkJehCYTasf7D7eeofbubqTQF9dl0YpYkQV4JETW4zYP0rTKXXiz
 DZR8O4fUxSyB6tTOSFimq0TeUjxM7sRFiNJl532/nhtZcmNvPNfGeTL
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
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
Reply-To: webgeek1234@gmail.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

From: Aaron Kling <webgeek1234@gmail.com>

This is a DDIC which can be used in various panels. The first
supported panel is the one used in the Retroid Pocket Nova.

Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
 drivers/gpu/drm/panel/Kconfig                 |  11 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 drivers/gpu/drm/panel/panel-ilitek-ili7836a.c | 297 ++++++++++++++++++++++++++
 3 files changed, 309 insertions(+)

diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index cbdf7b8f7f7af..792d6b92798d9 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -298,6 +298,17 @@ config DRM_PANEL_ILITEK_ILI7807S
 
 	  If M is selected the module will be called panel-ilitek-ili7807s.
 
+config DRM_PANEL_ILITEK_ILI7836A
+	tristate "Ilitek ILI7836A-based panels"
+	depends on OF
+	depends on DRM_MIPI_DSI
+	depends on BACKLIGHT_CLASS_DEVICE
+	help
+	  Say Y if you want to enable support for panels based on the
+	  Ilitek ILI7836A DDIC.
+
+	  If M is selected the module will be called panel-ilitek-ili7836a.
+
 config DRM_PANEL_ILITEK_IL9322
 	tristate "Ilitek ILI9322 320x240 QVGA panels"
 	depends on OF && SPI
diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
index 3b523cf378330..be96f4e8112da 100644
--- a/drivers/gpu/drm/panel/Makefile
+++ b/drivers/gpu/drm/panel/Makefile
@@ -29,6 +29,7 @@ obj-$(CONFIG_DRM_PANEL_HIMAX_HX83121A) += panel-himax-hx83121a.o
 obj-$(CONFIG_DRM_PANEL_HIMAX_HX8394) += panel-himax-hx8394.o
 obj-$(CONFIG_DRM_PANEL_HYDIS_HV101HD1) += panel-hydis-hv101hd1.o
 obj-$(CONFIG_DRM_PANEL_ILITEK_ILI7807S) += panel-ilitek-ili7807s.o
+obj-$(CONFIG_DRM_PANEL_ILITEK_ILI7836A) += panel-ilitek-ili7836a.o
 obj-$(CONFIG_DRM_PANEL_ILITEK_IL9322) += panel-ilitek-ili9322.o
 obj-$(CONFIG_DRM_PANEL_ILITEK_ILI9341) += panel-ilitek-ili9341.o
 obj-$(CONFIG_DRM_PANEL_ILITEK_ILI9488) += panel-ilitek-ili9488.o
diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili7836a.c b/drivers/gpu/drm/panel/panel-ilitek-ili7836a.c
new file mode 100644
index 0000000000000..f6331129dadf2
--- /dev/null
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili7836a.c
@@ -0,0 +1,297 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/backlight.h>
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/regulator/consumer.h>
+
+#include <drm/drm_connector.h>
+#include <drm/drm_crtc.h>
+#include <drm/drm_mipi_dsi.h>
+#include <drm/drm_modes.h>
+#include <drm/drm_of.h>
+#include <drm/drm_panel.h>
+#include <drm/drm_probe_helper.h>
+
+#include <video/mipi_display.h>
+
+static const struct regulator_bulk_data ili7836a_supplies[] = {
+	{ .supply = "vddio", },
+	{ .supply = "avdd", },
+};
+
+struct ili7836a_panel {
+	struct drm_panel panel;
+	struct drm_connector *connector;
+	struct mipi_dsi_device *dsi;
+	struct regulator_bulk_data *supplies;
+	struct gpio_desc *reset_gpio;
+	struct ili7836a_desc *desc;
+	enum drm_panel_orientation orientation;
+};
+
+struct ili7836a_desc {
+	unsigned int width_mm;
+	unsigned int height_mm;
+	unsigned int bpc;
+
+	const struct drm_display_mode *modes;
+	unsigned int num_modes;
+};
+
+static inline struct ili7836a_panel *to_ili7836a_panel(struct drm_panel *panel)
+{
+	return container_of(panel, struct ili7836a_panel, panel);
+}
+
+static void ili7836a_reset(struct ili7836a_panel *ctx)
+{
+	gpiod_set_value_cansleep(ctx->reset_gpio, 0);
+	msleep(20);
+	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
+	msleep(20);
+	gpiod_set_value_cansleep(ctx->reset_gpio, 0);
+	msleep(20);
+}
+
+static int ili7836a_on(struct ili7836a_panel *ctx)
+{
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
+
+	ctx->dsi->mode_flags |= MIPI_DSI_MODE_LPM;
+
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xff, 0x5a, 0xa5, 0x08);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xc8, 0x62);
+
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xff, 0x5a, 0xa5, 0x21);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xa4, 0x38);
+
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xff, 0x5a, 0xa5, 0x23);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x85, 0x15);
+
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xff, 0x5a, 0xa5, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x60, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6d, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x35);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x53, 0x20);
+
+	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
+	mipi_dsi_msleep(&dsi_ctx, 120);
+
+	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
+	mipi_dsi_msleep(&dsi_ctx, 20);
+
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xff, 0x5a, 0xa5, 0x22);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe1, 0x01);
+
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xff, 0x5a, 0xa5, 0x00);
+
+	return dsi_ctx.accum_err;
+}
+
+static int ili7836a_disable(struct drm_panel *panel)
+{
+	struct ili7836a_panel *ctx = to_ili7836a_panel(panel);
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
+
+	ctx->dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
+
+	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
+	mipi_dsi_msleep(&dsi_ctx, 20);
+	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
+	mipi_dsi_msleep(&dsi_ctx, 120);
+
+	return dsi_ctx.accum_err;
+}
+
+static int ili7836a_prepare(struct drm_panel *panel)
+{
+	struct ili7836a_panel *ctx = to_ili7836a_panel(panel);
+	struct device *dev = &ctx->dsi->dev;
+	int ret;
+
+	ret = regulator_bulk_enable(ARRAY_SIZE(ili7836a_supplies), ctx->supplies);
+	if (ret < 0) {
+		dev_err(dev, "Failed to enable regulators: %d\n", ret);
+		return ret;
+	}
+
+	ili7836a_reset(ctx);
+
+	ret = ili7836a_on(ctx);
+	if (ret < 0) {
+		dev_err(dev, "Failed to initialize panel: %d\n", ret);
+		gpiod_set_value_cansleep(ctx->reset_gpio, 1);
+		regulator_bulk_disable(ARRAY_SIZE(ili7836a_supplies), ctx->supplies);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int ili7836a_unprepare(struct drm_panel *panel)
+{
+	struct ili7836a_panel *ctx = to_ili7836a_panel(panel);
+
+	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
+	regulator_bulk_disable(ARRAY_SIZE(ili7836a_supplies), ctx->supplies);
+
+	return 0;
+}
+
+static const struct drm_display_mode nova_modes[] = {
+	{
+		/* 120Hz */
+		.clock = (1280 + 12 + 2 + 8) * (960 + 12 + 2 + 24) * 120 / 1000,
+		.hdisplay = 1280,
+		.hsync_start = 1280 + 12,
+		.hsync_end = 1280 + 12 + 2,
+		.htotal = 1280 + 12 + 2 + 8,
+		.vdisplay = 960,
+		.vsync_start = 960 + 12,
+		.vsync_end = 960 + 12 + 2,
+		.vtotal = 960 + 12 + 2 + 24,
+	}
+};
+
+static struct ili7836a_desc nova_desc = {
+	.modes = nova_modes,
+	.num_modes = ARRAY_SIZE(nova_modes),
+	.width_mm = 91,
+	.height_mm = 68,
+	.bpc = 8,
+};
+
+static int ili7836a_get_modes(struct drm_panel *panel,
+					struct drm_connector *connector)
+{
+	struct ili7836a_panel *ctx = to_ili7836a_panel(panel);
+
+	return drm_connector_helper_get_modes_fixed(connector, ctx->desc->modes);
+}
+
+static enum drm_panel_orientation ili7836a_get_orientation(struct drm_panel *panel)
+{
+	struct ili7836a_panel *ctx = to_ili7836a_panel(panel);
+
+	return ctx->orientation;
+}
+
+static const struct drm_panel_funcs ili7836a_panel_funcs = {
+	.prepare = ili7836a_prepare,
+	.unprepare = ili7836a_unprepare,
+	.disable = ili7836a_disable,
+	.get_modes = ili7836a_get_modes,
+	.get_orientation = ili7836a_get_orientation,
+};
+
+static int ili7836a_bl_update_status(struct backlight_device *bl)
+{
+	struct mipi_dsi_device *dsi = bl_get_data(bl);
+	u16 brightness = backlight_get_brightness(bl);
+	int ret;
+
+	dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
+
+	ret = mipi_dsi_dcs_set_display_brightness_large(dsi, brightness);
+	if (ret < 0)
+		return ret;
+
+	dsi->mode_flags |= MIPI_DSI_MODE_LPM;
+
+	return 0;
+}
+
+static const struct backlight_ops ili7836a_bl_ops = {
+	.update_status = ili7836a_bl_update_status,
+};
+
+static struct backlight_device *
+ili7836a_create_backlight(struct mipi_dsi_device *dsi)
+{
+	struct device *dev = &dsi->dev;
+	const struct backlight_properties props = {
+		.type = BACKLIGHT_RAW,
+		.brightness = 3445,
+		.max_brightness = 3445,
+	};
+
+	return devm_backlight_device_register(dev, dev_name(dev), dev, dsi,
+					      &ili7836a_bl_ops, &props);
+}
+
+static int ili7836a_probe(struct mipi_dsi_device *dsi)
+{
+	struct device *dev = &dsi->dev;
+	struct ili7836a_panel *ctx;
+	int ret;
+
+	ctx = devm_drm_panel_alloc(dev, __typeof(*ctx), panel,
+				   &ili7836a_panel_funcs,
+				   DRM_MODE_CONNECTOR_DSI);
+	if (IS_ERR(ctx))
+		return PTR_ERR(ctx);
+
+	ctx->desc = (struct ili7836a_desc *)of_device_get_match_data(dev);
+	if (!ctx->desc)
+		return -ENODEV;
+
+	ret = devm_regulator_bulk_get_const(dev,
+					    ARRAY_SIZE(ili7836a_supplies),
+					    ili7836a_supplies,
+					    &ctx->supplies);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to get regulators\n");
+
+	ctx->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(ctx->reset_gpio))
+		return dev_err_probe(dev, PTR_ERR(ctx->reset_gpio),
+				     "Failed to get reset-gpios\n");
+
+	ret = drm_of_get_panel_orientation(dev->of_node, &ctx->orientation);
+	if (ret < 0) {
+		dev_err(dev, "%pOF: failed to get orientation %d\n", dev->of_node, ret);
+		return ret;
+	}
+
+	ctx->dsi = dsi;
+	mipi_dsi_set_drvdata(dsi, ctx);
+
+	dsi->lanes = 4;
+	dsi->format = MIPI_DSI_FMT_RGB888;
+	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_HSE |
+			  MIPI_DSI_MODE_NO_EOT_PACKET | MIPI_DSI_CLOCK_NON_CONTINUOUS;
+
+	ctx->panel.prepare_prev_first = true;
+
+	ctx->panel.backlight = ili7836a_create_backlight(dsi);
+	if (IS_ERR(ctx->panel.backlight))
+		return dev_err_probe(dev, PTR_ERR(ctx->panel.backlight),
+				     "Failed to create backlight\n");
+
+	ret = devm_drm_panel_add(dev, &ctx->panel);
+	if (ret)
+		return ret;
+
+	return devm_mipi_dsi_attach(dev, dsi);
+}
+
+static const struct of_device_id ili7836a_of_match[] = {
+	{ .compatible = "retroidpocket,nova-panel", .data = &nova_desc },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, ili7836a_of_match);
+
+static struct mipi_dsi_driver ili7836a_driver = {
+	.probe = ili7836a_probe,
+	.driver = {
+		.name = "panel-ili7836a-amoled",
+		.of_match_table = ili7836a_of_match,
+	},
+};
+module_mipi_dsi_driver(ili7836a_driver);
+
+MODULE_DESCRIPTION("DRM driver for ILI7836A DSI panels");
+MODULE_LICENSE("GPL");

-- 
2.54.0


