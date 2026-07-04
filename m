Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18D1EC44500
	for <dri-devel@archiver.kernel.org>; Sat,  4 Jul 2026 08:09:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B7FD10E04E;
	Sat,  4 Jul 2026 08:09:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CmhA/3A2";
	dkim-atps=neutral
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4B6810E046
 for <dri-devel@lists.freedesktop.org>; Sat,  4 Jul 2026 08:09:50 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-4758bd3731bso957698f8f.0
 for <dri-devel@lists.freedesktop.org>; Sat, 04 Jul 2026 01:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783152589; x=1783757389; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OYDxuX3FVRBJpJ1bDqTLna4Pl7UtMkhAxcFqUu25+/4=;
 b=CmhA/3A2EbSVh5AI/B2R/vEmvgGuhc73vBnU5M3TRkseErJRCK24brANCW/tAydzy1
 FOFtixkRAV2cBebsI96+i9wEFLMcA9Hofpos9XmXMFf7z6Ki7+/zZThsZ1yzLGKXbeda
 Wb0bPfERLVYZlAx6jXZuiq4FMxVl+bnuemn8lit12ddEvtBVfi/GoPzw9HgKLqBaLXuQ
 I0gEmNteOf4ppK8npm2lTQviEq5UOOLGYoROdSeEqedMhlx4P2QmPvRiKCqqNQMOJdwB
 QWvKrSNmAUWh3cJtQZsBZobJ3h0tOCW77Hfieq2elhqGbsLxZe+wnV9uD/SWleQeSE3o
 LwwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783152589; x=1783757389;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OYDxuX3FVRBJpJ1bDqTLna4Pl7UtMkhAxcFqUu25+/4=;
 b=HP9Y6KnqhN7cq6y9FIN+m7WphQDIqUrfn+gL9UKptcOGgkZu5J7RQTmLXXt7yBe9+e
 xDfLHzI5UqEYDOzpNzi4yji500zxNy9YoioYsZjqfM66VZDaA8y4bvtP0wgGaXjoVTlc
 ve31ZwWcE3L27HO+yXAAFo0uM/RelLpD47y9E9BhTnrqas8rX9XZH0Rbe3kARP5hogAj
 SUwyaH9QdKogWtAlI+l5V3zVyDtZ5QpIe9QHACqGp1ztYoz5xvs6umpCdOi69ZpZz7Fm
 fumXst8cTs2CsyCRtofEmPsXdVwgZRBWra7hH/HNeIoGrRNU04smbslUmXdKAJx5GNr5
 vFnQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqneQro8gvlfmXWnS8qIukT5RsMesEJbQO6OMF27vYEmKW4lQrhnPhsMQ48PFhTkRTZagrsv/tl0RU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxZ+bkOcTkY5r7xYUZkN1xrz7oAwFpWVtQgsKO8ydAH2Eh4i+eD
 NYM15TIc8ooW7deydRUwKZwuEzViRyIYbxhObXK3VGiHuwwpsEyYs347
X-Gm-Gg: AfdE7ckwonisU0y7K2pzq45LcFYqapbn+ojXsTqB/nc74wvSG9jLU77iPXZgVrz4WZC
 jg2kySMtmWeZZNhhcC033hAPX3XGkIUCB6nyr1qJ2LkwFpme4txVqvtKLiqVVDik2ZD55ae0hIW
 XMAKx05WXI7cnfWeDs6mICxxIIBOTcoPiVZe471geRdGcXzqodL4DgEfGM0pprEkMYGU3L9xwX6
 rXupqJRfZCA9tRofKlBpRyt0dtkCZHNboY5fCwsBR/f2doznxrlIj8sp0mf4UCbCDpl+XijR1TW
 gfhBbmkWRiJeeIT3LSEIdiLMOVHS2aNafRR5FnGYgHT0vhVTZEgvaYyDb+OLAPo3whuAuvEdquq
 Kji40a564u8urbABocRYG70Ea2SuFyyXEcJrBov34cfxx7cPhsfRDzxGPfiDxbfkKJOuO+c7C6l
 efwJCFwUnQHkcy17aof7v6KUyqhrU=
X-Received: by 2002:a05:6000:288b:b0:475:b34a:dc1b with SMTP id
 ffacd0b85a97d-47abc8b7f0bmr2340050f8f.21.1783152589095; 
 Sat, 04 Jul 2026 01:09:49 -0700 (PDT)
Received: from anthony.local ([2a06:c701:49b2:4c00:12ff:e0ff:fea5:3d2e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa0960634sm6143055f8f.26.2026.07.04.01.09.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2026 01:09:48 -0700 (PDT)
From: Amit Barzilai <amit.barzilai22@gmail.com>
To: Javier Martinez Canillas <javierm@redhat.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>,
 dri-devel@lists.freedesktop.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Amit Barzilai <amit.barzilai22@gmail.com>
Subject: [PATCH v3 3/3] drm/ssd130x: Add SSD135X_FAMILY and SSD1351 support
Date: Sat,  4 Jul 2026 11:09:25 +0300
Message-ID: <20260704080925.75113-4-amit.barzilai22@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260704080925.75113-1-amit.barzilai22@gmail.com>
References: <20260704080925.75113-1-amit.barzilai22@gmail.com>
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

The Solomon SSD1351 is a 128x128 RGB color OLED controller. It shares
the SSD133X data path: a column/row addressing window followed by a bulk
RGB565 pixel write. Add it as a new SSD135X_FAMILY rather than a separate
driver, reusing the SSD133X plane, CRTC and blit/clear helpers.

The only data-path difference is that the SSD1351 requires an explicit
Write RAM command (0x5c) after the address window is programmed, before
pixel data is accepted, whereas the SSD133X enters data mode implicitly.
This is emitted from a shared ssd133x_write_pixels() helper so both the
damage-update and clear-screen paths cover it.

The SSD1351 also needs its own init sequence (ssd135x_init), dispatched
via ssd135x_encoder_atomic_enable. The re-map byte is fixed at 0 degrees,
65k color, COM split, BGR sub-pixel order; rotation is not supported.

The SSD1351 doesn't implement the SSD13XX_CONTRAST command (0x81) and
expects different opcodes for contrast and brightness management. The
current ssd130x_update_bl() function wouldn't work and the brightness
byte would be executed as a command opcode if run on the SSD1351 panel.
Until the backlight path is family-aware, skip backlight device
registration for the SSD135X family.

The SSD1351 is SPI-only, so only the SPI transport match tables gain an
entry; no new config symbol is needed.

While adding the SSD135X command path, ssd130x_write_cmds() forwards its
'const u8 *cmd' buffer to ssd130x_write_data(), which previously took a
non-const 'u8 *'. Constify the ssd130x_write_data() 'values' parameter
so the const-qualified buffer passes through without casting away const.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Amit Barzilai <amit.barzilai22@gmail.com>
---
 drivers/gpu/drm/solomon/ssd130x-spi.c |   7 +
 drivers/gpu/drm/solomon/ssd130x.c     | 244 +++++++++++++++++++++-----
 drivers/gpu/drm/solomon/ssd130x.h     |   5 +-
 3 files changed, 208 insertions(+), 48 deletions(-)

diff --git a/drivers/gpu/drm/solomon/ssd130x-spi.c b/drivers/gpu/drm/solomon/ssd130x-spi.c
index b52f5fd592a1..6e0dd6e5a88d 100644
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
 	{ "ssd1327", SSD1327_ID },
 	/* ssd133x family */
 	{ "ssd1331", SSD1331_ID },
+	/* ssd135x family */
+	{ "ssd1351", SSD1351_ID },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(spi, ssd130x_spi_id);
diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd130x.c
index 3f09977d227b..f7f0a74a297e 100644
--- a/drivers/gpu/drm/solomon/ssd130x.c
+++ b/drivers/gpu/drm/solomon/ssd130x.c
@@ -145,6 +145,33 @@
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
+#define SSD135X_SET_PRECHARGE			0xbb
+#define SSD135X_SET_VCOMH_VOLTAGE		0xbe
+#define SSD135X_SET_CONTRAST			0xc1
+#define SSD135X_SET_CONTRAST_MASTER		0xc7
+#define SSD135X_SET_MUX_RATIO			0xca
+#define SSD135X_SET_COMMAND_LOCK		0xfd
+
+/* ssd135x remap byte (data of SSD13XX_SET_SEG_REMAP) */
+#define SSD135X_SET_REMAP_COLUMN		BIT(1)
+#define SSD135X_SET_REMAP_COLOR_BGR		BIT(2)
+#define SSD135X_SET_REMAP_COM_SCAN		BIT(4)
+#define SSD135X_SET_REMAP_COM_SPLIT		BIT(5)
+#define SSD135X_SET_REMAP_65K			BIT(6)
+
 #define MAX_CONTRAST 255
 
 const struct ssd130x_deviceinfo ssd130x_variants[] = {
@@ -212,7 +239,13 @@ const struct ssd130x_deviceinfo ssd130x_variants[] = {
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
+	},
 };
 EXPORT_SYMBOL_NS_GPL(ssd130x_variants, "DRM_SSD130X");
 
@@ -246,47 +279,16 @@ static inline struct ssd130x_device *drm_to_ssd130x(struct drm_device *drm)
 /*
  * Helper to write data (SSD13XX_DATA) to the device.
  */
-static int ssd130x_write_data(struct ssd130x_device *ssd130x, u8 *values, int count)
+static int ssd130x_write_data(struct ssd130x_device *ssd130x, const u8 *values, int count)
 {
 	return regmap_bulk_write(ssd130x->regmap, SSD13XX_DATA, values, count);
 }
 
-/*
- * Helper to write command (SSD13XX_COMMAND). The fist variadic argument
- * is the command to write and the following are the command options.
- *
- * Note that the ssd13xx protocol requires each command and option to be
- * written as a SSD13XX_COMMAND device register value. That is why a call
- * to regmap_write(..., SSD13XX_COMMAND, ...) is done for each argument.
- */
-static int ssd130x_write_cmd(struct ssd130x_device *ssd130x, int count,
-			     /* u8 cmd, u8 option, ... */...)
-{
-	va_list ap;
-	u8 value;
-	int ret;
-
-	va_start(ap, count);
-
-	do {
-		value = va_arg(ap, int);
-		ret = regmap_write(ssd130x->regmap, SSD13XX_COMMAND, value);
-		if (ret)
-			goto out_end;
-	} while (--count);
-
-out_end:
-	va_end(ap);
-
-	return ret;
-}
-
 /*
  * Write a command byte sequence from a buffer.
  *
- * Like ssd130x_write_cmd() but takes a pre-built byte array instead of
- * variadic arguments, handy when the command is already in an array or
- * when the caller wants to use sizeof() for the length.
+ * The first byte is the command opcode and the following bytes are its
+ * options/parameters.
  */
 static int ssd130x_write_cmds(struct ssd130x_device *ssd130x, const u8 *cmd,
 			      size_t len)
@@ -294,6 +296,22 @@ static int ssd130x_write_cmds(struct ssd130x_device *ssd130x, const u8 *cmd,
 	unsigned int i;
 	int ret;
 
+	/*
+	 * The SSD135X family latches command parameters with D/C# HIGH (i.e.
+	 * clocked in as data), unlike the other families where the opcode and
+	 * all of its parameters are sent as commands (D/C# LOW). Send the
+	 * opcode as a command and any following parameter bytes as data.
+	 */
+	if (ssd130x->device_info->family_id == SSD135X_FAMILY) {
+		if (len == 0)
+			return 0;
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
@@ -303,6 +321,27 @@ static int ssd130x_write_cmds(struct ssd130x_device *ssd130x, const u8 *cmd,
 	return 0;
 }
 
+/*
+ * Variadic wrapper around ssd130x_write_cmds(). The first variadic argument is
+ * the command opcode and the following ones are its options/parameters.
+ */
+static int ssd130x_write_cmd(struct ssd130x_device *ssd130x, int count,
+			     /* u8 cmd, u8 option, ... */...)
+{
+	u8 buf[8];
+	va_list ap;
+
+	if (count > ARRAY_SIZE(buf))
+		return -EINVAL;
+
+	va_start(ap, count);
+	for (int i = 0; i < count; i++)
+		buf[i] = va_arg(ap, int);
+	va_end(ap);
+
+	return ssd130x_write_cmds(ssd130x, buf, count);
+}
+
 /*
  * Run a packed command sequence.  The format is a flat byte array where each
  * entry starts with a length byte followed by that many command bytes.  A
@@ -415,6 +454,12 @@ static void ssd130x_reset(struct ssd130x_device *ssd130x)
 	udelay(4);
 	gpiod_set_value_cansleep(ssd130x->reset, 0);
 	udelay(4);
+	/*
+	 * No long post-reset delay: the controller datasheets only specify
+	 * microsecond-scale reset timing. The lengthy delay seen in some other
+	 * drivers comes from fbtft's generic reset helper and targets slow
+	 * parallel-bus GPIOs, which do not apply here.
+	 */
 }
 
 static int ssd130x_power_on(struct ssd130x_device *ssd130x)
@@ -622,6 +667,42 @@ static int ssd133x_init(struct ssd130x_device *ssd130x)
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
+	const u8 cmds[] = {
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
+		2, SSD135X_SET_PRECHARGE, 0x17,
+		2, SSD135X_SET_VCOMH_VOLTAGE, 0x05,
+		4, SSD135X_SET_CONTRAST, 0xc8, 0x80, 0xc8,
+		2, SSD135X_SET_CONTRAST_MASTER, 0x0f,
+		2, SSD135X_SET_PRECHARGE2, 0x01,
+		1, SSD135X_SET_DISPLAY_NORMAL,
+		2, SSD13XX_SET_SEG_REMAP, remap,
+		0
+	};
+
+	return ssd130x_run_cmd_seq(ssd130x, cmds);
+}
+
 static int ssd130x_update_rect(struct ssd130x_device *ssd130x,
 			       struct drm_rect *rect, u8 *buf,
 			       u8 *data_array)
@@ -784,6 +865,26 @@ static int ssd132x_update_rect(struct ssd130x_device *ssd130x,
 	return ret;
 }
 
+/*
+ * Write a run of pixel data to the controller's display RAM. The SSD135X
+ * family requires an explicit Write RAM command once the address window has
+ * been set, before any pixel data is accepted; the SSD133X family enters data
+ * mode implicitly after the column/row range is programmed.
+ */
+static int ssd133x_write_pixels(struct ssd130x_device *ssd130x,
+				u8 *data_array, unsigned int count)
+{
+	if (ssd130x->device_info->family_id == SSD135X_FAMILY) {
+		int ret;
+
+		ret = ssd130x_write_cmd(ssd130x, 1, SSD135X_WRITE_RAM);
+		if (ret < 0)
+			return ret;
+	}
+
+	return ssd130x_write_data(ssd130x, data_array, count);
+}
+
 static int ssd133x_update_rect(struct ssd130x_device *ssd130x,
 			       struct drm_rect *rect, u8 *data_array,
 			       unsigned int pitch)
@@ -826,7 +927,7 @@ static int ssd133x_update_rect(struct ssd130x_device *ssd130x,
 		return ret;
 
 	/* Write out update in one go since horizontal addressing mode is used */
-	ret = ssd130x_write_data(ssd130x, data_array, pitch * rows);
+	ret = ssd133x_write_pixels(ssd130x, data_array, pitch * rows);
 
 	return ret;
 }
@@ -896,7 +997,7 @@ static void ssd133x_clear_screen(struct ssd130x_device *ssd130x, u8 *data_array)
 	memset(data_array, 0, pitch * ssd130x->height);
 
 	/* Write out update in one go since horizontal addressing mode is used */
-	ssd130x_write_data(ssd130x, data_array, pitch * ssd130x->height);
+	ssd133x_write_pixels(ssd130x, data_array, pitch * ssd130x->height);
 }
 
 static int ssd130x_fb_blit_rect(struct drm_framebuffer *fb,
@@ -1356,7 +1457,13 @@ static const struct drm_plane_helper_funcs ssd130x_primary_plane_helper_funcs[]
 		.atomic_check = ssd133x_primary_plane_atomic_check,
 		.atomic_update = ssd133x_primary_plane_atomic_update,
 		.atomic_disable = ssd133x_primary_plane_atomic_disable,
-	}
+	},
+	[SSD135X_FAMILY] = {
+		DRM_GEM_SHADOW_PLANE_HELPER_FUNCS,
+		.atomic_check = ssd133x_primary_plane_atomic_check,
+		.atomic_update = ssd133x_primary_plane_atomic_update,
+		.atomic_disable = ssd133x_primary_plane_atomic_disable,
+	},
 };
 
 static const struct drm_plane_funcs ssd130x_primary_plane_funcs = {
@@ -1510,6 +1617,10 @@ static const struct drm_crtc_helper_funcs ssd130x_crtc_helper_funcs[] = {
 		.mode_valid = ssd130x_crtc_mode_valid,
 		.atomic_check = ssd133x_crtc_atomic_check,
 	},
+	[SSD135X_FAMILY] = {
+		.mode_valid = ssd130x_crtc_mode_valid,
+		.atomic_check = ssd133x_crtc_atomic_check,
+	},
 };
 
 static const struct drm_crtc_funcs ssd130x_crtc_funcs = {
@@ -1597,6 +1708,31 @@ static void ssd133x_encoder_atomic_enable(struct drm_encoder *encoder,
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
@@ -1622,7 +1758,11 @@ static const struct drm_encoder_helper_funcs ssd130x_encoder_helper_funcs[] = {
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
@@ -1897,15 +2037,25 @@ struct ssd130x_device *ssd130x_probe(struct device *dev, struct regmap *regmap)
 	if (ret)
 		return ERR_PTR(ret);
 
-	bl = devm_backlight_device_register(dev, dev_name(dev), dev, ssd130x,
-					    &ssd130xfb_bl_ops, NULL);
-	if (IS_ERR(bl))
-		return ERR_PTR(dev_err_probe(dev, PTR_ERR(bl),
-					     "Unable to register backlight device\n"));
+	/*
+	 * The backlight update path drives contrast through the
+	 * SSD13XX_CONTRAST command (0x81), which the SSD135X family does not
+	 * implement; the brightness byte would be interpreted as a command
+	 * opcode instead. Do not register a backlight device for this family
+	 * until the backlight path is family-aware.
+	 */
+	if (ssd130x->device_info->family_id != SSD135X_FAMILY) {
+		bl = devm_backlight_device_register(dev, dev_name(dev), dev,
+						    ssd130x, &ssd130xfb_bl_ops,
+						    NULL);
+		if (IS_ERR(bl))
+			return ERR_PTR(dev_err_probe(dev, PTR_ERR(bl),
+						     "Unable to register backlight device\n"));
 
-	bl->props.brightness = ssd130x->contrast;
-	bl->props.max_brightness = MAX_CONTRAST;
-	ssd130x->bl_dev = bl;
+		bl->props.brightness = ssd130x->contrast;
+		bl->props.max_brightness = MAX_CONTRAST;
+		ssd130x->bl_dev = bl;
+	}
 
 	ret = ssd130x_init_modeset(ssd130x);
 	if (ret)
diff --git a/drivers/gpu/drm/solomon/ssd130x.h b/drivers/gpu/drm/solomon/ssd130x.h
index a4554018bb2a..350472cc5a12 100644
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
 
-- 
2.54.0

