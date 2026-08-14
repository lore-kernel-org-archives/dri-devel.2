Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBC57C5CFC1
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 15:28:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2270E10F66E;
	Fri, 14 Aug 2026 15:28:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NYUG2ijy";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D4E710F66E
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 15:28:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2C6C0405FA
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 15:28:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8AC61F000E9;
 Fri, 14 Aug 2026 15:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786721330;
 bh=NhdSG4ajJ+5UHzVnePPzWt3sKSV715AMZYDzGWEc/fE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NYUG2ijy4XtUvWhOhmOmShhEmDGe4Y2Qv9Bm6s2SrKk0B7O46BSx/Up7C883TjeDU
 to2nkLQc0Sq1EPu9doUW4hnzqNhGOhV6m9+RVgiXoOQJA24sZR0ACkqnasfApZqv9L
 aODSzKvljrgxbhOG/mk1oOKGR9KAuG6LW5nPjiUkP8Ky/bp8d/+enJTH58SmD0D2MP
 q7YD9bPpbn79fgJBJiYG+U3/ChZbtMi9cflmKNtUdg7hqviHkDzSPVQZXcyXx98pOX
 4n1gQT/LBZqSckirZJgLNpzt8x5bQ5OcAejWz7PHPjqHltg9pJ7xqqVtgztFHTUMx3
 AuwM0NEPoAoag==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 56/61] drm/sun4i: layer: Convert to atomic_create_state
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-sunxi@lists.linux.dev
In-Reply-To: <20260814-drm-no-more-plane-reset-v2-56-82d2963dd134@kernel.org>
References: <20260814-drm-no-more-plane-reset-v2-0-82d2963dd134@kernel.org>
 <20260814-drm-no-more-plane-reset-v2-56-82d2963dd134@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 15:28:49 +0000
Message-Id: <20260814152849.D8AC61F000E9@smtp.kernel.org>
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
- [Medium] The `.atomic_create_state` hook (`sun4i_backend_layer_create_sta=
te`) illegally retains state destruction logic, violating the factory funct=
ion API contract.
--

--- Patch [56]: [PATCH v2 56/61] drm/sun4i: layer: Convert to atomic_create=
_state ---
commit ff1555af002cdd0794b6aa7ae72c66565fbe6fdd
Author: Maxime Ripard <mripard@kernel.org>

drm/sun4i: layer: Convert to atomic_create_state

This commit converts the plane reset implementation to use
atomic_create_state. The existing implementation creates a custom state
subclass but only initializes a pristine state without resetting any
hardware, which matches the expected behavior of atomic_create_state.

> diff --git a/drivers/gpu/drm/sun4i/sun4i_layer.c b/drivers/gpu/drm/sun4i/=
sun4i_layer.c
> index d65587d96d9ee..b165960ca8e5d 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_layer.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_layer.c
> @@ -16,7 +16,7 @@
>  #include "sun4i_layer.h"
>  #include "sunxi_engine.h"
> =20
> -static void sun4i_backend_layer_reset(struct drm_plane *plane)
> +static struct drm_plane_state *sun4i_backend_layer_create_state(struct d=
rm_plane *plane)
>  {
>  	struct sun4i_layer_state *state;
> =20
>  	if (plane->state) {
>  		state =3D state_to_sun4i_layer_state(plane->state);
> =20
>  		__drm_atomic_helper_plane_destroy_state(&state->state);
> =20
>  		kfree(state);
>  		plane->state =3D NULL;
>  	}

[Severity: Medium]
Should this state destruction logic be removed since this function is now
an atomic_create_state hook?

The atomic_create_state factory function API contract expects only
allocation and initialization of a new state object. Although the DRM core
guarantees plane->state is NULL before invoking this hook (making this
block functionally dead code), it appears the Coccinelle semantic patch
may have missed removing this destruction block during the conversion.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814-drm-no-mor=
e-plane-reset-v2-0-82d2963dd134@kernel.org?part=3D56
