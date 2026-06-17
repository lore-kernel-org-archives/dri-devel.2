Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A965CD98E2
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 08:38:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C74F110EEC3;
	Wed, 17 Jun 2026 08:38:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="IKmQ/iPT";
	dkim-atps=neutral
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C77E910EEC3;
 Wed, 17 Jun 2026 08:38:09 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4ggHLQ6XWkz9tg3;
 Wed, 17 Jun 2026 10:38:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1781685486; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=spD7pjCIO/hnKowBxoDw0tQ702lZ3aup/LHEUbJfgM0=;
 b=IKmQ/iPT1RlaFXfDrJ/ESycocbU6Sfz4+BK4GpAZn3JoOKlisRysjWDmkvZQPlFk/96oD4
 cD2fxAHg5dlSEy3RdbXqTSaIQyNQQ6F9/eBu9jPxNELXHrJmW1Qj4cOFRHEYrWZEbslFfr
 +NSVMK/cDQ0Aoee2n1xL3nySoFrz9XNZ4Kn/8TpBj0JB3CxvhJW9aqvdq4II0dD0HKxW33
 zRzWqKmG4unkLMuzrKlpOXJeZTkO6eWdNItAWraLjQnlPv3oFDlebsTpQtI+fjM2+KYLXq
 t7OpmD5/ORVLxRbj2bIkgKKL4bGbV/NiJV2RQLcBb5YTB7B7RxLCPy98HbvBFg==
Message-ID: <ba8ea856526d54753da68deefe7b77f15c908fa3.camel@mailbox.org>
Subject: Re: [RFC] drm/sched: Replace completion with a flush
From: Philipp Stanner <phasta@mailbox.org>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
 dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Christian =?ISO-8859-1?Q?K=F6nig?=	
 <christian.koenig@amd.com>, Danilo Krummrich <dakr@kernel.org>, Matthew
 Brost	 <matthew.brost@intel.com>, Philipp Stanner <phasta@kernel.org>, 
 amd-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org
Date: Wed, 17 Jun 2026 10:38:01 +0200
In-Reply-To: <20260611123423.39819-1-tvrtko.ursulin@igalia.com>
References: <20260611123423.39819-1-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-ID: 2c5b219a17c02acc025
X-MBO-RS-META: e1ogaqb1yr7qkmooe7gtbm1jioff1nt6
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

On Thu, 2026-06-11 at 13:34 +0100, Tvrtko Ursulin wrote:
> Due the scheduler locking design, and the inability to always lock both
> the entity and the run-queue in the consistent order, a completion exists
> which effectively marks the entity as in use from a call path which is no=
t
> able to lock it.
>=20
> When entity is selected from the run job worker, its completion is marked
> as non-idle all until the code is sure it will not be dereferencing it an=
y
> more, at which point it signals it as idle, releasing the potential
> parallel cleanup path.
>=20
> We can remove the need for this completion by implementing the identical
> guarantee by simply flushing the run job work from the cleanup path, afte=
r
> having removed the entity from the run queue.
>=20
> We then know that the entity is no longer reachable by the run queue
> selection logic, so as soon as any pending work is done the cleanup can
> safely proceed. And because we have marked the entity as stopped, we also
> know that the entity cannot re-enter the run queue.
>=20
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Philipp Stanner <phasta@kernel.org>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: intel-xe@lists.freedesktop.org
> ---
> "Perfection is achieved, not when there is nothing more to add, but when
> =C2=A0there is nothing left to take away." - Antoine de Saint-Exup=C3=A9r=
y


Hmm, alright, so the basic trick just seems to be that the workqueue
implementation already can ensure the synchronization which we manually
implemented so far through the completion.


It's a bit more LOC, and doesn't solve a bug. However, I kind of like
the idea because it removes a redundant mechanism. Would be cool to
hear some other opinions, though.

A comment below

>=20
> Lets see what Intel's CI says about this, not to mention our new AI
> overlords...
> ---
> =C2=A0drivers/gpu/drm/scheduler/sched_entity.c=C2=A0=C2=A0 | 25 +++++++++=
++++++-------
> =C2=A0drivers/gpu/drm/scheduler/sched_internal.h | 14 ++++++++++--
> =C2=A0drivers/gpu/drm/scheduler/sched_main.c=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0 2 --
> =C2=A0drivers/gpu/drm/scheduler/sched_rq.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 14 +++++++-----
> =C2=A0include/drm/gpu_scheduler.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 9 --------
> =C2=A05 files changed, 38 insertions(+), 26 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/s=
cheduler/sched_entity.c
> index c51101ec70c1..e6f7c2fbefce 100644
> --- a/drivers/gpu/drm/scheduler/sched_entity.c
> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
> @@ -137,10 +137,6 @@ int drm_sched_entity_init(struct drm_sched_entity *e=
ntity,
> =C2=A0	entity->rq =3D &sched_list[0]->rq;
> =C2=A0	RCU_INIT_POINTER(entity->last_scheduled, NULL);
> =C2=A0	RB_CLEAR_NODE(&entity->rb_tree_node);
> -	init_completion(&entity->entity_idle);
> -
> -	/* We start in an idle state. */
> -	complete_all(&entity->entity_idle);
> =C2=A0
> =C2=A0	spin_lock_init(&entity->lock);
> =C2=A0	spsc_queue_init(&entity->job_queue);
> @@ -276,18 +272,24 @@ static void drm_sched_entity_kill_jobs_cb(struct dm=
a_fence *f,
> =C2=A0 */
> =C2=A0void drm_sched_entity_kill(struct drm_sched_entity *entity)
> =C2=A0{
> +	struct drm_gpu_scheduler *sched;
> =C2=A0	struct drm_sched_job *job;
> =C2=A0	struct dma_fence *prev;
> =C2=A0
> =C2=A0	spin_lock(&entity->lock);
> =C2=A0	entity->stopped =3D true;
> -	drm_sched_rq_remove_entity(entity->rq, entity);
> +	sched =3D drm_sched_rq_remove_entity(entity->rq, entity);
> =C2=A0	spin_unlock(&entity->lock);
> =C2=A0
> -	/* Make sure this entity is not used by the scheduler at the moment */
> -	wait_for_completion(&entity->entity_idle);
> +	/*
> +	 * Make sure this entity is not used by the scheduler at the moment.
> +	 *
> +	 * Scheduler is guaranteed to be stable after the entity was stopped an=
d
> +	 * removed from the run-queue.
> +	 */
> +	if (sched)
> +		drm_sched_flush_run_work(sched);
> =C2=A0
> -	/* The entity is guaranteed to not be used by the scheduler */
> =C2=A0	prev =3D rcu_dereference_check(entity->last_scheduled, true);
> =C2=A0	dma_fence_get(prev);
> =C2=A0	while ((job =3D drm_sched_entity_queue_pop(entity))) {
> @@ -576,6 +578,13 @@ void drm_sched_entity_select_rq(struct drm_sched_ent=
ity *entity)
> =C2=A0		return;
> =C2=A0
> =C2=A0	spin_lock(&entity->lock);
> +
> +	if (entity->stopped) {
> +		spin_unlock(&entity->lock);
> +		return;
> +
> +	}

Seems unrelated? Why wasn't this needed semantically before?

> +
> =C2=A0	sched =3D drm_sched_pick_best(entity->sched_list, entity->num_sche=
d_list);
> =C2=A0	rq =3D sched ? &sched->rq : NULL;
> =C2=A0	if (rq !=3D entity->rq) {
> diff --git a/drivers/gpu/drm/scheduler/sched_internal.h b/drivers/gpu/drm=
/scheduler/sched_internal.h
> index 13ecb771d7a2..80dece3be415 100644
> --- a/drivers/gpu/drm/scheduler/sched_internal.h
> +++ b/drivers/gpu/drm/scheduler/sched_internal.h
> @@ -35,12 +35,22 @@ bool drm_sched_can_queue(struct drm_gpu_scheduler *sc=
hed,
> =C2=A0			 struct drm_sched_entity *entity);
> =C2=A0void drm_sched_wakeup(struct drm_gpu_scheduler *sched);
> =C2=A0
> +/**
> + * drm_sched_flush_run_work - flush the run-job work

In v1, you'd probably want to document what this function typically
will be used for :)


Greetings,
P.
