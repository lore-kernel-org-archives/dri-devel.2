Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AD11C79FB6
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 00:15:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6144710E16D;
	Thu, 10 Sep 2026 00:15:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fireburn-co-uk.20251104.gappssmtp.com header.i=@fireburn-co-uk.20251104.gappssmtp.com header.b="UIGJCp+I";
	dkim-atps=neutral
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com
 [209.85.128.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A71410E16D
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 00:15:52 +0000 (UTC)
Received: by mail-yw1-f179.google.com with SMTP id
 00721157ae682-85a50f6a7f7so94692667b3.2
 for <dri-devel@lists.freedesktop.org>; Wed, 09 Sep 2026 17:15:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788999351; cv=none;
 d=google.com; s=arc-20260327;
 b=CK/QowLfKopPoLFJ1pfwDuckgcTELqfgZcIxi0CpIHhV/W4In+RNeveleI5xCrbCr3
 ZPgCFvQtsfEXKa9Z3kK8lIOOENfHhjtXsPrLo7DPYC1yJOgTAmPPiw5pL1oHEkcl+duM
 5QYLKcuT/WLtwmhOo2PRUVoyqy1KUIeU3kRYDmGAqM3KnPHoXeA48zzMrkG4KmvYH54T
 5mqLtSdr1c7AXriC9XnyBEgTLE6i8aiRXk4GRNGbcQc9ZyEEEP57LU0J0KZr8qXOp0UU
 AfM6Ev5Q6U/lsCBjEaqClfb5ialmQgIhBf8jCnzYA40lxV0a95IsJjxSsrMMyC/CwLkp
 Ihxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=FvfvgvsvTpdSimDtmvjd17d26cDmGGfX/zCh5Oy0Suw=;
 fh=A9jiD5WwDXie0mT39Di/JTetFJ0kTBXm7LGaOADwfIc=;
 b=EQNNkoY/fN0h+GXV+niZaxEqIPYE+AAX3Bvxv66AHAX9uIaiZzm5Ak/nLOnsVufMJi
 c0kSQUTcuRMo1uhOPpeu9gWRJqgRO3beSwxKu+KcbiM6ge/xeYI6KP4FjGRpKPkwzycE
 Z9UFW+bP7XZ+F41s7rior3ubUhT5rdC0fob2XE29/Br3Wbs8UlmlnLDLvRKVXsSXRKXJ
 hwyqk3gKP3JhX20WEeH2PpclMQEIxJTi1+Z7PVk5DuzaGDi2Vdsp12r+oj2Q6+nr6jpn
 JwY80QuZwG5iQIsTfViN/R/7JRwZg4a3/5Uf+YeUjb+gDKWdvF/XUyIQOTJMGUJgc04Z
 C3sg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20251104.gappssmtp.com; s=20251104; t=1788999351; x=1789604151;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FvfvgvsvTpdSimDtmvjd17d26cDmGGfX/zCh5Oy0Suw=;
 b=UIGJCp+IM7DHoxwFpu5cxXcNYUcQPYgvixoSUlM6AbQ9yfy4BUl3R3Y1O0T2peyHhI
 15XhrG6FDvaR7Wj6OJZHy7niE/+wrJKgVvodXDUm+DDjIUTEMxIgazR5t3/rnkJG+KTb
 mwlyO76+wFAhqT99U7SF5So4jGemL7viev0MzonF9F3vdjHl5YpvcBntGPZvpxurcPA8
 ds4EeTelBYS5h64yFXX39sZTH9vu4lK9rBL9Q2X2Kwk2aPC8GPqBA/TmkdtzwUS+J/jO
 PAO3z+rbozWalCbH0Sv2S/hSntbMCfdKNa3mTtrwoKcP69q/EHcnUoptNThAfRnmsNrp
 /TjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788999351; x=1789604151;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FvfvgvsvTpdSimDtmvjd17d26cDmGGfX/zCh5Oy0Suw=;
 b=eh7BYDO3wHgeFkX7DCn3WjMqSoyuOfeZ4ZC/UmqmvunFYp9D/psAMpK5cm50VRtd7E
 9rOy2zprBQzPkjLhdzETOzjDrN8DlawD/+kLb4+pKvMZoqyWu7tvDolpguGEoGoDDVfx
 Fx/yFHeA10GnTO9TG+h3bZxzwx5NCZCQHD5MDAWjcYTEGzxX/9XaTfkXRhqxehRDHuyB
 j26tOfLn0uL7bkR+gD9SMOYW2WGJ+PcgkOtyC0xT4GoX5l+Fl7sNOf+eF/IJrA0IQV6J
 Aow3rvnyhiFK8fuQDnWdfU4TJ5IB5OLJ8YdL7+RXCUqwVS5OEdbscIo1lfQeeENMf79G
 tf8w==
X-Forwarded-Encrypted: i=1;
 AKwUvBw/m6vIpZ6h2cfm0YE4+DZBas6ChfEkKO4ndni2aYQeyICF6YJ1SI0eaFRQZ1dKUxlBSFeOyXnD+oc=@lists.freedesktop.org
X-Gm-Message-State: AFuF++ntCAjaiA9JzJup78q/a4BZBFKk1MmmtNxsvQM1BG41GuAQlGyh
 le94i+Pld6MCezLEzDTiKT6i08R6VWCNvkoPL0AEBJink85sUdsEZ/Pn83tMOCFEZOxULsj5C6r
 uuHsiUYDaI9/KWxjT+OUeuVtJYcI0/Ww7SVJ7jCbz
X-Gm-Gg: AYBFou2gGAXCPuxcGZcaxugLclj9fa4CDg+iPRm8sdmwGjokrq28ATqbPxJcDZCJ1f3
 cx6Lr5D73NyArHlaTlNkn/WAbhw2mwmqZ+MX43GP3knVCJECbb5pNBXQxaDWGFp+wudAvl+egzS
 SR92me7FDeZ+akvgBjy6OmYAdn1/eTWLnnXryHYUCmD4fDkKMEGdbb8gDrVtvojJB0c0wa8sIsb
 1GCS2gQpXazFw8Qbel04W0+07P4Wc1CusLzBbTSeKkSLtSAju/hDUj66ZOb0h2M6GfnhBJlTK4Q
 ihcpPiAZzqhge67WC/CJTCnlxiiVLPP/6rCBqW0Jp3o6X40ibIay77SvkP6cPPBijSbQnus9lpv
 N9zO65/Zb4EsET7btaLX+ET6ULK+H1RTY5T8ajz+EVnV04g==
X-Received: by 2002:a05:690e:2006:b0:66f:c1bc:4035 with SMTP id
 956f58d0204a3-66fc1bc4670mr8352460d50.98.1788999351127; Wed, 09 Sep 2026
 17:15:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260909020854.58462-1-mike@fireburn.co.uk>
 <20260909094609.1541-1-mike@fireburn.co.uk>
 <e63d8ae9-f102-424f-88a5-0fd6837d79d4@amd.com>
In-Reply-To: <e63d8ae9-f102-424f-88a5-0fd6837d79d4@amd.com>
From: Mike Lothian <mike@fireburn.co.uk>
Date: Thu, 10 Sep 2026 01:15:39 +0100
X-Gm-Features: AcwNN1XQBCK9-NYAn3J4DkDrAeUXfHy9OxsiStI2D5iE6i7vvIKZ7yAdxs_R1EA
Message-ID: <CAHbf0-HAGCLcH2ryR6dgaTwMEjOgqbFFnzMUge-s1LZtjTohjA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: don't migrate a dma-buf into VRAM while
 runtime suspended
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
 kevinyang.wang@amd.com, dri-devel@lists.freedesktop.org, 
 stable@vger.kernel.org
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

On Wed, 9 Sept 2026 at 13:46, Christian K=C3=B6nig <christian.koenig@amd.co=
m> wrote:
>
> On 9/9/26 11:46, Mike Lothian wrote:
> > amdgpu_dma_buf_map() adds VRAM to the allowed domains for a peer2peer
> > attachment, so ttm_bo_validate() can migrate the buffer from GTT into
> > VRAM.  While the exporting device is runtime suspended its SDMA rings
> > are down and the move fails:
> >
> >   amdgpu: Move buffer fallback to memcpy unavailable
> >
> > An importer on a second GPU reaches this holding no runtime PM
> > reference on the exporter, e.g. a compositor on the APU submitting a
> > frame that references a buffer exported by an idle dGPU:
> >
> >   amdgpu_cs_ioctl -> amdgpu_cs_parser_bos -> amdgpu_cs_bo_validate
> >     -> ttm_bo_validate -> amdgpu_bo_move -> dma_buf_map_attachment
> >       -> amdgpu_dma_buf_map -> ttm_bo_validate -> amdgpu_bo_move
> >
> > Only migrate into VRAM while holding the exporter awake.
> > pm_runtime_get_if_active() takes a reference only when the device is
> > already active and never resumes it, so it cannot deadlock against the
> > reservation held across these callbacks.  That deadlock is why
> > commit 030631e97b20 ("drm/amdgpu: revert "take runtime pm reference
> > when we attach a buffer" v2") removed the pm_runtime_get_sync() from
> > the attach callback.
> >
> > If the device is suspended or suspending the buffer stays in GTT, which
> > remains accessible while the GPU is powered down.  A negative return
> > means runtime PM is disabled, so the device cannot suspend and VRAM
> > stays usable.
>
> That is a good catch, but your bug explanation as well as the solution st=
ill look a bit questionable to me.
> > Fixes: 030631e97b20 ("drm/amdgpu: revert "take runtime pm reference whe=
n we attach a buffer" v2")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Mike Lothian <mike@fireburn.co.uk>
> > Assisted-by: Claude:Opus-5 [Claude Code]
> > ---
> >
> > v2: hold the exporter with pm_runtime_get_if_active() across the
> >     validate instead of testing adev->mman.buffer_funcs_enabled.  The
> >     v1 check was racy - the device could suspend between the test and
> >     ttm_bo_validate(), so amdgpu_bo_move() could still see the rings
> >     torn down.  Reported by Sashiko AI review.
> >
> > Is this the failure that commit c52feb436539 ("drm/amdgpu: Disable
> > runtime PM for externally attached dGPUs") was working around?  That
> > commit explains how to detect external attachment but not what breaks,
> > so I can't tell which.
> >
> > If it is the same thing, could the pci_is_thunderbolt_attached() ||
> > dev_is_removable() check there be narrowed or dropped on top of this,
> > so eGPU users keep runtime PM?
> >
> > I can't test that here: this box hits the bug by missing that check.
> > The dGPU is on an oculink port off a native AMD root port, so
> > pci_is_thunderbolt_attached() is false, dev_is_removable() is empty,
> > and runtime PM stays enabled.
> >
> > Reproduced on a HawkPoint APU [1002:1900] driving the display with a
> > Navi 48 [Radeon AI PRO R9700] [1002:7551] on oculink for render
> > offload.  Without the patch kwin_wayland hits the call chain above
> > within a minute of the dGPU autosuspending and the desktop stops
> > repainting until it resumes.
>
> That sounds like there is also a bug in kwin as well.
>
> The GPU can only go into suspend when the rendering application closes it=
 driver connection and that usually only happens when it terminates

Not any more. amdgpu_driver_open_kms() does pm_runtime_get_sync() on
entry and pm_runtime_put_autosuspend() at the pm_put: label on every
path including success, so an open fd holds no reference.
amdgpu_driver_postclose_kms() is the same shape. I see the dGPU
autosuspend with the client's render node still open

> So question is here why is kwin still having that imported DMA-buf as nec=
essary resource for the rendering?

Because it is the content of a mapped window. kwin composites on the
APU and samples the buffer the client rendered on the dGPU. In 6.7.5
EglDisplay::importBufferAsImage() (src/opengl/egldisplay.cpp:395)
caches the EGLImage per GraphicsBuffer and drops it when the buffer is
destroyed, so the attach happens once, not per frame. The client can
then idle for minutes with the window still on screen

> But we still need to fix this properly in the kernel anyway to avoid havi=
ng a deny of service.
>
> >
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 16 ++++++++++++++--
> >  1 file changed, 14 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_dma_buf.c
> > index b33c300e26e2..c89846f266d3 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> > @@ -43,6 +43,7 @@
> >  #include <linux/dma-buf.h>
> >  #include <linux/dma-fence-array.h>
> >  #include <linux/pci-p2pdma.h>
> > +#include <linux/pm_runtime.h>
> >
> >  static const struct dma_buf_attach_ops amdgpu_dma_buf_attach_ops;
> >
> > @@ -189,14 +190,25 @@ static struct sg_table *amdgpu_dma_buf_map(struct=
 dma_buf_attachment *attach,
> >               /* move buffer into GTT or VRAM */
> >               struct ttm_operation_ctx ctx =3D { false, false };
> >               unsigned int domains =3D AMDGPU_GEM_DOMAIN_GTT;
> > +             int pm_ref =3D 0;
> >
> >               if (bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM &&
> >                   attach->peer2peer) {
> > -                     bo->flags |=3D AMDGPU_GEM_CREATE_CPU_ACCESS_REQUI=
RED;
> > -                     domains |=3D AMDGPU_GEM_DOMAIN_VRAM;
> > +                     /*
> > +                      * Only migrate into VRAM while the exporter is h=
eld
> > +                      * awake.  A negative return means runtime PM is
> > +                      * disabled, so it cannot suspend either.
> > +                      */
>
> Setting AMDGPU_GEM_DOMAIN_VRAM doesn't automatically migrate the BO, it j=
ust sets this as possible placement.

Not on this path. amdgpu_bo_placement_from_domain() marks GTT
TTM_PL_FLAG_FALLBACK when preferred_domains has VRAM and we are not an
APU, which is exactly when amdgpu_dma_buf_map() adds VRAM.
ttm_resource_compatible() skips fallback placements when not evicting,
so a BO in GTT is not compatible and ttm_bo_validate() migrates it

A WARN_ONCE on the failing branch gives old=3DTTM_PL_TT new=3DTTM_PL_VRAM
with amdgpu_dma_buf_map -> ttm_bo_validate -> amdgpu_bo_move in the
backtrace

> BO migration is only triggered if the BO is swapped out or similar. What =
most likely happens instead is that we suspend while something is still ong=
oing.
>
> But anyway the problem goes deeper than just the amdgpu_dma_buf_map() cal=
lback.
>
> We have picked up pinning DMA-buf to VRAM for RDMA without ODP (e.g. exac=
tly the feature I mention in the commit message of c52feb436539), but faile=
d to correctly fix the PM handling.
>
> So we really need to call pm_runtime_get_if_active() in amdgpu_dma_buf_at=
tach() and fail to let some other driver attach if the device is already su=
spended.

Happy to do that. Which behaviour do you want when it returns 0?

Failing the attach breaks render offload. The attachment lives as long
as the buffer, so a client allocating a new one while the dGPU is idle
gets a failed import and kwin has no texture for that window

Holding the reference until detach keeps offload working, but pins the
dGPU awake for as long as any of its buffers are imported, which in
practice is the whole session

Note the importer here is amdgpu on both ends, so "some other driver"
would not cover this case

Cheers

Mike

> Regards,
> Christian.
>
> > +                     pm_ref =3D pm_runtime_get_if_active(adev_to_drm(a=
dev)->dev);
> > +                     if (pm_ref) {
> > +                             bo->flags |=3D AMDGPU_GEM_CREATE_CPU_ACCE=
SS_REQUIRED;
> > +                             domains |=3D AMDGPU_GEM_DOMAIN_VRAM;
> > +                     }
> >               }
> >               amdgpu_bo_placement_from_domain(bo, domains);
> >               r =3D ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
> > +             if (pm_ref > 0)
> > +                     pm_runtime_put_autosuspend(adev_to_drm(adev)->dev=
);
> >               if (r)
> >                       return ERR_PTR(r);
> >       }
>
