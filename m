Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B769460A3801
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 12:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.a=rsa-sha256 header.s=dk201812 header.b=KbgA7unb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41DD110F260;
	Mon,  9 Nov 2026 12:33:03 +0000 (UTC)
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 403FC10F240;
 Mon,  9 Nov 2026 12:32:56 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.12/8.18.1.12) with ESMTP id
 6A974jcg2011149; Mon, 9 Nov 2026 12:32:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=n
 l+ZTQ29g0X1AjvjZkhWS+s9s3MSc8Ju6CfIIVOuOlY=; b=KbgA7unb9rnH0AAHP
 FY6czC/6diF962VQ2DQ5nTRKQZBejv/DS3md7/EcqHLVSQ2A8EaVcsuWSTqO5mGr
 zsXxlGn0VYpk1FAeiH7/ZPD+0NzGvBf91xtjKqMMIA8m7mM8tTBrxw18XxESSjsl
 3rWQfqpGqTtmsbeZ83m4IBMs8GAYk8sWIm15YnhJvrdtfBc6GBP6QdRy2U9/kOTG
 CNDhBPtjrrXGQmvPl/XV+2CvO8GcW/E4Nlnh2zzL00AXB/vYTAUkqZ1VwXYlx+TO
 Wm/ysFHfdv4mqL1wkrvBMz/gBBYEy7td16U/ZkYHVAKEJ60EpS+rox/7p8/26itk
 2pMyw==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4hsvxx1h5k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT
 key_exchange=secp384r1); Mon, 09 Nov 2026 12:32:45 +0000 (GMT)
Received: from [127.0.1.1] (172.25.5.26) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 9 Nov
 2026 12:32:43 +0000
From: Alexandru Dadu <alexandru.dadu@imgtec.com>
Date: Mon, 9 Nov 2026 14:32:18 +0200
Subject: [PATCH v6 4/4] drm/imagination: Simplify MIPS PTE definitions
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261109-b4-simplify-mips-pte-defs-v6-4-65153bc9a71c@imgtec.com>
References: <20261109-b4-simplify-mips-pte-defs-v6-0-65153bc9a71c@imgtec.com>
In-Reply-To: <20261109-b4-simplify-mips-pte-defs-v6-0-65153bc9a71c@imgtec.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794227557; l=7675;
 i=alexandru.dadu@imgtec.com; s=20260304; h=from:subject:message-id;
 bh=gZ+1jGk3nIcTdTnoMuSwuwb14tHqVwWtI5PUAt8LcEU=;
 b=tRDQ3pZKMaM3hMW56ITipWY+T2+OmNqZUCAnjpwZgsjwNjRC5jJDwovrZ6KbuHzD/mUp6jhev
 4PZKN3zQY8XCti93URlKleLuJgvCOtMTed7YhZgX8IP7CLIBAa6FcPn
X-Developer-Key: i=alexandru.dadu@imgtec.com; a=ed25519;
 pk=FU07SyNrYGwhahqSxbWEuzyXlUh47xBXvLvOR7UA6+U=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA0OSBTYWx0ZWRfX0dnp0nvgNdin
 YsH+//ITFbRzgFHL38sKnHv6bk8b4FuAK58FzI+L1t3BiJljgckSJ1sdECi/ha8VohWlVw9kZyz
 A9/wk/gb4po8mHgJMTrGu0d0E5xJrr8=
X-Proofpoint-ORIG-GUID: Ye5eJBgudrX1imsqmwAtwA3nSx6Qedwn
X-Authority-Analysis: v=2.4 cv=H+JOUOYi c=1 sm=1 tr=0 ts=6af1bd6d cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=h_3jC4m0AyQA:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=r_1tXGB3AAAA:8 a=vkN0XxrHRKDbMJCO9W8A:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA0OSBTYWx0ZWRfXzRuXTCRzKYTN
 RQNmyqhLAH07jRgV09nKQvodPczUN2PDMr/INF9fEy8H56VmROpZh99SiboSK2k3v7lYuHlEBNA
 TQQJ2NWtBdB5QY2Q/XdPxUbMRmDSQxcIhVPmq5l7jbey5A0ZdIA95joNGb+lWUU2Upeh7vDemm7
 xKFs3GpgZuA6FByK1A7CAVStM6Gd3itzF5v2Nq8brz6mbucz6S1PdmfFa6YT4//c0No3p5wZBWo
 eUJUh9kNI7K1H4D0xcu+CWML0hmWoo7QloGQAG/ydFvC7laz6iLYh5HDAZK3vVfDCPHE+IYH5lc
 CmoPlu3YSEo2r+Pv+gbwuJMQcYxRhz3eljzZ15+g9mY5VrIwPgIErMfmF1bTq5RX7Wczwg6FHvg
 YBNzipXc81R5DyV5VfA5FrwN8aM0TuXgNuSUTyHAYU708f47EFSdxrQzUXlUOX9IgfW7nAlygWO
 hzz3mGWQpIcRrL+PEgw==
X-Proofpoint-GUID: Ye5eJBgudrX1imsqmwAtwA3nSx6Qedwn
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
	SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Matt Coster <matt.coster@imgtec.com>

Use BIT() and GENMASK() in the definitions of the MIPS PTE format, and
remove some unused definitions that add no value.

Signed-off-by: Matt Coster <matt.coster@imgtec.com>
Signed-off-by: Alexandru Dadu <alexandru.dadu@imgtec.com>
Reviewed-by: Alessio Belle <alessio.belle@imgtec.com>
---
 drivers/gpu/drm/imagination/pvr_fw_mips_internal.h | 74 +++++++---------------
 drivers/gpu/drm/imagination/pvr_vm_mips.c          | 25 ++++----
 2 files changed, 35 insertions(+), 64 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_fw_mips_internal.h b/drivers/gpu/drm/imagination/pvr_fw_mips_internal.h
index f13829e63e1c..cbbf3982179a 100644
--- a/drivers/gpu/drm/imagination/pvr_fw_mips_internal.h
+++ b/drivers/gpu/drm/imagination/pvr_fw_mips_internal.h
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
+					  PVR_MIPSFW_ENTRYLO_PFN_ABOVE_32BIT) << 6)
 #define PVR_MIPSFW_TLB_GET_INHIBIT(entry_lo) (((entry_lo) >> 30) & 0x3U)
 #define PVR_MIPSFW_TLB_GET_DGV(entry_lo) ((entry_lo) & 0x7U)
 #define PVR_MIPSFW_TLB_GLOBAL BIT(0)
diff --git a/drivers/gpu/drm/imagination/pvr_vm_mips.c b/drivers/gpu/drm/imagination/pvr_vm_mips.c
index b74386032e6a..f6fa723649d3 100644
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

