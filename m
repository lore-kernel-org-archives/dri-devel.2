Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02E66C79F8C
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 10:00:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62AA510F080;
	Wed,  9 Sep 2026 10:00:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="pq7xzWb8";
	dkim-atps=neutral
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5AF210F080
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 10:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
 bh=FgD35pJ/63i446Ew876QrrSReSn6cC76bWMhun13S24=; b=pq7xzWb8yKj6T054GsfnRDUGEd
 kveBzPiFZvRPfV6Ku0oEFpasOP8sPaeL7hU0ZBz22U6brJI7DBKOTESl9YB9eiL41wkwd7V8sNL+l
 OaEYlngjRHZG4VWo/Vf8VJX00tjq4xnT8fcUUXqqFspBRD4881U9mryO8FeoGP/NNUq9FvD3Ewgoy
 5pe3lj2pe2bFWbroSI5K2z/EULPNhwdCTgkTglJ4ww/fWcG+iPWWcOmdHyLsZPGX64Ujf60GwWIpB
 j7400qv89rgjq4ZWOY5hdjxHB4a34VEcOo1QBuzsHmMvFElR+MVR+ENYq4d4RGQX36pWGnbc92b1l
 SUp9tnvw==;
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Maxime Ripard <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>,
 andy.yan@rock-chips.com, hjc@rock-chips.com,
 linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v4 15/41] drm/rockchip: Convert to atomic_create_state
Date: Wed, 09 Sep 2026 12:00:07 +0200
Message-ID: <10120529.VV5PYv0bhD@diego>
In-Reply-To: <20260908-drm-no-more-plane-reset-v4-15-a31b3fcfc989@kernel.org>
References: <20260908-drm-no-more-plane-reset-v4-0-a31b3fcfc989@kernel.org>
 <20260908-drm-no-more-plane-reset-v4-15-a31b3fcfc989@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

Am Dienstag, 8. September 2026, 16:46:46 Mitteleurop=C3=A4ische Sommerzeit =
schrieb Maxime Ripard:
> The plane only initializes a pristine state in its reset hook
> using drm_atomic_helper_plane_reset(), which is equivalent to what
> atomic_create_state expects. Convert to it.
>=20
> The conversion was done using the following Coccinelle semantic patch:
>=20
> @@
> identifier funcs;
> symbol drm_atomic_helper_plane_reset;
> symbol drm_atomic_helper_plane_create_state;
> @@
>=20
> struct drm_plane_funcs funcs =3D {
>   ...,
> - .reset =3D drm_atomic_helper_plane_reset,
> + .atomic_create_state =3D drm_atomic_helper_plane_create_state,
>   ...,
> };
>=20
> @match_struct_reset@
> identifier funcs, reset_func;
> @@
> struct drm_plane_funcs funcs =3D {
>     ...,
>     .reset =3D reset_func,
>     ...,
> };
>=20
> @reset_uses_helpers depends on match_struct_reset@
> identifier match_struct_reset.reset_func;
> @@
>=20
>  void reset_func(...)
>  {
>  	<+...
> (
>  	__drm_atomic_helper_plane_reset(...);
> |
> 	__drm_gem_reset_shadow_plane(...);
> )
>  	...+>
>  }
>=20
> @match_struct_destroy@
> identifier funcs, destroy_func;
> @@
> struct drm_plane_funcs funcs =3D {
>     ...,
>     .atomic_destroy_state =3D destroy_func,
>     ...,
> };
>=20
> @script:python renamed_func@
> old_name << match_struct_reset.reset_func;
> new_name;
> @@
> if old_name.endswith("_reset"):
>     coccinelle.new_name =3D old_name.replace("_reset", "_create_state")
> else:
>     coccinelle.new_name =3D old_name
>=20
> @update_struct depends on match_struct_reset && reset_uses_helpers@
> identifier match_struct_reset.funcs, match_struct_reset.reset_func;
> identifier renamed_func.new_name;
> @@
> struct drm_plane_funcs funcs =3D {
>     ...,
> -   .reset =3D reset_func,
> +   .atomic_create_state =3D new_name,
>     ...,
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
>  void reset_func(struct drm_plane *P)
>  {
>  	...
> (
> -	if (P->state) {
> - 		<+...
> (
> -		drm_atomic_helper_plane_destroy_state(P, P->state);
> |
> -		__drm_atomic_helper_plane_destroy_state(P->state);
> |
> -		P->funcs->atomic_destroy_state(P, P->state);
> |
> -		destroy_func(P, P->state);
> )
> - 		...+>
> - 	}
> |
> -	drm_WARN_ON_ONCE(P->dev, P->state);
> |
> -	WARN_ON(P->state);
> )
>  	...
> (
> -	kfree(P->state);
> |
> -	kfree(container_func(P->state));
> |
>  	// kfree is optional
> )
> (
> -	P->state =3D NULL;
> |
>  	// plane->state clearing is optional
> )
>  	...
>  }
>=20
> @drop_destroy_mtk depends on update_struct@
> identifier P;
> symbol __drm_atomic_helper_plane_destroy_state;
> symbol to_mtk_plane_state;
> @@
>=20
>  void mtk_plane_reset(struct drm_plane *P)
>  {
>  	...
> -	if (P->state) {
> -		__drm_atomic_helper_plane_destroy_state(P->state);
> -		...
> -	} else {
>  		...
> -	}
>  	...
>  }
>=20
> @transform_nv50_wndw depends on update_struct@
> identifier S;
> @@
>=20
>  void nv50_wndw_reset(...)
>  {
>  	...
> -	if (WARN_ON(!(S =3D kzalloc_obj(*S))))
> +	S =3D kzalloc_obj(*S);
> +	if (WARN_ON(!S))
>  		return;
>  	...
>  }
>=20
> @transform_kzalloc depends on update_struct@
> identifier match_struct_reset.reset_func;
> identifier P, S;
> statement ST;
> statement list STL;
> @@
>=20
>  void reset_func(struct drm_plane *P)
>  {
>  	<...
>  	S =3D kzalloc_obj(*S);
> (
> -	if (S)
> -	{
> -		STL
> -	}
> +	if (!S) return;
> +
> +	STL
> |
> -	if (S) ST
> +	if (!S) return;
> +
> +	ST
> )
> 	...>
>  }
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
>  	S =3D kzalloc_obj(*S);
> 	...
> (
>  	if (!S) {
> 		...
> -		return;
> +		return ERR_PTR(-ENOMEM);
>  	}
> |
>  	if (WARN_ON(!S)) {
> 		...
> -		return;
> +		return ERR_PTR(-ENOMEM);
>  	}
> |
>  	if (S =3D=3D NULL) {
>  		...
> -		return;
> +		return ERR_PTR(-ENOMEM);
>  	}
> )
> 	...
> (
> -	__drm_atomic_helper_plane_reset(P, PS);
> +	__drm_atomic_helper_plane_state_init(PS, P);
> |
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
>  struct drm_plane_state *new_name(struct drm_plane *P)
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
>  struct drm_plane_state *new_name(struct drm_plane *P)
> {
> 	...
>  	__drm_atomic_helper_plane_state_init(PS, P);
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
>  struct drm_plane_state *new_name(struct drm_plane *P)
> {
> 	...
>  	__drm_gem_shadow_plane_state_init(P, PS);
> 	...
> +
> +	return &PS->base;
> }
>=20
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>



