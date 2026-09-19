Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B5B9C982F5
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 07:01:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2DD410E458;
	Mon, 21 Sep 2026 07:01:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TftWTSY1";
	dkim-atps=neutral
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7082D10E1B6
 for <dri-devel@lists.freedesktop.org>; Sat, 19 Sep 2026 21:52:32 +0000 (UTC)
Received: by mail-pj2-f12.google.com with SMTP id
 98e67ed59e1d1-396ccd78e6eso718189a91.0
 for <dri-devel@lists.freedesktop.org>; Sat, 19 Sep 2026 14:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789854752; x=1790459552; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=SFfjjVYuyX+ZWtIQTKnBoyatvatssXhZQujt0x3z3r0=;
 b=TftWTSY1L8kQJqSk2EcKKDI0Rmr54XccfxZ5pHK7rwOCG5AEQISWEoT1bC1wBOeZcr
 cie/7b021xM0WTAcNcDWBFIrn4cpSyBfGJ599TVmsnHKuscfz2q9QWFKGUCZeHqa1E2c
 EjX4mTJSwKbQUMfi4Pe4HSSMiZkUxXXuvafOsaSkhdiii9pFCPYOXMGbwu13kHsp0khl
 +a5o4JPgut0YCk2lZy+PX+cCvmhPDJ87nyMJ8zy8mpNCH8Yub0qja+ZewrB3X4/HlxAr
 13YTxyyfbhfGJM18L7Jk6aU2XPPDc1OO7piPb2y0XZyD6twOk73yTRJ1z3ktVGKIinm9
 DKrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789854752; x=1790459552;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SFfjjVYuyX+ZWtIQTKnBoyatvatssXhZQujt0x3z3r0=;
 b=Wh+EhhBnNJqMmcUltdJsUCfzXjGQLYfJ1vem/tZ7FcNtV8gtxY4PdxMp9cuiBvP1sA
 BVRf3P0pBEoRe4ql/xhAEy85+xeE+GhuSBnPgLNiska7hHvhWV1vAUsTHcOnUYip+o6+
 cX0D8GXiv5nzFjgsgeK8JkQdYhtMaY2i+SYiUZpJCSNpEj2sJtxxw7cuRfpg30GVctQG
 mYbIgKoK5KREhVF9MVohYlqNbHVgNQ/Dlv3bOXq6E9xzojud9jNXqTY+FqQ9mbHBrD4l
 wuk26jnKH2gJ+zItDAPg6z16v1Fh0gV798RdVh48bDG0MrL5fN+XYwP36xNt0sfO6wUW
 UaIg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzPR9zhjxBahX/u+KiVf50jCoVUPxmmDlbMqxnihdRT9orq111Dupru9tifDOjpqD4eq+gdnkGj6to=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lT4zGhxdZTK8RGMUhlU3qXdMPMp6v8PO9KSlNqtqUpY3TIJIv5
 mOaDukx2qQvByd9Gb7AZ0KnSsz+dl87y/qPaI+WeCJdkQblCBsWAKhtg
X-Gm-Gg: AYBFou3y8ROiqfKDSfp/rDN/3DO/a4mglXAFj+JZYXiJ1FmcSkmSIzjX/CGriyby983
 YdAnDxHhdxkzt61Y0/Sn9VUWXzN5hfFwqh0R/hW2sI8XU/8HPvzo7l4LTn5lrAoxjzojCnessQG
 O5cWzbVAdjcqm66mKF3KZN96kIFacI7aqKPdQvGtgay8ApwFWKDH1FMXoMzyjoHRXOmGLevOv6P
 zq+Tbih9TaMidZvZ5ocx1VtSyoGgOzd5D568Yx3mla93VLnxjxU8qZGtmCkBqzCVioXIBl9Y5DD
 gSNR2dsX7nZZXU7VTyCwLzsD5vaXj0uW12ZgDJbVfNIVsyFlcsg1E7ucDt+jVQ4rNQLSLz/Oexq
 lMuvfTBst6d9NBMl3crFE+yYjSOOyr6bQoVyWBxGtT0bq9v6FbfOmwaxUM5dIKEY9/6SnZue+4n
 ypCJFXwytv7XxszdkI+EcvK5CVOw8jmC/F+qkoL20k7uldTmpXp3duz6uuB1bYFCxDi1JK4/LyQ
 TXyCNg54BCRQ9A3BMdJH2B8JF/CtwnVK2t0iVg1VdQRD/Ml5wACJEnyLlXH7C2OmuD3in70W99i
 SjsyZWvcIZnZ8MQTzbl9
X-Received: by 2002:a17:90b:3908:b0:39e:3d38:7ef1 with SMTP id
 98e67ed59e1d1-39e5565236dmr6546738a91.10.1789854751817; 
 Sat, 19 Sep 2026 14:52:31 -0700 (PDT)
Received: from phui-2.c.googlers.com.com
 (67.51.127.34.bc.googleusercontent.com. [34.127.51.67])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a02526e27dsm1883481a91.0.2026.09.19.14.52.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Sep 2026 14:52:31 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: airlied@redhat.com, kraxel@redhat.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, simona@ffwll.ch
Cc: virtualization@lists.linux.dev, spice-devel@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/qxl: fix cursor OOB read, dirty-rect bounds,
 and monitors double-fetch
Date: Sat, 19 Sep 2026 21:52:30 +0000
Message-ID: <20260919215230.3469792-1-benquike@gmail.com>
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

Fix out-of-bounds accesses and missing bounds checks in the QXL display
and dirty-framebuffer drawing paths:

1. In qxl_create_cursor() and qxl_cursor_atomic_check(), verify that the
   cursor GEM BO is at least 64 * 64 * 4 bytes (16 KiB) before copying
   into the QXL cursor command, and zero-initialize the stack struct
   qxl_cursor header.
2. In qxl_draw_dirty_fb() and qxl_framebuffer_surface_dirty(), validate
   clip coordinates against the framebuffer dimensions and negative x/y
   offsets before computing pixel pointers, and handle odd clip counts
   when DRM_MODE_FB_DIRTY_ANNOTATE_COPY is set.
3. In qxl_display_copy_rom_client_monitors_config(), read
   qdev->rom->client_monitors_config.count once with READ_ONCE() and
   clamp num_monitors to ARRAY_SIZE(heads).
4. In qxl_prepare_shadow(), propagate qxl_bo_create() allocation failures
   to qxl_plane_prepare_fb().

Fixes: f64122c1f6ad ("drm: add new QXL driver. (v1.4)")
Fixes: b4b27f08f9f9 ("drm/qxl: rework cursor plane")
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index 0719fc6a52d5..0fc14312e027 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -82,7 +82,7 @@ static int qxl_display_copy_rom_client_monitors_config(struct qxl_device *qdev)
 	uint32_t crc;
 	int status = MONITORS_CONFIG_UNCHANGED;
 
-	num_monitors = qdev->rom->client_monitors_config.count;
+	num_monitors = READ_ONCE(qdev->rom->client_monitors_config.count);
 	crc = crc32(0, (const uint8_t *)&qdev->rom->client_monitors_config,
 		  sizeof(qdev->rom->client_monitors_config));
 	if (crc != qdev->rom->client_monitors_config_crc)
@@ -95,9 +95,9 @@ static int qxl_display_copy_rom_client_monitors_config(struct qxl_device *qdev)
 		DRM_DEBUG_KMS("client monitors list will be truncated: %d < %d\n",
 			      qxl_num_crtc, num_monitors);
 		num_monitors = qxl_num_crtc;
-	} else {
-		num_monitors = qdev->rom->client_monitors_config.count;
 	}
+	if (num_monitors > ARRAY_SIZE(qdev->rom->client_monitors_config.heads))
+		num_monitors = ARRAY_SIZE(qdev->rom->client_monitors_config.heads);
 	if (qdev->client_monitors_config
 	      && (num_monitors != qdev->client_monitors_config->count)) {
 		status = MONITORS_CONFIG_MODIFIED;
@@ -454,6 +454,9 @@ static int qxl_framebuffer_surface_dirty(struct drm_framebuffer *fb,
 		norect.x2 = fb->width;
 		norect.y2 = fb->height;
 	} else if (flags & DRM_MODE_FB_DIRTY_ANNOTATE_COPY) {
+		if (num_clips < 2)
+			goto out_lock_end;
+		clips++;
 		num_clips /= 2;
 		inc = 2; /* skip source rects */
 	}
@@ -601,7 +604,7 @@ static struct qxl_bo *qxl_create_cursor(struct qxl_device *qdev,
 	struct qxl_cursor cursor;
 	int ret;
 
-	if (!user_bo)
+	if (!user_bo || user_bo->tbo.base.size < size)
 		return NULL;
 
 	ret = qxl_bo_create(qdev, sizeof(struct qxl_cursor) + size,
@@ -618,6 +621,7 @@ static struct qxl_bo *qxl_create_cursor(struct qxl_device *qdev,
 	if (ret)
 		goto err_unmap;
 
+	memset(&cursor, 0, sizeof(cursor));
 	cursor.header.unique = 0;
 	cursor.header.type = SPICE_CURSOR_TYPE_ALPHA;
 	cursor.header.width = 64;
@@ -819,10 +823,11 @@ static void qxl_calc_dumb_shadow(struct qxl_device *qdev,
 		DRM_DEBUG("%dx%d\n", surf->width, surf->height);
 }
 
-static void qxl_prepare_shadow(struct qxl_device *qdev, struct qxl_bo *user_bo,
-			       int crtc_index)
+static int qxl_prepare_shadow(struct qxl_device *qdev, struct qxl_bo *user_bo,
+			      int crtc_index)
 {
 	struct qxl_surface surf;
+	int ret;
 
 	qxl_update_dumb_head(qdev, crtc_index,
 			     user_bo);
@@ -836,9 +841,11 @@ static void qxl_prepare_shadow(struct qxl_device *qdev, struct qxl_bo *user_bo,
 				(&qdev->dumb_shadow_bo->tbo.base);
 			qdev->dumb_shadow_bo = NULL;
 		}
-		qxl_bo_create(qdev, surf.height * surf.stride,
-			      true, true, QXL_GEM_DOMAIN_SURFACE, 0,
-			      &surf, &qdev->dumb_shadow_bo);
+		ret = qxl_bo_create(qdev, surf.height * surf.stride,
+				    true, true, QXL_GEM_DOMAIN_SURFACE, 0,
+				    &surf, &qdev->dumb_shadow_bo);
+		if (ret)
+			return ret;
 	}
 	if (user_bo->shadow != qdev->dumb_shadow_bo) {
 		if (user_bo->shadow) {
@@ -851,6 +858,7 @@ static void qxl_prepare_shadow(struct qxl_device *qdev, struct qxl_bo *user_bo,
 		user_bo->shadow = qdev->dumb_shadow_bo;
 		qxl_bo_pin(user_bo->shadow);
 	}
+	return 0;
 }
 
 static int qxl_plane_prepare_fb(struct drm_plane *plane,
@@ -869,7 +877,9 @@ static int qxl_plane_prepare_fb(struct drm_plane *plane,
 
 	if (plane->type == DRM_PLANE_TYPE_PRIMARY &&
 	    user_bo->is_dumb) {
-		qxl_prepare_shadow(qdev, user_bo, new_state->crtc->index);
+		ret = qxl_prepare_shadow(qdev, user_bo, new_state->crtc->index);
+		if (ret)
+			return ret;
 	}
 
 	if (plane->type == DRM_PLANE_TYPE_CURSOR &&
@@ -919,7 +929,25 @@ static const uint32_t qxl_cursor_plane_formats[] = {
 	DRM_FORMAT_ARGB8888,
 };
 
+static int qxl_cursor_atomic_check(struct drm_plane *plane,
+				   struct drm_atomic_commit *state)
+{
+	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state,
+										 plane);
+	struct drm_framebuffer *fb = new_plane_state->fb;
+
+	if (!fb)
+		return 0;
+
+	if (fb->width != 64 || fb->height != 64 ||
+	    !fb->obj[0] || fb->obj[0]->size < 64 * 64 * 4)
+		return -EINVAL;
+
+	return 0;
+}
+
 static const struct drm_plane_helper_funcs qxl_cursor_helper_funcs = {
+	.atomic_check = qxl_cursor_atomic_check,
 	.atomic_update = qxl_cursor_atomic_update,
 	.atomic_disable = qxl_cursor_atomic_disable,
 	.prepare_fb = qxl_plane_prepare_fb,
diff --git a/drivers/gpu/drm/qxl/qxl_draw.c b/drivers/gpu/drm/qxl/qxl_draw.c
index 3a3e127ce297..302c17d87d1c 100644
--- a/drivers/gpu/drm/qxl/qxl_draw.c
+++ b/drivers/gpu/drm/qxl/qxl_draw.c
@@ -154,27 +154,40 @@ void qxl_draw_dirty_fb(struct qxl_device *qdev,
 	struct qxl_drm_image *dimage;
 	int ret;
 
-	ret = alloc_drawable(qdev, &release);
-	if (ret)
-		return;
-
-	clips->x1 += dumb_shadow_offset;
-	clips->x2 += dumb_shadow_offset;
-
-	left = clips->x1;
-	right = clips->x2;
+	left = clips->x1 + dumb_shadow_offset;
+	right = clips->x2 + dumb_shadow_offset;
 	top = clips->y1;
 	bottom = clips->y2;
 
 	/* skip the first clip rect */
 	for (i = 1, clips_ptr = clips + inc;
 	     i < num_clips; i++, clips_ptr += inc) {
-		left = min_t(int, left, (int)clips_ptr->x1);
-		right = max_t(int, right, (int)clips_ptr->x2);
+		left = min_t(int, left, (int)clips_ptr->x1 + dumb_shadow_offset);
+		right = max_t(int, right, (int)clips_ptr->x2 + dumb_shadow_offset);
 		top = min_t(int, top, (int)clips_ptr->y1);
 		bottom = max_t(int, bottom, (int)clips_ptr->y2);
 	}
 
+	if (dumb_shadow_offset < 0 || dumb_shadow_offset > INT_MAX - fb->width)
+		return;
+
+	left = clamp_t(int, left, dumb_shadow_offset,
+		       dumb_shadow_offset + fb->width);
+	right = clamp_t(int, right, dumb_shadow_offset,
+			dumb_shadow_offset + fb->width);
+	top = clamp_t(int, top, 0, fb->height);
+	bottom = clamp_t(int, bottom, 0, fb->height);
+
+	if (left >= right || top >= bottom)
+		return;
+
+	if ((size_t)bottom * stride > fb->obj[0]->size)
+		return;
+
+	ret = alloc_drawable(qdev, &release);
+	if (ret)
+		return;
+
 	width = right - left;
 	height = bottom - top;
 
