Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FCB8107760C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 19:28:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B949F10E0C3;
	Wed, 18 Mar 2026 19:28:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FSD5kdG0";
	dkim-atps=neutral
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7990A10E0C3
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 19:28:27 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-439cd6b0aedso120325f8f.1
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 12:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773862106; x=1774466906; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wv6jP1e3M1+PHnQU5Hq+FG1C5SwOP02k/za1P8Uz0WI=;
 b=FSD5kdG0MDTC5DJq3W4DQ0H1ONFZ1qPsycq0EPNQ1B4FSoN6E5X3EI4Xnv6w23VyRi
 xcVFt5zpDedNhS0H0u7m2xJzmikPQAdsPIKRW1F5UeMUJizTEyM05FFRu+2jol4kZhnw
 DaDd7QJJ6omCoZDN7dyk4tQlDeE8uKUQVFBj3lpNx4jqcAT5y8Qnj86rtkpg+NdrkDU7
 hr1jIgnNWiqquewGZuOh22mp4SgFcu4sx8Ei6fX6j2QZ35DTDSkWumECCPhaUCmgy2AF
 VtLZHcEQ+3lbTlna7ZEXdNh8+C/6SYMdBXezi/VkIljFGWWJc60WL9d2/e/JorYAZEbU
 FQqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773862106; x=1774466906;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Wv6jP1e3M1+PHnQU5Hq+FG1C5SwOP02k/za1P8Uz0WI=;
 b=IxuWDsNx7WxB3+1+dP3v2RClJsU7aIdgHC91GoRwMvZ8Ddm74o5P4/F5bt/rMZbQgp
 a9E1gorljToujYtYeU985er3xTwh3mrn3ZO6JQTsUJS4dxNPJO2qqS4J0+iQPaId0pOZ
 Tv8zrkFgri5wU+Q6H3sMumlCdO5pnW/ZeRYSfIiZTc3P40h7D8hDTQ9fDGC05u6N18bP
 hjmJN6s+RltZyU7HinYSKoJobE3yM3qWeO5gFLxF4RqwfmGGXYZE4ydYQHAtUPGxEdL3
 CZvPTFpPTJmqnOxS44pyBgLn9YZy/zbGNSZrW/dB7/hTHFCCElqHU8dGoqOyTZIGLo76
 7CcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9i/szQ+gPxYlbOhQ3QCgV/eEseBvcqgCbwVz3UrjQHShK2rKr6aHbWPQefCGsw8PoSZi6EHB2Fqs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyIJGFjZVp81wzUrSIPxxFC096vNlHzsxIRf/TaIP9iGS4qW1LC
 5imzjEp7n5L0Pqxg5p6lAVF0bb4kaFHAau2zeYMzQqjU3vVJHHa9UQH3
X-Gm-Gg: ATEYQzxjvqJTIxoVGZ4iRYrsan3vL0vj13gWYl++BR8tiBDDymCz+X9fp9BRc5XxX3U
 D1c/agwtbpVIuF3ecytEpmRxNKROnJwEb84NiIy23HOisqxA+fIA5SkVebLVqiB4sV079pjwzJc
 jEVz8+xPEf9yQYzp94EKzNQOoeFE+OTIUe3yhkalmv2uOgDFqmsZVT4tcwaj0Hw2BPBOmIKsvFr
 h9oXQCSwMopUMuxr2Bc3qkB4vqF6FovFFKIPAsW5khKLG51KRR5pOBtho+AK+XurSl4CFaBvAU2
 urM11DoKZsNuyZ/6EvTboReub4ozu3MOxjqSAukTHL6yWcasbPRW9SCeiU2fU1to0ekeKr1HJ3n
 +g/42G0zBE6GospQzqXB5rWyiz1AbP/l7kzRwkGT4fSO23wsHBKVi+IM6TRvaMWttBurgMiLhX1
 MNzfeONSIA+sUc2J3ScbpCHgARLqE2jf9kEy+8vAf0BkDvucZWH1lvXt5/4trtNbBn5XLtpYSHt
 gzf5jfq
X-Received: by 2002:a05:6000:400a:b0:439:bcdb:95a8 with SMTP id
 ffacd0b85a97d-43b52648c7cmr7805238f8f.0.1773862105581; 
 Wed, 18 Mar 2026 12:28:25 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-12-248.dynamic.telemach.net.
 [82.149.12.248]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b51899617sm10663715f8f.31.2026.03.18.12.28.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 12:28:25 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej@kernel.org>,
 Samuel Holland <samuel@sholland.org>, wens@kernel.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 linux-sunxi@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/sun4i: layers: Use drm_fb_dma_get_gem_addr() to get
 display memory
Date: Wed, 18 Mar 2026 20:28:23 +0100
Message-ID: <6247601.lOV4Wx5bFT@jernej-laptop>
In-Reply-To: <CAGb2v67sA48gfecLKiGozULmTo45hXF25n+2+nAHVFY_QEL24w@mail.gmail.com>
References: <20260309165635.1138413-1-wens@kernel.org>
 <CAGb2v67sA48gfecLKiGozULmTo45hXF25n+2+nAHVFY_QEL24w@mail.gmail.com>
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

Dne sreda, 18. marec 2026 ob 10:35:35 Srednjeevropski standardni =C4=8Das j=
e Chen-Yu Tsai napisal(a):
> Hi,
>=20
> On Tue, Mar 10, 2026 at 12:56=E2=80=AFAM Chen-Yu Tsai <wens@kernel.org> w=
rote:
> >
> > Commit 4636ce93d5b2 ("drm/fb-cma-helper: Add drm_fb_cma_get_gem_addr()")
> > adds a new helper, which covers fetching a drm_framebuffer's GEM object
> > and calculating the buffer address for a given plane.
> >
> > This patch uses this helper to replace our own open coded version of the
> > same function.
> >
> > Signed-off-by: Chen-Yu Tsai <wens@kernel.org>
> > ---
> >  drivers/gpu/drm/sun4i/sun8i_ui_layer.c | 16 ++-------------
> >  drivers/gpu/drm/sun4i/sun8i_vi_layer.c | 27 ++------------------------
> >  2 files changed, 4 insertions(+), 39 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c b/drivers/gpu/drm/s=
un4i/sun8i_ui_layer.c
> > index f08f6da55dd0..72c92203ae63 100644
> > --- a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
> > +++ b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
> > @@ -124,25 +124,13 @@ static void sun8i_ui_layer_update_buffer(struct s=
un8i_layer *layer,
> >  {
> >         struct drm_plane_state *state =3D plane->state;
> >         struct drm_framebuffer *fb =3D state->fb;
> > -       struct drm_gem_dma_object *gem;
> >         dma_addr_t dma_addr;
> >         u32 ch_base;
> > -       int bpp;
> >
> >         ch_base =3D sun8i_channel_base(layer);
> >
> > -       /* Get the physical address of the buffer in memory */
> > -       gem =3D drm_fb_dma_get_gem_obj(fb, 0);
> > -
> > -       DRM_DEBUG_DRIVER("Using GEM @ %pad\n", &gem->dma_addr);
> > -
> > -       /* Compute the start of the displayed memory */
> > -       bpp =3D fb->format->cpp[0];
> > -       dma_addr =3D gem->dma_addr + fb->offsets[0];
> > -
> > -       /* Fixup framebuffer address for src coordinates */
> > -       dma_addr +=3D (state->src.x1 >> 16) * bpp;
> > -       dma_addr +=3D (state->src.y1 >> 16) * fb->pitches[0];
> > +       /* Get the start of the displayed memory */
> > +       dma_addr =3D drm_fb_dma_get_gem_addr(fb, state, 0);
>=20
> I just realized while reading more code that there's a subtle difference
> here.
>=20
> The original code used state->src.x1, which is the "clipped" coordinates,
> while drm_fb_dma_get_gem_addr() uses state->src_x, which is the original
> coordinates.
>=20
> Jernej, do you know which one the driver is supposed to use? Or maybe
> it doesn't matter?

I would say that it doesn't matter for point of origin. Original coordinates
use uint32_t values which means origin cannot be out of screen (negative
numbers). What I found interesting is that clipped coordinates are int, e.g.
they can be negative.

Best regards,
Jernej




