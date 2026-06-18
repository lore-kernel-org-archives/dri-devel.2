Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3593FCD98F2
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 14:13:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B45010E7CC;
	Thu, 18 Jun 2026 14:13:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="gZm6nZqd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WTl9wIlP";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gZm6nZqd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WTl9wIlP";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF27010F2F4
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 14:13:02 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4749B6D2AB;
 Thu, 18 Jun 2026 14:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781791978; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o34Balt7z7UXOJskK1uCf4pL0cfCMU/jkVSHPSmInpg=;
 b=gZm6nZqdIiUC6WkvkOcX0p4/6Z8Kh3M4xQXXvsHQerVCLQ5OaUtUElcQQaRUMwtMIsv1vu
 DBH7ls0ROgLCEl3zgOW6GUxj1JQKs+bnIfA/iaZCOT3Ps64dA2E3kSuYS2DAcypqmaMdxp
 2aY5pD6nYIAvPbFjIJkNfT2CbyXGNn0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781791978;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o34Balt7z7UXOJskK1uCf4pL0cfCMU/jkVSHPSmInpg=;
 b=WTl9wIlPiT1cef4fS1D3xGyHQMZ49/KL0YgpsQV55n/NliFJVH6wnH2g/BuOsSDQjk21kO
 HlZ4G843iY9SMZCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781791978; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o34Balt7z7UXOJskK1uCf4pL0cfCMU/jkVSHPSmInpg=;
 b=gZm6nZqdIiUC6WkvkOcX0p4/6Z8Kh3M4xQXXvsHQerVCLQ5OaUtUElcQQaRUMwtMIsv1vu
 DBH7ls0ROgLCEl3zgOW6GUxj1JQKs+bnIfA/iaZCOT3Ps64dA2E3kSuYS2DAcypqmaMdxp
 2aY5pD6nYIAvPbFjIJkNfT2CbyXGNn0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781791978;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o34Balt7z7UXOJskK1uCf4pL0cfCMU/jkVSHPSmInpg=;
 b=WTl9wIlPiT1cef4fS1D3xGyHQMZ49/KL0YgpsQV55n/NliFJVH6wnH2g/BuOsSDQjk21kO
 HlZ4G843iY9SMZCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E4BB8779A8;
 Thu, 18 Jun 2026 14:12:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GLulNun8M2o8DQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Thu, 18 Jun 2026 14:12:57 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: robin.clark@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
 jesszhan0024@gmail.com, sean@poorly.run, marijn.suijten@somainline.org,
 airlied@gmail.com, simona@ffwll.ch
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, sashiko-reviews@lists.linux.dev,
 Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 4/6] drm/msm: fbdev: Calculate buffer geometry with format
 helpers
Date: Thu, 18 Jun 2026 16:11:35 +0200
Message-ID: <20260618141249.151338-5-tzimmermann@suse.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260618141249.151338-1-tzimmermann@suse.de>
References: <20260618141249.151338-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCPT_COUNT_TWELVE(0.00)[13];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 FREEMAIL_TO(0.00)[oss.qualcomm.com,kernel.org,linux.dev,gmail.com,poorly.run,somainline.org,ffwll.ch];
 RCVD_TLS_ALL(0.00)[];
 R_RATELIMIT(0.00)[to_ip_from(RLqirfcw6gnbcr9a9yhi49fhi6)];
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

Replace the geometry and size calculation in msm's fbdev emulation
with DRM format helpers. This consists of a 4CC lookup from the fbdev
parameters, format lookup, pitch calculation and size calculation.
Then allocate the GEM buffer object for the framebuffer memory from
the calculated size.

Explicitly align the size of the allocated GEM buffer object to full
pages. The contained memory is the framebuffer memory as seen by fbdev.
The page alignment is required for mmap.

v2:
- clarify the page alignment of the buffer size (Dmitry)

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/msm/msm_drv.h   |  7 -------
 drivers/gpu/drm/msm/msm_fbdev.c | 26 ++++++++++++--------------
 2 files changed, 12 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index 01a64a32b843..b21f8971dfa1 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -505,13 +505,6 @@ void msm_hrtimer_work_init(struct msm_hrtimer_work *work,
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
2.54.0

