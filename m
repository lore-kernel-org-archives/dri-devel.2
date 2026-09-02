Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 276A9C624D0
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 09:46:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E0FD10E1FF;
	Wed,  2 Sep 2026 09:46:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="oDK8MWQN";
	dkim-atps=neutral
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com
 [209.85.218.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87F4310E495
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 09:46:28 +0000 (UTC)
Received: by mail-ej1-f48.google.com with SMTP id
 a640c23a62f3a-c20ce3c118aso172871366b.0
 for <dri-devel@lists.freedesktop.org>; Wed, 02 Sep 2026 02:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1788342387; x=1788947187; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=GUxXRAsScbasjh7s3OWikJdhIfzJpIqvpE5QFbde7vc=;
 b=oDK8MWQND9ll9PT7gkEvYmZAdcr92LcHsZNm7HJ42IDU6602IYArEhFAD44QaZCEKk
 cqq5Nu4MVkUFmE9IXBxSXOverNXyZqlTFk+WGkAcMJMk+fy4eEOHqkPcY+1WcrFFa2BG
 XEwcat/hyx/xxFGo233gy4sU9us//hTFW2XJzFQdIpoPhjz7/xR5IuIiWXyGu3noV/4G
 fwfLfzMYB9ZVhnFcbbb1x+/o5C6EV136U6HW90R/kqcy9E8SiacsLTmKdtezNFVsXQGb
 0/K1ZYlzfgaKK+CwregNrqnvqCzkpPPdGVQIh2XVSus18Gx380nZXokfshDX7aOE9UCw
 aRRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788342387; x=1788947187;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GUxXRAsScbasjh7s3OWikJdhIfzJpIqvpE5QFbde7vc=;
 b=CTVKgEsorM9vpcK/SsBZwb2FOfoEgmWP714wC0yLwY8HAPvsItyFUexL+eooFUzxjc
 jmbmaA5b9NGGQyoK39K7mndSWxr2t687LanhNLoKvVi8MCkFUTjRV2rkVK0Pry63J5Rd
 +8esdFTG+0YVHkHSYkz7PvKYUuMal/9IlGUupMojQLhYAq65QG7VgYfuNRfNRftRS1Rf
 McCNDjWEvKexbZscyQqryKePe2l0yC3S7snaptTvv+S7uDRKbs2NBUy+GsMqNJaPUA4E
 ZnY2186GH/ctu6fmPrMWPdf8Yfw+Tp0pnJjOaXRlOk66Y1zMGqS0aSdVygB7NFuDL4l2
 BjjA==
X-Forwarded-Encrypted: i=1;
 AKwUvBx8oZiTJiM/JWk6oaBU4B1+lqv+eACJ73MLanwVSqyASIrMSnbL5N/rB2XlaWSMWfLzq1eoYjWSjSQ=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lFGFwVLtAu8v33XsX8onRYnyM0qne04+mnxI1ES+wr6Q9sKdi4
 1+nzfjk9ZxCHwo9DOOA7Sx1reVCEcMPDp0Zh83KnZQ9bHqW8RADPrTVpzk4t2dP1p24=
X-Gm-Gg: AYBFou0FotIX+ySHNGEtW2GqrGy412+9CQO29eJpNTkiYlzuO/EnBoCdS2LP89NsIC9
 57w7KwHewvmMHsXHEnxT57FxlrRJzSPVYBHnsOLVM79rDDx/c4VW0qi2nOyBmzI1ZBAznFfJW0n
 KMeSmr2cppS/jqRVCRLIOoVCuZHLTVMgQ243zdZVGxtbcpJPLD6bMRHHjltGx6AZZJS8R7/8aJD
 07lPeh/37sKtO29xVkFI73p97tYsl7nZEdMcc309ofjmM6/6RpcT7GuOYy0caHq0jBqQ6548Iow
 ulGAWyP59wBmntE4AGtxEZXHqOzyYikyG3/Fw22R6VkWFOcNT2UBoOLRAspUWuLC//xe0wEN5Gg
 k2Li0f4mG+C75H+FisAxbF71yv8gK9mLJToT/rggMNVE936Jz4J7jhcArat3OSl6WfvTxNMDbhE
 CpaCjmxTqg+l+QJTElw+N5AJ2OGG5teLfqyOQ2C6L910oIqg2ISfM9kkojpJR0LXkbR9PGGLNuJ
 G/g
X-Received: by 2002:a17:907:7b85:b0:c1c:49d9:4c34 with SMTP id
 a640c23a62f3a-c25dcc4c76dmr115853966b.11.1788342386564; 
 Wed, 02 Sep 2026 02:46:26 -0700 (PDT)
Received: from [192.168.0.116] ([81.79.79.1]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c25d0426726sm101629066b.58.2026.09.02.02.46.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2026 02:46:26 -0700 (PDT)
Message-ID: <8c2a4df5-37a4-414e-81e2-cd97218e5355@ursulin.net>
Date: Wed, 2 Sep 2026 10:46:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] drm/sched: cache the timeline name to fix a
 use-after-free
To: "Jonghyuk Kim(MalHyuk)" <malhyuk97@gmail.com>,
 Matthew Brost <matthew.brost@intel.com>, Danilo Krummrich <dakr@kernel.org>,
 Philipp Stanner <phasta@kernel.org>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
References: <cover.1787928528.git.malhyuk97@gmail.com>
 <b191f55e53492f95d965407f891fd93b0e74958d.1787928528.git.malhyuk97@gmail.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <b191f55e53492f95d965407f891fd93b0e74958d.1787928528.git.malhyuk97@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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


+ Christian's AMD email

On 28/08/2026 15:57, Jonghyuk Kim(MalHyuk) wrote:
> drm_sched_fence_get_timeline_name() returns fence->sched->name, and the
> drm_sched_fence ops keep a .release callback, so the fence is not
> ops-detached on signalling (dma_fence_signal_timestamp_locked() only
> clears ->ops for fences without .release/.wait). The callback therefore
> stays reachable on a long-signalled, userspace-held finished fence and
> unconditionally dereferences fence->sched.
> 
> A driver that allocates a drm_gpu_scheduler at per-context/per-queue/
> per-VM granularity and frees it on an unprivileged context/fd close, while
> exporting the resulting finished fence to userspace (drm_syncobj /
> sync_file / dma_resv), leaves fence->sched dangling after the free. A
> subsequent SYNC_IOC_FILE_INFO ioctl (which calls get_timeline_name())
> then reads the freed scheduler:
> 
>    BUG: KASAN: slab-use-after-free in drm_sched_fence_get_timeline_name
> 
> This is the same class as CVE-2025-38703 (drm/xe) and CVE-2025-71302
> (drm/panthor), which were fixed per-driver. amdxdna, nouveau and msm
> (VM_BIND) are still affected in mainline, so fix it in the core to cover
> any per-context-scheduler driver at once.
> 
> Scheduler names are persistent strings (string literals passed to
> drm_sched_init()), so cache the name pointer in the fence at init time,
> while the scheduler is guaranteed alive, and return the cached value from
> get_timeline_name() without dereferencing fence->sched.

It is not guaranteed in the documented contract that the name passed to 
drm_sched_init has to outlive the scheduler.

Case in point is asking "would have this patch fixed CVE-2025-38703" - 
to which I think answer is no. Until recent 299bc6d50b1b ("drm/xe/guc: 
Keep scheduler timeline name alive") my attempt in 6bd90e700b42 
("drm/xe: Make dma-fences compliant with the safe access rules") only 
half fixed it by adding a RCU grace to the sched object itself, while 
missing the fact timeline name gets freed instantly. I haven't gotten 
round trying to understand why KASAN did not catch this back when I was 
upstreaming 6bd90e700b42.

Anyway, I think the fix will have to be to either add the full RCU grace 
around names in the scheduler object owning modules, or your patch plus 
documenting that the name passed to drm_sched_init must follow the 
dma-fence safe access rules (with kernel-doc cross-link and an 
explanation of the connection between scheduler name and dma-fence 
timeline name).

Hm, that might be overkill.. how about we just keep a copy of the name 
in the scheduler object? If we document that in gpu_scheduler.h it would 
fix the drivers still vulnerable, while the ones which were fixed could 
be simplified.

Regards,

Tvrtko

> Signed-off-by: Jonghyuk Kim(MalHyuk) <malhyuk97@gmail.com>
> ---
>   drivers/gpu/drm/scheduler/sched_fence.c | 16 +++++++++++++++-
>   include/drm/gpu_scheduler.h             | 11 +++++++++++
>   2 files changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/scheduler/sched_fence.c b/drivers/gpu/drm/scheduler/sched_fence.c
> index 85ee3d694dc9..280a2d036ffd 100644
> --- a/drivers/gpu/drm/scheduler/sched_fence.c
> +++ b/drivers/gpu/drm/scheduler/sched_fence.c
> @@ -92,7 +92,13 @@ static const char *drm_sched_fence_get_driver_name(struct dma_fence *fence)
>   static const char *drm_sched_fence_get_timeline_name(struct dma_fence *f)
>   {
>   	struct drm_sched_fence *fence = to_drm_sched_fence(f);
> -	return (const char *)fence->sched->name;
> +
> +	/*
> +	 * Do not dereference fence->sched here: a userspace-held finished
> +	 * fence can outlive a per-context scheduler. Return the name cached
> +	 * in drm_sched_fence_init() instead.
> +	 */
> +	return fence->sched_name;
>   }
>   
>   static void drm_sched_fence_free_rcu(struct rcu_head *rcu)
> @@ -228,6 +234,14 @@ void drm_sched_fence_init(struct drm_sched_fence *fence,
>   	unsigned seq;
>   
>   	fence->sched = container_of(entity->rq, typeof(*fence->sched), rq);
> +	/*
> +	 * Cache the scheduler's timeline name: the finished fence may be
> +	 * exported to userspace and outlive @sched (per-context schedulers
> +	 * are freed on context teardown), so get_timeline_name() must not
> +	 * dereference @sched. Scheduler names are persistent (string
> +	 * literals passed to drm_sched_init()).
> +	 */
> +	fence->sched_name = fence->sched->name;
>   	seq = atomic_inc_return(&entity->fence_seq);
>   	dma_fence_init(&fence->scheduled, &drm_sched_fence_ops_scheduled,
>   		       &fence->lock, entity->fence_context, seq);
> diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
> index d61c19e78182..4f780d70acb6 100644
> --- a/include/drm/gpu_scheduler.h
> +++ b/include/drm/gpu_scheduler.h
> @@ -305,6 +305,17 @@ struct drm_sched_fence {
>            * belongs to.
>            */
>   	struct drm_gpu_scheduler	*sched;
> +	/**
> +	 * @sched_name: the timeline name of @sched, cached at init time.
> +	 *
> +	 * &drm_sched_fence.finished may be exported to userspace (via a
> +	 * sync_file or drm_syncobj) and can outlive @sched: a driver using a
> +	 * per-context scheduler frees it on context teardown while a
> +	 * userspace-held finished fence still references it. The
> +	 * get_timeline_name() callback must therefore not dereference @sched;
> +	 * it returns this cached name instead.
> +	 */
> +	const char			*sched_name;
>           /**
>            * @lock: the lock used by the scheduled and the finished fences.
>            */

