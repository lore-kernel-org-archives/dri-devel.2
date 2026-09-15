Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 292AEC88E73
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 08:37:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B80410EF49;
	Tue, 15 Sep 2026 08:37:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="joTygq+v";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B269010EF49
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 08:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789461422; x=1820997422;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=xDqG+EJeeUarKjVFHq1HJ0VuYpXdNwhA2TIW7GQqXf0=;
 b=joTygq+vuookKmjj+2/leslidbJwSFXtA3nje5gM2N85gZOlSIB/dpF8
 s/ZUCh9oo2Xltb4E6adk7j/06hNLNIZA1ShdFebPCZSviVcr7i9UBy8Rp
 tZ13iGWMoPGLL9j1GDF1lEzI+6VA8owQKxkBUtta4f25VJV3TJIyteorC
 5NMEE+Z907S+KhugnRzgpYDcW0JVCVdJaMUZSqwkwANQhbhwpOejGhbHj
 OhbMn+ktdQnS8BnP5vdy8+mRCXwVcwTm+uJKo0a4mppZ5sGrr3d8svTeZ
 yWFW34ewzn0SFbraEwUaxsBta4ClCg1NZV34jkhvb2NSbLaoI0WNNFt3i w==;
X-CSE-ConnectionGUID: U62hYBJFTnCdWzcPQmJb5Q==
X-CSE-MsgGUID: 6+d0kHM2TpGh98KAUcRxQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="101335327"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="101335327"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2026 01:37:01 -0700
X-CSE-ConnectionGUID: 7zF8/wlhQJCzR1y2kSTkjA==
X-CSE-MsgGUID: K5nsmn4IQPa0nSxOVsejKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="278177066"
Received: from pl-npu-pc-kwachow.igk.intel.com ([10.91.220.239])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2026 01:36:59 -0700
From: Karol Wachowski <karol.wachowski@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, jeff.hugo@oss.qualcomm.com, lizhi.hou@amd.com,
 andrzej.kacprowski@linux.intel.com, dawid.osuchowski@linux.intel.com,
 Tomasz Rusinowicz <tomasz.rusinowicz@intel.com>,
 Karol Wachowski <karol.wachowski@linux.intel.com>
Subject: [PATCH v3] accel/ivpu: Move register poll timeouts to vdev->timeout
Date: Tue, 15 Sep 2026 10:36:51 +0200
Message-ID: <20260915083651.950890-1-karol.wachowski@linux.intel.com>
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

Register poll timeouts are expressed in microseconds and are passed to
read_poll_timeout(), which disables a timeout when it is 0, unlike the
millisecond timeouts that are disabled with a negative value.

Also initialize state_dump_msg in the IVPU_TEST_MODE_DISABLE_TIMEOUTS
branch, which was missed when the field was added. Unlike the other
fields, it is a fixed delay passed to msleep() rather than a timeout, so
it has to keep a finite value. It is only reachable with this debug test
mode enabled, so there is no need for backporting.

Signed-off-by: Tomasz Rusinowicz <tomasz.rusinowicz@intel.com>
Signed-off-by: Karol Wachowski <karol.wachowski@linux.intel.com>
---
Changes in v3:
 - Address Sashiko AI review comment: disable the microsecond register
   poll timeouts with 0 instead of -1. read_poll_timeout() treats 0 as
   "never timeout", while -1 is converted to 0xffffffff and results in
   a finite ~71.6 minute timeout
   Review: https://sashiko.dev/#/patchset/20260914082649.891871-1-karol.wachowski@linux.intel.com?part=1
 - Initialize state_dump_msg in the IVPU_TEST_MODE_DISABLE_TIMEOUTS
   branch, it is a fixed msleep() delay and has to remain finite
 - Explain the timeout semantics in the commit message
 - Link to v2: https://lore.kernel.org/dri-devel/20260914084503.895042-1-karol.wachowski@linux.intel.com/T/#u

Changes in v2:
 - Add Signed-off-by: Karol Wachowski
 - Link to v1: https://lore.kernel.org/dri-devel/20260914082649.891871-1-karol.wachowski@linux.intel.com/T/#u
---
 drivers/accel/ivpu/ivpu_drv.h   |  3 +++
 drivers/accel/ivpu/ivpu_hw.c    | 22 ++++++++++++++++++++++
 drivers/accel/ivpu/ivpu_hw_ip.c |  6 ++----
 drivers/accel/ivpu/ivpu_mmu.c   | 12 ++++--------
 4 files changed, 31 insertions(+), 12 deletions(-)

diff --git a/drivers/accel/ivpu/ivpu_drv.h b/drivers/accel/ivpu/ivpu_drv.h
index 37d5a6ac55f8..8762b8969d96 100644
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
index 647dc045c231..47ed9beeb3fb 100644
--- a/drivers/accel/ivpu/ivpu_hw.c
+++ b/drivers/accel/ivpu/ivpu_hw.c
@@ -99,13 +99,21 @@ static void wa_init(struct ivpu_device *vdev)
 static void timeouts_init(struct ivpu_device *vdev)
 {
 	if (ivpu_test_mode & IVPU_TEST_MODE_DISABLE_TIMEOUTS) {
+		/* in milliseconds, negative value disables the timeout */
 		vdev->timeout.boot = -1;
 		vdev->timeout.jsm = -1;
 		vdev->timeout.tdr = -1;
 		vdev->timeout.inference = -1;
 		vdev->timeout.autosuspend = -1;
 		vdev->timeout.d0i3_entry_msg = -1;
+		/* fixed delay, not a timeout - has to remain finite */
+		vdev->timeout.state_dump_msg = 100;
+		/* in microseconds, zero disables the timeout */
+		vdev->timeout.mmu_reg = 0;
+		vdev->timeout.mmu_queue = 0;
+		vdev->timeout.pwr_island_status = 0;
 	} else if (ivpu_is_fpga(vdev)) {
+		/* in milliseconds */
 		vdev->timeout.boot = 50;
 		vdev->timeout.jsm = 15000;
 		vdev->timeout.tdr = 30000;
@@ -113,7 +121,12 @@ static void timeouts_init(struct ivpu_device *vdev)
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
@@ -121,7 +134,12 @@ static void timeouts_init(struct ivpu_device *vdev)
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
@@ -132,6 +150,10 @@ static void timeouts_init(struct ivpu_device *vdev)
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
index b2025274f91d..c846499d96ce 100644
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

