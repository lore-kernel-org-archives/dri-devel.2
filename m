Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C567EC98311
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 14:09:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1026D10F08E;
	Wed, 23 Sep 2026 14:09:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="SCVD0/XP";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5930E10F086;
 Wed, 23 Sep 2026 14:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790172571; x=1821708571;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=1kW/CBCW88repyidEiNedKlRCr9R6IfY4qEDJ8poIjY=;
 b=SCVD0/XPqxKl1TGYSGXJ1VOdlZyx4p0LSo6Q7og1OTzx47Xk47i/3lcY
 UZ9cInIEMzxdciF6vDubynX2hEk4xO0EJ7wEQjpusptuK6i1+zYl32oQH
 icKFlAHxijW9NqaMBshtorgIHklX1l57tqZaEgBsnXoXOcM2Q3kPz7D6h
 BBVOZbu5NlhzWdSvGigfesj1Jg2Lrrakmqa3ddiV/W5XW1oGmPXvPu3c5
 DgUxYHbTc8jz7VnbwjvkZ24Bqpt2pmilZU1shEHJQplPtpKCK1voq/uIn
 TvLfpAWzFMFrP65nIQEmdty1r1pOiKg4QharToZawpytBEMY5xy7lSvqP A==;
X-CSE-ConnectionGUID: MfPv8XZ0TEmaBEW6s0Oecg==
X-CSE-MsgGUID: LjKGiicGQBiducFKmt2lLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="101535339"
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; d="scan'208";a="101535339"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2026 07:09:31 -0700
X-CSE-ConnectionGUID: Vkx7OCsmSUmwtRD3poImgg==
X-CSE-MsgGUID: Y7iBtGI3T6OsTTMRjUJOSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; 
   d="scan'208";a="4885860"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO fedora)
 ([10.245.245.245])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2026 07:09:29 -0700
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Matthew Auld <matthew.auld@intel.com>, dri-devel@lists.freedesktop.org,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 3/3] drm/xe: Route deferred xe_vma/xe_vm teardown off
 system_dfl_wq
Date: Wed, 23 Sep 2026 16:08:44 +0200
Message-ID: <20260923140844.390822-4-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923140844.390822-1-thomas.hellstrom@linux.intel.com>
References: <20260923140844.390822-1-thomas.hellstrom@linux.intel.com>
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

xe_vma_destroy() can defer the final teardown of a struct xe_vma to a
dma_fence completion callback (vma_destroy_cb()), and xe_vm_free() (the
drm_gpuvm_ops.vm_free callback) always defers struct xe_vm teardown to
a work item, since destroying a VM needs to sleep. Both used to queue
their work on system_dfl_wq, a global, kernel-wide workqueue that xe
has no control over and never waits on during module unload.

drm_gpuvm_free() drops its drm_device reference immediately after
calling xe_vm_free(), without waiting for the deferred work to run.
The same applies one level down: whichever xe_vma or xe_vm reference
happens to be the last one can trigger this chain from a dma_fence
callback that may fire at an arbitrary time, including after the
owning file has already been closed and its own module reference
dropped. Since nothing tracks or waits for work queued on
system_dfl_wq, `rmmod xe` could succeed and free the module's text
while vma_destroy_work_func() or vm_destroy_work_func() is still
queued or running on it, jumping into freed code.

Fix this by queueing this work on xe_destroy_wq instead, the existing
module-lifetime workqueue already used for GuC exec queue teardown.
Unlike a per-device workqueue, this requires no dereference of a
struct xe_device that may already be gone by the time a deferred
callback fires, and unlike system_dfl_wq it is guaranteed to be
drained by xe_destroy_wq_module_exit() before the module is unloaded,
following the drm_pagemap_dev_hold()/unhold_work precedent of using a
workqueue that is waited on at module unload rather than a bare module
reference. The previous commit's reordering of xe_destroy_wq_exit()
to run after xe_device_exit() guarantees that xe_destroy_wq is only
torn down once the device-count has reached zero, i.e. after any
xe_vma or xe_vm whose teardown queues work here has already dropped
its drm_device reference and thus already queued that work.

Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Assisted-by: LLM
---
 drivers/gpu/drm/xe/xe_module.c | 6 ++++--
 drivers/gpu/drm/xe/xe_vm.c     | 5 +++--
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_module.c b/drivers/gpu/drm/xe/xe_module.c
index c61bd33546f2..897724cb5cfb 100644
--- a/drivers/gpu/drm/xe/xe_module.c
+++ b/drivers/gpu/drm/xe/xe_module.c
@@ -114,8 +114,10 @@ static void xe_destroy_wq_module_exit(void)
  * xe_destroy_wq_queue() - Queue work on the destroy workqueue
  * @work: work item to queue
  *
- * The destroy workqueue has module lifetime and is used for GuC exec queue
- * teardown that can outlive a single xe_device. SVM pagemap destroy uses the
+ * The destroy workqueue has module lifetime, and is guaranteed to outlive
+ * any xe_device, and to be drained before the module is unloaded. It is used
+ * for GuC exec queue and xe_vm/xe_vma teardown that can be deferred past the
+ * lifetime of the xe_device that triggered it. SVM pagemap destroy uses the
  * per-device xe->destroy_wq instead.
  *
  * Return: %true if @work was queued, %false if it was already pending.
diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index 390da884c727..ee369e6c3b28 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -29,6 +29,7 @@
 #include "xe_exec_queue.h"
 #include "xe_gt.h"
 #include "xe_migrate.h"
+#include "xe_module.h"
 #include "xe_pagefault.h"
 #include "xe_pat.h"
 #include "xe_pm.h"
@@ -1249,7 +1250,7 @@ static void vma_destroy_cb(struct dma_fence *fence,
 	struct xe_vma *vma = container_of(cb, struct xe_vma, destroy_cb);
 
 	INIT_WORK(&vma->destroy_work, vma_destroy_work_func);
-	queue_work(system_dfl_wq, &vma->destroy_work);
+	xe_destroy_wq_queue(&vma->destroy_work);
 }
 
 static void xe_vm_assert_write_mode_or_garbage_collector(struct xe_vm *vm)
@@ -2059,7 +2060,7 @@ static void xe_vm_free(struct drm_gpuvm *gpuvm)
 	struct xe_vm *vm = container_of(gpuvm, struct xe_vm, gpuvm);
 
 	/* To destroy the VM we need to be able to sleep */
-	queue_work(system_dfl_wq, &vm->destroy_work);
+	xe_destroy_wq_queue(&vm->destroy_work);
 }
 
 struct xe_vm *xe_vm_lookup(struct xe_file *xef, u32 id)
-- 
2.55.0

