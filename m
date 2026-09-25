Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51D46C98321
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 07:32:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44D6E10F91F;
	Fri, 25 Sep 2026 07:30:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RUGFcFrm";
	dkim-atps=neutral
Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com
 [74.125.230.205])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E69C310E70C
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 03:30:21 +0000 (UTC)
Received: by mail-qk2-f13.google.com with SMTP id
 d75a77b69052e-5309a20a55bso5363641cf.1
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 20:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790307021; x=1790911821; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=y1bT3lEzwlBoiYeaFeeWohd1A7XVi8JjrPv06TrtuZg=;
 b=RUGFcFrmcjYkmhdz3+i2FUpYenDOMzmbdZ9UFaXzsui4AUQA+m93gEMjox+Zwf/Jfw
 puWoVanrAXuzeGV0LgyQz0K/L3D7A37AVa+Vd2ngmOP0DRqGW/VbahulXgbQuYGBER/e
 lym+J4DZLN7F6v7Uev7PZ1rOmEFi8LxmHi69tXd3Wp43fh/7Q7dpe3lcCJz8B03ODP5w
 C0pWhNYB+vCChcFEI46YqF/VsK+2QcGFKI4WcdZU4uEAxmg8p+DO8v1AFbO4+gpyako2
 1F5GyGqoBXYga7Dl7xFmWHlB7Bl9CN9ZyhhCQdA7SXT0zrRl6f5xuQR7aRATBmkbkvrw
 JJ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790307021; x=1790911821;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=y1bT3lEzwlBoiYeaFeeWohd1A7XVi8JjrPv06TrtuZg=;
 b=MzhbJGsM09bEFak+mwljX8yhzuIgDgD84FFSLsP38IWXDYb/sWWqblmYYmmUCfHE6s
 IMy9dpvCc6/qSwfXxVZp5nQZ4ntfpdoUkXAlu1SFib6y9P7GVeJWIzH/q9Nbcsde6uiw
 W7+xvv8YQH7NpocvDDUqF3DJZO/c9HO8d6fexnp4qHFjejXUdkP4r98OUWgJ4ElcWLpH
 RUzEytWDvJ0Jn+ylTqe+2c7S8j+54yzD47MgAL9pGcuc7uemMVBTUN1BHn4WvGnfwUAU
 0a/M52gzMMZaroDbAHCa3GTack0kEuYQvlrK88SC23Q1LAK/o/yn9L0pic6eXMFghS58
 v8hw==
X-Gm-Message-State: AFuF++n+4d062KvBgAkjBy8iK2wh9wT6WvD4YmkJlKqqRtyo9ztaTosM
 n0GksfpiCilq3vT+PrRtgn3YRhOGoheKSGyJ0CuO+duM26krd0FHg/6eL8uB1Oiow3w=
X-Gm-Gg: AYBFou09YIKAYniAodWwF/NmogXuX4teAQqOyazRuZiucYWV8lvLrf0VuQ1z5INrxdr
 hkhRKpifiyiTBE9QKfzxDfDrWzMUH8FTtOEf8voZO9lLNxxpiLLsQyc8D69UTvFSIKFBE3161cF
 d3d4zPn9VpP0apz0friRobo+kw0fnndgueyFqDMzCBHtZyMBRAmyRwA7sxCx0sEAlX05N6zw5i8
 fAoh15wb1iZ4nxpJTcCDXC6VBPgm1PAUw6eKAVzrlzrQWf/T3Ln4Wbgjg1mO1X9CSdVDWL886Bn
 6k2a0miOhHjVeMaZsD+1+a8xW+BmEhiIrZvwM37A2JngCC0V9KZj0bpNHHstHVXynB5sHhJZPTc
 O3Kch0jUFrgiva0qRaGlRGBbcN/NLG/or0LxLtvsxiXFXxlWuY9cPDtpsKgY4fADLP08nj3UAkr
 42x8ld4RiGyD+tX7Cl/7JrrUUTK25A1CSb03ROH6H4dy4dHHDzyby+ZUPfr15+EH9xqPdHWUszo
 lCADzsRD5YAncAobkZgKiW/EC4tS+ppOOErXADK0qUveTnGe7jJJPXCYXeBYhsP
X-Received: by 2002:a05:622a:1392:b0:532:9f90:3f70 with SMTP id
 d75a77b69052e-5330b5a56d7mr23799041cf.10.1790307020648; 
 Thu, 24 Sep 2026 20:30:20 -0700 (PDT)
Received: from localhost.localdomain ([2600:4040:29f7:9600:b44c:c4c:9e3:10a8])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5330c0e16easm7031841cf.29.2026.09.24.20.30.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 24 Sep 2026 20:30:20 -0700 (PDT)
From: Dillon Amburgey <dillona@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: airlied@redhat.com, airlied@gmail.com, kraxel@redhat.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 simona@ffwll.ch, virtualization@lists.linux.dev,
 spice-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/qxl: size packed dumb heads from the plane source
Date: Thu, 24 Sep 2026 23:30:11 -0400
Message-ID: <20260925033011.12560-1-dillona@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260924025222.6077-1-dillona@gmail.com>
References: <20260924025222.6077-1-dillona@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 25 Sep 2026 07:30:44 +0000
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

QXL packs per-CRTC dumb buffers into a single primary surface.
qxl_update_dumb_head() recorded each dumb BO allocation (bo->surf)
instead of the plane source rectangle. Scanning 1280x800 from a
2048x1024 dumb framebuffer beside a 1024x768 head therefore created
a 3072x1024 primary and placed head 1 at +2048, rather than 2304x800
with head 1 at +1280.

Use src_w/src_h when building the packed shadow, and copy only that
source rectangle into it. Place that rectangle at the packed origin:
crtc->x and crtc->y are the plane source position, so adding them to
the packed offset publishes the head past the end of the primary.
When the shadow is reallocated, copy the other active dumb heads from
their current framebuffers. DRM_IOCTL_MODE_DIRTYFB intersects each
clip with the plane source and uses that same origin, so a dirty
update of one head is not painted at (0, 0).

Fixes: 90adda2ce898 ("drm/qxl: cover all crtcs in shadow bo.")
Assisted-by: LLM sparse
Signed-off-by: Dillon Amburgey <dillona@gmail.com>
---
Changes in v2:
- Place each source rectangle at the packed origin. crtc->x and
  crtc->y are the plane source position, so adding them published
  head 1 at +2560 on a 2304-wide primary. A shadow primary now
  reports dumb_heads[i].x and .y. A shared framebuffer with head 1
  scanning at x=1280 now reports +1280.
- A non-zero source y is no longer the destination y. The copy reads
  at src_y and writes at dumb_heads[i].y. A 1280x800 source starting
  at y=200 is drawn at the top of the primary.
- Replacing the shadow recopies the other active dumb heads from
  their current framebuffers. The failure was stale pixels, not a
  cleared head: after recoloring head 0 and enabling head 1, head 0
  kept the old color until this recopy.
- DRM_IOCTL_MODE_DIRTYFB intersects the clip with the plane source
  and uses that same origin. A dirty update of head 1 no longer
  paints that buffer at (0, 0).

 drivers/gpu/drm/qxl/qxl_display.c | 132 ++++++++++++++++++++++++------
 drivers/gpu/drm/qxl/qxl_draw.c    |   6 +-
 drivers/gpu/drm/qxl/qxl_drv.h     |   3 +-
 3 files changed, 113 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index 0719fc6a52d5..d01504332bc8 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -348,8 +348,10 @@ static void qxl_crtc_update_monitors_config(struct drm_crtc *crtc,
 		head.y = crtc->y;
 		if (qdev->monitors_config->count < i + 1)
 			qdev->monitors_config->count = i + 1;
-		if (qdev->primary_bo == qdev->dumb_shadow_bo)
-			head.x += qdev->dumb_heads[i].x;
+		if (qdev->primary_bo == qdev->dumb_shadow_bo) {
+			head.x = qdev->dumb_heads[i].x;
+			head.y = qdev->dumb_heads[i].y;
+		}
 	} else if (i > 0) {
 		head.width = 0;
 		head.height = 0;
@@ -458,8 +460,47 @@ static int qxl_framebuffer_surface_dirty(struct drm_framebuffer *fb,
 		inc = 2; /* skip source rects */
 	}
 
-	qxl_draw_dirty_fb(qdev, fb, qobj, flags, color,
-			  clips, num_clips, inc, 0);
+	if (qobj->shadow) {
+		struct drm_crtc *crtc;
+		unsigned int n;
+
+		drm_for_each_crtc(crtc, &qdev->ddev) {
+			struct drm_plane_state *st;
+			u32 sx, sy, sw, sh;
+
+			st = crtc->primary->state;
+			if (st->fb != fb ||
+			    !qdev->dumb_heads[crtc->index].width)
+				continue;
+			sx = st->src_x >> 16;
+			sy = st->src_y >> 16;
+			sw = st->src_w >> 16;
+			sh = st->src_h >> 16;
+			for (n = 0; n < num_clips; n++) {
+				struct drm_clip_rect *in = clips + n * inc;
+				struct drm_clip_rect c;
+				u32 x1 = max_t(u32, in->x1, sx);
+				u32 y1 = max_t(u32, in->y1, sy);
+				u32 x2 = min_t(u32, in->x2, sx + sw);
+				u32 y2 = min_t(u32, in->y2, sy + sh);
+
+				if (x1 >= x2 || y1 >= y2)
+					continue;
+				c.x1 = x1;
+				c.y1 = y1;
+				c.x2 = x2;
+				c.y2 = y2;
+				qxl_draw_dirty_fb(qdev, fb, qobj, flags, color,
+						  &c, 1, 1,
+						  qdev->dumb_heads[crtc->index].x - sx,
+						  (int)qdev->dumb_heads[crtc->index].y -
+						  (int)sy);
+			}
+		}
+	} else {
+		qxl_draw_dirty_fb(qdev, fb, qobj, flags, color,
+				  clips, num_clips, inc, 0, 0);
+	}
 
 out_lock_end:
 	DRM_MODESET_LOCK_ALL_END(fb->dev, ctx, ret);
@@ -662,6 +703,37 @@ static void qxl_free_cursor(struct qxl_bo *cursor_bo)
 	qxl_bo_unref(&cursor_bo);
 }
 
+static void qxl_redraw_other_dumb_heads(struct qxl_device *qdev, int skip)
+{
+	struct drm_crtc *crtc;
+
+	drm_for_each_crtc(crtc, &qdev->ddev) {
+		struct drm_plane_state *st;
+		struct qxl_bo *other;
+		struct drm_clip_rect clip;
+		u32 sx, sy;
+
+		if (crtc->index == skip ||
+		    !qdev->dumb_heads[crtc->index].width)
+			continue;
+		st = crtc->primary->state;
+		if (!st->fb)
+			continue;
+		other = gem_to_qxl_bo(st->fb->obj[0]);
+		if (!other->is_dumb)
+			continue;
+		sx = st->src_x >> 16;
+		sy = st->src_y >> 16;
+		clip.x1 = sx;
+		clip.y1 = sy;
+		clip.x2 = sx + (st->src_w >> 16);
+		clip.y2 = sy + (st->src_h >> 16);
+		qxl_draw_dirty_fb(qdev, st->fb, other, 0, 0, &clip, 1, 1,
+				  qdev->dumb_heads[crtc->index].x - sx,
+				  (int)qdev->dumb_heads[crtc->index].y - (int)sy);
+	}
+}
+
 static void qxl_primary_atomic_update(struct drm_plane *plane,
 				      struct drm_atomic_commit *state)
 {
@@ -670,13 +742,18 @@ static void qxl_primary_atomic_update(struct drm_plane *plane,
 	struct qxl_device *qdev = to_qxl(plane->dev);
 	struct qxl_bo *bo = gem_to_qxl_bo(new_state->fb->obj[0]);
 	struct qxl_bo *primary;
-	struct drm_clip_rect norect = {
-	    .x1 = 0,
-	    .y1 = 0,
-	    .x2 = new_state->fb->width,
-	    .y2 = new_state->fb->height
-	};
+	struct drm_clip_rect norect;
 	uint32_t dumb_shadow_offset = 0;
+	int y_off = 0;
+	u32 src_x = new_state->src_x >> 16;
+	u32 src_y = new_state->src_y >> 16;
+	u32 src_w = new_state->src_w >> 16;
+	u32 src_h = new_state->src_h >> 16;
+
+	norect.x1 = src_x;
+	norect.y1 = src_y;
+	norect.x2 = src_x + src_w;
+	norect.y2 = src_y + src_h;
 
 	primary = bo->shadow ? bo->shadow : bo;
 
@@ -687,12 +764,19 @@ static void qxl_primary_atomic_update(struct drm_plane *plane,
 		qxl_primary_apply_cursor(qdev, plane->state);
 	}
 
-	if (bo->is_dumb)
+	if (bo->is_dumb) {
 		dumb_shadow_offset =
-			qdev->dumb_heads[new_state->crtc->index].x;
+			qdev->dumb_heads[new_state->crtc->index].x - src_x;
+		y_off = (int)qdev->dumb_heads[new_state->crtc->index].y -
+			(int)src_y;
+	}
 
 	qxl_draw_dirty_fb(qdev, new_state->fb, bo, 0, 0, &norect, 1, 1,
-			  dumb_shadow_offset);
+			  dumb_shadow_offset, y_off);
+	if (qdev->dumb_shadow_needs_redraw) {
+		qdev->dumb_shadow_needs_redraw = false;
+		qxl_redraw_other_dumb_heads(qdev, new_state->crtc->index);
+	}
 }
 
 static void qxl_primary_atomic_disable(struct drm_plane *plane,
@@ -764,18 +848,14 @@ static void qxl_cursor_atomic_disable(struct drm_plane *plane,
 	qcrtc->cursor_bo = NULL;
 }
 
-static void qxl_update_dumb_head(struct qxl_device *qdev,
-				 int index, struct qxl_bo *bo)
+static void qxl_update_dumb_head(struct qxl_device *qdev, int index,
+				 struct qxl_bo *bo, uint32_t width,
+				 uint32_t height)
 {
-	uint32_t width, height;
-
 	if (index >= qdev->monitors_config->max_allowed)
 		return;
 
-	if (bo && bo->is_dumb) {
-		width = bo->surf.width;
-		height = bo->surf.height;
-	} else {
+	if (!bo || !bo->is_dumb) {
 		width = 0;
 		height = 0;
 	}
@@ -820,12 +900,11 @@ static void qxl_calc_dumb_shadow(struct qxl_device *qdev,
 }
 
 static void qxl_prepare_shadow(struct qxl_device *qdev, struct qxl_bo *user_bo,
-			       int crtc_index)
+			       int crtc_index, uint32_t width, uint32_t height)
 {
 	struct qxl_surface surf;
 
-	qxl_update_dumb_head(qdev, crtc_index,
-			     user_bo);
+	qxl_update_dumb_head(qdev, crtc_index, user_bo, width, height);
 	qxl_calc_dumb_shadow(qdev, &surf);
 	if (!qdev->dumb_shadow_bo ||
 	    qdev->dumb_shadow_bo->surf.width  != surf.width ||
@@ -839,6 +918,7 @@ static void qxl_prepare_shadow(struct qxl_device *qdev, struct qxl_bo *user_bo,
 		qxl_bo_create(qdev, surf.height * surf.stride,
 			      true, true, QXL_GEM_DOMAIN_SURFACE, 0,
 			      &surf, &qdev->dumb_shadow_bo);
+		qdev->dumb_shadow_needs_redraw = true;
 	}
 	if (user_bo->shadow != qdev->dumb_shadow_bo) {
 		if (user_bo->shadow) {
@@ -869,7 +949,9 @@ static int qxl_plane_prepare_fb(struct drm_plane *plane,
 
 	if (plane->type == DRM_PLANE_TYPE_PRIMARY &&
 	    user_bo->is_dumb) {
-		qxl_prepare_shadow(qdev, user_bo, new_state->crtc->index);
+		qxl_prepare_shadow(qdev, user_bo, new_state->crtc->index,
+				   new_state->src_w >> 16,
+				   new_state->src_h >> 16);
 	}
 
 	if (plane->type == DRM_PLANE_TYPE_CURSOR &&
diff --git a/drivers/gpu/drm/qxl/qxl_draw.c b/drivers/gpu/drm/qxl/qxl_draw.c
index 3a3e127ce297..f99f4afa46d9 100644
--- a/drivers/gpu/drm/qxl/qxl_draw.c
+++ b/drivers/gpu/drm/qxl/qxl_draw.c
@@ -129,7 +129,7 @@ void qxl_draw_dirty_fb(struct qxl_device *qdev,
 		       unsigned int flags, unsigned int color,
 		       struct drm_clip_rect *clips,
 		       unsigned int num_clips, int inc,
-		       uint32_t dumb_shadow_offset)
+		       u32 dumb_shadow_offset, int y_off)
 {
 	/*
 	 * TODO: if flags & DRM_MODE_FB_DIRTY_ANNOTATE_FILL then we should
@@ -160,6 +160,8 @@ void qxl_draw_dirty_fb(struct qxl_device *qdev,
 
 	clips->x1 += dumb_shadow_offset;
 	clips->x2 += dumb_shadow_offset;
+	clips->y1 += y_off;
+	clips->y2 += y_off;
 
 	left = clips->x1;
 	right = clips->x2;
@@ -210,7 +212,7 @@ void qxl_draw_dirty_fb(struct qxl_device *qdev,
 
 	ret = qxl_image_init(qdev, release, dimage, surface_base,
 			     left - dumb_shadow_offset,
-			     top, width, height, depth, stride);
+			     top - y_off, width, height, depth, stride);
 	qxl_bo_vunmap_locked(bo);
 	if (ret)
 		goto out_release_backoff;
diff --git a/drivers/gpu/drm/qxl/qxl_drv.h b/drivers/gpu/drm/qxl/qxl_drv.h
index cc02b5f10ad9..f7edb620d4d7 100644
--- a/drivers/gpu/drm/qxl/qxl_drv.h
+++ b/drivers/gpu/drm/qxl/qxl_drv.h
@@ -202,6 +202,7 @@ struct qxl_device {
 
 	struct qxl_bo *primary_bo;
 	struct qxl_bo *dumb_shadow_bo;
+	bool dumb_shadow_needs_redraw;
 	struct qxl_head *dumb_heads;
 
 	struct qxl_memslot main_slot;
@@ -394,7 +395,7 @@ void qxl_draw_dirty_fb(struct qxl_device *qdev,
 		       unsigned int flags, unsigned int color,
 		       struct drm_clip_rect *clips,
 		       unsigned int num_clips, int inc,
-		       uint32_t dumb_shadow_offset);
+		       u32 dumb_shadow_offset, int y_off);
 
 void qxl_release_free(struct qxl_device *qdev,
 		      struct qxl_release *release);

base-commit: 62f4c998b297cf233997a2b4cd6fc2d2df0319c9
-- 
2.43.0

