Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE8E2C5CFC1
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 08:09:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F044410F428;
	Fri, 14 Aug 2026 08:09:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mhb1WyVr";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D6BA10F428
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 08:09:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8338060A69;
 Fri, 14 Aug 2026 08:09:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58E071F000E9;
 Fri, 14 Aug 2026 08:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786694983;
 bh=WZjGJqvyOnMvxWs4wLtTq6zplXdp/jLJAmOpjr9LRIk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mhb1WyVrzIn6o9Y1/areCdBn1onsxlFZ/CjKSlNothjnXF2gCEF4CQQpvuJm6gU5j
 2HG7ONEgJRu0zMv+fc7deZBNI1eowaIf2NuvxrnSIHzNsy1tZi5Eqj+FJEaZGrMOHu
 38CJognO+jY9hktDgTsDcJBCFIIUkWzEK+yw+DuEoQPlGgdXhkmQajKnQqw7sXo/V5
 GQl4w0Cr7CnSL56WJ+r1dmPqcpnzqjXefeECIOlBxkynyaN26egMQpZcGzfEih8q5A
 /cHa7+48/KeNgdh+4MCGDm9DVwmammULV66WRJ9MVODdYyeS0dMtVYxbDKHte7SyKz
 ITWY5N1NOksew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] drm/sched: Ensure monotonic min_vruntime
To: "Tvrtko Ursulin" <tvrtko.ursulin@igalia.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260814075739.32481-3-tvrtko.ursulin@igalia.com>
References: <20260814075739.32481-1-tvrtko.ursulin@igalia.com>
 <20260814075739.32481-3-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 08:09:38 +0000
Message-Id: <20260814080942.58E071F000E9@smtp.kernel.org>
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
- [High] drm_sched_entity_save_vruntime() always saves a virtual runtime la=
g of 0 due to an impossible condition, permanently destroying the entity's =
relative lag state.
- [Medium] rq->min_vruntime incorrectly tracks the maximum updated vruntime=
 of the executing entity rather than the true minimum of the runqueue, pena=
lizing newly enqueued entities.
--

--- Patch [2]: [PATCH 2/2] drm/sched: Ensure monotonic min_vruntime ---
commit 840e24cc75ac9a836c633b23cb95dda0e0dc3b75
Author: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

drm/sched: Ensure monotonic min_vruntime

min_vruntime handling had a bug where if an entity never exited the run-
queue it could get penalised by its virtual runtime only ever growing,
while the periodically exiting and re-joining entities could repeatedly
get pulled ahead of it.

Fix it by making the min_vruntime strictly monotonic by tracking it
separately (an keeping it always up to date) instead of fetching what
happens to be the top of the tree sorted by virtual runtime.

While at it replace open coded ktime_t comparison with the correct
ktime_after() helper.

Fixes: 2fa4d8e2c109 ("drm/sched: Add fair scheduling policy")
Tested-by: Luke.Wildhardt@proton.me
Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Luke.Wildhardt@proton.me
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Philipp Stanner <phasta@kernel.org>
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Cc: Vitaly Prosyak <vitaly.prosyak@amd.com>

> diff --git a/drivers/gpu/drm/scheduler/sched_rq.c b/drivers/gpu/drm/sched=
uler/sched_rq.c
> index 23f46ec610e78..bc8363974a276 100644
> --- a/drivers/gpu/drm/scheduler/sched_rq.c
> +++ b/drivers/gpu/drm/scheduler/sched_rq.c

[ ... ]

> @@ -151,7 +130,7 @@ drm_sched_entity_save_vruntime(struct drm_sched_entit=
y *entity,
> =20
>  	spin_lock(&stats->lock);
>  	vruntime =3D stats->vruntime;
> -	if (min_vruntime && vruntime > min_vruntime)
> +	if (ktime_after(vruntime, min_vruntime))

[Severity: High]
Will this condition always evaluate to false and unconditionally reset the=
=20
saved lag to 0?

In drm_sched_rq_pop_entity(), the runqueue's min_vruntime is updated to be
at least the entity's current vruntime:

drm_sched_rq_pop_entity() {
    ...
    ts =3D drm_sched_entity_update_vruntime(entity);
    if (ktime_after(ts, rq->min_vruntime))
        rq->min_vruntime =3D ts;

Later in the same function, if the queue is empty, we call:

    drm_sched_entity_save_vruntime(entity, rq->min_vruntime);

Since min_vruntime is guaranteed to be greater than or equal to the entity's
vruntime at this point, the ktime_after(vruntime, min_vruntime) check here=
=20
seems mathematically impossible to satisfy.=20

Does this mean entities that empty their runqueue will permanently lose=20
their accumulated vruntime penalty?

>  		vruntime =3D ktime_sub(vruntime, min_vruntime);
>  	else
>  		vruntime =3D 0;

[ ... ]

> @@ -351,27 +324,27 @@ void drm_sched_rq_pop_entity(struct drm_sched_entit=
y *entity)
>  	 * Update the entity's location in the min heap according to
>  	 * the timestamp of the next job, if any.
>  	 */
> +
> +	if (drm_sched_policy =3D=3D DRM_SCHED_POLICY_FAIR) {
> +		ts =3D drm_sched_entity_update_vruntime(entity);
> +		if (ktime_after(ts, rq->min_vruntime))
> +			rq->min_vruntime =3D ts;
> +	}
> +

[Severity: Medium]
Does this unintentionally advance the runqueue's min_vruntime past other
entities still waiting in the RB tree?

By setting rq->min_vruntime to the newly updated vruntime of the currently
executing entity, it seems we might ignore the vruntimes of other entities
that are still queued.=20

When new entities join the runqueue, won't their initial vruntime be based=
=20
on this artificially inflated min_vruntime, penalizing them relative to the=
=20
existing waiting entities?

>  	next_job =3D drm_sched_entity_queue_peek(entity);
>  	if (next_job) {
> -		ktime_t ts;
> -
> -		if (drm_sched_policy =3D=3D DRM_SCHED_POLICY_FAIR)
> -			ts =3D drm_sched_entity_get_job_ts(entity);
> -		else if (drm_sched_policy =3D=3D DRM_SCHED_POLICY_FIFO)
> +		if (drm_sched_policy =3D=3D DRM_SCHED_POLICY_FIFO)
>  			ts =3D next_job->submit_ts;
> -		else
> +		else if (drm_sched_policy =3D=3D DRM_SCHED_POLICY_RR)
>  			ts =3D drm_sched_rq_next_rr_ts(rq, entity);
> =20
>  		drm_sched_rq_update_fifo_locked(entity, rq, ts);
>  	} else {
> -		drm_sched_rq_remove_fifo_locked(entity, rq);
> -
> -		if (drm_sched_policy =3D=3D DRM_SCHED_POLICY_FAIR) {
> -			ktime_t min_vruntime;
> +		if (drm_sched_policy =3D=3D DRM_SCHED_POLICY_FAIR)
> +			drm_sched_entity_save_vruntime(entity,
> +						       rq->min_vruntime);
> =20
> -			min_vruntime =3D drm_sched_rq_get_min_vruntime(rq);
> -			drm_sched_entity_save_vruntime(entity, min_vruntime);
> -		}
> +		drm_sched_rq_remove_fifo_locked(entity, rq);
>  	}
> =20
>  	spin_unlock(&rq->lock);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814075739.3248=
1-1-tvrtko.ursulin@igalia.com?part=3D2
