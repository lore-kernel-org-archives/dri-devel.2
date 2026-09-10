Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D15DCC88E41
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 21:14:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0063410EAD9;
	Thu, 10 Sep 2026 21:13:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LY8F8Ln6";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010016.outbound.protection.outlook.com [52.101.61.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4072D10E60D
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 21:13:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HUu9PoULfCy8y6R+8Gc1qV52J38fnFPBIpwd+k7LKGVcaKgCb77sYr2H9kLNB2WzmVLBY/LvlkreuwbHIC/Ai+HZ9bdlnNkQA+tsw1IuTVs5PPsiAWeMVkvOlhx14VlZQi3Nbh2ZVMk08ZPKYoU/uWR/Jz2td+wFJkR7ByJhXFahcpn390FdkemiQn09I1EmCMxQegdPSaBienVx7JO/Lrnq7K4eb7hcKG8N4lZAD2MzjVhHchVpXXUhvslrGB+KaG+8Hhlu7h3XfIcfvvW/Z/omMbaySkxZdd5fSDv9j073wCkuRsb3D00V1kSivMteHJ6qG71MMuDcqTvYK+LPqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bx5uTYPPi3ETY8X6AOxi1RfVSQe35uXpB89RvlY+dTw=;
 b=VcjexioFeY0bh84ZDcV1Uxt90zADoxt7RI754kf5sTUuBzXq9Ypfmjtpm0P7XlvL8kIGpDpxlLPCmWWQqVDeTPT9SKTluJTS1gYicFIry4LXtv1jNFGz+tAKAxNNC7HDVJDojTv6Yp2priO6d1poOfQHxU7gq394jeAaZzhPHiAX4Y27JgfJ5K4Rjt8GyJg/DjUUEtE2T1J4okDduYw6Q9XVIDYygPvBDXWs6jw2jupDQMLb5ezFP4zS/lMNeCpvl1VJDxQCtIGyJKSHUxw4rXA8FMH/yXSEB3fu9tTJfZez7IHAPBkatBjsstQsEpiVznHXAOzhYORIEEELqhCQDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bx5uTYPPi3ETY8X6AOxi1RfVSQe35uXpB89RvlY+dTw=;
 b=LY8F8Ln6TFTa3e0q9uOrCoWHcws091+gygR7kF27FjzJoRF6ThyMsei1vPv41TrLIT1D/POoHn6Nx9XoOSJdCkbsC6FlxJP77fMUN3Tzc3xcHjdlYQ/6tn9Qw1Q95qNO4oDyvRjJBjT3ah1Bst5P4F50w4/xiH2ngqpX5ElYsE0=
Received: from CH0PR04CA0076.namprd04.prod.outlook.com (2603:10b6:610:74::21)
 by BL4PR12MB9533.namprd12.prod.outlook.com (2603:10b6:208:58f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 21:13:51 +0000
Received: from CH3PEPF0000000E.namprd04.prod.outlook.com
 (2603:10b6:610:74:cafe::86) by CH0PR04CA0076.outlook.office365.com
 (2603:10b6:610:74::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Thu, 10
 Sep 2026 21:13:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000E.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Thu, 10 Sep 2026 21:13:51 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 10 Sep
 2026 16:13:51 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 10 Sep
 2026 16:13:50 -0500
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Thu, 10 Sep 2026 16:13:50 -0500
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <mario.limonciello@amd.com>, <karol.wachowski@linux.intel.com>,
 <dri-devel@lists.freedesktop.org>, <max.zhen@amd.com>
CC: Lizhi Hou <lizhi.hou@amd.com>, <linux-kernel@vger.kernel.org>,
 <sonal.santan@amd.com>
Subject: [PATCH V3] accel/amdxdna: Fix unsafe use of handle_mm_fault()
Date: Thu, 10 Sep 2026 14:13:38 -0700
Message-ID: <20260910211338.1102315-1-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000E:EE_|BL4PR12MB9533:EE_
X-MS-Office365-Filtering-Correlation-Id: d280a8e1-357c-465a-e3ff-08df0f8069b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|23010399003|36860700016|376014|10067099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: CPKRIwx8/VF4ulrDzQS7v9Ojh1fMlQv5JzCSS4Dtfkg1Hv26KCnlJZMPOOK8RXfXwK9RV64WYiqoV959qWEJ7JQdr3DjQobrIs8GVmJv3cBWPI9tqvs+SdFe8deOUPpZYXa7fjmet/GSS3HRLswBvfu3t3xaWq/q7H0ff+wueI6xkN/CogzuUfV4jFWg84b1HbposnNzaG4pFkI2tgdFtiMnEt0EhsZtOJhkERzhp7anXwUm4qgdzKYCBopbXm3mM/DkvuOFaRfiXtiLsg0KYnNlnYmeyxbI0vbahRLeVUXKrL9NI1nmBsnEhlblEVFaRyOoMsv07pFGygyW96kqhGiADFGkfOs+6rqq8Ha9LAsmpHDXfHUiyKeXsvMQDo7Mp2udxLQjbLC8yBL6yVF7mKT6GdB8tSdQcF7GwDs/oZCRWf7oeUzaYp1LwWEszU8DWTY2R9+Tmu23/9pcZQ/usftRLWBgMfcNL2rkKlbkP6YqdcJKOJPQHpaRlV0uOSAMB+rCDCadh7ZZ8OuVfNdExBwjeE9R3FJpTj3YzZ/Sg8SsRTMCm4yZf9Kwc1+G69ZzYCmGG+N0BraXddJ35ZNDo2GVSWwRHTvjpb1g1X4YEwMLahMVO5jXhXXJ9SVHL3JGDJjf+6sJbtwaWftJ3OTJJ4fSaMHKLiQkdl+luUm0UsF/iENNbRQikEhtEiWIp4WqZ/pEuWKQ1JZdwLI6/+p3Mw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(23010399003)(36860700016)(376014)(10067099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JEyrE/y4QC9W6UiE0x71TTULRwtpgAFNgVvVqnGUcbmHxw4McAgf2AxQ6TM6yiqruw2eUk4Ogm3eBjszSHPZGK85jfLibQyEkdoCe8ae6wuiRt8VG7q7BD5bZhtCVIG2k6GW9bxCp0ldTXHKdwsv+q8qg52lACYDHPe/4/S4MZ9Ixn+mJHJVBsLvQFNbDnBs4V53BsIcLjuh0Cy5qVpc3hpiHFIbHL+K0QK6q4U9313vbtnoFSpuP5fYyo+/gb0QaZTTu0Ige+iwpTkLz76GJ7IYAh6NoyTxWhscXThTN1w2ahDCvb0eB8fADw1CJCEGl0Z919VhNaJ6h7XaDJxroT8U5qoeOyTeOO+KqnI5oSOG2G8Am9iQMgO/kuUTIRSbO9DijgRXxi81BWzCck1RCjc/T+z201TqojflN4A0OK36+yN7svUHTQErCAvO+PhT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 21:13:51.2976 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d280a8e1-357c-465a-e3ff-08df0f8069b3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9533
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

handle_mm_fault() must not be called from the mmap callback because
the VMA has not yet been linked. The handle_mm_fault() API contract
assumes that the VMA is already linked.

Remove the handle_mm_fault() call from the mmap callback. For imported
BOs, mark the mapping as invalid and rely on the first command submission
to fault in the pages.

For shmem BOs, set the VM_MIXEDMAP flag and use vm_insert_pages().
Implement amdxdna_gem_mixed_vm_ops to handle the page faults.

Fixes: e486147c912f ("accel/amdxdna: Add BO import and export")
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
v2 & v3:
  Fix sashiko comment.

 drivers/accel/amdxdna/amdxdna_gem.c | 151 ++++++++++++++++++++++------
 1 file changed, 118 insertions(+), 33 deletions(-)

diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
index 0d165b66c1fc..a12a762b3a6b 100644
--- a/drivers/accel/amdxdna/amdxdna_gem.c
+++ b/drivers/accel/amdxdna/amdxdna_gem.c
@@ -14,6 +14,7 @@
 #include <linux/dma-direct.h>
 #include <linux/iosys-map.h>
 #include <linux/pagemap.h>
+#include <linux/swap.h>
 #include <linux/vmalloc.h>
 
 #include "amdxdna_cbuf.h"
@@ -490,16 +491,16 @@ static int amdxdna_insert_pages(struct amdxdna_gem_obj *abo,
 {
 	struct amdxdna_dev *xdna = to_xdna_dev(to_gobj(abo)->dev);
 	unsigned long num_pages = vma_pages(vma);
-	unsigned long offset = 0;
 	int ret;
 
-	if (!is_import_bo(abo)) {
-		ret = drm_gem_shmem_mmap(&abo->base, vma);
-		if (ret) {
-			XDNA_ERR(xdna, "Failed shmem mmap %d", ret);
-			return ret;
-		}
-	} else {
+	/*
+	 * Until today there is not any use case to mmap with non-zero
+	 * offset. Put an explicit check here.
+	 */
+	if (vma->vm_pgoff - drm_vma_node_start(&to_gobj(abo)->vma_node))
+		return -EINVAL;
+
+	if (is_import_bo(abo)) {
 		vma->vm_private_data = NULL;
 		vma->vm_ops = NULL;
 		ret = dma_buf_mmap(abo->dma_buf, vma, 0);
@@ -508,23 +509,28 @@ static int amdxdna_insert_pages(struct amdxdna_gem_obj *abo,
 			return ret;
 		}
 
+		amdxdna_mark_mapp_invalid(abo, vma);
+
 		/* Drop the reference drm_gem_mmap_obj() acquired.*/
 		drm_gem_object_put(to_gobj(abo));
+		return 0;
 	}
 
-	do {
-		vm_fault_t fault_ret;
-
-		fault_ret = handle_mm_fault(vma, vma->vm_start + offset,
-					    FAULT_FLAG_WRITE, NULL);
-		if (fault_ret & VM_FAULT_ERROR) {
-			XDNA_ERR(xdna, "Fault in page failed");
-			amdxdna_mark_mapp_invalid(abo, vma);
-			break;
-		}
+	ret = drm_gem_shmem_mmap(&abo->base, vma);
+	if (ret) {
+		XDNA_ERR(xdna, "Failed shmem mmap %d", ret);
+		return ret;
+	}
 
-		offset += PAGE_SIZE;
-	} while (--num_pages);
+	vm_flags_mod(vma, VM_MIXEDMAP, VM_PFNMAP);
+	ret = vm_insert_pages(vma, vma->vm_start, abo->base.pages, &num_pages);
+	if (ret) {
+		XDNA_ERR(xdna, "Failed to insert pages %d", ret);
+		dma_resv_lock(to_gobj(abo)->resv, NULL);
+		drm_gem_shmem_put_pages_locked(&abo->base);
+		dma_resv_unlock(to_gobj(abo)->resv);
+		return ret;
+	}
 
 	return 0;
 }
@@ -536,6 +542,10 @@ static int amdxdna_gem_obj_mmap(struct drm_gem_object *gobj,
 	struct amdxdna_gem_obj *abo = to_xdna_obj(gobj);
 	int ret;
 
+	XDNA_DBG(xdna, "BO map_offset 0x%llx type %d userptr 0x%lx size 0x%lx",
+		 drm_vma_node_offset_addr(&gobj->vma_node), abo->type,
+		 vma->vm_start, gobj->size);
+
 	ret = amdxdna_hmm_register(abo, vma);
 	if (ret)
 		return ret;
@@ -546,9 +556,6 @@ static int amdxdna_gem_obj_mmap(struct drm_gem_object *gobj,
 		goto hmm_unreg;
 	}
 
-	XDNA_DBG(xdna, "BO map_offset 0x%llx type %d userptr 0x%lx size 0x%lx",
-		 drm_vma_node_offset_addr(&gobj->vma_node), abo->type,
-		 vma->vm_start, gobj->size);
 	return 0;
 
 hmm_unreg:
@@ -556,14 +563,99 @@ static int amdxdna_gem_obj_mmap(struct drm_gem_object *gobj,
 	return ret;
 }
 
+/*
+ * VM operations for amdxdna shmem VMAs that use VM_MIXEDMAP.
+ *
+ * drm_gem_shmem_vm_ops cannot be used on VM_MIXEDMAP VMAs because its fault
+ * handler calls vmf_insert_pfn() → vmf_insert_pfn_prot() which contains:
+ *   BUG_ON((vma->vm_flags & VM_MIXEDMAP) && pfn_valid(pfn))
+ * All amdxdna shmem pages are ordinary struct pages so pfn_valid() is always
+ * true, making the combination fatal.
+ *
+ * These ops use vmf_insert_page() (struct-page based) instead, which is the
+ * correct API for VM_MIXEDMAP VMAs backed by real struct pages.  The open and
+ * close handlers replicate drm_gem_shmem_vm_open/close using only exported
+ * symbols.
+ */
+static vm_fault_t amdxdna_gem_mixedmap_fault(struct vm_fault *vmf)
+{
+	struct vm_area_struct *vma = vmf->vma;
+	struct drm_gem_object *gobj = vma->vm_private_data;
+	struct drm_gem_shmem_object *shmem = to_drm_gem_shmem_obj(gobj);
+	loff_t num_pages = gobj->size >> PAGE_SHIFT;
+	vm_fault_t ret = VM_FAULT_SIGBUS;
+	pgoff_t page_offset;
+	struct page *page;
+
+	/*
+	 * Partial free of vma is unexpected. Otherwise, the wrong page
+	 * will be faulted in and the user application may crash itself.
+	 */
+	page_offset = vmf->pgoff - vma->vm_pgoff;
+
+	dma_resv_lock(gobj->resv, NULL);
+
+	if (!shmem->pages || shmem->madv < 0 || page_offset >= num_pages)
+		goto out;
+
+	page = shmem->pages[page_offset];
+	if (WARN_ON_ONCE(!page))
+		goto out;
+
+	/*
+	 * Use vmf_insert_page() (struct-page path) not vmf_insert_pfn()
+	 * (PFN path) because this VMA carries VM_MIXEDMAP.
+	 */
+	ret = vmf_insert_page(vma, vmf->address, page);
+	if (ret == VM_FAULT_NOPAGE)
+		folio_mark_accessed(page_folio(page));
+
+out:
+	dma_resv_unlock(gobj->resv);
+	return ret;
+}
+
+static void amdxdna_gem_mixedmap_vm_open(struct vm_area_struct *vma)
+{
+	struct drm_gem_object *gobj = vma->vm_private_data;
+	struct drm_gem_shmem_object *shmem = to_drm_gem_shmem_obj(gobj);
+
+	/*
+	 * Bump pages_use_count so the page array stays alive for the new
+	 * mapping copy created by fork().  Mirrors drm_gem_shmem_vm_open().
+	 */
+	dma_resv_lock(gobj->resv, NULL);
+	drm_WARN_ON_ONCE(gobj->dev, !refcount_inc_not_zero(&shmem->pages_use_count));
+	dma_resv_unlock(gobj->resv);
+
+	drm_gem_vm_open(vma);
+}
+
+static void amdxdna_gem_mixedmap_vm_close(struct vm_area_struct *vma)
+{
+	struct drm_gem_object *gobj = vma->vm_private_data;
+	struct drm_gem_shmem_object *shmem = to_drm_gem_shmem_obj(gobj);
+
+	dma_resv_lock(gobj->resv, NULL);
+	drm_gem_shmem_put_pages_locked(shmem);
+	dma_resv_unlock(gobj->resv);
+
+	drm_gem_vm_close(vma);
+}
+
+static const struct vm_operations_struct amdxdna_gem_mixedmap_vm_ops = {
+	.fault  = amdxdna_gem_mixedmap_fault,
+	.open   = amdxdna_gem_mixedmap_vm_open,
+	.close  = amdxdna_gem_mixedmap_vm_close,
+};
+
 static int amdxdna_gem_dmabuf_mmap(struct dma_buf *dma_buf, struct vm_area_struct *vma)
 {
 	struct drm_gem_object *gobj = dma_buf->priv;
 	struct amdxdna_gem_obj *abo = to_xdna_obj(gobj);
-	unsigned long num_pages = vma_pages(vma);
 	int ret;
 
-	vma->vm_ops = &drm_gem_shmem_vm_ops;
+	vma->vm_ops = &amdxdna_gem_mixedmap_vm_ops;
 	vma->vm_private_data = gobj;
 
 	drm_gem_object_get(gobj);
@@ -573,16 +665,9 @@ static int amdxdna_gem_dmabuf_mmap(struct dma_buf *dma_buf, struct vm_area_struc
 
 	/* The buffer is based on memory pages. Fix the flag. */
 	vm_flags_mod(vma, VM_MIXEDMAP, VM_PFNMAP);
-	ret = vm_insert_pages(vma, vma->vm_start, abo->base.pages,
-			      &num_pages);
-	if (ret)
-		goto close_vma;
 
 	return 0;
 
-close_vma:
-	vma->vm_ops->close(vma);
-	return ret;
 put_obj:
 	drm_gem_object_put(gobj);
 	return ret;
@@ -878,7 +963,7 @@ static const struct drm_gem_object_funcs amdxdna_gem_shmem_funcs = {
 	.vmap = amdxdna_gem_obj_vmap,
 	.vunmap = amdxdna_gem_obj_vunmap,
 	.mmap = amdxdna_gem_obj_mmap,
-	.vm_ops = &drm_gem_shmem_vm_ops,
+	.vm_ops = &amdxdna_gem_mixedmap_vm_ops,
 	.export = amdxdna_gem_prime_export,
 };
 
-- 
2.34.1

