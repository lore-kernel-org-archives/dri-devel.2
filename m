Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E42E606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 07:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c6Y01sRU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20C2F10E175;
	Thu, 26 Nov 2026 07:02:48 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9209D10E39F
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 07:02:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D9FB960534;
 Thu, 26 Nov 2026 07:02:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B0BD1F000CA;
 Thu, 26 Nov 2026 07:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795676560;
 bh=97aOVqTzdxE1kbneZwzLi/QGKVPMl2LqhgNK0TFzMQc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=c6Y01sRUZ+NCB3/ewm+vKsaer/LOlFFcx4SLjS5K/56PN0r2exLnPOYVWyNiuE/Xu
 2Lv6zFdymKT1TIU3LBFEsANLoHmqEOw1lg7PWU6S2AoEUsBOsUcwO77wKXWEMM3z0j
 /lazakkKnaLUReXBGBmOQDiDW9753+iWGw6X5R/99KIgBuw2cm2ffR6/A84WbCNIuR
 XEcAHmL0nOiqKfcanPb1W/5jtI40gu5HUEFB9AyeXuWqs6YE62CN9McwjLiCH7SDtZ
 OHaHerPr75L0cHMzna3KwDrStzHDeETePcdQhVsE2kiOSd0M8gc4FC2UK8WvzngN+I
 2Pl1LSlSCP0tQ==
Message-ID: <sashiko-outbox-234923@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 11/21] drm/msm/dcp: Add DCP planes
To: "Jayant Shekhar" <jayant.shekhar@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org, media-ci@linuxtv.org
In-Reply-To: <20261126-jshekhar-v3-dcp-v3-11-f1e9d7505039@oss.qualcomm.com>
References: <20261126-jshekhar-v3-dcp-v3-0-f1e9d7505039@oss.qualcomm.com>
 <20261126-jshekhar-v3-dcp-v3-11-f1e9d7505039@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 07:02:38 +0000
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

Thank you for your contribution! Sashiko AI review found 13 potential
issues to consider:
- [High] drm/msm/dcp: broken HFI pipe detach lifecycle in
  dcp_plane_atomic_update()
- [High] drm/msm/dcp: stale plane visibility in dcp_plane_atomic_check()
- [High] drm/msm/dcp: missing or misordered HFI detach on pipe
  reassignment
- [High] drm/msm/dcp: unlocked plane->state access in
  dcp_plane_pipe_busy()
- [High] drm/msm/dcp: 90/270-degree rotation ignored in scaling and perf
  checks
- [High] drm/msm/dcp: divide-by-zero in dcp_plane_calc_bw() on zero
  vblank
- [High] drm/msm/dcp: missing dcp_plane_state.h include in
  dcp_crtc_aggregate_bw()
- [Medium] drm/msm/dcp: NULL return in dcp_plane_atomic_create_state()
  and missing format copy
- [Medium] drm/msm/dcp: stale bandwidth vote when planes hide in
  dcp_crtc_atomic_begin()
- [Medium] drm/msm/dcp: chroma planes omitted in dcp_plane_calc_perf()
  bpp
- [Medium] drm/msm/dcp: missing minimum source size check for RGB in
  dcp_plane_atomic_check()
- [Medium] drm/msm/dcp: broken IS_ERR() and NULL checks in
  dcp_plane_atomic_check()
- [Medium] drm/msm/dcp: non-alpha formats not forced to opaque blend in
  dcp_plane
--

commit 43ca0df7f906b25d403e77023334a1fac27d3027
Author: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>

drm/msm/dcp: Add DCP planes

This commit adds DRM plane support for the DCP display pipeline, including
format and scaling validation, HFI pipe assignment, bandwidth calculation,
and HFI property packet updates.

> diff --git a/drivers/gpu/drm/msm/dcp/dcp_crtc.c b/drivers/gpu/drm/msm/dcp=
/dcp_crtc.c
> index 512da8c4ddbcb..f58667ca458e9 100644
> --- a/drivers/gpu/drm/msm/dcp/dcp_crtc.c
> +++ b/drivers/gpu/drm/msm/dcp/dcp_crtc.c
> @@ -84,6 +84,36 @@ dcp_crtc_atomic_create_state(struct drm_crtc *crtc)
>  	return &cstate->base;
>  }
> =20
> +static void dcp_crtc_aggregate_bw(struct drm_crtc_state *crtc_state,
> +				  bool enable)
> +{
> +	struct dcp_crtc_state *cstate =3D to_dcp_crtc_state(crtc_state);
> +	struct drm_plane *plane;
> +	const struct drm_plane_state *pstate;
> +
> +	cstate->dram_ib  =3D 0;
> +	cstate->dram_ab  =3D 0;
> +	cstate->llcc_ib  =3D 0;
> +	cstate->llcc_ab  =3D 0;
> +	cstate->core_clk =3D 0;
> +
> +	if (!enable)
> +		return;
> +
> +	drm_atomic_crtc_state_for_each_plane_state(plane, pstate, crtc_state) {
> +		if (!pstate->visible)
> +			continue;
> +
> +		const struct dcp_plane_state *dcp_pstate =3D to_dcp_plane_state(pstate=
);
> +
> +		cstate->dram_ib  =3D max(cstate->dram_ib, dcp_pstate->fetch_bw);
> +		cstate->dram_ab +=3D dcp_pstate->fetch_bw;
> +		cstate->llcc_ib  =3D max(cstate->llcc_ib, dcp_pstate->fetch_bw);
> +		cstate->llcc_ab +=3D dcp_pstate->fetch_bw;
> +		cstate->core_clk =3D max(cstate->core_clk, dcp_pstate->clk);
> +	}
> +}

[Severity: High]
Does dcp_crtc.c fail to build here without including dcp_plane_state.h?
dcp_crtc_aggregate_bw() calls to_dcp_plane_state() and dereferences struct
dcp_plane_state, which are defined in dcp_plane_state.h, but that header is
only included in the later commit "drm/msm/dcp: Integrate the DSI bridge
with KMS".

[ ... ]

> @@ -538,6 +571,8 @@ static int dcp_crtc_atomic_check(struct drm_crtc *crt=
c,
>  		return -E2BIG;
>  	}
> =20
> +	dcp_crtc_aggregate_bw(crtc_state, true);
> +
>  	return 0;
>  }

[Severity: Medium]
Does disabling or clipping all planes on an active CRTC leave stale
bandwidth and clock votes pinned in firmware?

When no visible planes remain, dcp_crtc_aggregate_bw() zeroes dram_ib,
dram_ab, llcc_ib, llcc_ab, and core_clk, but dcp_crtc_atomic_begin() skips
updating the firmware vote when those fields reach zero:

drivers/gpu/drm/msm/dcp/dcp_crtc.c:dcp_crtc_atomic_begin() {
    ...
	if (cstate->core_clk > 0 || cstate->dram_ib > 0) {
		ret =3D dcp_hfi_crtc_set_bw(dcp_kms->hfi, session_id,
					  cstate->dram_ib,  cstate->dram_ab,
					  cstate->llcc_ib,  cstate->llcc_ab,
					  cstate->core_clk);
    ...
}

Conversely, when at least one plane is visible, dcp_crtc_atomic_begin()
resends dcp_hfi_crtc_set_bw() on every frame even when the aggregated votes
have not changed.

> diff --git a/drivers/gpu/drm/msm/dcp/dcp_plane.c b/drivers/gpu/drm/msm/dc=
p/dcp_plane.c
> new file mode 100644
> index 0000000000000..ff6ce28d61c8b
> --- /dev/null
> +++ b/drivers/gpu/drm/msm/dcp/dcp_plane.c

[ ... ]

> +static bool dcp_plane_pipe_busy(struct drm_atomic_commit *state,
> +				struct drm_plane *self, u32 pipe_id)
> +{
> +	struct drm_plane *plane;
> +	struct drm_plane_state *plane_state;
> +	struct drm_plane *iter_plane;
> +	struct drm_plane_state *new_plane_state;
> +	int i;
> +
> +	drm_for_each_plane(plane, state->dev) {
> +		if (plane =3D=3D self)
> +			continue;
> +
> +		plane_state =3D plane->state;
> +		for_each_new_plane_in_state(state, iter_plane, new_plane_state, i) {
> +			if (iter_plane =3D=3D plane) {
> +				plane_state =3D new_plane_state;
> +				break;
> +			}
> +		}
> +
> +		if (plane_state && plane_state->crtc && plane_state->visible &&
> +		    to_dcp_plane_state(plane_state)->hfi_pipe_id =3D=3D pipe_id)
> +			return true;
> +	}
> +
> +	return false;
> +}

[Severity: High]
Can dcp_plane_pipe_busy() trigger a use-after-free on plane->state or assign
the same HFI pipe to two planes during concurrent commits across CRTCs?

An atomic commit on CRTC 0 does not hold plane->mutex for planes bound to
CRTC 1 that are not part of state:

CPU0 (commit on CRTC 0)           CPU1 (commit on CRTC 1)
dcp_plane_atomic_check()
  dcp_plane_assign_pipe()
    dcp_plane_pipe_busy()
      plane_state =3D plane->state
                                  drm_atomic_helper_swap_state()
                                  ...
                                  dcp_plane_atomic_destroy_state()
                                    kfree(old_pstate)
      plane_state->visible
        <-- use-after-free

Even without a free, nothing serializes pipe allocation across CRTCs, so two
concurrent atomic checks can both see the same pipe_id as free in
dcp_plane_pipe_busy() and assign it to two active planes.

[ ... ]

> +static u64 dcp_plane_calc_bw(u32 bpp,
> +			     const struct drm_display_mode *mode,
> +			     const struct drm_rect *src,
> +			     const struct drm_rect *dst)
> +{
> +	int src_w =3D drm_rect_width(src) >> 16;
> +	int src_h =3D drm_rect_height(src) >> 16;
> +	int dst_h =3D drm_rect_height(dst);
> +	int fps   =3D drm_mode_vrefresh(mode);
> +	int vbp   =3D mode->vtotal - mode->vsync_end;
> +	int vpw   =3D mode->vsync_end - mode->vsync_start;
> +	int vfp   =3D mode->vsync_start - mode->vdisplay;
> +	u32 hw_latency =3D 25;
> +	u64 scale_factor =3D (src_h > dst_h) ? mult_frac(src_h, 1, dst_h) : 1;
> +	u64 plane_bw, prefill_bw;
> +
> +	plane_bw =3D (u64)src_w * mode->vtotal * fps * bpp * scale_factor;
> +	prefill_bw =3D plane_bw * hw_latency;
> +
> +	if ((vbp + vpw) > hw_latency)
> +		do_div(prefill_bw, (vbp + vpw));
> +	else if ((vbp + vpw + vfp) < hw_latency)
> +		do_div(prefill_bw, (vbp + vpw + vfp));
> +	else
> +		do_div(prefill_bw, hw_latency);
> +
> +	/* HFI DRAM/LLCC votes are expressed in Kbps. */
> +	return div_u64(max(plane_bw, prefill_bw), 1000);
> +}

[Severity: High]
Can do_div(prefill_bw, (vbp + vpw + vfp)) divide by zero when a mode has
zero vertical blanking?

Both drm_mode_validate_basic() and dcp_crtc_mode_valid() allow a mode where
vdisplay =3D=3D vsync_start =3D=3D vsync_end =3D=3D vtotal, which makes vbp=
 + vpw + vfp
equal to 0 and hits the else-if branch.  Also, computing scale_factor as
mult_frac(src_h, 1, dst_h) before multiplying plane_bw truncates fractional
vertical downscaling to an integer.

[ ... ]

> +void dcp_plane_calc_perf(const struct drm_plane_state *state,
> +			 const struct drm_display_mode *mode,
> +			 struct dcp_plane_perf *perf)
> +{
> +	struct drm_rect src, dst;
> +	u32 bpp;
> +
> +	memset(perf, 0, sizeof(*perf));
> +
> +	if (!state || !state->visible || !state->fb || !mode || !mode->clock ||
> +	    !drm_mode_vrefresh(mode))
> +		return;
> +
> +	src =3D drm_plane_state_src(state);
> +	dst =3D drm_plane_state_dest(state);
> +	bpp =3D drm_format_info_bpp(state->fb->format, 0);
> +
> +	perf->fetch_bw =3D dcp_plane_calc_bw(bpp, mode, &src, &dst);
> +	perf->clk =3D dcp_plane_calc_clk(mode, &src, &dst);
> +}

[Severity: Medium]
Does calling drm_format_info_bpp(state->fb->format, 0) omit the chroma
planes for multi-planar YUV formats?  For NV12, NV21, P010, YUV420, and
YVU420, plane 0 only accounts for the luma plane, under-calculating
fetch_bw by a third (and drm_format_info_bpp() returns bits per pixel
rather than bytes per pixel).

[ ... ]

> +static int dcp_plane_build_one_hfi_props_packet(struct dcp_plane_state *=
pstate,
> +						const struct drm_plane_state *state,
> +						u32 session_id, u32 packet_id,
> +						u8 *packet)
> +{
> +	struct drm_framebuffer *fb =3D state->fb;

[ ... ]

> +	hfi_rotation =3D dcp_drm_to_hfi_rotation(state->rotation);
> +	hfi_blend_op =3D dcp_drm_to_hfi_blend_op(state->pixel_blend_mode);
> +
> +	src_x =3D state->src_x >> 16;
> +	src_y =3D state->src_y >> 16;
> +	src_w =3D state->src_w >> 16;
> +	src_h =3D state->src_h >> 16;
> +	dst_x =3D state->crtc_x;
> +	dst_y =3D state->crtc_y;
> +	dst_w =3D state->crtc_w;
> +	dst_h =3D state->crtc_h;
> +
> +	hfi_alpha =3D dcp_hfi_scale_alpha(state, state->alpha);
> +	hfi_bg_alpha =3D dcp_hfi_scale_alpha(state,
> +					   dcp_compute_bg_alpha(state->pixel_blend_mode,
> +								state->alpha));

[Severity: Medium]
Should planes whose framebuffer format lacks an alpha channel
(!fb->format->has_alpha) fall back to DRM_MODE_BLEND_PIXEL_NONE?  Without
that check, formats such as XRGB8888, RGB565, NV12, and P010 use the default
DRM_MODE_BLEND_PREMULTI mode and program HFI_BLEND_OP_PREMULTIPLIED with
bg_alpha =3D 0 (when alpha is opaque) instead of HFI_BLEND_OP_OPAQUE.

[ ... ]

> +static int dcp_plane_atomic_check(struct drm_plane *plane,
> +				  struct drm_atomic_commit *state)
> +{

[ ... ]

> +	if (!new_state->crtc)
> +		return 0;
> +
> +	crtc_state =3D drm_atomic_get_new_crtc_state(state, new_state->crtc);
> +	if (IS_ERR(crtc_state)) {
> +		ret =3D PTR_ERR(crtc_state);
> +		drm_err(plane->dev, "plane%u: failed to get CRTC state: %d\n",
> +			plane->base.id, ret);
> +		return ret;
> +	}

[Severity: Medium]
drm_atomic_get_new_crtc_state() returns NULL, not an ERR_PTR, when the CRTC
is not in state, so IS_ERR(crtc_state) will not catch a NULL crtc_state
before drm_atomic_helper_check_plane_state() dereferences it.  Similarly,
in dcp_plane_assign_pipe(), dcp_plane_hfi_pipe_valid() checks
!dcp_kms->caps, but dcp_plane_assign_pipe() then dereferences caps
unconditionally.

> +
> +	if (!new_state->fb)
> +		return 0;

[Severity: High]
Does returning early on !new_state->crtc or !new_state->fb leave
new_state->visible set to true when a visible plane is disabled?

dcp_plane_atomic_duplicate_state() copies visible =3D true from the old
state, and returning before drm_atomic_helper_check_plane_state() leaves
new_state->visible true.  drm_atomic_plane_disabling() then evaluates to
false in drm_atomic_helper_commit_planes(), so neither
dcp_plane_atomic_disable() nor dcp_plane_atomic_update() runs, leaving the
HFI pipe attached in firmware scanning out old_state->fb after
dcp_plane_cleanup_fb() unpins its IOVA.

In addition, calling dcp_plane_assign_pipe() before
drm_atomic_helper_check_plane_state() causes dcp_plane_pipe_busy() to read
stale visible flags on higher-indexed planes in the same commit that have
not been checked yet, and assigns an HFI pipe even when the current plane
is about to be clipped to invisible.

> +
> +	scaling =3D new_state->src_w !=3D ((u32)new_state->crtc_w << 16) ||
> +			  new_state->src_h !=3D ((u32)new_state->crtc_h << 16);
> +
> +	pstate->hfi_pipe_id =3D dcp_plane_assign_pipe(dcp_kms, state, plane,
> +						    pstate, new_state->fb->format->is_yuv,
> +						    scaling);
> +	if (pstate->hfi_pipe_id =3D=3D U32_MAX) {
> +		drm_err(plane->dev, "plane%u: no compatible HFI pipe available\n",
> +			plane->base.id);
> +		return -ENOSPC;
> +	}
> +
> +	if (dcp_plane_pipe_is_vig(dcp_kms->caps, pstate->hfi_pipe_id)) {
> +		min_scale =3D FRAC_16_16(1, DCP_MAX_UPSCALE_RATIO);
> +		max_scale =3D DCP_MAX_DOWNSCALE_RATIO << 16;
> +	}
> +
> +	ret =3D drm_atomic_helper_check_plane_state(new_state, crtc_state,
> +						  min_scale, max_scale,
> +						  true, true);

[Severity: High]
Does checking scaling before rotating the source rectangle break 90- and
270-degree rotated planes?

When DRM_MODE_ROTATE_90 or DRM_MODE_ROTATE_270 is set on a non-square
plane, drm_atomic_helper_check_plane_state() swaps the source width and
height via drm_rect_rotate() before checking hscale and vscale.  Because
scaling is computed here from the unrotated src_w and src_h, an unscaled
90/270-degree plane is treated as scaled and forced onto a VIG pipe, while
a scaled 90/270-degree plane with src_w =3D=3D crtc_w << 16 and
src_h =3D=3D crtc_h << 16 can be assigned a DMA pipe where
DRM_PLANE_NO_SCALING causes drm_atomic_helper_check_plane_state() to fail
with -ERANGE.  dcp_plane_calc_perf() likewise passes the unrotated source
rectangle to dcp_plane_calc_bw() and dcp_plane_calc_clk().

[ ... ]

> +	if (new_state->fb->format->is_yuv) {
> +		u32 src_x =3D src.x1 >> 16;
> +		u32 src_y =3D src.y1 >> 16;
> +		u32 src_w =3D drm_rect_width(&src) >> 16;
> +		u32 src_h =3D drm_rect_height(&src) >> 16;
> +
> +		if (src_w < 2 || src_h < 2) {
> +			drm_err(plane->dev,
> +				"plane%u: YUV source too small: %ux%u\n",
> +				plane->base.id, src_w, src_h);
> +			return -EINVAL;
> +		}

[Severity: Medium]
Should non-YUV planes also reject source dimensions smaller than 1 pixel
((drm_rect_width(&src) >> 16) < 1 || (drm_rect_height(&src) >> 16) < 1)?
On a VIG pipe with min_scale =3D FRAC_16_16(1, 20), sub-pixel 16.16 source
dimensions pass drm_atomic_helper_check_plane_state() and then truncate to
0 when shifted right by 16 in dcp_plane_calc_bw() and
dcp_plane_build_one_hfi_props_packet().

[ ... ]

> +static void dcp_plane_atomic_update(struct drm_plane *plane,
> +				    struct drm_atomic_commit *state)
> +{
> +	struct drm_plane_state *new_state =3D
> +		drm_atomic_get_new_plane_state(state, plane);
> +	struct dcp_plane_state *pstate =3D to_dcp_plane_state(new_state);
> +	int ret;
> +
> +	drm_dbg_driver(plane->dev,
> +		       "plane%u: atomic_update visible=3D%d fb=3D%u pipe_id=3D%u\n",
> +		       plane->base.id, new_state->visible,
> +		       new_state->fb ? new_state->fb->base.id : 0,
> +		       pstate->hfi_pipe_id);
> +
> +	pstate->prop_pkt_size =3D 0;
> +
> +	if (!new_state->visible || !new_state->fb)
> +		return;
> +
> +	ret =3D dcp_plane_submit_update(plane, new_state);
> +	if (ret) {
> +		drm_err(plane->dev,
> +			"plane%u: HFI update failed: %d\n", plane->base.id, ret);
> +		dcp_plane_set_hfi_error(new_state, ret);
> +		return;
> +	}
> +}

[Severity: High]
When a visible plane is moved off-screen while remaining bound to its CRTC
and framebuffer, does returning early on !new_state->visible leave the HFI
pipe attached in firmware?

In drm_atomic_helper_commit_planes(), drm_atomic_plane_disabling() only
checks old_plane_state->crtc && !new_plane_state->crtc, so a plane that
becomes invisible with new_state->crtc !=3D NULL calls
dcp_plane_atomic_update() rather than dcp_plane_atomic_disable().  Because
dcp_plane_atomic_update() returns without detaching old_state's pipe, the
firmware continues scanning out old_state->fb after dcp_plane_cleanup_fb()
unpins its IOVA; and because dcp_plane_pipe_busy() treats invisible planes'
pipes as free, another plane can claim that pipe while the invisible plane
later detaches it in dcp_plane_atomic_disable().

> +
> +static void dcp_plane_atomic_disable(struct drm_plane *plane,
> +				     struct drm_atomic_commit *state)
> +{
> +	struct drm_plane_state *old_state =3D
> +		drm_atomic_get_old_plane_state(state, plane);
> +	struct dcp_plane_state *pstate =3D to_dcp_plane_state(old_state);
> +	int ret;
> +
> +	drm_dbg_driver(plane->dev,
> +		       "plane%u: atomic_disable pipe_id=3D%u\n",
> +		       plane->base.id, pstate->hfi_pipe_id);
> +
> +	ret =3D dcp_plane_submit_disable(plane, old_state);
> +	if (ret) {
> +		drm_err(plane->dev,
> +			"plane%u: HFI detach failed: %d\n", plane->base.id, ret);
> +		dcp_plane_set_hfi_error(old_state, ret);
> +	}
> +
> +	pstate->prop_pkt_size =3D 0;
> +	pstate->prop_pkt_id =3D 0;
> +}

[Severity: High]
What happens to the old or reassigned HFI pipe when dcp_plane_assign_pipe()
changes a plane's hfi_pipe_id or reassigns a pipe between planes in the
same commit?

If an active visible plane switches from a DMA pipe to a VIG pipe (for
example, changing from unscaled RGB to YUV or scaled),
dcp_plane_atomic_update() attaches the new pipe_id but never detaches
old_state's hfi_pipe_id.  Conversely, if a higher-indexed plane is disabled
in the same commit in which a lower-indexed plane claims its pipe_id,
drm_atomic_helper_commit_planes() runs the lower-indexed plane's
dcp_plane_atomic_update() first and the higher-indexed plane's
dcp_plane_atomic_disable() second, detaching the pipe that was just
attached.

> +
> +static struct drm_plane_state *
> +dcp_plane_atomic_duplicate_state(struct drm_plane *plane)
> +{
> +	struct dcp_plane_state *pstate, *old_pstate;
> +
> +	if (WARN_ON(!plane->state))
> +		return NULL;
> +
> +	old_pstate =3D to_dcp_plane_state(plane->state);
> +	pstate =3D kzalloc_obj(*pstate, GFP_KERNEL);
> +	if (!pstate)
> +		return NULL;
> +
> +	__drm_atomic_helper_plane_duplicate_state(plane, &pstate->base);
> +	pstate->hfi_pipe_id     =3D old_pstate->hfi_pipe_id;
> +	pstate->src_img_w       =3D old_pstate->src_img_w;
> +	pstate->src_img_h       =3D old_pstate->src_img_h;
> +	pstate->fetch_bw       =3D old_pstate->fetch_bw;
> +	pstate->clk            =3D old_pstate->clk;
> +	pstate->needs_dirtyfb  =3D old_pstate->needs_dirtyfb;
> +	pstate->prop_pkt_size   =3D 0;
> +	pstate->prop_pkt_id     =3D old_pstate->prop_pkt_id;
> +
> +	return &pstate->base;
> +}
> +
> +static void dcp_plane_atomic_destroy_state(struct drm_plane *plane,
> +					   struct drm_plane_state *state)
> +{
> +	__drm_atomic_helper_plane_destroy_state(state);
> +	kfree(to_dcp_plane_state(state));
> +}
> +
> +static struct drm_plane_state *
> +dcp_plane_atomic_create_state(struct drm_plane *plane)
> +{
> +	struct dcp_plane_state *pstate;
> +	u32 hfi_pipe_id =3D to_dcp_plane(plane)->hfi_pipe_id;
> +
> +	pstate =3D kzalloc_obj(*pstate, GFP_KERNEL);
> +	if (!pstate)
> +		return NULL;

[Severity: Medium]
Should dcp_plane_atomic_create_state() return ERR_PTR(-ENOMEM) instead of
NULL on allocation failure?  Its caller drm_mode_config_plane_create_state()
checks IS_ERR(plane_state), so a NULL return is treated as success and
leaves plane->state NULL.  Also, dcp_plane_atomic_duplicate_state() above
copies the other dcp_plane_state fields from old_pstate but omits
old_pstate->hfi_format.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126-jshekhar-v=
3-dcp-v3-0-f1e9d7505039@oss.qualcomm.com?part=3D11
