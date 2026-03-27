Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EC2810F2865
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 20:56:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EE3410EF5A;
	Fri, 27 Mar 2026 20:56:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="vRHZj7Ps";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EC7910EF5A
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 20:56:44 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id C73694398E;
 Fri, 27 Mar 2026 20:56:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55DF8C19423;
 Fri, 27 Mar 2026 20:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774645003;
 bh=uG/iR8i6NcKGGxPafCXRFo7WTHZIQsufmiwWKK5ZQOQ=;
 h=Date:From:To:Cc:Subject:From;
 b=vRHZj7Psye7PkzjbZuvc+XNkdOc6TrX0rNsDzHEH/sjJMN2sq1qDHqyB9JvX0Xlgr
 pDLz7reqdavuqGqAT63r/6ooFsPNoiP71CM0+sHb1z1iKDOQrRwEnf22xDAQRhqZJQ
 cM0E2kJ+16xwPPhoZLj7UIFmN4hRI2sJ4fUJyaz8AwkTlsmSd1UTyBparzg0Ni0mL1
 KTYo95F9TQcSzqc5byd4AmR2lMiwkgHxF5WLwDbWI7Fn+F80oeiAndELk07gkpX8Sq
 z2oumLKpcByuKFMK9VuARSxb77+ZCfP5ew3EWu3zAAPL/fdqUcG4X2zPw73HMxMRDq
 2nNYiXGxCRhcg==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
 id BE7D71AC589B; Fri, 27 Mar 2026 20:56:40 +0000 (GMT)
Date: Fri, 27 Mar 2026 20:56:40 +0000
From: Mark Brown <broonie@kernel.org>
To: Dave Airlie <airlied@redhat.com>, DRI <dri-devel@lists.freedesktop.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Maarten Lankhorst <dev@lankhorst.se>,
 Matthew Brost <matthew.brost@intel.com>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Subject: linux-next: manual merge of the drm tree with the origin tree
Message-ID: <acbvCOgSRyDI5Kqx@sirena.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+vp294VKlcdk/a+r"
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


--+vp294VKlcdk/a+r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm tree got a conflict in:

  drivers/gpu/drm/xe/xe_ggtt.c

between commit:

  01f2557aa684e5 ("drm/xe: Open-code GGTT MMIO access protection")

=66rom the origin tree and commits:

  4f3a998a173b43 ("drm/xe: Open-code GGTT MMIO access protection")
  e904c56ba6e0d4 ("drm/xe: Rewrite GGTT VF initialization")

=66rom the drm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --combined drivers/gpu/drm/xe/xe_ggtt.c
index d1561ebe4e56ca,21071b64b09dfa..00000000000000
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
@@@ -418,7 -478,7 +478,7 @@@
  	mutex_lock(&ggtt->lock);
  	bound =3D ggtt->flags & XE_GGTT_FLAGS_ONLINE;
  	if (bound)
- 		xe_ggtt_clear(ggtt, node->base.start, node->base.size);
+ 		xe_ggtt_clear(ggtt, xe_ggtt_node_addr(node), xe_ggtt_node_size(node));
  	drm_mm_remove_node(&node->base);
  	node->base.size =3D 0;
  	mutex_unlock(&ggtt->lock);
@@@ -430,7 -490,7 +490,7 @@@
  		xe_ggtt_invalidate(ggtt);
 =20
  free_node:
- 	xe_ggtt_node_fini(node);
+ 	ggtt_node_fini(node);
  }
 =20
  static void ggtt_node_remove_work_func(struct work_struct *work)
@@@ -536,169 -596,38 +596,38 @@@ static void xe_ggtt_invalidate(struct x
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
@@@ -712,30 -641,31 +641,31 @@@
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
@@@ -768,7 -698,7 +698,7 @@@ static void xe_ggtt_map_bo(struct xe_gg
  	if (XE_WARN_ON(!node))
  		return;
 =20
- 	start =3D node->base.start;
+ 	start =3D xe_ggtt_node_addr(node);
  	end =3D start + xe_bo_size(bo);
 =20
  	if (!xe_bo_is_vram(bo) && !xe_bo_is_stolen(bo)) {
@@@ -809,7 -739,7 +739,7 @@@ void xe_ggtt_map_bo_unlocked(struct xe_
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
@@@ -823,7 -753,7 +753,7 @@@
   *
   * Return: A pointer to %xe_ggtt_node struct on success. An ERR_PTR other=
wise.
   */
- struct xe_ggtt_node *xe_ggtt_node_insert_transform(struct xe_ggtt *ggtt,
+ struct xe_ggtt_node *xe_ggtt_insert_node_transform(struct xe_ggtt *ggtt,
  						   struct xe_bo *bo, u64 pte_flags,
  						   u64 size, u32 align,
  						   xe_ggtt_transform_cb transform, void *arg)
@@@ -831,7 -761,7 +761,7 @@@
  	struct xe_ggtt_node *node;
  	int ret;
 =20
- 	node =3D xe_ggtt_node_init(ggtt);
+ 	node =3D ggtt_node_init(ggtt);
  	if (IS_ERR(node))
  		return ERR_CAST(node);
 =20
@@@ -840,7 -770,7 +770,7 @@@
  		goto err;
  	}
 =20
- 	ret =3D xe_ggtt_node_insert_locked(node, size, align, 0);
+ 	ret =3D xe_ggtt_insert_node_locked(node, size, align, 0);
  	if (ret)
  		goto err_unlock;
 =20
@@@ -855,7 -785,7 +785,7 @@@
  err_unlock:
  	mutex_unlock(&ggtt->lock);
  err:
- 	xe_ggtt_node_fini(node);
+ 	ggtt_node_fini(node);
  	return ERR_PTR(ret);
  }
 =20
@@@ -881,7 -811,7 +811,7 @@@ static int __xe_ggtt_insert_bo_at(struc
 =20
  	xe_pm_runtime_get_noresume(tile_to_xe(ggtt->tile));
 =20
- 	bo->ggtt_node[tile_id] =3D xe_ggtt_node_init(ggtt);
+ 	bo->ggtt_node[tile_id] =3D ggtt_node_init(ggtt);
  	if (IS_ERR(bo->ggtt_node[tile_id])) {
  		err =3D PTR_ERR(bo->ggtt_node[tile_id]);
  		bo->ggtt_node[tile_id] =3D NULL;
@@@ -889,10 -819,30 +819,30 @@@
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
@@@ -1000,18 -950,16 +950,16 @@@ static u64 xe_encode_vfid_pte(u16 vfid
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
@@@ -1031,9 -979,8 +979,8 @@@
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
@@@ -1055,14 -1002,14 +1002,14 @@@ int xe_ggtt_node_save(struct xe_ggtt_no
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
@@@ -1095,14 -1042,14 +1042,14 @@@ int xe_ggtt_node_load(struct xe_ggtt_no
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
@@@ -1209,7 -1156,8 +1156,8 @@@ u64 xe_ggtt_read_pte(struct xe_ggtt *gg
   */
  u64 xe_ggtt_node_addr(const struct xe_ggtt_node *node)
  {
- 	return node->base.start;
+ 	/* pairs with WRITE_ONCE in xe_ggtt_shift_nodes() */
+ 	return node->base.start + READ_ONCE(node->ggtt->start);
  }
 =20
  /**

--+vp294VKlcdk/a+r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnG7wcACgkQJNaLcl1U
h9Dk9Af/ZeXQCqHLBwp2hfB9RUJO0ougbEi5x0Z5UEeWhyXyzX/mmlumTfDoVCQD
3Z1XXMDEHKJK7/+rDT/xDAZaxIlKEDqebL+E3qDSZ9CzPBJmZr3b9anPxRpP7jxj
xeqodoFQyBpg2H30uX8TpqSFcwr4EeGb4EK4ySA3vrXKGMDFTbWSH0PR2YbzcJj/
ad2vaFbzpuNGeKJmcUKd6t9Lo6DfTDRMW0tzV6pQ2/RRpPiaUAdVBomQCMPeeS3y
skhegrHgXeJxynFRDD77NxMAW1jW2mgmkOnSv0QIKtGMGP7ag1UUXLJoPPjXjIqT
X6T7dWpaLHLgOQH9NUVAMPkrOKww1Q==
=lLUC
-----END PGP SIGNATURE-----

--+vp294VKlcdk/a+r--
