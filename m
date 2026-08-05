Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 265D1C55822
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 07:39:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AD0C10E1F1;
	Wed,  5 Aug 2026 07:39:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Izb44Xz1";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D7AB10E1F1
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 07:39:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0EFC840B4A;
 Wed,  5 Aug 2026 07:39:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58AB71F000E9;
 Wed,  5 Aug 2026 07:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785915543;
 bh=Y3LKJDz1uTdE6lYXc/eMYJz/x3q4FbLXk6ameZ8EB+g=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Izb44Xz1MlmwJgdtYjHlm14PbfUGr/p7wEOA+UEClt83Ip/YsQYhKADyPfKjN3vSI
 MKyKrJdtek5HOatpTtSXXuIb5EhkySFRHqQE6MxFejKwz2pzC6kaunPr2Jrpt14Lcu
 6hAXoR0LRei7Gi3a32I1heiDAOSXdxFtp1GVZWwB3iPuHCueUq5C7ovaUm0ugfx45V
 wL/pVorOzkE2zrZN5Gx4C2nzZUwylyZUPj3fxopjcOWqgZD1/zH5/DnKcWskntTdUS
 Lkjd9L5wc9kz4JoNyMENJo9A4fCIfytoQoxX1tvN2YvGL6R92AQmhOZNQBxn77T4hz
 DPvnhsMmlBVWw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v5 v5 6/8] accel/rocket: add RK3576 NPU (RKNN) support
To: "Jiaxing Hu" <gahing@gahingwoo.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260805063826.95682-7-gahing@gahingwoo.com>
References: <20260805063826.95682-1-gahing@gahingwoo.com>
 <20260805063826.95682-7-gahing@gahingwoo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 07:39:02 +0000
Message-Id: <20260805073903.58AB71F000E9@smtp.kernel.org>
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

New issues:
- [High] Hardware reset triggered while polling timer and workqueue are sti=
ll active.
- [High] Unclocked MMIO writes in `rocket_poll_work_fn` due to stale sequen=
ce numbers.
- [High] Bypassing job completion in `rocket_poll_work_fn` during teardown =
leads to deadlocks and resource leaks.
- [High] Concurrent execution of `rocket_poll_work_fn` and `rocket_job_hand=
le_irq` corrupts hardware state and skips tasks.
- [High] Late hardware interrupts re-arm the polling timer after teardown, =
causing a Use-After-Free.

Pre-existing issues:
- [High] Unclocked MMIO access in shared IRQ handler (`rocket_job_irq_handl=
er`).
- [High] Reset workqueue can be used after destruction due to late IRQ firi=
ng.
- [High] IOMMU group reference leak on every job completion.
- [High] DRM device is registered and exposed to userspace before core hard=
ware and schedulers are initialized.
- [High] Unbinding a non-terminal core corrupts `rdev->num_cores` and leads=
 to state overwrite.
--

--- Patch [6]: [RFC PATCH v5 v5 6/8] accel/rocket: add RK3576 NPU (RKNN) su=
pport ---
commit 49430ea8bb109098d159ff322aab30ccbfc4c20a
Author: Jiaxing Hu <gahing@gahingwoo.com>

accel/rocket: add RK3576 NPU (RKNN) support

The RK3576 carries the same RKNN block as the RK3588, with two cores
instead of three and a few platform differences: The patch adds RK3576
support, managing its separate clock domains, power domains, and polling
the completion interrupt via an hrtimer.

> diff --git a/drivers/accel/rocket/rocket_device.c b/drivers/accel/rocket/=
rocket_device.c
> --- a/drivers/accel/rocket/rocket_device.c
> +++ b/drivers/accel/rocket/rocket_device.c
> @@ -31,6 +31,10 @@ struct rocket_device *rocket_device_init(struct platfo=
rm_device *pdev,

[ ... ]

>  	err =3D drm_dev_register(ddev, 0);
>  	if (err)
>  		return ERR_PTR(err);
> =20
>  	return rdev;
>  }

[Severity: High]
This is a pre-existing issue, but does rocket_device_init() expose the
DRM device to userspace before the hardware is actually ready?

It looks like drm_dev_register() is called here, exposing the device,
but rocket_probe() only initializes the core hardware and schedulers via
rocket_core_init() afterward. Could userspace race to open the device and
submit jobs before the schedulers and memory maps are initialized?

> diff --git a/drivers/accel/rocket/rocket_drv.c b/drivers/accel/rocket/roc=
ket_drv.c
> --- a/drivers/accel/rocket/rocket_drv.c
> +++ b/drivers/accel/rocket/rocket_drv.c
> @@ -176,6 +176,7 @@ static int rocket_probe(struct platform_device *pdev)
> =20
>  	rdev->cores[core].rdev =3D rdev;
>  	rdev->cores[core].dev =3D &pdev->dev;
> +	rdev->cores[core].soc =3D of_device_get_match_data(&pdev->dev);
>  	rdev->cores[core].index =3D core;
> =20
>  	rdev->num_cores++;

[Severity: High]
This is a pre-existing issue, but does the core removal logic in
rocket_remove() corrupt the device state if a non-terminal core is unbound?

If rocket_remove() is called for core 0 on a 2-core setup, it blindly
decrements rdev->num_cores to 1. If another core is then bound,
rocket_probe() will use rdev->num_cores (1) as the index, overwriting the
active rdev->cores[1] structure currently in use.

> diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/roc=
ket_job.c
> --- a/drivers/accel/rocket/rocket_job.c
> +++ b/drivers/accel/rocket/rocket_job.c

[ ... ]

> +static enum hrtimer_restart rocket_poll_timer_fn(struct hrtimer *timer)
> +{
> +	struct rocket_core *core =3D container_of(timer, struct rocket_core, po=
ll_timer);
> +	u32 raw;
> +
> +	if (!atomic_read(&core->poll_active))
> +		return HRTIMER_NORESTART;
> +
> +	core->poll_work_seq =3D core->poll_seq;
> +
> +	raw =3D rocket_pc_readl(core, INTERRUPT_RAW_STATUS);

[Severity: High]
Can the hardware reset logic race with this polling timer and workqueue?

When a job times out, the DRM scheduler calls rocket_reset(), which
triggers rocket_core_reset() without first stopping the active poll timer
or work. If the timer fires or the work executes concurrently, will they
attempt to read or write MMIO registers on a device undergoing reset or
without active clocks?

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
> +/* Start the job's next task, or retire it. Caller holds job_lock. */
> +static void rocket_job_next_locked(struct rocket_core *core)
> +{
> +	lockdep_assert_held(&core->job_lock);
> +
> +	if (!core->in_flight_job)
> +		return;
> +
> +	if (core->in_flight_job->next_task_idx < core->in_flight_job->task_coun=
t) {
> +		rocket_job_hw_submit(core, core->in_flight_job);
> +		return;
> +	}
> +
> +	iommu_detach_group(NULL, iommu_group_get(core->dev));

[Severity: High]
This is a pre-existing issue, but does calling iommu_group_get() here leak=
=20
the IOMMU group reference?

It appears iommu_group_get() acquires a reference that is passed to
iommu_detach_group(), but iommu_detach_group() does not consume the
reference, and there is no matching iommu_group_put(). Will this cause the
reference count to overflow or permanently pin IOMMU resources?

> +	dma_fence_signal(core->in_flight_job->done_fence);
> +	pm_runtime_put_autosuspend(core->dev);
> +	core->in_flight_job =3D NULL;
> +}
> +
> +static void rocket_poll_work_fn(struct work_struct *work)
> +{
> +	struct rocket_core *core =3D container_of(work, struct rocket_core, pol=
l_work);
> +
> +	pm_runtime_mark_last_busy(core->dev);
> +
> +	scoped_guard(mutex, &core->job_lock) {
> +		/*
> +		 * The interrupt can land while this work is queued, retire the job
> +		 * and start the next task. poll_seq only moves under job_lock, in
> +		 * hw_submit, so comparing it here says whether that happened. Doing
> +		 * it outside the lock would leave the window open rather than close
> +		 * it, and this work would then submit a task on top of a live one.
> +		 */
> +		if (READ_ONCE(core->poll_dying) || core->poll_work_seq !=3D core->poll=
_seq)
> +			return;

[Severity: High]
Does returning early here on poll_dying cause a resource leak and deadlock?

If poll_work_fn() returns early without calling rocket_job_next_locked(), it
looks like the done_fence of the currently executing job is never signaled,
the PM runtime reference is never released, and the IOMMU group is never
detached.

[Severity: High]
Can this sequence check incorrectly pass if the last task of a job completes
via a shared IRQ?

If rocket_job_handle_irq() finishes the last task, it drops the PM runtime
reference and clears in_flight_job. However, because rocket_job_hw_submit()
isn't called, poll_seq is not updated.

When this work function subsequently runs, it passes the sequence check
(poll_work_seq =3D=3D poll_seq) and proceeds to write to hardware. Since the
PM reference was already dropped, could this cause a fatal unclocked MMIO
access?

> +
> +		rocket_pc_writel(core, OPERATION_ENABLE, 0x0);
> +		rocket_pc_writel(core, INTERRUPT_CLEAR, 0x1ffff);
> +
> +		rocket_job_next_locked(core);
> +	}
> +}
> +
>  static void rocket_job_handle_irq(struct rocket_core *core)
>  {
> +	if (core->soc->poll_completion) {
> +		atomic_set(&core->poll_active, 0);
> +		hrtimer_cancel(&core->poll_timer);
> +	}
> +
>  	pm_runtime_mark_last_busy(core->dev);
> =20
>  	rocket_pc_writel(core, OPERATION_ENABLE, 0x0);

[Severity: High]
Can this hardware write outside the job_lock race with task submission?

The rocket_job_handle_irq() function writes 0 to OPERATION_ENABLE before
acquiring the job_lock. If poll_work_fn() is concurrently inside the lock
submitting the next task (which sets OPERATION_ENABLE to 1), the IRQ handler
can immediately overwrite it to 0, disabling the new task.

The IRQ handler would then acquire job_lock and call rocket_job_next_locked=
(),
which retires the newly started task without it ever executing.

>  	rocket_pc_writel(core, INTERRUPT_CLEAR, 0x1ffff);
> =20
>  	scoped_guard(mutex, &core->job_lock)
> -		if (core->in_flight_job) {
> -			if (core->in_flight_job->next_task_idx < core->in_flight_job->task_co=
unt) {
> -				rocket_job_hw_submit(core, core->in_flight_job);
> -				return;
> -			}
> -
> -			iommu_detach_group(NULL, iommu_group_get(core->dev));
> -			dma_fence_signal(core->in_flight_job->done_fence);
> -			pm_runtime_put_autosuspend(core->dev);
> -			core->in_flight_job =3D NULL;
> -		}
> +		rocket_job_next_locked(core);
>  }

[ ... ]

> @@ -460,6 +540,10 @@ int rocket_job_init(struct rocket_core *core)
>  	int ret;
> =20
>  	INIT_WORK(&core->reset.work, rocket_reset_work);
> +	INIT_WORK(&core->poll_work, rocket_poll_work_fn);
> +	hrtimer_setup(&core->poll_timer, rocket_poll_timer_fn, CLOCK_MONOTONIC,
> +		      HRTIMER_MODE_REL);
> +	atomic_set(&core->poll_active, 0);
>  	spin_lock_init(&core->fence_lock);
>  	mutex_init(&core->job_lock);
> =20
> @@ -501,8 +585,23 @@ int rocket_job_init(struct rocket_core *core)

[Severity: High]
This is a pre-existing issue, but does the shared IRQ handler perform
unclocked MMIO access?

The rocket_job_irq_handler (which calls rocket_job_handle_irq) is registered
with IRQF_SHARED. If it reads INTERRUPT_RAW_STATUS immediately without
checking if the device's power domain and clocks are active, a shared
interrupt firing while the NPU is runtime suspended could cause a
synchronous external abort.

>  void rocket_job_fini(struct rocket_core *core)
>  {
> +	/*
> +	 * Stop the poll from starting hardware work before tearing anything
> +	 * down: it submits the next task, and drm_sched_fini() does not wait
> +	 * for work already queued. Cancel after the scheduler is gone, so a
> +	 * job running now cannot re-arm the timer behind the cancel.
> +	 */
> +	if (core->soc->poll_completion)
> +		WRITE_ONCE(core->poll_dying, true);
> +
>  	drm_sched_fini(&core->sched);
> =20
> +	if (core->soc->poll_completion) {
> +		atomic_set(&core->poll_active, 0);
> +		hrtimer_cancel(&core->poll_timer);
> +		cancel_work_sync(&core->poll_work);
> +	}

[Severity: High]
Can a late hardware interrupt re-arm the polling timer after teardown?

While hrtimer_cancel() is called here, the hardware IRQ is not disabled.
If an interrupt fires after this point, rocket_job_handle_irq() will execut=
e,
progress the job, and call rocket_job_hw_submit(), which re-arms the timer
via hrtimer_start().

Once the rocket_core structure is freed, could the armed timer fire and
access freed memory?

> +
>  	cancel_work_sync(&core->reset.work);
>  	destroy_workqueue(core->reset.wq);
>  }

[Severity: High]
This is a pre-existing issue, but can the reset workqueue be used after it
is destroyed?

Because the shared IRQ remains active until devres cleans it up after
rocket_remove(), a late interrupt hitting the MAC interrupt condition could
call queue_work() on this destroyed workqueue, leading to a kernel panic.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805063826.9568=
2-1-gahing@gahingwoo.com?part=3D6
