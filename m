Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1149C43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 10:22:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A36C10EC15;
	Tue, 30 Jun 2026 10:22:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kQKXV1Pf";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012062.outbound.protection.outlook.com
 [40.107.200.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B4B610EC1D;
 Tue, 30 Jun 2026 10:22:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=emTIcNWDWKZBeOcwUqW3KQkPMQ+hUeRDAsEe1VPaudcJHhZg4uxZmfyX4rbIHVKvZujgR9u4GTlskHtY4RRIRBUclPo+hX9RxdruEHkIUja0oBsefelg7JIll1EQswqTVLX3wjnSmni0i0UG7bftO/c8IoxTVnj1/jEwGuue2ZHkneHlIf7X9htJkc8G3NWyGEC6TlwcqKCfWS2psIqDJnQxiB9LVKYI7QcXcW08YP01VA9yoyBoIxDWj0ZCA0d8IAB+kyNeA5O1PPw946poX1tIPKJaXSvo9TXX05TJMiJHvZ/w+nlT94m99auIJIHPlSKgc1FLmfdaG+kGvS+jXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0co6Xr0kpUqtXe1K468I1+/MkdyslOv7kUBxOj96iKI=;
 b=JHzSLK7LsqQYb/MTM6qEZU4XNE4R1X1qWUpNF3eRLA4m17cjsI2lZlBg9DqUdouJVaT7/rL8pwiwolXmT8Ty4Kz1WtK0YkfgKNjFRABnF6dHC5axydGWrGkFWMXN2x73xpa3Wov6snV9bIXuzb7vBMD64LCmmhQvUi/XBrzWW0gU8PiGvFTfCn+FVXN9fRuD9jQAPpBmm4EORYR7cth9H2vKXwypAPFaJTXrcHqvy5+opwWHrbmwJIkk7BUSjKIKAIkm2PCQ6VjvaRZWEOkIeul15e7oAh8UfYWDNWnxH+3BSt6YilZOSqMpPa20oIXhmogroCFwKXthecvtAl0AYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0co6Xr0kpUqtXe1K468I1+/MkdyslOv7kUBxOj96iKI=;
 b=kQKXV1PfgaWjrVZTYr8YWSgKAywDH/BAhZG+SpBkeb87I+fpF5QFwZKhWTkvoCp5VsVt2WPRAzq/dQNXTdOZDRhEGSTzNlVsUWsA3cPXPOl67q/VEU0up7FiB/uA1RdjM7wBAZ6GhyXSNDkLXUtggIT+vx5x3EYh8IOEuZnryJc=
Received: from MN2PR22CA0021.namprd22.prod.outlook.com (2603:10b6:208:238::26)
 by DM4PR12MB6009.namprd12.prod.outlook.com (2603:10b6:8:69::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 10:21:57 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:208:238:cafe::83) by MN2PR22CA0021.outlook.office365.com
 (2603:10b6:208:238::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Tue,
 30 Jun 2026 10:21:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 30 Jun 2026 10:21:56 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 30 Jun
 2026 05:21:53 -0500
From: Honglei Huang <honghuan@amd.com>
To: <sima@ffwll.ch>, <matthew.brost@intel.com>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>,
 <intel-xe@lists.freedesktop.org>
CC: <aliceryhl@google.com>, <Alexander.Deucher@amd.com>,
 <Felix.Kuehling@amd.com>, <Christian.Koenig@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>, <Yiru.Ma@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <honghuan@amd.com>
Subject: [PATCH v10 3/5] drm/xe: have xe_svm_range embed one drm_gpusvm_pages
Date: Tue, 30 Jun 2026 18:21:25 +0800
Message-ID: <20260630102127.392396-4-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260630102127.392396-1-honghuan@amd.com>
References: <20260630102127.392396-1-honghuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|DM4PR12MB6009:EE_
X-MS-Office365-Filtering-Correlation-Id: 88a86b26-0edb-41d0-6d6a-08ded6916a00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|23010399003|6133799003|22082099003|5023799004|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: 0H2/+l3v+UbL+y45TAB2J4TX6NFeo3NiYR4TsgBnmak8tMwZY/l6xXlcxLBxkF/Mvm3agjFz3uUTdvS8L6nB2S1qSytFc+Mq3/zFunJdOP9mct4MNU2GcqwqYk4uolQyDlLtXs12qTN56taQfS01ssg8k4ujCae7ZR8YcWAjE9W7ct4QJMzBLWqZk47Y29KrdUJZrvbYwe/8E38Gkw1IyqA83i4erI+a9sfxf6IeKsXc1YeJJ1WxY9HYquo0TklNXU1ueVh99CJrc4/z6quSlzqSgvOUJtNuW7PXqMAbw3NSIlErkRytdIcaWzX3O8/grfXbWKF0LT1hE8EMDTW3qB5g56rbZk6lDas3HUu0TQbqoRjs8mCIdKJ1hU4rrJ2STFvI00MFomodEzU1q4Hx1AeqxhLwEQe7TZzR7L42C/iKpGHMAUAQPyndkD+B+xkgRspyMn/BxJ1IWyimp7xElOjiVLKODov5wIogri9006DE/Vz4KlF6EuUqFFaunIMVJvjgsNPcW17B0P1+p99h106VPq+MppKfMsmwe3RVpT5K7plFdC4UH0FOz9yWlCAZZsjGKHcWYPRD+kBjk99NI5R70cagDetrpDUBjBenl0BwDfE9D1Z+WUmFD3L+gcKBRMGo9bRTqu/HaIKV25OLqicY2chP9cDjwpMRNIxWPMMm3FydV83TPY+B4yBmsDXPXHLEduWslklVbmtItVZzcA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(23010399003)(6133799003)(22082099003)(5023799004)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SuujXfr9zxVBtc7q4evI3nrr6DWDbi3ufNUCUItEtpnV1N6okVhsgypdf0qckjR5ZPvxg7LKpcFY9yJ82CIFlbE/m4bArV2Y+VuPnVwkwkquFNbvAdrIvl+aTfhGWmUaPtq85CWkYHhVku4L7bAYv53R4uHNYXlCrWMQDLYE1J/Oe/M0x3//9x1oPdPEO1fRyXIgH7I4SPBEHyTqs743r2jKhwnIvu+6KeYYWuF84ZHco+fBavjo1dCqKAamOrY4KaSjlFJzTdad81qhW2DU9qFPrIOBpP47p0caUi1xxO1Sju9+GPVrQ4OoySQstnlqn8wnBYkG+M3MRc9j6n7ixHi2vtCKFgHDnlfySO9/DXb7oMxx847XevSz6EznJBYWjiCUn35y1ZvY0PQqaK33Z0RLzRXbr+EVBq3XAXwoPn39z5252rMZaoL767MxYJTW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 10:21:56.9769 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88a86b26-0edb-41d0-6d6a-08ded6916a00
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6009
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
 drivers/gpu/drm/drm_gpusvm.c    | 16 ++++++++-----
 drivers/gpu/drm/xe/xe_pt.c      |  2 +-
 drivers/gpu/drm/xe/xe_svm.c     | 42 ++++++++++++++++++++++++++-------
 drivers/gpu/drm/xe/xe_svm.h     | 12 ++++++----
 drivers/gpu/drm/xe/xe_userptr.c |  5 ++--
 include/drm/drm_gpusvm.h        | 20 ++++++++++++++++
 6 files changed, 74 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
index 604554e40f6..b0e9a2db108 100644
--- a/drivers/gpu/drm/drm_gpusvm.c
+++ b/drivers/gpu/drm/drm_gpusvm.c
@@ -1228,12 +1228,17 @@ EXPORT_SYMBOL_GPL(drm_gpusvm_free_pages);
  * This function removes the specified GPU SVM range and also removes the parent
  * GPU SVM notifier if no more ranges remain in the notifier. The caller must
  * hold a lock to protect range and notifier removal.
+ *
+ * This function does not unmap or free the drm_gpusvm_pages, the driver owns
+ * that lifecycle. The caller must DMA unmap the range's pages before calling
+ * this function, so a range is never removed from the MMU interval tree while
+ * still DMA mapped. Typically the driver calls drm_gpusvm_unmap_pages() first.
+ * And the range_free callback's drm_gpusvm_free_pages() is a final fallback safe
+ * net.
  */
 void drm_gpusvm_range_remove(struct drm_gpusvm *gpusvm,
 			     struct drm_gpusvm_range *range)
 {
-	unsigned long npages = npages_in_range(drm_gpusvm_range_start(range),
-					       drm_gpusvm_range_end(range));
 	struct drm_gpusvm_notifier *notifier;
 
 	drm_gpusvm_driver_lock_held(gpusvm);
@@ -1245,8 +1250,6 @@ void drm_gpusvm_range_remove(struct drm_gpusvm *gpusvm,
 		return;
 
 	drm_gpusvm_notifier_lock(gpusvm);
-	__drm_gpusvm_unmap_pages(gpusvm, &range->pages, npages);
-	__drm_gpusvm_free_pages(gpusvm, &range->pages);
 	__drm_gpusvm_range_remove(notifier, range);
 	drm_gpusvm_notifier_unlock(gpusvm);
 
@@ -1325,13 +1328,14 @@ EXPORT_SYMBOL_GPL(drm_gpusvm_range_put);
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
index 4f0f438d6b9..d6437492027 100644
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
index cbb549bc8c4..74545dc4169 100644
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
@@ -300,6 +304,7 @@ static void xe_svm_invalidate(struct drm_gpusvm *gpusvm,
 static int __xe_svm_garbage_collector(struct xe_vm *vm,
 				      struct xe_svm_range *range)
 {
+	struct drm_gpusvm_ctx ctx = { .in_notifier = false, };
 	struct dma_fence *fence;
 
 	range_debug(range, "GARBAGE COLLECTOR");
@@ -311,6 +316,10 @@ static int __xe_svm_garbage_collector(struct xe_vm *vm,
 		return PTR_ERR(fence);
 	dma_fence_put(fence);
 
+	drm_gpusvm_unmap_pages(&vm->svm.gpusvm, &range->pages,
+			       drm_gpusvm_range_size(&range->base) >> PAGE_SHIFT,
+			       &ctx);
+
 	drm_gpusvm_range_remove(&vm->svm.gpusvm, &range->base);
 
 	return 0;
@@ -945,15 +954,28 @@ void xe_svm_close(struct xe_vm *vm)
  */
 void xe_svm_fini(struct xe_vm *vm)
 {
+	struct drm_gpusvm_notifier *notifier, *next;
+	struct drm_gpusvm_ctx ctx = { .in_notifier = false, };
+
 	xe_assert(vm->xe, xe_vm_is_closed(vm));
 
+	drm_gpusvm_for_each_notifier_safe(notifier, next, &vm->svm.gpusvm, 0, LONG_MAX) {
+		struct drm_gpusvm_range *range, *__next;
+
+		drm_gpusvm_for_each_range_safe(range, __next, notifier, 0, LONG_MAX)
+			drm_gpusvm_unmap_pages(&vm->svm.gpusvm,
+					       &(to_xe_range(range)->pages),
+					       drm_gpusvm_range_size(range) >> PAGE_SHIFT,
+					       &ctx);
+	}
+
 	drm_gpusvm_fini(&vm->svm.gpusvm);
 }
 
 static bool xe_svm_range_has_pagemap_locked(const struct xe_svm_range *range,
 					    const struct drm_pagemap *dpagemap)
 {
-	return range->base.pages.dpagemap == dpagemap;
+	return range->pages.dpagemap == dpagemap;
 }
 
 static bool xe_svm_range_has_pagemap(struct xe_svm_range *range,
@@ -1018,7 +1040,7 @@ bool xe_svm_range_validate(struct xe_vm *vm,
 	if (dpagemap)
 		ret = ret && xe_svm_range_has_pagemap_locked(range, dpagemap);
 	else
-		ret = ret && !range->base.pages.dpagemap;
+		ret = ret && !range->pages.dpagemap;
 
 	xe_svm_notifier_unlock(vm);
 
@@ -1513,7 +1535,11 @@ int xe_svm_range_get_pages(struct xe_vm *vm, struct xe_svm_range *range,
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
index 3ca46a6f98c..c8f4a7ba0f4 100644
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
@@ -210,10 +212,10 @@ struct xe_vram_region;
 struct xe_svm_range {
 	struct {
 		struct interval_tree_node itree;
-		struct {
-			const struct drm_pagemap_addr *dma_addr;
-		} pages;
 	} base;
+	struct {
+		const struct drm_pagemap_addr *dma_addr;
+	} pages;
 	u32 tile_present;
 	u32 tile_invalidated;
 };
diff --git a/drivers/gpu/drm/xe/xe_userptr.c b/drivers/gpu/drm/xe/xe_userptr.c
index 9df98bcd3ca..35dac137e39 100644
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

