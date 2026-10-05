Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3168CA5FCE
	for <dri-devel@archiver.kernel.org>; Mon,  5 Oct 2026 13:08:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C42510E265;
	Mon,  5 Oct 2026 13:08:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="k543q71O";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54D2E10E265
 for <dri-devel@lists.freedesktop.org>; Mon,  5 Oct 2026 13:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1791205709;
 bh=LSzuL6fP+0zGUl+Bo17Pao8LKAoJZbdsKY7GJudgd70=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=k543q71OpYMLaUwWteyAKS1xCf/7/VS1Nlf/ZZ9bRcNeEgvWyhiY/VVZfRgphw+xx
 iBwspwiveyiDCpjqPvToS1n7dGBbZLIgGvU4LbTrZov+dORh8GSHXr8k1faG399vAg
 CQVQCunhQiLxAoycq0+uqUOUmFqRhs9+BrUOc1+UsSGj8ESipYaABOF2mMep82v6l6
 7Jyn4CodU0AcoWcb7WyVa4R+uCZJb6Jw4cxhNE5qpcMnspUlqBgfDQrwI0tQ+ti7D0
 5568le/RFkTQ3CuLK3LN1AZA/v171+bwNOsQtJP8siNYFynkrLNjTgi9iGvJ/Xas/n
 yNfCoRKxwna4g==
Received: from fedora-61.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id EB8AB17E0243;
 Mon, 05 Oct 2026 15:08:28 +0200 (CEST)
Date: Mon, 5 Oct 2026 15:08:12 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Tejun Heo <tj@kernel.org>
Cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 kernel-dev@igalia.com, Chia-I Wu <olv@google.com>, Liviu Dudau
 <liviu.dudau@arm.com>, Matthew Brost <matthew.brost@intel.com>, Steven
 Price <steven.price@arm.com>
Subject: Re: [RFC v6 3/3] drm/panthor: Create per queue priority workqueues
Message-ID: <20261005150812.18f86b39@fedora-61.home>
In-Reply-To: <64d59ed5538c6af257058533c880740e@kernel.org>
References: <20261001160711.59888-1-tvrtko.ursulin@igalia.com>
 <20261001160711.59888-4-tvrtko.ursulin@igalia.com>
 <64d59ed5538c6af257058533c880740e@kernel.org>
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

Hello Tejun and Tvrtko,

On Fri, 02 Oct 2026 09:30:53 -1000
Tejun Heo <tj@kernel.org> wrote:

> > +	sched->submit_wq[PANTHOR_CSG_PRIORITY_MEDIUM] = alloc_workqueue("panthor-drm", WQ_MEM_RECLAIM | WQ_UNBOUND, 2);
> > +	sched->submit_wq[PANTHOR_CSG_PRIORITY_LOW] = sched->submit_wq[PANTHOR_CSG_PRIORITY_MEDIUM];
> > +	sched->submit_wq[PANTHOR_CSG_PRIORITY_HIGH] = alloc_workqueue("panthor-drm-high", WQ_HIGHPRI | WQ_MEM_RECLAIM | WQ_UNBOUND, 2);
> > +	sched->submit_wq[PANTHOR_CSG_PRIORITY_RT] = alloc_workqueue("panthor-drm-rt", WQ_RT | WQ_MEM_RECLAIM | WQ_UNBOUND, 2);  
> 
> For an unbound wq max_active applies to the whole wq, so this is two
> in-flight items per priority level across all the queues on the device,
> where the shared wq before had no effective limit. queue_run_job() blocks
> on sched->lock which tick_work() holds across FW round trips, so two
> blocked run_jobs would stall every other queue's run and free work at that
> level.

First off, panthor_sched::lock being a device-wide contention point for
submissions is something we plan to address (either by using a rw_lock
taken in read mode in the submit path and write mode in the scheduler
tick path, or by locking at a finer granularity).

> What's the reason for 2?

I think it was picked to keep the number of RT threads small, and
because we have this huge contention point, in ::run_job(), it was
deemed unimportant for now. Ultimately, if we were to size max_active
according to how fast the HW can dequeue, I guess we would go for
something like `max_active=panthor_sched::csg_slot_count`.

The other thing we need to address is the fact we now have proper
priority enforcement for submissions, but events are still processed
in a random order, so we probably want to have per-prio wq for OOM
handling, and we need a mechanism to process events in the CSG prio
order in panthor_sched_report_fw_events(). I'm also worried that an
RT-prio context would preempt the tick scheduled on
panthor_scheduler::wq, which is a regular-prio wq, thus making fairness
between RT contexts non-functional (if one RT context manages to queue
jobs fast enough, it would stay on the CSG slot with the highest prio
longer than we expect).

It's all these tiny details I'd like to sort out (or at least have a
plan for) before merging the per-prio-submit-wq stuff in panthor. This
being said, I don't think it should block the workqueue/drm_sched
changes, if they are deemed acceptable.

BTW, I apologize for being MIA for this long :-/.

Regards,

Boris
