Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F96606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 18:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y7nfs9cc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3137E10F07B;
	Tue, 24 Nov 2026 18:36:23 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A0D710F07F;
 Tue, 24 Nov 2026 18:36:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D279C44490;
 Tue, 24 Nov 2026 18:36:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B1231F000CF;
 Tue, 24 Nov 2026 18:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795545375;
 bh=P4lr4/a/AYoqlIUVGGNXunwc3UWQoER6oP2CFOwUnI4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Y7nfs9cc11e8DZtMJnLha7ISjz0kNWogS5L+QZ46jaw7teSw/QKELx2iGWKO3wT/1
 FCDuG+cPgRdNnD0mVX3m0Q53IVStmHf1PjzOZwab+6Vf1QQYbJPwmX3sEVnOYLWKk6
 WZ5pQJqm6Yo+6fDrXSNLw8MTpNGTAiAOisfXNdkosHHG0PHgWaypeqozCViElU8qXD
 LpvqMaVjihe5XTTOsiATkSxMEQP3M3j3HACCHyckxsh90y4Bouzm/WWPOqr/eP8OxR
 kkg4Em9seJsf+kPgL4HJhZL2VBDPT3KGCJn8TzaBke54uieFuRAvWXs3CljXZEJGbl
 XNjVKQR/tqTXg==
Message-ID: <sashiko-outbox-231832@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 11/19] drm/colorop: Introduce colorop helpers for crtc
To: "Melissa Wen" <mwen@igalia.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20261124181652.1333986-12-mwen@igalia.com>
References: <20261124181652.1333986-1-mwen@igalia.com>
 <20261124181652.1333986-12-mwen@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 18:36:14 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Low] drm/colorop: missing @funcs doc in
  drm_crtc_colorop_curve_1d_lut_init()
- [Low] drm/colorop: hardcoded PLANE log prefix in
  drm_colorop_has_supported_tf()
It also noticed 1 related pre-existing issue this patch does not
introduce:
- [High] drm/colorop: missing error cleanup in drm_plane_colorop_init()
  [1]
--

commit 31c092228a64133171c742733eb09f34d70d27f6
Author: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>

drm/colorop: Introduce colorop helpers for crtc

This commit adds CRTC-based colorop initialization helpers for post-blend
1D curve, 1D LUT, and 3x4 CTM color pipelines.

> diff --git a/drivers/gpu/drm/drm_colorop.c b/drivers/gpu/drm/drm_colorop.c
> index baef70460da93..2f62050524b2c 100644
> --- a/drivers/gpu/drm/drm_colorop.c
> +++ b/drivers/gpu/drm/drm_colorop.c
[ ... ]
> @@ -313,6 +328,26 @@ int drm_plane_colorop_curve_1d_init(struct drm_devic=
e *dev,
>  }
>  EXPORT_SYMBOL(drm_plane_colorop_curve_1d_init);
> =20
> +int drm_crtc_colorop_curve_1d_init(struct drm_device *dev,
> +				   struct drm_colorop *colorop,
> +				   struct drm_crtc *crtc,
> +				   const struct drm_colorop_funcs *funcs,
> +				   u64 supported_tfs, uint32_t flags)
> +{
> +	int ret;
> +
> +	ret =3D drm_colorop_has_supported_tf(dev, &crtc->base, crtc->name, supp=
orted_tfs);
> +	if (ret)
> +		return ret;

[Severity: Low]
When drm_colorop_has_supported_tf() rejects supported_tfs here, does it
log the CRTC with a [PLANE:%d:%s] prefix?  Both drm_err() messages in
drm_colorop_has_supported_tf() hardcode [PLANE:%d:%s].

> +
> +	ret =3D drm_crtc_colorop_init(dev, colorop, crtc, funcs, DRM_COLOROP_1D=
_CURVE, flags);
> +	if (ret)
> +		return ret;
> +
> +	return drm_common_colorop_curve_1d_init(dev, colorop, supported_tfs, fl=
ags);
> +}
> +EXPORT_SYMBOL(drm_crtc_colorop_curve_1d_init);

[Severity: High]
This problem wasn't introduced by this patch, but if property creation
fails in drm_common_colorop_init() or in a subtype helper such as
drm_common_colorop_curve_1d_init() [1], does it leave colorop
registered in dev->mode_config.object_idr and linked in
config->colorop_list with colorop->state still NULL?

drm_common_colorop_init() calls drm_mode_object_add() and adds
colorop->head to config->colorop_list before creating the base properties,
while colorop->state is only allocated at the end of the subtype helper by
drm_colorop_reset():

drivers/gpu/drm/drm_colorop.c:drm_common_colorop_init() {
	ret =3D drm_mode_object_add(dev, &colorop->base, DRM_MODE_OBJECT_COLOROP);
	if (ret)
		return ret;
	...
	list_add_tail(&colorop->head, &config->colorop_list);
	colorop->index =3D config->num_colorop++;
	...
	prop =3D drm_property_create_enum(dev,
					DRM_MODE_PROP_IMMUTABLE,
					"TYPE", drm_colorop_type_enum_list,
					ARRAY_SIZE(drm_colorop_type_enum_list));

	if (!prop)
		return -ENOMEM;
}

If any property allocation fails, neither drm_common_colorop_init() nor
the subtype helpers unwind the registration, so querying the published
mode object via DRM_IOCTL_MODE_OBJ_GETPROPERTIES will hit a NULL pointer
dereference on colorop->state in drm_atomic_colorop_get_property().

> @@ -402,6 +437,37 @@ drm_plane_colorop_curve_1d_lut_init(struct drm_devic=
e *dev,
>  }
>  EXPORT_SYMBOL(drm_plane_colorop_curve_1d_lut_init);
> =20
> +/**
> + * drm_crtc_colorop_curve_1d_lut_init - Initialize a DRM_COLOROP_1D_LUT
> + *
> + * @dev: DRM device
> + * @colorop: The drm_colorop object to initialize
> + * @crtc: The associated drm_crtc
> + * @lut_size: LUT size supported by driver
> + * @interpolation: 1D LUT interpolation type
> + * @flags: bitmask of misc, see DRM_COLOROP_FLAG_* defines.
> + * @return zero on success, -E value on failure
> + */
> +int
> +drm_crtc_colorop_curve_1d_lut_init(struct drm_device *dev,
> +				   struct drm_colorop *colorop,
> +				   struct drm_crtc *crtc,
> +				   const struct drm_colorop_funcs *funcs,

[Severity: Low]
The kernel-doc comment for drm_crtc_colorop_curve_1d_lut_init() omits the
@funcs parameter description (and uses @return instead of Return:), which
triggers a scripts/kernel-doc warning when building documentation or with
W=3D1.

[1] https://sashiko.dev/#/bug/linux-e4f43398-10d0-4ccc-944b-469733dc5b85

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124181652.1333=
986-1-mwen@igalia.com?part=3D11
