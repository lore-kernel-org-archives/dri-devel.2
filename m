Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3702C5DF97
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 22:36:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B19210F3E0;
	Fri, 21 Aug 2026 22:36:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rM/wJVSJ";
	dkim-atps=neutral
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com
 [209.85.210.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3E9410F3E1
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 22:36:20 +0000 (UTC)
Received: by mail-pf1-f178.google.com with SMTP id
 d2e1a72fcca58-84862b0d5aeso1202628b3a.2
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 15:36:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787351780; cv=none;
 d=google.com; s=arc-20260327;
 b=kFGzBNreaTfdhh166fuHbLqDBWr8/ZDoF3FpillWmtHEzP6q48nshGSDvp3Ij4Y02p
 64Za10WaGftGNOvWlKrtXEukr1VtvzO2Zk2uGmksdZCzLQ2BlnqVcIDaqj/865E9m3K/
 hozUubD4JsDiEPW2cE2nOstGcd0OsnbF0MecDrrqcoIYKbBhblo78/sMyH2qdKY1VfCp
 qI9yGqaH3J5fZCKsW03fve0TXGqzX1miWXUIR639nFY/FxADSqKV1n8/APMad0ptuP4O
 iJhyFEbRcQVirDykf+TDb9rJfxvn1iI7i2iaQsA537gsmq4K0PFr9AqoFjOERkVCQMad
 s9Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=jaWf+hmaqddnDUOtsPaTRUJjDHClz1pfmQFe8O2ji+4=;
 fh=QyvbOl5hq+0eZzmSl2b55K/TaBgKxGTP8RxJ7xipISw=;
 b=onjzkHTq7FDadAh4/Bws1+I4ERqnyHCnIfzs3QtngLjwRz1eDZDFggctLvnGkS5zhO
 rh6jPiH0oOqRh/2EhLls0J8tRIUNGNyfimRRtevtj5QAJvbSVBemj9F1OlKX42i7Mnkr
 dURIS2p9qES+ckatQFqXSXGrfsgQ0DqmwisdKOAsBoiZTPs0IpmhB0OiJKE2vz8oKUGp
 1yzJFJlIldM05chXs2ubEUh7x6vDMIwiO1oSX6IMcbfXTcUl8ySAhI70rzNneP1asc2T
 a7G5GZX43BlMELczt3LHLB4BNrDpjTq+BH6ZiJa/8hDVsf8pYWH5FrYV7D4o/ra5p+wu
 CyUw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787351780; x=1787956580; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jaWf+hmaqddnDUOtsPaTRUJjDHClz1pfmQFe8O2ji+4=;
 b=rM/wJVSJmRYisR8xrOeuuMeVKgxSLeOWAc8LpgaeLkq2Y30kyxl61EJgeIzdGwUOJx
 Vto7/egh5bJnsxk5YzmyMsFA79b3VYSztJsbW5MB+xHMn+mPKrSMYA7pHz5LEUTZHjaI
 oet5366O4XZM1YLZsP5RRH0gizJyBgn20BOvTS5BgsFm4frjjEFzKCaxm+JUrCOzq9Hl
 8snSF0d8Wtf8qUSQVsxYujaO3MDKEGe8KaV/5noQ9KHJ+0T3w7GpOXrH4XVWCFf2xYsV
 s1T/oJLruGqL5uzQJMTM7zD/F5iW3YYubZIup3a1CBRWGIAUvP+HAM3nAkU4almHfkNr
 HDmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787351780; x=1787956580;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jaWf+hmaqddnDUOtsPaTRUJjDHClz1pfmQFe8O2ji+4=;
 b=G8V5vybK+ZsHSQztL1YWv40emaS20X/GonJz8NB7YJC5L/5gQAL5xrTpP6yj4oQdBd
 P0Mh2MQ4A/uvQ/qeu3khrjE7mEsQLOmoZ71Rob+IomvorGQlQIBw0nWsJ/oVz8uBM4Ey
 0CtJbe/A6gqfkBRljlosq3hJaM7vGcq7l2Ht0bePeEnKWM7AliHP2/gXH0XUe/GV8iEk
 cFfWXmenjnvDXcBbqY1fu3QJZzmoRbDU+a4KaE7sa3Lh2Uy5Jqn+/gxzgIBySsct0PCv
 DoK4wE5UdkgrhB88BzweTTBRgavvvg1XT6b6VkmRd/nP+GkQ/OWbxu5b+C0lWYhiFVPC
 VhUw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrz2V2v3iJ9frACySe7it9UtpjeiRGJG592N+Jdt3jlc8f6pdIO+cgyLbPpDDmoIbQGJ2sxMQX9bX4=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kvoJbJpzWGgKhOHuEpvLbGFxTGBp3zlxFXb7YY/YSnJGusgPqu
 qeR8svcmOtqTuG9uRfZ2J+Cyy6kpkDfIZLX1sqaMj4Lf2+gFVxSWWxSFtVxg6yc0NU5puZWHeyb
 5kSmCJlf5/B3kSgIAgO4oMYEwW8Nv9kB1fZ8E
X-Gm-Gg: AR+sD13TtDBEYBB8SncJ8ia0scRuqJvW4U9bnyAnXqT5HJYmf6Mf/n1hC3dJWgFP533
 56XpR2vc1QesNR4cS0YNxODtaEzR0ITOl8JE5vdVf5bJo7Q3gXfY/ssFltiSgzoVdF69u/aiVaw
 C2vu16ZhUcqU8BQpnPV5cdfgEQWQYDBsOowDpyhIWTtUlKtNt37DNnXrg0peFpCjRdubGKkdbjI
 hccheZsW9GqP2ymEeBoGYv4WI93anh9/bUOXkBi/s125QYXiLACUAOtAhPsM90FrMYK/mozWDda
 urAWJFEb2ox2lD/fssPcPDuFLtvEoOpDxSpmyr5/JxI=
X-Received: by 2002:a05:6300:67c8:b0:3cc:3d08:da3e with SMTP id
 adf61e73a8af0-3cd2fdd1cfcmr18173591637.2.1787351780221; Fri, 21 Aug 2026
 15:36:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260820164929.17117-1-mohamedahmedegypt2001@gmail.com>
 <20260820164929.17117-9-mohamedahmedegypt2001@gmail.com>
 <33cd07ffe8f6a9c525f9d9b6d646efbf09cf76e9.camel@redhat.com>
In-Reply-To: <33cd07ffe8f6a9c525f9d9b6d646efbf09cf76e9.camel@redhat.com>
From: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
Date: Sat, 22 Aug 2026 02:36:08 +0400
X-Gm-Features: AcwNN1XoSU5CB0z4SMYc1EoD_kRVt6P6sfxebC3gSSHsnE-BOyDGF2vp96trW_M
Message-ID: <CAA+WOBsNkoL_fx48fL_hQ+Lg7ErG8cLZx0gUrqrKVA73RAoZGA@mail.gmail.com>
Subject: Re: [PATCH v2 08/10] drm/nouveau/gsp: fix vblank interrupts on GB20x
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

On Sat, Aug 22, 2026 at 2:12=E2=80=AFAM <lyude@redhat.com> wrote:
>
> Some comments regarding both patch #2 and this patch below:
>
>
> On Thu, 2026-08-20 at 20:49 +0400, Mohamed Ahmed wrote:
> > The GSP path programs per-head timing (vblank) interrupts the same
> > way on
> > every generation. NVD5.0 (GB20x) reworked the FE interrupt frontend
> > around four message-based kernel vectors (high latency, low latency,
> > PMU,
> > and GSP) and moved RM head-timing interrupts to the dedicated low-
> > latency
> > vector:
> >
> >  - The enable is NV_PDISP_FE_RM_INTR_EN1_HEAD_TIMING, 0x611ef0 +
> >    head*4 (570.144 kernel_head_0501.c, renamed kernel_head_0502.c
> > from
> >    575.51.02 on, and v05_01 dev_disp.h).
> >
> >  - The vector is reported as a separate interrupt table entry,
> >    MC_ENGINE_IDX_DISP_LOW (intr_gb202.c, intrCacheDispIntrVectors).
> >
> >  - The vector must be re-armed through NV_PDISP_FE_INTR_RETRIGGER(1)
> >    at 0x611f34 after servicing (kdispServiceInterrupt ->
> >    kdispIntrRetrigger_v05_01).
> >
> > The event latch (0x611800), per-head status (0x611c00), and dispatch
> > summary (0x611ec0) the interrupt handler uses are unchanged on GB20x
> > (kheadReadPendingVblank_v03_00 and kheadResetPendingLastData_v03_00
> > remain for DISPv0502+).
> >
> > On GB20x the old code enables head timing onto the legacy vector,
> > leaves
> > its handler there, and never re-arms the message-based vectors. Page
> > flips still complete (nv50 sends those events from the commit path),
> > so
> > the desktop looks fine while DRM vblank waits and vblank sequence
> > queries
> > are affected.
> >
> > Supply GB20x vblank enables and an interrupt handler that re-arms the
> > vector after servicing through gb202_gsp_disp, translate the low-
> > latency
> > interrupt table entry as a second NVKM_ENGINE_DISP instance, and flag
> > the table so r535_disp_oneinit() attaches the handler to that
> > instance.
> >
> > Signed-off-by: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
> > ---
> >  .../gpu/drm/nouveau/nvkm/engine/disp/gb202.c  | 42
> > +++++++++++++++++--
> >  .../nouveau/nvkm/subdev/gsp/rm/r535/disp.c    |  5 ++-
> >  .../drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c |  9 ++++
> >  3 files changed, 52 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/gb202.c
> > b/drivers/gpu/drm/nouveau/nvkm/engine/disp/gb202.c
> > index a66c820be9fe..f78669bafd64 100644
> > --- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/gb202.c
> > +++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/gb202.c
> > @@ -130,6 +130,40 @@ gb202_head_state(struct nvkm_head *head, struct
> > nvkm_head_state *state)
> >       }
> >  }
> >
> > +/* NVD5.0 (GB20x and later) moved the RM head-timing interrupt
> > enable to
> > + * the low-latency vector's EN1 block. The event latch is unchanged.
> > + */
> > +static void
> > +gb202_head_vblank_put(struct nvkm_head *head)
> > +{
> > +     struct nvkm_device *device =3D head->disp-
> > >engine.subdev.device;
> > +
> > +     nvkm_mask(device, 0x611ef0 + (head->id * 4), 0x00000002,
> > 0x00000000);
> > +}
> > +
> > +static void
> > +gb202_head_vblank_get(struct nvkm_head *head)
> > +{
> > +     struct nvkm_device *device =3D head->disp-
> > >engine.subdev.device;
> > +
> > +     nvkm_wr32(device, 0x611800 + (head->id * 4), 0x00000002);
> > +     nvkm_mask(device, 0x611ef0 + (head->id * 4), 0x00000002,
> > 0x00000002);
> > +}
> > +
> > +static irqreturn_t
> > +gb202_disp_intr(struct nvkm_inth *inth)
> > +{
> > +     struct nvkm_disp *disp =3D container_of(inth, typeof(*disp),
> > engine.subdev.inth);
> > +     irqreturn_t ret =3D tu102_disp_intr(inth);
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
> >  /* GB20x is GSP-only. This table supplies the register programming
> > the
> >   * GSP-RM display path needs from the chip.
> >   */
> > @@ -137,11 +171,13 @@ static const struct nvkm_disp_func
> >  gb202_gsp_disp =3D {
> >       .uevent =3D &gv100_disp_chan_uevent,
> >       .ramht_size =3D 0x2000,
> > -     .gsp.intr =3D tu102_disp_intr,
> > +     /* Head timing arrives on the dedicated low-latency vector.
> > */
> > +     .gsp.intr =3D gb202_disp_intr,
> > +     .gsp.intr_low_latency =3D true,
> >       .gsp.head_state =3D gb202_head_state,
> >       .gsp.head_rgpos =3D gv100_head_rgpos,
> > -     .gsp.vblank_get =3D tu102_head_vblank_get,
> > -     .gsp.vblank_put =3D tu102_head_vblank_put,
> > +     .gsp.vblank_get =3D gb202_head_vblank_get,
> > +     .gsp.vblank_put =3D gb202_head_vblank_put,
> >       .gsp.hdmi_gcp =3D gb202_sor_hdmi_gcp,
> >       /* The legacy AVI unit is unchanged on GB20x. */
> >       .gsp.hdmi_infoframe_avi =3D gv100_sor_hdmi_infoframe_avi,
> > diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
> > b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
> > index 3a8ff621ed62..a95f78c4502f 100644
> > --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
> > +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
> > @@ -1705,7 +1705,10 @@ r535_disp_oneinit(struct nvkm_disp *disp)
> >
> >       /* Chips that raise head-timing interrupts on a separate
> > low-latency
> >        * vector report it as a second DISP interrupt table entry,
> > exposed
> > -      * as instance 1 by the RM engine-index translation.
> > +      * as instance 1 by the RM engine-index translation (see
> > +      * r570_gsp_xlat_mc_engine_idx()). Their high-latency vector
> > +      * (instance 0) is left unhandled as no event nouveau
> > enables is
> > +      * routed to it, and without a handler it stays masked.
> >        */
>
> I didn't notice it until I got to this patch, but is it possible you
> mistakenly added the intr_low_latency stuff a little early with patch
> #2 and meant to add it here?
>
> (doesn't matter to me too much either way, whatever you intended works
> fine with me)
>
Yeah it was a rebase mistake and then I figured I could salvage it as
a bit of future-proofing in #2. I can try to fix it properly though.
> Otherwise:
>
> Reviewed-by: Lyude Paul <lyude@redhat.com>
>
> >       ret =3D nvkm_gsp_intr_stall(gsp, disp->engine.subdev.type,
> >                                 disp->func->gsp.intr_low_latency ?
> > 1 : disp->engine.subdev.inst);
> > diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c
> > b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c
> > index 3e391646d8f7..b45781cd0dfd 100644
> > --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c
> > +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c
> > @@ -44,6 +44,15 @@ r570_gsp_xlat_mc_engine_idx(u32 mc_engine_idx,
> > enum nvkm_subdev_type *ptype, int
> >               *ptype =3D NVKM_ENGINE_DISP;
> >               *pinst =3D 0;
> >               return true;
> > +     case MC_ENGINE_IDX_DISP_LOW:
> > +             /* GB20x+ report a separate low-latency display
> > vector, used
> > +              * for head-timing interrupts. Expose it as a second
> > DISP
> > +              * interrupt instance. r535_disp_oneinit() attaches
> > the
> > +              * handler to it when the chip's
> > gsp.intr_low_latency is set.
> > +              */
> > +             *ptype =3D NVKM_ENGINE_DISP;
> > +             *pinst =3D 1;
> > +             return true;
> >       case MC_ENGINE_IDX_CE0 ... MC_ENGINE_IDX_CE19:
> >               *ptype =3D NVKM_ENGINE_CE;
> >               *pinst =3D mc_engine_idx - MC_ENGINE_IDX_CE0;
>
