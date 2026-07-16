Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B4A5C44524
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 07:15:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6087510E6D2;
	Mon, 20 Jul 2026 07:15:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FzcKif+C";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16FE410F3E6
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 22:09:45 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-493f75f7172so52823045e9.1
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 15:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784239783; x=1784844583; darn=lists.freedesktop.org;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=bDZJF2FHgZ0pc0vw2vaEItundHS+IICtSs7RbOX6+08=;
 b=FzcKif+CMv2enzdPsFIPLQVTBYdr5KqQ3RiezHUubXqoCivwShF+RK2KfcjFti5KPP
 /HRICc3zeXBlEiHWyM+IFmnp48TrzU7BSniXqz68gW8QINKa3tnq7cg9f79bfW3Xo1vm
 SAGC8Wa5i7DnV39JWInS/lI7oBdFDH+mqjH3+h5EYg5XCwG/lbkxotWY3j0acr5bEa8F
 Icfjct/hwXI3P66GZuWlApWdlddSMvnDxpkNADMbYzt0FmRdZknpmNL5dJzeNSwqK3HW
 z5eJzYHEFR3gLj8t2hDEJmnDaUZH9QWA5EscwhzQgCjh6xmWMMthSWnJ8Bu5biNpkO4Q
 4DJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784239783; x=1784844583;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bDZJF2FHgZ0pc0vw2vaEItundHS+IICtSs7RbOX6+08=;
 b=RdMqvmjNGJRKrGUUuKOcPMKn3VouDBn258iEgJrhKE4lOVvdsewpYpgq8fu4LkMxP/
 AeUNqZ+6YjndQ5ZUMJvloNF7KY3K6IqyhLTAT2cSwi7oRg4j5hDGUycaTRCPO2sSQosT
 jddbafOcMeEEE/fmVVkGl4Tu5ZkQdh+1D96l2BJQSa30BVKe9jYKcu8JIYqbMJvOr70G
 NCcSYfv1L3kM8ziXJGUFZ5ySYdM9adpBbpZ2XQXK3fu+ODl3zxhZLbcIQHAkAp0ByU4i
 bo4y5XdMRKQvEAeCMpSDUGA7M/sfRtRIj0iDugBiARnwLasZorfRUsul7byYLq6svbkP
 vcUg==
X-Gm-Message-State: AOJu0YwVPtvvq+DRw743QP0kHyIU/Bl9CPmJkM4KpDGsLtURLl+vjrMc
 zJNGFtX1NQYrS6Ks1c51pe64X5mVro8hfjpPzbMqkEKlx1JW3TRPqG64
X-Gm-Gg: AfdE7ckbPWFPc8fkeIlE+Yx/uiGsBpWKJIuJGzOH2QRNUCW/65fTt+3Ynhi6ly8bQI6
 tyl1IdP1+5b7yitUbRLESAGr7UYBtcWwTGoVUiFEsdvjqVjAWgTtJvMp7ZucPdSm7DhnCFiFdXm
 sx71uov+AXg4YrAAmgJVZH8vwx7jRckYWUQfqDMygg8Xy+HEXZG5mkoxIJCXTQGNWL7WPBnFVK8
 Oi1DlX1oXF0zdEru5ktkgPN9dR66UCwobx/GtvUsE76ZVYbqNUD3s8Qx24HpafgayBsp07mX5jE
 XgWBZU96HNMiGAA7np/8cwj7gesTf7z1ySb8bf/+X+KPkOzkE6/WVNgDjL3MbyeZqrWBjN1uy+q
 j0Sb7K7bCRmsO3kQIp+7l5zL+TUintB7Vvc7kRlKbBmyu2UQ6kV10xqvOYcDhyJR3OPdAjipPKF
 9Wj4LAZB1R6jvFIL6AePjqeiTRBzYgQJYGdMVGAg==
X-Received: by 2002:a05:600c:6dda:b0:495:3aac:1098 with SMTP id
 5b1f17b1804b1-49540bdfaa6mr45166035e9.32.1784239783219; 
 Thu, 16 Jul 2026 15:09:43 -0700 (PDT)
Received: from michalis-linux (adsl-75.176.58.251.tellas.gr. [176.58.251.75])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f4634e5c3sm26705895f8f.1.2026.07.16.15.09.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 15:09:42 -0700 (PDT)
Date: Fri, 17 Jul 2026 01:09:41 +0300
From: Michail Tatas <michail.tatas@gmail.com>
To: michael@amarulasolutions.com, neil.armstrong@linaro.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 dianders@chromium.org, jesszhan0024@gmail.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/panel: ilitek-ili9805: Use _multi variants
Message-ID: <allWpYxgHfpKughy@michalis-linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

Convert functions mipi_dsi_* to mipi_dsi_*_multi as per the
gpu/todo file.
The multi variant of these functions include improved error 
handling.

Signed-off-by: Michail Tatas <michail.tatas@gmail.com>
---
 drivers/gpu/drm/panel/panel-ilitek-ili9805.c | 51 +++++---------------
 1 file changed, 13 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9805.c b/drivers/gpu/drm/panel/panel-ilitek-ili9805.c
index e6c483851f1f..7e9587afebbe 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili9805.c
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9805.c
@@ -159,36 +159,23 @@ static int ili9805_power_off(struct ili9805 *ctx)
 
 static int ili9805_activate(struct ili9805 *ctx)
 {
-	struct mipi_dsi_device *dsi = ctx->dsi;
-	struct device *dev = &dsi->dev;
-	int i, ret;
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
+	int i;
 
 	for (i = 0; i < ctx->desc->init_length; i++) {
 		const struct ili9805_instr *instr = &ctx->desc->init[i];
 
-		ret = mipi_dsi_dcs_write_buffer(ctx->dsi, instr->data, instr->len);
-		if (ret < 0)
-			return ret;
+		mipi_dsi_dcs_write_buffer_multi(&dsi_ctx, instr->data, instr->len);
 
 		if (instr->delay > 0)
-			msleep(instr->delay);
-	}
-
-	ret = mipi_dsi_dcs_exit_sleep_mode(ctx->dsi);
-	if (ret) {
-		dev_err(dev, "Failed to exit sleep mode (%d)\n", ret);
-		return ret;
+			mipi_dsi_msleep(&dsi_ctx, instr->delay);
 	}
 
-	usleep_range(5000, 6000);
+	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
+	mipi_dsi_usleep_range(&dsi_ctx, 5000, 6000);
+	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
 
-	ret = mipi_dsi_dcs_set_display_on(ctx->dsi);
-	if (ret) {
-		dev_err(dev, "Failed to set display ON (%d)\n", ret);
-		return ret;
-	}
-
-	return 0;
+	return dsi_ctx.accum_err;
 }
 
 static int ili9805_prepare(struct drm_panel *panel)
@@ -211,25 +198,13 @@ static int ili9805_prepare(struct drm_panel *panel)
 
 static int ili9805_deactivate(struct ili9805 *ctx)
 {
-	struct mipi_dsi_device *dsi = ctx->dsi;
-	struct device *dev = &dsi->dev;
-	int ret;
-
-	ret = mipi_dsi_dcs_set_display_off(ctx->dsi);
-	if (ret < 0) {
-		dev_err(dev, "Failed to set display OFF (%d)\n", ret);
-		return ret;
-	}
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
 
-	usleep_range(5000, 10000);
-
-	ret = mipi_dsi_dcs_enter_sleep_mode(ctx->dsi);
-	if (ret < 0) {
-		dev_err(dev, "Failed to enter sleep mode (%d)\n", ret);
-		return ret;
-	}
+	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
+	mipi_dsi_usleep_range(&dsi_ctx, 5000, 10000);
+	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
 
-	return 0;
+	return dsi_ctx.accum_err;
 }
 
 static int ili9805_unprepare(struct drm_panel *panel)
-- 
2.43.0

