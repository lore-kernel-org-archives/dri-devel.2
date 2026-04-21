Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BB9AF8FA71
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 12:57:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D384C10EC91;
	Tue, 21 Apr 2026 12:57:48 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E7A410EC81
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 12:57:46 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6B82B6A8EF;
 Tue, 21 Apr 2026 12:57:41 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1358C593AF;
 Tue, 21 Apr 2026 12:57:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iMdNA0V052labwAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Tue, 21 Apr 2026 12:57:41 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: robin.clark@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
 jesszhan0024@gmail.com, sean@poorly.run, marijn.suijten@somainline.org,
 airlied@gmail.com, simona@ffwll.ch
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 4/6] drm/msm: fbdev: Calculate buffer geometry with format
 helpers
Date: Tue, 21 Apr 2026 14:51:17 +0200
Message-ID: <20260421125733.209568-5-tzimmermann@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260421125733.209568-1-tzimmermann@suse.de>
References: <20260421125733.209568-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Queue-Id: 6B82B6A8EF
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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

Replace the geometry and size calculation in msm's fbdev emulation
with DRM format helpers. This consists of a 4CC lookup from the fbdev
parameters, format lookup, pitch calculation and size calculation.
Then allocate the GEM buffer object for the framebuffer memory from
the calculated size.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/msm/msm_drv.h   |  7 -------
 drivers/gpu/drm/msm/msm_fbdev.c | 26 ++++++++++++--------------
 2 files changed, 12 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index b3173fa4d222..00c50d7437d6 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -509,13 +509,6 @@ void msm_hrtimer_work_init(struct msm_hrtimer_work *work,
 #define DBG(fmt, ...) DRM_DEBUG_DRIVER(fmt"\n", ##__VA_ARGS__)
 #define VERB(fmt, ...) if (0) DRM_DEBUG_DRIVER(fmt"\n", ##__VA_ARGS__)
 
-static inline int align_pitch(int width, int bpp)
-{
-	int bytespp = (bpp + 7) / 8;
-	/* adreno needs pitch aligned to 32 pixels: */
-	return bytespp * ALIGN(width, 32);
-}
-
 /* for the generated headers: */
 #define INVALID_IDX(idx) ({BUG(); 0;})
 #define fui(x)                ({BUG(); 0;})
diff --git a/drivers/gpu/drm/msm/msm_fbdev.c b/drivers/gpu/drm/msm/msm_fbdev.c
index 1eb0368a6d07..5532c5779f17 100644
--- a/drivers/gpu/drm/msm/msm_fbdev.c
+++ b/drivers/gpu/drm/msm/msm_fbdev.c
@@ -95,23 +95,25 @@ int msm_fbdev_driver_fbdev_probe(struct drm_fb_helper *helper,
 	struct fb_info *fbi = helper->info;
 	struct drm_mode_fb_cmd2 mode_cmd = { };
 	struct drm_framebuffer *fb = NULL;
+	const struct drm_format_info *format;
+	u32 fourcc, pitch;
+	u64 size;
 	struct drm_gem_object *bo;
 	uint64_t paddr;
-	uint32_t format;
-	int ret, pitch;
-	int size;
-
-	format = drm_mode_legacy_fb_format(sizes->surface_bpp, sizes->surface_depth);
+	int ret;
 
 	DBG("create fbdev: %dx%d@%d (%dx%d)", sizes->surface_width,
 			sizes->surface_height, sizes->surface_bpp,
 			sizes->fb_width, sizes->fb_height);
 
-	pitch = align_pitch(sizes->surface_width, sizes->surface_bpp);
+	fourcc = drm_mode_legacy_fb_format(sizes->surface_bpp, sizes->surface_depth);
+	format = drm_get_format_info(dev, fourcc, DRM_FORMAT_MOD_LINEAR);
+	/* adreno needs pitch aligned to 32 pixels: */
+	pitch = drm_format_info_min_pitch(format, 0, ALIGN(sizes->surface_width, 32));
+	size = ALIGN(pitch * sizes->surface_height, PAGE_SIZE);
 
 	/* allocate backing bo */
-	size = pitch * sizes->surface_height;
-	DBG("allocating %d bytes for fb %d", size, dev->primary->index);
+	DBG("allocating %llu bytes for fb %d", size, dev->primary->index);
 	bo = msm_gem_new(dev, size, MSM_BO_SCANOUT | MSM_BO_WC | MSM_BO_STOLEN);
 	if (IS_ERR(bo)) {
 		drm_warn(dev, "could not allocate stolen bo\n");
@@ -125,16 +127,12 @@ int msm_fbdev_driver_fbdev_probe(struct drm_fb_helper *helper,
 
 	msm_gem_object_set_name(bo, "stolenfb");
 
-	mode_cmd.pixel_format = format;
+	mode_cmd.pixel_format = fourcc;
 	mode_cmd.width = sizes->surface_width;
 	mode_cmd.height = sizes->surface_height;
 	mode_cmd.pitches[0] = pitch;
-	mode_cmd.modifier[0] = DRM_FORMAT_MOD_LINEAR;
 
-	fb = msm_framebuffer_init(dev,
-				  drm_get_format_info(dev, mode_cmd.pixel_format,
-						      mode_cmd.modifier[0]),
-				  &mode_cmd, &bo);
+	fb = msm_framebuffer_init(dev, format, &mode_cmd, &bo);
 	if (IS_ERR(fb)) {
 		drm_err(dev, "failed to allocate fb\n");
 		ret = PTR_ERR(fb);
-- 
2.53.0

