Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3108BCA5FB3
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 11:10:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92F8910E237;
	Thu,  1 Oct 2026 11:10:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="b4+ZW3ye";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90A8C10E237
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 11:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790853027; x=1822389027;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=D8F2fQJdKdLEDIuOvRIc7FsKGH7mY87rZmOkPuY3888=;
 b=b4+ZW3ye9WSH+exn/HGvTYhsLscHvL01k7zjTwE7DMP93m3uETHmpSA8
 nk5rGobVcuq34OFGDfCOyRU/Ht97FyER/rdDHZRPaQwelSNm8VUgNl2xR
 srT/b2xgd32S3n7Xsvp3ubfzph175WL3F6xu51F/xaZxltiMRq3mmkZLA
 51cqmt7n1z6/un/byZ8var0rtzkMTohk4JV0AgVSAeNOA5fVT1ypHjc81
 8nrmen0dZ3o5iegM6GxwJ7F6Fb2zmWCuischtM0MEIh11x4rtMAM73MB7
 68g/l3wKZXmVdZnjgGAxy3Yfod3KCMW+YnGTgbZDFUnpkT1FwC4fy/4sp A==;
X-CSE-ConnectionGUID: dTjo8dZuTJqvGzhfaDEDhw==
X-CSE-MsgGUID: 6M1RGRMiQEe7n/WVKIM2Mg==
X-IronPort-AV: E=McAfee;i="6800,10657,11921"; a="90465597"
X-IronPort-AV: E=Sophos;i="6.27,134,1787036400"; d="scan'208";a="90465597"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2026 04:10:26 -0700
X-CSE-ConnectionGUID: BG3Jsv00Ssa6lfq7CEXQLg==
X-CSE-MsgGUID: TCt13To0S1OYpYamOX2QOg==
X-ExtLoop1: 1
Received: from try2-8594.igk.intel.com ([10.91.220.58])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2026 04:10:24 -0700
From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, jeff.hugo@oss.qualcomm.com,
 karol.wachowski@linux.intel.com, lizhi.hou@amd.com,
 andrzej.kacprowski@linux.intel.com,
 Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
Subject: [PATCH 3/3] accel/ivpu: Split HW IP generation dispatch into helpers
Date: Thu,  1 Oct 2026 13:04:01 +0200
Message-ID: <20261001110401.2866557-4-dawid.osuchowski@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261001110401.2866557-1-dawid.osuchowski@linux.intel.com>
References: <20261001110401.2866557-1-dawid.osuchowski@linux.intel.com>
MIME-Version: 1.0
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173,
 80-298 Gdansk - KRS 101882 - NIP 957-07-52-31
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

From: Karol Wachowski <karol.wachowski@linux.intel.com>

ivpu_hw_ip_soc_cpu_boot() and pwr_island_delay_set() keep the result of
their per-generation switch in locals that are left uninitialized on the
path past the last case. Building with -Wmaybe-uninitialized reports ret,
post, post2 and status; Kbuild disables that warning for GCC, so it does
not show up in a normal build.

Let every case return directly instead, so no local is needed.
ivpu_hw_ip_soc_cpu_boot() now dispatches on its own, with the debug
message moved ahead of the switch so that the boot mode is logged before
the boot registers are written, and the power island delay values move
into per-generation helpers. Neither switch has a default: label, so
-Wswitch reports any enum vpu_hw_ip value added later that is not
handled, and the path past the switch returns -EINVAL.

Build the power island delay values from zero instead of reading the
registers first. POST_DLY, POST1_DLY and POST2_DLY together span every
writable bit of PWR_ISLAND_EN_POST_DLY, and STATUS_DLY spans every
writable bit of PWR_ISLAND_STATUS_DLY, so the read-modify-write only
fetched bits that are immediately overwritten.

The boot mode is now logged even when the boot fails; no other functional
changes.

Signed-off-by: Karol Wachowski <karol.wachowski@linux.intel.com>
Signed-off-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
---
 drivers/accel/ivpu/ivpu_hw_ip.c | 64 ++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 33 deletions(-)

diff --git a/drivers/accel/ivpu/ivpu_hw_ip.c b/drivers/accel/ivpu/ivpu_hw_ip.c
index bd6bb3fa49ff..36730f4338f0 100644
--- a/drivers/accel/ivpu/ivpu_hw_ip.c
+++ b/drivers/accel/ivpu/ivpu_hw_ip.c
@@ -265,21 +265,35 @@ void ivpu_hw_ip_idle_gen_disable(struct ivpu_device *vdev)
 }
 
 static void
-pwr_island_delay_set_50xx(struct ivpu_device *vdev, u32 post, u32 post1, u32 post2, u32 status)
+pwr_island_delay_write(struct ivpu_device *vdev, u32 post, u32 post1, u32 post2, u32 status)
 {
 	u32 val;
 
-	val = REGV_RD32(VPU_50XX_HOST_SS_AON_PWR_ISLAND_EN_POST_DLY);
-	val = REG_SET_FLD_NUM(VPU_50XX_HOST_SS_AON_PWR_ISLAND_EN_POST_DLY, POST_DLY, post, val);
+	val = REG_SET_FLD_NUM(VPU_50XX_HOST_SS_AON_PWR_ISLAND_EN_POST_DLY, POST_DLY, post, 0);
 	val = REG_SET_FLD_NUM(VPU_50XX_HOST_SS_AON_PWR_ISLAND_EN_POST_DLY, POST1_DLY, post1, val);
 	val = REG_SET_FLD_NUM(VPU_50XX_HOST_SS_AON_PWR_ISLAND_EN_POST_DLY, POST2_DLY, post2, val);
 	REGV_WR32(VPU_50XX_HOST_SS_AON_PWR_ISLAND_EN_POST_DLY, val);
 
-	val = REGV_RD32(VPU_50XX_HOST_SS_AON_PWR_ISLAND_STATUS_DLY);
-	val = REG_SET_FLD_NUM(VPU_50XX_HOST_SS_AON_PWR_ISLAND_STATUS_DLY, STATUS_DLY, status, val);
+	val = REG_SET_FLD_NUM(VPU_50XX_HOST_SS_AON_PWR_ISLAND_STATUS_DLY, STATUS_DLY, status, 0);
 	REGV_WR32(VPU_50XX_HOST_SS_AON_PWR_ISLAND_STATUS_DLY, val);
 }
 
+static void pwr_island_delay_set_50xx(struct ivpu_device *vdev)
+{
+	if (vdev->hw->pll.profiling_freq == PLL_PROFILING_FREQ_HIGH)
+		pwr_island_delay_write(vdev, 18, 0, 0, 46);
+	else
+		pwr_island_delay_write(vdev, 0, 0, 0, 3);
+}
+
+static void pwr_island_delay_set_60xx(struct ivpu_device *vdev)
+{
+	if (vdev->hw->pll.profiling_freq == PLL_PROFILING_FREQ_HIGH)
+		pwr_island_delay_write(vdev, 198, 0, 198, 0);
+	else
+		pwr_island_delay_write(vdev, 17, 0, 17, 0);
+}
+
 static void pwr_island_trickle_drive_37xx(struct ivpu_device *vdev, bool enable)
 {
 	u32 val = REGV_RD32(VPU_37XX_HOST_SS_AON_PWR_ISLAND_TRICKLE_EN0);
@@ -675,27 +689,19 @@ static void dpu_active_drive_37xx(struct ivpu_device *vdev, bool enable)
 
 static void pwr_island_delay_set(struct ivpu_device *vdev)
 {
-	bool high = vdev->hw->pll.profiling_freq == PLL_PROFILING_FREQ_HIGH;
-	u32 post, post1, post2, status;
-
 	switch (ivpu_hw_ip_gen(vdev)) {
 	case IVPU_HW_IP_37XX:
 	case IVPU_HW_IP_40XX:
 		return;
+
 	case IVPU_HW_IP_50XX:
-		post = high ? 18 : 0;
-		post1 = 0;
-		post2 = 0;
-		status = high ? 46 : 3;
-		break;
+		pwr_island_delay_set_50xx(vdev);
+		return;
+
 	case IVPU_HW_IP_60XX:
-		post = high ? 198 : 17;
-		post1 = 0;
-		post2 = high ? 198 : 17;
-		status = 0;
+		pwr_island_delay_set_60xx(vdev);
+		return;
 	}
-
-	pwr_island_delay_set_50xx(vdev, post, post1, post2, status);
 }
 
 int ivpu_hw_ip_pwr_domain_enable(struct ivpu_device *vdev)
@@ -933,30 +939,22 @@ static int soc_cpu_boot_60xx(struct ivpu_device *vdev)
 
 int ivpu_hw_ip_soc_cpu_boot(struct ivpu_device *vdev)
 {
-	int ret;
+	ivpu_dbg(vdev, PM, "Booting firmware, mode: %s\n",
+		 ivpu_fw_is_warm_boot(vdev) ? "warm boot" : "cold boot");
 
 	switch (ivpu_hw_ip_gen(vdev)) {
 	case IVPU_HW_IP_37XX:
-		ret = soc_cpu_boot_37xx(vdev);
-		break;
+		return soc_cpu_boot_37xx(vdev);
 
 	case IVPU_HW_IP_40XX:
 	case IVPU_HW_IP_50XX:
-		ret = soc_cpu_boot_40xx(vdev);
-		break;
+		return soc_cpu_boot_40xx(vdev);
 
 	case IVPU_HW_IP_60XX:
-		ret = soc_cpu_boot_60xx(vdev);
-		break;
+		return soc_cpu_boot_60xx(vdev);
 	}
 
-	if (ret)
-		return ret;
-
-	ivpu_dbg(vdev, PM, "Booting firmware, mode: %s\n",
-		 ivpu_fw_is_warm_boot(vdev) ? "warm boot" : "cold boot");
-
-	return 0;
+	return -EINVAL;
 }
 
 static void wdt_disable_37xx(struct ivpu_device *vdev)
-- 
2.43.0

