Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808CF606A31C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 09:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lNRdXAHK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA81010EE4F;
	Mon, 16 Nov 2026 09:24:58 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B228110EE14
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 09:24:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 67CFD40B32;
 Mon, 16 Nov 2026 09:24:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AD881F000C4;
 Mon, 16 Nov 2026 09:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794821092;
 bh=wSf/dN28TZtHJId2Jg8//D4slicuQQ5vVTln9Xeho2Y=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=lNRdXAHKqHeBSsVM7i93fLTS2pueArrryY7C8YQLMHI/wq+SSFhbAtNAe10pOUEWB
 QPi0qxxCr5jUZ24HuvQSvV269Aq1s+QNm3revEVRFA4GSgKa+iTzf8n4rr0rWkl26R
 bjg5OMKNrWcffQuXZ7X0y2Cg3E9JCcA5xz2zzKCybdPzidKNT2XMgfoboPalKqOSsW
 ukb91mabtkeXeUdW1jen5kX7AQa4z/RV7JK4sU24+rsTouMWR/yt0S+DA2ZqBFkVgU
 6+a1GVAAeeN4kHwpZXw9aN5FUv9g74NdLLgPrrk5nkzPcJ6eXRq6+ucofUknzZeIhn
 e+HwSjPGjZTjw==
Message-ID: <sashiko-outbox-216609@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/3] drm/rockchip: vop2: Support 8K output by
 splicing two video ports
To: "Chaoyi Chen" <kernel@airkyi.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261116084555.1061-4-kernel@airkyi.com>
References: <20261116084555.1061-1-kernel@airkyi.com>
 <20261116084555.1061-4-kernel@airkyi.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 09:24:51 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [High] drm/rockchip: vop2: vop2_plane_atomic_check() skips splice
  check if invisible
- [High] drm/rockchip: vop2: vop2_plane_atomic_update() leaks enabled
  splice_win
- [Medium] drm/rockchip: vop2: vop2_plane_left_in_splice() ignores old
  plane/CRTC state
- [Medium] drm/rockchip: vop2: unaligned Esmart downscale and NV15/20/30
  split rects
--

commit d894ca3d47163eb563dfd331fbbaf4120ecda639
Author: Chaoyi Chen <chaoyi.chen@rock-chips.com>

drm/rockchip: vop2: Support 8K output by splicing two video ports

This commit adds splice mode support to the VOP2 driver so that modes wider
than 4096 pixels on RK3588 are split horizontally across two video ports and
paired hardware windows.

> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/d=
rm/rockchip/rockchip_drm_vop2.c
> index e811709bdc725..c8bf397da7059 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c

[ ... ]

> @@ -1064,6 +1092,244 @@ static void vop2_crtc_atomic_disable(struct drm_c=
rtc *crtc,
>  	}
>  }
> =20
> +static bool vop2_vp_uses_splice(struct vop2_video_port *vp,
> +				struct drm_crtc_state *cstate)
> +{
> +	if (!(vp->vop2->data->feature & VOP2_FEATURE_SPLICE))
> +		return false;
> +
> +	return cstate->adjusted_mode.hdisplay > VOP2_MAX_VP_OUTPUT_WIDTH;
> +}
> +
> +static struct vop2_video_port *
> +vop2_find_left_splice_vp(struct vop2 *vop2, int right_vp_id)
> +{
> +	const struct vop2_data *vop2_data =3D vop2->data;
> +	int i;
> +
> +	if (!(vop2_data->feature & VOP2_FEATURE_SPLICE))
> +		return NULL;
> +
> +	for (i =3D 0; i < vop2_data->nr_vps; i++) {
> +		const struct vop2_video_port_data *vp_data =3D &vop2_data->vp[i];
> +
> +		if (vp_data->max_output.width <=3D VOP2_MAX_VP_OUTPUT_WIDTH)
> +			continue;
> +
> +		if (vp_data->splice_vp_id =3D=3D right_vp_id)
> +			return &vop2->vps[i];
> +	}
> +
> +	return NULL;
> +}
> +
> +static int vop2_calc_splice_rects(struct drm_plane_state *pstate,
> +				  struct drm_crtc_state *cstate,
> +				  struct drm_rect *left_src,
> +				  struct drm_rect *left_dst,
> +				  struct drm_rect *right_src,
> +				  struct drm_rect *right_dst)
> +{
> +	struct drm_rect *src =3D &pstate->src;
> +	struct drm_rect *dst =3D &pstate->dst;
> +	struct drm_framebuffer *fb =3D pstate->fb;
> +	int half_hdisplay =3D cstate->adjusted_mode.crtc_hdisplay >> 1;
> +	int hscale =3D drm_rect_calc_hscale(src, dst, 0, INT_MAX);
> +	int dst_w =3D drm_rect_width(dst);
> +	int src_w =3D drm_rect_width(src) >> 16;
> +	int left_dst_w, left_src_w, right_dst_w;
> +
> +	if (hscale < 0)
> +		return hscale;
> +
> +	left_dst_w =3D min(half_hdisplay, dst->x2) - dst->x1;
> +	if (left_dst_w < 0)
> +		left_dst_w =3D 0;
> +	right_dst_w =3D dst_w - left_dst_w;
> +
> +	if (!right_dst_w)
> +		left_src_w =3D src_w;
> +	else
> +		left_src_w =3D (left_dst_w * hscale) >> 16;
> +
> +	/*
> +	 * Make sure the yrgb/uv mst of the right window are byte aligned
> +	 * with full pixel.
> +	 */
> +	if (right_dst_w) {
> +		if (fb->format->format =3D=3D DRM_FORMAT_NV15 ||
> +		    fb->format->format =3D=3D DRM_FORMAT_NV20 ||
> +		    fb->format->format =3D=3D DRM_FORMAT_NV30)
> +			left_src_w &=3D ~0x7;
> +		else if (fb->format->is_yuv)
> +			left_src_w &=3D ~0x1;
> +	}

[Severity: Medium]
Can vop2_calc_splice_rects() produce odd-width source rectangles when
downscaling RGB planes on Esmart windows, or misaligned DMA start addresses
for NV15, NV20 and NV30?

vop2_plane_atomic_check() rejects odd src_w when downscaling on Esmart
windows, but only checks the unsplit src_w.  Because left_src_w &=3D ~0x1 is
only applied when fb->format->is_yuv, an even RGB source width split across
two Esmart windows can still give both halves odd widths.

Also, for NV15, NV20 and NV30 (where 8 luma pixels pack into 10 bytes),
masking left_src_w with ~0x7 only aligns right_src->x1 =3D src->x1 +
(left_src_w << 16) when src->x1 >> 16 is already a multiple of 8, whereas
vop2_plane_atomic_check() only enforces src_x % 2 =3D=3D 0.  A src_x of 2, =
4 or
6 leaves both windows' yrgb_mst and uv_mst unaligned.

[ ... ]

> +static int vop2_plane_left_in_splice(struct drm_plane *plane,
> +				     struct drm_atomic_commit *state)
> +{
> +	struct vop2_win *win =3D to_vop2_win(plane);
> +	struct drm_plane_state *lstate;
> +	struct drm_crtc_state *lcstate;
> +	struct drm_crtc *lcrtc;
> +	int ret;
> +
> +	if (!win->left_win)
> +		return 0;
> +
> +	lstate =3D drm_atomic_get_new_plane_state(state, &win->left_win->base);
> +	if (!lstate) {
> +		ret =3D drm_modeset_lock(&win->left_win->base.mutex,
> +				       state->acquire_ctx);
> +		if (ret && ret !=3D -EALREADY)
> +			return ret;
> +
> +		lstate =3D win->left_win->base.state;
> +	}
> +
> +	if (!lstate || !lstate->crtc)
> +		return 0;
> +
> +	lcrtc =3D lstate->crtc;
> +
> +	lcstate =3D drm_atomic_get_new_crtc_state(state, lcrtc);
> +	if (!lcstate) {
> +		ret =3D drm_modeset_lock(&lcrtc->mutex, state->acquire_ctx);
> +		if (ret && ret !=3D -EALREADY)
> +			return ret;
> +
> +		lcstate =3D lcrtc->state;
> +	}
> +
> +	if (!lcstate || !lcstate->enable)
> +		return 0;
> +
> +	return vop2_vp_uses_splice(to_vop2_video_port(lcrtc), lcstate);
> +}

[Severity: Medium]
Does vop2_plane_left_in_splice() miss the case where win->left_win was acti=
ve
in splice mode in the old state and is being disabled or detached in the sa=
me
commit that enables win on another CRTC?

Unlike vop2_crtc_atomic_check(), which checks both rstate->crtc and
old_rstate->crtc when entering splice mode, vop2_plane_left_in_splice() only
checks the new plane and CRTC states.  If a single commit detaches
win->left_win from the spliced CRTC and enables win on another CRTC, the
second CRTC's atomic_begin() runs before vop2_plane_atomic_disable(), so
rk3568_vop2_setup_layer_mixer() overwrites RK3568_OVL_CTRL__LAYERSEL_REGDON=
E_SEL
and migrates win's port mux in RK3568_OVL_PORT_SEL while win is still enabl=
ed
with the spliced CRTC's buffer.

[ ... ]

> @@ -1122,15 +1389,33 @@ static int vop2_plane_atomic_check(struct drm_pla=
ne *plane,
>  		return -EINVAL;
>  	}
> =20
> -	if (src_w > vop2_data->max_input.width ||
> -	    src_h > vop2_data->max_input.height) {
> +	max_src_w =3D vop2_data->max_input.width;
> +	if (vop2_vp_uses_splice(vp, cstate))
> +		max_src_w *=3D 2;
> +
> +	if (src_w > max_src_w || src_h > vop2_data->max_input.height) {
>  		drm_dbg_kms(vop2->drm, "Invalid source: %dx%d. max input: %dx%d\n",
> -			    src_w, src_h,
> -			    vop2_data->max_input.width,
> -			    vop2_data->max_input.height);
> +			    src_w, src_h, max_src_w, vop2_data->max_input.height);
>  		return -EINVAL;
>  	}
> =20
> +	if (vop2_vp_uses_splice(vp, cstate)) {
> +		ret =3D vop2_plane_splice_check(pstate, cstate);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (win->left_win) {
> +		ret =3D vop2_plane_left_in_splice(plane, astate);
> +		if (ret < 0)
> +			return ret;
> +		if (ret) {
> +			drm_dbg_kms(vop2->drm, "%s is in use by %s in splice mode\n",
> +				    win->left_win->data->name, win->data->name);
> +			return -EBUSY;
> +		}
> +	}

[Severity: High]
Can an off-screen plane bypass vop2_plane_left_in_splice() and
vop2_plane_splice_check()?

vop2_plane_atomic_check() returns 0 when !pstate->visible before reaching
these checks, even though pstate->crtc is set and the plane remains in
cstate->plane_mask.  If a right-half splice window is attached to another
CRTC at off-screen coordinates while splice mode is active,
rk3568_vop2_setup_overlay() still iterates over crtc->state->plane_mask and
reassigns the window's port and layer muxing in RK3568_OVL_PORT_SEL and
RK3568_OVL_LAYER_SEL, and vop2_plane_atomic_update() then calls
vop2_plane_atomic_disable(), turning off the active right-half window.

[ ... ]

> @@ -1487,6 +1780,45 @@ static void vop2_plane_atomic_update(struct drm_pl=
ane *plane,
>  	}
>  }
> =20
> +static void vop2_plane_atomic_update(struct drm_plane *plane,
> +				     struct drm_atomic_commit *state)
> +{
> +	struct drm_plane_state *pstate =3D plane->state;
> +	struct drm_crtc *crtc =3D pstate->crtc;
> +	struct vop2_win *win =3D to_vop2_win(plane);
> +	struct drm_crtc_state *cstate;
> +	struct rockchip_crtc_state *vcstate;
> +	struct drm_rect left_src, left_dst, right_src, right_dst;
> +
> +	if (WARN_ON(!crtc))
> +		return;
> +
> +	if (!pstate->visible) {
> +		vop2_plane_atomic_disable(plane, state);
> +		return;
> +	}
> +
> +	cstate =3D drm_atomic_get_new_crtc_state(state, crtc);
> +	if (!cstate)
> +		cstate =3D crtc->state;
> +	vcstate =3D to_rockchip_crtc_state(cstate);
> +
> +	if (!vcstate->splice_mode) {
> +		vop2_win_atomic_update(win, &pstate->src, &pstate->dst, pstate);
> +		return;
> +	}

[Severity: High]
Does vop2_plane_atomic_update() leave win->splice_win enabled when a visible
plane moves from a spliced CRTC to a non-spliced CRTC, or when its CRTC
switches out of splice mode?

When the plane stays visible across the commit, vop2_plane_atomic_disable()=
 is
not called.  vop2_plane_atomic_update() sees !vcstate->splice_mode on the n=
ew
CRTC state, updates only win, and returns without disabling win->splice_win,
leaving the right-half window enabled and scanning out the old framebuffer =
DMA
address after the old framebuffer is unreferenced and freed.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116084555.1061=
-1-kernel@airkyi.com?part=3D3
