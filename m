Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE532606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 08:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l8JBt2eU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41BA3112102;
	Thu, 26 Nov 2026 08:09:17 +0000 (UTC)
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com
 [74.125.82.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B443110E191
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 02:47:27 +0000 (UTC)
Received: by mail-dy1-f176.google.com with SMTP id
 5a478bee46e88-38699cf08dfso7908237eec.1
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 18:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795661247; x=1796266047; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WGYqdo3jurMc6Z3tAAH/UhwvSHOclRa89Ymd8bSt1Ug=;
 b=l8JBt2eUqymGPK13wpwoLx0RfLWrp/S48w5ZnfFfmR3fD2Bq3UuAw2669ycWIwMGsk
 D8PR3y0Bugs04XV6zK6A/an4m+GPAfx1vqfyo0Sbm4G6hAuMaxasWe+a9Zg6+34J8Lzp
 J1lhD2pfO8uoLGGXSSk6CAvcJYP+lNu/pF4QwV85V77sP0CAgj6czwP4MBXCb2tZLsnK
 PhG87PI413oeglgOOjg96U+d1TeKX84pKx8utsJ8jPFbfBs9Htv3yolwH14720h/K9g2
 Vn8FzIM+MWtTht4VFs6S9Ueb7kkaX67NRvMx4ot5gl5Ug7dpOBP3tgbke0b1h8T3+34M
 c5Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795661247; x=1796266047;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=WGYqdo3jurMc6Z3tAAH/UhwvSHOclRa89Ymd8bSt1Ug=;
 b=X11m4qyICyFbO6GM/NKdfXZirbVrB0mYQ6VcKvrHTnk3/wxI/zFbuHZ06r2N8h4uEp
 SHWQMCPvq6+hOx14QZTapU53uhF6AN9vA8ti5FWgmZw7dBwkWd4RqmzbUMIiOR5k8+JU
 5oi/utqO6IUQDhD/s0dA7A+WNEdUVNQf206uV/mOpuAqHz8XM+TOY/JFy/42iYfHn9pX
 mMtFE4lGUk9KxN8WNdseolVx6VrDCw+p+0lR2MWfk0pGiYLNckElS+RiatonE0rDB3l6
 a7eeutj6XWhOEnOGSCdq9X6bUjqyyWxF1L0m/WzH4J+Ax3daGFw2Toi63vkCny8NGGvF
 ub5Q==
X-Gm-Message-State: APuU4Z8GBBV73VAPb9bMg5rnoih3Jr8H+HmHGcx8vy3VQbnCwIDvAIQi
 3y1MVwvbinmJmRsN4ObjOjpta2egrdtpDDJZMbdJYoGHVIIjHE4zTM+SoW3wgxio
X-Gm-Gg: AZFdTZc1W+HR0HBWaCF0pmvWDOqgVdKcMVv6VvVk+oxRrIjas0m07XEbIEOlXXHMVVI
 mwuCNoHrN/GKdDt2FiV8PJkWD9GGeJpNyiUXg1CpmnntFmWQ/nGxDgnIBfGGwM48Be7HAMFXUEF
 W32G3htE9a89HCmLelf+WUIQLXPXWaw4xdnEF5VzKEl+Hu/Z7RdyoTolp/00qe0zBzJFX5wpGr+
 pHm0zcWUgpMm9DQMvWTMIF/lH2tm9r0iORJ5DQgw6r4c5IWd/kufzMaHwKpOvFqKigDz48oUGMD
 r7mlEy5E61lep8We5Ve0+xddo4F+oqtBmMN7nU0hKPK/0vNTRCh+C9/hPillDNfIJNULV4J+Ofl
 KK7K4LIR89m7x7WdYMYD4rlhErkJmmovCiMAe20+SKrQSt78XX1m1+ltHJyTi/o70mdDry+1tOy
 yt2hfd2+d4mfv/U49t9NdH1RFZFkzCBWCT8jjQMejz29TQflz8p8hFZTTnHVRuutLgn/RWKgxxz
 ba3wXb3zLVCb5rPuXCcKnQzrW0gxz50dEksOuzKGXm5bP+WN6GUF1FOTAt3Fch1gwDnuE+ZzdjP
 3wfP168uhMFi8e7HaEVrh/7voW1JJ5QmAfrhW7NkFw==
X-Received: by 2002:a05:7300:26a4:b0:386:b8b7:5f79 with SMTP id
 5a478bee46e88-386b8b76ec9mr8645684eec.21.1795661246855; 
 Wed, 25 Nov 2026 18:47:26 -0800 (PST)
Received: from a-VirtualBox ([168.188.125.88])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-385666e99fdsm70815493eec.5.2026.11.25.18.47.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 18:47:26 -0800 (PST)
From: Minseo Park <hiyoukou@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: tzimmermann@suse.de, alain.volmat@foss.st.com, rgallaispou@gmail.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch, benjamin.gaignard@collabora.com,
 Minseo Park <hiyoukou@gmail.com>
Subject: [PATCH v2 1/4] drm/sti: cursor: do not resize the pixmap from
 .atomic_check()
Date: Thu, 26 Nov 2026 11:47:07 +0900
Message-ID: <20261126024710.33401-2-hiyoukou@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261126024710.33401-1-hiyoukou@gmail.com>
References: <20261126024710.33401-1-hiyoukou@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 26 Nov 2026 08:08:58 +0000
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
index 66f56355309f..7295b6edb8ef 100644
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
+		drm_err(drm_dev, "Failed to allocate memory for pixmap\n");
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

