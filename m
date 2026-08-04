Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D56FC55184
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 16:25:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 878D610E02D;
	Tue,  4 Aug 2026 16:25:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="n72sCKVx";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8E7A10E02D
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 16:25:10 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4957eefd361so24944695e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 04 Aug 2026 09:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785860709; x=1786465509; darn=lists.freedesktop.org;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9gYefvAyqnzn8QAHjERbxmBW19GFjgq4+owbZqEl8b0=;
 b=n72sCKVxipGOb2vJUUVbepdf5qT/r+H7AzVdkewP0nvmlA0gA6hQ1CsDEoxvrQRKdz
 VuWwx/18wCFywp1mtzjcM2xdJvR2K9LJ5nQ6GlHWtl+JcYdAsw7JutuZocRJwHIRNlTg
 VhT6lPfW8vmZG08wfVg/vR+hZeSlTuqGTBdKZDxu8rnBDw0fPS3XTw7nScKtBcBUEhTP
 mAC3u8UYNm3qCoDMLLCmAhdH3YzppHAvbgLlpmDHcqL5VhM1NNIeM9t117dXc1UPuWzU
 8ecImBAIfNvaeolAtJpf1Aqf8WYKhYrtPBblwGWu6/qPStIHRKUTKy9XYHaT9XtU4TSW
 e7Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785860709; x=1786465509;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9gYefvAyqnzn8QAHjERbxmBW19GFjgq4+owbZqEl8b0=;
 b=gzbL0YLrhoYCfO4qjG1+rkc48s3nMSZLsOw5IsXQd20YAEz7cLSqzq5AU2yrqXWl91
 CQh6eBS0tWl//+rzrFy+rlt33k6MLzb1bV1+Jbl61RkCDYBkcl8590kwjczElZ5DlaAR
 HpQitNj5b7rYlRKvpptxSFyvmTecrpVhpHPpL1VTN3oyAEjdjvuDARpHk707MBkkOuPS
 L3b7DPWfuNFg1uT9nXYFA07Ln4lQEi00ZyLhmCd/49bNqOflvxCVHDwbjwVhfWgfhYxu
 uI4bqApeeRzj43BapCX5lcZI0NujjMywM9GTpwUEZSeV95qxep3RfsjqUN2+4r5oD/OG
 XsQA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpn5UJqvC77DOu7S0k/du08g4f1B2HaLLsTC9unynbZ7B/GPyWIxbiscksET0uwSrp8ajalJkDsTCY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzsHyoiQefEJ/lDIlDwvUtsXm3nKHyeu7Kbpf7gR8HI8hckrYpt
 fOcT5ABIR+ThEF/nbvVyaME629ZPCY393PdoxOdd83o9gp0YWTpKDM4y
X-Gm-Gg: AR+sD13HbSQSAm7JpmwJK2/yirky8EQs11daelhnf5aZXcDo6uTWMQzpmC1Om6BGA/v
 GSoe1pYilMTk24EIdRyEzqeas2LMH9m8TxtaLh87A2WOLJVWva5VGX1zRnyZunKGY7jKm35lV6h
 qq0BFoB+0pMhAMILbHKjPvzYltM7ZGVrQtWPEZWfmqz2K/nZktSlUz/85L+epDbQgj3m7zC2kfC
 bA2nNoKCKyiFSMz8qC0T44PPTA9MrH1n0Bngiz+nDdYDKi/cepFtCV82FYTC9+MLriTaSgFLPRE
 l3IXKo+HtNTK6CSNwQBoUZu2GmTiroSmq9eGWgmF9jqjkT85tR4tlIPIUfw58baUebQBzn4wXoG
 ut5Be5mEtOgp3QbN8RpVUSUO5BhxILHphJoQ6i+kuUvtotPkmM/IvGR4RDTrU2Eh+NWgOFnizXr
 QD2grQDLiDOgTcxqMCq1+dcW0THHOQOw9U2Q5Z59rW2eMnPs4ME3TddLog9Zpdwpov/AVzn0aEg
 KOasV/nMkyxc9XSNLUhsc+MVNpzRKOw2iAhmu02fXAmPiJ8nrevXUAIcHH6LPiWLvSB5N7eeonW
 tBZRYglN6NzAOu5r+BUJnPRO74ydY+Q9/F4pm3+kvotEXbnDHXdoPkLespypP8tLRdEX1TkaVEM
 68YDXwUOA4aFdWixcrttTCqDYbgXVk9HpvVC/KjMFD+SWlNWiMoNP55uL6aAQn/PEJ3urxCq+Rl
 MwhUBDMqPpwFL4sA==
X-Received: by 2002:a05:600d:8492:b0:496:c9cd:e7ab with SMTP id
 5b1f17b1804b1-4980c64b873mr280626065e9.5.1785860708981; 
 Tue, 04 Aug 2026 09:25:08 -0700 (PDT)
Received: from jernej-laptop.localnet (APN-122-102-118-gprs.simobil.net.
 [46.122.102.118]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fec249a5fsm897076f8f.33.2026.08.04.09.25.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2026 09:25:08 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: wens@kernel.org
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, samuel@sholland.org, 
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/13] drm/sun4i: Align VI buffer addresses for subsampled
 formats
Date: Tue, 04 Aug 2026 18:25:06 +0200
Message-ID: <ugAWjG4QTtSgFVIbk0BoGg@gmail.com>
In-Reply-To: <CAGb2v67ugarRQAB=yDiyGti4E_r=dF0G08-TiGgphQSefHs8zQ@mail.gmail.com>
References: <cover.1785772659.git.jernej.skrabec@gmail.com>
 <CAGb2v66E95PwYhdPC4mkX1htF2VXECiGwUHfzLHV2ydOMiwxrg@mail.gmail.com>
 <CAGb2v67ugarRQAB=yDiyGti4E_r=dF0G08-TiGgphQSefHs8zQ@mail.gmail.com>
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

Dne torek, 4. avgust 2026 ob 13:14:38 Srednjeevropski poletni =C4=8Das je C=
hen-Yu Tsai napisal(a):
> On Tue, Aug 4, 2026 at 1:25=E2=80=AFAM Chen-Yu Tsai <wens@kernel.org> wro=
te:
> >
> > On Tue, Aug 4, 2026 at 12:11=E2=80=AFAM Jernej Skrabec <jernej.skrabec@=
gmail.com> wrote:
> > >
> > > This is a partial revert of commit 79ac1c945ab8 ("drm/sun4i: layers:
> > > Use drm_fb_dma_get_gem_addr() to get display memory").
> > >
> > > Chroma must start at the beginning of a subsampling block, for example
> > > chroma start address for NV12 must be aligned to 2 pixels.
> > > drm_fb_dma_get_gem_addr() offsets luma by the exact source coordinates
> > > and chroma by the coordinates divided by the subsampling factor, so f=
or
> > > odd offsets both planes no longer describe the same pixel, which the
> > > Display Engine scaler can't handle.
> > >
> > > Align source coordinates down for all planes instead. Remaining shift
> > > of one pixel is already compensated with scaler phase shift in
> > > sun8i_vi_layer_update_coord().
> >
> > Well I think this applies to the format in general, and probably should
> > be fixed in drm_fb_dma_get_gem_addr() instead?
> >
> > > Fixes: 79ac1c945ab8 ("drm/sun4i: layers: Use drm_fb_dma_get_gem_addr(=
) to get display memory")
> > > Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> > > ---
> > >  drivers/gpu/drm/sun4i/sun8i_vi_layer.c | 20 ++++++++++++++++++--
> > >  1 file changed, 18 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c b/drivers/gpu/drm=
/sun4i/sun8i_vi_layer.c
> > > index 09f668c8af24..ad036cb9d88e 100644
> > > --- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
> > > +++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
> > > @@ -197,15 +197,31 @@ static void sun8i_vi_layer_update_buffer(struct=
 sun8i_layer *layer,
> > >         struct drm_plane_state *state =3D plane->state;
> > >         struct drm_framebuffer *fb =3D state->fb;
> > >         const struct drm_format_info *format =3D fb->format;
> > > +       struct drm_gem_dma_object *gem;
> > > +       u32 dx, dy, src_x, src_y;
> > >         dma_addr_t dma_addr;
> > >         u32 ch_base;
> > >         int i;
> > >
> > >         ch_base =3D sun8i_channel_base(layer);
> > >
> > > +       /* Adjust x and y to be divisible by subsampling factor */
> > > +       src_x =3D (state->src.x1 >> 16) & ~(format->hsub - 1);
> > > +       src_y =3D (state->src.y1 >> 16) & ~(format->vsub - 1);
> >
> > AFAICT the only difference compared to drm_fb_dma_get_gem_addr()
> > is the masking here, i.e. round_down().
> >
> > > +
> > >         for (i =3D 0; i < format->num_planes; i++) {
> > > -               /* Get the start of the displayed memory */
> > > -               dma_addr =3D drm_fb_dma_get_gem_addr(fb, state, i);
> > > +               gem =3D drm_fb_dma_get_gem_obj(fb, i);
> > > +               dma_addr =3D gem->dma_addr + fb->offsets[i];
> > > +
> > > +               dx =3D src_x;
> > > +               dy =3D src_y;
> > > +               if (i > 0) {
> > > +                       dx /=3D format->hsub;
> > > +                       dy /=3D format->vsub;
> > > +               }
> > > +
> > > +               dma_addr +=3D dx * format->cpp[i];
> > > +               dma_addr +=3D dy * fb->pitches[i];
> >
> >
> > Where as the helper has (or used to have before the blocksize stuff):
> >
> >     paddr +=3D (format->cpp[plane] * (state->src_x >> 16)) / fb->format=
=2D>hsub;
> >     paddr +=3D (fb->pitches[plane] * (state->src_y >> 16)) / fb->format=
=2D>vsub;
> >
> > Am I missing something?
>=20
> After some headbanging on my end I see that the offset for the Y plane
> needs to be rounded down.
>=20
> But instead of reverting the whole thing and open-coding the helper
> again, could you adjust the address returned by the helper for odd
> offsets?

Yes, that's also an option. I'll do it in v2.

>=20
> And just a heads up, this also needs a clipped version of
> drm_fb_dma_get_gem_addr() as sun8i_ui_layer_update_coord() uses the
> clipped dimensions. I am currently working on this part.

Can you explain a bit more? I don't see why it needs any adjustement.

Best regards,
Jernej

>=20
>=20
> ChenYu
>=20
> > >
> > >                 /* Set the line width */
> > >                 DRM_DEBUG_DRIVER("Layer %d. line width: %d bytes\n",
> > > --
> > > 2.43.0
> > >
>=20




