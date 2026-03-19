Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED4F61090242
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 16:01:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 748E910E901;
	Thu, 19 Mar 2026 16:01:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="lnAGdi0E";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fDxZADh8";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="10m7U+ZE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5/9jNnop";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 332B210E8F9
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 16:01:40 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EB9B24D2CC;
 Thu, 19 Mar 2026 16:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773936082; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B8amLfmabmTYXqbh4Yf6hp/RRg8dLvOWOACB6unR7W4=;
 b=lnAGdi0EyJGqEL4k+7CIzwsdEF47t5/UiMFq0gAPFFiEvDk6CUp9kbsw9OMR0rJguAPyKH
 vz5JzxYsNcPRCmcXubm9Id8huM04k64TWEZkFgGHLmshIGi/TVsrnPWzSjfu55DjPbCVh8
 x1po7qWCbhxJdkclzGKBgT6Lbh8NI1A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773936082;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B8amLfmabmTYXqbh4Yf6hp/RRg8dLvOWOACB6unR7W4=;
 b=fDxZADh8O0FlLPv863nM7Q9c0FKUB+xFAMzk1pF/+p8jZRhcncOUzEmCMOMMa6oIc3UUkO
 ZyMZYuQcXJmC90Dg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773936081; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B8amLfmabmTYXqbh4Yf6hp/RRg8dLvOWOACB6unR7W4=;
 b=10m7U+ZEiUFhVAPBP/obiOrF9mzpe8nqYreK6bxBndGQtM9lXdV18ynF8iYIn1rn8vspfF
 ckpAb/pO+icET58Z/thprceYO1zbRhaWkcUSMAKBd2ezCiP1EHVRJ9l4zWU8vcyNMJZi6v
 9WhaYBKnthbQ2DUmUotBVSvSBeoOt8w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773936081;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B8amLfmabmTYXqbh4Yf6hp/RRg8dLvOWOACB6unR7W4=;
 b=5/9jNnopeSbhanvav7BkV7tJtl3eA6Uxc3b/FQGBXQcG4HsUJQLiZYGxy+CGMhRzp3WKhT
 jwfvlpKIMoQBoODg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CE34442758;
 Thu, 19 Mar 2026 16:01:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oI4nMc0dvGn0WQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Thu, 19 Mar 2026 16:01:17 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: david@lechnology.com, javierm@redhat.com, lanzano.alex@gmail.com,
 kamlesh.gurudasani@gmail.com, architanant5@gmail.com, wens@kernel.org,
 mripard@kernel.org, maarten.lankhorst@linux.intel.com, simona@ffwll.ch,
 airlied@gmail.com
Cc: dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v3 10/16] drm/panel-mipi-dbi: Use regular atomic helpers;
 drop simple-display helpers
Date: Thu, 19 Mar 2026 16:59:46 +0100
Message-ID: <20260319160110.109610-11-tzimmermann@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260319160110.109610-1-tzimmermann@suse.de>
References: <20260319160110.109610-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_CONTAINS_FROM(1.00)[]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[12]; MIME_TRACE(0.00)[0:+];
 TAGGED_RCPT(0.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_TO(0.00)[lechnology.com,redhat.com,gmail.com,kernel.org,linux.intel.com,ffwll.ch];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]
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
pipeline elements in struct panel_mipi_dbi_device and initialize them as
part of probing the device. Use mipi-dbi's existing helpers and initializer
macros where possible.

Effectively open-codes the modesetting code in the initializer helpers
of mipi-dbi and simple-display. Panel-mipi-dbi requires a custom helper
for CRTC enablement, and non-freeing cleanup of the pipeline.

v2:
- fix connector initialization

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Acked-by: David Lechner <david@lechnology.com>
Tested-by: David Lechner <david@lechnology.com>
---
 drivers/gpu/drm/tiny/panel-mipi-dbi.c | 139 +++++++++++++++++++++++---
 1 file changed, 123 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/tiny/panel-mipi-dbi.c b/drivers/gpu/drm/tiny/panel-mipi-dbi.c
index 4907945ab507..581e14528608 100644
--- a/drivers/gpu/drm/tiny/panel-mipi-dbi.c
+++ b/drivers/gpu/drm/tiny/panel-mipi-dbi.c
@@ -233,18 +233,46 @@ static void panel_mipi_dbi_commands_execute(struct mipi_dbi *dbi,
 	}
 }
 
-static void panel_mipi_dbi_enable(struct drm_simple_display_pipe *pipe,
-				  struct drm_crtc_state *crtc_state,
-				  struct drm_plane_state *plane_state)
+struct panel_mipi_dbi_device {
+	struct mipi_dbi_dev dbidev;
+
+	struct drm_plane plane;
+	struct drm_crtc crtc;
+	struct drm_encoder encoder;
+	struct drm_connector connector;
+};
+
+static struct panel_mipi_dbi_device *to_panel_mipi_dbi_device(struct drm_device *dev)
+{
+	return container_of(drm_to_mipi_dbi_dev(dev), struct panel_mipi_dbi_device, dbidev);
+}
+
+static const u64 panel_mipi_dbi_plane_format_modifiers[] = {
+	DRM_MIPI_DBI_PLANE_FORMAT_MODIFIERS,
+};
+
+static const struct drm_plane_helper_funcs panel_mipi_dbi_plane_helper_funcs = {
+	DRM_MIPI_DBI_PLANE_HELPER_FUNCS,
+};
+
+static const struct drm_plane_funcs panel_mipi_dbi_plane_funcs = {
+	DRM_MIPI_DBI_PLANE_FUNCS,
+	.destroy = drm_plane_cleanup,
+};
+
+static void panel_mipi_dbi_crtc_helper_atomic_enable(struct drm_crtc *crtc,
+						     struct drm_atomic_state *state)
 {
-	struct mipi_dbi_dev *dbidev = drm_to_mipi_dbi_dev(pipe->crtc.dev);
+	struct drm_device *drm = crtc->dev;
+	struct panel_mipi_dbi_device *panel_mipi_dbi = to_panel_mipi_dbi_device(drm);
+	struct mipi_dbi_dev *dbidev = &panel_mipi_dbi->dbidev;
 	struct mipi_dbi *dbi = &dbidev->dbi;
 	int ret, idx;
 
-	if (!drm_dev_enter(pipe->crtc.dev, &idx))
+	if (!drm_dev_enter(drm, &idx))
 		return;
 
-	drm_dbg(pipe->crtc.dev, "\n");
+	drm_dbg(drm, "\n");
 
 	ret = mipi_dbi_poweron_conditional_reset(dbidev);
 	if (ret < 0)
@@ -257,8 +285,35 @@ static void panel_mipi_dbi_enable(struct drm_simple_display_pipe *pipe,
 	drm_dev_exit(idx);
 }
 
-static const struct drm_simple_display_pipe_funcs panel_mipi_dbi_pipe_funcs = {
-	DRM_MIPI_DBI_SIMPLE_DISPLAY_PIPE_FUNCS(panel_mipi_dbi_enable),
+static const struct drm_crtc_helper_funcs panel_mipi_dbi_crtc_helper_funcs = {
+	DRM_MIPI_DBI_CRTC_HELPER_FUNCS,
+	.atomic_enable = panel_mipi_dbi_crtc_helper_atomic_enable,
+};
+
+static const struct drm_crtc_funcs panel_mipi_dbi_crtc_funcs = {
+	DRM_MIPI_DBI_CRTC_FUNCS,
+	.destroy = drm_crtc_cleanup,
+};
+
+static const struct drm_encoder_funcs panel_mipi_dbi_encoder_funcs = {
+	.destroy = drm_encoder_cleanup,
+};
+
+static const struct drm_connector_helper_funcs panel_mipi_dbi_connector_helper_funcs = {
+	DRM_MIPI_DBI_CONNECTOR_HELPER_FUNCS,
+};
+
+static const struct drm_connector_funcs panel_mipi_dbi_connector_funcs = {
+	DRM_MIPI_DBI_CONNECTOR_FUNCS,
+	.destroy = drm_connector_cleanup,
+};
+
+static const struct drm_mode_config_helper_funcs panel_mipi_dbi_mode_config_helper_funcs = {
+	DRM_MIPI_DBI_MODE_CONFIG_HELPER_FUNCS,
+};
+
+static const struct drm_mode_config_funcs panel_mipi_dbi_mode_config_funcs = {
+	DRM_MIPI_DBI_MODE_CONFIG_FUNCS,
 };
 
 DEFINE_DRM_GEM_DMA_FOPS(panel_mipi_dbi_fops);
@@ -317,20 +372,27 @@ static int panel_mipi_dbi_get_mode(struct mipi_dbi_dev *dbidev, struct drm_displ
 static int panel_mipi_dbi_spi_probe(struct spi_device *spi)
 {
 	struct device *dev = &spi->dev;
-	struct drm_display_mode mode;
+	struct panel_mipi_dbi_device *panel_mipi_dbi;
 	struct mipi_dbi_dev *dbidev;
 	struct drm_device *drm;
+	struct drm_display_mode mode;
 	struct mipi_dbi *dbi;
 	struct gpio_desc *dc;
 	unsigned int bpp;
 	size_t buf_size;
 	u32 formats[2];
+	struct drm_plane *plane;
+	struct drm_crtc *crtc;
+	struct drm_encoder *encoder;
+	struct drm_connector *connector;
 	int ret;
 
-	dbidev = devm_drm_dev_alloc(dev, &panel_mipi_dbi_driver, struct mipi_dbi_dev, drm);
-	if (IS_ERR(dbidev))
-		return PTR_ERR(dbidev);
-
+	panel_mipi_dbi = devm_drm_dev_alloc(dev, &panel_mipi_dbi_driver,
+					    struct panel_mipi_dbi_device,
+					    dbidev.drm);
+	if (IS_ERR(panel_mipi_dbi))
+		return PTR_ERR(panel_mipi_dbi);
+	dbidev = &panel_mipi_dbi->dbidev;
 	dbi = &dbidev->dbi;
 	drm = &dbidev->drm;
 
@@ -377,9 +439,54 @@ static int panel_mipi_dbi_spi_probe(struct spi_device *spi)
 		return ret;
 
 	buf_size = DIV_ROUND_UP(mode.hdisplay * mode.vdisplay * bpp, 8);
-	ret = mipi_dbi_dev_init_with_formats(dbidev, &panel_mipi_dbi_pipe_funcs,
-					     formats, ARRAY_SIZE(formats),
-					     &mode, 0, buf_size);
+	ret = drm_mipi_dbi_dev_init(dbidev, &mode, formats[0], 0, buf_size);
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
+	drm->mode_config.funcs = &panel_mipi_dbi_mode_config_funcs;
+	drm->mode_config.preferred_depth = bpp;
+	drm->mode_config.helper_private = &panel_mipi_dbi_mode_config_helper_funcs;
+
+	plane = &panel_mipi_dbi->plane;
+	ret = drm_universal_plane_init(drm, plane, 0, &panel_mipi_dbi_plane_funcs,
+				       formats, ARRAY_SIZE(formats),
+				       panel_mipi_dbi_plane_format_modifiers,
+				       DRM_PLANE_TYPE_PRIMARY, NULL);
+	if (ret)
+		return ret;
+	drm_plane_helper_add(plane, &panel_mipi_dbi_plane_helper_funcs);
+	drm_plane_enable_fb_damage_clips(plane);
+
+	crtc = &panel_mipi_dbi->crtc;
+	ret = drm_crtc_init_with_planes(drm, crtc, plane, NULL, &panel_mipi_dbi_crtc_funcs,
+					NULL);
+	if (ret)
+		return ret;
+	drm_crtc_helper_add(crtc, &panel_mipi_dbi_crtc_helper_funcs);
+
+	encoder = &panel_mipi_dbi->encoder;
+	ret = drm_encoder_init(drm, encoder, &panel_mipi_dbi_encoder_funcs,
+			       DRM_MODE_ENCODER_NONE, NULL);
+	if (ret)
+		return ret;
+	encoder->possible_crtcs = drm_crtc_mask(crtc);
+
+	connector = &panel_mipi_dbi->connector;
+	ret = drm_connector_init(drm, connector, &panel_mipi_dbi_connector_funcs,
+				 DRM_MODE_CONNECTOR_SPI);
+	if (ret)
+		return ret;
+	drm_connector_helper_add(connector, &panel_mipi_dbi_connector_helper_funcs);
+
+	ret = drm_connector_attach_encoder(connector, encoder);
 	if (ret)
 		return ret;
 
-- 
2.53.0

