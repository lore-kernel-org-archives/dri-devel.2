Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE065C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 11:27:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9825F10F7B8;
	Fri,  3 Jul 2026 11:27:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="Tu0HGkFa";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96EB110E5D8
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 11:27:42 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-493bab44440so2804275e9.0
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Jul 2026 04:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1783078061; x=1783682861; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OuAm8vdkodpohgIaaoCfMJWpUHZMR+Yb1vVl/12/bjU=;
 b=Tu0HGkFaMpOv9iiFiAZKzF4uD4+7zeRd8QPDmP5ZHv+2g/Ei8K/Z+h5ea6f6ne0PGN
 jMSpMvyxM5PGqqeufKw8Ox6jD8eZ6tPaSMNRsvOT1StWyUy3ky7iD9VZpHYWtSYiI12Q
 z1pGunUYTkHRRQeiNKgAdWDNBzkS9lHwrbO/CTq6eK7egw/ZYr0FVE0O45EWCuWdt9yT
 JPeIS335tEFhFihrU3uWTJ9uj3Iw2eLefvEQA2cOtivTfXJHfi/7jmU7j+15hSjxp720
 4FFVaHIsP0gscvMRnTg/rsniZ+2c1G13Z5ObOiERLqZRdfGAYIldckQwV6HbPtFZPxbb
 5gXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783078061; x=1783682861;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OuAm8vdkodpohgIaaoCfMJWpUHZMR+Yb1vVl/12/bjU=;
 b=AyweHZOWoYG4XJWtrNhPToO7kmPi4u+qt7qytX7RNhs3vPT0Oq//kIRg6WlpwZTSw0
 ZRaQkbnI2KwkR5/d9z5wyvqITQeb9I32rm3lX2u0y+W/hjerlaXRRhvMjY+ygrb536mM
 7Hr6wr1x5MI7YMBgNv5z+Mb2BbJGBRDgOu0mjMvdBtors2XGCThryE+o8aPj7HN1pwFe
 /fsvlEUBMPc5TanxwzKErGFGXWH0sJdU+ZVHCtVVkvmAfHmc7uDeXlwjTyZHL/YXUW9Y
 U6gDkBnnCCM9h6gGZ1pwp/nKjGU8CYgRgIV7cqxAc1DLxZunRe3jAv5SoeFlkssMln1A
 Z+JQ==
X-Gm-Message-State: AOJu0YzSuoeFoVnz72RA0p2W0cHfhc+TUh8HgWaQLusSdBLr1KkMJJli
 +IZLH52ilOeDxCYf7UsRI+jvsY/oKzfldW+Mi+qNJeKaThJHuD1/zYO6jFl9Mvk2RTg=
X-Gm-Gg: AfdE7clhTrYh0k/48zKEa+ca+2UcBNaCrn1LHJJjnsc8Yw8JtGixjD5U4sYmLPYg8+R
 NGKf/cDcbqZrfM0Ea5VN5wowkpx49ItZNC068oRlCodSPxy+AUv73kiLtxBP/Piah1qbgt2O4c6
 oxF9pCmFat/q8O+K9aL3HN1ppUpbvOPrq5t8KxYtHq6oBK6eBj4/u28Bybvz8XBQsNLVGICHCKO
 xJdTCGfdOu4FNzst4elbQIBj7Ym+EeoWeFmPh+ojPmADiDpiyzTcqtzLVt/qt8s1XmNRF43r4j5
 hag/TSu9vatrvL7YD+HZHoWgeKbP8O59WD03vBv25chwPKrLuO1bl44Qv3MGco92CVOXoohvVmA
 V4gFoTBrVhJG2o5g4W+txCY+V1GVLy2/Sb8Q80yXyUQps+8t+IqDQioWgx7PKbXyPDFRYk+aPI6
 A2sSIT0wRpO3+XhN3FxG8kn91vH2yBKg4yyw==
X-Received: by 2002:a05:600c:4b23:b0:493:bc4a:e7d4 with SMTP id
 5b1f17b1804b1-493c9d416d4mr31257795e9.19.1783078060493; 
 Fri, 03 Jul 2026 04:27:40 -0700 (PDT)
Received: from [192.168.0.116] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477dde1a4fdsm18439490f8f.26.2026.07.03.04.27.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jul 2026 04:27:40 -0700 (PDT)
Message-ID: <a4091099-1931-4ca2-a81a-9c3321b123a8@ursulin.net>
Date: Fri, 3 Jul 2026 12:27:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] drm/sched: Protect entity->last_scheduled with
 spinlock
To: Philipp Stanner <phasta@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>, Danilo Krummrich <dakr@kernel.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>, Marco Pagani
 <marco.pagani@linux.dev>, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Boris Brezillon <boris.brezillon@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
References: <20260701085920.3253248-2-phasta@kernel.org>
 <20260701085920.3253248-3-phasta@kernel.org>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20260701085920.3253248-3-phasta@kernel.org>
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


On 01/07/2026 09:59, Philipp Stanner wrote:
> The entity->last_scheduled field has always been set and read with
> special RCU functions in addition to memory barriers.
> 
> This was added in
> 
> commit 70102d77ff22 ("drm/scheduler: add drm_sched_entity_error and use rcu for last_scheduled")
> 
> however, no proper justification for that mechanism was provided. There
> seems to be no obvious reason, since the entity lock is available and
> taken at all places that evaluate the last_scheduled field. The only
> exception is drm_sched_entity_error(), which is not performance critical
> in any way.
> 
> Improve robustness, readability and maintainability by replacing RCU and
> barriers with the lock.

First thing, and regardless of other strands of discussion, I think it 
should be squashed with 3/5 instead of that one undoing the introduction 
of lock-unlock-lock-unlock.

For what the main topic is concerned, I really like the removal of all 
the rcu_dereference_check(, true) lines and the memory barriers.

But I also think the commit message should explain better what code 
paths are now taking an extra lock - under which circumstances is the 
lock now taken for all scheduler users, and which amdgpu paths use 
drm_sched_entity_error() a lot so could be affected. I doubt it creates 
a measurable performance impact but it needs to be explained.

I am also happy to give it a spin on the Steam Deck to see if I can 
observe anything.

> Signed-off-by: Philipp Stanner <phasta@kernel.org>
> ---
>   drivers/gpu/drm/scheduler/sched_entity.c | 50 ++++++++++--------------
>   include/drm/gpu_scheduler.h              |  9 ++---
>   2 files changed, 25 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
> index c51101ec70c1..91aec20611ad 100644
> --- a/drivers/gpu/drm/scheduler/sched_entity.c
> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
> @@ -135,7 +135,6 @@ int drm_sched_entity_init(struct drm_sched_entity *entity,
>   	entity->num_sched_list = num_sched_list;
>   	entity->sched_list = num_sched_list > 1 ? sched_list : NULL;
>   	entity->rq = &sched_list[0]->rq;
> -	RCU_INIT_POINTER(entity->last_scheduled, NULL);
>   	RB_CLEAR_NODE(&entity->rb_tree_node);
>   	init_completion(&entity->entity_idle);
>   
> @@ -201,10 +200,10 @@ int drm_sched_entity_error(struct drm_sched_entity *entity)
>   	struct dma_fence *fence;
>   	int r;
>   
> -	rcu_read_lock();
> -	fence = rcu_dereference(entity->last_scheduled);
> +	spin_lock(&entity->lock);
> +	fence = entity->last_scheduled;
>   	r = fence ? fence->error : 0;
> -	rcu_read_unlock();
> +	spin_unlock(&entity->lock);
>   
>   	return r;
>   }
> @@ -287,9 +286,10 @@ void drm_sched_entity_kill(struct drm_sched_entity *entity)
>   	/* Make sure this entity is not used by the scheduler at the moment */
>   	wait_for_completion(&entity->entity_idle);
>   
> -	/* The entity is guaranteed to not be used by the scheduler */
> -	prev = rcu_dereference_check(entity->last_scheduled, true);
> +	spin_lock(&entity->lock);
> +	prev = entity->last_scheduled;
>   	dma_fence_get(prev);
> +	spin_unlock(&entity->lock);
>   	while ((job = drm_sched_entity_queue_pop(entity))) {
>   		struct drm_sched_fence *s_fence = job->s_fence;
>   
> @@ -381,8 +381,7 @@ void drm_sched_entity_fini(struct drm_sched_entity *entity)
>   		entity->dependency = NULL;
>   	}
>   
> -	dma_fence_put(rcu_dereference_check(entity->last_scheduled, true));
> -	RCU_INIT_POINTER(entity->last_scheduled, NULL);
> +	dma_fence_put(entity->last_scheduled);
>   	drm_sched_entity_stats_put(entity->stats);
>   }
>   EXPORT_SYMBOL(drm_sched_entity_fini);
> @@ -507,6 +506,10 @@ drm_sched_job_dependency(struct drm_sched_job *job,
>   
>   struct drm_sched_job *drm_sched_entity_pop_job(struct drm_sched_entity *entity)
>   {
> +	/* Helper to avoid dropping the reference while the entity lock is held,
> +	 * just to have some more robustness.
> +	 */

I don't get this comment. Neither the placement or the content.

Regards,

Tvrtko

> +	struct dma_fence *prev_last_scheduled;
>   	struct drm_sched_job *sched_job;
>   
>   	sched_job = drm_sched_entity_queue_peek(entity);
> @@ -523,19 +526,14 @@ struct drm_sched_job *drm_sched_entity_pop_job(struct drm_sched_entity *entity)
>   	if (entity->guilty && atomic_read(entity->guilty))
>   		dma_fence_set_error(&sched_job->s_fence->finished, -ECANCELED);
>   
> -	dma_fence_put(rcu_dereference_check(entity->last_scheduled, true));
> -	rcu_assign_pointer(entity->last_scheduled,
> -			   dma_fence_get(&sched_job->s_fence->finished));
> -
> -	/*
> -	 * If the queue is empty we allow drm_sched_entity_select_rq() to
> -	 * locklessly access ->last_scheduled. This only works if we set the
> -	 * pointer before we dequeue and if we a write barrier here.
> -	 */
> -	smp_wmb();
> +	spin_lock(&entity->lock);
> +	prev_last_scheduled = entity->last_scheduled;
> +	entity->last_scheduled = dma_fence_get(&sched_job->s_fence->finished);
> +	spin_unlock(&entity->lock);
>   
>   	spsc_queue_pop(&entity->job_queue);
>   
> +	dma_fence_put(prev_last_scheduled);
>   	drm_sched_rq_pop_entity(entity);
>   
>   	/* Jobs and entities might have different lifecycles. Since we're
> @@ -561,21 +559,15 @@ void drm_sched_entity_select_rq(struct drm_sched_entity *entity)
>   	if (spsc_queue_count(&entity->job_queue))
>   		return;
>   
> -	/*
> -	 * Only when the queue is empty are we guaranteed that
> -	 * drm_sched_run_job_work() cannot change entity->last_scheduled. To
> -	 * enforce ordering we need a read barrier here. See
> -	 * drm_sched_entity_pop_job() for the other side.
> -	 */
> -	smp_rmb();
> -
> -	fence = rcu_dereference_check(entity->last_scheduled, true);
> +	spin_lock(&entity->lock);
> +	fence = entity->last_scheduled;
>   
>   	/* stay on the same engine if the previous job hasn't finished */
> -	if (fence && !dma_fence_is_signaled(fence))
> +	if (fence && !dma_fence_is_signaled(fence)) {
> +		spin_unlock(&entity->lock);
>   		return;
> +	}
>   
> -	spin_lock(&entity->lock);
>   	sched = drm_sched_pick_best(entity->sched_list, entity->num_sched_list);
>   	rq = sched ? &sched->rq : NULL;
>   	if (rq != entity->rq) {
> diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
> index d61c19e78182..176ff1f936cd 100644
> --- a/include/drm/gpu_scheduler.h
> +++ b/include/drm/gpu_scheduler.h
> @@ -100,7 +100,8 @@ struct drm_sched_entity {
>   	 * @lock:
>   	 *
>   	 * Lock protecting the run-queue (@rq) to which this entity belongs,
> -	 * @priority and the list of schedulers (@sched_list, @num_sched_list).
> +	 * @priority, @last_scheduled and the list of schedulers (@sched_list,
> +	 * @num_sched_list).
>   	 */
>   	spinlock_t			lock;
>   
> @@ -202,11 +203,9 @@ struct drm_sched_entity {
>   	/**
>   	 * @last_scheduled:
>   	 *
> -	 * Points to the finished fence of the last scheduled job. Only written
> -	 * by drm_sched_entity_pop_job(). Can be accessed locklessly from
> -	 * drm_sched_job_arm() if the queue is empty.
> +	 * Points to the finished fence of the last scheduled job.
>   	 */
> -	struct dma_fence __rcu		*last_scheduled;
> +	struct dma_fence		*last_scheduled;
>   
>   	/**
>   	 * @last_user: last group leader pushing a job into the entity.

