Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF9ABCA5FC2
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 07:06:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB87110F1F8;
	Wed, 30 Sep 2026 07:06:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BSI9IUrH";
	dkim-atps=neutral
Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com
 [74.125.225.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D9DE10F1F2
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 07:06:07 +0000 (UTC)
Received: by mail-wr2-f35.google.com with SMTP id
 ffacd0b85a97d-4885d4825adso3002051f8f.0
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 00:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790751966; x=1791356766; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XiVdqK0mPJMiTj9TjmslKFBRQLjGuLireiU6ZeHCNqY=;
 b=BSI9IUrHwcRt7yrd0qTLzGH3On7OaPBOaPWznN7h0TiHdUQZ7gO5aAp92M3uBFeaEi
 ykQpDeRbJX2L5FtxbHvtGQSbqmF4mt+uLtCv7IXRcI9cc1K7LGLI89aj5wCQBVizE/DE
 qZZoKQPqtpLXjEuNC6BH++Er7nptmFtJGxHvSNC2zBV7T2Kd4Gvy5+j1qxVDqc4D2FnT
 cieCxbIfFsIKeLFwQ13e2T2FLfeOH7oKrDqMk7PgzrwZca4uQ13mDqvh2pqBsIZTrBvY
 0CGCGmD6eDK/CTi3Ne4kaxuh+nGc0ix0s8b+gUy9xrz8zh0I/AeDWpzPbbh581qsNnCF
 GUGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790751966; x=1791356766;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=XiVdqK0mPJMiTj9TjmslKFBRQLjGuLireiU6ZeHCNqY=;
 b=MmaOVCNv+VEc/CGxrkyNw5sxj+HYsHUfTHhcJ801nx0l9O4HowWsl8p46enWiwl1I8
 BFwfZ6X0kXeaAIV4dWZouvjyV+zWF8982zY7PadYiuvpeSJ4NPQ15vwqlKKE645yQfP5
 beT8PTrjKGArh13Xzan3YnTGdv2zJ1xPFqEq3XlnoyzJIU3Sq5VnsSNOJBZm/P8vpbPS
 O9vtz0P6eYIni18u00/euRjr/ae/oLYZcUZ4sifAN5KhkhBUsN/cDNDuP9laGqcCfF2n
 DjzPaRTowWrkqm3tg2sUKaDky7HtOy/eO84mAMYT1iM5G5I+TS4ttcR/2NqRW9cs6Tps
 ROOA==
X-Gm-Message-State: AFq9FYIbgtg+kRFZncrFxmOAzJlMLYtKAuLL3SS8RbgIqF2PqYZW2+7m
 /W2WQO3soGXjfwywpmI5RdOqXj+bQ6mqJSubm5H1UgTSvIhyuc0TvKOp
X-Gm-Gg: AYBFou2AW8FWRAZj3QELze0O2Qm7j4zpVfFkjKX5WJ2zRgIBQ0IquZ2pJjANs8Y8Akt
 yOXRCr0X5dRHvV3CXCzSlupfB6tkNauVU2udrL98zHlehsi5zYgzsyXPd/KK3WQBI+9Zcf+2Xly
 53uJjAVObz+IFV/5yf5OBSjY3sXSv48Yt3CUw4CAi7055AXnXwNZIFJTy+KupGRXOhfAIooJ427
 Vo/XQVL9sl1imkcAgEIvg1rEvymdliRMzSNgCRxeO72b5he0ZWToiJk3hkWVPnkjxl1YGQG2bOT
 hwDoSFcN5szPEsxlekiQXDG7Pbv/MkDXNHgKE+sru5xkAR/ms9UDF+j0rzIotpygtzypcQHzRjd
 mxubMkoFuoPhAD6S/cvNLugiLvqATipIvSM+lcnJQOQoNw+2xk0guFyXhkcr9f1QeoJmtmm135o
 MntBOk3gkjsAPVz4DuP6q0sxZuO5WI/Jy3KKAFFoH5/yp3u8Pu6oJpgBC+oba7d4fPKIyL+VpR3
 qsNObnliz9WFrAY8NI=
X-Received: by 2002:a5d:5849:0:b0:487:35c:6513 with SMTP id
 ffacd0b85a97d-48b02526242mr945840f8f.42.1790751965649; 
 Wed, 30 Sep 2026 00:06:05 -0700 (PDT)
Received: from xeon ([188.163.112.76]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b029f5bcdsm1145150f8f.27.2026.09.30.00.06.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 00:06:05 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH v1 6/6] drm/panel: Add Hitachi TX10D07VM0BAA and LG
 LH400WV3-SD04 MIPI DBI panel driver
Date: Wed, 30 Sep 2026 10:05:35 +0300
Message-ID: <20260930070535.47130-7-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930070535.47130-1-clamor95@gmail.com>
References: <20260930070535.47130-1-clamor95@gmail.com>
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

Add a driver for panels used in LG Optimus 2X P990. Both panels are 4"
WVGA MIPI DBI Type B linked to DRM encoder via RGB to DBI bridge.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/gpu/drm/panel/Kconfig                 |  14 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 .../drm/panel/panel-hitachi-tx10d07vm0baa.c   | 396 ++++++++++++++++++
 3 files changed, 411 insertions(+)
 create mode 100644 drivers/gpu/drm/panel/panel-hitachi-tx10d07vm0baa.c

diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index 747f47347521a..47962197a9c76 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -273,6 +273,20 @@ config DRM_PANEL_HIMAX_HX8394
 
 	  If M is selected the module will be called panel-himax-hx8394.
 
+config DRM_PANEL_HITACHI_TX10D07VM0BAA
+	tristate "Hitachi TX10D07VM0BAA and LG LH400WV3 MIPI DBI panels"
+	depends on OF
+	depends on BACKLIGHT_CLASS_DEVICE
+	select DRM_MIPI_DBI
+	select VIDEOMODE_HELPERS
+	help
+	  Say Y here if you want to enable support for the HITACHI
+	  TX10D07VM0BAA and LG LH400WV3 MIPI DBI panels found in the
+	  LG Optimus 2X P990 smartphone.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called panel-hitachi-tx10d07vm0baa.
+
 config DRM_PANEL_HYDIS_HV101HD1
 	tristate "Hydis HV101HD1 panel"
 	depends on OF
diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
index f2c9c80a218f0..414267a49d922 100644
--- a/drivers/gpu/drm/panel/Makefile
+++ b/drivers/gpu/drm/panel/Makefile
@@ -27,6 +27,7 @@ obj-$(CONFIG_DRM_PANEL_HIMAX_HX83112A) += panel-himax-hx83112a.o
 obj-$(CONFIG_DRM_PANEL_HIMAX_HX83112B) += panel-himax-hx83112b.o
 obj-$(CONFIG_DRM_PANEL_HIMAX_HX83121A) += panel-himax-hx83121a.o
 obj-$(CONFIG_DRM_PANEL_HIMAX_HX8394) += panel-himax-hx8394.o
+obj-$(CONFIG_DRM_PANEL_HITACHI_TX10D07VM0BAA) += panel-hitachi-tx10d07vm0baa.o
 obj-$(CONFIG_DRM_PANEL_HYDIS_HV101HD1) += panel-hydis-hv101hd1.o
 obj-$(CONFIG_DRM_PANEL_ILITEK_ILI7807S) += panel-ilitek-ili7807s.o
 obj-$(CONFIG_DRM_PANEL_ILITEK_ILI7836A) += panel-ilitek-ili7836a.o
diff --git a/drivers/gpu/drm/panel/panel-hitachi-tx10d07vm0baa.c b/drivers/gpu/drm/panel/panel-hitachi-tx10d07vm0baa.c
new file mode 100644
index 0000000000000..d2c3b63649288
--- /dev/null
+++ b/drivers/gpu/drm/panel/panel-hitachi-tx10d07vm0baa.c
@@ -0,0 +1,396 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/array_size.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/gpio/consumer.h>
+#include <linux/media-bus-format.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+#include <linux/regulator/consumer.h>
+
+#include <video/mipi_display.h>
+
+#include <drm/drm_mipi_dbi.h>
+#include <drm/drm_modes.h>
+#include <drm/drm_of.h>
+#include <drm/drm_panel.h>
+#include <drm/drm_probe_helper.h>
+
+enum panel_dbi_id {
+	PANEL_DBI_NONE,
+	PANEL_DBI_TX10D07VM0BAA,
+	PANEL_DBI_LH400WV3,
+};
+
+static const struct regulator_bulk_data panel_dbi_supplies[] = {
+	{ .supply = "avci" }, { .supply = "iovcc" },
+};
+
+struct panel_dbi {
+	struct drm_panel panel;
+	struct mipi_dbi *dbi;
+
+	struct regulator_bulk_data *supplies;
+	struct gpio_desc *reset_gpio;
+};
+
+static inline struct panel_dbi *to_panel_dbi(struct drm_panel *panel)
+{
+	return container_of(panel, struct panel_dbi, panel);
+}
+
+#define panel_dbi_command(priv, cmd, seq...) \
+({ \
+	const u8 d[] = { seq }; \
+	struct drm_panel *panel = &(priv)->panel; \
+	struct device *dev = panel->dev; \
+	int ret; \
+	ret = mipi_dbi_command_stackbuf((priv)->dbi, cmd, d, ARRAY_SIZE(d)); \
+	if (ret) \
+		dev_err_ratelimited(dev, "error %d when sending command %#02x\n", ret, cmd); \
+	ret; \
+})
+
+static int panel_dbi_prepare(struct drm_panel *panel)
+{
+	struct panel_dbi *priv = to_panel_dbi(panel);
+	struct platform_device *bridge_pdev;
+	struct device_node *bridge_node;
+	struct device *dev = panel->dev;
+	int ret;
+
+	bridge_node = of_graph_get_remote_node(dev_of_node(dev), 0, 0);
+	if (!bridge_node)
+		return -ENODEV;
+
+	bridge_pdev = of_find_device_by_node(bridge_node);
+	of_node_put(bridge_node);
+	if (!bridge_pdev)
+		return -ENODEV;
+
+	priv->dbi = platform_get_drvdata(bridge_pdev);
+	if (!priv->dbi)
+		return -ENODEV;
+
+	gpiod_set_value_cansleep(priv->reset_gpio, 1);
+
+	ret = regulator_bulk_enable(ARRAY_SIZE(panel_dbi_supplies), priv->supplies);
+	if (ret) {
+		dev_err(dev, "failed to enable power supplies: %d\n", ret);
+		return ret;
+	}
+
+	usleep_range(1000, 2000);
+
+	gpiod_set_value_cansleep(priv->reset_gpio, 0);
+
+	usleep_range(10000, 11000);
+
+	return 0;
+};
+
+static int panel_dbi_unprepare(struct drm_panel *panel)
+{
+	struct panel_dbi *priv = to_panel_dbi(panel);
+
+	gpiod_set_value_cansleep(priv->reset_gpio, 1);
+	regulator_bulk_disable(ARRAY_SIZE(panel_dbi_supplies), priv->supplies);
+
+	msleep(50);
+
+	return 0;
+}
+
+static const struct drm_display_mode panel_dbi_mode = {
+	.clock = (480 + 10 + 10 + 10) * (800 + 4 + 4 + 4) * 60 / 1000,
+	.hdisplay = 480,
+	.hsync_start = 480 + 10,
+	.hsync_end = 480 + 10 + 10,
+	.htotal = 480 + 10 + 10 + 10,
+	.vdisplay = 800,
+	.vsync_start = 800 + 4,
+	.vsync_end = 800 + 4 + 4,
+	.vtotal = 800 + 4 + 4 + 4,
+	.width_mm = 86,
+	.height_mm = 52,
+	.type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
+};
+
+static int panel_dbi_get_modes(struct drm_panel *panel,
+			       struct drm_connector *connector)
+{
+	u32 bus_format = MEDIA_BUS_FMT_RGB888_1X24;
+
+	drm_display_info_set_bus_formats(&connector->display_info,
+					 &bus_format, 1);
+
+	connector->display_info.bus_flags = DRM_BUS_FLAG_PIXDATA_SAMPLE_POSEDGE |
+					    DRM_BUS_FLAG_SYNC_SAMPLE_NEGEDGE |
+					    DRM_BUS_FLAG_DE_HIGH |
+					    DRM_BUS_FLAG_DATA_LSB_TO_MSB;
+
+	return drm_connector_helper_get_modes_fixed(connector, &panel_dbi_mode);
+}
+
+static int hitachi_tx10d07vm0baa_enable(struct drm_panel *panel)
+{
+	struct panel_dbi *priv = to_panel_dbi(panel);
+
+	panel_dbi_command(priv, MIPI_DCS_SET_PARTIAL_ROWS, 0x00, 0x00, 0x03, 0x1f);
+	panel_dbi_command(priv, MIPI_DCS_SET_SCROLL_AREA, 0x00, 0x00, 0x03, 0x20,
+			  0x00, 0x00);
+
+	panel_dbi_command(priv, MIPI_DCS_SET_ADDRESS_MODE, 0x0a);
+	panel_dbi_command(priv, MIPI_DCS_SET_SCROLL_START, 0x00, 0x00);
+
+	panel_dbi_command(priv, MIPI_DCS_SET_PIXEL_FORMAT, MIPI_DCS_PIXEL_FMT_24BIT);
+	panel_dbi_command(priv, MIPI_DCS_SET_TEAR_SCANLINE, 0x00, 0x00);
+
+	panel_dbi_command(priv, 0x71, 0x00);		/* Ex_Vsync_en */
+
+	panel_dbi_command(priv, 0xb2, 0x00);		/* VCSEL */
+	panel_dbi_command(priv, 0xb4, 0xaa);		/* setvgmpm */
+	panel_dbi_command(priv, 0xb5, 0x33);		/* rbias1 */
+	panel_dbi_command(priv, 0xb6, 0x03);		/* rbias2 */
+
+	panel_dbi_command(priv, 0xb7, 0x1a, 0x33, 0x03, 0x03,
+			  0x03, 0x00, 0x00, 0x01, 0x02, 0x00,
+			  0x00, 0x04, 0x00, 0x01, 0x01, 0x01);	/* set_ddvdhp */
+	panel_dbi_command(priv, 0xb8, 0x1c, 0x53, 0x03, 0x03,
+			  0x00, 0x01, 0x02, 0x00, 0x00, 0x04,
+			  0x00, 0x01, 0x01);			/* set_ddvdhm */
+
+	panel_dbi_command(priv, 0xb9, 0x0a, 0x01, 0x01, 0x00,
+			  0x00, 0x00, 0x02, 0x00, 0x02, 0x01);	/* set_vgh */
+	panel_dbi_command(priv, 0xba, 0x0f, 0x01, 0x01, 0x00,
+			  0x00, 0x00, 0x02, 0x00, 0x02, 0x01);	/* set_vgl */
+	panel_dbi_command(priv, 0xbb, 0x00, 0x00, 0x00, 0x00,
+			  0x01, 0x02, 0x01);			/* set_vcl */
+
+	panel_dbi_command(priv, 0xc1, 0x01);		/* number of lines */
+	panel_dbi_command(priv, 0xc2, 0x08);		/* number of fp lines */
+	panel_dbi_command(priv, 0xc3, 0x04);		/* gateset(1) */
+	panel_dbi_command(priv, 0xc4, 0x4c);		/* 1h period */
+	panel_dbi_command(priv, 0xc5, 0x03);		/* source precharge */
+	panel_dbi_command(priv, 0xc6, 0xc4, 0x04);	/* source precharge timing */
+	panel_dbi_command(priv, 0xc7, 0x00);		/* source level */
+	panel_dbi_command(priv, 0xc8, 0x02);		/* number of bp lines */
+	panel_dbi_command(priv, 0xc9, 0x10);		/* gateset(2) */
+	panel_dbi_command(priv, 0xca, 0x04, 0x04);	/* gateset(3) */
+	panel_dbi_command(priv, 0xcb, 0x03);		/* gateset(4) */
+	panel_dbi_command(priv, 0xcc, 0x12);		/* gateset(5) */
+	panel_dbi_command(priv, 0xcd, 0x12);		/* gateset(6) */
+	panel_dbi_command(priv, 0xce, 0x30);		/* gateset(7) */
+	panel_dbi_command(priv, 0xcf, 0x30);		/* gateset(8) */
+	panel_dbi_command(priv, 0xd0, 0x40);		/* gateset(9) */
+	panel_dbi_command(priv, 0xd1, 0x22);		/* flhw */
+	panel_dbi_command(priv, 0xd2, 0x22);		/* vckhw */
+	panel_dbi_command(priv, 0xd3, 0x04);		/* flt */
+	panel_dbi_command(priv, 0xd4, 0x14);		/* tctrl */
+	panel_dbi_command(priv, 0xd6, 0x02);		/* dotinv */
+	panel_dbi_command(priv, 0xd7, 0x00);		/* on/off sequence period */
+
+	panel_dbi_command(priv, 0xd8, 0x01, 0x05, 0x06, 0x0d,
+			  0x18, 0x09, 0x22, 0x23, 0x00);		/* ponseqa */
+	panel_dbi_command(priv, 0xd9, 0x24, 0x01);			/* ponseqb */
+	panel_dbi_command(priv, 0xde, 0x09, 0x0f, 0x21, 0x12,
+			  0x04);					/* ponseqc */
+
+	panel_dbi_command(priv, 0xdf, 0x02, 0x06, 0x06, 0x06,
+			  0x06, 0x00);					/* pofseqa */
+	panel_dbi_command(priv, 0xe0, 0x01);				/* pofseqb */
+
+	panel_dbi_command(priv, MIPI_DCS_SET_DISPLAY_BRIGHTNESS, 0xff);
+	panel_dbi_command(priv, MIPI_DCS_WRITE_CONTROL_DISPLAY, 0x40);
+
+	panel_dbi_command(priv, 0xe2, 0x00, 0x00);		/* cabc pwm */
+	panel_dbi_command(priv, 0xe3, 0x03);			/* cabc */
+	panel_dbi_command(priv, 0xe4, 0x66, 0x7b, 0x90, 0xa5,
+			  0xbb, 0xc7, 0xe1, 0xe5);		/* cabc brightness */
+	panel_dbi_command(priv, 0xe5, 0xc5, 0xc5, 0xc9, 0xc9,
+			  0xd1, 0xe1, 0xf1, 0xfe);		/* cabc brightness */
+	panel_dbi_command(priv, 0xe7, 0x2a);			/* cabc */
+	panel_dbi_command(priv, 0xe8, 0x00);			/* brt_rev */
+	panel_dbi_command(priv, 0xe9, 0x00);			/* tefreq */
+
+	panel_dbi_command(priv, 0xea, 0x01);			/* high speed ram */
+
+	panel_dbi_command(priv, 0xeb, 0x00, 0x33, 0x0e, 0x15,
+			  0xb7, 0x78, 0x88, 0x0f);		/* gamma setting r pos */
+	panel_dbi_command(priv, 0xec, 0x00, 0x33, 0x0e, 0x15,
+			  0xb7, 0x78, 0x88, 0x0f);		/* gamma setting r neg */
+	panel_dbi_command(priv, 0xed, 0x00, 0x33, 0x0e, 0x15,
+			  0xb7, 0x78, 0x88, 0x0f);		/* gamma setting g pos */
+	panel_dbi_command(priv, 0xee, 0x00, 0x33, 0x0e, 0x15,
+			  0xb7, 0x78, 0x88, 0x0f);		/* gamma setting g neg */
+	panel_dbi_command(priv, 0xef, 0x00, 0x33, 0x0e, 0x15,
+			  0xb7, 0x78, 0x88, 0x0f);		/* gamma setting b pos */
+	panel_dbi_command(priv, 0xf0, 0x00, 0x33, 0x0e, 0x15,
+			  0xb7, 0x78, 0x88, 0x0f);		/* gamma setting b neg */
+
+	panel_dbi_command(priv, MIPI_DCS_EXIT_SLEEP_MODE);
+	msleep(110);
+
+	panel_dbi_command(priv, MIPI_DCS_SET_DISPLAY_ON);
+
+	return 0;
+}
+
+static int hitachi_tx10d07vm0baa_disable(struct drm_panel *panel)
+{
+	struct panel_dbi *priv = to_panel_dbi(panel);
+
+	panel_dbi_command(priv, MIPI_DCS_SET_DISPLAY_OFF);
+	msleep(35);
+
+	panel_dbi_command(priv, MIPI_DCS_ENTER_SLEEP_MODE);
+	msleep(50);
+
+	return 0;
+}
+
+static const struct drm_panel_funcs hitachi_tx10d07vm0baa_panel_funcs = {
+	.prepare = panel_dbi_prepare,
+	.enable = hitachi_tx10d07vm0baa_enable,
+	.disable = hitachi_tx10d07vm0baa_disable,
+	.unprepare = panel_dbi_unprepare,
+	.get_modes = panel_dbi_get_modes,
+};
+
+static int lg_lh400wv3_enable(struct drm_panel *panel)
+{
+	struct panel_dbi *priv = to_panel_dbi(panel);
+
+	panel_dbi_command(priv, MIPI_DCS_EXIT_INVERT_MODE);
+	panel_dbi_command(priv, MIPI_DCS_SET_TEAR_ON);
+
+	panel_dbi_command(priv, MIPI_DCS_SET_PIXEL_FORMAT, MIPI_DCS_PIXEL_FMT_24BIT |
+			  MIPI_DCS_PIXEL_FMT_24BIT << 4);
+
+	panel_dbi_command(priv, 0xb2, 0x00, 0xc8);
+	panel_dbi_command(priv, 0xb3, 0x00);
+	panel_dbi_command(priv, 0xb4, 0x04);
+	panel_dbi_command(priv, 0xb5, 0x42, 0x10, 0x10, 0x00, 0x20);
+	panel_dbi_command(priv, 0xb6, 0x0b, 0x0f, 0x3c, 0x13, 0x13, 0xe8);
+	panel_dbi_command(priv, 0xb7, 0x4c, 0x06, 0x0c, 0x00, 0x00);
+
+	panel_dbi_command(priv, 0xc0, 0x01, 0x11);
+	panel_dbi_command(priv, 0xc3, 0x07, 0x03, 0x04, 0x04, 0x04);
+	panel_dbi_command(priv, 0xc4, 0x12, 0x24, 0x18, 0x18, 0x02, 0x49);
+	panel_dbi_command(priv, 0xc5, 0x65);
+	panel_dbi_command(priv, 0xc6, 0x41, 0x63);
+
+	panel_dbi_command(priv, 0xd0, 0x00, 0x46, 0x74, 0x32, 0x1d, 0x03, 0x51, 0x15, 0x04);
+	panel_dbi_command(priv, 0xd1, 0x00, 0x46, 0x74, 0x32, 0x1d, 0x03, 0x51, 0x15, 0x04);
+	panel_dbi_command(priv, 0xd2, 0x00, 0x46, 0x74, 0x32, 0x1f, 0x03, 0x51, 0x15, 0x04);
+	panel_dbi_command(priv, 0xd3, 0x00, 0x46, 0x74, 0x32, 0x1f, 0x03, 0x51, 0x15, 0x04);
+	panel_dbi_command(priv, 0xd4, 0x01, 0x46, 0x74, 0x25, 0x00, 0x03, 0x51, 0x15, 0x04);
+	panel_dbi_command(priv, 0xd5, 0x01, 0x46, 0x74, 0x25, 0x00, 0x03, 0x51, 0x15, 0x04);
+
+	panel_dbi_command(priv, MIPI_DCS_SET_COLUMN_ADDRESS, 0x00, 0x00, 0x01, 0xdf);
+	panel_dbi_command(priv, MIPI_DCS_SET_PAGE_ADDRESS, 0x00, 0x00, 0x03, 0x1f);
+
+	panel_dbi_command(priv, MIPI_DCS_EXIT_SLEEP_MODE);
+	msleep(120);
+
+	panel_dbi_command(priv, MIPI_DCS_WRITE_MEMORY_START);
+	panel_dbi_command(priv, MIPI_DCS_SET_DISPLAY_ON);
+
+	return 0;
+}
+
+static int lg_lh400wv3_disable(struct drm_panel *panel)
+{
+	struct panel_dbi *priv = to_panel_dbi(panel);
+
+	panel_dbi_command(priv, MIPI_DCS_SET_DISPLAY_OFF);
+	panel_dbi_command(priv, MIPI_DCS_ENTER_SLEEP_MODE);
+	msleep(150);
+
+	panel_dbi_command(priv, 0xc1, 0x01);
+	usleep_range(10000, 11000);
+
+	return 0;
+};
+
+static const struct drm_panel_funcs lg_lh400wv3_panel_funcs = {
+	.prepare = panel_dbi_prepare,
+	.enable = lg_lh400wv3_enable,
+	.disable = lg_lh400wv3_disable,
+	.unprepare = panel_dbi_unprepare,
+	.get_modes = panel_dbi_get_modes,
+};
+
+static int panel_dbi_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	const struct drm_panel_funcs *panel_dbi_funcs;
+	struct panel_dbi *priv;
+	enum panel_dbi_id id;
+	int ret;
+
+	id = (uintptr_t)of_device_get_match_data(dev);
+
+	switch (id) {
+	case PANEL_DBI_TX10D07VM0BAA:
+		panel_dbi_funcs = &hitachi_tx10d07vm0baa_panel_funcs;
+		break;
+
+	case PANEL_DBI_LH400WV3:
+		panel_dbi_funcs = &lg_lh400wv3_panel_funcs;
+		break;
+
+	default:
+		return dev_err_probe(dev, -ENODEV, "Unknown device %d\n", id);
+	}
+
+	priv = devm_drm_panel_alloc(dev, struct panel_dbi, panel,
+				    panel_dbi_funcs, DRM_MODE_CONNECTOR_DPI);
+	if (IS_ERR(priv))
+		return PTR_ERR(priv);
+
+	ret = devm_regulator_bulk_get_const(dev, ARRAY_SIZE(panel_dbi_supplies),
+					    panel_dbi_supplies, &priv->supplies);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to get supplies\n");
+
+	priv->reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(priv->reset_gpio))
+		return dev_err_probe(dev, PTR_ERR(priv->reset_gpio),
+				     "Failed to get reset gpio\n");
+
+	ret = drm_panel_of_backlight(&priv->panel);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to get backlight\n");
+
+	ret = devm_drm_panel_add(dev, &priv->panel);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to add panel\n");
+
+	platform_set_drvdata(pdev, priv);
+
+	return 0;
+}
+
+static const struct of_device_id panel_dbi_of_match[] = {
+	{ .compatible = "hit,tx10d07vm0baa", .data = (void *)PANEL_DBI_TX10D07VM0BAA },
+	{ .compatible = "lg,lh400wv3-sd04", .data = (void *)PANEL_DBI_LH400WV3 },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, panel_dbi_of_match);
+
+static struct platform_driver panel_dbi_driver = {
+	.driver = {
+		.name = "panel-hitachi-tx10d07vm0baa",
+		.of_match_table = panel_dbi_of_match,
+	},
+	.probe = panel_dbi_probe,
+};
+module_platform_driver(panel_dbi_driver);
+
+MODULE_AUTHOR("Svyatoslav Ryhel <clamor95@gmail.com>");
+MODULE_DESCRIPTION("HITACHI TX10D07VM0BAA and LG LH400WV3-SD04 DBI panels driver");
+MODULE_LICENSE("GPL");
-- 
2.53.0

