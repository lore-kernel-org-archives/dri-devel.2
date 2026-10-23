Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE6F606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 13:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=R9azeME6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C6CE10E22F;
	Fri, 23 Oct 2026 13:26:39 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id B34A1112AFC
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 13:26:32 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 116C0315D
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 06:26:29 -0700 (PDT)
Received: from [192.168.0.1] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 053CF3F673
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 06:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1792761992; bh=gU1JPvbbsp+xB9jfFMJRFjxnS4cNlvn1cEM4iP4V4xM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=R9azeME6d6opQPLtdcRKBhA/hgusNlrODBe0E+m5uCyXC8S2kVaUPP99w2hPhsoKA
 Qpbt1mbQBBQWLTBdTzKqRK+H9OLXMgYrO9S/Nb1j3QvZD1oJJJ1lphW6fEJL2cqBrF
 VYfH4Z90oMJ7/g9umSPZywulqLOJClgIP3a9GDgw=
Date: Fri, 23 Oct 2026 14:26:28 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 kernel-dev@igalia.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Chia-I Wu <olv@google.com>, Matthew Brost <matthew.brost@intel.com>,
 Steven Price <steven.price@arm.com>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v7 4/4] drm/panthor: Create per queue priority workqueues
Message-ID: <attghL9iz3-PGUiT@e142607>
References: <20261022093848.5727-1-tvrtko.ursulin@igalia.com>
 <20261022093848.5727-5-tvrtko.ursulin@igalia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261022093848.5727-5-tvrtko.ursulin@igalia.com>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 22, 2026 at 10:38:48AM +0100, Tvrtko Ursulin wrote:
> Split the single workqueue shared between the driver internal logic and
> DRM scheduler use into separate ones, where the DRM scheduler one is
> created per GPU priority level using the appropriate mapping to
> workqueue priorities.
> 
> Low and medium GPU priority are served by a normal workqueue,
> high is server by a WQ_HIGHPRI instance, while realtime GPU priority is
> using the newly added WQ_RTPRI flag for lowest possible latency.
> 
> These workqueues are device global and for all three we set the maximum
> concurrency to two in order to keep the GPU optimally fed with work.
> 
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Cc: Boris Brezillon <boris.brezillon@collabora.com>
> Cc: Chia-I Wu <olv@google.com>
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Steven Price <steven.price@arm.com>
> Cc: Tejun Heo <tj@kernel.org>

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
>  drivers/gpu/drm/panthor/panthor_sched.c | 37 ++++++++++++++++++++++---
>  1 file changed, 33 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
> index 5b34032deff8..257895e5e48b 100644
> --- a/drivers/gpu/drm/panthor/panthor_sched.c
> +++ b/drivers/gpu/drm/panthor/panthor_sched.c
> @@ -152,11 +152,18 @@ struct panthor_scheduler {
>  	 *
>  	 * Used for the scheduler tick, group update or other kind of FW
>  	 * event processing that can't be handled in the threaded interrupt
> -	 * path. Also passed to the drm_gpu_scheduler instances embedded
> -	 * in panthor_queue.
> +	 * path.
>  	 */
>  	struct workqueue_struct *wq;
>  
> +	/**
> +	 * @submit_wq: Per priority workqueues for the DRM scheduler
> +	 *
> +	 * Passed to the drm_gpu_scheduler instances embedded
> +	 * in panthor_queue based on the queue priority.
> +	 */
> +	struct workqueue_struct *submit_wq[PANTHOR_CSG_PRIORITY_COUNT];
> +
>  	/**
>  	 * @heap_alloc_wq: Workqueue used to schedule tiler_oom works.
>  	 *
> @@ -3582,8 +3589,14 @@ group_create_queue(struct panthor_group *group,
>  		goto err_free_queue;
>  	}
>  
> +	if (group->priority >= ARRAY_SIZE(group->ptdev->scheduler->submit_wq) ||
> +	    !group->ptdev->scheduler->submit_wq[group->priority]) {
> +		ret = -EINVAL;
> +		goto err_free_queue;
> +	}
> +
>  	sched_args.name = queue->name;
> -
> +	sched_args.submit_wq = group->ptdev->scheduler->submit_wq[group->priority];
>  	ret = drm_sched_init(&queue->scheduler, &sched_args);
>  	if (ret)
>  		goto err_free_queue;
> @@ -4073,6 +4086,15 @@ static void panthor_sched_fini(struct drm_device *ddev, void *res)
>  	if (!sched || !sched->csg_slot_count)
>  		return;
>  
> +	if (sched->submit_wq[PANTHOR_CSG_PRIORITY_MEDIUM])
> +		destroy_workqueue(sched->submit_wq[PANTHOR_CSG_PRIORITY_MEDIUM]);
> +
> +	if (sched->submit_wq[PANTHOR_CSG_PRIORITY_HIGH])
> +		destroy_workqueue(sched->submit_wq[PANTHOR_CSG_PRIORITY_HIGH]);
> +
> +	if (sched->submit_wq[PANTHOR_CSG_PRIORITY_RT])
> +		destroy_workqueue(sched->submit_wq[PANTHOR_CSG_PRIORITY_RT]);
> +
>  	if (sched->wq)
>  		destroy_workqueue(sched->wq);
>  
> @@ -4174,7 +4196,14 @@ int panthor_sched_init(struct panthor_device *ptdev)
>  	 */
>  	sched->heap_alloc_wq = alloc_workqueue("panthor-heap-alloc", WQ_UNBOUND, 0);
>  	sched->wq = alloc_workqueue("panthor-csf-sched", WQ_MEM_RECLAIM | WQ_UNBOUND, 0);
> -	if (!sched->wq || !sched->heap_alloc_wq) {
> +	sched->submit_wq[PANTHOR_CSG_PRIORITY_MEDIUM] = alloc_workqueue("panthor-drm", WQ_MEM_RECLAIM | WQ_UNBOUND, 2);
> +	sched->submit_wq[PANTHOR_CSG_PRIORITY_LOW] = sched->submit_wq[PANTHOR_CSG_PRIORITY_MEDIUM];
> +	sched->submit_wq[PANTHOR_CSG_PRIORITY_HIGH] = alloc_workqueue("panthor-drm-high", WQ_HIGHPRI | WQ_MEM_RECLAIM | WQ_UNBOUND, 2);
> +	sched->submit_wq[PANTHOR_CSG_PRIORITY_RT] = alloc_workqueue("panthor-drm-rt", WQ_RT | WQ_MEM_RECLAIM | WQ_UNBOUND, 2);
> +	if (!sched->wq || !sched->heap_alloc_wq ||
> +	    !sched->submit_wq[PANTHOR_CSG_PRIORITY_MEDIUM] ||
> +	    !sched->submit_wq[PANTHOR_CSG_PRIORITY_HIGH] ||
> +	    !sched->submit_wq[PANTHOR_CSG_PRIORITY_RT]) {
>  		panthor_sched_fini(&ptdev->base, sched);
>  		drm_err(&ptdev->base, "Failed to allocate the workqueues");
>  		return -ENOMEM;
> -- 
> 2.56.0
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
