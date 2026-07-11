Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9484EC4450B
	for <dri-devel@archiver.kernel.org>; Sat, 11 Jul 2026 02:56:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1A3B10E2C3;
	Sat, 11 Jul 2026 02:56:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Lxd/MVVD";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E650310E2BC;
 Sat, 11 Jul 2026 02:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783738589; x=1815274589;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=u3Jx6VC8xZg2yCE3q2v8z9AzOPMGzRVVf08fs1sAico=;
 b=Lxd/MVVDDd1Qv02Jd3S9P6/C+WuIvc2LUmgFFG/jGgqTf+R6/sq6Yl/0
 gq+/6vAvEOckUfzbQPLPy0rMAFBrUpLSuCEp7jv3IMru6W4TW7dAUrI3V
 EjXAemtiHyaCFOYQ2O2120yV0Gdr3lSTaEVmvARfzyPfKVmmeckEzfsBB
 c3UwVn4OC8ypCPu+AZiRKaQHaauRtIqCRGkvR056gX4yGCfYr3iuI+wWx
 QYSbbEy+r0t4hAQ6cytYAx5TpqqXGpDY8wto1n/w+UPoMr3sQE54qrgdC
 P1B//630At1YLmXfWa1srGSPpSW22pgbKDONTPQ3uVRHF5SWufiKM8TwY Q==;
X-CSE-ConnectionGUID: q2080gMQS7SSIoOUftCfDg==
X-CSE-MsgGUID: HBecFZC1QhmiSlvrzfpItg==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="101986261"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="101986261"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2026 19:56:29 -0700
X-CSE-ConnectionGUID: CgqNHFOERJ+jFR3bidWx0g==
X-CSE-MsgGUID: Xt9oQ60VRbiJ4YYouvZ/9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="256987716"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2026 19:56:28 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v3 14/33] drm/xe: Destroy page tables after unlinking all VMAs
 on VM close
Date: Fri, 10 Jul 2026 19:56:00 -0700
Message-Id: <20260711025619.2540575-15-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260711025619.2540575-1-matthew.brost@intel.com>
References: <20260711025619.2540575-1-matthew.brost@intel.com>
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

xe_vm_close_and_put() freed the VM's page-table roots via
xe_vm_pt_destroy() before destroying the "contested" VMAs - those backed
by external (shared) BOs, which are deferred to xe_vma_destroy_unlocked()
because unlinking them requires taking the external BO's dma-resv lock
(via drm_exec), not vm->lock.

Until such a VMA is unlinked it remains reachable from its BO through
drm_gem_for_each_gpuvm_bo(). A concurrent BO move that only holds the
BO's dma-resv lock - TTM eviction, the shrinker, or the defrag worker -
calls xe_bo_move_notify() -> xe_bo_trigger_rebind() ->
xe_vm_invalidate_vma() -> xe_pt_zap_ptes(), which dereferences
vm->pt_root[tile->id]. With the page tables already freed this is a
use-after-free / NULL dereference, e.g.:

  Oops: general protection fault [...] kernel NULL pointer dereference
  RIP: xe_pt_zap_ptes+0x7c [xe]
  Call Trace:
   xe_vm_invalidate_vma_submit+0x64/0x130 [xe]
   xe_vm_invalidate_vma+0x27/0x60 [xe]
   xe_bo_move_notify+0x1e7/0x3d0 [xe]
   xe_bo_move+0x62d/0x1620 [xe]
   ttm_bo_handle_move_mem+0x243/0x330 [ttm]
   ttm_bo_validate+0xb4/0x1a0 [ttm]

The race is not closable with a flag or a NULL pt_root check in the
invalidate path: the freeing side holds only vm->lock while the walker
holds only the BO's resv, so there is no common lock to serialise on.

Fix the ordering instead: destroy the page tables only after every VMA -
including the contested external-BO VMAs - has been unlinked. Once the
contested loop completes no BO can reach a VMA of this VM, so freeing the
page tables (under vm->lock, to satisfy xe_vm_assert_held()) is safe.
xe_vm_free_scratch() still runs before the free as it reads
pt_root[]->level.

Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
Assisted-by: GitHub_Copilot:claude-opus-4.8
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
---
 drivers/gpu/drm/xe/xe_vm.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index 4557a8a4d270..9f55d22cb985 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -1934,15 +1934,7 @@ void xe_vm_close_and_put(struct xe_vm *vm)
 		vma->gpuva.flags |= XE_VMA_DESTROYED;
 	}
 
-	/*
-	 * All vm operations will add shared fences to resv.
-	 * The only exception is eviction for a shared object,
-	 * but even so, the unbind when evicted would still
-	 * install a fence to resv. Hence it's safe to
-	 * destroy the pagetables immediately.
-	 */
 	xe_vm_free_scratch(vm);
-	xe_vm_pt_destroy(vm);
 	xe_vm_unlock(vm);
 
 	/*
@@ -1956,6 +1948,22 @@ void xe_vm_close_and_put(struct xe_vm *vm)
 		xe_vma_destroy_unlocked(vma);
 	}
 
+	/*
+	 * Destroy the page tables only after every VMA has been unlinked. The
+	 * contested (external-BO) VMAs above are unlinked from their BO under
+	 * the BO's dma-resv lock, not vm->lock, so they can still be reached
+	 * via drm_gem_for_each_gpuvm_bo() by a concurrent BO move (eviction,
+	 * shrinker or the defrag worker) that only holds the BO's resv. Such a
+	 * move calls xe_vm_invalidate_vma() -> xe_pt_zap_ptes(), which
+	 * dereferences vm->pt_root[]; freeing the page tables while those VMAs
+	 * are still linked is a use-after-free. All vm operations add shared
+	 * fences to the resv (eviction of a shared object still installs an
+	 * unbind fence), so no GPU work outlives this point.
+	 */
+	xe_vm_lock(vm, false);
+	xe_vm_pt_destroy(vm);
+	xe_vm_unlock(vm);
+
 	xe_svm_fini(vm);
 
 	up_write(&vm->lock);
-- 
2.34.1

