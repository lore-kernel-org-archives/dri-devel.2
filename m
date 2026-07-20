Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A872CC4452A
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 14:43:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 104A310E976;
	Mon, 20 Jul 2026 14:43:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WgB8DITK";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D62310E976
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 14:43:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8E529601DE;
 Mon, 20 Jul 2026 14:43:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 251511F00A3D;
 Mon, 20 Jul 2026 14:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784558637;
 bh=zC+DF0ddq6OpasCImTJTgGb27ZlmDPQY7I35orb/hGk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=WgB8DITKwz8lOdi4gUX7ihOv5V3D6D+KtvyCjjpXHmQNiN3c3P5KWg5M1jbnTfMzf
 Au09jEXVHDKYV02F0PBYsae5T9PaxJ/oY9F8ICh2Xi5HbZ66QV5gs2Pqv1b5XALZuc
 E4ZkrA17kFsEioE9Dwilc/0mMJrIzi06XkLphKMx6j3ihfwHC2kroszyyCIu1aKIKA
 RVjTRmg1cASY5SOPMVCtipTryltK/q7uEejP7yx7i6kEZ81rMgBa0ndUD+EnuYYx2c
 C955cz+5lkh2Z90mcvR8afayYYgMNCjuyXVSVZoWvXArlRk/DA51MjMqygCb7g/jJ4
 0DiLdw9ehKVdw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] drm/amdgpu: Convert tiling flags to modifiers on
 GFX6-8
To: =?utf-8?b?VGltdXIgS3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260720142440.22076-3-timur.kristof@gmail.com>
References: <20260720142440.22076-1-timur.kristof@gmail.com>
 <20260720142440.22076-3-timur.kristof@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 14:43:55 +0000
Message-Id: <20260720144357.251511F00A3D@smtp.kernel.org>
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
- [High] Missing cpp factor in GFX6 block size calculation enables out-of-b=
ounds VRAM read vulnerability.
- [High] Strict rejection of RENDER microtiling introduces a functional reg=
ression for legacy GFX6 compositors.
- [Low] Usage of undefined/DC-specific ASSERT macro in generic AMDGPU code =
causes build failures or macro misuse.
--

--- Patch [2]: [PATCH 2/4] drm/amdgpu: Convert tiling flags to modifiers on=
 GFX6-8 ---
commit 44a2b5305f951bc68d3e2665bc5db9defc35dd24
Author: Timur Krist=C3=B3f <timur.kristof@gmail.com>
Subject: drm/amdgpu: Convert tiling flags to modifiers on GFX6-8

This commit converts tiling flags to DRM format modifiers for AMD GFX8 and
older GPUs, ensuring consistency across generations and allowing the display
driver to rely on them. It includes logic to map array modes to modifiers a=
nd
verify block sizes for GFX6 specifically.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_display.c
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c

[ ... ]

> +	if (array_mode !=3D AMD_FMT_MOD_TILE_GFX6_1D_TILED_THIN1 &&
> +	    array_mode !=3D AMD_FMT_MOD_TILE_GFX6_2D_TILED_THIN1) {
> +		drm_dbg_kms(dev, "Array mode %u not supported by display driver\n", ar=
ray_mode);
> +		return -EINVAL;
> +	}
> +	if (micro_tile_mode !=3D AMD_FMT_MOD_MICROTILE_DISPLAY) {
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: High]
Does this break legacy userspace compositors?=20

Looking at check_tiling_flags_gfx6(), it explicitly supports RENDER=20
microtiling (mode 3):

	micro_tile_mode =3D AMDGPU_TILING_GET(afb->tiling_flags, MICRO_TILE_MODE);
	switch (micro_tile_mode) {
	case 0: /* DISPLAY */
	case 3: /* RENDER */
		return 0;

Could returning -EINVAL here for RENDER mode cause a regression for legacy=
=20
clients allocating display buffers for 3D performance?

> +		drm_dbg_kms(dev, "Microtile mode %u not displayable\n", micro_tile_mod=
e);
> +		return -EINVAL;
> +	}

[ ... ]

> @@ -1120,6 +1247,15 @@ static int amdgpu_display_verify_sizes(struct amdg=
pu_framebuffer *rfb)
> =20
>  			get_block_dimensions(block_size_log2, format_info->cpp[i],
>  					     &block_width, &block_height);
> +		} else if (AMD_FMT_MOD_GET(TILE_VERSION, modifier) =3D=3D AMD_FMT_MOD_=
TILE_VER_GFX6) {
> +			ret =3D amdgpu_display_verify_sizes_gfx6(rfb->base.dev, modifier,
> +							       &block_width, &block_height);
> +			if (ret)
> +				return ret;
> +
> +			ASSERT(is_power_of_2(block_width));
                        ^^^^^^

[Severity: Low]
Are these ASSERT() macros defined in this context?=20

ASSERT is typically a Display Core (DC) specific macro (from dc/os_types.h)=
.=20
Since amdgpu_display.c is part of the core driver, would WARN_ON() be more=
=20
appropriate here to avoid potential build failures?

> +			ASSERT(is_power_of_2(block_height));
> +			block_size_log2 =3D ilog2(block_width * block_height);
                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: High]
Should this calculation include the bytes-per-pixel factor?=20

By omitting the format_info->cpp[i] multiplier, block_size_log2 appears to=
=20
underestimate the block size.=20

When this is later passed into amdgpu_display_verify_plane(), it calculates:

	unsigned int block_size =3D 1 << block_size_log2;
        ...
	size =3D rfb->base.offsets[plane] +
		(uint64_t)rfb->base.pitches[plane] / block_pitch *
		block_size * DIV_ROUND_UP(height, block_height);

	if (rfb->base.obj[0]->size < size) {

An underestimated block_size results in a vastly smaller size requirement,=
=20
which might allow an undersized Buffer Object to pass validation,=20
potentially leading to out-of-bounds VRAM reads.

>  		}
> =20
>  		ret =3D amdgpu_display_verify_plane(rfb, i, format_info,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720142440.2207=
6-1-timur.kristof@gmail.com?part=3D2
