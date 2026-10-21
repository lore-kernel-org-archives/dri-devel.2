Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2226D606A319
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 10:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lD9vfE1f
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81FF210FD4B;
	Wed, 21 Oct 2026 10:04:14 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05C8410F9CB;
 Wed, 21 Oct 2026 10:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792577045; x=1824113045;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=WF3jG7iusbsk5uFIobgDvu+KcwjvG5L1s1qeIcvIJIM=;
 b=lD9vfE1fByjw1BO2bufB18yB89H8MxJATWdoNfdkpuum3Cka9yukf+Z8
 Tv34XQsFmmPFyEWM3AZXfxhi/yUTzyyblhYxMSbF+CpNqQFbnlM7MsUbz
 JYuFSvi+fDJhGvqPkF0BIYwTk8PpRRaK0JEBZNQoVCxG/VG0XRSiyE06N
 UE4TEqi5/eGd2VY3Afyl5l10MCk/yVpzIRSLioEiIUgg5oaN4/XYL65ie
 IGejo1a7JdCXZtPfRLNm6urragVTg6oEppEnLXVUfHCUXDuNahzbiQFOg
 YPxzPtShbL7NpNYuYJW1TNt/3NVQYZOoJFUMyP92iULGWi/ZlHGpZqSpp g==;
X-CSE-ConnectionGUID: TWBiXB57RBiX6Jl5Ewj+pw==
X-CSE-MsgGUID: 248OGsbLRLOUEP16WWxLlQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1290311"
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="1290311"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 03:04:05 -0700
X-CSE-ConnectionGUID: pcqClIVPSNGCxxxEHmkNwQ==
X-CSE-MsgGUID: fM15UDjsRH6DRSc7R1pCJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="3382114"
Received: from varungup-desk.iind.intel.com ([10.190.238.71])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 03:04:00 -0700
From: Arvind Yadav <arvind.yadav@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: matthew.brost@intel.com, himal.prasad.ghimiray@intel.com,
 thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com
Subject: [RFC v3 10/17] drm/xe: Reuse one dummy page per BO after wedge
Date: Wed, 21 Oct 2026 15:33:11 +0530
Message-ID: <20261021100322.1014449-11-arvind.yadav@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021100322.1014449-1-arvind.yadav@intel.com>
References: <20261021100322.1014449-1-arvind.yadav@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

v3:
 - Map the dummy RAM page with normal WB protection. (Sashiko)

Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Assisted-by: LLM
Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
---
 drivers/gpu/drm/xe/xe_bo.c       | 33 +++++++++++++++++++++++++++++++-
 drivers/gpu/drm/xe/xe_bo_types.h |  4 ++++
 2 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
index 8fef7fa99ac4..6efcf3f5dda8 100644
--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -1994,6 +1994,9 @@ static void xe_ttm_bo_destroy(struct ttm_buffer_object *ttm_bo)
 		list_del(&bo->vram_userfault_link);
 	mutex_unlock(&xe->mem_access.vram_userfault.lock);
 
+	if (bo->wedged_dummy_page)
+		__free_page(bo->wedged_dummy_page);
+
 	kfree(bo);
 }
 
@@ -2189,6 +2192,32 @@ static vm_fault_t xe_bo_cpu_fault_fastpath(struct vm_fault *vmf, struct xe_devic
 	return ret;
 }
 
+static vm_fault_t xe_bo_vm_dummy_page(struct vm_fault *vmf, struct xe_bo *bo)
+{
+	struct vm_area_struct *vma = vmf->vma;
+	struct page *page, *old;
+	pgprot_t prot = vm_get_page_prot(vma->vm_flags);
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
+	return vmf_insert_pfn_prot(vma, vmf->address, pfn, prot);
+}
+
 static vm_fault_t xe_bo_cpu_fault(struct vm_fault *vmf)
 {
 	struct ttm_buffer_object *tbo = vmf->vma->vm_private_data;
@@ -2204,7 +2233,7 @@ static vm_fault_t xe_bo_cpu_fault(struct vm_fault *vmf)
 	int io_idx;
 
 	if (xe_device_io_get(xe, &io_idx))
-		return ttm_bo_vm_dummy_page(vmf, vmf->vma->vm_page_prot);
+		return xe_bo_vm_dummy_page(vmf, bo);
 
 	ret = xe_bo_cpu_fault_fastpath(vmf, xe, bo, needs_rpm);
 	if (ret != VM_FAULT_RETRY)
@@ -2494,6 +2523,8 @@ struct xe_bo *xe_bo_init_locked(struct xe_device *xe, struct xe_bo *bo,
 			return bo;
 	}
 
+	bo->wedged_dummy_page = NULL;
+
 	bo->ccs_cleared = false;
 	bo->tile = tile;
 	bo->flags = flags;
diff --git a/drivers/gpu/drm/xe/xe_bo_types.h b/drivers/gpu/drm/xe/xe_bo_types.h
index 8ec4a01a0092..80aeb4e31fe9 100644
--- a/drivers/gpu/drm/xe/xe_bo_types.h
+++ b/drivers/gpu/drm/xe/xe_bo_types.h
@@ -21,6 +21,7 @@ struct xe_device;
 struct xe_mem_pool_node;
 struct xe_vm;
 struct xe_exec_queue;
+struct page;
 
 #define XE_BO_MAX_PLACEMENTS	3
 
@@ -112,6 +113,9 @@ struct xe_bo {
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

