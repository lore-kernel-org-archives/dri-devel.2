Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35FE8CCA462
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 03:25:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78D5C10E2DF;
	Fri, 16 Oct 2026 03:25:46 +0000 (UTC)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com
 [209.85.208.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E63AE10E2DF
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 03:25:39 +0000 (UTC)
Received: by mail-ed1-f45.google.com with SMTP id
 4fb4d7f45d1cf-6af8620a7d2so7104778a12.0
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 20:25:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792121138; cv=none;
 d=google.com; s=arc-20260327;
 b=Lapcgr3JQh+8p4OvSUJcF4BiIz7PE7twtUkeLiPBlxzTxG9azDmZjdbQoBojn2UwfU
 TPWkxkPinPCnWP2kVsXeOAL0KviJgtx2YVSe5pCBvGNKnN+7CBciO2YYuzoFsPLJaX5b
 /R57ptTVu6jJGfBEIXHScdGKeylwRKktukbPcwnq1uwXW5xAd4ptFq+gPFdIHRY2txmi
 izKnewDoifenjSKkLWrToVw1yFMaJk/Jxk6EVTlITMOxdhcUg59NFHXKWqScG8Px01Kr
 kCBYdgMlKre5yudZwwtb9KCVlM/vS6Ulk3c5tNExacaZeS3mITzzhJgFImcAvAz1iAPc
 Ny2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=LBTssoM2mFnFxVDtlPbTRlVraone7Ifm/DBSAnH2w7Q=;
 fh=eqah1mMmaN/4BhWiPgoiV2tLCgxxLHM3MGi26Lro9FQ=;
 b=TuXooU0mBH2DZdB8epi7XCLCDaoFEqYX2xc5u8fkFMft4KX6jBz7fKb2fk8Tlx6hmz
 IYreJCxgLn4tbEj7hKGOq+KZKTWy3LRmTv8BqdSKeU1OduQe1gqXGtkDbaTlyngQr7qx
 +Ln8NTpwmJmRj1RRw+y1W/RgtZAKqlhkdNP+SniokEfB4XBCNOLFnU51Zc83Cy3NAzVJ
 CxayAgXkQ4BGca+2vaMti+ZFZqDM8t0q5gPG0P9iWKWfes7T6mEr863FqNSmD1AORKN/
 TcZ40ZRjSZVYdUmIEwv/lhCbPICkdKknIcKJ1DE6WlagfAIgzprWXsxdS2BxW8t0It+8
 fnVA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792121138; x=1792725938; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LBTssoM2mFnFxVDtlPbTRlVraone7Ifm/DBSAnH2w7Q=;
 b=c8ZKZslMZZF4CNAIAaqyLwhBI2P7k0NWru7QMQbH13qeKIbghoBMCxKj4dCBA8CI0E
 /9upD+TvKuaxCQb/n5melDVzHNyE8rx3DULwpHuyywXV1PxG+D5PF9JVTfNZDbDoVfEw
 Imevfh/OUr1LoZvIUkdwQJG1kcnLmkixJthDVTdRf5sR0aHKrqFdU1OCQkoVZa7Bc9sG
 wCVgSV2KBrauW1tJTUWbL4BrhOxgRFVuYkogWLF9MhtzP6EoFVH9+voDb2/hnMwm5n+u
 B25WETGIDrIAa0xwFsQZD33Rrx0wpr9cXoBcuwKIT5TK0W4v8M39YWFYtNl2BY59+wR/
 jZiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792121138; x=1792725938;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LBTssoM2mFnFxVDtlPbTRlVraone7Ifm/DBSAnH2w7Q=;
 b=bdIokSR3r/Q0pRpNwAHhVp5hPCywXP2AAxmNVJxLpMmGSheT77Y5JQvA3TkUg2HHLz
 eJe+mD9gd+RZ6NmtlcGpi/cCRvgdrI1SbsN6ClWxO8VpYsi0wnnAm0RP9C/E34jSQxGT
 gz8yCuSaMdujFKEKCwvOCCT7H+UhXv1rgjAbWHJfTw8aQAAHw5BrIoE8xOtgVYLp60NL
 YmhNOF2/0FZaNOG1gwF1cqFUJZgqJguaAStPTDUbaDjDuAqQWnxdwCaMwNKUxzmLYRqq
 7i2lswxFTDZBn9Pd1bDt/rs4uiKBgaajuGvo53yWSh5yG78Y9MDnZFsrBzHhNMSIpKvw
 EKxA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwhTGRhE2j3m3CPry//J6ZSiR+wooYjeCRwsMRhPRWIuHOLrnuSron3I6TkE3EH+E2ok/3d3pxnQVc=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJawKBIkE6SrzM5iw3MASfpbhbtio9GKeHVXcW1sxWWT+NnFDHY
 n5RibxHD3+sVbdd0SljuiUkusHO2ww5vGDuy4Rf1RUex5d93/LXhgFv/KnI9/PJpeeeUeEySmMJ
 n2ifSMraJ9dkOkeolSOPErhWVo+bMVIA=
X-Gm-Gg: AYBFou0GOUEcE65bk7eFkir9miyWNSxkx8s/Ejen21tmA1EST348mB5JdG3Q0ojMD43
 ZJ6ybv/MBLYNkn50rbNVclmykQ00F1A6bxjNzOnwaLeCSImO12GZWn+arsVOTclf2fFAKHsHzJ1
 Ea6gct2e9hz1fYvXrH5I3cjUY/DRCwba6Kxh3QxureWt2XQmFn5eNETIN5Jja4FZ9NEkvnBZdI9
 vOWaASHpRZhzlHm3jHI9Le+3K3KpOx5jV+RmvNJbJcRYVsJ7yyn2P/Gq7fbH82lX7FZ/VbKcS3P
 IrUslz++QlT9pep/kKTeXoCuBeEB/a+D1X8IFAluRYtkq0H2H1mphilKbdWim4HM
X-Received: by 2002:a05:6402:2788:b0:6aa:9866:551f with SMTP id
 4fb4d7f45d1cf-6b17c2d755cmr18289668a12.45.1792121137956; Thu, 15 Oct 2026
 20:25:37 -0700 (PDT)
MIME-Version: 1.0
References: <20261008204517.392180-1-jfisher84@gmail.com>
 <c64df6fa-6734-4c66-8f8b-52e5bd118cdb@amd.com>
In-Reply-To: <c64df6fa-6734-4c66-8f8b-52e5bd118cdb@amd.com>
From: John Fisher <jfisher84@gmail.com>
Date: Fri, 16 Oct 2026 16:25:26 +1300
X-Gm-Features: AclHuK8qA0Y5GArTBwCDOt3PjPocvVW2cHEUBULocqqscDY0UR0zbseYnJIw1eo
Message-ID: <CAC7wNSChWJ3nYY4GPT0Av+CDiudQ346hnxE_U0bfNLVvHdbozw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: wait for pending page table updates before
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

Thanks Christian. Since I don't have commit access, I assume that if
all looks good the commit will be passed on to be applied?

Thanks,
John

On Fri, 9 Oct 2026 at 20:00, Christian K=C3=B6nig <christian.koenig@amd.com=
> wrote:
>
> On 10/8/26 22:45, John Fisher wrote:
> > amdgpu_vm_make_compute() switches a VM from SDMA to CPU page table
> > updates when a KFD process acquires it. It syncs "with the last SDMA
> > update/clear" through amdgpu_bo_sync_wait() on the root PD, but that
> > walks the reservation with DMA_RESV_USAGE_READ, and the clears of the
> > VM's page tables (the root PD from amdgpu_vm_init(), and the PDs/PTs
> > the seq64 mapping allocates at the render node's open) are added there
> > by amdgpu_vm_sdma_commit() with DMA_RESV_USAGE_BOOKKEEP only:
> > amdgpu_vm_pt_clear() commits them with a NULL fence, so they do not
> > reach vm->last_update. The CPU path's own waits (amdgpu_vm_cpu_update()=
,
> > amdgpu_bo_kmap()) use DMA_RESV_USAGE_KERNEL. None of them waits for a
> > clear that is still queued.
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
> > Record the clears in vm->last_update, as amdgpu_vm_update_pdes() does
> > with its updates, and wait for it, uninterruptibly, before switching th=
e
> > update functions. The clears all go through vm->delayed, so the last on=
e
> > covers the earlier ones; immediate clears are not recorded, as before.
> >
> > With this, on 7.3-rc6 and on 7.2.9, the same client reads the handler
> > 10 of 10 times, 8 busy queues on the 4 compute slots complete in 5 of 5
> > runs on 7.3-rc6 and 3 of 3 on 7.2.9 (1 of 6 before), 16 and 32 queues
> > complete on 7.3-rc6, and two processes with 8 queues each complete
> > together on both, with no fault.
> >
> > Fixes: 926c79ad6ecd ("drm/amdgpu: promote the implicit sync to the depe=
ndent read fences")
> > Cc: stable@vger.kernel.org # v6.16+
> > Cc: Prike Liang <Prike.Liang@amd.com>
> > Signed-off-by: John Fisher <jfisher84@gmail.com>
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> > ---
> > v2: wait for vm->last_update, in which amdgpu_vm_pt_clear() now records
> >     the clears, instead of every BOOKKEEP fence on the root PD; wait
> >     uninterruptibly without checking the result; keep the original
> >     comment (Christian)
> > v1: https://lore.kernel.org/amd-gfx/20261007200345.417281-1-jfisher84@g=
mail.com/
> >
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 5 +----
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 2 +-
> >  2 files changed, 2 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_vm.c
> > index 29187fabc..757a037ed 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > @@ -2737,10 +2737,7 @@ int amdgpu_vm_make_compute(struct amdgpu_device =
*adev, struct amdgpu_vm *vm)
> >
> >       if (vm->use_cpu_for_update) {
> >               /* Sync with last SDMA update/clear before switching to C=
PU */
> > -             r =3D amdgpu_bo_sync_wait(vm->root.bo,
> > -                                     AMDGPU_FENCE_OWNER_UNDEFINED, tru=
e);
> > -             if (r)
> > -                     goto unreserve_bo;
> > +             dma_fence_wait(vm->last_update, false);
> >
> >               vm->update_funcs =3D &amdgpu_vm_cpu_funcs;
> >               r =3D amdgpu_vm_pt_map_tables(adev, vm);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_vm_pt.c
> > index c03327f12..cdbc2e931 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> > @@ -427,7 +427,7 @@ int amdgpu_vm_pt_clear(struct amdgpu_device *adev, =
struct amdgpu_vm *vm,
> >       if (r)
> >               goto exit;
> >
> > -     r =3D vm->update_funcs->commit(&params, NULL);
> > +     r =3D vm->update_funcs->commit(&params, &vm->last_update);
> >  exit:
> >       drm_dev_exit(idx);
> >       return r;
>
