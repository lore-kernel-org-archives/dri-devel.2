Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85812C4453A
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 17:34:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D082D10E430;
	Wed, 22 Jul 2026 17:34:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JNUOrjAa";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B5D110E0C9
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 17:34:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 236F1404C1;
 Wed, 22 Jul 2026 17:34:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF3FA1F000E9;
 Wed, 22 Jul 2026 17:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784741694;
 bh=8lar/GkQ79FGrJmRnc4iJXB8AsR5o0eZs9InosMqcYI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JNUOrjAatkj5s16+cXp5U7JRWsLw17RPkU/rboz7qUhKDzxUW9RI7BHoeO2QuwC7v
 1lifkYOMcFr3LtswMe2cHsAdmo3XDnfpiSOvXMb98dbM4e7hV/t0Yz1jBm0y6yvVGf
 MxNgvnF5Ut64zCX08/YsnBANL1yPbAYT35ddqq+2BhcM8yZov0tXglMVfxayp3QTnx
 8VjN/id325ZqSPJRceUrlsuuR3aNrtpMV78AaheTcKBgymtcNNDZkq1zgM2fYTZ5I2
 qKIlf4OPhok2iylLYHs8OzxhaO7y1MWvGLH9BiGTq82Tcw+PfWe1msElkNR+M+/Hhm
 Rh0M94/4uZ8bQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] drm/amd/display: Don't use tiling flags anymore
To: =?utf-8?b?VGltdXIgS3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260722165925.15805-5-timur.kristof@gmail.com>
References: <20260722165925.15805-1-timur.kristof@gmail.com>
 <20260722165925.15805-5-timur.kristof@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 17:34:53 +0000
Message-Id: <20260722173453.CF3FA1F000E9@smtp.kernel.org>
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
- [High] Missing 2D tiling format modifier for 8 bpp formats on GFX6-8 brea=
ks NV12/NV21 video playback.
--

--- Patch [4]: [PATCH 4/4] drm/amd/display: Don't use tiling flags anymore =
---
commit 9ecc330329837cba2c5f2f431e911a3b7ec6c4df
Author: Timur Krist=C3=B3f <timur.kristof@gmail.com>
Subject: drm/amd/display: Don't use tiling flags anymore

The commit removes the usage of legacy tiling flags from the amdgpu_dm
display code, transitioning all supported GPU generations to rely
completely on DRM format modifiers. It updates plane attribute filling,
surface updates, and cursor checks to reflect this change.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/dr=
ivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> index a593a44ef97bc..87187c965d55c 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
[ ... ]
> @@ -1235,8 +1201,6 @@ int amdgpu_dm_plane_fill_plane_buffer_attributes(st=
ruct amdgpu_device *adev,
>  										address);
>  		if (ret)
>  			return ret;
> -	} else if (afb->base.modifier =3D=3D DRM_FORMAT_MOD_INVALID) {
> -		amdgpu_dm_plane_fill_gfx8_tiling_info_from_flags(tiling_info, tiling_f=
lags);
>  	} else {
>  		ret =3D amdgpu_dm_plane_fill_gfx6_tiling_info_from_modifier(tiling_inf=
o,
>  									  afb->base.modifier);

[Severity: High]
By removing the legacy tiling flags fallback here, does this break NV12/NV21
video playback on GFX6-8?

Looking at amdgpu_dm_plane_add_gfx6_modifiers(), it appears to add 2D tiled
modifiers only for 16, 32, and 64 bpp:

	amdgpu_dm_plane_add_modifier(mods, size, capacity,
		amdgpu_dm_plane_calc_gfx6_mod(adev, 16, DC_ARRAY_2D_TILED_THIN1));
	amdgpu_dm_plane_add_modifier_dedup(mods, size, capacity,
		amdgpu_dm_plane_calc_gfx6_mod(adev, 32, DC_ARRAY_2D_TILED_THIN1));
	amdgpu_dm_plane_add_modifier_dedup(mods, size, capacity,
		amdgpu_dm_plane_calc_gfx6_mod(adev, 64, DC_ARRAY_2D_TILED_THIN1));

Since the modifier calculation for 8 bpp (which is required for NV12/NV21
formats) is missing, when userspace allocates a 2D-tiled NV12 framebuffer,
won't drm_plane_check_pixel_format() reject the atomic commit since it
cannot find the 8bpp modifier in the plane's advertised list?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722165925.1580=
5-1-timur.kristof@gmail.com?part=3D4
