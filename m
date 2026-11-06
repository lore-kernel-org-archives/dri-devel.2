Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE049606A32F
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 14:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JRUc8QcS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15A5688A27;
	Fri,  6 Nov 2026 14:07:05 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00E70112DF3
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 14:06:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 217856020F
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 14:06:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B41DF1F0089F;
 Fri,  6 Nov 2026 14:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793974017;
 bh=Rge4lu9kpKsnTowsl8nkJdYBqHNW5UZnKbXZCv1uV0w=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JRUc8QcSnNIjsKK4bDBEKBcbKdRQCsF864dHDokJSog9+ifHyk/M/+pYkdKJP6yCW
 q+he/M7p+ZQHAfhFDYhenhYZGD8xT5fdKQENbr1ixZMWxVE6oGtHleaQsQycj5Cha/
 uplNi7ZA04sFCFkIHLa68ygvja9Dc8kAp7diy6y7fB2KgznrB7UbnJVl/gygZlOxL0
 JkhngKZhf6ytdKCqupGRP3mjx7u2mnxDhM4F7JcJsdumEKSZbcFAgDLDG2rB3umOER
 6+4jF8Ez5fXeVr0LHbPAZNtMFrZR6oPflTj1wTR2odRP2UFfMSQW8i/1GAtShYb3/p
 0Ep76REtDM8wQ==
Message-ID: <sashiko-outbox-201540@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 35/39] drm/tidss: Implement readout support
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261106-drm-state-readout-v8-35-cbe78624e1bc@kernel.org>
References: <20261106-drm-state-readout-v8-0-cbe78624e1bc@kernel.org>
 <20261106-drm-state-readout-v8-35-cbe78624e1bc@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 14:06:57 +0000
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

Thank you for your contribution! Sashiko AI review found 8 potential
issues to consider:
- [High] drm/tidss: dispc_vp_init() clears DPIENABLE and dpi_output is
  unset on readout
- [High] drm/tidss: tidss_crtc_install_state() runs before
  tidss_irq_install() in probe
- [Medium] drm/tidss: missing drm_crtc_vblank_reset() in
  tidss_crtc_install_state()
- [Medium] drm/tidss: wrong channel ID comparison in
  dispc_ovr_get_plane()
- [Medium] drm/tidss: plane readout fails in
  tidss_plane_atomic_readout_state() when CRTC is disabled
- [Medium] drm/tidss: zpos and cropping mismatches in
  tidss_plane_atomic_readout_state()
- [Medium] drm/tidss: refcount imbalance and leak from
  tidss_crtc_install_state()
- [Medium] drm/tidss: bus_flags mismatch in dispc_vp_get_bus_flags()
  readout
--

commit 3df04a68595619e1ce0b980646624376e9262bc8
Author: Maxime Ripard <mripard@kernel.org>

drm/tidss: Implement readout support

This commit implements KMS hardware state readout callbacks for the tidss
CRTC, encoder bridge, plane, and DISPC layers.

> diff --git a/drivers/gpu/drm/tidss/tidss_crtc.c b/drivers/gpu/drm/tidss/t=
idss_crtc.c
> index d2664bda53a99..38d7a5dfe4f3d 100644
> --- a/drivers/gpu/drm/tidss/tidss_crtc.c
> +++ b/drivers/gpu/drm/tidss/tidss_crtc.c
[ ... ]
> @@ -372,6 +376,108 @@ static struct drm_crtc_state *tidss_crtc_create_sta=
te(struct drm_crtc *crtc)
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

[Severity: High]
Does the first tidss_runtime_get() during boot readout disable active DPI
outputs on SoCs with has_vp_control_dpienable set (AM62L)?

During tidss_probe(), the device starts runtime-suspended, so the first
tidss_runtime_get() calls dispc_runtime_resume() -> dispc_initial_config() =
->
dispc_vp_init():

drivers/gpu/drm/tidss/tidss_dispc.c:dispc_vp_init() {
	for (i =3D 0; i < dispc->feat->num_vps; i++) {
		VP_REG_FLD_MOD(dispc, i, DISPC_VP_CONFIG, 1,
			       DISPC_VP_CONFIG_GAMMAENABLE_MASK);

		if (dispc->feat->has_vp_control_dpienable) {
			/* Disable DPIENABLE for all VPs */
			VP_REG_FLD_MOD(dispc, i, DISPC_VP_CONTROL, 0,
				       DISPC_VP_CONTROL_DPIENABLE_MASK);
		}
	}
}

Because DISPC_VP_CONTROL_ENABLE_MASK stays set, dispc_vp_is_enabled() still
returns true and state readout succeeds without a full modeset, leaving
DISPC_VP_CONTROL_DPIENABLE_MASK cleared and the DPI display blank.

In addition, dispc->vp_data[hw_videoport].dpi_output is only populated in
dispc_vp_setup() during tidss_crtc_atomic_enable() or
tidss_crtc_atomic_flush(), so tidss_crtc_install_state() leaves it false on=
 a
read-out CRTC and a subsequent tidss_crtc_atomic_disable() skips clearing
DISPC_VP_CONTROL_DPIENABLE_MASK in dispc_vp_unprepare().

[ ... ]

> +static void tidss_crtc_install_state(struct drm_crtc *crtc,
> +				     struct drm_crtc_state *crtc_state)
> +{
> +	struct tidss_crtc *tcrtc =3D to_tidss_crtc(crtc);
> +	struct drm_device *ddev =3D crtc->dev;
> +	struct tidss_device *tidss =3D to_tidss(ddev);
> +	int ret;
> +
> +	/*
> +	 * The video port wasn't enabled in hardware: nothing to take
> +	 * over for it, and enabling the clock and the vblank reporting
> +	 * would leak their reference for a CRTC that no disable will
> +	 * ever release.
> +	 */
> +	if (!crtc_state->active)
> +		return;

[Severity: Medium]
Should the inactive branch call drm_crtc_vblank_reset(crtc) before returnin=
g?

When drm_mode_config_create_initial_state() succeeds via state readout, it
skips the drm_mode_config_create_state() fallback that normally calls
drm_crtc_vblank_reset().  Returning early here leaves vblank->inmodeset at 0
after drm_vblank_init(), allowing userspace vblank ioctls such as
DRM_IOCTL_WAIT_VBLANK to enable vblank interrupts on a disabled video port
instead of failing with -EINVAL.

> +
> +	tidss_runtime_get(tidss);
> +
> +	ret =3D dispc_vp_enable_clk(tidss->dispc, tcrtc->hw_videoport);
> +	if (ret !=3D 0) {
> +		tidss_runtime_put(tidss);
> +		return;
> +	}

[Severity: Medium]
If dispc_vp_enable_clk() fails here, or if tidss_probe() fails after
drm_mode_config_create_initial_state(), does this cause a clock and runtime
PM refcount imbalance?

When dispc_vp_enable_clk() fails, tidss_crtc_install_state() drops the
runtime PM reference and returns without enabling vp_clk, but crtc->state is
still installed with active =3D true, so a later tidss_crtc_atomic_disable()
unconditionally calls drm_crtc_vblank_off(), dispc_vp_disable_clk(), and
tidss_runtime_put(), underflowing both counts.  Conversely, if tidss_probe()
fails in platform_get_irq(), tidss_irq_install(), drm_dev_register(), or
aperture_remove_all_conflicting_devices(), the error path never unwinds the
vp_clk and runtime PM references acquired here for active CRTCs.

> +
> +	/* Turn vertical blanking interrupt reporting on. */\
> +	drm_crtc_vblank_on(crtc);
> +}

[Severity: High]
Does running tidss_crtc_install_state() before tidss_irq_install() in
tidss_probe() leave hardware interrupts unprogrammed while a read-out CRTC =
is
active?

In tidss_probe(), drm_mode_config_create_initial_state() runs before
tidss_irq_install():

drivers/gpu/drm/tidss/tidss_drv.c:tidss_probe() {
    ...
	ret =3D drm_mode_config_create_initial_state(ddev);
	if (ret) {
		dev_err(dev, "failed to create initial state: %d\n", ret);
		goto err_runtime_suspend;
	}

	irq =3D platform_get_irq(pdev, 0);
	if (irq < 0) {
		ret =3D irq;
		goto err_runtime_suspend;
	}
	tidss->irq =3D irq;

	ret =3D tidss_irq_install(ddev, irq);
    ...
}

When readout finds an active CRTC, tidss_crtc_install_state() keeps the
device runtime-active and calls drm_crtc_vblank_on(crtc).  tidss_irq_instal=
l()
then resets tidss->irq_mask =3D 0 (wiping any vblank IRQ bits set when
drm_vblank_offdelay =3D=3D 0) and populates DSS_IRQ_VP_FRAME_DONE,
DSS_IRQ_VP_SYNC_LOST, and DSS_IRQ_PLANE_FIFO_UNDERFLOW in tidss->irq_mask
without writing the mask to hardware.  Because the device is already runtime
active, dispc_runtime_resume() -> tidss_irq_resume() does not run again, so
FRAME_DONE remains disabled in hardware and a subsequent
tidss_crtc_atomic_disable() times out waiting for framedone_completion.

> diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/=
tidss_dispc.c
> index 8720403af9ed3..c3117745965b7 100644
> --- a/drivers/gpu/drm/tidss/tidss_dispc.c
> +++ b/drivers/gpu/drm/tidss/tidss_dispc.c
[ ... ]
> @@ -1474,6 +1480,228 @@ int dispc_vp_set_clk_rate(struct dispc_device *di=
spc, u32 hw_videoport,
[ ... ]
> +u32 dispc_vp_get_bus_flags(struct dispc_device *dispc, u32 hw_videoport)
> +{
> +	u32 flags =3D 0;
> +	u32 val;
> +
> +	val =3D dispc_vp_read(dispc, hw_videoport, DISPC_VP_POL_FREQ);
> +	if (FIELD_GET(DISPC_VP_POL_FREQ_IPC_MASK, val))
> +		flags |=3D DRM_BUS_FLAG_PIXDATA_DRIVE_NEGEDGE;
> +	else
> +		flags |=3D DRM_BUS_FLAG_PIXDATA_DRIVE_POSEDGE;
> +
> +	if (FIELD_GET(DISPC_VP_POL_FREQ_IEO_MASK, val))
> +		flags |=3D DRM_BUS_FLAG_DE_LOW;
> +	else
> +		flags |=3D DRM_BUS_FLAG_DE_HIGH;
> +
> +	if (FIELD_GET(DISPC_VP_POL_FREQ_RF_MASK, val))
> +		flags |=3D DRM_BUS_FLAG_SYNC_DRIVE_POSEDGE;
> +	else
> +		flags |=3D DRM_BUS_FLAG_SYNC_DRIVE_NEGEDGE;
> +
> +	return flags;
> +}

[Severity: Medium]
Will dispc_vp_get_bus_flags() cause state comparison mismatches in
tidss_crtc_compare_state() and drm_atomic_helper_bridge_compare_state() whe=
n a
panel or bridge leaves some polarity flags unset?

In tidss_bridge_atomic_check(), tcrtc_state->bus_flags is copied directly
from the next bridge or connector display_info without normalizing unset
polarity bits, and dispc_vp_prepare() defaults unset bits in hardware to
POSEDGE / DE_HIGH / NEGEDGE (for example, rocktech_rk101ii01d_ct on AM654
OLDI only sets DRM_BUS_FLAG_DE_HIGH).  Because dispc_vp_get_bus_flags()
unconditionally sets all three polarity flags, the read-out bus_flags will
not match the committed bus_flags after a blocking commit.

> +
>  /* OVR */
>  static void dispc_k2g_ovr_set_plane(struct dispc_device *dispc,
>  				    u32 hw_plane, u32 hw_videoport,
> @@ -1547,6 +1775,94 @@ void dispc_ovr_enable_layer(struct dispc_device *d=
ispc,
[ ... ]
> +int dispc_ovr_get_plane(struct dispc_device *dispc, u32 hw_plane,
> +			u32 *hw_videoport, int *x, int *y, u32 *layer)
> +{
> +	u32 vp, l;
> +
> +	switch (dispc->feat->subrev) {
[ ... ]
> +	case DISPC_AM625:
> +	case DISPC_AM62A7:
> +	case DISPC_AM62L:
> +	case DISPC_AM65X:
> +	case DISPC_J721E:
> +		for (vp =3D 0; vp < dispc->feat->num_vps; vp++) {
> +			for (l =3D 0; l < dispc->feat->num_vids; l++) {
> +				u32 attrs =3D dispc_ovr_read(dispc, vp,
> +							   DISPC_OVR_ATTRIBUTES(l));
> +
> +				if (!(attrs & DISPC_OVR_ATTRIBUTES_ENABLE_MASK))
> +					continue;
> +
> +				if (FIELD_GET(DISPC_OVR_ATTRIBUTES_CHANNELIN_MASK,
> +					      attrs) !=3D hw_plane)
> +					continue;

[Severity: Medium]
Should DISPC_OVR_ATTRIBUTES_CHANNELIN_MASK be compared against
dispc->feat->vid_info[hw_plane].hw_id instead of hw_plane?

dispc_am65x_ovr_set_plane() and dispc_j721e_ovr_set_plane() program CHANNEL=
IN
with dispc->feat->vid_info[hw_plane].hw_id.  On DISPC_AM62L, the single pla=
ne
has software index hw_plane =3D 0 but vid_info[0].hw_id =3D 1, so
dispc_ovr_get_plane() never matches the enabled layer and returns -ENODEV,
breaking both initial state readout and post-commit readout verification.

> diff --git a/drivers/gpu/drm/tidss/tidss_plane.c b/drivers/gpu/drm/tidss/=
tidss_plane.c
> index b0d5d6959b885..94824cff77f9d 100644
> --- a/drivers/gpu/drm/tidss/tidss_plane.c
> +++ b/drivers/gpu/drm/tidss/tidss_plane.c
[ ... ]
> @@ -176,11 +179,213 @@ static const struct drm_plane_helper_funcs tidss_p=
rimary_plane_helper_funcs =3D {
[ ... ]
> +static int tidss_plane_atomic_readout_state(struct drm_plane *plane,
> +					    struct drm_atomic_sro_state *state,
> +					    struct drm_plane_state *plane_state)
> +{
> +	struct drm_device *ddev =3D plane->dev;
> +	struct tidss_device *tidss =3D to_tidss(ddev);
> +	struct dispc_device *dispc =3D tidss->dispc;
> +	struct tidss_plane *tplane =3D to_tidss_plane(plane);
> +	struct drm_crtc_state *crtc_state;
> +	struct drm_framebuffer *fb;
> +	struct drm_crtc *crtc;
> +	unsigned int in_w, in_h;
> +	int crtc_x, crtc_y;
> +	u32 normalized_zpos;
> +	int ret;
> +
> +	tidss_runtime_get(tidss);
> +
> +	if (!dispc_plane_is_enabled(dispc, tplane->hw_plane_id))
> +		goto out;
> +
> +	fb =3D tidss_plane_readout_fb(plane);
> +	if (IS_ERR(fb)) {
> +		ret =3D PTR_ERR(fb);
> +		goto err_runtime_pm;
> +	}
> +
> +	crtc =3D tidss_plane_readout_crtc(plane, &crtc_x, &crtc_y,
> +					&normalized_zpos);
> +	if (IS_ERR(crtc)) {
> +		drm_framebuffer_put(fb);
> +		ret =3D PTR_ERR(crtc);
> +		goto err_runtime_pm;
> +	}

[Severity: Medium]
Does plane state readout fail or report stale active planes when a CRTC is
disabled?

When a CRTC is disabled, tidss_crtc_atomic_disable() disables the OVR layers
and video port, while tidss_atomic_commit_tail() passes
DRM_PLANE_COMMIT_ACTIVE_ONLY to drm_atomic_helper_commit_planes(), skipping
tidss_plane_atomic_disable() on the newly inactive CRTC and leaving
DISPC_VID_ATTRIBUTES_ENABLE_MASK set in hardware.  When post-commit readout
runs:
- on K3 SoCs, dispc_ovr_get_plane() finds no enabled OVR layer and returns
  -ENODEV, which tidss_plane_atomic_readout_state() treats as a fatal error
  instead of an unrouted/inactive plane;
- on K2G, dispc_ovr_get_plane() unconditionally returns videoport 0 even wh=
en
  the video port is disabled, and tidss_plane_atomic_readout_state() never
  checks crtc_state->active before marking the plane visible and attaching =
it
  to the disabled CRTC.

> +
> +	plane_state->fb =3D fb;
> +	plane_state->crtc =3D crtc;
> +	plane_state->visible =3D true;
> +
> +	dispc_plane_get_picture_size(dispc, tplane->hw_plane_id, &in_w, &in_h);
> +	plane_state->src_w =3D in_w << 16;
> +	plane_state->src_h =3D in_h << 16;
> +
> +	dispc_plane_get_size(dispc, tplane->hw_plane_id, &plane_state->crtc_w,
> +			     &plane_state->crtc_h);
> +
> +	plane_state->crtc_x =3D crtc_x;
> +	plane_state->crtc_y =3D crtc_y;
> +
> +	/*
> +	 * The overlay layer index a plane is routed to is its
> +	 * normalized zpos, as that is what the atomic update uses as
> +	 * the layer index. The raw zpos property userspace set
> +	 * cannot be recovered from the hardware.
> +	 */
> +	plane_state->normalized_zpos =3D normalized_zpos;
> +	plane_state->zpos =3D normalized_zpos;
> +
> +	// TODO: Handle src_x/src_y, see DISPC_VID_BA_0
> +
> +	plane_state->src.x1 =3D 0;
> +	plane_state->src.x2 =3D plane_state->src_w;
> +	plane_state->src.y1 =3D 0;
> +	plane_state->src.y2 =3D plane_state->src_h;

[Severity: Medium]
Will using drm_atomic_helper_plane_compare_state() trigger false mismatch
warnings whenever zpos !=3D normalized_zpos or a plane is cropped?

tidss_plane_create() initializes each plane's default zpos to its global
plane index (0, 1, 2, ...), whereas drm_atomic_normalize_zpos() normalizes
normalized_zpos per CRTC starting from 0.  Whenever plane 1 (such as the
primary plane on a second CRTC) or an overlay plane is enabled without all
lower-numbered planes on the same CRTC, expected->zpos differs from
normalized_zpos and STATE_CHECK_U32() on zpos in
drm_atomic_helper_plane_compare_state() fails.

Similarly, when a plane uses source cropping or non-zero src_x/src_y offset=
s,
tidss_plane_readout_fb() sets fb->width and fb->height from
DISPC_VID_PICTURE_SIZE (the cropped source dimensions) and
tidss_plane_atomic_readout_state() leaves src_x and src_y at 0, causing
drm_atomic_helper_plane_compare_state() to warn on fb->width, fb->height,
src_x, src_y, and src.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-drm-state-=
readout-v8-0-cbe78624e1bc@kernel.org?part=3D35
