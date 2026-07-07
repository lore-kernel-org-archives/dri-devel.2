Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86044C43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 14:27:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF76210E4E9;
	Tue,  7 Jul 2026 14:27:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FXfQJp7e";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4395D10E4E9
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 14:26:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8171C6138A;
 Tue,  7 Jul 2026 14:26:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F8261F000E9;
 Tue,  7 Jul 2026 14:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783434418;
 bh=9GgURgcnexXaQMTnA2ehitBzYL0V82wNJET8sMaH+qU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=FXfQJp7eXqjp4tBiU988u6tBO62Vi2O3uXrUG1duyMT5kIDOaxzUeiR3c38uRwWwQ
 rDEsW0VxebDkibVuOOKs8bGCl1H/ghiVSm5uMWUEtOSxyD5xTtCEPCnUMi/E/0RNqn
 /1+3Wuw9utdGyTifA1xbsoccOTc1F9jdsuFPOSrYORUQS2k+7FgEbIoHkkAOUhauWr
 mgCwt41I7/3JQ+sncuvQQxrD49JUuEpRSCWJ65rX+zCvCiBnw/kn7pZghI5bplqw62
 2DXDJP4CalQc2PrU2HmJUxtapujdAvzO7fW/BXU0aWFCC9KmSZttihL4ht+ebMYinV
 OKGm9Y7237p4A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/2] gpu/buddy: replace dual-tree/force_merge with
 decoupled dirty tracker
To: "Arunpravin Paneer Selvam" <Arunpravin.PaneerSelvam@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260707141238.711499-1-Arunpravin.PaneerSelvam@amd.com>
References: <20260707141238.711499-1-Arunpravin.PaneerSelvam@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 14:26:57 +0000
Message-Id: <20260707142658.0F8261F000E9@smtp.kernel.org>
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
- [High] Deadlock during memory reclaim due to GFP_KERNEL allocation in the=
 free path.
- [High] The dirty tracking steering logic completely breaks offset-aligned=
 allocations by bypassing min_block_size constraints.
- [Medium] The GPU_BUDDY_CLEAR_ALLOCATION preference is silently ignored in=
 multiple allocation paths.
- [Medium] The search traversal in __alloc_range_bias was inadvertently inv=
erted, fragmenting bottom-up allocations.
--

--- Patch [1]: [PATCH v5 1/2] gpu/buddy: replace dual-tree/force_merge with=
 decoupled dirty tracker ---
commit e512e6b2757e1aa8f79b4b91f5353e83198e524e
Author: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>

gpu/buddy: replace dual-tree/force_merge with decoupled dirty tracker

The current buddy allocator maintains separate clear_tree[] and
dirty_tree[] rbtrees per order, preventing coalescing between cleared
and dirty buddies. This patch replaces the dual-tree design with a single
free_tree[] rbtree and a lightweight out-of-band dirty tracker.

> diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
> index dc81fe0301ce8..288a85d9e95e1 100644
> --- a/drivers/gpu/buddy.c
> +++ b/drivers/gpu/buddy.c
> @@ -34,6 +35,411 @@
>  #endif
> =20
>  static struct kmem_cache *slab_blocks;
> +static struct kmem_cache *slab_extents;
> +
> +enum gpu_block_state {
> +	GPU_BLOCK_CLEAR,
> +	GPU_BLOCK_MIXED,
> +	GPU_BLOCK_DIRTY,
> +};
> +
> +/*
> + * Dirty tracker

[ ... ]

> +RB_DECLARE_CALLBACKS_MAX(static, gpu_dirty_augment_cb,
> +			 struct gpu_dirty_extent, rb,
> +			 u64, subtree_max_size,
> +			 extent_size)
> +
> +static struct gpu_dirty_extent *extent_alloc(void)
> +{
> +	return kmem_cache_zalloc(slab_extents, GFP_KERNEL | __GFP_NOFAIL);
> +}

[Severity: High]
If the system is under memory pressure, the kernel invokes the driver's
shrinker/eviction code to free VRAM. The eviction process holds driver locks
and frees buddy blocks, which calls into this allocation on the free path.

Could this GFP_KERNEL allocation inside the free path cause the shrinker to
block indefinitely waiting for memory, leading to a deadlock?

[ ... ]

> @@ -751,9 +1152,6 @@ __alloc_range_bias(struct gpu_buddy *mm,
>  				continue;
>  		}
> =20
> -		if (!fallback && block_incompatible(block, flags))
> -			continue;
> -
>  		if (contains(start, end, block_start, block_end) &&
>  		    order =3D=3D gpu_buddy_block_order(block)) {

[Severity: Medium]
The block_incompatible check was removed here. Additionally, functions like
gpu_buddy_find_block_aligned and get_maxblock appear to return the first
structurally matching block without checking the new has_clear or
subtree_has_clear fields.

Will this cause the GPU_BUDDY_CLEAR_ALLOCATION preference to be silently
ignored during range, aligned, and top-down allocations?

>  			/*
> @@ -771,64 +1169,35 @@ __alloc_range_bias(struct gpu_buddy *mm,
>  				goto err_undo;
>  		}
> =20
> -		list_add(&block->right->tmp_link, &dfs);
>  		list_add(&block->left->tmp_link, &dfs);
> +		list_add(&block->right->tmp_link, &dfs);
>  	} while (1);

[Severity: Medium]
The list_add function inserts items at the head, acting as a LIFO stack. By
pushing the left child and then the right child, the right child becomes the
head of the list and is popped first.

Does this inadvertently invert the search traversal to right-to-left
(highest address first), causing bottom-up allocations to fragment?

[ ... ]

> @@ -1282,18 +1684,36 @@ __gpu_buddy_alloc_blocks(struct gpu_buddy *mm,
>  			 unsigned int order,
>  			 unsigned long flags)
>  {
> -	if (flags & GPU_BUDDY_RANGE_ALLOCATION)
> +	struct gpu_buddy_block *block;
> +	bool steered =3D false;
> +
> +	/* Allocate from dirty tracker */
> +	if (!(flags & GPU_BUDDY_RANGE_ALLOCATION) &&
> +	    !(flags & GPU_BUDDY_CLEAR_ALLOCATION) &&
> +	    mm->clear_avail && mm->dirty.total_dirty) {
> +		u64 block_size =3D mm->chunk_size << order;
> +
> +		steered =3D dirty_steer_window(mm, block_size,
> +					     &start, &end, &flags);
> +	}
> +
> +	if (flags & GPU_BUDDY_RANGE_ALLOCATION) {
>  		/* Allocate traversing within the range */
> -		return  __gpu_buddy_alloc_range_bias(mm, start, end,
> -						     order, flags);
> -	else if (size < min_block_size)
> +		block =3D __alloc_range_bias(mm, start, end, order, flags);
> +		if (!IS_ERR(block) || !steered)
> +			return block;

[Severity: High]
A caller might request an offset-aligned allocation where the requested size
is smaller than min_block_size. The dirty steering logic here uses block_si=
ze
(which equals size, lacking the min_block_size alignment requirement) and
forces a range allocation.

Since __alloc_range_bias returns the block directly here, does this
completely bypass the gpu_buddy_offset_aligned_allocation logic and return a
misaligned block to the caller?

> +
> +		flags &=3D ~GPU_BUDDY_RANGE_ALLOCATION;
> +	}
> +
> +	if (size < min_block_size)
>  		/* Allocate from an offset-aligned region without size rounding */
>  		return gpu_buddy_offset_aligned_allocation(mm, size,
>  							   min_block_size,
>  							   flags);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707141238.7114=
99-1-Arunpravin.PaneerSelvam@amd.com?part=3D1
