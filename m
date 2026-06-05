Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8934CD6E7D
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 16:20:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F342E112BA3;
	Fri,  5 Jun 2026 16:20:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MryrAQLP";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C6EF112BA3
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 16:20:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1D6464188E;
 Fri,  5 Jun 2026 16:20:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E00F21F00893;
 Fri,  5 Jun 2026 16:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780676413;
 bh=SCc1ED0run+JRAhTWcRHKA3Hnu+U58j2PJkQLMPgNfA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=MryrAQLPU+Sz0LsrNPBV5WSpviXTHZxlIfgn9k/RGKHshAkdogFxWFtNhk1rle251
 98NEYWSLyYM1iB5xliPg5L3yejPsga+PYS2dGkhj7W5RV8qDU4BJzLEI2ILrooqTiO
 Gopc1G8hrHGd4X/bW3kXOqLDeTUHr8UaRjaEXek9DAj9AR9hJPZa9oSQESkavPaxKH
 zG4gvTMRbWm7FYELmMf12xAsbhRkLvOJDAOE2BcjYBjWCoSlhHTqhj4Mg6LH4oir3T
 7Q27gQMyhJH/j3F8/qAkEV4AVmEAHcZBAHETO2URPjrxGj21tfC1tlGjsdgq0tw5k6
 sJBeFlMunigJA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] drm/rocket: Submit one drm_sched_job per task
To: =?utf-8?b?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260605-rocket-per-task-jobs-v1-2-e3319adf3c49@igalia.com>
References: <20260605-rocket-per-task-jobs-v1-2-e3319adf3c49@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 16:20:12 +0000
Message-Id: <20260605162012.E00F21F00893@smtp.kernel.org>
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
- [Critical] Splitting an inference into independent `drm_sched_job` tasks =
breaks IOMMU domain isolation due to DRM scheduler interleaving.
- [High] Implicit BO dependencies are incorrectly anchored to the last task=
 of an inference instead of the first, causing premature hardware execution.
- [High] IOMMU detachment in `rocket_job_cleanup()` races with the executio=
n of the next inference because the ioctl thread holds the final kref.
- [High] If a task fails to start in `rocket_job_run()`, the rest of the in=
ference is not cancelled, leading to partial out-of-sequence execution.

Pre-existing issues:
- [Critical] Unconditional call to `rocket_iommu_domain_put()` in `rocket_j=
ob_cleanup()` causes a NULL pointer dereference if job initialization fails=
 early.
- [High] The IRQ handler accesses NPU registers before claiming the in-flig=
ht task, risking a hardware fault if the device has been reset concurrently.
- [High] The driver silently ignores failures of individual job submissions=
 in `rocket_ioctl_submit`.
--

commit ea82a8e8306fe83c325efae485834200ae29aec9
Author: Ma=C3=ADra Canal <mcanal@igalia.com>
Subject: drm/rocket: Submit one drm_sched_job per task

This commit redesigns the job submission path so each task is its own
drm_sched_job. It ensures all submissions flow through the DRM scheduler
so the reset path can serialize against hardware execution, while holding
an inference refcount across tasks.

> diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/roc=
ket_job.c
> --- a/drivers/accel/rocket/rocket_job.c
> +++ b/drivers/accel/rocket/rocket_job.c

[ ... ]

> @@ -186,43 +170,68 @@ static int rocket_job_push(struct rocket_job *job)
>  	struct drm_gem_object **bos;
>  	struct ww_acquire_ctx acquire_ctx;
> -	int ret =3D 0;
> +	int ret, i;
> =20
> -	bos =3D kvmalloc_array(job->in_bo_count + job->out_bo_count, sizeof(voi=
d *),
> -			     GFP_KERNEL);
> +	bos =3D kvmalloc_array(bo_count, sizeof(void *), GFP_KERNEL);
> +	if (!bos) {
> +		ret =3D -ENOMEM;
> +		goto err_cleanup_tasks;
> +	}
>  	memcpy(bos, job->in_bos, job->in_bo_count * sizeof(void *));
>  	memcpy(&bos[job->in_bo_count], job->out_bos, job->out_bo_count * sizeof=
(void *));
> =20
> -	ret =3D drm_gem_lock_reservations(bos, job->in_bo_count + job->out_bo_c=
ount, &acquire_ctx);
> +	ret =3D drm_gem_lock_reservations(bos, bo_count, &acquire_ctx);
> +	if (ret)
> +		goto err_free_bos;
> +
> +	/* Anchor the BO synchronization on the last task: its finished fence is
> +	 * the inference's completion fence.
> +	 */
> +	ret =3D rocket_acquire_object_fences(job->in_bos, job->in_bo_count,
> +					   &last->base, false);

[Severity: High]
Does anchoring the input dependencies to the last task allow the first
task to run before the input buffers are ready?

Since the DRM scheduler uses these dependencies to know when a job is
ready to run, adding them to last->base leaves job->tasks[0] without
dependencies.

The scheduler might submit the first task to the hardware immediately,
causing a read-before-write data race. Should the input dependencies be
anchored to the first task instead?

[ ... ]

> @@ -233,10 +242,22 @@ static void rocket_job_cleanup(struct kref *ref)
>  						refcount);
>  	unsigned int i;
> =20
> +	/*
> +	 * The last task holding a reference is gone, so the inference is over.
> +	 * The ordered scheduler workqueue runs this (from free_job()) before
> +	 * the next inference's run_job(), so the core's IOMMU group is free
> +	 * in time for it.
> +	 */
> +	if (job->core)
> +		iommu_detach_group(NULL, job->core->iommu_group);

[Severity: High]
Can this detachment race with the execution of a subsequent inference?

The ioctl thread initializes the inference refcount to 1 and drops it at
the end of rocket_ioctl_submit_job(). If the scheduler finishes all tasks
quickly, it drops its references, leaving the refcount at 1.

The scheduler might then start the next inference, which attaches its own
IOMMU domain. If the ioctl thread then wakes up and drops its final
reference, rocket_job_cleanup() will call iommu_detach_group().

Could this unmap the IOMMU while the next inference is actively executing
on the hardware?

> +
>  	rocket_iommu_domain_put(job->domain);

[Severity: Critical]
This is a pre-existing issue, but does this unconditionally dereference
the domain pointer?

If an error occurs early in rocket_ioctl_submit_job() (for example, if
rocket_copy_tasks() fails), the error path calls rocket_job_put(rjob)
and triggers cleanup before job->domain is initialized.

Since rocket_iommu_domain_put() internally executes
kref_put(&domain->kref, ...), passing a NULL pointer here will cause a
kernel panic. Should this check if job->domain is valid before putting it?

[ ... ]

> @@ -286,108 +307,102 @@ static struct dma_fence *rocket_job_run(struct dr=
m_sched_job *sched_job)
>  	struct rocket_core *core =3D sched_to_core(rdev, sched_job->sched);
>  	struct dma_fence *fence =3D NULL;
>  	int ret;
[ ... ]
> -	ret =3D pm_runtime_get_sync(core->dev);
> -	if (ret < 0)
> -		return fence;
> +	ret =3D pm_runtime_resume_and_get(core->dev);
> +	if (ret < 0) {
> +		dma_fence_put(fence);
> +		return ERR_PTR(ret);
> +	}

[Severity: High]
If pm_runtime_resume_and_get() or iommu_attach_group() fails and returns
an ERR_PTR, does the rest of the inference still execute?

The scheduler will complete this failed task with an error, but it appears
the job->cancelled flag is not set on these early failure paths.

Since subsequent tasks in the same inference will not observe the cancelled
flag, will they be submitted out of order, potentially leaving the hardware
in an invalid state?

> =20
> -	ret =3D iommu_attach_group(job->domain->domain, core->iommu_group);
> -	if (ret < 0)
> -		return fence;
> +	/* Attach the domain once for the whole inference. */
> +	if (!job->core) {
> +		ret =3D iommu_attach_group(job->domain->domain, core->iommu_group);

[Severity: Critical]
Does attaching the IOMMU domain only for the first task break isolation
when the scheduler interleaves tasks?

With the redesign mapping each task to a separate drm_sched_job, the DRM
scheduler can interleave tasks from different inferences on the same core.

If Process A's first task attaches its domain and then Process B's first
task attaches its domain, Process A's second task will see job->core is
already set.

Will Process A's second task then execute using Process B's IOMMU domain,
allowing cross-process memory access?

[ ... ]

> @@ -395,20 +409,20 @@ static void rocket_job_handle_irq(struct rocket_cor=
e *core)
>  {
> +	struct rocket_task *task;
> +
>  	pm_runtime_mark_last_busy(core->dev);
> =20
>  	rocket_pc_writel(core, OPERATION_ENABLE, 0x0);
>  	rocket_pc_writel(core, INTERRUPT_CLEAR, 0x1ffff);
> =20
> -	scoped_guard(mutex, &core->job_lock)
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
> +	/*
> +	 * Claim the in-flight task: the reset path may run concurrently, so
> +	 * whichever of us wins owns the PM put.
> +	 */
> +	task =3D xchg(&core->in_flight_task, NULL);

[Severity: High]
This is a pre-existing issue, but does writing to these registers before
claiming the in-flight task risk a hardware fault?

If a timeout occurs concurrently, rocket_reset() can claim the task, drop
the PM reference, and reset the hardware.

If this threaded IRQ handler then writes to the OPERATION_ENABLE and
INTERRUPT_CLEAR registers while the device is powered down or mid-reset,
could it trigger a bus error?

Should the handler claim the task first to guarantee the device is awake?

[ ... ]

>  int rocket_ioctl_submit(struct drm_device *dev, void *data, struct drm_f=
ile *file)
>  {
[ ... ]
>  	for (i =3D 0; i < args->job_count; i++)
>  		rocket_ioctl_submit_job(dev, file, &jobs[i]);
> =20
>  exit:
>  	kvfree(jobs);
> =20
>  	return ret;
>  }

[Severity: High]
This is a pre-existing issue, but is the return value of
rocket_ioctl_submit_job() intentionally ignored here?

If an individual job fails to submit due to an out-of-memory error or
invalid BO handles, the failure is neither checked nor accumulated.

Since user space will receive a success return code (ret =3D 0), does this
hide submission failures?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605-rocket-per=
-task-jobs-v1-0-e3319adf3c49@igalia.com?part=3D2
