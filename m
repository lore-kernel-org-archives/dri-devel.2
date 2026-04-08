Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8872910F9949
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 15:05:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCDF610E69A;
	Wed,  8 Apr 2026 15:05:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="JuHmWXex";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6ABBB10E696
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 15:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775660732; x=1807196732;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=o41h5Hyng3NdNdRROSlKgUK+u57iEHd3p56Sp3SaUcE=;
 b=JuHmWXexkW+4IXAJb+9WJENzGP2YjzPhLudSk7LAQWYRZIR/jlV462rO
 1/Jps0sMPCpZFLlpqDpaVqMX4xVd3GHM5Dowl0M6+zP7XqIyVpHuFxdCa
 Rof4bLlteDaAPYxXuUK96/a9KKi3gCqqJS7QKUWgWwRyBFtbAfhQc4C0d
 LxXWE083pB7ALEgV45FwnRzbk2lyi5DZekNHyoX4uHDvNpULmgZPkukWA
 fy5fcJDiRUoIsQD6p2AOqjbn5520Au+JQyW8hvgwRVBazLYP5Lpdnnmk/
 PqaoFlNh7k30rGSfCCFet2xIREnl8Sxv9aQWldjMqg61ZTg7YcgzvwF3d g==;
X-CSE-ConnectionGUID: WIhTIUjyQiW0Ev+zNSvhjw==
X-CSE-MsgGUID: eeGLqmvmQZG8U8iHEqxg4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="88031204"
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; d="scan'208";a="88031204"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2026 08:05:32 -0700
X-CSE-ConnectionGUID: 8yF31GefSpCbqlF57CzBsg==
X-CSE-MsgGUID: mFxh0SLRSymZtpoDEOOP5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; d="scan'208";a="227495419"
Received: from akacprow-dev3.igk.intel.com ([10.91.220.47])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2026 08:05:29 -0700
From: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, jeff.hugo@oss.qualcomm.com,
 karol.wachowski@linux.intel.com, lizhi.hou@amd.com,
 maciej.falkowski@linux.intel.com,
 Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
Subject: [PATCH v3] accel/ivpu: Add support for limiting NPU frequency
Date: Wed,  8 Apr 2026 17:01:52 +0200
Message-Id: <20260408150152.2093638-1-andrzej.kacprowski@linux.intel.com>
X-Mailer: git-send-email 2.34.1
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

Add configurable frequency limits to allow users to constrain the NPU
operating frequency range for power and thermal management. This support
requires firmware API version 3.34.0 or newer.

New sysfs interface:

The freq/ subdirectory contains the following attributes:

- hw_min_freq: Minimum frequency supported by hardware (read-only)
- hw_max_freq: Maximum frequency supported by hardware (read-only)
- hw_efficient_freq: Hardware's optimal operating frequency (read-only)
- current_freq: Current NPU frequency in MHz (read-only)
- set_min_freq: Configure minimum operating frequency (50XX+ devices)
- set_max_freq: Configure maximum operating frequency (50XX+ devices)

Legacy attributes npu_max_frequency_mhz and npu_current_frequency_mhz
are maintained for backward compatibility.

Implementation details:

- Frequency configuration is communicated to firmware via JSM messages
- User-specified frequency values are clamped to hardware limits
- Power-efficient frequency (pn_ratio) is adjusted dynamically to stay
  within the configured range
- Frequency configuration is initialized during device boot
- The JSM API header is updated to version 3.34.0 to support the new
  VPU_JSM_MSG_FREQ_CONFIG firmware message

Added description for the sysfs attributes in the Documentation/ABI.

Signed-off-by: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
---
Changes in v3:
- Fixed documentation of npu_max_frequency_mhz, it is an alias for
  hw_max_freq, not hw_min_freq.
- Remove duplicate declaration of ivpu_jsm_msg_freq_config()

Changes in v2:
- Added sysfs attribute documentation in Documentation/ABI.
- Updated MAINTAINERS to include the new documentation files.

 Documentation/ABI/obsolete/sysfs-driver-ivpu |  30 +++
 Documentation/ABI/testing/sysfs-driver-ivpu  |  65 +++++++
 MAINTAINERS                                  |   2 +
 drivers/accel/ivpu/ivpu_drv.c                |   8 +-
 drivers/accel/ivpu/ivpu_hw.h                 |  16 +-
 drivers/accel/ivpu/ivpu_hw_btrs.c            | 112 ++++++++---
 drivers/accel/ivpu/ivpu_hw_btrs.h            |  10 +-
 drivers/accel/ivpu/ivpu_jsm_msg.c            |  18 +-
 drivers/accel/ivpu/ivpu_jsm_msg.h            |   3 +-
 drivers/accel/ivpu/ivpu_sysfs.c              | 186 ++++++++++++++++---
 drivers/accel/ivpu/vpu_jsm_api.h             |  34 +++-
 11 files changed, 419 insertions(+), 65 deletions(-)
 create mode 100644 Documentation/ABI/obsolete/sysfs-driver-ivpu
 create mode 100644 Documentation/ABI/testing/sysfs-driver-ivpu

diff --git a/Documentation/ABI/obsolete/sysfs-driver-ivpu b/Documentation/ABI/obsolete/sysfs-driver-ivpu
new file mode 100644
index 000000000000..b906e7149729
--- /dev/null
+++ b/Documentation/ABI/obsolete/sysfs-driver-ivpu
@@ -0,0 +1,30 @@
+What:		/sys/bus/pci/drivers/intel_vpu/.../sched_mode
+Date:		October 2024
+KernelVersion:	6.12
+Contact:	dri-devel@lists.freedesktop.org
+Description:	Current NPU scheduling mode. Returns one of the following strings:
+		- "HW" - Hardware Scheduler mode
+		- "OS" - Operating System Scheduler mode
+		Read-only.
+		Deprecated since the "OS" scheduling mode is not usable
+		and will be removed from future versions of the driver.
+		Will be removed in 2027
+
+What:		/sys/bus/pci/drivers/intel_vpu/.../npu_max_frequency_mhz
+Date:		April 2025
+KernelVersion:	6.15
+Contact:	dri-devel@lists.freedesktop.org
+Description:	Legacy alias for /sys/bus/pci/drivers/intel_vpu/.../freq/hw_max_freq.
+		Shows maximum frequency in MHz of the NPU's data processing unit.
+		Read-only.
+		Will be removed in 2027
+
+What:		/sys/bus/pci/drivers/intel_vpu/.../npu_current_frequency_mhz
+Date:		April 2025
+KernelVersion:	6.15
+Contact:	dri-devel@lists.freedesktop.org
+Description:	Legacy alias for /sys/bus/pci/drivers/intel_vpu/.../freq/current_freq.
+		Shows current frequency in MHz of the NPU's data processing unit.
+		The value is read only when the device is active; otherwise it returns 0.
+		Read-only.
+		Will be removed in 2027
diff --git a/Documentation/ABI/testing/sysfs-driver-ivpu b/Documentation/ABI/testing/sysfs-driver-ivpu
new file mode 100644
index 000000000000..91685774edfc
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-driver-ivpu
@@ -0,0 +1,65 @@
+What:		/sys/bus/pci/drivers/intel_vpu/.../npu_busy_time_us
+Date:		May 2024
+KernelVersion:	6.11
+Contact:	dri-devel@lists.freedesktop.org
+Description:	Time in microseconds that the device spent executing jobs. The time is
+		counted when and only when there are jobs submitted to firmware. This time
+		can be used to measure the utilization of NPU, either by calculating the
+		difference between two timepoints or monitoring utilization percentage by
+		reading periodically. Recommended read period is 1 second to avoid impact
+		on job submission performance. Read-only.
+
+What:		/sys/bus/pci/drivers/intel_vpu/.../npu_memory_utilization
+Date:		Jan 2025
+KernelVersion:	6.15
+Contact:	dri-devel@lists.freedesktop.org
+Description:	Current NPU memory utilization in bytes. Reports the total size of all
+		resident buffer objects allocated for NPU use. Read-only.
+
+What:		/sys/bus/pci/drivers/intel_vpu/.../freq/hw_min_freq
+Date:		April 2026
+KernelVersion:	7.2
+Contact:	dri-devel@lists.freedesktop.org
+Description:	Minimum frequency in MHz supported by the NPU hardware. This is a
+		hardware capability and cannot be changed. Read-only.
+
+What:		/sys/bus/pci/drivers/intel_vpu/.../freq/hw_efficient_freq
+Date:		April 2026
+KernelVersion:	7.2
+Contact:	dri-devel@lists.freedesktop.org
+Description:	Most efficient operating frequency in MHz for the NPU. This represents
+		the frequency at which the NPU operates most efficiently in terms of power
+		and performance. Read-only.
+
+What:		/sys/bus/pci/drivers/intel_vpu/.../freq/hw_max_freq
+Date:		April 2026
+KernelVersion:	7.2
+Contact:	dri-devel@lists.freedesktop.org
+Description:	Maximum frequency in MHz supported by the NPU hardware. This is a
+		hardware capability and cannot be changed. Read-only.
+
+What:		/sys/bus/pci/drivers/intel_vpu/.../freq/current_freq
+Date:		April 2026
+KernelVersion:	7.2
+Contact:	dri-devel@lists.freedesktop.org
+Description:	Current operating frequency in MHz of the NPU. The value is valid only
+		when the device is active; returns 0 when idle. The actual frequency may
+		be lower than the requested range due to power or thermal constraints.
+		Read-only.
+
+What:		/sys/bus/pci/drivers/intel_vpu/.../freq/set_min_freq
+Date:		April 2026
+KernelVersion:	7.2
+Contact:	dri-devel@lists.freedesktop.org
+Description:	Configured minimum operating frequency in MHz (50XX devices and newer).
+		Values written are clamped to hardware limits (hw_min_freq to hw_max_freq).
+		If set_min_freq exceeds set_max_freq, the driver clamps set_min_freq to
+		set_max_freq when selecting the operating frequency. Read-write.
+
+What:		/sys/bus/pci/drivers/intel_vpu/.../freq/set_max_freq
+Date:		April 2026
+KernelVersion:	7.2
+Contact:	dri-devel@lists.freedesktop.org
+Description:	Configured maximum operating frequency in MHz (50XX devices and newer).
+		Values written are clamped to hardware limits (hw_min_freq to hw_max_freq).
+		Read-write.
diff --git a/MAINTAINERS b/MAINTAINERS
index ae8a01f30ff4..359456c4a96e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7837,6 +7837,8 @@ M:	Karol Wachowski <karol.wachowski@linux.intel.com>
 L:	dri-devel@lists.freedesktop.org
 S:	Supported
 T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
+F:	Documentation/ABI/obsolete/sysfs-driver-ivpu
+F:	Documentation/ABI/testing/sysfs-driver-ivpu
 F:	drivers/accel/ivpu/
 F:	include/uapi/drm/ivpu_accel.h
 
diff --git a/drivers/accel/ivpu/ivpu_drv.c b/drivers/accel/ivpu/ivpu_drv.c
index 2801378e3e19..e6d631108145 100644
--- a/drivers/accel/ivpu/ivpu_drv.c
+++ b/drivers/accel/ivpu/ivpu_drv.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (C) 2020-2025 Intel Corporation
+ * Copyright (C) 2020-2026 Intel Corporation
  */
 
 #include <linux/firmware.h>
@@ -234,7 +234,7 @@ static int ivpu_get_param_ioctl(struct drm_device *dev, void *data, struct drm_f
 		args->value = vdev->platform;
 		break;
 	case DRM_IVPU_PARAM_CORE_CLOCK_RATE:
-		args->value = ivpu_hw_dpu_max_freq_get(vdev);
+		args->value = ivpu_hw_btrs_pll_ratio_to_hz(vdev, vdev->hw->pll.max_ratio);
 		break;
 	case DRM_IVPU_PARAM_NUM_CONTEXTS:
 		args->value = file_priv->user_limits->max_ctx_count;
@@ -487,6 +487,10 @@ int ivpu_boot(struct ivpu_device *vdev)
 		ret = ivpu_hw_sched_init(vdev);
 		if (ret)
 			goto err_disable_ipc;
+
+		ret = ivpu_hw_btrs_cfg_freq_init(vdev);
+		if (ret)
+			goto err_disable_ipc;
 	}
 
 	return 0;
diff --git a/drivers/accel/ivpu/ivpu_hw.h b/drivers/accel/ivpu/ivpu_hw.h
index b6d0f0d0dccc..487a918e2fa9 100644
--- a/drivers/accel/ivpu/ivpu_hw.h
+++ b/drivers/accel/ivpu/ivpu_hw.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- * Copyright (C) 2020-2025 Intel Corporation
+ * Copyright (C) 2020-2026 Intel Corporation
  */
 
 #ifndef __IVPU_HW_H__
@@ -28,6 +28,7 @@ struct ivpu_hw_info {
 		struct ivpu_addr_range dma;
 	} ranges;
 	struct {
+		/* Hardware min and max pll ratio */
 		u8 min_ratio;
 		u8 max_ratio;
 		/*
@@ -35,6 +36,9 @@ struct ivpu_hw_info {
 		 * performance to power ratio at this frequency.
 		 */
 		u8 pn_ratio;
+		/* Pll ratios configured via sysfs interface */
+		u8 cfg_min_ratio;
+		u8 cfg_max_ratio;
 		u32 profiling_freq;
 	} pll;
 	struct {
@@ -80,16 +84,6 @@ static inline u64 ivpu_hw_range_size(const struct ivpu_addr_range *range)
 	return range->end - range->start;
 }
 
-static inline u32 ivpu_hw_dpu_max_freq_get(struct ivpu_device *vdev)
-{
-	return ivpu_hw_btrs_dpu_max_freq_get(vdev);
-}
-
-static inline u32 ivpu_hw_dpu_freq_get(struct ivpu_device *vdev)
-{
-	return ivpu_hw_btrs_dpu_freq_get(vdev);
-}
-
 static inline void ivpu_hw_irq_clear(struct ivpu_device *vdev)
 {
 	ivpu_hw_ip_irq_clear(vdev);
diff --git a/drivers/accel/ivpu/ivpu_hw_btrs.c b/drivers/accel/ivpu/ivpu_hw_btrs.c
index 06e65c592618..dac935164e11 100644
--- a/drivers/accel/ivpu/ivpu_hw_btrs.c
+++ b/drivers/accel/ivpu/ivpu_hw_btrs.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (C) 2020-2025 Intel Corporation
+ * Copyright (C) 2020-2026 Intel Corporation
  */
 
 #include <linux/units.h>
@@ -11,6 +11,7 @@
 #include "ivpu_hw_btrs_lnl_reg.h"
 #include "ivpu_hw_btrs_mtl_reg.h"
 #include "ivpu_hw_reg_io.h"
+#include "ivpu_jsm_msg.h"
 #include "ivpu_pm.h"
 
 #define BTRS_MTL_IRQ_MASK ((REG_FLD(VPU_HW_BTRS_MTL_INTERRUPT_STAT, ATS_ERR)) | \
@@ -33,8 +34,7 @@
 
 #define PLL_CDYN_DEFAULT               0x80
 #define PLL_EPP_DEFAULT                0x80
-#define PLL_REF_CLK_FREQ               50000000ull
-#define PLL_RATIO_TO_FREQ(x)           ((x) * PLL_REF_CLK_FREQ)
+#define PLL_REF_CLK_FREQ_MHZ           50
 
 #define PLL_TIMEOUT_US		       (1500 * USEC_PER_MSEC)
 #define IDLE_TIMEOUT_US		       (5 * USEC_PER_MSEC)
@@ -59,8 +59,6 @@
 #define DCT_ENABLE                     0x1
 #define DCT_DISABLE                    0x0
 
-static u32 pll_ratio_to_dpu_freq(struct ivpu_device *vdev, u32 ratio);
-
 int ivpu_hw_btrs_irqs_clear_with_0_mtl(struct ivpu_device *vdev)
 {
 	REGB_WR32(VPU_HW_BTRS_MTL_INTERRUPT_STAT, BTRS_MTL_ALL_IRQ_MASK);
@@ -111,6 +109,8 @@ void ivpu_hw_btrs_freq_ratios_init(struct ivpu_device *vdev)
 	hw->pll.min_ratio = clamp_t(u8, ivpu_pll_min_ratio, hw->pll.min_ratio, hw->pll.max_ratio);
 	hw->pll.max_ratio = clamp_t(u8, ivpu_pll_max_ratio, hw->pll.min_ratio, hw->pll.max_ratio);
 	hw->pll.pn_ratio = clamp_t(u8, hw->pll.pn_ratio, hw->pll.min_ratio, hw->pll.max_ratio);
+	hw->pll.cfg_max_ratio = hw->pll.max_ratio;
+	hw->pll.cfg_min_ratio = hw->pll.min_ratio;
 }
 
 static bool tile_disable_check(u32 config)
@@ -341,8 +341,8 @@ int ivpu_hw_btrs_wp_drive(struct ivpu_device *vdev, bool enable)
 
 	prepare_wp_request(vdev, &wp, enable);
 
-	ivpu_dbg(vdev, PM, "PLL workpoint request: %lu MHz, config: 0x%x, epp: 0x%x, cdyn: 0x%x\n",
-		 pll_ratio_to_dpu_freq(vdev, wp.target) / HZ_PER_MHZ, wp.cfg, wp.epp, wp.cdyn);
+	ivpu_dbg(vdev, PM, "PLL workpoint request: %u MHz, config: 0x%x, epp: 0x%x, cdyn: 0x%x\n",
+		 ivpu_hw_btrs_pll_ratio_to_mhz(vdev, wp.target), wp.cfg, wp.epp, wp.cdyn);
 
 	ret = wp_request_send(vdev, &wp);
 	if (ret) {
@@ -598,35 +598,101 @@ static u32 pll_config_get_lnl(struct ivpu_device *vdev)
 	return REGB_RD32(VPU_HW_BTRS_LNL_PLL_FREQ);
 }
 
-static u32 pll_ratio_to_dpu_freq_mtl(u16 ratio)
+static u32 pll_ratio_to_mhz_mtl(u8 pll_ratio)
 {
-	return (PLL_RATIO_TO_FREQ(ratio) * 2) / 3;
+	return (pll_ratio * PLL_REF_CLK_FREQ_MHZ * 2) / 3;
 }
 
-static u32 pll_ratio_to_dpu_freq_lnl(u16 ratio)
+static u32 pll_ratio_to_mhz_lnl(u8 pll_ratio)
 {
-	return PLL_RATIO_TO_FREQ(ratio) / 2;
+	return (pll_ratio * PLL_REF_CLK_FREQ_MHZ) / 2;
 }
 
-static u32 pll_ratio_to_dpu_freq(struct ivpu_device *vdev, u32 ratio)
+u32 ivpu_hw_btrs_pll_ratio_to_mhz(struct ivpu_device *vdev, u8 pll_ratio)
 {
 	if (ivpu_hw_btrs_gen(vdev) == IVPU_HW_BTRS_MTL)
-		return pll_ratio_to_dpu_freq_mtl(ratio);
+		return pll_ratio_to_mhz_mtl(pll_ratio);
 	else
-		return pll_ratio_to_dpu_freq_lnl(ratio);
+		return pll_ratio_to_mhz_lnl(pll_ratio);
 }
 
-u32 ivpu_hw_btrs_dpu_max_freq_get(struct ivpu_device *vdev)
+u32 ivpu_hw_btrs_pll_ratio_to_hz(struct ivpu_device *vdev, u8 pll_ratio)
 {
-	return pll_ratio_to_dpu_freq(vdev, vdev->hw->pll.max_ratio);
+	return ivpu_hw_btrs_pll_ratio_to_mhz(vdev, pll_ratio) * HZ_PER_MHZ;
 }
 
-u32 ivpu_hw_btrs_dpu_freq_get(struct ivpu_device *vdev)
+u32 ivpu_hw_btrs_current_freq_get(struct ivpu_device *vdev)
 {
 	if (ivpu_hw_btrs_gen(vdev) == IVPU_HW_BTRS_MTL)
-		return pll_ratio_to_dpu_freq_mtl(pll_config_get_mtl(vdev));
+		return pll_ratio_to_mhz_mtl(pll_config_get_mtl(vdev));
 	else
-		return pll_ratio_to_dpu_freq_lnl(pll_config_get_lnl(vdev));
+		return pll_ratio_to_mhz_lnl(pll_config_get_lnl(vdev));
+}
+
+static int ivpu_hw_btrs_cfg_freq_set(struct ivpu_device *vdev, u8 cfg_min_ratio, u8 cfg_max_ratio)
+{
+	u8 min_ratio = clamp_t(u8, cfg_min_ratio, vdev->hw->pll.min_ratio, cfg_max_ratio);
+	u8 pn_ratio = clamp_t(u8, vdev->hw->pll.pn_ratio, min_ratio, cfg_max_ratio);
+	int ret;
+
+	ivpu_dbg(vdev, PM, "Set frequency range to min: %u, pn: %u, max: %u MHz\n",
+		 ivpu_hw_btrs_pll_ratio_to_mhz(vdev, min_ratio),
+		 ivpu_hw_btrs_pll_ratio_to_mhz(vdev, pn_ratio),
+		 ivpu_hw_btrs_pll_ratio_to_mhz(vdev, cfg_max_ratio));
+
+	ret = ivpu_rpm_get(vdev);
+	if (ret < 0)
+		return ret;
+
+	ret = ivpu_jsm_msg_freq_config(vdev, min_ratio, pn_ratio, cfg_max_ratio);
+	ivpu_rpm_put(vdev);
+
+	if (ret) {
+		ivpu_warn(vdev,
+			  "Failed to set frequency to min: %u, pn: %u, max: %u MHz, ret %d\n",
+			  ivpu_hw_btrs_pll_ratio_to_mhz(vdev, min_ratio),
+			  ivpu_hw_btrs_pll_ratio_to_mhz(vdev, pn_ratio),
+			  ivpu_hw_btrs_pll_ratio_to_mhz(vdev, cfg_max_ratio),
+			  ret);
+		return ret;
+	}
+
+	vdev->hw->pll.cfg_min_ratio = cfg_min_ratio;
+	vdev->hw->pll.cfg_max_ratio = cfg_max_ratio;
+
+	return 0;
+}
+
+static u8 dpu_mhz_to_pll_ratio_lnl(u32 freq_mhz)
+{
+	return clamp_t(u32, freq_mhz / (PLL_REF_CLK_FREQ_MHZ / 2), 0, U8_MAX);
+}
+
+int ivpu_hw_btrs_cfg_max_freq_set(struct ivpu_device *vdev, u32 max_freq_mhz)
+{
+	u8 ratio = dpu_mhz_to_pll_ratio_lnl(max_freq_mhz);
+	u8 cfg_max_ratio = clamp_t(u8, ratio, vdev->hw->pll.min_ratio, vdev->hw->pll.max_ratio);
+
+	return ivpu_hw_btrs_cfg_freq_set(vdev, vdev->hw->pll.cfg_min_ratio, cfg_max_ratio);
+}
+
+int ivpu_hw_btrs_cfg_min_freq_set(struct ivpu_device *vdev, u32 min_freq_mhz)
+{
+	u8 ratio = dpu_mhz_to_pll_ratio_lnl(min_freq_mhz);
+	u8 cfg_min_ratio = clamp_t(u8, ratio, vdev->hw->pll.min_ratio, vdev->hw->pll.max_ratio);
+
+	return ivpu_hw_btrs_cfg_freq_set(vdev, cfg_min_ratio, vdev->hw->pll.cfg_max_ratio);
+}
+
+int ivpu_hw_btrs_cfg_freq_init(struct ivpu_device *vdev)
+{
+	if (vdev->hw->pll.min_ratio == vdev->hw->pll.cfg_min_ratio &&
+	    vdev->hw->pll.max_ratio == vdev->hw->pll.cfg_max_ratio)
+		return 0;
+
+	return ivpu_hw_btrs_cfg_freq_set(vdev,
+					 vdev->hw->pll.cfg_min_ratio,
+					 vdev->hw->pll.cfg_max_ratio);
 }
 
 /* Handler for IRQs from Buttress core (irqB) */
@@ -641,8 +707,8 @@ bool ivpu_hw_btrs_irq_handler_mtl(struct ivpu_device *vdev, int irq)
 	if (REG_TEST_FLD(VPU_HW_BTRS_MTL_INTERRUPT_STAT, FREQ_CHANGE, status)) {
 		u32 pll = pll_config_get_mtl(vdev);
 
-		ivpu_dbg(vdev, IRQ, "FREQ_CHANGE irq, wp %08x, %lu MHz",
-			 pll, pll_ratio_to_dpu_freq_mtl(pll) / HZ_PER_MHZ);
+		ivpu_dbg(vdev, IRQ, "FREQ_CHANGE irq, wp %08x, %u MHz",
+			 pll, pll_ratio_to_mhz_mtl(pll));
 	}
 
 	if (REG_TEST_FLD(VPU_HW_BTRS_MTL_INTERRUPT_STAT, ATS_ERR, status)) {
@@ -695,8 +761,8 @@ bool ivpu_hw_btrs_irq_handler_lnl(struct ivpu_device *vdev, int irq)
 	if (REG_TEST_FLD(VPU_HW_BTRS_LNL_INTERRUPT_STAT, FREQ_CHANGE, status)) {
 		u32 pll = pll_config_get_lnl(vdev);
 
-		ivpu_dbg(vdev, IRQ, "FREQ_CHANGE irq, wp %08x, %lu MHz",
-			 pll, pll_ratio_to_dpu_freq_lnl(pll) / HZ_PER_MHZ);
+		ivpu_dbg(vdev, IRQ, "FREQ_CHANGE irq, wp %08x, %u MHz",
+			 pll, pll_ratio_to_mhz_lnl(pll));
 	}
 
 	if (REG_TEST_FLD(VPU_HW_BTRS_LNL_INTERRUPT_STAT, ATS_ERR, status)) {
diff --git a/drivers/accel/ivpu/ivpu_hw_btrs.h b/drivers/accel/ivpu/ivpu_hw_btrs.h
index c4c10e22f30f..d6343d734570 100644
--- a/drivers/accel/ivpu/ivpu_hw_btrs.h
+++ b/drivers/accel/ivpu/ivpu_hw_btrs.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- * Copyright (C) 2020-2025 Intel Corporation
+ * Copyright (C) 2020-2026 Intel Corporation
  */
 
 #ifndef __IVPU_HW_BTRS_H__
@@ -31,8 +31,12 @@ int ivpu_hw_btrs_ip_reset(struct ivpu_device *vdev);
 void ivpu_hw_btrs_profiling_freq_reg_set_lnl(struct ivpu_device *vdev);
 void ivpu_hw_btrs_ats_print_lnl(struct ivpu_device *vdev);
 void ivpu_hw_btrs_clock_relinquish_disable_lnl(struct ivpu_device *vdev);
-u32 ivpu_hw_btrs_dpu_max_freq_get(struct ivpu_device *vdev);
-u32 ivpu_hw_btrs_dpu_freq_get(struct ivpu_device *vdev);
+u32 ivpu_hw_btrs_pll_ratio_to_mhz(struct ivpu_device *vdev, u8 pll_ratio);
+u32 ivpu_hw_btrs_pll_ratio_to_hz(struct ivpu_device *vdev, u8 pll_ratio);
+u32 ivpu_hw_btrs_current_freq_get(struct ivpu_device *vdev);
+int ivpu_hw_btrs_cfg_min_freq_set(struct ivpu_device *vdev, u32 freq_mhz);
+int ivpu_hw_btrs_cfg_max_freq_set(struct ivpu_device *vdev, u32 freq_mhz);
+int ivpu_hw_btrs_cfg_freq_init(struct ivpu_device *vdev);
 bool ivpu_hw_btrs_irq_handler_mtl(struct ivpu_device *vdev, int irq);
 bool ivpu_hw_btrs_irq_handler_lnl(struct ivpu_device *vdev, int irq);
 int ivpu_hw_btrs_dct_get_request(struct ivpu_device *vdev, bool *enable);
diff --git a/drivers/accel/ivpu/ivpu_jsm_msg.c b/drivers/accel/ivpu/ivpu_jsm_msg.c
index 07b1d6f615a9..17b42a76aef9 100644
--- a/drivers/accel/ivpu/ivpu_jsm_msg.c
+++ b/drivers/accel/ivpu/ivpu_jsm_msg.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (C) 2020-2024 Intel Corporation
+ * Copyright (C) 2020-2026 Intel Corporation
  */
 
 #include "ivpu_drv.h"
@@ -86,6 +86,9 @@ const char *ivpu_jsm_msg_type_to_str(enum vpu_ipc_msg_type type)
 	IVPU_CASE_TO_STR(VPU_JSM_MSG_DCT_ENABLE_DONE);
 	IVPU_CASE_TO_STR(VPU_JSM_MSG_DCT_DISABLE);
 	IVPU_CASE_TO_STR(VPU_JSM_MSG_DCT_DISABLE_DONE);
+	IVPU_CASE_TO_STR(VPU_JSM_MSG_FREQ_CONFIG);
+	IVPU_CASE_TO_STR(VPU_JSM_MSG_FREQ_CONFIG_RSP);
+	IVPU_CASE_TO_STR(VPU_JSM_MSG_RESERVED_111E);
 	}
 	#undef IVPU_CASE_TO_STR
 
@@ -571,3 +574,16 @@ int ivpu_jsm_state_dump_no_reply(struct ivpu_device *vdev)
 	return ivpu_ipc_send_and_wait(vdev, &req, VPU_IPC_CHAN_ASYNC_CMD,
 				      vdev->timeout.state_dump_msg);
 }
+
+int ivpu_jsm_msg_freq_config(struct ivpu_device *vdev, u16 min_ratio, u16 pn_ratio, u16 max_ratio)
+{
+	struct vpu_jsm_msg req = { .type = VPU_JSM_MSG_FREQ_CONFIG};
+	struct vpu_jsm_msg resp;
+
+	req.payload.freq_config.min_freq_pll_ratio = min_ratio;
+	req.payload.freq_config.pn_freq_pll_ratio = pn_ratio;
+	req.payload.freq_config.max_freq_pll_ratio = max_ratio;
+
+	return ivpu_ipc_send_receive_internal(vdev, &req, VPU_JSM_MSG_FREQ_CONFIG_RSP, &resp,
+					      VPU_IPC_CHAN_ASYNC_CMD, vdev->timeout.jsm);
+}
diff --git a/drivers/accel/ivpu/ivpu_jsm_msg.h b/drivers/accel/ivpu/ivpu_jsm_msg.h
index a74f5a0b0d93..28ffe07422b0 100644
--- a/drivers/accel/ivpu/ivpu_jsm_msg.h
+++ b/drivers/accel/ivpu/ivpu_jsm_msg.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- * Copyright (C) 2020-2024 Intel Corporation
+ * Copyright (C) 2020-2026 Intel Corporation
  */
 
 #ifndef __IVPU_JSM_MSG_H__
@@ -45,5 +45,6 @@ int ivpu_jsm_dct_enable(struct ivpu_device *vdev, u32 active_us, u32 inactive_us
 int ivpu_jsm_dct_disable(struct ivpu_device *vdev);
 int ivpu_jsm_state_dump(struct ivpu_device *vdev);
 int ivpu_jsm_state_dump_no_reply(struct ivpu_device *vdev);
+int ivpu_jsm_msg_freq_config(struct ivpu_device *vdev, u16 min_ratio, u16 pn_ratio, u16 max_ratio);
 
 #endif
diff --git a/drivers/accel/ivpu/ivpu_sysfs.c b/drivers/accel/ivpu/ivpu_sysfs.c
index d250a10caca9..95d201b3b8aa 100644
--- a/drivers/accel/ivpu/ivpu_sysfs.c
+++ b/drivers/accel/ivpu/ivpu_sysfs.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (C) 2024-2025 Intel Corporation
+ * Copyright (C) 2024-2026 Intel Corporation
  */
 
 #include <linux/device.h>
@@ -82,8 +82,7 @@ static DEVICE_ATTR_RO(npu_memory_utilization);
  * - "OS"		- Operating System Scheduler mode
  *
  */
-static ssize_t
-sched_mode_show(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t sched_mode_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct drm_device *drm = dev_get_drvdata(dev);
 	struct ivpu_device *vdev = to_ivpu_device(drm);
@@ -94,47 +93,162 @@ sched_mode_show(struct device *dev, struct device_attribute *attr, char *buf)
 static DEVICE_ATTR_RO(sched_mode);
 
 /**
- * DOC: npu_max_frequency
+ * DOC: NPU frequency control and information
+ *
+ * Hardware frequency capabilities:
+ * freq/hw_min_freq - Minimum frequency supported by the NPU hardware.
+ * freq/hw_max_freq - Maximum frequency supported by the NPU hardware.
+ * freq/hw_efficient_freq - Most efficient operating frequency for the NPU.
+ *
+ * Configurable frequency limits (50XX devices and newer):
+ * freq/set_min_freq - Configured minimum operating frequency.
+ * freq/set_max_freq - Configured maximum operating frequency.
+ *
+ * Clamping behavior: Values written to set_min_freq and set_max_freq are
+ * clamped to hardware limits. If set_min_freq exceeds set_max_freq, the driver
+ * clamps set_min_freq to set_max_freq when selecting the operating frequency.
+ *
+ * Current operating frequency:
+ * freq/current_freq - Current frequency in MHz. Valid only when the device is
+ * active; returns 0 when idle. May be lower than the requested range due to
+ * power or thermal constraints.
  *
- * The npu_max_frequency shows maximum frequency in MHz of the NPU's data
- * processing unit
+ * Legacy attributes (backward compatibility):
+ * npu_max_frequency_mhz - Alias for freq/hw_max_freq.
+ * npu_current_frequency_mhz - Alias for freq/current_freq.
  */
+
+static ssize_t hw_min_freq_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct drm_device *drm = dev_get_drvdata(dev);
+	struct ivpu_device *vdev = to_ivpu_device(drm);
+	u32 freq_mhz = ivpu_hw_btrs_pll_ratio_to_mhz(vdev, vdev->hw->pll.min_ratio);
+
+	return sysfs_emit(buf, "%u\n", freq_mhz);
+}
+
+static DEVICE_ATTR_RO(hw_min_freq);
+
+static ssize_t hw_efficient_freq_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct drm_device *drm = dev_get_drvdata(dev);
+	struct ivpu_device *vdev = to_ivpu_device(drm);
+	u32 freq_mhz = ivpu_hw_btrs_pll_ratio_to_mhz(vdev, vdev->hw->pll.pn_ratio);
+
+	return sysfs_emit(buf, "%u\n", freq_mhz);
+}
+
+static DEVICE_ATTR_RO(hw_efficient_freq);
+
+static ssize_t hw_max_freq_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct drm_device *drm = dev_get_drvdata(dev);
+	struct ivpu_device *vdev = to_ivpu_device(drm);
+	u32 freq_mhz = ivpu_hw_btrs_pll_ratio_to_mhz(vdev, vdev->hw->pll.max_ratio);
+
+	return sysfs_emit(buf, "%u\n", freq_mhz);
+}
+
+static DEVICE_ATTR_RO(hw_max_freq);
+
+static ssize_t set_min_freq_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct drm_device *drm = dev_get_drvdata(dev);
+	struct ivpu_device *vdev = to_ivpu_device(drm);
+	u32 freq_mhz = ivpu_hw_btrs_pll_ratio_to_mhz(vdev, vdev->hw->pll.cfg_min_ratio);
+
+	return sysfs_emit(buf, "%u\n", freq_mhz);
+}
+
 static ssize_t
-npu_max_frequency_mhz_show(struct device *dev, struct device_attribute *attr, char *buf)
+set_min_freq_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct drm_device *drm = dev_get_drvdata(dev);
 	struct ivpu_device *vdev = to_ivpu_device(drm);
-	u32 freq = ivpu_hw_dpu_max_freq_get(vdev);
+	u32 freq_mhz;
+	int ret;
+
+	ret = kstrtou32(buf, 10, &freq_mhz);
+	if (ret)
+		return ret;
 
-	return sysfs_emit(buf, "%lu\n", freq / HZ_PER_MHZ);
+	ret = ivpu_hw_btrs_cfg_min_freq_set(vdev, freq_mhz);
+	if (ret)
+		return ret;
+
+	return count;
 }
 
-static DEVICE_ATTR_RO(npu_max_frequency_mhz);
+static DEVICE_ATTR_RW(set_min_freq);
+
+static ssize_t set_max_freq_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct drm_device *drm = dev_get_drvdata(dev);
+	struct ivpu_device *vdev = to_ivpu_device(drm);
+	u32 freq_mhz = ivpu_hw_btrs_pll_ratio_to_mhz(vdev, vdev->hw->pll.cfg_max_ratio);
+
+	return sysfs_emit(buf, "%u\n", freq_mhz);
+}
 
-/**
- * DOC: npu_current_frequency_mhz
- *
- * The npu_current_frequency_mhz shows current frequency in MHz of the NPU's
- * data processing unit
- */
 static ssize_t
-npu_current_frequency_mhz_show(struct device *dev, struct device_attribute *attr, char *buf)
+set_max_freq_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct drm_device *drm = dev_get_drvdata(dev);
+	struct ivpu_device *vdev = to_ivpu_device(drm);
+	u32 freq_mhz;
+	int ret;
+
+	ret = kstrtou32(buf, 10, &freq_mhz);
+	if (ret)
+		return ret;
+
+	/* Convert MHz to Hz and set max frequency */
+	ret = ivpu_hw_btrs_cfg_max_freq_set(vdev, freq_mhz);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static DEVICE_ATTR_RW(set_max_freq);
+
+static ssize_t current_freq_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct drm_device *drm = dev_get_drvdata(dev);
 	struct ivpu_device *vdev = to_ivpu_device(drm);
-	u32 freq = 0;
+	u32 freq_mhz = 0;
 
 	/* Read frequency only if device is active, otherwise frequency is 0 */
 	if (pm_runtime_get_if_active(vdev->drm.dev) > 0) {
-		freq = ivpu_hw_dpu_freq_get(vdev);
+		freq_mhz = ivpu_hw_btrs_current_freq_get(vdev);
 
 		pm_runtime_put_autosuspend(vdev->drm.dev);
 	}
 
-	return sysfs_emit(buf, "%lu\n", freq / HZ_PER_MHZ);
+	return sysfs_emit(buf, "%u\n", freq_mhz);
 }
 
-static DEVICE_ATTR_RO(npu_current_frequency_mhz);
+static DEVICE_ATTR_RO(current_freq);
+
+/* Alias to current_freq for legacy compat */
+static struct device_attribute dev_attr_npu_max_frequency_mhz =
+	__ATTR(npu_max_frequency_mhz, 0444, hw_max_freq_show, NULL);
+
+static struct device_attribute dev_attr_npu_current_frequency_mhz =
+	__ATTR(npu_current_frequency_mhz, 0444, current_freq_show, NULL);
+
+static struct attribute *ivpu_freq_attrs[] = {
+	&dev_attr_hw_min_freq.attr,
+	&dev_attr_hw_efficient_freq.attr,
+	&dev_attr_hw_max_freq.attr,
+	&dev_attr_current_freq.attr,
+	NULL,
+};
+
+static struct attribute_group ivpu_freq_attr_group = {
+	.name = "freq",
+	.attrs = ivpu_freq_attrs,
+};
 
 static struct attribute *ivpu_dev_attrs[] = {
 	&dev_attr_npu_busy_time_us.attr,
@@ -154,6 +268,32 @@ void ivpu_sysfs_init(struct ivpu_device *vdev)
 	int ret;
 
 	ret = devm_device_add_group(vdev->drm.dev, &ivpu_dev_attr_group);
-	if (ret)
-		ivpu_warn(vdev, "Failed to add group to device, ret %d", ret);
+	if (ret) {
+		ivpu_warn(vdev, "Failed to add sysfs group to device, ret %d", ret);
+		return;
+	}
+
+	ret = devm_device_add_group(vdev->drm.dev, &ivpu_freq_attr_group);
+	if (ret) {
+		ivpu_warn(vdev, "Failed to add sysfs freq group, ret %d", ret);
+		return;
+	}
+
+	if (ivpu_hw_ip_gen(vdev) >= IVPU_HW_IP_50XX) {
+		ret = sysfs_add_file_to_group(&vdev->drm.dev->kobj,
+					      &dev_attr_set_min_freq.attr,
+					      "freq");
+		if (ret) {
+			ivpu_warn(vdev, "Failed to add sysfs set_min_freq to device, ret %d", ret);
+			return;
+		}
+
+		ret = sysfs_add_file_to_group(&vdev->drm.dev->kobj,
+					      &dev_attr_set_max_freq.attr,
+					      "freq");
+		if (ret) {
+			ivpu_warn(vdev, "Failed to add sysfs set_max_freq to device, ret %d", ret);
+			return;
+		}
+	}
 }
diff --git a/drivers/accel/ivpu/vpu_jsm_api.h b/drivers/accel/ivpu/vpu_jsm_api.h
index bca6a44dc041..6d58d04cc0c4 100644
--- a/drivers/accel/ivpu/vpu_jsm_api.h
+++ b/drivers/accel/ivpu/vpu_jsm_api.h
@@ -23,7 +23,7 @@
 /*
  * Minor version changes when API backward compatibility is preserved.
  */
-#define VPU_JSM_API_VER_MINOR 33
+#define VPU_JSM_API_VER_MINOR 34
 
 /*
  * API header changed (field names, documentation, formatting) but API itself has not been changed
@@ -604,6 +604,16 @@ enum vpu_ipc_msg_type {
 	 * This command has no payload
 	 */
 	VPU_JSM_MSG_DCT_DISABLE = 0x111d,
+	/**
+	 * Reserved command ID to ensure that the following command requests /
+	 * responses have the same lower byte value.
+	 */
+	VPU_JSM_MSG_RESERVED_111E = 0x111e,
+	/**
+	 * Control command: Configure VPU frequency scaling parameters.
+	 * @see vpu_ipc_msg_payload_freq_config
+	 */
+	VPU_JSM_MSG_FREQ_CONFIG = 0x111f,
 	/**
 	 * Dump VPU state. To be used for debug purposes only.
 	 * This command has no payload.
@@ -766,6 +776,11 @@ enum vpu_ipc_msg_type {
 	 * This command has no payload
 	 */
 	VPU_JSM_MSG_DCT_DISABLE_DONE = 0x221e,
+	/**
+	 * Response to control command: Configure VPU frequency scaling parameters.
+	 * @see vpu_ipc_msg_payload_freq_config
+	 */
+	VPU_JSM_MSG_FREQ_CONFIG_RSP = 0x221f,
 	/**
 	 * Response to state dump control command.
 	 * This command has no payload.
@@ -1650,6 +1665,22 @@ struct vpu_ipc_msg_payload_pwr_dct_control {
 	u32 dct_inactive_us;
 };
 
+/**
+ * Payload for @ref VPU_JSM_MSG_FREQ_CONFIG message.
+ *
+ * This payload allows the host to configure the VPU frequency scaling parameters.
+ */
+struct vpu_ipc_msg_payload_freq_config {
+	/** Minimum frequency PLL ratio */
+	u32 min_freq_pll_ratio;
+	/** Efficiency frequency PLL ratio */
+	u32 pn_freq_pll_ratio;
+	/** Maximum frequency PLL ratio */
+	u32 max_freq_pll_ratio;
+	/** Reserved for 64-bit alignment */
+	u32 reserved_0;
+};
+
 /*
  * Payloads union, used to define complete message format.
  */
@@ -1692,6 +1723,7 @@ union vpu_ipc_msg_payload {
 	struct vpu_ipc_msg_payload_hws_resume_engine hws_resume_engine;
 	struct vpu_ipc_msg_payload_pwr_d0i3_enter pwr_d0i3_enter;
 	struct vpu_ipc_msg_payload_pwr_dct_control pwr_dct_control;
+	struct vpu_ipc_msg_payload_freq_config freq_config;
 };
 
 /**
-- 
2.34.1

