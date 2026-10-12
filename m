Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CF9ACA9ED0
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 08:38:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 863D610EF4B;
	Mon, 12 Oct 2026 08:38:20 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 939B010EF4B
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 08:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791794294; x=1823330294;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=iECh7+Ekp2Iz7xWUYhKWcwKYUIfKFturSHBeCFK5bMg=;
 b=DVhzanP2LYIb7g8dKQemFJLOBSYHVVQZWPsqiwsMRVGTmDXpgnoJsAtF
 EFbvm4CGZNG7hLA+ppVE6UOyYlDNYNOvc0/zN77gFrZ+CVjX/he5DwAfQ
 /9YBM+6fl7vzODTe6EVZEXKD8hzrG1AiwPOvZbcY99+Dx45/LEXkZCrXj
 hS9dBk5Hu/GxWpV+M6yp1eyXgdKrMGpE4oeJQHC4w53MRoyRtJKS/9GrS
 3OFwCjCelqbxIFZn1TQn80sO1hKr9rPBiLcKGMdR2ueO5KOvzTYSe3v2V
 7FqOyrO/E/Ohsm+v1t3RN64+RvNJi9v0bDhY+o4shJ3jSXyeMnJueptJT Q==;
X-CSE-ConnectionGUID: asItFyeBTMq3IDOVvOsI7w==
X-CSE-MsgGUID: zXMWgLiRRGyybBDZkzA/bw==
X-IronPort-AV: E=McAfee;i="6800,10657,11932"; a="501018"
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="501018"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2026 01:38:14 -0700
X-CSE-ConnectionGUID: WUQONy1TR/+kP52LVGfw6g==
X-CSE-MsgGUID: b3oqsRUvRpibs9wKx8Yspg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="1030728"
Received: from pl-npu-pc-kwachow.igk.intel.com ([10.91.220.239])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2026 01:38:13 -0700
From: Karol Wachowski <karol.wachowski@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, jeff.hugo@oss.qualcomm.com, lizhi.hou@amd.com,
 andrzej.kacprowski@linux.intel.com, dawid.osuchowski@linux.intel.com,
 Karol Wachowski <karol.wachowski@linux.intel.com>
Subject: [PATCH 3/5] accel/ivpu: Merge identical 37xx and 40xx IP functions
Date: Mon, 12 Oct 2026 10:38:00 +0200
Message-ID: <20261012083802.2778448-4-karol.wachowski@linux.intel.com>
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

With a single register header, many 37xx and 40xx functions became
identical, including the IRQ handler. Keep one copy of each and call
the IRQ handler directly instead of through a function pointer.

No functional change.

Signed-off-by: Karol Wachowski <karol.wachowski@linux.intel.com>
---
 drivers/accel/ivpu/ivpu_hw.c    |   5 -
 drivers/accel/ivpu/ivpu_hw.h    |   6 -
 drivers/accel/ivpu/ivpu_hw_ip.c | 353 +++++---------------------------
 drivers/accel/ivpu/ivpu_hw_ip.h |   3 +-
 4 files changed, 49 insertions(+), 318 deletions(-)

diff --git a/drivers/accel/ivpu/ivpu_hw.c b/drivers/accel/ivpu/ivpu_hw.c
index 8b63140e3160..86679d64fc14 100644
--- a/drivers/accel/ivpu/ivpu_hw.c
+++ b/drivers/accel/ivpu/ivpu_hw.c
@@ -374,11 +374,6 @@ void ivpu_hw_profiling_freq_drive(struct ivpu_device *vdev, bool enable)
 
 void ivpu_irq_handlers_init(struct ivpu_device *vdev)
 {
-	if (ivpu_hw_ip_gen(vdev) == IVPU_HW_IP_37XX)
-		vdev->hw->irq.ip_irq_handler = ivpu_hw_ip_irq_handler_37xx;
-	else
-		vdev->hw->irq.ip_irq_handler = ivpu_hw_ip_irq_handler_40xx;
-
 	if (ivpu_hw_btrs_gen(vdev) == IVPU_HW_BTRS_MTL)
 		vdev->hw->irq.btrs_irq_handler = ivpu_hw_btrs_irq_handler_mtl;
 	else
diff --git a/drivers/accel/ivpu/ivpu_hw.h b/drivers/accel/ivpu/ivpu_hw.h
index d3c9ffe6a4b9..8c1b61df6cd4 100644
--- a/drivers/accel/ivpu/ivpu_hw.h
+++ b/drivers/accel/ivpu/ivpu_hw.h
@@ -18,7 +18,6 @@ struct ivpu_addr_range {
 struct ivpu_hw_info {
 	struct {
 		bool (*btrs_irq_handler)(struct ivpu_device *vdev, int irq);
-		bool (*ip_irq_handler)(struct ivpu_device *vdev, int irq);
 	} irq;
 	struct {
 		struct ivpu_addr_range runtime;
@@ -74,11 +73,6 @@ static inline u32 ivpu_hw_btrs_irq_handler(struct ivpu_device *vdev, int irq)
 	return vdev->hw->irq.btrs_irq_handler(vdev, irq);
 }
 
-static inline u32 ivpu_hw_ip_irq_handler(struct ivpu_device *vdev, int irq)
-{
-	return vdev->hw->irq.ip_irq_handler(vdev, irq);
-}
-
 static inline u64 ivpu_hw_range_size(const struct ivpu_addr_range *range)
 {
 	return range->end - range->start;
diff --git a/drivers/accel/ivpu/ivpu_hw_ip.c b/drivers/accel/ivpu/ivpu_hw_ip.c
index 55931d896e45..47f4f9e17d8a 100644
--- a/drivers/accel/ivpu/ivpu_hw_ip.c
+++ b/drivers/accel/ivpu/ivpu_hw_ip.c
@@ -17,49 +17,27 @@
 #define TIM_SAFE_ENABLE		            0xf1d0dead
 #define TIM_WATCHDOG_RESET_VALUE            0xffffffff
 
-#define ICB_0_IRQ_MASK_37XX ((REG_FLD(VPU_37XX_HOST_SS_ICB_STATUS_0, HOST_IPC_FIFO_INT)) | \
-			     (REG_FLD(VPU_37XX_HOST_SS_ICB_STATUS_0, MMU_IRQ_0_INT)) | \
-			     (REG_FLD(VPU_37XX_HOST_SS_ICB_STATUS_0, MMU_IRQ_1_INT)) | \
-			     (REG_FLD(VPU_37XX_HOST_SS_ICB_STATUS_0, MMU_IRQ_2_INT)) | \
-			     (REG_FLD(VPU_37XX_HOST_SS_ICB_STATUS_0, NOC_FIREWALL_INT)) | \
-			     (REG_FLD(VPU_37XX_HOST_SS_ICB_STATUS_0, CPU_INT_REDIRECT_0_INT)) | \
-			     (REG_FLD(VPU_37XX_HOST_SS_ICB_STATUS_0, CPU_INT_REDIRECT_1_INT)))
-
-#define ICB_1_IRQ_MASK_37XX ((REG_FLD(VPU_37XX_HOST_SS_ICB_STATUS_1, CPU_INT_REDIRECT_2_INT)) | \
-			     (REG_FLD(VPU_37XX_HOST_SS_ICB_STATUS_1, CPU_INT_REDIRECT_3_INT)) | \
-			     (REG_FLD(VPU_37XX_HOST_SS_ICB_STATUS_1, CPU_INT_REDIRECT_4_INT)))
-
-#define ICB_0_1_IRQ_MASK_37XX ((((u64)ICB_1_IRQ_MASK_37XX) << 32) | ICB_0_IRQ_MASK_37XX)
-
-#define ICB_0_IRQ_MASK_40XX ((REG_FLD(VPU_37XX_HOST_SS_ICB_STATUS_0, HOST_IPC_FIFO_INT)) | \
-			     (REG_FLD(VPU_37XX_HOST_SS_ICB_STATUS_0, MMU_IRQ_0_INT)) | \
-			     (REG_FLD(VPU_37XX_HOST_SS_ICB_STATUS_0, MMU_IRQ_1_INT)) | \
-			     (REG_FLD(VPU_37XX_HOST_SS_ICB_STATUS_0, MMU_IRQ_2_INT)) | \
-			     (REG_FLD(VPU_37XX_HOST_SS_ICB_STATUS_0, NOC_FIREWALL_INT)) | \
-			     (REG_FLD(VPU_37XX_HOST_SS_ICB_STATUS_0, CPU_INT_REDIRECT_0_INT)) | \
-			     (REG_FLD(VPU_37XX_HOST_SS_ICB_STATUS_0, CPU_INT_REDIRECT_1_INT)))
-
-#define ICB_1_IRQ_MASK_40XX ((REG_FLD(VPU_37XX_HOST_SS_ICB_STATUS_1, CPU_INT_REDIRECT_2_INT)) | \
-			     (REG_FLD(VPU_37XX_HOST_SS_ICB_STATUS_1, CPU_INT_REDIRECT_3_INT)) | \
-			     (REG_FLD(VPU_37XX_HOST_SS_ICB_STATUS_1, CPU_INT_REDIRECT_4_INT)))
-
-#define ICB_0_1_IRQ_MASK_40XX ((((u64)ICB_1_IRQ_MASK_40XX) << 32) | ICB_0_IRQ_MASK_40XX)
-
-#define ITF_FIREWALL_VIOLATION_MASK_37XX ((REG_FLD(VPU_37XX_HOST_SS_FW_SOC_IRQ_EN, CSS_ROM_CMX)) | \
-					  (REG_FLD(VPU_37XX_HOST_SS_FW_SOC_IRQ_EN, CSS_DBG)) | \
-					  (REG_FLD(VPU_37XX_HOST_SS_FW_SOC_IRQ_EN, CSS_CTRL)) | \
-					  (REG_FLD(VPU_37XX_HOST_SS_FW_SOC_IRQ_EN, DEC400)) | \
-					  (REG_FLD(VPU_37XX_HOST_SS_FW_SOC_IRQ_EN, MSS_NCE)) | \
-					  (REG_FLD(VPU_37XX_HOST_SS_FW_SOC_IRQ_EN, MSS_MBI)) | \
-					  (REG_FLD(VPU_37XX_HOST_SS_FW_SOC_IRQ_EN, MSS_MBI_CMX)))
-
-#define ITF_FIREWALL_VIOLATION_MASK_40XX ((REG_FLD(VPU_37XX_HOST_SS_FW_SOC_IRQ_EN, CSS_ROM_CMX)) | \
-					  (REG_FLD(VPU_37XX_HOST_SS_FW_SOC_IRQ_EN, CSS_DBG)) | \
-					  (REG_FLD(VPU_37XX_HOST_SS_FW_SOC_IRQ_EN, CSS_CTRL)) | \
-					  (REG_FLD(VPU_37XX_HOST_SS_FW_SOC_IRQ_EN, DEC400)) | \
-					  (REG_FLD(VPU_37XX_HOST_SS_FW_SOC_IRQ_EN, MSS_NCE)) | \
-					  (REG_FLD(VPU_37XX_HOST_SS_FW_SOC_IRQ_EN, MSS_MBI)) | \
-					  (REG_FLD(VPU_37XX_HOST_SS_FW_SOC_IRQ_EN, MSS_MBI_CMX)))
+#define ICB_0_IRQ_MASK ((REG_FLD(VPU_37XX_HOST_SS_ICB_STATUS_0, HOST_IPC_FIFO_INT)) | \
+			(REG_FLD(VPU_37XX_HOST_SS_ICB_STATUS_0, MMU_IRQ_0_INT)) | \
+			(REG_FLD(VPU_37XX_HOST_SS_ICB_STATUS_0, MMU_IRQ_1_INT)) | \
+			(REG_FLD(VPU_37XX_HOST_SS_ICB_STATUS_0, MMU_IRQ_2_INT)) | \
+			(REG_FLD(VPU_37XX_HOST_SS_ICB_STATUS_0, NOC_FIREWALL_INT)) | \
+			(REG_FLD(VPU_37XX_HOST_SS_ICB_STATUS_0, CPU_INT_REDIRECT_0_INT)) | \
+			(REG_FLD(VPU_37XX_HOST_SS_ICB_STATUS_0, CPU_INT_REDIRECT_1_INT)))
+
+#define ICB_1_IRQ_MASK ((REG_FLD(VPU_37XX_HOST_SS_ICB_STATUS_1, CPU_INT_REDIRECT_2_INT)) | \
+			(REG_FLD(VPU_37XX_HOST_SS_ICB_STATUS_1, CPU_INT_REDIRECT_3_INT)) | \
+			(REG_FLD(VPU_37XX_HOST_SS_ICB_STATUS_1, CPU_INT_REDIRECT_4_INT)))
+
+#define ICB_0_1_IRQ_MASK ((((u64)ICB_1_IRQ_MASK) << 32) | ICB_0_IRQ_MASK)
+
+#define ITF_FIREWALL_VIOLATION_MASK ((REG_FLD(VPU_37XX_HOST_SS_FW_SOC_IRQ_EN, CSS_ROM_CMX)) | \
+				     (REG_FLD(VPU_37XX_HOST_SS_FW_SOC_IRQ_EN, CSS_DBG)) | \
+				     (REG_FLD(VPU_37XX_HOST_SS_FW_SOC_IRQ_EN, CSS_CTRL)) | \
+				     (REG_FLD(VPU_37XX_HOST_SS_FW_SOC_IRQ_EN, DEC400)) | \
+				     (REG_FLD(VPU_37XX_HOST_SS_FW_SOC_IRQ_EN, MSS_NCE)) | \
+				     (REG_FLD(VPU_37XX_HOST_SS_FW_SOC_IRQ_EN, MSS_MBI)) | \
+				     (REG_FLD(VPU_37XX_HOST_SS_FW_SOC_IRQ_EN, MSS_MBI_CMX)))
 
 static int wait_for_ip_bar(struct ivpu_device *vdev)
 {
@@ -77,17 +55,7 @@ static void host_ss_rst_clr(struct ivpu_device *vdev)
 	REGV_WR32(VPU_37XX_HOST_SS_CPR_RST_CLR, val);
 }
 
-static int host_ss_noc_qreqn_check_37xx(struct ivpu_device *vdev, u32 exp_val)
-{
-	u32 val = REGV_RD32(VPU_37XX_HOST_SS_NOC_QREQN);
-
-	if (!REG_TEST_FLD_NUM(VPU_37XX_HOST_SS_NOC_QREQN, TOP_SOCMMIO, exp_val, val))
-		return -EIO;
-
-	return 0;
-}
-
-static int host_ss_noc_qreqn_check_40xx(struct ivpu_device *vdev, u32 exp_val)
+static int host_ss_noc_qreqn_check(struct ivpu_device *vdev, u32 exp_val)
 {
 	u32 val = REGV_RD32(VPU_37XX_HOST_SS_NOC_QREQN);
 
@@ -97,25 +65,7 @@ static int host_ss_noc_qreqn_check_40xx(struct ivpu_device *vdev, u32 exp_val)
 	return 0;
 }
 
-static int host_ss_noc_qreqn_check(struct ivpu_device *vdev, u32 exp_val)
-{
-	if (ivpu_hw_ip_gen(vdev) == IVPU_HW_IP_37XX)
-		return host_ss_noc_qreqn_check_37xx(vdev, exp_val);
-	else
-		return host_ss_noc_qreqn_check_40xx(vdev, exp_val);
-}
-
-static int host_ss_noc_qacceptn_check_37xx(struct ivpu_device *vdev, u32 exp_val)
-{
-	u32 val = REGV_RD32(VPU_37XX_HOST_SS_NOC_QACCEPTN);
-
-	if (!REG_TEST_FLD_NUM(VPU_37XX_HOST_SS_NOC_QACCEPTN, TOP_SOCMMIO, exp_val, val))
-		return -EIO;
-
-	return 0;
-}
-
-static int host_ss_noc_qacceptn_check_40xx(struct ivpu_device *vdev, u32 exp_val)
+static int host_ss_noc_qacceptn_check(struct ivpu_device *vdev, u32 exp_val)
 {
 	u32 val = REGV_RD32(VPU_37XX_HOST_SS_NOC_QACCEPTN);
 
@@ -125,25 +75,7 @@ static int host_ss_noc_qacceptn_check_40xx(struct ivpu_device *vdev, u32 exp_val
 	return 0;
 }
 
-static int host_ss_noc_qacceptn_check(struct ivpu_device *vdev, u32 exp_val)
-{
-	if (ivpu_hw_ip_gen(vdev) == IVPU_HW_IP_37XX)
-		return host_ss_noc_qacceptn_check_37xx(vdev, exp_val);
-	else
-		return host_ss_noc_qacceptn_check_40xx(vdev, exp_val);
-}
-
-static int host_ss_noc_qdeny_check_37xx(struct ivpu_device *vdev, u32 exp_val)
-{
-	u32 val = REGV_RD32(VPU_37XX_HOST_SS_NOC_QDENY);
-
-	if (!REG_TEST_FLD_NUM(VPU_37XX_HOST_SS_NOC_QDENY, TOP_SOCMMIO, exp_val, val))
-		return -EIO;
-
-	return 0;
-}
-
-static int host_ss_noc_qdeny_check_40xx(struct ivpu_device *vdev, u32 exp_val)
+static int host_ss_noc_qdeny_check(struct ivpu_device *vdev, u32 exp_val)
 {
 	u32 val = REGV_RD32(VPU_37XX_HOST_SS_NOC_QDENY);
 
@@ -153,14 +85,6 @@ static int host_ss_noc_qdeny_check_40xx(struct ivpu_device *vdev, u32 exp_val)
 	return 0;
 }
 
-static int host_ss_noc_qdeny_check(struct ivpu_device *vdev, u32 exp_val)
-{
-	if (ivpu_hw_ip_gen(vdev) == IVPU_HW_IP_37XX)
-		return host_ss_noc_qdeny_check_37xx(vdev, exp_val);
-	else
-		return host_ss_noc_qdeny_check_40xx(vdev, exp_val);
-}
-
 static int top_noc_qrenqn_check_37xx(struct ivpu_device *vdev, u32 exp_val)
 {
 	u32 val = REGV_RD32(VPU_37XX_TOP_NOC_QREQN);
@@ -223,19 +147,7 @@ int ivpu_hw_ip_host_ss_configure(struct ivpu_device *vdev)
 	return ret;
 }
 
-static void idle_gen_drive_37xx(struct ivpu_device *vdev, bool enable)
-{
-	u32 val = REGV_RD32(VPU_37XX_HOST_SS_AON_VPU_IDLE_GEN);
-
-	if (enable)
-		val = REG_SET_FLD(VPU_37XX_HOST_SS_AON_VPU_IDLE_GEN, EN, val);
-	else
-		val = REG_CLR_FLD(VPU_37XX_HOST_SS_AON_VPU_IDLE_GEN, EN, val);
-
-	REGV_WR32(VPU_37XX_HOST_SS_AON_VPU_IDLE_GEN, val);
-}
-
-static void idle_gen_drive_40xx(struct ivpu_device *vdev, bool enable)
+static void idle_gen_drive(struct ivpu_device *vdev, bool enable)
 {
 	u32 val = REGV_RD32(VPU_37XX_HOST_SS_AON_VPU_IDLE_GEN);
 
@@ -249,18 +161,12 @@ static void idle_gen_drive_40xx(struct ivpu_device *vdev, bool enable)
 
 void ivpu_hw_ip_idle_gen_enable(struct ivpu_device *vdev)
 {
-	if (ivpu_hw_ip_gen(vdev) == IVPU_HW_IP_37XX)
-		idle_gen_drive_37xx(vdev, true);
-	else
-		idle_gen_drive_40xx(vdev, true);
+	idle_gen_drive(vdev, true);
 }
 
 void ivpu_hw_ip_idle_gen_disable(struct ivpu_device *vdev)
 {
-	if (ivpu_hw_ip_gen(vdev) == IVPU_HW_IP_37XX)
-		idle_gen_drive_37xx(vdev, false);
-	else
-		idle_gen_drive_40xx(vdev, false);
+	idle_gen_drive(vdev, false);
 }
 
 static void
@@ -293,7 +199,7 @@ static void pwr_island_delay_set_60xx(struct ivpu_device *vdev)
 		pwr_island_delay_write(vdev, 17, 0, 17, 0);
 }
 
-static void pwr_island_trickle_drive_37xx(struct ivpu_device *vdev, bool enable)
+static void pwr_island_trickle_drive(struct ivpu_device *vdev, bool enable)
 {
 	u32 val = REGV_RD32(VPU_37XX_HOST_SS_AON_PWR_ISLAND_TRICKLE_EN0);
 
@@ -305,31 +211,7 @@ static void pwr_island_trickle_drive_37xx(struct ivpu_device *vdev, bool enable)
 	REGV_WR32(VPU_37XX_HOST_SS_AON_PWR_ISLAND_TRICKLE_EN0, val);
 }
 
-static void pwr_island_trickle_drive_40xx(struct ivpu_device *vdev, bool enable)
-{
-	u32 val = REGV_RD32(VPU_37XX_HOST_SS_AON_PWR_ISLAND_TRICKLE_EN0);
-
-	if (enable)
-		val = REG_SET_FLD(VPU_37XX_HOST_SS_AON_PWR_ISLAND_TRICKLE_EN0, MSS_CPU, val);
-	else
-		val = REG_CLR_FLD(VPU_37XX_HOST_SS_AON_PWR_ISLAND_TRICKLE_EN0, MSS_CPU, val);
-
-	REGV_WR32(VPU_37XX_HOST_SS_AON_PWR_ISLAND_TRICKLE_EN0, val);
-}
-
-static void pwr_island_drive_37xx(struct ivpu_device *vdev, bool enable)
-{
-	u32 val = REGV_RD32(VPU_37XX_HOST_SS_AON_PWR_ISLAND_EN0);
-
-	if (enable)
-		val = REG_SET_FLD(VPU_37XX_HOST_SS_AON_PWR_ISLAND_EN0, MSS_CPU, val);
-	else
-		val = REG_CLR_FLD(VPU_37XX_HOST_SS_AON_PWR_ISLAND_EN0, MSS_CPU, val);
-
-	REGV_WR32(VPU_37XX_HOST_SS_AON_PWR_ISLAND_EN0, val);
-}
-
-static void pwr_island_drive_40xx(struct ivpu_device *vdev, bool enable)
+static void pwr_island_drive(struct ivpu_device *vdev, bool enable)
 {
 	u32 val = REGV_RD32(VPU_37XX_HOST_SS_AON_PWR_ISLAND_EN0);
 
@@ -343,15 +225,9 @@ static void pwr_island_drive_40xx(struct ivpu_device *vdev, bool enable)
 
 static void pwr_island_enable(struct ivpu_device *vdev)
 {
-	if (ivpu_hw_ip_gen(vdev) == IVPU_HW_IP_37XX) {
-		pwr_island_trickle_drive_37xx(vdev, true);
-		ndelay(500);
-		pwr_island_drive_37xx(vdev, true);
-	} else {
-		pwr_island_trickle_drive_40xx(vdev, true);
-		ndelay(500);
-		pwr_island_drive_40xx(vdev, true);
-	}
+	pwr_island_trickle_drive(vdev, true);
+	ndelay(500);
+	pwr_island_drive(vdev, true);
 }
 
 static int wait_for_pwr_island_status(struct ivpu_device *vdev, u32 exp_val)
@@ -359,27 +235,11 @@ static int wait_for_pwr_island_status(struct ivpu_device *vdev, u32 exp_val)
 	if (IVPU_WA(punit_disabled))
 		return 0;
 
-	if (ivpu_hw_ip_gen(vdev) == IVPU_HW_IP_37XX)
-		return REGV_POLL_FLD(VPU_37XX_HOST_SS_AON_PWR_ISLAND_STATUS0, MSS_CPU, exp_val,
-				     vdev->timeout.pwr_island_status);
-	else
-		return REGV_POLL_FLD(VPU_37XX_HOST_SS_AON_PWR_ISLAND_STATUS0, MSS_CPU, exp_val,
-				     vdev->timeout.pwr_island_status);
-}
-
-static void pwr_island_isolation_drive_37xx(struct ivpu_device *vdev, bool enable)
-{
-	u32 val = REGV_RD32(VPU_37XX_HOST_SS_AON_PWR_ISO_EN0);
-
-	if (enable)
-		val = REG_SET_FLD(VPU_37XX_HOST_SS_AON_PWR_ISO_EN0, MSS_CPU, val);
-	else
-		val = REG_CLR_FLD(VPU_37XX_HOST_SS_AON_PWR_ISO_EN0, MSS_CPU, val);
-
-	REGV_WR32(VPU_37XX_HOST_SS_AON_PWR_ISO_EN0, val);
+	return REGV_POLL_FLD(VPU_37XX_HOST_SS_AON_PWR_ISLAND_STATUS0, MSS_CPU, exp_val,
+			     vdev->timeout.pwr_island_status);
 }
 
-static void pwr_island_isolation_drive_40xx(struct ivpu_device *vdev, bool enable)
+static void pwr_island_isolation_drive(struct ivpu_device *vdev, bool enable)
 {
 	u32 val = REGV_RD32(VPU_37XX_HOST_SS_AON_PWR_ISO_EN0);
 
@@ -391,14 +251,6 @@ static void pwr_island_isolation_drive_40xx(struct ivpu_device *vdev, bool enabl
 	REGV_WR32(VPU_37XX_HOST_SS_AON_PWR_ISO_EN0, val);
 }
 
-static void pwr_island_isolation_drive(struct ivpu_device *vdev, bool enable)
-{
-	if (ivpu_hw_ip_gen(vdev) == IVPU_HW_IP_37XX)
-		pwr_island_isolation_drive_37xx(vdev, enable);
-	else
-		pwr_island_isolation_drive_40xx(vdev, enable);
-}
-
 static void pwr_island_isolation_disable(struct ivpu_device *vdev)
 {
 	pwr_island_isolation_drive(vdev, false);
@@ -498,18 +350,7 @@ static void host_ss_rst_enable(struct ivpu_device *vdev)
 	host_ss_rst_drive(vdev, true);
 }
 
-static void host_ss_noc_qreqn_top_socmmio_drive_37xx(struct ivpu_device *vdev, bool enable)
-{
-	u32 val = REGV_RD32(VPU_37XX_HOST_SS_NOC_QREQN);
-
-	if (enable)
-		val = REG_SET_FLD(VPU_37XX_HOST_SS_NOC_QREQN, TOP_SOCMMIO, val);
-	else
-		val = REG_CLR_FLD(VPU_37XX_HOST_SS_NOC_QREQN, TOP_SOCMMIO, val);
-	REGV_WR32(VPU_37XX_HOST_SS_NOC_QREQN, val);
-}
-
-static void host_ss_noc_qreqn_top_socmmio_drive_40xx(struct ivpu_device *vdev, bool enable)
+static void host_ss_noc_qreqn_top_socmmio_drive(struct ivpu_device *vdev, bool enable)
 {
 	u32 val = REGV_RD32(VPU_37XX_HOST_SS_NOC_QREQN);
 
@@ -520,14 +361,6 @@ static void host_ss_noc_qreqn_top_socmmio_drive_40xx(struct ivpu_device *vdev, b
 	REGV_WR32(VPU_37XX_HOST_SS_NOC_QREQN, val);
 }
 
-static void host_ss_noc_qreqn_top_socmmio_drive(struct ivpu_device *vdev, bool enable)
-{
-	if (ivpu_hw_ip_gen(vdev) == IVPU_HW_IP_37XX)
-		host_ss_noc_qreqn_top_socmmio_drive_37xx(vdev, enable);
-	else
-		host_ss_noc_qreqn_top_socmmio_drive_40xx(vdev, enable);
-}
-
 static int host_ss_axi_drive(struct ivpu_device *vdev, bool enable)
 {
 	int ret;
@@ -997,72 +830,30 @@ void ivpu_hw_ip_wdt_disable(struct ivpu_device *vdev)
 		return wdt_disable_40xx(vdev);
 }
 
-static u32 ipc_rx_count_get_37xx(struct ivpu_device *vdev)
-{
-	u32 count = readl(vdev->regv + VPU_37XX_HOST_SS_TIM_IPC_FIFO_STAT);
-
-	return REG_GET_FLD(VPU_37XX_HOST_SS_TIM_IPC_FIFO_STAT, FILL_LEVEL, count);
-}
-
-static u32 ipc_rx_count_get_40xx(struct ivpu_device *vdev)
+u32 ivpu_hw_ip_ipc_rx_count_get(struct ivpu_device *vdev)
 {
 	u32 count = readl(vdev->regv + VPU_37XX_HOST_SS_TIM_IPC_FIFO_STAT);
 
 	return REG_GET_FLD(VPU_37XX_HOST_SS_TIM_IPC_FIFO_STAT, FILL_LEVEL, count);
 }
 
-u32 ivpu_hw_ip_ipc_rx_count_get(struct ivpu_device *vdev)
-{
-	if (ivpu_hw_ip_gen(vdev) == IVPU_HW_IP_37XX)
-		return ipc_rx_count_get_37xx(vdev);
-	else
-		return ipc_rx_count_get_40xx(vdev);
-}
-
 void ivpu_hw_ip_irq_enable(struct ivpu_device *vdev)
 {
-	if (ivpu_hw_ip_gen(vdev) == IVPU_HW_IP_37XX) {
-		REGV_WR32(VPU_37XX_HOST_SS_FW_SOC_IRQ_EN, ITF_FIREWALL_VIOLATION_MASK_37XX);
-		REGV_WR64(VPU_37XX_HOST_SS_ICB_ENABLE_0, ICB_0_1_IRQ_MASK_37XX);
-	} else {
-		REGV_WR32(VPU_37XX_HOST_SS_FW_SOC_IRQ_EN, ITF_FIREWALL_VIOLATION_MASK_40XX);
-		REGV_WR64(VPU_37XX_HOST_SS_ICB_ENABLE_0, ICB_0_1_IRQ_MASK_40XX);
-	}
+	REGV_WR32(VPU_37XX_HOST_SS_FW_SOC_IRQ_EN, ITF_FIREWALL_VIOLATION_MASK);
+	REGV_WR64(VPU_37XX_HOST_SS_ICB_ENABLE_0, ICB_0_1_IRQ_MASK);
 }
 
 void ivpu_hw_ip_irq_disable(struct ivpu_device *vdev)
 {
-	if (ivpu_hw_ip_gen(vdev) == IVPU_HW_IP_37XX) {
-		REGV_WR64(VPU_37XX_HOST_SS_ICB_ENABLE_0, 0x0ull);
-		REGV_WR32(VPU_37XX_HOST_SS_FW_SOC_IRQ_EN, 0x0);
-	} else {
-		REGV_WR64(VPU_37XX_HOST_SS_ICB_ENABLE_0, 0x0ull);
-		REGV_WR32(VPU_37XX_HOST_SS_FW_SOC_IRQ_EN, 0x0ul);
-	}
-}
-
-static void diagnose_failure_37xx(struct ivpu_device *vdev)
-{
-	u32 reg = REGV_RD32(VPU_37XX_HOST_SS_ICB_STATUS_0) & ICB_0_IRQ_MASK_37XX;
-
-	if (ipc_rx_count_get_37xx(vdev))
-		ivpu_err(vdev, "IPC FIFO queue not empty, missed IPC IRQ");
-
-	if (REG_TEST_FLD(VPU_37XX_HOST_SS_ICB_STATUS_0, CPU_INT_REDIRECT_0_INT, reg))
-		ivpu_err(vdev, "WDT MSS timeout detected\n");
-
-	if (REG_TEST_FLD(VPU_37XX_HOST_SS_ICB_STATUS_0, CPU_INT_REDIRECT_1_INT, reg))
-		ivpu_err(vdev, "WDT NCE timeout detected\n");
-
-	if (REG_TEST_FLD(VPU_37XX_HOST_SS_ICB_STATUS_0, NOC_FIREWALL_INT, reg))
-		ivpu_err(vdev, "NOC Firewall irq detected\n");
+	REGV_WR64(VPU_37XX_HOST_SS_ICB_ENABLE_0, 0x0ull);
+	REGV_WR32(VPU_37XX_HOST_SS_FW_SOC_IRQ_EN, 0x0);
 }
 
-static void diagnose_failure_40xx(struct ivpu_device *vdev)
+void ivpu_hw_ip_diagnose_failure(struct ivpu_device *vdev)
 {
-	u32 reg = REGV_RD32(VPU_37XX_HOST_SS_ICB_STATUS_0) & ICB_0_IRQ_MASK_40XX;
+	u32 reg = REGV_RD32(VPU_37XX_HOST_SS_ICB_STATUS_0) & ICB_0_IRQ_MASK;
 
-	if (ipc_rx_count_get_40xx(vdev))
+	if (ivpu_hw_ip_ipc_rx_count_get(vdev))
 		ivpu_err(vdev, "IPC FIFO queue not empty, missed IPC IRQ");
 
 	if (REG_TEST_FLD(VPU_37XX_HOST_SS_ICB_STATUS_0, CPU_INT_REDIRECT_0_INT, reg))
@@ -1075,20 +866,9 @@ static void diagnose_failure_40xx(struct ivpu_device *vdev)
 		ivpu_err(vdev, "NOC Firewall irq detected\n");
 }
 
-void ivpu_hw_ip_diagnose_failure(struct ivpu_device *vdev)
-{
-	if (ivpu_hw_ip_gen(vdev) == IVPU_HW_IP_37XX)
-		diagnose_failure_37xx(vdev);
-	else
-		diagnose_failure_40xx(vdev);
-}
-
 void ivpu_hw_ip_irq_clear(struct ivpu_device *vdev)
 {
-	if (ivpu_hw_ip_gen(vdev) == IVPU_HW_IP_37XX)
-		REGV_WR64(VPU_37XX_HOST_SS_ICB_CLEAR_0, ICB_0_1_IRQ_MASK_37XX);
-	else
-		REGV_WR64(VPU_37XX_HOST_SS_ICB_CLEAR_0, ICB_0_1_IRQ_MASK_40XX);
+	REGV_WR64(VPU_37XX_HOST_SS_ICB_CLEAR_0, ICB_0_1_IRQ_MASK);
 }
 
 static void irq_wdt_nce_handler(struct ivpu_device *vdev)
@@ -1111,43 +891,9 @@ static void irq_noc_firewall_handler(struct ivpu_device *vdev)
 }
 
 /* Handler for IRQs from NPU core */
-bool ivpu_hw_ip_irq_handler_37xx(struct ivpu_device *vdev, int irq)
-{
-	u32 status = REGV_RD32(VPU_37XX_HOST_SS_ICB_STATUS_0) & ICB_0_IRQ_MASK_37XX;
-
-	if (!status)
-		return false;
-
-	REGV_WR32(VPU_37XX_HOST_SS_ICB_CLEAR_0, status);
-
-	if (REG_TEST_FLD(VPU_37XX_HOST_SS_ICB_STATUS_0, MMU_IRQ_0_INT, status))
-		ivpu_mmu_irq_evtq_handler(vdev);
-
-	if (REG_TEST_FLD(VPU_37XX_HOST_SS_ICB_STATUS_0, HOST_IPC_FIFO_INT, status))
-		ivpu_ipc_irq_handler(vdev);
-
-	if (REG_TEST_FLD(VPU_37XX_HOST_SS_ICB_STATUS_0, MMU_IRQ_1_INT, status))
-		ivpu_dbg(vdev, IRQ, "MMU sync complete\n");
-
-	if (REG_TEST_FLD(VPU_37XX_HOST_SS_ICB_STATUS_0, MMU_IRQ_2_INT, status))
-		ivpu_mmu_irq_gerr_handler(vdev);
-
-	if (REG_TEST_FLD(VPU_37XX_HOST_SS_ICB_STATUS_0, CPU_INT_REDIRECT_0_INT, status))
-		irq_wdt_mss_handler(vdev);
-
-	if (REG_TEST_FLD(VPU_37XX_HOST_SS_ICB_STATUS_0, CPU_INT_REDIRECT_1_INT, status))
-		irq_wdt_nce_handler(vdev);
-
-	if (REG_TEST_FLD(VPU_37XX_HOST_SS_ICB_STATUS_0, NOC_FIREWALL_INT, status))
-		irq_noc_firewall_handler(vdev);
-
-	return true;
-}
-
-/* Handler for IRQs from NPU core */
-bool ivpu_hw_ip_irq_handler_40xx(struct ivpu_device *vdev, int irq)
+bool ivpu_hw_ip_irq_handler(struct ivpu_device *vdev, int irq)
 {
-	u32 status = REGV_RD32(VPU_37XX_HOST_SS_ICB_STATUS_0) & ICB_0_IRQ_MASK_40XX;
+	u32 status = REGV_RD32(VPU_37XX_HOST_SS_ICB_STATUS_0) & ICB_0_IRQ_MASK;
 
 	if (!status)
 		return false;
@@ -1204,10 +950,7 @@ void ivpu_hw_ip_db_set(struct ivpu_device *vdev, u32 db_id)
 
 u32 ivpu_hw_ip_ipc_rx_addr_get(struct ivpu_device *vdev)
 {
-	if (ivpu_hw_ip_gen(vdev) == IVPU_HW_IP_37XX)
-		return REGV_RD32(VPU_37XX_HOST_SS_TIM_IPC_FIFO_ATM);
-	else
-		return REGV_RD32(VPU_37XX_HOST_SS_TIM_IPC_FIFO_ATM);
+	return REGV_RD32(VPU_37XX_HOST_SS_TIM_IPC_FIFO_ATM);
 }
 
 void ivpu_hw_ip_ipc_tx_set(struct ivpu_device *vdev, u32 vpu_addr)
diff --git a/drivers/accel/ivpu/ivpu_hw_ip.h b/drivers/accel/ivpu/ivpu_hw_ip.h
index dbbcdd10a5f8..59ef904c08da 100644
--- a/drivers/accel/ivpu/ivpu_hw_ip.h
+++ b/drivers/accel/ivpu/ivpu_hw_ip.h
@@ -22,8 +22,7 @@ void ivpu_hw_ip_wdt_disable(struct ivpu_device *vdev);
 void ivpu_hw_ip_diagnose_failure(struct ivpu_device *vdev);
 u32 ivpu_hw_ip_ipc_rx_count_get(struct ivpu_device *vdev);
 void ivpu_hw_ip_irq_clear(struct ivpu_device *vdev);
-bool ivpu_hw_ip_irq_handler_37xx(struct ivpu_device *vdev, int irq);
-bool ivpu_hw_ip_irq_handler_40xx(struct ivpu_device *vdev, int irq);
+bool ivpu_hw_ip_irq_handler(struct ivpu_device *vdev, int irq);
 void ivpu_hw_ip_db_set(struct ivpu_device *vdev, u32 db_id);
 u32 ivpu_hw_ip_ipc_rx_addr_get(struct ivpu_device *vdev);
 void ivpu_hw_ip_ipc_tx_set(struct ivpu_device *vdev, u32 vpu_addr);
-- 
2.43.0

