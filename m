Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 216111090249
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 16:01:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E847610E8F6;
	Thu, 19 Mar 2026 16:01:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="hb2C0v0S";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4Z8ZGSRz";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="htPRk+HO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fy0jLREP";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6A6710E8EB
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 16:01:27 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 00BDE5BD49;
 Thu, 19 Mar 2026 16:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773936080; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7yWCp48lJFfvOvJEfpPVjZqk+le9ajJsEajlCCx8tsQ=;
 b=hb2C0v0S+LGXJiCfUFrQxvIKSzzwdGMHHuuuY0DfdljC47YPruq8wQ73aWtDDR2Lo1b/9Y
 ulH252jel7mzCfIvMtdNVxeP/9in7E5XcULJOI22Cj4ySw9F/WMqw+AMmTCQDPBxiObFyN
 QvKuQOG1CnwcGW7TFMwhvOfvTimBtRQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773936080;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7yWCp48lJFfvOvJEfpPVjZqk+le9ajJsEajlCCx8tsQ=;
 b=4Z8ZGSRzatUjJtcEvMPPOBwNFFGUTd+CD00Ncivtulerg4T3wqYEs7hY264ZGfAAuOKh8x
 6rQiFqc3y5V9N4Cw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=htPRk+HO;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=fy0jLREP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773936075; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7yWCp48lJFfvOvJEfpPVjZqk+le9ajJsEajlCCx8tsQ=;
 b=htPRk+HOdoImiceFkPDEpm09fJFGa7B1hKhkxWE2oudyTEL7yLmtSd5fXaTYMhNjE8x7Ro
 iRgLkjdaJdNrlZhhPNrjcYZ3/zQ7L4H36U/rXkwXd4imwp99CpC2lxZCXVlAWs2cicnCs8
 JvAXGItepGQuEyD7o+MBG/LsamR+iUI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773936075;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7yWCp48lJFfvOvJEfpPVjZqk+le9ajJsEajlCCx8tsQ=;
 b=fy0jLREPCtxmZXoQQvQQc1qvlzBN/Iw25gW0nICljGsjWQzTZBHEoyqbVklRAi9cjMXa/D
 8bpUylicXPDxHrAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A52794273C;
 Thu, 19 Mar 2026 16:01:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wPcgJ8odvGn0WQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Thu, 19 Mar 2026 16:01:14 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: david@lechnology.com, javierm@redhat.com, lanzano.alex@gmail.com,
 kamlesh.gurudasani@gmail.com, architanant5@gmail.com, wens@kernel.org,
 mripard@kernel.org, maarten.lankhorst@linux.intel.com, simona@ffwll.ch,
 airlied@gmail.com
Cc: dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v3 01/16] drm/mipi-dbi: Only modify planes on enabled CRTCs
Date: Thu, 19 Mar 2026 16:59:37 +0100
Message-ID: <20260319160110.109610-2-tzimmermann@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260319160110.109610-1-tzimmermann@suse.de>
References: <20260319160110.109610-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCPT_COUNT_TWELVE(0.00)[12];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_TO(0.00)[lechnology.com,redhat.com,gmail.com,kernel.org,linux.intel.com,ffwll.ch];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim,suse.de:email];
 TAGGED_RCPT(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 R_RATELIMIT(0.00)[to_ip_from(RLqtkr6cif1ebgurukgmwdm7xc)];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 00BDE5BD49
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

Use drm_atomic_helper_commit_tail_rpm() as commit tail to update the
plane after enabling the CRTC. Then remove the plane-update code from
mipi_dbi_enable_flush() and inline the remaining backlight code where
necessary.

Mipi-dbi's current commit tail drm_atomic_helper_commit_tail() first
updates the plane and then enables the CRTC. But the CRTC enablement
includes power management that prevents the initial plane update from
working. Hence, each mipi-dbi driver includes a plane update in their
CRTC enablement; in the form of mipi_dbi_enable_flush() or custom code.

Using drm_atomic_helper_commit_tail_rpm() enables the CRTC before any
plane updates. Hence the additional plane update can be removed from
mipi_dbi_enable_flush() and a number of drivers.

This leaves backlight_enable() in the helper, which can now be inlined
into affected drivers. Drivers now enable the CRTC plus an optional
backlight and then automatically update the plane.

In the case of disabling the display, drm_atomic_helper_commit_tail_rpm()
only disables the CRTC without touching the plane at all. Mipi-dbi's
mipi_dbi_pipe_disable() already contains the necessary logic.

Removing the plane update from the CRTC enablement will also help with
converting mipi-dbi from simple-pipe helpers to regular atomic helpers.

v3:
- st7586: remove unused variable
v2:
- ili9225: remove unused variables (David)
- st7586: remove unused variables (David)

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Acked-by: David Lechner <david@lechnology.com>
---
 drivers/gpu/drm/drm_mipi_dbi.c        | 44 ++++-----------------------
 drivers/gpu/drm/sitronix/st7586.c     | 11 -------
 drivers/gpu/drm/sitronix/st7735r.c    |  2 +-
 drivers/gpu/drm/tiny/hx8357d.c        |  3 +-
 drivers/gpu/drm/tiny/ili9163.c        |  3 +-
 drivers/gpu/drm/tiny/ili9225.c        | 11 -------
 drivers/gpu/drm/tiny/ili9341.c        |  3 +-
 drivers/gpu/drm/tiny/ili9486.c        |  3 +-
 drivers/gpu/drm/tiny/mi0283qt.c       |  3 +-
 drivers/gpu/drm/tiny/panel-mipi-dbi.c |  2 +-
 include/drm/drm_mipi_dbi.h            |  3 --
 11 files changed, 18 insertions(+), 70 deletions(-)

diff --git a/drivers/gpu/drm/drm_mipi_dbi.c b/drivers/gpu/drm/drm_mipi_dbi.c
index 00482227a9cd..bb6cebc583be 100644
--- a/drivers/gpu/drm/drm_mipi_dbi.c
+++ b/drivers/gpu/drm/drm_mipi_dbi.c
@@ -368,44 +368,6 @@ void mipi_dbi_pipe_update(struct drm_simple_display_pipe *pipe,
 }
 EXPORT_SYMBOL(mipi_dbi_pipe_update);
 
-/**
- * mipi_dbi_enable_flush - MIPI DBI enable helper
- * @dbidev: MIPI DBI device structure
- * @crtc_state: CRTC state
- * @plane_state: Plane state
- *
- * Flushes the whole framebuffer and enables the backlight. Drivers can use this
- * in their &drm_simple_display_pipe_funcs->enable callback.
- *
- * Note: Drivers which don't use mipi_dbi_pipe_update() because they have custom
- * framebuffer flushing, can't use this function since they both use the same
- * flushing code.
- */
-void mipi_dbi_enable_flush(struct mipi_dbi_dev *dbidev,
-			   struct drm_crtc_state *crtc_state,
-			   struct drm_plane_state *plane_state)
-{
-	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(plane_state);
-	struct drm_framebuffer *fb = plane_state->fb;
-	struct drm_rect rect = {
-		.x1 = 0,
-		.x2 = fb->width,
-		.y1 = 0,
-		.y2 = fb->height,
-	};
-	int idx;
-
-	if (!drm_dev_enter(&dbidev->drm, &idx))
-		return;
-
-	mipi_dbi_fb_dirty(&shadow_plane_state->data[0], fb, &rect,
-			  &shadow_plane_state->fmtcnv_state);
-	backlight_enable(dbidev->backlight);
-
-	drm_dev_exit(idx);
-}
-EXPORT_SYMBOL(mipi_dbi_enable_flush);
-
 static void mipi_dbi_blank(struct mipi_dbi_dev *dbidev)
 {
 	struct drm_device *drm = &dbidev->drm;
@@ -577,6 +539,10 @@ static int mipi_dbi_rotate_mode(struct drm_display_mode *mode,
 	}
 }
 
+static const struct drm_mode_config_helper_funcs mipi_dbi_mode_config_helper_funcs = {
+	.atomic_commit_tail = drm_atomic_helper_commit_tail_rpm,
+};
+
 static const struct drm_mode_config_funcs mipi_dbi_mode_config_funcs = {
 	.fb_create = drm_gem_fb_create_with_dirty,
 	.atomic_check = drm_atomic_helper_check,
@@ -660,6 +626,8 @@ int mipi_dbi_dev_init_with_formats(struct mipi_dbi_dev *dbidev,
 	drm->mode_config.max_width = dbidev->mode.hdisplay;
 	drm->mode_config.min_height = dbidev->mode.vdisplay;
 	drm->mode_config.max_height = dbidev->mode.vdisplay;
+	drm->mode_config.helper_private = &mipi_dbi_mode_config_helper_funcs;
+
 	dbidev->rotation = rotation;
 	dbidev->pixel_format = formats[0];
 	if (formats[0] == DRM_FORMAT_RGB888)
diff --git a/drivers/gpu/drm/sitronix/st7586.c b/drivers/gpu/drm/sitronix/st7586.c
index 16b6b4e368af..b6f38e03e1e5 100644
--- a/drivers/gpu/drm/sitronix/st7586.c
+++ b/drivers/gpu/drm/sitronix/st7586.c
@@ -174,15 +174,7 @@ static void st7586_pipe_enable(struct drm_simple_display_pipe *pipe,
 			       struct drm_plane_state *plane_state)
 {
 	struct mipi_dbi_dev *dbidev = drm_to_mipi_dbi_dev(pipe->crtc.dev);
-	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(plane_state);
-	struct drm_framebuffer *fb = plane_state->fb;
 	struct mipi_dbi *dbi = &dbidev->dbi;
-	struct drm_rect rect = {
-		.x1 = 0,
-		.x2 = fb->width,
-		.y1 = 0,
-		.y2 = fb->height,
-	};
 	int idx, ret;
 	u8 addr_mode;
 
@@ -242,9 +234,6 @@ static void st7586_pipe_enable(struct drm_simple_display_pipe *pipe,
 
 	msleep(100);
 
-	st7586_fb_dirty(&shadow_plane_state->data[0], fb, &rect,
-			&shadow_plane_state->fmtcnv_state);
-
 	mipi_dbi_command(dbi, MIPI_DCS_SET_DISPLAY_ON);
 out_exit:
 	drm_dev_exit(idx);
diff --git a/drivers/gpu/drm/sitronix/st7735r.c b/drivers/gpu/drm/sitronix/st7735r.c
index c1f8228495f6..1a34c7ba460b 100644
--- a/drivers/gpu/drm/sitronix/st7735r.c
+++ b/drivers/gpu/drm/sitronix/st7735r.c
@@ -129,7 +129,7 @@ static void st7735r_pipe_enable(struct drm_simple_display_pipe *pipe,
 
 	msleep(20);
 
-	mipi_dbi_enable_flush(dbidev, crtc_state, plane_state);
+	backlight_enable(dbidev->backlight);
 out_exit:
 	drm_dev_exit(idx);
 }
diff --git a/drivers/gpu/drm/tiny/hx8357d.c b/drivers/gpu/drm/tiny/hx8357d.c
index 9f26aaca0bfa..5115be8854bb 100644
--- a/drivers/gpu/drm/tiny/hx8357d.c
+++ b/drivers/gpu/drm/tiny/hx8357d.c
@@ -177,7 +177,8 @@ static void yx240qv29_enable(struct drm_simple_display_pipe *pipe,
 		break;
 	}
 	mipi_dbi_command(dbi, MIPI_DCS_SET_ADDRESS_MODE, addr_mode);
-	mipi_dbi_enable_flush(dbidev, crtc_state, plane_state);
+
+	backlight_enable(dbidev->backlight);
 out_exit:
 	drm_dev_exit(idx);
 }
diff --git a/drivers/gpu/drm/tiny/ili9163.c b/drivers/gpu/drm/tiny/ili9163.c
index 7c154c008344..c616f56af5b5 100644
--- a/drivers/gpu/drm/tiny/ili9163.c
+++ b/drivers/gpu/drm/tiny/ili9163.c
@@ -96,7 +96,8 @@ static void yx240qv29_enable(struct drm_simple_display_pipe *pipe,
 	}
 	addr_mode |= ILI9163_MADCTL_BGR;
 	mipi_dbi_command(dbi, MIPI_DCS_SET_ADDRESS_MODE, addr_mode);
-	mipi_dbi_enable_flush(dbidev, crtc_state, plane_state);
+
+	backlight_enable(dbidev->backlight);
 out_exit:
 	drm_dev_exit(idx);
 }
diff --git a/drivers/gpu/drm/tiny/ili9225.c b/drivers/gpu/drm/tiny/ili9225.c
index d32538b1eb09..3eaf6b3a055a 100644
--- a/drivers/gpu/drm/tiny/ili9225.c
+++ b/drivers/gpu/drm/tiny/ili9225.c
@@ -184,16 +184,8 @@ static void ili9225_pipe_enable(struct drm_simple_display_pipe *pipe,
 				struct drm_plane_state *plane_state)
 {
 	struct mipi_dbi_dev *dbidev = drm_to_mipi_dbi_dev(pipe->crtc.dev);
-	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(plane_state);
-	struct drm_framebuffer *fb = plane_state->fb;
 	struct device *dev = pipe->crtc.dev->dev;
 	struct mipi_dbi *dbi = &dbidev->dbi;
-	struct drm_rect rect = {
-		.x1 = 0,
-		.x2 = fb->width,
-		.y1 = 0,
-		.y2 = fb->height,
-	};
 	int ret, idx;
 	u8 am_id;
 
@@ -284,9 +276,6 @@ static void ili9225_pipe_enable(struct drm_simple_display_pipe *pipe,
 
 	ili9225_command(dbi, ILI9225_DISPLAY_CONTROL_1, 0x1017);
 
-	ili9225_fb_dirty(&shadow_plane_state->data[0], fb, &rect,
-			 &shadow_plane_state->fmtcnv_state);
-
 out_exit:
 	drm_dev_exit(idx);
 }
diff --git a/drivers/gpu/drm/tiny/ili9341.c b/drivers/gpu/drm/tiny/ili9341.c
index 2ab750cba505..972811564d6a 100644
--- a/drivers/gpu/drm/tiny/ili9341.c
+++ b/drivers/gpu/drm/tiny/ili9341.c
@@ -133,7 +133,8 @@ static void yx240qv29_enable(struct drm_simple_display_pipe *pipe,
 	}
 	addr_mode |= ILI9341_MADCTL_BGR;
 	mipi_dbi_command(dbi, MIPI_DCS_SET_ADDRESS_MODE, addr_mode);
-	mipi_dbi_enable_flush(dbidev, crtc_state, plane_state);
+
+	backlight_enable(dbidev->backlight);
 out_exit:
 	drm_dev_exit(idx);
 }
diff --git a/drivers/gpu/drm/tiny/ili9486.c b/drivers/gpu/drm/tiny/ili9486.c
index 1e411a0f4567..52b14f2cb0e1 100644
--- a/drivers/gpu/drm/tiny/ili9486.c
+++ b/drivers/gpu/drm/tiny/ili9486.c
@@ -155,7 +155,8 @@ static void waveshare_enable(struct drm_simple_display_pipe *pipe,
 	}
 	addr_mode |= ILI9486_MADCTL_BGR;
 	mipi_dbi_command(dbi, MIPI_DCS_SET_ADDRESS_MODE, addr_mode);
-	mipi_dbi_enable_flush(dbidev, crtc_state, plane_state);
+
+	backlight_enable(dbidev->backlight);
  out_exit:
 	drm_dev_exit(idx);
 }
diff --git a/drivers/gpu/drm/tiny/mi0283qt.c b/drivers/gpu/drm/tiny/mi0283qt.c
index a063eff77624..f121e1a8a303 100644
--- a/drivers/gpu/drm/tiny/mi0283qt.c
+++ b/drivers/gpu/drm/tiny/mi0283qt.c
@@ -137,7 +137,8 @@ static void mi0283qt_enable(struct drm_simple_display_pipe *pipe,
 	}
 	addr_mode |= ILI9341_MADCTL_BGR;
 	mipi_dbi_command(dbi, MIPI_DCS_SET_ADDRESS_MODE, addr_mode);
-	mipi_dbi_enable_flush(dbidev, crtc_state, plane_state);
+
+	backlight_enable(dbidev->backlight);
 out_exit:
 	drm_dev_exit(idx);
 }
diff --git a/drivers/gpu/drm/tiny/panel-mipi-dbi.c b/drivers/gpu/drm/tiny/panel-mipi-dbi.c
index 82dfa169f762..4907945ab507 100644
--- a/drivers/gpu/drm/tiny/panel-mipi-dbi.c
+++ b/drivers/gpu/drm/tiny/panel-mipi-dbi.c
@@ -252,7 +252,7 @@ static void panel_mipi_dbi_enable(struct drm_simple_display_pipe *pipe,
 	if (!ret)
 		panel_mipi_dbi_commands_execute(dbi, dbidev->driver_private);
 
-	mipi_dbi_enable_flush(dbidev, crtc_state, plane_state);
+	backlight_enable(dbidev->backlight);
 out_exit:
 	drm_dev_exit(idx);
 }
diff --git a/include/drm/drm_mipi_dbi.h b/include/drm/drm_mipi_dbi.h
index f45f9612c0bc..637be84d3d5a 100644
--- a/include/drm/drm_mipi_dbi.h
+++ b/include/drm/drm_mipi_dbi.h
@@ -176,9 +176,6 @@ enum drm_mode_status mipi_dbi_pipe_mode_valid(struct drm_simple_display_pipe *pi
 					      const struct drm_display_mode *mode);
 void mipi_dbi_pipe_update(struct drm_simple_display_pipe *pipe,
 			  struct drm_plane_state *old_state);
-void mipi_dbi_enable_flush(struct mipi_dbi_dev *dbidev,
-			   struct drm_crtc_state *crtc_state,
-			   struct drm_plane_state *plan_state);
 void mipi_dbi_pipe_disable(struct drm_simple_display_pipe *pipe);
 int mipi_dbi_pipe_begin_fb_access(struct drm_simple_display_pipe *pipe,
 				  struct drm_plane_state *plane_state);
-- 
2.53.0

