Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA841606A319
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 08:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=imgtec.com header.i=@imgtec.com header.a=rsa-sha256 header.s=dk201812 header.b=DKsPtTR+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D1E91123EF;
	Thu, 22 Oct 2026 08:25:47 +0000 (UTC)
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78BF81123ED;
 Thu, 22 Oct 2026 08:25:29 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69M751731909612; Thu, 22 Oct 2026 09:25:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=L
 Bn4nh2d916uaCDPE284y3FtCySZhz+sRoOBYWGfxDg=; b=DKsPtTR+N3oYDzGtL
 tiqwR0XU3GTFtDl3Oc8Eha9XLkGhdFGjLuoq7MSfjP8WJ2G4bLqJ1Ap3AFdpBr6W
 a4uU54+saheY9546YbHgRhinnc6krSJZrx5fketwdPgGBFhiEMZ4gWP6Xev58Ose
 tzFkM/gMe3KOvU8ylnc7bBvrb4aFNzASD0nmqReLvvB/X23WOjV4hH2XmglzErwX
 l1F8uBqkjpaW8vCgzTVr5rPl+S14LisZ0ntV7jCVn8SyVSDF4uAPomB5ar95w3N+
 B3ys2XZtQk/QtnofJ61fUTKsvvrSVQ7qgWICkkwy6xIaXbIH6gL5mYeKryufRBtZ
 g1Jjw==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4hf88f87nq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 22 Oct 2026 09:25:14 +0100 (BST)
Received: from [127.0.1.1] (172.25.5.18) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 22 Oct
 2026 09:25:11 +0100
From: Alexandru Dadu <alexandru.dadu@imgtec.com>
Date: Thu, 22 Oct 2026 11:24:54 +0300
Subject: [PATCH v2 4/4] drm/imagination: Simplify MIPS PTE definitions
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261022-b4-simplify-mips-pte-defs-v2-4-ee2402c03a4b@imgtec.com>
References: <20261022-b4-simplify-mips-pte-defs-v2-0-ee2402c03a4b@imgtec.com>
In-Reply-To: <20261022-b4-simplify-mips-pte-defs-v2-0-ee2402c03a4b@imgtec.com>
To: Alessio Belle <alessio.belle@imgtec.com>, Luigi Santivetti
 <luigi.santivetti@imgtec.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Paul Walmsley <pjw@kernel.org>, "Palmer Dabbelt" <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, "Alexandre Ghiti" <alex@ghiti.fr>
CC: <linux-kernel@vger.kernel.org>, <imagination@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <linux-riscv@lists.infradead.org>,
 Alexandru Dadu <alexandru.dadu@imgtec.com>, Matt Coster
 <opensource@mtcoster.net>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792657504; l=7605;
 i=alexandru.dadu@imgtec.com; s=20260304; h=from:subject:message-id;
 bh=fYUuDJCGw+bUiTZrYP9KqZOOsb0T75WjC8ockX0EDnU=;
 b=kO/U8ABSgkKqbJj9jynq2ZEnnh7WbcWdBU5H6IijIb3DuGUHr1z/wsHpToM5GTcW4Sgdf8z7l
 uL4tCFFbZjUBUaE0pRV/ni9O+Wls3ImVDvreHPJUMiDPbiZYYDZymO/
X-Developer-Key: i=alexandru.dadu@imgtec.com; a=ed25519;
 pk=FU07SyNrYGwhahqSxbWEuzyXlUh47xBXvLvOR7UA6+U=
X-Proofpoint-GUID: XQ9Vdo3B-2fqNFcBZ10LfTwavctfBBoa
X-Proofpoint-ORIG-GUID: XQ9Vdo3B-2fqNFcBZ10LfTwavctfBBoa
X-Authority-Analysis: v=2.4 cv=e7+T2qp/ c=1 sm=1 tr=0 ts=6ad9c86a cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=sVS2Dey4ZWMA:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22
 a=r_1tXGB3AAAA:8 a=2Pulcj8D2IyI57IxkyQA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDAzMyBTYWx0ZWRfX/dvmecJYRQf5
 zaQ+Zn/V1FpGyQu0JX57lwgdzRFKrFpvilxHzgHac4TdNhYsftSbXpglTuiGoh8SEnXU1PaZ3d6
 tX/+F6N8D6CWE5yNlxE1CaGwaH1mDME=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDAzMyBTYWx0ZWRfXxNg0ICkS3Wei
 fpyR1UfvckMlyJYzJuso6yBiDPNVDG4CzET3Nt4WZyp0Q7+j5xq2tz1PDFcalm3I9dARzUjfPX1
 6OFKuDZLEOcNwWk0A2B/IkF9ahHgXWGy/6m7EmxgCuQBDPgaeBY/7nbLlLIhB3VhZojTY8Qbmvp
 3hRR8TEYfdUZ/gkoQQp5OoFXdHTG7XJZKb4USaLgeEYn+JIPFfqDEhUBHMQAa7abFoZ6vXWaTlH
 BGiMLU+IpXqhT4qMNAmyDcF6f8FPBMTUjk+7rkthmOG3epoUkjZM2C66qPDuQTZsyzXak2loVAV
 e+62aLVXXPnJQ3IOaPPmjzfNR18dN05GRlir6rQOj1q9H0wNF0PLO0252i3K4dJehUrYzMHFhc7
 BOu7VFs8//pnCXl0yFP7auWgaC1gl/oRR868Oct/Ng9VS1JVdhlUn5x2WVt8sZV34+ogg7hEZYR
 tgYHKiOJRDPm1jkD0sw==
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
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Matt Coster <matt.coster@imgtec.com>

Use BIT() and GENMASK() in the definitions of the MIPS PTE format, and
remove some unused definitions that add no value.

Signed-off-by: Matt Coster <matt.coster@imgtec.com>
Signed-off-by: Alexandru Dadu <alexandru.dadu@imgtec.com>
---
 drivers/gpu/drm/imagination/pvr_mips_internal.h | 74 ++++++++-----------------
 drivers/gpu/drm/imagination/pvr_vm_mips.c       | 25 +++++----
 2 files changed, 35 insertions(+), 64 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_mips_internal.h b/drivers/gpu/drm/imagination/pvr_mips_internal.h
index 732730d64bf5..750ec7cd3650 100644
--- a/drivers/gpu/drm/imagination/pvr_mips_internal.h
+++ b/drivers/gpu/drm/imagination/pvr_mips_internal.h
@@ -39,63 +39,33 @@
 #define PVR_MIPSFW_MAX_NUM_PAGETABLE_PAGES (4)
 /* Total number of TLB entries. */
 #define PVR_MIPSFW_NUMBER_OF_TLB_ENTRIES (16)
-/* "Uncached" caching policy. */
-#define PVR_MIPSFW_UNCACHED_CACHE_POLICY (2)
-/* "Write-back write-allocate" caching policy. */
-#define PVR_MIPSFW_WRITEBACK_CACHE_POLICY (3)
-/* "Write-through no write-allocate" caching policy. */
-#define PVR_MIPSFW_WRITETHROUGH_CACHE_POLICY (1)
+
+enum pvr_fw_mips_cache_policy {
+	/* "Write-through no write-allocate" caching policy. */
+	PVR_MIPSFW_CACHE_POLICY_WRITETHROUGH = 1,
+	/* "Uncached" caching policy. */
+	PVR_MIPSFW_CACHE_POLICY_UNCACHED = 2,
+	/* "Write-back write-allocate" caching policy. */
+	PVR_MIPSFW_CACHE_POLICY_WRITEBACK = 3,
+};
+
 /* Cached policy used by MIPS in case of physical bus on 32 bit. */
-#define PVR_MIPSFW_CACHED_POLICY (PVR_MIPSFW_WRITEBACK_CACHE_POLICY)
+#define PVR_MIPSFW_CACHE_POLICY_CACHED (PVR_MIPSFW_CACHE_POLICY_WRITEBACK)
 /* Cached policy used by MIPS in case of physical bus on more than 32 bit. */
-#define PVR_MIPSFW_CACHED_POLICY_ABOVE_32BIT (PVR_MIPSFW_WRITETHROUGH_CACHE_POLICY)
+#define PVR_MIPSFW_CACHE_POLICY_CACHED_ABOVE_32BIT (PVR_MIPSFW_CACHE_POLICY_WRITETHROUGH)
+
 /* Total number of Remap entries. */
 #define PVR_MIPSFW_NUMBER_OF_REMAP_ENTRIES (2 * PVR_MIPSFW_NUMBER_OF_TLB_ENTRIES)
 
 /* MIPS EntryLo/PTE format. */
-
-#define PVR_MIPSFW_ENTRYLO_READ_INHIBIT_SHIFT (31U)
-#define PVR_MIPSFW_ENTRYLO_READ_INHIBIT_CLRMSK (0X7FFFFFFF)
-#define PVR_MIPSFW_ENTRYLO_READ_INHIBIT_EN (0X80000000)
-
-#define PVR_MIPSFW_ENTRYLO_EXEC_INHIBIT_SHIFT (30U)
-#define PVR_MIPSFW_ENTRYLO_EXEC_INHIBIT_CLRMSK (0XBFFFFFFF)
-#define PVR_MIPSFW_ENTRYLO_EXEC_INHIBIT_EN (0X40000000)
-
-/* Page Frame Number */
-#define PVR_MIPSFW_ENTRYLO_PFN_SHIFT (6)
-#define PVR_MIPSFW_ENTRYLO_PFN_ALIGNSHIFT (12)
-/* Mask used for the MIPS Page Table in case of physical bus on 32 bit. */
-#define PVR_MIPSFW_ENTRYLO_PFN_MASK (0x03FFFFC0)
-#define PVR_MIPSFW_ENTRYLO_PFN_SIZE (20)
-/* Mask used for the MIPS Page Table in case of physical bus on more than 32 bit. */
-#define PVR_MIPSFW_ENTRYLO_PFN_MASK_ABOVE_32BIT (0x3FFFFFC0)
-#define PVR_MIPSFW_ENTRYLO_PFN_SIZE_ABOVE_32BIT (24)
-#define PVR_MIPSFW_ADDR_TO_ENTRYLO_PFN_RSHIFT (PVR_MIPSFW_ENTRYLO_PFN_ALIGNSHIFT - \
-					       PVR_MIPSFW_ENTRYLO_PFN_SHIFT)
-
-#define PVR_MIPSFW_ENTRYLO_CACHE_POLICY_SHIFT (3U)
-#define PVR_MIPSFW_ENTRYLO_CACHE_POLICY_CLRMSK (0XFFFFFFC7)
-
-#define PVR_MIPSFW_ENTRYLO_DIRTY_SHIFT (2U)
-#define PVR_MIPSFW_ENTRYLO_DIRTY_CLRMSK (0XFFFFFFFB)
-#define PVR_MIPSFW_ENTRYLO_DIRTY_EN (0X00000004)
-
-#define PVR_MIPSFW_ENTRYLO_VALID_SHIFT (1U)
-#define PVR_MIPSFW_ENTRYLO_VALID_CLRMSK (0XFFFFFFFD)
-#define PVR_MIPSFW_ENTRYLO_VALID_EN (0X00000002)
-
-#define PVR_MIPSFW_ENTRYLO_GLOBAL_SHIFT (0U)
-#define PVR_MIPSFW_ENTRYLO_GLOBAL_CLRMSK (0XFFFFFFFE)
-#define PVR_MIPSFW_ENTRYLO_GLOBAL_EN (0X00000001)
-
-#define PVR_MIPSFW_ENTRYLO_DVG (PVR_MIPSFW_ENTRYLO_DIRTY_EN | \
-				PVR_MIPSFW_ENTRYLO_VALID_EN | \
-				PVR_MIPSFW_ENTRYLO_GLOBAL_EN)
-#define PVR_MIPSFW_ENTRYLO_UNCACHED (PVR_MIPSFW_UNCACHED_CACHE_POLICY << \
-				     PVR_MIPSFW_ENTRYLO_CACHE_POLICY_SHIFT)
-#define PVR_MIPSFW_ENTRYLO_DVG_UNCACHED (PVR_MIPSFW_ENTRYLO_DVG | \
-					 PVR_MIPSFW_ENTRYLO_UNCACHED)
+#define PVR_MIPSFW_ENTRYLO_READ_INHIBIT BIT_U32(31)
+#define PVR_MIPSFW_ENTRYLO_EXEC_INHIBIT BIT_U32(30)
+#define PVR_MIPSFW_ENTRYLO_PFN GENMASK_U32(25, 6)
+#define PVR_MIPSFW_ENTRYLO_PFN_ABOVE_32BIT GENMASK_U32(29, 6)
+#define PVR_MIPSFW_ENTRYLO_CACHE_POLICY GENMASK_U32(5, 3)
+#define PVR_MIPSFW_ENTRYLO_DIRTY BIT_U32(2)
+#define PVR_MIPSFW_ENTRYLO_VALID BIT_U32(1)
+#define PVR_MIPSFW_ENTRYLO_GLOBAL BIT_U32(0)
 
 /* Remap Range Config Addr Out. */
 /* These defines refer to the upper half of the Remap Range Config register. */
@@ -293,7 +263,7 @@ struct pvr_mipsfw_boot_data {
 #define PVR_MIPSFW_TLB_GET_PFN(entry_lo) (((entry_lo) >> 6) & 0XFFFFFU)
 /* GET_PA uses a non-standard PFN mask for 36 bit addresses. */
 #define PVR_MIPSFW_TLB_GET_PA(entry_lo) (((u64)(entry_lo) & \
-					  PVR_MIPSFW_ENTRYLO_PFN_MASK_ABOVE_32BIT) << 6)
+					 PVR_MIPSFW_ENTRYLO_PFN_ABOVE_32BIT) << 6)
 #define PVR_MIPSFW_TLB_GET_INHIBIT(entry_lo) (((entry_lo) >> 30) & 0x3U)
 #define PVR_MIPSFW_TLB_GET_DGV(entry_lo) ((entry_lo) & 0x7U)
 #define PVR_MIPSFW_TLB_GLOBAL BIT(0)
diff --git a/drivers/gpu/drm/imagination/pvr_vm_mips.c b/drivers/gpu/drm/imagination/pvr_vm_mips.c
index 40495b1486a2..7f49314bc6be 100644
--- a/drivers/gpu/drm/imagination/pvr_vm_mips.c
+++ b/drivers/gpu/drm/imagination/pvr_vm_mips.c
@@ -97,11 +97,13 @@ pvr_vm_mips_init(struct pvr_device *pvr_dev)
 		goto err_free_pages;
 	}
 
-	vm_data->pfn_mask = (phys_bus_width > 32) ? PVR_MIPSFW_ENTRYLO_PFN_MASK_ABOVE_32BIT :
-						    PVR_MIPSFW_ENTRYLO_PFN_MASK;
-
-	vm_data->cache_policy = (phys_bus_width > 32) ? PVR_MIPSFW_CACHED_POLICY_ABOVE_32BIT :
-							PVR_MIPSFW_CACHED_POLICY;
+	if (phys_bus_width > 32) {
+		vm_data->pfn_mask = PVR_MIPSFW_ENTRYLO_PFN_ABOVE_32BIT;
+		vm_data->cache_policy = PVR_MIPSFW_CACHE_POLICY_CACHED_ABOVE_32BIT;
+	} else {
+		vm_data->pfn_mask = PVR_MIPSFW_ENTRYLO_PFN;
+		vm_data->cache_policy = PVR_MIPSFW_CACHE_POLICY_CACHED;
+	}
 
 	pvr_dev->fw_dev.processor_data.mips_data.vm_data = vm_data;
 
@@ -145,15 +147,15 @@ get_mips_pte_flags(bool read, bool write, u32 cache_policy)
 	u32 flags = 0;
 
 	if (read && write) /* Read/write. */
-		flags |= PVR_MIPSFW_ENTRYLO_DIRTY_EN;
+		flags |= PVR_MIPSFW_ENTRYLO_DIRTY;
 	else if (write)    /* Write only. */
-		flags |= PVR_MIPSFW_ENTRYLO_READ_INHIBIT_EN;
+		flags |= PVR_MIPSFW_ENTRYLO_READ_INHIBIT;
 	else
 		WARN_ON(!read);
 
-	flags |= cache_policy << PVR_MIPSFW_ENTRYLO_CACHE_POLICY_SHIFT;
+	flags |= FIELD_PREP(PVR_MIPSFW_ENTRYLO_CACHE_POLICY, cache_policy);
 
-	flags |= PVR_MIPSFW_ENTRYLO_VALID_EN | PVR_MIPSFW_ENTRYLO_GLOBAL_EN;
+	flags |= PVR_MIPSFW_ENTRYLO_VALID | PVR_MIPSFW_ENTRYLO_GLOBAL;
 
 	return flags;
 }
@@ -199,7 +201,7 @@ pvr_vm_mips_map(struct pvr_device *pvr_dev, struct pvr_fw_object *fw_obj)
 	end_pfn = (end & fw_dev->fw_heap_info.offset_mask) >> PVR_MIPSFW_LOG2_PAGE_SIZE_4K;
 
 	if (pvr_obj->flags & PVR_BO_FW_FLAGS_DEVICE_UNCACHED)
-		cache_policy = PVR_MIPSFW_UNCACHED_CACHE_POLICY;
+		cache_policy = PVR_MIPSFW_CACHE_POLICY_UNCACHED;
 	else
 		cache_policy = vm_data->cache_policy;
 
@@ -216,8 +218,7 @@ pvr_vm_mips_map(struct pvr_device *pvr_dev, struct pvr_fw_object *fw_obj)
 		if (err)
 			goto err_unmap_pages;
 
-		pte = ((dma_addr >> PVR_MIPSFW_LOG2_PAGE_SIZE_4K)
-		       << PVR_MIPSFW_ENTRYLO_PFN_SHIFT) & vm_data->pfn_mask;
+		pte = field_prep(vm_data->pfn_mask, dma_addr >> PVR_MIPSFW_LOG2_PAGE_SIZE_4K);
 		pte |= pte_flags;
 
 		WRITE_ONCE(vm_data->pt[pfn], pte);

-- 
2.43.0

