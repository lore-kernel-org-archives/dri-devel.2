Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D2C606A31E
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 08:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0ZPfGIWD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECFC410E89D;
	Fri, 30 Oct 2026 08:49:36 +0000 (UTC)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C65E310E885
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 08:49:25 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-2d01548ac96so1398315ad.3
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 01:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793350165; x=1793954965; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XNsgYn8BBEugZlmjItsRbJU0MW5cK4djQ6SvuONHRL0=;
 b=0ZPfGIWDDu9gFka+9fnKyp3/ucm7PHFdHIg9LbE96yVkkOkZYUzdx+EwtF6/gE8EWB
 7Ah4tMrgOUZkOzMkOqHrPU8G9uFwX4zW9975mVBAq2wPPCXnh7ZDTVVOtlUerK6IFUUq
 dRMblSxg/SA7dFx14+sLo5J181v0wV6OwPJIFs4RCzTRWBbyMLWs7S07c6ESa94ElLDL
 uKEZjWveXMfp0N27ak7kbXrANO2wH/tHphO5bqJ3oprratq7EthN1Sd+NB+y23V15iti
 tPT6As2ZCZdvAqog1kIy9Khmzulf9ycm7xFPxdecR172TCZ4dcmzaN9cfXhoj93T3MhZ
 LIRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793350165; x=1793954965;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=XNsgYn8BBEugZlmjItsRbJU0MW5cK4djQ6SvuONHRL0=;
 b=dVyu+YEMLFv2Ukpq2xJm0nrhzoQujoyJJCyQ22svZafCduJgebTHAFa0dBnpigIe2z
 1CiWNlabQTtq5owgujIsTL5Y0xwnPfxbSGceyYl+okHm5+npGYHARhXFmgqqtxGE8d9R
 p1P71JZ3bs6yYVHjiVhjB3gMofHbam2osiUMgZlaQy8BoJUsruKo/rdexZXWaJucVR1m
 z8gPPEndmJEYofUs3PaS6Net3OlchvfSrbfDOM8OZWT324Fu8Khyzn8BT5DnAQo8lm1f
 zU3+YZBTcJit8cnVwbAxLFF+S5REVAznn0A6GSgV8m0MHPxbKy2lNQrh4xp4NlNFJTMl
 YUSw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwAczzx+HWRdsG+XTCKQd78fljS+sVzan+72hUvOblm53jMRe8xxSxieg5Hc3Pfti77vcJFC1INDZ0=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYI+358VNeNt1m1afS9V0ed/bmKnfqFx4ak/1gVzAFdcIH5X6iBt
 z3j+5/fx569FsTikt557yqAJLSm9TmQMGTjYeMkFsXFpvn6xA3dFLKOD
X-Gm-Gg: AYBFou17dfWVLgi99/4nnwKnXIiIspNs6e3VOzLiU6/t8210QERk7WA9cY/68g+ZpTr
 k57rdktAfAAkbR+oAXRhqoBSRlcwfM+PjO8Ux4YAcs7bRtVvZBhxYO/37GTvJihG9ZmW8j5mr4t
 0OnL2cFCYEb/XmC8xADaeSd/5mCIMIQGYlhtNb/CRPKcMDSCMiOOD1/cfwBOcj1vjdrh/ZddNkK
 CI9XN36J1HckfWOY2k2OUcUdv/EpuZ0ZY6wbjGoFCKQD1DS02sQ0y5Ee9IVXBU+qqch7zFY0GfM
 /XRpOZ6RtrFayCKy4y46JIXZlwwD9A/Oa7rYqgTRvFdlBzPF3M6XTE5RT0TBob5TNCtKQfN4/ZS
 0WBBXD51zudtlnqxi9RJq6dnVqEbZQPHmThlskDAD0xyTDaEG57+MtOGPGZfcKzlrIm9HBxM7tF
 90QvF1XvXXaN0ad2mzBxVjNs3J8OyIusaFtS6OAtA5Mnlae56wkXZ7SIh38vU00A9e0RXrf9vVF
 YWXQWhBjMk1w8e/9egZaMubzbzV50ra+fpsK20UG9GtHx5HPN998TzOSt/SoMijJtiBd2M/rJx2
 zRWsLIjFh/vAY90FelCS4Kc=
X-Received: by 2002:a17:90b:2f4f:b0:3a0:c162:51af with SMTP id
 98e67ed59e1d1-3ae89291df0mr2095146a91.0.1793350165073; 
 Fri, 30 Oct 2026 01:49:25 -0700 (PDT)
Received: from marchy ([211.24.73.58]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae84542a13sm3223575a91.5.2026.10.30.01.49.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 01:49:24 -0700 (PDT)
From: Adam Azuddin <azuddinadam@gmail.com>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 neil.armstrong@linaro.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de
Cc: jesszhan0024@gmail.com, airlied@gmail.com, simona@ffwll.ch,
 andersson@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 azuddinadam@gmail.com
Subject: [PATCH v5 2/2] drm/tiny: Add RAiO RA8875 display controller driver
Date: Fri, 30 Oct 2026 16:37:36 +0800
Message-ID: <20261030083737.47188-3-azuddinadam@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030083737.47188-1-azuddinadam@gmail.com>
References: <20261030083737.47188-1-azuddinadam@gmail.com>
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

Add a DRM tiny driver for the RAiO RA8875 SPI-connected TFT display
controller. The driver supports display resolutions up to 800x480
and uses the GEM shmem helper for buffer management.

Assisted-by: LLM
Signed-off-by: Adam Azuddin <azuddinadam@gmail.com>
---
 MAINTAINERS                   |   6 +
 drivers/gpu/drm/tiny/Kconfig  |  13 +
 drivers/gpu/drm/tiny/Makefile |   1 +
 drivers/gpu/drm/tiny/ra8875.c | 719 ++++++++++++++++++++++++++++++++++
 4 files changed, 739 insertions(+)
 create mode 100644 drivers/gpu/drm/tiny/ra8875.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 89ea35a35c68..84d99be03f64 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8450,6 +8450,12 @@ T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
 F:	drivers/gpu/drm/qxl/
 F:	include/uapi/drm/qxl_drm.h
 
+DRM DRIVER FOR RAIO RA8875 PANELS
+M:	Adam Azuddin <azuddinadam@gmail.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/display/panel/raio,ra8875.yaml
+F:	drivers/gpu/drm/tiny/ra8875.c
+
 DRM DRIVER FOR RAYDIUM RM67191 PANELS
 M:	Robert Chiras <robert.chiras@nxp.com>
 S:	Maintained
diff --git a/drivers/gpu/drm/tiny/Kconfig b/drivers/gpu/drm/tiny/Kconfig
index f0e72d4b6a47..2f1c49e31dd6 100644
--- a/drivers/gpu/drm/tiny/Kconfig
+++ b/drivers/gpu/drm/tiny/Kconfig
@@ -98,6 +98,19 @@ config DRM_PIXPAPER
 
 	  If M is selected, the module will be built as pixpaper.ko.
 
+config DRM_RA8875
+	tristate "DRM support for RA8875 display panels"
+	depends on DRM && SPI && OF
+	select DRM_CLIENT_SELECTION
+	select DRM_KMS_HELPER
+	select DRM_GEM_SHMEM_HELPER
+	select VIDEOMODE_HELPERS
+	help
+	  DRM driver for the following RAiO RA8875 based LCD panels:
+	  * East Rising 5.00" TFT LCD (ER-TFTM050-3)
+
+	  If M is selected the module will be called ra8875.
+
 config TINYDRM_HX8357D
 	tristate "DRM support for HX8357D display panels"
 	depends on DRM && SPI
diff --git a/drivers/gpu/drm/tiny/Makefile b/drivers/gpu/drm/tiny/Makefile
index 48d30bf6152f..ed4602097fbb 100644
--- a/drivers/gpu/drm/tiny/Makefile
+++ b/drivers/gpu/drm/tiny/Makefile
@@ -14,4 +14,5 @@ obj-$(CONFIG_TINYDRM_ILI9341)		+= ili9341.o
 obj-$(CONFIG_TINYDRM_ILI9486)		+= ili9486.o
 obj-$(CONFIG_TINYDRM_MI0283QT)		+= mi0283qt.o
 obj-$(CONFIG_TINYDRM_REPAPER)		+= repaper.o
+obj-$(CONFIG_DRM_RA8875)		+= ra8875.o
 obj-$(CONFIG_TINYDRM_SHARP_MEMORY)	+= sharp-memory.o
diff --git a/drivers/gpu/drm/tiny/ra8875.c b/drivers/gpu/drm/tiny/ra8875.c
new file mode 100644
index 000000000000..937bb7fdbd91
--- /dev/null
+++ b/drivers/gpu/drm/tiny/ra8875.c
@@ -0,0 +1,719 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * DRM driver for RAiO ra8875 controller
+ *
+ * Copyright 2026 Adam Azuddin <azuddinadam@gmail.com>
+ */
+
+#include <linux/gfp_types.h>
+#include <linux/array_size.h>
+#include <linux/bits.h>
+#include <linux/container_of.h>
+#include <linux/delay.h>
+#include <linux/dev_printk.h>
+#include <linux/device/devres.h>
+#include <linux/err.h>
+#include <linux/iosys-map.h>
+#include <linux/module.h>
+#include <linux/spi/spi.h>
+#include <linux/string.h>
+#include <video/of_display_timing.h>
+#include <video/of_videomode.h>
+#include <video/videomode.h>
+
+#include <drm/clients/drm_client_setup.h>
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_atomic.h>
+#include <drm/drm_connector.h>
+#include <drm/drm_damage_helper.h>
+#include <drm/drm_device.h>
+#include <drm/drm_drv.h>
+#include <drm/drm_fbdev_shmem.h>
+#include <drm/drm_framebuffer.h>
+#include <drm/drm_gem.h>
+#include <drm/drm_gem_atomic_helper.h>
+#include <drm/drm_gem_framebuffer_helper.h>
+#include <drm/drm_gem_shmem_helper.h>
+#include <drm/drm_managed.h>
+#include <drm/drm_mode.h>
+#include <drm/drm_mode_config.h>
+#include <drm/drm_modes.h>
+#include <drm/drm_probe_helper.h>
+#include <drm/drm_print.h>
+
+#define RA8875_TXBUF_ROWS	 16
+#define RA8875_CMD_DATA_BUF_SIZE 2
+
+#define RA8875_RESET_WAIT_MS 10 /* datasheet min: 1 ms after RST# rises */
+#define RA8875_MAX_WIDTH     800
+#define RA8875_MAX_HEIGHT    480
+
+#define RA8875_DATAWRITE	 0x00
+#define RA8875_CMDWRITE		 0x80
+#define RA8875_CMDREAD		 0xC0
+#define RA8875_PWRR		 0x01
+#define RA8875_PWRR_DISPON	 BIT(7)
+#define RA8875_PWRR_DISPOFF	 0x00
+#define RA8875_PWRR_SOFTRST	 BIT(0)
+#define RA8875_MRWC		 0x02
+#define RA8875_PLLC1		 0x88
+#define RA8875_PLLC1_PLLDIVN_11	 0x0B
+#define RA8875_PLLC2		 0x89
+#define RA8875_PLLC2_DIVK_4	 0x02
+#define RA8875_SYSR		 0x10
+#define RA8875_SYSR_16BPP	 0x0C
+#define RA8875_PCSR		 0x04
+#define RA8875_PCSR_PCLK_INV	 BIT(7) /* PDAT at falling edge */
+#define RA8875_PCSR_2CLK	 0x01
+#define RA8875_HDWR		 0x14
+#define RA8875_HNDFTR		 0x15
+#define RA8875_HNDFTR_HNDFT(n)	 ((n) & GENMASK(3, 0)) /* fine tune, 2px/step */
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
+#define RA8875_P1DCR_FULL	 0xFF
+#define RA8875_P1DCR_HALF	 0x80
+#define RA8875_P1DCR_MIN	 0x00
+
+DEFINE_DRM_GEM_FOPS(ra8875_fops);
+
+struct ra8875_device {
+	struct drm_device drm;
+	struct spi_device *spi;
+	struct gpio_desc *rst_gpio;
+	struct drm_crtc crtc;
+	struct drm_plane plane;
+	struct drm_encoder encoder;
+	struct drm_connector connector;
+	struct drm_display_mode mode;
+	u8 cmd_buf[RA8875_CMD_DATA_BUF_SIZE];
+	u8 data_buf[RA8875_CMD_DATA_BUF_SIZE];
+	u8 *txbuf;
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
+
+	return drm_connector_helper_get_modes_fixed(connector, &ra8875->mode);
+}
+
+static const struct drm_connector_helper_funcs ra8875_connector_helper_funcs = {
+	.get_modes = ra8875_connector_get_modes
+};
+
+static int ra8875_write_reg(struct ra8875_device *ra8875, u8 reg, u8 val)
+{
+	int ret;
+
+	ra8875->cmd_buf[0] = RA8875_CMDWRITE;
+	ra8875->cmd_buf[1] = reg;
+	ret = spi_write(ra8875->spi, ra8875->cmd_buf, 2);
+	if (ret)
+		goto err;
+
+	ra8875->data_buf[0] = RA8875_DATAWRITE;
+	ra8875->data_buf[1] = val;
+	ret = spi_write(ra8875->spi, ra8875->data_buf, 2);
+	if (ret)
+		goto err;
+
+	return 0;
+err:
+	dev_err(&ra8875->spi->dev,
+		"write_reg(0x%02x, 0x%02x) failed: %d\n", reg, val, ret);
+	return ret;
+}
+
+static int ra8875_write_pixels(struct ra8875_device *ra8875, size_t len)
+{
+	int ret;
+
+	ra8875->cmd_buf[0] = RA8875_CMDWRITE;
+	ra8875->cmd_buf[1] = RA8875_MRWC;
+	ret = spi_write(ra8875->spi, ra8875->cmd_buf, 2);
+	if (ret)
+		return ret;
+
+	return spi_write(ra8875->spi, ra8875->txbuf, len);
+}
+
+static int ra8875_hw_init(struct ra8875_device *ra8875,
+			  struct drm_display_mode *mode)
+{
+	u8 hdwr, hndr, hstr, hpwr, vpwr;
+	u16 vdhr, vndr, vstr;
+	int ret;
+
+	if (ra8875->rst_gpio) {
+		gpiod_set_value_cansleep(ra8875->rst_gpio, 1);
+		usleep_range(1000, 1200);
+		gpiod_set_value_cansleep(ra8875->rst_gpio, 0);
+		msleep(RA8875_RESET_WAIT_MS);
+	}
+
+	/* Soft Reset Sequence */
+	ret = ra8875_write_reg(ra8875, RA8875_PWRR, RA8875_PWRR_SOFTRST);
+	if (ret)
+		return ret;
+
+	usleep_range(1000, 2000);
+	ret = ra8875_write_reg(ra8875, RA8875_PWRR, 0);
+	if (ret)
+		return ret;
+
+	/* PLL */
+	ret = ra8875_write_reg(ra8875, RA8875_PLLC1, RA8875_PLLC1_PLLDIVN_11);
+	if (ret)
+		return ret;
+	usleep_range(200, 500);
+
+	ret = ra8875_write_reg(ra8875, RA8875_PLLC2, RA8875_PLLC2_DIVK_4);
+	if (ret)
+		return ret;
+	usleep_range(200, 500);
+
+	/* PCLK period = 2x System Clock period */
+	ret = ra8875_write_reg(ra8875, RA8875_PCSR, RA8875_PCSR_PCLK_INV | RA8875_PCSR_2CLK);
+	if (ret)
+		return ret;
+
+	/* 16bpp, 8-bit MCU interface */
+	ret = ra8875_write_reg(ra8875, RA8875_SYSR, RA8875_SYSR_16BPP);
+	if (ret)
+		return ret;
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
+	ret = ra8875_write_reg(ra8875, RA8875_HNDFTR, RA8875_HNDFTR_HNDFT(0));
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
+	/* PWM1: enabled, PWM output, full brightness */
+	ret = ra8875_write_reg(ra8875, RA8875_P1CR,
+			 RA8875_P1CR_ENABLE | RA8875_P1CR_SYS_CLK_DIV2);
+	if (ret)
+		return ret;
+
+	ret = ra8875_write_reg(ra8875, RA8875_P1DCR, RA8875_P1DCR_FULL);
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
+	int y, rows, ret;
+	u8 *txbuf = ra8875->txbuf;
+	int rows_per_chunk = RA8875_TXBUF_ROWS;
+
+	/* Set active window to full screen */
+	ret = ra8875_write_reg(ra8875, RA8875_HSAW0, 0);
+	if (ret)
+		return ret;
+
+	ret = ra8875_write_reg(ra8875, RA8875_HSAW1, 0);
+	if (ret)
+		return ret;
+
+	ret = ra8875_write_reg(ra8875, RA8875_VSAW0, 0);
+	if (ret)
+		return ret;
+
+	ret = ra8875_write_reg(ra8875, RA8875_VSAW1, 0);
+	if (ret)
+		return ret;
+
+	ret = ra8875_write_reg(ra8875, RA8875_HEAW0, (width - 1) & 0xFF);
+	if (ret)
+		return ret;
+
+	ret = ra8875_write_reg(ra8875, RA8875_HEAW1, ((width - 1) >> 8) & 0x03);
+	if (ret)
+		return ret;
+
+	ret = ra8875_write_reg(ra8875, RA8875_VEAW0, (height - 1) & 0xFF);
+	if (ret)
+		return ret;
+
+	ret = ra8875_write_reg(ra8875, RA8875_VEAW1,
+			       ((height - 1) >> 8) & 0x01);
+	if (ret)
+		return ret;
+
+	/* Set cursor to 0,0 */
+	ret = ra8875_write_reg(ra8875, RA8875_CURH0, 0);
+	if (ret)
+		return ret;
+
+	ret = ra8875_write_reg(ra8875, RA8875_CURH1, 0);
+	if (ret)
+		return ret;
+
+	ret = ra8875_write_reg(ra8875, RA8875_CURV0, 0);
+	if (ret)
+		return ret;
+
+	ret = ra8875_write_reg(ra8875, RA8875_CURV1, 0);
+	if (ret)
+		return ret;
+
+	memset(txbuf, 0, 1 + rows_per_chunk * width * 2);
+	txbuf[0] = RA8875_DATAWRITE;
+
+	for (y = 0; y < height; y += rows) {
+		rows = min(rows_per_chunk, height - y);
+		ret = ra8875_write_pixels(ra8875, 1 + rows * width * 2);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static void ra8875_crtc_atomic_enable(struct drm_crtc *crtc, struct drm_atomic_commit *state)
+{
+	struct ra8875_device *ra8875 =
+		container_of(crtc->dev, struct ra8875_device, drm);
+	struct drm_crtc_state *crtc_state =
+		drm_atomic_get_new_crtc_state(state, crtc);
+	struct drm_display_mode *mode = &crtc_state->mode;
+	int ret;
+
+	ret = ra8875_hw_init(ra8875, mode);
+	if (ret) {
+		drm_err(&ra8875->drm, "Failed to initialize hardware\n");
+		return;
+	}
+
+	ret = ra8875_clear_screen(ra8875, mode);
+	if (ret) {
+		drm_err(&ra8875->drm, "Failed to clear screen\n");
+		return;
+	}
+}
+
+static void ra8875_crtc_atomic_disable(struct drm_crtc *crtc, struct drm_atomic_commit *state)
+{
+	struct ra8875_device *ra8875 =
+		container_of(crtc->dev, struct ra8875_device, drm);
+
+	ra8875_write_reg(ra8875, RA8875_P1CR, RA8875_P1CR_DISABLE);
+	ra8875_write_reg(ra8875, RA8875_P1DCR, RA8875_P1DCR_MIN);
+
+	ra8875_write_reg(ra8875, RA8875_PWRR, RA8875_PWRR_DISPOFF);
+}
+
+static void ra8875_fb_dirty(struct ra8875_device *ra8875, struct iosys_map *src,
+			    struct drm_framebuffer *fb, struct drm_rect *rect)
+{
+	unsigned int width = drm_rect_width(rect);
+	int rows = 0;
+	struct iosys_map dst;
+	struct drm_format_conv_state fmtcnv_state = DRM_FORMAT_CONV_STATE_INIT;
+
+	if (ra8875_write_reg(ra8875, RA8875_HSAW0, rect->x1 & 0xFF))
+		goto err;
+	if (ra8875_write_reg(ra8875, RA8875_HSAW1, (rect->x1 >> 8) & 0x03))
+		goto err;
+	if (ra8875_write_reg(ra8875, RA8875_VSAW0, rect->y1 & 0xFF))
+		goto err;
+	if (ra8875_write_reg(ra8875, RA8875_VSAW1, (rect->y1 >> 8) & 0x01))
+		goto err;
+	if (ra8875_write_reg(ra8875, RA8875_HEAW0, (rect->x2 - 1) & 0xFF))
+		goto err;
+	if (ra8875_write_reg(ra8875, RA8875_HEAW1, ((rect->x2 - 1) >> 8) & 0x03))
+		goto err;
+
+	if (ra8875_write_reg(ra8875, RA8875_VEAW0, (rect->y2 - 1) & 0xFF))
+		goto err;
+	if (ra8875_write_reg(ra8875, RA8875_VEAW1, ((rect->y2 - 1) >> 8) & 0x01))
+		goto err;
+	if (ra8875_write_reg(ra8875, RA8875_CURH0, rect->x1 & 0xFF))
+		goto err;
+	if (ra8875_write_reg(ra8875, RA8875_CURH1, (rect->x1 >> 8) & 0x03))
+		goto err;
+	if (ra8875_write_reg(ra8875, RA8875_CURV0, rect->y1 & 0xFF))
+		goto err;
+	if (ra8875_write_reg(ra8875, RA8875_CURV1, (rect->y1 >> 8) & 0x01))
+		goto err;
+
+	for (int y = rect->y1; y < rect->y2; y += rows) {
+		struct drm_rect chunk;
+
+		rows = min(RA8875_TXBUF_ROWS, rect->y2 - y);
+		chunk = DRM_RECT_INIT(rect->x1, y, width, rows);
+
+		iosys_map_set_vaddr(&dst, ra8875->txbuf + 1);
+		drm_fb_swab(&dst, NULL, src, fb, &chunk, false, &fmtcnv_state);
+
+		if (ra8875_write_pixels(ra8875, 1 + rows * width * 2))
+			goto err;
+	}
+
+	drm_format_conv_state_release(&fmtcnv_state);
+	return;
+err:
+	drm_format_conv_state_release(&fmtcnv_state);
+	dev_err_once(fb->dev->dev, "Failed to update display\n");
+}
+
+static void ra8875_plane_atomic_update(struct drm_plane *plane, struct drm_atomic_commit *state)
+{
+	struct ra8875_device *ra8875 = container_of(plane->dev, struct ra8875_device, drm);
+	struct drm_plane_state *old_plane_state = drm_atomic_get_old_plane_state(state, plane);
+	struct drm_plane_state *plane_state = drm_atomic_get_new_plane_state(state, plane);
+	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(plane_state);
+	struct drm_framebuffer *fb = plane_state->fb;
+	struct drm_rect rect;
+	struct iosys_map *map = &shadow_plane_state->data[0];
+	int idx;
+
+	if (!fb)
+		return;
+
+	if (!drm_dev_enter(&ra8875->drm, &idx))
+		return;
+
+	if (iosys_map_is_null(map)) {
+		drm_err(&ra8875->drm, "Shadow map is null\n");
+		goto exit;
+	}
+	if (drm_atomic_helper_damage_merged(old_plane_state, plane_state, &rect))
+		ra8875_fb_dirty(ra8875, map, fb, &rect);
+exit:
+	drm_dev_exit(idx);
+}
+
+static enum drm_mode_status ra8875_mode_valid(struct drm_crtc *crtc,
+					      const struct drm_display_mode *mode)
+{
+	if (mode->hdisplay % 8 != 0 || mode->hsync_start % 8 != 0 ||
+	    mode->hsync_end % 8 != 0 || mode->htotal % 8 != 0) {
+		drm_dbg_kms(crtc->dev,
+		   "mode timings must be 8-pixel aligned (hdisplay=%d hsync_start=%d hsync_end=%d htotal=%d)\n",
+			    mode->hdisplay, mode->hsync_start, mode->hsync_end, mode->htotal);
+		return MODE_H_ILLEGAL;
+	}
+	return MODE_OK;
+}
+
+static int ra8875_plane_atomic_check(struct drm_plane *plane, struct drm_atomic_commit *state)
+{
+	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state, plane);
+	struct drm_crtc_state *crtc_state;
+
+	if (!new_plane_state->crtc)
+		return 0;
+
+	crtc_state = drm_atomic_get_new_crtc_state(state, new_plane_state->crtc);
+	if (!crtc_state)
+		return -EINVAL;
+
+	return drm_atomic_helper_check_plane_state(new_plane_state, crtc_state,
+						   DRM_PLANE_NO_SCALING,
+						   DRM_PLANE_NO_SCALING,
+						   false, true);
+}
+
+static const u32 ra8875_formats[] = {
+	DRM_FORMAT_RGB565,
+};
+
+static const struct drm_encoder_funcs ra8875_encoder_funcs_cleanup = {
+	.destroy = drm_encoder_cleanup,
+};
+
+static const struct drm_crtc_funcs ra8875_crtc_funcs = {
+	.atomic_create_state = drm_atomic_helper_crtc_create_state,
+	.destroy = drm_crtc_cleanup,
+	.set_config = drm_atomic_helper_set_config,
+	.page_flip = drm_atomic_helper_page_flip,
+	.atomic_duplicate_state = drm_atomic_helper_crtc_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_crtc_destroy_state,
+};
+
+static const struct drm_crtc_helper_funcs ra8875_crtc_helper_funcs = {
+	.mode_valid = ra8875_mode_valid,
+	.atomic_enable = ra8875_crtc_atomic_enable,
+	.atomic_disable = ra8875_crtc_atomic_disable,
+};
+
+static const struct drm_plane_funcs ra8875_plane_funcs = {
+	.update_plane = drm_atomic_helper_update_plane,
+	.disable_plane = drm_atomic_helper_disable_plane,
+	.destroy = drm_plane_cleanup,
+	DRM_GEM_SHADOW_PLANE_FUNCS,
+};
+
+static const struct drm_plane_helper_funcs ra8875_plane_helper_funcs = {
+	.prepare_fb = drm_gem_plane_helper_prepare_fb,
+	.begin_fb_access = drm_gem_begin_shadow_fb_access,
+	.end_fb_access = drm_gem_end_shadow_fb_access,
+	.atomic_check = ra8875_plane_atomic_check,
+	.atomic_update = ra8875_plane_atomic_update,
+};
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
+static int ra8875_probe(struct spi_device *spi)
+{
+	struct device *dev = &spi->dev;
+	struct ra8875_device *ra8875;
+	struct drm_connector *connector;
+	struct drm_device *drm;
+	struct videomode vm;
+	int ret;
+	size_t buf_size;
+
+	ra8875 = devm_drm_dev_alloc(dev, &ra8875_driver, struct ra8875_device,
+				    drm);
+
+	if (IS_ERR(ra8875))
+		return PTR_ERR(ra8875);
+
+	drm = &ra8875->drm;
+	connector = &ra8875->connector;
+
+	ra8875->rst_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(ra8875->rst_gpio))
+		return dev_err_probe(dev, PTR_ERR(ra8875->rst_gpio),
+			     "failed to get reset GPIO\n");
+
+	ra8875->spi = spi;
+
+	spi->mode = SPI_MODE_0;
+
+	ret = spi_setup(spi);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to setup SPI\n");
+
+	buf_size = 1 + RA8875_TXBUF_ROWS * RA8875_MAX_WIDTH * 2;
+	ra8875->txbuf = devm_kzalloc(&spi->dev, buf_size, GFP_KERNEL);
+	if (!ra8875->txbuf)
+		return -ENOMEM;
+
+	ret = of_get_videomode(dev->of_node, &vm, OF_USE_NATIVE_MODE);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to get videomode\n");
+	drm_display_mode_from_videomode(&vm, &ra8875->mode);
+
+	if (!ra8875->mode.hdisplay || !ra8875->mode.vdisplay ||
+	    ra8875->mode.hdisplay > RA8875_MAX_WIDTH ||
+	    ra8875->mode.vdisplay > RA8875_MAX_HEIGHT)
+		return dev_err_probe(dev, -EINVAL,
+				"Invalid display size %ux%u from device tree\n",
+				     ra8875->mode.hdisplay, ra8875->mode.vdisplay);
+
+	ra8875->mode.type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED;
+
+	drm_mode_set_name(&ra8875->mode);
+	ret = drmm_mode_config_init(drm);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to initialize mode config\n");
+
+	drm->mode_config.min_width = ra8875->mode.hdisplay;
+	drm->mode_config.max_width = ra8875->mode.hdisplay;
+	drm->mode_config.min_height = ra8875->mode.vdisplay;
+	drm->mode_config.max_height = ra8875->mode.vdisplay;
+
+	drm->mode_config.funcs = &ra8875_modeconfig_funcs;
+
+	drm_connector_helper_add(connector, &ra8875_connector_helper_funcs);
+	ret = drmm_connector_init(drm, connector, &ra8875_connector_funcs,
+				  DRM_MODE_CONNECTOR_SPI, NULL);
+
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to init connector:\n");
+
+	drm_plane_helper_add(&ra8875->plane, &ra8875_plane_helper_funcs);
+	ret = drm_universal_plane_init(drm, &ra8875->plane, 0,
+				       &ra8875_plane_funcs,
+				       ra8875_formats, ARRAY_SIZE(ra8875_formats),
+				       NULL,
+				       DRM_PLANE_TYPE_PRIMARY, NULL);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to initialize plane\n");
+
+	drm_crtc_helper_add(&ra8875->crtc, &ra8875_crtc_helper_funcs);
+	ret = drm_crtc_init_with_planes(drm, &ra8875->crtc, &ra8875->plane, NULL,
+					&ra8875_crtc_funcs, NULL);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to initialize CRTC with planes\n");
+
+	ra8875->encoder.possible_crtcs = drm_crtc_mask(&ra8875->crtc);
+	ret = drm_encoder_init(drm, &ra8875->encoder, &ra8875_encoder_funcs_cleanup,
+			       DRM_MODE_ENCODER_NONE, NULL);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to initialize encoder\n");
+
+	ret = drm_connector_attach_encoder(connector, &ra8875->encoder);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to attach connector to encoder\n");
+
+	drm_plane_enable_fb_damage_clips(&ra8875->plane);
+
+	spi_set_drvdata(spi, drm);
+	drm_mode_config_reset(drm);
+
+	ret = drm_dev_register(drm, 0);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to register device\n");
+
+	drm_client_setup(drm, drm_format_info(DRM_FORMAT_RGB565));
+
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
+static const struct of_device_id ra8875_of_match[] = {
+	{ .compatible = "raio,ra8875" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ra8875_of_match);
+
+static const struct spi_device_id ra8875_id[] = {
+	{ "ra8875", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, ra8875_id);
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
2.55.0

