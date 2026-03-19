Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 460061090248
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 16:02:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AE1610E953;
	Thu, 19 Mar 2026 16:02:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="sd96k4f9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ddMvG5sC";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sd96k4f9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ddMvG5sC";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D54810E8DB
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 16:02:02 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0FFA15BD88;
 Thu, 19 Mar 2026 16:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773936082; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pOu8nxVQjrdAcqp7JItkuk/+hPC6y+hGjF3Snmt67HQ=;
 b=sd96k4f94ZQxol6wPFMVQ6AIN7UmmEZwefr8RBuCbJXglOSXNqp9ADgJcPqSNFwPd2rUzb
 b8tAuY8EiAWDFwl52GlxVmhset9DrWkWUCSf3f/aJq2Q5wmDccsrYywBy72m2NZD0aFGqJ
 V8YRTO7jAmJ1Xn1S/LdsC434yBysVTo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773936082;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pOu8nxVQjrdAcqp7JItkuk/+hPC6y+hGjF3Snmt67HQ=;
 b=ddMvG5sCmQg056zBxdTGonTfqiFDfXN97fWpD9iGeN0q3K8jj9kHS8zQoP/YScB5Tq8jle
 /pNjwrHFL08X6zDw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=sd96k4f9;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ddMvG5sC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773936082; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pOu8nxVQjrdAcqp7JItkuk/+hPC6y+hGjF3Snmt67HQ=;
 b=sd96k4f94ZQxol6wPFMVQ6AIN7UmmEZwefr8RBuCbJXglOSXNqp9ADgJcPqSNFwPd2rUzb
 b8tAuY8EiAWDFwl52GlxVmhset9DrWkWUCSf3f/aJq2Q5wmDccsrYywBy72m2NZD0aFGqJ
 V8YRTO7jAmJ1Xn1S/LdsC434yBysVTo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773936082;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pOu8nxVQjrdAcqp7JItkuk/+hPC6y+hGjF3Snmt67HQ=;
 b=ddMvG5sCmQg056zBxdTGonTfqiFDfXN97fWpD9iGeN0q3K8jj9kHS8zQoP/YScB5Tq8jle
 /pNjwrHFL08X6zDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3305642761;
 Thu, 19 Mar 2026 16:01:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sKE+C88dvGn0WQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Thu, 19 Mar 2026 16:01:19 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: david@lechnology.com, javierm@redhat.com, lanzano.alex@gmail.com,
 kamlesh.gurudasani@gmail.com, architanant5@gmail.com, wens@kernel.org,
 mripard@kernel.org, maarten.lankhorst@linux.intel.com, simona@ffwll.ch,
 airlied@gmail.com
Cc: dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v3 14/16] drm/st7735r: Use regular atomic helpers;
 drop simple-display helpers
Date: Thu, 19 Mar 2026 16:59:50 +0100
Message-ID: <20260319160110.109610-15-tzimmermann@suse.de>
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
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
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
X-Rspamd-Queue-Id: 0FFA15BD88
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
pipeline elements in struct st7735r_device and initialize them as part
of probing the device. Use mipi-dbi's existing helpers and initializer
macros where possible.

Effectively open-codes the modesetting code in the initializer helpers
of mipi-dbi and simple-display. St7735r requires a custom helper for
CRTC enablement, and non-freeing cleanup of the pipeline.

v2:
- fix connector initialization

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Acked-by: David Lechner <david@lechnology.com>
---
 drivers/gpu/drm/sitronix/st7735r.c | 115 ++++++++++++++++++++++++++---
 1 file changed, 106 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/sitronix/st7735r.c b/drivers/gpu/drm/sitronix/st7735r.c
index e70c46df0299..5a75716ed5ff 100644
--- a/drivers/gpu/drm/sitronix/st7735r.c
+++ b/drivers/gpu/drm/sitronix/st7735r.c
@@ -55,6 +55,11 @@ struct st7735r_cfg {
 struct st7735r_device {
 	struct mipi_dbi_dev dbidev;	/* Must be first for .release() */
 	const struct st7735r_cfg *cfg;
+
+	struct drm_plane plane;
+	struct drm_crtc crtc;
+	struct drm_encoder encoder;
+	struct drm_connector connector;
 };
 
 static struct st7735r_device *to_st7735r_device(struct drm_device *drm)
@@ -62,17 +67,34 @@ static struct st7735r_device *to_st7735r_device(struct drm_device *drm)
 	return container_of(drm_to_mipi_dbi_dev(drm), struct st7735r_device, dbidev);
 }
 
-static void st7735r_pipe_enable(struct drm_simple_display_pipe *pipe,
-				struct drm_crtc_state *crtc_state,
-				struct drm_plane_state *plane_state)
+static const u32 st7735r_plane_formats[] = {
+	DRM_MIPI_DBI_PLANE_FORMATS,
+};
+
+static const u64 st7735r_plane_format_modifiers[] = {
+	DRM_MIPI_DBI_PLANE_FORMAT_MODIFIERS,
+};
+
+static const struct drm_plane_helper_funcs st7735r_plane_helper_funcs = {
+	DRM_MIPI_DBI_PLANE_HELPER_FUNCS,
+};
+
+static const struct drm_plane_funcs st7735r_plane_funcs = {
+	DRM_MIPI_DBI_PLANE_FUNCS,
+	.destroy = drm_plane_cleanup,
+};
+
+static void st7735r_crtc_helper_atomic_enable(struct drm_crtc *crtc,
+					      struct drm_atomic_state *state)
 {
-	struct st7735r_device *st7735r = to_st7735r_device(pipe->crtc.dev);
+	struct drm_device *drm = crtc->dev;
+	struct st7735r_device *st7735r = to_st7735r_device(drm);
 	struct mipi_dbi_dev *dbidev = &st7735r->dbidev;
 	struct mipi_dbi *dbi = &dbidev->dbi;
 	int ret, idx;
 	u8 addr_mode;
 
-	if (!drm_dev_enter(pipe->crtc.dev, &idx))
+	if (!drm_dev_enter(drm, &idx))
 		return;
 
 	DRM_DEBUG_KMS("\n");
@@ -138,8 +160,35 @@ static void st7735r_pipe_enable(struct drm_simple_display_pipe *pipe,
 	drm_dev_exit(idx);
 }
 
-static const struct drm_simple_display_pipe_funcs st7735r_pipe_funcs = {
-	DRM_MIPI_DBI_SIMPLE_DISPLAY_PIPE_FUNCS(st7735r_pipe_enable),
+static const struct drm_crtc_helper_funcs st7735r_crtc_helper_funcs = {
+	DRM_MIPI_DBI_CRTC_HELPER_FUNCS,
+	.atomic_enable = st7735r_crtc_helper_atomic_enable,
+};
+
+static const struct drm_crtc_funcs st7735r_crtc_funcs = {
+	DRM_MIPI_DBI_CRTC_FUNCS,
+	.destroy = drm_crtc_cleanup,
+};
+
+static const struct drm_encoder_funcs st7735r_encoder_funcs = {
+	.destroy = drm_encoder_cleanup,
+};
+
+static const struct drm_connector_helper_funcs st7735r_connector_helper_funcs = {
+	DRM_MIPI_DBI_CONNECTOR_HELPER_FUNCS,
+};
+
+static const struct drm_connector_funcs st7735r_connector_funcs = {
+	DRM_MIPI_DBI_CONNECTOR_FUNCS,
+	.destroy = drm_connector_cleanup,
+};
+
+static const struct drm_mode_config_helper_funcs st7735r_mode_config_helper_funcs = {
+	DRM_MIPI_DBI_MODE_CONFIG_HELPER_FUNCS,
+};
+
+static const struct drm_mode_config_funcs st7735r_mode_config_funcs = {
+	DRM_MIPI_DBI_MODE_CONFIG_FUNCS,
 };
 
 static const struct st7735r_cfg jd_t18003_t01_cfg = {
@@ -192,6 +241,10 @@ static int st7735r_probe(struct spi_device *spi)
 	struct drm_device *drm;
 	struct mipi_dbi *dbi;
 	struct gpio_desc *dc;
+	struct drm_plane *plane;
+	struct drm_crtc *crtc;
+	struct drm_encoder *encoder;
+	struct drm_connector *connector;
 	u32 rotation = 0;
 	int ret;
 
@@ -233,8 +286,52 @@ static int st7735r_probe(struct spi_device *spi)
 	dbidev->left_offset = cfg->left_offset;
 	dbidev->top_offset = cfg->top_offset;
 
-	ret = mipi_dbi_dev_init(dbidev, &st7735r_pipe_funcs, &cfg->mode,
-				rotation);
+	ret = drm_mipi_dbi_dev_init(dbidev, &cfg->mode, st7735r_plane_formats[0], rotation, 0);
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
+	drm->mode_config.funcs = &st7735r_mode_config_funcs;
+	drm->mode_config.preferred_depth = 16;
+	drm->mode_config.helper_private = &st7735r_mode_config_helper_funcs;
+
+	plane = &st7735r->plane;
+	ret = drm_universal_plane_init(drm, plane, 0, &st7735r_plane_funcs,
+				       st7735r_plane_formats, ARRAY_SIZE(st7735r_plane_formats),
+				       st7735r_plane_format_modifiers,
+				       DRM_PLANE_TYPE_PRIMARY, NULL);
+	if (ret)
+		return ret;
+	drm_plane_helper_add(plane, &st7735r_plane_helper_funcs);
+	drm_plane_enable_fb_damage_clips(plane);
+
+	crtc = &st7735r->crtc;
+	ret = drm_crtc_init_with_planes(drm, crtc, plane, NULL, &st7735r_crtc_funcs, NULL);
+	if (ret)
+		return ret;
+	drm_crtc_helper_add(crtc, &st7735r_crtc_helper_funcs);
+
+	encoder = &st7735r->encoder;
+	ret = drm_encoder_init(drm, encoder, &st7735r_encoder_funcs, DRM_MODE_ENCODER_NONE, NULL);
+	if (ret)
+		return ret;
+	encoder->possible_crtcs = drm_crtc_mask(crtc);
+
+	connector = &st7735r->connector;
+	ret = drm_connector_init(drm, connector, &st7735r_connector_funcs,
+				 DRM_MODE_CONNECTOR_SPI);
+	if (ret)
+		return ret;
+	drm_connector_helper_add(connector, &st7735r_connector_helper_funcs);
+
+	ret = drm_connector_attach_encoder(connector, encoder);
 	if (ret)
 		return ret;
 
-- 
2.53.0

