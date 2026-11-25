Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BCD606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 08:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cW5G1iCq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57494112134;
	Thu, 26 Nov 2026 08:11:11 +0000 (UTC)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com
 [209.85.210.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B104210FC9C
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 14:23:49 +0000 (UTC)
Received: by mail-pf1-f180.google.com with SMTP id
 d2e1a72fcca58-8a06cc097c7so3779208b3a.0
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 06:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795616629; x=1796221429; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=y5/CHXFxzdctHV36hwhzkbFVfy9xKoD/nJCtHj5TCeU=;
 b=cW5G1iCqCVEpNfA+fv1PJ7IjBMX23E8ynvLkCxA0R8rOBKQG+pp7KLwF4MHyVXwl/P
 QXCfg8nEZUcv0QyO5zSieIe69tVNn0Dt2Xat5/U1pBCTsf3+6h0k5pBWyI2QS+AiCiZa
 176MjBGXqxDH/HtAM3WSBFkNClPOHgcx1B31fZ2vphD5pfbWQjSmG2F1hWk/kgsK29W6
 1db+XCJkUeIzCQj//ruqs/HCr9hxmbJpv/qd7ENGnT5Fp1pSm3ZzU5wU8Mj+yhnVjRrY
 r/6n2GJJ/Vofi9HqYFrINtEARJyU/8Vz5n8gs17pYStHlC8/4EEAsHnPMB0MenIrj/0W
 2N6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795616629; x=1796221429;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=y5/CHXFxzdctHV36hwhzkbFVfy9xKoD/nJCtHj5TCeU=;
 b=KxgRA7+iat7EyUK/656XK2AoOgDr3WGGHzaxVwYwwWjmfsS1aYZz3e1+ObjlOnts3O
 CdkhV2Z8wH/B2YvUXXajlNTNsR/Q6oR4aL6isc2kyEc4x+/AjDPr7jshYhnLrxmI58Fi
 zuoVE1XNEVfFOIEtGuhrqDSAjyZbaURzrMAQX9/Dz/Z0NETADAf+VAMwGIMloio3dEZq
 qGLNlhtHM+0JPNvIHjCHcZVdkLDJ0mWx52AKqVhbICI96Vvw1kzpJYpoihMBWLu/PjQM
 GP6xPf0PBah83dxZGQ2QmBBth+kI+okKoAVck8xdeJlpxpq0Jv6674hyhoCxzovSRdVs
 w4Pg==
X-Gm-Message-State: APuU4Z9KQrBzPRulgBEFmBMSA8KTjKT/KcE0qhRM91aJoiq+7MC/02d9
 VBZTvvqB0NR8cE8rQoLZUuLsPThYPv3zZ+zOqqEsO4w2vvX33UHH/d0wkSbLj1BC
X-Gm-Gg: AZFdTZf0h3Ht/IkLD2O8FfncnOh/lyteqPDeTszODp8Gb+EcmjKrND7sxXp9/THZeoo
 gpFXOPIP1WBTQ4bbY81u8kWzaUza2DMVfVx1ufh+yH3r94IWrs8928i0LXiuqMZRc7LFsLv0f2D
 1oFXKxQ9Dk4vGhRmBzICzJS87+tXUMhklkUNlGU3AOR+TfktshxVu7N2hboHCx7jrQoGH/+HdKV
 1mlAHuKwgj2JmqVSD7FfZrnENiLclX+O6bkpELM2e/NZEtyEQNFZZ2WsDm1OM8U8sHCt3z1q+3p
 /iSJlOUYOahgBDnJR39Y2uAoDCt7r+7UkTr5l0ScG47YAoaoCcT7i88F4/ZmPRNxWAaAckEt1se
 b/+LlZCJDVP+kT9wJ0TSbU9iAQW/Fhy/+Eo8zJEuH4NO8tMkr13clJdMeYLCFelEuGvTp1TKtI/
 A5aT3S4AsEMrUtFPGsPEt18NOauD1Mm3pEWxm85Ig3Nwc0qSJtLyewV4uCYWCgdBSqCaiEBrdE8
 7Ups/0oD6f5934yQnEN2alzcnZ288J4DateBa8vRyzsjOl4qearCaxKYxZQkkC4mPcY3Ww7Usk2
 ofNs2IuDLIYj9x6YvO0LWfG1P0yqtz4kxfhzaIB9MA==
X-Received: by 2002:a05:6a21:2d95:b0:3f8:63f6:c8b8 with SMTP id
 adf61e73a8af0-401493a635amr21820455637.7.1795616629052; 
 Wed, 25 Nov 2026 06:23:49 -0800 (PST)
Received: from a-VirtualBox ([168.188.125.88])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8c872e45eccsm9115841b3a.31.2026.11.25.06.23.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 06:23:48 -0800 (PST)
From: Minseo Park <hiyoukou@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: alain.volmat@foss.st.com, rgallaispou@gmail.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, benjamin.gaignard@linaro.org,
 Minseo Park <hiyoukou@gmail.com>
Subject: [PATCH 1/3] drm/sti: cursor: do not resize the pixmap from
 .atomic_check()
Date: Wed, 25 Nov 2026 23:23:28 +0900
Message-ID: <20261125142330.15298-2-hiyoukou@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125142330.15298-1-hiyoukou@gmail.com>
References: <20261125142330.15298-1-hiyoukou@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 26 Nov 2026 08:08:59 +0000
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

sti_cursor_atomic_check() resizes the cursor pixmap whenever the
requested size differs from the one it cached: it frees the buffer the
hardware is using and allocates a new one.

That is commit work done in the check phase.  An atomic commit with
DRM_MODE_ATOMIC_TEST_ONLY runs drm_atomic_check_only(), which calls the
plane .atomic_check() hooks and returns without ever calling
.atomic_update(), and a commit whose check fails on some other object is
dropped the same way.  In both cases the buffer is freed while CUR_PML
still points at it, so the display engine keeps fetching the cursor from
memory that has gone back to the DMA pool, until some later commit
reprograms the register.

.atomic_check() already rejects a cursor wider or taller than
STI_CURS_MAX_SIZE, and the pixmap is CLUT8, so it never needs to be
larger than 128 * 128 bytes.  Allocate it once when the plane is created
and keep it for the lifetime of the device, with the managed allocator
so that it is released on unbind.  Nothing has to be resized afterwards.

With the pixmap no longer resized, struct sti_cursor does not need to
cache the cursor size either.  .atomic_update() takes it from the plane
state it is handed, which is the state .atomic_check() validated.  The
dev member goes with them, it only had users in the code being removed.

Fixes: dd86dc2f9ae1 ("drm/sti: implement atomic_check for the planes")
Signed-off-by: Minseo Park <hiyoukou@gmail.com>
---
 drivers/gpu/drm/sti/sti_cursor.c | 65 ++++++++++++++------------------
 1 file changed, 28 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/sti/sti_cursor.c b/drivers/gpu/drm/sti/sti_cursor.c
index 66f56355309f..0f0d7405dfef 100644
--- a/drivers/gpu/drm/sti/sti_cursor.c
+++ b/drivers/gpu/drm/sti/sti_cursor.c
@@ -53,20 +53,14 @@ struct dma_pixmap {
  * STI Cursor structure
  *
  * @sti_plane:    sti_plane structure
- * @dev:          driver device
  * @regs:         cursor registers
- * @width:        cursor width
- * @height:       cursor height
  * @clut:         color look up table
  * @clut_paddr:   color look up table physical address
  * @pixmap:       pixmap dma buffer (clut8-format cursor)
  */
 struct sti_cursor {
 	struct sti_plane plane;
-	struct device *dev;
 	void __iomem *regs;
-	unsigned int width;
-	unsigned int height;
 	unsigned short *clut;
 	dma_addr_t clut_paddr;
 	struct dma_pixmap pixmap;
@@ -146,14 +140,15 @@ static void cursor_debugfs_init(struct sti_cursor *cursor,
 				 minor->debugfs_root, minor);
 }
 
-static void sti_cursor_argb8888_to_clut8(struct sti_cursor *cursor, u32 *src)
+static void sti_cursor_argb8888_to_clut8(struct sti_cursor *cursor, u32 *src,
+					 unsigned int width, unsigned int height)
 {
 	u8  *dst = cursor->pixmap.base;
 	unsigned int i, j;
 	u32 a, r, g, b;
 
-	for (i = 0; i < cursor->height; i++) {
-		for (j = 0; j < cursor->width; j++) {
+	for (i = 0; i < height; i++) {
+		for (j = 0; j < width; j++) {
 			/* Pick the 2 higher bits of each component */
 			a = (*src >> 30) & 3;
 			r = (*src >> 22) & 3;
@@ -188,7 +183,6 @@ static int sti_cursor_atomic_check(struct drm_plane *drm_plane,
 	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state,
 										 drm_plane);
 	struct sti_plane *plane = to_sti_plane(drm_plane);
-	struct sti_cursor *cursor = to_sti_cursor(plane);
 	struct drm_crtc *crtc = new_plane_state->crtc;
 	struct drm_framebuffer *fb = new_plane_state->fb;
 	struct drm_crtc_state *crtc_state;
@@ -224,29 +218,6 @@ static int sti_cursor_atomic_check(struct drm_plane *drm_plane,
 		return -EINVAL;
 	}
 
-	/* If the cursor size has changed, re-allocated the pixmap */
-	if (!cursor->pixmap.base ||
-	    (cursor->width != src_w) ||
-	    (cursor->height != src_h)) {
-		cursor->width = src_w;
-		cursor->height = src_h;
-
-		if (cursor->pixmap.base)
-			dma_free_wc(cursor->dev, cursor->pixmap.size,
-				    cursor->pixmap.base, cursor->pixmap.paddr);
-
-		cursor->pixmap.size = cursor->width * cursor->height;
-
-		cursor->pixmap.base = dma_alloc_wc(cursor->dev,
-						   cursor->pixmap.size,
-						   &cursor->pixmap.paddr,
-						   GFP_KERNEL);
-		if (!cursor->pixmap.base) {
-			DRM_ERROR("Failed to allocate memory for pixmap\n");
-			return -EINVAL;
-		}
-	}
-
 	if (!drm_fb_dma_get_gem_obj(fb, 0)) {
 		DRM_ERROR("Can't get DMA GEM object for fb\n");
 		return -EINVAL;
@@ -271,6 +242,7 @@ static void sti_cursor_atomic_update(struct drm_plane *drm_plane,
 	struct drm_framebuffer *fb = newstate->fb;
 	struct drm_display_mode *mode;
 	int dst_x, dst_y;
+	unsigned int src_w, src_h;
 	struct drm_gem_dma_object *dma_obj;
 	u32 y, x;
 	u32 val;
@@ -281,11 +253,15 @@ static void sti_cursor_atomic_update(struct drm_plane *drm_plane,
 	mode = &crtc->mode;
 	dst_x = newstate->crtc_x;
 	dst_y = newstate->crtc_y;
+	/* src_w and src_h are in 16.16 format */
+	src_w = newstate->src_w >> 16;
+	src_h = newstate->src_h >> 16;
 
 	dma_obj = drm_fb_dma_get_gem_obj(fb, 0);
 
 	/* Convert ARGB8888 to CLUT8 */
-	sti_cursor_argb8888_to_clut8(cursor, (u32 *)dma_obj->vaddr);
+	sti_cursor_argb8888_to_clut8(cursor, (u32 *)dma_obj->vaddr,
+				     src_w, src_h);
 
 	/* AWS and AWE depend on the mode */
 	y = sti_vtg_get_line_number(*mode, 0);
@@ -299,8 +275,8 @@ static void sti_cursor_atomic_update(struct drm_plane *drm_plane,
 
 	/* Set memory location, size, and position */
 	writel(cursor->pixmap.paddr, cursor->regs + CUR_PML);
-	writel(cursor->width, cursor->regs + CUR_PMP);
-	writel(cursor->height << 16 | cursor->width, cursor->regs + CUR_SIZE);
+	writel(src_w, cursor->regs + CUR_PMP);
+	writel(src_h << 16 | src_w, cursor->regs + CUR_SIZE);
 
 	y = sti_vtg_get_line_number(*mode, dst_y);
 	x = sti_vtg_get_pixel_number(*mode, dst_x);
@@ -377,6 +353,22 @@ struct drm_plane *sti_cursor_create(struct drm_device *drm_dev,
 		return NULL;
 	}
 
+	/*
+	 * Allocate the pixmap once, for the largest cursor the hardware
+	 * supports.  It used to be reallocated from .atomic_check(), which
+	 * freed a buffer the display engine could still be scanning out.
+	 * Use the managed helper so it is released with the device.
+	 */
+	cursor->pixmap.size = STI_CURS_MAX_SIZE * STI_CURS_MAX_SIZE;
+	cursor->pixmap.base = dmam_alloc_attrs(dev, cursor->pixmap.size,
+					       &cursor->pixmap.paddr,
+					       GFP_KERNEL,
+					       DMA_ATTR_WRITE_COMBINE);
+	if (!cursor->pixmap.base) {
+		DRM_ERROR("Failed to allocate memory for pixmap\n");
+		goto err_clut;
+	}
+
 	/* Allocate clut buffer */
 	size = 0x100 * sizeof(unsigned short);
 	cursor->clut = dma_alloc_wc(dev, size, &cursor->clut_paddr,
@@ -387,7 +379,6 @@ struct drm_plane *sti_cursor_create(struct drm_device *drm_dev,
 		goto err_clut;
 	}
 
-	cursor->dev = dev;
 	cursor->regs = baseaddr;
 	cursor->plane.desc = desc;
 	cursor->plane.status = STI_PLANE_DISABLED;
-- 
2.43.0

