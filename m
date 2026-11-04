Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4913C606A33B
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 10:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d1q5fAtP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B196710FAB1;
	Wed,  4 Nov 2026 10:07:39 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4519110FAE7
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 10:07:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8967E60D85;
 Wed,  4 Nov 2026 10:07:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 266FB1F0093A;
 Wed,  4 Nov 2026 10:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793786852;
 bh=r06LotvDIMiygRoahVavVBvpQGNoYXXsdA4FoVx1ygc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=d1q5fAtPR11X6N6aL+NIXwJS9P3jkojBErjZVXPw2xT9/dHEh7M/HFYd317CO2JBX
 wDVbDzmuLOOkuj6VjEQXDL5Lpi7MtCLhau5HBB98RZw0WaJKx7xoe8bJZn0H7XVX0G
 XoPZX4DEAuIuqvha0xvj59JcxW+pVVrQASWU8Ib/FQZcPqc7uV9YZ020IrbLxFCBb6
 JJNn3vrldEqyOdu7G2fGSThrn5tAQFODIeJxkZrPNYWYQ6XqxdroCAp+3kxmlNh7/e
 bvmvsbBSo5vkZWygvTRWUH9RVJYQYNtHzTJhA+vc475U4SZUCgrpTQ9PKNSvmroAT6
 /6BDqwufAaVSg==
Message-ID: <sashiko-outbox-197043@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 6/6] drm/panthor: Create per queue priority workqueues
To: "Tvrtko Ursulin" <tvrtko.ursulin@igalia.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261104095225.32654-7-tvrtko.ursulin@igalia.com>
References: <20261104095225.32654-1-tvrtko.ursulin@igalia.com>
 <20261104095225.32654-7-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 10:07:31 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] drm/panthor: per-priority unbound submit_wq in panthor_sched_ini=
t() stalls on sched->lock and preempts tick_work()
- [Low] drm/panthor: dead submit_wq init and redundant check in group_creat=
e_queue()
--

commit f453c56b36202882aec84caf56004a890024791a
Author: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

drm/panthor: Create per queue priority workqueues

This commit splits the single workqueue shared between the Panthor driver's
internal scheduler logic and the DRM scheduler into separate per-priority
DRM scheduler submit workqueues.

> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/pa=
nthor/panthor_sched.c
> index a343c5180e01e..cbff37e5e1d1c 100644
> --- a/drivers/gpu/drm/panthor/panthor_sched.c
> +++ b/drivers/gpu/drm/panthor/panthor_sched.c
> @@ -153,11 +153,18 @@ struct panthor_scheduler {
>  	 *
>  	 * Used for the scheduler tick, group update or other kind of FW
>  	 * event processing that can't be handled in the threaded interrupt
> -	 * path. Also passed to the drm_gpu_scheduler instances embedded
> -	 * in panthor_queue.
> +	 * path.
>  	 */
>  	struct workqueue_struct *wq;
> =20
> +	/**
> +	 * @submit_wq: Per priority workqueues for the DRM scheduler
> +	 *
> +	 * Passed to the drm_gpu_scheduler instances embedded
> +	 * in panthor_queue based on the queue priority.
> +	 */
> +	struct workqueue_struct *submit_wq[PANTHOR_CSG_PRIORITY_COUNT];
> +
>  	/**
>  	 * @heap_alloc_wq: Workqueue used to schedule tiler_oom works.
>  	 *
> @@ -3572,8 +3579,14 @@ group_create_queue(struct panthor_group *group,
>  		goto err_free_queue;
>  	}
> =20
> -	sched_args.name =3D queue->name;
> +	if (group->priority >=3D ARRAY_SIZE(group->ptdev->scheduler->submit_wq)=
 ||
> +	    !group->ptdev->scheduler->submit_wq[group->priority]) {
> +		ret =3D -EINVAL;
> +		goto err_free_queue;
> +	}
> =20
> +	sched_args.name =3D queue->name;
> +	sched_args.submit_wq =3D group->ptdev->scheduler->submit_wq[group->prio=
rity];
>  	ret =3D drm_sched_init(&queue->scheduler, &sched_args);
>  	if (ret)
>  		goto err_free_queue;

[Severity: Low]
As reported by Tejun Heo on RFC v6 [1], this isn't a bug, but
group_create_queue() still initializes sched_args.submit_wq at the top of
the function before overwriting it here:

drivers/gpu/drm/panthor/panthor_sched.c:group_create_queue() {
	struct drm_sched_init_args sched_args =3D {
		.ops =3D &panthor_queue_sched_ops,
		.submit_wq =3D group->ptdev->scheduler->wq,
		...
	};
}

Similarly, the kernel-doc summary line for panthor_scheduler::wq still says
it is used by drm_gpu_scheduler.

In addition, can the bounds and NULL check on group->priority and
group->ptdev->scheduler->submit_wq[group->priority] in group_create_queue()
ever trigger? Its caller panthor_group_create() already rejects
group_args->priority >=3D PANTHOR_CSG_PRIORITY_COUNT, and panthor_sched_ini=
t()
populates all PANTHOR_CSG_PRIORITY_COUNT entries or fails initialization.

Finally, the commit message mentions WQ_RTPRI ("high is server by a
WQ_HIGHPRI instance, while realtime GPU priority is using the newly added
WQ_RTPRI flag"), whereas the flag used in panthor_sched_init() is WQ_RT.
Should those be cleaned up?

[ ... ]

> @@ -4172,7 +4194,14 @@ int panthor_sched_init(struct panthor_device *ptde=
v)
>  	 */
>  	sched->heap_alloc_wq =3D alloc_workqueue("panthor-heap-alloc", WQ_UNBOU=
ND, 0);
>  	sched->wq =3D alloc_workqueue("panthor-csf-sched", WQ_MEM_RECLAIM | WQ_=
UNBOUND, 0);
> -	if (!sched->wq || !sched->heap_alloc_wq) {
> +	sched->submit_wq[PANTHOR_CSG_PRIORITY_MEDIUM] =3D alloc_workqueue("pant=
hor-drm", WQ_MEM_RECLAIM | WQ_UNBOUND, 2);
> +	sched->submit_wq[PANTHOR_CSG_PRIORITY_LOW] =3D sched->submit_wq[PANTHOR=
_CSG_PRIORITY_MEDIUM];
> +	sched->submit_wq[PANTHOR_CSG_PRIORITY_HIGH] =3D alloc_workqueue("pantho=
r-drm-high", WQ_HIGHPRI | WQ_MEM_RECLAIM | WQ_UNBOUND, 2);
> +	sched->submit_wq[PANTHOR_CSG_PRIORITY_RT] =3D alloc_workqueue("panthor-=
drm-rt", WQ_RT | WQ_MEM_RECLAIM | WQ_UNBOUND, 2);
> +	if (!sched->wq || !sched->heap_alloc_wq ||
> +	    !sched->submit_wq[PANTHOR_CSG_PRIORITY_MEDIUM] ||
> +	    !sched->submit_wq[PANTHOR_CSG_PRIORITY_HIGH] ||
> +	    !sched->submit_wq[PANTHOR_CSG_PRIORITY_RT]) {
>  		panthor_sched_fini(&ptdev->base, sched);
>  		drm_err(&ptdev->base, "Failed to allocate the workqueues");
>  		return -ENOMEM;

[Severity: Medium]
As reported by Tejun Heo on RFC v6 [2], for a WQ_UNBOUND workqueue,
max_active applies across the entire workqueue rather than per CPU. Since
panthor_sched_init() allocates each submit_wq with WQ_UNBOUND and
max_active =3D 2 (whereas sched->wq previously used max_active =3D 0), and
group_create_queue() shares that submit_wq across all queues of a given
priority on the device for both drm_gpu_scheduler::work_run_job and
drm_gpu_scheduler::work_free_job, could two in-flight queue_run_job() calls
stalling on sched->lock block all other queues at that priority?

Specifically, in queue_run_job():

drivers/gpu/drm/panthor/panthor_sched.c:queue_run_job() {
	...
	ret =3D panthor_device_resume_and_get(ptdev);
	if (drm_WARN_ON(&ptdev->base, ret))
		return ERR_PTR(ret);

	mutex_lock(&sched->lock);
	...
}

tick_work() holds sched->lock across firmware round-trip waits in
csgs_upd_ctx_apply_locked(). When two queue_run_job() work items block on
sched->lock (or runtime PM resume), no other work_run_job (including
sync-only jobs with !job->call_info.size that do not take sched->lock) or
work_free_job (queue_free_job()) on that submit_wq can run. Because
submit_wq[PANTHOR_CSG_PRIORITY_LOW] aliases
submit_wq[PANTHOR_CSG_PRIORITY_MEDIUM], two blocked LOW-priority jobs will
also stall MEDIUM-priority job submissions and job completions.

Furthermore, because submit_wq[PANTHOR_CSG_PRIORITY_RT] is allocated with
WQ_RT while panthor_scheduler::wq (which runs tick_work and sync_upd_work)
remains a regular-priority workqueue, can a busy RT submission context
preempt tick_work() on sched->wq and prevent time-slicing and fairness
rotation between RT groups?

[1] https://lore.kernel.org/r/64d59ed5538c6af257058533c880740e@kernel.org
[2] https://lore.kernel.org/r/64d59ed5538c6af257058533c880740e@kernel.org

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104095225.3265=
4-1-tvrtko.ursulin@igalia.com?part=3D6
