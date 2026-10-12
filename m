Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0108CCA9ED1
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 08:38:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 191B610EF52;
	Mon, 12 Oct 2026 08:38:28 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79BFC10EF50
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 08:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791794296; x=1823330296;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=fg6tiF4yOXq8/QJMcU0U+VzwgHLEWmtqE7z2XRv2wJY=;
 b=YQkfq3uxf4HzF5jdYoVwyYa49zsE0JurSKYYm9TE1P3+91h6d5C7fmSp
 trolD6SYgPgudmsUpUH3nRwCYOsVpUL0aoQrJ6omOCrxlEnMjg2FVIIPi
 aaN2tw1jeShK+klaqRGljBj5BUIfnueXxv4wbI0mJLQZqhfT+hT5K2Yj8
 lnv/AZbv+FozCmgyZFS7jLAXdvexbAxWSy1jzn1aD/ZtoJ1nnLV6mXANH
 kHKnnNeIQQ6CT0uHujOU1eepEvjGzvGs50zsGTTs33/Sn632oidx60URF
 SODixYnD4R7LUwT8w5NjI5EsW50nbf5gdNYMTjVAWK7Y3HVmcHOn9eC4L w==;
X-CSE-ConnectionGUID: uowBLz8pTSu5df2WC1vj8w==
X-CSE-MsgGUID: XPnxieQnToesoTCY4H/qew==
X-IronPort-AV: E=McAfee;i="6800,10657,11932"; a="501024"
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="501024"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2026 01:38:16 -0700
X-CSE-ConnectionGUID: 9ZScIRkcQcqupT8/XUlxrQ==
X-CSE-MsgGUID: kpE1im/sTJOZEvYzjBoAdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="1030744"
Received: from pl-npu-pc-kwachow.igk.intel.com ([10.91.220.239])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2026 01:38:15 -0700
From: Karol Wachowski <karol.wachowski@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, jeff.hugo@oss.qualcomm.com, lizhi.hou@amd.com,
 andrzej.kacprowski@linux.intel.com, dawid.osuchowski@linux.intel.com,
 Karol Wachowski <karol.wachowski@linux.intel.com>
Subject: [PATCH 4/5] accel/ivpu: Merge buttress register headers
Date: Mon, 12 Oct 2026 10:38:01 +0200
Message-ID: <20261012083802.2778448-5-karol.wachowski@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261012083802.2778448-1-karol.wachowski@linux.intel.com>
References: <20261012083802.2778448-1-karol.wachowski@linux.intel.com>
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

Put the MTL and LNL buttress registers in a single header, like the IP
registers. No register shares its offset between MTL and LNL, so the
MTL ones are simply followed by the LNL ones.

Also fix the DUP_IDLE typo (should be DPU_IDLE).

No functional change.

Signed-off-by: Karol Wachowski <karol.wachowski@linux.intel.com>
---
 drivers/accel/ivpu/ivpu_hw_btrs.c             |  3 +-
 drivers/accel/ivpu/ivpu_hw_btrs_mtl_reg.h     | 83 -------------------
 ...u_hw_btrs_lnl_reg.h => ivpu_hw_btrs_reg.h} | 82 ++++++++++++++++--
 3 files changed, 78 insertions(+), 90 deletions(-)
 delete mode 100644 drivers/accel/ivpu/ivpu_hw_btrs_mtl_reg.h
 rename drivers/accel/ivpu/{ivpu_hw_btrs_lnl_reg.h => ivpu_hw_btrs_reg.h} (59%)

diff --git a/drivers/accel/ivpu/ivpu_hw_btrs.c b/drivers/accel/ivpu/ivpu_hw_btrs.c
index dce6e9d41ea9..5851d83dc36e 100644
--- a/drivers/accel/ivpu/ivpu_hw_btrs.c
+++ b/drivers/accel/ivpu/ivpu_hw_btrs.c
@@ -8,8 +8,7 @@
 #include "ivpu_drv.h"
 #include "ivpu_hw.h"
 #include "ivpu_hw_btrs.h"
-#include "ivpu_hw_btrs_lnl_reg.h"
-#include "ivpu_hw_btrs_mtl_reg.h"
+#include "ivpu_hw_btrs_reg.h"
 #include "ivpu_hw_reg_io.h"
 #include "ivpu_jsm_msg.h"
 #include "ivpu_pm.h"
diff --git a/drivers/accel/ivpu/ivpu_hw_btrs_mtl_reg.h b/drivers/accel/ivpu/ivpu_hw_btrs_mtl_reg.h
deleted file mode 100644
index e93d539e066f..000000000000
--- a/drivers/accel/ivpu/ivpu_hw_btrs_mtl_reg.h
+++ /dev/null
@@ -1,83 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (C) 2020-2023 Intel Corporation
- */
-
-#ifndef __IVPU_HW_BTRS_MTL_REG_H__
-#define __IVPU_HW_BTRS_MTL_REG_H__
-
-#include <linux/bits.h>
-
-#define VPU_HW_BTRS_MTL_INTERRUPT_TYPE				0x00000000u
-
-#define VPU_HW_BTRS_MTL_INTERRUPT_STAT				0x00000004u
-#define VPU_HW_BTRS_MTL_INTERRUPT_STAT_FREQ_CHANGE_MASK		BIT_MASK(0)
-#define VPU_HW_BTRS_MTL_INTERRUPT_STAT_ATS_ERR_MASK		BIT_MASK(1)
-#define VPU_HW_BTRS_MTL_INTERRUPT_STAT_UFI_ERR_MASK		BIT_MASK(2)
-
-#define VPU_HW_BTRS_MTL_WP_REQ_PAYLOAD0				0x00000008u
-#define VPU_HW_BTRS_MTL_WP_REQ_PAYLOAD0_MIN_RATIO_MASK		GENMASK(15, 0)
-#define VPU_HW_BTRS_MTL_WP_REQ_PAYLOAD0_MAX_RATIO_MASK		GENMASK(31, 16)
-
-#define VPU_HW_BTRS_MTL_WP_REQ_PAYLOAD1				0x0000000cu
-#define VPU_HW_BTRS_MTL_WP_REQ_PAYLOAD1_TARGET_RATIO_MASK	GENMASK(15, 0)
-#define VPU_HW_BTRS_MTL_WP_REQ_PAYLOAD1_EPP_MASK		GENMASK(31, 16)
-
-#define VPU_HW_BTRS_MTL_WP_REQ_PAYLOAD2				0x00000010u
-#define VPU_HW_BTRS_MTL_WP_REQ_PAYLOAD2_CONFIG_MASK		GENMASK(15, 0)
-
-#define VPU_HW_BTRS_MTL_WP_REQ_CMD				0x00000014u
-#define VPU_HW_BTRS_MTL_WP_REQ_CMD_SEND_MASK			BIT_MASK(0)
-
-#define VPU_HW_BTRS_MTL_WP_DOWNLOAD				0x00000018u
-#define VPU_HW_BTRS_MTL_WP_DOWNLOAD_TARGET_RATIO_MASK		GENMASK(15, 0)
-
-#define VPU_HW_BTRS_MTL_CURRENT_PLL				0x0000001cu
-#define VPU_HW_BTRS_MTL_CURRENT_PLL_RATIO_MASK			GENMASK(15, 0)
-
-#define VPU_HW_BTRS_MTL_PLL_ENABLE				0x00000020u
-
-#define VPU_HW_BTRS_MTL_FMIN_FUSE				0x00000024u
-#define VPU_HW_BTRS_MTL_FMIN_FUSE_MIN_RATIO_MASK		GENMASK(7, 0)
-#define VPU_HW_BTRS_MTL_FMIN_FUSE_PN_RATIO_MASK			GENMASK(15, 8)
-
-#define VPU_HW_BTRS_MTL_FMAX_FUSE				0x00000028u
-#define VPU_HW_BTRS_MTL_FMAX_FUSE_MAX_RATIO_MASK		GENMASK(7, 0)
-
-#define VPU_HW_BTRS_MTL_TILE_FUSE				0x0000002cu
-#define VPU_HW_BTRS_MTL_TILE_FUSE_VALID_MASK			BIT_MASK(0)
-#define VPU_HW_BTRS_MTL_TILE_FUSE_SKU_MASK			GENMASK(3, 2)
-
-#define VPU_HW_BTRS_MTL_LOCAL_INT_MASK				0x00000030u
-#define VPU_HW_BTRS_MTL_GLOBAL_INT_MASK				0x00000034u
-
-#define VPU_HW_BTRS_MTL_PLL_STATUS				0x00000040u
-#define VPU_HW_BTRS_MTL_PLL_STATUS_LOCK_MASK			BIT_MASK(1)
-
-#define VPU_HW_BTRS_MTL_VPU_STATUS				0x00000044u
-#define VPU_HW_BTRS_MTL_VPU_STATUS_READY_MASK			BIT_MASK(0)
-#define VPU_HW_BTRS_MTL_VPU_STATUS_IDLE_MASK			BIT_MASK(1)
-
-#define VPU_HW_BTRS_MTL_VPU_D0I3_CONTROL			0x00000060u
-#define VPU_HW_BTRS_MTL_VPU_D0I3_CONTROL_INPROGRESS_MASK	BIT_MASK(0)
-#define VPU_HW_BTRS_MTL_VPU_D0I3_CONTROL_I3_MASK		BIT_MASK(2)
-
-#define VPU_HW_BTRS_MTL_VPU_IP_RESET				0x00000050u
-#define VPU_HW_BTRS_MTL_VPU_IP_RESET_TRIGGER_MASK		BIT_MASK(0)
-
-#define VPU_HW_BTRS_MTL_VPU_TELEMETRY_OFFSET			0x00000080u
-#define VPU_HW_BTRS_MTL_VPU_TELEMETRY_SIZE			0x00000084u
-#define VPU_HW_BTRS_MTL_VPU_TELEMETRY_ENABLE			0x00000088u
-
-#define VPU_HW_BTRS_MTL_ATS_ERR_LOG_0				0x000000a0u
-#define VPU_HW_BTRS_MTL_ATS_ERR_LOG_1				0x000000a4u
-#define VPU_HW_BTRS_MTL_ATS_ERR_CLEAR				0x000000a8u
-
-#define VPU_HW_BTRS_MTL_UFI_ERR_LOG				0x000000b0u
-#define VPU_HW_BTRS_MTL_UFI_ERR_LOG_CQ_ID_MASK			GENMASK(11, 0)
-#define VPU_HW_BTRS_MTL_UFI_ERR_LOG_AXI_ID_MASK			GENMASK(19, 12)
-#define VPU_HW_BTRS_MTL_UFI_ERR_LOG_OPCODE_MASK			GENMASK(24, 20)
-
-#define VPU_HW_BTRS_MTL_UFI_ERR_CLEAR				0x000000b4u
-
-#endif /* __IVPU_HW_BTRS_MTL_REG_H__ */
diff --git a/drivers/accel/ivpu/ivpu_hw_btrs_lnl_reg.h b/drivers/accel/ivpu/ivpu_hw_btrs_reg.h
similarity index 59%
rename from drivers/accel/ivpu/ivpu_hw_btrs_lnl_reg.h
rename to drivers/accel/ivpu/ivpu_hw_btrs_reg.h
index a81a9ba540fa..8e20eed15967 100644
--- a/drivers/accel/ivpu/ivpu_hw_btrs_lnl_reg.h
+++ b/drivers/accel/ivpu/ivpu_hw_btrs_reg.h
@@ -1,13 +1,85 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- * Copyright (C) 2020-2024 Intel Corporation
+ * Copyright (C) 2020-2026 Intel Corporation
  */
 
-#ifndef __IVPU_HW_BTRS_LNL_REG_H__
-#define __IVPU_HW_BTRS_LNL_REG_H__
+#ifndef __IVPU_HW_BTRS_REG_H__
+#define __IVPU_HW_BTRS_REG_H__
 
 #include <linux/bits.h>
 
+#define VPU_HW_BTRS_MTL_INTERRUPT_TYPE				0x00000000u
+
+#define VPU_HW_BTRS_MTL_INTERRUPT_STAT				0x00000004u
+#define VPU_HW_BTRS_MTL_INTERRUPT_STAT_FREQ_CHANGE_MASK		BIT_MASK(0)
+#define VPU_HW_BTRS_MTL_INTERRUPT_STAT_ATS_ERR_MASK		BIT_MASK(1)
+#define VPU_HW_BTRS_MTL_INTERRUPT_STAT_UFI_ERR_MASK		BIT_MASK(2)
+
+#define VPU_HW_BTRS_MTL_WP_REQ_PAYLOAD0				0x00000008u
+#define VPU_HW_BTRS_MTL_WP_REQ_PAYLOAD0_MIN_RATIO_MASK		GENMASK(15, 0)
+#define VPU_HW_BTRS_MTL_WP_REQ_PAYLOAD0_MAX_RATIO_MASK		GENMASK(31, 16)
+
+#define VPU_HW_BTRS_MTL_WP_REQ_PAYLOAD1				0x0000000cu
+#define VPU_HW_BTRS_MTL_WP_REQ_PAYLOAD1_TARGET_RATIO_MASK	GENMASK(15, 0)
+#define VPU_HW_BTRS_MTL_WP_REQ_PAYLOAD1_EPP_MASK		GENMASK(31, 16)
+
+#define VPU_HW_BTRS_MTL_WP_REQ_PAYLOAD2				0x00000010u
+#define VPU_HW_BTRS_MTL_WP_REQ_PAYLOAD2_CONFIG_MASK		GENMASK(15, 0)
+
+#define VPU_HW_BTRS_MTL_WP_REQ_CMD				0x00000014u
+#define VPU_HW_BTRS_MTL_WP_REQ_CMD_SEND_MASK			BIT_MASK(0)
+
+#define VPU_HW_BTRS_MTL_WP_DOWNLOAD				0x00000018u
+#define VPU_HW_BTRS_MTL_WP_DOWNLOAD_TARGET_RATIO_MASK		GENMASK(15, 0)
+
+#define VPU_HW_BTRS_MTL_CURRENT_PLL				0x0000001cu
+#define VPU_HW_BTRS_MTL_CURRENT_PLL_RATIO_MASK			GENMASK(15, 0)
+
+#define VPU_HW_BTRS_MTL_PLL_ENABLE				0x00000020u
+
+#define VPU_HW_BTRS_MTL_FMIN_FUSE				0x00000024u
+#define VPU_HW_BTRS_MTL_FMIN_FUSE_MIN_RATIO_MASK		GENMASK(7, 0)
+#define VPU_HW_BTRS_MTL_FMIN_FUSE_PN_RATIO_MASK			GENMASK(15, 8)
+
+#define VPU_HW_BTRS_MTL_FMAX_FUSE				0x00000028u
+#define VPU_HW_BTRS_MTL_FMAX_FUSE_MAX_RATIO_MASK		GENMASK(7, 0)
+
+#define VPU_HW_BTRS_MTL_TILE_FUSE				0x0000002cu
+#define VPU_HW_BTRS_MTL_TILE_FUSE_VALID_MASK			BIT_MASK(0)
+#define VPU_HW_BTRS_MTL_TILE_FUSE_SKU_MASK			GENMASK(3, 2)
+
+#define VPU_HW_BTRS_MTL_LOCAL_INT_MASK				0x00000030u
+#define VPU_HW_BTRS_MTL_GLOBAL_INT_MASK				0x00000034u
+
+#define VPU_HW_BTRS_MTL_PLL_STATUS				0x00000040u
+#define VPU_HW_BTRS_MTL_PLL_STATUS_LOCK_MASK			BIT_MASK(1)
+
+#define VPU_HW_BTRS_MTL_VPU_STATUS				0x00000044u
+#define VPU_HW_BTRS_MTL_VPU_STATUS_READY_MASK			BIT_MASK(0)
+#define VPU_HW_BTRS_MTL_VPU_STATUS_IDLE_MASK			BIT_MASK(1)
+
+#define VPU_HW_BTRS_MTL_VPU_IP_RESET				0x00000050u
+#define VPU_HW_BTRS_MTL_VPU_IP_RESET_TRIGGER_MASK		BIT_MASK(0)
+
+#define VPU_HW_BTRS_MTL_VPU_D0I3_CONTROL			0x00000060u
+#define VPU_HW_BTRS_MTL_VPU_D0I3_CONTROL_INPROGRESS_MASK	BIT_MASK(0)
+#define VPU_HW_BTRS_MTL_VPU_D0I3_CONTROL_I3_MASK		BIT_MASK(2)
+
+#define VPU_HW_BTRS_MTL_VPU_TELEMETRY_OFFSET			0x00000080u
+#define VPU_HW_BTRS_MTL_VPU_TELEMETRY_SIZE			0x00000084u
+#define VPU_HW_BTRS_MTL_VPU_TELEMETRY_ENABLE			0x00000088u
+
+#define VPU_HW_BTRS_MTL_ATS_ERR_LOG_0				0x000000a0u
+#define VPU_HW_BTRS_MTL_ATS_ERR_LOG_1				0x000000a4u
+#define VPU_HW_BTRS_MTL_ATS_ERR_CLEAR				0x000000a8u
+
+#define VPU_HW_BTRS_MTL_UFI_ERR_LOG				0x000000b0u
+#define VPU_HW_BTRS_MTL_UFI_ERR_LOG_CQ_ID_MASK			GENMASK(11, 0)
+#define VPU_HW_BTRS_MTL_UFI_ERR_LOG_AXI_ID_MASK			GENMASK(19, 12)
+#define VPU_HW_BTRS_MTL_UFI_ERR_LOG_OPCODE_MASK			GENMASK(24, 20)
+
+#define VPU_HW_BTRS_MTL_UFI_ERR_CLEAR				0x000000b4u
+
 #define VPU_HW_BTRS_LNL_INTERRUPT_STAT				0x00000000u
 #define VPU_HW_BTRS_LNL_INTERRUPT_STAT_FREQ_CHANGE_MASK		BIT_MASK(0)
 #define VPU_HW_BTRS_LNL_INTERRUPT_STAT_ATS_ERR_MASK		BIT_MASK(1)
@@ -84,7 +156,7 @@
 #define VPU_HW_BTRS_LNL_VPU_STATUS				0x00000154u
 #define VPU_HW_BTRS_LNL_VPU_STATUS_READY_MASK			BIT_MASK(0)
 #define VPU_HW_BTRS_LNL_VPU_STATUS_IDLE_MASK			BIT_MASK(1)
-#define VPU_HW_BTRS_LNL_VPU_STATUS_DUP_IDLE_MASK		BIT_MASK(2)
+#define VPU_HW_BTRS_LNL_VPU_STATUS_DPU_IDLE_MASK		BIT_MASK(2)
 #define VPU_HW_BTRS_LNL_VPU_STATUS_CLOCK_RESOURCE_OWN_ACK_MASK	BIT_MASK(6)
 #define VPU_HW_BTRS_LNL_VPU_STATUS_POWER_RESOURCE_OWN_ACK_MASK	BIT_MASK(7)
 #define VPU_HW_BTRS_LNL_VPU_STATUS_PERF_CLK_MASK		BIT_MASK(11)
@@ -109,4 +181,4 @@
 #define VPU_HW_BTRS_LNL_FMAX_FUSE				0x00000178u
 #define VPU_HW_BTRS_LNL_FMAX_FUSE_MAX_RATIO_MASK		GENMASK(7, 0)
 
-#endif /* __IVPU_HW_BTRS_LNL_REG_H__ */
+#endif /* __IVPU_HW_BTRS_REG_H__ */
-- 
2.43.0

