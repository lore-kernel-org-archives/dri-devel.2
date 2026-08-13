Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C08ECC5CFDB
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 09:35:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E009810F23D;
	Thu, 13 Aug 2026 09:35:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Os5+FdTW";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADFDE10F23D
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 09:35:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9593D40067;
 Thu, 13 Aug 2026 09:35:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 535F41F000E9;
 Thu, 13 Aug 2026 09:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786613727;
 bh=G+nFDpRMcA0vky9cHmYndMorNQvEoR7XiPm1tFuXotM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Os5+FdTWprGU6IEeLbLhO0xnn+aWbEy5fkZV538Tfj4oUfsZ0OKHgN9qR/vqUPIds
 ieFRqy8vnbeyj0acoQDLP9FsTaWdVvMuje/G8L/QsLVuFhdwmyYObBUn0N0CqSXY56
 0IuLL/cybS13w5OrCVZlOAYYOEIAyP2Wi/aroifotIdo0YnShAhW2s32sbELV0muRR
 z8fz4GcSYDA5J4/I8G5gUYDboX/i6fEoFFKl1eAoWE8Wo4wfppTkZDKeNN64YPvEkI
 Ku0j+VA+GijjR9NRWngp0XPaPnBqbu+NErjR5Wb1kWNcnzpgE+HlJE47CJB5Ikq2JC
 9+BOzgWYcfDhQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] drm/sched: Protect entity->last_scheduled with
 spinlock
To: "Philipp Stanner" <phasta@kernel.org>
Cc: media-ci@linuxtv.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260813092510.2385962-6-phasta@kernel.org>
References: <20260813092510.2385962-4-phasta@kernel.org>
 <20260813092510.2385962-6-phasta@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 09:35:26 +0000
Message-Id: <20260813093527.535F41F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Incorrect ordering of `spsc_queue_pop()` and `drm_sched_rq_pop_ent=
ity()` causes runqueue corruption, empty entity leakage, and breaks FIFO sc=
heduling.
--

--- Patch [2]: [PATCH v2 2/2] drm/sched: Protect entity->last_scheduled wit=
h spinlock ---
commit fe95a95b4cbec301e14107b82365837fc67259e7
Author: Philipp Stanner <phasta@kernel.org>

drm/sched: Protect entity->last_scheduled with spinlock

This commit replaces the RCU and memory barrier mechanisms used to protect
entity->last_scheduled with a spinlock. It aims to improve robustness and
readability since the entity lock is already taken in most places that
evaluate this field.

> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/s=
cheduler/sched_entity.c
> --- a/drivers/gpu/drm/scheduler/sched_entity.c
> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
[ ... ]
> @@ -555,23 +558,16 @@ struct drm_sched_job *drm_sched_entity_pop_job(stru=
ct drm_sched_entity *entity)
>  	if (entity->guilty && atomic_read(entity->guilty))
>  		dma_fence_set_error(&sched_job->s_fence->finished, -ECANCELED);
> =20
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
> -	spsc_queue_pop(&entity->job_queue);
> -
>  	spin_lock(&entity->lock);
> +	prev_last_scheduled =3D entity->last_scheduled;
> +	entity->last_scheduled =3D dma_fence_get(&sched_job->s_fence->finished);
>  	drm_sched_rq_pop_entity(entity);
>  	spin_unlock(&entity->lock);
> =20
> +	spsc_queue_pop(&entity->job_queue);

[Severity: High]
Does moving spsc_queue_pop() after drm_sched_rq_pop_entity() cause runqueue
corruption?

Looking at drm_sched_rq_pop_entity(), it uses drm_sched_entity_queue_peek()
to check the next job in the queue:

drivers/gpu/drm/scheduler/sched_rq.c:drm_sched_rq_pop_entity() {
    ...
    next_job =3D drm_sched_entity_queue_peek(entity);
    if (next_job) {
        ...
        drm_sched_rq_update_fifo_locked(entity, rq, ts);
    } else {
        drm_sched_rq_remove_fifo_locked(entity, rq);
        ...
}

Because the current job hasn't been popped from entity->job_queue yet,
won't drm_sched_entity_queue_peek() return the job we are currently
processing instead of the subsequent job (or NULL)?

It appears this structural inversion causes the runqueue update to evaluate
the current job's timestamp rather than the next job, and prevents empty
entities from being correctly removed from the runqueue.

> +
> +	dma_fence_put(prev_last_scheduled);
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813092510.2385=
962-4-phasta@kernel.org?part=3D2
