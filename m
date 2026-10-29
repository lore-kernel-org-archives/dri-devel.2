Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D32A606A33D
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 15:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JW/rhR9+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 203BD1123E1;
	Thu, 29 Oct 2026 15:30:06 +0000 (UTC)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com
 [209.85.218.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57B1C1123D7
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 15:29:38 +0000 (UTC)
Received: by mail-ej1-f51.google.com with SMTP id
 a640c23a62f3a-c40e30c26a4so178718866b.0
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 08:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793287777; x=1793892577; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AKlnNUPAZYqn7bdU1beV1huh2DASjeUZeMyqIT8C+UA=;
 b=JW/rhR9+otdq3tW6bQYIwzeZVj3JsT7zicKCMzb4QLLNohikGu+KuGtBVzrpGLtObN
 yD8N/5u4ELc245C7xqoO5VXcwnao3gTMM613ayLGsDdSoKWShvoTcXbNO7/WTC/xorwT
 cLANF/3hIOcwb4lyCOKR1EXG+6188IS8FPTYHkfyE358hIbj5ORsWOdp7gFlsNX+Azc0
 3H4STCZ6K3Hh27/NNuX+FdUJum6JnK7kWqDll5LZoaXVaqh71KHAM+c/LxdqkimfxjnK
 nvxJ4pwWYlWITaF4/iq3MnK43hLR5qmOoZCjljuJIJCgSxgN0PW6DVJVafJpP1Pt22Lr
 +DaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793287777; x=1793892577;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=AKlnNUPAZYqn7bdU1beV1huh2DASjeUZeMyqIT8C+UA=;
 b=q0nCT2ohCFeoilkkASq7pfQHCJQcC1B8LW8xINyjsU/VraSAgMz5wLm9N+JOgdpVKf
 YC1qZNGVByJcNXe8l4j0Ns321qJV6em3KgWkKwbPxqHW7zNwVmeP0zKOPOG5OW852aYc
 WBtqDKrCA1JCKnnYQXFTHwykXKGusypqgFpi6apUBe9dA1QMGX5haUtbgvHXf76V41rN
 oilgM0zzbjgTksqp2lfCc7ZBExHT83RUGMWkboCIzIT+s1LP/oGz/qWRW/oUYep/zsJT
 ujC6Bi0fsy9ElOZv9r9LEYDodRgfwwbUpX5+zEev5+TjyVBfNEKbONC8eQlDnQp+XQO2
 qzVA==
X-Gm-Message-State: AFq9FYIHea2Z/HpG8/LLeuwW6xj2jcegi0IYfVdZx8Velsb/7pqPpo1s
 VL+GPdjS+GI2j90qwZ52TkB67Ub25Nx5hjyOwJ8qexJUG8l4DjlaylcX
X-Gm-Gg: AYBFou3eqUhhxllaWukViQYYWqxk2qi5F+H9ap4e7hgq7LJPupNJ6ReUIrL0kqdGLjt
 foXU1C9CTxl+w5d91eWMvGd/gKnnnJF5Ml2Rnr0eGG721YNgYFpusESP0KiFBRHfvPwu2bDL/W5
 CfTXngKtoZ5QYzuOmTCC0VTJszhqC2IpXYMJTvhNEAWQQafTRD1Rd0hMLZ920W5Wqo/VMhydOYf
 krHG2dcZu4iWYIJFOkAQ4MIcUxDZjxCyN7eq0mM+4yrXDvZncVckf4b0CR2q3/zaHujMYtX/2qH
 Sddm0oQuFgYqqTyYWMD9qflJsVCcBjV1O7MqwyFt9d6OxLwoMBKHzd4xSk3m9hPhfxKkhCHmMr9
 McBGtmPCcyWYDoHNdVHHYfnmaA3bT+A7cPvgno0cVl/Aci5RQYWrGTbr9cjs+dOgyboQIuzc7Bf
 QTKU/FWroexOkjlXmrDrEnfFYzMKqnhXH20jQmkbN0bFbiJBGpSrrWWjBAhp6Fvk1ShlSExyued
 o6p7/dEeAob0xwoc7f5VgO5uBCJ9ujL1odT+oHmNu9cw92m48lndajioUgAfUaIGa8k5VOMloRI
 NHNmfRAaaDedx/nH0s5cA1R7tIl6Hha2WHZ0rRz6VPGBQ7376hjNTphn2lEZn3n8Nb3dnA8=
X-Received: by 2002:a17:907:3faa:b0:c21:5cd6:3e49 with SMTP id
 a640c23a62f3a-c49d11364c7mr261281866b.9.1793287776394; 
 Thu, 29 Oct 2026 08:29:36 -0700 (PDT)
Received: from xeon ([188.163.112.62]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4ca27984f8sm1252166b.80.2026.10.29.08.29.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 08:29:35 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH v5 03/11] drm/panel: Add Hitachi TX10D07VM0BAA MIPI DBI Type B
 panel driver
Date: Thu, 29 Oct 2026 17:29:01 +0200
Message-ID: <20261029152909.234584-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261029152909.234584-1-clamor95@gmail.com>
References: <20261029152909.234584-1-clamor95@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a driver for panel used in LG Optimus 2X P990. Panel is 4" WVGA MIPI
DBI Type B linked to DRM encoder via RGB to DBI bridge.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/gpu/drm/panel/Kconfig                 |  14 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 .../drm/panel/panel-hitachi-tx10d07vm0baa.c   | 294 ++++++++++++++++++
 3 files changed, 309 insertions(+)
 create mode 100644 drivers/gpu/drm/panel/panel-hitachi-tx10d07vm0baa.c

diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index 7a520b4d60fef..0e86628bcdb80 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -274,6 +274,20 @@ config DRM_PANEL_HIMAX_HX8394
 
 	  If M is selected the module will be called panel-himax-hx8394.
 
+config DRM_PANEL_HITACHI_TX10D07VM0BAA
+	tristate "Hitachi TX10D07VM0BAA MIPI DBI Type B panel"
+	depends on OF
+	depends on BACKLIGHT_CLASS_DEVICE
+	select DRM_MIPI_DBI
+	select VIDEOMODE_HELPERS
+	help
+	  Say Y here if you want to enable support for the HITACHI
+	  TX10D07VM0BAA MIPI DBI Type B panel found in the LG Optimus 2X
+	  P990 smartphone.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called panel-hitachi-tx10d07vm0baa.
+
 config DRM_PANEL_HYDIS_HV101HD1
 	tristate "Hydis HV101HD1 panel"
 	depends on OF
diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
index da5175909d540..2f57e350311f3 100644
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
index 0000000000000..5ccc8d4725bc6
--- /dev/null
+++ b/drivers/gpu/drm/panel/panel-hitachi-tx10d07vm0baa.c
@@ -0,0 +1,294 @@
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
+#include <drm/drm_mipi_dbi_bus.h>
+#include <drm/drm_modes.h>
+#include <drm/drm_of.h>
+#include <drm/drm_panel.h>
+#include <drm/drm_probe_helper.h>
+
+static const struct regulator_bulk_data hitachi_tx10d07vm0baa_supplies[] = {
+	{ .supply = "avci" }, { .supply = "iovcc" },
+};
+
+struct hitachi_tx10d07vm0baa {
+	struct drm_panel panel;
+	struct mipi_dbi_device *dbi;
+
+	struct regulator_bulk_data *supplies;
+	struct gpio_desc *reset_gpio;
+};
+
+static inline struct hitachi_tx10d07vm0baa *to_hitachi_tx10d07vm0baa(struct drm_panel *panel)
+{
+	return container_of(panel, struct hitachi_tx10d07vm0baa, panel);
+}
+
+#define panel_dbi_command(dbidev, cmd, seq...) \
+({ \
+	const u8 d[] = { seq }; \
+	struct device *dev = &(dbidev)->dev; \
+	int ret; \
+	ret = mipi_dbi_command_stackbuf((dbidev)->dbi, cmd, d, ARRAY_SIZE(d)); \
+	if (ret) \
+		dev_err_ratelimited(dev, "error %d when sending command %#02x\n", ret, cmd); \
+	ret; \
+})
+
+static int hitachi_tx10d07vm0baa_prepare(struct drm_panel *panel)
+{
+	struct hitachi_tx10d07vm0baa *priv = to_hitachi_tx10d07vm0baa(panel);
+	struct device *dev = panel->dev;
+	int ret;
+
+	gpiod_set_value_cansleep(priv->reset_gpio, 1);
+
+	ret = regulator_bulk_enable(ARRAY_SIZE(hitachi_tx10d07vm0baa_supplies), priv->supplies);
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
+static int hitachi_tx10d07vm0baa_enable(struct drm_panel *panel)
+{
+	struct hitachi_tx10d07vm0baa *priv = to_hitachi_tx10d07vm0baa(panel);
+
+	panel_dbi_command(priv->dbi, MIPI_DCS_SET_PARTIAL_ROWS, 0x00, 0x00, 0x03, 0x1f);
+	panel_dbi_command(priv->dbi, MIPI_DCS_SET_SCROLL_AREA, 0x00, 0x00, 0x03, 0x20,
+			  0x00, 0x00);
+
+	panel_dbi_command(priv->dbi, MIPI_DCS_SET_ADDRESS_MODE, 0x0a);
+	panel_dbi_command(priv->dbi, MIPI_DCS_SET_SCROLL_START, 0x00, 0x00);
+
+	panel_dbi_command(priv->dbi, MIPI_DCS_SET_PIXEL_FORMAT, MIPI_DCS_PIXEL_FMT_24BIT);
+	panel_dbi_command(priv->dbi, MIPI_DCS_SET_TEAR_SCANLINE, 0x00, 0x00);
+
+	panel_dbi_command(priv->dbi, 0x71, 0x00);		/* Ex_Vsync_en */
+
+	panel_dbi_command(priv->dbi, 0xb2, 0x00);		/* VCSEL */
+	panel_dbi_command(priv->dbi, 0xb4, 0xaa);		/* setvgmpm */
+	panel_dbi_command(priv->dbi, 0xb5, 0x33);		/* rbias1 */
+	panel_dbi_command(priv->dbi, 0xb6, 0x03);		/* rbias2 */
+
+	panel_dbi_command(priv->dbi, 0xb7, 0x1a, 0x33, 0x03, 0x03,
+			  0x03, 0x00, 0x00, 0x01, 0x02, 0x00,
+			  0x00, 0x04, 0x00, 0x01, 0x01, 0x01);	/* set_ddvdhp */
+	panel_dbi_command(priv->dbi, 0xb8, 0x1c, 0x53, 0x03, 0x03,
+			  0x00, 0x01, 0x02, 0x00, 0x00, 0x04,
+			  0x00, 0x01, 0x01);			/* set_ddvdhm */
+
+	panel_dbi_command(priv->dbi, 0xb9, 0x0a, 0x01, 0x01, 0x00,
+			  0x00, 0x00, 0x02, 0x00, 0x02, 0x01);	/* set_vgh */
+	panel_dbi_command(priv->dbi, 0xba, 0x0f, 0x01, 0x01, 0x00,
+			  0x00, 0x00, 0x02, 0x00, 0x02, 0x01);	/* set_vgl */
+	panel_dbi_command(priv->dbi, 0xbb, 0x00, 0x00, 0x00, 0x00,
+			  0x01, 0x02, 0x01);			/* set_vcl */
+
+	panel_dbi_command(priv->dbi, 0xc1, 0x01);		/* number of lines */
+	panel_dbi_command(priv->dbi, 0xc2, 0x08);		/* number of fp lines */
+	panel_dbi_command(priv->dbi, 0xc3, 0x04);		/* gateset(1) */
+	panel_dbi_command(priv->dbi, 0xc4, 0x4c);		/* 1h period */
+	panel_dbi_command(priv->dbi, 0xc5, 0x03);		/* source precharge */
+	panel_dbi_command(priv->dbi, 0xc6, 0xc4, 0x04);	/* source precharge timing */
+	panel_dbi_command(priv->dbi, 0xc7, 0x00);		/* source level */
+	panel_dbi_command(priv->dbi, 0xc8, 0x02);		/* number of bp lines */
+	panel_dbi_command(priv->dbi, 0xc9, 0x10);		/* gateset(2) */
+	panel_dbi_command(priv->dbi, 0xca, 0x04, 0x04);	/* gateset(3) */
+	panel_dbi_command(priv->dbi, 0xcb, 0x03);		/* gateset(4) */
+	panel_dbi_command(priv->dbi, 0xcc, 0x12);		/* gateset(5) */
+	panel_dbi_command(priv->dbi, 0xcd, 0x12);		/* gateset(6) */
+	panel_dbi_command(priv->dbi, 0xce, 0x30);		/* gateset(7) */
+	panel_dbi_command(priv->dbi, 0xcf, 0x30);		/* gateset(8) */
+	panel_dbi_command(priv->dbi, 0xd0, 0x40);		/* gateset(9) */
+	panel_dbi_command(priv->dbi, 0xd1, 0x22);		/* flhw */
+	panel_dbi_command(priv->dbi, 0xd2, 0x22);		/* vckhw */
+	panel_dbi_command(priv->dbi, 0xd3, 0x04);		/* flt */
+	panel_dbi_command(priv->dbi, 0xd4, 0x14);		/* tctrl */
+	panel_dbi_command(priv->dbi, 0xd6, 0x02);		/* dotinv */
+	panel_dbi_command(priv->dbi, 0xd7, 0x00);		/* on/off sequence period */
+
+	panel_dbi_command(priv->dbi, 0xd8, 0x01, 0x05, 0x06, 0x0d,
+			  0x18, 0x09, 0x22, 0x23, 0x00);		/* ponseqa */
+	panel_dbi_command(priv->dbi, 0xd9, 0x24, 0x01);			/* ponseqb */
+	panel_dbi_command(priv->dbi, 0xde, 0x09, 0x0f, 0x21, 0x12,
+			  0x04);					/* ponseqc */
+
+	panel_dbi_command(priv->dbi, 0xdf, 0x02, 0x06, 0x06, 0x06,
+			  0x06, 0x00);					/* pofseqa */
+	panel_dbi_command(priv->dbi, 0xe0, 0x01);				/* pofseqb */
+
+	panel_dbi_command(priv->dbi, MIPI_DCS_SET_DISPLAY_BRIGHTNESS, 0xff);
+	panel_dbi_command(priv->dbi, MIPI_DCS_WRITE_CONTROL_DISPLAY, 0x40);
+
+	panel_dbi_command(priv->dbi, 0xe2, 0x00, 0x00);		/* cabc pwm */
+	panel_dbi_command(priv->dbi, 0xe3, 0x03);			/* cabc */
+	panel_dbi_command(priv->dbi, 0xe4, 0x66, 0x7b, 0x90, 0xa5,
+			  0xbb, 0xc7, 0xe1, 0xe5);		/* cabc brightness */
+	panel_dbi_command(priv->dbi, 0xe5, 0xc5, 0xc5, 0xc9, 0xc9,
+			  0xd1, 0xe1, 0xf1, 0xfe);		/* cabc brightness */
+	panel_dbi_command(priv->dbi, 0xe7, 0x2a);			/* cabc */
+	panel_dbi_command(priv->dbi, 0xe8, 0x00);			/* brt_rev */
+	panel_dbi_command(priv->dbi, 0xe9, 0x00);			/* tefreq */
+
+	panel_dbi_command(priv->dbi, 0xea, 0x01);			/* high speed ram */
+
+	panel_dbi_command(priv->dbi, 0xeb, 0x00, 0x33, 0x0e, 0x15,
+			  0xb7, 0x78, 0x88, 0x0f);		/* gamma setting r pos */
+	panel_dbi_command(priv->dbi, 0xec, 0x00, 0x33, 0x0e, 0x15,
+			  0xb7, 0x78, 0x88, 0x0f);		/* gamma setting r neg */
+	panel_dbi_command(priv->dbi, 0xed, 0x00, 0x33, 0x0e, 0x15,
+			  0xb7, 0x78, 0x88, 0x0f);		/* gamma setting g pos */
+	panel_dbi_command(priv->dbi, 0xee, 0x00, 0x33, 0x0e, 0x15,
+			  0xb7, 0x78, 0x88, 0x0f);		/* gamma setting g neg */
+	panel_dbi_command(priv->dbi, 0xef, 0x00, 0x33, 0x0e, 0x15,
+			  0xb7, 0x78, 0x88, 0x0f);		/* gamma setting b pos */
+	panel_dbi_command(priv->dbi, 0xf0, 0x00, 0x33, 0x0e, 0x15,
+			  0xb7, 0x78, 0x88, 0x0f);		/* gamma setting b neg */
+
+	panel_dbi_command(priv->dbi, MIPI_DCS_EXIT_SLEEP_MODE);
+	msleep(110);
+
+	panel_dbi_command(priv->dbi, MIPI_DCS_SET_DISPLAY_ON);
+
+	return 0;
+}
+
+static int hitachi_tx10d07vm0baa_disable(struct drm_panel *panel)
+{
+	struct hitachi_tx10d07vm0baa *priv = to_hitachi_tx10d07vm0baa(panel);
+
+	panel_dbi_command(priv->dbi, MIPI_DCS_SET_DISPLAY_OFF);
+	msleep(35);
+
+	panel_dbi_command(priv->dbi, MIPI_DCS_ENTER_SLEEP_MODE);
+	msleep(50);
+
+	return 0;
+}
+
+static int hitachi_tx10d07vm0baa_unprepare(struct drm_panel *panel)
+{
+	struct hitachi_tx10d07vm0baa *priv = to_hitachi_tx10d07vm0baa(panel);
+
+	gpiod_set_value_cansleep(priv->reset_gpio, 1);
+	regulator_bulk_disable(ARRAY_SIZE(hitachi_tx10d07vm0baa_supplies), priv->supplies);
+
+	msleep(50);
+
+	return 0;
+}
+
+static const struct drm_display_mode hitachi_tx10d07vm0baa_mode = {
+	.clock = (480 + 10 + 10 + 10) * (800 + 4 + 4 + 4) * 60 / 1000,
+	.hdisplay = 480,
+	.hsync_start = 480 + 10,
+	.hsync_end = 480 + 10 + 10,
+	.htotal = 480 + 10 + 10 + 10,
+	.vdisplay = 800,
+	.vsync_start = 800 + 4,
+	.vsync_end = 800 + 4 + 4,
+	.vtotal = 800 + 4 + 4 + 4,
+	.width_mm = 52,
+	.height_mm = 86,
+	.type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
+};
+
+static int hitachi_tx10d07vm0baa_get_modes(struct drm_panel *panel,
+					   struct drm_connector *connector)
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
+	return drm_connector_helper_get_modes_fixed(connector, &hitachi_tx10d07vm0baa_mode);
+}
+
+static const struct drm_panel_funcs hitachi_tx10d07vm0baa_panel_funcs = {
+	.prepare = hitachi_tx10d07vm0baa_prepare,
+	.enable = hitachi_tx10d07vm0baa_enable,
+	.disable = hitachi_tx10d07vm0baa_disable,
+	.unprepare = hitachi_tx10d07vm0baa_unprepare,
+	.get_modes = hitachi_tx10d07vm0baa_get_modes,
+};
+
+static int hitachi_tx10d07vm0baa_probe(struct mipi_dbi_device *dbi)
+{
+	struct hitachi_tx10d07vm0baa *priv;
+	struct device *dev = &dbi->dev;
+	int ret;
+
+	priv = devm_drm_panel_alloc(dev, struct hitachi_tx10d07vm0baa, panel,
+				    &hitachi_tx10d07vm0baa_panel_funcs, DRM_MODE_CONNECTOR_DPI);
+	if (IS_ERR(priv))
+		return PTR_ERR(priv);
+
+	ret = devm_regulator_bulk_get_const(dev, ARRAY_SIZE(hitachi_tx10d07vm0baa_supplies),
+					    hitachi_tx10d07vm0baa_supplies, &priv->supplies);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to get supplies\n");
+
+	priv->reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(priv->reset_gpio))
+		return dev_err_probe(dev, PTR_ERR(priv->reset_gpio),
+				     "Failed to get reset gpio\n");
+
+	priv->dbi = dbi;
+	mipi_dbi_set_drvdata(dbi, priv);
+
+	ret = drm_panel_of_backlight(&priv->panel);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to get backlight\n");
+
+	ret = devm_drm_panel_add(dev, &priv->panel);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to add panel\n");
+
+	return devm_mipi_dbi_attach(dev, dbi);
+}
+
+static const struct of_device_id hitachi_tx10d07vm0baa_of_match[] = {
+	{ .compatible = "hit,tx10d07vm0baa" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, hitachi_tx10d07vm0baa_of_match);
+
+static struct mipi_dbi_driver hitachi_tx10d07vm0baa_driver = {
+	.driver = {
+		.name = "panel-hitachi-tx10d07vm0baa",
+		.of_match_table = hitachi_tx10d07vm0baa_of_match,
+	},
+	.probe = hitachi_tx10d07vm0baa_probe,
+};
+module_mipi_dbi_driver(hitachi_tx10d07vm0baa_driver);
+
+MODULE_AUTHOR("Svyatoslav Ryhel <clamor95@gmail.com>");
+MODULE_DESCRIPTION("HITACHI TX10D07VM0BAA MIPI DBI Type B panel driver");
+MODULE_LICENSE("GPL");
-- 
2.53.0

