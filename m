Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BE29CD13DA
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 07:12:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9D1910E96D;
	Tue,  5 May 2026 07:12:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mV6jLkw3";
	dkim-atps=neutral
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com
 [209.85.215.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FAFC10E0B1
 for <dri-devel@lists.freedesktop.org>; Mon,  4 May 2026 02:14:23 +0000 (UTC)
Received: by mail-pg1-f178.google.com with SMTP id
 41be03b00d2f7-c802196bd32so30275a12.1
 for <dri-devel@lists.freedesktop.org>; Sun, 03 May 2026 19:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777860862; x=1778465662; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OSw7bxIHIV1P5OerjJyAkdF5p1j1kfhvLlHpMyBu4HE=;
 b=mV6jLkw3D8kC0I3dBi7+RopKCvsa+Q7SLPFWLN9+zCA99JHs+gLTGAqgJZQLhIfLCW
 ruYnHs95Ny/bjHFLc0kLaXbUoYC3oHEYAN6L0D9A1q5+Q3jHZBRG6+JWa9HpEatxBS5y
 IksUGhv/FJfwneJRbpa+Yes3af4roAIJduXxOKmuiBnEWmuSjBDYl3iPvZmbWOGLxSKk
 o6yc91SUYS5eFgPUCS8A4KGxcFKkw9wClU65BDKmq3ORKfBUeDuFR7n8l3CyW03yEALZ
 lIy5Z7zM3w6kSaNmcZrdBDTMibgcYdFqIsNucu3kHexxRyW98nLZAUztQjsLHnqfFm9U
 4FPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777860862; x=1778465662;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OSw7bxIHIV1P5OerjJyAkdF5p1j1kfhvLlHpMyBu4HE=;
 b=QoJWh45Vkf6EGtStIz9CZfl+VewyOfBMTJPEkS4ayWacvWd2c7JPoeAJFA05EAKNjW
 1lptOi+t99Cv3z3INqJC30NJiLnDf1BMsunZDJblBk0BJr24i884AzcneoEZEbL6kPCe
 gHyJwmcAxtoG/0b+eZ+H3TKAZ7mifnfvwX0HIDyQqKPfOkXca4j1ugTjb232aeLvrfjI
 Ni2iIKrd1HMCr0QGc2qLHi8uVTfpTmFSBo6+9ekUnislHgKEB0WukvtKwI7iRBrjkPJY
 1ywTCQ9VN7Y4ZlgVcAZD0uUWlHxOPjy7IwEMJHwXmCF19Kj0XM4U/i3kdtnhH7LK1rRi
 043A==
X-Gm-Message-State: AOJu0YyhOKI4n51Hb7ofpPUMLRlFB7BE4wVvanWy8qDIPWqK8Q5ADXNk
 Hshoq81Ll/g3CKwJjpFLqeFP8NYJo19EseeBOEWFMh8NKddOiVhbyRdD
X-Gm-Gg: AeBDiesdBdK1iML8L9SNynuiEMMXD7KVbhvQSCVCYjBRD+Xghri3ztzTD2fABGpLl+Q
 pIHC1IZlSctX/FZtKmRLu/xvCerP/kDDzYBYvRsDJXMisdvTJRrYTXPQ/VdlstoroJjncHRMIvm
 mmbDSWO4464csUAeOwINqjui+KXuflgLgZgtwVyBaLTWtiZcJsc7SoxBhDPJmT4APfjoLT+9XDG
 PnSOjh1dyl6DjeJdD6uW3Tpg529EH2PYrZR3qyPjGnkDy0sxRtst7VePM0rl9nDiLEYnCMJQQJ1
 vlnmav+HVx3y4ZfzLn7Zgnst+bJ78ev794urQWf4DoDlIwg4wdt7+PiEaPCrQhpjDeNFjVqQiIB
 cjXQsGoU7Y1/vkpfLq5iIdwS1JHZNQCuRWyf4XyZV350qVfxTFNUqt4O+7qUJj5VrzotTfaRsUT
 cTgVfJDsLqBE45sbuXfDPIfTj7Bnj4u73V
X-Received: by 2002:a05:6a00:a803:b0:837:95fc:148d with SMTP id
 d2e1a72fcca58-83795fc19aamr959116b3a.0.1777860862323; 
 Sun, 03 May 2026 19:14:22 -0700 (PDT)
Received: from marchy ([2405:3800:95f:677d:ee8e:77ff:fed4:d18b])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83515b543b0sm9191138b3a.53.2026.05.03.19.14.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 May 2026 19:14:21 -0700 (PDT)
From: Adam Azuddin <azuddinadam@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: devicetree@vger.kernel.org, Adam Azuddin <azuddinadam@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, LiangCheng Wang <zaq14760@gmail.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Marcus Folkesson <marcus.folkesson@gmail.com>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 2/2] drm/tiny: Add RAiO RA8875 display controller driver
Date: Mon,  4 May 2026 10:13:51 +0800
Message-ID: <20260504021355.72128-3-azuddinadam@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504021355.72128-1-azuddinadam@gmail.com>
References: <20260504021355.72128-1-azuddinadam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 05 May 2026 07:12:26 +0000
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

Add a DRM tiny driver for the RAiO RA8875 SPI-connected TFT display
controller. The driver supports display resolutions up to 800x480
and uses the GEM shmem helper for buffer management.

Signed-off-by: Adam Azuddin <azuddinadam@gmail.com>
---
 MAINTAINERS                   |   6 +
 drivers/gpu/drm/tiny/Kconfig  |  14 +
 drivers/gpu/drm/tiny/Makefile |   1 +
 drivers/gpu/drm/tiny/ra8875.c | 681 ++++++++++++++++++++++++++++++++++
 4 files changed, 702 insertions(+)
 create mode 100644 drivers/gpu/drm/tiny/ra8875.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 54b941d6e8b2..962fdbdbccf3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8268,6 +8268,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/display/panel/raydium,rm67191.yaml
 F:	drivers/gpu/drm/panel/panel-raydium-rm67191.c
 
+DRM DRIVER FOR RAIO RA8875 PANELS
+M:	Adam Azuddin <azuddinadam@gmail.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/display/panel/raio,ra8875.yaml
+F:	drivers/gpu/drm/tiny/ra8875.c
+
 DRM DRIVER FOR SAMSUNG DB7430 PANELS
 M:	Linus Walleij <linusw@kernel.org>
 S:	Maintained
diff --git a/drivers/gpu/drm/tiny/Kconfig b/drivers/gpu/drm/tiny/Kconfig
index f0e72d4b6a47..519f0f6e3bb4 100644
--- a/drivers/gpu/drm/tiny/Kconfig
+++ b/drivers/gpu/drm/tiny/Kconfig
@@ -195,6 +195,20 @@ config TINYDRM_REPAPER
 
 	  If M is selected the module will be called repaper.
 
+config TINYDRM_RA8875
+	tristate "DRM support for RA8875 display panels"
+	depends on DRM && SPI
+	select DRM_CLIENT_SELECTION
+	select DRM_KMS_HELPER
+	select DRM_GEM_SHMEM_HELPER
+	select BACKLIGHT_CLASS_DEVICE
+	select VIDEOMODE_HELPERS
+	help
+	  DRM driver for the following RAiO RA8875 based LCD panels:
+	  * East Rising 5.00" TFT LCD (ER-TFTM070-5V4)
+
+	  If M is selected the module will be called ra8875.
+
 config TINYDRM_SHARP_MEMORY
 	tristate "DRM support for Sharp Memory LCD panels"
 	depends on DRM && SPI
diff --git a/drivers/gpu/drm/tiny/Makefile b/drivers/gpu/drm/tiny/Makefile
index 48d30bf6152f..17e5e7766309 100644
--- a/drivers/gpu/drm/tiny/Makefile
+++ b/drivers/gpu/drm/tiny/Makefile
@@ -14,4 +14,5 @@ obj-$(CONFIG_TINYDRM_ILI9341)		+= ili9341.o
 obj-$(CONFIG_TINYDRM_ILI9486)		+= ili9486.o
 obj-$(CONFIG_TINYDRM_MI0283QT)		+= mi0283qt.o
 obj-$(CONFIG_TINYDRM_REPAPER)		+= repaper.o
+obj-$(CONFIG_TINYDRM_RA8875)		+= ra8875.o
 obj-$(CONFIG_TINYDRM_SHARP_MEMORY)	+= sharp-memory.o
diff --git a/drivers/gpu/drm/tiny/ra8875.c b/drivers/gpu/drm/tiny/ra8875.c
new file mode 100644
index 000000000000..632343197250
--- /dev/null
+++ b/drivers/gpu/drm/tiny/ra8875.c
@@ -0,0 +1,681 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * DRM driver for RAiO ra8875 controller
+ *
+ * Copyright 2026 Adam Azuddin <azuddinadam@gmail.com>
+ */
+#include <linux/mod_devicetable.h>
+#include <linux/bits.h>
+#include <linux/array_size.h>
+#include <linux/container_of.h>
+#include <linux/device/devres.h>
+#include <linux/err.h>
+#include <linux/iosys-map.h>
+#include <linux/dev_printk.h>
+#include <linux/regulator/consumer.h>
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/module.h>
+#include <linux/spi/spi.h>
+#include <linux/string.h>
+#include <video/of_display_timing.h>
+#include <video/of_videomode.h>
+#include <video/videomode.h>
+
+#include <drm/drm_gem.h>
+#include <drm/drm_gem_shmem_helper.h>
+#include <drm/drm_connector.h>
+#include <drm/drm_damage_helper.h>
+#include <drm/drm_framebuffer.h>
+#include <drm/drm_device.h>
+#include <drm/drm_mode.h>
+#include <drm/drm_mode_config.h>
+#include <drm/drm_modes.h>
+#include <drm/drm_probe_helper.h>
+#include <drm/drm_rect.h>
+#include <drm/drm_simple_kms_helper.h>
+#include <drm/drm_gem_framebuffer_helper.h>
+#include <drm/clients/drm_client_setup.h>
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_drv.h>
+#include <drm/drm_fbdev_shmem.h>
+#include <drm/drm_gem_atomic_helper.h>
+#include <drm/drm_managed.h>
+
+#define RA8875_MAX_SPI_SPEED 25000000
+#define RA8875_REG_SPI_SPEED 1000000
+
+#define RA8875_DATAWRITE	 0x00
+#define RA8875_CMDWRITE		 0x80
+#define RA8875_PWRR		 0x01
+#define RA8875_PWRR_DISPON	 BIT(7)
+#define RA8875_PWRR_DISPOFF	 0x00
+#define RA8875_MRWC		 0x02
+#define RA8875_PLLC1		 0x88
+#define RA8875_PLLC1_PLLDIVN_11	 0x0B
+#define RA8875_PLLC2		 0x89
+#define RA8875_PLLC2_DIVK_4	 0x02
+#define RA8875_SYSR		 0x10
+#define RA8875_SYSR_16BPP	 0x0C
+#define RA8875_PCSR		 0x04
+#define RA8875_PCSR_PCLK_INV	 BIT(7)
+#define RA8875_PCSR_2CLK	 0x01
+#define RA8875_HDWR		 0x14
+#define RA8875_HNDFTR		 0x15
+#define RA8875_HNDR		 0x16
+#define RA8875_HSTR		 0x17
+#define RA8875_HPWR		 0x18
+#define RA8875_VDHR0		 0x19
+#define RA8875_VDHR1		 0x1A
+#define RA8875_VNDR0		 0x1B
+#define RA8875_VNDR1		 0x1C
+#define RA8875_VSTR0		 0x1D
+#define RA8875_VSTR1		 0x1E
+#define RA8875_VPWR		 0x1F
+#define RA8875_HSAW0		 0x30
+#define RA8875_HSAW1		 0x31
+#define RA8875_VSAW0		 0x32
+#define RA8875_VSAW1		 0x33
+#define RA8875_HEAW0		 0x34
+#define RA8875_HEAW1		 0x35
+#define RA8875_VEAW0		 0x36
+#define RA8875_VEAW1		 0x37
+#define RA8875_MWCR0		 0x40
+#define RA8875_MWCR0_GFXMODE	 0x00
+#define RA8875_MWCR0_LRTD	 0x00
+#define RA8875_CURH0		 0x46
+#define RA8875_CURH1		 0x47
+#define RA8875_CURV0		 0x48
+#define RA8875_CURV1		 0x49
+#define RA8875_P1CR		 0x8A
+#define RA8875_P1CR_ENABLE	 BIT(7)
+#define RA8875_P1CR_DISABLE	 0x00
+#define RA8875_P1CR_SYS_CLK_DIV2 0x01
+#define RA8875_P1DCR		 0x8B
+#define RA8875_P1DCR_HALF	 0x80
+
+DEFINE_DRM_GEM_FOPS(ra8875_fops);
+
+static const struct drm_driver ra8875_driver = {
+	.driver_features = DRIVER_GEM | DRIVER_MODESET | DRIVER_ATOMIC,
+	DRM_GEM_SHMEM_DRIVER_OPS,
+	DRM_FBDEV_SHMEM_DRIVER_OPS,
+	.fops = &ra8875_fops,
+	.name = "ra8875",
+	.desc = "RAiO RA8875",
+	.major = 1,
+	.minor = 0,
+};
+
+struct ra8875_device {
+	struct drm_device drm;
+	struct spi_device *spi;
+	struct gpio_desc *rst_gpio;
+	struct drm_simple_display_pipe pipe;
+	struct drm_connector connector;
+	struct drm_display_mode mode;
+	struct regulator *vcc;
+	void *txbuf;
+};
+
+static const struct drm_mode_config_funcs ra8875_modeconfig_funcs = {
+	.fb_create = drm_gem_fb_create_with_dirty,
+	.atomic_check = drm_atomic_helper_check,
+	.atomic_commit = drm_atomic_helper_commit,
+};
+
+static const struct drm_connector_funcs ra8875_connector_funcs = {
+	.fill_modes = drm_helper_probe_single_connector_modes,
+	.reset = drm_atomic_helper_connector_reset,
+	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
+};
+
+static int ra8875_connector_get_modes(struct drm_connector *connector)
+{
+	struct ra8875_device *ra8875 =
+		container_of(connector, struct ra8875_device, connector);
+	struct drm_display_mode *mode;
+
+	mode = drm_mode_duplicate(connector->dev, &ra8875->mode);
+	if (!mode)
+		return 0;
+
+	mode->type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED;
+	drm_mode_set_name(mode);
+
+	drm_mode_probed_add(connector, mode);
+	return 1;
+}
+
+static const struct drm_connector_helper_funcs ra8875_connector_helper_funcs = {
+	.get_modes = ra8875_connector_get_modes
+};
+
+static const struct of_device_id ra8875_of_match[] = {
+	{ .compatible = "raio,ra8875" },
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, ra8875_of_match);
+
+static const struct spi_device_id ra8875_id[] = { { "ra8875", 0 }, {} };
+
+MODULE_DEVICE_TABLE(spi, ra8875_id);
+
+static int ra8875_write_reg(struct ra8875_device *ra8875, u8 reg, u8 val)
+{
+	u8 cmd[2] = { RA8875_CMDWRITE, reg };
+	u8 data[2] = { RA8875_DATAWRITE, val };
+
+	struct spi_transfer t_cmd = {
+		.tx_buf = cmd,
+		.len = 2,
+		.speed_hz = RA8875_REG_SPI_SPEED,
+	};
+	struct spi_transfer t_data = {
+		.tx_buf = data,
+		.len = 2,
+		.speed_hz = RA8875_REG_SPI_SPEED,
+	};
+	struct spi_message m;
+	int ret;
+
+	spi_message_init(&m);
+	spi_message_add_tail(&t_cmd, &m);
+	spi_message_add_tail(&t_data, &m);
+
+	ret = spi_sync(ra8875->spi, &m);
+	if (ret)
+		dev_err(&ra8875->spi->dev,
+			"write_reg(0x%02x, 0x%02x) failed: %d\n", reg, val,
+			ret);
+	return ret;
+}
+
+static int ra8875_hw_init(struct ra8875_device *ra8875,
+			  struct drm_display_mode *mode)
+{
+	u8 hdwr, hndr, hstr, hpwr, vpwr;
+	u16 vdhr, vndr, vstr;
+	int ret;
+
+	/* Assumes 20MHz crystal. PLL output = 20MHz * (11+1) = 240MHz */
+	ret = ra8875_write_reg(ra8875, RA8875_PLLC1, RA8875_PLLC1_PLLDIVN_11);
+	if (ret)
+		return ret;
+	ret = ra8875_write_reg(ra8875, RA8875_PLLC2, RA8875_PLLC2_DIVK_4);
+	if (ret)
+		return ret;
+
+	usleep_range(200, 500);
+
+	ret = ra8875_write_reg(ra8875, RA8875_PCSR,
+			       RA8875_PCSR_PCLK_INV | RA8875_PCSR_2CLK);
+	if (ret)
+		return ret;
+	ret = ra8875_write_reg(ra8875, RA8875_SYSR, RA8875_SYSR_16BPP);
+	if (ret)
+		return ret;
+
+	usleep_range(1000, 2000);
+
+	/* Graphics mode, left-to-right top-to-down write direction */
+	ret = ra8875_write_reg(ra8875, RA8875_MWCR0,
+			       RA8875_MWCR0_GFXMODE | RA8875_MWCR0_LRTD);
+	if (ret)
+		return ret;
+
+	/* Horizontal timing */
+	hdwr = (mode->hdisplay / 8) - 1;
+	hndr = ((mode->htotal - mode->hdisplay) / 8) - 1;
+	hstr = ((mode->hsync_start - mode->hdisplay) / 8) - 1;
+	hpwr = ((mode->hsync_end - mode->hsync_start) / 8) - 1;
+
+	ret = ra8875_write_reg(ra8875, RA8875_HDWR, hdwr);
+	if (ret)
+		return ret;
+	ret = ra8875_write_reg(ra8875, RA8875_HNDFTR, 0x00);
+	if (ret)
+		return ret;
+	ret = ra8875_write_reg(ra8875, RA8875_HNDR, hndr);
+	if (ret)
+		return ret;
+	ret = ra8875_write_reg(ra8875, RA8875_HSTR, hstr);
+	if (ret)
+		return ret;
+	ret = ra8875_write_reg(ra8875, RA8875_HPWR, hpwr);
+	if (ret)
+		return ret;
+
+	/* Vertical timing */
+	vdhr = mode->vdisplay - 1;
+	vndr = mode->vtotal - mode->vdisplay - 1;
+	vstr = mode->vsync_start - mode->vdisplay - 1;
+	vpwr = mode->vsync_end - mode->vsync_start - 1;
+
+	ret = ra8875_write_reg(ra8875, RA8875_VDHR0, vdhr & 0xFF);
+	if (ret)
+		return ret;
+	ret = ra8875_write_reg(ra8875, RA8875_VDHR1, (vdhr >> 8) & 0x01);
+	if (ret)
+		return ret;
+	ret = ra8875_write_reg(ra8875, RA8875_VNDR0, vndr & 0xFF);
+	if (ret)
+		return ret;
+	ret = ra8875_write_reg(ra8875, RA8875_VNDR1, (vndr >> 8) & 0x01);
+	if (ret)
+		return ret;
+	ret = ra8875_write_reg(ra8875, RA8875_VSTR0, vstr & 0xFF);
+	if (ret)
+		return ret;
+	ret = ra8875_write_reg(ra8875, RA8875_VSTR1, (vstr >> 8) & 0x01);
+	if (ret)
+		return ret;
+	ret = ra8875_write_reg(ra8875, RA8875_VPWR, vpwr);
+	if (ret)
+		return ret;
+
+	ret = ra8875_write_reg(ra8875, RA8875_P1CR,
+			       RA8875_P1CR_ENABLE | RA8875_P1CR_SYS_CLK_DIV2);
+	if (ret)
+		return ret;
+
+	/* 50% duty cycle; full brightness washes out the display */
+	ret = ra8875_write_reg(ra8875, RA8875_P1DCR, RA8875_P1DCR_HALF);
+	if (ret)
+		return ret;
+	usleep_range(10000, 11000);
+
+	/* Display on */
+	ret = ra8875_write_reg(ra8875, RA8875_PWRR, RA8875_PWRR_DISPON);
+	if (ret)
+		return ret;
+	usleep_range(10000, 11000);
+
+	return 0;
+}
+
+static int ra8875_clear_screen(struct ra8875_device *ra8875,
+			       struct drm_display_mode *mode)
+{
+	int width = mode->hdisplay;
+	int height = mode->vdisplay;
+	u8 *txbuf = ra8875->txbuf;
+	u8 cmd[2] = { RA8875_CMDWRITE, RA8875_MRWC };
+	struct spi_transfer t_data = {
+		.tx_buf = txbuf,
+		.len = 1 + width * height * 2,
+		.speed_hz = ra8875->spi->max_speed_hz,
+	};
+	struct spi_message m;
+	int ret;
+
+	/* Set active window to full screen */
+	ret = ra8875_write_reg(ra8875, RA8875_HSAW0, 0);
+	if (ret)
+		return ret;
+	ret = ra8875_write_reg(ra8875, RA8875_HSAW1, 0);
+	if (ret)
+		return ret;
+	ret = ra8875_write_reg(ra8875, RA8875_VSAW0, 0);
+	if (ret)
+		return ret;
+	ret = ra8875_write_reg(ra8875, RA8875_VSAW1, 0);
+	if (ret)
+		return ret;
+	ret = ra8875_write_reg(ra8875, RA8875_HEAW0, (width - 1) & 0xFF);
+	if (ret)
+		return ret;
+	ret = ra8875_write_reg(ra8875, RA8875_HEAW1, ((width - 1) >> 8) & 0x03);
+	if (ret)
+		return ret;
+	ret = ra8875_write_reg(ra8875, RA8875_VEAW0, (height - 1) & 0xFF);
+	if (ret)
+		return ret;
+	ret = ra8875_write_reg(ra8875, RA8875_VEAW1,
+			       ((height - 1) >> 8) & 0x01);
+	if (ret)
+		return ret;
+
+	/* Set cursor to 0,0 */
+	ret = ra8875_write_reg(ra8875, RA8875_CURH0, 0);
+	if (ret)
+		return ret;
+	ret = ra8875_write_reg(ra8875, RA8875_CURH1, 0);
+	if (ret)
+		return ret;
+	ret = ra8875_write_reg(ra8875, RA8875_CURV0, 0);
+	if (ret)
+		return ret;
+	ret = ra8875_write_reg(ra8875, RA8875_CURV1, 0);
+	if (ret)
+		return ret;
+
+	ret = spi_write(ra8875->spi, cmd, 2);
+	if (ret)
+		return ret;
+
+	memset(txbuf, 0, 1 + width * height * 2);
+	txbuf[0] = RA8875_DATAWRITE;
+
+	spi_message_init(&m);
+	spi_message_add_tail(&t_data, &m);
+	return spi_sync(ra8875->spi, &m);
+}
+
+static void ra8875_pipe_enable(struct drm_simple_display_pipe *pipe,
+			       struct drm_crtc_state *crtc_state,
+			       struct drm_plane_state *plane_state)
+{
+	int ret;
+	struct ra8875_device *ra8875 =
+		container_of(pipe->crtc.dev, struct ra8875_device, drm);
+	struct drm_display_mode *mode = &crtc_state->mode;
+
+	ret = ra8875_hw_init(ra8875, mode);
+	if (ret) {
+		dev_err(ra8875->drm.dev, "Failed hw_init: %d\n", ret);
+		return;
+	}
+
+	ret = ra8875_clear_screen(ra8875, mode);
+	if (ret) {
+		dev_err(ra8875->drm.dev, "Failed to clear screen: %d\n", ret);
+		return;
+	}
+}
+
+static void ra8875_pipe_disable(struct drm_simple_display_pipe *pipe)
+{
+	struct ra8875_device *ra8875 =
+		container_of(pipe->crtc.dev, struct ra8875_device, drm);
+
+	if (ra8875_write_reg(ra8875, RA8875_P1CR, RA8875_P1CR_DISABLE))
+		dev_err(ra8875->drm.dev, "Failed to disable P1CR\n");
+	if (ra8875_write_reg(ra8875, RA8875_P1DCR, 0x00))
+		dev_err(ra8875->drm.dev, "Failed to disable P1DCR\n");
+	if (ra8875_write_reg(ra8875, RA8875_PWRR, RA8875_PWRR_DISPOFF))
+		dev_err(ra8875->drm.dev, "Failed to turn off display\n");
+
+	if (ra8875->rst_gpio)
+		gpiod_set_value_cansleep(ra8875->rst_gpio, 0);
+
+	if (ra8875->vcc)
+		regulator_disable(ra8875->vcc);
+}
+
+static void ra8875_pipe_update(struct drm_simple_display_pipe *pipe,
+			       struct drm_plane_state *old_plane_state)
+{
+	struct drm_plane_state *state = pipe->plane.state;
+	struct drm_shadow_plane_state *shadow_plane_state =
+		to_drm_shadow_plane_state(state);
+	struct drm_framebuffer *fb = state->fb;
+	struct drm_atomic_helper_damage_iter iter;
+	struct drm_rect damage;
+	struct iosys_map *map = &shadow_plane_state->data[0];
+	struct spi_transfer t_data;
+	struct spi_message m;
+
+	struct ra8875_device *ra8875 =
+		container_of(pipe->crtc.dev, struct ra8875_device, drm);
+	u16 *src_row;
+	u16 *dst_row;
+	u8 cmd[2] = { RA8875_CMDWRITE, RA8875_MRWC };
+	u8 *txbuf = ra8875->txbuf;
+	unsigned int offset;
+	int width, height, r, p, idx;
+
+	if (!pipe->crtc.state->active)
+		return;
+
+	if (!fb)
+		return;
+
+	if (!drm_dev_enter(&ra8875->drm, &idx))
+		return;
+
+	if (iosys_map_is_null(map)) {
+		dev_err(&ra8875->spi->dev, "Shadow map is null\n");
+		goto exit;
+	}
+
+	drm_atomic_helper_damage_iter_init(&iter, old_plane_state, state);
+	drm_atomic_for_each_plane_damage(&iter, &damage) {
+		width = drm_rect_width(&damage);
+		height = drm_rect_height(&damage);
+
+		if (ra8875_write_reg(ra8875, RA8875_HSAW0, damage.x1 & 0xFF))
+			goto exit;
+		if (ra8875_write_reg(ra8875, RA8875_HSAW1,
+				     (damage.x1 >> 8) & 0x03))
+			goto exit;
+		if (ra8875_write_reg(ra8875, RA8875_VSAW0, damage.y1 & 0xFF))
+			goto exit;
+		if (ra8875_write_reg(ra8875, RA8875_VSAW1,
+				     (damage.y1 >> 8) & 0x01))
+			goto exit;
+		if (ra8875_write_reg(ra8875, RA8875_HEAW0,
+				     (damage.x2 - 1) & 0xFF))
+			goto exit;
+		if (ra8875_write_reg(ra8875, RA8875_HEAW1,
+				     ((damage.x2 - 1) >> 8) & 0x03))
+			goto exit;
+
+		if (ra8875_write_reg(ra8875, RA8875_VEAW0,
+				     (damage.y2 - 1) & 0xFF))
+			goto exit;
+		if (ra8875_write_reg(ra8875, RA8875_VEAW1,
+				     ((damage.y2 - 1) >> 8) & 0x01))
+			goto exit;
+
+		if (ra8875_write_reg(ra8875, RA8875_CURH0, damage.x1 & 0xFF))
+			goto exit;
+		if (ra8875_write_reg(ra8875, RA8875_CURH1,
+				     (damage.x1 >> 8) & 0x03))
+			goto exit;
+		if (ra8875_write_reg(ra8875, RA8875_CURV0, damage.y1 & 0xFF))
+			goto exit;
+		if (ra8875_write_reg(ra8875, RA8875_CURV1,
+				     (damage.y1 >> 8) & 0x01))
+			goto exit;
+
+		/* MRWC command and pixel data are sent as separate SPI messages;
+		 * the RA8875 does not require CS to be held between them.
+		 */
+		if (spi_write(ra8875->spi, cmd, 2))
+			goto exit;
+
+		offset =
+			drm_fb_clip_offset(fb->pitches[0], fb->format, &damage);
+
+		txbuf[0] = RA8875_DATAWRITE;
+		for (r = 0; r < height; r++) {
+			src_row = (u16 *)(map->vaddr + offset +
+					  r * fb->pitches[0]);
+			dst_row = (u16 *)(txbuf + 1 + r * width * 2);
+			for (p = 0; p < width; p++)
+				dst_row[p] = swab16(src_row[p]);
+		}
+
+		memset(&t_data, 0, sizeof(t_data));
+		t_data.tx_buf = txbuf;
+		t_data.len = 1 + height * width * 2;
+		t_data.speed_hz = ra8875->spi->max_speed_hz;
+
+		spi_message_init(&m);
+		spi_message_add_tail(&t_data, &m);
+		if (spi_sync(ra8875->spi, &m))
+			goto exit;
+	}
+exit:
+	drm_dev_exit(idx);
+}
+
+static const u32 ra8875_pipe_formats[] = {
+	DRM_FORMAT_RGB565,
+};
+
+static const struct drm_simple_display_pipe_funcs ra8875_pipe_funcs = {
+	.enable = ra8875_pipe_enable,
+	.disable = ra8875_pipe_disable,
+	.update = ra8875_pipe_update,
+	DRM_GEM_SIMPLE_DISPLAY_PIPE_SHADOW_PLANE_FUNCS,
+};
+
+static int ra8875_probe(struct spi_device *spi)
+{
+	struct device *dev = &spi->dev;
+	struct ra8875_device *ra8875;
+	struct drm_connector *connector;
+	struct drm_device *drm;
+	struct videomode vm;
+	size_t bufsize;
+	int ret;
+
+	ra8875 = devm_drm_dev_alloc(dev, &ra8875_driver, struct ra8875_device,
+				    drm);
+
+	if (IS_ERR(ra8875))
+		return PTR_ERR(ra8875);
+
+	ra8875->vcc = devm_regulator_get_optional(dev, "vcc");
+	if (IS_ERR(ra8875->vcc)) {
+		if (PTR_ERR(ra8875->vcc) != -ENODEV)
+			return dev_err_probe(dev, PTR_ERR(ra8875->vcc),
+					     "Failed to get regulator\n");
+		ra8875->vcc = NULL;
+	}
+
+	if (ra8875->vcc) {
+		ret = regulator_enable(ra8875->vcc);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "Failed to enable regulator\n");
+	}
+
+	ra8875->rst_gpio =
+		devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(ra8875->rst_gpio))
+		return dev_err_probe(dev, PTR_ERR(ra8875->rst_gpio),
+				     "Failed to get reset GPIO\n");
+
+	usleep_range(10000, 20000);
+
+	ra8875->spi = spi;
+
+	spi->mode = SPI_MODE_0;
+	spi->bits_per_word = 8;
+
+	spi->cs_setup.value = 10;
+	spi->cs_setup.unit = SPI_DELAY_UNIT_USECS;
+	spi->cs_inactive.value = 10;
+	spi->cs_inactive.unit = SPI_DELAY_UNIT_USECS;
+	spi->cs_hold.value = 10;
+	spi->cs_hold.unit = SPI_DELAY_UNIT_USECS;
+
+	spi->max_speed_hz = min(spi->max_speed_hz, RA8875_MAX_SPI_SPEED);
+
+	ret = spi_setup(spi);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to setup SPI\n");
+
+	/* Hardware Reset */
+	if (ra8875->rst_gpio) {
+		ret = gpiod_set_value_cansleep(ra8875->rst_gpio, 0);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "Failed to assert reset GPIO\n");
+		usleep_range(10000, 20000);
+		ret = gpiod_set_value_cansleep(ra8875->rst_gpio, 1);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "Failed to deassert reset GPIO\n");
+		usleep_range(100000, 110000);
+	}
+
+	ret = of_get_videomode(dev->of_node, &vm, OF_USE_NATIVE_MODE);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to get videomode\n");
+
+	drm_display_mode_from_videomode(&vm, &ra8875->mode);
+	ra8875->mode.type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED;
+	drm = &ra8875->drm;
+
+	ret = drmm_mode_config_init(drm);
+	if (ret)
+		return ret;
+
+	drm->mode_config.min_width = ra8875->mode.hdisplay;
+	drm->mode_config.max_width = ra8875->mode.hdisplay;
+	drm->mode_config.min_height = ra8875->mode.vdisplay;
+	drm->mode_config.max_height = ra8875->mode.vdisplay;
+
+	drm->mode_config.funcs = &ra8875_modeconfig_funcs;
+
+	bufsize = 1 + (size_t)ra8875->mode.hdisplay * ra8875->mode.vdisplay * 2;
+	ra8875->txbuf = devm_kzalloc(&spi->dev, bufsize, GFP_KERNEL);
+	if (!ra8875->txbuf)
+		return -ENOMEM;
+
+	connector = &ra8875->connector;
+	drm_connector_helper_add(connector, &ra8875_connector_helper_funcs);
+
+	ret = drmm_connector_init(drm, connector, &ra8875_connector_funcs,
+				  DRM_MODE_CONNECTOR_SPI, NULL);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to init connector\n");
+
+	connector->status = connector_status_connected;
+
+	ret = drm_simple_display_pipe_init(drm,
+					   &ra8875->pipe,
+					   &ra8875_pipe_funcs,
+					   ra8875_pipe_formats,
+					   ARRAY_SIZE(ra8875_pipe_formats),
+					   NULL, connector);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to init display pipe\n");
+
+	drm_plane_enable_fb_damage_clips(&ra8875->pipe.plane);
+
+	spi_set_drvdata(spi, drm);
+	drm_mode_config_reset(drm);
+
+	ret = drm_dev_register(drm, 0);
+	if (ret)
+		return ret;
+
+	drm_client_setup(drm, drm_format_info(DRM_FORMAT_RGB565));
+	return 0;
+}
+
+static void ra8875_remove(struct spi_device *spi)
+{
+	struct drm_device *drm = spi_get_drvdata(spi);
+
+	drm_dev_unplug(drm);
+	drm_atomic_helper_shutdown(drm);
+}
+
+static void ra8875_shutdown(struct spi_device *spi)
+{
+	drm_atomic_helper_shutdown(spi_get_drvdata(spi));
+}
+
+static struct spi_driver ra8875_spi_driver = {
+	.driver = {
+		.name = "ra8875",
+		.of_match_table = ra8875_of_match,
+	},
+	.id_table = ra8875_id,
+	.probe = ra8875_probe,
+	.remove = ra8875_remove,
+	.shutdown = ra8875_shutdown,
+};
+module_spi_driver(ra8875_spi_driver);
+
+MODULE_DESCRIPTION("RAiO RA8875 DRM driver");
+MODULE_AUTHOR("Adam Azuddin <azuddinadam@gmail.com>");
+MODULE_LICENSE("GPL");
-- 
2.54.0

