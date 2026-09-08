Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E80F5C79F9E
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 14:47:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1452910EC4A;
	Tue,  8 Sep 2026 14:47:10 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A064710EC4A
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 14:47:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 87A4543CC5;
 Tue,  8 Sep 2026 14:47:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8FA41F00AC4;
 Tue,  8 Sep 2026 14:47:07 +0000 (UTC)
From: Maxime Ripard <mripard@kernel.org>
Date: Tue, 08 Sep 2026 16:46:33 +0200
Subject: [PATCH v4 02/41] drm/vkms: Move frame_info into vkms_plane_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-drm-no-more-plane-reset-v4-2-a31b3fcfc989@kernel.org>
References: <20260908-drm-no-more-plane-reset-v4-0-a31b3fcfc989@kernel.org>
In-Reply-To: <20260908-drm-no-more-plane-reset-v4-0-a31b3fcfc989@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 hamohammed.sa@gmail.com, louis.chauvet@bootlin.com, melissa.srw@gmail.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=14944; i=mripard@kernel.org;
 h=from:subject:message-id; bh=qUo5iSbqPiKFJnS0dhOf17iyPgx65NiRY4NghQRg2H0=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFkL5M9xx/fFxPB8dkv7cXjJMhY+hcs8Xw/UuUUm2/d1X
 o19VlzVMZWFQZiTQVZMkeWJTNjp5e2LqxzsV/6AmcPKBDKEgYtTACYidZSxPk39qsmWKdkL3kiz
 9e5OPz/5jOAEv2NC2yewPFofV8HpcO38yZiX0daLuT642f/4N2/qHMaGX5tTWGYb8+9rvWEhJzd
 3rnJN+Lprvsumxax5sf+aE+O9UmHtqpP8Mh3l8jIOk5TeKl4DAA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
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

The vkms_frame_info structure is allocated separately in
vkms_plane_duplicate_state() and freed in vkms_plane_destroy_state(),
but has the exact same lifetime as the vkms_plane_state that contains
it.

This separate allocation is fragile: frame_info is only allocated in
duplicate_state, so any other path that creates a vkms_plane_state
produces a state with a NULL frame_info pointer. Both
vkms_plane_atomic_update() and vkms_plane_destroy_state() dereference
it unconditionally when a CRTC is set.

Embed frame_info directly in vkms_plane_state. The structure is
zero-initialized as part of the kzalloc, removing the need for a
separate allocation and its error handling in duplicate_state, and the
matching kfree in destroy_state.

Signed-off-by: Maxime Ripard <mripard@kernel.org>

---

Cc: hamohammed.sa@gmail.com
Cc: louis.chauvet@bootlin.com
Cc: melissa.srw@gmail.com
---
 drivers/gpu/drm/vkms/vkms_composer.c | 30 +++++++++++-----------
 drivers/gpu/drm/vkms/vkms_drv.h      |  2 +-
 drivers/gpu/drm/vkms/vkms_formats.c  | 48 ++++++++++++++++++------------------
 drivers/gpu/drm/vkms/vkms_plane.c    | 21 +++-------------
 4 files changed, 44 insertions(+), 57 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
index 899120cd07ac..0fc915a954ba 100644
--- a/drivers/gpu/drm/vkms/vkms_composer.c
+++ b/drivers/gpu/drm/vkms/vkms_composer.c
@@ -309,11 +309,11 @@ static void clamp_line_coordinates(enum pixel_read_direction direction,
 				   int *src_y_start, int *dst_x_start, int *pixel_count)
 {
 	/* By default the start points are correct */
 	*src_x_start = src_line->x1;
 	*src_y_start = src_line->y1;
-	*dst_x_start = current_plane->frame_info->dst.x1;
+	*dst_x_start = current_plane->frame_info.dst.x1;
 
 	/* Get the correct number of pixel to blend, it depends of the direction */
 	switch (direction) {
 	case READ_LEFT_TO_RIGHT:
 	case READ_RIGHT_TO_LEFT:
@@ -337,23 +337,23 @@ static void clamp_line_coordinates(enum pixel_read_direction direction,
 		if (*src_x_start < 0) {
 			*pixel_count += *src_x_start;
 			*dst_x_start -= *src_x_start;
 			*src_x_start = 0;
 		}
-		if (*src_x_start + *pixel_count > current_plane->frame_info->fb->width)
-			*pixel_count = max(0, (int)current_plane->frame_info->fb->width -
+		if (*src_x_start + *pixel_count > current_plane->frame_info.fb->width)
+			*pixel_count = max(0, (int)current_plane->frame_info.fb->width -
 				*src_x_start);
 		break;
 	case READ_BOTTOM_TO_TOP:
 	case READ_TOP_TO_BOTTOM:
 		if (*src_y_start < 0) {
 			*pixel_count += *src_y_start;
 			*dst_x_start -= *src_y_start;
 			*src_y_start = 0;
 		}
-		if (*src_y_start + *pixel_count > current_plane->frame_info->fb->height)
-			*pixel_count = max(0, (int)current_plane->frame_info->fb->height -
+		if (*src_y_start + *pixel_count > current_plane->frame_info.fb->height)
+			*pixel_count = max(0, (int)current_plane->frame_info.fb->height -
 				*src_y_start);
 		break;
 	}
 }
 
@@ -372,24 +372,24 @@ static void blend_line(struct vkms_plane_state *current_plane, int y,
 {
 	int src_x_start, src_y_start, dst_x_start, pixel_count;
 	struct drm_rect dst_line, tmp_src, src_line;
 
 	/* Avoid rendering useless lines */
-	if (y < current_plane->frame_info->dst.y1 ||
-	    y >= current_plane->frame_info->dst.y2)
+	if (y < current_plane->frame_info.dst.y1 ||
+	    y >= current_plane->frame_info.dst.y2)
 		return;
 
 	/*
 	 * dst_line is the line to copy. The initial coordinates are inside the
 	 * destination framebuffer, and then drm_rect_* helpers are used to
 	 * compute the correct position into the source framebuffer.
 	 */
-	dst_line = DRM_RECT_INIT(current_plane->frame_info->dst.x1, y,
-				 drm_rect_width(&current_plane->frame_info->dst),
+	dst_line = DRM_RECT_INIT(current_plane->frame_info.dst.x1, y,
+				 drm_rect_width(&current_plane->frame_info.dst),
 				 1);
 
-	drm_rect_fp_to_int(&tmp_src, &current_plane->frame_info->src);
+	drm_rect_fp_to_int(&tmp_src, &current_plane->frame_info.src);
 
 	/*
 	 * [1]: Clamping src_line to the crtc_x_limit to avoid writing outside of
 	 * the destination buffer
 	 */
@@ -409,21 +409,21 @@ static void blend_line(struct vkms_plane_state *current_plane, int y,
 	 * - Invert the rotation. This assumes that
 	 *   dst = drm_rect_rotate(src, rotation) (dst and src have the
 	 *   same size, but can be rotated).
 	 * - Apply the offset of the source rectangle to the coordinate.
 	 */
-	drm_rect_translate(&src_line, -current_plane->frame_info->dst.x1,
-			   -current_plane->frame_info->dst.y1);
+	drm_rect_translate(&src_line, -current_plane->frame_info.dst.x1,
+			   -current_plane->frame_info.dst.y1);
 	drm_rect_rotate_inv(&src_line, drm_rect_width(&tmp_src),
 			    drm_rect_height(&tmp_src),
-			    current_plane->frame_info->rotation);
+			    current_plane->frame_info.rotation);
 	drm_rect_translate(&src_line, tmp_src.x1, tmp_src.y1);
 
 	/* Get the correct reading direction in the source buffer. */
 
 	enum pixel_read_direction direction =
-		direction_for_rotation(current_plane->frame_info->rotation);
+		direction_for_rotation(current_plane->frame_info.rotation);
 
 	/* [2]: Compute and clamp the number of pixel to read */
 	clamp_line_coordinates(direction, current_plane, &src_line, &src_x_start, &src_y_start,
 			       &dst_x_start, &pixel_count);
 
@@ -537,11 +537,11 @@ static int check_iosys_map(struct vkms_crtc_state *crtc_state)
 {
 	struct vkms_plane_state **plane_state = crtc_state->active_planes;
 	u32 n_active_planes = crtc_state->num_active_planes;
 
 	for (size_t i = 0; i < n_active_planes; i++)
-		if (iosys_map_is_null(&plane_state[i]->frame_info->map[0]))
+		if (iosys_map_is_null(&plane_state[i]->frame_info.map[0]))
 			return -1;
 
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
index 0933e4ce0ff0..381483aa4fb0 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.h
+++ b/drivers/gpu/drm/vkms/vkms_drv.h
@@ -147,11 +147,11 @@ struct conversion_matrix {
  *		     struct vkms_plane_state must ensure that this pointer is valid
  * @conversion_matrix: matrix used for yuv formats to convert to rgb
  */
 struct vkms_plane_state {
 	struct drm_shadow_plane_state base;
-	struct vkms_frame_info *frame_info;
+	struct vkms_frame_info frame_info;
 	pixel_read_line_t pixel_read_line;
 	struct conversion_matrix conversion_matrix;
 };
 
 struct vkms_plane {
diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
index 964b574d9ed7..7f1f29b589e8 100644
--- a/drivers/gpu/drm/vkms/vkms_formats.c
+++ b/drivers/gpu/drm/vkms/vkms_formats.c
@@ -319,14 +319,14 @@ EXPORT_SYMBOL_IF_KUNIT(argb_u16_from_yuv161616);
 static void function_name(const struct vkms_plane_state *plane, int x_start,			\
 			      int y_start, enum pixel_read_direction direction, int count,	\
 			      struct pixel_argb_u16 out_pixel[])				\
 {												\
 	struct pixel_argb_u16 *end = out_pixel + count;						\
-	int step = get_block_step_bytes(plane->frame_info->fb, direction, 0);			\
+	int step = get_block_step_bytes(plane->frame_info.fb, direction, 0);			\
 	u8 *src_pixels;										\
 												\
-	packed_pixels_addr_1x1(plane->frame_info, x_start, y_start, 0, &src_pixels);		\
+	packed_pixels_addr_1x1(&plane->frame_info, x_start, y_start, 0, &src_pixels);		\
 												\
 	while (out_pixel < end) {								\
 		pixel_type *(pixel_name) = (pixel_type *)src_pixels;				\
 		*out_pixel = (callback)(__VA_ARGS__);						\
 		out_pixel += 1;									\
@@ -377,20 +377,20 @@ static void function_name(const struct vkms_plane_state *plane, int x_start,			\
 static void Rx_read_line(const struct vkms_plane_state *plane, int x_start,
 			 int y_start, enum pixel_read_direction direction, int count,
 			 struct pixel_argb_u16 out_pixel[])
 {
 	struct pixel_argb_u16 *end = out_pixel + count;
-	int bits_per_pixel = drm_format_info_bpp(plane->frame_info->fb->format, 0);
+	int bits_per_pixel = drm_format_info_bpp(plane->frame_info.fb->format, 0);
 	u8 *src_pixels;
 	int rem_x, rem_y;
 
-	WARN_ONCE(drm_format_info_block_height(plane->frame_info->fb->format, 0) != 1,
+	WARN_ONCE(drm_format_info_block_height(plane->frame_info.fb->format, 0) != 1,
 		  "%s() only support formats with block_h == 1", __func__);
 
-	packed_pixels_addr(plane->frame_info, x_start, y_start, 0, &src_pixels, &rem_x, &rem_y);
+	packed_pixels_addr(&plane->frame_info, x_start, y_start, 0, &src_pixels, &rem_x, &rem_y);
 	int bit_offset = (8 - bits_per_pixel) - rem_x * bits_per_pixel;
-	int step = get_block_step_bytes(plane->frame_info->fb, direction, 0);
+	int step = get_block_step_bytes(plane->frame_info.fb, direction, 0);
 	int mask = (0x1 << bits_per_pixel) - 1;
 	int lum_per_level = 0xFFFF / mask;
 
 	if (direction == READ_LEFT_TO_RIGHT || direction == READ_RIGHT_TO_LEFT) {
 		int restart_bit_offset;
@@ -501,19 +501,19 @@ static void function_name(const struct vkms_plane_state *plane, int x_start,			\
 		 struct pixel_argb_u16 out_pixel[])						\
 {												\
 	u8 *plane_1;										\
 	u8 *plane_2;										\
 												\
-	packed_pixels_addr_1x1(plane->frame_info, x_start, y_start, 0,				\
+	packed_pixels_addr_1x1(&plane->frame_info, x_start, y_start, 0,				\
 			       &plane_1);							\
-	packed_pixels_addr_1x1(plane->frame_info,						\
-			       x_start / plane->frame_info->fb->format->hsub,			\
-			       y_start / plane->frame_info->fb->format->vsub, 1,		\
+	packed_pixels_addr_1x1(&plane->frame_info,						\
+			       x_start / plane->frame_info.fb->format->hsub,			\
+			       y_start / plane->frame_info.fb->format->vsub, 1,			\
 			       &plane_2);							\
-	int step_1 = get_block_step_bytes(plane->frame_info->fb, direction, 0);			\
-	int step_2 = get_block_step_bytes(plane->frame_info->fb, direction, 1);			\
-	int subsampling = get_subsampling(plane->frame_info->fb->format, direction);		\
+	int step_1 = get_block_step_bytes(plane->frame_info.fb, direction, 0);			\
+	int step_2 = get_block_step_bytes(plane->frame_info.fb, direction, 1);			\
+	int subsampling = get_subsampling(plane->frame_info.fb->format, direction);		\
 	int subsampling_offset = get_subsampling_offset(direction, x_start, y_start);		\
 	const struct conversion_matrix *conversion_matrix = &plane->conversion_matrix;		\
 												\
 	for (int i = 0; i < count; i++) {							\
 		pixel_1_type *(pixel_1_name) = (pixel_1_type *)plane_1;				\
@@ -546,24 +546,24 @@ static void planar_yuv_read_line(const struct vkms_plane_state *plane, int x_sta
 {
 	u8 *y_plane;
 	u8 *channel_1_plane;
 	u8 *channel_2_plane;
 
-	packed_pixels_addr_1x1(plane->frame_info, x_start, y_start, 0,
+	packed_pixels_addr_1x1(&plane->frame_info, x_start, y_start, 0,
 			       &y_plane);
-	packed_pixels_addr_1x1(plane->frame_info,
-			       x_start / plane->frame_info->fb->format->hsub,
-			       y_start / plane->frame_info->fb->format->vsub, 1,
+	packed_pixels_addr_1x1(&plane->frame_info,
+			       x_start / plane->frame_info.fb->format->hsub,
+			       y_start / plane->frame_info.fb->format->vsub, 1,
 			       &channel_1_plane);
-	packed_pixels_addr_1x1(plane->frame_info,
-			       x_start / plane->frame_info->fb->format->hsub,
-			       y_start / plane->frame_info->fb->format->vsub, 2,
+	packed_pixels_addr_1x1(&plane->frame_info,
+			       x_start / plane->frame_info.fb->format->hsub,
+			       y_start / plane->frame_info.fb->format->vsub, 2,
 			       &channel_2_plane);
-	int step_y = get_block_step_bytes(plane->frame_info->fb, direction, 0);
-	int step_channel_1 = get_block_step_bytes(plane->frame_info->fb, direction, 1);
-	int step_channel_2 = get_block_step_bytes(plane->frame_info->fb, direction, 2);
-	int subsampling = get_subsampling(plane->frame_info->fb->format, direction);
+	int step_y = get_block_step_bytes(plane->frame_info.fb, direction, 0);
+	int step_channel_1 = get_block_step_bytes(plane->frame_info.fb, direction, 1);
+	int step_channel_2 = get_block_step_bytes(plane->frame_info.fb, direction, 2);
+	int subsampling = get_subsampling(plane->frame_info.fb->format, direction);
 	int subsampling_offset = get_subsampling_offset(direction, x_start, y_start);
 	const struct conversion_matrix *conversion_matrix = &plane->conversion_matrix;
 
 	for (int i = 0; i < count; i++) {
 		*out_pixel = argb_u16_from_yuv161616(conversion_matrix,
diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
index 6ee5c3f3207c..2fd4edf2d190 100644
--- a/drivers/gpu/drm/vkms/vkms_plane.c
+++ b/drivers/gpu/drm/vkms/vkms_plane.c
@@ -53,25 +53,15 @@ static const u32 vkms_formats[] = {
 
 static struct drm_plane_state *
 vkms_plane_duplicate_state(struct drm_plane *plane)
 {
 	struct vkms_plane_state *vkms_state;
-	struct vkms_frame_info *frame_info;
 
 	vkms_state = kzalloc_obj(*vkms_state);
 	if (!vkms_state)
 		return NULL;
 
-	frame_info = kzalloc_obj(*frame_info);
-	if (!frame_info) {
-		DRM_DEBUG_KMS("Couldn't allocate frame_info\n");
-		kfree(vkms_state);
-		return NULL;
-	}
-
-	vkms_state->frame_info = frame_info;
-
 	__drm_gem_duplicate_shadow_plane_state(plane, &vkms_state->base);
 
 	return &vkms_state->base.base;
 }
 
@@ -79,21 +69,18 @@ static void vkms_plane_destroy_state(struct drm_plane *plane,
 				     struct drm_plane_state *old_state)
 {
 	struct vkms_plane_state *vkms_state = to_vkms_plane_state(old_state);
 	struct drm_crtc *crtc = vkms_state->base.base.crtc;
 
-	if (crtc && vkms_state->frame_info->fb) {
+	if (crtc && vkms_state->frame_info.fb) {
 		/* dropping the reference we acquired in
 		 * vkms_primary_plane_update()
 		 */
-		if (drm_framebuffer_read_refcount(vkms_state->frame_info->fb))
-			drm_framebuffer_put(vkms_state->frame_info->fb);
+		if (drm_framebuffer_read_refcount(vkms_state->frame_info.fb))
+			drm_framebuffer_put(vkms_state->frame_info.fb);
 	}
 
-	kfree(vkms_state->frame_info);
-	vkms_state->frame_info = NULL;
-
 	__drm_gem_destroy_shadow_plane_state(&vkms_state->base);
 	kfree(vkms_state);
 }
 
 static void vkms_plane_reset(struct drm_plane *plane)
@@ -141,11 +128,11 @@ static void vkms_plane_atomic_update(struct drm_plane *plane,
 
 	fmt = fb->format->format;
 	vkms_plane_state = to_vkms_plane_state(new_state);
 	shadow_plane_state = &vkms_plane_state->base;
 
-	frame_info = vkms_plane_state->frame_info;
+	frame_info = &vkms_plane_state->frame_info;
 	memcpy(&frame_info->src, &new_state->src, sizeof(struct drm_rect));
 	memcpy(&frame_info->dst, &new_state->dst, sizeof(struct drm_rect));
 	frame_info->fb = fb;
 	memcpy(&frame_info->map, &shadow_plane_state->data, sizeof(frame_info->map));
 	drm_framebuffer_get(frame_info->fb);

-- 
2.55.0

