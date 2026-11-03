Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D59C606D80E
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 09:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=imgtec.com header.i=@imgtec.com header.a=rsa-sha256 header.s=dk201812 header.b=w560sXMx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 302BB10F486;
	Tue,  3 Nov 2026 09:01:24 +0000 (UTC)
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8B5510E53B;
 Tue,  3 Nov 2026 09:01:12 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A34D6u83126677; Tue, 3 Nov 2026 09:00:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=c
 9w2cVYOS/JtP/ygwOyGXTYQMzbvgLvIS7g/OWDgsqQ=; b=w560sXMxThzFDCB6G
 YevGbDFQBFZwYvIZMtqjAiIx8mwPpRL7inVQYEqMFC8jUK+e8TAuyNi6vqK09xD5
 MnFZaXoHc3YeQhp7SZx6igm7WVir3L0W9699orxAJKWbgxxpU1+QBjL3MUdbOMeR
 mGlNQSKJAI0xSR6gZQNw/lQFq+WH//QiZZ2JWQgpoP7uBN93I/DsC3vIJtD/y8LX
 RNMxUW5JE6fOH4An4aKilZ6XaFK+gkCdN7Yc311pnUHcUj6d9QZvCHAFge9oRzeN
 N5Bqa+lE+IanyZf64y7tZ6ZV54J2IHCEyYh4e2ImOnaK5MhKO7oxQ0iHNHLE+M3N
 rQPlw==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4hn7ft23tw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Nov 2026 09:00:54 +0000 (GMT)
Received: from [127.0.1.1] (172.25.5.26) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 3 Nov
 2026 09:00:52 +0000
From: Alexandru Dadu <alexandru.dadu@imgtec.com>
Date: Tue, 3 Nov 2026 11:00:40 +0200
Subject: [PATCH v4 1/5] drm/imagination: Prepare heap config header for
 multi-arch support
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261103-prep-meta-fw-arch-independent-v4-1-513d1c51f458@imgtec.com>
References: <20261103-prep-meta-fw-arch-independent-v4-0-513d1c51f458@imgtec.com>
In-Reply-To: <20261103-prep-meta-fw-arch-independent-v4-0-513d1c51f458@imgtec.com>
To: Alessio Belle <alessio.belle@imgtec.com>, Luigi Santivetti
 <luigi.santivetti@imgtec.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Paul Walmsley <pjw@kernel.org>, "Palmer Dabbelt" <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, "Alexandre Ghiti" <alex@ghiti.fr>
CC: <imagination@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 "Alexandru Dadu" <alexandru.dadu@imgtec.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793696450; l=7080;
 i=alexandru.dadu@imgtec.com; s=20260304; h=from:subject:message-id;
 bh=9eDwkLGnx8tNwuQaBx3u4oUMlcw41201/Cad9UF2XXs=;
 b=F4TBoWj7J/sdQvRgXMhkCZM1/wWLq/dlUCsDJlsBcZsprJMJsuczxkLers+ou/3JbANgyRxZz
 tP6OcS/IZ5aDokloT7XEtbIDBZ+d1E/WDfyqQ9R9gR3/YY5v3SwT1LT
X-Developer-Key: i=alexandru.dadu@imgtec.com; a=ed25519;
 pk=FU07SyNrYGwhahqSxbWEuzyXlUh47xBXvLvOR7UA6+U=
X-Proofpoint-ORIG-GUID: j8eRxaGk6x6skMS_XYNDfUzcgCs6nQLs
X-Proofpoint-GUID: j8eRxaGk6x6skMS_XYNDfUzcgCs6nQLs
X-Authority-Analysis: v=2.4 cv=HaSB3SE8 c=1 sm=1 tr=0 ts=6ae9a2c6 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=h_3jC4m0AyQA:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22
 a=r_1tXGB3AAAA:8 a=wwnLb05hCPqUNQMNHCwA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDAzNSBTYWx0ZWRfX7aCapeBOYh3X
 hYJPUry5vsNiJZAy/+HIaSca5IqnOuXrUDD9R9tVskZvvlYyFmbBH5d0o2Ox9uFmm2NgERXCYez
 ZE9RSCRbIgVh3tqmTPnT6xxVdC9YUVM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDAzNSBTYWx0ZWRfX9l6JnthbsGbT
 wWsx1zcTKhjHvAwC9nH+q+mz1EfJ9H506iLqd2FGUiFHZucf8chvpKHzXgra0nPPGVb1J4C+p9H
 yg1PVl6KrZJh9WeUCC/z+GCNL76t8cyjF0NogFKdvtQ8t7tiWvmjpCYN2GJJkLAccVPaWo9xfzP
 mRNvCfGTrLcwb68Lx+n22Jc8aC70V+KmUVT0vZmiJM3QkIa6Eomx4QxoL374Xdv66v3U2FFqxGK
 cQ9PTuB1/R8txxYux/qWlpHP9zT92gnAdRlK0fIRX/lhsyxhPgjOP1j0hwLAOVvI0QffHfARXyg
 gor2HbXXxltVdUPVk1ZA+REaV1PRsck7LCqSq5WHLnQxSR0PZ4j9yh9HWy8j0LG5qV7RAy9fQDC
 O5rNJL7sGdKwsgWzZjYEozaHbsRd8gcRIhtB1mfJzTNaPcPryx3v+ZeCG6WgWIiyFrmlpzXkcmC
 PqDKXu+hS3NPcxudK6Q==
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Update the name of pvr_rogue_heap_config.h to pvr_heap_config.h to
prepare it for a more generic implementation that will have memory
sections defined for multiple GPU architectures.
Update the multi-arch common define names to a generic format.

Signed-off-by: Alexandru Dadu <alexandru.dadu@imgtec.com>
---
 drivers/gpu/drm/imagination/pvr_fw.c               |  7 +++---
 drivers/gpu/drm/imagination/pvr_gem.h              |  2 +-
 .../{pvr_rogue_heap_config.h => pvr_heap_config.h} | 26 +++++++++++-----------
 drivers/gpu/drm/imagination/pvr_vm.c               | 18 +++++++--------
 4 files changed, 26 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_fw.c b/drivers/gpu/drm/imagination/pvr_fw.c
index c6c77b152342..4d5df5272f46 100644
--- a/drivers/gpu/drm/imagination/pvr_fw.c
+++ b/drivers/gpu/drm/imagination/pvr_fw.c
@@ -9,9 +9,8 @@
 #include "pvr_fw_startstop.h"
 #include "pvr_fw_trace.h"
 #include "pvr_gem.h"
+#include "pvr_heap_config.h"
 #include "pvr_power.h"
-#include "pvr_rogue_fwif_dev_info.h"
-#include "pvr_rogue_heap_config.h"
 #include "pvr_vm.h"
 
 #include <drm/drm_drv.h>
@@ -372,8 +371,8 @@ fw_sysinit_init(void *cpu_ptr, void *priv)
 	WARN_ON(pvr_fw_object_get_dma_addr(fw_mem->fault_page_obj, 0, &fault_dma_addr));
 	fwif_sysinit->fault_phys_addr = (u64)fault_dma_addr;
 
-	fwif_sysinit->pds_exec_base = ROGUE_PDSCODEDATA_HEAP_BASE;
-	fwif_sysinit->usc_exec_base = ROGUE_USCCODE_HEAP_BASE;
+	fwif_sysinit->pds_exec_base = PVR_PDSCODEDATA_HEAP_BASE;
+	fwif_sysinit->usc_exec_base = PVR_USCCODE_HEAP_BASE;
 
 	pvr_fw_object_get_fw_addr(fw_mem->runtime_cfg_obj, &fwif_sysinit->runtime_cfg_fw_addr);
 	pvr_fw_object_get_fw_addr(fw_dev->fw_trace.tracebuf_ctrl_obj,
diff --git a/drivers/gpu/drm/imagination/pvr_gem.h b/drivers/gpu/drm/imagination/pvr_gem.h
index 4286e047ae24..ae7af82b6f17 100644
--- a/drivers/gpu/drm/imagination/pvr_gem.h
+++ b/drivers/gpu/drm/imagination/pvr_gem.h
@@ -4,7 +4,7 @@
 #ifndef PVR_GEM_H
 #define PVR_GEM_H
 
-#include "pvr_rogue_heap_config.h"
+#include "pvr_heap_config.h"
 #include "pvr_rogue_meta.h"
 
 #include <uapi/drm/pvr_drm.h>
diff --git a/drivers/gpu/drm/imagination/pvr_rogue_heap_config.h b/drivers/gpu/drm/imagination/pvr_heap_config.h
similarity index 85%
rename from drivers/gpu/drm/imagination/pvr_rogue_heap_config.h
rename to drivers/gpu/drm/imagination/pvr_heap_config.h
index 5c33b342dda5..280bf1ed523b 100644
--- a/drivers/gpu/drm/imagination/pvr_rogue_heap_config.h
+++ b/drivers/gpu/drm/imagination/pvr_heap_config.h
@@ -1,8 +1,8 @@
 /* SPDX-License-Identifier: GPL-2.0-only OR MIT */
 /* Copyright (c) 2023 Imagination Technologies Ltd. */
 
-#ifndef PVR_ROGUE_HEAP_CONFIG_H
-#define PVR_ROGUE_HEAP_CONFIG_H
+#ifndef PVR_HEAP_CONFIG_H
+#define PVR_HEAP_CONFIG_H
 
 #include <linux/sizes.h>
 
@@ -14,7 +14,7 @@
  * fits into this, but the firmware heap is only ever created in the
  * kernel driver and never exposed to userspace.
  *
- * ROGUE_PDSCODEDATA_HEAP_BASE and ROGUE_USCCODE_HEAP_BASE will be programmed,
+ * PVR_PDSCODEDATA_HEAP_BASE and PVR_USCCODE_HEAP_BASE will be programmed,
  * on a global basis, into ROGUE_CR_PDS_EXEC_BASE and ROGUE_CR_USC_CODE_BASE_*
  * respectively. Therefore if client drivers use multiple configs they must
  * still be consistent with their definitions for these heaps.
@@ -38,9 +38,9 @@
 /* 0x80_0000_0000 ************************************************************/
 
 /* 0x80_0000_0000 - 0x9F_FFFF_FFFF **/
-/* 512 GiB to 640 GiB, size of 128 GiB : GENERAL_HEAP */
-#define ROGUE_GENERAL_HEAP_BASE 0x8000000000ull
-#define ROGUE_GENERAL_HEAP_SIZE SZ_128G
+/* 512 GiB to 640 GiB, size of 128 GiB : GENERAL_HEAP **/
+#define PVR_GENERAL_HEAP_BASE 0x8000000000ull
+#define PVR_GENERAL_HEAP_SIZE SZ_128G
 
 /* 0xA0_0000_0000 - 0xAF_FFFF_FFFF */
 /* 640 GiB to 704 GiB, size of 64 GiB : FREE */
@@ -58,8 +58,8 @@
 
 /* 0xDA_0000_0000 - 0xDA_FFFF_FFFF */
 /* 872 GiB to 876 GiB, size of 4 GiB : PDSCODEDATA_HEAP */
-#define ROGUE_PDSCODEDATA_HEAP_BASE 0xDA00000000ull
-#define ROGUE_PDSCODEDATA_HEAP_SIZE SZ_4G
+#define PVR_PDSCODEDATA_HEAP_BASE 0xDA00000000ull
+#define PVR_PDSCODEDATA_HEAP_SIZE SZ_4G
 
 /* 0xDB_0000_0000 - 0xDB_FFFF_FFFF */
 /* 876 GiB to 880 GiB, size of 256 MiB (reserved 4GiB) : BRN */
@@ -76,8 +76,8 @@
 
 /* 0xE0_0000_0000 - 0xE0_FFFF_FFFF */
 /* 896 GiB to 900 GiB, size of 4 GiB : USCCODE_HEAP */
-#define ROGUE_USCCODE_HEAP_BASE 0xE000000000ull
-#define ROGUE_USCCODE_HEAP_SIZE SZ_4G
+#define PVR_USCCODE_HEAP_BASE 0xE000000000ull
+#define PVR_USCCODE_HEAP_SIZE SZ_4G
 
 /* 0xE1_0000_0000 - 0xE1_BFFF_FFFF */
 /* 900 GiB to 903 GiB, size of 3 GiB : RESERVED */
@@ -99,8 +99,8 @@
 
 /* 0xF2_0000_0000 - 0xF2_001F_FFFF **/
 /* 968 GiB to 969 GiB, size of 2 MiB : VISTEST_HEAP */
-#define ROGUE_VISTEST_HEAP_BASE 0xF200000000ull
-#define ROGUE_VISTEST_HEAP_SIZE SZ_2M
+#define PVR_VISTEST_HEAP_BASE 0xF200000000ull
+#define PVR_VISTEST_HEAP_SIZE SZ_2M
 
 /* 0xF2_4000_0000 - 0xF2_FFFF_FFFF */
 /* 969 GiB to 972 GiB, size of 3 GiB : FREE */
@@ -110,4 +110,4 @@
 
 /* 0xFF_FFFF_FFFF ************************************************************/
 
-#endif /* PVR_ROGUE_HEAP_CONFIG_H */
+#endif /* PVR_HEAP_CONFIG_H */
diff --git a/drivers/gpu/drm/imagination/pvr_vm.c b/drivers/gpu/drm/imagination/pvr_vm.c
index ceb78694cd98..ae965043237d 100644
--- a/drivers/gpu/drm/imagination/pvr_vm.c
+++ b/drivers/gpu/drm/imagination/pvr_vm.c
@@ -6,9 +6,9 @@
 #include "pvr_device.h"
 #include "pvr_drv.h"
 #include "pvr_gem.h"
+#include "pvr_heap_config.h"
 #include "pvr_mmu.h"
 #include "pvr_rogue_fwif.h"
-#include "pvr_rogue_heap_config.h"
 
 #include <drm/drm_exec.h>
 #include <drm/drm_gem.h>
@@ -950,20 +950,20 @@ static const struct drm_pvr_static_data_area static_data_areas[] = {
  */
 static const struct drm_pvr_heap pvr_heaps[] = {
 	[DRM_PVR_HEAP_GENERAL] = {
-		.base = ROGUE_GENERAL_HEAP_BASE,
-		.size = ROGUE_GENERAL_HEAP_SIZE,
+		.base = PVR_GENERAL_HEAP_BASE,
+		.size = PVR_GENERAL_HEAP_SIZE,
 		.flags = 0,
 		.page_size_log2 = PVR_DEVICE_PAGE_SHIFT,
 	},
 	[DRM_PVR_HEAP_PDS_CODE_DATA] = {
-		.base = ROGUE_PDSCODEDATA_HEAP_BASE,
-		.size = ROGUE_PDSCODEDATA_HEAP_SIZE,
+		.base = PVR_PDSCODEDATA_HEAP_BASE,
+		.size = PVR_PDSCODEDATA_HEAP_SIZE,
 		.flags = 0,
 		.page_size_log2 = PVR_DEVICE_PAGE_SHIFT,
 	},
 	[DRM_PVR_HEAP_USC_CODE] = {
-		.base = ROGUE_USCCODE_HEAP_BASE,
-		.size = ROGUE_USCCODE_HEAP_SIZE,
+		.base = PVR_USCCODE_HEAP_BASE,
+		.size = PVR_USCCODE_HEAP_SIZE,
 		.flags = 0,
 		.page_size_log2 = PVR_DEVICE_PAGE_SHIFT,
 	},
@@ -974,8 +974,8 @@ static const struct drm_pvr_heap pvr_heaps[] = {
 		.page_size_log2 = PVR_DEVICE_PAGE_SHIFT,
 	},
 	[DRM_PVR_HEAP_VIS_TEST] = {
-		.base = ROGUE_VISTEST_HEAP_BASE,
-		.size = ROGUE_VISTEST_HEAP_SIZE,
+		.base = PVR_VISTEST_HEAP_BASE,
+		.size = PVR_VISTEST_HEAP_SIZE,
 		.flags = 0,
 		.page_size_log2 = PVR_DEVICE_PAGE_SHIFT,
 	},

-- 
2.43.0

