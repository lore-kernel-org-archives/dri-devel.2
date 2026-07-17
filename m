Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E626BC44507
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 06:24:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54E5110F44A;
	Fri, 17 Jul 2026 06:24:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Yp/SOtUM";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC8C310F44A
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 06:24:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B5BE340486;
 Fri, 17 Jul 2026 06:24:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 796221F000E9;
 Fri, 17 Jul 2026 06:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784269459;
 bh=1kdFW9w70GEtnW9Y/psExDLnU2djGyzMCRiKbtjZAf4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Yp/SOtUMNIQXGbtf298ObR2V9fhyz3xONN05mW2c4MKCexUbgvmWBDQb6HRAEJYuK
 xGcps+Q58oxnZ9Ll0H1BDmUiQlQr4z2Jt6a4MZIGMzZPszrA3nyEkG/gexOhqtI2+7
 /WoEmtp2QCnVRd+b53MdwxpS18Ijw7nmnePrDUGlwyB8O7L19OcdYOp2Pzo/A5S30Q
 WzMARCE8Z36jYM0T60DTPQJVrziEJ0lYtde8+TaIf0vJmiyfU0PE6elPtVKbadCMjB
 kUfY4sX0HoRuHHJpaKq5BIsNOAMx9ju4S0ehUsSfteNR4lUW/lpg6OGlrkZoj5bMZ7
 Tn/uZmfKRpG+g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/5] accel/ethosu: fix scheduler and IRQ lifetime
To: "GuoHan Zhao" <zhaoguohan@kylinos.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260717061145.1478139-3-zhaoguohan@kylinos.cn>
References: <20260717061145.1478139-1-zhaoguohan@kylinos.cn>
 <20260717061145.1478139-3-zhaoguohan@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 06:24:19 +0000
Message-Id: <20260717062419.796221F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] ethosu_init() ignores the return value of ethosu_sram_init().
- [Critical] The driver leaves NPU_REG_BASEP(ETHOSU_SRAM_REGION) unmodified=
 when job->sram_size =3D=3D 0 and no BO handle is provided for the SRAM reg=
ion, allowing an attacker to force the NPU to use a stale DMA address from =
a previously freed BO.
- [High] The ethosu_probe() error paths lack cleanup for resources initiali=
zed during probe, leading to memory leaks and leaked DRM scheduler workqueu=
es.
- [High] The return value of devm_platform_ioremap_resource() is not checke=
d for errors, leading to a crash on failure.
- [High] Calling drm_sched_job_cleanup() on an uninitialized job causes a n=
ull pointer dereference.
- [High] Racing ethosu_ioctl_submit with device unbind causes kernel panics=
 due to missing drm_dev_enter() and incorrect scheduler lifetime.
- [High] The job->done_fence allocated during job submission is leaked on e=
rror paths and causes a refcount underflow warning during scheduler teardow=
n if the job is cancelled.
- [High] Shared IRQ handler accesses hardware registers while clocks are di=
sabled.
--

--- Patch [2]: [PATCH v2 2/5] accel/ethosu: fix scheduler and IRQ lifetime =
---
commit 5c0b05e99c708b0d7c384370684640c706d58902
Author: GuoHan Zhao <zhaoguohan@kylinos.cn>

accel/ethosu: fix scheduler and IRQ lifetime

ethosu_job_init() requests the managed IRQ before initializing the DRM
scheduler. If drm_sched_init() fails, the error path calls drm_sched_fini()
on a partially initialized scheduler. The IRQ also remains registered until
devres cleanup after normal or probe-error paths destroy the scheduler.

Initialize the scheduler before requesting the IRQ. Scheduler setup failure
then needs no teardown, while IRQ setup failure can tear down a valid
scheduler. Free the IRQ explicitly before drm_sched_fini() to prevent
interrupt handlers from accessing scheduler state during teardown.

Fixes: 5a5e9c0228e6 ("accel: Add Arm Ethos-U NPU driver")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20260716082530.1023538-1-zhaoguohan@ky=
linos.cn?part=3D1
Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>

> diff --git a/drivers/accel/ethosu/ethosu_job.c b/drivers/accel/ethosu/eth=
osu_job.c
> index b76924645aaaf..5847433e87e7e 100644
> --- a/drivers/accel/ethosu/ethosu_job.c
> +++ b/drivers/accel/ethosu/ethosu_job.c
> @@ -315,6 +315,14 @@ int ethosu_job_init(struct ethosu_device *edev)
>  	if (edev->irq < 0)
>  		return edev->irq;
> =20
> +	edev->fence_context =3D dma_fence_context_alloc(1);
> +
> +	ret =3D drm_sched_init(&edev->sched, &args);
> +	if (ret) {
> +		dev_err(dev, "Failed to create scheduler: %d\n", ret);
> +		return ret;
> +	}
> +
>  	ret =3D devm_request_threaded_irq(dev, edev->irq,

[ ... ]

[Severity: High]
This is a pre-existing issue, but the ethosu_probe() error paths lack clean=
up
for resources initialized during probe:

drivers/accel/ethosu/ethosu_drv.c:ethosu_probe() {
    ...
	ret =3D ethosu_init(ethosudev);
	if (ret)
		return ret;
    ...
}

If ethosu_init() or drm_dev_register() fails, the function returns directly
without calling ethosu_job_fini().

Does this leak the DRM scheduler initialized by ethosu_job_init(), including
the scheduler's submit_wq workqueue and threads?

[Severity: High]
This is a pre-existing issue, but the return value of
devm_platform_ioremap_resource() is not checked for errors:

drivers/accel/ethosu/ethosu_drv.c:ethosu_probe() {
    ...
	ethosudev->regs =3D devm_platform_ioremap_resource(pdev, 0);

	ethosudev->num_clks =3D devm_clk_bulk_get_all(&pdev->dev, &ethosudev->clks=
);
    ...
}

If devm_platform_ioremap_resource() fails, it returns an ERR_PTR.=20

Because the return value is not checked with IS_ERR(), could ethosudev->regs
hold an invalid error pointer that causes a crash when dereferenced later in
ethosu_reset()?

[Severity: High]
This is a pre-existing issue, but drm_sched_job_cleanup() might be called on
an uninitialized job:

drivers/accel/ethosu/ethosu_job.c:ethosu_ioctl_submit_job() {
    ...
	ejob->done_fence =3D kzalloc_obj(*ejob->done_fence);
	if (!ejob->done_fence) {
		ret =3D -ENOMEM;
		goto out_cleanup_job;
	}
    ...
out_cleanup_job:
	if (ret)
		drm_sched_job_cleanup(&ejob->base);
    ...
}

If the allocation for ejob->done_fence fails, the error path calls
drm_sched_job_cleanup() on ejob->base. However, drm_sched_job_init() was
never called, meaning ejob->base.s_fence is NULL.

Will this cause a null pointer dereference when drm_sched_job_cleanup()
attempts to read the refcount?

[Severity: Critical]
This is a pre-existing issue, but ethosu_init() ignores the return value of
ethosu_sram_init():

drivers/accel/ethosu/ethosu_drv.c:ethosu_init() {
    ...
	ethosudev->npu_info.id =3D id =3D readl_relaxed(ethosudev->regs + NPU_REG_=
ID);
	ethosudev->npu_info.config =3D config =3D readl_relaxed(ethosudev->regs + =
NPU_REG_CONFIG);

	ethosu_sram_init(ethosudev);
    ...
}

If gen_pool_dma_alloc() fails inside ethosu_sram_init(), it returns -ENOMEM,
but ethosu_init() completely ignores this return code.

Could the driver proceed as if SRAM is fully available, programming physical
address 0 into the NPU SRAM base registers when a job runs?

[Severity: High]
This is a pre-existing issue, but ethosu_ioctl_submit() appears to lack
drm_dev_enter() and drm_dev_exit() protection:

drivers/accel/ethosu/ethosu_job.c:ethosu_ioctl_submit() {
	struct drm_ethosu_submit *args =3D data;
    ...

While ethosu_remove() tears down the scheduler:

drivers/accel/ethosu/ethosu_drv.c:ethosu_remove() {
    ...
	drm_dev_unregister(&ethosudev->base);
	ethosu_job_fini(ethosudev);
    ...
}

Since ethosu_remove() destroys the DRM scheduler synchronously via
ethosu_job_fini(), userspace might continue invoking submit ioctls on open
file descriptors.

Can this result in a use-after-free if submissions are pushed to the
scheduler entity and attempt to use the destroyed dev->sched workqueues
and locks?

[Severity: High]
This is a pre-existing issue, but the job->done_fence allocated during job
submission seems to be leaked on error paths:

drivers/accel/ethosu/ethosu_job.c:ethosu_job_err_cleanup() {
	unsigned int i;

	for (i =3D 0; i < job->region_cnt; i++)
		drm_gem_object_put(job->region_bo[i]);

	drm_gem_object_put(job->cmd_bo);

	kfree(job);
}

If job submission fails after ejob->done_fence is allocated,
ethosu_job_err_cleanup() frees the job but never frees the done_fence.

Additionally, if a job is cancelled before execution, dma_fence_init() is
never called, leaving the fence refcount at 0.

drivers/accel/ethosu/ethosu_job.c:ethosu_job_cleanup() {
    ...
	dma_fence_put(job->done_fence);
    ...
}

Could dma_fence_put() then trigger a refcount underflow warning during
scheduler teardown?

[Severity: Critical]
This is a pre-existing issue, but the NPU SRAM base address might remain
unmodified when job->sram_size is 0:

drivers/accel/ethosu/ethosu_job.c:ethosu_ioctl_submit_job() {
    ...
		/* Can only omit a BO handle if the region is not used or used for SRAM */
		if (!job->region_bo_handles[i]) {
			if (!cmd_info->region_size[i])
				continue;
			if (i =3D=3D ETHOSU_SRAM_REGION) {
				if (cmd_info->region_size[i] <=3D edev->npu_info.sram_size)
					continue;
    ...
}

drivers/accel/ethosu/ethosu_job.c:ethosu_job_hw_submit() {
    ...
	if (job->sram_size) {
		writel_relaxed(lower_32_bits(dev->sramphys),
			       dev->regs + NPU_REG_BASEP(ETHOSU_SRAM_REGION));
    ...
}

The ioctl validation allows an empty BO handle for ETHOSU_SRAM_REGION if the
command stream region size fits in the hardware SRAM. However,
ethosu_job_hw_submit() only programs the hardware SRAM base if
job->sram_size is greater than 0.

If a user submits a job with a command stream that accesses the SRAM region
while setting job->sram_size to 0, does this leave a stale DMA address in t=
he
hardware register from a previously freed BO, potentially allowing arbitrary
use-after-free DMA access?

[Severity: High]
This is a pre-existing issue, but the shared IRQ handler accesses hardware
registers unconditionally:

drivers/accel/ethosu/ethosu_job.c:ethosu_job_irq_handler() {
	struct ethosu_device *dev =3D data;
	u32 status =3D readl_relaxed(dev->regs + NPU_REG_STATUS);
    ...
}

The driver requests the IRQ using IRQF_SHARED and supports runtime PM.

If another device on the same shared IRQ line triggers an interrupt while
this device is runtime-suspended and its clocks are disabled, could reading
dev->regs + NPU_REG_STATUS cause a synchronous external abort (bus fault)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717061145.1478=
139-1-zhaoguohan@kylinos.cn?part=3D2
