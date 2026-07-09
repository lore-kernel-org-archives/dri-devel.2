Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8544EC43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 07:26:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA6C310F437;
	Thu,  9 Jul 2026 07:26:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="Hp9sLlHV";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E40310F3E4
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 07:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1783581956;
 bh=6grb0IWGyea9BoVl/qlPEnv3GJER9y3LDEvNA38GsPY=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Hp9sLlHVO8yoDv/2yleSH+CxOec8dICuTaIE90Z+E2e8IQLBoMctbqTRRY2DxQaFO
 rIhikzbwqPhWHBg/iRT6S82VocO8aIo4UFaNtlK8pnlxqoHuxwtdIhYcWrbxSQ36JG
 7tlhSUBLmO0e+YkKwWvckIpAK4VZ09p6a5ZNikSFCoEsAYxobdfxtRHSv2YDgaVnTW
 u/lVFJIJI6BvUlKgylBBt8KacVhlTi+Kxf2TWtpJUlRRoBgcA2221OJgeYTyDhIJdA
 fgE3T4Wd+rcrIgu2ScAJncJNuoIxf2xZVn3bYVaSUjhBs0f+tkpu9ALXGD7gG08Hmi
 mxX/MeLt+Ngtw==
Received: from fedora-2.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 3DB5617E0720;
 Thu, 09 Jul 2026 09:25:56 +0200 (CEST)
Date: Thu, 9 Jul 2026 09:25:52 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Matthew Brost <matthew.brost@intel.com>
Cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 <dri-devel@lists.freedesktop.org>, Steven Price <steven.price@arm.com>,
 "Liviu Dudau" <liviu.dudau@arm.com>, Chia-I Wu <olvaffe@gmail.com>, Danilo
 Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>,
 <kernel-dev@igalia.com>
Subject: Re: [RFC 0/8] DRM scheduler kthread_worker for submission latency
 improvements
Message-ID: <20260709092552.256e2b3f@fedora-2.home>
In-Reply-To: <ak63Qzqxn1k9ezEd@gsse-cloud1.jf.intel.com>
References: <20260702143745.79293-1-tvrtko.ursulin@igalia.com>
 <akd/ae5VGQrsWqsf@gsse-cloud1.jf.intel.com>
 <5963b079-cb44-4cd4-be56-f47bf3f15e0e@igalia.com>
 <akwyNSXO+QspyoBx@gsse-cloud1.jf.intel.com>
 <akym7rllMDFFcz8q@gsse-cloud1.jf.intel.com>
 <992e86a0-990c-46ab-8816-cf3c030d274a@igalia.com>
 <ak63Qzqxn1k9ezEd@gsse-cloud1.jf.intel.com>
Organization: Collabora
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Wed, 8 Jul 2026 13:46:59 -0700
Matthew Brost <matthew.brost@intel.com> wrote:

> On Wed, Jul 08, 2026 at 06:01:55PM +0100, Tvrtko Ursulin wrote:
> > 
> > On 07/07/2026 08:12, Matthew Brost wrote:  
> > > On Mon, Jul 06, 2026 at 03:54:45PM -0700, Matthew Brost wrote:  
> > > > On Mon, Jul 06, 2026 at 01:41:01PM +0100, Tvrtko Ursulin wrote:  
> > > > > 
> > > > > On 03/07/2026 10:22, Matthew Brost wrote:  
> > > > > > On Thu, Jul 02, 2026 at 03:37:37PM +0100, Tvrtko Ursulin wrote:  
> > > > > > > The problem statement is explained quite well and succinctly at:
> > > > > > > https://gitlab.freedesktop.org/panfrost/linux/-/work_items/49
> > > > > > > 
> > > > > > > Essentially, on a system (over)loaded with a lot of runnable CPU processes, a
> > > > > > > high-priority DRM client gets latency injected into the GPU submission path due
> > > > > > > to the DRM scheduler use of workqueues.
> > > > > > > 
> > > > > > > This patch series proposes to replace the workqueues with kthread_work and
> > > > > > > priority inheritance to solve this problem.
> > > > > > > 
> > > > > > > In the above linked issue Chia-I benchmarked the submit latencies which
> > > > > > > show a striking improvement:
> > > > > > > 
> > > > > > > 		median	95%	99%
> > > > > > >     before	41us	1.5ms	2.6ms
> > > > > > >      after	15us	19us	24us  
> > > > > > 
> > > > > > Can you give more information on these numbers? e.g., What you ran / how
> > > > > > you measured these. It is hard to argue with numbers.  
> > > > > 
> > > > > I believe Chia-I observed latency on some production hw/sw and then wrote a
> > > > > synthetic benchmark to test it more easily. Details are in the above linked
> > > > > issue.
> > > > >   
> > > > 
> > > > Thanks, I see this now. Part of the problem, as far as I can tell, is
> > > > that fences are signaled from work items rather than directly from IRQ
> > > > context.
> > > > 
> > > > For example:
> > > > 
> > > > "There is another 2.5 ms of scheduling latency from
> > > > panthor_sched_report_fw_events() (running on irq/105-panthor, PID 257)
> > > > to process_fw_events_work() (running on kworker/u32:1, PID 62)."
> > > > 
> > > > I assume this is only addressing the scheduling portion of the latency,
> > > > but you also mentioned a 9.5 ms delay for vkQueueWaitIdle(), where part
> > > > of the latency appears to be on the signaling side due to the worker
> > > > thread.
> > > >   
> > > > > > > This is obviously really good for preventing compositors from missing frames and  
> > > > > > 
> > > > > > Modern compositors do not pass render-job fences to draw jobs as input
> > > > > > dependencies. On Wayland, this functionality is provided by
> > > > > > linux-drm-syncobj-v1 and is enabled by default on Ubuntu 24.10 and
> > > > > > later. SurfaceFlinger has also operated this way for quite some time.
> > > > > > 
> > > > > > The obvious solution for compositors is to submit work directly through
> > > > > > the ioctl (i.e., bypass path in sched) when there are no input
> > > > > > dependencies, which should be the common case. The main exception is
> > > > > > when one of the BOs mapped into the compositor is migrating or otherwise
> > > > > > busy (i.e., a BO has a fence in a kernel dma-resv slot).  
> > > > > 
> > > > > You mean the direct submit RFC you floated some time ago? What was the
> > > > > verdict on that one, wasn't it rejected?
> > > > >   
> > > > 
> > > > I had some patches for DRM sched that I never posted. It turned out to
> > > > be a little tricky because of some other quirks in DRM sched, but it was
> > > > still roughly 100 LoC plus an additional lock.
> > > >   
> > > 
> > > Side note: I quickly rebased DRM DEP here [1] and prototyped some RT
> > > solutions.
> > > 
> > > I added a DRM_DEP_QUEUE_FLAGS_RT flag to internally choose between a
> > > workqueue and kthread_work, and to enable FIFO scheduling in [2]. Most
> > > of the details are hidden internally, but I had to make a few small
> > > changes in Xe to support this on the driver side [3].
> > > 
> > > Putting aside whether or when DRM DEP will land, if DRM sched really
> > > wants FIFO scheduling instead of bypass (the IMO this is somewhat
> > > questionable), I think the approach I took in DRM DEP makes a lot more
> > > sense. I haven't looked into what changes would be required in DRM
> > > sched, though; hopefully it wouldn't be too messy.
> > > 
> > > Of course, kthreads are now directly exposed to userspace, but this
> > > would be limited to privileged userspace with FIFO scheduling
> > > capabilities, which seems reasonable. Additionally, this approach does
> > > not require the kind of large paradigm shifts proposed by this series.  
> > 
> > This sounds plausible and TBH I also considered worker duality. If you look
> > at my series I wrap everything to drm_sched_work and drm_sched_worker so
> > drivers do not even have to know what is the underlying implementation.
> >   
> 
> You could probably abstract this to some extent, but any driver-side
> functions that process work on scheduler workers would still require
> dedicated function signatures. Perhaps some creative macros could do
> something like:
> 
> DRM_SCHED_DECL_DRIVER_WORK_FUNC(driver_sched, work_func);
> DRM_SCHED_INIT_DRIVER_WORK_FUNC(driver_sched, work_func);
> 
> However, this would only eliminate functions that perform a
> `container_of()` conversion or use an `if` statement to select between
> workqueues and `kthread_work`.

Honestly, I'm questioning the viability of such an hybrid design. Not
only this makes the code base even harder to reason about (and thus,
harder to maintain), but if you think about it, the only reason we got
here is because we pretended the full/monolithic drm_sched stack was a
good fit for this FW-scheduler use case, and the reality is that it's
not.

What we need for this FW-scheduler case is a simple per-context FIFO
with dep tracking. The KMD can then decide when to pull jobs from
this FIFO with its own deferred work model (workqueues, kthread or
whatever). All it needs to have is:

- a way to initialize the job and its deps (so basically the
  drm_sched_job_xxx() helpers)
- a way to queue a job to this FIFO (something like
  drm_sched_entity_push_job(), but maybe simpler)
- a way to evaluate if the first job in the queue is ready for
  execution
- a way to register a callback for asynchronous queue/job readiness
  re-evaluation. That would basically be called on a dep fence callback
  call, and defers the responsibility of how the re-evaluation is done
  to the driver. If you're using kthreads, you'll just be issuing a
  kthread_queue_work() from this callback. If you want workqueues, you'd
  be using queue_work_on(), etc.

The key here, is that the framework no longer decides the deferred work
model the driver has to use. This push/pull model makes it so the driver
is in control at all times, which also simplifies things like teardown,
or rather, make it so drm_sched is not in the way of driver specific
teardown sequences.

I know some of these concepts have been discussed with Philipp and
Danilo for the JobQueue implementation they intend to have on the
rust-side. I also know that they are not particularly thrilled by this
push/pull model, I think they're more going for a solution where jobs
are pushed to the driver when they are ready for execution, which
requires having their own worker/work to defer the run_job() call, so
back to the problem that the framework enforces the execution model.

Oh, and also, just because more is deferred to the driver doesn't mean
we can't have generic helpers for kthread-based/workqueue-based
deferral, the big difference being that, it's now up to the driver to
decide which ones they want to use.
