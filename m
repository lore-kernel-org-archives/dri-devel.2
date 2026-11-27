Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE510606A323
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 10:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YC/qfAjE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 284521129C5;
	Fri, 27 Nov 2026 10:20:39 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DAFC1129C2
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 10:20:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8597F4088C
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 10:20:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15DAE1F0089A;
 Fri, 27 Nov 2026 10:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795774828;
 bh=TE/Zms/9JwEscPzsWqtseqvex5zJdzUsRquh7BWbBM8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=YC/qfAjEfkClPm4B5Tx98MkRphnPn/FDEKCOZEevMZDGXrb+zWG86Y/CjX5IjU+FB
 iC+JICPlE0dkbig5KKTU0xeietXcvRbcwhsk968RhMOa8D6RrXmz8tqck1Vkvs97Z6
 y2gTbvEkxqj/udC56xevk6L4kcmXCnS9D+ExW82YVxfDCJBHUI0LWcjBBtw4lGbfy8
 pqX+ymbLp6IFM0qmB4NdejI/KaxupuAukbS9MMZl4VDUTMxmwrKhPtLBgjI8KsI8E3
 6cMLW8P9LJfcFBb7KgXgvcjCTMS+mxL2t0lCWEoQz2o91ZAIBLVk0NcqQ9bAndHaJJ
 035Yo0fnrCctQ==
Message-ID: <sashiko-outbox-237098@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 30/36] drm/tidss: plane: Implement hardware state
 readout
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261127-drm-state-readout-v10-30-0259582d45a8@kernel.org>
References: <20261127-drm-state-readout-v10-0-0259582d45a8@kernel.org>
 <20261127-drm-state-readout-v10-30-0259582d45a8@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 10:20:27 +0000
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

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [Medium] drm/tidss: -ENODEV in tidss_plane_atomic_readout_state() on
  partial commits
- [Medium] drm/tidss: tidss_plane_readout_fb() ignores vertical
  decimation
- [Medium] drm/tidss: false alpha state mismatch in
  tidss_plane_atomic_readout_state()
--

commit 3be74e07814475f76096d9b92a77584c340fd8f8
Author: Maxime Ripard <mripard@kernel.org>

drm/tidss: plane: Implement hardware state readout

This commit implements the atomic_sro_readout_state and
atomic_sro_compare_state hooks for tidss planes so that planes enabled by
firmware can be read out at boot and compared after atomic commits.

> diff --git a/drivers/gpu/drm/tidss/tidss_plane.c b/drivers/gpu/drm/tidss/=
tidss_plane.c
> index b0d5d6959b885..a9b4005d1d603 100644
> --- a/drivers/gpu/drm/tidss/tidss_plane.c
> +++ b/drivers/gpu/drm/tidss/tidss_plane.c
[ ... ]
> @@ -176,11 +180,252 @@ static const struct drm_plane_helper_funcs tidss_p=
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
[ ... ]
> +	dispc_plane_get_picture_size(dispc, tplane->hw_plane_id, &fb->width,
> +				     &fb->height);
> +
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
Does checking dispc_plane_get_pixel_inc() !=3D 1 miss vertical decimation?

In dispc_vid_calc_scaling(), vertical decimation (scale.yinc > 1) can be
enabled while scale.xinc =3D=3D 1.  In that case dispc_plane_setup() still
programs DISPC_VID_PIXEL_INC to 1, but writes the decimated height
(src_h >> 16) / scale.yinc into DISPC_VID_PICTURE_SIZE and multiplies
fb_width by scale.yinc in DISPC_VID_ROW_INC:

drivers/gpu/drm/tidss/tidss_dispc.c:dispc_plane_setup() {
    ...
	dispc_vid_write(dispc, hw_plane, DISPC_VID_ROW_INC,
			pixinc(1 + (scale.yinc * fb_width -
				    scale.xinc * scale.in_w),
			       cpp));
    ...
}

As a result, tidss_plane_readout_fb() reconstructs fb->pitches[0] as
scale.yinc times the actual pitch and fb->height (along with
plane_state->src_h) as 1 / scale.yinc of the actual height, causing state
comparison mismatches after blocking commits with vertical decimation or
corrupted framebuffer geometry if enabled by firmware at boot.

[ ... ]

> +static int tidss_plane_atomic_readout_state(struct drm_plane *plane,
> +					    struct drm_atomic_sro_state *state,
> +					    struct drm_plane_state *plane_state)
> +{
[ ... ]
> +	crtc =3D tidss_plane_readout_crtc(plane, &crtc_x, &crtc_y,
> +					&normalized_zpos);
> +	if (IS_ERR(crtc)) {
> +		ret =3D PTR_ERR(crtc);
> +
> +		/*
> +		 * tidss_crtc_atomic_disable() disables the overlay layers of
> +		 * the video port, but the planes on a CRTC being disabled
> +		 * aren't disabled in the VID pipeline. A plane that isn't
> +		 * routed to any layer is thus disabled.
> +		 */
> +		if (ret =3D=3D -ENODEV)
> +			goto out;
> +
> +		goto err_runtime_pm;
> +	}
> +
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
Should !crtc_state jump to out instead of returning -ENODEV?

Because tidss commits planes with DRM_PLANE_COMMIT_ACTIVE_ONLY, disabling
a CRTC (or detaching a plane after its CRTC was disabled) leaves
DISPC_VID_ATTRIBUTES_ENABLE_MASK set in hardware.  On K2G, where
dispc_ovr_get_plane() always returns hw_videoport 0 (or on K3 when
firmware left an overlay layer enabled on an inactive video port),
tidss_plane_readout_crtc() still returns that inactive CRTC.

When a later blocking commit updates a property on the unbound plane
without touching the inactive CRTC,
drm_atomic_helper_sro_readout_commit_crtcs_state() only populates
state->crtcs for CRTCs included in the commit.
drm_atomic_sro_get_crtc_state() then returns NULL and
tidss_plane_atomic_readout_state() fails post-commit readout verification
with -ENODEV instead of reporting the plane as disabled.

Also, on multi-videoport K3 SoCs, dispc_ovr_get_plane() scans video ports
from 0 upward without checking whether the video port is enabled, so an
overlay layer left enabled on a disabled lower-numbered video port can
shadow an active higher-numbered video port using the same plane.

[ ... ]

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
Will drm_atomic_helper_plane_compare_state() report false alpha mismatches
whenever userspace commits an alpha value whose high and low bytes differ?

dispc_plane_setup() programs the 8-bit global alpha register from
state->alpha >> 8 while expected->alpha keeps the full 16-bit value from
userspace (for example, 0x8000 for 50% opacity).  Replicating the read-out
byte with * 0x0101 produces actual->alpha =3D 0x8080, which fails the exact
16-bit comparison in drm_atomic_helper_plane_compare_state().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127-drm-state-=
readout-v10-0-0259582d45a8@kernel.org?part=3D30
