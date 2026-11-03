Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE21606A32C
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 13:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f3lLYdjT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F119310E4D6;
	Tue,  3 Nov 2026 13:26:57 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DEBF10E4D6
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 13:26:52 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4a2072b9832so4337825e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 05:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793712410; x=1794317210; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=L77FF2aWzZ913b54dk9ZT61wHg8HgCGCsNMqmepmddI=;
 b=f3lLYdjTKhABvK34ZhYFymIDC2v5h0i/9al863ZL+6xDOyhr4FxHSaHIkU+llRVanm
 rz3mW+7Euh/Thb/QS1m3FRflBTaajzdPmNPxqpnlAoW1ny+67R4/jkAMbWLELu5gAH2T
 exusoIoPkEaOAwkjJQjKz1uqR8XmkM/3YjCKNrLYXuwyoxoIXn/d3BJ7xBEd565nnWoP
 65k0VjppyGg/Iuvk1lR+Wpn9NovLk1TIwc6Mkx+omRvvVjCel1PHnQy7o3UoLcQsDfXZ
 g4bI/ub+/DuRegenfRunq7RVA6y1CJXZqkzZnQgKQsrliG1GfLquFYKLoOiYDU8V2RuL
 Y7gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793712410; x=1794317210;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=L77FF2aWzZ913b54dk9ZT61wHg8HgCGCsNMqmepmddI=;
 b=PH6edKi8Yr30qROboQnYMxZ9rvcdZkuEqnyU+a4apWtEKmXBkRO5eqZ8WqRGzvnRke
 A+B+UGrKHkDidcnZg/FL/xhG0/JGpMnuO7SP7YZ2p7Cow+GVHdb5qEdn8L0NTRworVa3
 H7d6P4bwAVa2Cmi0015Tj4bOrMyFRFg6YwY27Ncd8iwHxInbGGQ3k7m0/VLUO/pcyVKd
 ob8MtD6Y4mA6p1cFbxsm3DOSdimGD+lASg3v+s9nPfE7NcUDeZcOzbStfhxSwGpxiAay
 JdqBwGGxAQFK9QXtPRAVyoTouJGJr7lOjdX30VT9BqKaEzuettiWIvZdPhJLgSmpSY38
 laLA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwW/bGImG1x9efE1A1EjADHRpkzUKc0dSLJKqHxXVmpvSAZ/UlZOJzdqLOJZZelJAWKzTg3MseSCk4=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/GcuYYReUnH0cRu93eCQsN3j6JfeqC92JUzC28sH9wY2M/rKJt
 9CIhOwAr3lnGH2awwbNabPmuwk56kq8WgSQjk8SxR6keWNmr8BS7/z4=
X-Gm-Gg: AYBFou3D8aRuDk1Nt4N98VE0MHsPPfSfXybJF++OZakuaZu2/HaMXqJon4oDlPq3nT/
 cAeisj2lqWz1hPtI4VBVvyBKKlqkYK6tERNHfMHemuMfBMumyN+LQw75e0N0T84/OmzsYaV2Ux/
 fpOaFbig6VDbtdrUQOj1bpZJBvbJdOLkmxpFqaKnMyV3ldUKw2xXGURyWsenS+/mjrhoxzTEmu5
 kiS7nMwypAcncr0IDaDl1I3fRzw5D6iAAkypnWkfaBYhAQ4nsdebWbKb/UewJ+F5B/IlAK0+8jy
 G/M2o14+JvGkBBVXrzCGtBvMJllFw4kEU192uGbYy6kf3kKAQ1VKVwNNX2U56Hu1C3bHIc5R4Sr
 FFgD+UWScaPKenPSURLrIxVXUAaIZvAfw2ypfwTcc0D2YVJhz8pn+HJOgkSOn0VdBCWMWJ7r3td
 JfAPeKgaIsGi/9W9849ajCCekXCkwBv9YfTDz1PzmWtrajg6HbxqFIc6bpeOy3N6mjkYiVlk+Th
 mV9e0tSVd/JFjlHC6J+C9+YoQ8Q53xsH/HrZIIJnYGnD/EMWpPZTSi04TEHRiqqWMX1X9XDARtv
 3wMVJcC0BOE6i/vMfCPNwHQjY8Qv+qaFhv9MZxk3gTl7IATj6lUXKiBCtDAMxB6dA8DSXNcY3Z0
 lU/L9FYMt
X-Received: by 2002:a05:600c:37c8:b0:4a2:18c4:61a5 with SMTP id
 5b1f17b1804b1-4ac16acd93cmr305983945e9.6.1793712410096; 
 Tue, 03 Nov 2026 05:26:50 -0800 (PST)
Received: from ?IPV6:2001:b07:2ec:601d:4b26:1672:75c7:805a?
 ([2001:b07:2ec:601d:4b26:1672:75c7:805a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2a879f401sm54532585e9.5.2026.11.03.05.26.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2026 05:26:49 -0800 (PST)
Message-ID: <364b570f-e433-4e9f-8d69-d87f057a7b9d@gmail.com>
Date: Tue, 3 Nov 2026 14:26:47 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] drm/msm: Rework IFPC disable
To: Rob Clark <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 open list <linux-kernel@vger.kernel.org>
References: <20261102190010.720443-1-robin.clark@oss.qualcomm.com>
 <20261102190010.720443-2-robin.clark@oss.qualcomm.com>
Content-Language: en-US
From: Anna Maniscalco <anna.maniscalco2000@gmail.com>
In-Reply-To: <20261102190010.720443-2-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/2/26 8:00 PM, Rob Clark wrote:
> Previously this was coupled to SYSPROF level, which made sense at the
> time.  But there are other places that we need to inhibit IFPC.  So
> decouple it from the sysprof refcount.
>
> Now it has it's own refcount, so multiple threads can vote to inhibit
> IFPC safely.  The renamed gpu->ifpc_update() simply applies the new
> state by setting or clearing an OOB request.
>
> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> ---
>   drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 32 +++++++++++++++------------
>   drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 12 ++++------
>   drivers/gpu/drm/msm/adreno/a6xx_gpu.h |  3 ++-
>   drivers/gpu/drm/msm/adreno/a8xx_gpu.c |  6 +----
>   drivers/gpu/drm/msm/msm_gpu.c         |  1 +
>   drivers/gpu/drm/msm/msm_gpu.h         | 26 ++++++++++++++++++----
>   drivers/gpu/drm/msm/msm_perfcntr.c    |  6 ++---
>   drivers/gpu/drm/msm/msm_submitqueue.c | 10 +++++----
>   8 files changed, 56 insertions(+), 40 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> index 662f09bec9d5..bba5468db42e 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> @@ -2128,29 +2128,33 @@ static int a6xx_gmu_get_irq(struct a6xx_gmu *gmu, struct platform_device *pdev,
>   	return irq;
>   }
>   
> -void a6xx_gmu_sysprof_setup(struct msm_gpu *gpu, bool force_on)
> +void a6xx_gmu_ifpc_update_locked(struct msm_gpu *gpu)
>   {
> -	bool sysprof = msm_gpu_sysprof_no_ifpc(gpu) || force_on;
>   	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
>   	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
>   	struct a6xx_gmu *gmu = &a6xx_gpu->gmu;
> +	bool force_on = refcount_read(&gpu->ifpc_disable) > 1;
>   
> -	/* Nothing to do if GPU is suspended. We will handle this during GMU resume */
> -	if (!pm_runtime_get_if_active(&gpu->pdev->dev))
> -		return;
> -
> -	mutex_lock(&gmu->lock);
> +	WARN_ON_ONCE(!mutex_is_locked(&gmu->lock));
>   
> -	/*
> -	 * 'Perfcounter select' register values are lost during IFPC collapse. To avoid that,
> -	 * use the currently unused perfcounter oob vote to block IFPC when sysprof is active
> -	 */
> -	if (sysprof && !test_and_set_bit(GMU_STATUS_OOB_PERF_SET, &gmu->status))
> +	if (force_on && !test_and_set_bit(GMU_STATUS_OOB_PERF_SET, &gmu->status))
>   		a6xx_gmu_set_oob(gmu, GMU_OOB_PERFCOUNTER_SET);
> -	else if (!sysprof && test_and_clear_bit(GMU_STATUS_OOB_PERF_SET, &gmu->status))
> +	else if (!force_on && test_and_clear_bit(GMU_STATUS_OOB_PERF_SET, &gmu->status))
>   		a6xx_gmu_clear_oob(gmu, GMU_OOB_PERFCOUNTER_SET);
> +}
>   
> -	mutex_unlock(&gmu->lock);
> +void a6xx_gmu_ifpc_update(struct msm_gpu *gpu)
> +{
> +	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
> +	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
> +	struct a6xx_gmu *gmu = &a6xx_gpu->gmu;
> +
> +	/* Nothing to do if GPU is suspended. We will handle this during GMU resume */
> +	if (pm_runtime_get_if_active(&gpu->pdev->dev) <= 0)
> +		return;
> +
> +	scoped_guard (mutex, &gmu->lock)
> +		a6xx_gmu_ifpc_update_locked(gpu);
>   
>   	pm_runtime_put(&gpu->pdev->dev);
>   }
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> index 09d76cdf059f..bf71129e33a9 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -1565,11 +1565,7 @@ static int hw_init(struct msm_gpu *gpu)
>   		a6xx_gmu_clear_oob(&a6xx_gpu->gmu, GMU_OOB_BOOT_SLUMBER);
>   	}
>   
> -	if (!ret && msm_gpu_sysprof_no_ifpc(gpu)) {
> -		ret = a6xx_gmu_set_oob(gmu, GMU_OOB_PERFCOUNTER_SET);
> -		if (!ret)
> -			set_bit(GMU_STATUS_OOB_PERF_SET, &gmu->status);
> -	}
> +	a6xx_gmu_ifpc_update_locked(gpu);
>   
>   	return ret;
>   }
> @@ -2851,7 +2847,7 @@ const struct adreno_gpu_funcs a6xx_gpu_funcs = {
>   		.create_private_vm = a6xx_create_private_vm,
>   		.get_rptr = a6xx_get_rptr,
>   		.progress = a6xx_progress,
> -		.sysprof_setup = a6xx_gmu_sysprof_setup,
> +		.ifpc_update = a6xx_gmu_ifpc_update,
>   		.perfcntr_configure = a6xx_perfcntr_configure,
>   	},
>   	.init = a6xx_gpu_init,
> @@ -2922,7 +2918,7 @@ const struct adreno_gpu_funcs a7xx_gpu_funcs = {
>   		.create_private_vm = a6xx_create_private_vm,
>   		.get_rptr = a6xx_get_rptr,
>   		.progress = a6xx_progress,
> -		.sysprof_setup = a6xx_gmu_sysprof_setup,
> +		.ifpc_update = a6xx_gmu_ifpc_update,
>   		.perfcntr_configure = a6xx_perfcntr_configure,
>   	},
>   	.init = a6xx_gpu_init,
> @@ -2953,7 +2949,7 @@ const struct adreno_gpu_funcs a8xx_gpu_funcs = {
>   		.create_private_vm = a6xx_create_private_vm,
>   		.get_rptr = a6xx_get_rptr,
>   		.progress = a8xx_progress,
> -		.sysprof_setup = a6xx_gmu_sysprof_setup,
> +		.ifpc_update = a6xx_gmu_ifpc_update,
>   		.perfcntr_configure = a6xx_perfcntr_configure,
>   		.perfcntr_flush = a8xx_perfcntr_flush,
>   	},
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
> index 81d21acccea1..cb0ac27dacba 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
> @@ -298,7 +298,8 @@ void a6xx_gmu_clear_oob(struct a6xx_gmu *gmu, enum a6xx_gmu_oob_state state);
>   int a6xx_gmu_init(struct a6xx_gpu *a6xx_gpu, struct device_node *node);
>   int a6xx_gmu_wrapper_init(struct a6xx_gpu *a6xx_gpu, struct device_node *node);
>   void a6xx_gmu_remove(struct a6xx_gpu *a6xx_gpu);
> -void a6xx_gmu_sysprof_setup(struct msm_gpu *gpu, bool force_on);
> +void a6xx_gmu_ifpc_update_locked(struct msm_gpu *gpu);
> +void a6xx_gmu_ifpc_update(struct msm_gpu *gpu);
>   
>   void a6xx_preempt_init(struct msm_gpu *gpu);
>   void a6xx_preempt_hw_init(struct msm_gpu *gpu);
> diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
> index e7d04c865968..ecf15a8f68de 100644
> --- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
> @@ -846,11 +846,7 @@ static int hw_init(struct msm_gpu *gpu)
>   	 */
>   	a6xx_gmu_clear_oob(&a6xx_gpu->gmu, GMU_OOB_GPU_SET);
>   
> -	if (!ret && msm_gpu_sysprof_no_perfcntr_zap(gpu)) {
> -		ret = a6xx_gmu_set_oob(gmu, GMU_OOB_PERFCOUNTER_SET);
> -		if (!ret)
> -			set_bit(GMU_STATUS_OOB_PERF_SET, &gmu->status);
> -	}
> +	a6xx_gmu_ifpc_update_locked(gpu);
>   
>   	return ret;
>   }
> diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
> index fb07803f5aba..37f9e93daa43 100644
> --- a/drivers/gpu/drm/msm/msm_gpu.c
> +++ b/drivers/gpu/drm/msm/msm_gpu.c
> @@ -1012,6 +1012,7 @@ int msm_gpu_init(struct drm_device *drm, struct platform_device *pdev,
>   	gpu->nr_rings = nr_rings;
>   
>   	refcount_set(&gpu->sysprof_active, 1);
> +	refcount_set(&gpu->ifpc_disable, 1);
>   
>   	mutex_init(&gpu->perfcntr_lock);
>   
> diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
> index d27d54bdb7a7..0334a0f604ac 100644
> --- a/drivers/gpu/drm/msm/msm_gpu.h
> +++ b/drivers/gpu/drm/msm/msm_gpu.h
> @@ -93,7 +93,7 @@ struct msm_gpu_funcs {
>   	 * for cmdstream that is buffered in this FIFO upstream of the CP fw.
>   	 */
>   	bool (*progress)(struct msm_gpu *gpu, struct msm_ringbuffer *ring);
> -	void (*sysprof_setup)(struct msm_gpu *gpu, bool force_on);
> +	void (*ifpc_update)(struct msm_gpu *gpu);
>   
>   	/* Configure perfcntr SELect regs: */
>   	void (*perfcntr_configure)(struct msm_gpu *gpu, struct msm_ringbuffer *ring,
> @@ -186,6 +186,14 @@ struct msm_gpu {
>   	 */
>   	refcount_t sysprof_active;
>   
> +	/**
> +	 * ifpc_disable:
> +	 *
> +	 * Count of votes to disable IFPC (1-based, values above 1 mean IFPC
> +	 * is disabled).
> +	 */
> +	refcount_t ifpc_disable;
> +
>   	/**
>   	 * lock:
>   	 *
> @@ -375,10 +383,20 @@ msm_gpu_sysprof_no_perfcntr_zap(struct msm_gpu *gpu)
>   		(gpu->perfcntrs && READ_ONCE(gpu->perfcntrs->stream));
>   }
>   
> -static inline bool
> -msm_gpu_sysprof_no_ifpc(struct msm_gpu *gpu)
> +static inline void
> +msm_gpu_disable_ifpc_get(struct msm_gpu *gpu)
> +{
> +	refcount_inc(&gpu->ifpc_disable);
> +	if (gpu->funcs->ifpc_update)
> +		gpu->funcs->ifpc_update(gpu);
> +}
> +
> +static inline void
> +msm_gpu_disable_ifpc_put(struct msm_gpu *gpu)
>   {
> -	return refcount_read(&gpu->sysprof_active) > 1;
> +	refcount_dec(&gpu->ifpc_disable);
> +	if (gpu->funcs->ifpc_update)
> +		gpu->funcs->ifpc_update(gpu);
>   }
>   
>   /*
> diff --git a/drivers/gpu/drm/msm/msm_perfcntr.c b/drivers/gpu/drm/msm/msm_perfcntr.c
> index ce65b1160955..867dd476ed88 100644
> --- a/drivers/gpu/drm/msm/msm_perfcntr.c
> +++ b/drivers/gpu/drm/msm/msm_perfcntr.c
> @@ -259,8 +259,7 @@ sample_worker(struct kthread_work *work)
>   	}
>   
>   	/* Inhibit IFPC while accessing registers: */
> -	if (gpu->funcs->sysprof_setup)
> -		gpu->funcs->sysprof_setup(gpu, true);
> +	msm_gpu_disable_ifpc_get(gpu);
>   
>   	if (gpu->funcs->perfcntr_flush)
>   		gpu->funcs->perfcntr_flush(gpu);
> @@ -297,8 +296,7 @@ sample_worker(struct kthread_work *work)
>   	}
>   
>   	/* Re-enable IFPC: */
> -	if (gpu->funcs->sysprof_setup)
> -		gpu->funcs->sysprof_setup(gpu, false);
> +	msm_gpu_disable_ifpc_put(gpu);
>   
>   	smp_store_release(&stream->fifo.head, head);
>   	wake_up_all(&stream->poll_wq);
> diff --git a/drivers/gpu/drm/msm/msm_submitqueue.c b/drivers/gpu/drm/msm/msm_submitqueue.c
> index d307cdd17d90..8434a09319bc 100644
> --- a/drivers/gpu/drm/msm/msm_submitqueue.c
> +++ b/drivers/gpu/drm/msm/msm_submitqueue.c
> @@ -24,7 +24,10 @@ int msm_context_set_sysprof(struct msm_context *ctx, struct msm_gpu *gpu, int sy
>   		pm_runtime_get_sync(&gpu->pdev->dev);
>   		fallthrough;
>   	case 1:
> +		/* Disable zapping perfcntrs on context switch: */
>   		refcount_inc(&gpu->sysprof_active);
> +		/* Disable IFPC: */
> +		msm_gpu_disable_ifpc_get(gpu);
>   		fallthrough;
>   	case 0:
>   		break;
> @@ -36,16 +39,15 @@ int msm_context_set_sysprof(struct msm_context *ctx, struct msm_gpu *gpu, int sy
>   		pm_runtime_put_autosuspend(&gpu->pdev->dev);
>   		fallthrough;
>   	case 1:
> +		/* Drop our vote for inhibiting IFPC: */
> +		msm_gpu_disable_ifpc_put(gpu);
> +		/* Drop our vote for disabling perfcntr zapping: */
>   		refcount_dec(&gpu->sysprof_active);
>   		fallthrough;
>   	case 0:
>   		break;
>   	}
>   
> -	/* Some gpu families require additional setup for sysprof */
> -	if (gpu->funcs->sysprof_setup)
> -		gpu->funcs->sysprof_setup(gpu, false);
> -
>   	ctx->sysprof = sysprof;
>   
>   	return 0;

Thanks this will help with my hangcheck series.

Reviewed-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>

Best regards,
-- 
Anna Maniscalco <anna.maniscalco2000@gmail.com>

