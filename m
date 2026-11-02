Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444B1606A329
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 22:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n4Z9TIVh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9111D10E6E9;
	Mon,  2 Nov 2026 22:54:54 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E04B310E6E3;
 Mon,  2 Nov 2026 22:54:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4000360534;
 Mon,  2 Nov 2026 22:54:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B601F1F00A1C;
 Mon,  2 Nov 2026 22:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793660086;
 bh=lS5AryEtNuT/XGriuuk2VdulvKIDL/4ruMEU57pYPWo=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=n4Z9TIVhkbY/8Y7udWcsnH5U0HLmeWYwDSFIbCylQlwHDk6ueGDpcVbu4uaBLyEKr
 APEn4aP6IKJVSG85dXyCpH+CtQhbVwepapZyurVSMoExlUlznsf9xcYqcI9IjzMmyG
 TOyPVoaMmxOoIeyFjhTVN+O1Jy9PFnghFRmJyEf90HnDt4EnnNiDZkdWHq3ivp5aym
 rg3Poz0M9N8YP0xFAjrBbyQqO7W50Zx05IPArDwh1yjGiypHRw0Mrjz7BdMuX7sscz
 n/YvEu9rp5Y0cxeKHuidhSwsDFFBmlF5MPZ6tjhbFJlooYlxC2+j4bgyVELKxLGQxz
 O4bzJjbxAwTBQ==
Message-ID: <sashiko-outbox-194307@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 3/3] drm/xe: Add a minimum age gate to the shrinker
To: "Matthew Brost" <matthew.brost@intel.com>, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20261102223220.1411858-4-matthew.brost@intel.com>
References: <20261102223220.1411858-1-matthew.brost@intel.com>
 <20261102223220.1411858-4-matthew.brost@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 22:54:46 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] drm/xe: xe_bo_shrink_too_young() misses age updates for bulk-mov=
ed VM BOs
--

commit 281f376af4d072a5a3001932f9bcc749e37e12a5
Author: Matthew Brost <matthew.brost@intel.com>

drm/xe: Add a minimum age gate to the shrinker

This patch introduces a per-device shrinker_min_age_ms sysfs attribute and
Kconfig option to prevent the shrinker from backing up buffer objects that
were recently moved into TT or bumped on the LRU. Buffer objects are
timestamped on moves into XE_PL_TT and LRU updates, with the shrinker count
and scan walks skipping LRU priorities whose oldest candidate is younger
than the configured minimum age.

> diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
> index 42a6aa1a2e4a0..3163c01012f73 100644
> --- a/drivers/gpu/drm/xe/xe_bo.c
> +++ b/drivers/gpu/drm/xe/xe_bo.c
> @@ -1357,9 +1357,96 @@ static int xe_bo_move(struct ttm_buffer_object *tt=
m_bo, bool evict,
>  		xe_tt_unmap_sg(xe, ttm_bo->ttm);
>  	}
> =20
> +	/*
> +	 * ttm_resource_alloc() already placed the new resource at the tail of
> +	 * its LRU, or of @bo's bulk move, so only record when that happened.
> +	 */
> +	if (!ret && ttm_bo->resource && ttm_bo->resource->mem_type =3D=3D XE_PL=
_TT)
> +		bo->lru_stamp =3D jiffies;
> +
>  	return ret;
>  }

[ ... ]

> +bool xe_bo_shrink_too_young(struct ttm_buffer_object *bo, unsigned long =
min_age)
> +{
> +	struct xe_bo *xe_bo;
> +	unsigned long stamp;
> +
> +	if (!min_age || bo->resource->mem_type =3D=3D XE_PL_SYSTEM ||
> +	    !xe_bo_shrink_backup_candidate(bo))
> +		return false;
> +
> +	xe_bo =3D ttm_to_xe_bo(bo);
> +	xe_bo_assert_held(xe_bo);
> +
> +	if (bo->bulk_move && xe_bo->vm)
> +		stamp =3D xe_bo->vm->lru_stamp;
> +	else
> +		stamp =3D xe_bo->lru_stamp;
> +
> +	return stamp && time_before(jiffies, stamp + min_age);
> +}

[Severity: Medium]
As reported by Sashiko on v6 [1], can xe_bo_shrink_too_young() miss age
updates for private BOs that use a VM's bulk move?

In drivers/gpu/drm/xe/xe_bo.c, __xe_bo_create_locked() attaches every priva=
te
user BO created on a non-fault-mode VM to vm->lru_bulk_move:

drivers/gpu/drm/xe/xe_bo.c:__xe_bo_create_locked() {
	bo =3D xe_bo_init_locked(xe, bo, tile, vm ? xe_vm_resv(vm) : NULL,
			       vm && !xe_vm_in_fault_mode(vm) &&
			       flags & XE_BO_FLAG_USER ?
			       &vm->lru_bulk_move : NULL, size,
			       cpu_caching, type, flags, NULL, exec);
}

Because xe_bo_shrink_too_young() checks bo->bulk_move && xe_bo->vm and reads
only xe_bo->vm->lru_stamp (ignoring xe_bo->lru_stamp), three cases appear to
leave the stamp out of sync with the BO's actual activity or LRU position:

1. For preempt-fence LR VMs (XE_VM_FLAG_LR_MODE without
XE_VM_FLAG_FAULT_MODE), !xe_vm_in_fault_mode(vm) is true so private user BOs
have bo->bulk_move set. However, xe_exec_ioctl() in
drivers/gpu/drm/xe/xe_exec.c skips xe_vm_bump_lru() for all LR VMs:

drivers/gpu/drm/xe/xe_exec.c:xe_exec_ioctl() {
	if (!err && !xe_vm_in_lr_mode(vm))
		xe_vm_bump_lru(vm, exec);
}

And preempt_rebind_work_func() in drivers/gpu/drm/xe/xe_vm.c exits early in
xe_preempt_work_begin() when !preempt_fences_waiting(vm), so vm->lru_stamp
remains 0 (or stale from the last eviction/invalidation rebind) while the VM
creates BOs and submits work. When kswapd runs with ctx.no_wait_gpu =3D=3D =
false,
won't xe_bo_shrink_too_young() treat these active BOs as old and allow them
to be preempted and backed up regardless of shrinker_min_age_ms?

2. In xe_bo_move(), moving a BO into XE_PL_TT updates bo->lru_stamp =3D jif=
fies
without updating vm->lru_stamp. When a private BO on any non-fault-mode VM =
is
created in or moved into XE_PL_TT while its priority bucket in
vm->lru_bulk_move is empty (for instance, before the VM's first exec or when
no other TT BOs exist in that bucket), ttm_resource_alloc() ->
ttm_lru_bulk_move_add() places the resource at the tail of man->lru. Since
xe_bo_shrink_too_young() ignores bo->lru_stamp when bo->bulk_move is set, a
BO newly moved into TT will still read the stale or zero vm->lru_stamp and
won't be protected by shrinker_min_age_ms until an exec bumps the VM.

3. In drivers/gpu/drm/xe/xe_bo.c, xe_gem_object_close() detaches a private =
BO
from vm->lru_bulk_move in place when its GEM handle is closed while mappings
remain in the VM:

drivers/gpu/drm/xe/xe_bo.c:xe_gem_object_close() {
	if (bo->vm && !xe_vm_in_fault_mode(bo->vm)) {
		xe_bo_lock(bo, false);
		ttm_bo_set_bulk_move(&bo->ttm, NULL);
		xe_bo_unlock(bo);
	}
}

Once bo->bulk_move is cleared, xe_bo_shrink_too_young() switches back to
reading xe_bo->lru_stamp without updating either the stamp or the BO's LRU
position. If the BO was recently bumped via xe_vm_bump_lru(), closing the
handle reverts its age to the stale bo->lru_stamp; conversely, if the BO was
recently moved into TT inside an older bulk-move range near the head of the
LRU and then closed, its young bo->lru_stamp becomes visible near the LRU
head and causes ttm_bo_lru_cursor_skip_priority() to skip older BOs behind
it.

Would it make sense to propagate or take max(xe_bo->vm->lru_stamp,
xe_bo->lru_stamp) when appropriate, and ensure preempt-fence LR VMs and
bulk-move detach paths keep the stamp consistent with the LRU position?

[1] https://lore.kernel.org/r/20261027224902.1085762-4-matthew.brost@intel.=
com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102223220.1411=
858-1-matthew.brost@intel.com?part=3D3
