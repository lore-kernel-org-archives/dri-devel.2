Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 461A4F44843
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 11:32:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96F7B10E93D;
	Fri, 10 Apr 2026 11:32:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Mgws1bQy";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011035.outbound.protection.outlook.com [52.101.57.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36FE310E93D;
 Fri, 10 Apr 2026 11:32:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x4wpakqU7GEi2/Wj0PRG5cAINAbRVrc0oXZjRVNnptnECcyxfIK7mzIYY8rATETVyOL9hevX6E8avhzw181Pl50c9mLQkDvekvUSgtLl34WfE1DAxbG2Ort49iGIZDGdao9jGl0KG677orY+BwVy5y7Dbd4CsdaCYmWsGgRftEJi/R62qcD/cPeLdDUhR/F29i8OhmYHzb4OI+qxo8E+hyn6YnEKEfR1GHbmCN6B8tLmCV8s/P+hPT+IoMxgDAjngLdTcjkxRutp4Svb9oNCS7EEaBJoP+jZSsHhBMs4Vn63EKwlHMVQGgMgNula0bTLk41+hfEGKIy3Y8qj0LWV9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VakaeL4RgmyM9a244vMMy9g5XRrM8Lnk4EV5MMgmzRg=;
 b=LRBwHUYAMuM36pt9d/NqysK7iO1jsG+6ZSCWJoc+lb5EVSeFChEIOS7k3RWCk68E5rm16K5e7uh0iS462XiDzDpDFdZyRw3jnZ1lvvpTK5TNxXWvhE4/qznBD+j9HBG4ybxvM+QzXJBa37CIKEIrkZyoztOISckPudLeHP+lHxC8M7TmFvuP0E278j4/b3RVcPGc3FSAUEh2DTNhQM6fzITeW6hmvzN6ayf4t9n/DbQYDPhk2SMdtbgBywg5HaVZ7ZrpQ95ZhsvuCXCbYtPrMUNa6R3jbysJtMfd6j7q/PmoZF4X4uGKhQBThDWoht4vA6y4kDd/mwU9kXu+woQeeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VakaeL4RgmyM9a244vMMy9g5XRrM8Lnk4EV5MMgmzRg=;
 b=Mgws1bQyEdAgmYJhDeaJNnijEHiP6x5RjzNTlgCXh+TuvTgM7ccXeR0VrOdh9vEW4wxUMBK1AlZ7sLThx/vYh7DH9tp71vQ0YV1XpHDefU0X9PFtaA71GJZJF/0WNUOroTOe0fvjZAdMOtGjJHz+bRf+S5caZySXCz7u/QbfQYo=
Received: from PH7P220CA0085.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32c::26)
 by DS5PPFD22966BE3.namprd12.prod.outlook.com (2603:10b6:f:fc00::662)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Fri, 10 Apr
 2026 11:32:22 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:510:32c:cafe::95) by PH7P220CA0085.outlook.office365.com
 (2603:10b6:510:32c::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.42 via Frontend Transport; Fri,
 10 Apr 2026 11:32:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Fri, 10 Apr 2026 11:32:22 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 10 Apr
 2026 06:31:53 -0500
Received: from junhua-PC.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 10 Apr 2026 06:31:50 -0500
From: Junhua Shen <Junhua.Shen@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <honglei1.huang@amd.com>, <Lingshan.Zhu@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <junhshen@amd.com>, Junhua Shen <Junhua.Shen@amd.com>
Subject: [PATCH RFC 1/6] drm/amdgpu: introduce amdgpu_pagemap and kfd pgmap
 accessor
Date: Fri, 10 Apr 2026 19:31:41 +0800
Message-ID: <20260410113146.146212-2-Junhua.Shen@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260410113146.146212-1-Junhua.Shen@amd.com>
References: <20260410113146.146212-1-Junhua.Shen@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="y"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|DS5PPFD22966BE3:EE_
X-MS-Office365-Filtering-Correlation-Id: 538761b4-90c8-429f-020c-08de96f4d50c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: sYgFXoIG0q1Z8zXskZlHQCx+qg+ir51cBQpZLSC4SJ5eAbqF4zbjbIgZ+9SFi9i5wUi+csw6qMpOgDSYkqDs5KKMzOtfioe2CpBvMgASzKduiy4xKu+ID4qxpb3UbQMjCQblIvJqhYW7KCOzr1BY+s6xCHK9fLktYlsCxtSJzr2xZZhUowZTq9wEA1KOi6POYK3TLpExhNEknYEP6flndUBF1xQ//EA4SqHpLWpQVJT887176ihs6BRAHMN4A2xb+5dXaB5kiygGFwbxx6kJqFpRd+FlXT6+QKQRN8Xr2vtwAgrek1Z445W/Xq5KKlGXB5SxGMN5GmFE+Fev3uUSlgBdcxDDezpk4KZgBvGd7qrBwM0J+mXCaO+dIBdxLi+pJmLd/U3Y0MkHy8LLzi/EXwn+Jem8EIJ+5AZvWS4dMhSzbRcJVqaqZFV5yqU5Ji8QdRcc7dK4K+YtetK7t1NzBZHdy4QYtKOFiBrhHXs1npVvNaBzT2FtenLKxvj2pOS1Vck+GIfEQIJ2dDvqBSD4j1ngN1IgmMYEjl6WafCZPepyuCP4a/UPtn8ig9kH+eeZTxv357CBW9eZyjSENEZ+peOqdRM6GntGogysXNmEOIr07Lyxb5yms/3BMyZUQgbaAfper7UwEi6nedYYr+VH4QEvBLaxbAfWo6jiW+eL6KFCRCsgFVgX4fx86/g8pbvatoFRC3s+0w/nee5ORxyhmNQOYIu36QDboBCYS6vwgpTFIO8/z8e+cUjoWny9cY4xIuTUskAk5wQODqn7Boqh2R+jsq7Ta/vvZcytpVZVeJc29kve69/Rx56//hii47IZ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(921020)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Kitk27HDeOVlRsiwzDH1uY42LtaT43KhHNPicAMiCbybrjEwuPME9m0wPAK3EnvNvj2oqVKobxNUs0JSreONjyMZzL7tB9R+4D+Qq+FUf+7034q/w2NcCoMnsI6XJucx9J3JaeevwWMzHmTTwrl+hi/gLHNcZhtwoARwhuJkcW4Au/053SIjLF5oBlX5kFRbvgprx4s/rf0FDFIAbVEEZ9eYgsYLW+GNPT0X9F9vUWSbzfdY0kXyRLxPPLq9+OpLa7HF+cKe93PBdauJGFYBfI1nmfJxaG1T5HMUokbcyn9uAr3ghDfttr5PwX8mjV28fNiYjzV8z8Nf1JAL5CdaeulIurwf/2ur8lNokzaIfk7WEsCIXW8LfqS6jpBXblDg6sGZA27/rGxF08mySt18laIaKs8RkAIhTeAV2xPcZf8yCBVAOY19Mpjz+YgTe8qU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 11:32:22.2832 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 538761b4-90c8-429f-020c-08de96f4d50c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFD22966BE3
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

Wrap the bare dev_pagemap inside a new struct amdgpu_pagemap that
adds drm_pagemap state (dpagemap, adev back-pointer, hpa_base,
initialized flag) needed by the DRM GPUSVM migration path.

Signed-off-by: Junhua Shen <Junhua.Shen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h | 42 ++++++++++++++++++++--
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c   |  6 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c       |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h       |  2 +-
 4 files changed, 44 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index cdbab7f8cee8..844f622f55b0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -38,6 +38,8 @@
 #include "amdgpu_vm.h"
 #include "amdgpu_xcp.h"
 #include "kfd_topology.h"
+#include <drm/drm_pagemap.h>
+
 extern uint64_t amdgpu_amdkfd_total_mem_size;
 
 enum TLB_FLUSH_TYPE {
@@ -101,6 +103,29 @@ struct amdgpu_amdkfd_fence {
 	uint16_t context_id;
 };
 
+/**
+ * struct amdgpu_pagemap - VRAM migration infrastructure for drm_pagemap
+ *
+ * Wraps struct dev_pagemap with the additional drm_pagemap state needed
+ * by the DRM GPUSVM migration path. Used in place of bare
+ * dev_pagemap when CONFIG_DRM_AMDGPU_SVM is enabled.
+ *
+ * @dpagemap: drm_pagemap wrapper providing device_map / populate_mm callbacks
+ * @adev: back-pointer to the owning amdgpu_device for fast lookup from
+ *        ZONE_DEVICE pages (avoids traversing dpagemap->drm->drm_to_adev)
+ * @hpa_base: HPA base of the ZONE_DEVICE region (== pgmap.range.start)
+ * @initialized: true after successful devm_memremap_pages + dpagemap init
+ * @pgmap: ZONE_DEVICE registration — must be last, contains flexible-array member
+ */
+struct amdgpu_pagemap {
+	struct drm_pagemap dpagemap;
+	struct amdgpu_device *adev;
+	resource_size_t hpa_base;
+	bool initialized;
+	/* Must be last -- struct dev_pagemap ends in a flexible-array member */
+	struct dev_pagemap pgmap;
+};
+
 struct amdgpu_kfd_dev {
 	struct kfd_dev *dev;
 	int64_t vram_used[MAX_XCP];
@@ -111,12 +136,23 @@ struct amdgpu_kfd_dev {
 	/* Client for KFD BO GEM handle allocations */
 	struct drm_client_dev client;
 
-	/* HMM page migration MEMORY_DEVICE_PRIVATE mapping
-	 * Must be last --ends in a flexible-array member.
-	 */
+	/* HMM page migration MEMORY_DEVICE_PRIVATE mapping. */
+#if IS_ENABLED(CONFIG_DRM_AMDGPU_SVM)
+	struct amdgpu_pagemap apagemap;
+#else
 	struct dev_pagemap pgmap;
+#endif
 };
 
+/**
+ * amdgpu_kfd_pgmap - Get the dev_pagemap for HMM page migration
+ */
+#if IS_ENABLED(CONFIG_DRM_AMDGPU_SVM)
+#define amdgpu_kfd_pgmap(adev)	(&(adev)->kfd.apagemap.pgmap)
+#else
+#define amdgpu_kfd_pgmap(adev)	(&(adev)->kfd.pgmap)
+#endif
+
 enum kgd_engine_type {
 	KGD_ENGINE_PFP = 1,
 	KGD_ENGINE_ME,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 10bc81ce37cb..289683cabd79 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -212,7 +212,7 @@ svm_migrate_copy_done(struct amdgpu_device *adev, struct dma_fence *mfence)
 unsigned long
 svm_migrate_addr_to_pfn(struct amdgpu_device *adev, unsigned long addr)
 {
-	return (addr + adev->kfd.pgmap.range.start) >> PAGE_SHIFT;
+	return (addr + amdgpu_kfd_pgmap(adev)->range.start) >> PAGE_SHIFT;
 }
 
 static void
@@ -242,7 +242,7 @@ svm_migrate_addr(struct amdgpu_device *adev, struct page *page)
 	unsigned long addr;
 
 	addr = page_to_pfn(page) << PAGE_SHIFT;
-	return (addr - adev->kfd.pgmap.range.start);
+	return (addr - amdgpu_kfd_pgmap(adev)->range.start);
 }
 
 static struct page *
@@ -1037,7 +1037,7 @@ int kgd2kfd_init_zone_device(struct amdgpu_device *adev)
 	if (adev->apu_prefer_gtt)
 		return 0;
 
-	pgmap = &kfddev->pgmap;
+	pgmap = amdgpu_kfd_pgmap(adev);
 	memset(pgmap, 0, sizeof(*pgmap));
 
 	/* TODO: register all vram to HMM for now.
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 9b4143328371..4c11ed4e8ea3 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -185,7 +185,7 @@ svm_range_dma_map_dev(struct amdgpu_device *adev, struct svm_range *prange,
 
 			addr[i] = (hmm_pfns[i] << PAGE_SHIFT) +
 				   bo_adev->vm_manager.vram_base_offset -
-				   bo_adev->kfd.pgmap.range.start;
+				   amdgpu_kfd_pgmap(bo_adev)->range.start;
 			addr[i] |= SVM_RANGE_VRAM_DOMAIN;
 			pr_debug_ratelimited("vram address: 0x%llx\n", addr[i]);
 			continue;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index a63dfc95b602..8059169c7e0d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -200,7 +200,7 @@ void svm_range_list_lock_and_flush_work(struct svm_range_list *svms, struct mm_s
 /* SVM API and HMM page migration work together, device memory type
  * is initialized to not 0 when page migration register device memory.
  */
-#define KFD_IS_SVM_API_SUPPORTED(adev) ((adev)->kfd.pgmap.type != 0 ||\
+#define KFD_IS_SVM_API_SUPPORTED(adev) (amdgpu_kfd_pgmap(adev)->type != 0 ||\
 					((adev)->apu_prefer_gtt))
 
 void svm_range_bo_unref_async(struct svm_range_bo *svm_bo);
-- 
2.34.1

