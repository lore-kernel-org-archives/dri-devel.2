Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9939FD707A
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 14:55:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 549C310E132;
	Tue, 17 Mar 2026 14:55:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="Qg3oiMOW";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB65D10E132;
 Tue, 17 Mar 2026 14:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1773759317;
 bh=tWKlIu7SwKM4KDECN+4GtTx+puSykJu6NIk8Sqh7Oas=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Qg3oiMOWpfYAT6mxhRVRiGcTqCzAIsl0HWrklZIXItC/sd1LtX0WNVCsLjd+MCN/O
 MvnN1JqzkEtKjjmEroXa1tUowjYEqC1KV0Lkw+BtUnVX3I+jQxQcAaVSgyBh/SEngj
 DuIYyxly3rZvdjpX0KDwlNwFbkiBvwClfV0GS6U1a5jfYDS/aHftvjXts5lBk7Jr5y
 E/blygGm3sAy2C24QrYUfT9WrhrrnE6pZL4+5SGelfw7AqLcPx9Qj0wHedpDJfxV2f
 0qVFQkUa8lZqN222NkqrYREcJ6E8A8/VrcAu2/DDRy+KLGVzz4oUws0D0nS/WDdIfv
 WP9QUQI1s328w==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id EE9F517E026C;
 Tue, 17 Mar 2026 15:55:16 +0100 (CET)
Date: Tue, 17 Mar 2026 15:55:12 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Matthew Brost <matthew.brost@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, Tvrtko
 Ursulin <tvrtko.ursulin@igalia.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Thomas =?UTF-8?B?SGVsbHN0csO2bQ==?= <thomas.hellstrom@linux.intel.com>,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>, Danilo Krummrich
 <dakr@kernel.org>, David Airlie <airlied@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Philipp Stanner <phasta@kernel.org>, Simona Vetter <simona@ffwll.ch>, Sumit
 Semwal <sumit.semwal@linaro.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 02/12] drm/dep: Add DRM dependency queue layer
Message-ID: <20260317155512.7250be13@fedora>
In-Reply-To: <20260316043255.226352-3-matthew.brost@intel.com>
References: <20260316043255.226352-1-matthew.brost@intel.com>
 <20260316043255.226352-3-matthew.brost@intel.com>
Organization: Collabora
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Sun, 15 Mar 2026 21:32:45 -0700
Matthew Brost <matthew.brost@intel.com> wrote:

> +/**
> + * struct drm_dep_fence - fence tracking the completion of a dep job
> + *
> + * Contains a single dma_fence (@finished) that is signalled when the
> + * hardware completes the job. The fence uses the kernel's inline_lock
> + * (no external spinlock required).
> + *
> + * This struct is private to the drm_dep module; external code interacts
> + * through the accessor functions declared in drm_dep_fence.h.
> + */
> +struct drm_dep_fence {
> +	/**
> +	 * @finished: signalled when the job completes on hardware.
> +	 *
> +	 * Drivers should use this fence as the out-fence for a job since it
> +	 * is available immediately upon drm_dep_job_arm().
> +	 */
> +	struct dma_fence finished;
> +
> +	/**
> +	 * @deadline: deadline set on @finished which potentially needs to be
> +	 * propagated to @parent.
> +	 */
> +	ktime_t	deadline;
> +
> +	/**
> +	 * @parent: The hardware fence returned by &drm_dep_queue_ops.run_job.
> +	 *
> +	 * @finished is signaled once @parent is signaled. The initial store is
> +	 * performed via smp_store_release to synchronize with deadline handlin=
g.
> +	 *
> +	 * All readers must access this under the fence lock and take a referen=
ce to
> +	 * it, as @parent is set to NULL under the fence lock when the drm_dep_=
fence
> +	 * signals, and this drop also releases its internal reference.
> +	 */
> +	struct dma_fence *parent;
> +
> +	/**
> +	 * @q: the queue this fence belongs to.
> +	 */
> +	struct drm_dep_queue *q;
> +};

As Daniel pointed out already, with Christian's recent changes to
dma_fence (the ones that reset dma_fence::ops after ::signal()), the
fence proxy that existed in drm_sched_fence is no longer required:
drivers and their implementations can safely vanish even if some fences
they have emitted are still referenced by other subsystems. All we need
is:

- fence must be signaled for dma_fence::ops to be set back to NULL
- no .cleanup and no .wait implementation

There might be an interest in having HW submission fences reflecting
when the job is passed to the FW/HW queue, but that can done as a
separate fence implementation using a different fence timeline/context.

> diff --git a/drivers/gpu/drm/dep/drm_dep_job.c b/drivers/gpu/drm/dep/drm_=
dep_job.c
> new file mode 100644
> index 000000000000..2d012b29a5fc
> --- /dev/null
> +++ b/drivers/gpu/drm/dep/drm_dep_job.c
> @@ -0,0 +1,675 @@
> +// SPDX-License-Identifier: MIT
> +/*
> + * Copyright 2015 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a
> + * copy of this software and associated documentation files (the "Softwa=
re"),
> + * to deal in the Software without restriction, including without limita=
tion
> + * the rights to use, copy, modify, merge, publish, distribute, sublicen=
se,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SH=
ALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES=
 OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + * Copyright =C2=A9 2026 Intel Corporation
> + */
> +
> +/**
> + * DOC: DRM dependency job
> + *
> + * A struct drm_dep_job represents a single unit of GPU work associated =
with
> + * a struct drm_dep_queue. The lifecycle of a job is:
> + *
> + * 1. **Allocation**: the driver allocates memory for the job (typically=
 by
> + *    embedding struct drm_dep_job in a larger structure) and calls
> + *    drm_dep_job_init() to initialise it. On success the job holds one
> + *    kref reference and a reference to its queue.
> + *
> + * 2. **Dependency collection**: the driver calls drm_dep_job_add_depend=
ency(),
> + *    drm_dep_job_add_syncobj_dependency(), drm_dep_job_add_resv_depende=
ncies(),
> + *    or drm_dep_job_add_implicit_dependencies() to register dma_fence o=
bjects
> + *    that must be signalled before the job can run. Duplicate fences fr=
om the
> + *    same fence context are deduplicated automatically.
> + *
> + * 3. **Arming**: drm_dep_job_arm() initialises the job's finished fence,
> + *    consuming a sequence number from the queue. After arming,
> + *    drm_dep_job_finished_fence() returns a valid fence that may be pas=
sed to
> + *    userspace or used as a dependency by other jobs.
> + *
> + * 4. **Submission**: drm_dep_job_push() submits the job to the queue. T=
he
> + *    queue takes a reference that it holds until the job's finished fen=
ce
> + *    signals and the job is freed by the put_job worker.
> + *
> + * 5. **Completion**: when the job's hardware work finishes its finished=
 fence
> + *    is signalled and drm_dep_job_put() is called by the queue. The dri=
ver
> + *    must release any driver-private resources in &drm_dep_job_ops.rele=
ase.
> + *
> + * Reference counting uses drm_dep_job_get() / drm_dep_job_put(). The
> + * internal drm_dep_job_fini() tears down the dependency xarray and fence
> + * objects before the driver's release callback is invoked.
> + */
> +
> +#include <linux/dma-resv.h>
> +#include <linux/kref.h>
> +#include <linux/slab.h>
> +#include <drm/drm_dep.h>
> +#include <drm/drm_file.h>
> +#include <drm/drm_gem.h>
> +#include <drm/drm_syncobj.h>
> +#include "drm_dep_fence.h"
> +#include "drm_dep_job.h"
> +#include "drm_dep_queue.h"
> +
> +/**
> + * drm_dep_job_init() - initialise a dep job
> + * @job: dep job to initialise
> + * @args: initialisation arguments
> + *
> + * Initialises @job with the queue, ops and credit count from @args.  Ac=
quires
> + * a reference to @args->q via drm_dep_queue_get(); this reference is he=
ld for
> + * the lifetime of the job and released by drm_dep_job_release() when th=
e last
> + * job reference is dropped.
> + *
> + * Resources are released automatically when the last reference is dropp=
ed
> + * via drm_dep_job_put(), which must be called to release the job; drive=
rs
> + * must not free the job directly.
> + *
> + * Context: Process context. Allocates memory with GFP_KERNEL.
> + * Return: 0 on success, -%EINVAL if credits is 0,
> + *   -%ENOMEM on fence allocation failure.
> + */
> +int drm_dep_job_init(struct drm_dep_job *job,
> +		     const struct drm_dep_job_init_args *args)
> +{
> +	if (unlikely(!args->credits)) {
> +		pr_err("drm_dep: %s: credits cannot be 0\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	memset(job, 0, sizeof(*job));
> +
> +	job->dfence =3D drm_dep_fence_alloc();
> +	if (!job->dfence)
> +		return -ENOMEM;
> +
> +	job->ops =3D args->ops;
> +	job->q =3D drm_dep_queue_get(args->q);
> +	job->credits =3D args->credits;
> +
> +	kref_init(&job->refcount);
> +	xa_init_flags(&job->dependencies, XA_FLAGS_ALLOC);
> +	INIT_LIST_HEAD(&job->pending_link);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(drm_dep_job_init);
> +
> +/**
> + * drm_dep_job_drop_dependencies() - release all input dependency fences
> + * @job: dep job whose dependency xarray to drain
> + *
> + * Walks @job->dependencies, puts each fence, and destroys the xarray.
> + * Any slots still holding a %DRM_DEP_JOB_FENCE_PREALLOC sentinel =E2=80=
=94
> + * i.e. slots that were pre-allocated but never replaced =E2=80=94 are s=
ilently
> + * skipped; the sentinel carries no reference.  Called from
> + * drm_dep_queue_run_job() in process context immediately after
> + * @ops->run_job() returns, before the final drm_dep_job_put().  Releasi=
ng
> + * dependencies here =E2=80=94 while still in process context =E2=80=94 =
avoids calling
> + * xa_destroy() from IRQ context if the job's last reference is later
> + * dropped from a dma_fence callback.
> + *
> + * Context: Process context.
> + */
> +void drm_dep_job_drop_dependencies(struct drm_dep_job *job)
> +{
> +	struct dma_fence *fence;
> +	unsigned long index;
> +
> +	xa_for_each(&job->dependencies, index, fence) {
> +		if (unlikely(fence =3D=3D DRM_DEP_JOB_FENCE_PREALLOC))
> +			continue;
> +		dma_fence_put(fence);
> +	}
> +	xa_destroy(&job->dependencies);
> +}
> +
> +/**
> + * drm_dep_job_fini() - clean up a dep job
> + * @job: dep job to clean up
> + *
> + * Cleans up the dep fence and drops the queue reference held by @job.
> + *
> + * If the job was never armed (e.g. init failed before drm_dep_job_arm()=
),
> + * the dependency xarray is also released here.  For armed jobs the xarr=
ay
> + * has already been drained by drm_dep_job_drop_dependencies() in process
> + * context immediately after run_job(), so it is left untouched to avoid
> + * calling xa_destroy() from IRQ context.
> + *
> + * Warns if @job is still linked on the queue's pending list, which would
> + * indicate a bug in the teardown ordering.
> + *
> + * Context: Any context.
> + */
> +static void drm_dep_job_fini(struct drm_dep_job *job)
> +{
> +	bool armed =3D drm_dep_fence_is_armed(job->dfence);
> +
> +	WARN_ON(!list_empty(&job->pending_link));
> +
> +	drm_dep_fence_cleanup(job->dfence);
> +	job->dfence =3D NULL;
> +
> +	/*
> +	 * Armed jobs have their dependencies drained by
> +	 * drm_dep_job_drop_dependencies() in process context after run_job().

Just want to clear the confusion and make sure I get this right at the
same time. To me, "process context" means a user thread entering some
syscall(). What you call "process context" is more a "thread context" to
me. I'm actually almost certain it's always a kernel thread (a workqueue
worker thread to be accurate) that executes the drop_deps() after a
run_job().

> +	 * Skip here to avoid calling xa_destroy() from IRQ context.
> +	 */
> +	if (!armed)
> +		drm_dep_job_drop_dependencies(job);

Why do we need to make a difference here. Can't we just assume that the
hole drm_dep_job_fini() call is unsafe in atomic context, and have a
work item embedded in the job to defer its destruction when _put() is
called in a context where the destruction is not allowed?

> +}
> +
> +/**
> + * drm_dep_job_get() - acquire a reference to a dep job
> + * @job: dep job to acquire a reference on, or NULL
> + *
> + * Context: Any context.
> + * Return: @job with an additional reference held, or NULL if @job is NU=
LL.
> + */
> +struct drm_dep_job *drm_dep_job_get(struct drm_dep_job *job)
> +{
> +	if (job)
> +		kref_get(&job->refcount);
> +	return job;
> +}
> +EXPORT_SYMBOL(drm_dep_job_get);
> +
> +/**
> + * drm_dep_job_release() - kref release callback for a dep job
> + * @kref: kref embedded in the dep job
> + *
> + * Calls drm_dep_job_fini(), then invokes &drm_dep_job_ops.release if se=
t,
> + * otherwise frees @job with kfree().  Finally, releases the queue refer=
ence
> + * that was acquired by drm_dep_job_init() via drm_dep_queue_put().  The
> + * queue put is performed last to ensure no queue state is accessed after
> + * the job memory is freed.
> + *
> + * Context: Any context if %DRM_DEP_QUEUE_FLAGS_JOB_PUT_IRQ_SAFE is set =
on the
> + *   job's queue; otherwise process context only, as the release callbac=
k may
> + *   sleep.
> + */
> +static void drm_dep_job_release(struct kref *kref)
> +{
> +	struct drm_dep_job *job =3D
> +		container_of(kref, struct drm_dep_job, refcount);
> +	struct drm_dep_queue *q =3D job->q;
> +
> +	drm_dep_job_fini(job);
> +
> +	if (job->ops && job->ops->release)
> +		job->ops->release(job);
> +	else
> +		kfree(job);
> +
> +	drm_dep_queue_put(q);
> +}
> +
> +/**
> + * drm_dep_job_put() - release a reference to a dep job
> + * @job: dep job to release a reference on, or NULL
> + *
> + * When the last reference is dropped, calls &drm_dep_job_ops.release if=
 set,
> + * otherwise frees @job with kfree(). Does nothing if @job is NULL.
> + *
> + * Context: Any context if %DRM_DEP_QUEUE_FLAGS_JOB_PUT_IRQ_SAFE is set =
on the
> + *   job's queue; otherwise process context only, as the release callbac=
k may
> + *   sleep.
> + */
> +void drm_dep_job_put(struct drm_dep_job *job)
> +{
> +	if (job)
> +		kref_put(&job->refcount, drm_dep_job_release);
> +}
> +EXPORT_SYMBOL(drm_dep_job_put);
> +
> +/**
> + * drm_dep_job_arm() - arm a dep job for submission
> + * @job: dep job to arm
> + *
> + * Initialises the finished fence on @job->dfence, assigning
> + * it a sequence number from the job's queue. Must be called after
> + * drm_dep_job_init() and before drm_dep_job_push(). Once armed,
> + * drm_dep_job_finished_fence() returns a valid fence that may be passed=
 to
> + * userspace or used as a dependency by other jobs.
> + *
> + * Begins the DMA fence signalling path via dma_fence_begin_signalling().
> + * After this point, memory allocations that could trigger reclaim are
> + * forbidden; lockdep enforces this. arm() must always be paired with
> + * drm_dep_job_push(); lockdep also enforces this pairing.
> + *
> + * Warns if the job has already been armed.
> + *
> + * Context: Process context if %DRM_DEP_QUEUE_FLAGS_BYPASS_SUPPORTED is =
set
> + *   (takes @q->sched.lock, a mutex); any context otherwise. DMA fence s=
ignaling
> + *   path.
> + */
> +void drm_dep_job_arm(struct drm_dep_job *job)
> +{
> +	drm_dep_queue_push_job_begin(job->q);
> +	WARN_ON(drm_dep_fence_is_armed(job->dfence));
> +	drm_dep_fence_init(job->dfence, job->q);
> +	job->signalling_cookie =3D dma_fence_begin_signalling();

I'd really like DMA-signalling-path annotation to be something that
doesn't leak to the job object. The way I see it, in the submit path,
it should be some sort of block initializing an opaque token, and
drm_dep_job_arm() should expect a valid token to be passed, thus
guaranteeing that anything between arm and push, and more generally
anything in that section is safe.

	struct drm_job_submit_context submit_ctx;

	// Do all the prep stuff, pre-alloc, resv setup, ...

	// Non-faillible section of the submit starts here.
	// This is properly annotated with
	// dma_fence_{begin,end}_signalling() to ensure we're
	// not taking locks or doing allocations forbidden in
	// the signalling path
	drm_job_submit_non_faillible_section(&submit_ctx) {
		for_each_job() {
			drm_dep_job_arm(&submit_ctx, &job);

			// pass the armed fence around, if needed

			drm_dep_job_push(&submit_ctx, &job);
		}
	}

With the current solution, there's no control that
drm_dep_job_{arm,push}() calls are balanced, with the risk of leaving a
DMA-signalling annotation behind.

> +}
> +EXPORT_SYMBOL(drm_dep_job_arm);
> +
> +/**
> + * drm_dep_job_push() - submit a job to its queue for execution
> + * @job: dep job to push
> + *
> + * Submits @job to the queue it was initialised with. Must be called aft=
er
> + * drm_dep_job_arm(). Acquires a reference on @job on behalf of the queu=
e,
> + * held until the queue is fully done with it. The reference is released
> + * directly in the finished-fence dma_fence callback for queues with
> + * %DRM_DEP_QUEUE_FLAGS_JOB_PUT_IRQ_SAFE (where drm_dep_job_done() may r=
un
> + * from hardirq context), or via the put_job work item on the submit
> + * workqueue otherwise.
> + *
> + * Ends the DMA fence signalling path begun by drm_dep_job_arm() via
> + * dma_fence_end_signalling(). This must be paired with arm(); lockdep
> + * enforces the pairing.
> + *
> + * Once pushed, &drm_dep_queue_ops.run_job is guaranteed to be called for
> + * @job exactly once, even if the queue is killed or torn down before the
> + * job reaches the head of the queue. Drivers can use this guarantee to
> + * perform bookkeeping cleanup; the actual backend operation should be
> + * skipped when drm_dep_queue_is_killed() returns true.
> + *
> + * If the queue does not support the bypass path, the job is pushed dire=
ctly
> + * onto the SPSC submission queue via drm_dep_queue_push_job() without h=
olding
> + * @q->sched.lock. Otherwise, @q->sched.lock is taken and the job is eit=
her
> + * run immediately via drm_dep_queue_run_job() if it qualifies for bypas=
s, or
> + * enqueued via drm_dep_queue_push_job() for dispatch by the run_job wor=
k item.
> + *
> + * Warns if the job has not been armed.
> + *
> + * Context: Process context if %DRM_DEP_QUEUE_FLAGS_BYPASS_SUPPORTED is =
set
> + *   (takes @q->sched.lock, a mutex); any context otherwise. DMA fence s=
ignaling
> + *   path.
> + */
> +void drm_dep_job_push(struct drm_dep_job *job)
> +{
> +	struct drm_dep_queue *q =3D job->q;
> +
> +	WARN_ON(!drm_dep_fence_is_armed(job->dfence));
> +
> +	drm_dep_job_get(job);
> +
> +	if (!(q->sched.flags & DRM_DEP_QUEUE_FLAGS_BYPASS_SUPPORTED)) {
> +		drm_dep_queue_push_job(q, job);
> +		dma_fence_end_signalling(job->signalling_cookie);
> +		drm_dep_queue_push_job_end(job->q);
> +		return;
> +	}
> +
> +	scoped_guard(mutex, &q->sched.lock) {
> +		if (drm_dep_queue_can_job_bypass(q, job))
> +			drm_dep_queue_run_job(q, job);
> +		else
> +			drm_dep_queue_push_job(q, job);
> +	}
> +
> +	dma_fence_end_signalling(job->signalling_cookie);
> +	drm_dep_queue_push_job_end(job->q);
> +}
> +EXPORT_SYMBOL(drm_dep_job_push);
> +
> +/**
> + * drm_dep_job_add_dependency() - adds the fence as a job dependency
> + * @job: dep job to add the dependencies to
> + * @fence: the dma_fence to add to the list of dependencies, or
> + *         %DRM_DEP_JOB_FENCE_PREALLOC to reserve a slot for later.
> + *
> + * Note that @fence is consumed in both the success and error cases (exc=
ept
> + * when @fence is %DRM_DEP_JOB_FENCE_PREALLOC, which carries no referenc=
e).
> + *
> + * Signalled fences and fences belonging to the same queue as @job (i.e.=
 where
> + * fence->context matches the queue's finished fence context) are silent=
ly
> + * dropped; the job need not wait on its own queue's output.
> + *
> + * Warns if the job has already been armed (dependencies must be added b=
efore
> + * drm_dep_job_arm()).
> + *
> + * **Pre-allocation pattern**
> + *
> + * When multiple jobs across different queues must be prepared and submi=
tted
> + * together in a single atomic commit =E2=80=94 for example, where job A=
's finished
> + * fence is an input dependency of job B =E2=80=94 all jobs must be arme=
d and pushed
> + * within a single dma_fence_begin_signalling() / dma_fence_end_signalli=
ng()
> + * region.  Once that region has started no memory allocation is permitt=
ed.
> + *
> + * To handle this, pass %DRM_DEP_JOB_FENCE_PREALLOC during the preparati=
on
> + * phase (before arming any job, while GFP_KERNEL allocation is still al=
lowed)
> + * to pre-allocate a slot in @job->dependencies.  The slot index assigne=
d by
> + * the underlying xarray must be tracked by the caller separately (e.g. =
it is
> + * always index 0 when the dependency array is empty, as Xe relies on).
> + * After all jobs have been armed and the finished fences are available,=
 call
> + * drm_dep_job_replace_dependency() with that index and the real fence.
> + * drm_dep_job_replace_dependency() uses GFP_NOWAIT internally and may be
> + * called from atomic or signalling context.
> + *
> + * The sentinel slot is never skipped by the signalled-fence fast-path,
> + * ensuring a slot is always allocated even when the real fence is not y=
et
> + * known.
> + *
> + * **Example: bind job feeding TLB invalidation jobs**
> + *
> + * Consider a GPU with separate queues for page-table bind operations an=
d for
> + * TLB invalidation.  A single atomic commit must:
> + *
> + *  1. Run a bind job that modifies page tables.
> + *  2. Run one TLB-invalidation job per MMU that depends on the bind
> + *     completing, so stale translations are flushed before the engines
> + *     continue.
> + *
> + * Because all jobs must be armed and pushed inside a signalling region =
(where
> + * GFP_KERNEL is forbidden), pre-allocate slots before entering the regi=
on::
> + *
> + *   // Phase 1 =E2=80=94 process context, GFP_KERNEL allowed
> + *   drm_dep_job_init(bind_job, bind_queue, ops);
> + *   for_each_mmu(mmu) {
> + *       drm_dep_job_init(tlb_job[mmu], tlb_queue[mmu], ops);
> + *       // Pre-allocate slot at index 0; real fence not available yet
> + *       drm_dep_job_add_dependency(tlb_job[mmu], DRM_DEP_JOB_FENCE_PREA=
LLOC);
> + *   }
> + *
> + *   // Phase 2 =E2=80=94 inside signalling region, no GFP_KERNEL
> + *   dma_fence_begin_signalling();
> + *   drm_dep_job_arm(bind_job);
> + *   for_each_mmu(mmu) {
> + *       // Swap sentinel for bind job's finished fence
> + *       drm_dep_job_replace_dependency(tlb_job[mmu], 0,
> + *                                      dma_fence_get(bind_job->finished=
));

Just FYI, Panthor doesn't have this {begin,end}_signalling() in the
submit path. If we were to add it, it would be around the
panthor_submit_ctx_push_jobs() call, which might seem broken. In
practice I don't think it is because we don't expose fences to the
outside world until all jobs have been pushed. So what happens is that
a job depending on a previous job in the same batch-submit has the
armed-but-not-yet-pushed fence in its deps, and that's the only place
where this fence is present. If something fails on a subsequent job
preparation in the next batch submit, the rollback logic will just drop
the jobs on the floor, and release the armed-but-not-pushed-fence,
meaning we're not leaking a fence that will never be signalled. I'm in
no way saying this design is sane, just trying to explain why it's
currently safe and works fine.

In general, I wonder if we should distinguish between "armed" and
"publicly exposed" to help deal with this intra-batch dep thing without
resorting to reservation and other tricks like that.

> + *       drm_dep_job_arm(tlb_job[mmu]);
> + *   }
> + *   drm_dep_job_push(bind_job);
> + *   for_each_mmu(mmu)
> + *       drm_dep_job_push(tlb_job[mmu]);
> + *   dma_fence_end_signalling();
> + *
> + * Context: Process context. May allocate memory with GFP_KERNEL.
> + * Return: If fence =3D=3D DRM_DEP_JOB_FENCE_PREALLOC index of allocatio=
n on
> + * success, else 0 on success, or a negative error code.
> + */
> +int drm_dep_job_add_dependency(struct drm_dep_job *job, struct dma_fence=
 *fence)
> +{
> +	struct drm_dep_queue *q =3D job->q;
> +	struct dma_fence *entry;
> +	unsigned long index;
> +	u32 id =3D 0;
> +	int ret;
> +
> +	WARN_ON(drm_dep_fence_is_armed(job->dfence));
> +	might_alloc(GFP_KERNEL);
> +
> +	if (!fence)
> +		return 0;
> +
> +	if (fence =3D=3D DRM_DEP_JOB_FENCE_PREALLOC)
> +		goto add_fence;
> +
> +	/*
> +	 * Ignore signalled fences or fences from our own queue =E2=80=94 finis=
hed
> +	 * fences use q->fence.context.
> +	 */
> +	if (dma_fence_test_signaled_flag(fence) ||
> +	    fence->context =3D=3D q->fence.context) {
> +		dma_fence_put(fence);
> +		return 0;
> +	}
> +
> +	/* Deduplicate if we already depend on a fence from the same context.
> +	 * This lets the size of the array of deps scale with the number of
> +	 * engines involved, rather than the number of BOs.
> +	 */
> +	xa_for_each(&job->dependencies, index, entry) {
> +		if (entry =3D=3D DRM_DEP_JOB_FENCE_PREALLOC ||
> +		    entry->context !=3D fence->context)
> +			continue;
> +
> +		if (dma_fence_is_later(fence, entry)) {
> +			dma_fence_put(entry);
> +			xa_store(&job->dependencies, index, fence, GFP_KERNEL);
> +		} else {
> +			dma_fence_put(fence);
> +		}
> +		return 0;
> +	}
> +
> +add_fence:
> +	ret =3D xa_alloc(&job->dependencies, &id, fence, xa_limit_32b,
> +		       GFP_KERNEL);
> +	if (ret !=3D 0) {
> +		if (fence !=3D DRM_DEP_JOB_FENCE_PREALLOC)
> +			dma_fence_put(fence);
> +		return ret;
> +	}
> +
> +	return (fence =3D=3D DRM_DEP_JOB_FENCE_PREALLOC) ? id : 0;
> +}
> +EXPORT_SYMBOL(drm_dep_job_add_dependency);
> +
> +/**
> + * drm_dep_job_replace_dependency() - replace a pre-allocated dependency=
 slot
> + * @job: dep job to update
> + * @index: xarray index of the slot to replace, as returned when the sen=
tinel
> + *         was originally inserted via drm_dep_job_add_dependency()
> + * @fence: the real dma_fence to store; its reference is always consumed
> + *
> + * Replaces the %DRM_DEP_JOB_FENCE_PREALLOC sentinel at @index in
> + * @job->dependencies with @fence.  The slot must have been pre-allocate=
d by
> + * passing %DRM_DEP_JOB_FENCE_PREALLOC to drm_dep_job_add_dependency(); =
the
> + * existing entry is asserted to be the sentinel.
> + *
> + * This is the second half of the pre-allocation pattern described in
> + * drm_dep_job_add_dependency().  It is intended to be called inside a
> + * dma_fence_begin_signalling() / dma_fence_end_signalling() region where
> + * memory allocation with GFP_KERNEL is forbidden.  It uses GFP_NOWAIT
> + * internally so it is safe to call from atomic or signalling context, b=
ut
> + * since the slot has been pre-allocated no actual memory allocation occ=
urs.
> + *
> + * If @fence is already signalled the slot is erased rather than storing=
 a
> + * redundant dependency.  The successful store is asserted =E2=80=94 if =
the store
> + * fails it indicates a programming error (slot index out of range or
> + * concurrent modification).
> + *
> + * Must be called before drm_dep_job_arm(). @fence is consumed in all ca=
ses.
> + *
> + * Context: Any context. DMA fence signaling path.
> + */
> +void drm_dep_job_replace_dependency(struct drm_dep_job *job, u32 index,
> +				    struct dma_fence *fence)
> +{
> +	WARN_ON(xa_load(&job->dependencies, index) !=3D
> +		DRM_DEP_JOB_FENCE_PREALLOC);
> +
> +	if (dma_fence_test_signaled_flag(fence)) {
> +		xa_erase(&job->dependencies, index);
> +		dma_fence_put(fence);
> +		return;
> +	}
> +
> +	if (WARN_ON(xa_is_err(xa_store(&job->dependencies, index, fence,
> +				       GFP_NOWAIT)))) {
> +		dma_fence_put(fence);
> +		return;
> +	}

You don't seem to go for the
replace-if-earlier-fence-on-same-context-exists optimization that we
have in drm_dep_job_add_dependency(). Any reason not to?

> +}
> +EXPORT_SYMBOL(drm_dep_job_replace_dependency);
> +

I'm going to stop here for today.

Regards,

Boris
