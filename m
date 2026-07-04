Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6342C43458
	for <dri-devel@archiver.kernel.org>; Sat,  4 Jul 2026 08:24:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B8BB10E67B;
	Sat,  4 Jul 2026 08:24:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=pm.me header.i=@pm.me header.b="f9Ol8rJO";
	dkim-atps=neutral
Received: from mail-10631.protonmail.ch (mail-10631.protonmail.ch
 [79.135.106.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C63910E69B
 for <dri-devel@lists.freedesktop.org>; Sat,  4 Jul 2026 08:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
 s=protonmail3; t=1783153465; x=1783412665;
 bh=FE56xZC+oidqRx6Q0b0Qrj61IlYg68jQ4tpKfHW0AIE=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=f9Ol8rJO+/+On/0LIkQYJOzfLnHFMJYKBEsW5pqe+b+yMS9ku7w+/uQlTkvX/4VsP
 0PoQ/DC7jaPXnfZWj2E9haP9TyXCj6R1Vy1Qh7ehi5cxTa/RzaUj8qEn2qDIBgC2A8
 w9H4zfP0wWwURCqdqtmGAr6P0TwA0bgqGM8t22iyhlO6Ui5S1qIT1W6PIscLQQp7sR
 vlE7z3aV6y+CtpfUuCNofVVC4v4uPYPAu7CvoLgyTZXPOR7fDzIvhCmLt8bDodcFRr
 JjKTs1exXoXd8xIarU9xdVAyN9/RMUHttVnUULIsyQnrDMLWfk+xrjjzEKTv+0JUwR
 Sgew7ZpZyjHAA==
Date: Sat, 04 Jul 2026 08:24:19 +0000
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
Subject: [PATCH v3 2/2] drm/panel: Add driver for Raydium RM69220 DDIC
Message-ID: <20260704-asteroids-panel-support-v3-2-38dc92570579@pm.me>
In-Reply-To: <20260704-asteroids-panel-support-v3-0-38dc92570579@pm.me>
References: <20260704-asteroids-panel-support-v3-0-38dc92570579@pm.me>
Feedback-ID: 37836894:user:proton
X-Pm-Message-ID: 29ef8378ecccf889140b7382c203cb2e8a1c0610
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

Add a panel driver for Raydium RM69220 DDIC based displays such as the
BOE BF068MWM-TD0 found in the Nothing Phone (3a).

Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
---
 MAINTAINERS                                   |   1 +
 drivers/gpu/drm/panel/Kconfig                 |  15 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 drivers/gpu/drm/panel/panel-raydium-rm69220.c | 417 ++++++++++++++++++++++=
++++
 4 files changed, 434 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index eb70658e081e..dd68e2eb35a9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8378,6 +8378,7 @@ DRM DRIVER FOR RAYDIUM RM69220 PANELS
 M:=09Alexander Koskovich <akoskovich@pm.me>
 S:=09Maintained
 F:=09Documentation/devicetree/bindings/display/panel/raydium,rm69220.yaml
+F:=09drivers/gpu/drm/panel/panel-raydium-rm69220.c
=20
 DRM DRIVER FOR SAMSUNG DB7430 PANELS
 M:=09Linus Walleij <linusw@kernel.org>
diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index c0cc2bb4a3eb..4bc67c508fa6 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -799,6 +799,21 @@ config DRM_PANEL_RAYDIUM_RM692E5
 =09  Say Y here if you want to enable support for Raydium RM692E5-based
 =09  display panels, such as the one found in the Fairphone 5 smartphone.
=20
+config DRM_PANEL_RAYDIUM_RM69220
+=09tristate "Raydium RM69220-based DSI panel"
+=09depends on OF
+=09depends on DRM_MIPI_DSI
+=09depends on BACKLIGHT_CLASS_DEVICE
+=09select DRM_DISPLAY_DSC_HELPER
+=09select DRM_DISPLAY_HELPER
+=09help
+=09  Say Y here if you want to enable support for Raydium RM69220-based
+=09  display panels, such as the BOE BF068MWM-TD0 which can be found in
+=09  the Nothing Phone (3a).
+
+=09  To compile this driver as a module, choose M here: the module
+=09  will be called panel-raydium-rm69220.
+
 config DRM_PANEL_RAYDIUM_RM69380
 =09tristate "Raydium RM69380-based DSI panel"
 =09depends on GPIOLIB
diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefil=
e
index 6926ef28ab8d..93774d9bb5e4 100644
--- a/drivers/gpu/drm/panel/Makefile
+++ b/drivers/gpu/drm/panel/Makefile
@@ -79,6 +79,7 @@ obj-$(CONFIG_DRM_PANEL_RAYDIUM_RM67191) +=3D panel-raydiu=
m-rm67191.o
 obj-$(CONFIG_DRM_PANEL_RAYDIUM_RM67200) +=3D panel-raydium-rm67200.o
 obj-$(CONFIG_DRM_PANEL_RAYDIUM_RM68200) +=3D panel-raydium-rm68200.o
 obj-$(CONFIG_DRM_PANEL_RAYDIUM_RM692E5) +=3D panel-raydium-rm692e5.o
+obj-$(CONFIG_DRM_PANEL_RAYDIUM_RM69220) +=3D panel-raydium-rm69220.o
 obj-$(CONFIG_DRM_PANEL_RAYDIUM_RM69380) +=3D panel-raydium-rm69380.o
 obj-$(CONFIG_DRM_PANEL_RENESAS_R61307) +=3D panel-renesas-r61307.o
 obj-$(CONFIG_DRM_PANEL_RENESAS_R69328) +=3D panel-renesas-r69328.o
diff --git a/drivers/gpu/drm/panel/panel-raydium-rm69220.c b/drivers/gpu/dr=
m/panel/panel-raydium-rm69220.c
new file mode 100644
index 000000000000..4fa3036c4b5f
--- /dev/null
+++ b/drivers/gpu/drm/panel/panel-raydium-rm69220.c
@@ -0,0 +1,417 @@
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
+struct raydium_rm69220 {
+=09struct drm_panel panel;
+=09struct mipi_dsi_device *dsi;
+=09struct drm_dsc_config dsc;
+=09struct regulator_bulk_data *supplies;
+=09struct gpio_desc *reset_gpio;
+};
+
+static const struct regulator_bulk_data raydium_rm69220_supplies[] =3D {
+=09{ .supply =3D "vddio" },
+=09{ .supply =3D "dvdd" },
+=09{ .supply =3D "vci" },
+};
+
+static inline
+struct raydium_rm69220 *to_raydium_rm69220(struct drm_panel *panel)
+{
+=09return container_of(panel, struct raydium_rm69220, panel);
+}
+
+static void raydium_rm69220_reset(struct raydium_rm69220 *ctx)
+{
+=09gpiod_set_value_cansleep(ctx->reset_gpio, 0);
+=09usleep_range(1000, 2000);
+=09gpiod_set_value_cansleep(ctx->reset_gpio, 1);
+=09usleep_range(1000, 2000);
+=09gpiod_set_value_cansleep(ctx->reset_gpio, 0);
+=09msleep(32);
+}
+
+static int raydium_rm69220_on(struct raydium_rm69220 *ctx)
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
+static int raydium_rm69220_off(struct raydium_rm69220 *ctx)
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
+static int raydium_rm69220_prepare(struct drm_panel *panel)
+{
+=09struct raydium_rm69220 *ctx =3D to_raydium_rm69220(panel);
+=09struct device *dev =3D &ctx->dsi->dev;
+=09struct drm_dsc_picture_parameter_set pps;
+=09int ret;
+
+=09ret =3D regulator_bulk_enable(ARRAY_SIZE(raydium_rm69220_supplies), ctx=
->supplies);
+=09if (ret < 0) {
+=09=09dev_err(dev, "Failed to enable regulators: %d\n", ret);
+=09=09return ret;
+=09}
+
+=09raydium_rm69220_reset(ctx);
+
+=09ret =3D raydium_rm69220_on(ctx);
+=09if (ret < 0) {
+=09=09dev_err(dev, "Failed to initialize panel: %d\n", ret);
+=09=09goto err;
+=09}
+
+=09drm_dsc_pps_payload_pack(&pps, &ctx->dsc);
+
+=09ret =3D mipi_dsi_picture_parameter_set(ctx->dsi, &pps);
+=09if (ret < 0) {
+=09=09dev_err(dev, "failed to transmit PPS: %d\n", ret);
+=09=09goto err;
+=09}
+
+=09ret =3D mipi_dsi_compression_mode(ctx->dsi, true);
+=09if (ret < 0) {
+=09=09dev_err(dev, "failed to enable compression mode: %d\n", ret);
+=09=09goto err;
+=09}
+
+=09msleep(28);
+
+=09return 0;
+
+err:
+=09gpiod_set_value_cansleep(ctx->reset_gpio, 1);
+=09regulator_bulk_disable(ARRAY_SIZE(raydium_rm69220_supplies), ctx->suppl=
ies);
+=09return ret;
+}
+
+static int raydium_rm69220_unprepare(struct drm_panel *panel)
+{
+=09struct raydium_rm69220 *ctx =3D to_raydium_rm69220(panel);
+=09struct device *dev =3D &ctx->dsi->dev;
+=09int ret;
+
+=09ret =3D raydium_rm69220_off(ctx);
+=09if (ret < 0)
+=09=09dev_err(dev, "Failed to un-initialize panel: %d\n", ret);
+
+=09gpiod_set_value_cansleep(ctx->reset_gpio, 1);
+=09regulator_bulk_disable(ARRAY_SIZE(raydium_rm69220_supplies), ctx->suppl=
ies);
+
+=09return 0;
+}
+
+static const struct drm_display_mode raydium_rm69220_mode =3D {
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
+static int raydium_rm69220_get_modes(struct drm_panel *panel,
+=09=09=09=09=09    struct drm_connector *connector)
+{
+=09return drm_connector_helper_get_modes_fixed(connector, &raydium_rm69220=
_mode);
+}
+
+static const struct drm_panel_funcs raydium_rm69220_panel_funcs =3D {
+=09.prepare =3D raydium_rm69220_prepare,
+=09.unprepare =3D raydium_rm69220_unprepare,
+=09.get_modes =3D raydium_rm69220_get_modes,
+};
+
+static int raydium_rm69220_bl_update_status(struct backlight_device *bl)
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
+static const struct backlight_ops raydium_rm69220_bl_ops =3D {
+=09.update_status =3D raydium_rm69220_bl_update_status,
+};
+
+static struct backlight_device *
+raydium_rm69220_create_backlight(struct mipi_dsi_device *dsi)
+{
+=09struct device *dev =3D &dsi->dev;
+=09const struct backlight_properties props =3D {
+=09=09.type =3D BACKLIGHT_RAW,
+=09=09.brightness =3D 2946,
+=09=09.max_brightness =3D 3442, /* 4095 is HBM max */
+=09};
+
+=09return devm_backlight_device_register(dev, dev_name(dev), dev, dsi,
+=09=09=09=09=09      &raydium_rm69220_bl_ops, &props);
+}
+
+static int raydium_rm69220_probe(struct mipi_dsi_device *dsi)
+{
+=09struct device *dev =3D &dsi->dev;
+=09struct raydium_rm69220 *ctx;
+=09int ret;
+
+=09ctx =3D devm_drm_panel_alloc(dev, struct raydium_rm69220, panel,
+=09=09=09=09   &raydium_rm69220_panel_funcs,
+=09=09=09=09   DRM_MODE_CONNECTOR_DSI);
+=09if (IS_ERR(ctx))
+=09=09return PTR_ERR(ctx);
+
+=09ret =3D devm_regulator_bulk_get_const(dev,
+=09=09=09=09=09    ARRAY_SIZE(raydium_rm69220_supplies),
+=09=09=09=09=09    raydium_rm69220_supplies,
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
+
+=09dsi->lanes =3D 4;
+=09dsi->format =3D MIPI_DSI_FMT_RGB101010;
+=09dsi->mode_flags =3D MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_NO_EOT_PACKET |
+=09=09=09  MIPI_DSI_CLOCK_NON_CONTINUOUS | MIPI_DSI_MODE_LPM |
+=09=09=09  MIPI_DSI_MODE_DSC_ALL_SLICES_IN_PKT;
+
+=09ctx->panel.prepare_prev_first =3D true;
+
+=09ctx->panel.backlight =3D raydium_rm69220_create_backlight(dsi);
+=09if (IS_ERR(ctx->panel.backlight))
+=09=09return dev_err_probe(dev, PTR_ERR(ctx->panel.backlight),
+=09=09=09=09     "Failed to create backlight\n");
+
+=09ret =3D devm_drm_panel_add(dev, &ctx->panel);
+=09if (ret < 0)
+=09=09return ret;
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
+=09return devm_mipi_dsi_attach(dev, dsi);
+}
+
+static const struct of_device_id raydium_rm69220_of_match[] =3D {
+=09{ .compatible =3D "boe,bf068mwm-td0" },
+=09{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, raydium_rm69220_of_match);
+
+static struct mipi_dsi_driver raydium_rm69220_driver =3D {
+=09.probe =3D raydium_rm69220_probe,
+=09.driver =3D {
+=09=09.name =3D "panel-raydium-rm69220",
+=09=09.of_match_table =3D raydium_rm69220_of_match,
+=09},
+};
+module_mipi_dsi_driver(raydium_rm69220_driver);
+
+MODULE_AUTHOR("Alexander Koskovich <akoskovich@pm.me>");
+MODULE_DESCRIPTION("DRM driver for RM69220-equipped DSI panels");
+MODULE_LICENSE("GPL");

--=20
2.53.0


