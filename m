Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80B1AC55184
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 09:44:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B910D10E979;
	Tue,  4 Aug 2026 09:44:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PitF+G7r";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011027.outbound.protection.outlook.com [52.101.62.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61DC610E979;
 Tue,  4 Aug 2026 09:44:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uG7PI1xz4Nk3UzNY+15pAwUYjGsnWuux8DI2+GfuatXtAfdeCkmtTuvtg+b5cuxZGRq3yRRxKLjGwdKlDVJiMCLe1jlXoE5vfRTvExVWvM/6e5w31gH5jhJdbKjMZEiFD9OAfLCUYeQsR91c1fEQxI8Wq5bNSxL+UitzgFCxk4gCCRqXngPf0kVHDUkVfq4YQLY7GXYyFfWhov1mD3BzbPGTmYFJqvTE5IlOdmXiXpNPXQmgYwU1/JX36F0qPrAkfOy0CYQWQo2LHUOY/aIw1aW0b5vwCunv0OHPzXLLb6Q9HcccKkuaS8M7n5Q10aTBq8xCGBTijKCx9915TbKtPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c50gO5gyXQwG8l5JnyKSG86oTnvo9knV8m64pk6PTbQ=;
 b=dXx0tPjXNWKm/AgvkNWlGDefwWvGTefNE50wNS8/isArgdOwuhOG0arBCR7/b4z/D1TdaPmu2Z6da4lnZY9jc6FD9OEbJ/1TmA30bo7XcpWCfs+v0OHH0POSP8XnuBtthFjvzOHlHjt+WNJEQpqvPJo2bJSccbkxFo24onaGLhkdwU94xPA9nk+wL6WAG76NvCytR3xshBa3Z7zQCpY5LsJkiHSgcNVQ0NOmFQbsoUXORMA5Z/dbd+56iRq2x/gC84Y0CQAdSpD/lZTjU9IbFREHRgHDcrwUZ2LusLyrB5FyC6tOTRDpgpqw1zvDEAB1gT8jDPuoJ3lVBHVLiN30xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c50gO5gyXQwG8l5JnyKSG86oTnvo9knV8m64pk6PTbQ=;
 b=PitF+G7r/nFQE0pEzW9wbKj8BjBhtLItDH6dmwdienfhBPcJMiqrvWSyUW6a4qrcO9GS3nnHCPJLY7vbA89c66qLYka/WtS56o9jTvurALh8wEoP+YQ7+zslL7FqVhxa5+3kf+k80f5pyO/XjAJVQnIN2gVwLr5CDczxuuHl9iA=
Received: from MW4PR03CA0146.namprd03.prod.outlook.com (2603:10b6:303:8c::31)
 by MN2PR12MB4094.namprd12.prod.outlook.com (2603:10b6:208:15f::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 09:44:15 +0000
Received: from CO1PEPF000066E9.namprd05.prod.outlook.com
 (2603:10b6:303:8c:cafe::41) by MW4PR03CA0146.outlook.office365.com
 (2603:10b6:303:8c::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.18 via Frontend Transport; Tue, 4
 Aug 2026 09:44:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066E9.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Tue, 4 Aug 2026 09:44:15 +0000
Received: from hr-amd.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 4 Aug
 2026 04:44:10 -0500
From: Huang Rui <ray.huang@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Philip Yang
 <Philip.Yang@amd.com>, Alex Deucher <alexander.deucher@amd.com>, "Felix
 Kuehling" <felix.kuehling@amd.com>, Simona Vetter <simona@ffwll.ch>, "Matthew
 Brost" <matthew.brost@intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
CC: Xiaogang Chen <xiaogang.chen@amd.com>, Oak Zeng <Oak.Zeng@amd.com>, "Jenny
 Liu" <Jenny-Jing.Liu@amd.com>, Zhu Lingshan <lingshan.zhu@amd.com>,
 "Honglei
 Huang" <honglei1.huang@amd.com>, Junhua Shen <Junhua.Shen@amd.com>, Yiru Ma
 <yiru.ma@amd.com>, Huang Rui <ray.huang@amd.com>
Subject: [PATCH v9 15/18] drm/amdgpu: implement synchronous TTM eviction for
 SVM BOs
Date: Tue, 4 Aug 2026 17:42:41 +0800
Message-ID: <20260804094246.1719318-16-ray.huang@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260804094246.1719318-1-ray.huang@amd.com>
References: <20260804094246.1719318-1-ray.huang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E9:EE_|MN2PR12MB4094:EE_
X-MS-Office365-Filtering-Correlation-Id: 0968ab39-6463-493c-339c-08def20cf27a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|1800799024|376014|82310400026|921020|6133799003|56012099006|11063799006|5023799004|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: nD4NFcQ2NkXt4MqMiQrNl90D7pB1yiNORHsAz5gqIx+XrQGAO0YhmljHc3+G8UmgZQk+FhGh47/nSh4mCWC8MK1wY+aFWwn8fuEfooXYeoxqiTWFvIBRlRuH0ZUJoi36SbMS4pBrYP36kOW5xvhhanmvtqVv9ezYm8TRqbuAtOVSYob49CnZHSl5Foea9QivfCnDUEy6X3/wKvzoHrBp1Eh152yAAuw0F2SfW9nhA0GQ0cYqeBscLQUUjQvpGymjgbcAONe/QEFIyFUj32BjhOISIzm+1wFJd1RKar93kXXKjlZ3TDc5FKnXlAz6KZUkrjOP33QFyxSah7NkowkMxsauERw+9fUjyQlew2nnw2cURsrms/QZQPvJWt4IgHYfjr3o15gR+15HgmJVRUCFYntrzYWIT3U4uJu4O89fMkRH6r/WlCjRdk/8CnNV/7RWQeq0Tz0xCUuxWSsNjd8PXk2nFY8TKC3AuoEYI6j7omFsnj2Xeg6yC5mrSnniVhhmsha9x/Bhd//xPAzg6J0duMocWy8TH/e3V2w/UEkDjbLC/y2FNEmhCfK7CU8ieuYRS1vyiiUEEkrfN9RSrTDqdLu5qHoq4XsWPAvt/gedyG+cPh1IzU3q5dEXx8v7QsFIAFu+Gwv1UITYO71ZLlsaNHIvAmPRcWRmvx3+D2KzhFY33ivcaE1JJq4SERhG8vee/78nhH0HuXbTmEJQOZypsAAS7SB2e0avbKlt90O+GSAuCw8RQHgD1iTjxsOcL59t
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(1800799024)(376014)(82310400026)(921020)(6133799003)(56012099006)(11063799006)(5023799004)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: T9FfTxovWNsGSCFam+MvYwDzn5YhJouxlZyzExEUxl3EUBZgXxmcwsiv0uGJf567sMc9e3UpoD3NmS8qPbD0+pc1wMG6tvAPaTjrv99DrItANiEH83n5feVynqqmcr6ew7ZLVpi1P4Q6ytcby8tfb7dtq4ugHgR1I0/dbjm3kDoAIEG4nwWdPSXzLAFtVf3talWjiCg93V3H15aLs3Tazl0uqW1LvZH0ZbcW4c2oTZXpnQFTnpbtXHY8Gy8eQOYuP4ru0bb9KOxdHxy4GFlLEFK4robdy3+8vxhViM5urhReYjwVxXxpJZB2P+TllZXpI2HVaav7iu7weEdR6fgRJCpf0yRNj1iHQPG7KSTDQ/ZjetLEAMOAwwgZd94eNcXgHoWacLcOJ3/1H1iz6Yr0SoAfSN4AcBnllRsayqHwHg9GJOy4eP07qwV1q/US3N60
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 09:44:15.3469 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0968ab39-6463-493c-339c-08def20cf27a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4094
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

From: Junhua Shen <Junhua.Shen@amd.com>

Implement the TTM eviction path for SVM (Shared Virtual Memory) BOs,
enabling VRAM overcommit scenarios where device-private pages must be
migrated back to system memory when VRAM is full.

- amdgpu_ttm.c: Add SVM BO detection in amdgpu_evict_flags() to evict
  directly to SYSTEM domain. Add SVM BO handling in amdgpu_bo_move()
  to call amdgpu_svm_bo_evict() for VRAM->SYSTEM transitions, which
  synchronously migrates device-private pages back to RAM via
  SDMA.

- amdgpu_migrate.c: Add amdgpu_svm_bo_evict() and
  amdgpu_svm_bo_is_svm() helpers.

- amdgpu_object.c: Register SVM BO destroy callback in
  amdgpu_bo_is_amdgpu_bo() so TTM eviction can identify and handle
  SVM BOs correctly.

Signed-off-by: Junhua Shen <Junhua.Shen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.c | 44 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.h | 12 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c  |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c     | 20 ++++++++++
 4 files changed, 79 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.c
index 6aeba9220ac41..26b99e3088f23 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.c
@@ -64,6 +64,7 @@
 #include <drm/drm_pagemap.h>
 #include <linux/memremap.h>
 #include <linux/migrate.h>
+#include <linux/sched/mm.h>
 
 #include "amdgpu_migrate.h"
 #include "amdgpu.h"
@@ -648,6 +649,49 @@ static const struct drm_pagemap_devmem_ops amdgpu_pagemap_ops = {
 	.copy_to_ram         = amdgpu_svm_copy_to_ram,
 };
 
+/**
+ * amdgpu_svm_bo_evict - Evict SVM BO by migrating device pages back to RAM
+ * @bo: The amdgpu_bo to evict (must be an amdgpu_bo_svm)
+ *
+ * Called from amdgpu_bo_move() when TTM needs to evict a SVM BO from VRAM.
+ * Uses drm_pagemap_evict_to_ram() to synchronously migrate all device-private
+ * pages back to system memory via SDMA.
+ *
+ * If the owning process is exiting, there is nothing to migrate; return -EBUSY
+ * so the TTM eviction LRU walk skips this BO instead of aborting the whole walk
+ * (which would fail the allocation that triggered the eviction). Hold an mm
+ * reference across the call so the framework's own dead-mm path stays
+ * unreachable and any -EFAULT it returns is unambiguously a real error.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int amdgpu_svm_bo_evict(struct amdgpu_bo *bo)
+{
+	struct amdgpu_bo_svm *sbo = to_amdgpu_bo_svm(bo);
+	struct mm_struct *mm = sbo->devmem.mm;
+	int r;
+
+	if (!mmget_not_zero(mm))
+		return -EBUSY;
+
+	r = drm_pagemap_evict_to_ram(&sbo->devmem);
+
+	mmput_async(mm);
+
+	return r;
+}
+
+/**
+ * amdgpu_svm_bo_is_svm - Check if a TTM BO is an SVM BO
+ * @tbo: TTM buffer object
+ *
+ * Return: true if this is an amdgpu_bo_svm (identified by destroy callback)
+ */
+bool amdgpu_svm_bo_is_svm(struct ttm_buffer_object *tbo)
+{
+	return tbo->destroy == &amdgpu_bo_svm_destroy;
+}
+
 /* drm_pagemap_ops — top-level migration entry points */
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.h
index 56c66851f0a47..e9159e8167dd7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.h
@@ -30,6 +30,8 @@
 #include <linux/workqueue.h>
 
 struct amdgpu_device;
+struct amdgpu_bo;
+struct ttm_buffer_object;
 
 #define AMDGPU_INTERCONNECT_VRAM	DRM_INTERCONNECT_DRIVER
 #define AMDGPU_INTERCONNECT_P2P		(AMDGPU_INTERCONNECT_VRAM + 1)
@@ -75,12 +77,22 @@ struct amdgpu_pagemap {
 
 #if IS_ENABLED(CONFIG_DRM_AMDGPU_SVM)
 int amdgpu_svm_migration_init(struct amdgpu_device *adev);
+int amdgpu_svm_bo_evict(struct amdgpu_bo *bo);
+bool amdgpu_svm_bo_is_svm(struct ttm_buffer_object *tbo);
 #else
 static inline
 int amdgpu_svm_migration_init(struct amdgpu_device *adev)
 {
 	return 0;
 }
+static inline int amdgpu_svm_bo_evict(struct amdgpu_bo *bo)
+{
+	return -ENODEV;
+}
+static inline bool amdgpu_svm_bo_is_svm(struct ttm_buffer_object *tbo)
+{
+	return false;
+}
 #endif
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 4dd7c712b8c31..d6ea8737dedc5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -43,6 +43,7 @@
 #include "amdgpu_vram_mgr.h"
 #include "amdgpu_vm.h"
 #include "amdgpu_dma_buf.h"
+#include "amdgpu_migrate.h"
 
 /**
  * DOC: amdgpu_object
@@ -93,7 +94,8 @@ static void amdgpu_bo_user_destroy(struct ttm_buffer_object *tbo)
 bool amdgpu_bo_is_amdgpu_bo(struct ttm_buffer_object *bo)
 {
 	if (bo->destroy == &amdgpu_bo_destroy ||
-	    bo->destroy == &amdgpu_bo_user_destroy)
+	    bo->destroy == &amdgpu_bo_user_destroy ||
+	    amdgpu_svm_bo_is_svm(bo))
 		return true;
 
 	return false;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index cf78d70204941..6632abd92311b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -59,6 +59,7 @@
 #include "amdgpu_hmm.h"
 #include "amdgpu_atomfirmware.h"
 #include "amdgpu_res_cursor.h"
+#include "amdgpu_migrate.h"
 #include "bif/bif_4_1_d.h"
 
 MODULE_IMPORT_NS("DMA_BUF");
@@ -121,6 +122,15 @@ static void amdgpu_evict_flags(struct ttm_buffer_object *bo,
 		return;
 	}
 
+	/* SVM BOs must evict directly to system memory for drm_pagemap
+	 * migration back to RAM in amdgpu_bo_move().
+	 */
+	if (amdgpu_svm_bo_is_svm(bo)) {
+		amdgpu_bo_placement_from_domain(abo, AMDGPU_GEM_DOMAIN_CPU);
+		*placement = abo->placement;
+		return;
+	}
+
 	switch (bo->resource->mem_type) {
 	case AMDGPU_PL_GDS:
 	case AMDGPU_PL_GWS:
@@ -576,6 +586,16 @@ static int amdgpu_bo_move(struct ttm_buffer_object *bo, bool evict,
 		abo->flags &= ~AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
 	}
 
+	/* SVM BO eviction: migrate device-private pages back to RAM */
+	if (amdgpu_svm_bo_is_svm(bo) &&
+	    old_mem->mem_type == TTM_PL_VRAM &&
+	    new_mem->mem_type == TTM_PL_SYSTEM) {
+		r = amdgpu_svm_bo_evict(abo);
+		if (!r)
+			ttm_bo_move_null(bo, new_mem);
+		return r;
+	}
+
 	if (adev->mman.buffer_funcs_enabled &&
 	    ((old_mem->mem_type == TTM_PL_SYSTEM &&
 	      new_mem->mem_type == TTM_PL_VRAM) ||
-- 
2.53.0

