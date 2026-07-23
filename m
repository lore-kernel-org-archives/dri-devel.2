Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4C94C531D0
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 20:36:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3083510F1FA;
	Thu, 23 Jul 2026 20:36:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XkLn7xXM";
	dkim-atps=neutral
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63AA810E0FA
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 20:36:12 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-47f703a9e5dso447962f8f.0
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 13:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784838971; x=1785443771; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4EJj8w2hdYLd80dzrEBi3uGqqkq/lk4wRJGxxReFyHg=;
 b=XkLn7xXMDBR+hm9fPjSI1qJzixGAy3D9tld1PlL81rpIlQBR+8D9Y7Mbo+lPYNRRlu
 qONyYtkER+gUsg3zAfMxfu/5lLr3t51FY6oDxnAp/tUwGZw/hGso8oR+xgHoo0ExSnXp
 cWvS1ZMS9+dJB+QmzEGyI79V6KVLpP51/eFFk/lq26Uq9wwRfmVXEFkDVhCmUo1Qyel+
 XpxyMmXjTWqD1pSw/zJdx5Q26ydQzjZD2Fd1iTONmaohAVOPlkn7Id0GjT9x8bQUjtjJ
 Xmt/OF0qsK0nk4B6hD+f0S8NOBe6jYR4RCURGQ5zh38CliXhNbveqyHU3edbZJGdBwfO
 0PUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784838971; x=1785443771;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4EJj8w2hdYLd80dzrEBi3uGqqkq/lk4wRJGxxReFyHg=;
 b=LJ2AzIjM301pFFS5nwA7KGRVHezbdd9Uh7o8K4hrN15xPMCEbOMHRUG40AEGx82HOA
 vQlSaxdyI/6lHwWrZDcwWE6RM+0CJKaHpK8z7rKQdN98Fql0ahAO0bws97qV3CRAC0n9
 lng92Av/9PddvxQz7jZCQr0Kl5EQ982D23l6b5ZRNIMeVWHvsxmOAjkPmI8SGxVl1sGB
 Gf/TIKgA8pW4+uf6RFYQVhOMaB4sYUa6X/4L8WKhLH0QDjGwMtVL5KL5pwltrt6OhH+G
 ntN6Cb7dMZjL0jJ6IeWD6JrBgwE/1eF1n/B1ZZDrLkMFylY+/BcXI8yc4meLWC1oCBbv
 51FQ==
X-Gm-Message-State: AOJu0YyoCwoRYqtxgvqu7mS+2xE9mT5U0Xdgi0cZr9C7drytu1dbSKy4
 KCumckRcPZfBpSTLHkRCrzuHdoEB/QgmJCc2BLvV/ho8UrZQeSdqUdTO
X-Gm-Gg: AR+sD12oCYkWdiaxsbmzGU9NOQ/ZTS++VY7whO3KVpx2PxveJ9uOOlL53u/Go+X4aHU
 GWXab4+1XolRte9Ra69USRW4pEOjYgIkmiU/yFAd75bjxZvAGFt5C3kjh8h7cyWgmPZ+yytvSTq
 yeuZoFXjQqlHmaHix6Rc7J+NGFyfvu+jRI4q48qZhqI80AGS9RflUVP5ZcVoqJi7ue4fVHczDE8
 +SrUoUOVtvi+43xgm88SyqJopNNlUfUJHgjPT0cwGmIBfgvhfeIelaWhzhQq3oYc/qwlUWoRh2g
 DcGz1PqGLwoXxI+H4ssB+DUjbVEOvEWTBupxHJUtGsvbBcGmAw+5abwdzBwdMkyCvC1V4yl2JGg
 YIGC+0ihwg6MgrJkCBo+hNClkOUUFFzMPeHN7Yrp0phWjbuRcC8AOGRG1nlOSP7sT9gw8bM85uN
 KNmnwBzJRMmNfdZcteT6FduDeB7DuehUtjOATJLA==
X-Received: by 2002:a05:6000:603:b0:47f:8183:e9c9 with SMTP id
 ffacd0b85a97d-47f8d61a1c5mr6043402f8f.1.1784838970602; 
 Thu, 23 Jul 2026 13:36:10 -0700 (PDT)
Received: from michalis-linux (adsl-75.176.58.251.tellas.gr. [176.58.251.75])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85a2573csm17469806f8f.0.2026.07.23.13.36.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 13:36:10 -0700 (PDT)
From: Michail Tatas <michail.tatas@gmail.com>
To: michael@amarulasolutions.com, neil.armstrong@linaro.org,
 jesszhan0024@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, dianders@chromium.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Michail Tatas <michail.tatas@gmail.com>
Subject: [PATCH v4 2/3] drm/panel: ilitek-ili9805: Use dsi_multi in init
Date: Thu, 23 Jul 2026 23:36:00 +0300
Message-ID: <20260723203601.806697-3-michail.tatas@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723203601.806697-1-michail.tatas@gmail.com>
References: <20260723203601.806697-1-michail.tatas@gmail.com>
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

Drop the struct ili9805_instr and the init table
and use init functions.

Signed-off-by: Michail Tatas <michail.tatas@gmail.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
 drivers/gpu/drm/panel/panel-ilitek-ili9805.c | 161 +++++++++----------
 1 file changed, 76 insertions(+), 85 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9805.c b/drivers/gpu/drm/panel/panel-ilitek-ili9805.c
index 7e9587afebbe..1339604a0c94 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili9805.c
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9805.c
@@ -25,22 +25,8 @@
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
-	const char *name;
-	const struct ili9805_instr *init;
-	const size_t init_length;
+	void (*init)(struct mipi_dsi_multi_context *ctx);
 	const struct drm_display_mode *mode;
 	u32 width_mm;
 	u32 height_mm;
@@ -56,65 +42,80 @@ struct ili9805 {
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
+	mipi_dsi_dcs_set_pixel_format_multi(ctx, 0x77);
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
+	mipi_dsi_dcs_set_pixel_format_multi(ctx, 0x77);
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
@@ -160,16 +161,8 @@ static int ili9805_power_off(struct ili9805 *ctx)
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
@@ -246,7 +239,7 @@ static const struct drm_display_mode tm041xdhg01_timing = {
 };
 
 static int ili9805_get_modes(struct drm_panel *panel,
-			      struct drm_connector *connector)
+			     struct drm_connector *connector)
 {
 	struct ili9805 *ctx = panel_to_ili9805(panel);
 	struct drm_display_mode *mode;
@@ -343,7 +336,6 @@ static void ili9805_dsi_remove(struct mipi_dsi_device *dsi)
 
 static const struct ili9805_desc gpm1780a0_desc = {
 	.init = gpm1780a0_init,
-	.init_length = ARRAY_SIZE(gpm1780a0_init),
 	.mode = &gpm1780a0_timing,
 	.width_mm = 65,
 	.height_mm = 65,
@@ -351,7 +343,6 @@ static const struct ili9805_desc gpm1780a0_desc = {
 
 static const struct ili9805_desc tm041xdhg01_desc = {
 	.init = tm041xdhg01_init,
-	.init_length = ARRAY_SIZE(tm041xdhg01_init),
 	.mode = &tm041xdhg01_timing,
 	.width_mm = 42,
 	.height_mm = 96,
-- 
2.43.0

