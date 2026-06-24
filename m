Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E92C0CDB47F
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 08:54:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E27D10EE1C;
	Wed, 24 Jun 2026 08:54:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="jyuEqLF9";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24A3A10EE25
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 08:54:15 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65O5trZi1972136; Wed, 24 Jun 2026 08:54:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 roGAArzJagt0EeREZxN3Bt69vvVc4LbdRpbe1U4jaRI=; b=jyuEqLF9oKU2Tqd6
 LPymc0BU9Uq76PNtJEarSxRcc/hpRuzI2MZm7uytVNd2NvSr+FZfOtLWJPZ9J8jk
 LvWEBAxoNsJrTHD8+oJltFjuA42UtPUWXq4BrzXKjS8dxTJeI0Ni9t4/I+d8zWRP
 b/G5q9FgW3CQ3oII7apXDDWMOCNVg/8J/jv4Rk5GhWWpnXq9LroRQsmJedY2qHvT
 jNz5RkDaDboM7b+1gFETf/8o0uUonmnD+1zF4aAiGNgLXHsskXo8YY0Tp8YH5zJF
 B2hsAhTJ3UZIvPHNXbUinzdCRpB1YYUoOPv9fHo8FLiJHRblRNYTXDhaxcYwKYFu
 nQrPyg==
Received: from apblrppmta02.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f00eva81m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Jun 2026 08:54:06 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
 by APBLRPPMTA02.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 65O8oq6s005843; 
 Wed, 24 Jun 2026 08:54:02 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 4ewkxk3jsv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Jun 2026 08:54:02 +0000 (GMT)
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com
 [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 65O8s21I009032;
 Wed, 24 Jun 2026 08:54:02 GMT
Received: from hu-devc-hyd-u22-c.qualcomm.com (hu-arpisain-hyd.qualcomm.com
 [10.147.248.17])
 by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 65O8s2Ji009007
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Jun 2026 08:54:02 +0000 (GMT)
Received: from hu-arpisain-hyd.qualcomm.com (localhost [127.0.0.1])
 by hu-devc-hyd-u22-c.qualcomm.com (Postfix) with ESMTP id 7E8EEBC1;
 Wed, 24 Jun 2026 14:24:01 +0530 (+0530)
From: Arpit Saini <arpit.saini@oss.qualcomm.com>
Date: Wed, 24 Jun 2026 14:23:52 +0530
Subject: [PATCH v3 2/2] drm/panel: add Ilitek ILI7807S panel driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260624-ili7807s-v3-2-ddf37052a289@oss.qualcomm.com>
References: <20260624-ili7807s-v3-0-ddf37052a289@oss.qualcomm.com>
In-Reply-To: <20260624-ili7807s-v3-0-ddf37052a289@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782291241; l=10343;
 i=arpit.saini@oss.qualcomm.com; h=from:subject:message-id;
 bh=h6CyvuRqGYcB0FWFbhuB3Y4mPe0a5e38mNTG2MLGeoU=;
 b=CBmGJmIGdpt9NLipCnx8KZ1KY8CDaZeJQH7Qha0doMuXZN3yRHJ2cIYJcP9kTm5KICvX2vrOC
 6WeIb2epglKAU6rUfWHt3eyf+iDz9CovC7D1mUGon4GGp0EUMf1Lfl3
X-Developer-Key: i=arpit.saini@oss.qualcomm.com; a=ed25519;
 pk=OGOh7FGwrnkILHNlcTTABbBMQxxo319duzbTg0YPDAc=
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDA3MyBTYWx0ZWRfX6WKMXB1I0RYM
 BOEuvAf/NtE/2JSKk4PF+CO4RHH8sWTz2RPTqezrFEIAVbDdJ/EEn6wjVr9t4fpsvxSvOIjIGuo
 m8jwr9tdzUsjLLb7BU7ljlu12kim42c=
X-Authority-Analysis: v=2.4 cv=JbaMa0KV c=1 sm=1 tr=0 ts=6a3b9b2e cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=PpNqgBxrR9VdnZ8GWKIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDA3MyBTYWx0ZWRfX/EwSYfmgQvGv
 GDDvUtlPuJOY6E3pVVLFfZfouOEXPaF5CbfXcmjsRhnj19TDNOo2pZlo0GCaPvHRazI82Lfytak
 qMP4LSdMV5Q47V7Gme4KR066kkjhctQ5Vhn97Z6YWY8fVyC4mOugjFOGxnk44MMZm1PkJ8pRRAU
 6paliT3STFru+iAdBo77uWglhpeKnmO+znoAo5cpLgWVPuorH7ej6VucjQmvcKvw6AY5qNiwhpK
 UqDqywiIzeyOja6d6iR2P3oPINq5pEXiXIPQLUGUTU3O/bpJym+Un1B6diuCzqICvb76Zczopo8
 LNJALU7rMvaYdqnQ3NLdRDGK8uufnB633oyuPwSNckdZ8EqIB8cGMRDSjLT/4bp7mGrKpxOSHm8
 Ykho6tKH+TgQdD6ZMGJngW9m+M5/Eg==
X-Proofpoint-ORIG-GUID: g9lTNThBGxsBc_IJRkxDhutAaHkkr4k_
X-Proofpoint-GUID: g9lTNThBGxsBc_IJRkxDhutAaHkkr4k_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_02,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 suspectscore=0 adultscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2606150000 definitions=main-2606240073
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
 drivers/gpu/drm/panel/panel-ilitek-ili7807s.c | 293 ++++++++++++++++++++++++++
 3 files changed, 306 insertions(+)

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
index 000000000000..8ddfab2693ec
--- /dev/null
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili7807s.c
@@ -0,0 +1,293 @@
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
+	gpiod_set_value_cansleep(ctx->reset_gpio, 0);
+	usleep_range(10000, 11000);
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
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x35, 0x00);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x5e, 0x09, 0x99);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x53, 0x24);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x55, 0x01);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x51, 0x3f, 0xff);
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
+	ctx->dsi->mode_flags |= MIPI_DSI_MODE_LPM;
+
+	ctx->desc->init(&dsi_ctx);
+
+	ctx->dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
+
+	return dsi_ctx.accum_err;
+}
+
+static int ili7807s_off(struct ili7807s *ctx)
+{
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
+
+	ctx->dsi->mode_flags |= MIPI_DSI_MODE_LPM;
+
+	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
+	mipi_dsi_msleep(&dsi_ctx, 20);
+
+	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
+	mipi_dsi_msleep(&dsi_ctx, 120);
+
+	ctx->dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
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
+	.clock = 131911,
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
+	.width_mm  = 0,
+	.height_mm = 0,
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
+	ctx->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(ctx->reset_gpio))
+		return dev_err_probe(dev, PTR_ERR(ctx->reset_gpio),
+				     "failed to get reset gpio\n");
+
+	ctx->dsi = dsi;
+	mipi_dsi_set_drvdata(dsi, ctx);
+
+	dsi->lanes      = desc->lanes;
+	dsi->format     = desc->format;
+	dsi->mode_flags = desc->mode_flags;
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

