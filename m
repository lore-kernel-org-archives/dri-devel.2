Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA9FFCA9EC5
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 08:10:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8E6410E4BD;
	Mon, 12 Oct 2026 08:10:01 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 729D810E4BD
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 08:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791792596; x=1823328596;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=9aySwfCV9mefKC6QFh+0OUDmAUyvQdnN5yt3e9/c4WI=;
 b=ID0hhVhlKBK5h7ixbKa1TVjZeQ+X448gY3acvKNAe9TgpI/H0F5bNDFc
 qj2i+EIvl/mMwjasaYbMwp5TZSuMKjZnEU389BkgxiylF0aG6uviPID9p
 vHHNqfFEDfqcwK51KS/tWiNEKtn51OsFuv3HHxzSb7f22Zvsbgv2OpsVV
 LSg9E3n5kRy75bcpu70eGOnxQBUpnCa+hn51TGh4xPAVzdeGKG7AVw6ap
 ZclQg+xm1qDxwMf6okDrN+a1LLUDv9D2gPlyeOh7sGQIwjENLS6b25PYv
 c3khTT2hCUnWrbC3d68WGQgGeJ7Mbn/Nr0wcVmFVxpkbcB3fFM/wBzdVR g==;
X-CSE-ConnectionGUID: At5h+1DdQHmMqiWeiu0Dbg==
X-CSE-MsgGUID: R/8zG7enQUeFQJnr+rP4KQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11932"; a="371342"
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="371342"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2026 01:09:55 -0700
X-CSE-ConnectionGUID: Y++DDVkZRxaURbk9y1plgQ==
X-CSE-MsgGUID: 850XcDaJRAuuBAVWcpAwzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="809163"
Received: from pl-npu-pc-kwachow.igk.intel.com ([10.91.220.239])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2026 01:09:39 -0700
From: Karol Wachowski <karol.wachowski@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, jeff.hugo@oss.qualcomm.com, lizhi.hou@amd.com,
 andrzej.kacprowski@linux.intel.com, dawid.osuchowski@linux.intel.com,
 Karol Wachowski <karol.wachowski@linux.intel.com>
Subject: [PATCH] accel/ivpu: Cache FW API version and simplify API check macros
Date: Mon, 12 Oct 2026 10:09:33 +0200
Message-ID: <20261012080933.2771862-1-karol.wachowski@linux.intel.com>
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

Copy the API version array from the firmware image header into
struct ivpu_fw_info while the header is being parsed, and use the
cached copy afterwards. This way the raw firmware image header is only
accessed during image parsing, which is a step towards releasing the
firmware image once it has been loaded.

Since the API version is now available in vdev->fw before the
compatibility checks run, drop the redundant fw_hdr parameter from
IVPU_FW_CHECK_API_COMPAT(), IVPU_FW_CHECK_API_VER_LT() and the helpers
behind them, as well as from ivpu_fw_sched_mode_select().

Also make DRM_IVPU_PARAM_FW_API_VERSION read the cached copy instead of
dereferencing the firmware image directly.

No functional change.

Co-developed-by: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
Signed-off-by: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
Signed-off-by: Karol Wachowski <karol.wachowski@linux.intel.com>
---
 drivers/accel/ivpu/ivpu_drv.c |  5 +----
 drivers/accel/ivpu/ivpu_fw.c  | 36 +++++++++++++++++------------------
 drivers/accel/ivpu/ivpu_fw.h  |  1 +
 3 files changed, 20 insertions(+), 22 deletions(-)

diff --git a/drivers/accel/ivpu/ivpu_drv.c b/drivers/accel/ivpu/ivpu_drv.c
index 8c3fb0f01a31..ada18a36caef 100644
--- a/drivers/accel/ivpu/ivpu_drv.c
+++ b/drivers/accel/ivpu/ivpu_drv.c
@@ -290,10 +290,7 @@ static int ivpu_get_param_ioctl(struct drm_device *dev, void *data, struct drm_f
 		break;
 	case DRM_IVPU_PARAM_FW_API_VERSION:
 		if (args->index < VPU_FW_API_VER_NUM) {
-			struct vpu_firmware_header *fw_hdr;
-
-			fw_hdr = (struct vpu_firmware_header *)vdev->fw->file->data;
-			args->value = fw_hdr->api_version[args->index];
+			args->value = vdev->fw->api_version[args->index];
 		} else {
 			ret = -EINVAL;
 		}
diff --git a/drivers/accel/ivpu/ivpu_fw.c b/drivers/accel/ivpu/ivpu_fw.c
index f9ddaa2420c4..71ac0a861935 100644
--- a/drivers/accel/ivpu/ivpu_fw.c
+++ b/drivers/accel/ivpu/ivpu_fw.c
@@ -28,15 +28,15 @@
 #define ADDR_TO_L2_CACHE_CFG(addr) ((addr) >> 31)
 
 /* Check if FW API is compatible with the driver */
-#define IVPU_FW_CHECK_API_COMPAT(vdev, fw_hdr, name, min_major) \
-	ivpu_fw_check_api(vdev, fw_hdr, #name, \
+#define IVPU_FW_CHECK_API_COMPAT(vdev, name, min_major) \
+	ivpu_fw_check_api(vdev, #name, \
 			  VPU_##name##_API_VER_INDEX, \
 			  VPU_##name##_API_VER_MAJOR, \
 			  VPU_##name##_API_VER_MINOR, min_major)
 
 /* Check if API version is lower that the given version */
-#define IVPU_FW_CHECK_API_VER_LT(vdev, fw_hdr, name, major, minor) \
-	ivpu_fw_check_api_ver_lt(vdev, fw_hdr, #name, VPU_##name##_API_VER_INDEX, major, minor)
+#define IVPU_FW_CHECK_API_VER_LT(vdev, name, major, minor) \
+	ivpu_fw_check_api_ver_lt(vdev, #name, VPU_##name##_API_VER_INDEX, major, minor)
 
 #define IVPU_FOCUS_PRESENT_TIMER_MS 1000
 
@@ -93,12 +93,11 @@ static int ivpu_fw_request(struct ivpu_device *vdev)
 }
 
 static int
-ivpu_fw_check_api(struct ivpu_device *vdev, const struct vpu_firmware_header *fw_hdr,
-		  const char *str, int index, u16 expected_major, u16 expected_minor,
-		  u16 min_major)
+ivpu_fw_check_api(struct ivpu_device *vdev, const char *str, int index, u16 expected_major,
+		  u16 expected_minor, u16 min_major)
 {
-	u16 major = (u16)(fw_hdr->api_version[index] >> 16);
-	u16 minor = (u16)(fw_hdr->api_version[index]);
+	u16 major = (u16)(vdev->fw->api_version[index] >> 16);
+	u16 minor = (u16)(vdev->fw->api_version[index]);
 
 	if (major < min_major) {
 		ivpu_err(vdev, "Incompatible FW %s API version: %d.%d, required %d.0 or later\n",
@@ -116,11 +115,10 @@ ivpu_fw_check_api(struct ivpu_device *vdev, const struct vpu_firmware_header *fw
 }
 
 static bool
-ivpu_fw_check_api_ver_lt(struct ivpu_device *vdev, const struct vpu_firmware_header *fw_hdr,
-			 const char *str, int index, u16 major, u16 minor)
+ivpu_fw_check_api_ver_lt(struct ivpu_device *vdev, const char *str, int index, u16 major, u16 minor)
 {
-	u16 fw_major = (u16)(fw_hdr->api_version[index] >> 16);
-	u16 fw_minor = (u16)(fw_hdr->api_version[index]);
+	u16 fw_major = (u16)(vdev->fw->api_version[index] >> 16);
+	u16 fw_minor = (u16)(vdev->fw->api_version[index]);
 
 	if (fw_major < major || (fw_major == major && fw_minor < minor))
 		return true;
@@ -142,7 +140,7 @@ bool ivpu_is_within_range(u64 addr, size_t size, struct ivpu_addr_range *range)
 }
 
 static u32
-ivpu_fw_sched_mode_select(struct ivpu_device *vdev, const struct vpu_firmware_header *fw_hdr)
+ivpu_fw_sched_mode_select(struct ivpu_device *vdev)
 {
 	if (ivpu_hw_ip_gen(vdev) >= IVPU_HW_IP_60XX &&
 	    ivpu_sched_mode == VPU_SCHEDULING_MODE_OS) {
@@ -153,7 +151,7 @@ ivpu_fw_sched_mode_select(struct ivpu_device *vdev, const struct vpu_firmware_he
 	if (ivpu_sched_mode != IVPU_SCHED_MODE_AUTO)
 		return ivpu_sched_mode;
 
-	if (IVPU_FW_CHECK_API_VER_LT(vdev, fw_hdr, JSM, 3, 24))
+	if (IVPU_FW_CHECK_API_VER_LT(vdev, JSM, 3, 24))
 		return VPU_SCHEDULING_MODE_OS;
 
 	return VPU_SCHEDULING_MODE_HW;
@@ -302,9 +300,11 @@ static int ivpu_fw_parse(struct ivpu_device *vdev)
 
 	ivpu_info(vdev, "Firmware: %s, version: %s\n", fw->name, fw->version);
 
-	if (IVPU_FW_CHECK_API_COMPAT(vdev, fw_hdr, BOOT, 3))
+	memcpy(fw->api_version, fw_hdr->api_version, sizeof(fw->api_version));
+
+	if (IVPU_FW_CHECK_API_COMPAT(vdev, BOOT, 3))
 		return -EINVAL;
-	if (IVPU_FW_CHECK_API_COMPAT(vdev, fw_hdr, JSM, 3))
+	if (IVPU_FW_CHECK_API_COMPAT(vdev, JSM, 3))
 		return -EINVAL;
 
 	fw->boot_params_addr = boot_params_addr;
@@ -324,7 +324,7 @@ static int ivpu_fw_parse(struct ivpu_device *vdev)
 
 	fw->dvfs_mode = 0;
 
-	fw->sched_mode = ivpu_fw_sched_mode_select(vdev, fw_hdr);
+	fw->sched_mode = ivpu_fw_sched_mode_select(vdev);
 	ivpu_info(vdev, "Scheduler mode: %s\n", fw->sched_mode ? "HW" : "OS");
 
 	ivpu_preemption_config_parse(vdev, fw_hdr);
diff --git a/drivers/accel/ivpu/ivpu_fw.h b/drivers/accel/ivpu/ivpu_fw.h
index d3c410912c9c..e7045b47dfaf 100644
--- a/drivers/accel/ivpu/ivpu_fw.h
+++ b/drivers/accel/ivpu/ivpu_fw.h
@@ -20,6 +20,7 @@ struct ivpu_fw_info {
 	const struct firmware *file;
 	const char *name;
 	char version[FW_VERSION_STR_SIZE];
+	u32 api_version[VPU_FW_API_VER_NUM];
 	struct ivpu_bo *mem_bp;
 	struct ivpu_bo *mem_fw_ver;
 	struct ivpu_bo *mem;
-- 
2.43.0

