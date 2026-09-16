Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 256AEC88E5C
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 12:33:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5309F10E065;
	Wed, 16 Sep 2026 12:33:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OLnngwi5";
	dkim-atps=neutral
Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com
 [74.125.225.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9077510E065
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 12:33:09 +0000 (UTC)
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-4843c2790ccso454093f8f.1
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 05:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789561988; x=1790166788; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=a1EN2OK8k7gYm/WXEqB2cKw6sRlIVrueaJhwh5lRhr4=;
 b=OLnngwi5+OkmoO6i/6ANOY6XAuRnbb48mHXJq+/7j1wjrNcCb5g74vLoYW0sMu08La
 cCVKERNmkgU9KEW4gcYK7agc4uD4S1jzZCfJ5XmDlQrTyZmzXYjwL+P2Mq0LGH8eSqfH
 O9ozkwovE8Ezxr7u2x0df+Q/ErlIBQ9Za4hteIWZhbL2hOhXvgCwvjkI4ubsjCEtbBDv
 Dn+Yo+UswxxNGOhu073i/dHbe7gg2I/pTbeCKSrj0vzZoDtxltM8/gO5phBAoH6xnwJ4
 QTGIK4m1nyhbC+2Piv68eUOYMCPWlVy8H3qVf0vvAxhlci1xOWAXoY7k3QiOkkcySx8u
 VT4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789561988; x=1790166788;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=a1EN2OK8k7gYm/WXEqB2cKw6sRlIVrueaJhwh5lRhr4=;
 b=idg++H59crhVZpAbr3j3Dqgko76pnUMtxqVfgZaIZ802OA5mCDdVvDqCsHYQZfqZ0y
 ZBniREyY4lZjcfI/JQ7BuGx54gJ4cuChqVz534BU+ni8a+BHlyWf7EQaUbz/Bv/ApLPj
 /LQ3z1ktLwlxN+JA4O4X3n5nCBfg/ZGwZGaTnMvvgs9ihpXw2Tr5clqmPzmnvh3sOjWj
 P+WA9hcFOwemQr/mbQTlKGZbM6FBfycXPUGkHFfMEqP+eK1Nkv8uly3DW+RLu5XE1sHX
 wKm/g2ejoGC6aDiMRmPPeBS+tFjnIU/WPs1HGcCN1Ar03FCojo3VwyMSzIUmmfxfoTiU
 09QA==
X-Gm-Message-State: AFuF++nzrJHfZeF/bqvgHBdGT5I3fzQiKnLV796L/tzxNiDZhohxirdD
 qyqDHPai2QtRrAvzX1HdsvsEXEe45gC5kHVuC0/uwvGGPJGc3sZvbNkz
X-Gm-Gg: AYBFou3r+zwH2FhQ8a1vc3LgaHbRoeMwEm1Yp6mQte1OJd41PXNIEg7uqcygBAgr+Zb
 TqaJ8OUIBZJZPKdxs5qk6HGhqX2I0nN6v4HEdOtnSHD4t83xlfSyeKXRRCruIdcu/v26zjWdJKL
 ZS3/kAQN5B1spl9x8t+vOPtKg4jzetrcM5hlFIeIiz5Ha1d55ORFktV8RkF+Jy5lnKkJOlkX7LK
 Bx5oHF1RYKGlMBAHthKQMm030PHAaL7H3K9lZSKGvBEB23+/FJN/QckdCPU9E3qU5ShXz1RMRJ/
 l+BhkrwDQLokaglS6Y2IGsoDGiFF/yGgrvR+w0epMj8HzgYq49aBXpABc9GO5zq57AB/cLiAeRb
 zvLOgySYSAKM364o1APqEmHJjut27hUXj/5YNJw6vb/uktZjTgiF6w6+gi1SChboIKcWhQbRVZ3
 EDhUWzQSlvdiiPM5SuROx1TdTaBVZ/4P8Rkzg92SLXoACq/7/iQus9FzXrGqVnCBR2R9lnCRuW4
 xBCJrMRHn9VstYhcc0q8k2iSmQYXilks+793Rk=
X-Received: by 2002:a05:600c:46ce:b0:49c:dca4:94c with SMTP id
 5b1f17b1804b1-49eb7339895mr52752455e9.13.1789561987513; 
 Wed, 16 Sep 2026 05:33:07 -0700 (PDT)
Received: from [10.254.153.228] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e847ecf52sm51623765e9.2.2026.09.16.05.33.05
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 16 Sep 2026 05:33:06 -0700 (PDT)
Message-ID: <14ad8ea7-c65c-48b0-94c5-bc881d7aaddd@gmail.com>
Date: Wed, 16 Sep 2026 14:33:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] drm/sched: Protect entity->last_scheduled with
 spinlock
To: Philipp Stanner <phasta@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260910075942.2000338-2-phasta@kernel.org>
 <20260910075942.2000338-5-phasta@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20260910075942.2000338-5-phasta@kernel.org>
Content-Type: text/plain; charset=UTF-8
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

On 9/10/26 09:59, Philipp Stanner wrote:
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
> 
> Signed-off-by: Philipp Stanner <phasta@kernel.org>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/scheduler/sched_entity.c | 50 ++++++++++--------------
>  include/drm/gpu_scheduler.h              | 10 ++---
>  2 files changed, 24 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
> index e168f445f2ab..fa4a9388e5c9 100644
> --- a/drivers/gpu/drm/scheduler/sched_entity.c
> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
> @@ -136,7 +136,6 @@ int drm_sched_entity_init(struct drm_sched_entity *entity,
>  			      DRM_SCHED_PRIORITY_KERNEL : priority;
>  	entity->num_sched_list = num_sched_list;
>  	entity->sched_list = num_sched_list > 1 ? sched_list : NULL;
> -	RCU_INIT_POINTER(entity->last_scheduled, NULL);
>  	RB_CLEAR_NODE(&entity->rb_tree_node);
>  
>  	if (!sched_list[0]->sched_rq) {
> @@ -233,10 +232,10 @@ int drm_sched_entity_error(struct drm_sched_entity *entity)
>  	struct dma_fence *fence;
>  	int r;
>  
> -	rcu_read_lock();
> -	fence = rcu_dereference(entity->last_scheduled);
> +	spin_lock(&entity->lock);
> +	fence = entity->last_scheduled;
>  	r = fence ? fence->error : 0;
> -	rcu_read_unlock();
> +	spin_unlock(&entity->lock);
>  
>  	return r;
>  }
> @@ -319,9 +318,10 @@ void drm_sched_entity_kill(struct drm_sched_entity *entity)
>  	/* Make sure this entity is not used by the scheduler at the moment */
>  	wait_for_completion(&entity->entity_idle);
>  
> -	/* The entity is guaranteed to not be used by the scheduler */
> -	prev = rcu_dereference_check(entity->last_scheduled, true);
> +	spin_lock(&entity->lock);
> +	prev = entity->last_scheduled;
>  	dma_fence_get(prev);
> +	spin_unlock(&entity->lock);
>  	while ((job = drm_sched_entity_queue_pop(entity))) {
>  		struct drm_sched_fence *s_fence = job->s_fence;
>  
> @@ -413,8 +413,7 @@ void drm_sched_entity_fini(struct drm_sched_entity *entity)
>  		entity->dependency = NULL;
>  	}
>  
> -	dma_fence_put(rcu_dereference_check(entity->last_scheduled, true));
> -	RCU_INIT_POINTER(entity->last_scheduled, NULL);
> +	dma_fence_put(entity->last_scheduled);
>  	drm_sched_entity_stats_put(entity->stats);
>  }
>  EXPORT_SYMBOL(drm_sched_entity_fini);
> @@ -536,6 +535,10 @@ drm_sched_job_dependency(struct drm_sched_job *job,
>  
>  struct drm_sched_job *drm_sched_entity_pop_job(struct drm_sched_entity *entity)
>  {
> +	/* Helper to avoid dropping the reference while the entity lock is held,
> +	 * just to have some more robustness.
> +	 */
> +	struct dma_fence *prev_last_scheduled;
>  	struct drm_sched_job *sched_job;
>  
>  	sched_job = drm_sched_entity_queue_peek(entity);
> @@ -552,22 +555,15 @@ struct drm_sched_job *drm_sched_entity_pop_job(struct drm_sched_entity *entity)
>  	if (entity->guilty && atomic_read(entity->guilty))
>  		dma_fence_set_error(&sched_job->s_fence->finished, -ECANCELED);
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
> -
>  	spin_lock(&entity->lock);
> +	prev_last_scheduled = entity->last_scheduled;
> +	entity->last_scheduled = dma_fence_get(&sched_job->s_fence->finished);
>  	spsc_queue_pop(&entity->job_queue);
>  	drm_sched_rq_pop_entity(entity);
>  	spin_unlock(&entity->lock);
>  
> +	dma_fence_put(prev_last_scheduled);
> +
>  	/* Jobs and entities might have different lifecycles. Since we're
>  	 * removing the job from the entities queue, set the jobs entity pointer
>  	 * to NULL to prevent any future access of the entity through this job.
> @@ -591,21 +587,15 @@ void drm_sched_entity_select_rq(struct drm_sched_entity *entity)
>  	if (spsc_queue_count(&entity->job_queue))
>  		return;
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
>  	/* stay on the same engine if the previous job hasn't finished */
> -	if (fence && !dma_fence_is_signaled(fence))
> +	if (fence && !dma_fence_is_signaled(fence)) {
> +		spin_unlock(&entity->lock);
>  		return;
> +	}
>  
> -	spin_lock(&entity->lock);
>  	sched = drm_sched_pick_best(entity->sched_list, entity->num_sched_list);
>  	rq = sched ? sched->sched_rq[entity->rq_priority] : NULL;
>  	if (rq != entity->rq) {
> diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
> index 7a64cc11de08..aeeea6efc623 100644
> --- a/include/drm/gpu_scheduler.h
> +++ b/include/drm/gpu_scheduler.h
> @@ -100,8 +100,8 @@ struct drm_sched_entity {
>  	 * @lock:
>  	 *
>  	 * Lock protecting the run-queue (@rq) to which this entity belongs,
> -	 * @priority, the list of schedulers (@sched_list, @num_sched_list) and
> -	 * the @rr_ts field.
> +	 * @priority, @last_scheduled and the list of schedulers (@sched_list,
> +	 * @num_sched_list).
>  	 */
>  	spinlock_t			lock;
>  
> @@ -215,11 +215,9 @@ struct drm_sched_entity {
>  	/**
>  	 * @last_scheduled:
>  	 *
> -	 * Points to the finished fence of the last scheduled job. Only written
> -	 * by drm_sched_entity_pop_job(). Can be accessed locklessly from
> -	 * drm_sched_job_arm() if the queue is empty.
> +	 * Points to the finished fence of the last scheduled job.
>  	 */
> -	struct dma_fence __rcu		*last_scheduled;
> +	struct dma_fence		*last_scheduled;
>  
>  	/**
>  	 * @last_user: last group leader pushing a job into the entity.

