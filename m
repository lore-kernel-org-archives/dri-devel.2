Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C56B606A325
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 20:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jV5//+ET
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BEF010F81F;
	Tue, 27 Oct 2026 20:44:23 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 593C610F81C;
 Tue, 27 Oct 2026 20:44:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7AFB060211;
 Tue, 27 Oct 2026 20:44:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F33A11F01828;
 Tue, 27 Oct 2026 20:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793133854;
 bh=AX1cjS8Utg5r1vJjFBgBSl7iDwhdoaePqXHrPp7DtWw=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=jV5//+ETP/l+CDJzR+AXuzhT53HgFgBdy1wJwyY9o+KZ/zE/Bbb8G7BsHhxp5lNVS
 t7GHc/ByZFhNX2KG3+su37sXVCEx2VXh6F4vRA9Zo3oJ5G7TsM3j83jnTa+NR2Hlik
 S9nC81pgUMdJHJ8GdBIEjfXlzOE2kNWh/Ceuiraa/nBrLH4IU6luTfT2h07TUf/hlm
 ezZ6MtBMgXXryqcrMnhY8JvqdG3EliCinthklaeFulz+/2NuOBVZ7RcAVwQaNP1OOw
 E/C/o2FemgLpYVxm2t75rx4x0NoKK6JdmS+rxY3+4MyjiqdzWottYszWQb7dTMSl4x
 /vT+6gXvpScWQ==
Message-ID: <sashiko-outbox-187097@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/3] drm/xe: Bump the LRU on a successful page fault
To: "Matthew Brost" <matthew.brost@intel.com>, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20261027203107.1065800-2-matthew.brost@intel.com>
References: <20261027203107.1065800-1-matthew.brost@intel.com>
 <20261027203107.1065800-2-matthew.brost@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 20:44:13 +0000
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
- [Critical] drm/xe: missing lru_lock in xe_pagefault_handle_vma() LRU bump
--

commit 5192e1a5e7b4819fce82dbbbf32300162b7b7460
Author: Matthew Brost <matthew.brost@intel.com>

drm/xe: Bump the LRU on a successful page fault

This commit moves a VMA's backing BO to the tail of the TTM LRU after
successfully servicing a page fault so active fault-mode BOs are not
prematurely evicted or shrunk.

> diff --git a/drivers/gpu/drm/xe/xe_pagefault.c b/drivers/gpu/drm/xe/xe_pa=
gefault.c
> index 5247321c805ec..7d363160103ab 100644
> --- a/drivers/gpu/drm/xe/xe_pagefault.c
> +++ b/drivers/gpu/drm/xe/xe_pagefault.c
> @@ -201,6 +201,8 @@ static int xe_pagefault_handle_vma(struct xe_gt *gt, =
struct xe_vma *vma,
>  		xe_validation_ctx_init(&ctx, &vm->xe->val, &exec,
>  				       (struct xe_val_flags) {});
>  		drm_exec_until_all_locked(&exec) {
> +			struct xe_bo *bo =3D xe_vma_bo(vma);
> +
>  			err =3D xe_pagefault_begin(&exec, vma, tile->mem.vram,
>  						 needs_vram =3D=3D 1);
>  			drm_exec_retry_on_contention(&exec);
> @@ -221,6 +223,9 @@ static int xe_pagefault_handle_vma(struct xe_gt *gt, =
struct xe_vma *vma,
>  				xe_pagefault_set_error(pf, XE_PAGEFAULT_ERROR_VMA_REBIND);
>  				break;
>  			}
> +
> +			if (bo)
> +				ttm_bo_move_to_lru_tail(&bo->ttm);

[Severity: Critical]
Should xe_pagefault_handle_vma() call ttm_bo_move_to_lru_tail_unlocked()
here (or acquire bo->ttm.bdev->lru_lock around the call) instead of calling
ttm_bo_move_to_lru_tail() directly?

At this point in xe_pagefault_handle_vma(), only the VM and BO dma_resv
locks (via drm_exec), vma->fault_lock, and vm->lock are held, not
bo->ttm.bdev->lru_lock.

When a page fault occurs on a BO-backed VMA with a valid bo->ttm.resource,
the call chain xe_pagefault_handle_vma() -> ttm_bo_move_to_lru_tail() ->
ttm_resource_move_to_lru_tail() expects bo->bdev->lru_lock to be held:

drivers/gpu/drm/ttm/ttm_bo.c:ttm_bo_move_to_lru_tail() {
	dma_resv_assert_held(bo->base.resv);

	if (bo->resource)
		ttm_resource_move_to_lru_tail(bo->resource);
}

drivers/gpu/drm/ttm/ttm_resource.c:ttm_resource_move_to_lru_tail() {
	struct ttm_buffer_object *bo =3D res->bo;
	struct ttm_device *bdev =3D bo->bdev;

	lockdep_assert_held(&bo->bdev->lru_lock);

	if (ttm_resource_unevictable(res, bo)) {
		list_move_tail(&res->lru.link, &bdev->unevictable);

	} else if (bo->bulk_move) {
		struct ttm_lru_bulk_move_pos *pos =3D
			ttm_lru_bulk_move_pos(bo->bulk_move, res);

		ttm_lru_bulk_move_pos_tail(pos, res);
	} else {
		struct ttm_resource_manager *man;

		man =3D ttm_manager_type(bdev, res->mem_type);
		list_move_tail(&res->lru.link, &man->lru[bo->priority]);
	}
}

Without holding bo->bdev->lru_lock, won't this trigger a lockdep assertion
and race with concurrent LRU list users (such as other pagefault workers,
xe_vm_bump_lru(), resource init/fini, eviction, and the shrinker),
corrupting the shared LRU lists?

Also, a later commit in this series (b66983cf80f5) replaces this call with
xe_bo_bump_lru_locked(bo), which still calls ttm_bo_move_to_lru_tail() and
requires the caller to hold the device LRU lock without acquiring it in
xe_pagefault_handle_vma().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027203107.1065=
800-1-matthew.brost@intel.com?part=3D1
