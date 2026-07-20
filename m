Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88BF1C44520
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 12:26:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6556890B2;
	Mon, 20 Jul 2026 12:26:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SHBCebY4";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9799E890B2
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 12:26:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D2D8660A6A;
 Mon, 20 Jul 2026 12:26:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CE951F000E9;
 Mon, 20 Jul 2026 12:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784550379;
 bh=3wX2n20ApLyFFwIPJ4KqwqgO9HuOLX8e/YNXZNe4B0o=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=SHBCebY41q0IVXM0T4ZYqUbKExm+by8jgzjJGjHytkGyEpW8CtwdYeCFpoKZ7p4jx
 Q5FmZOjkYJ0KSux2NOBoSFPzUneQH9NUdJz95WOADlfY36TMqK0dc7hbeYp9KuaCx6
 AdyDfX6J8HgXs4fjLBBMTNBOGvlstE38wnrjI7W1nAWkdTl0jNQDnXWr74uYjyg68t
 uyhI5hkJatzrhCs0zRTLNt1rF7I6/usgGzSDW4ZN/w1bZ6w9QbtFOwSaxXLAr7cBXw
 A+GeDt71qkFQIG40CAnR0MjdLqwPPgdR8NBAxSkDSCfelxO4/jgC/0dIquRVQ2dB90
 fqeJ2etjzDvcw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/2] gpu/buddy: replace dual-tree/force_merge with
 decoupled dirty tracker
To: "Arunpravin Paneer Selvam" <Arunpravin.PaneerSelvam@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260720121041.339981-1-Arunpravin.PaneerSelvam@amd.com>
References: <20260720121041.339981-1-Arunpravin.PaneerSelvam@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 12:26:18 +0000
Message-Id: <20260720122619.5CE951F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Critical] Mempool exhaustion and direct reclaim deadlock in dirty extent=
 allocation (`extent_alloc`).
- [High] `__gpu_buddy_free` misclassifies MIXED blocks as purely DIRTY, per=
manently losing track of clear pages.

Pre-existing issues:
- [High] Reclaim deadlock during block splitting due to `GFP_KERNEL` in `gp=
u_block_alloc`.
--

--- Patch [1]: [PATCH v6 1/2] gpu/buddy: replace dual-tree/force_merge with=
 decoupled dirty tracker ---
commit 8d70f22110bb225d8340a7718c3a49a77a89a42c
Author: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>

gpu/buddy: replace dual-tree/force_merge with decoupled dirty tracker
   =20
This commit replaces the dual-tree buddy allocator with a single free tree
and a decoupled out-of-band dirty tracker. Fully cleared free blocks are
tracked outside using an augmented interval rbtree to enable O(log E)
lookup of the largest cleared extents.

> diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
> index dc81fe0301ce8..755a0b9e47458 100644
> --- a/drivers/gpu/buddy.c
> +++ b/drivers/gpu/buddy.c

[ ... ]

> @@ -34,6 +35,418 @@
> +static int gpu_dirty_tracker_init(struct gpu_dirty_tracker *dirty_tracke=
r)
> +{
> +	dirty_tracker->root =3D RB_ROOT;
> +	dirty_tracker->total_dirty =3D 0;
> +
> +	dirty_tracker->extent_pool =3D
> +		mempool_create_slab_pool(GPU_DIRTY_EXTENT_POOL_MIN, slab_extents);

[Severity: Critical]
Can this mempool size of 1 lead to a starvation deadlock?

Many operations (such as gpu_buddy_reset_clear() or gpu_buddy_free_list())
might require multiple extent allocations in a single locked transaction.

If the slab allocator fails, mempool_alloc() could exhaust the single
reserve element and then loop indefinitely waiting for an element to be
freed.

Since the thread holding the lock is blocked, no elements can be freed,
which could cause a permanent deadlock.

> +	if (!dirty_tracker->extent_pool)
> +		return -ENOMEM;
> +
> +	return 0;
> +}

[ ... ]

> +static struct gpu_dirty_extent *extent_alloc(struct gpu_dirty_tracker *d=
irty_tracker)
> +{
> +	struct gpu_dirty_extent *dirty_extent;
> +
> +	dirty_extent =3D mempool_alloc(dirty_tracker->extent_pool, GFP_KERNEL);

[Severity: Critical]
Is it safe to use GFP_KERNEL here while holding a driver lock?

This allocation is performed while holding a driver lock. GFP_KERNEL sets
__GFP_DIRECT_RECLAIM, which allows direct memory reclaim.

If the shrinker attempts to acquire the same driver lock to evict memory,
it could result in an AB-BA deadlock.

> +
> +	return dirty_extent;
> +}

[ ... ]

> @@ -253,37 +770,37 @@ __get_buddy(struct gpu_buddy_block *block)
>  }
> =20
>  static unsigned int __gpu_buddy_free(struct gpu_buddy *mm,
> -				     struct gpu_buddy_block *block,
> -				     bool force_merge)
> +				     struct gpu_buddy_block *block)
>  {
> +	enum gpu_block_state block_state;
>  	struct gpu_buddy_block *parent;
>  	unsigned int order;
> =20
> -	while ((parent =3D block->parent)) {
> -		struct gpu_buddy_block *buddy;
> +	block_state =3D gpu_buddy_block_is_clear(block) ? GPU_BLOCK_CLEAR :
> +							GPU_BLOCK_DIRTY;

[Severity: High]
Does this misclassify mixed blocks as purely dirty?

If a block is in the GPU_BLOCK_MIXED state (where has_clear is true but
is_clear is false), this initialization sets it to GPU_BLOCK_DIRTY because
it doesn't check the has_clear flag.

If the block's buddy is also dirty, the parent block state evaluates to
dirty and clears its has_clear flag.

This could cause the clear memory tracked by the dirty tracker to become
permanently inaccessible to GPU_BUDDY_CLEAR_ALLOCATION requests, as the
free tree's augment flags will cause the allocator to skip the subtree,
resulting in premature -ENOSPC allocation failures.

> =20
> -		buddy =3D __get_buddy(block);
> +		if (!gpu_buddy_block_is_free(buddy))

[ ... ]

> @@ -696,7 +1139,7 @@ static void __gpu_buddy_undo_splits(struct gpu_buddy=
 *mm,
>  	     gpu_buddy_block_is_free(buddy))) {
>  		rbtree_remove(mm, block);
>  		mm->free_scoreboard[gpu_buddy_block_order(block)]--;
> -		__gpu_buddy_free(mm, block, false);
> +		__gpu_buddy_free(mm, block);

[Severity: High]
Does feeding free mixed blocks into __gpu_buddy_free() here lose track
of clear pages?

When split_block() succeeds but the subsequent allocation fails, this path
merges the free child blocks. If the block is mixed, passing it to
__gpu_buddy_free() without marking it fully dirty in the tracker will cause
the misclassification issue mentioned above.

>  	}
>  }

[ ... ]

[Severity: High]
This is a pre-existing issue, but is it safe to use GFP_KERNEL when
allocating buddy blocks in gpu_block_alloc()?

Looking at gpu_block_alloc() in drivers/gpu/buddy.c:

	block =3D kmem_cache_zalloc(slab_blocks, GFP_KERNEL);
	if (!block)
		return NULL;

This allocation can occur during block splitting in gpu_buddy_alloc_blocks()
and gpu_buddy_block_trim(), which are executed while holding the driver's
memory manager lock.

Since GFP_KERNEL allows direct reclaim, the shrinker could attempt to evict
VRAM blocks and acquire the same lock, causing an AB-BA deadlock.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720121041.3399=
81-1-Arunpravin.PaneerSelvam@amd.com?part=3D1
