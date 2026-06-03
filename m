Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26086CD6E4A
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 06:57:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CDDC10F909;
	Wed,  3 Jun 2026 06:57:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5uBdgdTI";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012060.outbound.protection.outlook.com
 [40.93.195.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95BBA10F907;
 Wed,  3 Jun 2026 06:56:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n+zoEwjrhlJqqhzIJwGZkWJsEuCZcnUH3B0HVuGw7ygYrFGPMLEXkOvpAXXHchlj1mks8OuouL30RVhl6gFDFGdJka63db5X908MDiK2teS2NQjLZHzpjpU96BxG0R8zTjALP556QGBeoTwHkKi/WuyGadtmAP/07bG6PvDMBHiVwLNLJHYQNzV1YBLuZURyXurhXekf/xWqooxpmUfGsgJ2xkBcIYAlXhOITLvmhpR5hzSKN8zn9rnSAQ8L31ECI3DvQ1g91bVXGSyT3QAYhhSteZOhLwORGXEbTei2b28tCW61NssubEnMYOAYHfgoUyEKI/t9OBnMvXK6lg+ZrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eJM8MllX4UWG9iBcG0IuXfQrKJhaT7+uo2gJWA2avAk=;
 b=q8zhetEsiHgpipeCQOCmC9l6ErpH9H19P/KFFPr37c+g59jkdgO/nVp+LWZ1aQVtRa+DBXvIz7Xa1CcfmQlJRC8ZC/bg8/2uHt4eh8g5cUBBMcd6nEI9Kw8l1wV/lmmCEa+6cXOT/IOFT5gBS58ESEsWfoypip/oSskblmDMJO8m20QRUrvDPK3oWupVLuGNIVbkLlHKfkh3/pyxL3noT354tFsBwyNETjzWebw8D81D9ZEL2kyq1wMe4qAufFTA6eXdKl1L1KtUE3wmD3UPAM8o659uWzZ07utGZI1ojl+M3Pcd8h/AuZVgOzyzdrkQNYd92XmaItb8BObVfuTNng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJM8MllX4UWG9iBcG0IuXfQrKJhaT7+uo2gJWA2avAk=;
 b=5uBdgdTIDs41ZnfsfVrEVOOP/HhLIjjCZ3M5dr5VTAp8fJcojocW44KHjUXEz2bx26fy377squf0e0NStWToPO0f2hkDMXI1E2lDlgeM2oSMEnwJpZT9g5GUo+Z74tsfX+4J6ga7bvtlz3rGPrj4S0frCyaaE/baQWSMf2e0jWY=
Received: from DS1P220CA0002.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:455::11) by
 CH3PR12MB7546.namprd12.prod.outlook.com (2603:10b6:610:149::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 06:56:53 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2603:10b6:8:455:cafe::8a) by DS1P220CA0002.outlook.office365.com
 (2603:10b6:8:455::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Wed, 3
 Jun 2026 06:56:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE33.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Wed, 3 Jun 2026 06:56:52 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 3 Jun
 2026 01:56:48 -0500
From: Honglei Huang <honglei1.huang@amd.com>
To: <sima@ffwll.ch>, <matthew.brost@intel.com>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>
CC: <aliceryhl@google.com>, <Alexander.Deucher@amd.com>,
 <Felix.Kuehling@amd.com>, <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>,
 <Jenny-Jing.Liu@amd.com>, <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>,
 <Ray.Huang@amd.com>, <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>,
 <Yiru.Ma@amd.com>, <amd-gfx@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <honghuan@amd.com>
Subject: [RFC 2/5] drm/gpusvm: embed struct drm_device into drm_gpusvm_pages
Date: Wed, 3 Jun 2026 14:56:17 +0800
Message-ID: <20260603065620.2555316-3-honglei1.huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260603065620.2555316-1-honglei1.huang@amd.com>
References: <20260603065620.2555316-1-honglei1.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|CH3PR12MB7546:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ac105e7-9a7e-46a6-ce7c-08dec13d4af3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: tkeNL+mS8xxA+VhUsFrNh1ivQtbOhdFt2SX3jbTIgkLdWYmmn/6HqYwDm3dBXUD2H5KKEBlKHJ8v4l4NXPnZfvFYb4Ax1rNznsDzh1uqe3W4srxLUF+7f+a4gCv9egNR6UeQ/+sZm1JUF5WgwFp2tyB/459lIwhfhUmwAbhtEagN4+3F7aSI48K/ZPqTwjoUvMTWcJH7EusU0RisVbe6hiGOZMAzh2SJL8kV/5pSjBTDrdidZmmIAhE3rE33EIwhoxGnKWAHRpQ5oJHaZpV+C6wpSrB3ex5Psnn7H7zcT95nPanNUcy1CpRbE8MWk7yIodQeCF7SeDhhtAosQWbOTs3dkeWmMIGqXUIVGUx3QwnIpW9++Cmr9AEEyRBcS6R3AXkjpouxLXXDXu85cxfTjRbgXCFEEabAMrLhw/xZBF/KX7XDHY8YvNxm5Aq/gHD4t+YfCOxE0iwDv/bocPrj2yHDGcOelVC4asE+/lXE6sHLvmZGWpIrt9LYoYPqLeMGMHabCp2prkQMN0LoFzA/6FE82/xBIwQ8GynP+jaQb/MGHejJ+OZYJA98gy32HXtt0Fut5MdDxY8owVm234muujDOl+bxy/8tVGFBkvWkORq47z4S4NQExUe9iIAnE/sbQlOjO+w5XMEcF6dlkEDDi9Dufg/XwvNBV4PpPdHZcl3dXAhiK4Cs/q0/wPAc+e2bt90NBHs5a/cRNuN5katVDpBMeHzwtVsjCDqOORYdJ2E=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: yWETtg1x6rHqDErWZTTCJM3iA/4LQ+3cVCjE2KifOG1WN4hf5OLV7XgF5nAGbFafkPXZV2e2fMHWaoYfrrVFz+YODyfeOMK38KJf2cAqBtxx8hv3E7TF8I3fSSN0I5bSGl+q2ID7olv50qFAffF8GW+Xl/Wg/nlssPb8yDVHk8XjV0eqeZD43uY9W2wuligt03xrPqp8uKHCqY1Djd5sH5EiPn4qm4zqFth1fNjT4fPe4UvUy+GTPwvZat9SX5l0kEZjdyn+zCK1KbPkPyNov1GcWB50wNWvxBp8MvWpAJUgcFT3M7XMy97U98e4GuAql11vajToJgLtvpoNr6Jy+mwsh3YvLw6pAw4/TwwO2Xz2ZCsIuHtbgopUCtFIv7MT6UEFd16rEHLtAUUfjO1m2THbdNk1OgSKG+z4W9uM/AxeXEmT5FP4gyMe4UVHmbhY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 06:56:52.6968 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ac105e7-9a7e-46a6-ce7c-08dec13d4af3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7546
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

From: Honglei Huang <honghuan@amd.com>

drm_gpusvm_pages is the layer that actually represents physical
pages/mappings it owns the dma_addr array, the dma_iova_state...
With the previous patch, so drm_gpusvm_pages is now strictly about
physical pages and their DMA view.

Since now the drm_gpusvm_pages instance is inherently bound to one
specific drm_device, make that ownership explicit by giving
drm_gpusvm_pages its own drm_device handle, and drive all DMA through
it instead of through the gpusvm:

  - Add drm to struct drm_gpusvm_pages and a matching drm parameter
    to drm_gpusvm_get_pages(); the dma device is bound on first use
    and immutable for the lifetime of the pages instance.
  - Route all DMA in drm_gpusvm_get_pages() / __drm_gpusvm_unmap_pages()
    through svm_pages->drm instead of gpusvm->drm.
  - Update existing callers (drm_gpusvm_range_get_pages, xe userptr)

Suggested-by: Matthew Brost <matthew.brost@intel.com>
Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/drm_gpusvm.c    | 37 ++++++++++++++++++++++++---------
 drivers/gpu/drm/xe/xe_userptr.c |  1 +
 include/drm/drm_gpusvm.h        |  3 +++
 3 files changed, 31 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
index 6000d587cf2..3f076178b2a 100644
--- a/drivers/gpu/drm/drm_gpusvm.c
+++ b/drivers/gpu/drm/drm_gpusvm.c
@@ -1135,11 +1135,16 @@ static void __drm_gpusvm_unmap_pages(struct drm_gpusvm *gpusvm,
 				     unsigned long npages)
 {
 	struct drm_pagemap *dpagemap = svm_pages->dpagemap;
-	struct device *dev = gpusvm->drm->dev;
+	struct device *dev;
 	unsigned long i, j;
 
 	lockdep_assert_held(&gpusvm->notifier_lock);
 
+	if (WARN_ON_ONCE(!svm_pages->drm))
+		return;
+
+	dev = svm_pages->drm->dev;
+
 	if (svm_pages->flags.has_dma_mapping) {
 		struct drm_gpusvm_pages_flags flags = {
 			.__flags = svm_pages->flags.__flags,
@@ -1379,6 +1384,7 @@ static bool drm_gpusvm_pages_valid_unlocked(struct drm_gpusvm *gpusvm,
  * drm_gpusvm_get_pages() - Get pages and populate GPU SVM pages struct
  * @gpusvm: Pointer to the GPU SVM structure
  * @svm_pages: The SVM pages to populate. This will contain the dma-addresses
+ * @drm: The DRM device that will own the DMA mappings. Stored into @svm_pages
  * @mm: The mm corresponding to the CPU range
  * @notifier: The corresponding notifier for the given CPU range
  * @pages_start: Start CPU address for the pages
@@ -1392,6 +1398,7 @@ static bool drm_gpusvm_pages_valid_unlocked(struct drm_gpusvm *gpusvm,
  */
 int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
 			 struct drm_gpusvm_pages *svm_pages,
+			 struct drm_device *drm,
 			 struct mm_struct *mm,
 			 struct mmu_interval_notifier *notifier,
 			 unsigned long pages_start, unsigned long pages_end,
@@ -1421,6 +1428,15 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
 							   DMA_BIDIRECTIONAL;
 	struct dma_iova_state *state = &svm_pages->state;
 
+	if (!drm)
+		return -EINVAL;
+	if (svm_pages->drm) {
+		if (svm_pages->drm != drm)
+			return -EINVAL;
+	} else {
+		svm_pages->drm = drm;
+	}
+
 retry:
 	if (time_after(jiffies, timeout))
 		return -EBUSY;
@@ -1515,7 +1531,7 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
 
 				pagemap = page_pgmap(page);
 				dpagemap = drm_pagemap_page_to_dpagemap(page);
-				if (drm_WARN_ON(gpusvm->drm, !dpagemap)) {
+				if (drm_WARN_ON(drm, !dpagemap)) {
 					/*
 					 * Raced. This is not supposed to happen
 					 * since hmm_range_fault() should've migrated
@@ -1527,10 +1543,10 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
 			}
 			svm_pages->dma_addr[j] =
 				dpagemap->ops->device_map(dpagemap,
-							  gpusvm->drm->dev,
+							  drm->dev,
 							  page, order,
 							  dma_dir);
-			if (dma_mapping_error(gpusvm->drm->dev,
+			if (dma_mapping_error(drm->dev,
 					      svm_pages->dma_addr[j].addr)) {
 				err = -EFAULT;
 				goto err_unmap;
@@ -1550,11 +1566,11 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
 			}
 
 			if (!i)
-				dma_iova_try_alloc(gpusvm->drm->dev, state,
+				dma_iova_try_alloc(drm->dev, state,
 						   0, npages * PAGE_SIZE);
 
 			if (dma_use_iova(state)) {
-				err = dma_iova_link(gpusvm->drm->dev, state,
+				err = dma_iova_link(drm->dev, state,
 						    hmm_pfn_to_phys(pfns[i]),
 						    svm_pages->state_offset,
 						    PAGE_SIZE << order,
@@ -1565,11 +1581,11 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
 				addr = state->addr + svm_pages->state_offset;
 				svm_pages->state_offset += PAGE_SIZE << order;
 			} else {
-				addr = dma_map_page(gpusvm->drm->dev,
+				addr = dma_map_page(drm->dev,
 						    page, 0,
 						    PAGE_SIZE << order,
 						    dma_dir);
-				if (dma_mapping_error(gpusvm->drm->dev, addr)) {
+				if (dma_mapping_error(drm->dev, addr)) {
 					err = -EFAULT;
 					goto err_unmap;
 				}
@@ -1585,7 +1601,7 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
 	}
 
 	if (dma_use_iova(state)) {
-		err = dma_iova_sync(gpusvm->drm->dev, state, 0,
+		err = dma_iova_sync(drm->dev, state, 0,
 				    svm_pages->state_offset);
 		if (err)
 			goto err_unmap;
@@ -1635,7 +1651,8 @@ int drm_gpusvm_range_get_pages(struct drm_gpusvm *gpusvm,
 			       struct drm_gpusvm_range *range,
 			       const struct drm_gpusvm_ctx *ctx)
 {
-	return drm_gpusvm_get_pages(gpusvm, &range->pages, gpusvm->mm,
+	return drm_gpusvm_get_pages(gpusvm, &range->pages, gpusvm->drm,
+				    gpusvm->mm,
 				    &range->notifier->notifier,
 				    drm_gpusvm_range_start(range),
 				    drm_gpusvm_range_end(range), ctx);
diff --git a/drivers/gpu/drm/xe/xe_userptr.c b/drivers/gpu/drm/xe/xe_userptr.c
index 6761005c0b9..7e28f6868ff 100644
--- a/drivers/gpu/drm/xe/xe_userptr.c
+++ b/drivers/gpu/drm/xe/xe_userptr.c
@@ -75,6 +75,7 @@ int xe_vma_userptr_pin_pages(struct xe_userptr_vma *uvma)
 		return 0;
 
 	return drm_gpusvm_get_pages(&vm->svm.gpusvm, &uvma->userptr.pages,
+				    &xe->drm,
 				    uvma->userptr.notifier.mm,
 				    &uvma->userptr.notifier,
 				    xe_vma_userptr(vma),
diff --git a/include/drm/drm_gpusvm.h b/include/drm/drm_gpusvm.h
index 3dba4b9516f..ed228d9ff6b 100644
--- a/include/drm/drm_gpusvm.h
+++ b/include/drm/drm_gpusvm.h
@@ -127,6 +127,7 @@ struct drm_gpusvm_pages_flags {
 /**
  * struct drm_gpusvm_pages - Structure representing a GPU SVM mapped pages
  *
+ * @drm: The DRM device that owns the dma mappings
  * @dma_addr: Device address array
  * @dpagemap: The struct drm_pagemap of the device pages we're dma-mapping.
  *            Note this is assuming only one drm_pagemap per range is allowed.
@@ -136,6 +137,7 @@ struct drm_gpusvm_pages_flags {
  * @flags: Flags for the range; see &struct drm_gpusvm_pages_flags
  */
 struct drm_gpusvm_pages {
+	struct drm_device *drm;
 	struct drm_pagemap_addr *dma_addr;
 	struct drm_pagemap *dpagemap;
 	struct dma_iova_state state;
@@ -328,6 +330,7 @@ void drm_gpusvm_range_set_unmapped(struct drm_gpusvm_range *range,
 
 int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
 			 struct drm_gpusvm_pages *svm_pages,
+			 struct drm_device *drm,
 			 struct mm_struct *mm,
 			 struct mmu_interval_notifier *notifier,
 			 unsigned long pages_start, unsigned long pages_end,
-- 
2.34.1

