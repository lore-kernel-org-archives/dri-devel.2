Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FDC0CD5BC8
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 09:57:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A5A510E618;
	Tue, 26 May 2026 09:57:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hzMLLURn";
	dkim-atps=neutral
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E795F10E618
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 09:57:51 +0000 (UTC)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-2bcd730e090so84799705ad.2
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 02:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779789471; x=1780394271; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qdCfZvIpAc3UwzOXa3d73fscC26/BA3Xy8iKGDeVRvk=;
 b=hzMLLURnkTFjDrO+annXzLGiGSOvdc72s+FH9OoKg1Y6wUnSt2qQ5PFIaVykC0r+X6
 m3MXn/Ak5LivKvab4GN9pxCm0gigsOLPs0R/mQJ4Oo3bvk1unKeASGy0xAIaTU4vlcW3
 GeOQwbBqQmKMLtWq/GQtkFMurrSETIRTi1XCnUeI4d7imiSO6y9vhjaUK8BBbxCRc2Lt
 SP+bGlZmNr2s0jir8Sc32AN8WGJMrEYp/IpBeuY0LJ30jHbKOujzO5D/xg6RI5hTuqUv
 871GGkAsduFNhxawPaIAwDQajwJs9jqGZ9P6eQwQGObs0oMZLxNp6G9R4pYTTbNJ1jGn
 0ImA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779789471; x=1780394271;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qdCfZvIpAc3UwzOXa3d73fscC26/BA3Xy8iKGDeVRvk=;
 b=jk/6H0a3JokfNt7sh4GUm69gOSB3AOmTj/fD9bM0bWY4lRDH/kKuDtFmSg0vKBT0jp
 8+J/0jBxgvouaqUZ41qF14qo7KW+9AE+9abqny4rE8aImM7gKM+2AOh3utw7Ihvn5Uso
 wLMZM1Z5KNTnbvZraJNYLKhwoFIjh4vXh246D06iQv/0oHJoCBiKLgOIhlp6L7JA6yQm
 DiyLOaf4pU3mgo7Fv5v5QyczNW8J14ZzP142YYk/WeUomO6V1qNd5dNqp/wJ4OklUYOd
 fuDmogsB98JqocEMUoTHyV1AS89R0qwnBGl1zX/JZvRc3SqpF3lPt2niSAYu3Q68R+eR
 yyuw==
X-Gm-Message-State: AOJu0YzjnrfucyFkaOJ8a64BnyUd9qYH9qRKgqQvch21plCK9DocrQWf
 8RtAunTchZ2gG5tdnxPHTqpPM/K8x50tOWe/aP93z0hBVuF2JA7firZs
X-Gm-Gg: Acq92OEQDBKORk5NGK6nNQ3It6fmhisCZ8GX4xVCYmxuG4Q4R8x3whzFlsdaDpGAkbI
 gW+5WD3f9QNxp+RTLFrXSIqGD5JaPzh+91L2NHObTnb/4I0fcf//OAvFM9BfHLcuwRf7Q8whhGe
 zUreizRFhqiXzROtXhZiqlyAjdT3ChhBR9cNvOp9Oqu7+56KcgFOWeAdHmH6lXXr8Csq1ceAVWx
 YcIKQcUH25HyjIdoRh0hen1veisaVlonSCFo1yNUzoHU+Mf7bQO/1nURkDqe0rTsEsw9s/2Lm7s
 ABqViNSp8t1flq5O4OOEj99GEZWv7Sn+tdUXxr+xoyFqHCOJSeqK5dSyblyy9c0NwwPsA1qbUy7
 Zd0pgr5mPJwAFjaOrLGwqKieDMAiqY0X8j5wAwIyXuqvpBfkpAS16BE7bfaWejIe7bojRk2oImK
 lvCtI3+midgyDszVkiR48J/upqC0acYjrVfy3N03uZIsvBlE32hFVSY1pi8AZa58CiC2U1uRAuA
 HVM67tziYyOK6aTo6UzUQ==
X-Received: by 2002:a17:902:d4c3:b0:2b0:4fb6:85ce with SMTP id
 d9443c01a7336-2beb065ba47mr190016995ad.21.1779789471220; 
 Tue, 26 May 2026 02:57:51 -0700 (PDT)
Received: from [127.0.1.1] (211-23-39-77.hinet-ip.hinet.net. [211.23.39.77])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb58b2d47sm147055165ad.45.2026.05.26.02.57.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 02:57:50 -0700 (PDT)
From: LiangCheng Wang <zaq14760@gmail.com>
Date: Tue, 26 May 2026 17:57:17 +0800
Subject: [PATCH v2 2/2] drm/tiny: add support for PIXPAPER 4.26 monochrome
 e-ink panel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-bar-v2-2-c66df9a840c4@gmail.com>
References: <20260526-bar-v2-0-c66df9a840c4@gmail.com>
In-Reply-To: <20260526-bar-v2-0-c66df9a840c4@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Wig Cheng <onlywig@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, LiangCheng Wang <zaq14760@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779789463; l=27824;
 i=zaq14760@gmail.com; h=from:subject:message-id;
 bh=X9R9Ftvs8HDapxq/LssaT0rOEz53olNG6A0ZZe4zFuc=;
 b=NlMujuRiGh27QmPphGe0DpLmg6kOjaOPVYJGUA4P666deocrHqynrsrWorP/8gqEdj43z87DI
 4D7hVkUXJiuBiOEU1Elgb/N3+Xl0q6hVKJHnIrc4N1af4S/kmF5OlKj
X-Developer-Key: i=zaq14760@gmail.com; a=ed25519;
 pk=5IaLhzvMqasgGPT47dsa8HEpfb0/Dv2BZC0TzSLj6E0=
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

Introduce a DRM driver for the Mayqueen Pixpaper 4.26
monochrome e-ink display panel, which is controlled via SPI.
The driver supports an 800x480 display with XRGB8888
framebuffer input.

Also, add Kconfig and Makefile entries for the driver and
update MAINTAINERS for the Pixpaper DRM drivers and binding.

Signed-off-by: LiangCheng Wang <zaq14760@gmail.com>
---
 MAINTAINERS                          |   3 +-
 drivers/gpu/drm/tiny/Kconfig         |  16 +
 drivers/gpu/drm/tiny/Makefile        |   1 +
 drivers/gpu/drm/tiny/pixpaper-426m.c | 828 +++++++++++++++++++++++++++++++++++
 4 files changed, 847 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 882214b0e7db53bb8cc8e75b5d2269ee0591ea20..eebd73ee1f531d3785ec963da03fbab265c2d188 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8234,11 +8234,12 @@ T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
 F:	Documentation/devicetree/bindings/display/repaper.txt
 F:	drivers/gpu/drm/tiny/repaper.c
 
-DRM DRIVER FOR PIXPAPER E-INK PANEL
+DRM DRIVER FOR PIXPAPER E-INK PANELS
 M:	LiangCheng Wang <zaq14760@gmail.com>
 L:	dri-devel@lists.freedesktop.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/display/mayqueen,pixpaper.yaml
+F:	drivers/gpu/drm/tiny/pixpaper-426m.c
 F:	drivers/gpu/drm/tiny/pixpaper.c
 
 DRM DRIVER FOR QEMU'S CIRRUS DEVICE
diff --git a/drivers/gpu/drm/tiny/Kconfig b/drivers/gpu/drm/tiny/Kconfig
index f0e72d4b6a4709564e63c758e857bdb4a320dbe7..028c4314106ac31dfa717f6433c28e58b34c21e8 100644
--- a/drivers/gpu/drm/tiny/Kconfig
+++ b/drivers/gpu/drm/tiny/Kconfig
@@ -98,6 +98,22 @@ config DRM_PIXPAPER
 
 	  If M is selected, the module will be built as pixpaper.ko.
 
+config DRM_PIXPAPER_426M
+	tristate "DRM support for PIXPAPER 4.26 monochrome display panel"
+	depends on DRM && SPI
+	depends on MMU
+	select DRM_CLIENT_SELECTION
+	select DRM_GEM_SHMEM_HELPER
+	select DRM_KMS_HELPER
+	help
+	  DRM driver for the Mayqueen Pixpaper 4.26 monochrome e-ink
+	  display panel.
+
+	  This driver supports SPI-connected 800x480 monochrome panels
+	  with an XRGB8888 framebuffer input format.
+
+	  If M is selected, the module will be built as pixpaper-426m.ko.
+
 config TINYDRM_HX8357D
 	tristate "DRM support for HX8357D display panels"
 	depends on DRM && SPI
diff --git a/drivers/gpu/drm/tiny/Makefile b/drivers/gpu/drm/tiny/Makefile
index 48d30bf6152f979404ac1004174587823a30109e..037b751a1a851cc2f86f701ff71008bcb9c59f29 100644
--- a/drivers/gpu/drm/tiny/Makefile
+++ b/drivers/gpu/drm/tiny/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_DRM_CIRRUS_QEMU)		+= cirrus-qemu.o
 obj-$(CONFIG_DRM_GM12U320)		+= gm12u320.o
 obj-$(CONFIG_DRM_PANEL_MIPI_DBI)	+= panel-mipi-dbi.o
 obj-$(CONFIG_DRM_PIXPAPER)              += pixpaper.o
+obj-$(CONFIG_DRM_PIXPAPER_426M)         += pixpaper-426m.o
 obj-$(CONFIG_TINYDRM_HX8357D)		+= hx8357d.o
 obj-$(CONFIG_TINYDRM_ILI9163)		+= ili9163.o
 obj-$(CONFIG_TINYDRM_ILI9225)		+= ili9225.o
diff --git a/drivers/gpu/drm/tiny/pixpaper-426m.c b/drivers/gpu/drm/tiny/pixpaper-426m.c
new file mode 100644
index 0000000000000000000000000000000000000000..159dcc246092fc583cf4f352fe5c41b1e1fae84c
--- /dev/null
+++ b/drivers/gpu/drm/tiny/pixpaper-426m.c
@@ -0,0 +1,828 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * DRM driver for PIXPAPER 4.26 monochrome e-ink panel
+ *
+ * Author: LiangCheng Wang <zaq14760@gmail.com>,
+ */
+
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/spi/spi.h>
+
+#include <drm/clients/drm_client_setup.h>
+#include <drm/drm_atomic.h>
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_drv.h>
+#include <drm/drm_fbdev_shmem.h>
+#include <drm/drm_framebuffer.h>
+#include <drm/drm_gem_atomic_helper.h>
+#include <drm/drm_gem_shmem_helper.h>
+#include <drm/drm_gem_framebuffer_helper.h>
+#include <drm/drm_print.h>
+#include <drm/drm_probe_helper.h>
+
+MODULE_IMPORT_NS("DMA_BUF");
+
+/* Panel visible resolution */
+#define PIXPAPER_WIDTH    800
+#define PIXPAPER_HEIGHT   480
+
+/*
+ * The panel datasheet specifies an active area of 92.8 mm x 55.68 mm.
+ * Round to whole millimeters for drm_display_info.
+ */
+#define PIXPAPER_WIDTH_MM   93
+#define PIXPAPER_HEIGHT_MM  56
+
+/*
+ * According to the panel datasheet, no RGB-style timing parameters
+ * (porches, sync widths, or a dot clock) are provided. Define a minimal
+ * fixed mode only to satisfy the DRM mode API for this SPI-driven
+ * e-paper panel.
+ */
+#define PIXPAPER_HSYNC_LEN     1
+#define PIXPAPER_HFRONT_PORCH  1
+#define PIXPAPER_HBACK_PORCH   1
+#define PIXPAPER_VSYNC_LEN     1
+#define PIXPAPER_VFRONT_PORCH  1
+#define PIXPAPER_VBACK_PORCH   1
+#define PIXPAPER_MODE_REFRESH_HZ 1
+#define PIXPAPER_MODE_CLOCK_KHZ \
+	(((PIXPAPER_WIDTH + PIXPAPER_HFRONT_PORCH + PIXPAPER_HSYNC_LEN + \
+	   PIXPAPER_HBACK_PORCH) * \
+	  (PIXPAPER_HEIGHT + PIXPAPER_VFRONT_PORCH + PIXPAPER_VSYNC_LEN + \
+	   PIXPAPER_VBACK_PORCH) * \
+	  PIXPAPER_MODE_REFRESH_HZ) / 1000)
+
+#define PIXPAPER_SPI_BITS_PER_WORD 8
+#define PIXPAPER_SPI_SPEED_DEFAULT 1000000
+
+#define PIXPAPER_PIXEL_THRESHOLD 128
+
+#define PIXPAPER_BUSY_TIMEOUT_MS 10000
+#define PIXPAPER_BUSY_POLL_INITIAL_US_MIN 1000
+#define PIXPAPER_BUSY_POLL_INITIAL_US_MAX 1500
+#define PIXPAPER_BUSY_POLL_US_MIN 100
+#define PIXPAPER_BUSY_POLL_US_MAX 200
+
+#define PIXPAPER_RAM_START_ADDR 0x00
+
+#define PIXPAPER_LUMA_R_WEIGHT 299
+#define PIXPAPER_LUMA_G_WEIGHT 587
+#define PIXPAPER_LUMA_B_WEIGHT 114
+#define PIXPAPER_LUMA_DIVISOR 1000
+#define PIXPAPER_LUMA_ROUNDING_BIAS 500
+
+#define PIXPAPER_CMD_DRIVER_OUTPUT_CTRL      0x01
+#define PIXPAPER_CMD_BOOSTER_SOFT_START_CTRL 0x0C
+#define PIXPAPER_CMD_TEMP_SENSOR_CONTROL     0x18
+#define PIXPAPER_CMD_MASTER_ACTIVATION       0x20
+#define PIXPAPER_CMD_DISPLAY_UPDATE_CTRL2    0x22
+#define PIXPAPER_CMD_WRITE_RAM_BW            0x24
+#define PIXPAPER_CMD_BORDER_WAVEFORM_CONTROL 0x3C
+#define PIXPAPER_CMD_SET_RAM_X_START_END     0x44
+#define PIXPAPER_CMD_SET_RAM_Y_START_END     0x45
+#define PIXPAPER_CMD_SET_RAM_X_ADDR_COUNTER  0x4E
+#define PIXPAPER_CMD_SET_RAM_Y_ADDR_COUNTER  0x4F
+
+#define PIXPAPER_DRIVER_OUTPUT_SM                BIT(1)
+
+#define PIXPAPER_BORDER_WAVEFORM_GS_TRANSITION   (0x0 << 6)
+#define PIXPAPER_BORDER_WAVEFORM_LUT1_SEL        0x1
+
+#define PIXPAPER_UPDATE_CTRL2_ENABLE_CLK         BIT(7)
+#define PIXPAPER_UPDATE_CTRL2_ENABLE_ANALOG      BIT(6)
+#define PIXPAPER_UPDATE_CTRL2_LOAD_TEMP          BIT(5)
+#define PIXPAPER_UPDATE_CTRL2_LOAD_LUT           BIT(4)
+#define PIXPAPER_UPDATE_CTRL2_PATTERN_DISPLAY    BIT(2)
+
+#define PIXPAPER_TEMP_SENSOR_INTERNAL           0x80
+#define PIXPAPER_SOFTSTART_A                    0xAE
+#define PIXPAPER_SOFTSTART_B                    0xC7
+#define PIXPAPER_SOFTSTART_C                    0xC3
+#define PIXPAPER_SOFTSTART_D                    0xC0
+#define PIXPAPER_SOFTSTART_E                    0x80
+#define PIXPAPER_DRIVER_OUTPUT_GD_SM_TB         PIXPAPER_DRIVER_OUTPUT_SM
+#define PIXPAPER_BORDER_LUT1                    \
+	(PIXPAPER_BORDER_WAVEFORM_GS_TRANSITION | \
+	 PIXPAPER_BORDER_WAVEFORM_LUT1_SEL)
+#define PIXPAPER_UPDATE_INITIAL                 \
+	(PIXPAPER_UPDATE_CTRL2_ENABLE_CLK | \
+	PIXPAPER_UPDATE_CTRL2_ENABLE_ANALOG | \
+	PIXPAPER_UPDATE_CTRL2_LOAD_TEMP | \
+	PIXPAPER_UPDATE_CTRL2_LOAD_LUT | \
+	PIXPAPER_UPDATE_CTRL2_PATTERN_DISPLAY)
+struct pixpaper_error_ctx {
+	int errno_code;
+};
+
+struct pixpaper_init_seq {
+	u8 cmd;
+	const u8 *data;
+	u8 len;
+};
+
+struct pixpaper_panel {
+	struct drm_device drm;
+	struct drm_plane plane;
+	struct drm_crtc crtc;
+	struct drm_encoder encoder;
+	struct drm_connector connector;
+
+	struct spi_device *spi;
+	struct gpio_desc *reset;
+	struct gpio_desc *busy;
+	struct gpio_desc *dc;
+};
+
+static const uint32_t pixpaper_formats[] = {
+	DRM_FORMAT_XRGB8888,
+};
+
+static void pixpaper_xrgb8888_to_bw(const void *src, void *dst, u32 height,
+				    u32 width, u32 src_pitch, u32 dst_pitch);
+
+static const u8 pixpaper_init_temp_sensor[] = {
+	PIXPAPER_TEMP_SENSOR_INTERNAL,
+};
+
+static const u8 pixpaper_init_softstart[] = {
+	PIXPAPER_SOFTSTART_A,
+	PIXPAPER_SOFTSTART_B,
+	PIXPAPER_SOFTSTART_C,
+	PIXPAPER_SOFTSTART_D,
+	PIXPAPER_SOFTSTART_E,
+};
+
+static const u8 pixpaper_init_driver_output[] = {
+	(PIXPAPER_HEIGHT - 1) & 0xff,
+	(PIXPAPER_HEIGHT - 1) >> 8,
+	PIXPAPER_DRIVER_OUTPUT_GD_SM_TB,
+};
+
+static const u8 pixpaper_init_border[] = {
+	PIXPAPER_BORDER_LUT1,
+};
+
+static const u8 pixpaper_init_ram_x_window[] = {
+	PIXPAPER_RAM_START_ADDR,
+	PIXPAPER_RAM_START_ADDR,
+	(PIXPAPER_WIDTH - 1) & 0xff,
+	(PIXPAPER_WIDTH - 1) >> 8,
+};
+
+static const u8 pixpaper_init_ram_y_window[] = {
+	PIXPAPER_RAM_START_ADDR,
+	PIXPAPER_RAM_START_ADDR,
+	(PIXPAPER_HEIGHT - 1) & 0xff,
+	(PIXPAPER_HEIGHT - 1) >> 8,
+};
+
+static const u8 pixpaper_init_ram_x_counter[] = {
+	PIXPAPER_RAM_START_ADDR,
+	PIXPAPER_RAM_START_ADDR,
+};
+
+static const u8 pixpaper_init_ram_y_counter[] = {
+	PIXPAPER_RAM_START_ADDR,
+	PIXPAPER_RAM_START_ADDR,
+};
+
+static const struct pixpaper_init_seq pixpaper_init_seqs[] = {
+	{
+		.cmd = PIXPAPER_CMD_TEMP_SENSOR_CONTROL,
+		.data = pixpaper_init_temp_sensor,
+		.len = ARRAY_SIZE(pixpaper_init_temp_sensor),
+	},
+	{
+		.cmd = PIXPAPER_CMD_BOOSTER_SOFT_START_CTRL,
+		.data = pixpaper_init_softstart,
+		.len = ARRAY_SIZE(pixpaper_init_softstart),
+	},
+	{
+		.cmd = PIXPAPER_CMD_DRIVER_OUTPUT_CTRL,
+		.data = pixpaper_init_driver_output,
+		.len = ARRAY_SIZE(pixpaper_init_driver_output),
+	},
+	{
+		.cmd = PIXPAPER_CMD_BORDER_WAVEFORM_CONTROL,
+		.data = pixpaper_init_border,
+		.len = ARRAY_SIZE(pixpaper_init_border),
+	},
+	{
+		.cmd = PIXPAPER_CMD_SET_RAM_X_START_END,
+		.data = pixpaper_init_ram_x_window,
+		.len = ARRAY_SIZE(pixpaper_init_ram_x_window),
+	},
+	{
+		.cmd = PIXPAPER_CMD_SET_RAM_Y_START_END,
+		.data = pixpaper_init_ram_y_window,
+		.len = ARRAY_SIZE(pixpaper_init_ram_y_window),
+	},
+	{
+		.cmd = PIXPAPER_CMD_SET_RAM_X_ADDR_COUNTER,
+		.data = pixpaper_init_ram_x_counter,
+		.len = ARRAY_SIZE(pixpaper_init_ram_x_counter),
+	},
+	{
+		.cmd = PIXPAPER_CMD_SET_RAM_Y_ADDR_COUNTER,
+		.data = pixpaper_init_ram_y_counter,
+		.len = ARRAY_SIZE(pixpaper_init_ram_y_counter),
+	},
+};
+
+static inline struct pixpaper_panel *to_pixpaper_panel(struct drm_device *drm)
+{
+	return container_of(drm, struct pixpaper_panel, drm);
+}
+
+static void pixpaper_wait_busy(struct pixpaper_panel *panel)
+{
+	unsigned int timeout_ms = PIXPAPER_BUSY_TIMEOUT_MS;
+	unsigned long timeout_jiffies = jiffies + msecs_to_jiffies(timeout_ms);
+
+	usleep_range(PIXPAPER_BUSY_POLL_INITIAL_US_MIN,
+		     PIXPAPER_BUSY_POLL_INITIAL_US_MAX);
+	while (gpiod_get_value_cansleep(panel->busy) != 0) {
+		if (time_after(jiffies, timeout_jiffies)) {
+			drm_warn(&panel->drm, "Busy wait timed out\n");
+			return;
+		}
+		usleep_range(PIXPAPER_BUSY_POLL_US_MIN,
+			     PIXPAPER_BUSY_POLL_US_MAX);
+	}
+}
+
+static void pixpaper_spi_write(struct pixpaper_panel *panel, int dc,
+			       const void *buf, size_t len,
+			       struct pixpaper_error_ctx *err)
+{
+	int ret;
+
+	if (err->errno_code || !len)
+		return;
+
+	gpiod_set_value_cansleep(panel->dc, dc);
+	usleep_range(1, 5);
+
+	ret = spi_write(panel->spi, buf, len);
+	if (ret < 0)
+		err->errno_code = ret;
+}
+
+static void pixpaper_send_cmd(struct pixpaper_panel *panel, u8 cmd,
+			      struct pixpaper_error_ctx *err)
+{
+	pixpaper_spi_write(panel, 0, &cmd, sizeof(cmd), err);
+}
+
+static void pixpaper_send_data(struct pixpaper_panel *panel, u8 data,
+			       struct pixpaper_error_ctx *err)
+{
+	pixpaper_spi_write(panel, 1, &data, sizeof(data), err);
+}
+
+static void pixpaper_reset_ram_counters(struct pixpaper_panel *panel,
+					struct pixpaper_error_ctx *err)
+{
+	if (err->errno_code)
+		return;
+
+	pixpaper_send_cmd(panel, PIXPAPER_CMD_SET_RAM_X_ADDR_COUNTER, err);
+	pixpaper_send_data(panel, PIXPAPER_RAM_START_ADDR, err);
+	pixpaper_send_data(panel, PIXPAPER_RAM_START_ADDR, err);
+
+	pixpaper_send_cmd(panel, PIXPAPER_CMD_SET_RAM_Y_ADDR_COUNTER, err);
+	pixpaper_send_data(panel, PIXPAPER_RAM_START_ADDR, err);
+	pixpaper_send_data(panel, PIXPAPER_RAM_START_ADDR, err);
+}
+
+static void pixpaper_write_ram(struct pixpaper_panel *panel, u8 cmd,
+			       const u8 *buf, u32 len,
+			       struct pixpaper_error_ctx *err)
+{
+	if (err->errno_code || !buf || !len)
+		return;
+
+	pixpaper_reset_ram_counters(panel, err);
+
+	pixpaper_send_cmd(panel, cmd, err);
+	pixpaper_spi_write(panel, 1, buf, len, err);
+}
+
+static void pixpaper_send_init_seq(struct pixpaper_panel *panel,
+				   const struct pixpaper_init_seq *seq,
+				   struct pixpaper_error_ctx *err)
+{
+	if (err->errno_code || !seq->data || !seq->len)
+		return;
+
+	pixpaper_send_cmd(panel, seq->cmd, err);
+	pixpaper_spi_write(panel, 1, seq->data, seq->len, err);
+}
+
+static void pixpaper_trigger_update(struct pixpaper_panel *panel,
+				    struct pixpaper_error_ctx *err)
+{
+	if (err->errno_code)
+		return;
+
+	pixpaper_send_cmd(panel, PIXPAPER_CMD_DISPLAY_UPDATE_CTRL2, err);
+	pixpaper_send_data(panel, PIXPAPER_UPDATE_INITIAL, err);
+	pixpaper_send_cmd(panel, PIXPAPER_CMD_MASTER_ACTIVATION, err);
+	pixpaper_wait_busy(panel);
+}
+
+static void *pixpaper_prepare_buffer(const void *vaddr,
+				     const struct drm_framebuffer *fb,
+				     u32 *dst_pitch,
+				     struct pixpaper_error_ctx *err)
+{
+	void *dst;
+
+	if (err->errno_code)
+		return NULL;
+
+	*dst_pitch = DIV_ROUND_UP(fb->width, 8);
+	dst = kzalloc(*dst_pitch * fb->height, GFP_KERNEL);
+	if (!dst) {
+		err->errno_code = -ENOMEM;
+		return NULL;
+	}
+
+	pixpaper_xrgb8888_to_bw(vaddr, dst, fb->height, fb->width,
+				fb->pitches[0], *dst_pitch);
+
+	return dst;
+}
+
+static void pixpaper_write_image(struct pixpaper_panel *panel,
+				 const u8 *buf, u32 len,
+				 struct pixpaper_error_ctx *err)
+{
+	if (err->errno_code)
+		return;
+
+	pixpaper_write_ram(panel, PIXPAPER_CMD_WRITE_RAM_BW, buf, len, err);
+}
+
+static int pixpaper_panel_hw_init(struct pixpaper_panel *panel)
+{
+	struct pixpaper_error_ctx err = { .errno_code = 0 };
+	u8 i;
+
+	gpiod_set_value_cansleep(panel->reset, 0);
+	msleep(50);
+	gpiod_set_value_cansleep(panel->reset, 1);
+	msleep(50);
+
+	pixpaper_wait_busy(panel);
+
+	for (i = 0; i < ARRAY_SIZE(pixpaper_init_seqs); i++) {
+		pixpaper_send_init_seq(panel, &pixpaper_init_seqs[i], &err);
+		if (err.errno_code)
+			goto init_fail;
+	}
+
+	return 0;
+
+init_fail:
+	drm_err(&panel->drm, "Hardware initialization failed (err=%d)\n",
+		err.errno_code);
+	return err.errno_code;
+}
+
+static void pixpaper_xrgb8888_to_bw(const void *src, void *dst, u32 height,
+				    u32 width, u32 src_pitch, u32 dst_pitch)
+{
+	const uint8_t *src_base = src;
+	uint8_t *dst_pixels = dst;
+
+	if (dst == NULL || src == NULL)
+		return;
+
+	for (u32 y = 0; y < height; y++) {
+		uint8_t *dst_row = dst_pixels + y * dst_pitch;
+		const uint8_t *src_row = src_base + y * src_pitch;
+		const uint32_t *src_pixels = (const uint32_t *)src_row;
+
+		for (u32 x = 0; x < width; x++) {
+			u32 src_x = width - 1 - x;
+			uint8_t r, g, b;
+			u8 bit;
+			u32 bit_pos = x % 8;
+			u32 byte_pos = x / 8;
+			uint32_t gray_val;
+			uint32_t pixel;
+
+			pixel = src_pixels[src_x];
+			r = (pixel >> 16) & 0xFF;
+			g = (pixel >> 8) & 0xFF;
+			b = pixel & 0xFF;
+
+			gray_val = (r * PIXPAPER_LUMA_R_WEIGHT +
+				    g * PIXPAPER_LUMA_G_WEIGHT +
+				    b * PIXPAPER_LUMA_B_WEIGHT +
+				    PIXPAPER_LUMA_ROUNDING_BIAS) /
+				   PIXPAPER_LUMA_DIVISOR;
+			bit = gray_val >= PIXPAPER_PIXEL_THRESHOLD;
+
+			if (bit)
+				dst_row[byte_pos] |= BIT(7 - bit_pos);
+			else
+				dst_row[byte_pos] &= ~BIT(7 - bit_pos);
+		}
+	}
+}
+
+static int pixpaper_plane_helper_atomic_check(struct drm_plane *plane,
+					      struct drm_atomic_state *state)
+{
+	struct drm_plane_state *new_plane_state =
+		drm_atomic_get_new_plane_state(state, plane);
+	struct drm_crtc *new_crtc = new_plane_state->crtc;
+	struct drm_crtc_state *new_crtc_state = NULL;
+	int ret;
+
+	if (new_crtc)
+		new_crtc_state = drm_atomic_get_new_crtc_state(state, new_crtc);
+
+	ret = drm_atomic_helper_check_plane_state(new_plane_state,
+						  new_crtc_state, DRM_PLANE_NO_SCALING,
+						  DRM_PLANE_NO_SCALING, false, false);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int pixpaper_crtc_helper_atomic_check(struct drm_crtc *crtc,
+					     struct drm_atomic_state *state)
+{
+	struct drm_crtc_state *crtc_state =
+		drm_atomic_get_new_crtc_state(state, crtc);
+
+	if (!crtc_state->enable)
+		return 0;
+
+	return drm_atomic_helper_check_crtc_primary_plane(crtc_state);
+}
+
+static void pixpaper_crtc_atomic_enable(struct drm_crtc *crtc,
+					struct drm_atomic_state *state)
+{
+	struct pixpaper_panel *panel = to_pixpaper_panel(crtc->dev);
+	struct drm_device *drm = &panel->drm;
+	int idx;
+
+	if (!drm_dev_enter(drm, &idx))
+		return;
+
+	drm_dev_exit(idx);
+}
+
+static void pixpaper_crtc_atomic_disable(struct drm_crtc *crtc,
+					 struct drm_atomic_state *state)
+{
+	struct pixpaper_panel *panel = to_pixpaper_panel(crtc->dev);
+	struct drm_device *drm = &panel->drm;
+	int idx;
+
+	if (!drm_dev_enter(drm, &idx))
+		return;
+
+	drm_dev_exit(idx);
+}
+
+static void pixpaper_plane_atomic_update(struct drm_plane *plane,
+					 struct drm_atomic_state *state)
+{
+	struct drm_plane_state *plane_state =
+		drm_atomic_get_new_plane_state(state, plane);
+	struct drm_shadow_plane_state *shadow_plane_state =
+		to_drm_shadow_plane_state(plane_state);
+	struct pixpaper_panel *panel = to_pixpaper_panel(plane->dev);
+
+	if (!plane_state->crtc || !plane_state->fb || !plane_state->visible)
+		return;
+
+	{
+		struct drm_device *drm = &panel->drm;
+		struct drm_framebuffer *fb = plane_state->fb;
+		struct iosys_map map = shadow_plane_state->data[0];
+		const void *vaddr = map.vaddr;
+		int idx;
+		struct pixpaper_error_ctx err = { .errno_code = 0 };
+		uint32_t dst_pitch;
+		void *dst = NULL;
+		u32 dst_len;
+
+		if (!drm_dev_enter(drm, &idx))
+			return;
+
+		if (fb->format->format != DRM_FORMAT_XRGB8888) {
+			err.errno_code = -EINVAL;
+			drm_err(drm, "Unsupported framebuffer format: 0x%08x\n",
+				fb->format->format);
+			goto update_cleanup;
+		}
+
+		dst = pixpaper_prepare_buffer(vaddr, fb, &dst_pitch, &err);
+		if (err.errno_code) {
+			drm_err(drm, "Failed to allocate temporary buffer\n");
+			goto update_cleanup;
+		}
+
+		dst_len = dst_pitch * fb->height;
+		pixpaper_write_image(panel, dst, dst_len, &err);
+		if (err.errno_code)
+			goto update_cleanup;
+
+		pixpaper_trigger_update(panel, &err);
+		if (err.errno_code)
+			goto update_cleanup;
+update_cleanup:
+		if (err.errno_code && err.errno_code != -ETIMEDOUT)
+			drm_err(drm, "Frame update failed: %d\n",
+				err.errno_code);
+
+		kfree(dst);
+		drm_dev_exit(idx);
+	}
+}
+
+static int pixpaper_connector_get_modes(struct drm_connector *connector)
+{
+	struct drm_display_mode *mode;
+
+	mode = drm_mode_create(connector->dev);
+	if (!mode) {
+		drm_err(connector->dev,
+			"Failed to create mode for connector %s\n",
+			connector->name);
+		return 0;
+	}
+
+	mode->hdisplay    = PIXPAPER_WIDTH;
+	mode->hsync_start = PIXPAPER_WIDTH + PIXPAPER_HFRONT_PORCH;
+	mode->hsync_end   = mode->hsync_start + PIXPAPER_HSYNC_LEN;
+	mode->htotal      = mode->hsync_end + PIXPAPER_HBACK_PORCH;
+
+	mode->vdisplay    = PIXPAPER_HEIGHT;
+	mode->vsync_start = PIXPAPER_HEIGHT + PIXPAPER_VFRONT_PORCH;
+	mode->vsync_end   = mode->vsync_start + PIXPAPER_VSYNC_LEN;
+	mode->vtotal      = mode->vsync_end + PIXPAPER_VBACK_PORCH;
+
+	mode->clock       = PIXPAPER_MODE_CLOCK_KHZ;
+
+	mode->type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED;
+	drm_mode_set_name(mode);
+
+	if (drm_mode_validate_size(mode, connector->dev->mode_config.max_width,
+				   connector->dev->mode_config.max_height) != MODE_OK) {
+		drm_warn(connector->dev,
+			 "Mode %s (%dx%d) failed size validation against max %dx%d\n",
+			 mode->name, mode->hdisplay, mode->vdisplay,
+			 connector->dev->mode_config.max_width,
+			 connector->dev->mode_config.max_height);
+		drm_mode_destroy(connector->dev, mode);
+		return 0;
+		}
+
+		drm_mode_probed_add(connector, mode);
+
+		connector->display_info.width_mm  = PIXPAPER_WIDTH_MM;
+		connector->display_info.height_mm = PIXPAPER_HEIGHT_MM;
+
+	return 1;
+}
+
+static enum drm_mode_status pixpaper_mode_valid(const struct drm_display_mode *mode)
+{
+	if (mode->hdisplay == PIXPAPER_WIDTH &&
+	    mode->vdisplay == PIXPAPER_HEIGHT)
+		return MODE_OK;
+
+	return MODE_BAD;
+}
+
+static enum drm_mode_status pixpaper_crtc_mode_valid(struct drm_crtc *crtc,
+						     const struct drm_display_mode *mode)
+{
+	return pixpaper_mode_valid(mode);
+}
+
+static const struct drm_plane_funcs pixpaper_plane_funcs = {
+	.update_plane = drm_atomic_helper_update_plane,
+	.disable_plane = drm_atomic_helper_disable_plane,
+	.destroy = drm_plane_cleanup,
+	DRM_GEM_SHADOW_PLANE_FUNCS,
+};
+
+static const struct drm_plane_helper_funcs pixpaper_plane_helper_funcs = {
+	DRM_GEM_SHADOW_PLANE_HELPER_FUNCS,
+	.atomic_check = pixpaper_plane_helper_atomic_check,
+	.atomic_update = pixpaper_plane_atomic_update,
+};
+
+static const struct drm_crtc_funcs pixpaper_crtc_funcs = {
+	.set_config = drm_atomic_helper_set_config,
+	.page_flip = drm_atomic_helper_page_flip,
+	.reset = drm_atomic_helper_crtc_reset,
+	.destroy = drm_crtc_cleanup,
+	.atomic_duplicate_state = drm_atomic_helper_crtc_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_crtc_destroy_state,
+};
+
+static const struct drm_crtc_helper_funcs pixpaper_crtc_helper_funcs = {
+	.mode_valid = pixpaper_crtc_mode_valid,
+	.atomic_check = pixpaper_crtc_helper_atomic_check,
+	.atomic_enable = pixpaper_crtc_atomic_enable,
+	.atomic_disable = pixpaper_crtc_atomic_disable,
+};
+
+static const struct drm_encoder_funcs pixpaper_encoder_funcs = {
+	.destroy = drm_encoder_cleanup,
+};
+
+static const struct drm_connector_funcs pixpaper_connector_funcs = {
+	.reset = drm_atomic_helper_connector_reset,
+	.fill_modes = drm_helper_probe_single_connector_modes,
+	.destroy = drm_connector_cleanup,
+	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
+};
+
+static const struct drm_connector_helper_funcs pixpaper_connector_helper_funcs = {
+	.get_modes = pixpaper_connector_get_modes,
+};
+
+DEFINE_DRM_GEM_FOPS(pixpaper_fops);
+
+static struct drm_driver pixpaper_drm_driver = {
+	.driver_features = DRIVER_GEM | DRIVER_MODESET | DRIVER_ATOMIC,
+	.fops = &pixpaper_fops,
+	.name = "pixpaper-426m",
+	.desc = "DRM driver for PIXPAPER 4.26 monochrome e-ink panel",
+	.major = 1,
+	.minor = 0,
+	DRM_GEM_SHMEM_DRIVER_OPS,
+	DRM_FBDEV_SHMEM_DRIVER_OPS,
+};
+
+static int pixpaper_mode_config_valid(struct drm_device *dev,
+				      const struct drm_display_mode *mode)
+{
+	return pixpaper_mode_valid(mode);
+}
+
+static const struct drm_mode_config_funcs pixpaper_mode_config_funcs = {
+	.fb_create = drm_gem_fb_create_with_dirty,
+	.mode_valid = pixpaper_mode_config_valid,
+	.atomic_check = drm_atomic_helper_check,
+	.atomic_commit = drm_atomic_helper_commit,
+};
+
+static int pixpaper_probe(struct spi_device *spi)
+{
+	struct device *dev = &spi->dev;
+	struct pixpaper_panel *panel;
+	struct drm_device *drm;
+	int ret;
+
+	panel = devm_drm_dev_alloc(dev, &pixpaper_drm_driver,
+				   struct pixpaper_panel, drm);
+	if (IS_ERR(panel))
+		return PTR_ERR(panel);
+
+	drm = &panel->drm;
+	panel->spi = spi;
+	spi_set_drvdata(spi, panel);
+
+	ret = drmm_mode_config_init(drm);
+	if (ret)
+		return ret;
+
+	spi->mode = SPI_MODE_0;
+	spi->bits_per_word = PIXPAPER_SPI_BITS_PER_WORD;
+
+	if (!spi->max_speed_hz) {
+		drm_warn(drm,
+			 "spi-max-frequency not specified in DT, using default %u Hz\n",
+			 PIXPAPER_SPI_SPEED_DEFAULT);
+		spi->max_speed_hz = PIXPAPER_SPI_SPEED_DEFAULT;
+	}
+
+	ret = spi_setup(spi);
+	if (ret < 0) {
+		drm_err(drm, "SPI setup failed: %d\n", ret);
+		return ret;
+	}
+
+	if (!dev->dma_mask)
+		dev->dma_mask = &dev->coherent_dma_mask;
+	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
+	if (ret) {
+		drm_err(drm, "Failed to set DMA mask: %d\n", ret);
+		return ret;
+	}
+
+	panel->reset = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(panel->reset))
+		return PTR_ERR(panel->reset);
+
+	panel->busy = devm_gpiod_get(dev, "busy", GPIOD_IN);
+	if (IS_ERR(panel->busy))
+		return PTR_ERR(panel->busy);
+
+	panel->dc = devm_gpiod_get(dev, "dc", GPIOD_OUT_HIGH);
+	if (IS_ERR(panel->dc))
+		return PTR_ERR(panel->dc);
+
+	ret = pixpaper_panel_hw_init(panel);
+	if (ret) {
+		drm_err(drm, "Panel hardware initialization failed: %d\n", ret);
+		return ret;
+	}
+
+	drm->mode_config.funcs = &pixpaper_mode_config_funcs;
+	drm->mode_config.min_width = PIXPAPER_WIDTH;
+	drm->mode_config.max_width = PIXPAPER_WIDTH;
+	drm->mode_config.min_height = PIXPAPER_HEIGHT;
+	drm->mode_config.max_height = PIXPAPER_HEIGHT;
+
+	ret = drm_universal_plane_init(drm, &panel->plane, 1, &pixpaper_plane_funcs,
+				       pixpaper_formats, ARRAY_SIZE(pixpaper_formats), NULL,
+				       DRM_PLANE_TYPE_PRIMARY, NULL);
+	if (ret)
+		return ret;
+	drm_plane_helper_add(&panel->plane, &pixpaper_plane_helper_funcs);
+
+	ret = drm_crtc_init_with_planes(drm, &panel->crtc, &panel->plane, NULL,
+					&pixpaper_crtc_funcs, NULL);
+	if (ret)
+		return ret;
+	drm_crtc_helper_add(&panel->crtc, &pixpaper_crtc_helper_funcs);
+
+	ret = drm_encoder_init(drm, &panel->encoder, &pixpaper_encoder_funcs,
+			       DRM_MODE_ENCODER_NONE, NULL);
+	if (ret)
+		return ret;
+
+	ret = drm_connector_init(drm, &panel->connector,
+				 &pixpaper_connector_funcs,
+				 DRM_MODE_CONNECTOR_SPI);
+	if (ret)
+		return ret;
+
+	drm_connector_helper_add(&panel->connector,
+				 &pixpaper_connector_helper_funcs);
+	drm_connector_attach_encoder(&panel->connector, &panel->encoder);
+	panel->encoder.possible_crtcs = drm_crtc_mask(&panel->crtc);
+
+	drm_mode_config_reset(drm);
+
+	ret = drm_dev_register(drm, 0);
+	if (ret)
+		return ret;
+
+	drm_client_setup(drm, NULL);
+
+	return 0;
+}
+
+static void pixpaper_remove(struct spi_device *spi)
+{
+	struct pixpaper_panel *panel = spi_get_drvdata(spi);
+
+	if (!panel)
+		return;
+
+	drm_dev_unplug(&panel->drm);
+	drm_atomic_helper_shutdown(&panel->drm);
+}
+
+static const struct spi_device_id pixpaper_ids[] = { { "pixpaper-426m", 0 }, {} };
+MODULE_DEVICE_TABLE(spi, pixpaper_ids);
+
+static const struct of_device_id pixpaper_dt_ids[] = {
+	{ .compatible = "mayqueen,pixpaper-426m" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, pixpaper_dt_ids);
+
+static struct spi_driver pixpaper_spi_driver = {
+	.driver = {
+		.name = "pixpaper-426m",
+		.of_match_table = pixpaper_dt_ids,
+	},
+	.id_table = pixpaper_ids,
+	.probe = pixpaper_probe,
+	.remove = pixpaper_remove,
+};
+
+module_spi_driver(pixpaper_spi_driver);
+
+MODULE_AUTHOR("LiangCheng Wang");
+MODULE_DESCRIPTION("DRM SPI driver for PIXPAPER 4.26 monochrome e-ink panel");
+MODULE_LICENSE("GPL");

-- 
2.34.1

