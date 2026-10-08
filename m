Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DCFDCA6007
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 09:49:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5A0710FD5A;
	Thu,  8 Oct 2026 09:49:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="W4hPOrB1";
	dkim-atps=neutral
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com
 [209.85.208.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBE3710FD5C
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 09:49:30 +0000 (UTC)
Received: by mail-ed1-f43.google.com with SMTP id
 4fb4d7f45d1cf-6af9cc73235so1001539a12.0
 for <dri-devel@lists.freedesktop.org>; Thu, 08 Oct 2026 02:49:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791452969; cv=none;
 d=google.com; s=arc-20260327;
 b=ZRocslURjyzy5R77qXA8PeH0er/Nwkx3SPNJ4FSalsPicdlBwNKj4sBeWIg3CnBe9g
 xOu7NxcW+U7GaiJsU+jN4KvMdylY06YYOtpKcTJljK7iOipYCzJHmdI112nOLES0+scR
 /t2zUTonufbKzYQo9fwWwE1b6Ag+Hx2xnMlvrAkh48xIETOi9DnHb87LBa09/EPO+FQm
 DCul3QEA8cx3W0xvPdpQf+IYY9HoBGGELHrvH9bDL4oi6Blo/0Wo6fgiB2g11etAe+ra
 ZYaIlgy/tqgy3yL0mGCQfQpM/idpwWroMCoe3wa8Q3Wf0iIE0oVZ7mFmV3YsAzyJMQbp
 /NoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=kFul20M1kAj6OL6A2UXelET2OX/eEgeEYys9+x/QKks=;
 fh=jvOzHlSYhtt7QyuafF85i4RFvJI6oBKwv4wGMARTW58=;
 b=Nq2QTExcR0Zdnxy/sm0fYFhE0vAvsMlyzjpu1TwcHS4x0xAYKRFrk+AWzNMalEf2NF
 wMnDwdBEvzysj+zzzKaNbYn4oT/4QP2L8EKH5spDOHSg3V1VzHsE1fZ/BbqtAfB33bwH
 wkGC+rYfvbQ0maXA5hDBFXLOjBt7XrE1H7OQFRGgxNTfpvoLQjaZPDFK4nP7tfAm7vIC
 wmVn1Bms9CC2kYn6g355qHbz1CIFcJZ9pL38zoGza5rYgy4BkA3zerFfasEIBglNWOp+
 Q4sK63H8fP6eucd/R7rCdwGa20r4Qdgicq7EJK5CBi/7O1XrIZ/ep1K4SHcbcLcCejaa
 eAFQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791452969; x=1792057769; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kFul20M1kAj6OL6A2UXelET2OX/eEgeEYys9+x/QKks=;
 b=W4hPOrB17yiREqsP5JTQ2cvzil0QMlH7vcEOnwbFMqhCpW1uBMsqOKupKUg6jAvvUW
 QHCSk99PB0Ej9A8Cz30We4VQ24ui6CBaSE6qv4wB0sgRDv3Srf5ZxCNTMlw7olan6Pa+
 g6a58y6XvLSiYBHY1TSaAac/dZdIdpS5pJIzqCjjvkDzyhTydi7zBDQJbEeL4vxCMuUb
 OGM79LB6DUqlJDBRd2pvhkZsEpRVkkhoI24SMFk7dtfEnuApNyt9iNJUoQF1EgTHQzmE
 JQrpQKyUB4Q5cX9kYSGFhmXGiIBRoGcfsFCZMVC3p18Y16uasClWwqmPOTZFdrnhLV9n
 4QHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791452969; x=1792057769;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kFul20M1kAj6OL6A2UXelET2OX/eEgeEYys9+x/QKks=;
 b=PN2b6aC0vfnWFO9ljmkOtikpxRxEbIe56v/Y62zwn/cX2UUBNfa6g7lIm5WnnZETa7
 AWYQqS4QleroZIAD1mKxr3yqzNPmFQRMn50Ku2TtIfvsSlwJEGamzfdRlULSk0UGD1yP
 ZDp3Y4oHQ3oXtkw4Zr0R9c8tnccctAs/X4fdHOJC3BtQx2AfAozK+XuzMeARCfm1IhOl
 y0EiUFaBfzVBZpDoTuEsoLfsal2oFG1aNjhOMvLzI616U8py0mBVfQrDyqNVTo1fM5s2
 s+uyQ3gaC6lKx+rjzjtQe6AjrN5iR0+NXa4Ii+ciQ4NH7B+AHVLrLYHkj0P/JDtVxeOI
 WHUQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwFBwUtn263I+AEZmn+BFfvvRpk6LpCiJIwkbrV/M8aEuSgEdmLf4hHMzFsCPfk9Y7OmXcar6R8qP8=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nKfXe1tNzx1tHVMRH9m56GTnZ4DM9BEk/OTuQXiDjMSmCsstcg
 pZZ+zDVMAHd4AdbsuiIMa7mkmC6UlkUuTmHTCplJlUzbnUwOmmy4cH48dGIJrGi2UAcFfQ9o31A
 v7+Ffc0DYq6MtVDHnvDE4FiRqTVu79A4=
X-Gm-Gg: AYBFou2GTj9mf9t82un0M1yOBYxw3KardDyOVqiTkZ72t/+nxuNvLt4awXI8PiD2+ih
 Y7xdOGTDqyveLtCn5XpnNM201x8X+/xfYhslZXXrEqJdlasXpsXEus78EbOa8aLyEWomgsMA/GX
 QTdOT2w6rJnMDMXWaAwXA5cmaQY6oYP1zMgCYY5xkLFAUWwEU0NL53+tqJqjJFxowOGCM4wSszV
 sWXbUWWhwNygDhQViQx0qyU0LlXIRqf5nkNeXzvj91ny9oGW6KIvvbWSa1HOYA72t0T3x/TmmOu
 oVRCfVNp1yPZaaq063U8rHPdVqa9qtRKkkYX+Dpu5RVXcPe2tVHkxw==
X-Received: by 2002:a17:907:7245:b0:c25:f7dc:2dc with SMTP id
 a640c23a62f3a-c3191dec364mr163121366b.29.1791452968781; Thu, 08 Oct 2026
 02:49:28 -0700 (PDT)
MIME-Version: 1.0
References: <20261007200345.417281-1-jfisher84@gmail.com>
 <e14295dd-c78e-4604-ba38-5a03c8ffa7c4@amd.com>
In-Reply-To: <e14295dd-c78e-4604-ba38-5a03c8ffa7c4@amd.com>
From: John Fisher <jfisher84@gmail.com>
Date: Thu, 8 Oct 2026 22:49:17 +1300
X-Gm-Features: AclHuK-uPsqmYPJBD7A5pjJcEwjLsuclLYCy70EmQi7g3sP-Mv8C_pd3-bIpL0E
Message-ID: <CAC7wNSAWKwwkKat=rGpVQPXMdp7vLERs8X7wE=LdmBX1bL8O4Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: wait for pending page table updates before
 switching a VM to CPU updates
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
 dri-devel@lists.freedesktop.org, stable@vger.kernel.org, 
 Prike Liang <Prike.Liang@amd.com>
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

Ok understood. Uninterruptible with no return value check.

Which fence should it wait on, though?

The jobs that race here are the PD/PT clears from the render node's
open, and as far as I can see their fences only end up as BOOKKEEP
fences on the root PD:
amdgpu_vm_pt_clear() commits with a NULL fence, so they never reach
vm->last_update.
Nothing else sets vm->last_update between amdgpu_vm_init() and
ACQUIRE_VM either: amdgpu_seq64_map() goes through
amdgpu_vm_bo_update(), which puts its fence in bo_va->last_pt_update
because the seq64 BO is not always valid; amdgpu_map_static_csa() only
maps; and the PDEs of the new tables stay on vm->kernel.needs_update.
So at this point vm->last_update is still the stub, and a
dma_fence_wait(vm->last_update, false) here would not close the race.

I think maybe two other ways to wait for the VM's own updates:

1. Have amdgpu_vm_pt_clear() commit with &vm->last_update instead of
NULL, and dma_fence_wait(vm->last_update, false) here before it is
dropped. The clears all go through vm->delayed, so the last one covers
the earlier ones.
2. Keep the clears as they are and wait here only for the fences on
the root PD whose owner is AMDGPU_FENCE_OWNER_VM (exporting
amdgpu_sync_get_owner() or adding a small helper to amdgpu_sync.c).


Which would you prefer, or did you have something else in mind?

I'll send a v2 once I've rerun the tests on it.

Thanks,
John


On Thu, 8 Oct 2026 at 21:13, Christian K=C3=B6nig <christian.koenig@amd.com=
> wrote:
>
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
> > Fixes: 926c79ad6ecd ("drm/amdgpu: promote the implicit sync to the depe=
ndent read fences")
> > Cc: stable@vger.kernel.org # v6.16+
> > Cc: Prike Liang <Prike.Liang@amd.com>
> > Signed-off-by: John Fisher <jfisher84@gmail.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 17 +++++++++++++----
> >  1 file changed, 13 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_vm.c
> > index 29187fabc..8d0c03a40 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > @@ -2736,11 +2736,20 @@ int amdgpu_vm_make_compute(struct amdgpu_device=
 *adev, struct amdgpu_vm *vm)
> >                   "CPU update of VM recommended only for large BAR syst=
em\n");
> >
> >         if (vm->use_cpu_for_update) {
> > -               /* Sync with last SDMA update/clear before switching to=
 CPU */
> > -               r =3D amdgpu_bo_sync_wait(vm->root.bo,
> > -                                       AMDGPU_FENCE_OWNER_UNDEFINED, t=
rue);
> > -               if (r)
> > +               /*
> > +                * Sync with the last SDMA update/clear before switchin=
g to CPU
> > +                * updates. The VM's own page table updates are tracked=
 with
> > +                * DMA_RESV_USAGE_BOOKKEEP on the root PD, which
> > +                * amdgpu_bo_sync_wait() does not wait for: a clear of =
a PD still
> > +                * pending here lands after the CPU has written its ent=
ries.
>
> That comment is a bit superfluous, it describes the what and not the why.
>
> Just keep the "Sync with last SDMA update/clear before switching to CPU" =
or maybe change to "Sync with the last async SDMA update".
>
> > +                */
> > +               long t =3D dma_resv_wait_timeout(vm->root.bo->tbo.base.=
resv,
> > +                                              DMA_RESV_USAGE_BOOKKEEP,=
 true,
> > +                                              MAX_SCHEDULE_TIMEOUT);
>
> That is quite suboptimal, we don't want to wait for the BOOKKEEP fences h=
ere. And drop the return value checking and wait uninterruptible.
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
