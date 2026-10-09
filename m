Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4289CA601D
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 10:23:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 083F010E642;
	Fri,  9 Oct 2026 10:23:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YEHf+7vZ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E06AD10E534;
 Fri,  9 Oct 2026 10:23:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5471F41845;
 Fri,  9 Oct 2026 10:23:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB5391F000FF;
 Fri,  9 Oct 2026 10:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791541434;
 bh=EEjyWeU7pRUTKISGlRq7AuuLy2vaAmNqNUBeOCEZ/u0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=YEHf+7vZsq1NgPiXvd+A2CXn4Ly0l1Jz0JxdOPPVbCzZHw2PSp8x0evN0i9S91f94
 heZNhJtZ4Dq+UfM1JlWS9VWD4SNM8LBJMhpuLOkMdrqxs3dhysYJLd8OcDzVTYSkib
 gSbLL8vD+ccWponP6QUlgqusoZ0LoiZV9fGxbKbS5NsUkX095sfDWHNNlbCWyvmUMi
 hYtl9yXcU/xpYc/nnzXN2aeX6s8GfsjX4PbPmyGWqPCafhAZTeEyEhjoFYaWbyC1QA
 1coSr0GRBwPcYg0CaDm34/mIOdAnwsAC+3Rf7G8BUh/XLd3/LcdqDiu3uH7YmFRPFd
 3xZJvER69UFCQ==
Message-ID: <sashiko-outbox-165224@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/3] gpu/buddy: add range-restricted contiguous
 allocation fallback
To: "Arunpravin Paneer Selvam" <arunpravin.paneerselvam@amd.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org
In-Reply-To: <20261009100546.1103622-2-arunpravin.paneerselvam@amd.com>
References: <20261009100546.1103622-1-arunpravin.paneerselvam@amd.com>
 <20261009100546.1103622-2-arunpravin.paneerselvam@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 10:23:53 +0000
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
- [High] mm: gpu/buddy try-harder fails range allocation when free space ex=
ceeds range_end
- [High] mm: gpu/buddy try-harder misses higher-order blocks for range allo=
cations
--

commit 3089b8dadc6718a57b0162914961a76a654e9d6b
Author: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Subject: gpu/buddy: add range-restricted contiguous allocation fallback

This commit adds support for range-restricted contiguous allocation
fallback in the GPU buddy allocator. It extends __alloc_contig_try_harder
to confine candidate placements to a specified [range_start, range_end)
window.

> diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
> index 6566bad4fef15..1f648bcfce574 100644
> --- a/drivers/gpu/buddy.c
> +++ b/drivers/gpu/buddy.c
> @@ -1682,26 +1682,14 @@ static int __gpu_buddy_alloc_range(struct gpu_bud=
dy *mm,
[ ... ]
>  static int __alloc_contig_try_harder(struct gpu_buddy *mm,
> +				     u64 range_start, u64 range_end,
>  				     u64 size,
>  				     u64 min_block_size,
>  				     unsigned long flags,
>  				     struct list_head *blocks)
>  {

[Severity: High]
Does the try-harder fallback miss higher-order blocks for range allocations?

When this function is called as a fallback, it derives an order based on the
unrounded size and searches exclusively in mm->free_tree[order]:

        modify_size =3D rounddown_pow_of_two(size);
        pages =3D modify_size >> ilog2(mm->chunk_size);
        order =3D fls(pages) - 1;
        ...
        root =3D &mm->free_tree[order];
        if (RB_EMPTY_ROOT(root))
                return -ENOSPC;

However, for range contiguous allocations, the normal allocation pass round=
s up
the requested size. If a higher-order block intersects the range but cannot
fit the rounded-up size within the bounds, it gets skipped and is not split.

If this occurs, the valid contiguous space remains in a higher-order tree.

Since the try-harder fallback only checks the single derived order's tree,
will it fail immediately with -ENOSPC, missing the free space that resides =
in
the unsplit, higher-order blocks?

> -	u64 rhs_offset, lhs_offset, filled;
> +	u64 rhs_offset, lhs_offset, filled, aligned;
>  	struct gpu_buddy_block *block;
>  	struct rb_root *root;
>  	struct rb_node *iter;
> @@ -1726,25 +1714,36 @@ static int __alloc_contig_try_harder(struct gpu_b=
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
> +		if (!err && IS_ALIGNED(rhs_offset, min_block_size) &&
> +		    rhs_offset >=3D range_start && rhs_offset + size <=3D range_end)
>  			return 0;
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

[Severity: High]
Does this bypass the left-shift fallback when free space exceeds range_end?

__alloc_contig_try_harder() attempts to place a contiguous block by calling
__gpu_buddy_alloc_range() without passing range_end.

If the contiguous free space extends beyond range_end, this allocation fully
succeeds and returns err =3D=3D 0.

Because the allocation succeeded, the condition aligned + size <=3D range_e=
nd
will evaluate to false if the memory exceeds the requested range, and the c=
ode
hits goto next:

                        if (aligned >=3D range_start &&
                            aligned + size <=3D range_end) {
                                ...
                        }
                        goto next;
                }

This completely skips the lhs_offset fallback path that normally follows:

                if (size - filled > rhs_offset)
                        goto next;
                lhs_offset =3D rhs_offset - (size - filled);
                ...

Had the allocator been bounded by range_end, it would have returned -ENOSPC
with filled set, triggering the left-shift fallback to perfectly slide the
allocation into the requested range.

Will the presence of extra free memory outside the range cause valid contig=
uous
allocations to spuriously fail?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009100546.1103=
622-1-arunpravin.paneerselvam@amd.com?part=3D2
