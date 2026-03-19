Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D71D1090242
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 16:02:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F61810E90B;
	Thu, 19 Mar 2026 16:02:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="rM+eXuna";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NI4auW10";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rM+eXuna";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NI4auW10";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 554EB10E90A
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 16:01:50 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0721D5BD7D;
 Thu, 19 Mar 2026 16:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773936082; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eGXzAtOACK+//BMXr9d4SGvzE3NX1a5WQb0Cx9SSKno=;
 b=rM+eXunaLt635NnKMvfttJCLV+GCOjPfMeYyD2D1rXmONMxKa3W1Yx8ps8ROVB9gEh79yd
 2fFr6/8ew5bgY4hkR8Cp2EFv0d3nq+6ZSDVdJuznL4CsYT2KS4rX2FH2pnJKnESnq4O/yQ
 Z3Mx+4x+QXX68Y40rbO9xJYeR4Supm8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773936082;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eGXzAtOACK+//BMXr9d4SGvzE3NX1a5WQb0Cx9SSKno=;
 b=NI4auW10Mg96loFnna3AdFzk/ndmjDLEjIsKL9258ASbhUijQAFhdwmhtoZXdftmNOEGzK
 8eGzIPsxSniVHACw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=rM+eXuna;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=NI4auW10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773936082; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eGXzAtOACK+//BMXr9d4SGvzE3NX1a5WQb0Cx9SSKno=;
 b=rM+eXunaLt635NnKMvfttJCLV+GCOjPfMeYyD2D1rXmONMxKa3W1Yx8ps8ROVB9gEh79yd
 2fFr6/8ew5bgY4hkR8Cp2EFv0d3nq+6ZSDVdJuznL4CsYT2KS4rX2FH2pnJKnESnq4O/yQ
 Z3Mx+4x+QXX68Y40rbO9xJYeR4Supm8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773936082;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eGXzAtOACK+//BMXr9d4SGvzE3NX1a5WQb0Cx9SSKno=;
 b=NI4auW10Mg96loFnna3AdFzk/ndmjDLEjIsKL9258ASbhUijQAFhdwmhtoZXdftmNOEGzK
 8eGzIPsxSniVHACw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2F32142759;
 Thu, 19 Mar 2026 16:01:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +AZHCs4dvGn0WQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Thu, 19 Mar 2026 16:01:18 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: david@lechnology.com, javierm@redhat.com, lanzano.alex@gmail.com,
 kamlesh.gurudasani@gmail.com, architanant5@gmail.com, wens@kernel.org,
 mripard@kernel.org, maarten.lankhorst@linux.intel.com, simona@ffwll.ch,
 airlied@gmail.com
Cc: dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v3 11/16] drm/st7586: Use regular atomic helpers;
 drop simple-display helpers
Date: Thu, 19 Mar 2026 16:59:47 +0100
Message-ID: <20260319160110.109610-12-tzimmermann@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260319160110.109610-1-tzimmermann@suse.de>
References: <20260319160110.109610-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCPT_COUNT_TWELVE(0.00)[12];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+];
 FREEMAIL_TO(0.00)[lechnology.com,redhat.com,gmail.com,kernel.org,linux.intel.com,ffwll.ch];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 TAGGED_RCPT(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 R_RATELIMIT(0.00)[to_ip_from(RLqtkr6cif1ebgurukgmwdm7xc)];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Queue-Id: 0721D5BD7D
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

Replace simple-display helpers with regular atomic helpers. Store the
pipeline elements in struct st7586_device and initialize them as part
of probing the device. Use mipi-dbi's existing helpers and initializer
macros where possible.

Effectively open-codes the modesetting code in the initializer helpers
of mipi-dbi and simple-display. St7586 requires custom helpers for
various pipeline elements, and non-freeing cleanup of the pipeline.

v3:
- return early in st7586_plane_helper_atomic_update (David)
v2:
- fix connector initialization

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Acked-by: David Lechner <david@lechnology.com>
Tested-by: David Lechner <david@lechnology.com>
---
 drivers/gpu/drm/sitronix/st7586.c | 174 ++++++++++++++++++++++++------
 1 file changed, 139 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/sitronix/st7586.c b/drivers/gpu/drm/sitronix/st7586.c
index b6f38e03e1e5..fa58b3d83564 100644
--- a/drivers/gpu/drm/sitronix/st7586.c
+++ b/drivers/gpu/drm/sitronix/st7586.c
@@ -13,6 +13,7 @@
 #include <video/mipi_display.h>
 
 #include <drm/clients/drm_client_setup.h>
+#include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_damage_helper.h>
 #include <drm/drm_drv.h>
@@ -48,6 +49,20 @@
 #define ST7586_DISP_CTRL_MX	BIT(6)
 #define ST7586_DISP_CTRL_MY	BIT(7)
 
+struct st7586_device {
+	struct mipi_dbi_dev dbidev;
+
+	struct drm_plane plane;
+	struct drm_crtc crtc;
+	struct drm_encoder encoder;
+	struct drm_connector connector;
+};
+
+static struct st7586_device *to_st7586_device(struct drm_device *dev)
+{
+	return container_of(drm_to_mipi_dbi_dev(dev), struct st7586_device, dbidev);
+}
+
 /*
  * The ST7586 controller has an unusual pixel format where 2bpp grayscale is
  * packed 3 pixels per byte with the first two pixels using 3 bits and the 3rd
@@ -147,38 +162,59 @@ static void st7586_fb_dirty(struct iosys_map *src, struct drm_framebuffer *fb,
 		dev_err_once(fb->dev->dev, "Failed to update display %d\n", ret);
 }
 
-static void st7586_pipe_update(struct drm_simple_display_pipe *pipe,
-			       struct drm_plane_state *old_state)
+static const u32 st7586_plane_formats[] = {
+	DRM_FORMAT_XRGB8888,
+};
+
+static const u64 st7586_plane_format_modifiers[] = {
+	DRM_MIPI_DBI_PLANE_FORMAT_MODIFIERS,
+};
+
+static void st7586_plane_helper_atomic_update(struct drm_plane *plane,
+					      struct drm_atomic_state *state)
 {
-	struct drm_plane_state *state = pipe->plane.state;
-	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(state);
-	struct drm_framebuffer *fb = state->fb;
+	struct drm_plane_state *plane_state = plane->state;
+	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(plane_state);
+	struct drm_framebuffer *fb = plane_state->fb;
+	struct drm_plane_state *old_plane_state = drm_atomic_get_old_plane_state(state, plane);
 	struct drm_rect rect;
 	int idx;
 
-	if (!pipe->crtc.state->active)
+	if (!fb)
 		return;
 
-	if (!drm_dev_enter(fb->dev, &idx))
+	if (!drm_dev_enter(plane->dev, &idx))
 		return;
 
-	if (drm_atomic_helper_damage_merged(old_state, state, &rect))
+	if (drm_atomic_helper_damage_merged(old_plane_state, plane_state, &rect))
 		st7586_fb_dirty(&shadow_plane_state->data[0], fb, &rect,
 				&shadow_plane_state->fmtcnv_state);
 
 	drm_dev_exit(idx);
 }
 
-static void st7586_pipe_enable(struct drm_simple_display_pipe *pipe,
-			       struct drm_crtc_state *crtc_state,
-			       struct drm_plane_state *plane_state)
+static const struct drm_plane_helper_funcs st7586_plane_helper_funcs = {
+	DRM_GEM_SHADOW_PLANE_HELPER_FUNCS,
+	.atomic_check = drm_mipi_dbi_plane_helper_atomic_check,
+	.atomic_update = st7586_plane_helper_atomic_update
+};
+
+static const struct drm_plane_funcs st7586_plane_funcs = {
+	DRM_MIPI_DBI_PLANE_FUNCS,
+	.destroy = drm_plane_cleanup,
+};
+
+static void st7586_crtc_helper_atomic_enable(struct drm_crtc *crtc,
+					     struct drm_atomic_state *state)
 {
-	struct mipi_dbi_dev *dbidev = drm_to_mipi_dbi_dev(pipe->crtc.dev);
+	struct drm_device *drm = crtc->dev;
+	struct st7586_device *st7586 = to_st7586_device(drm);
+	struct mipi_dbi_dev *dbidev = &st7586->dbidev;
 	struct mipi_dbi *dbi = &dbidev->dbi;
 	int idx, ret;
 	u8 addr_mode;
 
-	if (!drm_dev_enter(pipe->crtc.dev, &idx))
+	if (!drm_dev_enter(drm, &idx))
 		return;
 
 	DRM_DEBUG_KMS("\n");
@@ -239,9 +275,12 @@ static void st7586_pipe_enable(struct drm_simple_display_pipe *pipe,
 	drm_dev_exit(idx);
 }
 
-static void st7586_pipe_disable(struct drm_simple_display_pipe *pipe)
+static void st7586_crtc_helper_atomic_disable(struct drm_crtc *crtc,
+					      struct drm_atomic_state *state)
 {
-	struct mipi_dbi_dev *dbidev = drm_to_mipi_dbi_dev(pipe->crtc.dev);
+	struct drm_device *drm = crtc->dev;
+	struct st7586_device *st7586 = to_st7586_device(drm);
+	struct mipi_dbi_dev *dbidev = &st7586->dbidev;
 
 	/*
 	 * This callback is not protected by drm_dev_enter/exit since we want to
@@ -255,20 +294,37 @@ static void st7586_pipe_disable(struct drm_simple_display_pipe *pipe)
 	mipi_dbi_command(&dbidev->dbi, MIPI_DCS_SET_DISPLAY_OFF);
 }
 
-static const u32 st7586_formats[] = {
-	DRM_FORMAT_XRGB8888,
+static const struct drm_crtc_helper_funcs st7586_crtc_helper_funcs = {
+	.mode_valid = drm_mipi_dbi_crtc_helper_mode_valid,
+	.atomic_check = drm_mipi_dbi_crtc_helper_atomic_check,
+	.atomic_enable = st7586_crtc_helper_atomic_enable,
+	.atomic_disable = st7586_crtc_helper_atomic_disable,
+};
+
+static const struct drm_crtc_funcs st7586_crtc_funcs = {
+	DRM_MIPI_DBI_CRTC_FUNCS,
+	.destroy = drm_crtc_cleanup,
 };
 
-static const struct drm_simple_display_pipe_funcs st7586_pipe_funcs = {
-	.mode_valid	= mipi_dbi_pipe_mode_valid,
-	.enable		= st7586_pipe_enable,
-	.disable	= st7586_pipe_disable,
-	.update		= st7586_pipe_update,
-	.begin_fb_access = mipi_dbi_pipe_begin_fb_access,
-	.end_fb_access	= mipi_dbi_pipe_end_fb_access,
-	.reset_plane	= mipi_dbi_pipe_reset_plane,
-	.duplicate_plane_state = mipi_dbi_pipe_duplicate_plane_state,
-	.destroy_plane_state = mipi_dbi_pipe_destroy_plane_state,
+static const struct drm_encoder_funcs st7586_encoder_funcs = {
+	.destroy = drm_encoder_cleanup,
+};
+
+static const struct drm_connector_helper_funcs st7586_connector_helper_funcs = {
+	DRM_MIPI_DBI_CONNECTOR_HELPER_FUNCS,
+};
+
+static const struct drm_connector_funcs st7586_connector_funcs = {
+	DRM_MIPI_DBI_CONNECTOR_FUNCS,
+	.destroy = drm_connector_cleanup,
+};
+
+static const struct drm_mode_config_helper_funcs st7586_mode_config_helper_funcs = {
+	DRM_MIPI_DBI_MODE_CONFIG_HELPER_FUNCS,
+};
+
+static const struct drm_mode_config_funcs st7586_mode_config_funcs = {
+	DRM_MIPI_DBI_MODE_CONFIG_FUNCS,
 };
 
 static const struct drm_display_mode st7586_mode = {
@@ -304,19 +360,23 @@ MODULE_DEVICE_TABLE(spi, st7586_id);
 static int st7586_probe(struct spi_device *spi)
 {
 	struct device *dev = &spi->dev;
+	struct st7586_device *st7586;
 	struct mipi_dbi_dev *dbidev;
 	struct drm_device *drm;
 	struct mipi_dbi *dbi;
 	struct gpio_desc *a0;
+	struct drm_plane *plane;
+	struct drm_crtc *crtc;
+	struct drm_encoder *encoder;
+	struct drm_connector *connector;
 	u32 rotation = 0;
 	size_t bufsize;
 	int ret;
 
-	dbidev = devm_drm_dev_alloc(dev, &st7586_driver,
-				    struct mipi_dbi_dev, drm);
-	if (IS_ERR(dbidev))
-		return PTR_ERR(dbidev);
-
+	st7586 = devm_drm_dev_alloc(dev, &st7586_driver, struct st7586_device, dbidev.drm);
+	if (IS_ERR(st7586))
+		return PTR_ERR(st7586);
+	dbidev = &st7586->dbidev;
 	dbi = &dbidev->dbi;
 	drm = &dbidev->drm;
 
@@ -345,9 +405,53 @@ static int st7586_probe(struct spi_device *spi)
 	/* Cannot read from this controller via SPI */
 	dbi->read_commands = NULL;
 
-	ret = mipi_dbi_dev_init_with_formats(dbidev, &st7586_pipe_funcs,
-					     st7586_formats, ARRAY_SIZE(st7586_formats),
-					     &st7586_mode, rotation, bufsize);
+	ret = drm_mipi_dbi_dev_init(dbidev, &st7586_mode, st7586_plane_formats[0],
+				    rotation, bufsize);
+	if (ret)
+		return ret;
+
+	ret = drmm_mode_config_init(drm);
+	if (ret)
+		return ret;
+
+	drm->mode_config.min_width = dbidev->mode.hdisplay;
+	drm->mode_config.max_width = dbidev->mode.hdisplay;
+	drm->mode_config.min_height = dbidev->mode.vdisplay;
+	drm->mode_config.max_height = dbidev->mode.vdisplay;
+	drm->mode_config.funcs = &st7586_mode_config_funcs;
+	drm->mode_config.preferred_depth = 24;
+	drm->mode_config.helper_private = &st7586_mode_config_helper_funcs;
+
+	plane = &st7586->plane;
+	ret = drm_universal_plane_init(drm, plane, 0, &st7586_plane_funcs,
+				       st7586_plane_formats, ARRAY_SIZE(st7586_plane_formats),
+				       st7586_plane_format_modifiers,
+				       DRM_PLANE_TYPE_PRIMARY, NULL);
+	if (ret)
+		return ret;
+	drm_plane_helper_add(plane, &st7586_plane_helper_funcs);
+	drm_plane_enable_fb_damage_clips(plane);
+
+	crtc = &st7586->crtc;
+	ret = drm_crtc_init_with_planes(drm, crtc, plane, NULL, &st7586_crtc_funcs, NULL);
+	if (ret)
+		return ret;
+	drm_crtc_helper_add(crtc, &st7586_crtc_helper_funcs);
+
+	encoder = &st7586->encoder;
+	ret = drm_encoder_init(drm, encoder, &st7586_encoder_funcs, DRM_MODE_ENCODER_NONE, NULL);
+	if (ret)
+		return ret;
+	encoder->possible_crtcs = drm_crtc_mask(crtc);
+
+	connector = &st7586->connector;
+	ret = drm_connector_init(drm, connector, &st7586_connector_funcs,
+				 DRM_MODE_CONNECTOR_SPI);
+	if (ret)
+		return ret;
+	drm_connector_helper_add(connector, &st7586_connector_helper_funcs);
+
+	ret = drm_connector_attach_encoder(connector, encoder);
 	if (ret)
 		return ret;
 
-- 
2.53.0

