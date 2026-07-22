Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A4A4C44536
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 13:59:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8367510E47E;
	Wed, 22 Jul 2026 13:59:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UdJ2AYMl";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0443F10E47E
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 13:59:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5570D600AB;
 Wed, 22 Jul 2026 13:59:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D19361F00A3F;
 Wed, 22 Jul 2026 13:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784728741;
 bh=LE5XOpGV6s683vW75eAWcF/sgd0MltD/ewc4Uex84ok=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UdJ2AYMlpBn08CzShmN/GM0RAKGQrkmFFHatqKW0g+hTDQGu00JbZ1UaAGNnv7Bhp
 l7qJhfjmM1Wk1iVVXxFqnLLZl4dPyVib1y3yhaTDvkZga5ZoDcsl5pRgCCpUuAiVbn
 JKkwOHsrL08NCi4e6lHPLoRQoNtSEBXLfqFyJowf5QwH9BKAIrk9q2eHuE34dVBaM2
 B/czSSd7CwM1wtb2j1ucWhPEdA2W6Iy0aSAqu1lN6/0Vvk1DcuAgSpjrBHc9x4Q/nd
 FFyvEfXYTKj6Zmw5mTBJJ0JDDxKyoEBblraPL8uJf2KsZVp7WkOWGkTtMhoClx9J9f
 f2zHf+P05Gldg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 05/11] drm/vkms: Add atomic check and matrix handling
 for fixed matrix colorop
To: "Harry Wentland" <harry.wentland@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260722134607.136293-6-harry.wentland@amd.com>
References: <20260722134607.136293-1-harry.wentland@amd.com>
 <20260722134607.136293-6-harry.wentland@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 13:59:00 +0000
Message-Id: <20260722135900.D19361F00A3F@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Page flips that do not modify the color pipeline incorrectly bypas=
s the YUV-to-RGB conversion matrix.
- [Medium] vkms_plane_atomic_check fails to validate the bypass state for t=
he fixed matrix colorop.
- [Medium] FIXED_MATRIX colorop is silently ignored for RGB formats, and st=
ate is unconditionally interpreted as fixed_matrix.

Pre-existing issues:
- [High] The background composer accesses live DRM object state (`colorop->=
state`), risking Use-After-Free.
--

--- Patch [5]: [PATCH v4 05/11] drm/vkms: Add atomic check and matrix handl=
ing for fixed matrix colorop ---
commit 7c8489284a67e8c66fd1ead26966ba84d8380366
Author: Harry Wentland <harry.wentland@amd.com>

drm/vkms: Add atomic check and matrix handling for fixed matrix colorop

This commit validates that YUV framebuffers use a non-bypassed fixed matrix
colorop when a color pipeline is active. It also maps the fixed matrix type
to color encoding and range for YUV-to-RGB conversion, while treating the
fixed matrix colorop as a no-op during composition.

> diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/=
vkms_composer.c
> index 83d217085ad09..899120cd07ac5 100644
> --- a/drivers/gpu/drm/vkms/vkms_composer.c
> +++ b/drivers/gpu/drm/vkms/vkms_composer.c
> @@ -187,6 +187,12 @@ static void apply_colorop(struct pixel_argb_s32 *pix=
el, struct drm_colorop *colo
>  		if (colorop_state->data)
>  			apply_3x4_matrix(pixel,
>  					 (struct drm_color_ctm_3x4 *)colorop_state->data->data);
> +	} else if (colorop->type =3D=3D DRM_COLOROP_FIXED_MATRIX) {
> +		/*
> +		 * Fixed Matrix is a no-op here. YUV-to-RGB conversion
> +		 * is handled at format read time via the
> +		 * conversion_matrix set in vkms_plane_atomic_update().
> +		 */
>  	}

[Severity: Medium]
If userspace applies a DRM_COLOROP_FIXED_MATRIX to an RGB plane, will this
silently ignore the operation instead of properly rejecting it in the atomic
check?

[Severity: High]
This isn't a bug introduced by this patch, but doesn't reading the live
colorop->state pointer asynchronously in the worker risk a use-after-free
if a concurrent atomic commit frees the old state?=20

Looking at the beginning of apply_colorop() in vkms_composer.c:

static void apply_colorop(struct pixel_argb_s32 *pixel, struct drm_colorop =
*colorop)
{
	struct drm_colorop_state *colorop_state =3D colorop->state;

Should VKMS snapshot the required properties into vkms_plane_state during
atomic_update instead of dereferencing the live DRM object state asynchrono=
usly?

[ ... ]
> diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkm=
s_plane.c
> index 68cb2a3335e64..6ee5c3f3207c5 100644
> --- a/drivers/gpu/drm/vkms/vkms_plane.c
> +++ b/drivers/gpu/drm/vkms/vkms_plane.c
[ ... ]
> @@ -148,7 +152,49 @@ static void vkms_plane_atomic_update(struct drm_plan=
e *plane,
>  	frame_info->rotation =3D new_state->rotation;
> =20
>  	vkms_plane_state->pixel_read_line =3D get_pixel_read_line_function(fmt);
> -	get_conversion_matrix_to_argb_u16(fmt, new_state->color_encoding, new_s=
tate->color_range,
> +
> +	if (new_state->color_pipeline) {
> +		struct drm_colorop *colorop =3D new_state->color_pipeline;
> +		struct drm_colorop_state *colorop_state;
> +
> +		colorop_state =3D drm_atomic_get_new_colorop_state(state, colorop);
> +		bypass =3D !colorop_state || colorop_state->bypass;

[Severity: High]
Could this logic inadvertently break YUV decoding on standard page flips?

If a page flip does not include the colorop in the atomic commit,
drm_atomic_get_new_colorop_state() returns NULL, which forces bypass to tru=
e.
Will this reset the conversion matrix to a no-op on the second frame?

> +
> +		if (!bypass) {
> +			switch (colorop_state->fixed_matrix_type) {

[Severity: Medium]
When the active colorop on an RGB plane is a 1D_CURVE instead of a
FIXED_MATRIX, will this unconditionally misinterpret the state struct and r=
ead
an invalid fixed_matrix_type?

> +			case DRM_COLOROP_FM_YCBCR601_FULL_RGB:
> +				encoding =3D DRM_COLOR_YCBCR_BT601;
> +				range =3D DRM_COLOR_YCBCR_FULL_RANGE;
> +				break;
[ ... ]
> @@ -175,6 +221,13 @@ static int vkms_plane_atomic_check(struct drm_plane =
*plane,
>  	if (ret !=3D 0)
>  		return ret;
> =20
> +	if (new_plane_state->color_pipeline && new_plane_state->fb->format->is_=
yuv) {
> +		struct drm_colorop *colorop =3D new_plane_state->color_pipeline;
> +
> +		if (colorop->type !=3D DRM_COLOROP_FIXED_MATRIX)
> +			return -EINVAL;

[Severity: Medium]
The commit message states that "The fixed matrix colorop must not be bypass=
ed"
when the framebuffer format is YUV.

Does this atomic check fail to enforce that rule by not retrieving the
colorop state to check its bypass property?

> +	}
> +
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722134607.1362=
93-1-harry.wentland@amd.com?part=3D5
