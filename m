Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3CB2CC6B15
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 07:53:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B89510F5A1;
	Tue, 13 Oct 2026 07:53:13 +0000 (UTC)
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com
 [74.125.224.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D8B310E735
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 04:35:55 +0000 (UTC)
Received: by mail-yx1-f47.google.com with SMTP id
 956f58d0204a3-677ad9083feso1778901d50.2
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 21:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791866154; x=1792470954; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Q79SjJi9kltChZ7QmatqFZHNr8QyYnXQCrfT5+1Exbs=;
 b=MYSZWbYo4ktnhcuB73nyaCSdbzoTzZTZh85HjYXTlTWH2XJqTJSpxFE+e92Uv4ggOA
 Y1D5VcoSbi+pCpL3OWLYFQY8b90n+oF2vlBUdaxKz2VE1Uiq5oALYdIaM8x7adBn/ygZ
 I6jCX/PbnJmqW/EpQnDRTudQbgmdPx0ltkG8zGu+i9Uu459lRJapUQ7HjyUU59ELWxB3
 0//o9cpl90cYUBwKXg6H6Lguzs8SkqmlEMHUeNa7xGDRR0QArq2VrDdhgsFy+etaziv4
 1dJFf8cmmiP2xKPTmTfeRcUQEWiW5g5aw2/xHUlpylhDPtOqvHuEvwjta1gyQRBhbCXB
 BXzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791866154; x=1792470954;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Q79SjJi9kltChZ7QmatqFZHNr8QyYnXQCrfT5+1Exbs=;
 b=aRd9iJVqAemVn7al/uXRHotWcPBvT3iqVZwFQ/XVO+3jjfcq9nJbttV20zMxAI//El
 qRkZc/M1bV+6ypZh4jIBh3JbIEkpkgg/bHAvM8jMsLcgfqt0BxoJpMe8fofb+f9gq2wI
 8jxJ69I5ioxWfDF4jvOXjB9vG7kmz2rXxDS+GbbAbd0QT4xKymwmx9tD54BSQ/x1N6np
 SoB9XObqNCeGi1r90HkLRlw7j/teE0nj1PnnjQyBG50LGIaO717kj0XlEoB5oKlXEmn3
 ndj/+PSv0oPj51/3W2L+vrC/BrNczI2wBJr6DFJwPF2eq8HKhAk3JUgXEtUk49J5xgl1
 zpbw==
X-Gm-Message-State: AFq9FYLT3vvLR4UlVUJOk6MWYgwN8o4bV/QRSKq6OB8IrRSll82xhwfV
 Uh+ZzcQVU/g/Sj/3WLVYwrqqB6VPSYl271houzbkNU/8gUDelMl5yWP2
X-Gm-Gg: AYBFou2u/7UPIpUDBp2z3u/5MciufP7FGpUJx0snnqkqgN0mmJBEgfUEnJE7m2Iz75U
 J89zoluIHUqAhl/mZgYp8ldLynfERCSQIgYiJpu77JrNRSW43Zy9gH1GZpMt1hSj6JY8qUMACvr
 S43x9AysGn9fv0+GmUw37Zx+uDDubz9+QCmdFJWkICaKyAxUDhph8UJNIvDKzSzKiTFOZIsjF2a
 KFDVyYTgTlhOva2DDF78xCSXfU3E1vqgsoazOPU6lNrjdEPZ+y/Ftv4zqvldsh2mbPuZF6atJgH
 VayE21E0XPhkMaK+5ObkO6JGSzzjTgZFdmURy5YKYf+j+eOCWjXn+dNhX4n+3nwU0KL7b+j8ll/
 WGHlLC4hitsftKprvPxxm0qjU0NeQUPvaD4aDfY25KwX8DxdwiFHlYQoLcnHgx2CI6rDM0myQeF
 KjpgCQbTe4x9QNE7QNI/Vtidi3hnyYZEZa/vqyEtkOyKnvGwUtiou1mhjLQkx/QQEKPhZHwK8W0
 nn4cMlIXayFiQ==
X-Received: by 2002:a05:690e:419c:b0:671:c5e:6d5 with SMTP id
 956f58d0204a3-6793678dd2amr3782267d50.4.1791866154340; 
 Mon, 12 Oct 2026 21:35:54 -0700 (PDT)
Received: from [192.168.1.71] ([2600:1702:56e9:4b40:e3a9:78c5:641e:a58c])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-67935606f5esm4448152d50.4.2026.10.12.21.35.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 21:35:54 -0700 (PDT)
From: Akash Sukhavasi <akash.sukhavasi@gmail.com>
Date: Mon, 12 Oct 2026 23:34:37 -0500
Subject: [PATCH 2/4] drm/panel: kingdisplay-kd097d04: Use
 mipi_dsi_*_multi(); fix minor bugs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-mipi-multi-series-v1-2-6a29add1ec92@gmail.com>
References: <20261012-mipi-multi-series-v1-0-6a29add1ec92@gmail.com>
In-Reply-To: <20261012-mipi-multi-series-v1-0-6a29add1ec92@gmail.com>
To: Doug Anderson <dianders@chromium.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Akash Sukhavasi <akash.sukhavasi@gmail.com>
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

Convert prepare(), disable(), and unprepare() to use the _multi()
equivalents.

In prepare(), use mipi_dsi_msleep() and mipi_dsi_usleep_range() instead
of plain msleep()/usleep_range() for delays between DSI commands, so
they are skipped on prior error since the function will clean up via the
existing poweroff label anyway.

In unprepare(), keep plain msleep() since the hardware delay must execute
regardless of any prior DSI error. This also fixes a bug where a failure
in enter_sleep_mode would return early, skipping the T15 delay, GPIO
deassertion, and regulator disable, leaving the panel stuck in a
prepared state. Because drm_panel_unprepare() does not clear
panel->prepared when the callback returns an error, drm_panel_prepare()
would return early on the next call, leaving the panel unable to be
re-initialised.

For the same reason, stop returning the regulator_disable() error from
unprepare(). Returning it would leave the panel in the same stuck state.

Signed-off-by: Akash Sukhavasi <akash.sukhavasi@gmail.com>
---
Compile tested only, no hardware available. checkpatch and a W=1
build are clean.
---
 drivers/gpu/drm/panel/panel-kingdisplay-kd097d04.c | 53 ++++++++--------------
 1 file changed, 18 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-kingdisplay-kd097d04.c b/drivers/gpu/drm/panel/panel-kingdisplay-kd097d04.c
index 893af9b16756..bc25ce1ce4a7 100644
--- a/drivers/gpu/drm/panel/panel-kingdisplay-kd097d04.c
+++ b/drivers/gpu/drm/panel/panel-kingdisplay-kd097d04.c
@@ -180,11 +180,10 @@ struct kingdisplay_panel *to_kingdisplay_panel(struct drm_panel *panel)
 static int kingdisplay_panel_disable(struct drm_panel *panel)
 {
 	struct kingdisplay_panel *kingdisplay = to_kingdisplay_panel(panel);
-	int err;
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = kingdisplay->link };
 
-	err = mipi_dsi_dcs_set_display_off(kingdisplay->link);
-	if (err < 0)
-		dev_err(panel->dev, "failed to set display off: %d\n", err);
+	/* Set display off; error does not prevent disable */
+	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
 
 	return 0;
 }
@@ -192,22 +191,16 @@ static int kingdisplay_panel_disable(struct drm_panel *panel)
 static int kingdisplay_panel_unprepare(struct drm_panel *panel)
 {
 	struct kingdisplay_panel *kingdisplay = to_kingdisplay_panel(panel);
-	int err;
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = kingdisplay->link };
 
-	err = mipi_dsi_dcs_enter_sleep_mode(kingdisplay->link);
-	if (err < 0) {
-		dev_err(panel->dev, "failed to enter sleep mode: %d\n", err);
-		return err;
-	}
+	/* Enter sleep mode; error does not prevent power-off */
+	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
 
 	/* T15: 120ms */
 	msleep(120);
 
 	gpiod_set_value_cansleep(kingdisplay->enable_gpio, 0);
-
-	err = regulator_disable(kingdisplay->supply);
-	if (err < 0)
-		return err;
+	regulator_disable(kingdisplay->supply);
 
 	return 0;
 }
@@ -215,6 +208,7 @@ static int kingdisplay_panel_unprepare(struct drm_panel *panel)
 static int kingdisplay_panel_prepare(struct drm_panel *panel)
 {
 	struct kingdisplay_panel *kingdisplay = to_kingdisplay_panel(panel);
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = kingdisplay->link };
 	int err, regulator_err;
 	unsigned int i;
 
@@ -232,33 +226,22 @@ static int kingdisplay_panel_prepare(struct drm_panel *panel)
 	/* T4: 15ms */
 	usleep_range(15000, 16000);
 
-	for (i = 0; i < ARRAY_SIZE(init_code); i++) {
-		err = mipi_dsi_generic_write(kingdisplay->link, &init_code[i],
-					sizeof(struct kingdisplay_panel_cmd));
-		if (err < 0) {
-			dev_err(panel->dev, "failed write init cmds: %d\n", err);
-			goto poweroff;
-		}
-	}
-
-	err = mipi_dsi_dcs_exit_sleep_mode(kingdisplay->link);
-	if (err < 0) {
-		dev_err(panel->dev, "failed to exit sleep mode: %d\n", err);
-		goto poweroff;
-	}
+	for (i = 0; i < ARRAY_SIZE(init_code); i++)
+		mipi_dsi_generic_write_multi(&dsi_ctx, &init_code[i],
+					     sizeof(struct kingdisplay_panel_cmd));
 
+	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
 	/* T6: 120ms */
-	msleep(120);
+	mipi_dsi_msleep(&dsi_ctx, 120);
+	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
+	/* T7: 10ms */
+	mipi_dsi_usleep_range(&dsi_ctx, 10000, 11000);
 
-	err = mipi_dsi_dcs_set_display_on(kingdisplay->link);
-	if (err < 0) {
-		dev_err(panel->dev, "failed to set display on: %d\n", err);
+	if (dsi_ctx.accum_err) {
+		err = dsi_ctx.accum_err;
 		goto poweroff;
 	}
 
-	/* T7: 10ms */
-	usleep_range(10000, 11000);
-
 	return 0;
 
 poweroff:

-- 
2.56.0

