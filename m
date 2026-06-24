Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78844CDB479
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 13:03:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA9E210EF25;
	Wed, 24 Jun 2026 13:03:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KluOqzQA";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B07610EF17
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 13:03:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7B1A960018
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 13:03:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F34E1F000E9;
 Wed, 24 Jun 2026 13:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782306183;
 bh=hUYiv/N9oof087dcZfo7pqgb/YjZK4IFMDFVjwYwwMo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=KluOqzQAlVKb+H28lWVstWj5oaJ8iqqaWJjiRVyMcmJ51RpA7HMMNZohnxdqLamZC
 Z+7dkzGTQ76Cq57nJmD+LOIhtfHByjxFSCbq1//yFfUwONx7wcTTcHDVocEg+Ma33r
 e4PSGMBeq/YKXfdWA1LWuVIlc7fQeH3z3uhN5MPf4nJd8+DyPmdPJ0J+98UFIfiDpz
 2BTmpyxofkpmwu1+cy/SMxC3Vd2eyes8qswK/uFg9SkFbXvRZ5IAu+pMyUcr41FO5E
 j2d3d2bMyd1XRxEs1B7M6JEprER7eJ+z37KrsT2GYM6x6emS+K/NvBUHnTFyKDcL+b
 Sm0NSkqMxQS4A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/sched: Protect entity->last_scheduled with spinlock
To: "Philipp Stanner" <phasta@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260624124651.1414814-2-phasta@kernel.org>
References: <20260624124651.1414814-2-phasta@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2026 13:03:02 +0000
Message-Id: <20260624130303.0F34E1F000E9@smtp.kernel.org>
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
- [High] Calling dma_fence_put() while holding the entity->lock spinlock in=
troduces a risk of AB-BA lock inversion and deadlock with driver locks.
--

commit 21ecb5d3d71a1baa4ff6c29fb3ddc0deff8299e3
Author: Philipp Stanner <phasta@kernel.org>

drm/sched: Protect entity->last_scheduled with spinlock

This commit replaces the RCU protection and memory barriers used for
entity->last_scheduled with the existing entity->lock spinlock. It also
guards the spsc_queue_pop() call with the same lock as a preparatory step
for future cleanups.

> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/s=
cheduler/sched_entity.c
> index c51101ec70c16..95b2c48a604a6 100644
> --- a/drivers/gpu/drm/scheduler/sched_entity.c
> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
[ ... ]
> @@ -523,18 +524,18 @@ struct drm_sched_job *drm_sched_entity_pop_job(stru=
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
> +	spin_lock(&entity->lock);
> +	dma_fence_put(entity->last_scheduled);

[Severity: High]
Could calling dma_fence_put() while holding entity->lock introduce an AB-BA
lock inversion risk here?

If dropping the final reference to the scheduled fence invokes its release
callback, this can synchronously drop the reference to the underlying driver
hardware fence (fence->parent). When the hardware fence's reference count
drops to zero, the driver-specific release callback is invoked synchronously
while entity->lock is held.

Drivers commonly acquire their own internal locks (e.g., submission queue
locks) in their fence release callbacks. However, during job submission,
drivers typically hold these same internal locks before calling
drm_sched_entity_push_job(), which subsequently acquires entity->lock.
This reverse lock ordering might create a circular lock dependency.

Would it be safer to grab a local reference to entity->last_scheduled,
update the pointer, drop the spinlock, and then call dma_fence_put() on
the local reference outside the critical section?

> +	entity->last_scheduled =3D dma_fence_get(&sched_job->s_fence->finished);
> +
> +	/* A recent rework required taking the spinlock above. Since spsc_queue
> +	 * is scheduled for removal as per the DRM-TODO-list, we access it here
> +	 * locked already to prepare for that cleanup.
> +	 *
> +	 * TODO: Fully replace spsc_queue with a locked (h)list.
>  	 */
> -	smp_wmb();
> -
>  	spsc_queue_pop(&entity->job_queue);
> +	spin_unlock(&entity->lock);
> =20
>  	drm_sched_rq_pop_entity(entity);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260624124651.1414=
814-2-phasta@kernel.org?part=3D1
