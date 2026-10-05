Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35C01CA5FF0
	for <dri-devel@archiver.kernel.org>; Mon,  5 Oct 2026 23:07:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54FCE10E0D3;
	Mon,  5 Oct 2026 23:07:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cZ8ohao8";
	dkim-atps=neutral
Received: from mail-ej2-f43.google.com (mail-ej2-f43.google.com
 [74.125.228.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 432D010E0D3
 for <dri-devel@lists.freedesktop.org>; Mon,  5 Oct 2026 23:07:11 +0000 (UTC)
Received: by mail-ej2-f43.google.com with SMTP id
 a640c23a62f3a-c2e201b7189so404052566b.0
 for <dri-devel@lists.freedesktop.org>; Mon, 05 Oct 2026 16:07:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791241629; cv=none;
 d=google.com; s=arc-20260327;
 b=TOILcvcux5UFY0uIOIIq9lpJ/iqUJP1IAA/BGBnEjsggtUu0dOdU8RCdyi3gOOuaBd
 JQwQSUBschJJMmEjXbhNLsAmOUZXvCKsE2w1ewouKZVeLE7ULlMbzAjU5Y81lRHACwN7
 3XLQU4Vvvp3DSh11qpMs9D5k/W1XMsUMZn8o+2mKqxPg77Gz3AjLE+1SO8N11crgGt9F
 JOruecOAnZYt1OY/ftAUc7i6eIR7SXyJgww9YXzSZRfoIoBcW5EPOiB35iutaQSlrpgD
 EStXnmgfjM6LuykijoGH7pIJq4FX8ImrzDRwCbYoCvml7W9N4/XWaZXAvxLtPxwiYkVR
 0lZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=7dSbFS/TGF43PAwCaCvB6hy4TbFPB/RLZ+NR8ckgjfI=;
 fh=E8CjV4kl4duGCsZ85GuiMaKPy9L32AJsy2+xof3xeJE=;
 b=E/o+IxS6YGPAXwCf1VTjMh6qvqptd3icQ39ss41VmEGdaTNBSiCVRMT5zJW45cX5kL
 uKkOjhnPV5siVTgBVCaG6BAnQR2yeGxJlH9ThLvFBrK8G/gE7d8svyK3jvTNs404Flia
 LlHD2Z6DltZQszZe/kGBTuaHT1ev75xUfyXx9l1vgKf9aYwKnpKeHRz9lhihpNjS2npf
 nf7oSepKTzwhiKPCWtZpHh4Z4EHXXe8KCw8fGt2dvetH4ArdTgv5SeB9AzA5voa0qbaf
 qM6ICXiDp/7MPoONsgEaBLBIu8eNpuhRZxLuM5NIRlX9qXNwr/b4p+HXU5M1o8mQLHVJ
 D+gg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791241629; x=1791846429; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=7dSbFS/TGF43PAwCaCvB6hy4TbFPB/RLZ+NR8ckgjfI=;
 b=cZ8ohao8E3Vy+X/PCY/MJwD4TKtPCReLagShLPOzwW4u1hxRKiKV63r/wYPeWw4Pco
 BbzzU2yi1YRUO5R2mSJY68/iL3A9kfSfwGSQfnuo2oTGhreiKufmoPLo6it13+UfVkiG
 7rVKkA4BmnUFEYNuBG5P3DuHja1GIv/0xBxSd9zv10KxJqqEFicDX9XaaEgdBZyq25Gk
 r5qqd2kjHvN76jGm9f2jClb2Vmtn7IDtl0L5yiIADsVKQsTlRFPIpbjlBpwEuc9AELTB
 oTtPf4g+5EmhrrtqU1YYuV3gN8OpXD7EpXj5Y0FoSNL/L1ZyZDsxsWYpPz86X6DHqRrN
 T3TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791241629; x=1791846429;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=7dSbFS/TGF43PAwCaCvB6hy4TbFPB/RLZ+NR8ckgjfI=;
 b=zAD0m/XImbLSRR/B3V9Zv7ztSWXlH79YYvcxNP+wq9puyl4Ks/zmhm8CxYMOg6yOB/
 +W7R0SOBZ7CY5UdZ8JCEuK7MLdfGi/oVXABCK+Df3Cs8tQwSU6RA0KDLbGddQbGUnTMb
 FOFLemE/c4jgopHBrHqPCydEagNHuBzQdH1CjmdZfbvyU3polFXhRny6jjCjXfEDYNEK
 93L2yYGFy/cWMU8hsl28SujlE8882O1smwlhepIiWasedHipJzswljwF2EbUPSl0W0zu
 ltYdKOleIQ1FsL7PU6oItsVgyA6yKAX44DNsrsXdevOINNlC+Kw0Y8sMNDDz3XDXn37u
 QdKA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzK7DarNh4rMFBZnxWYHsD9+wxNm46pXABluvia5ZJBCKl/HnTemYgZyK2uzxIuZiKms0TmN4eQlNw=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lthLsVHbaT8wGQqxJ6MHHJ0ZGY9U1qReVYeC4bZTVHXmGjL8O5
 zuW4HC4eXHi2z5qpEDalFc6F66qsVp4YHAaqhbSjiRU5qTA76bCVgrK+hFNiO7iZKnHowX9s2lb
 kVo5ibv5NBc7q/39nbTABRCTp6Gl67Fs=
X-Gm-Gg: AYBFou0FuWm2OUakI07fQzixFzuVxuk6T7p7CUM5Ump5NjCsAq0TrdWhoXQiKG77qqU
 W+zfVV22fedd21p/is3i90buNWbya4Td/mTTw6OvF2e63Lo2yfHIPS24SbJjzLeOBaGXpOrGie5
 65Uqz8pP2sAqbftcZlH3pf2ZdrggyISd1RMCUmSLBWQfMybmZKuNj0bGJM0vHoCJ7ohxO/1J7Fz
 FFGO6jLUkB0MZvLusX9IOYT91OytyaV6PTX6H+GPBQBBSGpSUgkwXTeStLATk4/+wVbhqVgOhgd
 LPkSmBIF0IfdhNqrTgPJQ/Vj6tczqCROxSmsExMnZCPJHx2ibv4IXBQuwkW/N+ba+38c1W/S5Sm
 OLI2elFrjsUhtx7h/iMVnMy+hipZZtCvOR4F8JAskg/c=
X-Received: by 2002:a17:907:802:b0:c2d:be57:f73a with SMTP id
 a640c23a62f3a-c2e4ad7e0e1mr1068062366b.13.1791241629344; Mon, 05 Oct 2026
 16:07:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260803135249.2898083-1-wenst@chromium.org>
 <CAGXv+5FS7gLB7-koaPKMqjtMPjOSWguW9NN_tS+8Wi2GTSHYEQ@mail.gmail.com>
In-Reply-To: <CAGXv+5FS7gLB7-koaPKMqjtMPjOSWguW9NN_tS+8Wi2GTSHYEQ@mail.gmail.com>
From: Inki Dae <daeinki@gmail.com>
Date: Tue, 6 Oct 2026 08:06:55 +0900
X-Gm-Features: AclHuK9msja3MH0F18fBLGWHxc5kpDFb8e1MDet0gFDCWL0lgXWfIWlykZBonGE
Message-ID: <CAAQKjZMqj9bD98f6wqYw0iX1-dn-Nrfb_L5TRSX24q170CHnBA@mail.gmail.com>
Subject: Re: [PATCH] drm/exynos: Set supported modifiers during plane init
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Seung-Woo Kim <sw0312.kim@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 DRI mailing list <dri-devel@lists.freedesktop.org>,
 linux-samsung-soc@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: multipart/alternative; boundary="000000000000062893065d1ff178"
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

--000000000000062893065d1ff178
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Sorry for late. I missed this patch.

I will take a look soon.

Thanks,
Inki Dae

2026=EB=85=84 10=EC=9B=94 5=EC=9D=BC (=EC=9B=94) =EC=98=A4=EC=A0=84 1:18, C=
hen-Yu Tsai <wenst@chromium.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:

> Hi,
>
> On Mon, Aug 3, 2026 at 3:52=E2=80=AFPM Chen-Yu Tsai <wenst@chromium.org> =
wrote:
> >
> > The exynos driver currently checks the modifier in a helper called by
> > the plane atomic check helper callback. This check only concerns whethe=
r
> > the selected plane supports the tiled format or not. This is tied to
> > the plane's hardware capability.
> >
> > Turns out the tiled support was added around the same time modifiers
> > were being plumbed through DRM planes. The latter provided a way to
> > describe per-plane modifier support.
> >
> > Add a field to the hardware plane capability struct to allow adding
> > an optional list of supported modifiers. This is passed to
> > drm_universal_plane_init(). This also allows the core to generate
> > and pass to userspace a list of supported modifiers for each plane.
> >
> > EXYNOS_DRM_PLANE_CAP_TILE and the existing helper are removed, as the
> > check is now down by the DRM atomic check.
> >
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
>
> Any chance someone could take a look at this? This drops some redundant
> code.
>
> > ---
> >  drivers/gpu/drm/exynos/exynos_drm_drv.h   |  2 +-
> >  drivers/gpu/drm/exynos/exynos_drm_plane.c | 30 +----------------------
> >  drivers/gpu/drm/exynos/exynos_mixer.c     |  8 +++++-
> >  3 files changed, 9 insertions(+), 31 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/exynos/exynos_drm_drv.h
> b/drivers/gpu/drm/exynos/exynos_drm_drv.h
> > index b126cd129944..ab0edb826261 100644
> > --- a/drivers/gpu/drm/exynos/exynos_drm_drv.h
> > +++ b/drivers/gpu/drm/exynos/exynos_drm_drv.h
> > @@ -92,7 +92,6 @@ struct exynos_drm_plane {
> >  #define EXYNOS_DRM_PLANE_CAP_DOUBLE    (1 << 0)
> >  #define EXYNOS_DRM_PLANE_CAP_SCALE     (1 << 1)
> >  #define EXYNOS_DRM_PLANE_CAP_ZPOS      (1 << 2)
> > -#define EXYNOS_DRM_PLANE_CAP_TILE      (1 << 3)
> >  #define EXYNOS_DRM_PLANE_CAP_PIX_BLEND (1 << 4)
> >  #define EXYNOS_DRM_PLANE_CAP_WIN_BLEND (1 << 5)
> >
> > @@ -112,6 +111,7 @@ struct exynos_drm_plane_config {
> >         const uint32_t *pixel_formats;
> >         unsigned int num_pixel_formats;
> >         unsigned int capabilities;
> > +       const uint64_t *modifiers;
> >  };
> >
> >  /*
> > diff --git a/drivers/gpu/drm/exynos/exynos_drm_plane.c
> b/drivers/gpu/drm/exynos/exynos_drm_plane.c
> > index 5c04ef87e400..31f5f0941154 100644
> > --- a/drivers/gpu/drm/exynos/exynos_drm_plane.c
> > +++ b/drivers/gpu/drm/exynos/exynos_drm_plane.c
> > @@ -174,30 +174,6 @@ static struct drm_plane_funcs exynos_plane_funcs =
=3D {
> >         .atomic_destroy_state =3D exynos_drm_plane_destroy_state,
> >  };
> >
> > -static int
> > -exynos_drm_plane_check_format(const struct exynos_drm_plane_config
> *config,
> > -                             struct exynos_drm_plane_state *state)
> > -{
> > -       struct drm_framebuffer *fb =3D state->base.fb;
> > -       struct drm_device *dev =3D fb->dev;
> > -
> > -       switch (fb->modifier) {
> > -       case DRM_FORMAT_MOD_SAMSUNG_64_32_TILE:
> > -               if (!(config->capabilities & EXYNOS_DRM_PLANE_CAP_TILE)=
)
> > -                       return -ENOTSUPP;
> > -               break;
> > -
> > -       case DRM_FORMAT_MOD_LINEAR:
> > -               break;
> > -
> > -       default:
> > -               DRM_DEV_ERROR(dev->dev, "unsupported pixel format
> modifier");
> > -               return -ENOTSUPP;
> > -       }
> > -
> > -       return 0;
> > -}
> > -
> >  static int
> >  exynos_drm_plane_check_size(const struct exynos_drm_plane_config
> *config,
> >                             struct exynos_drm_plane_state *state)
> > @@ -245,10 +221,6 @@ static int exynos_plane_atomic_check(struct
> drm_plane *plane,
> >         /* translate state into exynos_state */
> >         exynos_plane_mode_set(exynos_state);
> >
> > -       ret =3D exynos_drm_plane_check_format(exynos_plane->config,
> exynos_state);
> > -       if (ret)
> > -               return ret;
> > -
> >         ret =3D exynos_drm_plane_check_size(exynos_plane->config,
> exynos_state);
> >         return ret;
> >  }
> > @@ -312,7 +284,7 @@ int exynos_plane_init(struct drm_device *dev,
> >                                        &exynos_plane_funcs,
> >                                        config->pixel_formats,
> >                                        config->num_pixel_formats,
> > -                                      NULL, config->type, NULL);
> > +                                      config->modifiers, config->type,
> NULL);
> >         if (err) {
> >                 DRM_DEV_ERROR(dev->dev, "failed to initialize plane\n")=
;
> >                 return err;
> > diff --git a/drivers/gpu/drm/exynos/exynos_mixer.c
> b/drivers/gpu/drm/exynos/exynos_mixer.c
> > index 69dea5049309..d74e605a452b 100644
> > --- a/drivers/gpu/drm/exynos/exynos_mixer.c
> > +++ b/drivers/gpu/drm/exynos/exynos_mixer.c
> > @@ -93,6 +93,12 @@ static const uint32_t vp_formats[] =3D {
> >         DRM_FORMAT_NV21,
> >  };
> >
> > +static const uint64_t vp_modifiers[] =3D {
> > +       DRM_FORMAT_MOD_LINEAR,
> > +       DRM_FORMAT_MOD_SAMSUNG_64_32_TILE,
> > +       DRM_FORMAT_MOD_INVALID
> > +};
> > +
> >  struct mixer_context {
> >         struct platform_device *pdev;
> >         struct device           *dev;
> > @@ -148,8 +154,8 @@ static const struct exynos_drm_plane_config
> plane_configs[MIXER_WIN_NR] =3D {
> >                 .num_pixel_formats =3D ARRAY_SIZE(vp_formats),
> >                 .capabilities =3D EXYNOS_DRM_PLANE_CAP_SCALE |
> >                                 EXYNOS_DRM_PLANE_CAP_ZPOS |
> > -                               EXYNOS_DRM_PLANE_CAP_TILE |
> >                                 EXYNOS_DRM_PLANE_CAP_WIN_BLEND,
> > +               .modifiers =3D vp_modifiers,
> >         },
> >  };
> >
> > --
> > 2.55.0.571.g244d577d93-goog
> >
>
>

--000000000000062893065d1ff178
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hi,<div dir=3D"auto"><br></div><div dir=3D"auto">Sorry fo=
r late. I missed this patch.</div><div dir=3D"auto"><br></div><div dir=3D"a=
uto">I will take a look soon.</div><div dir=3D"auto"><br></div><div dir=3D"=
auto">Thanks,</div><div dir=3D"auto">Inki Dae</div><br><div class=3D"gmail_=
quote gmail_quote_container" dir=3D"auto"><div dir=3D"ltr" class=3D"gmail_a=
ttr">2026=EB=85=84 10=EC=9B=94 5=EC=9D=BC (=EC=9B=94) =EC=98=A4=EC=A0=84 1:=
18, Chen-Yu Tsai &lt;<a href=3D"mailto:wenst@chromium.org">wenst@chromium.o=
rg</a>&gt;=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">Hi,<br>
<br>
On Mon, Aug 3, 2026 at 3:52=E2=80=AFPM Chen-Yu Tsai &lt;<a href=3D"mailto:w=
enst@chromium.org" target=3D"_blank" rel=3D"noreferrer">wenst@chromium.org<=
/a>&gt; wrote:<br>
&gt;<br>
&gt; The exynos driver currently checks the modifier in a helper called by<=
br>
&gt; the plane atomic check helper callback. This check only concerns wheth=
er<br>
&gt; the selected plane supports the tiled format or not. This is tied to<b=
r>
&gt; the plane&#39;s hardware capability.<br>
&gt;<br>
&gt; Turns out the tiled support was added around the same time modifiers<b=
r>
&gt; were being plumbed through DRM planes. The latter provided a way to<br=
>
&gt; describe per-plane modifier support.<br>
&gt;<br>
&gt; Add a field to the hardware plane capability struct to allow adding<br=
>
&gt; an optional list of supported modifiers. This is passed to<br>
&gt; drm_universal_plane_init(). This also allows the core to generate<br>
&gt; and pass to userspace a list of supported modifiers for each plane.<br=
>
&gt;<br>
&gt; EXYNOS_DRM_PLANE_CAP_TILE and the existing helper are removed, as the<=
br>
&gt; check is now down by the DRM atomic check.<br>
&gt;<br>
&gt; Signed-off-by: Chen-Yu Tsai &lt;<a href=3D"mailto:wenst@chromium.org" =
target=3D"_blank" rel=3D"noreferrer">wenst@chromium.org</a>&gt;<br>
<br>
Any chance someone could take a look at this? This drops some redundant<br>
code.<br>
<br>
&gt; ---<br>
&gt;=C2=A0 drivers/gpu/drm/exynos/exynos_drm_drv.h=C2=A0 =C2=A0|=C2=A0 2 +-=
<br>
&gt;=C2=A0 drivers/gpu/drm/exynos/exynos_drm_plane.c | 30 +----------------=
------<br>
&gt;=C2=A0 drivers/gpu/drm/exynos/exynos_mixer.c=C2=A0 =C2=A0 =C2=A0|=C2=A0=
 8 +++++-<br>
&gt;=C2=A0 3 files changed, 9 insertions(+), 31 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/exynos/exynos_drm_drv.h b/drivers/gpu/drm=
/exynos/exynos_drm_drv.h<br>
&gt; index b126cd129944..ab0edb826261 100644<br>
&gt; --- a/drivers/gpu/drm/exynos/exynos_drm_drv.h<br>
&gt; +++ b/drivers/gpu/drm/exynos/exynos_drm_drv.h<br>
&gt; @@ -92,7 +92,6 @@ struct exynos_drm_plane {<br>
&gt;=C2=A0 #define EXYNOS_DRM_PLANE_CAP_DOUBLE=C2=A0 =C2=A0 (1 &lt;&lt; 0)<=
br>
&gt;=C2=A0 #define EXYNOS_DRM_PLANE_CAP_SCALE=C2=A0 =C2=A0 =C2=A0(1 &lt;&lt=
; 1)<br>
&gt;=C2=A0 #define EXYNOS_DRM_PLANE_CAP_ZPOS=C2=A0 =C2=A0 =C2=A0 (1 &lt;&lt=
; 2)<br>
&gt; -#define EXYNOS_DRM_PLANE_CAP_TILE=C2=A0 =C2=A0 =C2=A0 (1 &lt;&lt; 3)<=
br>
&gt;=C2=A0 #define EXYNOS_DRM_PLANE_CAP_PIX_BLEND (1 &lt;&lt; 4)<br>
&gt;=C2=A0 #define EXYNOS_DRM_PLANE_CAP_WIN_BLEND (1 &lt;&lt; 5)<br>
&gt;<br>
&gt; @@ -112,6 +111,7 @@ struct exynos_drm_plane_config {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const uint32_t *pixel_formats;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int num_pixel_formats;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int capabilities;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0const uint64_t *modifiers;<br>
&gt;=C2=A0 };<br>
&gt;<br>
&gt;=C2=A0 /*<br>
&gt; diff --git a/drivers/gpu/drm/exynos/exynos_drm_plane.c b/drivers/gpu/d=
rm/exynos/exynos_drm_plane.c<br>
&gt; index 5c04ef87e400..31f5f0941154 100644<br>
&gt; --- a/drivers/gpu/drm/exynos/exynos_drm_plane.c<br>
&gt; +++ b/drivers/gpu/drm/exynos/exynos_drm_plane.c<br>
&gt; @@ -174,30 +174,6 @@ static struct drm_plane_funcs exynos_plane_funcs =
=3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.atomic_destroy_state =3D exynos_drm_=
plane_destroy_state,<br>
&gt;=C2=A0 };<br>
&gt;<br>
&gt; -static int<br>
&gt; -exynos_drm_plane_check_format(const struct exynos_drm_plane_config *c=
onfig,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct exynos_drm_plane_state *state)<br=
>
&gt; -{<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0struct drm_framebuffer *fb =3D state-&gt;b=
ase.fb;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0struct drm_device *dev =3D fb-&gt;dev;<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0switch (fb-&gt;modifier) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0case DRM_FORMAT_MOD_SAMSUNG_64_32_TILE:<br=
>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!(config-&=
gt;capabilities &amp; EXYNOS_DRM_PLANE_CAP_TILE))<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0return -ENOTSUPP;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0case DRM_FORMAT_MOD_LINEAR:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0default:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DRM_DEV_ERROR(=
dev-&gt;dev, &quot;unsupported pixel format modifier&quot;);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOTSU=
PP;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; -}<br>
&gt; -<br>
&gt;=C2=A0 static int<br>
&gt;=C2=A0 exynos_drm_plane_check_size(const struct exynos_drm_plane_config=
 *config,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct exynos_drm_plane_state *state)<br>
&gt; @@ -245,10 +221,6 @@ static int exynos_plane_atomic_check(struct drm_p=
lane *plane,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* translate state into exynos_state =
*/<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exynos_plane_mode_set(exynos_state);<=
br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D exynos_drm_plane_check_format(exyn=
os_plane-&gt;config, exynos_state);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br=
>
&gt; -<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D exynos_drm_plane_check_size(e=
xynos_plane-&gt;config, exynos_state);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt;=C2=A0 }<br>
&gt; @@ -312,7 +284,7 @@ int exynos_plane_init(struct drm_device *dev,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;=
exynos_plane_funcs,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 confi=
g-&gt;pixel_formats,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 confi=
g-&gt;num_pixel_formats,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NULL, confi=
g-&gt;type, NULL);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 config-&gt;=
modifiers, config-&gt;type, NULL);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (err) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DRM_DEV_E=
RROR(dev-&gt;dev, &quot;failed to initialize plane\n&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return er=
r;<br>
&gt; diff --git a/drivers/gpu/drm/exynos/exynos_mixer.c b/drivers/gpu/drm/e=
xynos/exynos_mixer.c<br>
&gt; index 69dea5049309..d74e605a452b 100644<br>
&gt; --- a/drivers/gpu/drm/exynos/exynos_mixer.c<br>
&gt; +++ b/drivers/gpu/drm/exynos/exynos_mixer.c<br>
&gt; @@ -93,6 +93,12 @@ static const uint32_t vp_formats[] =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DRM_FORMAT_NV21,<br>
&gt;=C2=A0 };<br>
&gt;<br>
&gt; +static const uint64_t vp_modifiers[] =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0DRM_FORMAT_MOD_LINEAR,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0DRM_FORMAT_MOD_SAMSUNG_64_32_TILE,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0DRM_FORMAT_MOD_INVALID<br>
&gt; +};<br>
&gt; +<br>
&gt;=C2=A0 struct mixer_context {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct platform_device *pdev;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct device=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0*dev;<br>
&gt; @@ -148,8 +154,8 @@ static const struct exynos_drm_plane_config plane_=
configs[MIXER_WIN_NR] =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.num_pixe=
l_formats =3D ARRAY_SIZE(vp_formats),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.capabili=
ties =3D EXYNOS_DRM_PLANE_CAP_SCALE |<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0EXYNOS_DRM_PLANE_CAP_ZPOS |=
<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0EXYNOS_DRM_PLANE_CAP_TILE |<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0EXYNOS_DRM_PLANE_CAP_WIN_BL=
END,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.modifiers =3D=
 vp_modifiers,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0},<br>
&gt;=C2=A0 };<br>
&gt;<br>
&gt; --<br>
&gt; 2.55.0.571.g244d577d93-goog<br>
&gt;<br>
<br>
</blockquote></div></div>

--000000000000062893065d1ff178--
