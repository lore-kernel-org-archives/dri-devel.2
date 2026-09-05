Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 670A8C624D6
	for <dri-devel@archiver.kernel.org>; Sat,  5 Sep 2026 15:18:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CA5510E296;
	Sat,  5 Sep 2026 15:18:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bGLR/DLR";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A527C10E296
 for <dri-devel@lists.freedesktop.org>; Sat,  5 Sep 2026 15:18:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6F1104035C;
 Sat,  5 Sep 2026 15:18:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BE7F1F00A3A;
 Sat,  5 Sep 2026 15:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788621495;
 bh=CXDkAKuI8b7rEnUJtpmcxdxY6681Dc071+frf7b2wX8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bGLR/DLRPUAgY4n/ImgwVaBAct7Uw8lzctpIgyhnnHZLUUcVTt39wEVeZCvYI4Btm
 9t23npMTV4I3tyt3fskQUR6DkXqBEfmq9MHdZPCf90Fkpc9kqcoUxqy7jM9RsxgRIM
 newJeD2Ukt/OOxnqfHUm11VYPzZJ+ffPyxSzldRWu8QG/5JAloDDlz1hF6yGmeiQ4X
 ZUVyTfdCLX9o7hHVJMdG4i2aaAT8ZzoCc8WJSU7jHDS9ivPIzP/IwCFFFZWj30lQK2
 y8Usa4Dh31agcyhd2NwX3U+lrYASZayrRYiQjWSY7vn+Wgetudj+ELIuAZsZVtfsCI
 2u9lxipWEjFpg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] accel/rocket: search every core slot when looking up a
 scheduler
To: "Igor Paunovic" <royalnet026@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260905150432.7477-1-royalnet026@gmail.com>
References: <20260905150432.7477-1-royalnet026@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 15:18:14 +0000
Message-Id: <20260905151815.3BE7F1F00A3A@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 9 potential issue(=
s) to consider:

New issues:
- [Critical] The patch introduces a compilation failure by referencing an u=
ndefined struct member `max_cores` in `struct rocket_device`.

Pre-existing issues:
- [Critical] Decrementing `rdev->num_cores` on core removal without array c=
ompaction corrupts core tracking, leading to dropped active cores, array ov=
erwrites on re-probe, and use-after-free.
- [Critical] Use-after-free of GPU scheduler because reset work is cancelle=
d after scheduler teardown.
- [High] Unbinding a core leaves active clients with dangling scheduler ent=
ities, causing jobs to hang forever.
- [High] Missing NULL check for the `scheds` array allocation in `rocket_jo=
b_open`.
- [High] Incorrect teardown ordering in `rocket_core_fini` drops IOMMU and =
PM runtime states while the DRM scheduler and hardware are still active.
- [High] The IOVA allocator allocates up to 40 bits, but the hardware regis=
ter and UAPI strictly support 32-bit addresses for command buffers.
- [High] The shared IRQ handler reads a hardware register without verifying=
 that the device power domain and clocks are enabled.
- [High] The IRQ handler leaks a reference to the IOMMU group on every comp=
leted job.
--

commit 7e2bfdb7bd20f1e79747c6f4d972e6308a291eb7
Author: Igor Paunovic <royalnet026@gmail.com>

accel/rocket: search every core slot when looking up a scheduler

This patch attempts to fix a bug where sched_to_core() fails to find a core
after intermediate cores are unbound. It changes the iteration bound to
search all allocated core slots instead of just up to num_cores.

Closes: https://lore.kernel.org/dri-devel/apwUewaRnoTNXHCt@rock-5b-plus/

> diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/roc=
ket_job.c
> index 3141f210fcd1b..a6c24dfe0563a 100644
> --- a/drivers/accel/rocket/rocket_job.c
> +++ b/drivers/accel/rocket/rocket_job.c
> @@ -283,7 +283,7 @@ static struct rocket_core *sched_to_core(struct rocke=
t_device *rdev,
>  {
>  	unsigned int core;
> =20
> -	for (core =3D 0; core < rdev->num_cores; core++) {
> +	for (core =3D 0; core < rdev->max_cores; core++) {

[Severity: Critical]
Does struct rocket_device actually contain the max_cores field? The commit
message mentions this approach, but I can't find max_cores defined in struct
rocket_device. Will this cause a build failure here?

>  		if (&rdev->cores[core].sched =3D=3D sched)
>  			return &rdev->cores[core];
>  	}

[Severity: Critical]
This isn't a bug introduced by this patch, but when a core is removed in
rocket_remove():

drivers/accel/rocket/rocket_drv.c:rocket_remove() {
    ...
    rdev->num_cores--;
    ...
}

The active core count is decremented blindly without shifting the remaining
active cores into the resulting gap. Does this corrupt the core tracking,
leaving surviving active cores orphaned and vulnerable to being overwritten
if rocket_probe() reuses the shrunk num_cores as an index?

[Severity: High]
This is a pre-existing issue, but rocket_core_fini() initiates the teardown
of the drm scheduler:

drivers/accel/rocket/rocket_core.c:rocket_core_fini() {
    ...
    rocket_job_fini(core);
    ...
}

However, the client retains the scheduler entity pointing to this destroyed
scheduler from when it was initialized:

drivers/accel/rocket/rocket_job.c:rocket_job_open() {
    ...
    ret =3D drm_sched_entity_init(&rocket_priv->sched_entity,
                                DRM_SCHED_PRIORITY_NORMAL,
                                scheds,
                                rdev->num_cores, NULL);
    ...
}

If a client keeps the DRM file descriptor open while a core is unbound and
submits a job, will those jobs permanently hang waiting for the destroyed
scheduler?

[Severity: High]
This isn't a bug introduced by this patch, but rocket_job_open() allocates
the scheds array:

drivers/accel/rocket/rocket_job.c:rocket_job_open() {
    ...
    struct drm_gpu_scheduler **scheds =3D kmalloc_objs(*scheds,
                                                     rdev->num_cores);
    unsigned int core;
    int ret;
   =20
    for (core =3D 0; core < rdev->num_cores; core++)
        scheds[core] =3D &rdev->cores[core].sched;
    ...
}

If the allocation fails under memory pressure and returns NULL, won't the
immediate loop dereference lead to a kernel oops?

[Severity: Critical]
This is a pre-existing issue, but when cleaning up a job:

drivers/accel/rocket/rocket_job.c:rocket_job_fini() {
    ...
    drm_sched_fini(&core->sched);
   =20
    cancel_work_sync(&core->reset.work);
    ...
}

The scheduler is destroyed before its associated asynchronous reset work is
cancelled. If a job times out concurrently and the reset work executes,
could it result in a use-after-free when attempting to operate on the
already freed scheduler?

[Severity: High]
This is a pre-existing issue, but rocket_core_fini() drops IOMMU and PM
runtime states early:

drivers/accel/rocket/rocket_core.c:rocket_core_fini() {
    ...
    pm_runtime_disable(core->dev);
    iommu_group_put(core->iommu_group);
    core->iommu_group =3D NULL;
    rocket_job_fini(core);
    ...
}

Since rocket_job_fini() waits on or cancels the DRM scheduler, does
releasing the IOMMU group and disabling PM runtime beforehand leave active
hardware DMAing into unmapped memory or accessing disabled PM resources?

[Severity: High]
This isn't a bug introduced by this patch, but rocket_ioctl_create_bo()
allocates up to a 40-bit IOVA:

drivers/accel/rocket/rocket_gem.c:rocket_ioctl_create_bo() {
    ...
    args->dma_address =3D rkt_obj->mm.start;
    ...
}

Which is later written back to the NPU's hardware register via the 32-bit
regcmd field:

drivers/accel/rocket/rocket_job.c:rocket_job_hw_submit() {
    ...
    rocket_pc_writel(core, BASE_ADDRESS, task->regcmd);
    ...
}

If the buffer IOVA allocation exceeds the 4GB boundary, does this result in
silent address truncation and subsequent IOMMU faults when the hardware
accesses unintended physical memory?

[Severity: High]
This isn't a bug introduced by this patch, but the shared IRQ handler reads
a hardware register unconditionally:

drivers/accel/rocket/rocket_job.c:rocket_job_irq_handler() {
    ...
    u32 raw_status =3D rocket_pc_readl(core, INTERRUPT_RAW_STATUS);
    ...
}

If another device sharing the same IRQF_SHARED interrupt line fires while
the NPU is idle and runtime-suspended, will reading this register without
verifying the device power domain cause a synchronous external abort?

[Severity: High]
This is a pre-existing issue, but the IRQ handler gets an IOMMU group
reference:

drivers/accel/rocket/rocket_job.c:rocket_job_handle_irq() {
    ...
    iommu_detach_group(NULL, iommu_group_get(core->dev));
    ...
}

Since iommu_group_put() is never called to balance this, does this leak a
reference to the IOMMU group every time an in-flight job completes?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260905150432.7477=
-1-royalnet026@gmail.com?part=3D1
