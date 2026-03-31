Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67EEB109B47A
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 14:39:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E0A810E910;
	Tue, 31 Mar 2026 14:39:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="f+KGRUk6";
	dkim-atps=neutral
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com
 [74.125.82.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DD5C10E95C
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 14:39:00 +0000 (UTC)
Received: by mail-dy1-f173.google.com with SMTP id
 5a478bee46e88-2bd801b40dbso410621eec.0
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 07:39:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774967939; cv=none;
 d=google.com; s=arc-20240605;
 b=KOf44AaMgQHogxJRhTCGq3zZntXaA2EHY0Zc34mPfntV8nxlxY26bW6fAGMpY2tyAe
 SACWvU8xmg3P3LlI8KKUra0aQ4NDBzBUGc0vfqE/7y412hl0rPaZih7sr9zPtCOqtX0z
 XqKz5Z86i5cLYPOteARLDLc9/gD/0Fc/DPbPjoDS67Xx+RQwHsVnB4nI57NouGi7ApBc
 7Z0BpUvWUiNo02GaUtxj+OPQJeVCZ9sn9LEPgR7mn5OINsqQC5Yt+DNwU+qU0U9x+RC2
 WKlSY0qn2n8qYBKWve0nEFKQxL4AYlzVhaGt1GCZOw0KrDbETNNwaSMbwVK/PpKWKles
 YNMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=o65bcTJODSw4Zi0qmE/uFJ8m6kOI2qoRoMdNBPsW6xg=;
 fh=nhy8HI9+bY9fvwHvgWzgFIHTtwGMNH1SUxCYhDsOoGY=;
 b=SKMhVwenQwphO2DBha9U2Ty4rY0P8gvETxzIaPvwJV5Mofi2JrdEoodZcaSgR0b5I/
 ByLwbv/m/rToJo34e132Th36BanoU9tcwWMpTfbmPNARMJExY5HJs8qa6V/rBgcUovqz
 n8LklQXHwcPGVvL2Oy9ww0GmIOqD3XlCraDXC2aCCZXbgEwWu92pb/hzPlKdXfN94Tpq
 kEO0wWjbBFZ138k3YpUEeulaPi11XwNw5KfaWNUYsiahNq6ABdqSy3Ab1uQ4ALp6xabh
 AoDIX71+wFvuxGI5QMVx7SIRq+nLFmwy2qkHAWESiow1UxVcL1kKplWFkzoMJNrcJ4XW
 IdaQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774967939; x=1775572739; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o65bcTJODSw4Zi0qmE/uFJ8m6kOI2qoRoMdNBPsW6xg=;
 b=f+KGRUk6/+XMJClNPtK0cdELKzrekGZHw7N1YDGrLCQiL7C2F7v4jZmH8mtEXZhq6/
 rF3kKP3219HeK9xrPvF0QB/xrl9qH4qGC5HVQI8go3TPqOqb3Vb2LFnY911Gx/Fvm7fo
 ztl7nOoDC0/T42L4KMtcE1iEvQjDWpMHa2Cvdn3cw1LenEuo+tMguC2UeKMx/9iodcpB
 IT4XlwQwLOmHFYOnHgzLBt1JppRm+TN71JaMtpjzDCRLNeD10sJH6M/AHZ1Ucb51OTY0
 xCXfAgivgNLesxE3zQT7RWqyejfrZ06cPC8n+v9bD3y8a2aTmX01Q8Pr6W97g2/6ejHl
 Q2Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774967939; x=1775572739;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=o65bcTJODSw4Zi0qmE/uFJ8m6kOI2qoRoMdNBPsW6xg=;
 b=CQGRmemsfOXUDHNhEUUdA9Nxp2yK48F6VjEeJNV8viQOPMuus4KS1LVYRxOnSJ5PZh
 Zh/X8zY3tXuT8IqOvpPnXqIpWlVjNs6P2tPDAMbf6oC+NG6E34kIbwsN0Q6t9dyguzJv
 iozYdbbELCGRFT0b93jEALiGeFrl0AZThHtsjGtmapOBRk7C98sEPJVyHR8lJX0Cu5jj
 6rsayS6iDMPmXSlHi5RrhlZQFre6hnkf9LTVVEhlJlE5slZ6U322DXeKedCWQSuIqGu7
 eOU/+e4FSJAak+86xebGxK39jPVgHkTOth88G4b5UStyiPEbdhG+Ct4mpulCEcyRZC+u
 AIQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWN+4VoUTjYTI6RBeCjxU2Mr3Vlzm+Lt2UbXPgXppWwJ2zTwQOUMv7vdQDvJ53zVZHYe+O/gdaAI8Q=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwZ7xrHNLe2UeUGs5UlyuFn/1MJDRXXChR2g3EUJpzOSolXKUmq
 k4nEKLZq39qyVwRfP+4V+luCuyDJjN4lN8sYgU4P653+NFyc+ktulYArK3B2J9MD/TphmWBdhgl
 FR4brCyysgACUswCWE9FqoJdsdWZ+lCc=
X-Gm-Gg: ATEYQzz+lFaLHAIfYrhCX87tN0RD1zxbQk9jsYw12dw1MyrXdDZMPJHcZhfN/zYQ5nF
 CcRQPMbIFHNKevxz7v8gm02KCLN3L9AVY9fAHevLQNtZHYaIBvHuYZil1axefiiAep5QDC1Uhav
 qttVvZRKd/oTOA28M7gvqFfutVy+wjjJv3H9iEqgv6CwsRoap0DBdw7m4voSfUhtkjJBalkpHc7
 Iev2XEcl+cgW3nX5RoE5H+/vm5XUIVNYHKWUxpuH9D/xDgvgGwcYUA0WtQhErZkeh7PlllBZixX
 wMnur9/ZDdd/44MRTgYbuEh7F8K8uhMbztAb+d+fsVPujO5YcdfdWA+qxtivhxLyRH2ofg==
X-Received: by 2002:a05:7022:48f:b0:128:d590:2947 with SMTP id
 a92af1059eb24-12ab28da1bamr4261874c88.4.1774967939156; Tue, 31 Mar 2026
 07:38:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260331142127.52796-1-mikhail.v.gavrilov@gmail.com>
 <845af7e1-3ca7-483b-a3b1-0840d9c98596@amd.com>
In-Reply-To: <845af7e1-3ca7-483b-a3b1-0840d9c98596@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 31 Mar 2026 10:38:47 -0400
X-Gm-Features: AQROBzCP4hgUobb8FSouN55pHu2w5WfheoFQp7RyRUobCzfUlEJJglP9scfcXHw
Message-ID: <CADnq5_M-iwCHKJ+cnU1TQSc-aGJC465dwzWGQkhaZoSPz7Wu5g@mail.gmail.com>
Subject: Re: [PATCH v7] drm/amdgpu: replace PASID IDR with XArray
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 lijo.lazar@amd.com, Eric Huang <jinhuieric.huang@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
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

Alex

On Tue, Mar 31, 2026 at 10:29=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
>
>
> On 3/31/26 16:21, Mikhail Gavrilov wrote:
> > Replace the PASID IDR + spinlock with XArray as noted in the TODO
> > left by commit dccd79bb1c7f ("drm/amdgpu: fix the idr allocation
> > flags").
> >
> > The IDR conversion still has an IRQ safety issue:
> > amdgpu_pasid_free() can be called from hardirq context via the fence
> > signal path, but amdgpu_pasid_idr_lock is taken with plain spin_lock()
> > in process context, creating a potential deadlock:
> >
> >      CPU0
> >      ----
> >      spin_lock(&amdgpu_pasid_idr_lock)   // process context, IRQs on
> >      <Interrupt>
> >        spin_lock(&amdgpu_pasid_idr_lock) // deadlock
> >
> >    The hardirq call chain is:
> >
> >      sdma_v6_0_process_trap_irq
> >       -> amdgpu_fence_process
> >        -> dma_fence_signal
> >         -> drm_sched_job_done
> >          -> dma_fence_signal
> >           -> amdgpu_pasid_free_cb
> >            -> amdgpu_pasid_free
> >
> > Use XArray with XA_FLAGS_LOCK_IRQ (all xa operations use IRQ-safe
> > locking internally) and XA_FLAGS_ALLOC1 (zero is not a valid PASID).
> > Both xa_alloc_cyclic() and xa_erase() then handle locking
> > consistently, fixing the IRQ safety issue and removing the need for
> > an explicit spinlock.
> >
> > Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
> > Fixes: e6d765de3d6b ("drm/amdgpu: prevent immediate PASID reuse case")
> > Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> > ---
> >
> > v7: Rebased on amd-staging-drm-next which already includes
> >     dccd79bb1c7f ("drm/amdgpu: fix the idr allocation flags").
> >     Updated commit message to reflect that sleeping-under-spinlock
> >     is already fixed and the xarray conversion now addresses the
> >     remaining IRQ safety issue.  Inverted error check to
> >     if (r < 0) return r; per Christian K=C3=B6nig.
> > v6: Use DEFINE_XARRAY_FLAGS with XA_FLAGS_LOCK_IRQ | XA_FLAGS_ALLOC1
> >     so all xa operations use IRQ-safe locking internally.  Drop
> >     Cc: stable since the regression was never released to any stable
> >     kernel. (Christian K=C3=B6nig)
> >     https://lore.kernel.org/all/20260331111733.118553-1-mikhail.v.gavri=
lov@gmail.com/
> > v5: Use explicit xa_lock_irqsave/__xa_erase for amdgpu_pasid_free()
> >     since xa_erase() only uses plain xa_lock() which is not safe from
> >     hardirq context.
> >     https://lore.kernel.org/all/20260330191120.105065-1-mikhail.v.gavri=
lov@gmail.com/
> > v4: Use xa_alloc_cyclic/xa_erase directly instead of explicit
> >     xa_lock_irqsave, as suggested by Lijo Lazar.
> >     https://lore.kernel.org/all/20260330162038.25073-1-mikhail.v.gavril=
ov@gmail.com/
> > v3: Replace IDR with XArray instead of fixing the spinlock, as
> >     suggested by Lijo Lazar.
> >     https://lore.kernel.org/all/20260330110346.16548-1-mikhail.v.gavril=
ov@gmail.com/
> > v2: Added second patch fixing the {HARDIRQ-ON-W} -> {IN-HARDIRQ-W}
> >     lock inconsistency (spin_lock -> spin_lock_irqsave).
> >     https://lore.kernel.org/all/20260330053025.19203-1-mikhail.v.gavril=
ov@gmail.com/
> > v1: Fixed sleeping-under-spinlock (idr_alloc_cyclic with GFP_KERNEL)
> >     using idr_preload/GFP_NOWAIT.
> >     https://lore.kernel.org/all/20260328213900.19255-1-mikhail.v.gavril=
ov@gmail.com/
> >
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 34 ++++++++++---------------
> >  1 file changed, 13 insertions(+), 21 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_ids.c
> > index e495a8fa13fd..a6ac3b4ce0df 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> > @@ -22,7 +22,7 @@
> >   */
> >  #include "amdgpu_ids.h"
> >
> > -#include <linux/idr.h>
> > +#include <linux/xarray.h>
> >  #include <linux/dma-fence-array.h>
> >
> >
> > @@ -40,8 +40,8 @@
> >   * VMs are looked up from the PASID per amdgpu_device.
> >   */
> >
> > -static DEFINE_IDR(amdgpu_pasid_idr);
> > -static DEFINE_SPINLOCK(amdgpu_pasid_idr_lock);
> > +static DEFINE_XARRAY_FLAGS(amdgpu_pasid_xa, XA_FLAGS_LOCK_IRQ | XA_FLA=
GS_ALLOC1);
> > +static u32 amdgpu_pasid_xa_next;
> >
> >  /* Helper to free pasid from a fence callback */
> >  struct amdgpu_pasid_cb {
> > @@ -62,22 +62,19 @@ struct amdgpu_pasid_cb {
> >   */
> >  int amdgpu_pasid_alloc(unsigned int bits)
> >  {
> > -     int pasid;
> > +     u32 pasid;
> > +     int r;
> >
> >       if (bits =3D=3D 0)
> >               return -EINVAL;
> >
> > -     spin_lock(&amdgpu_pasid_idr_lock);
> > -     /* TODO: Need to replace the idr with an xarry, and then
> > -      * handle the internal locking with ATOMIC safe paths.
> > -      */
> > -     pasid =3D idr_alloc_cyclic(&amdgpu_pasid_idr, NULL, 1,
> > -                              1U << bits, GFP_ATOMIC);
> > -     spin_unlock(&amdgpu_pasid_idr_lock);
> > -
> > -     if (pasid >=3D 0)
> > -             trace_amdgpu_pasid_allocated(pasid);
> > +     r =3D xa_alloc_cyclic(&amdgpu_pasid_xa, &pasid, xa_mk_value(0),
> > +                         XA_LIMIT(1, (1U << bits) - 1),
> > +                         &amdgpu_pasid_xa_next, GFP_KERNEL);
> > +     if (r < 0)
> > +             return r;
> >
> > +     trace_amdgpu_pasid_allocated(pasid);
> >       return pasid;
> >  }
> >
> > @@ -88,10 +85,7 @@ int amdgpu_pasid_alloc(unsigned int bits)
> >  void amdgpu_pasid_free(u32 pasid)
> >  {
> >       trace_amdgpu_pasid_freed(pasid);
> > -
> > -     spin_lock(&amdgpu_pasid_idr_lock);
> > -     idr_remove(&amdgpu_pasid_idr, pasid);
> > -     spin_unlock(&amdgpu_pasid_idr_lock);
> > +     xa_erase(&amdgpu_pasid_xa, pasid);
> >  }
> >
> >  static void amdgpu_pasid_free_cb(struct dma_fence *fence,
> > @@ -634,7 +628,5 @@ void amdgpu_vmid_mgr_fini(struct amdgpu_device *ade=
v)
> >   */
> >  void amdgpu_pasid_mgr_cleanup(void)
> >  {
> > -     spin_lock(&amdgpu_pasid_idr_lock);
> > -     idr_destroy(&amdgpu_pasid_idr);
> > -     spin_unlock(&amdgpu_pasid_idr_lock);
> > +     xa_destroy(&amdgpu_pasid_xa);
> >  }
>
