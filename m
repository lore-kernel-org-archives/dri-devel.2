Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939A2606A31D
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 23:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SZEwqYCU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE8E110F88B;
	Tue, 27 Oct 2026 23:17:19 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15F7910F87E;
 Tue, 27 Oct 2026 23:17:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 32DD960211;
 Tue, 27 Oct 2026 23:17:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B675B1F01829;
 Tue, 27 Oct 2026 23:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793143031;
 bh=J7AkcRvEhgBFlkC5qnkpTiwTsYJibmkp/q/2V5jJetw=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=SZEwqYCU2ccl9hOvlt8t1mEicX1Gf1R6rCMaHB4UjBFF/ZlsAlymqLSUgolAa4x1W
 AC/Hty7XS7nIe1dxGDIDnA8tjOASaAEF1cWoMtRoEUeNaoWpXUeXtjGYFiiHILar22
 AKLGIj916vUt6dKMdXeIRdPcT4i6KJo5pz8fMmvcDzLdHjlOAAD/G1fFtg8Gpak8WF
 BRYnNCBPLVyuokb1f8GOfe43Z7nov/SP0lqEP/kRDZnmgBkNtzVWqr3eSLvjGXZL02
 n8BC3nv3KtwIkuKP2sFjJk4VDB7SwNa9DgxjzQ+QJ9n0mXnILw+XdMRxywzmbXynTS
 utqdiUxH08egw==
Message-ID: <sashiko-outbox-187202@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 3/3] drm/xe: Add a minimum age gate to the shrinker
To: "Matthew Brost" <matthew.brost@intel.com>, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20261027224902.1085762-4-matthew.brost@intel.com>
References: <20261027224902.1085762-1-matthew.brost@intel.com>
 <20261027224902.1085762-4-matthew.brost@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 23:17:11 +0000
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

commit e6e467b2b2dcc54cbb4e9022c6f181631ac6573a
Author: Matthew Brost <matthew.brost@intel.com>

drm/xe: Add a minimum age gate to the shrinker

This commit adds a minimum age gate to the xe shrinker so recently used
buffer objects in TT are not backed up before a configurable delay
(shrinker_min_age_ms). It timestamps BOs on move into TT and at LRU bump
time, using either the VM bulk-move timestamp or the BO's own timestamp.

> diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
> index 42a6aa1a2e4a0..a4c0c6284a24d 100644
> --- a/drivers/gpu/drm/xe/xe_bo.c
> +++ b/drivers/gpu/drm/xe/xe_bo.c
> @@ -1357,9 +1357,92 @@ static int xe_bo_move(struct ttm_buffer_object *tt=
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
> +		WRITE_ONCE(bo->lru_stamp, jiffies);
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
> +	if (bo->bulk_move && xe_bo->vm)
> +		stamp =3D READ_ONCE(xe_bo->vm->lru_stamp);
> +	else
> +		stamp =3D READ_ONCE(xe_bo->lru_stamp);
> +
> +	return stamp && time_before(jiffies, stamp + min_age);
> +}

[Severity: Medium]
Can xe_bo_shrink_too_young() miss age updates for bulk-moved VM BOs when
reading only xe_bo->vm->lru_stamp?

In __xe_bo_create_locked(), every private user BO on a non-fault-mode VM is
attached to vm->lru_bulk_move:

drivers/gpu/drm/xe/xe_bo.c:__xe_bo_create_locked() {
	...
	bo =3D xe_bo_init_locked(xe, bo, tile, vm ? xe_vm_resv(vm) : NULL,
			       vm && !xe_vm_in_fault_mode(vm) &&
			       flags & XE_BO_FLAG_USER ?
			       &vm->lru_bulk_move : NULL, size,
			       cpu_caching, type, flags, NULL, exec);
	...
}

Because bo->bulk_move && xe_bo->vm is true for these BOs,
xe_bo_shrink_too_young() ignores xe_bo->lru_stamp (even though xe_bo_move()
updates bo->lru_stamp on move into XE_PL_TT) and only consults
xe_bo->vm->lru_stamp.

However, vm->lru_stamp is only updated in xe_vm_bump_lru(), which is
skipped in xe_exec_ioctl() for all LR-mode VMs:

drivers/gpu/drm/xe/xe_exec.c:xe_exec_ioctl() {
	...
	if (!err && !xe_vm_in_lr_mode(vm))
		xe_vm_bump_lru(vm, exec);
	...
}

For a preempt-fence LR VM (XE_VM_FLAG_LR_MODE without
XE_VM_FLAG_FAULT_MODE), private user BOs have bo->bulk_move set to
&vm->lru_bulk_move, but xe_exec_ioctl() never calls xe_vm_bump_lru(), and
preempt_rebind_work_func() only calls xe_vm_bump_lru() after an eviction or
invalidation triggers rebind work. As a result, vm->lru_stamp stays 0 until
a rebind occurs and remains frozen at the last rebind timestamp afterward.

In addition, on any non-fault-mode VM, when a private user BO is moved into
XE_PL_TT in xe_bo_move() while the VM's (XE_PL_TT, bo->priority) bulk-move
range is empty (such as before the first exec, or after prior TT BOs at
that priority were evicted or moved to VRAM), ttm_resource_init() and
ttm_lru_bulk_move_add() place the resource at the tail of
man->lru[bo->priority] without updating vm->lru_stamp.

When that happens, won't xe_bo_shrink_too_young() see a 0 or stale
vm->lru_stamp and treat a newly moved or active TT BO at the LRU tail as
old, both allowing it to be backed up immediately and failing to trigger
ttm_bo_lru_cursor_skip_priority() in xe_shrinker_lru_young() and
__xe_shrinker_walk()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027224902.1085=
762-1-matthew.brost@intel.com?part=3D3
