Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FDE2C982E6
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 16:14:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D459010E5DE;
	Mon, 21 Sep 2026 16:14:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Mnd8xuTM";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A607310E5DE
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 16:14:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2A87B60120;
 Mon, 21 Sep 2026 16:14:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC93E1F000FF;
 Mon, 21 Sep 2026 16:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790007244;
 bh=BK5lzVVFh2Qk/cMVWO9c83J7/66yeIBqPn4ObPCKs5I=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Mnd8xuTMH4f2GbeQFngZ2QssYvnG5s73JM7hrL+p5dpFStS8yYFk6wREFiOsKXtub
 JUcihQDVNlUlPPRgNhESqLOMWNDlL6C5kIRys0b76Cnc0q82fCJAe5fJLdBs5u64kQ
 R4LQL/5Me/ts70raBXmcVkxpA5jvaR+wP1Iz0zeDmtnikLgNI86LUtDOIxV2z6uRMF
 9pc/iVILDQUlPOWyJtxYTVqjjH/PQ85HVmFhOcziTEyDlZMgAyjBjOYxVRWXEgfkeU
 2qnIKIgmEy0qgi6OkXECpPOx8Tpy7twXqzvn2GUQcqRU5Jd5j0M9cu23AaO1trqIk6
 5Sw65CHg+jh0Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 13/25] drm: Add VRR target frame rate properties
To: "Nicolas Frattaroli" <nicolas.frattaroli@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260921-vrr-limiter-uapi-v1-13-2fcd7d011646@collabora.com>
References: <20260921-vrr-limiter-uapi-v1-0-2fcd7d011646@collabora.com>
 <20260921-vrr-limiter-uapi-v1-13-2fcd7d011646@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 16:14:04 +0000
Message-Id: <20260921161404.AC93E1F000FF@smtp.kernel.org>
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
- [Medium] drm: Missing DRM core validation for VRR target properties
- [Medium] drm: Missing DRM_MODE_PROP_ATOMIC flag on multi-part VRR target =
properties
- [Low] drm: Redundant bounds check for VRR target properties in drm_atomic=
_crtc_set_property
--

commit 5c8aa8fe0326bb376d279373eb0661cd2fcc114e
Author: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Subject: drm: Add VRR target frame rate properties

This commit introduces new VRR target frame rate properties, allowing
user-space to set a target refresh rate range. The rates are expressed as
rational fractions using numerators and denominators. It adds the UAPI
properties, validation fields, and attaches them to CRTC objects.

> diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atom=
ic_uapi.c
> index 1eebcf6f5e05b..c9eb01d740b3e 100644
> --- a/drivers/gpu/drm/drm_atomic_uapi.c
> +++ b/drivers/gpu/drm/drm_atomic_uapi.c
> @@ -420,6 +420,22 @@ static int drm_atomic_crtc_set_property(struct drm_c=
rtc *crtc,
>  		return ret;
>  	} else if (property =3D=3D config->prop_vrr_enabled) {
>  		state->vrr_enabled =3D val;
> +	} else if (property =3D=3D config->prop_vrr_min_numerator) {
> +		if (val > U32_MAX)
> +			return -EINVAL;

[Severity: Low]
Is this manual bounds check necessary? Since this is a range property creat=
ed
with limits of 0 to U32_MAX, the DRM core's drm_property_change_valid_get()
should already validate val before reaching drm_atomic_crtc_set_property(),
making this check redundant.

> +		state->vrr_state.vrr_min_n =3D val;
> +	} else if (property =3D=3D config->prop_vrr_min_denominator) {
> +		if (val > U32_MAX)
> +			return -EINVAL;
> +		state->vrr_state.vrr_min_d =3D val;

[Severity: Medium]
Could this lack of validation allow structurally invalid states? The UAPI
documentation states the denominator must not be zero if the numerator is
non-zero. By accepting the denominator without validating it against the
numerator here, this constraint isn't enforced in the DRM core.

Could this cause drivers implementing VRR to hit divide-by-zero crashes if
they don't manually validate these constraints themselves?

[ ... ]

> diff --git a/drivers/gpu/drm/drm_mode_config.c b/drivers/gpu/drm/drm_mode=
_config.c
> index 48a56f23dadbb..da967d60f832a 100644
> --- a/drivers/gpu/drm/drm_mode_config.c
> +++ b/drivers/gpu/drm/drm_mode_config.c
> @@ -535,6 +535,26 @@ static int drm_mode_create_standard_properties(struc=
t drm_device *dev)
>  		return -ENOMEM;
>  	dev->mode_config.prop_vrr_enabled =3D prop;
> =20
> +	prop =3D drm_property_create_range(dev, 0, "VRR_MIN_NUMERATOR", 0, U32_=
MAX);

[Severity: Medium]
Should these multi-part properties be created with the DRM_MODE_PROP_ATOMIC
flag? Without it, they are exposed to legacy user-space applications.

Since legacy userspace updates properties one at a time using
drm_mode_obj_set_property_ioctl(), setting a non-zero numerator will
immediately trigger a commit while the denominator is still 0. This
passes an invalid intermediate state to the driver, causing it to reject the
modeset and making it impossible for legacy userspace to configure a target
rate.

> +	if (!prop)
> +		return -ENOMEM;
> +	dev->mode_config.prop_vrr_min_numerator =3D prop;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921-vrr-limite=
r-uapi-v1-0-2fcd7d011646@collabora.com?part=3D13
