Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8ED5C4452D
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 22:11:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C19A910E3E5;
	Tue, 21 Jul 2026 22:11:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="isrp4HCu";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6AEF10E391
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 17:27:25 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-49546c690ffso34900955e9.2
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 10:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784654844; x=1785259644; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IyowS+ZQ7dCHkaNuov8fuCaiCLBVCHZQSxPaLCWmj9E=;
 b=isrp4HCuulqAGBi7fVHF1Zm+BaINjbIPh9zBtd8lDdAIpKJXV/ifm6OujmbgtnAd80
 FRBOjwRSI0Bpq6KEDtmC5+3A1jYKQaH3Yav3CvCLDf0Kp2TxmIALbVQwR9slTsdXoYCh
 sQz6zYPWScRr9NEIVvept+CTEScfR9zmxWnwO6lPw6zQYNqHs6QphchgV+xBAQO5U7Xi
 YzQVAYbmKPYi6LIKXP9dvvk+g6bwsvUQhOYDNyYmdgZUZLjU+e/+4wcFLYVkcL3A7JSw
 TOo5DzkuJhqbY6QMjfCb2fOzCsLTkgUUeGKA7CzcPkuXM9kFKhi1CHs7zxvLHHJMMex3
 Nj+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784654844; x=1785259644;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=IyowS+ZQ7dCHkaNuov8fuCaiCLBVCHZQSxPaLCWmj9E=;
 b=KhrB2u0QlsYsA2oAj4VemGBApsuIioj/OYR57I/HnLEpMgGXLW/nRFT3BbpVY9OsSR
 bOUHBE6oHld/ZHx6R30D0/tr5i3AvAQxR503ML6XuJE7G7HpMQyEXslgzF/2K6R3c8tI
 eClzGtXAMzwS9YBF+NkBaTZwQoLXsqtIdYW73e2HdFtAWgYZN/J1lPSrvZtuF84up+Q3
 jq2bTI5KxWw7ROeLbjDtm77LFOgMWVvwcbxzTWmWo0Nb+YBhb30fcSchA3Z9wY06nBSo
 CbSemlsZqda9eg09yFQr/nyFikU8V+NIT0jW/S9oLxbA8R7rnRyrkSpCY8UswlxBcK1V
 P4+w==
X-Gm-Message-State: AOJu0YxBcAnSgIRMqes4XU28lENgQceaZTbvyL+0vZpIMY5z4SUeL7mz
 3I8zCZuqDVionKNCt6Ocltl5sCrGl6FzZzt6NX1iJtpqQjViN93uC+8b
X-Gm-Gg: AfdE7clSR0hOomcXx9Hq9soaIE+cCr/G5LXsNfj6OASKDwabkly9RwPiAuCGzjk5KNF
 W+ue6NndSKdm/qUaUuSOcPkBMnp+dgzWJUjLUB3a9BTIBsw2foAcxmJZPrc6lSEFWGnxW7HqnzZ
 UCGkPlcYAejkDwQmfQT3JAk0oCo8G5TR29l5TBuu8xeytlXSGI/TjK4AJNchW61Un6A+EHWigtV
 0jGX93TGmcrstjXoq6+Cawp1FoHA3VxDqy3JhOaRYc6W6w7ITtGr9UmQeKZKB0Fqgtx2G/KMrd/
 /JbhzihjjX3HjStLhGnAL2LsCpQjU5H0PPucrFUdgKVV8uWtTPVN5uUOOcqRMoq+HeYXRINvAS9
 PbznKxMVtPM09GZ4o29tcKQxIhC0beXax44wj5Bz/TWx01W9I7ijdG4BRuGgR5tJ6IOb3D5yysu
 a8rmrHdF9GkEORZIagd3EjMnpoxKVX5mHod6/Vx1vnVWCtuSoM
X-Received: by 2002:a05:600c:4445:b0:493:f262:b8 with SMTP id
 5b1f17b1804b1-4954a3e374cmr209286655e9.1.1784654843942; 
 Tue, 21 Jul 2026 10:27:23 -0700 (PDT)
Received: from michalis-linux (adsl-75.176.58.251.tellas.gr. [176.58.251.75])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956a4f24bcsm12215465e9.1.2026.07.21.10.27.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 10:27:23 -0700 (PDT)
From: Michail Tatas <michail.tatas@gmail.com>
To: michael@amarulasolutions.com, neil.armstrong@linaro.org,
 jesszhan0024@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, dianders@chromium.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Michail Tatas <michail.tatas@gmail.com>
Subject: [PATCH v3 2/3] drm/panel: ilitek-ili9805: Use dsi_multi in init
Date: Tue, 21 Jul 2026 20:27:14 +0300
Message-ID: <20260721172715.602196-3-michail.tatas@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260721172715.602196-1-michail.tatas@gmail.com>
References: <20260721172715.602196-1-michail.tatas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 21 Jul 2026 22:11:24 +0000
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
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
 drivers/gpu/drm/panel/panel-ilitek-ili9805.c | 160 +++++++++----------
 1 file changed, 76 insertions(+), 84 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9805.c b/drivers/gpu/drm/panel/panel-ilitek-ili9805.c
index 7e9587afebbe..909661f67d26 100644
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
@@ -56,65 +43,80 @@ struct ili9805 {
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
+	mipi_dsi_dcs_write_seq_multi(ctx, ILI9805_EXTCMD_CMD_SET_ENABLE_REG,
+				     ILI9805_SETEXTC_PARAMETER1, ILI9805_SETEXTC_PARAMETER2,
+				     ILI9805_SETEXTC_PARAMETER3);
+	mipi_dsi_msleep(ctx, 100);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xfd, 0x0f, 0x10, 0x44, 0x00);
+	mipi_dsi_msleep(ctx, 100);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xf8, 0x18, 0x02, 0x02, 0x18, 0x02, 0x02, 0x30, 0x00,
+				     0x00, 0x30, 0x00, 0x00, 0x30, 0x00, 0x00);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xb8, 0x62);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xf1, 0x00);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xf2, 0x00, 0x58, 0x40);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xf3, 0x60, 0x83, 0x04);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xfc, 0x04, 0x0f, 0x01);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xeb, 0x08, 0x0f);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xe0, 0x00, 0x08, 0x0d, 0x0e, 0x0e, 0x0d, 0x0a, 0x08,
+				     0x04, 0x08, 0x0d, 0x0f, 0x0b, 0x1c, 0x14, 0x0a);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xe1, 0x00, 0x08, 0x0d, 0x0e, 0x0e, 0x0d, 0x0a, 0x08,
+				     0x04, 0x08, 0x0d, 0x0f, 0x0b, 0x1c, 0x14, 0x0a);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xc1, 0x13, 0x39, 0x19, 0x06);
+	mipi_dsi_msleep(ctx, 10);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xc7, 0xe5);
+	mipi_dsi_msleep(ctx, 10);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xb1, 0x00, 0x12, 0x14);
+	mipi_dsi_msleep(ctx, 10);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xb4, 0x02);
+	mipi_dsi_msleep(ctx, 10);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xbb, 0x14, 0x55);
+	mipi_dsi_dcs_write_seq_multi(ctx, MIPI_DCS_SET_ADDRESS_MODE, 0x08);
+	mipi_dsi_dcs_write_seq_multi(ctx, MIPI_DCS_SET_PIXEL_FORMAT, 0x77);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x20);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xb0, 0x01);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xb6, 0x31, 0x00, 0xef);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xdf, 0x23);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xb9, 0x02, 0x00);
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
+	mipi_dsi_dcs_write_seq_multi(ctx, ILI9805_EXTCMD_CMD_SET_ENABLE_REG,
+				     ILI9805_SETEXTC_PARAMETER1, ILI9805_SETEXTC_PARAMETER2,
+				     ILI9805_SETEXTC_PARAMETER3);
+	mipi_dsi_msleep(ctx, 100);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xfd, 0x0f, 0x13, 0x44, 0x00);
+	mipi_dsi_msleep(ctx, 100);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xf8, 0x18, 0x02, 0x02, 0x18, 0x02, 0x02, 0x30, 0x01,
+				     0x01, 0x30, 0x01, 0x01, 0x30, 0x01, 0x01);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xb8, 0x74);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xf1, 0x00);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xf2, 0x00, 0x58, 0x40);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xfc, 0x04, 0x0f, 0x01);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xeb, 0x08, 0x0f);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xe0, 0x01, 0x0d, 0x15, 0x0e, 0x0f, 0x0f, 0x0b, 0x08,
+				     0x04, 0x07, 0x0a, 0x0d, 0x0c, 0x15, 0x0f, 0x08);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xe1, 0x01, 0x0d, 0x15, 0x0e, 0x0f, 0x0f, 0x0b, 0x08,
+				     0x04, 0x07, 0x0a, 0x0d, 0x0c, 0x15, 0x0f, 0x08);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xc1, 0x15, 0x03, 0x03, 0x31);
+	mipi_dsi_msleep(ctx, 10);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xb1, 0x00, 0x12, 0x14);
+	mipi_dsi_msleep(ctx, 10);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xb4, 0x02);
+	mipi_dsi_msleep(ctx, 10);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xbb, 0x14, 0x55);
+	mipi_dsi_dcs_write_seq_multi(ctx, MIPI_DCS_SET_ADDRESS_MODE, 0x0a);
+	mipi_dsi_dcs_write_seq_multi(ctx, MIPI_DCS_SET_PIXEL_FORMAT, 0x77);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x20);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xb0, 0x00);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xb6, 0x01);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xc2, 0x11);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x51, 0xff);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x53, 0x24);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x55, 0x00);
+}
 
 static inline struct ili9805 *panel_to_ili9805(struct drm_panel *panel)
 {
@@ -160,16 +162,8 @@ static int ili9805_power_off(struct ili9805 *ctx)
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
@@ -246,7 +240,7 @@ static const struct drm_display_mode tm041xdhg01_timing = {
 };
 
 static int ili9805_get_modes(struct drm_panel *panel,
-			      struct drm_connector *connector)
+			     struct drm_connector *connector)
 {
 	struct ili9805 *ctx = panel_to_ili9805(panel);
 	struct drm_display_mode *mode;
@@ -343,7 +337,6 @@ static void ili9805_dsi_remove(struct mipi_dsi_device *dsi)
 
 static const struct ili9805_desc gpm1780a0_desc = {
 	.init = gpm1780a0_init,
-	.init_length = ARRAY_SIZE(gpm1780a0_init),
 	.mode = &gpm1780a0_timing,
 	.width_mm = 65,
 	.height_mm = 65,
@@ -351,7 +344,6 @@ static const struct ili9805_desc gpm1780a0_desc = {
 
 static const struct ili9805_desc tm041xdhg01_desc = {
 	.init = tm041xdhg01_init,
-	.init_length = ARRAY_SIZE(tm041xdhg01_init),
 	.mode = &tm041xdhg01_timing,
 	.width_mm = 42,
 	.height_mm = 96,
-- 
2.43.0

