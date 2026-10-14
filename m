Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E3A0CC6B27
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 08:14:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EF3D10FBE6;
	Wed, 14 Oct 2026 08:14:20 +0000 (UTC)
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 269FD10FBF5;
 Wed, 14 Oct 2026 08:14:11 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69E646GZ2182309; Wed, 14 Oct 2026 09:13:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=a
 7JthdY6UlY9fk9bFYeaIoYhrPVu+YOh7WdIcZnDdps=; b=mCEyh7ZonvK59b8U3
 luki2EUbWiXpr+s5F+ZGlJcXvjbBihYL3LWgMgsdTVdEjc5yhmOrxePLCDbxnKX4
 sDBlS3722ucErjDAqFQJULJht2kogUE0cFmHBxUuZ3NbTcYy2+171savItilGVP2
 SUlrAGAznQsJq+UgzDM7IPH8towrncKOIkdQ3YqCAQs736xaKTZytey0kxh5T+CX
 J/fqjviH3qzuLFRw/bDKjEUuMDEJUZJAB0Ey9nvAz9dZCLd3A6V4LyMXPRFAYF30
 6n0vj3a5+MFaDYS3K9PNqvlio0HjBHNhHanng4FVx0l5mA+mXLEuzeORS0xF2Dc+
 I7KgQ==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4h7bmpapbd-6
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 Oct 2026 09:13:54 +0100 (BST)
Received: from [127.0.1.1] (172.25.5.23) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 14 Oct
 2026 09:13:51 +0100
From: Alexandru Dadu <alexandru.dadu@imgtec.com>
Date: Wed, 14 Oct 2026 11:13:10 +0300
Subject: [PATCH 4/4] drm/imagination: Simplify MIPS PTE definitions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261014-b4-simplify-mips-pte-defs-v1-4-b4ad7bb68e22@imgtec.com>
References: <20261014-b4-simplify-mips-pte-defs-v1-0-b4ad7bb68e22@imgtec.com>
In-Reply-To: <20261014-b4-simplify-mips-pte-defs-v1-0-b4ad7bb68e22@imgtec.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791965625; l=7067;
 i=alexandru.dadu@imgtec.com; s=20260304; h=from:subject:message-id;
 bh=sNHyToJLZGaibAd4/Ow4OJa8WHtqiJc2atC60GPrxVg=;
 b=kHMlXmB10PjJNy1TU+k+qG799pxgJzMDUXNk2wh7PYxohMOC3VubuJ/DmF2sh/O4WY//KZmat
 If4vaPs2kgpBWxvj+WSCnLON+KYV48zKehBCdhuLF71h9UX/HgVK/gQ
X-Developer-Key: i=alexandru.dadu@imgtec.com; a=ed25519;
 pk=FU07SyNrYGwhahqSxbWEuzyXlUh47xBXvLvOR7UA6+U=
X-Originating-IP: [172.25.5.23]
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDAzMiBTYWx0ZWRfX1ZB2Hr/1+Jis
 c/pRHja+hPLY95ol8WckPqCfO0gJRdKHl1Yjuwcih25ggC8TcE+TfGC/hTIjzmhLxfVfmoEHywk
 E3U3zVd82CjsiL8tnz0A9q759c5F9R+t8w2JV46PuuoWzu+1INQVkqupqv760Glh8a5oJasekSn
 3IxbLbeX/bKOuJ7/kb/wQZlwAr4eDcwv6YDpLchx17ZpbvJY0pKAbKPoXZ2zpsgPtqJVny/hDEK
 z08Cr5CwNpSTHNt5K0ileIP++dxdCcNlGiFxO42emYZh/62VB6fp4haZHvBkchhccrUqh8hhY+h
 yCpG7HXbsfs3MzITc4YJVNM7UMb/VtVKF9stp1gbCtaQyivuTLuN6KgttDOsCtjUe0IVeMTZiC7
 C+mv+Ni3AbEMXNBNaiMGagajbttd8Rm7aFWdpuPk2jlnywSbjJz4ShcXpEG5Bb87I11l5Glptgh
 0HRRidR4WO2ekDP+DKA==
X-Proofpoint-GUID: QI9hzbV-DYH4f-qy0Q9gdw-h8rBtk_2L
X-Authority-Analysis: v=2.4 cv=QpDLTlyd c=1 sm=1 tr=0 ts=6acf39c2 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=Vfs-8JXWiL0A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22
 a=r_1tXGB3AAAA:8 a=dZ2EV5tdkBY6hKowxAIA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-ORIG-GUID: QI9hzbV-DYH4f-qy0Q9gdw-h8rBtk_2L
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDAzMiBTYWx0ZWRfX1mZEcwPri3MT
 KmdBP6VBq7MaKIk+IgIYBGDv/kI8mKuLJmjGB+26HVoYoLc4mrD76xpOV5rLXTnXlxk4h+hjCeT
 /SQ393aqrOYjGgWhKRBW3te9Tro4KHA=
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

From: Matt Coster <matt.coster@imgtec.com>

Use BIT() and GENMASK() in the definitions of the MIPS PTE format, and
remove some unused definitions that add no value.

Signed-off-by: Matt Coster <matt.coster@imgtec.com>
Signed-off-by: Alexandru Dadu <alexandru.dadu@imgtec.com>
---
 drivers/gpu/drm/imagination/pvr_mips_internal.h | 72 ++++++++-----------------
 drivers/gpu/drm/imagination/pvr_vm_mips.c       | 25 ++++-----
 2 files changed, 34 insertions(+), 63 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_mips_internal.h b/drivers/gpu/drm/imagination/pvr_mips_internal.h
index 732730d64bf5..2b25a69003b3 100644
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

