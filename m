Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797B7606A322
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 13:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AjOh54eQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A571310F356;
	Mon,  9 Nov 2026 13:57:52 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09B2710F32E;
 Mon,  9 Nov 2026 13:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794232658; x=1825768658;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=GrGbcpGrzqucfBq0Zi98GzBNTYTqCYDqWQD21szR8RA=;
 b=AjOh54eQyIzJD9RCavf2uoba58yHjXXCs401/qMJlPnWzD1cdRbuhCmp
 /Ig+b1iRaC+9z1gawQmjLL93jlLCO4JKhq13azj4F1AvVaBPa5UikNWLN
 WRlTZvG0uQvhoYLzvQmJgWzpG7vbAnaPY7Ot/OGCuRkGnxZAQ3tjh+JoG
 sujT+CPocRH/y/BD+8mOFioPbnE5Ogc9UHbZZj6ug1DMOS6r3SKoyt6zY
 X74KsbvvP+5HXJYjOAugSWGllH7qK68EOZiYEC6PsXGrxF+vLMPmNKJQ9
 LIuKBX/VUKURPte/4HkUyxFU4+OULPDyMsTR08rCFBzzGmsEhnEUM6+Ds w==;
X-CSE-ConnectionGUID: WCE0d1L8RKmv2iqpPb7GAg==
X-CSE-MsgGUID: Qo8NltgjR7WytfnXvnoDRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11960"; a="2850926"
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="2850926"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 05:57:38 -0800
X-CSE-ConnectionGUID: iuAz/zJ6TMSBOCfbiG+pCQ==
X-CSE-MsgGUID: ZVWhG5hJTHWaHAJO2pWJkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="8202971"
Received: from pgcooper-mobl2.ger.corp.intel.com (HELO
 mkuoppal-desk.home.arpa) ([10.245.246.220])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 05:57:32 -0800
From: Mika Kuoppala <mika.kuoppala@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: simona.vetter@ffwll.ch, matthew.brost@intel.com, christian.koenig@amd.com,
 thomas.hellstrom@linux.intel.com, joonas.lahtinen@linux.intel.com,
 gustavo.sousa@intel.com, jan.maslak@intel.com,
 dominik.karol.piatkowski@intel.com, rodrigo.vivi@intel.com,
 andrzej.hajda@intel.com, matthew.auld@intel.com,
 maciej.patelczyk@intel.com, gwan-gyeong.mun@intel.com,
 michal.wajdeczko@intel.com, dri-devel@lists.freedesktop.org,
 Dominik Grzegorzek <dominik.grzegorzek@intel.com>,
 Christoph Manszewski <christoph.manszewski@intel.com>,
 Mika Kuoppala <mika.kuoppala@linux.intel.com>
Subject: [PATCH 17/20] drm/xe/eudebug: Introduce EU control interface
Date: Mon,  9 Nov 2026 15:55:42 +0200
Message-ID: <20261109135549.4128280-18-mika.kuoppala@linux.intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109135549.4128280-1-mika.kuoppala@linux.intel.com>
References: <20261109135549.4128280-1-mika.kuoppala@linux.intel.com>
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Dominik Grzegorzek <dominik.grzegorzek@intel.com>

Introduce EU control functionality, which allows the EU debugger
to interrupt, resume, and inform about the current state of
EU threads during execution. Provide an abstraction layer,
so that in the future the GuC will only need to provide appropriate
callbacks.

Based on an implementation created by the authors and others in the
i915 driver.

v2: - checkpatch (Maciej)
    - lrc index off by one fix (Mika)
    - checkpatch (Tilak)
    - 32bit fixes (Andrzej, Mika)
    - find_resource_get for client (Mika)
v3: - fw ref (Mika)
    - attention register naming
v4: - fused off handling (Dominik)
    - squash xe3 parts and ptl attentions (Mika)
v5: - s/ioctl_lock/exec_queue.lock to avoid wrong lock order (Mika)
v6: - require seqno MBZ (Mika)
v7: - error return consistency (Mika)
v8: - consolidate boilerplate and lrc sanity check (Mika)
v9: - keep FEE when setting FEH, user_arg reserved (Sashiko)
v10: - take runtime pm for hw access (Sashiko)
     - gate sriov (Sashiko)
     - more careful logging (Sashiko)
     - proper teardown if no runtime active
     - don't warn on wrong context (Claude)
     - documentation fixes (Claude)
     - byte size iter size check for safety (Claude)
v11: - interrupt on the engine the queue runs on (Sashiko)
v12: - don't reset media gts on enable (review-prompts)
v13: - no -EBUSY on discovery, OA reads cap_state under its gt_lock (Mika)

Signed-off-by: Dominik Grzegorzek <dominik.grzegorzek@intel.com>
Signed-off-by: Maciej Patelczyk <maciej.patelczyk@intel.com>
Signed-off-by: Christoph Manszewski <christoph.manszewski@intel.com>
Signed-off-by: Mika Kuoppala <mika.kuoppala@linux.intel.com>
---
 .../ABI/testing/sysfs-driver-intel-xe-eudebug |   9 +
 Documentation/gpu/xe/xe_eudebug.rst           |   6 +
 drivers/gpu/drm/xe/regs/xe_engine_regs.h      |   1 +
 drivers/gpu/drm/xe/xe_device_types.h          |   5 +-
 drivers/gpu/drm/xe/xe_eudebug.c               | 162 +++-
 drivers/gpu/drm/xe/xe_eudebug.h               |   5 +
 drivers/gpu/drm/xe/xe_eudebug_hw.c            | 735 ++++++++++++++++++
 drivers/gpu/drm/xe/xe_eudebug_hw.h            |   7 +
 drivers/gpu/drm/xe/xe_eudebug_types.h         |  25 +
 drivers/gpu/drm/xe/xe_oa.c                    |  60 ++
 drivers/gpu/drm/xe/xe_oa.h                    |   1 +
 include/uapi/drm/xe_drm_eudebug.h             |  68 ++
 12 files changed, 1081 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-intel-xe-eudebug b/Documentation/ABI/testing/sysfs-driver-intel-xe-eudebug
index 237dea4c6699..fec47a40144a 100644
--- a/Documentation/ABI/testing/sysfs-driver-intel-xe-eudebug
+++ b/Documentation/ABI/testing/sysfs-driver-intel-xe-eudebug
@@ -15,6 +15,15 @@ Description:	RW. Controls whether the EU debugger interface is armed for
 		Writing 0 while any debugger connection is still attached,
 		or any debuggable exec queue still exists, fails with -EBUSY.
 
+		Changing the setting resets each gt that has render or
+		compute engines, so that the debug registers take effect.
+		Exec queues with jobs in flight on that gt are banned by the
+		reset.
+
+		Writing 1 while an OA stream is open fails with -EBUSY, and
+		while the interface is enabled opening an OA stream fails
+		with -EBUSY.
+
 		Once enabled, connecting needs no privilege beyond access to
 		the render node: a client may attach to any DRM file it holds
 		a descriptor for, including its own. Any such client can
diff --git a/Documentation/gpu/xe/xe_eudebug.rst b/Documentation/gpu/xe/xe_eudebug.rst
index bf5d1f0ce0a0..b5aed372f4d7 100644
--- a/Documentation/gpu/xe/xe_eudebug.rst
+++ b/Documentation/gpu/xe/xe_eudebug.rst
@@ -89,3 +89,9 @@ VM Access
 
 .. kernel-doc:: include/uapi/drm/xe_drm_eudebug.h
    :identifiers: drm_xe_eudebug_vm_open
+
+EU/HW Control
+=============
+
+.. kernel-doc:: include/uapi/drm/xe_drm_eudebug.h
+   :identifiers: drm_xe_eudebug_eu_control
diff --git a/drivers/gpu/drm/xe/regs/xe_engine_regs.h b/drivers/gpu/drm/xe/regs/xe_engine_regs.h
index aaec9d02b986..9cee40460de9 100644
--- a/drivers/gpu/drm/xe/regs/xe_engine_regs.h
+++ b/drivers/gpu/drm/xe/regs/xe_engine_regs.h
@@ -171,6 +171,7 @@
 #define   IDLE_DELAY				REG_GENMASK(20, 0)
 
 #define RING_CURRENT_LRCA(base)			XE_REG((base) + 0x240)
+#define   CURRENT_LRCA_VALID			REG_BIT(0)
 
 #define RING_CONTEXT_CONTROL(base)		XE_REG((base) + 0x244, XE_REG_OPTION_MASKED)
 #define	  CTX_CTRL_PXP_ENABLE			REG_BIT(10)
diff --git a/drivers/gpu/drm/xe/xe_device_types.h b/drivers/gpu/drm/xe/xe_device_types.h
index 354b258f4ca6..6be8ea04f8f6 100644
--- a/drivers/gpu/drm/xe/xe_device_types.h
+++ b/drivers/gpu/drm/xe/xe_device_types.h
@@ -629,8 +629,9 @@ struct xe_device {
 		u64 session_count;
 
 		/**
-		 * @eudebug.cap_state: eudebug capability state, protected by
-		 * @eudebug.lock
+		 * @eudebug.cap_state: eudebug capability state. Written
+		 * under @eudebug.lock and the OA gt_lock of every gt, read
+		 * under either, see set_cap_state()
 		 */
 		enum xe_eudebug_cap_state cap_state;
 
diff --git a/drivers/gpu/drm/xe/xe_eudebug.c b/drivers/gpu/drm/xe/xe_eudebug.c
index 03ac45653172..4fab8304046b 100644
--- a/drivers/gpu/drm/xe/xe_eudebug.c
+++ b/drivers/gpu/drm/xe/xe_eudebug.c
@@ -17,11 +17,15 @@
 #include "xe_debug_data_types.h"
 #include "xe_device.h"
 #include "xe_eudebug.h"
+#include "xe_eudebug_hw.h"
 #include "xe_eudebug_types.h"
 #include "xe_eudebug_vm.h"
 #include "xe_exec_queue.h"
+#include "xe_gt.h"
 #include "xe_hw_engine.h"
 #include "xe_macros.h"
+#include "xe_oa.h"
+#include "xe_pm.h"
 #include "xe_sriov_pf.h"
 #include "xe_sync.h"
 #include "xe_vm.h"
@@ -551,12 +555,32 @@ static int event_fifo_pending(struct xe_eudebug *d,
 	return 0;
 }
 
-/* Read and written under xe->eudebug.lock, see @eudebug.cap_state */
+/*
+ * xe_oa_stream_open_ioctl_locked() checks the state under the OA gt_lock,
+ * where it cannot take xe->eudebug.lock: __xe_eudebug_enable() calls into
+ * OA with that held. So write it under both, and either is enough to read
+ * it.
+ */
 static void set_cap_state(struct xe_device *xe, enum xe_eudebug_cap_state state)
 {
+	struct xe_gt *gt;
+	u8 id;
+
 	lockdep_assert_held(&xe->eudebug.lock);
 
+	/* Without OA the gt_locks are not even initialized */
+	if (!xe->oa.xe) {
+		xe->eudebug.cap_state = state;
+		return;
+	}
+
+	for_each_gt(gt, xe, id)
+		mutex_lock_nested(&gt->oa.gt_lock, id);
+
 	xe->eudebug.cap_state = state;
+
+	for_each_gt(gt, xe, id)
+		mutex_unlock(&gt->oa.gt_lock);
 }
 
 static bool __xe_eudebug_is_enabled(struct xe_device *xe)
@@ -573,6 +597,19 @@ bool xe_eudebug_is_enabled(struct xe_device *xe)
 	return __xe_eudebug_is_enabled(xe);
 }
 
+/**
+ * xe_eudebug_is_enabled_oa - xe_eudebug_is_enabled() for OA
+ * @gt: the gt whose OA gt_lock the caller holds
+ *
+ * Return: true if eudebug is enabled, see set_cap_state()
+ */
+bool xe_eudebug_is_enabled_oa(struct xe_gt *gt)
+{
+	lockdep_assert_held(&gt->oa.gt_lock);
+
+	return gt_to_xe(gt)->eudebug.cap_state == XE_EUDEBUG_CAP_ENABLED;
+}
+
 static struct xe_eudebug *
 __xe_eudebug_get(struct xe_file *xef)
 {
@@ -896,6 +933,42 @@ struct xe_vm *xe_eudebug_vm_get(struct xe_eudebug *d, u32 id)
 	return vm;
 }
 
+/*
+ * The map keys queues by pointer without holding a reference. While
+ * attached, a destroy removes the handle ahead of the final put, and a
+ * detach clears the map in the same critical section that detaches us, so
+ * a handle found under the lock is never stale.
+ */
+struct xe_exec_queue *xe_eudebug_exec_queue_get(struct xe_eudebug *d, u32 id)
+{
+	struct xe_eudebug_resource *r =
+		resource_from_type(d, XE_EUDEBUG_RES_TYPE_EXEC_QUEUE);
+	struct xe_exec_queue *eq;
+
+	guard(mutex)(&d->lock);
+
+	if (__xe_eudebug_is_detached(d))
+		return ERR_PTR(-ENOTCONN);
+
+	eq = find_resource__unlocked(r, id);
+	if (eq)
+		xe_exec_queue_get(eq);
+
+	return eq ?: ERR_PTR(-EINVAL);
+}
+
+struct xe_lrc *xe_eudebug_find_lrc(struct xe_eudebug *d, u32 id)
+{
+	struct xe_eudebug_resource *r = resource_from_type(d, XE_EUDEBUG_RES_TYPE_LRC);
+	struct xe_lrc *lrc;
+
+	mutex_lock(&d->lock);
+	lrc = find_resource__unlocked(r, id);
+	mutex_unlock(&d->lock);
+
+	return lrc;
+}
+
 static struct drm_xe_eudebug_event *
 xe_eudebug_prepare_event(struct xe_eudebug *d, u16 type, u64 seqno, u16 flags,
 			 u32 len)
@@ -2126,6 +2199,10 @@ static long xe_eudebug_ioctl(struct file *file,
 		ret = xe_eudebug_vm_open_ioctl(d, arg);
 		eu_dbg(d, "ioctl cmd=VM_OPEN ret=%ld\n", ret);
 		break;
+	case DRM_XE_EUDEBUG_IOCTL_EU_CONTROL:
+		ret = xe_eudebug_eu_control(d, arg);
+		eu_dbg(d, "ioctl cmd=EU_CONTROL ret=%ld\n", ret);
+		break;
 	default:
 		ret = -ENOTTY;
 	}
@@ -2250,6 +2327,8 @@ xe_eudebug_connect(struct xe_device *xe,
 		goto err_fd;
 	}
 
+	xe_eudebug_hw_init(d);
+
 	eu_dbg(d, "connected session %llu", d->session);
 
 	drm_dev_get(&xe->drm);
@@ -2283,10 +2362,61 @@ void xe_eudebug_file_close(struct xe_file *xef)
 	up_write(&xef->eudebug.ioctl_lock);
 }
 
+struct eudebug_hw_update {
+	struct work_struct work;
+	struct xe_gt *gt;
+	bool enable;
+};
+
+static void eudebug_hw_update_work(struct work_struct *w)
+{
+	struct eudebug_hw_update *u = container_of(w, typeof(*u), work);
+	struct xe_gt *gt = u->gt;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(gt->hw_engines); i++) {
+		if (!(gt->info.engine_mask & BIT(i)))
+			continue;
+
+		xe_eudebug_init_hw_engine(&gt->hw_engines[i], u->enable);
+	}
+
+	/*
+	 * If a reset is already pending this does not queue another one,
+	 * but that reset is queued behind us and applies the new state.
+	 */
+	xe_gt_reset_async(gt);
+}
+
+/*
+ * The new state only reaches the hardware through a reset applying
+ * hwe->reg_sr. Update the lists from gt->ordered_wq, which is where
+ * gt_reset_worker() runs, so that no reset can be walking them meanwhile,
+ * and so that a reset already in flight, which would make
+ * xe_gt_reset_async() a no-op, has either finished before the update or
+ * runs after it.
+ */
+static void eudebug_hw_update(struct xe_gt *gt, bool enable)
+{
+	struct eudebug_hw_update u = {
+		.gt = gt,
+		.enable = enable,
+	};
+
+	INIT_WORK_ONSTACK(&u.work, eudebug_hw_update_work);
+	queue_work(gt->ordered_wq, &u.work);
+	flush_work(&u.work);
+	destroy_work_on_stack(&u.work);
+
+	flush_work(&gt->reset.worker);
+}
+
 static int __xe_eudebug_enable(struct xe_device *xe, bool enable,
 			       bool *end_lockdown)
 {
+	struct xe_gt *gt;
 	int ret;
+	u8 id;
 
 	guard(mutex)(&xe->eudebug.lock);
 
@@ -2315,6 +2445,36 @@ static int __xe_eudebug_enable(struct xe_device *xe, bool enable,
 		}
 	}
 
+	/*
+	 * eudebug and OA are mutually exclusive: both own EU state, see
+	 * xe_oa_stream_open_ioctl_locked(). Publish the new state before
+	 * looking for streams, and take it back if one is found. An OA open
+	 * racing this is then either seen here, because it took the gt_lock
+	 * first and published its stream, or sees eudebug enabled under that
+	 * same lock and is refused.
+	 */
+	if (enable) {
+		set_cap_state(xe, XE_EUDEBUG_CAP_ENABLED);
+		if (xe_oa_stream_active(xe)) {
+			set_cap_state(xe, XE_EUDEBUG_CAP_DISABLED);
+			/* Nothing was started that the lockdown has to outlive */
+			if (IS_SRIOV_PF(xe))
+				xe_sriov_pf_end_lockdown(xe);
+			drm_dbg(&xe->drm, "Can't enable eudebug: OA stream is open\n");
+			return -EBUSY;
+		}
+	}
+
+	xe_pm_runtime_get(xe);
+	for_each_gt(gt, xe, id) {
+		/* No engine there to program, so no reason to reset it */
+		if (xe_gt_is_media_type(gt))
+			continue;
+
+		eudebug_hw_update(gt, enable);
+	}
+	xe_pm_runtime_put(xe);
+
 	set_cap_state(xe, enable ?
 		      XE_EUDEBUG_CAP_ENABLED : XE_EUDEBUG_CAP_DISABLED);
 
diff --git a/drivers/gpu/drm/xe/xe_eudebug.h b/drivers/gpu/drm/xe/xe_eudebug.h
index ce61537a596e..11a40bc33e6e 100644
--- a/drivers/gpu/drm/xe/xe_eudebug.h
+++ b/drivers/gpu/drm/xe/xe_eudebug.h
@@ -14,6 +14,7 @@ struct drm_file;
 struct xe_debug_data;
 struct xe_device;
 struct xe_file;
+struct xe_gt;
 struct xe_vm;
 struct xe_exec_queue;
 struct xe_vma;
@@ -53,6 +54,7 @@ int xe_eudebug_connect_ioctl(struct drm_device *dev,
 void xe_eudebug_init(struct xe_device *xe);
 void xe_eudebug_init_early(struct xe_device *xe);
 bool xe_eudebug_is_enabled(struct xe_device *xe);
+bool xe_eudebug_is_enabled_oa(struct xe_gt *gt);
 
 int xe_eudebug_track_exec_queue(struct xe_exec_queue *q);
 void xe_eudebug_untrack_exec_queue(struct xe_exec_queue *q);
@@ -70,6 +72,8 @@ struct xe_vm *xe_eudebug_vm_get(struct xe_eudebug *d, u32 vm_id);
 
 void xe_eudebug_exec_queue_create(struct xe_file *xef, struct xe_exec_queue *q);
 void xe_eudebug_exec_queue_destroy(struct xe_file *xef, struct xe_exec_queue *q);
+struct xe_exec_queue *xe_eudebug_exec_queue_get(struct xe_eudebug *d, u32 id);
+struct xe_lrc *xe_eudebug_find_lrc(struct xe_eudebug *d, u32 id);
 
 void xe_eudebug_vm_bind_execute(struct xe_vm *vm, struct xe_vma_ops *ops);
 
@@ -86,6 +90,7 @@ static inline int xe_eudebug_connect_ioctl(struct drm_device *dev,
 static inline void xe_eudebug_init(struct xe_device *xe) { }
 static inline void xe_eudebug_init_early(struct xe_device *xe) { }
 static inline bool xe_eudebug_is_enabled(struct xe_device *xe) { return false; }
+static inline bool xe_eudebug_is_enabled_oa(struct xe_gt *gt) { return false; }
 static inline int xe_eudebug_track_exec_queue(struct xe_exec_queue *q) { return 0; }
 static inline void xe_eudebug_untrack_exec_queue(struct xe_exec_queue *q) { }
 
diff --git a/drivers/gpu/drm/xe/xe_eudebug_hw.c b/drivers/gpu/drm/xe/xe_eudebug_hw.c
index 7388facfe0a5..3c025f279488 100644
--- a/drivers/gpu/drm/xe/xe_eudebug_hw.c
+++ b/drivers/gpu/drm/xe/xe_eudebug_hw.c
@@ -24,8 +24,10 @@
 #include "xe_lrc.h"
 #include "xe_macros.h"
 #include "xe_mmio.h"
+#include "xe_pm.h"
 #include "xe_reg_sr.h"
 #include "xe_rtp.h"
+#include "xe_vm.h"
 #include "xe_wa.h"
 
 static void add_sr_entry(struct xe_hw_engine *hwe,
@@ -69,3 +71,736 @@ void xe_eudebug_init_hw_engine(struct xe_hw_engine *hwe, bool enable)
 		add_sr_entry(hwe, TD_CTL,
 			     TD_CTL_GLOBAL_DEBUG_ENABLE, enable);
 }
+
+static int read_hw_lrca_fw(struct xe_hw_engine *hwe, u32 *lrc_hw)
+{
+	u32 lrc_reg;
+
+	lrc_reg = xe_hw_engine_mmio_read32(hwe, RING_CURRENT_LRCA(0));
+
+	if (!(lrc_reg & CURRENT_LRCA_VALID))
+		return -ENOENT;
+
+	*lrc_hw = lrc_reg & GENMASK(31, 12);
+
+	return 0;
+}
+
+static int read_hw_lrca(struct xe_hw_engine *hwe, u32 *lrc_hw)
+{
+	unsigned int fw_ref;
+	int ret;
+
+	fw_ref = xe_force_wake_get(gt_to_fw(hwe->gt), hwe->domain);
+	if (!fw_ref)
+		return -ETIMEDOUT;
+
+	ret = read_hw_lrca_fw(hwe, lrc_hw);
+
+	xe_force_wake_put(gt_to_fw(hwe->gt), fw_ref);
+
+	return ret;
+}
+
+static bool lrca_equals(u32 a, u32 b)
+{
+	return (a & GENMASK(31, 12)) == (b & GENMASK(31, 12));
+}
+
+static int match_exec_queue_lrca(struct xe_exec_queue *q, u32 lrc_hw)
+{
+	int i;
+
+	for (i = 0; i < q->width; i++)
+		if (lrca_equals(lower_32_bits(xe_lrc_descriptor(q->lrc[i])), lrc_hw))
+			return i;
+
+	return -1;
+}
+
+static int rcu_debug1_engine_index(const struct xe_hw_engine * const hwe)
+{
+	if (hwe->class == XE_ENGINE_CLASS_RENDER) {
+		XE_WARN_ON(hwe->instance);
+		return 0;
+	}
+
+	XE_WARN_ON(hwe->instance > 3);
+
+	return hwe->instance + 1;
+}
+
+static u32 engine_status_xe1(const struct xe_hw_engine * const hwe,
+			     u32 rcu_debug1)
+{
+	const unsigned int first = 7;
+	const unsigned int incr = 3;
+	const unsigned int i = rcu_debug1_engine_index(hwe);
+	const unsigned int shift = first + (i * incr);
+
+	return (rcu_debug1 >> shift) & RCU_DEBUG_1_ENGINE_STATUS;
+}
+
+static u32 engine_status_xe2(const struct xe_hw_engine * const hwe,
+			     u32 rcu_debug1)
+{
+	const unsigned int first = 7;
+	const unsigned int incr = 4;
+	const unsigned int i = rcu_debug1_engine_index(hwe);
+	const unsigned int shift = first + (i * incr);
+
+	return (rcu_debug1 >> shift) & RCU_DEBUG_1_ENGINE_STATUS;
+}
+
+static u32 engine_status_xe3(const struct xe_hw_engine * const hwe,
+			     u32 rcu_debug1)
+{
+	const unsigned int first = 6;
+	const unsigned int incr = 4;
+	const unsigned int i = rcu_debug1_engine_index(hwe);
+	const unsigned int shift = first + (i * incr);
+
+	return (rcu_debug1 >> shift) & RCU_DEBUG_1_ENGINE_STATUS;
+}
+
+static u32 engine_status(const struct xe_hw_engine * const hwe,
+			 u32 rcu_debug1)
+{
+	u32 status = 0;
+
+	if (GRAPHICS_VER(gt_to_xe(hwe->gt)) < 20)
+		status = engine_status_xe1(hwe, rcu_debug1);
+	else if (GRAPHICS_VER(gt_to_xe(hwe->gt)) < 30)
+		status = engine_status_xe2(hwe, rcu_debug1);
+	else if (GRAPHICS_VER(gt_to_xe(hwe->gt)) < 35)
+		status = engine_status_xe3(hwe, rcu_debug1);
+	else
+		XE_WARN_ON(GRAPHICS_VER(gt_to_xe(hwe->gt)));
+
+	return status;
+}
+
+static bool engine_has_runalone_set(const struct xe_hw_engine * const hwe,
+				    u32 rcu_debug1)
+{
+	return engine_status(hwe, rcu_debug1) & RCU_DEBUG_1_RUNALONE_ACTIVE;
+}
+
+static bool engine_has_context_set(const struct xe_hw_engine * const hwe,
+				   u32 rcu_debug1)
+{
+	return engine_status(hwe, rcu_debug1) & RCU_DEBUG_1_CONTEXT_ACTIVE;
+}
+
+static struct xe_hw_engine *get_runalone_active_hw_engine(struct xe_gt *gt)
+{
+	struct xe_hw_engine *hwe, *first = NULL;
+	unsigned int num_active, id, fw_gt, fw_render;
+	u32 val;
+
+	/* No render/compute engine, and no render domain, elsewhere */
+	if (!xe_gt_is_main_type(gt))
+		return ERR_PTR(-ENOENT);
+
+	/*
+	 * RCU_DEBUG_1 sits in the render forcewake range on gen12 and dg2.
+	 * xe_force_wake_get() wakes one domain per call, so take both.
+	 */
+	fw_gt = xe_force_wake_get(gt_to_fw(gt), XE_FW_GT);
+	fw_render = xe_force_wake_get(gt_to_fw(gt), XE_FW_RENDER);
+	if (!fw_gt || !fw_render) {
+		xe_force_wake_put(gt_to_fw(gt), fw_render);
+		xe_force_wake_put(gt_to_fw(gt), fw_gt);
+		drm_dbg(&gt_to_xe(gt)->drm, "eudbg: runalone failed to get force wake\n");
+		return ERR_PTR(-ETIMEDOUT);
+	}
+
+	val = xe_mmio_read32(&gt->mmio, RCU_DEBUG_1);
+	xe_force_wake_put(gt_to_fw(gt), fw_render);
+	xe_force_wake_put(gt_to_fw(gt), fw_gt);
+
+	drm_dbg(&gt_to_xe(gt)->drm, "eudbg: runalone RCU_DEBUG_1 = 0x%08x\n", val);
+
+	/*
+	 * An all-ones read means the mmio access did not land - the device is
+	 * gone or mid-reset. Decoding it would flag every engine as runalone
+	 * and active and spuriously report several active engines, so bail.
+	 */
+	if (val == ~0u)
+		return ERR_PTR(-EIO);
+
+	num_active = 0;
+	xe_eudebug_for_each_hw_engine(hwe, gt, id) {
+		bool runalone, ctx;
+
+		runalone = engine_has_runalone_set(hwe, val);
+		ctx = engine_has_context_set(hwe, val);
+
+		drm_dbg(&gt_to_xe(gt)->drm, "eudbg: engine %s: runalone=%s, context=%s\n",
+			hwe->name, runalone ? "active" : "inactive",
+			ctx ? "active" : "inactive");
+
+		/*
+		 * On discrete parts the context status can read idle while
+		 * the context has raised attention, so do not rely on the
+		 * active bit there.
+		 */
+		if (IS_DGFX(gt_to_xe(gt)))
+			ctx = true;
+
+		if (runalone && ctx) {
+			num_active++;
+
+			drm_dbg(&gt_to_xe(gt)->drm, "eudbg: runalone engine %s %s\n",
+				hwe->name, first ? "ignored" : "selected");
+			if (!first)
+				first = hwe;
+		}
+	}
+
+	if (num_active > 1)
+		drm_err(&gt_to_xe(gt)->drm, "eudbg: %u runalone engines active!\n",
+			num_active);
+
+	if (!first)
+		return ERR_PTR(-ENOENT);
+
+	return first;
+}
+
+static struct xe_exec_queue *active_hwe_to_exec_queue(struct xe_hw_engine *hwe,
+						      int *lrc_idx)
+{
+	struct xe_device *xe = gt_to_xe(hwe->gt);
+	struct xe_gt *gt = hwe->gt;
+	struct xe_exec_queue *q, *found = NULL;
+	int idx, err;
+	u32 lrc_hw;
+
+	err = read_hw_lrca(hwe, &lrc_hw);
+	if (err)
+		return ERR_PTR(err);
+
+	mutex_lock(&xe->eudebug.lock);
+	list_for_each_entry(q, &xe->eudebug.targets, eudebug.target_link) {
+		if (q->gt != gt)
+			continue;
+
+		if (q->class != hwe->class)
+			continue;
+
+		idx = match_exec_queue_lrca(q, lrc_hw);
+		if (idx < 0)
+			continue;
+
+		found = xe_exec_queue_get_unless_zero(q);
+		if (!found)
+			continue;
+
+		if (lrc_idx)
+			*lrc_idx = idx;
+
+		break;
+	}
+	mutex_unlock(&xe->eudebug.lock);
+
+	if (!found)
+		return ERR_PTR(-ENOENT);
+
+	/*
+	 * The context can switch out while we walk the target list, so
+	 * both of these are ordinary outcomes rather than driver bugs.
+	 */
+	if (read_hw_lrca(hwe, &lrc_hw)) {
+		xe_exec_queue_put(found);
+		return ERR_PTR(-ENOENT);
+	}
+
+	if (match_exec_queue_lrca(found, lrc_hw) < 0) {
+		xe_exec_queue_put(found);
+		return ERR_PTR(-ENOENT);
+	}
+
+	return found;
+}
+
+struct xe_exec_queue *
+xe_gt_runalone_active_queue_get(struct xe_gt *gt, struct xe_hw_engine **active_hwe,
+				int *lrc_idx)
+{
+	struct xe_hw_engine *active;
+
+	active = get_runalone_active_hw_engine(gt);
+	if (IS_ERR(active))
+		return ERR_CAST(active);
+
+	if (active_hwe)
+		*active_hwe = active;
+
+	return active_hwe_to_exec_queue(active, lrc_idx);
+}
+
+static int check_lrc_sanity(const struct xe_exec_queue *q,
+			    const struct xe_lrc *lrc,
+			    const int lrc_idx)
+{
+	if (lrc_idx >= q->width)
+		return -EINVAL;
+
+	if (q->lrc[lrc_idx] != lrc)
+		return -EINVAL;
+
+	return 0;
+}
+
+/*
+ * The active context was sampled before the bitmask was copied in from
+ * userspace and before eudebug.lock was taken, and the hardware may have
+ * switched since. EU_ATT and EU_ATT_CLR are gt wide, so check again just
+ * before touching them, as xe_eu_control_interrupt_all() does for TD_CTL,
+ * rather than report or clear attention of some other context.
+ */
+static int check_lrc_active(struct xe_hw_engine *hwe, struct xe_lrc *lrc)
+{
+	u32 lrc_hw;
+	int err;
+
+	err = read_hw_lrca(hwe, &lrc_hw);
+	if (err)
+		return err;
+
+	if (!lrca_equals(lower_32_bits(xe_lrc_descriptor(lrc)), lrc_hw))
+		return -EBUSY;
+
+	return 0;
+}
+
+static int do_eu_control(struct xe_eudebug *d,
+			 const struct drm_xe_eudebug_eu_control * const arg,
+			 struct drm_xe_eudebug_eu_control __user * const user_ptr)
+{
+	void __user * const bitmask_ptr = u64_to_user_ptr(arg->bitmask_ptr);
+	struct xe_device *xe = d->xe;
+	struct xe_exec_queue *q, *active;
+	struct xe_hw_engine *active_hwe;
+	struct xe_lrc *lrc;
+	unsigned int hw_attn_size, attn_size;
+	u8 *bits = NULL;
+	u64 seqno;
+	int lrc_idx;
+	int ret;
+
+	if (xe_eudebug_is_detached(d))
+		return -ENOTCONN;
+
+	/* Accept only hardware reg granularity mask */
+	if (XE_IOCTL_DBG(xe, !IS_ALIGNED(arg->bitmask_size, sizeof(u32))))
+		return -EINVAL;
+
+	if (XE_IOCTL_DBG(xe, arg->seqno))
+		return -EINVAL;
+
+	/* Handles are u32 internally, do not let the upper half alias them */
+	if (XE_IOCTL_DBG(xe, arg->exec_queue_handle > U32_MAX ||
+			 arg->lrc_handle > U32_MAX))
+		return -EINVAL;
+
+	q = xe_eudebug_exec_queue_get(d, arg->exec_queue_handle);
+	if (XE_IOCTL_DBG(xe, IS_ERR(q)))
+		return PTR_ERR(q);
+
+	/* Run control is for fault mode vms only, see exec_queue_set_eudebug() */
+	if (XE_IOCTL_DBG(xe, !xe_exec_queue_is_debuggable(q) ||
+			 !xe_vm_in_fault_mode(q->vm))) {
+		ret = -EINVAL;
+		goto queue_put;
+	}
+
+	lrc = xe_eudebug_find_lrc(d, arg->lrc_handle);
+	if (XE_IOCTL_DBG(xe, !lrc)) {
+		ret = -EINVAL;
+		goto queue_put;
+	}
+
+	if (!xe_pm_runtime_get_if_active(xe)) {
+		ret = -EIO;
+		goto queue_put;
+	}
+
+	active = xe_gt_runalone_active_queue_get(q->gt, &active_hwe, &lrc_idx);
+	if (XE_IOCTL_DBG(xe, IS_ERR(active))) {
+		ret = PTR_ERR(active);
+		goto out_pm;
+	}
+
+	if (XE_IOCTL_DBG(xe, q != active)) {
+		ret = -EBUSY;
+		goto active_put;
+	}
+
+	ret = check_lrc_sanity(q, lrc, lrc_idx);
+	if (XE_IOCTL_DBG(xe, ret))
+		goto active_put;
+
+	hw_attn_size = xe_gt_eu_attention_bitmap_size(q->gt);
+	attn_size = arg->bitmask_size;
+
+	if (attn_size > hw_attn_size)
+		attn_size = hw_attn_size;
+
+	/*
+	 * RESUME clears attention, so a short mask cannot be applied and then
+	 * grown and retried like the others: the retry would clear the
+	 * leading threads again, possibly after they hit their next
+	 * breakpoint. Report the size and refuse without touching anything.
+	 */
+	if (XE_IOCTL_DBG(xe, arg->cmd == DRM_XE_EUDEBUG_EU_CONTROL_CMD_RESUME &&
+			 attn_size < hw_attn_size)) {
+		ret = -EINVAL;
+		if (put_user(hw_attn_size, &user_ptr->bitmask_size))
+			ret = -EFAULT;
+		goto active_put;
+	}
+
+	/*
+	 * Keep the zero size case without a buffer: memdup_user() would
+	 * hand back a ZERO_SIZE_PTR, and the copy back to userspace below
+	 * expects NULL when there is nothing to copy.
+	 */
+	if (attn_size > 0) {
+		bits = memdup_user(bitmask_ptr, attn_size);
+		if (IS_ERR(bits)) {
+			ret = PTR_ERR(bits);
+			bits = NULL;
+			goto active_put;
+		}
+	}
+
+	mutex_lock(&xe->eudebug.lock);
+
+	/*
+	 * Check again under the lock: memdup_user() can stall for as long as
+	 * userspace likes, and once detached, eudebug can be disabled and an
+	 * OA stream opened. The detach is published under this lock.
+	 */
+	if (xe_eudebug_is_detached(d)) {
+		ret = -ENOTCONN;
+		goto out_unlock;
+	}
+
+	ret = -EINVAL;
+	switch (arg->cmd) {
+	case DRM_XE_EUDEBUG_EU_CONTROL_CMD_INTERRUPT_ALL:
+		/* Make sure we dont promise anything but interrupting all */
+		if (!attn_size)
+			ret = d->ops->interrupt_all(d, active, active_hwe, lrc);
+		else
+			ret = -EINVAL;
+		break;
+	case DRM_XE_EUDEBUG_EU_CONTROL_CMD_STOPPED:
+		ret = check_lrc_active(active_hwe, lrc);
+		if (!ret)
+			ret = d->ops->stopped(d, active, lrc, bits, attn_size);
+		break;
+	case DRM_XE_EUDEBUG_EU_CONTROL_CMD_RESUME:
+		ret = check_lrc_active(active_hwe, lrc);
+		if (!ret)
+			ret = d->ops->resume(d, active, lrc, bits, attn_size);
+		break;
+	default:
+		break;
+	}
+
+	if (ret == 0)
+		seqno = atomic64_inc_return(&d->events.seqno);
+
+out_unlock:
+	mutex_unlock(&xe->eudebug.lock);
+
+	if (ret)
+		goto out_free;
+
+	if (put_user(seqno, &user_ptr->seqno)) {
+		ret = -EFAULT;
+		goto out_free;
+	}
+
+	/*
+	 * Only STOPPED fills the bitmask. RESUME reads it, and has resumed
+	 * the threads by now, so a buffer it cannot write back to must not
+	 * turn that into an error.
+	 */
+	if (arg->cmd == DRM_XE_EUDEBUG_EU_CONTROL_CMD_STOPPED &&
+	    copy_to_user(bitmask_ptr, bits, attn_size)) {
+		ret = -EFAULT;
+		goto out_free;
+	}
+
+	if (hw_attn_size != arg->bitmask_size)
+		if (put_user(hw_attn_size, &user_ptr->bitmask_size))
+			ret = -EFAULT;
+
+out_free:
+	kfree(bits);
+active_put:
+	xe_exec_queue_put(active);
+out_pm:
+	xe_pm_runtime_put(xe);
+queue_put:
+	xe_exec_queue_put(q);
+
+	return ret;
+}
+
+static int xe_eu_control_interrupt_all(struct xe_eudebug *d,
+				       struct xe_exec_queue *active,
+				       struct xe_hw_engine *hwe,
+				       struct xe_lrc *lrc)
+{
+	unsigned int fw_ref = 0;
+	u32 lrc_hw, lrc_hw_post;
+	u32 td_ctl;
+	int err = -EINVAL;
+
+	fw_ref = xe_force_wake_get(gt_to_fw(active->gt), hwe->domain);
+	if (!fw_ref) {
+		err = -ETIMEDOUT;
+		goto out;
+	}
+
+	/* Additional check just before issuing MMIO writes */
+	err = read_hw_lrca_fw(hwe, &lrc_hw);
+	if (err)
+		goto out;
+
+	if (!lrca_equals(lower_32_bits(xe_lrc_descriptor(lrc)), lrc_hw)) {
+		err = -EBUSY;
+		goto out;
+	}
+
+	td_ctl = xe_gt_mcr_unicast_read_any(active->gt, TD_CTL);
+
+	/* Halt on next thread dispatch */
+	if (!(td_ctl & TD_CTL_FORCE_EXTERNAL_HALT))
+		xe_gt_mcr_multicast_write(active->gt, TD_CTL,
+					  td_ctl | TD_CTL_FORCE_EXTERNAL_HALT);
+	else
+		eu_warn(d, "TD_CTL force external halt bit already set!\n");
+
+	/*
+	 * The sleep is needed because some interrupts are ignored
+	 * by the HW, hence we allow the HW some time to acknowledge
+	 * that.
+	 */
+	usleep_range(100, 110);
+
+	/* Halt regardless of thread dependencies */
+	if (!(td_ctl & TD_CTL_FORCE_EXCEPTION))
+		xe_gt_mcr_multicast_write(active->gt, TD_CTL,
+					  td_ctl | TD_CTL_FORCE_EXCEPTION |
+					  TD_CTL_FORCE_EXTERNAL_HALT);
+	else
+		eu_warn(d, "TD_CTL force exception bit already set!\n");
+
+	usleep_range(100, 110);
+
+	xe_gt_mcr_multicast_write(active->gt, TD_CTL, td_ctl &
+				  ~(TD_CTL_FORCE_EXTERNAL_HALT | TD_CTL_FORCE_EXCEPTION));
+
+	/*
+	 * In case of stopping wrong ctx emit warning.
+	 * Nothing else we can do for now.
+	 */
+	if (!read_hw_lrca_fw(hwe, &lrc_hw_post) &&
+	    !lrca_equals(lrc_hw, lrc_hw_post))
+		eu_warn(d, "interrupted wrong context 0x%08x, wanted 0x%08x\n",
+			lrc_hw_post, lrc_hw);
+
+out:
+	if (fw_ref)
+		xe_force_wake_put(gt_to_fw(active->gt), fw_ref);
+
+	return err;
+}
+
+struct ss_iter {
+	struct xe_eudebug *debugger;
+	unsigned int i;
+
+	unsigned int size;
+	u8 *bits;
+};
+
+/*
+ * check_attn_mcr() and clear_attn_mcr() run under
+ * xe_gt_foreach_dss_group_instance(), which holds the GT and render forcewake
+ * that EU_ATT and EU_ATT_CLR need.
+ */
+static int check_attn_mcr(struct xe_gt *gt, void *data,
+			  u16 group, u16 instance, bool present)
+{
+	struct ss_iter *iter = data;
+	struct xe_eudebug *d = iter->debugger;
+	unsigned int reg, row;
+
+	for (reg = 0; reg < xe_gt_eu_att_regs(gt); reg++) {
+		for (row = 0; row < XE_GT_EU_ATT_ROWS; row++) {
+			u32 val, cur = 0;
+
+			if (iter->i + sizeof(val) > iter->size)
+				return 0;
+
+			memcpy(&val, &iter->bits[iter->i], sizeof(val));
+			iter->i += sizeof(val);
+
+			if (present)
+				cur = xe_gt_mcr_unicast_read(gt, EU_ATT(reg, row), group, instance);
+
+			if ((val | cur) != cur) {
+				eu_dbg(d,
+				       "WRONG CLEAR (%u:%u:%u:%u) EU_ATT_CLR: 0x%08x; EU_ATT: 0x%08x\n",
+				       group, instance, reg, row, val, cur);
+				return -EINVAL;
+			}
+		}
+	}
+
+	return 0;
+}
+
+static int clear_attn_mcr(struct xe_gt *gt, void *data,
+			  u16 group, u16 instance, bool present)
+{
+	struct ss_iter *iter = data;
+	struct xe_eudebug *d = iter->debugger;
+	unsigned int reg, row;
+
+	for (reg = 0; reg < xe_gt_eu_att_regs(gt); reg++) {
+		for (row = 0; row < XE_GT_EU_ATT_ROWS; row++) {
+			u32 val;
+
+			if (iter->i + sizeof(val) > iter->size)
+				return 0;
+
+			memcpy(&val, &iter->bits[iter->i], sizeof(val));
+			iter->i += sizeof(val);
+
+			if (!val)
+				continue;
+
+			if (present) {
+				xe_gt_mcr_unicast_write(gt, EU_ATT_CLR(reg, row), val,
+							group, instance);
+
+				eu_dbg(d,
+				       "EU_ATT_CLR: (%u:%u:%u:%u): 0x%08x\n",
+				       group, instance, reg, row, val);
+			} else {
+				eu_dbg(d,
+				       "EU_ATT_CLR: (%u:%u:%u:%u): 0x%08x to fused off dss\n",
+				       group, instance, reg, row, val);
+			}
+		}
+	}
+
+	return 0;
+}
+
+static int xe_eu_control_resume(struct xe_eudebug *d,
+				struct xe_exec_queue *active,
+				struct xe_lrc *lrc,
+				u8 *bits, unsigned int bitmask_size)
+{
+	struct ss_iter iter = {
+		.debugger = d,
+		.i = 0,
+		.size = bitmask_size,
+		.bits = bits
+	};
+
+	/*
+	 * hsdes: 18021122357
+	 * We need to avoid clearing attention bits that are not set
+	 * in order to avoid the EOT hang on PVC.
+	 */
+	if (GRAPHICS_VERx100(d->xe) == 1260) {
+		int err;
+
+		err = xe_gt_foreach_dss_group_instance(active->gt, check_attn_mcr, &iter);
+		if (err)
+			return err;
+
+		iter.i = 0;
+	}
+
+	return xe_gt_foreach_dss_group_instance(active->gt, clear_attn_mcr, &iter);
+}
+
+static int xe_eu_control_stopped(struct xe_eudebug *d,
+				 struct xe_exec_queue *active,
+				 struct xe_lrc *lrc,
+				 u8 *bits, unsigned int bitmask_size)
+{
+	return xe_gt_eu_attention_bitmap(active->gt, bits, bitmask_size);
+}
+
+static const struct xe_eudebug_eu_control_ops eu_control = {
+	.interrupt_all = xe_eu_control_interrupt_all,
+	.stopped = xe_eu_control_stopped,
+	.resume = xe_eu_control_resume,
+};
+
+void xe_eudebug_hw_init(struct xe_eudebug *d)
+{
+	d->ops = &eu_control;
+}
+
+long xe_eudebug_eu_control(struct xe_eudebug *d, const u64 arg)
+{
+	struct drm_xe_eudebug_eu_control __user * const user_ptr =
+		u64_to_user_ptr(arg);
+	struct drm_xe_eudebug_eu_control user_arg;
+	struct xe_device *xe = d->xe;
+	int ret;
+
+	BUILD_BUG_ON(!(_IOC_DIR(DRM_XE_EUDEBUG_IOCTL_EU_CONTROL) & _IOC_WRITE));
+	BUILD_BUG_ON(!(_IOC_DIR(DRM_XE_EUDEBUG_IOCTL_EU_CONTROL) & _IOC_READ));
+	BUILD_BUG_ON(_IOC_SIZE(DRM_XE_EUDEBUG_IOCTL_EU_CONTROL) != sizeof(user_arg));
+
+	if (copy_from_user(&user_arg,
+			   user_ptr,
+			   sizeof(user_arg)))
+		return -EFAULT;
+
+	if (XE_IOCTL_DBG(xe, user_arg.flags))
+		return -EINVAL;
+
+	if (XE_IOCTL_DBG(xe, user_arg.reserved))
+		return -EINVAL;
+
+	if (XE_IOCTL_DBG(xe,
+			 user_arg.cmd != DRM_XE_EUDEBUG_EU_CONTROL_CMD_INTERRUPT_ALL &&
+			 user_arg.cmd != DRM_XE_EUDEBUG_EU_CONTROL_CMD_STOPPED &&
+			 user_arg.cmd != DRM_XE_EUDEBUG_EU_CONTROL_CMD_RESUME))
+		return -EINVAL;
+
+	if (XE_IOCTL_DBG(xe, IS_SRIOV_VF(xe)))
+		return -EPERM;
+
+	if (!access_ok(u64_to_user_ptr(user_arg.bitmask_ptr), user_arg.bitmask_size))
+		return -EFAULT;
+
+	eu_dbg(d,
+	       "eu_control: cmd=%u, flags=0x%x, exec_queue_handle=%llu, bitmask_size=%u\n",
+	       user_arg.cmd, user_arg.flags, user_arg.exec_queue_handle,
+	       user_arg.bitmask_size);
+
+	ret = do_eu_control(d, &user_arg, user_ptr);
+
+	eu_dbg(d,
+	       "eu_control: cmd=%u, flags=0x%x, exec_queue_handle=%llu, bitmask_size=%u ret=%d\n",
+	       user_arg.cmd, user_arg.flags, user_arg.exec_queue_handle,
+	       user_arg.bitmask_size, ret);
+
+	return ret;
+}
diff --git a/drivers/gpu/drm/xe/xe_eudebug_hw.h b/drivers/gpu/drm/xe/xe_eudebug_hw.h
index 447e83cd4e38..8c9d8fea1189 100644
--- a/drivers/gpu/drm/xe/xe_eudebug_hw.h
+++ b/drivers/gpu/drm/xe/xe_eudebug_hw.h
@@ -14,8 +14,15 @@ struct xe_gt;
 
 #if IS_ENABLED(CONFIG_DRM_XE_EUDEBUG)
 
+void xe_eudebug_hw_init(struct xe_eudebug *d);
 void xe_eudebug_init_hw_engine(struct xe_hw_engine *hwe, bool enable);
 
+long xe_eudebug_eu_control(struct xe_eudebug *d, const u64 arg);
+
+struct xe_exec_queue *xe_gt_runalone_active_queue_get(struct xe_gt *gt,
+						      struct xe_hw_engine **active_hwe,
+						      int *lrc_idx);
+
 #endif /* CONFIG_DRM_XE_EUDEBUG */
 
 #endif /* _XE_EUDEBUG_HW_H_ */
diff --git a/drivers/gpu/drm/xe/xe_eudebug_types.h b/drivers/gpu/drm/xe/xe_eudebug_types.h
index a8a440c62c4f..9cbcadecb2a7 100644
--- a/drivers/gpu/drm/xe/xe_eudebug_types.h
+++ b/drivers/gpu/drm/xe/xe_eudebug_types.h
@@ -19,6 +19,10 @@
 #include <uapi/drm/xe_drm_eudebug.h>
 
 struct xe_device;
+struct xe_eudebug;
+struct xe_hw_engine;
+struct xe_exec_queue;
+struct xe_lrc;
 
 /**
  * enum xe_eudebug_cap_state - eudebug capability state
@@ -68,6 +72,24 @@ struct xe_eudebug_resource {
 #define XE_EUDEBUG_RES_TYPE_LRC		2
 #define XE_EUDEBUG_RES_TYPE_COUNT	(XE_EUDEBUG_RES_TYPE_LRC + 1)
 
+/**
+ * struct xe_eudebug_eu_control_ops - interface for eu thread
+ * state control backend
+ */
+struct xe_eudebug_eu_control_ops {
+	/** @interrupt_all: interrupts workload active on given hwe */
+	int (*interrupt_all)(struct xe_eudebug *e, struct xe_exec_queue *q,
+			     struct xe_hw_engine *hwe, struct xe_lrc *lrc);
+
+	/** @resume: resumes threads reflected by bitmask active on given hwe */
+	int (*resume)(struct xe_eudebug *e, struct xe_exec_queue *q,
+		      struct xe_lrc *lrc, u8 *bitmap, unsigned int bitmap_size);
+
+	/** @stopped: returns bitmap reflecting threads which signal attention */
+	int (*stopped)(struct xe_eudebug *e, struct xe_exec_queue *q,
+		       struct xe_lrc *lrc, u8 *bitmap, unsigned int bitmap_size);
+};
+
 /**
  * struct xe_eudebug - Top level struct for eudebug: the connection
  */
@@ -182,6 +204,9 @@ struct xe_eudebug {
 		/** @acks.tree: pending acks by seqnos */
 		struct rb_root tree;
 	} acks;
+
+	/** @ops: operations for eu_control */
+	const struct xe_eudebug_eu_control_ops *ops;
 };
 
 #endif /* _XE_EUDEBUG_TYPES_H_ */
diff --git a/drivers/gpu/drm/xe/xe_oa.c b/drivers/gpu/drm/xe/xe_oa.c
index fe91abaccb14..52b3f342344a 100644
--- a/drivers/gpu/drm/xe/xe_oa.c
+++ b/drivers/gpu/drm/xe/xe_oa.c
@@ -1865,6 +1865,40 @@ static int xe_oa_stream_init(struct xe_oa_stream *stream,
 	return ret;
 }
 
+/**
+ * xe_oa_stream_active() - Whether any OA unit has a stream open
+ * @xe: the &xe_device
+ *
+ * Return: true if a stream is open on any OA unit of any gt.
+ */
+bool xe_oa_stream_active(struct xe_device *xe)
+{
+	struct xe_gt *gt;
+	u8 id;
+
+	/* Without OA the gt_locks are not even initialized */
+	if (!xe->oa.xe)
+		return false;
+
+	for_each_gt(gt, xe, id) {
+		unsigned int i;
+		bool active = false;
+
+		mutex_lock(&gt->oa.gt_lock);
+		for (i = 0; i < gt->oa.num_oa_units; i++)
+			if (gt->oa.oa_unit[i].exclusive_stream) {
+				active = true;
+				break;
+			}
+		mutex_unlock(&gt->oa.gt_lock);
+
+		if (active)
+			return true;
+	}
+
+	return false;
+}
+
 static int xe_oa_stream_open_ioctl_locked(struct xe_oa *oa,
 					  struct xe_oa_open_param *param)
 {
@@ -1880,6 +1914,21 @@ static int xe_oa_stream_open_ioctl_locked(struct xe_oa *oa,
 		goto exit;
 	}
 
+	/*
+	 * eudebug and OA both change EU and engine state that the other
+	 * relies on, such as the debug registers and workarounds eudebug
+	 * keeps in hwe->reg_sr and the settings OA changes and restores
+	 * around a stream. They do not have to run at the same time, so
+	 * refuse rather than interleave. xe_eudebug_enable() checks the
+	 * other direction with xe_oa_stream_active(), under the same
+	 * gt_lock held here.
+	 */
+	if (xe_eudebug_is_enabled_oa(param->hwe->gt)) {
+		drm_dbg(&oa->xe->drm, "OA not available while eudebug is enabled\n");
+		ret = -EBUSY;
+		goto exit;
+	}
+
 	ret = drm_syncobj_create(&ufence_syncobj, DRM_SYNCOBJ_CREATE_SIGNALED,
 				 NULL);
 	if (ret)
@@ -2090,6 +2139,17 @@ int xe_oa_stream_open_ioctl(struct drm_device *dev, u64 data, struct drm_file *f
 			ret = -EOPNOTSUPP;
 			goto err_exec_q;
 		}
+
+		/*
+		 * A debuggable queue runs with a preemption timeout of 0 so
+		 * that a debugger can hold its threads halted, and a stream
+		 * may change and restore engine settings around it. Keep
+		 * debuggable queues out of OA.
+		 */
+		if (XE_IOCTL_DBG(oa->xe, xe_exec_queue_is_debuggable(param.exec_q))) {
+			ret = -EBUSY;
+			goto err_exec_q;
+		}
 	}
 
 	/*
diff --git a/drivers/gpu/drm/xe/xe_oa.h b/drivers/gpu/drm/xe/xe_oa.h
index e510826f9efc..e40a6c418788 100644
--- a/drivers/gpu/drm/xe/xe_oa.h
+++ b/drivers/gpu/drm/xe/xe_oa.h
@@ -17,6 +17,7 @@ struct xe_hw_engine;
 int xe_oa_init(struct xe_device *xe);
 int xe_oa_register(struct xe_device *xe);
 int xe_oa_stream_open_ioctl(struct drm_device *dev, u64 data, struct drm_file *file);
+bool xe_oa_stream_active(struct xe_device *xe);
 int xe_oa_add_config_ioctl(struct drm_device *dev, u64 data, struct drm_file *file);
 int xe_oa_remove_config_ioctl(struct drm_device *dev, u64 data, struct drm_file *file);
 u32 xe_oa_timestamp_frequency(struct xe_gt *gt);
diff --git a/include/uapi/drm/xe_drm_eudebug.h b/include/uapi/drm/xe_drm_eudebug.h
index 4bb01a3c4fe4..fd498480df84 100644
--- a/include/uapi/drm/xe_drm_eudebug.h
+++ b/include/uapi/drm/xe_drm_eudebug.h
@@ -41,6 +41,7 @@ extern "C" {
 #define DRM_XE_EUDEBUG_IOCTL_READ_EVENT		_IOWR('j', 0x40, struct drm_xe_eudebug_event)
 #define DRM_XE_EUDEBUG_IOCTL_ACK_EVENT		_IOW('j', 0x41, struct drm_xe_eudebug_ack)
 #define DRM_XE_EUDEBUG_IOCTL_VM_OPEN		_IOW('j', 0x42, struct drm_xe_eudebug_vm_open)
+#define DRM_XE_EUDEBUG_IOCTL_EU_CONTROL		_IOWR('j', 0x43, struct drm_xe_eudebug_eu_control)
 
 /**
  * struct drm_xe_eudebug_event - Base type of event delivered by xe_eudebug.
@@ -407,6 +408,73 @@ struct drm_xe_eudebug_vm_open {
 	__u64 timeout_ns;
 };
 
+/**
+ * struct drm_xe_eudebug_eu_control - Control EU states
+ *
+ * Issue commands to execution units in hardware.
+ *
+ * With DRM_XE_EUDEBUG_IOCTL_EU_CONTROL debugger can
+ * interrupt all threads on execution units, query thread
+ * state and resume execution.
+ *
+ * :c:member:`drm_xe_eudebug_eu_control.seqno`
+ * will be updated to the timeline point when
+ * the command was issued.
+ *
+ * :c:member:`drm_xe_eudebug_eu_control.cmd` can
+ * be following:
+ *
+ * *DRM_XE_EUDEBUG_EU_CONTROL_CMD_INTERRUPT_ALL*
+ *  will instruct hardware to stop all threads on EUs
+ *  for exec_queue:lrc. This command takes no bitmask, so
+ *  :c:member:`drm_xe_eudebug_eu_control.bitmask_size`
+ *  must be set to zero.
+ *
+ * *DRM_XE_EUDEBUG_EU_CONTROL_CMD_STOPPED*
+ *  returns the bitmask for threads that are
+ *  in so called attention state.
+ *
+ * *DRM_XE_EUDEBUG_EU_CONTROL_CMD_RESUME*
+ *  resumes the threads whose bit is set in the bitmask.
+ *
+ */
+struct drm_xe_eudebug_eu_control {
+	/** @cmd: Command for execution units */
+#define DRM_XE_EUDEBUG_EU_CONTROL_CMD_INTERRUPT_ALL	0
+#define DRM_XE_EUDEBUG_EU_CONTROL_CMD_STOPPED		1
+#define DRM_XE_EUDEBUG_EU_CONTROL_CMD_RESUME		2
+	__u32 cmd;
+
+	/** @flags: Flags, must be set to zero */
+	__u32 flags;
+
+	/** @seqno: Seqno, must be set to zero */
+	__u64 seqno;
+
+	/** @exec_queue_handle: Exec queue handle for the command */
+	__u64 exec_queue_handle;
+
+	/** @lrc_handle: LRC handle for the command */
+	__u64 lrc_handle;
+
+	/** @reserved: Reserved field, must be set to zero */
+	__u32 reserved;
+
+	/**
+	 * @bitmask_size: Bitmask size in bytes
+	 *
+	 * Only the leading bytes that fit are used. If this differs from
+	 * the size the hardware bitmask needs, it is overwritten with that
+	 * size on return, so a short buffer can be grown and the command
+	 * retried. RESUME does not take a short buffer: it fails with
+	 * -EINVAL and resumes nothing, but still reports the size.
+	 */
+	__u32 bitmask_size;
+
+	/** @bitmask_ptr: Bitmask pointer, each bit is one thread */
+	__u64 bitmask_ptr;
+};
+
 #if defined(__cplusplus)
 }
 #endif
-- 
2.53.0

