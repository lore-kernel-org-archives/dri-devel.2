Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25C5A1090247
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 16:01:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81A5B10E8FD;
	Thu, 19 Mar 2026 16:01:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="UykjoC9I";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kdS8mGL6";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LKk1vdEw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4N5SYwXO";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27C4110E904
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 16:01:37 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DE9755BD72;
 Thu, 19 Mar 2026 16:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773936082; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rZr3ZWlaKNe3Z39l3gnpN6VsBBEMnKisNyPDemfSYq4=;
 b=UykjoC9I1og7g6u3yoUvko9nq7EGhqGGj7WbsEgaXsiwfkWG2n+5m0+GQt75BTA5XbXH2H
 2UJkglfyoo6hjevG3f3ogKcu4nLEG62PZP939yCtWVQU2JIOeQescIi98Iw7XH7UFmxEAv
 14l9H8RYF2acirARPOMCIn34PVcRpyY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773936082;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rZr3ZWlaKNe3Z39l3gnpN6VsBBEMnKisNyPDemfSYq4=;
 b=kdS8mGL6VC4YN/fGf6xLV5+gF1O6TrSnGbFYlgAB9Hl5qU8DMlwTFXlSx+a1GmQCDy4J0M
 FfMJFQafvgvoEKAw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=LKk1vdEw;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=4N5SYwXO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773936081; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rZr3ZWlaKNe3Z39l3gnpN6VsBBEMnKisNyPDemfSYq4=;
 b=LKk1vdEwKTKdGotXduWPLpmMY1W7H54+VbPP9QDnBbu2JdgPN6phtqcPuWp2o0VbE+/qHt
 Z30wQu372QUa15aN+BHwsHP4rUEMl5d+NQFBloJXhscVde5lE6C/QscvkHgKwMEwltl7zG
 McleNoYuADw62fJ4JUdSXabbGA17y5w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773936081;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rZr3ZWlaKNe3Z39l3gnpN6VsBBEMnKisNyPDemfSYq4=;
 b=4N5SYwXOOx3xu/d/3VWDfxsTkcX7kcJORyf5oY+vGQkyppHeytPzBYddl+/1gVXB4EB/oH
 Q/6wfdu4oX2+6FDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C479C42751;
 Thu, 19 Mar 2026 16:01:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yF3ELswdvGn0WQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Thu, 19 Mar 2026 16:01:16 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: david@lechnology.com, javierm@redhat.com, lanzano.alex@gmail.com,
 kamlesh.gurudasani@gmail.com, architanant5@gmail.com, wens@kernel.org,
 mripard@kernel.org, maarten.lankhorst@linux.intel.com, simona@ffwll.ch,
 airlied@gmail.com
Cc: dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v3 07/16] drm/ili9341: Use regular atomic helpers;
 drop simple-display helpers
Date: Thu, 19 Mar 2026 16:59:43 +0100
Message-ID: <20260319160110.109610-8-tzimmermann@suse.de>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 TAGGED_RCPT(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 R_RATELIMIT(0.00)[to_ip_from(RLqtkr6cif1ebgurukgmwdm7xc)];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: DE9755BD72
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
pipeline elements in struct ili9341_device and initialize them as part
of probing the device. Use mipi-dbi's existing helpers and initializer
macros where possible.

Effectively open-codes the modesetting code in the initializer helpers
of mipi-dbi and simple-display. Ili9341 requires a custom helper for
CRTC enablement, and non-freeing cleanup of the pipeline.

v3:
- set dbi variable (David)
v2:
- fix connector initialization

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Acked-by: David Lechner <david@lechnology.com>
---
 drivers/gpu/drm/tiny/ili9341.c | 135 +++++++++++++++++++++++++++++----
 1 file changed, 122 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/tiny/ili9341.c b/drivers/gpu/drm/tiny/ili9341.c
index 972811564d6a..e623bd8a1827 100644
--- a/drivers/gpu/drm/tiny/ili9341.c
+++ b/drivers/gpu/drm/tiny/ili9341.c
@@ -52,16 +52,48 @@
 #define ILI9341_MADCTL_MX	BIT(6)
 #define ILI9341_MADCTL_MY	BIT(7)
 
-static void yx240qv29_enable(struct drm_simple_display_pipe *pipe,
-			     struct drm_crtc_state *crtc_state,
-			     struct drm_plane_state *plane_state)
+struct ili9341_device {
+	struct mipi_dbi_dev dbidev;
+
+	struct drm_plane plane;
+	struct drm_crtc crtc;
+	struct drm_encoder encoder;
+	struct drm_connector connector;
+};
+
+static struct ili9341_device *to_ili9341_device(struct drm_device *dev)
 {
-	struct mipi_dbi_dev *dbidev = drm_to_mipi_dbi_dev(pipe->crtc.dev);
+	return container_of(drm_to_mipi_dbi_dev(dev), struct ili9341_device, dbidev);
+}
+
+static const u32 ili9341_plane_formats[] = {
+	DRM_MIPI_DBI_PLANE_FORMATS,
+};
+
+static const u64 ili9341_plane_format_modifiers[] = {
+	DRM_MIPI_DBI_PLANE_FORMAT_MODIFIERS,
+};
+
+static const struct drm_plane_helper_funcs ili9341_plane_helper_funcs = {
+	DRM_MIPI_DBI_PLANE_HELPER_FUNCS,
+};
+
+static const struct drm_plane_funcs ili9341_plane_funcs = {
+	DRM_MIPI_DBI_PLANE_FUNCS,
+	.destroy = drm_plane_cleanup,
+};
+
+static void ili9341_crtc_helper_atomic_enable(struct drm_crtc *crtc,
+					      struct drm_atomic_state *state)
+{
+	struct drm_device *drm = crtc->dev;
+	struct ili9341_device *ili9341 = to_ili9341_device(drm);
+	struct mipi_dbi_dev *dbidev = &ili9341->dbidev;
 	struct mipi_dbi *dbi = &dbidev->dbi;
 	u8 addr_mode;
 	int ret, idx;
 
-	if (!drm_dev_enter(pipe->crtc.dev, &idx))
+	if (!drm_dev_enter(drm, &idx))
 		return;
 
 	DRM_DEBUG_KMS("\n");
@@ -139,8 +171,35 @@ static void yx240qv29_enable(struct drm_simple_display_pipe *pipe,
 	drm_dev_exit(idx);
 }
 
-static const struct drm_simple_display_pipe_funcs ili9341_pipe_funcs = {
-	DRM_MIPI_DBI_SIMPLE_DISPLAY_PIPE_FUNCS(yx240qv29_enable),
+static const struct drm_crtc_helper_funcs ili9341_crtc_helper_funcs = {
+	DRM_MIPI_DBI_CRTC_HELPER_FUNCS,
+	.atomic_enable = ili9341_crtc_helper_atomic_enable,
+};
+
+static const struct drm_crtc_funcs ili9341_crtc_funcs = {
+	DRM_MIPI_DBI_CRTC_FUNCS,
+	.destroy = drm_crtc_cleanup,
+};
+
+static const struct drm_encoder_funcs ili9341_encoder_funcs = {
+	.destroy = drm_encoder_cleanup,
+};
+
+static const struct drm_connector_helper_funcs ili9341_connector_helper_funcs = {
+	DRM_MIPI_DBI_CONNECTOR_HELPER_FUNCS,
+};
+
+static const struct drm_connector_funcs ili9341_connector_funcs = {
+	DRM_MIPI_DBI_CONNECTOR_FUNCS,
+	.destroy = drm_connector_cleanup,
+};
+
+static const struct drm_mode_config_helper_funcs ili9341_mode_config_helper_funcs = {
+	DRM_MIPI_DBI_MODE_CONFIG_HELPER_FUNCS,
+};
+
+static const struct drm_mode_config_funcs ili9341_mode_config_funcs = {
+	DRM_MIPI_DBI_MODE_CONFIG_FUNCS,
 };
 
 static const struct drm_display_mode yx240qv29_mode = {
@@ -176,18 +235,22 @@ MODULE_DEVICE_TABLE(spi, ili9341_id);
 static int ili9341_probe(struct spi_device *spi)
 {
 	struct device *dev = &spi->dev;
+	struct ili9341_device *ili9341;
 	struct mipi_dbi_dev *dbidev;
 	struct drm_device *drm;
 	struct mipi_dbi *dbi;
 	struct gpio_desc *dc;
+	struct drm_plane *plane;
+	struct drm_crtc *crtc;
+	struct drm_encoder *encoder;
+	struct drm_connector *connector;
 	u32 rotation = 0;
 	int ret;
 
-	dbidev = devm_drm_dev_alloc(dev, &ili9341_driver,
-				    struct mipi_dbi_dev, drm);
-	if (IS_ERR(dbidev))
-		return PTR_ERR(dbidev);
-
+	ili9341 = devm_drm_dev_alloc(dev, &ili9341_driver, struct ili9341_device, dbidev.drm);
+	if (IS_ERR(ili9341))
+		return PTR_ERR(ili9341);
+	dbidev = &ili9341->dbidev;
 	dbi = &dbidev->dbi;
 	drm = &dbidev->drm;
 
@@ -209,7 +272,53 @@ static int ili9341_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	ret = mipi_dbi_dev_init(dbidev, &ili9341_pipe_funcs, &yx240qv29_mode, rotation);
+	ret = drm_mipi_dbi_dev_init(dbidev, &yx240qv29_mode, ili9341_plane_formats[0],
+				    rotation, 0);
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
+	drm->mode_config.funcs = &ili9341_mode_config_funcs;
+	drm->mode_config.preferred_depth = 16;
+	drm->mode_config.helper_private = &ili9341_mode_config_helper_funcs;
+
+	plane = &ili9341->plane;
+	ret = drm_universal_plane_init(drm, plane, 0, &ili9341_plane_funcs,
+				       ili9341_plane_formats, ARRAY_SIZE(ili9341_plane_formats),
+				       ili9341_plane_format_modifiers,
+				       DRM_PLANE_TYPE_PRIMARY, NULL);
+	if (ret)
+		return ret;
+	drm_plane_helper_add(plane, &ili9341_plane_helper_funcs);
+	drm_plane_enable_fb_damage_clips(plane);
+
+	crtc = &ili9341->crtc;
+	ret = drm_crtc_init_with_planes(drm, crtc, plane, NULL, &ili9341_crtc_funcs, NULL);
+	if (ret)
+		return ret;
+	drm_crtc_helper_add(crtc, &ili9341_crtc_helper_funcs);
+
+	encoder = &ili9341->encoder;
+	ret = drm_encoder_init(drm, encoder, &ili9341_encoder_funcs, DRM_MODE_ENCODER_NONE, NULL);
+	if (ret)
+		return ret;
+	encoder->possible_crtcs = drm_crtc_mask(crtc);
+
+	connector = &ili9341->connector;
+	ret = drm_connector_init(drm, connector, &ili9341_connector_funcs,
+				 DRM_MODE_CONNECTOR_SPI);
+	if (ret)
+		return ret;
+	drm_connector_helper_add(connector, &ili9341_connector_helper_funcs);
+
+	ret = drm_connector_attach_encoder(connector, encoder);
 	if (ret)
 		return ret;
 
-- 
2.53.0

