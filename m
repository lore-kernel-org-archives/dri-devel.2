Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B02CC44539
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 14:08:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7372C10EDD2;
	Wed, 22 Jul 2026 14:08:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UBESPOzN";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B81E10EDD2
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 14:08:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 88FEC600C3;
 Wed, 22 Jul 2026 14:08:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 296691F00A3A;
 Wed, 22 Jul 2026 14:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784729329;
 bh=wkJU6L3nHkRh40O4uzIDgNpdLAxV/tHAqPneaXdCMMo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UBESPOzNJfBEByd3OINBSK62Z+gaDrzS+dA41ZP4wffJByIxlcflgvAZ7YlZ/ksWO
 hOUJArRVuyeOMcLXfJhxk7HF23MOYjhkUG78qDU/Jh+9xOx2xbG9m4YeqIlzTPdXS6
 vnqxc5ftpcBODm1Q9ZJiwrYdkDcIlBp15vGwt/CrJOBDGFFyVmrpad17x/WIYsba6R
 ljEPJuIyzIY9+9TIxz13/juNsOnYbDOn8hrIfUiJaMZaTP4hksJ8+KUy/O0AvCHHKW
 rN+jvrhHczGySnIvcj0FRjuBWZz3nS0FTv+Vrm9IOBbMNDMGH17MD1XfTaA/NwPqkU
 hMvqXbqrO+CyA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 09/11] drm/amd/display: Check actual state during
 commit_tail
To: "Harry Wentland" <harry.wentland@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260722134607.136293-10-harry.wentland@amd.com>
References: <20260722134607.136293-1-harry.wentland@amd.com>
 <20260722134607.136293-10-harry.wentland@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 14:08:48 +0000
Message-Id: <20260722140849.296691F00A3A@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Build Breakage / Function Prototype Mismatch
- [High] Logic Error overwriting correctly calculated color_space with SRGB=
 during commit_tail
--

--- Patch [9]: [PATCH v4 09/11] drm/amd/display: Check actual state during =
commit_tail ---
commit 7fa51e59a15d532394f2e3959287098fefb48b8d
Author: Harry Wentland <harry.wentland@amd.com>

drm/amd/display: Check actual state during commit_tail

Previously we checked the plane_state->state's plane_color_pipeline
client config when determining whether fill_plane_color_attributes
should run, i.e., whether we had a plane color pipeline and should
use that code for handling fixed matrix properties, or whether we
should look at legacy plane encoding and range.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index e7080880b2211..4f07fe5688262 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -3008,7 +3008,8 @@ STATIC_IFN_KUNIT bool modereset_required(struct drm=
_crtc_state *crtc_state)
>  EXPORT_IF_KUNIT(modereset_required);
> =20
>  STATIC_IFN_KUNIT int
> -fill_plane_color_attributes(const struct drm_plane_state *plane_state,
> +fill_plane_color_attributes(struct drm_atomic_commit *state,
> +			    const struct drm_plane_state *plane_state,
>  			    const enum surface_pixel_format format,
>  			    enum dc_color_space *color_space)
>  {

[Severity: High]
Will this break the build when CONFIG_DRM_AMD_DC_KUNIT_TEST is enabled?

The old prototype remains in drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_d=
m.h:

    int fill_plane_color_attributes(const struct drm_plane_state *plane_sta=
te,
                                    const enum surface_pixel_format format,
                                    enum dc_color_space *color_space);

And the KUnit tests still call the function with 3 arguments:

drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c:dm_test_fill_c=
olor_attr_rgb_format() {
    ...
    ret =3D fill_plane_color_attributes(&plane_state,
                                      SURFACE_PIXEL_FORMAT_GRPH_ARGB8888,
                                      &color_space);
    ...
}

> @@ -3017,7 +3018,7 @@ fill_plane_color_attributes(const struct drm_plane_=
state *plane_state,
>  	*color_space =3D COLOR_SPACE_SRGB;
> =20
>  	/* Ignore properties when DRM_CLIENT_CAP_PLANE_COLOR_PIPELINE is set */
> -	if (plane_state->state && plane_state->state->plane_color_pipeline)
> +	if (state && state->plane_color_pipeline)
>  		return 0;

[Severity: High]
Could this unintentionally overwrite the correctly calculated color_space w=
ith
COLOR_SPACE_SRGB during commit_tail?

Because *color_space is initialized to COLOR_SPACE_SRGB before the early
return, when the color pipeline is active, fill_plane_color_attributes() se=
ts
plane_info->color_space to COLOR_SPACE_SRGB.

Later, DC core's copy_surface_update_to_plane() unconditionally copies this
value to surface->color_space:

drivers/gpu/drm/amd/display/dc/core/dc.c:copy_surface_update_to_plane() {
    ...
    if (srf_update->plane_info) {
        surface->color_space =3D
                srf_update->plane_info->color_space;
    ...
}

Can this clobber the fixed matrix value calculated during atomic check,
causing YUV-to-RGB conversion to be bypassed for YUV framebuffers?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722134607.1362=
93-1-harry.wentland@amd.com?part=3D9
