Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D648CD37B6
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 09:57:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9278210EDAD;
	Wed, 13 May 2026 09:57:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MO8ugGd3";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010038.outbound.protection.outlook.com [52.101.201.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EF6F10EDAA;
 Wed, 13 May 2026 09:57:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F8ofOTmz3iTn9PPqTFadvve6msBPcdEPo3VaDDu20zdJN5aM/96G4YuY2S3w/DFcN0ijY24M89HziD1iSx8/TfNF8ajkf/3vUVNZX9X/AxOoIsBRhZO/9GAQOYGonqOF9DpGNQ4N7jMZKH1vXz8OX5viLCQjeEVayMDw5/HXkv83muvVThLHHE3PCREiKon8LtBRmjsjULkT2qOhb4BNljkZE+6XO0DNkfbBInAp3VdFb8PijhC343nrz80Jb7ibwxQyvvQ0fgD52mT6g/E2u/FXdu6PA5YVJ0Rsp3N+zSSySwU/JEqux8REJE0Rp1SkuDZlHNzXBVO4m6n0i53eSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y66Dq2U8qftIMLwe8W7FelmRhnz7ljkbxu7FBr1e8ik=;
 b=lvzjGE4wDpvbDPJXx1coM+v8MWVl0rtxTBccFKqIsqQPeC6eV+3UGSoa6BKjLzFAX38+pLzZhJ0LpqGCFJ56+i1+ld70JhQ+VV11CXddJKh6yYSEfNQSxEZTSL/5M8LahnDhfNR9ogn6nCuYNpQyappL762Ch939vLR3nCY6vCmnN46GOSWVpE6Ea4vm+LRT68TBVXcF43PnY7f9lM9/Ymkgv1xQz4izDuKzIUjwScVR5TMAD/En3yuER1bgwWEDRdK2K36IzhClOYuwu02D1HT5iDMhhQeKyJInV4R1NcurIO7IlfnMarupxBLCHTFAf7hDXyumFA4C9B5MyLs/zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y66Dq2U8qftIMLwe8W7FelmRhnz7ljkbxu7FBr1e8ik=;
 b=MO8ugGd3CRXCsZP2KfIWTe620jtJLZS6khBUKnTShRjLtkMzlM3bAn9sd6fBU7WjEvFEKcQKTaUlt5po+a6sFeZg/suqdHooW+dZRE7yiNNQ5BDEIifvfzrdnZlsHpLNBhVcwFNYppFu+2tYJuLoVfEDBH/A1o2xYOghXoeKn7E=
Received: from DS1PR04CA0007.namprd04.prod.outlook.com (2603:10b6:8:44f::10)
 by SJ0PR12MB7460.namprd12.prod.outlook.com (2603:10b6:a03:48d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 09:57:49 +0000
Received: from DS2PEPF00003441.namprd04.prod.outlook.com
 (2603:10b6:8:44f:cafe::98) by DS1PR04CA0007.outlook.office365.com
 (2603:10b6:8:44f::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.12 via Frontend Transport; Wed,
 13 May 2026 09:57:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00003441.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Wed, 13 May 2026 09:57:48 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 13 May
 2026 04:57:48 -0500
Received: from junhua-PC.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 13 May 2026 04:57:45 -0500
From: Junhua Shen <Junhua.Shen@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <honglei1.huang@amd.com>, <Lingshan.Zhu@amd.com>, <simona@ffwll.ch>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <Junhua.Shen@amd.com>
Subject: [PATCH v4 3/6] drm/amdgpu: implement synchronous TTM eviction for SVM
 BOs
Date: Wed, 13 May 2026 17:57:31 +0800
Message-ID: <20260513095734.69598-4-Junhua.Shen@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260513095734.69598-1-Junhua.Shen@amd.com>
References: <20260513095734.69598-1-Junhua.Shen@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003441:EE_|SJ0PR12MB7460:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b6c5edd-ad55-4ccf-38b0-08deb0d61703
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|921020|18002099003|22082099003|56012099003|3023799003|11063799003;
X-Microsoft-Antispam-Message-Info: BQ5ia/83Gi1PiGf16ql4+XITk7JkRuHYFR0MFTUDE8EX4ai+TIiRIBZ37X9E6PLVxtcfrSAg9Z1+KQkfVOFOj8RD+linXZj/HqDCMGLigwy9MFK7AH9C2bWR/ku29uz0Hv/uchHtu8zM3oCQ72TFJDjRMgmYzKHWRRpBtaY6RMpW+SwbTAwR82445RrPEkCW7paK3QhPN1AWgdJlx6wsnzu+oHB/pepc2Nn5haVF7EtgvXTI5GCUnDWVa6tiEHlsXdQDvVPt6mZKFNrPviT/3kkelpEYMU/cK4dPJNHyfH9UztClGCPYeJ/wOxHC9iLSdWF8wCvq00iQhWe6aPi/0OmPY3OE9LoY+91WDC08Yl767PCuhC1AEMfJ1fyEHFcRdPLG3SO+1MxWDsl1ZL2+DxnSRUeJ+9bgXhKe+ouHAJJiwEI7LwnINocy6wCeEE6QiYtRo5nQSt9cj7Gb1A2kc4zwAYwWdzzwvM34ZPHXwgnQxratfqcpKlIg8Gipwd4sUbSbFffJ5yW91SkFkBK/gajWBwwQkBmT1OOwa4YPnMGjgeZrQu/IsDSnb+hC0HwC/SVMpbfTD5rZYFWO1Q4aCipxXvF3MHNg9Rn57Lu1seM4hOiflrbXaYoQfe0Y2268NIukvHCymd+yP9iLPs88Bjw8w3Jn+P6puaGZtG2ggF/k95iUXydzoHE3V2o8MZIn22WJradxzcjCeSgs8pAf1aLW9RS+vc7qIKEInO+kyBnPZ02IKmWmX4538vOdWh4HUnuN8BnT41F1xTEqf9zBYg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(921020)(18002099003)(22082099003)(56012099003)(3023799003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Q4X9qyOa38Q1sYJUBSup7Nbzz/gRsXwUNpzwNB5jBJyWL8rFyMK+6K9u4ymLshJ76XfA78rhhAdwRUPWA9mqTu8t0fXmjhwvQv6jje7nng2d3z/WYHcY2JZTJYaTx5cHXRLzFc/ihtcdiwmwGJoLNhepNLljn/Hn5mgSSlN1Whwj2Uyvw6TUXq9/7l8TawNZmReMEhtYvC2q+Y8hqRcZrzE5lPvHEKhIe60QbSSv5cFI0DG3yx/mmVBsudofqBdzAMiBK/HBAhI1hkFtxwUUy+YYt+n3w+x0iSfL71MfFXsE+tpnqYQEyLxFKk/1n2rQ3UT9PoBlHARieAJviuNRJzzcvuH9e1z3pYoJdV23LrKq8nmONGofPKKhwO+YcnI2TM0OKLrpAwbhWtgReun/Xpqqqnd74i3uQX8XuNitKdGJwkwxuXap2LnYsWLoGvYu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 09:57:48.7966 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b6c5edd-ad55-4ccf-38b0-08deb0d61703
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003441.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7460
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
index 54253d4dcc8d..ff45489c458e 100644
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
index 75796983f6a5..63da96c17e27 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.h
@@ -29,6 +29,8 @@
 #include <linux/memremap.h>
 
 struct amdgpu_device;
+struct amdgpu_bo;
+struct ttm_buffer_object;
 
 /*
  * AMDGPU_INTERCONNECT_VRAM - Protocol identifier for local VRAM access.
@@ -78,12 +80,22 @@ struct amdgpu_pagemap {
 
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
index 1fb956400696..78a677ff32bf 100644
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
index 714fd8d12ca5..5a45a29ef051 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -59,6 +59,7 @@
 #include "amdgpu_hmm.h"
 #include "amdgpu_atomfirmware.h"
 #include "amdgpu_res_cursor.h"
+#include "amdgpu_migrate.h"
 #include "bif/bif_4_1_d.h"
 
 MODULE_IMPORT_NS("DMA_BUF");
@@ -118,6 +119,15 @@ static void amdgpu_evict_flags(struct ttm_buffer_object *bo,
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
@@ -568,6 +578,16 @@ static int amdgpu_bo_move(struct ttm_buffer_object *bo, bool evict,
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

