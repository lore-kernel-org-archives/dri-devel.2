Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A28606A31C
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 13:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=n2v2isfA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA50310E8A1;
	Mon,  9 Nov 2026 13:23:38 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A12C10E772;
 Mon,  9 Nov 2026 13:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=E7k+XtyvTbOgMpzzEIXkCAsFuuvYd8RfNhrY6WdEzZg=; t=1794230613; x=2109590613; 
 b=n2v2isfACD5bk5w9+l+gMOGYtsQgCV95qjpUvXkhKdRVwic2m7rSPq8WK4im7/BUWFNuhwifCX0
 X9OSlJQ9ZaXTjDvOwINd/HHeoMOrv3Xc2/kYljq26U7Lk59O8OCwdQcT8sh4AdQFjueLoDr7qyzLi
 6BR2j1Duw6YaeAwqTODWTvahHZxkhTd4G3S1Q4/OR0+4CXifRvCuUJHoYpZJ1XPtnIkQTp73Ehhzm
 j5S2plTCs2IXh7rx9Iy6pNNGrD+j4Rik10m8N+m6VGNjIXz3A8P/cauWw0w3BbP+Zv2ditGjWQB9E
 wwmZ7cMZ221SsfrC5oLH4Wnqsnr5/5ov1YOw==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xQPLO-007Iyo-PY; Mon, 09 Nov 2026 14:23:30 +0100
Message-ID: <2d36879b-221a-4427-9800-779311fab70c@igalia.com>
Date: Mon, 9 Nov 2026 13:23:30 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/8] drm/sched: Replace completion with a flush
To: sashiko-reviews@lists.linux.dev, dri-devel@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org, Philipp Stanner <phasta@kernel.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
References: <20261020154123.33631-1-tvrtko.ursulin@igalia.com>
 <20261020154123.33631-8-tvrtko.ursulin@igalia.com>
 <sashiko-outbox-179331@kernel.org>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <sashiko-outbox-179331@kernel.org>
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
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 20/10/2026 17:07, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [Critical] drm/sched: stopped entity re-enters rbtree in drm_sched_rq_pop_entity()

This seems to be a pre-existing issue going all the way back to when 
FIFO was added. I'll send a fix.

> - [Critical] drm/sched: concurrent drm_sched_entity_kill() skips run_work flush

This one at least appears to be a real problem. So I think the 
simplification will not fly after all and I will need to drop this patch.

Cc: Philipp and Christian for visibility.

Regards,

Tvrtko

> - [High] drm/sched: workqueue deadlock in drm_sched_entity_kill() from free_job
> --
> 
> commit 271930dfdc1a5516f290d150182ce8d6b1d2358b
> Author: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> 
> drm/sched: Replace completion with a flush
> 
> This commit replaces struct drm_sched_entity.entity_idle with a flush of
> the scheduler's work_run_job work item in drm_sched_entity_kill() after
> removing the entity from the run-queue.
> 
>> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
>> index 3ca671af02ed5..79ea20838328d 100644
>> --- a/drivers/gpu/drm/scheduler/sched_entity.c
>> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
> [ ... ]
>> @@ -304,16 +299,23 @@ static void drm_sched_entity_kill_jobs_cb(struct dma_fence *f,
>>    */
>>   void drm_sched_entity_kill(struct drm_sched_entity *entity)
>>   {
>> +	struct drm_gpu_scheduler *sched;
>>   	struct drm_sched_job *job;
>>   	struct dma_fence *prev;
>>   
>>   	spin_lock(&entity->lock);
>>   	entity->stopped = true;
>> -	drm_sched_rq_remove_entity(entity->rq, entity);
>> +	sched = drm_sched_rq_remove_entity(entity->rq, entity);
>>   	spin_unlock(&entity->lock);
>>   
>> -	/* Make sure this entity is not used by the scheduler at the moment */
>> -	wait_for_completion(&entity->entity_idle);
>> +	/*
>> +	 * Make sure this entity is not used by the scheduler at the moment.
>> +	 *
>> +	 * Scheduler is guaranteed to be stable after the entity was stopped and
>> +	 * removed from the run-queue.
>> +	 */
>> +	if (sched)
>> +		drm_sched_flush_run_work(sched);
> 
> [Severity: Critical]
> Can an in-flight drm_sched_run_job_work() re-insert the stopped entity
> back into rq->rb_tree_root while drm_sched_entity_kill() is waiting inside
> drm_sched_flush_run_work()?
> 
> When an entity has two or more queued jobs and drm_sched_run_job_work()
> selects it via drm_sched_select_entity() -> drm_sched_rq_select_entity(),
> rq->lock is dropped before calling drm_sched_entity_pop_job(entity), which
> peeks the first job and checks its dependencies without holding rq->lock
> or entity->lock.
> 
> If drm_sched_entity_kill() runs during that unlocked window, it sets
> entity->stopped = true, removes entity->list and entity->rb_tree_node via
> drm_sched_rq_remove_entity(), and blocks in drm_sched_flush_run_work()
> before draining entity->job_queue.
> 
> The in-flight drm_sched_entity_pop_job() then acquires entity->lock, pops
> the first job, and calls drm_sched_rq_pop_entity(entity):
> 
> drivers/gpu/drm/scheduler/sched_entity.c:drm_sched_entity_pop_job() {
> 	...
> 	spin_lock(&entity->lock);
> 	prev_last_scheduled = entity->last_scheduled;
> 	entity->last_scheduled = dma_fence_get(&sched_job->s_fence->finished);
> 	spsc_queue_pop(&entity->job_queue);
> 	drm_sched_rq_pop_entity(entity);
> 	spin_unlock(&entity->lock);
> 	...
> }
> 
> In drm_sched_rq_pop_entity(), neither entity->stopped nor
> list_empty(&entity->list) is checked, and because the second job is still
> in entity->job_queue, next_job is non-NULL:
> 
> drivers/gpu/drm/scheduler/sched_rq.c:drm_sched_rq_pop_entity() {
> 	...
> 	next_job = drm_sched_entity_queue_peek(entity);
> 	if (next_job) {
> 		ktime_t ts;
> 		...
> 		drm_sched_rq_update_fifo_locked(entity, rq, ts);
> 	}
> 	...
> }
> 
> This re-inserts entity->rb_tree_node into rq->rb_tree_root before
> drm_sched_run_job_work() re-queues sched->work_run_job and finishes.
> 
> Once drm_sched_flush_run_work() returns, won't the re-queued
> drm_sched_run_job_work() be able to select the entity again concurrently
> with drm_sched_entity_kill() draining entity->job_queue and
> drm_sched_entity_fini() freeing the entity, or leave a dangling
> entity->rb_tree_node in rq->rb_tree_root because subsequent calls to
> drm_sched_rq_remove_entity() see list_empty(&entity->list) and return NULL
> early?
> 
> [Severity: High]
> Can calling drm_sched_flush_run_work(sched) here deadlock when
> drm_sched_entity_kill() is invoked from a driver's free_job() callback on
> sched->submit_wq?
> 
> When an entity pushes a job, drm_sched_rq_add_entity() links entity->list
> onto rq->entities, and entity->list stays linked even after all jobs have
> been popped and completed until drm_sched_rq_remove_entity() is called in
> drm_sched_entity_kill(). As a result, drm_sched_rq_remove_entity() returns
> a non-NULL sched for any entity that has ever submitted a job, causing
> drm_sched_entity_kill() to call flush_work(&sched->work_run_job).
> 
> By default, sched->submit_wq is allocated via drm_sched_alloc_wq() as an
> ordered workqueue (max_active = 1) shared by sched->work_run_job and
> sched->work_free_job. In drivers such as msm and panfrost, freeing a job in
> drm_sched_free_job_work() -> sched->ops->free_job() can drop the last
> reference to a closed context or submitqueue and tear down its entities:
> 
> drm_sched_free_job_work()
>    -> msm_job_free()
>      -> msm_gem_submit_put()
>        -> __msm_gem_submit_destroy()
>          -> msm_submitqueue_put() / msm_context_put()
>            -> __msm_context_destroy()
>              -> drm_sched_entity_destroy()
>                -> drm_sched_entity_fini()
>                  -> drm_sched_entity_kill()
>                    -> drm_sched_flush_run_work()
>                      -> flush_work(&sched->work_run_job)
> 
> and similarly via panfrost_job_free() -> panfrost_job_put() ->
> panfrost_job_cleanup() -> panfrost_jm_ctx_put() ->
> panfrost_jm_ctx_release() -> drm_sched_entity_destroy().
> 
> If sched->work_run_job is queued on the ordered sched->submit_wq when
> drm_sched_free_job_work() runs this path, won't flush_work(&sched->work_run_job)
> deadlock waiting for work_run_job, which cannot start until
> drm_sched_free_job_work() finishes (and trigger a recursive lockdep
> warning on drm_sched_lockdep_map)?
> 
>>   
>>   	spin_lock(&entity->lock);
>>   	prev = dma_fence_get(entity->last_scheduled);
> [ ... ]
>> diff --git a/drivers/gpu/drm/scheduler/sched_rq.c b/drivers/gpu/drm/scheduler/sched_rq.c
>> index 23f46ec610e78..79f7bdb5b3f0a 100644
>> --- a/drivers/gpu/drm/scheduler/sched_rq.c
>> +++ b/drivers/gpu/drm/scheduler/sched_rq.c
>> @@ -297,23 +297,32 @@ drm_sched_rq_add_entity(struct drm_sched_entity *entity, ktime_t ts)
>>    * @entity: scheduler entity
>>    *
>>    * Removes a scheduler entity from the run queue.
>> + *
>> + * Return: DRM scheduler selected to handle this entity or NULL if entity has
>> + * already been removed.
>>    */
>> -void drm_sched_rq_remove_entity(struct drm_sched_rq *rq,
>> -				struct drm_sched_entity *entity)
>> +struct drm_gpu_scheduler *
>> +drm_sched_rq_remove_entity(struct drm_sched_rq *rq,
>> +			   struct drm_sched_entity *entity)
>>   {
>> +	struct drm_gpu_scheduler *sched;
>> +
>>   	lockdep_assert_held(&entity->lock);
>>   
>>   	if (list_empty(&entity->list))
>> -		return;
>> +		return NULL;
>>   
>>   	spin_lock(&rq->lock);
>>   
>> -	atomic_dec(rq->sched->score);
>> +	sched = rq->sched;
>> +	atomic_dec(sched->score);
>>   	list_del_init(&entity->list);
>>   
>>   	drm_sched_rq_remove_fifo_locked(entity, rq);
>>   
>>   	spin_unlock(&rq->lock);
>> +
>> +	return sched;
>>   }
> 
> [Severity: Critical]
> What happens if two threads call drm_sched_entity_kill() on the same
> entity concurrently (for instance, one thread in file_operations->flush
> calling drm_sched_entity_flush() -> drm_sched_entity_kill() upon SIGKILL,
> and another thread closing the context and calling drm_sched_entity_fini()
> -> drm_sched_entity_kill()) while drm_sched_run_job_work() is using the
> entity?
> 
> Previously, both callers waited on wait_for_completion(&entity->entity_idle)
> until drm_sched_run_job_work() called complete_all(&entity->entity_idle).
> 
> With this change, the first caller into drm_sched_rq_remove_entity() runs
> list_del_init(&entity->list), receives the non-NULL sched pointer, drops
> entity->lock, and blocks in drm_sched_flush_run_work(sched).
> 
> When the second caller enters drm_sched_rq_remove_entity(), it sees
> list_empty(&entity->list) and gets NULL back, so in drm_sched_entity_kill()
> it skips drm_sched_flush_run_work(sched) and proceeds directly to draining
> entity->job_queue and freeing the entity in drm_sched_entity_fini() while
> drm_sched_run_job_work() is still running. Can this cause a use-after-free
> and concurrent SPSC queue access on entity->job_queue?
> 
> [ ... ]
> 

