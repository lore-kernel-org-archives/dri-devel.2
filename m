Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3669FC79FA0
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 12:42:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91C7C10E7CB;
	Mon,  7 Sep 2026 12:42:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZITITFx8";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 958C010E7CB;
 Mon,  7 Sep 2026 12:42:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AA0BE601F9;
 Mon,  7 Sep 2026 12:42:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 747001F00A3A;
 Mon,  7 Sep 2026 12:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788784945;
 bh=f8Ts5w096nTiKZCsgWyuuaQSyrLHMVciXEBvXuyvVS0=;
 h=Date:From:To:Cc:Subject;
 b=ZITITFx8uPyUXZUFYcSbAoCPT3i8WwlexiJtFSU3SRyxz+4HIpmCfn/QpyIcGErHR
 8UyrS31z86K6sHFeK2L/SQ0t39So3lKYzPqDGVHuZS1j6yzVUcKIw+H/9mu4Yc6Fpj
 MwrUDqNksNkvdy5hqvN7z1fZn0QgR87qSBvUT3wVJNrLSpf98O+yv7K8FkilnJhdwY
 nkb2Z9E0gC28wy/j4cNR1xh3LiZKvBCb5zNJJsVeEa+X10nMQCb7kE4WkjmW0xvMjZ
 6w/7ZTrczi6RQZBdl64ta0+QtMR2ndabNw/Y2H9knEkSzxFCK1JkHJO3gFp1co5a/0
 UYTd8pAPIRDXQ==
Date: Mon, 7 Sep 2026 13:42:21 +0100
From: Mark Brown <broonie@kernel.org>
To: Simona Vetter <simona.vetter@ffwll.ch>,
 Intel Graphics <intel-gfx@lists.freedesktop.org>,
 DRI <dri-devel@lists.freedesktop.org>
Cc: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 Kees Cook <kees@kernel.org>, Kees Cook <kees+treewide@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the drm-misc tree with the origin tree
Message-ID: <ap6xLbBLVwjGlE-f@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="nD1t3RANhXFek32W"
Content-Disposition: inline
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>


--nD1t3RANhXFek32W
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm-misc tree got a conflict in:

  drivers/gpu/buddy.c

between commit:

  3a2c4d55e32ad ("treewide: refresh kmalloc_obj() conversions")

=66rom the origin tree and commit:

  1ad5e807f716f ("gpu/buddy: replace dual-tree/force_merge with decoupled d=
irty tracker")

=66rom the drm-misc tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --combined drivers/gpu/buddy.c
index 26e7a48b55f33,644586eb5941e..0000000000000
--- a/drivers/gpu/buddy.c
+++ b/drivers/gpu/buddy.c
@@@ -3,11 -3,14 +3,14 @@@
   * Copyright =A9 2021 Intel Corporation
   */
 =20
+ #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+=20
  #include <linux/bug.h>
  #include <linux/export.h>
  #include <linux/kmemleak.h>
  #include <linux/module.h>
  #include <linux/sizes.h>
+ #include <linux/slab.h>
 =20
  #include <linux/gpu_buddy.h>
 =20
@@@ -34,6 -37,430 +37,430 @@@
  #endif
 =20
  static struct kmem_cache *slab_blocks;
+ static struct kmem_cache *slab_extents;
+=20
+ /*
+  * Dirty tracker
+  * -------------
+  *
+  * The dirty tracker maintains an augmented interval rbtree of contiguous
+  * dirty address ranges, decoupled from the buddy free trees.
+  * Each node covers a maximal coalesced run; adjacent extents are merged
+  * on insertion so the tree always holds the smallest possible number of
+  * extents.  The augmentation field @subtree_max_size lets the allocator
+  * locate the largest dirty extent in O(log E).
+  *
+  * Free trees (mm->free_tree[])
+  * ----------------------------
+  *
+  * Per-order augmented rbtrees of FREE buddy blocks, keyed by offset.
+  * Every node carries:
+  *   - subtree_max_alignment: largest natural alignment in the subtree,
+  *     used by aligned/range allocations to skip unsuitable subtrees in
+  *     O(log N).
+  *   - subtree_block_state: the highest clear class (DIRTY < MIXED < CLEA=
R)
+  *     of any block in the subtree, maintained as a max augment. A value =
of
+  *     >=3D MIXED means a clear-or-mixed block exists; =3D=3D CLEAR means=
 a
+  *     fully-clear block exists.
+  *
+  * Block classes
+  * -------------
+  *
+  * Each FREE block falls into one of three classes, determined in
+  * mark_free() by querying the dirty tracker for the block's range:
+  *
+  *   clear   -- HEADER_CLEAR set; no dirty extent overlaps the range.
+  *   mixed   -- HEADER_CLEAR unset; range has both dirty and clear bytes.
+  *   dirty   -- HEADER_CLEAR unset; range is fully dirty.
+  *
+  * Clear allocation
+  * ----------------
+  *
+  * A clear (CLEAR_ALLOCATION) request prefers clear -> mixed -> dirty.
+  * Climbing from the requested order up to max_order, rbtree_last_clear_f=
ree_block()
+  * returns, in one O(log N) descent per order, the right-most clear-or-mi=
xed block
+  * (fully-clear preferred over mixed) at the lowest order whose free tree=
 contains
+  * such a block. Only if no clear-or-mixed block exists at any order >=3D=
 the
+  * requested one does it fall back to a dirty block.
+  *
+  * Clear state is reported to the driver per whole block via HEADER_CLEAR=
, so a
+  * fully-clear block of the requested order lets the driver skip the clea=
r pass.
+  *
+  * The effective allocation preference depends on how the driver handles
+  * freed blocks:
+  *
+  *   1) Never clear on free:
+  *      No free block contains clear bytes, so clear allocations always
+  *      fall back to dirty blocks.
+  *
+  *   2) Always clear on free:
+  *      Freed blocks become clear while untouched blocks remain dirty.
+  *      Merging clear and dirty buddies produces mixed blocks, which are
+  *      reclassified when split. Over time, clear blocks become dominant,
+  *      so clear allocations are typically satisfied from clear blocks,
+  *      following a clear -> mixed -> dirty preference.
+  *
+  *   3) Selective clear on free:
+  *      For each order examined, fully-clear blocks are preferred over
+  *      mixed blocks, and mixed blocks are preferred over dirty blocks.
+  *      If a clear or mixed block is found at an order, it is selected
+  *      without searching higher orders. Dirty blocks are used only when
+  *      no clear or mixed block exists at any eligible order.
+  */
+=20
+ static u64 extent_size(struct gpu_dirty_extent *dirty_extent)
+ {
+ 	return dirty_extent->end - dirty_extent->start;
+ }
+=20
+ RB_DECLARE_CALLBACKS_MAX(static, gpu_dirty_augment_cb,
+ 			 struct gpu_dirty_extent, rb,
+ 			 u64, subtree_max_size,
+ 			 extent_size)
+=20
+ static struct gpu_dirty_extent *extent_alloc(struct gpu_dirty_tracker *di=
rty_tracker)
+ {
+ 	return kmem_cache_alloc(slab_extents, GFP_KERNEL);
+ }
+=20
+ static void extent_free(struct gpu_dirty_tracker *dirty_tracker,
+ 			struct gpu_dirty_extent *dirty_extent)
+ {
+ 	kmem_cache_free(slab_extents, dirty_extent);
+ }
+=20
+ /* Return the rightmost extent whose start is strictly below @offset. */
+ static struct gpu_dirty_extent *
+ prev_extent(struct gpu_dirty_tracker *dirty_tracker, u64 offset)
+ {
+ 	struct rb_node *rb =3D dirty_tracker->root.rb_node;
+ 	struct gpu_dirty_extent *dirty_extent =3D NULL;
+=20
+ 	while (rb) {
+ 		struct gpu_dirty_extent *tmp_extent =3D
+ 			rb_entry(rb, struct gpu_dirty_extent, rb);
+=20
+ 		if (tmp_extent->start < offset) {
+ 			dirty_extent =3D tmp_extent;
+ 			rb =3D rb->rb_right;
+ 		} else {
+ 			rb =3D rb->rb_left;
+ 		}
+ 	}
+=20
+ 	return dirty_extent;
+ }
+=20
+ /* Return the leftmost extent whose start is at or above @offset. */
+ static struct gpu_dirty_extent *
+ next_extent(struct gpu_dirty_tracker *dirty_tracker, u64 offset)
+ {
+ 	struct rb_node *rb =3D dirty_tracker->root.rb_node;
+ 	struct gpu_dirty_extent *dirty_extent =3D NULL;
+=20
+ 	while (rb) {
+ 		struct gpu_dirty_extent *tmp_extent =3D
+ 			rb_entry(rb, struct gpu_dirty_extent, rb);
+=20
+ 		if (tmp_extent->start >=3D offset) {
+ 			dirty_extent =3D tmp_extent;
+ 			rb =3D rb->rb_left;
+ 		} else {
+ 			rb =3D rb->rb_right;
+ 		}
+ 	}
+=20
+ 	return dirty_extent;
+ }
+=20
+ static void insert_extent(struct gpu_dirty_tracker *dirty_tracker,
+ 			  struct gpu_dirty_extent *dirty_extent)
+ {
+ 	struct rb_node **link =3D &dirty_tracker->root.rb_node;
+ 	struct rb_node *parent =3D NULL;
+ 	u64 size =3D extent_size(dirty_extent);
+=20
+ 	while (*link) {
+ 		struct gpu_dirty_extent *tmp_extent;
+=20
+ 		parent =3D *link;
+ 		tmp_extent =3D rb_entry(parent, struct gpu_dirty_extent, rb);
+=20
+ 		if (tmp_extent->subtree_max_size < size)
+ 			tmp_extent->subtree_max_size =3D size;
+=20
+ 		if (dirty_extent->start < tmp_extent->start)
+ 			link =3D &parent->rb_left;
+ 		else
+ 			link =3D &parent->rb_right;
+ 	}
+=20
+ 	dirty_extent->subtree_max_size =3D size;
+ 	rb_link_node(&dirty_extent->rb, parent, link);
+ 	rb_insert_augmented(&dirty_extent->rb, &dirty_tracker->root, &gpu_dirty_=
augment_cb);
+ }
+=20
+ static void remove_extent(struct gpu_dirty_tracker *dirty_tracker,
+ 			  struct gpu_dirty_extent *dirty_extent)
+ {
+ 	rb_erase_augmented(&dirty_extent->rb, &dirty_tracker->root, &gpu_dirty_a=
ugment_cb);
+ 	RB_CLEAR_NODE(&dirty_extent->rb);
+ }
+=20
+ static void gpu_dirty_tracker_init(struct gpu_dirty_tracker *dirty_tracke=
r)
+ {
+ 	dirty_tracker->root =3D RB_ROOT;
+ 	dirty_tracker->total_dirty =3D 0;
+ }
+=20
+ static void gpu_dirty_tracker_empty(struct gpu_dirty_tracker *dirty_track=
er)
+ {
+ 	struct rb_node *rb;
+=20
+ 	while ((rb =3D rb_first(&dirty_tracker->root))) {
+ 		struct gpu_dirty_extent *dirty_extent =3D
+ 			rb_entry(rb, struct gpu_dirty_extent, rb);
+=20
+ 		remove_extent(dirty_tracker, dirty_extent);
+ 		extent_free(dirty_tracker, dirty_extent);
+ 	}
+=20
+ 	dirty_tracker->total_dirty =3D 0;
+ }
+=20
+ static void gpu_dirty_tracker_fini(struct gpu_dirty_tracker *dirty_tracke=
r)
+ {
+ 	gpu_dirty_tracker_empty(dirty_tracker);
+ }
+=20
+ /*
+  * Mark the range [start, start + size] as dirty. Merge with the neighbou=
r on
+  * each side if they are contiguous, so the tree never holds two adjacent=
 ranges.
+  */
+ static void gpu_dirty_tracker_mark_dirty(struct gpu_dirty_tracker *dirty_=
tracker,
+ 					 u64 start, u64 size)
+ {
+ 	struct gpu_dirty_extent *left, *right, *dirty_extent;
+ 	u64 end =3D start + size;
+=20
+ 	gpu_buddy_assert(size);
+=20
+ 	/* Find contiguous neighbours, if any. */
+ 	left =3D prev_extent(dirty_tracker, start);
+ 	if (left && left->end !=3D start)
+ 		left =3D NULL;
+=20
+ 	right =3D next_extent(dirty_tracker, end);
+ 	if (right && right->start !=3D end)
+ 		right =3D NULL;
+=20
+ 	if (left && right) {
+ 		/* Merge left + new + right into a single extent. */
+ 		remove_extent(dirty_tracker, left);
+ 		remove_extent(dirty_tracker, right);
+ 		left->end =3D right->end;
+ 		extent_free(dirty_tracker, right);
+ 		insert_extent(dirty_tracker, left);
+ 	} else if (left) {
+ 		/* Extend left neighbour rightwards. */
+ 		remove_extent(dirty_tracker, left);
+ 		left->end =3D end;
+ 		insert_extent(dirty_tracker, left);
+ 	} else if (right) {
+ 		/* Extend right neighbour leftwards. */
+ 		remove_extent(dirty_tracker, right);
+ 		right->start =3D start;
+ 		insert_extent(dirty_tracker, right);
+ 	} else {
+ 		/* Standalone extent. */
+ 		dirty_extent =3D extent_alloc(dirty_tracker);
+ 		if (!dirty_extent) {
+ 			pr_warn_once("dirty extent allocation failed, skipping tracker update\=
n");
+ 			return;
+ 		}
+ 		dirty_extent->start =3D start;
+ 		dirty_extent->end   =3D end;
+ 		insert_extent(dirty_tracker, dirty_extent);
+ 	}
+=20
+ 	dirty_tracker->total_dirty +=3D size;
+ }
+=20
+ /*
+  * Remove the range [start, start + size] from the dirty tracker. Punch t=
he
+  * range out of every overlapping dirty extent, splitting one extent in t=
wo if
+  * the removed range falls strictly inside it.
+  */
+ static void gpu_dirty_tracker_remove_range(struct gpu_dirty_tracker *dirt=
y_tracker,
+ 					   u64 start, u64 size)
+ {
+ 	struct gpu_dirty_extent *dirty_extent, *next;
+ 	u64 end =3D start + size;
+=20
+ 	gpu_buddy_assert(size);
+=20
+ 	dirty_extent =3D prev_extent(dirty_tracker, start + 1);
+ 	if (!dirty_extent)
+ 		dirty_extent =3D next_extent(dirty_tracker, start);
+=20
+ 	while (dirty_extent && dirty_extent->start < end) {
+ 		struct rb_node *next_node =3D rb_next(&dirty_extent->rb);
+ 		u64 extent_start =3D dirty_extent->start;
+ 		u64 extent_end =3D dirty_extent->end;
+=20
+ 		if (next_node)
+ 			next =3D rb_entry(next_node, struct gpu_dirty_extent, rb);
+ 		else
+ 			next =3D NULL;
+=20
+ 		/* Skip a non-overlapping neighbour returned by prev_extent(). */
+ 		if (extent_end <=3D start) {
+ 			dirty_extent =3D next;
+ 			continue;
+ 		}
+=20
+ 		if (extent_start < start && extent_end > end) {
+ 			/*
+ 			 * Removed range lies strictly inside this dirty extent:
+ 			 * split it into the dirty left and right halves.
+ 			 */
+ 			struct gpu_dirty_extent *right =3D extent_alloc(dirty_tracker);
+=20
+ 			if (!right) {
+ 				pr_warn_once("dirty extent allocation failed, skipping tracker update=
\n");
+ 				dirty_extent =3D next;
+ 				continue;
+ 			}
+=20
+ 			remove_extent(dirty_tracker, dirty_extent);
+=20
+ 			dirty_extent->end =3D start;
+ 			right->start =3D end;
+ 			right->end   =3D extent_end;
+=20
+ 			insert_extent(dirty_tracker, dirty_extent);
+ 			insert_extent(dirty_tracker, right);
+=20
+ 			dirty_tracker->total_dirty -=3D size;
+ 		} else if (extent_start >=3D start && extent_end <=3D end) {
+ 			/* Extent fully covered: drop it. */
+ 			remove_extent(dirty_tracker, dirty_extent);
+ 			extent_free(dirty_tracker, dirty_extent);
+=20
+ 			dirty_tracker->total_dirty -=3D (extent_end - extent_start);
+ 		} else if (extent_start < start) {
+ 			/* Extent overlaps from the left: trim its right end. */
+ 			remove_extent(dirty_tracker, dirty_extent);
+ 			dirty_extent->end =3D start;
+ 			insert_extent(dirty_tracker, dirty_extent);
+=20
+ 			dirty_tracker->total_dirty -=3D (extent_end - start);
+ 		} else {
+ 			/* Extent overlaps from the right: trim its left end. */
+ 			remove_extent(dirty_tracker, dirty_extent);
+ 			dirty_extent->start =3D end;
+ 			insert_extent(dirty_tracker, dirty_extent);
+=20
+ 			dirty_tracker->total_dirty -=3D (end - extent_start);
+ 		}
+=20
+ 		dirty_extent =3D next;
+ 	}
+ }
+=20
+ static enum gpu_block_state
+ gpu_dirty_range_state(struct gpu_dirty_tracker *dirty_tracker,
+ 		      u64 start, u64 size)
+ {
+ 	struct gpu_dirty_extent *dirty_extent;
+ 	u64 end =3D start + size;
+=20
+ 	dirty_extent =3D prev_extent(dirty_tracker, start + 1);
+ 	if (dirty_extent) {
+ 		if (dirty_extent->start <=3D start && dirty_extent->end >=3D end)
+ 			return GPU_BLOCK_DIRTY;
+ 		if (dirty_extent->start < end && dirty_extent->end > start)
+ 			return GPU_BLOCK_MIXED;
+ 	}
+=20
+ 	dirty_extent =3D next_extent(dirty_tracker, start);
+ 	if (dirty_extent && dirty_extent->start < end)
+ 		return GPU_BLOCK_MIXED;
+=20
+ 	return GPU_BLOCK_CLEAR;
+ }
+=20
+ static struct rb_node *
+ dirty_tracker_descend_right(struct rb_node *node, u64 min_size)
+ {
+ 	while (node->rb_right) {
+ 		struct gpu_dirty_extent *tmp_extent;
+=20
+ 		tmp_extent =3D rb_entry(node->rb_right, struct gpu_dirty_extent, rb);
+=20
+ 		if (tmp_extent->subtree_max_size < min_size)
+ 			break;
+ 		node =3D node->rb_right;
+ 	}
+=20
+ 	return node;
+ }
+=20
+ static struct gpu_dirty_extent *
+ gpu_dirty_tracker_find(struct gpu_dirty_tracker *dirty_tracker,
+ 		       u64 min_size, u64 *aligned_start_out)
+ {
+ 	struct rb_node *rb =3D dirty_tracker->root.rb_node;
+ 	struct gpu_dirty_extent *root_extent;
+ 	struct rb_node *parent;
+=20
+ 	if (!min_size || !is_power_of_2(min_size))
+ 		return NULL;
+=20
+ 	if (!rb)
+ 		return NULL;
+=20
+ 	root_extent =3D rb_entry(rb, struct gpu_dirty_extent, rb);
+ 	if (root_extent->subtree_max_size < min_size)
+ 		return NULL;
+=20
+ 	rb =3D dirty_tracker_descend_right(rb, min_size);
+=20
+ 	while (rb) {
+ 		struct gpu_dirty_extent *dirty_extent;
+ 		u64 aligned_start;
+=20
+ 		dirty_extent =3D rb_entry(rb, struct gpu_dirty_extent, rb);
+ 		aligned_start =3D ALIGN(dirty_extent->start, min_size);
+=20
+ 		/* Check if a min_size block fits after the alignment skip. */
+ 		if (aligned_start <=3D dirty_extent->end &&
+ 		    dirty_extent->end - aligned_start >=3D min_size) {
+ 			*aligned_start_out =3D aligned_start;
+ 			return dirty_extent;
+ 		}
+=20
+ 		if (rb->rb_left) {
+ 			struct gpu_dirty_extent *tmp_extent;
+=20
+ 			tmp_extent =3D rb_entry(rb->rb_left, struct gpu_dirty_extent, rb);
+ 			if (tmp_extent->subtree_max_size >=3D min_size) {
+ 				rb =3D dirty_tracker_descend_right(rb->rb_left, min_size);
+ 				continue;
+ 			}
+ 		}
+=20
+ 		/* Walk up until we exit a node via its right child. */
+ 		parent =3D rb_parent(rb);
+ 		while (parent && parent->rb_right !=3D rb) {
+ 			rb =3D parent;
+ 			parent =3D rb_parent(rb);
+ 		}
+ 		rb =3D parent;
+ 	}
+=20
+ 	return NULL;
+ }
 =20
  static unsigned int
  gpu_buddy_block_state(struct gpu_buddy_block *block)
@@@ -67,10 -494,97 +494,97 @@@ static unsigned int gpu_buddy_block_off
  	return __ffs64(offset);
  }
 =20
- RB_DECLARE_CALLBACKS_MAX(static, gpu_buddy_augment_cb,
- 			 struct gpu_buddy_block, rb,
- 			 unsigned int, subtree_max_alignment,
- 			 gpu_buddy_block_offset_alignment);
+ static inline enum gpu_block_state
+ gpu_block_cached_state(struct gpu_buddy_block *block)
+ {
+ 	if (gpu_buddy_block_is_clear(block))
+ 		return GPU_BLOCK_CLEAR;
+ 	if (block->has_clear)
+ 		return GPU_BLOCK_MIXED;
+ 	return GPU_BLOCK_DIRTY;
+ }
+=20
+ static inline void gpu_buddy_augment_compute(struct gpu_buddy_block *bloc=
k)
+ {
+ 	enum gpu_block_state block_state;
+ 	struct gpu_buddy_block *right;
+ 	struct gpu_buddy_block *left;
+ 	unsigned int max_align;
+=20
+ 	max_align =3D gpu_buddy_block_offset_alignment(block);
+ 	block_state =3D gpu_block_cached_state(block);
+=20
+ 	left =3D rb_entry_safe(block->rb.rb_left, struct gpu_buddy_block, rb);
+ 	if (left) {
+ 		if (left->subtree_max_alignment > max_align)
+ 			max_align =3D left->subtree_max_alignment;
+=20
+ 		block_state =3D max(block_state, left->subtree_block_state);
+ 	}
+=20
+ 	right =3D rb_entry_safe(block->rb.rb_right, struct gpu_buddy_block, rb);
+ 	if (right) {
+ 		if (right->subtree_max_alignment > max_align)
+ 			max_align =3D right->subtree_max_alignment;
+=20
+ 		block_state =3D max(block_state, right->subtree_block_state);
+ 	}
+=20
+ 	block->subtree_max_alignment =3D max_align;
+ 	block->subtree_block_state =3D block_state;
+ }
+=20
+ static void gpu_buddy_augment_propagate(struct rb_node *rb, struct rb_nod=
e *stop)
+ {
+ 	while (rb !=3D stop) {
+ 		struct gpu_buddy_block *block;
+ 		unsigned int old_align;
+ 		enum gpu_block_state old_block_state;
+=20
+ 		block =3D rb_entry(rb, struct gpu_buddy_block, rb);
+ 		old_align =3D block->subtree_max_alignment;
+ 		old_block_state =3D block->subtree_block_state;
+=20
+ 		gpu_buddy_augment_compute(block);
+ 		if (block->subtree_max_alignment =3D=3D old_align &&
+ 		    block->subtree_block_state =3D=3D old_block_state)
+ 			break;
+=20
+ 		rb =3D rb_parent(&block->rb);
+ 	}
+ }
+=20
+ static void gpu_buddy_augment_copy(struct rb_node *rb_old, struct rb_node=
 *rb_new)
+ {
+ 	struct gpu_buddy_block *old;
+ 	struct gpu_buddy_block *new;
+=20
+ 	old =3D rb_entry(rb_old, struct gpu_buddy_block, rb);
+ 	new =3D rb_entry(rb_new, struct gpu_buddy_block, rb);
+=20
+ 	new->subtree_max_alignment =3D old->subtree_max_alignment;
+ 	new->subtree_block_state =3D old->subtree_block_state;
+ }
+=20
+ static void gpu_buddy_augment_rotate(struct rb_node *rb_old, struct rb_no=
de *rb_new)
+ {
+ 	struct gpu_buddy_block *old;
+ 	struct gpu_buddy_block *new;
+=20
+ 	old =3D rb_entry(rb_old, struct gpu_buddy_block, rb);
+ 	new =3D rb_entry(rb_new, struct gpu_buddy_block, rb);
+=20
+ 	new->subtree_max_alignment =3D old->subtree_max_alignment;
+ 	new->subtree_block_state =3D old->subtree_block_state;
+=20
+ 	gpu_buddy_augment_compute(old);
+ }
+=20
+ static const struct rb_augment_callbacks gpu_buddy_augment_cb =3D {
+ 	.propagate =3D gpu_buddy_augment_propagate,
+ 	.copy      =3D gpu_buddy_augment_copy,
+ 	.rotate    =3D gpu_buddy_augment_rotate,
+ };
 =20
  static struct gpu_buddy_block *gpu_block_alloc(struct gpu_buddy *mm,
  					       struct gpu_buddy_block *parent,
@@@ -101,13 -615,6 +615,6 @@@ static void gpu_block_free(struct gpu_b
  	kmem_cache_free(slab_blocks, block);
  }
 =20
- static enum gpu_buddy_free_tree
- get_block_tree(struct gpu_buddy_block *block)
- {
- 	return gpu_buddy_block_is_clear(block) ?
- 	       GPU_BUDDY_CLEAR_TREE : GPU_BUDDY_DIRTY_TREE;
- }
-=20
  static struct gpu_buddy_block *
  rbtree_get_free_block(const struct rb_node *node)
  {
@@@ -120,24 -627,59 +627,59 @@@ rbtree_last_free_block(struct rb_root *
  	return rbtree_get_free_block(rb_last(root));
  }
 =20
- static bool rbtree_is_empty(struct rb_root *root)
+ static struct gpu_buddy_block *
+ rbtree_last_clear_free_block(struct rb_root *root,
+ 			     enum gpu_block_state min_block_state)
  {
- 	return RB_EMPTY_ROOT(root);
+ 	struct rb_node *node =3D root->rb_node;
+ 	struct gpu_buddy_block *block =3D NULL;
+ 	struct gpu_buddy_block *root_block;
+ 	enum gpu_block_state target_state;
+=20
+ 	root_block =3D rbtree_get_free_block(node);
+ 	if (!root_block || root_block->subtree_block_state < min_block_state)
+ 		return NULL;
+=20
+ 	target_state =3D root_block->subtree_block_state;
+=20
+ 	while (node) {
+ 		struct gpu_buddy_block *right_block;
+ 		struct gpu_buddy_block *node_block;
+=20
+ 		node_block =3D rbtree_get_free_block(node);
+ 		right_block =3D rbtree_get_free_block(node->rb_right);
+=20
+ 		if (right_block && right_block->subtree_block_state >=3D target_state) {
+ 			node =3D node->rb_right;
+ 			continue;
+ 		}
+=20
+ 		if (gpu_block_cached_state(node_block) =3D=3D target_state) {
+ 			block =3D node_block;
+ 			break;
+ 		}
+=20
+ 		node =3D node->rb_left;
+ 	}
+=20
+ 	return block;
  }
 =20
  static void rbtree_insert(struct gpu_buddy *mm,
- 			  struct gpu_buddy_block *block,
- 			  enum gpu_buddy_free_tree tree)
+ 			  struct gpu_buddy_block *block)
  {
  	struct rb_node **link, *parent =3D NULL;
- 	unsigned int block_alignment, order;
+ 	enum gpu_block_state block_state;
  	struct gpu_buddy_block *node;
+ 	unsigned int block_alignment;
  	struct rb_root *root;
+ 	unsigned int order;
 =20
  	order =3D gpu_buddy_block_order(block);
  	block_alignment =3D gpu_buddy_block_offset_alignment(block);
+ 	block_state =3D gpu_block_cached_state(block);
 =20
- 	root =3D &mm->free_trees[tree][order];
+ 	root =3D &mm->free_tree[order];
  	link =3D &root->rb_node;
 =20
  	while (*link) {
@@@ -147,10 -689,12 +689,12 @@@
  		 * Manual augmentation update during insertion traversal. Required
  		 * because rb_insert_augmented() only calls rotate callback during
  		 * rotations. This ensures all ancestors on the insertion path have
- 		 * correct subtree_max_alignment values.
+ 		 * correct subtree_max_alignment / subtree_block_state values.
  		 */
  		if (node->subtree_max_alignment < block_alignment)
  			node->subtree_max_alignment =3D block_alignment;
+ 		if (node->subtree_block_state < block_state)
+ 			node->subtree_block_state =3D block_state;
 =20
  		if (gpu_buddy_block_offset(block) < gpu_buddy_block_offset(node))
  			link =3D &parent->rb_left;
@@@ -159,6 -703,7 +703,7 @@@
  	}
 =20
  	block->subtree_max_alignment =3D block_alignment;
+ 	block->subtree_block_state =3D block_state;
  	rb_link_node(&block->rb, parent, link);
  	rb_insert_augmented(&block->rb, root, &gpu_buddy_augment_cb);
  }
@@@ -167,53 -712,55 +712,55 @@@ static void rbtree_remove(struct gpu_bu
  			  struct gpu_buddy_block *block)
  {
  	unsigned int order =3D gpu_buddy_block_order(block);
- 	enum gpu_buddy_free_tree tree;
- 	struct rb_root *root;
 =20
- 	tree =3D get_block_tree(block);
- 	root =3D &mm->free_trees[tree][order];
-=20
- 	rb_erase_augmented(&block->rb, root, &gpu_buddy_augment_cb);
+ 	rb_erase_augmented(&block->rb, &mm->free_tree[order], &gpu_buddy_augment=
_cb);
  	RB_CLEAR_NODE(&block->rb);
  }
 =20
- static void clear_reset(struct gpu_buddy_block *block)
- {
- 	block->header &=3D ~GPU_BUDDY_HEADER_CLEAR;
- }
-=20
- static void mark_cleared(struct gpu_buddy_block *block)
- {
- 	block->header |=3D GPU_BUDDY_HEADER_CLEAR;
- }
-=20
  static void mark_allocated(struct gpu_buddy *mm,
  			   struct gpu_buddy_block *block)
  {
  	block->header &=3D ~GPU_BUDDY_HEADER_STATE;
  	block->header |=3D GPU_BUDDY_ALLOCATED;
 =20
+ 	block->has_clear =3D false;
+=20
  	mm->free_scoreboard[gpu_buddy_block_order(block)]--;
  	mm->used_scoreboard[gpu_buddy_block_order(block)]++;
 =20
  	rbtree_remove(mm, block);
  }
 =20
- static void mark_free(struct gpu_buddy *mm,
- 		      struct gpu_buddy_block *block)
+ static void __mark_free(struct gpu_buddy *mm,
+ 			struct gpu_buddy_block *block,
+ 			enum gpu_block_state block_state)
  {
- 	enum gpu_buddy_free_tree tree;
-=20
  	if (gpu_buddy_block_is_allocated(block))
  		mm->used_scoreboard[gpu_buddy_block_order(block)]--;
 =20
  	block->header &=3D ~GPU_BUDDY_HEADER_STATE;
  	block->header |=3D GPU_BUDDY_FREE;
 =20
+ 	block->header &=3D ~GPU_BUDDY_HEADER_CLEAR;
+=20
+ 	block->has_clear =3D (block_state !=3D GPU_BLOCK_DIRTY);
+ 	if (block_state =3D=3D GPU_BLOCK_CLEAR)
+ 		block->header |=3D GPU_BUDDY_HEADER_CLEAR;
+=20
  	mm->free_scoreboard[gpu_buddy_block_order(block)]++;
 =20
- 	tree =3D get_block_tree(block);
- 	rbtree_insert(mm, block, tree);
+ 	rbtree_insert(mm, block);
+ }
+=20
+ static void mark_free(struct gpu_buddy *mm,
+ 		      struct gpu_buddy_block *block)
+ {
+ 	enum gpu_block_state block_state;
+=20
+ 	block_state =3D gpu_dirty_range_state(&mm->dirty,
+ 					    gpu_buddy_block_offset(block),
+ 					    gpu_buddy_block_size(mm, block));
+ 	__mark_free(mm, block, block_state);
  }
 =20
  static void mark_split(struct gpu_buddy *mm,
@@@ -253,37 -800,31 +800,31 @@@ __get_buddy(struct gpu_buddy_block *blo
  }
 =20
  static unsigned int __gpu_buddy_free(struct gpu_buddy *mm,
- 				     struct gpu_buddy_block *block,
- 				     bool force_merge)
+ 				     struct gpu_buddy_block *block)
  {
+ 	enum gpu_block_state block_state;
  	struct gpu_buddy_block *parent;
  	unsigned int order;
 =20
- 	while ((parent =3D block->parent)) {
- 		struct gpu_buddy_block *buddy;
+ 	block_state =3D gpu_block_cached_state(block);
 =20
- 		buddy =3D __get_buddy(block);
+ 	while ((parent =3D block->parent)) {
+ 		struct gpu_buddy_block *buddy =3D __get_buddy(block);
 =20
  		if (!gpu_buddy_block_is_free(buddy))
  			break;
 =20
- 		if (!force_merge) {
- 			/*
- 			 * Check the block and its buddy clear state and exit
- 			 * the loop if they both have the dissimilar state.
- 			 */
- 			if (gpu_buddy_block_is_clear(block) !=3D
- 			    gpu_buddy_block_is_clear(buddy))
- 				break;
+ 		if (block_state !=3D GPU_BLOCK_MIXED) {
+ 			enum gpu_block_state buddy_state;
 =20
- 			if (gpu_buddy_block_is_clear(block))
- 				mark_cleared(parent);
+ 			buddy_state =3D gpu_block_cached_state(buddy);
+=20
+ 			if (buddy_state !=3D block_state)
+ 				block_state =3D GPU_BLOCK_MIXED;
  		}
 =20
  		rbtree_remove(mm, buddy);
  		mm->free_scoreboard[gpu_buddy_block_order(buddy)]--;
- 		if (force_merge && gpu_buddy_block_is_clear(buddy))
- 			mm->clear_avail -=3D gpu_buddy_block_size(mm, buddy);
 =20
  		if (gpu_buddy_block_is_allocated(block))
  			mm->used_scoreboard[gpu_buddy_block_order(block)]--;
@@@ -295,74 -836,11 +836,11 @@@
  	}
 =20
  	order =3D gpu_buddy_block_order(block);
- 	mark_free(mm, block);
+ 	__mark_free(mm, block, block_state);
 =20
  	return order;
  }
 =20
- static int __force_merge(struct gpu_buddy *mm,
- 			 u64 start,
- 			 u64 end,
- 			 unsigned int min_order)
- {
- 	unsigned int tree, order;
- 	int i;
-=20
- 	if (!min_order)
- 		return -ENOMEM;
-=20
- 	if (min_order > mm->max_order)
- 		return -EINVAL;
-=20
- 	for_each_free_tree(tree) {
- 		for (i =3D min_order - 1; i >=3D 0; i--) {
- 			struct rb_node *iter =3D rb_last(&mm->free_trees[tree][i]);
-=20
- 			while (iter) {
- 				struct gpu_buddy_block *block, *buddy;
- 				u64 block_start, block_end;
-=20
- 				block =3D rbtree_get_free_block(iter);
- 				iter =3D rb_prev(iter);
-=20
- 				if (!block || !block->parent)
- 					continue;
-=20
- 				block_start =3D gpu_buddy_block_offset(block);
- 				block_end =3D block_start + gpu_buddy_block_size(mm, block) - 1;
-=20
- 				if (!contains(start, end, block_start, block_end))
- 					continue;
-=20
- 				buddy =3D __get_buddy(block);
- 				if (!gpu_buddy_block_is_free(buddy))
- 					continue;
-=20
- 				gpu_buddy_assert(gpu_buddy_block_is_clear(block) !=3D
- 						 gpu_buddy_block_is_clear(buddy));
-=20
- 				/*
- 				 * Advance to the next node when the current node is the buddy,
- 				 * as freeing the block will also remove its buddy from the tree.
- 				 */
- 				if (iter =3D=3D &buddy->rb)
- 					iter =3D rb_prev(iter);
-=20
- 				rbtree_remove(mm, block);
- 				mm->free_scoreboard[gpu_buddy_block_order(block)]--;
- 				if (gpu_buddy_block_is_clear(block))
- 					mm->clear_avail -=3D gpu_buddy_block_size(mm, block);
-=20
- 				order =3D __gpu_buddy_free(mm, block, true);
- 				if (order >=3D min_order)
- 					return 0;
- 			}
- 		}
- 	}
-=20
- 	return -ENOMEM;
- }
-=20
  /**
   * gpu_buddy_init - init memory manager
   *
@@@ -377,7 -855,7 +855,7 @@@
   */
  int gpu_buddy_init(struct gpu_buddy *mm, u64 size, u64 chunk_size)
  {
- 	unsigned int i, j, root_count =3D 0;
+ 	unsigned int root_count =3D 0;
  	u64 offset =3D 0;
 =20
  	if (size < chunk_size)
@@@ -393,7 -871,6 +871,6 @@@
 =20
  	mm->size =3D size;
  	mm->avail =3D size;
- 	mm->clear_avail =3D 0;
  	mm->chunk_size =3D chunk_size;
  	mm->max_order =3D ilog2(size) - ilog2(chunk_size);
 =20
@@@ -411,23 -888,19 +888,17 @@@
  	if (!mm->used_scoreboard)
  		goto out_free_free_scoreboard;
 =20
- 	mm->free_trees =3D kmalloc_objs(*mm->free_trees, GPU_BUDDY_MAX_FREE_TREE=
S);
- 	if (!mm->free_trees)
+ 	mm->free_tree =3D kcalloc(mm->max_order + 1,
+ 				sizeof(struct rb_root),
+ 				GFP_KERNEL);
+ 	if (!mm->free_tree)
  		goto out_free_used_scoreboard;
 =20
- 	for_each_free_tree(i) {
- 		mm->free_trees[i] =3D kmalloc_objs(struct rb_root,
- 						 mm->max_order + 1);
- 		if (!mm->free_trees[i])
- 			goto out_free_tree;
-=20
- 		for (j =3D 0; j <=3D mm->max_order; ++j)
- 			mm->free_trees[i][j] =3D RB_ROOT;
- 	}
+ 	gpu_dirty_tracker_init(&mm->dirty);
 =20
  	mm->n_roots =3D hweight64(size);
 =20
 -	mm->roots =3D kmalloc_array(mm->n_roots,
 -				  sizeof(struct gpu_buddy_block *),
 -				  GFP_KERNEL);
 +	mm->roots =3D kmalloc_objs(struct gpu_buddy_block *, mm->n_roots);
  	if (!mm->roots)
  		goto out_free_tree;
 =20
@@@ -447,7 -920,8 +918,8 @@@
  		if (!root)
  			goto out_free_roots;
 =20
- 		mark_free(mm, root);
+ 		gpu_dirty_tracker_mark_dirty(&mm->dirty, offset, root_size);
+ 		__mark_free(mm, root, GPU_BLOCK_DIRTY);
 =20
  		BUG_ON(root_count > mm->max_order);
  		BUG_ON(gpu_buddy_block_size(mm, root) < chunk_size);
@@@ -469,9 -943,8 +941,8 @@@ out_free_roots
  		gpu_block_free(mm, mm->roots[root_count]);
  	kfree(mm->roots);
  out_free_tree:
- 	while (i--)
- 		kfree(mm->free_trees[i]);
- 	kfree(mm->free_trees);
+ 	gpu_dirty_tracker_fini(&mm->dirty);
+ 	kfree(mm->free_tree);
  out_free_used_scoreboard:
  	kfree(mm->used_scoreboard);
  out_free_free_scoreboard:
@@@ -489,7 -962,7 +960,7 @@@ EXPORT_SYMBOL(gpu_buddy_init)
   */
  void gpu_buddy_fini(struct gpu_buddy *mm)
  {
- 	u64 root_size, size, start;
+ 	u64 root_size, size;
  	unsigned int order;
  	int i;
 =20
@@@ -497,14 -970,10 +968,10 @@@
 =20
  	for (i =3D 0; i < mm->n_roots; ++i) {
  		order =3D ilog2(size) - ilog2(mm->chunk_size);
- 		start =3D gpu_buddy_block_offset(mm->roots[i]);
- 		__force_merge(mm, start, start + size, order);
+ 		root_size =3D mm->chunk_size << order;
 =20
  		gpu_buddy_assert(gpu_buddy_block_is_free(mm->roots[i]));
-=20
  		gpu_block_free(mm, mm->roots[i]);
-=20
- 		root_size =3D mm->chunk_size << order;
  		size -=3D root_size;
  	}
 =20
@@@ -513,9 -982,8 +980,8 @@@
  	for (i =3D 0; i <=3D mm->max_order; ++i)
  		gpu_buddy_assert(!mm->used_scoreboard[i]);
 =20
- 	for_each_free_tree(i)
- 		kfree(mm->free_trees[i]);
- 	kfree(mm->free_trees);
+ 	gpu_dirty_tracker_fini(&mm->dirty);
+ 	kfree(mm->free_tree);
  	kfree(mm->roots);
  	kfree(mm->free_scoreboard);
  	kfree(mm->used_scoreboard);
@@@ -527,6 -995,7 +993,7 @@@ static int split_block(struct gpu_budd
  {
  	unsigned int block_order =3D gpu_buddy_block_order(block) - 1;
  	u64 offset =3D gpu_buddy_block_offset(block);
+ 	enum gpu_block_state parent_state;
 =20
  	BUG_ON(!gpu_buddy_block_is_free(block));
  	BUG_ON(!gpu_buddy_block_order(block));
@@@ -542,17 -1011,18 +1009,18 @@@
  		return -ENOMEM;
  	}
 =20
+ 	parent_state =3D gpu_block_cached_state(block);
+=20
  	mark_split(mm, block);
 =20
- 	if (gpu_buddy_block_is_clear(block)) {
- 		mark_cleared(block->left);
- 		mark_cleared(block->right);
- 		clear_reset(block);
+ 	if (parent_state =3D=3D GPU_BLOCK_MIXED) {
+ 		mark_free(mm, block->left);
+ 		mark_free(mm, block->right);
+ 	} else {
+ 		__mark_free(mm, block->left, parent_state);
+ 		__mark_free(mm, block->right, parent_state);
  	}
 =20
- 	mark_free(mm, block->left);
- 	mark_free(mm, block->right);
-=20
  	return 0;
  }
 =20
@@@ -567,45 -1037,47 +1035,47 @@@
   */
  void gpu_buddy_reset_clear(struct gpu_buddy *mm, bool is_clear)
  {
- 	enum gpu_buddy_free_tree src_tree, dst_tree;
- 	u64 root_size, size, start;
- 	unsigned int order;
- 	int i;
+ 	unsigned int i;
 =20
  	gpu_buddy_driver_lock_held(mm);
- 	size =3D mm->size;
- 	for (i =3D 0; i < mm->n_roots; ++i) {
- 		order =3D ilog2(size) - ilog2(mm->chunk_size);
- 		start =3D gpu_buddy_block_offset(mm->roots[i]);
- 		__force_merge(mm, start, start + size, order);
 =20
- 		root_size =3D mm->chunk_size << order;
- 		size -=3D root_size;
- 	}
-=20
- 	src_tree =3D is_clear ? GPU_BUDDY_DIRTY_TREE : GPU_BUDDY_CLEAR_TREE;
- 	dst_tree =3D is_clear ? GPU_BUDDY_CLEAR_TREE : GPU_BUDDY_DIRTY_TREE;
+ 	gpu_dirty_tracker_empty(&mm->dirty);
 =20
  	for (i =3D 0; i <=3D mm->max_order; ++i) {
- 		struct rb_root *root =3D &mm->free_trees[src_tree][i];
  		struct gpu_buddy_block *block, *tmp;
 =20
- 		rbtree_postorder_for_each_entry_safe(block, tmp, root, rb) {
- 			rbtree_remove(mm, block);
+ 		rbtree_postorder_for_each_entry_safe(block, tmp,
+ 						     &mm->free_tree[i], rb) {
  			if (is_clear) {
- 				mark_cleared(block);
- 				mm->clear_avail +=3D gpu_buddy_block_size(mm, block);
+ 				if (!gpu_buddy_block_is_clear(block))
+ 					block->header |=3D GPU_BUDDY_HEADER_CLEAR;
+ 				block->has_clear =3D true;
  			} else {
- 				clear_reset(block);
- 				mm->clear_avail -=3D gpu_buddy_block_size(mm, block);
+ 				block->header &=3D ~GPU_BUDDY_HEADER_CLEAR;
+ 				block->has_clear =3D false;
+ 				gpu_dirty_tracker_mark_dirty(&mm->dirty,
+ 							     gpu_buddy_block_offset(block),
+ 							     gpu_buddy_block_size(mm, block));
  			}
 =20
- 			rbtree_insert(mm, block, dst_tree);
+ 			gpu_buddy_augment_compute(block);
  		}
  	}
  }
  EXPORT_SYMBOL(gpu_buddy_reset_clear);
 =20
+ static void __gpu_buddy_free_block_internal(struct gpu_buddy *mm,
+ 					    struct gpu_buddy_block *block)
+ {
+ 	u64 size =3D gpu_buddy_block_size(mm, block);
+=20
+ 	gpu_buddy_driver_lock_held(mm);
+ 	BUG_ON(!gpu_buddy_block_is_allocated(block));
+=20
+ 	mm->avail +=3D size;
+ 	__gpu_buddy_free(mm, block);
+ }
+=20
  /**
   * gpu_buddy_free_block - free a block
   *
@@@ -615,13 -1087,12 +1085,12 @@@
  void gpu_buddy_free_block(struct gpu_buddy *mm,
  			  struct gpu_buddy_block *block)
  {
- 	gpu_buddy_driver_lock_held(mm);
- 	BUG_ON(!gpu_buddy_block_is_allocated(block));
- 	mm->avail +=3D gpu_buddy_block_size(mm, block);
- 	if (gpu_buddy_block_is_clear(block))
- 		mm->clear_avail +=3D gpu_buddy_block_size(mm, block);
+ 	if (!gpu_buddy_block_is_clear(block))
+ 		gpu_dirty_tracker_mark_dirty(&mm->dirty,
+ 					     gpu_buddy_block_offset(block),
+ 					     gpu_buddy_block_size(mm, block));
 =20
- 	__gpu_buddy_free(mm, block, false);
+ 	__gpu_buddy_free_block_internal(mm, block);
  }
  EXPORT_SYMBOL(gpu_buddy_free_block);
 =20
@@@ -684,17 -1155,47 +1153,47 @@@ static void __gpu_buddy_free_list(struc
  				  bool mark_dirty)
  {
  	struct gpu_buddy_block *block, *on;
+ 	u64 dirty_start =3D 0, dirty_size =3D 0;
 =20
  	gpu_buddy_assert(!(mark_dirty && mark_clear));
 =20
  	list_for_each_entry_safe(block, on, objects, link) {
+ 		u64 offset =3D gpu_buddy_block_offset(block);
+ 		u64 size =3D gpu_buddy_block_size(mm, block);
+=20
  		if (mark_clear)
- 			mark_cleared(block);
+ 			block->header |=3D GPU_BUDDY_HEADER_CLEAR;
  		else if (mark_dirty)
- 			clear_reset(block);
- 		gpu_buddy_free_block(mm, block);
+ 			block->header &=3D ~GPU_BUDDY_HEADER_CLEAR;
+=20
+ 		/*
+ 		 * Coalesce contiguous dirty blocks into one extent update so
+ 		 * a multi-block contiguous free costs a single mark_dirty().
+ 		 * Flush the pending extent and start over on a gap.
+ 		 */
+ 		if (!gpu_buddy_block_is_clear(block)) {
+ 			if (dirty_size &&
+ 			    (dirty_start + dirty_size =3D=3D offset ||
+ 			     offset + size =3D=3D dirty_start)) {
+ 				dirty_start =3D min(dirty_start, offset);
+ 				dirty_size +=3D size;
+ 			} else {
+ 				if (dirty_size)
+ 					gpu_dirty_tracker_mark_dirty(&mm->dirty,
+ 								     dirty_start,
+ 								     dirty_size);
+ 				dirty_start =3D offset;
+ 				dirty_size =3D size;
+ 			}
+ 		}
+=20
+ 		__gpu_buddy_free_block_internal(mm, block);
  		cond_resched();
  	}
+=20
+ 	if (dirty_size)
+ 		gpu_dirty_tracker_mark_dirty(&mm->dirty, dirty_start, dirty_size);
+=20
  	INIT_LIST_HEAD(objects);
  }
 =20
@@@ -727,13 -1228,6 +1226,6 @@@ void gpu_buddy_free_list(struct gpu_bud
  }
  EXPORT_SYMBOL(gpu_buddy_free_list);
 =20
- static bool block_incompatible(struct gpu_buddy_block *block, unsigned in=
t flags)
- {
- 	bool needs_clear =3D flags & GPU_BUDDY_CLEAR_ALLOCATION;
-=20
- 	return needs_clear !=3D gpu_buddy_block_is_clear(block);
- }
-=20
  static void __gpu_buddy_undo_splits(struct gpu_buddy *mm,
  				    struct gpu_buddy_block *block)
  {
@@@ -744,7 -1238,7 +1236,7 @@@
  	     gpu_buddy_block_is_free(buddy))) {
  		rbtree_remove(mm, block);
  		mm->free_scoreboard[gpu_buddy_block_order(block)]--;
- 		__gpu_buddy_free(mm, block, false);
+ 		__gpu_buddy_free(mm, block);
  	}
  }
 =20
@@@ -752,8 -1246,7 +1244,7 @@@ static struct gpu_buddy_block=20
  __alloc_range_bias(struct gpu_buddy *mm,
  		   u64 start, u64 end,
  		   unsigned int order,
- 		   unsigned long flags,
- 		   bool fallback)
+ 		   unsigned long flags)
  {
  	u64 req_size =3D mm->chunk_size << order;
  	struct gpu_buddy_block *block;
@@@ -763,7 -1256,15 +1254,15 @@@
 =20
  	end =3D end - 1;
 =20
- 	for (i =3D 0; i < mm->n_roots; ++i)
+ 	/*
+ 	 * This range-constrained search hands back the highest/right-most
+ 	 * address that satisfies the request: the roots are seeded high-to-low
+ 	 * and the right (higher-address) child is descended first, making
+ 	 * top-down the default placement here. A non-top-down clear request is
+ 	 * the only exception, where the descent is biased towards clear or
+ 	 * clear-containing subtrees to satisfy the clear preference.
+ 	 */
+ 	for (i =3D mm->n_roots - 1; i >=3D 0; --i)
  		list_add_tail(&mm->roots[i]->tmp_link, &dfs);
 =20
  	do {
@@@ -799,9 -1300,6 +1298,6 @@@
  				continue;
  		}
 =20
- 		if (!fallback && block_incompatible(block, flags))
- 			continue;
-=20
  		if (contains(start, end, block_start, block_end) &&
  		    order =3D=3D gpu_buddy_block_order(block)) {
  			/*
@@@ -819,8 -1317,38 +1315,38 @@@
  				goto err_undo;
  		}
 =20
- 		list_add(&block->right->tmp_link, &dfs);
- 		list_add(&block->left->tmp_link, &dfs);
+ 		/*
+ 		 * Top-down is a strict address-placement policy, so when it is
+ 		 * requested we ignore clear steering and simply descend the
+ 		 * right (higher-address) child first. Only a non-top-down clear
+ 		 * request biases the descent towards clear/has_clear subtrees.
+ 		 */
+ 		if ((flags & GPU_BUDDY_CLEAR_ALLOCATION) &&
+ 		    !(flags & GPU_BUDDY_TOPDOWN_ALLOCATION)) {
+ 			struct gpu_buddy_block *prefer;
+=20
+ 			if (gpu_buddy_block_is_clear(block->right))
+ 				prefer =3D block->right;
+ 			else if (gpu_buddy_block_is_clear(block->left))
+ 				prefer =3D block->left;
+ 			else if (block->right->has_clear)
+ 				prefer =3D block->right;
+ 			else if (block->left->has_clear)
+ 				prefer =3D block->left;
+ 			else
+ 				prefer =3D block->right;
+=20
+ 			if (prefer =3D=3D block->right) {
+ 				list_add(&block->left->tmp_link, &dfs);
+ 				list_add(&block->right->tmp_link, &dfs);
+ 			} else {
+ 				list_add(&block->right->tmp_link, &dfs);
+ 				list_add(&block->left->tmp_link, &dfs);
+ 			}
+ 		} else {
+ 			list_add(&block->left->tmp_link, &dfs);
+ 			list_add(&block->right->tmp_link, &dfs);
+ 		}
  	} while (1);
 =20
  	return ERR_PTR(-ENOSPC);
@@@ -835,48 -1363,32 +1361,32 @@@ err_undo
  	return ERR_PTR(err);
  }
 =20
- static struct gpu_buddy_block *
- __gpu_buddy_alloc_range_bias(struct gpu_buddy *mm,
- 			     u64 start, u64 end,
- 			     unsigned int order,
- 			     unsigned long flags)
- {
- 	struct gpu_buddy_block *block;
- 	bool fallback =3D false;
-=20
- 	block =3D __alloc_range_bias(mm, start, end, order,
- 				   flags, fallback);
- 	if (IS_ERR(block))
- 		return __alloc_range_bias(mm, start, end, order,
- 					  flags, !fallback);
-=20
- 	return block;
- }
-=20
+ /* Return the highest-address free block of at least @order. */
  static struct gpu_buddy_block *
  get_maxblock(struct gpu_buddy *mm,
- 	     unsigned int order,
- 	     enum gpu_buddy_free_tree tree)
+ 	     unsigned int order)
  {
- 	struct gpu_buddy_block *max_block =3D NULL, *block =3D NULL;
- 	struct rb_root *root;
+ 	struct gpu_buddy_block *max_block;
+ 	struct gpu_buddy_block *block;
  	unsigned int i;
 =20
+ 	/*
+ 	 * Top-down allocation is a strict address-placement policy: the block
+ 	 * is chosen purely by offset, regardless of its clear/dirty state.
+ 	 * Clear state is re-derived from the dirty tracker once the allocation
+ 	 * completes, and the driver is responsible for issuing the clear pass
+ 	 * if a clear region is required.
+ 	 */
+ 	max_block =3D NULL;
+=20
  	for (i =3D order; i <=3D mm->max_order; ++i) {
- 		root =3D &mm->free_trees[tree][i];
- 		block =3D rbtree_last_free_block(root);
+ 		block =3D rbtree_last_free_block(&mm->free_tree[i]);
  		if (!block)
  			continue;
 =20
- 		if (!max_block) {
+ 		if (!max_block ||
+ 		    gpu_buddy_block_offset(block) > gpu_buddy_block_offset(max_block))
  			max_block =3D block;
- 			continue;
- 		}
-=20
- 		if (gpu_buddy_block_offset(block) >
- 		    gpu_buddy_block_offset(max_block)) {
- 			max_block =3D block;
- 		}
  	}
 =20
  	return max_block;
@@@ -888,44 -1400,33 +1398,33 @@@ alloc_from_freetree(struct gpu_buddy *m
  		    unsigned long flags)
  {
  	struct gpu_buddy_block *block =3D NULL;
- 	struct rb_root *root;
- 	enum gpu_buddy_free_tree tree;
  	unsigned int tmp;
  	int err;
 =20
- 	tree =3D (flags & GPU_BUDDY_CLEAR_ALLOCATION) ?
- 		GPU_BUDDY_CLEAR_TREE : GPU_BUDDY_DIRTY_TREE;
-=20
  	if (flags & GPU_BUDDY_TOPDOWN_ALLOCATION) {
- 		block =3D get_maxblock(mm, order, tree);
+ 		block =3D get_maxblock(mm, order);
  		if (block)
- 			/* Store the obtained block order */
  			tmp =3D gpu_buddy_block_order(block);
  	} else {
- 		for (tmp =3D order; tmp <=3D mm->max_order; ++tmp) {
- 			/* Get RB tree root for this order and tree */
- 			root =3D &mm->free_trees[tree][tmp];
- 			block =3D rbtree_last_free_block(root);
- 			if (block)
- 				break;
+ 		if (flags & GPU_BUDDY_CLEAR_ALLOCATION) {
+ 			for (tmp =3D order; tmp <=3D mm->max_order; ++tmp) {
+ 				block =3D rbtree_last_clear_free_block(&mm->free_tree[tmp],
+ 								     GPU_BLOCK_MIXED);
+ 				if (block)
+ 					break;
+ 			}
+ 		}
+ 		if (!block) {
+ 			for (tmp =3D order; tmp <=3D mm->max_order; ++tmp) {
+ 				block =3D rbtree_last_free_block(&mm->free_tree[tmp]);
+ 				if (block)
+ 					break;
+ 			}
  		}
  	}
 =20
- 	if (!block) {
- 		/* Try allocating from the other tree */
- 		tree =3D (tree =3D=3D GPU_BUDDY_CLEAR_TREE) ?
- 			GPU_BUDDY_DIRTY_TREE : GPU_BUDDY_CLEAR_TREE;
-=20
- 		for (tmp =3D order; tmp <=3D mm->max_order; ++tmp) {
- 			root =3D &mm->free_trees[tree][tmp];
- 			block =3D rbtree_last_free_block(root);
- 			if (block)
- 				break;
- 		}
-=20
- 		if (!block)
- 			return ERR_PTR(-ENOSPC);
- 	}
+ 	if (!block)
+ 		return ERR_PTR(-ENOSPC);
 =20
  	BUG_ON(!gpu_buddy_block_is_free(block));
 =20
@@@ -934,7 -1435,26 +1433,26 @@@
  		if (unlikely(err))
  			goto err_undo;
 =20
- 		block =3D block->right;
+ 		if ((flags & GPU_BUDDY_CLEAR_ALLOCATION) &&
+ 		    !(flags & GPU_BUDDY_TOPDOWN_ALLOCATION)) {
+ 			bool right_clear, left_clear;
+=20
+ 			right_clear =3D gpu_buddy_block_is_clear(block->right);
+ 			left_clear =3D gpu_buddy_block_is_clear(block->left);
+=20
+ 			if (right_clear)
+ 				block =3D block->right;
+ 			else if (left_clear)
+ 				block =3D block->left;
+ 			else if (block->right->has_clear)
+ 				block =3D block->right;
+ 			else if (block->left->has_clear)
+ 				block =3D block->left;
+ 			else
+ 				block =3D block->right;
+ 		} else {
+ 			block =3D block->right;
+ 		}
  		tmp--;
  	}
  	return block;
@@@ -961,12 -1481,10 +1479,10 @@@ static bool gpu_buddy_subtree_can_satis
 =20
  static struct gpu_buddy_block *
  gpu_buddy_find_block_aligned(struct gpu_buddy *mm,
- 			     enum gpu_buddy_free_tree tree,
  			     unsigned int order,
- 			     unsigned int alignment,
- 			     unsigned long flags)
+ 			     unsigned int alignment)
  {
- 	struct rb_root *root =3D &mm->free_trees[tree][order];
+ 	struct rb_root *root =3D &mm->free_tree[order];
  	struct rb_node *rb =3D root->rb_node;
 =20
  	while (rb) {
@@@ -999,12 -1517,10 +1515,10 @@@
  static struct gpu_buddy_block *
  gpu_buddy_offset_aligned_allocation(struct gpu_buddy *mm,
  				    u64 size,
- 				    u64 min_block_size,
- 				    unsigned long flags)
+ 				    u64 min_block_size)
  {
  	struct gpu_buddy_block *block =3D NULL;
  	unsigned int order, tmp, alignment;
- 	enum gpu_buddy_free_tree tree;
  	unsigned long pages;
  	int err;
 =20
@@@ -1012,19 -1528,15 +1526,15 @@@
  	pages =3D size >> ilog2(mm->chunk_size);
  	order =3D fls(pages) - 1;
 =20
- 	tree =3D (flags & GPU_BUDDY_CLEAR_ALLOCATION) ?
- 		GPU_BUDDY_CLEAR_TREE : GPU_BUDDY_DIRTY_TREE;
-=20
+ 	/*
+ 	 * Offset-aligned allocation is a strict address-placement policy: the
+ 	 * block is chosen purely by its offset alignment, regardless of its
+ 	 * clear/dirty state. Clear state is re-derived from the dirty tracker
+ 	 * once the allocation completes, and the driver is responsible for
+ 	 * issuing the clear pass if a clear region is required.
+ 	 */
  	for (tmp =3D order; tmp <=3D mm->max_order; ++tmp) {
- 		block =3D gpu_buddy_find_block_aligned(mm, tree, tmp,
- 						     alignment, flags);
- 		if (!block) {
- 			tree =3D (tree =3D=3D GPU_BUDDY_CLEAR_TREE) ?
- 				GPU_BUDDY_DIRTY_TREE : GPU_BUDDY_CLEAR_TREE;
- 			block =3D gpu_buddy_find_block_aligned(mm, tree, tmp,
- 							     alignment, flags);
- 		}
-=20
+ 		block =3D gpu_buddy_find_block_aligned(mm, tmp, alignment);
  		if (block)
  			break;
  	}
@@@ -1063,6 -1575,7 +1573,7 @@@ err_undo
  static int __alloc_range(struct gpu_buddy *mm,
  			 struct list_head *dfs,
  			 u64 start, u64 size,
+ 			 unsigned long flags,
  			 struct list_head *blocks,
  			 u64 *total_allocated_on_err)
  {
@@@ -1099,16 -1612,23 +1610,23 @@@
 =20
  		if (contains(start, end, block_start, block_end)) {
  			if (gpu_buddy_block_is_free(block)) {
+ 				u64 block_offset;
+ 				u64 block_size;
+=20
+ 				block_size =3D gpu_buddy_block_size(mm, block);
+ 				block_offset =3D gpu_buddy_block_offset(block);
+=20
+ 				if (!gpu_buddy_block_is_clear(block))
+ 					gpu_dirty_tracker_remove_range(&mm->dirty,
+ 								       block_offset,
+ 								       block_size);
+=20
  				mark_allocated(mm, block);
- 				total_allocated +=3D gpu_buddy_block_size(mm, block);
- 				mm->avail -=3D gpu_buddy_block_size(mm, block);
- 				if (gpu_buddy_block_is_clear(block))
- 					mm->clear_avail -=3D gpu_buddy_block_size(mm, block);
+ 				total_allocated +=3D block_size;
+ 				mm->avail -=3D block_size;
+=20
  				list_add_tail(&block->link, &allocated);
  				continue;
- 			} else if (!mm->clear_avail) {
- 				err =3D -ENOSPC;
- 				goto err_free;
  			}
  		}
 =20
@@@ -1153,6 -1673,7 +1671,7 @@@ err_free
  static int __gpu_buddy_alloc_range(struct gpu_buddy *mm,
  				   u64 start,
  				   u64 size,
+ 				   unsigned long flags,
  				   u64 *total_allocated_on_err,
  				   struct list_head *blocks)
  {
@@@ -1162,7 -1683,7 +1681,7 @@@
  	for (i =3D 0; i < mm->n_roots; ++i)
  		list_add_tail(&mm->roots[i]->tmp_link, &dfs);
 =20
- 	return __alloc_range(mm, &dfs, start, size,
+ 	return __alloc_range(mm, &dfs, start, size, flags,
  			     blocks, total_allocated_on_err);
  }
 =20
@@@ -1170,85 -1691,89 +1689,89 @@@ static int __alloc_contig_aligned_retry
  					u64 unaligned_offset,
  					u64 size,
  					u64 min_block_size,
+ 					unsigned long flags,
  					struct list_head *blocks)
  {
  	u64 aligned_offset =3D round_down(unaligned_offset, min_block_size);
 =20
- 	return __gpu_buddy_alloc_range(mm, aligned_offset, size, NULL, blocks);
+ 	return __gpu_buddy_alloc_range(mm, aligned_offset, size, flags,
+ 				       NULL, blocks);
  }
 =20
  static int __alloc_contig_try_harder(struct gpu_buddy *mm,
  				     u64 size,
  				     u64 min_block_size,
+ 				     unsigned long flags,
  				     struct list_head *blocks)
  {
  	u64 rhs_offset, lhs_offset, filled;
  	struct gpu_buddy_block *block;
- 	unsigned int tree, order;
+ 	struct rb_root *root;
+ 	struct rb_node *iter;
+ 	unsigned long pages;
+ 	unsigned int order;
  	u64 modify_size;
  	int err;
 =20
  	modify_size =3D rounddown_pow_of_two(size);
- 	order =3D ilog2(modify_size) - ilog2(mm->chunk_size);
+ 	pages =3D modify_size >> ilog2(mm->chunk_size);
+ 	order =3D fls(pages) - 1;
  	if (order =3D=3D 0)
  		return -ENOSPC;
 =20
- 	for_each_free_tree(tree) {
- 		struct rb_root *root;
- 		struct rb_node *iter;
+ 	root =3D &mm->free_tree[order];
+ 	if (RB_EMPTY_ROOT(root))
+ 		return -ENOSPC;
 =20
- 		root =3D &mm->free_trees[tree][order];
- 		if (rbtree_is_empty(root))
- 			continue;
+ 	iter =3D rb_last(root);
+ 	while (iter) {
+ 		block =3D rbtree_get_free_block(iter);
 =20
- 		iter =3D rb_last(root);
- 		while (iter) {
- 			block =3D rbtree_get_free_block(iter);
+ 		rhs_offset =3D gpu_buddy_block_offset(block);
 =20
- 			rhs_offset =3D gpu_buddy_block_offset(block);
-=20
- 			/* Allocate blocks traversing RHS */
- 			err =3D  __gpu_buddy_alloc_range(mm, rhs_offset, size,
- 						       &filled, blocks);
- 			if (err && err !=3D -ENOSPC)
- 				return err;
- 			if (!err && IS_ALIGNED(rhs_offset, min_block_size))
- 				return 0;
- 			if (!err) {
- 				/* Allocate the unaligned RHS offset using round_down */
- 				gpu_buddy_free_list_internal(mm, blocks);
- 				err =3D __alloc_contig_aligned_retry(mm, rhs_offset,
- 								   size,
- 								   min_block_size,
- 								   blocks);
- 				if (!err)
- 					return 0;
- 				if (err !=3D -ENOSPC) {
- 					gpu_buddy_free_list_internal(mm, blocks);
- 					return err;
- 				}
- 				goto next;
- 			}
-=20
- 			if (size - filled > rhs_offset)
- 				goto next;
-=20
- 			lhs_offset =3D rhs_offset - (size - filled);
-=20
- 			/* Allocate the unaligned LHS offset using round_down */
+ 		/* Allocate blocks traversing RHS */
+ 		err =3D  __gpu_buddy_alloc_range(mm, rhs_offset, size,
+ 					       flags, &filled, blocks);
+ 		if (err && err !=3D -ENOSPC)
+ 			return err;
+ 		if (!err && IS_ALIGNED(rhs_offset, min_block_size))
+ 			return 0;
+ 		if (!err) {
+ 			/* Allocate the unaligned RHS offset using round_down */
  			gpu_buddy_free_list_internal(mm, blocks);
- 			err =3D __alloc_contig_aligned_retry(mm, lhs_offset, size,
- 							   min_block_size, blocks);
+ 			err =3D __alloc_contig_aligned_retry(mm, rhs_offset,
+ 							   size,
+ 							   min_block_size,
+ 							   flags, blocks);
  			if (!err)
  				return 0;
  			if (err !=3D -ENOSPC) {
  				gpu_buddy_free_list_internal(mm, blocks);
  				return err;
  			}
- next:
- 			gpu_buddy_free_list_internal(mm, blocks);
- 			iter =3D rb_prev(iter);
+ 			goto next;
  		}
+=20
+ 		if (size - filled > rhs_offset)
+ 			goto next;
+=20
+ 		lhs_offset =3D rhs_offset - (size - filled);
+=20
+ 		/* Allocate the unaligned LHS offset using round_down */
+ 		gpu_buddy_free_list_internal(mm, blocks);
+ 		err =3D __alloc_contig_aligned_retry(mm, lhs_offset,
+ 						   size,
+ 						   min_block_size,
+ 						   flags, blocks);
+ 		if (!err)
+ 			return 0;
+ 		if (err !=3D -ENOSPC) {
+ 			gpu_buddy_free_list_internal(mm, blocks);
+ 			return err;
+ 		}
+ next:
+ 		gpu_buddy_free_list_internal(mm, blocks);
+ 		iter =3D rb_prev(iter);
  	}
 =20
  	return -ENOSPC;
@@@ -1282,6 -1807,7 +1805,7 @@@ int gpu_buddy_block_trim(struct gpu_bud
  	struct gpu_buddy_block *block;
  	u64 block_start, block_end;
  	LIST_HEAD(dfs);
+ 	bool was_clear;
  	u64 new_start;
  	int err;
 =20
@@@ -1324,22 -1850,35 +1848,35 @@@
  	}
 =20
  	list_del(&block->link);
- 	mark_free(mm, block);
+=20
+ 	was_clear =3D gpu_buddy_block_is_clear(block);
+=20
+ 	if (!was_clear)
+ 		gpu_dirty_tracker_mark_dirty(&mm->dirty,
+ 					     gpu_buddy_block_offset(block),
+ 					     gpu_buddy_block_size(mm, block));
+=20
+ 	__mark_free(mm, block, was_clear ? GPU_BLOCK_CLEAR : GPU_BLOCK_DIRTY);
  	mm->avail +=3D gpu_buddy_block_size(mm, block);
- 	if (gpu_buddy_block_is_clear(block))
- 		mm->clear_avail +=3D gpu_buddy_block_size(mm, block);
 =20
  	/* Prevent recursively freeing this node */
  	parent =3D block->parent;
  	block->parent =3D NULL;
 =20
  	list_add(&block->tmp_link, &dfs);
- 	err =3D  __alloc_range(mm, &dfs, new_start, new_size, blocks, NULL);
+ 	err =3D  __alloc_range(mm, &dfs, new_start, new_size,
+ 			     was_clear ? GPU_BUDDY_CLEAR_ALLOCATION : 0,
+ 			     blocks, NULL);
  	if (err) {
  		mark_allocated(mm, block);
  		mm->avail -=3D gpu_buddy_block_size(mm, block);
- 		if (gpu_buddy_block_is_clear(block))
- 			mm->clear_avail -=3D gpu_buddy_block_size(mm, block);
+ 		if (!was_clear) {
+ 			gpu_dirty_tracker_remove_range(&mm->dirty,
+ 						       gpu_buddy_block_offset(block),
+ 						       gpu_buddy_block_size(mm, block));
+ 		}
+ 		if (was_clear)
+ 			block->header |=3D GPU_BUDDY_HEADER_CLEAR;
  		list_add(&block->link, blocks);
  	}
 =20
@@@ -1348,6 -1887,22 +1885,22 @@@
  }
  EXPORT_SYMBOL(gpu_buddy_block_trim);
 =20
+ static bool dirty_steer_window(struct gpu_buddy *mm, u64 req_size,
+ 			       u64 *start, u64 *end, unsigned long *flags)
+ {
+ 	u64 aligned_start;
+ 	struct gpu_dirty_extent *ext =3D
+ 		gpu_dirty_tracker_find(&mm->dirty, req_size, &aligned_start);
+=20
+ 	if (!ext)
+ 		return false;
+=20
+ 	*start  =3D aligned_start;
+ 	*end    =3D ext->end;
+ 	*flags |=3D GPU_BUDDY_RANGE_ALLOCATION;
+ 	return true;
+ }
+=20
  static struct gpu_buddy_block *
  __gpu_buddy_alloc_blocks(struct gpu_buddy *mm,
  			 u64 start, u64 end,
@@@ -1355,18 -1910,36 +1908,36 @@@
  			 unsigned int order,
  			 unsigned long flags)
  {
- 	if (flags & GPU_BUDDY_RANGE_ALLOCATION)
+ 	struct gpu_buddy_block *block;
+ 	bool steered =3D false;
+=20
+ 	/* Allocate from dirty tracker */
+ 	if (!(flags & GPU_BUDDY_RANGE_ALLOCATION) &&
+ 	    !(flags & GPU_BUDDY_CLEAR_ALLOCATION) &&
+ 	    size >=3D min_block_size &&
+ 	    gpu_buddy_clear_avail(mm) && mm->dirty.total_dirty) {
+ 		u64 block_size =3D mm->chunk_size << order;
+=20
+ 		steered =3D dirty_steer_window(mm, block_size,
+ 					     &start, &end, &flags);
+ 	}
+=20
+ 	if (flags & GPU_BUDDY_RANGE_ALLOCATION) {
  		/* Allocate traversing within the range */
- 		return  __gpu_buddy_alloc_range_bias(mm, start, end,
- 						     order, flags);
- 	else if (size < min_block_size)
+ 		block =3D __alloc_range_bias(mm, start, end, order, flags);
+ 		if (!IS_ERR(block) || !steered)
+ 			return block;
+=20
+ 		flags &=3D ~GPU_BUDDY_RANGE_ALLOCATION;
+ 	}
+=20
+ 	if (size < min_block_size)
  		/* Allocate from an offset-aligned region without size rounding */
  		return gpu_buddy_offset_aligned_allocation(mm, size,
- 							   min_block_size,
- 							   flags);
- 	else
- 		/* Allocate from freetree */
- 		return alloc_from_freetree(mm, order, flags);
+ 							   min_block_size);
+=20
+ 	/* Allocate from freetree */
+ 	return alloc_from_freetree(mm, order, flags);
  }
 =20
  /**
@@@ -1427,7 -2000,7 +1998,7 @@@ int gpu_buddy_alloc_blocks(struct gpu_b
  		if (!IS_ALIGNED(start | end, min_block_size))
  			return -EINVAL;
 =20
- 		return __gpu_buddy_alloc_range(mm, start, size, NULL, blocks);
+ 		return __gpu_buddy_alloc_range(mm, start, size, flags, NULL, blocks);
  	}
 =20
  	original_size =3D size;
@@@ -1453,7 -2026,8 +2024,8 @@@
  		if ((flags & GPU_BUDDY_CONTIGUOUS_ALLOCATION) &&
  		    !(flags & GPU_BUDDY_RANGE_ALLOCATION))
  			return __alloc_contig_try_harder(mm, original_size,
- 							 original_min_size, blocks);
+ 							 original_min_size,
+ 							 flags, blocks);
 =20
  		return -EINVAL;
  	}
@@@ -1468,8 -2042,6 +2040,6 @@@
  		BUG_ON(size >=3D min_block_size && order < min_order);
 =20
  		do {
- 			unsigned int fallback_order;
-=20
  			block =3D __gpu_buddy_alloc_blocks(mm, start,
  							 end,
  							 size,
@@@ -1479,48 -2051,40 +2049,40 @@@
  			if (!IS_ERR(block))
  				break;
 =20
- 			if (size < min_block_size) {
- 				fallback_order =3D order;
- 			} else if (order =3D=3D min_order) {
- 				fallback_order =3D min_order;
- 			} else {
+ 			if (size >=3D min_block_size && order > min_order) {
  				order--;
  				continue;
  			}
 =20
- 			/* Try allocation through force merge method */
- 			if (mm->clear_avail &&
- 			    !__force_merge(mm, start, end, fallback_order)) {
- 				block =3D __gpu_buddy_alloc_blocks(mm, start,
- 								 end,
- 								 size,
- 								 min_block_size,
- 								 fallback_order,
- 								 flags);
- 				if (!IS_ERR(block)) {
- 					order =3D fallback_order;
- 					break;
- 				}
- 			}
-=20
  			/*
  			 * Try contiguous block allocation through
  			 * try harder method.
  			 */
  			if (flags & GPU_BUDDY_CONTIGUOUS_ALLOCATION &&
- 			    !(flags & GPU_BUDDY_RANGE_ALLOCATION))
- 				return __alloc_contig_try_harder(mm,
- 								 original_size,
- 								 original_min_size,
- 								 blocks);
+ 			    !(flags & GPU_BUDDY_RANGE_ALLOCATION)) {
+ 				err =3D __alloc_contig_try_harder(mm,
+ 								original_size,
+ 								original_min_size,
+ 								flags,
+ 								blocks);
+ 				if (!err)
+ 					return 0;
+ 				if (err !=3D -ENOSPC)
+ 					return err;
+ 				goto err_free;
+ 			}
  			err =3D -ENOSPC;
  			goto err_free;
  		} while (1);
 =20
+ 		if (!gpu_buddy_block_is_clear(block))
+ 			gpu_dirty_tracker_remove_range(&mm->dirty,
+ 						       gpu_buddy_block_offset(block),
+ 						       gpu_buddy_block_size(mm, block));
+=20
  		mark_allocated(mm, block);
  		mm->avail -=3D gpu_buddy_block_size(mm, block);
- 		if (gpu_buddy_block_is_clear(block))
- 			mm->clear_avail -=3D gpu_buddy_block_size(mm, block);
+=20
  		kmemleak_update_trace(block);
  		list_add_tail(&block->link, &allocated);
 =20
@@@ -1594,7 -2158,8 +2156,8 @@@ void gpu_buddy_print(struct gpu_buddy *
 =20
  	gpu_buddy_driver_lock_held(mm);
  	pr_info("chunk_size: %lluKiB, total: %lluMiB, free: %lluMiB, clear_free:=
 %lluMiB\n",
- 		mm->chunk_size >> 10, mm->size >> 20, mm->avail >> 20, mm->clear_avail =
>> 20);
+ 		mm->chunk_size >> 10, mm->size >> 20, mm->avail >> 20,
+ 		gpu_buddy_clear_avail(mm) >> 20);
 =20
  	for (order =3D mm->max_order; order >=3D 0; order--) {
  		u64 free_count =3D mm->free_scoreboard[order];
@@@ -1615,6 -2180,7 +2178,7 @@@ EXPORT_SYMBOL(gpu_buddy_print)
 =20
  static void gpu_buddy_module_exit(void)
  {
+ 	kmem_cache_destroy(slab_extents);
  	kmem_cache_destroy(slab_blocks);
  }
 =20
@@@ -1624,7 -2190,15 +2188,15 @@@ static int __init gpu_buddy_module_init
  	if (!slab_blocks)
  		return -ENOMEM;
 =20
+ 	slab_extents =3D KMEM_CACHE(gpu_dirty_extent, 0);
+ 	if (!slab_extents)
+ 		goto err_destroy_blocks;
+=20
  	return 0;
+=20
+ err_destroy_blocks:
+ 	kmem_cache_destroy(slab_blocks);
+ 	return -ENOMEM;
  }
 =20
  module_init(gpu_buddy_module_init);

--nD1t3RANhXFek32W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqesSwACgkQJNaLcl1U
h9Cg2gf/f7Cr/kHlvLDovvBaW9JlcbmYyevNaFpHzEcZnx4X9DZpwctwAnB9p12B
rfTE0knGc114Y0Vo3ZBiKeQIHc9K6R5d9DSL4mVnY0V2ladnLm6NajvtHgCts5P8
ulZMDvN3qFDvmYOwCdGTO3B8fNDzstnhcv8f+gAjbukPY8sig61h/A42FWhhYlIr
/qPQjbhICCk4YFd9g/TBgecRdBZB9Fu+Qxw4a/iHXGyIEcH/4nVeHOdsAgqTISit
YYYVrQWkC9ALZB/frMC7M/yRq5TUiC2vB7x5+3cuQNJ9TWQMKRNoRaeoGk6y/z+3
CNobrbXCWgSrVlS8fe9luuQ61hpaGg==
=ua/l
-----END PGP SIGNATURE-----

--nD1t3RANhXFek32W--
