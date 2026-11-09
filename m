Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DE8606A32A
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 13:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XYAs8Ef5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2606910F30D;
	Mon,  9 Nov 2026 13:57:02 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89F0610F2FB;
 Mon,  9 Nov 2026 13:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794232615; x=1825768615;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=2fpDmJ1/m0lUPhfNhMfIZXvPhVp7akPXQxCW8gZKqAc=;
 b=XYAs8Ef5zTLmj/gymwMYYvmm8JCaygV+zouENjHJA9pz66/CFIzCsGJq
 5GWWQUpVqQD8tkQ5TzXq+rxxPd1jgY2s/7ursEvlRYoawxmj+4Hy25Ubv
 DsqLxp7wKZsJLkg7qZv8n/bb86uiNLWPtqjrbBmh9preSni0RyxRJBhxT
 uD71+xUbOrdqnJTTusCBupIDnUxyZije2/1GjD60gDBXTfb+looABd2K2
 f8R30F2Y2kHYuXksrm+8oqmu1GJc6jzxrPQs5PF4KsJPxcK85mUwZw9R8
 56nYyGCDh/PVV97guJ+E3GTLNQIXhF3UAMWUP01jdL8/SKoxoXuMHooib Q==;
X-CSE-ConnectionGUID: P3WaXaaKTAahhRPbMI7L7A==
X-CSE-MsgGUID: TfOjoYcrSO2XUL1j23qyCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11960"; a="2850804"
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="2850804"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 05:56:54 -0800
X-CSE-ConnectionGUID: utY9dRPFTpyQq0kjgjO/uA==
X-CSE-MsgGUID: FJ9Z8MFeRySuN6RQ16gtJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="8202733"
Received: from pgcooper-mobl2.ger.corp.intel.com (HELO
 mkuoppal-desk.home.arpa) ([10.245.246.220])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 05:56:48 -0800
From: Mika Kuoppala <mika.kuoppala@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: simona.vetter@ffwll.ch, matthew.brost@intel.com, christian.koenig@amd.com,
 thomas.hellstrom@linux.intel.com, joonas.lahtinen@linux.intel.com,
 gustavo.sousa@intel.com, jan.maslak@intel.com,
 dominik.karol.piatkowski@intel.com, rodrigo.vivi@intel.com,
 andrzej.hajda@intel.com, matthew.auld@intel.com,
 maciej.patelczyk@intel.com, gwan-gyeong.mun@intel.com,
 michal.wajdeczko@intel.com, dri-devel@lists.freedesktop.org,
 Mika Kuoppala <mika.kuoppala@linux.intel.com>,
 Lucas De Marchi <lucas.demarchi@intel.com>,
 Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
 Jan Sokolowski <jan.sokolowski@intel.com>,
 Dominik Grzegorzek <dominik.grzegorzek@intel.com>
Subject: [PATCH 09/20] drm/xe/eudebug: Mark guc contexts as debuggable
Date: Mon,  9 Nov 2026 15:55:34 +0200
Message-ID: <20261109135549.4128280-10-mika.kuoppala@linux.intel.com>
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

Inform the GuC which contexts are debuggable, as their
handling differs from ordinary contexts.

v2: void return, use xe_gt_dbg, no need for lrc (Matt)
v3: add the workaround enabling (Daniele)
v4: version needed to 70.49.4
v5: bail out early before registering eq (Daniele)
v6: export the guc action for future (Mika)
v7: remove redundant xe_gt_info (Sashiko)

Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
Cc: Jan Sokolowski <jan.sokolowski@intel.com>
Signed-off-by: Dominik Grzegorzek <dominik.grzegorzek@intel.com>
Signed-off-by: Maciej Patelczyk <maciej.patelczyk@intel.com>
Signed-off-by: Mika Kuoppala <mika.kuoppala@linux.intel.com>
Reviewed-by: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
---
 drivers/gpu/drm/xe/abi/guc_actions_abi.h |  5 ++++
 drivers/gpu/drm/xe/abi/guc_klvs_abi.h    |  1 +
 drivers/gpu/drm/xe/xe_exec_queue.c       |  5 ++++
 drivers/gpu/drm/xe/xe_guc.c              | 15 +++++++++++
 drivers/gpu/drm/xe/xe_guc.h              |  6 +++++
 drivers/gpu/drm/xe/xe_guc_ads.c          |  5 ++++
 drivers/gpu/drm/xe/xe_guc_submit.c       | 34 ++++++++++++++++++++++++
 drivers/gpu/drm/xe/xe_wa_oob.rules       |  2 ++
 include/uapi/drm/xe_drm.h                |  5 ++--
 9 files changed, 76 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/abi/guc_actions_abi.h b/drivers/gpu/drm/xe/abi/guc_actions_abi.h
index f5c9b37038d4..48ba41fd8ccb 100644
--- a/drivers/gpu/drm/xe/abi/guc_actions_abi.h
+++ b/drivers/gpu/drm/xe/abi/guc_actions_abi.h
@@ -162,6 +162,7 @@ enum xe_guc_action {
 	XE_GUC_ACTION_NOTIFY_FLUSH_LOG_BUFFER_TO_FILE = 0x8003,
 	XE_GUC_ACTION_NOTIFY_CRASH_DUMP_POSTED = 0x8004,
 	XE_GUC_ACTION_NOTIFY_EXCEPTION = 0x8005,
+	XE_GUC_ACTION_EU_KERNEL_DEBUG = 0x8006,
 	XE_GUC_ACTION_TEST_G2G_SEND = 0xF001,
 	XE_GUC_ACTION_TEST_G2G_RECV = 0xF002,
 	XE_GUC_ACTION_LIMIT
@@ -285,4 +286,8 @@ enum xe_guc_g2g_type {
 /* invalid type for XE_GUC_ACTION_NOTIFY_MEMORY_CAT_ERROR */
 #define XE_GUC_CAT_ERR_TYPE_INVALID 0xdeadbeef
 
+enum xe_guc_eu_kernel_debug_request_type {
+	XE_GUC_EU_KERNEL_DEBUG_ENABLE = 0x3,
+};
+
 #endif
diff --git a/drivers/gpu/drm/xe/abi/guc_klvs_abi.h b/drivers/gpu/drm/xe/abi/guc_klvs_abi.h
index 4bcdc1a96785..147a1d0a1472 100644
--- a/drivers/gpu/drm/xe/abi/guc_klvs_abi.h
+++ b/drivers/gpu/drm/xe/abi/guc_klvs_abi.h
@@ -522,6 +522,7 @@ enum xe_guc_klv_ids {
 	GUC_WA_KLV_WAKE_POWER_DOMAINS_FOR_OUTBOUND_MMIO					= 0x900a,
 	GUC_WA_KLV_RESET_BB_STACK_PTR_ON_VF_SWITCH					= 0x900b,
 	GUC_WA_KLV_RESTORE_UNSAVED_MEDIA_CONTROL_REG					= 0x900c,
+	GUC_WA_KLV_RESET_DEP_ENGINES_ON_DEBUG_CTX_SWITCH				= 0x900d,
 	GUC_WA_KLV_CLR_CS_INDIRECT_RING_STATE_IF_IDLE_AT_CTX_REG			= 0x900e,
 	GUC_WA_KLV_REMAP_RANGED_TLB_INV							= 0x900f,
 	GUC_WA_KLV_IGNORE_MMIO_READ_SEM_TOKEN_64					= 0x9010,
diff --git a/drivers/gpu/drm/xe/xe_exec_queue.c b/drivers/gpu/drm/xe/xe_exec_queue.c
index 3eeb8a108b40..870abbf08d2e 100644
--- a/drivers/gpu/drm/xe/xe_exec_queue.c
+++ b/drivers/gpu/drm/xe/xe_exec_queue.c
@@ -21,6 +21,7 @@
 #include "xe_gt.h"
 #include "xe_gt_sriov_pf.h"
 #include "xe_gt_sriov_vf.h"
+#include "xe_guc.h"
 #include "xe_hw_engine_class_sysfs.h"
 #include "xe_hw_engine_group.h"
 #include "xe_irq.h"
@@ -1058,6 +1059,7 @@ static int exec_queue_set_eudebug(struct xe_device *xe, struct xe_exec_queue *q,
 				  u64 value)
 {
 	const u64 known_flags = DRM_XE_EXEC_QUEUE_EUDEBUG_FLAG_ENABLE;
+	struct xe_guc *guc = &q->gt->uc.guc;
 
 	if (XE_IOCTL_DBG(xe, !xe_engine_supports_eudebug(q->class)))
 		return -EINVAL;
@@ -1068,6 +1070,9 @@ static int exec_queue_set_eudebug(struct xe_device *xe, struct xe_exec_queue *q,
 	if (XE_IOCTL_DBG(xe, !IS_ENABLED(CONFIG_DRM_XE_EUDEBUG)))
 		return -EOPNOTSUPP;
 
+	if (XE_IOCTL_DBG(xe, !xe_guc_has_debug_contexts(guc)))
+		return -EOPNOTSUPP;
+
 	/*
 	 * The preemption timeout below is infinite, which is only safe where
 	 * no dma-fence waits for the queue to be preempted: a fault mode vm
diff --git a/drivers/gpu/drm/xe/xe_guc.c b/drivers/gpu/drm/xe/xe_guc.c
index 300126e6624f..8b9af0c483b5 100644
--- a/drivers/gpu/drm/xe/xe_guc.c
+++ b/drivers/gpu/drm/xe/xe_guc.c
@@ -823,6 +823,13 @@ int xe_guc_init(struct xe_guc *guc)
 		return 0;
 	}
 
+	if (IS_ENABLED(CONFIG_DRM_XE_EUDEBUG) && XE_GT_WA(gt, 14022766366) &&
+	    !xe_guc_has_debug_contexts(guc))
+		xe_gt_info(gt, "eudebug needs GuC version %u.%u.%u or greater\n",
+			   XE_GUC_VER_DEBUG_CONTEXTS_MAJOR,
+			   XE_GUC_VER_DEBUG_CONTEXTS_MINOR,
+			   XE_GUC_VER_DEBUG_CONTEXTS_PATCH);
+
 	ret = xe_guc_log_init(&guc->log);
 	if (ret)
 		goto out;
@@ -1959,6 +1966,14 @@ u16 xe_hwe_guc_logical_instance(struct xe_hw_engine *hwe)
 	return hwe->logical_instance;
 }
 
+bool xe_guc_has_debug_contexts(struct xe_guc *guc)
+{
+	return GUC_FIRMWARE_VER_AT_LEAST(guc,
+					 XE_GUC_VER_DEBUG_CONTEXTS_MAJOR,
+					 XE_GUC_VER_DEBUG_CONTEXTS_MINOR,
+					 XE_GUC_VER_DEBUG_CONTEXTS_PATCH);
+}
+
 #if IS_ENABLED(CONFIG_DRM_XE_KUNIT_TEST)
 #include "tests/xe_guc_g2g_test.c"
 #endif
diff --git a/drivers/gpu/drm/xe/xe_guc.h b/drivers/gpu/drm/xe/xe_guc.h
index 543ba4e5981e..79d76970995d 100644
--- a/drivers/gpu/drm/xe/xe_guc.h
+++ b/drivers/gpu/drm/xe/xe_guc.h
@@ -29,6 +29,11 @@
 #define GUC_FIRMWARE_VER_AT_LEAST(guc, ver...) \
 	xe_guc_fw_version_at_least((guc), MAKE_GUC_VER_ARGS(ver))
 
+/* Lowest GuC version that knows how to handle debuggable contexts */
+#define XE_GUC_VER_DEBUG_CONTEXTS_MAJOR	70
+#define XE_GUC_VER_DEBUG_CONTEXTS_MINOR	49
+#define XE_GUC_VER_DEBUG_CONTEXTS_PATCH	4
+
 struct drm_printer;
 struct xe_gt;
 
@@ -66,6 +71,7 @@ int xe_guc_start(struct xe_guc *guc);
 void xe_guc_wedge_declare(struct xe_guc *guc);
 bool xe_guc_using_main_gamctrl_queues(struct xe_guc *guc);
 bool xe_guc_has_paging_engine(struct xe_guc *guc);
+bool xe_guc_has_debug_contexts(struct xe_guc *guc);
 
 #if IS_ENABLED(CONFIG_DRM_XE_KUNIT_TEST)
 int xe_guc_g2g_test_notification(struct xe_guc *guc, u32 *payload, u32 len);
diff --git a/drivers/gpu/drm/xe/xe_guc_ads.c b/drivers/gpu/drm/xe/xe_guc_ads.c
index c3ce3c8c905a..0b1bdb40230b 100644
--- a/drivers/gpu/drm/xe/xe_guc_ads.c
+++ b/drivers/gpu/drm/xe/xe_guc_ads.c
@@ -402,6 +402,11 @@ static void guc_waklv_init(struct xe_guc_ads *ads)
 				 GUC_FEATURE_KLV_DISABLE_MULTI_QUEUE);
 	}
 
+	if (IS_ENABLED(CONFIG_DRM_XE_EUDEBUG) && XE_GT_WA(gt, 14022766366) &&
+	    xe_guc_has_debug_contexts(&gt->uc.guc))
+		guc_waklv_enable(ads, NULL, 0, &offset, &remain,
+				 GUC_WA_KLV_RESET_DEP_ENGINES_ON_DEBUG_CTX_SWITCH);
+
 	size = guc_ads_waklv_size(ads) - remain;
 	if (!size)
 		return;
diff --git a/drivers/gpu/drm/xe/xe_guc_submit.c b/drivers/gpu/drm/xe/xe_guc_submit.c
index b14b37b767f5..61a7d731f7d1 100644
--- a/drivers/gpu/drm/xe/xe_guc_submit.c
+++ b/drivers/gpu/drm/xe/xe_guc_submit.c
@@ -1023,6 +1023,37 @@ static u32 xe_hwe_guc_logical_to_submit_mask(struct xe_hw_engine *hwe, u32 logic
 	return logical_mask;
 }
 
+static int guc_action_eu_kernel_debug(struct xe_guc *guc, u32 id, u32 cmd)
+{
+	const u32 action[] = {
+		XE_GUC_ACTION_EU_KERNEL_DEBUG,
+		id,
+		cmd,
+		0, /* reserved */
+	};
+
+	return xe_guc_ct_send(&guc->ct, action,
+			      ARRAY_SIZE(action), 0, 0);
+}
+
+static void set_eu_kernel_debug(struct xe_exec_queue *q)
+{
+	struct xe_guc *guc = exec_queue_to_guc(q);
+	struct xe_gt *gt = guc_to_gt(guc);
+	int ret;
+
+	ret = guc_action_eu_kernel_debug(guc, q->guc->id,
+					 XE_GUC_EU_KERNEL_DEBUG_ENABLE);
+
+	if (ret)
+		xe_gt_err_ratelimited(gt,
+				      "GuC ctx=%u debug enabling failed with %d\n",
+				      q->guc->id, ret);
+	else
+		xe_gt_dbg(gt,
+			  "GuC ctx=%u debug enable requested\n", q->guc->id);
+}
+
 static void register_exec_queue(struct xe_exec_queue *q, int ctx_type)
 {
 	struct xe_guc *guc = exec_queue_to_guc(q);
@@ -1084,6 +1115,9 @@ static void register_exec_queue(struct xe_exec_queue *q, int ctx_type)
 
 	if (xe_exec_queue_is_multi_queue_secondary(q))
 		guc_exec_queue_send_cgp_sync(q, CGP_SYNC_REGISTRATION);
+
+	if (xe_exec_queue_is_debuggable(q))
+		set_eu_kernel_debug(q);
 }
 
 static u32 wq_space_until_wrap(struct xe_exec_queue *q)
diff --git a/drivers/gpu/drm/xe/xe_wa_oob.rules b/drivers/gpu/drm/xe/xe_wa_oob.rules
index 61aa50a63764..da774e17cb69 100644
--- a/drivers/gpu/drm/xe/xe_wa_oob.rules
+++ b/drivers/gpu/drm/xe/xe_wa_oob.rules
@@ -78,3 +78,5 @@
 		MEDIA_VERSION_RANGE(1301, 3503), FUNC(xe_rtp_match_not_sriov_vf)
 16030224309	GRAPHICS_VERSION_RANGE(3510, 3511)
 14028709524	GRAPHICS_VERSION(3510)
+14022766366	GRAPHICS_VERSION_RANGE(2001, 2004)
+		GRAPHICS_VERSION_RANGE(3000, 3005)
diff --git a/include/uapi/drm/xe_drm.h b/include/uapi/drm/xe_drm.h
index 1a157bf1589c..759e76b7ac52 100644
--- a/include/uapi/drm/xe_drm.h
+++ b/include/uapi/drm/xe_drm.h
@@ -1404,8 +1404,9 @@ struct drm_xe_vm_get_property {
  *    %DRM_XE_VM_CREATE_FLAG_FAULT_MODE,
  *    not combined with %DRM_XE_EXEC_QUEUE_SET_PROPERTY_PXP_TYPE or
  *    %DRM_XE_EXEC_QUEUE_SET_PROPERTY_MULTI_GROUP. Fails with
- *    -EOPNOTSUPP if the kernel is built without CONFIG_DRM_XE_EUDEBUG,
- *    and with -EPERM if eudebug is not enabled through sysfs.
+ *    -EOPNOTSUPP if the kernel is built without CONFIG_DRM_XE_EUDEBUG
+ *    or the GuC does not support debug contexts, and with -EPERM if
+ *    eudebug is not enabled through sysfs.
  *
  * The example below shows how to use &struct drm_xe_exec_queue_create to create
  * a simple exec_queue (no parallel submission) of class
-- 
2.53.0

