Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 627D2F3ED4B
	for <dri-devel@archiver.kernel.org>; Sat, 11 Apr 2026 12:29:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 149AF10E1F4;
	Sat, 11 Apr 2026 12:29:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ALu0EJ33";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4F5210E0F0
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 01:07:09 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-488a14c31eeso20184445e9.0
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 18:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775869628; x=1776474428; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VXgKZw4TerZdjUCdZpd91YopqLadLVyAhvrKe3AYvDs=;
 b=ALu0EJ33vx8tPTShS8cTIOLsQcXeieS5ZiVNHHcWnaP5hH+sQrJYhkH+2NQkQ0yOJ4
 nC/62r7meSq/oGCX29nKPqGGecia9yep73Ix3diQfKd/OPS3duYG/YLA5bqlTebk35Vj
 w4wBm2oGZD8YpQvMDimxys/yugBEIaTrRBcQTuULSYo1sOqXQADamPrqYQo+q1kIX605
 fWcRDFgN7T4mI4axEW5sH4YN0gAX1hUv25q2K15WnTtI5OLeyQQ2iwlcR2dLU5ciagj5
 2thFs7O0tC43WDVy+fBJhzfwiXJJyMNQD3chud5yPRnYM/nhCPjpJmGglXQaxwgj4y7H
 mhQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775869628; x=1776474428;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VXgKZw4TerZdjUCdZpd91YopqLadLVyAhvrKe3AYvDs=;
 b=TUZZYV2fwjZmaTTY+sx+A9dV0gy6apk2ooD9V0do1ZJ1Ms1a9EfCGi70Z5MfW7uamB
 g0rThF+fTQfoGbX0rG60AW2B9ryXC6svNbg/3hJ2slShSqtfBvcyBtuGBS6DwYuWNhSL
 tsV7eAzSP5Q607b7RRksDWNy1GWSfoEp+Gn7DmHQKTgkWJ4bmU6EjPH0+xzBScSJNpna
 3aX9mLsSaP/JieZw4pZR+9oDYoTG0XJLd6kaQLFzchURZ2860CULMJuOZaTKSfXHc8xR
 E11bP+Fqo+91ICGKlNMzn2kF5UwHBWeetFLQ6amrBdcHtQKbYqF2jmZ/Vz7ukz8bMPeT
 Rzpg==
X-Gm-Message-State: AOJu0YwSqgKrB7LtghUg4Zm75Lq9zsTKUR+v7izwwmSsLfff/FUuK6bU
 LJQisprNf5WiqQqtrawcCgKpiKPA8MX+yhW2GfCBKOwJp7NlKHVe4EBk
X-Gm-Gg: AeBDieshi0eyDHAt3Bod/uX9Dt+RS1iTEfei0IhT0Gu5Ii/5GHSFrSzLA85uXVoeEXD
 P/AtlhUpDwam6Y/xCgr0/CPCLu7W8zPVvhZOAAXgWAvrzqGJJgXRBwAgACPQgJa9XRNCVMCTLou
 iKO7rpofvWG5ePAvRRtfvJnoyr0Y2enbJHj1rpqt74gSrKCkHoGtRTZQ6HyKzp4gCiBvDUNluBa
 pYCZGM0grgFWWss9evWhL/FVUCyRw43jdyxnHDwpwyAoDzcXs50X3kBaeAqJTnDQ47mcTg45RM9
 LIIGv6x6T9gMQRjOsuqmQKpJi57a+GRDt5g/3rrToQ4sPI3+snyq8RXAO97QNSclkyDQSERMBqT
 g5FAcgoK3QqSS5VnFdLQyz6KwhJC7qVLjhgkcuQC0UcOqyhh9hJhCxsyIOUeYLMr1T8hoL3Udla
 jxUagLBC0ye75iMPks+QuMVzPRk4nf93rS6cXmB3nwLUAZjEvpDcKYVhoIfMksJrYrLrNN
X-Received: by 2002:a05:600c:800f:b0:47e:e2eb:bc22 with SMTP id
 5b1f17b1804b1-488d67b8d81mr68725315e9.5.1775869628136; 
 Fri, 10 Apr 2026 18:07:08 -0700 (PDT)
Received: from localhost.localdomain ([2a02:6b60:60:a500::100f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d5b3d4dbsm108662525e9.14.2026.04.10.18.07.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 18:07:07 -0700 (PDT)
From: Hussain Qadri <hussain.bqadri@gmail.com>
To: andrzej.hajda@intel.com,
	neil.armstrong@linaro.org,
	rfoss@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Hussain Qadri <hussain.bqadri@gmail.com>
Subject: [PATCH] drm/bridge: tc358762: Use mipi_dsi_generic_write_multi()
Date: Sat, 11 Apr 2026 02:06:48 +0100
Message-ID: <20260411010648.39585-1-hussain.bqadri@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 11 Apr 2026 12:29:27 +0000
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

Replace the driver-local error accumulation around
mipi_dsi_generic_write() with mipi_dsi_generic_write_multi()
and struct mipi_dsi_multi_context.

Signed-off-by: Hussain Qadri <hussain.bqadri@gmail.com>
---
 drivers/gpu/drm/bridge/tc358762.c | 46 +++++++++++--------------------
 1 file changed, 16 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358762.c b/drivers/gpu/drm/bridge/tc358762.c
index 98df3e667d4a..0630c4078987 100644
--- a/drivers/gpu/drm/bridge/tc358762.c
+++ b/drivers/gpu/drm/bridge/tc358762.c
@@ -76,25 +76,12 @@ struct tc358762 {
 	struct gpio_desc *reset_gpio;
 	struct drm_display_mode mode;
 	bool pre_enabled;
-	int error;
 };
 
-static int tc358762_clear_error(struct tc358762 *ctx)
+static void tc358762_write(struct mipi_dsi_multi_context *dsi_ctx, u16 addr, u32 val)
 {
-	int ret = ctx->error;
-
-	ctx->error = 0;
-	return ret;
-}
-
-static void tc358762_write(struct tc358762 *ctx, u16 addr, u32 val)
-{
-	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
-	ssize_t ret;
 	u8 data[6];
 
-	if (ctx->error)
-		return;
 
 	data[0] = addr;
 	data[1] = addr >> 8;
@@ -103,9 +90,7 @@ static void tc358762_write(struct tc358762 *ctx, u16 addr, u32 val)
 	data[4] = val >> 16;
 	data[5] = val >> 24;
 
-	ret = mipi_dsi_generic_write(dsi, data, sizeof(data));
-	if (ret < 0)
-		ctx->error = ret;
+	mipi_dsi_generic_write_multi(dsi_ctx, data, sizeof(data));
 }
 
 static inline struct tc358762 *bridge_to_tc358762(struct drm_bridge *bridge)
@@ -115,17 +100,19 @@ static inline struct tc358762 *bridge_to_tc358762(struct drm_bridge *bridge)
 
 static int tc358762_init(struct tc358762 *ctx)
 {
+	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
 	u32 lcdctrl;
 
-	tc358762_write(ctx, DSI_LANEENABLE,
+	tc358762_write(&dsi_ctx, DSI_LANEENABLE,
 		       LANEENABLE_L0EN | LANEENABLE_CLEN);
-	tc358762_write(ctx, PPI_D0S_CLRSIPOCOUNT, 5);
-	tc358762_write(ctx, PPI_D1S_CLRSIPOCOUNT, 5);
-	tc358762_write(ctx, PPI_D0S_ATMR, 0);
-	tc358762_write(ctx, PPI_D1S_ATMR, 0);
-	tc358762_write(ctx, PPI_LPTXTIMECNT, LPX_PERIOD);
+	tc358762_write(&dsi_ctx, PPI_D0S_CLRSIPOCOUNT, 5);
+	tc358762_write(&dsi_ctx, PPI_D1S_CLRSIPOCOUNT, 5);
+	tc358762_write(&dsi_ctx, PPI_D0S_ATMR, 0);
+	tc358762_write(&dsi_ctx, PPI_D1S_ATMR, 0);
+	tc358762_write(&dsi_ctx, PPI_LPTXTIMECNT, LPX_PERIOD);
 
-	tc358762_write(ctx, SPICMR, 0x00);
+	tc358762_write(&dsi_ctx, SPICMR, 0x00);
 
 	lcdctrl = LCDCTRL_VSDELAY(1) | LCDCTRL_RGB888 |
 		  LCDCTRL_UNK6 | LCDCTRL_VTGEN;
@@ -136,17 +123,16 @@ static int tc358762_init(struct tc358762 *ctx)
 	if (ctx->mode.flags & DRM_MODE_FLAG_NVSYNC)
 		lcdctrl |= LCDCTRL_VSPOL;
 
-	tc358762_write(ctx, LCDCTRL, lcdctrl);
+	tc358762_write(&dsi_ctx, LCDCTRL, lcdctrl);
 
-	tc358762_write(ctx, SYSCTRL, 0x040f);
+	tc358762_write(&dsi_ctx, SYSCTRL, 0x040f);
 	msleep(100);
 
-	tc358762_write(ctx, PPI_STARTPPI, PPI_START_FUNCTION);
-	tc358762_write(ctx, DSI_STARTDSI, DSI_RX_START);
+	tc358762_write(&dsi_ctx, PPI_STARTPPI, PPI_START_FUNCTION);
+	tc358762_write(&dsi_ctx, DSI_STARTDSI, DSI_RX_START);
 
 	msleep(100);
-
-	return tc358762_clear_error(ctx);
+	return dsi_ctx.accum_err;
 }
 
 static void tc358762_post_disable(struct drm_bridge *bridge,
-- 
2.53.0

