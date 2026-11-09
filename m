Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B817606A31C
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 13:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AU2IWKn2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64BBF10E8B3;
	Mon,  9 Nov 2026 13:56:51 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 558C010E4A8;
 Mon,  9 Nov 2026 13:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794232604; x=1825768604;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=f6OHxQPWLyEBdBjSXY8wfjrVr9mHiwS1tzioJwnNzQM=;
 b=AU2IWKn2Dd4rcU39sOurmZhUrPHmTQSTQpm96yMOSCbYw1ggiENK0OKo
 a/AbkVU/qKK9jhqqDYXpFEbqRkVMkVBsWtJzUtuc6tXiVhhgQPyHB/6YU
 ApcfkYd3jb/XlkhDhgT1PBEeQAG87loYmcYUnvzXwZAIP2bxYoVLGzFl6
 rmMUnUQFF0oPivEeOJLW2dqCCYTgTeacyOvOLslWeK6tpTZTy1iRMvdxK
 p2exdSmNprcyVdrgs7Xxp8N0nbWarJ514VAoEqnM6Kbgkfb8raJ13jKVz
 ZR+DQkgji90b7lxbitF0Q8ufFLr6279XpDd7cDd5xMsue2XIpe5eEzIJy w==;
X-CSE-ConnectionGUID: KMa8oKb+RwuxKEARKRDpQg==
X-CSE-MsgGUID: INKx93x1RPO1c0jeZkb+Bg==
X-IronPort-AV: E=McAfee;i="6800,10657,11960"; a="2850759"
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="2850759"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 05:56:44 -0800
X-CSE-ConnectionGUID: Aw4tGhsfQYCQlhQkRSexEg==
X-CSE-MsgGUID: 9vFr6umYQZ2iaNXZ9TMGAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="8202671"
Received: from pgcooper-mobl2.ger.corp.intel.com (HELO
 mkuoppal-desk.home.arpa) ([10.245.246.220])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 05:56:38 -0800
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
 Mika Kuoppala <mika.kuoppala@linux.intel.com>
Subject: [PATCH 07/20] drm/xe: Add EUDEBUG_ENABLE exec queue property
Date: Mon,  9 Nov 2026 15:55:32 +0200
Message-ID: <20261109135549.4128280-8-mika.kuoppala@linux.intel.com>
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

Introduce an immutable eudebug property for exec_queues,
using a flags value to enable eudebug-specific features. For now, the
engine LRC uses this flag to enable the runalone hardware feature.
Runalone ensures that only one hardware engine in a group
[rcs0, ccs0-3] is active on a tile.

v2: - check CONFIG_DRM_XE_EUDEBUG and LR mode (Matthew)
    - disable preempt (Dominik)
    - lrc_create remove from engine init
v3: - remove redundant runalone setup (Sashiko)
v4: - deny if pxp is on (Sashiko)
    - deny if secondary mq (Sashiko)
    - deny if parallel (Sashiko)
    - really deny if pxp (Claude)
v5: - fix the multiqueue (Sashiko)

Cc: Matthew Brost <matthew.brost@intel.com>
Signed-off-by: Dominik Grzegorzek <dominik.grzegorzek@intel.com>
Signed-off-by: Mika Kuoppala <mika.kuoppala@linux.intel.com>
---
 .../ABI/testing/sysfs-driver-intel-xe-eudebug | 10 +++
 drivers/gpu/drm/xe/xe_exec_queue.c            | 81 ++++++++++++++++++-
 drivers/gpu/drm/xe/xe_exec_queue.h            |  2 +
 drivers/gpu/drm/xe/xe_exec_queue_types.h      |  7 ++
 drivers/gpu/drm/xe/xe_hw_engine.h             |  9 +++
 include/uapi/drm/xe_drm.h                     | 12 +++
 6 files changed, 120 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-intel-xe-eudebug b/Documentation/ABI/testing/sysfs-driver-intel-xe-eudebug
index 884a791789ad..50ab7db1f811 100644
--- a/Documentation/ABI/testing/sysfs-driver-intel-xe-eudebug
+++ b/Documentation/ABI/testing/sysfs-driver-intel-xe-eudebug
@@ -24,6 +24,16 @@ Description:	RW. Controls whether the EU debugger interface is armed for
 		have to close them or be terminated. A connection shows up as
 		an "anon_inode:[xe_eudebug]" entry under /proc/<pid>/fd.
 
+		Once enabled, any client with access to the render node can
+		also create debuggable exec queues
+		(DRM_XE_EXEC_QUEUE_SET_PROPERTY_EUDEBUG), whether or not a
+		debugger is attached. While such a queue executes, the other
+		render and compute engines of its tile are kept idle
+		(runalone), and as its preemption timeout is infinite it is
+		not reset if it does not yield the engine when preempted.
+		Work from other clients on those engines can therefore be
+		held off for as long as such a queue keeps running.
+
 		Each connection allocates about 4 MiB of kernel memory for
 		its event queue, held until the connection is closed. The
 		number of connections is not limited beyond the file
diff --git a/drivers/gpu/drm/xe/xe_exec_queue.c b/drivers/gpu/drm/xe/xe_exec_queue.c
index 7ade915c59a8..e65bda492e58 100644
--- a/drivers/gpu/drm/xe/xe_exec_queue.c
+++ b/drivers/gpu/drm/xe/xe_exec_queue.c
@@ -31,6 +31,7 @@
 #include "xe_trace.h"
 #include "xe_vm.h"
 #include "xe_pxp.h"
+#include "xe_eudebug.h"
 
 /**
  * DOC: Execution Queue
@@ -416,6 +417,9 @@ static int __xe_exec_queue_init(struct xe_exec_queue *q, u32 exec_queue_flags)
 	if (q->flags & EXEC_QUEUE_FLAG_DISABLE_STATE_CACHE_PERF_FIX)
 		flags |= XE_LRC_DISABLE_STATE_CACHE_PERF_FIX;
 
+	if (q->eudebug_flags & EXEC_QUEUE_EUDEBUG_FLAG_ENABLE)
+		flags |= XE_LRC_CREATE_RUNALONE;
+
 	err = q->ops->init(q);
 	if (err)
 		return err;
@@ -1050,6 +1054,57 @@ static int exec_queue_set_state_cache_perf_fix(struct xe_device *xe, struct xe_e
 	return 0;
 }
 
+static int exec_queue_set_eudebug(struct xe_device *xe, struct xe_exec_queue *q,
+				  u64 value)
+{
+	const u64 known_flags = DRM_XE_EXEC_QUEUE_EUDEBUG_FLAG_ENABLE;
+
+	if (XE_IOCTL_DBG(xe, !xe_engine_supports_eudebug(q->class)))
+		return -EINVAL;
+
+	if (XE_IOCTL_DBG(xe, (value & ~known_flags)))
+		return -EINVAL;
+
+	if (XE_IOCTL_DBG(xe, !IS_ENABLED(CONFIG_DRM_XE_EUDEBUG)))
+		return -EOPNOTSUPP;
+
+	/*
+	 * The preemption timeout below is infinite, which is only safe where
+	 * no dma-fence waits for the queue to be preempted: a fault mode vm
+	 * has no preempt fences.
+	 */
+	if (XE_IOCTL_DBG(xe, !xe_exec_queue_is_lr(q) ||
+			 !xe_vm_in_fault_mode(q->vm)))
+		return -EINVAL;
+
+	if (XE_IOCTL_DBG(xe, xe_exec_queue_is_parallel(q)))
+		return -EINVAL;
+
+	if (XE_IOCTL_DBG(xe,
+			 !(value & DRM_XE_EXEC_QUEUE_EUDEBUG_FLAG_ENABLE)))
+		return -EINVAL;
+
+	if (XE_IOCTL_DBG(xe, !xe_eudebug_is_enabled(xe)))
+		return -EPERM;
+
+	q->eudebug_flags = EXEC_QUEUE_EUDEBUG_FLAG_ENABLE;
+	q->sched_props.preempt_timeout_us = 0;
+
+	return 0;
+}
+
+/**
+ * xe_exec_queue_is_debuggable() - Whether an exec_queue is debuggable
+ * @q: The exec_queue
+ *
+ * Return: True if @q was created with %DRM_XE_EXEC_QUEUE_SET_PROPERTY_EUDEBUG,
+ * false otherwise.
+ */
+bool xe_exec_queue_is_debuggable(struct xe_exec_queue *q)
+{
+	return q->eudebug_flags & EXEC_QUEUE_EUDEBUG_FLAG_ENABLE;
+}
+
 typedef int (*xe_exec_queue_set_property_fn)(struct xe_device *xe,
 					     struct xe_exec_queue *q,
 					     u64 value);
@@ -1064,6 +1119,7 @@ static const xe_exec_queue_set_property_fn exec_queue_set_property_funcs[] = {
 							exec_queue_set_multi_queue_priority,
 	[DRM_XE_EXEC_QUEUE_SET_DISABLE_STATE_CACHE_PERF_FIX] =
 							exec_queue_set_state_cache_perf_fix,
+	[DRM_XE_EXEC_QUEUE_SET_PROPERTY_EUDEBUG] = exec_queue_set_eudebug,
 };
 
 /**
@@ -1136,6 +1192,28 @@ static int exec_queue_user_ext_check(struct xe_exec_queue *q, u64 properties)
 			 (properties & BIT_ULL(DRM_XE_EXEC_QUEUE_SET_PROPERTY_PXP_TYPE))))
 		return -EINVAL;
 
+	/*
+	 * A debugger can inspect and modify the EU state and memory of a
+	 * debuggable queue, so it must not be combined with protected content.
+	 * Test the property mask rather than the queue state, as the extensions
+	 * are applied in the order userspace chained them and either one may be
+	 * processed first.
+	 */
+	if (XE_IOCTL_DBG(xe, (properties & BIT_ULL(DRM_XE_EXEC_QUEUE_SET_PROPERTY_EUDEBUG)) &&
+			 (properties & BIT_ULL(DRM_XE_EXEC_QUEUE_SET_PROPERTY_PXP_TYPE))))
+		return -EINVAL;
+
+	/*
+	 * EUDEBUG turns on runalone, which lets a single engine of the group
+	 * execute at a time, while a multi-queue group is there to run several
+	 * in parallel. Reject the combination. Testing the property mask
+	 * covers the primary as well, and does not depend on the order in
+	 * which userspace chained the extensions.
+	 */
+	if (XE_IOCTL_DBG(xe, (properties & BIT_ULL(DRM_XE_EXEC_QUEUE_SET_PROPERTY_EUDEBUG)) &&
+			 (properties & BIT_ULL(DRM_XE_EXEC_QUEUE_SET_PROPERTY_MULTI_GROUP))))
+		return -EINVAL;
+
 	return 0;
 }
 
@@ -1171,7 +1249,8 @@ static int exec_queue_user_ext_set_property(struct xe_device *xe,
 			 ext.property != DRM_XE_EXEC_QUEUE_SET_HANG_REPLAY_STATE &&
 			 ext.property != DRM_XE_EXEC_QUEUE_SET_PROPERTY_MULTI_GROUP &&
 			 ext.property != DRM_XE_EXEC_QUEUE_SET_PROPERTY_MULTI_QUEUE_PRIORITY &&
-			 ext.property != DRM_XE_EXEC_QUEUE_SET_DISABLE_STATE_CACHE_PERF_FIX))
+			 ext.property != DRM_XE_EXEC_QUEUE_SET_DISABLE_STATE_CACHE_PERF_FIX &&
+			 ext.property != DRM_XE_EXEC_QUEUE_SET_PROPERTY_EUDEBUG))
 		return -EINVAL;
 
 	idx = array_index_nospec(ext.property, ARRAY_SIZE(exec_queue_set_property_funcs));
diff --git a/drivers/gpu/drm/xe/xe_exec_queue.h b/drivers/gpu/drm/xe/xe_exec_queue.h
index e8963f85cabd..95a0d84b9590 100644
--- a/drivers/gpu/drm/xe/xe_exec_queue.h
+++ b/drivers/gpu/drm/xe/xe_exec_queue.h
@@ -162,4 +162,6 @@ int xe_exec_queue_contexts_hwsp_rebase(struct xe_exec_queue *q, void *scratch);
 struct xe_lrc *xe_exec_queue_lrc(struct xe_exec_queue *q);
 struct xe_lrc *xe_exec_queue_get_lrc(struct xe_exec_queue *q, u16 idx);
 
+bool xe_exec_queue_is_debuggable(struct xe_exec_queue *q);
+
 #endif
diff --git a/drivers/gpu/drm/xe/xe_exec_queue_types.h b/drivers/gpu/drm/xe/xe_exec_queue_types.h
index 48c05398b016..32893341287d 100644
--- a/drivers/gpu/drm/xe/xe_exec_queue_types.h
+++ b/drivers/gpu/drm/xe/xe_exec_queue_types.h
@@ -155,6 +155,13 @@ struct xe_exec_queue {
 	/** @ban_reason: Bitmask of ban reasons (DRM_XE_EXEC_QUEUE_BAN_REASON_*) */
 	atomic_t ban_reason;
 
+	/**
+	 * @eudebug_flags: immutable eudebug flags for this exec queue.
+	 * Set up with DRM_XE_EXEC_QUEUE_SET_PROPERTY_EUDEBUG.
+	 */
+#define EXEC_QUEUE_EUDEBUG_FLAG_ENABLE		BIT(0)
+	unsigned long eudebug_flags;
+
 	union {
 		/** @execlist: execlist backend specific state for exec queue */
 		struct xe_execlist_exec_queue *execlist;
diff --git a/drivers/gpu/drm/xe/xe_hw_engine.h b/drivers/gpu/drm/xe/xe_hw_engine.h
index c3ee37f8cfc0..532d69677981 100644
--- a/drivers/gpu/drm/xe/xe_hw_engine.h
+++ b/drivers/gpu/drm/xe/xe_hw_engine.h
@@ -78,4 +78,13 @@ enum xe_force_wake_domains xe_hw_engine_to_fw_domain(struct xe_hw_engine *hwe);
 
 u32 xe_hw_engine_mmio_read32(struct xe_hw_engine *hwe, struct xe_reg reg);
 
+static inline bool xe_engine_supports_eudebug(const enum xe_engine_class ec)
+{
+	if (ec == XE_ENGINE_CLASS_COMPUTE ||
+	    ec == XE_ENGINE_CLASS_RENDER)
+		return true;
+
+	return false;
+}
+
 #endif
diff --git a/include/uapi/drm/xe_drm.h b/include/uapi/drm/xe_drm.h
index e84b11324f08..1a157bf1589c 100644
--- a/include/uapi/drm/xe_drm.h
+++ b/include/uapi/drm/xe_drm.h
@@ -1396,6 +1396,16 @@ struct drm_xe_vm_get_property {
  *  - %DRM_XE_EXEC_QUEUE_SET_DISABLE_STATE_CACHE_PERF_FIX - Set the queue to
  *    enable render color cache keying on BTP+BTI instead of just BTI
  *    (only valid for render queues).
+ *  - %DRM_XE_EXEC_QUEUE_SET_PROPERTY_EUDEBUG - Make the queue debuggable
+ *    by an EU debugger. The queue runs in runalone mode, one engine at
+ *    a time, with a preemption timeout of 0. Fails with -EINVAL unless
+ *    the value is exactly %DRM_XE_EXEC_QUEUE_EUDEBUG_FLAG_ENABLE and the
+ *    queue is a width 1 render or compute queue on a VM created with
+ *    %DRM_XE_VM_CREATE_FLAG_FAULT_MODE,
+ *    not combined with %DRM_XE_EXEC_QUEUE_SET_PROPERTY_PXP_TYPE or
+ *    %DRM_XE_EXEC_QUEUE_SET_PROPERTY_MULTI_GROUP. Fails with
+ *    -EOPNOTSUPP if the kernel is built without CONFIG_DRM_XE_EUDEBUG,
+ *    and with -EPERM if eudebug is not enabled through sysfs.
  *
  * The example below shows how to use &struct drm_xe_exec_queue_create to create
  * a simple exec_queue (no parallel submission) of class
@@ -1443,6 +1453,8 @@ struct drm_xe_exec_queue_create {
 #define     DRM_XE_MULTI_GROUP_CREATE				(1ull << 63)
 #define   DRM_XE_EXEC_QUEUE_SET_PROPERTY_MULTI_QUEUE_PRIORITY	5
 #define   DRM_XE_EXEC_QUEUE_SET_DISABLE_STATE_CACHE_PERF_FIX	6
+#define   DRM_XE_EXEC_QUEUE_SET_PROPERTY_EUDEBUG		7
+#define     DRM_XE_EXEC_QUEUE_EUDEBUG_FLAG_ENABLE		(1 << 0)
 	/** @extensions: Pointer to the first extension struct, if any */
 	__u64 extensions;
 
-- 
2.53.0

