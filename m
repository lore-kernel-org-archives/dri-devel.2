Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2934EC01B6
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 09:55:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51E1B10E4B0;
	Mon, 23 Mar 2026 09:55:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="XgxHrIcG";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 822EA10E4AF;
 Mon, 23 Mar 2026 09:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1774259710;
 bh=0PcXqqGahcKSXn/GeSyDDPM/R3xqBJwyk0yiPXAF6Bk=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=XgxHrIcGEfeByp8WrPe9n+FZRK4njMYKrsvgPQ6CYmI3iS5oaOw7QHzjEFLYw1Jij
 EvmAxEU7DURYbnq+dn8dWQLIvtaQpv0VX2cyisASrXMSRGweoeF6WvLY0M9oTmlmn1
 d2GRKpUUJPlv13cm6JWjuCrVeRwZ1sFqbi9D9sSJQeW0/ln2rnWd+XLTeALmhMZyBN
 RGdqqUP+hrmrVN51W9iQFyKNo47rulYbAjqHLPJ8ZDJ2oNkb3LV3xXQBP2OU1qBvKx
 hNr560kxjeE3wZ492l4kU8rNru+gMFJ4RseYvIohcOjdF1posImj0htmP1yEzaN5YK
 F2D0/8dKgmhzw==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 94EA517E12AA;
 Mon, 23 Mar 2026 10:55:09 +0100 (CET)
Date: Mon, 23 Mar 2026 10:55:04 +0100
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
Message-ID: <20260323105504.2d9ae741@fedora>
In-Reply-To: <acDGf9BYQj6KwRIX@lstrano-desk.jf.intel.com>
References: <20260316043255.226352-1-matthew.brost@intel.com>
 <20260316043255.226352-3-matthew.brost@intel.com>
 <20260317155512.7250be13@fedora>
 <abs1Da8ntfAQISL6@lstrano-desk.jf.intel.com>
 <20260319101153.169c7f36@fedora>
 <acDGf9BYQj6KwRIX@lstrano-desk.jf.intel.com>
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

On Sun, 22 Mar 2026 21:50:07 -0700
Matthew Brost <matthew.brost@intel.com> wrote:

> > > > > diff --git a/drivers/gpu/drm/dep/drm_dep_job.c b/drivers/gpu/drm/=
dep/drm_dep_job.c
> > > > > new file mode 100644
> > > > > index 000000000000..2d012b29a5fc
> > > > > --- /dev/null
> > > > > +++ b/drivers/gpu/drm/dep/drm_dep_job.c
> > > > > @@ -0,0 +1,675 @@
> > > > > +// SPDX-License-Identifier: MIT
> > > > > +/*
> > > > > + * Copyright 2015 Advanced Micro Devices, Inc.
> > > > > + *
> > > > > + * Permission is hereby granted, free of charge, to any person o=
btaining a
> > > > > + * copy of this software and associated documentation files (the=
 "Software"),
> > > > > + * to deal in the Software without restriction, including withou=
t limitation
> > > > > + * the rights to use, copy, modify, merge, publish, distribute, =
sublicense,
> > > > > + * and/or sell copies of the Software, and to permit persons to =
whom the
> > > > > + * Software is furnished to do so, subject to the following cond=
itions:
> > > > > + *
> > > > > + * The above copyright notice and this permission notice shall b=
e included in
> > > > > + * all copies or substantial portions of the Software.
> > > > > + *
> > > > > + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIN=
D, EXPRESS OR
> > > > > + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCH=
ANTABILITY,
> > > > > + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO =
EVENT SHALL
> > > > > + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM,=
 DAMAGES OR
> > > > > + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OT=
HERWISE,
> > > > > + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR TH=
E USE OR
> > > > > + * OTHER DEALINGS IN THE SOFTWARE.
> > > > > + *
> > > > > + * Copyright =C2=A9 2026 Intel Corporation
> > > > > + */
> > > > > +
> > > > > +/**
> > > > > + * DOC: DRM dependency job
> > > > > + *
> > > > > + * A struct drm_dep_job represents a single unit of GPU work ass=
ociated with
> > > > > + * a struct drm_dep_queue. The lifecycle of a job is:
> > > > > + *
> > > > > + * 1. **Allocation**: the driver allocates memory for the job (t=
ypically by
> > > > > + *    embedding struct drm_dep_job in a larger structure) and ca=
lls
> > > > > + *    drm_dep_job_init() to initialise it. On success the job ho=
lds one
> > > > > + *    kref reference and a reference to its queue.
> > > > > + *
> > > > > + * 2. **Dependency collection**: the driver calls drm_dep_job_ad=
d_dependency(),
> > > > > + *    drm_dep_job_add_syncobj_dependency(), drm_dep_job_add_resv=
_dependencies(),
> > > > > + *    or drm_dep_job_add_implicit_dependencies() to register dma=
_fence objects
> > > > > + *    that must be signalled before the job can run. Duplicate f=
ences from the
> > > > > + *    same fence context are deduplicated automatically.
> > > > > + *
> > > > > + * 3. **Arming**: drm_dep_job_arm() initialises the job's finish=
ed fence,
> > > > > + *    consuming a sequence number from the queue. After arming,
> > > > > + *    drm_dep_job_finished_fence() returns a valid fence that ma=
y be passed to
> > > > > + *    userspace or used as a dependency by other jobs.
> > > > > + *
> > > > > + * 4. **Submission**: drm_dep_job_push() submits the job to the =
queue. The
> > > > > + *    queue takes a reference that it holds until the job's fini=
shed fence
> > > > > + *    signals and the job is freed by the put_job worker.
> > > > > + *
> > > > > + * 5. **Completion**: when the job's hardware work finishes its =
finished fence
> > > > > + *    is signalled and drm_dep_job_put() is called by the queue.=
 The driver
> > > > > + *    must release any driver-private resources in &drm_dep_job_=
ops.release.
> > > > > + *
> > > > > + * Reference counting uses drm_dep_job_get() / drm_dep_job_put()=
. The
> > > > > + * internal drm_dep_job_fini() tears down the dependency xarray =
and fence
> > > > > + * objects before the driver's release callback is invoked.
> > > > > + */
> > > > > +
> > > > > +#include <linux/dma-resv.h>
> > > > > +#include <linux/kref.h>
> > > > > +#include <linux/slab.h>
> > > > > +#include <drm/drm_dep.h>
> > > > > +#include <drm/drm_file.h>
> > > > > +#include <drm/drm_gem.h>
> > > > > +#include <drm/drm_syncobj.h>
> > > > > +#include "drm_dep_fence.h"
> > > > > +#include "drm_dep_job.h"
> > > > > +#include "drm_dep_queue.h"
> > > > > +
> > > > > +/**
> > > > > + * drm_dep_job_init() - initialise a dep job
> > > > > + * @job: dep job to initialise
> > > > > + * @args: initialisation arguments
> > > > > + *
> > > > > + * Initialises @job with the queue, ops and credit count from @a=
rgs.  Acquires
> > > > > + * a reference to @args->q via drm_dep_queue_get(); this referen=
ce is held for
> > > > > + * the lifetime of the job and released by drm_dep_job_release()=
 when the last
> > > > > + * job reference is dropped.
> > > > > + *
> > > > > + * Resources are released automatically when the last reference =
is dropped
> > > > > + * via drm_dep_job_put(), which must be called to release the jo=
b; drivers
> > > > > + * must not free the job directly.
> > > > > + *
> > > > > + * Context: Process context. Allocates memory with GFP_KERNEL.
> > > > > + * Return: 0 on success, -%EINVAL if credits is 0,
> > > > > + *   -%ENOMEM on fence allocation failure.
> > > > > + */
> > > > > +int drm_dep_job_init(struct drm_dep_job *job,
> > > > > +		     const struct drm_dep_job_init_args *args)
> > > > > +{
> > > > > +	if (unlikely(!args->credits)) {
> > > > > +		pr_err("drm_dep: %s: credits cannot be 0\n", __func__);
> > > > > +		return -EINVAL;
> > > > > +	}
> > > > > +
> > > > > +	memset(job, 0, sizeof(*job));
> > > > > +
> > > > > +	job->dfence =3D drm_dep_fence_alloc();
> > > > > +	if (!job->dfence)
> > > > > +		return -ENOMEM;
> > > > > +
> > > > > +	job->ops =3D args->ops;
> > > > > +	job->q =3D drm_dep_queue_get(args->q);
> > > > > +	job->credits =3D args->credits;
> > > > > +
> > > > > +	kref_init(&job->refcount);
> > > > > +	xa_init_flags(&job->dependencies, XA_FLAGS_ALLOC);
> > > > > +	INIT_LIST_HEAD(&job->pending_link);
> > > > > +
> > > > > +	return 0;
> > > > > +}
> > > > > +EXPORT_SYMBOL(drm_dep_job_init);
> > > > > +
> > > > > +/**
> > > > > + * drm_dep_job_drop_dependencies() - release all input dependenc=
y fences
> > > > > + * @job: dep job whose dependency xarray to drain
> > > > > + *
> > > > > + * Walks @job->dependencies, puts each fence, and destroys the x=
array.
> > > > > + * Any slots still holding a %DRM_DEP_JOB_FENCE_PREALLOC sentine=
l =E2=80=94
> > > > > + * i.e. slots that were pre-allocated but never replaced =E2=80=
=94 are silently
> > > > > + * skipped; the sentinel carries no reference.  Called from
> > > > > + * drm_dep_queue_run_job() in process context immediately after
> > > > > + * @ops->run_job() returns, before the final drm_dep_job_put(). =
 Releasing
> > > > > + * dependencies here =E2=80=94 while still in process context =
=E2=80=94 avoids calling
> > > > > + * xa_destroy() from IRQ context if the job's last reference is =
later
> > > > > + * dropped from a dma_fence callback.
> > > > > + *
> > > > > + * Context: Process context.
> > > > > + */
> > > > > +void drm_dep_job_drop_dependencies(struct drm_dep_job *job)
> > > > > +{
> > > > > +	struct dma_fence *fence;
> > > > > +	unsigned long index;
> > > > > +
> > > > > +	xa_for_each(&job->dependencies, index, fence) {
> > > > > +		if (unlikely(fence =3D=3D DRM_DEP_JOB_FENCE_PREALLOC))
> > > > > +			continue;
> > > > > +		dma_fence_put(fence);
> > > > > +	}
> > > > > +	xa_destroy(&job->dependencies);
> > > > > +}
> > > > > +
> > > > > +/**
> > > > > + * drm_dep_job_fini() - clean up a dep job
> > > > > + * @job: dep job to clean up
> > > > > + *
> > > > > + * Cleans up the dep fence and drops the queue reference held by=
 @job.
> > > > > + *
> > > > > + * If the job was never armed (e.g. init failed before drm_dep_j=
ob_arm()),
> > > > > + * the dependency xarray is also released here.  For armed jobs =
the xarray
> > > > > + * has already been drained by drm_dep_job_drop_dependencies() i=
n process
> > > > > + * context immediately after run_job(), so it is left untouched =
to avoid
> > > > > + * calling xa_destroy() from IRQ context.
> > > > > + *
> > > > > + * Warns if @job is still linked on the queue's pending list, wh=
ich would
> > > > > + * indicate a bug in the teardown ordering.
> > > > > + *
> > > > > + * Context: Any context.
> > > > > + */
> > > > > +static void drm_dep_job_fini(struct drm_dep_job *job)
> > > > > +{
> > > > > +	bool armed =3D drm_dep_fence_is_armed(job->dfence);
> > > > > +
> > > > > +	WARN_ON(!list_empty(&job->pending_link));
> > > > > +
> > > > > +	drm_dep_fence_cleanup(job->dfence);
> > > > > +	job->dfence =3D NULL;
> > > > > +
> > > > > +	/*
> > > > > +	 * Armed jobs have their dependencies drained by
> > > > > +	 * drm_dep_job_drop_dependencies() in process context after run=
_job().   =20
> > > >=20
> > > > Just want to clear the confusion and make sure I get this right at =
the
> > > > same time. To me, "process context" means a user thread entering so=
me
> > > > syscall(). What you call "process context" is more a "thread contex=
t" to
> > > > me. I'm actually almost certain it's always a kernel thread (a work=
queue
> > > > worker thread to be accurate) that executes the drop_deps() after a
> > > > run_job().   =20
> > >=20
> > > Some of context comments likely could be cleaned up. 'process context'
> > > here either in user context (bypass path) or run job work item.
> > >  =20
> > > >    =20
> > > > > +	 * Skip here to avoid calling xa_destroy() from IRQ context.
> > > > > +	 */
> > > > > +	if (!armed)
> > > > > +		drm_dep_job_drop_dependencies(job);   =20
> > > >=20
> > > > Why do we need to make a difference here. Can't we just assume that=
 the
> > > > hole drm_dep_job_fini() call is unsafe in atomic context, and have a
> > > > work item embedded in the job to defer its destruction when _put() =
is
> > > > called in a context where the destruction is not allowed?
> > > >    =20
> > >=20
> > > We already touched on this, but the design currently allows the last =
job
> > > put from dma-fence signaling path (IRQ). =20
> >=20
> > It's not much about the last _put and more about what happens in the
> > _release() you pass to kref_put(). My point being, if you assume
> > something in _release() is not safe to be done in an atomic context,
> > and _put() is assumed to be called from any context, you might as well =
=20
>=20
> No. DRM_DEP_QUEUE_FLAGS_JOB_PUT_IRQ_SAFE indicates that the entire job
> put (including release) is IRQ-safe. If the documentation isn=E2=80=99t c=
lear, I
> can clean that up. Some of my comments here [1] try to explain this
> further.
>=20
> Setting DRM_DEP_QUEUE_FLAGS_JOB_PUT_IRQ_SAFE makes a job analogous to a
> dma-fence whose release must be IRQ-safe, so there is precedent for
> this. I didn=E2=80=99t want to unilaterally require that all job releases=
 be
> IRQ-safe, as that would conflict with existing DRM scheduler jobs=E2=80=
=94hence
> the flag.
>=20
> The difference between non-IRQ-safe and IRQ-safe job release is only
> about 12 lines of code.

It's not just about the number of lines of code added to the core to
deal with that case, but also complexity of the API that results from
these various modes.

> I figured that if we=E2=80=99re going to invest the time
> and effort to replace DRM sched, we should aim for the best possible
> implementation. Any driver can opt-in here and immediately get less CPU
> ultization and power savings. I will try to figure out how to measure
> this and get some number here.

That's key here. My gut feeling is that we have so much deferred
already that adding one more work to the workqueue is not going to
hurt in term of scheduling overhead (no context switch if it's
scheduled on the same workqueue). Job cleanup is just the phase
following the job_done() event, which also requires a deferred work to
check progress on the queue anyway. And if you move the entirety of the
job cleanup to job_release() instead of doing part of it in
drm_dep_job_fini(), it makes for simpler design, where jobs are just
cleaned up when their refcnt drops to zero.

IMHO, that's exactly the kind of premature optimization that led us to
where we are with drm_sched: we think we need the optimization so we
add the complexity upfront without actual numbers to back this
theory (like, real GPU workloads to lead to actual differences in term
on power consumption, speed, ...), and the complexity just piles up as
you keep adding more and more of those flags.

>=20
> > just defer the cleanup (AKA the stuff you currently have in _release())
> > so everything is always cleaned up in a thread context. Yes, there's
> > scheduling overhead and extra latency, but it's also simpler, because
> > there's just one path. So, if the latency and the overhead is not =20
>=20
> This isn=E2=80=99t bolted on=E2=80=94it=E2=80=99s a built-in feature thro=
ughout. I can assure
> you that either mode works. I=E2=80=99ll likely add a debug Kconfig optio=
n to Xe
> that toggles DRM_DEP_QUEUE_FLAGS_JOB_PUT_IRQ_SAFE on each queue creation
> for CI runs, to ensure both paths work reliably and receive continuous
> testing.

I'm not claiming this doesn't work, I just want to make sure we're not
taking the same path drm_sched took with those premature optimizations.
If you have numbers that prove the extra power-consumption or the fact
the extra latency makes a difference in practice, that's a different
story, but otherwise, I still think it's preferable to start with a
smaller scope/simpler design, and add optimized cleanup path when we
have a proof it makes a difference.

>=20
> > proven to be a problem (and it rarely is for cleanup operations), I'm
> > still convinced this makes for an easier design to just defer the
> > cleanup all the time.
> >  =20
> > >  If we droppped that, then yes
> > > this could change. The reason the if statement currently is user is
> > > building a job and need to abort prior to calling arm() (e.g., a memo=
ry
> > > allocation fails) via a drm_dep_job_put. =20
> >=20
> > But even in that context, it could still be deferred and work just
> > fine, no?
> >  =20
>=20
> A work item context switch is thousands, if not tens of thousands, of
> cycles.

We won't have a full context switch just caused by the cleanup in the
normal execution case though. The context switch, you already have it
to check progress on the job queue anyway, so adding an extra job
cleanup is pretty cheap at this point. I'm not saying free either,
there's still the extra work insertion, the dequeuing, etc.

> If your job release is only ~20 instructions, this is a massive
> imbalance and an overall huge waste. Jobs are lightweight objects=E2=80=
=94they
> should really be thought of as an extension of fences. Fence release
> must be IRQ-safe per the documentation, so it follows that jobs can opt
> in to the same release rules.
>=20
> In contrast, queues are heavyweight objects, typically with associated
> memory that also needs to be released. Here, a work item absolutely
> makes sense=E2=80=94hence the design in DRM dep.

And that's kinda my point: a job being reported as done will cause a
work item to be scheduled to check progress on the queue, so you're
already paying the price of a context switch anyway. At this point, all
you'll gain by fast-tracking the job cleanup and allowing for IRQ-safe
cleanups is just latency. If you have numbers/workloads saying
otherwise, I'm fine reconsidering the extra complexity, but I'd to see
those first.

>=20
> > >=20
> > > Once arm() is called there is a guarnette the run_job path is called
> > > either via bypass or run job work item. =20
> >=20
> > Sure.
> >  =20
>=20
> Let=E2=80=99s not gloss over this=E2=80=94this is actually a huge differe=
nce from DRM
> sched. One of the biggest problems I found with DRM sched is that if you
> call arm(), run_job() may or may not be called. Without this guarantee,
> you can=E2=80=99t do driver-side bookkeeping in arm() that is later relea=
sed in
> run_job(), which would otherwise simplify the driver design.

You can do driver-side book-keeping after all jobs have been
successfully initialized, which include arming their fences. The key
turning point is when you start exposing those armed fences, not
when you arm them. See below.

>=20
> In Xe, we artificially enforce this rule through our own usage of DRM
> sched, but in DRM dep this is now an API-level contract. That allows
> drivers to embrace this semantic directly, simplifying their designs.
>=20

[...]

> > >  =20
> > > >    =20
> > > > > +}
> > > > > +EXPORT_SYMBOL(drm_dep_job_arm);
> > > > > +
> > > > > +/**
> > > > > + * drm_dep_job_push() - submit a job to its queue for execution
> > > > > + * @job: dep job to push
> > > > > + *
> > > > > + * Submits @job to the queue it was initialised with. Must be ca=
lled after
> > > > > + * drm_dep_job_arm(). Acquires a reference on @job on behalf of =
the queue,
> > > > > + * held until the queue is fully done with it. The reference is =
released
> > > > > + * directly in the finished-fence dma_fence callback for queues =
with
> > > > > + * %DRM_DEP_QUEUE_FLAGS_JOB_PUT_IRQ_SAFE (where drm_dep_job_done=
() may run
> > > > > + * from hardirq context), or via the put_job work item on the su=
bmit
> > > > > + * workqueue otherwise.
> > > > > + *
> > > > > + * Ends the DMA fence signalling path begun by drm_dep_job_arm()=
 via
> > > > > + * dma_fence_end_signalling(). This must be paired with arm(); l=
ockdep
> > > > > + * enforces the pairing.
> > > > > + *
> > > > > + * Once pushed, &drm_dep_queue_ops.run_job is guaranteed to be c=
alled for
> > > > > + * @job exactly once, even if the queue is killed or torn down b=
efore the
> > > > > + * job reaches the head of the queue. Drivers can use this guara=
ntee to
> > > > > + * perform bookkeeping cleanup; the actual backend operation sho=
uld be
> > > > > + * skipped when drm_dep_queue_is_killed() returns true.
> > > > > + *
> > > > > + * If the queue does not support the bypass path, the job is pus=
hed directly
> > > > > + * onto the SPSC submission queue via drm_dep_queue_push_job() w=
ithout holding
> > > > > + * @q->sched.lock. Otherwise, @q->sched.lock is taken and the jo=
b is either
> > > > > + * run immediately via drm_dep_queue_run_job() if it qualifies f=
or bypass, or
> > > > > + * enqueued via drm_dep_queue_push_job() for dispatch by the run=
_job work item.
> > > > > + *
> > > > > + * Warns if the job has not been armed.
> > > > > + *
> > > > > + * Context: Process context if %DRM_DEP_QUEUE_FLAGS_BYPASS_SUPPO=
RTED is set
> > > > > + *   (takes @q->sched.lock, a mutex); any context otherwise. DMA=
 fence signaling
> > > > > + *   path.
> > > > > + */
> > > > > +void drm_dep_job_push(struct drm_dep_job *job)
> > > > > +{
> > > > > +	struct drm_dep_queue *q =3D job->q;
> > > > > +
> > > > > +	WARN_ON(!drm_dep_fence_is_armed(job->dfence));
> > > > > +
> > > > > +	drm_dep_job_get(job);
> > > > > +
> > > > > +	if (!(q->sched.flags & DRM_DEP_QUEUE_FLAGS_BYPASS_SUPPORTED)) {
> > > > > +		drm_dep_queue_push_job(q, job);
> > > > > +		dma_fence_end_signalling(job->signalling_cookie);
> > > > > +		drm_dep_queue_push_job_end(job->q);
> > > > > +		return;
> > > > > +	}
> > > > > +
> > > > > +	scoped_guard(mutex, &q->sched.lock) {
> > > > > +		if (drm_dep_queue_can_job_bypass(q, job))
> > > > > +			drm_dep_queue_run_job(q, job);
> > > > > +		else
> > > > > +			drm_dep_queue_push_job(q, job);
> > > > > +	}
> > > > > +
> > > > > +	dma_fence_end_signalling(job->signalling_cookie);
> > > > > +	drm_dep_queue_push_job_end(job->q);
> > > > > +}
> > > > > +EXPORT_SYMBOL(drm_dep_job_push);
> > > > > +
> > > > > +/**
> > > > > + * drm_dep_job_add_dependency() - adds the fence as a job depend=
ency
> > > > > + * @job: dep job to add the dependencies to
> > > > > + * @fence: the dma_fence to add to the list of dependencies, or
> > > > > + *         %DRM_DEP_JOB_FENCE_PREALLOC to reserve a slot for lat=
er.
> > > > > + *
> > > > > + * Note that @fence is consumed in both the success and error ca=
ses (except
> > > > > + * when @fence is %DRM_DEP_JOB_FENCE_PREALLOC, which carries no =
reference).
> > > > > + *
> > > > > + * Signalled fences and fences belonging to the same queue as @j=
ob (i.e. where
> > > > > + * fence->context matches the queue's finished fence context) ar=
e silently
> > > > > + * dropped; the job need not wait on its own queue's output.
> > > > > + *
> > > > > + * Warns if the job has already been armed (dependencies must be=
 added before
> > > > > + * drm_dep_job_arm()).
> > > > > + *
> > > > > + * **Pre-allocation pattern**
> > > > > + *
> > > > > + * When multiple jobs across different queues must be prepared a=
nd submitted
> > > > > + * together in a single atomic commit =E2=80=94 for example, whe=
re job A's finished
> > > > > + * fence is an input dependency of job B =E2=80=94 all jobs must=
 be armed and pushed
> > > > > + * within a single dma_fence_begin_signalling() / dma_fence_end_=
signalling()
> > > > > + * region.  Once that region has started no memory allocation is=
 permitted.
> > > > > + *
> > > > > + * To handle this, pass %DRM_DEP_JOB_FENCE_PREALLOC during the p=
reparation
> > > > > + * phase (before arming any job, while GFP_KERNEL allocation is =
still allowed)
> > > > > + * to pre-allocate a slot in @job->dependencies.  The slot index=
 assigned by
> > > > > + * the underlying xarray must be tracked by the caller separatel=
y (e.g. it is
> > > > > + * always index 0 when the dependency array is empty, as Xe reli=
es on).
> > > > > + * After all jobs have been armed and the finished fences are av=
ailable, call
> > > > > + * drm_dep_job_replace_dependency() with that index and the real=
 fence.
> > > > > + * drm_dep_job_replace_dependency() uses GFP_NOWAIT internally a=
nd may be
> > > > > + * called from atomic or signalling context.
> > > > > + *
> > > > > + * The sentinel slot is never skipped by the signalled-fence fas=
t-path,
> > > > > + * ensuring a slot is always allocated even when the real fence =
is not yet
> > > > > + * known.
> > > > > + *
> > > > > + * **Example: bind job feeding TLB invalidation jobs**
> > > > > + *
> > > > > + * Consider a GPU with separate queues for page-table bind opera=
tions and for
> > > > > + * TLB invalidation.  A single atomic commit must:
> > > > > + *
> > > > > + *  1. Run a bind job that modifies page tables.
> > > > > + *  2. Run one TLB-invalidation job per MMU that depends on the =
bind
> > > > > + *     completing, so stale translations are flushed before the =
engines
> > > > > + *     continue.
> > > > > + *
> > > > > + * Because all jobs must be armed and pushed inside a signalling=
 region (where
> > > > > + * GFP_KERNEL is forbidden), pre-allocate slots before entering =
the region::
> > > > > + *
> > > > > + *   // Phase 1 =E2=80=94 process context, GFP_KERNEL allowed
> > > > > + *   drm_dep_job_init(bind_job, bind_queue, ops);
> > > > > + *   for_each_mmu(mmu) {
> > > > > + *       drm_dep_job_init(tlb_job[mmu], tlb_queue[mmu], ops);
> > > > > + *       // Pre-allocate slot at index 0; real fence not availab=
le yet
> > > > > + *       drm_dep_job_add_dependency(tlb_job[mmu], DRM_DEP_JOB_FE=
NCE_PREALLOC);
> > > > > + *   }
> > > > > + *
> > > > > + *   // Phase 2 =E2=80=94 inside signalling region, no GFP_KERNEL
> > > > > + *   dma_fence_begin_signalling();
> > > > > + *   drm_dep_job_arm(bind_job);
> > > > > + *   for_each_mmu(mmu) {
> > > > > + *       // Swap sentinel for bind job's finished fence
> > > > > + *       drm_dep_job_replace_dependency(tlb_job[mmu], 0,
> > > > > + *                                      dma_fence_get(bind_job->=
finished));   =20
> > > >=20
> > > > Just FYI, Panthor doesn't have this {begin,end}_signalling() in the
> > > > submit path. If we were to add it, it would be around the
> > > > panthor_submit_ctx_push_jobs() call, which might seem broken. In   =
=20
> > >=20
> > > Yes, I noticed that. I put XXX comment in my port [1] around this.
> > >=20
> > > [1] https://patchwork.freedesktop.org/patch/711952/?series=3D163245&r=
ev=3D1
> > >  =20
> > > > practice I don't think it is because we don't expose fences to the
> > > > outside world until all jobs have been pushed. So what happens is t=
hat
> > > > a job depending on a previous job in the same batch-submit has the
> > > > armed-but-not-yet-pushed fence in its deps, and that's the only pla=
ce
> > > > where this fence is present. If something fails on a subsequent job
> > > > preparation in the next batch submit, the rollback logic will just =
drop
> > > > the jobs on the floor, and release the armed-but-not-pushed-fence,
> > > > meaning we're not leaking a fence that will never be signalled. I'm=
 in
> > > > no way saying this design is sane, just trying to explain why it's
> > > > currently safe and works fine.   =20
> > >=20
> > > Yep, I think would be better have no failure points between arm and
> > > push which again I do my best to enforce via lockdep/warnings. =20
> >=20
> > I'm still not entirely convinced by that. To me _arm() is not quite the
> > moment you make your fence public, and I'm not sure the extra complexity
> > added for intra-batch dependencies (one job in a SUBMIT depending on a
> > previous job in the same SUBMIT) is justified, because what really
> > matters is not that we leave dangling/unsignalled dma_fence objects
> > around, the problem is when you do so on an object that has been
> > exposed publicly (syncobj, dma_resv, sync_file, ...).
> >  =20
>=20
> Let me give you an example of why a failure between arm() and push() is
> a huge problem:
>=20
> arm()
> dma_resv_install(fence_from_arm)
> fail

That's not what Panthor does. What we do is:

	for_each_job_in_batch() {
		ret =3D faillible_stuf()
		if (ret)
			goto rollback;

		arm(job)
	}

	// Nothing can fail after this point

	for_each_job_in_batch() {
		update_resvs(job->done_fence);
		push(job)
	}

	update_submit_syncobjs();

As you can see, an armed job doesn't mean the job fence is public, it
only becomes public after we've updated the resv of the BOs that might
be touched by this job.=20

>=20
> How does one unwind this? Signal the fence from arm()?

That, or we just ignore the fact it's not been signalled. If the job
that created the fence has never been submitted, and the fence has
vanished before hitting any public container, it doesn't matter.

> What if the fence
> from arm() is on a timeline currently being used by the device? The
> memory can move, and the device then can corrupt memory.

What? No, the seqno is just consumed, but there's nothing attached to
it, the previous job on this timeline (N-1) is still valid, and the next
one will have a seqno of N+1, which will force an implicit dep on N-1
on the same timeline. That's all.

>=20
> In my opinion, it=E2=80=99s best and safest to enforce a no-failure policy
> between arm() and push().

I don't think it's safer, it's just the semantics that have been
defined by drm_sched/dma_fence and that we keep forcing ourselves
into. I'd rather have a well defined dma_fence state that says "that's
it, I'm exposed, you have to signal me now", than this half-enforced
arm()+push() model.

>=20
> FWIW, this came up while I was reviewing AMDXDNA=E2=80=99s DRM scheduler =
usage,
> which had the exact issue I described above. I pointed it out and got a
> reply saying, =E2=80=9Cwell, this is an API issue, right?=E2=80=9D=E2=80=
=94and they were
> correct, it is an API issue.
>=20
> > >  =20
> > > >=20
> > > > In general, I wonder if we should distinguish between "armed" and
> > > > "publicly exposed" to help deal with this intra-batch dep thing wit=
hout
> > > > resorting to reservation and other tricks like that.
> > > >    =20
> > >=20
> > > I'm not exactly sure what you suggesting but always open to ideas. =20
> >=20
> > Right now _arm() is what does the dma_fence_init(). But there's an
> > extra step between initializing the fence object and making it
> > visible to the outside world. In order for the dep to be added to the
> > job, you need the fence to be initialized, but that's not quite
> > external visibility, because the job is still very much a driver
> > object, and if something fails, the rollback mechanism makes it so all
> > the deps are dropped on the floor along the job that's being destroyed.
> > So we won't really wait on this fence that's never going to be
> > signalled.
> >=20
> > I see what's appealing in pretending that _arm() =3D=3D externally-visi=
ble,
> > but it's also forcing us to do extra pre-alloc (or other pre-init)
> > operations that would otherwise not be required in the submit path. Not
> > a hill I'm willing to die on, but I just thought I'd mention the fact I
> > find it weird that we put extra constraints on ourselves that are not
> > strictly needed, just because we fail to properly flag the dma_fence
> > visibility transitions. =20
>=20
> See the dma-resv example above. I=E2=80=99m not willing to die on this hi=
ll
> either, but again, in my opinion, for safety and as an API-level
> contract, enforcing arm() as a no-failure point makes sense. It prevents
> drivers from doing anything dangerous like the dma-resv example, which
> is an extremely subtle bug.

That's a valid point, but you're not really enforcing things at
compile/run-time it's just "don't do this/that" in the docs. If you
encode the is_active() state at the dma_fence level, properly change
the fence state anytime it's about to be added to a public container,
and make it so an active fence that's released without being signalled
triggers a WARN_ON(), you've achieved more. Once you've done that, you
can also relax the rule that says that "an armed fence has to be
signalled" to "a fence that's active has to be signalled". With this,
the pre-alloc for intra-batch deps in your drm_dep_job::deps xarray is
no longer required, because you would be able to store inactive fences
there, as long as they become active before the job is pushed.

>=20
> >=20
> > On the rust side it would be directly described through the type
> > system (see the Visibility attribute in Daniel's branch[1]). On C side,
> > this could take the form of a new DMA_FENCE_FLAG_INACTIVE (or whichever
> > name you want to give it). Any operation pushing the fence to public
> > container (dma_resv, syncobj, sync_file, ...) would be rejected when
> > that flag is set. At _push() time, we'd clear that flag with a
> > dma_fence_set_active() helper, which would reflect the fact the fence
> > can now be observed and exposed to the outside world.
> >  =20
>=20
> Timeline squashing is problematic due to the DMA_FENCE_FLAG_INACTIVE
> flag. When adding a fence to dma-resv, fences that belong to the same
> timeline are immediately squashed. A later transition of the fence state
> completely breaks this behavior.

That's exactly my point: as soon as you want to insert the fence to a
public container, you have to make it "active", so it will never be
rolled back to the previous entry in the resv. Similarly, a
wait/add_callback() on an inactive fence should be rejected.

>=20
> 287 void dma_resv_add_fence(struct dma_resv *obj, struct dma_fence *fence,
> 288                         enum dma_resv_usage usage)
> 289 {
> 290         struct dma_resv_list *fobj;
> 291         struct dma_fence *old;
> 292         unsigned int i, count;
> 293
> 294         dma_fence_get(fence);
> 295
> 296         dma_resv_assert_held(obj);
> 297
> 298         /* Drivers should not add containers here, instead add each f=
ence
> 299          * individually.
> 300          */
> 301         WARN_ON(dma_fence_is_container(fence));
> 302
> 303         fobj =3D dma_resv_fences_list(obj);
> 304         count =3D fobj->num_fences;
> 305
> 306         for (i =3D 0; i < count; ++i) {
> 307                 enum dma_resv_usage old_usage;
> 308
> 309                 dma_resv_list_entry(fobj, i, obj, &old, &old_usage);
> 310                 if ((old->context =3D=3D fence->context && old_usage =
>=3D usage &&
> 311                      dma_fence_is_later_or_same(fence, old)) ||
> 312                     dma_fence_is_signaled(old)) {
> 313                         dma_resv_list_set(fobj, i, fence, usage);
> 314                         dma_fence_put(old);
> 315                         return;
> 316                 }
> 317         }
>=20
> Imagine syncobjs have similar squashing, but I don't know that offhand.

Same goes for syncobjs.

Regards,

Boris

