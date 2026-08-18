Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F2F7C5DF7D
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 20:02:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE01710E03F;
	Tue, 18 Aug 2026 20:02:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LoxO+cUA";
	dkim-atps=neutral
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com
 [209.85.215.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F377E10E03F
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 20:02:18 +0000 (UTC)
Received: by mail-pg1-f180.google.com with SMTP id
 41be03b00d2f7-ca7c1176317so134170a12.1
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 13:02:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787083338; cv=none;
 d=google.com; s=arc-20260327;
 b=kTbg8oZ5PstZrM6xRPgVDReV5yfzbER+rHvrEe0KFc4sAPyqYRVMZhyUKy2EvOpV5Z
 JcrzsyJdrjZu15eR3J6/3mDCUMGSbg4tWL4zFh3zmKogsMi01OxqqFSrGvGGu/wTPM3n
 QO1aT0emgOTETYoJQBJU945/s0oVyIxAkjZy+5AlEl0goMSQ8hrVr+ptDX7pLBFrPKGb
 UyUjPSgyCu5z3SPWDQlRyyK4I0BP3gXQ6At/13koW4jjGRQLUJX8VlZHZXDQzS6f5KB9
 H4sy4qCjeNuVlV5JNM5okb5r6dArPMmGozRUSPgMEulLOIm+nBxoroxyxuJJfDhOW7Sw
 d1Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=bALn7f+Zopw3SX8ojVaX++nOpa4KFELG4NTJqBbG5+c=;
 fh=OkEGjbhnGU4aEBBCOB9nbb6VZ4g8vB4m+PtckbTFOg4=;
 b=jTUAgxYXmIopbDOTMZ6OfvC2HxjtdGFDl2O9Na2QcUoBDFqrWOkBGMTmkf3RsWgRRF
 poZJVhi/TZ5xWD1yL9RG9lHAawPdKK4cpMtrrBCOi/QifF3V9ZFA+s7x7eBj4jthkxOa
 7dd1hGYYFIzZ5uRY1C7PLg/dVqOJI4JrAOJvxiRG3FhE10fT0q7Cgdo7sSeD/l2UNayA
 anKyLaGrh5/I25PORZeIHIzfg97c6IIiIjB4QvNhgYvj+dTaxbD4rRDvnfSCFOHDO/ys
 +R6+OpAMBM16Kmsw13p2Q+iCpfwE62bYehaumDlhZNK5fGvMO5vPujPTwFd/SUALESaB
 4sQA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787083338; x=1787688138; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bALn7f+Zopw3SX8ojVaX++nOpa4KFELG4NTJqBbG5+c=;
 b=LoxO+cUA6iByrlyrrZe8l2oszKIObwvyaxf7sA93rVrqJrKwYE5NA82Lqdw/UyVBAD
 HLnKuCH9qJ/Keag1eyXUMs1hzt2xDAYgUV59/a9Azlo5ed2nyYgpg/yl0KDlDRPkcLpL
 3VEeimp+PGy1yLetWmxtgNu7TmUkdcQu7dY2Z5a8qgIIaSUYuBT1EqYWXKhTMz9HaTKG
 LA+kTA1JOKeQTiyrSy87qCa5tg1xQ4JpJkVTKNsfEx6KHGyyqDppCDVHEHuUUWgrq8Iy
 o8LrIKfg84ugA8EIj2YcEyCD9gdZN3IebTQNNda5RiZgPutidTwc6fTRLZ3Jbyr9wXx6
 nppA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787083338; x=1787688138;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bALn7f+Zopw3SX8ojVaX++nOpa4KFELG4NTJqBbG5+c=;
 b=NXfpNowRY4S5sN0IswD23MeeuAsGC7bqlYkKTCZynbZUcdpNwuE9IXST39LnCtFqSz
 eBigX/PULTNd3iotz6drr52h+D2A1S7rYdjFCojcSOd8Jzw0Djuxh71AAlmVMaMKg72M
 LmprNJ/Ie8Bb4zeXYSBYEJ2JPOQpAsEWk90ZdbGfgIvSlzoojbt6HY5NnFBxzlXhziqN
 XqwxvjxKcXDh4OejdsnPaCEbXIDGnDPi9qWVt9/i9TUhAfpE1kPGq1orB7jSXBrGsJx1
 yr2B2u8uEDkE7VURrVALb4hU+KS8gCEntEYicKyw/8C3UeCbgE3SVDc0oNnqaD+N7EMY
 ZROw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpX1CchGJYKnNFKKbovOyAmQ81Dq0YKEgwKbC58WqmuWWivzVtEKPmCIsjAL7glDDLIkjnH2Jnt2No=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YymfQIDoy9qQuCrcclsZhbZPkXkj6AM9GMtc8UNTbes4gEU70q0
 YUFVLmYZS9VYViRr4OKZv9HHu0T1wwyBXD0nGSqDaDluME/EbdZaAE0ewZvmEsYE3GkOc1KnGFF
 860+iLnwex55pdQXK0P3YX85peQNHK67KQ8uoTvA=
X-Gm-Gg: AR+sD11XTE5ymrkrVCU5nKdIF4YxcX6c6zluHhprYCggeUgYOS3/eZ2faP4z9E0zL/A
 YjBOLSCsQ/tgqlcglarHXYs+e9IH9v3+wTwro8Gjn+Xi3hUFSus3LzijtneZ19JUAbuv3qy6e3p
 J1Ji34gNtSKzoXWsq4+ksCRZi5U8Yp/8jJ40TxnMGqNO4e6un0xFQqnWJ+3R9AWd3jWLt+TGh6R
 CMcux3tTD604FdFD1XQHoWF9CKzauyWHimH4VZ3e03h46pctdNnD0M/4yoAw2nGlv2qcPC1sTVD
 +xMe7rnc9dqA3hLlpCPlRReFqMql39YgcDq5KzwYdRtaF6Tn9XLUQDQ=
X-Received: by 2002:a05:6a21:7a9b:b0:3c3:791e:5e0c with SMTP id
 adf61e73a8af0-3ccff09f2damr481284637.19.1787083338276; Tue, 18 Aug 2026
 13:02:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260814235705.59132-1-mohamedahmedegypt2001@gmail.com>
 <20260814235705.59132-6-mohamedahmedegypt2001@gmail.com>
 <996d2033b1522090867e50f181e9b4daaab19861.camel@redhat.com>
In-Reply-To: <996d2033b1522090867e50f181e9b4daaab19861.camel@redhat.com>
From: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
Date: Wed, 19 Aug 2026 00:02:06 +0400
X-Gm-Features: AcwNN1VxU2BifjzzAG5-T_Vb2L4L4_OCcG96ymxk6orVp3OjMs6asBXgKb_Hs-k
Message-ID: <CAA+WOBvj2Q3-P9F5JgA4S+C0E46Zkyt6bLcVzWhfvaWWmTH7Vg@mail.gmail.com>
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

On Tue, Aug 18, 2026 at 2:59=E2=80=AFAM <lyude@redhat.com> wrote:
>
> On Sat, 2026-08-15 at 03:57 +0400, Mohamed Ahmed wrote:
> >
> > +
> > +static const struct nvkm_head_func
> > +gb202_head =3D {
> > +     .state =3D r535_head_state,
> > +     .vblank_get =3D gb202_head_vblank_get,
> > +     .vblank_put =3D gb202_head_vblank_put,
> > +};
> > +
>
> You should probably add these two as well:
>
>         .state =3D gv100_head_state,
>         .rgpos =3D gv100_head_rgpos,
>
> I don't think they've actually changed in blackwell, but it's possible
> maybe they do change in GB200x so you probably want to double check so
> we don't lose precise vblank timestamps again.
>
The head state changed actually (but RG position didn't), so adding
this in would be a regression. I have some work to wire it up properly
(part of VRR bringup) but I wasn't sure whether to include it in this
series or not. We don't have precise vblank timestamps for anything
GSP atm and everything falls back to the interrupt path, so it would
technically be a new feature rather than fix ups.
> >  static struct nvkm_conn *
> >  r535_conn_new(struct nvkm_disp *disp, u32 id)
> >  {
> > @@ -1496,6 +1523,20 @@ r535_disp_intr(struct nvkm_inth *inth)
> >       return IRQ_HANDLED;
> >  }
> >
> > +static irqreturn_t
> > +gb202_disp_intr(struct nvkm_inth *inth)
> > +{
> > +     struct nvkm_disp *disp =3D container_of(inth, typeof(*disp),
> > engine.subdev.inth);
> > +     irqreturn_t ret =3D r535_disp_intr(inth);
> > +
> > +     /* The FE interrupt vectors are message-based on NVD5.0. Re-
> > arm the
> > +      * low-latency vector so it fires again for any event that
> > latched
> > +      * while we were servicing.
> > +      */
> > +     nvkm_wr32(disp->engine.subdev.device, 0x611f34, 0x00000001);
> > +     return ret;
> > +}
> > +
> >  static void
> >  r535_disp_fini(struct nvkm_disp *disp, bool suspend)
> >  {
> > @@ -1568,7 +1609,9 @@ r535_disp_oneinit(struct nvkm_disp *disp)
> >       struct nvkm_device *device =3D disp->engine.subdev.device;
> >       struct nvkm_gsp *gsp =3D device->gsp;
> >       const struct nvkm_rm_api *rmapi =3D gsp->rm->api;
> > +     const struct nvkm_rm_gpu *gpu =3D gsp->rm->gpu;
> >       NV2080_CTRL_INTERNAL_DISPLAY_WRITE_INST_MEM_PARAMS *ctrl;
> > +     nvkm_inth_func intr_func;
> >       unsigned long mask;
> >       int ret, i;
> >
> > @@ -1722,7 +1765,12 @@ r535_disp_oneinit(struct nvkm_disp *disp)
> >               nvkm_gsp_rm_ctrl_done(&disp->rm.objcom, ctrl);
> >
> >               for_each_set_bit(i, &disp->head.mask, disp->head.nr)
> > {
> > -                     ret =3D nvkm_head_new_(&r535_head, disp, i);
> > +                     const struct nvkm_head_func *func =3D
> > &r535_head;
> > +
> > +                     if (gpu->disp.class.root >=3D GB202_DISP)
> > +                             func =3D &gb202_head;
> > +
> > +                     ret =3D nvkm_head_new_(func, disp, i);
> >                       if (ret)
> >                               return ret;
> >               }
> > @@ -1766,12 +1814,21 @@ r535_disp_oneinit(struct nvkm_disp *disp)
> >       if (ret)
> >               return ret;
> >
> > -     ret =3D nvkm_gsp_intr_stall(gsp, disp->engine.subdev.type,
> > disp->engine.subdev.inst);
> > +     if (gpu->disp.class.root >=3D GB202_DISP) {
> > +             /* GB20x deliver head-timing interrupts on the
> > display's
> > +              * separate low-latency vector (interrupt table
> > instance 1).
> > +              */
> > +             ret =3D nvkm_gsp_intr_stall(gsp, disp-
> > >engine.subdev.type, 1);
> > +             intr_func =3D gb202_disp_intr;
> > +     } else {
> > +             ret =3D nvkm_gsp_intr_stall(gsp, disp-
> > >engine.subdev.type, disp->engine.subdev.inst);
> > +             intr_func =3D r535_disp_intr;
> > +     }
> >       if (ret < 0)
> >               return ret;
> >
> >       ret =3D nvkm_inth_add(&device->vfn->intr, ret,
> > NVKM_INTR_PRIO_NORMAL, &disp->engine.subdev,
> > -                         r535_disp_intr, &disp-
> > >engine.subdev.inth);
> > +                         intr_func, &disp->engine.subdev.inth);
> >       if (ret)
> >               return ret;
> >
> > diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c
> > b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c
> > index 996941c668ba..2590b22663cb 100644
> > --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c
> > +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c
> > @@ -44,6 +44,14 @@ r570_gsp_xlat_mc_engine_idx(u32 mc_engine_idx,
> > enum nvkm_subdev_type *ptype, int
> >               *ptype =3D NVKM_ENGINE_DISP;
> >               *pinst =3D 0;
> >               return true;
> > +     case MC_ENGINE_IDX_DISP_LOW:
> > +             /* GB20x+ report a separate low-latency display
> > vector, used
> > +              * for head-timing interrupts. Expose it as a second
> > DISP
> > +              * interrupt instance.
> > +              */
> > +             *ptype =3D NVKM_ENGINE_DISP;
> > +             *pinst =3D 1;
> > +             return true;
> >       case MC_ENGINE_IDX_CE0 ... MC_ENGINE_IDX_CE19:
> >               *ptype =3D NVKM_ENGINE_CE;
> >               *pinst =3D mc_engine_idx - MC_ENGINE_IDX_CE0;
>
