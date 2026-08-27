Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 283CEC61DCD
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 10:18:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B0AD10EF96;
	Thu, 27 Aug 2026 10:18:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="fnlBPHOa";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8FEC10EF92;
 Thu, 27 Aug 2026 10:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787825922; x=1819361922;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=nnicMSuYpV3cDD5+YE6dXQUGE22wU0gKqDib7Z9FsJI=;
 b=fnlBPHOaI6ykASlHVPp7Gdtga80pDnKFis6dC1Cosdcpc8//CigpXuUl
 HTupyPKaInQ38ulWbivyCIKSY3w9RGjiBBoZ+vSRiLOCpZL3MOmgXeFWq
 GaKlktsKH/9oseo8sEuv3vCH+06XddL55qsGG0a+hDMkJn1mV7zUESL4W
 TaG+Qc4B8Qbi7h8b2tGg1H/UxAFrDQrPmLqDc8iNaWTB5Es1I5u/stiNx
 oWMBO5+xuPwjRsaADAt7odyaoqVDnNe7biZLsWcsLsOYE8IzZ5MkRtGak
 RPkZ7fwBmkFatQqvunHO0dTnUGE2YceGzqxowWwLa4MWIJ/AJDXabFdz0 g==;
X-CSE-ConnectionGUID: Q7vOOqAsQgCt5aehF0y0Fg==
X-CSE-MsgGUID: ijB7BDL6Tau7Eg9Y7vUMQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11887"; a="88445867"
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; d="scan'208";a="88445867"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2026 03:18:41 -0700
X-CSE-ConnectionGUID: Fglipl2JRNOZBkMXItjRuQ==
X-CSE-MsgGUID: DG7SMerhSFmG71XH1Gx9UA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; d="scan'208";a="306057631"
Received: from varungup-desk.iind.intel.com ([10.190.238.71])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2026 03:18:40 -0700
From: Arvind Yadav <arvind.yadav@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: matthew.brost@intel.com, himal.prasad.ghimiray@intel.com,
 thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com
Subject: [PATCH 06/13] drm/xe: Reuse one dummy page per BO after wedge
Date: Thu, 27 Aug 2026 15:47:54 +0530
Message-ID: <20260827101801.1247654-7-arvind.yadav@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827101801.1247654-1-arvind.yadav@intel.com>
References: <20260827101801.1247654-1-arvind.yadav@intel.com>
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

Map the faulting address first and return any error from that operation.
Prefault the rest of the VMA as a best-effort optimization.

A per-BO page also prevents writable mappings from different BOs from
sharing data.

Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
---
 drivers/gpu/drm/xe/xe_bo.c       | 51 +++++++++++++++++++++++++++++++-
 drivers/gpu/drm/xe/xe_bo_types.h |  4 +++
 2 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
index b86cd6030ed6..1f6ea9f5afe6 100644
--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -1876,6 +1876,9 @@ static void xe_ttm_bo_destroy(struct ttm_buffer_object *ttm_bo)
 		list_del(&bo->vram_userfault_link);
 	mutex_unlock(&xe->mem_access.vram_userfault.lock);
 
+	if (bo->wedged_dummy_page)
+		__free_page(bo->wedged_dummy_page);
+
 	kfree(bo);
 }
 
@@ -2080,6 +2083,50 @@ static vm_fault_t xe_bo_cpu_fault_fastpath(struct vm_fault *vmf, struct xe_devic
 	return ret;
 }
 
+static vm_fault_t xe_bo_vm_dummy_page(struct vm_fault *vmf, struct xe_bo *bo)
+{
+	struct vm_area_struct *vma = vmf->vma;
+	struct page *page, *old;
+	unsigned long address;
+	unsigned long pfn;
+	vm_fault_t ret, prefault_ret;
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
+	/* The faulting address must be mapped successfully. */
+	ret = vmf_insert_pfn_prot(vma, vmf->address, pfn,
+				  vma->vm_page_prot);
+	if (ret & VM_FAULT_ERROR)
+		return ret;
+
+	/* Prefault the remaining VMA as a best-effort optimization. */
+	for (address = vma->vm_start; address < vma->vm_end;
+	     address += PAGE_SIZE) {
+		if (address == vmf->address)
+			continue;
+
+		prefault_ret = vmf_insert_pfn_prot(vma, address, pfn,
+						   vma->vm_page_prot);
+		if (prefault_ret & VM_FAULT_ERROR)
+			break;
+	}
+
+	return ret;
+}
+
 static vm_fault_t xe_bo_cpu_fault(struct vm_fault *vmf)
 {
 	struct ttm_buffer_object *tbo = vmf->vma->vm_private_data;
@@ -2095,7 +2142,7 @@ static vm_fault_t xe_bo_cpu_fault(struct vm_fault *vmf)
 	int idx;
 
 	if (xe_device_io_blocked(xe) || !drm_dev_enter(&xe->drm, &idx))
-		return ttm_bo_vm_dummy_page(vmf, vmf->vma->vm_page_prot);
+		return xe_bo_vm_dummy_page(vmf, bo);
 
 	ret = xe_bo_cpu_fault_fastpath(vmf, xe, bo, needs_rpm);
 	if (ret != VM_FAULT_RETRY)
@@ -2385,6 +2432,8 @@ struct xe_bo *xe_bo_init_locked(struct xe_device *xe, struct xe_bo *bo,
 			return bo;
 	}
 
+	bo->wedged_dummy_page = NULL;
+
 	bo->ccs_cleared = false;
 	bo->tile = tile;
 	bo->flags = flags;
diff --git a/drivers/gpu/drm/xe/xe_bo_types.h b/drivers/gpu/drm/xe/xe_bo_types.h
index e45f24301050..82ee171ea6de 100644
--- a/drivers/gpu/drm/xe/xe_bo_types.h
+++ b/drivers/gpu/drm/xe/xe_bo_types.h
@@ -20,6 +20,7 @@
 struct xe_device;
 struct xe_mem_pool_node;
 struct xe_vm;
+struct page;
 
 #define XE_BO_MAX_PLACEMENTS	3
 
@@ -106,6 +107,9 @@ struct xe_bo {
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

