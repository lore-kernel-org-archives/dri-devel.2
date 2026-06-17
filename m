Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9545CD98F0
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 11:29:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4B5A10EFBE;
	Wed, 17 Jun 2026 11:29:48 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D11210EFB9
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 11:29:42 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B112D6BEAF;
 Wed, 17 Jun 2026 11:29:37 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 73B87779A8;
 Wed, 17 Jun 2026 11:29:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iP8HGyGFMmqbZAAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Wed, 17 Jun 2026 11:29:37 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: javierm@redhat.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, sashiko-reviews@lists.linux.dev,
 Thomas Zimmermann <tzimmermann@suse.de>, stable@vger.kernel.org
Subject: [PATCH 2/2] drm/sysfb: Return errno code from
 drm_sysfb_get_visible_size()
Date: Wed, 17 Jun 2026 13:27:30 +0200
Message-ID: <20260617112932.511657-3-tzimmermann@suse.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260617112932.511657-1-tzimmermann@suse.de>
References: <20260617112932.511657-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: B112D6BEAF
X-Rspamd-Action: no action
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

Change the return type of drm_sysfb_get_visible_size() to s64 so
that it returns a possible errno code from _get_validated_size0().
Fix callers to handle the errno code.

The currently returned unsigned type converts an errno code to a
very large size value, which drivers interpret as visible size of
the system framebuffer. Later efforts to reserve the framebuffer
resource fail.

The bug has been present since efidrm and vesadrm got merged. It
was then part of each driver.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: 32ae90c66fb6 ("drm/sysfb: Add efidrm for EFI displays")
Fixes: a84eb6abe2b6 ("drm/sysfb: Add vesadrm for VESA displays")
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Javier Martinez Canillas <javierm@redhat.com>
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v6.16+
---
 drivers/gpu/drm/sysfb/drm_sysfb_helper.h      | 2 +-
 drivers/gpu/drm/sysfb/drm_sysfb_screen_info.c | 2 +-
 drivers/gpu/drm/sysfb/efidrm.c                | 7 ++++---
 drivers/gpu/drm/sysfb/vesadrm.c               | 6 +++---
 4 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/sysfb/drm_sysfb_helper.h b/drivers/gpu/drm/sysfb/drm_sysfb_helper.h
index 2a2b553366fb..547f2327af5e 100644
--- a/drivers/gpu/drm/sysfb/drm_sysfb_helper.h
+++ b/drivers/gpu/drm/sysfb/drm_sysfb_helper.h
@@ -50,7 +50,7 @@ struct resource *drm_sysfb_get_memory_si(struct drm_device *dev,
 int drm_sysfb_get_stride_si(struct drm_device *dev, const struct screen_info *si,
 			    const struct drm_format_info *format,
 			    unsigned int width, unsigned int height, u64 size);
-u64 drm_sysfb_get_visible_size_si(struct drm_device *dev, const struct screen_info *si,
+s64 drm_sysfb_get_visible_size_si(struct drm_device *dev, const struct screen_info *si,
 				  unsigned int height, unsigned int stride, u64 size);
 #endif
 
diff --git a/drivers/gpu/drm/sysfb/drm_sysfb_screen_info.c b/drivers/gpu/drm/sysfb/drm_sysfb_screen_info.c
index 361b7233600c..40b4f7883b9b 100644
--- a/drivers/gpu/drm/sysfb/drm_sysfb_screen_info.c
+++ b/drivers/gpu/drm/sysfb/drm_sysfb_screen_info.c
@@ -64,7 +64,7 @@ int drm_sysfb_get_stride_si(struct drm_device *dev, const struct screen_info *si
 }
 EXPORT_SYMBOL(drm_sysfb_get_stride_si);
 
-u64 drm_sysfb_get_visible_size_si(struct drm_device *dev, const struct screen_info *si,
+s64 drm_sysfb_get_visible_size_si(struct drm_device *dev, const struct screen_info *si,
 				  unsigned int height, unsigned int stride, u64 size)
 {
 	u64 vsize = height * stride;
diff --git a/drivers/gpu/drm/sysfb/efidrm.c b/drivers/gpu/drm/sysfb/efidrm.c
index 1a1e36700976..3f9cd5d03efb 100644
--- a/drivers/gpu/drm/sysfb/efidrm.c
+++ b/drivers/gpu/drm/sysfb/efidrm.c
@@ -152,7 +152,8 @@ static struct efidrm_device *efidrm_device_create(struct drm_driver *drv,
 	const struct screen_info *si;
 	const struct drm_format_info *format;
 	int width, height, stride;
-	u64 vsize, mem_flags;
+	s64 vsize;
+	u64 mem_flags;
 	struct resource resbuf;
 	struct resource *res;
 	struct efidrm_device *efi;
@@ -206,8 +207,8 @@ static struct efidrm_device *efidrm_device_create(struct drm_driver *drv,
 	if (stride < 0)
 		return ERR_PTR(stride);
 	vsize = drm_sysfb_get_visible_size_si(dev, si, height, stride, resource_size(res));
-	if (!vsize)
-		return ERR_PTR(-EINVAL);
+	if (vsize < 0)
+		return ERR_PTR(vsize);
 
 	drm_dbg(dev, "framebuffer format=%p4cc, size=%dx%d, stride=%d bytes\n",
 		&format->format, width, height, stride);
diff --git a/drivers/gpu/drm/sysfb/vesadrm.c b/drivers/gpu/drm/sysfb/vesadrm.c
index dbc317778d54..6a67b2d2e451 100644
--- a/drivers/gpu/drm/sysfb/vesadrm.c
+++ b/drivers/gpu/drm/sysfb/vesadrm.c
@@ -402,7 +402,7 @@ static struct vesadrm_device *vesadrm_device_create(struct drm_driver *drv,
 	const struct screen_info *si;
 	const struct drm_format_info *format;
 	int width, height, stride;
-	u64 vsize;
+	s64 vsize;
 	struct resource resbuf;
 	struct resource *res;
 	struct vesadrm_device *vesa;
@@ -457,8 +457,8 @@ static struct vesadrm_device *vesadrm_device_create(struct drm_driver *drv,
 	if (stride < 0)
 		return ERR_PTR(stride);
 	vsize = drm_sysfb_get_visible_size_si(dev, si, height, stride, resource_size(res));
-	if (!vsize)
-		return ERR_PTR(-EINVAL);
+	if (vsize < 0)
+		return ERR_PTR(vsize);
 
 	drm_dbg(dev, "framebuffer format=%p4cc, size=%dx%d, stride=%d bytes\n",
 		&format->format, width, height, stride);
-- 
2.54.0

