Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05164C5DF70
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 08:07:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FE6410EA39;
	Tue, 18 Aug 2026 08:07:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DZ5Lw5P0";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA97A10EA30
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 08:06:54 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-49800c6a846so50583575e9.3
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 01:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787040413; x=1787645213; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=B2fVEcJvgOMMHDfgHu6eikQjPaW5FYExfbHusAlmMxs=;
 b=DZ5Lw5P03GHQFKs9vw7lm72SuL6bjBJTQH6dct5L8k7LhFPbEfc+p2JBH1rmQ+U6Nq
 hwdFFYi4C/Bma+xQoWrIshGKY8hZ1MgYqj0umLR1LmCS9a13scCBqmnNnu5tPkuqPnW7
 S51LIjKc93QuU/b/rO9xYg3frFOPKZ8Q7VGlDhFNQaUkXdLCShEvmV5Q5WLgRO43lr2Y
 7rBEufTA7FURysLn2kWY8OHd4A+rdmmGeFxHLgn2X/dkuzj4C1sLPO3x1SbDosmZwYKg
 92Hh8cYhEOkFKoSKs6ffm+PvfNvu5WTv+kx0RMTTEwjM6OEofjql8KXhnfPar0Xs7jB1
 cweA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787040413; x=1787645213;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=B2fVEcJvgOMMHDfgHu6eikQjPaW5FYExfbHusAlmMxs=;
 b=f32R/DxW6eDtN+7H52d1ftkp4aWELV/scxDGR2YAy+OEOCcjUvM+3SmDvrleBn9F99
 Q7vOBFsB1NfTJMWYAiTsaN80guunB+Cegzr04CYqp8g56EAnBBorOm1PxdQfn250hWA7
 O5LQgyuvh+QdKSlWVxqVJXY1ElA4BNd5RaCDzC6yLLehA3k3aAYobar9cKsuk/B4qPbV
 b0oaWZpU3tkiFlgRho7vVvggG3Ua0bpdKLLie8khiSxZOJU1leo+sOOH0Pmk1xit8O+0
 b0tq5Szg4wT9LcLqDwheFtkSu8a3ItMJ50Md47AAWmoq27TpLCGkaYCx/3fE38Xai4bH
 Uz+w==
X-Forwarded-Encrypted: i=1;
 AHgh+Rramp9P0tRB5yR2PDrl+r4ZShPXTFCUYOCY5EW84f1LaHp+ZgHCo5pbA1Bibtb8XagY9+agCT1HoQI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywa6IgzdkLbvyRlYsFctorj+vjrcWiz8XjW0hl0vity8q3wgJcm
 q6FqKtpx9yOMPCw6IztYo0QXey9Fs3VicTUQcXxX80SnKlIpoK1LWEM1
X-Gm-Gg: AR+sD10kT1boDG9Wf4/XXMoOBXK0guM/P1EJev0wvbDTJmnBIwe7fjy4Pqhhm5fIAPV
 L/HzxQkLf0MDH852EJZZVNijc5x7MPbqqddMpg+OyAAF7NrP8YfpHGB66VR2ya69zAc+oZCQHun
 4SnP9AbbRSBxYyWELc7m2FwdBST4Jn/lnqt3psfF1MEFoMX35K4e31YTPaA+VWBQb23f1ru43l6
 s6gy8iJ/hCConsjjeZQcfvDrtJHBB2snwtFzal88K1XfdD8N/gjxzfXx8oEbcZlMdeV1WlPlJuk
 gDlcWR7fd2k5hEVN86cwUnxmuc9PyIxVkF7En29fSchmZBp95NM6gMyhp3xOEGmftgkXNF9mEdh
 qTjmBE3qRkmV214dBS5VN0qI8AGuJ9lYgBgpw2ilAgnPcQuY7xkDTGOSNJh9amOk1b3hsDLg9e8
 Z6lEQtnD1ehhcpprVXEzb7gvA+vZ0sF1k5mohbVjA3VkYyAdBqduXyQ/n5PEsg9nyQDp1lHjQcm
 cs=
X-Received: by 2002:a05:600d:8489:20b0:499:8b13:3a98 with SMTP id
 5b1f17b1804b1-4998b133b3dmr307330665e9.4.1787040412707; 
 Tue, 18 Aug 2026 01:06:52 -0700 (PDT)
Received: from anthony.local ([2a06:c701:9cc4:c200:33d8:8ea2:e077:ebe1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482a5a3b2e9sm10367223f8f.9.2026.08.18.01.06.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 01:06:52 -0700 (PDT)
From: Amit Barzilai <amit.barzilai22@gmail.com>
To: Javier Martinez Canillas <javierm@redhat.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
 Fabio Piparo <holofermes@gmail.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Amit Barzilai <amit.barzilai22@gmail.com>
Subject: [PATCH v4 6/6] drm/ssd130x: Add SSD135X_FAMILY and SSD1351 support
Date: Tue, 18 Aug 2026 11:06:26 +0300
Message-ID: <20260818080626.30430-7-amit.barzilai22@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260818080626.30430-1-amit.barzilai22@gmail.com>
References: <20260818080626.30430-1-amit.barzilai22@gmail.com>
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

The Solomon SSD1351 is a 128x128 RGB color OLED controller. It shares the
SSD133X pixel layout: one 65k color (RGB565) pixel per Segment, written as
a bulk transfer once a column/row addressing window has been programmed.
Add it as a new SSD135X_FAMILY rather than as a separate driver, so that
the ssd130x plane, CRTC and encoder infrastructure is reused.

Give the family its own primary plane update and disable, encoder enable
and backlight callbacks instead of teaching the ssd133x ones about a second
family. Only the callbacks that carry no family specific logic are reused
as is: ssd133x_primary_plane_atomic_check(), ssd133x_crtc_atomic_check()
and ssd130x_encoder_atomic_disable().

The data path differs from the ssd133x family in one respect. The SSD1351
only starts accepting pixel data after an explicit Write RAM command
(0x5c), while the SSD133X enters data mode as soon as the address window
has been programmed. Emit it from ssd135x_update_rect(), which both the
damage update and the clear screen paths go through.

SSD1351 differs from previous controllers in the command protocol. While
the opcode is still sent on the command path, the parameters are sent on
the data path. Introduce the cmd_params_are_data flag to struct
ssd130x_deviceinfo and let ssd130x_write_cmds() split the buffer in
accordance to the device specifications.

The SSD1351 also needs its own init sequence (ssd135x_init). The remap
byte is fixed at horizontal address increment, COM split, reversed COM
scan direction, BGR sub-pixel order and 65k color depth; rotation is not
supported.

Contrast is calibrated per color channel as for the ssd133x family, but
the three channels are parameters of a single command (0xc1) instead of
one command per channel. Add ssd135x_set_contrast() for that and use it
from both the init and the backlight update paths.

The SSD1351 is SPI-only, so only the SPI transport match tables gain an
entry; no new config symbol is needed.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Amit Barzilai <amit.barzilai22@gmail.com>
---
 drivers/gpu/drm/solomon/ssd130x-spi.c |   7 +
 drivers/gpu/drm/solomon/ssd130x.c     | 308 +++++++++++++++++++++++++-
 drivers/gpu/drm/solomon/ssd130x.h     |  10 +-
 3 files changed, 318 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/solomon/ssd130x-spi.c b/drivers/gpu/drm/solomon/ssd130x-spi.c
index be50e5aa2c87..c41064aa8221 100644
--- a/drivers/gpu/drm/solomon/ssd130x-spi.c
+++ b/drivers/gpu/drm/solomon/ssd130x-spi.c
@@ -146,6 +146,11 @@ static const struct of_device_id ssd130x_of_match[] = {
 		.compatible = "solomon,ssd1331",
 		.data = &ssd130x_variants[SSD1331_ID],
 	},
+	/* ssd135x family */
+	{
+		.compatible = "solomon,ssd1351",
+		.data = &ssd130x_variants[SSD1351_ID],
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, ssd130x_of_match);
@@ -171,6 +176,8 @@ static const struct spi_device_id ssd130x_spi_id[] = {
 	{ .name = "ssd1327", .driver_data = SSD1327_ID },
 	/* ssd133x family */
 	{ .name = "ssd1331", .driver_data = SSD1331_ID },
+	/* ssd135x family */
+	{ .name = "ssd1351", .driver_data = SSD1351_ID },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(spi, ssd130x_spi_id);
diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd130x.c
index 61187a630a0d..af1f8e21f159 100644
--- a/drivers/gpu/drm/solomon/ssd130x.c
+++ b/drivers/gpu/drm/solomon/ssd130x.c
@@ -151,6 +151,37 @@
 #define SSD133X_SET_REMAP_COLOR_DEPTH_MASK	GENMASK(7, 6)
 #define SSD133X_COLOR_DEPTH_65K			0x1
 
+/* ssd135x commands */
+#define SSD135X_SET_COL_RANGE			0x15
+#define SSD135X_WRITE_RAM			0x5c
+#define SSD135X_SET_ROW_RANGE			0x75
+#define SSD135X_SET_DISPLAY_START		0xa1
+#define SSD135X_SET_DISPLAY_OFFSET		0xa2
+#define SSD135X_SET_DISPLAY_NORMAL		0xa6
+#define SSD135X_SET_FUNCTION			0xab
+#define SSD135X_SET_PHASE_LENGTH		0xb1
+#define SSD135X_SET_CLOCK_FREQ			0xb3
+#define SSD135X_SET_VSL				0xb4
+#define SSD135X_SET_GPIO			0xb5
+#define SSD135X_SET_PRECHARGE2			0xb6
+#define SSD135X_SET_PRECHARGE_VOLTAGE		0xbb
+#define SSD135X_SET_VCOMH_VOLTAGE		0xbe
+#define SSD135X_SET_CONTRAST			0xc1
+#define SSD135X_SET_CONTRAST_MASTER		0xc7
+#define SSD135X_SET_MUX_RATIO			0xca
+#define SSD135X_SET_COMMAND_LOCK		0xfd
+
+/* ssd135x A/B/C channel contrast at full brightness (white balance) */
+#define SSD135X_DEFAULT_CONTRAST_A		0xc8
+#define SSD135X_DEFAULT_CONTRAST_B		0x80
+#define SSD135X_DEFAULT_CONTRAST_C		0xc8
+
+/* ssd135x remap byte (data of SSD13XX_SET_SEG_REMAP) */
+#define SSD135X_SET_REMAP_COLOR_BGR		BIT(2)
+#define SSD135X_SET_REMAP_COM_SCAN		BIT(4)
+#define SSD135X_SET_REMAP_COM_SPLIT		BIT(5)
+#define SSD135X_SET_REMAP_65K			BIT(6)
+
 #define MAX_CONTRAST 255
 
 const struct ssd130x_deviceinfo ssd130x_variants[] = {
@@ -218,7 +249,14 @@ const struct ssd130x_deviceinfo ssd130x_variants[] = {
 		.default_width = 96,
 		.default_height = 64,
 		.family_id = SSD133X_FAMILY,
-	}
+	},
+	/* ssd135x family */
+	[SSD1351_ID] = {
+		.default_width = 128,
+		.default_height = 128,
+		.family_id = SSD135X_FAMILY,
+		.cmd_params_are_data = true,
+	},
 };
 EXPORT_SYMBOL_NS_GPL(ssd130x_variants, "DRM_SSD130X");
 
@@ -261,9 +299,10 @@ static int ssd130x_write_data(struct ssd130x_device *ssd130x, const u8 *values,
  * Helper to write a command (SSD13XX_COMMAND) from a buffer. The first byte
  * is the command opcode and the following ones are its parameters.
  *
- * Note that the ssd13xx protocol requires the opcode and each parameter to
- * be written as a SSD13XX_COMMAND device register value. That is why a call
- * to regmap_write(..., SSD13XX_COMMAND, ...) is done for each byte.
+ * By default every byte is written as a SSD13XX_COMMAND register value, hence
+ * the regmap_write() per byte. Controllers that set cmd_params_are_data expect
+ * the parameters on the data path instead, so only the opcode is written as
+ * SSD13XX_COMMAND and the rest as SSD13XX_DATA.
  */
 static int ssd130x_write_cmds(struct ssd130x_device *ssd130x, const u8 *cmd,
 			      size_t len)
@@ -271,6 +310,17 @@ static int ssd130x_write_cmds(struct ssd130x_device *ssd130x, const u8 *cmd,
 	unsigned int i;
 	int ret;
 
+	if (ssd130x->device_info->cmd_params_are_data) {
+		if (!len)
+			return 0;
+
+		ret = regmap_write(ssd130x->regmap, SSD13XX_COMMAND, cmd[0]);
+		if (ret || len == 1)
+			return ret;
+
+		return ssd130x_write_data(ssd130x, cmd + 1, len - 1);
+	}
+
 	for (i = 0; i < len; i++) {
 		ret = regmap_write(ssd130x->regmap, SSD13XX_COMMAND, cmd[i]);
 		if (ret)
@@ -617,6 +667,20 @@ static int ssd133x_set_contrast(struct ssd130x_device *ssd130x, u32 brightness)
 	return ssd130x_run_cmd_seq(ssd130x, cmds);
 }
 
+/*
+ * Same white balance calibration as for the ssd133x family, except that the
+ * ssd135x controllers take the three channels as parameters of a single
+ * command instead of one command per channel.
+ */
+static int ssd135x_set_contrast(struct ssd130x_device *ssd130x, u32 brightness)
+{
+	u8 a = ssd130x_scale_contrast(SSD135X_DEFAULT_CONTRAST_A, brightness);
+	u8 b = ssd130x_scale_contrast(SSD135X_DEFAULT_CONTRAST_B, brightness);
+	u8 c = ssd130x_scale_contrast(SSD135X_DEFAULT_CONTRAST_C, brightness);
+
+	return ssd130x_write_cmd(ssd130x, 4, SSD135X_SET_CONTRAST, a, b, c);
+}
+
 static int ssd133x_init(struct ssd130x_device *ssd130x)
 {
 	int ret;
@@ -654,6 +718,47 @@ static int ssd133x_init(struct ssd130x_device *ssd130x)
 	return ssd130x_run_cmd_seq(ssd130x, cmds);
 }
 
+static int ssd135x_init(struct ssd130x_device *ssd130x)
+{
+	/*
+	 * Horizontal address increment, COM split, reversed COM scan direction,
+	 * BGR sub-pixel order and 65k (RGB565) color depth. Rotation is not
+	 * supported, so the remap byte is fixed.
+	 */
+	u8 remap = SSD135X_SET_REMAP_65K | SSD135X_SET_REMAP_COM_SPLIT |
+		   SSD135X_SET_REMAP_COLOR_BGR | SSD135X_SET_REMAP_COM_SCAN;
+	int ret;
+	const u8 cmds[] = {
+		/* Unlock the controller, then the extended command set */
+		2, SSD135X_SET_COMMAND_LOCK, 0x12,
+		2, SSD135X_SET_COMMAND_LOCK, 0xb1,
+		1, SSD13XX_DISPLAY_OFF,
+		2, SSD135X_SET_CLOCK_FREQ, 0xf1,
+		2, SSD135X_SET_MUX_RATIO, ssd130x->height - 1,
+		3, SSD135X_SET_COL_RANGE, 0x00, ssd130x->width - 1,
+		3, SSD135X_SET_ROW_RANGE, 0x00, ssd130x->height - 1,
+		2, SSD135X_SET_DISPLAY_START, 0x00,
+		2, SSD135X_SET_DISPLAY_OFFSET, 0x00,
+		2, SSD135X_SET_GPIO, 0x00,
+		2, SSD135X_SET_FUNCTION, 0x01,
+		2, SSD135X_SET_PHASE_LENGTH, 0x32,
+		4, SSD135X_SET_VSL, 0xa0, 0xb5, 0x55,
+		2, SSD135X_SET_PRECHARGE_VOLTAGE, 0x17,
+		2, SSD135X_SET_VCOMH_VOLTAGE, 0x05,
+		2, SSD135X_SET_CONTRAST_MASTER, 0x0f,
+		2, SSD135X_SET_PRECHARGE2, 0x01,
+		1, SSD135X_SET_DISPLAY_NORMAL,
+		2, SSD13XX_SET_SEG_REMAP, remap,
+		0,
+	};
+
+	ret = ssd130x_run_cmd_seq(ssd130x, cmds);
+	if (ret < 0)
+		return ret;
+
+	return ssd135x_set_contrast(ssd130x, ssd130x->contrast);
+}
+
 static int ssd130x_update_rect(struct ssd130x_device *ssd130x,
 			       struct drm_rect *rect, u8 *buf,
 			       u8 *data_array)
@@ -863,6 +968,44 @@ static int ssd133x_update_rect(struct ssd130x_device *ssd130x,
 	return ret;
 }
 
+static int ssd135x_update_rect(struct ssd130x_device *ssd130x,
+			       struct drm_rect *rect, u8 *data_array,
+			       unsigned int pitch)
+{
+	unsigned int x = rect->x1;
+	unsigned int y = rect->y1;
+	unsigned int columns = drm_rect_width(rect);
+	unsigned int rows = drm_rect_height(rect);
+	int ret;
+
+	/*
+	 * The pixel layout is the same as for the ssd133x family: one 65k
+	 * color (RGB565) pixel per Segment, sent Segment by Segment when the
+	 * (default) horizontal address increment mode is used.
+	 *
+	 * But unlike the ssd133x family, which starts accepting pixel data as
+	 * soon as the address window has been programmed, the ssd135x family
+	 * needs an explicit Write RAM command before the data is written.
+	 */
+
+	/* Set column start and end */
+	ret = ssd130x_write_cmd(ssd130x, 3, SSD135X_SET_COL_RANGE, x, x + columns - 1);
+	if (ret < 0)
+		return ret;
+
+	/* Set row start and end */
+	ret = ssd130x_write_cmd(ssd130x, 3, SSD135X_SET_ROW_RANGE, y, y + rows - 1);
+	if (ret < 0)
+		return ret;
+
+	ret = ssd130x_write_cmd(ssd130x, 1, SSD135X_WRITE_RAM);
+	if (ret < 0)
+		return ret;
+
+	/* Write out update in one go since horizontal addressing mode is used */
+	return ssd130x_write_data(ssd130x, data_array, pitch * rows);
+}
+
 static void ssd130x_clear_screen(struct ssd130x_device *ssd130x, u8 *data_array)
 {
 	unsigned int pages = DIV_ROUND_UP(ssd130x->height, SSD130X_PAGE_HEIGHT);
@@ -931,6 +1074,22 @@ static void ssd133x_clear_screen(struct ssd130x_device *ssd130x, u8 *data_array)
 	ssd130x_write_data(ssd130x, data_array, pitch * ssd130x->height);
 }
 
+static void ssd135x_clear_screen(struct ssd130x_device *ssd130x, u8 *data_array)
+{
+	struct drm_rect screen = DRM_RECT_INIT(0, 0, ssd130x->width, ssd130x->height);
+	const struct drm_format_info *fi = drm_format_info(DRM_FORMAT_RGB565);
+	unsigned int pitch;
+
+	if (!fi)
+		return;
+
+	pitch = drm_format_info_min_pitch(fi, 0, ssd130x->width);
+
+	memset(data_array, 0, pitch * ssd130x->height);
+
+	ssd135x_update_rect(ssd130x, &screen, data_array, pitch);
+}
+
 static int ssd130x_fb_blit_rect(struct drm_framebuffer *fb,
 				const struct iosys_map *vmap,
 				struct drm_rect *rect,
@@ -1003,6 +1162,29 @@ static int ssd133x_fb_blit_rect(struct drm_framebuffer *fb,
 	return 0;
 }
 
+static int ssd135x_fb_blit_rect(struct drm_framebuffer *fb,
+				const struct iosys_map *vmap,
+				struct drm_rect *rect, u8 *data_array,
+				struct drm_format_conv_state *fmtcnv_state)
+{
+	struct ssd130x_device *ssd130x = drm_to_ssd130x(fb->dev);
+	const struct drm_format_info *fi = drm_format_info(DRM_FORMAT_RGB565);
+	unsigned int dst_pitch;
+	struct iosys_map dst;
+
+	if (!fi)
+		return -EINVAL;
+
+	dst_pitch = drm_format_info_min_pitch(fi, 0, drm_rect_width(rect));
+
+	iosys_map_set_vaddr(&dst, data_array);
+	drm_fb_xrgb8888_to_rgb565be(&dst, &dst_pitch, vmap, fb, rect, fmtcnv_state);
+
+	ssd135x_update_rect(ssd130x, rect, data_array, dst_pitch);
+
+	return 0;
+}
+
 static int ssd130x_primary_plane_atomic_check(struct drm_plane *plane,
 					      struct drm_atomic_commit *state)
 {
@@ -1245,6 +1427,45 @@ static void ssd133x_primary_plane_atomic_update(struct drm_plane *plane,
 	drm_dev_exit(idx);
 }
 
+static void ssd135x_primary_plane_atomic_update(struct drm_plane *plane,
+						struct drm_atomic_commit *state)
+{
+	struct drm_plane_state *plane_state = drm_atomic_get_new_plane_state(state, plane);
+	struct drm_plane_state *old_plane_state = drm_atomic_get_old_plane_state(state, plane);
+	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(plane_state);
+	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state, plane_state->crtc);
+	struct ssd130x_crtc_state *ssd130x_crtc_state =  to_ssd130x_crtc_state(crtc_state);
+	struct drm_framebuffer *fb = plane_state->fb;
+	struct drm_atomic_helper_damage_iter iter;
+	struct drm_device *drm = plane->dev;
+	struct drm_rect dst_clip;
+	struct drm_rect damage;
+	int idx;
+
+	if (!drm_dev_enter(drm, &idx))
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
+		ssd135x_fb_blit_rect(fb, &shadow_plane_state->data[0], &dst_clip,
+				     ssd130x_crtc_state->data_array,
+				     &shadow_plane_state->fmtcnv_state);
+	}
+
+	drm_gem_fb_end_cpu_access(fb, DMA_FROM_DEVICE);
+
+out_drm_dev_exit:
+	drm_dev_exit(idx);
+}
+
 static void ssd130x_primary_plane_atomic_disable(struct drm_plane *plane,
 						 struct drm_atomic_commit *state)
 {
@@ -1317,6 +1538,30 @@ static void ssd133x_primary_plane_atomic_disable(struct drm_plane *plane,
 	drm_dev_exit(idx);
 }
 
+static void ssd135x_primary_plane_atomic_disable(struct drm_plane *plane,
+						 struct drm_atomic_commit *state)
+{
+	struct drm_device *drm = plane->dev;
+	struct ssd130x_device *ssd130x = drm_to_ssd130x(drm);
+	struct drm_plane_state *plane_state = drm_atomic_get_new_plane_state(state, plane);
+	struct drm_crtc_state *crtc_state;
+	struct ssd130x_crtc_state *ssd130x_crtc_state;
+	int idx;
+
+	if (!plane_state->crtc)
+		return;
+
+	crtc_state = drm_atomic_get_new_crtc_state(state, plane_state->crtc);
+	ssd130x_crtc_state = to_ssd130x_crtc_state(crtc_state);
+
+	if (!drm_dev_enter(drm, &idx))
+		return;
+
+	ssd135x_clear_screen(ssd130x, ssd130x_crtc_state->data_array);
+
+	drm_dev_exit(idx);
+}
+
 /* Called during init to allocate the plane's atomic state. */
 static void ssd130x_primary_plane_reset(struct drm_plane *plane)
 {
@@ -1385,7 +1630,13 @@ static const struct drm_plane_helper_funcs ssd130x_primary_plane_helper_funcs[]
 		.atomic_check = ssd133x_primary_plane_atomic_check,
 		.atomic_update = ssd133x_primary_plane_atomic_update,
 		.atomic_disable = ssd133x_primary_plane_atomic_disable,
-	}
+	},
+	[SSD135X_FAMILY] = {
+		DRM_GEM_SHADOW_PLANE_HELPER_FUNCS,
+		.atomic_check = ssd133x_primary_plane_atomic_check,
+		.atomic_update = ssd135x_primary_plane_atomic_update,
+		.atomic_disable = ssd135x_primary_plane_atomic_disable,
+	},
 };
 
 static const struct drm_plane_funcs ssd130x_primary_plane_funcs = {
@@ -1539,6 +1790,10 @@ static const struct drm_crtc_helper_funcs ssd130x_crtc_helper_funcs[] = {
 		.mode_valid = ssd130x_crtc_mode_valid,
 		.atomic_check = ssd133x_crtc_atomic_check,
 	},
+	[SSD135X_FAMILY] = {
+		.mode_valid = ssd130x_crtc_mode_valid,
+		.atomic_check = ssd133x_crtc_atomic_check,
+	},
 };
 
 static const struct drm_crtc_funcs ssd130x_crtc_funcs = {
@@ -1626,6 +1881,31 @@ static void ssd133x_encoder_atomic_enable(struct drm_encoder *encoder,
 	ssd130x_power_off(ssd130x);
 }
 
+static void ssd135x_encoder_atomic_enable(struct drm_encoder *encoder,
+					  struct drm_atomic_commit *state)
+{
+	struct drm_device *drm = encoder->dev;
+	struct ssd130x_device *ssd130x = drm_to_ssd130x(drm);
+	int ret;
+
+	ret = ssd130x_power_on(ssd130x);
+	if (ret)
+		return;
+
+	ret = ssd135x_init(ssd130x);
+	if (ret)
+		goto power_off;
+
+	ssd130x_write_cmd(ssd130x, 1, SSD13XX_DISPLAY_ON);
+
+	backlight_enable(ssd130x->bl_dev);
+
+	return;
+
+power_off:
+	ssd130x_power_off(ssd130x);
+}
+
 static void ssd130x_encoder_atomic_disable(struct drm_encoder *encoder,
 					   struct drm_atomic_commit *state)
 {
@@ -1651,7 +1931,11 @@ static const struct drm_encoder_helper_funcs ssd130x_encoder_helper_funcs[] = {
 	[SSD133X_FAMILY] = {
 		.atomic_enable = ssd133x_encoder_atomic_enable,
 		.atomic_disable = ssd130x_encoder_atomic_disable,
-	}
+	},
+	[SSD135X_FAMILY] = {
+		.atomic_enable = ssd135x_encoder_atomic_enable,
+		.atomic_disable = ssd130x_encoder_atomic_disable,
+	},
 };
 
 static const struct drm_encoder_funcs ssd130x_encoder_funcs = {
@@ -1728,6 +2012,15 @@ static int ssd133x_update_bl(struct backlight_device *bdev)
 	return ssd133x_set_contrast(ssd130x, ssd130x->contrast);
 }
 
+static int ssd135x_update_bl(struct backlight_device *bdev)
+{
+	struct ssd130x_device *ssd130x = bl_get_data(bdev);
+
+	ssd130x->contrast = backlight_get_brightness(bdev);
+
+	return ssd135x_set_contrast(ssd130x, ssd130x->contrast);
+}
+
 static const struct backlight_ops ssd130xfb_bl_ops[] = {
 	[SSD130X_FAMILY] = {
 		.update_status	= ssd130x_update_bl,
@@ -1738,6 +2031,9 @@ static const struct backlight_ops ssd130xfb_bl_ops[] = {
 	[SSD133X_FAMILY] = {
 		.update_status	= ssd133x_update_bl,
 	},
+	[SSD135X_FAMILY] = {
+		.update_status	= ssd135x_update_bl,
+	},
 };
 
 static void ssd130x_parse_properties(struct ssd130x_device *ssd130x)
diff --git a/drivers/gpu/drm/solomon/ssd130x.h b/drivers/gpu/drm/solomon/ssd130x.h
index a4554018bb2a..fd81262f2ceb 100644
--- a/drivers/gpu/drm/solomon/ssd130x.h
+++ b/drivers/gpu/drm/solomon/ssd130x.h
@@ -26,7 +26,8 @@
 enum ssd130x_family_ids {
 	SSD130X_FAMILY,
 	SSD132X_FAMILY,
-	SSD133X_FAMILY
+	SSD133X_FAMILY,
+	SSD135X_FAMILY,
 };
 
 enum ssd130x_variants {
@@ -42,6 +43,8 @@ enum ssd130x_variants {
 	SSD1327_ID,
 	/* ssd133x family */
 	SSD1331_ID,
+	/* ssd135x family */
+	SSD1351_ID,
 	NR_SSD130X_VARIANTS
 };
 
@@ -54,6 +57,11 @@ struct ssd130x_deviceinfo {
 	bool need_pwm;
 	bool need_chargepump;
 	bool page_mode_only;
+	/*
+	 * Whether the controller takes a command's parameters on the data path
+	 * instead of as further command bytes.
+	 */
+	bool cmd_params_are_data;
 
 	enum ssd130x_family_ids family_id;
 };
-- 
2.55.0

