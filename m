Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5EFECA600F
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 09:47:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DC0910FD51;
	Thu,  8 Oct 2026 09:47:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="c+zyNR4G";
	dkim-atps=neutral
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com
 [209.85.218.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3107B10FD4C
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 09:47:07 +0000 (UTC)
Received: by mail-ej1-f49.google.com with SMTP id
 a640c23a62f3a-c2533d83e3bso437162566b.2
 for <dri-devel@lists.freedesktop.org>; Thu, 08 Oct 2026 02:47:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791452825; cv=none;
 d=google.com; s=arc-20260327;
 b=jdmvV2qIBHVf2EOUBae+ForAiUMV3LM+lR3uM7Jw9W7Nxe71TkMyV8VGUt1YSK3Cf4
 LpgJamzocfTNUYusqDrzZILmMkBPRZeFTRctLBzICsLtIpYwSgSEq5BcdS60cU5pbaUn
 Rw1ntlo1UluS+sfhQL0xnclU28+HMI+RIRR3Ckox8qC2lE4N8RH2HJpxTHUFy5sA2uXi
 y4+LYBb3HoX6LIIL6a28nFjochaZL6Jf2CuMn8MPF+jvPm8RwI7f38N//MdJhI4vGk7D
 vKJppLZwmZE4BzZbII9YTAcq9re5tem+l8lo1hyarBxLKPyNkiu+Mkjei2p9vOWpP4hP
 ZJjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=pBG2CfwZvvXh2kkPTzl9pyAXNEnFVYX5W7gHYOSfvRM=;
 fh=085d7Rf3JaQc4/op4f+LFMWeMmKAekpxdOScdey2HY0=;
 b=VIJ3dfZutz6AkugLeDWKateYquiqFx+7APGS3k1Zrol0DPND90ib5/ZYcNZZRdNoOP
 yaFW3OrH3BFYK9iJcluHSom+x0WYm0exCRtY1AVxlptRIck7uJkqztKaFngC5yFrNBM5
 eLmH6ZggQDTqSamtHnbbX9WeqWXzW4PiOZk5B/2M9SOJFrD8OHNTK1Wqd1XtC2Wsug/8
 nWW1kLd2hKrnJhJw72GDkARGYWpMpUMh7pGp+S3uYd2uRgh3Hb6IDP6hY+UuMKHjrVS/
 3xiE3CG9Xxv2K/S2auKTswnrHorzl/dJDzNbQLMSMMU6mgUL5BnuTE+i7iaEPl2i+A7p
 450Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791452825; x=1792057625; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=pBG2CfwZvvXh2kkPTzl9pyAXNEnFVYX5W7gHYOSfvRM=;
 b=c+zyNR4GaIssXV7z+bRXJwTI3uWZcd6NqnNypG6Eryi3pyei9ah6EeQwFqz1NG+UzP
 8PRrUIPgBMehXBHNTR5ls1sD0fdMpyNM6KTD1jUxexIb0Gyq5+FT1JBNqXPZcC6mZmFC
 858pTYF0qyIsosP2MJEozEkuxOT9To8XSqk5BGeuR9PG0sVSJee+Th9aMs7xslC+k+h5
 zFQlDdNmG6j1etprSETgtHT/5iP2sYBPm+saH3L9bMcpqx/B6gs6yPRfkbXx6x9EbP1r
 tKPdxecJFRYZN1csqA89xCDX2MmQCinG6eZMEVJEgrKrV7W95UEvJfpaaahg8EymYOkm
 oqdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791452825; x=1792057625;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=pBG2CfwZvvXh2kkPTzl9pyAXNEnFVYX5W7gHYOSfvRM=;
 b=mvGX18cFajxQBJLo5DSgvjfC+Dy78ouX74aRVScGNR37BmRfotOxwRSHMNWSqhAuxa
 p5Jf3OZTCIClKybfYqsGt/VSTnXsbjUZHB0LD0NVAA9xK75egxrNTH+V2sRPxdhb6Ld+
 kIyMJX5BiBzkWgr3cAK/Hi54ca/tp2KpgixlbTsWvOoRSOpehWGpH6kb/nICZhUi8uz5
 avVYIaiWXSiEd50nxyFpaOLGmmuFp/zkL/Mx6RlPBYLVAH9lzT3xvASldo/oaj6snj0Y
 vglol9q0TXJzRWRFiIQe6NomwXjj0kdFZvPgnU5H4/OtJpQ9vJO6cKLj9FndB8UTnw/c
 pz6g==
X-Forwarded-Encrypted: i=1;
 AKwUvBzrRfU3qKv39+BS5c2ewl7DLwDJiRh6F3Xo03rw4VsqnCZ06+TVYU0w/VVChCX+N0Dk2SX/iSwFRfs=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nuPwHK5kks8liwiv6AL3ACG04jv2u3/VkcS62rca5qIbP/d7K9
 0DU1UyMdjvEAJK5UUVjTRphyAOaviAlnsswPgw50Bh9qDsksH99yK3HCzqs5x8VrgG7d02sAYrT
 7UWAt4LnXdzHS+jrCI8wX2N6AwYgVqQA=
X-Gm-Gg: AYBFou3qMjzretGQ4mwmg77zPG+DhBEOVrSpWCPaICTpx0BbJJwy1r4Vrm1tpQ5oFOD
 E1c3rvAzAdcnGhu6pOPlRH+2B18mRWYmGdSok+VUkK4vTlyXsqxgagBrmrsOVXcZnWVG8A0ULiD
 Bw7fckJwEklyvO8Bajsv9foM+HsVA8oT2PDQvSscCPF/KZaGRwtGim9HgoIkNHSs4LO4MLiSpZB
 5dOCkRUIoKNn1Qd7tnL/E7UO6chd+HJpC9EHDK73OiC3KmQ5uCNm7L0vd2fQLgTrWBBZBvv6S73
 viUXG/g9RLZVlI0GodLYad39djPArNLbc4pGcBGkAykeKQEv/Ua12w==
X-Received: by 2002:a17:907:3e20:b0:c2e:9034:138f with SMTP id
 a640c23a62f3a-c317c1787edmr504310366b.47.1791452825330; Thu, 08 Oct 2026
 02:47:05 -0700 (PDT)
MIME-Version: 1.0
References: <20261007200345.417281-1-jfisher84@gmail.com>
 <e14295dd-c78e-4604-ba38-5a03c8ffa7c4@amd.com>
In-Reply-To: <e14295dd-c78e-4604-ba38-5a03c8ffa7c4@amd.com>
From: John Fisher <jfisher84@gmail.com>
Date: Thu, 8 Oct 2026 22:46:51 +1300
X-Gm-Features: AclHuK_AjxFaQeg1twq6ZvT33J1CFW4b0jM4QIal_YB9ZXA4gSkmPYLd--SuBYg
Message-ID: <CAC7wNSAqWcaR=v7N+_Qe9SRPU8AAd0vjophDtkfnhRY4RhrXqA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: wait for pending page table updates before
 switching a VM to CPU updates
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
 dri-devel@lists.freedesktop.org, stable@vger.kernel.org, 
 Prike Liang <Prike.Liang@amd.com>
Content-Type: multipart/alternative; boundary="0000000000004928f7065d511dad"
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

--0000000000004928f7065d511dad
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ok understood. Uninterruptible with no return value check.

Which fence should it wait on, though?

The jobs that race here are the PD/PT clears from the render node's open,
and as far as I can see their fences only end up as BOOKKEEP fences on the
root PD:
amdgpu_vm_pt_clear() commits with a NULL fence, so they never reach
vm->last_update.
Nothing else sets vm->last_update between amdgpu_vm_init() and ACQUIRE_VM
either: amdgpu_seq64_map() goes through amdgpu_vm_bo_update(), which puts
its fence in bo_va->last_pt_update because the seq64 BO is not always
valid; amdgpu_map_static_csa() only maps; and the PDEs of the new tables
stay on vm->kernel.needs_update.
So at this point vm->last_update is still the stub, and a
dma_fence_wait(vm->last_update, false) here would not close the race.

I think maybe two other ways to wait for the VM's own updates:

   1. Have amdgpu_vm_pt_clear() commit with &vm->last_update instead of
   NULL, and dma_fence_wait(vm->last_update, false) here before it is dropp=
ed.
   The clears all go through vm->delayed, so the last one covers the earlie=
r
   ones.
   2. Keep the clears as they are and wait here only for the fences on the
   root PD whose owner is AMDGPU_FENCE_OWNER_VM (exporting
   amdgpu_sync_get_owner() or adding a small helper to amdgpu_sync.c).


Which would you prefer, or did you have something else in mind?

I'll send a v2 once I've rerun the tests on it.

Thanks,
John


On Thu, 8 Oct 2026 at 21:13, Christian K=C3=B6nig <christian.koenig@amd.com=
>
wrote:

> On 10/7/26 22:03, John Fisher wrote:
> > amdgpu_vm_make_compute() switches a VM from SDMA to CPU page table
> > updates when a KFD process acquires it. It syncs "with the last SDMA
> > update/clear" through amdgpu_bo_sync_wait() on the root PD, but that
> > walks the reservation with DMA_RESV_USAGE_READ, and the VM's own page
> > table jobs (the root clear from amdgpu_vm_init(), and the PD/PT clears
> > and the seq64 mapping from the render node's open) are added by
> > amdgpu_vm_sdma_commit() with DMA_RESV_USAGE_BOOKKEEP. The CPU path's ow=
n
> > waits (amdgpu_vm_cpu_update(), amdgpu_bo_kmap()) use
> > DMA_RESV_USAGE_KERNEL. None of them waits for a clear that is still
> > queued.
> >
> > When one is, the CPU writes the first entries of the new compute VM (th=
e
> > KFD trap handler's TBA/TMA page at AMDGPU_VA_RESERVED_TRAP_START, mappe=
d
> > during ACQUIRE_VM) into a page directory the SDMA then clears. The
> > entries are gone, the handler's page is unmapped, and the first wave
> > save of any queue of the process faults in the SQC instruction fetch at
> > the handler's address (GCVM_L2_PROTECTION_FAULT_STATUS 0x008012B1,
> > PERMISSION_FAULTS 0xb). The MES then fails REMOVE_QUEUE and SUSPEND, an=
d
> > the device takes a MODE1 reset with VRAM lost on 7.2.9; on 7.3-rc6 the
> > queue is reset instead.
> >
> > The window is the time between the render node's open and ACQUIRE_VM.
> > ROCr spends milliseconds there and is practically never hit; a minimal
> > KFD client that opens the render node and acquires the VM at once is hi=
t
> > most of the time. On a Radeon AI PRO R9700 (gfx1201, Resizable BAR, so
> > vm_update_mode defaults to CPU updates for compute VMs), a wave reading
> > the trap handler's page right after queue creation found it unmapped in
> > 8 of 12 runs; a 5 ms sleep between the open and ACQUIRE_VM made that 0
> > of 9, and the same sleep after queue creation instead 3 of 3.
> >
> > The wait covered these jobs until commit 926c79ad6ecd ("drm/amdgpu:
> > promote the implicit sync to the dependent read fences") narrowed
> > amdgpu_sync_resv() from DMA_RESV_USAGE_BOOKKEEP to DMA_RESV_USAGE_READ;
> > the VM's page table jobs have been added with BOOKKEEP since commit
> > 4247084057cf ("drm/amdgpu: use DMA_RESV_USAGE_BOOKKEEP v2"), so from
> > v6.16 on the sync in amdgpu_vm_make_compute() waits for nothing of
> > them.
> >
> > Wait for every fence on the root PD's reservation before switching the
> > update functions. With this the same client reads the handler 10 of 10
> > times, 8 busy queues on the 4 compute slots complete in 5 of 5 runs
> > (1 of 6 before), and two processes with 8 queues each complete together=
,
> > with no fault.
> >
> > Fixes: 926c79ad6ecd ("drm/amdgpu: promote the implicit sync to the
> dependent read fences")
> > Cc: stable@vger.kernel.org # v6.16+
> > Cc: Prike Liang <Prike.Liang@amd.com>
> > Signed-off-by: John Fisher <jfisher84@gmail.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 17 +++++++++++++----
> >  1 file changed, 13 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > index 29187fabc..8d0c03a40 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > @@ -2736,11 +2736,20 @@ int amdgpu_vm_make_compute(struct amdgpu_device
> *adev, struct amdgpu_vm *vm)
> >                   "CPU update of VM recommended only for large BAR
> system\n");
> >
> >         if (vm->use_cpu_for_update) {
> > -               /* Sync with last SDMA update/clear before switching to
> CPU */
> > -               r =3D amdgpu_bo_sync_wait(vm->root.bo,
> > -                                       AMDGPU_FENCE_OWNER_UNDEFINED,
> true);
> > -               if (r)
> > +               /*
> > +                * Sync with the last SDMA update/clear before switchin=
g
> to CPU
> > +                * updates. The VM's own page table updates are tracked
> with
> > +                * DMA_RESV_USAGE_BOOKKEEP on the root PD, which
> > +                * amdgpu_bo_sync_wait() does not wait for: a clear of =
a
> PD still
> > +                * pending here lands after the CPU has written its
> entries.
>
> That comment is a bit superfluous, it describes the what and not the why.
>
> Just keep the "Sync with last SDMA update/clear before switching to CPU"
> or maybe change to "Sync with the last async SDMA update".
>
> > +                */
> > +               long t =3D
> dma_resv_wait_timeout(vm->root.bo->tbo.base.resv,
> > +                                              DMA_RESV_USAGE_BOOKKEEP,
> true,
> > +                                              MAX_SCHEDULE_TIMEOUT);
>
> That is quite suboptimal, we don't want to wait for the BOOKKEEP fences
> here. And drop the return value checking and wait uninterruptible.
>
> Regards,
> Christian.
>
> > +               if (t < 0) {
> > +                       r =3D t;
> >                         goto unreserve_bo;
> > +               }
> >
> >                 vm->update_funcs =3D &amdgpu_vm_cpu_funcs;
> >                 r =3D amdgpu_vm_pt_map_tables(adev, vm);
> > --
> > 2.55.0
> >
>
>

--0000000000004928f7065d511dad
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Ok understood. Uninterruptible with no return value check.=
<br><br>Which fence should it wait on, though?<br><br>The jobs that race he=
re are the PD/PT clears from the render node&#39;s open, and as far as I ca=
n see their fences only end up as BOOKKEEP fences on the root PD:<br>amdgpu=
_vm_pt_clear() commits with a NULL fence, so they never reach vm-&gt;last_u=
pdate.<br>Nothing else sets vm-&gt;last_update between amdgpu_vm_init() and=
 ACQUIRE_VM either: amdgpu_seq64_map() goes through amdgpu_vm_bo_update(), =
which puts its fence in bo_va-&gt;last_pt_update because the seq64 BO is no=
t always valid; amdgpu_map_static_csa() only maps; and the PDEs of the new =
tables stay on vm-&gt;kernel.needs_update.<br>So at this point vm-&gt;last_=
update is still the stub, and a dma_fence_wait(vm-&gt;last_update, false) h=
ere would not close the race.<br><br>I think maybe two other ways to wait f=
or the VM&#39;s own updates:<br><div><ol><li>Have amdgpu_vm_pt_clear() comm=
it with &amp;vm-&gt;last_update instead of NULL, and dma_fence_wait(vm-&gt;=
last_update, false) here before it is dropped. The clears all go through vm=
-&gt;delayed, so the last one covers the earlier ones.</li><li>Keep the cle=
ars as they are and wait here only for the fences on the root PD whose owne=
r is AMDGPU_FENCE_OWNER_VM (exporting amdgpu_sync_get_owner() or adding a s=
mall helper to amdgpu_sync.c).</li></ol></div><br><div>Which would you pref=
er, or did you have something else in mind?</div><div><br></div>I&#39;ll se=
nd a v2 once I&#39;ve rerun the tests on it.<br><br>Thanks,<br>John<br><br>=
</div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr"=
 class=3D"gmail_attr">On Thu, 8 Oct 2026 at 21:13, Christian K=C3=B6nig &lt=
;<a href=3D"mailto:christian.koenig@amd.com">christian.koenig@amd.com</a>&g=
t; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On 10/=
7/26 22:03, John Fisher wrote:<br>
&gt; amdgpu_vm_make_compute() switches a VM from SDMA to CPU page table<br>
&gt; updates when a KFD process acquires it. It syncs &quot;with the last S=
DMA<br>
&gt; update/clear&quot; through amdgpu_bo_sync_wait() on the root PD, but t=
hat<br>
&gt; walks the reservation with DMA_RESV_USAGE_READ, and the VM&#39;s own p=
age<br>
&gt; table jobs (the root clear from amdgpu_vm_init(), and the PD/PT clears=
<br>
&gt; and the seq64 mapping from the render node&#39;s open) are added by<br=
>
&gt; amdgpu_vm_sdma_commit() with DMA_RESV_USAGE_BOOKKEEP. The CPU path&#39=
;s own<br>
&gt; waits (amdgpu_vm_cpu_update(), amdgpu_bo_kmap()) use<br>
&gt; DMA_RESV_USAGE_KERNEL. None of them waits for a clear that is still<br=
>
&gt; queued.<br>
&gt; <br>
&gt; When one is, the CPU writes the first entries of the new compute VM (t=
he<br>
&gt; KFD trap handler&#39;s TBA/TMA page at AMDGPU_VA_RESERVED_TRAP_START, =
mapped<br>
&gt; during ACQUIRE_VM) into a page directory the SDMA then clears. The<br>
&gt; entries are gone, the handler&#39;s page is unmapped, and the first wa=
ve<br>
&gt; save of any queue of the process faults in the SQC instruction fetch a=
t<br>
&gt; the handler&#39;s address (GCVM_L2_PROTECTION_FAULT_STATUS 0x008012B1,=
<br>
&gt; PERMISSION_FAULTS 0xb). The MES then fails REMOVE_QUEUE and SUSPEND, a=
nd<br>
&gt; the device takes a MODE1 reset with VRAM lost on 7.2.9; on 7.3-rc6 the=
<br>
&gt; queue is reset instead.<br>
&gt; <br>
&gt; The window is the time between the render node&#39;s open and ACQUIRE_=
VM.<br>
&gt; ROCr spends milliseconds there and is practically never hit; a minimal=
<br>
&gt; KFD client that opens the render node and acquires the VM at once is h=
it<br>
&gt; most of the time. On a Radeon AI PRO R9700 (gfx1201, Resizable BAR, so=
<br>
&gt; vm_update_mode defaults to CPU updates for compute VMs), a wave readin=
g<br>
&gt; the trap handler&#39;s page right after queue creation found it unmapp=
ed in<br>
&gt; 8 of 12 runs; a 5 ms sleep between the open and ACQUIRE_VM made that 0=
<br>
&gt; of 9, and the same sleep after queue creation instead 3 of 3.<br>
&gt; <br>
&gt; The wait covered these jobs until commit 926c79ad6ecd (&quot;drm/amdgp=
u:<br>
&gt; promote the implicit sync to the dependent read fences&quot;) narrowed=
<br>
&gt; amdgpu_sync_resv() from DMA_RESV_USAGE_BOOKKEEP to DMA_RESV_USAGE_READ=
;<br>
&gt; the VM&#39;s page table jobs have been added with BOOKKEEP since commi=
t<br>
&gt; 4247084057cf (&quot;drm/amdgpu: use DMA_RESV_USAGE_BOOKKEEP v2&quot;),=
 so from<br>
&gt; v6.16 on the sync in amdgpu_vm_make_compute() waits for nothing of<br>
&gt; them.<br>
&gt; <br>
&gt; Wait for every fence on the root PD&#39;s reservation before switching=
 the<br>
&gt; update functions. With this the same client reads the handler 10 of 10=
<br>
&gt; times, 8 busy queues on the 4 compute slots complete in 5 of 5 runs<br=
>
&gt; (1 of 6 before), and two processes with 8 queues each complete togethe=
r,<br>
&gt; with no fault.<br>
&gt; <br>
&gt; Fixes: 926c79ad6ecd (&quot;drm/amdgpu: promote the implicit sync to th=
e dependent read fences&quot;)<br>
&gt; Cc: <a href=3D"mailto:stable@vger.kernel.org" target=3D"_blank">stable=
@vger.kernel.org</a> # v6.16+<br>
&gt; Cc: Prike Liang &lt;<a href=3D"mailto:Prike.Liang@amd.com" target=3D"_=
blank">Prike.Liang@amd.com</a>&gt;<br>
&gt; Signed-off-by: John Fisher &lt;<a href=3D"mailto:jfisher84@gmail.com" =
target=3D"_blank">jfisher84@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 17 +++++++++++++----<br=
>
&gt;=C2=A0 1 file changed, 13 insertions(+), 4 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_vm.c<br>
&gt; index 29187fabc..8d0c03a40 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
&gt; @@ -2736,11 +2736,20 @@ int amdgpu_vm_make_compute(struct amdgpu_devic=
e *adev, struct amdgpu_vm *vm)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&q=
uot;CPU update of VM recommended only for large BAR system\n&quot;);<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (vm-&gt;use_cpu_for_update) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Sync with l=
ast SDMA update/clear before switching to CPU */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D amdgpu_b=
o_sync_wait(vm-&gt;<a href=3D"http://root.bo" rel=3D"noreferrer" target=3D"=
_blank">root.bo</a>,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AMDGP=
U_FENCE_OWNER_UNDEFINED, true);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (r)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Sync with t=
he last SDMA update/clear before switching to CPU<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * updates. Th=
e VM&#39;s own page table updates are tracked with<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * DMA_RESV_US=
AGE_BOOKKEEP on the root PD, which<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * amdgpu_bo_s=
ync_wait() does not wait for: a clear of a PD still<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * pending her=
e lands after the CPU has written its entries.<br>
<br>
That comment is a bit superfluous, it describes the what and not the why.<b=
r>
<br>
Just keep the &quot;Sync with last SDMA update/clear before switching to CP=
U&quot; or maybe change to &quot;Sync with the last async SDMA update&quot;=
.<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0long t =3D dma=
_resv_wait_timeout(vm-&gt;root.bo-&gt;tbo.base.resv,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 DMA_RESV_USAGE_BOOKKEEP, true,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 MAX_SCHEDULE_TIMEOUT);<br>
<br>
That is quite suboptimal, we don&#39;t want to wait for the BOOKKEEP fences=
 here. And drop the return value checking and wait uninterruptible.<br>
<br>
Regards,<br>
Christian.<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (t &lt; 0) =
{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0r =3D t;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0goto unreserve_bo;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vm-&gt;up=
date_funcs =3D &amp;amdgpu_vm_cpu_funcs;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D amd=
gpu_vm_pt_map_tables(adev, vm);<br>
&gt; --<br>
&gt; 2.55.0<br>
&gt; <br>
<br>
</blockquote></div>

--0000000000004928f7065d511dad--
