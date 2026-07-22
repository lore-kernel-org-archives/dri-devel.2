Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 957CEC44539
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 14:14:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1A6510E2DC;
	Wed, 22 Jul 2026 14:14:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="k7ki9pgO";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E52F10E2DC
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 14:14:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6782A406F3;
 Wed, 22 Jul 2026 14:14:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A5D71F00A3A;
 Wed, 22 Jul 2026 14:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784729661;
 bh=8Uy4r1WmC1LXEI6P01rLjjYlp/IXFKh4B/SxP/8QKfA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=k7ki9pgOL55vqVpVNAodkWGQ06oHU3IHfcuP93ErEqOiMe7wtNgGPwFa6303cj/VR
 cJxpetrFu7SDmSFLHUqA90pxFgsThrdXecLCx0ymyBOkWjp7U9jWB0tKqm1ZtdMKSX
 A1pVOq3z0gaxiaJcFvhU+PGIlhEnoRMPOiEQjydy/zOT5xQwjdMZa2L1JA8j5FZX8S
 lbDAHB8WaJSOTgISZo/zBi494HgJDcA3e1TOfkMIDWEvVM2TA/wh7C38Zvd+RVliMg
 WECm+QKCOJVTbgd8+W4Sy48+kNB4u4N/Z954mMIs0esydKS79KvYDydwkTKJzB8Fob
 N55mLLzN4x4vg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 07/11] drm/amd/display: Implement fixed matrix
 colorop color space mapping
To: "Harry Wentland" <harry.wentland@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260722134607.136293-8-harry.wentland@amd.com>
References: <20260722134607.136293-1-harry.wentland@amd.com>
 <20260722134607.136293-8-harry.wentland@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 14:14:20 +0000
Message-Id: <20260722141421.2A5D71F00A3A@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] `vkms_plane_atomic_update` unintentionally disables the fixed matr=
ix colorop during simple page flips.
- [Medium] `drm_plane_colorop_fixed_matrix_init` uses `-BIT(DRM_COLOROP_FM_=
COUNT)` which zero-extends on 32-bit platforms, failing to validate bits 32=
-63 of the `u64` `supported_fm` mask.
- [Medium] `__set_dm_plane_colorop_fixed_matrix` unconditionally sets `full=
_update =3D 1`, which can unnecessarily destroy fast page flip performance.
- [Low] Mismatch between commit message documentation and code implementati=
on for bypass color space.

Pre-existing issues:
- [High] `__set_dm_plane_colorop_fixed_matrix` and `amdgpu_dm_update_plane_=
color_mgmt` silently drop the entire color pipeline on page flips.
--

--- Patch [7]: [PATCH v4 07/11] drm/amd/display: Implement fixed matrix col=
orop color space mapping ---
commit b2189c95d176aaf780d252979cb22287548aef19
Author: Harry Wentland <harry.wentland@amd.com>

drm/amd/display: Implement fixed matrix colorop color space mapping

Add __set_dm_plane_colorop_fixed_matrix() which maps the fixed matrix type
enum to the appropriate dc_color_space for DC programming. It also updates
the plane properties processing to handle the fixed matrix before degamma.

> When the fixed matrix is bypassed, color_space is set to
> COLOR_SPACE_UNKNOWN.

[Severity: Low]
This isn't a bug, but there is a mismatch between the documentation and the
implementation. The commit message states COLOR_SPACE_UNKNOWN is used when
bypassed, but the code sets it to COLOR_SPACE_SRGB.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/dr=
ivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
> index 357c7c5c85cff..62791077ceef8 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
> @@ -1545,6 +1545,61 @@ __set_colorop_in_tf_1d_curve(struct dc_plane_state=
 *dc_plane_state,
>  }
>  EXPORT_IF_KUNIT(__set_colorop_in_tf_1d_curve);
> =20
> +static int
> +__set_dm_plane_colorop_fixed_matrix(struct drm_plane_state *plane_state,
> +				    struct dc_plane_state *dc_plane_state,
> +				    struct drm_colorop *colorop)
> +{
> +	struct drm_colorop *old_colorop;
> +	struct drm_colorop_state *colorop_state =3D NULL, *new_colorop_state;
> +	struct drm_atomic_commit *state =3D plane_state->state;
> +	int i =3D 0;
> +
> +	old_colorop =3D colorop;
> +
> +	for_each_new_colorop_in_state(state, colorop, new_colorop_state, i) {
> +		if (new_colorop_state->colorop =3D=3D old_colorop) {
> +			colorop_state =3D new_colorop_state;
> +			break;
> +		}
> +	}
> +
> +	if (!colorop_state)
> +		return -EINVAL;

[Severity: High]
This isn't a regression introduced by this patch, but does returning -EINVAL
here cause the entire hardware color pipeline configuration to be silently
discarded?

When userspace performs a fast page flip without modifying the color pipeli=
ne,
the DRM core does not add the colorop states to the atomic commit.

Since for_each_new_colorop_in_state() only searches the current transaction,
it will return -EINVAL if the state is missing. Can this lead to
amdgpu_dm_update_plane_color_mgmt() catching this -EINVAL and reverting to
legacy DRM color properties on every simple page flip?

> +
> +	if (colorop_state->bypass) {
> +		dc_plane_state->color_space =3D COLOR_SPACE_SRGB;
> +		return 0;
> +	}
> +
> +	switch (colorop_state->fixed_matrix_type) {
> +	case DRM_COLOROP_FM_YCBCR601_FULL_RGB:
> +		dc_plane_state->color_space =3D COLOR_SPACE_YCBCR601;
> +		break;

[ ... ]

> +	case DRM_COLOROP_FM_YCBCR2020_NC_LIMITED_RGB:
> +		dc_plane_state->color_space =3D COLOR_SPACE_2020_YCBCR_LIMITED;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	dc_plane_state->update_bits.full_update =3D 1;
> +
> +	return 0;
> +}

[Severity: Medium]
Does setting full_update to 1 unconditionally here unnecessarily impact fast
page flip performance?

If the fixed matrix colorop is explicitly included in the atomic commit, th=
is
forces a full update even if the state didn't actually change from the
previous commit.

Should this only force a full update if the color_space or bypass state
actively transitioned, to avoid hardware sequencer overhead and potential
stuttering?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722134607.1362=
93-1-harry.wentland@amd.com?part=3D7
