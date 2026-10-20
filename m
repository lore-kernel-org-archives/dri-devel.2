Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4E7606A322
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 05:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=K3r6I8vf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1901410EB7B;
	Tue, 20 Oct 2026 05:59:23 +0000 (UTC)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com
 [209.85.167.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80F4410E9F4
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 05:59:17 +0000 (UTC)
Received: by mail-lf1-f48.google.com with SMTP id
 2adb3069b0e04-5bcb6faf862so2604922e87.2
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 22:59:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792475955; cv=none;
 d=google.com; s=arc-20260327;
 b=d0NhHfEDu/5L/Mc+EhVy6zS+hKTrP7gUuo4luxBEex3/LCazMo2JK23qj9bNmX/sh/
 ZFQN7xD1Wa5kreHU2V84wHgUZE8Ackh2Q//Lebv2WUwMKiIuDIJafSAr4/nuBZyLaqnQ
 30R7EzQVPsgFCWn+nVRNj2x6YLyQJAGiUCeXIhDtWEXwgkhulmWjJudlUTZFTVC3wOZl
 rZovL6qAlPIxFXDiOda5awVPR517xeiT4MhuwzwKTbKbSx7tQ3HDA3l4nTA/08a/K/yJ
 Nm9Di6+ojjMtwtHJ+ggoPTb8SoaRVQ+nPugL+LtAPkMjLoCuurOzbjv0XQ5gkTN2cQDk
 80Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=aCg8fph/1fJDI6h7fkyNcd2zVqelb2p7EHJpKPHyiUA=;
 fh=vElwR1hR9dGb+znyY3IVfjutZrm9sYjzUrVdXdg2gTk=;
 b=c3DdBc9Fe2RgPgvwXx/t8hKNHm24zOd6bTPOtqsfMyM40exwsoaMLzw0AKTSWRSwOv
 u2a4KYiZHGyzKcgiiNVa90kIFzuzuDwRNsRJHTQJ7Wg/tVMIPSo4QTnTCR4NDHlzOtbf
 Bcd9kxZjtApVCGpz+l7E+Q0geL0v0Y2DQcikunvgiJMXmL8Y8CtGXEaazccgmvBPPHDF
 67qTnv8BVK/LIS2t02S1Ojk5TTULnE+GD8iQv498ZXS5U6vVFECJ0EesM2gS4VLG5wsE
 B1+CTRxIo/DtURZ3q6D2KHZ7UjbGPmV5yol3Oscz1hUvOgMjMhgtSZ+9xB/vowCn4eoj
 1ckg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792475955; x=1793080755; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=aCg8fph/1fJDI6h7fkyNcd2zVqelb2p7EHJpKPHyiUA=;
 b=K3r6I8vfrU49eLROtE7s2eVt5Jcx96xeBrxUpnyhBXfVcMKYplv6IuAl9VgyTTZ8pR
 hAPZ8bSzAF+RiVU3xE9eYLyrLTnttOmRH7Dsw9hCL52v+IcqbMqZL6N5Z40F1rpgRez/
 Ew4gCbyiyG9tGr2nS0NxtF03fyEXeVLRD6U14YSybSBDT9zfgw7odhWO5vd1uqRS3BCB
 gaPYzEN8d3K4JTmSiIv843BfejPPJ2sUMHRq0p0x4RIRHg/iKCKyfnz2g/keWRBop7H+
 /nwNe0reI+pO6v7hmG2PyyHzoOoQ5MJtrOGFgWaJv4PHFJ5yfv16DY8510S9TDLxbhye
 g1OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792475955; x=1793080755;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aCg8fph/1fJDI6h7fkyNcd2zVqelb2p7EHJpKPHyiUA=;
 b=LAxz8u+NF0uu9c24oVkA0KaKWjE233S8BzXY7mZ0E4wU8fXJCPOnJx5AnNvGlbrbWh
 fWofRpxuWvfzQsU8omcS9AynpGb35OUekfxGCBVIRP0vdPhJ6OC6XuTYdmpXhxIsPt7r
 ZWSn/LYx6TumW2yXG8Y57Zt05oONo79QKTYmfbZsqM/5ubAewygie1OA0eYr6nOvpxha
 EIGbbrLoWeI6theO19FWfk8Dbgy3/mUL9A8RPIeK24Xfx09+jAe3F9+36UWZvyvBaWGZ
 MjcX2/MWhT051xLGtvEGWFlvHgdOF2YOs1J0ilM2WG31jDtR7a8U/jwIgMlRZO3SUMBL
 8WRQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxariH/a7zBYfjSqGkFkHke0Q8dKre33hkKBL/y54Fuv91ozEL31bPJWayR+4XK7YE2F+IW5H6qXx8=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKNVQtjUx6IMJjNrNR4fkz7EH2kMaPbisgpJavxBUjskQ5z73SU
 067TkifwNpsKYzqLUmB1NiE6H+ECQNpxY0QnBi4pW3bvxjjwdiSAbl5HxrlQRAx6lkPMYcSUWod
 Fw480UUOBE51OlNmSMsMlCTmxw7wgPA4TUf0O
X-Gm-Gg: AYBFou1Dl3lNna50LElglP+KZ2rCiHzJoM/bhzocKHrU57UTI9/7e2l0vhfwBNkEDns
 mu63fdToQkiO7HGZouEcjPI2hajY6msHOXlbZOrFQqL1rQvTfLYp0RlBEkSrg9xn7O+RN0VU3E6
 ITBkYkUnLFP8Cc707yC0qdFSmuDpKMRF4U4regHeRAYCC9vDNRxh+07LDCRuJxx8jzIRQFkVLJL
 7EZ3Tnx66Yef+QDDOBG4KH+DA2EzTFSnLbhPb3S9CPJqCT+mppHaayo1vrKFqJTKZT8sU66dsh7
 +l/qc1wSzh7CEeQNfj8Qc1LuC/ToilAgHPQ8Tq5np1rBEl0ge7LxuNkHQ8xnmvsL+KoYhJg9dvp
 rOAEpFm/sctOoqzV1jI+cEPPPBPYvNb2qYx5px3+hEB4=
X-Received: by 2002:a05:6512:401c:b0:5bc:f6b4:96c1 with SMTP id
 2adb3069b0e04-5be50a09735mr3339214e87.9.1792475954919; Mon, 19 Oct 2026
 22:59:14 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261018-tegra-drm-yvu420-v2-0-512889103ab4@gmail.com>
 <20261018-tegra-drm-yvu420-v2-1-512889103ab4@gmail.com>
 <HmrilxC8QwiAQGw2IQ1Ztw@nvidia.com>
In-Reply-To: <HmrilxC8QwiAQGw2IQ1Ztw@nvidia.com>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Tue, 20 Oct 2026 00:59:03 -0500
X-Gm-Features: AclHuK-m8XMWtAb64cQPzzqZx3KIZG_Ohxl4ldySrzNI4kuCiiZ69ozwRbh1oCQ
Message-ID: <CALHNRZ9pTTLTpsKCi7oETcjpxNbZmQxfnC+pvEx4Wezv1_zchw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] drm/tegra: Support swapping chroma planes
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: Thierry Reding <thierry.reding@kernel.org>,
 David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Jonathan Hunter <jonathanh@nvidia.com>,
 dri-devel@lists.freedesktop.org, 
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Tue, Oct 20, 2026 at 12:08=E2=80=AFAM Mikko Perttunen <mperttunen@nvidia=
.com> wrote:
>
> On Monday, October 19, 2026 7:03=E2=80=AFAM Aaron Kling via B4 Relay wrot=
e:
> > From: Aaron Kling <webgeek1234@gmail.com>
> >
> > The Tegra display controller supports some yuv types, but not their
> > chroma swapped variants. For example, yuv420 is supported but yvu420 is
> > not. This can be efficiently worked around by just passing the hardware
> > said chroma planes backwards. Add a flag to the plane state struct and
> > handling to both tegradc and nvdisplay paths.
> >
> > Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> > ---
> >  drivers/gpu/drm/tegra/dc.c    |  6 +++++-
> >  drivers/gpu/drm/tegra/hub.c   | 14 +++++++++-----
> >  drivers/gpu/drm/tegra/plane.c |  5 ++++-
> >  drivers/gpu/drm/tegra/plane.h |  3 ++-
> >  4 files changed, 20 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
> > index b0bfa946e6979..39c2e920d76a6 100644
> > --- a/drivers/gpu/drm/tegra/dc.c
> > +++ b/drivers/gpu/drm/tegra/dc.c
> > @@ -740,7 +740,8 @@ static int tegra_plane_atomic_check(struct drm_plan=
e *plane,
> >
> >       err =3D tegra_plane_format(new_plane_state->fb->format->format,
> >                                &plane_state->format,
> > -                              &plane_state->swap);
> > +                              &plane_state->swap,
> > +                              &plane_state->swap_uv);
> >       if (err < 0)
> >               return err;
> >
> > @@ -872,6 +873,9 @@ static void tegra_plane_atomic_update(struct drm_pl=
ane *plane,
> >                       window.stride[i] =3D fb->pitches[i];
> >       }
> >
> > +     if (tegra_plane_state->swap_uv)
> > +             swap(window.base[1], window.base[2]);
> > +
> >       tegra_dc_setup_window(p, &window);
> >  }
> >
> > diff --git a/drivers/gpu/drm/tegra/hub.c b/drivers/gpu/drm/tegra/hub.c
> > index 448f49f3a7d7e..6427155ac4fdf 100644
> > --- a/drivers/gpu/drm/tegra/hub.c
> > +++ b/drivers/gpu/drm/tegra/hub.c
> > @@ -440,7 +440,8 @@ static int tegra_shared_plane_atomic_check(struct d=
rm_plane *plane,
> >
> >       err =3D tegra_plane_format(new_plane_state->fb->format->format,
> >                                &plane_state->format,
> > -                              &plane_state->swap);
> > +                              &plane_state->swap,
> > +                              &plane_state->swap_uv);
> >       if (err < 0)
> >               return err;
> >
> > @@ -664,24 +665,27 @@ static void tegra_shared_plane_atomic_update(stru=
ct drm_plane *plane,
> >       tegra_plane_writel(p, value, DC_WIN_PLANAR_STORAGE);
> >
> >       if (yuv && planes > 1) {
> > -             base =3D tegra_plane_state->iova[1] + fb->offsets[1];
> > +             uint8_t u =3D tegra_plane_state->swap_uv ? 2 : 1;
> > +             uint8_t v =3D tegra_plane_state->swap_uv ? 1 : 2;
> > +
> > +             base =3D tegra_plane_state->iova[u] + fb->offsets[u];
> >               base |=3D addr_flag;
> >
> >               tegra_plane_writel(p, upper_32_bits(base), DC_WINBUF_STAR=
T_ADDR_HI_U);
> >               tegra_plane_writel(p, lower_32_bits(base), DC_WINBUF_STAR=
T_ADDR_U);
> >
> >               if (planes > 2) {
> > -                     base =3D tegra_plane_state->iova[2] + fb->offsets=
[2];
> > +                     base =3D tegra_plane_state->iova[v] + fb->offsets=
[v];
> >                       base |=3D addr_flag;
> >
> >                       tegra_plane_writel(p, upper_32_bits(base), DC_WIN=
BUF_START_ADDR_HI_V);
> >                       tegra_plane_writel(p, lower_32_bits(base), DC_WIN=
BUF_START_ADDR_V);
> >               }
> >
> > -             value =3D PITCH_U(fb->pitches[1]);
> > +             value =3D PITCH_U(fb->pitches[u]);
> >
> >               if (planes > 2)
> > -                     value |=3D PITCH_V(fb->pitches[2]);
> > +                     value |=3D PITCH_V(fb->pitches[v]);
> >
> >               tegra_plane_writel(p, value, DC_WIN_PLANAR_STORAGE_UV);
> >       } else {
>
> I noticed DC_WIN_PRECOMP_WGRP_PARAMS has a SWAP_UV bit. This is already
> defined in dc.h. So we can use that for the hub.c implementation instead
> of manually swapping.

Oh. I figured there had to be something like that in one of the
generations, but my grep-fu failed me. Even more embarrassing that I
ended up using the exact same name. I will update and verify this and
send a new revision.

> Otherwise everything looks good to me. We could also enable the swap_uv
> logic for other UV formats.

Eh, other than asking for the entire patch to be rewritten over the
last two revisions, it looks good. :P And alright, I'll plumb yvu422
and yvu444 in the new revision as well. However, I don't have test
cases for those.

Aaron

> Cheers
> Mikko
>
> > diff --git a/drivers/gpu/drm/tegra/plane.c b/drivers/gpu/drm/tegra/plan=
e.c
> > index 2148b0c59815c..757bc552809fe 100644
> > --- a/drivers/gpu/drm/tegra/plane.c
> > +++ b/drivers/gpu/drm/tegra/plane.c
> > @@ -59,6 +59,7 @@ tegra_plane_atomic_duplicate_state(struct drm_plane *=
plane)
> >       copy->tiling =3D state->tiling;
> >       copy->format =3D state->format;
> >       copy->swap =3D state->swap;
> > +     copy->swap_uv =3D state->swap_uv;
> >       copy->reflect_x =3D state->reflect_x;
> >       copy->reflect_y =3D state->reflect_y;
> >       copy->opaque =3D state->opaque;
> > @@ -319,11 +320,13 @@ int tegra_plane_state_add(struct tegra_plane *pla=
ne,
> >       return 0;
> >  }
> >
> > -int tegra_plane_format(u32 fourcc, u32 *format, u32 *swap)
> > +int tegra_plane_format(u32 fourcc, u32 *format, u32 *swap, bool *swap_=
uv)
> >  {
> >       /* assume no swapping of fetched data */
> >       if (swap)
> >               *swap =3D BYTE_SWAP_NOSWAP;
> > +     if (swap_uv)
> > +             *swap_uv =3D false;
> >
> >       switch (fourcc) {
> >       case DRM_FORMAT_ARGB4444:
> > diff --git a/drivers/gpu/drm/tegra/plane.h b/drivers/gpu/drm/tegra/plan=
e.h
> > index e33a581e6490e..dba5f1b254e98 100644
> > --- a/drivers/gpu/drm/tegra/plane.h
> > +++ b/drivers/gpu/drm/tegra/plane.h
> > @@ -49,6 +49,7 @@ struct tegra_plane_state {
> >       struct tegra_bo_tiling tiling;
> >       u32 format;
> >       u32 swap;
> > +     bool swap_uv;
> >
> >       bool reflect_x;
> >       bool reflect_y;
> > @@ -88,7 +89,7 @@ void tegra_plane_cleanup_fb(struct drm_plane *plane,
> >  int tegra_plane_state_add(struct tegra_plane *plane,
> >                         struct drm_plane_state *state);
> >
> > -int tegra_plane_format(u32 fourcc, u32 *format, u32 *swap);
> > +int tegra_plane_format(u32 fourcc, u32 *format, u32 *swap, bool *swap_=
uv);
> >  bool tegra_plane_format_is_indexed(unsigned int format);
> >  bool tegra_plane_format_is_yuv(unsigned int format, unsigned int *plan=
es, unsigned int *bpc);
> >  int tegra_plane_setup_legacy_state(struct tegra_plane *tegra,
> >
> > --
> > 2.54.0
> >
> >
> >
>
>
>
>
