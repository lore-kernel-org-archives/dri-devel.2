Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3308606A320
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 13:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E2gmDuNy
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3048E112A75;
	Fri, 20 Nov 2026 13:28:44 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF7FD112444
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 13:28:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A63E061DEF
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 13:28:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C88131F000D0;
 Fri, 20 Nov 2026 13:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795181315;
 bh=TnmDuJNrgpJmkdzCgKGHx9ur9BAjlg/cNVyCD+thscE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=E2gmDuNytDxRZB1KdlxzWy0WMHA9h57Wnnc7K/J2VwNucIWTH6MKN0ra7dOW8+fsQ
 BAlxBDnBin//x5ajBolcsikr3B9/gX4LXs2hE/CtYzarvgiS96DAMid6LgQVRzWxEz
 b8WMryphVvqG6sFNRrNVk3ABPdVyRZtIyPAB8tntbq8N1H7lTLvVCQcNAkoTN7vBsd
 +y2cCPI2eVxAJJpXU60PhqNE9Mpoa/1PvdcAfwzm5Cmou7Co7UeIj2ncwK7ihmKYLv
 mLoTqYSKqoy69B5o6jXYUHI1LhnzjSxfCY/16Pj4y+RRit7QzWQDh43e3RQFOpGrh/
 F2ApgySCLaaiw==
Message-ID: <sashiko-outbox-225240@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 35/42] drm/tidss: plane: Implement hardware state
 readout
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261120-drm-state-readout-v9-35-a67c2b45b8ec@kernel.org>
References: <20261120-drm-state-readout-v9-0-a67c2b45b8ec@kernel.org>
 <20261120-drm-state-readout-v9-35-a67c2b45b8ec@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 13:28:35 +0000
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
- [High] drm/tidss: build failure from calling dispc readout helpers
  before definition
- [Medium] drm/tidss: plane readout miscalculates pitch and height on
  vertical decimation
- [Medium] drm/tidss: unhandled NULL crtc_state in
  tidss_plane_atomic_readout_state()
- [Medium] drm/tidss: false state mismatch in
  tidss_plane_atomic_readout_state()
--

commit 06a115c7e84f276955999ca7175b2ba65fbac981
Author: Maxime Ripard <mripard@kernel.org>

drm/tidss: plane: Implement hardware state readout

This commit implements the atomic_sro_readout_state and
atomic_sro_compare_state hooks for tidss planes to reconstruct plane and
framebuffer state from the hardware registers.

> diff --git a/drivers/gpu/drm/tidss/tidss_plane.c b/drivers/gpu/drm/tidss/=
tidss_plane.c
> index b0d5d6959b885..88f415b5439f4 100644
> --- a/drivers/gpu/drm/tidss/tidss_plane.c
> +++ b/drivers/gpu/drm/tidss/tidss_plane.c
[ ... ]
> @@ -176,11 +179,232 @@ static const struct drm_plane_helper_funcs tidss_p=
rimary_plane_helper_funcs =3D {
>  	.get_scanout_buffer =3D drm_fb_dma_get_scanout_buffer,
>  };
> =20
> +static const struct drm_framebuffer_funcs tidss_plane_readout_fb_funcs =
=3D {
> +	.destroy	=3D drm_gem_fb_destroy,
> +};
> +
> +static struct drm_framebuffer *tidss_plane_readout_fb(struct drm_plane *=
plane)
> +{
> +	struct drm_device *ddev =3D plane->dev;
> +	struct tidss_device *tidss =3D to_tidss(ddev);
> +	struct dispc_device *dispc =3D tidss->dispc;
> +	struct tidss_plane *tplane =3D to_tidss_plane(plane);
> +	const struct drm_format_info *info;
> +	struct drm_framebuffer *fb;
> +	int ret;
> +
> +	fb =3D kzalloc_obj(*fb);
> +	if (!fb)
> +		return ERR_PTR(-ENOMEM);
> +
> +	fb->dev =3D plane->dev;
> +
> +	info =3D dispc_plane_get_current_format(dispc, tplane->hw_plane_id);

[Severity: High]
Does this fail to build at this commit in the series?

tidss_plane_readout_fb(), tidss_plane_readout_crtc(), and
tidss_plane_atomic_readout_state() call dispc_plane_get_current_format(),
dispc_plane_get_picture_size(), dispc_plane_get_pixel_inc(),
dispc_plane_get_row_inc(), dispc_ovr_get_plane(),
dispc_plane_is_enabled(), dispc_plane_get_size(),
dispc_plane_get_global_alpha(), and dispc_plane_get_blend_mode(), which
are only declared and defined in the subsequent commit "drm/tidss: dispc:
Add hardware state readout helpers".  Reordering that patch before this
one would keep the series bisectable.

[ ... ]

> +	/*
> +	 * A pixel increment of 1 means that the DMA engine fetches every
> +	 * pixel of the source buffer. Any other value means that
> +	 * horizontal decimation is enabled, and the buffer geometry
> +	 * cannot be reconstructed from the registers.
> +	 */
> +	if (dispc_plane_get_pixel_inc(dispc, tplane->hw_plane_id) !=3D 1) {
> +		ret =3D -EINVAL;
> +		goto err_free_fb;
> +	}
> +
> +	/*
> +	 * The row increment register holds the extra bytes between the
> +	 * end of a row of the picture and the beginning of the next one,
> +	 * which includes any padding the firmware might have programmed.
> +	 */
> +	fb->pitches[0] =3D fb->width * (drm_format_info_bpp(info, 0) / 8) +
> +			 dispc_plane_get_row_inc(dispc, tplane->hw_plane_id) - 1;

[Severity: Medium]
Can vertical decimation without horizontal decimation cause
tidss_plane_readout_fb() and tidss_plane_atomic_readout_state() to
miscalculate fb->pitches[0], fb->height, plane_state->src_h, and
plane_state->src.y2?

In dispc_vid_calc_scaling(), vertical decimation (scale.yinc > 1) is
computed independently of horizontal decimation (scale.xinc):

drivers/gpu/drm/tidss/tidss_dispc.c:dispc_plane_setup() {
    ...
	dispc_vid_write(dispc, hw_plane, DISPC_VID_PICTURE_SIZE,
			FIELD_PREP(DISPC_VID_PICTURE_SIZE_MEMSIZEY_MASK, scale.in_h - 1) |
			FIELD_PREP(DISPC_VID_PICTURE_SIZE_MEMSIZEX_MASK, scale.in_w - 1));
    ...
	dispc_vid_write(dispc, hw_plane, DISPC_VID_ROW_INC,
			pixinc(1 + (scale.yinc * fb_width -
				    scale.xinc * scale.in_w),
			       cpp));
    ...
}

When a plane downscales vertically with scale.xinc =3D=3D 1 and
scale.yinc > 1, DISPC_VID_PIXEL_INC remains 1, so readout succeeds but
computes fb->pitches[0] as scale.yinc * pitches[0] and reads back the
decimated height (src_h >> 16) / scale.yinc from DISPC_VID_PICTURE_SIZE.
This triggers post-commit state mismatch warnings in
drm_atomic_sro_readout_and_compare() and reconstructs bogus geometry if
firmware leaves vertical decimation enabled at boot.

[ ... ]

> +	crtc_state =3D drm_atomic_sro_get_crtc_state(state, crtc);
> +	if (!crtc_state) {
> +		ret =3D -ENODEV;
> +		goto err_runtime_pm;
> +	}
> +
> +	/*
> +	 * K2G has no overlay manager to tell us whether the plane is
> +	 * routed, and the planes of a disabled video port are left
> +	 * enabled: a plane on an inactive CRTC isn't scanned out.
> +	 */
> +	if (!crtc_state->active)
> +		goto out;

[Severity: Medium]
Should a NULL crtc_state jump to out instead of returning -ENODEV?

Because tidss_atomic_commit_tail() commits planes with
DRM_PLANE_COMMIT_ACTIVE_ONLY, disabling a CRTC leaves
DISPC_VID_ATTRIBUTES_ENABLE set on its planes, and on K2G (which has no
overlay manager) or when firmware leaves a plane routed to a disabled
video port, tidss_plane_readout_crtc() still returns that inactive CRTC.
If a later blocking commit updates a property on that unbound plane
without touching the inactive CRTC,
drm_atomic_helper_sro_readout_commit_crtcs_state() does not populate that
CRTC in state, so drm_atomic_sro_get_crtc_state() returns NULL and aborts
post-commit state readout with -ENODEV instead of treating the plane as
disabled.

[ ... ]

> +	// TODO: Handle src_x/src_y, see DISPC_VID_BA_0
> +
> +	plane_state->src.x1 =3D 0;
> +	plane_state->src.x2 =3D plane_state->src_w;
> +	plane_state->src.y1 =3D 0;
> +	plane_state->src.y2 =3D plane_state->src_h;
> +	plane_state->dst.x1 =3D crtc_x;
> +	plane_state->dst.x2 =3D crtc_x + plane_state->crtc_w;
> +	plane_state->dst.y1 =3D crtc_y;
> +	plane_state->dst.y2 =3D crtc_y + plane_state->crtc_h;
> +
> +	/*
> +	 * The global alpha register is 8 bits wide and is programmed
> +	 * from the high byte of the 16 bits alpha property.
> +	 * Replicating the byte is the only inverse that preserves the
> +	 * fraction of full opacity (0x00 -> 0x0000, 0xff -> 0xffff)
> +	 * and round-trips through a program-then-readout cycle.
> +	 */
> +	plane_state->alpha =3D
> +		dispc_plane_get_global_alpha(dispc, tplane->hw_plane_id) * 0x0101;
> +	plane_state->pixel_blend_mode =3D
> +		dispc_plane_get_blend_mode(dispc, tplane->hw_plane_id);
> +
> +	crtc_state->plane_mask |=3D drm_plane_mask(plane);
> +
> +out:
> +	tidss_runtime_put(tidss);
> +	return 0;
> +
> +err_runtime_pm:
> +	tidss_runtime_put(tidss);
> +	return ret;
> +}
> +
>  static const struct drm_plane_funcs tidss_plane_funcs =3D {
>  	.update_plane =3D drm_atomic_helper_update_plane,
>  	.disable_plane =3D drm_atomic_helper_disable_plane,
>  	.destroy =3D drm_plane_destroy,
>  	.atomic_create_state =3D drm_atomic_helper_plane_create_state,
> +	.atomic_sro_readout_state =3D tidss_plane_atomic_readout_state,
> +	.atomic_sro_compare_state =3D drm_atomic_helper_plane_compare_state,

[Severity: Medium]
Will drm_atomic_helper_plane_compare_state() report false state mismatches
whenever a plane is committed with non-zero src_x/src_y or a 16-bit alpha
whose high and low bytes differ?

drm_atomic_helper_check_plane_state() sets expected->src to
(src_x, src_y) .. (src_x + src_w, src_y + src_h), whereas
tidss_plane_atomic_readout_state() hardcodes actual->src.x1 and
actual->src.y1 to 0, causing the src.{x1,x2,y1,y2} checks in
drm_atomic_helper_plane_compare_state() to fail on any cropped or panned
plane.  Similarly, dispc_plane_setup() programs DISPC_VID_GLOBAL_ALPHA
with state->alpha >> 8, so comparing expected->alpha against the
replicated actual->alpha fails whenever (alpha >> 8) !=3D (alpha & 0xff)
(for example, 0x8000).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120-drm-state-=
readout-v9-0-a67c2b45b8ec@kernel.org?part=3D35
