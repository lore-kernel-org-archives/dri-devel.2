Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B441EFF8861
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 10:06:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 220A110E68B;
	Mon, 27 Apr 2026 10:06:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bedmVvoK";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010015.outbound.protection.outlook.com [52.101.201.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92E9810E689;
 Mon, 27 Apr 2026 10:06:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NqltcTqg3LZQZf5dO96IVWALxXw2EddXKnaAJVlCzodK92oCqqIaU45B0EFgS9zW467oYcPm68CSx4Ha4ctZVHF1sfNNvzR9JAVQ1BfzOAIyaWTz+x6UpKfl5y8J9tWMbbTqyem/tmpCl0q7MH3DnLnhCCeXwBA2JxpMDXSSvKZojblG0Vd4K6/8p/EKgGS5MimG+L4MRTkdGTQbgteYaRfAgs7j9B9fK/MHubqrAxa6F3IT041+Hl4g1dnZt9tclACwzmtzxKoWu+xvjbs5Slb95BVQ9xIOrjJm1CwVIPz5yAWK2LWbbwdbsEBTLbhz4dudrvGBDefdpNddRWGy/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mX2aAu/khPxkKL3q4Yap6tTW4W4SJuOQB0ggMZFXCi4=;
 b=YJ4OMrHx2OQkiAK0D3s8CeMiG19cEsAL+tepD56pdVMO8Y7O1l1mRfdKSm7aerz0Z1aKvDiy7SpHdzxKHNzvBpgK1NJV56O9+VOpL3sz4z/RiQ+q/YdQPcuGmhx7M8cXvAiRRVnTdW0mugCqdSBqMDpYKS6M/s+HRDqEEaAVMJVOM+Tzxwv4Daqfu2UQd3XMNRRWIjs2MvdMRdZVjzXuR2ramMRml0OvBARcOKJ5ny3lGg19aHiXzVBbMXtYZOHlvFwdvFnJaa2e+FHfXFR5QlsQPHy4oZC1nqGUfAmFIPgtzxCveb/QuTY5qn8NrF4RQ/tGtJBKSLecjBMGlz0OFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mX2aAu/khPxkKL3q4Yap6tTW4W4SJuOQB0ggMZFXCi4=;
 b=bedmVvoKwxCASjTo3x/YF11Wm+WXyuTgHSwnJSYgTK9pgnYvH2h0mNKBRonN3UvmAYzcWecMQXx3CkLd5zHBWmxpBSXvGP1Lj0e45ubUdYR2dhYpIqQQyT5Vnraio+zkyIUnzzUpUV2DWqUYtD8iUmXWAYv3q0k1uTWK3eVImRk=
Received: from SJ0PR03CA0338.namprd03.prod.outlook.com (2603:10b6:a03:39c::13)
 by MN2PR12MB4357.namprd12.prod.outlook.com (2603:10b6:208:262::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Mon, 27 Apr
 2026 10:05:54 +0000
Received: from MW1PEPF00016160.namprd21.prod.outlook.com
 (2603:10b6:a03:39c:cafe::d9) by SJ0PR03CA0338.outlook.office365.com
 (2603:10b6:a03:39c::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Mon,
 27 Apr 2026 10:05:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MW1PEPF00016160.mail.protection.outlook.com (10.167.249.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.0 via Frontend Transport; Mon, 27 Apr 2026 10:05:53 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 27 Apr
 2026 05:05:47 -0500
Received: from junhua-PC.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 27 Apr 2026 05:05:44 -0500
From: Junhua Shen <Junhua.Shen@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <honglei1.huang@amd.com>, <Lingshan.Zhu@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 "Junhua Shen" <Junhua.Shen@amd.com>
Subject: [PATCH v3 5/5] drm/amdgpu: integrate VRAM migration into SVM range
 map path
Date: Mon, 27 Apr 2026 18:05:22 +0800
Message-ID: <20260427100522.7014-6-Junhua.Shen@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260427100522.7014-1-Junhua.Shen@amd.com>
References: <20260427100522.7014-1-Junhua.Shen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF00016160:EE_|MN2PR12MB4357:EE_
X-MS-Office365-Filtering-Correlation-Id: 7997a760-c126-469f-325d-08dea4449156
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|921020|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 9c/P0e60kqwOJSd9M80vGV0PCSvLpSpWxD1M+r1rCZxeB07/1QgUWAHtOIU6c7v93h9BtXtoJA9GGnKwM4qdyCfASSP619OyyYTdTyAD4KuZyCJdndcyRAQ7RFKDuihKtTm++MNUgUmpWp1vAUDFXy+NEsbcNrSdF7QkFnYAzfUJcn+I8a9SSpMQ9Nt7Y7MxUZL/wTqVORc0ET3IxkbgH419mB5wzbVYWlyfwjNjOel6jNAbccy/c75jQLCj7pugLn0qyX4aLCvjV4aPBMwi5q8yLvs2N6icuNzErbAnCz3bymbH2He0vUSqtE/fBPLz5LCT+7ElykmiSQI8DEsHpGxV0JhUkdpdGbRLwgT/ChElSQS7ZR2xC232R+jjl4TrmZAqKUuwmoJbNJInMPnAYSl6xBF/BLh8mYw9blWqtY+Ihw80ol2a2rXkcgg6nHQZPu7/tRCHI6USEJKEvMOSNDxnHIsCALWpxD39K5WatIEXLHy+/UKIqPufuSF4dBA6OELApQyEAPomO2oQVsJcS0t5yNPAb6ZYYYQpNC/Qtr0oYWmXtXzmgSnJ06VJsR3CllK4FuPZlzrkjTjyjFTR51g0uYzreV6r5LuXceYEOsdv4QUv/sxjcXN2ogXPrVKLSpQn8MaTpZpR7Eu1U7+JN6kQLhtoDIx5V3DM37DGWnpm76ouRfKM8/5gocb9MPEEWrI62TCbHwVDBhibIU3b/4sLQMJDKDz4cJmhrxBLALQR+wg4dugo9Cfr3afvYVN4CfrxULfDYAyRhx+qYg0o/UzU1QdIbQKS7gfrQX4mX6YmE9rf4jaE8+HxvY17bJ8i
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(921020)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6xmZ9auwPt3Q6IqbtgJYuMB/bsXTyDdyVYPWSGaeb20W4uKvp3wlHE1RcOdlSpp8jnmOyyypdJ7yuCNqLMAaUvUDhDxh7ELmT6FpPkRyKaNyO7ZOjQtJp5ZLz1Pc9rXHh3VkPDy2CDRps+tFWqNf45FQHdmGP9egDbqzXlOweGc2dV8lY/zqzq85KeuTAI3DBxsXc6XVNlWwzit8X93eQNMLpG68bCYgTNRsbtjM4b3Wk8+fx12QwZ8lgaShjqAxuGFBza4q88zDHHVHWrcH8uUqQsUbI8x+4miYbN3AKJkBD/O21pgHHzSDgh+MkYVuLb+kJI0TBnv3KUMFb1ocjjydCrtkhG7S8cPQKplus5PKWC3ZuUm69IolsrnASgkc+gfUpKDh5D+wwDX3Pcy31EitljyA0MST9W/W7a6qhBQi9TXkVhAdcRGf+JUceTOr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 10:05:53.4955 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7997a760-c126-469f-325d-08dea4449156
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW1PEPF00016160.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4357
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

hook up ZONE_DEVICE registration in device init and reset.

Wire the migration decision layer into the SVM range map call chain:

- Add migrate_mode parameter to amdgpu_svm_range_map_attr_ranges()
  and propagate it through map_interval -> per-range map loop
- Call amdgpu_svm_range_migrate_range() on each drm_gpusvm_range
  before GPU mapping to perform VRAM migration or eviction
- Pass appropriate migrate_mode from SVM attr prefetch triggers
  and the restore worker

Signed-off-by: Junhua Shen <Junhua.Shen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |   4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c     |   4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c       |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c | 136 +++++++++---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h |   5 +-
 5 files changed, 87 insertions(+), 66 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index fbe553c38583..3be51a2c0106 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -78,6 +78,7 @@
 #include "amdgpu_reset.h"
 #include "amdgpu_virt.h"
 #include "amdgpu_dev_coredump.h"
+#include "amdgpu_migrate.h"
 
 #include <linux/suspend.h>
 #include <drm/task_barrier.h>
@@ -4076,6 +4077,9 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 
 	/* Don't init kfd if whole hive need to be reset during init */
 	if (adev->init_lvl->level != AMDGPU_INIT_LEVEL_MINIMAL_XGMI) {
+#if IS_ENABLED(CONFIG_DRM_AMDGPU_SVM)
+		amdgpu_svm_migration_init(adev);
+#endif
 		kgd2kfd_init_zone_device(adev);
 		kfd_update_svm_support_properties(adev);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
index 28c4ad62f50e..c94d43f3ab42 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
@@ -25,6 +25,7 @@
 #include "aldebaran.h"
 #include "sienna_cichlid.h"
 #include "smu_v13_0_10.h"
+#include "amdgpu_migrate.h"
 
 static int amdgpu_reset_xgmi_reset_on_init_suspend(struct amdgpu_device *adev)
 {
@@ -87,6 +88,9 @@ static int amdgpu_reset_xgmi_reset_on_init_restore_hwctxt(
 		return r;
 	list_for_each_entry(tmp_adev, reset_device_list, reset_list) {
 		if (!tmp_adev->kfd.init_complete) {
+#if IS_ENABLED(CONFIG_DRM_AMDGPU_SVM)
+			amdgpu_svm_migration_init(tmp_adev);
+#endif
 			kgd2kfd_init_zone_device(tmp_adev);
 			amdgpu_amdkfd_device_init(tmp_adev);
 			amdgpu_amdkfd_drm_client_create(tmp_adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c
index 57103a140164..cd8dbe56a9e9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c
@@ -32,6 +32,7 @@
 #include "amdgpu_svm.h"
 #include "amdgpu_svm_attr.h"
 #include "amdgpu_svm_range.h"
+#include "amdgpu_svm_range_migrate.h"
 #include "amdgpu_vm.h"
 
 #if IS_ENABLED(CONFIG_DRM_AMDGPU_SVM)
@@ -341,7 +342,8 @@ int amdgpu_svm_handle_fault(struct amdgpu_device *adev, uint32_t pasid,
 	AMDGPU_SVM_TRACE("handle_fault: map_attr page=0x%lx\n", fault_page);
 
 	down_write(&svm->svm_lock);
-	ret = amdgpu_svm_range_map_attr_ranges(svm, fault_page, fault_page);
+	ret = amdgpu_svm_range_map_attr_ranges(svm, fault_page, fault_page,
+					       AMDGPU_SVM_MIGRATE_PREFERRED);
 	up_write(&svm->svm_lock);
 
 	if (ret)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
index 472a641fb836..8880e2ba79cc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
@@ -25,6 +25,7 @@
 #include "amdgpu_svm.h"
 #include "amdgpu_svm_attr.h"
 #include "amdgpu_svm_range.h"
+#include "amdgpu_migrate.h"
 #include "amdgpu.h"
 #include "amdgpu_amdkfd.h"
 #include "amdgpu_vm.h"
@@ -114,7 +115,6 @@ range_pages_valid(struct amdgpu_svm *svm,
 	return drm_gpusvm_range_pages_valid(&svm->gpusvm, range);
 }
 
-
 static int
 amdgpu_svm_range_gpu_unmap_in_notifier(struct amdgpu_svm *svm,
 				      struct drm_gpusvm_range *range,
@@ -247,11 +247,11 @@ amdgpu_svm_range_attr_pte_flags(struct amdgpu_svm *svm,
 	return pte_flags;
 }
 
-	/*
-	* POC/WA: reuse kfd apis for queue quiesce/resume
-	* But kfd apis are for process level, not for GPU VM level
-	* need consider potential issues
-	*/
+/*
+ * POC/WA: reuse kfd apis for queue quiesce/resume
+ * But kfd apis are for process level, not for GPU VM level
+ * need consider potential issues
+ */
 void amdgpu_svm_range_restore_begin_compute(struct amdgpu_svm *svm)
 {
 	int ret;
@@ -317,39 +317,6 @@ static int amdgpu_svm_range_lock_vm_pd(struct amdgpu_svm *svm, struct drm_exec *
 	return 0;
 }
 
-static int
-amdgpu_svm_range_update_gpu(struct amdgpu_svm *svm, unsigned long start_page,
-			   unsigned long last_page, uint64_t pte_flags,
-			   dma_addr_t *pages_addr, bool flush_tlb,
-			   bool update_pdes, bool wait_fence)
-{
-	struct drm_exec exec;
-	struct dma_fence *fence = NULL;
-	int ret;
-
-	ret = amdgpu_svm_range_lock_vm_pd(svm, &exec);
-	if (ret)
-		return ret;
-
-	ret = amdgpu_vm_update_range(svm->adev, svm->vm, false, false,
-				     flush_tlb, true,
-				     NULL, start_page, last_page, pte_flags, 0, 0,
-				     NULL, pages_addr, wait_fence ? &fence : NULL);
-	if (!ret && wait_fence && fence) {
-		ret = dma_fence_wait(fence, false);
-		if (ret < 0)
-			AMDGPU_SVM_TRACE("wait unmap fence failed: ret=%d [0x%lx-0x%lx]-0x%lx\n",
-					 ret, start_page, last_page,
-					 last_page - start_page + 1);
-	}
-	if (!ret && update_pdes)
-		ret = amdgpu_vm_update_pdes(svm->adev, svm->vm, false);
-
-	dma_fence_put(fence);
-	drm_exec_fini(&exec);
-	return ret;
-}
-
 static int
 amdgpu_svm_range_update_gpu_range(struct amdgpu_svm *svm,
 				  struct drm_gpusvm_range *range,
@@ -376,9 +343,11 @@ amdgpu_svm_range_update_gpu_range(struct amdgpu_svm *svm,
 						npages - mapped_pages);
 		dma_addr_t seg_addr = entry->addr;
 		unsigned long start_page, last_page;
+		uint64_t seg_pte_flags = pte_flags;
 		bool is_last_seg;
 
-		if (entry->proto != DRM_INTERCONNECT_SYSTEM)
+		if (entry->proto != DRM_INTERCONNECT_SYSTEM &&
+		    entry->proto != AMDGPU_INTERCONNECT_VRAM)
 			return -EOPNOTSUPP;
 
 		while (mapped_pages + seg_pages < npages) {
@@ -399,9 +368,13 @@ amdgpu_svm_range_update_gpu_range(struct amdgpu_svm *svm,
 		last_page = start_page + seg_pages - 1;
 		is_last_seg = mapped_pages + seg_pages == npages;
 
+		/* For VRAM pages, Clear the SYSTEM and SNOOPED bits */
+		if (entry->proto == AMDGPU_INTERCONNECT_VRAM)
+			seg_pte_flags &= ~(AMDGPU_PTE_SYSTEM | AMDGPU_PTE_SNOOPED);
+
 		ret = amdgpu_vm_update_range(svm->adev, svm->vm, false, false,
 					     flush_tlb && is_last_seg, true, NULL,
-					     start_page, last_page, pte_flags,
+					     start_page, last_page, seg_pte_flags,
 					     0, seg_addr, NULL, NULL,
 					     wait_fence && is_last_seg ? fence : NULL);
 		if (ret)
@@ -413,17 +386,35 @@ amdgpu_svm_range_update_gpu_range(struct amdgpu_svm *svm,
 	return 0;
 }
 
+static bool
+preferred_loc_is_vram(const struct amdgpu_svm_attrs *attrs)
+{
+	return attrs->preferred_loc != AMDGPU_SVM_LOCATION_SYSMEM &&
+	       attrs->preferred_loc != AMDGPU_SVM_LOCATION_UNDEFINED;
+}
+
 static int
 amdgpu_svm_range_map(struct amdgpu_svm *svm,
 		       unsigned long start,
 		       unsigned long end,
 		       const struct amdgpu_svm_attrs *attrs,
 		       const struct drm_gpusvm_ctx *gpusvm_ctx,
-		       uint64_t pte_flags)
+		       uint64_t pte_flags,
+		       enum amdgpu_svm_migrate_mode migrate_mode)
 {
 	unsigned long addr = start;
 	int ret;
 
+	/*
+	 * For preferred migration mode, determine the
+	 * actual migration direction based on the preferred
+	 * location attribute.
+	 */
+	if (migrate_mode == AMDGPU_SVM_MIGRATE_PREFERRED)
+		migrate_mode = preferred_loc_is_vram(attrs) ?
+				       AMDGPU_SVM_MIGRATE_TO_VRAM :
+				       AMDGPU_SVM_MIGRATE_TO_SYSMEM;
+
 	while (addr < end) {
 		struct drm_exec exec;
 		struct drm_gpusvm_ctx map_ctx;
@@ -462,6 +453,10 @@ amdgpu_svm_range_map(struct amdgpu_svm *svm,
 		if (next_addr <= addr)
 			return -EINVAL;
 
+		/* Per-range migration */
+		if (migrate_mode != AMDGPU_SVM_MIGRATE_NONE)
+			amdgpu_svm_range_migrate_range(svm, range, migrate_mode);
+
 		range_pte_flags = map_ctx.read_only ?
 			(pte_flags & ~AMDGPU_PTE_WRITEABLE) : pte_flags;
 
@@ -529,10 +524,16 @@ amdgpu_svm_range_map(struct amdgpu_svm *svm,
 static int
 amdgpu_svm_range_map_interval(struct amdgpu_svm *svm, unsigned long start_page,
 				unsigned long last_page,
-				const struct amdgpu_svm_attrs *attrs)
+				const struct amdgpu_svm_attrs *attrs,
+				enum amdgpu_svm_migrate_mode migrate_mode)
 {
+	bool hw_devmem = amdgpu_pagemap_capable(svm);
+
 	struct drm_gpusvm_ctx gpusvm_ctx = {
 		.read_only = !!(attrs->flags & AMDGPU_SVM_FLAG_GPU_RO),
+		.devmem_possible = hw_devmem,
+		.device_private_page_owner = hw_devmem ?
+			AMDGPU_SVM_PGMAP_OWNER(svm->adev) : NULL,
 	};
 	unsigned long start = start_page << PAGE_SHIFT;
 	unsigned long end = (last_page + 1) << PAGE_SHIFT;
@@ -542,7 +543,7 @@ amdgpu_svm_range_map_interval(struct amdgpu_svm *svm, unsigned long start_page,
 	pte_flags = amdgpu_svm_range_attr_pte_flags(svm, attrs);
 
 	ret = amdgpu_svm_range_map(svm, start, end, attrs, &gpusvm_ctx,
-				   pte_flags);
+				   pte_flags, migrate_mode);
 	if (ret)
 		AMDGPU_SVM_TRACE("map_interval failed: ret=%d [0x%lx-0x%lx)-0x%lx\n",
 				 ret, start, end, end - start);
@@ -553,7 +554,8 @@ amdgpu_svm_range_map_interval(struct amdgpu_svm *svm, unsigned long start_page,
 int
 amdgpu_svm_range_map_attr_ranges(struct amdgpu_svm *svm,
 				 unsigned long start_page,
-				 unsigned long last_page)
+				 unsigned long last_page,
+				 enum amdgpu_svm_migrate_mode migrate_mode)
 {
 	lockdep_assert_held_write(&svm->svm_lock);
 
@@ -573,9 +575,10 @@ amdgpu_svm_range_map_attr_ranges(struct amdgpu_svm *svm,
 
 		seg_last = min(seg_last, last_page);
 		if (range_has_access(attrs.access)) {
-			/* map may fail here cause no vma or access deny */
-			ret = amdgpu_svm_range_map_interval(svm, cursor, seg_last,
-							    &attrs);
+			ret = amdgpu_svm_range_map_interval(svm, cursor,
+							    seg_last,
+							    &attrs,
+							    migrate_mode);
 			if (ret)
 				return ret;
 		}
@@ -657,7 +660,6 @@ static int amdgpu_svm_range_rebuild_locked(struct amdgpu_svm *svm,
 	unsigned long rebuild_start = start_page;
 	unsigned long rebuild_last = last_page;
 	bool removed;
-	int ret;
 
 	lockdep_assert_held_write(&svm->svm_lock);
 
@@ -673,14 +675,10 @@ static int amdgpu_svm_range_rebuild_locked(struct amdgpu_svm *svm,
 	/* scan rebuild start end to build the extra removed ranges */
 	if (rebuild)
 		return amdgpu_svm_range_map_attr_ranges(svm, rebuild_start,
-							rebuild_last);
+							rebuild_last,
+							AMDGPU_SVM_MIGRATE_PREFERRED);
 
-	ret = amdgpu_svm_range_update_gpu(svm, rebuild_start, rebuild_last,
-					  0, NULL, true, true, true);
-	if (!ret)
-		svm->flush_tlb(svm);
-
-	return ret;
+	return 0;
 }
 
 static void
@@ -706,10 +704,11 @@ amdgpu_svm_range_process_notifier_ranges(struct amdgpu_svm *svm,
 		if (clear_pte) {
 			amdgpu_svm_range_gpu_unmap_in_notifier(svm, range,
 									   mmu_range);
-			range_invalidate_gpu_mapping(range);
 		}
 
 		drm_gpusvm_range_unmap_pages(&svm->gpusvm, range, &ctx);
+		range_invalidate_gpu_mapping(range);
+
 		if (is_unmap)
 			drm_gpusvm_range_set_unmapped(range, mmu_range);
 
@@ -758,6 +757,7 @@ int amdgpu_svm_range_apply_attr_change(struct amdgpu_svm *svm,
 {
 	lockdep_assert_held_write(&svm->svm_lock);
 
+	enum amdgpu_svm_migrate_mode migrate_mode = AMDGPU_SVM_MIGRATE_NONE;
 	bool old_access, new_access;
 	bool update_mapping = false;
 
@@ -788,16 +788,24 @@ int amdgpu_svm_range_apply_attr_change(struct amdgpu_svm *svm,
 	    new_access)
 		update_mapping = true;
 
-	if (trigger & AMDGPU_SVM_ATTR_TRIGGER_LOCATION_CHANGE) {
-		/* TODO: add migration */
+	if ((trigger & AMDGPU_SVM_ATTR_TRIGGER_LOCATION_CHANGE) &&
+	    new_access) {
+		int32_t loc = new_attrs->prefetch_loc;
+
+		if (loc == AMDGPU_SVM_LOCATION_SYSMEM) {
+			migrate_mode = AMDGPU_SVM_MIGRATE_TO_SYSMEM;
+			update_mapping = true;
+		} else if (loc != AMDGPU_SVM_LOCATION_UNDEFINED) {
+			migrate_mode = AMDGPU_SVM_MIGRATE_TO_VRAM;
+			update_mapping = true;
+		}
 	}
 
 	if (!update_mapping)
 		return 0;
 
-	AMDGPU_SVM_TRACE("mapping update: remap interval [0x%lx-0x%lx]-0x%lx\n",
-			 start, last, last - start + 1);
-	return amdgpu_svm_range_map_interval(svm, start, last, new_attrs);
+	return amdgpu_svm_range_map_interval(svm, start, last, new_attrs,
+					     migrate_mode);
 }
 
 static bool
@@ -1004,7 +1012,8 @@ static void amdgpu_svm_range_restore_worker(struct work_struct *w)
 
 		down_write(&svm->svm_lock);
 		ret = amdgpu_svm_range_map_attr_ranges(svm, op_ctx.start,
-						       op_ctx.last);
+						       op_ctx.last,
+						       AMDGPU_SVM_MIGRATE_NONE);
 		up_write(&svm->svm_lock);
 
 		if (ret) {
@@ -1042,7 +1051,6 @@ static void amdgpu_svm_range_restore_worker(struct work_struct *w)
 			drm_gpusvm_notifier_unlock(&svm->gpusvm);
 			svm->end_restore(svm);
 			return;
-	
 		}
 		drm_gpusvm_notifier_unlock(&svm->gpusvm);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h
index 18bf3dad13fd..0065ae50c700 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h
@@ -30,6 +30,8 @@
 #include <linux/list.h>
 #include <linux/types.h>
 
+#include "amdgpu_svm_range_migrate.h"
+
 struct amdgpu_svm;
 struct amdgpu_svm_attrs;
 struct drm_gpusvm_notifier;
@@ -62,7 +64,8 @@ void amdgpu_svm_range_flush(struct amdgpu_svm *svm);
 void amdgpu_svm_range_sync_work(struct amdgpu_svm *svm);
 int amdgpu_svm_range_map_attr_ranges(struct amdgpu_svm *svm,
 				     unsigned long start_page,
-				     unsigned long last_page);
+				     unsigned long last_page,
+				     enum amdgpu_svm_migrate_mode migrate_mode);
 int amdgpu_svm_range_apply_attr_change(
 	struct amdgpu_svm *svm, unsigned long start, unsigned long last,
 	uint32_t trigger, const struct amdgpu_svm_attrs *prev_attrs,
-- 
2.34.1

