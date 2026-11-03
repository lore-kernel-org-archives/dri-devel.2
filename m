Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1102B606A326
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 13:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B8lfgcHn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CC4C10E7F7;
	Tue,  3 Nov 2026 13:09:40 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A79510E7F7;
 Tue,  3 Nov 2026 13:09:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1CA9043E2B;
 Tue,  3 Nov 2026 13:09:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8FBD1F00A17;
 Tue,  3 Nov 2026 13:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793711374;
 bh=7UiSEZE7ULVZaxkgrq2ycvaZiVN2Qjwwb3QCywp+cqE=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=B8lfgcHnj1xB2KvQm1A+tR41mPxkHstaPpZRqvKQERtP53LJLY1VqT561+lq+CY4F
 3H59pi3Ha2gPNzKNj1CDlKsBoRDjE3sDJcAWVoGglf2xjrBkhuTb4Gv1S5t2kMKGod
 kDsU+NwAzii5UIXxk10H1cudAQfbEXlEo/9kGkxdVlpEIkUB8CyKVfYrch6XqG4x3Z
 YVetGP9cufYavKmXivm28LRJ84AETPKdcqv/DVcmvRjUGZRX9D0NAp3AVnNG45Nhv2
 YIPCdGtym3vndaTZIX2qsJWjwKb3tkvirWqxBrUA2eROC5o2vaEXstZpWD/X9CxQoM
 LO3sXNkwFdSgw==
Message-ID: <sashiko-outbox-195310@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] gpu/buddy: restore two-pass clear/dirty guard for
 range-biased allocation
To: "Arunpravin Paneer Selvam" <arunpravin.paneerselvam@amd.com>,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
In-Reply-To: <20261103125617.2480786-1-arunpravin.paneerselvam@amd.com>
References: <20261103125617.2480786-1-arunpravin.paneerselvam@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 13:09:33 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] gpu/buddy: leaked split on range-straddling mixed block in __alloc=
_range_bias()
--

commit caf65a7be15ef66d98faecfc731749477d23b658
Author: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>

gpu/buddy: restore two-pass clear/dirty guard for range-biased allocation

This commit introduces a two-pass clear/dirty eligibility check in
__alloc_range_bias() via block_incompatible() so that range-biased
allocations avoid splitting opposite-class extents during the initial strict
pass before falling back when -ENOSPC is returned. It also accepts mixed
blocks at the requested order as-is and adds a KUnit regression test for
range-biased clear/dirty separation.

> diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
> index 28cff97d57dc8..f2914f919b04a 100644
> --- a/drivers/gpu/buddy.c
> +++ b/drivers/gpu/buddy.c
> @@ -1240,11 +1240,23 @@ static void __gpu_buddy_undo_splits(struct gpu_bu=
ddy *mm,
>  	}
>  }
> =20
> +static bool block_incompatible(struct gpu_buddy_block *block, unsigned i=
nt flags)
> +{
> +	bool needs_clear =3D flags & GPU_BUDDY_CLEAR_ALLOCATION;
> +
> +	if (!gpu_buddy_block_is_free(block))
> +		return false;
> +
> +	return needs_clear ? !block->has_clear :
> +			     gpu_buddy_block_is_clear(block);
> +}
> +
>  static struct gpu_buddy_block *
>  __alloc_range_bias(struct gpu_buddy *mm,
>  		   u64 start, u64 end,
>  		   unsigned int order,
> -		   unsigned long flags)
> +		   unsigned long flags,
> +		   bool fallback)
>  {

[ ... ]

> @@ -1298,6 +1308,9 @@ __alloc_range_bias(struct gpu_buddy *mm,
>  				continue;
>  		}
> =20
> +		if (!fallback && block_incompatible(block, flags))
> +			continue;
> +
>  		if (contains(start, end, block_start, block_end) &&
>  		    order =3D=3D gpu_buddy_block_order(block)) {
>  			/*
> @@ -1315,38 +1328,8 @@ __alloc_range_bias(struct gpu_buddy *mm,
>  				goto err_undo;
>  		}
> =20
> -		/*
> -		 * Top-down is a strict address-placement policy, so when it is
> -		 * requested we ignore clear steering and simply descend the
> -		 * right (higher-address) child first. Only a non-top-down clear
> -		 * request biases the descent towards clear/has_clear subtrees.
> -		 */
> -		if ((flags & GPU_BUDDY_CLEAR_ALLOCATION) &&
> -		    !(flags & GPU_BUDDY_TOPDOWN_ALLOCATION)) {
> -			struct gpu_buddy_block *prefer;
> -
> -			if (gpu_buddy_block_is_clear(block->right))
> -				prefer =3D block->right;
> -			else if (gpu_buddy_block_is_clear(block->left))
> -				prefer =3D block->left;
> -			else if (block->right->has_clear)
> -				prefer =3D block->right;
> -			else if (block->left->has_clear)
> -				prefer =3D block->left;
> -			else
> -				prefer =3D block->right;
> -
> -			if (prefer =3D=3D block->right) {
> -				list_add(&block->left->tmp_link, &dfs);
> -				list_add(&block->right->tmp_link, &dfs);
> -			} else {
> -				list_add(&block->right->tmp_link, &dfs);
> -				list_add(&block->left->tmp_link, &dfs);
> -			}
> -		} else {
> -			list_add(&block->left->tmp_link, &dfs);
> -			list_add(&block->right->tmp_link, &dfs);
> -		}
> +		list_add(&block->left->tmp_link, &dfs);
> +		list_add(&block->right->tmp_link, &dfs);
>  	} while (1);

[Severity: High]
Can __alloc_range_bias() still leave an unmerged split block (and leak the
child gpu_buddy_block allocations on teardown) when a free mixed block of
order greater than the target order straddles the start or end boundary of
the requested [start, end) range?

In __alloc_range_bias(), block_incompatible() returns false for any free
mixed block because block->has_clear is true and gpu_buddy_block_is_clear()
is false across the whole block span. Dropping unsplit_block() relies on the
assumption that splitting a mixed block during the strict pass
(fallback =3D=3D false) will always find at least one compatible descendant=
 at
the target order.

However, when a free mixed block with order > target order only partially
overlaps [start, end), it passes the adjusted range check in
__alloc_range_bias():

	if (block_start < start || block_end > end) {
		u64 adjusted_start =3D max(block_start, start);
		u64 adjusted_end =3D min(block_end, end);

		if (round_down(adjusted_end + 1, req_size) <=3D
		    round_up(adjusted_start, req_size))
			continue;
	}

	if (!fallback && block_incompatible(block, flags))
		continue;

	...

	if (!gpu_buddy_block_is_split(block)) {
		err =3D split_block(mm, block);
		if (unlikely(err))
			goto err_undo;
	}

If the compatible portion that made the parent mixed lies in the child
outside [start, end) while the child inside [start, end) is purely
opposite-class (for example, clear when a dirty allocation is requested),
split_block() splits the parent into two free children, the out-of-range
child is skipped by the range check, and the in-range child is rejected by
block_incompatible().

When the allocation is then satisfied elsewhere in the tree, the split pare=
nt
is left in GPU_BUDDY_SPLIT state with both children simultaneously in
GPU_BUDDY_FREE state:

1. If the mixed block straddles end (e.g. a 4 MiB allocator with 1 MiB
   chunks where [0, 1M) is dirty free, [1M, 2M) is allocated, and [2M, 4M)
   is a coalesced free mixed block with [2M, 3M) clear and [3M, 4M) dirty),
   a 1 MiB dirty range allocation over [0, 3M) visits [2M, 4M) first, splits
   it, rejects [3M, 4M) as out of range and [2M, 3M) via
   block_incompatible(), and then succeeds at [0, 1M) during the strict pass
   without running the fallback pass.

2. If the mixed block straddles start (e.g. [0, 2M) is a free mixed block
   with [0, 1M) dirty and [1M, 2M) clear, and [2M, 4M) is clear free), a
   1 MiB dirty range allocation over [1M, 4M) skips [2M, 4M) in the strict
   pass, splits [0, 2M) and rejects both halves, fails the strict pass with
   -ENOSPC, and then satisfies the request from [3M, 4M) in the fallback
   pass before visiting [0, 2M).

Because neither child of the abandoned split node is allocated, freeing
other blocks never coalesces across the GPU_BUDDY_SPLIT parent in
__gpu_buddy_free(), leaving the buddy tree permanently fragmented and
triggering gpu_buddy_assert(gpu_buddy_block_is_free(mm->roots[i])) in
gpu_buddy_fini() while leaking the descendant gpu_buddy_block structures in
slab_blocks.

Should __alloc_range_bias() still undo rejected splits when descending
blocks that are not fully contained within [start, end), or check compatibi=
lity
against the in-range portion?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103125617.2480=
786-1-arunpravin.paneerselvam@amd.com?part=3D1
