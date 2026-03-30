Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1F221061B0F
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 15:49:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FBF010E6A0;
	Mon, 30 Mar 2026 15:49:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="F3N5TwLz";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5424510E6A0
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 15:49:13 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id F2AD3439A4;
 Mon, 30 Mar 2026 15:49:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0234BC4CEF7;
 Mon, 30 Mar 2026 15:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774885752;
 bh=i3Xe30wQ4epBv8u2EflnbpvuGTHsgZ8BrHWThxGdUbw=;
 h=Date:From:To:Cc:Subject:From;
 b=F3N5TwLzO96bc97IXXKaEfQ9XGBE2DhcLWdMifLI+VSucCIlVsvqxmHJYiHCGPo0r
 YC4YXv/6KBn3LOILlUCOfaiGoPVUR3GIdIdYXjc8z7jxN+BRVOauRTNe32VZTRJY1H
 JbiDadHnyDDZKtAULz7EWMLWyXe86+U9O+zINhG1SaVuEsNM58+HxDmTrzmHA6b5cF
 iD0qv49/H/WHx1U/RPG0M8Z7wRl3JB5PNWLVI0szgr7+jQeAv63qIjdaWRVzW1bUWZ
 LmxzjZ/qW1nAxVyPp8uP572MCSAkcVQdJYJyXhP48wT7BCrt7GvvShNLpluE8d/amW
 mvCJ2MZMW75LQ==
Date: Mon, 30 Mar 2026 16:49:08 +0100
From: Mark Brown <broonie@kernel.org>
To: Dave Airlie <airlied@redhat.com>, DRI <dri-devel@lists.freedesktop.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Maarten Lankhorst <dev@lankhorst.se>,
 Matthew Brost <matthew.brost@intel.com>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
 Dnyaneshwar Bhadane <dnyaneshwar.bhadane@intel.com>
Subject: linux-next: manual merge of the drm tree with the origin tree
Message-ID: <acqbdHacTkJe5LEe@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4Gl4ABwND1g0/7H5"
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


--4Gl4ABwND1g0/7H5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm tree got a conflict in:

  drivers/gpu/drm/xe/xe_ggtt.c

between commit:

  01f2557aa684e ("drm/xe: Open-code GGTT MMIO access protection")

=66rom the origin tree and commit:

  e904c56ba6e0d ("drm/xe: Rewrite GGTT VF initialization")
  225d02cb46d0e ("drm/xe: Issue GGTT invalidation under lock in ggtt_node_r=
emove")

=66rom the drm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --combined drivers/gpu/drm/xe/xe_ggtt.c
index d1561ebe4e56c,a848d1a41b9b9..0000000000000
--- a/drivers/gpu/drm/xe/xe_ggtt.c
+++ b/drivers/gpu/drm/xe/xe_ggtt.c
@@@ -66,12 -66,14 +66,14 @@@
   * give us the correct placement for free.
   */
 =20
+ #define XE_GGTT_FLAGS_64K	BIT(0)
+ #define XE_GGTT_FLAGS_ONLINE	BIT(1)
+=20
  /**
   * struct xe_ggtt_node - A node in GGTT.
   *
-  * This struct needs to be initialized (only-once) with xe_ggtt_node_init=
() before any node
-  * insertion, reservation, or 'ballooning'.
-  * It will, then, be finalized by either xe_ggtt_node_remove() or xe_ggtt=
_node_deballoon().
+  * This struct is allocated with xe_ggtt_insert_node(,_transform) or xe_g=
gtt_insert_bo(,_at).
+  * It will be deallocated using xe_ggtt_node_remove().
   */
  struct xe_ggtt_node {
  	/** @ggtt: Back pointer to xe_ggtt where this region will be inserted at=
 */
@@@ -84,6 -86,63 +86,63 @@@
  	bool invalidate_on_remove;
  };
 =20
+ /**
+  * struct xe_ggtt_pt_ops - GGTT Page table operations
+  * Which can vary from platform to platform.
+  */
+ struct xe_ggtt_pt_ops {
+ 	/** @pte_encode_flags: Encode PTE flags for a given BO */
+ 	u64 (*pte_encode_flags)(struct xe_bo *bo, u16 pat_index);
+=20
+ 	/** @ggtt_set_pte: Directly write into GGTT's PTE */
+ 	xe_ggtt_set_pte_fn ggtt_set_pte;
+=20
+ 	/** @ggtt_get_pte: Directly read from GGTT's PTE */
+ 	u64 (*ggtt_get_pte)(struct xe_ggtt *ggtt, u64 addr);
+ };
+=20
+ /**
+  * struct xe_ggtt - Main GGTT struct
+  *
+  * In general, each tile can contains its own Global Graphics Translation=
 Table
+  * (GGTT) instance.
+  */
+ struct xe_ggtt {
+ 	/** @tile: Back pointer to tile where this GGTT belongs */
+ 	struct xe_tile *tile;
+         /** @start: Start offset of GGTT */
+ 	u64 start;
+ 	/** @size: Total usable size of this GGTT */
+ 	u64 size;
+=20
+ #define XE_GGTT_FLAGS_64K BIT(0)
+ 	/**
+ 	 * @flags: Flags for this GGTT
+ 	 * Acceptable flags:
+ 	 * - %XE_GGTT_FLAGS_64K - if PTE size is 64K. Otherwise, regular is 4K.
+ 	 * - %XE_GGTT_FLAGS_ONLINE - is GGTT online, protected by ggtt->lock
+ 	 *   after init
+ 	 */
+ 	unsigned int flags;
+ 	/** @scratch: Internal object allocation used as a scratch page */
+ 	struct xe_bo *scratch;
+ 	/** @lock: Mutex lock to protect GGTT data */
+ 	struct mutex lock;
+ 	/**
+ 	 *  @gsm: The iomem pointer to the actual location of the translation
+ 	 * table located in the GSM for easy PTE manipulation
+ 	 */
+ 	u64 __iomem *gsm;
+ 	/** @pt_ops: Page Table operations per platform */
+ 	const struct xe_ggtt_pt_ops *pt_ops;
+ 	/** @mm: The memory manager used to manage individual GGTT allocations */
+ 	struct drm_mm mm;
+ 	/** @access_count: counts GGTT writes */
+ 	unsigned int access_count;
+ 	/** @wq: Dedicated unordered work queue to process node removals */
+ 	struct workqueue_struct *wq;
+ };
+=20
  static u64 xelp_ggtt_pte_flags(struct xe_bo *bo, u16 pat_index)
  {
  	u64 pte =3D XE_PAGE_PRESENT;
@@@ -193,7 -252,7 +252,7 @@@ static void xe_ggtt_set_pte_and_flush(s
  static u64 xe_ggtt_get_pte(struct xe_ggtt *ggtt, u64 addr)
  {
  	xe_tile_assert(ggtt->tile, !(addr & XE_PTE_MASK));
- 	xe_tile_assert(ggtt->tile, addr < ggtt->size);
+ 	xe_tile_assert(ggtt->tile, addr < ggtt->start + ggtt->size);
 =20
  	return readq(&ggtt->gsm[addr >> XE_PTE_SHIFT]);
  }
@@@ -299,7 -358,7 +358,7 @@@ static void __xe_ggtt_init_early(struc
  {
  	ggtt->start =3D start;
  	ggtt->size =3D size;
- 	drm_mm_init(&ggtt->mm, start, size);
+ 	drm_mm_init(&ggtt->mm, 0, size);
  }
 =20
  int xe_ggtt_init_kunit(struct xe_ggtt *ggtt, u32 start, u32 size)
@@@ -349,9 -408,15 +408,15 @@@ int xe_ggtt_init_early(struct xe_ggtt *
  		ggtt_start =3D wopcm;
  		ggtt_size =3D (gsm_size / 8) * (u64)XE_PAGE_SIZE - ggtt_start;
  	} else {
- 		/* GGTT is expected to be 4GiB */
- 		ggtt_start =3D wopcm;
- 		ggtt_size =3D SZ_4G - ggtt_start;
+ 		ggtt_start =3D xe_tile_sriov_vf_ggtt_base(ggtt->tile);
+ 		ggtt_size =3D xe_tile_sriov_vf_ggtt(ggtt->tile);
+=20
+ 		if (ggtt_start < wopcm ||
+ 		    ggtt_start + ggtt_size > GUC_GGTT_TOP) {
+ 			xe_tile_err(ggtt->tile, "Invalid GGTT configuration: %#llx-%#llx\n",
+ 				    ggtt_start, ggtt_start + ggtt_size - 1);
+ 			return -ERANGE;
+ 		}
  	}
 =20
  	ggtt->gsm =3D ggtt->tile->mmio.regs + SZ_8M;
@@@ -369,7 -434,7 +434,7 @@@
  	else
  		ggtt->pt_ops =3D &xelp_pt_ops;
 =20
- 	ggtt->wq =3D alloc_workqueue("xe-ggtt-wq", WQ_MEM_RECLAIM, 0);
+ 	ggtt->wq =3D alloc_workqueue("xe-ggtt-wq", WQ_MEM_RECLAIM | WQ_PERCPU, 0=
);
  	if (!ggtt->wq)
  		return -ENOMEM;
 =20
@@@ -380,17 -445,7 +445,7 @@@
  		return err;
 =20
  	ggtt->flags |=3D XE_GGTT_FLAGS_ONLINE;
- 	err =3D devm_add_action_or_reset(xe->drm.dev, dev_fini_ggtt, ggtt);
- 	if (err)
- 		return err;
-=20
- 	if (IS_SRIOV_VF(xe)) {
- 		err =3D xe_tile_sriov_vf_prepare_ggtt(ggtt->tile);
- 		if (err)
- 			return err;
- 	}
-=20
- 	return 0;
+ 	return devm_add_action_or_reset(xe->drm.dev, dev_fini_ggtt, ggtt);
  }
  ALLOW_ERROR_INJECTION(xe_ggtt_init_early, ERRNO); /* See xe_pci_probe() */
 =20
@@@ -404,12 -459,17 +459,17 @@@ static void xe_ggtt_initial_clear(struc
  	/* Display may have allocated inside ggtt, so be careful with clearing h=
ere */
  	mutex_lock(&ggtt->lock);
  	drm_mm_for_each_hole(hole, &ggtt->mm, start, end)
- 		xe_ggtt_clear(ggtt, start, end - start);
+ 		xe_ggtt_clear(ggtt, ggtt->start + start, end - start);
 =20
  	xe_ggtt_invalidate(ggtt);
  	mutex_unlock(&ggtt->lock);
  }
 =20
+ static void ggtt_node_fini(struct xe_ggtt_node *node)
+ {
+ 	kfree(node);
+ }
+=20
  static void ggtt_node_remove(struct xe_ggtt_node *node)
  {
  	struct xe_ggtt *ggtt =3D node->ggtt;
@@@ -418,19 -478,14 +478,14 @@@
  	mutex_lock(&ggtt->lock);
  	bound =3D ggtt->flags & XE_GGTT_FLAGS_ONLINE;
  	if (bound)
- 		xe_ggtt_clear(ggtt, node->base.start, node->base.size);
+ 		xe_ggtt_clear(ggtt, xe_ggtt_node_addr(node), xe_ggtt_node_size(node));
  	drm_mm_remove_node(&node->base);
  	node->base.size =3D 0;
+ 	if (bound && node->invalidate_on_remove)
+ 		xe_ggtt_invalidate(ggtt);
  	mutex_unlock(&ggtt->lock);
 =20
- 	if (!bound)
- 		goto free_node;
-=20
- 	if (node->invalidate_on_remove)
- 		xe_ggtt_invalidate(ggtt);
-=20
- free_node:
- 	xe_ggtt_node_fini(node);
+ 	ggtt_node_fini(node);
  }
 =20
  static void ggtt_node_remove_work_func(struct work_struct *work)
@@@ -536,169 -591,38 +591,38 @@@ static void xe_ggtt_invalidate(struct x
  	ggtt_invalidate_gt_tlb(ggtt->tile->media_gt);
  }
 =20
- static void xe_ggtt_dump_node(struct xe_ggtt *ggtt,
- 			      const struct drm_mm_node *node, const char *description)
- {
- 	char buf[10];
-=20
- 	if (IS_ENABLED(CONFIG_DRM_XE_DEBUG)) {
- 		string_get_size(node->size, 1, STRING_UNITS_2, buf, sizeof(buf));
- 		xe_tile_dbg(ggtt->tile, "GGTT %#llx-%#llx (%s) %s\n",
- 			    node->start, node->start + node->size, buf, description);
- 	}
- }
-=20
  /**
-  * xe_ggtt_node_insert_balloon_locked - prevent allocation of specified G=
GTT addresses
-  * @node: the &xe_ggtt_node to hold reserved GGTT node
-  * @start: the starting GGTT address of the reserved region
-  * @end: then end GGTT address of the reserved region
-  *
-  * To be used in cases where ggtt->lock is already taken.
-  * Use xe_ggtt_node_remove_balloon_locked() to release a reserved GGTT no=
de.
-  *
-  * Return: 0 on success or a negative error code on failure.
-  */
- int xe_ggtt_node_insert_balloon_locked(struct xe_ggtt_node *node, u64 sta=
rt, u64 end)
- {
- 	struct xe_ggtt *ggtt =3D node->ggtt;
- 	int err;
-=20
- 	xe_tile_assert(ggtt->tile, start < end);
- 	xe_tile_assert(ggtt->tile, IS_ALIGNED(start, XE_PAGE_SIZE));
- 	xe_tile_assert(ggtt->tile, IS_ALIGNED(end, XE_PAGE_SIZE));
- 	xe_tile_assert(ggtt->tile, !drm_mm_node_allocated(&node->base));
- 	lockdep_assert_held(&ggtt->lock);
-=20
- 	node->base.color =3D 0;
- 	node->base.start =3D start;
- 	node->base.size =3D end - start;
-=20
- 	err =3D drm_mm_reserve_node(&ggtt->mm, &node->base);
-=20
- 	if (xe_tile_WARN(ggtt->tile, err, "Failed to balloon GGTT %#llx-%#llx (%=
pe)\n",
- 			 node->base.start, node->base.start + node->base.size, ERR_PTR(err)))
- 		return err;
-=20
- 	xe_ggtt_dump_node(ggtt, &node->base, "balloon");
- 	return 0;
- }
-=20
- /**
-  * xe_ggtt_node_remove_balloon_locked - release a reserved GGTT region
-  * @node: the &xe_ggtt_node with reserved GGTT region
-  *
-  * To be used in cases where ggtt->lock is already taken.
-  * See xe_ggtt_node_insert_balloon_locked() for details.
-  */
- void xe_ggtt_node_remove_balloon_locked(struct xe_ggtt_node *node)
- {
- 	if (!xe_ggtt_node_allocated(node))
- 		return;
-=20
- 	lockdep_assert_held(&node->ggtt->lock);
-=20
- 	xe_ggtt_dump_node(node->ggtt, &node->base, "remove-balloon");
-=20
- 	drm_mm_remove_node(&node->base);
- }
-=20
- static void xe_ggtt_assert_fit(struct xe_ggtt *ggtt, u64 start, u64 size)
- {
- 	struct xe_tile *tile =3D ggtt->tile;
-=20
- 	xe_tile_assert(tile, start >=3D ggtt->start);
- 	xe_tile_assert(tile, start + size <=3D ggtt->start + ggtt->size);
- }
-=20
- /**
-  * xe_ggtt_shift_nodes_locked - Shift GGTT nodes to adjust for a change i=
n usable address range.
+  * xe_ggtt_shift_nodes() - Shift GGTT nodes to adjust for a change in usa=
ble address range.
   * @ggtt: the &xe_ggtt struct instance
-  * @shift: change to the location of area provisioned for current VF
+  * @new_start: new location of area provisioned for current VF
   *
-  * This function moves all nodes from the GGTT VM, to a temp list. These =
nodes are expected
-  * to represent allocations in range formerly assigned to current VF, bef=
ore the range changed.
-  * When the GGTT VM is completely clear of any nodes, they are re-added w=
ith shifted offsets.
+  * Ensure that all struct &xe_ggtt_node are moved to the @new_start base =
address
+  * by changing the base offset of the GGTT.
   *
-  * The function has no ability of failing - because it shifts existing no=
des, without
-  * any additional processing. If the nodes were successfully existing at =
the old address,
-  * they will do the same at the new one. A fail inside this function woul=
d indicate that
-  * the list of nodes was either already damaged, or that the shift brings=
 the address range
-  * outside of valid bounds. Both cases justify an assert rather than erro=
r code.
+  * This function may be called multiple times during recovery, but if
+  * @new_start is unchanged from the current base, it's a noop.
+  *
+  * @new_start should be a value between xe_wopcm_size() and #GUC_GGTT_TOP.
   */
- void xe_ggtt_shift_nodes_locked(struct xe_ggtt *ggtt, s64 shift)
+ void xe_ggtt_shift_nodes(struct xe_ggtt *ggtt, u64 new_start)
  {
- 	struct xe_tile *tile __maybe_unused =3D ggtt->tile;
- 	struct drm_mm_node *node, *tmpn;
- 	LIST_HEAD(temp_list_head);
+ 	guard(mutex)(&ggtt->lock);
 =20
- 	lockdep_assert_held(&ggtt->lock);
+ 	xe_tile_assert(ggtt->tile, new_start >=3D xe_wopcm_size(tile_to_xe(ggtt-=
>tile)));
+ 	xe_tile_assert(ggtt->tile, new_start + ggtt->size <=3D GUC_GGTT_TOP);
 =20
- 	if (IS_ENABLED(CONFIG_DRM_XE_DEBUG))
- 		drm_mm_for_each_node_safe(node, tmpn, &ggtt->mm)
- 			xe_ggtt_assert_fit(ggtt, node->start + shift, node->size);
-=20
- 	drm_mm_for_each_node_safe(node, tmpn, &ggtt->mm) {
- 		drm_mm_remove_node(node);
- 		list_add(&node->node_list, &temp_list_head);
- 	}
-=20
- 	list_for_each_entry_safe(node, tmpn, &temp_list_head, node_list) {
- 		list_del(&node->node_list);
- 		node->start +=3D shift;
- 		drm_mm_reserve_node(&ggtt->mm, node);
- 		xe_tile_assert(tile, drm_mm_node_allocated(node));
- 	}
+ 	/* pairs with READ_ONCE in xe_ggtt_node_addr() */
+ 	WRITE_ONCE(ggtt->start, new_start);
  }
 =20
- static int xe_ggtt_node_insert_locked(struct xe_ggtt_node *node,
+ static int xe_ggtt_insert_node_locked(struct xe_ggtt_node *node,
  				      u32 size, u32 align, u32 mm_flags)
  {
  	return drm_mm_insert_node_generic(&node->ggtt->mm, &node->base, size, al=
ign, 0,
  					  mm_flags);
  }
 =20
- /**
-  * xe_ggtt_node_insert - Insert a &xe_ggtt_node into the GGTT
-  * @node: the &xe_ggtt_node to be inserted
-  * @size: size of the node
-  * @align: alignment constrain of the node
-  *
-  * It cannot be called without first having called xe_ggtt_init() once.
-  *
-  * Return: 0 on success or a negative error code on failure.
-  */
- int xe_ggtt_node_insert(struct xe_ggtt_node *node, u32 size, u32 align)
- {
- 	int ret;
-=20
- 	if (!node || !node->ggtt)
- 		return -ENOENT;
-=20
- 	mutex_lock(&node->ggtt->lock);
- 	ret =3D xe_ggtt_node_insert_locked(node, size, align,
- 					 DRM_MM_INSERT_HIGH);
- 	mutex_unlock(&node->ggtt->lock);
-=20
- 	return ret;
- }
-=20
- /**
-  * xe_ggtt_node_init - Initialize %xe_ggtt_node struct
-  * @ggtt: the &xe_ggtt where the new node will later be inserted/reserved.
-  *
-  * This function will allocate the struct %xe_ggtt_node and return its po=
inter.
-  * This struct will then be freed after the node removal upon xe_ggtt_nod=
e_remove()
-  * or xe_ggtt_node_remove_balloon_locked().
-  *
-  * Having %xe_ggtt_node struct allocated doesn't mean that the node is al=
ready
-  * allocated in GGTT. Only xe_ggtt_node_insert(), allocation through
-  * xe_ggtt_node_insert_transform(), or xe_ggtt_node_insert_balloon_locked=
() will ensure the node is inserted or reserved
-  * in GGTT.
-  *
-  * Return: A pointer to %xe_ggtt_node struct on success. An ERR_PTR other=
wise.
-  **/
- struct xe_ggtt_node *xe_ggtt_node_init(struct xe_ggtt *ggtt)
+ static struct xe_ggtt_node *ggtt_node_init(struct xe_ggtt *ggtt)
  {
  	struct xe_ggtt_node *node =3D kzalloc_obj(*node, GFP_NOFS);
 =20
@@@ -712,30 -636,31 +636,31 @@@
  }
 =20
  /**
-  * xe_ggtt_node_fini - Forcebly finalize %xe_ggtt_node struct
-  * @node: the &xe_ggtt_node to be freed
+  * xe_ggtt_insert_node - Insert a &xe_ggtt_node into the GGTT
+  * @ggtt: the &xe_ggtt into which the node should be inserted.
+  * @size: size of the node
+  * @align: alignment constrain of the node
   *
-  * If anything went wrong with either xe_ggtt_node_insert(), xe_ggtt_node=
_insert_locked(),
-  * or xe_ggtt_node_insert_balloon_locked(); and this @node is not going t=
o be reused, then,
-  * this function needs to be called to free the %xe_ggtt_node struct
-  **/
- void xe_ggtt_node_fini(struct xe_ggtt_node *node)
- {
- 	kfree(node);
- }
-=20
- /**
-  * xe_ggtt_node_allocated - Check if node is allocated in GGTT
-  * @node: the &xe_ggtt_node to be inspected
-  *
-  * Return: True if allocated, False otherwise.
+  * Return: &xe_ggtt_node on success or a ERR_PTR on failure.
   */
- bool xe_ggtt_node_allocated(const struct xe_ggtt_node *node)
+ struct xe_ggtt_node *xe_ggtt_insert_node(struct xe_ggtt *ggtt, u32 size, =
u32 align)
  {
- 	if (!node || !node->ggtt)
- 		return false;
+ 	struct xe_ggtt_node *node;
+ 	int ret;
 =20
- 	return drm_mm_node_allocated(&node->base);
+ 	node =3D ggtt_node_init(ggtt);
+ 	if (IS_ERR(node))
+ 		return node;
+=20
+ 	guard(mutex)(&ggtt->lock);
+ 	ret =3D xe_ggtt_insert_node_locked(node, size, align,
+ 					 DRM_MM_INSERT_HIGH);
+ 	if (ret) {
+ 		ggtt_node_fini(node);
+ 		return ERR_PTR(ret);
+ 	}
+=20
+ 	return node;
  }
 =20
  /**
@@@ -768,7 -693,7 +693,7 @@@ static void xe_ggtt_map_bo(struct xe_gg
  	if (XE_WARN_ON(!node))
  		return;
 =20
- 	start =3D node->base.start;
+ 	start =3D xe_ggtt_node_addr(node);
  	end =3D start + xe_bo_size(bo);
 =20
  	if (!xe_bo_is_vram(bo) && !xe_bo_is_stolen(bo)) {
@@@ -809,7 -734,7 +734,7 @@@ void xe_ggtt_map_bo_unlocked(struct xe_
  }
 =20
  /**
-  * xe_ggtt_node_insert_transform - Insert a newly allocated &xe_ggtt_node=
 into the GGTT
+  * xe_ggtt_insert_node_transform - Insert a newly allocated &xe_ggtt_node=
 into the GGTT
   * @ggtt: the &xe_ggtt where the node will inserted/reserved.
   * @bo: The bo to be transformed
   * @pte_flags: The extra GGTT flags to add to mapping.
@@@ -823,7 -748,7 +748,7 @@@
   *
   * Return: A pointer to %xe_ggtt_node struct on success. An ERR_PTR other=
wise.
   */
- struct xe_ggtt_node *xe_ggtt_node_insert_transform(struct xe_ggtt *ggtt,
+ struct xe_ggtt_node *xe_ggtt_insert_node_transform(struct xe_ggtt *ggtt,
  						   struct xe_bo *bo, u64 pte_flags,
  						   u64 size, u32 align,
  						   xe_ggtt_transform_cb transform, void *arg)
@@@ -831,7 -756,7 +756,7 @@@
  	struct xe_ggtt_node *node;
  	int ret;
 =20
- 	node =3D xe_ggtt_node_init(ggtt);
+ 	node =3D ggtt_node_init(ggtt);
  	if (IS_ERR(node))
  		return ERR_CAST(node);
 =20
@@@ -840,7 -765,7 +765,7 @@@
  		goto err;
  	}
 =20
- 	ret =3D xe_ggtt_node_insert_locked(node, size, align, 0);
+ 	ret =3D xe_ggtt_insert_node_locked(node, size, align, 0);
  	if (ret)
  		goto err_unlock;
 =20
@@@ -855,7 -780,7 +780,7 @@@
  err_unlock:
  	mutex_unlock(&ggtt->lock);
  err:
- 	xe_ggtt_node_fini(node);
+ 	ggtt_node_fini(node);
  	return ERR_PTR(ret);
  }
 =20
@@@ -881,7 -806,7 +806,7 @@@ static int __xe_ggtt_insert_bo_at(struc
 =20
  	xe_pm_runtime_get_noresume(tile_to_xe(ggtt->tile));
 =20
- 	bo->ggtt_node[tile_id] =3D xe_ggtt_node_init(ggtt);
+ 	bo->ggtt_node[tile_id] =3D ggtt_node_init(ggtt);
  	if (IS_ERR(bo->ggtt_node[tile_id])) {
  		err =3D PTR_ERR(bo->ggtt_node[tile_id]);
  		bo->ggtt_node[tile_id] =3D NULL;
@@@ -889,10 -814,30 +814,30 @@@
  	}
 =20
  	mutex_lock(&ggtt->lock);
+ 	/*
+ 	 * When inheriting the initial framebuffer, the framebuffer is
+ 	 * physically located at VRAM address 0, and usually at GGTT address 0 t=
oo.
+ 	 *
+ 	 * The display code will ask for a GGTT allocation between end of BO and
+ 	 * remainder of GGTT, unaware that the start is reserved by WOPCM.
+ 	 */
+ 	if (start >=3D ggtt->start)
+ 		start -=3D ggtt->start;
+ 	else
+ 		start =3D 0;
+=20
+ 	/* Should never happen, but since we handle start, fail graciously for e=
nd */
+ 	if (end >=3D ggtt->start)
+ 		end -=3D ggtt->start;
+ 	else
+ 		end =3D 0;
+=20
+ 	xe_tile_assert(ggtt->tile, end >=3D start + xe_bo_size(bo));
+=20
  	err =3D drm_mm_insert_node_in_range(&ggtt->mm, &bo->ggtt_node[tile_id]->=
base,
  					  xe_bo_size(bo), alignment, 0, start, end, 0);
  	if (err) {
- 		xe_ggtt_node_fini(bo->ggtt_node[tile_id]);
+ 		ggtt_node_fini(bo->ggtt_node[tile_id]);
  		bo->ggtt_node[tile_id] =3D NULL;
  	} else {
  		u16 cache_mode =3D bo->flags & XE_BO_FLAG_NEEDS_UC ? XE_CACHE_NONE : XE=
_CACHE_WB;
@@@ -1000,18 -945,16 +945,16 @@@ static u64 xe_encode_vfid_pte(u16 vfid
  	return FIELD_PREP(GGTT_PTE_VFID, vfid) | XE_PAGE_PRESENT;
  }
 =20
- static void xe_ggtt_assign_locked(struct xe_ggtt *ggtt, const struct drm_=
mm_node *node, u16 vfid)
+ static void xe_ggtt_assign_locked(const struct xe_ggtt_node *node, u16 vf=
id)
  {
- 	u64 start =3D node->start;
- 	u64 size =3D node->size;
+ 	struct xe_ggtt *ggtt =3D node->ggtt;
+ 	u64 start =3D xe_ggtt_node_addr(node);
+ 	u64 size =3D xe_ggtt_node_size(node);
  	u64 end =3D start + size - 1;
  	u64 pte =3D xe_encode_vfid_pte(vfid);
 =20
  	lockdep_assert_held(&ggtt->lock);
 =20
- 	if (!drm_mm_node_allocated(node))
- 		return;
-=20
  	while (start < end) {
  		ggtt->pt_ops->ggtt_set_pte(ggtt, start, pte);
  		start +=3D XE_PAGE_SIZE;
@@@ -1031,9 -974,8 +974,8 @@@
   */
  void xe_ggtt_assign(const struct xe_ggtt_node *node, u16 vfid)
  {
- 	mutex_lock(&node->ggtt->lock);
- 	xe_ggtt_assign_locked(node->ggtt, &node->base, vfid);
- 	mutex_unlock(&node->ggtt->lock);
+ 	guard(mutex)(&node->ggtt->lock);
+ 	xe_ggtt_assign_locked(node, vfid);
  }
 =20
  /**
@@@ -1055,14 -997,14 +997,14 @@@ int xe_ggtt_node_save(struct xe_ggtt_no
  	if (!node)
  		return -ENOENT;
 =20
- 	guard(mutex)(&node->ggtt->lock);
+ 	ggtt =3D node->ggtt;
+ 	guard(mutex)(&ggtt->lock);
 =20
  	if (xe_ggtt_node_pt_size(node) !=3D size)
  		return -EINVAL;
 =20
- 	ggtt =3D node->ggtt;
- 	start =3D node->base.start;
- 	end =3D start + node->base.size - 1;
+ 	start =3D xe_ggtt_node_addr(node);
+ 	end =3D start + xe_ggtt_node_size(node) - 1;
 =20
  	while (start < end) {
  		pte =3D ggtt->pt_ops->ggtt_get_pte(ggtt, start);
@@@ -1095,14 -1037,14 +1037,14 @@@ int xe_ggtt_node_load(struct xe_ggtt_no
  	if (!node)
  		return -ENOENT;
 =20
- 	guard(mutex)(&node->ggtt->lock);
+ 	ggtt =3D node->ggtt;
+ 	guard(mutex)(&ggtt->lock);
 =20
  	if (xe_ggtt_node_pt_size(node) !=3D size)
  		return -EINVAL;
 =20
- 	ggtt =3D node->ggtt;
- 	start =3D node->base.start;
- 	end =3D start + node->base.size - 1;
+ 	start =3D xe_ggtt_node_addr(node);
+ 	end =3D start + xe_ggtt_node_size(node) - 1;
 =20
  	while (start < end) {
  		vfid_pte =3D u64_replace_bits(*buf++, vfid, GGTT_PTE_VFID);
@@@ -1209,7 -1151,8 +1151,8 @@@ u64 xe_ggtt_read_pte(struct xe_ggtt *gg
   */
  u64 xe_ggtt_node_addr(const struct xe_ggtt_node *node)
  {
- 	return node->base.start;
+ 	/* pairs with WRITE_ONCE in xe_ggtt_shift_nodes() */
+ 	return node->base.start + READ_ONCE(node->ggtt->start);
  }
 =20
  /**

--4Gl4ABwND1g0/7H5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnKm3MACgkQJNaLcl1U
h9DWZAf+PkP6X5w+ddjybu9+QAgNefyxcF2QTan8ffmM2WtdOArkl1G2VoqIq6YW
LDHqO+NBxmGC+WHHdLorQr+7GySCzg8rLQlaxGteebCdobjxDVm1bDYfJGX9UbOH
qf0o3CVgwLhGtWMHlrXEzrCaoAAJap9j6bgNl/hLDgrSUyMQIkjjFE4Ch8mH0rc1
eQSba9jYQ6MWVDVThwURK539UhICRn8ICUJBZMUnrCtBXF/SdYwnv8k5Wrx/WpPC
r25VoRqfABPxUHe0s5+veggH1+T8Qz+HZlAkgmc6OvftmsPq4LFiA8K6woWuFhYC
pEkXWuCVai6TPLp58M5/siheHs07bw==
=ligj
-----END PGP SIGNATURE-----

--4Gl4ABwND1g0/7H5--
