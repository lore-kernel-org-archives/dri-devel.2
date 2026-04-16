Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B03AAF8A163
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 11:39:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 186C310E88E;
	Thu, 16 Apr 2026 11:39:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="TKENET24";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DB1910E88B
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 11:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1ryApl0KHNaIlHZVg70CJmK/AIQvWYmEt+Uc65xyRec=; b=TKENET24zDtl0pO8PB+wQpKwqM
 N3kBYmmGuZ9nAb761l+ousF2hyV36naVScxZoaPwzLVfIgYhsQdMdcjTnjlTrPTYAqm3rqLHE/soQ
 VAB/g53lnTYPLywOS60Qogsz7PolGT2MtPvVDWMPxNDaARTu4hf1tE6xpYflytvLOkh2+bT/XVt6z
 EkTed1XGU9nYpYNOBkMkOl/ApDs7bkiVd9h596rXl8rBztz2T3cWR+QwKxb2qCVpg6uauJ0epIDZ5
 p09+LVtwM/AL3eDLQUpE7sBuxMSWeXQyswvzqIZFkjEA+kBugEdd0hiElAP1Lcx4NfY55U62q7DHz
 nHBDFfsw==;
Received: from [90.240.106.137] (helo=[192.168.0.101])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wDL49-00GxQX-Gf; Thu, 16 Apr 2026 13:39:25 +0200
Message-ID: <59d03f0f-068a-4a86-b52c-cd47742edf6e@igalia.com>
Date: Thu, 16 Apr 2026 12:39:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] drm/v3d: Clear queue->active_job when
 v3d_fence_create() fails
To: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Melissa Wen <mwen@igalia.com>, Iago Toral <itoral@igalia.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org
References: <20260413-v3d-sched-misc-fixes-v1-0-bac63a8ceb6c@igalia.com>
 <20260413-v3d-sched-misc-fixes-v1-2-bac63a8ceb6c@igalia.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <20260413-v3d-sched-misc-fixes-v1-2-bac63a8ceb6c@igalia.com>
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


On 13/04/2026 16:03, Maíra Canal wrote:
> The run_job() callbacks for BIN, RENDER, TFU and CSD assign the incoming
> job to queue->active_job before calling v3d_fence_create(). If
> v3d_fence_create() fails, the callback returns NULL without clearing
> active_job, leaving a dangling pointer.

I don't know the driver well enough to know if this can be hit, or under 
which circumstances (spurious interrupt?), but the fix looks correct 
regardless.

One small doubt below.

> Create a failure path in all run_job() callbacks that clears the active
> job before returning NULL. The BIN path takes queue->queue_lock around the
> clear as it races against v3d_overflow_mem_work(); RENDER, TFU and CSD
> paths have no concurrent reader, so the clear is lock-free.
> 
> Fixes: a783a09ee76d ("drm/v3d: Refactor job management.")
> Signed-off-by: Maíra Canal <mcanal@igalia.com>
> ---
>   drivers/gpu/drm/v3d/v3d_sched.c | 52 ++++++++++++++++++++++++-----------------
>   1 file changed, 30 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/gpu/drm/v3d/v3d_sched.c b/drivers/gpu/drm/v3d/v3d_sched.c
> index 1855ef5b3b5f..d42db75e639b 100644
> --- a/drivers/gpu/drm/v3d/v3d_sched.c
> +++ b/drivers/gpu/drm/v3d/v3d_sched.c
> @@ -206,12 +206,8 @@ static struct dma_fence *v3d_bin_job_run(struct drm_sched_job *sched_job)
>   	struct dma_fence *fence;
>   	unsigned long irqflags;
>   
> -	if (unlikely(job->base.base.s_fence->finished.error)) {
> -		spin_lock_irqsave(&queue->queue_lock, irqflags);
> -		queue->active_job = NULL;
> -		spin_unlock_irqrestore(&queue->queue_lock, irqflags);
> -		return NULL;
> -	}
> +	if (unlikely(job->base.base.s_fence->finished.error))
> +		goto out_clean_job;
>   
>   	/* Lock required around bin_job update vs
>   	 * v3d_overflow_mem_work().
> @@ -228,7 +224,7 @@ static struct dma_fence *v3d_bin_job_run(struct drm_sched_job *sched_job)
>   
>   	fence = v3d_fence_create(v3d, V3D_BIN);
>   	if (IS_ERR(fence))
> -		return NULL;
> +		goto out_clean_job;

I wonder whether it would be feasible to simply only assign to 
queue->active_job after fence has been created and have a smaller diff 
for backporting?

Either way the patch looks correct to me:

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Regards,

Tvrtko

>   
>   	if (job->base.irq_fence)
>   		dma_fence_put(job->base.irq_fence);
> @@ -256,6 +252,12 @@ static struct dma_fence *v3d_bin_job_run(struct drm_sched_job *sched_job)
>   	V3D_CORE_WRITE(0, V3D_CLE_CT0QEA, job->end);
>   
>   	return fence;
> +
> +out_clean_job:
> +	spin_lock_irqsave(&queue->queue_lock, irqflags);
> +	queue->active_job = NULL;
> +	spin_unlock_irqrestore(&queue->queue_lock, irqflags);
> +	return NULL;
>   }
>   
>   static struct dma_fence *v3d_render_job_run(struct drm_sched_job *sched_job)
> @@ -265,10 +267,8 @@ static struct dma_fence *v3d_render_job_run(struct drm_sched_job *sched_job)
>   	struct drm_device *dev = &v3d->drm;
>   	struct dma_fence *fence;
>   
> -	if (unlikely(job->base.base.s_fence->finished.error)) {
> -		v3d->queue[V3D_RENDER].active_job = NULL;
> -		return NULL;
> -	}
> +	if (unlikely(job->base.base.s_fence->finished.error))
> +		goto out_clean_job;
>   
>   	v3d->queue[V3D_RENDER].active_job = &job->base;
>   
> @@ -282,7 +282,7 @@ static struct dma_fence *v3d_render_job_run(struct drm_sched_job *sched_job)
>   
>   	fence = v3d_fence_create(v3d, V3D_RENDER);
>   	if (IS_ERR(fence))
> -		return NULL;
> +		goto out_clean_job;
>   
>   	if (job->base.irq_fence)
>   		dma_fence_put(job->base.irq_fence);
> @@ -303,6 +303,10 @@ static struct dma_fence *v3d_render_job_run(struct drm_sched_job *sched_job)
>   	V3D_CORE_WRITE(0, V3D_CLE_CT1QEA, job->end);
>   
>   	return fence;
> +
> +out_clean_job:
> +	v3d->queue[V3D_RENDER].active_job = NULL;
> +	return NULL;
>   }
>   
>   static struct dma_fence *
> @@ -313,16 +317,14 @@ v3d_tfu_job_run(struct drm_sched_job *sched_job)
>   	struct drm_device *dev = &v3d->drm;
>   	struct dma_fence *fence;
>   
> -	if (unlikely(job->base.base.s_fence->finished.error)) {
> -		v3d->queue[V3D_TFU].active_job = NULL;
> -		return NULL;
> -	}
> +	if (unlikely(job->base.base.s_fence->finished.error))
> +		goto out_clean_job;
>   
>   	v3d->queue[V3D_TFU].active_job = &job->base;
>   
>   	fence = v3d_fence_create(v3d, V3D_TFU);
>   	if (IS_ERR(fence))
> -		return NULL;
> +		goto out_clean_job;
>   
>   	if (job->base.irq_fence)
>   		dma_fence_put(job->base.irq_fence);
> @@ -350,6 +352,10 @@ v3d_tfu_job_run(struct drm_sched_job *sched_job)
>   	V3D_WRITE(V3D_TFU_ICFG(v3d->ver), job->args.icfg | V3D_TFU_ICFG_IOC);
>   
>   	return fence;
> +
> +out_clean_job:
> +	v3d->queue[V3D_TFU].active_job = NULL;
> +	return NULL;
>   }
>   
>   static struct dma_fence *
> @@ -361,10 +367,8 @@ v3d_csd_job_run(struct drm_sched_job *sched_job)
>   	struct dma_fence *fence;
>   	int i, csd_cfg0_reg;
>   
> -	if (unlikely(job->base.base.s_fence->finished.error)) {
> -		v3d->queue[V3D_CSD].active_job = NULL;
> -		return NULL;
> -	}
> +	if (unlikely(job->base.base.s_fence->finished.error))
> +		goto out_clean_job;
>   
>   	v3d->queue[V3D_CSD].active_job = &job->base;
>   
> @@ -372,7 +376,7 @@ v3d_csd_job_run(struct drm_sched_job *sched_job)
>   
>   	fence = v3d_fence_create(v3d, V3D_CSD);
>   	if (IS_ERR(fence))
> -		return NULL;
> +		goto out_clean_job;
>   
>   	if (job->base.irq_fence)
>   		dma_fence_put(job->base.irq_fence);
> @@ -399,6 +403,10 @@ v3d_csd_job_run(struct drm_sched_job *sched_job)
>   	V3D_CORE_WRITE(0, csd_cfg0_reg, job->args.cfg[0]);
>   
>   	return fence;
> +
> +out_clean_job:
> +	v3d->queue[V3D_CSD].active_job = NULL;
> +	return NULL;
>   }
>   
>   static void
> 

