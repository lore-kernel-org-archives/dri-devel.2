Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942C8606A31B
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 09:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NWwWRlEx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0265110ED1B;
	Mon, 26 Oct 2026 09:36:15 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7B4D10ED1B
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793007366; x=1824543366;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=OVnYgL0l1Zg+JEnCiZJwFCqaO1s2/oT4oYQZVQTDEi8=;
 b=NWwWRlExOCZStSwnwW3ThHtYaHdqTpxglxeye4dKsUV1fdDLlhcRf3TY
 J6BO4gdMx0yp34G3Y/DnuyOkMJUPlmzc+l/iggkVEKCikcNSZKu/XlttB
 PCYNScEFiN82IfGvENX1KwwGaeidVSYW9SuZ26dcEBbgaNU3FMBqxWHb5
 Y7XwBKeH7nN9YS6w5wTFw4TJR9TjG2flmF6yNeLlKlj0pEJS/uXCZJoje
 PWswGd/tXl4xIf25zHEOkET9U3yPU+8CTtPvdxeMs4TAd6wBOWv9ofNSP
 WtqwqKBLNX1zpTK9S2sVHS3B8VO66LhlLVthrLWBIRonorbkR/9OO4u74 A==;
X-CSE-ConnectionGUID: p+LeKLiZQ7akkUhw36KyeA==
X-CSE-MsgGUID: H/hVMYorToSXabBJXQm/Bg==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1673081"
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="1673081"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2026 02:36:06 -0700
X-CSE-ConnectionGUID: 3XZPtCgySnq1/cTX9ZpfwA==
X-CSE-MsgGUID: 5fktleE+SHG1l36gr70vzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="4100165"
Received: from akacprow-dev3.igk.intel.com ([10.91.220.47])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2026 02:36:05 -0700
From: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, jeff.hugo@oss.qualcomm.com,
 karol.wachowski@linux.intel.com, lizhi.hou@amd.com,
 dawid.osuchowski@linux.intel.com,
 Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
Subject: [PATCH] accel/ivpu: Read preemption buffer size from boot params
Date: Mon, 26 Oct 2026 10:30:20 +0100
Message-ID: <20261026093020.228233-1-andrzej.kacprowski@linux.intel.com>
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
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The optimal preemption buffer size depends on the hardware and firmware
configuration, which is best known to the firmware. Newer firmware
reports the required size in the preemption_buffer_size field of the
boot params, which it writes before signaling cold boot completion.

Read the size from the boot params once, after the initial cold boot
during device initialization, as the firmware does not update it
afterwards. Use it as the primary preemption buffer size and skip
allocating the secondary buffer. A size outside of the [2 MiB, 32 MiB]
range is treated as a firmware error and fails probe. If the firmware
does not report the size, keep using the sizes from the firmware image
header to preserve compatibility with older firmware.

When preemption_buffer_1_max_size is set in the image header, use
preemption_buffer_2_max_size even if it is zero, instead of falling
back to preemption_buffer_2_size.

Move initialization of the trace and DVFS defaults to
ivpu_fw_preboot_init().

Update the FW boot API header to version 3.39.1:
- Add the VPU_GOV_ON_DEMAND_PER_PRIORITY and VPU_GOV_ON_DEMAND_QOS
  DVFS governors
- Add the preemption_buffer_size field to struct vpu_boot_params
- Mark the preemption buffer sizes in the image header as deprecated

Signed-off-by: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
---
 drivers/accel/ivpu/ivpu_drv.c     | 11 +++-
 drivers/accel/ivpu/ivpu_drv.h     |  2 +-
 drivers/accel/ivpu/ivpu_fw.c      | 91 +++++++++++++++++++++++--------
 drivers/accel/ivpu/ivpu_fw.h      |  1 +
 drivers/accel/ivpu/ivpu_job.c     |  3 +
 drivers/accel/ivpu/ivpu_pm.c      |  2 +-
 drivers/accel/ivpu/vpu_boot_api.h | 36 +++++++++---
 7 files changed, 112 insertions(+), 34 deletions(-)

diff --git a/drivers/accel/ivpu/ivpu_drv.c b/drivers/accel/ivpu/ivpu_drv.c
index 61149b7c30c2..b60430dcf168 100644
--- a/drivers/accel/ivpu/ivpu_drv.c
+++ b/drivers/accel/ivpu/ivpu_drv.c
@@ -506,11 +506,12 @@ static int ivpu_hw_sched_init(struct ivpu_device *vdev)
 /**
  * ivpu_boot() - Start VPU firmware
  * @vdev: VPU device
+ * @device_init: Indicates if this is the initial boot during device initialization
  *
  * This function is paired with ivpu_shutdown() but it doesn't power up the
  * VPU because power up has to be called very early in ivpu_probe().
  */
-int ivpu_boot(struct ivpu_device *vdev)
+int ivpu_boot(struct ivpu_device *vdev, bool device_init)
 {
 	int ret;
 
@@ -547,6 +548,12 @@ int ivpu_boot(struct ivpu_device *vdev)
 	if (ivpu_test_mode & IVPU_TEST_MODE_FW_TEST)
 		return 0;
 
+	if (device_init) {
+		ret = ivpu_fw_postboot_init(vdev);
+		if (ret)
+			goto err_disable_ipc;
+	}
+
 	if (!ivpu_fw_is_warm_boot(vdev)) {
 		ret = ivpu_pm_dct_init(vdev);
 		if (ret)
@@ -841,7 +848,7 @@ static int ivpu_dev_init(struct ivpu_device *vdev)
 
 	ivpu_pm_init(vdev);
 
-	ret = ivpu_boot(vdev);
+	ret = ivpu_boot(vdev, true);
 	if (ret)
 		goto err_ipc_fini;
 
diff --git a/drivers/accel/ivpu/ivpu_drv.h b/drivers/accel/ivpu/ivpu_drv.h
index ea5b8dc612d1..70fab9c649d2 100644
--- a/drivers/accel/ivpu/ivpu_drv.h
+++ b/drivers/accel/ivpu/ivpu_drv.h
@@ -243,7 +243,7 @@ extern int ivpu_test_mode;
 struct ivpu_file_priv *ivpu_file_priv_get(struct ivpu_file_priv *file_priv);
 void ivpu_file_priv_put(struct ivpu_file_priv **link);
 
-int ivpu_boot(struct ivpu_device *vdev);
+int ivpu_boot(struct ivpu_device *vdev, bool device_init);
 int ivpu_shutdown(struct ivpu_device *vdev);
 void ivpu_prepare_for_reset(struct ivpu_device *vdev);
 bool ivpu_is_capable(struct ivpu_device *vdev, u32 capability);
diff --git a/drivers/accel/ivpu/ivpu_fw.c b/drivers/accel/ivpu/ivpu_fw.c
index 96f5be23a867..6607a5da1934 100644
--- a/drivers/accel/ivpu/ivpu_fw.c
+++ b/drivers/accel/ivpu/ivpu_fw.c
@@ -19,8 +19,13 @@
 
 #define FW_SHAVE_NN_MAX_SIZE	SZ_2M
 #define FW_FILE_IMAGE_OFFSET	(VPU_FW_HEADER_SIZE + FW_VERSION_HEADER_SIZE)
-#define FW_PREEMPT_BUF_MIN_SIZE SZ_4K
-#define FW_PREEMPT_BUF_MAX_SIZE SZ_32M
+
+/* Size limits for preemption buffer sizes from image header */
+#define FW_PREEMPT_BUF_MIN_SIZE		SZ_4K
+#define FW_PREEMPT_BUF_MAX_SIZE		SZ_32M
+/* Size limits for preemption buffer size from boot parameters */
+#define FW_PREEMPT_BUF_BP_MIN_SIZE	SZ_2M
+#define FW_PREEMPT_BUF_BP_MAX_SIZE	SZ_32M
 
 #define WATCHDOG_MSS_REDIRECT	32
 #define WATCHDOG_NCE_REDIRECT	33
@@ -160,35 +165,31 @@ ivpu_fw_sched_mode_select(struct ivpu_device *vdev)
 static void
 ivpu_preemption_config_parse(struct ivpu_device *vdev, const struct vpu_firmware_header *fw_hdr)
 {
-	struct ivpu_fw_info *fw = vdev->fw;
 	u32 primary_preempt_buf_size, secondary_preempt_buf_size;
 
-	if (fw_hdr->preemption_buffer_1_max_size)
+	if (fw_hdr->preemption_buffer_1_max_size) {
 		primary_preempt_buf_size = fw_hdr->preemption_buffer_1_max_size;
-	else
-		primary_preempt_buf_size = fw_hdr->preemption_buffer_1_size;
-
-	if (fw_hdr->preemption_buffer_2_max_size)
 		secondary_preempt_buf_size = fw_hdr->preemption_buffer_2_max_size;
-	else
+	} else {
+		primary_preempt_buf_size = fw_hdr->preemption_buffer_1_size;
 		secondary_preempt_buf_size = fw_hdr->preemption_buffer_2_size;
-
-	ivpu_dbg(vdev, FW_BOOT, "Preemption buffer size, primary: %u, secondary: %u\n",
-		 primary_preempt_buf_size, secondary_preempt_buf_size);
+	}
 
 	if (primary_preempt_buf_size < FW_PREEMPT_BUF_MIN_SIZE ||
 	    secondary_preempt_buf_size < FW_PREEMPT_BUF_MIN_SIZE) {
-		ivpu_warn(vdev, "Preemption buffers size too small\n");
+		ivpu_warn(vdev, "Preemption buffers size too small, primary %u, secondary %u\n",
+			  primary_preempt_buf_size, secondary_preempt_buf_size);
 		return;
 	}
 
 	if (primary_preempt_buf_size > FW_PREEMPT_BUF_MAX_SIZE ||
 	    secondary_preempt_buf_size > FW_PREEMPT_BUF_MAX_SIZE) {
-		ivpu_warn(vdev, "Preemption buffers size too big\n");
+		ivpu_warn(vdev, "Preemption buffers size too big, primary %u, secondary %u\n",
+			  primary_preempt_buf_size, secondary_preempt_buf_size);
 		return;
 	}
 
-	if (fw->sched_mode != VPU_SCHEDULING_MODE_HW)
+	if (vdev->fw->sched_mode != VPU_SCHEDULING_MODE_HW)
 		return;
 
 	if (ivpu_test_mode & IVPU_TEST_MODE_MIP_DISABLE)
@@ -196,6 +197,9 @@ ivpu_preemption_config_parse(struct ivpu_device *vdev, const struct vpu_firmware
 
 	vdev->fw->primary_preempt_buf_size = ALIGN(primary_preempt_buf_size, PAGE_SIZE);
 	vdev->fw->secondary_preempt_buf_size = ALIGN(secondary_preempt_buf_size, PAGE_SIZE);
+
+	ivpu_dbg(vdev, FW_BOOT, "Preemption buffer size, primary: %u, secondary: %u\n",
+		 vdev->fw->primary_preempt_buf_size, vdev->fw->secondary_preempt_buf_size);
 }
 
 static int ivpu_fw_parse(struct ivpu_device *vdev)
@@ -318,18 +322,10 @@ static int ivpu_fw_parse(struct ivpu_device *vdev)
 	fw->shave_nn_size = PAGE_ALIGN(fw_hdr->shave_nn_fw_size);
 	fw->cold_boot_entry_point = fw_hdr->entry_point;
 
-	fw->trace_level = min(ivpu_fw_log_level, IVPU_FW_LOG_FATAL);
-	fw->trace_destination_mask = VPU_TRACE_DESTINATION_VERBOSE_TRACING;
-	fw->trace_hw_component_mask = -1;
-
-	fw->dvfs_mode = 0;
-
 	fw->sched_mode = ivpu_fw_sched_mode_select(vdev);
 	ivpu_info(vdev, "Scheduler mode: %s\n", fw->sched_mode ? "HW" : "OS");
 
 	ivpu_preemption_config_parse(vdev, fw_hdr);
-	ivpu_dbg(vdev, FW_BOOT, "Mid-inference preemption %s supported\n",
-		 ivpu_fw_preempt_buf_size(vdev) ? "is" : "is not");
 
 	if (fw_hdr->ro_section_start_address &&
 	    !ivpu_is_within_range(fw_hdr->ro_section_start_address, fw_hdr->ro_section_size,
@@ -363,6 +359,16 @@ static void ivpu_fw_release(struct ivpu_device *vdev)
 	release_firmware(vdev->fw->file);
 }
 
+static void ivpu_fw_preboot_init(struct ivpu_device *vdev)
+{
+	struct ivpu_fw_info *fw = vdev->fw;
+
+	/* Let the firmware decide optimal DVFS mode */
+	fw->dvfs_mode = 0;
+	fw->trace_level = min(ivpu_fw_log_level, IVPU_FW_LOG_FATAL);
+	fw->trace_destination_mask = VPU_TRACE_DESTINATION_VERBOSE_TRACING;
+	fw->trace_hw_component_mask = -1;
+}
 
 static void ivpu_fw_mem_fini(struct ivpu_device *vdev)
 {
@@ -469,6 +475,8 @@ int ivpu_fw_init(struct ivpu_device *vdev)
 	if (ret)
 		goto err_fw_release;
 
+	ivpu_fw_preboot_init(vdev);
+
 	ret = ivpu_fw_mem_init(vdev);
 	if (ret)
 		goto err_fw_release;
@@ -710,3 +718,40 @@ void ivpu_fw_boot_params_setup(struct ivpu_device *vdev, struct vpu_boot_params
 
 	ivpu_fw_boot_params_print(vdev, boot_params);
 }
+
+int ivpu_fw_postboot_init(struct ivpu_device *vdev)
+{
+	struct vpu_boot_params *boot_params = ivpu_bo_vaddr(vdev->fw->mem_bp);
+	u32 preempt_buf_size = boot_params->preemption_buffer_size;
+
+	ivpu_dbg(vdev, FW_BOOT, "Post boot init\n");
+
+	if (vdev->fw->sched_mode == VPU_SCHEDULING_MODE_OS ||
+	    ivpu_test_mode & IVPU_TEST_MODE_MIP_DISABLE) {
+		drm_WARN_ON(&vdev->drm, ivpu_fw_preempt_buf_size(vdev));
+		ivpu_dbg(vdev, FW_BOOT, "Preemption disabled!\n");
+		return 0;
+	}
+
+	if (preempt_buf_size) {
+		/* Preemption buffer size provided in boot parameters */
+		if (preempt_buf_size < FW_PREEMPT_BUF_BP_MIN_SIZE ||
+		    preempt_buf_size > FW_PREEMPT_BUF_BP_MAX_SIZE) {
+			ivpu_err(vdev, "Invalid preemption buffer size in boot params: %u, expected range [%u, %u]\n",
+				 preempt_buf_size,
+				 FW_PREEMPT_BUF_BP_MIN_SIZE,
+				 FW_PREEMPT_BUF_BP_MAX_SIZE);
+			/* Be strict about invalid preemption buffer size in boot params */
+			return -EINVAL;
+		}
+		vdev->fw->primary_preempt_buf_size = ALIGN(preempt_buf_size, PAGE_SIZE);
+		vdev->fw->secondary_preempt_buf_size = 0;
+	}
+
+	ivpu_dbg(vdev, FW_BOOT, "Preemption buffer size: %u\n", ivpu_fw_preempt_buf_size(vdev));
+
+	if (!ivpu_fw_preempt_buf_size(vdev))
+		ivpu_warn(vdev, "Hardware scheduling without preemption buffer!\n");
+
+	return 0;
+}
diff --git a/drivers/accel/ivpu/ivpu_fw.h b/drivers/accel/ivpu/ivpu_fw.h
index 45a705431f22..2fcedb6c3e7d 100644
--- a/drivers/accel/ivpu/ivpu_fw.h
+++ b/drivers/accel/ivpu/ivpu_fw.h
@@ -57,6 +57,7 @@ int ivpu_fw_init(struct ivpu_device *vdev);
 void ivpu_fw_fini(struct ivpu_device *vdev);
 int ivpu_fw_load(struct ivpu_device *vdev);
 void ivpu_fw_boot_params_setup(struct ivpu_device *vdev, struct vpu_boot_params *boot_params);
+int ivpu_fw_postboot_init(struct ivpu_device *vdev);
 
 static inline bool ivpu_fw_is_warm_boot(struct ivpu_device *vdev)
 {
diff --git a/drivers/accel/ivpu/ivpu_job.c b/drivers/accel/ivpu/ivpu_job.c
index bfdee29cd91c..6a1307ee2e19 100644
--- a/drivers/accel/ivpu/ivpu_job.c
+++ b/drivers/accel/ivpu/ivpu_job.c
@@ -45,6 +45,9 @@ static int ivpu_preemption_buffers_create(struct ivpu_device *vdev,
 		return -ENOMEM;
 	}
 
+	if (vdev->fw->secondary_preempt_buf_size == 0)
+		return 0;
+
 	cmdq->secondary_preempt_buf = ivpu_bo_create(vdev, &file_priv->ctx, &vdev->hw->ranges.dma,
 						     vdev->fw->secondary_preempt_buf_size,
 						     DRM_IVPU_BO_WC);
diff --git a/drivers/accel/ivpu/ivpu_pm.c b/drivers/accel/ivpu/ivpu_pm.c
index cd4eff72f76c..8a6062bb101c 100644
--- a/drivers/accel/ivpu/ivpu_pm.c
+++ b/drivers/accel/ivpu/ivpu_pm.c
@@ -100,7 +100,7 @@ static int ivpu_resume(struct ivpu_device *vdev)
 		goto err_power_down;
 	}
 
-	ret = ivpu_boot(vdev);
+	ret = ivpu_boot(vdev, false);
 	if (ret)
 		goto err_mmu_disable;
 
diff --git a/drivers/accel/ivpu/vpu_boot_api.h b/drivers/accel/ivpu/vpu_boot_api.h
index 06c092d5e675..c0da9e9cba62 100644
--- a/drivers/accel/ivpu/vpu_boot_api.h
+++ b/drivers/accel/ivpu/vpu_boot_api.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: MIT */
 /*
- * Copyright (c) 2020-2025, Intel Corporation.
+ * Copyright (c) 2020-2026, Intel Corporation.
  */
 
 /**
@@ -36,12 +36,12 @@
  * Minor version changes when API backward compatibility is preserved.
  * Resets to 0 if Major version is incremented.
  */
-#define VPU_BOOT_API_VER_MINOR 29
+#define VPU_BOOT_API_VER_MINOR 39
 
 /**
  * API header changed (field names, documentation, formatting) but API itself has not been changed
  */
-#define VPU_BOOT_API_VER_PATCH 5
+#define VPU_BOOT_API_VER_PATCH 1
 
 /**
  * Index in the API version table
@@ -74,6 +74,10 @@ struct vpu_firmware_header {
 	/** Size of memory require for firmware execution */
 	u32 runtime_size;
 	u32 shave_nn_fw_size;
+	/*
+	 * Preemption buffer sizes in image header are deprecated post NPU50xx.
+	 * Use vpu_boot_params::preemption_buffer_size instead.
+	 */
 	/**
 	 * Size of primary preemption buffer, assuming a 2-job submission queue.
 	 * NOTE: host driver is expected to adapt size accordingly to actual
@@ -199,7 +203,7 @@ struct vpu_boot_l2_cache_config {
  * Macros to enable various power profiles within the NPU.
  * To be defined as part of 32 bit mask.
  */
-#define POWER_PROFILE_SURVIVABILITY 0x1
+#define POWER_PROFILE_SURVIVABILITY BIT(0)
 
 /**
  * Enum for dvfs_mode boot param.
@@ -209,7 +213,9 @@ enum vpu_governor {
 	VPU_GOV_MAX_PERFORMANCE = 1, /** Maximum performance governor */
 	VPU_GOV_ON_DEMAND = 2, /** On Demand frequency control governor */
 	VPU_GOV_POWER_SAVE = 3, /** Power save governor */
-	VPU_GOV_ON_DEMAND_PRIORITY_AWARE = 4 /** On Demand priority based governor */
+	VPU_GOV_ON_DEMAND_PRIORITY_AWARE = 4, /** On Demand priority based governor */
+	VPU_GOV_ON_DEMAND_PER_PRIORITY = 5, /** On Demand frequency per-priority governor */
+	VPU_GOV_ON_DEMAND_QOS = 6 /** On Demand QOS based governor */
 };
 
 struct vpu_boot_params {
@@ -239,8 +245,20 @@ struct vpu_boot_params {
 	 * On VPU2.7 HW this address must be within 2GB range starting from L2C_PAGE_TABLE base
 	 */
 	u64 shave_nn_fw_base;
-	u64 save_restore_ret_address; /** stores the address of FW's restore entry point */
-	u32 reserved_4[43];
+	/**
+	 * Firmware restore entry point used to resume from D0i3.
+	 * Set before entering D0i3 and cleared during the resume sequence.
+	 * Deprecated on NPU60xx and later; boot_type selects the warmboot path.
+	 */
+	u64 save_restore_ret_address;
+	/**
+	 * Required preemption buffer size in bytes.
+	 * Firmware writes this before signaling cold-boot completion to the host;
+	 * it is not updated afterward.
+	 * Available since NPU50xx.
+	 */
+	u32 preemption_buffer_size;
+	u32 reserved_4[42];
 	/** IRQ re-direct numbers: 0x200 - 0x2FF */
 	s32 watchdog_irq_mss;
 	s32 watchdog_irq_nce;
@@ -268,6 +286,10 @@ struct vpu_boot_params {
 	 * TODO: EISW-33556: Move log level definition (mvLog_t) to this file.
 	 */
 	u32 default_trace_level;
+	/**
+	 * Boot mode requested by the host: VPU_BOOT_TYPE_COLDBOOT or
+	 * VPU_BOOT_TYPE_WARMBOOT. Used by the boot loader on NPU60xx+.
+	 */
 	u32 boot_type;
 	u64 punit_telemetry_sram_base;
 	u64 punit_telemetry_sram_size;
-- 
2.43.0

