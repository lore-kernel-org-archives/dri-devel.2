Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A1BFC5DF7D
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 20:09:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8248710E4E0;
	Tue, 18 Aug 2026 20:09:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TiFRc4Xo";
	dkim-atps=neutral
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3715310EC50
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 20:09:42 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-2d58efc7356so2867005ad.1
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 13:09:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787083782; cv=none;
 d=google.com; s=arc-20260327;
 b=osiWqAO0xr5q/oEwyF1FUH2CSa0a0yC1aFQcAggGykyYY/t8k9NYRi2r2E6tJK4Tih
 6urbIDl6PoFAgus6zhp7Nz2xBo5IRTNjo1oZf2V7YLjqytDUDOcIcaGITWEC6p6H2/9v
 sDTe91LihxCe1Qtyf45CknKuq4JqhUWgTUcA0O4hlBX5E7cN89Gr9fPvj4rvEGUnHpK3
 3MAfRLPenxtiHBmPwzk4iL/7YpTDqV1HXOtgZy2SczoRpG+AEdop1FVXXSYt18CC7ID6
 7mLeRVpKzORWCUA936mMYJb/CCefZegrmMWKO+YbqNb5glcq43+H4IyAJKVOhjcs1s1d
 q7dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=jZYskyW08zgMImgX0YFcFXsxVtNqFp2DmI9fJNn8/bM=;
 fh=Ct6mUbVL6tviW8KjtCBBitd/++fuXa3Sr/f92ZeV2mw=;
 b=azvniD6JeQ9OksWJVHOuqhNvK1n5XO2x5UakSTOSkfjckX6Q6TxUw3KgmMOqVFLyP9
 mrD0Pz6jjiMeiuIZu4amk+NYvdI/De6ZY9Kg2nWXUEzsV9hWpoEfhV8fQAn1JQ3yN39Y
 SppGDha4+DsJmuX1tKrtPrd3787CCOaSdGX7wOxEIKWf7swM19Pr5QzybarsCjkS213M
 uCvd0YkBQ+RKut1XdbEpjBV8+Qu7BGqJGh6+jPx08SvejXR59Bec4RJI+/hKSe5qrKG9
 CnKny8IYQvpoLGDh1OKdupZX+F8latLRPVx7VP992mWsUi6vZsaIxfQPblP+2qSgc3Mq
 coXQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787083782; x=1787688582; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jZYskyW08zgMImgX0YFcFXsxVtNqFp2DmI9fJNn8/bM=;
 b=TiFRc4XobPJsuHx+Dx/yoR0QCN53Tv9jXqvQ3x1jalZW4edRoycvyDfEbvdP/bwcIu
 wA6TOl/OuVOLRuxOtWpmTnYL3EIhlAscH301ResNNwUE/LHteP963E1AINUyZrCDwb3j
 A+QMm6rYhtB3aN5qamxYJL6XiJPmQicWKBaRlmDdzDk+W1zhjV6ziYF3oEEdLCwf6/7+
 VS/kFlQX6Qn6EowECS+gp2zlG34jOQmfyROul7GPzDHOCTBmXib7YtjFQeRoatTlu05p
 RLmjgHG7VAEn08Hju6SktTa5yS4z1sOMNz2qUnwcP/8jR+G2P+6ZmChpu2i86joXrsGi
 DQ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787083782; x=1787688582;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jZYskyW08zgMImgX0YFcFXsxVtNqFp2DmI9fJNn8/bM=;
 b=LEKWSBooANniI7OIOoNH3CzvCA47CmGdQUpd8feQlSPuVpaE+1M/zHcd4IM2sBnHC8
 sKaGOwHhr10Ob9l0Aj6dF3ce2Bi5ufh6VJOyfYFg84HZPZdJueANhy5jtvHJhvHuDvlp
 AlXpc/Mv7gp7vwAL5QNmDT79fBJ7x0XDUatMMqox1qCQI2zYqlwzmvpx5GzHsfhXySzc
 RD7S3lHdv6s7thV91bW+nsDwHGJbJQxS7LhSURu8pw2XApgNGcjrRLoGI3bOGfvCgWaL
 0pVSBzm2Bwgn6fS73VNpfTTglHYjX7cgg7Xliw/oPMDntrbbCkbTxsBzwV8WHpyxpxqJ
 bo0g==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr/8xuRfwnCBT21PvbFCphskH8vBvfAZBYTYKPDVMKMxmwKB8oOfIvplZtZb+DZ0u7kBOXGFXLmSAc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzrgl5DNL5rCdHosxcFLmxpETOxtxYvWQJqR7bHSu121OSE1UmR
 4JQTb031rlgfbAP7sUKj/bh6XBCR9KQ32ke4icZstvjahWuFMClt3gm+7Uj1Jnr+QIK5vkLzJW5
 u1HQWfsEdjcPRfKc8XNnhLRnNA5b/Keg=
X-Gm-Gg: AR+sD10bI1KlWLQe7qwyjoxhLXXpf+TpmOS7xCvyZwEcCbW27AwZc6xzMikCbIB92nf
 447gwlBZyoJOqQk8ml2BJFXIWakm4q54IfS0fBwA0YEYzFtRQoxnYc1TZYx6mecBukeDJbipSZD
 PuU5QHOpqUp0H2T1vI+eKFKG+iubTSVPGMo9np6SVvFeVIeGgTStB6SQQg/BG2QcO/VDJL8qEa/
 6Ik6dssaxoMPVplVaugSVo+DBtEtxSmzfTfrJWB2+k8PGNKWGVGrqM2emyutc1nA6LNRngA0TXa
 Bk5JUygSFcEqklBTuhKXerp8BhaXAdYgXElmV12dyNA097WjAXZ6lw==
X-Received: by 2002:a17:90b:4490:b0:393:288:29e3 with SMTP id
 98e67ed59e1d1-3957b2527c3mr403834a91.10.1787083781624; Tue, 18 Aug 2026
 13:09:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260814235705.59132-1-mohamedahmedegypt2001@gmail.com>
 <20260814235705.59132-6-mohamedahmedegypt2001@gmail.com>
 <996d2033b1522090867e50f181e9b4daaab19861.camel@redhat.com>
 <CAA+WOBvj2Q3-P9F5JgA4S+C0E46Zkyt6bLcVzWhfvaWWmTH7Vg@mail.gmail.com>
 <6a9619f71c1f033044ba01c6ff6ba78af4a0aff1.camel@redhat.com>
In-Reply-To: <6a9619f71c1f033044ba01c6ff6ba78af4a0aff1.camel@redhat.com>
From: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
Date: Wed, 19 Aug 2026 00:09:29 +0400
X-Gm-Features: AcwNN1W_auS0i7vhE5u1Af6pg4eCo3cKJPP2Rl5vF5JZ1RJWuxPIS13GyvwK7hI
Message-ID: <CAA+WOBtbC176yVMZ1OZHQANNdNhHuGVtNMdiDLeSvHKmsD3L-A@mail.gmail.com>
Subject: Re: [PATCH 5/7] nouveau/gsp: fix vblank interrupts on GB20x
To: lyude@redhat.com
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 Danilo Krummrich <dakr@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Mary Guillemard <mary@mary.zone>, nouveau@lists.freedesktop.org
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

On Wed, Aug 19, 2026 at 12:06=E2=80=AFAM <lyude@redhat.com> wrote:
>
> On Wed, 2026-08-19 at 00:02 +0400, Mohamed Ahmed wrote:
> > On Tue, Aug 18, 2026 at 2:59=E2=80=AFAM <lyude@redhat.com> wrote:
> > >
> > > On Sat, 2026-08-15 at 03:57 +0400, Mohamed Ahmed wrote:
> > > >
> > > > +
> > > > +static const struct nvkm_head_func
> > > > +gb202_head =3D {
> > > > +     .state =3D r535_head_state,
> > > > +     .vblank_get =3D gb202_head_vblank_get,
> > > > +     .vblank_put =3D gb202_head_vblank_put,
> > > > +};
> > > > +
> > >
> > > You should probably add these two as well:
> > >
> > >         .state =3D gv100_head_state,
> > >         .rgpos =3D gv100_head_rgpos,
> > >
> > > I don't think they've actually changed in blackwell, but it's
> > > possible
> > > maybe they do change in GB200x so you probably want to double check
> > > so
> > > we don't lose precise vblank timestamps again.
> > >
> > The head state changed actually (but RG position didn't), so adding
> > this in would be a regression. I have some work to wire it up
> > properly
> > (part of VRR bringup) but I wasn't sure whether to include it in this
> > series or not. We don't have precise vblank timestamps for anything
> > GSP atm and everything falls back to the interrupt path, so it would
> > technically be a new feature rather than fix ups.
>
> Actually we definitely do now! We didn't used to for ages, but I wrote
> a patch that got upstreamed for it a few weeks ago, you can see it
> here:
>
> static const struct nvkm_head_func
> r535_head =3D {
>         .state =3D gv100_head_state,
>         .rgpos =3D gv100_head_rgpos,
>         .vblank_get =3D r535_head_vblank_get,
>         .vblank_put =3D r535_head_vblank_put,
> };
>
> If the patch for adding this to blackwell is already ready I wouldn't
> mind taking it as part of this series, but that's up to you
>
Ohh woops, sorry. I missed that. Yes, I'll rebase on top of the latest
then and re-test.
> > > >  static struct nvkm_conn *
> > > >  r535_conn_new(struct nvkm_disp *disp, u32 id)
> > > >  {
> > > > @@ -1496,6 +1523,20 @@ r535_disp_intr(struct nvkm_inth *inth)
> > > >       return IRQ_HANDLED;
> > > >  }
> > > >
> > > > +static irqreturn_t
> > > > +gb202_disp_intr(struct nvkm_inth *inth)
> > > > +{
> > > > +     struct nvkm_disp *disp =3D container_of(inth, typeof(*disp),
> > > > engine.subdev.inth);
> > > > +     irqreturn_t ret =3D r535_disp_intr(inth);
> > > > +
> > > > +     /* The FE interrupt vectors are message-based on NVD5.0.
> > > > Re-
> > > > arm the
> > > > +      * low-latency vector so it fires again for any event that
> > > > latched
> > > > +      * while we were servicing.
> > > > +      */
> > > > +     nvkm_wr32(disp->engine.subdev.device, 0x611f34,
> > > > 0x00000001);
> > > > +     return ret;
> > > > +}
> > > > +
> > > >  static void
> > > >  r535_disp_fini(struct nvkm_disp *disp, bool suspend)
> > > >  {
> > > > @@ -1568,7 +1609,9 @@ r535_disp_oneinit(struct nvkm_disp *disp)
> > > >       struct nvkm_device *device =3D disp->engine.subdev.device;
> > > >       struct nvkm_gsp *gsp =3D device->gsp;
> > > >       const struct nvkm_rm_api *rmapi =3D gsp->rm->api;
> > > > +     const struct nvkm_rm_gpu *gpu =3D gsp->rm->gpu;
> > > >       NV2080_CTRL_INTERNAL_DISPLAY_WRITE_INST_MEM_PARAMS *ctrl;
> > > > +     nvkm_inth_func intr_func;
> > > >       unsigned long mask;
> > > >       int ret, i;
> > > >
> > > > @@ -1722,7 +1765,12 @@ r535_disp_oneinit(struct nvkm_disp *disp)
> > > >               nvkm_gsp_rm_ctrl_done(&disp->rm.objcom, ctrl);
> > > >
> > > >               for_each_set_bit(i, &disp->head.mask, disp-
> > > > >head.nr)
> > > > {
> > > > -                     ret =3D nvkm_head_new_(&r535_head, disp, i);
> > > > +                     const struct nvkm_head_func *func =3D
> > > > &r535_head;
> > > > +
> > > > +                     if (gpu->disp.class.root >=3D GB202_DISP)
> > > > +                             func =3D &gb202_head;
> > > > +
> > > > +                     ret =3D nvkm_head_new_(func, disp, i);
> > > >                       if (ret)
> > > >                               return ret;
> > > >               }
> > > > @@ -1766,12 +1814,21 @@ r535_disp_oneinit(struct nvkm_disp *disp)
> > > >       if (ret)
> > > >               return ret;
> > > >
> > > > -     ret =3D nvkm_gsp_intr_stall(gsp, disp->engine.subdev.type,
> > > > disp->engine.subdev.inst);
> > > > +     if (gpu->disp.class.root >=3D GB202_DISP) {
> > > > +             /* GB20x deliver head-timing interrupts on the
> > > > display's
> > > > +              * separate low-latency vector (interrupt table
> > > > instance 1).
> > > > +              */
> > > > +             ret =3D nvkm_gsp_intr_stall(gsp, disp-
> > > > > engine.subdev.type, 1);
> > > > +             intr_func =3D gb202_disp_intr;
> > > > +     } else {
> > > > +             ret =3D nvkm_gsp_intr_stall(gsp, disp-
> > > > > engine.subdev.type, disp->engine.subdev.inst);
> > > > +             intr_func =3D r535_disp_intr;
> > > > +     }
> > > >       if (ret < 0)
> > > >               return ret;
> > > >
> > > >       ret =3D nvkm_inth_add(&device->vfn->intr, ret,
> > > > NVKM_INTR_PRIO_NORMAL, &disp->engine.subdev,
> > > > -                         r535_disp_intr, &disp-
> > > > > engine.subdev.inth);
> > > > +                         intr_func, &disp->engine.subdev.inth);
> > > >       if (ret)
> > > >               return ret;
> > > >
> > > > diff --git
> > > > a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c
> > > > b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c
> > > > index 996941c668ba..2590b22663cb 100644
> > > > --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c
> > > > +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c
> > > > @@ -44,6 +44,14 @@ r570_gsp_xlat_mc_engine_idx(u32 mc_engine_idx,
> > > > enum nvkm_subdev_type *ptype, int
> > > >               *ptype =3D NVKM_ENGINE_DISP;
> > > >               *pinst =3D 0;
> > > >               return true;
> > > > +     case MC_ENGINE_IDX_DISP_LOW:
> > > > +             /* GB20x+ report a separate low-latency display
> > > > vector, used
> > > > +              * for head-timing interrupts. Expose it as a
> > > > second
> > > > DISP
> > > > +              * interrupt instance.
> > > > +              */
> > > > +             *ptype =3D NVKM_ENGINE_DISP;
> > > > +             *pinst =3D 1;
> > > > +             return true;
> > > >       case MC_ENGINE_IDX_CE0 ... MC_ENGINE_IDX_CE19:
> > > >               *ptype =3D NVKM_ENGINE_CE;
> > > >               *pinst =3D mc_engine_idx - MC_ENGINE_IDX_CE0;
> > >
>
