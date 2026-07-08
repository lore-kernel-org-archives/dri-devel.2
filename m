Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C095AC43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 09:21:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DFCB10E59E;
	Wed,  8 Jul 2026 09:21:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="HU6E8f5R";
	dkim-atps=neutral
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com
 [209.85.208.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5587410E59E
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 09:20:59 +0000 (UTC)
Received: by mail-ed1-f44.google.com with SMTP id
 4fb4d7f45d1cf-698bf053053so801042a12.3
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Jul 2026 02:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1783502458; x=1784107258; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=W7NiDQJoKDQdV8YX3g9oeMoz6qFJFZ46J3+eMQIsCQw=;
 b=HU6E8f5RxgSe9eEhcEaViOJPBjzR1a2QVPc3InvU8GizuHyCm/s7Iv8HJwPB5/QlHf
 yvnhi013t/OzkrYFf7gNKA+JLcYjnjwi1oI9oZVUUYSFWFInJnI5TYMLFJTm+3E1awsA
 s0wecKZKUnuni2qjh0cWK9hnzHcNJRXebBhmuSdFDfhDak4ZZAV/jyP7sGeTbZ1fx0T+
 X+qicrmv4qBGDD3X9rZmOWg/aKTH8QfcCTYSi0IWvqG8HX3nPbWH80JhNkBlTlezMvAy
 +6CrrMDCzm+1ijZWthrZEwVGHwM8mGlH085EsDKh/TN4/BkGFKUUfHqJQgUc7ahCDeqC
 jroQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783502458; x=1784107258;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=W7NiDQJoKDQdV8YX3g9oeMoz6qFJFZ46J3+eMQIsCQw=;
 b=g2shvnROrb/mJy+Ef1K6n0N8AYo+YwjYR+MxBtE/J/U0x4VrIrmuQg2QNddQ63tFBy
 pfo9B5BPb13n7ihF3WI5Cqd2ECYpGZ0nKZGn1nBr0fjLsr2QfluNRGs7POWjFJt7obbs
 HeZPbNPvLWQNeL8szNDQfKU6hh2nZT5orVq0h2FKqpPgbq4QN/SuDpgrFxfmljTLo7f6
 C2tb5g/T74sePTelPb3LvP09wdpHs6ymqBjiGRTEjA/Owkt07bKQKnz/16nedgEN8KsO
 Kv2cTwdN+uw95wGBVe9xxt3LsIx92QmjL2l6HFM1XBMf6CLmr2kxgoxJWHZpDYWr0rNe
 YEkA==
X-Gm-Message-State: AOJu0Yw9EM90bwr22Kqfd0q1fM0xV6Jlg+wui99Nyd2e7TXtYQVjpAkD
 ayl2y5c7WZ6CPZlJZGpYmat/dG8UnkjCfbzvSsFDQEnE0Ml4KCGEZOEguLepdRQEQGvLgzJkEHr
 Zc5lPmx4=
X-Gm-Gg: AfdE7cljEIGJfe95FLyaemzYZi1SP07TF/NKDLiHf61cvnrOkR7H3ZFYcLXNdGly5FD
 enahdRpDyB5D9rsenOgg4NDSr704RhyygdplmYDA1K6jWUCs9wwgZkUsJbjgxeYVJudihhznniP
 P0vGwW6vnZNmBlcV6oO1ut39iYAQmMPRAOLDnrzrgUQodn8+T4JLhHVOsqytvNN1yGl0xdJ8J/y
 AGqtpCj7kORiQb7XoZDu2I6J0cwHQhVCds41e1aaM0dyZd+jpaCfZq+MXCTp39s1ocIcCP3sQgp
 s2sRonnOjwnUlr8bbbe14Q6yiiJd0rR+OeTn8ddYC3r6w/WJ9nAMqxpNHmbVk3OJNfCrX+rCskg
 ivgCex8FVrEOoDhDznYvQeNDOVG15kNFqCP7UXkY59y0Np/u6TFnK+zKyOGTB19xrMAk7CCOglX
 4TkWCr5pGMKOCdDPBwOVP0pOn5OvV4BaGgCA==
X-Received: by 2002:a05:6402:388b:b0:68f:cc95:8c10 with SMTP id
 4fb4d7f45d1cf-69ab44a07efmr572815a12.27.1783502457112; 
 Wed, 08 Jul 2026 02:20:57 -0700 (PDT)
Received: from [192.168.0.116] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-69aa613d4e2sm1678874a12.24.2026.07.08.02.20.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jul 2026 02:20:56 -0700 (PDT)
Message-ID: <46ffa75c-83e2-4f4b-9d5b-e43fdfa12176@ursulin.net>
Date: Wed, 8 Jul 2026 10:20:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] drm/sched/tests: Let the DRM scheduler manage job
 lifetimes
To: Marco Pagani <marco.pagani@linux.dev>,
 Matthew Brost <matthew.brost@intel.com>, Danilo Krummrich <dakr@kernel.org>,
 Philipp Stanner <phasta@kernel.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260707114807.154572-1-marco.pagani@linux.dev>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20260707114807.154572-1-marco.pagani@linux.dev>
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


On 07/07/2026 12:48, Marco Pagani wrote:
> Currently, the mock scheduler uses KUnit-managed memory for jobs. This ties
> the job's memory lifetime to the test suite rather than the DRM scheduler's
> callbacks. This does not represent real driver behavior and can lead to
> potential Use-After-Free bugs in the tests.

Since you say use-after-free, that means something belonging to a test 
wasn't properly cleaned up, right? Could you help me out review by 
describing one example?

Idea was that tests are self contained, ie. when a tests exits it is 
guaranteed all resources belonging to it are gone. Everything else 
should be a test bug which IMO means it is fine to crash if a new tests 
gets that wrong. Just idle at the end of the test and everything should 
work.

> Update the mock scheduler to let the lifetime of jobs be managed by the DRM
> scheduler's asynchronous callbacks instead of KUnit managed memory. Add a
> kref reference counter to track the job's lifetime between test suites and
> the scheduler.
> 
> Finally, to avoid memory leaks in the event of an early test abortion,
> register a cleanup KUnit action that automatically puts the reference to
> the job.

So kunit managed memory, freed on test exit, is replaced by kunit 
managed actions, which also free on test exit?

Some random thoughts below while I wait to understand the motivation and 
problem statement better:

> Signed-off-by: Marco Pagani <marco.pagani@linux.dev>
> ---
>   .../gpu/drm/scheduler/tests/mock_scheduler.c  | 68 ++++++++++++++-----
>   drivers/gpu/drm/scheduler/tests/sched_tests.h |  6 ++
>   2 files changed, 57 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/gpu/drm/scheduler/tests/mock_scheduler.c b/drivers/gpu/drm/scheduler/tests/mock_scheduler.c
> index 14403a762335..51f81082f37a 100644
> --- a/drivers/gpu/drm/scheduler/tests/mock_scheduler.c
> +++ b/drivers/gpu/drm/scheduler/tests/mock_scheduler.c
> @@ -96,6 +96,14 @@ drm_mock_sched_job_signal_timer(struct hrtimer *hrtimer)
>   	return HRTIMER_NORESTART;
>   }
>   
> +static void drm_mock_sched_job_cleanup_action(void *ptr)
> +{
> +	struct drm_mock_sched_job *job = ptr;
> +
> +	job->test = NULL;
> +	drm_mock_sched_job_put(job);
> +}
> +
>   /**
>    * drm_mock_sched_job_new - Create a new mock scheduler job
>    *
> @@ -111,23 +119,34 @@ drm_mock_sched_job_new(struct kunit *test,
>   	struct drm_mock_sched_job *job;
>   	int ret;
>   
> -	job = kunit_kzalloc(test, sizeof(*job), GFP_KERNEL);
> +	/* Let the DRM Scheduler manage the lifetime of the job */

However that does not match real driver behaviour either (circling back 
to the justification from the commit message). It is the drivers which 
own this memory, not the DRM scheduler. So in this case mock scheduler, 
which is a kunit test client, etc.

> +	job = kzalloc_obj(*job, GFP_KERNEL);
>   	KUNIT_ASSERT_NOT_NULL(test, job);
>   
> +	kref_init(&job->refcount);
> +	job->test = test;
> +
>   	ret = drm_sched_job_init(&job->base,
>   				 &entity->base,
>   				 1,
>   				 NULL,
>   				 1);
> -	KUNIT_ASSERT_EQ(test, ret, 0);
> -
> -	job->test = test;
> +	if (ret) {
> +		kfree(job);
> +		KUNIT_ASSERT_EQ_MSG(test, ret, 0, "drm_sched_job_init failed");
> +	}
>   
>   	init_completion(&job->done);
>   	INIT_LIST_HEAD(&job->link);
>   	hrtimer_setup(&job->timer, drm_mock_sched_job_signal_timer,
>   		      CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
>   
> +	ret = kunit_add_action(test, drm_mock_sched_job_cleanup_action, job);
> +	if (ret) {
> +		drm_mock_sched_job_put(job);
> +		KUNIT_ASSERT_EQ_MSG(test, ret, 0, "kunit_add_action failed");
> +	}
> +
>   	return job;
>   }
>   
> @@ -152,7 +171,7 @@ static void drm_mock_sched_hw_fence_release(struct dma_fence *fence)
>   
>   	hrtimer_cancel(&job->timer);
>   
> -	/* Containing job is freed by the kunit framework */
> +	drm_mock_sched_job_put(job);
>   }
>   
>   static const struct dma_fence_ops drm_mock_sched_hw_fence_ops = {
> @@ -173,6 +192,8 @@ static struct dma_fence *mock_sched_run_job(struct drm_sched_job *sched_job)
>   		       sched->hw_timeline.context,
>   		       atomic_inc_return(&sched->hw_timeline.next_seqno));
>   
> +	kref_get(&job->refcount);
> +
>   	dma_fence_get(&job->hw_fence); /* Reference for the job_list */
>   
>   	spin_lock_irq(&sched->lock);
> @@ -200,6 +221,17 @@ static struct dma_fence *mock_sched_run_job(struct drm_sched_job *sched_job)
>   	return &job->hw_fence;
>   }
>   
> +static void mock_sched_free_job(struct drm_sched_job *sched_job)
> +{

Free which is actually a reference put is non-obvious API.

> +	struct drm_mock_sched_job *job = drm_sched_job_to_mock_job(sched_job);
> +
> +	/* Only if the fence has been successfully initialized */
> +	if (job->hw_fence.ops)
> +		dma_fence_put(&job->hw_fence);
> +
> +	drm_mock_sched_job_put(job);
> +}
> +
>   /*
>    * Normally, drivers would take appropriate measures in this callback, such as
>    * killing the entity the faulty job is associated with, resetting the hardware
> @@ -232,21 +264,26 @@ mock_sched_timedout_job(struct drm_sched_job *sched_job)
>   	}
>   	spin_unlock_irqrestore(&sched->lock, flags);
>   
> -	dma_fence_put(&job->hw_fence);
> -	drm_sched_job_cleanup(sched_job);
> -	/* Mock job itself is freed by the kunit framework. */
> +	mock_sched_free_job(sched_job);
>   
>   	return DRM_GPU_SCHED_STAT_RESET;
>   }
>   
> -static void mock_sched_free_job(struct drm_sched_job *sched_job)
> +static void drm_mock_sched_job_release(struct kref *ref)
>   {
> -	struct drm_mock_sched_job *job = drm_sched_job_to_mock_job(sched_job);
> +	struct drm_mock_sched_job *job;
> +
> +	job = container_of(ref, struct drm_mock_sched_job, refcount);
>   
> -	dma_fence_put(&job->hw_fence);
> -	drm_sched_job_cleanup(sched_job);
> +	drm_sched_job_cleanup(&job->base);
>   
> -	/* Mock job itself is freed by the kunit framework. */
> +	kfree(job);
> +}
> +
> +void drm_mock_sched_job_put(struct drm_mock_sched_job *job)
> +{
> +	if (job)
> +		kref_put(&job->refcount, drm_mock_sched_job_release);
>   }
>   
>   static void mock_sched_cancel_job(struct drm_sched_job *sched_job)
> @@ -265,10 +302,7 @@ static void mock_sched_cancel_job(struct drm_sched_job *sched_job)
>   	}
>   	spin_unlock_irqrestore(&sched->lock, flags);
>   
> -	/*
> -	 * The GPU Scheduler will call drm_sched_backend_ops.free_job(), still.
> -	 * Mock job itself is freed by the kunit framework.
> -	 */
> +	/* The GPU Scheduler will call drm_sched_backend_ops.free_job() */
>   }
>   
>   static const struct drm_sched_backend_ops drm_mock_scheduler_ops = {
> diff --git a/drivers/gpu/drm/scheduler/tests/sched_tests.h b/drivers/gpu/drm/scheduler/tests/sched_tests.h
> index 553d45abd057..e4d33f0bf935 100644
> --- a/drivers/gpu/drm/scheduler/tests/sched_tests.h
> +++ b/drivers/gpu/drm/scheduler/tests/sched_tests.h
> @@ -13,6 +13,7 @@
>   #include <linux/list.h>
>   #include <linux/mutex.h>
>   #include <linux/types.h>
> +#include <linux/kref.h>
>   
>   #include <drm/gpu_scheduler.h>
>   
> @@ -90,6 +91,7 @@ struct drm_mock_sched_entity {
>    */
>   struct drm_mock_sched_job {
>   	struct drm_sched_job	base;
> +	struct kref		refcount;
>   
>   	struct completion	done;
>   
> @@ -144,6 +146,8 @@ struct drm_mock_sched_job *
>   drm_mock_sched_job_new(struct kunit *test,
>   		       struct drm_mock_sched_entity *entity);
>   
> +void drm_mock_sched_job_put(struct drm_mock_sched_job *job);
> +
>   /**
>    * drm_mock_sched_job_submit - Arm and submit a job in one go
>    *
> @@ -151,6 +155,8 @@ drm_mock_sched_job_new(struct kunit *test,
>    */
>   static inline void drm_mock_sched_job_submit(struct drm_mock_sched_job *job)
>   {
> +	kref_get(&job->refcount);
> +

This feels fragile because if someone writes a test which uses arm+push 
directly bad things will happen. What is this extra reference for versus 
the one obtained by creating a job?

Regards,

Tvrtko

>   	drm_sched_job_arm(&job->base);
>   	drm_sched_entity_push_job(&job->base);
>   }

