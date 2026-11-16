Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1C4606A31C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 08:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.a=rsa-sha256 header.s=altu2504 header.b=XXg6zgCg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3866310E8CE;
	Mon, 16 Nov 2026 08:47:12 +0000 (UTC)
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.155.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DDD610E8CE
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 08:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
 s=altu2504; t=1794818787;
 bh=MeX8+dvE8e0G2O+C6BqwavzIzihFlZhkFMyazb1utO8=;
 h=From:To:Subject:Date:Message-Id;
 b=XXg6zgCg6PaDHCRl78aA09EmzFWu4tWpxRggh1MW8PNUTSFKeUFfS5p8TDJ4sxxai
 tDHGxX/a7V7yPfhDeCJAEJpqLiSuyXa8trjLkFAl51SqHnXVjNBb8J2TjCVkzMEe8B
 OHczEqSPmw8RJ10MdUGenbBz3c8D51+jJskz/FiE=
X-QQ-mid: esmtpgz13t1794818779tef2241dd
X-QQ-Originating-IP: mZrGDoWwxBCBW7gFIrAX6JDdhU7uU9pmJ8YmO6NgKbo=
Received: from DESKTOP-8BT1A2O.localdomain ( [58.22.7.114])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 16 Nov 2026 16:46:14 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9485749444014407588
From: Chaoyi Chen <kernel@airkyi.com>
To: Sandy Huang <hjc@rock-chips.com>,
 =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andyshrk@163.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Chaoyi Chen <chaoyi.chen@rock-chips.com>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v3 3/3] drm/rockchip: vop2: Support 8K output by splicing two
 video ports
Date: Mon, 16 Nov 2026 16:45:55 +0800
Message-Id: <20261116084555.1061-4-kernel@airkyi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20261116084555.1061-1-kernel@airkyi.com>
References: <20261116084555.1061-1-kernel@airkyi.com>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:airkyi.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MPtvDXbctkRmM03opKLZ7ZT/aZiVrjRiyl0MAQSH83IcAQZ/pLN0ryIV
 leAgItjR9BxtcUJ6B0Tv5LqLZcDztWLcmUx+Wi3dRr+bbqYW4aGfkhPt+JeBOtYT9HTEUQQ
 Epx9P/a8hMDAUvoysbfecMDIy/W4h8F2Bw1Tux4bSFLghEXiyAR4+3WEHtxlbvjiq57fOz5
 qQqdPe8M5nj9o/OMerMgEJ2UMg4NmO/ZWpYca/6KS1b26uiP3B0uzPIuYOp+OkEhAJZbT7y
 jZhYQwrrCiLdXjxcnVyQVZPzeVQB9ioOlf3qw6TUtjmSjm9RXOZBXdMYkTmzi8B4eY5o0OB
 kgZJoh/10WQ1XmX8DpEeNojkEcckflQ/tqpR0wmMgm0CbgdIFBFVnOmEzMs49ZHmT+8wFcS
 HVoFJQXkug41lns58xA2uOSTXmrSCEUgcavtIWD+IVPg8ANKmVVtj3AgNrG+8gY8HXd23AW
 2aTffpKw/ss8AWXu1UngL7pM7RO3O5XEr6TzqgDYhoS0a0R+/+hmiKXvZSBa1wrbl9BISnb
 JDe/lAXftT4BQEsjL8Aa7ThsGcDJj1V/LIuDzEmesrM75GihHS/muN3so4afC5Xvhw8PwCR
 0mwuW1iIWWOPPRToy95RjdQgYkSk8b+GoeEGgS7v38MmFdkEWpRYPKzoQ1xyzVPHz1sL+8q
 aip94PAmHT7pLFeKuEWslby+XXgU9cZbg8en5FPEj/4w4DDkskTL11h+7hOlOlyO2j3LkPW
 5h7ZqzP44fzgwy2rp9DNfLgBe+sXi3xE34ERBGrbfU9xOARJYrsrntJVCd5ZQd3sNVu0rL2
 fZDjSOKHS96YdSQ90W9F2VpP6ONozredXpR5PZBoeOd7LiqlRI8t71hPb1XmY5mXXtMjxhv
 a9DVLwXCoCH01Q2lpg+b9Z1djvXfCNwL3fQNW/eLPTRu8+68SbN2h73FO5EczXerUX6rhlX
 dv8VmCj/GWjL6Ued1eXcttBKN9JUX7sb6ZvOsWr6KCJw/B3dA/P9+JuEMw40FejLVO4Q34F
 dzwAL2wFTJoI3t0yKvNYW4w+yETGP6QlQBj7zB6Q==
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

From: Chaoyi Chen <chaoyi.chen@rock-chips.com>

A single RK3588 video port can only drive 4096 pixels per line, so
modes wider than that (e.g. 7680x4320) cannot be output by one video
port alone. The VOP2 can instead merge video ports and two windows:
VP0 drives the left half of the screen, VP1 the right half, and each
plane of the CRTC is split horizontally between a window pair
(Cluster0/1, Cluster2/3, Esmart0/1, Esmart2/3).

Three components need to be configured: the CRTC, the plane and the
post-processing block.

1. For CRTC

In splice mode the CRTC reserved for VP1 is taken over, so make the
following changes:

vop2_crtc_atomic_check() sets the new splice_mode flag for modes
wider than VOP2_MAX_VP_OUTPUT_WIDTH, reserves the partner video port
(rejecting the commit if it is already active) and verifies that both
video ports have enough layers for the planes of the CRTC. The
reserved video port is taken into account when the layers are
distributed over the video ports, and it is registered so that its
windows exist, but its own CRTC is kept unusable while it serves as
the right half.

2. For Plane

To avoid requiring additional userspace changes, the plane split is
performed in the driver. Userspace can thereforekeep updating a single
plane that is 8K wide. To do so, make the following changes:

vop2_plane_atomic_check() accepts a source width of twice the maximum
input width and validates the split: the plane must use a window with
the WIN_FEATURE_SPLICE_LEFT flag, must not be rotated or x-mirrored,
and cluster windows that scale down may only do so centred on the
screen with a factor below 1.2.

vop2_plane_atomic_update() calculates the left and right source and
destination rectangles and programs both windows of a plane pair from
the same plane state.

3. For post-processing block

The overlay, alpha and layer mixer setup iterate over the window mask
of a video port instead of the planes of its CRTC, because the right
video port has no planes of its own. A right window resolves its
plane state through left_win.

Gamma LUT and background colour setup are applied to the partner
video port as well.

For ease of handling, we impose the following restrictions:
- When VP1 is occupied by splice mode, reject acquiring its mode
  in .mode_valid.
- When splice mode is enabled, the next commit must not disable
  splice mode and enable VP1 at the same time.

Assisted-by: LLM
Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
---
Changes in v3:
- Rework the left-window splice check to avoid pulling an unrelated CRTC
  into non-modeset commits, and use the new CRTC mode instead of the
  stale splice_mode flag(Sashiko).
- Reserve the splice partner window when the partner VP has no CRTC, so
  it cannot be assigned as another VP's primary plane(Sashiko).
- Only set the partner VP's CFG_DONE while the new state is in splice
  mode; do not force it when leaving splice mode(Sashiko).
- Program the main and splice video ports in a single layer-mixer pass,
  and apply the YUV overlay mode to both VPs(Sashiko).

Changes in v2:
- vop2_win_get_pstate(): use the left window's state only in splice mode(Sashiko).
- Reject splice windows already in use by another CRTC(Sashiko).
- Check the splice partner via drm_atomic_get_crtc_state() instead of the runtime flag and unlocked read(Sashiko).
- Set splice_mode_right/left_vp before the error paths of vop2_crtc_atomic_enable()(Sashiko).
- Validate each split half against the min width 4 and max input width; align NV20/NV30 like NV15(Sashiko).
- Latch overlay registers at the left VP's vsync; don't wait for the partner's own cfg-done(Sashiko).
- Program the color key on the window actually being updated(Sashiko).
---
 drivers/gpu/drm/rockchip/rockchip_drm_drv.h  |   5 +
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 571 +++++++++++++++++--
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.h |  66 ++-
 drivers/gpu/drm/rockchip/rockchip_vop2_reg.c | 370 ++++++++----
 4 files changed, 853 insertions(+), 159 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
index 4705dc6b8bd7..db4d50dd3dc9 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
@@ -54,6 +54,11 @@ struct rockchip_crtc_state {
 	int output_flags;
 	bool enable_afbc;
 	bool yuv_overlay;
+	/**
+	 * @splice_mode: two video ports are joined together to drive a
+	 * display that is wider than a single video port can handle.
+	 */
+	bool splice_mode;
 	u32 bus_format;
 	u32 bus_flags;
 	int color_space;
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
index e811709bdc72..c8bf397da705 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
@@ -150,6 +150,7 @@ static void vop2_unlock(struct vop2 *vop2)
 static void vop2_win_disable(struct vop2_win *win)
 {
 	vop2_win_write(win, VOP2_WIN_ENABLE, 0);
+	vop2_win_write(win, VOP2_WIN_YUV_CLIP, 0);
 
 	if (vop2_cluster_window(win))
 		vop2_win_write(win, VOP2_WIN_CLUSTER_ENABLE, 0);
@@ -426,9 +427,9 @@ static bool vop2_half_block_enable(struct drm_plane_state *pstate)
 }
 
 static u32 vop2_afbc_transform_offset(struct drm_plane_state *pstate,
+				      struct drm_rect *src,
 				      bool afbc_half_block_en)
 {
-	struct drm_rect *src = &pstate->src;
 	struct drm_framebuffer *fb = pstate->fb;
 	u32 bpp = vop2_get_bpp(fb->format);
 	u32 vir_width = (fb->pitches[0] << 3) / bpp;
@@ -1012,13 +1013,32 @@ static void vop2_crtc_atomic_disable(struct drm_crtc *crtc,
 				     struct drm_atomic_commit *state)
 {
 	struct vop2_video_port *vp = to_vop2_video_port(crtc);
+	struct rockchip_crtc_state *old_vcstate;
+	struct vop2_video_port *splice_vp = NULL;
 	struct vop2 *vop2 = vp->vop2;
 	struct drm_crtc_state *old_crtc_state;
+	struct drm_plane *plane;
 	int ret;
 
 	vop2_lock(vop2);
 
 	old_crtc_state = drm_atomic_get_old_crtc_state(state, crtc);
+	old_vcstate = to_rockchip_crtc_state(old_crtc_state);
+	splice_vp = old_vcstate->splice_mode ? vop2_get_splice_vp(vp) : NULL;
+
+	/*
+	 * The right windows are not tracked by the plane states, disable
+	 * them before the video ports are put into standby.
+	 */
+	if (splice_vp) {
+		drm_atomic_crtc_state_for_each_plane(plane, old_crtc_state) {
+			struct vop2_win *win = to_vop2_win(plane)->splice_win;
+
+			if (win)
+				vop2_win_disable(win);
+		}
+	}
+
 	drm_atomic_helper_disable_planes_on_crtc(old_crtc_state, false);
 
 	drm_crtc_vblank_off(crtc);
@@ -1034,6 +1054,9 @@ static void vop2_crtc_atomic_disable(struct drm_crtc *crtc,
 
 	vop2_crtc_enable_irq(vp, VP_INT_DSP_HOLD_VALID);
 
+	if (splice_vp)
+		vop2->ops->setup_splice(vp, false);
+
 	vop2_vp_write(vp, RK3568_VP_DSP_CTRL, RK3568_VP_DSP_CTRL__STANDBY);
 
 	ret = wait_for_completion_timeout(&vp->dsp_hold_completion,
@@ -1043,6 +1066,11 @@ static void vop2_crtc_atomic_disable(struct drm_crtc *crtc,
 
 	vop2_crtc_disable_irq(vp, VP_INT_DSP_HOLD_VALID);
 
+	if (splice_vp) {
+		splice_vp->splice_mode_right = false;
+		splice_vp->left_vp = NULL;
+	}
+
 	if (vp->dclk_src)
 		clk_set_parent(vp->dclk, vp->dclk_src);
 
@@ -1064,6 +1092,244 @@ static void vop2_crtc_atomic_disable(struct drm_crtc *crtc,
 	}
 }
 
+static bool vop2_vp_uses_splice(struct vop2_video_port *vp,
+				struct drm_crtc_state *cstate)
+{
+	if (!(vp->vop2->data->feature & VOP2_FEATURE_SPLICE))
+		return false;
+
+	return cstate->adjusted_mode.hdisplay > VOP2_MAX_VP_OUTPUT_WIDTH;
+}
+
+static struct vop2_video_port *
+vop2_find_left_splice_vp(struct vop2 *vop2, int right_vp_id)
+{
+	const struct vop2_data *vop2_data = vop2->data;
+	int i;
+
+	if (!(vop2_data->feature & VOP2_FEATURE_SPLICE))
+		return NULL;
+
+	for (i = 0; i < vop2_data->nr_vps; i++) {
+		const struct vop2_video_port_data *vp_data = &vop2_data->vp[i];
+
+		if (vp_data->max_output.width <= VOP2_MAX_VP_OUTPUT_WIDTH)
+			continue;
+
+		if (vp_data->splice_vp_id == right_vp_id)
+			return &vop2->vps[i];
+	}
+
+	return NULL;
+}
+
+static int vop2_calc_splice_rects(struct drm_plane_state *pstate,
+				  struct drm_crtc_state *cstate,
+				  struct drm_rect *left_src,
+				  struct drm_rect *left_dst,
+				  struct drm_rect *right_src,
+				  struct drm_rect *right_dst)
+{
+	struct drm_rect *src = &pstate->src;
+	struct drm_rect *dst = &pstate->dst;
+	struct drm_framebuffer *fb = pstate->fb;
+	int half_hdisplay = cstate->adjusted_mode.crtc_hdisplay >> 1;
+	int hscale = drm_rect_calc_hscale(src, dst, 0, INT_MAX);
+	int dst_w = drm_rect_width(dst);
+	int src_w = drm_rect_width(src) >> 16;
+	int left_dst_w, left_src_w, right_dst_w;
+
+	if (hscale < 0)
+		return hscale;
+
+	left_dst_w = min(half_hdisplay, dst->x2) - dst->x1;
+	if (left_dst_w < 0)
+		left_dst_w = 0;
+	right_dst_w = dst_w - left_dst_w;
+
+	if (!right_dst_w)
+		left_src_w = src_w;
+	else
+		left_src_w = (left_dst_w * hscale) >> 16;
+
+	/*
+	 * Make sure the yrgb/uv mst of the right window are byte aligned
+	 * with full pixel.
+	 */
+	if (right_dst_w) {
+		if (fb->format->format == DRM_FORMAT_NV15 ||
+		    fb->format->format == DRM_FORMAT_NV20 ||
+		    fb->format->format == DRM_FORMAT_NV30)
+			left_src_w &= ~0x7;
+		else if (fb->format->is_yuv)
+			left_src_w &= ~0x1;
+	}
+
+	if (left_src_w > src_w)
+		left_src_w = src_w;
+
+	left_src->x1 = src->x1;
+	left_src->x2 = src->x1 + (left_src_w << 16);
+	left_dst->x1 = dst->x1;
+	left_dst->x2 = dst->x1 + left_dst_w;
+
+	right_src->x1 = left_src->x2;
+	right_src->x2 = src->x2;
+	right_dst->x1 = dst->x1 + left_dst_w - half_hdisplay;
+	if (right_dst->x1 < 0)
+		right_dst->x1 = 0;
+	right_dst->x2 = right_dst->x1 + right_dst_w;
+
+	left_src->y1 = right_src->y1 = src->y1;
+	left_src->y2 = right_src->y2 = src->y2;
+	left_dst->y1 = right_dst->y1 = dst->y1;
+	left_dst->y2 = right_dst->y2 = dst->y2;
+
+	return 0;
+}
+
+static int vop2_splice_part_size_check(struct vop2_win *win,
+				       struct drm_rect *src,
+				       struct drm_rect *dst)
+{
+	struct vop2 *vop2 = win->vop2;
+
+	if (!drm_rect_width(dst))
+		return 0;
+
+	if (drm_rect_width(dst) < 4 || (drm_rect_width(src) >> 16) < 4 ||
+	    (drm_rect_width(src) >> 16) > vop2->data->max_input.width) {
+		drm_dbg_kms(vop2->drm,
+			    "%s: split %dx%d->%dx%d, min width is 4, max input width is %d\n",
+			    win->data->name, drm_rect_width(src) >> 16,
+			    drm_rect_height(src) >> 16, drm_rect_width(dst),
+			    drm_rect_height(dst), vop2->data->max_input.width);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int vop2_cluster_splice_scale_check(struct vop2_win *win,
+					   struct drm_plane_state *pstate,
+					   int hdisplay)
+{
+	struct drm_rect *src = &pstate->src;
+	struct drm_rect *dst = &pstate->dst;
+	int half_hdisplay = hdisplay >> 1;
+
+	/* scale up is ok */
+	if ((drm_rect_width(src) >> 16) <= drm_rect_width(dst))
+		return 0;
+
+	if ((drm_rect_width(src) >> 16) <= VOP2_MAX_VP_OUTPUT_WIDTH)
+		return 0;
+	/*
+	 * Cluster scale down limitation in splice mode:
+	 * If scale down, must display at horizontal center
+	 */
+	if (dst->x1 < half_hdisplay && dst->x2 > half_hdisplay) {
+		if (dst->x2 + dst->x1 != hdisplay) {
+			drm_dbg_kms(win->vop2->drm,
+				    "%s must scale down at center in splice mode\n",
+				    win->data->name);
+			return -EINVAL;
+		}
+
+		if (drm_rect_calc_hscale(src, dst, 1, FRAC_16_16(6, 5)) < 0) {
+			drm_dbg_kms(win->vop2->drm,
+				    "%s scale down factor should be < 1.2 in splice mode\n",
+				    win->data->name);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+static int vop2_plane_splice_check(struct drm_plane_state *pstate,
+				   struct drm_crtc_state *cstate)
+{
+	struct vop2_win *win = to_vop2_win(pstate->plane);
+	struct vop2 *vop2 = win->vop2;
+	struct vop2_win *splice_win = win->splice_win;
+	struct drm_rect left_src, left_dst, right_src, right_dst;
+	int ret;
+
+	if (!(win->data->feature & WIN_FEATURE_SPLICE_LEFT) || !splice_win) {
+		drm_dbg_kms(vop2->drm, "%s cannot be used in splice mode\n",
+			    win->data->name);
+		return -EINVAL;
+	}
+
+	if (pstate->rotation & (DRM_MODE_ROTATE_90 | DRM_MODE_ROTATE_270 |
+				DRM_MODE_REFLECT_X)) {
+		drm_dbg_kms(vop2->drm, "%s can't rotate 270/90 and xmirror in splice mode\n",
+			    win->data->name);
+		return -EINVAL;
+	}
+
+	if (vop2_cluster_window(win)) {
+		ret = vop2_cluster_splice_scale_check(win, pstate,
+						      cstate->adjusted_mode.hdisplay);
+		if (ret)
+			return ret;
+	}
+
+	ret = vop2_calc_splice_rects(pstate, cstate, &left_src, &left_dst,
+				     &right_src, &right_dst);
+	if (ret)
+		return ret;
+
+	ret = vop2_splice_part_size_check(win, &left_src, &left_dst);
+	if (ret)
+		return ret;
+
+	return vop2_splice_part_size_check(splice_win, &right_src, &right_dst);
+}
+
+static int vop2_plane_left_in_splice(struct drm_plane *plane,
+				     struct drm_atomic_commit *state)
+{
+	struct vop2_win *win = to_vop2_win(plane);
+	struct drm_plane_state *lstate;
+	struct drm_crtc_state *lcstate;
+	struct drm_crtc *lcrtc;
+	int ret;
+
+	if (!win->left_win)
+		return 0;
+
+	lstate = drm_atomic_get_new_plane_state(state, &win->left_win->base);
+	if (!lstate) {
+		ret = drm_modeset_lock(&win->left_win->base.mutex,
+				       state->acquire_ctx);
+		if (ret && ret != -EALREADY)
+			return ret;
+
+		lstate = win->left_win->base.state;
+	}
+
+	if (!lstate || !lstate->crtc)
+		return 0;
+
+	lcrtc = lstate->crtc;
+
+	lcstate = drm_atomic_get_new_crtc_state(state, lcrtc);
+	if (!lcstate) {
+		ret = drm_modeset_lock(&lcrtc->mutex, state->acquire_ctx);
+		if (ret && ret != -EALREADY)
+			return ret;
+
+		lcstate = lcrtc->state;
+	}
+
+	if (!lcstate || !lcstate->enable)
+		return 0;
+
+	return vop2_vp_uses_splice(to_vop2_video_port(lcrtc), lcstate);
+}
+
 static int vop2_plane_atomic_check(struct drm_plane *plane,
 				   struct drm_atomic_commit *astate)
 {
@@ -1081,6 +1347,7 @@ static int vop2_plane_atomic_check(struct drm_plane *plane,
 	int max_scale = FRAC_16_16(8, 1);
 	int src_x, src_w, src_h;
 	int dest_w, dest_h;
+	int max_src_w;
 	int format;
 	int ret;
 
@@ -1122,15 +1389,33 @@ static int vop2_plane_atomic_check(struct drm_plane *plane,
 		return -EINVAL;
 	}
 
-	if (src_w > vop2_data->max_input.width ||
-	    src_h > vop2_data->max_input.height) {
+	max_src_w = vop2_data->max_input.width;
+	if (vop2_vp_uses_splice(vp, cstate))
+		max_src_w *= 2;
+
+	if (src_w > max_src_w || src_h > vop2_data->max_input.height) {
 		drm_dbg_kms(vop2->drm, "Invalid source: %dx%d. max input: %dx%d\n",
-			    src_w, src_h,
-			    vop2_data->max_input.width,
-			    vop2_data->max_input.height);
+			    src_w, src_h, max_src_w, vop2_data->max_input.height);
 		return -EINVAL;
 	}
 
+	if (vop2_vp_uses_splice(vp, cstate)) {
+		ret = vop2_plane_splice_check(pstate, cstate);
+		if (ret)
+			return ret;
+	}
+
+	if (win->left_win) {
+		ret = vop2_plane_left_in_splice(plane, astate);
+		if (ret < 0)
+			return ret;
+		if (ret) {
+			drm_dbg_kms(vop2->drm, "%s is in use by %s in splice mode\n",
+				    win->left_win->data->name, win->data->name);
+			return -EBUSY;
+		}
+	}
+
 	/*
 	 * Src.x1 can be odd when do clip, but yuv plane start point
 	 * need align with 2 pixel.
@@ -1180,8 +1465,10 @@ static void vop2_plane_atomic_disable(struct drm_plane *plane,
 				      struct drm_atomic_commit *state)
 {
 	struct drm_plane_state *old_pstate = NULL;
+	struct drm_crtc_state *old_cstate = NULL;
 	struct vop2_win *win = to_vop2_win(plane);
 	struct vop2 *vop2 = win->vop2;
+	bool splice = false;
 
 	drm_dbg(vop2->drm, "%s disable\n", win->data->name);
 
@@ -1190,19 +1477,26 @@ static void vop2_plane_atomic_disable(struct drm_plane *plane,
 	if (old_pstate && !old_pstate->crtc)
 		return;
 
+	if (old_pstate) {
+		old_cstate = drm_atomic_get_old_crtc_state(state, old_pstate->crtc);
+		splice = to_rockchip_crtc_state(old_cstate)->splice_mode;
+	}
+
+	if (splice && win->splice_win)
+		vop2_win_disable(win->splice_win);
+
 	vop2_win_disable(win);
-	vop2_win_write(win, VOP2_WIN_YUV_CLIP, 0);
 }
 
 /*
  * The color key is 10 bit, so all format should
  * convert to 10 bit here.
  */
-static void vop2_plane_setup_color_key(struct drm_plane *plane, u32 color_key)
+static void vop2_win_setup_color_key(struct vop2_win *win,
+				     struct drm_plane_state *pstate,
+				     u32 color_key)
 {
-	struct drm_plane_state *pstate = plane->state;
 	struct drm_framebuffer *fb = pstate->fb;
-	struct vop2_win *win = to_vop2_win(plane);
 	u32 color_key_en = 0;
 	u32 r = 0;
 	u32 g = 0;
@@ -1244,12 +1538,11 @@ static void vop2_plane_setup_color_key(struct drm_plane *plane, u32 color_key)
 	vop2_win_write(win, VOP2_WIN_COLOR_KEY, (r << 20) | (g << 10) | b);
 }
 
-static void vop2_plane_atomic_update(struct drm_plane *plane,
-				     struct drm_atomic_commit *state)
+static void vop2_win_atomic_update(struct vop2_win *win, struct drm_rect *src,
+				   struct drm_rect *dest,
+				   struct drm_plane_state *pstate)
 {
-	struct drm_plane_state *pstate = plane->state;
 	struct drm_crtc *crtc = pstate->crtc;
-	struct vop2_win *win = to_vop2_win(plane);
 	struct vop2_video_port *vp = to_vop2_video_port(crtc);
 	struct drm_display_mode *adjusted_mode = &crtc->state->adjusted_mode;
 	struct vop2 *vop2 = win->vop2;
@@ -1261,8 +1554,6 @@ static void vop2_plane_atomic_update(struct drm_plane *plane,
 	u32 afbc_format;
 	u32 rb_swap;
 	u32 uv_swap;
-	struct drm_rect *src = &pstate->src;
-	struct drm_rect *dest = &pstate->dst;
 	u32 afbc_tile_num;
 	u32 transform_offset;
 	bool dither_up;
@@ -1283,8 +1574,10 @@ static void vop2_plane_atomic_update(struct drm_plane *plane,
 	if (WARN_ON(!crtc))
 		return;
 
-	if (!pstate->visible) {
-		vop2_plane_atomic_disable(plane, state);
+	/* disable no visible window */
+	if (!drm_rect_width(src) || !drm_rect_height(src) ||
+	    !drm_rect_width(dest) || !drm_rect_height(dest)) {
+		vop2_win_disable(win);
 		return;
 	}
 
@@ -1424,7 +1717,7 @@ static void vop2_plane_atomic_update(struct drm_plane *plane,
 			vop2_win_write(win, VOP2_WIN_AFBC_PLD_OFFSET, yrgb_mst);
 		}
 
-		transform_offset = vop2_afbc_transform_offset(pstate, half_block_en);
+		transform_offset = vop2_afbc_transform_offset(pstate, src, half_block_en);
 		vop2_win_write(win, VOP2_WIN_AFBC_HDR_PTR, yrgb_mst);
 		vop2_win_write(win, VOP2_WIN_AFBC_PIC_SIZE, act_info);
 		vop2_win_write(win, VOP2_WIN_TRANSFORM_OFFSET, transform_offset);
@@ -1467,7 +1760,7 @@ static void vop2_plane_atomic_update(struct drm_plane *plane,
 
 	vop2_setup_scale(vop2, win, src_w, src_h, dsp_w, dsp_h, fb->format->format);
 	if (!vop2_cluster_window(win))
-		vop2_plane_setup_color_key(plane, 0);
+		vop2_win_setup_color_key(win, pstate, 0);
 	vop2_win_write(win, VOP2_WIN_ACT_INFO, act_info);
 	vop2_win_write(win, VOP2_WIN_DSP_INFO, dsp_info);
 	vop2_win_write(win, VOP2_WIN_DSP_ST, dest->y1 << 16 | (dest->x1 & 0xffff));
@@ -1487,6 +1780,45 @@ static void vop2_plane_atomic_update(struct drm_plane *plane,
 	}
 }
 
+static void vop2_plane_atomic_update(struct drm_plane *plane,
+				     struct drm_atomic_commit *state)
+{
+	struct drm_plane_state *pstate = plane->state;
+	struct drm_crtc *crtc = pstate->crtc;
+	struct vop2_win *win = to_vop2_win(plane);
+	struct drm_crtc_state *cstate;
+	struct rockchip_crtc_state *vcstate;
+	struct drm_rect left_src, left_dst, right_src, right_dst;
+
+	if (WARN_ON(!crtc))
+		return;
+
+	if (!pstate->visible) {
+		vop2_plane_atomic_disable(plane, state);
+		return;
+	}
+
+	cstate = drm_atomic_get_new_crtc_state(state, crtc);
+	if (!cstate)
+		cstate = crtc->state;
+	vcstate = to_rockchip_crtc_state(cstate);
+
+	if (!vcstate->splice_mode) {
+		vop2_win_atomic_update(win, &pstate->src, &pstate->dst, pstate);
+		return;
+	}
+
+	if (!win->splice_win)
+		return;
+
+	if (WARN_ON(vop2_calc_splice_rects(pstate, cstate, &left_src, &left_dst,
+					  &right_src, &right_dst)))
+		return;
+
+	vop2_win_atomic_update(win, &left_src, &left_dst, pstate);
+	vop2_win_atomic_update(win->splice_win, &right_src, &right_dst, pstate);
+}
+
 static const struct drm_plane_helper_funcs vop2_plane_helper_funcs = {
 	.atomic_check = vop2_plane_atomic_check,
 	.atomic_update = vop2_plane_atomic_update,
@@ -1524,6 +1856,16 @@ static enum drm_mode_status vop2_crtc_mode_valid(struct drm_crtc *crtc,
 {
 	struct vop2_video_port *vp = to_vop2_video_port(crtc);
 
+	/*
+	 * For RK3588, VP0 and VP1 will be both used in splice mode. All display
+	 * modes of the right VP should be set as invalid when vop2 is working in
+	 * splice mode.
+	 */
+	if (vp->splice_mode_right) {
+		DRM_DEV_DEBUG(vp->vop2->dev, "vp%d is in splice mode right\n", vp->id);
+		return MODE_BAD;
+	}
+
 	if (mode->hdisplay > vp->data->max_output.width)
 		return MODE_BAD_HVALUE;
 
@@ -1561,8 +1903,9 @@ static void vop2_crtc_atomic_set_gamma_seamless(struct vop2 *vop2,
 						struct vop2_video_port *vp,
 						struct drm_crtc *crtc)
 {
-	vop2_writel(vop2, RK3568_LUT_PORT_SEL,
-		    FIELD_PREP(RK3588_LUT_PORT_SEL__GAMMA_AHB_WRITE_SEL, vp->id));
+	regmap_update_bits(vop2->map, RK3568_LUT_PORT_SEL,
+			   RK3588_LUT_PORT_SEL__GAMMA_AHB_WRITE_SEL,
+			   FIELD_PREP(RK3588_LUT_PORT_SEL__GAMMA_AHB_WRITE_SEL, vp->id));
 	vop2_vp_dsp_lut_enable(vp);
 	vop2_crtc_write_gamma_lut(vop2, crtc);
 	vop2_vp_dsp_lut_update_enable(vp);
@@ -1573,7 +1916,7 @@ static void vop2_crtc_atomic_set_gamma_rk356x(struct vop2 *vop2,
 					      struct drm_crtc *crtc)
 {
 	vop2_vp_dsp_lut_disable(vp);
-	vop2_cfg_done(vp);
+	vop2_cfg_done(vp, false);
 	if (!vop2_vp_dsp_lut_poll_disabled(vp))
 		return;
 
@@ -1587,18 +1930,25 @@ static void vop2_crtc_atomic_try_set_gamma(struct vop2 *vop2,
 					   struct drm_crtc *crtc,
 					   struct drm_crtc_state *crtc_state)
 {
+	struct rockchip_crtc_state *vcstate = to_rockchip_crtc_state(crtc_state);
+
 	if (!vop2->lut_regs)
 		return;
 
 	if (!crtc_state->gamma_lut) {
 		vop2_vp_dsp_lut_disable(vp);
+		if (vcstate->splice_mode)
+			vop2_vp_dsp_lut_disable(vop2_get_splice_vp(vp));
 		return;
 	}
 
-	if (vop2_supports_seamless_gamma_lut_update(vop2))
+	if (vop2_supports_seamless_gamma_lut_update(vop2)) {
 		vop2_crtc_atomic_set_gamma_seamless(vop2, vp, crtc);
-	else
+		if (vcstate->splice_mode)
+			vop2_crtc_atomic_set_gamma_seamless(vop2, vop2_get_splice_vp(vp), crtc);
+	} else {
 		vop2_crtc_atomic_set_gamma_rk356x(vop2, vp, crtc);
+	}
 }
 
 static inline void vop2_crtc_atomic_try_set_gamma_locked(struct vop2 *vop2,
@@ -1640,13 +1990,12 @@ static void vop2_dither_setup(struct drm_crtc *crtc, u32 *dsp_ctrl)
 				DITHER_DOWN_ALLEGRO);
 }
 
-static void vop2_bgcolor_setup(struct drm_crtc *crtc, bool force,
+static void vop2_bgcolor_setup(struct vop2_video_port *vp, bool force,
 			       struct drm_crtc_state *new_crtc_state,
 			       struct drm_crtc_state *old_crtc_state)
 {
 	struct rockchip_crtc_state *new_vcstate = to_rockchip_crtc_state(new_crtc_state);
 	struct rockchip_crtc_state *old_vcstate = to_rockchip_crtc_state(old_crtc_state);
-	struct vop2_video_port *vp = to_vop2_video_port(crtc);
 	u64 bgcolor = new_crtc_state->background_color;
 	u16 y, cb, cr;
 	u32 val;
@@ -1690,6 +2039,8 @@ static void vop2_post_config(struct drm_crtc *crtc, bool force,
 			     struct drm_crtc_state *old_crtc_state)
 {
 	struct vop2_video_port *vp = to_vop2_video_port(crtc);
+	struct rockchip_crtc_state *new_vcstate = to_rockchip_crtc_state(new_crtc_state);
+	struct vop2_video_port *splice_vp = NULL;
 	struct vop2 *vop2 = vp->vop2;
 	struct drm_display_mode *mode = &new_crtc_state->adjusted_mode;
 	u16 vtotal = mode->crtc_vtotal;
@@ -1704,7 +2055,11 @@ static void vop2_post_config(struct drm_crtc *crtc, bool force,
 	u16 hact_end, vact_end;
 	u32 val;
 
+	splice_vp = new_vcstate->splice_mode ? vop2_get_splice_vp(vp) : NULL;
+
 	vop2->ops->setup_bg_dly(vp);
+	if (splice_vp)
+		vop2->ops->setup_bg_dly(splice_vp);
 
 	vsize = rounddown(vsize, 2);
 	hsize = rounddown(hsize, 2);
@@ -1737,7 +2092,9 @@ static void vop2_post_config(struct drm_crtc *crtc, bool force,
 		vop2_vp_write(vp, RK3568_VP_POST_DSP_VACT_INFO_F1, val);
 	}
 
-	vop2_bgcolor_setup(crtc, force, new_crtc_state, old_crtc_state);
+	vop2_bgcolor_setup(vp, force, new_crtc_state, old_crtc_state);
+	if (splice_vp)
+		vop2_bgcolor_setup(splice_vp, force, new_crtc_state, old_crtc_state);
 }
 
 static int us_to_vertical_line(struct drm_display_mode *mode, int us)
@@ -1749,6 +2106,7 @@ static void vop2_crtc_atomic_enable(struct drm_crtc *crtc,
 				    struct drm_atomic_commit *state)
 {
 	struct vop2_video_port *vp = to_vop2_video_port(crtc);
+	struct vop2_video_port *splice_vp = NULL;
 	struct vop2 *vop2 = vp->vop2;
 	const struct vop2_data *vop2_data = vop2->data;
 	const struct vop2_video_port_data *vp_data = &vop2_data->vp[vp->id];
@@ -1780,6 +2138,12 @@ static void vop2_crtc_atomic_enable(struct drm_crtc *crtc,
 
 	vop2_lock(vop2);
 
+	if (vcstate->splice_mode) {
+		splice_vp = vop2_get_splice_vp(vp);
+		splice_vp->splice_mode_right = true;
+		splice_vp->left_vp = vp;
+	}
+
 	ret = clk_prepare_enable(vp->dclk);
 	if (ret < 0) {
 		drm_err(vop2->drm, "failed to enable dclk for video port%d - %d\n",
@@ -1940,9 +2304,12 @@ static void vop2_crtc_atomic_enable(struct drm_crtc *crtc,
 
 	clk_set_rate(vp->dclk, clock);
 
+	if (splice_vp)
+		vop2->ops->setup_splice(vp, true);
+
 	vop2_post_config(crtc, true, crtc_state, old_crtc_state);
 
-	vop2_cfg_done(vp);
+	vop2_cfg_done(vp, vcstate->splice_mode);
 
 	vop2_vp_write(vp, RK3568_VP_DSP_CTRL, dsp_ctrl);
 
@@ -1984,21 +2351,100 @@ static int vop2_crtc_atomic_check(struct drm_crtc *crtc,
 				  struct drm_atomic_commit *state)
 {
 	struct vop2_video_port *vp = to_vop2_video_port(crtc);
+	struct vop2 *vop2 = vp->vop2;
+	const struct vop2_video_port_data *vp_data = &vop2->data->vp[vp->id];
+	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
+	struct rockchip_crtc_state *vcstate = to_rockchip_crtc_state(crtc_state);
+	struct vop2_video_port *splice_vp;
 	struct drm_plane *plane;
 	int nplanes = 0;
-	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
 	int ret;
 
 	ret = vop2_crtc_atomic_check_gamma(vp, crtc, state, crtc_state);
 	if (ret)
 		return ret;
 
+	/* Check if left_vp is in use */
+	if (crtc_state->enable && drm_atomic_crtc_needs_modeset(crtc_state)) {
+		struct vop2_video_port *left_vp = vop2_find_left_splice_vp(vop2, vp->id);
+
+		if (left_vp && left_vp->crtc.state) {
+			struct drm_crtc_state *lstate, *lold;
+
+			lstate = drm_atomic_get_crtc_state(state, &left_vp->crtc);
+			if (IS_ERR(lstate))
+				return PTR_ERR(lstate);
+
+			lold = drm_atomic_get_old_crtc_state(state, &left_vp->crtc);
+			if (to_rockchip_crtc_state(lold)->splice_mode) {
+				drm_dbg_kms(vop2->drm, "vp%d is in use by vp%d in splice mode\n",
+					    vp->id, left_vp->id);
+				return -EBUSY;
+			}
+		}
+	}
+
 	drm_atomic_crtc_state_for_each_plane(plane, crtc_state)
 		nplanes++;
 
 	if (nplanes > vp->nlayers)
 		return -EINVAL;
 
+	vcstate->splice_mode = false;
+	if (crtc_state->enable && vop2_vp_uses_splice(vp, crtc_state)) {
+		struct drm_crtc_state *splice_state;
+
+		if (vp_data->max_output.width <= VOP2_MAX_VP_OUTPUT_WIDTH)
+			return -EINVAL;
+
+		splice_vp = vop2_get_splice_vp(vp);
+		if (drm_atomic_crtc_needs_modeset(crtc_state) && splice_vp->crtc.state) {
+			splice_state = drm_atomic_get_crtc_state(state, &splice_vp->crtc);
+			if (IS_ERR(splice_state))
+				return PTR_ERR(splice_state);
+
+			if (splice_state->enable) {
+				drm_dbg_kms(vop2->drm, "vp%d is already in use\n", splice_vp->id);
+				return -EBUSY;
+			}
+		}
+
+		/*
+		 * The right half uses its own set of OVL layers, both video
+		 * ports need enough layers for the planes of the left CRTC.
+		 */
+		if (nplanes > min(vp->nlayers, splice_vp->nlayers))
+			return -EINVAL;
+
+		/* Check whether the right window is used by another CRTC. */
+		drm_atomic_crtc_state_for_each_plane(plane, crtc_state) {
+			struct vop2_win *win = to_vop2_win(plane);
+			struct vop2_win *rwin = win->splice_win;
+			struct drm_plane_state *rstate, *old_rstate;
+
+			/* For windows that cannot be spliced */
+			if (!rwin) {
+				drm_dbg_kms(vop2->drm, "%s cannot be used in splice mode\n",
+					    win->data->name);
+				return -EINVAL;
+			}
+
+			rstate = drm_atomic_get_plane_state(state, &rwin->base);
+			if (IS_ERR(rstate))
+				return PTR_ERR(rstate);
+
+			/* If window is already in use by another CRTC, then reject it. */
+			old_rstate = drm_atomic_get_old_plane_state(state, &rwin->base);
+			if (rstate->crtc || (old_rstate && old_rstate->crtc)) {
+				drm_dbg_kms(vop2->drm, "%s is in use on another CRTC\n",
+					    rwin->data->name);
+				return -EBUSY;
+			}
+		}
+
+		vcstate->splice_mode = true;
+	}
+
 	return 0;
 }
 
@@ -2018,6 +2464,7 @@ static void vop2_crtc_atomic_flush(struct drm_crtc *crtc,
 	struct drm_crtc_state *old_crtc_state = drm_atomic_get_old_crtc_state(state, crtc);
 	struct vop2_video_port *vp = to_vop2_video_port(crtc);
 	struct vop2 *vop2 = vp->vop2;
+	bool splice = to_rockchip_crtc_state(crtc_state)->splice_mode;
 
 	/* In case of modeset, gamma lut update already happened in atomic enable */
 	if (!drm_atomic_crtc_needs_modeset(crtc_state) && crtc_state->color_mgmt_changed)
@@ -2025,7 +2472,7 @@ static void vop2_crtc_atomic_flush(struct drm_crtc *crtc,
 
 	vop2_post_config(crtc, false, crtc_state, old_crtc_state);
 
-	vop2_cfg_done(vp);
+	vop2_cfg_done(vp, splice);
 
 	spin_lock_irq(&crtc->dev->event_lock);
 
@@ -2510,6 +2957,8 @@ static int vop2_create_crtcs(struct vop2 *vop2)
 	struct device_node *port;
 	struct vop2_video_port *vp;
 	struct vop2_win *win;
+	bool vp_used[ROCKCHIP_MAX_CRTC] = {};
+	u32 reserved_splice_wins = 0;
 	u32 possible_crtcs;
 	int i, j, nvp, nvps = 0;
 	int ret;
@@ -2543,9 +2992,23 @@ static int vop2_create_crtcs(struct vop2 *vop2)
 			return dev_err_probe(drm->dev, -ENOENT,
 					     "no port node found for video_port%d\n", i);
 		vp->crtc.port = port;
-		nvps++;
+		vp_used[i] = true;
 	}
 
+	/* reserved vp for 8K mode */
+	for (i = 0; i < vop2_data->nr_vps; i++) {
+		if (!(vop2_data->feature & VOP2_FEATURE_SPLICE) || !vp_used[i])
+			continue;
+		if (vop2->vps[i].data->max_output.width <= VOP2_MAX_VP_OUTPUT_WIDTH)
+			continue;
+
+		vp_used[vop2->vps[i].data->splice_vp_id] = true;
+	}
+
+	for (i = 0; i < vop2_data->nr_vps; i++)
+		if (vp_used[i])
+			nvps++;
+
 	nvp = 0;
 	/* Register a primary plane for every crtc */
 	for (i = 0; i < vop2_data->nr_vps; i++) {
@@ -2568,6 +3031,13 @@ static int vop2_create_crtcs(struct vop2 *vop2)
 			if (vop2_is_mirror_win(win))
 				continue;
 
+			/*
+			 * Keep a required splice window away from another
+			 * VP's primary plane.
+			 */
+			if (reserved_splice_wins & BIT(win->win_id))
+				continue;
+
 			if (win->type == DRM_PLANE_TYPE_PRIMARY) {
 				possible_crtcs = BIT(nvp);
 				vp->primary_plane = win;
@@ -2576,6 +3046,15 @@ static int vop2_create_crtcs(struct vop2 *vop2)
 					return dev_err_probe(drm->dev, ret,
 							     "failed to init primary plane %s\n",
 							     win->data->name);
+
+				/*
+				 * If the right VP has no CRTC of its own,
+				 * reserve the right window for splice mode.
+				 */
+				if ((vop2_data->feature & VOP2_FEATURE_SPLICE) &&
+				    vp->data->max_output.width > VOP2_MAX_VP_OUTPUT_WIDTH &&
+				    win->splice_win && !vop2_get_splice_vp(vp)->crtc.port)
+					reserved_splice_wins |= BIT(win->splice_win->win_id);
 				nvp++;
 				break;
 			}
@@ -2653,7 +3132,7 @@ static int vop2_create_crtcs(struct vop2 *vop2)
 	for (i = 0; i < vop2->data->nr_vps; i++) {
 		struct vop2_video_port *vp = &vop2->vps[i];
 
-		if (vp->crtc.port)
+		if (vp_used[i])
 			vp->nlayers = vop2_data->win_size / nvps;
 	}
 
@@ -2726,7 +3205,7 @@ static int vop2_win_init(struct vop2 *vop2)
 {
 	const struct vop2_data *vop2_data = vop2->data;
 	struct vop2_win *win;
-	int i, ret;
+	int i, j, ret;
 
 	for (i = 0; i < vop2_data->win_size; i++) {
 		const struct vop2_win_data *win_data = &vop2_data->win[i];
@@ -2747,6 +3226,28 @@ static int vop2_win_init(struct vop2 *vop2)
 			return ret;
 	}
 
+	/* Link the windows used for the two halves of a spliced plane */
+	for (i = 0; i < vop2_data->win_size; i++) {
+		win = &vop2->win[i];
+
+		if (!(win->data->feature & WIN_FEATURE_SPLICE_LEFT))
+			continue;
+
+		for (j = 0; j < vop2_data->win_size; j++) {
+			if (vop2->win[j].data->phys_id != win->data->splice_win_id)
+				continue;
+
+			win->splice_win = &vop2->win[j];
+			win->splice_win->left_win = win;
+			break;
+		}
+
+		if (!win->splice_win)
+			return dev_err_probe(vop2->dev, -EINVAL,
+					     "no splice window for %s\n",
+					     win->data->name);
+	}
+
 	vop2->registered_num_wins = vop2_data->win_size;
 
 	return 0;
@@ -2825,6 +3326,8 @@ static int vop2_bind(struct device *dev, struct device *master, void *data)
 	drm->mode_config.min_width = 4;
 	drm->mode_config.min_height = 4;
 	drm->mode_config.max_width = vop2_data->max_input.width;
+	if (vop2_data->feature & VOP2_FEATURE_SPLICE)
+		drm->mode_config.max_width = vop2_data->max_output.width;
 	drm->mode_config.max_height = vop2_data->max_input.height;
 
 	ret = vop2_win_init(vop2);
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h
index ffcb39c130aa..87c7fcdb26df 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h
@@ -24,14 +24,24 @@
 
 #define VOP2_VP_FEATURE_OUTPUT_10BIT        BIT(0)
 
+/*
+ * The maximum output width of a single video port. Modes wider than
+ * this are driven by splicing two video ports together.
+ */
+#define VOP2_MAX_VP_OUTPUT_WIDTH	4096
+
 #define VOP2_FEATURE_HAS_SYS_GRF	BIT(0)
 #define VOP2_FEATURE_HAS_VO0_GRF	BIT(1)
 #define VOP2_FEATURE_HAS_VO1_GRF	BIT(2)
 #define VOP2_FEATURE_HAS_VOP_GRF	BIT(3)
 #define VOP2_FEATURE_HAS_SYS_PMU	BIT(4)
+/* splice two windows and two VPs to support resolutions > 4096 */
+#define VOP2_FEATURE_SPLICE		BIT(5)
 
 #define WIN_FEATURE_AFBDC		BIT(0)
 #define WIN_FEATURE_CLUSTER		BIT(1)
+/* Left window in splice mode */
+#define WIN_FEATURE_SPLICE_LEFT		BIT(6)
 
 /*
  *  the delay number of a window in different mode.
@@ -178,6 +188,13 @@ struct vop2_win_data {
 	const char *name;
 	unsigned int phys_id;
 
+	/**
+	 * @splice_win_id: phy id of the window driving the right half of
+	 * this window in splice mode. Only valid for windows with
+	 * %WIN_FEATURE_SPLICE_LEFT.
+	 */
+	u8 splice_win_id;
+
 	u32 base;
 	u32 possible_vp_mask;
 	enum drm_plane_type type;
@@ -217,10 +234,26 @@ struct vop2_win {
 	u32 offset;
 
 	enum drm_plane_type type;
+
+	/**
+	 * @splice_win: window used for the right half of this window when
+	 * the display is driven in splice mode.
+	 */
+	struct vop2_win *splice_win;
+	/**
+	 * @left_win: window driving the left half of this window when this
+	 * window is used as the right half in splice mode.
+	 */
+	struct vop2_win *left_win;
 };
 
 struct vop2_video_port_data {
 	unsigned int id;
+	/**
+	 * @splice_vp_id: id of the video port driving the right half of the
+	 * screen when this video port works in splice mode.
+	 */
+	u8 splice_vp_id;
 	u32 feature;
 	u16 gamma_lut_len;
 	u16 cubic_lut_len;
@@ -252,6 +285,17 @@ struct vop2_video_port {
 	struct drm_pending_vblank_event *event;
 
 	unsigned int nlayers;
+
+	/**
+	 * @splice_mode_right: this video port drives the right half of the
+	 * display in splice mode.
+	 */
+	bool splice_mode_right;
+	/**
+	 * @left_vp: video port driving the left half when
+	 * @splice_mode_right is set.
+	 */
+	struct vop2_video_port *left_vp;
 };
 
 /**
@@ -264,6 +308,11 @@ struct vop2_ops {
 	unsigned long (*setup_intf_mux)(struct vop2_video_port *vp, int ep_id, u32 polflags);
 	void (*setup_bg_dly)(struct vop2_video_port *vp);
 	void (*setup_overlay)(struct vop2_video_port *vp);
+	/*
+	 * @setup_splice: join or split this video port and its partner to
+	 * drive a mode wider than a single video port can handle.
+	 */
+	void (*setup_splice)(struct vop2_video_port *vp, bool enable);
 };
 
 struct vop2_data {
@@ -712,6 +761,7 @@ enum dst_factor_mode {
 #define RK3588_DSP_IF_POL__DP0_PIN_POL			GENMASK(10, 8)
 
 #define RK3588_LUT_PORT_SEL__GAMMA_AHB_WRITE_SEL	GENMASK(13, 12)
+#define RK3568_LUT_PORT_SEL__SPLICE_EN			BIT(16)
 
 #define RK3568_VP0_MIPI_CTRL__DCLK_DIV2_PHASE_LOCK	BIT(5)
 #define RK3568_VP0_MIPI_CTRL__DCLK_DIV2			BIT(4)
@@ -848,6 +898,14 @@ static inline struct vop2_win *to_vop2_win(struct drm_plane *p)
 	return container_of(p, struct vop2_win, base);
 }
 
+static inline struct vop2_video_port *
+vop2_get_splice_vp(struct vop2_video_port *vp)
+{
+	struct vop2 *vop2 = vp->vop2;
+
+	return &vop2->vps[vop2->data->vp[vp->id].splice_vp_id];
+}
+
 /*
  * Note:
  * The write mask function is documented but missing on rk3566/8, writes
@@ -857,13 +915,19 @@ static inline struct vop2_win *to_vop2_win(struct drm_plane *p)
  * GLB_CFG_DONE_EN has no write mask bit.
  *
  */
-static inline void vop2_cfg_done(struct vop2_video_port *vp)
+static inline void vop2_cfg_done(struct vop2_video_port *vp, bool splice)
 {
 	struct vop2 *vop2 = vp->vop2;
 	u32 val = RK3568_REG_CFG_DONE__GLB_CFG_DONE_EN;
 
 	val |= BIT(vp->id) | (BIT(vp->id) << 16);
 
+	if (splice) {
+		int splice_vp_id = vop2->data->vp[vp->id].splice_vp_id;
+
+		val |= BIT(splice_vp_id) | (BIT(splice_vp_id) << 16);
+	}
+
 	regmap_set_bits(vop2->map, RK3568_REG_CFG_DONE, val);
 }
 
diff --git a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
index c44648e1bc0d..28212e1414f3 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
+++ b/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
@@ -1056,10 +1056,11 @@ static const struct vop2_regs_dump rk3576_regs_dump[] = {
 static const struct vop2_video_port_data rk3588_vop_video_ports[] = {
 	{
 		.id = 0,
+		.splice_vp_id = 1,
 		.feature = VOP2_VP_FEATURE_OUTPUT_10BIT,
 		.gamma_lut_len = 1024,
 		.cubic_lut_len = 9 * 9 * 9, /* 9x9x9 */
-		.max_output = { 4096, 2304 },
+		.max_output = { 7680, 4320 },
 		/* hdr2sdr sdr2hdr hdr2hdr sdr2sdr */
 		.pre_scan_max_dly = { 76, 65, 65, 54 },
 		.offset = 0xc00,
@@ -1121,6 +1122,7 @@ static const struct vop2_win_data rk3588_vop_win_data[] = {
 	{
 		.name = "Cluster0-win0",
 		.phys_id = ROCKCHIP_VOP2_CLUSTER0,
+		.splice_win_id = ROCKCHIP_VOP2_CLUSTER1,
 		.base = 0x1000,
 		.possible_vp_mask = BIT(0) | BIT(1) | BIT(2) | BIT(3),
 		.formats = formats_cluster,
@@ -1136,7 +1138,7 @@ static const struct vop2_win_data rk3588_vop_win_data[] = {
 		.max_downscale_factor = 4,
 		.dly = { 4, 26, 29 },
 		.type = DRM_PLANE_TYPE_PRIMARY,
-		.feature = WIN_FEATURE_AFBDC | WIN_FEATURE_CLUSTER,
+		.feature = WIN_FEATURE_AFBDC | WIN_FEATURE_CLUSTER | WIN_FEATURE_SPLICE_LEFT,
 	}, {
 		.name = "Cluster1-win0",
 		.phys_id = ROCKCHIP_VOP2_CLUSTER1,
@@ -1159,6 +1161,7 @@ static const struct vop2_win_data rk3588_vop_win_data[] = {
 	}, {
 		.name = "Cluster2-win0",
 		.phys_id = ROCKCHIP_VOP2_CLUSTER2,
+		.splice_win_id = ROCKCHIP_VOP2_CLUSTER3,
 		.base = 0x1400,
 		.possible_vp_mask = BIT(0) | BIT(1) | BIT(2) | BIT(3),
 		.formats = formats_cluster,
@@ -1174,7 +1177,7 @@ static const struct vop2_win_data rk3588_vop_win_data[] = {
 		.max_upscale_factor = 4,
 		.max_downscale_factor = 4,
 		.dly = { 4, 26, 29 },
-		.feature = WIN_FEATURE_AFBDC | WIN_FEATURE_CLUSTER,
+		.feature = WIN_FEATURE_AFBDC | WIN_FEATURE_CLUSTER | WIN_FEATURE_SPLICE_LEFT,
 	}, {
 		.name = "Cluster3-win0",
 		.phys_id = ROCKCHIP_VOP2_CLUSTER3,
@@ -1197,6 +1200,7 @@ static const struct vop2_win_data rk3588_vop_win_data[] = {
 	}, {
 		.name = "Esmart0-win0",
 		.phys_id = ROCKCHIP_VOP2_ESMART0,
+		.splice_win_id = ROCKCHIP_VOP2_ESMART1,
 		.possible_vp_mask = BIT(0) | BIT(1) | BIT(2) | BIT(3),
 		.formats = formats_esmart,
 		.nformats = ARRAY_SIZE(formats_esmart),
@@ -1211,6 +1215,7 @@ static const struct vop2_win_data rk3588_vop_win_data[] = {
 		.max_upscale_factor = 8,
 		.max_downscale_factor = 8,
 		.dly = { 23, 45, 48 },
+		.feature = WIN_FEATURE_SPLICE_LEFT,
 	}, {
 		.name = "Esmart1-win0",
 		.phys_id = ROCKCHIP_VOP2_ESMART1,
@@ -1231,6 +1236,7 @@ static const struct vop2_win_data rk3588_vop_win_data[] = {
 	}, {
 		.name = "Esmart2-win0",
 		.phys_id = ROCKCHIP_VOP2_ESMART2,
+		.splice_win_id = ROCKCHIP_VOP2_ESMART3,
 		.base = 0x1c00,
 		.possible_vp_mask = BIT(0) | BIT(1) | BIT(2) | BIT(3),
 		.formats = formats_esmart,
@@ -1245,6 +1251,7 @@ static const struct vop2_win_data rk3588_vop_win_data[] = {
 		.max_upscale_factor = 8,
 		.max_downscale_factor = 8,
 		.dly = { 23, 45, 48 },
+		.feature = WIN_FEATURE_SPLICE_LEFT,
 	}, {
 		.name = "Esmart3-win0",
 		.phys_id = ROCKCHIP_VOP2_ESMART3,
@@ -1387,6 +1394,19 @@ static struct vop2_win *vop2_find_win_by_phys_id(struct vop2 *vop2, uint8_t phys
 	return NULL;
 }
 
+/*
+ * The right window in splice mode shares the plane state of the left one,
+ * only its registers and position on the screen are different.
+ */
+static struct drm_plane_state *
+vop2_win_get_pstate(struct vop2_video_port *vp, struct vop2_win *win)
+{
+	if (win->left_win && vp->splice_mode_right)
+		return win->left_win->base.state;
+
+	return win->base.state;
+}
+
 static unsigned long rk3568_set_intf_mux(struct vop2_video_port *vp, int id, u32 polflags)
 {
 	struct vop2 *vop2 = vp->vop2;
@@ -1873,7 +1893,7 @@ static int vop2_find_start_mixer_id_for_vp(struct vop2_video_port *vp)
 
 	for (i = 0; i < 31; i += 4) {
 		match = false;
-		for_each_set_bit(phys_id, &win_mask, ROCKCHIP_VOP2_ESMART3) {
+		for_each_set_bit(phys_id, &win_mask, BITS_PER_TYPE(u32)) {
 			win = vop2_find_win_by_phys_id(vop2, phys_id);
 			if (win->data->layer_sel_id[vp->id] == ((layer_sel >> i) & 0xf)) {
 				match = true;
@@ -1890,11 +1910,11 @@ static int vop2_find_start_mixer_id_for_vp(struct vop2_video_port *vp)
 	return used_layer;
 }
 
-static void vop2_setup_cluster_alpha(struct vop2 *vop2, struct vop2_win *main_win)
+static void vop2_setup_cluster_alpha(struct vop2 *vop2, struct vop2_win *main_win,
+				     struct drm_plane_state *pstate)
 {
 	struct vop2_alpha_config alpha_config;
 	struct vop2_alpha alpha;
-	struct drm_plane_state *bottom_win_pstate;
 	bool src_pixel_alpha_en = false;
 	u16 src_glb_alpha_val, dst_glb_alpha_val;
 	u32 src_color_ctrl_reg, dst_color_ctrl_reg, src_alpha_ctrl_reg, dst_alpha_ctrl_reg;
@@ -1903,11 +1923,10 @@ static void vop2_setup_cluster_alpha(struct vop2 *vop2, struct vop2_win *main_wi
 	bool swap = false;
 
 	/* At one win mode, win0 is dst/bottom win, and win1 is a all zero src/top win */
-	bottom_win_pstate = main_win->base.state;
 	src_glb_alpha_val = 0;
-	dst_glb_alpha_val = main_win->base.state->alpha;
+	dst_glb_alpha_val = pstate->alpha;
 
-	if (!bottom_win_pstate->fb)
+	if (!pstate->fb)
 		return;
 
 	alpha_config.src_premulti_en = premulti_en;
@@ -1959,7 +1978,10 @@ static void vop2_setup_alpha(struct vop2_video_port *vp)
 	struct drm_framebuffer *fb;
 	struct vop2_alpha_config alpha_config;
 	struct vop2_alpha alpha;
-	struct drm_plane *plane;
+	struct drm_plane_state *pstate;
+	struct vop2_win *win;
+	unsigned long win_mask = vp->win_mask;
+	int phys_id;
 	int pixel_alpha_en;
 	int premulti_en, gpremulti_en = 0;
 	int mixer_id;
@@ -1975,11 +1997,12 @@ static void vop2_setup_alpha(struct vop2_video_port *vp)
 
 	alpha_config.dst_pixel_alpha_en = true; /* alpha value need transfer to next mix */
 
-	drm_atomic_crtc_for_each_plane(plane, &vp->crtc) {
-		struct vop2_win *win = to_vop2_win(plane);
+	for_each_set_bit(phys_id, &win_mask, BITS_PER_TYPE(u32)) {
+		win = vop2_find_win_by_phys_id(vop2, phys_id);
+		pstate = vop2_win_get_pstate(vp, win);
 
-		if (plane->state->normalized_zpos == 0 &&
-		    !is_opaque(plane->state->alpha) &&
+		if (pstate->normalized_zpos == 0 &&
+		    !is_opaque(pstate->alpha) &&
 		    !vop2_cluster_window(win)) {
 			/*
 			 * If bottom layer have global alpha effect [except cluster layer,
@@ -1987,7 +2010,7 @@ static void vop2_setup_alpha(struct vop2_video_port *vp)
 			 * at cluster mix], bottom layer mix need deal with global alpha.
 			 */
 			bottom_layer_alpha_en = true;
-			dst_global_alpha = plane->state->alpha;
+			dst_global_alpha = pstate->alpha;
 		}
 	}
 
@@ -2003,9 +2026,12 @@ static void vop2_setup_alpha(struct vop2_video_port *vp)
 		dst_alpha_ctrl_reg = RK3576_OVL_MIX0_DST_ALPHA_CTRL(vp->id);
 	}
 
-	drm_atomic_crtc_for_each_plane(plane, &vp->crtc) {
-		struct vop2_win *win = to_vop2_win(plane);
-		int zpos = plane->state->normalized_zpos;
+	for_each_set_bit(phys_id, &win_mask, BITS_PER_TYPE(u32)) {
+		int zpos;
+
+		win = vop2_find_win_by_phys_id(vop2, phys_id);
+		pstate = vop2_win_get_pstate(vp, win);
+		zpos = pstate->normalized_zpos;
 
 		/*
 		 * Need to configure alpha from second layer.
@@ -2013,13 +2039,12 @@ static void vop2_setup_alpha(struct vop2_video_port *vp)
 		if (zpos == 0)
 			continue;
 
-		if (plane->state->pixel_blend_mode == DRM_MODE_BLEND_PREMULTI)
+		if (pstate->pixel_blend_mode == DRM_MODE_BLEND_PREMULTI)
 			premulti_en = 1;
 		else
 			premulti_en = 0;
 
-		plane = &win->base;
-		fb = plane->state->fb;
+		fb = pstate->fb;
 
 		pixel_alpha_en = fb->format->has_alpha;
 
@@ -2030,7 +2055,7 @@ static void vop2_setup_alpha(struct vop2_video_port *vp)
 			/* Cd = Cs + (1 - As) * Cd * Agd */
 			alpha_config.dst_premulti_en = false;
 			alpha_config.src_pixel_alpha_en = pixel_alpha_en;
-			alpha_config.src_glb_alpha_value = plane->state->alpha;
+			alpha_config.src_glb_alpha_value = pstate->alpha;
 			alpha_config.dst_glb_alpha_value = dst_global_alpha;
 		} else if (vop2_cluster_window(win)) {
 			/* Mix output data only have pixel alpha */
@@ -2042,7 +2067,7 @@ static void vop2_setup_alpha(struct vop2_video_port *vp)
 			/* Cd = Cs + (1 - As) * Cd */
 			alpha_config.dst_premulti_en = true;
 			alpha_config.src_pixel_alpha_en = pixel_alpha_en;
-			alpha_config.src_glb_alpha_value = plane->state->alpha;
+			alpha_config.src_glb_alpha_value = pstate->alpha;
 			alpha_config.dst_glb_alpha_value = DRM_BLEND_ALPHA_OPAQUE;
 		}
 
@@ -2132,7 +2157,10 @@ static void rk3568_vop2_wait_for_layer_cfg_done(struct vop2 *vop2)
 static void rk3568_vop2_setup_layer_mixer(struct vop2_video_port *vp)
 {
 	struct vop2 *vop2 = vp->vop2;
-	struct drm_plane *plane;
+	struct drm_crtc *crtc = &vp->crtc;
+	struct drm_plane_state *pstate;
+	struct vop2_win *win;
+	unsigned long win_mask;
 	u32 layer_sel;
 	u32 port_sel;
 	u32 atv_layer_sel;
@@ -2142,11 +2170,33 @@ static void rk3568_vop2_setup_layer_mixer(struct vop2_video_port *vp)
 	unsigned int ofs;
 	u32 ovl_ctrl;
 	u32 cfg_done;
+	int phys_id;
 	int i;
 	struct vop2_video_port *vp0 = &vop2->vps[0];
 	struct vop2_video_port *vp1 = &vop2->vps[1];
 	struct vop2_video_port *vp2 = &vop2->vps[2];
-	struct rockchip_crtc_state *vcstate = to_rockchip_crtc_state(vp->crtc.state);
+	struct rockchip_crtc_state *vcstate;
+	struct vop2_video_port *main_vp = vp;
+	struct vop2_video_port *splice_vp = NULL;
+	u32 own_cfg_done_mask;
+	u32 yuv_mask;
+	int vp_idx;
+
+	/* right vp share the same crtc state in splice mode */
+	if (vp->splice_mode_right)
+		main_vp = vp->left_vp;
+	crtc = &main_vp->crtc;
+	vcstate = to_rockchip_crtc_state(crtc->state);
+	if (vcstate->splice_mode)
+		splice_vp = vop2_get_splice_vp(main_vp);
+
+	/* In splice mode, update main_vp and splice vp */
+	own_cfg_done_mask = BIT(main_vp->id);
+	yuv_mask = RK3568_OVL_CTRL__YUV_MODE(main_vp->id);
+	if (splice_vp) {
+		own_cfg_done_mask |= BIT(splice_vp->id);
+		yuv_mask |= RK3568_OVL_CTRL__YUV_MODE(splice_vp->id);
+	}
 
 	mutex_lock(&vop2->ovl_lock);
 	ovl_ctrl = vop2_readl(vop2, RK3568_OVL_CTRL);
@@ -2154,9 +2204,9 @@ static void rk3568_vop2_setup_layer_mixer(struct vop2_video_port *vp)
 	ovl_ctrl &= ~RK3568_OVL_CTRL__LAYERSEL_REGDONE_SEL;
 
 	if (vcstate->yuv_overlay)
-		ovl_ctrl |= RK3568_OVL_CTRL__YUV_MODE(vp->id);
+		ovl_ctrl |= yuv_mask;
 	else
-		ovl_ctrl &= ~RK3568_OVL_CTRL__YUV_MODE(vp->id);
+		ovl_ctrl &= ~yuv_mask;
 
 	port_sel = vop2->old_port_sel;
 	port_sel &= RK3568_OVL_PORT_SEL__SEL_PORT;
@@ -2186,86 +2236,97 @@ static void rk3568_vop2_setup_layer_mixer(struct vop2_video_port *vp)
 	atv_layer_sel = vop2_readl(vop2, RK3568_OVL_LAYER_SEL);
 	layer_sel = vop2->old_layer_sel;
 
-	ofs = 0;
-	for (i = 0; i < vp->id; i++)
-		ofs += vop2->vps[i].nlayers;
+	/* Calculate main_vp and splice_vp */
+	for (vp_idx = 0; vp_idx < (splice_vp ? 2 : 1); vp_idx++) {
+		vp = vp_idx ? splice_vp : main_vp;
+		ofs = 0;
+		for (i = 0; i < vp->id; i++)
+			ofs += vop2->vps[i].nlayers;
 
-	drm_atomic_crtc_for_each_plane(plane, &vp->crtc) {
-		struct vop2_win *win = to_vop2_win(plane);
-		struct vop2_win *old_win;
+		win_mask = vp->win_mask;
+		for_each_set_bit(phys_id, &win_mask, BITS_PER_TYPE(u32)) {
+			struct vop2_win *old_win;
 
-		layer_id = (u8)(plane->state->normalized_zpos + ofs);
-		/*
-		 * Find the layer this win bind in old state.
-		 */
-		for (old_layer_id = 0; old_layer_id < vop2->data->win_size; old_layer_id++) {
-			layer_sel_id = (layer_sel >> (4 * old_layer_id)) & 0xf;
-			if (layer_sel_id == win->data->layer_sel_id[vp->id])
-				break;
-		}
+			win = vop2_find_win_by_phys_id(vop2, phys_id);
+			pstate = vop2_win_get_pstate(vp, win);
 
-		/*
-		 * Find the win bind to this layer in old state
-		 */
-		for (i = 0; i < vop2->data->win_size; i++) {
-			old_win = &vop2->win[i];
-			layer_sel_id = (layer_sel >> (4 * layer_id)) & 0xf;
-			if (layer_sel_id == old_win->data->layer_sel_id[vp->id])
+			layer_id = (u8)(pstate->normalized_zpos + ofs);
+			/*
+			 * Find the layer this win bind in old state.
+			 */
+			for (old_layer_id = 0;
+			     old_layer_id < vop2->data->win_size; old_layer_id++) {
+				layer_sel_id = (layer_sel >> (4 * old_layer_id)) & 0xf;
+				if (layer_sel_id == win->data->layer_sel_id[vp->id])
+					break;
+			}
+
+			/*
+			 * Find the win bind to this layer in old state
+			 */
+			for (i = 0; i < vop2->data->win_size; i++) {
+				old_win = &vop2->win[i];
+				layer_sel_id = (layer_sel >> (4 * layer_id)) & 0xf;
+				if (layer_sel_id == old_win->data->layer_sel_id[vp->id])
+					break;
+			}
+
+			switch (win->data->phys_id) {
+			case ROCKCHIP_VOP2_CLUSTER0:
+				port_sel &= ~RK3568_OVL_PORT_SEL__CLUSTER0;
+				port_sel |= FIELD_PREP(RK3568_OVL_PORT_SEL__CLUSTER0, vp->id);
 				break;
-		}
+			case ROCKCHIP_VOP2_CLUSTER1:
+				port_sel &= ~RK3568_OVL_PORT_SEL__CLUSTER1;
+				port_sel |= FIELD_PREP(RK3568_OVL_PORT_SEL__CLUSTER1, vp->id);
+				break;
+			case ROCKCHIP_VOP2_CLUSTER2:
+				port_sel &= ~RK3588_OVL_PORT_SEL__CLUSTER2;
+				port_sel |= FIELD_PREP(RK3588_OVL_PORT_SEL__CLUSTER2, vp->id);
+				break;
+			case ROCKCHIP_VOP2_CLUSTER3:
+				port_sel &= ~RK3588_OVL_PORT_SEL__CLUSTER3;
+				port_sel |= FIELD_PREP(RK3588_OVL_PORT_SEL__CLUSTER3, vp->id);
+				break;
+			case ROCKCHIP_VOP2_ESMART0:
+				port_sel &= ~RK3568_OVL_PORT_SEL__ESMART0;
+				port_sel |= FIELD_PREP(RK3568_OVL_PORT_SEL__ESMART0, vp->id);
+				break;
+			case ROCKCHIP_VOP2_ESMART1:
+				port_sel &= ~RK3568_OVL_PORT_SEL__ESMART1;
+				port_sel |= FIELD_PREP(RK3568_OVL_PORT_SEL__ESMART1, vp->id);
+				break;
+			case ROCKCHIP_VOP2_ESMART2:
+				port_sel &= ~RK3588_OVL_PORT_SEL__ESMART2;
+				port_sel |= FIELD_PREP(RK3588_OVL_PORT_SEL__ESMART2, vp->id);
+				break;
+			case ROCKCHIP_VOP2_ESMART3:
+				port_sel &= ~RK3588_OVL_PORT_SEL__ESMART3;
+				port_sel |= FIELD_PREP(RK3588_OVL_PORT_SEL__ESMART3, vp->id);
+				break;
+			case ROCKCHIP_VOP2_SMART0:
+				port_sel &= ~RK3568_OVL_PORT_SEL__SMART0;
+				port_sel |= FIELD_PREP(RK3568_OVL_PORT_SEL__SMART0, vp->id);
+				break;
+			case ROCKCHIP_VOP2_SMART1:
+				port_sel &= ~RK3568_OVL_PORT_SEL__SMART1;
+				port_sel |= FIELD_PREP(RK3568_OVL_PORT_SEL__SMART1, vp->id);
+				break;
+			}
 
-		switch (win->data->phys_id) {
-		case ROCKCHIP_VOP2_CLUSTER0:
-			port_sel &= ~RK3568_OVL_PORT_SEL__CLUSTER0;
-			port_sel |= FIELD_PREP(RK3568_OVL_PORT_SEL__CLUSTER0, vp->id);
-			break;
-		case ROCKCHIP_VOP2_CLUSTER1:
-			port_sel &= ~RK3568_OVL_PORT_SEL__CLUSTER1;
-			port_sel |= FIELD_PREP(RK3568_OVL_PORT_SEL__CLUSTER1, vp->id);
-			break;
-		case ROCKCHIP_VOP2_CLUSTER2:
-			port_sel &= ~RK3588_OVL_PORT_SEL__CLUSTER2;
-			port_sel |= FIELD_PREP(RK3588_OVL_PORT_SEL__CLUSTER2, vp->id);
-			break;
-		case ROCKCHIP_VOP2_CLUSTER3:
-			port_sel &= ~RK3588_OVL_PORT_SEL__CLUSTER3;
-			port_sel |= FIELD_PREP(RK3588_OVL_PORT_SEL__CLUSTER3, vp->id);
-			break;
-		case ROCKCHIP_VOP2_ESMART0:
-			port_sel &= ~RK3568_OVL_PORT_SEL__ESMART0;
-			port_sel |= FIELD_PREP(RK3568_OVL_PORT_SEL__ESMART0, vp->id);
-			break;
-		case ROCKCHIP_VOP2_ESMART1:
-			port_sel &= ~RK3568_OVL_PORT_SEL__ESMART1;
-			port_sel |= FIELD_PREP(RK3568_OVL_PORT_SEL__ESMART1, vp->id);
-			break;
-		case ROCKCHIP_VOP2_ESMART2:
-			port_sel &= ~RK3588_OVL_PORT_SEL__ESMART2;
-			port_sel |= FIELD_PREP(RK3588_OVL_PORT_SEL__ESMART2, vp->id);
-			break;
-		case ROCKCHIP_VOP2_ESMART3:
-			port_sel &= ~RK3588_OVL_PORT_SEL__ESMART3;
-			port_sel |= FIELD_PREP(RK3588_OVL_PORT_SEL__ESMART3, vp->id);
-			break;
-		case ROCKCHIP_VOP2_SMART0:
-			port_sel &= ~RK3568_OVL_PORT_SEL__SMART0;
-			port_sel |= FIELD_PREP(RK3568_OVL_PORT_SEL__SMART0, vp->id);
-			break;
-		case ROCKCHIP_VOP2_SMART1:
-			port_sel &= ~RK3568_OVL_PORT_SEL__SMART1;
-			port_sel |= FIELD_PREP(RK3568_OVL_PORT_SEL__SMART1, vp->id);
-			break;
+			layer_sel &= ~RK3568_OVL_LAYER_SEL__LAYER(layer_id, 0x7);
+			layer_sel |= RK3568_OVL_LAYER_SEL__LAYER(layer_id,
+								 win->data->layer_sel_id[vp->id]);
+			/*
+			 * When we bind a window from layerM to layerN, we also need to move the
+			 * old window on layerN to layerM to avoid one window selected by two or
+			 * more layers.
+			 */
+			layer_sel &= ~RK3568_OVL_LAYER_SEL__LAYER(old_layer_id, 0x7);
+			layer_sel |=
+				RK3568_OVL_LAYER_SEL__LAYER(old_layer_id,
+							    old_win->data->layer_sel_id[vp->id]);
 		}
-
-		layer_sel &= ~RK3568_OVL_LAYER_SEL__LAYER(layer_id, 0x7);
-		layer_sel |= RK3568_OVL_LAYER_SEL__LAYER(layer_id, win->data->layer_sel_id[vp->id]);
-		/*
-		 * When we bind a window from layerM to layerN, we also need to move the old
-		 * window on layerN to layerM to avoid one window selected by two or more layers.
-		 */
-		layer_sel &= ~RK3568_OVL_LAYER_SEL__LAYER(old_layer_id, 0x7);
-		layer_sel |= RK3568_OVL_LAYER_SEL__LAYER(old_layer_id,
-			     old_win->data->layer_sel_id[vp->id]);
 	}
 
 	/*
@@ -2286,7 +2347,7 @@ static void rk3568_vop2_setup_layer_mixer(struct vop2_video_port *vp)
 	if (layer_sel != vop2->old_layer_sel && atv_layer_sel != vop2->old_layer_sel) {
 		cfg_done = vop2_readl(vop2, RK3568_REG_CFG_DONE);
 		cfg_done &= (BIT(vop2->data->nr_vps) - 1);
-		cfg_done &= ~BIT(vp->id);
+		cfg_done &= ~own_cfg_done_mask;
 		/*
 		 * Changes of other VPs' overlays have not taken effect
 		 */
@@ -2295,13 +2356,13 @@ static void rk3568_vop2_setup_layer_mixer(struct vop2_video_port *vp)
 	}
 
 	if (layer_sel != vop2->old_layer_sel || port_sel != vop2->old_port_sel)
-		ovl_ctrl |= FIELD_PREP(RK3568_OVL_CTRL__LAYERSEL_REGDONE_SEL, vp->id);
+		ovl_ctrl |= FIELD_PREP(RK3568_OVL_CTRL__LAYERSEL_REGDONE_SEL, main_vp->id);
 	vop2_writel(vop2, RK3568_OVL_CTRL, ovl_ctrl);
 
 	if (port_sel != vop2->old_port_sel) {
 		vop2->old_port_sel = port_sel;
 		vop2_writel(vop2, RK3568_OVL_PORT_SEL, port_sel);
-		vop2_cfg_done(vp);
+		vop2_cfg_done(main_vp, vcstate->splice_mode);
 		rk3568_vop2_wait_for_port_mux_done(vop2);
 	}
 
@@ -2354,33 +2415,61 @@ static void rk3568_vop2_setup_dly_for_windows(struct vop2_video_port *vp)
 	vop2_writel(vop2, RK3568_SMART_DLY_NUM, sdly);
 }
 
-static void rk3568_vop2_setup_overlay(struct vop2_video_port *vp)
+static void rk3568_vop2_setup_overlay_for_vp(struct vop2_video_port *vp)
 {
 	struct vop2 *vop2 = vp->vop2;
-	struct drm_crtc *crtc = &vp->crtc;
-	struct drm_plane *plane;
+	unsigned long win_mask = vp->win_mask;
+	struct vop2_win *win;
+	int phys_id;
 
-	vp->win_mask = 0;
+	if (!win_mask)
+		return;
 
-	drm_atomic_crtc_for_each_plane(plane, crtc) {
-		struct vop2_win *win = to_vop2_win(plane);
+	for_each_set_bit(phys_id, &win_mask, BITS_PER_TYPE(u32)) {
+		win = vop2_find_win_by_phys_id(vop2, phys_id);
+		if (WARN_ON(!win))
+			continue;
 
 		win->delay = win->data->dly[VOP2_DLY_MODE_DEFAULT];
 
-		vp->win_mask |= BIT(win->data->phys_id);
-
 		if (vop2_cluster_window(win))
-			vop2_setup_cluster_alpha(vop2, win);
+			vop2_setup_cluster_alpha(vop2, win,
+						 vop2_win_get_pstate(vp, win));
 	}
 
-	if (!vp->win_mask)
-		return;
-
-	rk3568_vop2_setup_layer_mixer(vp);
 	vop2_setup_alpha(vp);
 	rk3568_vop2_setup_dly_for_windows(vp);
 }
 
+static void rk3568_vop2_setup_overlay(struct vop2_video_port *vp)
+{
+	struct rockchip_crtc_state *vcstate = to_rockchip_crtc_state(vp->crtc.state);
+	struct vop2_video_port *splice_vp = NULL;
+	struct drm_plane *plane;
+
+	vp->win_mask = 0;
+	if (vcstate->splice_mode) {
+		splice_vp = vop2_get_splice_vp(vp);
+		splice_vp->win_mask = 0;
+	}
+
+	/* The right video port shares the plane state of the left one */
+	drm_atomic_crtc_for_each_plane(plane, &vp->crtc) {
+		struct vop2_win *win = to_vop2_win(plane);
+
+		vp->win_mask |= BIT(win->data->phys_id);
+		if (splice_vp && win->splice_win)
+			splice_vp->win_mask |= BIT(win->splice_win->data->phys_id);
+	}
+
+	if (vp->win_mask || (splice_vp && splice_vp->win_mask))
+		rk3568_vop2_setup_layer_mixer(vp);
+
+	rk3568_vop2_setup_overlay_for_vp(vp);
+	if (splice_vp)
+		rk3568_vop2_setup_overlay_for_vp(splice_vp);
+}
+
 static void rk3576_vop2_setup_layer_mixer(struct vop2_video_port *vp)
 {
 	struct rockchip_crtc_state *vcstate = to_rockchip_crtc_state(vp->crtc.state);
@@ -2435,7 +2524,8 @@ static void rk3576_vop2_setup_overlay(struct vop2_video_port *vp)
 		vp->win_mask |= BIT(win->data->phys_id);
 
 		if (vop2_cluster_window(win))
-			vop2_setup_cluster_alpha(vop2, win);
+			vop2_setup_cluster_alpha(vop2, win,
+						 vop2_win_get_pstate(vp, win));
 	}
 
 	if (!vp->win_mask)
@@ -2449,17 +2539,38 @@ static void rk3576_vop2_setup_overlay(struct vop2_video_port *vp)
 static void rk3568_vop2_setup_bg_dly(struct vop2_video_port *vp)
 {
 	struct drm_crtc *crtc = &vp->crtc;
-	struct drm_display_mode *mode = &crtc->state->adjusted_mode;
-	u16 hdisplay = mode->crtc_hdisplay;
-	u16 hsync_len = mode->crtc_hsync_end - mode->crtc_hsync_start;
+	struct rockchip_crtc_state *vcstate;
+	struct drm_display_mode *mode;
+	u16 hdisplay, hsync_len;
 	u32 bg_dly;
 	u32 pre_scan_dly;
 
+	/* right vp share the same crtc state in splice mode */
+	if (vp->splice_mode_right)
+		crtc = &vp->left_vp->crtc;
+
+	vcstate = to_rockchip_crtc_state(crtc->state);
+	mode = &crtc->state->adjusted_mode;
+	hdisplay = mode->crtc_hdisplay;
+	hsync_len = mode->crtc_hsync_end - mode->crtc_hsync_start;
+
 	bg_dly = vp->data->pre_scan_max_dly[3];
 	vop2_writel(vp->vop2, RK3568_VP_BG_MIX_CTRL(vp->id),
 		    FIELD_PREP(RK3568_VP_BG_MIX_CTRL__BG_DLY, bg_dly));
 
-	pre_scan_dly = ((bg_dly + (hdisplay >> 1) - 1) << 16) | hsync_len;
+	/*
+	 * splice mode: hdisplay must roundup as 4 pixel,
+	 * no splice mode: hdisplay must roundup as 2 pixel.
+	 */
+	if (vcstate->splice_mode)
+		pre_scan_dly = bg_dly + (roundup(hdisplay, 4) >> 2) - 1;
+	else
+		pre_scan_dly = bg_dly + (roundup(hdisplay, 2) >> 1) - 1;
+
+	if (vp->vop2->version == VOP_VERSION_RK3588 && hsync_len < 8)
+		hsync_len = 8;
+
+	pre_scan_dly = (pre_scan_dly << 16) | hsync_len;
 	vop2_vp_write(vp, RK3568_VP_PRE_SCAN_HTIMING, pre_scan_dly);
 }
 
@@ -2483,6 +2594,15 @@ static void rk3576_vop2_setup_bg_dly(struct vop2_video_port *vp)
 	vop2_vp_write(vp, RK3568_VP_PRE_SCAN_HTIMING, pre_scan_dly);
 }
 
+static void rk3588_vop2_setup_splice(struct vop2_video_port *vp, bool enable)
+{
+	struct vop2 *vop2 = vp->vop2;
+
+	regmap_update_bits(vop2->map, RK3568_LUT_PORT_SEL,
+			   RK3568_LUT_PORT_SEL__SPLICE_EN,
+			   enable ? RK3568_LUT_PORT_SEL__SPLICE_EN : 0);
+}
+
 static const struct vop2_ops rk3568_vop_ops = {
 	.setup_intf_mux = rk3568_set_intf_mux,
 	.setup_bg_dly = rk3568_vop2_setup_bg_dly,
@@ -2499,6 +2619,7 @@ static const struct vop2_ops rk3588_vop_ops = {
 	.setup_intf_mux = rk3588_set_intf_mux,
 	.setup_bg_dly = rk3568_vop2_setup_bg_dly,
 	.setup_overlay = rk3568_vop2_setup_overlay,
+	.setup_splice = rk3588_vop2_setup_splice,
 };
 
 static const struct vop2_data rk3566_vop = {
@@ -2561,10 +2682,11 @@ static const struct vop2_data rk3576_vop = {
 static const struct vop2_data rk3588_vop = {
 	.version = VOP_VERSION_RK3588,
 	.feature = VOP2_FEATURE_HAS_SYS_GRF | VOP2_FEATURE_HAS_VO1_GRF |
-		   VOP2_FEATURE_HAS_VOP_GRF | VOP2_FEATURE_HAS_SYS_PMU,
+		   VOP2_FEATURE_HAS_VOP_GRF | VOP2_FEATURE_HAS_SYS_PMU |
+		   VOP2_FEATURE_SPLICE,
 	.nr_vps = 4,
 	.max_input = { 4096, 4320 },
-	.max_output = { 4096, 4320 },
+	.max_output = { 7680, 4320 },
 	.vp = rk3588_vop_video_ports,
 	.win = rk3588_vop_win_data,
 	.win_size = ARRAY_SIZE(rk3588_vop_win_data),
-- 
2.53.0

