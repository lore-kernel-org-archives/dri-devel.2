Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E33A9C44508
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 11:08:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1239C10EFD3;
	Wed, 15 Jul 2026 11:08:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Z/Ai7eNM";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D41410EFD3
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 11:08:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 405846111A;
 Wed, 15 Jul 2026 11:08:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF5F01F000E9;
 Wed, 15 Jul 2026 11:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784113702;
 bh=Na/rooKl4CFjWDDBWL5jLTuAIfxCefJVF8OqzS047vg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Z/Ai7eNMF9H3Z4ASa0Eyt9PF/Z7ptNP1FtxhL38+pwsRPe3BeLShKDyo/HHupUCK1
 5lSCqZKrJR3a71j2q7pQdWzkR9N85puU4xhuh/KX/b5S5+O5bETi9N2AfsJD94jwb+
 sr8xvgiI1SC3szNhaQOY7SGosI2ZuRyNQLhnMN7XIyUkDOD01nbHoqr1cx/ANZM+Om
 Au0olOEvXZQ8lk+QS9F0DZGqLvis5bINkkZmXEUnsFQ3L/Hvrl9YcuhMUfrBRo5fgY
 0wG0nGZ79Q/5NsRwsf6TIWctWy4EheirU/7FgYCTBrnLdGNMx9PIdxhaHXzQvEIEhA
 paV3H/Ur44ulg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] drm/amd/display: Support DRM format modifiers on
 GFX6-8
To: =?utf-8?b?VGltdXIgS3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260715105757.13125-4-timur.kristof@gmail.com>
References: <20260715105757.13125-1-timur.kristof@gmail.com>
 <20260715105757.13125-4-timur.kristof@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 11:08:20 +0000
Message-Id: <20260715110821.BF5F01F000E9@smtp.kernel.org>
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
- [High] Missing bit-to-byte conversion in `tile_bytes` calculation.
- [High] NULL pointer dereference in `amdgpu_dm_plane_add_modifier_dedup`.
- [Medium] Missing 8-bpp modifier exposure in `amdgpu_dm_plane_add_gfx6_mod=
ifiers`.
--

--- Patch [3]: [PATCH 3/4] drm/amd/display: Support DRM format modifiers on=
 GFX6-8 ---
commit 3fb28c857b70a3a3413b8818708816df4bf9fc7e
Author: Timur Krist=C3=B3f <timur.kristof@gmail.com>

    drm/amd/display: Support DRM format modifiers on GFX6-8
   =20
    Expose displayable DRM format modifiers based on which
    tiling modes are supported by the GFX block.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/dr=
ivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> index b2507c5de7c86..9d56ce635cbda 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c

[ ... ]

> @@ -180,6 +180,19 @@ STATIC_IFN_KUNIT void amdgpu_dm_plane_add_modifier(u=
int64_t **mods, uint64_t *si
>  }
>  EXPORT_IF_KUNIT(amdgpu_dm_plane_add_modifier);
> =20
> +STATIC_IFN_KUNIT void amdgpu_dm_plane_add_modifier_dedup(uint64_t **mods=
, uint64_t *size,
> +							 uint64_t *cap, uint64_t mod)
> +{
> +	uint64_t i;
> +
> +	for (i =3D 0; i < *size; ++i)
> +		if ((*mods)[i] =3D=3D mod)
> +			return;

[Severity: High]
If a previous call to amdgpu_dm_plane_add_modifier() fails to reallocate the
array, it sets *mods to NULL but leaves *size at its previous non-zero valu=
e:

amdgpu_dm_plane_add_modifier() {
    ...
		if (!new_mods) {
			kfree(*mods);
			*mods =3D NULL;
			return;
		}
    ...
}

Will this loop cause a NULL pointer dereference on the next call to=20
amdgpu_dm_plane_add_modifier_dedup() since it unconditionally evaluates=20
(*mods)[i] without checking if *mods is NULL?

> +
> +	amdgpu_dm_plane_add_modifier(mods, size, cap, mod);
> +}
> +EXPORT_IF_KUNIT(amdgpu_dm_plane_add_modifier_dedup);

[ ... ]

> @@ -468,6 +516,246 @@ static void amdgpu_dm_plane_add_gfx10_1_modifiers(c=
onst struct amdgpu_device *ad

[ ... ]

> +/**
> + * amdgpu_dm_plane_get_gfx7_macro_tile_idx() - Get macro tile mode index=
 on GFX7-8
> + *
> + * @bpp: bits per pixel in the image
> + * @tile_split_bytes: actual tile split bytes, see amdgpu_dm_plane_calc_=
gfx7_tile_split()
> + *
> + * Select which macro tiling mode from the table is suitable for the giv=
en bits per pixel,
> + * assuming 2D_TILED_THIN1 array mode and DISPLAY micro tile mode (and n=
o multisampling).
> + * Note that the tiling table is uAPI and userspace relies on specific m=
odes being
> + * present at specific indices.
> + * See CiLib::HwlComputeMacroModeIndex() in addrlib.
> + */
> +static u32 amdgpu_dm_plane_get_gfx7_macro_tile_idx(const u32 bpp, const =
u32 tile_split_bytes)
> +{
> +	const u32 tile_bytes =3D clamp(8 * 8 * bpp, 64, tile_split_bytes);

[Severity: High]
Does this calculation compute the microtile size in bits instead of bytes?=
=20
Because it lacks a division by 8 (e.g., (8 * 8 * bpp) / 8), the computed=20
tile_bytes is artificially inflated. For a 16bpp format, this would
calculate 1024 instead of 128, leading to an incorrect macro tile index=20
being selected which may cause tiled buffers to be rejected or misrendered=
=20
on GFX7-8.

> +	const u32 macro_tile_idx =3D ilog2(tile_bytes / 64);
> +
> +	WARN_ON(macro_tile_idx >=3D 16);
> +
> +	return macro_tile_idx;
> +}

[ ... ]

> +/**
> + * amdgpu_dm_plane_add_gfx6_modifiers() - Expose modifiers for GFX6-8
> + *
> + * @adev: amdgpu_device pointer
> + * @mods: Pointer to array of format modifiers
> + * @size: Pointer to size of the array
> + * @capacity: Pointer to capacity of the array
> + *
> + * Calculate a DRM format modifier for macro tiled modes for each suppor=
ted
> + * bits per pixel value. Use de-duplication because on some GPUs it may =
happen
> + * that different bpp results in the exact same macro tiling mode, depen=
ding
> + * on the tiling table.
> + *
> + * Also expose a micro tiled only mode. This is less optimal, but suppor=
ted.
> + */
> +static void amdgpu_dm_plane_add_gfx6_modifiers(const struct amdgpu_devic=
e *adev,
> +					       u64 **mods,
> +					       u64 *size,
> +					       u64 *capacity)
> +{
> +	/* 2D tiled displayable */
> +	amdgpu_dm_plane_add_modifier(mods, size, capacity,
> +		amdgpu_dm_plane_calc_gfx6_mod(adev, 16, DC_ARRAY_2D_TILED_THIN1));

[Severity: Medium]
Are we missing the 8-bpp modifier exposure here?

The helper function amdgpu_dm_plane_get_gfx6_tile_idx() explicitly supports=
=20
bpp =3D=3D 8, but we only seem to expose 16, 32, and 64 bpp formats here.=20
Without this, userspace might not be able to negotiate 2D tiling for 8-bpp
formats.

> +	amdgpu_dm_plane_add_modifier_dedup(mods, size, capacity,
> +		amdgpu_dm_plane_calc_gfx6_mod(adev, 32, DC_ARRAY_2D_TILED_THIN1));
> +	amdgpu_dm_plane_add_modifier_dedup(mods, size, capacity,
> +		amdgpu_dm_plane_calc_gfx6_mod(adev, 64, DC_ARRAY_2D_TILED_THIN1));
> +
> +	/* 1D tiled displayable */
> +	amdgpu_dm_plane_add_modifier(mods, size, capacity,
> +		amdgpu_dm_plane_calc_gfx6_mod(adev, 0, DC_ARRAY_1D_TILED_THIN1));
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715105757.1312=
5-1-timur.kristof@gmail.com?part=3D3
