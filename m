Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 343B8C624A4
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 08:47:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CD0F10E0BE;
	Thu,  3 Sep 2026 08:47:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="j06Z5HR1";
	dkim-atps=neutral
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5A8310E0BE
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 08:47:06 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hbCrl3Y6WzMl12;
 Thu, 03 Sep 2026 10:47:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1788425223; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lS9F4rIYBzfNdppMZK6a5Tt5Oo2fi4c7dvH/gWrs5Y8=;
 b=j06Z5HR18ok6cljzKmpyj8R96WwK0C9ecVQiUgpMeEodSP7loQlTVZmb4H/mXD2KfjZM2d
 m0gPY62S2Lhelr5zCtLVNXVln/+awPDBFkdBTkocAAxYw+5ueCP8rdbCvaXzA/xnqi2Pud
 8DnN69HVWG1r3iuakULyvou28s4KHPsa4NYMNI3whVAPE2Dfj2Z7jpyVlme+HekhvFdTC5
 w5aeFUIEWmcutSIv/VC0nkjhj25PhGOAAoFWvcl32a/4bKSFJu1V/E2Ul5ZEClKtUEkk/I
 71c1iEmDS+NPIlfHdfj6NZnq4YN88JkwgZLCbIyT7fqOLWVdlu+oy8sXJD9+xQ==
Message-ID: <611c2624e60ea422229e666480da3e504d126682.camel@mailbox.org>
Subject: Re: [PATCH v3 1/2] drm/sched: fix use-after-free of the fence
 timeline name
From: Philipp Stanner <phasta@mailbox.org>
To: "Jonghyuk Kim(MalHyuk)" <malhyuk97@gmail.com>, tursulin@ursulin.net, 
 phasta@kernel.org, matthew.brost@intel.com, dakr@kernel.org
Cc: christian.koenig@amd.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
Date: Thu, 03 Sep 2026 10:46:59 +0200
In-Reply-To: <20260902144204.1843670-2-malhyuk97@gmail.com>
References: <20260902144204.1843670-1-malhyuk97@gmail.com>
 <20260902144204.1843670-2-malhyuk97@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-META: id1up75im5je3bazaq1wc7qmnw9wsexp
X-MBO-RS-ID: f26dfd43d1bfa023aa0
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
Reply-To: phasta@kernel.org
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Wed, 2026-09-02 at 23:42 +0900, Jonghyuk Kim(MalHyuk) wrote:
>=20

[=E2=80=A6]

>=20
> The finished fence carried a .release callback solely to drop the
> scheduled fence's reference. That callback kept the ops attached, leaving
> get_timeline_name() reachable on a signalled finished fence with a
> dangling ->sched. Drop the callback and move the reference handling
> instead:
>=20
> =C2=A0- The scheduled fence now holds a reference on the finished fence, =
so
> =C2=A0=C2=A0 the finished fence, and with it the shared allocation, is re=
leased
> =C2=A0=C2=A0 last. Its release drops the parent fence and that finished-f=
ence
> =C2=A0=C2=A0 reference; the finished fence is then freed from dma_fence_f=
ree().

The backend doesn't know about this (admittedly weird) shared-
allocation phenomenon. I suppose the reason why we don't run into
double-free is that the scheduled-fence does still implement ops-
>release.

If that's the case, that needs to be documented in the code as a
groundlayer for future cleanups (I suppose we should eliminate that
shared allocation. If objects have distinct lifetimes, they should have
distinct memory. It was probably done like that so that drivers can
access both subfences through container_of()).

a la

"TODO: this release callback should be removed, too, but can't because
double-free"

> scheduler. Unlike caching the name string, this also covers drivers whose
> timeline name is dynamically allocated (drm/panthor, drm/xe).

It's good to have detailed commit messages, but I don't think hinting
at that alternative solution (caching), which we don't implement, is
necessary.

>=20

[=E2=80=A6]

> - it is the normal result for a foreign fence - and a signalled fence is
> an already-satisfied dependency, so the scheduler's dependency-collapsing
> optimisation is unaffected.
>=20

I don't understand this phrase. You're saying that someone trying to
register a dependency won't bother if he sees NULL?


>=20
>=20

[=E2=80=A6]

> =C2=A0
> -static void drm_sched_fence_free_rcu(struct rcu_head *rcu)
> -{
> -	struct dma_fence *f =3D container_of(rcu, struct dma_fence, rcu);
> -	struct drm_sched_fence *fence =3D to_drm_sched_fence(f);
> -
> -	if (!WARN_ON_ONCE(!fence))
> -		kmem_cache_free(sched_fence_slab, fence);
> -}
> -
> =C2=A0/**
> =C2=A0 * drm_sched_fence_free - free up an uninitialized fence
> =C2=A0 *
> @@ -132,21 +123,12 @@ static void drm_sched_fence_release_scheduled(struc=
t dma_fence *f)
> =C2=A0	struct drm_sched_fence *fence =3D to_drm_sched_fence(f);
> =C2=A0
> =C2=A0	dma_fence_put(fence->parent);
> -	call_rcu(&fence->finished.rcu, drm_sched_fence_free_rcu);

@Christian, Tvrtko, opinions on that?

> -}
> -
> -/**
> - * drm_sched_fence_release_finished - drop extra reference
> - *
> - * @f: fence
> - *
> - * Drop the extra reference from the scheduled fence to the base fence.
> - */
> -static void drm_sched_fence_release_finished(struct dma_fence *f)
> -{
> -	struct drm_sched_fence *fence =3D to_drm_sched_fence(f);
> -
> -	dma_fence_put(&fence->scheduled);
> +	/*
> +	 * Drop the reference the scheduled fence holds on the finished fence.
> +	 * The finished fence is released last and frees the shared allocation
> +	 * from its dma_fence_free() (see drm_sched_fence_init()).
> +	 */
> +	dma_fence_put(&fence->finished);
> =C2=A0}
> =C2=A0
> =C2=A0static void drm_sched_fence_set_deadline_finished(struct dma_fence =
*f,
> @@ -189,7 +171,13 @@ static const struct dma_fence_ops drm_sched_fence_op=
s_scheduled =3D {
> =C2=A0static const struct dma_fence_ops drm_sched_fence_ops_finished =3D =
{
> =C2=A0	.get_driver_name =3D drm_sched_fence_get_driver_name,
> =C2=A0	.get_timeline_name =3D drm_sched_fence_get_timeline_name,
> -	.release =3D drm_sched_fence_release_finished,
> +	/*
> +	 * No .release callback: dma_fence detaches ->ops on signalling for
> +	 * fences without .release/.wait, so get_timeline_name() is never calle=
d
> +	 * on a signalled finished fence and cannot dereference a freed
> +	 * scheduler. The shared allocation is freed from dma_fence_free() once
> +	 * this fence's refcount drops - it is released last, after @scheduled.
> +	 */

That comment is not necessary. The new code simply complies with the
current idiomatic fence design. Comments are necessary at tricky bits
or when one deviates from idiomatic usage.

> =C2=A0	.set_deadline =3D drm_sched_fence_set_deadline_finished,
> =C2=A0};
> =C2=A0
> @@ -233,6 +221,14 @@ void drm_sched_fence_init(struct drm_sched_fence *fe=
nce,
> =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &fence->lock, entity->fence_=
context, seq);
> =C2=A0	dma_fence_init(&fence->finished, &drm_sched_fence_ops_finished,
> =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &fence->lock, entity->fence_=
context + 1, seq);
> +
> +	/*
> +	 * Hold a reference on the finished fence from the scheduled fence, so
> +	 * the finished fence (and the shared allocation) outlives @scheduled.
> +	 * drm_sched_fence_release_scheduled() drops it; the finished fence is
> +	 * therefore released last and frees the allocation via dma_fence_free(=
).
> +	 */
> +	dma_fence_get(&fence->finished);

So what was the counter-part of this dma_fence_get() before?

> =C2=A0}
> =C2=A0
> =C2=A0module_init(drm_sched_fence_slab_init);
> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/sch=
eduler/sched_main.c
> index 6cb6f9546493..fb238f51c0ed 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -842,6 +842,15 @@ void drm_sched_job_cleanup(struct drm_sched_job *job=
)
> =C2=A0		 * been called.
> =C2=A0		 */
> =C2=A0		dma_fence_put(&job->s_fence->finished);
> +		/*
> +		 * Drop the initial reference on the scheduled fence. It no
> +		 * longer has a .release callback dropping it (the finished
> +		 * fence's .release was removed to allow ops-detach on signal),

Same as above, I think the comment should not focus on the past
situation. The past should be tracked by the commit message; a comment
should only mention the past if it's still relevant, for example to
solve an open TODO.

> +		 * so the last put here lets drm_sched_fence_release_scheduled()

Strictly speaking, you don't know whether it's the last put().
drm_sched_fence is a public object and drivers might have taken various
references.

> +		 * run, which drops @parent and the scheduled fence's reference
> +		 * on @finished. @finished is freed last, from dma_fence_free().

finished and scheduled would be freed through dma_fence_free()
simultaneously, since they still share the allocation.

I think the shared allocation and how things are freed should be
documented, but is drm_sched_job_cleanup() the right place?


> +		 */
> +		dma_fence_put(&job->s_fence->scheduled);
> =C2=A0		drm_sched_entity_stats_put(job->entity_stats);
> =C2=A0	} else {
> =C2=A0		/* The job was aborted before it has been committed to be run;
> diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
> index 7a64cc11de08..686c3687944f 100644
> --- a/include/drm/gpu_scheduler.h
> +++ b/include/drm/gpu_scheduler.h
> @@ -287,48 +287,58 @@ struct drm_sched_rq {
> =C2=A0 * struct drm_sched_fence - fences corresponding to the scheduling =
of a job.
> =C2=A0 */
> =C2=A0struct drm_sched_fence {
>=20

[=E2=80=A6]

> =C2=A0	struct dma_fence		finished;
> =C2=A0
> +	/**
> +	 * @scheduled: this fence is what will be signaled by the scheduler
> +	 * when the job is scheduled.
> +	 *
> +	 * It holds a reference on @finished so that the shared allocation is
> +	 * released only after @scheduled itself is done; its release drops

Won't it drop the endire drm_sched_fence?

I think this struct's documentation is the right place to document the
life time and allocation pattern, together with maybe the relevant
places in sched_fence.c

Then you could be a bit less verbose in the other code places; see
above.

> +	 * that reference and the @parent one.
> +	 */
> +	struct dma_fence		scheduled;
> +
> =C2=A0	/**
> =C2=A0	 * @deadline: deadline set on &drm_sched_fence.finished which
> =C2=A0	 * potentially needs to be propagated to &drm_sched_fence.parent
> =C2=A0	 */
> =C2=A0	ktime_t				deadline;
> =C2=A0
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /**
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * @parent: the fence re=
turned by &drm_sched_backend_ops.run_job
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * when scheduling the j=
ob on hardware. We signal the
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * &drm_sched_fence.fini=
shed fence once parent is signalled.
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> +	/**
> +	 * @parent: the fence returned by &drm_sched_backend_ops.run_job
> +	 * when scheduling the job on hardware. We signal the
> +	 * &drm_sched_fence.finished fence once parent is signalled.
> +	 */
> =C2=A0	struct dma_fence		*parent;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /**
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * @sched: the scheduler=
 instance to which the job having this struct
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * belongs to.
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> +	/**
> +	 * @sched: the scheduler instance to which the job having this struct
> +	 * belongs to.
> +	 */
> =C2=A0	struct drm_gpu_scheduler	*sched;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /**
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * @lock: the lock used =
by the scheduled and the finished fences.
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> +	/**
> +	 * @lock: the lock used by the scheduled and the finished fences.
> +	 */
> =C2=A0	spinlock_t			lock;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /**
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * @owner: job owner for=
 debugging
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> +	/**
> +	 * @owner: job owner for debugging
> +	 */
> =C2=A0	void				*owner;

Formatting fixes in a separate patch please, unless you need to modify
those lines for semantically related reasons.


Thanks
P.
