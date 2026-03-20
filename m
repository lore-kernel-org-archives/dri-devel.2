Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3705109879A
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 15:22:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B00110E90C;
	Fri, 20 Mar 2026 15:22:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="ZflG67tR";
	dkim-atps=neutral
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FC8410E90C
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 15:22:47 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62K7sxZC3930003; Fri, 20 Mar 2026 15:22:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=d
 2xlE6wM294iBMpPnLgRk7v1U0eCoLi366e5jsFxuMc=; b=ZflG67tRzUN2PJ9gz
 5R0I6jT7QYJQe7QMSYSWiRlrDsrKSNxMn/bsNHKapBD3lPUl9Hqlox7uzrHWySNk
 wukR6vUU/0xKSxFyM7nSAWmfh78xTKT75/bBxNPEtTo5oEA5Csi1/WMb5WByxGqY
 5WAjN7yNo0bt85N8QHqoJJdDZ6ZTorIw/TfXoZKvlT//I7MCQYOXse+DOrdBPbkG
 6QpnpAWGK4UTML2zLCFV9ugZQ8OmEuB3ElFCGq+yQq/0/iJyxTKhEuHmNHL8N/LT
 fxEhPBpgEkFU3PcfFnxB+3AWHjzVXCTj/YvxrDircLs0iATum3+YAbS7DujoWxNi
 8oPjw==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4cw0mwdjs4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 20 Mar 2026 15:22:25 +0000 (GMT)
Received: from HHMAIL03.hh.imgtec.org (10.44.0.121) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 20 Mar
 2026 15:22:24 +0000
Received: from
 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa
 (172.25.4.249) by HHMAIL03.hh.imgtec.org (10.44.0.121) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 20 Mar 2026 15:22:23 +0000
From: Matt Coster <matt.coster@imgtec.com>
Date: Fri, 20 Mar 2026 15:22:12 +0000
Subject: [PATCH v2 1/2] drm/imagination: Define packed BVNCs in the uapi
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260320-bvnc-cleanup-v2-1-49c3c1453289@imgtec.com>
References: <20260320-bvnc-cleanup-v2-0-49c3c1453289@imgtec.com>
In-Reply-To: <20260320-bvnc-cleanup-v2-0-49c3c1453289@imgtec.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: Frank Binns <frank.binns@imgtec.com>, Brajesh Gupta
 <brajesh.gupta@imgtec.com>, Alessio Belle <alessio.belle@imgtec.com>,
 Alexandru Dadu <alexandru.dadu@imgtec.com>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>, "Matt
 Coster" <matt.coster@imgtec.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6152;
 i=matt.coster@imgtec.com; h=from:subject:message-id;
 bh=RSH6QERV89O6WwT0rSXIIDDR5RFxUFJhuhMID2KGPKM=;
 b=owGbwMvMwCFWuUfy8817WRsYT6slMWTuTdO7v7TOytfxVo7lN6mlZbcEi3ifG3EeOf1+wz7eZ
 wtYzkSGdJSyMIhxMMiKKbLsWGG5Qu2PmpbEjV/FMHNYmUCGMHBxCsBEGBIY/uc4nGA5HcYlciGl
 ru1rx4v1DIy6sxenXqgTlbX9PEX9eDnDX7lzAf4bQvorXGS6Nxvurth5z6b2gteXGTePdKSKPf9
 RzgwA
X-Developer-Key: i=matt.coster@imgtec.com; a=openpgp;
 fpr=05A40CFCE7269D61D97100A1747F0A9036F90DFA
X-Originating-IP: [172.25.4.249]
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDEyMiBTYWx0ZWRfXw4D8jJD14/lE
 Zn7I/i7JO/e7S+RWXh0VH3oFS1bGIhV2nnu1nkzBNXQ8IWyO6lw1ZThCfGkLDIIyTS3CEf01Hte
 TmL4g15QL+/0mYgYzGhASVYXGVKuGWf4h+BLYMG6MVlr9dP+BmFuo+RwQC4we8Q+oal3zVtybt5
 cLEgfPP2Dhs0b7bwVWflRZVHPDcy4c5F4Svkw4kfTShjkqGOORq+FGTJfxic/DwZs15qiRr2uSt
 NIzGMmv3Ob9tMvv0NV7y68acdph7SYnyB1skxoAN4zNRP/bK60EuYXNfEsECqZ+2KhwhQ5vzYr8
 ydHBHfQW8FwO5t8vivtOoCECxc2xpsTJFCuv6DtNW+bwyA0jVV+CyhfIvTPb0qh9vUiV7BQ8Vgd
 EOKKKfQTsTu3ohBLGawypxfKSLCLAQPbd2W5p4JEpob7w1uaMyK/u8a0uoMMA0RFV3ppaO5dUsJ
 NgA4kcPNXtU7RKMMVCw==
X-Authority-Analysis: v=2.4 cv=JaexbEKV c=1 sm=1 tr=0 ts=69bd6631 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=Ylr_HOfL8O8A:10 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=bC-a23v3AAAA:8 a=r_1tXGB3AAAA:8 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8
 a=u9jD9pbJY3YoXFmSU6kA:9 a=QEXdDO2ut3YA:10 a=FO4_E8m0qiDe52t0p3_H:22
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-GUID: PtzPcp4NBW7lnR-NiiXCHP5v7nPsrs44
X-Proofpoint-ORIG-GUID: PtzPcp4NBW7lnR-NiiXCHP5v7nPsrs44
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

Using the uapi-safe __GENMASK_ULL(), we can stably define the layout of
64-bit packed BVNCs. These defs replace the replicated doc comment that
appears all over the place.

Signed-off-by: Matt Coster <matt.coster@imgtec.com>

---
Changes in v2:
- Add _CONST variant of PVR_PACKED_BVNC() for use in case statements.
  This fixes the build issue reported by the test bot[1][2]
- Link to v1: https://patch.msgid.link/20260206-bvnc-cleanup-v1-1-f3c818541fbe@imgtec.com

[1]: https://lore.kernel.org/r/202602070204.PjaKNSpZ-lkp@intel.com/
[2]: https://lore.kernel.org/r/202602070500.zo0DrH6U-lkp@intel.com/
---
 drivers/gpu/drm/imagination/pvr_device.c |  6 ++---
 drivers/gpu/drm/imagination/pvr_device.h | 43 +++++++++++++-------------------
 include/uapi/drm/pvr_drm.h               | 14 +++++------
 3 files changed, 27 insertions(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_device.c b/drivers/gpu/drm/imagination/pvr_device.c
index f58bb66a6327..9b26585a42bf 100644
--- a/drivers/gpu/drm/imagination/pvr_device.c
+++ b/drivers/gpu/drm/imagination/pvr_device.c
@@ -547,11 +547,11 @@ static enum pvr_gpu_support_level
 pvr_gpu_support_level(const struct pvr_gpu_id *gpu_id)
 {
 	switch (pvr_gpu_id_to_packed_bvnc(gpu_id)) {
-	case PVR_PACKED_BVNC(33, 15, 11, 3):
-	case PVR_PACKED_BVNC(36, 53, 104, 796):
+	case PVR_PACKED_BVNC_CONST(33, 15, 11, 3):
+	case PVR_PACKED_BVNC_CONST(36, 53, 104, 796):
 		return PVR_GPU_SUPPORTED;
 
-	case PVR_PACKED_BVNC(36, 52, 104, 182):
+	case PVR_PACKED_BVNC_CONST(36, 52, 104, 182):
 		return PVR_GPU_EXPERIMENTAL;
 
 	default:
diff --git a/drivers/gpu/drm/imagination/pvr_device.h b/drivers/gpu/drm/imagination/pvr_device.h
index d51c57cf9332..55d8ff11d507 100644
--- a/drivers/gpu/drm/imagination/pvr_device.h
+++ b/drivers/gpu/drm/imagination/pvr_device.h
@@ -14,7 +14,7 @@
 #include <drm/drm_file.h>
 #include <drm/drm_mm.h>
 
-#include <linux/bits.h>
+#include <linux/bitfield.h>
 #include <linux/compiler_attributes.h>
 #include <linux/compiler_types.h>
 #include <linux/device.h>
@@ -470,6 +470,12 @@ struct pvr_file {
 
 #define to_pvr_file(file) ((file)->driver_priv)
 
+#define __PVR_PACKED_BVNC(prep, b, v, n, c) \
+	(prep(DRM_PVR_BVNC_B, b) | \
+	 prep(DRM_PVR_BVNC_V, v) | \
+	 prep(DRM_PVR_BVNC_N, n) | \
+	 prep(DRM_PVR_BVNC_C, c))
+
 /**
  * PVR_PACKED_BVNC() - Packs B, V, N and C values into a 64-bit unsigned integer
  * @b: Branch ID.
@@ -477,39 +483,24 @@ struct pvr_file {
  * @n: Number of scalable units.
  * @c: Config ID.
  *
- * The packed layout is as follows:
- *
- *    +--------+--------+--------+-------+
- *    | 63..48 | 47..32 | 31..16 | 15..0 |
- *    +========+========+========+=======+
- *    | B      | V      | N      | C     |
- *    +--------+--------+--------+-------+
+ * The packed layout follows the bitfield defined by the DRM_PVR_BVNC_* macros.
  *
  * pvr_gpu_id_to_packed_bvnc() should be used instead of this macro when a
  * &struct pvr_gpu_id is available in order to ensure proper type checking.
  *
  * Return: Packed BVNC.
  */
-/* clang-format off */
-#define PVR_PACKED_BVNC(b, v, n, c) \
-	((((u64)(b) & GENMASK_ULL(15, 0)) << 48) | \
-	 (((u64)(v) & GENMASK_ULL(15, 0)) << 32) | \
-	 (((u64)(n) & GENMASK_ULL(15, 0)) << 16) | \
-	 (((u64)(c) & GENMASK_ULL(15, 0)) <<  0))
-/* clang-format on */
+#define PVR_PACKED_BVNC(b, v, n, c) __PVR_PACKED_BVNC(FIELD_PREP, b, v, n, c)
+
+/** PVR_PACKED_BVNC_CONST() - Compile-time equivalent of PVR_PACKED_BVNC(). */
+#define PVR_PACKED_BVNC_CONST(b, v, n, c) __PVR_PACKED_BVNC(FIELD_PREP_CONST, b, v, n, c)
 
 /**
  * pvr_gpu_id_to_packed_bvnc() - Packs B, V, N and C values into a 64-bit
  * unsigned integer
  * @gpu_id: GPU ID.
  *
- * The packed layout is as follows:
- *
- *    +--------+--------+--------+-------+
- *    | 63..48 | 47..32 | 31..16 | 15..0 |
- *    +========+========+========+=======+
- *    | B      | V      | N      | C     |
- *    +--------+--------+--------+-------+
+ * The packed layout follows the bitfield defined by the DRM_PVR_BVNC_* macros.
  *
  * This should be used in preference to PVR_PACKED_BVNC() when a &struct
  * pvr_gpu_id is available in order to ensure proper type checking.
@@ -525,10 +516,10 @@ pvr_gpu_id_to_packed_bvnc(const struct pvr_gpu_id *gpu_id)
 static __always_inline void
 packed_bvnc_to_pvr_gpu_id(u64 bvnc, struct pvr_gpu_id *gpu_id)
 {
-	gpu_id->b = (bvnc & GENMASK_ULL(63, 48)) >> 48;
-	gpu_id->v = (bvnc & GENMASK_ULL(47, 32)) >> 32;
-	gpu_id->n = (bvnc & GENMASK_ULL(31, 16)) >> 16;
-	gpu_id->c = bvnc & GENMASK_ULL(15, 0);
+	gpu_id->b = FIELD_GET(DRM_PVR_BVNC_B, bvnc);
+	gpu_id->v = FIELD_GET(DRM_PVR_BVNC_V, bvnc);
+	gpu_id->n = FIELD_GET(DRM_PVR_BVNC_N, bvnc);
+	gpu_id->c = FIELD_GET(DRM_PVR_BVNC_C, bvnc);
 }
 
 int pvr_device_init(struct pvr_device *pvr_dev);
diff --git a/include/uapi/drm/pvr_drm.h b/include/uapi/drm/pvr_drm.h
index ccf6c2112468..72f3f90560cf 100644
--- a/include/uapi/drm/pvr_drm.h
+++ b/include/uapi/drm/pvr_drm.h
@@ -6,6 +6,7 @@
 
 #include "drm.h"
 
+#include <linux/bits.h>
 #include <linux/const.h>
 #include <linux/types.h>
 
@@ -113,6 +114,11 @@ struct drm_pvr_obj_array {
  * DOC: PowerVR IOCTL DEV_QUERY interface
  */
 
+#define DRM_PVR_BVNC_B __GENMASK_ULL(63, 48)
+#define DRM_PVR_BVNC_V __GENMASK_ULL(47, 32)
+#define DRM_PVR_BVNC_N __GENMASK_ULL(31, 16)
+#define DRM_PVR_BVNC_C __GENMASK_ULL(15, 0)
+
 /**
  * struct drm_pvr_dev_query_gpu_info - Container used to fetch information about
  * the graphics processor.
@@ -125,13 +131,7 @@ struct drm_pvr_dev_query_gpu_info {
 	 * @gpu_id: GPU identifier.
 	 *
 	 * For all currently supported GPUs this is the BVNC encoded as a 64-bit
-	 * value as follows:
-	 *
-	 *    +--------+--------+--------+-------+
-	 *    | 63..48 | 47..32 | 31..16 | 15..0 |
-	 *    +========+========+========+=======+
-	 *    | B      | V      | N      | C     |
-	 *    +--------+--------+--------+-------+
+	 * value using the DRM_PVR_BVNC_* bitmasks.
 	 */
 	__u64 gpu_id;
 

-- 
2.53.0

