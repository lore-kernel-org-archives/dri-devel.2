Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809C3606A327
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 08:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mTIvNp02
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E26F810F375;
	Tue, 20 Oct 2026 08:10:06 +0000 (UTC)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com
 [209.85.208.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A110E10F375
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 08:10:00 +0000 (UTC)
Received: by mail-lj1-f179.google.com with SMTP id
 38308e7fff4ca-3ab27b4924aso19413581fa.2
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 01:10:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792483799; cv=none;
 d=google.com; s=arc-20260327;
 b=Uy3lSaoKMLEZ2M322ihdqLbEmg8Wn50Gxq5PsLNjwjoHqtUskakbElTn7X5nldN3XG
 vOHdj/Jykemn3lQqyj1SolkCS2VeVlhhik5YQySee4Bc6S6EU07Nlzjc1P4wKolFehu2
 Vk3YYZOOcsrOclgVgXV4//3sqVyr1QP90Y4P5671Xp3hdQCtpJ+Y3shohWTehRyEiPO9
 jc2WYlUUMSf/itBeQ5xlBk9AZI8995s2rCc8E2dhspp10ojaNWJ0j/+/YFGCX9Ai1Q0X
 OCfDQ6IeFrDFpPZo5VpqQtZUup7YDu73FpoTsgU8c2KMdGfFJOYFJxQimQoQphVpFczD
 3rqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=V6mptVN35vJ98NYii+6LNnGBoOW3foxwKoXliiFVg4k=;
 fh=eYamT9vW+Xz8x0yCsPdJ7USCGTI6WVyjLhpbrHduwJ0=;
 b=Za3QjyE7A9PdAPmYbPhkD0qHTFVHC8s/CQ1VuyZSLK3BbK4g+jmwjE/hUDc6Tt2585
 XAVwWY92FV4D+QH17kNRAGHb5z7VzINWl8c85TSD59UTSrUiBYBDaSktZBPyn1j+OtHq
 IC4QtXoCYNP0BCZ3qVz6MlzaVU+DqLYYjiqlA0RJV9cQp+kbpbvtKbMhQqKIrvwSn0VM
 Cte07HJVRkT4ooYl7i6PQFNehb7l8h6rKEaLpBmCb8ySWOBDrNVlFDWF9GZRD1tbK0Qn
 avhWMuGgE8Hb0G+Fmd2a7J2WFAv33CW4yYMSZLg9gR2/wU9pGkXeDU81AvkNi2nad3Wl
 d3Hg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792483799; x=1793088599; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=V6mptVN35vJ98NYii+6LNnGBoOW3foxwKoXliiFVg4k=;
 b=mTIvNp02nzGg4Z7nNxGrIA4uvJzsHuQp8MUC41TuP8qYkVo9jV8TBJQTiXnRAsZ6eX
 yFoy6uU4bqEa+RGtcFc++u5F3Z7PJTzDJ19qfM3+suRarBDVztg1dWwe9dt+S95Qg7JF
 vxxGZaAN1LM1pfWQg9DLIY191wqO7q41CbezQ2oG9QXQPnqn70CJEXN+pbUIl8/dVNZU
 AX8MfoTEJohymdzWXkAKmPIpt664up+krN/zcLwwgC56/yd1SW6HkWJZaRo6W/Pdaah/
 RpnPf8BpbczkmSl7x1on/fTUlwyPzoza+MdAO3tQVr+ZndHWKmwIa4jASo1YXQ6bkpnS
 E0cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792483799; x=1793088599;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=V6mptVN35vJ98NYii+6LNnGBoOW3foxwKoXliiFVg4k=;
 b=was05K7hqaOFix4GnJfTw4oZCDHhLWbYohhjlX00l2HXAb0KdhqX90K/o81/1dpenY
 DKsGFxNOendKhR4KK4WKKnCnTpsAqFmRi5Now6RQoQqHslEQS7l3KtBFBCszxP9chX2y
 Ho926XkRPc7B+mkitJGGLbikfDShIckaRB98dany56jNhV8ITyzTiY8Tw1tnzijS8G0f
 stkpfIh5jeYLbPjkTZh4B0ERtCvSBM76f76FLsJ1unWo20Q0/8SZa3ozXfBOn9VafVNb
 62BJoadp1Jd5NVkJxl/bPbsusscXWJZC2zXZs6U0xFpPX2In2oMRIuDgd2jHILAUoFlD
 z7yw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzNvZYMCR2cGJGIvF0tSrIK4VkB8Fwyf+4jbEZrd4npN1ZY750TvesT34+QPZ9qY7GaFDI7KXGY43U=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKLOIKJvDDSD8KFFDOFY+B2r5tVfF6ANeWuDtcFCzi8o9bzriE/
 zZ40RAmMcq12aw+0x4gZvsE/Kbgrj7kFgTgxfSrFRDLBvb+9B1I2/gIDPU86D8Izy4aF/e2cjf3
 YNoJLtAhMMPi0SxLyuoRfzB3lJ2PR/Ak=
X-Gm-Gg: AYBFou0Ju30rqWbmB4UkXYL/7nwpkogiU5HH3VMFlRTqObtNTbnWkXjV8a96JWrRDMb
 cEon5wrhXrz7d/WNB2ghprKCVI29gVgvKacrN+dF8Za/6UM3BM4wnBGXJFHQ5DblLEmdgAagdTH
 RNEMxjY8aeOphawfYjrhI4VZ82ns+pGBTyxGtmBRTO98HmMqB55nfw7KNP6pFj4aYMqFo9SSer0
 KUkLbE+HBNTxJaMM3akzdF/R4xug2gycqt4YMfbNgLhY5n4tijg5LAlQJ1hQx2iTzdF2K//LZ1v
 OpbbKYUjo/mBFmwoqRKlFrYeFMjlT+Sp0TQZIqOBjubXgwwdpftGe/2SxqYjYdzcCyfLmgqM8+C
 2qknvZ3H/jZL7RVzKRUvhAQgrtlKDopCqz4i/ZgmrEKY=
X-Received: by 2002:a05:651c:43c3:10b0:3a9:decc:71d8 with SMTP id
 38308e7fff4ca-3ab292e7330mr15305261fa.20.1792483798450; Tue, 20 Oct 2026
 01:09:58 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261018-tegra-drm-yvu420-v2-0-512889103ab4@gmail.com>
 <HmrilxC8QwiAQGw2IQ1Ztw@nvidia.com>
 <CALHNRZ9pTTLTpsKCi7oETcjpxNbZmQxfnC+pvEx4Wezv1_zchw@mail.gmail.com>
 <YwDFPLEmR6OpEy_iH5qhQg@nvidia.com>
In-Reply-To: <YwDFPLEmR6OpEy_iH5qhQg@nvidia.com>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Tue, 20 Oct 2026 03:09:46 -0500
X-Gm-Features: AclHuK9G5flqUwHbZoc27IHAExPyam9IuxmD1uS85V1i11rVUagnEOUPWT-m7-o
Message-ID: <CALHNRZ_Kiqc0VJN+4gDDM0Z+Ns0VO3jCoLUk1xNn1OGjeS2+LQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] drm/tegra: Support swapping chroma planes
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: linux-tegra@vger.kernel.org, Thierry Reding <thierry.reding@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jonathan Hunter <jonathanh@nvidia.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 20, 2026 at 1:33=E2=80=AFAM Mikko Perttunen <mperttunen@nvidia.=
com> wrote:
>
> On Tuesday, October 20, 2026 2:59=E2=80=AFPM Aaron Kling wrote:
> > On Tue, Oct 20, 2026 at 12:08=E2=80=AFAM Mikko Perttunen <mperttunen@nv=
idia.com> wrote:
> > >
> > > On Monday, October 19, 2026 7:03=E2=80=AFAM Aaron Kling via B4 Relay =
wrote:
> > > > From: Aaron Kling <webgeek1234@gmail.com>
> > > >
> > > > The Tegra display controller supports some yuv types, but not their
> > > > chroma swapped variants. For example, yuv420 is supported but yvu42=
0 is
> > > > not. This can be efficiently worked around by just passing the hard=
ware
> > > > said chroma planes backwards. Add a flag to the plane state struct =
and
> > > > handling to both tegradc and nvdisplay paths.
> > > >
> > > > Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> > > > ---
> > > >  drivers/gpu/drm/tegra/dc.c    |  6 +++++-
> > > >  drivers/gpu/drm/tegra/hub.c   | 14 +++++++++-----
> > > >  drivers/gpu/drm/tegra/plane.c |  5 ++++-
> > > >  drivers/gpu/drm/tegra/plane.h |  3 ++-
> > > >  4 files changed, 20 insertions(+), 8 deletions(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.=
c
> > > > index b0bfa946e6979..39c2e920d76a6 100644
> > > > --- a/drivers/gpu/drm/tegra/dc.c
> > > > +++ b/drivers/gpu/drm/tegra/dc.c
> > > > @@ -740,7 +740,8 @@ static int tegra_plane_atomic_check(struct drm_=
plane *plane,
> > > >
> > > >       err =3D tegra_plane_format(new_plane_state->fb->format->forma=
t,
> > > >                                &plane_state->format,
> > > > -                              &plane_state->swap);
> > > > +                              &plane_state->swap,
> > > > +                              &plane_state->swap_uv);
> > > >       if (err < 0)
> > > >               return err;
> > > >
> > > > @@ -872,6 +873,9 @@ static void tegra_plane_atomic_update(struct dr=
m_plane *plane,
> > > >                       window.stride[i] =3D fb->pitches[i];
> > > >       }
> > > >
> > > > +     if (tegra_plane_state->swap_uv)
> > > > +             swap(window.base[1], window.base[2]);
> > > > +
> > > >       tegra_dc_setup_window(p, &window);
> > > >  }
> > > >
> > > > diff --git a/drivers/gpu/drm/tegra/hub.c b/drivers/gpu/drm/tegra/hu=
b.c
> > > > index 448f49f3a7d7e..6427155ac4fdf 100644
> > > > --- a/drivers/gpu/drm/tegra/hub.c
> > > > +++ b/drivers/gpu/drm/tegra/hub.c
> > > > @@ -440,7 +440,8 @@ static int tegra_shared_plane_atomic_check(stru=
ct drm_plane *plane,
> > > >
> > > >       err =3D tegra_plane_format(new_plane_state->fb->format->forma=
t,
> > > >                                &plane_state->format,
> > > > -                              &plane_state->swap);
> > > > +                              &plane_state->swap,
> > > > +                              &plane_state->swap_uv);
> > > >       if (err < 0)
> > > >               return err;
> > > >
> > > > @@ -664,24 +665,27 @@ static void tegra_shared_plane_atomic_update(=
struct drm_plane *plane,
> > > >       tegra_plane_writel(p, value, DC_WIN_PLANAR_STORAGE);
> > > >
> > > >       if (yuv && planes > 1) {
> > > > -             base =3D tegra_plane_state->iova[1] + fb->offsets[1];
> > > > +             uint8_t u =3D tegra_plane_state->swap_uv ? 2 : 1;
> > > > +             uint8_t v =3D tegra_plane_state->swap_uv ? 1 : 2;
> > > > +
> > > > +             base =3D tegra_plane_state->iova[u] + fb->offsets[u];
> > > >               base |=3D addr_flag;
> > > >
> > > >               tegra_plane_writel(p, upper_32_bits(base), DC_WINBUF_=
START_ADDR_HI_U);
> > > >               tegra_plane_writel(p, lower_32_bits(base), DC_WINBUF_=
START_ADDR_U);
> > > >
> > > >               if (planes > 2) {
> > > > -                     base =3D tegra_plane_state->iova[2] + fb->off=
sets[2];
> > > > +                     base =3D tegra_plane_state->iova[v] + fb->off=
sets[v];
> > > >                       base |=3D addr_flag;
> > > >
> > > >                       tegra_plane_writel(p, upper_32_bits(base), DC=
_WINBUF_START_ADDR_HI_V);
> > > >                       tegra_plane_writel(p, lower_32_bits(base), DC=
_WINBUF_START_ADDR_V);
> > > >               }
> > > >
> > > > -             value =3D PITCH_U(fb->pitches[1]);
> > > > +             value =3D PITCH_U(fb->pitches[u]);
> > > >
> > > >               if (planes > 2)
> > > > -                     value |=3D PITCH_V(fb->pitches[2]);
> > > > +                     value |=3D PITCH_V(fb->pitches[v]);
> > > >
> > > >               tegra_plane_writel(p, value, DC_WIN_PLANAR_STORAGE_UV=
);
> > > >       } else {
> > >
> > > I noticed DC_WIN_PRECOMP_WGRP_PARAMS has a SWAP_UV bit. This is alrea=
dy
> > > defined in dc.h. So we can use that for the hub.c implementation inst=
ead
> > > of manually swapping.
> >
> > Oh. I figured there had to be something like that in one of the
> > generations, but my grep-fu failed me. Even more embarrassing that I
> > ended up using the exact same name. I will update and verify this and
> > send a new revision.
> >
> > > Otherwise everything looks good to me. We could also enable the swap_=
uv
> > > logic for other UV formats.
> >
> > Eh, other than asking for the entire patch to be rewritten over the
> > last two revisions, it looks good. :P And alright, I'll plumb yvu422
> > and yvu444 in the new revision as well. However, I don't have test
> > cases for those.
>
> These are minor revisions, pretty much cosmetic! :)
>
> If you have access to the libdrm modetest command, you can use it to
> test -- e.g.
>
> sudo modetest -M tegra -s 78:1920x1080 \
>       -P 44@43:896x504+40+288@YU12 \
>       -P 48@43:896x504+984+288@YV12
>
> (the ID numbers may differ) to set up a 1920x1080 mode with two overlay
> planes one with each plane ordering.

I'm still mostly focused on android. If there's something where I'm
concerned there's a difference between android and a Linux rootfs or
such, I'll test against a simple cli rootfs. But I don't have a full
graphical Linux setup for testing. At one point I did try to compile
modetest for aosp, but I don't think I made it work.

Aaron

> BTW, I believe the hardware swap bit also supports packed and semiplanar
> formats -- you can add those too if you'd like or leave them out and we
> can add them later if needed.
>
> Mikko
>
> >
> > Aaron
> >
> > > Cheers
> > > Mikko
> > >
> > > > diff --git a/drivers/gpu/drm/tegra/plane.c b/drivers/gpu/drm/tegra/=
plane.c
> > > > index 2148b0c59815c..757bc552809fe 100644
> > > > --- a/drivers/gpu/drm/tegra/plane.c
> > > > +++ b/drivers/gpu/drm/tegra/plane.c
> > > > @@ -59,6 +59,7 @@ tegra_plane_atomic_duplicate_state(struct drm_pla=
ne *plane)
> > > >       copy->tiling =3D state->tiling;
> > > >       copy->format =3D state->format;
> > > >       copy->swap =3D state->swap;
> > > > +     copy->swap_uv =3D state->swap_uv;
> > > >       copy->reflect_x =3D state->reflect_x;
> > > >       copy->reflect_y =3D state->reflect_y;
> > > >       copy->opaque =3D state->opaque;
> > > > @@ -319,11 +320,13 @@ int tegra_plane_state_add(struct tegra_plane =
*plane,
> > > >       return 0;
> > > >  }
> > > >
> > > > -int tegra_plane_format(u32 fourcc, u32 *format, u32 *swap)
> > > > +int tegra_plane_format(u32 fourcc, u32 *format, u32 *swap, bool *s=
wap_uv)
> > > >  {
> > > >       /* assume no swapping of fetched data */
> > > >       if (swap)
> > > >               *swap =3D BYTE_SWAP_NOSWAP;
> > > > +     if (swap_uv)
> > > > +             *swap_uv =3D false;
> > > >
> > > >       switch (fourcc) {
> > > >       case DRM_FORMAT_ARGB4444:
> > > > diff --git a/drivers/gpu/drm/tegra/plane.h b/drivers/gpu/drm/tegra/=
plane.h
> > > > index e33a581e6490e..dba5f1b254e98 100644
> > > > --- a/drivers/gpu/drm/tegra/plane.h
> > > > +++ b/drivers/gpu/drm/tegra/plane.h
> > > > @@ -49,6 +49,7 @@ struct tegra_plane_state {
> > > >       struct tegra_bo_tiling tiling;
> > > >       u32 format;
> > > >       u32 swap;
> > > > +     bool swap_uv;
> > > >
> > > >       bool reflect_x;
> > > >       bool reflect_y;
> > > > @@ -88,7 +89,7 @@ void tegra_plane_cleanup_fb(struct drm_plane *pla=
ne,
> > > >  int tegra_plane_state_add(struct tegra_plane *plane,
> > > >                         struct drm_plane_state *state);
> > > >
> > > > -int tegra_plane_format(u32 fourcc, u32 *format, u32 *swap);
> > > > +int tegra_plane_format(u32 fourcc, u32 *format, u32 *swap, bool *s=
wap_uv);
> > > >  bool tegra_plane_format_is_indexed(unsigned int format);
> > > >  bool tegra_plane_format_is_yuv(unsigned int format, unsigned int *=
planes, unsigned int *bpc);
> > > >  int tegra_plane_setup_legacy_state(struct tegra_plane *tegra,
> > > >
> > > > --
> > > > 2.54.0
> > > >
> > > >
> > > >
> > >
> > >
> > >
> > >
>
>
>
>
