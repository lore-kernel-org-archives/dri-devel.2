Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453A9606A319
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 12:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oK2+0BQ9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DC3A10E2ED;
	Wed, 21 Oct 2026 12:46:44 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C20810E29A;
 Wed, 21 Oct 2026 12:46:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 424F443954;
 Wed, 21 Oct 2026 12:46:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEB091F000CD;
 Wed, 21 Oct 2026 12:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792586798;
 bh=DSHGh9biCR4Z2aelLqBDwVZs/0FUQY9Qjl4/z4+adCY=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=oK2+0BQ9dhixcbCHRQn8jc4Kq1CAVRTyjsy6IOaROreywmIgGC9sMGCeD1epEKNin
 6JpAChW9dXVbnrOT5ID1NQqlKqklCqOG6vGcM5PudrE4bkYT+wym1Sn6euVRM9TEcK
 2vH54Ft5xFYZXrS3QLdtW727hapzOOyewrF1ogWJYLl8+XZL0qeeTBvCiCJVUw3L1F
 IjTKNjwPlrvdksROtvyCk/OlkIH0TGIBG15yHgZewmDLCvjkmlL0ZP1LpQNT37IAy1
 V5rrnd20LD0yi5e757EX/VASRFWK2i0pSS8o57m+2naWcp3YzbRMg6Z79K5colC4D4
 +evTWUS3gFa5A==
Message-ID: <sashiko-outbox-180272@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/2] gpu/buddy: add range-restricted contiguous
 allocation fallback
To: "Arunpravin Paneer Selvam" <arunpravin.paneerselvam@amd.com>,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
In-Reply-To: <20261021121813.1820345-2-arunpravin.paneerselvam@amd.com>
References: <20261021121813.1820345-1-arunpravin.paneerselvam@amd.com>
 <20261021121813.1820345-2-arunpravin.paneerselvam@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 12:46:37 +0000
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
- [Medium] gpu/buddy: spurious -ENOSPC in __alloc_contig_try_harder() for r=
ange allocs
--

commit 14acba1e552d60bba9eee2e544118f0040222647
Author: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>

gpu/buddy: add range-restricted contiguous allocation fallback

This commit extends __alloc_contig_try_harder() with a [range_start,
range_end) window and routes range-restricted contiguous allocations through
it when no single naturally aligned power-of-two block is available. It also
adds KUnit tests covering fragmented range-restricted contiguous allocation=
s.

> diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
> index 8eb5835d6944c..693176ee3daf9 100644
> --- a/drivers/gpu/buddy.c
> +++ b/drivers/gpu/buddy.c
> @@ -1723,43 +1723,32 @@ static int __gpu_buddy_alloc_range(struct gpu_bud=
dy *mm,
>  			     blocks, total_allocated_on_err);
>  }
> =20
> -static int __alloc_contig_aligned_retry(struct gpu_buddy *mm,
> -					u64 unaligned_offset,
> -					u64 size,
> -					u64 min_block_size,
> -					unsigned long flags,
> -					struct list_head *blocks)
> -{
> -	u64 aligned_offset =3D round_down(unaligned_offset, min_block_size);
> -
> -	return __gpu_buddy_alloc_range(mm, aligned_offset, size, flags,
> -				       NULL, blocks);
> -}
> -
>  static int __alloc_contig_try_harder(struct gpu_buddy *mm,
> +				     u64 range_start, u64 range_end,
>  				     u64 size,
>  				     u64 min_block_size,
>  				     unsigned long flags,
>  				     struct list_head *blocks)
>  {
> -	u64 rhs_offset, lhs_offset, filled;
> +	u64 rhs_offset, lhs_offset, filled, aligned;
>  	struct gpu_buddy_block *block;
> +	unsigned int min_order, order;
>  	struct rb_root *root;
>  	struct rb_node *iter;
>  	unsigned long pages;
> -	unsigned int order;
>  	u64 modify_size;
>  	int err;
> =20
> +	min_order =3D ilog2(min_block_size) - ilog2(mm->chunk_size);
> +
>  	modify_size =3D rounddown_pow_of_two(size);
>  	pages =3D modify_size >> ilog2(mm->chunk_size);
>  	order =3D fls(pages) - 1;
> -	if (order =3D=3D 0)
> -		return -ENOSPC;
> =20
> +retry_order:
>  	root =3D &mm->free_tree[order];
>  	if (RB_EMPTY_ROOT(root))
> -		return -ENOSPC;
> +		goto next_order;
> =20
>  	iter =3D rb_last(root);
>  	while (iter) {
> @@ -1767,25 +1756,48 @@ static int __alloc_contig_try_harder(struct gpu_b=
uddy *mm,
> =20
>  		rhs_offset =3D gpu_buddy_block_offset(block);
> =20
> +		if (rhs_offset >=3D range_end) {
> +			iter =3D rb_prev(iter);
> +			continue;
> +		}
> +		if (rhs_offset < range_start)
> +			break;
> +
>  		/* Allocate blocks traversing RHS */
>  		err =3D  __gpu_buddy_alloc_range(mm, rhs_offset, size,
>  					       flags, &filled, blocks);
>  		if (err && err !=3D -ENOSPC)
>  			return err;
> -		if (!err && IS_ALIGNED(rhs_offset, min_block_size))
> +
> +		if (!err)
> +			filled =3D size;
> +
> +		/* Clamp a full or partial fill that crosses range_end. */
> +		if (rhs_offset + filled > range_end) {
> +			gpu_buddy_free_list_internal(mm, blocks);
> +			filled =3D range_end - rhs_offset;
> +			err =3D -ENOSPC;
> +		}
> +
> +		if (!err && IS_ALIGNED(rhs_offset, min_block_size) &&
> +		    rhs_offset >=3D range_start)
>  			return 0;
> +
>  		if (!err) {
>  			/* Allocate the unaligned RHS offset using round_down */
>  			gpu_buddy_free_list_internal(mm, blocks);
> -			err =3D __alloc_contig_aligned_retry(mm, rhs_offset,
> -							   size,
> -							   min_block_size,
> -							   flags, blocks);
> -			if (!err)
> -				return 0;
> -			if (err !=3D -ENOSPC) {
> -				gpu_buddy_free_list_internal(mm, blocks);
> -				return err;
> +
> +			aligned =3D round_down(rhs_offset, min_block_size);
> +			if (aligned >=3D range_start &&
> +			    aligned + size <=3D range_end) {
> +				err =3D __gpu_buddy_alloc_range(mm, aligned, size,
> +							      flags, NULL, blocks);
> +				if (!err)
> +					return 0;
> +				if (err !=3D -ENOSPC) {
> +					gpu_buddy_free_list_internal(mm, blocks);
> +					return err;
> +				}
>  			}
>  			goto next;
>  		}
> @@ -1797,21 +1809,73 @@ static int __alloc_contig_try_harder(struct gpu_b=
uddy *mm,
> =20
>  		/* Allocate the unaligned LHS offset using round_down */
>  		gpu_buddy_free_list_internal(mm, blocks);
> -		err =3D __alloc_contig_aligned_retry(mm, lhs_offset,
> -						   size,
> -						   min_block_size,
> -						   flags, blocks);
> -		if (!err)
> -			return 0;
> -		if (err !=3D -ENOSPC) {
> -			gpu_buddy_free_list_internal(mm, blocks);
> -			return err;
> +
> +		aligned =3D round_down(lhs_offset, min_block_size);
> +		if (aligned >=3D range_start && aligned + size <=3D range_end) {
> +			err =3D __gpu_buddy_alloc_range(mm, aligned, size,
> +						      flags, NULL, blocks);
> +			if (!err)
> +				return 0;
> +			if (err !=3D -ENOSPC) {
> +				gpu_buddy_free_list_internal(mm, blocks);
> +				return err;
> +			}
>  		}
>  next:
>  		gpu_buddy_free_list_internal(mm, blocks);
>  		iter =3D rb_prev(iter);
>  	}
> =20
> +next_order:
> +	if (order > min_order) {
> +		order--;
> +		goto retry_order;
> +	}
> +
> +	/* A non-range request would already have used a larger free block. */
> +	if (!(flags & GPU_BUDDY_RANGE_ALLOCATION))
> +		return -ENOSPC;
> +
> +	/*
> +	 * Last resort: the span may sit inside a larger coalesced free block
> +	 * that the anchored search above never visits. Walk the higher-order
> +	 * free trees (bounded by the number of free blocks, not by the window
> +	 * size) and carve the highest aligned span that fits inside each block
> +	 * overlapping the window.
> +	 */
> +	for (order =3D fls(modify_size >> ilog2(mm->chunk_size));
> +	     order <=3D mm->max_order; order++) {
> +		for (iter =3D rb_last(&mm->free_tree[order]); iter;
> +		     iter =3D rb_prev(iter)) {
> +			u64 low, high;
> +
> +			block =3D rbtree_get_free_block(iter);
> +			low =3D max(gpu_buddy_block_offset(block), range_start);
> +			high =3D min(gpu_buddy_block_offset(block) +
> +				   gpu_buddy_block_size(mm, block), range_end);
> +
> +			if (gpu_buddy_block_offset(block) >=3D range_end)
> +				continue;
> +			if (gpu_buddy_block_offset(block) +
> +			    gpu_buddy_block_size(mm, block) <=3D range_start)
> +				break;
> +			if (high < low + size)
> +				continue;
> +
> +			aligned =3D round_down(high - size, min_block_size);
> +			if (aligned < low)
> +				continue;
> +
> +			err =3D __gpu_buddy_alloc_range(mm, aligned, size, flags,
> +						      NULL, blocks);
> +			if (!err)
> +				return 0;
> +			gpu_buddy_free_list_internal(mm, blocks);
> +			if (err !=3D -ENOSPC)
> +				return err;
> +		}
> +	}
> +
>  	return -ENOSPC;
>  }

[Severity: Medium]
Can __alloc_contig_try_harder() in drivers/gpu/buddy.c still return a
spurious -ENOSPC when gpu_buddy_alloc_blocks() falls back to it for a
range-restricted or min_block_size-aligned contiguous allocation, if the
valid contiguous span straddles a higher-order block boundary, a block
starting below range_start, or a trailing block smaller than min_block_size?

In the first pass, the anchored search starts at
order =3D fls(pages) - 1, breaks out of the free_tree walk as soon as
rhs_offset < range_start:

		if (rhs_offset < range_start)
			break;

and stops descending at min_order:

	if (order > min_order) {
		order--;
		goto retry_order;
	}

In the second pass, the higher-order free_tree walk clips each individual
free block to [range_start, range_end) via [low, high) and requires the
entire request to fit inside that single block's clipped window:

			if (high < low + size)
				continue;

			aligned =3D round_down(high - size, min_block_size);
			if (aligned < low)
				continue;

Because the second pass only tests placements contained within a single
higher-order block and never stitches across adjacent free blocks, it looks
like valid contiguous placements are missed in three cases:

1. A span straddling two higher-order blocks. For example, with chunk_size
of 4K, if [16K, 32K) is free at order 2 and [32K, 64K) is free at order 3, a
request for size =3D 12K, min_block_size =3D 4K in [24K, 40K) finds free_tr=
ee[1]
and free_tree[0] empty in the first pass. The second pass clips [16K, 32K)
to [24K, 32K) (8K < 12K) and [32K, 64K) to [32K, 40K) (8K < 12K), skipping
both and returning -ENOSPC even though the entire [24K, 40K) window is free.

2. A span straddling a block that starts below range_start and an adjacent
higher-order block. With the same free blocks [16K, 32K) at order 2 and
[32K, 64K) at order 3, a request for size =3D 20K, min_block_size =3D 4K in
[20K, 44K) starts at order 2, sees rhs_offset =3D 16K < range_start (20K), =
and
breaks without probing from range_start. The second pass clips [32K, 64K) to
[32K, 44K) (12K < 20K) and skips it, returning -ENOSPC when [20K, 44K) is
completely free.

3. A span straddling a higher-order block and a trailing free block with
order < min_order. Since min_block_size constrains the start alignment of
the contiguous span rather than the size of trailing blocks stitched into
it, if [0, 16K) is free at order 2 and [16K, 20K) is free at order 0, a
request for size =3D 12K, min_block_size =3D 8K (min_order =3D 1) in [8K, 2=
4K)
stops descending at min_order =3D 1 without visiting [16K, 20K) at order 0,
and the second pass skips [0, 16K) because [8K, 16K) is only 8K (< 12K),
missing the valid 8K-aligned placement at [8K, 20K).

Should the anchored search instead start from mm->max_order down to order 0,
and clamp blocks that start below range_start (with rhs_offset + block_size=
 >
range_start) to start probing at range_start?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021121813.1820=
345-1-arunpravin.paneerselvam@amd.com?part=3D2
