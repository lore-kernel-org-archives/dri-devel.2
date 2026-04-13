Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26E5AEBFD30
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 10:30:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7984F10E3F3;
	Mon, 13 Apr 2026 10:30:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZHaGDlgC";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013052.outbound.protection.outlook.com
 [40.93.196.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7480510E3F3;
 Mon, 13 Apr 2026 10:30:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N6ognKr8YTKm3FgbF/O7RjCpLwTutnNvbqmOJEPFsznAla3B0DVRgvVEGVX0it5hUXWRN90ivVVzERJY4g6Qx2q8qVNnxDnkRhxY2GbGRjx1dgWwjU0mWnOYOETmAtR/GK9GZcOyQQBYIqkSaQTj+tXpX9gk4lGOhf8VZVuiWNZhYEJXbgYmU2v/5S0KTavMdKaLYxnIYdL1//nnyUyGjNkV6a50emunc6UcEeMBDqqqpOm5QeGt4MuuawBH7ARzPtChY99P6znOL7cTuOzPGuk5fox6OjpMx7ptLsixugeRwncxmxLJIZ6lt5ETKDl6vawO5u6/kSZA0V5tZO8Qcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VakaeL4RgmyM9a244vMMy9g5XRrM8Lnk4EV5MMgmzRg=;
 b=EeBAi7Ol+AWDkBu/ulV3U1gg2GuhiFWClE9HVe8DfIdchnIGpUQ027R8Dtym4LMRhFY0nz1Uj4ycOGjyXMMVkiRMUrAjyJ4mud2Ggd09HxGfectGwgPn7AdzbWIviKiwZwsRF52smSbxbts/3IicG+LXimNPdWVICDm/uTXzhJJDccj3ErRwERsgbINnTJwHgQETJ08xsyTkXIuOZtOi8HU70LRQJAQvMCF7tu6A6lqSlSr/zT0ocGk0LjqKp+A2tsv0x6TVXFg3F0EbXO5UNCMzRzgs+qQcAK+ivbvcGd8FJe4lDbUEgFnboVyLz7K7z+7vCsnTyM6AlPUHt4JbXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VakaeL4RgmyM9a244vMMy9g5XRrM8Lnk4EV5MMgmzRg=;
 b=ZHaGDlgC78cGCVZhoFGYr52uj0cnnfk1qBPc/16Oy+8HaBip6LVaesV8zZKNvjFYdrP4J+QceG/Tg1vAM7j4/J7mr/O9/OhjY9Eu1XtKhkMJCgJT9+KpCRRmqWJuLBMWsV0s8PoJZYvjqqjJhHnBfUBDiYgZdut1/CKuL91eZxA=
Received: from BYAPR06CA0015.namprd06.prod.outlook.com (2603:10b6:a03:d4::28)
 by LV2PR12MB999095.namprd12.prod.outlook.com (2603:10b6:408:353::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Mon, 13 Apr
 2026 10:30:40 +0000
Received: from SJ5PEPF00000207.namprd05.prod.outlook.com
 (2603:10b6:a03:d4:cafe::bb) by BYAPR06CA0015.outlook.office365.com
 (2603:10b6:a03:d4::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Mon,
 13 Apr 2026 10:30:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF00000207.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Mon, 13 Apr 2026 10:30:39 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 13 Apr
 2026 05:30:39 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 13 Apr
 2026 05:30:38 -0500
Received: from junhua-PC.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 13 Apr 2026 05:30:35 -0500
From: Junhua Shen <Junhua.Shen@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <honglei1.huang@amd.com>, <Lingshan.Zhu@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <junhshen@amd.com>, Junhua Shen <Junhua.Shen@amd.com>
Subject: [PATCH v2 1/5] drm/amdgpu: introduce amdgpu_pagemap and kfd pgmap
 accessor
Date: Mon, 13 Apr 2026 18:30:27 +0800
Message-ID: <20260413103031.181953-2-Junhua.Shen@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260413103031.181953-1-Junhua.Shen@amd.com>
References: <20260413103031.181953-1-Junhua.Shen@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB04.amd.com: Junhua.Shen@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000207:EE_|LV2PR12MB999095:EE_
X-MS-Office365-Filtering-Correlation-Id: 27665d03-b090-49b1-e7cf-08de9947b569
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: TiydwQq4fUXq/4hY7/9XAYYOAYGPn31HeFhrnKVQwQkqye3qQ1dHdb/GWZ3KtGnyRRGgYGR3jxYfD08/BxNHS47OLqfAYrAIUovQD2kS81aMm5JMwm3/Qd64isObpujFWWQn1Wg916wmeMBy34Sn0AOHNyx3O1+/QgkRD3uw+D7W4uScQPskU7RssH/mUh8eU7eBKmDFGi4DOVCJq5JMCdsQkoR+G6nasXIKkXr4DXN7H67EfRoovm04yuyssioFMa+cA9H5+Jcj3sSlgy51M5EtrqWZrDlGEnmslBdwCB7rbecHvY1XQbpPuF4y2xUaHjQEv1+7PUHU1Zr09ilA3sXUJ0Zo7dmBCJymcL9XcLbF352CrwmxijkuM6/HWIEUxVd5/lFmhi7dUvnrrs66IUa83fUbgmEK77/ZshkWkOF6+Y0Uf7T/LZqKiUSXGbce71mnYOkjYTyoBNXHIpPPlMofqS8qiwQSjVG/vdKm3GDcVL/0IWsRHNxy+XbkMJLgZCjIad+kpuJKH5nKbOrR9VkT5ArozyfM8N25IcQblasuWXm6JzUPgbTDUFSgMDDKKVDxOMOFwF1mzvYbloYdiTCT9StiUNLRtt3b+Om2T6JzCCsYpcMTN3Oc92VBjb6W+XlQCaI9N8ljZPBunGM+r4+G4firM2hMO90aRc12BoOEwy3ZA5sgShbZID+jCPdH71GntFzpHkHWNJ/OhgPqkzTuEapinBXjOUbDFJ7cgCOXVd+ClFHL02lRBY07WSvvbojCYEOvmQknQF6Ck1uImajBzAXneICjPO1IFDNjE04Zfb43t6dFfjl4m1tvOhQb
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(921020)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4DKcxNWYKlcMCjfxeTKCjRNdJpCVGNgowCWZ8PvVBAF4tbm5iltARK/teDQwlZkRiZ1qMVPoFHuJdPfm6x5FtvzQW3GCezvm8IkTx4b8OviFhqFeTkG7X62facJGtLFMWvK9P1Rg4HS6h5N6482NNfTVp4/B9b4ChXlwCWBud+lYKTMUTMXEe4mrmPwCXAc9zlo6l0RnZgS+a1RZ3lU93LTm146+ZIdCPklke32LVVbDokVWuCHBYfAEhlfEQ02ztjG+SrsWcpd7dg6VAB1oyAVJyjb7Ed59ERaL84XWvUrU6koN5N3rz/URe/U7N9+/98JTiMuTH01jOPDu3LzK8OMLi+g8/lYuiMZSk5FXS9Hj3V26GJRvqfEsP/X4DN/wSNMEwKlpSVSknQf8DX2Cmc/2xE/DUFUTI/LihpXK87lw+mYYRVVyPlkxnPpxd0J1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 10:30:39.7190 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27665d03-b090-49b1-e7cf-08de9947b569
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000207.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB999095
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

