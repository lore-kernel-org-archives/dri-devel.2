Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC68CFF8867
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 13:51:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18EB110F033;
	Wed, 29 Apr 2026 13:51:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bvXhZRvF";
	dkim-atps=neutral
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77AC710F033
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 13:51:25 +0000 (UTC)
Received: by mail-dl1-f43.google.com with SMTP id
 a92af1059eb24-12714f01940so851283c88.0
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 06:51:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777470685; cv=none;
 d=google.com; s=arc-20240605;
 b=iV5OF7o+6UCY4j7hyL0eQCueG+r+rL88+94yvtOdl21TQVVXeaOMy1eighHQ4ofO/M
 GG50lEffCKP8+i+2+ZphU+4DIQ1IcsAnKmmKj8uPQYx9WNI2I73+QDLOYcY2eC+CUUw4
 nDKsNhgp+DzjuLQzd9JT59XK1/ACgyOS2WspXMPatCGdBsqBfmLnTzQePWZ0jpa/lfNN
 N8U/zQQLG57mKGjJxg1/YHHZ2duzCC4Fpkzrw6iJBQQX9iyDoHTSpBMvD31/UyZ+c9UK
 ifGEsIMQDGf3I06H70DIt2JLhkidNV6pVEkkknEkBpVZY0PYNACY9FWkIuMm/JOsAFhW
 AyxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=QaoAn8DS0yZuY6OqaxjQw7MLX36SlFZ88L9O11T0AXQ=;
 fh=G2aggllH915J9XjlmXHJTB9nqRLGUCL3ezAFFWPYIf8=;
 b=QOzea2gaTshpyJkHUwA/DU2MiNrGEVYtBafUgfd4uPWqFqvPYYY50vqkzi51WCzkFX
 HadkyizNmkg1IjNup5q7gzKBn3WgAaG3n9rMBTFTNqh9oqfNDUi10wMAcQizY4g0oiNW
 JrTFWiTboCO8RqDyS4LnWbGxz6+MMQewiw3k9lNH0Sfo8QvYXc2wZ7C2KJJQyme2M79a
 3tGlcU1eLIYXiY+e8xeiMaW6LgWOjjjRRyyCEcJgYezbu+N4Yi6ONteTiM3RqgpROSiJ
 EV3nq6edwiom4ALRbTh/WJJXibU+r7AM/7sHXLQGAexqtd/6nNXiDsfhwTVc8N2061sx
 VKKA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777470685; x=1778075485; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QaoAn8DS0yZuY6OqaxjQw7MLX36SlFZ88L9O11T0AXQ=;
 b=bvXhZRvFqIV6NLXNnYup+HKVxfVXeulObaKaA2zCGDDRuPX2wXbAq+H4XoLliMOhjp
 lPz0iyaW0hmL2t3qHuPWywaF/uqPQh+1338Dq/Tcy9HuNwNNdx/fn9kOQy7sdCYPoNNX
 tih7RSuKlxAjto4KNkXnizzZRWWGqbUAWXmBMTW5YVNytSzewOMRQpTauMwTliKdYNmk
 wSN7O2jILAD6QdeEsOJ1DQh5cQbiZc8LYSeqOOh/vt8pACyzb/Zeh95fhcQLGmQNQI1D
 RhyAna+TRPgBiFVou7iXmkOFQ8r/LIWaNz3mhWpJaYNLvbyJJ0BCq5CggCdFeG8ZfuT8
 /vvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777470685; x=1778075485;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QaoAn8DS0yZuY6OqaxjQw7MLX36SlFZ88L9O11T0AXQ=;
 b=OLCf+PdMTE4GLZyD+9SDg3aPZY9dHOAgpYphkdgTuljpqs6/r087roQKx4eaLHjYmQ
 GZhT3n2RWZBu6gRCUCmIlSL3O0gmZaMz4AdMviaywIgqg98Z0+v5PZX+6Gx+CzSC+pt+
 ZHZCTDvV//RI36htM8kXYqMYTQ8rzP68rz67vo3buFkniojgi35XPkpdlbYUqVap0fRK
 jG+6e92ZG7Tfs/3oNgFxu8iRqtIuGJP+xEM4ErEbuwy2LmRkvGSxF78+6W9NoH4uHHq5
 PgFDq0Pyudf+2TTy14eILBsMDpwib/gIgr8whZENYI+a6glI+QHEthHIw+3aEBncSDqI
 og/g==
X-Forwarded-Encrypted: i=1;
 AFNElJ88/HtYllWBxfDYoMjtWDBaZU5jSAcvrnB1BFl1gH+vBPSy3kGXUsI2kn1rzFVw2I/oZyAuf4YAgNo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwnD/0f+D4jp/4vnRCBCPVxD0BXX8Y+eYhRwskEeups/5Rq33bx
 QJI+gymeottD+I80xORPJpgM0mr9Go6Zidy3A3Z7UUeGketp492z/j1k/kgXx5Yhf9BZLX+Krq4
 IFwNmflG4JVxYBgOzKLUOD3Xb0fk7ydY=
X-Gm-Gg: AeBDieuZvHR6rwZ+AzmQRpe0kc2Ccp9YzEGUmCknY0iEYO0cSeWK/e5hV+hKnxKIB1q
 mBUG20f3gn0QoSyBx+Zd8+hG52FxqMYcxljld9AG3RcrLqzDq+IEYO7BZ/q8dlArSgSvGGzjE9V
 McXW+rI99+pvdkXiiihCW2umS1SQRQ7wza2p7Rodfe6bdpBMtbZhRJEBvxPgNfrIqvwNppcHeqY
 9Ghm5lvY65CULOtSOIh/epWq9MIT1hmj47bUcbBIuxPTDw7DXOg8k7jxOUT7VvsmiFOVOiTWjmW
 bUXUTcEs2MEUHf3K+zqd351+0bBNpblAwhddALD6IwnunEtJN7rZ2dkLAC6PrsoJuOWrkZRAL68
 cLwwM
X-Received: by 2002:a05:7022:6089:b0:12b:f899:7178 with SMTP id
 a92af1059eb24-12ddd54ed39mr1623295c88.7.1777470684470; Wed, 29 Apr 2026
 06:51:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260428232009.10737-1-leonardocesar@usp.br>
 <38b716ff-fac9-4921-8121-4a76cf1cef18@amd.com>
In-Reply-To: <38b716ff-fac9-4921-8121-4a76cf1cef18@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 29 Apr 2026 09:51:12 -0400
X-Gm-Features: AVHnY4JVsTc-BelPZacFiBBEXrzxLXfPvi6gaNF6uJlEwkAtJr4aRjJIq6CTwck
Message-ID: <CADnq5_Nvfj-WMc039YvjoWfYiXcQ5estN573dO1Y2LtwPMiNRA@mail.gmail.com>
Subject: Re: [PATCH v4] drm/amdgpu: deduplicate ring preempt ib function
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

Applied.  Thanks!

On Wed, Apr 29, 2026 at 9:19=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 4/29/26 01:19, Leonardo Cesar wrote:
> > The ring preemption function is identical for both gfx_v11_0 and
> > gfx_v12_0. This patch refactors the code by moving the core logic
> > into a generic function inside amdgpu_gfx.c to reduce code
> > duplication and simplify future maintenance.
> >
> > Signed-off-by: Leonardo Cesar <leonardocesar@usp.br>
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> >
> > ---
> > v3 -> v4:
> > - Dropped 'r' variable by reordering the return logic
> >
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | ...
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 52 +++++++++++++++++++++++++
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  2 +
> >  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 52 +------------------------
> >  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  | 52 +------------------------
> >  4 files changed, 56 insertions(+), 102 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_gfx.c
> > index 2956e45c9..f7ebead09 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > @@ -2684,3 +2684,55 @@ void amdgpu_debugfs_compute_sched_mask_init(stru=
ct amdgpu_device *adev)
> >  #endif
> >  }
> >
> > +int amdgpu_gfx_ring_preempt_ib(struct amdgpu_ring *ring)
> > +{
> > +     struct amdgpu_device *adev =3D ring->adev;
> > +     struct amdgpu_kiq *kiq =3D &adev->gfx.kiq[0];
> > +     struct amdgpu_ring *kiq_ring =3D &kiq->ring;
> > +     unsigned long flags;
> > +     int i;
> > +
> > +     if (adev->enable_mes)
> > +             return -EINVAL;
> > +
> > +     if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
> > +             return -EINVAL;
> > +
> > +     spin_lock_irqsave(&kiq->ring_lock, flags);
> > +
> > +     if (amdgpu_ring_alloc(kiq_ring, kiq->pmf->unmap_queues_size)) {
> > +             spin_unlock_irqrestore(&kiq->ring_lock, flags);
> > +             return -ENOMEM;
> > +     }
> > +
> > +     /* assert preemption condition */
> > +     amdgpu_ring_set_preempt_cond_exec(ring, false);
> > +
> > +     /* assert IB preemption, emit the trailing fence */
> > +     kiq->pmf->kiq_unmap_queues(kiq_ring, ring, PREEMPT_QUEUES_NO_UNMA=
P,
> > +                                     ring->trail_fence_gpu_addr,
> > +                                     ++ring->trail_seq);
> > +     amdgpu_ring_commit(kiq_ring);
> > +
> > +     spin_unlock_irqrestore(&kiq->ring_lock, flags);
> > +
> > +     /* poll the trailing fence */
> > +     for (i =3D 0; i < adev->usec_timeout; i++) {
> > +             if (ring->trail_seq =3D=3D
> > +                     le32_to_cpu(*(ring->trail_fence_cpu_addr)))
> > +                     break;
> > +             udelay(1);
> > +     }
> > +
> > +     /* deassert preemption condition */
> > +    amdgpu_ring_set_preempt_cond_exec(ring, true);
> > +
> > +     if (i >=3D adev->usec_timeout) {
> > +             DRM_ERROR("ring %d failed to preempt ib\n", ring->idx);
> > +             return -EINVAL;
> > +     }
> > +
> > +     return 0;
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
> >       switch (mode) {
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/a=
md/amdgpu/gfx_v11_0.c
> > index 5097de940..1ba848bfa 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> > @@ -6206,56 +6206,6 @@ static void gfx_v11_0_ring_emit_gfx_shadow(struc=
t amdgpu_ring *ring,
> >       ring->set_q_mode_offs =3D offs;
> >  }
> >
> > -static int gfx_v11_0_ring_preempt_ib(struct amdgpu_ring *ring)
> > -{
> > -     int i, r =3D 0;
> > -     struct amdgpu_device *adev =3D ring->adev;
> > -     struct amdgpu_kiq *kiq =3D &adev->gfx.kiq[0];
> > -     struct amdgpu_ring *kiq_ring =3D &kiq->ring;
> > -     unsigned long flags;
> > -
> > -     if (adev->enable_mes)
> > -             return -EINVAL;
> > -
> > -     if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
> > -             return -EINVAL;
> > -
> > -     spin_lock_irqsave(&kiq->ring_lock, flags);
> > -
> > -     if (amdgpu_ring_alloc(kiq_ring, kiq->pmf->unmap_queues_size)) {
> > -             spin_unlock_irqrestore(&kiq->ring_lock, flags);
> > -             return -ENOMEM;
> > -     }
> > -
> > -     /* assert preemption condition */
> > -     amdgpu_ring_set_preempt_cond_exec(ring, false);
> > -
> > -     /* assert IB preemption, emit the trailing fence */
> > -     kiq->pmf->kiq_unmap_queues(kiq_ring, ring, PREEMPT_QUEUES_NO_UNMA=
P,
> > -                                ring->trail_fence_gpu_addr,
> > -                                ++ring->trail_seq);
> > -     amdgpu_ring_commit(kiq_ring);
> > -
> > -     spin_unlock_irqrestore(&kiq->ring_lock, flags);
> > -
> > -     /* poll the trailing fence */
> > -     for (i =3D 0; i < adev->usec_timeout; i++) {
> > -             if (ring->trail_seq =3D=3D
> > -                 le32_to_cpu(*(ring->trail_fence_cpu_addr)))
> > -                     break;
> > -             udelay(1);
> > -     }
> > -
> > -     if (i >=3D adev->usec_timeout) {
> > -             r =3D -EINVAL;
> > -             DRM_ERROR("ring %d failed to preempt ib\n", ring->idx);
> > -     }
> > -
> > -     /* deassert preemption condition */
> > -     amdgpu_ring_set_preempt_cond_exec(ring, true);
> > -     return r;
> > -}
> > -
> >  static void gfx_v11_0_ring_emit_de_meta(struct amdgpu_ring *ring, bool=
 resume)
> >  {
> >       struct amdgpu_device *adev =3D ring->adev;
> > @@ -7295,7 +7245,7 @@ static const struct amdgpu_ring_funcs gfx_v11_0_r=
ing_funcs_gfx =3D {
> >       .emit_cntxcntl =3D gfx_v11_0_ring_emit_cntxcntl,
> >       .emit_gfx_shadow =3D gfx_v11_0_ring_emit_gfx_shadow,
> >       .init_cond_exec =3D gfx_v11_0_ring_emit_init_cond_exec,
> > -     .preempt_ib =3D gfx_v11_0_ring_preempt_ib,
> > +     .preempt_ib =3D amdgpu_gfx_ring_preempt_ib,
> >       .emit_frame_cntl =3D gfx_v11_0_ring_emit_frame_cntl,
> >       .emit_wreg =3D gfx_v11_0_ring_emit_wreg,
> >       .emit_reg_wait =3D gfx_v11_0_ring_emit_reg_wait,
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/a=
md/amdgpu/gfx_v12_0.c
> > index 65c33823a..6cf244349 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> > @@ -4611,56 +4611,6 @@ static unsigned gfx_v12_0_ring_emit_init_cond_ex=
ec(struct amdgpu_ring *ring,
> >       return ret;
> >  }
> >
> > -static int gfx_v12_0_ring_preempt_ib(struct amdgpu_ring *ring)
> > -{
> > -     int i, r =3D 0;
> > -     struct amdgpu_device *adev =3D ring->adev;
> > -     struct amdgpu_kiq *kiq =3D &adev->gfx.kiq[0];
> > -     struct amdgpu_ring *kiq_ring =3D &kiq->ring;
> > -     unsigned long flags;
> > -
> > -     if (adev->enable_mes)
> > -             return -EINVAL;
> > -
> > -     if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
> > -             return -EINVAL;
> > -
> > -     spin_lock_irqsave(&kiq->ring_lock, flags);
> > -
> > -     if (amdgpu_ring_alloc(kiq_ring, kiq->pmf->unmap_queues_size)) {
> > -             spin_unlock_irqrestore(&kiq->ring_lock, flags);
> > -             return -ENOMEM;
> > -     }
> > -
> > -     /* assert preemption condition */
> > -     amdgpu_ring_set_preempt_cond_exec(ring, false);
> > -
> > -     /* assert IB preemption, emit the trailing fence */
> > -     kiq->pmf->kiq_unmap_queues(kiq_ring, ring, PREEMPT_QUEUES_NO_UNMA=
P,
> > -                                ring->trail_fence_gpu_addr,
> > -                                ++ring->trail_seq);
> > -     amdgpu_ring_commit(kiq_ring);
> > -
> > -     spin_unlock_irqrestore(&kiq->ring_lock, flags);
> > -
> > -     /* poll the trailing fence */
> > -     for (i =3D 0; i < adev->usec_timeout; i++) {
> > -             if (ring->trail_seq =3D=3D
> > -                 le32_to_cpu(*(ring->trail_fence_cpu_addr)))
> > -                     break;
> > -             udelay(1);
> > -     }
> > -
> > -     if (i >=3D adev->usec_timeout) {
> > -             r =3D -EINVAL;
> > -             DRM_ERROR("ring %d failed to preempt ib\n", ring->idx);
> > -     }
> > -
> > -     /* deassert preemption condition */
> > -     amdgpu_ring_set_preempt_cond_exec(ring, true);
> > -     return r;
> > -}
> > -
> >  static void gfx_v12_0_ring_emit_rreg(struct amdgpu_ring *ring, uint32_=
t reg,
> >                                    uint32_t reg_val_offs)
> >  {
> > @@ -5539,7 +5489,7 @@ static const struct amdgpu_ring_funcs gfx_v12_0_r=
ing_funcs_gfx =3D {
> >       .pad_ib =3D amdgpu_ring_generic_pad_ib,
> >       .emit_cntxcntl =3D gfx_v12_0_ring_emit_cntxcntl,
> >       .init_cond_exec =3D gfx_v12_0_ring_emit_init_cond_exec,
> > -     .preempt_ib =3D gfx_v12_0_ring_preempt_ib,
> > +     .preempt_ib =3D amdgpu_gfx_ring_preempt_ib,
> >       .emit_wreg =3D gfx_v12_0_ring_emit_wreg,
> >       .emit_reg_wait =3D gfx_v12_0_ring_emit_reg_wait,
> >       .emit_reg_write_reg_wait =3D gfx_v12_0_ring_emit_reg_write_reg_wa=
it,
>
