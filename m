Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A8BBFCD0C1
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 07:34:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C983010E6A1;
	Wed, 18 Mar 2026 07:34:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="VlXT05Ed";
	dkim-atps=neutral
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89C5010E441
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 07:34:05 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-439bcec8613so5034666f8f.3
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 00:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1773819244; x=1774424044;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M3u4l6KJxfcF4Ec1QdU4IuVTPNuU4YibXUQsw0zNgHQ=;
 b=VlXT05EdF5tRk+3BR/LQ/2m7NRR/aamcnuSCX5fTKfUAFsRlD9fNDKZUVqeA0wdvUQ
 NywpLPAGc8Gg75GALsfLqV/nZ24OIw6eTKxNBjHABWK3szN3OoaJzlFdm7oNTs0B62wd
 /DLeRPv+YHO6TF5PH4/8bLEH4cwQf+PkQjVnA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773819244; x=1774424044;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=M3u4l6KJxfcF4Ec1QdU4IuVTPNuU4YibXUQsw0zNgHQ=;
 b=B0AiCTGWTWSULL3cO+OPnbe4Wfh5AXJs8rK2Md8epA11LlFXAHtxD4PHM5cKyM4Jts
 H+HC3Xfdc1UCjBlO1O70lDyyqWxGOrTKazK2JMro2TnlUXVN7pd/SwymHNuRYiJFjhPa
 XPzTmIrlPHec5AawkTP+1CUYLa/llr07UKNKax2m/c9bTC9E32ayYppNlOCEpBB1eF6n
 mA43TO3vP8z2T60yS44pmswoYMUCdAEmHe0AnGmu926FgLTOedLsuoS18BtnF+R+zB8x
 HAZqUfiJZnTBVQyPEtizwzn3fN3l4iWhhdFe/YcE4hafXw2wX9dNTODB/E6etFygzgZw
 svXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtf6XiDMz9e/YJChmFWjOO59NkqmVQORSL3Dd9SuunoDYlnSedMFW0Ocgkk1fyaBBKoFCETwaibTM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw8QM9bc21bs00PfJZHHZ6HiEXKQmL3+rfVdeB6HKrEOh1gWncM
 gUoPovkvX+2mnGv/gpqvEX8BDjSkvTGngthxtrrNzTJFvgx2EZtVpR2lnKqeY17TOLE=
X-Gm-Gg: ATEYQzyAbq7AOFWC2QKONm1qj/Skt26P9Yz2oRj/asTqbNJ3w0euRjGtAscKqCvjetq
 8dPSd7kHwHaHCNtXLnhyvtuOVGU7p+p1qVNdoEB6reaL3NAfEdbZGvgDEsDNKljzRvIS63PsA7x
 OBSqrLwI9avExDUie53Sgj1/bB5xs6nInusTIdD3BZXPDLSfEQt5Bxx9RSenLrreqz5rfnVHUWL
 16I+6v3XcxCC5l69wRPN53pmriXajOXeGrIYSd6v7NL9XNZ/kOwS/f21jVN6y0t3lyGpmxajL2Z
 NNvWxHX2R45aNlPYddHsjrL06PXI1BCaTH1pIv7gsFm4ldlQArDOwILO6XUAf9JpjZsY94RfJ8v
 VFseCxmCBk3c8zf97ySN2Pym15picC+ugleXJ8bXGQkc9TOWgVqkIcEf78H0K77aczgW9QxfyEQ
 kBGhYncL+FvPpZgkwisXExSBku+tFN9etha1XlLeb0d36UKMXiWgXKQ/0JVZaF47PFUvEwoOM6r
 g022B2X3e7nCA7OVff4Bwfya+xCeRHuy2v/zvsNpKjSl1+0MNPil8X4ZvGu+vP+N9rzp2SCradV
 nK3rLgWg6UUSiBERaZMumQ==
X-Received: by 2002:a05:600c:8a6:b0:485:35ee:f836 with SMTP id
 5b1f17b1804b1-486f4422104mr24071425e9.2.1773819243875; 
 Wed, 18 Mar 2026 00:34:03 -0700 (PDT)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-87-9-97-160.retail.telecomitalia.it. [87.9.97.160])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486f45f7e96sm25615765e9.0.2026.03.18.00.34.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 00:34:02 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 David Airlie <airlied@gmail.com>, Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Michael Walle <mwalle@kernel.org>,
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org
Subject: [PATCH v5 2/4] drm/panel: ilitek-ili9806e: split core and DSI logic
Date: Wed, 18 Mar 2026 08:32:51 +0100
Message-ID: <20260318073346.18041-3-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260318073346.18041-1-dario.binacchi@amarulasolutions.com>
References: <20260318073346.18041-1-dario.binacchi@amarulasolutions.com>
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

Split the driver to support multiple transport buses. The core logic
(power, GPIO, backlight) is moved to a dedicated core module, while
DSI-specific code is restricted to the DSI module.

Introduce DRM_PANEL_ILITEK_ILI9806E_CORE as a hidden Kconfig symbol
selected by the bus-specific configuration.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

---

Changes in v5:
- Add Reviewed-by tag of Neil Armstrong

Changes in v4:
- Fix "WARNING: unmet direct dependencies detected for
  DRM_PANEL_ILITEK_ILI9806E_CORE" reported by kernel test robot

 MAINTAINERS                                   |   2 +-
 drivers/gpu/drm/panel/Kconfig                 |   4 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 .../drm/panel/panel-ilitek-ili9806e-core.c    | 129 +++++++++++++++
 .../drm/panel/panel-ilitek-ili9806e-core.h    |  15 ++
 .../gpu/drm/panel/panel-ilitek-ili9806e-dsi.c | 151 +++++-------------
 6 files changed, 193 insertions(+), 109 deletions(-)
 create mode 100644 drivers/gpu/drm/panel/panel-ilitek-ili9806e-core.c
 create mode 100644 drivers/gpu/drm/panel/panel-ilitek-ili9806e-core.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 0ac6e344ea01..fcb91fe8d061 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8028,7 +8028,7 @@ F:	drivers/gpu/drm/panel/panel-ilitek-ili9805.c
 DRM DRIVER FOR ILITEK ILI9806E PANELS
 M:	Michael Walle <mwalle@kernel.org>
 S:	Maintained
-F:	drivers/gpu/drm/panel/panel-ilitek-ili9806e-dsi.c
+F:	drivers/gpu/drm/panel/panel-ilitek-ili9806e-*
 
 DRM DRIVER FOR JADARD JD9365DA-H3 MIPI-DSI LCD PANELS
 M:	Jagan Teki <jagan@edgeble.ai>
diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index 142f32a1d256..7fc20421cba5 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -257,11 +257,15 @@ config DRM_PANEL_ILITEK_ILI9805
 	  Say Y if you want to enable support for panels based on the
 	  Ilitek ILI9805 controller.
 
+config DRM_PANEL_ILITEK_ILI9806E_CORE
+	tristate
+
 config DRM_PANEL_ILITEK_ILI9806E_DSI
 	tristate "Ilitek ILI9806E-based DSI panels"
 	depends on OF
 	depends on DRM_MIPI_DSI
 	depends on BACKLIGHT_CLASS_DEVICE
+	select DRM_PANEL_ILITEK_ILI9806E_CORE
 	help
 	  Say Y if you want to enable support for panels based on the
 	  Ilitek ILI9806E controller using DSI.
diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
index 2ceeec7e2110..f56dafb36499 100644
--- a/drivers/gpu/drm/panel/Makefile
+++ b/drivers/gpu/drm/panel/Makefile
@@ -26,6 +26,7 @@ obj-$(CONFIG_DRM_PANEL_HYDIS_HV101HD1) += panel-hydis-hv101hd1.o
 obj-$(CONFIG_DRM_PANEL_ILITEK_IL9322) += panel-ilitek-ili9322.o
 obj-$(CONFIG_DRM_PANEL_ILITEK_ILI9341) += panel-ilitek-ili9341.o
 obj-$(CONFIG_DRM_PANEL_ILITEK_ILI9805) += panel-ilitek-ili9805.o
+obj-$(CONFIG_DRM_PANEL_ILITEK_ILI9806E_CORE) += panel-ilitek-ili9806e-core.o
 obj-$(CONFIG_DRM_PANEL_ILITEK_ILI9806E_DSI) += panel-ilitek-ili9806e-dsi.o
 obj-$(CONFIG_DRM_PANEL_ILITEK_ILI9881C) += panel-ilitek-ili9881c.o
 obj-$(CONFIG_DRM_PANEL_ILITEK_ILI9882T) += panel-ilitek-ili9882t.o
diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9806e-core.c b/drivers/gpu/drm/panel/panel-ilitek-ili9806e-core.c
new file mode 100644
index 000000000000..c088685d9d85
--- /dev/null
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9806e-core.c
@@ -0,0 +1,129 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Ilitek ILI9806E core driver.
+ *
+ * Copyright (c) 2026 Amarula Solutions, Dario Binacchi <dario.binacchi@amarulasolutions.com>
+ */
+
+#include <drm/drm_panel.h>
+
+#include <linux/delay.h>
+#include <linux/export.h>
+#include <linux/gpio/consumer.h>
+#include <linux/module.h>
+#include <linux/property.h>
+#include <linux/regulator/consumer.h>
+
+#include "panel-ilitek-ili9806e-core.h"
+
+struct ili9806e {
+	void *transport;
+	struct drm_panel panel;
+
+	struct regulator_bulk_data supplies[2];
+	struct gpio_desc *reset_gpio;
+};
+
+static const char * const regulator_names[] = {
+	"vdd",
+	"vccio",
+};
+
+void *ili9806e_get_transport(struct drm_panel *panel)
+{
+	struct ili9806e *ctx = container_of(panel, struct ili9806e, panel);
+
+	return ctx->transport;
+}
+EXPORT_SYMBOL_GPL(ili9806e_get_transport);
+
+int ili9806e_power_on(struct device *dev)
+{
+	struct ili9806e *ctx = dev_get_drvdata(dev);
+	int ret;
+
+	gpiod_set_value(ctx->reset_gpio, 1);
+
+	ret = regulator_bulk_enable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
+	if (ret) {
+		dev_err(dev, "regulator bulk enable failed: %d\n", ret);
+		return ret;
+	}
+
+	usleep_range(10000, 20000);
+	gpiod_set_value(ctx->reset_gpio, 0);
+	usleep_range(10000, 20000);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ili9806e_power_on);
+
+int ili9806e_power_off(struct device *dev)
+{
+	struct ili9806e *ctx = dev_get_drvdata(dev);
+	int ret;
+
+	gpiod_set_value(ctx->reset_gpio, 1);
+
+	ret = regulator_bulk_disable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
+	if (ret)
+		dev_err(dev, "regulator bulk disable failed: %d\n", ret);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(ili9806e_power_off);
+
+int ili9806e_probe(struct device *dev, void *transport,
+		  const struct drm_panel_funcs *funcs,
+		  int connector_type)
+{
+	struct ili9806e *ctx;
+	int i, ret;
+
+	ctx = devm_kzalloc(dev, sizeof(struct ili9806e), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	dev_set_drvdata(dev, ctx);
+	ctx->transport = transport;
+
+	for (i = 0; i < ARRAY_SIZE(ctx->supplies); i++)
+		ctx->supplies[i].supply = regulator_names[i];
+
+	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(ctx->supplies),
+				      ctx->supplies);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to get regulators\n");
+
+	ctx->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(ctx->reset_gpio))
+		return dev_err_probe(dev, PTR_ERR(ctx->reset_gpio),
+				     "Failed to get reset-gpios\n");
+
+	drm_panel_init(&ctx->panel, dev, funcs, connector_type);
+
+	ret = drm_panel_of_backlight(&ctx->panel);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to get backlight\n");
+
+	ctx->panel.prepare_prev_first = true;
+	drm_panel_add(&ctx->panel);
+
+	return 0;
+
+}
+EXPORT_SYMBOL_GPL(ili9806e_probe);
+
+void ili9806e_remove(struct device *dev)
+{
+	struct ili9806e *ctx = dev_get_drvdata(dev);
+
+	drm_panel_remove(&ctx->panel);
+}
+EXPORT_SYMBOL_GPL(ili9806e_remove);
+
+MODULE_AUTHOR("Dario Binacchi <dario.binacchi@amarulasolutions.com>");
+MODULE_AUTHOR("Gunnar Dibbern <gunnar.dibbern@lht.dlh.de>");
+MODULE_AUTHOR("Michael Walle <mwalle@kernel.org>");
+MODULE_DESCRIPTION("Ilitek ILI9806E Controller Driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9806e-core.h b/drivers/gpu/drm/panel/panel-ilitek-ili9806e-core.h
new file mode 100644
index 000000000000..dddece62cf42
--- /dev/null
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9806e-core.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _PANEL_ILITEK_ILI9806E_CORE_H
+#define _PANEL_ILITEK_ILI9806E_CORE_H
+
+void *ili9806e_get_transport(struct drm_panel *panel);
+int ili9806e_power_off(struct device *dev);
+int ili9806e_power_on(struct device *dev);
+
+int ili9806e_probe(struct device *dev, void *transport,
+		   const struct drm_panel_funcs *funcs,
+		   int connector_type);
+void ili9806e_remove(struct device *dev);
+
+#endif /* _PANEL_ILITEK_ILI9806E_CORE_H */
diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9806e-dsi.c b/drivers/gpu/drm/panel/panel-ilitek-ili9806e-dsi.c
index c337c4f1a1c7..ecdbed8d4a3a 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili9806e-dsi.c
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9806e-dsi.c
@@ -1,15 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0
 
-#include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/errno.h>
-#include <linux/gpio/consumer.h>
 #include <linux/kernel.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/property.h>
-#include <linux/regulator/consumer.h>
 
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_modes.h>
@@ -18,7 +15,9 @@
 
 #include <video/mipi_display.h>
 
-struct panel_desc {
+#include "panel-ilitek-ili9806e-core.h"
+
+struct ili9806e_dsi_panel_desc {
 	const struct drm_display_mode *display_mode;
 	unsigned long mode_flags;
 	enum mipi_dsi_pixel_format format;
@@ -26,60 +25,13 @@ struct panel_desc {
 	void (*init_sequence)(struct mipi_dsi_multi_context *ctx);
 };
 
-struct ili9806e_panel {
-	struct drm_panel panel;
+struct ili9806e_dsi_panel {
 	struct mipi_dsi_device *dsi;
-	struct gpio_desc *reset_gpio;
-	struct regulator_bulk_data supplies[2];
-	const struct panel_desc *desc;
+	const struct ili9806e_dsi_panel_desc *desc;
 	enum drm_panel_orientation orientation;
 };
 
-static const char * const regulator_names[] = {
-	"vdd",
-	"vccio",
-};
-
-static inline struct ili9806e_panel *to_ili9806e_panel(struct drm_panel *panel)
-{
-	return container_of(panel, struct ili9806e_panel, panel);
-}
-
-static int ili9806e_power_on(struct ili9806e_panel *ctx)
-{
-	struct mipi_dsi_device *dsi = ctx->dsi;
-	int ret;
-
-	gpiod_set_value(ctx->reset_gpio, 1);
-
-	ret = regulator_bulk_enable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
-	if (ret < 0) {
-		dev_err(&dsi->dev, "regulator bulk enable failed: %d\n", ret);
-		return ret;
-	}
-
-	usleep_range(10000, 20000);
-	gpiod_set_value(ctx->reset_gpio, 0);
-	usleep_range(10000, 20000);
-
-	return 0;
-}
-
-static int ili9806e_power_off(struct ili9806e_panel *ctx)
-{
-	struct mipi_dsi_device *dsi = ctx->dsi;
-	int ret;
-
-	gpiod_set_value(ctx->reset_gpio, 1);
-
-	ret = regulator_bulk_disable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
-	if (ret)
-		dev_err(&dsi->dev, "regulator bulk disable failed: %d\n", ret);
-
-	return ret;
-}
-
-static int ili9806e_on(struct ili9806e_panel *ili9806e)
+static int ili9806e_dsi_on(struct ili9806e_dsi_panel *ili9806e)
 {
 	struct mipi_dsi_multi_context ctx = { .dsi = ili9806e->dsi };
 
@@ -93,7 +45,7 @@ static int ili9806e_on(struct ili9806e_panel *ili9806e)
 	return ctx.accum_err;
 }
 
-static int ili9806e_off(struct ili9806e_panel *panel)
+static int ili9806e_dsi_off(struct ili9806e_dsi_panel *panel)
 {
 	struct mipi_dsi_multi_context ctx = { .dsi = panel->dsi };
 
@@ -104,88 +56,75 @@ static int ili9806e_off(struct ili9806e_panel *panel)
 	return ctx.accum_err;
 }
 
-static int ili9806e_prepare(struct drm_panel *panel)
+static int ili9806e_dsi_prepare(struct drm_panel *panel)
 {
-	struct ili9806e_panel *ctx = to_ili9806e_panel(panel);
+	struct ili9806e_dsi_panel *ctx = ili9806e_get_transport(panel);
+	struct device *dev = &ctx->dsi->dev;
 	int ret;
 
-	ret = ili9806e_power_on(ctx);
+	ret = ili9806e_power_on(dev);
 	if (ret < 0)
 		return ret;
 
-	ret = ili9806e_on(ctx);
+	ret = ili9806e_dsi_on(ctx);
 	if (ret < 0) {
-		ili9806e_power_off(ctx);
+		ili9806e_power_off(dev);
 		return ret;
 	}
 
 	return 0;
 }
 
-static int ili9806e_unprepare(struct drm_panel *panel)
+static int ili9806e_dsi_unprepare(struct drm_panel *panel)
 {
-	struct ili9806e_panel *ctx = to_ili9806e_panel(panel);
-	struct mipi_dsi_device *dsi = ctx->dsi;
+	struct ili9806e_dsi_panel *ctx = ili9806e_get_transport(panel);
+	struct device *dev = &ctx->dsi->dev;
 	int ret;
 
-	ili9806e_off(ctx);
+	ili9806e_dsi_off(ctx);
 
-	ret = ili9806e_power_off(ctx);
+	ret = ili9806e_power_off(dev);
 	if (ret < 0)
-		dev_err(&dsi->dev, "power off failed: %d\n", ret);
+		dev_err(dev, "power off failed: %d\n", ret);
 
 	return ret;
 }
 
-static int ili9806e_get_modes(struct drm_panel *panel,
+static int ili9806e_dsi_get_modes(struct drm_panel *panel,
 			      struct drm_connector *connector)
 {
-	struct ili9806e_panel *ctx = to_ili9806e_panel(panel);
+	struct ili9806e_dsi_panel *ctx = ili9806e_get_transport(panel);
 	const struct drm_display_mode *mode = ctx->desc->display_mode;
 
 	return drm_connector_helper_get_modes_fixed(connector, mode);
 }
 
-static enum drm_panel_orientation ili9806e_get_orientation(struct drm_panel *panel)
+static enum drm_panel_orientation ili9806e_dsi_get_orientation(struct drm_panel *panel)
 {
-	struct ili9806e_panel *ctx = to_ili9806e_panel(panel);
+	struct ili9806e_dsi_panel *ctx = ili9806e_get_transport(panel);
 
 	return ctx->orientation;
 }
 
-static const struct drm_panel_funcs ili9806e_funcs = {
-	.prepare = ili9806e_prepare,
-	.unprepare = ili9806e_unprepare,
-	.get_modes = ili9806e_get_modes,
-	.get_orientation = ili9806e_get_orientation,
+static const struct drm_panel_funcs ili9806e_dsi_funcs = {
+	.prepare = ili9806e_dsi_prepare,
+	.unprepare = ili9806e_dsi_unprepare,
+	.get_modes = ili9806e_dsi_get_modes,
+	.get_orientation = ili9806e_dsi_get_orientation,
 };
 
 static int ili9806e_dsi_probe(struct mipi_dsi_device *dsi)
 {
 	struct device *dev = &dsi->dev;
-	struct ili9806e_panel *ctx;
-	int i, ret;
+	struct ili9806e_dsi_panel *ctx;
+	int ret;
 
-	ctx = devm_drm_panel_alloc(dev, struct ili9806e_panel, panel, &ili9806e_funcs,
-				   DRM_MODE_CONNECTOR_DSI);
-	if (IS_ERR(ctx))
-		return PTR_ERR(ctx);
+	ctx = devm_kzalloc(dev, sizeof(struct ili9806e_dsi_panel), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
 
 	ctx->desc = device_get_match_data(dev);
 
-	for (i = 0; i < ARRAY_SIZE(ctx->supplies); i++)
-		ctx->supplies[i].supply = regulator_names[i];
-
-	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(ctx->supplies),
-				      ctx->supplies);
-	if (ret < 0)
-		return ret;
-
-	ctx->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
-	if (IS_ERR(ctx->reset_gpio))
-		return dev_err_probe(dev, PTR_ERR(ctx->reset_gpio),
-				     "Failed to get reset-gpios\n");
-
 	mipi_dsi_set_drvdata(dsi, ctx);
 	ctx->dsi = dsi;
 
@@ -197,17 +136,15 @@ static int ili9806e_dsi_probe(struct mipi_dsi_device *dsi)
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to get orientation\n");
 
-	ret = drm_panel_of_backlight(&ctx->panel);
+	ret = ili9806e_probe(dev, ctx, &ili9806e_dsi_funcs,
+			     DRM_MODE_CONNECTOR_DSI);
 	if (ret)
-		return dev_err_probe(dev, ret, "Failed to get backlight\n");
-
-	ctx->panel.prepare_prev_first = true;
-	drm_panel_add(&ctx->panel);
+		return ret;
 
 	ret = mipi_dsi_attach(dsi);
 	if (ret < 0) {
 		dev_err_probe(dev, ret, "Failed to attach to DSI host\n");
-		drm_panel_remove(&ctx->panel);
+		ili9806e_remove(dev);
 		return ret;
 	}
 
@@ -216,10 +153,8 @@ static int ili9806e_dsi_probe(struct mipi_dsi_device *dsi)
 
 static void ili9806e_dsi_remove(struct mipi_dsi_device *dsi)
 {
-	struct ili9806e_panel *ctx = mipi_dsi_get_drvdata(dsi);
-
 	mipi_dsi_detach(dsi);
-	drm_panel_remove(&ctx->panel);
+	ili9806e_remove(&dsi->dev);
 }
 
 static void com35h3p70ulc_init(struct mipi_dsi_multi_context *ctx)
@@ -369,7 +304,7 @@ static const struct drm_display_mode com35h3p70ulc_default_mode = {
 	.height_mm = 71,
 };
 
-static const struct panel_desc com35h3p70ulc_desc = {
+static const struct ili9806e_dsi_panel_desc com35h3p70ulc_desc = {
 	.init_sequence = com35h3p70ulc_init,
 	.display_mode = &com35h3p70ulc_default_mode,
 	.mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST |
@@ -533,7 +468,7 @@ static const struct drm_display_mode dmt028vghmcmi_1d_default_mode = {
 	.type		= DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
 };
 
-static const struct panel_desc dmt028vghmcmi_1d_desc = {
+static const struct ili9806e_dsi_panel_desc dmt028vghmcmi_1d_desc = {
 	.init_sequence = dmt028vghmcmi_1d_init,
 	.display_mode = &dmt028vghmcmi_1d_default_mode,
 	.mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST |
@@ -542,17 +477,17 @@ static const struct panel_desc dmt028vghmcmi_1d_desc = {
 	.lanes = 2,
 };
 
-static const struct of_device_id ili9806e_of_match[] = {
+static const struct of_device_id ili9806e_dsi_of_match[] = {
 	{ .compatible = "densitron,dmt028vghmcmi-1d", .data = &dmt028vghmcmi_1d_desc },
 	{ .compatible = "ortustech,com35h3p70ulc", .data = &com35h3p70ulc_desc },
 	{ }
 };
-MODULE_DEVICE_TABLE(of, ili9806e_of_match);
+MODULE_DEVICE_TABLE(of, ili9806e_dsi_of_match);
 
 static struct mipi_dsi_driver ili9806e_dsi_driver = {
 	.driver = {
 		.name = "ili9806e-dsi",
-		.of_match_table = ili9806e_of_match,
+		.of_match_table = ili9806e_dsi_of_match,
 	},
 	.probe = ili9806e_dsi_probe,
 	.remove = ili9806e_dsi_remove,
-- 
2.43.0

