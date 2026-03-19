Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3B52107527E
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 09:12:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EE8210E939;
	Thu, 19 Mar 2026 09:12:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="ErcGSNnB";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6CA510E928;
 Thu, 19 Mar 2026 09:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1773911517;
 bh=OxLUA34ADh4QKKjZn6I3Uj2nWeH8eRhYqWjM1lNID2A=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=ErcGSNnBE8P9/Nte8KdHOezbL4PB99wFSaucntFOn4GXwbLaUKD60t/7Rwpj4SrxF
 dqr4t/gIX1QEIyBg3DadgBJxKKKL3fNxTuwKtF+E+7VWK9H/PcjWE8czjgm8fj5VLv
 fyAVRHS43ny3Wr02inKSlyZ9LjbZKi3qMJ6fxOO/0D2kX2Y9+RX8aqEeD3XHvO83Yb
 uax2YCQ30oLKKDaPoMpR/G5EFw4WPHN+zUZ+rsyTb9mM8OUuND3JkBX4aGBm9BSRYX
 hezyDN75jSu1d+Xmns2b7MN1Hbz4PPGhFVgYLK7Ojq3TurAcoTIB9HRw46v1/ZBobQ
 TRUwloq8ssp6Q==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id BAB1D17E10F8;
 Thu, 19 Mar 2026 10:11:56 +0100 (CET)
Date: Thu, 19 Mar 2026 10:11:53 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Matthew Brost <matthew.brost@intel.com>
Cc: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>, Thomas =?UTF-8?B?SGVsbHN0csO2bQ==?=
 <thomas.hellstrom@linux.intel.com>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, Danilo Krummrich <dakr@kernel.org>, David
 Airlie <airlied@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Philipp Stanner <phasta@kernel.org>, Simona Vetter <simona@ffwll.ch>, Sumit
 Semwal <sumit.semwal@linaro.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 02/12] drm/dep: Add DRM dependency queue layer
Message-ID: <20260319101153.169c7f36@fedora>
In-Reply-To: <abs1Da8ntfAQISL6@lstrano-desk.jf.intel.com>
References: <20260316043255.226352-1-matthew.brost@intel.com>
 <20260316043255.226352-3-matthew.brost@intel.com>
 <20260317155512.7250be13@fedora>
 <abs1Da8ntfAQISL6@lstrano-desk.jf.intel.com>
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

Hi Matthew,

On Wed, 18 Mar 2026 16:28:13 -0700
Matthew Brost <matthew.brost@intel.com> wrote:

> > - fence must be signaled for dma_fence::ops to be set back to NULL
> > - no .cleanup and no .wait implementation
> >=20
> > There might be an interest in having HW submission fences reflecting
> > when the job is passed to the FW/HW queue, but that can done as a
> > separate fence implementation using a different fence timeline/context.
> >  =20
>=20
> Yes, I removed scheduled side of drm sched fence as I figured that could
> be implemented driver side (or as an optional API in drm dep). Only
> AMDGPU / PVR use these too for ganged submissions which I need to wrap
> my head around. My initial thought is both of implementations likely
> could be simplified.

IIRC, PVR was also relying on it to allow native FW waits: when we have
a job that has deps that are backed by fences emitted by the same
driver, they are detected and lowered to waits on the "scheduled"
fence, the wait on the finished fence is done FW side.

>=20
> > > diff --git a/drivers/gpu/drm/dep/drm_dep_job.c b/drivers/gpu/drm/dep/=
drm_dep_job.c
> > > new file mode 100644
> > > index 000000000000..2d012b29a5fc
> > > --- /dev/null
> > > +++ b/drivers/gpu/drm/dep/drm_dep_job.c
> > > @@ -0,0 +1,675 @@
> > > +// SPDX-License-Identifier: MIT
> > > +/*
> > > + * Copyright 2015 Advanced Micro Devices, Inc.
> > > + *
> > > + * Permission is hereby granted, free of charge, to any person obtai=
ning a
> > > + * copy of this software and associated documentation files (the "So=
ftware"),
> > > + * to deal in the Software without restriction, including without li=
mitation
> > > + * the rights to use, copy, modify, merge, publish, distribute, subl=
icense,
> > > + * and/or sell copies of the Software, and to permit persons to whom=
 the
> > > + * Software is furnished to do so, subject to the following conditio=
ns:
> > > + *
> > > + * The above copyright notice and this permission notice shall be in=
cluded in
> > > + * all copies or substantial portions of the Software.
> > > + *
> > > + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, E=
XPRESS OR
> > > + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTA=
BILITY,
> > > + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVEN=
T SHALL
> > > + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAM=
AGES OR
> > > + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERW=
ISE,
> > > + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE US=
E OR
> > > + * OTHER DEALINGS IN THE SOFTWARE.
> > > + *
> > > + * Copyright =C2=A9 2026 Intel Corporation
> > > + */
> > > +
> > > +/**
> > > + * DOC: DRM dependency job
> > > + *
> > > + * A struct drm_dep_job represents a single unit of GPU work associa=
ted with
> > > + * a struct drm_dep_queue. The lifecycle of a job is:
> > > + *
> > > + * 1. **Allocation**: the driver allocates memory for the job (typic=
ally by
> > > + *    embedding struct drm_dep_job in a larger structure) and calls
> > > + *    drm_dep_job_init() to initialise it. On success the job holds =
one
> > > + *    kref reference and a reference to its queue.
> > > + *
> > > + * 2. **Dependency collection**: the driver calls drm_dep_job_add_de=
pendency(),
> > > + *    drm_dep_job_add_syncobj_dependency(), drm_dep_job_add_resv_dep=
endencies(),
> > > + *    or drm_dep_job_add_implicit_dependencies() to register dma_fen=
ce objects
> > > + *    that must be signalled before the job can run. Duplicate fence=
s from the
> > > + *    same fence context are deduplicated automatically.
> > > + *
> > > + * 3. **Arming**: drm_dep_job_arm() initialises the job's finished f=
ence,
> > > + *    consuming a sequence number from the queue. After arming,
> > > + *    drm_dep_job_finished_fence() returns a valid fence that may be=
 passed to
> > > + *    userspace or used as a dependency by other jobs.
> > > + *
> > > + * 4. **Submission**: drm_dep_job_push() submits the job to the queu=
e. The
> > > + *    queue takes a reference that it holds until the job's finished=
 fence
> > > + *    signals and the job is freed by the put_job worker.
> > > + *
> > > + * 5. **Completion**: when the job's hardware work finishes its fini=
shed fence
> > > + *    is signalled and drm_dep_job_put() is called by the queue. The=
 driver
> > > + *    must release any driver-private resources in &drm_dep_job_ops.=
release.
> > > + *
> > > + * Reference counting uses drm_dep_job_get() / drm_dep_job_put(). The
> > > + * internal drm_dep_job_fini() tears down the dependency xarray and =
fence
> > > + * objects before the driver's release callback is invoked.
> > > + */
> > > +
> > > +#include <linux/dma-resv.h>
> > > +#include <linux/kref.h>
> > > +#include <linux/slab.h>
> > > +#include <drm/drm_dep.h>
> > > +#include <drm/drm_file.h>
> > > +#include <drm/drm_gem.h>
> > > +#include <drm/drm_syncobj.h>
> > > +#include "drm_dep_fence.h"
> > > +#include "drm_dep_job.h"
> > > +#include "drm_dep_queue.h"
> > > +
> > > +/**
> > > + * drm_dep_job_init() - initialise a dep job
> > > + * @job: dep job to initialise
> > > + * @args: initialisation arguments
> > > + *
> > > + * Initialises @job with the queue, ops and credit count from @args.=
  Acquires
> > > + * a reference to @args->q via drm_dep_queue_get(); this reference i=
s held for
> > > + * the lifetime of the job and released by drm_dep_job_release() whe=
n the last
> > > + * job reference is dropped.
> > > + *
> > > + * Resources are released automatically when the last reference is d=
ropped
> > > + * via drm_dep_job_put(), which must be called to release the job; d=
rivers
> > > + * must not free the job directly.
> > > + *
> > > + * Context: Process context. Allocates memory with GFP_KERNEL.
> > > + * Return: 0 on success, -%EINVAL if credits is 0,
> > > + *   -%ENOMEM on fence allocation failure.
> > > + */
> > > +int drm_dep_job_init(struct drm_dep_job *job,
> > > +		     const struct drm_dep_job_init_args *args)
> > > +{
> > > +	if (unlikely(!args->credits)) {
> > > +		pr_err("drm_dep: %s: credits cannot be 0\n", __func__);
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	memset(job, 0, sizeof(*job));
> > > +
> > > +	job->dfence =3D drm_dep_fence_alloc();
> > > +	if (!job->dfence)
> > > +		return -ENOMEM;
> > > +
> > > +	job->ops =3D args->ops;
> > > +	job->q =3D drm_dep_queue_get(args->q);
> > > +	job->credits =3D args->credits;
> > > +
> > > +	kref_init(&job->refcount);
> > > +	xa_init_flags(&job->dependencies, XA_FLAGS_ALLOC);
> > > +	INIT_LIST_HEAD(&job->pending_link);
> > > +
> > > +	return 0;
> > > +}
> > > +EXPORT_SYMBOL(drm_dep_job_init);
> > > +
> > > +/**
> > > + * drm_dep_job_drop_dependencies() - release all input dependency fe=
nces
> > > + * @job: dep job whose dependency xarray to drain
> > > + *
> > > + * Walks @job->dependencies, puts each fence, and destroys the xarra=
y.
> > > + * Any slots still holding a %DRM_DEP_JOB_FENCE_PREALLOC sentinel =
=E2=80=94
> > > + * i.e. slots that were pre-allocated but never replaced =E2=80=94 a=
re silently
> > > + * skipped; the sentinel carries no reference.  Called from
> > > + * drm_dep_queue_run_job() in process context immediately after
> > > + * @ops->run_job() returns, before the final drm_dep_job_put().  Rel=
easing
> > > + * dependencies here =E2=80=94 while still in process context =E2=80=
=94 avoids calling
> > > + * xa_destroy() from IRQ context if the job's last reference is later
> > > + * dropped from a dma_fence callback.
> > > + *
> > > + * Context: Process context.
> > > + */
> > > +void drm_dep_job_drop_dependencies(struct drm_dep_job *job)
> > > +{
> > > +	struct dma_fence *fence;
> > > +	unsigned long index;
> > > +
> > > +	xa_for_each(&job->dependencies, index, fence) {
> > > +		if (unlikely(fence =3D=3D DRM_DEP_JOB_FENCE_PREALLOC))
> > > +			continue;
> > > +		dma_fence_put(fence);
> > > +	}
> > > +	xa_destroy(&job->dependencies);
> > > +}
> > > +
> > > +/**
> > > + * drm_dep_job_fini() - clean up a dep job
> > > + * @job: dep job to clean up
> > > + *
> > > + * Cleans up the dep fence and drops the queue reference held by @jo=
b.
> > > + *
> > > + * If the job was never armed (e.g. init failed before drm_dep_job_a=
rm()),
> > > + * the dependency xarray is also released here.  For armed jobs the =
xarray
> > > + * has already been drained by drm_dep_job_drop_dependencies() in pr=
ocess
> > > + * context immediately after run_job(), so it is left untouched to a=
void
> > > + * calling xa_destroy() from IRQ context.
> > > + *
> > > + * Warns if @job is still linked on the queue's pending list, which =
would
> > > + * indicate a bug in the teardown ordering.
> > > + *
> > > + * Context: Any context.
> > > + */
> > > +static void drm_dep_job_fini(struct drm_dep_job *job)
> > > +{
> > > +	bool armed =3D drm_dep_fence_is_armed(job->dfence);
> > > +
> > > +	WARN_ON(!list_empty(&job->pending_link));
> > > +
> > > +	drm_dep_fence_cleanup(job->dfence);
> > > +	job->dfence =3D NULL;
> > > +
> > > +	/*
> > > +	 * Armed jobs have their dependencies drained by
> > > +	 * drm_dep_job_drop_dependencies() in process context after run_job=
(). =20
> >=20
> > Just want to clear the confusion and make sure I get this right at the
> > same time. To me, "process context" means a user thread entering some
> > syscall(). What you call "process context" is more a "thread context" to
> > me. I'm actually almost certain it's always a kernel thread (a workqueue
> > worker thread to be accurate) that executes the drop_deps() after a
> > run_job(). =20
>=20
> Some of context comments likely could be cleaned up. 'process context'
> here either in user context (bypass path) or run job work item.
>=20
> >  =20
> > > +	 * Skip here to avoid calling xa_destroy() from IRQ context.
> > > +	 */
> > > +	if (!armed)
> > > +		drm_dep_job_drop_dependencies(job); =20
> >=20
> > Why do we need to make a difference here. Can't we just assume that the
> > hole drm_dep_job_fini() call is unsafe in atomic context, and have a
> > work item embedded in the job to defer its destruction when _put() is
> > called in a context where the destruction is not allowed?
> >  =20
>=20
> We already touched on this, but the design currently allows the last job
> put from dma-fence signaling path (IRQ).

It's not much about the last _put and more about what happens in the
_release() you pass to kref_put(). My point being, if you assume
something in _release() is not safe to be done in an atomic context,
and _put() is assumed to be called from any context, you might as well
just defer the cleanup (AKA the stuff you currently have in _release())
so everything is always cleaned up in a thread context. Yes, there's
scheduling overhead and extra latency, but it's also simpler, because
there's just one path. So, if the latency and the overhead is not
proven to be a problem (and it rarely is for cleanup operations), I'm
still convinced this makes for an easier design to just defer the
cleanup all the time.

>  If we droppped that, then yes
> this could change. The reason the if statement currently is user is
> building a job and need to abort prior to calling arm() (e.g., a memory
> allocation fails) via a drm_dep_job_put.

But even in that context, it could still be deferred and work just
fine, no?

>=20
> Once arm() is called there is a guarnette the run_job path is called
> either via bypass or run job work item.

Sure.

>=20
> > > +}
> > > +
> > > +/**
> > > + * drm_dep_job_get() - acquire a reference to a dep job
> > > + * @job: dep job to acquire a reference on, or NULL
> > > + *
> > > + * Context: Any context.
> > > + * Return: @job with an additional reference held, or NULL if @job i=
s NULL.
> > > + */
> > > +struct drm_dep_job *drm_dep_job_get(struct drm_dep_job *job)
> > > +{
> > > +	if (job)
> > > +		kref_get(&job->refcount);
> > > +	return job;
> > > +}
> > > +EXPORT_SYMBOL(drm_dep_job_get);
> > > +
> > > +/**
> > > + * drm_dep_job_release() - kref release callback for a dep job
> > > + * @kref: kref embedded in the dep job
> > > + *
> > > + * Calls drm_dep_job_fini(), then invokes &drm_dep_job_ops.release i=
f set,
> > > + * otherwise frees @job with kfree().  Finally, releases the queue r=
eference
> > > + * that was acquired by drm_dep_job_init() via drm_dep_queue_put(). =
 The
> > > + * queue put is performed last to ensure no queue state is accessed =
after
> > > + * the job memory is freed.
> > > + *
> > > + * Context: Any context if %DRM_DEP_QUEUE_FLAGS_JOB_PUT_IRQ_SAFE is =
set on the
> > > + *   job's queue; otherwise process context only, as the release cal=
lback may
> > > + *   sleep.
> > > + */
> > > +static void drm_dep_job_release(struct kref *kref)
> > > +{
> > > +	struct drm_dep_job *job =3D
> > > +		container_of(kref, struct drm_dep_job, refcount);
> > > +	struct drm_dep_queue *q =3D job->q;
> > > +
> > > +	drm_dep_job_fini(job);
> > > +
> > > +	if (job->ops && job->ops->release)
> > > +		job->ops->release(job);
> > > +	else
> > > +		kfree(job);
> > > +
> > > +	drm_dep_queue_put(q);
> > > +}
> > > +
> > > +/**
> > > + * drm_dep_job_put() - release a reference to a dep job
> > > + * @job: dep job to release a reference on, or NULL
> > > + *
> > > + * When the last reference is dropped, calls &drm_dep_job_ops.releas=
e if set,
> > > + * otherwise frees @job with kfree(). Does nothing if @job is NULL.
> > > + *
> > > + * Context: Any context if %DRM_DEP_QUEUE_FLAGS_JOB_PUT_IRQ_SAFE is =
set on the
> > > + *   job's queue; otherwise process context only, as the release cal=
lback may
> > > + *   sleep.
> > > + */
> > > +void drm_dep_job_put(struct drm_dep_job *job)
> > > +{
> > > +	if (job)
> > > +		kref_put(&job->refcount, drm_dep_job_release);
> > > +}
> > > +EXPORT_SYMBOL(drm_dep_job_put);
> > > +
> > > +/**
> > > + * drm_dep_job_arm() - arm a dep job for submission
> > > + * @job: dep job to arm
> > > + *
> > > + * Initialises the finished fence on @job->dfence, assigning
> > > + * it a sequence number from the job's queue. Must be called after
> > > + * drm_dep_job_init() and before drm_dep_job_push(). Once armed,
> > > + * drm_dep_job_finished_fence() returns a valid fence that may be pa=
ssed to
> > > + * userspace or used as a dependency by other jobs.
> > > + *
> > > + * Begins the DMA fence signalling path via dma_fence_begin_signalli=
ng().
> > > + * After this point, memory allocations that could trigger reclaim a=
re
> > > + * forbidden; lockdep enforces this. arm() must always be paired with
> > > + * drm_dep_job_push(); lockdep also enforces this pairing.
> > > + *
> > > + * Warns if the job has already been armed.
> > > + *
> > > + * Context: Process context if %DRM_DEP_QUEUE_FLAGS_BYPASS_SUPPORTED=
 is set
> > > + *   (takes @q->sched.lock, a mutex); any context otherwise. DMA fen=
ce signaling
> > > + *   path.
> > > + */
> > > +void drm_dep_job_arm(struct drm_dep_job *job)
> > > +{
> > > +	drm_dep_queue_push_job_begin(job->q);
> > > +	WARN_ON(drm_dep_fence_is_armed(job->dfence));
> > > +	drm_dep_fence_init(job->dfence, job->q);
> > > +	job->signalling_cookie =3D dma_fence_begin_signalling(); =20
> >=20
> > I'd really like DMA-signalling-path annotation to be something that
> > doesn't leak to the job object. The way I see it, in the submit path,
> > it should be some sort of block initializing an opaque token, and
> > drm_dep_job_arm() should expect a valid token to be passed, thus
> > guaranteeing that anything between arm and push, and more generally
> > anything in that section is safe.
> >  =20
>=20
> Yes. drm_dep_queue_push_job_begin internally creates a token (current)
> that is paired drm_dep_queue_push_job_end. If you ever have imbalance
> between arm() and push() you will get complaints.
>=20
> > 	struct drm_job_submit_context submit_ctx;
> >=20
> > 	// Do all the prep stuff, pre-alloc, resv setup, ...
> >=20
> > 	// Non-faillible section of the submit starts here.
> > 	// This is properly annotated with
> > 	// dma_fence_{begin,end}_signalling() to ensure we're
> > 	// not taking locks or doing allocations forbidden in
> > 	// the signalling path
> > 	drm_job_submit_non_faillible_section(&submit_ctx) {
> > 		for_each_job() {
> > 			drm_dep_job_arm(&submit_ctx, &job);
> >=20
> > 			// pass the armed fence around, if needed
> >=20
> > 			drm_dep_job_push(&submit_ctx, &job);
> > 		}
> > 	}
> >=20
> > With the current solution, there's no control that
> > drm_dep_job_{arm,push}() calls are balanced, with the risk of leaving a
> > DMA-signalling annotation behind. =20
>=20
> See above, that is what drm_dep_queue_push_job_begin/end do.

That's still error-prone, and the kind of errors you only detect at
runtime. Let alone the fact you might not even notice if the unbalanced
symptoms are caused by error paths that are rarely tested. I'm
proposing something that's designed so you can't make those mistakes
unless you really want to:

- drm_job_submit_non_faillible_section() is a block-like macro
  with a clear scope before/after which the token is invalid
- drm_job_submit_non_faillible_section() is the only place that can
  produce a valid token (not enforceable in C, but with an
  __drm_dep_queue_create_submit_token() and proper disclaimer, I guess
  we can discourage people to inadvertently use it)
- drm_dep_job_{arm,push}() calls requires a valid token to work, and
  with the two points mentioned above, that means you can't call
  drm_dep_job_{arm,push}() outside a
  drm_job_submit_non_faillible_section() block

It's not quite the compile-time checks rust would enforce, but it's a
model that forces people to do it the right way, with extra runtime
checks for the case where they still got it wrong (like, putting the
_arm() and _push() in two different
drm_job_submit_non_faillible_section() blocks).

>=20
> >  =20
> > > +}
> > > +EXPORT_SYMBOL(drm_dep_job_arm);
> > > +
> > > +/**
> > > + * drm_dep_job_push() - submit a job to its queue for execution
> > > + * @job: dep job to push
> > > + *
> > > + * Submits @job to the queue it was initialised with. Must be called=
 after
> > > + * drm_dep_job_arm(). Acquires a reference on @job on behalf of the =
queue,
> > > + * held until the queue is fully done with it. The reference is rele=
ased
> > > + * directly in the finished-fence dma_fence callback for queues with
> > > + * %DRM_DEP_QUEUE_FLAGS_JOB_PUT_IRQ_SAFE (where drm_dep_job_done() m=
ay run
> > > + * from hardirq context), or via the put_job work item on the submit
> > > + * workqueue otherwise.
> > > + *
> > > + * Ends the DMA fence signalling path begun by drm_dep_job_arm() via
> > > + * dma_fence_end_signalling(). This must be paired with arm(); lockd=
ep
> > > + * enforces the pairing.
> > > + *
> > > + * Once pushed, &drm_dep_queue_ops.run_job is guaranteed to be calle=
d for
> > > + * @job exactly once, even if the queue is killed or torn down befor=
e the
> > > + * job reaches the head of the queue. Drivers can use this guarantee=
 to
> > > + * perform bookkeeping cleanup; the actual backend operation should =
be
> > > + * skipped when drm_dep_queue_is_killed() returns true.
> > > + *
> > > + * If the queue does not support the bypass path, the job is pushed =
directly
> > > + * onto the SPSC submission queue via drm_dep_queue_push_job() witho=
ut holding
> > > + * @q->sched.lock. Otherwise, @q->sched.lock is taken and the job is=
 either
> > > + * run immediately via drm_dep_queue_run_job() if it qualifies for b=
ypass, or
> > > + * enqueued via drm_dep_queue_push_job() for dispatch by the run_job=
 work item.
> > > + *
> > > + * Warns if the job has not been armed.
> > > + *
> > > + * Context: Process context if %DRM_DEP_QUEUE_FLAGS_BYPASS_SUPPORTED=
 is set
> > > + *   (takes @q->sched.lock, a mutex); any context otherwise. DMA fen=
ce signaling
> > > + *   path.
> > > + */
> > > +void drm_dep_job_push(struct drm_dep_job *job)
> > > +{
> > > +	struct drm_dep_queue *q =3D job->q;
> > > +
> > > +	WARN_ON(!drm_dep_fence_is_armed(job->dfence));
> > > +
> > > +	drm_dep_job_get(job);
> > > +
> > > +	if (!(q->sched.flags & DRM_DEP_QUEUE_FLAGS_BYPASS_SUPPORTED)) {
> > > +		drm_dep_queue_push_job(q, job);
> > > +		dma_fence_end_signalling(job->signalling_cookie);
> > > +		drm_dep_queue_push_job_end(job->q);
> > > +		return;
> > > +	}
> > > +
> > > +	scoped_guard(mutex, &q->sched.lock) {
> > > +		if (drm_dep_queue_can_job_bypass(q, job))
> > > +			drm_dep_queue_run_job(q, job);
> > > +		else
> > > +			drm_dep_queue_push_job(q, job);
> > > +	}
> > > +
> > > +	dma_fence_end_signalling(job->signalling_cookie);
> > > +	drm_dep_queue_push_job_end(job->q);
> > > +}
> > > +EXPORT_SYMBOL(drm_dep_job_push);
> > > +
> > > +/**
> > > + * drm_dep_job_add_dependency() - adds the fence as a job dependency
> > > + * @job: dep job to add the dependencies to
> > > + * @fence: the dma_fence to add to the list of dependencies, or
> > > + *         %DRM_DEP_JOB_FENCE_PREALLOC to reserve a slot for later.
> > > + *
> > > + * Note that @fence is consumed in both the success and error cases =
(except
> > > + * when @fence is %DRM_DEP_JOB_FENCE_PREALLOC, which carries no refe=
rence).
> > > + *
> > > + * Signalled fences and fences belonging to the same queue as @job (=
i.e. where
> > > + * fence->context matches the queue's finished fence context) are si=
lently
> > > + * dropped; the job need not wait on its own queue's output.
> > > + *
> > > + * Warns if the job has already been armed (dependencies must be add=
ed before
> > > + * drm_dep_job_arm()).
> > > + *
> > > + * **Pre-allocation pattern**
> > > + *
> > > + * When multiple jobs across different queues must be prepared and s=
ubmitted
> > > + * together in a single atomic commit =E2=80=94 for example, where j=
ob A's finished
> > > + * fence is an input dependency of job B =E2=80=94 all jobs must be =
armed and pushed
> > > + * within a single dma_fence_begin_signalling() / dma_fence_end_sign=
alling()
> > > + * region.  Once that region has started no memory allocation is per=
mitted.
> > > + *
> > > + * To handle this, pass %DRM_DEP_JOB_FENCE_PREALLOC during the prepa=
ration
> > > + * phase (before arming any job, while GFP_KERNEL allocation is stil=
l allowed)
> > > + * to pre-allocate a slot in @job->dependencies.  The slot index ass=
igned by
> > > + * the underlying xarray must be tracked by the caller separately (e=
.g. it is
> > > + * always index 0 when the dependency array is empty, as Xe relies o=
n).
> > > + * After all jobs have been armed and the finished fences are availa=
ble, call
> > > + * drm_dep_job_replace_dependency() with that index and the real fen=
ce.
> > > + * drm_dep_job_replace_dependency() uses GFP_NOWAIT internally and m=
ay be
> > > + * called from atomic or signalling context.
> > > + *
> > > + * The sentinel slot is never skipped by the signalled-fence fast-pa=
th,
> > > + * ensuring a slot is always allocated even when the real fence is n=
ot yet
> > > + * known.
> > > + *
> > > + * **Example: bind job feeding TLB invalidation jobs**
> > > + *
> > > + * Consider a GPU with separate queues for page-table bind operation=
s and for
> > > + * TLB invalidation.  A single atomic commit must:
> > > + *
> > > + *  1. Run a bind job that modifies page tables.
> > > + *  2. Run one TLB-invalidation job per MMU that depends on the bind
> > > + *     completing, so stale translations are flushed before the engi=
nes
> > > + *     continue.
> > > + *
> > > + * Because all jobs must be armed and pushed inside a signalling reg=
ion (where
> > > + * GFP_KERNEL is forbidden), pre-allocate slots before entering the =
region::
> > > + *
> > > + *   // Phase 1 =E2=80=94 process context, GFP_KERNEL allowed
> > > + *   drm_dep_job_init(bind_job, bind_queue, ops);
> > > + *   for_each_mmu(mmu) {
> > > + *       drm_dep_job_init(tlb_job[mmu], tlb_queue[mmu], ops);
> > > + *       // Pre-allocate slot at index 0; real fence not available y=
et
> > > + *       drm_dep_job_add_dependency(tlb_job[mmu], DRM_DEP_JOB_FENCE_=
PREALLOC);
> > > + *   }
> > > + *
> > > + *   // Phase 2 =E2=80=94 inside signalling region, no GFP_KERNEL
> > > + *   dma_fence_begin_signalling();
> > > + *   drm_dep_job_arm(bind_job);
> > > + *   for_each_mmu(mmu) {
> > > + *       // Swap sentinel for bind job's finished fence
> > > + *       drm_dep_job_replace_dependency(tlb_job[mmu], 0,
> > > + *                                      dma_fence_get(bind_job->fini=
shed)); =20
> >=20
> > Just FYI, Panthor doesn't have this {begin,end}_signalling() in the
> > submit path. If we were to add it, it would be around the
> > panthor_submit_ctx_push_jobs() call, which might seem broken. In =20
>=20
> Yes, I noticed that. I put XXX comment in my port [1] around this.
>=20
> [1] https://patchwork.freedesktop.org/patch/711952/?series=3D163245&rev=
=3D1
>=20
> > practice I don't think it is because we don't expose fences to the
> > outside world until all jobs have been pushed. So what happens is that
> > a job depending on a previous job in the same batch-submit has the
> > armed-but-not-yet-pushed fence in its deps, and that's the only place
> > where this fence is present. If something fails on a subsequent job
> > preparation in the next batch submit, the rollback logic will just drop
> > the jobs on the floor, and release the armed-but-not-pushed-fence,
> > meaning we're not leaking a fence that will never be signalled. I'm in
> > no way saying this design is sane, just trying to explain why it's
> > currently safe and works fine. =20
>=20
> Yep, I think would be better have no failure points between arm and
> push which again I do my best to enforce via lockdep/warnings.

I'm still not entirely convinced by that. To me _arm() is not quite the
moment you make your fence public, and I'm not sure the extra complexity
added for intra-batch dependencies (one job in a SUBMIT depending on a
previous job in the same SUBMIT) is justified, because what really
matters is not that we leave dangling/unsignalled dma_fence objects
around, the problem is when you do so on an object that has been
exposed publicly (syncobj, dma_resv, sync_file, ...).

>=20
> >=20
> > In general, I wonder if we should distinguish between "armed" and
> > "publicly exposed" to help deal with this intra-batch dep thing without
> > resorting to reservation and other tricks like that.
> >  =20
>=20
> I'm not exactly sure what you suggesting but always open to ideas.

Right now _arm() is what does the dma_fence_init(). But there's an
extra step between initializing the fence object and making it
visible to the outside world. In order for the dep to be added to the
job, you need the fence to be initialized, but that's not quite
external visibility, because the job is still very much a driver
object, and if something fails, the rollback mechanism makes it so all
the deps are dropped on the floor along the job that's being destroyed.
So we won't really wait on this fence that's never going to be
signalled.

I see what's appealing in pretending that _arm() =3D=3D externally-visible,
but it's also forcing us to do extra pre-alloc (or other pre-init)
operations that would otherwise not be required in the submit path. Not
a hill I'm willing to die on, but I just thought I'd mention the fact I
find it weird that we put extra constraints on ourselves that are not
strictly needed, just because we fail to properly flag the dma_fence
visibility transitions.

On the rust side it would be directly described through the type
system (see the Visibility attribute in Daniel's branch[1]). On C side,
this could take the form of a new DMA_FENCE_FLAG_INACTIVE (or whichever
name you want to give it). Any operation pushing the fence to public
container (dma_resv, syncobj, sync_file, ...) would be rejected when
that flag is set. At _push() time, we'd clear that flag with a
dma_fence_set_active() helper, which would reflect the fact the fence
can now be observed and exposed to the outside world.

>=20
> > > + *       drm_dep_job_arm(tlb_job[mmu]);
> > > + *   }
> > > + *   drm_dep_job_push(bind_job);
> > > + *   for_each_mmu(mmu)
> > > + *       drm_dep_job_push(tlb_job[mmu]);
> > > + *   dma_fence_end_signalling();
> > > + *
> > > + * Context: Process context. May allocate memory with GFP_KERNEL.
> > > + * Return: If fence =3D=3D DRM_DEP_JOB_FENCE_PREALLOC index of alloc=
ation on
> > > + * success, else 0 on success, or a negative error code.
> > > + */
> > > +int drm_dep_job_add_dependency(struct drm_dep_job *job, struct dma_f=
ence *fence)
> > > +{
> > > +	struct drm_dep_queue *q =3D job->q;
> > > +	struct dma_fence *entry;
> > > +	unsigned long index;
> > > +	u32 id =3D 0;
> > > +	int ret;
> > > +
> > > +	WARN_ON(drm_dep_fence_is_armed(job->dfence));
> > > +	might_alloc(GFP_KERNEL);
> > > +
> > > +	if (!fence)
> > > +		return 0;
> > > +
> > > +	if (fence =3D=3D DRM_DEP_JOB_FENCE_PREALLOC)
> > > +		goto add_fence;
> > > +
> > > +	/*
> > > +	 * Ignore signalled fences or fences from our own queue =E2=80=94 f=
inished
> > > +	 * fences use q->fence.context.
> > > +	 */
> > > +	if (dma_fence_test_signaled_flag(fence) ||
> > > +	    fence->context =3D=3D q->fence.context) {
> > > +		dma_fence_put(fence);
> > > +		return 0;
> > > +	}
> > > +
> > > +	/* Deduplicate if we already depend on a fence from the same contex=
t.
> > > +	 * This lets the size of the array of deps scale with the number of
> > > +	 * engines involved, rather than the number of BOs.
> > > +	 */
> > > +	xa_for_each(&job->dependencies, index, entry) {
> > > +		if (entry =3D=3D DRM_DEP_JOB_FENCE_PREALLOC ||
> > > +		    entry->context !=3D fence->context)
> > > +			continue;
> > > +
> > > +		if (dma_fence_is_later(fence, entry)) {
> > > +			dma_fence_put(entry);
> > > +			xa_store(&job->dependencies, index, fence, GFP_KERNEL);
> > > +		} else {
> > > +			dma_fence_put(fence);
> > > +		}
> > > +		return 0;
> > > +	}
> > > +
> > > +add_fence:
> > > +	ret =3D xa_alloc(&job->dependencies, &id, fence, xa_limit_32b,
> > > +		       GFP_KERNEL);
> > > +	if (ret !=3D 0) {
> > > +		if (fence !=3D DRM_DEP_JOB_FENCE_PREALLOC)
> > > +			dma_fence_put(fence);
> > > +		return ret;
> > > +	}
> > > +
> > > +	return (fence =3D=3D DRM_DEP_JOB_FENCE_PREALLOC) ? id : 0;
> > > +}
> > > +EXPORT_SYMBOL(drm_dep_job_add_dependency);
> > > +
> > > +/**
> > > + * drm_dep_job_replace_dependency() - replace a pre-allocated depend=
ency slot
> > > + * @job: dep job to update
> > > + * @index: xarray index of the slot to replace, as returned when the=
 sentinel
> > > + *         was originally inserted via drm_dep_job_add_dependency()
> > > + * @fence: the real dma_fence to store; its reference is always cons=
umed
> > > + *
> > > + * Replaces the %DRM_DEP_JOB_FENCE_PREALLOC sentinel at @index in
> > > + * @job->dependencies with @fence.  The slot must have been pre-allo=
cated by
> > > + * passing %DRM_DEP_JOB_FENCE_PREALLOC to drm_dep_job_add_dependency=
(); the
> > > + * existing entry is asserted to be the sentinel.
> > > + *
> > > + * This is the second half of the pre-allocation pattern described in
> > > + * drm_dep_job_add_dependency().  It is intended to be called inside=
 a
> > > + * dma_fence_begin_signalling() / dma_fence_end_signalling() region =
where
> > > + * memory allocation with GFP_KERNEL is forbidden.  It uses GFP_NOWA=
IT
> > > + * internally so it is safe to call from atomic or signalling contex=
t, but
> > > + * since the slot has been pre-allocated no actual memory allocation=
 occurs.
> > > + *
> > > + * If @fence is already signalled the slot is erased rather than sto=
ring a
> > > + * redundant dependency.  The successful store is asserted =E2=80=94=
 if the store
> > > + * fails it indicates a programming error (slot index out of range or
> > > + * concurrent modification).
> > > + *
> > > + * Must be called before drm_dep_job_arm(). @fence is consumed in al=
l cases.
> > > + *
> > > + * Context: Any context. DMA fence signaling path.
> > > + */
> > > +void drm_dep_job_replace_dependency(struct drm_dep_job *job, u32 ind=
ex,
> > > +				    struct dma_fence *fence)
> > > +{
> > > +	WARN_ON(xa_load(&job->dependencies, index) !=3D
> > > +		DRM_DEP_JOB_FENCE_PREALLOC);
> > > +
> > > +	if (dma_fence_test_signaled_flag(fence)) {
> > > +		xa_erase(&job->dependencies, index);
> > > +		dma_fence_put(fence);
> > > +		return;
> > > +	}
> > > +
> > > +	if (WARN_ON(xa_is_err(xa_store(&job->dependencies, index, fence,
> > > +				       GFP_NOWAIT)))) {
> > > +		dma_fence_put(fence);
> > > +		return;
> > > +	} =20
> >=20
> > You don't seem to go for the
> > replace-if-earlier-fence-on-same-context-exists optimization that we
> > have in drm_dep_job_add_dependency(). Any reason not to?
> >  =20
>=20
> No, that could be added in. My reasoning for ommiting was if you are
> pre-alloc a slot you likely know that the same timeline hasn't already
> been added in but maybe that is bad assumption.

Hm, in Panthor that would mean extra checks driver side, because at the
moment we don't check where deps come from. I'd be tempted to say, the
more we can automate the better, dunno.

Regards,

Boris

[1]https://gitlab.freedesktop.org/panfrost/linux/-/merge_requests/61/diffs#=
a5a71f917ff65cfe4c1a341fa7e55ae149d22863_300_693
