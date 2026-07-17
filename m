Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C28FC4450F
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 06:23:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B82410F448;
	Fri, 17 Jul 2026 06:23:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Y36Cjp9E";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90C6D10F448
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 06:23:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 708394023F;
 Fri, 17 Jul 2026 06:23:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 331251F000E9;
 Fri, 17 Jul 2026 06:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784269417;
 bh=cbu6Pm55inW4kgWFOgY/7L+auyrZvHk8WCYZ3ys5Vvk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Y36Cjp9Ee0S32knR30NjBohmh8n+rqrqFsh20ik6vXvfdcFtBS/H1TZ+sUc8NIffz
 TOsYb7syXy72TXZq1iJXEk/PmmsE9u1s9Lz4f7RGwi/KQVb9+Qc7BKrKeD1cNdUME2
 hM8zqS4y7qd2WBe1bmOl+LI2twp+r/CRQikeC4kG+8+FNlbVpsSgyyT0r4nboXiJBb
 66Qv4SOkkrRP/j4oxfRnRqfdNpmKy3knSfuHeGlWpG8ZT7Jade+FDfIIjuD1fb49FA
 3o9j8mkSWjsE1v1AnaZDVunpyg2KTa3H2U5y/ch2qbn2FpMS/fEPOS52Dl4wRRRNQq
 3egjAZMAnWSuQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/5] accel/ethosu: check DMA mask setup
To: "GuoHan Zhao" <zhaoguohan@kylinos.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260717061145.1478139-2-zhaoguohan@kylinos.cn>
References: <20260717061145.1478139-1-zhaoguohan@kylinos.cn>
 <20260717061145.1478139-2-zhaoguohan@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 06:23:36 +0000
Message-Id: <20260717062337.331251F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 12 potential issue=
(s) to consider:

Pre-existing issues:
- [Critical] Validation mismatch allows jobs to run with stale NPU region p=
ointers (UAF / OOB DMA).
- [High] Missing IS_ERR check for devm_platform_ioremap_resource() in ethos=
u_probe().
- [High] Ignored ethosu_sram_init() failure leaves stale sram_size, causing=
 the NPU to DMA to physical address 0x0.
- [High] ethosu_probe error paths leak DRM scheduler, PM runtime references=
, and SRAM, leading to a UAF.
- [High] Calling drm_sched_fini on a failed drm_sched_init causes a crash.
- [High] WARN_ON(ret) in ethosu_job_open evaluates to 1 on error, bypassing=
 VFS error checks and causing NULL pointer dereferences later.
- [High] The job's done_fence is leaked on all error paths in ethosu_ioctl_=
submit_job.
- [High] ethosu_job_run leaves done_fence uninitialized if the job is abort=
ed, causing a refcount underflow later.
- [High] Hardirq handler reads unclocked MMIO registers when IRQ fires earl=
y or during runtime suspend.
- [High] Out-of-bounds array read in ethosu_job_timedout using unvalidated =
hardware register value.
- [High] Potential AB-BA deadlock due to calling pm_runtime_resume_and_get =
while holding dma_resv locks.
- [High] Uninitialized SRAM memory disclosure via runtime PM race.
--

--- Patch [1]: [PATCH v2 1/5] accel/ethosu: check DMA mask setup ---
commit ea4ab7f2e2a6b6cb0faa43a971f991179714158a
Author: GuoHan Zhao <zhaoguohan@kylinos.cn>
Subject: accel/ethosu: check DMA mask setup

This patch checks the return value of dma_set_mask_and_coherent() to avoid
proceeding with an unsupported DMA configuration. If it fails, the probe
function now properly returns the error.

Link: https://sashiko.dev/#/patchset/20260716082530.1023538-1-zhaoguohan@ky=
linos.cn?part=3D1

> diff --git a/drivers/accel/ethosu/ethosu_drv.c b/drivers/accel/ethosu/eth=
osu_drv.c
> index ed9c748a54ad5..f3920185389de 100644
> --- a/drivers/accel/ethosu/ethosu_drv.c
> +++ b/drivers/accel/ethosu/ethosu_drv.c
> @@ -339,7 +339,9 @@ static int ethosu_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  	platform_set_drvdata(pdev, ethosudev);
> =20
> -	dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(40));
> +	ret =3D dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(40));
> +	if (ret)
> +		return ret;
> =20
>  	ethosudev->regs =3D devm_platform_ioremap_resource(pdev, 0);

[Severity: High]
This is a pre-existing issue, but does this code check the return value of
devm_platform_ioremap_resource()?

If devm_platform_ioremap_resource() fails, it returns an ERR_PTR. Because t=
his
is not checked, ethosu_init() subsequently calls ethosu_device_resume() whi=
ch
calls ethosu_reset(), passing the error pointer to writel_relaxed(), result=
ing
in a fatal page fault:

    ethosu_reset()
        writel_relaxed(RESET_PENDING_CSL, ethosudev->regs + NPU_REG_RESET);

Could we add an IS_ERR check here?

[Severity: High]
This isn't a bug introduced by this patch, but does the error path in
ethosu_probe() clean up the DRM scheduler properly?

If ethosu_probe() fails after ethosu_job_init() (which initializes the
scheduler), it seems to return directly without calling ethosu_job_fini():

    ret =3D ethosu_init(ethosudev);
    if (ret)
        return ret;

Since ethosudev is devres-managed, it is freed upon probe failure, but the
active scheduler kthreads might remain running and attempt to access the
freed memory.


While reviewing this driver, I also noticed a few other pre-existing issues
outside of this patch's context:

[Severity: Critical]
This isn't a bug introduced by this patch, but does the validation logic
in ethosu_ioctl_submit_job() incorrectly permit jobs with sram_size =3D 0?

    ethosu_ioctl_submit_job()
        if (i =3D=3D ETHOSU_SRAM_REGION) {
            if (cmd_info->region_size[i] <=3D edev->npu_info.sram_size)
                continue;

If a user sets job->sram_size to 0, validation passes. However,
ethosu_job_hw_submit() uses job->sram_size to conditionally update the base:

    ethosu_job_hw_submit()
        if (job->sram_size) {
            writel_relaxed(lower_32_bits(dev->sramphys), ...);
        }

Since it is 0, the base pointer update is skipped. Can this allow the NPU
to execute the command stream using a stale pointer left over from a
previous job, resulting in out-of-bounds DMA?

[Severity: High]
This is a pre-existing issue, but does ethosu_init() ignore the return value
of ethosu_sram_init()?

If ethosu_sram_init() fails, ethosudev->sramphys remains 0, but
ethosudev->npu_info.sram_size was already populated. Since ethosu_init()
doesn't check the return value, it permits the driver to proceed:

    ethosu_init()
        ethosu_sram_init(ethosudev);
        dev_info(ethosudev->base.dev, ...);

If userspace submits a job requesting SRAM, ethosu_job_hw_submit() programs
the NPU using dev->sramphys:

    ethosu_job_hw_submit()
        writel_relaxed(lower_32_bits(dev->sramphys),
                       dev->regs + NPU_REG_BASEP(ETHOSU_SRAM_REGION));

Can this cause the hardware to DMA to physical address 0x0?

[Severity: High]
This is a pre-existing issue, but can the error path in ethosu_job_init()
cause a crash if drm_sched_init() fails?

    ethosu_job_init()
        ret =3D drm_sched_init(&edev->sched, ...);
        if (ret)
            goto err_sched;
        ...
    err_sched:
        drm_sched_fini(&edev->sched);
        return ret;

If drm_sched_init() fails, it cleans up internally. Does calling
drm_sched_fini() on it again attempt to stop non-existent workqueues or
kthreads, resulting in a NULL pointer dereference?

[Severity: High]
This isn't a bug introduced by this patch, but does ethosu_job_open() return
a positive value on error?

    ethosu_job_open()
        ret =3D drm_sched_entity_init(...);
        if (ret)
            return WARN_ON(ret);

WARN_ON() evaluates to 1. When ethosu_open() propagates this to VFS, it mig=
ht
bypass the VFS error checks since 1 is treated as success:

    ethosu_open()
        ret =3D ethosu_job_open(priv);
        if (ret)
            goto err_put_mod;

Could this bypass assigning file->driver_priv, leading to a NULL pointer
dereference later when ethosu_postclose() passes it to ethosu_job_close()?

[Severity: High]
This is a pre-existing issue, but is the done_fence leaked on error paths in
ethosu_ioctl_submit_job()?

    ethosu_ioctl_submit_job()
        ejob->done_fence =3D kzalloc_obj(*ejob->done_fence);

If the submission fails later, ethosu_job_err_cleanup() is called, but it
seems to omit freeing the done_fence:

    ethosu_job_err_cleanup()
        ...
        drm_gem_object_put(job->cmd_bo);
        kfree(job);

Can an unprivileged user trigger this leak repeatedly by passing invalid
parameters?

[Severity: High]
This is a pre-existing issue, but can ethosu_job_run() skip initializing the
fence, leading to a refcount underflow?

    ethosu_job_run()
        if (unlikely(job->base.s_fence->finished.error))
            return NULL;

        dma_fence_init(fence, &ethosu_fence_ops, &dev->fence_lock, ...);

If it returns early, job->done_fence remains zero-initialized. Later,
ethosu_job_cleanup() unconditionally calls dma_fence_put(job->done_fence),
which could attempt to decrement a 0-refcount object.

[Severity: High]
This isn't a bug introduced by this patch, but is the IRQ requested before =
the
device clocks are turned on?

    ethosu_job_init()
        ret =3D devm_request_threaded_irq(dev, edev->irq,
                                        ethosu_job_irq_handler, ...);

If the device shares this IRQ, and the IRQ fires before ethosu_init() enabl=
es
the clocks, ethosu_job_irq_handler() will immediately access MMIO:

    ethosu_job_irq_handler()
        u32 status =3D readl_relaxed(dev->regs + NPU_REG_STATUS);

Can accessing unclocked MMIO registers cause a fatal bus lockup?

[Severity: High]
This is a pre-existing issue, but does ethosu_job_timedout() use an
unvalidated hardware register value as an array index?

    ethosu_job_timedout()
        cmdaddr =3D readl_relaxed(dev->regs + NPU_REG_QREAD);
        ...
        dev_err(dev->base.dev, "...", cmdaddr, bocmds[cmdaddr / 4]);

If a malicious command stream causes a timeout with an out-of-bounds address
in QREAD, could this perform an out-of-bounds kernel memory read?

[Severity: High]
This is a pre-existing issue, but can ethosu_job_push() cause an AB-BA
deadlock by calling pm_runtime_resume_and_get() while holding dma_resv lock=
s?

    ethosu_job_push()
        ret =3D drm_gem_lock_reservations(job->region_bo, ...);
        if (ret)
            return ret;
        ...
        ret =3D pm_runtime_resume_and_get(job->dev->base.dev);

If memory reclaim runs and attempts to shrink shared BOs, the shrinker will
try to acquire the same dma_resv locks. Since pm_runtime can block on
allocations or power domains, could this invert lock ordering?

[Severity: High]
This is a pre-existing issue, but does ethosu_init() expose uninitialized
SRAM via a runtime PM race?

    ethosu_init()
        ret =3D ethosu_device_resume(ethosudev->base.dev);
        ...
        ethosu_sram_init(ethosudev);

Because ethosu_device_resume() is called before ethosu_sram_init() allocates
the SRAM, the memset_io() zeroing logic is skipped. The device is then mark=
ed
active.

If a job is submitted immediately, pm_runtime_resume_and_get() might skip
ethosu_device_resume(), allowing the job to run with uncleared SRAM memory.
Could this leak sensitive data to userspace?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717061145.1478=
139-1-zhaoguohan@kylinos.cn?part=3D1
