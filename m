Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B586CA9ED1
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 08:38:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91DC310EF58;
	Mon, 12 Oct 2026 08:38:18 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9303110EF50
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 08:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791794290; x=1823330290;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=hRfA1MBdg+CUCMg3oozA2lOzLqAniQm4ZMcDzuUA65g=;
 b=GKKkNvvzvtCJDSSfpK3UDXFeXrdIKQkfQyx4zsJgJ7I2qIyGeT1gFthW
 2OoxUTPuXLOxwHLWLKd9J9jofHP5hBPVFhJHiHA/UxYH5LLEj4hrtdCLW
 WWypjanXuPE++W2QyvzhfdZXG3wDZtTD0o2JsZiptIe4BhXxFQnB7EBN5
 Oxe+L8wmXOGbHDFMhl54/gn7+AuApAQvioM0D8LUVT8zcommE2hpGcNH3
 Bp294kO+0r1A3RWgyiZfrx1CLszLvB5YJ0wrKf235tRnchwvPEe5d/jw7
 vg4TkiSbpItoEmR5bInsHlInhZR1Q7iYnAnHItMM5TtvAKhv6e6b3i3h+ g==;
X-CSE-ConnectionGUID: YcESugawR2WjZuTImQp1Hw==
X-CSE-MsgGUID: YH+7Wk0NRx+KUSLv3ggW+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11932"; a="501007"
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="501007"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2026 01:38:10 -0700
X-CSE-ConnectionGUID: o73O1EiRTRWHrSZAa9JUYw==
X-CSE-MsgGUID: QyeSdih3RLGkQ9kMD0Kjiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="1030696"
Received: from pl-npu-pc-kwachow.igk.intel.com ([10.91.220.239])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2026 01:38:09 -0700
From: Karol Wachowski <karol.wachowski@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, jeff.hugo@oss.qualcomm.com, lizhi.hou@amd.com,
 andrzej.kacprowski@linux.intel.com, dawid.osuchowski@linux.intel.com,
 Karol Wachowski <karol.wachowski@linux.intel.com>
Subject: [PATCH 1/5] accel/ivpu: Add test mode to enable the FREQ_CHANGE
 interrupt
Date: Mon, 12 Oct 2026 10:37:58 +0200
Message-ID: <20261012083802.2778448-2-karol.wachowski@linux.intel.com>
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

The buttress FREQ_CHANGE interrupt is not enabled by the driver, but
there is no way to turn it on for testing and debugging.

Store the buttress interrupt mask in struct ivpu_hw_info, so it is set up
once during HW info initialization instead of being a compile time
constant, and use it everywhere the mask is needed. Add the
IVPU_TEST_MODE_FREQ_CHANGE_ENABLE test mode that adds FREQ_CHANGE to this
mask.

No functional change with the test mode disabled.

Signed-off-by: Karol Wachowski <karol.wachowski@linux.intel.com>
---
 drivers/accel/ivpu/ivpu_drv.h     |  1 +
 drivers/accel/ivpu/ivpu_hw.h      |  1 +
 drivers/accel/ivpu/ivpu_hw_btrs.c | 22 ++++++++++++++++------
 3 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/accel/ivpu/ivpu_drv.h b/drivers/accel/ivpu/ivpu_drv.h
index e87eb0f9e486..ea5b8dc612d1 100644
--- a/drivers/accel/ivpu/ivpu_drv.h
+++ b/drivers/accel/ivpu/ivpu_drv.h
@@ -230,6 +230,7 @@ extern bool ivpu_force_snoop;
 #define IVPU_TEST_MODE_FW_TEST            BIT(0)
 #define IVPU_TEST_MODE_NULL_HW            BIT(1)
 #define IVPU_TEST_MODE_NULL_SUBMISSION    BIT(2)
+#define IVPU_TEST_MODE_FREQ_CHANGE_ENABLE BIT(3)
 #define IVPU_TEST_MODE_MIP_DISABLE        BIT(6)
 #define IVPU_TEST_MODE_DISABLE_TIMEOUTS   BIT(8)
 #define IVPU_TEST_MODE_TURBO_ENABLE       BIT(9)
diff --git a/drivers/accel/ivpu/ivpu_hw.h b/drivers/accel/ivpu/ivpu_hw.h
index 11717ffe738c..d3c9ffe6a4b9 100644
--- a/drivers/accel/ivpu/ivpu_hw.h
+++ b/drivers/accel/ivpu/ivpu_hw.h
@@ -51,6 +51,7 @@ struct ivpu_hw_info {
 	u16 config;
 	ktime_t d0i3_entry_host_ts;
 	u64 d0i3_entry_vpu_ts;
+	u32 btrs_irq_mask;
 	atomic_t firewall_irq_counter;
 };
 
diff --git a/drivers/accel/ivpu/ivpu_hw_btrs.c b/drivers/accel/ivpu/ivpu_hw_btrs.c
index 2f4f5156d62e..dce6e9d41ea9 100644
--- a/drivers/accel/ivpu/ivpu_hw_btrs.c
+++ b/drivers/accel/ivpu/ivpu_hw_btrs.c
@@ -141,6 +141,11 @@ static int info_init_mtl(struct ivpu_device *vdev)
 	hw->tile_fuse = BTRS_MTL_TILE_FUSE_ENABLE_BOTH;
 	hw->sku = BTRS_MTL_TILE_SKU_BOTH;
 	hw->config = WP_CONFIG(MTL_CONFIG_2_TILE, MTL_PLL_RATIO_4_3);
+	hw->btrs_irq_mask = BTRS_MTL_IRQ_MASK;
+
+	if (ivpu_test_mode & IVPU_TEST_MODE_FREQ_CHANGE_ENABLE)
+		hw->btrs_irq_mask = REG_SET_FLD(VPU_HW_BTRS_MTL_INTERRUPT_STAT, FREQ_CHANGE,
+						hw->btrs_irq_mask);
 
 	return 0;
 }
@@ -157,6 +162,11 @@ static int info_init_lnl(struct ivpu_device *vdev)
 
 	hw->tile_fuse = tile_fuse_config;
 	hw->pll.profiling_freq = PLL_PROFILING_FREQ_DEFAULT;
+	hw->btrs_irq_mask = BTRS_LNL_IRQ_MASK;
+
+	if (ivpu_test_mode & IVPU_TEST_MODE_FREQ_CHANGE_ENABLE)
+		hw->btrs_irq_mask = REG_SET_FLD(VPU_HW_BTRS_LNL_INTERRUPT_STAT, FREQ_CHANGE,
+						hw->btrs_irq_mask);
 
 	return 0;
 }
@@ -683,7 +693,7 @@ int ivpu_hw_btrs_cfg_freq_init(struct ivpu_device *vdev)
 /* Handler for IRQs from Buttress core (irqB) */
 bool ivpu_hw_btrs_irq_handler_mtl(struct ivpu_device *vdev, int irq)
 {
-	u32 status = REGB_RD32(VPU_HW_BTRS_MTL_INTERRUPT_STAT) & BTRS_MTL_IRQ_MASK;
+	u32 status = REGB_RD32(VPU_HW_BTRS_MTL_INTERRUPT_STAT) & vdev->hw->btrs_irq_mask;
 	bool schedule_recovery = false;
 
 	if (!status)
@@ -725,7 +735,7 @@ bool ivpu_hw_btrs_irq_handler_mtl(struct ivpu_device *vdev, int irq)
 /* Handler for IRQs from Buttress core (irqB) */
 bool ivpu_hw_btrs_irq_handler_lnl(struct ivpu_device *vdev, int irq)
 {
-	u32 status = REGB_RD32(VPU_HW_BTRS_LNL_INTERRUPT_STAT) & BTRS_LNL_IRQ_MASK;
+	u32 status = REGB_RD32(VPU_HW_BTRS_LNL_INTERRUPT_STAT) & vdev->hw->btrs_irq_mask;
 	bool schedule_recovery = false;
 
 	if (!status)
@@ -867,10 +877,10 @@ void ivpu_hw_btrs_global_int_enable(struct ivpu_device *vdev)
 void ivpu_hw_btrs_irq_enable(struct ivpu_device *vdev)
 {
 	if (ivpu_hw_btrs_gen(vdev) == IVPU_HW_BTRS_MTL) {
-		REGB_WR32(VPU_HW_BTRS_MTL_LOCAL_INT_MASK, (u32)(~BTRS_MTL_IRQ_MASK));
+		REGB_WR32(VPU_HW_BTRS_MTL_LOCAL_INT_MASK, (u32)(~vdev->hw->btrs_irq_mask));
 		REGB_WR32(VPU_HW_BTRS_MTL_GLOBAL_INT_MASK, 0x0);
 	} else {
-		REGB_WR32(VPU_HW_BTRS_LNL_LOCAL_INT_MASK, (u32)(~BTRS_LNL_IRQ_MASK));
+		REGB_WR32(VPU_HW_BTRS_LNL_LOCAL_INT_MASK, (u32)(~vdev->hw->btrs_irq_mask));
 		REGB_WR32(VPU_HW_BTRS_LNL_GLOBAL_INT_MASK, 0x0);
 	}
 }
@@ -888,7 +898,7 @@ void ivpu_hw_btrs_irq_disable(struct ivpu_device *vdev)
 
 static void diagnose_failure_mtl(struct ivpu_device *vdev)
 {
-	u32 reg = REGB_RD32(VPU_HW_BTRS_MTL_INTERRUPT_STAT) & BTRS_MTL_IRQ_MASK;
+	u32 reg = REGB_RD32(VPU_HW_BTRS_MTL_INTERRUPT_STAT) & vdev->hw->btrs_irq_mask;
 
 	if (REG_TEST_FLD(VPU_HW_BTRS_MTL_INTERRUPT_STAT, ATS_ERR, reg))
 		ivpu_err(vdev, "ATS_ERR irq 0x%016llx", REGB_RD64(VPU_HW_BTRS_MTL_ATS_ERR_LOG_0));
@@ -905,7 +915,7 @@ static void diagnose_failure_mtl(struct ivpu_device *vdev)
 
 static void diagnose_failure_lnl(struct ivpu_device *vdev)
 {
-	u32 reg = REGB_RD32(VPU_HW_BTRS_LNL_INTERRUPT_STAT) & BTRS_LNL_IRQ_MASK;
+	u32 reg = REGB_RD32(VPU_HW_BTRS_LNL_INTERRUPT_STAT) & vdev->hw->btrs_irq_mask;
 
 	if (REG_TEST_FLD(VPU_HW_BTRS_LNL_INTERRUPT_STAT, ATS_ERR, reg)) {
 		ivpu_err(vdev, "ATS_ERR_LOG1 0x%08x ATS_ERR_LOG2 0x%08x\n",
-- 
2.43.0

