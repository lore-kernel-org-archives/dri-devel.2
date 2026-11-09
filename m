Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06154606A31C
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 13:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jvYvukdm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB73D10F330;
	Mon,  9 Nov 2026 13:57:39 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FA2E10F312;
 Mon,  9 Nov 2026 13:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794232648; x=1825768648;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ibZ4FPFvdrjZfG2cKm8I/33KNu0YtG94dpNkPU9vOb4=;
 b=jvYvukdmM9XdgYkGr4B2pE8/1UlbxxTuXMtq8JqPkZn9bTpii0zx4GlF
 gfLdjMtgq2Bu6YQc6dEYZcyHXT4YSKDm909Hahm5sKwtEyI90UJ4UsP1M
 XPTAQ0Bb5XDQfzXZTSUcrnw1AWTFsGbO3YEd5H1FszPW7UirTw7LQnnJk
 r9ESaRqxoXd1ueS55MQGHE8imv71d7mCKrcdutpP+r735tnrC+MFkbL1a
 ciseRJ4QZYEIReOGCQlvgKzg03z9+J7eS/MurzmgirRGEjdJYAVFRYjU1
 yjyacyrr6X9CXw1bKu2/dS0rehbs3aS5joK4YUneJiPhlv/k+QziZG0qN A==;
X-CSE-ConnectionGUID: PS3Y3duGTAmnYqFnBmsA3g==
X-CSE-MsgGUID: yZ2Q8MrMTaa8L+C7BoKB+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11960"; a="2850908"
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="2850908"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 05:57:26 -0800
X-CSE-ConnectionGUID: xcexucaGTCqvZq0dWlRTqg==
X-CSE-MsgGUID: w3GcjOcuRXmtZw14BvY/HQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="8202924"
Received: from pgcooper-mobl2.ger.corp.intel.com (HELO
 mkuoppal-desk.home.arpa) ([10.245.246.220])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 05:57:21 -0800
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
Subject: [PATCH 15/20] drm/xe/eudebug: Add hw enablement
Date: Mon,  9 Nov 2026 15:55:40 +0200
Message-ID: <20261109135549.4128280-16-mika.kuoppala@linux.intel.com>
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Dominik Grzegorzek <dominik.grzegorzek@intel.com>

In order to turn on debug capabilities (i.e. breakpoints), TD_CTL
and some other registers need to be programmed. Implement eudebug
mode enabling, including eudebug related workarounds.

v2: Move workarounds to xe_wa_oob. Use reg_sr directly instead of
xe_rtp as it suits better for dynamic manipulation of those registers we
do later in the series.
v3: get rid of undefining XE_MCR_REG (Mika)
v4: return if dss_mask is all 0.
v5: remove unused GLOBAL_DEBUG_ENABLE (Sashiko)
v6: - don't leak fw ref, check for zero dss_mask (Sashiko)
    - hold runtime for hw access (Sashiko)
    - make iter size check byte granularity for safety (Claude)
    - simplify xe_reg_sr_add with overwrite (Claude)
    - check that bitmap size is aligned to hw (4) (Claude)
v7: - assert attention bitmap size granularity (Sashiko)
    - overwrite fix (Claude)
v8: - drop duplicate STALL_DOP_GATING_DISABLE (Sashiko)
v9: - refuse eudebug on graphics versions without known debug
      register layouts (review-prompts)
v10: - cap_state under eudebug.lock (Mika)
v11: - no empty #else in xe_eudebug_hw.h (Sashiko)

Signed-off-by: Dominik Grzegorzek <dominik.grzegorzek@intel.com>
Signed-off-by: Mika Kuoppala <mika.kuoppala@linux.intel.com>
Signed-off-by: Maciej Patelczyk <maciej.patelczyk@intel.com>
---
 drivers/gpu/drm/xe/Makefile           |   2 +-
 drivers/gpu/drm/xe/regs/xe_gt_regs.h  |  18 ++
 drivers/gpu/drm/xe/xe_eudebug.c       |   9 +-
 drivers/gpu/drm/xe/xe_eudebug_hw.c    |  71 ++++++++
 drivers/gpu/drm/xe/xe_eudebug_hw.h    |  21 +++
 drivers/gpu/drm/xe/xe_gt_debug.c      | 228 ++++++++++++++++++++++++++
 drivers/gpu/drm/xe/xe_gt_debug.h      |  31 ++++
 drivers/gpu/drm/xe/xe_oa.c            |   1 +
 drivers/gpu/drm/xe/xe_reg_sr.c        |  19 ++-
 drivers/gpu/drm/xe/xe_reg_sr.h        |   4 +-
 drivers/gpu/drm/xe/xe_reg_whitelist.c |   2 +-
 drivers/gpu/drm/xe/xe_rtp.c           |   2 +-
 drivers/gpu/drm/xe/xe_wa_oob.rules    |   2 +
 13 files changed, 402 insertions(+), 8 deletions(-)
 create mode 100644 drivers/gpu/drm/xe/xe_eudebug_hw.c
 create mode 100644 drivers/gpu/drm/xe/xe_eudebug_hw.h
 create mode 100644 drivers/gpu/drm/xe/xe_gt_debug.c
 create mode 100644 drivers/gpu/drm/xe/xe_gt_debug.h

diff --git a/drivers/gpu/drm/xe/Makefile b/drivers/gpu/drm/xe/Makefile
index f24ef4261dcb..356f44aac308 100644
--- a/drivers/gpu/drm/xe/Makefile
+++ b/drivers/gpu/drm/xe/Makefile
@@ -165,7 +165,7 @@ xe-$(CONFIG_DRM_XE_GPUSVM) += xe_svm.o
 xe-$(CONFIG_DRM_GPUSVM) += xe_userptr.o
 
 # debugging shaders with gdb (eudebug) support
-xe-$(CONFIG_DRM_XE_EUDEBUG) += xe_eudebug.o xe_eudebug_vm.o
+xe-$(CONFIG_DRM_XE_EUDEBUG) += xe_eudebug.o xe_eudebug_vm.o xe_eudebug_hw.o xe_gt_debug.o
 
 # graphics hardware monitoring (HWMON) support
 xe-$(CONFIG_HWMON) += xe_hwmon.o
diff --git a/drivers/gpu/drm/xe/regs/xe_gt_regs.h b/drivers/gpu/drm/xe/regs/xe_gt_regs.h
index cd972a03a792..765a5c076695 100644
--- a/drivers/gpu/drm/xe/regs/xe_gt_regs.h
+++ b/drivers/gpu/drm/xe/regs/xe_gt_regs.h
@@ -553,10 +553,20 @@
 #define   DG2_DISABLE_ROUND_ENABLE_ALLOW_FOR_SSLA	REG_BIT(15)
 #define   CLEAR_OPTIMIZATION_DISABLE			REG_BIT(6)
 
+#define TD_CTL					XE_REG_MCR(0xe400)
+#define   TD_CTL_FEH_AND_FEE_ENABLE		REG_BIT(7) /* forced halt and exception */
+#define   TD_CTL_FORCE_EXTERNAL_HALT		REG_BIT(6)
+#define   TD_CTL_FORCE_THREAD_BREAKPOINT_ENABLE	REG_BIT(4)
+#define   TD_CTL_FORCE_EXCEPTION		REG_BIT(3)
+#define   TD_CTL_BREAKPOINT_ENABLE		REG_BIT(2)
+#define   TD_CTL_GLOBAL_DEBUG_ENABLE		REG_BIT(0) /* XeHP */
+
 #define CACHE_MODE_SS				XE_REG_MCR(0xe420, XE_REG_OPTION_MASKED)
 #define   DISABLE_ECC				REG_BIT(5)
 #define   ENABLE_PREFETCH_INTO_IC		REG_BIT(3)
 
+#define EU_ATT(reg, row)			XE_REG_MCR((reg ? 0xe478 : 0xe470) + (row) * 4)
+
 #define ROW_CHICKEN4				XE_REG_MCR(0xe48c, XE_REG_OPTION_MASKED)
 #define   DISABLE_GRF_CLEAR			REG_BIT(13)
 #define   XEHP_DIS_BBL_SYSPIPE			REG_BIT(11)
@@ -566,6 +576,8 @@
 #define   THREAD_EX_ARB_MODE			REG_GENMASK(3, 2)
 #define   THREAD_EX_ARB_MODE_RR_AFTER_DEP	REG_FIELD_PREP(THREAD_EX_ARB_MODE, 0x2)
 
+#define EU_ATT_CLR(reg, row)			XE_REG_MCR((reg ? 0xe698 : 0xe490) + (row) * 4)
+
 #define ROW_CHICKEN3				XE_REG_MCR(0xe49c, XE_REG_OPTION_MASKED)
 #define   XE2_EUPEND_CHK_FLUSH_DIS		REG_BIT(14)
 #define   DIS_EU_GRF_POISON_TO_LSC		REG_BIT(13)
@@ -589,6 +601,7 @@
 #define   DISABLE_READ_SUPPRESSION		REG_BIT(15)
 #define   DISABLE_EARLY_READ			REG_BIT(14)
 #define   ENABLE_LARGE_GRF_MODE			REG_BIT(12)
+#define   XEHPC_DISABLE_BTB			REG_BIT(11)
 #define   PUSH_CONST_DEREF_HOLD_DIS		REG_BIT(8)
 #define   DISABLE_TDL_SVHS_GATING		REG_BIT(1)
 #define   DISABLE_DOP_GATING			REG_BIT(0)
@@ -680,6 +693,11 @@
 	RCU_ASYNC_INVALIDATE_TEXTURE_CACHE | \
 	RCU_ASYNC_INVALIDATE_INSTRUCTION_CACHE)
 
+#define RCU_DEBUG_1				XE_REG(0x14a00)
+#define   RCU_DEBUG_1_ENGINE_STATUS		REG_GENMASK(2, 0)
+#define   RCU_DEBUG_1_RUNALONE_ACTIVE		REG_BIT(2)
+#define   RCU_DEBUG_1_CONTEXT_ACTIVE		REG_BIT(0)
+
 #define FORCEWAKE_ACK_GT			XE_REG(0x130044)
 
 /* Applicable for all FORCEWAKE_DOMAIN and FORCEWAKE_ACK_DOMAIN regs */
diff --git a/drivers/gpu/drm/xe/xe_eudebug.c b/drivers/gpu/drm/xe/xe_eudebug.c
index e31418970113..bf4d3ac4e092 100644
--- a/drivers/gpu/drm/xe/xe_eudebug.c
+++ b/drivers/gpu/drm/xe/xe_eudebug.c
@@ -2402,7 +2402,14 @@ void xe_eudebug_init_early(struct xe_device *xe)
 	if (drmm_add_action(&xe->drm, xe_eudebug_lock_fini, NULL))
 		drm_dbg(&xe->drm, "eudebug lock will not be destroyed\n");
 
-	xe->eudebug.cap_state = XE_EUDEBUG_CAP_DISABLED;
+	if (GRAPHICS_VER(xe) >= 35) {
+		/* debug register layouts are only known up to Xe3 */
+		drm_dbg(&xe->drm, "eudebug not supported on graphics version %u\n",
+			GRAPHICS_VER(xe));
+		xe->eudebug.cap_state = XE_EUDEBUG_CAP_NOT_SUPPORTED;
+	} else {
+		xe->eudebug.cap_state = XE_EUDEBUG_CAP_DISABLED;
+	}
 }
 
 void xe_eudebug_init(struct xe_device *xe)
diff --git a/drivers/gpu/drm/xe/xe_eudebug_hw.c b/drivers/gpu/drm/xe/xe_eudebug_hw.c
new file mode 100644
index 000000000000..7388facfe0a5
--- /dev/null
+++ b/drivers/gpu/drm/xe/xe_eudebug_hw.c
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright © 2023-2025 Intel Corporation
+ */
+
+#include "xe_eudebug_hw.h"
+
+#include <linux/delay.h>
+#include <linux/pm_runtime.h>
+#include <generated/xe_wa_oob.h>
+
+#include "regs/xe_gt_regs.h"
+#include "regs/xe_engine_regs.h"
+
+#include "xe_eudebug.h"
+#include "xe_eudebug_types.h"
+#include "xe_exec_queue.h"
+#include "xe_exec_queue_types.h"
+#include "xe_force_wake.h"
+#include "xe_gt.h"
+#include "xe_gt_debug.h"
+#include "xe_gt_mcr.h"
+#include "xe_hw_engine.h"
+#include "xe_lrc.h"
+#include "xe_macros.h"
+#include "xe_mmio.h"
+#include "xe_reg_sr.h"
+#include "xe_rtp.h"
+#include "xe_wa.h"
+
+static void add_sr_entry(struct xe_hw_engine *hwe,
+			 struct xe_reg_mcr mcr_reg,
+			 u32 mask, bool enable)
+{
+	const struct xe_reg_sr_entry sr_entry = {
+		.reg = mcr_reg.__reg,
+		.clr_bits = mask,
+		.set_bits = enable ? mask : 0,
+		.read_mask = mask,
+	};
+
+	xe_reg_sr_add(&hwe->reg_sr, &sr_entry, hwe->gt, true);
+}
+
+void xe_eudebug_init_hw_engine(struct xe_hw_engine *hwe, bool enable)
+{
+	struct xe_gt *gt = hwe->gt;
+	struct xe_device *xe = gt_to_xe(gt);
+
+	if (!xe_rtp_match_first_render_or_compute(xe, gt, hwe))
+		return;
+
+	if (XE_GT_WA(gt, 18022722726))
+		add_sr_entry(hwe, ROW_CHICKEN,
+			     STALL_DOP_GATING_DISABLE, enable);
+
+	if (XE_GT_WA(gt, 14015474168))
+		add_sr_entry(hwe, ROW_CHICKEN2,
+			     XEHPC_DISABLE_BTB,
+			     enable);
+
+	add_sr_entry(hwe, TD_CTL,
+		     TD_CTL_BREAKPOINT_ENABLE |
+		     TD_CTL_FORCE_THREAD_BREAKPOINT_ENABLE |
+		     TD_CTL_FEH_AND_FEE_ENABLE,
+		     enable);
+
+	if (xe->info.graphics_verx100 >= 1250)
+		add_sr_entry(hwe, TD_CTL,
+			     TD_CTL_GLOBAL_DEBUG_ENABLE, enable);
+}
diff --git a/drivers/gpu/drm/xe/xe_eudebug_hw.h b/drivers/gpu/drm/xe/xe_eudebug_hw.h
new file mode 100644
index 000000000000..447e83cd4e38
--- /dev/null
+++ b/drivers/gpu/drm/xe/xe_eudebug_hw.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright © 2023-2025 Intel Corporation
+ */
+
+#ifndef _XE_EUDEBUG_HW_H_
+#define _XE_EUDEBUG_HW_H_
+
+#include <linux/types.h>
+
+struct xe_eudebug;
+struct xe_hw_engine;
+struct xe_gt;
+
+#if IS_ENABLED(CONFIG_DRM_XE_EUDEBUG)
+
+void xe_eudebug_init_hw_engine(struct xe_hw_engine *hwe, bool enable);
+
+#endif /* CONFIG_DRM_XE_EUDEBUG */
+
+#endif /* _XE_EUDEBUG_HW_H_ */
diff --git a/drivers/gpu/drm/xe/xe_gt_debug.c b/drivers/gpu/drm/xe/xe_gt_debug.c
new file mode 100644
index 000000000000..a2f660777949
--- /dev/null
+++ b/drivers/gpu/drm/xe/xe_gt_debug.c
@@ -0,0 +1,228 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright © 2023 Intel Corporation
+ */
+
+#include "regs/xe_gt_regs.h"
+#include "xe_device.h"
+#include "xe_force_wake.h"
+#include "xe_gt.h"
+#include "xe_gt_topology.h"
+#include "xe_gt_debug.h"
+#include "xe_gt_mcr.h"
+#include "xe_pm.h"
+#include "xe_macros.h"
+
+unsigned int xe_gt_eu_att_regs(struct xe_gt *gt)
+{
+	return (GRAPHICS_VERx100(gt_to_xe(gt)) >= 3000) ? 2u : 1u;
+}
+
+int xe_gt_foreach_dss_group_instance(struct xe_gt *gt,
+				     int (*fn)(struct xe_gt *gt,
+					       void *data,
+					       u16 group,
+					       u16 instance,
+					       bool present),
+				     void *data)
+{
+	struct xe_device *xe = gt_to_xe(gt);
+	xe_dss_mask_t dss_mask;
+	unsigned int dss, fw_gt, fw_render;
+	u16 group, instance;
+	int ret = 0;
+
+	/* EUs, and the render forcewake domain, exist on the main GT only */
+	if (!xe_gt_is_main_type(gt))
+		return -EINVAL;
+
+	if (!xe_pm_runtime_get_if_active(xe))
+		return -EIO;
+
+	/*
+	 * The EU attention registers sit in the render forcewake domain.
+	 * xe_force_wake_get() wakes one domain per call, so take GT and
+	 * render separately.
+	 */
+	fw_gt = xe_force_wake_get(gt_to_fw(gt), XE_FW_GT);
+	fw_render = xe_force_wake_get(gt_to_fw(gt), XE_FW_RENDER);
+	if (!fw_gt || !fw_render) {
+		ret = -ETIMEDOUT;
+		goto out_fw;
+	}
+
+	bitmap_or(dss_mask, gt->fuse_topo.g_dss_mask, gt->fuse_topo.c_dss_mask,
+		  XE_MAX_DSS_FUSE_BITS);
+
+	/* If by any chance dss_mask is all 0s */
+	if (!bitmap_weight(dss_mask, XE_MAX_DSS_FUSE_BITS)) {
+		ret = -EINVAL;
+		goto out_fw;
+	}
+
+	/*
+	 * Note: This removes terminating zeros when last dss is fused out!
+	 * In order bitmask to be exactly the same as on with i915 we would
+	 * need to figure out max dss for given platform, most probably by
+	 * querying hwconfig
+	 */
+
+	for (dss = 0;
+	     dss <= find_last_bit(dss_mask, XE_MAX_DSS_FUSE_BITS);
+	     dss++) {
+		xe_gt_mcr_get_dss_steering(gt, dss, &group, &instance);
+
+		ret = fn(gt, data, group, instance, test_bit(dss, dss_mask));
+		if (ret)
+			break;
+	}
+
+out_fw:
+	xe_force_wake_put(gt_to_fw(gt), fw_render);
+	xe_force_wake_put(gt_to_fw(gt), fw_gt);
+	xe_pm_runtime_put(xe);
+
+	return ret;
+}
+
+static int read_first_attention_mcr(struct xe_gt *gt, void *data,
+				    u16 group, u16 instance, bool present)
+{
+	unsigned int reg, row;
+
+	if (!present)
+		return 0;
+
+	for (reg = 0; reg < xe_gt_eu_att_regs(gt); reg++) {
+		for (row = 0; row < XE_GT_EU_ATT_ROWS; row++) {
+			u32 val;
+
+			val = xe_gt_mcr_unicast_read(gt, EU_ATT(reg, row), group, instance);
+
+			if (val)
+				return 1;
+		}
+	}
+
+	return 0;
+}
+
+#define MAX_EUS_PER_ROW 4u
+#define MAX_THREADS 8u
+
+/**
+ * xe_gt_eu_attention_bitmap_size - query size of the attention bitmask
+ *
+ * @gt: pointer to struct xe_gt
+ *
+ * The bitmask is u32 sized hardware register content, one bit per thread,
+ * in native endianness. It is a byte array rather than a kernel bitmap:
+ * it crosses to userspace as one, and its size is expressed in bytes.
+ *
+ * Return: size in bytes, always a multiple of sizeof(u32).
+ */
+int xe_gt_eu_attention_bitmap_size(struct xe_gt *gt)
+{
+	xe_dss_mask_t dss_mask;
+
+	/*
+	 * The readers move through the buffer one u32 register at a time, so
+	 * every dss/register/row has to contribute a whole number of them.
+	 * Everything else in the size below is integer multiplication, which
+	 * makes the total u32 aligned by construction rather than by luck.
+	 */
+	BUILD_BUG_ON(MAX_THREADS * MAX_EUS_PER_ROW / 8 != sizeof(u32));
+
+	bitmap_or(dss_mask, gt->fuse_topo.c_dss_mask,
+		  gt->fuse_topo.g_dss_mask, XE_MAX_DSS_FUSE_BITS);
+
+	if (XE_WARN_ON(bitmap_empty(dss_mask, XE_MAX_DSS_FUSE_BITS)))
+		return 0;
+
+	return (find_last_bit(dss_mask, XE_MAX_DSS_FUSE_BITS) + 1) *
+		XE_GT_EU_ATT_ROWS * xe_gt_eu_att_regs(gt) * MAX_THREADS *
+		MAX_EUS_PER_ROW / 8;
+}
+
+struct attn_read_iter {
+	struct xe_gt *gt;
+	unsigned int i;
+	unsigned int size;
+	u8 *bits;
+};
+
+static int read_eu_attentions_mcr(struct xe_gt *gt, void *data,
+				  u16 group, u16 instance, bool present)
+{
+	struct attn_read_iter * const iter = data;
+	unsigned int reg, row;
+
+	for (reg = 0; reg < xe_gt_eu_att_regs(gt); reg++) {
+		for (row = 0; row < XE_GT_EU_ATT_ROWS; row++) {
+			u32 val;
+
+			if (iter->i + sizeof(val) > iter->size)
+				return 0;
+
+			if (present)
+				val = xe_gt_mcr_unicast_read(gt, EU_ATT(reg, row), group, instance);
+			else
+				val = 0;
+
+			memcpy(&iter->bits[iter->i], &val, sizeof(val));
+			iter->i += sizeof(val);
+		}
+	}
+
+	return 0;
+}
+
+/**
+ * xe_gt_eu_attention_bitmap - query host attention
+ *
+ * @gt: pointer to struct xe_gt
+ * @bits: buffer to fill with the attention bits, one u32 per dss, register
+ *	and row, in the order xe_gt_foreach_dss_group_instance() walks them
+ * @bitmap_size: size of @bits in bytes, a multiple of sizeof(u32)
+ *
+ * Return: 0 on success, negative otherwise.
+ */
+int xe_gt_eu_attention_bitmap(struct xe_gt *gt, u8 *bits,
+			      unsigned int bitmap_size)
+{
+	struct attn_read_iter iter = {
+		.gt = gt,
+		.i = 0,
+		.size = bitmap_size,
+		.bits = bits
+	};
+
+	/* One u32 of attention state per dss, register and row */
+	BUILD_BUG_ON(MAX_THREADS * MAX_EUS_PER_ROW / 8 != sizeof(u32));
+
+	if (XE_WARN_ON(!IS_ALIGNED(bitmap_size, sizeof(u32))))
+		return -EINVAL;
+
+	return xe_gt_foreach_dss_group_instance(gt, read_eu_attentions_mcr, &iter);
+}
+
+/**
+ * xe_gt_eu_threads_needing_attention - Query host attention
+ *
+ * @gt: pointer to struct xe_gt
+ *
+ * Return: 1 if threads waiting host attention, 0 otherwise.
+ */
+int xe_gt_eu_threads_needing_attention(struct xe_gt *gt)
+{
+	int err;
+
+	err = xe_gt_foreach_dss_group_instance(gt, read_first_attention_mcr, NULL);
+
+	/*
+	 * Negative is a suspended device, a forcewake timeout, a GT without
+	 * EUs or an empty dss mask. Report no attention, the next scan looks
+	 * again.
+	 */
+	return err < 0 ? 0 : err;
+}
diff --git a/drivers/gpu/drm/xe/xe_gt_debug.h b/drivers/gpu/drm/xe/xe_gt_debug.h
new file mode 100644
index 000000000000..d5a13e8667c4
--- /dev/null
+++ b/drivers/gpu/drm/xe/xe_gt_debug.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright © 2023 Intel Corporation
+ */
+
+#ifndef _XE_GT_DEBUG_H_
+#define _XE_GT_DEBUG_H_
+
+#include <linux/bits.h>
+#include <linux/math.h>
+
+struct xe_gt;
+
+#define XE_GT_EU_ATT_ROWS 2u
+
+unsigned int xe_gt_eu_att_regs(struct xe_gt *gt);
+
+int xe_gt_eu_threads_needing_attention(struct xe_gt *gt);
+int xe_gt_foreach_dss_group_instance(struct xe_gt *gt,
+				     int (*fn)(struct xe_gt *gt,
+					       void *data,
+					       u16 group,
+					       u16 instance,
+					       bool present),
+				     void *data);
+
+int xe_gt_eu_attention_bitmap_size(struct xe_gt *gt);
+int xe_gt_eu_attention_bitmap(struct xe_gt *gt, u8 *bits,
+			      unsigned int bitmap_size);
+
+#endif
diff --git a/drivers/gpu/drm/xe/xe_oa.c b/drivers/gpu/drm/xe/xe_oa.c
index 838802482ada..fe91abaccb14 100644
--- a/drivers/gpu/drm/xe/xe_oa.c
+++ b/drivers/gpu/drm/xe/xe_oa.c
@@ -27,6 +27,7 @@
 #include "xe_bb.h"
 #include "xe_bo.h"
 #include "xe_device.h"
+#include "xe_eudebug.h"
 #include "xe_exec_queue.h"
 #include "xe_force_wake.h"
 #include "xe_gt.h"
diff --git a/drivers/gpu/drm/xe/xe_reg_sr.c b/drivers/gpu/drm/xe/xe_reg_sr.c
index eab84a528d12..ca943956602f 100644
--- a/drivers/gpu/drm/xe/xe_reg_sr.c
+++ b/drivers/gpu/drm/xe/xe_reg_sr.c
@@ -105,7 +105,8 @@ static struct xe_reg sanitize_mcr(struct xe_reg_sr *sr,
 
 int xe_reg_sr_add(struct xe_reg_sr *sr,
 		  const struct xe_reg_sr_entry *e,
-		  struct xe_gt *gt)
+		  struct xe_gt *gt,
+		  bool overwrite)
 {
 	unsigned long idx = e->reg.addr;
 	struct xe_reg_sr_entry *pentry = xa_load(&sr->xa, idx);
@@ -115,15 +116,27 @@ int xe_reg_sr_add(struct xe_reg_sr *sr,
 	reg = sanitize_mcr(sr, e, gt);
 
 	if (pentry) {
-		if (!compatible_entries(pentry, e)) {
+		if (!overwrite && !compatible_entries(pentry, e)) {
 			ret = -EINVAL;
 			goto fail;
 		}
 
 		pentry->clr_bits |= e->clr_bits;
-		pentry->set_bits |= e->set_bits;
 		pentry->read_mask |= e->read_mask;
 
+		/*
+		 * Overwrite replaces the bits this entry owns instead of
+		 * accumulating them, so a caller can lower bits it raised
+		 * earlier. Same result as the plain or for a caller whose
+		 * set_bits and clr_bits are the same mask, but it also holds
+		 * when set_bits is a subset of clr_bits.
+		 */
+		if (overwrite)
+			pentry->set_bits = (pentry->set_bits & ~e->clr_bits) |
+					   e->set_bits;
+		else
+			pentry->set_bits |= e->set_bits;
+
 		return 0;
 	}
 
diff --git a/drivers/gpu/drm/xe/xe_reg_sr.h b/drivers/gpu/drm/xe/xe_reg_sr.h
index d26cf4713383..8231640edb0f 100644
--- a/drivers/gpu/drm/xe/xe_reg_sr.h
+++ b/drivers/gpu/drm/xe/xe_reg_sr.h
@@ -6,6 +6,8 @@
 #ifndef _XE_REG_SR_H_
 #define _XE_REG_SR_H_
 
+#include <linux/types.h>
+
 /*
  * Reg save/restore bookkeeping
  */
@@ -28,7 +30,7 @@ void xe_reg_sr_lrc_check(struct xe_reg_sr *sr,
 			 struct drm_printer *p);
 
 int xe_reg_sr_add(struct xe_reg_sr *sr, const struct xe_reg_sr_entry *e,
-		  struct xe_gt *gt);
+		  struct xe_gt *gt, bool overwrite);
 void xe_reg_sr_apply_mmio(struct xe_reg_sr *sr, struct xe_gt *gt);
 void xe_reg_sr_apply_whitelist(struct xe_hw_engine *hwe);
 
diff --git a/drivers/gpu/drm/xe/xe_reg_whitelist.c b/drivers/gpu/drm/xe/xe_reg_whitelist.c
index cab1b578ca0e..744844f59bd5 100644
--- a/drivers/gpu/drm/xe/xe_reg_whitelist.c
+++ b/drivers/gpu/drm/xe/xe_reg_whitelist.c
@@ -193,7 +193,7 @@ static int whitelist_apply_to_hwe(struct xe_hw_engine *hwe, struct xe_reg_sr *in
 		}
 
 		xe_reg_whitelist_print_entry(&p, 0, reg, entry);
-		xe_reg_sr_add(out, &hwe_entry, hwe->gt);
+		xe_reg_sr_add(out, &hwe_entry, hwe->gt, false);
 
 		slot++;
 	}
diff --git a/drivers/gpu/drm/xe/xe_rtp.c b/drivers/gpu/drm/xe/xe_rtp.c
index 6a8d6ea68f25..56641a72f33f 100644
--- a/drivers/gpu/drm/xe/xe_rtp.c
+++ b/drivers/gpu/drm/xe/xe_rtp.c
@@ -244,7 +244,7 @@ static void rtp_add_sr_entry(const struct xe_rtp_action *action,
 
 	sr_entry.reg.addr += mmio_base;
 
-	xe_reg_sr_add(sr, &sr_entry, gt);
+	xe_reg_sr_add(sr, &sr_entry, gt, false);
 }
 
 static bool rtp_process_one_sr(const struct xe_rtp_entry_sr *entry,
diff --git a/drivers/gpu/drm/xe/xe_wa_oob.rules b/drivers/gpu/drm/xe/xe_wa_oob.rules
index da774e17cb69..6e1bd16e3329 100644
--- a/drivers/gpu/drm/xe/xe_wa_oob.rules
+++ b/drivers/gpu/drm/xe/xe_wa_oob.rules
@@ -80,3 +80,5 @@
 14028709524	GRAPHICS_VERSION(3510)
 14022766366	GRAPHICS_VERSION_RANGE(2001, 2004)
 		GRAPHICS_VERSION_RANGE(3000, 3005)
+18022722726	GRAPHICS_VERSION_RANGE(1250, 1274)
+14015474168	PLATFORM(PVC)
-- 
2.53.0

