Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8BE606A319
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 07:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WFKmi2j4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D373D10E220;
	Thu, 22 Oct 2026 07:46:10 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1D8610E220
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 07:46:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D21F360235;
 Thu, 22 Oct 2026 07:46:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 612661F000C1;
 Thu, 22 Oct 2026 07:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792655163;
 bh=8scVEgPhlsJ7vcgo1MtMl8PRXK0grLnJDWMvNULq4To=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=WFKmi2j4x77PwxMquT6T0PUZf41vibYxSxuPGUt5I8LPcdummAKXuw66YHik1La4G
 5pjBgBzch8/ifl6H4KnxLa/tSQOsYi98d7PXp3hpux/zdKfuwQX8kOeHIswnhQWd59
 9wsTK0Wzzy/BAIlzrfIgX+fr7opFMZ/gLFzo7kiJUNI5Bjrl7zStVt8lDnjc8ysvr/
 fd+6iN3CP0eXucoLcPi/QF48RTx5AD7Skh7Ix8dxC4z2vbmJ8dhXWWSdCm/A//bH9Y
 dG7Gve34jCbJCCO1+I9CPuOcfROXni8Hf1oGhQUiKNspaleS+r2HqvD9igI3gCzF/o
 suOhE6r2gMHlQ==
Message-ID: <sashiko-outbox-181132@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] drm/rockchip: vop2: Support 8K output by splicing
 two video ports
To: "Chaoyi Chen" <kernel@airkyi.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261022071737.508-4-kernel@airkyi.com>
References: <20261022071737.508-1-kernel@airkyi.com>
 <20261022071737.508-4-kernel@airkyi.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 07:46:02 +0000
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

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:
- [Critical] drm/rockchip: vop2: unconditional left_win lookup in vop2_win_=
get_pstate()
- [High] drm/rockchip: vop2: unreserved splice_win planes conflict across C=
RTCs
- [High] drm/rockchip: vop2: unlocked and non-atomic splice_vp check in ato=
mic_check
- [High] drm/rockchip: vop2: NULL crtc->state deref on vop2_crtc_atomic_ena=
ble() error
- [High] drm/rockchip: vop2: unvalidated split rects in vop2_plane_splice_c=
heck()
- [High] drm/rockchip: vop2: wrong VP ID and cfg_done wait in setup_layer_m=
ixer()
- [High] drm/rockchip: vop2: unlatched splice_win disable in vop2_crtc_atom=
ic_disable()
- [Medium] drm/rockchip: vop2: wrong window target in vop2_plane_setup_colo=
r_key() call
--

commit 5afbbbf195591a121c509707a5216215ec7b5279
Author: Chaoyi Chen <chaoyi.chen@rock-chips.com>

drm/rockchip: vop2: Support 8K output by splicing two video ports

This commit adds 8K display mode support on RK3588 VOP2 by splicing two vid=
eo
ports (VP0 and VP1) and pairing windows horizontally across the left and ri=
ght
halves of the screen. It updates CRTC, plane, and overlay/post-processing
configuration to split planes and program both video ports.

> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/d=
rm/rockchip/rockchip_drm_vop2.c
> index 71312bbeabeb1..f5a52554eaae8 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c

[ ... ]

> @@ -1012,13 +1013,33 @@ static void vop2_crtc_atomic_disable(struct drm_c=
rtc *crtc,
>  				     struct drm_atomic_commit *state)
>  {
>  	struct vop2_video_port *vp =3D to_vop2_video_port(crtc);
> +	struct rockchip_crtc_state *old_vcstate;
> +	struct vop2_video_port *splice_vp =3D NULL;
>  	struct vop2 *vop2 =3D vp->vop2;
>  	struct drm_crtc_state *old_crtc_state;
> +	struct drm_plane *plane;
>  	int ret;
> =20
>  	vop2_lock(vop2);
> =20
>  	old_crtc_state =3D drm_atomic_get_old_crtc_state(state, crtc);
> +	old_vcstate =3D to_rockchip_crtc_state(old_crtc_state);
> +	if (old_vcstate->splice_mode)
> +		splice_vp =3D &vop2->vps[vop2->data->vp[vp->id].splice_vp_id];
> +
> +	/*
> +	 * The right windows are not tracked by the plane states, disable
> +	 * them before the video ports are put into standby.
> +	 */
> +	if (splice_vp) {
> +		drm_atomic_crtc_state_for_each_plane(plane, old_crtc_state) {
> +			struct vop2_win *win =3D to_vop2_win(plane)->splice_win;
> +
> +			if (win)
> +				vop2_win_disable(win);
> +		}
> +	}
> +
>  	drm_atomic_helper_disable_planes_on_crtc(old_crtc_state, false);
> =20
>  	drm_crtc_vblank_off(crtc);
> @@ -1034,6 +1055,9 @@ static void vop2_crtc_atomic_disable(struct drm_crt=
c *crtc,
> =20
>  	vop2_crtc_enable_irq(vp, VP_INT_DSP_HOLD_VALID);
> =20
> +	if (splice_vp)
> +		vop2->ops->setup_splice(vp, false);
> +
>  	vop2_vp_write(vp, RK3568_VP_DSP_CTRL, RK3568_VP_DSP_CTRL__STANDBY);

[Severity: High]
When old_vcstate->splice_mode is true, vop2_crtc_atomic_disable() disables
each plane's splice_win via vop2_win_disable(win) and clears
RK3568_LUT_PORT_SEL__SPLICE_EN, but never calls vop2_cfg_done().

Furthermore, vop2_cfg_done(vp) checks vcstate->splice_mode on vp->crtc.state
(the new CRTC state):

    if (vcstate->splice_mode) {
        int splice_vp_id =3D vop2->data->vp[vp->id].splice_vp_id;

        val |=3D BIT(splice_vp_id) | (BIT(splice_vp_id) << 16);
    }

If a CRTC transitions from an 8K splice mode to a non-splice mode (or is
disabled while another CRTC keeps VOP2 powered on), the new vcstate->splice=
_mode
is false, so subsequent vop2_cfg_done(vp) calls only set BIT(vp->id) and ne=
ver
set BIT(splice_vp_id).

Won't this leave the shadowed VOP2_WIN_ENABLE and VOP2_WIN_CLUSTER_ENABLE
register writes on splice_win unlatched in hardware?

> @@ -1064,6 +1093,152 @@ static void vop2_crtc_atomic_disable(struct drm_c=
rtc *crtc,

[ ... ]

> +	/*
> +	 * Make sure the yrgb/uv mst of the right window are byte aligned
> +	 * with full pixel.
> +	 */
> +	if (right_dst_w) {
> +		if (fb->format->format =3D=3D DRM_FORMAT_NV15)
> +			left_src_w &=3D ~0x7;
> +		else if (fb->format->is_yuv)
> +			left_src_w &=3D ~0x1;
> +	}
> +
> +	if (left_src_w > src_w)
> +		left_src_w =3D src_w;
> +
> +	left_src->x1 =3D src->x1;
> +	left_src->x2 =3D src->x1 + (left_src_w << 16);
> +	left_dst->x1 =3D dst->x1;
> +	left_dst->x2 =3D dst->x1 + left_dst_w;
> +
> +	right_src->x1 =3D left_src->x2;
> +	right_src->x2 =3D src->x2;
> +	right_dst->x1 =3D dst->x1 + left_dst_w - half_hdisplay;
> +	if (right_dst->x1 < 0)
> +		right_dst->x1 =3D 0;
> +	right_dst->x2 =3D right_dst->x1 + right_dst_w;
> +
> +	left_src->y1 =3D right_src->y1 =3D src->y1;
> +	left_src->y2 =3D right_src->y2 =3D src->y2;
> +	left_dst->y1 =3D right_dst->y1 =3D dst->y1;
> +	left_dst->y2 =3D right_dst->y2 =3D dst->y2;
> +
> +	return 0;
> +}
> +
> +static int vop2_cluster_splice_scale_check(struct vop2_win *win,
> +					   struct drm_plane_state *pstate,
> +					   int hdisplay)
> +{
> +	struct drm_rect *src =3D &pstate->src;
> +	struct drm_rect *dst =3D &pstate->dst;
> +	int half_hdisplay =3D hdisplay >> 1;
> +
> +	/* scale up is ok */
> +	if ((drm_rect_width(src) >> 16) <=3D drm_rect_width(dst))
> +		return 0;
> +
> +	if ((drm_rect_width(src) >> 16) <=3D VOP2_MAX_VP_OUTPUT_WIDTH)
> +		return 0;
> +	/*
> +	 * Cluster scale down limitation in splice mode:
> +	 * If scale down, must display at horizontal center
> +	 */
> +	if (dst->x1 < half_hdisplay && dst->x2 > half_hdisplay) {
> +		if (dst->x2 + dst->x1 !=3D hdisplay) {
> +			drm_dbg_kms(win->vop2->drm,
> +				    "%s must scale down at center in splice mode\n",
> +				    win->data->name);
> +			return -EINVAL;
> +		}
> +
> +		if (drm_rect_calc_hscale(src, dst, 1, FRAC_16_16(6, 5)) < 0) {
> +			drm_dbg_kms(win->vop2->drm,
> +				    "%s scale down factor should be < 1.2 in splice mode\n",
> +				    win->data->name);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int vop2_plane_splice_check(struct drm_plane_state *pstate,
> +				   struct drm_crtc_state *cstate)
> +{
> +	struct vop2_win *win =3D to_vop2_win(pstate->plane);
> +	struct vop2 *vop2 =3D win->vop2;
> +	struct vop2_win *splice_win =3D win->splice_win;
> +	struct drm_rect left_src, left_dst, right_src, right_dst;
> +	int ret;
> +
> +	if (!(win->data->feature & WIN_FEATURE_SPLICE_LEFT) || !splice_win) {
> +		drm_dbg_kms(vop2->drm, "%s cannot be used in splice mode\n",
> +			    win->data->name);
> +		return -EINVAL;
> +	}
> +
> +	if (pstate->rotation & (DRM_MODE_ROTATE_90 | DRM_MODE_ROTATE_270 |
> +				DRM_MODE_REFLECT_X)) {
> +		drm_dbg_kms(vop2->drm, "%s can't rotate 270/90 and xmirror in splice m=
ode\n",
> +			    win->data->name);
> +		return -EINVAL;
> +	}
> +
> +	if (vop2_cluster_window(win)) {
> +		ret =3D vop2_cluster_splice_scale_check(win, pstate,
> +						      cstate->adjusted_mode.hdisplay);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret =3D vop2_calc_splice_rects(pstate, cstate, &left_src, &left_dst,
> +				     &right_src, &right_dst);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}

[Severity: High]
In vop2_plane_atomic_check(), the minimum size check (src_w >=3D 4, dest_w =
>=3D 4)
is only performed on the combined plane, and max_src_w is doubled to
2 * vop2_data->max_input.width. vop2_plane_splice_check() then computes
left_src, left_dst, right_src, and right_dst via vop2_calc_splice_rects(),
but does not validate the resulting split rectangles:

1. If a plane straddles half_hdisplay such that either split half has a
   non-zero width smaller than 4 pixels (or if left_src_w is rounded down to
   0 by the NV15/YUV alignment mask while left_dst_w > 0),
   vop2_plane_atomic_check() succeeds. During commit, vop2_win_atomic_updat=
e()
   will then trigger WARN_ON(dsp_w < 4) || WARN_ON(src_w < 4) and return
   early without updating VOP2_WIN_YRGB_MST or disabling the window, leaving
   a previously active window scanning out a stale DMA address.

2. If a plane with src_w > 4096 is placed wholly or mostly on one half of t=
he
   screen (for example, dst->x2 <=3D half_hdisplay or dst->x1 >=3D half_hdi=
splay,
   which also bypasses the dst->x1 < half_hdisplay && dst->x2 > half_hdispl=
ay
   check in vop2_cluster_splice_scale_check(), or on an Esmart window),
   left_src_w or right_src_w will exceed the single-window maximum input
   width of 4096.

3. In vop2_calc_splice_rects(), the 8-pixel alignment mask (left_src_w &=3D=
 ~0x7)
   only checks DRM_FORMAT_NV15, missing DRM_FORMAT_NV20 and DRM_FORMAT_NV30
   which also use packed 10-bit YUV blocks on Esmart windows.

Should vop2_plane_splice_check() validate that each visible half satisfies
the per-window minimum (4) and maximum (vop2_data->max_input.width) width
constraints, and should vop2_calc_splice_rects() also align DRM_FORMAT_NV20
and DRM_FORMAT_NV30 to 8 pixels?

[ ... ]

> @@ -1468,7 +1659,7 @@ static void vop2_plane_atomic_update(struct drm_pla=
ne *plane,
> =20
>  	vop2_setup_scale(vop2, win, src_w, src_h, dsp_w, dsp_h, fb->format->for=
mat);
>  	if (!vop2_cluster_window(win))
> -		vop2_plane_setup_color_key(plane, 0);
> +		vop2_plane_setup_color_key(pstate->plane, 0);
>  	vop2_win_write(win, VOP2_WIN_ACT_INFO, act_info);
>  	vop2_win_write(win, VOP2_WIN_DSP_INFO, dsp_info);
>  	vop2_win_write(win, VOP2_WIN_DSP_ST, dest->y1 << 16 | (dest->x1 & 0xfff=
f));

[Severity: Medium]
When vop2_plane_atomic_update() calls vop2_win_atomic_update() for
win->splice_win, pstate->plane still points to the left window's drm_plane.
Inside vop2_plane_setup_color_key(), the target window is resolved via
to_vop2_win(plane):

    struct vop2_win *win =3D to_vop2_win(plane);

Doesn't this program VOP2_WIN_COLOR_KEY_EN and VOP2_WIN_COLOR_KEY on the le=
ft
window a second time instead of programming win->splice_win when updating an
Esmart window in splice mode?

> @@ -1488,6 +1679,45 @@ static void vop2_plane_atomic_update(struct drm_pl=
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
> +
> +	if (!win->splice_win)
> +		return;
> +
> +	if (WARN_ON(vop2_calc_splice_rects(pstate, cstate, &left_src, &left_dst,
> +					  &right_src, &right_dst)))
> +		return;
> +
> +	vop2_win_atomic_update(win, &left_src, &left_dst, pstate);
> +	vop2_win_atomic_update(win->splice_win, &right_src, &right_dst, pstate);
> +}

[Severity: High]
In vop2_create_crtcs(), all right-half windows (Cluster1-win0, Cluster3-win=
0,
Esmart1-win0, Esmart3-win0) are still registered as independent DRM primary=
 or
overlay planes. For example, when VP1 has no DT port, the primary plane loop
in vop2_create_crtcs() skips VP1 and assigns Cluster1-win0
(Cluster0-win0->splice_win) as VP2's primary plane, while the remaining
right-half windows are registered as overlay planes with possible_crtcs
covering all CRTCs.

However, neither vop2_plane_splice_check() nor vop2_plane_atomic_check()
verifies whether win->splice_win is currently active as a DRM plane on anot=
her
CRTC, or prevents another CRTC from enabling a plane whose win->left_win is
active on a spliced CRTC:

1. If VP0 is in 8K splice mode using Cluster0 or Esmart0 while VP2 uses
   Cluster1 or Esmart1, both CRTCs will concurrently overwrite the same
   physical window registers, win->delay, and RK3568_OVL_PORT_SEL.

2. Because every splice_win has a higher plane index than its left_win, if a
   right-half DRM plane is disabled in the same atomic commit that updates
   its left_win in splice mode, drm_atomic_helper_commit_planes() calls
   vop2_plane_atomic_update(left_win) first (enabling win->splice_win) and
   then calls vop2_plane_atomic_disable(splice_win) second, which calls
   vop2_win_disable(splice_win) and turns off the right half of the spliced
   plane.

How is exclusive ownership of win->splice_win enforced between the spliced
CRTC and other CRTCs?

[ ... ]

> @@ -1941,6 +2203,14 @@ static void vop2_crtc_atomic_enable(struct drm_crt=
c *crtc,
> =20
>  	clk_set_rate(vp->dclk, clock);
> =20
> +	if (vcstate->splice_mode) {
> +		splice_vp =3D &vop2->vps[vp_data->splice_vp_id];
> +		splice_vp->splice_mode_right =3D true;
> +		splice_vp->left_vp =3D vp;
> +
> +		vop2->ops->setup_splice(vp, true);
> +	}
> +
>  	vop2_post_config(crtc, true, crtc_state, old_crtc_state);

[Severity: High]
What happens if vop2_crtc_atomic_enable() returns early on an error path
(such as clk_prepare_enable(vp->dclk) failing or !clock) before
splice_vp->splice_mode_right and splice_vp->left_vp are initialized here?

Because vcstate->splice_mode was already set to true in
vop2_crtc_atomic_check(), the subsequent calls in the same commit to
vop2_crtc_atomic_begin() -> rk3568_vop2_setup_overlay() ->
rk3568_vop2_setup_layer_mixer(splice_vp) and vop2_crtc_atomic_flush() ->
vop2_post_config() -> rk3568_vop2_setup_bg_dly(splice_vp) will still execute
for splice_vp.

In both rk3568_vop2_setup_layer_mixer() and rk3568_vop2_setup_bg_dly():

    if (vp->splice_mode_right)
        crtc =3D &vp->left_vp->crtc;
    vcstate =3D to_rockchip_crtc_state(crtc->state);

Since splice_vp->splice_mode_right is still false, crtc remains
&splice_vp->crtc, and when splice_vp is reserved without a DT port,
splice_vp->crtc.state is NULL, causing a NULL pointer dereference.

> @@ -1985,21 +2255,59 @@ static int vop2_crtc_atomic_check(struct drm_crtc=
 *crtc,
>  				  struct drm_atomic_commit *state)
>  {
>  	struct vop2_video_port *vp =3D to_vop2_video_port(crtc);
> +	struct vop2 *vop2 =3D vp->vop2;
> +	const struct vop2_video_port_data *vp_data =3D &vop2->data->vp[vp->id];
> +	struct drm_crtc_state *crtc_state =3D drm_atomic_get_new_crtc_state(sta=
te, crtc);
> +	struct rockchip_crtc_state *vcstate =3D to_rockchip_crtc_state(crtc_sta=
te);
> +	struct drm_display_mode *mode =3D &crtc_state->adjusted_mode;
> +	struct vop2_video_port *splice_vp;
>  	struct drm_plane *plane;
>  	int nplanes =3D 0;
> -	struct drm_crtc_state *crtc_state =3D drm_atomic_get_new_crtc_state(sta=
te, crtc);
>  	int ret;
> =20
>  	ret =3D vop2_crtc_atomic_check_gamma(vp, crtc, state, crtc_state);
>  	if (ret)
>  		return ret;
> =20
> +	if (vp->splice_mode_right && crtc_state->active)
> +		return -EBUSY;
> +
>  	drm_atomic_crtc_state_for_each_plane(plane, crtc_state)
>  		nplanes++;
> =20
>  	if (nplanes > vp->nlayers)
>  		return -EINVAL;
> =20
> +	vcstate->splice_mode =3D false;
> +	if (crtc_state->enable && mode->hdisplay > VOP2_MAX_VP_OUTPUT_WIDTH) {
> +		const struct drm_crtc_state *splice_state;
> +
> +		if (!(vop2->data->feature & VOP2_FEATURE_SPLICE) ||
> +		    vp_data->max_output.width <=3D VOP2_MAX_VP_OUTPUT_WIDTH)
> +			return -EINVAL;
> +
> +		splice_vp =3D &vop2->vps[vp_data->splice_vp_id];
> +		if (splice_vp->crtc.state) {
> +			splice_state =3D drm_atomic_get_new_crtc_state(state, &splice_vp->crt=
c);
> +			if (!splice_state)
> +				splice_state =3D splice_vp->crtc.state;
> +			if (splice_state->active) {
> +				drm_dbg_kms(vop2->drm, "vp%d is already in use\n",
> +					    splice_vp->id);
> +				return -EBUSY;
> +			}
> +		}
> +
> +		/*
> +		 * The right half uses its own set of OVL layers, both video
> +		 * ports need enough layers for the planes of the left CRTC.
> +		 */
> +		if (nplanes > min(vp->nlayers, splice_vp->nlayers))
> +			return -EINVAL;
> +
> +		vcstate->splice_mode =3D true;
> +	}
> +
>  	return 0;
>  }

[Severity: High]
There appear to be several synchronization and atomic state issues with how
splice_vp is checked and reserved here:

1. vop2_crtc_atomic_check() runs on every atomic check involving crtc,
   including plane updates where splice_vp->crtc.mutex is not held. When
   splice_vp->crtc is not part of state, falling back to reading
   splice_vp->crtc.state directly without holding splice_vp->crtc.mutex rac=
es
   with concurrent commits on splice_vp->crtc swapping and freeing its old
   crtc_state in drm_atomic_helper_swap_state() -> vop2_crtc_destroy_state(=
).
   Not adding splice_vp->crtc to state also means drm_atomic_helper_setup_c=
ommit()
   will not serialize against in-flight non-blocking commits on splice_vp.

2. vp->splice_mode_right is mutated during commit_tail in
   vop2_crtc_atomic_enable() and vop2_crtc_atomic_disable() rather than bei=
ng
   derived from the atomic state being checked. If userspace submits a sing=
le
   atomic commit (or DRM_MODE_ATOMIC_TEST_ONLY check) that switches VP0 from
   an 8K mode to a 4K mode while enabling VP1, vop2_crtc_atomic_check() for
   VP1 will still see vp->splice_mode_right =3D=3D true and reject the comm=
it with
   -EBUSY (and vop2_crtc_mode_valid() will similarly reject all modes on VP1
   with MODE_BAD while VP0 is in splice mode). Conversely, after a
   non-blocking commit enabling splice mode on VP0 swaps state and drops
   locks, vp1->splice_mode_right remains false until commit_work runs
   vop2_crtc_atomic_enable(), allowing a racing commit on VP1 to pass
   vop2_crtc_atomic_check().

3. Checking crtc_state->active and splice_state->active instead of ->enable
   allows VP0 to steal VP1 while VP1 is in DPMS OFF (enable =3D=3D true,
   active =3D=3D false), and because vop2_crtc_atomic_disable() clears
   splice_vp->splice_mode_right on DPMS OFF, VP1 can be enabled while VP0 is
   in DPMS OFF, causing VP0's subsequent DPMS ON to fail with -EBUSY.

Could vop2_crtc_atomic_check() instead acquire the partner CRTC state via
drm_atomic_get_crtc_state() when modesetting and check enable rather than
active and commit-time splice_mode_right?

> diff --git a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c b/drivers/gpu/d=
rm/rockchip/rockchip_vop2_reg.c
> index c44648e1bc0d6..8d97dcd10ec10 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c

[ ... ]

> @@ -1387,6 +1394,18 @@ static struct vop2_win *vop2_find_win_by_phys_id(s=
truct vop2 *vop2, uint8_t phys
>  	return NULL;
>  }
> =20
> +/*
> + * The right window in splice mode shares the plane state of the left on=
e,
> + * only its registers and position on the screen are different.
> + */
> +static struct drm_plane_state *vop2_win_get_pstate(struct vop2_win *win)
> +{
> +	if (win->left_win)
> +		return win->left_win->base.state;
> +
> +	return win->base.state;
> +}

[ ... ]

> @@ -1894,7 +1913,7 @@ static void vop2_setup_cluster_alpha(struct vop2 *v=
op2, struct vop2_win *main_wi
>  {
>  	struct vop2_alpha_config alpha_config;
>  	struct vop2_alpha alpha;
> -	struct drm_plane_state *bottom_win_pstate;
> +	struct drm_plane_state *pstate =3D vop2_win_get_pstate(main_win);
>  	bool src_pixel_alpha_en =3D false;
>  	u16 src_glb_alpha_val, dst_glb_alpha_val;
>  	u32 src_color_ctrl_reg, dst_color_ctrl_reg, src_alpha_ctrl_reg, dst_alp=
ha_ctrl_reg;
> @@ -1903,11 +1922,10 @@ static void vop2_setup_cluster_alpha(struct vop2 =
*vop2, struct vop2_win *main_wi
>  	bool swap =3D false;
> =20
>  	/* At one win mode, win0 is dst/bottom win, and win1 is a all zero src/=
top win */
> -	bottom_win_pstate =3D main_win->base.state;
>  	src_glb_alpha_val =3D 0;
> -	dst_glb_alpha_val =3D main_win->base.state->alpha;
> +	dst_glb_alpha_val =3D pstate->alpha;
> =20
> -	if (!bottom_win_pstate->fb)
> +	if (!pstate->fb)
>  		return;

[ ... ]

> @@ -2003,9 +2025,12 @@ static void vop2_setup_alpha(struct vop2_video_por=
t *vp)
>  		dst_alpha_ctrl_reg =3D RK3576_OVL_MIX0_DST_ALPHA_CTRL(vp->id);
>  	}
> =20
> -	drm_atomic_crtc_for_each_plane(plane, &vp->crtc) {
> -		struct vop2_win *win =3D to_vop2_win(plane);
> -		int zpos =3D plane->state->normalized_zpos;
> +	for_each_set_bit(phys_id, &win_mask, BITS_PER_TYPE(u32)) {
> +		int zpos;
> +
> +		win =3D vop2_find_win_by_phys_id(vop2, phys_id);
> +		pstate =3D vop2_win_get_pstate(win);
> +		zpos =3D pstate->normalized_zpos;
> =20
>  		/*
>  		 * Need to configure alpha from second layer.
> @@ -2013,13 +2038,12 @@ static void vop2_setup_alpha(struct vop2_video_po=
rt *vp)
>  		if (zpos =3D=3D 0)
>  			continue;
> =20
> -		if (plane->state->pixel_blend_mode =3D=3D DRM_MODE_BLEND_PREMULTI)
> +		if (pstate->pixel_blend_mode =3D=3D DRM_MODE_BLEND_PREMULTI)
>  			premulti_en =3D 1;
>  		else
>  			premulti_en =3D 0;
> =20
> -		plane =3D &win->base;
> -		fb =3D plane->state->fb;
> +		fb =3D pstate->fb;
> =20
>  		pixel_alpha_en =3D fb->format->has_alpha;

[Severity: Critical]
In vop2_win_init(), win->splice_win->left_win =3D win is set unconditionall=
y at
probe time for Cluster1, Cluster3, Esmart1, and Esmart3, and is never clear=
ed.
However, vop2_win_get_pstate(win) unconditionally returns
win->left_win->base.state whenever win->left_win is non-NULL, even when the
video port is operating in normal non-splice mode (!vp->splice_mode_right) =
and
win is being used as an independent DRM plane.

When Cluster1, Cluster3, Esmart1, or Esmart3 is enabled on any CRTC in norm=
al
non-splice mode while its corresponding left_win (Cluster0, Cluster2, Esmar=
t0,
or Esmart2) is disabled (so left_win->base.state->fb is NULL):

1. vop2_setup_cluster_alpha() checks if (!pstate->fb) on left_win's state a=
nd
   returns early without configuring cluster alpha.

2. rk3568_vop2_setup_layer_mixer() computes layer_id from left_win's
   normalized_zpos instead of win->base.state->normalized_zpos.

3. Because vop2_plane_init() initializes default zpos to win->win_id (which=
 is
   non-zero for Cluster2, Esmart0, and Esmart2) and
   __drm_atomic_helper_plane_duplicate_state() preserves normalized_zpos ac=
ross
   plane disables, vop2_setup_alpha() can see zpos !=3D 0 on the disabled
   left_win's state and dereference fb =3D pstate->fb (NULL) at
   fb->format->has_alpha.

4. Because win->left_win->base is a separate drm_plane that may be bound to
   another CRTC, the committing CRTC does not hold win->left_win->base.mute=
x,
   so a concurrent atomic commit on another CRTC can swap and free
   win->left_win->base.state while vop2_setup_cluster_alpha(),
   rk3568_vop2_setup_layer_mixer(), and vop2_setup_alpha() are dereferencing
   it.

Should vop2_win_get_pstate() only resolve through win->left_win when the vi=
deo
port is actually acting as the right half in splice mode
(vp->splice_mode_right)?

[ ... ]

> @@ -2301,7 +2337,12 @@ static void rk3568_vop2_setup_layer_mixer(struct v=
op2_video_port *vp)
>  	if (port_sel !=3D vop2->old_port_sel) {
>  		vop2->old_port_sel =3D port_sel;
>  		vop2_writel(vop2, RK3568_OVL_PORT_SEL, port_sel);
> -		vop2_cfg_done(vp);
> +		/*
> +		 * The port mux can only take effect together with the config
> +		 * done of the video port owning the CRTC state. In splice mode
> +		 * that also latches the registers of the right video port.
> +		 */
> +		vop2_cfg_done(vp->splice_mode_right ? vp->left_vp : vp);
>  		rk3568_vop2_wait_for_port_mux_done(vop2);
>  	}
> =20
> @@ -2354,33 +2395,63 @@ static void rk3568_vop2_setup_dly_for_windows(str=
uct vop2_video_port *vp)

[ ... ]

> +static void rk3568_vop2_setup_overlay(struct vop2_video_port *vp)
> +{
> +	struct vop2 *vop2 =3D vp->vop2;
> +	struct rockchip_crtc_state *vcstate =3D to_rockchip_crtc_state(vp->crtc=
.state);
> +	const struct vop2_video_port_data *vp_data =3D &vop2->data->vp[vp->id];
> +	struct vop2_video_port *splice_vp =3D NULL;
> +	struct drm_plane *plane;
> +
> +	vp->win_mask =3D 0;
> +	if (vcstate->splice_mode) {
> +		splice_vp =3D &vop2->vps[vp_data->splice_vp_id];
> +		splice_vp->win_mask =3D 0;
> +	}
> +
> +	/*
> +	 * The right video port shares the plane state of the left one, only
> +	 * the windows it uses and their position on the screen differ.
> +	 */
> +	drm_atomic_crtc_for_each_plane(plane, &vp->crtc) {
> +		struct vop2_win *win =3D to_vop2_win(plane);
> +
> +		vp->win_mask |=3D BIT(win->data->phys_id);
> +		if (splice_vp && win->splice_win)
> +			splice_vp->win_mask |=3D BIT(win->splice_win->data->phys_id);
> +	}
> +
> +	rk3568_vop2_setup_overlay_for_vp(vp);
> +	if (splice_vp)
> +		rk3568_vop2_setup_overlay_for_vp(splice_vp);
> +}

[Severity: High]
In rk3568_vop2_setup_overlay(), splice mode calls
rk3568_vop2_setup_overlay_for_vp(vp) followed immediately by
rk3568_vop2_setup_overlay_for_vp(splice_vp), which invokes
rk3568_vop2_setup_layer_mixer() twice back-to-back before
vop2_crtc_atomic_flush() has latched the first update:

    if (layer_sel !=3D vop2->old_layer_sel && atv_layer_sel !=3D vop2->old_=
layer_sel) {
        cfg_done =3D vop2_readl(vop2, RK3568_REG_CFG_DONE);
        cfg_done &=3D (BIT(vop2->data->nr_vps) - 1);
        cfg_done &=3D ~BIT(vp->id);
        /*
         * Changes of other VPs' overlays have not taken effect
         */
        if (cfg_done)
            rk3568_vop2_wait_for_layer_cfg_done(vop2);
    }

    if (layer_sel !=3D vop2->old_layer_sel || port_sel !=3D vop2->old_port_=
sel)
        ovl_ctrl |=3D FIELD_PREP(RK3568_OVL_CTRL__LAYERSEL_REGDONE_SEL, vp-=
>id);
    vop2_writel(vop2, RK3568_OVL_CTRL, ovl_ctrl);

1. In the second call (for splice_vp), RK3568_OVL_CTRL__LAYERSEL_REGDONE_SEL
   is set to vp->id (the right VP, which is in standby with no running dclk=
 or
   VSYNC) instead of vp->left_vp->id, overwriting the left VP ID programmed=
 by
   the first call. Won't that prevent the active left VP's VSYNC from latch=
ing
   RK3568_OVL_PORT_SEL and RK3568_OVL_LAYER_SEL, causing
   rk3568_vop2_wait_for_port_mux_done() to time out?

2. Because the first call updates vop2->old_layer_sel =3D layer_sel before =
the
   register is latched at VSYNC, the immediate second call for splice_vp se=
es
   atv_layer_sel !=3D vop2->old_layer_sel and layer_sel !=3D vop2->old_laye=
r_sel.
   Since cfg_done &=3D ~BIT(vp->id) only clears BIT(splice_vp->id) and leav=
es
   BIT(vp->left_vp->id) set (for example from vop2_crtc_atomic_enable()),
   won't the second call enter rk3568_vop2_wait_for_layer_cfg_done() and sp=
in
   for 50ms waiting for the uncommitted layer_sel from the first call?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022071737.508-=
1-kernel@airkyi.com?part=3D3
