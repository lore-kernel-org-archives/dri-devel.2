Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCB42CC6B1D
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 13:51:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E056010FEB5;
	Wed, 14 Oct 2026 13:50:54 +0000 (UTC)
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com
 [209.85.215.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BAA910FEB5
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 13:50:48 +0000 (UTC)
Received: by mail-pg1-f181.google.com with SMTP id
 41be03b00d2f7-cc751eddf25so2528573a12.3
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 06:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791985848; x=1792590648; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=24RQVoLsUurrQma53DK6RaZwJpCvuTQH/vyoxxKrEHQ=;
 b=CKJqgJHZAJsB7JA9EU6vxLiTRx16jxTy3J8xNu8SC3tvkT7l1PBaYXOCccEpDOEqtu
 bfP+UDg9z2ZLV1HsjK7I2RAbxnm89NZhuSf4af1UCL8Tfrr83PRWLAhMrzXqISqH+VBX
 xaZ3W2XnJj6cB/G0HtMR55A54GQ4XIHNSyCMHTu8O0sh+sM/xb4UCtZ6ZQDZlLVqClmw
 fSgy7qBwzaz4dWb60W3U+CVujX9W52CaGRO4+lITheIaC06VSGl18I8yyf7h7xnFOkyI
 QBV5ZQYbgxP3bSACJeTtxM7dG7bLIofnPpyrPdmt/ZPnRW4b2epJVb2n+HWpws5FE0OV
 o4PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791985848; x=1792590648;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=24RQVoLsUurrQma53DK6RaZwJpCvuTQH/vyoxxKrEHQ=;
 b=DOqGHBh7G0J0AffU/MIdWMGgHZ1/XY8YCasd1hAMJ1s8LS6DVfe4AHc4ihYN8DeyPq
 jC+htRImIXj+op/Ck1wprj8LyMew4Q7ROhkuFrNkpjj7pUeeTubFWsf8HVBNYExfXzzz
 WmrJEl4JLSHeMuMH7b5qc6GGF/CYHAumkCFkSmBtT/VcAqJZkVTZBWkMkIdeufQi3g8j
 whT1k1nsHA6Twtv5t1lAxXRKWN7ScE5CBV4wFhiFN2HlQ+Pwmby+LwYgtgoizLxmuykr
 PVpkiowmTZqoN+3FlfCWMdqSr0zMoHvME3ZqQ7JiOT+Q5TLvQskxFSoScugoXi4I7uRF
 PWKA==
X-Forwarded-Encrypted: i=1;
 AKwUvByxbXvJ3lUDrxDQb4ruwEpIOw4FOOYuXwq1qQUzzge5mNEiMomcxxyjcbkdmCDIOL08Fb/GdoFZIXg=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIdJIsLFaK0ln4ZyZriRLp9tga3B2BIh1mE18Y4wpRMv0d+QJAS
 id3bK0aeV6iQjsaJuEbLVysrqBE3HX3xIQLlKbbAZKXSlExv10hz19uH
X-Gm-Gg: AYBFou2x66aNE2KXllLVWnr0keAktNarRZ3RMINQjSdQgEGfBU2imMa2VVlnsBNePj8
 VpvX0ioopaFYrjaYdiBlUC5O9Yv8DRaxKzLD7mBhtLXBlswjMUCZDvAPi1IhVCE/Xyp4TRvqSMd
 tu6SRYlVwWhbIhI74Oueihybbr1URuC4iX9Xuq7kMKHsJDsN5UGOWt7CtqsjrU1ibbsOCrYWRBx
 19CtDjk3eZcCJ7Tf+bBbI27oB9GK87rE8VrI5LohDFVqtwmh4JrppqmE3j66qDaS1Kb8YU5vU1p
 NAs35VfyENXYg/h1n8g9elnVZwPN6hieT3OoWNjKbovbRPWrnhRPcCHudOq8yQsPUdhzvohQLJp
 fPybcsmi3NXYQsjJ6fFgXdNcaMVjLaKxVWGo9NlclKWxV7zeHSIugF5fAqy9mhPcE7C3PlGRrGD
 Pps3x3sOMpcT6CRZpx3apW/Ofo2QqwWIIoZSnPZowdFUkvVVaQjGpndEOpxLsrfSCbTDiiRnuMp
 s6tTYMKhMivMHJ54LJ2a0Gw8TEmCKHvoi8At9IhHtuEuvHM8muPXSRZsXi7UP8PRWt/hLaMQt4K
 T5cQVE+VOAEdhB7GVjCmlPhGJsp/g9Q5HmdP6vuWFppKiw==
X-Received: by 2002:a05:6a21:3289:b0:3e1:c2e4:217a with SMTP id
 adf61e73a8af0-3e1c2e434a6mr5231397637.69.1791985847807; 
 Wed, 14 Oct 2026 06:50:47 -0700 (PDT)
Received: from NB150512.ADVANTECH.CORP
 (2001-b011-6c00-3d72-751d-cebe-164a-ae70.dynamic-ip6.hinet.net.
 [2001:b011:6c00:3d72:751d:cebe:164a:ae70])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-89d804e514bsm1168418b3a.41.2026.10.14.06.50.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 06:50:46 -0700 (PDT)
From: Hsieh Hung-En <hungen3108@gmail.com>
To: dianders@chromium.org, neil.armstrong@linaro.org, jesszhan0024@gmail.com
Cc: jagan@amarulasolutions.com, osama.abdelkader@gmail.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, Hsieh Hung-En <hungen3108@gmail.com>
Subject: [PATCH 1/3] drm/panel: feiyang-fy07024di26a30d: Use
 mipi_dsi_*_multi() functions
Date: Wed, 14 Oct 2026 21:50:26 +0800
Message-ID: <20261014135028.1438841-2-hungen3108@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014135028.1438841-1-hungen3108@gmail.com>
References: <20261014135028.1438841-1-hungen3108@gmail.com>
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

Replace the deprecated MIPI DSI DCS helpers with their _multi variants,
as suggested in Documentation/gpu/todo.rst. Also convert
mipi_dsi_dcs_write_buffer() for consistency.

In prepare(), the first failed command prevents subsequent DSI transfers
and its error is returned, as before. The new helper also logs the error.

In unprepare(), clear accum_err between commands so that ENTER_SLEEP_MODE
is still attempted if SET_DISPLAY_OFF fails, preserving the original
error handling behavior.

In disable(), ignore SET_DISPLAY_OFF errors to allow drm_panel_disable()
to clear panel->enabled, avoiding a stale enabled state after the panel
is powered off. This follows commit 00efe8a68565 ("drm/panel:
ronbo-rb070d30: Ignore DCS errors in disable()"). Command failures
remain logged by the helper.

Signed-off-by: Hsieh Hung-En <hungen3108@gmail.com>
---
 .../drm/panel/panel-feiyang-fy07024di26a30d.c | 35 +++++++++++--------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c b/drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c
index c1d8ca5ca6e1..24934b9d430b 100644
--- a/drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c
+++ b/drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c
@@ -46,7 +46,7 @@ static const struct feiyang_init_cmd feiyang_init_cmds[] = {
 static int feiyang_prepare(struct drm_panel *panel)
 {
 	struct feiyang *ctx = panel_to_feiyang(panel);
-	struct mipi_dsi_device *dsi = ctx->dsi;
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
 	unsigned int i;
 	int ret;
 
@@ -81,44 +81,51 @@ static int feiyang_prepare(struct drm_panel *panel)
 		const struct feiyang_init_cmd *cmd =
 						&feiyang_init_cmds[i];
 
-		ret = mipi_dsi_dcs_write_buffer(dsi, cmd->data,
+		mipi_dsi_dcs_write_buffer_multi(&dsi_ctx, cmd->data,
 						FEIYANG_INIT_CMD_LEN);
-		if (ret < 0)
-			return ret;
 	}
 
-	return 0;
+	return dsi_ctx.accum_err;
 }
 
 static int feiyang_enable(struct drm_panel *panel)
 {
 	struct feiyang *ctx = panel_to_feiyang(panel);
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
 
 	/* T12 (video & logic signal rise + backlight rise) T12 >= 200ms */
 	msleep(200);
 
-	return mipi_dsi_dcs_set_display_on(ctx->dsi);
+	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
+
+	return dsi_ctx.accum_err;
 }
 
 static int feiyang_disable(struct drm_panel *panel)
 {
 	struct feiyang *ctx = panel_to_feiyang(panel);
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
 
-	return mipi_dsi_dcs_set_display_off(ctx->dsi);
+	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
+
+	/*
+	 * Returning an error would leave panel->enabled set, causing the
+	 * next enable to be skipped even after unprepare powers off the panel.
+	 * The helper above already logs any command failure.
+	 */
+	return 0;
 }
 
 static int feiyang_unprepare(struct drm_panel *panel)
 {
 	struct feiyang *ctx = panel_to_feiyang(panel);
-	int ret;
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
 
-	ret = mipi_dsi_dcs_set_display_off(ctx->dsi);
-	if (ret < 0)
-		dev_err(panel->dev, "failed to set display off: %d\n", ret);
+	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
 
-	ret = mipi_dsi_dcs_enter_sleep_mode(ctx->dsi);
-	if (ret < 0)
-		dev_err(panel->dev, "failed to enter sleep mode: %d\n", ret);
+	/* Attempt to enter sleep mode even if display off failed. */
+	dsi_ctx.accum_err = 0;
+	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
 
 	/* T13 (backlight fall + video & logic signal fall) T13 >= 200ms */
 	msleep(200);
-- 
2.43.0

