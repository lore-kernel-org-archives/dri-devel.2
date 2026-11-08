Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501CC606A31C
	for <dri-devel@archiver.kernel.org>; Sun,  8 Nov 2026 19:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dHNfDHEd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE9A910EC84;
	Sun,  8 Nov 2026 19:33:37 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CF2510E831
 for <dri-devel@lists.freedesktop.org>; Sun,  8 Nov 2026 19:33:31 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4a20bde60a0so2107445e9.3
 for <dri-devel@lists.freedesktop.org>; Sun, 08 Nov 2026 11:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794166410; x=1794771210; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WqK6mbkkkr10tJsOCL0yXCIykxjGMKDl1nexZ/2ocm0=;
 b=dHNfDHEd9kfk0EYbFC4/LF0IOk4W9ldZETeI9pL0oH/ctghL9Xx/TtNZ3wuIDN/Cis
 6R0s9l2DB70lqR2crNGjh5vg12EfIjuFXZO/VtOwJPtbddOGF9CccDaS646zqEOzhSw0
 /sSkPUnXqGzN6QZ1hHEGLLDEHOaLxiSIM3sF3wlrqTGcMJj7cT3bWTnYRK9LNnty4XLk
 eVryQeMimMp4liSpompNYANxkFbF8ObJ9ttyt+jBpHUXAg6Ioz6PzrUVwIaLDNOYBl4o
 nP/jYtsVWPqsJU+yisbpr0vew4rDeHTy8HNmggXRYWSoYrsiuHqrtNOezOjXg2Y5dYkN
 j0pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794166410; x=1794771210;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WqK6mbkkkr10tJsOCL0yXCIykxjGMKDl1nexZ/2ocm0=;
 b=Vy08POGuhqGuwtymvaS2O9KOSZlbEo5sKZBpeO3tN2z2Y15Q3Y7RBpl3MoEekNP4yj
 M7Xo0xbHcDfFs+dvFgD0joMxjPh/P7BF3uEyzTejV4kii++mpTa5vZI3UaiFGoDJMS0w
 Al9FmS7gcLhGWvO3AWfwseFX/d7m7nKzoWXoYi5cSjOWvEF4/SiA8gHKTeF3pIcBhF7C
 d1R6BveyG3/OtpZ91yPv5vUduK3AuBbyNKl53ag28YxbsT5z2RqO/zjSIoS45g5W9RFV
 2BrFWahoZsVUUvbkcl8Po2IsPxlwXU3X+ksKL2MyGlI2UpVo0aaqutYnAuO6T4tnUB91
 oEoA==
X-Gm-Message-State: APuU4Z989tsSqEr0ovcSel6kGtibBlwDgj/QWjpZIRviJFKIbSqZo0sy
 NI0rUjaAYQtmP2pgOjAtab/msgibYfCxB8bE8lfiCjl3bI0972XSQZH5
X-Gm-Gg: AYBFou3cBAdbC4eQ2fjNzMMNT6UzKOo52Mpm/XxDVrO7x0IUqflaJaAWlKNPNgOcUk9
 YLvnbxE+UOfb6jRSSsh4J1ek9fVXaHIos0lfN45DsuaYVoWAvdji9YPt7/3Yixtx2Dgdr8JW+5h
 eeo6XtwxusCReacis1wzd6uITimE+a0/kKVPan9SKNShfBe64eKHo9zu46JR/jaXQErKRXTcrzT
 u4R0xgyh6Ng+NMo9HPe6A1iQP/dwdCNEbaXj+7iwN5EQg8Dqy7DCnVE0Ru7GLooSw4oqPziMkqE
 6xqlWSVSezw/WzOiDfPonhxP00UNAPJnDunFbiedm0crFfQqGd41+6F3jYEavaQvmWsDxDAZLyP
 Dczm4Su4amPmV2mpgQuC+CcJAy7ojKiOiHU+FPaNBUx+Dul5gs9NF9a4SDVynnVm8v0ExnTuKUk
 LyVR1/gftkSWfw5ufN988gva5AMv/CFmnCRQRIvsurHBpHqDF9JEKSHzHyz2II23OqZr9dqaJcW
 ojoc6VlHGkbu6jhE/Kfh4Bflv6w1co/r0AEq4/EF3kxaKHqEfu12DoriyAozqi28ZuqooYNscG+
 sqMgCrENpTfOQPABsnpecHlG/B6gDSLDBy7toPFrfg==
X-Received: by 2002:a05:600c:8b70:b0:4a2:fd2:985d with SMTP id
 5b1f17b1804b1-4b963c73ab1mr41078225e9.12.1794166409692; 
 Sun, 08 Nov 2026 11:33:29 -0800 (PST)
Received: from [10.111.176.198] ([2001:19f0:6c01:2c43:5400:5ff:fef6:1b30])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b76cbfa121sm105422115e9.1.2026.11.08.11.33.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2026 11:33:28 -0800 (PST)
From: Oarora Etimis <oaroraetimis@gmail.com>
Date: Sun, 08 Nov 2026 19:33:10 +0000
Subject: [PATCH 2/4] drm/vkms: precompute the gamma LUT for every channel value
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261108-lut-v1-2-f762d70ae4cd@gmail.com>
References: <20261108-lut-v1-0-f762d70ae4cd@gmail.com>
In-Reply-To: <20261108-lut-v1-0-f762d70ae4cd@gmail.com>
To: Louis Chauvet <louis.chauvet@bootlin.com>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Melissa Wen <melissa.srw@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>, 
 Harry Wentland <harry.wentland@amd.com>, 
 Pekka Paalanen <pekka.paalanen@collabora.com>, 
 Arthur Grillo <arthurgrillo@riseup.net>, 
 Helen Koike <helen.fornazier@gmail.com>, 
 Vignesh Raman <vignesh.raman@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Oarora Etimis <oaroraetimis@gmail.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

apply_lut() interpolates every channel of every pixel: three calls to
apply_lut_to_channel_value(), each computing a fixed-point LUT index and
lerping the two neighbouring entries. In virtme-ng with two CPUs, that
makes kms_plane@pixel-format-source-clamping take 78.9-83.8 s and
kms_plane@pixel-format 160.1-167.8 s over ten runs.

A channel value is a u16, so a channel has only 65536 possible inputs.
Compute them once per LUT change into three tables of 65536 u16, in one
allocation of 384 KiB, and let apply_lut() index them by the channel value
itself; composing a pixel then costs three reads. The two subtests drop to
4.87-4.90 s and 9.70-9.84 s.

Entries come from the same apply_lut_to_channel_value(), so the composed
output stays bit-identical to the per-pixel path.

The tables are built in vkms_composer_worker(), outside the composer lock,
on a frame with a CRC pending whose blob differs from the one they were
built from. Holding a reference on that blob keeps its address from being
recycled, so comparing pointers stays a valid identity test for contents
that are immutable once published. They are allocated with kvmalloc() in
vkms_crtc_init() and freed by a device action that also drops the blob
reference - registered before the workqueue, so the workqueue is destroyed
first.

When there is no LUT the tables keep their previous contents; apply_lut()
returns on the NULL base before indexing them.

This patch depends on patch 1: it declares gamma_lut and clears
lut_length when there is no LUT. Applied alone, this patch does not
compile, and the rebuild check would build from a NULL base.

Signed-off-by: Oarora Etimis <oaroraetimis@gmail.com>
---
 drivers/gpu/drm/vkms/vkms_composer.c | 37 ++++++++++++++++++++++++++++++------
 drivers/gpu/drm/vkms/vkms_composer.h |  3 +++
 drivers/gpu/drm/vkms/vkms_crtc.c     | 24 +++++++++++++++++++++++
 drivers/gpu/drm/vkms/vkms_drv.h      |  6 ++++++
 4 files changed, 64 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
index 1d5658bbd493..5bbc34113250 100644
--- a/drivers/gpu/drm/vkms/vkms_composer.c
+++ b/drivers/gpu/drm/vkms/vkms_composer.c
@@ -111,21 +111,37 @@ VISIBLE_IF_KUNIT u16 apply_lut_to_channel_value(const struct vkms_color_lut *lut
 }
 EXPORT_SYMBOL_IF_KUNIT(apply_lut_to_channel_value);
 
+/*
+ * Precompute the LUT for every 16-bit channel value, so that composing a
+ * pixel becomes one table lookup instead of an interpolation.
+ */
+VISIBLE_IF_KUNIT void build_lut_table(const struct vkms_color_lut *lut, u16 *lut_table)
+{
+	enum lut_channel channel;
+	int i;
+
+	for (channel = LUT_RED; channel < LUT_RESERVED; channel++) {
+		for (i = 0; i < LUT_TABLE_ENTRIES; i++)
+			lut_table[channel * LUT_TABLE_ENTRIES + i] =
+				apply_lut_to_channel_value(lut, i, channel);
+	}
+}
+EXPORT_SYMBOL_IF_KUNIT(build_lut_table);
 
 static void apply_lut(const struct vkms_crtc_state *crtc_state, struct line_buffer *output_buffer)
 {
-	if (!crtc_state->gamma_lut.base)
-		return;
+	const struct vkms_output *out = drm_crtc_to_vkms_output(crtc_state->base.crtc);
+	const u16 *table = out->gamma_lut_table;
 
-	if (!crtc_state->gamma_lut.lut_length)
+	if (!crtc_state->gamma_lut.base || !crtc_state->gamma_lut.lut_length)
 		return;
 
 	for (size_t x = 0; x < output_buffer->n_pixels; x++) {
 		struct pixel_argb_u16 *pixel = &output_buffer->pixels[x];
 
-		pixel->r = apply_lut_to_channel_value(&crtc_state->gamma_lut, pixel->r, LUT_RED);
-		pixel->g = apply_lut_to_channel_value(&crtc_state->gamma_lut, pixel->g, LUT_GREEN);
-		pixel->b = apply_lut_to_channel_value(&crtc_state->gamma_lut, pixel->b, LUT_BLUE);
+		pixel->r = table[LUT_RED * LUT_TABLE_ENTRIES + pixel->r];
+		pixel->g = table[LUT_GREEN * LUT_TABLE_ENTRIES + pixel->g];
+		pixel->b = table[LUT_BLUE * LUT_TABLE_ENTRIES + pixel->b];
 	}
 }
 
@@ -653,6 +669,15 @@ void vkms_composer_worker(struct work_struct *work)
 	if (!crc_pending)
 		return;
 
+	/* Rebuild only when the LUT differs from the one the table was built from. */
+	if (gamma_lut != out->gamma_lut_blob) {
+		if (crtc_state->gamma_lut.lut_length)
+			build_lut_table(&crtc_state->gamma_lut, out->gamma_lut_table);
+
+		drm_property_blob_put(out->gamma_lut_blob);
+		out->gamma_lut_blob = gamma_lut ? drm_property_blob_get(gamma_lut) : NULL;
+	}
+
 	if (wb_pending)
 		ret = compose_active_planes(active_wb, crtc_state, &crc32);
 	else
diff --git a/drivers/gpu/drm/vkms/vkms_composer.h b/drivers/gpu/drm/vkms/vkms_composer.h
index 04dd5646f672..b0ee93ba6dbe 100644
--- a/drivers/gpu/drm/vkms/vkms_composer.h
+++ b/drivers/gpu/drm/vkms/vkms_composer.h
@@ -17,11 +17,14 @@ enum lut_channel {
 	LUT_RESERVED
 };
 
+#define LUT_TABLE_ENTRIES	(1U << 16)
+
 #if IS_ENABLED(CONFIG_KUNIT)
 u16 lerp_u16(u16 a, u16 b, s64 t);
 s64 get_lut_index(const struct vkms_color_lut *lut, u16 channel_value);
 u16 apply_lut_to_channel_value(const struct vkms_color_lut *lut, u16 channel_value,
 			       enum lut_channel channel);
+void build_lut_table(const struct vkms_color_lut *lut, u16 *lut_table);
 void apply_3x4_matrix(struct pixel_argb_s32 *pixel, const struct drm_color_ctm_3x4 *matrix);
 #endif
 
diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
index fe17f49305a9..c6ac90fbca2b 100644
--- a/drivers/gpu/drm/vkms/vkms_crtc.c
+++ b/drivers/gpu/drm/vkms/vkms_crtc.c
@@ -11,6 +11,7 @@
 #include <drm/drm_vblank.h>
 #include <drm/drm_vblank_helper.h>
 
+#include "vkms_composer.h"
 #include "vkms_drv.h"
 
 static bool vkms_crtc_handle_vblank_timeout(struct drm_crtc *crtc)
@@ -203,6 +204,14 @@ static const struct drm_crtc_helper_funcs vkms_crtc_helper_funcs = {
 	.handle_vblank_timeout = vkms_crtc_handle_vblank_timeout,
 };
 
+static void vkms_release_gamma_lut(struct drm_device *dev, void *data)
+{
+	struct vkms_output *out = data;
+
+	kvfree(out->gamma_lut_table);
+	drm_property_blob_put(out->gamma_lut_blob);
+}
+
 struct vkms_output *vkms_crtc_init(struct drm_device *dev, struct drm_plane *primary,
 				   struct drm_plane *cursor)
 {
@@ -235,6 +244,21 @@ struct vkms_output *vkms_crtc_init(struct drm_device *dev, struct drm_plane *pri
 	spin_lock_init(&vkms_out->lock);
 	spin_lock_init(&vkms_out->composer_lock);
 
+	/*
+	 * Allocate before composer_workq: drmm frees in reverse order, so the
+	 * workqueue (and any running worker) is destroyed before this table is
+	 * freed.
+	 */
+	vkms_out->gamma_lut_table = kvmalloc_array(LUT_RESERVED * LUT_TABLE_ENTRIES,
+						   sizeof(*vkms_out->gamma_lut_table),
+						   GFP_KERNEL | __GFP_ZERO);
+	if (!vkms_out->gamma_lut_table)
+		return ERR_PTR(-ENOMEM);
+
+	ret = drmm_add_action_or_reset(dev, vkms_release_gamma_lut, vkms_out);
+	if (ret)
+		return ERR_PTR(ret);
+
 	vkms_out->composer_workq = drmm_alloc_ordered_workqueue(dev, "vkms_composer", 0);
 	if (IS_ERR(vkms_out->composer_workq))
 		return ERR_CAST(vkms_out->composer_workq);
diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
index 381483aa4fb0..065a7b07b4ab 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.h
+++ b/drivers/gpu/drm/vkms/vkms_drv.h
@@ -214,6 +214,10 @@ struct vkms_crtc_state {
  *		      writeback)
  * @composer_state: Protected by @lock, current state of this VKMS output
  * @composer_lock: Lock used internally to protect @composer_state members
+ * @gamma_lut_table: Precomputed gamma LUT indexed by the 16-bit channel value. Allocated
+ *		     in vkms_crtc_init() and freed with the device.
+ * @gamma_lut_blob: Blob @gamma_lut_table was built from. Holds a reference so that the
+ *		    blob cannot be freed and reused at the same address with other contents.
  */
 struct vkms_output {
 	struct drm_crtc crtc;
@@ -226,6 +230,8 @@ struct vkms_output {
 	struct vkms_crtc_state *composer_state;
 
 	spinlock_t composer_lock;
+	u16 *gamma_lut_table;
+	struct drm_property_blob *gamma_lut_blob;
 };
 
 struct vkms_config;

-- 
2.55.0

