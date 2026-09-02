Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C4DAC624D0
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 10:17:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8056510E02F;
	Wed,  2 Sep 2026 10:16:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="n0ydxvwR";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 991C310E02F
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 10:16:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E6C12600D0;
 Wed,  2 Sep 2026 10:16:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75DEC1F000E9;
 Wed,  2 Sep 2026 10:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788344216;
 bh=9sRLPgB4NEPBap6yBgr46gki/NQd3LFe8adDto4629o=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=n0ydxvwRzPkPC33PuViw2YHF7XGkZAahoBypVkkn0+Ed0PbtqlXWTV1ChnHpXWKht
 lmVxz2rqOH3zHEu8w3Heyhv+IYHysEdYPgF1eBotvDaXH4YQs5x6OmKJ8YP1gmu8yz
 VZZLmklYToLpP9SLZKWphJVFfBeW6t3yuUjms0DOn0TJeUqiY6lnzHDMMIqBf6hakw
 iFo8OY6OWk7aAVQH6kafkf/qScMChlHfewai4pQThHfvXGvhDbEKfkYZdd4Sy7Qo5o
 vDkCP7oLFiqtNxEYjIrrhvMWD/kly6k/q2KtQpicn0q+0fy2uSpAh7l5D5I1ZVmoaE
 5zp4SKhfMC/sg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/radeon: Create the primary plane in the driver
To: oushixiong1025@163.com
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260902100739.627697-1-oushixiong1025@163.com>
References: <20260902100739.627697-1-oushixiong1025@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 10:16:56 +0000
Message-Id: <20260902101656.75DEC1F000E9@smtp.kernel.org>
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
- [High] Backwards Compatibility / Functional Regression: Restricting suppo=
rted formats on primary plane
- [Medium] Memory leak of `radeon_crtc` on the error path when `drm_crtc_in=
it_with_planes()` fails.
--

commit a5951b1d6bc3cbef461bfcabdab5aeff88a28da4
Author: Shixiong Ou <oushixiong@kylinos.cn>

drm/radeon: Create the primary plane in the driver

This commit replaces the fixed format primary plane created by
drm_crtc_init() with a driver-owned primary plane in the radeon driver.
This allows the driver to set the blend mode property to PREMULTI, resolving
warnings during drm_mode_config_validate().

> diff --git a/drivers/gpu/drm/radeon/radeon_display.c b/drivers/gpu/drm/ra=
deon/radeon_display.c
> index aac6733ddd82c..058ec866f02b8 100644
> --- a/drivers/gpu/drm/radeon/radeon_display.c
> +++ b/drivers/gpu/drm/radeon/radeon_display.c
[ ... ]
> @@ -664,6 +667,19 @@ radeon_crtc_set_config(struct drm_mode_set *set,
>  	return ret;
>  }
> =20
> +static const uint32_t radeon_primary_formats[] =3D {
> +	/*
> +	 * The display engine programs an ARGB8888 surface format for both
> +	 * XRGB8888 and ARGB8888 framebuffers.
> +	 */
> +	DRM_FORMAT_XRGB8888,
> +	DRM_FORMAT_ARGB8888,
> +};
> +
> +static const struct drm_plane_funcs radeon_primary_plane_funcs =3D {
> +	DRM_PLANE_NON_ATOMIC_FUNCS,
> +};
> +
>  static const struct drm_crtc_funcs radeon_crtc_funcs =3D {
>  	.cursor_set2 =3D radeon_crtc_cursor_set2,
>  	.cursor_move =3D radeon_crtc_cursor_move,
[ ... ]
> @@ -693,7 +711,29 @@ static void radeon_crtc_init(struct drm_device *dev,=
 int index)
>  		return;
>  	}
> =20
> -	drm_crtc_init(dev, &radeon_crtc->base, &radeon_crtc_funcs);
> +	primary =3D __drm_universal_plane_alloc(dev, sizeof(*primary), 0, 0,
> +					      &radeon_primary_plane_funcs,
> +					      radeon_primary_formats,
> +					      ARRAY_SIZE(radeon_primary_formats),
> +					      NULL, DRM_PLANE_TYPE_PRIMARY, NULL);

[Severity: High]
Will this break backwards compatibility for userspace programs configuring
legacy pixel formats?

The array radeon_primary_formats explicitly lists only DRM_FORMAT_XRGB8888
and DRM_FORMAT_ARGB8888. When __drm_universal_plane_alloc() is called here,
it leaves primary->format_default as false (since it is zero-initialized).

Because of this, the core DRM modeset logic in drm_mode_setcrtc() will now
strictly check pixel formats against this restricted list and return -EINVAL
for other formats. The hardware supports and previously accepted legacy
formats (like RGB565, 8-bit, 15-bit, and 24-bit color) which are handled in
radeon_crtc_do_set_base().

> +	if (IS_ERR(primary)) {
> +		destroy_workqueue(radeon_crtc->flip_queue);
> +		kfree(radeon_crtc);
> +		return;
> +	}
> +
> +	ret =3D drm_crtc_init_with_planes(dev, &radeon_crtc->base, primary, NUL=
L,
> +					&radeon_crtc_funcs, NULL);
> +	if (ret) {
> +		dev_err(dev->dev, "Failed to init CRTC %d: %d\n", index, ret);
> +		drm_plane_cleanup(primary);
> +		kfree(primary);
> +		destroy_workqueue(radeon_crtc->flip_queue);
> +		return;
> +	}

[Severity: Medium]
Does this error path leak the dynamically allocated radeon_crtc object?

If drm_crtc_init_with_planes() fails during device initialization, the code
cleans up the primary plane and destroys the flip queue, but it appears to
return without calling kfree(radeon_crtc).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902100739.6276=
97-1-oushixiong1025@163.com?part=3D1
