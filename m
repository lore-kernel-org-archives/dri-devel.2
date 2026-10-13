Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1DE6CC6B10
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 07:54:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2C4D10F5B6;
	Tue, 13 Oct 2026 07:53:48 +0000 (UTC)
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com
 [74.125.224.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D69C210E714
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 04:35:56 +0000 (UTC)
Received: by mail-yx1-f41.google.com with SMTP id
 956f58d0204a3-66c9995ca60so4278006d50.1
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 21:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791866156; x=1792470956; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rPZxZeQ1MN5oxdqJmVTe39KchSUoN5mtLJpoRFFbDDY=;
 b=LNWw+H7yr7Lkim7SytdJtSUtOMyIvoScJTLzbhlOuiO7EEwbpWD/EWj8rcfcJqvhjj
 13ITX4Ystcu7a5RmRFP+gfyCp3HpB8whoJt9Cm0l3WmbSjIq8GtuIyg1WUM/QMIEwDGM
 Mt2QM2E1ChQkRaf5f8UActsWaalkBGaaL6vr9vhYczK/C5g6FXoEamjfz1c39t5O8fxe
 RZVpFY9FPCuQcLqSn7s0SZuJttFly3vckIOD5C/hwyb3XynZdfpsjqhbYx46qdA6qc0L
 +MY37BhgTOCg1vXw/Ytot5rmhpPyF2sQyOIg5k/xzkPRGn9a1EmxTizLw4gNJjVc7WQT
 dApg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791866156; x=1792470956;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rPZxZeQ1MN5oxdqJmVTe39KchSUoN5mtLJpoRFFbDDY=;
 b=lazsY6FgI+gT6kfjtLFvrjss+B8XZvnYWWhH55e9o+uUJfEK9ZpcVAmqrPfArYCrNf
 4uuaH88XszQ5cMaj0XPJLWXGkqpSH5qmW9gk1cjsNJezDcf/wr893Jq/xoregeQ0a9G9
 Gkt5XUttjaasfQdrJB6TaWQy+hgLCUdQlRNOOW3pGXhtj6U7+1MKhm/HzxeFZDi9Y96M
 IzSRj2hdt0OwDU7M/I2k3nhspfjkQi4uJ9R2FJLYXMhasdG4nTMA+2HS7FezfHvl/mz4
 KDX9G/K8MgO06e3McDOdiVgwH85MFyeVXe6p18sBmWXgk3HmC3ylNWdGzztJwRt/zS3T
 sjjQ==
X-Gm-Message-State: AFq9FYLvBRHxRMfVHnUqyK8i0LB/l+T32BpuT05HAebt1zoVdFhRxyko
 dbHf8JIlE4UQQpzhHGJV5Td4IZH0kQTNhThYmuQH/nM4VohTWuu0GHZP
X-Gm-Gg: AYBFou3Nh/jukYVUQ52kryxa7i0AMcBN6PLZKUlxN2Ub85L+pumSHhXwc4VEX/KkJeu
 6ZKpEHzHMlM6QQTsZ0+Z+WwFgfGBiaKhOdtPGK1KrlYjaH00spD4mt2sWYfkW0DnO5G8PV9S1RH
 5Ks2YkB6AmgRrbBZbX9CNNiFtDbjCs2Ew1xbDrwUUuxEFMQvNVYotIPTP9m82T+SZEpg/qKC1RH
 WvuYolRVLYVEIa19G36fWj0HqTsAH2Vg+pzPf1VYfHBxLRMDFexdIGgVjO/txEXTeCBoxPunLFN
 DDurb/nT8X2ULuuy0GKe5yUpx3UEN1dm+8znXfaJnGINgjzvo80NE6V50ZZQRPiXdgn3VaoRvN+
 mO3iPTDW+adbNvs5IDB4o+k+WowFgJeaJ2xORhjiod+Y3FMlIrb76WMZKKYs4CkLSJWMHOTaxtc
 UoKErEtA8Qd9YuaDIExR4o3aSJaHIY1GKLGRkzRat/IrO35ULuGG818bFM0030sD6cAD0QvPyTG
 pip3zFQupBZtw==
X-Received: by 2002:a05:690e:11c8:b0:677:d5bd:8336 with SMTP id
 956f58d0204a3-67938974c0cmr3660343d50.16.1791866155837; 
 Mon, 12 Oct 2026 21:35:55 -0700 (PDT)
Received: from [192.168.1.71] ([2600:1702:56e9:4b40:e3a9:78c5:641e:a58c])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-67935606f5esm4448152d50.4.2026.10.12.21.35.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 21:35:55 -0700 (PDT)
From: Akash Sukhavasi <akash.sukhavasi@gmail.com>
Date: Mon, 12 Oct 2026 23:34:38 -0500
Subject: [PATCH 3/4] drm/panel: innolux-p079zca: Use mipi_dsi_*_multi();
 fix minor bugs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-mipi-multi-series-v1-3-6a29add1ec92@gmail.com>
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
existing poweroff label anyway.

In unprepare(), keep plain msleep() since the hardware delays must
execute regardless of any prior DSI error. The original code logged a
set_display_off() failure and still attempted enter_sleep_mode(), so
clear accum_err after set_display_off_multi() to keep that behaviour.

This also fixes a bug where a failure in enter_sleep_mode would return
early, skipping the sleep-mode delay, GPIO deassertion, power-down
delay, and regulator teardown, leaving the panel stuck in a prepared
state. Because drm_panel_unprepare() does not clear panel->prepared
when the callback returns an error, drm_panel_prepare() would return
early on the next call, leaving the panel unable to be re-initialised.

For the same reason, stop returning the regulator_bulk_disable() error
from unprepare(). Returning it would leave the panel in the same stuck
state.

Signed-off-by: Akash Sukhavasi <akash.sukhavasi@gmail.com>
---
Compile tested only, no hardware available. checkpatch and a W=1
build are clean.
---
 drivers/gpu/drm/panel/panel-innolux-p079zca.c | 43 ++++++++++-----------------
 1 file changed, 16 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-innolux-p079zca.c b/drivers/gpu/drm/panel/panel-innolux-p079zca.c
index 80afeeab9475..8da2f9b2ddde 100644
--- a/drivers/gpu/drm/panel/panel-innolux-p079zca.c
+++ b/drivers/gpu/drm/panel/panel-innolux-p079zca.c
@@ -54,17 +54,13 @@ static inline struct innolux_panel *to_innolux_panel(struct drm_panel *panel)
 static int innolux_panel_unprepare(struct drm_panel *panel)
 {
 	struct innolux_panel *innolux = to_innolux_panel(panel);
-	int err;
-
-	err = mipi_dsi_dcs_set_display_off(innolux->link);
-	if (err < 0)
-		dev_err(panel->dev, "failed to set display off: %d\n", err);
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = innolux->link };
 
-	err = mipi_dsi_dcs_enter_sleep_mode(innolux->link);
-	if (err < 0) {
-		dev_err(panel->dev, "failed to enter sleep mode: %d\n", err);
-		return err;
-	}
+	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
+	/* Reset error to continue power-down sequence even if display off failed */
+	dsi_ctx.accum_err = 0;
+	/* Enter sleep mode; error does not prevent power-off */
+	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
 
 	if (innolux->desc->sleep_mode_delay)
 		msleep(innolux->desc->sleep_mode_delay);
@@ -74,10 +70,8 @@ static int innolux_panel_unprepare(struct drm_panel *panel)
 	if (innolux->desc->power_down_delay)
 		msleep(innolux->desc->power_down_delay);
 
-	err = regulator_bulk_disable(innolux->desc->num_supplies,
-				     innolux->supplies);
-	if (err < 0)
-		return err;
+	regulator_bulk_disable(innolux->desc->num_supplies,
+			       innolux->supplies);
 
 	return 0;
 }
@@ -85,6 +79,7 @@ static int innolux_panel_unprepare(struct drm_panel *panel)
 static int innolux_panel_prepare(struct drm_panel *panel)
 {
 	struct innolux_panel *innolux = to_innolux_panel(panel);
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = innolux->link };
 	int err;
 
 	gpiod_set_value_cansleep(innolux->enable_gpio, 0);
@@ -108,24 +103,18 @@ static int innolux_panel_prepare(struct drm_panel *panel)
 			goto poweroff;
 	}
 
-	err = mipi_dsi_dcs_exit_sleep_mode(innolux->link);
-	if (err < 0) {
-		dev_err(panel->dev, "failed to exit sleep mode: %d\n", err);
-		goto poweroff;
-	}
-
+	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
 	/* T6: 120ms - 1000ms*/
-	msleep(120);
+	mipi_dsi_msleep(&dsi_ctx, 120);
+	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
+	/* T7: 5ms */
+	mipi_dsi_usleep_range(&dsi_ctx, 5000, 6000);
 
-	err = mipi_dsi_dcs_set_display_on(innolux->link);
-	if (err < 0) {
-		dev_err(panel->dev, "failed to set display on: %d\n", err);
+	if (dsi_ctx.accum_err) {
+		err = dsi_ctx.accum_err;
 		goto poweroff;
 	}
 
-	/* T7: 5ms */
-	usleep_range(5000, 6000);
-
 	return 0;
 
 poweroff:

-- 
2.56.0

