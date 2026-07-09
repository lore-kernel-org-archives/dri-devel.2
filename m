Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 882A7C44506
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 12:29:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A95310F595;
	Thu,  9 Jul 2026 12:29:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kePoUe7f";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2889B10E65E
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 12:29:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7BF2E6001A
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 12:29:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 075411F000E9;
 Thu,  9 Jul 2026 12:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783600159;
 bh=R0GsRHoglZkpZrkVChDAraJPoxYR0jPV6k7AxtvgQ28=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=kePoUe7fBAFEX9T4IM4i5NOq2FfGMVB+8CiuAA8S87OlNLphcmUMbS1TDAA0DimPK
 t9u4dS3a76Xz2vvZbv7Hz3bbXzDco3FLzsbXgbH4Iws4iYPXljHjBGo8xkK+LqUh01
 L7InGYHr7jnxFKHNPhf+EarXdcifVq4Iu8ygxWzqnrNtYUZ0ipHB1XOGK3EoBmo6P7
 ofEcF8N41w7Ax3RtoO4YCxxfRA7u7yqfFMGdW1iIWx4/aFZrPD+RF+QFXxChuTsy4N
 ZpsmHWilN6HHgXs7uPFfgm94eEWweq2DUyB3X0rr8RfxjUk9p+gkNyA+iJ+QhXo2uX
 gcaEJciCgGzfw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 43/60] drm/atmel-hlcdc: Convert to atomic_create_state
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260709-drm-no-more-plane-reset-v1-43-302d986fe5f0@kernel.org>
References: <20260709-drm-no-more-plane-reset-v1-0-302d986fe5f0@kernel.org>
 <20260709-drm-no-more-plane-reset-v1-43-302d986fe5f0@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 12:29:18 +0000
Message-Id: <20260709122919.075411F000E9@smtp.kernel.org>
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
- [Medium] Hardware modification inside `atomic_create_state` violates the =
DRM API contract.
- [Medium] The function returns `-EINVAL` instead of `-ENOMEM` when memory =
allocation for DMA descriptors fails.
--

--- Patch [43]: [PATCH 43/60] drm/atmel-hlcdc: Convert to atomic_create_sta=
te ---
commit 28ffcf15c4fc4a6c19751342c0e8a7f7e0d7a988
Author: Maxime Ripard <mripard@kernel.org>
drm/atmel-hlcdc: Convert to atomic_create_state

This commit converts the atmel-hlcdc plane reset implementation to use
atomic_create_state. The conversion was primarily done using a Coccinelle
semantic patch.

> The plane reset implementation creates a custom state
> subclass, but only initializes a pristine state without resetting any
> hardware. This is equivalent to what atomic_create_state expects.

Is this description of the old reset function accurate?

Looking at atmel_hlcdc_csc_init(), which is called via the lcdc_csc_init()
hook, it appears to perform direct register writes:

atmel_hlcdc_csc_init() {
    ...
    atmel_hlcdc_layer_write_cfg(&plane->layer,
                                desc->layout.csc + i,
                                hlcdc_csc_coeffs[i]);
}

This seems to indicate the old reset function did actually touch hardware,
contrary to the commit message.

> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c b/drivers/gp=
u/drm/atmel-hlcdc/atmel_hlcdc_plane.c
> index f17a832351e9d..ff35251a01846 100644
> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c

[ ... ]

> @@ -1183,36 +1183,33 @@ static void atmel_hlcdc_plane_atomic_destroy_stat=
e(struct drm_plane *p,

[ ... ]

> -	if (state) {
> -		if (atmel_hlcdc_plane_alloc_dscrs(p, state)) {
> -			kfree(state);
> -			drm_err(p->dev,
> -				"Failed to allocate initial plane state\n");
> -			return;
> -		}
> -		__drm_atomic_helper_plane_reset(p, &state->base);
> +	if (!state)
> +		return ERR_PTR(-ENOMEM);
> +
> +	if (atmel_hlcdc_plane_alloc_dscrs(p, state)) {
> +		kfree(state);
> +		drm_err(p->dev, "Failed to allocate initial plane state\n");
> +		return ERR_PTR(-EINVAL);

[Severity: Medium]
Since atmel_hlcdc_plane_alloc_dscrs() internally returns -ENOMEM when
dma_pool_alloc() fails, should this propagate that error or return
ERR_PTR(-ENOMEM) instead of hardcoding -EINVAL?

>  	}
> +	__drm_atomic_helper_plane_state_init(&state->base, p);
> =20
>  	if (plane->layer.desc->layout.csc)
>  		dc->desc->ops->lcdc_csc_init(plane, plane->layer.desc);

[Severity: Medium]
Does this break the DRM API contract for atomic_create_state?

The atomic_create_state hook is documented to have no side effects, but as
noted above, lcdc_csc_init() writes directly to hardware registers.

If the driver is later initialized using
drm_mode_config_create_initial_state() before power domains are fully
enabled, could these hardware accesses cause a crash or hang?

> +
> +	return &state->base;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709-drm-no-mor=
e-plane-reset-v1-0-302d986fe5f0@kernel.org?part=3D43
