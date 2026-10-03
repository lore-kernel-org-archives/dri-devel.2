Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1705BCA5FE9
	for <dri-devel@archiver.kernel.org>; Sat,  3 Oct 2026 01:33:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EEAF10E712;
	Sat,  3 Oct 2026 01:33:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DUNLAjGA";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96F1810E4C5
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 01:33:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1BDC760D77;
 Sat,  3 Oct 2026 01:33:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B23A11F00893;
 Sat,  3 Oct 2026 01:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790991193;
 bh=xpvBK+8h1kN+nYTo/sb8SK0t4G3mY52DNzUONbBtThI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=DUNLAjGA9e2lT5LbcwIuA3evPmebxBtmH46FmfimCwuQztp6ecVRsdi+0doFAqrzR
 X2Pl9v/aVMJYHqtynD22WWfYpdHy9O4xTE0WpCAeIHIAU39GyXDRPyTYSa73CNQSZl
 Qbrr7254h2R96PJQloQUehd4+rZemCd9oUf4kuq/k8BLYJ/lwi1OMX+zEqZt2LVEhV
 STZDyoqEOzqBJGROrjYHWQd1YvgNPjWqwY9DQTq68F3PB+kaDTlPzxBc3QpFp5Wdew
 mEJEppQWh3YxgEsOIiEC0q+a7MmpF3gOR8vZGWWHvJ6MJy5YGU1rX/d786siwuk2wY
 OIhVHwFrkdsfQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 9/9] drm/sched: Untangle the scheduler list mess
To: "Tvrtko Ursulin" <tvrtko.ursulin@igalia.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261002154713.77591-10-tvrtko.ursulin@igalia.com>
References: <20261002154713.77591-1-tvrtko.ursulin@igalia.com>
 <20261002154713.77591-10-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 01:33:13 +0000
Message-Id: <20261003013313.B23A11F00893@smtp.kernel.org>
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
- [Critical] drm/sched: memory corruption and leak due to union aliasing in=
 drm_sched_entity_modify_sched
- [High] drm/amdgpu: sleeping in atomic context during priority override
- [High] drm/sched: NULL pointer dereference in drm_sched_entity_init due t=
o missing checks
- [Medium] drm/amdgpu: incomplete state rollback on priority update failure
--

commit ab2f90841362b0f1b7727691f75f0960403af244
Author: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Date:   Fri Oct 2 15:47:13 2026 +0000

    drm/sched: Untangle the scheduler list mess

This commit documents how the scheduler behaves and makes the entity own
its own copy of the scheduler list to untangle the API. Some API calls
are updated to return success/failure, which percolates mostly through
amdgpu priority overrides.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ctx.c
> index acafa8c59cc90..6500e7f69f5e0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
[ ... ]
> @@ -811,16 +811,18 @@ static void amdgpu_ctx_set_entity_priority(struct a=
mdgpu_ctx *ctx,
>  		hw_prio =3D array_index_nospec(hw_prio, AMDGPU_RING_PRIO_MAX);
>  		scheds =3D adev->gpu_sched[hw_ip][hw_prio].sched;
>  		num_scheds =3D adev->gpu_sched[hw_ip][hw_prio].num_scheds;
> -		drm_sched_entity_modify_sched(&aentity->entity, scheds,
> -					      num_scheds);
> +		ret =3D drm_sched_entity_modify_sched(&aentity->entity, scheds,
> +						    num_scheds);
>  	}
> +
> +	return ret;
>  }
> =20
> -void amdgpu_ctx_priority_override(struct amdgpu_ctx *ctx,
> -				  int32_t priority)
> +int amdgpu_ctx_priority_override(struct amdgpu_ctx *ctx, int32_t priorit=
y)
>  {
>  	int32_t ctx_prio;
>  	unsigned i, j;
> +	int ret;
> =20
>  	ctx->override_priority =3D priority;
> =20
> @@ -831,10 +833,15 @@ void amdgpu_ctx_priority_override(struct amdgpu_ctx=
 *ctx,
>  			if (!ctx->entities[i][j])
>  				continue;
> =20
> -			amdgpu_ctx_set_entity_priority(ctx, ctx->entities[i][j],
> -						       i, ctx_prio);
> +			ret =3D amdgpu_ctx_set_entity_priority(ctx,
> +							     ctx->entities[i][j],
> +							     i, ctx_prio);
> +			if (ret)
> +				return ret;
>  		}
>  	}
> +
> +	return 0;
>  }

[Severity: Medium]
If drm_sched_entity_modify_sched() fails (e.g. from an -ENOMEM during its
allocation), isn't the software priority already modified unconditionally
by the earlier call to drm_sched_entity_set_priority()?

Additionally, when an error is returned to amdgpu_ctx_priority_override(),
the loop exits early, returning the error. Does this leave the context
partially updated without rolling back the priorities of the previous
entities?

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_sched.c
> index 8effb1158430d..0efe90767bfba 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
> @@ -51,11 +51,14 @@ static int amdgpu_sched_process_priority_override(str=
uct amdgpu_device *adev,
> =20
>  	mgr =3D &fpriv->ctx_mgr;
>  	xa_lock(&mgr->ctx_handles);
> -	xa_for_each(&mgr->ctx_handles, id, ctx)
> -		amdgpu_ctx_priority_override(ctx, priority);
> +	xa_for_each(&mgr->ctx_handles, id, ctx) {
> +		r =3D amdgpu_ctx_priority_override(ctx, priority);
> +		if (r)
> +			break;
> +	}
>  	xa_unlock(&mgr->ctx_handles);
> =20
> -	return 0;
> +	return r;
>  }

[Severity: High]
Does this sequence lead to sleeping in atomic context?

amdgpu_sched_process_priority_override() acquires the mgr->ctx_handles
spinlock via xa_lock(), entering an atomic context, and calls:

  amdgpu_ctx_priority_override() ->
    amdgpu_ctx_set_entity_priority() ->
      drm_sched_entity_modify_sched()

If the engine has multiple schedulers, drm_sched_entity_modify_sched()
dynamically allocates memory using GFP_KERNEL, which implies
__GFP_DIRECT_RECLAIM and can sleep. Can this trigger a Scheduling while
atomic BUG?

> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/s=
cheduler/sched_entity.c
> index 79ea20838328d..a2e043df10619 100644
> --- a/drivers/gpu/drm/scheduler/sched_entity.c
> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
[ ... ]
> @@ -119,16 +124,11 @@ int drm_sched_entity_init(struct drm_sched_entity *=
entity,
>  			  unsigned int num_sched_list,
>  			  atomic_t *guilty)
>  {
> -	unsigned int i;
> +	int ret;
> =20
> -	if (!entity || !sched_list || !num_sched_list)
> +	if (!entity)
>  		return -EINVAL;
> =20
> -	for (i =3D 0; i < num_sched_list; i++) {
> -		if (!sched_list[i] || !sched_list[i]->sched_rq)
> -			return -EINVAL;
> -	}
> -
>  	memset(entity, 0, sizeof(struct drm_sched_entity));
> =20
>  	entity->stats =3D drm_sched_entity_stats_new();
> @@ -138,8 +138,6 @@ int drm_sched_entity_init(struct drm_sched_entity *en=
tity,
>  	INIT_LIST_HEAD(&entity->list);
>  	entity->guilty =3D guilty;
>  	entity->last_user =3D current->group_leader;
> -	entity->num_sched_list =3D num_sched_list;
> -	entity->sched_list =3D num_sched_list > 1 ? sched_list : NULL;
>  	RB_CLEAR_NODE(&entity->rb_tree_node);
> =20
>  	if (priority >=3D sched_list[0]->num_user_rqs) {

[Severity: High]
The fail-safe checks for sched_list and num_sched_list were moved down to
drm_sched_entity_modify_sched(), but sched_list[0] is still dereferenced
here before that new validation takes place.

If a driver initializes an entity with an empty scheduler list, won't this
immediately result in a NULL pointer or out-of-bounds dereference instead
of a graceful -EINVAL?

> @@ -178,21 +183,53 @@ EXPORT_SYMBOL(drm_sched_entity_init);
[ ... ]
> +int drm_sched_entity_modify_sched(struct drm_sched_entity *entity,
> +				  struct drm_gpu_scheduler **sched_list,
> +				  unsigned int num_sched_list)
>  {
> -	WARN_ON(!num_sched_list || !sched_list);
> +	struct drm_gpu_scheduler **newscheds, **oldscheds;
> +	unsigned int i;
> +
> +	if (!sched_list || !num_sched_list)
> +		return -EINVAL;
> +
> +	for (i =3D 0; i < num_sched_list; i++) {
> +		if (!sched_list[i] || !sched_list[i]->sched_rq)
> +			return -EINVAL;
> +	}
> +
> +	if (num_sched_list > 1) {
> +		newscheds =3D kmemdup_array(sched_list, num_sched_list,
> +					  sizeof(*sched_list), GFP_KERNEL);
> +		if (!newscheds)
> +			return -ENOMEM;
> +	}
> =20
>  	spin_lock(&entity->lock);
> -	entity->sched_list =3D sched_list;
> +	if (num_sched_list =3D=3D 1) {
> +		entity->sched =3D sched_list[0];
> +		oldscheds =3D NULL;
> +	} else {
> +		oldscheds =3D entity->sched_list;
> +		entity->sched_list =3D newscheds;
> +	}
>  	entity->num_sched_list =3D num_sched_list;
>  	spin_unlock(&entity->lock);
> +
> +	kfree(oldscheds);
> +
> +	return 0;
>  }

[Severity: Critical]
The struct drm_sched_entity uses a union for sched_list and sched. Does
this logic incorrectly use the new num_sched_list count to determine how
to extract the old pointer?

When transitioning from 1 scheduler to >1, the else branch executes, and
oldscheds is assigned entity->sched_list. Since they share a union, doesn't
this alias with the old entity->sched pointer, causing kfree(oldscheds) to
incorrectly free a driver-owned scheduler object instead of an array?

Conversely, when going from >1 to 1, the if branch sets oldscheds to NULL,
which seems to leak the previously allocated entity->sched_list array.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002154713.7759=
1-1-tvrtko.ursulin@igalia.com?part=3D9
