Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A6C9C5AC82
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 09:30:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3656110E761;
	Mon, 10 Aug 2026 09:30:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ojpoUteh";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8670E10E761
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 09:30:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0130543D6F;
 Mon, 10 Aug 2026 09:30:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 146061F000E9;
 Mon, 10 Aug 2026 09:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786354216;
 bh=PVIOzFK2qRLs9lfPHOamCVmb7juYH53B0KTvYbVBOFY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ojpoUtehrm4281nGpDxgSOEU68rnvM7y34TD01elBrGJ7k+TxpLTRyWOZKVAdj92s
 ySnZZQA4bQl7+yZOVlEBq9psHYkDvTgm6Uil9JxFG20V8Ms25f/tEVQt4+/vAbF+rQ
 S5AioUGuZyj2AOKQXFWGDbAHwncY1RYZtwLy4vtcTtu8v0CfxqBwVkTfATX42AQHaA
 MW4Vq7zHUCTsHdJdoZN+k7RsD4BFQ5KETx26V1M/Mo/tZLTfA57BqqBD9rZWpL+fvw
 Ehash+t7a86AhNTA+mGthRpNU6GA9WhLdim4wcIbgTgDLSbJnWCwA4rcmvgiJHhLR7
 YewtN8KeLwfBw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 1/2] gpu/buddy: replace dual-tree/force_merge with
 decoupled dirty tracker
To: "Arunpravin Paneer Selvam" <Arunpravin.PaneerSelvam@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260810091231.11936-1-Arunpravin.PaneerSelvam@amd.com>
References: <20260810091231.11936-1-Arunpravin.PaneerSelvam@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 09:30:15 +0000
Message-Id: <20260810093016.146061F000E9@smtp.kernel.org>
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
- [High] Deadlock via mempool exhaustion under the buddy allocator lock
- [Medium] has_clear flag is not reset upon allocation, corrupting the free=
 tree's clear-steering heuristic
--

--- Patch [1]: [PATCH v8 1/2] gpu/buddy: replace dual-tree/force_merge with=
 decoupled dirty tracker ---
commit 2bd11b8a5badb80e1216b4be0ddab3e1dbd3cdbb
Author: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>

gpu/buddy: replace dual-tree/force_merge with decoupled dirty tracker

This commit replaces the dual-tree buddy allocator with a single free tree
and a decoupled dirty tracker to avoid merging barriers during mixed
workloads. It removes the O(N) __force_merge scan and instead uses an
augmented interval rbtree for tracking dirty extents.

> diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
> --- a/drivers/gpu/buddy.c
> +++ b/drivers/gpu/buddy.c
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

[Severity: High]
Could this lead to a deadlock through mempool exhaustion under the buddy
allocator lock?

The comment assumes that because GFP_KERNEL can sleep for reclaim, it will
eventually succeed without __GFP_NOFAIL. However, during an OOM event,
kmalloc can fail and return NULL.

If this happens during a loop in gpu_buddy_reset_clear() or=20
__gpu_buddy_free_list() while holding the driver lock, the first allocation
failure consumes the single reserved mempool element.

A subsequent allocation failure in the same loop would block in
mempool_alloc() waiting for a free element. Since the blocking thread holds
the driver lock, no other thread can enter the allocator to free extents,
which seems like it would cause an unrecoverable deadlock.

[ ... ]
> +static inline enum gpu_block_state
> +gpu_block_cached_state(struct gpu_buddy_block *block)
> +{
> +	if (gpu_buddy_block_is_clear(block))
> +		return GPU_BLOCK_CLEAR;
> +	if (block->has_clear)
> +		return GPU_BLOCK_MIXED;
> +	return GPU_BLOCK_DIRTY;
> +}

[Severity: Medium]
Will this read a stale has_clear flag for blocks that were allocated without
being split?

Looking at mark_allocated(), the has_clear flag is not reset when the block
changes to the allocated state. If a block previously evaluated as
GPU_BLOCK_MIXED is allocated at its natural order and given to the driver,
has_clear remains true.

When the block is later freed, __gpu_buddy_free() uses this cached state
instead of querying the dirty tracker, inserting the now fully dirty block
into the free tree as MIXED.

Would it be better to reset has_clear when the block is marked as allocated
to prevent the tree's augmentation from diverging from the actual dirty
tracker state?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260810091231.1193=
6-1-Arunpravin.PaneerSelvam@amd.com?part=3D1
