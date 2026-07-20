Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25ABEC4452A
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 14:42:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12C4110E974;
	Mon, 20 Jul 2026 14:42:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="R44qySa4";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4503F10E972
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 14:42:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5E2D560A6A;
 Mon, 20 Jul 2026 14:42:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E81121F00A3A;
 Mon, 20 Jul 2026 14:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784558529;
 bh=dQqlFFKFdf+Hw4jSHez4hjapKY4jCaxPPkGUzHiCo6Y=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=R44qySa4/YBYJYZ2exhv9+1KgVzbBFSPLq2sZcQ8Nv9+aTTGafxZXd0KLJe4Qhahc
 Qh7OglBtRHJRv6gji18WwJPqSe0NLIpee32EA28pZIpumz3nGCCUmnDPM8F+3limKF
 ENCv3pLU0EDG+f58yiG1vwrzGmANLlDspyAQTw4R9WwW3mSgYjuuTG0ehW6rG1mzAK
 2feMHtlEyafK7hHBodpGWdmL/2f0zx4sBRDXWvrqrwpXMwHcIv0YgyOxVrSaafNdYl
 Osdrdqonfq8fnA4RzYRg+JzO+CWuNstvY6zNm8nQo8GLrYg19ZKZA7N7/Sv/Jt5SsH
 Tyxw6a3NEWCfA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] drm/amd/display: Support DRM format modifiers on
 GFX6-8
To: =?utf-8?b?VGltdXIgS3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260720142440.22076-4-timur.kristof@gmail.com>
References: <20260720142440.22076-1-timur.kristof@gmail.com>
 <20260720142440.22076-4-timur.kristof@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 14:42:08 +0000
Message-Id: <20260720144208.E81121F00A3A@smtp.kernel.org>
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
- [High] The calculation of `block_size_log2` for GFX6 modifiers computes t=
he log2 of the block's pixel count rather than its byte size, allowing unde=
rsized framebuffers to bypass validation.
- [High] The new format modifier validation rigidly rejects `RENDER` micro-=
tiling mode (value 3), breaking backward compatibility with existing usersp=
ace buffers.
- [Medium] Memory leak in KUnit test `dm_test_get_plane_modifiers` due to a=
n overwritten pointer.
--

--- Patch [3]: [PATCH 3/4] drm/amd/display: Support DRM format modifiers on=
 GFX6-8 ---
commit 4836999b9da380df8ff4cbe5d660f33f0b1bc33d
Author: Timur Krist=C3=B3f <timur.kristof@gmail.com>

drm/amd/display: Support DRM format modifiers on GFX6-8

Expose displayable DRM format modifiers based on which
tiling modes are supported by the GFX block. This patch calculates
and exposes proper macro and micro tiling modes for GFX6-8 hardware.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/dr=
ivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> index 26f35434a92f0..2706b2ea4eae2 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
[ ... ]
> @@ -468,6 +519,249 @@ static void amdgpu_dm_plane_add_gfx10_1_modifiers(c=
onst struct amdgpu_device *ad
[ ... ]
> +/**
> + * amdgpu_dm_plane_gfx6_format_mod_supported() - Check if a modifier is =
supported on GFX6-8
> + *
> + * @adev: amdgpu_device pointer
> + * @bpp: bits per pixel in the image
> + * @modifier: the modifier whose support we check
> + *
> + * On GFX6-8, not all DRM format modifier can be used with all image for=
mats.
> + * Check whether the specified modifier is supported with the given bits=
 per pixel value.
> + */
> +static bool amdgpu_dm_plane_gfx6_format_mod_supported(const struct amdgp=
u_device *adev,
> +						      const u32 bpp,
> +						      const u64 modifier)
> +{
> +	const u32 array_mode =3D AMD_FMT_MOD_GET(TILE, modifier);
> +	const u32 micro_tile_mode =3D AMD_FMT_MOD_GET(MICROTILE, modifier);
> +
> +	if (!IS_AMD_FMT_MOD(modifier))
> +		return false;
> +
> +	/* GFX9 and newer format modifiers are not supported on GFX6-8 yet. */
> +	if (AMD_FMT_MOD_GET(TILE_VERSION, modifier) !=3D AMD_FMT_MOD_TILE_VER_G=
FX6)
> +		return false;
> +
> +	/* GFX8 and older format modifiers are not supported on GFX9+ yet. */
> +	if (adev->family >=3D AMDGPU_FAMILY_AI)
> +		return false;
> +
> +	/* GFX6-7 doesn't have any DCC, GFX8 doesn't have displayable DCC. */
> +	if (AMD_FMT_MOD_GET(DCC, modifier))
> +		return false;
> +
> +	/*
> +	 * For now, only expose 1D and 2D tiles THIN array modes.
> +	 * Linear is already exposed through DRM_FORMAT_MOD_LINEAR.
> +	 */
> +	if (array_mode !=3D AMD_FMT_MOD_TILE_GFX6_1D_TILED_THIN1 &&
> +	    array_mode !=3D AMD_FMT_MOD_TILE_GFX6_2D_TILED_THIN1)
> +		return false;
> +
> +	/*
> +	 * For now, only expose DISPLAY micro tile mode.
> +	 * THIN, DEPTH and THICK modes are not displayable.
> +	 * ROTATED has never been supported on Linux.
> +	 */
> +	if (micro_tile_mode !=3D AMD_FMT_MOD_MICROTILE_DISPLAY)
> +		return false;

[Severity: High]
Does this strict micro tile mode check break backward compatibility with
existing userspace?

Prior to this patch, userspace could allocate a buffer with the RENDER
micro-tiling mode (value 3) and it was explicitly allowed by the legacy che=
ck
for compatibility with Mesa's radeonsi driver.

By exposing modifiers on GFX6-8 here, the legacy check is disabled, and the
kernel converts the tiling flags to an implicit modifier. This modifier gets
rejected by the strict AMD_FMT_MOD_MICROTILE_DISPLAY check in
amdgpu_display_verify_sizes_gfx6(), which can cause compositors to fail to
display scanout buffers.

> +
> +	/* Verify that the modifier is the same that we'd expose for this bpp */
> +	return amdgpu_dm_plane_calc_gfx6_mod(adev, bpp, array_mode) =3D=3D modi=
fier;
> +}
[ ... ]
> @@ -749,12 +1043,6 @@ static void amdgpu_dm_plane_add_gfx12_modifiers(str=
uct amdgpu_device *adev,
>  STATIC_IFN_KUNIT int amdgpu_dm_plane_get_plane_modifiers(struct amdgpu_d=
evice *adev, unsigned int plane_type, uint64_t **mods)
>  {
>  	uint64_t size =3D 0, capacity =3D 128;
> -	*mods =3D NULL;
> -
> -	/* We have not hooked up any pre-GFX9 modifiers. */
> -	if (adev->family < AMDGPU_FAMILY_AI)
> -		return 0;
> -

[Severity: Medium]
Can this cause a KUnit test failure and memory leak?

The test dm_test_get_plane_modifiers() in
drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c asserts
that amdgpu_dm_plane_get_plane_modifiers() leaves `mods` as NULL for
AMDGPU_FAMILY_SI. Since this patch now allocates and populates `mods` for
GFX6 hardware, the test expectation fails.

Because the execution continues in the test, it passes the already-allocated
pointer back into the function which overwrites the pointer, leaking the
previous array allocation.

>  	*mods =3D kmalloc_array(capacity, sizeof(uint64_t), GFP_KERNEL);
> =20
>  	if (plane_type =3D=3D DRM_PLANE_TYPE_CURSOR) {
> @@ -764,6 +1052,13 @@ STATIC_IFN_KUNIT int amdgpu_dm_plane_get_plane_modi=
fiers(struct amdgpu_device *a
>  	}
> =20
>  	switch (adev->family) {
> +	case AMDGPU_FAMILY_SI:
> +	case AMDGPU_FAMILY_CI:
> +	case AMDGPU_FAMILY_KV:
> +	case AMDGPU_FAMILY_VI:
> +	case AMDGPU_FAMILY_CZ:
> +		amdgpu_dm_plane_add_gfx6_modifiers(adev, mods, &size, &capacity);
> +		break;

[Severity: High]
Could exposing these modifiers allow undersized framebuffers to bypass vali=
dation?

By adding these modifiers, the code now allows userspace to create framebuf=
fers
with GFX6 modifiers via addfb2. In drivers/gpu/drm/amd/amdgpu/amdgpu_displa=
y.c,
amdgpu_display_verify_sizes() calculates block_size_log2 for GFX6:

    block_size_log2 =3D ilog2(block_width * block_height);

This calculates the log2 of the pixel count rather than the byte size, beca=
use
it is missing the format_info->cpp[i] multiplier. The missing multiplier
causes the byte size validation to incorrectly pass for undersized buffers.
This can lead to the display hardware reading beyond the allocated GEM obje=
ct
bounds during scanout.

>  	case AMDGPU_FAMILY_AI:
>  	case AMDGPU_FAMILY_RV:
>  		amdgpu_dm_plane_add_gfx9_modifiers(adev, mods, &size, &capacity);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720142440.2207=
6-1-timur.kristof@gmail.com?part=3D3
