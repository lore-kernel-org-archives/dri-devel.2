Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1142C2A09B
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 14:22:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EF8110F501;
	Fri,  7 Aug 2026 14:22:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nEuL4mHP";
	dkim-atps=neutral
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 404ED10F501
 for <dri-devel@lists.freedesktop.org>; Fri,  7 Aug 2026 14:22:38 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-383cb94f742so3332781a91.3
 for <dri-devel@lists.freedesktop.org>; Fri, 07 Aug 2026 07:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786112558; x=1786717358; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xiuUi61ARSwzz1aZ04OlVUgIQTtBBwGlgu/FI/r02UA=;
 b=nEuL4mHPgnkfWUGMYqE9Aiv/mKhAxRvAg1LC6Zr/nKSugViM1WefOAiHDsG72UcXLf
 5AmwH+cheGIypqR0NrEBZTWF4N6l9qwrKfT3j8i177xMO4IvBKUTFm6IF8MLFmWlF5Ap
 Q+NKS58o2ix0/M7ilWzSF3s9imnLNzexbSxral3kVre1d4HhroBxutjBc8W0KVQGhMQ8
 62aE8ajqNnNZRr41qkMoqZ9REAlG2dT/K7n0O1MjpL9VAYe+CuHobYxOD1t1r7I6ZVxQ
 JOjpndVA7o9pdALdnA1eBdPDevGu+dZzBHjgttjdNpn3RNr6uoGZh6gxuD31ELcLyoBh
 Bn1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786112558; x=1786717358;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xiuUi61ARSwzz1aZ04OlVUgIQTtBBwGlgu/FI/r02UA=;
 b=mXNZhgnOd2pA1QyLtt1NK/TUQSGyKPD1HFaJenFXR1sbYc6guhF8QnEulxhrfs23r8
 kWIRwhXeZRLXWAjwULdVRMtTtHNywLR0OX37B0I+bgEHu9gs+rRrmJQgRDK5pYI2SNF1
 6tuTpMhUi+m5UJfbocuE9PG5E49UiUHJVxqzlZlYrL2l+36QbRP2p/cMFo4BY837I1RN
 6KY3VFL84YY9UnU6Y7PUjiQZXST4UYuf08y9OphGSQCxRg3TVgNEUUS2wR1RO+8L8dRN
 FRSqfJjwYSldLtQV2r5xjalBflSP9LY0jcscl2YezR/wLZNrfhHefz6ROlakcqg4UIYV
 BzTg==
X-Forwarded-Encrypted: i=1;
 AHgh+RobdN+y32msvshbdn/9inhIV42lEOoyNSgNbELsQEJ6K2HwQeJfcYJ63a/rer/4E5cvqdy8h+TGmBc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywr51DKgNwmDqbn+cssEJk7Iy4ySqs7KDDPoGu+MHvMP3Kf07IY
 oDWIPkqiDgurwhtWq4dq4x8DI8ma5H7UXdEVnGz2Eni+UcYIovHRR+g=
X-Gm-Gg: AR+sD10OcirX0eYeWE++YaQWW+N+iUNTVaMRiq+YxFlyz1u+AjYYUXoWhtEwV4AH41z
 WkM088NMqHiNw4YwAYB85O7Nt7sHnyA3GVLksxH8s3RpVzfsecarH69NOSRkMk2rS8tVlwAgELp
 P6WQflMESETxxx9OaMd6+Z8qT8mpGrGcBPeWhbbE78IVrFmu5zXhEG/SyX2yhg4Z3wx0ZxXo+Xj
 fLbOnjVuvJdXT5b3cgxyeMWmoP/bJPsLjURc8pjg31n/OU950YGbT/1YQo3WM69KP+gCytJV0sr
 NavCHBtxBLEBNwEJWmU1rXScRDr5aJPuTz+xLo/oAkV45NEMsF43EGlthzUad/KIDaV+Aks1dcW
 fgosPtF1xnOXOOcEQo9lrKWQoY52pxGFG/OIrvDHU6lLT49hxQ2P9EbVE7mCNvEbnfcGdczXTgb
 UEf0IWCKoL4P79ntPfxSmnTK+xjGmrotz/mwD4rxn6RtJ+Qpr1WUYfV4Lyo5NxHGiSdOtBymkW4
 dW7EjrL2/xnfzotXd4WYyT5J+APdYqTAN8hbb2Kc6PKKx9Nlwg=
X-Received: by 2002:a05:6a20:6a1c:b0:3c4:3112:45 with SMTP id
 adf61e73a8af0-3cb85e9926fmr26441258637.1.1786112557526; 
 Fri, 07 Aug 2026 07:22:37 -0700 (PDT)
Received: from localhost.localdomain ([186.158.238.108])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315be8a7395sm8521868eec.9.2026.08.07.07.22.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 07:22:37 -0700 (PDT)
From: =?UTF-8?q?Nicol=C3=A1s=20Antinori?= <nico.antinori.7@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: =?UTF-8?q?Nicol=C3=A1s=20Antinori?= <nico.antinori.7@gmail.com>,
 Brigham Campbell <me@brighamcampbell.com>,
 Jori Koolstra <jkoolstra@xs4all.nl>,
 Shuah Khan <skhan@linuxfoundation.org>, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev
Subject: [PATCH 2/3] drm/ch1115: add support for Chipwealth CH1115 OLED
 controller
Date: Fri,  7 Aug 2026 11:19:51 -0300
Message-ID: <1d814b35f543d5aa19ca8cfab923af3b4403fcef.1786110720.git.nico.antinori.7@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1786110720.git.nico.antinori.7@gmail.com>
References: <cover.1786110720.git.nico.antinori.7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Chipwealth CH1115 is a controller for monochrome dot matrix OLED panels.

Add DRM support for this chip using i2c bus.

Signed-off-by: Nicolás Antinori <nico.antinori.7@gmail.com>
---
 drivers/gpu/drm/Kconfig             |   1 +
 drivers/gpu/drm/Makefile            |   1 +
 drivers/gpu/drm/chipwealth/Kconfig  |  16 +
 drivers/gpu/drm/chipwealth/Makefile |   3 +
 drivers/gpu/drm/chipwealth/ch1115.c | 828 ++++++++++++++++++++++++++++
 5 files changed, 849 insertions(+)
 create mode 100644 drivers/gpu/drm/chipwealth/Kconfig
 create mode 100644 drivers/gpu/drm/chipwealth/Makefile
 create mode 100644 drivers/gpu/drm/chipwealth/ch1115.c

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index ba242a8318a8..7aa3ca225434 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -307,6 +307,7 @@ source "drivers/gpu/drm/aspeed/Kconfig"
 source "drivers/gpu/drm/ast/Kconfig"
 source "drivers/gpu/drm/atmel-hlcdc/Kconfig"
 source "drivers/gpu/drm/bridge/Kconfig"
+source "drivers/gpu/drm/chipwealth/Kconfig"
 source "drivers/gpu/drm/etnaviv/Kconfig"
 source "drivers/gpu/drm/exynos/Kconfig"
 source "drivers/gpu/drm/fsl-dcu/Kconfig"
diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index 58c8729ab5a9..9ef738f549ec 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -238,6 +238,7 @@ obj-$(CONFIG_DRM_SPRD) += sprd/
 obj-$(CONFIG_DRM_LOONGSON) += loongson/
 obj-$(CONFIG_DRM_POWERVR) += imagination/
 obj-$(CONFIG_DRM_VERISILICON_DC) += verisilicon/
+obj-y			+= chipwealth/

 # Ensure drm headers are self-contained and pass kernel-doc
 hdrtest-files := \
diff --git a/drivers/gpu/drm/chipwealth/Kconfig b/drivers/gpu/drm/chipwealth/Kconfig
new file mode 100644
index 000000000000..f94af7525c0b
--- /dev/null
+++ b/drivers/gpu/drm/chipwealth/Kconfig
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config DRM_CH1115
+	tristate "DRM support for Ch1115 OLED panels (I2C BUS)"
+	depends on DRM && I2C
+	select DRM_CLIENT_SELECTION
+	select DRM_GEM_SHMEM_HELPER
+	select DRM_KMS_HELPER
+	select REGMAP_I2C
+	select VIDEOMODE_HELPERS
+	help
+	  Chipwealth CH1115 is a controller for monochrome dot matrix OLED
+	  panels.
+
+	  DRM Driver for Ch1115 OLED panels connected via I2C.
+
+	  If M is selected the module will be called ch1115.
diff --git a/drivers/gpu/drm/chipwealth/Makefile b/drivers/gpu/drm/chipwealth/Makefile
new file mode 100644
index 000000000000..f9907dc494a1
--- /dev/null
+++ b/drivers/gpu/drm/chipwealth/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+obj-$(CONFIG_DRM_CH1115)		+= ch1115.o
diff --git a/drivers/gpu/drm/chipwealth/ch1115.c b/drivers/gpu/drm/chipwealth/ch1115.c
new file mode 100644
index 000000000000..0ff5d3d9a7cd
--- /dev/null
+++ b/drivers/gpu/drm/chipwealth/ch1115.c
@@ -0,0 +1,828 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * DRM driver for Ch1115 panels
+ *
+ * Copyright (C) 2026 Nicolás Antinori <nico.antinori.7@gmail.com>
+ *
+ * Datasheet: https://datasheet4u.com/download/1576606/CH1115.html
+ *
+ * Based on
+ *  - drivers/gpu/drm/sitronix/st7571-i2c.c
+ *  - drivers/gpu/drm/sitronix/st7571.c
+ * Copyright (C) 2025 Marcus Folkesson <marcus.folkesson@gmail.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+
+#include <drm/clients/drm_client_setup.h>
+#include <drm/drm_atomic.h>
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_connector.h>
+#include <drm/drm_crtc_helper.h>
+#include <drm/drm_damage_helper.h>
+#include <drm/drm_drv.h>
+#include <drm/drm_encoder.h>
+#include <drm/drm_fbdev_shmem.h>
+#include <drm/drm_fourcc.h>
+#include <drm/drm_framebuffer.h>
+#include <drm/drm_gem_atomic_helper.h>
+#include <drm/drm_gem_framebuffer_helper.h>
+#include <drm/drm_gem_shmem_helper.h>
+#include <drm/drm_plane.h>
+#include <drm/drm_probe_helper.h>
+
+#include <video/display_timing.h>
+#include <video/of_display_timing.h>
+
+#define CH1115_VAL_CLOCK_DIVIDE_RATIO(c, d)		(FIELD_PREP(GENMASK(7, 4), (c)) | \
+							 FIELD_PREP(GENMASK(3, 0), (d)))
+#define CH1115_VAL_DC_DC_OFF				0x8a
+#define CH1115_VAL_DC_DC_ON				0x8b
+#define CH1115_VAL_PRE_CHARGE_PERIOD			0x22
+#define CH1115_VAL_CLOCK_OSC_FREQ			0x8
+#define CH1115_VAL_CLOCK_DIV_RATIO			0x0
+#define CH1115_VAL_VCOM_DESELECT_LVL			0x20
+#define CH1115_VAL_CONTRAST				0x7f
+
+#define CH1115_PAGE_HEIGHT				8
+#define CH1115_MAX_WIDTH				128
+#define CH1115_MAX_HEIGHT				64
+#define CH1115_MAX_PAGES				8
+#define CH1115_MAX_CONTRAST				255
+
+#define CH1115_COMMAND_MODE				0x00
+#define CH1115_DATA_MODE				0x40
+
+#define CH1115_CMD_START_LINE				0x40
+#define CH1115_CMD_CONTRAST				0x81
+#define CH1115_CMD_SEG_REMAP_FLIP			0xa1
+#define CH1115_CMD_FOLLOW_RAM				0xa4
+#define CH1115_CMD_ALL_ON				0xa5
+#define CH1115_CMD_NORMAL				0xa6
+#define CH1115_CMD_INVERTED				0xa7
+#define CH1115_CMD_MUX_RATIO				0xa8
+#define CH1115_CMD_DC_DC				0xad
+#define CH1115_CMD_OFF					0xae
+#define CH1115_CMD_ON					0xaf
+#define CH1115_CMD_COM_REMAP_FLIP			0xc8
+#define CH1115_CMD_OFFSET				0xd3
+#define CH1115_CMD_CLOCK_DIVIDE_RATIO			0xd5
+#define CH1115_CMD_PRECHARGE_PERIOD			0xd9
+#define CH1115_CMD_VCOM_DESELECT_LVL			0xdb
+
+#define CH1115_SET_COLUMN_LSB(c)			(0x00 | FIELD_PREP(GENMASK(3, 0), (c)))
+#define CH1115_SET_COLUMN_MSB(c)			(0x10 | FIELD_PREP(GENMASK(2, 0), (c) >> 4))
+#define CH1115_SET_PAGE(p)				(0xb0 | FIELD_PREP(GENMASK(3, 0), (p)))
+
+#define DRIVER_NAME "ch1115"
+#define DRIVER_DESC "ch1115 DRM driver"
+#define DRIVER_MAJOR 1
+#define DRIVER_MINOR 0
+
+struct ch1115_device {
+	struct drm_device dev;
+
+	struct drm_plane primary_plane;
+	struct drm_crtc crtc;
+	struct drm_encoder encoder;
+	struct drm_connector connector;
+
+	struct drm_display_mode mode;
+
+	struct i2c_client *client;
+	struct regmap *regmap;
+
+	bool inverted;
+	u8 contrast;
+
+	u8 pages;
+	u8 first_page;
+	u8 bytes_per_row;
+
+	u8 width;
+	u8 height;
+	u32 width_mm;
+	u32 height_mm;
+	u8 x_start_offset;
+
+	u8 *hwbuf;
+	u8 *row;
+};
+
+static inline int ch1115_send_command_list(struct ch1115_device *ch1115,
+					   const u8 *cmd_list, size_t len)
+{
+	return regmap_bulk_write(ch1115->regmap, CH1115_COMMAND_MODE, cmd_list, len);
+}
+
+static inline int ch1115_draw_screen(struct ch1115_device *ch1115,
+				     const u8 *data, size_t len)
+{
+	return regmap_bulk_write(ch1115->regmap, CH1115_DATA_MODE, data, len);
+}
+
+static inline struct ch1115_device *drm_to_ch1115(struct drm_device *dev)
+{
+	return container_of(dev, struct ch1115_device, dev);
+}
+
+static int ch1115_set_position(struct ch1115_device *ch1115, int x, int y)
+{
+	u8 cmd_list[] = {
+		CH1115_SET_PAGE(y / CH1115_PAGE_HEIGHT),
+		CH1115_SET_COLUMN_LSB(x),
+		CH1115_SET_COLUMN_MSB(x),
+	};
+
+	return ch1115_send_command_list(ch1115, cmd_list, ARRAY_SIZE(cmd_list));
+}
+
+static void ch1115_shutdown(struct i2c_client *client)
+{
+	struct ch1115_device *ch1115 = i2c_get_clientdata(client);
+	struct drm_device *drm_dev = &ch1115->dev;
+
+	drm_atomic_helper_shutdown(drm_dev);
+}
+
+static int ch1115_clear_screen(struct ch1115_device *ch1115)
+{
+	int ret;
+	int y = 0;
+	char *row = ch1115->row;
+
+	for (int i = ch1115->x_start_offset; i < ch1115->width; i++)
+		row[i] = 0x00;
+
+	do {
+		ret = ch1115_set_position(ch1115, ch1115->x_start_offset, y);
+		if (ret < 0)
+			return ret;
+
+		ret = ch1115_draw_screen(ch1115, row + ch1115->x_start_offset, ch1115->width);
+		if (ret < 0)
+			return ret;
+
+		y += CH1115_PAGE_HEIGHT;
+	} while (y < ch1115->height);
+
+	return 0;
+}
+
+static int ch1115_oled_init(struct ch1115_device *ch1115)
+{
+	u8 commands[] = {
+		CH1115_CMD_OFF,
+
+		CH1115_CMD_CLOCK_DIVIDE_RATIO,
+		CH1115_VAL_CLOCK_DIVIDE_RATIO(CH1115_VAL_CLOCK_OSC_FREQ,
+					      CH1115_VAL_CLOCK_DIV_RATIO),
+
+		CH1115_CMD_MUX_RATIO,
+		ch1115->height - 1,
+
+		CH1115_CMD_OFFSET,
+		(u8)(ch1115->first_page * CH1115_PAGE_HEIGHT),
+
+		CH1115_CMD_START_LINE,
+
+		CH1115_CMD_DC_DC,
+		CH1115_VAL_DC_DC_ON,
+
+		CH1115_CMD_SEG_REMAP_FLIP,
+		CH1115_CMD_COM_REMAP_FLIP,
+
+		CH1115_CMD_CONTRAST,
+		ch1115->contrast,
+
+		CH1115_CMD_PRECHARGE_PERIOD,
+		CH1115_VAL_PRE_CHARGE_PERIOD,
+
+		CH1115_CMD_VCOM_DESELECT_LVL,
+		CH1115_VAL_VCOM_DESELECT_LVL,
+
+		CH1115_CMD_FOLLOW_RAM,
+
+		ch1115->inverted
+			? CH1115_CMD_INVERTED
+			: CH1115_CMD_NORMAL,
+	};
+
+	return ch1115_send_command_list(ch1115, commands, ARRAY_SIZE(commands));
+}
+
+static void ch1115_prepare_buffer(struct ch1115_device *ch1115,
+				  const struct iosys_map *vmap,
+				  struct drm_framebuffer *fb,
+				  struct drm_rect *rect,
+				  struct drm_format_conv_state *fmtcnv_state)
+{
+	unsigned int dst_pitch;
+	struct iosys_map dst;
+
+	dst_pitch = DIV_ROUND_UP(drm_rect_width(rect), 8);
+	iosys_map_set_vaddr(&dst, ch1115->hwbuf);
+
+	drm_fb_xrgb8888_to_mono(&dst, &dst_pitch, vmap, fb, rect, fmtcnv_state);
+}
+
+static inline u8 ch1115_transform_xy(const char *p, int x, int y, u8 bytes_per_row)
+{
+	int xrest = x % 8;
+	u8 result = 0;
+
+	/*
+	 * Transforms an (x, y) pixel coordinate into a vertical 8-bit
+	 * column from the framebuffer. It calculates the corresponding byte in the
+	 * framebuffer, extracts the bit at the given x position across 8 consecutive
+	 * rows, and packs those bits into a single byte.
+	 *
+	 * Return an 8-bit value representing a vertical column of pixels.
+	 */
+
+	x = x / 8;
+	y = (y / 8) * 8;
+
+	for (int i = 0; i < 8; i++) {
+		int row_idx = y + i;
+		u8 byte = p[row_idx * bytes_per_row + x];
+		u8 bit = (byte >> xrest) & 1;
+
+		result |= (bit << i);
+	}
+
+	return result;
+}
+
+static int ch1115_fb_update_rect(struct drm_framebuffer *fb, struct drm_rect *rect)
+{
+	struct ch1115_device *ch1115 = drm_to_ch1115(fb->dev);
+	char *row = ch1115->row;
+	int ret;
+
+	rect->y1 = round_down(rect->y1, CH1115_PAGE_HEIGHT);
+	rect->y2 = min_t(unsigned int, round_up(rect->y2, CH1115_PAGE_HEIGHT), ch1115->height);
+
+	for (int y = rect->y1; y < rect->y2; y += CH1115_PAGE_HEIGHT) {
+		for (int x = rect->x1; x < rect->x2; x++)
+			row[x] = ch1115_transform_xy(ch1115->hwbuf, x, y, ch1115->bytes_per_row);
+
+		ret = ch1115_set_position(ch1115, ch1115->x_start_offset + rect->x1, y);
+		if (ret < 0)
+			return ret;
+
+		ret = ch1115_draw_screen(ch1115, row + rect->x1, rect->x2 - rect->x1);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+
+/*
+ * DRM
+ */
+DEFINE_DRM_GEM_FOPS(ch1115_fops);
+static const struct drm_driver ch1115_driver = {
+	.driver_features = DRIVER_MODESET | DRIVER_GEM | DRIVER_ATOMIC,
+
+	.name		 = DRIVER_NAME,
+	.desc		 = DRIVER_DESC,
+	.major		 = DRIVER_MAJOR,
+	.minor		 = DRIVER_MINOR,
+
+	.fops		 = &ch1115_fops,
+	DRM_GEM_SHMEM_DRIVER_OPS,
+	DRM_FBDEV_SHMEM_DRIVER_OPS,
+};
+
+/*
+ * Modeset
+ */
+static struct drm_display_mode ch1115_mode(struct ch1115_device *ch1115)
+{
+	struct drm_display_mode mode = {
+		DRM_SIMPLE_MODE(ch1115->width, ch1115->height,
+				ch1115->width_mm, ch1115->height_mm),
+	};
+
+	return mode;
+}
+
+static const struct drm_mode_config_funcs ch1115_mode_config_funcs = {
+	.fb_create = drm_gem_fb_create_with_dirty,
+	.atomic_check = drm_atomic_helper_check,
+	.atomic_commit = drm_atomic_helper_commit,
+};
+
+static int ch1115_mode_config_init(struct ch1115_device *ch1115)
+{
+	struct drm_device *dev = &ch1115->dev;
+	int ret;
+
+	ret = drmm_mode_config_init(dev);
+	if (ret)
+		return ret;
+
+	dev->mode_config.min_width = ch1115->width;
+	dev->mode_config.min_height = ch1115->height;
+	dev->mode_config.max_width = CH1115_MAX_WIDTH;
+	dev->mode_config.max_height = CH1115_MAX_HEIGHT;
+	dev->mode_config.preferred_depth = 24;
+	dev->mode_config.funcs = &ch1115_mode_config_funcs;
+
+	return 0;
+}
+
+/*
+ * Plane
+ */
+static const struct drm_plane_funcs ch1115_primary_plane_funcs = {
+	.update_plane = drm_atomic_helper_update_plane,
+	.disable_plane = drm_atomic_helper_disable_plane,
+	.destroy = drm_plane_cleanup,
+	DRM_GEM_SHADOW_PLANE_FUNCS,
+};
+
+static int ch1115_primary_plane_helper_atomic_check(struct drm_plane *plane,
+						    struct drm_atomic_commit *state)
+{
+	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state, plane);
+	struct drm_crtc *new_crtc = new_plane_state->crtc;
+	struct drm_crtc_state *new_crtc_state = NULL;
+
+	if (new_crtc)
+		new_crtc_state = drm_atomic_get_new_crtc_state(state, new_crtc);
+
+	return drm_atomic_helper_check_plane_state(new_plane_state, new_crtc_state,
+						   DRM_PLANE_NO_SCALING,
+						   DRM_PLANE_NO_SCALING,
+						   false, false);
+}
+
+static void ch1115_primary_plane_helper_atomic_update(struct drm_plane *plane,
+						      struct drm_atomic_commit *state)
+{
+	struct drm_plane_state *old_plane_state = drm_atomic_get_old_plane_state(state, plane);
+	struct drm_plane_state *plane_state = drm_atomic_get_new_plane_state(state, plane);
+	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(plane_state);
+	struct drm_framebuffer *fb = plane_state->fb;
+	struct drm_atomic_helper_damage_iter iter;
+	struct drm_device *dev = plane->dev;
+	struct drm_rect damage;
+	struct ch1115_device *ch1115 = drm_to_ch1115(plane->dev);
+	int ret, idx;
+
+	if (!fb)
+		return;
+
+	ret = drm_gem_fb_begin_cpu_access(fb, DMA_FROM_DEVICE);
+	if (ret)
+		return;
+
+	if (!drm_dev_enter(dev, &idx))
+		goto out_drm_gem_fb_end_cpu_access;
+
+	drm_atomic_helper_damage_iter_init(&iter, old_plane_state, plane_state);
+	drm_atomic_for_each_plane_damage(&iter, &damage) {
+		ch1115_prepare_buffer(ch1115,
+				      &shadow_plane_state->data[0],
+				      fb, &damage,
+				      &shadow_plane_state->fmtcnv_state);
+
+		ch1115_fb_update_rect(fb, &damage);
+	}
+
+	drm_dev_exit(idx);
+
+out_drm_gem_fb_end_cpu_access:
+	drm_gem_fb_end_cpu_access(fb, DMA_FROM_DEVICE);
+}
+
+static void ch1115_primary_plane_helper_atomic_disable(struct drm_plane *plane,
+						       struct drm_atomic_commit *state)
+{
+	struct drm_device *dev = plane->dev;
+	struct ch1115_device *ch1115 = drm_to_ch1115(plane->dev);
+	int idx;
+
+	if (!drm_dev_enter(dev, &idx))
+		return;
+
+	ch1115_clear_screen(ch1115);
+	drm_dev_exit(idx);
+}
+
+static const struct drm_plane_helper_funcs ch1115_primary_plane_helper_funcs = {
+	DRM_GEM_SHADOW_PLANE_HELPER_FUNCS,
+	.atomic_check = ch1115_primary_plane_helper_atomic_check,
+	.atomic_update = ch1115_primary_plane_helper_atomic_update,
+	.atomic_disable = ch1115_primary_plane_helper_atomic_disable,
+};
+
+static const u64 ch1115_primary_plane_fmtmods[] = {
+	DRM_FORMAT_MOD_LINEAR,
+	DRM_FORMAT_MOD_INVALID
+};
+
+static const u32 ch1115_primary_plane_formats[] = {
+	DRM_FORMAT_XRGB8888,
+};
+
+static int ch1115_plane_init(struct ch1115_device *ch1115)
+{
+	struct drm_plane *plane = &ch1115->primary_plane;
+	struct drm_device *dev = &ch1115->dev;
+	int ret;
+
+	ret = drm_universal_plane_init(dev, plane, 0,
+				       &ch1115_primary_plane_funcs,
+				       ch1115_primary_plane_formats,
+				       ARRAY_SIZE(ch1115_primary_plane_formats),
+				       ch1115_primary_plane_fmtmods,
+				       DRM_PLANE_TYPE_PRIMARY, NULL);
+	if (ret)
+		return ret;
+
+	drm_plane_helper_add(plane, &ch1115_primary_plane_helper_funcs);
+	drm_plane_enable_fb_damage_clips(plane);
+
+	return 0;
+}
+
+/*
+ * CRTC
+ */
+static enum drm_mode_status ch1115_crtc_mode_valid(struct drm_crtc *crtc,
+						   const struct drm_display_mode *mode)
+{
+	struct ch1115_device *ch1115 = drm_to_ch1115(crtc->dev);
+
+	return drm_crtc_helper_mode_valid_fixed(crtc, mode, &ch1115->mode);
+}
+
+static const struct drm_crtc_helper_funcs ch1115_crtc_helper_funcs = {
+	.atomic_check = drm_crtc_helper_atomic_check,
+	.mode_valid = ch1115_crtc_mode_valid,
+};
+
+static const struct drm_crtc_funcs ch1115_crtc_funcs = {
+	.reset = drm_atomic_helper_crtc_reset,
+	.destroy = drm_crtc_cleanup,
+	.set_config = drm_atomic_helper_set_config,
+	.page_flip = drm_atomic_helper_page_flip,
+	.atomic_duplicate_state = drm_atomic_helper_crtc_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_crtc_destroy_state,
+};
+
+static int ch1115_crtc_init(struct ch1115_device *ch1115)
+{
+	struct drm_plane *primary_plane = &ch1115->primary_plane;
+	struct drm_crtc *crtc = &ch1115->crtc;
+	struct drm_device *dev = &ch1115->dev;
+	int ret;
+
+	ret = drm_crtc_init_with_planes(dev, crtc, primary_plane, NULL,
+					&ch1115_crtc_funcs, NULL);
+	if (ret)
+		return ret;
+
+	drm_crtc_helper_add(crtc, &ch1115_crtc_helper_funcs);
+
+	return 0;
+}
+
+/*
+ * Encoder
+ */
+static void ch1115_encoder_atomic_enable(struct drm_encoder *encoder,
+					 struct drm_atomic_commit *state)
+{
+	struct drm_device *drm = encoder->dev;
+	struct ch1115_device *ch1115 = drm_to_ch1115(drm);
+
+	ch1115_oled_init(ch1115);
+
+	u8 command = CH1115_CMD_ON;
+
+	ch1115_send_command_list(ch1115, &command, 1);
+}
+
+static void ch1115_encoder_atomic_disable(struct drm_encoder *encoder,
+					  struct drm_atomic_commit *state)
+{
+	struct drm_device *drm = encoder->dev;
+	struct ch1115_device *ch1115 = drm_to_ch1115(drm);
+
+	u8 command = CH1115_CMD_OFF;
+
+	ch1115_send_command_list(ch1115, &command, 1);
+}
+
+static const struct drm_encoder_funcs ch1115_encoder_funcs = {
+	.destroy = drm_encoder_cleanup,
+
+};
+
+static const struct drm_encoder_helper_funcs ch1115_encoder_helper_funcs = {
+	.atomic_enable = ch1115_encoder_atomic_enable,
+	.atomic_disable = ch1115_encoder_atomic_disable,
+};
+
+static int ch1115_encoder_init(struct ch1115_device *ch1115)
+{
+	struct drm_encoder *encoder = &ch1115->encoder;
+	struct drm_crtc *crtc = &ch1115->crtc;
+	struct drm_device *dev = &ch1115->dev;
+	int ret;
+
+	ret = drm_encoder_init(dev, encoder, &ch1115_encoder_funcs, DRM_MODE_ENCODER_NONE, NULL);
+	if (ret)
+		return ret;
+
+	drm_encoder_helper_add(encoder, &ch1115_encoder_helper_funcs);
+
+	encoder->possible_crtcs = drm_crtc_mask(crtc);
+
+	return 0;
+}
+
+/*
+ * Connector
+ */
+static int ch1115_connector_get_modes(struct drm_connector *conn)
+{
+	struct ch1115_device *ch1115 = drm_to_ch1115(conn->dev);
+
+	return drm_connector_helper_get_modes_fixed(conn, &ch1115->mode);
+}
+
+static const struct drm_connector_helper_funcs ch1115_connector_helper_funcs = {
+	.get_modes = ch1115_connector_get_modes,
+};
+
+static const struct drm_connector_funcs ch1115_connector_funcs = {
+	.reset = drm_atomic_helper_connector_reset,
+	.fill_modes = drm_helper_probe_single_connector_modes,
+	.destroy = drm_connector_cleanup,
+	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
+};
+
+static int ch1115_connector_init(struct ch1115_device *ch1115)
+{
+	struct drm_connector *connector = &ch1115->connector;
+	struct drm_encoder *encoder = &ch1115->encoder;
+	struct drm_device *dev = &ch1115->dev;
+	int ret;
+
+	ret = drm_connector_init(dev, connector, &ch1115_connector_funcs,
+				 DRM_MODE_CONNECTOR_Unknown);
+
+	if (ret)
+		return ret;
+
+	drm_connector_helper_add(connector, &ch1115_connector_helper_funcs);
+
+	return drm_connector_attach_encoder(connector, encoder);
+}
+
+/* The ch1115 driver does not read registers but regmap expects a .read */
+static int ch1115_regmap_read(void *context, const void *reg_buf,
+			      size_t reg_size, void *val_buf, size_t val_size)
+{
+	return -EOPNOTSUPP;
+}
+
+static int ch1115_regmap_write(void *context, const void *data, size_t count)
+{
+	struct i2c_client *client = context;
+	struct ch1115_device *ch1115 = i2c_get_clientdata(client);
+	int ret;
+
+	struct i2c_msg msg = {
+		.addr = ch1115->client->addr,
+		.len = count,
+		.buf = (u8 *)data,
+	};
+
+	ret = i2c_transfer(ch1115->client->adapter, &msg, 1);
+
+	return ret;
+}
+
+static const struct regmap_bus ch1115_regmap_bus = {
+	.read = ch1115_regmap_read,
+	.write = ch1115_regmap_write,
+};
+
+static const struct regmap_config ch1115_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+};
+
+static int ch1115_parse_dt(struct ch1115_device *ch1115)
+{
+	struct device *dev = &ch1115->client->dev;
+	struct device_node *np = dev->of_node;
+	struct display_timing dt;
+	int ret;
+	u32 val;
+
+	ret = of_property_read_u32(np, "first-page", &val);
+	if (ret) {
+		dev_err(dev, "Failed to get first-page from DT\n");
+		return ret;
+	}
+	if (val > CH1115_MAX_PAGES) {
+		dev_err(dev, "first-page=%d must be [0-%d]\n", val, CH1115_MAX_PAGES);
+		return -EINVAL;
+	}
+	ch1115->first_page = (u8)val;
+
+	ret = of_property_read_u32(np, "width-mm", &ch1115->width_mm);
+	if (ret) {
+		dev_err(dev, "Failed to get width-mm from DT\n");
+		return ret;
+	}
+	if (ch1115->width_mm == 0) {
+		dev_err(dev, "Invalid width-mm 0\n");
+		return -EINVAL;
+	}
+
+	ret = of_property_read_u32(np, "height-mm", &ch1115->height_mm);
+	if (ret) {
+		dev_err(dev, "Failed to get height-mm from DT\n");
+		return ret;
+	}
+	if (ch1115->height_mm == 0) {
+		dev_err(dev, "Invalid height-mm 0\n");
+		return -EINVAL;
+	}
+
+	ret = of_property_read_u32(np, "contrast", &val);
+	if (ret) {
+		ch1115->contrast = CH1115_VAL_CONTRAST;
+	} else {
+		if (val > CH1115_MAX_CONTRAST) {
+			dev_err(dev, "contrast=%d must be [0-%d]\n", val, CH1115_MAX_CONTRAST);
+			return -EINVAL;
+		}
+		ch1115->contrast = (u8)val;
+	}
+
+	ret = of_get_display_timing(np, "panel-timing", &dt);
+	if (ret) {
+		dev_err(dev, "Failed to get display timing from DT\n");
+		return ret;
+	}
+	if (dt.hactive.typ > CH1115_MAX_WIDTH) {
+		dev_err(dev, "width=%d must be less than %d\n", dt.hactive.typ, CH1115_MAX_WIDTH);
+		return -EINVAL;
+	}
+	if (dt.vactive.typ > CH1115_MAX_HEIGHT) {
+		dev_err(dev, "height=%d must be less than %d\n", dt.vactive.typ, CH1115_MAX_HEIGHT);
+		return -EINVAL;
+	}
+
+	ch1115->width = dt.hactive.typ;
+	ch1115->height = dt.vactive.typ;
+
+	ch1115->inverted = of_property_read_bool(np, "inverted");
+
+	return 0;
+}
+
+static int ch1115_probe(struct i2c_client *client)
+{
+	struct ch1115_device *ch1115;
+	int ret;
+
+	ch1115 = devm_drm_dev_alloc(&client->dev, &ch1115_driver,
+				    struct ch1115_device, dev);
+	if (IS_ERR(ch1115))
+		return PTR_ERR(ch1115);
+
+	i2c_set_clientdata(client, ch1115);
+
+	ch1115->client = client;
+	ch1115->regmap = devm_regmap_init(&client->dev, &ch1115_regmap_bus,
+					  client, &ch1115_regmap_config);
+	if (IS_ERR(ch1115->regmap)) {
+		return dev_err_probe(&client->dev, PTR_ERR(ch1115->regmap),
+				     "Failed to initialize regmap\n");
+	}
+
+	ret = ch1115_parse_dt(ch1115);
+	if (ret) {
+		return dev_err_probe(&client->dev, ret,
+				     "Failed to parse DT\n");
+	}
+
+	ch1115->pages = DIV_ROUND_UP(ch1115->height, CH1115_PAGE_HEIGHT);
+	ch1115->bytes_per_row = ch1115->width / 8;
+	ch1115->x_start_offset = CH1115_MAX_WIDTH - ch1115->width;
+	ch1115->mode = ch1115_mode(ch1115);
+
+	ch1115->hwbuf = devm_kzalloc(&client->dev,
+				     ch1115->pages * ch1115->width,
+				     GFP_KERNEL);
+	if (!ch1115->hwbuf)
+		return -ENOMEM;
+
+	ch1115->row = devm_kzalloc(&client->dev, ch1115->width, GFP_KERNEL);
+	if (!ch1115->row)
+		return -ENOMEM;
+
+	// DRM
+	ret = ch1115_mode_config_init(ch1115);
+	if (ret)
+		return dev_err_probe(&client->dev, ret,
+				     "Failed to initialize mode config\n");
+
+	ret = ch1115_plane_init(ch1115);
+	if (ret)
+		return dev_err_probe(&client->dev, ret,
+				     "Failed to initialize primary plane\n");
+
+	ret = ch1115_crtc_init(ch1115);
+	if (ret < 0)
+		return dev_err_probe(&client->dev, ret,
+				     "Failed to initialize CRTC\n");
+
+	ret = ch1115_encoder_init(ch1115);
+	if (ret < 0)
+		return dev_err_probe(&client->dev, ret,
+				     "Failed to initialize encoder\n");
+
+	ret = ch1115_connector_init(ch1115);
+	if (ret < 0)
+		return dev_err_probe(&client->dev, ret,
+				     "Failed to initialize connector\n");
+
+	drm_mode_config_reset(&ch1115->dev);
+
+	ret = drm_dev_register(&ch1115->dev, 0);
+	if (ret)
+		return dev_err_probe(&client->dev, ret,
+				     "Failed to register DRM device\n");
+
+	drm_client_setup(&ch1115->dev, NULL);
+
+	return 0;
+}
+
+static void ch1115_remove(struct i2c_client *client)
+{
+	struct ch1115_device *ch1115 = i2c_get_clientdata(client);
+	int ret;
+
+	u8 cmd_list[] = {
+		CH1115_CMD_OFF,
+
+		CH1115_CMD_ALL_ON,
+
+		CH1115_CMD_DC_DC,
+		CH1115_VAL_DC_DC_OFF,
+	};
+
+	ret = ch1115_send_command_list(ch1115, cmd_list, ARRAY_SIZE(cmd_list));
+	if (ret < 0)
+		dev_err(&client->dev, "There was an error executing the shutdown commands");
+
+	usleep_range(10000, 15000);
+
+	drm_dev_unplug(&ch1115->dev);
+}
+
+static const struct i2c_device_id ch1115_id[] = {
+	{ .name = "ch1115" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, ch1115_id);
+
+static const struct of_device_id ch1115_of_match[] = {
+	{ .compatible = "chipwealth,ch1115" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ch1115_of_match);
+
+static struct i2c_driver ch1115_i2c_driver = {
+	.driver = {
+		.name	= DRIVER_NAME,
+		.of_match_table = ch1115_of_match,
+	},
+	.probe		= ch1115_probe,
+	.remove		= ch1115_remove,
+	.shutdown	= ch1115_shutdown,
+	.id_table	= ch1115_id,
+};
+module_i2c_driver(ch1115_i2c_driver);
+
+MODULE_DESCRIPTION(DRIVER_DESC);
+MODULE_AUTHOR("Nicolás Antinori <nico.antinori.7@gmail.com>");
+MODULE_LICENSE("GPL");
--
2.47.3

