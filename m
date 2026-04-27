Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BD93FF886C
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 17:11:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73EE610E830;
	Mon, 27 Apr 2026 17:11:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lemov3DG";
	dkim-atps=neutral
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com
 [209.85.210.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4BD610E830
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 17:11:47 +0000 (UTC)
Received: by mail-ot1-f48.google.com with SMTP id
 46e09a7af769-7dcc9b506d9so6964112a34.1
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 10:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777309907; x=1777914707; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=30EaWge1vr69+mBJGQmrqCxUtg6xcGISL+y5QQ8wI0E=;
 b=lemov3DGQSkCsnaxIjpsOhvT+rcuoFPAs0qn6Ye8tgmYcwPxBHQ6Gf+122xoiBufMm
 fwddw6urLn9RyTLBfEspYC4az/KAi4OchC3zLyzCcMkI5YwqsAtv+PCqfckMzK7vjfjO
 ryKHTCqeNtxx35lD2u0FvuMPJn9v3HT+ZclX6UaEZqS/o72RejP26fK0Ppj9bLjJ9gKX
 bzeWr9QsJkZGLk3Ud6rGw/cM/xhj2QmNzKBO1KwWXe3NKTMK3wRzMWZYMnQ3GrbxlcAs
 QZWucLku+PGhZdNw/jLzM3F/qOm2h65U1OFZ1jeBaAK8TBJOoXhLXYedSiwBGxsZnKyr
 9O9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777309907; x=1777914707;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=30EaWge1vr69+mBJGQmrqCxUtg6xcGISL+y5QQ8wI0E=;
 b=JdtAoN+jHhUGmQuyIQ+Vk0XeCK+GZuNU/rEyikq9ateLFAr/x/vw6jGyQ/vjXk3Wc6
 6N6LmEhITo3cpRPJBZe5DT8n2gyUyZTkH1vqU3/cJxx2TDKgXCD98/A+JboE2WZDEZNW
 kYCSF10W3mHmRGa9ZXvM3fInPDFpX9UjSxWjCsJWK6C2uTqERszGZBlzBgNWMeFSKOrU
 hMBSWIj7VpoRX18v3GKqezh1pkGhIaZoxUWSUvRekyzpQq11Z+NX+ieRTGSduc3aHOA4
 BBaAVIkzys/vYjom1Sd3NrEOqpJfOqusBKn8VlI6Hzpgpig/KxAHVQdWgXvxgEpOmXa7
 A0bQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/TqJ/DuDd14oKMqoJ7CdmveV5V/9h4WoDVdH/qlRP8rZUixXHEL420iVblUtRvW7pGvciol+KaDkI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyZqp8Im8tIvkMdZcu7antI8ZGQ2YacHhfrrrS55zm86t5y2xlN
 3dcwnw0ESSfJnEu5OULYbKx4z6GUmZQO5QxeDP+DzAaNryk8Lf+Buj0D
X-Gm-Gg: AeBDievcscGxgTBdLg5uObzLuyVks86BRxHUrmC8hYqM9ilaQsv9x2DQEiz8hXrQZov
 /LyHeuJaZQUTrA+uMRVsSoox9aAH7Kb65zYNOZ19PNbFpoZrNEzjtATeAx2XuRkhG0y23Il5mjE
 T917UyAmm9bXRdsAzTFd0JCXFWw5NtOJCODGnJ4AJj9zCN14/+b4yJ5mJ2k3VF1qJWcC1q0vZzH
 iAK8BeA/Mnr7HX6F2Y31MVPOIObGWy9idutxD2/zGnP5gsio4UAxTOSZ/jtqckjyXZYw/hlqdFX
 xNwzggtrBAFDrpOSLfJyvWEMya90csOtQaU8r7Byi0sxUacsz56VPgCGqc8IJTO+sZGfcpQHC7M
 NMrEVVepkWhKipuOEBZFKBqNrENGvyBsf13qa7a2k0RQaXPY3qkelOjbyN2gJiVm3wiT62KLaOZ
 ZBEhSjGKwf3e39nMY6RIANg6LvIgavJB+suvHkphJA6A==
X-Received: by 2002:a4a:e903:0:b0:696:175d:6016 with SMTP id
 006d021491bc7-696175d6293mr10102934eaf.37.1777309906851; 
 Mon, 27 Apr 2026 10:11:46 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0::54])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6955036558esm10261236eaf.14.2026.04.27.10.11.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 10:11:46 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-rockchip@lists.infradead.org
Cc: linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, xsf@rock-chips.com, sre@kernel.org,
 simona@ffwll.ch, airlied@gmail.com, tzimmermann@suse.de,
 mripard@kernel.org, maarten.lankhorst@linux.intel.com,
 jesszhan0024@gmail.com, neil.armstrong@linaro.org, heiko@sntech.de,
 conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
 Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 4/6] drm/panel: anbernic-td4310: Add RG Vita Pro panel
Date: Mon, 27 Apr 2026 12:09:12 -0500
Message-ID: <20260427170914.5062-5-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427170914.5062-1-macroalpha82@gmail.com>
References: <20260427170914.5062-1-macroalpha82@gmail.com>
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

From: Chris Morgan <macromorgan@hotmail.com>

The panel used by Anbernic in the RG Vita-Pro is a DSI panel based
on the TD4310 controller IC. It measures approximately 5.5 inches
diagonally and is 1080x1920 in resolution.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 drivers/gpu/drm/panel/Kconfig                 |  10 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 drivers/gpu/drm/panel/panel-anbernic-td4310.c | 291 ++++++++++++++++++
 3 files changed, 302 insertions(+)
 create mode 100644 drivers/gpu/drm/panel/panel-anbernic-td4310.c

diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index d6863b28ddc5..5229361349d4 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -17,6 +17,16 @@ config DRM_PANEL_ABT_Y030XX067A
 	  Y030XX067A 320x480 3.0" panel as found in the YLM RG-280M, RG-300
 	  and RG-99 handheld gaming consoles.
 
+config DRM_PANEL_ANBERNIC_TD4310
+	tristate "Anbernic TD4310 LCD panel"
+	depends on GPIOLIB && OF
+	depends on DRM_MIPI_DSI
+	depends on BACKLIGHT_CLASS_DEVICE
+	help
+	  Say Y here to enable support for Anbernic designed panels with the
+	  TD4310 panel controller such as the ones used on the Anbernic RG
+	  Vita Pro.
+
 config DRM_PANEL_ARM_VERSATILE
 	tristate "ARM Versatile panel driver"
 	depends on OF
diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
index a4291dc3905b..9d8f70c9de3e 100644
--- a/drivers/gpu/drm/panel/Makefile
+++ b/drivers/gpu/drm/panel/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_DRM_PANEL_ABT_Y030XX067A) += panel-abt-y030xx067a.o
+obj-$(CONFIG_DRM_PANEL_ANBERNIC_TD4310) += panel-anbernic-td4310.o
 obj-$(CONFIG_DRM_PANEL_ARM_VERSATILE) += panel-arm-versatile.o
 obj-$(CONFIG_DRM_PANEL_ASUS_Z00T_TM5P5_NT35596) += panel-asus-z00t-tm5p5-n35596.o
 obj-$(CONFIG_DRM_PANEL_AUO_A030JTN01) += panel-auo-a030jtn01.o
diff --git a/drivers/gpu/drm/panel/panel-anbernic-td4310.c b/drivers/gpu/drm/panel/panel-anbernic-td4310.c
new file mode 100644
index 000000000000..9dd1db822989
--- /dev/null
+++ b/drivers/gpu/drm/panel/panel-anbernic-td4310.c
@@ -0,0 +1,291 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for Anbernic panels with TD4310 panel controller.
+ *
+ * Copyright (C) 2026 Chris Morgan <macromorgan@hotmail.com>
+ *
+ */
+
+#include <linux/gpio/consumer.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/regulator/consumer.h>
+
+#include <drm/drm_mipi_dsi.h>
+#include <drm/drm_modes.h>
+#include <drm/drm_panel.h>
+
+#include <video/mipi_display.h>
+
+struct anbernic_panel_td4310_info {
+	const struct drm_display_mode *display_modes;
+	unsigned int num_modes;
+	u16 width_mm;
+	u16 height_mm;
+	u32 bus_flags;
+	unsigned long mode_flags;
+	u32 format;
+	u32 lanes;
+	u16 prepare_delay;
+	u16 reset_delay;
+	u16 init_delay;
+	u16 enable_delay;
+	u16 disable_delay;
+	u16 unprepare_delay;
+};
+
+struct anbernic_panel_td4310 {
+	struct device *dev;
+	struct mipi_dsi_device *dsi;
+	struct drm_panel panel;
+	const struct anbernic_panel_td4310_info *panel_info;
+	struct gpio_desc *reset_gpio;
+	struct gpio_desc *enable_gpio;
+	struct regulator *vdd;
+	enum drm_panel_orientation orientation;
+};
+
+static inline struct anbernic_panel_td4310 *panel_to_anbernic_panel_td4310(struct drm_panel *panel)
+{
+	return container_of(panel, struct anbernic_panel_td4310, panel);
+}
+
+static int panel_anbernic_td4310_prepare(struct drm_panel *panel)
+{
+	struct anbernic_panel_td4310 *ctx = panel_to_anbernic_panel_td4310(panel);
+	struct mipi_dsi_device *dsi = ctx->dsi;
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
+	int ret;
+
+	ret = regulator_enable(ctx->vdd);
+	if (ret)
+		return ret;
+
+	if (ctx->enable_gpio) {
+		ret = gpiod_set_value_cansleep(ctx->enable_gpio, 1);
+		if (ret)
+			goto err_enable;
+	};
+
+	gpiod_set_value_cansleep(ctx->reset_gpio, 0);
+	mipi_dsi_msleep(&dsi_ctx, 10);
+
+	ret = gpiod_set_value_cansleep(ctx->reset_gpio, 1);
+	if (ret)
+		goto err_reset;
+	if (ctx->panel_info->reset_delay)
+		mipi_dsi_msleep(&dsi_ctx, ctx->panel_info->reset_delay);
+	ret = gpiod_set_value_cansleep(ctx->reset_gpio, 0);
+	if (ret)
+		goto err_reset;
+
+	if (ctx->panel_info->enable_delay)
+		mipi_dsi_msleep(&dsi_ctx, ctx->panel_info->enable_delay);
+
+	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
+	mipi_dsi_msleep(&dsi_ctx, 100);
+	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
+	mipi_dsi_msleep(&dsi_ctx, 100);
+
+	return dsi_ctx.accum_err;
+
+err_reset:
+	gpiod_set_value_cansleep(ctx->enable_gpio, 0);
+err_enable:
+	regulator_disable(ctx->vdd);
+	return ret;
+}
+
+static int panel_anbernic_td4310_unprepare(struct drm_panel *panel)
+{
+	struct anbernic_panel_td4310 *ctx = panel_to_anbernic_panel_td4310(panel);
+	struct mipi_dsi_device *dsi = ctx->dsi;
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
+
+	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
+	mipi_dsi_msleep(&dsi_ctx, 120);
+	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
+	mipi_dsi_msleep(&dsi_ctx, 120);
+
+	if (ctx->enable_gpio)
+		gpiod_set_value_cansleep(ctx->enable_gpio, 0);
+
+	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
+
+	regulator_disable(ctx->vdd);
+
+	return 0;
+}
+
+static int panel_anbernic_td4310_get_modes(struct drm_panel *panel,
+				    struct drm_connector *connector)
+{
+	struct anbernic_panel_td4310 *ctx = panel_to_anbernic_panel_td4310(panel);
+	const struct anbernic_panel_td4310_info *panel_info = ctx->panel_info;
+	struct drm_display_mode *mode;
+	unsigned int i;
+
+	for (i = 0; i < panel_info->num_modes; i++) {
+		mode = drm_mode_duplicate(connector->dev,
+					  &panel_info->display_modes[i]);
+		if (!mode)
+			return -ENOMEM;
+
+		drm_mode_set_name(mode);
+
+		mode->type = DRM_MODE_TYPE_DRIVER;
+		if (panel_info->num_modes == 1)
+			mode->type |= DRM_MODE_TYPE_PREFERRED;
+
+		drm_mode_probed_add(connector, mode);
+	}
+
+	connector->display_info.bpc = 8;
+	connector->display_info.width_mm = panel_info->width_mm;
+	connector->display_info.height_mm = panel_info->height_mm;
+	connector->display_info.bus_flags = panel_info->bus_flags;
+
+	return panel_info->num_modes;
+}
+
+static enum drm_panel_orientation panel_anbernic_td4310_get_orientation(struct drm_panel *panel)
+{
+	struct anbernic_panel_td4310 *ctx = panel_to_anbernic_panel_td4310(panel);
+
+	return ctx->orientation;
+}
+
+static const struct drm_panel_funcs panel_anbernic_td4310_funcs = {
+	.prepare = panel_anbernic_td4310_prepare,
+	.unprepare = panel_anbernic_td4310_unprepare,
+	.get_modes = panel_anbernic_td4310_get_modes,
+	.get_orientation = panel_anbernic_td4310_get_orientation,
+};
+
+static int panel_anbernic_td4310_probe(struct mipi_dsi_device *dsi)
+{
+	struct device *dev = &dsi->dev;
+	struct anbernic_panel_td4310 *ctx;
+	int ret;
+
+	ctx = devm_drm_panel_alloc(dev, struct anbernic_panel_td4310, panel,
+				   &panel_anbernic_td4310_funcs,
+				   DRM_MODE_CONNECTOR_DSI);
+	if (IS_ERR(ctx))
+		return PTR_ERR(ctx);
+
+	ctx->dev = dev;
+
+	ctx->panel_info = of_device_get_match_data(dev);
+	if (!ctx->panel_info)
+		return -EINVAL;
+
+	ret = of_drm_get_panel_orientation(dev->of_node, &ctx->orientation);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to get panel orientation\n");
+
+	ctx->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(ctx->reset_gpio))
+		return dev_err_probe(dev, PTR_ERR(ctx->reset_gpio),
+				     "Cannot get reset gpio\n");
+
+	ctx->enable_gpio = devm_gpiod_get_optional(dev, "enable", GPIOD_OUT_HIGH);
+	if (IS_ERR(ctx->enable_gpio))
+		return dev_err_probe(dev, PTR_ERR(ctx->enable_gpio),
+				     "Cannot get enable gpio\n");
+
+	ctx->vdd = devm_regulator_get(dev, "vdd");
+	if (IS_ERR(ctx->vdd))
+		return dev_err_probe(dev, PTR_ERR(ctx->vdd),
+				     "Failed to request vdd regulator\n");
+
+	ctx->dsi = dsi;
+	mipi_dsi_set_drvdata(dsi, ctx);
+
+	dsi->lanes = ctx->panel_info->lanes;
+	dsi->format = ctx->panel_info->format;
+	dsi->mode_flags = ctx->panel_info->mode_flags;
+
+	ret = drm_panel_of_backlight(&ctx->panel);
+	if (ret)
+		return ret;
+
+	drm_panel_add(&ctx->panel);
+
+	ret = mipi_dsi_attach(dsi);
+	if (ret < 0) {
+		dev_err(dev, "mipi_dsi_attach failed: %d\n", ret);
+		drm_panel_remove(&ctx->panel);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void panel_anbernic_td4310_remove(struct mipi_dsi_device *dsi)
+{
+	struct anbernic_panel_td4310 *ctx = mipi_dsi_get_drvdata(dsi);
+	int ret;
+
+	ret = mipi_dsi_detach(dsi);
+	if (ret < 0)
+		dev_err(&dsi->dev, "Failed to detach from DSI host: %d\n", ret);
+
+	drm_panel_remove(&ctx->panel);
+}
+
+static const struct drm_display_mode anbernic_vitapro_modes[] = {
+	{
+		.clock = 140020,
+		.hdisplay = 1080,
+		.hsync_start = 1080 + 50,
+		.hsync_end = 1080 + 50 + 4,
+		.htotal = 1080 + 50 + 4 + 50,
+		.vdisplay = 1920,
+		.vsync_start = 1920 + 15,
+		.vsync_end = 1920 + 15 + 4,
+		.vtotal = 1920 + 15 + 4 + 32,
+		.flags = DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC,
+	},
+};
+
+static const struct anbernic_panel_td4310_info anbernic_vitapro_info = {
+	.display_modes = anbernic_vitapro_modes,
+	.num_modes = ARRAY_SIZE(anbernic_vitapro_modes),
+	.width_mm = 69,
+	.height_mm = 121,
+	.bus_flags = DRM_BUS_FLAG_DE_LOW | DRM_BUS_FLAG_PIXDATA_DRIVE_NEGEDGE,
+	.mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST |
+		      MIPI_DSI_MODE_LPM | MIPI_DSI_MODE_NO_EOT_PACKET |
+		      MIPI_DSI_CLOCK_NON_CONTINUOUS,
+	.format = MIPI_DSI_FMT_RGB888,
+	.lanes = 4,
+	.prepare_delay = 50,
+	.reset_delay = 220,
+	.enable_delay = 120,
+	.disable_delay = 50,
+	.unprepare_delay = 20,
+};
+
+static const struct of_device_id panel_anbernic_td4310_of_match[] = {
+	{
+		.compatible = "anbernic,panel-vita-pro",
+		.data = &anbernic_vitapro_info,
+	},
+	{ },
+};
+MODULE_DEVICE_TABLE(of, panel_anbernic_td4310_of_match);
+
+static struct mipi_dsi_driver anbernic_panel_td4310_driver = {
+	.driver = {
+		.name = "panel-anbernic-td4310",
+		.of_match_table = panel_anbernic_td4310_of_match,
+	},
+	.probe	= panel_anbernic_td4310_probe,
+	.remove = panel_anbernic_td4310_remove,
+};
+module_mipi_dsi_driver(anbernic_panel_td4310_driver);
+
+MODULE_AUTHOR("Chris Morgan <macromorgan@hotmail.com>");
+MODULE_DESCRIPTION("DRM driver for Anbernic TD4310 MIPI DSI panels");
+MODULE_LICENSE("GPL");
-- 
2.43.0

