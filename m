Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49586606A31B
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 17:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L8jmFBfT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEB9910E021;
	Thu,  5 Nov 2026 17:07:24 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D3DF10E1AC
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 17:07:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3CBF043497;
 Thu,  5 Nov 2026 17:07:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F09161F000C1;
 Thu,  5 Nov 2026 17:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793898438;
 bh=Kpl8+++8QJGKSdrsjHm4Wy9OAm6wG8uG3+wooafG0KE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=L8jmFBfTZSykGVjmIr1qeuTAW6jB4Cl0JP2SfRJGBUKOCvyzevLenEFC4bVgBkptX
 XdXPr4ZKOzPA61YZMPaDu9bhZVmeNTyk5+Fah7ntXhrft2phzZc+vok3V5IOFuUgxO
 fJrDWUhFWx9/EghbV+q5TdYII3n2v6//5n4gtON/bo8Q4zKFAF9x/zDCMk0jYqtKT3
 xgUJvoQga5aAV6vtLEqoUWXG4f+qVPcfwwfytd7T92v3Rz+s93sjGJPktScDxqkjKi
 CEJqMfUZxkDIeRxZJEGU+NoCyTeZ2uGw84fuv39d4qGLny/6zcICiMln4bKOvMzhFC
 KenIIosFyFrgw==
Message-ID: <sashiko-outbox-199576@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 09/27] drm: Add VRR target frame rate properties
To: "Nicolas Frattaroli" <nicolas.frattaroli@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261105-vrr-limiter-uapi-v2-9-55f4215be2c2@collabora.com>
References: <20261105-vrr-limiter-uapi-v2-0-55f4215be2c2@collabora.com>
 <20261105-vrr-limiter-uapi-v2-9-55f4215be2c2@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 17:07:17 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] drm: missing DRM_MODE_PROP_ATOMIC flag on VRR limiter CRTC prope=
rties
- [Medium] drm: missing min <=3D max VRR rate check in drm_atomic_crtc_chec=
k()
--

commit 221e142e46603679a11c0d1b71599449f1d7a39c
Author: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

drm: Add VRR target frame rate properties

This commit introduces four CRTC properties (VRR_MIN_NUMERATOR,
VRR_MIN_DENOMINATOR, VRR_MAX_NUMERATOR, and VRR_MAX_DENOMINATOR) to allow
userspace to configure a target frame rate range for Variable Refresh Rate
as numerator/denominator fractions.

> diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
> index 9bb761eda59f4..da5c6925c349f 100644
> --- a/drivers/gpu/drm/drm_atomic.c
> +++ b/drivers/gpu/drm/drm_atomic.c
> @@ -489,6 +489,7 @@ EXPORT_SYMBOL(drm_atomic_get_crtc_state);
>  static int drm_atomic_crtc_check(const struct drm_crtc_state *old_crtc_s=
tate,
>  				 const struct drm_crtc_state *new_crtc_state)
>  {
> +	const struct drm_crtc_vrr_state *vrr =3D &new_crtc_state->vrr_state;
>  	struct drm_crtc *crtc =3D new_crtc_state->crtc;
> =20
>  	/* NOTE: we explicitly don't enforce constraints such as primary
> @@ -544,6 +545,19 @@ static int drm_atomic_crtc_check(const struct drm_cr=
tc_state *old_crtc_state,
>  		return -EINVAL;
>  	}
> =20
> +	/*
> +	 * Reject VRR limiter ranges that only specify one end of the limit, or
> +	 * specify a numerator > 0 with a denominator that is 0.
> +	 */
> +	if ((!vrr->vrr_min_n || !vrr->vrr_min_d ||
> +	     !vrr->vrr_max_n || !vrr->vrr_max_d) &&
> +	    (vrr->vrr_min_n > 0 || vrr->vrr_max_n > 0)) {
> +		drm_dbg_atomic(crtc->dev,
> +			       "[CRTC:%d:%s] incomplete VRR limiter range\n",
> +			       crtc->base.id, crtc->name);
> +		return -EINVAL;
> +	}

[Severity: Medium]
As reported by Sashiko on RFC [1], should drm_atomic_crtc_check() also reje=
ct
inverted VRR target frame rate ranges where the minimum rate fraction excee=
ds
the maximum rate fraction?

In include/drm/drm_mode_config.h, the kerneldoc for struct drm_mode_config
documents that prop_vrr_max_numerator divided by prop_vrr_max_denominator m=
ust
result in a frame rate equal to or above prop_vrr_min_numerator divided by
prop_vrr_min_denominator.

However, drm_atomic_crtc_check() only checks that all four values are non-z=
ero
when either numerator is positive. If userspace submits an atomic commit via
DRM_IOCTL_MODE_ATOMIC with non-zero limiter values where vrr_min_n / vrr_mi=
n_d
is greater than vrr_max_n / vrr_max_d (for example while vrr_enabled is fal=
se,
or on a non-HDMI connector), the check succeeds and commits the inverted ra=
nge
into drm_crtc_state.

Would it make sense to check:

    mul_u32_u32(vrr->vrr_min_n, vrr->vrr_max_d) >
    mul_u32_u32(vrr->vrr_max_n, vrr->vrr_min_d)

when the limiter range is non-zero in drm_atomic_crtc_check()?

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
> +	if (!prop)
> +		return -ENOMEM;
> +	dev->mode_config.prop_vrr_min_numerator =3D prop;
> +
> +	prop =3D drm_property_create_range(dev, 0, "VRR_MIN_DENOMINATOR", 0, U3=
2_MAX);
> +	if (!prop)
> +		return -ENOMEM;
> +	dev->mode_config.prop_vrr_min_denominator =3D prop;
> +
> +	prop =3D drm_property_create_range(dev, 0, "VRR_MAX_NUMERATOR", 0, U32_=
MAX);
> +	if (!prop)
> +		return -ENOMEM;
> +	dev->mode_config.prop_vrr_max_numerator =3D prop;
> +
> +	prop =3D drm_property_create_range(dev, 0, "VRR_MAX_DENOMINATOR", 0, U3=
2_MAX);
> +	if (!prop)
> +		return -ENOMEM;
> +	dev->mode_config.prop_vrr_max_denominator =3D prop;

[Severity: Medium]
As reported by Sashiko on RFC [2], should these four properties be created
with the DRM_MODE_PROP_ATOMIC flag in drm_mode_create_standard_properties()?

Because flags is passed as 0 to drm_property_create_range(),
drm_mode_object_get_properties() exposes these properties to legacy non-ato=
mic
userspace clients. Non-atomic clients update properties one at a time via
DRM_IOCTL_MODE_OBJ_SETPROPERTY:

    drm_mode_obj_set_property_ioctl()
      -> set_property_atomic()
        -> drm_atomic_commit()
          -> drm_atomic_check_only()
            -> drm_atomic_crtc_check()

Since drm_atomic_crtc_check() rejects any state where only part of the
limiter range is non-zero with -EINVAL, a legacy client cannot transition
from (0, 0, 0, 0) to an active range or clear an active range back to
(0, 0, 0, 0) one property at a time without failing on the intermediate
commits.

[1] https://lore.kernel.org/r/20260921-vrr-limiter-uapi-v1-13-2fcd7d011646@=
collabora.com
[2] https://lore.kernel.org/r/20260921-vrr-limiter-uapi-v1-13-2fcd7d011646@=
collabora.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-vrr-limite=
r-uapi-v2-0-55f4215be2c2@collabora.com?part=3D9
