Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DE7606A321
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 12:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=imgtec.com header.i=@imgtec.com header.a=rsa-sha256 header.s=dk201812 header.b=Vejse3oi
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F024110EFA8;
	Mon, 26 Oct 2026 12:49:37 +0000 (UTC)
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 427C910EFAB;
 Mon, 26 Oct 2026 12:49:32 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69QArZpP3064362; Mon, 26 Oct 2026 12:49:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=B
 2iNY2Bn9VO6KkDaKQ49ntXUVMH7344ZKY6ufFSANwk=; b=Vejse3oizJ8ghqe/+
 Q/cdJIdjQQY4DsurjXdWfyqiNAOFUFewpWbYFz9zK3DETvtea5e6gPxHZuB+I9Ev
 +to6Btt/DfxT8NqGUJNUAddPfopFMfjgEAx4jIip4MCf0oj8gxHK/zngWmYkIneq
 eAYOl+URtSaH/3F3TjiOGUoO19mfpRPSCKNqsQm3zrV4i/8nFA2eyQdHst7HJYaF
 FwUYb1HXY5muiTVtj5FgXbFA1SwWoeFUdVkCOQM2rYS+Wlqa3y3dttr6Rz0bMd+M
 uMFofwTt0aHXqGUY0SIlcDUJPpGY1UzhgRJ0Oa7M8k0WD+mhBBULpa3xwlkgjccs
 THb0g==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4hgmrthptj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Oct 2026 12:49:19 +0000 (GMT)
Received: from [127.0.1.1] (172.25.10.25) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 26 Oct
 2026 12:49:17 +0000
From: Alexandru Dadu <alexandru.dadu@imgtec.com>
Date: Mon, 26 Oct 2026 14:48:33 +0200
Subject: [PATCH v3 1/4] drm/imagination: Limit access to the MIPS firmware
 interface
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261026-b4-simplify-mips-pte-defs-v3-1-587087d8a284@imgtec.com>
References: <20261026-b4-simplify-mips-pte-defs-v3-0-587087d8a284@imgtec.com>
In-Reply-To: <20261026-b4-simplify-mips-pte-defs-v3-0-587087d8a284@imgtec.com>
To: Alessio Belle <alessio.belle@imgtec.com>, Luigi Santivetti
 <luigi.santivetti@imgtec.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Paul Walmsley <pjw@kernel.org>, "Palmer Dabbelt" <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, "Alexandre Ghiti" <alex@ghiti.fr>
CC: <linux-kernel@vger.kernel.org>, <imagination@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>,
 Alexandru Dadu <alexandru.dadu@imgtec.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793018955; l=21896;
 i=alexandru.dadu@imgtec.com; s=20260304; h=from:subject:message-id;
 bh=uhyDK0mgbCRLoDq0Hv6SkuJPTPtjWGmiBbOwx8qmTkA=;
 b=9DwO9YxjbFFjZn+eSUGqOsKfoX9InfFlhoR/o3h6Db22uiV2xgnnkumQk/l5LnfidF311+6qB
 jVocdfT2Q16C7ecCvaZ0v4ktDCLwP7FvHaZ1V7l0pljbJcIUs3aw89v
X-Developer-Key: i=alexandru.dadu@imgtec.com; a=ed25519;
 pk=FU07SyNrYGwhahqSxbWEuzyXlUh47xBXvLvOR7UA6+U=
X-Proofpoint-ORIG-GUID: 6GhGJKaq-AwEVYEDdaE1M6_6tpAztgho
X-Authority-Analysis: v=2.4 cv=NZdzRGD4 c=1 sm=1 tr=0 ts=6adf4c4f cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=1spURiKJc90A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=r_1tXGB3AAAA:8 a=_C6vD7yIWngb3mRO16oA:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA1MCBTYWx0ZWRfX4nqnyvMSnSq6
 XWceBmDdNy5GY6YdkDaTOvkFnVgc4ULt93uZvgDRkOVQ2kYL2KA+4BP1qNuuErnb1VjxHatSmSF
 eJ6A2G3Bwvl3vayB2BCbjrMSv8kmzmg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA1MCBTYWx0ZWRfX6h2bcQVe5/PA
 rRKCDKDJML1D6fRgWqFiWOcmeJx332KNRR3HW2XKei8UgO0bb2YhqvVOd6YEZIyy190sPCX84Ej
 +T2fnrcpIyjk4Yyq0kMAfugV6m12ASQOMeyZ8cXbbQGXBaWDCfj8h1Kh4Zjz3gAW1F27vvwdT9J
 8vVH3Oe5WQ1rAqNKij5Zr8yGU20L4Hm5ipdvYj16R0liN2i4mSaAR0DHn6vDdDMZQPuZZ9SNtoC
 dZKkr/eWXnlQSrGrhOJ/x5qGcALrvCEQhIBkFe8rdzQOvfDOzZS3Ba1Bb5DXAbGjbYzoX1juNdy
 mn7hxpPoZTzmQv50SQYLIRfzxqibeP73KyzI+g006vp3BE3ByyMZNf5u5LVKAdcDTX+zcEhqf1B
 iZp5C+JSiYfV5zOVdbdSTC0GZkD6ZFG+gw78a5JR+h/eKyKi8DzFfBbMcPlE3x1Yaq0fG2sgBjI
 CIlUfxRyc9KgovvdnLA==
X-Proofpoint-GUID: 6GhGJKaq-AwEVYEDdaE1M6_6tpAztgho
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

From: Alessio Belle <alessio.belle@imgtec.com>

Ensure all accesses to the MIPS firmware interface are done using the
generic firmware interface, or the MIPS-specific VM interface.
To achieve this:

- Split struct pvr_fw_mips_data from the MIPS firmware interface header,
  which is essentially an interface between the "main" MIPS firmware
  logic and the MIPS VM logic, into two structures internal to the main
  and VM MIPS firmware logic.
- To restore the interface between main and VM MIPS firmware logic, add
  function to acquire the addresses of the MIPS firmware page table.
- Remove the MIPS firmware interface header.
- Rename the MIPS firmware processor headers adding an "internal"
  suffix.
- Add guard to the MIPS firmware processor header to prevent accidental
  inclusion outside of the MIPS firmware specific logic.

Signed-off-by: Alessio Belle <alessio.belle@imgtec.com>
Signed-off-by: Alexandru Dadu <alexandru.dadu@imgtec.com>
---
 drivers/gpu/drm/imagination/pvr_fw.h               |  11 +-
 drivers/gpu/drm/imagination/pvr_fw_mips.c          |  57 ++++++----
 drivers/gpu/drm/imagination/pvr_fw_mips.h          |  49 ---------
 drivers/gpu/drm/imagination/pvr_fw_riscv.c         |   1 -
 ...{pvr_rogue_mips.h => pvr_rogue_mips_internal.h} |  12 +-
 ...ips_check.h => pvr_rogue_mips_internal_check.h} |   6 +-
 drivers/gpu/drm/imagination/pvr_vm_mips.c          | 122 +++++++++++++++------
 drivers/gpu/drm/imagination/pvr_vm_mips.h          |   2 +
 8 files changed, 148 insertions(+), 112 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_fw.h b/drivers/gpu/drm/imagination/pvr_fw.h
index 4b25291135b6..0d4507f55c84 100644
--- a/drivers/gpu/drm/imagination/pvr_fw.h
+++ b/drivers/gpu/drm/imagination/pvr_fw.h
@@ -310,10 +310,15 @@ struct pvr_fw_device {
 	/** @funcs: Function table for the FW processor used by this device. */
 	const struct pvr_fw_defs *defs;
 
-	/** @processor_data: Pointer to data specific to FW processor. */
+	/** @processor_data: Data specific to FW processor. */
 	union {
-		/** @mips_data: Pointer to MIPS-specific data. */
-		struct pvr_fw_mips_data *mips_data;
+		/** @mips_data: MIPS-specific data. */
+		struct {
+			/** @mips_fw_data: Pointer to MIPS-FW-specific data. */
+			struct pvr_fw_mips_data *fw_data;
+			/** @mips_vm_data: Pointer to MIPS-VM-specific data. */
+			struct pvr_vm_mips_data *vm_data;
+		} mips_data;
 	} processor_data;
 
 	/** @fw_heap_info: Firmware heap information. */
diff --git a/drivers/gpu/drm/imagination/pvr_fw_mips.c b/drivers/gpu/drm/imagination/pvr_fw_mips.c
index 6914fc46db50..7e4dd23e1f3f 100644
--- a/drivers/gpu/drm/imagination/pvr_fw_mips.c
+++ b/drivers/gpu/drm/imagination/pvr_fw_mips.c
@@ -3,9 +3,10 @@
 
 #include "pvr_device.h"
 #include "pvr_fw.h"
-#include "pvr_fw_mips.h"
 #include "pvr_gem.h"
-#include "pvr_rogue_mips.h"
+#define PVR_ROGUE_MIPS_INTERNAL_H_EXPLICIT_INCLUDE
+#include "pvr_rogue_mips_internal.h"
+#undef PVR_ROGUE_MIPS_INTERNAL_H_EXPLICIT_INCLUDE
 #include "pvr_vm_mips.h"
 
 #include <linux/err.h>
@@ -15,9 +16,31 @@
 #define ROGUE_FW_HEAP_MIPS_SHIFT 24 /* 16 MB */
 #define ROGUE_FW_HEAP_MIPS_RESERVED_SIZE SZ_1M
 
+/**
+ * struct pvr_fw_mips_data - MIPS-specific data
+ */
+struct pvr_fw_mips_data {
+	/** @boot_code_dma_addr: DMA address of MIPS boot code. */
+	dma_addr_t boot_code_dma_addr;
+
+	/** @boot_data_dma_addr: DMA address of MIPS boot data. */
+	dma_addr_t boot_data_dma_addr;
+
+	/** @exception_code_dma_addr: DMA address of MIPS exception code. */
+	dma_addr_t exception_code_dma_addr;
+};
+
 static int
 pvr_mips_init(struct pvr_device *pvr_dev)
 {
+	struct pvr_fw_mips_data *fw_data;
+
+	fw_data = devm_kzalloc(pvr_dev->base.dev, sizeof(*fw_data), GFP_KERNEL);
+	if (!fw_data)
+		return -ENOMEM;
+
+	pvr_dev->fw_dev.processor_data.mips_data.fw_data = fw_data;
+
 	pvr_fw_heap_info_init(pvr_dev, ROGUE_FW_HEAP_MIPS_SHIFT, ROGUE_FW_HEAP_MIPS_RESERVED_SIZE);
 
 	return pvr_vm_mips_init(pvr_dev);
@@ -35,7 +58,7 @@ pvr_mips_fw_process(struct pvr_device *pvr_dev, const u8 *fw,
 		    u32 core_code_alloc_size)
 {
 	struct pvr_fw_device *fw_dev = &pvr_dev->fw_dev;
-	struct pvr_fw_mips_data *mips_data = fw_dev->processor_data.mips_data;
+	struct pvr_fw_mips_data *fw_data = fw_dev->processor_data.mips_data.fw_data;
 	const struct pvr_fw_layout_entry *boot_code_entry;
 	const struct pvr_fw_layout_entry *boot_data_entry;
 	const struct pvr_fw_layout_entry *exception_code_entry;
@@ -56,12 +79,12 @@ pvr_mips_fw_process(struct pvr_device *pvr_dev, const u8 *fw,
 		return -EINVAL;
 
 	WARN_ON(pvr_gem_get_dma_addr(fw_dev->mem.code_obj->gem, boot_code_entry->alloc_offset,
-				     &mips_data->boot_code_dma_addr));
+				     &fw_data->boot_code_dma_addr));
 	WARN_ON(pvr_gem_get_dma_addr(fw_dev->mem.data_obj->gem, boot_data_entry->alloc_offset,
-				     &mips_data->boot_data_dma_addr));
+				     &fw_data->boot_data_dma_addr));
 	WARN_ON(pvr_gem_get_dma_addr(fw_dev->mem.code_obj->gem,
 				     exception_code_entry->alloc_offset,
-				     &mips_data->exception_code_dma_addr));
+				     &fw_data->exception_code_dma_addr));
 
 	stack_entry = pvr_fw_find_layout_entry(pvr_dev, MIPS_STACK);
 	if (!stack_entry)
@@ -76,14 +99,10 @@ pvr_mips_fw_process(struct pvr_device *pvr_dev, const u8 *fw,
 
 	boot_data->reg_base = pvr_dev->regs_resource->start;
 
-	for (u32 page_nr = 0; page_nr < ARRAY_SIZE(boot_data->pt_phys_addr); page_nr++) {
-		/* Firmware expects 4k pages, but host page size might be different. */
-		u32 src_page_nr = (page_nr * ROGUE_MIPSFW_PAGE_SIZE_4K) >> PAGE_SHIFT;
-		u32 page_offset = (page_nr * ROGUE_MIPSFW_PAGE_SIZE_4K) & ~PAGE_MASK;
-
-		boot_data->pt_phys_addr[page_nr] = mips_data->pt_dma_addr[src_page_nr] +
-						   page_offset;
-	}
+	err = pvr_vm_get_pt_phys_addrs(pvr_dev, boot_data->pt_phys_addr,
+				       ARRAY_SIZE(boot_data->pt_phys_addr));
+	if (err)
+		return err;
 
 	boot_data->pt_log2_page_size = ROGUE_MIPSFW_LOG2_PAGE_SIZE_4K;
 	boot_data->pt_num_pages = ROGUE_MIPSFW_MAX_NUM_PAGETABLE_PAGES;
@@ -96,7 +115,7 @@ pvr_mips_fw_process(struct pvr_device *pvr_dev, const u8 *fw,
 static int
 pvr_mips_wrapper_init(struct pvr_device *pvr_dev)
 {
-	struct pvr_fw_mips_data *mips_data = pvr_dev->fw_dev.processor_data.mips_data;
+	struct pvr_fw_mips_data *fw_data = pvr_dev->fw_dev.processor_data.mips_data.fw_data;
 	const u64 remap_settings = ROGUE_MIPSFW_BOOT_REMAP_LOG2_SEGMENT_SIZE;
 	u32 phys_bus_width;
 
@@ -119,7 +138,7 @@ pvr_mips_wrapper_init(struct pvr_device *pvr_dev)
 		       ROGUE_MIPSFW_BOOT_REMAP_PHYS_ADDR_IN |
 		       ROGUE_CR_MIPS_ADDR_REMAP1_CONFIG1_MODE_ENABLE_EN);
 	pvr_cr_write64(pvr_dev, ROGUE_CR_MIPS_ADDR_REMAP1_CONFIG2,
-		       (mips_data->boot_code_dma_addr &
+		       (fw_data->boot_code_dma_addr &
 			~ROGUE_CR_MIPS_ADDR_REMAP1_CONFIG2_ADDR_OUT_CLRMSK) | remap_settings);
 
 	if (PVR_HAS_QUIRK(pvr_dev, 63553)) {
@@ -132,7 +151,7 @@ pvr_mips_wrapper_init(struct pvr_device *pvr_dev)
 		pvr_cr_write64(pvr_dev, ROGUE_CR_MIPS_ADDR_REMAP5_CONFIG1,
 			       ROGUE_CR_MIPS_ADDR_REMAP5_CONFIG1_MODE_ENABLE_EN);
 		pvr_cr_write64(pvr_dev, ROGUE_CR_MIPS_ADDR_REMAP5_CONFIG2,
-			       (mips_data->boot_code_dma_addr &
+			       (fw_data->boot_code_dma_addr &
 				~ROGUE_CR_MIPS_ADDR_REMAP5_CONFIG2_ADDR_OUT_CLRMSK) |
 			       remap_settings);
 	}
@@ -141,14 +160,14 @@ pvr_mips_wrapper_init(struct pvr_device *pvr_dev)
 		       ROGUE_MIPSFW_DATA_REMAP_PHYS_ADDR_IN |
 		       ROGUE_CR_MIPS_ADDR_REMAP2_CONFIG1_MODE_ENABLE_EN);
 	pvr_cr_write64(pvr_dev, ROGUE_CR_MIPS_ADDR_REMAP2_CONFIG2,
-		       (mips_data->boot_data_dma_addr &
+		       (fw_data->boot_data_dma_addr &
 			~ROGUE_CR_MIPS_ADDR_REMAP2_CONFIG2_ADDR_OUT_CLRMSK) | remap_settings);
 
 	pvr_cr_write64(pvr_dev, ROGUE_CR_MIPS_ADDR_REMAP3_CONFIG1,
 		       ROGUE_MIPSFW_CODE_REMAP_PHYS_ADDR_IN |
 		       ROGUE_CR_MIPS_ADDR_REMAP3_CONFIG1_MODE_ENABLE_EN);
 	pvr_cr_write64(pvr_dev, ROGUE_CR_MIPS_ADDR_REMAP3_CONFIG2,
-		       (mips_data->exception_code_dma_addr &
+		       (fw_data->exception_code_dma_addr &
 			~ROGUE_CR_MIPS_ADDR_REMAP3_CONFIG2_ADDR_OUT_CLRMSK) | remap_settings);
 
 	/* Garten IDLE bit controlled by MIPS. */
diff --git a/drivers/gpu/drm/imagination/pvr_fw_mips.h b/drivers/gpu/drm/imagination/pvr_fw_mips.h
deleted file mode 100644
index a0c5c41c8aa2..000000000000
--- a/drivers/gpu/drm/imagination/pvr_fw_mips.h
+++ /dev/null
@@ -1,49 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only OR MIT */
-/* Copyright (c) 2023 Imagination Technologies Ltd. */
-
-#ifndef PVR_FW_MIPS_H
-#define PVR_FW_MIPS_H
-
-#include "pvr_rogue_mips.h"
-
-#include <asm/page.h>
-#include <linux/math.h>
-#include <linux/types.h>
-
-/* Forward declaration from pvr_gem.h. */
-struct pvr_gem_object;
-
-#define PVR_MIPS_PT_PAGE_COUNT DIV_ROUND_UP(ROGUE_MIPSFW_MAX_NUM_PAGETABLE_PAGES * ROGUE_MIPSFW_PAGE_SIZE_4K, PAGE_SIZE)
-
-/**
- * struct pvr_fw_mips_data - MIPS-specific data
- */
-struct pvr_fw_mips_data {
-	/**
-	 * @pt_pages: Pages containing MIPS pagetable.
-	 */
-	struct page *pt_pages[PVR_MIPS_PT_PAGE_COUNT];
-
-	/** @pt: Pointer to CPU mapping of MIPS pagetable. */
-	u32 *pt;
-
-	/** @pt_dma_addr: DMA mappings of MIPS pagetable. */
-	dma_addr_t pt_dma_addr[PVR_MIPS_PT_PAGE_COUNT];
-
-	/** @boot_code_dma_addr: DMA address of MIPS boot code. */
-	dma_addr_t boot_code_dma_addr;
-
-	/** @boot_data_dma_addr: DMA address of MIPS boot data. */
-	dma_addr_t boot_data_dma_addr;
-
-	/** @exception_code_dma_addr: DMA address of MIPS exception code. */
-	dma_addr_t exception_code_dma_addr;
-
-	/** @cache_policy: Cache policy for this processor. */
-	u32 cache_policy;
-
-	/** @pfn_mask: PFN mask for MIPS pagetable. */
-	u32 pfn_mask;
-};
-
-#endif /* PVR_FW_MIPS_H */
diff --git a/drivers/gpu/drm/imagination/pvr_fw_riscv.c b/drivers/gpu/drm/imagination/pvr_fw_riscv.c
index cd84635bb88d..612feb5e0ded 100644
--- a/drivers/gpu/drm/imagination/pvr_fw_riscv.c
+++ b/drivers/gpu/drm/imagination/pvr_fw_riscv.c
@@ -4,7 +4,6 @@
 #include "pvr_device.h"
 #include "pvr_fw.h"
 #include "pvr_fw_info.h"
-#include "pvr_fw_mips.h"
 #include "pvr_gem.h"
 #include "pvr_rogue_cr_defs.h"
 #include "pvr_rogue_riscv.h"
diff --git a/drivers/gpu/drm/imagination/pvr_rogue_mips.h b/drivers/gpu/drm/imagination/pvr_rogue_mips_internal.h
similarity index 98%
rename from drivers/gpu/drm/imagination/pvr_rogue_mips.h
rename to drivers/gpu/drm/imagination/pvr_rogue_mips_internal.h
index 41ed618fda3f..68b4db83cb4b 100644
--- a/drivers/gpu/drm/imagination/pvr_rogue_mips.h
+++ b/drivers/gpu/drm/imagination/pvr_rogue_mips_internal.h
@@ -1,8 +1,12 @@
 /* SPDX-License-Identifier: GPL-2.0-only OR MIT */
 /* Copyright (c) 2023 Imagination Technologies Ltd. */
 
-#ifndef PVR_ROGUE_MIPS_H
-#define PVR_ROGUE_MIPS_H
+#ifndef PVR_ROGUE_MIPS_INTERNAL_H
+#define PVR_ROGUE_MIPS_INTERNAL_H
+
+#ifndef PVR_ROGUE_MIPS_INTERNAL_H_EXPLICIT_INCLUDE
+#error This file may only be included if explicitly defined
+#endif
 
 #include <linux/bits.h>
 #include <linux/types.h>
@@ -330,6 +334,6 @@ struct rogue_mips_state {
 	struct rogue_mips_remap_entry remap[ROGUE_MIPSFW_NUMBER_OF_REMAP_ENTRIES];
 };
 
-#include "pvr_rogue_mips_check.h"
+#include "pvr_rogue_mips_internal_check.h"
 
-#endif /* PVR_ROGUE_MIPS_H */
+#endif /* PVR_ROGUE_MIPS_INTERNAL_H */
diff --git a/drivers/gpu/drm/imagination/pvr_rogue_mips_check.h b/drivers/gpu/drm/imagination/pvr_rogue_mips_internal_check.h
similarity index 91%
rename from drivers/gpu/drm/imagination/pvr_rogue_mips_check.h
rename to drivers/gpu/drm/imagination/pvr_rogue_mips_internal_check.h
index aebf231ce90f..60bc83d7cdbc 100644
--- a/drivers/gpu/drm/imagination/pvr_rogue_mips_check.h
+++ b/drivers/gpu/drm/imagination/pvr_rogue_mips_internal_check.h
@@ -1,8 +1,8 @@
 /* SPDX-License-Identifier: GPL-2.0-only OR MIT */
 /* Copyright (c) 2023 Imagination Technologies Ltd. */
 
-#ifndef PVR_ROGUE_MIPS_CHECK_H
-#define PVR_ROGUE_MIPS_CHECK_H
+#ifndef PVR_ROGUE_MIPS_INTERNAL_CHECK_H
+#define PVR_ROGUE_MIPS_INTERNAL_CHECK_H
 
 #include "pvr_check.h"
 
@@ -32,4 +32,4 @@ OFFSET_CHECK(struct rogue_mips_state, tlb, 44);
 OFFSET_CHECK(struct rogue_mips_state, remap, 300);
 SIZE_CHECK(struct rogue_mips_state, 684);
 
-#endif /* PVR_ROGUE_MIPS_CHECK_H */
+#endif /* PVR_ROGUE_MIPS_INTERNAL_CHECK_H */
diff --git a/drivers/gpu/drm/imagination/pvr_vm_mips.c b/drivers/gpu/drm/imagination/pvr_vm_mips.c
index 5847a1c92bea..264ea0fccf9c 100644
--- a/drivers/gpu/drm/imagination/pvr_vm_mips.c
+++ b/drivers/gpu/drm/imagination/pvr_vm_mips.c
@@ -2,10 +2,11 @@
 /* Copyright (c) 2023 Imagination Technologies Ltd. */
 
 #include "pvr_device.h"
-#include "pvr_fw_mips.h"
 #include "pvr_gem.h"
 #include "pvr_mmu.h"
-#include "pvr_rogue_mips.h"
+#define PVR_ROGUE_MIPS_INTERNAL_H_EXPLICIT_INCLUDE
+#include "pvr_rogue_mips_internal.h"
+#undef PVR_ROGUE_MIPS_INTERNAL_H_EXPLICIT_INCLUDE
 #include "pvr_vm.h"
 #include "pvr_vm_mips.h"
 
@@ -16,6 +17,31 @@
 #include <linux/types.h>
 #include <linux/vmalloc.h>
 
+#define PVR_MIPS_PT_PAGE_COUNT \
+	DIV_ROUND_UP(ROGUE_MIPSFW_MAX_NUM_PAGETABLE_PAGES * ROGUE_MIPSFW_PAGE_SIZE_4K, PAGE_SIZE)
+
+/**
+ * struct pvr_vm_mips_data - MIPS-VM-specific data
+ */
+struct pvr_vm_mips_data {
+	/**
+	 * @pt_pages: Pages containing MIPS pagetable.
+	 */
+	struct page *pt_pages[PVR_MIPS_PT_PAGE_COUNT];
+
+	/** @pt: Pointer to CPU mapping of MIPS pagetable. */
+	u32 *pt;
+
+	/** @pt_dma_addr: DMA mappings of MIPS pagetable. */
+	dma_addr_t pt_dma_addr[PVR_MIPS_PT_PAGE_COUNT];
+
+	/** @cache_policy: Cache policy for this processor. */
+	u32 cache_policy;
+
+	/** @pfn_mask: PFN mask for MIPS pagetable. */
+	u32 pfn_mask;
+};
+
 /**
  * pvr_vm_mips_init() - Initialise MIPS FW pagetable
  * @pvr_dev: Target PowerVR device.
@@ -31,7 +57,7 @@ pvr_vm_mips_init(struct pvr_device *pvr_dev)
 {
 	u32 pt_size = 1 << ROGUE_MIPSFW_LOG2_PAGETABLE_SIZE_4K(pvr_dev);
 	struct device *dev = from_pvr_device(pvr_dev)->dev;
-	struct pvr_fw_mips_data *mips_data;
+	struct pvr_vm_mips_data *vm_data;
 	u32 phys_bus_width;
 	int page_nr;
 	int err;
@@ -43,49 +69,49 @@ pvr_vm_mips_init(struct pvr_device *pvr_dev)
 	if (PVR_FEATURE_VALUE(pvr_dev, phys_bus_width, &phys_bus_width))
 		return -EINVAL;
 
-	mips_data = drmm_kzalloc(from_pvr_device(pvr_dev), sizeof(*mips_data), GFP_KERNEL);
-	if (!mips_data)
+	vm_data = drmm_kzalloc(from_pvr_device(pvr_dev), sizeof(*vm_data), GFP_KERNEL);
+	if (!vm_data)
 		return -ENOMEM;
 
 	for (page_nr = 0; page_nr < PVR_MIPS_PT_PAGE_COUNT; page_nr++) {
-		mips_data->pt_pages[page_nr] = alloc_page(GFP_KERNEL | __GFP_ZERO);
-		if (!mips_data->pt_pages[page_nr]) {
+		vm_data->pt_pages[page_nr] = alloc_page(GFP_KERNEL | __GFP_ZERO);
+		if (!vm_data->pt_pages[page_nr]) {
 			err = -ENOMEM;
 			goto err_free_pages;
 		}
 
-		mips_data->pt_dma_addr[page_nr] = dma_map_page(dev, mips_data->pt_pages[page_nr], 0,
-							       PAGE_SIZE, DMA_TO_DEVICE);
-		if (dma_mapping_error(dev, mips_data->pt_dma_addr[page_nr])) {
+		vm_data->pt_dma_addr[page_nr] = dma_map_page(dev, vm_data->pt_pages[page_nr], 0,
+							     PAGE_SIZE, DMA_TO_DEVICE);
+		if (dma_mapping_error(dev, vm_data->pt_dma_addr[page_nr])) {
 			err = -ENOMEM;
-			__free_page(mips_data->pt_pages[page_nr]);
+			__free_page(vm_data->pt_pages[page_nr]);
 			goto err_free_pages;
 		}
 	}
 
-	mips_data->pt = vmap(mips_data->pt_pages, pt_size >> PAGE_SHIFT, VM_MAP,
-			     pgprot_writecombine(PAGE_KERNEL));
-	if (!mips_data->pt) {
+	vm_data->pt = vmap(vm_data->pt_pages, pt_size >> PAGE_SHIFT, VM_MAP,
+			   pgprot_writecombine(PAGE_KERNEL));
+	if (!vm_data->pt) {
 		err = -ENOMEM;
 		goto err_free_pages;
 	}
 
-	mips_data->pfn_mask = (phys_bus_width > 32) ? ROGUE_MIPSFW_ENTRYLO_PFN_MASK_ABOVE_32BIT :
-						      ROGUE_MIPSFW_ENTRYLO_PFN_MASK;
+	vm_data->pfn_mask = (phys_bus_width > 32) ? ROGUE_MIPSFW_ENTRYLO_PFN_MASK_ABOVE_32BIT :
+						    ROGUE_MIPSFW_ENTRYLO_PFN_MASK;
 
-	mips_data->cache_policy = (phys_bus_width > 32) ? ROGUE_MIPSFW_CACHED_POLICY_ABOVE_32BIT :
-							  ROGUE_MIPSFW_CACHED_POLICY;
+	vm_data->cache_policy = (phys_bus_width > 32) ? ROGUE_MIPSFW_CACHED_POLICY_ABOVE_32BIT :
+							ROGUE_MIPSFW_CACHED_POLICY;
 
-	pvr_dev->fw_dev.processor_data.mips_data = mips_data;
+	pvr_dev->fw_dev.processor_data.mips_data.vm_data = vm_data;
 
 	return 0;
 
 err_free_pages:
 	while (--page_nr >= 0) {
 		dma_unmap_page(from_pvr_device(pvr_dev)->dev,
-			       mips_data->pt_dma_addr[page_nr], PAGE_SIZE, DMA_TO_DEVICE);
+			       vm_data->pt_dma_addr[page_nr], PAGE_SIZE, DMA_TO_DEVICE);
 
-		__free_page(mips_data->pt_pages[page_nr]);
+		__free_page(vm_data->pt_pages[page_nr]);
 	}
 
 	return err;
@@ -99,17 +125,17 @@ void
 pvr_vm_mips_fini(struct pvr_device *pvr_dev)
 {
 	struct pvr_fw_device *fw_dev = &pvr_dev->fw_dev;
-	struct pvr_fw_mips_data *mips_data = fw_dev->processor_data.mips_data;
+	struct pvr_vm_mips_data *vm_data = fw_dev->processor_data.mips_data.vm_data;
 
-	vunmap(mips_data->pt);
+	vunmap(vm_data->pt);
 	for (int page_nr = PVR_MIPS_PT_PAGE_COUNT - 1; page_nr >= 0; page_nr--) {
 		dma_unmap_page(from_pvr_device(pvr_dev)->dev,
-			       mips_data->pt_dma_addr[page_nr], PAGE_SIZE, DMA_TO_DEVICE);
+			       vm_data->pt_dma_addr[page_nr], PAGE_SIZE, DMA_TO_DEVICE);
 
-		__free_page(mips_data->pt_pages[page_nr]);
+		__free_page(vm_data->pt_pages[page_nr]);
 	}
 
-	fw_dev->processor_data.mips_data = NULL;
+	fw_dev->processor_data.mips_data.vm_data = NULL;
 }
 
 static u32
@@ -145,7 +171,7 @@ int
 pvr_vm_mips_map(struct pvr_device *pvr_dev, struct pvr_fw_object *fw_obj)
 {
 	struct pvr_fw_device *fw_dev = &pvr_dev->fw_dev;
-	struct pvr_fw_mips_data *mips_data = fw_dev->processor_data.mips_data;
+	struct pvr_vm_mips_data *vm_data = fw_dev->processor_data.mips_data.vm_data;
 	struct pvr_gem_object *pvr_obj = fw_obj->gem;
 	const u64 start = fw_obj->fw_mm_node.start;
 	const u64 size = fw_obj->fw_mm_node.size;
@@ -174,7 +200,7 @@ pvr_vm_mips_map(struct pvr_device *pvr_dev, struct pvr_fw_object *fw_obj)
 	if (pvr_obj->flags & PVR_BO_FW_FLAGS_DEVICE_UNCACHED)
 		cache_policy = ROGUE_MIPSFW_UNCACHED_CACHE_POLICY;
 	else
-		cache_policy = mips_data->cache_policy;
+		cache_policy = vm_data->cache_policy;
 
 	pte_flags = get_mips_pte_flags(true, true, cache_policy);
 
@@ -190,10 +216,10 @@ pvr_vm_mips_map(struct pvr_device *pvr_dev, struct pvr_fw_object *fw_obj)
 			goto err_unmap_pages;
 
 		pte = ((dma_addr >> ROGUE_MIPSFW_LOG2_PAGE_SIZE_4K)
-		       << ROGUE_MIPSFW_ENTRYLO_PFN_SHIFT) & mips_data->pfn_mask;
+		       << ROGUE_MIPSFW_ENTRYLO_PFN_SHIFT) & vm_data->pfn_mask;
 		pte |= pte_flags;
 
-		WRITE_ONCE(mips_data->pt[pfn], pte);
+		WRITE_ONCE(vm_data->pt[pfn], pte);
 	}
 
 	pvr_mmu_flush_request_all(pvr_dev);
@@ -202,7 +228,7 @@ pvr_vm_mips_map(struct pvr_device *pvr_dev, struct pvr_fw_object *fw_obj)
 
 err_unmap_pages:
 	while (--pfn >= start_pfn)
-		WRITE_ONCE(mips_data->pt[pfn], 0);
+		WRITE_ONCE(vm_data->pt[pfn], 0);
 
 	pvr_mmu_flush_request_all(pvr_dev);
 	WARN_ON(pvr_mmu_flush_exec(pvr_dev, true));
@@ -219,7 +245,7 @@ void
 pvr_vm_mips_unmap(struct pvr_device *pvr_dev, struct pvr_fw_object *fw_obj)
 {
 	struct pvr_fw_device *fw_dev = &pvr_dev->fw_dev;
-	struct pvr_fw_mips_data *mips_data = fw_dev->processor_data.mips_data;
+	struct pvr_vm_mips_data *vm_data = fw_dev->processor_data.mips_data.vm_data;
 	const u64 start = fw_obj->fw_mm_node.start;
 	const u64 size = fw_obj->fw_mm_node.size;
 	const u64 end = start + size;
@@ -230,8 +256,38 @@ pvr_vm_mips_unmap(struct pvr_device *pvr_dev, struct pvr_fw_object *fw_obj)
 			    ROGUE_MIPSFW_LOG2_PAGE_SIZE_4K;
 
 	for (u32 pfn = start_pfn; pfn < end_pfn; pfn++)
-		WRITE_ONCE(mips_data->pt[pfn], 0);
+		WRITE_ONCE(vm_data->pt[pfn], 0);
 
 	pvr_mmu_flush_request_all(pvr_dev);
 	WARN_ON(pvr_mmu_flush_exec(pvr_dev, true));
 }
+
+/**
+ * pvr_vm_get_pt_phys_addrs() - Acquire the physical addresses of the MIPS FW page table pages
+ * @pvr_dev: Target PowerVR device.
+ * @phys_addrs: Output array for physical addresses of MIPS FW page table pages.
+ * @max_num_addrs: Maximum number of addresses that can be written to @phys_addrs.
+ *
+ * Returns:
+ *  * 0 on success, or
+ *  * -%EINVAL if @phys_addrs cannot accommodate all MIPS FW page table pages.
+ */
+int
+pvr_vm_get_pt_phys_addrs(struct pvr_device *pvr_dev, u64 *phys_addrs, int max_num_addrs)
+{
+	struct pvr_fw_device *fw_dev = &pvr_dev->fw_dev;
+	struct pvr_vm_mips_data *vm_data = fw_dev->processor_data.mips_data.vm_data;
+
+	if (ARRAY_SIZE(vm_data->pt_pages) > max_num_addrs)
+		return -EINVAL;
+
+	for (u32 page_nr = 0; page_nr < max_num_addrs; page_nr++) {
+		/* Firmware expects 4k pages, but host page size might be different. */
+		u32 src_page_nr = (page_nr * ROGUE_MIPSFW_PAGE_SIZE_4K) >> PAGE_SHIFT;
+		u32 page_offset = (page_nr * ROGUE_MIPSFW_PAGE_SIZE_4K) & ~PAGE_MASK;
+
+		phys_addrs[page_nr] = vm_data->pt_dma_addr[src_page_nr] + page_offset;
+	}
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/imagination/pvr_vm_mips.h b/drivers/gpu/drm/imagination/pvr_vm_mips.h
index 0fd59f68fb5b..3db0606c5037 100644
--- a/drivers/gpu/drm/imagination/pvr_vm_mips.h
+++ b/drivers/gpu/drm/imagination/pvr_vm_mips.h
@@ -18,5 +18,7 @@ int
 pvr_vm_mips_map(struct pvr_device *pvr_dev, struct pvr_fw_object *fw_obj);
 void
 pvr_vm_mips_unmap(struct pvr_device *pvr_dev, struct pvr_fw_object *fw_obj);
+int
+pvr_vm_get_pt_phys_addrs(struct pvr_device *pvr_dev, u64 *phys_addrs, int max_num_addrs);
 
 #endif /* PVR_VM_MIPS_H */

-- 
2.43.0

