Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFE1606A322
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 13:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UVltMxbv
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2660710F2E4;
	Mon,  9 Nov 2026 13:57:31 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D38B110F2E4;
 Mon,  9 Nov 2026 13:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794232643; x=1825768643;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=XAshJLX3Xe5x2doGXu/SbbwoHV2uGJPLYB8OKgnvoLA=;
 b=UVltMxbvV3IF8zEUVfI7/dOMySWyHlirbNB7u2SKb1XRvVDNDa8oT2ro
 1Pr6pfibuuJHueRwFKC6GanhOvLPD4M435HXQesIcCNysLi58O7Qm1DhM
 2nK3uHZNtH8sQhCIjfwNu6K47pF8Cq7jZ4E3JMabZad0sDPQ+OMqj3Itz
 9LA5wtk+09lz5ier/ew8bjMLFwsfZ8I4zDonQG6dLip9NCWLwfi5L9p4B
 CZUVSfaa9lLIM1DlhuKEQ1qQLCqiiitHf/IjlCwK5XmhYNBkdfS39aar4
 P1kg3uwVJw614vRR6HlK8f/cGYlFNtzUPgUXjiAYxN0zo5HbPFL6nsmB5 w==;
X-CSE-ConnectionGUID: YBwUurxjSnG1VO/KdAxcpQ==
X-CSE-MsgGUID: nyx95TU2QsavcM5Rt1V6YQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11960"; a="2850896"
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="2850896"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 05:57:20 -0800
X-CSE-ConnectionGUID: fa6PizMxRAWo6WCZ0Ga4og==
X-CSE-MsgGUID: 1D3XHc+4R5Gp3BOAjqprIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="8202872"
Received: from pgcooper-mobl2.ger.corp.intel.com (HELO
 mkuoppal-desk.home.arpa) ([10.245.246.220])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 05:57:09 -0800
From: Mika Kuoppala <mika.kuoppala@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: simona.vetter@ffwll.ch, matthew.brost@intel.com, christian.koenig@amd.com,
 thomas.hellstrom@linux.intel.com, joonas.lahtinen@linux.intel.com,
 gustavo.sousa@intel.com, jan.maslak@intel.com,
 dominik.karol.piatkowski@intel.com, rodrigo.vivi@intel.com,
 andrzej.hajda@intel.com, matthew.auld@intel.com,
 maciej.patelczyk@intel.com, gwan-gyeong.mun@intel.com,
 michal.wajdeczko@intel.com, dri-devel@lists.freedesktop.org,
 Mika Kuoppala <mika.kuoppala@linux.intel.com>
Subject: [PATCH 13/20] drm/xe/eudebug: Add vm open/pread/pwrite
Date: Mon,  9 Nov 2026 15:55:38 +0200
Message-ID: <20261109135549.4128280-14-mika.kuoppala@linux.intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109135549.4128280-1-mika.kuoppala@linux.intel.com>
References: <20261109135549.4128280-1-mika.kuoppala@linux.intel.com>
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The debugger needs access to the client's vm to read and write, for
example to inspect ISA/ELF and set up breakpoints.

Add an ioctl to open the target vm with the debugger client and
vm_handle, and hook up pread/pwrite support.

Open will take a timeout argument so that standard fsync
can be used for explicit flushing between cpu/gpu for
the target vm.

Implement this for bo-backed storage. userptr will
be done in the following patch.

v2: - checkpatch (Maciej)
    - 32bit fixes (Andrzej)
    - bo_vmap (Mika)
    - fix vm leak if can't allocate k_buffer (Mika)
    - assert vm write held for vma (Matthew)
v3: - fw ref, ttm_bo_access
    - timeout boundary check (Dominik)
    - don't try to copy to user on zero bytes (Mika)
v4: - offset as unsigned long (Thomas)
    - check XE_VMA_DESTROYED
v5: - drm_dev_put before releasing debugger (Mika)
v6: - stop flushing on first error (Mika)
v7: - deny access on debugger disconnect (Andrzej)
v8: - correct offset calc in ttm_bo_access (Sashiko)
    - overzealous warn removed (Sashiko)
    - check param.extensions (Sashiko)
    - avoid hitting assert (Sashiko)
    - fix detach race on open (Claude)
    - build assert on ioctl cmd (Claude)
    - reject >u32 on vm lookup (Claude)
    - allow smaller vmallocs before fail
v9: - take runtime pm (Sashiko)
v10: - bound the fsync timeout (Sashiko)
v11: - no -EBUSY on discovery, lookup needs no eudebug.lock (Mika)
v12: - reject imported dma-bufs with -EINVAL (Sashiko)

Cc: Andrzej Hajda <andrzej.hajda@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Signed-off-by: Mika Kuoppala <mika.kuoppala@linux.intel.com>
---
 Documentation/gpu/xe/xe_eudebug.rst  |   6 +
 drivers/gpu/drm/xe/Makefile          |   2 +-
 drivers/gpu/drm/xe/regs/xe_gt_regs.h |  23 +
 drivers/gpu/drm/xe/xe_device_types.h |   7 +
 drivers/gpu/drm/xe/xe_eudebug.c      |  74 +++-
 drivers/gpu/drm/xe/xe_eudebug.h      |  11 +
 drivers/gpu/drm/xe/xe_eudebug_vm.c   | 610 +++++++++++++++++++++++++++
 drivers/gpu/drm/xe/xe_eudebug_vm.h   |  13 +
 drivers/gpu/drm/xe/xe_hw_engine.h    |   5 +
 include/uapi/drm/xe_drm_eudebug.h    |  69 ++-
 10 files changed, 810 insertions(+), 10 deletions(-)
 create mode 100644 drivers/gpu/drm/xe/xe_eudebug_vm.c
 create mode 100644 drivers/gpu/drm/xe/xe_eudebug_vm.h

diff --git a/Documentation/gpu/xe/xe_eudebug.rst b/Documentation/gpu/xe/xe_eudebug.rst
index fbee568d44be..bf5d1f0ce0a0 100644
--- a/Documentation/gpu/xe/xe_eudebug.rst
+++ b/Documentation/gpu/xe/xe_eudebug.rst
@@ -83,3 +83,9 @@ Acknowledging Events
 
 .. kernel-doc:: include/uapi/drm/xe_drm_eudebug.h
    :identifiers: drm_xe_eudebug_ack
+
+VM Access
+=========
+
+.. kernel-doc:: include/uapi/drm/xe_drm_eudebug.h
+   :identifiers: drm_xe_eudebug_vm_open
diff --git a/drivers/gpu/drm/xe/Makefile b/drivers/gpu/drm/xe/Makefile
index aee129a48040..f24ef4261dcb 100644
--- a/drivers/gpu/drm/xe/Makefile
+++ b/drivers/gpu/drm/xe/Makefile
@@ -165,7 +165,7 @@ xe-$(CONFIG_DRM_XE_GPUSVM) += xe_svm.o
 xe-$(CONFIG_DRM_GPUSVM) += xe_userptr.o
 
 # debugging shaders with gdb (eudebug) support
-xe-$(CONFIG_DRM_XE_EUDEBUG) += xe_eudebug.o
+xe-$(CONFIG_DRM_XE_EUDEBUG) += xe_eudebug.o xe_eudebug_vm.o
 
 # graphics hardware monitoring (HWMON) support
 xe-$(CONFIG_HWMON) += xe_hwmon.o
diff --git a/drivers/gpu/drm/xe/regs/xe_gt_regs.h b/drivers/gpu/drm/xe/regs/xe_gt_regs.h
index 06d45b1f2218..cd972a03a792 100644
--- a/drivers/gpu/drm/xe/regs/xe_gt_regs.h
+++ b/drivers/gpu/drm/xe/regs/xe_gt_regs.h
@@ -657,6 +657,29 @@
 #define   CCS_MODE_CSLICE(cslice, ccs) \
 	((ccs) << ((cslice) * CCS_MODE_CSLICE_WIDTH))
 
+#define RCU_ASYNC_FLUSH				XE_REG(0x149fc)
+#define   RCU_ASYNC_FLUSH_IN_PROGRESS	REG_BIT(31)
+#define   RCU_ASYNC_FLUSH_ENGINE_ID_SHIFT	28
+#define   RCU_ASYNC_FLUSH_AMFS		REG_BIT(8)
+#define   RCU_ASYNC_FLUSH_PREFETCH	REG_BIT(7)
+#define   RCU_ASYNC_FLUSH_DATA_PORT	REG_BIT(6)
+#define   RCU_ASYNC_FLUSH_DATA_CACHE	REG_BIT(5)
+#define   RCU_ASYNC_FLUSH_HDC_PIPELINE	REG_BIT(4)
+#define   RCU_ASYNC_INVALIDATE_HDC_PIPELINE REG_BIT(3)
+#define   RCU_ASYNC_INVALIDATE_CONSTANT_CACHE REG_BIT(2)
+#define   RCU_ASYNC_INVALIDATE_TEXTURE_CACHE REG_BIT(1)
+#define   RCU_ASYNC_INVALIDATE_INSTRUCTION_CACHE REG_BIT(0)
+#define   RCU_ASYNC_FLUSH_AND_INVALIDATE_ALL ( \
+	RCU_ASYNC_FLUSH_AMFS | \
+	RCU_ASYNC_FLUSH_PREFETCH | \
+	RCU_ASYNC_FLUSH_DATA_PORT | \
+	RCU_ASYNC_FLUSH_DATA_CACHE | \
+	RCU_ASYNC_FLUSH_HDC_PIPELINE | \
+	RCU_ASYNC_INVALIDATE_HDC_PIPELINE | \
+	RCU_ASYNC_INVALIDATE_CONSTANT_CACHE | \
+	RCU_ASYNC_INVALIDATE_TEXTURE_CACHE | \
+	RCU_ASYNC_INVALIDATE_INSTRUCTION_CACHE)
+
 #define FORCEWAKE_ACK_GT			XE_REG(0x130044)
 
 /* Applicable for all FORCEWAKE_DOMAIN and FORCEWAKE_ACK_DOMAIN regs */
diff --git a/drivers/gpu/drm/xe/xe_device_types.h b/drivers/gpu/drm/xe/xe_device_types.h
index 72747cb6b4f6..73b576547193 100644
--- a/drivers/gpu/drm/xe/xe_device_types.h
+++ b/drivers/gpu/drm/xe/xe_device_types.h
@@ -640,6 +640,13 @@ struct xe_device {
 		/** @eudebug.lock: protects the eudebug state of this device */
 		struct mutex lock;
 
+		/**
+		 * @eudebug.flush_lock: serializes the vm fsync() cache flushes,
+		 * which share RCU_ASYNC_FLUSH and save and restore the engine
+		 * idle messaging around it
+		 */
+		struct mutex flush_lock;
+
 		/** @eudebug.wq: used for the async session disconnect */
 		struct workqueue_struct *wq;
 	} eudebug;
diff --git a/drivers/gpu/drm/xe/xe_eudebug.c b/drivers/gpu/drm/xe/xe_eudebug.c
index 934dc116120e..e31418970113 100644
--- a/drivers/gpu/drm/xe/xe_eudebug.c
+++ b/drivers/gpu/drm/xe/xe_eudebug.c
@@ -18,6 +18,7 @@
 #include "xe_device.h"
 #include "xe_eudebug.h"
 #include "xe_eudebug_types.h"
+#include "xe_eudebug_vm.h"
 #include "xe_exec_queue.h"
 #include "xe_hw_engine.h"
 #include "xe_macros.h"
@@ -264,7 +265,7 @@ static bool __xe_eudebug_is_detached(struct xe_eudebug *d)
 	return !d->target.xef;
 }
 
-static bool xe_eudebug_is_detached(struct xe_eudebug *d)
+bool xe_eudebug_is_detached(struct xe_eudebug *d)
 {
 	guard(mutex)(&d->lock);
 
@@ -286,7 +287,7 @@ static void xe_eudebug_free(struct kref *ref)
 	kfree(d);
 }
 
-static void xe_eudebug_put(struct xe_eudebug *d)
+void xe_eudebug_put(struct xe_eudebug *d)
 {
 	kref_put(&d->ref, xe_eudebug_free);
 }
@@ -870,6 +871,31 @@ static int xe_eudebug_remove_handle(struct xe_eudebug *d, int type, void *p,
 	return ret;
 }
 
+static void *find_resource__unlocked(struct xe_eudebug_resource *r,
+				     u32 id)
+{
+	struct xe_eudebug_handle *h;
+
+	h = xa_load(&r->xa, id);
+
+	return h ? (void *)(uintptr_t)h->key : NULL;
+}
+
+struct xe_vm *xe_eudebug_vm_get(struct xe_eudebug *d, u32 id)
+{
+	struct xe_eudebug_resource *r =
+		resource_from_type(d, XE_EUDEBUG_RES_TYPE_VM);
+	struct xe_vm *vm;
+
+	mutex_lock(&d->lock);
+	vm = find_resource__unlocked(r, id);
+	if (vm)
+		xe_vm_get(vm);
+	mutex_unlock(&d->lock);
+
+	return vm;
+}
+
 static struct drm_xe_eudebug_event *
 xe_eudebug_prepare_event(struct xe_eudebug *d, u16 type, u64 seqno, u16 flags,
 			 u32 len)
@@ -2096,6 +2122,10 @@ static long xe_eudebug_ioctl(struct file *file,
 		ret = xe_eudebug_ack_event_ioctl(d, arg);
 		eu_dbg(d, "ioctl cmd=EVENT_ACK ret=%ld\n", ret);
 		break;
+	case DRM_XE_EUDEBUG_IOCTL_VM_OPEN:
+		ret = xe_eudebug_vm_open_ioctl(d, arg);
+		eu_dbg(d, "ioctl cmd=VM_OPEN ret=%ld\n", ret);
+		break;
 	default:
 		ret = -ENOTTY;
 	}
@@ -2253,7 +2283,8 @@ void xe_eudebug_file_close(struct xe_file *xef)
 	up_write(&xef->eudebug.ioctl_lock);
 }
 
-static int xe_eudebug_enable(struct xe_device *xe, bool enable)
+static int __xe_eudebug_enable(struct xe_device *xe, bool enable,
+			       bool *end_lockdown)
 {
 	int ret;
 
@@ -2280,8 +2311,37 @@ static int xe_eudebug_enable(struct xe_device *xe, bool enable)
 	set_cap_state(xe, enable ?
 		      XE_EUDEBUG_CAP_ENABLED : XE_EUDEBUG_CAP_DISABLED);
 
-	if (!enable && IS_SRIOV_PF(xe))
-		xe_sriov_pf_end_lockdown(xe);
+	/*
+	 * The lockdown must outlive any vm fsync() cache flush still writing
+	 * gt registers. Waiting those out under eudebug.lock would stall
+	 * everything else behind their polls, so hand the release to the
+	 * caller, which runs after we drop it.
+	 */
+	if (!enable)
+		*end_lockdown = IS_SRIOV_PF(xe);
+
+	return 0;
+}
+
+static int xe_eudebug_enable(struct xe_device *xe, bool enable)
+{
+	bool end_lockdown = false;
+	int ret;
+
+	ret = __xe_eudebug_enable(xe, enable, &end_lockdown);
+	if (ret || !end_lockdown)
+		return ret;
+
+	/*
+	 * A debugger detached before the disable may still be in a vm
+	 * fsync() cache flush, writing gt registers. A flush only starts
+	 * under flush_lock, after checking for the detach, so taking it once
+	 * waits out the last one.
+	 */
+	mutex_lock(&xe->eudebug.flush_lock);
+	mutex_unlock(&xe->eudebug.flush_lock);
+
+	xe_sriov_pf_end_lockdown(xe);
 
 	return 0;
 }
@@ -2375,6 +2435,10 @@ void xe_eudebug_init(struct xe_device *xe)
 	if (err)
 		goto out_err;
 
+	err = drmm_mutex_init(dev, &xe->eudebug.flush_lock);
+	if (err)
+		goto out_err;
+
 	/*
 	 * Last: once the attribute exists it can enable us, and nothing may
 	 * fail and overwrite cap_state after that. Removing a file that was
diff --git a/drivers/gpu/drm/xe/xe_eudebug.h b/drivers/gpu/drm/xe/xe_eudebug.h
index fc46d80a0b60..dc92cdbbf75e 100644
--- a/drivers/gpu/drm/xe/xe_eudebug.h
+++ b/drivers/gpu/drm/xe/xe_eudebug.h
@@ -37,10 +37,15 @@ struct xe_eudebug;
 		     ##__VA_ARGS__); \
 	} while (0)
 
+#define eu_warn(d, fmt, ...)  __eu_print(d, drm_warn, fmt, ##__VA_ARGS__)
 #define eu_dbg(d, fmt, ...)   __eu_print(d, drm_dbg, fmt, ##__VA_ARGS__)
 
 #define xe_eudebug_assert(d, ...) xe_assert((d)->xe, ##__VA_ARGS__)
 
+#define xe_eudebug_for_each_hw_engine(__hwe, __gt, __id) \
+	for_each_hw_engine(__hwe, __gt, __id)	       \
+		for_each_if(xe_hw_engine_has_eudebug(__hwe))
+
 int xe_eudebug_connect_ioctl(struct drm_device *dev,
 			     void *data,
 			     struct drm_file *file);
@@ -54,6 +59,12 @@ void xe_eudebug_file_close(struct xe_file *xef);
 void xe_eudebug_vm_create(struct xe_file *xef, struct xe_vm *vm);
 void xe_eudebug_vm_destroy(struct xe_file *xef, struct xe_vm *vm);
 
+bool xe_eudebug_is_detached(struct xe_eudebug *d);
+
+void xe_eudebug_put(struct xe_eudebug *d);
+
+struct xe_vm *xe_eudebug_vm_get(struct xe_eudebug *d, u32 vm_id);
+
 void xe_eudebug_exec_queue_create(struct xe_file *xef, struct xe_exec_queue *q);
 void xe_eudebug_exec_queue_destroy(struct xe_file *xef, struct xe_exec_queue *q);
 
diff --git a/drivers/gpu/drm/xe/xe_eudebug_vm.c b/drivers/gpu/drm/xe/xe_eudebug_vm.c
new file mode 100644
index 000000000000..385fcc7e8f5c
--- /dev/null
+++ b/drivers/gpu/drm/xe/xe_eudebug_vm.c
@@ -0,0 +1,610 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright © 2023-2025 Intel Corporation
+ */
+
+#include "xe_eudebug_vm.h"
+
+#include <linux/anon_inodes.h>
+#include <linux/dma-resv.h>
+#include <linux/fs.h>
+#include <linux/string_choices.h>
+#include <linux/vmalloc.h>
+
+#include <drm/drm_drv.h>
+
+#include "xe_bo.h"
+#include "xe_device.h"
+#include "xe_eudebug.h"
+#include "xe_eudebug_types.h"
+#include "xe_force_wake.h"
+#include "xe_gt.h"
+#include "xe_mmio.h"
+#include "xe_pm.h"
+#include "xe_vm.h"
+#include "xe_wedge.h"
+
+#include "regs/xe_gt_regs.h"
+#include "regs/xe_engine_regs.h"
+
+static int xe_eudebug_vma_access(struct xe_vma *vma,
+				 const u64 offset_in_vma,
+				 void *buf, const size_t len, bool write)
+{
+	struct xe_bo *bo;
+	u64 bytes;
+
+	lockdep_assert_held_write(&xe_vma_vm(vma)->lock);
+
+	if (offset_in_vma >= xe_vma_size(vma))
+		return -EINVAL;
+
+	if (vma->gpuva.flags & XE_VMA_DESTROYED)
+		return -EINVAL;
+
+	bytes = min_t(u64, len, xe_vma_size(vma) - offset_in_vma);
+	if (!bytes)
+		return 0;
+
+	bo = xe_bo_get(xe_vma_bo(vma));
+	if (bo) {
+		const u64 bo_offset = xe_vma_bo_offset(vma) + offset_in_vma;
+		int ret;
+		long lret;
+
+		/*
+		 * An imported dma-buf comes with dma addresses only. Its
+		 * page array stays empty, and ttm_bo_access_locked() would
+		 * kmap a NULL page.
+		 */
+		if (bo->ttm.type == ttm_bo_type_sg) {
+			xe_bo_put(bo);
+			return -EINVAL;
+		}
+
+		/*
+		 * A bo that has just been moved into place is cleared, or
+		 * copied, by a dma engine, and that work is published only as
+		 * a DMA_RESV_USAGE_KERNEL fence on its dma_resv. Nothing below
+		 * ttm_bo_access_locked() waits for it, so without this the
+		 * debugger reads whatever the pages held before the clear
+		 * landed. Those are recycled pages, and vram is a device wide
+		 * pool, so their previous owner need not be the target being
+		 * debugged.
+		 *
+		 * dma-resv.h states the rule plainly for this usage class:
+		 * drivers always must wait for these fences before accessing
+		 * the resource.
+		 *
+		 * Wait and access under one reservation. vm->lock keeps this
+		 * vm's rebinds out, but not a cpu fault migration or an
+		 * eviction, and either can install a new placement with a new
+		 * kernel fence the moment the reservation is dropped.
+		 */
+		ret = xe_bo_lock(bo, true);
+		if (ret) {
+			xe_bo_put(bo);
+			return ret;
+		}
+
+		if (xe_bo_madv_is_dontneed(bo) || xe_bo_is_purged(bo)) {
+			ret = -EINVAL;
+			goto out_unlock;
+		}
+
+		lret = dma_resv_wait_timeout(bo->ttm.base.resv,
+					     DMA_RESV_USAGE_KERNEL, true,
+					     MAX_SCHEDULE_TIMEOUT);
+		if (lret < 0)
+			ret = lret;
+		else
+			ret = ttm_bo_access_locked(&bo->ttm, bo_offset, buf,
+						   bytes, write);
+
+out_unlock:
+		xe_bo_unlock(bo);
+		xe_bo_put(bo);
+
+		return ret;
+	}
+
+	return -EINVAL;
+}
+
+static int xe_eudebug_vm_access(struct xe_vm *vm, const u64 offset,
+				void *buf, const size_t len, bool write)
+{
+	struct xe_vma *vma;
+	int ret;
+
+	down_write(&vm->lock);
+
+	if (offset >= vm->size || len > vm->size - offset) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	vma = xe_vm_find_overlapping_vma(vm, offset, len);
+	if (vma) {
+		u64 vma_local_offset;
+
+		/*
+		 * xe_vm_find_overlapping_vma() may return a VMA that starts
+		 * above @offset, when @offset lies in a hole but
+		 * [offset, offset+len) reaches into the VMA. Reject anything
+		 * that doesn't actually cover @offset itself.
+		 */
+		if (offset < xe_vma_start(vma) ||
+		    offset >= (xe_vma_start(vma) + xe_vma_size(vma))) {
+			ret = -EINVAL;
+			goto out;
+		}
+
+		/* Translate VM-space offset to VMA-local offset. */
+		vma_local_offset = offset - xe_vma_start(vma);
+		ret = xe_eudebug_vma_access(vma, vma_local_offset, buf, len, write);
+	} else {
+		ret = -EINVAL;
+	}
+
+out:
+	up_write(&vm->lock);
+
+	return ret;
+}
+
+struct vm_file {
+	struct xe_eudebug *debugger;
+	struct xe_vm *vm;
+	u64 flags;
+	u64 vm_handle;
+	u32 timeout_us;
+};
+
+static ssize_t __vm_read_write(struct xe_vm *vm,
+			       void *bb,
+			       char __user *r_buffer,
+			       const char __user *w_buffer,
+			       const u64 offset,
+			       size_t len,
+			       const bool write)
+{
+	ssize_t ret;
+
+	if (!len)
+		return 0;
+
+	if (write) {
+		ret = copy_from_user(bb, w_buffer, len);
+		if (ret)
+			return -EFAULT;
+
+		ret = xe_eudebug_vm_access(vm, offset, bb, len, true);
+		if (ret <= 0)
+			return ret;
+
+		len = ret;
+	} else {
+		ret = xe_eudebug_vm_access(vm, offset, bb, len, false);
+		if (ret <= 0)
+			return ret;
+
+		len = ret;
+
+		ret = copy_to_user(r_buffer, bb, len);
+		if (ret)
+			return -EFAULT;
+	}
+
+	return len;
+}
+
+static ssize_t __xe_eudebug_vm_access(struct file *file,
+				      char __user *r_buffer,
+				      const char __user *w_buffer,
+				      size_t count, loff_t *__pos)
+{
+	struct vm_file *vmf = file->private_data;
+	struct xe_eudebug * const d = vmf->debugger;
+	struct xe_device * const xe = d->xe;
+	const bool write = !!w_buffer;
+	struct xe_vm *vm;
+	ssize_t copied = 0;
+	ssize_t bytes_left;
+	ssize_t ret;
+	unsigned long alloc_len;
+	loff_t pos = *__pos;
+	void *k_buffer;
+
+	if (XE_IOCTL_DBG(d->xe, xe_eudebug_is_detached(d)))
+		return -ENOTCONN;
+
+	if (XE_IOCTL_DBG(xe, write && r_buffer))
+		return -EINVAL;
+
+	vm = xe_eudebug_vm_get(d, vmf->vm_handle);
+	if (XE_IOCTL_DBG(xe, !vm))
+		return -EINVAL;
+
+	if (XE_IOCTL_DBG(xe, vm != vmf->vm)) {
+		eu_warn(d, "vm_access(%s): vm handle mismatch vm_handle=%llu, flags=0x%llx, pos=%llu, count=%zu\n",
+			str_write_read(write),
+			vmf->vm_handle, vmf->flags, pos, count);
+		xe_vm_put(vm);
+		return -EINVAL;
+	}
+
+	if (!count) {
+		xe_vm_put(vm);
+		return 0;
+	}
+
+	if (pos >= vm->size) {
+		xe_vm_put(vm);
+		return write ? -ENOSPC : 0;
+	}
+
+	count = min_t(u64, count, vm->size - pos);
+	bytes_left = count;
+
+	alloc_len = min_t(unsigned long, ALIGN(count, PAGE_SIZE), 64 * SZ_1M);
+	do  {
+		k_buffer = __vmalloc(alloc_len, GFP_KERNEL_ACCOUNT | __GFP_NOWARN);
+		if (k_buffer)
+			break;
+
+		alloc_len >>= 1;
+	} while (alloc_len >= PAGE_SIZE);
+
+	if (XE_IOCTL_DBG(xe, !k_buffer)) {
+		xe_vm_put(vm);
+		return -ENOMEM;
+	}
+
+	do {
+		const ssize_t len = min_t(ssize_t, bytes_left, alloc_len);
+
+		ret = __vm_read_write(vm, k_buffer,
+				      write ? NULL : r_buffer + copied,
+				      write ? w_buffer + copied : NULL,
+				      (u64)(pos + copied),
+				      len,
+				      write);
+		if (ret <= 0)
+			break;
+
+		bytes_left -= ret;
+		copied += ret;
+	} while (bytes_left > 0);
+
+	vfree(k_buffer);
+	xe_vm_put(vm);
+
+	if (XE_WARN_ON(copied < 0))
+		copied = 0;
+
+	*__pos += copied;
+
+	return copied ?: ret;
+}
+
+/*
+ * The vm fd holds a drm_device reference, which keeps struct xe_device
+ * around but not the hardware: after an unbind the mmio mapping is gone.
+ * As with xe_bo_cpu_fault(), refuse to touch the device once it has been
+ * unplugged or wedged.
+ */
+static int vm_file_enter(struct xe_device *xe, int *idx)
+{
+	if (xe_wedged(xe))
+		return -ECANCELED;
+
+	if (!drm_dev_enter(&xe->drm, idx))
+		return -ENODEV;
+
+	return 0;
+}
+
+static ssize_t xe_eudebug_vm_read(struct file *file,
+				  char __user *buffer,
+				  size_t count, loff_t *pos)
+{
+	struct vm_file *vmf = file->private_data;
+	struct xe_device *xe = vmf->debugger->xe;
+	ssize_t ret;
+	int idx;
+
+	ret = vm_file_enter(xe, &idx);
+	if (ret)
+		return ret;
+
+	/*
+	 * These are plain file operations, not DRM ioctls, so nothing above
+	 * us is holding a runtime PM reference. The access reaches VRAM and
+	 * MMIO, which is not allowed while the device is suspended.
+	 */
+	xe_pm_runtime_get(xe);
+	ret = __xe_eudebug_vm_access(file, buffer, NULL, count, pos);
+	xe_pm_runtime_put(xe);
+
+	drm_dev_exit(idx);
+
+	return ret;
+}
+
+static ssize_t xe_eudebug_vm_write(struct file *file,
+				   const char __user *buffer,
+				   size_t count, loff_t *pos)
+{
+	struct vm_file *vmf = file->private_data;
+	struct xe_device *xe = vmf->debugger->xe;
+	ssize_t ret;
+	int idx;
+
+	ret = vm_file_enter(xe, &idx);
+	if (ret)
+		return ret;
+
+	xe_pm_runtime_get(xe);
+	ret = __xe_eudebug_vm_access(file, NULL, buffer, count, pos);
+	xe_pm_runtime_put(xe);
+
+	drm_dev_exit(idx);
+
+	return ret;
+}
+
+static int engine_rcu_flush(struct xe_eudebug *d,
+			    struct xe_hw_engine *hwe,
+			    u32 timeout_us)
+{
+	const struct xe_reg psmi_addr = RING_PSMI_CTL(hwe->mmio_base);
+	struct xe_gt *gt = hwe->gt;
+	unsigned int fw_gt, fw_ref;
+	u32 mask = RCU_ASYNC_FLUSH_AND_INVALIDATE_ALL;
+	u32 psmi_ctrl;
+	u32 id;
+	int ret;
+
+	if (hwe->class == XE_ENGINE_CLASS_RENDER)
+		id = 0;
+	else if (hwe->class == XE_ENGINE_CLASS_COMPUTE)
+		id = hwe->instance + 1;
+	else
+		return -EINVAL;
+
+	mask |= id << RCU_ASYNC_FLUSH_ENGINE_ID_SHIFT;
+
+	/*
+	 * RCU_ASYNC_FLUSH is a gt global register in the GT forcewake
+	 * domain, while RING_PSMI_CTL belongs to the engine's own domain.
+	 * Holding only the latter lets the flush request be dropped and the
+	 * status poll read back 0, so fsync() would report a flush that
+	 * never happened.
+	 */
+	fw_gt = xe_force_wake_get(gt_to_fw(gt), XE_FW_GT);
+	if (!fw_gt)
+		return -ETIMEDOUT;
+
+	fw_ref = xe_force_wake_get(gt_to_fw(gt), hwe->domain);
+	if (!fw_ref) {
+		xe_force_wake_put(gt_to_fw(gt), fw_gt);
+		return -ETIMEDOUT;
+	}
+
+	/*
+	 * Serialize flushes. They share RCU_ASYNC_FLUSH, and a concurrent
+	 * one would restore RING_PSMI_CTL under our feet. This is not
+	 * eudebug.lock, as the polls below can take a long while and
+	 * nothing else needs to wait for them.
+	 */
+	mutex_lock(&d->xe->eudebug.flush_lock);
+
+	/*
+	 * A disable on a PF takes this lock, once every debugger is
+	 * detached, before it lets VFs be enabled. Look again under it, so
+	 * that no flush touches the gt after that.
+	 */
+	if (xe_eudebug_is_detached(d)) {
+		ret = -ENOTCONN;
+		goto out_unlock;
+	}
+
+	psmi_ctrl = xe_mmio_read32(&gt->mmio, psmi_addr);
+	if (!(psmi_ctrl & IDLE_MSG_DISABLE))
+		xe_mmio_write32(&gt->mmio, psmi_addr,
+				REG_MASKED_FIELD_ENABLE(IDLE_MSG_DISABLE));
+
+	/* XXX: Timeout is per operation but in here we flush previous */
+	ret = xe_mmio_wait32(&gt->mmio, RCU_ASYNC_FLUSH,
+			     RCU_ASYNC_FLUSH_IN_PROGRESS, 0,
+			     timeout_us, NULL, false);
+	if (ret)
+		goto out;
+
+	xe_mmio_write32(&gt->mmio, RCU_ASYNC_FLUSH, mask);
+
+	ret = xe_mmio_wait32(&gt->mmio, RCU_ASYNC_FLUSH,
+			     RCU_ASYNC_FLUSH_IN_PROGRESS, 0,
+			     timeout_us, NULL, false);
+out:
+	if (!(psmi_ctrl & IDLE_MSG_DISABLE))
+		xe_mmio_write32(&gt->mmio, psmi_addr,
+				REG_MASKED_FIELD_DISABLE(IDLE_MSG_DISABLE));
+
+out_unlock:
+	mutex_unlock(&d->xe->eudebug.flush_lock);
+	xe_force_wake_put(gt_to_fw(gt), fw_ref);
+	xe_force_wake_put(gt_to_fw(gt), fw_gt);
+
+	return ret;
+}
+
+static int xe_eudebug_vm_fsync(struct file *file, loff_t start, loff_t end, int datasync)
+{
+	struct vm_file *vmf = file->private_data;
+	struct xe_eudebug *d = vmf->debugger;
+	struct xe_gt *gt;
+	int gt_id;
+	int ret = -EINVAL;
+	int idx, err;
+
+	eu_dbg(d, "vm_fsync: vm_handle=%llu, flags=0x%llx, start=%llu, end=%llu datasync=%d\n",
+	       vmf->vm_handle, vmf->flags, start, end, datasync);
+
+	if (XE_IOCTL_DBG(d->xe, xe_eudebug_is_detached(d)))
+		return -ENOTCONN;
+
+	err = vm_file_enter(d->xe, &idx);
+	if (err)
+		return err;
+
+	/* Not an ioctl, so take our own runtime PM ref before touching MMIO */
+	xe_pm_runtime_get(d->xe);
+
+	for_each_gt(gt, d->xe, gt_id) {
+		struct xe_hw_engine *hwe;
+		enum xe_hw_engine_id id;
+
+		/* XXX: vm open per engine? */
+		xe_eudebug_for_each_hw_engine(hwe, gt, id) {
+			ret = engine_rcu_flush(d, hwe, vmf->timeout_us);
+			if (ret)
+				goto out;
+		}
+	}
+out:
+	xe_pm_runtime_put(d->xe);
+	drm_dev_exit(idx);
+
+	return ret;
+}
+
+static int xe_eudebug_vm_release(struct inode *inode, struct file *file)
+{
+	struct vm_file *vmf = file->private_data;
+	struct xe_eudebug *d = vmf->debugger;
+	struct xe_device *xe = d->xe;
+
+	eu_dbg(d, "vm_release: vm_handle=%llu, flags=0x%llx\n",
+	       vmf->vm_handle, vmf->flags);
+
+	xe_vm_put(vmf->vm);
+	xe_eudebug_put(d);
+	drm_dev_put(&xe->drm);
+
+	kfree(vmf);
+
+	return 0;
+}
+
+/* Ceiling for fsync, see xe_eudebug_vm_open_ioctl() */
+#define XE_EUDEBUG_VM_SYNC_MAX_TIMEOUT_NS (10ull * NSEC_PER_SEC)
+
+static const struct file_operations vm_fops = {
+	.owner   = THIS_MODULE,
+	.llseek  = generic_file_llseek,
+	.read    = xe_eudebug_vm_read,
+	.write   = xe_eudebug_vm_write,
+	.fsync   = xe_eudebug_vm_fsync,
+	.release = xe_eudebug_vm_release,
+};
+
+long xe_eudebug_vm_open_ioctl(struct xe_eudebug *d, unsigned long arg)
+{
+	struct drm_xe_eudebug_vm_open param;
+	struct xe_device * const xe = d->xe;
+	struct vm_file *vmf = NULL;
+	struct xe_vm *vm;
+	struct file *file;
+	long ret = 0;
+	int fd;
+
+	BUILD_BUG_ON(_IOC_SIZE(DRM_XE_EUDEBUG_IOCTL_VM_OPEN) != sizeof(param));
+	BUILD_BUG_ON(!(_IOC_DIR(DRM_XE_EUDEBUG_IOCTL_VM_OPEN) & _IOC_WRITE));
+
+	if (XE_IOCTL_DBG(xe, copy_from_user(&param, (void __user *)arg, sizeof(param))))
+		return -EFAULT;
+
+	if (XE_IOCTL_DBG(xe, param.flags))
+		return -EINVAL;
+
+	if (XE_IOCTL_DBG(xe, param.extensions))
+		return -EINVAL;
+
+	if (XE_IOCTL_DBG(xe, param.vm_handle > U32_MAX))
+		return -EINVAL;
+
+	/*
+	 * The flush waits on mmio while holding eudebug.flush_lock, so an
+	 * unbounded timeout here would stall every other fsync() on the
+	 * device. The hardware flush is a microsecond scale operation; the
+	 * cap is generous rather than tight.
+	 */
+	if (XE_IOCTL_DBG(xe, param.timeout_ns > XE_EUDEBUG_VM_SYNC_MAX_TIMEOUT_NS))
+		return -EINVAL;
+
+	/*
+	 * The map keys vms by pointer without holding a reference. While
+	 * attached, a destroy removes the handle ahead of the final put, and
+	 * a detach empties the map in the same critical section that detaches
+	 * us, so the lookup never resolves a stale handle.
+	 */
+	vm = xe_eudebug_vm_get(d, param.vm_handle);
+	if (XE_IOCTL_DBG(xe, !vm))
+		return xe_eudebug_is_detached(d) ? -ENOTCONN : -EINVAL;
+
+	vmf = kzalloc_obj(*vmf, GFP_KERNEL);
+	if (XE_IOCTL_DBG(xe, !vmf)) {
+		ret = -ENOMEM;
+		goto out_vm_put;
+	}
+
+	fd = get_unused_fd_flags(O_CLOEXEC);
+	if (XE_IOCTL_DBG(xe, fd < 0)) {
+		ret = fd;
+		goto out_free;
+	}
+
+	kref_get(&d->ref);
+	vmf->debugger = d;
+	vmf->vm = vm;
+	vmf->flags = param.flags;
+	vmf->vm_handle = param.vm_handle;
+	/*
+	 * 0 would make the flush sample its status once and give up, which
+	 * is not what leaving the timeout unset reads as, so it selects the
+	 * maximum. Round up, so that a short timeout does not truncate to 0.
+	 */
+	vmf->timeout_us = DIV_ROUND_UP_ULL(param.timeout_ns ?: XE_EUDEBUG_VM_SYNC_MAX_TIMEOUT_NS,
+					   NSEC_PER_USEC);
+
+	file = anon_inode_getfile("[xe_eudebug.vm]", &vm_fops, vmf, O_RDWR);
+	if (IS_ERR(file)) {
+		ret = PTR_ERR(file);
+		XE_IOCTL_DBG(xe, ret);
+		goto out_fd_put;
+	}
+
+	eu_dbg(d, "vm_open: handle=%llu, flags=0x%llx, fd=%d\n",
+	       vmf->vm_handle, vmf->flags, fd);
+
+	drm_dev_get(&xe->drm);
+
+	file->f_mode |= FMODE_PREAD | FMODE_PWRITE |
+		FMODE_READ | FMODE_WRITE | FMODE_LSEEK;
+
+	fd_install(fd, file);
+
+	return fd;
+
+out_fd_put:
+	put_unused_fd(fd);
+	xe_eudebug_put(d);
+out_free:
+	kfree(vmf);
+out_vm_put:
+	xe_vm_put(vm);
+
+	return ret;
+}
diff --git a/drivers/gpu/drm/xe/xe_eudebug_vm.h b/drivers/gpu/drm/xe/xe_eudebug_vm.h
new file mode 100644
index 000000000000..dfd43b93588f
--- /dev/null
+++ b/drivers/gpu/drm/xe/xe_eudebug_vm.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright © 2023-2025 Intel Corporation
+ */
+
+#ifndef _XE_EUDEBUG_VM_H_
+#define _XE_EUDEBUG_VM_H_
+
+struct xe_eudebug;
+
+long xe_eudebug_vm_open_ioctl(struct xe_eudebug *d, unsigned long arg);
+
+#endif /* _XE_EUDEBUG_VM_H_ */
diff --git a/drivers/gpu/drm/xe/xe_hw_engine.h b/drivers/gpu/drm/xe/xe_hw_engine.h
index 532d69677981..7319ac0bb91e 100644
--- a/drivers/gpu/drm/xe/xe_hw_engine.h
+++ b/drivers/gpu/drm/xe/xe_hw_engine.h
@@ -87,4 +87,9 @@ static inline bool xe_engine_supports_eudebug(const enum xe_engine_class ec)
 	return false;
 }
 
+static inline bool xe_hw_engine_has_eudebug(const struct xe_hw_engine *hwe)
+{
+	return xe_engine_supports_eudebug(hwe->class);
+}
+
 #endif
diff --git a/include/uapi/drm/xe_drm_eudebug.h b/include/uapi/drm/xe_drm_eudebug.h
index f5ac97b5ebf9..448821c32d29 100644
--- a/include/uapi/drm/xe_drm_eudebug.h
+++ b/include/uapi/drm/xe_drm_eudebug.h
@@ -40,6 +40,7 @@ extern "C" {
  */
 #define DRM_XE_EUDEBUG_IOCTL_READ_EVENT		_IOWR('j', 0x40, struct drm_xe_eudebug_event)
 #define DRM_XE_EUDEBUG_IOCTL_ACK_EVENT		_IOW('j', 0x41, struct drm_xe_eudebug_ack)
+#define DRM_XE_EUDEBUG_IOCTL_VM_OPEN		_IOW('j', 0x42, struct drm_xe_eudebug_vm_open)
 
 /**
  * struct drm_xe_eudebug_event - Base type of event delivered by xe_eudebug.
@@ -209,10 +210,11 @@ struct drm_xe_eudebug_event_exec_queue {
  *
  * When EVENT_UFENCE is sent by the driver, all the operations of the
  * original vm_bind_ioctl() have completed, not only its debug data ones.
- * Memory in a debug data [addr, range] is then present if this bind or an
- * earlier one mapped it. Accessing it before the related EVENT_UFENCE
- * leads to undefined results, as bind operations are asynchronous and the
- * backing storage might not be there yet when VM_BIND is received.
+ * Memory in a debug data [addr, range] is then present, and accessible
+ * through DRM_XE_EUDEBUG_IOCTL_VM_OPEN, if this bind or an earlier one
+ * mapped it. Accessing it before the related EVENT_UFENCE leads to
+ * undefined results, as bind operations are asynchronous and the backing
+ * storage might not be there yet when VM_BIND is received.
  *
  * Client's UFENCE sync will be held by the driver: client's
  * drm_xe_wait_ufence will not complete and the value of the ufence
@@ -344,6 +346,65 @@ struct drm_xe_eudebug_ack {
 	__u64 reserved;
 };
 
+/**
+ * struct drm_xe_eudebug_vm_open - Open a target vm
+ *
+ * Open target VM for reading and writing with DRM_XE_EUDEBUG_IOCTL_VM_OPEN.
+ *
+ * File descriptor is returned which can be used with pread and pwrite
+ * to inspect and modify the target VM.
+ *
+ * Multiple operations can be synced with calling fsync(fd). The
+ * fsync will time out if the VM can't be guaranteed to be in sync, see
+ * @timeout_ns. Caller should re-read the state with pread again.
+ *
+ * pread() and pwrite() take a vm address as the offset. Like accesses
+ * through ptrace, a transfer carries on across adjacent mappings. It
+ * comes back short where it reaches an address no mapping covers, or
+ * where an access fails after some bytes were already transferred.
+ * Errors worth telling apart:
+ *
+ * - -EINVAL if no mapping of this vm covers the offset, or the vm handle
+ *   has gone. Retrying does not help until the target binds the range.
+ *   Mappings whose backing store the CPU cannot reach, such as imported
+ *   dma-bufs, fail with -EINVAL as well, as do buffer objects the target
+ *   marked purgeable (DONTNEED) or the kernel already purged.
+ * - -EINTR if the wait for the backing store to be ready was interrupted.
+ * - -ENOTCONN if the debug target is gone.
+ * - -ENOSPC from pwrite() at an offset at or past the end of the vm.
+ *   pread() returns 0 there.
+ * - -ENOMEM, -EFAULT, -EIO or -ENODATA if a bounce buffer could not be
+ *   allocated, the user buffer is bad, or the backing store could not
+ *   be accessed.
+ * - -ECANCELED if the device is wedged, and -ENODEV if it is gone.
+ * - -ETIMEDOUT from fsync() if the flush did not complete within
+ *   @timeout_ns. The vm may be out of sync, so pread() again.
+ *
+ */
+struct drm_xe_eudebug_vm_open {
+	/** @extensions: Reserved for future extensions, must be zero */
+	__u64 extensions;
+
+	/** @vm_handle: handle of vm to be accessed */
+	__u64 vm_handle;
+
+	/** @flags: flags, must be zero */
+	__u64 flags;
+
+	/**
+	 * @timeout_ns: Timeout value in nanoseconds
+	 *
+	 * Bounds each hardware wait of an fsync() on the returned fd.
+	 * fsync() flushes, and waits on, every engine that supports
+	 * debugging in turn, so one call can take a multiple of this value.
+	 * The flush waits on hardware while holding a device wide lock, so
+	 * the value is capped: anything above 10 seconds is rejected with
+	 * -EINVAL. 0 selects the cap. The value is rounded up to
+	 * microseconds.
+	 */
+	__u64 timeout_ns;
+};
+
 #if defined(__cplusplus)
 }
 #endif
-- 
2.53.0

