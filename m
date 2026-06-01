Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EC50CD6E55
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 18:00:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D71C1136A9;
	Mon,  1 Jun 2026 18:00:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="gzcjYXhV";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF3481136A6
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 18:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1780336834;
 bh=NSO9+f4UyIYv1pCXUWepWAtPKVP4X8bGJTPLn/MhlxI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=gzcjYXhVld80Ke1ImNq1+v7Q4A9/7RabfGuVBUjc7sVEAAJM396ZJ0anY30zpjqgx
 8hJPA18INtvBFt55uHn6Iyvg7ec08zO1nMARF6Qp4p4Ek+ZOt+7vATm5ag05hA+BGo
 A//jBQYB7EQHcbBe63cyHksrijaeg3I1h9aFIMt9rZHaL6JaLn+D1B0nbjO5q5EyKD
 tnoTHVH62NIbk/XPelyJXEFhugaI3a1fqaYOd6Pr4O6Nr3djzH+jiFHcCoXrXe5cQB
 kjLEWaomgBwwkW5F8bqtefW5dfYv5wJ1DsqyNKJwzbPIjZEBD6FnhL/3AgX1df/uhE
 0aKkv1zdziwMw==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 0E26117E0852;
 Mon,  1 Jun 2026 20:00:34 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Mon, 01 Jun 2026 21:00:04 +0300
Subject: [PATCH v2 2/2] drm/rockchip: vop2: Add YUV support to background color
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-vop2-bg-yuv-v2-2-e5aef1d16fec@collabora.com>
References: <20260601-vop2-bg-yuv-v2-0-e5aef1d16fec@collabora.com>
In-Reply-To: <20260601-vop2-bg-yuv-v2-0-e5aef1d16fec@collabora.com>
To: Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
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

The VOP2 background color must be programmed with 10-bit precision,
using YUV format when the overlay operates in YUV mode, and RGB
otherwise.

Add the required RGB-to-YCbCr conversion logic, covering all color
spaces supported by the display controller: BT601L, BT601F, BT709L and
BT2020L.

Since the color is currently programmed to hardware on every atomic
commit, minimize the computation cost by splitting the work across the
two paths: in atomic_enable(), perform the conversion unconditionally
(the hardware state is unknown after power-on), while in atomic_flush(),
perform it only when the DRM property has actually changed.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 153 ++++++++++++++++++++++++---
 1 file changed, 138 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
index 64ac07cb1b0d..9b261f0c7eec 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
@@ -728,6 +728,89 @@ static void vop2_setup_csc_mode(struct vop2_video_port *vp,
 	vop2_win_write(win, VOP2_WIN_CSC_MODE, csc_mode);
 }
 
+/*
+ * RGB-to-YCbCr conversion based on color_to_ycbcr() and rgb2ycbcr() from
+ * drivers/media/common/v4l2-tpg/v4l2-tpg-core.c.
+ *
+ * Limited-range Y offset & chroma midpoint are expressed in 16-bit space.
+ */
+#define RGB2YUV_LIMITED_Y_OFFSET	(16 << 8)
+#define RGB2YUV_CHROMA_OFFSET		(128 << 8)
+#define COEFF(v, r)			((s32)(0.5 + (v) * (r) * 256.0))
+
+struct rgb2yuv_matrix {
+	s32 y_r,  y_g,  y_b;
+	s32 cb_r, cb_g, cb_b;
+	s32 cr_r, cr_g, cr_b;
+	s32 y_offset;
+};
+
+/* BT.601 Limited range */
+static const struct rgb2yuv_matrix rgb2yuv_bt601l = {
+	.y_r  = COEFF(0.299, 219),   .y_g  = COEFF(0.587, 219),   .y_b  = COEFF(0.114, 219),
+	.cb_r = COEFF(-0.1687, 224), .cb_g = COEFF(-0.3313, 224), .cb_b = COEFF(0.5, 224),
+	.cr_r = COEFF(0.5, 224),     .cr_g = COEFF(-0.4187, 224), .cr_b = COEFF(-0.0813, 224),
+	.y_offset = RGB2YUV_LIMITED_Y_OFFSET,
+};
+
+/* BT.601 Full range */
+static const struct rgb2yuv_matrix rgb2yuv_bt601f = {
+	.y_r  = COEFF(0.299, 255),   .y_g  = COEFF(0.587, 255),   .y_b  = COEFF(0.114, 255),
+	.cb_r = COEFF(-0.1687, 255), .cb_g = COEFF(-0.3313, 255), .cb_b = COEFF(0.5, 255),
+	.cr_r = COEFF(0.5, 255),     .cr_g = COEFF(-0.4187, 255), .cr_b = COEFF(-0.0813, 255),
+	.y_offset = 0,
+};
+
+/* BT.709 Limited range */
+static const struct rgb2yuv_matrix rgb2yuv_bt709l = {
+	.y_r  = COEFF(0.2126, 219),  .y_g  = COEFF(0.7152, 219),  .y_b  = COEFF(0.0722, 219),
+	.cb_r = COEFF(-0.1146, 224), .cb_g = COEFF(-0.3854, 224), .cb_b = COEFF(0.5, 224),
+	.cr_r = COEFF(0.5, 224),     .cr_g = COEFF(-0.4542, 224), .cr_b = COEFF(-0.0458, 224),
+	.y_offset = RGB2YUV_LIMITED_Y_OFFSET,
+};
+
+/* BT.2020 Limited range */
+static const struct rgb2yuv_matrix rgb2yuv_bt2020l = {
+	.y_r  = COEFF(0.2627, 219),  .y_g  = COEFF(0.6780, 219),  .y_b  = COEFF(0.0593, 219),
+	.cb_r = COEFF(-0.1396, 224), .cb_g = COEFF(-0.3604, 224), .cb_b = COEFF(0.5, 224),
+	.cr_r = COEFF(0.5, 224),     .cr_g = COEFF(-0.4598, 224), .cr_b = COEFF(-0.0402, 224),
+	.y_offset = RGB2YUV_LIMITED_Y_OFFSET,
+};
+
+static const struct rgb2yuv_matrix *
+vop2_rgb2yuv_get_matrix(enum vop_csc_format csc)
+{
+	switch (csc) {
+	case CSC_BT601L:
+		return &rgb2yuv_bt601l;
+	case CSC_BT601F:
+		return &rgb2yuv_bt601f;
+	case CSC_BT2020L:
+		return &rgb2yuv_bt2020l;
+	case CSC_BT709L:
+	default:
+		return &rgb2yuv_bt709l;
+	}
+}
+
+/* Convert an RGB (16bpc) to YUV444 (16bpc). */
+static void vop2_rgb16_to_yuv16(int v4l2_cs, u16 r, u16 g, u16 b,
+				u16 *y, u16 *cb, u16 *cr)
+{
+	enum vop_csc_format csc = vop2_convert_csc_mode(v4l2_cs);
+	const struct rgb2yuv_matrix *m = vop2_rgb2yuv_get_matrix(csc);
+	s64 rs = r, gs = g, bs = b;
+	s64 ys, cbs, crs;
+
+	ys  = m->y_r  * rs + m->y_g  * gs + m->y_b  * bs;
+	cbs = m->cb_r * rs + m->cb_g * gs + m->cb_b * bs;
+	crs = m->cr_r * rs + m->cr_g * gs + m->cr_b * bs;
+
+	*y  = (ys  >> 16) + m->y_offset;
+	*cb = (cbs >> 16) + RGB2YUV_CHROMA_OFFSET;
+	*cr = (crs >> 16) + RGB2YUV_CHROMA_OFFSET;
+}
+
 static void vop2_crtc_enable_irq(struct vop2_video_port *vp, u32 irq)
 {
 	struct vop2 *vop2 = vp->vop2;
@@ -1554,12 +1637,58 @@ static void vop2_dither_setup(struct drm_crtc *crtc, u32 *dsp_ctrl)
 				DITHER_DOWN_ALLEGRO);
 }
 
-static void vop2_post_config(struct drm_crtc *crtc)
+static void vop2_bgcolor_setup(struct drm_crtc *crtc, bool force,
+			       struct drm_crtc_state *new_crtc_state,
+			       struct drm_crtc_state *old_crtc_state)
+{
+	struct rockchip_crtc_state *new_vcstate = to_rockchip_crtc_state(new_crtc_state);
+	struct rockchip_crtc_state *old_vcstate = to_rockchip_crtc_state(old_crtc_state);
+	struct vop2_video_port *vp = to_vop2_video_port(crtc);
+	u64 bgcolor = new_crtc_state->background_color;
+	u16 y, cb, cr;
+	u32 val;
+
+	if (!force && old_crtc_state->background_color == bgcolor &&
+	    old_vcstate->color_space == new_vcstate->color_space)
+		return;
+
+	/*
+	 * Background color is programmed with 10 bits of precision, using YUV
+	 * format when operating in YUV overlay mode, and RGB otherwise.
+	 */
+	if (new_vcstate->yuv_overlay) {
+		vop2_rgb16_to_yuv16(new_vcstate->color_space,
+				    DRM_ARGB64_GETR(bgcolor),
+				    DRM_ARGB64_GETG(bgcolor),
+				    DRM_ARGB64_GETB(bgcolor),
+				    &y, &cb, &cr);
+
+		val = FIELD_PREP(RK3568_VP_DSP_BG__DSP_BG_RED, cr >> 6);
+		FIELD_MODIFY(RK3568_VP_DSP_BG__DSP_BG_GREEN, &val, y >> 6);
+		FIELD_MODIFY(RK3568_VP_DSP_BG__DSP_BG_BLUE, &val, cb >> 6);
+	} else {
+		/*
+		 * Since performance is more important than accuracy here, make
+		 * use of the DRM_ARGB64_GET*_BPCS() helpers.
+		 */
+		val = FIELD_PREP(RK3568_VP_DSP_BG__DSP_BG_RED,
+				 DRM_ARGB64_GETR_BPCS(bgcolor, 10));
+		FIELD_MODIFY(RK3568_VP_DSP_BG__DSP_BG_GREEN, &val,
+			     DRM_ARGB64_GETG_BPCS(bgcolor, 10));
+		FIELD_MODIFY(RK3568_VP_DSP_BG__DSP_BG_BLUE, &val,
+			     DRM_ARGB64_GETB_BPCS(bgcolor, 10));
+	}
+
+	vop2_vp_write(vp, RK3568_VP_DSP_BG, val);
+}
+
+static void vop2_post_config(struct drm_crtc *crtc, bool force,
+			     struct drm_crtc_state *new_crtc_state,
+			     struct drm_crtc_state *old_crtc_state)
 {
 	struct vop2_video_port *vp = to_vop2_video_port(crtc);
 	struct vop2 *vop2 = vp->vop2;
-	struct drm_display_mode *mode = &crtc->state->adjusted_mode;
-	u64 bgcolor = crtc->state->background_color;
+	struct drm_display_mode *mode = &new_crtc_state->adjusted_mode;
 	u16 vtotal = mode->crtc_vtotal;
 	u16 hdisplay = mode->crtc_hdisplay;
 	u16 hact_st = mode->crtc_htotal - mode->crtc_hsync_start;
@@ -1605,15 +1734,7 @@ static void vop2_post_config(struct drm_crtc *crtc)
 		vop2_vp_write(vp, RK3568_VP_POST_DSP_VACT_INFO_F1, val);
 	}
 
-	/*
-	 * Background color is programmed with 10 bits of precision.
-	 * Since performance is more important than accuracy here,
-	 * make use of the DRM_ARGB64_GET*_BPCS() helpers.
-	 */
-	val = FIELD_PREP(RK3568_VP_DSP_BG__DSP_BG_RED, DRM_ARGB64_GETR_BPCS(bgcolor, 10));
-	FIELD_MODIFY(RK3568_VP_DSP_BG__DSP_BG_GREEN, &val, DRM_ARGB64_GETG_BPCS(bgcolor, 10));
-	FIELD_MODIFY(RK3568_VP_DSP_BG__DSP_BG_BLUE, &val, DRM_ARGB64_GETB_BPCS(bgcolor, 10));
-	vop2_vp_write(vp, RK3568_VP_DSP_BG, val);
+	vop2_bgcolor_setup(crtc, force, new_crtc_state, old_crtc_state);
 }
 
 static int us_to_vertical_line(struct drm_display_mode *mode, int us)
@@ -1628,8 +1749,9 @@ static void vop2_crtc_atomic_enable(struct drm_crtc *crtc,
 	struct vop2 *vop2 = vp->vop2;
 	const struct vop2_data *vop2_data = vop2->data;
 	const struct vop2_video_port_data *vp_data = &vop2_data->vp[vp->id];
+	struct drm_crtc_state *old_crtc_state = drm_atomic_get_old_crtc_state(state, crtc);
 	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
-	struct rockchip_crtc_state *vcstate = to_rockchip_crtc_state(crtc->state);
+	struct rockchip_crtc_state *vcstate = to_rockchip_crtc_state(crtc_state);
 	struct drm_display_mode *mode = &crtc->state->adjusted_mode;
 	unsigned long clock = mode->crtc_clock * 1000;
 	u16 hsync_len = mode->crtc_hsync_end - mode->crtc_hsync_start;
@@ -1799,7 +1921,7 @@ static void vop2_crtc_atomic_enable(struct drm_crtc *crtc,
 
 	clk_set_rate(vp->dclk, clock);
 
-	vop2_post_config(crtc);
+	vop2_post_config(crtc, true, crtc_state, old_crtc_state);
 
 	vop2_cfg_done(vp);
 
@@ -1874,6 +1996,7 @@ static void vop2_crtc_atomic_flush(struct drm_crtc *crtc,
 				   struct drm_atomic_commit *state)
 {
 	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
+	struct drm_crtc_state *old_crtc_state = drm_atomic_get_old_crtc_state(state, crtc);
 	struct vop2_video_port *vp = to_vop2_video_port(crtc);
 	struct vop2 *vop2 = vp->vop2;
 
@@ -1881,7 +2004,7 @@ static void vop2_crtc_atomic_flush(struct drm_crtc *crtc,
 	if (!drm_atomic_crtc_needs_modeset(crtc_state) && crtc_state->color_mgmt_changed)
 		vop2_crtc_atomic_try_set_gamma_locked(vop2, vp, crtc, crtc_state);
 
-	vop2_post_config(crtc);
+	vop2_post_config(crtc, false, crtc_state, old_crtc_state);
 
 	vop2_cfg_done(vp);
 

-- 
2.54.0

