Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8332CD6E68
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 09:50:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F90310E5F0;
	Thu,  4 Jun 2026 09:50:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="MJ2q4u0f";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CD0D10E5F0;
 Thu,  4 Jun 2026 09:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780566630; x=1812102630;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Ih8o1AApgERbppoR7RSUuA+cFyPOod7VCJx27S4kSfw=;
 b=MJ2q4u0f6gWYHrxZ33Tznsz7S1Dx79WHDuvpDrinyJsSRs9Rj+k9oy/x
 ZN4SUsl1OpQ7vChE46cn53OpyJHSQYG31j3WiOhPuref9mv9JA0/0SVRW
 7vvm5jcQ8bwAdgUle8iCDqXBiimmM1WPnjSWo5lN6uu/wNERo/wTMjspP
 ZY5K2nQJSD2rMKWTOIMnrDo/QJNCDciY4UYfBU9+O5pUxaYqkVlo+2BHC
 bTJMbi90deExZdkYRFQWbKj9+FUnjlNKQOZwUbW19wqm10N+T/J/b5tN3
 goTalZGDNiYipeDcjotXUHklqgAmNpdFtECeKr7pJe4iAwUHGhHD4pdqI w==;
X-CSE-ConnectionGUID: 7jEadGBpRdaHGqW5Wzeqcw==
X-CSE-MsgGUID: eTd4ObbzTU+ykobXR7LL1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="98810519"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; d="scan'208";a="98810519"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2026 02:50:30 -0700
X-CSE-ConnectionGUID: Ta8qjmqYSNua053YMNhFFw==
X-CSE-MsgGUID: odnHgP+gQCGM4iA+SmsUGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; d="scan'208";a="282602347"
Received: from varungup-desk.iind.intel.com ([10.190.238.71])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2026 02:50:28 -0700
From: Arvind Yadav <arvind.yadav@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: matthew.brost@intel.com, himal.prasad.ghimiray@intel.com,
 thomas.hellstrom@linux.intel.com
Subject: [RFC v3 2/7] drm/xe/vm: Preserve cpu_autoreset_active across GPUVA
 operations
Date: Thu,  4 Jun 2026 15:20:07 +0530
Message-ID: <20260604095012.367231-3-arvind.yadav@intel.com>
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

GPUVA split and remap operations rebuild VMAs from create flags. These
flags preserve persistent VMA state, but not runtime-only state such as
cpu_autoreset_active.

Forward XE_VMA_CPU_AUTORESET_ACTIVE explicitly through the MAP/REMAP
pipeline so xe_vma_create() can restore cpu_autoreset_active in the new
VMA. The bit remains pipeline-only and is stripped before storing
vma->gpuva.flags.

Also relax the UNMAP attribute warning for MADVISE_AUTORESET VMAs, since
they may legitimately carry non-default madvise-managed attributes.

v2:
  - Move runtime state to xe_vma bool and keep
    XE_VMA_CPU_AUTORESET_ACTIVE as pipeline-only. (Matt)
  - Add xe_vma_effective_create_flags() to centralise flag handling.

v3:
  - Guard cpu_autoreset_active assignment to CPU_ADDR_MIRROR VMAs only (Matt)

Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
---
 drivers/gpu/drm/xe/xe_vm.c | 44 ++++++++++++++++++++++++++++++++------
 1 file changed, 38 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index 080c2fff0e95..dec5279f08a2 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -1105,7 +1105,11 @@ static struct xe_vma *xe_vma_create(struct xe_vm *vm,
 	vma->gpuva.vm = &vm->gpuvm;
 	vma->gpuva.va.addr = start;
 	vma->gpuva.va.range = end - start + 1;
-	vma->gpuva.flags = flags;
+	/* Pipeline-only, do not store in gpuva.flags. */
+	vma->gpuva.flags = flags & ~XE_VMA_CPU_AUTORESET_ACTIVE;
+	vma->cpu_autoreset_active =
+		(flags & XE_VMA_SYSTEM_ALLOCATOR) &&
+		(flags & XE_VMA_CPU_AUTORESET_ACTIVE);
 
 	for_each_tile(tile, vm->xe, id)
 		vma->tile_mask |= 0x1 << id;
@@ -2479,8 +2483,10 @@ vm_bind_ioctl_ops_create(struct xe_vm *vm, struct xe_vma_ops *vops,
 				op->map.vma_flags |= XE_VMA_SYSTEM_ALLOCATOR;
 			if (flags & DRM_XE_VM_BIND_FLAG_DUMPABLE)
 				op->map.vma_flags |= XE_VMA_DUMPABLE;
-			if (flags & DRM_XE_VM_BIND_FLAG_MADVISE_AUTORESET)
+			if (flags & DRM_XE_VM_BIND_FLAG_MADVISE_AUTORESET) {
 				op->map.vma_flags |= XE_VMA_MADV_AUTORESET;
+				op->map.vma_flags |= XE_VMA_CPU_AUTORESET_ACTIVE;
+			}
 			op->map.request_decompress = flags & DRM_XE_VM_BIND_FLAG_DECOMPRESS;
 			op->map.pat_index = pat_index;
 			op->map.invalidate_on_bind =
@@ -2800,6 +2806,9 @@ static int vm_bind_ioctl_ops_parse(struct xe_vm *vm, struct drm_gpuva_ops *ops,
 			};
 
 			flags |= op->map.vma_flags & XE_VMA_CREATE_MASK;
+			/* Forward pipeline-only state. */
+			if (op->map.vma_flags & XE_VMA_CPU_AUTORESET_ACTIVE)
+				flags |= XE_VMA_CPU_AUTORESET_ACTIVE;
 
 			vma = new_vma(vm, &op->base.map, &default_attr,
 				      flags);
@@ -2842,6 +2851,10 @@ static int vm_bind_ioctl_ops_parse(struct xe_vm *vm, struct drm_gpuva_ops *ops,
 			op->remap.old_range = op->remap.range;
 
 			flags |= op->base.remap.unmap->va->flags & XE_VMA_CREATE_MASK;
+			/* Forward pipeline-only state. */
+			if (xe_vma_has_cpu_autoreset_active(old))
+				flags |= XE_VMA_CPU_AUTORESET_ACTIVE;
+
 			if (op->base.remap.prev) {
 				vma = new_vma(vm, op->base.remap.prev,
 					      &old->attr, flags);
@@ -4693,6 +4706,17 @@ int xe_vma_need_vram_for_atomic(struct xe_device *xe, struct xe_vma *vma, bool i
 	}
 }
 
+/* Add pipeline-only autoreset state when rebuilding a VMA. */
+static unsigned int xe_vma_effective_create_flags(struct xe_vma *vma)
+{
+	unsigned int flags = vma->gpuva.flags;
+
+	if (xe_vma_has_cpu_autoreset_active(vma))
+		flags |= XE_VMA_CPU_AUTORESET_ACTIVE;
+
+	return flags;
+}
+
 static int xe_vm_alloc_vma(struct xe_vm *vm,
 			   struct drm_gpuvm_map_req *map_req,
 			   bool is_madvise)
@@ -4728,19 +4752,24 @@ static int xe_vm_alloc_vma(struct xe_vm *vm,
 		if (!is_madvise) {
 			if (__op->op == DRM_GPUVA_OP_UNMAP) {
 				vma = gpuva_to_vma(op->base.unmap.va);
-				XE_WARN_ON(!xe_vma_has_default_mem_attrs(vma));
+				/* AUTORESET VMAs may carry madvise-managed attrs. */
+				XE_WARN_ON(!xe_vma_has_default_mem_attrs(vma) &&
+					   !(vma->gpuva.flags & XE_VMA_MADV_AUTORESET));
 				default_pat = vma->attr.default_pat_index;
-				vma_flags = vma->gpuva.flags;
+				vma_flags = xe_vma_effective_create_flags(vma);
 			}
 
 			if (__op->op == DRM_GPUVA_OP_REMAP) {
 				vma = gpuva_to_vma(op->base.remap.unmap->va);
 				default_pat = vma->attr.default_pat_index;
-				vma_flags = vma->gpuva.flags;
+				vma_flags = xe_vma_effective_create_flags(vma);
 			}
 
 			if (__op->op == DRM_GPUVA_OP_MAP) {
 				op->map.vma_flags |= vma_flags & XE_VMA_CREATE_MASK;
+				/* Forward pipeline-only state. */
+				if (vma_flags & XE_VMA_CPU_AUTORESET_ACTIVE)
+					op->map.vma_flags |= XE_VMA_CPU_AUTORESET_ACTIVE;
 				op->map.pat_index = default_pat;
 			}
 		} else {
@@ -4749,7 +4778,7 @@ static int xe_vm_alloc_vma(struct xe_vm *vm,
 				xe_assert(vm->xe, !remap_op);
 				xe_assert(vm->xe, xe_vma_has_no_bo(vma));
 				remap_op = true;
-				vma_flags = vma->gpuva.flags;
+				vma_flags = xe_vma_effective_create_flags(vma);
 			}
 
 			if (__op->op == DRM_GPUVA_OP_MAP) {
@@ -4762,6 +4791,9 @@ static int xe_vm_alloc_vma(struct xe_vm *vm,
 				 * unmapping.
 				 */
 				op->map.vma_flags |= vma_flags & XE_VMA_CREATE_MASK;
+				/* Forward pipeline-only state. */
+				if (vma_flags & XE_VMA_CPU_AUTORESET_ACTIVE)
+					op->map.vma_flags |= XE_VMA_CPU_AUTORESET_ACTIVE;
 			}
 		}
 		print_op(vm->xe, __op);
-- 
2.43.0

