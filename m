Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6D7DC43458
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 13:20:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23D4810F8DD;
	Fri, 10 Jul 2026 13:20:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="Bx+lVEWf";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81E8110F8DD
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 13:20:33 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-493c5220cb7so6719435e9.3
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 06:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1783689632; x=1784294432; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=OrnQdgHYX1jQdSLNgqv4eif0HeOC+ShJkpWPBMwNWUo=;
 b=Bx+lVEWfTIRzm0aaMGXuJD1UMqsn0QxXhfes1vuwa5otykO+dQ7vP6ln3AuZwfAVpC
 dy5GxHdXp0Ki7nXAO9nip4A1jDSdcWi3Q6X8YEn0LF2fkOFBK/xJBfOd2Fsf7aSx0umY
 BBL2yjElLJWGF6nzaAXRFYUmJu9Bk5QuYFKiE1Gbz08FEI2oQ9loICm+PFutinl6DTyn
 qT87SuLOtkXs1lREg2JKbESVj4aD9d1evncc45iWfnKL31hCTDrLrDRkfarwAlfTmNQz
 r7yRQaGrfKCoamG0bEmxPvKvHjQAPUbGx04wpDTYL3sTQURFBSahijEOYtzPmvINYL7b
 QE2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783689632; x=1784294432;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OrnQdgHYX1jQdSLNgqv4eif0HeOC+ShJkpWPBMwNWUo=;
 b=eb4ch+QkT8wEKM55r2izSS78cnQcFlw3Oy5fakcRCjl6x03eZBvoGmxIhtDdGWUOGm
 jcfUr45wKdlkbTjqErDjjDGx5kISdi10BxhzwXAKn8Qh/NrhVfjviJbaf5DES8pkyyKl
 ghyfMACxfV3IQYr+AoIK2eBDtgfM/IW+AgY1o6N/6QIU4ZVMchLo/4oL784PPMrAIfAM
 zPaj5DC9bTk+vRweei1ZI+8mToUnaJw38WACjIqinPlQ8sz9GTC/SZYHlr6rHX8olXg3
 Kclh3fI2rzZRpmqUQDo1HocjMNE7Tgq6AbSMV+qdNHCQQKweLwhKi/phF0lf0RDbWJS5
 YSzg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqo9iYjZtfnMiP+6kClbCsCwShgjnQ30VUQvg/CqS88PrvF3Al6P2uyVol77vAPhQMjQIdzY6P8+MY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxUdJgkKx2XZRiUV2SjHjvJoLnsgk79oGfnGpHNwytPgaiW9EGs
 RCZEuZ4l6X0aentMycR1OsXrm3Q2g1Nl3aLptHoqVi8rN/I/AFEOI+9sIQho+xCyduy/MYUYdPk
 VgYN9nK0=
X-Gm-Gg: AfdE7cl/XYw4ehxByxEh9MFq+6SqVx8Duqv3JwdbNOiZ3kSXXGPrB6Kb9Usx0/IuFob
 wMArRc/vR+ing+LeFI4Yn2uvNMkj67gdnlilwdwjPOKb2qnyzggadVTeJ0abzAE8yPJ8TOOa6jx
 HL1YxUo3e7o7ASBYu3fxiSOalttyOGBEiMG/YkqMafhauUu/OKI70RI8gaBxHNqICKVKEuRtq4N
 5FSvdSrDhZytQbpxujoc6jCdYfrcdbGAT1Vu7CnsDX8wQVBAJ6yU9bU19gRIkKw9bjygVpip/E2
 3G0ORdA7WDDhvtQ18KBU3y0CfwK4pIem0FpoGprQsH1E+aAcAShVOFgcD1hL+3CwRxJKmaPdE8v
 POO82qN//3IaMf19M38UtfGN9mQUtlak2DLISzjnBSXG5OZmRsur/Tfy6kRRQR9Fx0dq/8RKmvO
 kgJobGH1gTcYbu6q/16Q9Pr1ZWRKqrRJWnkQ==
X-Received: by 2002:a05:600c:628b:b0:493:e947:b24a with SMTP id
 5b1f17b1804b1-493e947b27fmr92954715e9.14.1783689631346; 
 Fri, 10 Jul 2026 06:20:31 -0700 (PDT)
Received: from [192.168.0.116] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493eb6df417sm145120185e9.8.2026.07.10.06.20.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jul 2026 06:20:30 -0700 (PDT)
Message-ID: <f524ee2d-c15f-4b7f-ae42-2c28b06e58b6@ursulin.net>
Date: Fri, 10 Jul 2026 14:20:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] drm/sched/tests: Let the DRM scheduler manage job
 lifetimes
To: Marco Pagani <marco.pagani@linux.dev>
Cc: Matthew Brost <matthew.brost@intel.com>,
 Danilo Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260707114807.154572-1-marco.pagani@linux.dev>
 <46ffa75c-83e2-4f4b-9d5b-e43fdfa12176@ursulin.net>
 <f36c7c87-38c5-41f9-bd14-efc9918a4b61@linux.dev>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <f36c7c87-38c5-41f9-bd14-efc9918a4b61@linux.dev>
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


On 09/07/2026 22:53, Marco Pagani wrote:
> On 08/07/2026 11:20, Tvrtko Ursulin wrote:
>>
>> On 07/07/2026 12:48, Marco Pagani wrote:
>>> Currently, the mock scheduler uses KUnit-managed memory for jobs. This ties
>>> the job's memory lifetime to the test suite rather than the DRM scheduler's
>>> callbacks. This does not represent real driver behavior and can lead to
>>> potential Use-After-Free bugs in the tests.
>>
>> Since you say use-after-free, that means something belonging to a test
>> wasn't properly cleaned up, right? Could you help me out review by
>> describing one example?
> 
> Sure, I experienced a UAF myself while writing the sched_parallel test
> suite (v3->v4). The UAF happened in v3 because of a reference that the
> scheduler backend keeps to the fence of the last scheduled job (in
> drm_sched_run_job_work()->drm_sched_entity_pop_job()). If the job is
> released before its entity, the pointer becomes dangling.
> 
> On a NR_CPUS > 20 system, this caused a UAF during the teardown phase
> because jobs were freed before their entities by the KUnit actions
> implicitly registered by drm_mock_sched_job_new() when allocating the
> memory. To solve this in v4, I had to move KUnit release action for the
> entities to ensure that entities are freed before jobs.

Why wouldn't it work to idle the entities and the scheduler before the 
test exits? There is even kunit_suite.exit which some other tests use.

> I also have another UAF reported by our internal CI that I haven't yet
> fully investigated in drm_sched_basic:
> 
> KUNIT: drm_sched: BUG: KASAN: null-ptr-deref in drm_sched_basic_test+0x3b4/0x7c0 [drm_sched_tests]

This one is interesting. Is it maybe the dep_chain case? Perhaps prev 
fence reference needs to be taken before submit and carrier over to next 
iteration.

>> Idea was that tests are self contained, ie. when a tests exits it is
>> guaranteed all resources belonging to it are gone. Everything else
>> should be a test bug which IMO means it is fine to crash if a new tests
>> gets that wrong. Just idle at the end of the test and everything should
>> work.
> 
> I fully agree that test should be self-contained. However, my point is
> that KUnit infrastructure should serve as a sandbox to avoid leaking
> resources and not force or perturb the lifetime of test items (jobs in
> this case) within the boundaries of the test.
> 
> I think the problem with the current design of the mock scheduler is
> that drm_mock_sched_job_new() implicitly registers a cleanup action to
> free the job's memory independently of the job's state. Even more subtly,
> this approach implicitly defines a LIFO teardown order depending on when
> drm_mock_sched_job_new() is called in the test.
> 
> This may confuse test developers who might be unaware of this behavior,
> as they are likely to assume that the lifetime of the job will be always
> guaranteed during the entire test, as I've experienced myself.

Are you saying the unexpected thing is that job can be safely 
dereferenced for the duration of the test? Or that it cannot? Latter 
would be a bug somewhere AFAICT.

>>> Update the mock scheduler to let the lifetime of jobs be managed by the DRM
>>> scheduler's asynchronous callbacks instead of KUnit managed memory. Add a
>>> kref reference counter to track the job's lifetime between test suites and
>>> the scheduler.
>>>
>>> Finally, to avoid memory leaks in the event of an early test abortion,
>>> register a cleanup KUnit action that automatically puts the reference to
>>> the job.
>>
>> So kunit managed memory, freed on test exit, is replaced by kunit
>> managed actions, which also free on test exit?
> 
> The idea is to use KUnit actions to guarantee tests against resource
> leaks by dropping a reference, and let the same callback used by the
> scheduler to free the memory, instead of abruptly free the memory from
> right under the scheduler's nose.

I first want to understand exactly what the issue is. The current design 
exactly cannot free the memory under the scheduler nose unless there is 
a test bug where test exited and has left the scheduler with unprocessed 
jobs. I am not saying we cannot have reference counted jobs but, again, 
at the moment I don't understand the problem.

Regards,

Tvrtko

>> Some random thoughts below while I wait to understand the motivation and
>> problem statement better:
>>
>>> Signed-off-by: Marco Pagani <marco.pagani@linux.dev>
>>> ---
>>>    .../gpu/drm/scheduler/tests/mock_scheduler.c  | 68 ++++++++++++++-----
>>>    drivers/gpu/drm/scheduler/tests/sched_tests.h |  6 ++
>>>    2 files changed, 57 insertions(+), 17 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/scheduler/tests/mock_scheduler.c b/drivers/gpu/drm/scheduler/tests/mock_scheduler.c
>>> index 14403a762335..51f81082f37a 100644
>>> --- a/drivers/gpu/drm/scheduler/tests/mock_scheduler.c
>>> +++ b/drivers/gpu/drm/scheduler/tests/mock_scheduler.c
>>> @@ -96,6 +96,14 @@ drm_mock_sched_job_signal_timer(struct hrtimer *hrtimer)
>>>    	return HRTIMER_NORESTART;
>>>    }
>>>    
>>> +static void drm_mock_sched_job_cleanup_action(void *ptr)
>>> +{
>>> +	struct drm_mock_sched_job *job = ptr;
>>> +
>>> +	job->test = NULL;
>>> +	drm_mock_sched_job_put(job);
>>> +}
>>> +
>>>    /**
>>>     * drm_mock_sched_job_new - Create a new mock scheduler job
>>>     *
>>> @@ -111,23 +119,34 @@ drm_mock_sched_job_new(struct kunit *test,
>>>    	struct drm_mock_sched_job *job;
>>>    	int ret;
>>>    
>>> -	job = kunit_kzalloc(test, sizeof(*job), GFP_KERNEL);
>>> +	/* Let the DRM Scheduler manage the lifetime of the job */
>>
>> However that does not match real driver behaviour either (circling back
>> to the justification from the commit message). It is the drivers which
>> own this memory, not the DRM scheduler. So in this case mock scheduler,
>> which is a kunit test client, etc.
> 
> I'm not entirely following on this. Sure, it is the driver that
> allocates and owns the job's memory, but it is the the scheduler backend
> that manage the job's lifecycle and decides when a it is finished and
> the underlying memory can be freed. To be more precise, I think it is
> fair to say that when a job is submitted, the ownership is transferred
> from the driver the to scheduler backend until the job is finished.
> 
> 
>>> +	job = kzalloc_obj(*job, GFP_KERNEL);
>>>    	KUNIT_ASSERT_NOT_NULL(test, job);
>>>    
>>> +	kref_init(&job->refcount);
>>> +	job->test = test;
>>> +
>>>    	ret = drm_sched_job_init(&job->base,
>>>    				 &entity->base,
>>>    				 1,
>>>    				 NULL,
>>>    				 1);
>>> -	KUNIT_ASSERT_EQ(test, ret, 0);
>>> -
>>> -	job->test = test;
>>> +	if (ret) {
>>> +		kfree(job);
>>> +		KUNIT_ASSERT_EQ_MSG(test, ret, 0, "drm_sched_job_init failed");
>>> +	}
>>>    
>>>    	init_completion(&job->done);
>>>    	INIT_LIST_HEAD(&job->link);
>>>    	hrtimer_setup(&job->timer, drm_mock_sched_job_signal_timer,
>>>    		      CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
>>>    
>>> +	ret = kunit_add_action(test, drm_mock_sched_job_cleanup_action, job);
>>> +	if (ret) {
>>> +		drm_mock_sched_job_put(job);
>>> +		KUNIT_ASSERT_EQ_MSG(test, ret, 0, "kunit_add_action failed");
>>> +	}
>>> +
>>>    	return job;
>>>    }
>>>    
>>> @@ -152,7 +171,7 @@ static void drm_mock_sched_hw_fence_release(struct dma_fence *fence)
>>>    
>>>    	hrtimer_cancel(&job->timer);
>>>    
>>> -	/* Containing job is freed by the kunit framework */
>>> +	drm_mock_sched_job_put(job);
>>>    }
>>>    
>>>    static const struct dma_fence_ops drm_mock_sched_hw_fence_ops = {
>>> @@ -173,6 +192,8 @@ static struct dma_fence *mock_sched_run_job(struct drm_sched_job *sched_job)
>>>    		       sched->hw_timeline.context,
>>>    		       atomic_inc_return(&sched->hw_timeline.next_seqno));
>>>    
>>> +	kref_get(&job->refcount);
>>> +
>>>    	dma_fence_get(&job->hw_fence); /* Reference for the job_list */
>>>    
>>>    	spin_lock_irq(&sched->lock);
>>> @@ -200,6 +221,17 @@ static struct dma_fence *mock_sched_run_job(struct drm_sched_job *sched_job)
>>>    	return &job->hw_fence;
>>>    }
>>>    
>>> +static void mock_sched_free_job(struct drm_sched_job *sched_job)
>>> +{
>>
>> Free which is actually a reference put is non-obvious API.
> 
> Uhm, this is not an API but the implementation of the .free_job method
> of drm_mock_scheduler_ops. I've kept the function name since it matches
> the name of backend op.
> 
> 
>>> +	struct drm_mock_sched_job *job = drm_sched_job_to_mock_job(sched_job);
>>> +
>>> +	/* Only if the fence has been successfully initialized */
>>> +	if (job->hw_fence.ops)
>>> +		dma_fence_put(&job->hw_fence);
>>> +
>>> +	drm_mock_sched_job_put(job);
>>> +}
>>> +
>>>    /*
>>>     * Normally, drivers would take appropriate measures in this callback, such as
>>>     * killing the entity the faulty job is associated with, resetting the hardware
>>> @@ -232,21 +264,26 @@ mock_sched_timedout_job(struct drm_sched_job *sched_job)
>>>    	}
>>>    	spin_unlock_irqrestore(&sched->lock, flags);
>>>    
>>> -	dma_fence_put(&job->hw_fence);
>>> -	drm_sched_job_cleanup(sched_job);
>>> -	/* Mock job itself is freed by the kunit framework. */
>>> +	mock_sched_free_job(sched_job);
>>>    
>>>    	return DRM_GPU_SCHED_STAT_RESET;
>>>    }
>>>    
>>> -static void mock_sched_free_job(struct drm_sched_job *sched_job)
>>> +static void drm_mock_sched_job_release(struct kref *ref)
>>>    {
>>> -	struct drm_mock_sched_job *job = drm_sched_job_to_mock_job(sched_job);
>>> +	struct drm_mock_sched_job *job;
>>> +
>>> +	job = container_of(ref, struct drm_mock_sched_job, refcount);
>>>    
>>> -	dma_fence_put(&job->hw_fence);
>>> -	drm_sched_job_cleanup(sched_job);
>>> +	drm_sched_job_cleanup(&job->base);
>>>    
>>> -	/* Mock job itself is freed by the kunit framework. */
>>> +	kfree(job);
>>> +}
>>> +
>>> +void drm_mock_sched_job_put(struct drm_mock_sched_job *job)
>>> +{
>>> +	if (job)
>>> +		kref_put(&job->refcount, drm_mock_sched_job_release);
>>>    }
>>>    
>>>    static void mock_sched_cancel_job(struct drm_sched_job *sched_job)
>>> @@ -265,10 +302,7 @@ static void mock_sched_cancel_job(struct drm_sched_job *sched_job)
>>>    	}
>>>    	spin_unlock_irqrestore(&sched->lock, flags);
>>>    
>>> -	/*
>>> -	 * The GPU Scheduler will call drm_sched_backend_ops.free_job(), still.
>>> -	 * Mock job itself is freed by the kunit framework.
>>> -	 */
>>> +	/* The GPU Scheduler will call drm_sched_backend_ops.free_job() */
>>>    }
>>>    
>>>    static const struct drm_sched_backend_ops drm_mock_scheduler_ops = {
>>> diff --git a/drivers/gpu/drm/scheduler/tests/sched_tests.h b/drivers/gpu/drm/scheduler/tests/sched_tests.h
>>> index 553d45abd057..e4d33f0bf935 100644
>>> --- a/drivers/gpu/drm/scheduler/tests/sched_tests.h
>>> +++ b/drivers/gpu/drm/scheduler/tests/sched_tests.h
>>> @@ -13,6 +13,7 @@
>>>    #include <linux/list.h>
>>>    #include <linux/mutex.h>
>>>    #include <linux/types.h>
>>> +#include <linux/kref.h>
>>>    
>>>    #include <drm/gpu_scheduler.h>
>>>    
>>> @@ -90,6 +91,7 @@ struct drm_mock_sched_entity {
>>>     */
>>>    struct drm_mock_sched_job {
>>>    	struct drm_sched_job	base;
>>> +	struct kref		refcount;
>>>    
>>>    	struct completion	done;
>>>    
>>> @@ -144,6 +146,8 @@ struct drm_mock_sched_job *
>>>    drm_mock_sched_job_new(struct kunit *test,
>>>    		       struct drm_mock_sched_entity *entity);
>>>    
>>> +void drm_mock_sched_job_put(struct drm_mock_sched_job *job);
>>> +
>>>    /**
>>>     * drm_mock_sched_job_submit - Arm and submit a job in one go
>>>     *
>>> @@ -151,6 +155,8 @@ drm_mock_sched_job_new(struct kunit *test,
>>>     */
>>>    static inline void drm_mock_sched_job_submit(struct drm_mock_sched_job *job)
>>>    {
>>> +	kref_get(&job->refcount);
>>> +
>>
>> This feels fragile because if someone writes a test which uses arm+push
>> directly bad things will happen. What is this extra reference for versus
>> the one obtained by creating a job?
> 
> Fair point. I've consider taking the reference also before run in
> mock_sched_run_job() or directly in drm_mock_sched_job_new(), but both
> approaches felt suboptimal. I have to think about this. I'll come up
> with a better approach for v2.
> 
> 
>> Regards,
>>
>> Tvrtko
>>
>>>    	drm_sched_job_arm(&job->base);
>>>    	drm_sched_entity_push_job(&job->base);
>>>    }
>>
> 
> Thanks,
> Marco

