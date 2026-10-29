Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4764606A31D
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 08:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vm5zTFQ4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 102A710E7BF;
	Thu, 29 Oct 2026 08:22:38 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B82DA10E7BF
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 08:22:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AB4AE60210
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 08:22:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 471C81F01825;
 Thu, 29 Oct 2026 08:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793262150;
 bh=zR+5Ig0J2degW4/aIqF5BaF2Csc+1fYppieNHLdrhdI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Vm5zTFQ40ac3JAeD58a/B9THntXhAfwQWl9NRLjyxUQX3zXdy8OdCKHn+Yjp7KxgG
 By0PFAWhjlK7ZFhBKzxvnAS5JR5IU6CQsDilz6TYzhiWFxcuHuWB5MaKWMn6Lm3nsb
 BgS7sB45oX3kZgFdIz3ZirDyGEQSffCNZ18zeGOe67yQ3PehtVk5zVbKdtjGvomkwr
 YT5OHUbPlM9tWVqgohkrftfGt7EvsO75xnTLBIOPv9zaON8c6EJWWIt1QndDarl7WN
 TBYiCQu2v22zhJXV3/wRybPxO8j6gyoizjJ2yQ46qdmTGJHSw0dWyUDks46Xxs6Nbf
 5yBbDCf3yJKlw==
Message-ID: <sashiko-outbox-188958@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 32/34] drm/tidss: Implement readout support
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261029-drm-state-readout-v7-32-25e5163d75c3@kernel.org>
References: <20261029-drm-state-readout-v7-0-25e5163d75c3@kernel.org>
 <20261029-drm-state-readout-v7-32-25e5163d75c3@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 08:22:29 +0000
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

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [High] drm/tidss: tidss_crtc_install_state() enables inactive CRTCs and l=
eaks PM
- [High] drm/tidss: missing drm_mode_config_create_initial_state() in tidss=
_probe()
- [High] drm/tidss: GEM-less readout fb fails prepare_fb() and zeroes DMA a=
ddress
- [Medium] drm/tidss: tidss_crtc_compare_state() checks bus config on inact=
ive CRTCs
- [Medium] drm/tidss: plane readout incomplete state and -EINVAL trigger WA=
RN_ON on commit
- [Medium] drm/tidss: incomplete crtc_state->plane_mask readout on partial =
commits
--

commit 8f81eb167182a1d35a4ac3bf95240f371e285879
Author: Maxime Ripard <mripard@kernel.org>

drm/tidss: Implement readout support

This commit implements hardware state readout and state comparison callbacks
for CRTCs, bridges, and planes in the tidss driver using the DRM atomic sta=
te
readout helpers.

> diff --git a/drivers/gpu/drm/tidss/tidss_crtc.c b/drivers/gpu/drm/tidss/t=
idss_crtc.c
> index 3da49f77fa080..4409f8c9114bb 100644
> --- a/drivers/gpu/drm/tidss/tidss_crtc.c
> +++ b/drivers/gpu/drm/tidss/tidss_crtc.c
[ ... ]
> @@ -370,6 +374,90 @@ static struct drm_crtc_state *tidss_crtc_create_stat=
e(struct drm_crtc *crtc)
>  	return &tstate->base;
>  }
> =20
> +static int tidss_crtc_readout_state(struct drm_crtc *crtc,
> +				    struct drm_atomic_sro_state *state,
> +				    struct drm_crtc_state *crtc_state)
> +{
> +	struct drm_device *ddev =3D crtc->dev;
> +	struct tidss_device *tidss =3D to_tidss(ddev);
> +	struct dispc_device *dispc =3D tidss->dispc;
> +	struct tidss_crtc_state *tstate =3D to_tidss_crtc_state(crtc_state);
> +	struct tidss_crtc *tcrtc =3D
> +		to_tidss_crtc(crtc);
> +	struct drm_display_mode mode =3D {};
> +	int ret;
> +
> +	tidss_runtime_get(tidss);
> +
> +	if (!dispc_vp_is_enabled(dispc, tcrtc->hw_videoport))
> +		goto out;
> +
> +	tstate->base.active =3D 1;
> +	tstate->base.enable =3D 1;
> +
> +	ret =3D dispc_vp_readout_mode(dispc, tcrtc->hw_videoport, &mode);
> +	if (ret)
> +		goto err_runtime_put;
> +
> +	ret =3D drm_atomic_set_mode_for_crtc(&tstate->base, &mode);
> +	if (WARN_ON(ret))
> +		goto err_runtime_put;
> +
> +	drm_mode_copy(&tstate->base.adjusted_mode, &mode);
> +
> +	tstate->bus_flags =3D dispc_vp_get_bus_flags(dispc, tcrtc->hw_videoport=
);
> +	ret =3D dispc_vp_get_bus_format(dispc, tcrtc->hw_videoport,
> +				      &tstate->bus_format);
> +	if (ret)
> +		goto err_runtime_put;
> +
> +	/*
> +	 * The active connectors and planes will be filled by their
> +	 * respective readout callbacks.
> +	 */

[Severity: Medium]
What happens to crtc_state->plane_mask (as well as connector_mask and
encoder_mask) during post-commit verification in
drm_atomic_sro_readout_and_compare() when a blocking commit includes the CR=
TC
but only a subset of its active planes?

When drm_atomic_sro_readout_and_compare(commit) calls
drm_atomic_helper_sro_build_state(dev, commit) with a non-NULL commit,
drm_atomic_helper_sro_readout_planes_state() only invokes
atomic_sro_readout_state() for planes present in that commit.

If two planes are active on a CRTC and userspace performs a blocking page
flip or property update on only one of them (without changing x/y or zpos, =
so
tidss_atomic_check() does not call drm_atomic_add_affected_planes()),
tidss_plane_atomic_check() adds the CRTC to the commit via
drm_atomic_get_crtc_state(), but the second active plane is not in the comm=
it.

Because tidss_crtc_readout_state() leaves crtc_state->plane_mask at 0 and
relies on tidss_plane_atomic_readout_state() to OR in drm_plane_mask(plane),
won't the untouched plane's bit be missing from the readout CRTC state's
plane_mask, causing drm_atomic_helper_crtc_compare_state() to report a
plane_mask mismatch?

> +
> +out:
> +	tidss_runtime_put(tidss);
> +	return 0;
> +
> +err_runtime_put:
> +	tidss_runtime_put(tidss);
> +	return ret;
> +}
> +
> +static void tidss_crtc_install_state(struct drm_crtc *crtc,
> +				     struct drm_crtc_state *crtc_state)
> +{
> +	struct tidss_crtc *tcrtc =3D to_tidss_crtc(crtc);
> +	struct drm_device *ddev =3D crtc->dev;
> +	struct tidss_device *tidss =3D to_tidss(ddev);
> +	int ret;
> +
> +	tidss_runtime_get(tidss);
> +
> +	ret =3D dispc_vp_enable_clk(tidss->dispc, tcrtc->hw_videoport);
> +	if (ret !=3D 0)
> +		return;
> +
> +	/* Turn vertical blanking interrupt reporting on. */
> +	drm_crtc_vblank_on(crtc);
> +}

[Severity: High]
Should tidss_crtc_install_state() check whether crtc_state->active is set
before enabling runtime PM, the videoport clock, and vblank reporting?

When a videoport is disabled in hardware (!dispc_vp_is_enabled()),
tidss_crtc_readout_state() jumps to out and returns 0 with
crtc_state->active =3D=3D false, and drm_atomic_helper_sro_readout_crtc_sta=
te()
stores that inactive state in state->crtcs[i].state.

Later, drm_atomic_sro_install_state() iterates over all CRTCs and invokes
atomic_sro_install_state() for every non-NULL crtc_state:

drivers/gpu/drm/drm_atomic_state_readout.c:drm_atomic_sro_install_state() {
    ...
		crtc_state =3D state->crtcs[i].state;
		if (!crtc_state)
			continue;

		if (crtc_funcs->atomic_sro_install_state)
			crtc_funcs->atomic_sro_install_state(crtc, crtc_state);
    ...
}

For an inactive CRTC, won't tidss_crtc_install_state() unconditionally call
tidss_runtime_get(), dispc_vp_enable_clk(), and drm_crtc_vblank_on(), leaki=
ng
both the runtime PM reference and the videoport clock enable count because
crtc->state->active is false (so tidss_crtc_atomic_disable() will not run to
release them)?

Also, if dispc_vp_enable_clk() returns a non-zero error in
tidss_crtc_install_state(), doesn't the early return leak the runtime PM
reference acquired by tidss_runtime_get(tidss)?

> +
> +static bool tidss_crtc_compare_state(struct drm_crtc *crtc,
> +				     struct drm_printer *p,
> +				     struct drm_crtc_state *expected,
> +				     struct drm_crtc_state *actual)
> +{
> +	struct tidss_crtc_state *t_expected =3D to_tidss_crtc_state(expected);
> +	struct tidss_crtc_state *t_actual =3D to_tidss_crtc_state(actual);
> +	bool ret =3D drm_atomic_helper_crtc_compare_state(crtc, p, expected, ac=
tual);
> +
> +	STATE_CHECK_U32_X(ret, p, crtc->name, t_expected, t_actual, bus_format);
> +	STATE_CHECK_U32_X(ret, p, crtc->name, t_expected, t_actual, bus_flags);
> +
> +	return ret;
> +}

[Severity: Medium]
Can tidss_crtc_compare_state() report false mismatches for bus_format and
bus_flags when an active CRTC is disabled?

When a CRTC is disabled in a blocking commit, tidss_crtc_duplicate_state()
copies the previous active state's non-zero bus_format and bus_flags into t=
he
new state:

drivers/gpu/drm/tidss/tidss_crtc.c:tidss_crtc_duplicate_state() {
    ...
	state->bus_format =3D current_state->bus_format;
	state->bus_flags =3D current_state->bus_flags;
    ...
}

During post-commit readout in tidss_crtc_readout_state(),
!dispc_vp_is_enabled() is true and jumps to out before reading bus_flags or
bus_format, leaving them 0 in t_actual.

While drm_atomic_helper_crtc_compare_state() returns early when both
expected->active and actual->active are false:

drivers/gpu/drm/drm_atomic_state_readout_helper.c:drm_atomic_helper_crtc_co=
mpare_state() {
    ...
	/* Both inactive, mode and properties are meaningless. */
	if (!expected->active && !actual->active)
		return ret;
    ...
}

tidss_crtc_compare_state() still checks bus_format and bus_flags
unconditionally. Should those checks be skipped when the CRTC is inactive?

> diff --git a/drivers/gpu/drm/tidss/tidss_kms.c b/drivers/gpu/drm/tidss/ti=
dss_kms.c
> index 3b97c08c4f714..b0b69b8531111 100644
> --- a/drivers/gpu/drm/tidss/tidss_kms.c
> +++ b/drivers/gpu/drm/tidss/tidss_kms.c
[ ... ]
> @@ -133,6 +136,7 @@ static const struct drm_mode_config_funcs mode_config=
_funcs =3D {
>  	.fb_create =3D drm_gem_fb_create,
>  	.atomic_check =3D tidss_atomic_check,
>  	.atomic_commit =3D drm_atomic_helper_commit,
> +	.atomic_sro_readout_state =3D drm_atomic_helper_sro_readout_state,
>  	.hw_reset =3D tidss_hw_reset,
>  };

[Severity: High]
How are mode_config_funcs.atomic_sro_readout_state (and tidss_crtc_install_=
state)
and the fallback mode_config_funcs.hw_reset reached during probe?

In drivers/gpu/drm/drm_mode_config.c, atomic_sro_readout_state and hw_reset
are only invoked by drm_mode_config_create_initial_state():

drivers/gpu/drm/drm_mode_config.c:drm_mode_config_create_initial_state() {
    ...
	if (dev->mode_config.funcs->atomic_sro_readout_state) {
		ret =3D dev->mode_config.funcs->atomic_sro_readout_state(dev);
		if (!ret)
			goto out;
	}

	/* Reset the hardware first ... */
	if (dev->mode_config.funcs->hw_reset)
		dev->mode_config.funcs->hw_reset(dev);
    ...
}

However, tidss_probe() in drivers/gpu/drm/tidss/tidss_drv.c still calls
drm_mode_config_reset(ddev):

drivers/gpu/drm/tidss/tidss_drv.c:tidss_probe() {
    ...
	drm_kms_helper_poll_init(ddev);

	drm_mode_config_reset(ddev);

	ret =3D drm_dev_register(ddev, 0);
    ...
}

Because drm_mode_config_reset() only allocates blank software states without
calling atomic_sro_readout_state or hw_reset, isn't initial state readout
(along with the hardware reset moved into tidss_hw_reset()) never executed =
at
probe time?

Furthermore, if tidss_probe() is updated to call
drm_mode_config_create_initial_state(ddev) after pm_runtime_enable(dev), wo=
n't
dispc_reset_hw() fail when readout falls back to hw_reset because
pm_runtime_set_active(dev) returns -EAGAIN when runtime PM is already enabl=
ed?

> diff --git a/drivers/gpu/drm/tidss/tidss_plane.c b/drivers/gpu/drm/tidss/=
tidss_plane.c
> index b0d5d6959b885..ebdb63f8e8f17 100644
> --- a/drivers/gpu/drm/tidss/tidss_plane.c
> +++ b/drivers/gpu/drm/tidss/tidss_plane.c
[ ... ]
> @@ -176,11 +179,186 @@ static const struct drm_plane_helper_funcs tidss_p=
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
> +	if (IS_ERR(info)) {
> +		ret =3D PTR_ERR(info);
> +		goto err_free_fb;
> +	}
> +
> +	// TODO: Figure out YUV and multiplanar formats, along with
> +	// the color encoding and range
> +	if (info->is_yuv) {
> +		ret =3D -EINVAL;
> +		goto err_free_fb;
> +	}
> +
> +	fb->format =3D info;
> +
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
> +
> +	/*
> +	 * TODO: The DMA base address has the offsets baked in, and there
> +	 * is no backing buffer to recover them from.
> +	 */
> +	fb->offsets[0] =3D 0;
> +
> +	ret =3D drm_framebuffer_init(plane->dev, fb, &tidss_plane_readout_fb_fu=
ncs);
> +	if (ret) {
> +		kfree(fb);
> +		return ERR_PTR(ret);
> +	}
> +
> +	return fb;
> +
> +err_free_fb:
> +	kfree(fb);
> +	return ERR_PTR(ret);
> +}

[Severity: High]
What happens on a subsequent atomic commit if a plane still references the
framebuffer created by tidss_plane_readout_fb() (for example, when updating
plane properties or when tidss_atomic_check() adds affected planes on the
CRTC)?

Because tidss_plane_readout_fb() allocates fb with fb->obj[0] =3D=3D NULL a=
nd
neither tidss_plane_helper_funcs nor tidss_primary_plane_helper_funcs sets a
custom .prepare_fb callback, drm_atomic_helper_prepare_planes() defaults to
drm_gem_plane_helper_prepare_fb() on this DRIVER_GEM driver. Won't
drm_gem_fb_get_obj(state->fb, 0) trigger drm_WARN_ON_ONCE(dev, !fb->obj[pla=
ne])
and fail the commit with -EINVAL?

In addition, if dispc_plane_setup() is called while state->fb is a GEM-less
readout framebuffer:

drivers/gpu/drm/tidss/tidss_dispc.c:dispc_plane_setup() {
    ...
	dma_addr_t dma_addr =3D drm_fb_dma_get_gem_addr(state->fb, state, 0);
    ...
	dispc_vid_write(dispc, hw_plane, DISPC_VID_BA_0, dma_addr & 0xffffffff);
	dispc_vid_write(dispc, hw_plane, DISPC_VID_BA_EXT_0, (u64)dma_addr >> 32);
    ...
}

drm_fb_dma_get_gem_addr() returns 0 when fb->obj[0] is NULL, which would
overwrite DISPC_VID_BA_0 and DISPC_VID_BA_EXT_0 with 0x0.

> +
> +static struct drm_crtc *tidss_plane_readout_crtc(struct drm_plane *plane)
> +{
> +	struct drm_device *dev =3D plane->dev;
> +
> +	/* TODO: Add support for multiple CRTCs */
> +	if (dev->num_crtcs !=3D 1)
> +		return ERR_PTR(-EINVAL);
> +
> +	return list_first_entry(&dev->mode_config.crtc_list, struct drm_crtc, h=
ead);
> +}
> +
> +static int tidss_plane_atomic_readout_state(struct drm_plane *plane,
> +					    struct drm_atomic_sro_state *state,
> +					    struct drm_plane_state *plane_state)
> +{
[ ... ]
> +	dispc_plane_get_size(dispc, tplane->hw_plane_id, &plane_state->crtc_w,
> +			     &plane_state->crtc_h);
> +
> +	// TODO: Handle crtc_x/crtc_x/src_x/src_y
> +	// crtc_x/crtc_y are handled by DISPC_OVR_ATTRIBUTES / OVR1_DSS_ATTRIBU=
TES
> +
> +	// TODO: Handle zpos, see DISPC_OVR_ATTRIBUTES / OVR1_DSS_ATTRIBUTES
> +
> +	plane_state->src.x1 =3D 0;
> +	plane_state->src.x2 =3D plane_state->src_w;
> +	plane_state->src.y1 =3D 0;
> +	plane_state->src.y2 =3D plane_state->src_h;
> +	plane_state->dst.x1 =3D 0;
> +	plane_state->dst.x2 =3D plane_state->crtc_w;
> +	plane_state->dst.y1 =3D 0;
> +	plane_state->dst.y2 =3D plane_state->crtc_h;

[Severity: Medium]
Won't the unimplemented cases in tidss_plane_readout_fb(),
tidss_plane_readout_crtc(), and tidss_plane_atomic_readout_state() trigger
kernel warnings and state mismatch errors during normal runtime commits?

When all bridges and connectors in the pipeline implement readout callbacks,
drm_atomic_sro_device_can_readout() returns true and every blocking atomic
commit runs drm_atomic_sro_readout_and_compare() in commit_tail().

If userspace commits a YUV plane (info->is_yuv), enables horizontal
decimation (dispc_plane_get_pixel_inc() !=3D 1), or runs on a multi-CRTC SoC
(dev->num_crtcs !=3D 1), tidss_plane_atomic_readout_state() returns -EINVAL,
which triggers drm_WARN_ON(dev, ret) in
drm_atomic_helper_sro_readout_plane_state() and WARN_ON(IS_ERR(readout_stat=
e))
in drm_atomic_sro_readout_and_compare().

Similarly, if a blocking commit positions a plane at non-zero crtc_x/crtc_y=
 or
src_x/src_y, or uses a non-zero zpos/normalized_zpos, leaving those fields =
at
0 in tidss_plane_atomic_readout_state() will cause
drm_atomic_helper_plane_compare_state() to log state mismatch errors on eve=
ry
such commit.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-drm-state-=
readout-v7-0-25e5163d75c3@kernel.org?part=3D32
