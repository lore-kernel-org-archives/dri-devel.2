Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B332C55184
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 17:04:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95C0A10EB2B;
	Tue,  4 Aug 2026 17:04:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bg7OoWzi";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0B1E10EB2B
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 17:04:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A387560A83
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 17:04:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DB1D1F00ACA
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 17:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785863064;
 bh=Mdy5BwKP2BUlXSPT818fsnoO/+gx2VkeYa1S7BhDg0A=;
 h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc;
 b=bg7OoWziEtDRjqC4NPN8cKVmWJ+CKhiKvG1BGvdcP8l6UqkD9OeZLO5Wey3SL5Hk4
 jz7H4wWr/Pp3bw1Tcexu2Pz4RS4LQwY0H0I4bObe/+iZjVyg7eiADFsDZg62Q5Dsqn
 fqBAOobykxBmMQtpohVjEBoRFR0ZdM0zMByMDjAqEE1pLGJbqDrnxIgET4X+8/neHe
 VAg+2kLTMbXE2WuqcFliF1HZ+35BK5IN+H0AvEDSXY65anSU2FhsmKeUTqOLfSZf3w
 RKPdKKSySk1OpPWPT7f1V3c0SwPypmfVC96Swv0o77F4kicbFogvzM7/BH7MUSXNE8
 dIIqekk+50UQQ==
Received: by mail-lj1-f174.google.com with SMTP id
 38308e7fff4ca-39c8dbf4f38so659271fa.3
 for <dri-devel@lists.freedesktop.org>; Tue, 04 Aug 2026 10:04:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+RoQDYzv9TiMaSmCwZX247oAtusj28MKxyxQmDbpsupnYj5Ir8+ri9bLHIA5LMz5wPczn2xHzM4B+b8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxPylfgsHb2NEYoIzpEsOpYDXYtj7pCu9BCqPL9dQakDEtFnlo4
 jLXvNDSNSGzqq06ODQx9GdE2a5A87+jtGcEfHtJPHGPF5oSZyFN4zmH81IfcTJAJrsFoTyuu2rl
 jTZ/8yQSWIsAOqlEe9Ks/tmJkzwwblbI=
X-Received: by 2002:a05:651c:b21:b0:39e:b257:e878 with SMTP id
 38308e7fff4ca-39fbae384e5mr15601fa.8.1785863062769; Tue, 04 Aug 2026 10:04:22
 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1785772659.git.jernej.skrabec@gmail.com>
 <CAGb2v66E95PwYhdPC4mkX1htF2VXECiGwUHfzLHV2ydOMiwxrg@mail.gmail.com>
 <CAGb2v67ugarRQAB=yDiyGti4E_r=dF0G08-TiGgphQSefHs8zQ@mail.gmail.com>
 <ugAWjG4QTtSgFVIbk0BoGg@gmail.com>
In-Reply-To: <ugAWjG4QTtSgFVIbk0BoGg@gmail.com>
From: Chen-Yu Tsai <wens@kernel.org>
Date: Wed, 5 Aug 2026 01:04:10 +0800
X-Gmail-Original-Message-ID: <CAGb2v67mTzB+R7XDasSNhpmdzu5ikdoO0QwiHR432pdt_v7A_Q@mail.gmail.com>
X-Gm-Features: AUfX_mxqXe7yankErUPBEOhM0CS9DLRlpwPXjUeNfllWGs8vBgMDWFkZlhW-0lE
Message-ID: <CAGb2v67mTzB+R7XDasSNhpmdzu5ikdoO0QwiHR432pdt_v7A_Q@mail.gmail.com>
Subject: Re: [PATCH 13/13] drm/sun4i: Align VI buffer addresses for subsampled
 formats
To: =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, samuel@sholland.org, 
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
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
Reply-To: wens@kernel.org
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Wed, Aug 5, 2026 at 12:25=E2=80=AFAM Jernej =C5=A0krabec <jernej.skrabec=
@gmail.com> wrote:
>
> Dne torek, 4. avgust 2026 ob 13:14:38 Srednjeevropski poletni =C4=8Das je=
 Chen-Yu Tsai napisal(a):
> > On Tue, Aug 4, 2026 at 1:25=E2=80=AFAM Chen-Yu Tsai <wens@kernel.org> w=
rote:
> > >
> > > On Tue, Aug 4, 2026 at 12:11=E2=80=AFAM Jernej Skrabec <jernej.skrabe=
c@gmail.com> wrote:
> > > >
> > > > This is a partial revert of commit 79ac1c945ab8 ("drm/sun4i: layers=
:
> > > > Use drm_fb_dma_get_gem_addr() to get display memory").
> > > >
> > > > Chroma must start at the beginning of a subsampling block, for exam=
ple
> > > > chroma start address for NV12 must be aligned to 2 pixels.
> > > > drm_fb_dma_get_gem_addr() offsets luma by the exact source coordina=
tes
> > > > and chroma by the coordinates divided by the subsampling factor, so=
 for
> > > > odd offsets both planes no longer describe the same pixel, which th=
e
> > > > Display Engine scaler can't handle.
> > > >
> > > > Align source coordinates down for all planes instead. Remaining shi=
ft
> > > > of one pixel is already compensated with scaler phase shift in
> > > > sun8i_vi_layer_update_coord().
> > >
> > > Well I think this applies to the format in general, and probably shou=
ld
> > > be fixed in drm_fb_dma_get_gem_addr() instead?
> > >
> > > > Fixes: 79ac1c945ab8 ("drm/sun4i: layers: Use drm_fb_dma_get_gem_add=
r() to get display memory")
> > > > Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> > > > ---
> > > >  drivers/gpu/drm/sun4i/sun8i_vi_layer.c | 20 ++++++++++++++++++--
> > > >  1 file changed, 18 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c b/drivers/gpu/d=
rm/sun4i/sun8i_vi_layer.c
> > > > index 09f668c8af24..ad036cb9d88e 100644
> > > > --- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
> > > > +++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
> > > > @@ -197,15 +197,31 @@ static void sun8i_vi_layer_update_buffer(stru=
ct sun8i_layer *layer,
> > > >         struct drm_plane_state *state =3D plane->state;
> > > >         struct drm_framebuffer *fb =3D state->fb;
> > > >         const struct drm_format_info *format =3D fb->format;
> > > > +       struct drm_gem_dma_object *gem;
> > > > +       u32 dx, dy, src_x, src_y;
> > > >         dma_addr_t dma_addr;
> > > >         u32 ch_base;
> > > >         int i;
> > > >
> > > >         ch_base =3D sun8i_channel_base(layer);
> > > >
> > > > +       /* Adjust x and y to be divisible by subsampling factor */
> > > > +       src_x =3D (state->src.x1 >> 16) & ~(format->hsub - 1);
> > > > +       src_y =3D (state->src.y1 >> 16) & ~(format->vsub - 1);
> > >
> > > AFAICT the only difference compared to drm_fb_dma_get_gem_addr()
> > > is the masking here, i.e. round_down().
> > >
> > > > +
> > > >         for (i =3D 0; i < format->num_planes; i++) {
> > > > -               /* Get the start of the displayed memory */
> > > > -               dma_addr =3D drm_fb_dma_get_gem_addr(fb, state, i);
> > > > +               gem =3D drm_fb_dma_get_gem_obj(fb, i);
> > > > +               dma_addr =3D gem->dma_addr + fb->offsets[i];
> > > > +
> > > > +               dx =3D src_x;
> > > > +               dy =3D src_y;
> > > > +               if (i > 0) {
> > > > +                       dx /=3D format->hsub;
> > > > +                       dy /=3D format->vsub;
> > > > +               }
> > > > +
> > > > +               dma_addr +=3D dx * format->cpp[i];
> > > > +               dma_addr +=3D dy * fb->pitches[i];
> > >
> > >
> > > Where as the helper has (or used to have before the blocksize stuff):
> > >
> > >     paddr +=3D (format->cpp[plane] * (state->src_x >> 16)) / fb->form=
at->hsub;
> > >     paddr +=3D (fb->pitches[plane] * (state->src_y >> 16)) / fb->form=
at->vsub;
> > >
> > > Am I missing something?
> >
> > After some headbanging on my end I see that the offset for the Y plane
> > needs to be rounded down.
> >
> > But instead of reverting the whole thing and open-coding the helper
> > again, could you adjust the address returned by the helper for odd
> > offsets?
>
> Yes, that's also an option. I'll do it in v2.
>
> >
> > And just a heads up, this also needs a clipped version of
> > drm_fb_dma_get_gem_addr() as sun8i_ui_layer_update_coord() uses the
> > clipped dimensions. I am currently working on this part.
>
> Can you explain a bit more? I don't see why it needs any adjustement.

My understanding is that drm_atomic_helper_check_plane_state() calculates
the "clipped" rectangles for the plane using values from userspace in
state->src_[xywh] and state->crtc_[xywh] and puts them in state->src
and state->dst, respectively. If the overlay is moved partially outside
the screen, the overlay is "clipped".


Say we have a screen of 1920x1080, with an overlay buffer that is 1280x720.
Say state->src_x and state->src_y are (-50, 0), given by userspace.
drm_atomic_helper_check_plane_state() will calculate the clipped & scaled
rectangles and put them in state->src. This latter rectangle is what is
used sun8i_ui_layer_update_coord().

So we would have:

    (src_x, src_y) =3D (-50, 0), (src_w, src_h) =3D (1280, 720)

The clipped numbers are

    (src.x1, src.y1) =3D (0, 0), (src.x2, src.y2) =3D (1230, 720)

src, not src_[xywh], is what sun8i layers uses to program the coordinates,
and prior to the drm_fb_dma_get_gem_addr() conversion, also to calculate
the buffer start address. drm_fb_dma_get_gem_addr() however uses src_[xy]
to calculate the address.


Essentially, when overlaying a clipped plane, the start address needs to
be adjusted if the source (top left) offset is outside the screen.
clipping =3D=3D automatic cropping to fit the screen.

I don't know if userspace applications routinely do this, but I think this
needs to be restored to the prior behavior.


ChenYu
