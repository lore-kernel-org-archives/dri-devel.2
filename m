Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29392C5CFC1
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 03:33:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41EF510E51B;
	Fri, 14 Aug 2026 03:33:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Av6lvXYs";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62DBA10E51B
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 03:33:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 864B5600AD;
 Fri, 14 Aug 2026 03:33:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 143E31F000E9;
 Fri, 14 Aug 2026 03:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786678402;
 bh=UMgJ7WlbhignHnMbpuTICj5ilpmNDL7WX+wJKfCe6/s=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Av6lvXYskpxG+L5uV7ULRlOpJyvJ8FghIqP+FNWsXAwcRXYher4mz9SPcFHH0NkSL
 jXxHp2+6VRW+YVLaZyIlyTBtY5LplRyUsKo2WP2QbMBEcQUOuHlNe5bHsTE2oCnXNx
 bc7dpQsAc2ZtEVABODcEuhKUOU9HhAoXE1zDiVnK5zcLZXcSqUkeuSwWVP6mBG/ZrU
 BEwDWjtN8M/+X83pKI7rHEib0v82NH+p3U8N3iA1ujWdh5APsGqg8Tv9+vzOPd2SPA
 mw9nBU2r7tUtHZ+EM0XXn8/GQoP3vgVkn6D7EFUdzeuwjN20ph9Vd+b7gLMxLyrwEB
 z+cR6CO0wt7ZQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] accel/rocket: Fix the extra iommu_group_get call in
 rocket_job_handle_irq
To: "Chaoyi Chen" <kernel@airkyi.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260814022453.437-4-kernel@airkyi.com>
References: <20260814022453.437-1-kernel@airkyi.com>
 <20260814022453.437-4-kernel@airkyi.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 03:33:21 +0000
Message-Id: <20260814033322.143E31F000E9@smtp.kernel.org>
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
- [High] The patch introduces a guaranteed NULL pointer dereference in the =
interrupt handler during device teardown by caching the IOMMU group pointer.

Pre-existing issues:
- [High] The shared IRQ handler accesses hardware registers on a potentiall=
y suspended device and lacks `synchronize_irq()` in the runtime suspend pat=
h.
- [High] The device can be left permanently powered on with clocks enabled =
indefinitely after driver removal if an asynchronous suspend is cancelled.
- [High] Unsafe teardown ordering allows the timeout reset work to derefere=
nce a freed or NULL IOMMU group.
- [High] The driver does not verify that an IOMMU group was successfully re=
trieved during initialization, leading to crashes if no IOMMU is present.
- [High] The shared IRQ handler is managed by devres but the resources it d=
epends on are destroyed manually in `rocket_job_fini`, leading to a Use-Aft=
er-Free.
- [High] Hardware state (`OPERATION_ENABLE`) is modified outside `core->job=
_lock` in the threaded IRQ handler, creating a critical TOCTOU race conditi=
on.
- [Medium] Timeout reset logic uses `pm_runtime_put_noidle()`, which can pr=
event the device from entering a suspended state indefinitely.
- [Medium] Memory leak of the dynamically allocated `scheds` array in `rock=
et_job_open` on the error path.
--

--- Patch [3]: [PATCH 3/4] accel/rocket: Fix the extra iommu_group_get call=
 in rocket_job_handle_irq ---
commit a3d6f36e63b3077307646b0545b3207616881be9
Author: Chaoyi Chen <chaoyi.chen@rock-chips.com>

accel/rocket: Fix the extra iommu_group_get call in rocket_job_handle_irq

This commit removes an extra iommu_group_get() call in rocket_job_handle_ir=
q()
that caused a reference count leak. It replaces the call with the cached
core->iommu_group pointer to ensure the IOMMU group can be released properly
during teardown.

> diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/roc=
ket_job.c
> index 3141f210fcd1b..0fc4d220c48ce 100644
> --- a/drivers/accel/rocket/rocket_job.c
> +++ b/drivers/accel/rocket/rocket_job.c
> @@ -355,7 +355,7 @@ static void rocket_job_handle_irq(struct rocket_core =
*core)
>  				return;
>  			}
> =20
> -			iommu_detach_group(NULL, iommu_group_get(core->dev));
> +			iommu_detach_group(NULL, core->iommu_group);

[Severity: High]
Does this introduce a NULL pointer dereference during driver removal?

During driver removal, rocket_core_fini() explicitly sets core->iommu_group
to NULL before the DRM scheduler and devres-managed IRQ handler are stopped.
If an in-flight job completes or a delayed IRQ thread runs in this window,
rocket_job_handle_irq() will pass the NULL core->iommu_group to
iommu_detach_group(), which dereferences it unconditionally and causes a
kernel panic.

>  			dma_fence_signal(core->in_flight_job->done_fence);
>  			pm_runtime_put_autosuspend(core->dev);
>  			core->in_flight_job =3D NULL;

[Severity: High]
This is a pre-existing issue, but does the shared IRQ handler access hardwa=
re
registers on a potentially suspended device?

If a shared interrupt is triggered by another device while the NPU is
runtime-suspended, the driver will directly read INTERRUPT_RAW_STATUS witho=
ut
verifying if the device is active:

drivers/accel/rocket/rocket_job.c:rocket_job_irq_handler() {
    ...
    u32 raw_status =3D rocket_pc_readl(core, INTERRUPT_RAW_STATUS);
    ...
}

Accessing unclocked hardware registers can cause a bus fault. Additionally,
rocket_device_runtime_suspend() disables clocks without calling
synchronize_irq():

drivers/accel/rocket/rocket_drv.c:rocket_device_runtime_suspend() {
    ...
    clk_bulk_disable_unprepare(ARRAY_SIZE(rdev->cores[core].clks),
                               rdev->cores[core].clks);
    ...
}

This allows an in-flight IRQ handler to race with hardware power-down.

[Severity: High]
This is a pre-existing issue, but can the device be left permanently powered
on with clocks enabled indefinitely after driver removal?

During device removal, rocket_core_fini() calls pm_runtime_disable() which
cancels any pending asynchronous suspend work:

drivers/accel/rocket/rocket_core.c:rocket_core_fini() {
    ...
    pm_runtime_dont_use_autosuspend(core->dev);
    pm_runtime_disable(core->dev);
    ...
}

Because a synchronous suspend is not used prior to disabling runtime PM,
the device can be left permanently in the RPM_ACTIVE state.

[Severity: High]
This is a pre-existing issue, but does unsafe teardown ordering allow the
timeout reset work to dereference a freed or NULL IOMMU group?

During driver removal, rocket_core_fini() frees the IOMMU group and sets it
to NULL:

drivers/accel/rocket/rocket_core.c:rocket_core_fini() {
    ...
    iommu_group_put(core->iommu_group);
    core->iommu_group =3D NULL;
    rocket_job_fini(core);
    ...
}

rocket_job_fini() then cancels the reset work. If a job timeout occurs
concurrently and the reset work executes before cancellation, rocket_reset()
will use the NULL or freed group:

drivers/accel/rocket/rocket_job.c:rocket_reset() {
    ...
    iommu_detach_group(NULL, core->iommu_group);
    ...
}

[Severity: High]
This is a pre-existing issue, but does the driver fail to verify if an IOMMU
group was successfully retrieved during initialization?

In rocket_core_init(), core->iommu_group is assigned without validation:

drivers/accel/rocket/rocket_core.c:rocket_core_init() {
    ...
    core->iommu_group =3D iommu_group_get(dev);
    ...
}

If the device lacks an IOMMU, this returns NULL. When the first job is later
submitted, rocket_job_run() passes this NULL group to iommu_attach_group(),
causing a kernel panic:

drivers/accel/rocket/rocket_job.c:rocket_job_run() {
    ...
    ret =3D iommu_attach_group(job->domain->domain, core->iommu_group);
    ...
}

[Severity: Medium]
This is a pre-existing issue, but does the timeout reset logic cause a power
leak by failing to queue an idle check?

In rocket_reset(), the PM usage count is dropped using
pm_runtime_put_noidle():

drivers/accel/rocket/rocket_job.c:rocket_reset() {
    ...
    pm_runtime_put_noidle(core->dev);
    ...
}

This decrements the usage counter but explicitly avoids queuing an idle che=
ck
or autosuspend request. If no further jobs are submitted, the device will
remain in a powered-on state indefinitely.

[Severity: Medium]
This is a pre-existing issue, but does this code leak the scheds array on
the error path?

The scheds array is dynamically allocated, but if drm_sched_entity_init()
returns an error, the function returns immediately without freeing it:

drivers/accel/rocket/rocket_job.c:rocket_job_open() {
    ...
    ret =3D drm_sched_entity_init(&rocket_priv->sched_entity, ...);
    if (WARN_ON(ret))
        return ret;
    ...
}

[Severity: High]
This is a pre-existing issue, but does manual cleanup race with the devres
managed IRQ handler, leading to a use-after-free?

The IRQ is managed via devres, but critical data structures are destroyed
manually in rocket_job_fini() before devres teardown:

drivers/accel/rocket/rocket_job.c:rocket_job_fini() {
    ...
    drm_sched_fini(&core->sched);
    cancel_work_sync(&core->reset.work);
    destroy_workqueue(core->reset.wq);
    ...
}

If an interrupt fires between the manual cleanup and devres teardown, the I=
RQ
handler thread will attempt to access destroyed scheduler state or workqueu=
es.

[Severity: High]
This is a pre-existing issue, but is there a time-of-check to time-of-use
race condition when modifying hardware state outside of core->job_lock?

The IRQ thread disables the hardware by writing to OPERATION_ENABLE before
acquiring the lock:

drivers/accel/rocket/rocket_job.c:rocket_job_handle_irq() {
    ...
    rocket_pc_writel(core, OPERATION_ENABLE, 0x0);
    rocket_pc_writel(core, INTERRUPT_CLEAR, 0x1ffff);

    scoped_guard(mutex, &core->job_lock)
    ...
}

If a job times out, rocket_reset() can restart the scheduler and submit a n=
ew
job. If the delayed IRQ thread for the timed-out job executes subsequently,
it will write 0x0 to OPERATION_ENABLE unprotected, aborting the new job and
falsely signaling success.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814022453.437-=
1-kernel@airkyi.com?part=3D3
