Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9372D606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 08:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RSBb5ATq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F262F112105;
	Thu, 29 Oct 2026 08:45:18 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 310EC10E7A3
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 08:45:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C56EF43754;
 Thu, 29 Oct 2026 08:45:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BE8B1F01825;
 Thu, 29 Oct 2026 08:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793263512;
 bh=zimV11ZVmyT4t8FSST0oWbYNLl1pQTX1sprge2VPX4E=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=RSBb5ATqckNfxk/k/ArADekSzHK2Xg41Vxnyevxx+3raFLMc6+9h7mKb5M29jks/c
 wJLTDC1fZKHB3wD6Pu89kyUr7DuFI0Hvgq+bdLRbNB714M7alKNvGJoEghA27TYZ83
 F8tN5DmNt3WQo8jLurZ+/yZUBMQk3QBYWtkaKnY+cIwXrZTCwA+cubUQbzNWMFhzNq
 giHL6TwLCnzhfmjYJ+PMRe8rHHwh5NuXJWFj1gxc/55ej1dIDZwGZf5wB//E7zgplz
 ka/Vx0aPANxYMMJ/QzrIC8QihoCkEUNiua+JswSmpKdl4BdGvl7PgZ30VEPM/uWw39
 zq+DQlRoroVkQ==
Message-ID: <sashiko-outbox-188986@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] drm/rockchip: vop2: Support 8K output by
 splicing two video ports
To: "Chaoyi Chen" <kernel@airkyi.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261029081429.862-4-kernel@airkyi.com>
References: <20261029081429.862-1-kernel@airkyi.com>
 <20261029081429.862-4-kernel@airkyi.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 08:45:12 +0000
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

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [High] drm/rockchip: vop2: vop2_plane_atomic_check() adds unrelated CRTC =
on pageflips
- [High] drm/rockchip: vop2: stale splice_mode and incomplete plane conflic=
t checks
- [High] drm/rockchip: vop2: vop2_create_crtcs() binds splice_win as VP2 pr=
imary plane
- [High] drm/rockchip: vop2: broken CFG_DONE latching on splice disable and=
 modeset
- [High] drm/rockchip: vop2: back-to-back rk3568_vop2_setup_layer_mixer() t=
imes out
- [Medium] drm/rockchip: vop2: vop2_crtc_mode_valid() checks runtime splice=
_mode_right
- [Medium] drm/rockchip: vop2: unaligned Esmart downscale and NV15/20/30 sp=
lit rects
--

commit fb88a534f1ee73c5e200206f6544bce1ff6db310
Author: Chaoyi Chen <chaoyi.chen@rock-chips.com>

drm/rockchip: vop2: Support 8K output by splicing two video ports

This commit adds support for 8K display modes on RK3588 VOP2 by splicing
two video ports and splitting each plane horizontally across a pair of
hardware windows. It updates CRTC, plane, and overlay post-processing
configuration to reserve and program the partner video port and windows.

> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/d=
rm/rockchip/rockchip_drm_vop2.c
> index b3d6574bbd96a..acf8efe57719f 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
[ ... ]
> @@ -1012,13 +1013,32 @@ static void vop2_crtc_atomic_disable(struct drm_c=
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
> +	splice_vp =3D old_vcstate->splice_mode ? vop2_get_splice_vp(vp) : NULL;
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
> @@ -1034,6 +1054,9 @@ static void vop2_crtc_atomic_disable(struct drm_crt=
c *crtc,
> =20
>  	vop2_crtc_enable_irq(vp, VP_INT_DSP_HOLD_VALID);
> =20
> +	if (splice_vp)
> +		vop2->ops->setup_splice(vp, false);
> +
>  	vop2_vp_write(vp, RK3568_VP_DSP_CTRL, RK3568_VP_DSP_CTRL__STANDBY);
[ ... ]
> @@ -1064,6 +1092,202 @@ static void vop2_crtc_atomic_disable(struct drm_c=
rtc *crtc,
[ ... ]
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
Can vop2_calc_splice_rects() in drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
produce unaligned split rectangles for Esmart downscaling and NV15/NV20/NV30
formats?

First, in vop2_plane_atomic_check(), Esmart windows reject downscaling when
the source width is odd:

	if (!vop2_cluster_window(win) && src_w > dest_w && (src_w & 1)) {
		drm_dbg_kms(vop2->drm,
			    "Esmart windows cannot downscale odd-width source regions\n");
		return -EINVAL;
	}

That check only inspects the unsplit plane's src_w and dest_w. When
right_dst_w > 0 and !fb->format->is_yuv (RGB formats), vop2_calc_splice_rec=
ts()
computes left_src_w =3D (left_dst_w * hscale) >> 16 without rounding it to =
an
even width. An even total src_w downscaled on Esmart0/1 or Esmart2/3 can sp=
lit
into an odd left_src_w and an odd right_src_w, bypassing the check in
vop2_plane_atomic_check() and programming both Esmart hardware windows to
downscale odd-width source regions.

Second, for DRM_FORMAT_NV15, DRM_FORMAT_NV20, and DRM_FORMAT_NV30 (10-bit
packed YUV where 8 pixels occupy 10 bytes), vop2_calc_splice_rects() masks
left_src_w &=3D ~0x7 so the right window's start offset is byte-aligned on =
an
8-pixel boundary. However, right_src->x1 is set to src->x1 + (left_src_w <<=
 16),
and vop2_plane_atomic_check() only checks (src->x1 >> 16) % 2. When
src->x1 >> 16 is 2, 4, or 6, neither left_src->x1 >> 16 nor right_src->x1 >=
> 16
is a multiple of 8, causing drm_format_info_min_pitch() in
vop2_win_atomic_update() to compute non-byte-aligned yrgb_mst and uv_mst DMA
addresses.

Should vop2_calc_splice_rects() and vop2_plane_atomic_check() enforce 8-pix=
el
alignment on src_x for NV15/NV20/NV30 and ensure split Esmart downscale sou=
rce
widths are even?

[ ... ]
> @@ -1122,15 +1347,43 @@ static int vop2_plane_atomic_check(struct drm_pla=
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
> +		struct drm_plane_state *lstate;
> +		struct drm_crtc_state *lcstate;
> +
> +		lstate =3D drm_atomic_get_plane_state(astate, &win->left_win->base);
> +		if (IS_ERR(lstate))
> +			return PTR_ERR(lstate);
> +
> +		if (lstate->crtc) {
> +			lcstate =3D drm_atomic_get_crtc_state(astate, lstate->crtc);
> +			if (IS_ERR(lcstate))
> +				return PTR_ERR(lcstate);
> +
> +			if (to_rockchip_crtc_state(lcstate)->splice_mode) {
> +				drm_dbg_kms(vop2->drm, "%s is in use by %s in splice mode\n",
> +					    win->left_win->data->name, win->data->name);
> +				return -EBUSY;
> +			}
> +		}
> +	}

[Severity: High]
Does vop2_plane_atomic_check() in drivers/gpu/drm/rockchip/rockchip_drm_vop=
2.c
pull an unrelated CRTC into non-modeset pageflip commits whenever win->left=
_win
is set?

In vop2_win_init(), win->left_win is permanently populated at probe time for
Cluster1-win0, Cluster3-win0, Esmart1-win0, and Esmart3-win0. When userspace
submits a normal non-modeset plane update or pageflip (where
astate->allow_modeset is false) using any of those planes (for example, VP1=
's
primary plane Cluster1-win0 or VP3's primary plane Cluster3-win0, even when=
 no
CRTC is using splice mode), vop2_plane_atomic_check() unconditionally calls
drm_atomic_get_plane_state(astate, &win->left_win->base) and, when
lstate->crtc is non-NULL, drm_atomic_get_crtc_state(astate, lstate->crtc).

When win->left_win is active on another CRTC (such as Cluster0-win0 on VP0),
adding that unrelated CRTC state to a commit with allow_modeset =3D=3D false
triggers the kernel warning in drm_atomic_check_only():

	if (affected_crtc !=3D requested_crtc) {
		drm_dbg_atomic(dev,
			       "driver added CRTC to commit: requested 0x%x, affected 0x%0x\n",
			       requested_crtc, affected_crtc);
		WARN(!state->allow_modeset, "adding CRTC not allowed without modesets: re=
quested 0x%x, affected 0x%0x\n",
		     requested_crtc, affected_crtc);
	}

In addition, pulling the other CRTC and plane into astate causes stall_chec=
ks()
in drm_atomic_helper_setup_commit() to fail independent non-blocking pagefl=
ips
with -EBUSY whenever the other CRTC has an in-flight flip, and attaches a n=
ew
drm_crtc_commit to the other CRTC so that drm_atomic_helper_commit_planes()
reprograms and waits for vblank on the unrelated CRTC on every flip.

[ ... ]
> @@ -1524,6 +1824,16 @@ static enum drm_mode_status vop2_crtc_mode_valid(s=
truct drm_crtc *crtc,
>  {
>  	struct vop2_video_port *vp =3D to_vop2_video_port(crtc);
> =20
> +	/*
> +	 * For RK3588, VP0 and VP1 will be both used in splice mode. All display
> +	 * modes of the right VP should be set as invalid when vop2 is working =
in
> +	 * splice mode.
> +	 */
> +	if (vp->splice_mode_right) {
> +		DRM_DEV_DEBUG(vp->vop2->dev, "vp%d is in splice mode right\n", vp->id);
> +		return MODE_BAD;
> +	}
> +
>  	if (mode->hdisplay > vp->data->max_output.width)
>  		return MODE_BAD_HVALUE;

[Severity: Medium]
Is it safe for vop2_crtc_mode_valid() in
drivers/gpu/drm/rockchip/rockchip_drm_vop2.c to reject modes based on the
runtime vp->splice_mode_right flag?

vp->splice_mode_right is updated under vop2_lock(vop2) during commit_tail in
vop2_crtc_atomic_enable() and vop2_crtc_atomic_disable(). Reading it unlock=
ed
in vop2_crtc_mode_valid() causes drm_helper_probe_single_connector_modes() =
to
prune all modes on VP1's connector while VP0 is running in 8K splice mode.

Furthermore, because drm_atomic_helper_check_modeset() invokes mode_valid()
before atomic_check and before commit_tail clears vp->splice_mode_right, any
atomic commit (or DRM_MODE_ATOMIC_TEST_ONLY check) that switches VP0 out of=
 8K
splice mode and enables VP1 in the same transaction will be rejected by
vop2_crtc_mode_valid() with MODE_BAD (-EINVAL).

[ ... ]
> @@ -1984,21 +2319,100 @@ static int vop2_crtc_atomic_check(struct drm_crt=
c *crtc,
>  				  struct drm_atomic_commit *state)
>  {
>  	struct vop2_video_port *vp =3D to_vop2_video_port(crtc);
> +	struct vop2 *vop2 =3D vp->vop2;
> +	const struct vop2_video_port_data *vp_data =3D &vop2->data->vp[vp->id];
> +	struct drm_crtc_state *crtc_state =3D drm_atomic_get_new_crtc_state(sta=
te, crtc);
> +	struct rockchip_crtc_state *vcstate =3D to_rockchip_crtc_state(crtc_sta=
te);
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
> +	/* Check if left_vp is in use */
> +	if (crtc_state->enable && drm_atomic_crtc_needs_modeset(crtc_state)) {
> +		struct vop2_video_port *left_vp =3D vop2_find_left_splice_vp(vop2, vp-=
>id);
> +
> +		if (left_vp && left_vp->crtc.state) {
> +			struct drm_crtc_state *lstate, *lold;
> +
> +			lstate =3D drm_atomic_get_crtc_state(state, &left_vp->crtc);
> +			if (IS_ERR(lstate))
> +				return PTR_ERR(lstate);
> +
> +			lold =3D drm_atomic_get_old_crtc_state(state, &left_vp->crtc);
> +			if (to_rockchip_crtc_state(lold)->splice_mode) {
> +				drm_dbg_kms(vop2->drm, "vp%d is in use by vp%d in splice mode\n",
> +					    vp->id, left_vp->id);
> +				return -EBUSY;
> +			}
> +		}
> +	}

[Severity: High]
Can the splice conflict checks across vop2_plane_atomic_check() and
vop2_crtc_atomic_check() in drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
examine stale splice_mode state or miss plane conflicts?

There appear to be four related issues in these checks:

1. In drm_atomic_helper_check_planes(), all plane->atomic_check() callbacks
(vop2_plane_atomic_check()) run before any crtc->atomic_check() callbacks
(vop2_crtc_atomic_check()). Because vcstate->splice_mode is only updated in
vop2_crtc_atomic_check(), when vop2_plane_atomic_check() checks
to_rockchip_crtc_state(lcstate)->splice_mode, it reads the stale splice_mode
value duplicated from the previous commit rather than whether lstate->crtc =
uses
splice mode in the new commit.

2. In vop2_crtc_atomic_check() above, lstate is fetched via
drm_atomic_get_crtc_state(state, &left_vp->crtc) and left unused, while the
check inspects to_rockchip_crtc_state(lold)->splice_mode on the old CRTC st=
ate.
If userspace switches left_vp (VP0) from an 8K splice mode to a non-splice =
mode
(or disables VP0) and enables vp (VP1) in the same atomic commit, both
vop2_crtc_atomic_check() and vop2_plane_atomic_check() falsely reject the
commit with -EBUSY.

3. In vop2_plane_atomic_check(), the early return for invisible planes:

	if (!pstate->visible)
		return 0;

runs before vop2_plane_splice_check() and before the if (win->left_win) che=
ck.
A plane attached to a CRTC (pstate->crtc !=3D NULL) that is clipped off-scr=
een
(!pstate->visible) remains in crtc_state->plane_mask. During commit,
rk3568_vop2_setup_overlay() in drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
iterates over crtc->state->plane_mask via drm_atomic_crtc_for_each_plane() =
and
reassigns the window in RK3568_OVL_PORT_SEL, while vop2_plane_atomic_update=
()
calls vop2_plane_atomic_disable() -> vop2_win_disable(win) on the active ri=
ght
splice window.

4. Unlike vop2_crtc_atomic_check() (which checks both rstate->crtc and
old_rstate->crtc), vop2_plane_atomic_check() only checks if (lstate->crtc) =
and
does not check old_lstate->crtc. If win->left_win is disabled on an active
splice CRTC in the same commit that win is enabled on another CRTC,
vop2_crtc_atomic_begin() on the other CRTC can migrate win's
RK3568_OVL_PORT_SEL before win->left_win is disabled, and
vop2_plane_atomic_disable(win->left_win) will race with
vop2_plane_atomic_update(win) on the shared hardware window.

[ ... ]
> @@ -2018,6 +2432,7 @@ static void vop2_crtc_atomic_flush(struct drm_crtc =
*crtc,
>  	struct drm_crtc_state *old_crtc_state =3D drm_atomic_get_old_crtc_state=
(state, crtc);
>  	struct vop2_video_port *vp =3D to_vop2_video_port(crtc);
>  	struct vop2 *vop2 =3D vp->vop2;
> +	bool splice =3D false;
> =20
>  	/* In case of modeset, gamma lut update already happened in atomic enab=
le */
>  	if (!drm_atomic_crtc_needs_modeset(crtc_state) && crtc_state->color_mgm=
t_changed)
> @@ -2025,7 +2440,12 @@ static void vop2_crtc_atomic_flush(struct drm_crtc=
 *crtc,
> =20
>  	vop2_post_config(crtc, false, crtc_state, old_crtc_state);
> =20
> -	vop2_cfg_done(vp);
> +	/* When the splice_mode state changes, an update is also required */
> +	if (to_rockchip_crtc_state(crtc_state)->splice_mode ||
> +	    to_rockchip_crtc_state(old_crtc_state)->splice_mode)
> +		splice =3D true;
> +
> +	vop2_cfg_done(vp, splice);

[Severity: High]
What happens to RK3568_REG_CFG_DONE when disabling a spliced CRTC or
modesetting it from an 8K splice mode to a non-splice mode?

In vop2_crtc_atomic_disable() in drivers/gpu/drm/rockchip/rockchip_drm_vop2=
.c,
when old_vcstate->splice_mode is true, the function disables the right wind=
ows
via vop2_win_disable(win), disables the left windows via
drm_atomic_helper_disable_planes_on_crtc(old_crtc_state, false), and clears
RK3568_LUT_PORT_SEL__SPLICE_EN via vop2->ops->setup_splice(vp, false) before
writing RK3568_VP_DSP_CTRL__STANDBY, without calling vop2_cfg_done().

If the CRTC is being disabled (crtc_state->active =3D=3D false),
drm_atomic_helper_commit_planes() is called with DRM_PLANE_COMMIT_ACTIVE_ON=
LY,
so vop2_crtc_atomic_flush() is skipped and vop2_cfg_done() is never called =
to
latch the disabled windows.

Conversely, if the CRTC is modesetting from an 8K splice mode
(old_crtc_state->splice_mode =3D=3D true) to a non-splice mode
(crtc_state->splice_mode =3D=3D false, crtc_state->active =3D=3D true),
vop2_crtc_atomic_disable() has already cleared RK3568_LUT_PORT_SEL__SPLICE_=
EN
and splice_vp (VP1) remains in standby with no running dclk or vsync. When
vop2_crtc_atomic_flush() then sets splice =3D true because
to_rockchip_crtc_state(old_crtc_state)->splice_mode is true,
vop2_cfg_done(vp, true) sets BIT(splice_vp_id) in RK3568_REG_CFG_DONE. Beca=
use
SPLICE_EN is already 0 and splice_vp is in standby, BIT(splice_vp_id) in
RK3568_REG_CFG_DONE will never clear, causing subsequent layer updates in
rk3568_vop2_setup_layer_mixer() to see cfg_done & ~own_cfg_done_mask !=3D 0=
 and
busy-wait for 50 ms until timeout in rk3568_vop2_wait_for_layer_cfg_done().

[ ... ]
> @@ -2510,6 +2930,7 @@ static int vop2_create_crtcs(struct vop2 *vop2)
>  	struct device_node *port;
>  	struct vop2_video_port *vp;
>  	struct vop2_win *win;
> +	bool vp_used[ROCKCHIP_MAX_CRTC] =3D {};
>  	u32 possible_crtcs;
>  	int i, j, nvp, nvps =3D 0;
>  	int ret;
> @@ -2543,9 +2964,23 @@ static int vop2_create_crtcs(struct vop2 *vop2)
>  			return dev_err_probe(drm->dev, -ENOENT,
>  					     "no port node found for video_port%d\n", i);
>  		vp->crtc.port =3D port;
> -		nvps++;
> +		vp_used[i] =3D true;
>  	}
> =20
> +	/* reserved vp for 8K mode */
> +	for (i =3D 0; i < vop2_data->nr_vps; i++) {
> +		if (!(vop2_data->feature & VOP2_FEATURE_SPLICE) || !vp_used[i])
> +			continue;
> +		if (vop2->vps[i].data->max_output.width <=3D VOP2_MAX_VP_OUTPUT_WIDTH)
> +			continue;
> +
> +		vp_used[vop2->vps[i].data->splice_vp_id] =3D true;
> +	}
> +
> +	for (i =3D 0; i < vop2_data->nr_vps; i++)
> +		if (vp_used[i])
> +			nvps++;
> +
>  	nvp =3D 0;
>  	/* Register a primary plane for every crtc */
>  	for (i =3D 0; i < vop2_data->nr_vps; i++) {

[Severity: High]
In vop2_create_crtcs() in drivers/gpu/drm/rockchip/rockchip_drm_vop2.c, what
happens on RK3588 boards where VP0 and VP2 (or VP3) are enabled in device t=
ree
while VP1 is unconnected?

The loop above marks vp_used[1] =3D true for VP1 (splice_vp_id =3D 1), but
vp1->crtc.port remains NULL when VP1 has no DT remote node. In the primary
plane registration loop immediately following:

	for (i =3D 0; i < vop2_data->nr_vps; i++) {
		vp =3D &vop2->vps[i];

		if (!vp->crtc.port)
			continue;

		for (j =3D 0; j < vop2->registered_num_wins; j++) {
			win =3D &vop2->win[j];

VP0 (i =3D 0) gets Cluster0-win0 as its primary plane, VP1 (i =3D 1) is ski=
pped
because !vp->crtc.port, and then VP2 (i =3D 2) or VP3 (i =3D 3) is assigned=
 the
next unregistered DRM_PLANE_TYPE_PRIMARY window, which is Cluster1-win0
(Cluster0-win0's splice_win), with possible_crtcs restricted exclusively to
that CRTC, while Cluster2-win0 becomes an overlay plane.

Because Cluster1-win0 is the right splice partner of VP0's primary plane
Cluster0-win0, won't this make 8K splice mode on VP0 and normal display out=
put
on VP2/VP3 mutually exclusive (-EBUSY) on boards with unconnected VP1?

[ ... ]
> diff --git a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c b/drivers/gpu/d=
rm/rockchip/rockchip_vop2_reg.c
> index c44648e1bc0d6..08f9f8cac8789 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
[ ... ]
> @@ -2286,7 +2331,7 @@ static void rk3568_vop2_setup_layer_mixer(struct vo=
p2_video_port *vp)
>  	if (layer_sel !=3D vop2->old_layer_sel && atv_layer_sel !=3D vop2->old_=
layer_sel) {
>  		cfg_done =3D vop2_readl(vop2, RK3568_REG_CFG_DONE);
>  		cfg_done &=3D (BIT(vop2->data->nr_vps) - 1);
> -		cfg_done &=3D ~BIT(vp->id);
> +		cfg_done &=3D ~own_cfg_done_mask;
>  		/*
>  		 * Changes of other VPs' overlays have not taken effect
>  		 */
> @@ -2295,13 +2340,13 @@ static void rk3568_vop2_setup_layer_mixer(struct =
vop2_video_port *vp)
>  	}
> =20
>  	if (layer_sel !=3D vop2->old_layer_sel || port_sel !=3D vop2->old_port_=
sel)
> -		ovl_ctrl |=3D FIELD_PREP(RK3568_OVL_CTRL__LAYERSEL_REGDONE_SEL, vp->id=
);
> +		ovl_ctrl |=3D FIELD_PREP(RK3568_OVL_CTRL__LAYERSEL_REGDONE_SEL, main_v=
p->id);
>  	vop2_writel(vop2, RK3568_OVL_CTRL, ovl_ctrl);
> =20
>  	if (port_sel !=3D vop2->old_port_sel) {
>  		vop2->old_port_sel =3D port_sel;
>  		vop2_writel(vop2, RK3568_OVL_PORT_SEL, port_sel);
> -		vop2_cfg_done(vp);
> +		vop2_cfg_done(main_vp, vcstate->splice_mode);
>  		rk3568_vop2_wait_for_port_mux_done(vop2);
>  	}
[ ... ]
> @@ -2354,33 +2399,59 @@ static void rk3568_vop2_setup_dly_for_windows(str=
uct vop2_video_port *vp)
[ ... ]
> +static void rk3568_vop2_setup_overlay(struct vop2_video_port *vp)
> +{
> +	struct rockchip_crtc_state *vcstate =3D to_rockchip_crtc_state(vp->crtc=
.state);
> +	struct vop2_video_port *splice_vp =3D NULL;
> +	struct drm_plane *plane;
> +
> +	vp->win_mask =3D 0;
> +	if (vcstate->splice_mode) {
> +		splice_vp =3D vop2_get_splice_vp(vp);
> +		splice_vp->win_mask =3D 0;
> +	}
> +
> +	/* The right video port shares the plane state of the left one */
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
Does calling rk3568_vop2_setup_overlay_for_vp(vp) followed immediately by
rk3568_vop2_setup_overlay_for_vp(splice_vp) in rk3568_vop2_setup_overlay() =
in
drivers/gpu/drm/rockchip/rockchip_vop2_reg.c cause a 50 ms busy-wait timeou=
t in
rk3568_vop2_setup_layer_mixer()?

During vop2_crtc_atomic_begin(), the first call to
rk3568_vop2_setup_layer_mixer(vp) updates vop2->old_layer_sel =3D layer_sel=
 and
writes the shadowed register RK3568_OVL_LAYER_SEL. Because vop2_cfg_done() =
is
not called until vop2_crtc_atomic_flush(), reading RK3568_OVL_LAYER_SEL sti=
ll
returns the pre-commit active hardware value.

In the immediate second call to rk3568_vop2_setup_layer_mixer(splice_vp):

1. atv_layer_sel =3D vop2_readl(vop2, RK3568_OVL_LAYER_SEL) still equals th=
e old
hardware value, so atv_layer_sel !=3D vop2->old_layer_sel is true, and
layer_sel !=3D vop2->old_layer_sel is also true when splice_vp updates its
right-half layers. If any other video port (such as VP2 or VP3) has a pendi=
ng
CFG_DONE bit in RK3568_REG_CFG_DONE, rk3568_vop2_setup_layer_mixer(splice_v=
p)
calls rk3568_vop2_wait_for_layer_cfg_done(vop2), which busy-polls for
vop2_readl(vop2, RK3568_OVL_LAYER_SEL) =3D=3D vop2->old_layer_sel. Because
RK3568_OVL_CTRL__LAYERSEL_REGDONE_SEL was set to main_vp->id by the first c=
all
and vop2_cfg_done(main_vp, ...) has not been called yet, vop2->old_layer_sel
cannot latch during vop2_crtc_atomic_begin(), guaranteeing a 50 ms spin
timeout.

2. If port_sel !=3D vop2->old_port_sel in the second call
rk3568_vop2_setup_layer_mixer(splice_vp), it calls
vop2_cfg_done(main_vp, vcstate->splice_mode) and waits for vsync in
rk3568_vop2_wait_for_port_mux_done(vop2), which latches the first call's
left-half RK3568_OVL_LAYER_SEL a frame early before splice_vp's
RK3568_OVL_LAYER_SEL and window registers have been programmed.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029081429.862-=
1-kernel@airkyi.com?part=3D3
