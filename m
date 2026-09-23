Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DE3EC9830D
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 07:31:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8224F10F8F4;
	Fri, 25 Sep 2026 07:30:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cIDrb78T";
	dkim-atps=neutral
Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com
 [74.125.224.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 442FA10F16C
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 20:07:34 +0000 (UTC)
Received: by mail-yx2-f12.google.com with SMTP id
 956f58d0204a3-66e4aac92dbso1216994d50.2
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 13:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790194053; x=1790798853; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=A9+ovGuYBvMVBjRl4lW40mH855ce4DQy0r96l5cCvso=;
 b=cIDrb78TzbMDzW2j+LEa8qoG6Ti4k/U02+q/UcEDaDWTfAs3YhZOgj6IiNJ3fAjAAW
 CSDuneBOPlJnSyTopUEFoNTSKZSFb7cssI0eRASG1FY6xfkNxABKpkW11C+TEbAANIc+
 RbHKrXWS9UCv0Ig0ekl0WLpluD1KCSHGhC9qp7ppUJw57W99zP+tsxMv3ZTEBLTHyoVn
 GgvYC3f50EjyGZ0YC4z/JMGtEWD4qpDMFo+HDsUxBSWPer+f30MzaymnNKA1aNn58ENX
 c/1Cqb4dmhohHyXwM3YZGz11BH9iMxsSZTqa5q/GxfiH2hki/5viKV42OjroC0P8HGv3
 D5MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790194053; x=1790798853;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=A9+ovGuYBvMVBjRl4lW40mH855ce4DQy0r96l5cCvso=;
 b=lVkYq683I+LASmrP/JZUVU8mYp6L+2Fyathfu+RzzRJpApfY2Z+derfrKVmjSZ7OIC
 pLkFcq4Pk2q4YfAty/7+Ka2hfhjFn78xWgwz1RAsAcoLiydeQd9q7qfKyiIq3Xz9FgKe
 fnNAQVmF7H9tXuVdwFuXgm6gqfB8hf6YuXa0ZuG34zIpSiBr3/adygnXz7R1Zx9cNMRz
 lzMLZJ0GUSKTFbAxxv3cGIWvPxv0Gaqxjsdds1VXf904ovdXa7fmKGkdYuTkQopVkycK
 t/aH1KxLjE8z1H8lkbMPVi/tZ4eic+utGm178ndkQ1UaGRvF0PDQiIVlFXzvKsdhvW8w
 CqKg==
X-Gm-Message-State: AFuF++lr1sn2sJRzNEDFiZ0oRS3VZOWfN2pKMI/bQNKw/szQKItCWpgJ
 yWhh8d2nAKAvPHC/LgJB0nye2D/JNy0SXN6pJNX9GhkStG2LH9dXhl4MD+36a/KK
X-Gm-Gg: AYBFou1yjKaHBAT+dKGjQIt95vqTdnBC8yGPwZYh5u3VEjO2RvbEk1rrd3ubhUX1z2J
 GuVnKlWVW5AChBWzI0SttsT4E1yQ5eOCe9xbs4dSTPDTBQNSGPIpU48NCXpR/36Ur0wXz+w3u3f
 aPk1qr9d7q3Jn0RtVXS2aGm5SHGUEW+WdNHEi7QceFG0kVCOrmgK6YXNicNE9Pi6LPUI6v4Jws+
 QmTSbqTfsjrf1O/g3j0Znxe8Qwg9O0+T/MqxzdVSVld55uvR+CtvKK3uCUBb/kL0tko4ypZQef2
 YDZ/M3g0r+wrLBAyMb21XH0n1lZcHVcBwU76Q9hfTcJ6iBZznUKrGh3OLnmgJ3h1ayiiJTB6+6h
 i3CFFJc0LbjSvQh0t+X7AxAhdOQjSkX2yY0eRaGtUBkhj4e5erStQxxo5CqLlgxuITuue3p/6cZ
 wVszzF8iMR7X9HNSY0YwjOKbUmrfFIypcDQvxj11RuhdSU3MdgPZl3la9AWFZuPHkarpOrFej/N
 r6N0DGAsOy3BzmZyZNM
X-Received: by 2002:a05:690e:43cc:10b0:672:d32d:8ee with SMTP id
 956f58d0204a3-672ed42d6aemr182037d50.50.1790194052859; 
 Wed, 23 Sep 2026 13:07:32 -0700 (PDT)
Received: from DESKTOP-TLFH1MG ([76.255.203.42])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-672d80bea23sm1221915d50.10.2026.09.23.13.07.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 13:07:32 -0700 (PDT)
From: Jonathan Frazin <frazinjonathan@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, kamlesh.gurudasani@gmail.com,
 lanzano.alex@gmail.com, phil@raspberrypi.com, linux-kernel@vger.kernel.org,
 Jonathan Frazin <frazinjonathan@gmail.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>
Subject: [PATCH v2 1/2] drm/mipi-dbi: honour the plane source offset when
 flushing
Date: Wed, 23 Sep 2026 14:57:11 -0500
Message-ID: <20260923195713.88-2-frazinjonathan@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923195713.88-1-frazinjonathan@gmail.com>
References: <20260923195713.88-1-frazinjonathan@gmail.com>
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

Cc: Dave Stevenson <dave.stevenson@raspberrypi.com>
Signed-off-by: Jonathan Frazin <frazinjonathan@gmail.com>
---
Changes since v1:
- Clamp the damage rectangle to the panel's fixed mode before using it.
  src_x/src_y are the plane source origin truncated to whole pixels, but
  the rectangle from drm_atomic_helper_damage_merged() is clipped against
  that origin's exact 16.16 fixed-point value - when the origin has a
  fractional part, the rectangle's far edge could land up to a pixel past
  where the truncated origin would place the panel's own width/height,
  overflowing the panel-sized tx_buf. Thanks to the automated review for
  catching this.

 drivers/gpu/drm/drm_mipi_dbi.c | 33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/drm_mipi_dbi.c b/drivers/gpu/drm/drm_mipi_dbi.c
index 25cf04d02..1263dce91 100644
--- a/drivers/gpu/drm/drm_mipi_dbi.c
+++ b/drivers/gpu/drm/drm_mipi_dbi.c
@@ -271,19 +271,35 @@ static void mipi_dbi_set_window_address(struct mipi_dbi_dev *dbidev,
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
+	 */
+	rect->x2 = min_t(int, rect->x2, src_x + dbidev->mode.hdisplay);
+	rect->y2 = min_t(int, rect->y2, src_y + dbidev->mode.vdisplay);
+
+	height = rect->y2 - rect->y1;
+	width = rect->x2 - rect->x1;
+
 	full = width == fb->width && height == fb->height;
 
 	DRM_DEBUG_KMS("Flushing [FB:%d] " DRM_RECT_FMT "\n", fb->base.id, DRM_RECT_ARG(rect));
@@ -298,8 +314,13 @@ static void mipi_dbi_fb_dirty(struct iosys_map *src, struct drm_framebuffer *fb,
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
@@ -390,6 +411,8 @@ void drm_mipi_dbi_plane_helper_atomic_update(struct drm_plane *plane,
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

