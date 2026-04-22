Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DB22F9EDC9
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 12:55:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A125310EA06;
	Wed, 22 Apr 2026 12:55:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="sAoY57fO";
	dkim-atps=neutral
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D51A10E2AF
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 12:55:14 +0000 (UTC)
Received: by mail-dl1-f51.google.com with SMTP id
 a92af1059eb24-12c8cac037cso316045c88.3
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 05:55:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776862513; cv=none;
 d=google.com; s=arc-20240605;
 b=HtSJUS3p7zvRCW9SgYQJBfftfHeF6SX5BsAU/2XlnPMmHEzNm7aKywqKX83yBfPXr/
 xH7E8LWYfDM8aK4hytMSsvBewMVrQpJN2FzBCjAftXSTPYfqxiwuz09zCrPebL72+Uwp
 jiYKb1JI0Dl4m51szGPiWd8WvJZrP6cmft77NGeZ2SMSzjnUlwdbuIINMdlHK3DlBsq1
 CfVWNOhsfdPVlDWXVir8GR1IFfAwtP85yYapYkP66IosGqdntpdku31JuZS8I36Mz+25
 IUiWxbSyk7dpjbeRIS7NWWsNJKxWJEJtzz9m6F48WzEw+iDWWsoPpIy6zKcJY9uMorkN
 5drQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=XMA2IAQFuEAQkvlYVwoA50CqQYEHirECMjZyFrAmng4=;
 fh=/t7KG05zR6wRmCyO2nZpxLsdnqpuQNSIcbawGke0SYQ=;
 b=jkruKHyfyWdnQn2HkYMiZcaJvA+klwbS0FPcaqJqk/jo7tlnemviIJtNQ2xLdLzgc1
 UTp2FLLzlkL5xvj7OO7MR+E3Q1DUCbAfiYekCWtJzPMnPPTb+azYgXDIJpSxZwM6b6dB
 2ZclGRWIz+E6hYT9xF5vu0c9tnc51ChpQUCWacK3pqOOBOnELViPO9Ja2ApxkBSuIFes
 TZreWrCdUN5WKZHxXwvxUsGOBZvG90xSuzmAxURTV/nxBb6oQotAc3gb3yMnhGi2SXX9
 jXaCJB9HKGOW/Rwb40JfCnYRe0+TM1F9emuT4PtvXqI7QcMQCNmcgo3Jl+GfTGLedIRl
 MPaA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776862513; x=1777467313; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XMA2IAQFuEAQkvlYVwoA50CqQYEHirECMjZyFrAmng4=;
 b=sAoY57fO/MrBuqVO9ufPFcAofApeCALPEfdYxKcJeV4CX5PT9w9arIXwge9BUUhU0B
 cfOFv3RHG8GHlGHlYk//bLOq0uIUu90DUttNNiGnA84quSjrouwCC3jeJmaszgOeMeYB
 obKzHUwyU29/MGv4ej9+/yyL9u86mOAycFZ0y4z00Yl/q3WpzSBattu34in9XwGzgVI3
 253iEzmqmemnhq47bygtf7i34lvjC6S8paWHD3GIzRLtO0uCx196zRksaptWeTaD0rdk
 kdesArS0dVPT4+QCnUVg10eJglbOJFiYFtorQPo/OsjZTwY55bfLYE6Ty57tUy0CCUE7
 JQYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776862513; x=1777467313;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XMA2IAQFuEAQkvlYVwoA50CqQYEHirECMjZyFrAmng4=;
 b=aH5LlpxSU7PwEpE7wFvMwXlw0ouZSaVzeJggufQiUzJp1Fa9PTkxVZGvZlV9yPAZyR
 LKpHt9pp1hiYcdd829XJmRmzFR30aPBNq13imAb+oLBruz3NJTsl5fGCD8yxY6mRImVK
 X2dUyAng5zhYs0eHtOVk3OBBtIZX+vpVgknaRyjoP3ABzIFhqxTIttAmit9o6BCiV+au
 JMWlpp+8rYRuDzBjWNS7GRg+z8D2hdRFdVYF6zst/3U7pcPq3ebQQQw6w5vC4ikIydQG
 JTqMB3wet8RvN4gk1EY3CSke+0W3T88yxxm5mbzp6nv+D0XjK462MU2DnB/Yx4pt7Mjl
 bixg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/CM4PyKlvWv2ldbRs0zo2VDrIYvzoZC5eYVwpXCdsCyaAWTqACnJQ6YA4x+azzWW548DbOsap8AHY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx0ARiuw6P93sCeXrcWYOER6ntBCGmCV0J1XqYJI1Brda1zSUqh
 IOJ6D14Zu1LEkHbiYJnlwqy6TS8xSBsoxv9YrClLpA7fOz9uAhH31YT1a+jPNoYau/RGssjCW1s
 vlbvIC31vRf9VGk/D6bZvyklL+XoFaLg=
X-Gm-Gg: AeBDiesNl9kaebHMz8HJDTRcy8afDENDXkmoPFHTKWWwAaLg0eoj8baQg6VKSeOWsyh
 sRqeEXAClh39rgHeB/JbL7KsTlRjMwM4f8aIiiwdsw1KYLW8ZWmK8xBL+i2alLUx6ie683lvCpR
 ww2j4S1Weiyi+C2n2XCZB6LhNRcKc4hjVpsJJhTdLLx9glFgC5+ZUZ/b767r3v7Gsyb0HaXunW2
 s2WNxveZQavGU+qm4X7cV+s0ahRkPIzTU5qASdNRzutWcczOp4gumdDiUfyg3k3uuS5iBsqP92v
 nKAia1JvlWyJlDrlB7p/lzuhS/Zu9F6QqLdrvB0/Jhl0xUdQWA16YQJdey4sJIjkjkIstuVp412
 uzDZG
X-Received: by 2002:a05:7022:f9b:b0:12c:8cd7:d459 with SMTP id
 a92af1059eb24-12c8cd7dc44mr2878688c88.3.1776862513180; Wed, 22 Apr 2026
 05:55:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260421200311.15624-1-leonardocesar@usp.br>
 <59b686c6-42f5-4cde-8199-dae64722bfd1@amd.com>
In-Reply-To: <59b686c6-42f5-4cde-8199-dae64722bfd1@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 22 Apr 2026 08:55:01 -0400
X-Gm-Features: AQROBzBAGJ9G3CKNhIQVOisYvCS4hNJF1UCNu6or3WIMQcUxLHvEM2bdJiObLDw
Message-ID: <CADnq5_MGRpNE8Ge_5=w5mQDJivdS2Wt_2LD=dR-mrWH89Yc-0A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: deduplicate ring preempt ib function
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Leonardo Cesar <leonardocesar@usp.br>, alexander.deucher@amd.com,
 airlied@gmail.com, simona@ffwll.ch, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org
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

On Wed, Apr 22, 2026 at 3:09=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 4/21/26 22:03, Leonardo Cesar wrote:
> > The ring preemption function is identical for both gfx_v11_0 and
> > gfx_v12_0. This patch refactors the code by moving the core logic
> > into a generic function inside amdgpu_gfx.c to reduce code
> > duplication and simplify future maintenance.
>
> Yeah that one looks reasonable. As far as I can see there isn't anything =
HW generation specific in the function.
>
> Question is rather why we have that for gfx12 in the first place. @Alex I=
IRC we support preemption only for a very narrow use case on gfx11, could t=
hat just be accidentially be copied over?
>

Yeah, probably just copy and pasted over when we brought up gfx12.

Alex

> >
> > Signed-off-by: Leonardo Cesar <leonardocesar@usp.br>
> >
> > ---
> > v1 -> v2:
> > - Removed wrapper functions for gfx_v11 and gfx_v12 and updated call si=
tes directly.
> >
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | ...
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 51 ++++++++++++++++++++++++
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  2 +
> >  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 52 +------------------------
> >  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  | 52 +------------------------
> >  4 files changed, 55 insertions(+), 102 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_gfx.c
> > index 2956e45c9..a157cbd8e 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > @@ -2684,3 +2684,54 @@ void amdgpu_debugfs_compute_sched_mask_init(stru=
ct amdgpu_device *adev)
> >  #endif
> >  }
> >
> > +int amdgpu_gfx_ring_preempt_ib(struct amdgpu_ring *ring)
> > +{
> > +       int i, r =3D 0;
>
> Just a style nit: Variables like "i" or "r" last please and don't initial=
ize vairables like "r" while defining it.
>
> Regards,
> Christian.
>
> > +       struct amdgpu_device *adev =3D ring->adev;
> > +       struct amdgpu_kiq *kiq =3D &adev->gfx.kiq[0];
> > +       struct amdgpu_ring *kiq_ring =3D &kiq->ring;
> > +       unsigned long flags;
> > +
> > +       if (adev->enable_mes)
> > +               return -EINVAL;
> > +
> > +       if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
> > +               return -EINVAL;
> > +
> > +       spin_lock_irqsave(&kiq->ring_lock, flags);
> > +
> > +       if (amdgpu_ring_alloc(kiq_ring, kiq->pmf->unmap_queues_size)) {
> > +               spin_unlock_irqrestore(&kiq->ring_lock, flags);
> > +               return -ENOMEM;
> > +       }
> > +
> > +       /* assert preemption condition */
> > +       amdgpu_ring_set_preempt_cond_exec(ring, false);
> > +
> > +       /* assert IB preemption, emit the trailing fence */
> > +       kiq->pmf->kiq_unmap_queues(kiq_ring, ring, PREEMPT_QUEUES_NO_UN=
MAP,
> > +                                       ring->trail_fence_gpu_addr,
> > +                                       ++ring->trail_seq);
> > +       amdgpu_ring_commit(kiq_ring);
> > +
> > +       spin_unlock_irqrestore(&kiq->ring_lock, flags);
> > +
> > +       /* poll the trailing fence */
> > +       for (i =3D 0; i < adev->usec_timeout; i++) {
> > +               if (ring->trail_seq =3D=3D
> > +                       le32_to_cpu(*(ring->trail_fence_cpu_addr)))
> > +                       break;
> > +               udelay(1);
> > +       }
> > +
> > +       if (i >=3D adev->usec_timeout) {
> > +               r =3D -EINVAL;
> > +               DRM_ERROR("ring %d failed to preempt ib\n", ring->idx);
> > +       }
> > +
> > +       /* deassert preemption condition */
> > +       amdgpu_ring_set_preempt_cond_exec(ring, true);
> > +       return r;
> > +}
> > +
> > +
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_gfx.h
> > index a0cf0a3b4..77050f988 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> > @@ -664,6 +664,8 @@ void amdgpu_gfx_csb_preamble_end(u32 *buffer, u32 c=
ount);
> >  void amdgpu_debugfs_gfx_sched_mask_init(struct amdgpu_device *adev);
> >  void amdgpu_debugfs_compute_sched_mask_init(struct amdgpu_device *adev=
);
> >
> > +int amdgpu_gfx_ring_preempt_ib(struct amdgpu_ring *ring);
> > +
> >  static inline const char *amdgpu_gfx_compute_mode_desc(int mode)
> >  {
> >         switch (mode) {
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/a=
md/amdgpu/gfx_v11_0.c
> > index 5097de940..1ba848bfa 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> > @@ -6206,56 +6206,6 @@ static void gfx_v11_0_ring_emit_gfx_shadow(struc=
t amdgpu_ring *ring,
> >         ring->set_q_mode_offs =3D offs;
> >  }
> >
> > -static int gfx_v11_0_ring_preempt_ib(struct amdgpu_ring *ring)
> > -{
> > -       int i, r =3D 0;
> > -       struct amdgpu_device *adev =3D ring->adev;
> > -       struct amdgpu_kiq *kiq =3D &adev->gfx.kiq[0];
> > -       struct amdgpu_ring *kiq_ring =3D &kiq->ring;
> > -       unsigned long flags;
> > -
> > -       if (adev->enable_mes)
> > -               return -EINVAL;
> > -
> > -       if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
> > -               return -EINVAL;
> > -
> > -       spin_lock_irqsave(&kiq->ring_lock, flags);
> > -
> > -       if (amdgpu_ring_alloc(kiq_ring, kiq->pmf->unmap_queues_size)) {
> > -               spin_unlock_irqrestore(&kiq->ring_lock, flags);
> > -               return -ENOMEM;
> > -       }
> > -
> > -       /* assert preemption condition */
> > -       amdgpu_ring_set_preempt_cond_exec(ring, false);
> > -
> > -       /* assert IB preemption, emit the trailing fence */
> > -       kiq->pmf->kiq_unmap_queues(kiq_ring, ring, PREEMPT_QUEUES_NO_UN=
MAP,
> > -                                  ring->trail_fence_gpu_addr,
> > -                                  ++ring->trail_seq);
> > -       amdgpu_ring_commit(kiq_ring);
> > -
> > -       spin_unlock_irqrestore(&kiq->ring_lock, flags);
> > -
> > -       /* poll the trailing fence */
> > -       for (i =3D 0; i < adev->usec_timeout; i++) {
> > -               if (ring->trail_seq =3D=3D
> > -                   le32_to_cpu(*(ring->trail_fence_cpu_addr)))
> > -                       break;
> > -               udelay(1);
> > -       }
> > -
> > -       if (i >=3D adev->usec_timeout) {
> > -               r =3D -EINVAL;
> > -               DRM_ERROR("ring %d failed to preempt ib\n", ring->idx);
> > -       }
> > -
> > -       /* deassert preemption condition */
> > -       amdgpu_ring_set_preempt_cond_exec(ring, true);
> > -       return r;
> > -}
> > -
> >  static void gfx_v11_0_ring_emit_de_meta(struct amdgpu_ring *ring, bool=
 resume)
> >  {
> >         struct amdgpu_device *adev =3D ring->adev;
> > @@ -7295,7 +7245,7 @@ static const struct amdgpu_ring_funcs gfx_v11_0_r=
ing_funcs_gfx =3D {
> >         .emit_cntxcntl =3D gfx_v11_0_ring_emit_cntxcntl,
> >         .emit_gfx_shadow =3D gfx_v11_0_ring_emit_gfx_shadow,
> >         .init_cond_exec =3D gfx_v11_0_ring_emit_init_cond_exec,
> > -       .preempt_ib =3D gfx_v11_0_ring_preempt_ib,
> > +       .preempt_ib =3D amdgpu_gfx_ring_preempt_ib,
> >         .emit_frame_cntl =3D gfx_v11_0_ring_emit_frame_cntl,
> >         .emit_wreg =3D gfx_v11_0_ring_emit_wreg,
> >         .emit_reg_wait =3D gfx_v11_0_ring_emit_reg_wait,
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/a=
md/amdgpu/gfx_v12_0.c
> > index 65c33823a..6cf244349 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> > @@ -4611,56 +4611,6 @@ static unsigned gfx_v12_0_ring_emit_init_cond_ex=
ec(struct amdgpu_ring *ring,
> >         return ret;
> >  }
> >
> > -static int gfx_v12_0_ring_preempt_ib(struct amdgpu_ring *ring)
> > -{
> > -       int i, r =3D 0;
> > -       struct amdgpu_device *adev =3D ring->adev;
> > -       struct amdgpu_kiq *kiq =3D &adev->gfx.kiq[0];
> > -       struct amdgpu_ring *kiq_ring =3D &kiq->ring;
> > -       unsigned long flags;
> > -
> > -       if (adev->enable_mes)
> > -               return -EINVAL;
> > -
> > -       if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
> > -               return -EINVAL;
> > -
> > -       spin_lock_irqsave(&kiq->ring_lock, flags);
> > -
> > -       if (amdgpu_ring_alloc(kiq_ring, kiq->pmf->unmap_queues_size)) {
> > -               spin_unlock_irqrestore(&kiq->ring_lock, flags);
> > -               return -ENOMEM;
> > -       }
> > -
> > -       /* assert preemption condition */
> > -       amdgpu_ring_set_preempt_cond_exec(ring, false);
> > -
> > -       /* assert IB preemption, emit the trailing fence */
> > -       kiq->pmf->kiq_unmap_queues(kiq_ring, ring, PREEMPT_QUEUES_NO_UN=
MAP,
> > -                                  ring->trail_fence_gpu_addr,
> > -                                  ++ring->trail_seq);
> > -       amdgpu_ring_commit(kiq_ring);
> > -
> > -       spin_unlock_irqrestore(&kiq->ring_lock, flags);
> > -
> > -       /* poll the trailing fence */
> > -       for (i =3D 0; i < adev->usec_timeout; i++) {
> > -               if (ring->trail_seq =3D=3D
> > -                   le32_to_cpu(*(ring->trail_fence_cpu_addr)))
> > -                       break;
> > -               udelay(1);
> > -       }
> > -
> > -       if (i >=3D adev->usec_timeout) {
> > -               r =3D -EINVAL;
> > -               DRM_ERROR("ring %d failed to preempt ib\n", ring->idx);
> > -       }
> > -
> > -       /* deassert preemption condition */
> > -       amdgpu_ring_set_preempt_cond_exec(ring, true);
> > -       return r;
> > -}
> > -
> >  static void gfx_v12_0_ring_emit_rreg(struct amdgpu_ring *ring, uint32_=
t reg,
> >                                      uint32_t reg_val_offs)
> >  {
> > @@ -5539,7 +5489,7 @@ static const struct amdgpu_ring_funcs gfx_v12_0_r=
ing_funcs_gfx =3D {
> >         .pad_ib =3D amdgpu_ring_generic_pad_ib,
> >         .emit_cntxcntl =3D gfx_v12_0_ring_emit_cntxcntl,
> >         .init_cond_exec =3D gfx_v12_0_ring_emit_init_cond_exec,
> > -       .preempt_ib =3D gfx_v12_0_ring_preempt_ib,
> > +       .preempt_ib =3D amdgpu_gfx_ring_preempt_ib,
> >         .emit_wreg =3D gfx_v12_0_ring_emit_wreg,
> >         .emit_reg_wait =3D gfx_v12_0_ring_emit_reg_wait,
> >         .emit_reg_write_reg_wait =3D gfx_v12_0_ring_emit_reg_write_reg_=
wait,
> > --
> > 2.43.0
> >
>
