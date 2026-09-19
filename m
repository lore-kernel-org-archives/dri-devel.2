Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68C45C982ED
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 07:01:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81DE710E3AB;
	Mon, 21 Sep 2026 07:01:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="H9CmsYYM";
	dkim-atps=neutral
Received: from mail-pz2-f32.google.com (mail-pz2-f32.google.com
 [74.125.228.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3A4C10E589
 for <dri-devel@lists.freedesktop.org>; Sat, 19 Sep 2026 22:35:14 +0000 (UTC)
Received: by mail-pz2-f32.google.com with SMTP id
 41be03b00d2f7-cc4d04d73b8so1532226a12.1
 for <dri-devel@lists.freedesktop.org>; Sat, 19 Sep 2026 15:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789857314; x=1790462114; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=kyS13joyy5JXOuXWzEcFnGwNzI5fcdKO60kKLkXIRKw=;
 b=H9CmsYYMdWTo/Xhs23UEA62modAjL2fNxYoLZt4oT48DJiAs0Jp1VBocNJTL2FK0Ix
 dbRulTpmek/kH9h4WBE1UOdoismIyUzM4N3iyy8rUIWJN9RfL8upGFcSJ+1gfMQHXZJT
 e2xNHyASVgiIxEfJ/CEtMvpI0CEmviEM/BVWjb8GXx1YYIz2Rtq7lKeDdbaMWBic5oVE
 q9YGafJnyJsROeNSHGYvGzntVNyTyoO1JQuMdmk2z0TNP+8DsMKjRp37MnIwQlR4pt1W
 c0rbGWFPpx0DwJ1Rx/igeyRyFasLKn+fTqZGUhg0LDoYLsEWdyrIUlxQMR3AySQNCW8y
 T6YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789857314; x=1790462114;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kyS13joyy5JXOuXWzEcFnGwNzI5fcdKO60kKLkXIRKw=;
 b=b3gCXR/vGW/NtyzRApDh2RbJEU90sdUgZrERd2OhDgEfKSEppXOPwX3rRtLcM1U6hU
 wZ9LhhJfxvq5cAipf9o5AoQxCueWJy8oGZwNKO60DjxbIcYElHznT+IuuRPMSJcVH3mn
 SD5QEUb6whxlBH6kmx+xQc6dsrH0Wf0Bt2RZUbAvrpgKq6U/E+DdEk8FJk4GsDg+O+AJ
 /o7jxT8ZROrSnk5PE2haxmN9OzQw8JIWyeQMSOKySzkL/SvWnDqFzYoZdBj4i0qsqPwC
 jooV0ROQNOKmFcoCPbfhX3Z6n7HarhMJiQ5An3Q6kRHS+RhxKZsigul161RmtIrYVri/
 Emug==
X-Gm-Message-State: AFuF++n+tcNC6bwVvsjdYa1ptUFYY82kMVegFTJMkwgLs84lBK5Lv6k8
 XqM+jCueGp48qBfk0EK/CZu5ksVo+rSeBkcplKLHvLHmhvBG1F13NfAp
X-Gm-Gg: AYBFou1XPE6f4IZYC5eKQg2TtsmOeu1EtSMxCzFltqqRZ6ZdGPDBfzsornVCOMP6aMw
 taXjA+MRMJ79sNGkWWo5IxqJknzMb1ITDDwkK56YXRHKybc6oZ4e5XFwD22LwprBhgm5WHBNwK4
 oLDidlU8d0+Kq4QEe8bOBZ7FEUxK/Z+TzYjs2UaKuDgCF+0AIAxaLHRHECBDXWc+F9+UyTqzQuH
 Ej9rrEaFnccNoXvtUS60KdPM6BjOvTqBUDiCBrWQj4wHUufJBvjh/a53ELiNFCJZctt7lXsUTCk
 +70nNxxMAtKAwWGlTG3FjiBb/J4tZ3B+fLzLHM+r/j06JkHuDil1DUbh7na3tIwlI/qW+yjNlED
 4IdYJ+X502OTY/1Yw7+iIVkrNYiIo6JjVyM+gYsNib1sD/uTmzSHgwYbIVkQ4zFEwLcOYFfiOfO
 BMuwtxQbutXf9ixqLRmPMKGHIWy7hX22rn/AILXykgT49iMQse3Z8odTKGVV0mqq08yuCI6cCLo
 St+x6qa8g0jx9RifCbBv1aifrBPVWO859wAtpAYDPSuB6xDNrImIxwqYRvWjR0c+b7XPKQ94jd9
 zfv0/8AFsg==
X-Received: by 2002:a17:90a:ec88:b0:39e:6c69:34dd with SMTP id
 98e67ed59e1d1-39e6c6936f4mr4837765a91.65.1789857314235; 
 Sat, 19 Sep 2026 15:35:14 -0700 (PDT)
Received: from phui-2.c.googlers.com.com
 (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e6c4bc0d2sm6194633a91.12.2026.09.19.15.35.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Sep 2026 15:35:13 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: hansg@kernel.org, tzimmermann@suse.de, simona@ffwll.ch, airlied@redhat.com
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/tiny: fix VRAM/EDID/transfer bounds in bochs, gm12u320,
 pixpaper, and sharp-memory
Date: Sat, 19 Sep 2026 22:35:13 +0000
Message-ID: <20260919223513.3889412-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 21 Sep 2026 07:00:14 +0000
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

Fix framebuffer size, EDID extension count, and transfer buffer bounds
checks across drivers/gpu/drm/tiny/ (bochs.c, gm12u320.c, pixpaper.c,
and sharp-memory.c).

Fixes: 77b8cabf3d52 ("drm/gm12u320: Move driver to drm/tiny")
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
diff --git a/drivers/gpu/drm/tiny/bochs.c b/drivers/gpu/drm/tiny/bochs.c
index e2d957e51505..19d0af677321 100644
--- a/drivers/gpu/drm/tiny/bochs.c
+++ b/drivers/gpu/drm/tiny/bochs.c
@@ -422,6 +422,8 @@ static int bochs_primary_plane_helper_atomic_check(struct drm_plane *plane,
 						   struct drm_atomic_commit *state)
 {
 	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state, plane);
+	struct drm_framebuffer *fb = new_plane_state->fb;
+	struct bochs_device *bochs = to_bochs_device(plane->dev);
 	struct drm_crtc *new_crtc = new_plane_state->crtc;
 	struct drm_crtc_state *new_crtc_state = NULL;
 	int ret;
@@ -438,6 +440,9 @@ static int bochs_primary_plane_helper_atomic_check(struct drm_plane *plane,
 	else if (!new_plane_state->visible)
 		return 0;
 
+	if (fb && (u64)fb->pitches[0] * fb->height > bochs->fb_size)
+		return -EINVAL;
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/tiny/gm12u320.c b/drivers/gpu/drm/tiny/gm12u320.c
index 4ad074337af0..9dfbfc6bb1b6 100644
--- a/drivers/gpu/drm/tiny/gm12u320.c
+++ b/drivers/gpu/drm/tiny/gm12u320.c
@@ -268,12 +268,18 @@ static void gm12u320_copy_fb_to_blocks(struct gm12u320_device *gm12u320)
 	x2 = gm12u320->fb_update.rect.x2;
 	y1 = gm12u320->fb_update.rect.y1;
 	y2 = gm12u320->fb_update.rect.y2;
-	vaddr = gm12u320->fb_update.src_map.vaddr; /* TODO: Use mapping abstraction properly */
+
+	ret = drm_gem_fb_vmap(fb, &gm12u320->fb_update.src_map, NULL);
+	if (ret) {
+		GM12U320_ERR("drm_gem_fb_vmap err: %d\n", ret);
+		goto put_fb;
+	}
+	vaddr = gm12u320->fb_update.src_map.vaddr;
 
 	ret = drm_gem_fb_begin_cpu_access(fb, DMA_FROM_DEVICE);
 	if (ret) {
 		GM12U320_ERR("drm_gem_fb_begin_cpu_access err: %d\n", ret);
-		goto put_fb;
+		goto vunmap_fb;
 	}
 
 	src = vaddr + y1 * fb->pitches[0] + x1 * 4;
@@ -311,6 +317,8 @@ static void gm12u320_copy_fb_to_blocks(struct gm12u320_device *gm12u320)
 	}
 
 	drm_gem_fb_end_cpu_access(fb, DMA_FROM_DEVICE);
+vunmap_fb:
+	drm_gem_fb_vunmap(fb, &gm12u320->fb_update.src_map);
 put_fb:
 	drm_framebuffer_put(fb);
 	gm12u320->fb_update.fb = NULL;
@@ -418,6 +426,7 @@ static void gm12u320_fb_mark_dirty(struct drm_framebuffer *fb,
 	} else {
 		struct drm_rect *rect = &gm12u320->fb_update.rect;
 
+		gm12u320->fb_update.src_map = *map;
 		rect->x1 = min(rect->x1, dirty->x1);
 		rect->y1 = min(rect->y1, dirty->y1);
 		rect->x2 = max(rect->x2, dirty->x2);
@@ -583,8 +592,17 @@ static void gm12u320_pipe_update(struct drm_simple_display_pipe *pipe,
 	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(state);
 	struct drm_rect rect;
 
-	if (drm_atomic_helper_damage_merged(old_state, state, &rect))
+	if (!state->fb) {
+		gm12u320_stop_fb_update(to_gm12u320(pipe->crtc.dev));
+		return;
+	}
+
+	if (drm_atomic_helper_damage_merged(old_state, state, &rect)) {
 		gm12u320_fb_mark_dirty(state->fb, &shadow_plane_state->data[0], &rect);
+	} else if (old_state->fb != state->fb) {
+		drm_rect_init(&rect, 0, 0, state->fb->width, state->fb->height);
+		gm12u320_fb_mark_dirty(state->fb, &shadow_plane_state->data[0], &rect);
+	}
 }
 
 static const struct drm_simple_display_pipe_funcs gm12u320_pipe_funcs = {
diff --git a/drivers/gpu/drm/tiny/pixpaper.c b/drivers/gpu/drm/tiny/pixpaper.c
index d02ac26d007c..475e92c3410e 100644
--- a/drivers/gpu/drm/tiny/pixpaper.c
+++ b/drivers/gpu/drm/tiny/pixpaper.c
@@ -865,7 +865,7 @@ static void pixpaper_plane_atomic_update(struct drm_plane *plane,
 	struct drm_shadow_plane_state *shadow_plane_state =
 		to_drm_shadow_plane_state(plane_state);
 	struct drm_crtc *crtc = plane_state->crtc;
-	struct pixpaper_panel *panel = to_pixpaper_panel(crtc->dev);
+	struct pixpaper_panel *panel = to_pixpaper_panel(plane->dev);
 
 	struct drm_device *drm = &panel->drm;
 	struct drm_framebuffer *fb = plane_state->fb;
@@ -875,6 +875,9 @@ static void pixpaper_plane_atomic_update(struct drm_plane *plane,
 	__le32 *src_pixels = NULL;
 	struct pixpaper_error_ctx err = { .errno_code = 0 };
 
+	if (!crtc || !fb)
+		return;
+
 	if (!drm_dev_enter(drm, &idx))
 		return;
 
diff --git a/drivers/gpu/drm/tiny/sharp-memory.c b/drivers/gpu/drm/tiny/sharp-memory.c
index 7efd7b567f3b..b365e7549666 100644
--- a/drivers/gpu/drm/tiny/sharp-memory.c
+++ b/drivers/gpu/drm/tiny/sharp-memory.c
@@ -595,6 +595,9 @@ static int sharp_memory_probe(struct spi_device *spi)
 		smd->vcom_mode = SHARP_MEMORY_SOFTWARE_VCOM;
 		smd->sw_vcom_signal = kthread_run(sharp_memory_sw_vcom_signal_thread,
 						  smd, "sw_vcom_signal");
+		if (IS_ERR(smd->sw_vcom_signal))
+			return dev_err_probe(dev, PTR_ERR(smd->sw_vcom_signal),
+					     "Failed to start sw_vcom_signal thread\n");
 
 	} else if (!strcmp("external", vcom_mode_str)) {
 		smd->vcom_mode = SHARP_MEMORY_EXTERNAL_VCOM;
@@ -616,15 +619,21 @@ static int sharp_memory_probe(struct spi_device *spi)
 	ret = sharp_memory_pipe_init(drm, smd, sharp_memory_formats,
 				     ARRAY_SIZE(sharp_memory_formats),
 				     NULL);
-	if (ret)
+	if (ret) {
+		if (smd->sw_vcom_signal)
+			kthread_stop(smd->sw_vcom_signal);
 		return dev_err_probe(dev, ret, "Failed to initialize display pipeline.\n");
+	}
 
 	drm_plane_enable_fb_damage_clips(&smd->plane);
 	drm_mode_config_reset(drm);
 
 	ret = drm_dev_register(drm, 0);
-	if (ret)
+	if (ret) {
+		if (smd->sw_vcom_signal)
+			kthread_stop(smd->sw_vcom_signal);
 		return dev_err_probe(dev, ret, "Failed to register drm device.\n");
+	}
 
 	drm_client_setup(drm, NULL);
 
