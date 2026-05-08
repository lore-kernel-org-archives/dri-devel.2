Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A498ACD3445
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 14:01:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0742510F4DD;
	Fri,  8 May 2026 14:01:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="FEy3pwYk";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 045D310F4DD
 for <dri-devel@lists.freedesktop.org>; Fri,  8 May 2026 14:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3/nIIl+Qgc1RYZL/F4cmYBP6rKtjTQwBlnybZVHHJ1U=; b=FEy3pwYkIiCGUaLE7xkjXuDmqg
 jFJNtm273ia01BkHtaCy85O+fjXvcaeqKcfmPHx+BlrW03wZhMX+DLxOiE+xkZCnFi1DWxiAzk2Rb
 w8JBSGEp84YliLPiLT1XNPBcHXvMDwUg5l/eT5UdEZQJS+pNh3w8kJ7o++OY0q6e4EEuOSaEHMoO5
 bXwWPBYmH7QorH8+fj4YBeDgXn3CELYLvgiFbJqOLSRvP76l2XXnIyxk8APuRoYUl4+ZV4E7idRl2
 eJwkO2beg71PcH5o8BJAH8881fpVgza7noP6NiDAnE7CPJ+V8lzlEPrKVoAzXyfjLcvsKEklhoC35
 6t2MCj3w==;
Received: from [189.7.87.137] (helo=[192.168.0.5])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wLLlY-007uYl-DW; Fri, 08 May 2026 16:01:19 +0200
Message-ID: <d8fce777-ad3a-4af3-a9be-dd2871c2cffa@igalia.com>
Date: Fri, 8 May 2026 11:01:14 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] drm/v3d: Clear queue->active_job when
 v3d_fence_create() fails
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, Melissa Wen
 <mwen@igalia.com>, Iago Toral <itoral@igalia.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org
References: <20260413-v3d-sched-misc-fixes-v1-0-bac63a8ceb6c@igalia.com>
 <20260413-v3d-sched-misc-fixes-v1-2-bac63a8ceb6c@igalia.com>
 <59d03f0f-068a-4a86-b52c-cd47742edf6e@igalia.com>
From: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Content-Language: en-US
Autocrypt: addr=mcanal@igalia.com; keydata=
 xsBNBGcCwywBCADgTji02Sv9zjHo26LXKdCaumcSWglfnJ93rwOCNkHfPIBll85LL9G0J7H8
 /PmEL9y0LPo9/B3fhIpbD8VhSy9Sqz8qVl1oeqSe/rh3M+GceZbFUPpMSk5pNY9wr5raZ63d
 gJc1cs8XBhuj1EzeE8qbP6JAmsL+NMEmtkkNPfjhX14yqzHDVSqmAFEsh4Vmw6oaTMXvwQ40
 SkFjtl3sr20y07cJMDe++tFet2fsfKqQNxwiGBZJsjEMO2T+mW7DuV2pKHr9aifWjABY5EPw
 G7qbrh+hXgfT+njAVg5+BcLz7w9Ju/7iwDMiIY1hx64Ogrpwykj9bXav35GKobicCAwHABEB
 AAHNIE1hw61yYSBDYW5hbCA8bWNhbmFsQGlnYWxpYS5jb20+wsCRBBMBCAA7FiEE+ORdfQEW
 dwcppnfRP/MOinaI+qoFAmcCwywCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQ
 P/MOinaI+qoUBQgAqz2gzUP7K3EBI24+a5FwFlruQGtim85GAJZXToBtzsfGLLVUSCL3aF/5
 O335Bh6ViSBgxmowIwVJlS/e+L95CkTGzIIMHgyUZfNefR2L3aZA6cgc9z8cfow62Wu8eXnq
 GM/+WWvrFQb/dBKKuohfBlpThqDWXxhozazCcJYYHradIuOM8zyMtCLDYwPW7Vqmewa+w994
 7Lo4CgOhUXVI2jJSBq3sgHEPxiUBOGxvOt1YBg7H9C37BeZYZxFmU8vh7fbOsvhx7Aqu5xV7
 FG+1ZMfDkv+PixCuGtR5yPPaqU2XdjDC/9mlRWWQTPzg74RLEw5sz/tIHQPPm6ROCACFls7A
 TQRnAsMsAQgAxTU8dnqzK6vgODTCW2A6SAzcvKztxae4YjRwN1SuGhJR2isJgQHoOH6oCItW
 Xc1CGAWnci6doh1DJvbbB7uvkQlbeNxeIz0OzHSiB+pb1ssuT31Hz6QZFbX4q+crregPIhr+
 0xeDi6Mtu+paYprI7USGFFjDUvJUf36kK0yuF2XUOBlF0beCQ7Jhc+UoI9Akmvl4sHUrZJzX
 LMeajARnSBXTcig6h6/NFVkr1mi1uuZfIRNCkxCE8QRYebZLSWxBVr3h7dtOUkq2CzL2kRCK
 T2rKkmYrvBJTqSvfK3Ba7QrDg3szEe+fENpL3gHtH6h/XQF92EOulm5S5o0I+ceREwARAQAB
 wsB2BBgBCAAgFiEE+ORdfQEWdwcppnfRP/MOinaI+qoFAmcCwywCGwwACgkQP/MOinaI+qpI
 zQf+NAcNDBXWHGA3lgvYvOU31+ik9bb30xZ7IqK9MIi6TpZqL7cxNwZ+FAK2GbUWhy+/gPkX
 it2gCAJsjo/QEKJi7Zh8IgHN+jfim942QZOkU+p/YEcvqBvXa0zqW0sYfyAxkrf/OZfTnNNE
 Tr+uBKNaQGO2vkn5AX5l8zMl9LCH3/Ieaboni35qEhoD/aM0Kpf93PhCvJGbD4n1DnRhrxm1
 uEdQ6HUjWghEjC+Jh9xUvJco2tUTepw4OwuPxOvtuPTUa1kgixYyG1Jck/67reJzMigeuYFt
 raV3P8t/6cmtawVjurhnCDuURyhUrjpRhgFp+lW8OGr6pepHol/WFIOQEg==
In-Reply-To: <59d03f0f-068a-4a86-b52c-cd47742edf6e@igalia.com>
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

Hi Tvrtko,

On 16/04/26 08:39, Tvrtko Ursulin wrote:
> 
> On 13/04/2026 16:03, Maíra Canal wrote:
>> The run_job() callbacks for BIN, RENDER, TFU and CSD assign the incoming
>> job to queue->active_job before calling v3d_fence_create(). If
>> v3d_fence_create() fails, the callback returns NULL without clearing
>> active_job, leaving a dangling pointer.
> 
> I don't know the driver well enough to know if this can be hit, or under 
> which circumstances (spurious interrupt?), but the fix looks correct 
> regardless.
> 
> One small doubt below.
> 
>> Create a failure path in all run_job() callbacks that clears the active
>> job before returning NULL. The BIN path takes queue->queue_lock around 
>> the
>> clear as it races against v3d_overflow_mem_work(); RENDER, TFU and CSD
>> paths have no concurrent reader, so the clear is lock-free.
>>
>> Fixes: a783a09ee76d ("drm/v3d: Refactor job management.")
>> Signed-off-by: Maíra Canal <mcanal@igalia.com>
>> ---
>>   drivers/gpu/drm/v3d/v3d_sched.c | 52 +++++++++++++++++++++++ 
>> +-----------------
>>   1 file changed, 30 insertions(+), 22 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/v3d/v3d_sched.c b/drivers/gpu/drm/v3d/ 
>> v3d_sched.c
>> index 1855ef5b3b5f..d42db75e639b 100644
>> --- a/drivers/gpu/drm/v3d/v3d_sched.c
>> +++ b/drivers/gpu/drm/v3d/v3d_sched.c
>> @@ -206,12 +206,8 @@ static struct dma_fence *v3d_bin_job_run(struct 
>> drm_sched_job *sched_job)
>>       struct dma_fence *fence;
>>       unsigned long irqflags;
>> -    if (unlikely(job->base.base.s_fence->finished.error)) {
>> -        spin_lock_irqsave(&queue->queue_lock, irqflags);
>> -        queue->active_job = NULL;
>> -        spin_unlock_irqrestore(&queue->queue_lock, irqflags);
>> -        return NULL;
>> -    }
>> +    if (unlikely(job->base.base.s_fence->finished.error))
>> +        goto out_clean_job;
>>       /* Lock required around bin_job update vs
>>        * v3d_overflow_mem_work().
>> @@ -228,7 +224,7 @@ static struct dma_fence *v3d_bin_job_run(struct 
>> drm_sched_job *sched_job)
>>       fence = v3d_fence_create(v3d, V3D_BIN);
>>       if (IS_ERR(fence))
>> -        return NULL;
>> +        goto out_clean_job;
> 
> I wonder whether it would be feasible to simply only assign to queue- 
>  >active_job after fence has been created and have a smaller diff for 
> backporting?

I'm not sure if it's worth to backport this patch, as this issue dates
back to Linux 5.10. Considering that the issue can only happen if
kzalloc fails, I'd consider it a low priority bug.

> 
> Either way the patch looks correct to me:
> 
> Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Thanks for the review!

Best regards,
- Maíra

> 
> Regards,
> 
> Tvrtko
> 
>>       if (job->base.irq_fence)
>>           dma_fence_put(job->base.irq_fence);
>> @@ -256,6 +252,12 @@ static struct dma_fence *v3d_bin_job_run(struct 
>> drm_sched_job *sched_job)
>>       V3D_CORE_WRITE(0, V3D_CLE_CT0QEA, job->end);
>>       return fence;
>> +
>> +out_clean_job:
>> +    spin_lock_irqsave(&queue->queue_lock, irqflags);
>> +    queue->active_job = NULL;
>> +    spin_unlock_irqrestore(&queue->queue_lock, irqflags);
>> +    return NULL;
>>   }
>>   static struct dma_fence *v3d_render_job_run(struct drm_sched_job 
>> *sched_job)
>> @@ -265,10 +267,8 @@ static struct dma_fence 
>> *v3d_render_job_run(struct drm_sched_job *sched_job)
>>       struct drm_device *dev = &v3d->drm;
>>       struct dma_fence *fence;
>> -    if (unlikely(job->base.base.s_fence->finished.error)) {
>> -        v3d->queue[V3D_RENDER].active_job = NULL;
>> -        return NULL;
>> -    }
>> +    if (unlikely(job->base.base.s_fence->finished.error))
>> +        goto out_clean_job;
>>       v3d->queue[V3D_RENDER].active_job = &job->base;
>> @@ -282,7 +282,7 @@ static struct dma_fence *v3d_render_job_run(struct 
>> drm_sched_job *sched_job)
>>       fence = v3d_fence_create(v3d, V3D_RENDER);
>>       if (IS_ERR(fence))
>> -        return NULL;
>> +        goto out_clean_job;
>>       if (job->base.irq_fence)
>>           dma_fence_put(job->base.irq_fence);
>> @@ -303,6 +303,10 @@ static struct dma_fence 
>> *v3d_render_job_run(struct drm_sched_job *sched_job)
>>       V3D_CORE_WRITE(0, V3D_CLE_CT1QEA, job->end);
>>       return fence;
>> +
>> +out_clean_job:
>> +    v3d->queue[V3D_RENDER].active_job = NULL;
>> +    return NULL;
>>   }
>>   static struct dma_fence *
>> @@ -313,16 +317,14 @@ v3d_tfu_job_run(struct drm_sched_job *sched_job)
>>       struct drm_device *dev = &v3d->drm;
>>       struct dma_fence *fence;
>> -    if (unlikely(job->base.base.s_fence->finished.error)) {
>> -        v3d->queue[V3D_TFU].active_job = NULL;
>> -        return NULL;
>> -    }
>> +    if (unlikely(job->base.base.s_fence->finished.error))
>> +        goto out_clean_job;
>>       v3d->queue[V3D_TFU].active_job = &job->base;
>>       fence = v3d_fence_create(v3d, V3D_TFU);
>>       if (IS_ERR(fence))
>> -        return NULL;
>> +        goto out_clean_job;
>>       if (job->base.irq_fence)
>>           dma_fence_put(job->base.irq_fence);
>> @@ -350,6 +352,10 @@ v3d_tfu_job_run(struct drm_sched_job *sched_job)
>>       V3D_WRITE(V3D_TFU_ICFG(v3d->ver), job->args.icfg | 
>> V3D_TFU_ICFG_IOC);
>>       return fence;
>> +
>> +out_clean_job:
>> +    v3d->queue[V3D_TFU].active_job = NULL;
>> +    return NULL;
>>   }
>>   static struct dma_fence *
>> @@ -361,10 +367,8 @@ v3d_csd_job_run(struct drm_sched_job *sched_job)
>>       struct dma_fence *fence;
>>       int i, csd_cfg0_reg;
>> -    if (unlikely(job->base.base.s_fence->finished.error)) {
>> -        v3d->queue[V3D_CSD].active_job = NULL;
>> -        return NULL;
>> -    }
>> +    if (unlikely(job->base.base.s_fence->finished.error))
>> +        goto out_clean_job;
>>       v3d->queue[V3D_CSD].active_job = &job->base;
>> @@ -372,7 +376,7 @@ v3d_csd_job_run(struct drm_sched_job *sched_job)
>>       fence = v3d_fence_create(v3d, V3D_CSD);
>>       if (IS_ERR(fence))
>> -        return NULL;
>> +        goto out_clean_job;
>>       if (job->base.irq_fence)
>>           dma_fence_put(job->base.irq_fence);
>> @@ -399,6 +403,10 @@ v3d_csd_job_run(struct drm_sched_job *sched_job)
>>       V3D_CORE_WRITE(0, csd_cfg0_reg, job->args.cfg[0]);
>>       return fence;
>> +
>> +out_clean_job:
>> +    v3d->queue[V3D_CSD].active_job = NULL;
>> +    return NULL;
>>   }
>>   static void
>>
> 

