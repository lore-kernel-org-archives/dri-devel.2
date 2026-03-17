Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63FE6F33817
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 08:48:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB2EF10E5BC;
	Tue, 17 Mar 2026 08:48:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="GBimsIHb";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD4C210E5BA;
 Tue, 17 Mar 2026 08:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1773737310;
 bh=uWG43mq6Ow0wkUJ2a+DE5ZgiUmqSH+G8DOcUFGaWha8=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=GBimsIHb1sNrkyOsleIQj9hALdYcV0fJ5j6sMHC9U25bh2q6NH+6HD7KrxjUUt8U7
 3Z8R5M9UV7GtOtmno/7nWPmZRaLEiAPLMGiDgOOGw5jvDyshucC+bSSoHq0KNhMFNY
 FqOUA48vQMDWnAUKx5MlM218cyaxRI8VgK9k9aARxeDLQ3TAtRLEBWo52zJUnj4IOY
 Wsbk2jKv5CYpbhlx24UF13iiuYjl4JZ0voPoYTN//XvVSq84tTsXJUnipinMlnW3sm
 PAvB2SW7IlGZT+V+3SsEbvb2jAdeXZgG5OHtwh+tNRqcsPsYc43nbcJK+k51+ehqFS
 /qj5/Q5mul7/w==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id EDBFC17E026C;
 Tue, 17 Mar 2026 09:48:29 +0100 (CET)
Date: Tue, 17 Mar 2026 09:48:24 +0100
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
Message-ID: <20260317094824.58cc34e4@fedora>
In-Reply-To: <abjlFshfpJXCz8z8@lstrano-desk.jf.intel.com>
References: <20260316043255.226352-1-matthew.brost@intel.com>
 <20260316043255.226352-3-matthew.brost@intel.com>
 <20260316101601.464823ae@fedora>
 <abjlFshfpJXCz8z8@lstrano-desk.jf.intel.com>
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

On Mon, 16 Mar 2026 22:22:30 -0700
Matthew Brost <matthew.brost@intel.com> wrote:

> On Mon, Mar 16, 2026 at 10:16:01AM +0100, Boris Brezillon wrote:
> > Hi Matthew,
> >=20
> > On Sun, 15 Mar 2026 21:32:45 -0700
> > Matthew Brost <matthew.brost@intel.com> wrote:
> >  =20
> > > Diverging requirements between GPU drivers using firmware scheduling
> > > and those using hardware scheduling have shown that drm_gpu_scheduler=
 is
> > > no longer sufficient for firmware-scheduled GPU drivers. The technical
> > > debt, lack of memory-safety guarantees, absence of clear object-lifet=
ime
> > > rules, and numerous driver-specific hacks have rendered
> > > drm_gpu_scheduler unmaintainable. It is time for a fresh design for
> > > firmware-scheduled GPU drivers=E2=80=94one that addresses all of the
> > > aforementioned shortcomings.
> > >=20
> > > Add drm_dep, a lightweight GPU submission queue intended as a
> > > replacement for drm_gpu_scheduler for firmware-managed GPU schedulers
> > > (e.g. Xe, Panthor, AMDXDNA, PVR, Nouveau, Nova). Unlike
> > > drm_gpu_scheduler, which separates the scheduler (drm_gpu_scheduler)
> > > from the queue (drm_sched_entity) into two objects requiring external
> > > coordination, drm_dep merges both roles into a single struct
> > > drm_dep_queue. This eliminates the N:1 entity-to-scheduler mapping
> > > that is unnecessary for firmware schedulers which manage their own
> > > run-lists internally.
> > >=20
> > > Unlike drm_gpu_scheduler, which relies on external locking and lifeti=
me
> > > management by the driver, drm_dep uses reference counting (kref) on b=
oth
> > > queues and jobs to guarantee object lifetime safety. A job holds a qu=
eue
> > > reference from init until its last put, and the queue holds a job ref=
erence
> > > from dispatch until the put_job worker runs. This makes use-after-free
> > > impossible even when completion arrives from IRQ context or concurrent
> > > teardown is in flight.
> > >=20
> > > The core objects are:
> > >=20
> > >   struct drm_dep_queue - a per-context submission queue owning an
> > >     ordered submit workqueue, a TDR timeout workqueue, an SPSC job
> > >     queue, and a pending-job list. Reference counted; drivers can emb=
ed
> > >     it and provide a .release vfunc for RCU-safe teardown. =20
> >=20
> > First of, I like this idea, and actually think we should have done that
> > from the start rather than trying to bend drm_sched to meet our =20
>=20
> Yes. Tvrtko actually suggested this years ago, and in my na=C3=AFvet=C3=
=A9 I
> rejected it. I=E2=80=99m eating my hat here.
>=20
> > FW-assisted scheduling model. That's also the direction me and Danilo
> > have been pushing for for the new JobQueue stuff in rust, so I'm glad
> > to see some consensus here.
> >=20
> > Now, let's start with the usual naming nitpick :D =3D> can't we find a
> > better prefix than "drm_dep"? I think I get where "dep" comes from (the
> > logic mostly takes care of job deps, and acts as a FIFO otherwise, no
> > real scheduling involved). It's kinda okay for drm_dep_queue, even
> > though, according to the description you've made, jobs seem to stay in
> > that queue even after their deps are met, which, IMHO, is a bit
> > confusing: dep_queue sounds like a queue in which jobs are placed until
> > their deps are met, and then the job moves to some other queue.
> >=20
> > It gets worse for drm_dep_job, which sounds like a dep-only job, rather
> > than a job that's queued to the drm_dep_queue. Same goes for
> > drm_dep_fence, which I find super confusing. What this one does is just
> > proxy the driver fence to provide proper isolation between GPU drivers
> > and fence observers (other drivers).
> >=20
> > Since this new model is primarily designed for hardware that have
> > FW-assisted scheduling, how about drm_fw_queue, drm_fw_job,
> > drm_fw_job_fence? =20
>=20
> We can bikeshed =E2=80=94 I=E2=80=99m open to other names, but I believe =
hardware
> scheduling can be built quite cleanly on top of this, so drm_fw_*
> doesn=E2=80=99t really work either.

I agree drm_fw_ is not great either. I think Philipp's name, JobQueue,
is a better fit.

> Check out a hardware-scheduler PoC built
> (today) on top of this in [1].

Yeah, I'm pretty sure we can add a layer on top to deal with HW GPU
queues (Danilo and Philipp proposed it already), I'm just not sure it
should be our primary focus, at least not until we have something
usable for the drivers that are currently written in rust. Doesn't mean
we shouldn't think about it and design the thing so it can be added
later, of course, but most of the time, perfect is the enemy of good.

>=20
> [1] https://gitlab.freedesktop.org/mbrost/xe-kernel-driver-svn-perf-6-15-=
2025/-/commit/22c8aa993b5c9e4ad0c312af2f3e032273d20966
>=20
> >  =20
> > >=20
> > >   struct drm_dep_job - a single unit of GPU work. Drivers embed this
> > >     and provide a .release vfunc. Jobs carry an xarray of input
> > >     dma_fence dependencies and produce a drm_dep_fence as their
> > >     finished fence.
> > >=20
> > >   struct drm_dep_fence - a dma_fence subclass wrapping an optional
> > >     parent hardware fence. The finished fence is armed (sequence
> > >     number assigned) before submission and signals when the hardware
> > >     fence signals (or immediately on synchronous completion).
> > >=20
> > > Job lifecycle:
> > >   1. drm_dep_job_init() - allocate and initialise; job acquires a
> > >      queue reference.
> > >   2. drm_dep_job_add_dependency() and friends - register input fences;
> > >      duplicates from the same context are deduplicated.
> > >   3. drm_dep_job_arm() - assign sequence number, obtain finished fenc=
e.
> > >   4. drm_dep_job_push() - submit to queue.
> > >=20
> > > Submission paths under queue lock:
> > >   - Bypass path: if DRM_DEP_QUEUE_FLAGS_BYPASS_SUPPORTED is set, the
> > >     SPSC queue is empty, no dependencies are pending, and credits are
> > >     available, the job is dispatched inline on the calling thread. =20
> >=20
> > I've yet to look at the code, but I must admit I'm less worried about
> > this fast path if it's part of a new model restricted to FW-assisted
> > scheduling. I keep thinking we're not entirely covered for so called
> > real-time GPU contexts that might have jobs that are not dep-free, and
> > if we're going for something new, I'd really like us to consider that
> > case from the start (maybe investigate if kthread_work[er] can be used
> > as a replacement for workqueues, if RT priority on workqueues is not an
> > option).
> >  =20
>=20
> I mostly agree, and I=E2=80=99ll look into whether kthread_work is better
> suited=E2=80=94if that=E2=80=99s the right model, it should be done up fr=
ont.
>=20
> But can you give a use case for real-time GPU contexts that are not
> dep-free? I personally don=E2=80=99t know of one.

Let alone real-time GPU contexts, you still have the concept of context
priority in both GL and Vulkan, on which jobs with deps are likely to
be queued, and if the dequeuing thread doesn't take this priority into
consideration, there's nothing differentiating a low-prio from an
high-prio context, thus partially defeating the priority you assign to
your FW queue (you can execute fast, but if the queuing to the FW queue
is slow, it's pointless).

As for real-time contexts, yes, right now the only use case I can think
of is compositors, and apparently those would pass dep-less submissions,
but claiming that this is the only use case we'll ever have for those RT
contexts is a bit of a risk I'd rather not take. Also, if we solve the
problem with kthreads with prios, it might be that we don't even need
this fastpath in the first place.

>=20
> > >   - Queued path: job is pushed onto the SPSC queue and the run_job
> > >     worker is kicked. The worker resolves remaining dependencies
> > >     (installing wakeup callbacks for unresolved fences) before calling
> > >     ops->run_job().
> > >=20
> > > Credit-based throttling prevents hardware overflow: each job declares
> > > a credit cost at init time; dispatch is deferred until sufficient
> > > credits are available.
> > >=20
> > > Timeout Detection and Recovery (TDR): a per-queue delayed work item
> > > fires when the head pending job exceeds q->job.timeout jiffies, calli=
ng
> > > ops->timedout_job(). drm_dep_queue_trigger_timeout() forces immediate
> > > expiry for device teardown.
> > >=20
> > > IRQ-safe completion: queues flagged DRM_DEP_QUEUE_FLAGS_JOB_PUT_IRQ_S=
AFE
> > > allow drm_dep_job_done() to be called from hardirq context (e.g. a
> > > dma_fence callback). Dependency cleanup is deferred to process context
> > > after ops->run_job() returns to avoid calling xa_destroy() from IRQ.
> > >=20
> > > Zombie-state guard: workers use kref_get_unless_zero() on entry and
> > > bail immediately if the queue refcount has already reached zero and
> > > async teardown is in flight, preventing use-after-free.
> > >=20
> > > Teardown is always deferred to a module-private workqueue (dep_free_w=
q)
> > > so that destroy_workqueue() is never called from within one of the
> > > queue's own workers. Each queue holds a drm_dev_get() reference on its
> > > owning struct drm_device, released as the final step of teardown via
> > > drm_dev_put(). This prevents the driver module from being unloaded
> > > while any queue is still alive without requiring a separate drain API=
. =20
> >=20
> > Thanks for posting this RFC. I'll try to have a closer look at the code
> > in the coming days, but given the diffstat, it might take me a bit of
> > time... =20
>=20
>=20
> I understand =E2=80=94 I=E2=80=99m a firehose when I get started. Hopeful=
ly a sane one,
> though.

One last note: I've seen a bunch of discussions that start to look like
some pissing contest between C and rust advocates. I've only started to
look at rust recently, in the context of Tyr (the rust re-implementation
of Panthor), and there's niceties in the language that I think make it
a good fit for the new JobQueue thing we've been discussing (Daniel
listed a bunch of them). I don't really mind who's going to end up
winning the trophy of this contest to be honest, but what I certainly
don't want is for us to be stuck with no solution at all because each
camp claims that their solution is best and none of them give up on
their ideas (basically what happened with the AGX driver). So please,
please, let's all take a step back, have a look at what each side has
done, keep the discussion constructive, and hopefully we'll end up with
a mix of ideas that makes the final solution better.

Regards,

Boris
