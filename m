Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45BC1C4450A
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 08:39:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C3CD10F214;
	Thu, 16 Jul 2026 08:39:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ljOD4WNY";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D49210F214
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 08:39:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 800DF60054;
 Thu, 16 Jul 2026 08:39:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14F141F000E9;
 Thu, 16 Jul 2026 08:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784191184;
 bh=6Om/N6k47zsJ/RUIc5yazgzQz4vrVN4V1XZFJuHB7/Q=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ljOD4WNYcU41UDfuRf32Dk2ONoAWqqzFa5pxySp2lKcl0TFkUk4rj/OK1AxIg9P/H
 K3YA7rQPam67kKC1lB2A2dTZUiWzkV6gxMVzOyimlKDRbtIw6gEP9fO/S+xPltTRLS
 3yufxj35lMIhGN9J+6wUwiXe7a+w4wRQ3tUgkMhFYnL3cUM9qiB6On5w3Gb7oRWEJW
 GjxeMB264iSiDVAHT3z0ucdxfZk+gI/QE5po9ZM4pMB/BeIP1bA6p1jOy1D138S4HP
 K8O4WkGZwZGrU3yjjzcsb9/e9FZvlU8VWjgP+l/5EAygcnsrE/ARQyMYJTcqOYxpJI
 qlgO9iVNevGww==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] accel/ethosu: clean up resources on probe failure
To: zhaoguohan@kylinos.cn
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260716082530.1023538-2-zhaoguohan@kylinos.cn>
References: <20260716082530.1023538-1-zhaoguohan@kylinos.cn>
 <20260716082530.1023538-2-zhaoguohan@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 08:39:43 +0000
Message-Id: <20260716083944.14F141F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 10 potential issue=
(s) to consider:

Pre-existing issues:
- [High] The shared IRQ handler accesses hardware registers directly withou=
t ensuring the device is actively powered, leading to potential bus faults =
or spurious interrupts.
- [High] The runtime suspend callback powers down hardware clocks without s=
ynchronizing against in-flight shared IRQ handlers.
- [High] Device removal does not synchronously suspend the hardware, leakin=
g the active state and leaving device clocks permanently enabled.
- [High] Calling `drm_sched_fini()` after `drm_sched_init()` fails causes a=
 kernel panic due to uninitialized waitqueues.
- [High] The driver ignores the return value of `dma_set_mask_and_coherent(=
)`, risking silent DMA address truncation.
- [High] The return value of `ethosu_sram_init()` is ignored, which can lea=
d to the NPU accessing an unallocated or invalid SRAM DMA address.
- [High] The devm-managed shared IRQ handler can outlive the DRM scheduler =
during probe failure and module removal.
- [High] Driver removal does not stop active hardware jobs.
- [High] The `done_fence` allocation is leaked if `ethosu_ioctl_submit_job(=
)` encounters an error during job initialization.
- [High] Calling `dma_fence_put()` on a fence that skipped initialization c=
auses a refcount underflow warning and leaks memory.
--

--- Patch [1]: [PATCH 1/3] accel/ethosu: clean up resources on probe failur=
e ---
commit 78b823f053992db797e336339fffb6f86bafc10f
Author: GuoHan Zhao <zhaoguohan@kylinos.cn>

accel/ethosu: clean up resources on probe failure

ethosu_job_init() creates a scheduler before ethosu_init() and
drm_dev_register(). Errors from either later step return directly, leaving
the scheduler workqueue allocated. A drm_dev_register() failure also leaves
the optional SRAM allocation behind.

Link: https://sashiko.dev/#/patchset/20260716065219.931088-1-zhaoguohan@kyl=
inos.cn?part=3D1

> diff --git a/drivers/accel/ethosu/ethosu_drv.c b/drivers/accel/ethosu/eth=
osu_drv.c
> index ed9c748a54ad5..d1153b15ca3ee 100644
> --- a/drivers/accel/ethosu/ethosu_drv.c
> +++ b/drivers/accel/ethosu/ethosu_drv.c

[ ... ]

> @@ -353,13 +366,21 @@ static int ethosu_probe(struct platform_device *pde=
v)
> =20
>  	ret =3D ethosu_init(ethosudev);

[Severity: High]
This is a pre-existing issue, but is the return value of ethosu_sram_init()
checked during ethosu_init()?

If the SRAM pool allocation fails, ethosudev->npu_info.sram_size still
reflects the full pool size, but ethosudev->sramphys remains zero. Can this
cause the NPU to attempt access to unmapped or zero physical memory when
a job utilizing SRAM is submitted?

>  	if (ret)
> -		return ret;
> +		goto err_job_fini;
> =20
>  	ret =3D drm_dev_register(&ethosudev->base, 0);

[Severity: High]
This is a pre-existing issue, but does this code ignore the return value of
dma_set_mask_and_coherent() which is called earlier in ethosu_probe()?

If the platform only supports 32-bit DMA and the call fails, the default
32-bit mask is retained. The DRM core and driver might proceed assuming
40-bit DMA is active, handing the NPU physical addresses greater than 4 GB,
which could lead to silent DMA address truncation and memory corruption.

>  	if (ret)
> -		pm_runtime_dont_use_autosuspend(ethosudev->base.dev);
> +		goto err_runtime_suspend;

[ ... ]

> @@ -369,9 +390,7 @@ static void ethosu_remove(struct platform_device *pde=
v)
> =20
>  	drm_dev_unregister(&ethosudev->base);
>  	ethosu_job_fini(ethosudev);

[Severity: High]
This is a pre-existing issue, but does ethosu_remove() fail to synchronously
suspend the hardware?

The driver unregisters the DRM device but never explicitly suspends the
hardware (e.g., via pm_runtime_put_sync_suspend()). Devres cleanup only
calls pm_runtime_disable(), which cancels pending autosuspends but does not
invoke the suspend callback if the device is active. Can this leave the
device hardware and clocks permanently powered on after module unload?

[Severity: High]
This is a pre-existing issue, but can the devm-managed shared IRQ handler
outlive the DRM scheduler here?

The IRQ is requested using devm_request_threaded_irq(). During ethosu_remov=
e()
(and on probe failure), the driver explicitly calls ethosu_job_fini(), which
destroys the DRM scheduler.

Because the IRQ is managed by devm, it remains fully active until the
remove function completes. If an interrupt fires in this window, could
ethosu_job_irq_handler() execute and access the destroyed dev->sched or
dev->in_flight_job structures, leading to a use-after-free?

[Severity: High]
This is a pre-existing issue, but does device removal ensure active hardware
jobs are stopped?

ethosu_remove() destroys the software state but fails to halt the physical
NPU hardware (e.g., via ethosu_reset() or a synchronous suspend).

If an active job is executing during driver unload, will the NPU continue
running and asynchronously write to memory that has already been freed?

> -	if (ethosudev->sram)
> -		gen_pool_free(ethosudev->srampool, (unsigned long)ethosudev->sram,
> -			      ethosudev->npu_info.sram_size);
> +	ethosu_sram_fini(ethosudev);
>  }

[Severity: High]
This is a pre-existing issue, but can the shared IRQ handler access
hardware registers while the device is suspended?

drivers/accel/ethosu/ethosu_job.c:ethosu_job_irq_handler() {
    ...
    u32 status =3D readl_relaxed(dev->regs + NPU_REG_STATUS);
    ...
}

If the Ethos-U device is suspended via runtime PM and another device on
the same IRQ line triggers an interrupt, ethosu_job_irq_handler() runs
unconditionally. Reading from a powered-down block typically returns
0xffffffff or triggers an external bus fault.

Should the handler use pm_runtime_get_if_active() before accessing
hardware registers to prevent spurious interrupts or kernel panics?

[Severity: High]
This is a pre-existing issue, but does the runtime suspend callback
safely synchronize against in-flight shared IRQ handlers?

drivers/accel/ethosu/ethosu_drv.c:ethosu_device_suspend() {
    ...
    clk_bulk_disable_unprepare(ethosudev->num_clks, ethosudev->clks);
    ...
}

The driver requests an interrupt with IRQF_SHARED. If an interrupt from
a shared device fires concurrently right before the clocks are disabled,
could the irq handler be mid-execution reading registers just as the clocks
are cut?

Should the suspend callback call synchronize_irq() before powering
down hardware clocks?

[Severity: High]
This is a pre-existing issue, but does the error handling path for
drm_sched_init() cause a panic if it fails?

drivers/accel/ethosu/ethosu_job.c:ethosu_job_init() {
    ...
    ret =3D drm_sched_init(&edev->sched, &args);
    if (ret) {
        dev_err(dev, "Failed to create scheduler: %d\n", ret);
        goto err_sched;
    }
    return 0;

err_sched:
    drm_sched_fini(&edev->sched);
    return ret;
}

If drm_sched_init() fails, it cleans up its own state. The error path
then branches to err_sched and calls drm_sched_fini() on the partially
initialized scheduler.

Because the waitqueue head was either destroyed or never initialized,
its list pointers are NULL. Will drm_sched_fini() invoking
wake_up_all(&sched->job_scheduled) cause an immediate crash?

[Severity: High]
This is a pre-existing issue, but does ethosu_ioctl_submit_job() leak
the done_fence allocation on error paths?

drivers/accel/ethosu/ethosu_job.c:ethosu_ioctl_submit_job() {
    ...
    ejob->done_fence =3D kzalloc_obj(*ejob->done_fence);
    ...
}

If a subsequent operation fails (e.g., drm_gem_object_lookup returns NULL),
the code branches to out_cleanup_job and calls ethosu_job_err_cleanup().

drivers/accel/ethosu/ethosu_job.c:ethosu_job_err_cleanup() {
    ...
    drm_gem_object_put(job->cmd_bo);
    kfree(job);
}

This cleanup function drops BO references and frees the job object, but
appears to forget freeing the job->done_fence pointer. Could an unprivileged
user repeatedly trigger this leak by passing invalid BO handles?

[Severity: High]
This is a pre-existing issue, but can calling dma_fence_put() on a fence
that skipped initialization cause a refcount underflow?

drivers/accel/ethosu/ethosu_job.c:ethosu_job_run() {
    ...
    if (unlikely(job->base.s_fence->finished.error))
        return NULL;
    ...
}

If a job is aborted before it runs, ethosu_job_run() returns NULL early
and skips calling dma_fence_init() on job->done_fence.

Later, the DRM scheduler destroys the job:

drivers/accel/ethosu/ethosu_job.c:ethosu_job_cleanup() {
    ...
    dma_fence_put(job->done_fence);
    ...
}

Because the fence was only zero-allocated and never initialized, its
refcount is 0. Will kref_put() underflow, print a warning, and abort
the release, permanently leaking the memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716082530.1023=
538-1-zhaoguohan@kylinos.cn?part=3D1
