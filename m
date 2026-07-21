Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D962C4452B
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 20:21:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C390F10E1A1;
	Tue, 21 Jul 2026 20:21:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="MtRYTBAZ";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C343310EB4C
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 20:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784665294;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mlnFQ99aa8t0Pw6apvxh40TvR2813sTRYaAICMkMrLE=;
 b=MtRYTBAZUyXSVK4xVy/uqKNYo6FJHtBnc9xTI5q6Y+uU13GCLbm3NyD8ihDK2SPr5PJzAT
 bdpU1OsUZegoK2PyMTiyb2FV4nYxprzLPvQoJsm5Wn7JAZ3pDmZkvvkD0fdoLfXMfKBBQO
 peQ+H26iTqZcPoCBs4kk0sQpl+XuFX8=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-100-_7xRUdUeOg6QSUgkGoe_8g-1; Tue, 21 Jul 2026 16:21:33 -0400
X-MC-Unique: _7xRUdUeOg6QSUgkGoe_8g-1
X-Mimecast-MFC-AGG-ID: _7xRUdUeOg6QSUgkGoe_8g_1784665293
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-5276aa86d00so9695481cf.2
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 13:21:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784665293; x=1785270093;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+i9xLnOHuwiwHa9K/+d5RIhTcAexDbG5V5/jyv0DPH4=;
 b=XVoA2e8VwQnMWqLEdNdrf+UXT38gkrmUK8MWhRDMYGGY7lWkRY/cs7ZjUFsvA/DHMR
 9TCXp8R+aT7YtQmvbl+7VR4peKOtiCShHOinw+3NMPpBfh7dyfZzTH71NHGUrBkpBdIW
 LIejQwNjK/iRz7mN/l7/s3YorRCfgBqSU3n4WjZD55yl2byjSsiMVkWAmvTpSLqOgnXU
 u0kr0XiF9/GBFWTlH8KvhFyp+JMhkAbE0PjBIKkQ9mdznNJu2ksqVlrGUA9kKvICrqjk
 tUuRayF5miOTIVB3CleB93eXue/vbDkqTLKgsiKZE3huVWLS2Kr0mcS8d2oQ2q3QmgBY
 Za9w==
X-Gm-Message-State: AOJu0YzzdCTqbvKweUJ3qnBYEhZZbI/p6R/g91uLUBVCKg5Duosmb6UR
 bYizuF+AnD6NPMcJGu5zgF6xm7OAor8zSApZULoo08jquhJeguIp1PbJVdgp/OE3qH9pdIJTI+e
 ITI2SHemvnyA7L1HPblf4UWuPRsXdx5itJzqlWF2p1mnxaQXoFmQe8LdpHERa26V+UIXXGg==
X-Gm-Gg: AfdE7cllpIukhxVYKvsBaLzUkEGd3A+OioSlC9WOTBa7eR32atrC9GPps/uXoyln5Qt
 fV5SiW3x1jM7MplPpKgMr68Z02c3jJPckd2oqaccRV4uezRAAoEg4k39NGJgfG3W0pC0dOFehw1
 kVGzfEB+3d+Lg22UVKRYplH/GQBmQ0hh9npGXwGegJfxJyUTL+ARN8osb1172JhGG83ds3wcr6a
 UO0P/oCmfVl0yQInuUHwIOf0vjQ1c3/04jf2Ip1VfrDqbkOvr7vxAURBa46tQa76hutGO1wNf4X
 E5WtCxlNzvReg8IbrLdeQ+Yj3s9NjivROBI1a6lKIFk+LXjgS1v2qeemLOaKBPNruCpr4qOY
X-Received: by 2002:ac8:59d2:0:b0:51c:7b12:5ff2 with SMTP id
 d75a77b69052e-5213d7a6561mr180315271cf.78.1784665292822; 
 Tue, 21 Jul 2026 13:21:32 -0700 (PDT)
X-Received: by 2002:ac8:59d2:0:b0:51c:7b12:5ff2 with SMTP id
 d75a77b69052e-5213d7a6561mr180314731cf.78.1784665292053; 
 Tue, 21 Jul 2026 13:21:32 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-527d3b4149bsm2060001cf.28.2026.07.21.13.21.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 13:21:31 -0700 (PDT)
Message-ID: <f0d8c411b2f58a15ac01b5e638f4c871a6c0b110.camel@redhat.com>
Subject: Re: [PATCH v2 3/3] drm/nouveau/kms/nv50-: Unconditionally create
 blend_mode prop for wndws
From: lyude@redhat.com
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
Date: Tue, 21 Jul 2026 16:21:30 -0400
In-Reply-To: <20260720211503.4BA811F000E9@smtp.kernel.org>
References: <20260720205541.257781-1-lyude@redhat.com>
 <20260720205541.257781-4-lyude@redhat.com>
 <20260720211503.4BA811F000E9@smtp.kernel.org>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: thmWWqlTwq6lW076PBaEpYwdKI6TDFG5TQ4ZBSyamlE_1784665293
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

On Mon, 2026-07-20 at 21:15 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
> - [Medium] The patch introduces a conditional check that contradicts
> its commit message and results in an incomplete fix for a DRM core
> WARN_ON. While claiming to 'unconditionally create blend_mode prop
> for wndws', the code limits this to planes where `func->blend_modes`
> is non-zero. Older primary planes (e.g., `base507c`) expose alpha
> formats but lack `.blend_modes` initialization, meaning they will
> still trigger the warning.
> --
>=20
> --- Patch [3]: [PATCH v2 3/3] drm/nouveau/kms/nv50-: Unconditionally
> create blend_mode prop for wndws ---
> commit d890a1a203754ff1359f8cdacfa01e033bb7b8f3
> Author: Lyude Paul <lyude@redhat.com>
> drm/nouveau/kms/nv50-: Unconditionally create blend_mode prop for
> wndws
>=20
> This patch attempts to resolve a DRM core validation warning by
> ensuring the
> blend_mode property is created for all window types that expose color
> formats
> with an alpha channel, even if they lack a blend_set function.
>=20
> > diff --git a/drivers/gpu/drm/nouveau/dispnv50/wndw.c
> > b/drivers/gpu/drm/nouveau/dispnv50/wndw.c
> > index 0f331f47bded8..84b9a16bdb8ab 100644
> > --- a/drivers/gpu/drm/nouveau/dispnv50/wndw.c
> > +++ b/drivers/gpu/drm/nouveau/dispnv50/wndw.c
>=20
> [ ... ]
>=20
> > @@ -944,6 +937,17 @@ nv50_wndw_new_(const struct nv50_wndw_func
> > *func, struct drm_device *dev,
> > =C2=A0=09=09=09return ret;
> > =C2=A0=09}
> > =C2=A0
> > +=09/*
> > +=09 * DRM requires that we have a blend mode property for any
> > type of plane that exposes color
> > +=09 * formats with an alpha channel. So do this, even if we
> > don't actually have control for the
> > +=09 * blend property hooked up with blend_set.
> > +=09 */
> > +=09if (func->blend_modes) {
>=20
> [Severity: Medium]
> Does this conditional check contradict the commit message? The commit
> states
> the blend_mode property is created unconditionally for all types of
> wndws.
>=20
> However, for older primary planes like base507c, the nv50_wndw_func
> definition
> does not initialize .blend_modes:
>=20
> static const struct nv50_wndw_func
> base507c =3D {
> =09.acquire =3D base507c_acquire,
> =09.release =3D base507c_release,
> =09.sema_set =3D base507c_sema_set,
> =09...
>=20
> Since func->blend_modes evaluates to 0 here, the property creation is
> skipped.
>=20
> Because base507c_format exposes formats with an alpha channel (such
> as
> DRM_FORMAT_ARGB8888), won't skipping the property creation here leave
> the issue
> unfixed and cause the DRM core validation WARN_ON to still trigger?

this is kind of fascinating, it's referencing an issue that was on the
last version of this patch series but is most certainly fixed on this
patch series.

Weird.
>=20
> > +=09=09ret =3D drm_plane_create_blend_mode_property(&wndw-
> > >plane, func->blend_modes);
> > +=09=09if (ret)
> > +=09=09=09return ret;
> > +=09}
> > +
> > =C2=A0=09return 0;
> > =C2=A0}

