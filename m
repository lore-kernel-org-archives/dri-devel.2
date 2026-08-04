Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15E5CC5518F
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 17:58:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A74789FA5;
	Tue,  4 Aug 2026 17:58:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QGRnKGsZ";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DDDC89FA5
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 17:58:50 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-49545ba3d4eso403875e9.3
 for <dri-devel@lists.freedesktop.org>; Tue, 04 Aug 2026 10:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785866328; x=1786471128; darn=lists.freedesktop.org;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8FfIalmLeScOxNe/jU0URjsOVpQ536KPeXddNb2Qzuk=;
 b=QGRnKGsZNoQd/QvE9S10L/l97KGyNLUKrsLNEcwii4ebDkbYAp0qWUybbQczITIfav
 VwGK90DyBTozVqiY5PxFSQR1rfC2TwtRGsTw1F7GPUqC+cqm4LsAiRgyUNaJUgbA3AFZ
 gYZKwz6vhZuL9sjSE+Iy2FHC7QEYhavNxfsiRi5QXx//dVEn8vAh2lHL3iimNO2xxNrT
 ws8Jil3Lwpk9AAsBchdW54VxmpqGiT3n9QIXQULzFsY/bQas1M/kuH1/Yq2Vg3/cJSgV
 Oc3k4XTCHVOKVZQyyVf7f68Hgr+KLFGdHSLkn2Nmba3p9CAvHnr3XZkTqzXGk65stXba
 51Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785866328; x=1786471128;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8FfIalmLeScOxNe/jU0URjsOVpQ536KPeXddNb2Qzuk=;
 b=po8sCjhMxHhQzaOSUsSRpXvpk1/c8hfKyqLHQxLrP3WW/q2SSpbME6BeULX/q3SgL2
 jbAcLzLFBjCVVcIydRjyAYcpxFEFHUuSlv8yyvzrApCyYC0Sk8pgbOxqJAz+bZiBmzQv
 FA1yR24XBCfAR4YFdkn+gTem4v/mJ4t7yUHcb3tLq53f7JtqyGdLcIn13AzKdw+GWrq6
 xiUbKF2VoawAcGTPbg2hw4eNKty0ZsDNHh1f8/1L8GvhPIe2NjSSUud48oB1yoIXQzWL
 0dQa9eLKJHfviZBULCiUrJ6MWyQ9BCshDLFHQgYkKUW2JGdNI2d1kCy3Ckb8VX/1pPuD
 kE7A==
X-Forwarded-Encrypted: i=1;
 AHgh+RqqDwD4jMjmERhjFGPwJ8ATgivRn4djZPIzkGOqA0p8Shxpu8ObcAqAniPjmTWCBqIo4thvc3eaeuo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwGANyNBjdQy6CIE9igQ7/jnssdaUmIKXg8GT9+/TAvivzbuy/g
 rUmJJsON0aP9izmciodcK0TXKXUiY0ntm0SiZXxSvL+wpYqu5Fu7EYDL
X-Gm-Gg: AR+sD13LOkZ2//uFB+zAtPNPIEpT6scHA0OZdOExZZdkW1tO2n70jz+NrEa1amSKHcV
 Y1wPqjkTxwZHXXKFNID7TDRW6kPMcLnbH+LYfLd1ExZQLSljB3bOh157ayigH+QHUzorHFznV7w
 kQgOKAFD5fBoTZUlUhZ1LRugIttohmd7imhkeKKljjcIS3oWVN+Qm9+oPuUYzQoJZn3UkcjR67M
 u0nqeSRZ5sqOBBQX+OprqrRZB9eGyIJ2yrWObH8TiqYhdia9Hzof3i2betZ60kYSt6INQiQY/00
 Wequ02vqyoqHMwCOemJt7OwvMUoVves80wlNWYJD/4TEg14b/ZdJnPncyeycmg6D0IczLDHRFdA
 EAwQRzZgsLQfpY1U4mk4Yi0af/EMFl15Mp2PCkcq/BwLVgrQv+Ay+FttrJt0HMp6gTWY7XxDe7T
 63hCXSv4WfhtqeEIoY/2otrU0znG30sQzNoIzW1dHAIROYvPEbvqHYW/cR4ysb1QsJc11j/x+Kw
 gfiaejA92KcSJE2gXtsq2ujaJB+SumWSrBuKOAsrNaDOAucmJ/7Ki8PA5CGXt6q5w/c2s/w34ps
 pWFV9L+IhRSllfufh7wgDweEHmbQXXuR/29ocZxI/qbJHq9SJ/Pw/+Qz1Lu0X//jyJdG7+hctyA
 sFB3D1n5lY5Sv+O/oO8t69EFvaCoFql05PguIQQbcIPTdBZzIgpOeWJ/Ya/bXx+Fu01HC7RqTEU
 IOESTwe0xGmxYX+Q==
X-Received: by 2002:a05:600c:8b51:b0:495:6b55:f938 with SMTP id
 5b1f17b1804b1-4994e7ba99emr39395e9.10.1785866328394; 
 Tue, 04 Aug 2026 10:58:48 -0700 (PDT)
Received: from jernej-laptop.localnet (APN-122-102-118-gprs.simobil.net.
 [46.122.102.118]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4994dfe8973sm19187475e9.7.2026.08.04.10.58.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2026 10:58:47 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: wens@kernel.org
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, samuel@sholland.org, 
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/13] drm/sun4i: Align VI buffer addresses for subsampled
 formats
Date: Tue, 04 Aug 2026 19:58:45 +0200
Message-ID: <58Gvon3UR1Sy7a6nLT6bDw@gmail.com>
In-Reply-To: <CAGb2v67mTzB+R7XDasSNhpmdzu5ikdoO0QwiHR432pdt_v7A_Q@mail.gmail.com>
References: <cover.1785772659.git.jernej.skrabec@gmail.com>
 <ugAWjG4QTtSgFVIbk0BoGg@gmail.com>
 <CAGb2v67mTzB+R7XDasSNhpmdzu5ikdoO0QwiHR432pdt_v7A_Q@mail.gmail.com>
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

Dne torek, 4. avgust 2026 ob 19:04:10 Srednjeevropski poletni =C4=8Das je C=
hen-Yu Tsai napisal(a):
> On Wed, Aug 5, 2026 at 12:25=E2=80=AFAM Jernej =C5=A0krabec <jernej.skrab=
ec@gmail.com> wrote:
> >
> > Dne torek, 4. avgust 2026 ob 13:14:38 Srednjeevropski poletni =C4=8Das =
je Chen-Yu Tsai napisal(a):
> > > On Tue, Aug 4, 2026 at 1:25=E2=80=AFAM Chen-Yu Tsai <wens@kernel.org>=
 wrote:
> > > >
> > > > On Tue, Aug 4, 2026 at 12:11=E2=80=AFAM Jernej Skrabec <jernej.skra=
bec@gmail.com> wrote:
> > > > >
> > > > > This is a partial revert of commit 79ac1c945ab8 ("drm/sun4i: laye=
rs:
> > > > > Use drm_fb_dma_get_gem_addr() to get display memory").
> > > > >
> > > > > Chroma must start at the beginning of a subsampling block, for ex=
ample
> > > > > chroma start address for NV12 must be aligned to 2 pixels.
> > > > > drm_fb_dma_get_gem_addr() offsets luma by the exact source coordi=
nates
> > > > > and chroma by the coordinates divided by the subsampling factor, =
so for
> > > > > odd offsets both planes no longer describe the same pixel, which =
the
> > > > > Display Engine scaler can't handle.
> > > > >
> > > > > Align source coordinates down for all planes instead. Remaining s=
hift
> > > > > of one pixel is already compensated with scaler phase shift in
> > > > > sun8i_vi_layer_update_coord().
> > > >
> > > > Well I think this applies to the format in general, and probably sh=
ould
> > > > be fixed in drm_fb_dma_get_gem_addr() instead?
> > > >
> > > > > Fixes: 79ac1c945ab8 ("drm/sun4i: layers: Use drm_fb_dma_get_gem_a=
ddr() to get display memory")
> > > > > Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> > > > > ---
> > > > >  drivers/gpu/drm/sun4i/sun8i_vi_layer.c | 20 ++++++++++++++++++--
> > > > >  1 file changed, 18 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c b/drivers/gpu=
/drm/sun4i/sun8i_vi_layer.c
> > > > > index 09f668c8af24..ad036cb9d88e 100644
> > > > > --- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
> > > > > +++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
> > > > > @@ -197,15 +197,31 @@ static void sun8i_vi_layer_update_buffer(st=
ruct sun8i_layer *layer,
> > > > >         struct drm_plane_state *state =3D plane->state;
> > > > >         struct drm_framebuffer *fb =3D state->fb;
> > > > >         const struct drm_format_info *format =3D fb->format;
> > > > > +       struct drm_gem_dma_object *gem;
> > > > > +       u32 dx, dy, src_x, src_y;
> > > > >         dma_addr_t dma_addr;
> > > > >         u32 ch_base;
> > > > >         int i;
> > > > >
> > > > >         ch_base =3D sun8i_channel_base(layer);
> > > > >
> > > > > +       /* Adjust x and y to be divisible by subsampling factor */
> > > > > +       src_x =3D (state->src.x1 >> 16) & ~(format->hsub - 1);
> > > > > +       src_y =3D (state->src.y1 >> 16) & ~(format->vsub - 1);
> > > >
> > > > AFAICT the only difference compared to drm_fb_dma_get_gem_addr()
> > > > is the masking here, i.e. round_down().
> > > >
> > > > > +
> > > > >         for (i =3D 0; i < format->num_planes; i++) {
> > > > > -               /* Get the start of the displayed memory */
> > > > > -               dma_addr =3D drm_fb_dma_get_gem_addr(fb, state, i=
);
> > > > > +               gem =3D drm_fb_dma_get_gem_obj(fb, i);
> > > > > +               dma_addr =3D gem->dma_addr + fb->offsets[i];
> > > > > +
> > > > > +               dx =3D src_x;
> > > > > +               dy =3D src_y;
> > > > > +               if (i > 0) {
> > > > > +                       dx /=3D format->hsub;
> > > > > +                       dy /=3D format->vsub;
> > > > > +               }
> > > > > +
> > > > > +               dma_addr +=3D dx * format->cpp[i];
> > > > > +               dma_addr +=3D dy * fb->pitches[i];
> > > >
> > > >
> > > > Where as the helper has (or used to have before the blocksize stuff=
):
> > > >
> > > >     paddr +=3D (format->cpp[plane] * (state->src_x >> 16)) / fb->fo=
rmat->hsub;
> > > >     paddr +=3D (fb->pitches[plane] * (state->src_y >> 16)) / fb->fo=
rmat->vsub;
> > > >
> > > > Am I missing something?
> > >
> > > After some headbanging on my end I see that the offset for the Y plane
> > > needs to be rounded down.
> > >
> > > But instead of reverting the whole thing and open-coding the helper
> > > again, could you adjust the address returned by the helper for odd
> > > offsets?
> >
> > Yes, that's also an option. I'll do it in v2.
> >
> > >
> > > And just a heads up, this also needs a clipped version of
> > > drm_fb_dma_get_gem_addr() as sun8i_ui_layer_update_coord() uses the
> > > clipped dimensions. I am currently working on this part.
> >
> > Can you explain a bit more? I don't see why it needs any adjustement.
>=20
> My understanding is that drm_atomic_helper_check_plane_state() calculates
> the "clipped" rectangles for the plane using values from userspace in
> state->src_[xywh] and state->crtc_[xywh] and puts them in state->src
> and state->dst, respectively. If the overlay is moved partially outside
> the screen, the overlay is "clipped".
>=20
>=20
> Say we have a screen of 1920x1080, with an overlay buffer that is 1280x72=
0.
> Say state->src_x and state->src_y are (-50, 0), given by userspace.
> drm_atomic_helper_check_plane_state() will calculate the clipped & scaled
> rectangles and put them in state->src. This latter rectangle is what is
> used sun8i_ui_layer_update_coord().
>=20
> So we would have:
>=20
>     (src_x, src_y) =3D (-50, 0), (src_w, src_h) =3D (1280, 720)
>=20
> The clipped numbers are
>=20
>     (src.x1, src.y1) =3D (0, 0), (src.x2, src.y2) =3D (1230, 720)
>=20
> src, not src_[xywh], is what sun8i layers uses to program the coordinates,
> and prior to the drm_fb_dma_get_gem_addr() conversion, also to calculate
> the buffer start address. drm_fb_dma_get_gem_addr() however uses src_[xy]
> to calculate the address.
>=20
>=20
> Essentially, when overlaying a clipped plane, the start address needs to
> be adjusted if the source (top left) offset is outside the screen.
> clipping =3D=3D automatic cropping to fit the screen.
>=20
> I don't know if userspace applications routinely do this, but I think this
> needs to be restored to the prior behavior.

Uh, it would be nice if this is fixed. But I think it's not too common
for app to use negative coordinates.

Best regards,
Jernej


