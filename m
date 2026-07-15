Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1365AC44501
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 11:10:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6050810EFD9;
	Wed, 15 Jul 2026 11:10:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mYB6DIg9";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63EF310EFD9
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 11:10:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DED3E4192D;
 Wed, 15 Jul 2026 11:10:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0D9F1F000E9;
 Wed, 15 Jul 2026 11:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784113851;
 bh=bD9vkBsPy35lSLZRkJtwFvZldGEfA35ChovNJjRfIuI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mYB6DIg9ORhDizcz0DfZlq7qQTQqjcayxL070n8SRqqoVpxudvWQ8AHaGnE/Dw9C/
 JQxL1r5H3XGwzXHp1N/8Hh/oh41GYxLssVkOMBWyWehED0B8hT3Do0HHeH7KBs0xCa
 9m4Cx9xyPMjo9EGCvvOT9FBnmAVc0G1WSixPDPNHbjDQmrH0ALobw8jeh3CUSfFcxD
 TMqYtjYpEdPDUW0zd6tuUPFeJWBsmk/HBrsUnNmKl4iT88Zmp7jC9V3giB/6r1t4fe
 jKh2aWuq9jB4Tt0OVq1XI3z8fh6vBIUwWws6gkmIuJ34ilqIXD4Z3IFZ4JRqWCblBg
 Scg5NBgld598w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] drm/amdgpu: Convert tiling flags to modifiers on
 GFX6-8
To: =?utf-8?b?VGltdXIgS3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260715105757.13125-3-timur.kristof@gmail.com>
References: <20260715105757.13125-1-timur.kristof@gmail.com>
 <20260715105757.13125-3-timur.kristof@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 11:10:51 +0000
Message-Id: <20260715111051.A0D9F1F000E9@smtp.kernel.org>
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
- [High] Uninitialized variable `block_size_log2` in GFX6 modifier path cau=
ses undefined behavior and potential kernel panic.
- [High] User-controlled `PIPE_CONFIG` in GFX6 modifier can trigger `unreac=
hable()`, leading to kernel panic or undefined behavior.
- [Medium] Unbounded `drm_err()` on invalid GFX6 array mode allows userspac=
e to flood the kernel log.
--

--- Patch [2]: [PATCH 2/4] drm/amdgpu: Convert tiling flags to modifiers on=
 GFX6-8 ---
commit 642125971654c581668fe700356dfbee6905eccc
Author: Timur Krist=C3=B3f <timur.kristof@gmail.com>
Subject: drm/amdgpu: Convert tiling flags to modifiers on GFX6-8

This commit converts the tiling flags to modifiers on GFX8 and older,
so that the DC display driver can rely on them like on newer generations.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_display.c
> index 950937b363fbe..dcca930ed3c04 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c

[ ... ]

> @@ -940,6 +940,55 @@ static int convert_tiling_flags_to_modifier(struct a=
mdgpu_framebuffer *afb)
>  	return 0;
>  }
> =20
> +static int convert_tiling_flags_to_modifier_gfx6(struct amdgpu_framebuff=
er *afb)
> +{
> +	const uint32_t array_mode =3D AMDGPU_TILING_GET(afb->tiling_flags, ARRA=
Y_MODE);
> +	const uint32_t pipe_config =3D AMDGPU_TILING_GET(afb->tiling_flags, PIP=
E_CONFIG);

[ ... ]

> +	switch (array_mode) {
> +	case DC_ARRAY_LINEAR_GENERAL:
> +	case DC_ARRAY_LINEAR_ALLIGNED:
> +		modifier =3D DRM_FORMAT_MOD_LINEAR;
> +		break;
> +
> +	case DC_ARRAY_2D_TILED_THIN1:
> +		/* Macro tiled modes only */
> +		modifier |=3D
> +			AMD_FMT_MOD_SET(PIPE_CONFIG, pipe_config) |
> +			AMD_FMT_MOD_SET(TILE_SPLIT, tile_split) |
> +			AMD_FMT_MOD_SET(BANK_WIDTH, bank_width) |
> +			AMD_FMT_MOD_SET(BANK_HEIGHT, bank_height) |
> +			AMD_FMT_MOD_SET(MACRO_TILE_ASPECT, macro_tile_aspect) |
> +			AMD_FMT_MOD_SET(NUM_BANKS, num_banks);
> +		fallthrough;
> +
> +	case DC_ARRAY_1D_TILED_THIN1:
> +		/* Micro and macro tiled modes */
> +		modifier |=3D
> +			AMD_FMT_MOD |
> +			AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX6) |
> +			AMD_FMT_MOD_SET(TILE, array_mode) |
> +			AMD_FMT_MOD_SET(MICROTILE, micro_tile_mode);
> +		break;
> +
> +	default:
> +		drm_err(&adev->ddev, "array mode 0x%x not supported by DCE\n", array_m=
ode);

[Severity: Medium]
Could this drm_err() be triggered repeatedly by a user space process provid=
ing
an invalid array_mode to DRM_IOCTL_MODE_ADDFB2, flooding the kernel log?

Should this use a rate-limited print or drm_dbg_kms() instead to prevent log
spam from unprivileged users?

> +		return -EINVAL;
> +	}
> +
> +	afb->base.modifier =3D modifier;
> +	afb->base.flags |=3D DRM_MODE_FB_MODIFIERS;
> +	return 0;
> +}

[ ... ]

> @@ -1093,7 +1142,7 @@ static int amdgpu_display_verify_sizes(struct amdgp=
u_framebuffer *rfb)
> =20
>  			get_block_dimensions(block_size_log2, format_info->cpp[i],
>  					     &block_width, &block_height);
> -		} else {
> +		} else if (AMD_FMT_MOD_GET(TILE_VERSION, modifier) >=3D AMD_FMT_MOD_TI=
LE_VER_GFX9) {
>  			int swizzle =3D AMD_FMT_MOD_GET(TILE, modifier);
> =20
>  			switch ((swizzle & ~3) + 1) {
> @@ -1120,6 +1169,60 @@ static int amdgpu_display_verify_sizes(struct amdg=
pu_framebuffer *rfb)
> =20
>  			get_block_dimensions(block_size_log2, format_info->cpp[i],
>  					     &block_width, &block_height);
> +		} else if (AMD_FMT_MOD_GET(TILE_VERSION, modifier) =3D=3D AMD_FMT_MOD_=
TILE_VER_GFX6) {
> +			const u32 display_micro_tile_pitch =3D 32; /* required by DCE */
> +			const u32 micro_tile_width =3D 8;
> +			const u32 micro_tile_height =3D 8;
> +			const u32 micro_tile_mode =3D AMD_FMT_MOD_GET(MICROTILE, modifier);
> +			const u32 array_mode =3D AMD_FMT_MOD_GET(TILE, modifier);
> +			u32 num_banks, bank_width, bank_height, pipe_config, macro_tile_aspec=
t;
> +			u32 num_pipes;
> +
> +			if (AMD_FMT_MOD_GET(DCC, modifier)) {
> +				drm_dbg_kms(rfb->base.dev, "DCC is not displayable on GFX6-8\n");
> +				return -EINVAL;
> +			}
> +			if (array_mode !=3D AMD_FMT_MOD_TILE_GFX6_1D_TILED_THIN1 &&
> +			    array_mode !=3D AMD_FMT_MOD_TILE_GFX6_2D_TILED_THIN1) {
> +				drm_dbg_kms(rfb->base.dev,
> +					"Array mode %u is not supported by the display driver\n",
> +					array_mode);
> +				return -EINVAL;
> +			}
> +			if (micro_tile_mode !=3D AMD_FMT_MOD_MICROTILE_DISPLAY) {
> +				drm_dbg_kms(rfb->base.dev,
> +					"Micro tile mode %u is not displayable on GFX6-8\n",
> +					micro_tile_mode);
> +				return -EINVAL;
> +			}
> +
> +			num_banks =3D 2 << AMD_FMT_MOD_GET(NUM_BANKS, modifier);
> +			bank_width =3D 1 << AMD_FMT_MOD_GET(BANK_WIDTH, modifier);
> +			bank_height =3D 1 << AMD_FMT_MOD_GET(BANK_HEIGHT, modifier);
> +			pipe_config =3D AMD_FMT_MOD_GET(PIPE_CONFIG, modifier);
> +			macro_tile_aspect =3D 1 << AMD_FMT_MOD_GET(MACRO_TILE_ASPECT, modifie=
r);
> +
> +			if (pipe_config >=3D AMD_FMT_MOD_PIPE_CONFIG_P16_32x32_8x16)
> +				num_pipes =3D 16;
> +			else if (pipe_config >=3D AMD_FMT_MOD_PIPE_CONFIG_P8_16x16_8x16)
> +				num_pipes =3D 8;
> +			else if (pipe_config >=3D AMD_FMT_MOD_PIPE_CONFIG_P4_8x16)
> +				num_pipes =3D 4;
> +			else if (pipe_config =3D=3D AMD_FMT_MOD_PIPE_CONFIG_P2)
> +				num_pipes =3D 2;
> +			else
> +				unreachable();

[Severity: High]
Since pipe_config comes from AMD_FMT_MOD_GET(PIPE_CONFIG, modifier), which =
is
user-controlled via the framebuffer modifier, could a user pass a value sma=
ller
than AMD_FMT_MOD_PIPE_CONFIG_P2?

If so, hitting unreachable() here would result in undefined compiler behavi=
or.
With CONFIG_OBJTOOL enabled, it can emit an invalid instruction that immedi=
ately
panics the kernel. If execution falls through, num_pipes remains uninitiali=
zed
and is subsequently used in a multiplication.

> +
> +			if (array_mode < AMD_FMT_MOD_TILE_GFX6_2D_TILED_THIN1) {
> +				block_width =3D display_micro_tile_pitch;
> +				block_height =3D micro_tile_height;
> +			} else {
> +				/* Assume non-PRT macro tiling modes */
> +				block_width =3D num_pipes * micro_tile_width *
> +					      bank_width * macro_tile_aspect;
> +				block_height =3D micro_tile_height * bank_height *
> +					       num_banks / macro_tile_aspect;
> +			}
>  		}
> =20
>  		ret =3D amdgpu_display_verify_plane(rfb, i, format_info,
>  						  block_width, block_height, block_size_log2);

[Severity: High]
Does this pass an uninitialized block_size_log2 into
amdgpu_display_verify_plane()?

It appears block_size_log2 is never set in the new AMD_FMT_MOD_TILE_VER_GFX6
branch just above this call.

Inside amdgpu_display_verify_plane(), this uninitialized value is used in a
shift:
unsigned int block_size =3D 1 << block_size_log2;

If the uninitialized stack garbage causes block_size to evaluate to 0, this
will trigger a divide-by-zero panic on the subsequent modulo check:
if (rfb->base.offsets[plane] % block_size)

Or if it underestimates the BO size, could this lead to out-of-bounds VRAM
access during scanout?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715105757.1312=
5-1-timur.kristof@gmail.com?part=3D2
