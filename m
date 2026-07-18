Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A38EC4450A
	for <dri-devel@archiver.kernel.org>; Sat, 18 Jul 2026 03:28:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A85E10E51C;
	Sat, 18 Jul 2026 03:28:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CExkVN77";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D401110E51A
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 03:28:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DF5E960DC0;
 Sat, 18 Jul 2026 03:28:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9514E1F000E9;
 Sat, 18 Jul 2026 03:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784345280;
 bh=/59ZmpMOZOu/U2hJkANuZv/zYxUgr0tvoErd4Rm9NB4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CExkVN77hOyySj6AVvu5FxSvt9zqF3KKfyApp0icMwPNDENm3bhdby4lGIMGmZKve
 tvoXyl+xrrRimscWEJPUtmc9yeqnGz3oB1RXIphoHWJ8mFqJDEAzdnN/gY4n1u+tyr
 TmxjvgnV8U9JXwT8HhW6XzqxdHipjweO0EJexD2d+TD9w2vsavEOvCY7oumbuWx7ZF
 fjfx2SB0T3Sor3PpdnsQJD6i/TCM1S2NDhn+TBpClZ3VNO68XkGyN2hySFIa7LyOHb
 4/CDGwET3auYY4E/b0onzSLYNKdoftBiub5L/B2R2o98AljABl3t29TqNJQObi8DJl
 Ax57msRWtU7TQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 6/8] accel/rocket: add RK3576 NPU (RKNN) support
To: "Jiaxing Hu" <gahing@gahingwoo.com>
Cc: robh@kernel.org, dri-devel@lists.freedesktop.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260718031146.3368811-7-gahing@gahingwoo.com>
References: <20260718031146.3368811-1-gahing@gahingwoo.com>
 <20260718031146.3368811-7-gahing@gahingwoo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Jul 2026 03:27:59 +0000
Message-Id: <20260718032759.9514E1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:

New issues:
- [High] Resource leak on `devm_pm_domain_attach_list` failure.
- [High] Teardown order race in `rocket_job_fini` allows the hrtimer to be =
re-armed after cancellation.
- [High] Race condition and hardware state corruption on RK3576 DMA errors =
due to double-processing and unsynchronized MMIO writes.

Pre-existing issues:
- [High] Unconditional MMIO access in shared IRQ handler causes bus faults =
while device is suspended.
- [High] Leaked IOMMU group reference on job completion.
- [High] The runtime suspend callback powers down the device without synchr=
onizing the shared IRQ.
- [High] Calling `drm_sched_fini` on a partially initialized scheduler caus=
es a kernel panic.
--

--- Patch [6]: [RFC PATCH v2 6/8] accel/rocket: add RK3576 NPU (RKNN) suppo=
rt ---
commit 3624dfd3291e5171660b2a505645f90fa60606b8
Author: Jiaxing Hu <gahing@gahingwoo.com>

accel/rocket: add RK3576 NPU (RKNN) support

This commit adds RK3576 support to the rocket DRM accelerator driver. It
introduces new clocks, power domains, and a polled completion mechanism
since the RK3576 has no maskable completion interrupt.

> diff --git a/drivers/accel/rocket/rocket_core.c b/drivers/accel/rocket/ro=
cket_core.c
> index b3b2fa9ba645a..140e37969a7b1 100644
> --- a/drivers/accel/rocket/rocket_core.c
> +++ b/drivers/accel/rocket/rocket_core.c
> @@ -65,6 +83,23 @@ int rocket_core_init(struct rocket_core *core)
>  		return err;
>  	}
> =20
> +	/*
> +	 * RK3576: the NPU spans TWO power domains (PD_NPU0 + PD_NPU1).
> [ ... ]
> +	if (core->soc->multi_power_domain) {
> +		struct dev_pm_domain_list *pd_list;
> +
> +		err =3D devm_pm_domain_attach_list(dev, NULL, &pd_list);
> +		if (err < 0)
> +			return dev_err_probe(dev, err,
> +					     "failed to attach NPU power domains\n");
> +	}
> +

[Severity: High]
Does this early return leak resources?

In rocket_core_init(), rocket_job_init() is called earlier, which allocates
non-devm resources such as an ordered workqueue and a DRM scheduler.

If devm_pm_domain_attach_list() fails, the function returns directly with
dev_err_probe() and skips the necessary rocket_job_fini() and
iommu_group_put() cleanup.

> diff --git a/drivers/accel/rocket/rocket_drv.c b/drivers/accel/rocket/roc=
ket_drv.c
> --- a/drivers/accel/rocket/rocket_drv.c
> +++ b/drivers/accel/rocket/rocket_drv.c
> @@ -260,7 +276,7 @@ static int rocket_device_runtime_suspend(struct devic=
e *dev)
>  	if (!rocket_job_is_idle(&rdev->cores[core]))
>  		return -EBUSY;
> =20
> -	clk_bulk_disable_unprepare(ARRAY_SIZE(rdev->cores[core].clks), rdev->co=
res[core].clks);
> +	clk_bulk_disable_unprepare(rdev->cores[core].soc->num_clks, rdev->cores=
[core].clks);
> =20

[Severity: High]
This is a pre-existing issue, but does this power down the device without
synchronizing the shared IRQ?

Since the driver uses IRQF_SHARED, another device sharing the IRQ line could
trigger the interrupt handler just as the clocks are being disabled.

Can this race condition cause the IRQ handler to execute on powered-down
hardware, potentially leading to a kernel panic? Should we call
synchronize_irq() before turning off the clocks?

> diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/roc=
ket_job.c
> --- a/drivers/accel/rocket/rocket_job.c
> +++ b/drivers/accel/rocket/rocket_job.c
> @@ -326,12 +360,55 @@ static struct dma_fence *rocket_job_run(struct drm_=
sched_job *sched_job)
> [ ... ]
> +static void rocket_job_handle_irq(struct rocket_core *core)
> +{
> +	u32 clear =3D 0x1ffff;
> +
> +	if (core->soc->poll_completion) {
> +		/* Stop the completion poll -- we're handling it now. */
> +		atomic_set(&core->poll_active, 0);
> +		hrtimer_cancel(&core->poll_timer);
> +		clear |=3D PC_INTERRUPT_MASK_RK3576_PC_DONE_0 |
> +			 PC_INTERRUPT_MASK_RK3576_PC_DONE_1;
> +	}
> +
>  	pm_runtime_mark_last_busy(core->dev);
> =20
>  	rocket_pc_writel(core, OPERATION_ENABLE, 0x0);
> -	rocket_pc_writel(core, INTERRUPT_CLEAR, 0x1ffff);
> +	rocket_pc_writel(core, INTERRUPT_CLEAR, clear);
> =20

[Severity: High]
Can a DMA error on RK3576 trigger a race condition that corrupts hardware
state?

On RK3576, a DMA error drops OPERATION_ENABLE to 0 and raises a DMA error
interrupt. This simultaneously triggers the threaded IRQ handler and the
poll timer workqueue, which will both see OPERATION_ENABLE =3D=3D 0.

Both threads will concurrently invoke rocket_job_handle_irq(). Because this
function clears OPERATION_ENABLE outside the job_lock, one thread can write
0 to OPERATION_ENABLE right after the other thread has already submitted the
next job and written 1.

Does this permanently halt the hardware by leaving the newly submitted job
disabled?

>  	scoped_guard(mutex, &core->job_lock)
>  		if (core->in_flight_job) {
> [ ... ]
>  			iommu_detach_group(NULL, iommu_group_get(core->dev));

[Severity: High]
This is a pre-existing issue, but does this leak the IOMMU group reference?

The call to iommu_group_get() increments the reference count, but
iommu_detach_group() does not consume or release it.

Since job completion is a hot path, will this quickly overflow the refcount
or leak memory? Should the driver just use the already cached
core->iommu_group instead?

> @@ -424,9 +514,22 @@ static irqreturn_t rocket_job_irq_handler(int irq, v=
oid *data)
>  {
>  	struct rocket_core *core =3D data;
>  	u32 raw_status =3D rocket_pc_readl(core, INTERRUPT_RAW_STATUS);

[Severity: High]
This is a pre-existing issue, but can this unconditional MMIO read cause a
bus fault if the device is suspended?

Because the driver uses IRQF_SHARED, another device could trigger
rocket_job_irq_handler() while the NPU is runtime suspended and powered dow=
n.
Reading from a powered-down device typically returns garbage data or causes=
 a
synchronous external abort.

Should we use pm_runtime_get_if_active() to verify the device is powered
before touching MMIO registers?

> @@ -486,6 +593,10 @@ int rocket_job_init(struct rocket_core *core)
> [ ... ]
>  err_sched:
>  	drm_sched_fini(&core->sched);

[Severity: High]
This is a pre-existing issue, but can calling drm_sched_fini() here cause a
kernel panic?

If drm_sched_init() fails internally (e.g., due to memory allocation failur=
e),
the waitqueues and lists inside the scheduler structure are left uninitiali=
zed.
When we jump to the err_sched label, drm_sched_fini() will unconditionally
try to wake up these uninitialized waitqueues.

> @@ -486,6 +593,10 @@ int rocket_job_init(struct rocket_core *core)
> =20
>  void rocket_job_fini(struct rocket_core *core)
>  {
> +	atomic_set(&core->poll_active, 0);
> +	hrtimer_cancel(&core->poll_timer);
> +	cancel_work_sync(&core->poll_work);
> +
>  	drm_sched_fini(&core->sched);
> =20

[Severity: High]
Is there a teardown order race that allows the hrtimer to be re-armed after
cancellation?

The poll timer and workqueue are cancelled before stopping the DRM schedule=
r.
If a concurrent scheduler thread pulls a pending job and calls
rocket_job_hw_submit(), it will restart poll_timer.

Can this lead to a use-after-free when the timer fires on freed memory after
teardown completes? Should we stop the scheduler before cancelling the time=
r?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260718031146.3368=
811-1-gahing@gahingwoo.com?part=3D6
