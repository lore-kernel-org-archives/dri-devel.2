Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7387DC43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 11:13:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C36A210EEE4;
	Wed,  1 Jul 2026 11:13:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="hW9pDiJo";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38E3810EEE4
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 11:13:01 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 661A8cdT744397; Wed, 1 Jul 2026 11:12:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +8Nhv8/56o/tzEz+paIgQaKYJa7uAhemecFkU3ENhDg=; b=hW9pDiJogVPoPFkV
 Ua8Hn0+zA0gHg8R4doUKTsrvu2ZEE8Vsw3s/QvAmsmkeKZoKH9jLyWeYgCW1qQxM
 X6M/MXFHTLGtgSTxLEFTCh4IDZuVgvlt01ne5SwqJ/+E5oR3iNG5djlyGw+9gufD
 J9KWHWA2Aqndk6ibDTf+lE41EWEyGpfR0efXYhPxMkQ/kRe6D++zZnvMRyaLI+CG
 Sm/vmsJ91seq4PRU94KHDAKdBxqaPPOZIKD3RbAGi8EdgFS8GOn4i3KfniePsuFu
 HW6/E0EdAJhZCNhgJ/qZwYUuGXMMOntauKy3ndjsIt39mzalwa67FCA81wcS2IGI
 ou0BEw==
Received: from apblrppmta01.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4x0th5mq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 01 Jul 2026 11:12:55 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
 by APBLRPPMTA01.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 661BCqVa031718; 
 Wed, 1 Jul 2026 11:12:52 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 4f27kk0335-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 01 Jul 2026 11:12:52 +0000 (GMT)
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com
 [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 661BCpCx031700;
 Wed, 1 Jul 2026 11:12:51 GMT
Received: from hu-devc-hyd-u22-c.qualcomm.com (hu-arpisain-hyd.qualcomm.com
 [10.147.248.17])
 by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 661BCpI9031699
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 01 Jul 2026 11:12:51 +0000 (GMT)
Received: from hu-arpisain-hyd.qualcomm.com (localhost [127.0.0.1])
 by hu-devc-hyd-u22-c.qualcomm.com (Postfix) with ESMTP id B1D88638;
 Wed,  1 Jul 2026 16:42:50 +0530 (+0530)
From: Arpit Saini <arpit.saini@oss.qualcomm.com>
Date: Wed, 01 Jul 2026 16:42:50 +0530
Subject: [PATCH v4 2/2] drm/panel: add Ilitek ILI7807S panel driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-ili7807s-v4-2-c7d76d4780a5@oss.qualcomm.com>
References: <20260701-ili7807s-v4-0-c7d76d4780a5@oss.qualcomm.com>
In-Reply-To: <20260701-ili7807s-v4-0-c7d76d4780a5@oss.qualcomm.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: arpit.saini@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, ayushi.makhija@oss.qualcomm.com,
 rajeevny@qti.qualcomm.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782904370; l=10274;
 i=arpit.saini@oss.qualcomm.com; h=from:subject:message-id;
 bh=jZXgnTISCbDzwd0YhWS3RScMeUxW0ijv8IeN5AVD5bc=;
 b=6ImdzJq2DJU6jubWY8beiO5vZxP8eU0DI4vauigRc4bQ0TVxXPKdaZ9u300ZJJdWJN9MYfgTF
 Fj5Q91HPhhyATomp3qs+wVtPoXCWKQBgvANN0FO9KXPxQimyPEsc4w8
X-Developer-Key: i=arpit.saini@oss.qualcomm.com; a=ed25519;
 pk=OGOh7FGwrnkILHNlcTTABbBMQxxo319duzbTg0YPDAc=
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-GUID: W3m-YkeMWYpPtNaFW-Ry5_PKmvoeUA4S
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDExOCBTYWx0ZWRfXzuOARgXM29If
 pqzm3OCr+bcKaA55GSI/Dv8IM2zuLtvC3b/dBVstMofRIWQCGE0Tla7XFC1DXO0AoLTc/ZqkOZU
 recJIiG32qBJG2ixsMj05Z5B7NseQuc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDExOCBTYWx0ZWRfX5aUbwvPlrg3+
 iRJ4gngTSRwakwB5QoJR9EQ+cQ3isXyTRE5m2J1i0SVWFNCj7DzGKBDjvAXlm9ckQjKJ+RXsx37
 DS6alC9hjUeNjsF/OlrEfdEydUfhKkMO51J52Y4Vws8EFeQkguCELK5nNSekcYm9WpQmF2KZUWJ
 U0Cug5bK0pcmoHXrCDaAlwP8a9PoGBoIzJTtGZHAPGldO7qkYjJRaM9nKd/gmOzeW9cnRGohDF7
 iJNN+zKzsTuS6V/FyV8xeYKani94y0w//1+H3/F8wRkS252FB3yarZFR/d7sGb4YiGmgeyMqF6u
 Vaw/YwSxqDNWZohaaDrLamFWiJ9e5wT8ohNr1c4FtrkKSvvu/O1FDxfBnkGuc+Vh1JZQr4Lzid4
 WYrM19ULSlJrf2GRnygadsGksmfi/BQ9OyLpXWITVhc+czdt8Fe09EnlWgYpjEjVp/nWZMuLM1l
 GqHwSv255WbDn6NMB6g==
X-Authority-Analysis: v=2.4 cv=T5+8ifKQ c=1 sm=1 tr=0 ts=6a44f637 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=PpNqgBxrR9VdnZ8GWKIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: W3m-YkeMWYpPtNaFW-Ry5_PKmvoeUA4S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 bulkscore=0 clxscore=1015 priorityscore=1501 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010118
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

Add a DRM panel driver for the DLC DLC0697 1080x1920@60Hz MIPI DSI
panel based on the Ilitek ILI7807S display controller.

The panel operates in video burst mode with four data lanes using
RGB888 pixel format.

Signed-off-by: Arpit Saini <arpit.saini@oss.qualcomm.com>
---
 drivers/gpu/drm/panel/Kconfig                 |  12 ++
 drivers/gpu/drm/panel/Makefile                |   1 +
 drivers/gpu/drm/panel/panel-ilitek-ili7807s.c | 285 ++++++++++++++++++++++++++
 3 files changed, 298 insertions(+)

diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index 7450b27622a2..1cbaac1bf545 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -264,6 +264,18 @@ config DRM_PANEL_HYDIS_HV101HD1
 
 	  If M is selected the module will be called panel-hydis-hv101hd1
 
+config DRM_PANEL_ILITEK_ILI7807S
+	tristate "Ilitek ILI7807S-based panels"
+	depends on OF
+	depends on DRM_MIPI_DSI
+	depends on BACKLIGHT_CLASS_DEVICE
+	help
+	  Say Y if you want to enable support for panels based on the
+	  Ilitek ILI7807S display controller, such as the DLC DLC0697
+	  1080x1920 MIPI DSI panel.
+
+	  If M is selected the module will be called panel-ilitek-ili7807s.
+
 config DRM_PANEL_ILITEK_IL9322
 	tristate "Ilitek ILI9322 320x240 QVGA panels"
 	depends on OF && SPI
diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
index c2c5cf817116..c3002b351cb8 100644
--- a/drivers/gpu/drm/panel/Makefile
+++ b/drivers/gpu/drm/panel/Makefile
@@ -26,6 +26,7 @@ obj-$(CONFIG_DRM_PANEL_HIMAX_HX83112B) += panel-himax-hx83112b.o
 obj-$(CONFIG_DRM_PANEL_HIMAX_HX83121A) += panel-himax-hx83121a.o
 obj-$(CONFIG_DRM_PANEL_HIMAX_HX8394) += panel-himax-hx8394.o
 obj-$(CONFIG_DRM_PANEL_HYDIS_HV101HD1) += panel-hydis-hv101hd1.o
+obj-$(CONFIG_DRM_PANEL_ILITEK_ILI7807S) += panel-ilitek-ili7807s.o
 obj-$(CONFIG_DRM_PANEL_ILITEK_IL9322) += panel-ilitek-ili9322.o
 obj-$(CONFIG_DRM_PANEL_ILITEK_ILI9341) += panel-ilitek-ili9341.o
 obj-$(CONFIG_DRM_PANEL_ILITEK_ILI9805) += panel-ilitek-ili9805.o
diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili7807s.c b/drivers/gpu/drm/panel/panel-ilitek-ili7807s.c
new file mode 100644
index 000000000000..12b491b0bca4
--- /dev/null
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili7807s.c
@@ -0,0 +1,285 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <linux/backlight.h>
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/regulator/consumer.h>
+
+#include <video/mipi_display.h>
+
+#include <drm/drm_mipi_dsi.h>
+#include <drm/drm_modes.h>
+#include <drm/drm_panel.h>
+#include <drm/drm_probe_helper.h>
+
+struct panel_desc {
+	const struct drm_display_mode *mode;
+	unsigned int lanes;
+	enum mipi_dsi_pixel_format format;
+	unsigned long mode_flags;
+	void (*init)(struct mipi_dsi_multi_context *dsi_ctx);
+};
+
+struct ili7807s {
+	struct drm_panel panel;
+	struct mipi_dsi_device *dsi;
+	const struct panel_desc *desc;
+
+	struct regulator_bulk_data *supplies;
+	struct gpio_desc *reset_gpio;
+};
+
+static const struct regulator_bulk_data ili7807s_supplies[] = {
+	{ .supply = "vddi" },
+	{ .supply = "avdd" },
+	{ .supply = "avee" },
+};
+
+static inline struct ili7807s *to_ili7807s(struct drm_panel *panel)
+{
+	return container_of(panel, struct ili7807s, panel);
+}
+
+static void ili7807s_reset(struct ili7807s *ctx)
+{
+	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
+	usleep_range(10000, 11000);
+	gpiod_set_value_cansleep(ctx->reset_gpio, 0);
+	usleep_range(10000, 11000);
+}
+
+static void dlc0697_init_sequence(struct mipi_dsi_multi_context *dsi_ctx)
+{
+	mipi_dsi_dcs_soft_reset_multi(dsi_ctx);
+	mipi_dsi_msleep(dsi_ctx, 120);
+
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xff, 0x78, 0x07, 0x00);
+	mipi_dsi_dcs_set_tear_on_multi(dsi_ctx, MIPI_DSI_DCS_TEAR_MODE_VBLANK);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, MIPI_DCS_SET_CABC_MIN_BRIGHTNESS, 0x09, 0x99);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, MIPI_DCS_WRITE_CONTROL_DISPLAY, 0x24);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, MIPI_DCS_WRITE_POWER_SAVE, 0x01);
+	mipi_dsi_dcs_set_display_brightness_multi(dsi_ctx, 0x1fff);
+
+	mipi_dsi_dcs_exit_sleep_mode_multi(dsi_ctx);
+	mipi_dsi_msleep(dsi_ctx, 120);
+
+	mipi_dsi_dcs_set_display_on_multi(dsi_ctx);
+	mipi_dsi_msleep(dsi_ctx, 20);
+}
+
+static int ili7807s_on(struct ili7807s *ctx)
+{
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
+
+	ctx->desc->init(&dsi_ctx);
+
+	return dsi_ctx.accum_err;
+}
+
+static int ili7807s_off(struct ili7807s *ctx)
+{
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
+
+	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
+	mipi_dsi_msleep(&dsi_ctx, 20);
+
+	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
+	mipi_dsi_msleep(&dsi_ctx, 120);
+
+	return dsi_ctx.accum_err;
+}
+
+static int ili7807s_prepare(struct drm_panel *panel)
+{
+	struct ili7807s *ctx = to_ili7807s(panel);
+	int ret;
+
+	ret = regulator_bulk_enable(ARRAY_SIZE(ili7807s_supplies), ctx->supplies);
+	if (ret < 0) {
+		dev_err(ctx->panel.dev, "failed to enable regulators: %d\n", ret);
+		return ret;
+	}
+
+	msleep(20);
+
+	ili7807s_reset(ctx);
+
+	ret = ili7807s_on(ctx);
+	if (ret < 0) {
+		dev_err(ctx->panel.dev, "failed to initialise panel: %d\n", ret);
+		goto err;
+	}
+
+	return 0;
+
+err:
+	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
+
+	regulator_bulk_disable(ARRAY_SIZE(ili7807s_supplies), ctx->supplies);
+	return ret;
+}
+
+static int ili7807s_unprepare(struct drm_panel *panel)
+{
+	struct ili7807s *ctx = to_ili7807s(panel);
+	int ret;
+
+	ret = ili7807s_off(ctx);
+	if (ret < 0)
+		dev_err(ctx->panel.dev, "failed to disable panel: %d\n", ret);
+
+	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
+
+	regulator_bulk_disable(ARRAY_SIZE(ili7807s_supplies), ctx->supplies);
+
+	return 0;
+}
+
+static int ili7807s_get_modes(struct drm_panel *panel,
+			      struct drm_connector *connector)
+{
+	struct ili7807s *ctx = to_ili7807s(panel);
+
+	return drm_connector_helper_get_modes_fixed(connector, ctx->desc->mode);
+}
+
+static const struct drm_panel_funcs ili7807s_panel_funcs = {
+	.prepare = ili7807s_prepare,
+	.unprepare = ili7807s_unprepare,
+	.get_modes = ili7807s_get_modes,
+};
+
+static int ili7807s_bl_update_status(struct backlight_device *bl)
+{
+	struct mipi_dsi_device *dsi = bl_get_data(bl);
+	u16 brightness = backlight_get_brightness(bl);
+	int ret;
+
+	dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
+
+	ret = mipi_dsi_dcs_set_display_brightness_large(dsi, brightness);
+
+	dsi->mode_flags |= MIPI_DSI_MODE_LPM;
+
+	return ret;
+}
+
+static const struct backlight_ops ili7807s_bl_ops = {
+	.update_status = ili7807s_bl_update_status,
+};
+
+static struct backlight_device *ili7807s_create_backlight(struct mipi_dsi_device *dsi)
+{
+	struct device *dev = &dsi->dev;
+	const struct backlight_properties props = {
+		.type           = BACKLIGHT_RAW,
+		.brightness     = 0x3fff,
+		.max_brightness = 0x3fff,
+	};
+
+	return devm_backlight_device_register(dev, dev_name(dev), dev, dsi,
+					      &ili7807s_bl_ops, &props);
+}
+
+static const struct drm_display_mode dlc0697_mode = {
+	.clock = (1080 + 18 + 2 + 16) * (1920 + 26 + 4 + 20) * 60 / 1000,
+
+	.hdisplay    = 1080,
+	.hsync_start = 1080 + 18,
+	.hsync_end   = 1080 + 18 + 2,
+	.htotal      = 1080 + 18 + 2 + 16,
+
+	.vdisplay    = 1920,
+	.vsync_start = 1920 + 26,
+	.vsync_end   = 1920 + 26 + 4,
+	.vtotal      = 1920 + 26 + 4 + 20,
+
+	.width_mm  = 87,
+	.height_mm = 154,
+	.type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
+};
+
+static const struct panel_desc dlc0697_desc = {
+	.mode       = &dlc0697_mode,
+	.lanes      = 4,
+	.format     = MIPI_DSI_FMT_RGB888,
+	.mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST,
+	.init       = dlc0697_init_sequence,
+};
+
+static int ili7807s_probe(struct mipi_dsi_device *dsi)
+{
+	struct device *dev = &dsi->dev;
+	const struct panel_desc *desc;
+	struct ili7807s *ctx;
+	int ret;
+
+	ctx = devm_drm_panel_alloc(dev, struct ili7807s, panel,
+				   &ili7807s_panel_funcs,
+				   DRM_MODE_CONNECTOR_DSI);
+	if (IS_ERR(ctx))
+		return PTR_ERR(ctx);
+
+	desc = of_device_get_match_data(dev);
+	ctx->desc = desc;
+
+	ret = devm_regulator_bulk_get_const(dev, ARRAY_SIZE(ili7807s_supplies),
+					    ili7807s_supplies, &ctx->supplies);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "failed to get regulators\n");
+
+	ctx->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(ctx->reset_gpio))
+		return dev_err_probe(dev, PTR_ERR(ctx->reset_gpio),
+				     "failed to get reset gpio\n");
+
+	ctx->dsi = dsi;
+	mipi_dsi_set_drvdata(dsi, ctx);
+
+	dsi->lanes      = desc->lanes;
+	dsi->format     = desc->format;
+	dsi->mode_flags = desc->mode_flags | MIPI_DSI_MODE_LPM;
+
+	ctx->panel.prepare_prev_first = true;
+
+	ret = drm_panel_of_backlight(&ctx->panel);
+	if (ret)
+		return ret;
+
+	if (!ctx->panel.backlight) {
+		ctx->panel.backlight = ili7807s_create_backlight(dsi);
+		if (IS_ERR(ctx->panel.backlight))
+			return dev_err_probe(dev, PTR_ERR(ctx->panel.backlight),
+					     "failed to create backlight\n");
+	}
+
+	ret = devm_drm_panel_add(dev, &ctx->panel);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "failed to add panel\n");
+
+	return devm_mipi_dsi_attach(dev, dsi);
+}
+
+static const struct of_device_id ili7807s_of_match[] = {
+	{ .compatible = "dlc,dlc0697", .data = &dlc0697_desc },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ili7807s_of_match);
+
+static struct mipi_dsi_driver ili7807s_dsi_driver = {
+	.probe  = ili7807s_probe,
+	.driver = {
+		.name           = "panel-ilitek-ili7807s",
+		.of_match_table = ili7807s_of_match,
+	},
+};
+module_mipi_dsi_driver(ili7807s_dsi_driver);
+
+MODULE_AUTHOR("Arpit Saini <arpit.saini@oss.qualcomm.com>");
+MODULE_DESCRIPTION("Panel driver for Ilitek ILI7807S LCD DSI panel");
+MODULE_LICENSE("GPL");

-- 
2.34.1

