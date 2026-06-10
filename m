Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 394DCCD98D2
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 10:49:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 755F210EE5D;
	Thu, 11 Jun 2026 10:49:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VVhTHTge";
	dkim-atps=neutral
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B8A410E500
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 16:45:00 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-45eeea039ebso3782661f8f.1
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 09:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781109899; x=1781714699; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c7HItPVxnVRozeOhp3gwZ6pCwsxCX0V99f8c8hJsh70=;
 b=VVhTHTgeOutxa/WZYbLXZSVrAxY8eaw1HtMCKEy/Yudwy1s5mh8WwDdLBi5P2Tl+T3
 bM4bO9mz3JEGU8CgvyksG8GNfg9hkyTEIOd5QePNwhY2MWcj3Oo6xlGBTS3Pb0RRmqdG
 Xd/cfUVKArKHPzlfYxrUxJlfsWyNepDvSWAQn+jX5fqh8gdRZ/t8Zsz4G1caxz+kLmXP
 FjbiBblRC6zOuPq3JdgeDeEYR9LnBJ1u6HRzXBNqXA92YOHBcqKmx69uTs5izgl9VsgM
 UuQeHzVDnALb7ZmyEO7QkgnmyjAM6cp6W2rNa549qL9BNQKKd3b2jd3ZX6lkN7u9CcL3
 lPAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781109899; x=1781714699;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=c7HItPVxnVRozeOhp3gwZ6pCwsxCX0V99f8c8hJsh70=;
 b=HZhtR4yL+3m9h0nBBVtJRHKuOSGK5OyuU9hvW7a3GVKDKwpEHTV9kITYiPJzYBxUyg
 t8dmtPRWsp3vgyar3QAgE5cTLCKxKRJnPOX0GYin3+Dr3f1vFKenrOvBhPnqTYPzzAtY
 jU7eJoX08JzldWSMmJo1MH2zlXU5VH+dtH52K85sBRNS9F/Vd9Jkl8F9iVY8cgflOCN4
 viQO0IQJhNGc+c0QudblGOEUwdNQjZg4kK312Ww8bcmx7vLxNbKh62o4LwYIHQtYV039
 afhUcZSacb30dANKm9nPpu+eyS6eQw7AWrc9BwqqENJH1TBGI7s3ru+zo8Zd8jZrJrqp
 oQJg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/7VdEL4BEWHGEKMWmcAiGvu2GkES4cNood/Vqj2dxAnzjiyXteAtoIt1QM9Kv2f7wX/P+ZZWI8caI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyKu+TEn02jdMx6tJtnDOCy2g8UAmi3o4FGJmBI5FdSKhMCqd3S
 M5Cuhicy6WmCEWZI8Gm6CEZeLPQFs4TBzmidrq2TCRRxLg7tufnidgDC
X-Gm-Gg: Acq92OFwypl421eL66ojsEhkVY6JOx9Nfq45Kz1i7+53GmEif/OoBF6nekGEpd2X9Mg
 Oe9QgUel6wgHgKnlEqYe7pKKWelMzBCjwPO0cDT/qbkWKwPFJelvnXimLRwtXiENPOVldBiYn/I
 J+g4s5SsuoQPHRaIBk4DCY8vI7g2MJA1EzVi2HTN77azOwYnp/1V75M7LWA2eT3Zt1k9vchR3Wy
 b6RO1BIxcTaHX20oTu1Hg7vpxyZ+QmdSmKT5EF9lZSk1Hh5+08+5jO3kPzez9UVjR6xInyQ8VkR
 lAXypvejhkcou/hGaj8nJX9uYFVulZEs+nilH9eS2pBSZFrRmO0pZD5cy+/MqdmEfizuAM4bnBB
 4mPV9RmvhFlxliGk2bUnEgusqpgwWY9mEfFEiy3VfuZc9G/cc45iIc2Ib2CK4Uw5HaXTzwsSa0U
 4CgqkwI/3Oz1dPdyAxLc8z+zNSA3yYWFinqfSBRBr/
X-Received: by 2002:a5d:6610:0:b0:45e:fa38:c899 with SMTP id
 ffacd0b85a97d-460302dc4dbmr28725978f8f.4.1781109898593; 
 Wed, 10 Jun 2026 09:44:58 -0700 (PDT)
Received: from anthony ([2a06:c701:9cfb:2900:12ff:e0ff:fea5:3d2e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46028a6dcbdsm61156733f8f.7.2026.06.10.09.44.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 09:44:57 -0700 (PDT)
From: Amit Barzilai <amit.barzilai22@gmail.com>
To: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch
Cc: javierm@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Amit Barzilai <amit.barzilai22@gmail.com>
Subject: [PATCH 2/2] drm/solomon: Add SSD1351 OLED display driver
Date: Wed, 10 Jun 2026 19:44:28 +0300
Message-ID: <20260610164428.180091-3-amit.barzilai22@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260610164428.180091-1-amit.barzilai22@gmail.com>
References: <20260610164428.180091-1-amit.barzilai22@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 11 Jun 2026 10:49:05 +0000
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

Add a DRM/KMS driver for the Solomon SSD1351, a 128x128 65k-color RGB
OLED controller driven over a 4-wire SPI bus (clock, data, chip-select
and a Data/Command GPIO).

Unlike the monochrome and grayscale SSD13xx parts handled by the ssd130x
driver, the SSD1351 has a native 16-bit RGB565 frame format, so the
driver uploads pixels as RGB565 rather than down-converting to RGB332.
Its command set (column/row range 0x15/0x75, write-RAM 0x5c) differs from
MIPI DCS, so the generic mipi_dbi helpers cannot be reused for the pixel
path and a small SPI command/data layer is implemented instead.

The driver advertises XRGB8888 to userspace and converts to big-endian
RGB565 on flush via drm_fb_xrgb8888_to_rgb565be(), building on the GEM
SHMEM and atomic modeset/shadow-plane helpers with damage-clipped partial
updates. Panels wired with a BGR sub-pixel order are handled through the
colour remap register.

Also add the DRM_SSD1351 Kconfig/Makefile entries and a MAINTAINERS
record.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Amit Barzilai <amit.barzilai22@gmail.com>
---
 MAINTAINERS                       |   7 +
 drivers/gpu/drm/solomon/Kconfig   |  14 +
 drivers/gpu/drm/solomon/Makefile  |   1 +
 drivers/gpu/drm/solomon/ssd1351.c | 556 ++++++++++++++++++++++++++++++
 4 files changed, 578 insertions(+)
 create mode 100644 drivers/gpu/drm/solomon/ssd1351.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 8e80296449ba..1e2b662c5aed 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8377,6 +8377,13 @@ F:	Documentation/devicetree/bindings/display/solomon,ssd-common.yaml
 F:	Documentation/devicetree/bindings/display/solomon,ssd13*.yaml
 F:	drivers/gpu/drm/solomon/ssd130x*
 
+DRM DRIVER FOR SOLOMON SSD1351 OLED DISPLAYS
+M:	Amit Barzilai <amit.barzilai22@gmail.com>
+S:	Maintained
+T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
+F:	Documentation/devicetree/bindings/display/solomon,ssd1351.yaml
+F:	drivers/gpu/drm/solomon/ssd1351.c
+
 DRM DRIVER FOR ST-ERICSSON MCDE
 M:	Linus Walleij <linusw@kernel.org>
 S:	Maintained
diff --git a/drivers/gpu/drm/solomon/Kconfig b/drivers/gpu/drm/solomon/Kconfig
index 400a6cab3a67..957dc36dc495 100644
--- a/drivers/gpu/drm/solomon/Kconfig
+++ b/drivers/gpu/drm/solomon/Kconfig
@@ -30,3 +30,17 @@ config DRM_SSD130X_SPI
 	  Say Y here if the SSD13xx OLED display is connected via SPI bus.
 
 	  If M is selected the module will be called ssd130x-spi.
+
+config DRM_SSD1351
+	tristate "DRM support for Solomon SSD1351 OLED displays"
+	depends on DRM && SPI && MMU
+	select DRM_CLIENT_SELECTION
+	select DRM_GEM_SHMEM_HELPER
+	select DRM_KMS_HELPER
+	help
+	  DRM driver for the Solomon SSD1351 RGB565 color OLED controller
+	  connected via 4-wire SPI. It drives up to a 128x128 65k-color
+	  panel and uploads pixels in the controller's native RGB565
+	  format, exposing a standard DRM/KMS device to userspace.
+
+	  If M is selected the module will be called ssd1351.
diff --git a/drivers/gpu/drm/solomon/Makefile b/drivers/gpu/drm/solomon/Makefile
index b5fc792257d7..35ca60e4cf36 100644
--- a/drivers/gpu/drm/solomon/Makefile
+++ b/drivers/gpu/drm/solomon/Makefile
@@ -1,3 +1,4 @@
 obj-$(CONFIG_DRM_SSD130X)	+= ssd130x.o
 obj-$(CONFIG_DRM_SSD130X_I2C)	+= ssd130x-i2c.o
 obj-$(CONFIG_DRM_SSD130X_SPI)	+= ssd130x-spi.o
+obj-$(CONFIG_DRM_SSD1351)	+= ssd1351.o
diff --git a/drivers/gpu/drm/solomon/ssd1351.c b/drivers/gpu/drm/solomon/ssd1351.c
new file mode 100644
index 000000000000..7c4a5c461afb
--- /dev/null
+++ b/drivers/gpu/drm/solomon/ssd1351.c
@@ -0,0 +1,556 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * DRM driver for the Solomon SSD1351 RGB565 color OLED controller
+ *
+ * The SSD1351 drives up to a 128x128 65k-color OLED panel over a 4-wire
+ * SPI bus (clock, data, chip-select and a Data/Command GPIO). Unlike the
+ * monochrome and grayscale SSD13xx parts handled by the ssd130x driver,
+ * the SSD1351 has a native 16-bit RGB565 frame format, so this driver
+ * uploads pixels as RGB565 rather than down-converting to RGB332.
+ *
+ * The command set (column/row range 0x15/0x75, write-RAM 0x5c) differs
+ * from MIPI DCS, so the generic mipi_dbi helpers cannot be reused for the
+ * pixel path; a small SPI command/data layer is implemented here instead.
+ *
+ * Author: Amit Barzilai <amit.barzilai22@gmail.com>
+ */
+
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/module.h>
+#include <linux/property.h>
+#include <linux/spi/spi.h>
+
+#include <drm/clients/drm_client_setup.h>
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_damage_helper.h>
+#include <drm/drm_atomic.h>
+#include <drm/drm_drv.h>
+#include <drm/drm_crtc_helper.h>
+#include <drm/drm_fbdev_shmem.h>
+#include <drm/drm_format_helper.h>
+#include <drm/drm_gem_atomic_helper.h>
+#include <drm/drm_gem_shmem_helper.h>
+#include <drm/drm_gem_framebuffer_helper.h>
+#include <drm/drm_managed.h>
+#include <drm/drm_modeset_helper.h>
+#include <drm/drm_probe_helper.h>
+#include <drm/drm_print.h>
+#include <drm/drm_rect.h>
+
+#define SSD1351_WIDTH 128
+#define SSD1351_HEIGHT 128
+
+/* Commands */
+#define SSD1351_SET_COL_ADDRESS 0x15
+#define SSD1351_WRITE_RAM 0x5c
+#define SSD1351_SET_ROW_ADDRESS 0x75
+#define SSD1351_SET_REMAP 0xa0
+#define SSD1351_SET_START_LINE 0xa1
+#define SSD1351_SET_DISPLAY_OFFSET 0xa2
+#define SSD1351_SET_DISPLAY_NORMAL 0xa6
+#define SSD1351_SET_FUNCTION 0xab
+#define SSD1351_SET_DISPLAY_OFF 0xae
+#define SSD1351_SET_DISPLAY_ON 0xaf
+#define SSD1351_SET_PHASE_LENGTH 0xb1
+#define SSD1351_SET_CLOCK_DIV 0xb3
+#define SSD1351_SET_VSL 0xb4
+#define SSD1351_SET_GPIO 0xb5
+#define SSD1351_SET_PRECHARGE2 0xb6
+#define SSD1351_SET_PRECHARGE 0xbb
+#define SSD1351_SET_VCOMH 0xbe
+#define SSD1351_SET_CONTRAST 0xc1
+#define SSD1351_SET_CONTRAST_MASTER 0xc7
+#define SSD1351_SET_MUX_RATIO 0xca
+#define SSD1351_SET_COMMAND_LOCK 0xfd
+
+/* Re-map / Color Depth (command 0xa0) bits */
+#define SSD1351_REMAP_COLUMN BIT(1) /* reverse column (SEG) order */
+#define SSD1351_REMAP_COLOR_BGR BIT(2) /* swap sub-pixel color order */
+#define SSD1351_REMAP_COM_SCAN BIT(4) /* reverse COM scan direction */
+#define SSD1351_REMAP_COM_SPLIT BIT(5) /* odd/even COM split */
+#define SSD1351_REMAP_65K BIT(6) /* 65k (RGB565) color depth */
+
+struct ssd1351_device {
+	struct drm_device drm;
+	struct spi_device *spi;
+	struct gpio_desc *reset;
+	struct gpio_desc *dc;
+	u32 rotation;
+
+	/* Scratch buffer holding one frame of RGB565 pixels for SPI upload */
+	u8 *tx_buf;
+
+	struct drm_plane plane;
+	struct drm_crtc crtc;
+	struct drm_encoder encoder;
+	struct drm_connector connector;
+};
+
+static struct ssd1351_device *drm_to_ssd1351(struct drm_device *drm)
+{
+	return container_of(drm, struct ssd1351_device, drm);
+}
+
+/*
+ * SPI access. The D/C GPIO selects whether the bytes shifted out are
+ * interpreted as a command (low) or as data (high).
+ */
+static int ssd1351_write_cmd(struct ssd1351_device *ssd1351, u8 cmd,
+			     const u8 *params, size_t num)
+{
+	int ret;
+
+	gpiod_set_value_cansleep(ssd1351->dc, 0);
+	ret = spi_write(ssd1351->spi, &cmd, 1);
+	if (ret)
+		return ret;
+
+	if (num) {
+		gpiod_set_value_cansleep(ssd1351->dc, 1);
+		ret = spi_write(ssd1351->spi, params, num);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+/* Send a command followed by a fixed list of single-byte parameters. */
+#define ssd1351_command(ssd1351, cmd, ...)                   \
+	({                                                   \
+		static const u8 _params[] = { __VA_ARGS__ }; \
+		ssd1351_write_cmd((ssd1351), (cmd), _params, \
+				  ARRAY_SIZE(_params));      \
+	})
+
+static void ssd1351_reset(struct ssd1351_device *ssd1351)
+{
+	if (!ssd1351->reset)
+		return;
+
+	/*
+	 * Work in logical levels: 1 asserts reset, 0 releases it. The DT's
+	 * GPIO_ACTIVE_LOW flag handles the physical inversion, so this pulse is
+	 * correct regardless of how the board wires the RES# line.
+	 */
+	gpiod_set_value_cansleep(ssd1351->reset, 1);
+	usleep_range(20, 1000);
+	gpiod_set_value_cansleep(ssd1351->reset, 0);
+	msleep(120);
+}
+
+static int ssd1351_init_display(struct ssd1351_device *ssd1351)
+{
+	u8 remap = SSD1351_REMAP_65K | SSD1351_REMAP_COM_SPLIT |
+		   SSD1351_REMAP_COLOR_BGR;
+	int ret;
+
+	ssd1351_reset(ssd1351);
+
+	/* Unlock the controller and allow access to all command registers */
+	ret = ssd1351_command(ssd1351, SSD1351_SET_COMMAND_LOCK, 0x12);
+	if (ret)
+		return ret;
+	ret = ssd1351_command(ssd1351, SSD1351_SET_COMMAND_LOCK, 0xb1);
+	if (ret)
+		return ret;
+
+	ret = ssd1351_command(ssd1351, SSD1351_SET_DISPLAY_OFF);
+	if (ret)
+		return ret;
+
+	ret = ret ?: ssd1351_command(ssd1351, SSD1351_SET_CLOCK_DIV, 0xf1);
+	ret = ret ?: ssd1351_command(ssd1351, SSD1351_SET_MUX_RATIO, 0x7f);
+	ret = ret ?: ssd1351_command(ssd1351, SSD1351_SET_COL_ADDRESS, 0x00, 0x7f);
+	ret = ret ?: ssd1351_command(ssd1351, SSD1351_SET_ROW_ADDRESS, 0x00, 0x7f);
+	ret = ret ?: ssd1351_command(ssd1351, SSD1351_SET_START_LINE, 0x00);
+	ret = ret ?: ssd1351_command(ssd1351, SSD1351_SET_DISPLAY_OFFSET, 0x00);
+	ret = ret ?: ssd1351_command(ssd1351, SSD1351_SET_GPIO, 0x00);
+	ret = ret ?: ssd1351_command(ssd1351, SSD1351_SET_FUNCTION, 0x01);
+	ret = ret ?: ssd1351_command(ssd1351, SSD1351_SET_PHASE_LENGTH, 0x32);
+	ret = ret ?: ssd1351_command(ssd1351, SSD1351_SET_VSL, 0xa0, 0xb5, 0x55);
+	ret = ret ?: ssd1351_command(ssd1351, SSD1351_SET_PRECHARGE, 0x17);
+	ret = ret ?: ssd1351_command(ssd1351, SSD1351_SET_VCOMH, 0x05);
+	ret = ret ?: ssd1351_command(ssd1351, SSD1351_SET_CONTRAST, 0xc8, 0x80, 0xc8);
+	ret = ret ?: ssd1351_command(ssd1351, SSD1351_SET_CONTRAST_MASTER, 0x0f);
+	ret = ret ?: ssd1351_command(ssd1351, SSD1351_SET_PRECHARGE2, 0x01);
+	ret = ret ?: ssd1351_command(ssd1351, SSD1351_SET_DISPLAY_NORMAL);
+	if (ret)
+		return ret;
+
+	/*
+	 * Select 65k (RGB565) color depth and the orientation. 0 and 180 degrees
+	 * are reached with the column/COM-scan mirror bits while keeping the
+	 * controller in horizontal address-increment mode, which matches the
+	 * row-major pixel data produced below. The hardware can also rotate by
+	 * 90/270 via the vertical address-increment bit, but that transposes the
+	 * upload and would require a transposing blit + window remap that this
+	 * driver does not implement; such rotations are rejected at probe.
+	 */
+	if (ssd1351->rotation == 180)
+		remap |= SSD1351_REMAP_COLUMN;
+	else
+		remap |= SSD1351_REMAP_COM_SCAN;
+
+	ret = ssd1351_write_cmd(ssd1351, SSD1351_SET_REMAP, &remap, 1);
+	if (ret)
+		return ret;
+
+	return ssd1351_command(ssd1351, SSD1351_SET_DISPLAY_ON);
+}
+
+static void ssd1351_fb_blit_rect(struct ssd1351_device *ssd1351,
+				 struct drm_framebuffer *fb,
+				 const struct iosys_map *vmap,
+				 struct drm_rect *rect,
+				 struct drm_format_conv_state *fmtcnv_state)
+{
+	unsigned int width = drm_rect_width(rect);
+	unsigned int height = drm_rect_height(rect);
+	unsigned int dst_pitch = width * sizeof(u16);
+	struct iosys_map dst;
+	u8 range[2];
+
+	iosys_map_set_vaddr(&dst, ssd1351->tx_buf);
+
+	/*
+	 * The panel expects RGB565 most-significant byte first; the big-endian
+	 * conversion produces exactly that byte stream for the 8-bit SPI words.
+	 */
+	drm_fb_xrgb8888_to_rgb565be(&dst, &dst_pitch, vmap, fb, rect,
+				    fmtcnv_state);
+
+	range[0] = rect->x1;
+	range[1] = rect->x2 - 1;
+	if (ssd1351_write_cmd(ssd1351, SSD1351_SET_COL_ADDRESS, range,
+			      sizeof(range)))
+		return;
+
+	range[0] = rect->y1;
+	range[1] = rect->y2 - 1;
+	if (ssd1351_write_cmd(ssd1351, SSD1351_SET_ROW_ADDRESS, range,
+			      sizeof(range)))
+		return;
+
+	ssd1351_write_cmd(ssd1351, SSD1351_WRITE_RAM, ssd1351->tx_buf,
+			  width * height * sizeof(u16));
+}
+
+/*
+ * Plane
+ */
+
+static int ssd1351_plane_atomic_check(struct drm_plane *plane,
+				      struct drm_atomic_state *state)
+{
+	struct drm_plane_state *plane_state =
+		drm_atomic_get_new_plane_state(state, plane);
+	struct drm_crtc *crtc = plane_state->crtc;
+	struct drm_crtc_state *crtc_state = NULL;
+
+	if (crtc)
+		crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
+
+	return drm_atomic_helper_check_plane_state(plane_state, crtc_state,
+						   DRM_PLANE_NO_SCALING,
+						   DRM_PLANE_NO_SCALING, false,
+						   false);
+}
+
+static void ssd1351_plane_atomic_update(struct drm_plane *plane,
+					struct drm_atomic_state *state)
+{
+	struct drm_plane_state *plane_state =
+		drm_atomic_get_new_plane_state(state, plane);
+	struct drm_plane_state *old_plane_state =
+		drm_atomic_get_old_plane_state(state, plane);
+	struct drm_shadow_plane_state *shadow_plane_state =
+		to_drm_shadow_plane_state(plane_state);
+	struct ssd1351_device *ssd1351 = drm_to_ssd1351(plane->dev);
+	struct drm_framebuffer *fb = plane_state->fb;
+	struct drm_atomic_helper_damage_iter iter;
+	struct drm_rect damage;
+	struct drm_rect dst_clip;
+	int idx;
+
+	if (!fb)
+		return;
+
+	if (!drm_dev_enter(&ssd1351->drm, &idx))
+		return;
+
+	if (drm_gem_fb_begin_cpu_access(fb, DMA_FROM_DEVICE))
+		goto out_drm_dev_exit;
+
+	drm_atomic_helper_damage_iter_init(&iter, old_plane_state, plane_state);
+	drm_atomic_for_each_plane_damage(&iter, &damage) {
+		dst_clip = plane_state->dst;
+
+		if (!drm_rect_intersect(&dst_clip, &damage))
+			continue;
+
+		ssd1351_fb_blit_rect(ssd1351, fb, &shadow_plane_state->data[0],
+				     &dst_clip,
+				     &shadow_plane_state->fmtcnv_state);
+	}
+
+	drm_gem_fb_end_cpu_access(fb, DMA_FROM_DEVICE);
+
+out_drm_dev_exit:
+	drm_dev_exit(idx);
+}
+
+static const struct drm_plane_helper_funcs ssd1351_plane_helper_funcs = {
+	DRM_GEM_SHADOW_PLANE_HELPER_FUNCS,
+	.atomic_check = ssd1351_plane_atomic_check,
+	.atomic_update = ssd1351_plane_atomic_update,
+};
+
+static const struct drm_plane_funcs ssd1351_plane_funcs = {
+	DRM_GEM_SHADOW_PLANE_FUNCS,
+	.update_plane = drm_atomic_helper_update_plane,
+	.disable_plane = drm_atomic_helper_disable_plane,
+	.destroy = drm_plane_cleanup,
+};
+
+static const u32 ssd1351_formats[] = {
+	DRM_FORMAT_XRGB8888,
+};
+
+/*
+ * CRTC
+ */
+
+static void ssd1351_crtc_atomic_enable(struct drm_crtc *crtc,
+				       struct drm_atomic_state *state)
+{
+	struct ssd1351_device *ssd1351 = drm_to_ssd1351(crtc->dev);
+	int idx, ret;
+
+	if (!drm_dev_enter(crtc->dev, &idx))
+		return;
+
+	ret = ssd1351_init_display(ssd1351);
+	if (ret)
+		drm_err(crtc->dev, "Failed to initialize display: %d\n", ret);
+
+	drm_dev_exit(idx);
+}
+
+static void ssd1351_crtc_atomic_disable(struct drm_crtc *crtc,
+					struct drm_atomic_state *state)
+{
+	struct ssd1351_device *ssd1351 = drm_to_ssd1351(crtc->dev);
+	int idx;
+
+	if (!drm_dev_enter(crtc->dev, &idx))
+		return;
+
+	ssd1351_command(ssd1351, SSD1351_SET_DISPLAY_OFF);
+
+	drm_dev_exit(idx);
+}
+
+static const struct drm_crtc_helper_funcs ssd1351_crtc_helper_funcs = {
+	.atomic_check = drm_crtc_helper_atomic_check,
+	.atomic_enable = ssd1351_crtc_atomic_enable,
+	.atomic_disable = ssd1351_crtc_atomic_disable,
+};
+
+static const struct drm_crtc_funcs ssd1351_crtc_funcs = {
+	.reset = drm_atomic_helper_crtc_reset,
+	.destroy = drm_crtc_cleanup,
+	.set_config = drm_atomic_helper_set_config,
+	.page_flip = drm_atomic_helper_page_flip,
+	.atomic_duplicate_state = drm_atomic_helper_crtc_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_crtc_destroy_state,
+};
+
+/*
+ * Encoder
+ */
+
+static const struct drm_encoder_funcs ssd1351_encoder_funcs = {
+	.destroy = drm_encoder_cleanup,
+};
+
+/*
+ * Connector
+ */
+
+static const struct drm_display_mode ssd1351_mode = {
+	DRM_SIMPLE_MODE(SSD1351_WIDTH, SSD1351_HEIGHT, 24, 24),
+};
+
+static int ssd1351_connector_get_modes(struct drm_connector *connector)
+{
+	return drm_connector_helper_get_modes_fixed(connector, &ssd1351_mode);
+}
+
+static const struct drm_connector_helper_funcs ssd1351_connector_helper_funcs = {
+	.get_modes = ssd1351_connector_get_modes,
+};
+
+static const struct drm_connector_funcs ssd1351_connector_funcs = {
+	.reset = drm_atomic_helper_connector_reset,
+	.fill_modes = drm_helper_probe_single_connector_modes,
+	.destroy = drm_connector_cleanup,
+	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
+};
+
+static const struct drm_mode_config_funcs ssd1351_mode_config_funcs = {
+	.fb_create = drm_gem_fb_create_with_dirty,
+	.atomic_check = drm_atomic_helper_check,
+	.atomic_commit = drm_atomic_helper_commit,
+};
+
+/*
+ * Driver
+ */
+
+DEFINE_DRM_GEM_FOPS(ssd1351_fops);
+
+static const struct drm_driver ssd1351_driver = {
+	.driver_features = DRIVER_GEM | DRIVER_MODESET | DRIVER_ATOMIC,
+	.fops = &ssd1351_fops,
+	DRM_GEM_SHMEM_DRIVER_OPS,
+	DRM_FBDEV_SHMEM_DRIVER_OPS,
+	.name = "ssd1351",
+	.desc = "Solomon SSD1351",
+	.major = 1,
+	.minor = 0,
+};
+
+static int ssd1351_probe(struct spi_device *spi)
+{
+	struct device *dev = &spi->dev;
+	struct ssd1351_device *ssd1351;
+	struct drm_device *drm;
+	int ret;
+
+	ssd1351 = devm_drm_dev_alloc(dev, &ssd1351_driver,
+				     struct ssd1351_device, drm);
+	if (IS_ERR(ssd1351))
+		return PTR_ERR(ssd1351);
+
+	drm = &ssd1351->drm;
+	ssd1351->spi = spi;
+	spi_set_drvdata(spi, drm);
+
+	ssd1351->reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(ssd1351->reset))
+		return dev_err_probe(dev, PTR_ERR(ssd1351->reset),
+				     "Failed to get reset GPIO\n");
+
+	ssd1351->dc = devm_gpiod_get(dev, "dc", GPIOD_OUT_LOW);
+	if (IS_ERR(ssd1351->dc))
+		return dev_err_probe(dev, PTR_ERR(ssd1351->dc),
+				     "Failed to get D/C GPIO\n");
+
+	device_property_read_u32(dev, "rotation", &ssd1351->rotation);
+	if (ssd1351->rotation != 0 && ssd1351->rotation != 180)
+		return dev_err_probe(dev, -EINVAL,
+				     "Unsupported rotation %u; only 0 and 180 are supported\n",
+				     ssd1351->rotation);
+
+	ssd1351->tx_buf = devm_kmalloc(dev,
+				       SSD1351_WIDTH * SSD1351_HEIGHT * sizeof(u16),
+				       GFP_KERNEL);
+	if (!ssd1351->tx_buf)
+		return -ENOMEM;
+
+	ret = drmm_mode_config_init(drm);
+	if (ret)
+		return ret;
+
+	drm->mode_config.min_width = SSD1351_WIDTH;
+	drm->mode_config.max_width = SSD1351_WIDTH;
+	drm->mode_config.min_height = SSD1351_HEIGHT;
+	drm->mode_config.max_height = SSD1351_HEIGHT;
+	drm->mode_config.preferred_depth = 24;
+	drm->mode_config.funcs = &ssd1351_mode_config_funcs;
+
+	ret = drm_universal_plane_init(drm, &ssd1351->plane, 0,
+				       &ssd1351_plane_funcs, ssd1351_formats,
+				       ARRAY_SIZE(ssd1351_formats), NULL,
+				       DRM_PLANE_TYPE_PRIMARY, NULL);
+	if (ret)
+		return ret;
+	drm_plane_helper_add(&ssd1351->plane, &ssd1351_plane_helper_funcs);
+	drm_plane_enable_fb_damage_clips(&ssd1351->plane);
+
+	ret = drm_crtc_init_with_planes(drm, &ssd1351->crtc, &ssd1351->plane,
+					NULL, &ssd1351_crtc_funcs, NULL);
+	if (ret)
+		return ret;
+	drm_crtc_helper_add(&ssd1351->crtc, &ssd1351_crtc_helper_funcs);
+
+	ret = drm_encoder_init(drm, &ssd1351->encoder, &ssd1351_encoder_funcs,
+			       DRM_MODE_ENCODER_NONE, NULL);
+	if (ret)
+		return ret;
+	ssd1351->encoder.possible_crtcs = drm_crtc_mask(&ssd1351->crtc);
+
+	ret = drm_connector_init(drm, &ssd1351->connector,
+				 &ssd1351_connector_funcs,
+				 DRM_MODE_CONNECTOR_SPI);
+	if (ret)
+		return ret;
+	drm_connector_helper_add(&ssd1351->connector,
+				 &ssd1351_connector_helper_funcs);
+
+	ret = drm_connector_attach_encoder(&ssd1351->connector,
+					   &ssd1351->encoder);
+	if (ret)
+		return ret;
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
+static void ssd1351_remove(struct spi_device *spi)
+{
+	struct drm_device *drm = spi_get_drvdata(spi);
+
+	drm_dev_unplug(drm);
+	drm_atomic_helper_shutdown(drm);
+}
+
+static void ssd1351_shutdown(struct spi_device *spi)
+{
+	drm_atomic_helper_shutdown(spi_get_drvdata(spi));
+}
+
+static const struct of_device_id ssd1351_of_match[] = {
+	{ .compatible = "solomon,ssd1351" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, ssd1351_of_match);
+
+static const struct spi_device_id ssd1351_id[] = { { "ssd1351", 0 }, {} };
+MODULE_DEVICE_TABLE(spi, ssd1351_id);
+
+static struct spi_driver ssd1351_spi_driver = {
+	.driver = {
+		.name = "ssd1351",
+		.of_match_table = ssd1351_of_match,
+	},
+	.id_table = ssd1351_id,
+	.probe = ssd1351_probe,
+	.remove = ssd1351_remove,
+	.shutdown = ssd1351_shutdown,
+};
+module_spi_driver(ssd1351_spi_driver);
+
+MODULE_DESCRIPTION("Solomon SSD1351 DRM driver");
+MODULE_AUTHOR("Amit Barzilai <amit.barzilai22@gmail.com>");
+MODULE_LICENSE("GPL");
-- 
2.54.0

