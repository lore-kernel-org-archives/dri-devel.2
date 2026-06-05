Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49BB5CD6E7E
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 07:54:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE07411A537;
	Fri,  5 Jun 2026 07:54:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qMTb5z0h";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013007.outbound.protection.outlook.com
 [40.107.201.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50CC611A53E;
 Fri,  5 Jun 2026 07:54:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MhFhg7JCI77k5yJS1ueBlCZpj1KXXITyIjjcj+o7BS1g/WJXVlSBkVkPQv0ps0bA3N17On95vXFcr0XounA2B3/dqSBR5Y9sdsbgMgJfR0bZa6JFaiMlITBEuNl6yBvnnlqc8ltdmwVgW8WqUnuQP0ummFKpw1SUowc7DL4SX85uMBkwSCTmDYhY97FjkwrCi1zf8GNRln7W2H/ykrwuQw7kVBs6bAhGFjH2SCGIsIvG9o1cmd/1P/4p4qcUJ+Gpt14f9Cw3BjNeGrX07Ub+382nq3FZe+DJwYoXTigpR325Rdp0LGq5VmHqr0D8b26GCCh1mBUmj+evG/pPjrxWqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eg8ZIF8mz+EWVDmCwF/vwPnqWfMwYU2YtonuzFWazYQ=;
 b=NHJnDoB5cWxPYvg2qBSAWg/o9aqXnpDfgHOhm72djXr59mCIIid+G9hC7GnRog/IIiJPB2i75NPr7ePBEzJwQoIaj2gJUsJzRiiREbO2XYuNADrsGxZFHEzlBEVri9FZ+Ce3IE6ChHlOVVvMZZCWh/97W0lJUeuMtUASWKkQXuT/3CHoumgooHR7j43MKmJ50AkDWTkgzBk7Dk0b0RBe6RQIBTltGUa9vPVi2G1dxYKKiac8CJbRR30mPsyT//ZZoMjZrFosWKE1YnwPnP8ia+fG253z8UY/bSxl9A1Wy3U/kdgNE0frPy5f5apwrVQ6Fk0dY0wgeBCbr9JqlYPyPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eg8ZIF8mz+EWVDmCwF/vwPnqWfMwYU2YtonuzFWazYQ=;
 b=qMTb5z0hr/vhrganAhOFpoxQvQ64vAtEOZ0SzpfLZ7oX9H7zYd8Cryk5SjwlvohrMccv4mb7OlM/jQN3M0lsJgjsFD7jCF0Fur8AvMZ1Sf/5QbEcPZA+KX5v1DxCjS/BWFT1O0cJ1trcuZLT/qLb9r6EpPSGttWobKUm3ritoDo=
Received: from BN9PR03CA0525.namprd03.prod.outlook.com (2603:10b6:408:131::20)
 by DS0PR12MB9323.namprd12.prod.outlook.com (2603:10b6:8:1b3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 07:53:55 +0000
Received: from BN2PEPF000044A1.namprd02.prod.outlook.com
 (2603:10b6:408:131:cafe::c) by BN9PR03CA0525.outlook.office365.com
 (2603:10b6:408:131::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.8 via Frontend Transport; Fri, 5
 Jun 2026 07:53:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000044A1.mail.protection.outlook.com (10.167.243.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 5 Jun 2026 07:53:55 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 5 Jun
 2026 02:53:54 -0500
Received: from junhua-PC.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 5 Jun 2026 02:53:51 -0500
From: Junhua Shen <Junhua.Shen@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <honglei1.huang@amd.com>, <Lingshan.Zhu@amd.com>, <simona@ffwll.ch>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <Junhua.Shen@amd.com>
Subject: [PATCH v5 3/8] drm/amdgpu: implement synchronous TTM eviction for SVM
 BOs
Date: Fri, 5 Jun 2026 15:53:35 +0800
Message-ID: <20260605075340.20199-4-Junhua.Shen@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260605075340.20199-1-Junhua.Shen@amd.com>
References: <20260605075340.20199-1-Junhua.Shen@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A1:EE_|DS0PR12MB9323:EE_
X-MS-Office365-Filtering-Correlation-Id: 1955d3e2-1fa3-4dd0-c16f-08dec2d797f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|921020|56012099006|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: t+NXXQwdQ+tr0PGdRTINGUUf8v+DkhG63w5mKhx8jz3aV1HN9yZt02n7ztOraRIQcZ72tl/0zYJHEWwaIMXFUjfKwWdk820qLYoo45Vp8UqQ2FvWDpcUGwe8S+JOn+bYLlpMGYIedf4DbHb8ytyAlBIu7rNP2YzRdMSLcPq4kY/esCFnLBOYsbCvdBzuGet00oDGTxYvQ3n5arOHRtunaFcOS5juGQCubai2J2opUum89Y/RLvJAxgSHB9vkDGdU++XmU8pn6umj+YLGf2gZxiT9z9JmsRVfvpzSj5pzGSp4LLXcnMfxXmzGCym5hOYlI3uRXKWPkDhIc7poc4GMCimJXflWCqIY/S+REuMeyL6BpcoG17J2vqjjf3O57RBjdBZgOaYdJRGfT7yhB+LQZKRKvZ0iw48qP63zY5RP7YN89tHK9+gURqrfBjAaKNbAWWTdgWT6iFlg/tbk4Sbbw2ii7o5aRrC39SdJkbUd1IV/Y4IGvI3saapov3EpKa1lEDlZFNmDGEvyYwSoYqFTDZ0EaxaB0slUJEA6lqSV9vj+K1iN/AFvAVHcrjifGT0D1+xpqQAI7Jp6IDjeWvORNc2HBniSguoBpHWYBhAg8sbz5R9fY8iZdpq09pRaflQc8mRT2s51t8sBHOGA+CBBN/dt52BfTHE0BQHP42SThUezZD4Ak877y0RIHFja1mYZP16X5+aVfqOno969dejzRv8m+VdOs3tKFpvCBCshDVe31mM5+lD3pklJb8D3Q3iKOLkbdkr5ZvLANwQZp/LCDQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(921020)(56012099006)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qbSDzSNUKwfaXmnyzU9C9s1iefx3WEzx7y7k8yZXsQTO5gnXFn5anTCvvmcaMRZ0l1o7PVh4zoaitetxqHJQDTNbQlP6o+5OpRXlgrz/DyGdcuF4Fq0gblqJGDLx2/EPnazK3ZbFB1qO5VQDHesmv1VUfRLHRnAYThbS8yRds4re0nOIOeOGXmQKkzf49hPTo0Hj7HUdONdNN0jzApymMiXyAWpimP5miWdnJ37lZ+OLFH+wtkLHoZVyktD4//EAYsCuRRI7K9+73au6JQb5Do9dGRwJY1b3VUiFMCYbydNwH+ywZNgjUO4/4FBp/ruaTWmvhz+wjqkFQEyIxhgl8geDhJDtDRZJwNyPOfE5FswucUsHv6dinRmE53ZlRlttrSxHn8cx5csJM8d98u5zRF2P931WAPevrruXt4e8upgItRvXSZqvnwaE0dk1LSvJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 07:53:55.5937 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1955d3e2-1fa3-4dd0-c16f-08dec2d797f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9323
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
index 4d6ec19c4887..0979e0319cef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.c
@@ -628,6 +628,34 @@ static const struct drm_pagemap_devmem_ops amdgpu_pagemap_ops = {
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
index a196a11ff802..25e0c1f13180 100644
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
index 4dd7c712b8c3..d6ea8737dedc 100644
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
index 6c6ab4dd6ea9..9d3deec7cede 100644
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
2.34.1

