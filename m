Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BD13C43327
	for <dri-devel@archiver.kernel.org>; Sat, 27 Jun 2026 03:54:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1EDB10F788;
	Sat, 27 Jun 2026 03:54:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Bi8LZahH";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012033.outbound.protection.outlook.com
 [40.107.200.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8F1610F788;
 Sat, 27 Jun 2026 03:54:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jfc4ndb9HjWpC5rbhCJIE6udNUJPSx8fBw7MdKluw2GlL7mxo/p97GR0IZB/6ptSVphYT9yo5fwTut4c4L1rLlHQdkKXPHGIn8Ev26wwSNrILgFpsnPNic3B5msrNZRQ9Hu3KAkeRUnvnmM4gtqJ38Ki2TOHpt0gazRQ3Akeb4F/vVjsQlmT2UkS39QmRn0gqS+BkeJqLZz7J4ruGGOazju8mxRBu5qR8o+rziPhpIY+89S+1HksH1HYqlSho+tcAR+BpwJ2OTtIce2CJ8S5Rwl3SlWgk6kuF+sjIm/TjTKGUjBJtXngj7tAEu75qT72DAIVBK858PONb/rLcMOIsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OuK0Aqvkwbn1CIAHPOBC1ON1bue/H+cxkVq7QAGT0Ms=;
 b=kuzS+HJkdK3GOSbmOXMujOb97uOecNioadP93MbJEkNrnuX5kyUssGjvLQpxmGi8w+MfJN+UEUSzNgd3x4is/h0I7qwUUriCp01bvsEMVRV58rDUhCbnSZouXTNxRvF5KAzo597Y0eFLNZ5eZH18w9KbUATjg/AJ3L0Wnswj7tOwJKwLEwpjGhkFVjIubncEKQEOlMCBhD7bBhcG5Ti/qov7v/5YDCsihilsUJMV23a8MFfeBuXrQNPb2WRdsK73H64HbGijRAAFXurnNvC6c+uY62hqfGkJLqV55uxd0j2n+1OULQ3BjCCpHcMOmzcgAJESVeFW7BzlwUCY/IGFTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OuK0Aqvkwbn1CIAHPOBC1ON1bue/H+cxkVq7QAGT0Ms=;
 b=Bi8LZahHoXrwyE19ExwnZVPISiAEAp7KH+s+LYLrts5Kap/9lErUzmQ106T2O4U3rpxQ0hptd/NrYNRutgYHpbOY3UEUDw1zI3QwfCjopdwgML/HvNOJ3VXqbu3R+J0aqRGjVtCeG3tzPGem0+fWr832j/yF3DVr849e01ERPuM=
Received: from MN2PR03CA0015.namprd03.prod.outlook.com (2603:10b6:208:23a::20)
 by DSSPR12MB999213.namprd12.prod.outlook.com (2603:10b6:8:378::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Sat, 27 Jun
 2026 03:54:43 +0000
Received: from BL6PEPF00020E64.namprd04.prod.outlook.com
 (2603:10b6:208:23a:cafe::8c) by MN2PR03CA0015.outlook.office365.com
 (2603:10b6:208:23a::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.17 via Frontend Transport; Sat,
 27 Jun 2026 03:54:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E64.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Sat, 27 Jun 2026 03:54:43 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 26 Jun
 2026 22:54:37 -0500
From: Honglei Huang <honglei1.huang@amd.com>
To: <sima@ffwll.ch>, <matthew.brost@intel.com>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>,
 <intel-xe@lists.freedesktop.org>
CC: <aliceryhl@google.com>, <Alexander.Deucher@amd.com>,
 <Felix.Kuehling@amd.com>, <Christian.Koenig@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>, <Yiru.Ma@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <honghuan@amd.com>
Subject: [PATCH v5 2/5] drm/gpusvm: embed struct drm_device into
 drm_gpusvm_pages
Date: Sat, 27 Jun 2026 11:54:14 +0800
Message-ID: <20260627035418.3796481-2-honglei1.huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260627035418.3796481-1-honglei1.huang@amd.com>
References: <20260627035418.3796481-1-honglei1.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E64:EE_|DSSPR12MB999213:EE_
X-MS-Office365-Filtering-Correlation-Id: 991819d8-da47-40e9-84d0-08ded3ffd284
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|23010399003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: t2x/d1UcvU3SeiiGIj950hR8bp02VuVwhBRNA5mZJH9J0rHXzKiwRwci6uvlvMNEcQEBL0BdRkyjZR4SMf5G2K8lZ7upnXCaPpaMSFupA7wnhBRHGSrbLWWbZbk5ixNCbpF1ewpwbB3bBu7u/NRRGYKwvG9OM8D+BhvZmekB8970TYze1FuMhTC7HYFefNpXDGldXqMi0Wbl6AoPgek0l8MJdTwC/UVhdtRJh+WVO6mZ1n64VhwelL/mHvPiTVxSTE+qzPje5BXwqbLZZ7yQDZ4nnbdg9R+ZhiEqWsDXlygHaDI089UCTqDCLE/AlKxuCb1o8gdqcd8R0AmKuv6HIgVXAz7by3lcFUgIFif7s95bg2Dso0o4vMve6HNpigcRlUTGhq2Bz4zGVrsFSNynNFzDkY/3ugqkC4xab6mZ71DhIt5PHKKu/i30aVetOPWSshDPsHxUZMzvdTo6vTJQq/cVcSakoqzeNpxuKPg3oUYuBkMmXB7oAEDkuJg8AU7AWmg0/ARJ+amSMlMdadb/Lwy0MDrFT63z6TPHzofqkknZuUP6Ap7kgb6jsi8va2AbGBXbCYGlltpVeN+LiYJaUsCjsFZ/raZvh5B8rARLTlK55eoNQ22y/ipTV9LxKsAuxIa4Lvh4/C29c8grAClt3SD4xN8jm1o3Wri1OLL64CaQ3zbRaxW9kB38RtcyduQhhVlEnUWTfDvT+WHzTK0G5Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(23010399003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: a56HcFipPSRV75jHpXosZRICvKrSmyghZEzjo7xACvbUv6onSNVHey2LmV5/3sZnbOyBWPWQUtfDDIB4n2165CtjSLjZ6MW242XA0EeE2NCVUHpMunnjGKVXVaeI/wBjXfuHWTUVVs65CMcuV/uu17QXv1XkDJYKNT6JKxbOAwXcFyfUwmICS8ue2KooWaqBkuCGdEQOVsjLVn3868HpaTz12ZgAw9MZFpMPWNkCRuZs6mHC7COml3ACYnh+4kw+2MwmWWX6EEVoJ1J047t614N/VcuHIZGW3RObb3MhdvT0CojLsB76qZ8jOiMzqjAXUeG82kxYNWYfo+qb4VM7odC1WVAF0Z2xPXFeUu/IL+iflfCYp03fUy/bi3v4BtkPnIsJftm9weFBmmBQ5cp5m3qU4ABntTWlrn5OIyhFo0TxLVPG8EJSC2lRQ8JePYqx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2026 03:54:43.4779 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 991819d8-da47-40e9-84d0-08ded3ffd284
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSSPR12MB999213
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
Reviewed-by: Matthew Brost <matthew.brost@intel.com>
Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/drm_gpusvm.c    | 30 ++++++++++++++++++++----------
 drivers/gpu/drm/xe/xe_userptr.c |  2 ++
 include/drm/drm_gpusvm.h        |  2 ++
 3 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
index df900553f21..155e3c2e703 100644
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

