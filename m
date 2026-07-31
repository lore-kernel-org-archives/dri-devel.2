Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EFEBC54F54
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 04:54:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9705D10E1A5;
	Fri, 31 Jul 2026 04:54:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fy1Asf5P";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4CDF10E1A5
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 04:54:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 16833600C8;
 Fri, 31 Jul 2026 04:54:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E1051F000E9;
 Fri, 31 Jul 2026 04:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785473671;
 bh=0EsrDrFGaTX4V8d9Wn7ip8F6psMO91HC/1jjQpfrEKE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=fy1Asf5P3EoQdjrv62rybttWDt/sM8rxRJROkatjuZMkj9RjRfnFCe1C6Q+ype0DB
 KSoyija4XyxLtKcQQvRqF+06AhQkk7sZkhjNN7JrCqALDi14OyKsvargi7rnq1qeq9
 Vso8eP5upchaLxub1kOb8kchqH2EvqNyfhKC8kZBrgWMHhVddD2K1F8OJLpNh4/NAK
 5l+H0YG0XshjfgeFhaUnHWw0JmVf+UrR6dK8eg9K+NYNSzZreIKpsC5o6bsVN73Cwo
 uZQHFwc0jMDUi9IKSTID+nc0bQf7N+dqP1e+Tm7AfUUk1jpN+uXLYJCegg8Jk4/7/V
 37NiHt+e3PTMQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 4/6] accel/rocket: add RK3576 NPU (RKNN) support
To: "Jiaxing Hu" <gahing@gahingwoo.com>
Cc: devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260731043507.1832277-5-gahing@gahingwoo.com>
References: <20260731043507.1832277-1-gahing@gahingwoo.com>
 <20260731043507.1832277-5-gahing@gahingwoo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 04:54:31 +0000
Message-Id: <20260731045431.7E1051F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Missing teardown of `poll_timer` and `poll_work` causes use-after-=
free on module unload or device teardown.
- [High] Stale `poll_work` execution can prematurely complete and corrupt n=
ewly submitted jobs because pending work is not cancelled.

Pre-existing issues:
- [High] The shared IRQ handler accesses hardware registers without ensurin=
g the device is active, causing potential crashes if the device is suspende=
d.
- [High] Unbalanced `iommu_group_get()` leaks an IOMMU group reference on e=
very job completion.
--

--- Patch [4]: [RFC PATCH v3 4/6] accel/rocket: add RK3576 NPU (RKNN) suppo=
rt ---
commit dd0a45989eab5a4ff6b90c355a58e175aad35c8f
Author: Jiaxing Hu <gahing@gahingwoo.com>

accel/rocket: add RK3576 NPU (RKNN) support
   =20
The RK3576 carries the same RKNN block as the RK3588, with two cores
instead of three and a few platform differences:
   =20
 - the CBUF (convolution buffer) has its own clock domain, so the core
   needs six clocks rather than four;
 - the BIU reset moved into the power domain, leaving one reset here;
 - the NPU spans two power domains, and a device with more than one is
   skipped by the driver-core single-domain auto-attach, so the list has
   to be attached explicitly;
 - the DPU completion interrupt is armed exactly as on RK3588 but never
   reaches the GIC. The completion is visible in INTERRUPT_RAW_STATUS,
   so sample that from an hrtimer rather than wait for an interrupt that
   does not come. The interrupt stays armed, so if it ever does arrive
   the normal handler finalises the job first.
   =20
Select all of that from of_device_id match data so the RK3588 path keeps
its existing counts and behaviour unchanged.

> diff --git a/drivers/accel/rocket/rocket_drv.c b/drivers/accel/rocket/roc=
ket_drv.c
> index 8bbbce594883e..7f7dfa3742fc8 100644
> --- a/drivers/accel/rocket/rocket_drv.c
> +++ b/drivers/accel/rocket/rocket_drv.c
[ ... ]
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
>  	return 0;
>  }

[Severity: High]
This is a pre-existing issue, but can the shared IRQ handler crash if it ru=
ns
while the device is suspended?

The NPU driver registers its interrupt handler rocket_job_irq_handler() with
IRQF_SHARED. The hardirq handler unconditionally reads the
INTERRUPT_RAW_STATUS MMIO register without calling pm_runtime_get_if_active=
().

Additionally, rocket_device_runtime_suspend() disables hardware clocks here
without calling synchronize_irq().

If another device sharing the IRQ line triggers an interrupt while the NPU
is runtime-suspended, the handler will attempt to read powered-down hardwar=
e.
Should the suspend callback use synchronize_irq() and the IRQ handler verify
the device is active?

> diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/roc=
ket_job.c
> index bb77b6bf0f231..e9103a93020cc 100644
> --- a/drivers/accel/rocket/rocket_job.c
> +++ b/drivers/accel/rocket/rocket_job.c
[ ... ]
> @@ -341,8 +358,42 @@ static struct dma_fence *rocket_job_run(struct drm_s=
ched_job *sched_job)
>  	return ERR_PTR(ret);
>  }
> =20
> +static void rocket_job_handle_irq(struct rocket_core *core);
> +
> +static enum hrtimer_restart rocket_poll_timer_fn(struct hrtimer *timer)
> +{
> +	struct rocket_core *core =3D container_of(timer, struct rocket_core, po=
ll_timer);
> +	u32 raw;
> +
> +	if (!atomic_read(&core->poll_active))
> +		return HRTIMER_NORESTART;
> +
> +	raw =3D rocket_pc_readl(core, INTERRUPT_RAW_STATUS);
> +	if ((raw & (PC_INTERRUPT_RAW_STATUS_DPU_0 | PC_INTERRUPT_RAW_STATUS_DPU=
_1)) ||
> +	    ++core->poll_ticks >=3D RK3576_POLL_MAX_TICKS) {
> +		atomic_set(&core->poll_active, 0);
> +		schedule_work(&core->poll_work);
> +		return HRTIMER_NORESTART;
> +	}
> +
> +	hrtimer_forward_now(timer, ns_to_ktime(RK3576_POLL_INTERVAL_NS));
> +	return HRTIMER_RESTART;
> +}
> +
> +static void rocket_poll_work_fn(struct work_struct *work)
> +{
> +	struct rocket_core *core =3D container_of(work, struct rocket_core, pol=
l_work);
> +
> +	rocket_job_handle_irq(core);
> +}
> +
>  static void rocket_job_handle_irq(struct rocket_core *core)
>  {
> +	if (core->soc->poll_completion) {
> +		atomic_set(&core->poll_active, 0);
> +		hrtimer_cancel(&core->poll_timer);
> +	}
> +

[Severity: High]
Can a stale poll_work execution corrupt the next job?

If a real hardware IRQ arrives after poll_timer queues poll_work, the real
IRQ handles the completion and cancels the timer here. However, poll_work
could remain pending in the workqueue.

The DRM scheduler could then immediately submit the next job. When the stale
poll_work executes, it calls rocket_job_handle_irq() which would incorrectly
mark the new job as finished, signal its completion fence early, detach its
IOMMU group, and halt the hardware.

Does the driver need a way to cancel the pending work or ignore it if it is
no longer relevant, both here and in rocket_reset()?

[Severity: High]
This is a pre-existing issue, but does this function leak an IOMMU group
reference on every job completion?

Further down in rocket_job_handle_irq(), the code calls:

	iommu_detach_group(NULL, iommu_group_get(core->dev));

The iommu_group_get() function increments the kobject reference count, but
iommu_detach_group() does not consume it. Because there is no matching
iommu_group_put(), a reference is leaked every time a job finishes. Should
this use the existing core->iommu_group pointer instead?

>  	pm_runtime_mark_last_busy(core->dev);
> =20
>  	rocket_pc_writel(core, OPERATION_ENABLE, 0x0);
[ ... ]
> @@ -460,6 +511,10 @@ int rocket_job_init(struct rocket_core *core)
>  	int ret;
> =20
>  	INIT_WORK(&core->reset.work, rocket_reset_work);
> +	INIT_WORK(&core->poll_work, rocket_poll_work_fn);
> +	hrtimer_setup(&core->poll_timer, rocket_poll_timer_fn, CLOCK_MONOTONIC,
> +		      HRTIMER_MODE_REL);
> +	atomic_set(&core->poll_active, 0);

[Severity: High]
Does this code leak the timer and work on module unload?

Since poll_timer and poll_work are initialized here, shouldn't they be
cancelled in rocket_job_fini() with hrtimer_cancel() and cancel_work_sync()?

Because the rocket_core struct is allocated with devm_kcalloc(), it is freed
shortly after driver removal. If the timer fires or the pending work execut=
es
after the memory is freed, it could cause a use-after-free crash.

>  	spin_lock_init(&core->fence_lock);
>  	mutex_init(&core->job_lock);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731043507.1832=
277-1-gahing@gahingwoo.com?part=3D4
