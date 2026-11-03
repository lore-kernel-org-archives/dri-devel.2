Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEDD606A32F
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 09:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=imgtec.com header.i=@imgtec.com header.a=rsa-sha256 header.s=dk201812 header.b=lgkTXmZQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25B9210F450;
	Tue,  3 Nov 2026 09:01:21 +0000 (UTC)
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A6EF10E7DD;
 Tue,  3 Nov 2026 09:01:13 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A34D6uC3126677; Tue, 3 Nov 2026 09:00:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=8
 UxN5G4CszVASc0eJ51bWhZrmzSLYZSfVvLKokYxmLc=; b=lgkTXmZQIqmGXVOco
 LY7LDJ2/J7CNEKPT6/pgmqMPhGR/UUk1wV3/uSRLDe87W9GnqqXEntwyBFEaaEUj
 xR89SI7N2i1SGtp51tBIvxqN7PZnD1ZwnHc8jaDY7zqGuVHoqLIXQnibP4ge/cpU
 TfKwWxP+pOuleOk8clDmczRqmI2xu0pMyOK2JHM0f4BvSDjkyRgCU7RbGq2xsB1h
 JvdVyr6R2hFUMTiqEQ9kWvwX61JXQ8TY54eCPX3O//ORbu0DiqOs/Gr5Tkp27PKN
 b0lTMuCCx5zLas3o58nWEYO+nsI9Rt2bFDluvTlusAM1rex7sn84DMEhGCaPLNtS
 MGFjA==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4hn7ft23tw-5
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Nov 2026 09:00:57 +0000 (GMT)
Received: from [127.0.1.1] (172.25.5.26) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 3 Nov
 2026 09:00:55 +0000
From: Alexandru Dadu <alexandru.dadu@imgtec.com>
Date: Tue, 3 Nov 2026 11:00:42 +0200
Subject: [PATCH v4 3/5] drm/imagination: Make the RISC-V firmware header
 arch-independent
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261103-prep-meta-fw-arch-independent-v4-3-513d1c51f458@imgtec.com>
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
 "Alexandru Dadu" <alexandru.dadu@imgtec.com>,
 Matt Coster <opensource@mtcoster.net>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793696450; l=5651;
 i=alexandru.dadu@imgtec.com; s=20260304; h=from:subject:message-id;
 bh=N00B/HKIov+RzgHbL1f3a705Bh43/lCp6PTCWxTp7oE=;
 b=qoxoQIyBIxYbxeVbXcHQazY3xuEiUzNbbamk0JvDqfm1yzjbI/nmxlFrq2WaeDjfltjHPROx3
 BQWWQkhAItPDSKaTe1nemiqAoUg6gG16EO/bQo1+D1v0TY02iyMC2AW
X-Developer-Key: i=alexandru.dadu@imgtec.com; a=ed25519;
 pk=FU07SyNrYGwhahqSxbWEuzyXlUh47xBXvLvOR7UA6+U=
X-Proofpoint-ORIG-GUID: YGNGvhxVgp7TrJb3Wf0Xgbj2uXW2qpuf
X-Proofpoint-GUID: YGNGvhxVgp7TrJb3Wf0Xgbj2uXW2qpuf
X-Authority-Analysis: v=2.4 cv=HaSB3SE8 c=1 sm=1 tr=0 ts=6ae9a2ca cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=h_3jC4m0AyQA:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22
 a=r_1tXGB3AAAA:8 a=SqUUmSXaI7-uYlY8_LkA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDAzNSBTYWx0ZWRfX7Ao0If+7Z2+G
 TQSx+mWs+T2QRTq272X9j0Qjo7/nNS4S+vcZns1mu/MS2I7qIwswCR4vyffdkueo3f5mhIVIZHY
 9+k04JfGbrpnT0voYO2AC65xmcI3ezE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDAzNSBTYWx0ZWRfX0bkhqC3C0PLJ
 RFbRr8SDPLdd9wrGGzrGSi0xOiezBw/JXYot8McqVDLDvlFhI++JSqfzPS0sL1mUZobtfY3WAWr
 NcIErZ1pi0WKA5RNi2HsoEBhqPU1Is3MW7n8rh2AWO4TJLqyzMmSuPolH6OW8rgzA0p6wTn0sKU
 pxDND3SHmwStTvsawLv2nckf3rEkcMGN3XIcDdHdnmulxESADMqT1EaVlDDpzBwKs2P870WuIVS
 lv964SAbogxE78RPGr3BlvyEuBB9ji2vEM8RVGneNkBuJoYf2Y/2l63UMxi0Tx1GpgNpk2z4AZL
 5ihhrj+lJnsaAvXSPeft1vZhe3u39RJDdGwpOzil2K6nmiLaYqepBSUKbFq/clpsYmeaZ/rW/D3
 4KrFh+gC2htupVOKlfnO3o3SFa7pVmasHp6FKZNlgPpvPNT5T8xPSgxXgT9fWCrPPnoQDERZq6x
 PQuxWm5xAi/FzJPYjSg==
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

From: Alessio Belle <alessio.belle@imgtec.com>

This header file contains definitions common to all PowerVR
architectures starting from Rogue, so rename both the file and its
contents to reflect this.

Signed-off-by: Alessio Belle <alessio.belle@imgtec.com>
Signed-off-by: Matt Coster <matt.coster@imgtec.com>
Signed-off-by: Alexandru Dadu <alexandru.dadu@imgtec.com>
---
 drivers/gpu/drm/imagination/pvr_fw_riscv.c         | 14 +++----
 .../gpu/drm/imagination/pvr_fw_riscv_internal.h    | 43 ++++++++++++++++++++++
 .../gpu/drm/imagination/pvr_rogue_riscv_internal.h | 43 ----------------------
 3 files changed, 50 insertions(+), 50 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_fw_riscv.c b/drivers/gpu/drm/imagination/pvr_fw_riscv.c
index 0d4dd45520a9..2b24c40bc20f 100644
--- a/drivers/gpu/drm/imagination/pvr_fw_riscv.c
+++ b/drivers/gpu/drm/imagination/pvr_fw_riscv.c
@@ -6,10 +6,10 @@
 #include "pvr_fw_info.h"
 #include "pvr_fw_mips.h"
 #include "pvr_gem.h"
+#define PVR_FW_RISCV_INTERNAL_H_EXPLICIT_INCLUDE
+#include "pvr_fw_riscv_internal.h"
+#undef PVR_FW_RISCV_INTERNAL_H_EXPLICIT_INCLUDE
 #include "pvr_rogue_cr_defs.h"
-#define PVR_ROGUE_RISCV_INTERNAL_H_EXPLICIT_INCLUDE
-#include "pvr_rogue_riscv_internal.h"
-#undef PVR_ROGUE_RISCV_INTERNAL_H_EXPLICIT_INCLUDE
 #include "pvr_vm.h"
 
 #include <linux/compiler.h>
@@ -43,13 +43,13 @@ pvr_riscv_wrapper_init(struct pvr_device *pvr_dev)
 
 	pvr_cr_write64(pvr_dev,
 		       PVR_CR_REPEAT_X(ROGUE_CR_FWCORE_ADDR_REMAP_CONFIG,
-				       ROGUE_RISCV_REGION_BOOTLDR_CODE),
+				       PVR_RISCV_REGION_BOOTLDR_CODE),
 		       code_addr | common_opts |
 		       ROGUE_CR_FWCORE_ADDR_REMAP_CONFIGx_FETCH_EN_EN);
 
 	pvr_cr_write64(pvr_dev,
 		       PVR_CR_REPEAT_X(ROGUE_CR_FWCORE_ADDR_REMAP_CONFIG,
-				       ROGUE_RISCV_REGION_BOOTLDR_DATA),
+				       PVR_RISCV_REGION_BOOTLDR_DATA),
 		       data_addr | common_opts |
 		       ROGUE_CR_FWCORE_ADDR_REMAP_CONFIGx_LOAD_STORE_EN_EN);
 
@@ -132,9 +132,9 @@ pvr_riscv_get_fw_addr_with_offset(struct pvr_fw_object *fw_obj, u32 offset)
 
 	/* RISC-V cacheability is determined by address. */
 	if (fw_obj->gem->flags & PVR_BO_FW_FLAGS_DEVICE_UNCACHED)
-		fw_addr |= ROGUE_RISCVFW_REGION_BASE(SHARED_UNCACHED_DATA);
+		fw_addr |= PVR_RISCVFW_REGION_BASE(SHARED_UNCACHED_DATA);
 	else
-		fw_addr |= ROGUE_RISCVFW_REGION_BASE(SHARED_CACHED_DATA);
+		fw_addr |= PVR_RISCVFW_REGION_BASE(SHARED_CACHED_DATA);
 
 	return fw_addr;
 }
diff --git a/drivers/gpu/drm/imagination/pvr_fw_riscv_internal.h b/drivers/gpu/drm/imagination/pvr_fw_riscv_internal.h
new file mode 100644
index 000000000000..abcbb4ef06fe
--- /dev/null
+++ b/drivers/gpu/drm/imagination/pvr_fw_riscv_internal.h
@@ -0,0 +1,43 @@
+/* SPDX-License-Identifier: GPL-2.0 OR MIT */
+/* Copyright (c) 2024 Imagination Technologies Ltd. */
+
+#ifndef PVR_FW_RISCV_INTERNAL_H
+#define PVR_FW_RISCV_INTERNAL_H
+
+#ifndef PVR_FW_RISCV_INTERNAL_H_EXPLICIT_INCLUDE
+#error This file may only be included if explicitly defined
+#endif
+
+#include "pvr_rogue_cr_defs.h"
+
+#include <linux/bitops.h>
+#include <linux/sizes.h>
+#include <linux/types.h>
+
+#define PVR_RISCVFW_REGION_SIZE SZ_256M
+#define PVR_RISCVFW_REGION_SHIFT __ffs(PVR_RISCVFW_REGION_SIZE)
+
+enum pvr_riscvfw_region {
+	PVR_RISCV_REGION__RESERVED_0 = 0,
+	PVR_RISCV_REGION__RESERVED_1,
+	PVR_RISCV_REGION_SOCIF,
+	PVR_RISCV_REGION__RESERVED_3,
+	PVR_RISCV_REGION__RESERVED_4,
+	PVR_RISCV_REGION_BOOTLDR_DATA,
+	PVR_RISCV_REGION_SHARED_CACHED_DATA,
+	PVR_RISCV_REGION__RESERVED_7,
+	PVR_RISCV_REGION_COREMEM,
+	PVR_RISCV_REGION__RESERVED_9,
+	PVR_RISCV_REGION__RESERVED_A,
+	PVR_RISCV_REGION__RESERVED_B,
+	PVR_RISCV_REGION_BOOTLDR_CODE,
+	PVR_RISCV_REGION_SHARED_UNCACHED_DATA,
+	PVR_RISCV_REGION__RESERVED_E,
+	PVR_RISCV_REGION__RESERVED_F,
+
+	PVR_RISCV_REGION__COUNT,
+};
+
+#define PVR_RISCVFW_REGION_BASE(r) ((u32)(PVR_RISCV_REGION_##r) << PVR_RISCVFW_REGION_SHIFT)
+
+#endif /* PVR_FW_RISCV_INTERNAL_H */
diff --git a/drivers/gpu/drm/imagination/pvr_rogue_riscv_internal.h b/drivers/gpu/drm/imagination/pvr_rogue_riscv_internal.h
deleted file mode 100644
index ba18c2a82205..000000000000
--- a/drivers/gpu/drm/imagination/pvr_rogue_riscv_internal.h
+++ /dev/null
@@ -1,43 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 OR MIT */
-/* Copyright (c) 2024 Imagination Technologies Ltd. */
-
-#ifndef PVR_ROGUE_RISCV_INTERNAL_H
-#define PVR_ROGUE_RISCV_INTERNAL_H
-
-#ifndef PVR_ROGUE_RISCV_INTERNAL_H_EXPLICIT_INCLUDE
-#error This file may only be included if explicitly defined
-#endif
-
-#include "pvr_rogue_cr_defs.h"
-
-#include <linux/bitops.h>
-#include <linux/sizes.h>
-#include <linux/types.h>
-
-#define ROGUE_RISCVFW_REGION_SIZE SZ_256M
-#define ROGUE_RISCVFW_REGION_SHIFT __ffs(ROGUE_RISCVFW_REGION_SIZE)
-
-enum rogue_riscvfw_region {
-	ROGUE_RISCV_REGION__RESERVED_0 = 0,
-	ROGUE_RISCV_REGION__RESERVED_1,
-	ROGUE_RISCV_REGION_SOCIF,
-	ROGUE_RISCV_REGION__RESERVED_3,
-	ROGUE_RISCV_REGION__RESERVED_4,
-	ROGUE_RISCV_REGION_BOOTLDR_DATA,
-	ROGUE_RISCV_REGION_SHARED_CACHED_DATA,
-	ROGUE_RISCV_REGION__RESERVED_7,
-	ROGUE_RISCV_REGION_COREMEM,
-	ROGUE_RISCV_REGION__RESERVED_9,
-	ROGUE_RISCV_REGION__RESERVED_A,
-	ROGUE_RISCV_REGION__RESERVED_B,
-	ROGUE_RISCV_REGION_BOOTLDR_CODE,
-	ROGUE_RISCV_REGION_SHARED_UNCACHED_DATA,
-	ROGUE_RISCV_REGION__RESERVED_E,
-	ROGUE_RISCV_REGION__RESERVED_F,
-
-	ROGUE_RISCV_REGION__COUNT,
-};
-
-#define ROGUE_RISCVFW_REGION_BASE(r) ((u32)(ROGUE_RISCV_REGION_##r) << ROGUE_RISCVFW_REGION_SHIFT)
-
-#endif /* PVR_ROGUE_RISCV_INTERNAL_H */

-- 
2.43.0

