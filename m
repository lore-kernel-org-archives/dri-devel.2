Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C639ACD6E57
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 09:50:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E99510E605;
	Thu,  4 Jun 2026 09:50:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="laEgA5ar";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B0CF10E5EB;
 Thu,  4 Jun 2026 09:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780566628; x=1812102628;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Fja3sj91yNkzycVADI92oP2XEHRLSJgApmfriabnUpw=;
 b=laEgA5arUGHq02oLv3OzCdmIrFulsZCvPj7ugSwKkeKJwaCxLoRPuQ+h
 lQguvdJWO48YntX8FVb5Mfqa0H+qMRvHmZqRxNtBnfJnYDmF24RolAwVM
 5oPRgWL1SXWUjTed5/ulXqfqrpGUWbJE3Vn86QuooKW1bEBmzAqlSnLOT
 Zr7ZbsX3x/be02yEQLrqODsSYpFD5ZYaYUnUNr3/2sgZQorGealoHXu2U
 4odaOJ3J111MoQNeKnNcqYf8mM2RbSAk1R2OG9C8EVzf3qyW5k5Y2c6iV
 Z9YhlcbtQPnwAKJ5NhMowgw4eGYIQBu+6JyMLClKljv8w4lJwhMIybJaV g==;
X-CSE-ConnectionGUID: LghJzJ6rSlaQeBTN5LolWA==
X-CSE-MsgGUID: J5bin2DLRs2B0juy9A3MdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="98810518"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; d="scan'208";a="98810518"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2026 02:50:28 -0700
X-CSE-ConnectionGUID: EDEatTuzRr+IP5eguVGhSw==
X-CSE-MsgGUID: XCpKp2PvRv+UzKiiYqM+0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; d="scan'208";a="282602334"
Received: from varungup-desk.iind.intel.com ([10.190.238.71])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2026 02:50:26 -0700
From: Arvind Yadav <arvind.yadav@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: matthew.brost@intel.com, himal.prasad.ghimiray@intel.com,
 thomas.hellstrom@linux.intel.com
Subject: [RFC v3 1/7] drm/xe/vm: Track CPU_AUTORESET state in xe_vma
Date: Thu,  4 Jun 2026 15:20:06 +0530
Message-ID: <20260604095012.367231-2-arvind.yadav@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260604095012.367231-1-arvind.yadav@intel.com>
References: <20260604095012.367231-1-arvind.yadav@intel.com>
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

Track MADVISE_AUTORESET CPU-only state in struct xe_vma with a dedicated
cpu_autoreset_active bool.

Add XE_VMA_CPU_AUTORESET_ACTIVE as a pipeline-only bit to carry this
state through MAP/REMAP operations. Runtime state lives in
xe_vma.cpu_autoreset_active rather than vma->gpuva.flags.

The state is set at bind time and cleared on the first successful GPU
fault.

v2:
  - Move runtime state from gpuva.flags to xe_vma bool. (Matt)
  - Keep XE_VMA_CPU_AUTORESET_ACTIVE pipeline-only. (Matt)

v3:
  - Add kernel-doc and lockdep_assert_held to
    xe_vma_has_cpu_autoreset_active(). (Matt)

Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
---
 drivers/gpu/drm/xe/xe_vm.h       | 14 ++++++++++++++
 drivers/gpu/drm/xe/xe_vm_types.h | 13 +++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_vm.h b/drivers/gpu/drm/xe/xe_vm.h
index c5b900f38ded..0dd201cce968 100644
--- a/drivers/gpu/drm/xe/xe_vm.h
+++ b/drivers/gpu/drm/xe/xe_vm.h
@@ -181,6 +181,20 @@ static inline bool xe_vma_is_userptr(struct xe_vma *vma)
 		!xe_vma_is_cpu_addr_mirror(vma);
 }
 
+/**
+ * xe_vma_has_cpu_autoreset_active() - Check if VMA is still CPU-only
+ * @vma: VMA to check
+ *
+ * The caller must hold vm->lock (read or write).
+ *
+ * Return: true if CPU-only autoreset is armed, false after the first GPU touch.
+ */
+static inline bool xe_vma_has_cpu_autoreset_active(struct xe_vma *vma)
+{
+	lockdep_assert_held(&xe_vma_vm(vma)->lock);
+	return vma->cpu_autoreset_active;
+}
+
 struct xe_vma *xe_vm_find_vma_by_addr(struct xe_vm *vm, u64 page_addr);
 
 int xe_vma_need_vram_for_atomic(struct xe_device *xe, struct xe_vma *vma, bool is_atomic);
diff --git a/drivers/gpu/drm/xe/xe_vm_types.h b/drivers/gpu/drm/xe/xe_vm_types.h
index 635ed29b9a69..e6380458272e 100644
--- a/drivers/gpu/drm/xe/xe_vm_types.h
+++ b/drivers/gpu/drm/xe/xe_vm_types.h
@@ -52,6 +52,11 @@ struct xe_vm_pgtable_update_op;
 #define XE_VMA_DUMPABLE		(DRM_GPUVA_USERBITS << 8)
 #define XE_VMA_SYSTEM_ALLOCATOR	(DRM_GPUVA_USERBITS << 9)
 #define XE_VMA_MADV_AUTORESET	(DRM_GPUVA_USERBITS << 10)
+/*
+ * Pipeline-only bit used to carry cpu_autoreset_active through MAP/REMAP.
+ * It must not be stored persistently in vma->gpuva.flags.
+ */
+#define XE_VMA_CPU_AUTORESET_ACTIVE	(DRM_GPUVA_USERBITS << 11)
 
 /**
  * struct xe_vma_mem_attr - memory attributes associated with vma
@@ -157,6 +162,14 @@ struct xe_vma {
 	/** @tile_staged: bind is staged for this VMA */
 	u8 tile_staged;
 
+	/**
+	 * @cpu_autoreset_active: CPU mirror VMA has not been GPU-faulted yet.
+	 *
+	 * Set for MADVISE_AUTORESET CPU mirror VMAs and cleared on the first
+	 * successful GPU fault. Protected by vm->lock.
+	 */
+	bool cpu_autoreset_active;
+
 	/**
 	 * @skip_invalidation: Used in madvise to avoid invalidation
 	 * if mem attributes doesn't change
-- 
2.43.0

