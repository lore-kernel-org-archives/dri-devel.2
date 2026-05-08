Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ADECCD342F
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 06:48:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB8D110F352;
	Fri,  8 May 2026 06:48:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="UZXE+2GA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="V0g/okx8";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TrEKDGgr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7qhWn4nl";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A66210E1C0
 for <dri-devel@lists.freedesktop.org>; Fri,  8 May 2026 06:48:52 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EF8F866D60;
 Fri,  8 May 2026 06:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1778222931; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cZsaukSwwYwyw2QWtnxk2DA/oVq+do+ykglUmDmglU0=;
 b=UZXE+2GAqQpYAUBBDadgr+DrLzmwSgORYarW37GfRsQR2BeteJc38mxKkPlowhRd+QRa+1
 jAqC4XuvwG9OkQQiKdoFQ1CHFC1K1zG4QHliI61H0gL8ZduMEW8nfhXamB0UOEmHB0rdVZ
 Wwn7RygCo0PpCry1++SZgr2KGEwjSsE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1778222931;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cZsaukSwwYwyw2QWtnxk2DA/oVq+do+ykglUmDmglU0=;
 b=V0g/okx8D6hRitfR5N1Rf5OrXfMj2CleguslH3C8c9QxK1FlX9CkfJZnqwxdMPe4sa0L1U
 5qSHUEQd+M9+RJBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1778222930; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cZsaukSwwYwyw2QWtnxk2DA/oVq+do+ykglUmDmglU0=;
 b=TrEKDGgrzB3TdL5A4LrT1IK15RuW1U2VX7EK/Uw1rIXF9Ml4tN4cw2jM/DM8Lvb0FSQldx
 nQGmMc+gJCYdBxI9rBeeSsbH6M6n0211G9xqdySUZJCD7bAN3iRDcmm7+MsBl4MIu3kAUc
 gG3e/LGQAlrYl2ptnpVPfT2cLPsZHtk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1778222930;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cZsaukSwwYwyw2QWtnxk2DA/oVq+do+ykglUmDmglU0=;
 b=7qhWn4nlvh1kuZYsumA8nyJwpN+IfnRo4iqcqQkrr1MY5/gYc8kZi06owhtsx9YhOVI1Dc
 Hd8su6HtZKi43SBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A6210593A8;
 Fri,  8 May 2026 06:48:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kHAjJ1KH/Wm1cgAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Fri, 08 May 2026 06:48:50 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: inki.dae@samsung.com, sw0312.kim@samsung.com, kyungmin.park@samsung.com,
 m.szyprowski@samsung.com, wens@kernel.org, airlied@gmail.com,
 simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-samsung-soc@vger.kernel.org,
 Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 3/5] drm/exynos: fbdev: Calculate buffer geometry with
 format helpers
Date: Fri,  8 May 2026 08:46:49 +0200
Message-ID: <20260508064842.22689-4-tzimmermann@suse.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260508064842.22689-1-tzimmermann@suse.de>
References: <20260508064842.22689-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-6.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 FREEMAIL_TO(0.00)[samsung.com,kernel.org,gmail.com,ffwll.ch];
 RCPT_COUNT_SEVEN(0.00)[10];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 R_RATELIMIT(0.00)[to_ip_from(RLqirfcw6gnbcr9a9yhi49fhi6)];
 RCVD_TLS_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; FREEMAIL_ENVRCPT(0.00)[gmail.com]
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

Replace the geometry and size calculation in exynos' fbdev emulation
with DRM format helpers. This consists of a 4CC lookup from the fbdev
parameters, format lookup, pitch calculation and size calculation.

Then allocate the GEM buffer object for the framebuffer memory from
the calculated size. Mmap provides the allocated buffer to user space,
so align the buffer size to PAGE_SIZE.

Initialize the fields screen_size and fix.smem_len in struct fb_info
from the size of the allocated buffer object. This is the real size
and can differ from the requested size.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/gpu/drm/exynos/exynos_drm_fbdev.c | 35 ++++++++++++-----------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_fbdev.c b/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
index 1c564edd497e..9225cf1a83c8 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
@@ -60,11 +60,14 @@ static const struct drm_fb_helper_funcs exynos_drm_fbdev_helper_funcs = {
 int exynos_drm_fbdev_driver_fbdev_probe(struct drm_fb_helper *helper,
 					struct drm_fb_helper_surface_size *sizes)
 {
-	struct exynos_drm_gem *exynos_gem;
 	struct drm_device *dev = helper->dev;
 	struct fb_info *info = helper->info;
+	u32 fourcc, pitch;
+	u64 size;
+	const struct drm_format_info *format;
+	struct exynos_drm_gem *exynos_gem;
+	struct drm_gem_object *obj;
 	struct drm_mode_fb_cmd2 mode_cmd = { 0 };
-	unsigned long size;
 	int ret;
 
 	DRM_DEV_DEBUG_KMS(dev->dev,
@@ -72,23 +75,23 @@ int exynos_drm_fbdev_driver_fbdev_probe(struct drm_fb_helper *helper,
 			  sizes->surface_width, sizes->surface_height,
 			  sizes->surface_bpp);
 
-	mode_cmd.width = sizes->surface_width;
-	mode_cmd.height = sizes->surface_height;
-	mode_cmd.pitches[0] = sizes->surface_width * (sizes->surface_bpp >> 3);
-	mode_cmd.pixel_format = drm_mode_legacy_fb_format(sizes->surface_bpp,
-							  sizes->surface_depth);
-
-	size = mode_cmd.pitches[0] * mode_cmd.height;
+	fourcc = drm_mode_legacy_fb_format(sizes->surface_bpp, sizes->surface_depth);
+	format = drm_get_format_info(dev, fourcc, DRM_FORMAT_MOD_LINEAR);
+	pitch = drm_format_info_min_pitch(format, 0, sizes->surface_width);
+	size = ALIGN(pitch * sizes->surface_height, PAGE_SIZE);
 
 	exynos_gem = exynos_drm_gem_create(dev, EXYNOS_BO_WC, size, true);
 	if (IS_ERR(exynos_gem))
 		return PTR_ERR(exynos_gem);
+	obj = &exynos_gem->base;
+
+	mode_cmd.width = sizes->surface_width;
+	mode_cmd.height = sizes->surface_height;
+	mode_cmd.pixel_format = fourcc;
+	mode_cmd.pitches[0] = pitch;
+	mode_cmd.modifier[0] = DRM_FORMAT_MOD_LINEAR;
 
-	helper->fb =
-		exynos_drm_framebuffer_init(dev,
-					    drm_get_format_info(dev, mode_cmd.pixel_format,
-								mode_cmd.modifier[0]),
-					    &mode_cmd, &exynos_gem, 1);
+	helper->fb = exynos_drm_framebuffer_init(dev, format, &mode_cmd, &exynos_gem, 1);
 	if (IS_ERR(helper->fb)) {
 		DRM_DEV_ERROR(dev->dev, "failed to create drm framebuffer.\n");
 		ret = PTR_ERR(helper->fb);
@@ -102,8 +105,8 @@ int exynos_drm_fbdev_driver_fbdev_probe(struct drm_fb_helper *helper,
 
 	info->flags |= FBINFO_VIRTFB;
 	info->screen_buffer = exynos_gem->kvaddr;
-	info->screen_size = size;
-	info->fix.smem_len = size;
+	info->screen_size = obj->size;
+	info->fix.smem_len = obj->size;
 
 	return 0;
 
-- 
2.54.0

