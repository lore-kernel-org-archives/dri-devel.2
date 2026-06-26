Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21C7ECDE00E
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 09:11:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B0EB10F511;
	Fri, 26 Jun 2026 09:11:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="jBSVO8vy";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id B13F810F511
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 09:11:29 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 947F21655
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 02:11:24 -0700 (PDT)
Received: from [192.168.0.1] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 DDCA13F836
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 02:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1782465089; bh=jm7egqUyEzW6DOGD9yfCsukCGAJ2Ls8ut4uVYSyLZc4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jBSVO8vyOkG540vwk2xIqp6jnQqQXnWYoenX+rP+SgaiYnZxFqM9hLb+X58iFbBu/
 w9yzY1AUt6Xuus9auqSicdWkryzCt3mlpn6OEhF2RN3vM0B1DZLMPjnK+jCN15uzar
 31fwpKPiiKEixRl+o+uHihCukm2JIXThYi6jF6to=
Date: Fri, 26 Jun 2026 10:11:17 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Steven Price <steven.price@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Chia-I Wu <olvaffe@gmail.com>, Karunika Choo <karunika.choo@arm.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 sashiko-bot@kernel.org
Subject: Re: [PATCH 01/11] drm/panthor: Always use the IRQ-safe variant when
 acquiring the fence lock
Message-ID: <aj5CNZGu632lGc8r@e142607>
References: <20260625-panthor-misc-fixes-v1-0-b67ed973fea6@collabora.com>
 <20260625-panthor-misc-fixes-v1-1-b67ed973fea6@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260625-panthor-misc-fixes-v1-1-b67ed973fea6@collabora.com>
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

On Thu, Jun 25, 2026 at 02:40:27PM +0200, Boris Brezillon wrote:
> Since dma_fence objects can be shared with other subsystems, they may be
> accessed from hardirq context in those drivers, and we have to take
> that into account by also using the IRQ-safe variant when acquiring
> the lock.
> 
> While at it, switch to the guard model.
> 
> Fixes: de8548813824 ("drm/panthor: Add the scheduler logical block")
> Reported-by: sashiko-bot@kernel.org
> Closes: https://sashiko.dev/#/patchset/20260625-panthor-signal-from-irq-v5-0-8836a74e0ef9@collabora.com?part=11
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
>  drivers/gpu/drm/panthor/panthor_sched.c | 83 ++++++++++++++++-----------------
>  1 file changed, 39 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
> index 5b34032deff8..e97f29469d28 100644
> --- a/drivers/gpu/drm/panthor/panthor_sched.c
> +++ b/drivers/gpu/drm/panthor/panthor_sched.c
> @@ -1151,15 +1151,14 @@ queue_suspend_timeout_locked(struct panthor_queue *queue)
>  static void
>  queue_suspend_timeout(struct panthor_queue *queue)
>  {
> -	spin_lock(&queue->fence_ctx.lock);
> +	guard(spinlock_irqsave)(&queue->fence_ctx.lock);
>  	queue_suspend_timeout_locked(queue);
> -	spin_unlock(&queue->fence_ctx.lock);
>  }
>  
>  static void
>  queue_resume_timeout(struct panthor_queue *queue)
>  {
> -	spin_lock(&queue->fence_ctx.lock);
> +	guard(spinlock_irqsave)(&queue->fence_ctx.lock);
>  
>  	if (queue_timeout_is_suspended(queue)) {
>  		mod_delayed_work(queue->scheduler.timeout_wq,
> @@ -1168,8 +1167,6 @@ queue_resume_timeout(struct panthor_queue *queue)
>  
>  		queue->timeout.remaining = MAX_SCHEDULE_TIMEOUT;
>  	}
> -
> -	spin_unlock(&queue->fence_ctx.lock);
>  }
>  
>  /**
> @@ -1542,7 +1539,7 @@ cs_slot_process_fault_event_locked(struct panthor_device *ptdev,
>  		u64 cs_extract = queue->iface.output->extract;
>  		struct panthor_job *job;
>  
> -		spin_lock(&queue->fence_ctx.lock);
> +		guard(spinlock_irqsave)(&queue->fence_ctx.lock);
>  		list_for_each_entry(job, &queue->fence_ctx.in_flight_jobs, node) {
>  			if (cs_extract >= job->ringbuf.end)
>  				continue;
> @@ -1552,7 +1549,6 @@ cs_slot_process_fault_event_locked(struct panthor_device *ptdev,
>  
>  			dma_fence_set_error(job->done_fence, -EINVAL);
>  		}
> -		spin_unlock(&queue->fence_ctx.lock);
>  	}
>  
>  	if (group) {
> @@ -2183,13 +2179,13 @@ group_term_post_processing(struct panthor_group *group)
>  		if (!queue)
>  			continue;
>  
> -		spin_lock(&queue->fence_ctx.lock);
> -		list_for_each_entry_safe(job, tmp, &queue->fence_ctx.in_flight_jobs, node) {
> -			list_move_tail(&job->node, &faulty_jobs);
> -			dma_fence_set_error(job->done_fence, err);
> -			dma_fence_signal_locked(job->done_fence);
> +		scoped_guard(spinlock_irqsave, &queue->fence_ctx.lock) {
> +			list_for_each_entry_safe(job, tmp, &queue->fence_ctx.in_flight_jobs, node) {
> +				list_move_tail(&job->node, &faulty_jobs);
> +				dma_fence_set_error(job->done_fence, err);
> +				dma_fence_signal_locked(job->done_fence);
> +			}
>  		}
> -		spin_unlock(&queue->fence_ctx.lock);
>  
>  		/* Manually update the syncobj seqno to unblock waiters. */
>  		syncobj = group->syncobjs->kmap + (i * sizeof(*syncobj));
> @@ -3049,39 +3045,39 @@ static bool queue_check_job_completion(struct panthor_queue *queue)
>  	LIST_HEAD(done_jobs);
>  
>  	cookie = dma_fence_begin_signalling();
> -	spin_lock(&queue->fence_ctx.lock);
> -	list_for_each_entry_safe(job, job_tmp, &queue->fence_ctx.in_flight_jobs, node) {
> -		if (!syncobj) {
> -			struct panthor_group *group = job->group;
> +	scoped_guard(spinlock_irqsave, &queue->fence_ctx.lock) {
> +		list_for_each_entry_safe(job, job_tmp, &queue->fence_ctx.in_flight_jobs, node) {
> +			if (!syncobj) {
> +				struct panthor_group *group = job->group;
>  
> -			syncobj = group->syncobjs->kmap +
> -				  (job->queue_idx * sizeof(*syncobj));
> +				syncobj = group->syncobjs->kmap +
> +					  (job->queue_idx * sizeof(*syncobj));
> +			}
> +
> +			if (syncobj->seqno < job->done_fence->seqno)
> +				break;
> +
> +			list_move_tail(&job->node, &done_jobs);
> +			dma_fence_signal_locked(job->done_fence);
>  		}
>  
> -		if (syncobj->seqno < job->done_fence->seqno)
> -			break;
> +		if (list_empty(&queue->fence_ctx.in_flight_jobs)) {
> +			/* If we have no job left, we cancel the timer, and reset remaining
> +			 * time to its default so it can be restarted next time
> +			 * queue_resume_timeout() is called.
> +			 */
> +			queue_suspend_timeout_locked(queue);
>  
> -		list_move_tail(&job->node, &done_jobs);
> -		dma_fence_signal_locked(job->done_fence);
> +			/* If there's no job pending, we consider it progress to avoid a
> +			 * spurious timeout if the timeout handler and the sync update
> +			 * handler raced.
> +			 */
> +			progress = true;
> +		} else if (!list_empty(&done_jobs)) {
> +			queue_reset_timeout_locked(queue);
> +			progress = true;
> +		}
>  	}
> -
> -	if (list_empty(&queue->fence_ctx.in_flight_jobs)) {
> -		/* If we have no job left, we cancel the timer, and reset remaining
> -		 * time to its default so it can be restarted next time
> -		 * queue_resume_timeout() is called.
> -		 */
> -		queue_suspend_timeout_locked(queue);
> -
> -		/* If there's no job pending, we consider it progress to avoid a
> -		 * spurious timeout if the timeout handler and the sync update
> -		 * handler raced.
> -		 */
> -		progress = true;
> -	} else if (!list_empty(&done_jobs)) {
> -		queue_reset_timeout_locked(queue);
> -		progress = true;
> -	}
> -	spin_unlock(&queue->fence_ctx.lock);
>  	dma_fence_end_signalling(cookie);
>  
>  	list_for_each_entry_safe(job, job_tmp, &done_jobs, node) {
> @@ -3346,9 +3342,8 @@ queue_run_job(struct drm_sched_job *sched_job)
>  	job->ringbuf.end = job->ringbuf.start + (instrs.count * sizeof(u64));
>  
>  	panthor_job_get(&job->base);
> -	spin_lock(&queue->fence_ctx.lock);
> -	list_add_tail(&job->node, &queue->fence_ctx.in_flight_jobs);
> -	spin_unlock(&queue->fence_ctx.lock);
> +	scoped_guard(spinlock_irqsave, &queue->fence_ctx.lock)
> +		list_add_tail(&job->node, &queue->fence_ctx.in_flight_jobs);
>  
>  	/* Make sure the ring buffer is updated before the INSERT
>  	 * register.
> 
> -- 
> 2.54.0
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
