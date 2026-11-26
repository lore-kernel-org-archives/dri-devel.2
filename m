Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13B2606A31E
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 16:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PHYOL1jd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 055901125FD;
	Thu, 26 Nov 2026 16:59:41 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DA4F112619
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 16:59:34 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-4a7b8abe209so5658490f8f.0
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 08:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795712373; x=1796317173; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UNGA/1n2bWHLcGx1c23w17fck2ByGOHPPmEA+8qZEVY=;
 b=PHYOL1jdrTQ0euvmHYuuupd1lnMEcFfdOElmBPTJyvRJu51hCJ+j4h3Z7TFToqwxjj
 tuKqOOQ0p3ap/JmhpshxyO51DQflpfBU8YMNqA+Uk8j+TSF2nBvpsMzVh2CYdxLHSzz8
 0kbA2A286nB3sf0e4UClFR3wteZfDXIMsJX9uENNuDt/CLspklCZxYBL7BTdRmAeBWTR
 3r5iK5D0cEdp8pW6Vdm/E3cRpNGtwDZE7r+kBQyTkglJYzMeW6bAmlid5q3OKtKCf1z/
 t0JzYfWHMLIhmZfWBlUngb5B0bLmdNe4zYx4tZIVXYEuzsqEpGt0hakLOj+TRBilXdVI
 hwHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795712373; x=1796317173;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UNGA/1n2bWHLcGx1c23w17fck2ByGOHPPmEA+8qZEVY=;
 b=O28TFcKGiKStyQ60KDe0mFW0m8007N+XavAuF+vg4YB1a2DdP/ag1pQmZXkZxbYuq/
 P6COFQzBq67uvBrx1UUX0sBgun6PJo2aNlFYEg+ew3Yk5IGfNq3k4zqjtBhUy08r10q0
 85V1sDPrtoabTdfoZZulLggBJEgsbizxztjeUw5w0r/rQ26Fzd80votKyXMawN+6En1k
 RllwbsGuKLZ/I2l2XgFjiNPDtcDxwIRhMEt2y8M2uY3fcUMphaDt40KJE5nNRbBHsGEH
 /vD+wqqDc2SRFkhCXHceBZnt9TR6tZij3nbpCeVqZcLI+NWzJw2fajxSVnjeMQhPmGfs
 JHSQ==
X-Gm-Message-State: APuU4Z8nGk3arkACob/o3ZC7YKtcF7eyfaP51IuO67Z8C6IWwVOr1oh4
 zYq0a0jQtauOPtei4PnC5Zb4/ekh+4dirngy9FVyLPRgzhncGf5T2rVC
X-Gm-Gg: AZFdTZfqWSnZeD86erfkx53e8yPAXCVVdcyQNm49WNo/Ov7+YTyy8SivkN/8qqCwZTe
 TLx1u/0ETdCSY0zCCE3ADZ0/E4Dy/DPgL4RoIUbpizrlhmi200UKW9uc6hgApkWNvgcJMp+4aGA
 jRobfWoQBWNOifBWZTlwDyzq2xJf8PBddnilMmljIVAw0SJyGvIiOY3kZJJD2nrl9W+6QEKgRpd
 l+OSlarMBCyWG+epOD9FfmzcKm+kpUO0d4GdGdfSR2+9pgPZBwtuZ54n3qFwluV3zYP9roZTCTy
 sAl49D/z+m83U3hO9ju5H65Qv+gQO1DMnc87oXSv1WP6Bcom0rvlE1//8E9hia7Od2LojkYFUug
 cc8Q7t7I8vi0C3liSKnNJLPqtzwjBfOYBiUWd7U4hIk8DNprbMoc5sAzWawfEBK0/Y1E3VCwAhR
 9awJsNitpjJAege9ESmaSWlGPb8MJ7qp2Vvazons98EMUr5cJSbxMAp6JrlQRiPB+KbNjdo5aFN
 jPs3HAWdqDW4Kee55L7CFd9T0Sw0aIBCqeWhgT6XpEmUixWTdVCWE2hdFH1BtwVLjYiqqQrg3+H
 9lsd2SVQ1Mp62PXQ8xHXZTT0KpWV6X9KSBOigg==
X-Received: by 2002:adf:ef06:0:b0:4a9:5848:3640 with SMTP id
 ffacd0b85a97d-4abb5db79e6mr34143975f8f.55.1795712372601; 
 Thu, 26 Nov 2026 08:59:32 -0800 (PST)
Received: from [10.56.169.198] ([95.179.249.152])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4b70c05b9desm17700731f8f.54.2026.11.26.08.59.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 08:59:32 -0800 (PST)
From: Oarora Etimis <oaroraetimis@gmail.com>
Date: Thu, 26 Nov 2026 17:59:04 +0100
Subject: [PATCH v2 2/2] drm/vkms: copy a full-screen frame straight to
 writeback
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-composer-fastpath-v2-2-292ed6d4c4d6@gmail.com>
References: <20261126-composer-fastpath-v2-0-292ed6d4c4d6@gmail.com>
In-Reply-To: <20261126-composer-fastpath-v2-0-292ed6d4c4d6@gmail.com>
To: Louis Chauvet <louis.chauvet@bootlin.com>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Melissa Wen <melissa.srw@gmail.com>, Oarora Etimis <oaroraetimis@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When no CRC is armed and both sides use the same 32-bit format, copy the
frame straight into the writeback buffer.

Signed-off-by: Oarora Etimis <oaroraetimis@gmail.com>
---
 drivers/gpu/drm/vkms/vkms_composer.c | 82 +++++++++++++++++++++++++++++++++---
 drivers/gpu/drm/vkms/vkms_drv.h      |  5 +++
 drivers/gpu/drm/vkms/vkms_formats.c  | 26 ++++++++++++
 3 files changed, 106 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
index 4e2dd568bc3e..239fdaca2926 100644
--- a/drivers/gpu/drm/vkms/vkms_composer.c
+++ b/drivers/gpu/drm/vkms/vkms_composer.c
@@ -581,6 +581,47 @@ static bool compose_direct(const struct vkms_crtc_state *crtc_state)
 	return true;
 }
 
+/**
+ * writeback_direct() - Can the frame skip the line buffer?
+ * @crtc_state: the state to compose
+ * @wb: the writeback job, or NULL
+ * @plane: the plane the frame comes from
+ * @crc_on: whether this frame has to produce a CRC entry
+ *
+ * True when nothing needs 16-bit pixels: no CRC, no LUT, no colour pipeline.
+ *
+ * Returns: true if the frame can be copied straight into the writeback buffer.
+ */
+static bool writeback_direct(const struct vkms_crtc_state *crtc_state,
+			     const struct vkms_writeback_job *wb,
+			     const struct vkms_plane_state *plane,
+			     bool crc_on)
+{
+	const struct drm_format_info *format;
+
+	/* The CRC is computed over the 16-bit line buffer. */
+	if (!wb || crc_on)
+		return false;
+
+	/* The gamma LUT is applied to the 16-bit line buffer. */
+	if (crtc_state->gamma_lut.y)
+		return false;
+
+	/* The copy walks source rows, so the plane cannot be rotated. */
+	if (plane->frame_info.rotation != DRM_MODE_ROTATE_0)
+		return false;
+
+	if (plane->frame_info.src.x1 || plane->frame_info.src.y1)
+		return false;
+
+	format = plane->frame_info.fb->format;
+	if (format != wb->wb_frame_info.fb->format)
+		return false;
+
+	/* The copy assumes the padding byte, which only XRGB8888 has here. */
+	return format->format == DRM_FORMAT_XRGB8888;
+}
+
 /**
  * blend - blend the pixels from all planes and compute crc
  * @wb: The writeback frame buffer metadata
@@ -589,6 +630,7 @@ static bool compose_direct(const struct vkms_crtc_state *crtc_state)
  * @output_buffer: A buffer of a row that will receive the result of the blend(s)
  * @stage_buffer: The line with the pixels from plane being blend to the output
  * @row_size: The size, in bytes, of a single row
+ * @direct: true when the plane can be read straight into @output_buffer
  *
  * This function blends the pixels (Using the `pre_mul_alpha_blend`)
  * from all planes, calculates the crc32 of the output from the former step,
@@ -597,7 +639,8 @@ static bool compose_direct(const struct vkms_crtc_state *crtc_state)
 static void blend(struct vkms_writeback_job *wb,
 		  struct vkms_crtc_state *crtc_state,
 		  u32 *crc32, struct line_buffer *stage_buffer,
-		  struct line_buffer *output_buffer, size_t row_size)
+		  struct line_buffer *output_buffer, size_t row_size,
+		  bool direct)
 {
 	struct vkms_plane_state **plane = crtc_state->active_planes;
 	u32 n_active_planes = crtc_state->num_active_planes;
@@ -612,7 +655,6 @@ static void blend(struct vkms_writeback_job *wb,
 
 	int crtc_y_limit = crtc_state->base.mode.vdisplay;
 	int crtc_x_limit = crtc_state->base.mode.hdisplay;
-	bool direct = compose_direct(crtc_state);
 
 	/*
 	 * The planes are composed line-by-line to avoid heavy memory usage. It is a necessary
@@ -670,10 +712,12 @@ static int check_iosys_map(struct vkms_crtc_state *crtc_state)
 
 static int compose_active_planes(struct vkms_writeback_job *active_wb,
 				 struct vkms_crtc_state *crtc_state,
-				 u32 *crc32)
+				 u32 *crc32, bool crc_on)
 {
 	size_t line_width, pixel_size = sizeof(struct pixel_argb_u16);
 	struct line_buffer output_buffer, stage_buffer;
+	const struct vkms_plane_state *plane;
+	bool direct;
 	int ret = 0;
 
 	/*
@@ -690,6 +734,17 @@ static int compose_active_planes(struct vkms_writeback_job *active_wb,
 	if (WARN_ON(check_format_funcs(crtc_state, active_wb)))
 		return -EINVAL;
 
+	direct = compose_direct(crtc_state);
+
+	plane = crtc_state->active_planes[0];
+
+	if (direct && writeback_direct(crtc_state, active_wb, plane, crc_on)) {
+		for (int y = 0; y < crtc_state->base.mode.vdisplay; y++)
+			vkms_writeback_row_direct(active_wb, plane, y);
+
+		return 0;
+	}
+
 	line_width = crtc_state->base.mode.hdisplay;
 	stage_buffer.n_pixels = line_width;
 	output_buffer.n_pixels = line_width;
@@ -708,7 +763,7 @@ static int compose_active_planes(struct vkms_writeback_job *active_wb,
 	}
 
 	blend(active_wb, crtc_state, crc32, &stage_buffer,
-	      &output_buffer, line_width * pixel_size);
+	      &output_buffer, line_width * pixel_size, direct);
 
 	kvfree(output_buffer.pixels);
 free_stage_buffer:
@@ -734,7 +789,7 @@ void vkms_composer_worker(struct work_struct *work)
 	struct drm_crtc *crtc = crtc_state->base.crtc;
 	struct vkms_writeback_job *active_wb = crtc_state->active_writeback;
 	struct vkms_output *out = drm_crtc_to_vkms_output(crtc);
-	bool crc_pending, wb_pending;
+	bool crc_pending, wb_pending, crc_on;
 	u64 frame_start, frame_end;
 	u32 crc32 = 0;
 	int ret;
@@ -772,10 +827,16 @@ void vkms_composer_worker(struct work_struct *work)
 	if (!crc_pending)
 		return;
 
+	/*
+	 * One read for both the direct-path decision and the CRC entry: a frame
+	 * must not be queued with a CRC that was never computed.
+	 */
+	crc_on = READ_ONCE(out->crc_enabled);
+
 	if (wb_pending)
-		ret = compose_active_planes(active_wb, crtc_state, &crc32);
+		ret = compose_active_planes(active_wb, crtc_state, &crc32, crc_on);
 	else
-		ret = compose_active_planes(NULL, crtc_state, &crc32);
+		ret = compose_active_planes(NULL, crtc_state, &crc32, crc_on);
 
 	if (ret)
 		return;
@@ -790,6 +851,9 @@ void vkms_composer_worker(struct work_struct *work)
 	/*
 	 * The worker can fall behind the vblank hrtimer, make sure we catch up.
 	 */
+	if (!crc_on)
+		return;
+
 	while (frame_start <= frame_end)
 		drm_crtc_add_crc_entry(crtc, true, frame_start++, &crc32);
 }
@@ -858,6 +922,10 @@ int vkms_set_crc_source(struct drm_crtc *crtc, const char *src_name)
 
 	ret = vkms_crc_parse_source(src_name, &enabled);
 
+	spin_lock_irq(&out->lock);
+	WRITE_ONCE(out->crc_enabled, enabled);
+	spin_unlock_irq(&out->lock);
+
 	vkms_set_composer(out, enabled);
 
 	return ret;
diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
index b7eb7033fb4b..69f12cecd2f9 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.h
+++ b/drivers/gpu/drm/vkms/vkms_drv.h
@@ -220,6 +220,8 @@ struct vkms_crtc_state {
  * @lock: Lock used to protect concurrent access to the composer
  * @composer_enabled: Protected by @lock, true when the VKMS composer is active (crc needed or
  *		      writeback)
+ * @crc_enabled: true while the CRC source is enabled. Written under @lock, read with
+ *		 READ_ONCE() from the composer worker
  * @composer_state: Protected by @lock, current state of this VKMS output
  * @composer_lock: Lock used internally to protect @composer_state members
  */
@@ -231,6 +233,7 @@ struct vkms_output {
 	spinlock_t lock;
 
 	bool composer_enabled;
+	bool crc_enabled;
 	struct vkms_crtc_state *composer_state;
 
 	spinlock_t composer_lock;
@@ -325,6 +328,8 @@ int vkms_verify_crc_source(struct drm_crtc *crtc, const char *source_name,
 void vkms_composer_worker(struct work_struct *work);
 void vkms_set_composer(struct vkms_output *out, bool enabled);
 void vkms_writeback_row(struct vkms_writeback_job *wb, const struct line_buffer *src_buffer, int y);
+void vkms_writeback_row_direct(struct vkms_writeback_job *wb,
+			       const struct vkms_plane_state *plane, int y);
 
 /* Writeback */
 int vkms_enable_writeback_connector(struct vkms_device *vkmsdev, struct vkms_output *vkms_out);
diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
index 7f1f29b589e8..8bbd517092a5 100644
--- a/drivers/gpu/drm/vkms/vkms_formats.c
+++ b/drivers/gpu/drm/vkms/vkms_formats.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0+
 
 #include <linux/kernel.h>
+#include <linux/unaligned.h>
 #include <linux/minmax.h>
 
 #include <drm/drm_blend.h>
@@ -681,6 +682,31 @@ void vkms_writeback_row(struct vkms_writeback_job *wb,
 		wb->pixel_write(dst_pixels, &in_pixels[x]);
 }
 
+/**
+ * vkms_writeback_row_direct() - Copy a composed line into the writeback buffer
+ * @wb: the writeback job
+ * @plane: the plane the line comes from
+ * @y: line to write
+ *
+ * Only used when writeback_direct() returned true.
+ */
+void vkms_writeback_row_direct(struct vkms_writeback_job *wb,
+			       const struct vkms_plane_state *plane, int y)
+{
+	const struct vkms_frame_info *src_info = &plane->frame_info;
+	struct vkms_frame_info *dst_info = &wb->wb_frame_info;
+	u8 *src_pixels, *dst_pixels;
+	int rem_x, rem_y;
+	int x_limit = drm_rect_width(&dst_info->dst);
+
+	packed_pixels_addr(src_info, src_info->dst.x1, y, 0, &src_pixels, &rem_x, &rem_y);
+	packed_pixels_addr(dst_info, dst_info->dst.x1, y, 0, &dst_pixels, &rem_x, &rem_y);
+
+	/* compose_direct() guarantees no alpha, so byte 3 is padding. */
+	for (int x = 0; x < x_limit; x++, src_pixels += 4, dst_pixels += 4)
+		put_unaligned_le32(get_unaligned_le32(src_pixels) | 0xff000000, dst_pixels);
+}
+
 /**
  * get_pixel_read_line_function() - Retrieve the correct read_line function for a specific
  * format. The returned pointer is NULL for unsupported pixel formats. The caller must ensure that

-- 
2.56.1

