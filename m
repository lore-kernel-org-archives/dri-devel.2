Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D56C61090242
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 16:01:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC23710E7D1;
	Thu, 19 Mar 2026 16:01:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="uTyZiom4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="OTDxNEcm";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="s8c8V1aa";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sbkeeB6h";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0114610E7A5
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 16:01:22 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5BE365BD66;
 Thu, 19 Mar 2026 16:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773936080; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Snh35t1p6OmtFgDfrpALnvqRePs+ThL08qQG9oyX7Y8=;
 b=uTyZiom49Nz4J0Pyb0k+am/CxrFQqGon0y1JLFsDR+vJ+zIeSEHxzu5uoNh05F3ESm/8yg
 K0Tn2b2D2vvUvSJzV26jmw1ietOjewrWV9wgzmqN585CWde3yBckjLp+iYTxnx2ZSr7tpJ
 VJqiaaGDXOlSDMdFew8az+uRnqPjkSM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773936080;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Snh35t1p6OmtFgDfrpALnvqRePs+ThL08qQG9oyX7Y8=;
 b=OTDxNEcmMEE3UP6N7A0m+Husz7wG3WYCCWNKN03RfY8AtQdWjJGT5ZBKel76hzcMoAU2JO
 DrWpo0xSdoW4dxAA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=s8c8V1aa;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=sbkeeB6h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773936075; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Snh35t1p6OmtFgDfrpALnvqRePs+ThL08qQG9oyX7Y8=;
 b=s8c8V1aaWzJJ6xBVg2Qo6RpMiHDmktie56I5PUtsX5Z8LMxb3Gfx/hXEIsC+fTuAcRmU2x
 AeZpbQkYmHrKkDz0jkoLexq5Mp8X7A5BT8BBvyuex5bMuDxcsUBMdbTKEghgQVYz95FE6g
 wDFu77hEIW5JfUgVDFk+eX4xtkQvCZ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773936075;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Snh35t1p6OmtFgDfrpALnvqRePs+ThL08qQG9oyX7Y8=;
 b=sbkeeB6hmEiz9lv4oIWiwxeCu0dc+FjeYAmCd+YNqPJfPv8ebGPSEiQK/NaErxIgvByJDq
 ppxdZGTfKT6iuUAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 074CD4274C;
 Thu, 19 Mar 2026 16:01:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mJmCAMsdvGn0WQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Thu, 19 Mar 2026 16:01:15 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: david@lechnology.com, javierm@redhat.com, lanzano.alex@gmail.com,
 kamlesh.gurudasani@gmail.com, architanant5@gmail.com, wens@kernel.org,
 mripard@kernel.org, maarten.lankhorst@linux.intel.com, simona@ffwll.ch,
 airlied@gmail.com
Cc: dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v3 02/16] drm/mipi-dbi: Support custom pipelines with
 drm_mipi_dbi_dev_init()
Date: Thu, 19 Mar 2026 16:59:38 +0100
Message-ID: <20260319160110.109610-3-tzimmermann@suse.de>
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
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FREEMAIL_TO(0.00)[lechnology.com,redhat.com,gmail.com,kernel.org,linux.intel.com,ffwll.ch];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCPT_COUNT_TWELVE(0.00)[12];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid,suse.de:email];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TAGGED_RCPT(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; DKIM_TRACE(0.00)[suse.de:+];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 TO_DN_SOME(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Queue-Id: 5BE365BD66
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

Initialize the mipi-dbi device with drm_mipi_dbi_dev_init() without
creating a modesetting pipeline. Will allow for mipi-dbi drivers
without simple-display helpers.

As the new helper is a DRM function, add the drm_ prefix. Mipi-dbi
interfaces currently lack this.

v3:
- document tx_buf_size parameter (David)

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Acked-by: David Lechner <david@lechnology.com>
---
 drivers/gpu/drm/drm_mipi_dbi.c | 80 ++++++++++++++++++++++++----------
 include/drm/drm_mipi_dbi.h     |  4 ++
 2 files changed, 61 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/drm_mipi_dbi.c b/drivers/gpu/drm/drm_mipi_dbi.c
index bb6cebc583be..bc5444ca7ac6 100644
--- a/drivers/gpu/drm/drm_mipi_dbi.c
+++ b/drivers/gpu/drm/drm_mipi_dbi.c
@@ -554,6 +554,59 @@ static const uint32_t mipi_dbi_formats[] = {
 	DRM_FORMAT_XRGB8888,
 };
 
+/**
+ * drm_mipi_dbi_dev_init - MIPI DBI device initialization
+ * @dbidev: MIPI DBI device structure to initialize
+ * @mode: Hardware display mode
+ * @format: Hardware color format (DRM_FORMAT\_\*).
+ * @rotation: Initial rotation in degrees Counter Clock Wise
+ * @tx_buf_size: Allocate a transmit buffer of at least this size.
+ *
+ * Initializes a MIPI-DBI device. The minimum size of the transmit buffer
+ * in @tx_buf_size is optional. Pass 0 to allocate enough memory to transmit
+ * a single scanline of the display.
+ *
+ * Returns:
+ * Zero on success, negative error code on failure.
+ */
+int drm_mipi_dbi_dev_init(struct mipi_dbi_dev *dbidev, const struct drm_display_mode *mode,
+			  u32 format, unsigned int rotation, size_t tx_buf_size)
+{
+	struct drm_device *drm = &dbidev->drm;
+	int ret;
+
+	if (!dbidev->dbi.command)
+		return -EINVAL;
+
+	if (!tx_buf_size) {
+		const struct drm_format_info *info = drm_format_info(format);
+
+		tx_buf_size = drm_format_info_min_pitch(info, 0, mode->hdisplay) *
+			      mode->vdisplay;
+	}
+
+	dbidev->tx_buf = devm_kmalloc(drm->dev, tx_buf_size, GFP_KERNEL);
+	if (!dbidev->tx_buf)
+		return -ENOMEM;
+
+	drm_mode_copy(&dbidev->mode, mode);
+	ret = mipi_dbi_rotate_mode(&dbidev->mode, rotation);
+	if (ret) {
+		drm_err(drm, "Illegal rotation value %u\n", rotation);
+		return -EINVAL;
+	}
+
+	dbidev->rotation = rotation;
+	drm_dbg(drm, "rotation = %u\n", rotation);
+
+	dbidev->pixel_format = format;
+	if (dbidev->pixel_format == DRM_FORMAT_RGB888)
+		dbidev->dbi.write_memory_bpw = 8;
+
+	return 0;
+}
+EXPORT_SYMBOL(drm_mipi_dbi_dev_init);
+
 /**
  * mipi_dbi_dev_init_with_formats - MIPI DBI device initialization with custom formats
  * @dbidev: MIPI DBI device structure to initialize
@@ -590,24 +643,14 @@ int mipi_dbi_dev_init_with_formats(struct mipi_dbi_dev *dbidev,
 	struct drm_device *drm = &dbidev->drm;
 	int ret;
 
-	if (!dbidev->dbi.command)
-		return -EINVAL;
+	ret = drm_mipi_dbi_dev_init(dbidev, mode, formats[0], rotation, tx_buf_size);
+	if (ret)
+		return ret;
 
 	ret = drmm_mode_config_init(drm);
 	if (ret)
 		return ret;
 
-	dbidev->tx_buf = devm_kmalloc(drm->dev, tx_buf_size, GFP_KERNEL);
-	if (!dbidev->tx_buf)
-		return -ENOMEM;
-
-	drm_mode_copy(&dbidev->mode, mode);
-	ret = mipi_dbi_rotate_mode(&dbidev->mode, rotation);
-	if (ret) {
-		DRM_ERROR("Illegal rotation value %u\n", rotation);
-		return -EINVAL;
-	}
-
 	drm_connector_helper_add(&dbidev->connector, &mipi_dbi_connector_hfuncs);
 	ret = drm_connector_init(drm, &dbidev->connector, &mipi_dbi_connector_funcs,
 				 DRM_MODE_CONNECTOR_SPI);
@@ -628,13 +671,6 @@ int mipi_dbi_dev_init_with_formats(struct mipi_dbi_dev *dbidev,
 	drm->mode_config.max_height = dbidev->mode.vdisplay;
 	drm->mode_config.helper_private = &mipi_dbi_mode_config_helper_funcs;
 
-	dbidev->rotation = rotation;
-	dbidev->pixel_format = formats[0];
-	if (formats[0] == DRM_FORMAT_RGB888)
-		dbidev->dbi.write_memory_bpw = 8;
-
-	DRM_DEBUG_KMS("rotation = %u\n", rotation);
-
 	return 0;
 }
 EXPORT_SYMBOL(mipi_dbi_dev_init_with_formats);
@@ -660,13 +696,11 @@ int mipi_dbi_dev_init(struct mipi_dbi_dev *dbidev,
 		      const struct drm_simple_display_pipe_funcs *funcs,
 		      const struct drm_display_mode *mode, unsigned int rotation)
 {
-	size_t bufsize = (u32)mode->vdisplay * mode->hdisplay * sizeof(u16);
-
 	dbidev->drm.mode_config.preferred_depth = 16;
 
 	return mipi_dbi_dev_init_with_formats(dbidev, funcs, mipi_dbi_formats,
 					      ARRAY_SIZE(mipi_dbi_formats), mode,
-					      rotation, bufsize);
+					      rotation, 0);
 }
 EXPORT_SYMBOL(mipi_dbi_dev_init);
 
diff --git a/include/drm/drm_mipi_dbi.h b/include/drm/drm_mipi_dbi.h
index 637be84d3d5a..9c0e015dd929 100644
--- a/include/drm/drm_mipi_dbi.h
+++ b/include/drm/drm_mipi_dbi.h
@@ -164,6 +164,10 @@ static inline struct mipi_dbi_dev *drm_to_mipi_dbi_dev(struct drm_device *drm)
 
 int mipi_dbi_spi_init(struct spi_device *spi, struct mipi_dbi *dbi,
 		      struct gpio_desc *dc);
+
+int drm_mipi_dbi_dev_init(struct mipi_dbi_dev *dbidev, const struct drm_display_mode *mode,
+			  u32 format, unsigned int rotation, size_t tx_buf_size);
+
 int mipi_dbi_dev_init_with_formats(struct mipi_dbi_dev *dbidev,
 				   const struct drm_simple_display_pipe_funcs *funcs,
 				   const uint32_t *formats, unsigned int format_count,
-- 
2.53.0

