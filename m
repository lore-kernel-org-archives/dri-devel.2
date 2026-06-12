Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DC6DCD98DA
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 09:11:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 739AB10F3A6;
	Fri, 12 Jun 2026 09:11:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="canbXsgm";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010014.outbound.protection.outlook.com [52.101.85.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CC2010F39E;
 Fri, 12 Jun 2026 09:11:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R5CGbmhi1HgRmu8esAXfs3gHPCeCYv7B0X76nU5n7NB2RPOWlPeZBg6vzZ46qgu/oDDmpqCmGcqRCqkHcxS4t/bPSE2Zam2WRR3xc3ZahursHKzKctGPl60+bOgLjiaodo1eH6c0vqgx2neX+uUi731B4dYehV4HiBW4CApq+yG/DnMpgPDWS9Sl3wthvbFWTQnAE3Lt6KhpofU/M5Iwp4v7120YdPQq84smDllEhBUkGMk0WaJ3dYeMQOBx36kIK2Mpl7PcreTq7R8lFPdslHam3OrJT0v2CvxypktRCKXoNjsH13RIX1iouvi7Of30KHubnGk5CNHMytvkxINEJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MVGWSE/A9DlxjOWptgiQyVpPhTDPkwPlwdm/oBDUMuU=;
 b=pwgt1K+sqNhEEk9UCso9ZJ4dViEv5RaOZpAfdRlaCFHCAQPgArSbCIi/hsy5nHj5R0AMSLRe+BLU69qmWxRlSHfOtEDg5HhU5fuuQ4GWqLqzSu0L7p9/aW3VYJsWtKCheWOcgFyW6IXM6hMf1tNO0gxhr+PrB4SV3+njO3kZjSXg5zh/qxasv6I3eE6XvQj7we8CXarvQkOXXogukivq7GHjN12gMGGqmdLIUuNITBIDuhoD6kgI+2ytUgpM+d0J8lkGkxDa9VacqlifrserQLFKH4fnhtuC4e70Z59lDhXpU/+8r9nHwJCnq8MfP1AcBJ9RXZj+cY3m/ZEu7q3s6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MVGWSE/A9DlxjOWptgiQyVpPhTDPkwPlwdm/oBDUMuU=;
 b=canbXsgmo7xLCrosNaahqFgzNsUxKRavxGUv5nBPGGuVqY2wpBYOA9t342Bu3mLDsDvNRctE8L1O3v2EDJm/+sGZy3DahbslBnzmNJP5No4NEeyO7rBwhr/ZN08COcLl9YATaW6nTHyy8PzReoP02iGtlY1DJRtOabMYa99hTtI=
Received: from CY5PR15CA0128.namprd15.prod.outlook.com (2603:10b6:930:68::18)
 by IA1PR12MB6091.namprd12.prod.outlook.com (2603:10b6:208:3ed::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Fri, 12 Jun
 2026 09:11:20 +0000
Received: from CH1PEPF0000AD7D.namprd04.prod.outlook.com
 (2603:10b6:930:68:cafe::64) by CY5PR15CA0128.outlook.office365.com
 (2603:10b6:930:68::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.15 via Frontend Transport; Fri,
 12 Jun 2026 09:11:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7D.mail.protection.outlook.com (10.167.244.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Fri, 12 Jun 2026 09:11:19 +0000
Received: from hr-amd.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 12 Jun
 2026 04:11:06 -0500
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
 <yiru.ma@amd.com>
Subject: [PATCH v8 15/18] drm/amdgpu: implement synchronous TTM eviction for
 SVM BOs
Date: Fri, 12 Jun 2026 17:09:17 +0800
Message-ID: <20260612090928.29682-16-ray.huang@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260612090928.29682-1-ray.huang@amd.com>
References: <20260612090928.29682-1-ray.huang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="y"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7D:EE_|IA1PR12MB6091:EE_
X-MS-Office365-Filtering-Correlation-Id: c3a363c3-72fa-4c55-db8c-08dec86290c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|23010399003|36860700016|921020|56012099006|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: 4UO0gwChLKqe4NMlRkH7UskE/0gJcgUpo8ZAArveJZhcAOtWGucTtN0P6BRv4u6yVw0CKR0hT2ncgDGglgJVhdH5Nha5prIjxBGVCVp0DyUxgxhFg5nSCAbTJ3EnkwoGEROaCI0kxrFPJRJZCZgInkKBG7urmg+2zf9NccySHipFffMmn/fkDohF6gE/63aRoSYoq0jBm/Mk1qd6boWMIG72Oo8g5MVnLSxG/RMQEtcpIRxlz9JXiwYmzy2b7XWeTSsuujQCH3tJ71xXPggmWMyDpgizC5W/k0cvlKeBBKWSv2PL5RbL7zGvYpjhzTZt1IqB+EhaM1nqaxgkHU0cLaFQ46z3ODeBJmvxlb+0MGsdTz21+WLJnb9UG2xBfMhftZtK427voPquAtxuPVvUwrlAVbPJqxtwzz9IToSk8x+8phWlnD4yrx0d5/KsUenooiq/K72jXbriGNWnXUvaZ8UFZDqWSDldYuP50ZyA1tfEd38YvzQ1W827vbkJYo5xdhVvd1hLWZhCbOx73E+VZsNfbI0eEt1u0JHTparnnrfPPxSSNxn76nPBNHgSlMrmwVwHJ/yy/kKu8OJo5O98G6rJmnJz0mlAizb4npJ1oGVwENaxwLaFIbgjZXBfKTX332/XusW+Ujv1326Y9678bXYTn6Z7TTsAM105TgbxC+jgcxHwQ1/Tp0AdhGgJDlWtMzJ3GdoiY8boaOFyi1dGhwZ+DfYAG4bQi7ASjPsv8G/t9KL7k4+L/66qUX/sW2I47lkhrflxxW2ELtbYvqm09g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(23010399003)(36860700016)(921020)(56012099006)(18002099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2hIkOaOOZpzOc+684gMgZA0lhiWA3gNzgVfzq0N4BxMJiQ8rqgC4pcyvlsHgCknYf9hjP3F7tKPA8L9s58nlUBBgriw/4Vm7HoauQ8b97gx+RJkAYROIC1ojtkUPBopGLjWF4uMzEUoYak6Bzw+z/+zbx/XIo+tQQpDJODg0Plk4kuq4UbqNJn7VCibB1TVIdA/dPO+licN5xfVZBlO/k07DzNuFCoxRXbBC13Gzp7+Z6fMQNaOWF36yulLaWKOMfiPyGwiR+8IPSn8HiRmFTOER58kVKiuMkcEJVpEJivxNYXAeu7rhDhKO94aUhMmiezIaHGoblehzI2LrvqMXv4NwM/rH1ndPFEGO5zfcea/OPbDypW9aS/l8nBOsQ1xljPniTWrA59zcFUcKe4SgcszOkLWHxuhGlpojNqTGd6kZqJJFP8Ni9GcEY/WK8gAp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 09:11:19.4141 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3a363c3-72fa-4c55-db8c-08dec86290c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6091
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.c | 28 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.h | 12 +++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c  |  4 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c     | 20 +++++++++++++++
 4 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.c
index 3756404ec334c..88079221eeca7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.c
@@ -645,6 +645,34 @@ static const struct drm_pagemap_devmem_ops amdgpu_pagemap_ops = {
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
+ * Return: 0 on success, negative error code on failure
+ */
+int amdgpu_svm_bo_evict(struct amdgpu_bo *bo)
+{
+	struct amdgpu_bo_svm *sbo = to_amdgpu_bo_svm(bo);
+
+	return drm_pagemap_evict_to_ram(&sbo->devmem);
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
index a196a11ff8025..25e0c1f131809 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.h
@@ -29,6 +29,8 @@
 #include <linux/memremap.h>
 
 struct amdgpu_device;
+struct amdgpu_bo;
+struct ttm_buffer_object;
 
 #define AMDGPU_INTERCONNECT_VRAM	DRM_INTERCONNECT_DRIVER
 #define AMDGPU_INTERCONNECT_P2P		(AMDGPU_INTERCONNECT_VRAM + 1)
@@ -70,12 +72,22 @@ struct amdgpu_pagemap {
 
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
index 6c6ab4dd6ea95..9d3deec7cedec 100644
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
@@ -575,6 +585,16 @@ static int amdgpu_bo_move(struct ttm_buffer_object *bo, bool evict,
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

