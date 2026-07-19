Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 745F5C4452A
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 07:16:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 173CD10E7A3;
	Mon, 20 Jul 2026 07:15:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ad4se4sk";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 698CC10E0A1
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Jul 2026 19:04:09 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-49557167508so8689415e9.1
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Jul 2026 12:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784487848; x=1785092648; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9WaGTj0odz/Z3DfCnGwj2JafcVngJK7ESYUU6M/9CpI=;
 b=Ad4se4skTl0BDtLTpHhceBnR+kAxbxJtdeKk5cqrz4jO1uLfxGl9bKQPAzcO07mXLT
 BTknMhlGFaF92tuhv01vl2U3AFX+CPzmFpdAImF8cQCJulYnA2/vRLaVbgwa+/wHXhxs
 5s+fPkZE/HIA5kkQZdfentNDTkZdmTWh4qyptRGMWWfKHeZ3s1izzsdVKuJTLD5tHCV8
 Uv8Um+FGQf3tuzXKrcZ1rg/m/oZrCtgmzvUsEJoWwvO9T8QqRfsnw6/X8id/XIDPUKkp
 eNNNkxZp/IMblT0GcL6sfsDs15XyD5TzfD+PvsxoGqguqZrCVsoCZtcujQx+k9G227rE
 /Cmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784487848; x=1785092648;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=9WaGTj0odz/Z3DfCnGwj2JafcVngJK7ESYUU6M/9CpI=;
 b=E/lfBW1lmNc9Y0Kt8lXIB9HVdC+oM1UzeV933zSZlzRdPBc6qTAM6xZIMFVg1a50MO
 p3AHV4heeaMIQa+LqllWVmLYw5BkL5Rdtgq9C+F7cEgqyfOJFgQpYsfjsKcmBNE3zTPi
 OtM+j8vft/GyeLZYNDx/EzLGMk7AbiC9QN5nqN1W3QOpAhvqx+pJnUfdPOnS2uzcyA86
 LUKZwLKeGCmntuv7fQ0BCxYETUdmkx/AsU40FmQv9EoYR4h64sCITmLefCXujl5U7RTB
 SmHv8MWRMkub1B7EN/WsoWCkaGBqI530l37mDbfpRw8KELzqWeYyJQ4sBbQMN0GX9fv0
 +tjA==
X-Gm-Message-State: AOJu0YyN4P5QdQwMhg1BltZA/4eSPfWT5p8k57l1NQGHNYuBFqt19jo1
 3S2b7yIdq20Z4aU4/FyibKmQdHRStZK9+AdMzmMjNz4vpfIFh+3RmNVg
X-Gm-Gg: AfdE7cmdExUf1luJlWRR59e1mBoQaI+1C1gAN9GIzxNT4GEvXez+cZPgKxAtEZuBlaY
 8PHI7lj2kO6EFnKnCgFPQ8nYUgkDgjSXFrvZx9RcUMIwSLs5JEczTeTBA6nUUUGmGDgimiRex4R
 WUAO47fC0sd/3lwQEJomAanmfmg63XnLsSJzi1KqDqbnKRnj02WduHLVmDpXrvPzJnYCTVReKPo
 TGxNPu/Zmryb/IXnoojgQXyg/I4asqtywo/GjH5M/Oy363GU6TRUaO6PNMmbBN1IkSoB4zfvumK
 1/omGICyBVhOAi9rZYNX29vma4hoeJEh98GKVVsI3NG18RdBt7KOfRtIOIdniKrbT1HYwluDG4H
 vxin3KI4sXjNLFt7r4Z7Oe4FbtiUI2d3fjuGneK49DTYx4Cs1ASwz5+Tt2mpS/8tUQXW4/q52UL
 opf+aYpaO+aUpFG7aFanYAlDgsUi3L3Nxx0Okw1w==
X-Received: by 2002:a05:600c:b85:b0:495:5365:c0d1 with SMTP id
 5b1f17b1804b1-49553d85ea0mr68678755e9.14.1784487847665; 
 Sun, 19 Jul 2026 12:04:07 -0700 (PDT)
Received: from michalis-linux (adsl-75.176.58.251.tellas.gr. [176.58.251.75])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63e499c2sm21523046f8f.4.2026.07.19.12.04.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Jul 2026 12:04:07 -0700 (PDT)
From: Michail Tatas <michail.tatas@gmail.com>
To: michael@amarulasolutions.com, neil.armstrong@linaro.org,
 jesszhan0024@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, dianders@chromium.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Michail Tatas <michail.tatas@gmail.com>
Subject: [PATCH v2 2/3] drm/panel: ilitek-ili9805: Use dsi_multi in init
Date: Sun, 19 Jul 2026 22:03:56 +0300
Message-ID: <20260719190358.438699-3-michail.tatas@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260719190358.438699-1-michail.tatas@gmail.com>
References: <20260719190358.438699-1-michail.tatas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 20 Jul 2026 07:15:03 +0000
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

Drop the struct ili9805_instr and the init table
and use init functions.

Signed-off-by: Michail Tatas <michail.tatas@gmail.com>
---
 drivers/gpu/drm/panel/panel-ilitek-ili9805.c | 156 +++++++++----------
 1 file changed, 73 insertions(+), 83 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9805.c b/drivers/gpu/drm/panel/panel-ilitek-ili9805.c
index 7e9587afebbe..a70b9512746a 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili9805.c
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9805.c
@@ -25,22 +25,9 @@
 #define ILI9805_SETEXTC_PARAMETER2		(0x98)
 #define ILI9805_SETEXTC_PARAMETER3		(0x05)
 
-#define ILI9805_INSTR(_delay, ...) { \
-		.delay = (_delay), \
-		.len = sizeof((u8[]) {__VA_ARGS__}), \
-		.data = (u8[]){__VA_ARGS__} \
-	}
-
-struct ili9805_instr {
-	size_t len;
-	const u8 *data;
-	u32 delay;
-};
-
 struct ili9805_desc {
 	const char *name;
-	const struct ili9805_instr *init;
-	const size_t init_length;
+	void (*init)(struct mipi_dsi_multi_context *ctx);
 	const struct drm_display_mode *mode;
 	u32 width_mm;
 	u32 height_mm;
@@ -56,65 +43,78 @@ struct ili9805 {
 	struct gpio_desc	*reset_gpio;
 };
 
-static const struct ili9805_instr gpm1780a0_init[] = {
-	ILI9805_INSTR(100, ILI9805_EXTCMD_CMD_SET_ENABLE_REG, ILI9805_SETEXTC_PARAMETER1,
-		      ILI9805_SETEXTC_PARAMETER2, ILI9805_SETEXTC_PARAMETER3),
-	ILI9805_INSTR(100, 0xFD, 0x0F, 0x10, 0x44, 0x00),
-	ILI9805_INSTR(0, 0xf8, 0x18, 0x02, 0x02, 0x18, 0x02, 0x02, 0x30, 0x00,
-		      0x00, 0x30, 0x00, 0x00, 0x30, 0x00, 0x00),
-	ILI9805_INSTR(0, 0xB8, 0x62),
-	ILI9805_INSTR(0, 0xF1, 0x00),
-	ILI9805_INSTR(0, 0xF2, 0x00, 0x58, 0x40),
-	ILI9805_INSTR(0, 0xF3, 0x60, 0x83, 0x04),
-	ILI9805_INSTR(0, 0xFC, 0x04, 0x0F, 0x01),
-	ILI9805_INSTR(0, 0xEB, 0x08, 0x0F),
-	ILI9805_INSTR(0, 0xe0, 0x00, 0x08, 0x0d, 0x0e, 0x0e, 0x0d, 0x0a, 0x08, 0x04,
-		      0x08, 0x0d, 0x0f, 0x0b, 0x1c, 0x14, 0x0a),
-	ILI9805_INSTR(0, 0xe1, 0x00, 0x08, 0x0d, 0x0e, 0x0e, 0x0d, 0x0a, 0x08, 0x04,
-		      0x08, 0x0d, 0x0f, 0x0b, 0x1c, 0x14, 0x0a),
-	ILI9805_INSTR(10, 0xc1, 0x13, 0x39, 0x19, 0x06),
-	ILI9805_INSTR(10, 0xc7, 0xe5),
-	ILI9805_INSTR(10, 0xB1, 0x00, 0x12, 0x14),
-	ILI9805_INSTR(10, 0xB4, 0x02),
-	ILI9805_INSTR(0, 0xBB, 0x14, 0x55),
-	ILI9805_INSTR(0, MIPI_DCS_SET_ADDRESS_MODE, 0x08),
-	ILI9805_INSTR(0, MIPI_DCS_SET_PIXEL_FORMAT, 0x77),
-	ILI9805_INSTR(0, 0x20),
-	ILI9805_INSTR(0, 0xB0, 0x01),
-	ILI9805_INSTR(0, 0xB6, 0x31, 0x00, 0xef),
-	ILI9805_INSTR(0, 0xDF, 0x23),
-	ILI9805_INSTR(0, 0xB9, 0x02, 0x00),
-};
+static void gpm1780a0_init(struct mipi_dsi_multi_context *ctx)
+{
+	mipi_dsi_dcs_write_seq_multi(ctx, ILI9805_EXTCMD_CMD_SET_ENABLE_REG, ILI9805_SETEXTC_PARAMETER1,
+							ILI9805_SETEXTC_PARAMETER2, ILI9805_SETEXTC_PARAMETER3);
+	mipi_dsi_msleep(ctx, 100);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xFD, 0x0F, 0x10, 0x44, 0x00);
+	mipi_dsi_msleep(ctx, 100);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xf8, 0x18, 0x02, 0x02, 0x18, 0x02, 0x02, 0x30, 0x00,
+							0x00, 0x30, 0x00, 0x00, 0x30, 0x00, 0x00);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xB8, 0x62);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xF1, 0x00);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xF2, 0x00, 0x58, 0x40);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xF3, 0x60, 0x83, 0x04);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xFC, 0x04, 0x0F, 0x01);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xEB, 0x08, 0x0F);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xe0, 0x00, 0x08, 0x0d, 0x0e, 0x0e, 0x0d, 0x0a, 0x08, 0x04,
+							0x08, 0x0d, 0x0f, 0x0b, 0x1c, 0x14, 0x0a);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xe1, 0x00, 0x08, 0x0d, 0x0e, 0x0e, 0x0d, 0x0a, 0x08, 0x04,
+							0x08, 0x0d, 0x0f, 0x0b, 0x1c, 0x14, 0x0a);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xc1, 0x13, 0x39, 0x19, 0x06);
+	mipi_dsi_msleep(ctx, 10);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xc7, 0xe5);
+	mipi_dsi_msleep(ctx, 10);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xB1, 0x00, 0x12, 0x14);
+	mipi_dsi_msleep(ctx, 10);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xB4, 0x02);
+	mipi_dsi_msleep(ctx, 10);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xBB, 0x14, 0x55);
+	mipi_dsi_dcs_write_seq_multi(ctx, MIPI_DCS_SET_ADDRESS_MODE, 0x08);
+	mipi_dsi_dcs_write_seq_multi(ctx, MIPI_DCS_SET_PIXEL_FORMAT, 0x77);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x20);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xB0, 0x01);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xB6, 0x31, 0x00, 0xef);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xDF, 0x23);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xB9, 0x02, 0x00);
+}
 
-static const struct ili9805_instr tm041xdhg01_init[] = {
-	ILI9805_INSTR(100, ILI9805_EXTCMD_CMD_SET_ENABLE_REG, ILI9805_SETEXTC_PARAMETER1,
-		      ILI9805_SETEXTC_PARAMETER2, ILI9805_SETEXTC_PARAMETER3),
-	ILI9805_INSTR(100, 0xFD, 0x0F, 0x13, 0x44, 0x00),
-	ILI9805_INSTR(0, 0xf8, 0x18, 0x02, 0x02, 0x18, 0x02, 0x02, 0x30, 0x01,
-		      0x01, 0x30, 0x01, 0x01, 0x30, 0x01, 0x01),
-	ILI9805_INSTR(0, 0xB8, 0x74),
-	ILI9805_INSTR(0, 0xF1, 0x00),
-	ILI9805_INSTR(0, 0xF2, 0x00, 0x58, 0x40),
-	ILI9805_INSTR(0, 0xFC, 0x04, 0x0F, 0x01),
-	ILI9805_INSTR(0, 0xEB, 0x08, 0x0F),
-	ILI9805_INSTR(0, 0xe0, 0x01, 0x0d, 0x15, 0x0e, 0x0f, 0x0f, 0x0b, 0x08, 0x04,
-		      0x07, 0x0a, 0x0d, 0x0c, 0x15, 0x0f, 0x08),
-	ILI9805_INSTR(0, 0xe1, 0x01, 0x0d, 0x15, 0x0e, 0x0f, 0x0f, 0x0b, 0x08, 0x04,
-		      0x07, 0x0a, 0x0d, 0x0c, 0x15, 0x0f, 0x08),
-	ILI9805_INSTR(10, 0xc1, 0x15, 0x03, 0x03, 0x31),
-	ILI9805_INSTR(10, 0xB1, 0x00, 0x12, 0x14),
-	ILI9805_INSTR(10, 0xB4, 0x02),
-	ILI9805_INSTR(0, 0xBB, 0x14, 0x55),
-	ILI9805_INSTR(0, MIPI_DCS_SET_ADDRESS_MODE, 0x0a),
-	ILI9805_INSTR(0, MIPI_DCS_SET_PIXEL_FORMAT, 0x77),
-	ILI9805_INSTR(0, 0x20),
-	ILI9805_INSTR(0, 0xB0, 0x00),
-	ILI9805_INSTR(0, 0xB6, 0x01),
-	ILI9805_INSTR(0, 0xc2, 0x11),
-	ILI9805_INSTR(0, 0x51, 0xFF),
-	ILI9805_INSTR(0, 0x53, 0x24),
-	ILI9805_INSTR(0, 0x55, 0x00),
-};
+static void tm041xdhg01_init(struct mipi_dsi_multi_context *ctx)
+{
+	mipi_dsi_dcs_write_seq_multi(ctx, ILI9805_EXTCMD_CMD_SET_ENABLE_REG, ILI9805_SETEXTC_PARAMETER1,
+							ILI9805_SETEXTC_PARAMETER2, ILI9805_SETEXTC_PARAMETER3);
+	mipi_dsi_msleep(ctx, 100);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xFD, 0x0F, 0x13, 0x44, 0x00);
+	mipi_dsi_msleep(ctx, 100);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xf8, 0x18, 0x02, 0x02, 0x18, 0x02, 0x02, 0x30, 0x01,
+							0x01, 0x30, 0x01, 0x01, 0x30, 0x01, 0x01);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xB8, 0x74);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xF1, 0x00);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xF2, 0x00, 0x58, 0x40);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xFC, 0x04, 0x0F, 0x01);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xEB, 0x08, 0x0F);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xe0, 0x01, 0x0d, 0x15, 0x0e, 0x0f, 0x0f, 0x0b, 0x08, 0x04,
+							0x07, 0x0a, 0x0d, 0x0c, 0x15, 0x0f, 0x08);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xe1, 0x01, 0x0d, 0x15, 0x0e, 0x0f, 0x0f, 0x0b, 0x08, 0x04,
+							0x07, 0x0a, 0x0d, 0x0c, 0x15, 0x0f, 0x08);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xc1, 0x15, 0x03, 0x03, 0x31);
+	mipi_dsi_msleep(ctx, 10);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xB1, 0x00, 0x12, 0x14);
+	mipi_dsi_msleep(ctx, 10);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xB4, 0x02);
+	mipi_dsi_msleep(ctx, 10);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xBB, 0x14, 0x55);
+	mipi_dsi_dcs_write_seq_multi(ctx, MIPI_DCS_SET_ADDRESS_MODE, 0x0a);
+	mipi_dsi_dcs_write_seq_multi(ctx, MIPI_DCS_SET_PIXEL_FORMAT, 0x77);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x20);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xB0, 0x00);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xB6, 0x01);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xc2, 0x11);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x51, 0xFF);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x53, 0x24);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x55, 0x00);
+}
 
 static inline struct ili9805 *panel_to_ili9805(struct drm_panel *panel)
 {
@@ -160,16 +160,8 @@ static int ili9805_power_off(struct ili9805 *ctx)
 static int ili9805_activate(struct ili9805 *ctx)
 {
 	struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
-	int i;
 
-	for (i = 0; i < ctx->desc->init_length; i++) {
-		const struct ili9805_instr *instr = &ctx->desc->init[i];
-
-		mipi_dsi_dcs_write_buffer_multi(&dsi_ctx, instr->data, instr->len);
-
-		if (instr->delay > 0)
-			mipi_dsi_msleep(&dsi_ctx, instr->delay);
-	}
+	ctx->desc->init(&dsi_ctx);
 
 	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
 	mipi_dsi_usleep_range(&dsi_ctx, 5000, 6000);
@@ -343,7 +335,6 @@ static void ili9805_dsi_remove(struct mipi_dsi_device *dsi)
 
 static const struct ili9805_desc gpm1780a0_desc = {
 	.init = gpm1780a0_init,
-	.init_length = ARRAY_SIZE(gpm1780a0_init),
 	.mode = &gpm1780a0_timing,
 	.width_mm = 65,
 	.height_mm = 65,
@@ -351,7 +342,6 @@ static const struct ili9805_desc gpm1780a0_desc = {
 
 static const struct ili9805_desc tm041xdhg01_desc = {
 	.init = tm041xdhg01_init,
-	.init_length = ARRAY_SIZE(tm041xdhg01_init),
 	.mode = &tm041xdhg01_timing,
 	.width_mm = 42,
 	.height_mm = 96,
-- 
2.43.0

