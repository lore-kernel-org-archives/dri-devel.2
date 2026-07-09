Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 709F7C43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 12:25:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D47F310F587;
	Thu,  9 Jul 2026 12:25:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BKV3OkNT";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FDFA10F587
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 12:25:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 96A996001A
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 12:25:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2160A1F000E9;
 Thu,  9 Jul 2026 12:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783599905;
 bh=lwpFKex9Ubu4sTbFDs6uUqGPUVBsvHe8zUaP0VwbJdQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=BKV3OkNTkYNCKdAA7U8SSXw9BV1tyVOLbVk3re0o5SmpK6lHWKrSivFxXx6O55FN2
 tSUWwBkqHZTfJulZ+Tb4hO7DDZD6T+D7uiID0o/LvZWxzbapVwnlGh74/M28Zx7MxX
 /GyePG+YM6nHHZxxG+uaOShhneSTdkq+84GaQvgEU3Xv8muzo9IqhEIVHyVlILpMvV
 I4XcPkhqhDGUA6N1Q7OytUcNQ/BsE3i+9Fg1KlnJRSDN7SOGSknJ0OddcFDkivQeRU
 x0DFmtXS1nLT56acH7KE0HTVOMXvHHzGEGhQrL837ih3B2JNIH/BZvk9vbLuw5RNUA
 dGv9XuDUhblYw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 44/60] drm/exynos: Convert to atomic_create_state
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260709-drm-no-more-plane-reset-v1-44-302d986fe5f0@kernel.org>
References: <20260709-drm-no-more-plane-reset-v1-0-302d986fe5f0@kernel.org>
 <20260709-drm-no-more-plane-reset-v1-44-302d986fe5f0@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 12:25:04 +0000
Message-Id: <20260709122505.2160A1F000E9@smtp.kernel.org>
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
- [High] NULL pointer dereference in `exynos_drm_plane_create_state` due to=
 accessing `plane->state` before it is assigned.
--

--- Patch [44]: [PATCH 44/60] drm/exynos: Convert to atomic_create_state ---
commit 425d9a6e7835f76d839e38884c8943389a4e1c1c
Author: Maxime Ripard <mripard@kernel.org>

drm/exynos: Convert to atomic_create_state

This commit converts the plane reset implementation to use atomic_create_st=
ate
by replacing the custom reset hook. A Coccinelle semantic patch was used to
perform the conversion.

> diff --git a/drivers/gpu/drm/exynos/exynos_drm_plane.c b/drivers/gpu/drm/=
exynos/exynos_drm_plane.c
> --- a/drivers/gpu/drm/exynos/exynos_drm_plane.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_plane.c
[ ... ]
> -static void exynos_drm_plane_reset(struct drm_plane *plane)
> +static struct drm_plane_state *exynos_drm_plane_create_state(struct drm_=
plane *plane)
>  {
>  	struct exynos_drm_plane *exynos_plane =3D to_exynos_plane(plane);
>  	struct exynos_drm_plane_state *exynos_state;
> =20
> -	if (plane->state) {
> -		exynos_state =3D to_exynos_plane_state(plane->state);
> -		__drm_atomic_helper_plane_destroy_state(plane->state);
> -		kfree(exynos_state);
> -		plane->state =3D NULL;
> -	}
> -
>  	exynos_state =3D kzalloc_obj(*exynos_state);
> -	if (exynos_state) {
> -		__drm_atomic_helper_plane_reset(plane, &exynos_state->base);
> -		plane->state->zpos =3D exynos_plane->config->zpos;
> -	}
> +	if (!exynos_state)
> +		return ERR_PTR(-ENOMEM);
> +
> +	__drm_atomic_helper_plane_state_init(&exynos_state->base, plane);
> +	plane->state->zpos =3D exynos_plane->config->zpos;

[Severity: High]
Can this cause a NULL pointer dereference during plane initialization?

Since __drm_atomic_helper_plane_state_init() does not assign plane->state
(unlike the old __drm_atomic_helper_plane_reset() helper), plane->state
is likely NULL during initial creation. Even if it is not NULL, should this
code be modifying the newly allocated state (exynos_state->base.zpos)
instead of plane->state->zpos?

> +
> +	return &exynos_state->base;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709-drm-no-mor=
e-plane-reset-v1-0-302d986fe5f0@kernel.org?part=3D44
