Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92476606A338
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 20:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GDodQr/W
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC81C10E6BA;
	Tue, 17 Nov 2026 20:50:18 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EE6510E6C9
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 20:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794948613; x=1826484613;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=RQG1R6O6OcGnhuYpHYi36G2u7+nWRZka4jaWOhFri5Y=;
 b=GDodQr/Wy8RFCF+C2kBzWGD8N/XfXACgwsRBOlG8cfZ2eSakA0WS37hL
 tC+EuTm0fSyKdqSOvq/14bmg3AYhfm1z2xPvd1j2aRGdEbyI5eo0D1rdS
 m0xieCFRs5UO9c5YtknNz6jnXnPikZPQ3K3pSIXAqV66govlqr13ckrMF
 r7ILhM4u3XkV+/p9AaWHPN+Gr6HpiRsBmYvpmOTOWCzDK9JcYPtwRuo3y
 hO8qr9+SycBKhkUGM8Sm1gLwAssns7mo5jaQ4Q11IhpDiM6x4YLhlQcsA
 m2Uzn5rxjROri+UzdwL130KB1GDbWi5xNDLt1H9mfOH4k1Zbkyd3xipvF w==;
X-CSE-ConnectionGUID: e170N+WnR/iszsiHLO+DZA==
X-CSE-MsgGUID: BOkRU6n5Rcmmnc4piLhHOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3633655"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3633655"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2026 12:50:12 -0800
X-CSE-ConnectionGUID: DuZIbWrmTR6uBSdS4ugSaA==
X-CSE-MsgGUID: AjAovy6wSK2AQh4SKPWBFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; d="scan'208";a="10310718"
Received: from akacprow-dev3.igk.intel.com ([10.91.220.47])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2026 12:50:11 -0800
From: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, jeff.hugo@oss.qualcomm.com,
 karol.wachowski@linux.intel.com, lizhi.hou@amd.com,
 dawid.osuchowski@linux.intel.com,
 Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
Subject: [PATCH v2] accel/ivpu: Remove sched_mode module parameter
Date: Tue, 17 Nov 2026 21:44:19 +0100
Message-ID: <20261117204419.2841928-1-andrzej.kacprowski@linux.intel.com>
X-Mailer: git-send-email 2.43.0
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

OS scheduling supports only a limited subset of NPU functionality and
is not intended for production use. However, the sched_mode module
parameter exposes it as a regular configuration option, and the driver
silently falls back to it when the firmware JSM API is older than 3.24.

Make hardware scheduling the only production mode:
- remove the sched_mode module parameter,
- require BOOT API 3.17 and JSM API 3.24 or newer, and fail probe with
  a message requesting a firmware update otherwise,
- allow OS scheduling on pre-60XX devices only through the
  IVPU_TEST_MODE_HWS_DISABLE test_mode bit, for debugging.

The initial 37xx and 40xx firmware added to linux-firmware in March 2025
reports BOOT and JSM APIs 3.27, meeting both minimum requirements.

Extend IVPU_FW_CHECK_API_COMPAT() to accept minimum major and minor
versions so both API requirements can be checked explicitly.

Signed-off-by: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
---
Change in v2
- Resent the patch from the @linux.intel.com address, the @intel.com
  account adds a confidentiality notice.

 drivers/accel/ivpu/ivpu_drv.c |  4 --
 drivers/accel/ivpu/ivpu_drv.h |  4 +-
 drivers/accel/ivpu/ivpu_fw.c  | 84 ++++++++++++++++-------------------
 3 files changed, 39 insertions(+), 53 deletions(-)

diff --git a/drivers/accel/ivpu/ivpu_drv.c b/drivers/accel/ivpu/ivpu_drv.c
index 28cb18dcfa9b..2c761a6aa6ca 100644
--- a/drivers/accel/ivpu/ivpu_drv.c
+++ b/drivers/accel/ivpu/ivpu_drv.c
@@ -55,10 +55,6 @@ u8 ivpu_pll_max_ratio = U8_MAX;
 module_param_named(pll_max_ratio, ivpu_pll_max_ratio, byte, 0644);
 MODULE_PARM_DESC(pll_max_ratio, "Maximum PLL ratio used to set NPU frequency");
 
-int ivpu_sched_mode = IVPU_SCHED_MODE_AUTO;
-module_param_named(sched_mode, ivpu_sched_mode, int, 0444);
-MODULE_PARM_DESC(sched_mode, "Scheduler mode: -1 - Use default scheduler, 0 - Use OS scheduler (supported on 27XX - 50XX), 1 - Use HW scheduler");
-
 bool ivpu_disable_mmu_cont_pages;
 module_param_named(disable_mmu_cont_pages, ivpu_disable_mmu_cont_pages, bool, 0444);
 MODULE_PARM_DESC(disable_mmu_cont_pages, "Disable MMU contiguous pages optimization");
diff --git a/drivers/accel/ivpu/ivpu_drv.h b/drivers/accel/ivpu/ivpu_drv.h
index fe8b66e779a7..9b24d6c9d864 100644
--- a/drivers/accel/ivpu/ivpu_drv.h
+++ b/drivers/accel/ivpu/ivpu_drv.h
@@ -56,8 +56,6 @@
 #define IVPU_PLATFORM_HSLE    4
 #define IVPU_PLATFORM_INVALID 8
 
-#define IVPU_SCHED_MODE_AUTO -1
-
 #define IVPU_DBG_REG	 BIT(0)
 #define IVPU_DBG_IRQ	 BIT(1)
 #define IVPU_DBG_MMU	 BIT(2)
@@ -224,7 +222,6 @@ struct ivpu_file_priv {
 extern int ivpu_dbg_mask;
 extern u8 ivpu_pll_min_ratio;
 extern u8 ivpu_pll_max_ratio;
-extern int ivpu_sched_mode;
 extern bool ivpu_disable_mmu_cont_pages;
 extern bool ivpu_force_snoop;
 
@@ -233,6 +230,7 @@ extern bool ivpu_force_snoop;
 #define IVPU_TEST_MODE_NULL_SUBMISSION    BIT(2)
 #define IVPU_TEST_MODE_FREQ_CHANGE_ENABLE BIT(3)
 #define IVPU_TEST_MODE_MIP_DISABLE        BIT(6)
+#define IVPU_TEST_MODE_HWS_DISABLE        BIT(7)
 #define IVPU_TEST_MODE_DISABLE_TIMEOUTS   BIT(8)
 #define IVPU_TEST_MODE_TURBO_ENABLE       BIT(9)
 #define IVPU_TEST_MODE_TURBO_DISABLE      BIT(10)
diff --git a/drivers/accel/ivpu/ivpu_fw.c b/drivers/accel/ivpu/ivpu_fw.c
index 6607a5da1934..eaf7a193e305 100644
--- a/drivers/accel/ivpu/ivpu_fw.c
+++ b/drivers/accel/ivpu/ivpu_fw.c
@@ -33,15 +33,11 @@
 #define ADDR_TO_L2_CACHE_CFG(addr) ((addr) >> 31)
 
 /* Check if FW API is compatible with the driver */
-#define IVPU_FW_CHECK_API_COMPAT(vdev, name, min_major) \
+#define IVPU_FW_CHECK_API_COMPAT(vdev, name, min_major, min_minor) \
 	ivpu_fw_check_api(vdev, #name, \
 			  VPU_##name##_API_VER_INDEX, \
 			  VPU_##name##_API_VER_MAJOR, \
-			  VPU_##name##_API_VER_MINOR, min_major)
-
-/* Check if API version is lower that the given version */
-#define IVPU_FW_CHECK_API_VER_LT(vdev, name, major, minor) \
-	ivpu_fw_check_api_ver_lt(vdev, #name, VPU_##name##_API_VER_INDEX, major, minor)
+			  VPU_##name##_API_VER_MINOR, min_major, min_minor)
 
 #define IVPU_FOCUS_PRESENT_TIMER_MS 1000
 
@@ -97,28 +93,6 @@ static int ivpu_fw_request(struct ivpu_device *vdev)
 	return ret;
 }
 
-static int
-ivpu_fw_check_api(struct ivpu_device *vdev, const char *str, int index, u16 expected_major,
-		  u16 expected_minor, u16 min_major)
-{
-	u16 major = (u16)(vdev->fw->api_version[index] >> 16);
-	u16 minor = (u16)(vdev->fw->api_version[index]);
-
-	if (major < min_major) {
-		ivpu_err(vdev, "Incompatible FW %s API version: %d.%d, required %d.0 or later\n",
-			 str, major, minor, min_major);
-		return -EINVAL;
-	}
-	if (major != expected_major) {
-		ivpu_warn(vdev, "Major FW %s API version different: %d.%d (expected %d.%d)\n",
-			  str, major, minor, expected_major, expected_minor);
-	}
-	ivpu_dbg(vdev, FW_BOOT, "FW %s API version: %d.%d (expected %d.%d)\n",
-		 str, major, minor, expected_major, expected_minor);
-
-	return 0;
-}
-
 static bool
 ivpu_fw_check_api_ver_lt(struct ivpu_device *vdev, const char *str, int index, u16 major, u16 minor)
 {
@@ -131,6 +105,29 @@ ivpu_fw_check_api_ver_lt(struct ivpu_device *vdev, const char *str, int index, u
 	return false;
 }
 
+static int
+ivpu_fw_check_api(struct ivpu_device *vdev, const char *str, int index, u16 drv_major,
+		  u16 drv_minor, u16 min_major, u16 min_minor)
+{
+	u16 fw_major = (u16)(vdev->fw->api_version[index] >> 16);
+	u16 fw_minor = (u16)(vdev->fw->api_version[index]);
+
+	if (ivpu_fw_check_api_ver_lt(vdev, str, index, min_major, min_minor)) {
+		ivpu_err(vdev, "Firmware %s API version %u.%u is too old; minimum supported version is %u.%u\n",
+			 str, fw_major, fw_minor, min_major, min_minor);
+		ivpu_err(vdev, "Update firmware %s before using this device\n", vdev->fw->name);
+		return -EINVAL;
+	}
+	if (fw_major != drv_major) {
+		ivpu_warn(vdev, "Major %s API version different: firmware %u.%u, driver %u.%u\n",
+			  str, fw_major, fw_minor, drv_major, drv_minor);
+	}
+	ivpu_dbg(vdev, FW_BOOT, "%s API version: firmware %u.%u, driver %u.%u\n",
+		 str, fw_major, fw_minor, drv_major, drv_minor);
+
+	return 0;
+}
+
 bool ivpu_is_within_range(u64 addr, size_t size, struct ivpu_addr_range *range)
 {
 	u64 addr_end;
@@ -144,22 +141,18 @@ bool ivpu_is_within_range(u64 addr, size_t size, struct ivpu_addr_range *range)
 	return true;
 }
 
-static u32
-ivpu_fw_sched_mode_select(struct ivpu_device *vdev)
+static void ivpu_fw_sched_mode_init(struct ivpu_device *vdev)
 {
-	if (ivpu_hw_ip_gen(vdev) >= IVPU_HW_IP_60XX &&
-	    ivpu_sched_mode == VPU_SCHEDULING_MODE_OS) {
-		ivpu_warn(vdev, "OS sched mode is not supported, using HW mode\n");
-		return VPU_SCHEDULING_MODE_HW;
+	if (ivpu_test_mode & IVPU_TEST_MODE_HWS_DISABLE) {
+		if (ivpu_hw_ip_gen(vdev) < IVPU_HW_IP_60XX) {
+			vdev->fw->sched_mode = VPU_SCHEDULING_MODE_OS;
+			ivpu_warn(vdev, "OS scheduling mode enabled. Use for debug only!\n");
+			return;
+		}
+		ivpu_warn(vdev, "OS scheduling mode is not supported, using HW mode\n");
 	}
-
-	if (ivpu_sched_mode != IVPU_SCHED_MODE_AUTO)
-		return ivpu_sched_mode;
-
-	if (IVPU_FW_CHECK_API_VER_LT(vdev, JSM, 3, 24))
-		return VPU_SCHEDULING_MODE_OS;
-
-	return VPU_SCHEDULING_MODE_HW;
+	vdev->fw->sched_mode = VPU_SCHEDULING_MODE_HW;
+	ivpu_dbg(vdev, FW_BOOT, "Scheduling mode: HW\n");
 }
 
 static void
@@ -306,9 +299,9 @@ static int ivpu_fw_parse(struct ivpu_device *vdev)
 
 	memcpy(fw->api_version, fw_hdr->api_version, sizeof(fw->api_version));
 
-	if (IVPU_FW_CHECK_API_COMPAT(vdev, BOOT, 3))
+	if (IVPU_FW_CHECK_API_COMPAT(vdev, BOOT, 3, 17))
 		return -EINVAL;
-	if (IVPU_FW_CHECK_API_COMPAT(vdev, JSM, 3))
+	if (IVPU_FW_CHECK_API_COMPAT(vdev, JSM, 3, 24))
 		return -EINVAL;
 
 	fw->boot_params_addr = boot_params_addr;
@@ -322,8 +315,7 @@ static int ivpu_fw_parse(struct ivpu_device *vdev)
 	fw->shave_nn_size = PAGE_ALIGN(fw_hdr->shave_nn_fw_size);
 	fw->cold_boot_entry_point = fw_hdr->entry_point;
 
-	fw->sched_mode = ivpu_fw_sched_mode_select(vdev);
-	ivpu_info(vdev, "Scheduler mode: %s\n", fw->sched_mode ? "HW" : "OS");
+	ivpu_fw_sched_mode_init(vdev);
 
 	ivpu_preemption_config_parse(vdev, fw_hdr);
 
-- 
2.43.0

