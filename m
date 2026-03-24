Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9061F532F8
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 08:50:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C74510E607;
	Tue, 24 Mar 2026 08:50:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="VHZGUAdS";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E90EC10E491;
 Tue, 24 Mar 2026 08:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1774342201;
 bh=Lee/DXBliWUgYPLPoeQ+8aE0c7KXDs/hyeVRnQv43tU=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=VHZGUAdSF/PsHjbOOFLHwGPWsZU7xFmQcs/j6xGsLcfQI/cp8Z9Q//YjDTVL4IiEF
 liorvnLvwePQoPdwM/0RAb5ayFvOqlr1MMsBk20pwUMMMY1+QU1CFh1UL9EyfLZbEX
 lywAnsfnLOlqUUWOuvIgc7l3WCC8gvp280oNfWihcjZWzMgJ7s60fLrGZ7BR/8hV3A
 XGgkA/9desk6QjjyB5lV+jjh26qd+UUPGzJ5B6GCzS1Wf3wQ8NghJxWoOm75RBJwb2
 XsL8D6Nxbc6anDshKOy/CEYHD2q22CMPmoSbgs5edy9oc8KvIFTZTrRFcjdfMAKD5n
 for3vVuLC66JA==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id B613317E4BDA;
 Tue, 24 Mar 2026 09:50:00 +0100 (CET)
Date: Tue, 24 Mar 2026 09:49:57 +0100
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
Message-ID: <20260324094957.0841801e@fedora>
In-Reply-To: <acFzpZruqlZQnQNk@lstrano-desk.jf.intel.com>
References: <20260316043255.226352-1-matthew.brost@intel.com>
 <20260316043255.226352-3-matthew.brost@intel.com>
 <20260317155512.7250be13@fedora>
 <abs1Da8ntfAQISL6@lstrano-desk.jf.intel.com>
 <20260319101153.169c7f36@fedora>
 <acDGf9BYQj6KwRIX@lstrano-desk.jf.intel.com>
 <20260323105504.2d9ae741@fedora>
 <acFzpZruqlZQnQNk@lstrano-desk.jf.intel.com>
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

On Mon, 23 Mar 2026 10:08:53 -0700
Matthew Brost <matthew.brost@intel.com> wrote:

> On Mon, Mar 23, 2026 at 10:55:04AM +0100, Boris Brezillon wrote:
> > Hi Matthew,
> >=20
> > On Sun, 22 Mar 2026 21:50:07 -0700
> > Matthew Brost <matthew.brost@intel.com> wrote:
> >  =20
> > > > > > > diff --git a/drivers/gpu/drm/dep/drm_dep_job.c b/drivers/gpu/=
drm/dep/drm_dep_job.c
> > > > > > > new file mode 100644
> > > > > > > index 000000000000..2d012b29a5fc
> > > > > > > --- /dev/null
> > > > > > > +++ b/drivers/gpu/drm/dep/drm_dep_job.c
> > > > > > > @@ -0,0 +1,675 @@
> > > > > > > +// SPDX-License-Identifier: MIT
> > > > > > > +/*
> > > > > > > + * Copyright 2015 Advanced Micro Devices, Inc.
> > > > > > > + *
> > > > > > > + * Permission is hereby granted, free of charge, to any pers=
on obtaining a
> > > > > > > + * copy of this software and associated documentation files =
(the "Software"),
> > > > > > > + * to deal in the Software without restriction, including wi=
thout limitation
> > > > > > > + * the rights to use, copy, modify, merge, publish, distribu=
te, sublicense,
> > > > > > > + * and/or sell copies of the Software, and to permit persons=
 to whom the
> > > > > > > + * Software is furnished to do so, subject to the following =
conditions:
> > > > > > > + *
> > > > > > > + * The above copyright notice and this permission notice sha=
ll be included in
> > > > > > > + * all copies or substantial portions of the Software.
> > > > > > > + *
> > > > > > > + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY=
 KIND, EXPRESS OR
> > > > > > > + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF M=
ERCHANTABILITY,
> > > > > > > + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN=
 NO EVENT SHALL
> > > > > > > + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CL=
AIM, DAMAGES OR
> > > > > > > + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT O=
R OTHERWISE,
> > > > > > > + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE O=
R THE USE OR
> > > > > > > + * OTHER DEALINGS IN THE SOFTWARE.
> > > > > > > + *
> > > > > > > + * Copyright =C2=A9 2026 Intel Corporation
> > > > > > > + */
> > > > > > > +
> > > > > > > +/**
> > > > > > > + * DOC: DRM dependency job
> > > > > > > + *
> > > > > > > + * A struct drm_dep_job represents a single unit of GPU work=
 associated with
> > > > > > > + * a struct drm_dep_queue. The lifecycle of a job is:
> > > > > > > + *
> > > > > > > + * 1. **Allocation**: the driver allocates memory for the jo=
b (typically by
> > > > > > > + *    embedding struct drm_dep_job in a larger structure) an=
d calls
> > > > > > > + *    drm_dep_job_init() to initialise it. On success the jo=
b holds one
> > > > > > > + *    kref reference and a reference to its queue.
> > > > > > > + *
> > > > > > > + * 2. **Dependency collection**: the driver calls drm_dep_jo=
b_add_dependency(),
> > > > > > > + *    drm_dep_job_add_syncobj_dependency(), drm_dep_job_add_=
resv_dependencies(),
> > > > > > > + *    or drm_dep_job_add_implicit_dependencies() to register=
 dma_fence objects
> > > > > > > + *    that must be signalled before the job can run. Duplica=
te fences from the
> > > > > > > + *    same fence context are deduplicated automatically.
> > > > > > > + *
> > > > > > > + * 3. **Arming**: drm_dep_job_arm() initialises the job's fi=
nished fence,
> > > > > > > + *    consuming a sequence number from the queue. After armi=
ng,
> > > > > > > + *    drm_dep_job_finished_fence() returns a valid fence tha=
t may be passed to
> > > > > > > + *    userspace or used as a dependency by other jobs.
> > > > > > > + *
> > > > > > > + * 4. **Submission**: drm_dep_job_push() submits the job to =
the queue. The
> > > > > > > + *    queue takes a reference that it holds until the job's =
finished fence
> > > > > > > + *    signals and the job is freed by the put_job worker.
> > > > > > > + *
> > > > > > > + * 5. **Completion**: when the job's hardware work finishes =
its finished fence
> > > > > > > + *    is signalled and drm_dep_job_put() is called by the qu=
eue. The driver
> > > > > > > + *    must release any driver-private resources in &drm_dep_=
job_ops.release.
> > > > > > > + *
> > > > > > > + * Reference counting uses drm_dep_job_get() / drm_dep_job_p=
ut(). The
> > > > > > > + * internal drm_dep_job_fini() tears down the dependency xar=
ray and fence
> > > > > > > + * objects before the driver's release callback is invoked.
> > > > > > > + */
> > > > > > > +
> > > > > > > +#include <linux/dma-resv.h>
> > > > > > > +#include <linux/kref.h>
> > > > > > > +#include <linux/slab.h>
> > > > > > > +#include <drm/drm_dep.h>
> > > > > > > +#include <drm/drm_file.h>
> > > > > > > +#include <drm/drm_gem.h>
> > > > > > > +#include <drm/drm_syncobj.h>
> > > > > > > +#include "drm_dep_fence.h"
> > > > > > > +#include "drm_dep_job.h"
> > > > > > > +#include "drm_dep_queue.h"
> > > > > > > +
> > > > > > > +/**
> > > > > > > + * drm_dep_job_init() - initialise a dep job
> > > > > > > + * @job: dep job to initialise
> > > > > > > + * @args: initialisation arguments
> > > > > > > + *
> > > > > > > + * Initialises @job with the queue, ops and credit count fro=
m @args.  Acquires
> > > > > > > + * a reference to @args->q via drm_dep_queue_get(); this ref=
erence is held for
> > > > > > > + * the lifetime of the job and released by drm_dep_job_relea=
se() when the last
> > > > > > > + * job reference is dropped.
> > > > > > > + *
> > > > > > > + * Resources are released automatically when the last refere=
nce is dropped
> > > > > > > + * via drm_dep_job_put(), which must be called to release th=
e job; drivers
> > > > > > > + * must not free the job directly.
> > > > > > > + *
> > > > > > > + * Context: Process context. Allocates memory with GFP_KERNE=
L.
> > > > > > > + * Return: 0 on success, -%EINVAL if credits is 0,
> > > > > > > + *   -%ENOMEM on fence allocation failure.
> > > > > > > + */
> > > > > > > +int drm_dep_job_init(struct drm_dep_job *job,
> > > > > > > +		     const struct drm_dep_job_init_args *args)
> > > > > > > +{
> > > > > > > +	if (unlikely(!args->credits)) {
> > > > > > > +		pr_err("drm_dep: %s: credits cannot be 0\n", __func__);
> > > > > > > +		return -EINVAL;
> > > > > > > +	}
> > > > > > > +
> > > > > > > +	memset(job, 0, sizeof(*job));
> > > > > > > +
> > > > > > > +	job->dfence =3D drm_dep_fence_alloc();
> > > > > > > +	if (!job->dfence)
> > > > > > > +		return -ENOMEM;
> > > > > > > +
> > > > > > > +	job->ops =3D args->ops;
> > > > > > > +	job->q =3D drm_dep_queue_get(args->q);
> > > > > > > +	job->credits =3D args->credits;
> > > > > > > +
> > > > > > > +	kref_init(&job->refcount);
> > > > > > > +	xa_init_flags(&job->dependencies, XA_FLAGS_ALLOC);
> > > > > > > +	INIT_LIST_HEAD(&job->pending_link);
> > > > > > > +
> > > > > > > +	return 0;
> > > > > > > +}
> > > > > > > +EXPORT_SYMBOL(drm_dep_job_init);
> > > > > > > +
> > > > > > > +/**
> > > > > > > + * drm_dep_job_drop_dependencies() - release all input depen=
dency fences
> > > > > > > + * @job: dep job whose dependency xarray to drain
> > > > > > > + *
> > > > > > > + * Walks @job->dependencies, puts each fence, and destroys t=
he xarray.
> > > > > > > + * Any slots still holding a %DRM_DEP_JOB_FENCE_PREALLOC sen=
tinel =E2=80=94
> > > > > > > + * i.e. slots that were pre-allocated but never replaced =E2=
=80=94 are silently
> > > > > > > + * skipped; the sentinel carries no reference.  Called from
> > > > > > > + * drm_dep_queue_run_job() in process context immediately af=
ter
> > > > > > > + * @ops->run_job() returns, before the final drm_dep_job_put=
().  Releasing
> > > > > > > + * dependencies here =E2=80=94 while still in process contex=
t =E2=80=94 avoids calling
> > > > > > > + * xa_destroy() from IRQ context if the job's last reference=
 is later
> > > > > > > + * dropped from a dma_fence callback.
> > > > > > > + *
> > > > > > > + * Context: Process context.
> > > > > > > + */
> > > > > > > +void drm_dep_job_drop_dependencies(struct drm_dep_job *job)
> > > > > > > +{
> > > > > > > +	struct dma_fence *fence;
> > > > > > > +	unsigned long index;
> > > > > > > +
> > > > > > > +	xa_for_each(&job->dependencies, index, fence) {
> > > > > > > +		if (unlikely(fence =3D=3D DRM_DEP_JOB_FENCE_PREALLOC))
> > > > > > > +			continue;
> > > > > > > +		dma_fence_put(fence);
> > > > > > > +	}
> > > > > > > +	xa_destroy(&job->dependencies);
> > > > > > > +}
> > > > > > > +
> > > > > > > +/**
> > > > > > > + * drm_dep_job_fini() - clean up a dep job
> > > > > > > + * @job: dep job to clean up
> > > > > > > + *
> > > > > > > + * Cleans up the dep fence and drops the queue reference hel=
d by @job.
> > > > > > > + *
> > > > > > > + * If the job was never armed (e.g. init failed before drm_d=
ep_job_arm()),
> > > > > > > + * the dependency xarray is also released here.  For armed j=
obs the xarray
> > > > > > > + * has already been drained by drm_dep_job_drop_dependencies=
() in process
> > > > > > > + * context immediately after run_job(), so it is left untouc=
hed to avoid
> > > > > > > + * calling xa_destroy() from IRQ context.
> > > > > > > + *
> > > > > > > + * Warns if @job is still linked on the queue's pending list=
, which would
> > > > > > > + * indicate a bug in the teardown ordering.
> > > > > > > + *
> > > > > > > + * Context: Any context.
> > > > > > > + */
> > > > > > > +static void drm_dep_job_fini(struct drm_dep_job *job)
> > > > > > > +{
> > > > > > > +	bool armed =3D drm_dep_fence_is_armed(job->dfence);
> > > > > > > +
> > > > > > > +	WARN_ON(!list_empty(&job->pending_link));
> > > > > > > +
> > > > > > > +	drm_dep_fence_cleanup(job->dfence);
> > > > > > > +	job->dfence =3D NULL;
> > > > > > > +
> > > > > > > +	/*
> > > > > > > +	 * Armed jobs have their dependencies drained by
> > > > > > > +	 * drm_dep_job_drop_dependencies() in process context after=
 run_job().     =20
> > > > > >=20
> > > > > > Just want to clear the confusion and make sure I get this right=
 at the
> > > > > > same time. To me, "process context" means a user thread enterin=
g some
> > > > > > syscall(). What you call "process context" is more a "thread co=
ntext" to
> > > > > > me. I'm actually almost certain it's always a kernel thread (a =
workqueue
> > > > > > worker thread to be accurate) that executes the drop_deps() aft=
er a
> > > > > > run_job().     =20
> > > > >=20
> > > > > Some of context comments likely could be cleaned up. 'process con=
text'
> > > > > here either in user context (bypass path) or run job work item.
> > > > >    =20
> > > > > >      =20
> > > > > > > +	 * Skip here to avoid calling xa_destroy() from IRQ context.
> > > > > > > +	 */
> > > > > > > +	if (!armed)
> > > > > > > +		drm_dep_job_drop_dependencies(job);     =20
> > > > > >=20
> > > > > > Why do we need to make a difference here. Can't we just assume =
that the
> > > > > > hole drm_dep_job_fini() call is unsafe in atomic context, and h=
ave a
> > > > > > work item embedded in the job to defer its destruction when _pu=
t() is
> > > > > > called in a context where the destruction is not allowed?
> > > > > >      =20
> > > > >=20
> > > > > We already touched on this, but the design currently allows the l=
ast job
> > > > > put from dma-fence signaling path (IRQ).   =20
> > > >=20
> > > > It's not much about the last _put and more about what happens in the
> > > > _release() you pass to kref_put(). My point being, if you assume
> > > > something in _release() is not safe to be done in an atomic context,
> > > > and _put() is assumed to be called from any context, you might as w=
ell   =20
> > >=20
> > > No. DRM_DEP_QUEUE_FLAGS_JOB_PUT_IRQ_SAFE indicates that the entire job
> > > put (including release) is IRQ-safe. If the documentation isn=E2=80=
=99t clear, I
> > > can clean that up. Some of my comments here [1] try to explain this
> > > further.
> > >=20
> > > Setting DRM_DEP_QUEUE_FLAGS_JOB_PUT_IRQ_SAFE makes a job analogous to=
 a
> > > dma-fence whose release must be IRQ-safe, so there is precedent for
> > > this. I didn=E2=80=99t want to unilaterally require that all job rele=
ases be
> > > IRQ-safe, as that would conflict with existing DRM scheduler jobs=E2=
=80=94hence
> > > the flag.
> > >=20
> > > The difference between non-IRQ-safe and IRQ-safe job release is only
> > > about 12 lines of code. =20
> >=20
> > It's not just about the number of lines of code added to the core to
> > deal with that case, but also complexity of the API that results from
> > these various modes.
> >  =20
>=20
> Fair enough.
>=20
> > > I figured that if we=E2=80=99re going to invest the time
> > > and effort to replace DRM sched, we should aim for the best possible
> > > implementation. Any driver can opt-in here and immediately get less C=
PU
> > > ultization and power savings. I will try to figure out how to measure
> > > this and get some number here. =20
> >=20
> > That's key here. My gut feeling is that we have so much deferred
> > already that adding one more work to the workqueue is not going to
> > hurt in term of scheduling overhead (no context switch if it's
> > scheduled on the same workqueue). Job cleanup is just the phase =20
>=20
> Signaling of fences in many drivers occurs in hard IRQ context rather
> than in a work queue. I agree that if you are signaling fences from a
> work queue, the overhead of another work item is minimal.

I'm talking about the drm_dep_queue_run_job_queue() call which in turn
calls queue_work() when a job gets reported as done. That, I think, is
the most likely path, isn't it?

>=20
> > following the job_done() event, which also requires a deferred work to
> > check progress on the queue anyway. And if you move the entirety of the=
 =20
>=20
> Yes, I see Panthor signals fences from a work queue by looking at the
> seqnos, but again, in many drivers this flow is IRQ-driven for fence
> signaling latency reasons.

I'm not talking about the signalling of the done_fence, but the work
that's used to check progress on a job queue
(drm_dep_queue_run_job_queue()).

> > >  =20
> > > > >=20
> > > > > Once arm() is called there is a guarnette the run_job path is cal=
led
> > > > > either via bypass or run job work item.   =20
> > > >=20
> > > > Sure.
> > > >    =20
> > >=20
> > > Let=E2=80=99s not gloss over this=E2=80=94this is actually a huge dif=
ference from DRM
> > > sched. One of the biggest problems I found with DRM sched is that if =
you
> > > call arm(), run_job() may or may not be called. Without this guarante=
e,
> > > you can=E2=80=99t do driver-side bookkeeping in arm() that is later r=
eleased in
> > > run_job(), which would otherwise simplify the driver design. =20
> >=20
> > You can do driver-side book-keeping after all jobs have been
> > successfully initialized, which include arming their fences. The key
> > turning point is when you start exposing those armed fences, not
> > when you arm them. See below.
> >  =20
>=20
> There is still the seqno critical section which starts at arm() and
> closed at push() or drop of fence.

That's orthogonal to the rule that says nothing after _arm() can
fail, I think. To guarantee proper job ordering, you need extra locking
(at the moment, we rely on the VM resv lock to serialize this in
Panthor).

> > >=20
> > > In my opinion, it=E2=80=99s best and safest to enforce a no-failure p=
olicy
> > > between arm() and push(). =20
> >=20
> > I don't think it's safer, it's just the semantics that have been
> > defined by drm_sched/dma_fence and that we keep forcing ourselves
> > into. I'd rather have a well defined dma_fence state that says "that's
> > it, I'm exposed, you have to signal me now", than this half-enforced
> > arm()+push() model.
> >  =20
>=20
> So what is the suggestion here =E2=80=94 move the asserts I have from arm=
() to
> something like begin_push()? We could add a dma-fence state toggle there
> as well if we can get that part merged into dma-fence. Or should we just
> drop the asserts/lockdep checks between arm() and push() completely? I=E2=
=80=99m
> open to either approach here.

If we can have that INACTIVE flag added, and the associated
dma_fence_init[64]_inactive() variants, I would say, we call
dma_fence_init[64]_inactive() in _arm(), and we call
dma_fence_set_active() in _push(). It'd still be valuable to have some
sort of delimitation for the submission through some block-like macro
with an associated context to which we can attach states and allow for
more (optional?) runtime-checks.

>=20
> > >=20
> > > FWIW, this came up while I was reviewing AMDXDNA=E2=80=99s DRM schedu=
ler usage,
> > > which had the exact issue I described above. I pointed it out and got=
 a
> > > reply saying, =E2=80=9Cwell, this is an API issue, right?=E2=80=9D=E2=
=80=94and they were
> > > correct, it is an API issue.
> > >  =20
> > > > >    =20
> > > > > >=20
> > > > > > In general, I wonder if we should distinguish between "armed" a=
nd
> > > > > > "publicly exposed" to help deal with this intra-batch dep thing=
 without
> > > > > > resorting to reservation and other tricks like that.
> > > > > >      =20
> > > > >=20
> > > > > I'm not exactly sure what you suggesting but always open to ideas=
.   =20
> > > >=20
> > > > Right now _arm() is what does the dma_fence_init(). But there's an
> > > > extra step between initializing the fence object and making it
> > > > visible to the outside world. In order for the dep to be added to t=
he
> > > > job, you need the fence to be initialized, but that's not quite
> > > > external visibility, because the job is still very much a driver
> > > > object, and if something fails, the rollback mechanism makes it so =
all
> > > > the deps are dropped on the floor along the job that's being destro=
yed.
> > > > So we won't really wait on this fence that's never going to be
> > > > signalled.
> > > >=20
> > > > I see what's appealing in pretending that _arm() =3D=3D externally-=
visible,
> > > > but it's also forcing us to do extra pre-alloc (or other pre-init)
> > > > operations that would otherwise not be required in the submit path.=
 Not
> > > > a hill I'm willing to die on, but I just thought I'd mention the fa=
ct I
> > > > find it weird that we put extra constraints on ourselves that are n=
ot
> > > > strictly needed, just because we fail to properly flag the dma_fence
> > > > visibility transitions.   =20
> > >=20
> > > See the dma-resv example above. I=E2=80=99m not willing to die on thi=
s hill
> > > either, but again, in my opinion, for safety and as an API-level
> > > contract, enforcing arm() as a no-failure point makes sense. It preve=
nts
> > > drivers from doing anything dangerous like the dma-resv example, which
> > > is an extremely subtle bug. =20
> >=20
> > That's a valid point, but you're not really enforcing things at
> > compile/run-time it's just "don't do this/that" in the docs. If you
> > encode the is_active() state at the dma_fence level, properly change
> > the fence state anytime it's about to be added to a public container,
> > and make it so an active fence that's released without being signalled
> > triggers a WARN_ON(), you've achieved more. Once you've done that, you
> > can also relax the rule that says that "an armed fence has to be
> > signalled" to "a fence that's active has to be signalled". With this,
> > the pre-alloc for intra-batch deps in your drm_dep_job::deps xarray is
> > no longer required, because you would be able to store inactive fences =
=20
>=20
> I wouldn=E2=80=99t go that far or say it=E2=80=99s that simple. This woul=
d require a
> fairly large refactor of Xe=E2=80=99s VM bind pipeline to call arm() earl=
ier,
> and I=E2=80=99m not even sure it would be possible. Between arm() and pus=
h(),
> the seqno critical section still remains and requires locking, in
> particulay the tricky case is kernel binds (e.g., page fault handling)
> which use the same queue. Multiple threads can issue kernel binds
> concurrently, as our page fault handler is multi-threaded, similar
> to the CPU page fault handler, so critical section between arm() and
> push() is very late in the pipeline tightly protected by a lock.

This sounds like a different issue to me. That's the constraint that
says _arm() and _push() ordering needs to be preserved to guarantee
that jobs are properly ordered on the job queue. But that's orthogonal
to the rule that says nothing between _arm() and _push() on a given job
can fail. Let's take the Panthor case as an example:

	for_each_job_in_batch() {
		// This acquires the VM resv lock, and all BO locks
		// Because queues target a specific VM and all jobs
		// in the a SUBMIT must target the same VM, this
		// guarantees that seqno allocation happening further
		// down (when _arm() is called) won't be interleaved
		// with other concurrent submissions to the same queues.
		lock_and_prepare_resvs()

		<--- Seqno critical section starts here
	}

 	for_each_job_in_batch() {
		// If something fails here, we drop all the jobs that
		// are part of this SUBMIT, and the resv locks are
		// released as part of the rollback. This means we
		// consumed but didn't use the seqnos, thus creating
		// a whole on the timeline, which is armless, as long
		// as those seqnos are not recycled.
		ret =3D faillible_stuf()
 		if (ret)
 			goto rollback;
=20
 		arm(job)
 	}
=20
 	// Nothing can fail after this point
=20
 	for_each_job_in_batch() {
		// resv locks are released here, unblocking other
		// concurrent submissions
 		update_resvs(job->done_fence)

		<--- Seqno critical section ends here in case of success

 		push(job)
 	}
=20
	update_submit_syncobjs();

rollback:
	unlock_resvs()
	<--- Seqno critical section ends here in case of success
...

How wide your critical seqno section is is up to each driver, really.

>=20
> > there, as long as they become active before the job is pushed.
> >  =20
> > >  =20
> > > >=20
> > > > On the rust side it would be directly described through the type
> > > > system (see the Visibility attribute in Daniel's branch[1]). On C s=
ide,
> > > > this could take the form of a new DMA_FENCE_FLAG_INACTIVE (or which=
ever
> > > > name you want to give it). Any operation pushing the fence to public
> > > > container (dma_resv, syncobj, sync_file, ...) would be rejected when
> > > > that flag is set. At _push() time, we'd clear that flag with a
> > > > dma_fence_set_active() helper, which would reflect the fact the fen=
ce
> > > > can now be observed and exposed to the outside world.
> > > >    =20
> > >=20
> > > Timeline squashing is problematic due to the DMA_FENCE_FLAG_INACTIVE
> > > flag. When adding a fence to dma-resv, fences that belong to the same
> > > timeline are immediately squashed. A later transition of the fence st=
ate
> > > completely breaks this behavior. =20
> >=20
> > That's exactly my point: as soon as you want to insert the fence to a
> > public container, you have to make it "active", so it will never be
> > rolled back to the previous entry in the resv. Similarly, a
> > wait/add_callback() on an inactive fence should be rejected.
> >  =20
>=20
> This is bit bigger dma-fence / treewide level change but in general I
> believe this is a good idea.

I agree it's a bit more work. It implies patching containers to reject
insertion when the INACTIVE flag is set. If we keep !INACTIVE as the
default (__dma_fence_init(INACTIVE) being an opt-in), fence emitters can
be moved to this model progressively though.
