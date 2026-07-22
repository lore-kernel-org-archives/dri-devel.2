Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D909C44536
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 18:45:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 747EF10E3D5;
	Wed, 22 Jul 2026 18:45:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Fp/xlCmI";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0759610E3D5
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 18:45:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2F9EE600B0;
 Wed, 22 Jul 2026 18:45:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEB581F00A3E;
 Wed, 22 Jul 2026 18:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784745899;
 bh=1rTEBSkZK/hC9dCFHQWyWHl4Hjv4HIdOq350Z8B1X5Y=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Fp/xlCmINWCVwFgyCmBvuKr3/uSjRoKJJShUdz5amkQ0aGXOYS+n0pR53mEMvl8Pj
 2Q8dkMKzMrsqiY8dBMHf/gYpNRMyZH9UT8RRTpw7XpO8uSihMI8D1ErOGRpT5mVMQp
 +8prBcrlfaBgMTUih/blNJRecyRuwDIHfpoAWWCalmYMRSOCWKPI8JvsTFEC5FEC/w
 uEtL8vIkaNt23A+3jVAF4C338LAFaqUOjmNH18781S2mU11t82zkqABcFyW1GnOhpz
 kBKhEsISVM5F7ixg9igfPBhe++aBT8ee8RFfR1DcYOwCO5y8aN4Q7sktNHqE4ASWAZ
 Qf1ZyGEcThisA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amd/display: fix missing blend-mode-prop warning
To: "Melissa Wen" <mwen@igalia.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260722183240.626522-1-mwen@igalia.com>
References: <20260722183240.626522-1-mwen@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 18:44:59 +0000
Message-Id: <20260722184459.AEB581F00A3E@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The patch leaves the blend mode warning unresolved for most DCE =
platforms, and incorrectly advertises unsupported blend modes for DCE110 pr=
imary planes.
--

--- Patch [1]: [PATCH] drm/amd/display: fix missing blend-mode-prop warning=
 ---
commit 5b22da875a02b052ccb2b1f44b116e2e68afa2f7
Author: Melissa Wen <mwen@igalia.com>

    drm/amd/display: fix missing blend-mode-prop warning

    validate_blend_mode_for_alpha_formats() warns when a plane supports
    formats with alpha but doesn't expose the blend mode property. Fix this
    by adding the same blend modes to primary plane, since they are all
    universal planes in DCN-generation. Cursor planes support ARGB8888
    format and CURSOR_MODE_COLOR_PRE_MULTIPLIED_ALPHA is set by default
    (other color formats are not implemented), so only expose support to
    PREMULTI, which is the default blend mode on DRM.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/dr=
ivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> index 26f35434a92f0..9a41cdd39ccf0 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> @@ -1932,7 +1932,12 @@ int amdgpu_dm_plane_init(struct amdgpu_display_man=
ager *dm,
>  	if (res)
>  		return res;
> =20
> -	if (plane->type =3D=3D DRM_PLANE_TYPE_OVERLAY &&
> +	/* TODO: per_pixel_alpha is not set to DCE planes. Check what blend
> +	 * modes are supported in DCE-generation planes, i.e.
> +	 * DC_PLANE_TYPE_DCE_RGB and expose blend mode property accordingly.
> +	 */
> +	if ((plane->type =3D=3D DRM_PLANE_TYPE_OVERLAY ||
> +	     plane->type =3D=3D DRM_PLANE_TYPE_PRIMARY) &&
>  	    plane_cap && plane_cap->per_pixel_alpha) {
>  		unsigned int blend_caps =3D BIT(DRM_MODE_BLEND_PIXEL_NONE) |
>  					  BIT(DRM_MODE_BLEND_PREMULTI) |
> @@ -1940,6 +1945,13 @@ int amdgpu_dm_plane_init(struct amdgpu_display_man=
ager *dm,
> =20
>  		drm_plane_create_alpha_property(plane);
>  		drm_plane_create_blend_mode_property(plane, blend_caps);

[Severity: Medium]
Will this leave the blend mode warning unresolved for most DCE platforms, a=
nd
incorrectly advertise unsupported blend modes for DCE110 primary planes?

On DCE hardware where plane_cap->per_pixel_alpha is 0 (such as DCE100 and
DCE112), amdgpu_dm_plane_get_plane_formats() still unconditionally exposes
DRM_FORMAT_ARGB8888. Because of this, the DRM core's
validate_blend_mode_for_alpha_formats() will continue to warn on boot since
the plane has an alpha format but no blend mode property.

Additionally, on DCE110 where per_pixel_alpha is 1, this patch attaches the
blend mode property with PREMULTI, COVERAGE, and NONE. However, does the DCE
hardware sequencer (dce_set_blender_mode) ignore
plane_state->pre_multiplied_alpha and hardcode alpha blending? If so, the
advertised blend modes will silently fail to work, which violates the API
contract.

> +	} else if (plane->type =3D=3D DRM_PLANE_TYPE_CURSOR) {
> +		/* Cursor color format is set to
> +		 * CURSOR_MODE_COLOR_PRE_MULTIPLIED_ALPHA by default, so only
> +		 * advertise DRM_MODE_BLEND_PREMULTI blend mode for this type
> +		 * of plane.
> +		 */
> +		drm_plane_create_blend_mode_property(plane, BIT(DRM_MODE_BLEND_PREMULT=
I));
>  	}
> =20
>  	if (plane->type =3D=3D DRM_PLANE_TYPE_PRIMARY) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722183240.6265=
22-1-mwen@igalia.com?part=3D1
