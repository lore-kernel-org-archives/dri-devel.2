Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFFE3CC6B13
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 07:54:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F29C410F5C9;
	Tue, 13 Oct 2026 07:53:48 +0000 (UTC)
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com
 [74.125.224.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8C8A10E731
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 04:35:53 +0000 (UTC)
Received: by mail-yx1-f41.google.com with SMTP id
 956f58d0204a3-679334baa1fso1871680d50.2
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 21:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791866153; x=1792470953; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZJYJafIRYHrf+Y6ybXa+ws4RGB1oa5Cfi7dRuSbb02U=;
 b=GDsHZ+2rR/Gr9KcEtO1LkVKKvMa9EFaqBDQcOWeevnXiFfg6t3cxdebqe5BQrNCIDE
 c93ohMwRihnGucfaFmtD90Cee7V20htsZQsql48Wo4dQzJy5eUTI+k9VQvmkmJ5tF21T
 qkh+7tZ3Ls+lgNKS0MTbYwwGt/qu/PhMwRIPcfCRdYPDoyE8agOd7sMyWepYioDuiv4r
 SKxmSrQBtm6VamONCRsGx+ARAWshf+f0cKzXalaYpvEsMm1gu0bXSMPv9v7ciiWBTa50
 hAtZynsyt9VoUkRLQdbQeMjKXLcafYFqi8R/3Fm8djBx0LnzQczGVVZHDzOu/Hb1OIvA
 RDLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791866153; x=1792470953;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZJYJafIRYHrf+Y6ybXa+ws4RGB1oa5Cfi7dRuSbb02U=;
 b=QP3IKDOJ5LqFMNVSY947q3vWbIZydWZHx1ePJEPhJFyX7A5xxS0XoVBM+O6zPoy2dI
 VMAeuV9ISCdcI3qCj3s8aVZEtt2Bb4uEwlAE1lzJyJ7/sI1s+K4W92/torxdM+G4KSTU
 93Wk2QSDf0FDyILElKRkOhIpsOmnfPQU1bXvdLe7jiCW/7MYBM6s2cYtR/MMFi96iWog
 2XBuFUmCWXpdUdFj40IKNKZzPGB5Qnpng6TZH5YuFwtqOnlM7mm8dhwPPimYM3A/Mutp
 gv66HL7czeSTUFyHa0zpyPON84BpeoBfY6B70Qb8tcmV98qm6+W4E5J7mocVvSzSU8zq
 azDA==
X-Gm-Message-State: AFq9FYK1OAUKJIo4Na0F5vReVWf2oinZWFbfvO4TVXoFJZK/0vr+8Mrz
 cAC78kO3ycClyDZARv5r2ayN8WoUpEGWSi4QIiLbrC2N0YmZZuhbQGPj
X-Gm-Gg: AYBFou3UUJtAP+sxhQOXh759PxuN6DuC2EDyExGFZ1jkjKy6IcvRldfdGHwtflgXZ2D
 LjYhDkzlahUTz6ZOTyZQptOMBoIe4FksblQvxiKUg8nImpQq98O4UX8pwh+SwJZrrcpqsLiNJxV
 VdvpsUlS+pv85SKK//dQNLK9cyHB9ejKwm7z91/aRhk1GV/NV6nfi0TXG+G3xRdp3jTzqBCPLkW
 vsQpyVzvDg+ldPZ16hwHG+AjKGnO1zTylp+FuBdQCZjhDsbUf97GAh4xVAfOJAI2KDWZWjUXEV8
 hYOQnZoRFPArJc8miEeh8cC/a/4MpOpaVQvaiiXB2mYrDzWxYb3nErWcjIfTEHtvt2zDCTeT4Q3
 PbYcokDsPl1jGhKj3RrbtrKQHw/8cRz/VNeB+iDZJrAlFBre0wd6NRw0V5C7sSn4ZZaOECD3V52
 MeBAqKHrI62aJ4FpPV3eER1AHJLVcfvjihwDoA9LvWlbYNXtDGsC3EgHcIjNaUSbpXDH9kCRJVw
 6SlDNZvEKD5xYqgzQ22SjrJ
X-Received: by 2002:a05:690e:e8a:b0:677:ceec:5eac with SMTP id
 956f58d0204a3-679362efcc4mr3015665d50.107.1791866152700; 
 Mon, 12 Oct 2026 21:35:52 -0700 (PDT)
Received: from [192.168.1.71] ([2600:1702:56e9:4b40:e3a9:78c5:641e:a58c])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-67935606f5esm4448152d50.4.2026.10.12.21.35.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 21:35:51 -0700 (PDT)
From: Akash Sukhavasi <akash.sukhavasi@gmail.com>
Date: Mon, 12 Oct 2026 23:34:36 -0500
Subject: [PATCH 1/4] drm/panel: leadtek-ltk500hd1829: Use
 mipi_dsi_*_multi()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-mipi-multi-series-v1-1-6a29add1ec92@gmail.com>
References: <20261012-mipi-multi-series-v1-0-6a29add1ec92@gmail.com>
In-Reply-To: <20261012-mipi-multi-series-v1-0-6a29add1ec92@gmail.com>
To: Doug Anderson <dianders@chromium.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Akash Sukhavasi <akash.sukhavasi@gmail.com>, 
 Heiko Stuebner <heiko@sntech.de>
X-Mailer: b4 0.14.3
X-Mailman-Approved-At: Tue, 13 Oct 2026 07:52:59 +0000
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

The mipi_dsi_dcs_*() and mipi_dsi_generic_write() functions used by
this driver are deprecated in favour of their _multi() counterparts,
as noted in Documentation/gpu/todo.rst. The _multi() variants record
the first error in a context structure and skip subsequent calls once
an error is set, removing the need to check the return value after
each command. They also log failures internally, making the per-call
dev_err() calls redundant.

Convert prepare() and unprepare() to use the _multi() equivalents.

In prepare(), use mipi_dsi_msleep() instead of plain msleep() so the
delay is skipped on prior error, since the function will clean up
via the existing disable_iovcc label anyway.

In unprepare(), keep plain msleep() since the hardware delay must
execute regardless of any prior DSI error. The original code logged
a set_display_off() failure and still attempted enter_sleep_mode(),
so clear accum_err after set_display_off_multi() to keep that
behaviour. An enter_sleep_mode() failure was also only logged, and
that stays the same.

Cc: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Akash Sukhavasi <akash.sukhavasi@gmail.com>
---
Compile tested only, no hardware available. checkpatch and a W=1
build are clean.
---
 drivers/gpu/drm/panel/panel-leadtek-ltk500hd1829.c | 40 ++++++++--------------
 1 file changed, 14 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-leadtek-ltk500hd1829.c b/drivers/gpu/drm/panel/panel-leadtek-ltk500hd1829.c
index ff35b62a327e..ee65506477df 100644
--- a/drivers/gpu/drm/panel/panel-leadtek-ltk500hd1829.c
+++ b/drivers/gpu/drm/panel/panel-leadtek-ltk500hd1829.c
@@ -489,16 +489,13 @@ static int ltk500hd1829_unprepare(struct drm_panel *panel)
 {
 	struct ltk500hd1829 *ctx = panel_to_ltk500hd1829(panel);
 	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
-	int ret;
-
-	ret = mipi_dsi_dcs_set_display_off(dsi);
-	if (ret < 0)
-		dev_err(panel->dev, "failed to set display off: %d\n", ret);
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
 
-	ret = mipi_dsi_dcs_enter_sleep_mode(dsi);
-	if (ret < 0) {
-		dev_err(panel->dev, "failed to enter sleep mode: %d\n", ret);
-	}
+	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
+	/* Reset error to continue power-down sequence even if display off failed */
+	dsi_ctx.accum_err = 0;
+	/* Enter sleep mode; error does not prevent power-off */
+	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
 
 	/* 120ms to enter sleep mode */
 	msleep(120);
@@ -513,6 +510,7 @@ static int ltk500hd1829_prepare(struct drm_panel *panel)
 {
 	struct ltk500hd1829 *ctx = panel_to_ltk500hd1829(panel);
 	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
 	unsigned int i;
 	int ret;
 
@@ -535,27 +533,17 @@ static int ltk500hd1829_prepare(struct drm_panel *panel)
 	/* tRT: >= 5ms */
 	usleep_range(5000, 6000);
 
-	for (i = 0; i < ctx->panel_desc->num_init; i++) {
-		ret = mipi_dsi_generic_write(dsi, &ctx->panel_desc->init[i],
+	for (i = 0; i < ctx->panel_desc->num_init; i++)
+		mipi_dsi_generic_write_multi(&dsi_ctx, &ctx->panel_desc->init[i],
 					     sizeof(struct ltk500hd1829_cmd));
-		if (ret < 0) {
-			dev_err(panel->dev, "failed to write init cmds: %d\n", ret);
-			goto disable_iovcc;
-		}
-	}
-
-	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
-	if (ret < 0) {
-		dev_err(panel->dev, "failed to exit sleep mode: %d\n", ret);
-		goto disable_iovcc;
-	}
 
+	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
 	/* 120ms to exit sleep mode */
-	msleep(120);
+	mipi_dsi_msleep(&dsi_ctx, 120);
+	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
 
-	ret = mipi_dsi_dcs_set_display_on(dsi);
-	if (ret < 0) {
-		dev_err(panel->dev, "failed to set display on: %d\n", ret);
+	if (dsi_ctx.accum_err) {
+		ret = dsi_ctx.accum_err;
 		goto disable_iovcc;
 	}
 

-- 
2.56.0

