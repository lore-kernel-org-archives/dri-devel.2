Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6747C88E6E
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 09:00:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8751910EC2D;
	Mon, 14 Sep 2026 09:00:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ruCt9Agq";
	dkim-atps=neutral
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBE6B10EC1F
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 09:00:29 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-4843e397f74so1822669f8f.1
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 02:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789376428; x=1789981228; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=v2HrjQPpcVWm6BhiXO9b7DCr+5kSL3AyFXfVdl7HOS4=;
 b=ruCt9Agqs0w1TekG9WHIluwWUHFY5qPgVmrTfsKJ62kLejL+HdehuS7CyP7Ao9VOJ7
 dyDO1SmH0o6wlhKkvPkN6IlVpADBJ01nVEDcDSgd7A1Jy6T3fp1BVyHu1ZfhIsg/HC8p
 /OGonyzAkTsHyzG4NVnoNTv2Vr/S2ntSmPXC1Y9NMMFx9uXywpzp30i1i11XLYXlMnsf
 EnLEzp4v5m8cc+M3jj0zcGrCrspCBxlvBu8Ir7ekFD16NflAKsYQHVPKeUiDwTef8imm
 UbXYVian03ya59roDLoLYj7N6vS1aeAHprUlMS1EBDFbDZpbZQ6+xxLKdQltx1Nlhgr9
 IFtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789376428; x=1789981228;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=v2HrjQPpcVWm6BhiXO9b7DCr+5kSL3AyFXfVdl7HOS4=;
 b=AqxQW8DCRx+UAeXDX6OzNpmeuthRqgiWGs8v6KkhGIkIk9Hn349VbKnpRm88/M+q1n
 UDBWRCzE1lwquVCb0T04Kq78H87BnsRJoCLit67YyS8hez00pwpaIgokCmX3Jef5RSfv
 otKWT0X9DnhPZhJ1SDLXw6/jvpke4Wt81Q3UAnZD5j6MN7rNNQueFyve4wR4I0jikIsm
 FwAWO3lSm5r9ttMXJmgK824m05Y0P8Ovk+KDlJ+dzrWoBb0vmWVmD/EGbhCQ4Q/zvbMO
 OFkN2X7Z9YEC5wiiBO245MSuvS6US98GbFxlRENDjZIM5nj7LR5AiNnW2OBDtqxep4Gp
 wMAQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxxf1xMa8bcERdsd39F1aIhr72H22c3T4p9/4RiH1KWkNofWDKqczBYbw1XRF6XYwHL1bqzm5b8q/A=@lists.freedesktop.org
X-Gm-Message-State: AFuF++m4jUQ847il2/KYI/76lmfZefhtdbbKQQ7mY9zJ9aqyTzpU9K1h
 BeahfPIIMD25JTOjaU5t94Wlg8vH8F+dF+xpnSpvAQJSHf48xOUdyP3vFW5HNQ==
X-Gm-Gg: AYBFou2fd27I/euul27KAjaZ/BX58gsUQt8TFSJl5IS3B/3sDarU4Jbl+NemEjJggIa
 KHsRGDvFX9zFf/cfvhrbs+pkTcixkov5S1yR6cDHM7Slbr15mMzDKi7NE5ykS2LhUEvMXiELf4w
 ijrtZtm3q39lf+3aAr7aYIM0Awf1O/9MLIzuXwEU8Wk9WxWMzzKlGsRfsFA9Ih9fq8wDUrVok5x
 BHCizITK5n9vzgNqonyftKR0m0HRXo1zOJl8NAPm6QfkOxdKLw7HGUiP8ClhcP9kXrrGCgLCPsS
 pbTAUlvJPFnx0ergDEbDoIt3nu/K0EZfY/MizQ/nvuJjeyoFZXcuEBqD/NrB5lYjpsLz8G/im0x
 Zz4r3ypu/S6eeT9Cm02hGFsJLGuw9A9epD+7/osvXGKYF4AMo8jnIjfnlu7O0Adns+s9tm8UOJ3
 iZhDsHwq4WPm1lGKliIS8h/2yBNhcqTdebKQVKMOfua2XsVnWdreSeEfiAw2A3xgmrNYjTzi7vf
 Lp3RuN3OK5t
X-Received: by 2002:a05:6000:4b17:b0:482:dd86:348 with SMTP id
 ffacd0b85a97d-486fc955dffmr6546190f8f.4.1789376427849; 
 Mon, 14 Sep 2026 02:00:27 -0700 (PDT)
Received: from anthony.local ([2a06:c701:9cc4:c200:33d8:8ea2:e077:ebe1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb32e7f5sm25245851f8f.9.2026.09.14.02.00.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 02:00:27 -0700 (PDT)
From: Amit Barzilai <amit.barzilai22@gmail.com>
To: javierm@redhat.com, airlied@gmail.com, simona@ffwll.ch,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: andriy.shevchenko@intel.com, holofermes@gmail.com,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, amit.barzilai22@gmail.com
Subject: [PATCH v6 6/6] drm/ssd130x: Add SSD135X_FAMILY and SSD1351 support
Date: Mon, 14 Sep 2026 11:59:31 +0300
Message-ID: <20260914085931.66857-7-amit.barzilai22@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260914085931.66857-1-amit.barzilai22@gmail.com>
References: <20260914085931.66857-1-amit.barzilai22@gmail.com>
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

Assisted-by: LLM
Signed-off-by: Amit Barzilai <amit.barzilai22@gmail.com>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
---
 drivers/gpu/drm/solomon/ssd130x-spi.c |   7 +
 drivers/gpu/drm/solomon/ssd130x.c     | 312 +++++++++++++++++++++++++-
 drivers/gpu/drm/solomon/ssd130x.h     |  10 +-
 3 files changed, 322 insertions(+), 7 deletions(-)

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
index fd13250ef56a..324467ae9309 100644
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
@@ -271,6 +310,18 @@ static int ssd130x_write_cmds(struct ssd130x_device *ssd130x, const u8 *cmd,
 	unsigned int i;
 	int ret;
 
+	if (!len)
+		return 0;
+
+	if (ssd130x->device_info->cmd_params_are_data) {
+		ret = regmap_write(ssd130x->regmap, SSD13XX_COMMAND, cmd[0]);
+		/* A command with no parameters is complete after its opcode. */
+		if (ret || len == 1)
+			return ret;
+
+		return ssd130x_write_data(ssd130x, cmd + 1, len - 1);
+	}
+
 	for (i = 0; i < len; i++) {
 		ret = regmap_write(ssd130x->regmap, SSD13XX_COMMAND, cmd[i]);
 		if (ret)
@@ -617,6 +668,20 @@ static int ssd133x_set_contrast(struct ssd130x_device *ssd130x, u32 brightness)
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
@@ -654,6 +719,47 @@ static int ssd133x_init(struct ssd130x_device *ssd130x)
 	return ssd130x_run_cmd_seq(ssd130x, cmds);
 }
 
+static int ssd135x_init(struct ssd130x_device *ssd130x)
+{
+	/*
+	 * Horizontal address increment, COM split, reversed COM scan direction,
+	 * BGR sub-pixel order and 65k (RGB565) color depth. Rotation is not
+	 * supported, so the remap byte is fixed.
+	 */
+	const u8 remap = SSD135X_SET_REMAP_65K | SSD135X_SET_REMAP_COM_SPLIT |
+			 SSD135X_SET_REMAP_COLOR_BGR | SSD135X_SET_REMAP_COM_SCAN;
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
+	int ret;
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
@@ -863,6 +969,44 @@ static int ssd133x_update_rect(struct ssd130x_device *ssd130x,
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
@@ -932,6 +1076,23 @@ static void ssd133x_clear_screen(struct ssd130x_device *ssd130x, u8 *data_array)
 	ssd130x_write_data(ssd130x, data_array, pitch * ssd130x->height);
 }
 
+static void ssd135x_clear_screen(struct ssd130x_device *ssd130x, u8 *data_array)
+{
+	struct drm_rect screen = DRM_RECT_INIT(0, 0, ssd130x->width, ssd130x->height);
+	const struct drm_format_info *fi;
+	unsigned int pitch;
+
+	fi = drm_format_info(DRM_FORMAT_RGB565);
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
@@ -1005,6 +1166,30 @@ static int ssd133x_fb_blit_rect(struct drm_framebuffer *fb,
 	return 0;
 }
 
+static int ssd135x_fb_blit_rect(struct drm_framebuffer *fb,
+				const struct iosys_map *vmap,
+				struct drm_rect *rect, u8 *data_array,
+				struct drm_format_conv_state *fmtcnv_state)
+{
+	struct ssd130x_device *ssd130x = drm_to_ssd130x(fb->dev);
+	const struct drm_format_info *fi;
+	unsigned int dst_pitch;
+	struct iosys_map dst;
+
+	fi = drm_format_info(DRM_FORMAT_RGB565);
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
@@ -1247,6 +1432,45 @@ static void ssd133x_primary_plane_atomic_update(struct drm_plane *plane,
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
@@ -1319,6 +1543,31 @@ static void ssd133x_primary_plane_atomic_disable(struct drm_plane *plane,
 	drm_dev_exit(idx);
 }
 
+static void ssd135x_primary_plane_atomic_disable(struct drm_plane *plane,
+						 struct drm_atomic_commit *state)
+{
+	struct drm_device *drm = plane->dev;
+	struct ssd130x_device *ssd130x = drm_to_ssd130x(drm);
+	struct drm_plane_state *plane_state;
+	struct drm_crtc_state *crtc_state;
+	struct ssd130x_crtc_state *ssd130x_crtc_state;
+	int idx;
+
+	plane_state = drm_atomic_get_new_plane_state(state, plane);
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
 static struct drm_plane_state *ssd130x_primary_plane_create_state(struct drm_plane *plane)
 {
@@ -1387,7 +1636,13 @@ static const struct drm_plane_helper_funcs ssd130x_primary_plane_helper_funcs[]
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
@@ -1544,6 +1799,10 @@ static const struct drm_crtc_helper_funcs ssd130x_crtc_helper_funcs[] = {
 		.mode_valid = ssd130x_crtc_mode_valid,
 		.atomic_check = ssd133x_crtc_atomic_check,
 	},
+	[SSD135X_FAMILY] = {
+		.mode_valid = ssd130x_crtc_mode_valid,
+		.atomic_check = ssd133x_crtc_atomic_check,
+	},
 };
 
 static const struct drm_crtc_funcs ssd130x_crtc_funcs = {
@@ -1631,6 +1890,31 @@ static void ssd133x_encoder_atomic_enable(struct drm_encoder *encoder,
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
@@ -1656,7 +1940,11 @@ static const struct drm_encoder_helper_funcs ssd130x_encoder_helper_funcs[] = {
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
@@ -1733,6 +2021,15 @@ static int ssd133x_update_bl(struct backlight_device *bdev)
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
@@ -1743,6 +2040,9 @@ static const struct backlight_ops ssd130xfb_bl_ops[] = {
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

