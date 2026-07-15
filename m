Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B026CC44501
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 11:42:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0293810EFC9;
	Wed, 15 Jul 2026 11:42:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Xf1Ttbvv";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5479E10EFC9
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 11:42:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CB06B4139E;
 Wed, 15 Jul 2026 11:42:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 856321F000E9;
 Wed, 15 Jul 2026 11:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784115758;
 bh=wQjoaO7ElEKJ4IdT9pqWvGpg3Ez/FMOfkg3Sq0p9Wvg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Xf1TtbvvnFNoMJUeAFN9F1/KgWY5pwQbTvWVtLd1sjTvWSEuzQEJTIUhnA18ruVHw
 3UAT/ic+n3/uSaVvYkPhs4uHovJ/JA2+Iuf6HM8QzPiqLOTZxIwCQZjFVRXGsnF0It
 f4sHHkoUasdfodJA3WWRnGYQW26EkwNESNyhAm1g4MHUj8hetXWMs5MpfFxr0MwWZA
 R/jp26DJzm9RB57I/n5XQ3YtzUQVImgcQ/RPU7eyJBPTbtdqkwoVlMEsX9lUyQSj5s
 8G9LB4/n9k4wWuLnBXy8mvxePqfLxhq8W3h6Pw28wT4zbdbvNaNmcO/IED7APDNzqo
 6fapkCIwVD2ng==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] drm/amd/display: Don't use tiling flags anymore
To: =?utf-8?b?VGltdXIgS3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260715105757.13125-5-timur.kristof@gmail.com>
References: <20260715105757.13125-1-timur.kristof@gmail.com>
 <20260715105757.13125-5-timur.kristof@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 11:42:38 +0000
Message-Id: <20260715114238.856321F000E9@smtp.kernel.org>
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
- [High] Removing the `tiling_flags` check in `should_reset_plane` allows f=
ramebuffers with different DCC pitches or dimensions (but identical modifie=
rs) to bypass DRM atomic check validation, leading to hardware corruption a=
nd stale DML calculations during commit.
--

--- Patch [4]: [PATCH 4/4] drm/amd/display: Don't use tiling flags anymore =
---
commit b71fc193d0b1254508d4ef4e5b1e90decbcba27a
Author: Timur Krist=C3=B3f <timur.kristof@gmail.com>

drm/amd/display: Don't use tiling flags anymore

This commit removes all code from amdgpu_dm that dealt with tiling flags,
as all supported GPU generations now support DRM format modifiers. The lega=
cy
non-DC display code still relies on tiling flags.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index c643cc5428577..2f7388c47d02a 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c

[ ... ]

> @@ -4279,7 +4277,6 @@ static void amdgpu_dm_commit_planes(struct drm_atom=
ic_state *state,
> =20
>  		fill_dc_plane_info_and_addr(
>  			dm->adev, new_plane_state,
> -			afb->tiling_flags,
>  			&bundle->plane_infos[planes_count],
>  			&bundle->flip_addrs[planes_count].address,
>  			afb->tmz_surface);

[Severity: High]
Since the return value of fill_dc_plane_info_and_addr() is ignored here,
what happens if DCC validation fails due to missed dimension or pitch
changes?

Could this result in a zero-filled plane_info structure being sent to the
hardware (for example, setting global_alpha to 0) and causing a black
screen?

[ ... ]

> @@ -6248,8 +6245,7 @@ static bool should_reset_plane(struct drm_atomic_st=
ate *state,
>  		new_afb =3D (struct amdgpu_framebuffer *)new_other_state->fb;
> =20
>  		/* Tiling and DCC changes also require bandwidth updates. */
> -		if (old_afb->tiling_flags !=3D new_afb->tiling_flags ||
> -		    old_afb->base.modifier !=3D new_afb->base.modifier)
> +		if (old_afb->base.modifier !=3D new_afb->base.modifier)
>  			return true;
>  	}

[Severity: High]
By removing the tiling_flags check here in should_reset_plane(), how do we
ensure that framebuffers with identical modifiers but different DCC pitches
or dimensions still trigger a validation reset?

If a user-space client flips between two framebuffers with the same format
and source rectangle, but different backing buffer dimensions, it seems
this might bypass DRM atomic check validation.

Could this lead to DC hardware being programmed using stale Display Mode
Logger (DML) calculations and watermarks, resulting in display corruption?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715105757.1312=
5-1-timur.kristof@gmail.com?part=3D4
