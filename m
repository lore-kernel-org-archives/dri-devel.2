Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88283CD37AA
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 06:56:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE8C310F36C;
	Fri,  8 May 2026 06:56:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="L8KHJCk6";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EA1C10F369;
 Fri,  8 May 2026 06:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778223364; x=1809759364;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=47POBLVaUrXtK1fn5h2rHbXgKdBedhfQvXbum5KWZpY=;
 b=L8KHJCk6taFyMXyAoAmZyKAbRI4ljiOboWt1PV+cdcPFKuUcGU53eDZV
 OllX892Dwr9BU7Z5Es02CnlKmCKclnmduTUd6f/9cweldEN212jEgeikh
 u9wL3hIQunc34UypSq0M7a11w/sD2lueud9mDZOTsclPufA2Rdnrd4sxJ
 OlSMeIYI1+I7L+SUI4RRhMkIL4ZUJH0UqVQbNH6ABndjdH816jdQcnSzx
 uGorDDZduLCK0YV3pkn99HEhi6ai2SCtz4WIpkbipjDh9yms2u4JnBcId
 Gb50FdHeoWxczpf4q5IFWspdg0OAHxlR6pAn/nN/A/IWkPkGR0w728OKK w==;
X-CSE-ConnectionGUID: z7a1qwv5SN6aQcp0zk+W/A==
X-CSE-MsgGUID: RVvl4OzcTj6CRTRDvCAj/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="79373325"
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; d="scan'208";a="79373325"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2026 23:56:03 -0700
X-CSE-ConnectionGUID: F50X2WD0Tn6WkjwwFx5+Nw==
X-CSE-MsgGUID: vHEYlSuQSi2eEDhF3COPEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; d="scan'208";a="232153647"
Received: from tejasupa-desk.iind.intel.com (HELO tejasupa-desk)
 ([10.190.239.37])
 by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2026 23:56:00 -0700
From: Tejas Upadhyay <tejas.upadhyay@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: matthew.auld@intel.com, Arunpravin.PaneerSelvam@amd.com,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 Tejas Upadhyay <tejas.upadhyay@intel.com>,
 Matthew Brost <matthew.brost@intel.com>
Subject: [PATCH V2] drm/buddy: Integrate lockdep annotations for gpu buddy
 manager
Date: Fri,  8 May 2026 12:25:45 +0530
Message-ID: <20260508065544.4049240-2-tejas.upadhyay@intel.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
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

gpu_buddy APIs are expected to be called with the driver-provided lock
held, but there is no runtime enforcement of this contract. Add lockdep
annotations to catch locking violations early.

Introduce gpu_buddy_driver_set_lock() for the driver to register the
lock that protects the buddy manager. Add gpu_buddy_driver_lock_held()
assertions to all exported gpu_buddy and drm_buddy APIs that
access/modify the manager state. The lock_dep_map field is only compiled
in when CONFIG_LOCKDEP is enabled, adding zero overhead to production
builds.

Wire up xe_ttm_vram_mgr to register its mutex with the buddy manager
after initialization.

Assisted-by: Copilot:claude-opus-4.6
Suggested-by: Matthew Brost <matthew.brost@intel.com>
Signed-off-by: Tejas Upadhyay <tejas.upadhyay@intel.com>
Reviewed-by: Matthew Auld <matthew.auld@intel.com>
---
 drivers/gpu/buddy.c                  | 11 ++++++++
 drivers/gpu/drm/drm_buddy.c          |  1 +
 drivers/gpu/drm/xe/xe_ttm_vram_mgr.c |  1 +
 include/linux/gpu_buddy.h            | 41 ++++++++++++++++++++++++++++
 4 files changed, 54 insertions(+)

diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
index 52686672e99f..eb1457376307 100644
--- a/drivers/gpu/buddy.c
+++ b/drivers/gpu/buddy.c
@@ -437,6 +437,9 @@ int gpu_buddy_init(struct gpu_buddy *mm, u64 size, u64 chunk_size)
 		root_count++;
 	} while (size);
 
+#ifdef CONFIG_LOCKDEP
+	mm->lock_dep_map = NULL;
+#endif
 	return 0;
 
 out_free_roots:
@@ -538,6 +541,7 @@ void gpu_buddy_reset_clear(struct gpu_buddy *mm, bool is_clear)
 	unsigned int order;
 	int i;
 
+	gpu_buddy_driver_lock_held(mm);
 	size = mm->size;
 	for (i = 0; i < mm->n_roots; ++i) {
 		order = ilog2(size) - ilog2(mm->chunk_size);
@@ -580,6 +584,7 @@ EXPORT_SYMBOL(gpu_buddy_reset_clear);
 void gpu_buddy_free_block(struct gpu_buddy *mm,
 			  struct gpu_buddy_block *block)
 {
+	gpu_buddy_driver_lock_held(mm);
 	BUG_ON(!gpu_buddy_block_is_allocated(block));
 	mm->avail += gpu_buddy_block_size(mm, block);
 	if (gpu_buddy_block_is_clear(block))
@@ -633,6 +638,7 @@ void gpu_buddy_free_list(struct gpu_buddy *mm,
 {
 	bool mark_clear = flags & GPU_BUDDY_CLEARED;
 
+	gpu_buddy_driver_lock_held(mm);
 	__gpu_buddy_free_list(mm, objects, mark_clear, !mark_clear);
 }
 EXPORT_SYMBOL(gpu_buddy_free_list);
@@ -1172,6 +1178,8 @@ int gpu_buddy_block_trim(struct gpu_buddy *mm,
 	u64 new_start;
 	int err;
 
+	gpu_buddy_driver_lock_held(mm);
+
 	if (!list_is_singular(blocks))
 		return -EINVAL;
 
@@ -1287,6 +1295,8 @@ int gpu_buddy_alloc_blocks(struct gpu_buddy *mm,
 	unsigned long pages;
 	int err;
 
+	gpu_buddy_driver_lock_held(mm);
+
 	if (size < mm->chunk_size)
 		return -EINVAL;
 
@@ -1475,6 +1485,7 @@ void gpu_buddy_print(struct gpu_buddy *mm)
 {
 	int order;
 
+	gpu_buddy_driver_lock_held(mm);
 	pr_info("chunk_size: %lluKiB, total: %lluMiB, free: %lluMiB, clear_free: %lluMiB\n",
 		mm->chunk_size >> 10, mm->size >> 20, mm->avail >> 20, mm->clear_avail >> 20);
 
diff --git a/drivers/gpu/drm/drm_buddy.c b/drivers/gpu/drm/drm_buddy.c
index 841f3de5f307..faa025498de4 100644
--- a/drivers/gpu/drm/drm_buddy.c
+++ b/drivers/gpu/drm/drm_buddy.c
@@ -42,6 +42,7 @@ void drm_buddy_print(struct gpu_buddy *mm, struct drm_printer *p)
 {
 	int order;
 
+	gpu_buddy_driver_lock_held(mm);
 	drm_printf(p, "chunk_size: %lluKiB, total: %lluMiB, free: %lluMiB, clear_free: %lluMiB\n",
 		   mm->chunk_size >> 10, mm->size >> 20, mm->avail >> 20, mm->clear_avail >> 20);
 
diff --git a/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c b/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c
index 6ba47996bc7c..9f67df646955 100644
--- a/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c
+++ b/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c
@@ -322,6 +322,7 @@ int __xe_ttm_vram_mgr_init(struct xe_device *xe, struct xe_ttm_vram_mgr *mgr,
 	if (err)
 		return err;
 
+	gpu_buddy_driver_set_lock(&mgr->mm, &mgr->lock);
 	ttm_set_driver_manager(&xe->ttm, mem_type, &mgr->manager);
 	ttm_resource_manager_set_used(&mgr->manager, true);
 
diff --git a/include/linux/gpu_buddy.h b/include/linux/gpu_buddy.h
index 5fa917ba5450..71941a039648 100644
--- a/include/linux/gpu_buddy.h
+++ b/include/linux/gpu_buddy.h
@@ -154,6 +154,7 @@ struct gpu_buddy_block {
  * @avail: Total free space currently available for allocation in bytes.
  * @clear_avail: Free space available in the clear tree (zeroed memory) in bytes.
  *               This is a subset of @avail.
+ * @lock_dep_map: Annotates gpu_buddy API with a driver provided lock.
  */
 struct gpu_buddy {
 /* private: */
@@ -179,8 +180,48 @@ struct gpu_buddy {
 	u64 size;
 	u64 avail;
 	u64 clear_avail;
+#ifdef CONFIG_LOCKDEP
+	struct lockdep_map *lock_dep_map;
+#endif
 };
 
+#ifdef CONFIG_LOCKDEP
+/**
+ * gpu_buddy_driver_set_lock() - Set the lock protecting accesses to GPU BUDDY
+ * @mm: Pointer to GPU buddy structure.
+ * @lock: the lock used to protect the gpu buddy. The locking primitive
+ * must contain a dep_map field.
+ *
+ * Call this to annotate gpu_buddy APIs which access/modify gpu_buddy manager
+ */
+#define gpu_buddy_driver_set_lock(mm, lock) \
+	do { \
+		struct gpu_buddy *__mm = (mm); \
+		if (!WARN(__mm->lock_dep_map, "GPU BUDDY MM lock should be set only once.")) \
+			__mm->lock_dep_map = &(lock)->dep_map; \
+	} while (0)
+#else
+#define gpu_buddy_driver_set_lock(mm, lock) do { (void)(mm); (void)(lock); } while (0)
+#endif
+
+#ifdef CONFIG_LOCKDEP
+/**
+ * gpu_buddy_driver_lock_held() - Assert GPU BUDDY manager lock is held
+ * @mm: Pointer to the GPU BUDDY structure.
+ *
+ * Ensure driver lock is held.
+ */
+static inline void gpu_buddy_driver_lock_held(struct gpu_buddy *mm)
+{
+	if (mm->lock_dep_map)
+		lockdep_assert(lock_is_held_type(mm->lock_dep_map, 0));
+}
+#else
+static inline void gpu_buddy_driver_lock_held(struct gpu_buddy *mm)
+{
+}
+#endif
+
 static inline u64
 gpu_buddy_block_offset(const struct gpu_buddy_block *block)
 {
-- 
2.52.0

