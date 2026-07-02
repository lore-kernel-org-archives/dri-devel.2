Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D992FC43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 15:31:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3890510F474;
	Thu,  2 Jul 2026 15:31:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="oLON+nr9";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BA7110F474
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 15:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1783006294;
 bh=Zi5UKkQAde8mN3IG6YQiyurRns38TX7Fo1Cu8dlpyYU=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=oLON+nr9Nv4Ra+ef4reeIHjf13O86yZHLVONwqtvpNONxvyewZctShSRdULpZdYAs
 n5M6FypsJA7X3lrgZH7hUs1NWGwt5nGrsK/86kqLmuFrWRgqgBXvOxYtyFnatg9vIg
 U8a8X6JOqfHhSHs6XIg2qW5NwFCnZ2P/dV2Uv/Pc5YGdqMcZ67zPmDERoxmFXlOmLg
 ijFNiev/UtGbH/tQpApHRSwJiFhkCJ7vibax65al9RX5uaZzRnkiHffTnLeEBp2GBX
 TYc7pw/HTxa6OGa3rgGJfncVHaFTrYaZKfL0zHLWlyjTYwpDHjTPlLN4KUX7IvogzB
 86zZj0PU4ywnQ==
Received: from fedora-2.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 3715617E0852;
 Thu,  2 Jul 2026 17:31:34 +0200 (CEST)
Date: Thu, 2 Jul 2026 17:31:27 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: dri-devel@lists.freedesktop.org, Steven Price <steven.price@arm.com>,
 Liviu Dudau <liviu.dudau@arm.com>, Chia-I Wu <olvaffe@gmail.com>, Danilo
 Krummrich <dakr@kernel.org>, Matthew Brost <matthew.brost@intel.com>,
 Philipp Stanner <phasta@kernel.org>, kernel-dev@igalia.com
Subject: Re: [RFC 2/8] drm/panthor: Use separate workqueue for DRM scheduler
Message-ID: <20260702173127.3103af30@fedora-2.home>
In-Reply-To: <20260702143745.79293-3-tvrtko.ursulin@igalia.com>
References: <20260702143745.79293-1-tvrtko.ursulin@igalia.com>
 <20260702143745.79293-3-tvrtko.ursulin@igalia.com>
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

On Thu,  2 Jul 2026 15:37:39 +0100
Tvrtko Ursulin <tvrtko.ursulin@igalia.com> wrote:

> Currently an unordered workqueue is used for the DRM scheduler which means
> its concurrency is externally managed, and given there is one scheduler
> instance per userspace queue, that means workqueue management logic is
> within its rights to spawn many kernel threads to submit their respective
> jobs.
> 
> Problem there is that all run job callbacks are serialized on the device
> global mutex,

I think we should address that instead, and either shorten the scope of
the locked section, or make it so we don't make it a contention point
for concurrent job submission from different contexts (with a rwsem
instead of a lock, for instance).

> making the potential thread storm just causing lock
> contention.
> 
> If we add a separate ordered workqueue for the DRM scheduler integration
> we can avoid this problem, since the ordered property directly expresses
> the nature of the submission backend implementation.

Yep, except that's not how it was meant to work. The goal was to allow
contexts to submit their jobs concurrently to the FW. The only reason we
take the lock is to:

1. make sure the context is still allowed to take jobs
2. kick the group scheduler if the context is not resident

For #1, I believe we can come up with either a lockless solution, or a
solution where the lock protecting the state belongs to the group
instead of being externally protected by the device-wide scheduler lock.

For #2, the rwsem approach, and narrowing down the locked section to
just this part of the code should do the trick. 

> 
> And considering the other user of this workqueue, the free job callback,
> which is not globally serialized in this manner so could be thought to
> potentially regress with this change, it should not be the case since
> commit
> a58f317c1ca0 ("drm/sched: Free all finished jobs at once")
> made the DRM scheduler handle the cleanup of finished jobs more promptly.

I don't know if this change is a hard dep for what's coming next, but
if it's not, I'd drop it. If it is, and the new kthread_work solution
relies on this serialization, I guess I need to read more to understand
why.

> 
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Cc: Boris Brezillon <boris.brezillon@collabora.com>
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Cc: Steven Price <steven.price@arm.com>
> ---
> v2:
>  * Actually create an unordered wq.
>  * Put back WQ_MEM_RECLAIM to sched->wq.
> ---
>  drivers/gpu/drm/panthor/panthor_sched.c | 26 +++++++++++++++++--------
>  1 file changed, 18 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
> index 2bee1c92fb9e..f4dfd82ad8a8 100644
> --- a/drivers/gpu/drm/panthor/panthor_sched.c
> +++ b/drivers/gpu/drm/panthor/panthor_sched.c
> @@ -147,13 +147,11 @@ struct panthor_scheduler {
>  	struct panthor_device *ptdev;
>  
>  	/**
> -	 * @wq: Workqueue used by our internal scheduler logic and
> -	 * drm_gpu_scheduler.
> +	 * @wq: Workqueue used by our internal scheduler logic.
>  	 *
>  	 * Used for the scheduler tick, group update or other kind of FW
>  	 * event processing that can't be handled in the threaded interrupt
> -	 * path. Also passed to the drm_gpu_scheduler instances embedded
> -	 * in panthor_queue.
> +	 * path.
>  	 */
>  	struct workqueue_struct *wq;
>  
> @@ -166,6 +164,14 @@ struct panthor_scheduler {
>  	 */
>  	struct workqueue_struct *heap_alloc_wq;
>  
> +	/**
> +	 * @sched_wq: Workqueue used for the DRM scheduler.
> +	 *
> +	 * Workqueue used for drm_gpu_scheduler instances embedded in
> +	 * panthor_queue.
> +	 */
> +	struct workqueue_struct *sched_wq;
> +
>  	/** @tick_work: Work executed on a scheduling tick. */
>  	struct delayed_work tick_work;
>  
> @@ -3488,7 +3494,7 @@ group_create_queue(struct panthor_group *group,
>  {
>  	struct drm_sched_init_args sched_args = {
>  		.ops = &panthor_queue_sched_ops,
> -		.submit_wq = group->ptdev->scheduler->wq,
> +		.submit_wq = group->ptdev->scheduler->sched_wq,
>  		/*
>  		 * The credit limit argument tells us the total number of
>  		 * instructions across all CS slots in the ringbuffer, with
> @@ -4078,6 +4084,9 @@ static void panthor_sched_fini(struct drm_device *ddev, void *res)
>  	if (sched->heap_alloc_wq)
>  		destroy_workqueue(sched->heap_alloc_wq);
>  
> +	if (sched->sched_wq)
> +		destroy_workqueue(sched->sched_wq);
> +
>  	for (prio = PANTHOR_CSG_PRIORITY_COUNT - 1; prio >= 0; prio--) {
>  		drm_WARN_ON(ddev, !list_empty(&sched->groups.runnable[prio]));
>  		drm_WARN_ON(ddev, !list_empty(&sched->groups.idle[prio]));
> @@ -4168,12 +4177,13 @@ int panthor_sched_init(struct panthor_device *ptdev)
>  	 * allocate memory, and fail the tiling job if none of these
>  	 * countermeasures worked.
>  	 *
> -	 * Set WQ_MEM_RECLAIM on sched->wq to unblock the situation when the
> -	 * system is running out of memory.
> +	 * Set WQ_MEM_RECLAIM on sched->wq and wq->sched_wq to unblock the
> +	 * situation when the system is running out of memory.
>  	 */
>  	sched->heap_alloc_wq = alloc_workqueue("panthor-heap-alloc", WQ_UNBOUND, 0);
>  	sched->wq = alloc_workqueue("panthor-csf-sched", WQ_MEM_RECLAIM | WQ_UNBOUND, 0);
> -	if (!sched->wq || !sched->heap_alloc_wq) {
> +	sched->sched_wq = alloc_ordered_workqueue("panthor-drm-sched", WQ_MEM_RECLAIM);
> +	if (!sched->wq || !sched->heap_alloc_wq || !sched->sched_wq) {
>  		panthor_sched_fini(&ptdev->base, sched);
>  		drm_err(&ptdev->base, "Failed to allocate the workqueues");
>  		return -ENOMEM;

