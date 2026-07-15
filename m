Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 426ACC44507
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 22:08:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C8A510E254;
	Wed, 15 Jul 2026 22:08:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=crapouillou.net header.i=@crapouillou.net header.b="HyiILIAp";
	dkim-atps=neutral
Received: from aposti.net (aposti.net [185.119.170.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1F0A10E254
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 22:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crapouillou.net;
 s=mail; t=1784153311;
 bh=iyqFBKpEcM69SF5aDYXRi/En6GJa9MOiBmk7o5wmHhc=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=HyiILIAp5RMVqNiDuJbHZlQEZgSkwk0krqr4l720wzwGPuNqezbHG9jZe8pWUVywP
 U8ITYUbiHpPACQRKC81xZni8WzrGUs6dt32Pr5FSVxiu+ylGm6WjALui8br6wrh38T
 3tB6dyBwvaMaYGqbRXtq4NIt6y2Ot/fwukzBcrrU=
Message-ID: <ee161e6969a3f9f0b445a534a086a91cd8786128.camel@crapouillou.net>
Subject: Re: [PATCH 19/60] drm/ingenic: Convert to atomic_create_state
From: Paul Cercueil <paul@crapouillou.net>
To: Maxime Ripard <mripard@kernel.org>, Maarten Lankhorst	
 <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>,  David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-mips@vger.kernel.org
Date: Thu, 16 Jul 2026 00:08:25 +0200
In-Reply-To: <20260709-drm-no-more-plane-reset-v1-19-302d986fe5f0@kernel.org>
References: <20260709-drm-no-more-plane-reset-v1-0-302d986fe5f0@kernel.org>
 <20260709-drm-no-more-plane-reset-v1-19-302d986fe5f0@kernel.org>
Autocrypt: addr=paul@crapouillou.net; prefer-encrypt=mutual;
 keydata=mQENBF0KhcEBCADkfmrzdTOp/gFOMQX0QwKE2WgeCJiHPWkpEuPH81/HB2dpjPZNW03ZM
 LQfECbbaEkdbN4YnPfXgcc1uBe5mwOAPV1MBlaZcEt4M67iYQwSNrP7maPS3IaQJ18ES8JJ5Uf5Uz
 FZaUawgH+oipYGW+v31cX6L3k+dGsPRM0Pyo0sQt52fsopNPZ9iag0iY7dGNuKenaEqkYNjwEgTtN
 z8dt6s3hMpHIKZFL3OhAGi88wF/21isv0zkF4J0wlf9gYUTEEY3Eulx80PTVqGIcHZzfavlWIdzhe
 +rxHTDGVwseR2Y1WjgFGQ2F+vXetAB8NEeygXee+i9nY5qt9c07m8mzjABEBAAG0JFBhdWwgQ2VyY
 3VlaWwgPHBhdWxAY3JhcG91aWxsb3UubmV0PokBTgQTAQoAOBYhBNdHYd8OeCBwpMuVxnPua9InSr
 1BBQJdCoXBAhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEHPua9InSr1BgvIH/0kLyrI3V0f
 33a6D3BJwc1grbygPVYGuC5l5eMnAI+rDmLR19E2yvibRpgUc87NmPEQPpbbtAZt8On/2WZoE5OIP
 dlId/AHNpdgAtGXo0ZX4LGeVPjxjdkbrKVHxbcdcnY+zzaFglpbVSvp76pxqgVg8PgxkAAeeJV+ET
 4t0823Gz2HzCL/6JZhvKAEtHVulOWoBh368SYdolp1TSfORWmHzvQiCCCA+j0cMkYVGzIQzEQhX7U
 rf9N/nhU5/SGLFEi9DcBfXoGzhyQyLXflhJtKm3XGB1K/pPulbKaPcKAl6rIDWPuFpHkSbmZ9r4KF
 lBwgAhlGy6nqP7O3u7q23hRU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Hi Maxime,

Le jeudi 09 juillet 2026 =C3=A0 13:50 +0200, Maxime Ripard a =C3=A9crit=C2=
=A0:
> The plane only initializes a pristine state in its reset hook
> using drm_atomic_helper_plane_reset(), which is equivalent to what
> atomic_create_state expects. Convert to it.
>=20
> The conversion was done using the following Coccinelle semantic
> patch:
>=20
> @@
> identifier funcs;
> symbol drm_atomic_helper_plane_reset;
> symbol drm_atomic_helper_plane_create_state;
> @@
>=20
> struct drm_plane_funcs funcs =3D {
> =C2=A0 ...,
> - .reset =3D drm_atomic_helper_plane_reset,
> + .atomic_create_state =3D drm_atomic_helper_plane_create_state,
> =C2=A0 ...,
> };
>=20
> @match_struct_reset@
> identifier funcs, reset_func;
> @@
> struct drm_plane_funcs funcs =3D {
> =C2=A0=C2=A0=C2=A0 ...,
> =C2=A0=C2=A0=C2=A0 .reset =3D reset_func,
> =C2=A0=C2=A0=C2=A0 ...,
> };
>=20
> @reset_uses_helpers depends on match_struct_reset@
> identifier match_struct_reset.reset_func;
> @@
>=20
> =C2=A0void reset_func(...)
> =C2=A0{
> =C2=A0	<+...
> (
> =C2=A0	__drm_atomic_helper_plane_reset(...);
> >=20
> 	__drm_gem_reset_shadow_plane(...);
> )
> =C2=A0	...+>
> =C2=A0}
>=20
> @match_struct_destroy@
> identifier funcs, destroy_func;
> @@
> struct drm_plane_funcs funcs =3D {
> =C2=A0=C2=A0=C2=A0 ...,
> =C2=A0=C2=A0=C2=A0 .atomic_destroy_state =3D destroy_func,
> =C2=A0=C2=A0=C2=A0 ...,
> };
>=20
> @script:python renamed_func@
> old_name << match_struct_reset.reset_func;
> new_name;
> @@
> if old_name.endswith("_reset"):
> =C2=A0=C2=A0=C2=A0 coccinelle.new_name =3D old_name.replace("_reset", "_c=
reate_state")
> else:
> =C2=A0=C2=A0=C2=A0 coccinelle.new_name =3D old_name
>=20
> @update_struct depends on match_struct_reset && reset_uses_helpers@
> identifier match_struct_reset.funcs, match_struct_reset.reset_func;
> identifier renamed_func.new_name;
> @@
> struct drm_plane_funcs funcs =3D {
> =C2=A0=C2=A0=C2=A0 ...,
> -=C2=A0=C2=A0 .reset =3D reset_func,
> +=C2=A0=C2=A0 .atomic_create_state =3D new_name,
> =C2=A0=C2=A0=C2=A0 ...,
> };
>=20
> @drop_destroy depends on update_struct && match_struct_destroy@
> identifier match_struct_reset.reset_func;
> identifier match_struct_destroy.destroy_func;
> identifier container_func;
> identifier P;
> symbol drm_atomic_helper_plane_destroy_state;
> symbol __drm_atomic_helper_plane_destroy_state;
> @@
>=20
> =C2=A0void reset_func(struct drm_plane *P)
> =C2=A0{
> =C2=A0	...
> (
> -	if (P->state) {
> -=C2=A0		<+...
> (
> -		drm_atomic_helper_plane_destroy_state(P, P->state);
> >=20
> -		__drm_atomic_helper_plane_destroy_state(P->state);
> >=20
> -		P->funcs->atomic_destroy_state(P, P->state);
> >=20
> -		destroy_func(P, P->state);
> )
> -=C2=A0		...+>
> -=C2=A0	}
> >=20
> -	drm_WARN_ON_ONCE(P->dev, P->state);
> >=20
> -	WARN_ON(P->state);
> )
> =C2=A0	...
> (
> -	kfree(P->state);
> >=20
> -	kfree(container_func(P->state));
> >=20
> =C2=A0	// kfree is optional
> )
> (
> -	P->state =3D NULL;
> >=20
> =C2=A0	// plane->state clearing is optional
> )
> =C2=A0	...
> =C2=A0}
>=20
> @drop_destroy_mtk depends on update_struct@
> identifier P;
> symbol __drm_atomic_helper_plane_destroy_state;
> symbol to_mtk_plane_state;
> @@
>=20
> =C2=A0void mtk_plane_reset(struct drm_plane *P)
> =C2=A0{
> =C2=A0	...
> -	if (P->state) {
> -		__drm_atomic_helper_plane_destroy_state(P->state);
> -		...
> -	} else {
> =C2=A0		...
> -	}
> =C2=A0	...
> =C2=A0}
>=20
> @transform_nv50_wndw depends on update_struct@
> identifier S;
> @@
>=20
> =C2=A0void nv50_wndw_reset(...)
> =C2=A0{
> =C2=A0	...
> -	if (WARN_ON(!(S =3D kzalloc_obj(*S))))
> +	S =3D kzalloc_obj(*S);
> +	if (WARN_ON(!S))
> =C2=A0		return;
> =C2=A0	...
> =C2=A0}
>=20
> @transform_kzalloc depends on update_struct@
> identifier match_struct_reset.reset_func;
> identifier P, S;
> statement ST;
> statement list STL;
> @@
>=20
> =C2=A0void reset_func(struct drm_plane *P)
> =C2=A0{
> =C2=A0	<...
> =C2=A0	S =3D kzalloc_obj(*S);
> (
> -	if (S)
> -	{
> -		STL
> -	}
> +	if (!S) return;
> +
> +	STL
> >=20
> -	if (S) ST
> +	if (!S) return;
> +
> +	ST
> )
> 	...>
> =C2=A0}
>=20
> @transform_body depends on update_struct@
> identifier match_struct_reset.reset_func;
> identifier renamed_func.new_name;
> identifier S, P;
> expression PS;
> @@
> - void reset_func(struct drm_plane *P)
> + struct drm_plane_state *new_name(struct drm_plane *P)
> {
> 	...
> =C2=A0	S =3D kzalloc_obj(*S);
> 	...
> (
> =C2=A0	if (!S) {
> 		...
> -		return;
> +		return ERR_PTR(-ENOMEM);
> =C2=A0	}
> >=20
> =C2=A0	if (WARN_ON(!S)) {
> 		...
> -		return;
> +		return ERR_PTR(-ENOMEM);
> =C2=A0	}
> >=20
> =C2=A0	if (S =3D=3D NULL) {
> =C2=A0		...
> -		return;
> +		return ERR_PTR(-ENOMEM);
> =C2=A0	}
> )
> 	...
> (
> -	__drm_atomic_helper_plane_reset(P, PS);
> +	__drm_atomic_helper_plane_state_init(PS, P);
> >=20
> -	__drm_gem_reset_shadow_plane(P, PS);
> +	__drm_gem_shadow_plane_state_init(P, PS);
> )
> 	...
> }
>=20
> @update_early_return depends on update_struct@
> identifier match_struct_reset.reset_func;
> identifier renamed_func.new_name;
> identifier P;
> expression PS;
> @@
> =C2=A0struct drm_plane_state *new_name(struct drm_plane *P)
> {
> 	<+...
> -	return;
> +	return ERR_PTR(-EINVAL);
> 	...+>
> }
>=20
> @update_return_plane depends on update_struct@
> identifier match_struct_reset.reset_func;
> identifier renamed_func.new_name;
> identifier P;
> expression PS;
> @@
> =C2=A0struct drm_plane_state *new_name(struct drm_plane *P)
> {
> 	...
> =C2=A0	__drm_atomic_helper_plane_state_init(PS, P);
> 	...
> +
> +	return PS;
> }
>=20
> @update_return_shadow depends on update_struct@
> identifier renamed_func.new_name;
> identifier P;
> expression PS;
> @@
> =C2=A0struct drm_plane_state *new_name(struct drm_plane *P)
> {
> 	...
> =C2=A0	__drm_gem_shadow_plane_state_init(P, PS);
> 	...
> +
> +	return &PS->base;
> }
>=20
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Acked-by: Paul Cercueil <paul@crapouillou.net>

Cheers,
-Paul

> ---
> Cc: linux-mips@vger.kernel.org
> Cc: paul@crapouillou.net
> ---
> =C2=A0drivers/gpu/drm/ingenic/ingenic-drm-drv.c | 2 +-
> =C2=A0drivers/gpu/drm/ingenic/ingenic-ipu.c=C2=A0=C2=A0=C2=A0=C2=A0 | 2 +=
-
> =C2=A02 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
> b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
> index 7e569af22391..396b812568a4 100644
> --- a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
> +++ b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
> @@ -985,11 +985,11 @@ static const struct drm_driver
> ingenic_drm_driver_data =3D {
> =C2=A0};
> =C2=A0
> =C2=A0static const struct drm_plane_funcs ingenic_drm_primary_plane_funcs
> =3D {
> =C2=A0	.update_plane		=3D drm_atomic_helper_update_plane,
> =C2=A0	.disable_plane		=3D drm_atomic_helper_disable_plane,
> -	.reset			=3D drm_atomic_helper_plane_reset,
> +	.atomic_create_state =3D drm_atomic_helper_plane_create_state,
> =C2=A0	.destroy		=3D drm_plane_cleanup,
> =C2=A0
> =C2=A0	.atomic_duplicate_state	=3D
> drm_atomic_helper_plane_duplicate_state,
> =C2=A0	.atomic_destroy_state	=3D
> drm_atomic_helper_plane_destroy_state,
> =C2=A0};
> diff --git a/drivers/gpu/drm/ingenic/ingenic-ipu.c
> b/drivers/gpu/drm/ingenic/ingenic-ipu.c
> index 56143a191f36..bf24882e8d9f 100644
> --- a/drivers/gpu/drm/ingenic/ingenic-ipu.c
> +++ b/drivers/gpu/drm/ingenic/ingenic-ipu.c
> @@ -716,11 +716,11 @@ ingenic_ipu_plane_atomic_set_property(struct
> drm_plane *plane,
> =C2=A0}
> =C2=A0
> =C2=A0static const struct drm_plane_funcs ingenic_ipu_plane_funcs =3D {
> =C2=A0	.update_plane		=3D drm_atomic_helper_update_plane,
> =C2=A0	.disable_plane		=3D drm_atomic_helper_disable_plane,
> -	.reset			=3D drm_atomic_helper_plane_reset,
> +	.atomic_create_state =3D drm_atomic_helper_plane_create_state,
> =C2=A0	.destroy		=3D drm_plane_cleanup,
> =C2=A0
> =C2=A0	.atomic_duplicate_state	=3D
> drm_atomic_helper_plane_duplicate_state,
> =C2=A0	.atomic_destroy_state	=3D
> drm_atomic_helper_plane_destroy_state,
> =C2=A0
