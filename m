Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50814C5B572
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 19:06:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7CCE10E1A8;
	Fri, 14 Aug 2026 19:06:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="E9R+qVB2";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3C4910E094
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 19:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786734413;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EXbV03SglUAVYkcsiKdvgl4+VZ/gbiiscwVTQZEGVe0=;
 b=E9R+qVB2so3N2ZPPiFsq7SkYwiBXN6sExlGEh2T2crrhGqf1SfhofzKyUnMqFlQYx6w4Jz
 fTVBoxLH4Jd+2Eto9seN2TN/HMQNjzZvQ3S4J8jIH6oRkwVHV+2SawXMR11n098N2fMd8T
 iUqqQNxWdUNIelBW4gm4mBs7AG3PUME=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-Pu9RjT9JP2acHwyl4uR4dg-1; Fri, 14 Aug 2026 15:06:52 -0400
X-MC-Unique: Pu9RjT9JP2acHwyl4uR4dg-1
X-Mimecast-MFC-AGG-ID: Pu9RjT9JP2acHwyl4uR4dg_1786734412
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-52d33c89a29so18424501cf.1
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 12:06:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786734412; x=1787339212;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WxFTX0yOJLZlCl8/a3EJL4yygyDVspCJMhQ7vy8Km48=;
 b=YOYCXdIA+oZjr89npxd21jdLkDnEC235Uu2H9HRUhD/BQ+I/JBsoWg2U7HbXjvINmF
 gkmOWLxgrEvPI28Cz4JDqWUJ1w6ekisp0DLbLbBXEBDIXPqRNqYFVJS/6CpaKQZfeFA0
 736irNS0bPqnYS++ijIAqis/9qWliuAgbAqEawZsdNePHT0PSn17Wx3IuSFbEoCjKUWC
 rv/UpjkOkTJcn512M4QOx8pNduLAHFXOpixTlQTPoM21/EhrvDyh5i2GNyLdgN2h0wJg
 7C1PwzGsfzRB/v+/JEI/fWCYLmy86bbyfI9eRzYNBpXJ08dg4SNZdwTex5hxErNQys6V
 5s3w==
X-Gm-Message-State: AOJu0YxZUPkkU4Lqpqp4qQsTVT3GdoXV84T1XXtze4NjPdX0RzWa7JMU
 pXG9QVfYfTpnTyuMf7TA0toYdhThtHxd+n31WItk9G4QvpvWvzmEF3NDgYxdOPI5gXUG7oAh7FJ
 7s7uAMObxWP+CQzmscEW0Djx4P8rLtZcCwJuusQy0ima1jsin7Z/T97HllBmXkmrd2UzybQ==
X-Gm-Gg: AR+sD11JFWUPhfDtzI1eaCQt2W3f6wYepBzFuJatcSsk3tAPjpt9P7m3Kc2+RLxJsqj
 MRPAWGTWCd2zfqBIHyQbhr9+xk8UatLVrLuQG2h6WrOi8b/djbPpdnNm6HKbOW9yqpXnoXVpK3G
 xWo+TsHckUV2VUoorAs0i4ICBdoJrqHeZExLnfuS1/il2qIBulDj5wvcH1RudB2usldK6nqaIRI
 Nvf1vPPdRJIpIKHiTabqzLc8KOAzLoJM0XoGWkNLg7yKk73GMBy/ZIdFY+bF/tAp0UA7Z2tBS3X
 RYtdJhabsPrNWe8A3Qfu0TuE5ZjL882AJh5cO8DgMTeTifqahrXe0+78oN+U3ifMw0qbxuQW
X-Received: by 2002:a05:622a:98f:b0:516:d699:a99b with SMTP id
 d75a77b69052e-52d854dfe55mr100186741cf.40.1786734412089; 
 Fri, 14 Aug 2026 12:06:52 -0700 (PDT)
X-Received: by 2002:a05:622a:98f:b0:516:d699:a99b with SMTP id
 d75a77b69052e-52d854dfe55mr100185681cf.40.1786734411401; 
 Fri, 14 Aug 2026 12:06:51 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52d83ef920csm27229611cf.8.2026.08.14.12.06.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 12:06:50 -0700 (PDT)
Message-ID: <fcfc05b3197c0318ecdd8e60597b618f366eb8d3.camel@redhat.com>
Subject: Re: [PATCH v2 51/61] drm/nouveau: Convert to atomic_create_state
From: lyude@redhat.com
To: Maxime Ripard <mripard@kernel.org>, Maarten Lankhorst	
 <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>,  David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, dakr@kernel.org, 
 nouveau@lists.freedesktop.org
Date: Fri, 14 Aug 2026 15:06:49 -0400
In-Reply-To: <20260814-drm-no-more-plane-reset-v2-51-82d2963dd134@kernel.org>
References: <20260814-drm-no-more-plane-reset-v2-0-82d2963dd134@kernel.org>
 <20260814-drm-no-more-plane-reset-v2-51-82d2963dd134@kernel.org>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OXQ0Ifz3J8d425PaWb3SRTuqRPeHcFYDJEiQxoRS2Ps_1786734412
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, 2026-08-14 at 16:57 +0200, Maxime Ripard wrote:
> The plane reset implementation creates a custom state
> subclass, but only initializes a pristine state without resetting any
> hardware. This is equivalent to what atomic_create_state expects.
> Convert to it.
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
> =C2=A0=09<+...
> (
> =C2=A0=09__drm_atomic_helper_plane_reset(...);
> >=20
> =09__drm_gem_reset_shadow_plane(...);
> )
> =C2=A0=09...+>
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
> =C2=A0=09...
> (
> -=09if (P->state) {
> -=C2=A0=09=09<+...
> (
> -=09=09drm_atomic_helper_plane_destroy_state(P, P->state);
> >=20
> -=09=09__drm_atomic_helper_plane_destroy_state(P->state);
> >=20
> -=09=09P->funcs->atomic_destroy_state(P, P->state);
> >=20
> -=09=09destroy_func(P, P->state);
> )
> -=C2=A0=09=09...+>
> -=C2=A0=09}
> >=20
> -=09drm_WARN_ON_ONCE(P->dev, P->state);
> >=20
> -=09WARN_ON(P->state);
> )
> =C2=A0=09...
> (
> -=09kfree(P->state);
> >=20
> -=09kfree(container_func(P->state));
> >=20
> =C2=A0=09// kfree is optional
> )
> (
> -=09P->state =3D NULL;
> >=20
> =C2=A0=09// plane->state clearing is optional
> )
> =C2=A0=09...
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
> =C2=A0=09...
> -=09if (P->state) {
> -=09=09__drm_atomic_helper_plane_destroy_state(P->state);
> -=09=09...
> -=09} else {
> =C2=A0=09=09...
> -=09}
> =C2=A0=09...
> =C2=A0}
>=20
> @transform_nv50_wndw depends on update_struct@
> identifier S;
> @@
>=20
> =C2=A0void nv50_wndw_reset(...)
> =C2=A0{
> =C2=A0=09...
> -=09if (WARN_ON(!(S =3D kzalloc_obj(*S))))
> +=09S =3D kzalloc_obj(*S);
> +=09if (WARN_ON(!S))
> =C2=A0=09=09return;
> =C2=A0=09...
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
> =C2=A0=09<...
> =C2=A0=09S =3D kzalloc_obj(*S);
> (
> -=09if (S)
> -=09{
> -=09=09STL
> -=09}
> +=09if (!S) return;
> +
> +=09STL
> >=20
> -=09if (S) ST
> +=09if (!S) return;
> +
> +=09ST
> )
> =09...>
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
> =09...
> =C2=A0=09S =3D kzalloc_obj(*S);
> =09...
> (
> =C2=A0=09if (!S) {
> =09=09...
> -=09=09return;
> +=09=09return ERR_PTR(-ENOMEM);
> =C2=A0=09}
> >=20
> =C2=A0=09if (WARN_ON(!S)) {
> =09=09...
> -=09=09return;
> +=09=09return ERR_PTR(-ENOMEM);
> =C2=A0=09}
> >=20
> =C2=A0=09if (S =3D=3D NULL) {
> =C2=A0=09=09...
> -=09=09return;
> +=09=09return ERR_PTR(-ENOMEM);
> =C2=A0=09}
> )
> =09...
> (
> -=09__drm_atomic_helper_plane_reset(P, PS);
> +=09__drm_atomic_helper_plane_state_init(PS, P);
> >=20
> -=09__drm_gem_reset_shadow_plane(P, PS);
> +=09__drm_gem_shadow_plane_state_init(P, PS);
> )
> =09...
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
> =09<+...
> -=09return;
> +=09return ERR_PTR(-EINVAL);
> =09...+>
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
> =09...
> =C2=A0=09__drm_atomic_helper_plane_state_init(PS, P);
> =09...
> +
> +=09return PS;
> }
>=20
> @update_return_shadow depends on update_struct@
> identifier renamed_func.new_name;
> identifier P;
> expression PS;
> @@
> =C2=A0struct drm_plane_state *new_name(struct drm_plane *P)
> {
> =09...
> =C2=A0=09__drm_gem_shadow_plane_state_init(P, PS);
> =09...
> +
> +=09return &PS->base;
> }
>=20
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
> Cc: dakr@kernel.org
> Cc: lyude@redhat.com
> Cc: nouveau@lists.freedesktop.org
> ---
> =C2=A0drivers/gpu/drm/nouveau/dispnv50/wndw.c | 15 +++++++--------
> =C2=A01 file changed, 7 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/nouveau/dispnv50/wndw.c
> b/drivers/gpu/drm/nouveau/dispnv50/wndw.c
> index 15a322422f4e..378095138d12 100644
> --- a/drivers/gpu/drm/nouveau/dispnv50/wndw.c
> +++ b/drivers/gpu/drm/nouveau/dispnv50/wndw.c
> @@ -750,22 +750,21 @@ nv50_wndw_zpos_default(struct drm_plane *plane)
> =C2=A0{
> =C2=A0=09return (plane->type =3D=3D DRM_PLANE_TYPE_PRIMARY) ? 0 :
> =C2=A0=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (plane->type =3D=3D DRM_PLA=
NE_TYPE_OVERLAY) ? 1 : 255;
> =C2=A0}
> =C2=A0
> -static void
> -nv50_wndw_reset(struct drm_plane *plane)
> +static struct drm_plane_state *nv50_wndw_create_state(struct
> drm_plane *plane)
> =C2=A0{
> =C2=A0=09struct nv50_wndw_atom *asyw;
> =C2=A0
> -=09if (WARN_ON(!(asyw =3D kzalloc_obj(*asyw))))
> -=09=09return;
> +=09asyw =3D kzalloc_obj(*asyw);
> +=09if (WARN_ON(!asyw))
> +=09=09return ERR_PTR(-ENOMEM);

Should this be drm_WARN_ON() while we're at it?

Otherwise, this looks good to me:

Reviewed-by: Lyude Paul <lyude@redhat.com>

> =C2=A0
> -=09if (plane->state)
> -=09=09plane->funcs->atomic_destroy_state(plane, plane-
> >state);
> +=09__drm_atomic_helper_plane_state_init(&asyw->state, plane);
> =C2=A0
> -=09__drm_atomic_helper_plane_reset(plane, &asyw->state);
> +=09return &asyw->state;
> =C2=A0}
> =C2=A0
> =C2=A0static void
> =C2=A0nv50_wndw_destroy(struct drm_plane *plane)
> =C2=A0{
> @@ -835,11 +834,11 @@ static bool
> nv50_plane_format_mod_supported(struct drm_plane *plane,
> =C2=A0const struct drm_plane_funcs
> =C2=A0nv50_wndw =3D {
> =C2=A0=09.update_plane =3D drm_atomic_helper_update_plane,
> =C2=A0=09.disable_plane =3D drm_atomic_helper_disable_plane,
> =C2=A0=09.destroy =3D nv50_wndw_destroy,
> -=09.reset =3D nv50_wndw_reset,
> +=09.atomic_create_state =3D nv50_wndw_create_state,
> =C2=A0=09.atomic_duplicate_state =3D nv50_wndw_atomic_duplicate_state,
> =C2=A0=09.atomic_destroy_state =3D nv50_wndw_atomic_destroy_state,
> =C2=A0=09.format_mod_supported =3D nv50_plane_format_mod_supported,
> =C2=A0};
> =C2=A0

