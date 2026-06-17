Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B424CD98E2
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 10:36:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F40110EF99;
	Wed, 17 Jun 2026 10:36:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RuHCjTgS";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012041.outbound.protection.outlook.com
 [40.107.200.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DAB410EF97;
 Wed, 17 Jun 2026 10:36:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vJqOhobc+kHOpi/ndNNqR+dNTx5U9cLwkoCXrImCef4dKXKiSuaBGSAksad5+yb5gWrheoL3IHewhR5fvHCG1YzF47CszuAiAbjl5NBCeU+wuJK9oVvTobmlz9uxjMJ3oXNbRw7laUQx8mE+l8CkhBE7ltXOksd4sjTVRWDDicFKPezzH6DJwxfcQFsyI3mydt9jn9Oo35bCgOrZYSjoSW5ZqxuDLQl4sTum32VaChHwm2Mb5+jFOIr3dEYzxwcB8RjmcD6VUJbLtLC9Yq2xouEvv10cIp17XtNQTtTOj8Z88PypIinbCQLkK2tgBbX9ebJoWiXKy3R+42b49V3heQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mQNcdeBfrcg79Lzn2aSRrJqF6L4p4U71x25rHG8wHgg=;
 b=wN/AerkyJU6oiwHRNQJy8nw++vW0GQ6Fr4wMs7dzxIPdYm9MqMEqsc0gSBWWtRC8RY/fN2PsbcFUEWCEaQVsWYFJ67OsK2C2n5g+saIJo1EXIKv0qUjaSvVxw+6dMJl7oiuwQGaRd5+iBs4Vkm+4xkNOo11o/jUxYrik56mjPj/D4spphUI5dDMMufIzn66urilopn35J9NmEGJyfw0BQ4p8A4SvvrMNThc9UqA7nZGwmNeuR+zvScjKf/ucbaCd/HoqffoBtH9pBWovtklkN4I2XJjcRFeRPR2DmJ+nEAiI9Es5HJNm/qsMAae0NBPZzmhiB+/xJF3OhKp+tKS8og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mQNcdeBfrcg79Lzn2aSRrJqF6L4p4U71x25rHG8wHgg=;
 b=RuHCjTgSR32S7C1uUuCQvB37xh5r1ibHCI6wY5uONEj7+ZoBqW/n7jOsvsnVs54TCET48lMCT3Lc7IAMP48d5LzLCnBBZUl5fEaravAjNvC4Gn22ZYPza56qsHG3bv9ZHkQC804tf/1y9dpXvpQgX9POuvNiw+O99F7raet3H14=
Received: from BLAPR05CA0004.namprd05.prod.outlook.com (2603:10b6:208:36e::8)
 by SJ2PR12MB9116.namprd12.prod.outlook.com (2603:10b6:a03:557::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 10:36:33 +0000
Received: from BL02EPF0001A106.namprd05.prod.outlook.com
 (2603:10b6:208:36e:cafe::47) by BLAPR05CA0004.outlook.office365.com
 (2603:10b6:208:36e::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.11 via Frontend Transport; Wed,
 17 Jun 2026 10:36:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A106.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Wed, 17 Jun 2026 10:36:33 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 17 Jun
 2026 05:36:28 -0500
From: Honglei Huang <honglei1.huang@amd.com>
To: <sima@ffwll.ch>, <matthew.brost@intel.com>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>
CC: <aliceryhl@google.com>, <Alexander.Deucher@amd.com>,
 <Felix.Kuehling@amd.com>, <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>,
 <Jenny-Jing.Liu@amd.com>, <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>,
 <Ray.Huang@amd.com>, <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>,
 <Yiru.Ma@amd.com>, <amd-gfx@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>,
 <honghuan@amd.com>
Subject: [PATCH v2 2/5] drm/gpusvm: embed struct drm_device into
 drm_gpusvm_pages
Date: Wed, 17 Jun 2026 18:35:59 +0800
Message-ID: <20260617103602.1491609-3-honglei1.huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260617103602.1491609-1-honglei1.huang@amd.com>
References: <20260617103602.1491609-1-honglei1.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A106:EE_|SJ2PR12MB9116:EE_
X-MS-Office365-Filtering-Correlation-Id: f33c0e48-fc28-4586-543c-08decc5c4d01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|23010399003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: NWtdpU95X0cpsBsFmkcnJaJ7TAL9Vwl729fBUXCoXu2IbMc0RfkttsUlXZPWzb6jQE3yEdyVGpFlMApt+BeYML9XRl4L83h2eC7wCogJeukY0eGkkPzHCIcYlucy3jCkW/xowQspa7Zs00v8NaEgP9Kszvu9t0p7QZP2exSj+jT6tbeeFIgGOKpgO/AUjLi+BePxEAncr2oQ17v8SSC/NP+6co0vGPcuYl+s0aKGpAxsd3litMxAYtjBjkrY0VDooA9Vk9NBLEKVQjNBYATFnVYY2hagvxCxJi95a8Wd4u+6Us+vtJV7kDKDSXSDxRThg1WCukp/NwSzZJs6OeWKU/KOiE80jP5zqChCx8vsoTjz3z+3UVpOZP8kmOFQfnkCCvwWqQAbpPNjcNoc1IL0TLYaSBki106+1Lw0HxdQF6KDgvMDec3aOLuofOjSJQgA7QdMj373eM62Qj1g70m1AxXVbzuIaq5o/pl9nj8RqGEj7W8dLvtezN+2fPN4Gv2UZjWNSpHk5ymJEJBJSUi6ijXVakiO/w7jLJHgOMAhNv1LumDKtSG4SSQXZE6GJ4URo1xcnJCEaHKWZTwg9KmY1bOu5MsNOzmfEHcueKgcb9M5N5tSfnXYngqWjLo/LOFhqsN6vpvXzb12kJleJt62yZehRoeDVzhzEhUWWLMSMU4hQ9KYJDvY397vkjGh/j/E50a2ZI2ibh4c0WOptdDATQt67e2EUuRmhP0rIz87sPA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(23010399003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7w+U6VTOPlkb1/UEzLMEWgDzLKNAkToc3KoiafxkrNFJFIPlTgfhFm4esIdrVmbmvUj2MZufEaLFwJi9G3jK0mmfH6wh747IIf1h4fo3L004iTIUVSv87S3rW+S8OOFoHWvnpeclSjt3dtYt+T276hPegeILCSBMl6J3Rv9p2DnB11d+7n/Tag0qP0aohdzbs8EbfOCENySKUHLENskNT9X/DP7V41pW//wryzbUrTf4Zyeyp4jMtAhUGiwcPSSa6UoXlBCH4us2Dm3VaF0STFjBzluR8r1HLddyiuAv2a4fAHkEw/XM9FUldUKKi75Zp+ZekIIkBRuyunh4M37nmWnEFM08koghYzeHZZZ6GEb+MNZPLp+ONWKKT0WRtJ0NnrEl0xvkzt4bi9uJROsReybSI8wMcM5n1GKi9L6bCcZyxMzX8kiL1POipKTNIi+Z
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 10:36:33.3818 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f33c0e48-fc28-4586-543c-08decc5c4d01
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A106.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9116
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

  - Add drm to struct drm_gpusvm_pages and route all DMA in
    drm_gpusvm_get_pages() / __drm_gpusvm_unmap_pages() through
    svm_pages->drm instead of gpusvm->drm.
  - Bind svm_pages->drm where the pages object is initialised
    (drm_gpusvm_range_alloc() and the xe userptr setup) and require
    it to be set on entry to drm_gpusvm_get_pages(); the dma device
    is immutable for the lifetime of the pages instance. A later
    patch introduces drm_gpusvm_init_pages() to centralise this.

Suggested-by: Matthew Brost <matthew.brost@intel.com>
Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/drm_gpusvm.c    | 30 ++++++++++++++++++++----------
 drivers/gpu/drm/xe/xe_userptr.c |  2 ++
 include/drm/drm_gpusvm.h        |  2 ++
 3 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
index 6cb38c76dc7..d6407c94cdd 100644
--- a/drivers/gpu/drm/drm_gpusvm.c
+++ b/drivers/gpu/drm/drm_gpusvm.c
@@ -641,6 +641,7 @@ drm_gpusvm_range_alloc(struct drm_gpusvm *gpusvm,
 	range->itree.last = ALIGN(fault_addr + 1, chunk_size) - 1;
 	INIT_LIST_HEAD(&range->entry);
 	range->pages.notifier_seq = LONG_MAX;
+	range->pages.drm = gpusvm->drm;
 	range->flags.migrate_devmem = migrate_devmem ? 1 : 0;
 
 	return range;
@@ -1135,11 +1136,16 @@ static void __drm_gpusvm_unmap_pages(struct drm_gpusvm *gpusvm,
 				     unsigned long npages)
 {
 	struct drm_pagemap *dpagemap = svm_pages->dpagemap;
-	struct device *dev = gpusvm->drm->dev;
+	struct device *dev;
 	unsigned long i, j;
 
 	lockdep_assert_held(&gpusvm->notifier_lock);
 
+	if (!svm_pages->drm)
+		return;
+
+	dev = svm_pages->drm->dev;
+
 	if (svm_pages->flags.has_dma_mapping) {
 		struct drm_gpusvm_pages_flags flags = {
 			.__flags = svm_pages->flags.__flags,
@@ -1421,6 +1427,9 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
 							   DMA_BIDIRECTIONAL;
 	struct dma_iova_state *state = &svm_pages->state;
 
+	if (!svm_pages->drm)
+		return -EINVAL;
+
 retry:
 	if (time_after(jiffies, timeout))
 		return -EBUSY;
@@ -1520,7 +1529,7 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
 
 				pagemap = page_pgmap(page);
 				dpagemap = drm_pagemap_page_to_dpagemap(page);
-				if (drm_WARN_ON(gpusvm->drm, !dpagemap)) {
+				if (drm_WARN_ON(svm_pages->drm, !dpagemap)) {
 					/*
 					 * Raced. This is not supposed to happen
 					 * since hmm_range_fault() should've migrated
@@ -1532,10 +1541,10 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
 			}
 			svm_pages->dma_addr[j] =
 				dpagemap->ops->device_map(dpagemap,
-							  gpusvm->drm->dev,
+							  svm_pages->drm->dev,
 							  page, order,
 							  dma_dir);
-			if (dma_mapping_error(gpusvm->drm->dev,
+			if (dma_mapping_error(svm_pages->drm->dev,
 					      svm_pages->dma_addr[j].addr)) {
 				err = -EFAULT;
 				goto err_unmap;
@@ -1555,11 +1564,11 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
 			}
 
 			if (!i)
-				dma_iova_try_alloc(gpusvm->drm->dev, state,
+				dma_iova_try_alloc(svm_pages->drm->dev, state,
 						   0, npages * PAGE_SIZE);
 
 			if (dma_use_iova(state)) {
-				err = dma_iova_link(gpusvm->drm->dev, state,
+				err = dma_iova_link(svm_pages->drm->dev, state,
 						    hmm_pfn_to_phys(pfns[i]),
 						    svm_pages->state_offset,
 						    PAGE_SIZE << order,
@@ -1570,11 +1579,11 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
 				addr = state->addr + svm_pages->state_offset;
 				svm_pages->state_offset += PAGE_SIZE << order;
 			} else {
-				addr = dma_map_page(gpusvm->drm->dev,
+				addr = dma_map_page(svm_pages->drm->dev,
 						    page, 0,
 						    PAGE_SIZE << order,
 						    dma_dir);
-				if (dma_mapping_error(gpusvm->drm->dev, addr)) {
+				if (dma_mapping_error(svm_pages->drm->dev, addr)) {
 					err = -EFAULT;
 					goto err_unmap;
 				}
@@ -1590,7 +1599,7 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
 	}
 
 	if (dma_use_iova(state)) {
-		err = dma_iova_sync(gpusvm->drm->dev, state, 0,
+		err = dma_iova_sync(svm_pages->drm->dev, state, 0,
 				    svm_pages->state_offset);
 		if (err)
 			goto err_unmap;
@@ -1640,7 +1649,8 @@ int drm_gpusvm_range_get_pages(struct drm_gpusvm *gpusvm,
 			       struct drm_gpusvm_range *range,
 			       const struct drm_gpusvm_ctx *ctx)
 {
-	return drm_gpusvm_get_pages(gpusvm, &range->pages, gpusvm->mm,
+	return drm_gpusvm_get_pages(gpusvm, &range->pages,
+				    gpusvm->mm,
 				    &range->notifier->notifier,
 				    drm_gpusvm_range_start(range),
 				    drm_gpusvm_range_end(range), ctx);
diff --git a/drivers/gpu/drm/xe/xe_userptr.c b/drivers/gpu/drm/xe/xe_userptr.c
index 6761005c0b9..1b540e62af6 100644
--- a/drivers/gpu/drm/xe/xe_userptr.c
+++ b/drivers/gpu/drm/xe/xe_userptr.c
@@ -390,6 +390,7 @@ int xe_userptr_setup(struct xe_userptr_vma *uvma, unsigned long start,
 		     unsigned long range)
 {
 	struct xe_userptr *userptr = &uvma->userptr;
+	struct xe_vm *vm = xe_vma_vm(&uvma->vma);
 	int err;
 
 	INIT_LIST_HEAD(&userptr->invalidate_link);
@@ -402,6 +403,7 @@ int xe_userptr_setup(struct xe_userptr_vma *uvma, unsigned long start,
 		return err;
 
 	userptr->pages.notifier_seq = LONG_MAX;
+	userptr->pages.drm = &vm->xe->drm;
 
 	return 0;
 }
diff --git a/include/drm/drm_gpusvm.h b/include/drm/drm_gpusvm.h
index 251a7266a73..842353afb27 100644
--- a/include/drm/drm_gpusvm.h
+++ b/include/drm/drm_gpusvm.h
@@ -129,6 +129,7 @@ struct drm_gpusvm_pages_flags {
 /**
  * struct drm_gpusvm_pages - Structure representing a GPU SVM mapped pages
  *
+ * @drm: The DRM device that owns the dma mappings
  * @dma_addr: Device address array
  * @dpagemap: The struct drm_pagemap of the device pages we're dma-mapping.
  *            Note this is assuming only one drm_pagemap per range is allowed.
@@ -138,6 +139,7 @@ struct drm_gpusvm_pages_flags {
  * @flags: Flags for the range; see &struct drm_gpusvm_pages_flags
  */
 struct drm_gpusvm_pages {
+	struct drm_device *drm;
 	struct drm_pagemap_addr *dma_addr;
 	struct drm_pagemap *dpagemap;
 	struct dma_iova_state state;
-- 
2.34.1

