Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 508F7FF886F
	for <dri-devel@archiver.kernel.org>; Fri,  1 May 2026 01:19:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2005010E4CC;
	Fri,  1 May 2026 01:19:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="PPgveD2J";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 080BA10E1BB;
 Fri,  1 May 2026 01:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777598354; x=1809134354;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Ad7r6hUJoWAvuJ8c4PbDIgjjLdP4pUdKNvUZ0YQinEk=;
 b=PPgveD2Js1yMwG6qgjCnaVi99BVnQZDJun8Tc182icATWBghqwBieUzP
 zmDQlqONcVe8mZNIGTdZcEnc9C0GSMt2p1TlmSR12/BauM5dGN40ESqyO
 Uso++0YyIA/uOkVhbv9jOAdY2p8DN9nbQW2Y/XDrxWlpImRLlOChu9m+c
 NC4H4i2WgBRQqNBYTUk7zs5iAz01lJPaUE4QcwKuIE2EjPxduTvcxqxSW
 Oxr5GC/SipWrEgFheDlgLgfASYGqnN+yKq6Nr08UhFPnlUJhJcJIY6Avf
 PT0tBDikWYWFNa+PW0BQoLAtESD6EZevE4m0sZfjw5+zkZq+2wQ+MmLIQ w==;
X-CSE-ConnectionGUID: VpF/1GyPQra0qBMoG9opew==
X-CSE-MsgGUID: j6iTwiXgRC2hIzO5TUtHzw==
X-IronPort-AV: E=McAfee;i="6800,10657,11772"; a="78762569"
X-IronPort-AV: E=Sophos;i="6.23,209,1770624000"; d="scan'208";a="78762569"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2026 18:19:13 -0700
X-CSE-ConnectionGUID: 5HAcB5FwSiOgsohsGWF2Mw==
X-CSE-MsgGUID: Zef6QrhgSDCL0SMZ5Umnww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,209,1770624000"; d="scan'208";a="239730493"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2026 18:19:13 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v2] drm/xe: Do not blindly copy system CCS pages when shrinking
Date: Thu, 30 Apr 2026 18:19:07 -0700
Message-Id: <20260501011907.2331654-1-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
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

If the PAT index for a BO is configured without compression, copying CCS
pages during BO shrinking provides no value. Skip CCS copies for BOs that
have never been configured with compressed PAT indexes.

Once a BO is configured with a compressed PAT index, this becomes a
one-way transition that enables CCS copies. This heuristic is imprecise,
but simple and functional.

Assisted-by: Claude:claude-sonnet-4.6 # kernel doc
Signed-off-by: Matthew Brost <matthew.brost@intel.com>

---

When running 10x tabs webgl aquarium, it was observed a ratio of ~6.5 to
1 of BOs that can possible enable compression (xe_bo_needs_ccs_pages
returns true) actually enable compression in the PAT index and overall
CCS copies are reduced by roughly 1/2 when the shrinker is triggered.

v2:
 - Only skip CCS copy when moving to system placement (sashiko)
 - Set ccs_used upon rebind (sashiko)
 - Add helpers for ccs_used access + document locking
 - Set ccs_used in kunit tests (CI)
---
 drivers/gpu/drm/xe/tests/xe_bo.c |  2 ++
 drivers/gpu/drm/xe/xe_bo.c       |  3 +++
 drivers/gpu/drm/xe/xe_bo.h       | 35 ++++++++++++++++++++++++++++++++
 drivers/gpu/drm/xe/xe_bo_types.h |  6 ++++++
 drivers/gpu/drm/xe/xe_vm.c       |  8 ++++++++
 5 files changed, 54 insertions(+)

diff --git a/drivers/gpu/drm/xe/tests/xe_bo.c b/drivers/gpu/drm/xe/tests/xe_bo.c
index 49c95ed67d7e..1686e735a2c7 100644
--- a/drivers/gpu/drm/xe/tests/xe_bo.c
+++ b/drivers/gpu/drm/xe/tests/xe_bo.c
@@ -149,6 +149,8 @@ static void ccs_test_run_tile(struct xe_device *xe, struct xe_tile *tile,
 
 	xe_bo_lock(bo, false);
 
+	xe_bo_set_ccs_used(bo);
+
 	kunit_info(test, "Verifying that CCS data is cleared on creation.\n");
 	ret = ccs_test_migrate(tile, bo, false, 0ULL, 0xdeadbeefdeadbeefULL,
 			       test, exec);
diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
index 5ce60d161e09..765b5d345a7e 100644
--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -1105,6 +1105,9 @@ static int xe_bo_move(struct ttm_buffer_object *ttm_bo, bool evict,
 			flags |= XE_MIGRATE_CLEAR_FLAG_CCS_DATA;
 
 		fence = xe_migrate_clear(migrate, bo, new_mem, flags);
+	} else if (handle_system_ccs && new_mem->mem_type == XE_PL_SYSTEM &&
+		   !xe_bo_is_ccs_used(bo)) {
+		fence = dma_fence_get_stub();
 	} else {
 		fence = xe_migrate_copy(migrate, bo, bo, old_mem, new_mem,
 					handle_system_ccs);
diff --git a/drivers/gpu/drm/xe/xe_bo.h b/drivers/gpu/drm/xe/xe_bo.h
index 68dea7d25a6b..101dc7a36f9a 100644
--- a/drivers/gpu/drm/xe/xe_bo.h
+++ b/drivers/gpu/drm/xe/xe_bo.h
@@ -514,4 +514,39 @@ static inline bool xe_bo_is_mem_type(struct xe_bo *bo, u32 mem_type)
 	xe_bo_assert_held(bo);
 	return bo->ttm.resource->mem_type == mem_type;
 }
+
+/**
+ * xe_bo_set_ccs_used() - Mark the CCS region of a BO as used
+ * @bo: The &xe_bo whose CCS region is being marked as used
+ *
+ * Mark the CCS (Compression Control Surface) metadata region of @bo as in use.
+ * This is set when the BO is mapped with a PAT index that has compression
+ * enabled, indicating that the CCS region holds valid compression state and
+ * must be handled appropriately during migration (e.g. copied or cleared rather
+ * than skipped).
+ *
+ * Caller must hold the BO reservation lock.
+ */
+static inline void xe_bo_set_ccs_used(struct xe_bo *bo)
+{
+	xe_bo_assert_held(bo);
+	bo->ccs_used = true;
+}
+
+/**
+ * xe_bo_is_ccs_used() - Check whether the CCS region of a BO is in use
+ * @bo: The &xe_bo to check
+ *
+ * Return: true if the CCS (Compression Control Surface) metadata region of
+ * @bo has been marked as used (i.e. the BO was mapped with compression
+ * enabled), false otherwise.
+ *
+ * Caller must hold the BO reservation lock.
+ */
+static inline bool xe_bo_is_ccs_used(struct xe_bo *bo)
+{
+	xe_bo_assert_held(bo);
+	return bo->ccs_used;
+}
+
 #endif
diff --git a/drivers/gpu/drm/xe/xe_bo_types.h b/drivers/gpu/drm/xe/xe_bo_types.h
index 9c199badd9b2..16cb97a5f2a6 100644
--- a/drivers/gpu/drm/xe/xe_bo_types.h
+++ b/drivers/gpu/drm/xe/xe_bo_types.h
@@ -88,6 +88,12 @@ struct xe_bo {
 	/** @ccs_cleared: true means that CCS region of BO is already cleared */
 	bool ccs_cleared;
 
+	/**
+	 * @ccs_used: true means that CCS region of BO is used, protected by
+	 * BO's dma-resv lock
+	 */
+	bool ccs_used;
+
 	/** @bb_ccs: BB instructions of CCS read/write. Valid only for VF */
 	struct xe_mem_pool_node *bb_ccs[XE_SRIOV_VF_CCS_CTX_COUNT];
 
diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index c3836f6eab35..7fbf3607b48b 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -743,11 +743,16 @@ static int xe_vm_ops_add_rebind(struct xe_vma_ops *vops, struct xe_vma *vma,
 				u8 tile_mask)
 {
 	struct xe_vma_op *op;
+	struct xe_bo *bo = xe_vma_bo(vma);
 
 	op = kzalloc_obj(*op);
 	if (!op)
 		return -ENOMEM;
 
+	if (bo && xe_pat_index_get_comp_en(xe_vma_vm(vma)->xe,
+					   vma->attr.pat_index))
+		xe_bo_set_ccs_used(bo);
+
 	xe_vm_populate_rebind(op, vma, tile_mask);
 	list_add_tail(&op->link, &vops->list);
 	xe_vma_ops_incr_pt_update_ops(vops, tile_mask, 1);
@@ -3054,6 +3059,9 @@ static int vma_lock_and_validate(struct drm_exec *exec, struct xe_vma *vma,
 
 		if (flags.request_decompress)
 			err = xe_bo_decompress(bo);
+
+		if (xe_pat_index_get_comp_en(vm->xe, vma->attr.pat_index))
+			xe_bo_set_ccs_used(bo);
 	}
 
 	return err;
-- 
2.34.1

