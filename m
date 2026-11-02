Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59641606A32C
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 07:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=imgtec.com header.i=@imgtec.com header.a=rsa-sha256 header.s=dk201812 header.b=sYjJQQDp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F269C10EB62;
	Mon,  2 Nov 2026 07:09:29 +0000 (UTC)
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77B9D10E587;
 Mon,  2 Nov 2026 07:09:23 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A26GB1r3838432; Mon, 2 Nov 2026 07:09:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=o
 w+5sHC3WIN40j8WcPeuf1Jm4+f4G3UjTKRB20bgcac=; b=sYjJQQDp40Be1IGgo
 TOp8xw3/IMBEytTX1CXbWeriPF/Qbn52koEnUnE8RHYf9uBTTtGEDV1SM87MFDvE
 ur1MQa34mX41skxOjvj0uBiTCMY3nSP3RLE9XEoEGkgKXGqv+Eaju4blZsxFBW5A
 O/SB29hrMuST93Ni2FUIJ+W/E5BvzLSgCHR7aEJHTO82vNlQQK4OvApxGmLgv23T
 YVEiObjq+pF3GwqLNYU1AnQK8p62YlYXsVP5Tnwlyx+R1FGImv5lE7o/O9MGnR+w
 9o6Y5QZXTygESpVTY3DeNxjDfr2AQM41he200ogp7rP1YFJttk1CV8i7PtOz/Etn
 /Ivwg==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4hn99whb6a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 02 Nov 2026 07:09:05 +0000 (GMT)
Received: from [127.0.1.1] (172.25.5.26) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 2 Nov
 2026 07:09:03 +0000
From: Alexandru Dadu <alexandru.dadu@imgtec.com>
Date: Mon, 2 Nov 2026 09:08:34 +0200
Subject: [PATCH v5 2/4] drm/imagination: Make the MIPS firmware headers
 arch-independent
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261102-b4-simplify-mips-pte-defs-v5-2-d5bcf7d95a1a@imgtec.com>
References: <20261102-b4-simplify-mips-pte-defs-v5-0-d5bcf7d95a1a@imgtec.com>
In-Reply-To: <20261102-b4-simplify-mips-pte-defs-v5-0-d5bcf7d95a1a@imgtec.com>
To: Alessio Belle <alessio.belle@imgtec.com>, Luigi Santivetti
 <luigi.santivetti@imgtec.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Paul Walmsley <pjw@kernel.org>, "Palmer Dabbelt" <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, "Alexandre Ghiti" <alex@ghiti.fr>
CC: <linux-kernel@vger.kernel.org>, <imagination@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, Alexandru Dadu
 <alexandru.dadu@imgtec.com>, Matt Coster <opensource@mtcoster.net>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793603340; l=45045;
 i=alexandru.dadu@imgtec.com; s=20260304; h=from:subject:message-id;
 bh=N0SPqZDD5RwDPSi92gKqVw5tIPssJNv1NTFN/jgSKcE=;
 b=mCN3i6mlYkDqXCPFgVkgiNUu4maqTH8V1KI1MQKmzLLn4zF7SkJlUkPxkfeILd+gU7yFsdBcJ
 spqmBEoUnDCBX+xK/v7IX+39u5oAXDXpGl9rLqdEdRpcHZS+K+gyGe2
X-Developer-Key: i=alexandru.dadu@imgtec.com; a=ed25519;
 pk=FU07SyNrYGwhahqSxbWEuzyXlUh47xBXvLvOR7UA6+U=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDAyOCBTYWx0ZWRfX8keCVwK9DHBv
 4CofeMRI6bxoy5hZIO9VzlP5CYMpV7c/oX11skyDSvYTeBHoU6gO1S4S5irJs78b/ArkhMbLeGw
 7mtvbapLn4oGl5+8j6tOvY8gGSWuHhVfRfThlj9LMBGLRVTbbw6oBq2ycPVJOautms4e3SYtomM
 2zwzGvmOB1mFfKsFAgJPVoGzgywgcZNUx5HIqJIa/4mUEIoZ5BpvcUzAFCXtt8IQcmYVY1Vt0Qy
 yKaaZUM+Pth65XvpmQPnqm+S0hEf1kbkKJ4MiJXHj18cevODQ9Jhkx+yzcDRn9LWCRwW04Lnxig
 UKqC1i3PK9azaot5zAgUDd/+zjL/xr5Z63Akas7ZUbUlryxc/plIP+CHYgxW1lJshyQ3AN1WEDb
 mrqWlP2w90Kj2QBSkznDw6/ztXS+jQJzGnFJLD0BcnuyNxgf3cDh5z3zxLtRUksh3QgyxVBjq4K
 Cet0qI+TxjaNAqTqPrw==
X-Proofpoint-ORIG-GUID: fZ0d-prYPwVRxRmyZ4B-HOIip8rlrtAI
X-Proofpoint-GUID: fZ0d-prYPwVRxRmyZ4B-HOIip8rlrtAI
X-Authority-Analysis: v=2.4 cv=BZlNQbt2 c=1 sm=1 tr=0 ts=6ae83711 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=h_3jC4m0AyQA:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=r_1tXGB3AAAA:8 a=veFuZ-MWkUqy_VuYZwIA:9 a=Wi-m_hBPOQrF8Rj2:21
 a=QEXdDO2ut3YA:10 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDAyOCBTYWx0ZWRfX9yInDM6rLMuQ
 FDQ5calnJvShawy4mhIW+Gxxv9Sxmz/7Y5K5pz2sCvXLqTiKsC20PC93sEEM1win9AF1kVGrVlR
 IKDhQ9vt9Gukau0R2zyb5DMYvbUqO4Y=
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

While this header is specific to Rogue, rename it and its contents
anyway with arch-independent prefixes for consistency with the other
firmware headers.

Signed-off-by: Alessio Belle <alessio.belle@imgtec.com>
Signed-off-by: Matt Coster <matt.coster@imgtec.com>
Signed-off-by: Alexandru Dadu <alexandru.dadu@imgtec.com>
---
 drivers/gpu/drm/imagination/pvr_fw_mips.c          |  28 +-
 drivers/gpu/drm/imagination/pvr_fw_mips_internal.h | 339 +++++++++++++++++++++
 .../drm/imagination/pvr_fw_mips_internal_check.h   |  35 +++
 .../gpu/drm/imagination/pvr_rogue_mips_internal.h  | 339 ---------------------
 .../imagination/pvr_rogue_mips_internal_check.h    |  35 ---
 drivers/gpu/drm/imagination/pvr_vm_mips.c          |  54 ++--
 6 files changed, 415 insertions(+), 415 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_fw_mips.c b/drivers/gpu/drm/imagination/pvr_fw_mips.c
index 7e4dd23e1f3f..de691aa06f86 100644
--- a/drivers/gpu/drm/imagination/pvr_fw_mips.c
+++ b/drivers/gpu/drm/imagination/pvr_fw_mips.c
@@ -4,9 +4,9 @@
 #include "pvr_device.h"
 #include "pvr_fw.h"
 #include "pvr_gem.h"
-#define PVR_ROGUE_MIPS_INTERNAL_H_EXPLICIT_INCLUDE
-#include "pvr_rogue_mips_internal.h"
-#undef PVR_ROGUE_MIPS_INTERNAL_H_EXPLICIT_INCLUDE
+#define PVR_FW_MIPS_INTERNAL_H_EXPLICIT_INCLUDE
+#include "pvr_fw_mips_internal.h"
+#undef PVR_FW_MIPS_INTERNAL_H_EXPLICIT_INCLUDE
 #include "pvr_vm_mips.h"
 
 #include <linux/err.h>
@@ -63,7 +63,7 @@ pvr_mips_fw_process(struct pvr_device *pvr_dev, const u8 *fw,
 	const struct pvr_fw_layout_entry *boot_data_entry;
 	const struct pvr_fw_layout_entry *exception_code_entry;
 	const struct pvr_fw_layout_entry *stack_entry;
-	struct rogue_mipsfw_boot_data *boot_data;
+	struct pvr_mipsfw_boot_data *boot_data;
 	dma_addr_t dma_addr;
 	int err;
 
@@ -90,8 +90,8 @@ pvr_mips_fw_process(struct pvr_device *pvr_dev, const u8 *fw,
 	if (!stack_entry)
 		return -EINVAL;
 
-	boot_data = (struct rogue_mipsfw_boot_data *)(fw_data_ptr + boot_data_entry->alloc_offset +
-						      ROGUE_MIPSFW_BOOTLDR_CONF_OFFSET);
+	boot_data = (struct pvr_mipsfw_boot_data *)(fw_data_ptr + boot_data_entry->alloc_offset +
+						    PVR_MIPSFW_BOOTLDR_CONF_OFFSET);
 
 	WARN_ON(pvr_fw_object_get_dma_addr(fw_dev->mem.data_obj, stack_entry->alloc_offset,
 					   &dma_addr));
@@ -104,8 +104,8 @@ pvr_mips_fw_process(struct pvr_device *pvr_dev, const u8 *fw,
 	if (err)
 		return err;
 
-	boot_data->pt_log2_page_size = ROGUE_MIPSFW_LOG2_PAGE_SIZE_4K;
-	boot_data->pt_num_pages = ROGUE_MIPSFW_MAX_NUM_PAGETABLE_PAGES;
+	boot_data->pt_log2_page_size = PVR_MIPSFW_LOG2_PAGE_SIZE_4K;
+	boot_data->pt_num_pages = PVR_MIPSFW_MAX_NUM_PAGETABLE_PAGES;
 	boot_data->reserved1 = 0;
 	boot_data->reserved2 = 0;
 
@@ -116,7 +116,7 @@ static int
 pvr_mips_wrapper_init(struct pvr_device *pvr_dev)
 {
 	struct pvr_fw_mips_data *fw_data = pvr_dev->fw_dev.processor_data.mips_data.fw_data;
-	const u64 remap_settings = ROGUE_MIPSFW_BOOT_REMAP_LOG2_SEGMENT_SIZE;
+	const u64 remap_settings = PVR_MIPSFW_BOOT_REMAP_LOG2_SEGMENT_SIZE;
 	u32 phys_bus_width;
 
 	int err = PVR_FEATURE_VALUE(pvr_dev, phys_bus_width, &phys_bus_width);
@@ -129,13 +129,13 @@ pvr_mips_wrapper_init(struct pvr_device *pvr_dev)
 		return -EINVAL;
 
 	pvr_cr_write32(pvr_dev, ROGUE_CR_MIPS_WRAPPER_CONFIG,
-		       (ROGUE_MIPSFW_REGISTERS_VIRTUAL_BASE >>
-			ROGUE_MIPSFW_WRAPPER_CONFIG_REGBANK_ADDR_ALIGN) |
+		       (PVR_MIPSFW_REGISTERS_VIRTUAL_BASE >>
+			PVR_MIPSFW_WRAPPER_CONFIG_REGBANK_ADDR_ALIGN) |
 		       ROGUE_CR_MIPS_WRAPPER_CONFIG_BOOT_ISA_MODE_MICROMIPS);
 
 	/* Configure remap for boot code, boot data and exceptions code areas. */
 	pvr_cr_write64(pvr_dev, ROGUE_CR_MIPS_ADDR_REMAP1_CONFIG1,
-		       ROGUE_MIPSFW_BOOT_REMAP_PHYS_ADDR_IN |
+		       PVR_MIPSFW_BOOT_REMAP_PHYS_ADDR_IN |
 		       ROGUE_CR_MIPS_ADDR_REMAP1_CONFIG1_MODE_ENABLE_EN);
 	pvr_cr_write64(pvr_dev, ROGUE_CR_MIPS_ADDR_REMAP1_CONFIG2,
 		       (fw_data->boot_code_dma_addr &
@@ -157,14 +157,14 @@ pvr_mips_wrapper_init(struct pvr_device *pvr_dev)
 	}
 
 	pvr_cr_write64(pvr_dev, ROGUE_CR_MIPS_ADDR_REMAP2_CONFIG1,
-		       ROGUE_MIPSFW_DATA_REMAP_PHYS_ADDR_IN |
+		       PVR_MIPSFW_DATA_REMAP_PHYS_ADDR_IN |
 		       ROGUE_CR_MIPS_ADDR_REMAP2_CONFIG1_MODE_ENABLE_EN);
 	pvr_cr_write64(pvr_dev, ROGUE_CR_MIPS_ADDR_REMAP2_CONFIG2,
 		       (fw_data->boot_data_dma_addr &
 			~ROGUE_CR_MIPS_ADDR_REMAP2_CONFIG2_ADDR_OUT_CLRMSK) | remap_settings);
 
 	pvr_cr_write64(pvr_dev, ROGUE_CR_MIPS_ADDR_REMAP3_CONFIG1,
-		       ROGUE_MIPSFW_CODE_REMAP_PHYS_ADDR_IN |
+		       PVR_MIPSFW_CODE_REMAP_PHYS_ADDR_IN |
 		       ROGUE_CR_MIPS_ADDR_REMAP3_CONFIG1_MODE_ENABLE_EN);
 	pvr_cr_write64(pvr_dev, ROGUE_CR_MIPS_ADDR_REMAP3_CONFIG2,
 		       (fw_data->exception_code_dma_addr &
diff --git a/drivers/gpu/drm/imagination/pvr_fw_mips_internal.h b/drivers/gpu/drm/imagination/pvr_fw_mips_internal.h
new file mode 100644
index 000000000000..f13829e63e1c
--- /dev/null
+++ b/drivers/gpu/drm/imagination/pvr_fw_mips_internal.h
@@ -0,0 +1,339 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR MIT */
+/* Copyright (c) 2023 Imagination Technologies Ltd. */
+
+#ifndef PVR_FW_MIPS_INTERNAL_H
+#define PVR_FW_MIPS_INTERNAL_H
+
+#ifndef PVR_FW_MIPS_INTERNAL_H_EXPLICIT_INCLUDE
+#error This file may only be included if explicitly defined
+#endif
+
+#include <linux/bits.h>
+#include <linux/types.h>
+
+/* Utility defines for memory management. */
+#define PVR_MIPSFW_LOG2_PAGE_SIZE_4K (12)
+#define PVR_MIPSFW_PAGE_SIZE_4K (0x1 << PVR_MIPSFW_LOG2_PAGE_SIZE_4K)
+#define PVR_MIPSFW_PAGE_MASK_4K (PVR_MIPSFW_PAGE_SIZE_4K - 1)
+#define PVR_MIPSFW_LOG2_PAGE_SIZE_64K (16)
+#define PVR_MIPSFW_PAGE_SIZE_64K (0x1 << PVR_MIPSFW_LOG2_PAGE_SIZE_64K)
+#define PVR_MIPSFW_PAGE_MASK_64K (PVR_MIPSFW_PAGE_SIZE_64K - 1)
+#define PVR_MIPSFW_LOG2_PAGE_SIZE_256K (18)
+#define PVR_MIPSFW_PAGE_SIZE_256K (0x1 << PVR_MIPSFW_LOG2_PAGE_SIZE_256K)
+#define PVR_MIPSFW_PAGE_MASK_256K (PVR_MIPSFW_PAGE_SIZE_256K - 1)
+#define PVR_MIPSFW_LOG2_PAGE_SIZE_1MB (20)
+#define PVR_MIPSFW_PAGE_SIZE_1MB (0x1 << PVR_MIPSFW_LOG2_PAGE_SIZE_1MB)
+#define PVR_MIPSFW_PAGE_MASK_1MB (PVR_MIPSFW_PAGE_SIZE_1MB - 1)
+#define PVR_MIPSFW_LOG2_PAGE_SIZE_4MB (22)
+#define PVR_MIPSFW_PAGE_SIZE_4MB (0x1 << PVR_MIPSFW_LOG2_PAGE_SIZE_4MB)
+#define PVR_MIPSFW_PAGE_MASK_4MB (PVR_MIPSFW_PAGE_SIZE_4MB - 1)
+#define PVR_MIPSFW_LOG2_PTE_ENTRY_SIZE (2)
+/* log2 page table sizes dependent on FW heap size and page size (for each OS). */
+#define PVR_MIPSFW_LOG2_PAGETABLE_SIZE_4K(pvr_dev) ((pvr_dev)->fw_dev.fw_heap_info.log2_size - \
+						    PVR_MIPSFW_LOG2_PAGE_SIZE_4K +    \
+						    PVR_MIPSFW_LOG2_PTE_ENTRY_SIZE)
+#define PVR_MIPSFW_LOG2_PAGETABLE_SIZE_64K(pvr_dev) ((pvr_dev)->fw_dev.fw_heap_info.log2_size - \
+						     PVR_MIPSFW_LOG2_PAGE_SIZE_64K +   \
+						     PVR_MIPSFW_LOG2_PTE_ENTRY_SIZE)
+/* Maximum number of page table pages (both Host and MIPS pages). */
+#define PVR_MIPSFW_MAX_NUM_PAGETABLE_PAGES (4)
+/* Total number of TLB entries. */
+#define PVR_MIPSFW_NUMBER_OF_TLB_ENTRIES (16)
+/* "Uncached" caching policy. */
+#define PVR_MIPSFW_UNCACHED_CACHE_POLICY (2)
+/* "Write-back write-allocate" caching policy. */
+#define PVR_MIPSFW_WRITEBACK_CACHE_POLICY (3)
+/* "Write-through no write-allocate" caching policy. */
+#define PVR_MIPSFW_WRITETHROUGH_CACHE_POLICY (1)
+/* Cached policy used by MIPS in case of physical bus on 32 bit. */
+#define PVR_MIPSFW_CACHED_POLICY (PVR_MIPSFW_WRITEBACK_CACHE_POLICY)
+/* Cached policy used by MIPS in case of physical bus on more than 32 bit. */
+#define PVR_MIPSFW_CACHED_POLICY_ABOVE_32BIT (PVR_MIPSFW_WRITETHROUGH_CACHE_POLICY)
+/* Total number of Remap entries. */
+#define PVR_MIPSFW_NUMBER_OF_REMAP_ENTRIES (2 * PVR_MIPSFW_NUMBER_OF_TLB_ENTRIES)
+
+/* MIPS EntryLo/PTE format. */
+
+#define PVR_MIPSFW_ENTRYLO_READ_INHIBIT_SHIFT (31U)
+#define PVR_MIPSFW_ENTRYLO_READ_INHIBIT_CLRMSK (0X7FFFFFFF)
+#define PVR_MIPSFW_ENTRYLO_READ_INHIBIT_EN (0X80000000)
+
+#define PVR_MIPSFW_ENTRYLO_EXEC_INHIBIT_SHIFT (30U)
+#define PVR_MIPSFW_ENTRYLO_EXEC_INHIBIT_CLRMSK (0XBFFFFFFF)
+#define PVR_MIPSFW_ENTRYLO_EXEC_INHIBIT_EN (0X40000000)
+
+/* Page Frame Number */
+#define PVR_MIPSFW_ENTRYLO_PFN_SHIFT (6)
+#define PVR_MIPSFW_ENTRYLO_PFN_ALIGNSHIFT (12)
+/* Mask used for the MIPS Page Table in case of physical bus on 32 bit. */
+#define PVR_MIPSFW_ENTRYLO_PFN_MASK (0x03FFFFC0)
+#define PVR_MIPSFW_ENTRYLO_PFN_SIZE (20)
+/* Mask used for the MIPS Page Table in case of physical bus on more than 32 bit. */
+#define PVR_MIPSFW_ENTRYLO_PFN_MASK_ABOVE_32BIT (0x3FFFFFC0)
+#define PVR_MIPSFW_ENTRYLO_PFN_SIZE_ABOVE_32BIT (24)
+#define PVR_MIPSFW_ADDR_TO_ENTRYLO_PFN_RSHIFT (PVR_MIPSFW_ENTRYLO_PFN_ALIGNSHIFT - \
+					       PVR_MIPSFW_ENTRYLO_PFN_SHIFT)
+
+#define PVR_MIPSFW_ENTRYLO_CACHE_POLICY_SHIFT (3U)
+#define PVR_MIPSFW_ENTRYLO_CACHE_POLICY_CLRMSK (0XFFFFFFC7)
+
+#define PVR_MIPSFW_ENTRYLO_DIRTY_SHIFT (2U)
+#define PVR_MIPSFW_ENTRYLO_DIRTY_CLRMSK (0XFFFFFFFB)
+#define PVR_MIPSFW_ENTRYLO_DIRTY_EN (0X00000004)
+
+#define PVR_MIPSFW_ENTRYLO_VALID_SHIFT (1U)
+#define PVR_MIPSFW_ENTRYLO_VALID_CLRMSK (0XFFFFFFFD)
+#define PVR_MIPSFW_ENTRYLO_VALID_EN (0X00000002)
+
+#define PVR_MIPSFW_ENTRYLO_GLOBAL_SHIFT (0U)
+#define PVR_MIPSFW_ENTRYLO_GLOBAL_CLRMSK (0XFFFFFFFE)
+#define PVR_MIPSFW_ENTRYLO_GLOBAL_EN (0X00000001)
+
+#define PVR_MIPSFW_ENTRYLO_DVG (PVR_MIPSFW_ENTRYLO_DIRTY_EN | \
+				PVR_MIPSFW_ENTRYLO_VALID_EN | \
+				PVR_MIPSFW_ENTRYLO_GLOBAL_EN)
+#define PVR_MIPSFW_ENTRYLO_UNCACHED (PVR_MIPSFW_UNCACHED_CACHE_POLICY << \
+				     PVR_MIPSFW_ENTRYLO_CACHE_POLICY_SHIFT)
+#define PVR_MIPSFW_ENTRYLO_DVG_UNCACHED (PVR_MIPSFW_ENTRYLO_DVG | \
+					 PVR_MIPSFW_ENTRYLO_UNCACHED)
+
+/* Remap Range Config Addr Out. */
+/* These defines refer to the upper half of the Remap Range Config register. */
+#define PVR_MIPSFW_REMAP_RANGE_ADDR_OUT_MASK (0x0FFFFFF0)
+#define PVR_MIPSFW_REMAP_RANGE_ADDR_OUT_SHIFT (4) /* wrt upper half of the register. */
+#define PVR_MIPSFW_REMAP_RANGE_ADDR_OUT_ALIGNSHIFT (12)
+#define PVR_MIPSFW_ADDR_TO_RR_ADDR_OUT_RSHIFT (PVR_MIPSFW_REMAP_RANGE_ADDR_OUT_ALIGNSHIFT - \
+					       PVR_MIPSFW_REMAP_RANGE_ADDR_OUT_SHIFT)
+
+/*
+ * Pages to trampoline problematic physical addresses:
+ *   - PVR_MIPSFW_BOOT_REMAP_PHYS_ADDR_IN : 0x1FC0_0000
+ *   - PVR_MIPSFW_DATA_REMAP_PHYS_ADDR_IN : 0x1FC0_1000
+ *   - PVR_MIPSFW_CODE_REMAP_PHYS_ADDR_IN : 0x1FC0_2000
+ *   - (benign trampoline)               : 0x1FC0_3000
+ * that would otherwise be erroneously remapped by the MIPS wrapper.
+ * (see "Firmware virtual layout and remap configuration" section below)
+ */
+
+#define PVR_MIPSFW_TRAMPOLINE_LOG2_NUMPAGES (2)
+#define PVR_MIPSFW_TRAMPOLINE_NUMPAGES BIT(PVR_MIPSFW_TRAMPOLINE_LOG2_NUMPAGES)
+#define PVR_MIPSFW_TRAMPOLINE_SIZE (PVR_MIPSFW_TRAMPOLINE_NUMPAGES << \
+				    PVR_MIPSFW_LOG2_PAGE_SIZE_4K)
+#define PVR_MIPSFW_TRAMPOLINE_LOG2_SEGMENT_SIZE (PVR_MIPSFW_TRAMPOLINE_LOG2_NUMPAGES + \
+						 PVR_MIPSFW_LOG2_PAGE_SIZE_4K)
+
+#define PVR_MIPSFW_TRAMPOLINE_TARGET_PHYS_ADDR (PVR_MIPSFW_BOOT_REMAP_PHYS_ADDR_IN)
+#define PVR_MIPSFW_TRAMPOLINE_OFFSET(a) ((a) - PVR_MIPSFW_BOOT_REMAP_PHYS_ADDR_IN)
+
+#define PVR_MIPSFW_SENSITIVE_ADDR(a) (PVR_MIPSFW_BOOT_REMAP_PHYS_ADDR_IN == \
+				      (~((1 << PVR_MIPSFW_TRAMPOLINE_LOG2_SEGMENT_SIZE) - 1) \
+				       & (a)))
+
+/* Firmware virtual layout and remap configuration. */
+/*
+ * For each remap region we define:
+ * - the virtual base used by the Firmware to access code/data through that region
+ * - the microAptivAP physical address correspondent to the virtual base address,
+ *   used as input address and remapped to the actual physical address
+ * - log2 of size of the region remapped by the MIPS wrapper, i.e. number of bits from
+ *   the bottom of the base input address that survive onto the output address
+ *   (this defines both the alignment and the maximum size of the remapped region)
+ * - one or more code/data segments within the remapped region.
+ */
+
+/* Boot remap setup. */
+#define PVR_MIPSFW_BOOT_REMAP_VIRTUAL_BASE (0xBFC00000)
+#define PVR_MIPSFW_BOOT_REMAP_PHYS_ADDR_IN (0x1FC00000)
+#define PVR_MIPSFW_BOOT_REMAP_LOG2_SEGMENT_SIZE (12)
+#define PVR_MIPSFW_BOOT_NMI_CODE_VIRTUAL_BASE (PVR_MIPSFW_BOOT_REMAP_VIRTUAL_BASE)
+
+/* Data remap setup. */
+#define PVR_MIPSFW_DATA_REMAP_VIRTUAL_BASE (0xBFC01000)
+#define PVR_MIPSFW_DATA_CACHED_REMAP_VIRTUAL_BASE (0x9FC01000)
+#define PVR_MIPSFW_DATA_REMAP_PHYS_ADDR_IN (0x1FC01000)
+#define PVR_MIPSFW_DATA_REMAP_LOG2_SEGMENT_SIZE (12)
+#define PVR_MIPSFW_BOOT_NMI_DATA_VIRTUAL_BASE (PVR_MIPSFW_DATA_REMAP_VIRTUAL_BASE)
+
+/* Code remap setup. */
+#define PVR_MIPSFW_CODE_REMAP_VIRTUAL_BASE (0x9FC02000)
+#define PVR_MIPSFW_CODE_REMAP_PHYS_ADDR_IN (0x1FC02000)
+#define PVR_MIPSFW_CODE_REMAP_LOG2_SEGMENT_SIZE (12)
+#define PVR_MIPSFW_EXCEPTIONS_VIRTUAL_BASE (PVR_MIPSFW_CODE_REMAP_VIRTUAL_BASE)
+
+/* Permanent mappings setup. */
+#define PVR_MIPSFW_PT_VIRTUAL_BASE (0xCF000000)
+#define PVR_MIPSFW_REGISTERS_VIRTUAL_BASE (0xCF800000)
+#define PVR_MIPSFW_STACK_VIRTUAL_BASE (0xCF600000)
+
+/* Bootloader configuration data. */
+/*
+ * Bootloader configuration offset (where PVR_MIPSFW_BOOT_DATA lives)
+ * within the bootloader/NMI data page.
+ */
+#define PVR_MIPSFW_BOOTLDR_CONF_OFFSET (0x0)
+
+/* NMI shared data. */
+/* Base address of the shared data within the bootloader/NMI data page. */
+#define PVR_MIPSFW_NMI_SHARED_DATA_BASE (0x100)
+/* Size used by Debug dump data. */
+#define PVR_MIPSFW_NMI_SHARED_SIZE (0x2B0)
+/* Offsets in the NMI shared area in 32-bit words. */
+#define PVR_MIPSFW_NMI_SYNC_FLAG_OFFSET (0x0)
+#define PVR_MIPSFW_NMI_STATE_OFFSET (0x1)
+#define PVR_MIPSFW_NMI_ERROR_STATE_SET (0x1)
+
+/* MIPS boot stage. */
+#define PVR_MIPSFW_BOOT_STAGE_OFFSET (0x400)
+
+/*
+ * MIPS private data in the bootloader data page.
+ * Memory below this offset is used by the FW only, no interface data allowed.
+ */
+#define PVR_MIPSFW_PRIVATE_DATA_OFFSET (0x800)
+
+struct pvr_mipsfw_boot_data {
+	u64 stack_phys_addr;
+	u64 reg_base;
+	u64 pt_phys_addr[PVR_MIPSFW_MAX_NUM_PAGETABLE_PAGES];
+	u32 pt_log2_page_size;
+	u32 pt_num_pages;
+	u32 reserved1;
+	u32 reserved2;
+};
+
+#define PVR_MIPSFW_GET_OFFSET_IN_DWORDS(offset) ((offset) / sizeof(u32))
+#define PVR_MIPSFW_GET_OFFSET_IN_QWORDS(offset) ((offset) / sizeof(u64))
+
+/* Used for compatibility checks. */
+#define PVR_MIPSFW_ARCHTYPE_VER_CLRMSK (0xFFFFE3FFU)
+#define PVR_MIPSFW_ARCHTYPE_VER_SHIFT (10U)
+#define PVR_MIPSFW_CORE_ID_VALUE (0x001U)
+#define PVR_FW_PROCESSOR_MIPS "MIPS"
+
+/* microAptivAP cache line size. */
+#define PVR_MIPSFW_MICROAPTIVEAP_CACHELINE_SIZE (16U)
+
+/*
+ * The SOCIF transactions are identified with the top 16 bits of the physical address emitted by
+ * the MIPS.
+ */
+#define PVR_MIPSFW_WRAPPER_CONFIG_REGBANK_ADDR_ALIGN (16U)
+
+/* Values to put in the MIPS selectors for performance counters. */
+/* Icache accesses in COUNTER0. */
+#define PVR_MIPSFW_PERF_COUNT_CTRL_ICACHE_ACCESSES_C0 (9U)
+/* Icache misses in COUNTER1. */
+#define PVR_MIPSFW_PERF_COUNT_CTRL_ICACHE_MISSES_C1 (9U)
+
+/* Dcache accesses in COUNTER0. */
+#define PVR_MIPSFW_PERF_COUNT_CTRL_DCACHE_ACCESSES_C0 (10U)
+/* Dcache misses in COUNTER1. */
+#define PVR_MIPSFW_PERF_COUNT_CTRL_DCACHE_MISSES_C1 (11U)
+
+/* ITLB instruction accesses in COUNTER0. */
+#define PVR_MIPSFW_PERF_COUNT_CTRL_ITLB_INSTR_ACCESSES_C0 (5U)
+/* JTLB instruction accesses misses in COUNTER1. */
+#define PVR_MIPSFW_PERF_COUNT_CTRL_JTLB_INSTR_MISSES_C1 (7U)
+
+  /* Instructions completed in COUNTER0. */
+#define PVR_MIPSFW_PERF_COUNT_CTRL_INSTR_COMPLETED_C0 (1U)
+/* JTLB data misses in COUNTER1. */
+#define PVR_MIPSFW_PERF_COUNT_CTRL_JTLB_DATA_MISSES_C1 (8U)
+
+/* Shift for the Event field in the MIPS perf ctrl registers. */
+#define PVR_MIPSFW_PERF_COUNT_CTRL_EVENT_SHIFT (5U)
+
+/* Additional flags for performance counters. See MIPS manual for further reference. */
+#define PVR_MIPSFW_PERF_COUNT_CTRL_COUNT_USER_MODE (8U)
+#define PVR_MIPSFW_PERF_COUNT_CTRL_COUNT_KERNEL_MODE (2U)
+#define PVR_MIPSFW_PERF_COUNT_CTRL_COUNT_EXL (1U)
+
+#define PVR_MIPSFW_C0_NBHWIRQ	8
+
+/* Macros to decode C0_Cause register. */
+#define PVR_MIPSFW_C0_CAUSE_EXCCODE(cause) (((cause) & 0x7c) >> 2)
+#define PVR_MIPSFW_C0_CAUSE_EXCCODE_FWERROR 9
+/* Use only when Coprocessor Unusable exception. */
+#define PVR_MIPSFW_C0_CAUSE_UNUSABLE_UNIT(cause) (((cause) >> 28) & 0x3)
+#define PVR_MIPSFW_C0_CAUSE_PENDING_HWIRQ(cause) (((cause) & 0x3fc00) >> 10)
+#define PVR_MIPSFW_C0_CAUSE_FDCIPENDING BIT(21)
+#define PVR_MIPSFW_C0_CAUSE_IV BIT(23)
+#define PVR_MIPSFW_C0_CAUSE_IC BIT(25)
+#define PVR_MIPSFW_C0_CAUSE_PCIPENDING BIT(26)
+#define PVR_MIPSFW_C0_CAUSE_TIPENDING BIT(30)
+#define PVR_MIPSFW_C0_CAUSE_BRANCH_DELAY BIT(31)
+
+/* Macros to decode C0_Debug register. */
+#define PVR_MIPSFW_C0_DEBUG_EXCCODE(debug) (((debug) >> 10) & 0x1f)
+#define PVR_MIPSFW_C0_DEBUG_DSS BIT(0)
+#define PVR_MIPSFW_C0_DEBUG_DBP BIT(1)
+#define PVR_MIPSFW_C0_DEBUG_DDBL BIT(2)
+#define PVR_MIPSFW_C0_DEBUG_DDBS BIT(3)
+#define PVR_MIPSFW_C0_DEBUG_DIB BIT(4)
+#define PVR_MIPSFW_C0_DEBUG_DINT BIT(5)
+#define PVR_MIPSFW_C0_DEBUG_DIBIMPR BIT(6)
+#define PVR_MIPSFW_C0_DEBUG_DDBLIMPR BIT(18)
+#define PVR_MIPSFW_C0_DEBUG_DDBSIMPR BIT(19)
+#define PVR_MIPSFW_C0_DEBUG_IEXI BIT(20)
+#define PVR_MIPSFW_C0_DEBUG_DBUSEP BIT(21)
+#define PVR_MIPSFW_C0_DEBUG_CACHEEP BIT(22)
+#define PVR_MIPSFW_C0_DEBUG_MCHECKP BIT(23)
+#define PVR_MIPSFW_C0_DEBUG_IBUSEP BIT(24)
+#define PVR_MIPSFW_C0_DEBUG_DM BIT(30)
+#define PVR_MIPSFW_C0_DEBUG_DBD BIT(31)
+
+/* Macros to decode TLB entries. */
+#define PVR_MIPSFW_TLB_GET_MASK(page_mask) (((page_mask) >> 13) & 0XFFFFU)
+/* Page size in KB. */
+#define PVR_MIPSFW_TLB_GET_PAGE_SIZE(page_mask) ((((page_mask) | 0x1FFF) + 1) >> 11)
+/* Page size in KB. */
+#define PVR_MIPSFW_TLB_GET_PAGE_MASK(page_size) ((((page_size) << 11) - 1) & ~0x7FF)
+#define PVR_MIPSFW_TLB_GET_VPN2(entry_hi) ((entry_hi) >> 13)
+#define PVR_MIPSFW_TLB_GET_COHERENCY(entry_lo) (((entry_lo) >> 3) & 0x7U)
+#define PVR_MIPSFW_TLB_GET_PFN(entry_lo) (((entry_lo) >> 6) & 0XFFFFFU)
+/* GET_PA uses a non-standard PFN mask for 36 bit addresses. */
+#define PVR_MIPSFW_TLB_GET_PA(entry_lo) (((u64)(entry_lo) & \
+					  PVR_MIPSFW_ENTRYLO_PFN_MASK_ABOVE_32BIT) << 6)
+#define PVR_MIPSFW_TLB_GET_INHIBIT(entry_lo) (((entry_lo) >> 30) & 0x3U)
+#define PVR_MIPSFW_TLB_GET_DGV(entry_lo) ((entry_lo) & 0x7U)
+#define PVR_MIPSFW_TLB_GLOBAL BIT(0)
+#define PVR_MIPSFW_TLB_VALID BIT(1)
+#define PVR_MIPSFW_TLB_DIRTY BIT(2)
+#define PVR_MIPSFW_TLB_XI BIT(30)
+#define PVR_MIPSFW_TLB_RI BIT(31)
+
+#define PVR_MIPSFW_REMAP_GET_REGION_SIZE(region_size_encoding) (1 << (((region_size_encoding) \
+								      + 1) << 1))
+
+struct pvr_mips_tlb_entry {
+	u32 tlb_page_mask;
+	u32 tlb_hi;
+	u32 tlb_lo0;
+	u32 tlb_lo1;
+};
+
+struct pvr_mips_remap_entry {
+	u32 remap_addr_in;  /* Always 4k aligned. */
+	u32 remap_addr_out; /* Always 4k aligned. */
+	u32 remap_region_size;
+};
+
+struct pvr_mips_state {
+	u32 error_state; /* This must come first in the structure. */
+	u32 error_epc;
+	u32 status_register;
+	u32 cause_register;
+	u32 bad_register;
+	u32 epc;
+	u32 sp;
+	u32 debug;
+	u32 depc;
+	u32 bad_instr;
+	u32 unmapped_address;
+	struct pvr_mips_tlb_entry tlb[PVR_MIPSFW_NUMBER_OF_TLB_ENTRIES];
+	struct pvr_mips_remap_entry remap[PVR_MIPSFW_NUMBER_OF_REMAP_ENTRIES];
+};
+
+#include "pvr_fw_mips_internal_check.h"
+
+#endif /* PVR_FW_MIPS_INTERNAL_H */
diff --git a/drivers/gpu/drm/imagination/pvr_fw_mips_internal_check.h b/drivers/gpu/drm/imagination/pvr_fw_mips_internal_check.h
new file mode 100644
index 000000000000..efa41b5c41f9
--- /dev/null
+++ b/drivers/gpu/drm/imagination/pvr_fw_mips_internal_check.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR MIT */
+/* Copyright (c) 2023 Imagination Technologies Ltd. */
+
+#ifndef PVR_FW_MIPS_INTERNAL_CHECK_H
+#define PVR_FW_MIPS_INTERNAL_CHECK_H
+
+#include "pvr_check.h"
+
+OFFSET_CHECK(struct pvr_mips_tlb_entry, tlb_page_mask, 0);
+OFFSET_CHECK(struct pvr_mips_tlb_entry, tlb_hi, 4);
+OFFSET_CHECK(struct pvr_mips_tlb_entry, tlb_lo0, 8);
+OFFSET_CHECK(struct pvr_mips_tlb_entry, tlb_lo1, 12);
+SIZE_CHECK(struct pvr_mips_tlb_entry, 16);
+
+OFFSET_CHECK(struct pvr_mips_remap_entry, remap_addr_in, 0);
+OFFSET_CHECK(struct pvr_mips_remap_entry, remap_addr_out, 4);
+OFFSET_CHECK(struct pvr_mips_remap_entry, remap_region_size, 8);
+SIZE_CHECK(struct pvr_mips_remap_entry, 12);
+
+OFFSET_CHECK(struct pvr_mips_state, error_state, 0);
+OFFSET_CHECK(struct pvr_mips_state, error_epc, 4);
+OFFSET_CHECK(struct pvr_mips_state, status_register, 8);
+OFFSET_CHECK(struct pvr_mips_state, cause_register, 12);
+OFFSET_CHECK(struct pvr_mips_state, bad_register, 16);
+OFFSET_CHECK(struct pvr_mips_state, epc, 20);
+OFFSET_CHECK(struct pvr_mips_state, sp, 24);
+OFFSET_CHECK(struct pvr_mips_state, debug, 28);
+OFFSET_CHECK(struct pvr_mips_state, depc, 32);
+OFFSET_CHECK(struct pvr_mips_state, bad_instr, 36);
+OFFSET_CHECK(struct pvr_mips_state, unmapped_address, 40);
+OFFSET_CHECK(struct pvr_mips_state, tlb, 44);
+OFFSET_CHECK(struct pvr_mips_state, remap, 300);
+SIZE_CHECK(struct pvr_mips_state, 684);
+
+#endif /* PVR_FW_MIPS_INTERNAL_CHECK_H */
diff --git a/drivers/gpu/drm/imagination/pvr_rogue_mips_internal.h b/drivers/gpu/drm/imagination/pvr_rogue_mips_internal.h
deleted file mode 100644
index 68b4db83cb4b..000000000000
--- a/drivers/gpu/drm/imagination/pvr_rogue_mips_internal.h
+++ /dev/null
@@ -1,339 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only OR MIT */
-/* Copyright (c) 2023 Imagination Technologies Ltd. */
-
-#ifndef PVR_ROGUE_MIPS_INTERNAL_H
-#define PVR_ROGUE_MIPS_INTERNAL_H
-
-#ifndef PVR_ROGUE_MIPS_INTERNAL_H_EXPLICIT_INCLUDE
-#error This file may only be included if explicitly defined
-#endif
-
-#include <linux/bits.h>
-#include <linux/types.h>
-
-/* Utility defines for memory management. */
-#define ROGUE_MIPSFW_LOG2_PAGE_SIZE_4K (12)
-#define ROGUE_MIPSFW_PAGE_SIZE_4K (0x1 << ROGUE_MIPSFW_LOG2_PAGE_SIZE_4K)
-#define ROGUE_MIPSFW_PAGE_MASK_4K (ROGUE_MIPSFW_PAGE_SIZE_4K - 1)
-#define ROGUE_MIPSFW_LOG2_PAGE_SIZE_64K (16)
-#define ROGUE_MIPSFW_PAGE_SIZE_64K (0x1 << ROGUE_MIPSFW_LOG2_PAGE_SIZE_64K)
-#define ROGUE_MIPSFW_PAGE_MASK_64K (ROGUE_MIPSFW_PAGE_SIZE_64K - 1)
-#define ROGUE_MIPSFW_LOG2_PAGE_SIZE_256K (18)
-#define ROGUE_MIPSFW_PAGE_SIZE_256K (0x1 << ROGUE_MIPSFW_LOG2_PAGE_SIZE_256K)
-#define ROGUE_MIPSFW_PAGE_MASK_256K (ROGUE_MIPSFW_PAGE_SIZE_256K - 1)
-#define ROGUE_MIPSFW_LOG2_PAGE_SIZE_1MB (20)
-#define ROGUE_MIPSFW_PAGE_SIZE_1MB (0x1 << ROGUE_MIPSFW_LOG2_PAGE_SIZE_1MB)
-#define ROGUE_MIPSFW_PAGE_MASK_1MB (ROGUE_MIPSFW_PAGE_SIZE_1MB - 1)
-#define ROGUE_MIPSFW_LOG2_PAGE_SIZE_4MB (22)
-#define ROGUE_MIPSFW_PAGE_SIZE_4MB (0x1 << ROGUE_MIPSFW_LOG2_PAGE_SIZE_4MB)
-#define ROGUE_MIPSFW_PAGE_MASK_4MB (ROGUE_MIPSFW_PAGE_SIZE_4MB - 1)
-#define ROGUE_MIPSFW_LOG2_PTE_ENTRY_SIZE (2)
-/* log2 page table sizes dependent on FW heap size and page size (for each OS). */
-#define ROGUE_MIPSFW_LOG2_PAGETABLE_SIZE_4K(pvr_dev) ((pvr_dev)->fw_dev.fw_heap_info.log2_size - \
-						      ROGUE_MIPSFW_LOG2_PAGE_SIZE_4K +    \
-						      ROGUE_MIPSFW_LOG2_PTE_ENTRY_SIZE)
-#define ROGUE_MIPSFW_LOG2_PAGETABLE_SIZE_64K(pvr_dev) ((pvr_dev)->fw_dev.fw_heap_info.log2_size - \
-						       ROGUE_MIPSFW_LOG2_PAGE_SIZE_64K +   \
-						       ROGUE_MIPSFW_LOG2_PTE_ENTRY_SIZE)
-/* Maximum number of page table pages (both Host and MIPS pages). */
-#define ROGUE_MIPSFW_MAX_NUM_PAGETABLE_PAGES (4)
-/* Total number of TLB entries. */
-#define ROGUE_MIPSFW_NUMBER_OF_TLB_ENTRIES (16)
-/* "Uncached" caching policy. */
-#define ROGUE_MIPSFW_UNCACHED_CACHE_POLICY (2)
-/* "Write-back write-allocate" caching policy. */
-#define ROGUE_MIPSFW_WRITEBACK_CACHE_POLICY (3)
-/* "Write-through no write-allocate" caching policy. */
-#define ROGUE_MIPSFW_WRITETHROUGH_CACHE_POLICY (1)
-/* Cached policy used by MIPS in case of physical bus on 32 bit. */
-#define ROGUE_MIPSFW_CACHED_POLICY (ROGUE_MIPSFW_WRITEBACK_CACHE_POLICY)
-/* Cached policy used by MIPS in case of physical bus on more than 32 bit. */
-#define ROGUE_MIPSFW_CACHED_POLICY_ABOVE_32BIT (ROGUE_MIPSFW_WRITETHROUGH_CACHE_POLICY)
-/* Total number of Remap entries. */
-#define ROGUE_MIPSFW_NUMBER_OF_REMAP_ENTRIES (2 * ROGUE_MIPSFW_NUMBER_OF_TLB_ENTRIES)
-
-/* MIPS EntryLo/PTE format. */
-
-#define ROGUE_MIPSFW_ENTRYLO_READ_INHIBIT_SHIFT (31U)
-#define ROGUE_MIPSFW_ENTRYLO_READ_INHIBIT_CLRMSK (0X7FFFFFFF)
-#define ROGUE_MIPSFW_ENTRYLO_READ_INHIBIT_EN (0X80000000)
-
-#define ROGUE_MIPSFW_ENTRYLO_EXEC_INHIBIT_SHIFT (30U)
-#define ROGUE_MIPSFW_ENTRYLO_EXEC_INHIBIT_CLRMSK (0XBFFFFFFF)
-#define ROGUE_MIPSFW_ENTRYLO_EXEC_INHIBIT_EN (0X40000000)
-
-/* Page Frame Number */
-#define ROGUE_MIPSFW_ENTRYLO_PFN_SHIFT (6)
-#define ROGUE_MIPSFW_ENTRYLO_PFN_ALIGNSHIFT (12)
-/* Mask used for the MIPS Page Table in case of physical bus on 32 bit. */
-#define ROGUE_MIPSFW_ENTRYLO_PFN_MASK (0x03FFFFC0)
-#define ROGUE_MIPSFW_ENTRYLO_PFN_SIZE (20)
-/* Mask used for the MIPS Page Table in case of physical bus on more than 32 bit. */
-#define ROGUE_MIPSFW_ENTRYLO_PFN_MASK_ABOVE_32BIT (0x3FFFFFC0)
-#define ROGUE_MIPSFW_ENTRYLO_PFN_SIZE_ABOVE_32BIT (24)
-#define ROGUE_MIPSFW_ADDR_TO_ENTRYLO_PFN_RSHIFT (ROGUE_MIPSFW_ENTRYLO_PFN_ALIGNSHIFT - \
-						 ROGUE_MIPSFW_ENTRYLO_PFN_SHIFT)
-
-#define ROGUE_MIPSFW_ENTRYLO_CACHE_POLICY_SHIFT (3U)
-#define ROGUE_MIPSFW_ENTRYLO_CACHE_POLICY_CLRMSK (0XFFFFFFC7)
-
-#define ROGUE_MIPSFW_ENTRYLO_DIRTY_SHIFT (2U)
-#define ROGUE_MIPSFW_ENTRYLO_DIRTY_CLRMSK (0XFFFFFFFB)
-#define ROGUE_MIPSFW_ENTRYLO_DIRTY_EN (0X00000004)
-
-#define ROGUE_MIPSFW_ENTRYLO_VALID_SHIFT (1U)
-#define ROGUE_MIPSFW_ENTRYLO_VALID_CLRMSK (0XFFFFFFFD)
-#define ROGUE_MIPSFW_ENTRYLO_VALID_EN (0X00000002)
-
-#define ROGUE_MIPSFW_ENTRYLO_GLOBAL_SHIFT (0U)
-#define ROGUE_MIPSFW_ENTRYLO_GLOBAL_CLRMSK (0XFFFFFFFE)
-#define ROGUE_MIPSFW_ENTRYLO_GLOBAL_EN (0X00000001)
-
-#define ROGUE_MIPSFW_ENTRYLO_DVG (ROGUE_MIPSFW_ENTRYLO_DIRTY_EN | \
-				  ROGUE_MIPSFW_ENTRYLO_VALID_EN | \
-				  ROGUE_MIPSFW_ENTRYLO_GLOBAL_EN)
-#define ROGUE_MIPSFW_ENTRYLO_UNCACHED (ROGUE_MIPSFW_UNCACHED_CACHE_POLICY << \
-				       ROGUE_MIPSFW_ENTRYLO_CACHE_POLICY_SHIFT)
-#define ROGUE_MIPSFW_ENTRYLO_DVG_UNCACHED (ROGUE_MIPSFW_ENTRYLO_DVG | \
-					   ROGUE_MIPSFW_ENTRYLO_UNCACHED)
-
-/* Remap Range Config Addr Out. */
-/* These defines refer to the upper half of the Remap Range Config register. */
-#define ROGUE_MIPSFW_REMAP_RANGE_ADDR_OUT_MASK (0x0FFFFFF0)
-#define ROGUE_MIPSFW_REMAP_RANGE_ADDR_OUT_SHIFT (4) /* wrt upper half of the register. */
-#define ROGUE_MIPSFW_REMAP_RANGE_ADDR_OUT_ALIGNSHIFT (12)
-#define ROGUE_MIPSFW_ADDR_TO_RR_ADDR_OUT_RSHIFT (ROGUE_MIPSFW_REMAP_RANGE_ADDR_OUT_ALIGNSHIFT - \
-						 ROGUE_MIPSFW_REMAP_RANGE_ADDR_OUT_SHIFT)
-
-/*
- * Pages to trampoline problematic physical addresses:
- *   - ROGUE_MIPSFW_BOOT_REMAP_PHYS_ADDR_IN : 0x1FC0_0000
- *   - ROGUE_MIPSFW_DATA_REMAP_PHYS_ADDR_IN : 0x1FC0_1000
- *   - ROGUE_MIPSFW_CODE_REMAP_PHYS_ADDR_IN : 0x1FC0_2000
- *   - (benign trampoline)               : 0x1FC0_3000
- * that would otherwise be erroneously remapped by the MIPS wrapper.
- * (see "Firmware virtual layout and remap configuration" section below)
- */
-
-#define ROGUE_MIPSFW_TRAMPOLINE_LOG2_NUMPAGES (2)
-#define ROGUE_MIPSFW_TRAMPOLINE_NUMPAGES BIT(ROGUE_MIPSFW_TRAMPOLINE_LOG2_NUMPAGES)
-#define ROGUE_MIPSFW_TRAMPOLINE_SIZE (ROGUE_MIPSFW_TRAMPOLINE_NUMPAGES << \
-				      ROGUE_MIPSFW_LOG2_PAGE_SIZE_4K)
-#define ROGUE_MIPSFW_TRAMPOLINE_LOG2_SEGMENT_SIZE (ROGUE_MIPSFW_TRAMPOLINE_LOG2_NUMPAGES + \
-						   ROGUE_MIPSFW_LOG2_PAGE_SIZE_4K)
-
-#define ROGUE_MIPSFW_TRAMPOLINE_TARGET_PHYS_ADDR (ROGUE_MIPSFW_BOOT_REMAP_PHYS_ADDR_IN)
-#define ROGUE_MIPSFW_TRAMPOLINE_OFFSET(a) ((a) - ROGUE_MIPSFW_BOOT_REMAP_PHYS_ADDR_IN)
-
-#define ROGUE_MIPSFW_SENSITIVE_ADDR(a) (ROGUE_MIPSFW_BOOT_REMAP_PHYS_ADDR_IN == \
-					(~((1 << ROGUE_MIPSFW_TRAMPOLINE_LOG2_SEGMENT_SIZE) - 1) \
-					 & (a)))
-
-/* Firmware virtual layout and remap configuration. */
-/*
- * For each remap region we define:
- * - the virtual base used by the Firmware to access code/data through that region
- * - the microAptivAP physical address correspondent to the virtual base address,
- *   used as input address and remapped to the actual physical address
- * - log2 of size of the region remapped by the MIPS wrapper, i.e. number of bits from
- *   the bottom of the base input address that survive onto the output address
- *   (this defines both the alignment and the maximum size of the remapped region)
- * - one or more code/data segments within the remapped region.
- */
-
-/* Boot remap setup. */
-#define ROGUE_MIPSFW_BOOT_REMAP_VIRTUAL_BASE (0xBFC00000)
-#define ROGUE_MIPSFW_BOOT_REMAP_PHYS_ADDR_IN (0x1FC00000)
-#define ROGUE_MIPSFW_BOOT_REMAP_LOG2_SEGMENT_SIZE (12)
-#define ROGUE_MIPSFW_BOOT_NMI_CODE_VIRTUAL_BASE (ROGUE_MIPSFW_BOOT_REMAP_VIRTUAL_BASE)
-
-/* Data remap setup. */
-#define ROGUE_MIPSFW_DATA_REMAP_VIRTUAL_BASE (0xBFC01000)
-#define ROGUE_MIPSFW_DATA_CACHED_REMAP_VIRTUAL_BASE (0x9FC01000)
-#define ROGUE_MIPSFW_DATA_REMAP_PHYS_ADDR_IN (0x1FC01000)
-#define ROGUE_MIPSFW_DATA_REMAP_LOG2_SEGMENT_SIZE (12)
-#define ROGUE_MIPSFW_BOOT_NMI_DATA_VIRTUAL_BASE (ROGUE_MIPSFW_DATA_REMAP_VIRTUAL_BASE)
-
-/* Code remap setup. */
-#define ROGUE_MIPSFW_CODE_REMAP_VIRTUAL_BASE (0x9FC02000)
-#define ROGUE_MIPSFW_CODE_REMAP_PHYS_ADDR_IN (0x1FC02000)
-#define ROGUE_MIPSFW_CODE_REMAP_LOG2_SEGMENT_SIZE (12)
-#define ROGUE_MIPSFW_EXCEPTIONS_VIRTUAL_BASE (ROGUE_MIPSFW_CODE_REMAP_VIRTUAL_BASE)
-
-/* Permanent mappings setup. */
-#define ROGUE_MIPSFW_PT_VIRTUAL_BASE (0xCF000000)
-#define ROGUE_MIPSFW_REGISTERS_VIRTUAL_BASE (0xCF800000)
-#define ROGUE_MIPSFW_STACK_VIRTUAL_BASE (0xCF600000)
-
-/* Bootloader configuration data. */
-/*
- * Bootloader configuration offset (where ROGUE_MIPSFW_BOOT_DATA lives)
- * within the bootloader/NMI data page.
- */
-#define ROGUE_MIPSFW_BOOTLDR_CONF_OFFSET (0x0)
-
-/* NMI shared data. */
-/* Base address of the shared data within the bootloader/NMI data page. */
-#define ROGUE_MIPSFW_NMI_SHARED_DATA_BASE (0x100)
-/* Size used by Debug dump data. */
-#define ROGUE_MIPSFW_NMI_SHARED_SIZE (0x2B0)
-/* Offsets in the NMI shared area in 32-bit words. */
-#define ROGUE_MIPSFW_NMI_SYNC_FLAG_OFFSET (0x0)
-#define ROGUE_MIPSFW_NMI_STATE_OFFSET (0x1)
-#define ROGUE_MIPSFW_NMI_ERROR_STATE_SET (0x1)
-
-/* MIPS boot stage. */
-#define ROGUE_MIPSFW_BOOT_STAGE_OFFSET (0x400)
-
-/*
- * MIPS private data in the bootloader data page.
- * Memory below this offset is used by the FW only, no interface data allowed.
- */
-#define ROGUE_MIPSFW_PRIVATE_DATA_OFFSET (0x800)
-
-struct rogue_mipsfw_boot_data {
-	u64 stack_phys_addr;
-	u64 reg_base;
-	u64 pt_phys_addr[ROGUE_MIPSFW_MAX_NUM_PAGETABLE_PAGES];
-	u32 pt_log2_page_size;
-	u32 pt_num_pages;
-	u32 reserved1;
-	u32 reserved2;
-};
-
-#define ROGUE_MIPSFW_GET_OFFSET_IN_DWORDS(offset) ((offset) / sizeof(u32))
-#define ROGUE_MIPSFW_GET_OFFSET_IN_QWORDS(offset) ((offset) / sizeof(u64))
-
-/* Used for compatibility checks. */
-#define ROGUE_MIPSFW_ARCHTYPE_VER_CLRMSK (0xFFFFE3FFU)
-#define ROGUE_MIPSFW_ARCHTYPE_VER_SHIFT (10U)
-#define ROGUE_MIPSFW_CORE_ID_VALUE (0x001U)
-#define ROGUE_FW_PROCESSOR_MIPS "MIPS"
-
-/* microAptivAP cache line size. */
-#define ROGUE_MIPSFW_MICROAPTIVEAP_CACHELINE_SIZE (16U)
-
-/*
- * The SOCIF transactions are identified with the top 16 bits of the physical address emitted by
- * the MIPS.
- */
-#define ROGUE_MIPSFW_WRAPPER_CONFIG_REGBANK_ADDR_ALIGN (16U)
-
-/* Values to put in the MIPS selectors for performance counters. */
-/* Icache accesses in COUNTER0. */
-#define ROGUE_MIPSFW_PERF_COUNT_CTRL_ICACHE_ACCESSES_C0 (9U)
-/* Icache misses in COUNTER1. */
-#define ROGUE_MIPSFW_PERF_COUNT_CTRL_ICACHE_MISSES_C1 (9U)
-
-/* Dcache accesses in COUNTER0. */
-#define ROGUE_MIPSFW_PERF_COUNT_CTRL_DCACHE_ACCESSES_C0 (10U)
-/* Dcache misses in COUNTER1. */
-#define ROGUE_MIPSFW_PERF_COUNT_CTRL_DCACHE_MISSES_C1 (11U)
-
-/* ITLB instruction accesses in COUNTER0. */
-#define ROGUE_MIPSFW_PERF_COUNT_CTRL_ITLB_INSTR_ACCESSES_C0 (5U)
-/* JTLB instruction accesses misses in COUNTER1. */
-#define ROGUE_MIPSFW_PERF_COUNT_CTRL_JTLB_INSTR_MISSES_C1 (7U)
-
-  /* Instructions completed in COUNTER0. */
-#define ROGUE_MIPSFW_PERF_COUNT_CTRL_INSTR_COMPLETED_C0 (1U)
-/* JTLB data misses in COUNTER1. */
-#define ROGUE_MIPSFW_PERF_COUNT_CTRL_JTLB_DATA_MISSES_C1 (8U)
-
-/* Shift for the Event field in the MIPS perf ctrl registers. */
-#define ROGUE_MIPSFW_PERF_COUNT_CTRL_EVENT_SHIFT (5U)
-
-/* Additional flags for performance counters. See MIPS manual for further reference. */
-#define ROGUE_MIPSFW_PERF_COUNT_CTRL_COUNT_USER_MODE (8U)
-#define ROGUE_MIPSFW_PERF_COUNT_CTRL_COUNT_KERNEL_MODE (2U)
-#define ROGUE_MIPSFW_PERF_COUNT_CTRL_COUNT_EXL (1U)
-
-#define ROGUE_MIPSFW_C0_NBHWIRQ	8
-
-/* Macros to decode C0_Cause register. */
-#define ROGUE_MIPSFW_C0_CAUSE_EXCCODE(cause) (((cause) & 0x7c) >> 2)
-#define ROGUE_MIPSFW_C0_CAUSE_EXCCODE_FWERROR 9
-/* Use only when Coprocessor Unusable exception. */
-#define ROGUE_MIPSFW_C0_CAUSE_UNUSABLE_UNIT(cause) (((cause) >> 28) & 0x3)
-#define ROGUE_MIPSFW_C0_CAUSE_PENDING_HWIRQ(cause) (((cause) & 0x3fc00) >> 10)
-#define ROGUE_MIPSFW_C0_CAUSE_FDCIPENDING BIT(21)
-#define ROGUE_MIPSFW_C0_CAUSE_IV BIT(23)
-#define ROGUE_MIPSFW_C0_CAUSE_IC BIT(25)
-#define ROGUE_MIPSFW_C0_CAUSE_PCIPENDING BIT(26)
-#define ROGUE_MIPSFW_C0_CAUSE_TIPENDING BIT(30)
-#define ROGUE_MIPSFW_C0_CAUSE_BRANCH_DELAY BIT(31)
-
-/* Macros to decode C0_Debug register. */
-#define ROGUE_MIPSFW_C0_DEBUG_EXCCODE(debug) (((debug) >> 10) & 0x1f)
-#define ROGUE_MIPSFW_C0_DEBUG_DSS BIT(0)
-#define ROGUE_MIPSFW_C0_DEBUG_DBP BIT(1)
-#define ROGUE_MIPSFW_C0_DEBUG_DDBL BIT(2)
-#define ROGUE_MIPSFW_C0_DEBUG_DDBS BIT(3)
-#define ROGUE_MIPSFW_C0_DEBUG_DIB BIT(4)
-#define ROGUE_MIPSFW_C0_DEBUG_DINT BIT(5)
-#define ROGUE_MIPSFW_C0_DEBUG_DIBIMPR BIT(6)
-#define ROGUE_MIPSFW_C0_DEBUG_DDBLIMPR BIT(18)
-#define ROGUE_MIPSFW_C0_DEBUG_DDBSIMPR BIT(19)
-#define ROGUE_MIPSFW_C0_DEBUG_IEXI BIT(20)
-#define ROGUE_MIPSFW_C0_DEBUG_DBUSEP BIT(21)
-#define ROGUE_MIPSFW_C0_DEBUG_CACHEEP BIT(22)
-#define ROGUE_MIPSFW_C0_DEBUG_MCHECKP BIT(23)
-#define ROGUE_MIPSFW_C0_DEBUG_IBUSEP BIT(24)
-#define ROGUE_MIPSFW_C0_DEBUG_DM BIT(30)
-#define ROGUE_MIPSFW_C0_DEBUG_DBD BIT(31)
-
-/* Macros to decode TLB entries. */
-#define ROGUE_MIPSFW_TLB_GET_MASK(page_mask) (((page_mask) >> 13) & 0XFFFFU)
-/* Page size in KB. */
-#define ROGUE_MIPSFW_TLB_GET_PAGE_SIZE(page_mask) ((((page_mask) | 0x1FFF) + 1) >> 11)
-/* Page size in KB. */
-#define ROGUE_MIPSFW_TLB_GET_PAGE_MASK(page_size) ((((page_size) << 11) - 1) & ~0x7FF)
-#define ROGUE_MIPSFW_TLB_GET_VPN2(entry_hi) ((entry_hi) >> 13)
-#define ROGUE_MIPSFW_TLB_GET_COHERENCY(entry_lo) (((entry_lo) >> 3) & 0x7U)
-#define ROGUE_MIPSFW_TLB_GET_PFN(entry_lo) (((entry_lo) >> 6) & 0XFFFFFU)
-/* GET_PA uses a non-standard PFN mask for 36 bit addresses. */
-#define ROGUE_MIPSFW_TLB_GET_PA(entry_lo) (((u64)(entry_lo) & \
-					    ROGUE_MIPSFW_ENTRYLO_PFN_MASK_ABOVE_32BIT) << 6)
-#define ROGUE_MIPSFW_TLB_GET_INHIBIT(entry_lo) (((entry_lo) >> 30) & 0x3U)
-#define ROGUE_MIPSFW_TLB_GET_DGV(entry_lo) ((entry_lo) & 0x7U)
-#define ROGUE_MIPSFW_TLB_GLOBAL BIT(0)
-#define ROGUE_MIPSFW_TLB_VALID BIT(1)
-#define ROGUE_MIPSFW_TLB_DIRTY BIT(2)
-#define ROGUE_MIPSFW_TLB_XI BIT(30)
-#define ROGUE_MIPSFW_TLB_RI BIT(31)
-
-#define ROGUE_MIPSFW_REMAP_GET_REGION_SIZE(region_size_encoding) (1 << (((region_size_encoding) \
-									+ 1) << 1))
-
-struct rogue_mips_tlb_entry {
-	u32 tlb_page_mask;
-	u32 tlb_hi;
-	u32 tlb_lo0;
-	u32 tlb_lo1;
-};
-
-struct rogue_mips_remap_entry {
-	u32 remap_addr_in;  /* Always 4k aligned. */
-	u32 remap_addr_out; /* Always 4k aligned. */
-	u32 remap_region_size;
-};
-
-struct rogue_mips_state {
-	u32 error_state; /* This must come first in the structure. */
-	u32 error_epc;
-	u32 status_register;
-	u32 cause_register;
-	u32 bad_register;
-	u32 epc;
-	u32 sp;
-	u32 debug;
-	u32 depc;
-	u32 bad_instr;
-	u32 unmapped_address;
-	struct rogue_mips_tlb_entry tlb[ROGUE_MIPSFW_NUMBER_OF_TLB_ENTRIES];
-	struct rogue_mips_remap_entry remap[ROGUE_MIPSFW_NUMBER_OF_REMAP_ENTRIES];
-};
-
-#include "pvr_rogue_mips_internal_check.h"
-
-#endif /* PVR_ROGUE_MIPS_INTERNAL_H */
diff --git a/drivers/gpu/drm/imagination/pvr_rogue_mips_internal_check.h b/drivers/gpu/drm/imagination/pvr_rogue_mips_internal_check.h
deleted file mode 100644
index 60bc83d7cdbc..000000000000
--- a/drivers/gpu/drm/imagination/pvr_rogue_mips_internal_check.h
+++ /dev/null
@@ -1,35 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only OR MIT */
-/* Copyright (c) 2023 Imagination Technologies Ltd. */
-
-#ifndef PVR_ROGUE_MIPS_INTERNAL_CHECK_H
-#define PVR_ROGUE_MIPS_INTERNAL_CHECK_H
-
-#include "pvr_check.h"
-
-OFFSET_CHECK(struct rogue_mips_tlb_entry, tlb_page_mask, 0);
-OFFSET_CHECK(struct rogue_mips_tlb_entry, tlb_hi, 4);
-OFFSET_CHECK(struct rogue_mips_tlb_entry, tlb_lo0, 8);
-OFFSET_CHECK(struct rogue_mips_tlb_entry, tlb_lo1, 12);
-SIZE_CHECK(struct rogue_mips_tlb_entry, 16);
-
-OFFSET_CHECK(struct rogue_mips_remap_entry, remap_addr_in, 0);
-OFFSET_CHECK(struct rogue_mips_remap_entry, remap_addr_out, 4);
-OFFSET_CHECK(struct rogue_mips_remap_entry, remap_region_size, 8);
-SIZE_CHECK(struct rogue_mips_remap_entry, 12);
-
-OFFSET_CHECK(struct rogue_mips_state, error_state, 0);
-OFFSET_CHECK(struct rogue_mips_state, error_epc, 4);
-OFFSET_CHECK(struct rogue_mips_state, status_register, 8);
-OFFSET_CHECK(struct rogue_mips_state, cause_register, 12);
-OFFSET_CHECK(struct rogue_mips_state, bad_register, 16);
-OFFSET_CHECK(struct rogue_mips_state, epc, 20);
-OFFSET_CHECK(struct rogue_mips_state, sp, 24);
-OFFSET_CHECK(struct rogue_mips_state, debug, 28);
-OFFSET_CHECK(struct rogue_mips_state, depc, 32);
-OFFSET_CHECK(struct rogue_mips_state, bad_instr, 36);
-OFFSET_CHECK(struct rogue_mips_state, unmapped_address, 40);
-OFFSET_CHECK(struct rogue_mips_state, tlb, 44);
-OFFSET_CHECK(struct rogue_mips_state, remap, 300);
-SIZE_CHECK(struct rogue_mips_state, 684);
-
-#endif /* PVR_ROGUE_MIPS_INTERNAL_CHECK_H */
diff --git a/drivers/gpu/drm/imagination/pvr_vm_mips.c b/drivers/gpu/drm/imagination/pvr_vm_mips.c
index 264ea0fccf9c..726f900d3582 100644
--- a/drivers/gpu/drm/imagination/pvr_vm_mips.c
+++ b/drivers/gpu/drm/imagination/pvr_vm_mips.c
@@ -3,10 +3,10 @@
 
 #include "pvr_device.h"
 #include "pvr_gem.h"
+#define PVR_FW_MIPS_INTERNAL_H_EXPLICIT_INCLUDE
+#include "pvr_fw_mips_internal.h"
+#undef PVR_FW_MIPS_INTERNAL_H_EXPLICIT_INCLUDE
 #include "pvr_mmu.h"
-#define PVR_ROGUE_MIPS_INTERNAL_H_EXPLICIT_INCLUDE
-#include "pvr_rogue_mips_internal.h"
-#undef PVR_ROGUE_MIPS_INTERNAL_H_EXPLICIT_INCLUDE
 #include "pvr_vm.h"
 #include "pvr_vm_mips.h"
 
@@ -18,7 +18,7 @@
 #include <linux/vmalloc.h>
 
 #define PVR_MIPS_PT_PAGE_COUNT \
-	DIV_ROUND_UP(ROGUE_MIPSFW_MAX_NUM_PAGETABLE_PAGES * ROGUE_MIPSFW_PAGE_SIZE_4K, PAGE_SIZE)
+	DIV_ROUND_UP(PVR_MIPSFW_MAX_NUM_PAGETABLE_PAGES * PVR_MIPSFW_PAGE_SIZE_4K, PAGE_SIZE)
 
 /**
  * struct pvr_vm_mips_data - MIPS-VM-specific data
@@ -55,15 +55,15 @@ struct pvr_vm_mips_data {
 int
 pvr_vm_mips_init(struct pvr_device *pvr_dev)
 {
-	u32 pt_size = 1 << ROGUE_MIPSFW_LOG2_PAGETABLE_SIZE_4K(pvr_dev);
+	u32 pt_size = 1 << PVR_MIPSFW_LOG2_PAGETABLE_SIZE_4K(pvr_dev);
 	struct device *dev = from_pvr_device(pvr_dev)->dev;
 	struct pvr_vm_mips_data *vm_data;
 	u32 phys_bus_width;
 	int page_nr;
 	int err;
 
-	/* Page table size must be at most ROGUE_MIPSFW_MAX_NUM_PAGETABLE_PAGES * 4k pages. */
-	if (pt_size > ROGUE_MIPSFW_MAX_NUM_PAGETABLE_PAGES * SZ_4K)
+	/* Page table size must be at most PVR_MIPSFW_MAX_NUM_PAGETABLE_PAGES * 4k pages. */
+	if (pt_size > PVR_MIPSFW_MAX_NUM_PAGETABLE_PAGES * SZ_4K)
 		return -EINVAL;
 
 	if (PVR_FEATURE_VALUE(pvr_dev, phys_bus_width, &phys_bus_width))
@@ -96,11 +96,11 @@ pvr_vm_mips_init(struct pvr_device *pvr_dev)
 		goto err_free_pages;
 	}
 
-	vm_data->pfn_mask = (phys_bus_width > 32) ? ROGUE_MIPSFW_ENTRYLO_PFN_MASK_ABOVE_32BIT :
-						    ROGUE_MIPSFW_ENTRYLO_PFN_MASK;
+	vm_data->pfn_mask = (phys_bus_width > 32) ? PVR_MIPSFW_ENTRYLO_PFN_MASK_ABOVE_32BIT :
+						    PVR_MIPSFW_ENTRYLO_PFN_MASK;
 
-	vm_data->cache_policy = (phys_bus_width > 32) ? ROGUE_MIPSFW_CACHED_POLICY_ABOVE_32BIT :
-							ROGUE_MIPSFW_CACHED_POLICY;
+	vm_data->cache_policy = (phys_bus_width > 32) ? PVR_MIPSFW_CACHED_POLICY_ABOVE_32BIT :
+							PVR_MIPSFW_CACHED_POLICY;
 
 	pvr_dev->fw_dev.processor_data.mips_data.vm_data = vm_data;
 
@@ -144,15 +144,15 @@ get_mips_pte_flags(bool read, bool write, u32 cache_policy)
 	u32 flags = 0;
 
 	if (read && write) /* Read/write. */
-		flags |= ROGUE_MIPSFW_ENTRYLO_DIRTY_EN;
+		flags |= PVR_MIPSFW_ENTRYLO_DIRTY_EN;
 	else if (write)    /* Write only. */
-		flags |= ROGUE_MIPSFW_ENTRYLO_READ_INHIBIT_EN;
+		flags |= PVR_MIPSFW_ENTRYLO_READ_INHIBIT_EN;
 	else
 		WARN_ON(!read);
 
-	flags |= cache_policy << ROGUE_MIPSFW_ENTRYLO_CACHE_POLICY_SHIFT;
+	flags |= cache_policy << PVR_MIPSFW_ENTRYLO_CACHE_POLICY_SHIFT;
 
-	flags |= ROGUE_MIPSFW_ENTRYLO_VALID_EN | ROGUE_MIPSFW_ENTRYLO_GLOBAL_EN;
+	flags |= PVR_MIPSFW_ENTRYLO_VALID_EN | PVR_MIPSFW_ENTRYLO_GLOBAL_EN;
 
 	return flags;
 }
@@ -190,15 +190,15 @@ pvr_vm_mips_map(struct pvr_device *pvr_dev, struct pvr_fw_object *fw_obj)
 	    start >= ROGUE_FW_HEAP_BASE + fw_dev->fw_heap_info.raw_size ||
 	    end < ROGUE_FW_HEAP_BASE ||
 	    end >= ROGUE_FW_HEAP_BASE + fw_dev->fw_heap_info.raw_size ||
-	    (start & ROGUE_MIPSFW_PAGE_MASK_4K) ||
-	    ((end + 1) & ROGUE_MIPSFW_PAGE_MASK_4K))
+	    (start & PVR_MIPSFW_PAGE_MASK_4K) ||
+	    ((end + 1) & PVR_MIPSFW_PAGE_MASK_4K))
 		return -EINVAL;
 
-	start_pfn = (start & fw_dev->fw_heap_info.offset_mask) >> ROGUE_MIPSFW_LOG2_PAGE_SIZE_4K;
-	end_pfn = (end & fw_dev->fw_heap_info.offset_mask) >> ROGUE_MIPSFW_LOG2_PAGE_SIZE_4K;
+	start_pfn = (start & fw_dev->fw_heap_info.offset_mask) >> PVR_MIPSFW_LOG2_PAGE_SIZE_4K;
+	end_pfn = (end & fw_dev->fw_heap_info.offset_mask) >> PVR_MIPSFW_LOG2_PAGE_SIZE_4K;
 
 	if (pvr_obj->flags & PVR_BO_FW_FLAGS_DEVICE_UNCACHED)
-		cache_policy = ROGUE_MIPSFW_UNCACHED_CACHE_POLICY;
+		cache_policy = PVR_MIPSFW_UNCACHED_CACHE_POLICY;
 	else
 		cache_policy = vm_data->cache_policy;
 
@@ -210,13 +210,13 @@ pvr_vm_mips_map(struct pvr_device *pvr_dev, struct pvr_fw_object *fw_obj)
 
 		err = pvr_fw_object_get_dma_addr(fw_obj,
 						 (pfn - start_pfn) <<
-						 ROGUE_MIPSFW_LOG2_PAGE_SIZE_4K,
+						 PVR_MIPSFW_LOG2_PAGE_SIZE_4K,
 						 &dma_addr);
 		if (err)
 			goto err_unmap_pages;
 
-		pte = ((dma_addr >> ROGUE_MIPSFW_LOG2_PAGE_SIZE_4K)
-		       << ROGUE_MIPSFW_ENTRYLO_PFN_SHIFT) & vm_data->pfn_mask;
+		pte = ((dma_addr >> PVR_MIPSFW_LOG2_PAGE_SIZE_4K)
+		       << PVR_MIPSFW_ENTRYLO_PFN_SHIFT) & vm_data->pfn_mask;
 		pte |= pte_flags;
 
 		WRITE_ONCE(vm_data->pt[pfn], pte);
@@ -251,9 +251,9 @@ pvr_vm_mips_unmap(struct pvr_device *pvr_dev, struct pvr_fw_object *fw_obj)
 	const u64 end = start + size;
 
 	const u32 start_pfn = (start & fw_dev->fw_heap_info.offset_mask) >>
-			      ROGUE_MIPSFW_LOG2_PAGE_SIZE_4K;
+			      PVR_MIPSFW_LOG2_PAGE_SIZE_4K;
 	const u32 end_pfn = (end & fw_dev->fw_heap_info.offset_mask) >>
-			    ROGUE_MIPSFW_LOG2_PAGE_SIZE_4K;
+			    PVR_MIPSFW_LOG2_PAGE_SIZE_4K;
 
 	for (u32 pfn = start_pfn; pfn < end_pfn; pfn++)
 		WRITE_ONCE(vm_data->pt[pfn], 0);
@@ -283,8 +283,8 @@ pvr_vm_get_pt_phys_addrs(struct pvr_device *pvr_dev, u64 *phys_addrs, int max_nu
 
 	for (u32 page_nr = 0; page_nr < max_num_addrs; page_nr++) {
 		/* Firmware expects 4k pages, but host page size might be different. */
-		u32 src_page_nr = (page_nr * ROGUE_MIPSFW_PAGE_SIZE_4K) >> PAGE_SHIFT;
-		u32 page_offset = (page_nr * ROGUE_MIPSFW_PAGE_SIZE_4K) & ~PAGE_MASK;
+		u32 src_page_nr = (page_nr * PVR_MIPSFW_PAGE_SIZE_4K) >> PAGE_SHIFT;
+		u32 page_offset = (page_nr * PVR_MIPSFW_PAGE_SIZE_4K) & ~PAGE_MASK;
 
 		phys_addrs[page_nr] = vm_data->pt_dma_addr[src_page_nr] + page_offset;
 	}

-- 
2.43.0

