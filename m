Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 349F4C61DBD
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 17:38:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1762A10EB20;
	Tue, 25 Aug 2026 17:38:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="k6AN4GkD";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFBF910EB20;
 Tue, 25 Aug 2026 17:38:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DF05760133;
 Tue, 25 Aug 2026 17:38:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5324E1F000E9;
 Tue, 25 Aug 2026 17:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787679498;
 bh=1i3kUg8BcIGBFzc3aF1gdwX+wnXAw69hX7cONb1GvzU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=k6AN4GkDE9Sbck8j9NTHO5x9hvB70fV9JF7zVC2wav6x2G5QehxXeQbcUv7mUS8i6
 gUhuVgMZ/T2t8eOV+ZQQL4oMu7l3ln7xHpALVGUD8BRhSzV6b8JYF89F6GC5s+U+S/
 qcjuU7DHc4vZKcBlnfgaooc4vll+3CVEZpeYHUDM8ThSu3ntqnt02zsGxgOJHRah3L
 lZdOtt9fN8GA8s7bC7NfMfGSdzN9dw9YZZLI+7PICadc3+m37U0mxqvi/RvnRkIX+W
 lfWAEwoCuNvsotF3f3c7KTzhetMyiIEwXQvlE45HTVV06uugHblNdTsWDgCTay+umT
 PPPu3yEQUqHUw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 1/2] gpu/buddy: replace dual-tree/force_merge with
 decoupled dirty tracker
To: "Arunpravin Paneer Selvam" <Arunpravin.PaneerSelvam@amd.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org
In-Reply-To: <20260825172432.80355-1-Arunpravin.PaneerSelvam@amd.com>
References: <20260825172432.80355-1-Arunpravin.PaneerSelvam@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 17:38:17 +0000
Message-Id: <20260825173818.5324E1F000E9@smtp.kernel.org>
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
- [High] Information leak due to extent_alloc() failure causing dirty VRAM =
to be incorrectly returned as clear memory.
- [High] Deadlock during direct memory reclaim because extent_alloc() uses =
GFP_KERNEL while holding the allocator lock.
- [Medium] State corruption and integer underflow in total_dirty due to ext=
ent split failures in gpu_dirty_tracker_remove_range().
--

commit 1a4e9ba2186b718711f70ef5e634d528dec6b22b
Author: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>

gpu/buddy: replace dual-tree/force_merge with decoupled dirty tracker

The current buddy allocator maintains separate clear_tree[] and
dirty_tree[] rbtrees per order, preventing coalescing between cleared
and dirty buddies. Under mixed workloads, this creates a merge barrier:
adjacent buddies frequently end up split across trees, forcing reliance
on __force_merge() during allocation.

> diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
> index 4d5ac375a538c..bfa6ef85f1186 100644
> --- a/drivers/gpu/buddy.c
> +++ b/drivers/gpu/buddy.c

[ ... ]

> +static struct gpu_dirty_extent *extent_alloc(struct gpu_dirty_tracker *d=
irty_tracker)
> +{
> +	return kmem_cache_alloc(slab_extents, GFP_KERNEL);
> +}

[Severity: High]
Does this code trigger a deadlock during direct memory reclaim?

This allocation is called from paths like gpu_buddy_free_list() where the
allocator's lock is explicitly held:

void gpu_buddy_free_list(struct gpu_buddy *mm, ...)
{
	...
	gpu_buddy_driver_lock_held(mm);
	__gpu_buddy_free_list(mm, objects, mark_clear, !mark_clear);
}

Since GFP_KERNEL allows blocking and invokes direct memory reclaim, the
shrinker (such as TTM's global shrinker) may attempt to swap out VRAM and
call back into the allocator to free blocks. This would attempt to acquire
the exact same driver allocator lock that is already held, leading to a
self-deadlock.

Should this use a non-reclaim flag like GFP_NOWAIT or be moved to a mempool
as hinted in the changelog (v6) to guarantee nodes without __GFP_NOFAIL?

[ ... ]

> +static void gpu_dirty_tracker_mark_dirty(struct gpu_dirty_tracker *dirty=
_tracker,
> +					 u64 start, u64 size)
> +{
> +	struct gpu_dirty_extent *left, *right, *dirty_extent;
> +	u64 end =3D start + size;
> +
> +	gpu_buddy_assert(size);

[ ... ]

> +	} else {
> +		/* Standalone extent. */
> +		dirty_extent =3D extent_alloc(dirty_tracker);
> +		if (!dirty_extent) {
> +			pr_warn_once("dirty extent allocation failed, skipping tracker update=
\n");
> +			return;
> +		}
> +		dirty_extent->start =3D start;
> +		dirty_extent->end   =3D end;
> +		insert_extent(dirty_tracker, dirty_extent);
> +	}
> +
> +	dirty_tracker->total_dirty +=3D size;
> +}

[Severity: High]
Can this early return on allocation failure lead to an information leak by
improperly classifying dirty memory as clear?

If extent_alloc() fails in gpu_dirty_tracker_mark_dirty(), the function
logs a warning and returns early without recording the dirty extent. When
this block is later queried in gpu_dirty_range_state(), the function will
find no overlapping dirty extent and default to GPU_BLOCK_CLEAR:

static enum gpu_block_state
gpu_dirty_range_state(struct gpu_dirty_tracker *dirty_tracker, ...)
{
	...
	return GPU_BLOCK_CLEAR;
}

Consequently, in mark_free(), the block is erroneously marked with
GPU_BUDDY_HEADER_CLEAR:

static void mark_free(struct gpu_buddy *mm,
		      struct gpu_buddy_block *block)
{
	enum gpu_block_state block_state;

	block_state =3D gpu_dirty_range_state(&mm->dirty,
					    gpu_buddy_block_offset(block),
					    gpu_buddy_block_size(mm, block));
	__mark_free(mm, block, block_state);
}

A subsequent allocation requesting GPU_BUDDY_CLEAR_ALLOCATION would be
handed this dirty block. The caller trusts the clear flag, skips the
hardware zeroing pass, and potentially exposes previous VRAM contents to a
new context. Is there a safe fallback when dirty tracking cannot be updated?

[ ... ]

> +static void gpu_dirty_tracker_remove_range(struct gpu_dirty_tracker *dir=
ty_tracker,
> +					   u64 start, u64 size)
> +{

[ ... ]

> +		if (extent_start < start && extent_end > end) {
> +			/*
> +			 * Removed range lies strictly inside this dirty extent:
> +			 * split it into the dirty left and right halves.
> +			 */
> +			struct gpu_dirty_extent *right =3D extent_alloc(dirty_tracker);
> +
> +			if (!right) {
> +				pr_warn_once("dirty extent allocation failed, skipping tracker updat=
e\n");
> +				dirty_extent =3D next;
> +				continue;
> +			}

[Severity: Medium]
Will an allocation failure here corrupt the rbtree state and cause
total_dirty to underflow?

If extent_alloc() fails while trying to split an extent in
gpu_dirty_tracker_remove_range(), it logs a warning and skips removal.
This leaves the old extent intact, encompassing the now-allocated block
range.=20

When the block is later freed, gpu_dirty_tracker_mark_dirty() searches for
contiguous neighbors. Because the old extent perfectly overlaps the freed
range rather than just adjoining it, it falls through to the standalone
extent creation branch and inserts a duplicate overlapping extent.

Furthermore, gpu_dirty_tracker_mark_dirty() then unconditionally adds to the
counter:

	dirty_tracker->total_dirty +=3D size;

This double-counting will eventually cause total_dirty to exceed mm->avail.
Since gpu_buddy_clear_avail() returns mm->avail - mm->dirty.total_dirty,
this wraps around to a huge U64 value, completely breaking the allocator's
clear/dirty steering logic.

Should failed splits mark the entire overlapping extent as dirty instead of
skipping, or should the allocator gracefully degrade?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825172432.8035=
5-1-Arunpravin.PaneerSelvam@amd.com?part=3D1
