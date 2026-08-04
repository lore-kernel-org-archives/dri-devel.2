Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5CA0C55172
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 10:10:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67C8210E997;
	Tue,  4 Aug 2026 10:10:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="eXxJQ1AB";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37A8210E991
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 10:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1785838198;
 bh=f8vFWPW3Sz1raEvU2KHEctAC8v0qwf+N55cUGo+b5zE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=eXxJQ1ABPN5qlvU9yUIlnkrbHTeyXlR6MkktcvpoytPNAChTaglmkl4D85lR1B9g3
 lPPrUTAEtGrYr7ss7d5HVSGn0uflbpI65c2EOs44Iblr06siRFVtvjqufSfGw5ETID
 ZkKiy+JfPctyskvaJoFFjQ6UZ+TFu4YW3fH3NwUunRtxouWbxs2KesHzi8T9l+OOe2
 6coR+cEzf7Z0shCltJx3FkE069VBLubdnFiezhD0P6QiDuCdilahYbrDyVEi08Zzn5
 d5YbcDjnhg8y9LQdNU16uONc6DdjDnxTDcXAhGq3FdH/TGwt44cqlIELvWbcY6h6lO
 3KBQqI7b5jGog==
Received: from fedora-21.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 8BF0F17E10BC;
 Tue, 04 Aug 2026 12:09:57 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Tue, 04 Aug 2026 12:09:45 +0200
Subject: [PATCH 06/12] drm/panthor: Split panthor_vm
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-panthor-unplug-fixes-v1-6-abbbd2d41b13@collabora.com>
References: <20260804-panthor-unplug-fixes-v1-0-abbbd2d41b13@collabora.com>
In-Reply-To: <20260804-panthor-unplug-fixes-v1-0-abbbd2d41b13@collabora.com>
To: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785838194; l=79357;
 i=boris.brezillon@collabora.com; s=20260429; h=from:subject:message-id;
 bh=f8vFWPW3Sz1raEvU2KHEctAC8v0qwf+N55cUGo+b5zE=;
 b=dsaT4JGE+/KzJeL7Svn7vNK6JtKpEFa/D/SoDe6NVUS2nXJpDVs21re5VI1l8y0RJeqPYlZMn
 UmdXXaQGR/oCJj/jBWBOoxb/WA89FMp1S8yv3y451y+PL8W00+owVS5
X-Developer-Key: i=boris.brezillon@collabora.com; a=ed25519;
 pk=eN+ORdOgQY7d5U+0kA8h5bf67XdD8bhKbjD/TCHexSY=
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

The way things are currently defined makes the cleanup procedure harder
because the panthor_vm object cleanup happens after drm_gpuvm_fini() has
been called, and sometimes we need a drm_gpuvm to undo things.
This has been worked around by things like the panthor_vm_unmap_range()
call in panthor_vm_destroy(), but there are still situations where this
is problematic, like the show_each_vm() where we walk a list of VM and
call drm_debugfs_gpuva_info() on each, with the risk of hitting an object
that had drm_gpuvm_fini() called on it already.

There's more of these tricky situations to come when we get to making
the unplug logic more robust, so let's address the problem ahead of it
and split the panthor_vm object in two:

- panthor_as: this is the object embedding drm_gpuvm and more
  generally dealing with page table updates/residency
- panthor_vm: this is the user-visible object wrapping around
  panthor_as. Among other things, it contains the scheduler for
  the bind queue and the drm_mm tree for kernel BO allocation.
  This object owns a drm_gpuvm ref.

With this in place, we can do the cleanup steps that need a valid
drm_gpuvm object in panthor_vm_release(), and the rest is cleaned up
in panthor_vm_pgtable_free().

Note that there's a bunch of s/as[_nr]/slot/ variable/argument renames
to clear the confusion between the AS slot number and the newly
introduced panthor_as object.

Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_mmu.c | 1052 +++++++++++++++++----------------
 1 file changed, 552 insertions(+), 500 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index fb9dec64d320..2d462813a711 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -41,14 +41,14 @@
 
 #define MAX_AS_SLOTS			32
 
-struct panthor_vm;
+struct panthor_as;
 
 /**
  * struct panthor_as_slot - Address space slot
  */
 struct panthor_as_slot {
-	/** @vm: VM bound to this slot. NULL is no VM is bound. */
-	struct panthor_vm *vm;
+	/** @as: AS bound to this slot. NULL if no AS is bound. */
+	struct panthor_as *as;
 };
 
 /**
@@ -77,19 +77,19 @@ struct panthor_mmu {
 		/** @as.faulty_mask: Bitmask encoding the faulty slots. */
 		unsigned long faulty_mask;
 
-		/** @as.slots: VMs currently bound to the AS slots. */
+		/** @as.slots: AS currently bound to the AS slots. */
 		struct panthor_as_slot slots[MAX_AS_SLOTS];
 
 		/**
-		 * @as.lru_list: List of least recently used VMs.
+		 * @as.lru_list: List of least recently used AS.
 		 *
-		 * We use this list to pick a VM to evict when all slots are
+		 * We use this list to pick an AS to evict when all slots are
 		 * used.
 		 *
-		 * There should be no more active VMs than there are AS slots,
-		 * so this LRU is just here to keep VMs bound until there's
-		 * a need to release a slot, thus avoid unnecessary TLB/cache
-		 * flushes.
+		 * There should be no more active AS than there are AS slots,
+		 * so this LRU is just here to keep page tables bound until
+		 * there's a need to release a slot, thus avoiding unnecessary
+		 * TLB/cache flushes.
 		 */
 		struct list_head lru_list;
 	} as;
@@ -153,9 +153,9 @@ struct panthor_vma {
 };
 
 /**
- * struct panthor_vm_op_ctx - VM operation context
+ * struct panthor_as_op_ctx - AS operation context
  *
- * With VM operations potentially taking place in a dma-signaling path, we
+ * With AS operations potentially taking place in a dma-signaling path, we
  * need to make sure everything that might require resource allocation is
  * pre-allocated upfront. This is what this operation context is far.
  *
@@ -163,7 +163,7 @@ struct panthor_vma {
  * asynchronously, and let the VM_BIND scheduler process the next VM_BIND
  * request.
  */
-struct panthor_vm_op_ctx {
+struct panthor_as_op_ctx {
 	/** @rsvd_page_tables: Pages reserved for the MMU page table update. */
 	struct {
 		/** @rsvd_page_tables.count: Number of pages reserved. */
@@ -215,13 +215,120 @@ struct panthor_vm_op_ctx {
 	} map;
 };
 
+/**
+ * struct panthor_as - Used to managed a GPU address space.
+ */
+struct panthor_as {
+	/**
+	 * @base: Inherit from drm_gpuvm.
+	 *
+	 * We delegate all the VA management to the common drm_gpuvm framework
+	 * and only implement hooks to update the MMU page table.
+	 */
+	struct drm_gpuvm base;
+
+	/** @memattr: Value to program to the AS_MEMATTR register. */
+	u64 memattr;
+
+	/** @pt: Page table fields. */
+	struct {
+		/** @pt.ops: Page table ops. */
+		struct io_pgtable_ops *ops;
+
+		/** @pt.root: Page table root. */
+		void *root;
+	} pt;
+
+	/**
+	 * @op_lock: Lock used to serialize operations on the AS.
+	 *
+	 * The serialization of jobs queued to the VM_BIND queue is already
+	 * taken care of by drm_sched, but we need to serialize synchronous
+	 * and asynchronous VM_BIND request. This is what this lock is for.
+	 */
+	struct mutex op_lock;
+
+	/**
+	 * @op_ctx: The context attached to the currently executing operation.
+	 *
+	 * NULL when no operation is in progress.
+	 */
+	struct panthor_as_op_ctx *op_ctx;
+
+	/** @active_cnt: Number of active users of this address space. */
+	refcount_t active_cnt;
+
+	/** @hw_slot: Hardware slot related fields. */
+	struct {
+		/**
+		 * @hw_slot.id: ID of the slot this AS is bound to.
+		 *
+		 * A value of -1 means the AS is inactive/not bound.
+		 */
+		int id;
+
+		/**
+		 * @hw_slot.lru_node: Used to insert the AS in panthor_mmu::as::lru_list.
+		 *
+		 * Active ASs should not be inserted in the LRU list.
+		 */
+		struct list_head lru_node;
+	} hw_slot;
+
+	/**
+	 * @unusable: True if the AS has turned unusable because something
+	 * bad happened during an asynchronous request.
+	 *
+	 * We don't try to recover from such failures, because this implies
+	 * informing userspace about the specific operation that failed, and
+	 * hoping the userspace driver can replay things from there. This all
+	 * sounds very complicated for little gain.
+	 *
+	 * Instead, we should just flag the AS as unusable, and fail any
+	 * further request targeting this AS.
+	 *
+	 * We also provide a way to query an AS state, so userspace can
+	 * destroy it and create a new one.
+	 *
+	 * As an analogy, this would be mapped to a VK_ERROR_DEVICE_LOST
+	 * situation, where the logical device needs to be re-created.
+	 */
+	bool unusable;
+
+	/**
+	 * @unhandled_fault: Unhandled fault happened.
+	 *
+	 * This should be reported to the scheduler, and the queue/group be
+	 * flagged as faulty as a result.
+	 */
+	bool unhandled_fault;
+
+	/** @locked_region: Information about the currently locked region currently. */
+	struct {
+		/** @locked_region.start: Start of the locked region. */
+		u64 start;
+
+		/** @locked_region.size: Size of the locked region. */
+		u64 size;
+	} locked_region;
+
+	/** @reclaim: Fields related to BO reclaim. */
+	struct {
+		/** @reclaim.lru: LRU of BOs that are only mapped to this AS. */
+		struct drm_gem_lru lru;
+
+		/**
+		 * @reclaim.lru_node: Node used to insert the AS in
+		 * panthor_device::reclaim::vms.
+		 */
+		struct list_head lru_node;
+	} reclaim;
+};
+
 /**
  * struct panthor_vm - VM object
  *
  * A VM is an object representing a GPU (or MCU) virtual address space.
- * It embeds the MMU page table for this address space, a tree containing
- * all the virtual mappings of GEM objects, and other things needed to manage
- * the VM.
  *
  * Except for the MCU VM, which is managed by the kernel, all other VMs are
  * created by userspace and mostly managed by userspace, using the
@@ -233,13 +340,11 @@ struct panthor_vm_op_ctx {
  * by default).
  */
 struct panthor_vm {
-	/**
-	 * @base: Inherit from drm_gpuvm.
-	 *
-	 * We delegate all the VA management to the common drm_gpuvm framework
-	 * and only implement hooks to update the MMU page table.
-	 */
-	struct drm_gpuvm base;
+	/** @refcount: VM refcount. */
+	struct kref refcount;
+
+	/** @as: VM address space. */
+	struct panthor_as *as;
 
 	/**
 	 * @sched: Scheduler used for asynchronous VM_BIND request.
@@ -256,34 +361,6 @@ struct panthor_vm {
 	 */
 	struct drm_sched_entity entity;
 
-	/** @ptdev: Device. */
-	struct panthor_device *ptdev;
-
-	/** @memattr: Value to program to the AS_MEMATTR register. */
-	u64 memattr;
-
-	/** @pgtbl_ops: Page table operations. */
-	struct io_pgtable_ops *pgtbl_ops;
-
-	/** @root_page_table: Stores the root page table pointer. */
-	void *root_page_table;
-
-	/**
-	 * @op_lock: Lock used to serialize operations on a VM.
-	 *
-	 * The serialization of jobs queued to the VM_BIND queue is already
-	 * taken care of by drm_sched, but we need to serialize synchronous
-	 * and asynchronous VM_BIND request. This is what this lock is for.
-	 */
-	struct mutex op_lock;
-
-	/**
-	 * @op_ctx: The context attached to the currently executing VM operation.
-	 *
-	 * NULL when no operation is in progress.
-	 */
-	struct panthor_vm_op_ctx *op_ctx;
-
 	/**
 	 * @mm: Memory management object representing the auto-VA/kernel-VA.
 	 *
@@ -313,26 +390,6 @@ struct panthor_vm {
 	/** @user_va_range: Upper boundary of VAs VM users can map objects against. */
 	u64 user_va_range;
 
-	/** @as: Address space related fields. */
-	struct {
-		/**
-		 * @as.id: ID of the address space this VM is bound to.
-		 *
-		 * A value of -1 means the VM is inactive/not bound.
-		 */
-		int id;
-
-		/** @as.active_cnt: Number of active users of this VM. */
-		refcount_t active_cnt;
-
-		/**
-		 * @as.lru_node: Used to instead the VM in the panthor_mmu::as::lru_list.
-		 *
-		 * Active VMs should not be inserted in the LRU list.
-		 */
-		struct list_head lru_node;
-	} as;
-
 	/**
 	 * @heaps: Tiler heap related fields.
 	 */
@@ -361,55 +418,6 @@ struct panthor_vm {
 	 */
 	bool destroyed;
 
-	/**
-	 * @unusable: True if the VM has turned unusable because something
-	 * bad happened during an asynchronous request.
-	 *
-	 * We don't try to recover from such failures, because this implies
-	 * informing userspace about the specific operation that failed, and
-	 * hoping the userspace driver can replay things from there. This all
-	 * sounds very complicated for little gain.
-	 *
-	 * Instead, we should just flag the VM as unusable, and fail any
-	 * further request targeting this VM.
-	 *
-	 * We also provide a way to query a VM state, so userspace can destroy
-	 * it and create a new one.
-	 *
-	 * As an analogy, this would be mapped to a VK_ERROR_DEVICE_LOST
-	 * situation, where the logical device needs to be re-created.
-	 */
-	bool unusable;
-
-	/**
-	 * @unhandled_fault: Unhandled fault happened.
-	 *
-	 * This should be reported to the scheduler, and the queue/group be
-	 * flagged as faulty as a result.
-	 */
-	bool unhandled_fault;
-
-	/** @locked_region: Information about the currently locked region currently. */
-	struct {
-		/** @locked_region.start: Start of the locked region. */
-		u64 start;
-
-		/** @locked_region.size: Size of the locked region. */
-		u64 size;
-	} locked_region;
-
-	/** @reclaim: Fields related to BO reclaim. */
-	struct {
-		/** @reclaim.lru: LRU of BOs that are only mapped to this VM. */
-		struct drm_gem_lru lru;
-
-		/**
-		 * @reclaim.lru_node: Node used to insert the VM in
-		 * panthor_device::reclaim::vms.
-		 */
-		struct list_head lru_node;
-	} reclaim;
-
 	/**
 	 * @dummy: Dummy object used for sparse mappings.
 	 *
@@ -437,7 +445,7 @@ struct panthor_vm_bind_job {
 	struct panthor_vm *vm;
 
 	/** @ctx: Operation context. */
-	struct panthor_vm_op_ctx ctx;
+	struct panthor_as_op_ctx ctx;
 };
 
 /*
@@ -466,36 +474,37 @@ static struct kmem_cache *pt_cache;
  */
 static void *alloc_pt(void *cookie, size_t size, gfp_t gfp)
 {
-	struct panthor_vm *vm = cookie;
+	struct panthor_as *as = cookie;
+	struct panthor_as_op_ctx *op_ctx = as->op_ctx;
+	struct drm_device *ddev = as->base.drm;
 	void *page;
 
 	/* Allocation of the root page table happening during init. */
-	if (unlikely(!vm->root_page_table)) {
+	if (unlikely(!as->pt.root)) {
+		struct device *dev = drm_dev_dma_dev(ddev);
 		struct page *p;
 
-		drm_WARN_ON(&vm->ptdev->base, vm->op_ctx);
-		p = alloc_pages_node(dev_to_node(vm->ptdev->base.dev),
-				     gfp | __GFP_ZERO, get_order(size));
+		drm_WARN_ON(ddev, op_ctx);
+		p = alloc_pages_node(dev_to_node(dev), gfp | __GFP_ZERO, get_order(size));
 		page = p ? page_address(p) : NULL;
-		vm->root_page_table = page;
+		as->pt.root = page;
 		return page;
 	}
 
 	/* We're not supposed to have anything bigger than 4k here, because we picked a
 	 * 4k granule size at init time.
 	 */
-	if (drm_WARN_ON(&vm->ptdev->base, size != SZ_4K))
+	if (drm_WARN_ON(ddev, size != SZ_4K))
 		return NULL;
 
 	/* We must have some op_ctx attached to the VM and it must have at least one
 	 * free page.
 	 */
-	if (drm_WARN_ON(&vm->ptdev->base, !vm->op_ctx) ||
-	    drm_WARN_ON(&vm->ptdev->base,
-			vm->op_ctx->rsvd_page_tables.ptr >= vm->op_ctx->rsvd_page_tables.count))
+	if (drm_WARN_ON(ddev, !op_ctx) ||
+	    drm_WARN_ON(ddev, op_ctx->rsvd_page_tables.ptr >= op_ctx->rsvd_page_tables.count))
 		return NULL;
 
-	page = vm->op_ctx->rsvd_page_tables.pages[vm->op_ctx->rsvd_page_tables.ptr++];
+	page = op_ctx->rsvd_page_tables.pages[op_ctx->rsvd_page_tables.ptr++];
 	memset(page, 0, SZ_4K);
 
 	/* Page table entries don't use virtual addresses, which trips out
@@ -518,22 +527,23 @@ static void *alloc_pt(void *cookie, size_t size, gfp_t gfp)
  */
 static void free_pt(void *cookie, void *data, size_t size)
 {
-	struct panthor_vm *vm = cookie;
+	struct panthor_as *as = cookie;
+	struct drm_device *ddev = as->base.drm;
 
-	if (unlikely(vm->root_page_table == data)) {
+	if (unlikely(as->pt.root == data)) {
 		free_pages((unsigned long)data, get_order(size));
-		vm->root_page_table = NULL;
+		as->pt.root = NULL;
 		return;
 	}
 
-	if (drm_WARN_ON(&vm->ptdev->base, size != SZ_4K))
+	if (drm_WARN_ON(ddev, size != SZ_4K))
 		return;
 
 	/* Return the page to the pt_cache. */
 	kmem_cache_free(pt_cache, data);
 }
 
-static int wait_ready(struct panthor_device *ptdev, u32 as_nr)
+static int wait_ready(struct panthor_device *ptdev, u32 slot)
 {
 	struct panthor_mmu *mmu = ptdev->mmu;
 	int ret;
@@ -542,7 +552,7 @@ static int wait_ready(struct panthor_device *ptdev, u32 as_nr)
 	/* Wait for the MMU status to indicate there is no active command, in
 	 * case one is pending.
 	 */
-	ret = gpu_read_relaxed_poll_timeout_atomic(mmu->iomem, AS_STATUS(as_nr), val,
+	ret = gpu_read_relaxed_poll_timeout_atomic(mmu->iomem, AS_STATUS(slot), val,
 						   !(val & AS_STATUS_AS_ACTIVE), 10, 100000);
 
 	if (ret) {
@@ -553,15 +563,15 @@ static int wait_ready(struct panthor_device *ptdev, u32 as_nr)
 	return ret;
 }
 
-static int as_send_cmd_and_wait(struct panthor_device *ptdev, u32 as_nr, u32 cmd)
+static int as_send_cmd_and_wait(struct panthor_device *ptdev, u32 slot, u32 cmd)
 {
 	int status;
 
 	/* write AS_COMMAND when MMU is ready to accept another command */
-	status = wait_ready(ptdev, as_nr);
+	status = wait_ready(ptdev, slot);
 	if (!status) {
-		gpu_write(ptdev->mmu->iomem, AS_COMMAND(as_nr), cmd);
-		status = wait_ready(ptdev, as_nr);
+		gpu_write(ptdev->mmu->iomem, AS_COMMAND(slot), cmd);
+		status = wait_ready(ptdev, slot);
 	}
 
 	return status;
@@ -596,41 +606,41 @@ static u64 pack_region_range(struct panthor_device *ptdev, u64 *region_start, u6
 	return region_width | *region_start;
 }
 
-static u32 panthor_mmu_as_fault_mask(struct panthor_device *ptdev, u32 as)
+static u32 panthor_mmu_as_fault_mask(struct panthor_device *ptdev, u32 slot)
 {
-	return BIT(as);
+	return BIT(slot);
 }
 
 /* Forward declaration to call helpers within as_enable/disable */
 static void panthor_mmu_irq_handler(struct panthor_device *ptdev, u32 status);
 PANTHOR_IRQ_HANDLER(mmu, panthor_mmu_irq_handler);
 
-static int panthor_mmu_as_enable(struct panthor_device *ptdev, u32 as_nr,
+static int panthor_mmu_as_enable(struct panthor_device *ptdev, u32 slot,
 				 u64 transtab, u64 transcfg, u64 memattr)
 {
 	struct panthor_mmu *mmu = ptdev->mmu;
 
 	panthor_mmu_irq_enable_events(&ptdev->mmu->irq,
-				      panthor_mmu_as_fault_mask(ptdev, as_nr));
+				      panthor_mmu_as_fault_mask(ptdev, slot));
 
-	gpu_write64(mmu->iomem, AS_TRANSTAB(as_nr), transtab);
-	gpu_write64(mmu->iomem, AS_MEMATTR(as_nr), memattr);
-	gpu_write64(mmu->iomem, AS_TRANSCFG(as_nr), transcfg);
+	gpu_write64(mmu->iomem, AS_TRANSTAB(slot), transtab);
+	gpu_write64(mmu->iomem, AS_MEMATTR(slot), memattr);
+	gpu_write64(mmu->iomem, AS_TRANSCFG(slot), transcfg);
 
-	return as_send_cmd_and_wait(ptdev, as_nr, AS_COMMAND_UPDATE);
+	return as_send_cmd_and_wait(ptdev, slot, AS_COMMAND_UPDATE);
 }
 
-static int panthor_mmu_as_disable(struct panthor_device *ptdev, u32 as_nr,
+static int panthor_mmu_as_disable(struct panthor_device *ptdev, u32 slot,
 				  bool recycle_slot)
 {
 	struct panthor_mmu *mmu = ptdev->mmu;
-	struct panthor_vm *vm = ptdev->mmu->as.slots[as_nr].vm;
+	struct panthor_as *as = ptdev->mmu->as.slots[slot].as;
 	int ret;
 
 	lockdep_assert_held(&ptdev->mmu->as.slots_lock);
 
 	panthor_mmu_irq_disable_events(&ptdev->mmu->irq,
-				       panthor_mmu_as_fault_mask(ptdev, as_nr));
+				       panthor_mmu_as_fault_mask(ptdev, slot));
 
 	/* Flush+invalidate RW caches, invalidate RO ones. */
 	ret = panthor_gpu_flush_caches(ptdev, CACHE_CLEAN | CACHE_INV,
@@ -638,9 +648,9 @@ static int panthor_mmu_as_disable(struct panthor_device *ptdev, u32 as_nr,
 	if (ret)
 		return ret;
 
-	if (vm && vm->locked_region.size) {
+	if (as && as->locked_region.size) {
 		/* Unlock the region if there's a lock pending. */
-		ret = as_send_cmd_and_wait(ptdev, vm->as.id, AS_COMMAND_UNLOCK);
+		ret = as_send_cmd_and_wait(ptdev, slot, AS_COMMAND_UNLOCK);
 		if (ret)
 			return ret;
 	}
@@ -651,11 +661,11 @@ static int panthor_mmu_as_disable(struct panthor_device *ptdev, u32 as_nr,
 	if (recycle_slot)
 		return 0;
 
-	gpu_write64(mmu->iomem, AS_TRANSTAB(as_nr), 0);
-	gpu_write64(mmu->iomem, AS_MEMATTR(as_nr), 0);
-	gpu_write64(mmu->iomem, AS_TRANSCFG(as_nr), AS_TRANSCFG_ADRMODE_UNMAPPED);
+	gpu_write64(mmu->iomem, AS_TRANSTAB(slot), 0);
+	gpu_write64(mmu->iomem, AS_MEMATTR(slot), 0);
+	gpu_write64(mmu->iomem, AS_TRANSCFG(slot), AS_TRANSCFG_ADRMODE_UNMAPPED);
 
-	return as_send_cmd_and_wait(ptdev, as_nr, AS_COMMAND_UPDATE);
+	return as_send_cmd_and_wait(ptdev, slot, AS_COMMAND_UPDATE);
 }
 
 static u32 panthor_mmu_fault_mask(struct panthor_device *ptdev, u32 value)
@@ -672,7 +682,7 @@ static u32 panthor_mmu_fault_mask(struct panthor_device *ptdev, u32 value)
  */
 bool panthor_vm_has_unhandled_faults(struct panthor_vm *vm)
 {
-	return vm->unhandled_fault;
+	return vm->as->unhandled_fault;
 }
 
 /**
@@ -683,23 +693,23 @@ bool panthor_vm_has_unhandled_faults(struct panthor_vm *vm)
  */
 bool panthor_vm_is_unusable(struct panthor_vm *vm)
 {
-	return vm->unusable;
+	return vm->as->unusable;
 }
 
-static void panthor_vm_release_as_locked(struct panthor_vm *vm)
+static void panthor_as_release_hw_slot_locked(struct panthor_as *as)
 {
-	struct panthor_device *ptdev = vm->ptdev;
+	struct panthor_device *ptdev = container_of(as->base.drm, struct panthor_device, base);
 
 	lockdep_assert_held(&ptdev->mmu->as.slots_lock);
 
-	if (drm_WARN_ON(&ptdev->base, vm->as.id < 0))
+	if (drm_WARN_ON(&ptdev->base, as->hw_slot.id < 0))
 		return;
 
-	ptdev->mmu->as.slots[vm->as.id].vm = NULL;
-	clear_bit(vm->as.id, &ptdev->mmu->as.alloc_mask);
-	refcount_set(&vm->as.active_cnt, 0);
-	list_del_init(&vm->as.lru_node);
-	vm->as.id = -1;
+	ptdev->mmu->as.slots[as->hw_slot.id].as = NULL;
+	clear_bit(as->hw_slot.id, &ptdev->mmu->as.alloc_mask);
+	refcount_set(&as->active_cnt, 0);
+	list_del_init(&as->hw_slot.lru_node);
+	as->hw_slot.id = -1;
 }
 
 /**
@@ -712,17 +722,18 @@ static void panthor_vm_release_as_locked(struct panthor_vm *vm)
  */
 int panthor_vm_active(struct panthor_vm *vm)
 {
-	struct panthor_device *ptdev = vm->ptdev;
+	struct panthor_as *as = vm->as;
+	struct panthor_device *ptdev = container_of(as->base.drm, struct panthor_device, base);
 	u32 va_bits = GPU_MMU_FEATURES_VA_BITS(ptdev->gpu_info.mmu_features);
-	struct io_pgtable_cfg *cfg = &io_pgtable_ops_to_pgtable(vm->pgtbl_ops)->cfg;
-	int ret = 0, as, cookie;
+	struct io_pgtable_cfg *cfg = &io_pgtable_ops_to_pgtable(as->pt.ops)->cfg;
+	int ret = 0, slot, cookie;
 	u64 transtab, transcfg;
 	u32 fault_mask;
 
 	if (!drm_dev_enter(&ptdev->base, &cookie))
 		return -ENODEV;
 
-	if (refcount_inc_not_zero(&vm->as.active_cnt))
+	if (refcount_inc_not_zero(&as->active_cnt))
 		goto out_dev_exit;
 
 	/* As soon as active is called, we place the VM at the end of the VM LRU.
@@ -731,25 +742,25 @@ int panthor_vm_active(struct panthor_vm *vm)
 	 * that's an acceptable trade-off.
 	 */
 	mutex_lock(&ptdev->base.gem_lru_mutex);
-	if (vm->reclaim.lru.count)
-		list_move_tail(&vm->reclaim.lru_node, &ptdev->reclaim.vms);
+	if (as->reclaim.lru.count)
+		list_move_tail(&as->reclaim.lru_node, &ptdev->reclaim.vms);
 	mutex_unlock(&ptdev->base.gem_lru_mutex);
 
 	/* Make sure we don't race with lock/unlock_region() calls
 	 * happening around VM bind operations.
 	 */
-	mutex_lock(&vm->op_lock);
+	mutex_lock(&as->op_lock);
 	mutex_lock(&ptdev->mmu->as.slots_lock);
 
-	if (refcount_inc_not_zero(&vm->as.active_cnt))
+	if (refcount_inc_not_zero(&as->active_cnt))
 		goto out_unlock;
 
-	as = vm->as.id;
-	if (as >= 0) {
+	slot = as->hw_slot.id;
+	if (slot >= 0) {
 		/* Unhandled pagefault on this AS, the MMU was disabled. We need to
 		 * re-enable the MMU after clearing+unmasking the AS interrupts.
 		 */
-		if (ptdev->mmu->as.faulty_mask & panthor_mmu_as_fault_mask(ptdev, as))
+		if (ptdev->mmu->as.faulty_mask & panthor_mmu_as_fault_mask(ptdev, slot))
 			goto out_enable_as;
 
 		goto out_make_active;
@@ -758,36 +769,36 @@ int panthor_vm_active(struct panthor_vm *vm)
 	/* Check for a free AS */
 	if (vm->for_mcu) {
 		drm_WARN_ON(&ptdev->base, ptdev->mmu->as.alloc_mask & BIT(0));
-		as = 0;
+		slot = 0;
 	} else {
-		as = ffz(ptdev->mmu->as.alloc_mask | BIT(0));
+		slot = ffz(ptdev->mmu->as.alloc_mask | BIT(0));
 	}
 
-	if (!(BIT(as) & ptdev->gpu_info.as_present)) {
-		struct panthor_vm *lru_vm;
+	if (!(BIT(slot) & ptdev->gpu_info.as_present)) {
+		struct panthor_as *lru_as;
 
-		lru_vm = list_first_entry_or_null(&ptdev->mmu->as.lru_list,
-						  struct panthor_vm,
-						  as.lru_node);
-		if (drm_WARN_ON(&ptdev->base, !lru_vm)) {
+		lru_as = list_first_entry_or_null(&ptdev->mmu->as.lru_list,
+						  struct panthor_as,
+						  hw_slot.lru_node);
+		if (drm_WARN_ON(&ptdev->base, !lru_as)) {
 			ret = -EBUSY;
 			goto out_unlock;
 		}
 
-		drm_WARN_ON(&ptdev->base, refcount_read(&lru_vm->as.active_cnt));
-		as = lru_vm->as.id;
+		drm_WARN_ON(&ptdev->base, refcount_read(&lru_as->active_cnt));
+		slot = lru_as->hw_slot.id;
 
-		ret = panthor_mmu_as_disable(ptdev, as, true);
+		ret = panthor_mmu_as_disable(ptdev, slot, true);
 		if (ret)
 			goto out_unlock;
 
-		panthor_vm_release_as_locked(lru_vm);
+		panthor_as_release_hw_slot_locked(lru_as);
 	}
 
 	/* Assign the free or reclaimed AS to the FD */
-	vm->as.id = as;
-	set_bit(as, &ptdev->mmu->as.alloc_mask);
-	ptdev->mmu->as.slots[as].vm = vm;
+	as->hw_slot.id = slot;
+	set_bit(slot, &ptdev->mmu->as.alloc_mask);
+	ptdev->mmu->as.slots[slot].as = as;
 
 out_enable_as:
 	transtab = cfg->arm_lpae_s1_cfg.ttbr;
@@ -799,12 +810,12 @@ int panthor_vm_active(struct panthor_vm *vm)
 		transcfg |= AS_TRANSCFG_PTW_SH_OS;
 
 	/* If the VM is re-activated, we clear the fault. */
-	vm->unhandled_fault = false;
+	as->unhandled_fault = false;
 
 	/* Unhandled pagefault on this AS, clear the fault and enable the AS,
 	 * which re-enables interrupts.
 	 */
-	fault_mask = panthor_mmu_as_fault_mask(ptdev, as);
+	fault_mask = panthor_mmu_as_fault_mask(ptdev, slot);
 	if (ptdev->mmu->as.faulty_mask & fault_mask) {
 		gpu_write(ptdev->mmu->irq.iomem, INT_CLEAR, fault_mask);
 		ptdev->mmu->as.faulty_mask &= ~fault_mask;
@@ -813,18 +824,18 @@ int panthor_vm_active(struct panthor_vm *vm)
 	/* The VM update is guarded by ::op_lock, which we take at the beginning
 	 * of this function, so we don't expect any locked region here.
 	 */
-	drm_WARN_ON(&vm->ptdev->base, vm->locked_region.size > 0);
-	ret = panthor_mmu_as_enable(vm->ptdev, vm->as.id, transtab, transcfg, vm->memattr);
+	drm_WARN_ON(&ptdev->base, as->locked_region.size > 0);
+	ret = panthor_mmu_as_enable(ptdev, as->hw_slot.id, transtab, transcfg, as->memattr);
 
 out_make_active:
 	if (!ret) {
-		refcount_set(&vm->as.active_cnt, 1);
-		list_del_init(&vm->as.lru_node);
+		refcount_set(&as->active_cnt, 1);
+		list_del_init(&as->hw_slot.lru_node);
 	}
 
 out_unlock:
 	mutex_unlock(&ptdev->mmu->as.slots_lock);
-	mutex_unlock(&vm->op_lock);
+	mutex_unlock(&as->op_lock);
 
 out_dev_exit:
 	drm_dev_exit(cookie);
@@ -846,21 +857,22 @@ int panthor_vm_active(struct panthor_vm *vm)
  */
 void panthor_vm_idle(struct panthor_vm *vm)
 {
-	struct panthor_device *ptdev = vm->ptdev;
+	struct panthor_as *as = vm->as;
+	struct panthor_device *ptdev = container_of(as->base.drm, struct panthor_device, base);
 
-	if (!refcount_dec_and_mutex_lock(&vm->as.active_cnt, &ptdev->mmu->as.slots_lock))
+	if (!refcount_dec_and_mutex_lock(&as->active_cnt, &ptdev->mmu->as.slots_lock))
 		return;
 
-	if (!drm_WARN_ON(&ptdev->base, vm->as.id == -1 || !list_empty(&vm->as.lru_node)))
-		list_add_tail(&vm->as.lru_node, &ptdev->mmu->as.lru_list);
+	if (!drm_WARN_ON(&ptdev->base, as->hw_slot.id == -1 || !list_empty(&as->hw_slot.lru_node)))
+		list_add_tail(&as->hw_slot.lru_node, &ptdev->mmu->as.lru_list);
 
-	refcount_set(&vm->as.active_cnt, 0);
+	refcount_set(&as->active_cnt, 0);
 	mutex_unlock(&ptdev->mmu->as.slots_lock);
 }
 
 u32 panthor_vm_page_size(struct panthor_vm *vm)
 {
-	const struct io_pgtable *pgt = io_pgtable_ops_to_pgtable(vm->pgtbl_ops);
+	const struct io_pgtable *pgt = io_pgtable_ops_to_pgtable(vm->as->pt.ops);
 	u32 pg_shift = ffs(pgt->cfg.pgsize_bitmap) - 1;
 
 	return 1u << pg_shift;
@@ -884,7 +896,7 @@ static void panthor_vm_start(struct panthor_vm *vm)
  */
 int panthor_vm_as(struct panthor_vm *vm)
 {
-	return vm->as.id;
+	return vm->as->hw_slot.id;
 }
 
 static size_t get_pgsize(u64 addr, size_t size, size_t *count)
@@ -908,43 +920,43 @@ static size_t get_pgsize(u64 addr, size_t size, size_t *count)
 	return SZ_2M;
 }
 
-static void panthor_vm_declare_unusable(struct panthor_vm *vm)
+static void panthor_as_declare_unusable(struct panthor_as *as)
 {
-	struct panthor_device *ptdev = vm->ptdev;
+	struct panthor_device *ptdev = container_of(as->base.drm, struct panthor_device, base);
 	int cookie;
 
-	if (vm->unusable)
+	if (as->unusable)
 		return;
 
-	vm->unusable = true;
+	as->unusable = true;
 	mutex_lock(&ptdev->mmu->as.slots_lock);
-	if (vm->as.id >= 0 && drm_dev_enter(&ptdev->base, &cookie)) {
-		panthor_mmu_as_disable(ptdev, vm->as.id, false);
+	if (as->hw_slot.id >= 0 && drm_dev_enter(&ptdev->base, &cookie)) {
+		panthor_mmu_as_disable(ptdev, as->hw_slot.id, false);
 		drm_dev_exit(cookie);
 	}
 	mutex_unlock(&ptdev->mmu->as.slots_lock);
 }
 
-static void panthor_vm_unmap_pages(struct panthor_vm *vm, u64 iova, u64 size)
+static void panthor_as_unmap_pages(struct panthor_as *as, u64 iova, u64 size)
 {
-	struct panthor_device *ptdev = vm->ptdev;
-	struct io_pgtable_ops *ops = vm->pgtbl_ops;
+	struct drm_device *ddev = as->base.drm;
+	struct io_pgtable_ops *ops = as->pt.ops;
 	u64 start_iova = iova;
 	u64 offset = 0;
 
 	if (!size)
 		return;
 
-	drm_WARN_ON(&ptdev->base,
-		    (iova < vm->locked_region.start) ||
-		    (iova + size > vm->locked_region.start + vm->locked_region.size));
+	drm_WARN_ON(ddev,
+		    (iova < as->locked_region.start) ||
+		    (iova + size > as->locked_region.start + as->locked_region.size));
 
 	while (offset < size) {
 		size_t unmapped_sz = 0, pgcount;
 		size_t pgsize = get_pgsize(iova + offset, size - offset, &pgcount);
 
 		unmapped_sz = ops->unmap_pages(ops, iova + offset, pgsize, pgcount, NULL);
-		if (drm_WARN_ON_ONCE(&ptdev->base, unmapped_sz != pgsize * pgcount)) {
+		if (drm_WARN_ON_ONCE(ddev, unmapped_sz != pgsize * pgcount)) {
 			/* Gracefully handle sparsely unmapped regions to avoid leaving
 			 * page table pages behind when the drm_gpuvm and VM page table
 			 * are out-of-sync. This is not supposed to happen, hence the
@@ -958,33 +970,32 @@ static void panthor_vm_unmap_pages(struct panthor_vm *vm, u64 iova, u64 size)
 			 * so flag the VM unusable to make sure it's not going
 			 * to be used anymore.
 			 */
-			panthor_vm_declare_unusable(vm);
+			panthor_as_declare_unusable(as);
 
 			/* If we don't make progress, we're screwed. That also means
 			 * something else prevents us from unmapping the region, but
 			 * there's not much we can do here: time for debugging.
 			 */
-			if (drm_WARN_ON_ONCE(&ptdev->base, !unmapped_sz))
+			if (drm_WARN_ON_ONCE(ddev, !unmapped_sz))
 				return;
 		}
 
-		drm_dbg(&ptdev->base,
-			"unmap: as=%d, iova=0x%llx, sz=%llu, va=0x%llx, pgcnt=%zu, pgsz=%zu",
-			vm->as.id, start_iova, size, iova + offset,
-			unmapped_sz / pgsize, pgsize);
+		drm_dbg(ddev,
+			"unmap: iova=0x%llx, sz=%llu, va=0x%llx, pgcnt=%zu, pgsz=%zu",
+			start_iova, size, iova + offset, unmapped_sz / pgsize, pgsize);
 
 		offset += unmapped_sz;
 	}
 }
 
 static int
-panthor_vm_map_pages(struct panthor_vm *vm, u64 iova, int prot,
+panthor_as_map_pages(struct panthor_as *as, u64 iova, int prot,
 		     struct sg_table *sgt, u64 offset, u64 size)
 {
-	struct panthor_device *ptdev = vm->ptdev;
+	struct drm_device *ddev = as->base.drm;
 	unsigned int count;
 	struct scatterlist *sgl;
-	struct io_pgtable_ops *ops = vm->pgtbl_ops;
+	struct io_pgtable_ops *ops = as->pt.ops;
 	u64 start_iova = iova;
 	u64 start_size = size;
 	int ret;
@@ -992,9 +1003,9 @@ panthor_vm_map_pages(struct panthor_vm *vm, u64 iova, int prot,
 	if (!size)
 		return 0;
 
-	drm_WARN_ON(&ptdev->base,
-		    (iova < vm->locked_region.start) ||
-		    (iova + size > vm->locked_region.start + vm->locked_region.size));
+	drm_WARN_ON(ddev,
+		    (iova < as->locked_region.start) ||
+		    (iova + size > as->locked_region.start + as->locked_region.size));
 
 	for_each_sgtable_dma_sg(sgt, sgl, count) {
 		dma_addr_t paddr = sg_dma_address(sgl);
@@ -1017,10 +1028,9 @@ panthor_vm_map_pages(struct panthor_vm *vm, u64 iova, int prot,
 			ret = ops->map_pages(ops, iova, paddr, pgsize, pgcount, prot,
 					     GFP_KERNEL, &mapped);
 
-			drm_dbg(&ptdev->base,
-				"map: as=%d, iova=0x%llx, sz=%llu, va=0x%llx, pa=%pad, pgcnt=%zu, pgsz=%zu",
-				vm->as.id, start_iova, start_size, iova, &paddr,
-				mapped / pgsize, pgsize);
+			drm_dbg(ddev,
+				"map: iova=0x%llx, sz=%llu, va=0x%llx, pa=%pad, pgcnt=%zu, pgsz=%zu",
+				start_iova, start_size, iova, &paddr, mapped / pgsize, pgsize);
 
 			iova += mapped;
 			paddr += mapped;
@@ -1031,12 +1041,12 @@ panthor_vm_map_pages(struct panthor_vm *vm, u64 iova, int prot,
 				ret = -ENOMEM;
 
 			/* If something fails, we stop there, and flag the VM unusable. */
-			if (drm_WARN_ON_ONCE(&ptdev->base, ret)) {
+			if (drm_WARN_ON_ONCE(ddev, ret)) {
 				/* Unmap what we've already mapped to avoid leaving page
 				 * table pages behind.
 				 */
-				panthor_vm_unmap_pages(vm, start_iova, iova - start_iova);
-				panthor_vm_declare_unusable(vm);
+				panthor_as_unmap_pages(as, start_iova, iova - start_iova);
+				panthor_as_declare_unusable(as);
 				return ret;
 			}
 		}
@@ -1051,8 +1061,8 @@ panthor_vm_map_pages(struct panthor_vm *vm, u64 iova, int prot,
 }
 
 static int
-panthor_vm_map_sparse(struct panthor_vm *vm, u64 iova, int prot,
-		      struct sg_table *sgt, u64 size)
+panthor_as_map_sparse(struct panthor_as *as, u64 iova,
+		      int prot, struct sg_table *sgt, u64 size)
 {
 	u64 mapped = 0;
 	int ret;
@@ -1061,10 +1071,10 @@ panthor_vm_map_sparse(struct panthor_vm *vm, u64 iova, int prot,
 		u64 addr = iova + mapped;
 		u32 chunk_size = min(size - mapped, SZ_2M - (addr & (SZ_2M - 1)));
 
-		ret = panthor_vm_map_pages(vm, addr, prot, sgt,
+		ret = panthor_as_map_pages(as, addr, prot, sgt,
 					   addr % SZ_2M, chunk_size);
 		if (ret) {
-			panthor_vm_unmap_pages(vm, iova, mapped);
+			panthor_as_unmap_pages(as, iova, mapped);
 			return ret;
 		}
 
@@ -1166,8 +1176,8 @@ static void panthor_vm_bo_free(struct drm_gpuvm_bo *vm_bo)
 	kfree(vm_bo);
 }
 
-static void panthor_vm_cleanup_op_ctx(struct panthor_vm_op_ctx *op_ctx,
-				      struct panthor_vm *vm)
+static void panthor_as_cleanup_op_ctx(struct panthor_as_op_ctx *op_ctx,
+				      struct panthor_as *as)
 {
 	u32 remaining_pt_count = op_ctx->rsvd_page_tables.count -
 				 op_ctx->rsvd_page_tables.ptr;
@@ -1202,11 +1212,11 @@ static void panthor_vm_cleanup_op_ctx(struct panthor_vm_op_ctx *op_ctx,
 		kfree(op_ctx->preallocated_vmas[i]);
 
 	if (!skip_deferred_cleanup)
-		drm_gpuvm_bo_deferred_cleanup(&vm->base);
+		drm_gpuvm_bo_deferred_cleanup(&as->base);
 }
 
 static void
-panthor_vm_op_ctx_return_vma(struct panthor_vm_op_ctx *op_ctx,
+panthor_as_op_ctx_return_vma(struct panthor_as_op_ctx *op_ctx,
 			     struct panthor_vma *vma)
 {
 	for (u32 i = 0; i < ARRAY_SIZE(op_ctx->preallocated_vmas); i++) {
@@ -1220,7 +1230,7 @@ panthor_vm_op_ctx_return_vma(struct panthor_vm_op_ctx *op_ctx,
 }
 
 static struct panthor_vma *
-panthor_vm_op_ctx_get_vma(struct panthor_vm_op_ctx *op_ctx)
+panthor_as_op_ctx_get_vma(struct panthor_as_op_ctx *op_ctx)
 {
 	for (u32 i = 0; i < ARRAY_SIZE(op_ctx->preallocated_vmas); i++) {
 		struct panthor_vma *vma = op_ctx->preallocated_vmas[i];
@@ -1235,7 +1245,7 @@ panthor_vm_op_ctx_get_vma(struct panthor_vm_op_ctx *op_ctx)
 }
 
 static int
-panthor_vm_op_ctx_prealloc_vmas(struct panthor_vm_op_ctx *op_ctx)
+panthor_as_op_ctx_prealloc_vmas(struct panthor_as_op_ctx *op_ctx)
 {
 	u32 vma_count;
 
@@ -1274,7 +1284,7 @@ panthor_vm_op_ctx_prealloc_vmas(struct panthor_vm_op_ctx *op_ctx)
 	return 0;
 }
 
-static void panthor_vm_init_op_ctx(struct panthor_vm_op_ctx *op_ctx,
+static void panthor_vm_init_op_ctx(struct panthor_as_op_ctx *op_ctx,
 				   u64 size, u64 va, u32 flags)
 {
 	memset(op_ctx, 0, sizeof(*op_ctx));
@@ -1283,7 +1293,7 @@ static void panthor_vm_init_op_ctx(struct panthor_vm_op_ctx *op_ctx,
 	op_ctx->va.addr = va;
 }
 
-static int panthor_vm_op_ctx_prealloc_pts(struct panthor_vm_op_ctx *op_ctx)
+static int panthor_as_op_ctx_prealloc_pts(struct panthor_as_op_ctx *op_ctx)
 {
 	u64 size = op_ctx->va.range;
 	u64 va = op_ctx->va.addr;
@@ -1319,8 +1329,8 @@ static int panthor_vm_op_ctx_prealloc_pts(struct panthor_vm_op_ctx *op_ctx)
 	 DRM_PANTHOR_VM_BIND_OP_MAP_SPARSE | \
 	 DRM_PANTHOR_VM_BIND_OP_TYPE_MASK)
 
-static int panthor_vm_prepare_map_op_ctx(struct panthor_vm_op_ctx *op_ctx,
-					 struct panthor_vm *vm,
+static int panthor_as_prepare_map_op_ctx(struct panthor_as_op_ctx *op_ctx,
+					 struct panthor_as *as,
 					 struct panthor_gem_object *bo,
 					 const struct drm_panthor_vm_bind_op *op)
 {
@@ -1355,12 +1365,12 @@ static int panthor_vm_prepare_map_op_ctx(struct panthor_vm_op_ctx *op_ctx,
 
 	/* If the BO has an exclusive VM attached, it can't be mapped to other VMs. */
 	if (bo->exclusive_vm_root_gem &&
-	    bo->exclusive_vm_root_gem != panthor_vm_root_gem(vm))
+	    bo->exclusive_vm_root_gem != as->base.r_obj)
 		return -EINVAL;
 
 	panthor_vm_init_op_ctx(op_ctx, op->size, op->va, op->flags);
 
-	ret = panthor_vm_op_ctx_prealloc_vmas(op_ctx);
+	ret = panthor_as_op_ctx_prealloc_vmas(op_ctx);
 	if (ret)
 		goto err_cleanup;
 
@@ -1380,7 +1390,7 @@ static int panthor_vm_prepare_map_op_ctx(struct panthor_vm_op_ctx *op_ctx,
 		goto err_cleanup;
 	}
 
-	preallocated_vm_bo = drm_gpuvm_bo_create(&vm->base, &bo->base);
+	preallocated_vm_bo = drm_gpuvm_bo_create(&as->base, &bo->base);
 	if (!preallocated_vm_bo) {
 		ret = -ENOMEM;
 		goto err_cleanup;
@@ -1389,15 +1399,15 @@ static int panthor_vm_prepare_map_op_ctx(struct panthor_vm_op_ctx *op_ctx,
 	op_ctx->map.vm_bo = drm_gpuvm_bo_obtain_prealloc(preallocated_vm_bo);
 	op_ctx->map.bo_offset = op->bo_offset;
 
-	ret = panthor_vm_op_ctx_prealloc_pts(op_ctx);
+	ret = panthor_as_op_ctx_prealloc_pts(op_ctx);
 	if (ret)
 		goto err_cleanup;
 
 	/* Insert BO into the extobj list last, when we know nothing can fail. */
-	if (bo->base.resv != panthor_vm_resv(vm)) {
-		dma_resv_lock(panthor_vm_resv(vm), NULL);
+	if (bo->base.resv != drm_gpuvm_resv(&as->base)) {
+		dma_resv_lock(drm_gpuvm_resv(&as->base), NULL);
 		drm_gpuvm_bo_extobj_add(op_ctx->map.vm_bo);
-		dma_resv_unlock(panthor_vm_resv(vm));
+		dma_resv_unlock(drm_gpuvm_resv(&as->base));
 	}
 
 	/* And finally update the BO state. */
@@ -1410,12 +1420,12 @@ static int panthor_vm_prepare_map_op_ctx(struct panthor_vm_op_ctx *op_ctx,
 	return 0;
 
 err_cleanup:
-	panthor_vm_cleanup_op_ctx(op_ctx, vm);
+	panthor_as_cleanup_op_ctx(op_ctx, as);
 	return ret;
 }
 
-static int panthor_vm_prepare_unmap_op_ctx(struct panthor_vm_op_ctx *op_ctx,
-					   struct panthor_vm *vm,
+static int panthor_as_prepare_unmap_op_ctx(struct panthor_as_op_ctx *op_ctx,
+					   struct panthor_as *as,
 					   u64 va, u64 size)
 {
 	u32 pt_count = 0;
@@ -1436,7 +1446,7 @@ static int panthor_vm_prepare_unmap_op_ctx(struct panthor_vm_op_ctx *op_ctx,
 	    ALIGN(va + size, SZ_2M) != ALIGN(va, SZ_2M))
 		pt_count++;
 
-	ret = panthor_vm_op_ctx_prealloc_vmas(op_ctx);
+	ret = panthor_as_op_ctx_prealloc_vmas(op_ctx);
 	if (ret)
 		goto err_cleanup;
 
@@ -1459,12 +1469,12 @@ static int panthor_vm_prepare_unmap_op_ctx(struct panthor_vm_op_ctx *op_ctx,
 	return 0;
 
 err_cleanup:
-	panthor_vm_cleanup_op_ctx(op_ctx, vm);
+	panthor_as_cleanup_op_ctx(op_ctx, as);
 	return ret;
 }
 
 static void
-panthor_vm_prepare_sync_only_op_ctx(struct panthor_vm_op_ctx *op_ctx)
+panthor_as_prepare_sync_only_op_ctx(struct panthor_as_op_ctx *op_ctx)
 {
 	memset(op_ctx, 0, sizeof(*op_ctx));
 	op_ctx->flags = DRM_PANTHOR_VM_BIND_OP_TYPE_SYNC_ONLY;
@@ -1492,8 +1502,8 @@ panthor_vm_get_bo_for_va(struct panthor_vm *vm, u64 va, u64 *bo_offset)
 	struct panthor_vma *vma;
 
 	/* Take the VM lock to prevent concurrent map/unmap operations. */
-	mutex_lock(&vm->op_lock);
-	gpuva = drm_gpuva_find_first(&vm->base, va, 1);
+	mutex_lock(&vm->as->op_lock);
+	gpuva = drm_gpuva_find_first(&vm->as->base, va, 1);
 	vma = gpuva ? container_of(gpuva, struct panthor_vma, base) : NULL;
 	if (vma && vma->base.gem.obj) {
 		drm_gem_object_get(vma->base.gem.obj);
@@ -1502,7 +1512,7 @@ panthor_vm_get_bo_for_va(struct panthor_vm *vm, u64 va, u64 *bo_offset)
 			vma->base.gem.offset + (va - vma->base.va.addr) :
 			va & (SZ_2M - 1);
 	}
-	mutex_unlock(&vm->op_lock);
+	mutex_unlock(&vm->as->op_lock);
 
 	return bo;
 }
@@ -1622,22 +1632,24 @@ int panthor_vm_pool_create_vm(struct panthor_device *ptdev,
 
 static void panthor_vm_destroy(struct panthor_vm *vm)
 {
+	struct panthor_as *as;
+	struct panthor_device *ptdev;
+
 	if (!vm)
 		return;
 
+	as = vm->as;
+	ptdev = container_of(as->base.drm, struct panthor_device, base);
 	vm->destroyed = true;
 
 	/* Tell scheduler to stop all GPU work related to this VM */
-	if (refcount_read(&vm->as.active_cnt) > 0)
-		panthor_sched_prepare_for_vm_destruction(vm->ptdev);
+	if (refcount_read(&as->active_cnt) > 0)
+		panthor_sched_prepare_for_vm_destruction(ptdev);
 
 	mutex_lock(&vm->heaps.lock);
 	panthor_heap_pool_destroy(vm->heaps.pool);
 	vm->heaps.pool = NULL;
 	mutex_unlock(&vm->heaps.lock);
-
-	drm_WARN_ON(&vm->ptdev->base,
-		    panthor_vm_unmap_range(vm, vm->base.mm_start, vm->base.mm_range));
 	panthor_vm_put(vm);
 }
 
@@ -1777,17 +1789,18 @@ static const char *access_type_name(struct panthor_device *ptdev,
 	}
 }
 
-static int panthor_vm_lock_region(struct panthor_vm *vm, u64 start, u64 size)
+static int panthor_as_lock_region(struct panthor_as *as, u64 start, u64 size)
 {
-	struct panthor_device *ptdev = vm->ptdev;
+	struct drm_device *ddev = as->base.drm;
+	struct panthor_device *ptdev = container_of(ddev, struct panthor_device, base);
 	int ret = 0;
 
-	/* sm_step_remap() can call panthor_vm_lock_region() to account for
+	/* sm_step_remap() can call panthor_as_lock_region() to account for
 	 * the wider unmap needed when doing a partial huge page unamp. We
 	 * need to ignore the lock if it's already part of the locked region.
 	 */
-	if (start >= vm->locked_region.start &&
-	    start + size <= vm->locked_region.start + vm->locked_region.size)
+	if (start >= as->locked_region.start &&
+	    start + size <= as->locked_region.start + as->locked_region.size)
 		return 0;
 
 	/* sm_step_remap() may need a locked region that isn't a strict superset
@@ -1798,42 +1811,42 @@ static int panthor_vm_lock_region(struct panthor_vm *vm, u64 start, u64 size)
 	 * boundaries in a remap operation can only shift up or down respectively,
 	 * but never otherwise.
 	 */
-	if (vm->locked_region.size) {
-		u64 end = max(vm->locked_region.start + vm->locked_region.size,
+	if (as->locked_region.size) {
+		u64 end = max(as->locked_region.start + as->locked_region.size,
 			      start + size);
 
-		drm_WARN_ON_ONCE(&vm->ptdev->base, (start + size <= vm->locked_region.start) ||
-				 (start >= vm->locked_region.start + vm->locked_region.size));
+		drm_WARN_ON_ONCE(ddev, (start + size <= as->locked_region.start) ||
+				 (start >= as->locked_region.start + as->locked_region.size));
 
-		start = min(start, vm->locked_region.start);
+		start = min(start, as->locked_region.start);
 		size = end - start;
 	}
 
 	mutex_lock(&ptdev->mmu->as.slots_lock);
-	if (vm->as.id >= 0 && size) {
+	if (as->hw_slot.id >= 0 && size) {
 		/* Lock the region that needs to be updated */
-		gpu_write64(ptdev->mmu->iomem, AS_LOCKADDR(vm->as.id),
+		gpu_write64(ptdev->mmu->iomem, AS_LOCKADDR(as->hw_slot.id),
 			    pack_region_range(ptdev, &start, &size));
 
 		/* If the lock succeeded, update the locked_region info. */
-		ret = as_send_cmd_and_wait(ptdev, vm->as.id, AS_COMMAND_LOCK);
+		ret = as_send_cmd_and_wait(ptdev, as->hw_slot.id, AS_COMMAND_LOCK);
 	}
 
 	if (!ret) {
-		vm->locked_region.start = start;
-		vm->locked_region.size = size;
+		as->locked_region.start = start;
+		as->locked_region.size = size;
 	}
 	mutex_unlock(&ptdev->mmu->as.slots_lock);
 
 	return ret;
 }
 
-static void panthor_vm_unlock_region(struct panthor_vm *vm)
+static void panthor_as_unlock_region(struct panthor_as *as)
 {
-	struct panthor_device *ptdev = vm->ptdev;
+	struct panthor_device *ptdev = container_of(as->base.drm, struct panthor_device, base);
 
 	mutex_lock(&ptdev->mmu->as.slots_lock);
-	if (vm->as.id >= 0) {
+	if (as->hw_slot.id >= 0) {
 		int ret;
 
 		/* flush+invalidate RW caches and invalidate RO ones.
@@ -1846,7 +1859,7 @@ static void panthor_vm_unlock_region(struct panthor_vm *vm)
 
 		/* Unlock the region if the flush is effective. */
 		if (!ret)
-			ret = as_send_cmd_and_wait(ptdev, vm->as.id, AS_COMMAND_UNLOCK);
+			ret = as_send_cmd_and_wait(ptdev, as->hw_slot.id, AS_COMMAND_UNLOCK);
 
 		/* If we fail to flush or unlock the region, schedule a GPU reset
 		 * to unblock the situation.
@@ -1854,8 +1867,8 @@ static void panthor_vm_unlock_region(struct panthor_vm *vm)
 		if (ret)
 			panthor_device_schedule_reset(ptdev);
 	}
-	vm->locked_region.start = 0;
-	vm->locked_region.size = 0;
+	as->locked_region.start = 0;
+	as->locked_region.size = 0;
 	mutex_unlock(&ptdev->mmu->as.slots_lock);
 }
 
@@ -1908,8 +1921,8 @@ static void panthor_mmu_irq_handler(struct panthor_device *ptdev, u32 status)
 		 */
 		gpu_write(mmu->irq.iomem, INT_CLEAR, mask);
 
-		if (ptdev->mmu->as.slots[as].vm)
-			ptdev->mmu->as.slots[as].vm->unhandled_fault = true;
+		if (ptdev->mmu->as.slots[as].as)
+			ptdev->mmu->as.slots[as].as->unhandled_fault = true;
 
 		/* Disable the MMU to kill jobs on this AS. */
 		panthor_mmu_as_disable(ptdev, as, false);
@@ -1937,12 +1950,12 @@ void panthor_mmu_suspend(struct panthor_device *ptdev)
 {
 	mutex_lock(&ptdev->mmu->as.slots_lock);
 	for (u32 i = 0; i < ARRAY_SIZE(ptdev->mmu->as.slots); i++) {
-		struct panthor_vm *vm = ptdev->mmu->as.slots[i].vm;
+		struct panthor_as *as = ptdev->mmu->as.slots[i].as;
 
-		if (vm) {
+		if (as) {
 			drm_WARN_ON(&ptdev->base,
 				    panthor_mmu_as_disable(ptdev, i, false));
-			panthor_vm_release_as_locked(vm);
+			panthor_as_release_hw_slot_locked(as);
 		}
 	}
 	mutex_unlock(&ptdev->mmu->as.slots_lock);
@@ -2012,10 +2025,10 @@ void panthor_mmu_post_reset(struct panthor_device *ptdev)
 	ptdev->mmu->as.faulty_mask = 0;
 
 	for (u32 i = 0; i < ARRAY_SIZE(ptdev->mmu->as.slots); i++) {
-		struct panthor_vm *vm = ptdev->mmu->as.slots[i].vm;
+		struct panthor_as *as = ptdev->mmu->as.slots[i].as;
 
-		if (vm)
-			panthor_vm_release_as_locked(vm);
+		if (as)
+			panthor_as_release_hw_slot_locked(as);
 	}
 
 	mutex_unlock(&ptdev->mmu->as.slots_lock);
@@ -2031,15 +2044,23 @@ void panthor_mmu_post_reset(struct panthor_device *ptdev)
 	mutex_unlock(&ptdev->mmu->vm.lock);
 }
 
-static void panthor_vm_free(struct drm_gpuvm *gpuvm)
+static void panthor_vm_release(struct kref *kref)
 {
-	struct panthor_vm *vm = container_of(gpuvm, struct panthor_vm, base);
-	struct panthor_device *ptdev = vm->ptdev;
+	struct panthor_vm *vm = container_of(kref, struct panthor_vm, refcount);
+	struct panthor_as *as = vm->as;
+	struct panthor_device *ptdev = container_of(as->base.drm, struct panthor_device, base);
 
+	/* Make sure the page table behind this VM doesn't participate in reclaim
+	 * after that point, since we're about to release everything anyway.
+	 */
 	mutex_lock(&ptdev->base.gem_lru_mutex);
-	list_del_init(&vm->reclaim.lru_node);
+	list_del_init(&as->reclaim.lru_node);
 	mutex_unlock(&ptdev->base.gem_lru_mutex);
 
+	/* Unmap everything in case some BOs were still mapped. */
+	drm_WARN_ON(&ptdev->base,
+		    panthor_vm_unmap_range(vm, as->base.mm_start, as->base.mm_range));
+
 	mutex_lock(&vm->heaps.lock);
 	if (drm_WARN_ON(&ptdev->base, vm->heaps.pool))
 		panthor_heap_pool_destroy(vm->heaps.pool);
@@ -2060,29 +2081,26 @@ static void panthor_vm_free(struct drm_gpuvm *gpuvm)
 	drm_sched_entity_destroy(&vm->entity);
 	drm_sched_fini(&vm->sched);
 
-	mutex_lock(&vm->op_lock);
+	mutex_lock(&vm->as->op_lock);
 	mutex_lock(&ptdev->mmu->as.slots_lock);
-	if (vm->as.id >= 0) {
+	if (as->hw_slot.id >= 0) {
 		int cookie;
 
 		if (drm_dev_enter(&ptdev->base, &cookie)) {
-			panthor_mmu_as_disable(ptdev, vm->as.id, false);
+			panthor_mmu_as_disable(ptdev, as->hw_slot.id, false);
 			drm_dev_exit(cookie);
 		}
 
-		ptdev->mmu->as.slots[vm->as.id].vm = NULL;
-		clear_bit(vm->as.id, &ptdev->mmu->as.alloc_mask);
-		list_del(&vm->as.lru_node);
+		panthor_as_release_hw_slot_locked(as);
 	}
 	mutex_unlock(&ptdev->mmu->as.slots_lock);
-	mutex_unlock(&vm->op_lock);
-
-	free_io_pgtable_ops(vm->pgtbl_ops);
+	mutex_unlock(&vm->as->op_lock);
 
 	if (vm->dummy)
 		drm_gem_object_put(&vm->dummy->base);
 
 	drm_mm_takedown(&vm->mm);
+	drm_gpuvm_put(&as->base);
 	kfree(vm);
 }
 
@@ -2092,7 +2110,8 @@ static void panthor_vm_free(struct drm_gpuvm *gpuvm)
  */
 void panthor_vm_put(struct panthor_vm *vm)
 {
-	drm_gpuvm_put(vm ? &vm->base : NULL);
+	if (vm)
+		kref_put(&vm->refcount, panthor_vm_release);
 }
 
 /**
@@ -2104,7 +2123,7 @@ void panthor_vm_put(struct panthor_vm *vm)
 struct panthor_vm *panthor_vm_get(struct panthor_vm *vm)
 {
 	if (vm)
-		drm_gpuvm_get(&vm->base);
+		kref_get(&vm->refcount);
 
 	return vm;
 }
@@ -2125,6 +2144,8 @@ struct panthor_vm *panthor_vm_get(struct panthor_vm *vm)
  */
 struct panthor_heap_pool *panthor_vm_get_heap_pool(struct panthor_vm *vm, bool create)
 {
+	struct panthor_device *ptdev = container_of(vm->as->base.drm,
+						    struct panthor_device, base);
 	struct panthor_heap_pool *pool;
 
 	mutex_lock(&vm->heaps.lock);
@@ -2132,7 +2153,7 @@ struct panthor_heap_pool *panthor_vm_get_heap_pool(struct panthor_vm *vm, bool c
 		if (vm->destroyed)
 			pool = ERR_PTR(-EINVAL);
 		else
-			pool = panthor_heap_pool_create(vm->ptdev, vm);
+			pool = panthor_heap_pool_create(ptdev, vm);
 
 		if (!IS_ERR(pool))
 			vm->heaps.pool = panthor_heap_pool_get(pool);
@@ -2167,7 +2188,7 @@ void panthor_vm_heaps_sizes(struct panthor_file *pfile, struct drm_memory_stats
 	xa_for_each(&pfile->vms->xa, i, vm) {
 		size_t size = panthor_heap_pool_size(vm->heaps.pool);
 		stats->resident += size;
-		if (vm->as.id >= 0)
+		if (vm->as->hw_slot.id >= 0)
 			stats->active += size;
 	}
 	xa_unlock(&pfile->vms->xa);
@@ -2215,8 +2236,7 @@ static u64 mair_to_memattr(u64 mair, bool coherent)
 	return memattr;
 }
 
-static void panthor_vma_link(struct panthor_vm *vm,
-			     struct panthor_vma *vma,
+static void panthor_vma_link(struct panthor_vma *vma,
 			     struct drm_gpuvm_bo *vm_bo)
 {
 	struct panthor_gem_object *bo = to_panthor_bo(vma->base.gem.obj);
@@ -2252,25 +2272,25 @@ panthor_fix_sparse_map_offset(struct drm_gpuva_op_map *op, u32 flags)
 }
 
 static int
-panthor_vm_exec_map_op(struct panthor_vm *vm, u32 flags,
+panthor_as_exec_map_op(struct panthor_as *as, u32 flags,
 		       const struct drm_gpuva_op_map *op)
 {
 	struct panthor_gem_object *bo = to_panthor_bo(op->gem.obj);
 	int prot = flags_to_prot(flags);
 
 	if (flags & DRM_PANTHOR_VM_BIND_OP_MAP_SPARSE)
-		return panthor_vm_map_sparse(vm, op->va.addr, prot,
+		return panthor_as_map_sparse(as, op->va.addr, prot,
 					     bo->dmap.sgt, op->va.range);
 
-	return panthor_vm_map_pages(vm, op->va.addr, prot, bo->dmap.sgt,
+	return panthor_as_map_pages(as, op->va.addr, prot, bo->dmap.sgt,
 				    op->gem.offset, op->va.range);
 }
 
 static int panthor_gpuva_sm_step_map(struct drm_gpuva_op *op, void *priv)
 {
-	struct panthor_vm *vm = priv;
-	struct panthor_vm_op_ctx *op_ctx = vm->op_ctx;
-	struct panthor_vma *vma = panthor_vm_op_ctx_get_vma(op_ctx);
+	struct panthor_as *as = priv;
+	struct panthor_as_op_ctx *op_ctx = as->op_ctx;
+	struct panthor_vma *vma = panthor_as_op_ctx_get_vma(op_ctx);
 	int ret;
 
 	if (!vma)
@@ -2279,14 +2299,14 @@ static int panthor_gpuva_sm_step_map(struct drm_gpuva_op *op, void *priv)
 	panthor_vma_init(vma, op_ctx->flags & PANTHOR_VM_MAP_FLAGS);
 	panthor_fix_sparse_map_offset(&op->map, vma->flags);
 
-	ret = panthor_vm_exec_map_op(vm, vma->flags, &op->map);
+	ret = panthor_as_exec_map_op(as, vma->flags, &op->map);
 	if (ret) {
-		panthor_vm_op_ctx_return_vma(op_ctx, vma);
+		panthor_as_op_ctx_return_vma(op_ctx, vma);
 		return ret;
 	}
 
-	drm_gpuva_map(&vm->base, &vma->base, &op->map);
-	panthor_vma_link(vm, vma, op_ctx->map.vm_bo);
+	drm_gpuva_map(&as->base, &vma->base, &op->map);
+	panthor_vma_link(vma, op_ctx->map.vm_bo);
 
 	drm_gpuvm_bo_put_deferred(op_ctx->map.vm_bo);
 	op_ctx->map.vm_bo = NULL;
@@ -2347,8 +2367,8 @@ static int panthor_gpuva_sm_step_remap(struct drm_gpuva_op *op,
 				       void *priv)
 {
 	struct panthor_vma *unmap_vma = container_of(op->remap.unmap->va, struct panthor_vma, base);
-	struct panthor_vm *vm = priv;
-	struct panthor_vm_op_ctx *op_ctx = vm->op_ctx;
+	struct panthor_as *as = priv;
+	struct panthor_as_op_ctx *op_ctx = as->op_ctx;
 	struct panthor_vma *prev_vma = NULL, *next_vma = NULL;
 	u64 unmap_start, unmap_range;
 	int ret;
@@ -2374,8 +2394,8 @@ static int panthor_gpuva_sm_step_remap(struct drm_gpuva_op *op,
 		 * atomicity. panthor_vm_lock_region() bails out early if the new region
 		 * is already part of the locked region, so no need to do this check here.
 		 */
-		panthor_vm_lock_region(vm, unmap_start, unmap_range);
-		panthor_vm_unmap_pages(vm, unmap_start, unmap_range);
+		panthor_as_lock_region(as, unmap_start, unmap_range);
+		panthor_as_unmap_pages(as, unmap_start, unmap_range);
 	}
 
 	if (op->remap.prev) {
@@ -2391,12 +2411,12 @@ static int panthor_gpuva_sm_step_remap(struct drm_gpuva_op *op,
 			};
 			panthor_fix_sparse_map_offset(&map_op, unmap_vma->flags);
 
-			ret = panthor_vm_exec_map_op(vm, unmap_vma->flags, &map_op);
+			ret = panthor_as_exec_map_op(as, unmap_vma->flags, &map_op);
 			if (ret)
 				return ret;
 		}
 
-		prev_vma = panthor_vm_op_ctx_get_vma(op_ctx);
+		prev_vma = panthor_as_op_ctx_get_vma(op_ctx);
 		panthor_vma_init(prev_vma, unmap_vma->flags);
 		prev_vma->evicted = unmap_vma->evicted;
 	}
@@ -2414,12 +2434,12 @@ static int panthor_gpuva_sm_step_remap(struct drm_gpuva_op *op,
 			};
 			panthor_fix_sparse_map_offset(&map_op, unmap_vma->flags);
 
-			ret = panthor_vm_exec_map_op(vm, unmap_vma->flags, &map_op);
+			ret = panthor_as_exec_map_op(as, unmap_vma->flags, &map_op);
 			if (ret)
 				return ret;
 		}
 
-		next_vma = panthor_vm_op_ctx_get_vma(op_ctx);
+		next_vma = panthor_as_op_ctx_get_vma(op_ctx);
 		panthor_vma_init(next_vma, unmap_vma->flags);
 		next_vma->evicted = unmap_vma->evicted;
 	}
@@ -2434,11 +2454,11 @@ static int panthor_gpuva_sm_step_remap(struct drm_gpuva_op *op,
 		 * owned by the old mapping which will be released when this
 		 * mapping is destroyed, we need to grab a ref here.
 		 */
-		panthor_vma_link(vm, prev_vma, op->remap.unmap->va->vm_bo);
+		panthor_vma_link(prev_vma, op->remap.unmap->va->vm_bo);
 	}
 
 	if (next_vma) {
-		panthor_vma_link(vm, next_vma, op->remap.unmap->va->vm_bo);
+		panthor_vma_link(next_vma, op->remap.unmap->va->vm_bo);
 	}
 
 	panthor_vma_unlink(unmap_vma);
@@ -2449,10 +2469,10 @@ static int panthor_gpuva_sm_step_unmap(struct drm_gpuva_op *op,
 				       void *priv)
 {
 	struct panthor_vma *unmap_vma = container_of(op->unmap.va, struct panthor_vma, base);
-	struct panthor_vm *vm = priv;
+	struct panthor_as *as = priv;
 
 	if (!unmap_vma->evicted) {
-		panthor_vm_unmap_pages(vm, unmap_vma->base.va.addr,
+		panthor_as_unmap_pages(as, unmap_vma->base.va.addr,
 				       unmap_vma->base.va.range);
 	}
 
@@ -2464,7 +2484,7 @@ static int panthor_gpuva_sm_step_unmap(struct drm_gpuva_op *op,
 void panthor_vm_update_bo_reclaim_lru_locked(struct panthor_gem_object *bo)
 {
 	struct panthor_device *ptdev = container_of(bo->base.dev, struct panthor_device, base);
-	struct panthor_vm *vm = NULL;
+	struct panthor_as *as = NULL;
 	struct drm_gpuvm_bo *vm_bo;
 
 	dma_resv_assert_held(bo->base.resv);
@@ -2477,13 +2497,13 @@ void panthor_vm_update_bo_reclaim_lru_locked(struct panthor_gem_object *bo)
 		/* We're only supposed to have one non-evicted vm_bo in the list if we get
 		 * there.
 		 */
-		drm_WARN_ON(&ptdev->base, vm);
-		vm = container_of(vm_bo->vm, struct panthor_vm, base);
+		drm_WARN_ON(&ptdev->base, as);
+		as = container_of(vm_bo->vm, struct panthor_as, base);
 
 		mutex_lock(&ptdev->base.gem_lru_mutex);
-		drm_gem_lru_move_tail_locked(&vm->reclaim.lru, &bo->base);
-		if (list_empty(&vm->reclaim.lru_node))
-			list_move(&vm->reclaim.lru_node, &ptdev->reclaim.vms);
+		drm_gem_lru_move_tail_locked(&as->reclaim.lru, &bo->base);
+		if (list_empty(&as->reclaim.lru_node))
+			list_move(&as->reclaim.lru_node, &ptdev->reclaim.vms);
 		mutex_unlock(&ptdev->base.gem_lru_mutex);
 	}
 }
@@ -2494,10 +2514,11 @@ int panthor_vm_evict_bo_mappings_locked(struct panthor_gem_object *bo)
 	int ret = 0;
 
 	drm_gem_for_each_gpuvm_bo(vm_bo, &bo->base) {
-		struct panthor_vm *vm = container_of(vm_bo->vm, struct panthor_vm, base);
+		struct panthor_as *as = container_of(vm_bo->vm,
+								struct panthor_as, base);
 		struct drm_gpuva *va;
 
-		if (!mutex_trylock(&vm->op_lock))
+		if (!mutex_trylock(&as->op_lock))
 			return -EDEADLK;
 
 		/* It can be that the vm_bo was already evicted but a new
@@ -2526,16 +2547,16 @@ int panthor_vm_evict_bo_mappings_locked(struct panthor_gem_object *bo)
 			 * will be validated, causing all its evicted VMAs to be repopulated
 			 * before the job runs. So no GPU fault expected.
 			 */
-			ret = panthor_vm_lock_region(vm, va->va.addr, va->va.range);
+			ret = panthor_as_lock_region(as, va->va.addr, va->va.range);
 			if (ret)
 				break;
 
-			panthor_vm_unmap_pages(vm, va->va.addr, va->va.range);
-			panthor_vm_unlock_region(vm);
+			panthor_as_unmap_pages(as, va->va.addr, va->va.range);
+			panthor_as_unlock_region(as);
 			vma->evicted = true;
 		}
 
-		mutex_unlock(&vm->op_lock);
+		mutex_unlock(&as->op_lock);
 
 		if (ret)
 			break;
@@ -2545,14 +2566,14 @@ int panthor_vm_evict_bo_mappings_locked(struct panthor_gem_object *bo)
 }
 
 static struct panthor_vma *select_evicted_vma(struct drm_gpuvm_bo *vm_bo,
-					      struct panthor_vm_op_ctx *op_ctx)
+					      struct panthor_as_op_ctx *op_ctx)
 {
-	struct panthor_vm *vm = container_of(vm_bo->vm, struct panthor_vm, base);
+	struct panthor_as *as = container_of(vm_bo->vm, struct panthor_as, base);
 	struct panthor_vma *first_evicted_vma = NULL;
 	struct drm_gpuva *va;
 
 	/* Take op_lock to protect against va insertion/removal. */
-	mutex_lock(&vm->op_lock);
+	mutex_lock(&as->op_lock);
 	drm_gpuvm_bo_for_each_va(va, vm_bo) {
 		struct panthor_vma *vma = container_of(va, struct panthor_vma, base);
 
@@ -2563,22 +2584,22 @@ static struct panthor_vma *select_evicted_vma(struct drm_gpuvm_bo *vm_bo,
 			break;
 		}
 	}
-	mutex_unlock(&vm->op_lock);
+	mutex_unlock(&as->op_lock);
 
 	return first_evicted_vma;
 }
 
 static int remap_evicted_vma(struct drm_gpuvm_bo *vm_bo,
 			     struct panthor_vma *evicted_vma,
-			     struct panthor_vm_op_ctx *op_ctx)
+			     struct panthor_as_op_ctx *op_ctx)
 {
-	struct panthor_vm *vm = container_of(vm_bo->vm, struct panthor_vm, base);
+	struct panthor_as *as = container_of(vm_bo->vm, struct panthor_as, base);
 	struct panthor_gem_object *bo = to_panthor_bo(vm_bo->obj);
 	struct drm_gpuva *va;
 	bool found = false;
 	int ret;
 
-	ret = panthor_vm_op_ctx_prealloc_pts(op_ctx);
+	ret = panthor_as_op_ctx_prealloc_pts(op_ctx);
 	if (ret)
 		goto out_cleanup;
 
@@ -2587,7 +2608,7 @@ static int remap_evicted_vma(struct drm_gpuvm_bo *vm_bo,
 	 * to release it so we can allocate PTs, because this very same lock
 	 * is taken in a DMA-signalling path.
 	 */
-	mutex_lock(&vm->op_lock);
+	mutex_lock(&as->op_lock);
 	drm_gpuvm_bo_for_each_va(va, vm_bo) {
 		struct panthor_vma *vma = container_of(va, struct panthor_vma, base);
 
@@ -2607,8 +2628,8 @@ static int remap_evicted_vma(struct drm_gpuvm_bo *vm_bo,
 	}
 
 	if (found) {
-		vm->op_ctx = op_ctx;
-		ret = panthor_vm_lock_region(vm, evicted_vma->base.va.addr,
+		as->op_ctx = op_ctx;
+		ret = panthor_as_lock_region(as, evicted_vma->base.va.addr,
 					     evicted_vma->base.va.range);
 		if (!ret) {
 			struct drm_gpuva_op_map map_op = {
@@ -2617,34 +2638,37 @@ static int remap_evicted_vma(struct drm_gpuvm_bo *vm_bo,
 				.gem.obj = &bo->base,
 				.gem.offset = evicted_vma->base.gem.offset,
 			};
-			if (evicted_vma->flags & DRM_PANTHOR_VM_BIND_OP_MAP_SPARSE)
-				drm_WARN_ON_ONCE(&vm->ptdev->base, map_op.gem.offset !=
-						 (map_op.va.addr & (SZ_2M - 1)));
+			if (evicted_vma->flags & DRM_PANTHOR_VM_BIND_OP_MAP_SPARSE) {
+				u64 expected_offset = map_op.va.addr & (SZ_2M - 1);
 
-			ret = panthor_vm_exec_map_op(vm, evicted_vma->flags, &map_op);
+				drm_WARN_ON_ONCE(as->base.drm,
+						 map_op.gem.offset != expected_offset);
+			}
+
+			ret = panthor_as_exec_map_op(as, evicted_vma->flags, &map_op);
 			if (!ret)
 				evicted_vma->evicted = false;
 
-			panthor_vm_unlock_region(vm);
+			panthor_as_unlock_region(as);
 		}
 
-		vm->op_ctx = NULL;
+		as->op_ctx = NULL;
 	}
 
-	mutex_unlock(&vm->op_lock);
+	mutex_unlock(&as->op_lock);
 
 out_cleanup:
-	panthor_vm_cleanup_op_ctx(op_ctx, vm);
+	panthor_as_cleanup_op_ctx(op_ctx, as);
 	return ret;
 }
 
 static int panthor_vm_restore_vmas(struct drm_gpuvm_bo *vm_bo)
 {
-	struct panthor_vm *vm = container_of(vm_bo->vm, struct panthor_vm, base);
+	struct panthor_as *as = container_of(vm_bo->vm, struct panthor_as, base);
 	struct panthor_gem_object *bo = to_panthor_bo(vm_bo->obj);
-	struct panthor_vm_op_ctx op_ctx;
+	struct panthor_as_op_ctx op_ctx;
 
-	if (drm_WARN_ON_ONCE(&vm->ptdev->base, !bo->dmap.sgt))
+	if (drm_WARN_ON_ONCE(as->base.drm, !bo->dmap.sgt))
 		return -EINVAL;
 
 	for (struct panthor_vma *vma = select_evicted_vma(vm_bo, &op_ctx);
@@ -2680,8 +2704,19 @@ static int panthor_vm_bo_validate(struct drm_gpuvm_bo *vm_bo,
 	return 0;
 }
 
+static void panthor_as_free(struct drm_gpuvm *gpuvm)
+{
+	struct panthor_as *as = container_of(gpuvm, struct panthor_as, base);
+
+	if (as->pt.ops)
+		free_io_pgtable_ops(as->pt.ops);
+
+	mutex_destroy(&as->op_lock);
+	kfree(as);
+}
+
 static const struct drm_gpuvm_ops panthor_gpuvm_ops = {
-	.vm_free = panthor_vm_free,
+	.vm_free = panthor_as_free,
 	.vm_bo_free = panthor_vm_bo_free,
 	.sm_step_map = panthor_gpuva_sm_step_map,
 	.sm_step_remap = panthor_gpuva_sm_step_remap,
@@ -2697,7 +2732,7 @@ static const struct drm_gpuvm_ops panthor_gpuvm_ops = {
  */
 struct dma_resv *panthor_vm_resv(struct panthor_vm *vm)
 {
-	return drm_gpuvm_resv(&vm->base);
+	return drm_gpuvm_resv(&vm->as->base);
 }
 
 struct drm_gem_object *panthor_vm_root_gem(struct panthor_vm *vm)
@@ -2705,12 +2740,12 @@ struct drm_gem_object *panthor_vm_root_gem(struct panthor_vm *vm)
 	if (!vm)
 		return NULL;
 
-	return vm->base.r_obj;
+	return vm->as->base.r_obj;
 }
 
-static int
-panthor_vm_exec_op(struct panthor_vm *vm, struct panthor_vm_op_ctx *op,
-		   bool flag_vm_unusable_on_failure)
+static int panthor_as_exec_op(struct panthor_as *as,
+			      struct panthor_as_op_ctx *op,
+			      bool flag_vm_unusable_on_failure)
 {
 	u32 op_type = op->flags & DRM_PANTHOR_VM_BIND_OP_TYPE_MASK;
 	int ret;
@@ -2718,10 +2753,10 @@ panthor_vm_exec_op(struct panthor_vm *vm, struct panthor_vm_op_ctx *op,
 	if (op_type == DRM_PANTHOR_VM_BIND_OP_TYPE_SYNC_ONLY)
 		return 0;
 
-	mutex_lock(&vm->op_lock);
-	vm->op_ctx = op;
+	mutex_lock(&as->op_lock);
+	as->op_ctx = op;
 
-	ret = panthor_vm_lock_region(vm, op->va.addr, op->va.range);
+	ret = panthor_as_lock_region(as, op->va.addr, op->va.range);
 	if (ret)
 		goto out;
 
@@ -2734,17 +2769,17 @@ panthor_vm_exec_op(struct panthor_vm *vm, struct panthor_vm_op_ctx *op,
 			.map.gem.offset = op->map.bo_offset,
 		};
 
-		if (vm->unusable) {
+		if (as->unusable) {
 			ret = -EINVAL;
 			break;
 		}
 
-		ret = drm_gpuvm_sm_map(&vm->base, vm, &map_req);
+		ret = drm_gpuvm_sm_map(&as->base, as, &map_req);
 		break;
 	}
 
 	case DRM_PANTHOR_VM_BIND_OP_TYPE_UNMAP:
-		ret = drm_gpuvm_sm_unmap(&vm->base, vm, op->va.addr, op->va.range);
+		ret = drm_gpuvm_sm_unmap(&as->base, as, op->va.addr, op->va.range);
 		break;
 
 	default:
@@ -2752,14 +2787,14 @@ panthor_vm_exec_op(struct panthor_vm *vm, struct panthor_vm_op_ctx *op,
 		break;
 	}
 
-	panthor_vm_unlock_region(vm);
+	panthor_as_unlock_region(as);
 
 out:
 	if (ret && flag_vm_unusable_on_failure)
-		panthor_vm_declare_unusable(vm);
+		panthor_as_declare_unusable(as);
 
-	vm->op_ctx = NULL;
-	mutex_unlock(&vm->op_lock);
+	as->op_ctx = NULL;
+	mutex_unlock(&as->op_lock);
 
 	return ret;
 }
@@ -2777,7 +2812,7 @@ panthor_vm_bind_run_job(struct drm_sched_job *sched_job)
 	 * to be destroyed and recreated.
 	 */
 	cookie = dma_fence_begin_signalling();
-	ret = panthor_vm_exec_op(job->vm, &job->ctx, true);
+	ret = panthor_as_exec_op(job->vm->as, &job->ctx, true);
 	dma_fence_end_signalling(cookie);
 
 	return ret ? ERR_PTR(ret) : NULL;
@@ -2790,7 +2825,7 @@ static void panthor_vm_bind_job_release(struct kref *kref)
 	if (job->base.s_fence)
 		drm_sched_job_cleanup(&job->base);
 
-	panthor_vm_cleanup_op_ctx(&job->ctx, job->vm);
+	panthor_as_cleanup_op_ctx(&job->ctx, job->vm->as);
 	panthor_vm_put(job->vm);
 	kfree(job);
 }
@@ -2835,6 +2870,62 @@ static const struct drm_sched_backend_ops panthor_vm_bind_ops = {
 	.timedout_job = panthor_vm_bind_timedout_job,
 };
 
+static struct panthor_as *
+panthor_as_create(struct panthor_device *ptdev, const char *name,
+		  u64 min_va, u64 va_range)
+{
+	struct io_pgtable_cfg as_cfg = {
+		.pgsize_bitmap	= ptdev->mmu_info.page_size_bitmap,
+		.ias		= GPU_MMU_FEATURES_VA_BITS(ptdev->gpu_info.mmu_features),
+		.oas		= GPU_MMU_FEATURES_PA_BITS(ptdev->gpu_info.mmu_features),
+		.coherent_walk	= ptdev->coherent,
+		.tlb		= &mmu_tlb_ops,
+		.iommu_dev	= drm_dev_dma_dev(&ptdev->base),
+		.alloc		= alloc_pt,
+		.free		= free_pt,
+	};
+	struct drm_gem_object *dummy_gem;
+	struct panthor_as *as;
+	u64 mair;
+
+	/* We allocate a dummy GEM for the VM. */
+	dummy_gem = drm_gpuvm_resv_object_alloc(&ptdev->base);
+	if (!dummy_gem)
+		return ERR_PTR(-ENOMEM);
+
+	as = kzalloc_obj(*as);
+	if (!as) {
+		drm_gem_object_put(dummy_gem);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	mutex_init(&as->op_lock);
+	drm_gem_lru_init(&as->reclaim.lru);
+	INIT_LIST_HEAD(&as->reclaim.lru_node);
+	INIT_LIST_HEAD(&as->hw_slot.lru_node);
+	as->hw_slot.id = -1;
+	refcount_set(&as->active_cnt, 0);
+
+	/* We intentionally leave the reserved range to zero, because we want kernel VMAs
+	 * to be handled the same way user VMAs are.
+	 */
+	drm_gpuvm_init(&as->base, name,
+		       DRM_GPUVM_RESV_PROTECTED | DRM_GPUVM_IMMEDIATE_MODE,
+		       &ptdev->base, dummy_gem, min_va, va_range, 0, 0,
+		       &panthor_gpuvm_ops);
+	drm_gem_object_put(dummy_gem);
+
+	as->pt.ops = alloc_io_pgtable_ops(ARM_64_LPAE_S1, &as_cfg, as);
+	if (!as->pt.ops) {
+		drm_gpuvm_put(&as->base);
+		return ERR_PTR(-EINVAL);
+	}
+
+	mair = io_pgtable_ops_to_pgtable(as->pt.ops)->cfg.arm_lpae_s1_cfg.mair;
+	as->memattr = mair_to_memattr(mair, ptdev->coherent);
+	return as;
+}
+
 /**
  * panthor_vm_create() - Create a VM
  * @ptdev: Device.
@@ -2852,9 +2943,8 @@ panthor_vm_create(struct panthor_device *ptdev, bool for_mcu,
 		  u64 auto_kernel_va_start, u64 auto_kernel_va_size)
 {
 	u32 va_bits = GPU_MMU_FEATURES_VA_BITS(ptdev->gpu_info.mmu_features);
-	u32 pa_bits = GPU_MMU_FEATURES_PA_BITS(ptdev->gpu_info.mmu_features);
+	const char *name = for_mcu ? "panthor-MCU-VM" : "panthor-GPU-VM";
 	u64 full_va_range = 1ull << va_bits;
-	struct drm_gem_object *dummy_gem;
 	struct drm_gpu_scheduler *sched;
 	const struct drm_sched_init_args sched_args = {
 		.ops = &panthor_vm_bind_ops,
@@ -2865,27 +2955,11 @@ panthor_vm_create(struct panthor_device *ptdev, bool for_mcu,
 		.name = "panthor-vm-bind",
 		.dev = ptdev->base.dev,
 	};
-	struct io_pgtable_cfg pgtbl_cfg;
-	u64 mair, min_va, va_range;
+	struct panthor_as *as;
 	struct panthor_vm *vm;
+	u64 min_va, va_range;
 	int ret;
 
-	vm = kzalloc_obj(*vm);
-	if (!vm)
-		return ERR_PTR(-ENOMEM);
-
-	/* We allocate a dummy GEM for the VM. */
-	dummy_gem = drm_gpuvm_resv_object_alloc(&ptdev->base);
-	if (!dummy_gem) {
-		ret = -ENOMEM;
-		goto err_free_vm;
-	}
-
-	mutex_init(&vm->heaps.lock);
-	vm->for_mcu = for_mcu;
-	vm->ptdev = ptdev;
-	mutex_init(&vm->op_lock);
-
 	if (for_mcu) {
 		/* CSF MCU is a cortex M7, and can only address 4G */
 		min_va = 0;
@@ -2895,49 +2969,35 @@ panthor_vm_create(struct panthor_device *ptdev, bool for_mcu,
 		va_range = full_va_range;
 	}
 
+	as = panthor_as_create(ptdev, name, min_va, va_range);
+	if (IS_ERR(as))
+		return ERR_CAST(as);
+
+	vm = kzalloc_obj(*vm);
+	if (!vm) {
+		ret = -ENOMEM;
+		goto err_put_as;
+	}
+
 	vm->user_va_range = kernel_va_start;
+	vm->as = as;
+	mutex_init(&vm->heaps.lock);
+	vm->for_mcu = for_mcu;
 
 	mutex_init(&vm->mm_lock);
 	drm_mm_init(&vm->mm, kernel_va_start, kernel_va_size);
 	vm->kernel_auto_va.start = auto_kernel_va_start;
 	vm->kernel_auto_va.end = vm->kernel_auto_va.start + auto_kernel_va_size - 1;
 
-	drm_gem_lru_init(&vm->reclaim.lru);
-	INIT_LIST_HEAD(&vm->reclaim.lru_node);
-	INIT_LIST_HEAD(&vm->node);
-	INIT_LIST_HEAD(&vm->as.lru_node);
-	vm->as.id = -1;
-	refcount_set(&vm->as.active_cnt, 0);
-
-	pgtbl_cfg = (struct io_pgtable_cfg) {
-		.pgsize_bitmap	= ptdev->mmu_info.page_size_bitmap,
-		.ias		= va_bits,
-		.oas		= pa_bits,
-		.coherent_walk	= ptdev->coherent,
-		.tlb		= &mmu_tlb_ops,
-		.iommu_dev	= ptdev->base.dev,
-		.alloc		= alloc_pt,
-		.free		= free_pt,
-	};
-
-	vm->pgtbl_ops = alloc_io_pgtable_ops(ARM_64_LPAE_S1, &pgtbl_cfg, vm);
-	if (!vm->pgtbl_ops) {
-		ret = -EINVAL;
-		goto err_mm_takedown;
-	}
-
 	ret = drm_sched_init(&vm->sched, &sched_args);
 	if (ret)
-		goto err_free_io_pgtable;
+		goto err_free_vm;
 
 	sched = &vm->sched;
 	ret = drm_sched_entity_init(&vm->entity, 0, &sched, 1, NULL);
 	if (ret)
 		goto err_sched_fini;
 
-	mair = io_pgtable_ops_to_pgtable(vm->pgtbl_ops)->cfg.arm_lpae_s1_cfg.mair;
-	vm->memattr = mair_to_memattr(mair, ptdev->coherent);
-
 	mutex_lock(&ptdev->mmu->vm.lock);
 	list_add_tail(&vm->node, &ptdev->mmu->vm.list);
 
@@ -2946,28 +3006,20 @@ panthor_vm_create(struct panthor_device *ptdev, bool for_mcu,
 		panthor_vm_stop(vm);
 	mutex_unlock(&ptdev->mmu->vm.lock);
 
-	/* We intentionally leave the reserved range to zero, because we want kernel VMAs
-	 * to be handled the same way user VMAs are.
-	 */
-	drm_gpuvm_init(&vm->base, for_mcu ? "panthor-MCU-VM" : "panthor-GPU-VM",
-		       DRM_GPUVM_RESV_PROTECTED | DRM_GPUVM_IMMEDIATE_MODE,
-		       &ptdev->base, dummy_gem, min_va, va_range, 0, 0,
-		       &panthor_gpuvm_ops);
-	drm_gem_object_put(dummy_gem);
+	kref_init(&vm->refcount);
 	return vm;
 
 err_sched_fini:
 	drm_sched_fini(&vm->sched);
 
-err_free_io_pgtable:
-	free_io_pgtable_ops(vm->pgtbl_ops);
-
-err_mm_takedown:
-	drm_mm_takedown(&vm->mm);
-	drm_gem_object_put(dummy_gem);
-
 err_free_vm:
+	drm_mm_takedown(&vm->mm);
+	mutex_destroy(&vm->mm_lock);
+	mutex_destroy(&vm->heaps.lock);
 	kfree(vm);
+
+err_put_as:
+	drm_gpuvm_put(&as->base);
 	return ERR_PTR(ret);
 }
 
@@ -2975,7 +3027,7 @@ static int
 panthor_vm_bind_prepare_op_ctx(struct drm_file *file,
 			       struct panthor_vm *vm,
 			       const struct drm_panthor_vm_bind_op *op,
-			       struct panthor_vm_op_ctx *op_ctx)
+			       struct panthor_as_op_ctx *op_ctx)
 {
 	ssize_t vm_pgsz = panthor_vm_page_size(vm);
 	struct drm_gem_object *gem;
@@ -2998,7 +3050,7 @@ panthor_vm_bind_prepare_op_ctx(struct drm_file *file,
 			drm_gem_object_get(&vm->dummy->base);
 		}
 
-		ret = panthor_vm_prepare_map_op_ctx(op_ctx, vm,
+		ret = panthor_as_prepare_map_op_ctx(op_ctx, vm->as,
 						    gem ? to_panthor_bo(gem) : NULL,
 						    op);
 		drm_gem_object_put(gem);
@@ -3011,7 +3063,7 @@ panthor_vm_bind_prepare_op_ctx(struct drm_file *file,
 		if (op->bo_handle || op->bo_offset)
 			return -EINVAL;
 
-		return panthor_vm_prepare_unmap_op_ctx(op_ctx, vm, op->va, op->size);
+		return panthor_as_prepare_unmap_op_ctx(op_ctx, vm->as, op->va, op->size);
 
 	case DRM_PANTHOR_VM_BIND_OP_TYPE_SYNC_ONLY:
 		if (op->flags & ~DRM_PANTHOR_VM_BIND_OP_TYPE_MASK)
@@ -3026,7 +3078,7 @@ panthor_vm_bind_prepare_op_ctx(struct drm_file *file,
 		if (!op->syncs.count)
 			return -EINVAL;
 
-		panthor_vm_prepare_sync_only_op_ctx(op_ctx);
+		panthor_as_prepare_sync_only_op_ctx(op_ctx);
 		return 0;
 
 	default:
@@ -3061,7 +3113,7 @@ panthor_vm_bind_job_create(struct drm_file *file,
 	if (!vm)
 		return ERR_PTR(-EINVAL);
 
-	if (vm->destroyed || vm->unusable)
+	if (vm->destroyed || vm->as->unusable)
 		return ERR_PTR(-EINVAL);
 
 	job = kzalloc_obj(*job);
@@ -3107,7 +3159,7 @@ int panthor_vm_bind_job_prepare_resvs(struct drm_exec *exec,
 	int ret;
 
 	/* Acquire the VM lock an reserve a slot for this VM bind job. */
-	ret = drm_gpuvm_prepare_vm(&job->vm->base, exec, 1);
+	ret = drm_gpuvm_prepare_vm(&job->vm->as->base, exec, 1);
 	if (ret)
 		return ret;
 
@@ -3132,7 +3184,7 @@ void panthor_vm_bind_job_update_resvs(struct drm_exec *exec,
 	struct panthor_vm_bind_job *job = container_of(sched_job, struct panthor_vm_bind_job, base);
 
 	/* Explicit sync => we just register our job finished fence as bookkeep. */
-	drm_gpuvm_resv_add_fence(&job->vm->base, exec,
+	drm_gpuvm_resv_add_fence(&job->vm->as->base, exec,
 				 &sched_job->s_fence->finished,
 				 DMA_RESV_USAGE_BOOKKEEP,
 				 DMA_RESV_USAGE_BOOKKEEP);
@@ -3143,7 +3195,7 @@ void panthor_vm_update_resvs(struct panthor_vm *vm, struct drm_exec *exec,
 			     enum dma_resv_usage private_usage,
 			     enum dma_resv_usage extobj_usage)
 {
-	drm_gpuvm_resv_add_fence(&vm->base, exec, fence, private_usage, extobj_usage);
+	drm_gpuvm_resv_add_fence(&vm->as->base, exec, fence, private_usage, extobj_usage);
 }
 
 /**
@@ -3158,7 +3210,7 @@ int panthor_vm_bind_exec_sync_op(struct drm_file *file,
 				 struct panthor_vm *vm,
 				 struct drm_panthor_vm_bind_op *op)
 {
-	struct panthor_vm_op_ctx op_ctx;
+	struct panthor_as_op_ctx op_ctx;
 	int ret;
 
 	/* No sync objects allowed on synchronous operations. */
@@ -3172,8 +3224,8 @@ int panthor_vm_bind_exec_sync_op(struct drm_file *file,
 	if (ret)
 		return ret;
 
-	ret = panthor_vm_exec_op(vm, &op_ctx, false);
-	panthor_vm_cleanup_op_ctx(&op_ctx, vm);
+	ret = panthor_as_exec_op(vm->as, &op_ctx, false);
+	panthor_as_cleanup_op_ctx(&op_ctx, vm->as);
 
 	return ret;
 }
@@ -3202,18 +3254,18 @@ int panthor_vm_map_bo_range(struct panthor_vm *vm, struct panthor_gem_object *bo
 		.va = va,
 		.flags = flags,
 	};
-	struct panthor_vm_op_ctx op_ctx;
+	struct panthor_as_op_ctx op_ctx;
 	int ret;
 
-	if (drm_WARN_ON(&vm->ptdev->base, flags & DRM_PANTHOR_VM_BIND_OP_MAP_SPARSE))
+	if (drm_WARN_ON(vm->as->base.drm, flags & DRM_PANTHOR_VM_BIND_OP_MAP_SPARSE))
 		return -EINVAL;
 
-	ret = panthor_vm_prepare_map_op_ctx(&op_ctx, vm, bo, &op);
+	ret = panthor_as_prepare_map_op_ctx(&op_ctx, vm->as, bo, &op);
 	if (ret)
 		return ret;
 
-	ret = panthor_vm_exec_op(vm, &op_ctx, false);
-	panthor_vm_cleanup_op_ctx(&op_ctx, vm);
+	ret = panthor_as_exec_op(vm->as, &op_ctx, false);
+	panthor_as_cleanup_op_ctx(&op_ctx, vm->as);
 
 	return ret;
 }
@@ -3231,15 +3283,15 @@ int panthor_vm_map_bo_range(struct panthor_vm *vm, struct panthor_gem_object *bo
  */
 int panthor_vm_unmap_range(struct panthor_vm *vm, u64 va, u64 size)
 {
-	struct panthor_vm_op_ctx op_ctx;
+	struct panthor_as_op_ctx op_ctx;
 	int ret;
 
-	ret = panthor_vm_prepare_unmap_op_ctx(&op_ctx, vm, va, size);
+	ret = panthor_as_prepare_unmap_op_ctx(&op_ctx, vm->as, va, size);
 	if (ret)
 		return ret;
 
-	ret = panthor_vm_exec_op(vm, &op_ctx, false);
-	panthor_vm_cleanup_op_ctx(&op_ctx, vm);
+	ret = panthor_as_exec_op(vm->as, &op_ctx, false);
+	panthor_as_cleanup_op_ctx(&op_ctx, vm->as);
 
 	return ret;
 }
@@ -3263,15 +3315,15 @@ int panthor_vm_prepare_mapped_bos_resvs(struct drm_exec *exec, struct panthor_vm
 	int ret;
 
 	/* Acquire the VM lock and reserve a slot for this GPU job. */
-	ret = drm_gpuvm_prepare_vm(&vm->base, exec, slot_count);
+	ret = drm_gpuvm_prepare_vm(&vm->as->base, exec, slot_count);
 	if (ret)
 		return ret;
 
-	ret = drm_gpuvm_prepare_objects(&vm->base, exec, slot_count);
+	ret = drm_gpuvm_prepare_objects(&vm->as->base, exec, slot_count);
 	if (ret)
 		return ret;
 
-	return drm_gpuvm_validate(&vm->base, exec);
+	return drm_gpuvm_validate(&vm->as->base, exec);
 }
 
 unsigned long
@@ -3288,21 +3340,21 @@ panthor_mmu_reclaim_priv_bos(struct panthor_device *ptdev,
 	list_splice_init(&ptdev->reclaim.vms, &vms);
 
 	while (freed < nr_to_scan) {
-		struct panthor_vm *vm;
+		struct panthor_as *as;
 
-		vm = list_first_entry_or_null(&vms, typeof(*vm),
+		as = list_first_entry_or_null(&vms, typeof(*as),
 					      reclaim.lru_node);
-		if (!vm)
+		if (!as)
 			break;
 
-		if (!kref_get_unless_zero(&vm->base.kref)) {
-			list_del_init(&vm->reclaim.lru_node);
+		if (!kref_get_unless_zero(&as->base.kref)) {
+			list_del_init(&as->reclaim.lru_node);
 			continue;
 		}
 
 		mutex_unlock(&ptdev->base.gem_lru_mutex);
 
-		freed += drm_gem_lru_scan(&ptdev->base, &vm->reclaim.lru,
+		freed += drm_gem_lru_scan(&ptdev->base, &as->reclaim.lru,
 					  nr_to_scan - freed,
 					  remaining, shrink, NULL);
 
@@ -3311,20 +3363,20 @@ panthor_mmu_reclaim_priv_bos(struct panthor_device *ptdev,
 		/* If the VM is still in the temporary list, remove it so we
 		 * can proceed with the next VM.
 		 */
-		if (vm == list_first_entry_or_null(&vms, typeof(*vm), reclaim.lru_node)) {
-			list_del_init(&vm->reclaim.lru_node);
+		if (as == list_first_entry_or_null(&vms, typeof(*as), reclaim.lru_node)) {
+			list_del_init(&as->reclaim.lru_node);
 
 			/* Keep the VM around if there are still things to
 			 * reclaim, so we can preserve the LRU order when
 			 * re-inserting in ptdev->reclaim.vms at the end.
 			 */
-			if (vm->reclaim.lru.count > 0)
-				list_add_tail(&vm->reclaim.lru_node, &remaining_vms);
+			if (as->reclaim.lru.count > 0)
+				list_add_tail(&as->reclaim.lru_node, &remaining_vms);
 		}
 
 		mutex_unlock(&ptdev->base.gem_lru_mutex);
 
-		panthor_vm_put(vm);
+		drm_gpuvm_put(&as->base);
 
 		mutex_lock(&ptdev->base.gem_lru_mutex);
 	}
@@ -3356,12 +3408,12 @@ void panthor_mmu_unplug(struct panthor_device *ptdev)
 
 	mutex_lock(&ptdev->mmu->as.slots_lock);
 	for (u32 i = 0; i < ARRAY_SIZE(ptdev->mmu->as.slots); i++) {
-		struct panthor_vm *vm = ptdev->mmu->as.slots[i].vm;
+		struct panthor_as *as = ptdev->mmu->as.slots[i].as;
 
-		if (vm) {
+		if (as) {
 			drm_WARN_ON(&ptdev->base,
 				    panthor_mmu_as_disable(ptdev, i, false));
-			panthor_vm_release_as_locked(vm);
+			panthor_as_release_hw_slot_locked(as);
 		}
 	}
 	mutex_unlock(&ptdev->mmu->as.slots_lock);
@@ -3445,9 +3497,9 @@ static int show_vm_gpuvas(struct panthor_vm *vm, struct seq_file *m)
 {
 	int ret;
 
-	mutex_lock(&vm->op_lock);
-	ret = drm_debugfs_gpuva_info(m, &vm->base);
-	mutex_unlock(&vm->op_lock);
+	mutex_lock(&vm->as->op_lock);
+	ret = drm_debugfs_gpuva_info(m, &vm->as->base);
+	mutex_unlock(&vm->as->op_lock);
 
 	return ret;
 }

-- 
2.55.0

