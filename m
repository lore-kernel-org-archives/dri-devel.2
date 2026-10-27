Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DE8606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 20:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TTZC2b2F
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B48610F829;
	Tue, 27 Oct 2026 20:31:35 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E7B210F823;
 Tue, 27 Oct 2026 20:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793133084; x=1824669084;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=nLWx8wNJDuqKdzxyWN1uIwnbD7KLmtdFbBE3i9zUayU=;
 b=TTZC2b2F5CpRF0BJ1rlvSHLTYzz0QOsP8aeJ/6BeBSlIJsDBdBDIAicF
 6oPb+KkhKcoQoXxnGN4etr9qQpldBvC2fUEmKni5RmvlkypzaF71+jNeG
 2kJIWtWW3pnONZDGoUXAGX0YD3r7AM5TcU49wj+uwh8AvSM2qYhk0Rf9S
 z3XjBsQwWd2/y56QihdM0k9HfGg02ouRdtX+uMnoUIiwKJJ3q7P/tFD1P
 Dwv5xucK2jWfn8S1ns66DoN7F0Ls9q0xb+AYWUeZGYyEvrwoTQEkSGLJT
 FRipSqNK4UlN2gHMjGK3fr1aQHf7AkzMXx/bLkoJr8crLF/T91aJ1hNfZ Q==;
X-CSE-ConnectionGUID: TTEoCHRSRdm8XouCm55PnA==
X-CSE-MsgGUID: R9/z++FoT1+PFpoPpzK2Og==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1832110"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1832110"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2026 13:31:13 -0700
X-CSE-ConnectionGUID: gNCqUfURRbmzKpUoZh1LVQ==
X-CSE-MsgGUID: 4waR9ba5TjSE9LRE06g22A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="5035066"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2026 13:31:13 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v5 3/3] drm/xe: Add a minimum age gate to the shrinker
Date: Tue, 27 Oct 2026 13:31:07 -0700
Message-Id: <20261027203107.1065800-4-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261027203107.1065800-1-matthew.brost@intel.com>
References: <20261027203107.1065800-1-matthew.brost@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Backing up a BO costs a GPU blit plus a page copy, and if the BO is part
of an active working set it is faulted straight back in on the next exec.
Evicting a BO that was used moments ago is therefore almost always a
loss, yet the shrinker has no notion of recency beyond LRU order.

Timestamp BOs wherever their LRU position is updated, and read the stamp
back from whatever owns that position. A BO in a VM's bulk move is
anchored inside its range, so it is aged by the VM-wide stamp taken in
xe_vm_bump_lru() alongside the bulk move itself. Any other BO carries
its own, stamped there too and on a successful move into TT in
xe_bo_move(), where ttm_resource_alloc() has already placed the new
resource at the LRU tail.

Add a per-device shrinker_min_age_ms sysfs attribute, defaulting to
CONFIG_DRM_XE_SHRINKER_MIN_AGE_MS (0, disabled). While set, the shrinker
won't back up BOs younger than the delay. Each LRU priority is roughly
age ordered, so the gate is applied per priority: xe_shrinker_count()
snoops the first shrinkable BO of each priority and reports nothing only
if all of them are young, and the backup walk skips to the next priority
at the first young BO, both as a backstop for the count sample and so a
hot priority doesn't shield colder BOs in another one.

Only BOs this shrinker would actually back up have a say. BOs in
XE_PL_SYSTEM, which are not GPU mapped and hence not part of a working
set, and BOs xe_bo_shrink() rejects outright are never young. Purgeable
BOs and those advised DONTNEED are neither: they are dropped rather than
backed up and accounted to the purgeable shrinker, so they are never
young and the count snoop skips their XE_BO_PRIORITY_LOW band entirely.

The gate is hard and applies at every reclaim priority, so a working set
kept younger than the delay is never backed up and can lead to OOM. This
is deliberate, and why it is off by default.

Assisted-by: LLM
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
---
 drivers/gpu/drm/xe/Kconfig.profile   |  15 +++
 drivers/gpu/drm/xe/xe_bo.c           |  83 ++++++++++++++
 drivers/gpu/drm/xe/xe_bo.h           |   5 +
 drivers/gpu/drm/xe/xe_bo_types.h     |   8 ++
 drivers/gpu/drm/xe/xe_device_sysfs.c |  35 ++++++
 drivers/gpu/drm/xe/xe_pagefault.c    |   2 +-
 drivers/gpu/drm/xe/xe_shrinker.c     | 164 +++++++++++++++++++++++++--
 drivers/gpu/drm/xe/xe_shrinker.h     |   3 +
 drivers/gpu/drm/xe/xe_vm.c           |   4 +-
 drivers/gpu/drm/xe/xe_vm_types.h     |   8 ++
 10 files changed, 316 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/xe/Kconfig.profile b/drivers/gpu/drm/xe/Kconfig.profile
index 23045ed2aa94..dd3985e502b8 100644
--- a/drivers/gpu/drm/xe/Kconfig.profile
+++ b/drivers/gpu/drm/xe/Kconfig.profile
@@ -74,6 +74,7 @@ config DRM_XE_ENABLE_SCHEDTIMEOUT_LIMIT
 	  to apply to applicable user. For elevated user, all above MIN
 	  and MAX values will apply when this configuration is enable to
 	  apply limitation. By default limitation is applied.
+
 config DRM_XE_SHRINKER_NON_PURGEABLE_SEEKS
 	int "Default seeks value of the non-purgeable bo shrinker"
 	default 8
@@ -86,3 +87,17 @@ config DRM_XE_SHRINKER_NON_PURGEABLE_SEEKS
 	  reclaim pressure on non-purgeable buffer objects, which need
 	  GPU idling and writeback to be reclaimed, in favour of purgeable
 	  ones and other kernel caches.
+
+config DRM_XE_SHRINKER_MIN_AGE_MS
+	int "Default minimum BO age before shrinker backup (ms)"
+	default 0
+	range 0 1000000
+	help
+	  Default for the per-device shrinker_min_age_ms sysfs attribute. The
+	  shrinker won't back up a BO that was moved into TT, or bumped on the
+	  LRU by an exec, less than this many milliseconds ago. BOs already
+	  evicted to system memory are not part of a working set and are
+	  never protected. This applies at every reclaim priority: a working
+	  set kept younger than this is never backed up and can cause OOM.
+	  Only set if that risk is preferred over thrashing a hot working
+	  set. 0 disables.
diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
index 42a6aa1a2e4a..a4c0c6284a24 100644
--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -1357,9 +1357,92 @@ static int xe_bo_move(struct ttm_buffer_object *ttm_bo, bool evict,
 		xe_tt_unmap_sg(xe, ttm_bo->ttm);
 	}
 
+	/*
+	 * ttm_resource_alloc() already placed the new resource at the tail of
+	 * its LRU, or of @bo's bulk move, so only record when that happened.
+	 */
+	if (!ret && ttm_bo->resource && ttm_bo->resource->mem_type == XE_PL_TT)
+		WRITE_ONCE(bo->lru_stamp, jiffies);
+
 	return ret;
 }
 
+/**
+ * xe_bo_bump_lru_locked() - Bump a BO on the LRU and stamp its last use
+ * @bo: The buffer object, reserved by the caller.
+ *
+ * Move @bo to the tail of its LRU and record the time for the shrinker's
+ * minimum age gate. Only meaningful for BOs outside a bulk move, since a
+ * BO in one is anchored inside its range and is bumped, and aged, with it.
+ * The caller must hold the device LRU lock.
+ */
+void xe_bo_bump_lru_locked(struct xe_bo *bo)
+{
+	WRITE_ONCE(bo->lru_stamp, jiffies);
+	ttm_bo_move_to_lru_tail(&bo->ttm);
+}
+
+/**
+ * xe_bo_shrink_backup_candidate() - Whether the shrinker may back up a BO
+ * @bo: The TTM buffer object, reserved by the caller.
+ *
+ * A BO is a backup candidate if backing it up is the only way to reclaim it.
+ * BOs advised DONTNEED, which sit at XE_BO_PRIORITY_LOW, and purgeable ones
+ * are not: their pages are simply dropped, which is cheap, and they are
+ * accounted to the purgeable shrinker. Neither are the BOs xe_bo_shrink()
+ * hands to xe_bo_shrink_purge() outright: ghost BOs, which aren't xe BOs,
+ * and BOs already freed and waiting to be reaped. Nor are BOs whose tt
+ * isn't TTM_TT_FLAG_EXTERNAL_MAPPABLE, which xe_bo_shrink() rejects.
+ *
+ * Return: true if @bo would be backed up by a non-purge shrink pass.
+ */
+bool xe_bo_shrink_backup_candidate(struct ttm_buffer_object *bo)
+{
+	struct xe_ttm_tt *xe_tt;
+
+	if (!xe_bo_is_xe_bo(bo) || !kref_read(&bo->base.refcount) || !bo->ttm ||
+	    !(bo->ttm->page_flags & TTM_TT_FLAG_EXTERNAL_MAPPABLE) ||
+	    bo->priority <= XE_BO_PRIORITY_LOW)
+		return false;
+
+	xe_tt = container_of(bo->ttm, struct xe_ttm_tt, ttm);
+
+	return !xe_tt->purgeable;
+}
+
+/**
+ * xe_bo_shrink_too_young() - Whether a BO was used too recently to shrink
+ * @bo: The TTM buffer object, reserved by the caller.
+ * @min_age: Minimum age in jiffies. 0 disables the check.
+ *
+ * The age is taken from whatever owns @bo's LRU position: &xe_vm.lru_stamp
+ * if @bo rides along with a VM's bulk move, its own &xe_bo.lru_stamp if not.
+ *
+ * BOs that the shrink walk would not back up anyway are never considered
+ * young, see xe_bo_shrink_backup_candidate(). Neither are BOs in
+ * XE_PL_SYSTEM: they are not GPU mapped, hence not part of a working set,
+ * and must be moved back to TT, refreshing the stamp, before use.
+ *
+ * Return: true if @bo was touched less than @min_age jiffies ago.
+ */
+bool xe_bo_shrink_too_young(struct ttm_buffer_object *bo, unsigned long min_age)
+{
+	struct xe_bo *xe_bo;
+	unsigned long stamp;
+
+	if (!min_age || bo->resource->mem_type == XE_PL_SYSTEM ||
+	    !xe_bo_shrink_backup_candidate(bo))
+		return false;
+
+	xe_bo = ttm_to_xe_bo(bo);
+	if (bo->bulk_move && xe_bo->vm)
+		stamp = READ_ONCE(xe_bo->vm->lru_stamp);
+	else
+		stamp = READ_ONCE(xe_bo->lru_stamp);
+
+	return stamp && time_before(jiffies, stamp + min_age);
+}
+
 static long xe_bo_shrink_purge(struct ttm_operation_ctx *ctx,
 			       struct ttm_buffer_object *bo,
 			       unsigned long *scanned)
diff --git a/drivers/gpu/drm/xe/xe_bo.h b/drivers/gpu/drm/xe/xe_bo.h
index 77b3a02e9b8e..65d4c638e8d8 100644
--- a/drivers/gpu/drm/xe/xe_bo.h
+++ b/drivers/gpu/drm/xe/xe_bo.h
@@ -623,6 +623,11 @@ struct xe_bo_shrink_flags {
 	u32 writeback : 1;
 };
 
+void xe_bo_bump_lru_locked(struct xe_bo *bo);
+
+bool xe_bo_shrink_backup_candidate(struct ttm_buffer_object *bo);
+bool xe_bo_shrink_too_young(struct ttm_buffer_object *bo, unsigned long min_age);
+
 long xe_bo_shrink(struct ttm_operation_ctx *ctx, struct ttm_buffer_object *bo,
 		  const struct xe_bo_shrink_flags flags,
 		  unsigned long *scanned);
diff --git a/drivers/gpu/drm/xe/xe_bo_types.h b/drivers/gpu/drm/xe/xe_bo_types.h
index 0265fb314c77..f63b668c7134 100644
--- a/drivers/gpu/drm/xe/xe_bo_types.h
+++ b/drivers/gpu/drm/xe/xe_bo_types.h
@@ -49,6 +49,14 @@ struct xe_bo {
 	u32 flags;
 	/** @vm: VM this BO is attached to, for extobj this will be NULL */
 	struct xe_vm *vm;
+	/**
+	 * @lru_stamp: jiffies at the last LRU bump, done on a move into TT
+	 * and at exec time. Only describes the LRU position of a BO outside
+	 * a bulk move; BOs in one are aged by &xe_vm.lru_stamp instead.
+	 * Consulted by the shrinker's minimum age gate. Accessed with
+	 * READ_ONCE()/WRITE_ONCE().
+	 */
+	unsigned long lru_stamp;
 	/**
 	 * @q: Queue this BO is attached to, mostly for LRC BO, NULL otherwise.
 	 * Protected by the BO dma_resv: readers must hold it across both the
diff --git a/drivers/gpu/drm/xe/xe_device_sysfs.c b/drivers/gpu/drm/xe/xe_device_sysfs.c
index ff5d25dd867c..26b1f71ed522 100644
--- a/drivers/gpu/drm/xe/xe_device_sysfs.c
+++ b/drivers/gpu/drm/xe/xe_device_sysfs.c
@@ -38,6 +38,12 @@
  * reclaimed by the shrinker. Higher values reduce reclaim pressure on
  * non-purgeable buffer objects. Valid values are 1 to 64. Defaults to
  * CONFIG_DRM_XE_SHRINKER_NON_PURGEABLE_SEEKS.
+ *
+ * shrinker_min_age_ms - Report/change the minimum time, in ms, since a BO was
+ * last moved to TT or bumped on the LRU by an exec before the shrinker may
+ * back it up. BOs evicted to system memory are never protected. Defaults to
+ * CONFIG_DRM_XE_SHRINKER_MIN_AGE_MS, 0 disables. This applies at every
+ * reclaim priority, so a non-zero value can lead to OOM.
  */
 
 static ssize_t
@@ -331,8 +337,37 @@ shrinker_non_purgeable_seeks_store(struct device *dev,
 
 static DEVICE_ATTR_RW(shrinker_non_purgeable_seeks);
 
+static ssize_t
+shrinker_min_age_ms_show(struct device *dev, struct device_attribute *attr,
+			 char *buf)
+{
+	struct xe_device *xe = pdev_to_xe_device(to_pci_dev(dev));
+
+	return sysfs_emit(buf, "%u\n", xe_shrinker_min_age_ms(xe->mem.shrinker));
+}
+
+static ssize_t
+shrinker_min_age_ms_store(struct device *dev, struct device_attribute *attr,
+			  const char *buff, size_t count)
+{
+	struct xe_device *xe = pdev_to_xe_device(to_pci_dev(dev));
+	unsigned int ms;
+	int ret;
+
+	ret = kstrtouint(buff, 0, &ms);
+	if (ret)
+		return ret;
+
+	xe_shrinker_set_min_age_ms(xe->mem.shrinker, ms);
+
+	return count;
+}
+
+static DEVICE_ATTR_RW(shrinker_min_age_ms);
+
 static struct attribute *shrinker_attrs[] = {
 	&dev_attr_shrinker_non_purgeable_seeks.attr,
+	&dev_attr_shrinker_min_age_ms.attr,
 	NULL
 };
 
diff --git a/drivers/gpu/drm/xe/xe_pagefault.c b/drivers/gpu/drm/xe/xe_pagefault.c
index 7d363160103a..8e25bc67772e 100644
--- a/drivers/gpu/drm/xe/xe_pagefault.c
+++ b/drivers/gpu/drm/xe/xe_pagefault.c
@@ -225,7 +225,7 @@ static int xe_pagefault_handle_vma(struct xe_gt *gt, struct xe_vma *vma,
 			}
 
 			if (bo)
-				ttm_bo_move_to_lru_tail(&bo->ttm);
+				xe_bo_bump_lru_locked(bo);
 		}
 		xe_validation_ctx_fini(&ctx);
 	} while (err == -EAGAIN);
diff --git a/drivers/gpu/drm/xe/xe_shrinker.c b/drivers/gpu/drm/xe/xe_shrinker.c
index c86455ea08d1..c650726ff6de 100644
--- a/drivers/gpu/drm/xe/xe_shrinker.c
+++ b/drivers/gpu/drm/xe/xe_shrinker.c
@@ -39,6 +39,8 @@
  * @shrink: Pointer to the mm shrinker handling non-purgeable (shrinkable) objects.
  * @purge_shrink: Pointer to the mm shrinker handling purgeable objects.
  * @pm_worker: Worker to wake up the device if required.
+ * @min_age_ms: Minimum BO age before backup, in ms. 0 disables. Defaults to
+ * CONFIG_DRM_XE_SHRINKER_MIN_AGE_MS, overridable through sysfs.
  */
 struct xe_shrinker {
 	struct xe_device *xe;
@@ -50,6 +52,7 @@ struct xe_shrinker {
 	struct shrinker *shrink;
 	struct shrinker *purge_shrink;
 	struct work_struct pm_worker;
+	unsigned int min_age_ms;
 };
 
 static struct xe_shrinker *to_xe_shrinker(struct shrinker *shrink)
@@ -104,6 +107,7 @@ static void xe_shrinker_runtime_pm_put(struct xe_shrinker *shrinker, bool runtim
 static int __xe_shrinker_walk(struct xe_shrinker *shrinker,
 			      struct ttm_operation_ctx *ctx,
 			      const struct xe_bo_shrink_flags flags,
+			      unsigned long min_age,
 			      unsigned long to_scan, unsigned long *scanned,
 			      unsigned long *freed)
 {
@@ -139,6 +143,16 @@ static int __xe_shrinker_walk(struct xe_shrinker *shrinker,
 			if (!ttm_bo_shrink_suitable(ttm_bo, ctx))
 				continue;
 
+			/*
+			 * Each LRU priority is roughly age ordered, so the
+			 * rest of this priority is most likely young too.
+			 * Move on to the next priority.
+			 */
+			if (xe_bo_shrink_too_young(ttm_bo, min_age)) {
+				ttm_bo_lru_cursor_skip_priority(&curs);
+				continue;
+			}
+
 			lret = xe_bo_shrink(ctx, ttm_bo, flags, scanned);
 			/* Like the TTM LRU walk, skip bos we can't shrink now. */
 			if (lret == -EBUSY)
@@ -171,6 +185,7 @@ static int __xe_shrinker_walk(struct xe_shrinker *shrinker,
 static int xe_shrinker_walk(struct xe_shrinker *shrinker,
 			    struct ttm_operation_ctx *ctx,
 			    const struct xe_bo_shrink_flags flags,
+			    unsigned long min_age,
 			    unsigned long to_scan, unsigned long *scanned,
 			    unsigned long *freed)
 {
@@ -180,26 +195,126 @@ static int xe_shrinker_walk(struct xe_shrinker *shrinker,
 
 	swap(no_wait_gpu, ctx->no_wait_gpu);
 	save_flags.writeback = false;
-	ret = __xe_shrinker_walk(shrinker, ctx, save_flags, to_scan, scanned,
-				 freed);
+	ret = __xe_shrinker_walk(shrinker, ctx, save_flags, min_age,
+				 to_scan, scanned, freed);
 	swap(no_wait_gpu, ctx->no_wait_gpu);
 	if (ret || *scanned >= to_scan)
 		return ret;
 
 	if (!ctx->no_wait_gpu) {
-		ret = __xe_shrinker_walk(shrinker, ctx, save_flags, to_scan, scanned,
-					 freed);
+		ret = __xe_shrinker_walk(shrinker, ctx, save_flags, min_age,
+					 to_scan, scanned, freed);
 		if (ret || *scanned >= to_scan)
 			return ret;
 	}
 
 	if (flags.writeback)
-		ret = __xe_shrinker_walk(shrinker, ctx, flags, to_scan, scanned,
-					 freed);
+		ret = __xe_shrinker_walk(shrinker, ctx, flags, min_age,
+					 to_scan, scanned, freed);
 
 	return ret;
 }
 
+/**
+ * DOC: Shrinker minimum age
+ *
+ * The per-device shrinker_min_age_ms sysfs attribute, defaulting to
+ * CONFIG_DRM_XE_SHRINKER_MIN_AGE_MS, protects recently used BOs from backup.
+ * A BO's age is taken from whatever owns its position on the LRU, and is
+ * stamped wherever that position is updated: the VM-wide stamp for a BO
+ * riding along with a VM's bulk move, bumped on exec in xe_vm_bump_lru(),
+ * its own stamp otherwise, bumped there as well and on a move into TT in
+ * xe_bo_move(). BOs in XE_PL_SYSTEM are never young: they are not GPU
+ * mapped, so not part of a working set, and will be stamped again when
+ * moved back to TT for use.
+ *
+ * The gate is applied per LRU priority, each of which is roughly age
+ * ordered. xe_shrinker_count() snoops the first shrinkable BO of each
+ * priority on each TT-backed LRU. Only if all of them are young does it stop
+ * reporting shrinkable pages; anything else, including reaching no verdict
+ * at all, lets it report. The backup walk in xe_shrinker_scan() skips to the
+ * next priority at the first young BO, as a backstop since the count snoop
+ * is only a sample. A hot priority thus doesn't shield colder BOs in another
+ * priority. BOs that aren't backed up anyway have no say either way: those
+ * in XE_PL_SYSTEM are never young, and purgeable and DONTNEED ones, which
+ * belong to the purgeable shrinker, are ignored by the snoop entirely.
+ *
+ * The gate is hard and applies at every reclaim priority. A working set kept
+ * younger than the delay is never backed up, which can lead to OOM. This is
+ * intended for users who prefer that risk over thrashing a hot working set,
+ * hence it is disabled by default.
+ */
+static unsigned long xe_shrinker_min_age(struct xe_shrinker *shrinker)
+{
+	unsigned int ms = READ_ONCE(shrinker->min_age_ms);
+
+	return ms ? msecs_to_jiffies(ms) : 0;
+}
+
+/* Max shrink-unsuitable BOs to skip per LRU before giving up the snoop. */
+#define XE_SHRINKER_SNOOP_MAX	16
+
+/*
+ * Whether the first BO of every priority on every TT-backed LRU that this
+ * shrinker would back up is younger than @min_age. BOs are trylocked through
+ * the reserved LRU walker since their tt may be torn down while still on the
+ * LRU. Contended BOs are skipped by the walker, and may be all of them. If no
+ * verdict can be reached, because nothing was inspected or the snoop budget
+ * ran out, report not young and leave it to the scan side check.
+ */
+static bool xe_shrinker_lru_young(struct xe_shrinker *shrinker,
+				  unsigned long min_age)
+{
+	struct ttm_operation_ctx ctx = {
+		.interruptible = false,
+		.no_wait_gpu = false,
+	};
+	struct xe_device *xe = shrinker->xe;
+	unsigned int mem_type;
+	bool young = false;
+
+	for (mem_type = XE_PL_SYSTEM; mem_type <= XE_PL_TT; ++mem_type) {
+		struct ttm_resource_manager *man = ttm_manager_type(&xe->ttm, mem_type);
+		struct ttm_bo_lru_cursor curs;
+		struct ttm_buffer_object *ttm_bo;
+		struct ttm_lru_walk_arg arg = {
+			.ctx = &ctx,
+			.trylock_only = true,
+		};
+		unsigned int budget = XE_SHRINKER_SNOOP_MAX;
+
+		if (!man || !man->use_tt)
+			continue;
+
+		ttm_bo_lru_for_each_reserved_guarded(&curs, man, &arg, ttm_bo) {
+			/*
+			 * Nothing in the DONTNEED band is backed up, and it
+			 * is accounted to the purgeable shrinker, so it has
+			 * no say here. Skip the whole band in one go.
+			 */
+			if (ttm_bo->priority <= XE_BO_PRIORITY_LOW) {
+				ttm_bo_lru_cursor_skip_priority(&curs);
+				continue;
+			}
+
+			if (!ttm_bo_shrink_suitable(ttm_bo, &ctx) ||
+			    !xe_bo_shrink_backup_candidate(ttm_bo)) {
+				if (!--budget)
+					return false;
+				continue;
+			}
+
+			if (!xe_bo_shrink_too_young(ttm_bo, min_age))
+				return false;
+
+			young = true;
+			ttm_bo_lru_cursor_skip_priority(&curs);
+		}
+	}
+
+	return young;
+}
+
 static unsigned long
 xe_shrinker_count_purgeable(struct shrinker *shrink, struct shrink_control *sc)
 {
@@ -239,7 +354,7 @@ static unsigned long
 xe_shrinker_count(struct shrinker *shrink, struct shrink_control *sc)
 {
 	struct xe_shrinker *shrinker = to_xe_shrinker(shrink);
-	unsigned long num_pages;
+	unsigned long num_pages, min_age;
 	bool can_backup = !!(sc->gfp_mask & __GFP_FS);
 
 	if (!can_backup)
@@ -263,6 +378,10 @@ xe_shrinker_count(struct shrinker *shrink, struct shrink_control *sc)
 
 	write_unlock(&shrinker->lock);
 
+	min_age = xe_shrinker_min_age(shrinker);
+	if (num_pages && min_age && xe_shrinker_lru_young(shrinker, min_age))
+		return SHRINK_EMPTY;
+
 	return num_pages ? num_pages : SHRINK_EMPTY;
 }
 
@@ -297,7 +416,8 @@ static unsigned long xe_shrinker_scan_purgeable(struct shrinker *shrink,
 		.purge = true,
 	};
 
-	xe_shrinker_walk(shrinker, &ctx, shrink_flags, nr_to_scan, &nr_scanned, &freed);
+	xe_shrinker_walk(shrinker, &ctx, shrink_flags, 0, nr_to_scan, &nr_scanned,
+			 &freed);
 
 	sc->nr_scanned = nr_scanned;
 
@@ -322,7 +442,9 @@ static unsigned long xe_shrinker_scan(struct shrinker *shrink, struct shrink_con
 	/* Might need runtime PM to access backed-up or CCS-compressed data. */
 	runtime_pm = xe_shrinker_runtime_pm_get(shrinker);
 
-	xe_shrinker_walk(shrinker, &ctx, shrink_flags, nr_to_scan, &nr_scanned, &freed);
+	xe_shrinker_walk(shrinker, &ctx, shrink_flags,
+			 xe_shrinker_min_age(shrinker), nr_to_scan, &nr_scanned,
+			 &freed);
 
 	sc->nr_scanned = nr_scanned;
 	xe_shrinker_runtime_pm_put(shrinker, runtime_pm);
@@ -387,6 +509,29 @@ int xe_shrinker_set_non_purgeable_seeks(struct xe_shrinker *shrinker,
 	return 0;
 }
 
+/**
+ * xe_shrinker_min_age_ms() - Get the shrinker minimum BO age
+ * @shrinker: Pointer to the struct xe_shrinker.
+ *
+ * Return: Minimum age, in ms, a BO must reach before it may be backed up.
+ */
+unsigned int xe_shrinker_min_age_ms(struct xe_shrinker *shrinker)
+{
+	return READ_ONCE(shrinker->min_age_ms);
+}
+
+/**
+ * xe_shrinker_set_min_age_ms() - Set the shrinker minimum BO age
+ * @shrinker: Pointer to the struct xe_shrinker.
+ * @ms: Minimum age, in ms. 0 disables the gate.
+ *
+ * See DOC: Shrinker minimum age. A non-zero value can lead to OOM.
+ */
+void xe_shrinker_set_min_age_ms(struct xe_shrinker *shrinker, unsigned int ms)
+{
+	WRITE_ONCE(shrinker->min_age_ms, ms);
+}
+
 /**
  * xe_shrinker_create() - Create an xe per-device shrinker
  * @xe: Pointer to the xe device.
@@ -415,6 +560,7 @@ int xe_shrinker_create(struct xe_device *xe)
 
 	INIT_WORK(&shrinker->pm_worker, xe_shrinker_pm);
 	shrinker->xe = xe;
+	shrinker->min_age_ms = CONFIG_DRM_XE_SHRINKER_MIN_AGE_MS;
 	rwlock_init(&shrinker->lock);
 
 	shrinker->purge_shrink->count_objects = xe_shrinker_count_purgeable;
diff --git a/drivers/gpu/drm/xe/xe_shrinker.h b/drivers/gpu/drm/xe/xe_shrinker.h
index 4b3c73689619..586d7772bd58 100644
--- a/drivers/gpu/drm/xe/xe_shrinker.h
+++ b/drivers/gpu/drm/xe/xe_shrinker.h
@@ -18,4 +18,7 @@ int xe_shrinker_non_purgeable_seeks(struct xe_shrinker *shrinker);
 int xe_shrinker_set_non_purgeable_seeks(struct xe_shrinker *shrinker,
 					unsigned int seeks);
 
+unsigned int xe_shrinker_min_age_ms(struct xe_shrinker *shrinker);
+void xe_shrinker_set_min_age_ms(struct xe_shrinker *shrinker, unsigned int ms);
+
 #endif
diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index 86c3b4fd232f..583c55b7f97d 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -463,13 +463,15 @@ void xe_vm_bump_lru(struct xe_vm *vm, struct drm_exec *exec)
 	spinlock_t *lru_lock = &vm->xe->ttm.lru_lock;
 	struct drm_gem_object *obj;
 
+	WRITE_ONCE(vm->lru_stamp, jiffies);
+
 	spin_lock(lru_lock);
 	ttm_lru_bulk_move_tail(&vm->lru_bulk_move);
 	drm_exec_for_each_locked_object(exec, obj) {
 		if (!drm_gpuvm_is_extobj(&vm->gpuvm, obj))
 			continue;
 
-		ttm_bo_move_to_lru_tail(&gem_to_xe_bo(obj)->ttm);
+		xe_bo_bump_lru_locked(gem_to_xe_bo(obj));
 		cond_resched_lock(lru_lock);
 	}
 	spin_unlock(lru_lock);
diff --git a/drivers/gpu/drm/xe/xe_vm_types.h b/drivers/gpu/drm/xe/xe_vm_types.h
index fb9305124679..046505a285e9 100644
--- a/drivers/gpu/drm/xe/xe_vm_types.h
+++ b/drivers/gpu/drm/xe/xe_vm_types.h
@@ -267,6 +267,14 @@ struct xe_vm {
 	/** @lru_bulk_move: Bulk LRU move list for this VM's BOs */
 	struct ttm_lru_bulk_move lru_bulk_move;
 
+	/**
+	 * @lru_stamp: jiffies at the last xe_vm_bump_lru(), which is where
+	 * @lru_bulk_move is moved to the LRU tail. Ages every BO in that
+	 * bulk move for the shrinker's minimum age gate. Accessed with
+	 * READ_ONCE()/WRITE_ONCE().
+	 */
+	unsigned long lru_stamp;
+
 	u64 size;
 
 	struct xe_pt *pt_root[XE_MAX_TILES_PER_DEVICE];
-- 
2.34.1

