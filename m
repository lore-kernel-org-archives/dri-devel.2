Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0724F8A15F
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 11:46:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F17210E88F;
	Thu, 16 Apr 2026 11:46:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="K3e2I8UB";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94E0010E88F
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 11:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WzF9ayCs4D6rVy6c3e+LfQDj8TL4U/sHqoi6tvNQIVE=; b=K3e2I8UBdrKZprTmd9er51Ryfq
 xUV5iJ9JgvG1LZeQUY9kTrgiS9y2zf4De6EerWSnwEtnYI4CNLGG3ywZC/AjZdb+ufdRjI882DEWx
 AcyqixuTVE683AJakCGZ0P2s8qcUJFlOiuYMHHF22LhGSjd1qo9YRYM/hoJgjVX2olXxE6UJExCcp
 rVKQvVMfs5NQTnC6bzaZb4E/9a1N1PjD+fD13MxzpyotUetVHVEfQU2oBMFveYwrtnW3tk8HCHLzs
 4YI/Ihvk41EA6sXgFRH9mxuKw9/Zr/DPjIKMnwj2goxDeH++4zTRa/Qcl0L5RYx32jKr+xRBV7moO
 /PBYstAw==;
Received: from [90.240.106.137] (helo=[192.168.0.101])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wDLAm-00GxbU-76; Thu, 16 Apr 2026 13:46:16 +0200
Message-ID: <16c06f02-3497-4a4b-9818-911154b7ed7a@igalia.com>
Date: Thu, 16 Apr 2026 12:46:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10] drm/v3d: Replace spin_lock_irqsave() with
 spin_lock_irq()
To: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Melissa Wen <mwen@igalia.com>, Iago Toral <itoral@igalia.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org
References: <20260413-v3d-sched-misc-fixes-v1-0-bac63a8ceb6c@igalia.com>
 <20260413-v3d-sched-misc-fixes-v1-4-bac63a8ceb6c@igalia.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <20260413-v3d-sched-misc-fixes-v1-4-bac63a8ceb6c@igalia.com>
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
> v3d_overflow_mem_work() and v3d_bin_job_run() both run from workqueue
> context where IRQs are always enabled, so the flags save/restore of
> spin_lock_irqsave() is unnecessary. Use spin_lock_irq() instead.

spin_(un)lock looks would be enough. Sorry if it was me who said 
spin_lock_irq during the previous round?

Regards,

Tvrtko

> Signed-off-by: Maíra Canal <mcanal@igalia.com>
> ---
>   drivers/gpu/drm/v3d/v3d_irq.c   | 7 +++----
>   drivers/gpu/drm/v3d/v3d_sched.c | 9 ++++-----
>   2 files changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/v3d/v3d_irq.c b/drivers/gpu/drm/v3d/v3d_irq.c
> index 86efaef2722c..d4d7c39227be 100644
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
> @@ -64,17 +63,17 @@ v3d_overflow_mem_work(struct work_struct *work)
>   	 * bin job got scheduled, that's fine.  We'll just give them
>   	 * some binner pool anyway.
>   	 */
> -	spin_lock_irqsave(&queue->queue_lock, irqflags);
> +	spin_lock_irq(&queue->queue_lock);
>   	bin_job = (struct v3d_bin_job *)queue->active_job;
>   
>   	if (!bin_job) {
> -		spin_unlock_irqrestore(&queue->queue_lock, irqflags);
> +		spin_unlock_irq(&queue->queue_lock);
>   		goto out;
>   	}
>   
>   	drm_gem_object_get(obj);
>   	list_add_tail(&bo->unref_head, &bin_job->render->unref_list);
> -	spin_unlock_irqrestore(&queue->queue_lock, irqflags);
> +	spin_unlock_irq(&queue->queue_lock);
>   
>   	v3d_mmu_flush_all(v3d);
>   
> diff --git a/drivers/gpu/drm/v3d/v3d_sched.c b/drivers/gpu/drm/v3d/v3d_sched.c
> index d42db75e639b..f3999678e5da 100644
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
> +	spin_lock_irq(&queue->queue_lock);
>   	queue->active_job = &job->base;
>   	/* Clear out the overflow allocation, so we don't
>   	 * reuse the overflow attached to a previous job.
>   	 */
>   	V3D_CORE_WRITE(0, V3D_PTB_BPOS, 0);
> -	spin_unlock_irqrestore(&queue->queue_lock, irqflags);
> +	spin_unlock_irq(&queue->queue_lock);
>   
>   	v3d_invalidate_caches(v3d);
>   
> @@ -254,9 +253,9 @@ static struct dma_fence *v3d_bin_job_run(struct drm_sched_job *sched_job)
>   	return fence;
>   
>   out_clean_job:
> -	spin_lock_irqsave(&queue->queue_lock, irqflags);
> +	spin_lock_irq(&queue->queue_lock);
>   	queue->active_job = NULL;
> -	spin_unlock_irqrestore(&queue->queue_lock, irqflags);
> +	spin_unlock_irq(&queue->queue_lock);
>   	return NULL;
>   }
>   
> 

