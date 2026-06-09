Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EDEDCD8C92
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 12:51:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 894D510E5B1;
	Tue,  9 Jun 2026 12:51:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="F/bA83P0";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3762210E5B1
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 12:51:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AF993601D6;
 Tue,  9 Jun 2026 12:51:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 430E01F00893;
 Tue,  9 Jun 2026 12:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781009499;
 bh=AOi6PcrVlMiCaJpDmXQ54XI0wWNkc0qIUXe6vWTD8vU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=F/bA83P0QDPEbihIMr+gRi+iEtf6DbDBLO9gD7zhoBVGkF8ZxKPXHkhqNSs4imum5
 tud2OSdBHEx2Dvq47pf9wN1q4J4epM/8AOxYi3YBI+Mbv8qBg5gojzN7ezA0b1R6GG
 Hh+SPGoAEGSm+Dozy/Dqmt3+qsmIvQQgimbTFmWFhCZgFZdb8nb9F/wkHbi38AYWk2
 ACHV3mO5SaaFQUm0U86fmSr/asPeszt8QdxQ6WBZSGMHoeH/8jrcaIv8DSBwbvDvcT
 NO6KsRt2vpUhJKoqgHb3wpeZ33o4cg9jMVfa41Wqppj4lx2sAqwVU0zTL/reepmSW4
 JbEO+n+PRgUqw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 6/7] drm/amd/display: fix bnld colorop bypass mode
To: "Melissa Wen" <mwen@igalia.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260609121230.1358786-7-mwen@igalia.com>
References: <20260609121230.1358786-7-mwen@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 12:51:38 +0000
Message-Id: <20260609125139.430E01F00893@smtp.kernel.org>
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

Pre-existing issues:
- [High] Silent failure and invalid hardware state when an active 1D LUT ha=
s an invalid data blob size.
- [High] The return value of `__set_input_tf_32()` is ignored, masking pote=
ntial memory allocation failures.
- [Medium] The validation logic for the 1D LUT colorop incorrectly checks t=
he `curve_1d_type` property, which is unused and logically invalid for LUTs.
--

commit 43bb295360cf4259492eaea0a93a4e70f5f5599c
Author: Melissa Wen <mwen@igalia.com>
Subject: drm/amd/display: fix bnld colorop bypass mode

If userspace set blnd colorop to bypass, AMD driver skips blnd transfer
function configuration. This patch clarifies the bypass mode setup by initi=
ally
setting the tf type to bypass.

Fixes: 52da8325996b ("drm/amd/display: Add support for sRGB EOTF in BLND bl=
ock")

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/dr=
ivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
> index 4651241433296..2d91d88a45742 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
> @@ -1811,6 +1811,8 @@ __set_dm_plane_colorop_blend(struct drm_plane_state=
 *plane_state,
>  	uint32_t blend_size =3D 0;
>  	int i =3D 0;
> =20
> +	tf->type =3D TF_TYPE_BYPASS;
> +
>  	/* 1D Curve - BLND TF */

[ ... ]

> 	if (!colorop_state->bypass && colorop->type =3D=3D DRM_COLOROP_1D_CURVE =
&&
> 	    (BIT(colorop_state->curve_1d_type) & amdgpu_dm_supported_blnd_tfs)) {
> 		drm_dbg(dev, "Blend TF colorop with ID: %d\n", colorop->base.id);
> 		tf->type =3D TF_TYPE_DISTRIBUTED_POINTS;
> 		tf->tf =3D default_tf =3D amdgpu_colorop_tf_to_dc_tf(colorop_state->cur=
ve_1d_type);
> 		tf->sdr_ref_white_level =3D SDR_WHITE_LEVEL_INIT_VALUE;
> 		__set_input_tf_32(NULL, tf, blend_lut, blend_size);

[Severity: High]
This is a pre-existing issue, but does this mask potential memory allocation
failures?

The return value of __set_input_tf_32() is ignored here, so if it returns an
error, the atomic commit proceeds with incompletely programmed hardware sta=
te.

> 	}
>=20
> 	/* 1D Curve - BLND LUT */

[ ... ]

> 	if (!colorop_state->bypass && colorop->type =3D=3D DRM_COLOROP_1D_LUT &&
> 	    (BIT(colorop_state->curve_1d_type) & amdgpu_dm_supported_blnd_tfs)) {

[Severity: Medium]
This isn't a bug introduced by this patch, but does this improperly validate
the 1D LUT state?

The validation logic incorrectly checks the curve_1d_type property, which is
unused and logically invalid for LUTs. The condition passes by coincidence
because 0 corresponds to DRM_COLOROP_1D_CURVE_SRGB_EOTF, which happens to be
supported by the BLND block.

> 		drm_dbg(dev, "Blend LUT colorop with ID: %d\n", colorop->base.id);
> 		tf->type =3D TF_TYPE_DISTRIBUTED_POINTS;
> 		tf->tf =3D default_tf;
> 		tf->sdr_ref_white_level =3D SDR_WHITE_LEVEL_INIT_VALUE;
> 		blend_lut =3D __extract_blob_lut32(colorop_state->data, &blend_size);
> 		blend_size =3D blend_lut !=3D NULL ? blend_size : 0;
>=20
> 		/* Custom LUT size must be the same as supported size */
> 		if (blend_size =3D=3D colorop->size)
> 			__set_input_tf_32(NULL, tf, blend_lut, blend_size);

[Severity: High]
This is a pre-existing issue, but could this lead to an invalid hardware
state if the sizes do not match?

If a 1D LUT colorop is active but the user provides an improperly sized or
missing data blob, the setup function __set_input_tf_32() is skipped.

However, tf->type is already set to TF_TYPE_DISTRIBUTED_POINTS and the
function returns success (0) instead of an error. This leaves the transfer
function logically active but with uninitialized point data. A similar issue
appears to exist in __set_dm_plane_colorop_shaper() as well.

> 	}
>=20
> 	return 0;
> }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609121230.1358=
786-1-mwen@igalia.com?part=3D6
