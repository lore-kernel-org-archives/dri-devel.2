Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79E08C982F1
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 10:17:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC26F10EC39;
	Tue, 22 Sep 2026 10:17:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="eqcle7ix";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 840A710EC37;
 Tue, 22 Sep 2026 10:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790072272; x=1821608272;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=6SpysAhncBI0hV/2Mn/SmwjOMngXpcJ2b5NBcQYUOno=;
 b=eqcle7ixji1R8YSU/ZLOHOY+eyttC04+XcrVXP91/JEerxE4PWRfevLd
 V7SfWhavhKWi7BVU1duOBxxz7aQ/5Pe4FFhEhhBuGd7NusZl8GK7Ukktu
 ZdBOkllTJYNidbLQehhk55fhe9QY1HHXg6zZoogPzg+c2OJ0tTFE2aNiR
 UU8nn3HJ2OA+Lh/8ihIR/AtUEHXpTydHyH5JRweTKiNhzIxttO8GwCh0M
 rRYcP5pSCSUEpkuT94nL/z0uGffHGuL5R70SVhyw7NkB6EQQwxSHzVFlB
 YTYwXCgVGRCpBiyBWCUPdhMcfTtvxIIYSy5LItCdYCqYtkUlA4lodCkr9 Q==;
X-CSE-ConnectionGUID: 6MrDh3qWR4eVkiu4I9M81Q==
X-CSE-MsgGUID: BKFXtlEMTh6lYzfc089ISw==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="101322816"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; d="scan'208";a="101322816"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 03:17:52 -0700
X-CSE-ConnectionGUID: EPZ/azaGQt2cXZ94ZcEjuA==
X-CSE-MsgGUID: 4upwP0KOQtS7rplXpP0jww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; d="scan'208";a="299307867"
Received: from varungup-desk.iind.intel.com ([10.190.238.71])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 03:17:50 -0700
From: Arvind Yadav <arvind.yadav@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: matthew.brost@intel.com, himal.prasad.ghimiray@intel.com,
 thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com
Subject: [PATCH v2 08/15] drm/xe: Reuse one dummy page per BO after wedge
Date: Tue, 22 Sep 2026 15:46:53 +0530
Message-ID: <20260922101721.1583542-9-arvind.yadav@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922101721.1583542-1-arvind.yadav@intel.com>
References: <20260922101721.1583542-1-arvind.yadav@intel.com>
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

ttm_bo_vm_dummy_page() allocates a page and a managed cleanup action on
every call. These allocations remain until the DRM device is released,
so repeated fallback faults can retain many pages.

Keep one zeroed dummy page in each Xe BO and reuse it when device I/O is
blocked or the device is unplugged. Use cmpxchg() to handle concurrent
faults and free the page when the BO is destroyed.

A per-BO page also prevents writable mappings from different BOs from
sharing data.

Map only the faulting address and return the insertion result directly.
Other addresses fault on demand and reuse the same dummy page.
This avoids walking a potentially large VMA during a single fault.

v2:
 - Drop whole-VMA prefaulting and map only the faulting address to avoid
   long fault-handler runtimes on large mappings. (Sashiko)

Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
---
 drivers/gpu/drm/xe/xe_bo.c       | 33 +++++++++++++++++++++++++++++++-
 drivers/gpu/drm/xe/xe_bo_types.h |  4 ++++
 2 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
index b39b07b55f64..7902ce3fe012 100644
--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -1890,6 +1890,9 @@ static void xe_ttm_bo_destroy(struct ttm_buffer_object *ttm_bo)
 		list_del(&bo->vram_userfault_link);
 	mutex_unlock(&xe->mem_access.vram_userfault.lock);
 
+	if (bo->wedged_dummy_page)
+		__free_page(bo->wedged_dummy_page);
+
 	kfree(bo);
 }
 
@@ -2094,6 +2097,32 @@ static vm_fault_t xe_bo_cpu_fault_fastpath(struct vm_fault *vmf, struct xe_devic
 	return ret;
 }
 
+static vm_fault_t xe_bo_vm_dummy_page(struct vm_fault *vmf, struct xe_bo *bo)
+{
+	struct vm_area_struct *vma = vmf->vma;
+	struct page *page, *old;
+	unsigned long pfn;
+
+	page = READ_ONCE(bo->wedged_dummy_page);
+	if (!page) {
+		page = alloc_page(GFP_KERNEL | __GFP_ZERO);
+		if (!page)
+			return VM_FAULT_OOM;
+
+		old = cmpxchg(&bo->wedged_dummy_page, NULL, page);
+		if (old) {
+			__free_page(page);
+			page = old;
+		}
+	}
+
+	pfn = page_to_pfn(page);
+
+	/* Map other addresses on demand instead of walking the whole VMA. */
+	return vmf_insert_pfn_prot(vma, vmf->address, pfn,
+				   vma->vm_page_prot);
+}
+
 static vm_fault_t xe_bo_cpu_fault(struct vm_fault *vmf)
 {
 	struct ttm_buffer_object *tbo = vmf->vma->vm_private_data;
@@ -2109,7 +2138,7 @@ static vm_fault_t xe_bo_cpu_fault(struct vm_fault *vmf)
 	int io_idx;
 
 	if (xe_device_io_get(xe, &io_idx))
-		return ttm_bo_vm_dummy_page(vmf, vmf->vma->vm_page_prot);
+		return xe_bo_vm_dummy_page(vmf, bo);
 
 	ret = xe_bo_cpu_fault_fastpath(vmf, xe, bo, needs_rpm);
 	if (ret != VM_FAULT_RETRY)
@@ -2399,6 +2428,8 @@ struct xe_bo *xe_bo_init_locked(struct xe_device *xe, struct xe_bo *bo,
 			return bo;
 	}
 
+	bo->wedged_dummy_page = NULL;
+
 	bo->ccs_cleared = false;
 	bo->tile = tile;
 	bo->flags = flags;
diff --git a/drivers/gpu/drm/xe/xe_bo_types.h b/drivers/gpu/drm/xe/xe_bo_types.h
index 0eb93052c1d5..8b3823b60cbf 100644
--- a/drivers/gpu/drm/xe/xe_bo_types.h
+++ b/drivers/gpu/drm/xe/xe_bo_types.h
@@ -21,6 +21,7 @@ struct xe_device;
 struct xe_mem_pool_node;
 struct xe_vm;
 struct xe_exec_queue;
+struct page;
 
 #define XE_BO_MAX_PLACEMENTS	3
 
@@ -114,6 +115,9 @@ struct xe_bo {
 	/** @vram_userfault_link: Link into @mem_access.vram_userfault.list */
 	struct list_head vram_userfault_link;
 
+	/** @wedged_dummy_page: Zeroed page used for faults after device wedge */
+	struct page *wedged_dummy_page;
+
 	/**
 	 * @min_align: minimum alignment needed for this BO if different
 	 * from default
-- 
2.43.0

