Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06EC3606A31B
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 22:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H5TlxEIn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F8E910ED67;
	Mon, 19 Oct 2026 22:02:56 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABDB410EDD0
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 22:02:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 930674130A;
 Mon, 19 Oct 2026 22:02:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24CDD1F000C4;
 Mon, 19 Oct 2026 22:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792447370;
 bh=1vNr5FO/mm711jaU+jFZYO+lcV7Jij+fa8I1nHyeJMQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=H5TlxEInbHIyivWCEquk1G14tKJE8wJHaiuVuifC9UQzW4mrnpNzyb4WDH1hamBSt
 zhdWI4qFAxTcn3vNWaiWPhRDT1RRIXCYgrh6If6bXekuRalHsGm9fSAl6IFubchI2A
 QvGDKuVQ9xXuBP7wB3t9gjYhvkrYqYnV8BcPHxKLul6bQvc/BgWeGGaOe8e5sZMoyg
 j52+1mTg0WL3O2LmJAschzkXDv6H/U5HVXHdchjNmA8jTdcqrSrqQYvi5MwUkmPcp6
 K5oQAUzDTsppkI2sQ5O+ZMjTyD1w7mLVt6AomUnP22rAhMXp+hushdS/NcLjrgS+Bj
 trVa7BPzcgbVw==
Message-ID: <sashiko-outbox-178288@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 08/14] drm/solomon: ssd16xx: Expose refresh mode as
 plane property
To: "Devarsh Thakkar" <devarsht@ti.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261019213726.4145532-9-devarsht@ti.com>
References: <20261019213726.4145532-1-devarsht@ti.com>
 <20261019213726.4145532-9-devarsht@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 22:02:49 +0000
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] drm/solomon: ssd16xx: missing helper in ssd16xx_plane_atomic_creat=
e_state()
- [High] drm/solomon: ssd16xx: missed fast LUT preload in ssd16xx_plane_ato=
mic_update()
--

commit 5297d32536b98e77de269756d1d61d02dc735b4b
Author: Devarsh Thakkar <devarsht@ti.com>

drm/solomon: ssd16xx: Expose refresh mode as plane property

This commit exposes a "refresh_mode" enum property on the primary plane to
allow userspace to select between partial, full, and fast e-paper display
update modes at runtime. It subclasses drm_shadow_plane_state into
ssd16xx_plane_state and tracks refresh mode transitions in
ssd16xx_plane_atomic_update().

> diff --git a/drivers/gpu/drm/solomon/ssd16xx.c b/drivers/gpu/drm/solomon/=
ssd16xx.c
> index 99f11b7ec03e9..f53c67ae7d317 100644
> --- a/drivers/gpu/drm/solomon/ssd16xx.c
> +++ b/drivers/gpu/drm/solomon/ssd16xx.c
> @@ -397,8 +397,21 @@ struct ssd16xx_device {
>  	u8  *tx_red_buf; /* 1bpp red-channel buffer (3-color panels only) */
>  	u16 *tx_buf9;    /* 9-bit SPI expansion buffer (3-wire mode only) */
>  	u8  spi_buf[64] ____cacheline_aligned; /* DMA-safe buffer for SPI trans=
fers */
> +
> +	struct drm_property *refresh_mode_property;
> +};
> +
> +/* Plane state subclass: refresh_mode lives on the plane, not the connec=
tor,
> + * so plane_atomic_update() can diff against its own old/new state.
> + */
> +struct ssd16xx_plane_state {
> +	struct drm_shadow_plane_state base;
> +	enum ssd16xx_refresh_mode refresh_mode; /* Pending refresh mode */
>  };
> =20
> +#define to_ssd16xx_plane_state(s) \
> +	container_of((s), struct ssd16xx_plane_state, base.base)
> +
>  static inline struct ssd16xx_device *to_ssd16xx_device(struct drm_device=
 *drm)
>  {
>  	return container_of(drm, struct ssd16xx_device, drm);
> @@ -1430,11 +1443,91 @@ static void ssd16xx_plane_destroy(struct drm_plan=
e *plane)
>  	drm_plane_cleanup(plane);
>  }
> =20
> +static void ssd16xx_plane_atomic_destroy_state(struct drm_plane *plane,
> +					       struct drm_plane_state *state);
> +
> +static struct drm_plane_state *ssd16xx_plane_atomic_create_state(struct =
drm_plane *plane)
> +{
> +	struct ssd16xx_device *device =3D plane_to_ssd16xx_device(plane);
> +	struct ssd16xx_plane_state *ssd_state;
> +
> +	ssd_state =3D kzalloc_obj(*ssd_state, GFP_KERNEL);
> +	if (!ssd_state)
> +		return ERR_PTR(-ENOMEM);
> +
> +	__drm_gem_shadow_plane_state_init(plane, &ssd_state->base);
> +	ssd_state->refresh_mode =3D device->refresh_mode;
> +
> +	return &ssd_state->base.base;
> +}

[Severity: High]
Does this compile when CONFIG_DRM_SSD16XX is enabled?

In drivers/gpu/drm/solomon/ssd16xx.c, ssd16xx_plane_atomic_create_state()
calls __drm_gem_shadow_plane_state_init(), which does not exist in
include/drm/drm_gem_atomic_helper.h or anywhere else in the tree:

include/drm/drm_gem_atomic_helper.h:
    void __drm_gem_duplicate_shadow_plane_state(struct drm_plane *plane,
                                                struct drm_shadow_plane_sta=
te *new_shadow_plane_state);
    void __drm_gem_destroy_shadow_plane_state(struct drm_shadow_plane_state=
 *shadow_plane_state);
    void __drm_gem_reset_shadow_plane(struct drm_plane *plane,
                                      struct drm_shadow_plane_state *shadow=
_plane_state);

Should this implement a plane .reset callback calling
__drm_gem_reset_shadow_plane() instead of .atomic_create_state (and drop the
unused forward declaration of ssd16xx_plane_atomic_destroy_state() above)?

[ ... ]

> @@ -1462,6 +1555,8 @@ static void ssd16xx_plane_atomic_update(struct drm_=
plane *plane,
>  	struct drm_plane_state *new_state =3D drm_atomic_get_new_plane_state(st=
ate, plane);
>  	struct drm_shadow_plane_state *shadow_state =3D to_drm_shadow_plane_sta=
te(new_state);
>  	struct ssd16xx_device *device =3D plane_to_ssd16xx_device(plane);
> +	struct ssd16xx_plane_state *new_ssd =3D to_ssd16xx_plane_state(new_stat=
e);
> +	struct ssd16xx_plane_state *old_ssd =3D to_ssd16xx_plane_state(old_stat=
e);
>  	enum ssd16xx_refresh_mode saved_mode;
>  	u8 saved_border_waveform_idx;
>  	struct drm_framebuffer *fb =3D new_state->fb;
> @@ -1495,6 +1590,25 @@ static void ssd16xx_plane_atomic_update(struct drm=
_plane *plane,
> =20
>  	drm_dbg(&device->drm, "plane_atomic_update: calling fb_dirty rect=3D(%d=
,%d)-(%d,%d)\n",
>  		rect.x1, rect.y1, rect.x2, rect.y2);
> +
> +	/* Diff refresh_mode against the plane's own previous state to see
> +	 * whether fast LUT preload is needed.
> +	 */
> +	if (old_ssd->refresh_mode !=3D new_ssd->refresh_mode) {
> +		/*
> +		 * Fast refresh omits LOAD_LUT each update; arm the
> +		 * one-shot flag so LUT is pre-loaded before the first
> +		 * fast frame.
> +		 */
> +		if (new_ssd->refresh_mode =3D=3D SSD16XX_REFRESH_FAST &&
> +		    old_ssd->refresh_mode !=3D SSD16XX_REFRESH_FULL)
> +			device->fast_lut_pending =3D true;
> +		else
> +			device->fast_lut_pending =3D false;
> +	}
> +
> +	device->refresh_mode =3D new_ssd->refresh_mode;
> +
>  	/*
>  	 * When refresh_mode_init was set, use the specified mode for this first
>  	 * frame only, then restore the user-configured refresh_mode so

[Severity: High]
Can ssd16xx_plane_atomic_update() in drivers/gpu/drm/solomon/ssd16xx.c miss
preloading the Mode 1 LUT before executing SSD16XX_REFRESH_FAST?

There appear to be three scenarios where the LUT state and plane state get =
out
of sync:

1. If userspace sets refresh_mode to SSD16XX_REFRESH_FAST while the CRTC is
inactive (where drm_atomic_helper_commit_tail_rpm() passes
DRM_PLANE_COMMIT_ACTIVE_ONLY and skips ssd16xx_plane_atomic_update()), or w=
hen
ssd16xx_plane_atomic_update() returns early before this diff check:

drivers/gpu/drm/solomon/ssd16xx.c:ssd16xx_plane_atomic_update() {
    ...
	if (!fb)
		goto out_exit;

	/* Nothing to draw: don't wake the panel up. */
	if (!drm_atomic_helper_damage_merged(old_state, new_state, &rect))
		goto out_exit;
    ...
}

drm_atomic_helper_swap_state() has already updated plane->state to new_stat=
e,
while device->refresh_mode and device->fast_lut_pending remain unchanged. On
the next commit that actually draws a frame,
ssd16xx_plane_atomic_duplicate_state() copies plane->state, so both
old_ssd->refresh_mode and new_ssd->refresh_mode are SSD16XX_REFRESH_FAST. A=
s a
result, neither ssd16xx_crtc_atomic_enable() -> ssd16xx_hw_init() (which st=
ill
sees the stale device->refresh_mode) nor ssd16xx_plane_atomic_update() (whi=
ch
sees old_ssd->refresh_mode =3D=3D new_ssd->refresh_mode) will preload the f=
ast
LUT.

2. In ssd16xx_plane_atomic_update(), pm_runtime_resume_and_get() is called
before device->refresh_mode is updated from new_ssd->refresh_mode. If the
panel was in SSD16XX_REFRESH_FULL mode and entered runtime suspend, waking =
the
device on a commit that switches from SSD16XX_REFRESH_FULL to
SSD16XX_REFRESH_FAST runs:

pm_runtime_resume_and_get()
  -> ssd16xx_pm_runtime_resume()
    -> ssd16xx_hw_init()

ssd16xx_hw_init() resets the controller (wiping the LUT) and checks
device->refresh_mode =3D=3D SSD16XX_REFRESH_FAST, which is still
SSD16XX_REFRESH_FULL, so it skips the LUT preload. Then
ssd16xx_plane_atomic_update() checks old_ssd->refresh_mode !=3D
SSD16XX_REFRESH_FULL, which is false, and sets device->fast_lut_pending =3D
false even though the controller was just reset.

3. Right below this hunk in ssd16xx_plane_atomic_update(), when
device->init_refresh_pending is true on the first frame, device->refresh_mo=
de
is temporarily overridden with device->refresh_mode_init, but
device->fast_lut_pending is still consumed and cleared before
ssd16xx_fb_dirty() runs:

drivers/gpu/drm/solomon/ssd16xx.c:ssd16xx_plane_atomic_update() {
    ...
	if (device->init_refresh_pending) {
		device->refresh_mode =3D device->refresh_mode_init;
		device->border_waveform_update_idx =3D device->border_waveform_init_idx;
	}

	if (device->fast_lut_pending) {
		ret =3D ssd16xx_preload_fast_lut(device);
		...
		device->fast_lut_pending =3D false;
	}
    ...
}

If refresh_mode_init is SSD16XX_REFRESH_PARTIAL, ssd16xx_fb_dirty() will lo=
ad
the Mode 2 partial LUT for that first frame, overwriting the preloaded Mode=
 1
LUT before subsequent SSD16XX_REFRESH_FAST frames execute.

Would it be more reliable to track what LUT mode is currently loaded in the
hardware (resetting that tracking in ssd16xx_hw_init() and updating it when
ssd16xx_fb_dirty() or ssd16xx_preload_fast_lut() runs), rather than diffing
old_ssd->refresh_mode against new_ssd->refresh_mode?

[ ... ]

> @@ -2057,6 +2194,9 @@ static int ssd16xx_probe(struct spi_device *spi)
>  	if (ret)
>  		return ret;
> =20
> +	ret =3D ssd16xx_plane_create_properties(device);
> +	if (ret)
> +		return ret;
>  	drm_mode_config_reset(drm);
> =20
>  	/*

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019213726.4145=
532-1-devarsht@ti.com?part=3D8
