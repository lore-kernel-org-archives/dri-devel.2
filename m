Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA9C3C9832F
	for <dri-devel@archiver.kernel.org>; Sun, 27 Sep 2026 18:43:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3794C10E6A5;
	Sun, 27 Sep 2026 18:43:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EXhxmQLc";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 101B210E69D
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 18:43:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AA9A0401B5;
 Sun, 27 Sep 2026 18:43:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A23E1F000FF;
 Sun, 27 Sep 2026 18:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790534634;
 bh=MiJLK9zfspIDuGEFEkEd1odTJlaz+JjS18bqAnJlqD4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=EXhxmQLcnEPxyQ329Xll86lj/lCUlnib5aDytwCHLtX/xwA2lYVtiS3ff7Ao6+JCr
 yjjmQE68YOqDv7THwA4/cD4/wFtvtsYdfnR53dPINaYe5x+TxTIyCmoqNV1R1A2AZG
 4xm04d4ViGnlvBC8/5oIqEaBgGKpW2N8twissbiYW7daDVNJfpGPEXDTBjLIQfkf1K
 5F9pNXuWVhEf2MbdvbkL4tSr6JJNdBaRhlUry1lyl9QoM8vDUBQ8TEusDQ0ob3QT/P
 inmwDeSJaacwzSe/0mvJXn8pJQ+eHvY7kj20OS5e9285ebFxjuomHpl2+JwN7FFVqe
 LslzX+Cw26UEQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 08/14] drm/solomon: ssd16xx: Expose refresh mode as
 plane property
To: "Devarsh Thakkar" <devarsht@ti.com>
Cc: robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260927182329.4193961-9-devarsht@ti.com>
References: <20260927182329.4193961-1-devarsht@ti.com>
 <20260927182329.4193961-9-devarsht@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 27 Sep 2026 18:43:53 +0000
Message-Id: <20260927184354.4A23E1F000FF@smtp.kernel.org>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] drm/ssd16xx: hardware desync when refresh_mode is updated on disab=
led plane
- [High] drm/ssd16xx: double vunmap risk due to kmemdup of shadow plane sta=
te
- [Low] drm/ssd16xx: build failure due to undefined __drm_gem_shadow_plane_=
state_init
--

commit f164596b389c43d5ba1998c30d9e04e66112e4d1
Author: Devarsh Thakkar <devarsht@ti.com>

drm/solomon: ssd16xx: Expose refresh mode as plane property

This commit adds a DRM plane property "refresh_mode" to allow userspace
to select between partial, full, and fast display update modes at runtime.
It uses an enum to match the internal refresh modes and updates the
default setting from the panel configuration.

> diff --git a/drivers/gpu/drm/solomon/ssd16xx.c b/drivers/gpu/drm/solomon/=
ssd16xx.c
> index 6255f434248ae..dc2b8fe536af3 100644
> --- a/drivers/gpu/drm/solomon/ssd16xx.c
> +++ b/drivers/gpu/drm/solomon/ssd16xx.c
[ ... ]
> @@ -1397,11 +1409,91 @@ static void ssd16xx_plane_destroy(struct drm_plan=
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
> +	ssd_state =3D kzalloc(sizeof(*ssd_state), GFP_KERNEL);
> +	if (!ssd_state)
> +		return ERR_PTR(-ENOMEM);
> +
> +	__drm_gem_shadow_plane_state_init(plane, &ssd_state->base);

[Severity: Low]
Does this cause a build failure? It appears __drm_gem_shadow_plane_state_in=
it()
is not defined anywhere in the kernel.

If the module were somehow compiled, would failing to initialize the base
plane state leave plane_state->plane as NULL and cause a NULL pointer
dereference in the core DRM atomic helpers?

> +	ssd_state->refresh_mode =3D device->refresh_mode;
> +
> +	return &ssd_state->base.base;
> +}
> +
> +static struct drm_plane_state *
> +ssd16xx_plane_atomic_duplicate_state(struct drm_plane *plane)
> +{
> +	struct ssd16xx_plane_state *old_ssd_state, *ssd_state;
> +
> +	if (WARN_ON(!plane->state))
> +		return NULL;
> +
> +	old_ssd_state =3D to_ssd16xx_plane_state(plane->state);
> +	ssd_state =3D kmemdup(old_ssd_state, sizeof(*ssd_state), GFP_KERNEL);

[Severity: High]
Does this kmemdup() risk a double free or double unmap of the shadow plane
state?

The struct drm_shadow_plane_state contains map and data arrays which track
active kernel memory mappings of the framebuffer. These are explicitly
documented as "Transitional state - do not export or duplicate".

If the new state encounters an error before drm_gem_begin_shadow_fb_access()
overwrites them, won't the error cleanup paths unmap those stale pointers,
resulting in a double vunmap of the old state's memory?

> +	if (!ssd_state)
> +		return NULL;
> +
> +	__drm_gem_duplicate_shadow_plane_state(plane, &ssd_state->base);
> +	return &ssd_state->base.base;
> +}
[ ... ]
> @@ -1456,6 +1550,25 @@ static void ssd16xx_plane_atomic_update(struct drm=
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

[Severity: High]
Can this hardware configuration desynchronize from the software state, lead=
ing
to a missing LUT preload and corrupted display output?

Earlier in ssd16xx_plane_atomic_update(), there is an early return when the
plane is being disabled:

    if (!fb)
        return;

If a userspace atomic commit disables the plane while simultaneously changi=
ng
the refresh_mode property, won't this early return skip the state
synchronization here?=20

When the plane is later enabled, wouldn't pm_runtime_resume() call
ssd16xx_hw_init(), read the stale device->refresh_mode, and skip the requir=
ed
FAST mode LUT preload?

> +
>  	/*
>  	 * When refresh_mode_init was set, use the specified mode for this first
>  	 * frame only, then restore the user-configured refresh_mode so

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260927182329.4193=
961-1-devarsht@ti.com?part=3D8
