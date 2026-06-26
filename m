Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F74FCD4F26
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 08:42:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64D3F10F4FB;
	Fri, 26 Jun 2026 08:42:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Z5wyQIqa";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EF2A10F4FB
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 08:42:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6D2AE60098
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 08:42:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E64DC1F00A3A;
 Fri, 26 Jun 2026 08:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782463367;
 bh=XUKwDgPIeiOODf076bJFCNTITZT6q0i6a7ul8NuCigw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Z5wyQIqaQy8AMSEvEPbrU/15nqag/ukxJESDkghd9OpibUyYr5UPJAecWrcZuo0kt
 DnWGlCtCJQmN9Wn+dlqslw9WaEKiGnsLpd7Ma1fUYPzCrIciohbiWdcmfy8B15ruB5
 GC9JjuKeUKq5rtlSLGYS8MYSdA+NrJjjxSYbBz9EsGbiiEgc9aMpHS1wWlsSaozdYn
 Xj9Do9Ox6oJ8z98lLv7u2SHJ19p4CsHT+cZ6IzYOIDEMDdC5FuKH1h0oxCEqKBWkI2
 1gK4pzD4l7mXC4tSsDNvvQOC5lytCFyu46HgOjASfyj6BWe7nUptHlAILUT9xHGSn9
 PHbOOaqgJsk4Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/sched: Protect entity->last_scheduled with spinlock
To: "Philipp Stanner" <phasta@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260626081942.2122144-2-phasta@kernel.org>
References: <20260626081942.2122144-2-phasta@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 08:42:46 +0000
Message-Id: <20260626084246.E64DC1F00A3A@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Use-After-Free in `drm_sched_entity_error()` due to lockless clear=
ing of `entity->last_scheduled` in `drm_sched_entity_fini()`.
- [Low] Incomplete preparational refactoring: `drm_sched_entity_kill()` cal=
ls `spsc_queue_pop()` locklessly.
--

commit 8128ccd719adfa75d48bc49990edb4b623aa9607
Author: Philipp Stanner <phasta@kernel.org>

drm/sched: Protect entity->last_scheduled with spinlock

This commit replaces the RCU mechanisms and memory barriers protecting
entity->last_scheduled with a spinlock to improve maintainability. It
also begins guarding spsc_queue_pop() with the lock in preparation for
replacing the queue with a locked list.

> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/s=
cheduler/sched_entity.c
> index 4ebb513255edd..2959feb08ac7e 100644
> --- a/drivers/gpu/drm/scheduler/sched_entity.c
> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
> @@ -202,10 +201,10 @@ int drm_sched_entity_error(struct drm_sched_entity =
*entity)
>  	struct dma_fence *fence;
>  	int r;
> =20
> -	rcu_read_lock();
> -	fence =3D rcu_dereference(entity->last_scheduled);
> +	spin_lock(&entity->lock);
> +	fence =3D entity->last_scheduled;
>  	r =3D fence ? fence->error : 0;
> -	rcu_read_unlock();
> +	spin_unlock(&entity->lock);
> =20
>  	return r;
>  }

[ ... ]

> @@ -292,8 +291,10 @@ void drm_sched_entity_kill(struct drm_sched_entity *=
entity)
>  	wait_for_completion(&entity->entity_idle);
> =20
>  	/* The entity is guaranteed to not be used by the scheduler */
> -	prev =3D rcu_dereference_check(entity->last_scheduled, true);
> +	spin_lock(&entity->lock);
> +	prev =3D entity->last_scheduled;
>  	dma_fence_get(prev);
> +	spin_unlock(&entity->lock);
>  	while ((job =3D drm_sched_entity_queue_pop(entity))) {
>  		struct drm_sched_fence *s_fence =3D job->s_fence;

[Severity: Low]
The commit message notes that spsc_queue_pop() should be guarded with the l=
ock
as a preparational step, but drm_sched_entity_queue_pop() (which wraps
spsc_queue_pop()) is called here in the while loop without holding
entity->lock.

Could this lead to lockless list manipulation when the underlying queue data
structure is later replaced with a locked list?

[ ... ]

> @@ -388,8 +389,12 @@ void drm_sched_entity_fini(struct drm_sched_entity *=
entity)
>  		entity->dependency =3D NULL;
>  	}
> =20
> -	dma_fence_put(rcu_dereference_check(entity->last_scheduled, true));
> -	RCU_INIT_POINTER(entity->last_scheduled, NULL);
> +	dma_fence_put(entity->last_scheduled);
> +	/*
> +	 * Normally all users should be gone now, but since drm_sched has
> +	 * experienced many layering violations in the past, better be safe.
> +	 */
> +	WRITE_ONCE(entity->last_scheduled, NULL);
>  	drm_sched_entity_stats_put(entity->stats);
>  }

[Severity: High]
Could this lockless pointer clearing lead to a use-after-free in
drm_sched_entity_error()?

Since drm_sched_entity_error() now uses spin_lock() instead of
rcu_read_lock(), a concurrent reader could acquire entity->lock between the
dma_fence_put() and WRITE_ONCE() calls here.

If an RCU grace period completes before the reader dereferences fence->erro=
r,
might the reader access a freed fence? Since spinlocks under PREEMPT_RT can
sleep, RCU grace periods aren't implicitly blocked. Would it be safer to
acquire entity->lock around the pointer clearing sequence here?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626081942.2122=
144-2-phasta@kernel.org?part=3D1
