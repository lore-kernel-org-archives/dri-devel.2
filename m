Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35D58C43458
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 22:18:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C09910F988;
	Fri, 10 Jul 2026 22:18:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NESl6tmi";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E3C110F988
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 22:18:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 17AA942E60;
 Fri, 10 Jul 2026 22:18:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C342E1F000E9;
 Fri, 10 Jul 2026 22:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783721928;
 bh=AQGW7U2OSOGVthlzh/txLbwRZCF5AMX8rH4nYsLJsTk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NESl6tmiTlrtvinKdJKr9b0pTx/0hoZ4FR6TSdTaowzKejfmnoEsmtSJiu/E/isQd
 f/I9MUki4BdXi+c96cptMKbodnv6EysjT4nirhv3s5HrWj0yIceGabdIkyf/28qeNr
 oc2Ubf8ZOubR2VIGAIdzpa5uF1bOOmblu3b2333UZGdRyJebW27PFH9T39PKhqRLEl
 3/Y5vaU8yDfiT8+zkgCo7p/A1keTvHKeWGB+efJVLf3oH6ECpsednA2XYDHV7M8r7i
 Xuq13gFJg+XvHz06qiYvCYZflKCcc2OIDsoY4s13adeaujBy9ObuvN7lOAhC+ZKmPZ
 rRT+NZlDBJEyQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 15/33] drm/xe: Track BOs backed at a sub-optimal page
 order
To: "Matthew Brost" <matthew.brost@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260710215442.2444235-16-matthew.brost@intel.com>
References: <20260710215442.2444235-1-matthew.brost@intel.com>
 <20260710215442.2444235-16-matthew.brost@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 22:18:47 +0000
Message-Id: <20260710221847.C342E1F000E9@smtp.kernel.org>
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
- [Medium] BOs moved to SYSTEM memory during a failed shrinker purge are in=
correctly left on the defrag list.
- [Medium] Framebuffer pinning bypasses defrag list tracking updates, viola=
ting the invariant that pinned BOs are removed from the list.
--

--- Patch [15]: [PATCH v2 15/33] drm/xe: Track BOs backed at a sub-optimal =
page order ---
commit d8c62c56c566775d903f43756778e071af0acb80
Author: Matthew Brost <matthew.brost@intel.com>

    drm/xe: Track BOs backed at a sub-optimal page order

    Add per-device tracking of BOs whose backing TT pages were allocated
    below the pool's beneficial order, as reported by the
    TTM_TT_FLAG_BENEFICIAL_ORDER_FAILED tt page flag. These BOs are future
    candidates for a defragmentation pass that reallocates their pages at t=
he
    beneficial order.

> diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
> index cca617cf34d13..d7b0536564ab2 100644
> --- a/drivers/gpu/drm/xe/xe_bo.c
> +++ b/drivers/gpu/drm/xe/xe_bo.c
[ ... ]
> @@ -1261,6 +1358,15 @@ static long xe_bo_shrink_purge(struct ttm_operatio=
n_ctx *ctx,
>  	if (lret > 0) {
>  		xe_ttm_tt_account_subtract(xe, bo->ttm);
>  		update_global_total_pages(bo->bdev, -(long)tt->num_pages);
> +
> +		/*
> +		 * The pages are gone, so a tracked BO no longer needs defrag.
> +		 * This shrinker purge path frees pages without going through
> +		 * xe_bo_move(), so drop any stale defrag list entry here. Ghost
> +		 * bos are never tracked, so guard for real xe bos.
> +		 */
> +		if (xe_bo_is_xe_bo(bo))
> +			xe_bo_defrag_remove(ttm_to_xe_bo(bo));
>  	}
> =20
>  	return lret;

[Severity: Medium]
When xe_bo_shrink_purge() attempts to purge a BO, it uses ttm_bo_move_null(=
) to
move it to XE_PL_SYSTEM, which bypasses xe_bo_defrag_update().=20

If the subsequent ttm_bo_shrink() call fails (lret <=3D 0), this explicit
xe_bo_defrag_remove() is skipped.

Could this leave a tracked BO in SYSTEM memory while incorrectly remaining =
on
the defrag list, violating the tracking invariant and wasting worker cycles?

[ ... ]
> @@ -3072,6 +3183,8 @@ int xe_bo_pin(struct xe_bo *bo, struct drm_exec *ex=
ec)
>  	if (bo->ttm.ttm && ttm_tt_is_populated(bo->ttm.ttm))
>  		xe_ttm_tt_account_subtract(xe, bo->ttm.ttm);
> =20
> +	xe_bo_defrag_remove(bo);
> +
>  	/*
>  	 * FIXME: If we always use the reserve / unreserve functions for locking
>  	 * we do not need this.

[Severity: Medium]
Will this miss defrag list tracking updates for framebuffer BOs?

xe_fb_pin() and __xe_unpin_fb_vma() in drivers/gpu/drm/xe/display/xe_fb_pin=
.c
call ttm_bo_pin() and ttm_bo_unpin() directly rather than using this
xe_bo_pin() wrapper.

If a framebuffer BO resides in XE_PL_TT with sub-optimal page allocations,
could it remain on the defrag list even when pinned, causing the defrag
worker to incorrectly process pinned BOs?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710215442.2444=
235-1-matthew.brost@intel.com?part=3D15
