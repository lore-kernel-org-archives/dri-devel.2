Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE7AFC5DF87
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 10:55:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7066010EDCF;
	Wed, 19 Aug 2026 10:55:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="oF3x6KnK";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B1E610EDCF;
 Wed, 19 Aug 2026 10:55:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C700243A88;
 Wed, 19 Aug 2026 10:55:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86F791F000E9;
 Wed, 19 Aug 2026 10:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787136907;
 bh=7iTTHZ3xcjQ92zAwzvSRQN7vRFF2cZlUVYWYvh1+G4g=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=oF3x6KnKpX7dD0MpBjA8rIPM8pZgXWN7b47LuVNPGwTDuUO0yQu9DID27XcW2/+9q
 KOwMm4J54T7GlieXetYq4McxdFlkag5TkqNMX720GLfEjnnIYQsuOugdwY85yG4vW4
 U52GBPgnodcp3Rp+pHOiWch1Y1VlfIt90xkuSE2goSWT77AFXeR8i/XbKFS64ZM4pi
 R6NQIlGtg0N7uGs4aSHnoXNIJnEbk9IXOBJIIJBma1EeXqLHWiTvWf+NVRbRZ/TjZv
 +g2QnLbWJNf40f25Vo5vdgiz7zBwpr8/Z6e8h8AKUYs9HkEi12DKtB/vR0ptA6IXrA
 L1/MZHCpQBSvw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 1/2] gpu/buddy: replace dual-tree/force_merge with
 decoupled dirty tracker
To: "Arunpravin Paneer Selvam" <Arunpravin.PaneerSelvam@amd.com>
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260819104242.10703-1-Arunpravin.PaneerSelvam@amd.com>
References: <20260819104242.10703-1-Arunpravin.PaneerSelvam@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 10:55:07 +0000
Message-Id: <20260819105507.86F791F000E9@smtp.kernel.org>
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
- [Critical] Failing to allocate a dirty extent causes dirty memory to be f=
alsely classified as clear, leaking uninitialized data to userspace.
- [High] Failing to allocate a dirty extent during `remove_range` corrupts =
the interval tree with overlapping extents and underflows `clear_avail`.
- [High] Using `GFP_KERNEL` allocation on the free path under the allocator=
 lock creates a direct reclaim lock recursion deadlock risk.
--

--- Patch [1]: [PATCH v10 1/2] gpu/buddy: replace dual-tree/force_merge wit=
h decoupled dirty tracker ---
commit 81520a8dbad12cdd20c2cfc232d134998aef3e50
Author: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>

gpu/buddy: replace dual-tree/force_merge with decoupled dirty tracker

The current buddy allocator maintains separate clear_tree[] and dirty_tree[]
rbtrees per order, preventing coalescing between cleared and dirty buddies.
This replaces the dual-tree design with a single free_tree and a lightweight
out-of-band dirty tracker interval rbtree, removing the force_merge step and
allowing unconditional coalescing.

> diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
> --- a/drivers/gpu/buddy.c
> +++ b/drivers/gpu/buddy.c

[ ... ]

> @@ -118,6 +118,11 @@ RB_DECLARE_CALLBACKS_MAX(static, gpu_dirty_augment_c=
b,
> +static struct gpu_dirty_extent *extent_alloc(struct gpu_dirty_tracker *d=
irty_tracker)
> +{
> +	return kmem_cache_alloc(slab_extents, GFP_KERNEL);
> +}

[Severity: High]
Could the use of GFP_KERNEL here lead to a lock recursion deadlock?

When called from the free path in gpu_buddy_free_block() via
gpu_dirty_tracker_mark_dirty(), the driver's buddy allocator lock is
held. Since GFP_KERNEL permits direct memory reclaim, memory pressure
could cause the kernel to invoke DRM shrinkers. If a shrinker attempts
to free VRAM objects, it would try to acquire the exact same allocator
lock.

Would it be safer to use GFP_NOWAIT or a pre-allocated mempool for these
tracker allocations?

[ ... ]

> @@ -240,6 +240,49 @@ static void gpu_dirty_tracker_fini(struct gpu_dirty_=
tracker *dirty_tracker)
> +static void gpu_dirty_tracker_mark_dirty(struct gpu_dirty_tracker *dirty=
_tracker,
> +					 u64 start, u64 size)
> +{

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

[Severity: High]
Does skipping the tracker update on allocation failure risk leaking
uninitialized memory to userspace?

If extent_alloc() fails under memory pressure and we return early, the
newly dirty memory becomes completely untracked. When this block is
eventually freed or split, gpu_dirty_range_state() will incorrectly
return GPU_BLOCK_CLEAR because it cannot find the extent.

This causes __mark_free() to set the GPU_BUDDY_HEADER_CLEAR flag. If a
user process subsequently requests a cleared allocation, the driver will
trust this flag, skip the hardware zeroing pass, and hand out dirty
memory.

[ ... ]

> @@ -294,6 +294,76 @@ static void gpu_dirty_tracker_mark_dirty(struct gpu_=
dirty_tracker *dirty_tracker,
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
> +
> +			remove_extent(dirty_tracker, dirty_extent);

[Severity: High]
Can a failure to allocate the right-half extent here corrupt the
interval tree and underflow the available clear memory counter?

If extent_alloc() fails, the code skips splitting the extent and leaves
the entire encompassing old extent in the tree, bypassing the
total_dirty size subtraction.

Later, when the newly allocated block is freed,
gpu_dirty_tracker_mark_dirty() will attempt to add it back. Because the
block falls strictly inside the stale extent rather than abutting it, it
fails to merge and inserts an overlapping extent. This breaks the
non-overlapping invariant of the tree and double-counts the size in
total_dirty, which can eventually exceed the total available memory and
cause an unsigned underflow in gpu_buddy_clear_avail().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819104242.1070=
3-1-Arunpravin.PaneerSelvam@amd.com?part=3D1
