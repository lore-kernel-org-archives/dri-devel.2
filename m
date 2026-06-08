Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 109F6CD8C9F
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 10:02:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67F3510F0A9;
	Mon,  8 Jun 2026 10:02:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="lG5X6FmJ";
	dkim-atps=neutral
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90BF910F0A9
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 10:02:27 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4gYndr4R9jz9sxR;
 Mon,  8 Jun 2026 12:02:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1780912944; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tbnSj9vwchxFe4Ao/xPkJhQ9KcRu30P2UdUjdt/6nFQ=;
 b=lG5X6FmJdxeE2EKtewEZZlZqI9Sa03aIWjBOxQImo9vS05xHCUGSjdjYspjszau6T5qgzv
 8pQszbMNRBbss6/t7nl12l4pqW2VRUk9GP8cZS/NPm6RD2Y4+FT00rHMfucEHmb6J6ciux
 8I5QPszZFdtFY9Sc0Kmg1tzZhN+reBs24NadZugjaZQDPdwTXuNcwIktogD97JPA7NkBQe
 JGeXWsdCK+a6S+eOYjDZdEury0rtxLh7FLWLdUCfzRVV1PUi0Ih6l4TswEFljRZZq0gUcq
 9Wgu9fY0xlveI690noL9IjpxpOyL9FnPnUXPbkvK8LIIu1jv//u0CIKkgc/Sqw==
Message-ID: <d8d4ffb3488dd2e1950fb1fc291fab68e2d953bb.camel@mailbox.org>
Subject: Re: [PATCH 2/3] drm/rocket: Submit one drm_sched_job per task
From: Philipp Stanner <phasta@mailbox.org>
To: =?ISO-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>, Tomeu Vizoso	
 <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>, Christian
 =?ISO-8859-1?Q?K=F6nig?=	 <christian.koenig@amd.com>, Christian
 =?ISO-8859-1?Q?K=F6nig?=	 <ckoenig.leichtzumerken@gmail.com>, Rob Herring
 <robh@kernel.org>, Matthew Brost <matthew.brost@intel.com>, Danilo
 Krummrich <dakr@kernel.org>, Philipp Stanner	 <phasta@kernel.org>, Sumit
 Semwal <sumit.semwal@linaro.org>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org
Date: Mon, 08 Jun 2026 12:02:19 +0200
In-Reply-To: <20260605-rocket-per-task-jobs-v1-2-e3319adf3c49@igalia.com>
References: <20260605-rocket-per-task-jobs-v1-0-e3319adf3c49@igalia.com>
 <20260605-rocket-per-task-jobs-v1-2-e3319adf3c49@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-META: sys8qigngqjygngasabehxrbdfatdfky
X-MBO-RS-ID: 9104888e592f0c5bf2f
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
Reply-To: phasta@kernel.org
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Hi,

On Fri, 2026-06-05 at 13:06 -0300, Ma=C3=ADra Canal wrote:
> The current submission model breaks the DRM scheduler's design in two
> ways.
>=20
> First, a job spawns further hardware work from outside the scheduler.
> rocket_job_run() submits only the first task of an inference; every
> subsequent task is submitted by the threaded IRQ handler, which calls
> rocket_job_hw_submit() directly.
>  The scheduler expects all of a job's
> hardware submission to happen in run_job(). Driving it from the IRQ
> handler instead is invisible to the scheduler, and drm_sched_stop() only
> synchronizes the scheduler's workqueue, not the threaded IRQ, so the
> reset path races these IRQ-driven submissions. The job_lock mutex and the
> reset.pending flag exist only as a workaround that self-inflicted race.

nit: missing word "for"

>=20
> Second, the submission path returns after arming a job. rocket_job_push()
> calls drm_sched_job_arm() and only then acquires the BO fences, bailing
> out and cleaning the job up if that fails. But arming is a point of no
> return: per its documentation, "Once this function was called, you *must*
> submit @job with drm_sched_entity_push_job()", because it publishes the
> job's fences.

Oh dear. Yeah, got catch.

>=20
> Redesign the submission so each task is its own drm_sched_job, which is
> what the scheduler's model actually expects:
>=20
> =C2=A0 - Every submission to the NPU flows through run_job(), and the IRQ
> =C2=A0=C2=A0=C2=A0 handler only signals the task's fence. Nothing is star=
ted without the
> =C2=A0=C2=A0=C2=A0 knowledge of the scheduler, so it can serialize submis=
sion against
> =C2=A0=C2=A0=C2=A0 reset.

+1

>=20
> =C2=A0 - The BO reservations and implicit dependencies are acquired befor=
e any
> =C2=A0=C2=A0=C2=A0 task is armed, so the only fallible step precedes the =
point of no
> =C2=A0=C2=A0=C2=A0 return.
>=20
> struct rocket_job becomes the refcounted inference shared by its tasks;

If they're now shared, do they also require synchronization?

> struct rocket_task becomes the per-task scheduled unit, and each task
> holds a reference to the inference, so the last task to be freed marks it
> done. Ordering between tasks comes from the per-file entity's FIFO and
> arming all tasks up front pins the inference to one core. The implicit
> BO dependencies and the completion fence are anchored on the last task.
>=20
> The IOMMU domain is attached once by the first task to run and detached
> when the last task drops its reference. On timeout the inference is marke=
d
> cancelled before the scheduler restarts; the remaining tasks observe the
> flag in run_job() and fail with -ECANCELED without touching hardware, so
> only the affected inference is abandoned.
>=20
> With this, the Rocket driver can comply to the DRM scheduler's
> expectations.
>=20
> Signed-off-by: Ma=C3=ADra Canal <mcanal@igalia.com>

Some more fly-by comments below, but not a super deep review:

> ---
> =C2=A0drivers/accel/rocket/rocket_core.h |=C2=A0=C2=A0 5 +-
> =C2=A0drivers/accel/rocket/rocket_job.c=C2=A0 | 257 ++++++++++++++++++++-=
----------------
> =C2=A0drivers/accel/rocket/rocket_job.h=C2=A0 |=C2=A0 26 +++-
> =C2=A03 files changed, 158 insertions(+), 130 deletions(-)
>=20
> diff --git a/drivers/accel/rocket/rocket_core.h b/drivers/accel/rocket/ro=
cket_core.h
> index 4d163a6ac653..f74dc99d07bb 100644
> --- a/drivers/accel/rocket/rocket_core.h
> +++ b/drivers/accel/rocket/rocket_core.h
> @@ -41,14 +41,13 @@ struct rocket_core {
> =C2=A0
> =C2=A0	struct iommu_group *iommu_group;
> =C2=A0
> -	struct mutex job_lock;
> -	struct rocket_job *in_flight_job;
> +	/* Task currently running on the hardware. */
> +	struct rocket_task *in_flight_task;
> =C2=A0
> =C2=A0	spinlock_t fence_lock;
> =C2=A0
> =C2=A0	struct {
> =C2=A0		struct workqueue_struct *wq;
> -		atomic_t pending;
> =C2=A0	} reset;
> =C2=A0
> =C2=A0	struct drm_gpu_scheduler sched;
> diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/roc=
ket_job.c
> index 8a26139a44f4..871041eb7a1d 100644
> --- a/drivers/accel/rocket/rocket_job.c
> +++ b/drivers/accel/rocket/rocket_job.c
> @@ -20,10 +20,10 @@
> =C2=A0
> =C2=A0#define JOB_TIMEOUT_MS 500
> =C2=A0
> -static struct rocket_job *
> -to_rocket_job(struct drm_sched_job *sched_job)
> +static struct rocket_task *
> +to_rocket_task(struct drm_sched_job *sched_job)
> =C2=A0{
> -	return container_of(sched_job, struct rocket_job, base);
> +	return container_of(sched_job, struct rocket_task, base);
> =C2=A0}
> =C2=A0
> =C2=A0static const char *rocket_fence_get_driver_name(struct dma_fence *f=
ence)
> @@ -61,8 +61,6 @@ rocket_copy_tasks(struct drm_device *dev,
> =C2=A0		=C2=A0 struct drm_rocket_job *job,
> =C2=A0		=C2=A0 struct rocket_job *rjob)
> =C2=A0{
> -	int ret =3D 0;
> -
> =C2=A0	if (job->task_struct_size < sizeof(struct drm_rocket_task))
> =C2=A0		return -EINVAL;
> =C2=A0
> @@ -71,7 +69,7 @@ rocket_copy_tasks(struct drm_device *dev,
> =C2=A0	if (!rjob->task_count)
> =C2=A0		return 0;
> =C2=A0
> -	rjob->tasks =3D kvmalloc_objs(*rjob->tasks, job->task_count);
> +	rjob->tasks =3D kvzalloc_objs(*rjob->tasks, job->task_count);
> =C2=A0	if (!rjob->tasks) {
> =C2=A0		drm_dbg(dev, "Failed to allocate task array\n");
> =C2=A0		return -ENOMEM;
> @@ -84,14 +82,12 @@ rocket_copy_tasks(struct drm_device *dev,
> =C2=A0				=C2=A0=C2=A0 u64_to_user_ptr(job->tasks) + i * job->task_struct=
_size,
> =C2=A0				=C2=A0=C2=A0 sizeof(task))) {
> =C2=A0			drm_dbg(dev, "Failed to copy incoming tasks\n");
> -			ret =3D -EFAULT;
> -			goto fail;
> +			return -EFAULT;
> =C2=A0		}
> =C2=A0
> =C2=A0		if (task.regcmd_count =3D=3D 0) {
> =C2=A0			drm_dbg(dev, "regcmd_count field in drm_rocket_task should be > =
0.\n");
> -			ret =3D -EINVAL;
> -			goto fail;
> +			return -EINVAL;
> =C2=A0		}
> =C2=A0
> =C2=A0		rjob->tasks[i].regcmd =3D task.regcmd;
> @@ -99,26 +95,14 @@ rocket_copy_tasks(struct drm_device *dev,
> =C2=A0	}
> =C2=A0
> =C2=A0	return 0;
> -
> -fail:
> -	kvfree(rjob->tasks);
> -	return ret;

Not super obvious to the reader why this is now unnecessary?

Could these changes be a separate patch?

> =C2=A0}
> =C2=A0

[=E2=80=A6]

>=20
> =C2=A0static struct rocket_core *sched_to_core(struct rocket_device *rdev=
,
> @@ -286,108 +307,102 @@ static struct rocket_core *sched_to_core(struct r=
ocket_device *rdev,
> =C2=A0
> =C2=A0static struct dma_fence *rocket_job_run(struct drm_sched_job *sched=
_job)
> =C2=A0{
> -	struct rocket_job *job =3D to_rocket_job(sched_job);
> -	struct rocket_device *rdev =3D job->rdev;
> -	struct rocket_core *core =3D sched_to_core(rdev, sched_job->sched);
> +	struct rocket_task *task =3D to_rocket_task(sched_job);
> +	struct rocket_job *job =3D task->job;
> +	struct rocket_core *core =3D sched_to_core(job->rdev, sched_job->sched)=
;
> =C2=A0	struct dma_fence *fence =3D NULL;
> =C2=A0	int ret;
> =C2=A0
> -	if (unlikely(job->base.s_fence->finished.error))
> +	if (unlikely(sched_job->s_fence->finished.error))
> =C2=A0		return NULL;
> =C2=A0
> -	/*
> -	 * Nothing to execute: can happen if the job has finished while
> -	 * we were resetting the NPU.
> -	 */
> -	if (job->next_task_idx =3D=3D job->task_count)
> +	/* An earlier task of this inference timed out, abandon the inference. =
*/
> +	if (atomic_read(&job->cancelled)) {

I see that you touch some mutexes in this patch. Some seem to
disappear. These atomics stay.

They look a bit racy, too, don't they?

> +		dma_fence_set_error(&sched_job->s_fence->finished, -ECANCELED);
> =C2=A0		return NULL;
> +	}
> =C2=A0
> =C2=A0	fence =3D rocket_fence_create(core);
> =C2=A0	if (IS_ERR(fence))
> =C2=A0		return fence;
> =C2=A0
> -	if (job->done_fence)
> -		dma_fence_put(job->done_fence);
> -	job->done_fence =3D dma_fence_get(fence);
> +	if (task->done_fence)
> +		dma_fence_put(task->done_fence);
> +	task->done_fence =3D dma_fence_get(fence);
> =C2=A0
> -	ret =3D pm_runtime_get_sync(core->dev);
> -	if (ret < 0)
> -		return fence;
> -
> -	ret =3D iommu_attach_group(job->domain->domain, core->iommu_group);
> -	if (ret < 0)
> -		return fence;
> -
> -	scoped_guard(mutex, &core->job_lock) {
> -		core->in_flight_job =3D job;
> -		rocket_job_hw_submit(core, job);
> +	ret =3D pm_runtime_resume_and_get(core->dev);
> +	if (ret < 0) {
> +		dma_fence_put(fence);
> +		return ERR_PTR(ret);
> =C2=A0	}
> =C2=A0
> +	/* Attach the domain once for the whole inference. */
> +	if (!job->core) {
> +		ret =3D iommu_attach_group(job->domain->domain, core->iommu_group);
> +		if (ret < 0) {
> +			pm_runtime_put_autosuspend(core->dev);
> +			dma_fence_put(fence);
> +			return ERR_PTR(ret);
> +		}
> +		job->core =3D core;
> +	}
> +
> +	WRITE_ONCE(core->in_flight_task, task);

The scoped_guard above disappears, and now a WRITE_ONCE appears. Hmm.
The core doesn't have a lock?

> +	rocket_job_hw_submit(core, task);
> +
> =C2=A0	return fence;
> =C2=A0}
> =C2=A0
> =C2=A0static void rocket_job_handle_irq(struct rocket_core *core)
> =C2=A0{
> +	struct rocket_task *task;
> +
> =C2=A0	pm_runtime_mark_last_busy(core->dev);
> =C2=A0
> =C2=A0	rocket_pc_writel(core, OPERATION_ENABLE, 0x0);
> =C2=A0	rocket_pc_writel(core, INTERRUPT_CLEAR, 0x1ffff);
> =C2=A0
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

Why is it sometimes WRITE_ONCE and sometimes xchg?

I don't understand much of rocket's design, but this makes me feel
uncomfortable about the overall locking / synchronization design.


Regards
P.
