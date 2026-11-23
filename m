Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7067606A695
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 16:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mI5qwwTs
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F33710EF7F;
	Mon, 23 Nov 2026 16:21:17 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C444410EF7F
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 16:21:10 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-491f34b4e0fso1650521f8f.2
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 08:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795450869; x=1796055669; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fda28KiwfR/uzDKv3MAz6CcnsCAovWf2BbPnW7RFwYc=;
 b=mI5qwwTs7weiOYeCCWRZjlNqEQTLhdZgEJLOOCIzn1blQlVZP89ebn2J+x1CAzU/p8
 GTVkrYlp3G2LXCa5akX7xHAQIjwNTZ6A8W0JlbufCpuPW2Kg7nj/BjRF5IabVZyfwIuy
 Wvub/0d7fIPv4dwx/75cwD7Ua9qpXnpxOLVd3dW6+V9qrQqsmGzOP1tMdSdVYfBU0gO0
 /VUhoi4bQn6LxpfmXz6LAlbdwfRWtujXsBZwYRY04J+Pl/quFLFT6uVB4ej0exyJHu7q
 Bi3IqJ8eDjIcWe7DT9Ae6v+yq9F7+7oD/CWj0H2a0/4Xu9KJkv6Kns6x4CX0uMhz+z2u
 UdEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795450869; x=1796055669;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fda28KiwfR/uzDKv3MAz6CcnsCAovWf2BbPnW7RFwYc=;
 b=NVhHEyUuMyhBl+aRIqLvULfpDMusgfokPO+RWP/iA18WdSEG5uL0vKl9sEvNiJaSXj
 OWDqL0JeTu1OJDVN6/zNxJLwh0f6DFHrfKAyka0h6AaY+tPWeZCBAagBpey9/hEBYTWC
 T+5pZS3AhH3vfZEWWVbSyomI/drWeUMG0Cb/UAPg/LFH2jkzH4ng9OPrHzrrTboApY/p
 MSsDHEd/sGnSkcnzh7TJEFJ0ea2FIC+7dXjAzdGMbJqkyXIGnl4Xv9kBdIeDPSK0VkkT
 k1HyF5wnu+w1/1i1t781wiZnQbT8Qtl0Yz9cPSSyF73sQ5oIZkuuCNxEmoglAGuDgmCM
 r1kQ==
X-Gm-Message-State: APuU4Z+u7A4vBiIjxwxL+Hmc0W1HtD+Wja6/cG1vc6S80jaIFd4KVYX6
 z3p3w7Inc5kCckZHZ7H3F6q3WoDGFkbTGTYupAuY5weXgfFmq2N+0iuq
X-Gm-Gg: AZFdTZf8SHahay1PLtkxvtfgLTg5bd+I7qiUIQnwOl56By0MOO1BuqaV4zYWbcjRa2v
 7GcIFembZ4YodimL0X1SbkfD6Gz8N+CqZFk7D4GTRIqWFg9MzCI+5jYe2PefZPDg6nLTMxw1YOY
 ZTsYKm6tiUK7RdPMrVL5Ltf53VQisA5gicGLH6IgWnxvQdP4kkWas4PRWq07xPwZ4ZUyxqSxYub
 G6W9joDSN3dzo3WOBVBHaRKR1rUkvjYBJptNIv7UKqicideI8S+gqr1VLgjRuDJFEtHisbCFgeO
 LpRbCGULZeHOe2FOf4y0ysLTLoWcaN+9OGKPink2JL3V/RE3DOPdeWE5UaZ+rGXuL9tOXgG0OrB
 PPiuOGNDPLQef/+Unb+NRcCAJDkham4jBDx9b2OuOFsxVBvLox/OfbOcVTHXE1U1T/eI4os5crG
 rygGdI7W8uB7GlgNBej4707+/Fx5LOhXy1smN1PmGMSPGwBaaCNl4KLG6/bB+567UdE1jWHF/Ar
 xov9K6Xmu4buI46q+WlqHpw15vIl7RzzpUWU92DpzTglF6VFSCPWw9dwD/reB3zqSLO5vMN66zz
 33vkwmA0aDKLAJrOsdOxGoadsDI7zcdUMSgx9QJ8
X-Received: by 2002:a5d:588b:0:b0:48e:66d0:664c with SMTP id
 ffacd0b85a97d-4abaf64be12mr24769786f8f.15.1795450869045; 
 Mon, 23 Nov 2026 08:21:09 -0800 (PST)
Received: from [10.56.169.198] ([2001:19f0:6c01:2c43:5400:5ff:fef6:1b30])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6b110ba3sm18863696f8f.35.2026.11.23.08.21.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 08:21:08 -0800 (PST)
From: Oarora Etimis <oaroraetimis@gmail.com>
Date: Mon, 23 Nov 2026 17:20:27 +0100
Subject: [PATCH RESEND 2/4] drm/vkms: precompute the gamma LUT for every
 channel value
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-lut-v1-2-5556c89a2ebd@gmail.com>
References: <20261123-lut-v1-0-5556c89a2ebd@gmail.com>
In-Reply-To: <20261123-lut-v1-0-5556c89a2ebd@gmail.com>
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
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
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
2.56.1

