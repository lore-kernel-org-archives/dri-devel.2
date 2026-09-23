Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DA7EC98321
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 07:31:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9671810F8E7;
	Fri, 25 Sep 2026 07:30:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JrRlsFLN";
	dkim-atps=neutral
Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com
 [74.125.224.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BF3810F1B6
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 20:59:04 +0000 (UTC)
Received: by mail-yx2-f13.google.com with SMTP id
 00721157ae682-85d46e4cdccso15914457b3.1
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 13:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790197143; x=1790801943; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OI+RXS7AWef0aTId53Kef6aofXdoW+lQEP5J9ptA3JM=;
 b=JrRlsFLNr2wqLTWWbRszkbMIehLz4NtOfwPw02BZDbKBbiggRxDSvU/LXibZG4jTsA
 moncB8qt+Y39Q3LMNA9qwJId6jMPZ2Ycg1mLhnCQMVqi8aZl69k5Oy49eZFV6w2RO6MN
 hrUsGLCjC1un1FxsmPVvRQ0Ly4478h+4dEAUpPv3LaJI4U8d1QcCaglnY2LJ5fE1xp50
 OBx1EJI1i8WZiEsXcYirvKAECvoOOKVE6k7RTcJIaFX6ZbnAr8teHeQ68mIyVQ9HmopW
 GxHHhFAAWF6HkS9WGbHk+dXMcO8p+bJ82NLzcC3TqowO2likcxOKYG9FJeAbRxGVJSYD
 cP0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790197143; x=1790801943;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=OI+RXS7AWef0aTId53Kef6aofXdoW+lQEP5J9ptA3JM=;
 b=S4zbElvvGlYZCohIMtx23f5sT1bNXayOZUR5foMejqGbBEf2MNYvPmQgsdIc/+mq6x
 Oy3DsPtgivUFrDsEXA+PEo4bGx5qMprJiS6rSfd4QkxhVT1acm+auBO4ZJFIeAAGaPbG
 Fkj20KKsrHaC06aROKOtkcQxTuidU7PrFBcJnf03faE2cKIvsz2v+XhgW2vpReYyHuoO
 n9JW7UCTYX9oC6ILQ2VPF8PH+EK9ZBM+nssuFplCKv+xqdfa0ouG0HbisE7FuDXCiPBg
 xrUTfXn8S9TiypMaEB41TINDdlrhBxH+2/qt+AGkf1e/3aoeADQhF/1szr9Xrs9DWGBY
 rABg==
X-Gm-Message-State: AFuF++moS7bd3lDF2hjRCP2sFP1UJR7WwJIZFEdPjimFSSfZw0dvWIM4
 JdmFGjUx7BNqpqDDRIOQWkTFTbFAjTpYogk7hYdwLS1csrRn6cN+zfy9X4TE2RHg
X-Gm-Gg: AYBFou2gYPt9Q3l98qx10UXSPa4PMXeVmx0T7M5O0YioOPabslJez3FFHS21MgD9A7y
 1R2avg5f3ufb5s2wXUdNzRwcNNbCzyt2Gg69USE8zZYN9knT6SzvAgN+wUW0TYyGyY/WuOvyY4i
 +x0UFdC6FN9dyaeWmub6eTSu0WPCg/cJUIi1lDce8+cjvgiw3UpqlTg+vOr8onJVvM8+bIZ6HFQ
 sLNbhdTVheBRCsFxMrW1ihryjXCkTjwhocobQoZmocTZyPt0+N25llnR27xYkzBhj5/KIuhY07K
 IydK6gRnYeqS67mQYyMSUJCoX68Qm1xfAcW/xBBTeyW4OW9Y6Pot7CjmdYu0RKNvPG0a1/oebc7
 iESqKNebOaIjs4xp8BH4/5T/dEnUdPSQtpF3XES8xrered5FsCl85q1ju4D5QfqW8gjInxkpfpm
 +QzOUnvJBLHuDOC3yqCe48GkCOMxiezhgwwrbonsEyxNqTUnnkgREkHLOp22/JAP/b9SgX3BF3R
 sv3Cu/kHg==
X-Received: by 2002:a05:690c:39b:b0:882:b4b2:c49 with SMTP id
 00721157ae682-8a646e8848bmr3505747b3.18.1790197142862; 
 Wed, 23 Sep 2026 13:59:02 -0700 (PDT)
Received: from DESKTOP-TLFH1MG ([76.255.203.42])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8a65270b1e2sm1073467b3.41.2026.09.23.13.59.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 13:59:02 -0700 (PDT)
From: Jonathan Frazin <frazinjonathan@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, kamlesh.gurudasani@gmail.com,
 lanzano.alex@gmail.com, phil@raspberrypi.com, linux-kernel@vger.kernel.org,
 Jonathan Frazin <frazinjonathan@gmail.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>
Subject: [PATCH v3 1/2] drm/mipi-dbi: honour the plane source offset when
 flushing
Date: Wed, 23 Sep 2026 15:58:33 -0500
Message-ID: <20260923205835.3505-2-frazinjonathan@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923205835.3505-1-frazinjonathan@gmail.com>
References: <20260923205835.3505-1-frazinjonathan@gmail.com>
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

mipi_dbi_fb_dirty() takes the damage rectangle from
drm_atomic_helper_damage_merged(), which is expressed in framebuffer
coordinates and already clipped to the plane's source rectangle.  It
then passed that rectangle straight to mipi_dbi_set_window_address(),
which is correct only while the source rectangle starts at (0,0) - i.e.
while the framebuffer is exactly panel-sized.

If a driver allows a framebuffer larger than the panel and the plane
selects a sub-region with a non-zero src_x/src_y, the controller was
still addressed in framebuffer coordinates, so the wrong part of the
panel was written and an out-of-range window could be programmed.

Pass the integer plane source origin down to mipi_dbi_fb_dirty() and
subtract it when programming the column/page address.  The copy into the
transfer buffer still uses the framebuffer-coordinate rectangle, so it
keeps reading the correct pixels from an oversized source.  With a
panel-sized framebuffer src_x/src_y are zero and behaviour is unchanged.

The rectangle from drm_atomic_helper_damage_merged() is clipped against
the src rectangle's exact 16.16 fixed-point bounds, while src_x/src_y
above are that same origin truncated to whole pixels. When the origin
has a fractional part, the truncation can leave the rectangle's far
edge up to a pixel past where a whole-pixel origin would place the
panel's own width/height - and tx_buf is sized for exactly the panel,
with no slack for that overshoot. Clamp the rectangle to the panel's
fixed mode before using it for the window address or the transfer
length.

A damage clip can also lie entirely within that one-pixel sliver past
the panel edge - the damage iterator clips only against the exact
fixed-point bound, not the whole-pixel one used here - collapsing the
clamped rectangle to zero width or height. Skip the flush in that case
rather than program an inverted (start past end) address window, which
is undefined behaviour per the MIPI DCS spec.

Cc: Dave Stevenson <dave.stevenson@raspberrypi.com>
Signed-off-by: Jonathan Frazin <frazinjonathan@gmail.com>
---
Changes since v2:
- A damage clip lying entirely within the one-pixel sliver the v2 clamp
  cuts off collapses the clamped rectangle to zero width or height,
  which was still reaching mipi_dbi_set_window_address() as an inverted
  (start past end) address window ahead of a zero-length write - skip
  the flush when the clamped rectangle is empty. Thanks again to the
  automated review for catching this on v2.

Changes since v1:
- Clamp the damage rectangle to the panel's fixed mode before using it,
  as described above. Thanks to the automated review for catching this.

 drivers/gpu/drm/drm_mipi_dbi.c | 43 ++++++++++++++++++++++++++++++----
 1 file changed, 38 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/drm_mipi_dbi.c b/drivers/gpu/drm/drm_mipi_dbi.c
index 25cf04d02..bb557fab1 100644
--- a/drivers/gpu/drm/drm_mipi_dbi.c
+++ b/drivers/gpu/drm/drm_mipi_dbi.c
@@ -271,19 +271,45 @@ static void mipi_dbi_set_window_address(struct mipi_dbi_dev *dbidev,
 }
 
 static void mipi_dbi_fb_dirty(struct iosys_map *src, struct drm_framebuffer *fb,
-			      struct drm_rect *rect, struct drm_format_conv_state *fmtcnv_state)
+			      struct drm_rect *rect, unsigned int src_x, unsigned int src_y,
+			      struct drm_format_conv_state *fmtcnv_state)
 {
 	struct mipi_dbi_dev *dbidev = drm_to_mipi_dbi_dev(fb->dev);
-	unsigned int height = rect->y2 - rect->y1;
-	unsigned int width = rect->x2 - rect->x1;
 	const struct drm_format_info *dst_format;
 	struct mipi_dbi *dbi = &dbidev->dbi;
 	bool swap = dbi->swap_bytes;
+	unsigned int height, width;
 	int ret = 0;
 	size_t len;
 	bool full;
 	void *tr;
 
+	/*
+	 * @rect is in framebuffer coordinates, clipped to the plane's src
+	 * rectangle by the damage iterator against that rectangle's exact
+	 * 16.16 fixed-point bounds. @src_x/@src_y are that same origin
+	 * truncated to whole pixels. When the origin has a fractional part,
+	 * that truncation can leave @rect's far edge up to a pixel past
+	 * where a whole-pixel @src_x/@src_y would place the panel's own
+	 * width/height -- and tx_buf is sized for exactly the panel, with no
+	 * slack for that overshoot. Clamp before using @rect for anything.
+	 *
+	 * A damage clip can lie entirely in that one-pixel sliver past the
+	 * panel edge -- the iterator above clips only against the exact
+	 * fixed-point bound, not the whole-pixel one used here -- in which
+	 * case the clamp collapses @rect to zero width or height. Nothing in
+	 * it was ever visible on the panel, so skip the flush rather than
+	 * program an inverted (start past end) address window.
+	 */
+	rect->x2 = min_t(int, rect->x2, src_x + dbidev->mode.hdisplay);
+	rect->y2 = min_t(int, rect->y2, src_y + dbidev->mode.vdisplay);
+
+	if (rect->x2 <= rect->x1 || rect->y2 <= rect->y1)
+		return;
+
+	height = rect->y2 - rect->y1;
+	width = rect->x2 - rect->x1;
+
 	full = width == fb->width && height == fb->height;
 
 	DRM_DEBUG_KMS("Flushing [FB:%d] " DRM_RECT_FMT "\n", fb->base.id, DRM_RECT_ARG(rect));
@@ -298,8 +324,13 @@ static void mipi_dbi_fb_dirty(struct iosys_map *src, struct drm_framebuffer *fb,
 		tr = src->vaddr; /* TODO: Use mapping abstraction properly */
 	}
 
-	mipi_dbi_set_window_address(dbidev, rect->x1, rect->x2 - 1, rect->y1,
-				    rect->y2 - 1);
+	/*
+	 * @rect is in framebuffer coordinates and has been clipped to the plane
+	 * src rectangle by the damage iterator. The panel is addressed relative
+	 * to the src origin, so subtract it here.
+	 */
+	mipi_dbi_set_window_address(dbidev, rect->x1 - src_x, rect->x2 - 1 - src_x,
+				    rect->y1 - src_y, rect->y2 - 1 - src_y);
 
 	if (fb->format->format == DRM_FORMAT_XRGB8888)
 		dst_format = drm_format_info(dbidev->pixel_format);
@@ -390,6 +421,8 @@ void drm_mipi_dbi_plane_helper_atomic_update(struct drm_plane *plane,
 	if (drm_dev_enter(plane->dev, &idx)) {
 		if (drm_atomic_helper_damage_merged(old_plane_state, plane_state, &rect))
 			mipi_dbi_fb_dirty(&shadow_plane_state->data[0], fb, &rect,
+					  plane_state->src_x >> 16,
+					  plane_state->src_y >> 16,
 					  &shadow_plane_state->fmtcnv_state);
 		drm_dev_exit(idx);
 	}
-- 
2.53.0

