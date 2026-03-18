Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B01AC10775E6
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 16:22:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EE2B10E00B;
	Wed, 18 Mar 2026 16:22:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ivPGCZx/";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9632210E02A
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 16:22:03 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 4CECA40768
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 16:22:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3001CC2BC87
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 16:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773850923;
 bh=T97aoZ7NgVNK3bf7m5LjMK8b5ZisKHJvvvuGMXalsA0=;
 h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
 b=ivPGCZx/qfMr6Q0pIxSJwtm9cV7ZMj6RhwAwtzAMIGLhIDs6k9KpdiHoyzWAx9U86
 nSj6s6c8P0Jo+sIPgFcLGuW5NO79zpXmK4o2eAXQMekPZGOu8PjW9Y4L8ycOzo03dB
 FJt5FpqXLGIE8ZSvY0t0q49Dg916nSE5AzdfLtTzgt3WZClc3vdnMhDgtBOwW9ULwJ
 fCgLlwQ3u8Io4qSAPs7EGDKJbE80zQHeG93ZahKdlOxh/jOqQUkhRwNyZl/7dxtXfl
 qcQKUYgbeJ7cHK/OqhB1vAzyJEBxoYu9b5sE6CTRBEK/otC6Stvyat2hYmEPCNuEbW
 E0kUOjIRDCe0A==
Received: by mail-lj1-f169.google.com with SMTP id
 38308e7fff4ca-38a46657a9fso860591fa.1
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 09:22:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCU2Ru2XP4gHvAjQ9EQk56aZXYt/e2BUEjUSdpl0gzyqNIhhwliG6ieN3vkFV2lArKJEroMdiv25c30=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzpAfjSggt+SZGUhbXaA24se46a/amqc/pYSJrgUMt8PVsm6QZc
 i8FWzfvDY3b257SwvF0lKdVD9iy+pK7pMUico4Hka3XMaNAxF13FjTTZjZsTaNeI0Hr/cfxh85Z
 1ACz5b3C5YwyudvJqi54Im5oBDNp86R0=
X-Received: by 2002:a05:651c:f02:b0:38a:6acc:8dd with SMTP id
 38308e7fff4ca-38bd57d16b4mr16195451fa.15.1773850921511; Wed, 18 Mar 2026
 09:22:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260317064049.696795-1-wenst@chromium.org>
 <20260317064049.696795-2-wenst@chromium.org>
 <20260318160239.GB633439@killaraus.ideasonboard.com>
In-Reply-To: <20260318160239.GB633439@killaraus.ideasonboard.com>
From: Chen-Yu Tsai <wens@kernel.org>
Date: Thu, 19 Mar 2026 00:21:49 +0800
X-Gmail-Original-Message-ID: <CAGb2v66+OHbNOQLk1JojFapPDhSK6eqCySRWzQVYGkvAivqD4Q@mail.gmail.com>
X-Gm-Features: AaiRm503aLc_PUnOAbewqYGMjHBxRoTrFj-iNoSyc6onK3A0wGY85ZN-PahRSYQ
Message-ID: <CAGb2v66+OHbNOQLk1JojFapPDhSK6eqCySRWzQVYGkvAivqD4Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] drm/rcar-du: Use drm_gem_dma_get_sg_table() helper
 to get scatter gather table
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 asahi@lists.linux.dev
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

On Thu, Mar 19, 2026 at 12:02=E2=80=AFAM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Chen-Yu,
>
> Thank you for the patch.
>
> On Tue, Mar 17, 2026 at 02:40:43PM +0800, Chen-Yu Tsai wrote:
> > The rcar-du driver is directly calling dma_get_sgtable() on a
> > drm_gem_dma_object. Not passing the dma_attrs field in may cause
> > problems when DMA_ATTR_NO_KERNEL_MAPPING is added to the GEM DMA
> > helpers gain support later.
> >
> > Instead, use the drm_gem_dma_get_sg_table() helper to get the scatter
> > gather table.
> >
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > ---
> > Changes since v1:
> > - new patch
> >
> > Not sure if we should add a helper like drm_fb_dma_get_gem_addr(). This
> > seems to be the only driver that is using a scatter gather table to pas=
s
> > DMA addresses.
>
> The DU can't access memory directly (at least on Gen3 and newer), and
> goes through a separate device called VSP that acts as an external DMA
> engine (*) and compositor. This is why buffers need to be mapped
> manually to the VSP, the GEM helpers would otherwise use the DU struct
> device, which isn't correct. I can't use drm_device.dma_dev as the DMA
> initiator can be different per CRTC.
>
> I don't think a separate helper with a single user would be very useful
> here, especially given that part of the logic in
> drm_fb_dma_get_gem_addr() is in the separate vsp1 driver. Refactoring
> may get messy, for little benefit.
>
> * And in some cases the VSP further delegates memory access to the FCP,
> which is yet another DMA initiator from an IOMMU point of view.

I see. That's probably the most complicated hardware I've seen so far.

> > ---
> >  drivers/gpu/drm/renesas/rcar-du/rcar_du_vsp.c | 12 +++++++++---
> >  1 file changed, 9 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_vsp.c b/drivers/gp=
u/drm/renesas/rcar-du/rcar_du_vsp.c
> > index 94c22d2db197..6a62608ee3a9 100644
> > --- a/drivers/gpu/drm/renesas/rcar-du/rcar_du_vsp.c
> > +++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_vsp.c
> > @@ -291,10 +291,16 @@ int rcar_du_vsp_map_fb(struct rcar_du_vsp *vsp, s=
truct drm_framebuffer *fb,
> >                               dst =3D sg_next(dst);
> >                       }
> >               } else {
> > -                     ret =3D dma_get_sgtable(rcdu->dev, sgt, gem->vadd=
r,
> > -                                           gem->dma_addr, gem->base.si=
ze);
>
> Did you compile the patch ? The rcdu variable is now unused. Apart from
> that, it compiles fine and seems to operate as expected.

I probably missed it in the logs. Thanks for catching it.

> > -                     if (ret)
> > +                     struct sg_table *ret_sgt;
> > +
> > +                     ret_sgt =3D drm_gem_dma_get_sg_table(gem);
> > +                     if (IS_ERR(ret_sgt)) {
> > +                             ret =3D PTR_ERR(ret_sgt);
> >                               goto fail;
> > +                     }
> > +
> > +                     memcpy(sgt, ret_sgt, sizeof(*sgt));
> > +                     kfree(ret_sgt);
>
> It's a bit of a shame to kmalloc() a new sg_table and free it right
> after :-/ Would it be that bad to switch to dma_get_sgtable_attrs()
> here, and pass gem->dma_attrs to the function ?

That's another option. I was trying to isolate the DMA API calls to
just the GEM DMA helpers, but as you said, it's a bit wasteful.

I'll just switch to dma_get_sgtable_attrs() and squash the change into
the other dma_*_attrs() conversion patch.


Thanks
ChenYu

> >               }
> >
> >               ret =3D vsp1_du_map_sg(vsp->vsp, sgt);
>
> --
> Regards,
>
> Laurent Pinchart
