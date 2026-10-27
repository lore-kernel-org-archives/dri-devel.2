Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D098B606A31A
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 20:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=USerJRNk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EEA910F827;
	Tue, 27 Oct 2026 20:50:53 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEB6B10F827;
 Tue, 27 Oct 2026 20:50:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BCD1C60211;
 Tue, 27 Oct 2026 20:50:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4083B1F01825;
 Tue, 27 Oct 2026 20:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793134245;
 bh=TuaeLEOpigXbx6pmjWGhDvzeqZvPeg2WYFOPoPESNYk=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=USerJRNkopE4a5HArO8y1BBiVg8XPnfkRlXJD+AwIYcLs0gtFEsIampmuWTXKo7vO
 wCu7SwTgF6zuHS71vzuOjJ2L6jNjQ6U7/fgUWFmvWDJH1I8YsJaG/8ERFAvaFaOSzw
 LenXN+XrIIL0M9ja2zYaRRjFmFAwKS6J0OvAgPdnzQW3nXhn52NjE0fwwMxQrt5y7x
 apEazV62/3hxnLgWw2gINQCA8gqsHiETxVGyZWdsrcVWFjWT9o/fdm+/Wk7r2pbtWg
 c21fHhlsJGpBF/ZON5psy4q2+xCDcBk1+UcBSUHT84zqRCNdBhQ1Kv55N7Kiyyf3+m
 SUabpYzSnMcRg==
Message-ID: <sashiko-outbox-187101@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/3] drm/xe: Add a minimum age gate to the shrinker
To: "Matthew Brost" <matthew.brost@intel.com>, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20261027203107.1065800-4-matthew.brost@intel.com>
References: <20261027203107.1065800-1-matthew.brost@intel.com>
 <20261027203107.1065800-4-matthew.brost@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 20:50:44 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] drm/xe: missing lru_lock around xe_bo_bump_lru_locked() in pagefau=
lt
- [Medium] drm/xe: __xe_shrinker_walk() fails to skip priority on GPU-busy =
young BOs
--

commit b66983cf80f56fab6416b52fa5320ec4dd988b90
Author: Matthew Brost <matthew.brost@intel.com>

drm/xe: Add a minimum age gate to the shrinker

This commit adds a minimum age gate to the non-purgeable BO shrinker,
configured via Kconfig and a per-device shrinker_min_age_ms sysfs attribute.
BOs and VM bulk moves are timestamped when their LRU positions are updated =
so
the shrinker can skip backing up recently used BOs.

> diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
> index 42a6aa1a2e4a0..a4c0c6284a24d 100644
> --- a/drivers/gpu/drm/xe/xe_bo.c
> +++ b/drivers/gpu/drm/xe/xe_bo.c
> @@ -1357,9 +1357,92 @@ static int xe_bo_move(struct ttm_buffer_object *tt=
m_bo, bool evict,

[ ... ]

> +/**
> + * xe_bo_bump_lru_locked() - Bump a BO on the LRU and stamp its last use
> + * @bo: The buffer object, reserved by the caller.
> + *
> + * Move @bo to the tail of its LRU and record the time for the shrinker's
> + * minimum age gate. Only meaningful for BOs outside a bulk move, since a
> + * BO in one is anchored inside its range and is bumped, and aged, with =
it.
> + * The caller must hold the device LRU lock.
> + */
> +void xe_bo_bump_lru_locked(struct xe_bo *bo)
> +{
> +	WRITE_ONCE(bo->lru_stamp, jiffies);
> +	ttm_bo_move_to_lru_tail(&bo->ttm);
> +}

[ ... ]

> diff --git a/drivers/gpu/drm/xe/xe_pagefault.c b/drivers/gpu/drm/xe/xe_pa=
gefault.c
> index 7d363160103ab..8e25bc67772e4 100644
> --- a/drivers/gpu/drm/xe/xe_pagefault.c
> +++ b/drivers/gpu/drm/xe/xe_pagefault.c
> @@ -225,7 +225,7 @@ static int xe_pagefault_handle_vma(struct xe_gt *gt, =
struct xe_vma *vma,
>  			}
> =20
>  			if (bo)
> -				ttm_bo_move_to_lru_tail(&bo->ttm);
> +				xe_bo_bump_lru_locked(bo);

[Severity: High]
Does xe_pagefault_handle_vma() need to hold vm->xe->ttm.lru_lock around
xe_bo_bump_lru_locked(bo)?

While the pre-existing ttm_bo_move_to_lru_tail() call here also lacked
lru_lock, xe_bo_bump_lru_locked() requires the caller to hold the device LRU
lock because the call chain:

  xe_pagefault_handle_vma()
    xe_bo_bump_lru_locked()
      ttm_bo_move_to_lru_tail()
        ttm_resource_move_to_lru_tail()

asserts lockdep_assert_held(&bo->bdev->lru_lock) and mutates the shared LRU
lists via list_move_tail(). Without acquiring vm->xe->ttm.lru_lock, servici=
ng
a GPU page fault on a BO-backed VMA will trigger a lockdep warning and race
with concurrent TTM LRU operations.

> diff --git a/drivers/gpu/drm/xe/xe_shrinker.c b/drivers/gpu/drm/xe/xe_shr=
inker.c
> index c86455ea08d18..c650726ff6ded 100644
> --- a/drivers/gpu/drm/xe/xe_shrinker.c
> +++ b/drivers/gpu/drm/xe/xe_shrinker.c

[ ... ]

> @@ -139,6 +143,16 @@ static int __xe_shrinker_walk(struct xe_shrinker *sh=
rinker,
>  			if (!ttm_bo_shrink_suitable(ttm_bo, ctx))
>  				continue;
> =20
> +			/*
> +			 * Each LRU priority is roughly age ordered, so the
> +			 * rest of this priority is most likely young too.
> +			 * Move on to the next priority.
> +			 */
> +			if (xe_bo_shrink_too_young(ttm_bo, min_age)) {
> +				ttm_bo_lru_cursor_skip_priority(&curs);
> +				continue;
> +			}

[Severity: Medium]
Should the xe_bo_shrink_too_young() check in __xe_shrinker_walk() happen
before ttm_bo_shrink_suitable(), or otherwise not depend on ctx->no_wait_gp=
u?

In xe_shrinker_walk(), the first pass (and the only pass during direct
reclaim when ttm_bo_shrink_avoid_wait() is true) forces ctx->no_wait_gpu to
true:

  swap(no_wait_gpu, ctx->no_wait_gpu);
  save_flags.writeback =3D false;
  ret =3D __xe_shrinker_walk(shrinker, ctx, save_flags, min_age,
                           to_scan, scanned, freed);
  swap(no_wait_gpu, ctx->no_wait_gpu);

When ctx->no_wait_gpu is true, ttm_bo_shrink_suitable() returns false for a=
ny
BO with unsignaled GPU fences:

  bool ttm_bo_shrink_suitable(struct ttm_buffer_object *bo,
                              struct ttm_operation_ctx *ctx)
  {
          return bo->ttm && ttm_tt_is_populated(bo->ttm) && !bo->pin_count =
&&
                  (!ctx->no_wait_gpu ||
                   dma_resv_test_signaled(bo->base.resv,
                                          DMA_RESV_USAGE_BOOKKEEP));
  }

Because BOs that were recently moved into TT or bumped by an exec are likely
to still have active GPU fences, they will fail ttm_bo_shrink_suitable() and
hit continue before reaching xe_bo_shrink_too_young(). Won't that prevent
ttm_bo_lru_cursor_skip_priority(&curs) from triggering and cause
__xe_shrinker_walk() to walk every busy young BO in the priority list witho=
ut
advancing *scanned?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027203107.1065=
800-1-matthew.brost@intel.com?part=3D3
