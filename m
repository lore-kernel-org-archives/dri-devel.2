Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CDD0C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 14:18:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C1B610E1C1;
	Mon,  6 Jul 2026 14:18:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="XeK7OtR6";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FB9A10E1C1
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 14:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1783347499;
 bh=ll6/DvBBEAg2O2JGYdPiJ1/KUN+YNbGIfkC2sAzC2Ic=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=XeK7OtR6FOkx7ZoFs7Xi7cSP9gHDlVvh3fd7AJTPZAjr9LR8+NhhINNpQziKM94t5
 qg/3gR9Dji1m7kr6a/H4zOW0eid5pQ5TMHDyHWsmvxtXC3u9YYlwfw4JPEU2XIEeNM
 LOtdx/DnV4HbtvwxFDTCgX/AkagCdYKTqYccRIxIJ455jkQTrga4jEu4g7ROWV1H4E
 JQj+AT1OHVJS0dIRzvnCILWjls7CUY7HLGaUpx3PQd5aEnWfdVqQB8x4JmNyC8gI4w
 FJHqGzCGbxbLCCv9iokFEeZc5a+KgoB7NJ8WrCakvg9BZgTODkwCjAft/KR8cATEFB
 eNkEyOjuvHRVg==
Received: from fedora-2.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 25AE217E023C;
 Mon, 06 Jul 2026 16:18:19 +0200 (CEST)
Date: Mon, 6 Jul 2026 16:18:12 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: dri-devel@lists.freedesktop.org, Steven Price <steven.price@arm.com>,
 Liviu Dudau <liviu.dudau@arm.com>, Chia-I Wu <olvaffe@gmail.com>, Danilo
 Krummrich <dakr@kernel.org>, Matthew Brost <matthew.brost@intel.com>,
 Philipp Stanner <phasta@kernel.org>, kernel-dev@igalia.com
Subject: Re: [RFC 2/8] drm/panthor: Use separate workqueue for DRM scheduler
Message-ID: <20260706161812.07ee7500@fedora-2.home>
In-Reply-To: <8aa9ffad-ece3-428b-b307-1d5f4136db73@igalia.com>
References: <20260702143745.79293-1-tvrtko.ursulin@igalia.com>
 <20260702143745.79293-3-tvrtko.ursulin@igalia.com>
 <20260702173127.3103af30@fedora-2.home>
 <8aa9ffad-ece3-428b-b307-1d5f4136db73@igalia.com>
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

On Mon, 6 Jul 2026 13:03:33 +0100
Tvrtko Ursulin <tvrtko.ursulin@igalia.com> wrote:

> On 02/07/2026 16:31, Boris Brezillon wrote:
> > On Thu,  2 Jul 2026 15:37:39 +0100
> > Tvrtko Ursulin <tvrtko.ursulin@igalia.com> wrote:
> >   
> >> Currently an unordered workqueue is used for the DRM scheduler which means
> >> its concurrency is externally managed, and given there is one scheduler
> >> instance per userspace queue, that means workqueue management logic is
> >> within its rights to spawn many kernel threads to submit their respective
> >> jobs.
> >>
> >> Problem there is that all run job callbacks are serialized on the device
> >> global mutex,  
> > 
> > I think we should address that instead, and either shorten the scope of
> > the locked section, or make it so we don't make it a contention point
> > for concurrent job submission from different contexts (with a rwsem
> > instead of a lock, for instance).
> >   
> >> making the potential thread storm just causing lock
> >> contention.
> >>
> >> If we add a separate ordered workqueue for the DRM scheduler integration
> >> we can avoid this problem, since the ordered property directly expresses
> >> the nature of the submission backend implementation.  
> > 
> > Yep, except that's not how it was meant to work. The goal was to allow
> > contexts to submit their jobs concurrently to the FW. The only reason we
> > take the lock is to:
> > 
> > 1. make sure the context is still allowed to take jobs
> > 2. kick the group scheduler if the context is not resident
> > 
> > For #1, I believe we can come up with either a lockless solution, or a
> > solution where the lock protecting the state belongs to the group
> > instead of being externally protected by the device-wide scheduler lock.
> > 
> > For #2, the rwsem approach, and narrowing down the locked section to
> > just this part of the code should do the trick.  
> 
> Out of curiosity how much CPU side parallelism you think is required to 
> keep these GPUs fed? Both today (with the greater lock contention) and 
> in the future (with the reduced contention) I guess would be interesting 
> data points.

The maximum is known: it's the amount of FW CSG slot we have available.
I think the theoretical limit is 16, but IIRC, we never had more than 8
exposed by the FW.

Also, adjusting the priority of the thread used for job submission is
not enough (at least not for panthor), because the processing of FW
events is still going through this single-prio workqueue (signaling is
about to be moved to the threaded IRQ handler, but we still defer the
processing of some events to work items, and those can block progress
on a queue until they are processed). If we're processing events coming
from low prio queues before those coming from high prio queues, we're
back to the same problem. Not to mention that now, high prio submission
threads can completely starve FW event processing.

This is just my 2-cts, but I think we need both side of the equation
addressed at the same time, which is why I believe we should convert
panthor_scheduler::wq to the same kthread_worker mechanism.

> 
> >> And considering the other user of this workqueue, the free job callback,
> >> which is not globally serialized in this manner so could be thought to
> >> potentially regress with this change, it should not be the case since
> >> commit
> >> a58f317c1ca0 ("drm/sched: Free all finished jobs at once")
> >> made the DRM scheduler handle the cleanup of finished jobs more promptly.  
> > 
> > I don't know if this change is a hard dep for what's coming next, but
> > if it's not, I'd drop it. If it is, and the new kthread_work solution
> > relies on this serialization, I guess I need to read more to understand
> > why.  
> 
> You mean this patch, "drm/panthor: Use separate workqueue for DRM 
> scheduler"?
> 
> It is not strictly required. I could for example use the concurrent 
> flavour of the drm_sched_worker I add later in the series. That would 
> align with WQ_UNBOUND which is currently used, but then there is the 
> question of how much parallelism is required and the fact dumb worker 
> pool implementation from this RFC makes no attempt to spawn/retire 
> threads on demand. It just picks four out of thin air kind of. Priority 
> inheritance would still work but if picking a fix number of threads 
> based on some criteria wouldn't be feasible I would need to work on a 
> smarter worker pool implementation.

If that's easier, we can let the driver define the max number of
threads to spawn.

> 
> I could drop it, although the question would be when do you expect 
> locking rework could realistically happen and,

If that's a blocker for this series, I can try to prioritize this
change.

> if not quick, what is the 
> advantage of keeping the false parallelism.

The advantage is that we don't start relying on the artificial
serialization provided by single-threaded workqueues, because the more
we rely on that, the harder it gets to go back to a solution where GPU
contexts can submit jobs concurrently.
