Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E821FCD6E55
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 13:03:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BC4B10FDB1;
	Wed,  3 Jun 2026 13:03:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=pm.me header.i=@pm.me header.b="ruL4BZgN";
	dkim-atps=neutral
Received: from mail-106118.protonmail.ch (mail-106118.protonmail.ch
 [79.135.106.118])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F19710FDAE
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 13:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
 s=protonmail3; t=1780491809; x=1780751009;
 bh=MZ8Z/A4WZ/tX++iZJVysuny8VUtR9ZvD02LVT4P3Kss=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=ruL4BZgN3a4gxocJdM0PlV0jp+VXtY/oArRIhingD+63q6NJPbWjubJMx10XGAs/V
 iXKvhoEdqHgO4uWYZ9hraRTofOZVR8/8EbXGgL2WfUrU67UfqcT3ki3A4mYwh9rXnt
 WZsjFBVojd+9WHFyTCrT4vSFaGxUiNW+CHCUAfX19IzXBRtyg5ueUrzeH0DKLrBcPM
 E7YMIWulbwm74BlNeK7s8g0ABa8w5ersUSssfN+KfJ4rvU2G3f66Ob9IhgeX3X0wp8
 BpfxTch+b5OXhNExIW1cqZhZOnLo0K+qbVlewNR2GIbhbZ/RQTpTuEe6Kr08OVQn89
 g9VXIGohB8l5Q==
Date: Wed, 03 Jun 2026 13:03:22 +0000
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
From: Alexander Koskovich <akoskovich@pm.me>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Alexander Koskovich <akoskovich@pm.me>
Subject: [PATCH 2/2] drm/panel: Add BOE BF068MWM-TD0 panel driver
Message-ID: <20260603-asteroids-panel-support-v1-2-109c6ac81c8f@pm.me>
In-Reply-To: <20260603-asteroids-panel-support-v1-0-109c6ac81c8f@pm.me>
References: <20260603-asteroids-panel-support-v1-0-109c6ac81c8f@pm.me>
Feedback-ID: 37836894:user:proton
X-Pm-Message-ID: b81d5fb2c37f600947fca1456371c1ed0e1959b0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Add the panel driver for BOE BF068MWM-TD0 support found in the Nothing
Phone (3a).

Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
---
 MAINTAINERS                                    |   1 +
 drivers/gpu/drm/panel/Kconfig                  |  11 +
 drivers/gpu/drm/panel/Makefile                 |   1 +
 drivers/gpu/drm/panel/panel-boe-bf068mwm-td0.c | 432 +++++++++++++++++++++=
++++
 4 files changed, 445 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 63d0224bba3b..d7175e630d77 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8004,6 +8004,7 @@ DRM DRIVER FOR BOE BF068MWM-TD0 PANELS
 M:=09Alexander Koskovich <akoskovich@pm.me>
 S:=09Maintained
 F:=09Documentation/devicetree/bindings/display/panel/boe,bf068mwm-td0.yaml
+F:=09drivers/gpu/drm/panel/panel-boe-bf068mwm-td0.c
=20
 DRM DRIVER FOR BOE HIMAX8279D PANELS
 M:=09Jerry Han <hanxu5@huaqin.corp-partner.google.com>
diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index 7450b27622a2..03987190f45c 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -56,6 +56,17 @@ config DRM_PANEL_BOE_BF060Y8M_AJ0
 =09  uses 24 bit RGB per pixel. It provides a MIPI DSI interface to
 =09  the host and backlight is controlled through DSI commands.
=20
+config DRM_PANEL_BOE_BF068MWM_TD0
+=09tristate "BOE BF068MWM-TD0 panel"
+=09depends on OF
+=09depends on DRM_MIPI_DSI
+=09depends on BACKLIGHT_CLASS_DEVICE
+=09help
+=09  Say Y here if you want to enable support for BOE BF068MWM-TD0
+=09  6.77" AMOLED modules. The panel has a 1080x2392 resolution and
+=09  uses 30 bit RGB per pixel. It provides a MIPI DSI interface to
+=09  the host and backlight is controlled through DSI commands.
+
 config DRM_PANEL_BOE_HIMAX8279D
 =09tristate "Boe Himax8279d panel"
 =09depends on OF
diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefil=
e
index c2c5cf817116..2fa1ea3cfe26 100644
--- a/drivers/gpu/drm/panel/Makefile
+++ b/drivers/gpu/drm/panel/Makefile
@@ -4,6 +4,7 @@ obj-$(CONFIG_DRM_PANEL_ARM_VERSATILE) +=3D panel-arm-versat=
ile.o
 obj-$(CONFIG_DRM_PANEL_ASUS_Z00T_TM5P5_NT35596) +=3D panel-asus-z00t-tm5p5=
-n35596.o
 obj-$(CONFIG_DRM_PANEL_AUO_A030JTN01) +=3D panel-auo-a030jtn01.o
 obj-$(CONFIG_DRM_PANEL_BOE_BF060Y8M_AJ0) +=3D panel-boe-bf060y8m-aj0.o
+obj-$(CONFIG_DRM_PANEL_BOE_BF068MWM_TD0) +=3D panel-boe-bf068mwm-td0.o
 obj-$(CONFIG_DRM_PANEL_BOE_HIMAX8279D) +=3D panel-boe-himax8279d.o
 obj-$(CONFIG_DRM_PANEL_BOE_TD4320) +=3D panel-boe-td4320.o
 obj-$(CONFIG_DRM_PANEL_BOE_TH101MB31UIG002_28A) +=3D panel-boe-th101mb31ig=
002-28a.o
diff --git a/drivers/gpu/drm/panel/panel-boe-bf068mwm-td0.c b/drivers/gpu/d=
rm/panel/panel-boe-bf068mwm-td0.c
new file mode 100644
index 000000000000..bbf7aed19616
--- /dev/null
+++ b/drivers/gpu/drm/panel/panel-boe-bf068mwm-td0.c
@@ -0,0 +1,432 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Generated with linux-mdss-dsi-panel-driver-generator from vendor device=
 tree.
+ * Copyright (c) 2026 Alexander Koskovich <akoskovich@pm.me>
+ */
+
+#include <linux/backlight.h>
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/mod_devicetable.h>
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
+struct boe_bf068mwm_td0 {
+=09struct drm_panel panel;
+=09struct mipi_dsi_device *dsi;
+=09struct drm_dsc_config dsc;
+=09struct regulator_bulk_data *supplies;
+=09struct gpio_desc *reset_gpio;
+};
+
+static const struct regulator_bulk_data boe_bf068mwm_td0_supplies[] =3D {
+=09{ .supply =3D "vddio" },
+=09{ .supply =3D "dvdd" },
+=09{ .supply =3D "vci" },
+};
+
+static inline
+struct boe_bf068mwm_td0 *to_boe_bf068mwm_td0(struct drm_panel *panel)
+{
+=09return container_of(panel, struct boe_bf068mwm_td0, panel);
+}
+
+static void boe_bf068mwm_td0_reset(struct boe_bf068mwm_td0 *ctx)
+{
+=09gpiod_set_value_cansleep(ctx->reset_gpio, 0);
+=09usleep_range(1000, 2000);
+=09gpiod_set_value_cansleep(ctx->reset_gpio, 1);
+=09usleep_range(1000, 2000);
+=09gpiod_set_value_cansleep(ctx->reset_gpio, 0);
+=09msleep(32);
+}
+
+static int boe_bf068mwm_td0_on(struct boe_bf068mwm_td0 *ctx)
+{
+=09struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D ctx->dsi };
+
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xfe, 0x76);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x9a, 0x10);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x9b, 0x00);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xfe, 0x77);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x9a, 0x10);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x9b, 0x00);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xfe, 0x78);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x9a, 0x10);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x9b, 0x00);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xfe, 0x79);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x9a, 0xf0);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x9b, 0x00);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xfe, 0x74);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1a, 0xe0);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1b, 0x00);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xfe, 0x40);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xa9, 0x68);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xab, 0x22);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xfe, 0x40);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xc0, 0xa6);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xbf, 0x87);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xfe, 0x82);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x00, 0x90);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xfe, 0xd4);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x61, 0x08);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xa2, 0x04);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xfe, 0x00);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xfa, 0x01);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xfe, 0xd2);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x97, 0x08);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x36, 0x11);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x39, 0xab);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3a, 0x30);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3b, 0x80);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3d, 0x09);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3f, 0x58);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x40, 0x04);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x41, 0x38);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x42, 0x00);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x43, 0x0d);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x44, 0x02);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x45, 0x1c);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x46, 0x02);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x47, 0x1c);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x48, 0x02);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x49, 0x00);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4a, 0x02);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4b, 0x0e);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4d, 0x20);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4e, 0x01);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4f, 0x39);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x50, 0x00);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x51, 0x07);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x53, 0x0c);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x54, 0x08);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x55, 0x00);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x56, 0x07);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x58, 0xd3);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x59, 0x18);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5a, 0x00);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5b, 0x10);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5c, 0xf0);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5d, 0x07);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5e, 0x10);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5f, 0x20);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x60, 0x00);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x61, 0x06);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x62, 0x0f);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x63, 0x0f);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x64, 0x33);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x65, 0x0e);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x66, 0x1c);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x67, 0x2a);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x68, 0x38);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x69, 0x46);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6a, 0x54);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6b, 0x62);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6c, 0x69);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6d, 0x70);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6e, 0x77);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6f, 0x79);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x70, 0x7b);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x71, 0x7d);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x72, 0x7e);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x73, 0x01);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x74, 0x02);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x75, 0x22);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x76, 0x00);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x77, 0x2a);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x78, 0x40);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x79, 0x2a);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7a, 0xbe);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7b, 0x3a);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7c, 0xfc);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7d, 0x3a);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7e, 0xfa);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7f, 0x3a);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x80, 0xf8);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x81, 0x3b);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x82, 0x38);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x83, 0x3b);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x84, 0x78);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x85, 0x3b);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x86, 0xb6);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x87, 0x4b);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x88, 0xf6);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x89, 0x4c);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x8a, 0x34);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x8b, 0x4c);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x8c, 0x74);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x8d, 0x5c);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x8e, 0x74);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x8f, 0x8c);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x90, 0xf4);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x91, 0x00);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x92, 0x00);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x93, 0x00);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x94, 0x00);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x95, 0x00);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x96, 0x00);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xfe, 0xa0);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x66, 0x06);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xfe, 0x49);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x87, 0x00);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3f, 0x00);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xfe, 0xa0);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x04, 0x07);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4b, 0x40);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4d, 0x40);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xfe, 0xa1);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x58, 0x67);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x75, 0xa7);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xfe, 0x00);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2f, 0x00);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xfe, 0x00);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xfa, 0x01);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xc1, 0x03);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xc2, 0x03);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x35, 0x00);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x51, 0x0d, 0xbb);
+=09mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xfe, 0x00);
+=09mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
+=09mipi_dsi_msleep(&dsi_ctx, 80);
+=09mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
+=09mipi_dsi_usleep_range(&dsi_ctx, 10000, 11000);
+
+=09return dsi_ctx.accum_err;
+}
+
+static int boe_bf068mwm_td0_off(struct boe_bf068mwm_td0 *ctx)
+{
+=09struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D ctx->dsi };
+
+=09mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
+=09mipi_dsi_msleep(&dsi_ctx, 100);
+=09mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
+=09mipi_dsi_msleep(&dsi_ctx, 100);
+
+=09return dsi_ctx.accum_err;
+}
+
+static int boe_bf068mwm_td0_prepare(struct drm_panel *panel)
+{
+=09struct boe_bf068mwm_td0 *ctx =3D to_boe_bf068mwm_td0(panel);
+=09struct device *dev =3D &ctx->dsi->dev;
+=09struct drm_dsc_picture_parameter_set pps;
+=09int ret;
+
+=09ret =3D regulator_bulk_enable(ARRAY_SIZE(boe_bf068mwm_td0_supplies), ct=
x->supplies);
+=09if (ret < 0) {
+=09=09dev_err(dev, "Failed to enable regulators: %d\n", ret);
+=09=09return ret;
+=09}
+
+=09boe_bf068mwm_td0_reset(ctx);
+
+=09ret =3D boe_bf068mwm_td0_on(ctx);
+=09if (ret < 0) {
+=09=09dev_err(dev, "Failed to initialize panel: %d\n", ret);
+=09=09gpiod_set_value_cansleep(ctx->reset_gpio, 1);
+=09=09regulator_bulk_disable(ARRAY_SIZE(boe_bf068mwm_td0_supplies), ctx->s=
upplies);
+=09=09return ret;
+=09}
+
+=09drm_dsc_pps_payload_pack(&pps, &ctx->dsc);
+
+=09ret =3D mipi_dsi_picture_parameter_set(ctx->dsi, &pps);
+=09if (ret < 0) {
+=09=09dev_err(panel->dev, "failed to transmit PPS: %d\n", ret);
+=09=09return ret;
+=09}
+
+=09ret =3D mipi_dsi_compression_mode(ctx->dsi, true);
+=09if (ret < 0) {
+=09=09dev_err(dev, "failed to enable compression mode: %d\n", ret);
+=09=09return ret;
+=09}
+
+=09msleep(28);
+
+=09return 0;
+}
+
+static int boe_bf068mwm_td0_unprepare(struct drm_panel *panel)
+{
+=09struct boe_bf068mwm_td0 *ctx =3D to_boe_bf068mwm_td0(panel);
+=09struct device *dev =3D &ctx->dsi->dev;
+=09int ret;
+
+=09ret =3D boe_bf068mwm_td0_off(ctx);
+=09if (ret < 0)
+=09=09dev_err(dev, "Failed to un-initialize panel: %d\n", ret);
+
+=09gpiod_set_value_cansleep(ctx->reset_gpio, 1);
+=09regulator_bulk_disable(ARRAY_SIZE(boe_bf068mwm_td0_supplies), ctx->supp=
lies);
+
+=09return 0;
+}
+
+static const struct drm_display_mode boe_bf068mwm_td0_mode =3D {
+=09.clock =3D (1080 + 36 + 4 + 36) * (2392 + 72 + 4 + 52) * 120 / 1000,
+=09.hdisplay =3D 1080,
+=09.hsync_start =3D 1080 + 36,
+=09.hsync_end =3D 1080 + 36 + 4,
+=09.htotal =3D 1080 + 36 + 4 + 36,
+=09.vdisplay =3D 2392,
+=09.vsync_start =3D 2392 + 72,
+=09.vsync_end =3D 2392 + 72 + 4,
+=09.vtotal =3D 2392 + 72 + 4 + 52,
+=09.width_mm =3D 71,
+=09.height_mm =3D 157,
+=09.type =3D DRM_MODE_TYPE_DRIVER,
+};
+
+static int boe_bf068mwm_td0_get_modes(struct drm_panel *panel,
+=09=09=09=09=09    struct drm_connector *connector)
+{
+=09return drm_connector_helper_get_modes_fixed(connector, &boe_bf068mwm_td=
0_mode);
+}
+
+static const struct drm_panel_funcs boe_bf068mwm_td0_panel_funcs =3D {
+=09.prepare =3D boe_bf068mwm_td0_prepare,
+=09.unprepare =3D boe_bf068mwm_td0_unprepare,
+=09.get_modes =3D boe_bf068mwm_td0_get_modes,
+};
+
+static int boe_bf068mwm_td0_bl_update_status(struct backlight_device *bl)
+{
+=09struct mipi_dsi_device *dsi =3D bl_get_data(bl);
+=09u16 brightness =3D backlight_get_brightness(bl);
+=09int ret;
+
+=09dsi->mode_flags &=3D ~MIPI_DSI_MODE_LPM;
+
+=09ret =3D mipi_dsi_dcs_set_display_brightness_large(dsi, brightness);
+=09if (ret < 0)
+=09=09return ret;
+
+=09dsi->mode_flags |=3D MIPI_DSI_MODE_LPM;
+
+=09return 0;
+}
+
+static const struct backlight_ops boe_bf068mwm_td0_bl_ops =3D {
+=09.update_status =3D boe_bf068mwm_td0_bl_update_status,
+};
+
+static struct backlight_device *
+boe_bf068mwm_td0_create_backlight(struct mipi_dsi_device *dsi)
+{
+=09struct device *dev =3D &dsi->dev;
+=09const struct backlight_properties props =3D {
+=09=09.type =3D BACKLIGHT_RAW,
+=09=09.brightness =3D 2946,
+=09=09.max_brightness =3D 3442, /* 4095 is HBM max */
+=09};
+
+=09return devm_backlight_device_register(dev, dev_name(dev), dev, dsi,
+=09=09=09=09=09      &boe_bf068mwm_td0_bl_ops, &props);
+}
+
+static int boe_bf068mwm_td0_probe(struct mipi_dsi_device *dsi)
+{
+=09struct device *dev =3D &dsi->dev;
+=09struct boe_bf068mwm_td0 *ctx;
+=09int ret;
+
+=09ctx =3D devm_drm_panel_alloc(dev, struct boe_bf068mwm_td0, panel,
+=09=09=09=09   &boe_bf068mwm_td0_panel_funcs,
+=09=09=09=09   DRM_MODE_CONNECTOR_DSI);
+=09if (IS_ERR(ctx))
+=09=09return PTR_ERR(ctx);
+
+=09ret =3D devm_regulator_bulk_get_const(dev,
+=09=09=09=09=09    ARRAY_SIZE(boe_bf068mwm_td0_supplies),
+=09=09=09=09=09    boe_bf068mwm_td0_supplies,
+=09=09=09=09=09    &ctx->supplies);
+=09if (ret < 0)
+=09=09return ret;
+
+=09ctx->reset_gpio =3D devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
+=09if (IS_ERR(ctx->reset_gpio))
+=09=09return dev_err_probe(dev, PTR_ERR(ctx->reset_gpio),
+=09=09=09=09     "Failed to get reset-gpios\n");
+
+=09ctx->dsi =3D dsi;
+=09mipi_dsi_set_drvdata(dsi, ctx);
+
+=09dsi->lanes =3D 4;
+=09dsi->format =3D MIPI_DSI_FMT_RGB101010;
+=09dsi->mode_flags =3D MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_NO_EOT_PACKET |
+=09=09=09  MIPI_DSI_CLOCK_NON_CONTINUOUS | MIPI_DSI_MODE_LPM |
+=09=09=09  MIPI_DSI_MODE_DSC_ALL_SLICES_IN_PKT;
+
+=09ctx->panel.prepare_prev_first =3D true;
+
+=09ctx->panel.backlight =3D boe_bf068mwm_td0_create_backlight(dsi);
+=09if (IS_ERR(ctx->panel.backlight))
+=09=09return dev_err_probe(dev, PTR_ERR(ctx->panel.backlight),
+=09=09=09=09     "Failed to create backlight\n");
+
+=09drm_panel_add(&ctx->panel);
+
+=09/* This panel only supports DSC; unconditionally enable it */
+=09dsi->dsc =3D &ctx->dsc;
+
+=09ctx->dsc.dsc_version_major =3D 1;
+=09ctx->dsc.dsc_version_minor =3D 1;
+=09ctx->dsc.slice_height =3D 13;
+=09ctx->dsc.slice_width =3D 540;
+
+=09ctx->dsc.slice_count =3D 1080 / ctx->dsc.slice_width;
+=09ctx->dsc.bits_per_component =3D 10;
+=09ctx->dsc.bits_per_pixel =3D 8 << 4; /* 4 fractional bits */
+=09ctx->dsc.block_pred_enable =3D true;
+
+=09ret =3D mipi_dsi_attach(dsi);
+=09if (ret < 0) {
+=09=09drm_panel_remove(&ctx->panel);
+=09=09return dev_err_probe(dev, ret, "Failed to attach to DSI host\n");
+=09}
+
+=09return 0;
+}
+
+static void boe_bf068mwm_td0_remove(struct mipi_dsi_device *dsi)
+{
+=09struct boe_bf068mwm_td0 *ctx =3D mipi_dsi_get_drvdata(dsi);
+=09int ret;
+
+=09ret =3D mipi_dsi_detach(dsi);
+=09if (ret < 0)
+=09=09dev_err(&dsi->dev, "Failed to detach from DSI host: %d\n", ret);
+
+=09drm_panel_remove(&ctx->panel);
+}
+
+static const struct of_device_id boe_bf068mwm_td0_of_match[] =3D {
+=09{ .compatible =3D "boe,bf068mwm-td0" },
+=09{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, boe_bf068mwm_td0_of_match);
+
+static struct mipi_dsi_driver boe_bf068mwm_td0_driver =3D {
+=09.probe =3D boe_bf068mwm_td0_probe,
+=09.remove =3D boe_bf068mwm_td0_remove,
+=09.driver =3D {
+=09=09.name =3D "panel-bf068mwm-td0",
+=09=09.of_match_table =3D boe_bf068mwm_td0_of_match,
+=09},
+};
+module_mipi_dsi_driver(boe_bf068mwm_td0_driver);
+
+MODULE_AUTHOR("Alexander Koskovich <akoskovich@pm.me>");
+MODULE_DESCRIPTION("BOE BF068MWM-TD0 MIPI-DSI OLED panel");
+MODULE_LICENSE("GPL");

--=20
2.53.0


