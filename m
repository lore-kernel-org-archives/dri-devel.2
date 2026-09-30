Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34EF4CA5FCB
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 16:09:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 698F410E260;
	Wed, 30 Sep 2026 16:09:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="BEbZqx6B";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1EF110E260
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 16:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790784564; x=1822320564;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=QFQYSB3k0h6dyCGHgtUaEwyX8vhxUFEUvcuvHPSU3lU=;
 b=BEbZqx6Btiewswrf+oxAj6+AgXgIFcNi7i9iEez5WCnE2hHKs7gL87Ml
 gffpvW2GTV1F5SUWZzZQRZ3XSdm9ldvYwHTy/5ao2JoYUc7REn+YqKTkm
 kVekggXzc1DRU6Bc4+HtKC/MMZJ7EFWzQgJKpgG4PusTftg+aCOHGqpR8
 2FZlQV/bIms9VzNCe1Lo0LQTKbkxSmnVtH+guMzCrjmLz7hvX9TqT+gJh
 aQjo3PX2ZKQevnUDIRSZ9kiulN1sTYm7q3EGmOfLO/7WCxw+stb8TYfZ7
 lmh1I4A3nv82RpFNMPCi+4GpLS5mtzIt5DoaAVHBqOlOhoQIHLU/UgWND Q==;
X-CSE-ConnectionGUID: ug8nI7paRa2Ly6CGCeeBcA==
X-CSE-MsgGUID: lpVhJEFkSsewCF7ggvkBrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11921"; a="91543985"
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; d="scan'208";a="91543985"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2026 09:09:23 -0700
X-CSE-ConnectionGUID: WxkkFg0TSoSYNSRc9wO1ng==
X-CSE-MsgGUID: 6fEj8tvITM6lXXbcXOZ21w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; d="scan'208";a="274353617"
Received: from akacprow-dev3.igk.intel.com ([10.91.220.47])
 by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2026 09:09:22 -0700
From: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, jeff.hugo@oss.qualcomm.com,
 karol.wachowski@linux.intel.com, lizhi.hou@amd.com,
 dawid.osuchowski@linux.intel.com,
 Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
Subject: [PATCH] accel/ivpu: Drop MTL interrupt clear-with-zero workaround
Date: Wed, 30 Sep 2026 18:03:48 +0200
Message-ID: <20260930160348.1562800-1-andrzej.kacprowski@linux.intel.com>
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

Early MTL steppings needed a runtime check for BTRS interrupt status
registers that cleared by writing 0 instead of the usual write-1-to-clear
flow.

Those pre-production steppings are no longer supported. Remove the
workaround flag, probe helper, and conditional IRQ clear path, and always
clear handled MTL BTRS interrupt status bits by writing the interrupt
status value.

Signed-off-by: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
---
 drivers/accel/ivpu/ivpu_drv.h     |  1 -
 drivers/accel/ivpu/ivpu_hw.c      |  4 ----
 drivers/accel/ivpu/ivpu_hw_btrs.c | 24 +-----------------------
 drivers/accel/ivpu/ivpu_hw_btrs.h |  1 -
 4 files changed, 1 insertion(+), 29 deletions(-)

diff --git a/drivers/accel/ivpu/ivpu_drv.h b/drivers/accel/ivpu/ivpu_drv.h
index 86d7c9966cac..210f723cf251 100644
--- a/drivers/accel/ivpu/ivpu_drv.h
+++ b/drivers/accel/ivpu/ivpu_drv.h
@@ -110,7 +110,6 @@
 struct ivpu_wa_table {
 	bool punit_disabled;
 	bool clear_runtime_mem;
-	bool interrupt_clear_with_0;
 	bool disable_clock_relinquish;
 	bool wp0_during_power_up;
 	bool disable_d0i2;
diff --git a/drivers/accel/ivpu/ivpu_hw.c b/drivers/accel/ivpu/ivpu_hw.c
index 647dc045c231..c039eee501ae 100644
--- a/drivers/accel/ivpu/ivpu_hw.c
+++ b/drivers/accel/ivpu/ivpu_hw.c
@@ -67,9 +67,6 @@ static void wa_init(struct ivpu_device *vdev)
 	vdev->wa.punit_disabled = false;
 	vdev->wa.clear_runtime_mem = false;
 
-	if (ivpu_hw_btrs_gen(vdev) == IVPU_HW_BTRS_MTL)
-		vdev->wa.interrupt_clear_with_0 = ivpu_hw_btrs_irqs_clear_with_0_mtl(vdev);
-
 	if ((ivpu_device_id(vdev) == PCI_DEVICE_ID_LNL &&
 	     ivpu_revision(vdev) < IVPU_HW_IP_REV_LNL_B0) ||
 	    (ivpu_device_id(vdev) == PCI_DEVICE_ID_NVL &&
@@ -90,7 +87,6 @@ static void wa_init(struct ivpu_device *vdev)
 
 	IVPU_PRINT_WA(punit_disabled);
 	IVPU_PRINT_WA(clear_runtime_mem);
-	IVPU_PRINT_WA(interrupt_clear_with_0);
 	IVPU_PRINT_WA(disable_clock_relinquish);
 	IVPU_PRINT_WA(wp0_during_power_up);
 	IVPU_PRINT_WA(disable_d0i2);
diff --git a/drivers/accel/ivpu/ivpu_hw_btrs.c b/drivers/accel/ivpu/ivpu_hw_btrs.c
index a17c829adb89..2f4f5156d62e 100644
--- a/drivers/accel/ivpu/ivpu_hw_btrs.c
+++ b/drivers/accel/ivpu/ivpu_hw_btrs.c
@@ -24,9 +24,6 @@
 			   (REG_FLD(VPU_HW_BTRS_LNL_INTERRUPT_STAT, IMR1_ERR)) | \
 			   (REG_FLD(VPU_HW_BTRS_LNL_INTERRUPT_STAT, SURV_ERR)))
 
-#define BTRS_MTL_ALL_IRQ_MASK (BTRS_MTL_IRQ_MASK | (REG_FLD(VPU_HW_BTRS_MTL_INTERRUPT_STAT, \
-			       FREQ_CHANGE)))
-
 #define BTRS_IRQ_DISABLE_MASK ((u32)-1)
 
 #define BTRS_LNL_ALL_IRQ_MASK ((u32)-1)
@@ -59,18 +56,6 @@
 #define DCT_ENABLE                     0x1
 #define DCT_DISABLE                    0x0
 
-int ivpu_hw_btrs_irqs_clear_with_0_mtl(struct ivpu_device *vdev)
-{
-	REGB_WR32(VPU_HW_BTRS_MTL_INTERRUPT_STAT, BTRS_MTL_ALL_IRQ_MASK);
-	if (REGB_RD32(VPU_HW_BTRS_MTL_INTERRUPT_STAT) == BTRS_MTL_ALL_IRQ_MASK) {
-		/* Writing 1s does not clear the interrupt status register */
-		REGB_WR32(VPU_HW_BTRS_MTL_INTERRUPT_STAT, 0x0);
-		return true;
-	}
-
-	return false;
-}
-
 static void freq_ratios_init_mtl(struct ivpu_device *vdev)
 {
 	struct ivpu_hw_info *hw = vdev->hw;
@@ -729,14 +714,7 @@ bool ivpu_hw_btrs_irq_handler_mtl(struct ivpu_device *vdev, int irq)
 	}
 
 	/* This must be done after interrupts are cleared at the source. */
-	if (IVPU_WA(interrupt_clear_with_0))
-		/*
-		 * Writing 1 triggers an interrupt, so we can't perform read update write.
-		 * Clear local interrupt status by writing 0 to all bits.
-		 */
-		REGB_WR32(VPU_HW_BTRS_MTL_INTERRUPT_STAT, 0x0);
-	else
-		REGB_WR32(VPU_HW_BTRS_MTL_INTERRUPT_STAT, status);
+	REGB_WR32(VPU_HW_BTRS_MTL_INTERRUPT_STAT, status);
 
 	if (schedule_recovery)
 		ivpu_pm_trigger_recovery(vdev, "Buttress IRQ");
diff --git a/drivers/accel/ivpu/ivpu_hw_btrs.h b/drivers/accel/ivpu/ivpu_hw_btrs.h
index d6343d734570..e545284fcfa2 100644
--- a/drivers/accel/ivpu/ivpu_hw_btrs.h
+++ b/drivers/accel/ivpu/ivpu_hw_btrs.h
@@ -19,7 +19,6 @@
 
 int ivpu_hw_btrs_info_init(struct ivpu_device *vdev);
 void ivpu_hw_btrs_freq_ratios_init(struct ivpu_device *vdev);
-int ivpu_hw_btrs_irqs_clear_with_0_mtl(struct ivpu_device *vdev);
 int ivpu_hw_btrs_wp_drive(struct ivpu_device *vdev, bool enable);
 int ivpu_hw_btrs_wait_for_clock_res_own_ack(struct ivpu_device *vdev);
 int ivpu_hw_btrs_d0i3_enable(struct ivpu_device *vdev);
-- 
2.43.0

