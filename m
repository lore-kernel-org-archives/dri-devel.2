Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FBC606A31A
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 16:08:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C803F10E15D;
	Tue, 20 Oct 2026 16:08:06 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FD5A10E15D;
 Tue, 20 Oct 2026 16:08:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 60C0F601F9;
 Tue, 20 Oct 2026 16:08:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5D1F1F000C9;
 Tue, 20 Oct 2026 16:08:03 +0000 (UTC)
Message-ID: <sashiko-outbox-179331@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 7/8] drm/sched: Replace completion with a flush
To: "Tvrtko Ursulin" <tvrtko.ursulin@igalia.com>,
 dri-devel@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org
In-Reply-To: <20261020154123.33631-8-tvrtko.ursulin@igalia.com>
References: <20261020154123.33631-1-tvrtko.ursulin@igalia.com>
 <20261020154123.33631-8-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 16:07:33 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] drm/sched: stopped entity re-enters rbtree in drm_sched_rq_pop=
_entity()
- [Critical] drm/sched: concurrent drm_sched_entity_kill() skips run_work f=
lush
- [High] drm/sched: workqueue deadlock in drm_sched_entity_kill() from free=
_job
--

commit 271930dfdc1a5516f290d150182ce8d6b1d2358b
Author: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

drm/sched: Replace completion with a flush

This commit replaces struct drm_sched_entity.entity_idle with a flush of
the scheduler's work_run_job work item in drm_sched_entity_kill() after
removing the entity from the run-queue.

> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/s=
cheduler/sched_entity.c
> index 3ca671af02ed5..79ea20838328d 100644
> --- a/drivers/gpu/drm/scheduler/sched_entity.c
> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
[ ... ]
> @@ -304,16 +299,23 @@ static void drm_sched_entity_kill_jobs_cb(struct dm=
a_fence *f,
>   */
>  void drm_sched_entity_kill(struct drm_sched_entity *entity)
>  {
> +	struct drm_gpu_scheduler *sched;
>  	struct drm_sched_job *job;
>  	struct dma_fence *prev;
> =20
>  	spin_lock(&entity->lock);
>  	entity->stopped =3D true;
> -	drm_sched_rq_remove_entity(entity->rq, entity);
> +	sched =3D drm_sched_rq_remove_entity(entity->rq, entity);
>  	spin_unlock(&entity->lock);
> =20
> -	/* Make sure this entity is not used by the scheduler at the moment */
> -	wait_for_completion(&entity->entity_idle);
> +	/*
> +	 * Make sure this entity is not used by the scheduler at the moment.
> +	 *
> +	 * Scheduler is guaranteed to be stable after the entity was stopped and
> +	 * removed from the run-queue.
> +	 */
> +	if (sched)
> +		drm_sched_flush_run_work(sched);

[Severity: Critical]
Can an in-flight drm_sched_run_job_work() re-insert the stopped entity
back into rq->rb_tree_root while drm_sched_entity_kill() is waiting inside
drm_sched_flush_run_work()?

When an entity has two or more queued jobs and drm_sched_run_job_work()
selects it via drm_sched_select_entity() -> drm_sched_rq_select_entity(),
rq->lock is dropped before calling drm_sched_entity_pop_job(entity), which
peeks the first job and checks its dependencies without holding rq->lock
or entity->lock.

If drm_sched_entity_kill() runs during that unlocked window, it sets
entity->stopped =3D true, removes entity->list and entity->rb_tree_node via
drm_sched_rq_remove_entity(), and blocks in drm_sched_flush_run_work()
before draining entity->job_queue.

The in-flight drm_sched_entity_pop_job() then acquires entity->lock, pops
the first job, and calls drm_sched_rq_pop_entity(entity):

drivers/gpu/drm/scheduler/sched_entity.c:drm_sched_entity_pop_job() {
	...
	spin_lock(&entity->lock);
	prev_last_scheduled =3D entity->last_scheduled;
	entity->last_scheduled =3D dma_fence_get(&sched_job->s_fence->finished);
	spsc_queue_pop(&entity->job_queue);
	drm_sched_rq_pop_entity(entity);
	spin_unlock(&entity->lock);
	...
}

In drm_sched_rq_pop_entity(), neither entity->stopped nor
list_empty(&entity->list) is checked, and because the second job is still
in entity->job_queue, next_job is non-NULL:

drivers/gpu/drm/scheduler/sched_rq.c:drm_sched_rq_pop_entity() {
	...
	next_job =3D drm_sched_entity_queue_peek(entity);
	if (next_job) {
		ktime_t ts;
		...
		drm_sched_rq_update_fifo_locked(entity, rq, ts);
	}
	...
}

This re-inserts entity->rb_tree_node into rq->rb_tree_root before
drm_sched_run_job_work() re-queues sched->work_run_job and finishes.

Once drm_sched_flush_run_work() returns, won't the re-queued
drm_sched_run_job_work() be able to select the entity again concurrently
with drm_sched_entity_kill() draining entity->job_queue and
drm_sched_entity_fini() freeing the entity, or leave a dangling
entity->rb_tree_node in rq->rb_tree_root because subsequent calls to
drm_sched_rq_remove_entity() see list_empty(&entity->list) and return NULL
early?

[Severity: High]
Can calling drm_sched_flush_run_work(sched) here deadlock when
drm_sched_entity_kill() is invoked from a driver's free_job() callback on
sched->submit_wq?

When an entity pushes a job, drm_sched_rq_add_entity() links entity->list
onto rq->entities, and entity->list stays linked even after all jobs have
been popped and completed until drm_sched_rq_remove_entity() is called in
drm_sched_entity_kill(). As a result, drm_sched_rq_remove_entity() returns
a non-NULL sched for any entity that has ever submitted a job, causing
drm_sched_entity_kill() to call flush_work(&sched->work_run_job).

By default, sched->submit_wq is allocated via drm_sched_alloc_wq() as an
ordered workqueue (max_active =3D 1) shared by sched->work_run_job and
sched->work_free_job. In drivers such as msm and panfrost, freeing a job in
drm_sched_free_job_work() -> sched->ops->free_job() can drop the last
reference to a closed context or submitqueue and tear down its entities:

drm_sched_free_job_work()
  -> msm_job_free()
    -> msm_gem_submit_put()
      -> __msm_gem_submit_destroy()
        -> msm_submitqueue_put() / msm_context_put()
          -> __msm_context_destroy()
            -> drm_sched_entity_destroy()
              -> drm_sched_entity_fini()
                -> drm_sched_entity_kill()
                  -> drm_sched_flush_run_work()
                    -> flush_work(&sched->work_run_job)

and similarly via panfrost_job_free() -> panfrost_job_put() ->
panfrost_job_cleanup() -> panfrost_jm_ctx_put() ->
panfrost_jm_ctx_release() -> drm_sched_entity_destroy().

If sched->work_run_job is queued on the ordered sched->submit_wq when
drm_sched_free_job_work() runs this path, won't flush_work(&sched->work_run=
_job)
deadlock waiting for work_run_job, which cannot start until
drm_sched_free_job_work() finishes (and trigger a recursive lockdep
warning on drm_sched_lockdep_map)?

> =20
>  	spin_lock(&entity->lock);
>  	prev =3D dma_fence_get(entity->last_scheduled);
[ ... ]
> diff --git a/drivers/gpu/drm/scheduler/sched_rq.c b/drivers/gpu/drm/sched=
uler/sched_rq.c
> index 23f46ec610e78..79f7bdb5b3f0a 100644
> --- a/drivers/gpu/drm/scheduler/sched_rq.c
> +++ b/drivers/gpu/drm/scheduler/sched_rq.c
> @@ -297,23 +297,32 @@ drm_sched_rq_add_entity(struct drm_sched_entity *en=
tity, ktime_t ts)
>   * @entity: scheduler entity
>   *
>   * Removes a scheduler entity from the run queue.
> + *
> + * Return: DRM scheduler selected to handle this entity or NULL if entit=
y has
> + * already been removed.
>   */
> -void drm_sched_rq_remove_entity(struct drm_sched_rq *rq,
> -				struct drm_sched_entity *entity)
> +struct drm_gpu_scheduler *
> +drm_sched_rq_remove_entity(struct drm_sched_rq *rq,
> +			   struct drm_sched_entity *entity)
>  {
> +	struct drm_gpu_scheduler *sched;
> +
>  	lockdep_assert_held(&entity->lock);
> =20
>  	if (list_empty(&entity->list))
> -		return;
> +		return NULL;
> =20
>  	spin_lock(&rq->lock);
> =20
> -	atomic_dec(rq->sched->score);
> +	sched =3D rq->sched;
> +	atomic_dec(sched->score);
>  	list_del_init(&entity->list);
> =20
>  	drm_sched_rq_remove_fifo_locked(entity, rq);
> =20
>  	spin_unlock(&rq->lock);
> +
> +	return sched;
>  }

[Severity: Critical]
What happens if two threads call drm_sched_entity_kill() on the same
entity concurrently (for instance, one thread in file_operations->flush
calling drm_sched_entity_flush() -> drm_sched_entity_kill() upon SIGKILL,
and another thread closing the context and calling drm_sched_entity_fini()
-> drm_sched_entity_kill()) while drm_sched_run_job_work() is using the
entity?

Previously, both callers waited on wait_for_completion(&entity->entity_idle)
until drm_sched_run_job_work() called complete_all(&entity->entity_idle).

With this change, the first caller into drm_sched_rq_remove_entity() runs
list_del_init(&entity->list), receives the non-NULL sched pointer, drops
entity->lock, and blocks in drm_sched_flush_run_work(sched).

When the second caller enters drm_sched_rq_remove_entity(), it sees
list_empty(&entity->list) and gets NULL back, so in drm_sched_entity_kill()
it skips drm_sched_flush_run_work(sched) and proceeds directly to draining
entity->job_queue and freeing the entity in drm_sched_entity_fini() while
drm_sched_run_job_work() is still running. Can this cause a use-after-free
and concurrent SPSC queue access on entity->job_queue?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020154123.3363=
1-1-tvrtko.ursulin@igalia.com?part=3D7
