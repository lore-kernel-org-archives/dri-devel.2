Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11569CC6B0E
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 07:54:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C5FA10F5A7;
	Tue, 13 Oct 2026 07:53:23 +0000 (UTC)
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com
 [74.125.224.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 959E210E714
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 04:36:03 +0000 (UTC)
Received: by mail-yx1-f50.google.com with SMTP id
 956f58d0204a3-67687f279b3so1914973d50.0
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 21:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791866162; x=1792470962; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nWBafGepq5jprFkNrEdJl0mPwThaR4s3Yj/sMZVg9k8=;
 b=eeEnEqLse2twwJw/knYvlU+aGF+fBTT5Qf1bgQltahSpCGbUN6nC7DTzJup+p1tJhA
 S54Kw/WUIEIH6kxbMskZRVba1zaCK2hTsyqMuWrDbt+tqleecnwGZBVxxpse8N3eUtsH
 x5RHNzlHojCqiKzBTSGhe3Ppq+N2hFG0HzCGIrLxegpZOp+x1YetZSNky8eDrpFGmC/d
 goYZR1pwd1Vi3xVpF8ljOeaNiRIgDDZo/Vl4R1+339er0yJAeBRpBpOzPHr8ohZu7xu+
 bwoePI+1jra1riqlZ4BkywemNJCg76dgYeCT+UvaI/sMEpEM08xbpdLb/JED4DWfqwRu
 oGCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791866162; x=1792470962;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nWBafGepq5jprFkNrEdJl0mPwThaR4s3Yj/sMZVg9k8=;
 b=E3D8F8wN975vz3KpbR3TLLykQiW/WDNzw3e7cBuh2j5kcz6DO/9HPqaJwDj0dCJQG7
 bkkXXtfMM6AA0BTbiKHdJ4AQrCepeFv8PfpyHdHn/XUxdWEVXsO5pC/UymbB7YpWZeQu
 m6I5hAR/Tv9LlgSPu9Cm65+aWT/psVHSeIsyteEG7Ijfo9NAbdb0e1XDlPofbDvw3LUl
 y7anBWbWvW0XXkVz+LvF7jXY8OZLClTSi6Fysdq4PYsqsH0ApmnwUkq9FS7wpBT1EAmj
 E6rmrRL2AkTMSvwCqolbgPv6AJb0g6EIaZQpLlARsWlWlIc1LASUcgQw0CZ2CJmdhZAt
 POJw==
X-Gm-Message-State: AFq9FYLPn7OHbfAnT2yFc/+Ak1X+cCA+YXZS2xixHg9+FbcP+3CMQLzR
 /2cKcM0yY+W7/B8yf6fDbtfJ7kbGP0Bsq3Py9NjrA/Kjf21eCzhHafZ7
X-Gm-Gg: AYBFou3ktMhR5NAAzB44PBhUea0gBdpOfI3jLlBcWDCsF5b7kEaFLVFPq/1E3DrDELY
 Y//lLyCNICEew4XsgR5m1Hd/3miyl5x1Re4nIjoukx/mp/5WSXFDfPIJq5Q2VlRIiAKtcstttn2
 ZuPXaKmNeDkTl5DZ4mqq87M6tmfvwcqC55/MtTX6AVbCG85dDd8v4z8FFhSALHmKK/MwtrNs9I7
 0uva/rSY+/vDVDVNd6BKwBbnpAM+id99LRHit/Zh+odQVzZJaipdYhEDZi1FTsbhq2ED+mebIve
 XVv+YKPVQ2aH8ptSKPunHUl4Jw16iAx4l2olPs0kKx/2SGUmtsDes7mPIzpl6STzV4QS1rEs8CF
 z2ww4oPNwXQnb8BZ9HRkorTCE4haDmlhmdZm5HUxm3a4Aw/aij8AIgepbxZUrA/ZOaY2bbYZ9hH
 0rJCil4NkxfHm3zgq+j9GHiO+SxUhky3fW/f1dxal4bA3N2DucR2Zj0p0lViSWKHG3RV39NPbki
 lxSPJ4nUF1MsRA=
X-Received: by 2002:a05:690e:14c8:b0:677:c9c1:25a2 with SMTP id
 956f58d0204a3-67958f083dbmr2300112d50.26.1791866157808; 
 Mon, 12 Oct 2026 21:35:57 -0700 (PDT)
Received: from [192.168.1.71] ([2600:1702:56e9:4b40:e3a9:78c5:641e:a58c])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-67935606f5esm4448152d50.4.2026.10.12.21.35.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 21:35:57 -0700 (PDT)
From: Akash Sukhavasi <akash.sukhavasi@gmail.com>
Date: Mon, 12 Oct 2026 23:34:39 -0500
Subject: [PATCH 4/4] drm/panel: newvision-nv3051d: Use mipi_dsi_*_multi();
 fix minor bugs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-mipi-multi-series-v1-4-6a29add1ec92@gmail.com>
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
 Chris Morgan <macromorgan@hotmail.com>
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

The mipi_dsi_dcs_*() functions used by this driver are deprecated in
favour of their _multi() counterparts, as noted in
Documentation/gpu/todo.rst. The _multi() variants record the first
error in a context structure and skip subsequent calls once an error
is set, removing the need to check the return value after each command.
They also log failures internally, making the per-call dev_err() calls
redundant.

Convert prepare() and unprepare() to use the _multi() equivalents.

In prepare(), use mipi_dsi_msleep() and mipi_dsi_usleep_range() instead
of plain msleep()/usleep_range() for delays between DSI commands, so
they are skipped on prior error since the function will clean up via the
existing disable_vdd label anyway.

In unprepare(), keep plain msleep() and usleep_range() since the
hardware delays must execute regardless of any prior DSI error. The
original code logged a set_display_off() failure and still attempted
enter_sleep_mode(), so clear accum_err after set_display_off_multi()
to keep that behaviour.

This also fixes a bug where a failure in enter_sleep_mode would return
early, skipping the post-sleep delay, reset GPIO assertion, and
regulator disable, leaving the panel stuck in a prepared state. Because
drm_panel_unprepare() does not clear panel->prepared when the callback
returns an error, drm_panel_prepare() would return early on the next
call, leaving the panel unable to be re-initialised.

Cc: Chris Morgan <macromorgan@hotmail.com>
Signed-off-by: Akash Sukhavasi <akash.sukhavasi@gmail.com>
---
Compile tested only, no hardware available. checkpatch and a W=1
build are clean.
---
 drivers/gpu/drm/panel/panel-newvision-nv3051d.c | 36 +++++++++----------------
 1 file changed, 13 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-newvision-nv3051d.c b/drivers/gpu/drm/panel/panel-newvision-nv3051d.c
index 22560384e48e..7dc25102a773 100644
--- a/drivers/gpu/drm/panel/panel-newvision-nv3051d.c
+++ b/drivers/gpu/drm/panel/panel-newvision-nv3051d.c
@@ -247,19 +247,14 @@ static int panel_nv3051d_unprepare(struct drm_panel *panel)
 {
 	struct panel_nv3051d *ctx = panel_to_panelnv3051d(panel);
 	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
-	int ret;
-
-	ret = mipi_dsi_dcs_set_display_off(dsi);
-	if (ret < 0)
-		dev_err(ctx->dev, "failed to set display off: %d\n", ret);
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
 
+	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
+	/* Reset error to continue power-down sequence even if display off failed */
+	dsi_ctx.accum_err = 0;
 	msleep(20);
-
-	ret = mipi_dsi_dcs_enter_sleep_mode(dsi);
-	if (ret < 0) {
-		dev_err(ctx->dev, "failed to enter sleep mode: %d\n", ret);
-		return ret;
-	}
+	/* Enter sleep mode; error does not prevent power-off */
+	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
 
 	usleep_range(10000, 15000);
 
@@ -274,6 +269,7 @@ static int panel_nv3051d_prepare(struct drm_panel *panel)
 {
 	struct panel_nv3051d *ctx = panel_to_panelnv3051d(panel);
 	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
 	int ret;
 
 	dev_dbg(ctx->dev, "Resetting the panel\n");
@@ -295,22 +291,16 @@ static int panel_nv3051d_prepare(struct drm_panel *panel)
 		goto disable_vdd;
 	}
 
-	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
-	if (ret < 0) {
-		dev_err(ctx->dev, "Failed to exit sleep mode: %d\n", ret);
-		goto disable_vdd;
-	}
-
-	msleep(200);
+	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
+	mipi_dsi_msleep(&dsi_ctx, 200);
+	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
+	mipi_dsi_usleep_range(&dsi_ctx, 10000, 15000);
 
-	ret = mipi_dsi_dcs_set_display_on(dsi);
-	if (ret < 0) {
-		dev_err(ctx->dev, "Failed to set display on: %d\n", ret);
+	if (dsi_ctx.accum_err) {
+		ret = dsi_ctx.accum_err;
 		goto disable_vdd;
 	}
 
-	usleep_range(10000, 15000);
-
 	return 0;
 
 disable_vdd:

-- 
2.56.0

