Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 004F5C43602
	for <dri-devel@archiver.kernel.org>; Sat, 27 Jun 2026 03:54:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EBD710F78B;
	Sat, 27 Jun 2026 03:54:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qy0ZROPd";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010041.outbound.protection.outlook.com [52.101.56.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D510E10F787;
 Sat, 27 Jun 2026 03:54:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dHaMvH2CO2LPlHWKjA+SqwZH2MywblxHA+DGocGcP55w9nRcdTm8yeazAfkINAH7l4hvwqdu2cifpNeK0VJjo+J/KoWMAilwEdBAdGKWWrUWUqaMCeacId+JQJjscuv0OK0gda3Ez0dnRPy5C3/IFkdf9n0ySy+sf8fgmFWTWq824rCVhRxUHBhY1hzz3lIU6Se3r086/byjwTAX9N+RYu8OkAZk5BJ6bdL2/Dpzz2MLtCw+Dt+Sor2iWuXIvVdPG81iPgaErPBmmMY1DJtB3om6Zyjs88kerFLa5ONkjBSVBHbYt6BNmeZM6OM7hhU+Ks+7pXH47RdH70wDrhnAvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wyVorZ0Y/4KrcMsDFShxPC8FCsn1I2nMhRgEoMi8Yrs=;
 b=D1ONexMlpfk4Y8wpv6lJl5dP1NYgrEkpjTJL78WWdsirwi6QmgBQ+bGiA2Q4IOALF6rtS1PWIZB5TLC0jHwcGTTaX+8txDaxBw5rlFGko1+1TCd+yCNVlQgB9dsH4X28wXnKt7J/ul+pJTgHP0ysubelnaFFiPWJL6eIixJcJmCRKmbw6axiYDhVCzP+qeUkIhwKVrwOcTsLP40CXmTD8v/slS7JsqWFw3RhBJQ3TtvVpxqHuLbi/tYDh9M5YVjUARvuQPIX8S070DCxaCH2H6g7kPShtIed4ezLrO9RGQBtTD6mZDxj9eFHum3lGAjcrUX9t7G89cw5uM5l/B5mrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wyVorZ0Y/4KrcMsDFShxPC8FCsn1I2nMhRgEoMi8Yrs=;
 b=qy0ZROPdTWaEpKdq7IYZjOUNTGMyvkiVvjAhTg/jxKeT6HPnG4eC4cie+iH7Ra3EW2yhpyCzMNC/fpTcDTd0TzlVgiV5oaU9uSQcoKJ7Ko6uKV3ZciG5zGMEBcaoBtNiUdAr/qZlQrTS1AzKCIZk1jtEBM6iPNTDHGAdZdwMVHo=
Received: from MN2PR03CA0012.namprd03.prod.outlook.com (2603:10b6:208:23a::17)
 by DS0PR12MB8454.namprd12.prod.outlook.com (2603:10b6:8:15e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Sat, 27 Jun
 2026 03:54:45 +0000
Received: from BL6PEPF00020E64.namprd04.prod.outlook.com
 (2603:10b6:208:23a:cafe::98) by MN2PR03CA0012.outlook.office365.com
 (2603:10b6:208:23a::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.17 via Frontend Transport; Sat,
 27 Jun 2026 03:54:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E64.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Sat, 27 Jun 2026 03:54:45 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 26 Jun
 2026 22:54:41 -0500
From: Honglei Huang <honglei1.huang@amd.com>
To: <sima@ffwll.ch>, <matthew.brost@intel.com>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>,
 <intel-xe@lists.freedesktop.org>
CC: <aliceryhl@google.com>, <Alexander.Deucher@amd.com>,
 <Felix.Kuehling@amd.com>, <Christian.Koenig@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>, <Yiru.Ma@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <honghuan@amd.com>
Subject: [PATCH v5 3/5] drm/xe: have xe_svm_range embed one drm_gpusvm_pages
Date: Sat, 27 Jun 2026 11:54:15 +0800
Message-ID: <20260627035418.3796481-3-honglei1.huang@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E64:EE_|DS0PR12MB8454:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a4f5782-6a62-4788-b9c3-08ded3ffd3bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|23010399003|11063799006|5023799004|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: F6Fgsv5ElGYiUjfOYbiYSvPJa3pefTl+oB5d97EyDOw2dVGqNpgVPkPGbdbEUwhgbxAQNbxICmCyrrEe4Uq60Mv+VlVcRyLLwRE+AcsGPuKsTlTX9+PP0FgLOBuN6SpzcXqRYjA91817rjS5nMsJ0yLmg7SKDquA2eJ5p8mqqf1SQMMs4UR2iX306hB/iUD5WDxVnB0FjN5oPMoqsITO7Ep5iKH1zy3bz7K6hCYpVyQAAFIBSK4LGKapkcAjkEVAbarYiXOn0zrUdrqxXPKK7PqzetyJtQskM6iK1fyOSo6AEu6s/q6sSAYdKnsscJ3ZW5rv1uxq8xr5GRZQvCP2JzrzZ2QEjxY5zHK8wzQtGZBtgu1HeshZsX/2GzL6+BSehtc2lkG92dS3RAaviuN9pc8rECj2b8md2nYUXKqPGq02oR+RxkWGPs17JM5F4A7dI/Wza/oQOsxhj2SjP86RkIES04kNfg0dbJKz1UeghnZfw4Dt9t0xMvoP9bc2GYNZOshQCwRZP7sYIjZn6HXuMOtZrmRtjf/8e7qO5FBkcXED9+p3DhFI7wEN6wJ/JUXRpIXMRdDljm+yZYQYa12GvaF5jXTYJgP2qPgfV40rTVak10a4mnET3oYaUqacmWYqLoDvBcdam0ShvFZSvViz+VE/GnDevHN2ddlnksjuCByOiWobeylWtk7uhzGum7EF4eTQrQUao7Shnyilcf/8uw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(23010399003)(11063799006)(5023799004)(56012099006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0PwUEUVyHvUmtPtybhYzWTFUGM89Uh3p5/Bchudm0cWvlmByc8o3TQ8lXTHbgMcy4Sv4Op7wccrpTmegPjPSfvVZAmjTpBx+C0wtBp8ALnP5PgKRxTJ9i6S4kq2qFRp4OBnnQjM3XNl2NGhgj+uXRUUdSpx1VPTSbkYxEzdZsTEityp4Q0N/FPRXngW1/AM5ZODKrVCurfx3CsX406lo0usErbj2BFqBVuZjUcsVgWJYC4zTjExihQpGNvKKezXYQcAo9f8/i1MYLlvCer5vCu7ITYSXJ/gVvg0+Kg7dymhrAtfcH6PiiLki1LJaNUHwrI8ES9clJsK7duwjHH/+PaUh7RVVk38n9zx5wbkI51zvNCxttlci2XLjvyRg1BVPyH+2KCQwbQK+4/DX4ugh1KxsWHW52eLAwgkZYLP5ufE/YwaSqXsrmKSTT0yVcVQq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2026 03:54:45.5297 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a4f5782-6a62-4788-b9c3-08ded3ffd3bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8454
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

With drm_gpusvm_pages now self contained, make xe stop relying
on the drm_gpusvm_range pages and take responsibility for the page
lifecycle on the driver side.

Driver side (xe):

  - Embed struct drm_gpusvm_pages in xe_svm_range and route all
    xe accesses through it instead of range->base.pages.
  - Initialise the embedded pages via drm_gpusvm_init_pages(), which
    binds the owning &xe->drm up front, and take over the page
    lifecycle: xe_svm_range_get_pages() calls drm_gpusvm_get_pages()
    directly; the notifier event_end and xe_svm_range_free() paths
    drive unmap/free on the embedded pages object.
  - Convert the open-coded userptr pages init in xe_userptr_setup()
    to the same drm_gpusvm_init_pages() helper.
  - Switch xe_svm_range_pages_valid() to drm_gpusvm_pages_valid().

Framework side (drm_gpusvm):

  - Add a small inline drm_gpusvm_init_pages() helper that records the
    owning drm_device and initialises the per-pages state, giving
    drivers a single hook to extend.
  - Export drm_gpusvm_pages_valid() to let driver owned pages
    can query mapping state without going through a range.
  - Lifecycle change: drm_gpusvm_range_remove() no longer *triggers*
    unmap/free of the embedded pages. The unmap/free logic itself stays
    in the framework -- drm_gpusvm_free_pages() still performs the DMA
    unmap (as an idempotent backstop) and frees the dma_addr array --
    but the driver now owns *when* it runs, since the driver owns the
    drm_gpusvm_pages object.

Side effect / contract: a driver that owns a drm_gpusvm_pages is now
responsible for its lifecycle: drm_gpusvm_init_pages() before first
use, and drm_gpusvm_free_pages() when the owner goes away. Xe does the
latter from its ops->range_free callback, which the framework invokes
once the range refcount drops to zero in drm_gpusvm_range_remove().
The timely DMA unmap for the IOMMU security model still happens in the
notifier invalidate path via drm_gpusvm_unmap_pages(); the unmap inside
drm_gpusvm_free_pages() is only a backstop for pages that were never
invalidated.

Suggested-by: Matthew Brost <matthew.brost@intel.com>
Reviewed-by: Matthew Brost <matthew.brost@intel.com>
Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/drm_gpusvm.c    | 14 ++++++++------
 drivers/gpu/drm/xe/xe_pt.c      |  2 +-
 drivers/gpu/drm/xe/xe_svm.c     | 24 ++++++++++++++++--------
 drivers/gpu/drm/xe/xe_svm.h     |  6 ++++--
 drivers/gpu/drm/xe/xe_userptr.c |  5 ++---
 include/drm/drm_gpusvm.h        | 20 ++++++++++++++++++++
 6 files changed, 51 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
index 155e3c2e703..85fbadc9716 100644
--- a/drivers/gpu/drm/drm_gpusvm.c
+++ b/drivers/gpu/drm/drm_gpusvm.c
@@ -1228,12 +1228,15 @@ EXPORT_SYMBOL_GPL(drm_gpusvm_free_pages);
  * This function removes the specified GPU SVM range and also removes the parent
  * GPU SVM notifier if no more ranges remain in the notifier. The caller must
  * hold a lock to protect range and notifier removal.
+ *
+ * This function does not unmap or free the drm_gpusvm_pages; the driver owns
+ * that lifecycle and is expected to release them from its
+ * &drm_gpusvm_ops.range_free callback (invoked once the range refcount drops
+ * to zero via drm_gpusvm_range_put() below).
  */
 void drm_gpusvm_range_remove(struct drm_gpusvm *gpusvm,
 			     struct drm_gpusvm_range *range)
 {
-	unsigned long npages = npages_in_range(drm_gpusvm_range_start(range),
-					       drm_gpusvm_range_end(range));
 	struct drm_gpusvm_notifier *notifier;
 
 	drm_gpusvm_driver_lock_held(gpusvm);
@@ -1245,8 +1248,6 @@ void drm_gpusvm_range_remove(struct drm_gpusvm *gpusvm,
 		return;
 
 	drm_gpusvm_notifier_lock(gpusvm);
-	__drm_gpusvm_unmap_pages(gpusvm, &range->pages, npages);
-	__drm_gpusvm_free_pages(gpusvm, &range->pages);
 	__drm_gpusvm_range_remove(notifier, range);
 	drm_gpusvm_notifier_unlock(gpusvm);
 
@@ -1325,13 +1326,14 @@ EXPORT_SYMBOL_GPL(drm_gpusvm_range_put);
  *
  * Return: True if GPU SVM range has valid pages, False otherwise
  */
-static bool drm_gpusvm_pages_valid(struct drm_gpusvm *gpusvm,
-				   struct drm_gpusvm_pages *svm_pages)
+bool drm_gpusvm_pages_valid(struct drm_gpusvm *gpusvm,
+			    struct drm_gpusvm_pages *svm_pages)
 {
 	lockdep_assert_held(&gpusvm->notifier_lock);
 
 	return svm_pages->flags.has_devmem_pages || svm_pages->flags.has_dma_mapping;
 }
+EXPORT_SYMBOL_GPL(drm_gpusvm_pages_valid);
 
 /**
  * drm_gpusvm_range_pages_valid() - GPU SVM range pages valid
diff --git a/drivers/gpu/drm/xe/xe_pt.c b/drivers/gpu/drm/xe/xe_pt.c
index 0959e0e88a1..4a8af0e934c 100644
--- a/drivers/gpu/drm/xe/xe_pt.c
+++ b/drivers/gpu/drm/xe/xe_pt.c
@@ -758,7 +758,7 @@ xe_pt_stage_bind(struct xe_tile *tile, struct xe_vma *vma,
 			return -EAGAIN;
 		}
 		if (xe_svm_range_has_dma_mapping(range)) {
-			xe_res_first_dma(range->base.pages.dma_addr, 0,
+			xe_res_first_dma(range->pages.dma_addr, 0,
 					 xe_svm_range_size(range),
 					 &curs);
 			xe_svm_range_debug(range, "BIND PREPARE - MIXED");
diff --git a/drivers/gpu/drm/xe/xe_svm.c b/drivers/gpu/drm/xe/xe_svm.c
index 63da149f3b7..77af0a8de63 100644
--- a/drivers/gpu/drm/xe/xe_svm.c
+++ b/drivers/gpu/drm/xe/xe_svm.c
@@ -66,7 +66,7 @@ static bool xe_svm_range_in_vram(struct xe_svm_range *range)
 
 	struct drm_gpusvm_pages_flags flags = {
 		/* Pairs with WRITE_ONCE in drm_gpusvm.c */
-		.__flags = READ_ONCE(range->base.pages.flags.__flags),
+		.__flags = READ_ONCE(range->pages.flags.__flags),
 	};
 
 	return flags.has_devmem_pages;
@@ -96,7 +96,7 @@ static struct xe_vm *range_to_vm(struct drm_gpusvm_range *r)
 	       (r__)->base.gpusvm,					\
 	       xe_svm_range_in_vram((r__)) ? 1 : 0,			\
 	       xe_svm_range_has_vram_binding((r__)) ? 1 : 0,		\
-	       (r__)->base.pages.notifier_seq,				\
+	       (r__)->pages.notifier_seq,				\
 	       xe_svm_range_start((r__)), xe_svm_range_end((r__)),	\
 	       xe_svm_range_size((r__)))
 
@@ -115,6 +115,7 @@ xe_svm_range_alloc(struct drm_gpusvm *gpusvm)
 		return NULL;
 
 	INIT_LIST_HEAD(&range->garbage_collector_link);
+	drm_gpusvm_init_pages(&range->pages, &gpusvm_to_vm(gpusvm)->xe->drm);
 	xe_vm_get(gpusvm_to_vm(gpusvm));
 
 	return &range->base;
@@ -122,8 +123,10 @@ xe_svm_range_alloc(struct drm_gpusvm *gpusvm)
 
 static void xe_svm_range_free(struct drm_gpusvm_range *range)
 {
+	drm_gpusvm_free_pages(range->gpusvm, &(to_xe_range(range)->pages),
+			      drm_gpusvm_range_size(range) >> PAGE_SHIFT);
 	xe_vm_put(range_to_vm(range));
-	kfree(range);
+	kfree(to_xe_range(range));
 }
 
 static void
@@ -134,7 +137,7 @@ xe_svm_garbage_collector_add_range(struct xe_vm *vm, struct xe_svm_range *range,
 
 	range_debug(range, "GARBAGE COLLECTOR ADD");
 
-	drm_gpusvm_range_set_unmapped(&range->base, &range->base.pages, 1,
+	drm_gpusvm_range_set_unmapped(&range->base, &range->pages, 1,
 				      mmu_range);
 
 	spin_lock(&vm->svm.garbage_collector.lock);
@@ -209,7 +212,8 @@ xe_svm_range_notifier_event_end(struct xe_vm *vm, struct drm_gpusvm_range *r,
 
 	xe_svm_assert_in_notifier(vm);
 
-	drm_gpusvm_range_unmap_pages(&vm->svm.gpusvm, r, &ctx);
+	drm_gpusvm_unmap_pages(&vm->svm.gpusvm, &(to_xe_range(r)->pages),
+			       drm_gpusvm_range_size(r) >> PAGE_SHIFT, &ctx);
 	if (!xe_vm_is_closed(vm) && mmu_range->event == MMU_NOTIFY_UNMAP)
 		xe_svm_garbage_collector_add_range(vm, to_xe_range(r),
 						   mmu_range);
@@ -953,7 +957,7 @@ void xe_svm_fini(struct xe_vm *vm)
 static bool xe_svm_range_has_pagemap_locked(const struct xe_svm_range *range,
 					    const struct drm_pagemap *dpagemap)
 {
-	return range->base.pages.dpagemap == dpagemap;
+	return range->pages.dpagemap == dpagemap;
 }
 
 static bool xe_svm_range_has_pagemap(struct xe_svm_range *range,
@@ -1018,7 +1022,7 @@ bool xe_svm_range_validate(struct xe_vm *vm,
 	if (dpagemap)
 		ret = ret && xe_svm_range_has_pagemap_locked(range, dpagemap);
 	else
-		ret = ret && !range->base.pages.dpagemap;
+		ret = ret && !range->pages.dpagemap;
 
 	xe_svm_notifier_unlock(vm);
 
@@ -1508,7 +1512,11 @@ int xe_svm_range_get_pages(struct xe_vm *vm, struct xe_svm_range *range,
 {
 	int err = 0;
 
-	err = drm_gpusvm_range_get_pages(&vm->svm.gpusvm, &range->base, ctx);
+	err = drm_gpusvm_get_pages(&vm->svm.gpusvm, &range->pages,
+				   vm->svm.gpusvm.mm,
+				   &range->base.notifier->notifier,
+				   drm_gpusvm_range_start(&range->base),
+				   drm_gpusvm_range_end(&range->base), ctx);
 	if (err == -EOPNOTSUPP) {
 		range_debug(range, "PAGE FAULT - EVICT PAGES");
 		drm_gpusvm_range_evict(&vm->svm.gpusvm, &range->base);
diff --git a/drivers/gpu/drm/xe/xe_svm.h b/drivers/gpu/drm/xe/xe_svm.h
index b7b8eeacf19..1423ab2f1d6 100644
--- a/drivers/gpu/drm/xe/xe_svm.h
+++ b/drivers/gpu/drm/xe/xe_svm.h
@@ -31,6 +31,8 @@ struct xe_vram_region;
 struct xe_svm_range {
 	/** @base: base drm_gpusvm_range */
 	struct drm_gpusvm_range base;
+	/** @pages: Page/DMA mapping state for this range (single drm_device). */
+	struct drm_gpusvm_pages pages;
 	/**
 	 * @garbage_collector_link: Link into VM's garbage collect SVM range
 	 * list. Protected by VM's garbage collect lock.
@@ -74,7 +76,7 @@ struct xe_pagemap {
  */
 static inline bool xe_svm_range_pages_valid(struct xe_svm_range *range)
 {
-	return drm_gpusvm_range_pages_valid(range->base.gpusvm, &range->base);
+	return drm_gpusvm_pages_valid(range->base.gpusvm, &range->pages);
 }
 
 int xe_devm_add(struct xe_tile *tile, struct xe_vram_region *vr);
@@ -132,7 +134,7 @@ void *xe_svm_private_page_owner(struct xe_vm *vm, bool force_smem);
 static inline bool xe_svm_range_has_dma_mapping(struct xe_svm_range *range)
 {
 	lockdep_assert_held(&range->base.gpusvm->notifier_lock);
-	return range->base.pages.flags.has_dma_mapping;
+	return range->pages.flags.has_dma_mapping;
 }
 
 /**
diff --git a/drivers/gpu/drm/xe/xe_userptr.c b/drivers/gpu/drm/xe/xe_userptr.c
index 1b540e62af6..06da9725a4a 100644
--- a/drivers/gpu/drm/xe/xe_userptr.c
+++ b/drivers/gpu/drm/xe/xe_userptr.c
@@ -396,15 +396,14 @@ int xe_userptr_setup(struct xe_userptr_vma *uvma, unsigned long start,
 	INIT_LIST_HEAD(&userptr->invalidate_link);
 	INIT_LIST_HEAD(&userptr->repin_link);
 
+	drm_gpusvm_init_pages(&userptr->pages, &vm->xe->drm);
+
 	err = mmu_interval_notifier_insert(&userptr->notifier, current->mm,
 					   start, range,
 					   &vma_userptr_notifier_ops);
 	if (err)
 		return err;
 
-	userptr->pages.notifier_seq = LONG_MAX;
-	userptr->pages.drm = &vm->xe->drm;
-
 	return 0;
 }
 
diff --git a/include/drm/drm_gpusvm.h b/include/drm/drm_gpusvm.h
index 842353afb27..3f38283111c 100644
--- a/include/drm/drm_gpusvm.h
+++ b/include/drm/drm_gpusvm.h
@@ -310,6 +310,9 @@ void drm_gpusvm_range_put(struct drm_gpusvm_range *range);
 bool drm_gpusvm_range_pages_valid(struct drm_gpusvm *gpusvm,
 				  struct drm_gpusvm_range *range);
 
+bool drm_gpusvm_pages_valid(struct drm_gpusvm *gpusvm,
+			    struct drm_gpusvm_pages *svm_pages);
+
 int drm_gpusvm_range_get_pages(struct drm_gpusvm *gpusvm,
 			       struct drm_gpusvm_range *range,
 			       const struct drm_gpusvm_ctx *ctx);
@@ -350,6 +353,23 @@ void drm_gpusvm_free_pages(struct drm_gpusvm *gpusvm,
 			   struct drm_gpusvm_pages *svm_pages,
 			   unsigned long npages);
 
+/**
+ * drm_gpusvm_init_pages() - Initialize a freshly allocated drm_gpusvm_pages
+ * @svm_pages: Pointer to the drm_gpusvm_pages to initialize.
+ * @drm: The DRM device that will own DMA mappings for this pages object.
+ *
+ * Drivers that embed one or more drm_gpusvm_pages in their own range
+ * structure must call this once on each pages instance after allocation,
+ * before the first drm_gpusvm_get_pages() / unmap / free.
+ */
+static inline void drm_gpusvm_init_pages(struct drm_gpusvm_pages *svm_pages,
+					 struct drm_device *drm)
+{
+	memset(svm_pages, 0, sizeof(*svm_pages));
+	svm_pages->drm = drm;
+	svm_pages->notifier_seq = LONG_MAX;
+}
+
 /**
  * enum drm_gpusvm_scan_result - Scan result from the drm_gpusvm_scan_mm() function.
  * @DRM_GPUSVM_SCAN_UNPOPULATED: At least one page was not present or inaccessible.
-- 
2.34.1

