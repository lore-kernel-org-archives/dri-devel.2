Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9573606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 20:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ToQYG/zS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40E7E10E651;
	Thu, 29 Oct 2026 20:58:53 +0000 (UTC)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com
 [209.85.160.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07FF510E834
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 20:58:47 +0000 (UTC)
Received: by mail-qt1-f173.google.com with SMTP id
 d75a77b69052e-535179e995bso24930461cf.0
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 13:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793307526; x=1793912326; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=v0nueKfM1lSAPftYVoSLUkDbPpn2D3P/t5rVcRmFMj8=;
 b=ToQYG/zSfMZesAhfxb+W1ngIkNKBs+Np/nsw56z0sEyV3ayWNQ/p9FgrNyThPGCtPG
 dQiuQw6kyTq6IZznWd/piBFx9b7yb9D+j56OXE5penX5VjhXksw2CjZan7xqadydxkKk
 bfaV28Yb8OdsL7BmXAHyp4hR/0O38YKRrsK3vhp4WQ13PlORaIefamIyLCqdfpew/gXK
 uSfsuLLfuaHywkbbEHzUXGhCLPJrhstn1D32ZI3MOPqhqGqqsvbYVMiPBZ//GRivVO07
 jxDT60rQ9LwrZ7fk4oLx6NnUhXPLEn0mUXyTOT5ABdhZID9pt0gzKcKEm609N+qovSUQ
 92vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793307526; x=1793912326;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=v0nueKfM1lSAPftYVoSLUkDbPpn2D3P/t5rVcRmFMj8=;
 b=zH+37tb3i1UBRrERg5/AtPUcdFr2zuCVS4KprA97hR/QIXKlf1Gf77dVYINFp8upKm
 McIbQqbpOScos5y/pSDSARU6tIvVAR8D5ZWqCX3fJLMzVB4jMaqWNNtWPq0oiCVD/uFA
 C3DdAiNAfkk48DdtmfL/xrtWrFcBegcaQNJAAvumEz1dtvrPSwfHrwJNsYtfpbtvphus
 zbeHEFLeMWteOMo/R9j1rmFvX4vKvym7QRVAGu/98hk2MAPwf0y8MYecR0CqkU1qlPg2
 Lxy89d2mpbktZa5GZsEu4DW/Meb5xY5li1aNgCa6g+136ScisQvUsV6FsEyV/UsIGTom
 qqfw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwA08jc5Eq2XszCn+13eyVBU7BpXG5kJaQX/FK3mADYccp/U/CIuGituiSwOXjA6m4ypGjO/Scr/8A=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKaJ6whLHMZb0crBdxMcqHIKGYoY7MMk5zCwXFW9ZCPCDT27xHP
 4atCgHoU4l8jLFEWQw5KGvNZs16qRTigC1rQYyL4ug4TXtiwkyVrxDWh
X-Gm-Gg: AYBFou1RGIDGCqGrOy4dIikpif1Pr6x58TCN4is8pZHUPKiUAMWvNNGfnTBuPtrW/fQ
 E94XVlK42zzbxRsD3/BsOX6yaFQGeaihRJtuUN5Q01kFBwMoogbwliO0A4HAVSte/RmViT9P+4i
 qw4pJUbjZjdjPvKg+3p8GaMi6yV5hN3O7MO2TtCTszzaYtv4tLC2h+YG2RMRW1F6rCfVy5UkP9m
 LNJMY622knfbUBjInm4oB7XTlHJRI3xHa7F57tCzsan3RdjzwKyWGOw+s7/Rjjw/GYbqPlX4pUP
 s1ObwaWo3ukOT2fKJ2mGBPEUhT4VFBYTm5uAQRR8NU80Igmo8McBmkjizH948RyvWQQT8aZBVZ7
 VsHGhB/IxscQq0RgFf2dA8+CmLWV3b+7ndEGgPZ2pboNUtZBfb2cgc9nfjJJlAHp2q/0uFW2XMu
 WTKgGPY/ZpqUi8wPenq8XwdsXFouCe3FgTZfXw3YEol8agPCHQmYJVMjpMuwBnYccC9WHaG/iBV
 3WOrxHJ+62KYHsmegQ994GZt67Ehmgww6HTQ8sX8v/fuufdq0YKYPX2NnHAixOlr+2BmGIYdoRz
 9KJxsOQpKZTyYs+OQ4NlRPXGe14exe8VC4sfhLGy+cviUMc=
X-Received: by 2002:a05:622a:488:b0:535:dd0a:c09e with SMTP id
 d75a77b69052e-542b85e3f81mr3752831cf.74.1793307525763; 
 Thu, 29 Oct 2026 13:58:45 -0700 (PDT)
Received: from holowork.tail3176d.ts.net ([71.104.86.121])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91ca31032c9sm6006136d6.21.2026.10.29.13.58.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 13:58:43 -0700 (PDT)
From: Fabio Piparo <holofermes@gmail.com>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Amit Barzilai <amit.barzilai22@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Fabio Piparo <holofermes@gmail.com>
Subject: [PATCH 2/2] drm/ssd130x: Add SSD1322_FAMILY and move the SSD1322 to it
Date: Thu, 29 Oct 2026 16:57:51 -0400
Message-ID: <20261029205751.3513474-3-holofermes@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261029205751.3513474-1-holofermes@gmail.com>
References: <20261029205751.3513474-1-holofermes@gmail.com>
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

The SSD1322 has been in the match tables since commit fdd591e00a9c
("drm/ssd130x: Add support for the SSD132x OLED controller family") as
a member of the ssd132x family, which was brought up on an SSD1327. The
two controllers share the 4-bit grayscale RAM layout and many opcodes,
but the ssd132x paths cannot produce an image on an SSD1322:

- A command's parameters travel on the data path, as on the SSD1351,
  so every multi-byte command in ssd132x_init() is read as a run of
  single opcodes.
- Some of the opcodes differ: 0xa4 is "entire display off" on the
  SSD1322 and normal display mode is 0xa6, the multiplex ratio command
  is 0xca, the contrast command 0xc1 and the precharge voltage command
  0xbb.
- A column address covers four Segments instead of two, the RAM only
  accepts pixel data after a Write RAM command (0x5c), and with nibble
  remap the leftmost pixel of a pair is the high nibble.

Give the SSD1322 its own family, shaped like ssd135x: an init
table, a Write RAM before the pixel data, a contrast command with its
value in the data phase, and its own plane update, encoder enable and
backlight callbacks.

The init sequence follows the Newhaven NHD-3.12-25664UCW2 datasheet,
including its analog settings for the module (external VSL, precharge,
VCOMH), with three changes: the display clock and the column offset come
from the device tree, the contrast is the backlight brightness and is set
after the sequence, and dual COM line mode, which the datasheet only
allows up to 64 rows, is turned off for taller panels.

Assisted-by: LLM
Signed-off-by: Fabio Piparo <holofermes@gmail.com>
---
 drivers/gpu/drm/solomon/ssd130x-i2c.c |   3 +-
 drivers/gpu/drm/solomon/ssd130x-spi.c |   6 +-
 drivers/gpu/drm/solomon/ssd130x.c     | 277 +++++++++++++++++++++++++-
 drivers/gpu/drm/solomon/ssd130x.h     |   4 +-
 4 files changed, 281 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/solomon/ssd130x-i2c.c b/drivers/gpu/drm/solomon/ssd130x-i2c.c
index 941a2eb44c5..5b85d000c57 100644
--- a/drivers/gpu/drm/solomon/ssd130x-i2c.c
+++ b/drivers/gpu/drm/solomon/ssd130x-i2c.c
@@ -92,11 +92,12 @@ static const struct of_device_id ssd130x_of_match[] = {
 		.compatible = "solomon,ssd1309fb-i2c",
 		.data = &ssd130x_variants[SSD1309_ID],
 	},
-	/* ssd132x family */
+	/* ssd1322 family */
 	{
 		.compatible = "solomon,ssd1322",
 		.data = &ssd130x_variants[SSD1322_ID],
 	},
+	/* ssd132x family */
 	{
 		.compatible = "solomon,ssd1325",
 		.data = &ssd130x_variants[SSD1325_ID],
diff --git a/drivers/gpu/drm/solomon/ssd130x-spi.c b/drivers/gpu/drm/solomon/ssd130x-spi.c
index c41064aa822..dba35c2e881 100644
--- a/drivers/gpu/drm/solomon/ssd130x-spi.c
+++ b/drivers/gpu/drm/solomon/ssd130x-spi.c
@@ -128,11 +128,12 @@ static const struct of_device_id ssd130x_of_match[] = {
 		.compatible = "solomon,ssd1309",
 		.data = &ssd130x_variants[SSD1309_ID],
 	},
-	/* ssd132x family */
+	/* ssd1322 family */
 	{
 		.compatible = "solomon,ssd1322",
 		.data = &ssd130x_variants[SSD1322_ID],
 	},
+	/* ssd132x family */
 	{
 		.compatible = "solomon,ssd1325",
 		.data = &ssd130x_variants[SSD1325_ID],
@@ -170,8 +171,9 @@ static const struct spi_device_id ssd130x_spi_id[] = {
 	{ .name = "ssd1306", .driver_data = SSD1306_ID },
 	{ .name = "ssd1307", .driver_data = SSD1307_ID },
 	{ .name = "ssd1309", .driver_data = SSD1309_ID },
-	/* ssd132x family */
+	/* ssd1322 family */
 	{ .name = "ssd1322", .driver_data = SSD1322_ID },
+	/* ssd132x family */
 	{ .name = "ssd1325", .driver_data = SSD1325_ID },
 	{ .name = "ssd1327", .driver_data = SSD1327_ID },
 	/* ssd133x family */
diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd130x.c
index ee43cf0da87..7ea92d72326 100644
--- a/drivers/gpu/drm/solomon/ssd130x.c
+++ b/drivers/gpu/drm/solomon/ssd130x.c
@@ -14,6 +14,7 @@
 #include <linux/bits.h>
 #include <linux/delay.h>
 #include <linux/gpio/consumer.h>
+#include <linux/log2.h>
 #include <linux/math.h>
 #include <linux/property.h>
 #include <linux/pwm.h>
@@ -47,6 +48,7 @@
 #define SSD130X_PAGE_HEIGHT 8
 
 #define SSD132X_SEGMENT_WIDTH 2
+#define SSD1322_SEGMENT_WIDTH 4
 
 /* ssd13xx commands */
 #define SSD13XX_CONTRAST			0x81
@@ -182,6 +184,38 @@
 #define SSD135X_SET_REMAP_COM_SPLIT		BIT(5)
 #define SSD135X_SET_REMAP_65K			BIT(6)
 
+/* ssd1322 commands */
+#define SSD1322_WRITE_RAM			0x5c
+#define SSD1322_SET_REMAP			0xa0
+#define SSD1322_SET_DISPLAY_START		0xa1
+#define SSD1322_SET_DISPLAY_OFFSET		0xa2
+#define SSD1322_SET_DISPLAY_NORMAL		0xa6
+#define SSD1322_EXIT_PARTIAL_DISPLAY		0xa9
+#define SSD1322_SET_FUNCTION_SELECT_A		0xab
+#define SSD1322_SET_PHASE_LENGTH		0xb1
+#define SSD1322_SET_CLOCK_FREQ			0xb3
+#define SSD1322_SET_DISPLAY_ENHANCE_A		0xb4
+#define SSD1322_SET_GPIO			0xb5
+#define SSD1322_SET_PRECHARGE_PERIOD		0xb6
+#define SSD1322_SELECT_DEFAULT_TABLE		0xb9
+#define SSD1322_SET_PRECHARGE_VOLTAGE		0xbb
+#define SSD1322_SET_VCOMH_VOLTAGE		0xbe
+#define SSD1322_SET_CONTRAST_CURRENT		0xc1
+#define SSD1322_SET_MASTER_CONTRAST		0xc7
+#define SSD1322_SET_MULTIPLEX_RATIO		0xca
+#define SSD1322_SET_DISPLAY_ENHANCE_B		0xd1
+#define SSD1322_SET_COMMAND_LOCK		0xfd
+
+/* ssd1322 remap first byte (data of SSD1322_SET_REMAP) */
+#define SSD1322_SET_REMAP_NIBBLE		BIT(2)
+#define SSD1322_SET_REMAP_COM_SCAN		BIT(4)
+/* ssd1322 remap second byte (data of SSD1322_SET_REMAP) */
+#define SSD1322_SET_REMAP_B_RESERVED		BIT(0)
+#define SSD1322_SET_REMAP_DUAL_COM		BIT(4)
+
+#define SSD1322_CLOCK_DIV_MAX			1024
+#define SSD1322_DUAL_COM_MAX_HEIGHT		64
+
 #define MAX_CONTRAST 255
 
 const struct ssd130x_deviceinfo ssd130x_variants[] = {
@@ -229,11 +263,6 @@ const struct ssd130x_deviceinfo ssd130x_variants[] = {
 		.family_id = SSD130X_FAMILY,
 	},
 	/* ssd132x family */
-	[SSD1322_ID] = {
-		.default_width = 480,
-		.default_height = 128,
-		.family_id = SSD132X_FAMILY,
-	},
 	[SSD1325_ID] = {
 		.default_width = 128,
 		.default_height = 80,
@@ -257,6 +286,15 @@ const struct ssd130x_deviceinfo ssd130x_variants[] = {
 		.family_id = SSD135X_FAMILY,
 		.cmd_params_are_data = true,
 	},
+	/* ssd1322 family */
+	[SSD1322_ID] = {
+		.default_width = 480,
+		.default_height = 128,
+		.default_dclk_div = 2,
+		.default_dclk_frq = 9,
+		.family_id = SSD1322_FAMILY,
+		.cmd_params_are_data = true,
+	},
 };
 EXPORT_SYMBOL_NS_GPL(ssd130x_variants, "DRM_SSD130X");
 
@@ -774,6 +812,66 @@ static int ssd135x_init(struct ssd130x_device *ssd130x)
 	return ssd135x_set_contrast(ssd130x, ssd130x->contrast);
 }
 
+static int ssd1322_set_contrast(struct ssd130x_device *ssd130x, u32 brightness)
+{
+	return ssd130x_write_cmd(ssd130x, 2, SSD1322_SET_CONTRAST_CURRENT, brightness);
+}
+
+static int ssd1322_init(struct ssd130x_device *ssd130x)
+{
+	unsigned int columns = DIV_ROUND_UP(ssd130x->width, SSD1322_SEGMENT_WIDTH);
+	u8 dclk = SSD130X_SET_CLOCK_DIV_SET(ilog2(ssd130x->dclk_div)) |
+		  SSD130X_SET_CLOCK_FREQ_SET(ssd130x->dclk_frq);
+	/*
+	 * Horizontal address increment, nibble remap and reversed COM scan
+	 * direction. Rotation is not supported, so the remap bytes are fixed.
+	 */
+	const u8 remap = SSD1322_SET_REMAP_NIBBLE | SSD1322_SET_REMAP_COM_SCAN;
+	const u8 remap_b = SSD1322_SET_REMAP_B_RESERVED |
+			   (ssd130x->height <= SSD1322_DUAL_COM_MAX_HEIGHT ?
+			    SSD1322_SET_REMAP_DUAL_COM : 0);
+	const u8 cmds[] = {
+		/* Unlock the controller */
+		2, SSD1322_SET_COMMAND_LOCK, 0x12,
+		1, SSD13XX_DISPLAY_OFF,
+		3, SSD132X_SET_COL_RANGE, ssd130x->col_offset,
+		   ssd130x->col_offset + columns - 1,
+		3, SSD132X_SET_ROW_RANGE, 0x00, ssd130x->height - 1,
+		2, SSD1322_SET_CLOCK_FREQ, dclk,
+		2, SSD1322_SET_MULTIPLEX_RATIO, ssd130x->height - 1,
+		2, SSD1322_SET_DISPLAY_OFFSET, 0x00,
+		2, SSD1322_SET_DISPLAY_START, 0x00,
+		3, SSD1322_SET_REMAP, remap, remap_b,
+		2, SSD1322_SET_GPIO, 0x00,
+		2, SSD1322_SET_FUNCTION_SELECT_A, 0x01,
+		3, SSD1322_SET_DISPLAY_ENHANCE_A, 0xa0, 0xfd,
+		2, SSD1322_SET_MASTER_CONTRAST, 0x0f,
+		1, SSD1322_SELECT_DEFAULT_TABLE,
+		2, SSD1322_SET_PHASE_LENGTH, 0xe2,
+		3, SSD1322_SET_DISPLAY_ENHANCE_B, 0xa2, 0x20,
+		2, SSD1322_SET_PRECHARGE_VOLTAGE, 0x1f,
+		2, SSD1322_SET_PRECHARGE_PERIOD, 0x08,
+		2, SSD1322_SET_VCOMH_VOLTAGE, 0x07,
+		1, SSD1322_SET_DISPLAY_NORMAL,
+		1, SSD1322_EXIT_PARTIAL_DISPLAY,
+		0,
+	};
+	int ret;
+
+	if (!is_power_of_2(ssd130x->dclk_div) ||
+	    ssd130x->dclk_div > SSD1322_CLOCK_DIV_MAX) {
+		drm_err(&ssd130x->drm, "Invalid display clock divisor %u\n",
+			ssd130x->dclk_div);
+		return -EINVAL;
+	}
+
+	ret = ssd130x_run_cmd_seq(ssd130x, cmds);
+	if (ret < 0)
+		return ret;
+
+	return ssd1322_set_contrast(ssd130x, ssd130x->contrast);
+}
+
 static int ssd130x_update_rect(struct ssd130x_device *ssd130x,
 			       struct drm_rect *rect, u8 *buf,
 			       u8 *data_array)
@@ -1020,6 +1118,35 @@ static int ssd135x_update_rect(struct ssd130x_device *ssd130x,
 	return ssd130x_write_data(ssd130x, data_array, pitch * rows);
 }
 
+static int ssd1322_update_rect(struct ssd130x_device *ssd130x,
+			       struct drm_rect *rect, u8 *data_array,
+			       unsigned int pitch)
+{
+	unsigned int col = ssd130x->col_offset + rect->x1 / SSD1322_SEGMENT_WIDTH;
+	unsigned int columns = DIV_ROUND_UP(drm_rect_width(rect), SSD1322_SEGMENT_WIDTH);
+	unsigned int rows = drm_rect_height(rect);
+	struct drm_device *drm = &ssd130x->drm;
+	int ret;
+
+	drm_WARN_ONCE(drm, rect->x1 % SSD1322_SEGMENT_WIDTH != 0,
+		      "x must be aligned to screen segment\n");
+
+	ret = ssd132x_set_col_range(ssd130x, col, columns);
+	if (ret < 0)
+		return ret;
+
+	ret = ssd132x_set_row_range(ssd130x, rect->y1, rows);
+	if (ret < 0)
+		return ret;
+
+	ret = ssd130x_write_cmd(ssd130x, 1, SSD1322_WRITE_RAM);
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
@@ -1212,6 +1339,45 @@ static int ssd135x_fb_blit_rect(struct drm_framebuffer *fb,
 	return 0;
 }
 
+static int ssd1322_fb_blit_rect(struct drm_framebuffer *fb,
+				const struct iosys_map *vmap,
+				struct drm_rect *rect, u8 *buf,
+				u8 *data_array,
+				struct drm_format_conv_state *fmtcnv_state)
+{
+	struct ssd130x_device *ssd130x = drm_to_ssd130x(fb->dev);
+	unsigned int width, height, pitch;
+	unsigned int i, j;
+	u32 array_idx = 0;
+	struct iosys_map dst;
+
+	/* Align x to display segment boundaries */
+	rect->x1 = round_down(rect->x1, SSD1322_SEGMENT_WIDTH);
+	rect->x2 = min_t(unsigned int, round_up(rect->x2, SSD1322_SEGMENT_WIDTH),
+			 ssd130x->width);
+
+	width = drm_rect_width(rect);
+	height = drm_rect_height(rect);
+	pitch = DIV_ROUND_UP(width, 2);
+
+	iosys_map_set_vaddr(&dst, buf);
+	drm_fb_xrgb8888_to_gray8(&dst, &width, vmap, fb, rect, fmtcnv_state);
+
+	for (i = 0; i < height; i++) {
+		/* Process pair of pixels and combine them into a single byte */
+		for (j = 0; j < width; j += 2) {
+			u8 n1 = buf[i * width + j];
+			u8 n2 = j + 1 < width ? buf[i * width + j + 1] : 0;
+
+			data_array[array_idx++] = (n1 & 0xf0) | (n2 >> 4);
+		}
+	}
+
+	ssd1322_update_rect(ssd130x, rect, data_array, pitch);
+
+	return 0;
+}
+
 static int ssd130x_primary_plane_atomic_check(struct drm_plane *plane,
 					      struct drm_atomic_commit *state)
 {
@@ -1493,6 +1659,47 @@ static void ssd135x_primary_plane_atomic_update(struct drm_plane *plane,
 	drm_dev_exit(idx);
 }
 
+static void ssd1322_primary_plane_atomic_update(struct drm_plane *plane,
+						struct drm_atomic_commit *state)
+{
+	struct drm_plane_state *plane_state = drm_atomic_get_new_plane_state(state, plane);
+	struct drm_plane_state *old_plane_state = drm_atomic_get_old_plane_state(state, plane);
+	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(plane_state);
+	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state, plane_state->crtc);
+	struct ssd130x_crtc_state *ssd130x_crtc_state =  to_ssd130x_crtc_state(crtc_state);
+	struct ssd130x_plane_state *ssd130x_plane_state = to_ssd130x_plane_state(plane_state);
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
+		ssd1322_fb_blit_rect(fb, &shadow_plane_state->data[0], &dst_clip,
+				     ssd130x_plane_state->buffer,
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
@@ -1590,6 +1797,15 @@ static void ssd135x_primary_plane_atomic_disable(struct drm_plane *plane,
 	drm_dev_exit(idx);
 }
 
+static void ssd1322_primary_plane_atomic_disable(struct drm_plane *plane,
+						 struct drm_atomic_commit *state)
+{
+	/*
+	 * Keep this empty function to avoid calling
+	 * atomic_update when disabling the plane.
+	 */
+}
+
 /* Called during init to allocate the plane's atomic state. */
 static struct drm_plane_state *ssd130x_primary_plane_create_state(struct drm_plane *plane)
 {
@@ -1665,6 +1881,12 @@ static const struct drm_plane_helper_funcs ssd130x_primary_plane_helper_funcs[]
 		.atomic_update = ssd135x_primary_plane_atomic_update,
 		.atomic_disable = ssd135x_primary_plane_atomic_disable,
 	},
+	[SSD1322_FAMILY] = {
+		DRM_GEM_SHADOW_PLANE_HELPER_FUNCS,
+		.atomic_check = ssd132x_primary_plane_atomic_check,
+		.atomic_update = ssd1322_primary_plane_atomic_update,
+		.atomic_disable = ssd1322_primary_plane_atomic_disable,
+	},
 };
 
 static const struct drm_plane_funcs ssd130x_primary_plane_funcs = {
@@ -1825,6 +2047,10 @@ static const struct drm_crtc_helper_funcs ssd130x_crtc_helper_funcs[] = {
 		.mode_valid = ssd130x_crtc_mode_valid,
 		.atomic_check = ssd133x_crtc_atomic_check,
 	},
+	[SSD1322_FAMILY] = {
+		.mode_valid = ssd130x_crtc_mode_valid,
+		.atomic_check = ssd132x_crtc_atomic_check,
+	},
 };
 
 static const struct drm_crtc_funcs ssd130x_crtc_funcs = {
@@ -1937,6 +2163,31 @@ static void ssd135x_encoder_atomic_enable(struct drm_encoder *encoder,
 	ssd130x_power_off(ssd130x);
 }
 
+static void ssd1322_encoder_atomic_enable(struct drm_encoder *encoder,
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
+	ret = ssd1322_init(ssd130x);
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
@@ -1967,6 +2218,10 @@ static const struct drm_encoder_helper_funcs ssd130x_encoder_helper_funcs[] = {
 		.atomic_enable = ssd135x_encoder_atomic_enable,
 		.atomic_disable = ssd130x_encoder_atomic_disable,
 	},
+	[SSD1322_FAMILY] = {
+		.atomic_enable = ssd1322_encoder_atomic_enable,
+		.atomic_disable = ssd130x_encoder_atomic_disable,
+	},
 };
 
 static const struct drm_encoder_funcs ssd130x_encoder_funcs = {
@@ -2052,6 +2307,15 @@ static int ssd135x_update_bl(struct backlight_device *bdev)
 	return ssd135x_set_contrast(ssd130x, ssd130x->contrast);
 }
 
+static int ssd1322_update_bl(struct backlight_device *bdev)
+{
+	struct ssd130x_device *ssd130x = bl_get_data(bdev);
+
+	ssd130x->contrast = backlight_get_brightness(bdev);
+
+	return ssd1322_set_contrast(ssd130x, ssd130x->contrast);
+}
+
 static const struct backlight_ops ssd130xfb_bl_ops[] = {
 	[SSD130X_FAMILY] = {
 		.update_status	= ssd130x_update_bl,
@@ -2065,6 +2329,9 @@ static const struct backlight_ops ssd130xfb_bl_ops[] = {
 	[SSD135X_FAMILY] = {
 		.update_status	= ssd135x_update_bl,
 	},
+	[SSD1322_FAMILY] = {
+		.update_status	= ssd1322_update_bl,
+	},
 };
 
 static void ssd130x_parse_properties(struct ssd130x_device *ssd130x)
diff --git a/drivers/gpu/drm/solomon/ssd130x.h b/drivers/gpu/drm/solomon/ssd130x.h
index fd81262f2ce..b49bbf36228 100644
--- a/drivers/gpu/drm/solomon/ssd130x.h
+++ b/drivers/gpu/drm/solomon/ssd130x.h
@@ -28,6 +28,7 @@ enum ssd130x_family_ids {
 	SSD132X_FAMILY,
 	SSD133X_FAMILY,
 	SSD135X_FAMILY,
+	SSD1322_FAMILY,
 };
 
 enum ssd130x_variants {
@@ -37,8 +38,9 @@ enum ssd130x_variants {
 	SSD1306_ID,
 	SSD1307_ID,
 	SSD1309_ID,
-	/* ssd132x family */
+	/* ssd1322 family */
 	SSD1322_ID,
+	/* ssd132x family */
 	SSD1325_ID,
 	SSD1327_ID,
 	/* ssd133x family */
-- 
2.53.0

