Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A156C43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 06:45:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 907CB10F3B6;
	Thu,  9 Jul 2026 06:45:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="itCXBBRu";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19E1410F3B1
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 06:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1783579524;
 bh=aEAVLwvqpcFWZllt0VPknQQgKnqC6FNzOkP8RKh3aCQ=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=itCXBBRuUzTCxQd3CrUD80wGe7Ph7YWLmyOHC6lUqepU3QC8DGLlMykdajI8V024R
 FxENoXBieMIwnip3LVzhfE/nhmg00P+prMLyImka4gpotsy7ftSNNrw7vFRBdvZR19
 yr/wUMO0bztlM8zZtc7AdqcxdTj57GpTccfUou7bPdMjf6jIebmtg09JuDr/ikJTgW
 F3Z8mOWntWgx5OINw8UmWdEZN9vzK/DouWqwbr6RIBt/nOX4u3nDufN9G4S1UKXFb7
 5VUDiJgOlxH87bUFif6eokPTVtimQHx5cs00CBg3UP73+fJMrwLi1aKIPywwnfnIK9
 TPfiizIIRSccQ==
Received: from fedora-2.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 15E7B17E019E;
 Thu, 09 Jul 2026 08:45:24 +0200 (CEST)
Date: Thu, 9 Jul 2026 08:45:20 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: dri-devel@lists.freedesktop.org, Steven Price <steven.price@arm.com>,
 Liviu Dudau <liviu.dudau@arm.com>, Chia-I Wu <olvaffe@gmail.com>, Danilo
 Krummrich <dakr@kernel.org>, Matthew Brost <matthew.brost@intel.com>,
 Philipp Stanner <phasta@kernel.org>, kernel-dev@igalia.com
Subject: Re: [RFC 2/8] drm/panthor: Use separate workqueue for DRM scheduler
Message-ID: <20260709084520.16d32cb7@fedora-2.home>
In-Reply-To: <bd262d12-65d0-4c59-a314-b42b540acd99@igalia.com>
References: <20260702143745.79293-1-tvrtko.ursulin@igalia.com>
 <20260702143745.79293-3-tvrtko.ursulin@igalia.com>
 <20260702173127.3103af30@fedora-2.home>
 <8aa9ffad-ece3-428b-b307-1d5f4136db73@igalia.com>
 <20260706161812.07ee7500@fedora-2.home>
 <bd262d12-65d0-4c59-a314-b42b540acd99@igalia.com>
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

On Wed, 8 Jul 2026 17:47:36 +0100
Tvrtko Ursulin <tvrtko.ursulin@igalia.com> wrote:

> On 06/07/2026 15:18, Boris Brezillon wrote:
> > On Mon, 6 Jul 2026 13:03:33 +0100
> > Tvrtko Ursulin <tvrtko.ursulin@igalia.com> wrote:
> >   
> >> On 02/07/2026 16:31, Boris Brezillon wrote:  
> >>> On Thu,  2 Jul 2026 15:37:39 +0100
> >>> Tvrtko Ursulin <tvrtko.ursulin@igalia.com> wrote:
> >>>      
> >>>> Currently an unordered workqueue is used for the DRM scheduler which means
> >>>> its concurrency is externally managed, and given there is one scheduler
> >>>> instance per userspace queue, that means workqueue management logic is
> >>>> within its rights to spawn many kernel threads to submit their respective
> >>>> jobs.
> >>>>
> >>>> Problem there is that all run job callbacks are serialized on the device
> >>>> global mutex,  
> >>>
> >>> I think we should address that instead, and either shorten the scope of
> >>> the locked section, or make it so we don't make it a contention point
> >>> for concurrent job submission from different contexts (with a rwsem
> >>> instead of a lock, for instance).
> >>>      
> >>>> making the potential thread storm just causing lock
> >>>> contention.
> >>>>
> >>>> If we add a separate ordered workqueue for the DRM scheduler integration
> >>>> we can avoid this problem, since the ordered property directly expresses
> >>>> the nature of the submission backend implementation.  
> >>>
> >>> Yep, except that's not how it was meant to work. The goal was to allow
> >>> contexts to submit their jobs concurrently to the FW. The only reason we
> >>> take the lock is to:
> >>>
> >>> 1. make sure the context is still allowed to take jobs
> >>> 2. kick the group scheduler if the context is not resident
> >>>
> >>> For #1, I believe we can come up with either a lockless solution, or a
> >>> solution where the lock protecting the state belongs to the group
> >>> instead of being externally protected by the device-wide scheduler lock.
> >>>
> >>> For #2, the rwsem approach, and narrowing down the locked section to
> >>> just this part of the code should do the trick.  
> >>
> >> Out of curiosity how much CPU side parallelism you think is required to
> >> keep these GPUs fed? Both today (with the greater lock contention) and
> >> in the future (with the reduced contention) I guess would be interesting
> >> data points.  
> > 
> > The maximum is known: it's the amount of FW CSG slot we have available.
> > I think the theoretical limit is 16, but IIRC, we never had more than 8
> > exposed by the FW.  
> 
> Yeah but is it _really_ required to have 8 CPU threads feed these slots? 

8 is indeed the number of SW slots, but there are multiple HW queues
under the hood (and multiple cores to dispatch jobs to), making it so
multiple GPU context can effectively be scheduled in parallel. This
number is lower than the number of FW slots though (I need to check if
it's exposed through some RO regs).

> GPU will still take one at a time and preemption is not that fast, no?

Preemption on the FW side is pretty simple: each slot gets a unique
prio, and lower prio slots only get HW queues and GPU resources if
higher prio ones are idle and accept to give up their resources for a
bit. We then have a 10ms tick in panthor to rotate the FW slot
priorities. So yes, preemption is not very granular, but that's not
really the problem I'm worried about. What I'm worried about is having
just one thread for everything, with the first-queued/first-served
model that the kthread_worker infrastructure provides. If we're talking
about one thread per-priority level, that's already better, and then I
agree that the contention on GPU contexts with the same priority is less
of an issue, especially since the run_job work has to run before being
rescheduled, which gives you this natural FIFO behavior, thus leaving
other contexts a chance to queue their run_job in the meantime.

But this WQ_UNBOUND -> WQ_SINGLE_THREAD transition, where the wq is
shared among the entire device is not that. It's actually serializing
work submission for all GPU contexts regardless of their priority.

TLDR; I'd be happy if we start with just one kthread per-prio + the
narrowing of the locked section in the run_job() implementation, so
that context submission actually happens concurrently, and low prio
context don't starve high-prio/RT ones in the submission path. 

