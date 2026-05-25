Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93542CD5BD0
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 10:58:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3C6510E00F;
	Mon, 25 May 2026 10:57:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="ILYktu1Z";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F2E010E00F
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 10:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3gZrGj2YR3+SfoOQuAgMhl6DjNIOV/Cz4XPSgQ/V+Kk=; b=ILYktu1Z7fiAMgtt1cQj4l3DEj
 Hr5ieqIhRp3TWAtb8xpu+RtJ2KCcgUbMcQLH/8LZU0axzFiYBftIKg+CvcWI6iR/pu3W8rnq3QtTL
 atuAl63/k7XyI3OHded7sm3GLdMn8PfHO2dew6uWhktxJWaZcNAPNFG5suiDv9KeBKMbPx+u5Q4qR
 ch7ogi1kvF4BiuxI5YcL4DhPW08tLCIL2deb5fsdsX5B8IHmoYhNT69rXzfJ3+QfPIGEX9JNictV+
 +SyBIIUcSs7uFp927IXAc7WFFeyl6B+4XJba0Qg6lhHI9iogB+l4OsswzgfnY/Y/xUjhqcTYBf5XR
 jcO0TU8A==;
Received: from [90.240.106.137] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wRT0C-007yr1-2e; Mon, 25 May 2026 12:57:44 +0200
Message-ID: <51bc9733-162f-4c1a-88e8-99f23b4677ee@igalia.com>
Date: Mon, 25 May 2026 11:57:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/14] drm/v3d: Replace spin_lock_irqsave() with
 spin_lock()
To: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Melissa Wen <mwen@igalia.com>, Iago Toral <itoral@igalia.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org
References: <20260510-v3d-sched-misc-fixes-v2-0-ca4aba343ef6@igalia.com>
 <20260510-v3d-sched-misc-fixes-v2-4-ca4aba343ef6@igalia.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <20260510-v3d-sched-misc-fixes-v2-4-ca4aba343ef6@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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


On 10/05/2026 23:12, Maíra Canal wrote:
> queue->queue_lock is only acquired from v3d_overflow_mem_work() and
> v3d_bin_job_run(), both of which run from workqueue context. The hard
> IRQ handler does not take this lock, so disabling interrupts while
> holding it is unnecessary.
> 
> Drop the spin_lock_irqsave() and use plain spin_(un)lock() instead.
> 
> Signed-off-by: Maíra Canal <mcanal@igalia.com>
> ---
>   drivers/gpu/drm/v3d/v3d_irq.c   | 17 +++++++----------
>   drivers/gpu/drm/v3d/v3d_sched.c | 21 ++++++++++-----------
>   2 files changed, 17 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/gpu/drm/v3d/v3d_irq.c b/drivers/gpu/drm/v3d/v3d_irq.c
> index 86efaef2722c..754a969b862b 100644
> --- a/drivers/gpu/drm/v3d/v3d_irq.c
> +++ b/drivers/gpu/drm/v3d/v3d_irq.c
> @@ -47,7 +47,6 @@ v3d_overflow_mem_work(struct work_struct *work)
>   	struct v3d_queue_state *queue = &v3d->queue[V3D_BIN];
>   	struct v3d_bin_job *bin_job;
>   	struct drm_gem_object *obj;
> -	unsigned long irqflags;
>   
>   	if (IS_ERR(bo)) {
>   		drm_err(dev, "Couldn't allocate binner overflow mem\n");
> @@ -64,18 +63,16 @@ v3d_overflow_mem_work(struct work_struct *work)
>   	 * bin job got scheduled, that's fine.  We'll just give them
>   	 * some binner pool anyway.
>   	 */
> -	spin_lock_irqsave(&queue->queue_lock, irqflags);
> -	bin_job = (struct v3d_bin_job *)queue->active_job;
> +	scoped_guard(spinlock, &queue->queue_lock) {
> +		bin_job = (struct v3d_bin_job *)queue->active_job;
>   
> -	if (!bin_job) {
> -		spin_unlock_irqrestore(&queue->queue_lock, irqflags);
> -		goto out;
> +		if (!bin_job)
> +			goto out;
> +
> +		drm_gem_object_get(obj);
> +		list_add_tail(&bo->unref_head, &bin_job->render->unref_list);
>   	}
>   
> -	drm_gem_object_get(obj);
> -	list_add_tail(&bo->unref_head, &bin_job->render->unref_list);
> -	spin_unlock_irqrestore(&queue->queue_lock, irqflags);
> -
>   	v3d_mmu_flush_all(v3d);
>   
>   	V3D_CORE_WRITE(0, V3D_PTB_BPOA, bo->node.start << V3D_MMU_PAGE_SHIFT);
> diff --git a/drivers/gpu/drm/v3d/v3d_sched.c b/drivers/gpu/drm/v3d/v3d_sched.c
> index 66569b538e4e..cc3212e2cb5d 100644
> --- a/drivers/gpu/drm/v3d/v3d_sched.c
> +++ b/drivers/gpu/drm/v3d/v3d_sched.c
> @@ -204,7 +204,6 @@ static struct dma_fence *v3d_bin_job_run(struct drm_sched_job *sched_job)
>   	struct v3d_queue_state *queue = &v3d->queue[V3D_BIN];
>   	struct drm_device *dev = &v3d->drm;
>   	struct dma_fence *fence;
> -	unsigned long irqflags;
>   
>   	if (unlikely(job->base.base.s_fence->finished.error))
>   		goto out_clean_job;
> @@ -212,13 +211,13 @@ static struct dma_fence *v3d_bin_job_run(struct drm_sched_job *sched_job)
>   	/* Lock required around bin_job update vs
>   	 * v3d_overflow_mem_work().
>   	 */
> -	spin_lock_irqsave(&queue->queue_lock, irqflags);
> -	queue->active_job = &job->base;
> -	/* Clear out the overflow allocation, so we don't
> -	 * reuse the overflow attached to a previous job.
> -	 */
> -	V3D_CORE_WRITE(0, V3D_PTB_BPOS, 0);
> -	spin_unlock_irqrestore(&queue->queue_lock, irqflags);
> +	scoped_guard(spinlock, &queue->queue_lock) {
> +		queue->active_job = &job->base;
> +		/* Clear out the overflow allocation, so we don't
> +		 * reuse the overflow attached to a previous job.
> +		 */
> +		V3D_CORE_WRITE(0, V3D_PTB_BPOS, 0);

Transformation is like-for-like and after the previous patch irq safety 
is indeed not needed, so:

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

The only thing I am not sure of is whether this write to V3D_PTB_BPOS 
needs to under the lock. Bin job run callback is the only place which 
touches it so maybe not? And if it doesn't, then of course do that 
movement in a separate patch.

Regards,

Tvrtko

> +	}
>   
>   	v3d_invalidate_caches(v3d);
>   
> @@ -254,9 +253,9 @@ static struct dma_fence *v3d_bin_job_run(struct drm_sched_job *sched_job)
>   	return fence;
>   
>   out_clean_job:
> -	spin_lock_irqsave(&queue->queue_lock, irqflags);
> -	queue->active_job = NULL;
> -	spin_unlock_irqrestore(&queue->queue_lock, irqflags);
> +	scoped_guard(spinlock, &queue->queue_lock) {
> +		queue->active_job = NULL;
> +	}
>   	return NULL;
>   }
>   
> 

