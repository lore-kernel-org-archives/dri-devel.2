Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CAE8606A31F
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 04:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=imgtec.com header.i=@imgtec.com header.a=rsa-sha256 header.s=dk201812 header.b=M8OnpaH1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D54010E27F;
	Mon, 26 Oct 2026 04:57:39 +0000 (UTC)
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D60E10E27F;
 Mon, 26 Oct 2026 04:57:33 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69Q4doPJ2391863; Mon, 26 Oct 2026 04:57:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=dk201812; bh=8fu43DNA2RG8i02HeOjlRKt
 PZ4P9JA9dEbuGqv9jRII=; b=M8OnpaH1CVvGe3uJ1GKfHxyth4YeVMrEVYkGL+R
 ruMlFQk1qg4EIpo5TXS6DJarWpdM4kKltUVm+n3X/BG0O06Bub4MVVCSMoh+31of
 BTyhOPyakotbI0qrygIaBhgASWiDEKV6TL6GyySwbZf3sn4Y1G2WbKdLDZRRzDKh
 QdPPkOiLiRiYe99Bktv+PYb8l+r8gNyC+kVhyEAk9e4/S71dpeORnPTm3cEb411E
 ify8f2VuOkg28HfVfizIu2HBC9rFIumhf+1hul0OyRjq1rKiUdHcP0kPV/gGs9Kk
 KWOP0R9siStKvO1ePr9ATKp/phqO9ttb/Ly9vNpHsVvhvZw==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4hgmrthcby-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Oct 2026 04:57:17 +0000 (GMT)
Received: from [127.0.1.1] (172.25.128.225) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 26 Oct
 2026 04:57:13 +0000
From: Brajesh Gupta <brajesh.gupta@imgtec.com>
Date: Mon, 26 Oct 2026 10:26:45 +0530
Subject: [PATCH] drm/imagination: Support for querying Firmware information
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261026-fwversion-v1-1-3ed17c65bf4c@imgtec.com>
X-B4-Tracking: v=1; b=H4sIAIzd3moC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDINZNKy9LLQKp0rU0TbQwSrQ0TLNMM1cCqi8oSk3LrACbFR1bWwsAPLu
 UBVsAAAA=
X-Change-ID: 20261026-fwversion-95a82a91f9f7
To: Alessio Belle <alessio.belle@imgtec.com>, Luigi Santivetti
 <luigi.santivetti@imgtec.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: <imagination@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, Brajesh Gupta <brajesh.gupta@imgtec.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5329;
 i=brajesh.gupta@imgtec.com; h=from:subject:message-id;
 bh=EjB5brLJIxO02+FtPvrMC3ZFJgz/BdZGAbQJm8HvvcU=;
 b=owEBbQKS/ZANAwAKAdAmd1l+AvFwAcsmYgBq3t2pFF/WiCq+BNjL7WLIr1sDEP5lTvvcSdpzb
 VlMlLrDUpSJAjMEAAEKAB0WIQSQIkZAwD1cxcAsz3LQJndZfgLxcAUCat7dqQAKCRDQJndZfgLx
 cGbID/4vESQAXz+n6321XS5RrP1l/wyM3jaYXl6P9s5dAR0PyrVT3/NXxH1QprSsHGYXSGg0ND5
 WS5l3DQnnK4/AUtnZY2ZX/8raLnXl1cXpEOBgVWQ9ttOty48GNrvN0pWlXS67cSJpT5CqFcxnKC
 0tsLaR4+7VeLJHxV2+JVkTMSFU7g0s0Ox5cjgYQq3rqfNWlM9neEAJWDaMrWnH4dErrLroBSsTn
 wliAkJCstHggMaXu1YGeJ3ayLx3ugK4a8HC2kLS8DBh6wkMijZeUkVHAxNyYMrK25A00P38A5ay
 PA3Bkx4ZQ8A9ObPd5c/esS0iTrFkKQDVnuJO/GC2HuLB1T2vjs/0neOCYma3NLXYbIRFoCQxygd
 bI/xYnFl3WS3IlrRLnJ2cqjKj6/NaQC80Jj340BAKNFSN/kxxu+5HWdui0HhvEl+2lzliSOVeuu
 TYKAN+gzfkK7UO1mHFq0+nMohZVAuftoVF097waSguQOHOYYQLAzKNt33u+yEfQ5mKxJ+RfBzaY
 bE7fXmvgrdn6HgOvDf8k9l4TXFky9KEWEYk3sU2rtB2tHJV6Z2H6O/vooo1kcDMf1Yqf0TXMvpV
 mBEbDtzUzvBTeE30duNUT8jDIIO9MotqagwKgi8dDJCaZKTtv+5bmZohNOVNHSnNPfPSOfDCzYs
 8ATh3MatKZgZpCw==
X-Developer-Key: i=brajesh.gupta@imgtec.com; a=openpgp;
 fpr=05BAA300FD5C580EFD3F8D2F073292BAD0D39671
X-Proofpoint-ORIG-GUID: 89KgDbSGtrz5uKctqCA9P-5rbOMmZdni
X-Authority-Analysis: v=2.4 cv=NZdzRGD4 c=1 sm=1 tr=0 ts=6adeddad cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=HYrZrZQ_E1YA:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=r_1tXGB3AAAA:8 a=VQtmmEAXoFRDbT8Ph0MA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAxOSBTYWx0ZWRfX/aS4Cd3NB7td
 DckXBhmTwujrhMJWmrgK0f0ro8+eP068348KTxpfJeo+UMrSGL2KknUIksQuhevOi3JvcfGBZL6
 TESFOlce/RUVzsBHOCkjCANua1iYvi8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAxOSBTYWx0ZWRfX0QNRPzaFD+JX
 qIwKl1Oogp8EOyoiRLXLmgqApB/bqUnhFCkCOIp1Dx6WWdRMLiqfABM5abGo8NS0SSQ2DsiIUND
 oUk/WcU7X3GQ/XpE0ybxJSaNROqiQMUCYEb5UnmgNnoBfd4qmN6bHmX4GC05Idii8tvtLYxw+5n
 GB7ZGi1zQeN0axXXNGi1Ij7Z4VZRoAL13Vgi7ct9eoqLhNLJBQoScZLb7fBs/pxE33CWbljgWdS
 fEZ7NEe13pqmLQagaDz8WUhYFj4+MsQhq37V5dbXizCOJEq/RnVPHhIj5GStqkm+PVIXJP85HHw
 v+uFE0gkCo2N+4QsSnc1uxhO3d9lPHRnyBVSENu680W0B5R+TqV5GRLjDH8EwpE45tib3NW0ntb
 Kzi9EZrmEa/agHG4t7YGp/xwwJwJsZ62dpMFaz1PFaJ2Av7tpC2thnfFX6LJnn9bgfgeRpul7Zk
 YyLMLaRKXkxsUWgEYsA==
X-Proofpoint-GUID: 89KgDbSGtrz5uKctqCA9P-5rbOMmZdni
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a new subtype DRM_PVR_DEV_QUERY_FW_INFO_GET under
DRM_IOCTL_PVR_DEV_QUERY to query Firmware information. This allows the
userspace to detect any bug fixes and features present in the Firmware
and take appropriate action.
Currently it supports querying major and minor version of the Firmware.

Signed-off-by: Brajesh Gupta <brajesh.gupta@imgtec.com>
---
 drivers/gpu/drm/imagination/pvr_drv.c |  5 +++++
 drivers/gpu/drm/imagination/pvr_drv.h |  4 +++-
 drivers/gpu/drm/imagination/pvr_fw.c  | 25 +++++++++++++++++++++++++
 drivers/gpu/drm/imagination/pvr_fw.h  |  3 +++
 include/uapi/drm/pvr_drm.h            | 18 ++++++++++++++++++
 5 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/imagination/pvr_drv.c b/drivers/gpu/drm/imagination/pvr_drv.c
index 5c965ef0274f..2d522a8e46ad 100644
--- a/drivers/gpu/drm/imagination/pvr_drv.c
+++ b/drivers/gpu/drm/imagination/pvr_drv.c
@@ -6,6 +6,7 @@
 #include "pvr_device.h"
 #include "pvr_drv.h"
 #include "pvr_free_list.h"
+#include "pvr_fw.h"
 #include "pvr_gem.h"
 #include "pvr_hwrt.h"
 #include "pvr_job.h"
@@ -658,6 +659,10 @@ pvr_ioctl_dev_query(struct drm_device *drm_dev, void *raw_args,
 	case DRM_PVR_DEV_QUERY_STATIC_DATA_AREAS_GET:
 		ret = pvr_static_data_areas_get(pvr_dev, args);
 		break;
+
+	case DRM_PVR_DEV_QUERY_FW_INFO_GET:
+		ret = pvr_fw_info_get(pvr_dev, args);
+		break;
 	}
 
 	drm_dev_exit(idx);
diff --git a/drivers/gpu/drm/imagination/pvr_drv.h b/drivers/gpu/drm/imagination/pvr_drv.h
index 7fa147312dd1..fd01feeeda1d 100644
--- a/drivers/gpu/drm/imagination/pvr_drv.h
+++ b/drivers/gpu/drm/imagination/pvr_drv.h
@@ -13,9 +13,10 @@
 /*
  * Driver interface version:
  *  - 1.0: Initial interface
+ *  - 1.1: Add DRM_PVR_DEV_QUERY_FW_INFO_GET query
  */
 #define PVR_DRIVER_MAJOR 1
-#define PVR_DRIVER_MINOR 0
+#define PVR_DRIVER_MINOR 1
 #define PVR_DRIVER_PATCHLEVEL 0
 
 int pvr_get_uobj(u64 usr_ptr, u32 usr_size, u32 min_size, u32 obj_size, void *out);
@@ -68,6 +69,7 @@ int pvr_set_uobj_array(const struct drm_pvr_obj_array *out, u32 min_stride, u32
 	PVR_UOBJ_DECL(struct drm_pvr_dev_query_heap_info, heaps) \
 	PVR_UOBJ_DECL(struct drm_pvr_static_data_area, offset) \
 	PVR_UOBJ_DECL(struct drm_pvr_dev_query_static_data_areas, static_data_areas) \
+	PVR_UOBJ_DECL(struct drm_pvr_dev_query_fw_info, minor_version) \
 	)
 
 /**
diff --git a/drivers/gpu/drm/imagination/pvr_fw.c b/drivers/gpu/drm/imagination/pvr_fw.c
index c6c77b152342..1f21e6adaff2 100644
--- a/drivers/gpu/drm/imagination/pvr_fw.c
+++ b/drivers/gpu/drm/imagination/pvr_fw.c
@@ -4,6 +4,7 @@
 #include "pvr_ccb.h"
 #include "pvr_device.h"
 #include "pvr_device_info.h"
+#include "pvr_drv.h"
 #include "pvr_fw.h"
 #include "pvr_fw_info.h"
 #include "pvr_fw_startstop.h"
@@ -1496,3 +1497,27 @@ pvr_fw_hard_reset(struct pvr_device *pvr_dev)
 
 	return 0;
 }
+
+int
+pvr_fw_info_get(const struct pvr_device *pvr_dev,
+		struct drm_pvr_ioctl_dev_query_args *args)
+{
+	struct drm_pvr_dev_query_fw_info fw_info = {0};
+	int err;
+
+	if (!args->pointer) {
+		args->size = sizeof(struct drm_pvr_dev_query_fw_info);
+		return 0;
+	}
+
+	fw_info.major_version = pvr_dev->fw_version.major;
+	fw_info.minor_version = pvr_dev->fw_version.minor;
+
+	err = PVR_UOBJ_SET(args->pointer, args->size, fw_info);
+	if (err < 0)
+		return err;
+
+	if (args->size > sizeof(fw_info))
+		args->size = sizeof(fw_info);
+	return 0;
+}
diff --git a/drivers/gpu/drm/imagination/pvr_fw.h b/drivers/gpu/drm/imagination/pvr_fw.h
index 4b25291135b6..7e18f3e7d4be 100644
--- a/drivers/gpu/drm/imagination/pvr_fw.h
+++ b/drivers/gpu/drm/imagination/pvr_fw.h
@@ -496,4 +496,7 @@ int
 pvr_fw_process_elf_command_stream(struct pvr_device *pvr_dev, const u8 *fw, u8 *fw_code_ptr,
 				  u8 *fw_data_ptr, u8 *fw_core_code_ptr, u8 *fw_core_data_ptr);
 
+int
+pvr_fw_info_get(const struct pvr_device *pvr_dev, struct drm_pvr_ioctl_dev_query_args *args);
+
 #endif /* PVR_FW_H */
diff --git a/include/uapi/drm/pvr_drm.h b/include/uapi/drm/pvr_drm.h
index ccf6c2112468..94281af974c7 100644
--- a/include/uapi/drm/pvr_drm.h
+++ b/include/uapi/drm/pvr_drm.h
@@ -434,6 +434,18 @@ struct drm_pvr_dev_query_static_data_areas {
 	struct drm_pvr_obj_array static_data_areas;
 };
 
+/**
+ * struct drm_pvr_dev_query_fw_info - Container used to fetch information
+ * about the GPU Firmware like its version.
+ */
+struct drm_pvr_dev_query_fw_info {
+	/** @major_version: Major version of the Firmware. */
+	__u16 major_version;
+
+	/** @minor_version: Minor version of the Firmware. */
+	__u16 minor_version;
+};
+
 /**
  * enum drm_pvr_dev_query - For use with &drm_pvr_ioctl_dev_query_args.type to
  * indicate the type of the receiving container.
@@ -476,6 +488,12 @@ enum drm_pvr_dev_query {
 	 * a pointer to &struct drm_pvr_dev_query_static_data_areas.
 	 */
 	DRM_PVR_DEV_QUERY_STATIC_DATA_AREAS_GET,
+
+	/**
+	 * @DRM_PVR_DEV_QUERY_FW_INFO_GET: The dev query args contain
+	 * a pointer to &struct drm_pvr_dev_query_fw_info.
+	 */
+	DRM_PVR_DEV_QUERY_FW_INFO_GET,
 };
 
 /**

---
base-commit: a8fe4e162ba8212b7e51fdb024b37800f36b496c
change-id: 20261026-fwversion-95a82a91f9f7

Best regards,
--  
Brajesh Gupta <brajesh.gupta@imgtec.com>

