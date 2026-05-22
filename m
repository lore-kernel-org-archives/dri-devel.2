Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE4C0CD5BB3
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 16:08:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECE4010E8E8;
	Fri, 22 May 2026 16:08:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="iWN8HczS";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75FC810E8E8
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 16:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1779466086;
 bh=J2zbrUI6IHKWzuNJqMPA+KyQdjhf7qXTmpVdvBNaLSg=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=iWN8HczSfYKqq9RMue9g28/DLidBnsoQm56nsDj16eum0+cz6LT2wm/fEDOumLVLJ
 UFp8239MfLWogC2qzbCi72KazdHAVoc1wEw5FByx7TAuHvVaMdlETpxP/jc/rSK0AL
 JQp/yTLo/72NcLZj+v2EGJcimeZ12dClla2NFR3+p9JtD5pbTCgkF00txIRAoDed9D
 hT3x26WlDU15mGOBoxPEu4uiKkU11plChyJWibRr+V+0XcE7/6/NCGR20I19oL8mYR
 Tgabh6qaPhBs5Xd1P33POIOLqWobh4OQAM/kah7ZtoEcsxv95jrFOrRCnFZeohxy9A
 DAD9vDGEZ/1WA==
Received: from fedora (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id DC41C17E0CAC;
 Fri, 22 May 2026 18:08:05 +0200 (CEST)
Date: Fri, 22 May 2026 18:08:02 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: dri-devel@lists.freedesktop.org, kernel-dev@igalia.com, Liviu Dudau
 <liviu.dudau@arm.com>, Steven Price <steven.price@arm.com>
Subject: Re: [RFC 2/2] drm/panthor: Use separate workqueue for DRM scheduler
Message-ID: <20260522174831.34983d27@fedora>
In-Reply-To: <20260522113817.11745-3-tvrtko.ursulin@igalia.com>
References: <20260522113817.11745-1-tvrtko.ursulin@igalia.com>
 <20260522113817.11745-3-tvrtko.ursulin@igalia.com>
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

On Fri, 22 May 2026 12:38:17 +0100
Tvrtko Ursulin <tvrtko.ursulin@igalia.com> wrote:

> Currently an unordered workqueue is used for the DRM scheduler which means
> its concurrency is externally managed, and given there is one scheduler
> instance per userspace queue, that means workqueue management logic is
> within its rights to spawn many kernel threads to submit their respective
> jobs.
> 
> Problem there is that all run job callbacks are serialized on the device
> global mutex, making the potential thread storm just causing lock
> contention.

Yeah, so initially we were not supposed to take the lock over the whole
run_job() function. We should normally be able to queue things to the
ring buffer, and only briefly take the lock to check if the context is
still resident and kick the group scheduler if it's not. I agree that
in practice it turned in a huge synchronization point. I guess we should
consider turning that mutex into a rwsem that's taken in write mode in
the tick path, and read-mode elsewhere.

> 
> If we add a separate ordered workqueue for the DRM scheduler integration
> we can avoid this problem, since the ordered property directly expresses
> the nature of the submission backend implementation.

I don't see alloc_ordered_workqueue() being used for the sched_wq
workqueue, is that intended (according to this comment, you seem to
want an ordered wq).

> 
> And considering the other user of this workqueue, the free job callback,
> which is not globally serialized in this manner so could be thought to
> potentially regress with this change, it should not be the case since
> commit
> a58f317c1ca0 ("drm/sched: Free all finished jobs at once")
> made the DRM scheduler handle the cleanup of finished jobs more promptly.
> 
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Cc: Boris Brezillon <boris.brezillon@collabora.com>
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Cc: Steven Price <steven.price@arm.com>
> ---
>  drivers/gpu/drm/panthor/panthor_sched.c | 27 ++++++++++++++++---------
>  1 file changed, 17 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
> index 2bee1c92fb9e..cc6b3e2b015a 100644
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
> @@ -4167,13 +4176,11 @@ int panthor_sched_init(struct panthor_device *ptdev)
>  	 * FW is smart enough to fall back on other methods if the kernel can't
>  	 * allocate memory, and fail the tiling job if none of these
>  	 * countermeasures worked.
> -	 *
> -	 * Set WQ_MEM_RECLAIM on sched->wq to unblock the situation when the
> -	 * system is running out of memory.
>  	 */
>  	sched->heap_alloc_wq = alloc_workqueue("panthor-heap-alloc", WQ_UNBOUND, 0);
> -	sched->wq = alloc_workqueue("panthor-csf-sched", WQ_MEM_RECLAIM | WQ_UNBOUND, 0);
> -	if (!sched->wq || !sched->heap_alloc_wq) {
> +	sched->wq = alloc_workqueue("panthor-csf-sched", WQ_UNBOUND, 0);
> +	sched->sched_wq = alloc_workqueue("panthor-drm-sched", WQ_MEM_RECLAIM, 0);

The other one also needs MEM_RECLAIM, because you need work items
queued to sched->wq to run to guarantee forward progress, and you need
to guarantee forward progress to reclaim GPU mem.

> +	if (!sched->wq || !sched->heap_alloc_wq || !sched->sched_wq) {
>  		panthor_sched_fini(&ptdev->base, sched);
>  		drm_err(&ptdev->base, "Failed to allocate the workqueues");
>  		return -ENOMEM;

