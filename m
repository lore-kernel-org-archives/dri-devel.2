Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EFF606A339
	for <dri-devel@archiver.kernel.org>; Sat,  7 Nov 2026 19:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HlsjVrR7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E49B410E655;
	Sat,  7 Nov 2026 19:47:40 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5578B10E655
 for <dri-devel@lists.freedesktop.org>; Sat,  7 Nov 2026 19:47:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 36E9143F05;
 Sat,  7 Nov 2026 19:47:30 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794080850;
 b=X/Vucrfsczwe5sNIF+zXwaCzWWSpfE3KEuEfKWOvh1QgQS8NsEAcB8bb7tDhI5st9mXQ
 xNsmnYi2MrDxaVWoQHTACKSAhAZeqh5qBd4g7bH6jZYPmrzrryHLQlCFQgBmAsoXxVJ39
 N3U1j6ZoS3Mo/zv0kS4ba7oQVBSUuB+zDDnkaXTZnfADFS73RLu2PXWrBH674EIhVH3jw
 sHjnlnYhsfmmjGqvk23Uw5CXeZrsDLQGkg8KU4fMHVaJTWGPXq4qJ8DGedjlp2GasiZSV
 6l8I4CsVv1GvtKffDJT7SIn7A2qEOXNgq32yw/iFQF/3HdCvOnda7PH11zkvIwi7c7A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794080850;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=O2xOvwrGtcIvjotLKtPHhKqHjdMFXqroWskZTC1zQJY=;
 b=i9SbW1ENYh7okzcvFW7h0qcE1X7wqqTLeOmmEUrohhREQSorj2ubFcUDGMI/30fggwHW
 e4kzQJpLCqys4nwmawyUtO9jcFo89IpVoHqYUIGVcy2Wv+nZ7DXH9rbxOInQp+vU336eM
 3P2btP12yugXg9QdcMUA35CzDNEjx/J+4b+/pql/QAQ4vWaazpkc5xy9/xj7DBjoTz9/w
 FZWLsobVQqhdDGaT6kuVzPh7vEIy09NE50rX8AV7aHpstqdA9oEwjzOKGYBEr+azHryvD
 egOazKD1mV4INfiEc5hv23iVcx8fgwZxSWpzGX391L+9csw9no7t2pGwuqdyUWj48rw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 7ED711F008A3;
 Sat,  7 Nov 2026 19:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794080850;
 bh=O2xOvwrGtcIvjotLKtPHhKqHjdMFXqroWskZTC1zQJY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=HlsjVrR7n5OMFveZg779yHlCzsM2CtcZz62bGv2GtmH/9mnyA4VC+edQlo59XH45l
 cfw1s2SNGgstremu8Mian7V1uAGNIF9vWyYsgEJ7+vvSsib3G2DebrcQiey2UIa0YJ
 ac5R8BN8usYdzIp3fU0AwsNRw1aomDWbYuFkAITGK4jVrCF5/Wf9FKCKcHfc+frO1o
 SqrR4LGiW80fWaxLptsyH+lQYRTYwBhVM4c9IrO5Nzynhd77ShSEzTgIU/RA35HAR/
 6Cb3HLxt2oisZFWuVV92kt2AgRu/GQKlAHsYcq+zpVRDEY5xIDkM45fVSCTfgIccGp
 bgvgIx1krJCMg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 07DA547CD8;
 Sat,  7 Nov 2026 19:47:28 +0000 (UTC)
From: Nizat Mikayilli via B4 Relay <devnull+nacht.dxdmail.cc@kernel.org>
Date: Sat, 07 Nov 2026 20:47:26 +0100
Subject: [PATCH 3/3] drm/panel: Add driver for Anapass ANA38407 DDIC
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261107-b4-ana38407-v1-3-c8b33147110a@dxdmail.cc>
References: <20261107-b4-ana38407-v1-0-c8b33147110a@dxdmail.cc>
In-Reply-To: <20261107-b4-ana38407-v1-0-c8b33147110a@dxdmail.cc>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, Nizat Mikayilli <nacht@dxdmail.cc>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794080847; l=13185;
 i=nacht@dxdmail.cc; s=20261004; h=from:subject:message-id;
 bh=96xLb+kyhsv8qm/6qK8cIh81iWQLo10ReBdn37GW90g=;
 b=8bdNZFNoRVAy8+cX0ubLzZ+l45vDuDBGRHELFtciZP8zwyvtMtkcZxhZSdibaTFFeuc9hIy6u
 lmlDe+6cN6YDvY76yxuldyKd6lsFU+l80cjUlvtaYumMjvghXRz0Lkb
X-Developer-Key: i=nacht@dxdmail.cc; a=ed25519;
 pk=Kay3P3pOJq5klUD+0/I8QX8JGOh0CeQXEwRVv7CMm4k=
X-Endpoint-Received: by B4 Relay for nacht@dxdmail.cc/20261004 with
 auth_id=1111
X-Original-From: Nizat Mikayilli <nacht@dxdmail.cc>
Content-Transfer-Encoding: 7bit
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
Reply-To: nacht@dxdmail.cc
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Nizat Mikayilli <nacht@dxdmail.cc>

Add a driver for the Samsung AMSA10FA01 2560x1600 AMOLED panel of the
Samsung Galaxy Tab S9 Wi-Fi, which uses an Anapass ANA38407 DDIC in
command mode with DSC.

The init sequence is taken from the vendor panel data for revision D
of the panel. Only the 120 Hz mode is supported.

Signed-off-by: Nizat Mikayilli <nacht@dxdmail.cc>
---
 MAINTAINERS                                    |   1 +
 drivers/gpu/drm/panel/Kconfig                  |  15 ++
 drivers/gpu/drm/panel/Makefile                 |   1 +
 drivers/gpu/drm/panel/panel-anapass-ana38407.c | 320 +++++++++++++++++++++++++
 4 files changed, 337 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e282fbb04e6e..5229bc5f0b94 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8232,6 +8232,7 @@ DRM DRIVER FOR ANAPASS ANA38407 PANELS
 M:	Nizat Mikayilli <nacht@dxdmail.cc>
 S:	Maintained
 F:	Documentation/devicetree/bindings/display/panel/anapass,ana38407.yaml
+F:	drivers/gpu/drm/panel/panel-anapass-ana38407.c
 
 DRM DRIVER FOR APPLE TOUCH BARS
 M:	Aun-Ali Zaidi <admin@kodeit.net>
diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index 7a520b4d60fe..9585c50ee315 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -18,6 +18,21 @@ config DRM_PANEL_ABT_Y030XX067A
 	  Y030XX067A 320x480 3.0" panel as found in the YLM RG-280M, RG-300
 	  and RG-99 handheld gaming consoles.
 
+config DRM_PANEL_ANAPASS_ANA38407
+	tristate "Anapass ANA38407-based DSI panel"
+	depends on OF
+	depends on DRM_MIPI_DSI
+	depends on BACKLIGHT_CLASS_DEVICE
+	select DRM_DISPLAY_DSC_HELPER
+	select DRM_DISPLAY_HELPER
+	help
+	  Say Y here if you want to enable support for Anapass ANA38407-based
+	  display panels, such as the Samsung AMSA10FA01 which can be found in
+	  the Samsung Galaxy Tab S9 Wi-Fi.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called panel-anapass-ana38407.
+
 config DRM_PANEL_ANBERNIC_TD4310
 	tristate "Anbernic TD4310 LCD panel"
 	depends on GPIOLIB && OF
diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
index da5175909d54..d931461dfaa4 100644
--- a/drivers/gpu/drm/panel/Makefile
+++ b/drivers/gpu/drm/panel/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_DRM_PANEL_ABT_Y030XX067A) += panel-abt-y030xx067a.o
+obj-$(CONFIG_DRM_PANEL_ANAPASS_ANA38407) += panel-anapass-ana38407.o
 obj-$(CONFIG_DRM_PANEL_ANBERNIC_TD4310) += panel-anbernic-td4310.o
 obj-$(CONFIG_DRM_PANEL_ARM_VERSATILE) += panel-arm-versatile.o
 obj-$(CONFIG_DRM_PANEL_ASUS_Z00T_TM5P5_NT35596) += panel-asus-z00t-tm5p5-n35596.o
diff --git a/drivers/gpu/drm/panel/panel-anapass-ana38407.c b/drivers/gpu/drm/panel/panel-anapass-ana38407.c
new file mode 100644
index 000000000000..dbacdc658495
--- /dev/null
+++ b/drivers/gpu/drm/panel/panel-anapass-ana38407.c
@@ -0,0 +1,320 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2026, Nizat Mikayilli <nacht@dxdmail.cc>
+ */
+
+#include <linux/backlight.h>
+#include <linux/delay.h>
+#include <linux/device-id/of.h>
+#include <linux/gpio/consumer.h>
+#include <linux/module.h>
+#include <linux/regulator/consumer.h>
+
+#include <video/mipi_display.h>
+
+#include <drm/display/drm_dsc.h>
+#include <drm/display/drm_dsc_helper.h>
+#include <drm/drm_mipi_dsi.h>
+#include <drm/drm_modes.h>
+#include <drm/drm_panel.h>
+#include <drm/drm_probe_helper.h>
+
+struct ana38407 {
+	struct drm_panel panel;
+	struct mipi_dsi_device *dsi;
+	struct drm_dsc_config dsc;
+	struct regulator_bulk_data *supplies;
+	struct gpio_desc *reset_gpio;
+};
+
+static const struct regulator_bulk_data ana38407_supplies[] = {
+	{ .supply = "vddio" },
+	{ .supply = "vci" },
+};
+
+static inline struct ana38407 *to_ana38407(struct drm_panel *panel)
+{
+	return container_of(panel, struct ana38407, panel);
+}
+
+static void ana38407_unlock(struct mipi_dsi_multi_context *dsi_ctx)
+{
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xf0, 0x5a, 0x5a);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xf1, 0x5a, 0x5a);
+}
+
+static void ana38407_lock(struct mipi_dsi_multi_context *dsi_ctx)
+{
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xf0, 0xa5, 0xa5);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xf1, 0xa5, 0xa5);
+}
+
+/* C1 carries the value, C0 (after B0 03) the 16-bit register address */
+static void ana38407_write_indirect(struct mipi_dsi_multi_context *dsi_ctx,
+				    u16 addr, u8 val)
+{
+	mipi_dsi_dcs_write_var_seq_multi(dsi_ctx, 0xc1, val);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xb0, 0x03);
+	mipi_dsi_dcs_write_var_seq_multi(dsi_ctx, 0xc0, 0x0f, 0x00, 0x00, 0x00,
+					 addr >> 8, addr & 0xff, 0x81);
+}
+
+static void ana38407_slew_boost(struct mipi_dsi_multi_context *dsi_ctx, u8 val)
+{
+	ana38407_write_indirect(dsi_ctx, 0x134f, val);
+	ana38407_write_indirect(dsi_ctx, 0x1362, val);
+	ana38407_write_indirect(dsi_ctx, 0x1375, val);
+	ana38407_write_indirect(dsi_ctx, 0x1388, val);
+}
+
+static int ana38407_on(struct ana38407 *ctx)
+{
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
+	struct drm_dsc_picture_parameter_set pps;
+
+	ana38407_unlock(&dsi_ctx);
+	/* SLEW_BOOSTING_OFF */
+	ana38407_slew_boost(&dsi_ctx, 0x2a);
+	/* PM_EN_DISP_ON_DELAY */
+	ana38407_write_indirect(&dsi_ctx, 0x1435, 0x00);
+	ana38407_write_indirect(&dsi_ctx, 0x0104, 0x23);
+	ana38407_lock(&dsi_ctx);
+
+	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
+	mipi_dsi_msleep(&dsi_ctx, 50);
+
+	ana38407_unlock(&dsi_ctx);
+	/* MX_IP_ENABLE */
+	ana38407_write_indirect(&dsi_ctx, 0x09b2, 0x23);
+	/* TCON_INTR_SETTING */
+	ana38407_write_indirect(&dsi_ctx, 0x1446, 0x02);
+	ana38407_write_indirect(&dsi_ctx, 0x08cf, 0x13);
+	ana38407_write_indirect(&dsi_ctx, 0x09cd, 0x05);
+	ana38407_lock(&dsi_ctx);
+
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xf0, 0x5a, 0x5a);
+	/* TE_ON */
+	mipi_dsi_dcs_set_tear_on_multi(&dsi_ctx, MIPI_DSI_DCS_TEAR_MODE_VBLANK);
+	/* TSP_SYNC_SETTING */
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb0, 0x0b, 0xb9);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb9, 0xcc);
+	/* DSC_SETTING */
+	mipi_dsi_compression_mode_multi(&dsi_ctx, true);
+	drm_dsc_pps_payload_pack(&pps, &ctx->dsc);
+	mipi_dsi_picture_parameter_set_multi(&dsi_ctx, &pps);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xf0, 0xa5, 0xa5);
+
+	/* DIA_SETTING */
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x91, 0x02);
+
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xf0, 0x5a, 0x5a);
+	/* ACL */
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, MIPI_DCS_WRITE_POWER_SAVE, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb0, 0x5f, 0xc9);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xc9, 0x00, 0x05);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb0, 0x51, 0xc9);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xc9, 0x40, 0xff, 0x26);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb0, 0x62, 0xc9);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xc9, 0x3e, 0x42);
+	/* BRIGHTNESS_DIMMING_SETTING */
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, MIPI_DCS_WRITE_CONTROL_DISPLAY, 0x28);
+	/* SP_SETTING */
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xc3, 0x02);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xf0, 0xa5, 0xa5);
+	mipi_dsi_msleep(&dsi_ctx, 20);
+
+	ana38407_unlock(&dsi_ctx);
+	/* SLEW_BOOSTING_ON */
+	ana38407_slew_boost(&dsi_ctx, 0x2e);
+	/* VRR_SETTING */
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x60, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb0, 0x13, 0xdd);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xdd, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb0, 0x10, 0xb9);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb9, 0x80, 0x00, 0x00, 0x00);
+	ana38407_lock(&dsi_ctx);
+
+	return dsi_ctx.accum_err;
+}
+
+static int ana38407_prepare(struct drm_panel *panel)
+{
+	struct ana38407 *ctx = to_ana38407(panel);
+	int ret;
+
+	ret = regulator_bulk_enable(ARRAY_SIZE(ana38407_supplies), ctx->supplies);
+	if (ret < 0)
+		return ret;
+
+	usleep_range(11000, 12000);
+	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
+	usleep_range(10000, 11000);
+	gpiod_set_value_cansleep(ctx->reset_gpio, 0);
+	/* The vendor kernel waits for TCON_RDY here, measured at 125 ms */
+	msleep(200);
+
+	ret = ana38407_on(ctx);
+	if (ret < 0) {
+		gpiod_set_value_cansleep(ctx->reset_gpio, 1);
+		usleep_range(15000, 16000);
+		regulator_bulk_disable(ARRAY_SIZE(ana38407_supplies), ctx->supplies);
+	}
+
+	return ret;
+}
+
+static int ana38407_enable(struct drm_panel *panel)
+{
+	struct ana38407 *ctx = to_ana38407(panel);
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
+
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xf0, 0x5a, 0x5a);
+	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xf0, 0xa5, 0xa5);
+
+	return dsi_ctx.accum_err;
+}
+
+static int ana38407_unprepare(struct drm_panel *panel)
+{
+	struct ana38407 *ctx = to_ana38407(panel);
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
+
+	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
+	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
+	mipi_dsi_msleep(&dsi_ctx, 100);
+
+	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
+	usleep_range(15000, 16000);
+	regulator_bulk_disable(ARRAY_SIZE(ana38407_supplies), ctx->supplies);
+
+	return 0;
+}
+
+static const struct drm_display_mode ana38407_mode = {
+	.clock = (2560 + 34 + 64 + 34) * (1600 + 42 + 64 + 32) * 120 / 1000,
+	.hdisplay = 2560,
+	.hsync_start = 2560 + 34,
+	.hsync_end = 2560 + 34 + 64,
+	.htotal = 2560 + 34 + 64 + 34,
+	.vdisplay = 1600,
+	.vsync_start = 1600 + 42,
+	.vsync_end = 1600 + 42 + 64,
+	.vtotal = 1600 + 42 + 64 + 32,
+	.width_mm = 236,
+	.height_mm = 148,
+	.type = DRM_MODE_TYPE_DRIVER,
+};
+
+static int ana38407_get_modes(struct drm_panel *panel,
+			      struct drm_connector *connector)
+{
+	return drm_connector_helper_get_modes_fixed(connector, &ana38407_mode);
+}
+
+static const struct drm_panel_funcs ana38407_panel_funcs = {
+	.prepare = ana38407_prepare,
+	.enable = ana38407_enable,
+	.unprepare = ana38407_unprepare,
+	.get_modes = ana38407_get_modes,
+};
+
+static int ana38407_bl_update_status(struct backlight_device *bl)
+{
+	struct ana38407 *ctx = bl_get_data(bl);
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
+	u16 brightness = backlight_get_brightness(bl);
+
+	if (!ctx->panel.enabled)
+		return 0;
+
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xf0, 0x5a, 0x5a);
+	mipi_dsi_dcs_write_var_seq_multi(&dsi_ctx, MIPI_DCS_SET_DISPLAY_BRIGHTNESS,
+					 brightness >> 8, brightness & 0xff);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xf0, 0xa5, 0xa5);
+
+	return dsi_ctx.accum_err;
+}
+
+static const struct backlight_ops ana38407_bl_ops = {
+	.update_status = ana38407_bl_update_status,
+};
+
+static int ana38407_probe(struct mipi_dsi_device *dsi)
+{
+	const struct backlight_properties props = {
+		.type = BACKLIGHT_RAW,
+		.brightness = 2047,
+		.max_brightness = 2047,
+	};
+	struct device *dev = &dsi->dev;
+	struct ana38407 *ctx;
+	int ret;
+
+	ctx = devm_drm_panel_alloc(dev, struct ana38407, panel,
+				   &ana38407_panel_funcs,
+				   DRM_MODE_CONNECTOR_DSI);
+	if (IS_ERR(ctx))
+		return PTR_ERR(ctx);
+
+	ret = devm_regulator_bulk_get_const(dev, ARRAY_SIZE(ana38407_supplies),
+					    ana38407_supplies, &ctx->supplies);
+	if (ret < 0)
+		return ret;
+
+	ctx->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(ctx->reset_gpio))
+		return dev_err_probe(dev, PTR_ERR(ctx->reset_gpio),
+				     "Failed to get reset-gpios\n");
+
+	ctx->dsi = dsi;
+
+	ctx->dsc.dsc_version_major = 1;
+	ctx->dsc.dsc_version_minor = 1;
+	ctx->dsc.slice_height = 100;
+	ctx->dsc.slice_width = 1280;
+	ctx->dsc.slice_count = 2;
+	ctx->dsc.bits_per_component = 8;
+	ctx->dsc.bits_per_pixel = 8 << 4;
+	ctx->dsc.block_pred_enable = true;
+
+	dsi->dsc = &ctx->dsc;
+	dsi->lanes = 4;
+	dsi->format = MIPI_DSI_FMT_RGB888;
+	dsi->mode_flags = MIPI_DSI_CLOCK_NON_CONTINUOUS | MIPI_DSI_MODE_LPM;
+
+	ctx->panel.prepare_prev_first = true;
+
+	ctx->panel.backlight = devm_backlight_device_register(dev, dev_name(dev),
+							      dev, ctx,
+							      &ana38407_bl_ops,
+							      &props);
+	if (IS_ERR(ctx->panel.backlight))
+		return dev_err_probe(dev, PTR_ERR(ctx->panel.backlight),
+				     "Failed to register backlight\n");
+
+	ret = devm_drm_panel_add(dev, &ctx->panel);
+	if (ret)
+		return ret;
+
+	return devm_mipi_dsi_attach(dev, dsi);
+}
+
+static const struct of_device_id ana38407_of_match[] = {
+	{ .compatible = "samsung,amsa10fa01" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, ana38407_of_match);
+
+static struct mipi_dsi_driver ana38407_driver = {
+	.probe = ana38407_probe,
+	.driver = {
+		.name = "panel-anapass-ana38407",
+		.of_match_table = ana38407_of_match,
+	},
+};
+module_mipi_dsi_driver(ana38407_driver);
+
+MODULE_AUTHOR("Nizat Mikayilli <nacht@dxdmail.cc>");
+MODULE_DESCRIPTION("DRM driver for ANA38407-equipped DSI panels");
+MODULE_LICENSE("GPL");

-- 
2.56.0


