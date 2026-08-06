Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E95FC561E6
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 06:11:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1607010E28B;
	Thu,  6 Aug 2026 06:11:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="cMOmG6Ua";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DACF910E274;
 Thu,  6 Aug 2026 06:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785996700; x=1817532700;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=8/3ai5iWOW8v1Ou0OOwxIrMB39d/xzTOGPwl+EBoK4I=;
 b=cMOmG6Uai2r223eDk6LtK+kkYrwpA/COwwde4qWxMuH6dADR8iZuNOoW
 n/8FVrQMTwgmt3gmzGOD1KTdmKxjt5P2g9N0ns8VvHAD606NftS3CuIWQ
 IcVUSOLiqZE62VOp78TdZoV+aZOyDqhIoVDeUumDSsaemSWbE2nOUiUgo
 3RccX0C8lYFqWx0IPkopbxEehMhm5eEMdt1RVivQBsSMc4i6Ls7aFYajM
 UDkAL89oe+yc61mqGo0pPBFZwI4/d46Otua5io/nLoyUnDXu1bSbCDZSE
 8LqU1xKOkHQveTizx1g5ohClVNqLzvz8evO+jP5kTU9vSFQWZBe7DWNLL A==;
X-CSE-ConnectionGUID: oSkDs6QJQQe62n1WaMn7hg==
X-CSE-MsgGUID: kkbPT/zlT9KrkqDvV0vwMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="103984173"
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; d="scan'208";a="103984173"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Aug 2026 23:11:40 -0700
X-CSE-ConnectionGUID: 5D+7/xzxQsm7jkx7rdDuog==
X-CSE-MsgGUID: As/WE4wGRzeub4fNU1wcCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; d="scan'208";a="262628797"
Received: from varungup-desk.iind.intel.com ([10.190.238.71])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Aug 2026 23:11:37 -0700
From: Arvind Yadav <arvind.yadav@intel.com>
To: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: matthew.brost@intel.com, thomas.hellstrom@linux.intel.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, himal.prasad.ghimiray@intel.com
Subject: [PATCH v2] drm/pagemap: Prevent double migration of device pages
Date: Thu,  6 Aug 2026 11:41:26 +0530
Message-ID: <20260806061126.1499149-1-arvind.yadav@intel.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

A device page migrated to system memory by a CPU fault can remain
referenced after migration completes. During this window, raw-PFN
eviction can collect the same device PFN and migrate it again.

The first migration has already transferred the memcg charge from the
source folio. Migrating that source again can create an uncharged system
folio. Adding such a folio to the LRU can spin indefinitely in
folio_lruvec_lock_irqsave(), causing a soft lockup and an RCU stall.

Track successful device-page migrations in an allocation-relative bitmap
stored in drm_pagemap_zdd. Record successful migrations before finalize
unlocks and drops the migration reference on the source.

Make raw-PFN eviction skip retired folios. Record raw-PFN migrations as
well so an eviction retry cannot select a folio migrated by an earlier
pass.

Mark every base-page bit covered by a migrated folio so the retirement
state remains valid if the source folio is later split.

v2:
- Replace the retired-PFN XArray with an embedded bitmap.(Matthew Brost)
- Mark every base page covered by a migrated folio so retirement remains
  valid if the folio is later split.

The lockup was observed as:
==============================
[10109.860465] watchdog: BUG: soft lockup - CPU#9 stuck for 26s! [kworker/u65:5:6557]
[10109.860508] irq event stamp: 308085402
[10109.860508] hardirqs last  enabled at (308085401): [<ffffffff829571e1>] _raw_spin_unlock_irqrestore+0x51/0x80
[10109.860514] hardirqs last disabled at (308085402): [<ffffffff8293dd71>] sysvec_apic_timer_interrupt+0x11/0xc0
[10109.860516] softirqs last  enabled at (307538534): [<ffffffff813d111b>] __irq_exit_rcu+0xdb/0x1c0
[10109.860519] softirqs last disabled at (307538529): [<ffffffff813d111b>] __irq_exit_rcu+0xdb/0x1c0
[10109.860521] CPU: 9 UID: 0 PID: 6557 Comm: kworker/u65:5 Kdump: loaded Tainted: G S         O        7.2.0-rc3-lgci-xepurge-
[10109.860524] Tainted: [S]=CPU_OUT_OF_SPEC, [O]=OOT_MODULE
[10109.860524] Hardware name: ASUS System Product Name/PRIME Z790-P WIFI, BIOS 0812 02/24/2023
[10109.860525] Workqueue: xe_page_fault_work_queue xe_pagefault_queue_work [xe]
[10109.860644] RIP: 0010:_raw_spin_unlock_irqrestore+0x57/0x80
[10109.860647] Code: 00 75 1c 65 ff 0d 69 ee 84 01 74 20 5b 41 5c 5d 31 c0 31 d2 31 c9 31 f6 31 ff c3 cc cc cc cc e8 8f 2e c9
[10109.860648] RSP: 0018:ffffc9000c017030 EFLAGS: 00000246
[10109.860649] RAX: 0000000000000000 RBX: ffff8881012c00d0 RCX: 0000000000000000
[10109.860650] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[10109.860650] RBP: ffffc9000c017040 R08: 0000000000000000 R09: 0000000000000000
[10109.860651] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000246
[10109.860651] R13: ffffc9000c0170a0 R14: ffff8881012c00d0 R15: ffff88810e9e6f00
[10109.860652] FS:  0000000000000000(0000) GS:ffff8888db2f2000(0000) knlGS:0000000000000000
[10109.860653] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[10109.860653] CR2: 00007a26c0e00048 CR3: 00000001f366d006 CR4: 0000000000f72ef0
[10109.860654] PKRU: 55555554
[10109.860655] Call Trace:
[10109.860655]  <TASK>
[10109.860657]  folio_lruvec_lock_irqsave+0x216/0x220
[10109.860661]  ? __pfx_lru_add+0x10/0x10
[10109.860665]  folio_batch_move_lru+0xc8/0x450
[10109.860670]  ? lock_acquire+0xc4/0x2d0
[10109.860674]  ? __folio_batch_add_and_move+0x60/0x2e0
[10109.860677]  ? folio_migrate_mapping+0xa6/0x110
[10109.860679]  ? folio_migrate_flags+0x13b/0x1b0
[10109.860681]  ? __pfx_lru_add+0x10/0x10
[10109.860683]  __folio_batch_add_and_move+0xe7/0x2e0
[10109.860685]  ? dma_iova_try_alloc+0xb0/0x140
[10109.860689]  folio_add_lru+0x64/0x80
[10109.860691]  __migrate_device_finalize+0x12c/0x270
[10109.860695]  migrate_device_finalize+0x10/0x20
[10109.860698]  drm_pagemap_evict_to_ram+0x185/0x370 [drm_gpusvm_helper]
[10109.860704]  ? drm_pagemap_evict_to_ram+0x96/0x370 [drm_gpusvm_helper]
[10109.860709]  xe_svm_bo_evict+0x15/0x20 [xe]
[10109.860819]  ? xe_svm_bo_evict+0x15/0x20 [xe]
[10109.860921]  xe_bo_move+0x107e/0x1570 [xe]
[10109.860992]  ? xe_ttm_tt_create+0x168/0x340 [xe]
[10109.861059]  ? __up_read+0x98/0x2b0
[10109.861061]  ? lock_is_held_type+0xa3/0x130
[10109.861067]  ttm_bo_handle_move_mem+0xe8/0x1e0 [ttm]
[10109.861075]  ttm_bo_evict+0x141/0x1c0 [ttm]
[10109.861081]  ttm_bo_evict_cb+0x9f/0x100 [ttm]
[10109.861086]  ttm_lru_walk_for_evict+0x84/0x190 [ttm]
[10109.861091]  ? xe_ttm_vram_mgr_new+0x258/0x3a0 [xe]
[10109.861198]  ttm_bo_alloc_resource+0x219/0x750 [ttm]
[10109.861203]  ? ttm_bo_alloc_resource+0xa9/0x750 [ttm]
[10109.861208]  ? lock_acquire+0xc4/0x2d0
[10109.861214]  ttm_bo_validate+0x94/0x1c0 [ttm]
[10109.861218]  ? ww_mutex_trylock+0x19d/0x3d0
[10109.861219]  ? _raw_write_unlock+0x22/0x50
[10109.861223]  ttm_bo_init_reserved+0x17d/0x1f0 [ttm]
[10109.861228]  xe_bo_init_locked+0x20a/0x620 [xe]
[10109.861294]  ? __pfx_xe_ttm_bo_destroy+0x10/0x10 [xe]
[10109.861359]  ? mark_held_locks+0x46/0x90
[10109.861361]  ? __create_object+0x68/0xc0
[10109.861366]  __xe_bo_create_locked+0x384/0xa20 [xe]
[10109.861432]  ? lock_acquire+0xc4/0x2d0
[10109.861434]  ? xe_drm_pagemap_populate_mm+0xd3/0x340 [xe]
[10109.861542]  xe_bo_create_locked+0x23/0x40 [xe]
[10109.861609]  xe_drm_pagemap_populate_mm+0x12e/0x340 [xe]
[10109.861707]  ? __lock_acquire+0x43e/0x2930
[10109.861716]  drm_pagemap_populate_mm+0x74/0xe0 [drm_gpusvm_helper]
[10109.861720]  xe_svm_alloc_vram+0xb5/0x2c0 [xe]
[10109.861817]  ? seqcount_lockdep_reader_access.constprop.0+0x9f/0xc0
[10109.861819]  ? ktime_get+0x23/0x130
[10109.861821]  ? trace_hardirqs_on+0x22/0xe0
[10109.861823]  ? seqcount_lockdep_reader_access.constprop.0+0x9f/0xc0
[10109.861826]  __xe_svm_handle_pagefault+0x77d/0xbf0 [xe]
[10109.861924]  ? rwsem_down_write_slowpath+0x43a/0x9a0
[10109.861926]  ? _raw_spin_unlock_irq+0x27/0x70
[10109.861928]  ? rwsem_down_write_slowpath+0x43a/0x9a0
[10109.861929]  ? trace_hardirqs_on+0x22/0xe0
[10109.861931]  ? _raw_spin_unlock_irq+0x27/0x70
[10109.861933]  ? rwsem_down_write_slowpath+0x459/0x9a0
[10109.861937]  xe_svm_handle_pagefault+0x3d/0xb0 [xe]
[10109.862030]  xe_pagefault_queue_work+0x1a9/0x520 [xe]
[10109.862122]  process_one_work+0x239/0x730
[10109.862127]  worker_thread+0x200/0x3f0
[10109.862130]  ? __pfx_worker_thread+0x10/0x10
[10109.862132]  kthread+0x10d/0x150
[10109.862133]  ? __pfx_kthread+0x10/0x10
[10109.862135]  ret_from_fork+0x3bd/0x470
[10109.862138]  ? __pfx_kthread+0x10/0x10
[10109.862140]  ret_from_fork_asm+0x1a/0x30
[10109.862146]  </TASK>

Fixes: 99624bdff867 ("drm/gpusvm: Add support for GPU Shared Virtual Memory")
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
---
 drivers/gpu/drm/drm_pagemap.c | 143 ++++++++++++++++++++++++++++++++--
 1 file changed, 136 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/drm_pagemap.c b/drivers/gpu/drm/drm_pagemap.c
index 7a056592ac66..713095e27006 100644
--- a/drivers/gpu/drm/drm_pagemap.c
+++ b/drivers/gpu/drm/drm_pagemap.c
@@ -7,6 +7,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/migrate.h>
 #include <linux/pagemap.h>
+#include <linux/bitmap.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_pagemap.h>
 #include <drm/drm_pagemap_util.h>
@@ -66,6 +67,12 @@
  * @refcount: Reference count for the zdd
  * @devmem_allocation: device memory allocation
  * @dpagemap: Refcounted pointer to the underlying struct drm_pagemap.
+ * @range_start: Virtual start address of the device memory allocation. Used to
+ * translate a clipped CPU-fault range into an allocation-relative page offset.
+ * @range_npages: Number of pages covered by the allocation, i.e. the number of
+ * valid bits in @retire_map.
+ * @retire_map: Allocation-relative bitmap. Every base page covered by a
+ * migrated folio remains marked until this mapping generation is destroyed.
  *
  * This structure serves as a generic wrapper installed in
  * page->zone_device_data. It provides infrastructure for looking up a device
@@ -78,29 +85,38 @@ struct drm_pagemap_zdd {
 	struct kref refcount;
 	struct drm_pagemap_devmem *devmem_allocation;
 	struct drm_pagemap *dpagemap;
+	unsigned long range_start;
+	unsigned long range_npages;
+	unsigned long retire_map[];
 };
 
 /**
  * drm_pagemap_zdd_alloc() - Allocate a zdd structure.
  * @dpagemap: Pointer to the underlying struct drm_pagemap.
+ * @start: Virtual start address of the device memory allocation.
+ * @npages: Number of pages in the device memory allocation.
  *
  * This function allocates and initializes a new zdd structure. It sets up the
- * reference count and initializes the destroy work.
+ * reference count and a zeroed retirement bitmap sized for @npages.
  *
- * Return: Pointer to the allocated zdd on success, ERR_PTR() on failure.
+ * Return: Pointer to the allocated zdd on success, NULL on failure.
  */
 static struct drm_pagemap_zdd *
-drm_pagemap_zdd_alloc(struct drm_pagemap *dpagemap)
+drm_pagemap_zdd_alloc(struct drm_pagemap *dpagemap, unsigned long start,
+		      unsigned long npages)
 {
 	struct drm_pagemap_zdd *zdd;
 
-	zdd = kmalloc_obj(*zdd);
+	zdd = kzalloc(struct_size(zdd, retire_map, BITS_TO_LONGS(npages)),
+		      GFP_KERNEL);
 	if (!zdd)
 		return NULL;
 
 	kref_init(&zdd->refcount);
 	zdd->devmem_allocation = NULL;
 	zdd->dpagemap = drm_pagemap_get(dpagemap);
+	zdd->range_start = start;
+	zdd->range_npages = npages;
 
 	return zdd;
 }
@@ -669,7 +685,7 @@ int drm_pagemap_migrate_to_devmem(struct drm_pagemap_devmem *devmem_allocation,
 	pagemap_addr = buf + (2 * sizeof(*migrate.src) * npages);
 	pages = buf + (2 * sizeof(*migrate.src) + sizeof(*pagemap_addr)) * npages;
 
-	zdd = drm_pagemap_zdd_alloc(dpagemap);
+	zdd = drm_pagemap_zdd_alloc(dpagemap, start, npages);
 	if (!zdd) {
 		err = -ENOMEM;
 		kvfree(buf);
@@ -1102,12 +1118,115 @@ void drm_pagemap_put(struct drm_pagemap *dpagemap)
 }
 EXPORT_SYMBOL(drm_pagemap_put);
 
+/**
+ * drm_pagemap_is_devmem_page() - Check whether a page is device memory
+ * @page: page to check
+ *
+ * Return: true if @page is device-private or device-coherent
+ */
+static bool drm_pagemap_is_devmem_page(const struct page *page)
+{
+	return is_device_private_page(page) || is_device_coherent_page(page);
+}
+
+/**
+ * drm_pagemap_retire_migrated_pages() - Record migrated device folios
+ * @src_pfns: source array after migrate_vma_pages() or migrate_device_pages()
+ * @npages: number of entries in @src_pfns
+ * @first: allocation-relative page offset of @src_pfns[0]
+ *
+ * Record successful migrations in the zdd retirement bitmap before finalize
+ * unlocks the sources. The bit is set only after a confirmed migration, and
+ * test_and_set_bit() is used because concurrent CPU faults on clipped ranges
+ * can update different bits in the same word.
+ */
+static void drm_pagemap_retire_migrated_pages(unsigned long *src_pfns,
+					      unsigned long npages,
+					      unsigned long first)
+{
+	unsigned long i = 0;
+
+	while (i < npages) {
+		struct page *page = migrate_pfn_to_page(src_pfns[i]);
+		struct drm_pagemap_zdd *zdd;
+		unsigned long bit, j, nr = 1;
+
+		if (!page) {
+			i++;
+			continue;
+		}
+
+		nr = folio_nr_pages(page_folio(page));
+
+		if (!(src_pfns[i] & MIGRATE_PFN_MIGRATE) ||
+		    !drm_pagemap_is_devmem_page(page))
+			goto next;
+
+		zdd = drm_pagemap_page_zone_device_data(page);
+		bit = first + i;
+
+		if (WARN_ON_ONCE(bit >= zdd->range_npages ||
+				 nr > zdd->range_npages - bit))
+			goto next;
+
+		/* Keep later folio splits covered. */
+		for (j = 0; j < nr; j++)
+			WARN_ON_ONCE(test_and_set_bit(bit + j, zdd->retire_map));
+next:
+		i += nr;
+	}
+}
+
+/**
+ * drm_pagemap_skip_retired_pages() - Drop retired PFNs from a raw-PFN eviction
+ * @src_pfns: source array after migrate_device_pfns() (MIGRATE_PFN encoded)
+ * @npages: number of entries in @src_pfns
+ *
+ * Skip source PFNs already migrated to RAM by either migration path. The
+ * raw-PFN eviction array starts at allocation offset zero, so the array index
+ * is also the retirement bitmap index.
+ */
+static void drm_pagemap_skip_retired_pages(unsigned long *src_pfns,
+					   unsigned long npages)
+{
+	unsigned long i = 0;
+
+	while (i < npages) {
+		struct page *page = migrate_pfn_to_page(src_pfns[i]);
+		struct drm_pagemap_zdd *zdd;
+		unsigned long nr = 1;
+
+		if (!page) {
+			i++;
+			continue;
+		}
+
+		nr = folio_nr_pages(page_folio(page));
+
+		if (!(src_pfns[i] & MIGRATE_PFN_MIGRATE) ||
+		    !drm_pagemap_is_devmem_page(page))
+			goto next;
+
+		zdd = drm_pagemap_page_zone_device_data(page);
+		if (WARN_ON_ONCE(i >= zdd->range_npages)) {
+			src_pfns[i] &= ~MIGRATE_PFN_MIGRATE;
+			goto next;
+		}
+
+		if (test_bit(i, zdd->retire_map))
+			src_pfns[i] &= ~MIGRATE_PFN_MIGRATE;
+next:
+		i += nr;
+	}
+}
+
 /**
  * drm_pagemap_evict_to_ram() - Evict GPU SVM range to RAM
  * @devmem_allocation: Pointer to the device memory allocation
  *
- * Similar to __drm_pagemap_migrate_to_ram but does not require mmap lock and
- * migration done via migrate_device_* functions.
+ * Similar to __drm_pagemap_migrate_to_ram(), but uses the
+ * migrate_device_* helpers and does not require the mmap lock. Device
+ * PFNs already migrated to RAM by either migration path are skipped.
  *
  * Return: 0 on success, negative error code on failure.
  */
@@ -1149,6 +1268,8 @@ int drm_pagemap_evict_to_ram(struct drm_pagemap_devmem *devmem_allocation)
 	if (err)
 		goto err_free;
 
+	drm_pagemap_skip_retired_pages(src, npages);
+
 	err = drm_pagemap_migrate_populate_ram_pfn(NULL, NULL, npages, &mpages,
 						   src, dst, 0);
 	if (err || !mpages)
@@ -1179,6 +1300,8 @@ int drm_pagemap_evict_to_ram(struct drm_pagemap_devmem *devmem_allocation)
 	if (err)
 		drm_pagemap_migration_unlock_put_pages(npages, dst);
 	migrate_device_pages(src, dst, npages);
+	/* Raw-PFN eviction: array starts at allocation offset zero. */
+	drm_pagemap_retire_migrated_pages(src, npages, 0);
 	migrate_device_finalize(src, dst, npages);
 	drm_pagemap_migrate_unmap_pages(devmem_allocation->dev, pagemap_addr, dst, npages,
 					DMA_FROM_DEVICE, &state);
@@ -1251,6 +1374,10 @@ static int __drm_pagemap_migrate_to_ram(struct vm_area_struct *vas,
 	if (end > vas->vm_end)
 		end = vas->vm_end;
 
+	/* Keep the range within the ZDD allocation so retirement offsets stay valid. */
+	start = max(start, zdd->range_start);
+	end = min(end, zdd->range_start + (zdd->range_npages << PAGE_SHIFT));
+
 	migrate.start = start;
 	migrate.end = end;
 	npages = npages_in_range(start, end);
@@ -1309,6 +1436,8 @@ static int __drm_pagemap_migrate_to_ram(struct vm_area_struct *vas,
 	if (err)
 		drm_pagemap_migration_unlock_put_pages(npages, migrate.dst);
 	migrate_vma_pages(&migrate);
+	drm_pagemap_retire_migrated_pages(migrate.src, npages,
+					  (start - zdd->range_start) >> PAGE_SHIFT);
 	migrate_vma_finalize(&migrate);
 	if (dev)
 		drm_pagemap_migrate_unmap_pages(dev, pagemap_addr, migrate.dst,
-- 
2.43.0

