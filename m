Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1536606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 11:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gNbwI+mJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41DE8112525;
	Thu, 22 Oct 2026 11:12:18 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 009B4112522
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 11:12:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D9E896057A;
 Thu, 22 Oct 2026 11:12:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EC6D1F000C6;
 Thu, 22 Oct 2026 11:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792667530;
 bh=1ywc/Lbb1Z7vmXBBab6218r/4CEsw2WaCdC0ezvFtj4=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=gNbwI+mJn8YtgnegL+AyrkQxpfcmBI/93dF0IcFbQV8/gWokDqVZBDq4akaMnObsy
 d45zyg09i+OtuTR3Tx4V2WKJnbllTDp3bE/GARZo1LOKr1wQFIEBX7mY7fBxj4hRYr
 0cGWEnhaMUg0l6/vjZCUSb6Osi3wm9c9V8trvFJLW7+h5RH2PaCbVZTrPpHwFXABmy
 q3ypeoRYcCBHspYb+N7qMNd/Wg7HuU5yby8tEWcerhk5W9umtCudoFEK4WI0HLiVzJ
 np74n616ZYKtp/hHLFD4Z3HsyWtYHJadcQjTq9Cv+Sfw9IEqsAf+3GKovJJ8REmQX/
 e1rp0iFxZ6N6Q==
Message-ID: <sashiko-outbox-181358@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/scheduler: signal fences of jobs pushed to a
 stopped entity
To: "Olivier Kaloudoff" <olivier.kaloudoff@gmail.com>,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20261022105454.60267-1-olivier.kaloudoff@gmail.com>
References: <20261022105454.60267-1-olivier.kaloudoff@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 11:12:09 +0000
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] drm/sched: out-of-order fence signaling in drm_sched_entity_pu=
sh_job()
--

commit 94b284ecd7cfe529710e74fba166d9065b9197ff
Author: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>

drm/scheduler: signal fences of jobs pushed to a stopped entity

This commit checks entity->stopped under entity->lock in
drm_sched_entity_push_job() before pushing a job to the entity queue. When
the entity is stopped, it decrements the scheduler score and schedules
drm_sched_entity_kill_jobs_work() to signal the job fences.

> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/s=
cheduler/sched_entity.c
> index 7be0387bac3ce..37adb82292088 100644
> --- a/drivers/gpu/drm/scheduler/sched_entity.c
> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
> @@ -644,6 +644,27 @@ void drm_sched_entity_push_job(struct drm_sched_job =
*sched_job)
> =20
>  	spin_lock(&entity->lock);
> =20
> +	/*
> +	 * A stopped entity is never put back on a run queue, so a job
> +	 * queued on it would be stranded forever and its fences would
> +	 * never signal, hanging any task waiting on them. Don't queue
> +	 * the job at all; run the normal kill-jobs work on it so its
> +	 * finished fence completes with -ESRCH.
> +	 */
> +	if (unlikely(entity->stopped)) {
> +		spin_unlock(&entity->lock);
> +		/*
> +		 * Balance the atomic_inc(&sched->score) above; the
> +		 * decrement in drm_sched_job_done() only happens when
> +		 * the job actually runs on a scheduler.
> +		 */
> +		atomic_dec(entity->rq->sched->score);
> +		DRM_ERROR("Trying to push to a killed entity\n");
> +		INIT_WORK(&sched_job->work, drm_sched_entity_kill_jobs_work);
> +		schedule_work(&sched_job->work);
> +		return;
> +	}
> +
>  	first =3D spsc_queue_push(&entity->job_queue, &sched_job->queue_node);
> =20
>  	/* first job wakes up scheduler */

[Severity: Critical]
Can scheduling drm_sched_entity_kill_jobs_work() directly here cause
s_fence->scheduled and s_fence->finished to signal out of order relative to
earlier jobs on the same entity?

Before calling drm_sched_entity_push_job(), the caller arms the job via
drm_sched_job_arm() -> drm_sched_fence_init(), which assigns the next
sequence number on entity->fence_context and entity->fence_context + 1.

In drivers/gpu/drm/scheduler/sched_entity.c:drm_sched_entity_kill(), after
setting entity->stopped =3D true, the function waits for entity->entity_idle
and chains each drained job behind entity->last_scheduled and prior queued
jobs:

	spin_lock(&entity->lock);
	entity->stopped =3D true;
	drm_sched_rq_remove_entity(entity->rq, entity);
	spin_unlock(&entity->lock);

	/* Make sure this entity is not used by the scheduler at the moment */
	wait_for_completion(&entity->entity_idle);

	spin_lock(&entity->lock);
	prev =3D dma_fence_get(entity->last_scheduled);
	spin_unlock(&entity->lock);
	while ((job =3D drm_sched_entity_queue_pop(entity))) {
		struct drm_sched_fence *s_fence =3D job->s_fence;

		dma_fence_get(&s_fence->finished);
		if (!prev ||
		    dma_fence_add_callback(prev, &job->finish_cb,
					   drm_sched_entity_kill_jobs_cb)) {
			...
			drm_sched_entity_kill_jobs_cb(NULL, &job->finish_cb);
		}

		prev =3D &s_fence->finished;
	}
	dma_fence_put(prev);

In contrast, when drm_sched_entity_push_job() sees entity->stopped, it
immediately schedules drm_sched_entity_kill_jobs_work() without waiting for
entity->entity_idle, entity->last_scheduled, or the tail of the chain in
drm_sched_entity_kill() (which is only kept in the local variable prev).

Since drm_sched_entity_kill_jobs_work() only waits on fences in
sched_job->dependencies, and jobs on the same entity normally rely on the
entity queue for ordering rather than explicit same-entity dependencies,
this job's fences can signal while an earlier job from the same entity is
still executing on the hardware.

For example, drivers/dma-buf/dma-resv.c:dma_resv_add_fence() replaces an
earlier unsignaled fence from the same context when a later sequence number
is added:

	for (i =3D 0; i < count; ++i) {
		enum dma_resv_usage old_usage;

		dma_resv_list_entry(fobj, i, obj, &old, &old_usage);
		if ((old->context =3D=3D fence->context && old_usage >=3D usage &&
		     dma_fence_is_later_or_same(fence, old)) ||
		    dma_fence_is_signaled(old)) {
			dma_resv_list_set(fobj, i, fence, usage);
			dma_fence_put(old);
			return;
		}
	}

Similarly, in the amdkfd migration path
svm_migrate_vma_to_ram() -> svm_migrate_copy_memory_gart() in
drivers/gpu/drm/amd/amdkfd/kfd_migrate.c, multiple copy jobs are submitted
to the same entity and *mfence is overwritten with the latest job's fence:

		r =3D amdgpu_copy_buffer(adev, entity,
				       gart_s, gart_d, size * PAGE_SIZE,
				       NULL, &next, true, 0);
		if (r) {
			dev_err(adev->dev, "fail %d to copy memory\n", r);
			goto out_unlock;
		}

		dma_fence_put(*mfence);
		*mfence =3D next;

If the entity is killed while an earlier job is still in flight and a
subsequent job hits the entity->stopped path in drm_sched_entity_push_job(),
wouldn't the later job's fence signal first and cause callers waiting on
*mfence or dma_resv to unmap and free memory while the earlier job is still
accessing it?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022105454.6026=
7-1-olivier.kaloudoff@gmail.com?part=3D1
