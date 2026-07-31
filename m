Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 265A4C55167
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 07:21:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8697A10F1A2;
	Fri, 31 Jul 2026 07:21:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UgVW/q0J";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0D3010F1A2
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 07:21:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 50CE444043;
 Fri, 31 Jul 2026 07:21:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 144C21F000E9;
 Fri, 31 Jul 2026 07:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785482493;
 bh=qMGreFJNXY3S1v8XX5OR0esOzssbxtGhbJ/+/fY25N0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UgVW/q0JWZon+8V8CS4ag8l+lXamO8gd6p79S2kIm54b4+v3/08x6Ln36aNiSQ+lv
 QmjZetHZbFaNHXIO2N/9U1wUZPnlJPN/GKkiUhuPyqeN7g2NTADs+I8kOJAhNG1pWX
 wiLf3iqo8ckpas7x/1OBROAwPtDTR17YBtUmqH9bNEI9ERmnYyCyS2q72Xdku6NaaR
 K2WEqZKxC7dbxXid+rMh87AxFPN+AFKp1mfwoi1OKqCoo0b9QmRhyD1PKFZ8aM7Jo2
 qxKab+yLOJq7cn+wO/Kqbf1SbzrLwHlrAnup+nGGaf08+6pp4dmLxCfOcOK3eTRpXR
 fUqxI4bBDEo0w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 1/2] gpu/buddy: replace dual-tree/force_merge with
 decoupled dirty tracker
To: "Arunpravin Paneer Selvam" <Arunpravin.PaneerSelvam@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260731070741.2654251-1-Arunpravin.PaneerSelvam@amd.com>
References: <20260731070741.2654251-1-Arunpravin.PaneerSelvam@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 07:21:32 +0000
Message-Id: <20260731072133.144C21F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Mempool deadlock in `gpu_buddy_reset_clear` and free paths during =
extent allocation when multiple extents are required within a single locked=
 section.
--

--- Patch [1]: [PATCH v7 1/2] gpu/buddy: replace dual-tree/force_merge with=
 decoupled dirty tracker ---
commit e1f55d34ee0b3bd852cd9853e793c8cbdf7fc6f6
Author: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>

gpu/buddy: replace dual-tree/force_merge with decoupled dirty tracker

This commit replaces the dual-tree buddy allocator design with a single free
tree and an out-of-band dirty tracker using an augmented interval rbtree. It
also moves extent allocations to a mempool to guarantee progress and avoid
deadlocks associated with __GFP_NOFAIL.

> diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
> --- a/drivers/gpu/buddy.c
> +++ b/drivers/gpu/buddy.c
> @@ -34,6 +35,441 @@
>  #endif
> =20
>  static struct kmem_cache *slab_blocks;
> +static struct kmem_cache *slab_extents;
> +
> +/*
> + * A single reserved extent suffices. Every allocation uses GFP_KERNEL
> + * from sleepable context, so the underlying slab alloc almost always
> + * succeeds via reclaim; the reserve only backstops the rare case where
> + * it still returns NULL (e.g. the current task is an OOM victim),
> + * guaranteeing a non-NULL extent without __GFP_NOFAIL. Because each
> + * alloc can independently wait for reclaim, the reserve need not scale
> + * with the number of extents added in one locked section (e.g. by
> + * gpu_buddy_reset_clear()).
> + */
> +#define GPU_DIRTY_EXTENT_POOL_MIN 1

[ ... ]

> +static struct gpu_dirty_extent *extent_alloc(struct gpu_dirty_tracker *d=
irty_tracker)
> +{
> +	/*
> +	 * The void free/reset paths must record an extent and cannot handle
> +	 * failure, so the mempool reserve guarantees a non-NULL return
> +	 * without __GFP_NOFAIL. GFP_KERNEL is safe under the buddy lock: no
> +	 * driver frees buddy blocks from a shrinker, so reclaim cannot
> +	 * recurse into the lock we hold.
> +	 */
> +	return mempool_alloc(dirty_tracker->extent_pool, GFP_KERNEL);
> +}

[ ... ]

> +static int gpu_dirty_tracker_init(struct gpu_dirty_tracker *dirty_tracke=
r)
> +{
> +	dirty_tracker->root =3D RB_ROOT;
> +	dirty_tracker->total_dirty =3D 0;
> +
> +	dirty_tracker->extent_pool =3D
> +		mempool_create_slab_pool(GPU_DIRTY_EXTENT_POOL_MIN, slab_extents);
> +	if (!dirty_tracker->extent_pool)
> +		return -ENOMEM;
> +
> +	return 0;
> +}

[ ... ]

> @@ -572,42 +1055,39 @@ static int split_block(struct gpu_buddy *mm,
>   */
>  void gpu_buddy_reset_clear(struct gpu_buddy *mm, bool is_clear)
>  {
> -	enum gpu_buddy_free_tree src_tree, dst_tree;
> -	u64 root_size, size, start;
> -	unsigned int order;
> -	int i;
> +	unsigned int i;
> =20
>  	gpu_buddy_driver_lock_held(mm);

[ ... ]

> +	for (i =3D 0; i <=3D mm->max_order; ++i) {
> -		struct rb_root *root =3D &mm->free_trees[src_tree][i];
>  		struct gpu_buddy_block *block, *tmp;
> =20
> -		rbtree_postorder_for_each_entry_safe(block, tmp, root, rb) {
> -			rbtree_remove(mm, block);
> +		rbtree_postorder_for_each_entry_safe(block, tmp,
> +						     &mm->free_tree[i], rb) {
>  			if (is_clear) {
> -				mark_cleared(block);
> -				mm->clear_avail +=3D gpu_buddy_block_size(mm, block);
> +				if (!gpu_buddy_block_is_clear(block))
> +					block->header |=3D GPU_BUDDY_HEADER_CLEAR;
> +				block->has_clear =3D true;
> +			} else if (gpu_buddy_block_is_clear(block)) {
> +				block->header &=3D ~GPU_BUDDY_HEADER_CLEAR;
> +				block->has_clear =3D false;
> +				gpu_dirty_tracker_mark_dirty(&mm->dirty,
> +							     gpu_buddy_block_offset(block),
> +							     gpu_buddy_block_size(mm, block));

[Severity: High]
Could this loop trigger a mempool deadlock during memory pressure?

In gpu_dirty_tracker_init(), the extent pool is created with a minimum
size of GPU_DIRTY_EXTENT_POOL_MIN (1). However, this loop in
gpu_buddy_reset_clear() holds the driver lock and iterates over the free
tree, potentially calling gpu_dirty_tracker_mark_dirty() multiple times.

If the underlying slab allocation fails during extent_alloc(),
mempool_alloc() will use the single reserved extent. If a second allocation
fails within the same locked section, mempool_alloc() with GFP_KERNEL will
sleep and retry indefinitely.

Since the driver lock is held, no other thread can free blocks to return
extents to the mempool, resulting in a deadlock. Does the mempool reserve
need to scale with the maximum number of extents that can be allocated
in a single locked section?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731070741.2654=
251-1-Arunpravin.PaneerSelvam@amd.com?part=3D1
