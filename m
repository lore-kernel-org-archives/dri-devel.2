Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEDDDC4450A
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 07:04:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F44710E2EE;
	Thu, 16 Jul 2026 07:04:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="I0+RbUNf";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F7AA10E2EE
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 07:04:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 472BF43CD3;
 Thu, 16 Jul 2026 07:04:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 000F01F00A3A;
 Thu, 16 Jul 2026 07:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784185493;
 bh=UBXSLt9kxB5AWz0Q8FvBmxCxZqNiA87FyfDIW1p6w/E=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=I0+RbUNfrLd0F7TTGhL9vFCXHcOqATVdUdGjjYYmwhdj8cFilu+eH8hHi5JWfcbqq
 sSalgwmM+AuJmqF5FxrwnElYEikS59DbEktOKzLWaAUW3jlaybgm0tCc2VbjVy2/DQ
 zTQSOGqq5N/TcwCTBpP8YDBYsivapj0TpEJ3MS66RFJDc/dtt5OjG4CXifTuJerJUu
 jAfTH7CqDqwYKU5UB/hgTyUZ/ys7eO/Aa5ZNom/RkulbbQTbkfffvm85F6GMSl8AVy
 2spzWHBZ/RYtW3gGiB8vi25vYUNouI++vv09VWCNQr6AGJnsYO5PDxMHBa4OvEnuIk
 hQ+kzSZVosJiA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] accel/ethosu: check MMIO mapping errors in probe
To: zhaoguohan@kylinos.cn
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260716065219.931088-1-zhaoguohan@kylinos.cn>
References: <20260716065219.931088-1-zhaoguohan@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 07:04:52 +0000
Message-Id: <20260716070453.000F01F00A3A@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Missing cleanup of job scheduler and SRAM pool on probe error =
paths causes a Use-After-Free.
- [Critical] Ignored return value from ethosu_sram_init() leads to potentia=
l memory corruption.
- [High] Registering a shared IRQ handler before enabling hardware clocks c=
an cause a bus fault.
- [High] User-triggerable memory leak of done_fence in ethosu_ioctl_submit_=
job error paths.
- [High] Refcount underflow caused by calling dma_fence_put() on an uniniti=
alized done_fence.
--

--- Patch [1]: [PATCH] accel/ethosu: check MMIO mapping errors in probe ---
commit 211e95fc7f28959e17e3b5a23f5f4f5aaf071bdd
Author: GuoHan Zhao <zhaoguohan@kylinos.cn>
accel/ethosu: check MMIO mapping errors in probe

devm_platform_ioremap_resource() returns an error pointer when the register
resource cannot be mapped. ethosu_probe() stores it and continues until
initialization dereferences it through MMIO accessors. This patch returns
the mapping error before initializing the device.

> diff --git a/drivers/accel/ethosu/ethosu_drv.c b/drivers/accel/ethosu/eth=
osu_drv.c
> index ed9c748a54ad5..b2901eb8a7a03 100644
> --- a/drivers/accel/ethosu/ethosu_drv.c
> +++ b/drivers/accel/ethosu/ethosu_drv.c
> @@ -342,6 +342,8 @@ static int ethosu_probe(struct platform_device *pdev)
>  	dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(40));
> =20
>  	ethosudev->regs =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(ethosudev->regs))
> +		return PTR_ERR(ethosudev->regs);
> =20
>  	ethosudev->num_clks =3D devm_clk_bulk_get_all(&pdev->dev, &ethosudev->c=
lks);
>  	if (ethosudev->num_clks < 0)

I noticed some additional pre-existing issues in this driver.

drivers/accel/ethosu/ethosu_drv.c:ethosu_probe() {
    ...
        ret =3D ethosu_init(ethosudev);
        if (ret)
                return ret;

        ret =3D drm_dev_register(&ethosudev->base, 0);
        if (ret)
                pm_runtime_dont_use_autosuspend(ethosudev->base.dev);

        pm_runtime_put_autosuspend(ethosudev->base.dev);
        return ret;
}

[Severity: Critical]
This is a pre-existing issue, but was not introduced by this patch.

If ethosu_init() or drm_dev_register() fail, the function returns directly
without calling ethosu_job_fini() or freeing the sram pool.

Because the job scheduler is embedded in the devm-allocated ethosu_device, =
it
will be freed when devm cleans up. However, the drm scheduler kthreads and
timers remain active and will access the freed memory.

Can this cause a use-after-free regression leading to a kernel panic?

drivers/accel/ethosu/ethosu_drv.c:ethosu_probe() {
    ...
        ret =3D ethosu_job_init(ethosudev);
        if (ret)
                return ret;

        ret =3D ethosu_init(ethosudev);
    ...
}

[Severity: High]
This is a pre-existing issue, but was not introduced by this patch.

ethosu_job_init() registers the interrupt handler with IRQF_SHARED before
ethosu_init() resumes PM runtime and enables the clocks.

If another device on the same IRQ line triggers an interrupt in this window,
the handler will execute and read NPU_REG_STATUS:

drivers/accel/ethosu/ethosu_job.c:ethosu_job_irq_handler() {
    ...
        u32 status =3D readl_relaxed(dev->regs + NPU_REG_STATUS);
    ...
}

Will reading from an unclocked NPU peripheral crash the system?

drivers/accel/ethosu/ethosu_drv.c:ethosu_init() {
    ...
        ethosu_sram_init(ethosudev);
    ...
}

[Severity: Critical]
This is a pre-existing issue, but was not introduced by this patch.

In ethosu_sram_init(), if gen_pool_dma_alloc() fails, it returns an error.
However, ethosu_init() ignores this return value.

Because npu_info.sram_size was already set to gen_pool_size(), it remains
non-zero while sramphys remains 0.

When a user submits a job requesting sram, the size check passes, and
ethosu_job_hw_submit() configures the hardware to use physical sram
address 0x0.

Could this result in a memory corruption regression or an IOMMU fault?

drivers/accel/ethosu/ethosu_job.c:ethosu_job_err_cleanup() {
        unsigned int i;

        for (i =3D 0; i < job->region_cnt; i++)
                drm_gem_object_put(job->region_bo[i]);

        drm_gem_object_put(job->cmd_bo);

        kfree(job);
}

[Severity: High]
This is a pre-existing issue, but was not introduced by this patch.

ethosu_ioctl_submit_job() allocates done_fence. If a subsequent validation
fails, the error path calls ethosu_job_err_cleanup().

This function frees the job structure but misses freeing job->done_fence.

Can an unprivileged user repeatedly call the submit ioctl with invalid hand=
les
to trigger a done_fence leak?

drivers/accel/ethosu/ethosu_job.c:ethosu_job_run() {
    ...
        if (unlikely(job->base.s_fence->finished.error))
                return NULL;

        dma_fence_init(fence, &ethosu_fence_ops, &dev->fence_lock,
                       dev->fence_context, ++dev->emit_seqno);
    ...
}

[Severity: High]
This is a pre-existing issue, but was not introduced by this patch.

If job->base.s_fence->finished.error is true, the function returns early
without calling dma_fence_init() on job->done_fence.

When the job is later destroyed, ethosu_job_cleanup() unconditionally calls
dma_fence_put() on the fence:

drivers/accel/ethosu/ethosu_job.c:ethosu_job_cleanup() {
    ...
        dma_fence_put(job->done_fence);
    ...
}

Since the fence is zero-initialized, will calling kref_put() on it violate =
the
API and cause a refcount underflow?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716065219.9310=
88-1-zhaoguohan@kylinos.cn?part=3D1
