Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FC34C43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 09:52:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D05A410EBE7;
	Tue, 30 Jun 2026 09:52:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MMInsXTk";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B672710EBE7
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 09:52:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 863E5401FD;
 Tue, 30 Jun 2026 09:52:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 498D61F000E9;
 Tue, 30 Jun 2026 09:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782813136;
 bh=qRdAQnXxxkeW+pfJh57qAy3+W1XvFdeRK2VEEenNHkw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=MMInsXTkjXTgA38GgBuhZtrJLXsidr9DgWXnvBup/mDmm8fTZsWGw/KnqVCvq7aho
 pat05uI3AQ9TLD/s8jLWySBs+av5KBtHhICBoSEMoA4x9x/AbIicqWYzDdGzbAqhNm
 1eGdHeWk8yMqjtsX0vYVLdzeo9nASfovvxI1aVjYwHcPLz88WtQPEKpmPiu3NfrKFv
 Ee3zK4T/ECQwZBFXNL5dw4AD2N1nLNgmx01q2x/S6DtozFzniNThH9bPinryKkpHnm
 3guD/2eYcwg4RaJdMVf68qDMNsGg8YXLkECOpl3PpDutcIgTiRX6ecNhmWOWuhrRmP
 oraTXCbb8YO1A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5] drm/imagination: Fix double call to
 drm_sched_entity_fini()
To: "Brajesh Gupta" <brajesh.gupta@imgtec.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260630-b4-sched_fix-v5-1-2a84cbf18bfe@imgtec.com>
References: <20260630-b4-sched_fix-v5-1-2a84cbf18bfe@imgtec.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 09:52:15 +0000
Message-Id: <20260630095216.498D61F000E9@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Exposing a partially initialized context via `xa_alloc` allows=
 concurrent destruction, leading to a NULL pointer dereference or Use-After=
-Free.
- [Critical] Concurrent execution of `pvr_submit_jobs` and `pvr_context_des=
troy` leads to leaked jobs, contexts, and Use-After-Free vulnerabilities.
- [High] Use-After-Free of `ctx->fw_obj` in the `pvr_context_create` error =
path when `xa_alloc` fails.
- [High] ABBA deadlock between pvr_queue_device_pre_reset() and the DRM sch=
eduler run job worker.
--

commit 98944fa2f1c44497ea7e4317dca4599e33e19c35
Author: Brajesh Gupta <brajesh.gupta@imgtec.com>

drm/imagination: Fix double call to drm_sched_entity_fini()

This commit prevents a double call to drm_sched_entity_fini() during contex=
t=20
destruction by only calling it in the pvr_context_create() failure path. Th=
e=20
prior logic incorrectly triggered entity destruction from both pvr_queue_ki=
ll()=20
and pvr_queue_destroy().

> diff --git a/drivers/gpu/drm/imagination/pvr_context.c b/drivers/gpu/drm/=
imagination/pvr_context.c
> index eba4694400b5a..b6f9e078315dc 100644
> --- a/drivers/gpu/drm/imagination/pvr_context.c
> +++ b/drivers/gpu/drm/imagination/pvr_context.c
[ ... ]
> @@ -349,7 +351,7 @@ int pvr_context_create(struct pvr_file *pvr_file, str=
uct drm_pvr_ioctl_create_co
>  	pvr_fw_object_destroy(ctx->fw_obj);
> =20
>  err_destroy_queues:
> -	pvr_context_destroy_queues(ctx);
> +	pvr_context_destroy_queues(ctx, true);

[Severity: High]
This is a pre-existing issue, but does this error path lead to a use-after-=
free
if context handles or memory are exhausted?

If xa_alloc() fails earlier in pvr_context_create(), the error path jumps to
err_destroy_fw_obj, which calls pvr_fw_object_destroy(ctx->fw_obj). This fr=
ees
the firmware object but leaves the pointer in ctx->fw_obj intact.

Execution then falls through to err_destroy_queues, which calls
pvr_context_destroy_queues() -> pvr_queue_destroy() ->=20
pvr_queue_cleanup_fw_context().

Since queue->ctx->fw_obj is non-NULL, pvr_queue_cleanup_fw_context() will c=
all
pvr_fw_structure_cleanup() on the already-freed pointer, causing a=20
use-after-free:

drivers/gpu/drm/imagination/pvr_queue.c:pvr_queue_cleanup_fw_context() {
	if (!queue->ctx->fw_obj)
		return 0;

	return pvr_fw_structure_cleanup(queue->ctx->pvr_dev, ...);
}

Could ctx->fw_obj be set to NULL after destruction, or could this cleanup l=
ogic
be restructured to avoid accessing the freed pointer?

[Severity: Critical]
This is also a pre-existing issue, but does the successful creation path
expose a partially initialized context to userspace?

In pvr_context_create(), after successfully allocating a handle via xa_allo=
c(),
the context handle is immediately visible to userspace:

drivers/gpu/drm/imagination/pvr_context.c:pvr_context_create() {
	err =3D xa_alloc(&pvr_file->ctx_handles, &args->handle, ctx,
                       xa_limit_32b, GFP_KERNEL);
	if (err)
		goto err_destroy_fw_obj;

	spin_lock(&pvr_dev->ctx_list_lock);
	list_add_tail(&ctx->file_link, &pvr_file->contexts);
    ...
}

If a concurrent thread guesses the newly allocated handle and calls
pvr_ioctl_destroy_context() before list_add_tail() completes, it will
find the context, remove it, and drop its reference. This triggers
pvr_context_release(), which calls list_del(&ctx->file_link). Since
ctx->file_link is still NULL, this dereferences a NULL pointer.

If list debugging catches it, the original thread might still access
the freed context to add it to the list, leading to a use-after-free.

Should the context be fully initialized and added to the list before it
is exposed via xa_alloc()?

> =20
>  err_free_ctx_id:
>  	/*
[ ... ]
> @@ -384,7 +386,7 @@ pvr_context_release(struct kref *ref_count)
>  	spin_unlock(&pvr_dev->ctx_list_lock);
> =20
>  	xa_erase(&pvr_dev->ctx_ids, ctx->ctx_id);
> -	pvr_context_destroy_queues(ctx);
> +	pvr_context_destroy_queues(ctx, false);
>  	pvr_fw_object_destroy(ctx->fw_obj);
>  	kfree(ctx->data);
>  	pvr_vm_context_put(ctx->vm_ctx);
> diff --git a/drivers/gpu/drm/imagination/pvr_queue.c b/drivers/gpu/drm/im=
agination/pvr_queue.c
> index 7ed60e1c1a866..941c017399fc3 100644
> --- a/drivers/gpu/drm/imagination/pvr_queue.c
> +++ b/drivers/gpu/drm/imagination/pvr_queue.c
[ ... ]
> @@ -1439,11 +1439,12 @@ void pvr_queue_kill(struct pvr_queue *queue)
>  /**
>   * pvr_queue_destroy() - Destroy a queue.
>   * @queue: The queue to destroy.
> + * @cleanup_queue_entity: Whether to cleanup the queue entity.
>   *
>   * Cleanup the queue and free the resources attached to it. Should be
>   * called from the context release function.
>   */
> -void pvr_queue_destroy(struct pvr_queue *queue)
> +void pvr_queue_destroy(struct pvr_queue *queue, bool cleanup_queue_entit=
y)
>  {
>  	if (!queue)
>  		return;
> @@ -1453,7 +1454,8 @@ void pvr_queue_destroy(struct pvr_queue *queue)
>  	mutex_unlock(&queue->ctx->pvr_dev->queues.lock);

[Severity: High]
This is a pre-existing issue, but does taking pvr_dev->queues.lock here or
during GPU reset risk a deadlock with the scheduler's run job worker?

During a GPU reset, pvr_queue_device_pre_reset() takes queues.lock and
then calls pvr_queue_stop() -> drm_sched_stop() -> drm_sched_wqueue_stop(),
which waits for the currently executing scheduler job to finish:

drivers/gpu/drm/imagination/pvr_queue.c:pvr_queue_device_pre_reset() {
	mutex_lock(&pvr_dev->queues.lock);
	list_for_each_entry(queue, &pvr_dev->queues.idle, node)
		pvr_queue_stop(queue, NULL);
    ...
}

Concurrently, if the scheduler is executing drm_sched_run_job_work() ->
pvr_queue_run_job() -> pvr_queue_submit_job_to_cccb() ->
pvr_queue_update_active_state(), it will try to acquire the same queues.loc=
k:

drivers/gpu/drm/imagination/pvr_queue.c:pvr_queue_update_active_state() {
	mutex_lock(&pvr_dev->queues.lock);
	pvr_queue_update_active_state_locked(queue);
	mutex_unlock(&pvr_dev->queues.lock);
}

This creates a scenario where the reset path holds queues.lock and waits for
the job worker to finish, while the job worker is blocked trying to acquire
queues.lock. Can this deadlock be avoided?

> =20
>  	drm_sched_fini(&queue->scheduler);
> -	drm_sched_entity_fini(&queue->entity);
> +	if (cleanup_queue_entity)
> +		drm_sched_entity_fini(&queue->entity);

[Severity: Critical]
This isn't a bug introduced by this patch, but does killing the queue entity
early lead to leaked jobs and a use-after-free if jobs are still being push=
ed?

In pvr_context_destroy(), if another thread is simultaneously executing
pvr_submit_jobs(), it might hold a valid reference to the context. However,
pvr_context_destroy() calls pvr_context_kill_queues(), which forcibly destr=
oys
the scheduler entity before the context is actually released:

drivers/gpu/drm/imagination/pvr_context.c:pvr_context_destroy() {
	pvr_context_kill_queues(ctx);

	/* Release the reference held by the handle set. */
	pvr_context_put(ctx);
}

This destroys the DRM scheduler entity via drm_sched_entity_destroy(), which
also frees entity->stats.

Meanwhile, the concurrent thread in pvr_submit_jobs() can proceed to push j=
obs
to this destroyed entity:

drivers/gpu/drm/imagination/pvr_job.c:pvr_submit_jobs() {
    ...
	for (i =3D 0; i < args->jobs_count; i++) {
		pvr_queue_job_arm(jobs[i]);
	}
    ...
}

pvr_queue_job_arm() -> drm_sched_job_arm() will access the freed entity->st=
ats
via drm_sched_entity_stats_get(), causing a use-after-free. Additionally, t=
he
pushed jobs are permanently leaked, which in turn leaks the context they ho=
ld a
reference to.

Should the entity destruction be deferred until the context reference count
reaches zero?

> =20
>  	if (WARN_ON(queue->last_queued_job_scheduled_fence))
>  		dma_fence_put(queue->last_queued_job_scheduled_fence);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630-b4-sched_f=
ix-v5-1-2a84cbf18bfe@imgtec.com?part=3D1
