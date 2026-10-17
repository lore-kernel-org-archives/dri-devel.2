Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DC0FCCF2C9
	for <dri-devel@archiver.kernel.org>; Sun, 18 Oct 2026 14:53:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 783B610E044;
	Sun, 18 Oct 2026 14:53:39 +0000 (UTC)
Received: from mail-pz2-f9.google.com (mail-pz2-f9.google.com [74.125.228.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4482810E3CA
 for <dri-devel@lists.freedesktop.org>; Sat, 17 Oct 2026 10:34:22 +0000 (UTC)
Received: by mail-pz2-f9.google.com with SMTP id
 41be03b00d2f7-cd65a511e43so394346a12.1
 for <dri-devel@lists.freedesktop.org>; Sat, 17 Oct 2026 03:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792233262; x=1792838062; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WiyBe7vhMbtf4uRkYpBiNCvTHoDTzCk8KGb/Yp4fKF4=;
 b=IIZL/H5nddAJmQbW3JBi0BoaTEnOhzpmWaktTa6JQ5NOtFHe+YvXPJ4uz6PJPICu8Z
 AKyBpvZ2FjXYXEfu4UNUqcmehyf/MV9Xr+VNI3s5A25TxNFYASZGpisMVtfBqk/vruDX
 1ebd1YPRSs5F62UKy9rbPJQYPH97RBlQ2vTLy7ue2JrMDtEUZtTsp9lcgGzWfWFqbOai
 +8KJ+IiLUsIkGhPMQELv6IPI3jyJbrwRAEqfO4udLd2RsmgX2zPodqnF7SrqOsSoYxXZ
 HSPKLm+tNmPaerkyLWwO3n2FdiAPsj23d3OeGxxOLSVrmmrFUJF1iQDTcVYjMnGFvoZi
 ts+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792233262; x=1792838062;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=WiyBe7vhMbtf4uRkYpBiNCvTHoDTzCk8KGb/Yp4fKF4=;
 b=EPPAdO4PAJAZGixndGdo2+FpTeGmlzHAhIXtnStJgJwoM0OWNonpk2zvJGKiEriYJ+
 VIcb1fAG5bYtQkAo82qagXlk60UUD0FmDNG/g0/7ehEMN1/iIEkgS+nbV3QrdUL6sEKj
 0JdfZ2c/2/uoygLLDP+hnWlZQm3AqSI0kaZ16uEH4K13Ja06pDGIGAyXTujdgq/6UdwE
 64PblLfZX+9U+I8dS3NO5JXdFF76gxbLI+Vr/ksFUYQDr+ZR5JYRxxD54G+ABrtf5Kdz
 PDcti/ciCtuXXwkjE0yryHMyyiJ7ij7dlJZmk229M2E5HWCrpC9y5b45dLkV3n3vbDsk
 8QXg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzkM+ZEhWFyvVe4bzUiu7xA3w7WB+ncPj2Gc0yn7KUecWK0calmO6DVxpID4RuKOpOzAm9RTPw/MTk=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJlomyj+YAad5PL4je0r/ty5N8d0/F9YH47/HxD3eZ06BpDSKed
 XD35+wivGqFJ3bftU0UbJ+CY9V6hTHlWk7t0YSFHeDkob7/51EG6B8Va
X-Gm-Gg: AYBFou1K6c1csowGIZY1MAaQuxz5QCfBYT63cGYbN8K19mtiWh2U7ozCNRpczrSv8ph
 wN5Lz33qmT3W5IqOYdyw1JmCG6eW8IGTpij6tJ8CtcacFGnoPmo4JweNlNx3rqXNQA5e9yMEGUJ
 IfMMvjnMUzlghJcpIpHZr3vttK+plKydUukr3Xc3LKqBJpR2B3bubB2gcDeJKhEFSInFnU2MaVI
 XxDnl8XlIplGGK3i9Ur0u/C7sRYZEeuAGx9I+0E6KsLIE7PlI6k7ucKllLtv764BchaRSxPnkgp
 CrKurC2av8fAeBmDecaz7kh1xQoix23JxK8r1yV/Bm5r80MOhxY0tezCUKl1cyCbb7TseHdscGW
 4TmYxIszHHUrPFEnYYIOiEApUU5lPYs1+jTNwEIoXNitKaOl4pMzzsosGV//mVi3fv35q13XE/k
 QVtBiv6mWBGm6pVX93ea5cSKdZEc1tqVolbPiC8NdkYCJlcaSzeZvPekqK
X-Received: by 2002:a05:6a00:1f12:b0:880:973d:597a with SMTP id
 d2e1a72fcca58-8a04d04e513mr1777109b3a.53.1792233261655; 
 Sat, 17 Oct 2026 03:34:21 -0700 (PDT)
Received: from Linux-PC ([2a09:bac5:1f0f:372d::57f:4e])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-89f58414986sm2051585b3a.57.2026.10.17.03.33.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2026 03:34:19 -0700 (PDT)
From: tianshi12127 <tianshi12127@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, dri-devel@lists.freedesktop.org
Cc: Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>,
 devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
 Lu Chen <tianshi12127@gmail.com>
Subject: [PATCH v2 3/3] drm/panel: add driver for Smartisan TD4362
Date: Sat, 17 Oct 2026 18:32:50 +0800
Message-ID: <20261017103250.800109-4-tianshi12127@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261017103250.800109-1-tianshi12127@gmail.com>
References: <20261017083531.766557-1-tianshi12127@gmail.com>
 <20261017103250.800109-1-tianshi12127@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 18 Oct 2026 14:53:13 +0000
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

From: Lu Chen <tianshi12127@gmail.com>

Add support for the Smartisan TD4362 1080x2242 command mode DSI
panel found in the Smartisan R1 (trident) smartphone.

The initialization and power sequences were generated from the
downstream device tree with linux-mdss-dsi-panel-driver-generator.

Tested on a Smartisan R1 (trident).

Signed-off-by: Lu Chen <tianshi12127@gmail.com>
---
 drivers/gpu/drm/panel/Kconfig                 |  13 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 .../gpu/drm/panel/panel-smartisan-td4362.c    | 263 ++++++++++++++++++
 3 files changed, 277 insertions(+)
 create mode 100644 drivers/gpu/drm/panel/panel-smartisan-td4362.c

diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index b30d7781745c..0b413152267f 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -1124,6 +1124,19 @@ config DRM_PANEL_SITRONIX_ST7789V
 	  Say Y here if you want to enable support for the Sitronix
 	  ST7789V controller for 240x320 LCD panels
 
+config DRM_PANEL_SMARTISAN_TD4362
+	tristate "Smartisan TD4362 DSI panel"
+	depends on OF
+	depends on DRM_MIPI_DSI
+	depends on BACKLIGHT_CLASS_DEVICE
+	help
+	  Say Y here if you want to enable support for the Smartisan TD4362
+	  1080x2242 command mode panel found in the Smartisan R1 (trident)
+	  smartphone. The panel is driven over four MIPI DSI lanes in
+	  command mode.
+
+	  If unsure, say N.
+
 config DRM_PANEL_SONY_ACX565AKM
 	tristate "Sony ACX565AKM panel"
 	depends on GPIOLIB && OF && SPI
diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
index 4532f79021ea..bc4fad310554 100644
--- a/drivers/gpu/drm/panel/Makefile
+++ b/drivers/gpu/drm/panel/Makefile
@@ -112,6 +112,7 @@ obj-$(CONFIG_DRM_PANEL_SHARP_LS060T1SX01) += panel-sharp-ls060t1sx01.o
 obj-$(CONFIG_DRM_PANEL_SITRONIX_ST7701) += panel-sitronix-st7701.o
 obj-$(CONFIG_DRM_PANEL_SITRONIX_ST7703) += panel-sitronix-st7703.o
 obj-$(CONFIG_DRM_PANEL_SITRONIX_ST7789V) += panel-sitronix-st7789v.o
+obj-$(CONFIG_DRM_PANEL_SMARTISAN_TD4362) += panel-smartisan-td4362.o
 obj-$(CONFIG_DRM_PANEL_SUMMIT) += panel-summit.o
 obj-$(CONFIG_DRM_PANEL_SYNAPTICS_R63353) += panel-synaptics-r63353.o
 obj-$(CONFIG_DRM_PANEL_SYNAPTICS_TDDI) += panel-synaptics-tddi.o
diff --git a/drivers/gpu/drm/panel/panel-smartisan-td4362.c b/drivers/gpu/drm/panel/panel-smartisan-td4362.c
new file mode 100644
index 000000000000..7fb0ca43780d
--- /dev/null
+++ b/drivers/gpu/drm/panel/panel-smartisan-td4362.c
@@ -0,0 +1,263 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (c) 2026 Lu Chen <tianshi12127@gmail.com>
+// Generated with linux-mdss-dsi-panel-driver-generator from vendor device tree:
+//   Copyright (c) 2013, The Linux Foundation. All rights reserved.
+
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/regulator/consumer.h>
+
+#include <video/mipi_display.h>
+
+#include <drm/drm_mipi_dsi.h>
+#include <drm/drm_modes.h>
+#include <drm/drm_panel.h>
+#include <drm/drm_probe_helper.h>
+
+struct smartisan_td4362 {
+	struct drm_panel panel;
+	struct mipi_dsi_device *dsi;
+	struct regulator_bulk_data *supplies;
+	struct gpio_desc *reset_gpio;
+};
+
+static const struct regulator_bulk_data smartisan_td4362_supplies[] = {
+	{ .supply = "vddio" },
+	{ .supply = "vsp" },
+	{ .supply = "vsn" },
+};
+
+static inline struct smartisan_td4362 *to_smartisan_td4362(struct drm_panel *panel)
+{
+	return container_of(panel, struct smartisan_td4362, panel);
+}
+
+static void smartisan_td4362_reset(struct smartisan_td4362 *ctx)
+{
+	gpiod_set_value_cansleep(ctx->reset_gpio, 0);
+	usleep_range(10000, 10100);
+	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
+	usleep_range(10000, 10100);
+	gpiod_set_value_cansleep(ctx->reset_gpio, 0);
+	usleep_range(10000, 10100);
+}
+
+static int smartisan_td4362_on(struct smartisan_td4362 *ctx)
+{
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
+
+	ctx->dsi->mode_flags |= MIPI_DSI_MODE_LPM;
+
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, MIPI_DCS_SET_DISPLAY_BRIGHTNESS,
+				     0xff);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, MIPI_DCS_WRITE_CONTROL_DISPLAY,
+				     0x24);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, MIPI_DCS_WRITE_POWER_SAVE, 0x82);
+	mipi_dsi_dcs_set_tear_on_multi(&dsi_ctx, MIPI_DSI_DCS_TEAR_MODE_VBLANK);
+	mipi_dsi_dcs_set_column_address_multi(&dsi_ctx, 0x0000, 0x0437);
+	mipi_dsi_dcs_set_page_address_multi(&dsi_ctx, 0x0000, 0x08c1);
+	mipi_dsi_dcs_set_tear_scanline_multi(&dsi_ctx, 0x07fa);
+	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
+	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
+	mipi_dsi_msleep(&dsi_ctx, 80);
+
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xb0, 0x04);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xb9,
+					 0x9b, 0x51, 0x07, 0xe6, 0x00, 0x10,
+					 0x00);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xba,
+					 0xbb, 0x2f, 0x1d, 0xbe, 0x00, 0x10,
+					 0x04);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xce,
+					 0x5d, 0x40, 0x60, 0x78, 0x87, 0x94,
+					 0x9e, 0xab, 0xb8, 0xc4, 0xcd, 0xd6,
+					 0xde, 0xe5, 0xec, 0xf3, 0xfd, 0xff,
+					 0x04, 0x28, 0x04, 0x04, 0x42, 0x00,
+					 0x69, 0x5a, 0x40, 0x01, 0xf4, 0x00,
+					 0x00, 0x04, 0xfa, 0x00);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xca,
+					 0x1d, 0xfc, 0xfc, 0xfc, 0x00, 0x07,
+					 0x07, 0x00, 0x00, 0x00, 0xeb, 0xe7,
+					 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+					 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+					 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+					 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+					 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+					 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+					 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+					 0x00, 0x00, 0x00, 0x00, 0x00, 0x00);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xf9, 0x64);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xb0, 0x03);
+
+	return dsi_ctx.accum_err;
+}
+
+static int smartisan_td4362_off(struct smartisan_td4362 *ctx)
+{
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
+
+	ctx->dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
+
+	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
+	mipi_dsi_usleep_range(&dsi_ctx, 16000, 17000);
+	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
+	mipi_dsi_msleep(&dsi_ctx, 64);
+
+	return dsi_ctx.accum_err;
+}
+
+static int smartisan_td4362_prepare(struct drm_panel *panel)
+{
+	struct smartisan_td4362 *ctx = to_smartisan_td4362(panel);
+	struct device *dev = &ctx->dsi->dev;
+	int ret;
+
+	ret = regulator_bulk_enable(ARRAY_SIZE(smartisan_td4362_supplies),
+				    ctx->supplies);
+	if (ret < 0) {
+		dev_err(dev, "Failed to enable regulators: %d\n", ret);
+		return ret;
+	}
+
+	msleep(100);
+
+	smartisan_td4362_reset(ctx);
+
+	ret = smartisan_td4362_on(ctx);
+	if (ret < 0) {
+		dev_err(dev, "Failed to initialize panel: %d\n", ret);
+		gpiod_set_value_cansleep(ctx->reset_gpio, 1);
+		regulator_bulk_disable(ARRAY_SIZE(smartisan_td4362_supplies),
+				       ctx->supplies);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int smartisan_td4362_unprepare(struct drm_panel *panel)
+{
+	struct smartisan_td4362 *ctx = to_smartisan_td4362(panel);
+	struct device *dev = &ctx->dsi->dev;
+	int ret;
+
+	ret = smartisan_td4362_off(ctx);
+	if (ret < 0)
+		dev_err(dev, "Failed to un-initialize panel: %d\n", ret);
+
+	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
+	regulator_bulk_disable(ARRAY_SIZE(smartisan_td4362_supplies),
+			       ctx->supplies);
+
+	return 0;
+}
+
+static const struct drm_display_mode smartisan_td4362_mode = {
+	.clock = (1080 + 44 + 2 + 60) * (2242 + 8 + 2 + 100) * 60 / 1000,
+	.hdisplay = 1080,
+	.hsync_start = 1080 + 44,
+	.hsync_end = 1080 + 44 + 2,
+	.htotal = 1080 + 44 + 2 + 60,
+	.vdisplay = 2242,
+	.vsync_start = 2242 + 8,
+	.vsync_end = 2242 + 8 + 2,
+	.vtotal = 2242 + 8 + 2 + 100,
+	.width_mm = 64,
+	.height_mm = 117,
+	.type = DRM_MODE_TYPE_DRIVER,
+};
+
+static int smartisan_td4362_get_modes(struct drm_panel *panel,
+				      struct drm_connector *connector)
+{
+	return drm_connector_helper_get_modes_fixed(connector,
+						    &smartisan_td4362_mode);
+}
+
+static const struct drm_panel_funcs smartisan_td4362_panel_funcs = {
+	.prepare = smartisan_td4362_prepare,
+	.unprepare = smartisan_td4362_unprepare,
+	.get_modes = smartisan_td4362_get_modes,
+};
+
+static int smartisan_td4362_probe(struct mipi_dsi_device *dsi)
+{
+	struct device *dev = &dsi->dev;
+	struct smartisan_td4362 *ctx;
+	int ret;
+
+	ctx = devm_drm_panel_alloc(dev, struct smartisan_td4362, panel,
+				   &smartisan_td4362_panel_funcs,
+				   DRM_MODE_CONNECTOR_DSI);
+	if (IS_ERR(ctx))
+		return PTR_ERR(ctx);
+
+	ret = devm_regulator_bulk_get_const(dev,
+					    ARRAY_SIZE(smartisan_td4362_supplies),
+					    smartisan_td4362_supplies,
+					    &ctx->supplies);
+	if (ret < 0)
+		return ret;
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
+	dsi->mode_flags = MIPI_DSI_CLOCK_NON_CONTINUOUS;
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
+static void smartisan_td4362_remove(struct mipi_dsi_device *dsi)
+{
+	struct smartisan_td4362 *ctx = mipi_dsi_get_drvdata(dsi);
+	int ret;
+
+	ret = mipi_dsi_detach(dsi);
+	if (ret < 0)
+		dev_err(&dsi->dev, "Failed to detach from DSI host: %d\n", ret);
+
+	drm_panel_remove(&ctx->panel);
+}
+
+static const struct of_device_id smartisan_td4362_of_match[] = {
+	{ .compatible = "smartisan,td4362" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, smartisan_td4362_of_match);
+
+static struct mipi_dsi_driver smartisan_td4362_driver = {
+	.probe = smartisan_td4362_probe,
+	.remove = smartisan_td4362_remove,
+	.driver = {
+		.name = "panel-smartisan-td4362",
+		.of_match_table = smartisan_td4362_of_match,
+	},
+};
+module_mipi_dsi_driver(smartisan_td4362_driver);
+
+MODULE_AUTHOR("Lu Chen <tianshi12127@gmail.com>");
+MODULE_DESCRIPTION("DRM driver for Smartisan TD4362 1080p command mode DSI panel");
+MODULE_LICENSE("GPL");
-- 
2.56.0

