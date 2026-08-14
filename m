Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6858CC5CFC1
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 08:10:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD9B710F443;
	Fri, 14 Aug 2026 08:10:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UYbdVPuq";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FCF010F443
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 08:10:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2461E40E37;
 Fri, 14 Aug 2026 08:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0FAB1F00A3A;
 Fri, 14 Aug 2026 08:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786695022;
 bh=asHxFYr6MwhDHVWnhP3JiWHCP+V9KMvbulZFQU80jAk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UYbdVPuqRorfriGL12r0Mv5ctNaMnUurlzbKHXJLsIr16Si8VVJdNgO7wcRk+OT8m
 WTpXVjUvlbNiBI+QUqjBkvgTc8F+sIh05WQFKpzJEB5wakqZ+grZERJsALz3C361xT
 LOx4HxUvmNCZyMPgm4A8Ku264N8+oh6VJoJAIWQcSNk0pzFHzHvmpyhnK4ZWEWW9ug
 8suW0emQtCJ5bil07OqbO6wqgz89V10bVbjj2buvS94XuF2LspstDcsbmhIeupX9io
 Sl3ETGhBuGEkSLWBBrBY49bVlmnoVlQbSoewdON6TeAVGYlGQnDeykob0Da3wms3ZJ
 kpvDAawiLLamg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] drm/sched: Do not restore unsaved virtual runtime
To: "Tvrtko Ursulin" <tvrtko.ursulin@igalia.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260814075739.32481-2-tvrtko.ursulin@igalia.com>
References: <20260814075739.32481-1-tvrtko.ursulin@igalia.com>
 <20260814075739.32481-2-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 08:10:21 +0000
Message-Id: <20260814081021.D0FAB1F00A3A@smtp.kernel.org>
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

Pre-existing issues:
- [High] A killed and stopped scheduler entity can be unconditionally added=
 back to the runqueue's rbtree, leading to a use-after-free when the entity=
 is subsequently freed by the driver.
--

--- Patch [1]: [PATCH 1/2] drm/sched: Do not restore unsaved virtual runtim=
e ---
commit 8feac77c9420bd8a6d250c6a988250fe755b6870
Author: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: drm/sched: Do not restore unsaved virtual runtime

This patch modifies the queue push/pop and runqueue management paths in the
drm scheduler. It extends the scope of entity->lock to encompass both queue
management and rbtree updates. This prevents a race condition where a new j=
ob
could be pushed to an entity before its virtual runtime was correctly saved.

> diff --git a/drivers/gpu/drm/scheduler/sched_rq.c b/drivers/gpu/drm/sched=
uler/sched_rq.c
> index 0464d324d98d5..23f46ec610e78 100644
> --- a/drivers/gpu/drm/scheduler/sched_rq.c
> +++ b/drivers/gpu/drm/scheduler/sched_rq.c

[ ... ]

> @@ -343,16 +340,17 @@ drm_sched_rq_next_rr_ts(struct drm_sched_rq *rq,
>   */
>  void drm_sched_rq_pop_entity(struct drm_sched_entity *entity)
>  {
> +	struct drm_sched_rq *rq =3D entity->rq;
>  	struct drm_sched_job *next_job;
> -	struct drm_sched_rq *rq;
> +
> +	lockdep_assert_held(&entity->lock);
> +
> +	spin_lock(&rq->lock);
> =20
>  	/*
>  	 * Update the entity's location in the min heap according to
>  	 * the timestamp of the next job, if any.
>  	 */
> -	spin_lock(&entity->lock);
> -	rq =3D entity->rq;
> -	spin_lock(&rq->lock);
>  	next_job =3D drm_sched_entity_queue_peek(entity);
>  	if (next_job) {

[Severity: High]
This is a pre-existing issue, but can this lead to a use-after-free if the
entity is killed concurrently?

If drm_sched_entity_kill() in drivers/gpu/drm/scheduler/sched_entity.c is
called on an entity with multiple pending jobs concurrently with the schedu=
ler
thread popping a job:

drm_sched_entity_kill() {
    ...
    spin_lock(&entity->lock);
    entity->stopped =3D true;
    drm_sched_rq_remove_entity(entity->rq, entity);
    spin_unlock(&entity->lock);
    ...
}

Meanwhile, the scheduler thread popping a job calls drm_sched_rq_pop_entity=
()
in drivers/gpu/drm/scheduler/sched_rq.c. Since next_job is not NULL, the co=
de
takes this path and calls drm_sched_rq_update_fifo_locked(), which
unconditionally adds the entity back to the runqueue's rbtree, ignoring
entity->stopped.

When the killer thread wakes up and finishes, the entity is freed but still
linked in the rbtree, which corrupts the rbtree.

Should drm_sched_rq_pop_entity() check entity->stopped before re-adding the
entity to the runqueue, similar to the check in drm_sched_rq_add_entity()?

>  		ktime_t ts;
> @@ -375,8 +373,8 @@ void drm_sched_rq_pop_entity(struct drm_sched_entity =
*entity)
>  			drm_sched_entity_save_vruntime(entity, min_vruntime);
>  		}
>  	}
> +
>  	spin_unlock(&rq->lock);
> -	spin_unlock(&entity->lock);
>  }
> =20
>  /**

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814075739.3248=
1-1-tvrtko.ursulin@igalia.com?part=3D1
