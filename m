Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1BC9C88E6E
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 08:27:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16CD610E13B;
	Mon, 14 Sep 2026 08:27:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Qe0zco4V";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66B1C89190
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 08:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789374419; x=1820910419;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=F0seJX/gdXPPqaOK4ZLnfKkXx4glAvLd1xYuegNK24c=;
 b=Qe0zco4VD7N3gydCdwfUArKKKAR76Ham4IAXqghthfyN7oBuudvgrZtk
 cdYZCM2tRw4z42YI4+OH7Wj92Ftm6/noP7+JmPMgep78ZLl/k6/soYM7j
 0/ODG5nvFlskXOroPrRLvw6izeZx32mUj7GBKUwbGGlUb+DAaj7mQebmN
 GsFLytugdG+TJCOZnU/AYzfzKxQd6j4A33GFagi+/mOjkb21NlX5oChuk
 eZiXJLITGYSeYPjQnPiLeH2g8bQFuSu5adO5HibIBHFAZkp2U0KiybZSE
 1NpOYiZGVr1og+GNpXno3AdAmp/xJYax9sfE87GLM4N1RbFbB3ZoMD5mP A==;
X-CSE-ConnectionGUID: GtmFHsQ7TceW6LAIQZ8IPw==
X-CSE-MsgGUID: CG9Ph8+lRO+O+n7R5wKEgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11904"; a="112493801"
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; d="scan'208";a="112493801"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2026 01:26:58 -0700
X-CSE-ConnectionGUID: wEWtduZUR/CF509s54mOuQ==
X-CSE-MsgGUID: WAHS+3xhTQS5uENCmG1LQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; d="scan'208";a="276735402"
Received: from pl-npu-pc-kwachow.igk.intel.com ([10.91.220.239])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2026 01:26:57 -0700
From: Karol Wachowski <karol.wachowski@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, jeff.hugo@oss.qualcomm.com, lizhi.hou@amd.com,
 andrzej.kacprowski@linux.intel.com, dawid.osuchowski@linux.intel.com,
 Tomasz Rusinowicz <tomasz.rusinowicz@intel.com>
Subject: [PATCH] accel/ivpu: Move register poll timeouts to vdev->timeout
Date: Mon, 14 Sep 2026 10:26:49 +0200
Message-ID: <20260914082649.891871-1-karol.wachowski@linux.intel.com>
X-Mailer: git-send-email 2.43.0
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

From: Tomasz Rusinowicz <tomasz.rusinowicz@intel.com>

Use the vdev->timeout structure for register poll timeouts. This allows
adjusting those timeouts depending on the platform type.
For FPGA set MMU timeouts to 10x.

Signed-off-by: Tomasz Rusinowicz <tomasz.rusinowicz@intel.com>
---
 drivers/accel/ivpu/ivpu_drv.h   |  3 +++
 drivers/accel/ivpu/ivpu_hw.c    | 20 ++++++++++++++++++++
 drivers/accel/ivpu/ivpu_hw_ip.c |  6 ++----
 drivers/accel/ivpu/ivpu_mmu.c   | 12 ++++--------
 4 files changed, 29 insertions(+), 12 deletions(-)

diff --git a/drivers/accel/ivpu/ivpu_drv.h b/drivers/accel/ivpu/ivpu_drv.h
index 8f29f1dc52b9..3b26a64ed04f 100644
--- a/drivers/accel/ivpu/ivpu_drv.h
+++ b/drivers/accel/ivpu/ivpu_drv.h
@@ -186,6 +186,9 @@ struct ivpu_device {
 		int autosuspend;
 		int d0i3_entry_msg;
 		int state_dump_msg;
+		int mmu_reg;
+		int mmu_queue;
+		int pwr_island_status;
 	} timeout;
 };
 
diff --git a/drivers/accel/ivpu/ivpu_hw.c b/drivers/accel/ivpu/ivpu_hw.c
index 647dc045c231..613bcdbc364c 100644
--- a/drivers/accel/ivpu/ivpu_hw.c
+++ b/drivers/accel/ivpu/ivpu_hw.c
@@ -99,13 +99,19 @@ static void wa_init(struct ivpu_device *vdev)
 static void timeouts_init(struct ivpu_device *vdev)
 {
 	if (ivpu_test_mode & IVPU_TEST_MODE_DISABLE_TIMEOUTS) {
+		/* in milliseconds */
 		vdev->timeout.boot = -1;
 		vdev->timeout.jsm = -1;
 		vdev->timeout.tdr = -1;
 		vdev->timeout.inference = -1;
 		vdev->timeout.autosuspend = -1;
 		vdev->timeout.d0i3_entry_msg = -1;
+		/* in microseconds */
+		vdev->timeout.mmu_reg = -1;
+		vdev->timeout.mmu_queue = -1;
+		vdev->timeout.pwr_island_status = -1;
 	} else if (ivpu_is_fpga(vdev)) {
+		/* in milliseconds */
 		vdev->timeout.boot = 50;
 		vdev->timeout.jsm = 15000;
 		vdev->timeout.tdr = 30000;
@@ -113,7 +119,12 @@ static void timeouts_init(struct ivpu_device *vdev)
 		vdev->timeout.autosuspend = -1;
 		vdev->timeout.d0i3_entry_msg = 500;
 		vdev->timeout.state_dump_msg = 10000;
+		/* in microseconds */
+		vdev->timeout.mmu_reg = 100 * USEC_PER_MSEC;
+		vdev->timeout.mmu_queue = 1000 * USEC_PER_MSEC;
+		vdev->timeout.pwr_island_status = 5 * USEC_PER_MSEC;
 	} else if (ivpu_is_simics(vdev)) {
+		/* in milliseconds */
 		vdev->timeout.boot = 50;
 		vdev->timeout.jsm = 500;
 		vdev->timeout.tdr = 10000;
@@ -121,7 +132,12 @@ static void timeouts_init(struct ivpu_device *vdev)
 		vdev->timeout.autosuspend = 100;
 		vdev->timeout.d0i3_entry_msg = 100;
 		vdev->timeout.state_dump_msg = 10;
+		/* in microseconds */
+		vdev->timeout.mmu_reg = 10 * USEC_PER_MSEC;
+		vdev->timeout.mmu_queue = 100 * USEC_PER_MSEC;
+		vdev->timeout.pwr_island_status = 5 * USEC_PER_MSEC;
 	} else {
+		/* in milliseconds */
 		vdev->timeout.boot = 1000;
 		vdev->timeout.jsm = 500;
 		vdev->timeout.tdr = 2000;
@@ -132,6 +148,10 @@ static void timeouts_init(struct ivpu_device *vdev)
 			vdev->timeout.autosuspend = 100;
 		vdev->timeout.d0i3_entry_msg = 5;
 		vdev->timeout.state_dump_msg = 100;
+		/* in microseconds */
+		vdev->timeout.mmu_reg = 10 * USEC_PER_MSEC;
+		vdev->timeout.mmu_queue = 100 * USEC_PER_MSEC;
+		vdev->timeout.pwr_island_status = 5 * USEC_PER_MSEC;
 	}
 }
 
diff --git a/drivers/accel/ivpu/ivpu_hw_ip.c b/drivers/accel/ivpu/ivpu_hw_ip.c
index 81f0b1f8f5a6..46661fbf9d05 100644
--- a/drivers/accel/ivpu/ivpu_hw_ip.c
+++ b/drivers/accel/ivpu/ivpu_hw_ip.c
@@ -15,8 +15,6 @@
 #include "ivpu_mmu.h"
 #include "ivpu_pm.h"
 
-#define PWR_ISLAND_STATUS_TIMEOUT_US        (5 * USEC_PER_MSEC)
-
 #define TIM_SAFE_ENABLE		            0xf1d0dead
 #define TIM_WATCHDOG_RESET_VALUE            0xffffffff
 
@@ -350,10 +348,10 @@ static int wait_for_pwr_island_status(struct ivpu_device *vdev, u32 exp_val)
 
 	if (ivpu_hw_ip_gen(vdev) == IVPU_HW_IP_37XX)
 		return REGV_POLL_FLD(VPU_37XX_HOST_SS_AON_PWR_ISLAND_STATUS0, MSS_CPU, exp_val,
-				     PWR_ISLAND_STATUS_TIMEOUT_US);
+				     vdev->timeout.pwr_island_status);
 	else
 		return REGV_POLL_FLD(VPU_40XX_HOST_SS_AON_PWR_ISLAND_STATUS0, CSS_CPU, exp_val,
-				     PWR_ISLAND_STATUS_TIMEOUT_US);
+				     vdev->timeout.pwr_island_status);
 }
 
 static void pwr_island_isolation_drive_37xx(struct ivpu_device *vdev, bool enable)
diff --git a/drivers/accel/ivpu/ivpu_mmu.c b/drivers/accel/ivpu/ivpu_mmu.c
index 41efd8985fa6..1908375ff128 100644
--- a/drivers/accel/ivpu/ivpu_mmu.c
+++ b/drivers/accel/ivpu/ivpu_mmu.c
@@ -220,9 +220,6 @@
 #define IVPU_MMU_STE_1_S1DSS		GENMASK_ULL(1, 0)
 #define IVPU_MMU_STE_1_S1DSS_TERMINATE	0x0
 
-#define IVPU_MMU_REG_TIMEOUT_US		(10 * USEC_PER_MSEC)
-#define IVPU_MMU_QUEUE_TIMEOUT_US	(100 * USEC_PER_MSEC)
-
 #define IVPU_MMU_GERROR_ERR_MASK ((REG_FLD(IVPU_MMU_REG_GERROR, CMDQ)) | \
 				  (REG_FLD(IVPU_MMU_REG_GERROR, EVTQ_ABT)) | \
 				  (REG_FLD(IVPU_MMU_REG_GERROR, PRIQ_ABT)) | \
@@ -438,14 +435,14 @@ static int ivpu_mmu_reg_write_cr0(struct ivpu_device *vdev, u32 val)
 {
 	REGV_WR32(IVPU_MMU_REG_CR0, val);
 
-	return REGV_POLL_FLD(IVPU_MMU_REG_CR0ACK, VAL, val, IVPU_MMU_REG_TIMEOUT_US);
+	return REGV_POLL_FLD(IVPU_MMU_REG_CR0ACK, VAL, val, vdev->timeout.mmu_reg);
 }
 
 static int ivpu_mmu_reg_write_irq_ctrl(struct ivpu_device *vdev, u32 val)
 {
 	REGV_WR32(IVPU_MMU_REG_IRQ_CTRL, val);
 
-	return REGV_POLL_FLD(IVPU_MMU_REG_IRQ_CTRLACK, VAL, val, IVPU_MMU_REG_TIMEOUT_US);
+	return REGV_POLL_FLD(IVPU_MMU_REG_IRQ_CTRLACK, VAL, val, vdev->timeout.mmu_reg);
 }
 
 static int ivpu_mmu_irqs_setup(struct ivpu_device *vdev)
@@ -465,8 +462,7 @@ static int ivpu_mmu_cmdq_wait_for_cons(struct ivpu_device *vdev)
 	struct ivpu_mmu_queue *cmdq = &vdev->mmu->cmdq;
 	int ret;
 
-	ret = REGV_POLL_FLD(IVPU_MMU_REG_CMDQ_CONS, VAL, cmdq->prod,
-			    IVPU_MMU_QUEUE_TIMEOUT_US);
+	ret = REGV_POLL_FLD(IVPU_MMU_REG_CMDQ_CONS, VAL, cmdq->prod, vdev->timeout.mmu_queue);
 	if (ret)
 		return ret;
 
@@ -880,7 +876,7 @@ static int ivpu_mmu_evtq_set(struct ivpu_device *vdev, bool enable)
 		val = REG_CLR_FLD(IVPU_MMU_REG_CR0, EVTQEN, val);
 	REGV_WR32(IVPU_MMU_REG_CR0, val);
 
-	return REGV_POLL_FLD(IVPU_MMU_REG_CR0ACK, VAL, val, IVPU_MMU_REG_TIMEOUT_US);
+	return REGV_POLL_FLD(IVPU_MMU_REG_CR0ACK, VAL, val, vdev->timeout.mmu_reg);
 }
 
 static int ivpu_mmu_evtq_enable(struct ivpu_device *vdev)
-- 
2.43.0

