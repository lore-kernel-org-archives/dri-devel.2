Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1913DC43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 07:11:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FAE810E7F4;
	Mon, 13 Jul 2026 07:10:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=proton.me header.i=@proton.me header.b="DQ0k1SsW";
	dkim-atps=neutral
Received: from mail-244103.protonmail.ch (mail-244103.protonmail.ch
 [109.224.244.103])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47C6110E605
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 16:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1783701603; x=1783960803;
 bh=W/GsfKPOaZSLDS+A7YXLVD02wrpyt4Mu3bl9AWPnlJI=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=DQ0k1SsWEv8zgcrJFrmXkesNbUCPOw13dfWiyV+Ym9suMYV27HFthkUifJFUEt6Oc
 C1FVruyabty+KEMZzJIjkVWaAUroqZipso7kKO8An/mGlT8DsBwurr8eutf+4841bn
 3q36QDuCkXz+ThcUPSrKvLQnCiwof0fPu9ezkbvTKz4YmHoHAjNedTH0LrSmIRGnON
 8hy+lI/K+tgtR/AzcQYo+I0OGoyksjBBnO9xl21XTmtMRQLJXhD1Awcp6t5WXedaO6
 Rmwbgh8azdYgljgu5HPcr75nB0hjbmjrQQXBetwnxx6GyQkQ7hwUGhl2A1vqlnLGBO
 bioifTYuqT0Jw==
Date: Fri, 10 Jul 2026 16:39:57 +0000
To: Maxime Ripard <mripard@kernel.org>
From: Aditya Garg <gargaditya08@proton.me>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 admin@kodeit.net
Subject: Re: [PATCH 10/60] drm/appletbdrm: Convert to atomic_create_state
Message-ID: <z0B1fK_tCddwbXPhrtdbaFsc0NW7GFsKair7OQgyayEFkVtPegjPJJTzTHGuPqVjFOFDK_TtAr5Jployn7WW2u9wSBO-EnYoBglVQwOYem4=@proton.me>
In-Reply-To: <20260709-drm-no-more-plane-reset-v1-10-302d986fe5f0@kernel.org>
References: <20260709-drm-no-more-plane-reset-v1-0-302d986fe5f0@kernel.org>
 <20260709-drm-no-more-plane-reset-v1-10-302d986fe5f0@kernel.org>
Feedback-ID: 145777226:user:proton
X-Pm-Message-ID: 17797ba9b4727fef5549ba068fe17633bf12f0de
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 13 Jul 2026 07:10:39 +0000
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

Acked-by: Aditya Garg <gargaditya08@proton.me>

On Thursday, 9 July 2026 at 5:21 PM, Maxime Ripard <mripard@kernel.org> wro=
te:

> The plane reset implementation creates a custom state subclass, but
> only initializes a pristine state without resetting any hardware. This
> is equivalent to what atomic_create_state expects. Convert to it.
>
> The conversion was done using the following Coccinelle semantic patch:
>
> @@
> identifier funcs;
> symbol drm_atomic_helper_plane_reset;
> symbol drm_atomic_helper_plane_create_state;
> @@
>
> struct drm_plane_funcs funcs =3D {
>   ...,
> - .reset =3D drm_atomic_helper_plane_reset,
> + .atomic_create_state =3D drm_atomic_helper_plane_create_state,
>   ...,
> };
>
> @match_struct_reset@
> identifier funcs, reset_func;
> @@
> struct drm_plane_funcs funcs =3D {
>     ...,
>     .reset =3D reset_func,
>     ...,
> };
>
> @reset_uses_helpers depends on match_struct_reset@
> identifier match_struct_reset.reset_func;
> @@
>
>  void reset_func(...)
>  {
>  =09<+...
> (
>  =09__drm_atomic_helper_plane_reset(...);
> |
> =09__drm_gem_reset_shadow_plane(...);
> )
>  =09...+>
>  }
>
> @match_struct_destroy@
> identifier funcs, destroy_func;
> @@
> struct drm_plane_funcs funcs =3D {
>     ...,
>     .atomic_destroy_state =3D destroy_func,
>     ...,
> };
>
> @script:python renamed_func@
> old_name << match_struct_reset.reset_func;
> new_name;
> @@
> if old_name.endswith("_reset"):
>     coccinelle.new_name =3D old_name.replace("_reset", "_create_state")
> else:
>     coccinelle.new_name =3D old_name
>
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
>
> @drop_destroy depends on update_struct && match_struct_destroy@
> identifier match_struct_reset.reset_func;
> identifier match_struct_destroy.destroy_func;
> identifier container_func;
> identifier P;
> symbol drm_atomic_helper_plane_destroy_state;
> symbol __drm_atomic_helper_plane_destroy_state;
> @@
>
>  void reset_func(struct drm_plane *P)
>  {
>  =09...
> (
> -=09if (P->state) {
> - =09=09<+...
> (
> -=09=09drm_atomic_helper_plane_destroy_state(P, P->state);
> |
> -=09=09__drm_atomic_helper_plane_destroy_state(P->state);
> |
> -=09=09P->funcs->atomic_destroy_state(P, P->state);
> |
> -=09=09destroy_func(P, P->state);
> )
> - =09=09...+>
> - =09}
> |
> -=09drm_WARN_ON_ONCE(P->dev, P->state);
> |
> -=09WARN_ON(P->state);
> )
>  =09...
> (
> -=09kfree(P->state);
> |
> -=09kfree(container_func(P->state));
> |
>  =09// kfree is optional
> )
> (
> -=09P->state =3D NULL;
> |
>  =09// plane->state clearing is optional
> )
>  =09...
>  }
>
> @drop_destroy_mtk depends on update_struct@
> identifier P;
> symbol __drm_atomic_helper_plane_destroy_state;
> symbol to_mtk_plane_state;
> @@
>
>  void mtk_plane_reset(struct drm_plane *P)
>  {
>  =09...
> -=09if (P->state) {
> -=09=09__drm_atomic_helper_plane_destroy_state(P->state);
> -=09=09...
> -=09} else {
>  =09=09...
> -=09}
>  =09...
>  }
>
> @transform_nv50_wndw depends on update_struct@
> identifier S;
> @@
>
>  void nv50_wndw_reset(...)
>  {
>  =09...
> -=09if (WARN_ON(!(S =3D kzalloc_obj(*S))))
> +=09S =3D kzalloc_obj(*S);
> +=09if (WARN_ON(!S))
>  =09=09return;
>  =09...
>  }
>
> @transform_kzalloc depends on update_struct@
> identifier match_struct_reset.reset_func;
> identifier P, S;
> statement ST;
> statement list STL;
> @@
>
>  void reset_func(struct drm_plane *P)
>  {
>  =09<...
>  =09S =3D kzalloc_obj(*S);
> (
> -=09if (S)
> -=09{
> -=09=09STL
> -=09}
> +=09if (!S) return;
> +
> +=09STL
> |
> -=09if (S) ST
> +=09if (!S) return;
> +
> +=09ST
> )
> =09...>
>  }
>
> @transform_body depends on update_struct@
> identifier match_struct_reset.reset_func;
> identifier renamed_func.new_name;
> identifier S, P;
> expression PS;
> @@
> - void reset_func(struct drm_plane *P)
> + struct drm_plane_state *new_name(struct drm_plane *P)
> {
> =09...
>  =09S =3D kzalloc_obj(*S);
> =09...
> (
>  =09if (!S) {
> =09=09...
> -=09=09return;
> +=09=09return ERR_PTR(-ENOMEM);
>  =09}
> |
>  =09if (WARN_ON(!S)) {
> =09=09...
> -=09=09return;
> +=09=09return ERR_PTR(-ENOMEM);
>  =09}
> |
>  =09if (S =3D=3D NULL) {
>  =09=09...
> -=09=09return;
> +=09=09return ERR_PTR(-ENOMEM);
>  =09}
> )
> =09...
> (
> -=09__drm_atomic_helper_plane_reset(P, PS);
> +=09__drm_atomic_helper_plane_state_init(PS, P);
> |
> -=09__drm_gem_reset_shadow_plane(P, PS);
> +=09__drm_gem_shadow_plane_state_init(P, PS);
> )
> =09...
> }
>
> @update_early_return depends on update_struct@
> identifier match_struct_reset.reset_func;
> identifier renamed_func.new_name;
> identifier P;
> expression PS;
> @@
>  struct drm_plane_state *new_name(struct drm_plane *P)
> {
> =09<+...
> -=09return;
> +=09return ERR_PTR(-EINVAL);
> =09...+>
> }
>
> @update_return_plane depends on update_struct@
> identifier match_struct_reset.reset_func;
> identifier renamed_func.new_name;
> identifier P;
> expression PS;
> @@
>  struct drm_plane_state *new_name(struct drm_plane *P)
> {
> =09...
>  =09__drm_atomic_helper_plane_state_init(PS, P);
> =09...
> +
> +=09return PS;
> }
>
> @update_return_shadow depends on update_struct@
> identifier renamed_func.new_name;
> identifier P;
> expression PS;
> @@
>  struct drm_plane_state *new_name(struct drm_plane *P)
> {
> =09...
>  =09__drm_gem_shadow_plane_state_init(P, PS);
> =09...
> +
> +=09return &PS->base;
> }
>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
> Cc: admin@kodeit.net
> Cc: gargaditya08@proton.me
> ---
>  drivers/gpu/drm/tiny/appletbdrm.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/tiny/appletbdrm.c b/drivers/gpu/drm/tiny/app=
letbdrm.c
> index cdd35af49892..742478198111 100644
> --- a/drivers/gpu/drm/tiny/appletbdrm.c
> +++ b/drivers/gpu/drm/tiny/appletbdrm.c
> @@ -497,21 +497,21 @@ static void appletbdrm_primary_plane_helper_atomic_=
disable(struct drm_plane *pla
>  =09appletbdrm_clear_display(adev);
>
>  =09drm_dev_exit(idx);
>  }
>
> -static void appletbdrm_primary_plane_reset(struct drm_plane *plane)
> +static struct drm_plane_state *appletbdrm_primary_plane_create_state(str=
uct drm_plane *plane)
>  {
>  =09struct appletbdrm_plane_state *appletbdrm_state;
>
> -=09WARN_ON(plane->state);
> -
>  =09appletbdrm_state =3D kzalloc_obj(*appletbdrm_state);
>  =09if (!appletbdrm_state)
> -=09=09return;
> +=09=09return ERR_PTR(-ENOMEM);
>
> -=09__drm_gem_reset_shadow_plane(plane, &appletbdrm_state->base);
> +=09__drm_gem_shadow_plane_state_init(plane, &appletbdrm_state->base);
> +
> +=09return &(&appletbdrm_state->base)->base;
>  }
>
>  static struct drm_plane_state *appletbdrm_primary_plane_duplicate_state(=
struct drm_plane *plane)
>  {
>  =09struct drm_shadow_plane_state *new_shadow_plane_state;
> @@ -559,11 +559,11 @@ static const struct drm_plane_helper_funcs appletbd=
rm_primary_plane_helper_funcs
>  };
>
>  static const struct drm_plane_funcs appletbdrm_primary_plane_funcs =3D {
>  =09.update_plane =3D drm_atomic_helper_update_plane,
>  =09.disable_plane =3D drm_atomic_helper_disable_plane,
> -=09.reset =3D appletbdrm_primary_plane_reset,
> +=09.atomic_create_state =3D appletbdrm_primary_plane_create_state,
>  =09.atomic_duplicate_state =3D appletbdrm_primary_plane_duplicate_state,
>  =09.atomic_destroy_state =3D appletbdrm_primary_plane_destroy_state,
>  =09.destroy =3D drm_plane_cleanup,
>  };
>
>
> --
> 2.54.0
>
>
