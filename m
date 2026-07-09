Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FDB7C44508
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 10:08:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF4DE10F4BD;
	Thu,  9 Jul 2026 10:08:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="dS6pQIXj";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0602E10F4BF
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 10:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1783591701;
 bh=PT0Lwt2J8Kwx7GXpwDEVhaGkNF96i6rocr2DnxgpRVE=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=dS6pQIXjNHZE/6Sf6LK+XFNq2f3/Dx/M7LGYF7A40e3/H7OplRKmQlfAjARxYA/OT
 Rfd2BJHZWLX17Iz2O1OlqsLbAkM73kKnug1LthL1fbBn9oj5gC8EK4IRyFum/KqiwN
 aQooyVhC6LjULnYtL0aqi+lXFlwQqV0rXSRZbSb6ywklSa4E3stbH/g/SPr9EedR44
 hU+dKFhgj1n+pSBTzGWppqMc+p0ngzLKWVxJjwtmv4YqIDzRux+Ghuwd+9f4gslYQN
 tTdRZERslj2N/WzQ9lmstVk139BXRIcVD6njA5kHaM/aAkoepH/14QD0SLVqGUYpaC
 97wD7fYn8/fOg==
Received: from fedora-2.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id C737617E05E8;
 Thu, 09 Jul 2026 12:08:20 +0200 (CEST)
Date: Thu, 9 Jul 2026 12:08:15 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Matthew Brost <matthew.brost@intel.com>
Cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 <dri-devel@lists.freedesktop.org>, Steven Price <steven.price@arm.com>,
 "Liviu Dudau" <liviu.dudau@arm.com>, Chia-I Wu <olvaffe@gmail.com>, Danilo
 Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>,
 <kernel-dev@igalia.com>
Subject: Re: [RFC 0/8] DRM scheduler kthread_worker for submission latency
 improvements
Message-ID: <20260709120815.57185e05@fedora-2.home>
In-Reply-To: <ak9T5V6BQE2bojZs@gsse-cloud1.jf.intel.com>
References: <20260702143745.79293-1-tvrtko.ursulin@igalia.com>
 <akd/ae5VGQrsWqsf@gsse-cloud1.jf.intel.com>
 <5963b079-cb44-4cd4-be56-f47bf3f15e0e@igalia.com>
 <akwyNSXO+QspyoBx@gsse-cloud1.jf.intel.com>
 <akym7rllMDFFcz8q@gsse-cloud1.jf.intel.com>
 <992e86a0-990c-46ab-8816-cf3c030d274a@igalia.com>
 <ak63Qzqxn1k9ezEd@gsse-cloud1.jf.intel.com>
 <20260709092552.256e2b3f@fedora-2.home>
 <ak9T5V6BQE2bojZs@gsse-cloud1.jf.intel.com>
Organization: Collabora
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
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

On Thu, 9 Jul 2026 00:55:17 -0700
Matthew Brost <matthew.brost@intel.com> wrote:

> On Thu, Jul 09, 2026 at 09:25:52AM +0200, Boris Brezillon wrote:
> > On Wed, 8 Jul 2026 13:46:59 -0700
> > Matthew Brost <matthew.brost@intel.com> wrote:
> >  =20
> > > On Wed, Jul 08, 2026 at 06:01:55PM +0100, Tvrtko Ursulin wrote: =20
> > > >=20
> > > > On 07/07/2026 08:12, Matthew Brost wrote:   =20
> > > > > On Mon, Jul 06, 2026 at 03:54:45PM -0700, Matthew Brost wrote:   =
=20
> > > > > > On Mon, Jul 06, 2026 at 01:41:01PM +0100, Tvrtko Ursulin wrote:=
   =20
> > > > > > >=20
> > > > > > > On 03/07/2026 10:22, Matthew Brost wrote:   =20
> > > > > > > > On Thu, Jul 02, 2026 at 03:37:37PM +0100, Tvrtko Ursulin wr=
ote:   =20
> > > > > > > > > The problem statement is explained quite well and succinc=
tly at:
> > > > > > > > > https://gitlab.freedesktop.org/panfrost/linux/-/work_item=
s/49
> > > > > > > > >=20
> > > > > > > > > Essentially, on a system (over)loaded with a lot of runna=
ble CPU processes, a
> > > > > > > > > high-priority DRM client gets latency injected into the G=
PU submission path due
> > > > > > > > > to the DRM scheduler use of workqueues.
> > > > > > > > >=20
> > > > > > > > > This patch series proposes to replace the workqueues with=
 kthread_work and
> > > > > > > > > priority inheritance to solve this problem.
> > > > > > > > >=20
> > > > > > > > > In the above linked issue Chia-I benchmarked the submit l=
atencies which
> > > > > > > > > show a striking improvement:
> > > > > > > > >=20
> > > > > > > > > 		median	95%	99%
> > > > > > > > >     before	41us	1.5ms	2.6ms
> > > > > > > > >      after	15us	19us	24us   =20
> > > > > > > >=20
> > > > > > > > Can you give more information on these numbers? e.g., What =
you ran / how
> > > > > > > > you measured these. It is hard to argue with numbers.   =20
> > > > > > >=20
> > > > > > > I believe Chia-I observed latency on some production hw/sw an=
d then wrote a
> > > > > > > synthetic benchmark to test it more easily. Details are in th=
e above linked
> > > > > > > issue.
> > > > > > >    =20
> > > > > >=20
> > > > > > Thanks, I see this now. Part of the problem, as far as I can te=
ll, is
> > > > > > that fences are signaled from work items rather than directly f=
rom IRQ
> > > > > > context.
> > > > > >=20
> > > > > > For example:
> > > > > >=20
> > > > > > "There is another 2.5 ms of scheduling latency from
> > > > > > panthor_sched_report_fw_events() (running on irq/105-panthor, P=
ID 257)
> > > > > > to process_fw_events_work() (running on kworker/u32:1, PID 62)."
> > > > > >=20
> > > > > > I assume this is only addressing the scheduling portion of the =
latency,
> > > > > > but you also mentioned a 9.5 ms delay for vkQueueWaitIdle(), wh=
ere part
> > > > > > of the latency appears to be on the signaling side due to the w=
orker
> > > > > > thread.
> > > > > >    =20
> > > > > > > > > This is obviously really good for preventing compositors =
from missing frames and   =20
> > > > > > > >=20
> > > > > > > > Modern compositors do not pass render-job fences to draw jo=
bs as input
> > > > > > > > dependencies. On Wayland, this functionality is provided by
> > > > > > > > linux-drm-syncobj-v1 and is enabled by default on Ubuntu 24=
.10 and
> > > > > > > > later. SurfaceFlinger has also operated this way for quite =
some time.
> > > > > > > >=20
> > > > > > > > The obvious solution for compositors is to submit work dire=
ctly through
> > > > > > > > the ioctl (i.e., bypass path in sched) when there are no in=
put
> > > > > > > > dependencies, which should be the common case. The main exc=
eption is
> > > > > > > > when one of the BOs mapped into the compositor is migrating=
 or otherwise
> > > > > > > > busy (i.e., a BO has a fence in a kernel dma-resv slot).   =
=20
> > > > > > >=20
> > > > > > > You mean the direct submit RFC you floated some time ago? Wha=
t was the
> > > > > > > verdict on that one, wasn't it rejected?
> > > > > > >    =20
> > > > > >=20
> > > > > > I had some patches for DRM sched that I never posted. It turned=
 out to
> > > > > > be a little tricky because of some other quirks in DRM sched, b=
ut it was
> > > > > > still roughly 100 LoC plus an additional lock.
> > > > > >    =20
> > > > >=20
> > > > > Side note: I quickly rebased DRM DEP here [1] and prototyped some=
 RT
> > > > > solutions.
> > > > >=20
> > > > > I added a DRM_DEP_QUEUE_FLAGS_RT flag to internally choose betwee=
n a
> > > > > workqueue and kthread_work, and to enable FIFO scheduling in [2].=
 Most
> > > > > of the details are hidden internally, but I had to make a few sma=
ll
> > > > > changes in Xe to support this on the driver side [3].
> > > > >=20
> > > > > Putting aside whether or when DRM DEP will land, if DRM sched rea=
lly
> > > > > wants FIFO scheduling instead of bypass (the IMO this is somewhat
> > > > > questionable), I think the approach I took in DRM DEP makes a lot=
 more
> > > > > sense. I haven't looked into what changes would be required in DRM
> > > > > sched, though; hopefully it wouldn't be too messy.
> > > > >=20
> > > > > Of course, kthreads are now directly exposed to userspace, but th=
is
> > > > > would be limited to privileged userspace with FIFO scheduling
> > > > > capabilities, which seems reasonable. Additionally, this approach=
 does
> > > > > not require the kind of large paradigm shifts proposed by this se=
ries.   =20
> > > >=20
> > > > This sounds plausible and TBH I also considered worker duality. If =
you look
> > > > at my series I wrap everything to drm_sched_work and drm_sched_work=
er so
> > > > drivers do not even have to know what is the underlying implementat=
ion.
> > > >    =20
> > >=20
> > > You could probably abstract this to some extent, but any driver-side
> > > functions that process work on scheduler workers would still require
> > > dedicated function signatures. Perhaps some creative macros could do
> > > something like:
> > >=20
> > > DRM_SCHED_DECL_DRIVER_WORK_FUNC(driver_sched, work_func);
> > > DRM_SCHED_INIT_DRIVER_WORK_FUNC(driver_sched, work_func);
> > >=20
> > > However, this would only eliminate functions that perform a
> > > `container_of()` conversion or use an `if` statement to select between
> > > workqueues and `kthread_work`. =20
> >=20
> > Honestly, I'm questioning the viability of such an hybrid design. Not
> > only this makes the code base even harder to reason about (and thus,
> > harder to maintain), but if you think about it, the only reason we got =
=20
>=20
> If this is hard to maintain or reason about, then the scheduler is
> broken. It took me roughly 10 minutes to modify a branch with DRM dep
> and Xe to support a hybrid design, and another 20 minutes or so to
> figure out how to run an Xe test with FIFO scheduling :). It shouldn't
> be difficult to do the same in DRM sched either. If it is, that only
> highlights why I think DRM dep is a good idea.
>=20
> > here is because we pretended the full/monolithic drm_sched stack was a
> > good fit for this FW-scheduler use case, and the reality is that it's
> > not.
> >=20
> > What we need for this FW-scheduler case is a simple per-context FIFO
> > with dep tracking. The KMD can then decide when to pull jobs from
> > this FIFO with its own deferred work model (workqueues, kthread or
> > whatever). All it needs to have is:
> >=20
> > - a way to initialize the job and its deps (so basically the
> >   drm_sched_job_xxx() helpers)
> > - a way to queue a job to this FIFO (something like
> >   drm_sched_entity_push_job(), but maybe simpler)
> > - a way to evaluate if the first job in the queue is ready for
> >   execution
> > - a way to register a callback for asynchronous queue/job readiness
> >   re-evaluation. That would basically be called on a dep fence callback
> >   call, and defers the responsibility of how the re-evaluation is done
> >   to the driver. If you're using kthreads, you'll just be issuing a
> >   kthread_queue_work() from this callback. If you want workqueues, you'd
> >   be using queue_work_on(), etc.
> >=20
> > The key here, is that the framework no longer decides the deferred work
> > model the driver has to use. This push/pull model makes it so the driver
> > is in control at all times, which also simplifies things like teardown,
> > or rather, make it so drm_sched is not in the way of driver specific
> > teardown sequences. =20
>=20
> drm_sched teardowns are in fact awful.
>=20
> >=20
> > I know some of these concepts have been discussed with Philipp and
> > Danilo for the JobQueue implementation they intend to have on the
> > rust-side. I also know that they are not particularly thrilled by this
> > push/pull model, I think they're more going for a solution where jobs
> > are pushed to the driver when they are ready for execution, which
> > requires having their own worker/work to defer the run_job() call, so
> > back to the problem that the framework enforces the execution model.
> >  =20
>=20
> This all sounds nice, but my initial reaction is that you're asking the
> driver to do a lot of things that it will likely get wrong=E2=80=94for ex=
ample,
> stopping and starting queues, DMA-fence rules,

drm_sched is not doing much for that actually. You can get things wrong
and still not notice, or notice it, but too late. All it does is provide
a set of helpers to stop/start the main scheduler, and people have
copied the pattern that exist in other drivers to get things somewhat
correct.

Sure, the stop/start of your HW queues is something you'll have to do,
but it won't be as complicated as it is today, because the driver is
the one pulling jobs out of the job queue, so if it knows it's stopping
the HW queue, it can stop pulling jobs from there.

As for the fence rules, I'm not too sure what the risk is compared to
what we have today. Ultimately, what guarantees that you do the right
thing is lockdep not complaining where you're in a dma_fence_signalling
section, or drivers signaling the fences at teardown (which can be
automated through helpers too).

> tracking jobs to
> completion,

None of the drm_sched infra helped with that in Panthor: we still have
to track in-flight jobs anyway and do the right thing on a reset when
the context has in-flight jobs. Sure, drm_sched has extra checks, plus
a way to push jobs back to the pending list on resumption, but in case
of Panthor, it didn't solve much, and most of the time, it's actually
in the way. Now, I'm not saying Panthor is the alpha & omega when it
comes to these things, but I'd much rather have a component-base
approach, where drivers can pick the things then need and glue it
together, instead of having this monolithic design that's really meant
to be used for pure HW queues with SW queues on top, and not FW queues.

> handling timeouts, managing object lifetimes,

Yet again, lifetime would benefit from this split I think: as soon as
the job leaves the job queue (FIFO), ownership is transferred to the
driver, which makes things a lot easier to reason about than the
current "job is passed to the driver, but it's still owned by the
scheduler" and you to do shenanigans on a pre/post reset. All of a
sudden, this decision to re-issue jobs or not is left to the driver,
which, when it does, passes ownership back to the job queue.

Same for timeouts, it's up to the driver to decide at which level it's
placed, which would prevent the spurious timeouts issue we had in
Panthor, because GPU contexts are not always resident when jobs are
passed to the driver (second layer of scheduling there).

> and
> implementing teardown flows.

Teardown flow is probably where this new model would be the most
beneficial, because the job queue is just a passive component, so, as
soon as the driver decides that it wants to stop pulling jobs from it,
it happens, period. Now, there's of course other components you have to
stop to guarantee that in-flight jobs are either fully killed, or land
before the rest of the teardown happens. It's another case where I
didn't find drm_sched particularly useful, because you can get things
wrong still, and all it adds is extra churn because things can still be
pushed while you're in the process of declaring the HW queue dead.

> Consequently, DRM sched has historically
> gotten many of these things wrong as well, although the concepts you
> want a scheduler to provide are there=E2=80=94they're just implemented po=
orly.

There might be a bit of that, but there's also a lot of FW-scheduling
is not the same as global-HW-queue-scheduling. There's basically a whole
layer that's gone, because the queue is no longer global, but instead
per GPU-context. So basically, all the heavy-lifted logic in
drm_sched_main, and the teardown/pause/resume complexity is gone,
because when you're touching a queue, it has no impact on other queues.

>=20
> Another major problem with what you're suggesting is that you
> essentially have to accept that a ready job may be pushed to the driver
> from IRQ context, since fences can signal from IRQ context.

That's a case for proper documentation, I think. Something along the
lines of "Don't ever do anything from the ::evaluate() callback other
than queuing a re-evaluation through some deferral mechanism, like
workqueue or kthread_worker". Lockdep should do the rest. Providing
default helpers for kthread_work/work_struct would certainly point
users in the right direction.

> That's a
> massive can of worms, and I know firsthand what a terrible idea it can
> be because i915 did exactly that.

I'd argue that, as it is today, drm_sched is already a massive can of
worms for these FW-scheduler use cases, otherwise we wouldn't be having
this discussion :P. I'm not sure getting rid of it in favor of
something simpler/modular would be significantly worse, especially not
if we can provide semi-generic components that can be pulled by drivers
to leverage some of the tricky aspects you mentioned (per-HW/FW-queue
timeout, semi-automatic dma_fence_signalling annotation in
work_item/kthread_work implems, ...). That's basically the things we've
been discussing for months with Philipp and Danilo.
