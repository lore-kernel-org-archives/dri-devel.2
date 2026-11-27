Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E25606A31E
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 08:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=d1Gvxu/V
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3FA9112890;
	Fri, 27 Nov 2026 08:43:36 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012063.outbound.protection.outlook.com
 [40.93.195.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1E5C11288D;
 Fri, 27 Nov 2026 08:43:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e3XUKotLfZnujLT+wtJjOSCKaSUuWwCSGFK0HDKL77m5dwOHrcs4ao8SDFb+s7IwyWM9P83l4lFnPM77rlXBZetZTbvqpPGkGwJN+INh8ODKKoCh8icoAxC/suZnZ8APNpg3qHe2ipsOqR9xGRVLgAaDaqoCOH62QT4WeZ815S4JDD05JanQHNmKrHuGuK8avtKQxSxa+L5gihVMeY2WlydWW3c6tiP1E3F9Ny3TaBWW4tsT4NM0j8dIHh6WF5exFfawdk3jJxTJGWctNRmjblCv6Ri/s42I6HTFDwxWCaXrQT293imS6RtS29R+0BXLSeU8G3+iufUGgF1nQzIDQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rAvGAuhSp+KsQNRSLzg0McH71g7nLGe1UpMzcbvsaz0=;
 b=tNzQ5lxR379hwP36B2GNurqPgf9lk/pY2vAAFVU46ACMhGTmpseRsiPu2IYglqmNSHw51SVqNx2g87Bbc0yiwhhHw/SZqvlq2q2LDJnaWyvGeEUySUxjbfNP8QMQmiZwfjOiHi03mONoj9jBX5u6lATzVSYpIe2ufowZ7P2GsNnw4ILBz4OK5jUc7zPXb2E6wcMNjwyDCRAr9hNlHSPzi6inPhTi/MUSo2P/twsHLK2kNGAEGTdqNA3HtvNL3gXXNFtoJ+B8ZylBe0I++Vl9barju0xTGo5WU72iwoFSOuHn2lQGX0H5BA6iBiOCM/P8PsKcsGRFW7PGLY6SdIGgGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rAvGAuhSp+KsQNRSLzg0McH71g7nLGe1UpMzcbvsaz0=;
 b=d1Gvxu/Vj5ONXxcvHIzvMTvLNgm12aR7UrWnhLzXh1ugKC09gwQZlfxyfVldrd0Alxzg4AOe/L4aaXnhzrgHuKrD8nVfZXFhVG3KHs21mYRjDRZnmpUwZxIS6JoyLFUzQZTayiaRCAPk9jesKY6f6rW4I2AZZ6rnaGxbtjTcCy4=
Received: from CH5P223CA0019.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::6)
 by DS0PR12MB8294.namprd12.prod.outlook.com (2603:10b6:8:f4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Fri, 27 Nov
 2026 08:43:25 +0000
Received: from CH2PEPF000166BB.namprd04.prod.outlook.com
 (2603:10b6:610:1f3:cafe::44) by CH5P223CA0019.outlook.office365.com
 (2603:10b6:610:1f3::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.10 via Frontend Transport; Fri,
 27 Nov 2026 08:43:25 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF000166BB.mail.protection.outlook.com (10.167.252.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.5 via Frontend Transport; Fri, 27 Nov 2026 08:43:25 +0000
Received: from hr-amd.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 27 Nov
 2026 02:43:20 -0600
From: Huang Rui <ray.huang@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Philip Yang
 <Philip.Yang@amd.com>, Alex Deucher <alexander.deucher@amd.com>, "Felix
 Kuehling" <felix.kuehling@amd.com>, Simona Vetter <simona@ffwll.ch>, "Matthew
 Brost" <matthew.brost@intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Aveline Noir <jm5905938@gmail.com>, <amd-gfx@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>
CC: Xiaogang Chen <xiaogang.chen@amd.com>, Oak Zeng <Oak.Zeng@amd.com>, "Jenny
 Liu" <Jenny-Jing.Liu@amd.com>, Zhu Lingshan <lingshan.zhu@amd.com>,
 "Honglei
 Huang" <honglei1.huang@amd.com>, Junhua Shen <Junhua.Shen@amd.com>, Yiru Ma
 <yiru.ma@amd.com>, Huang Rui <ray.huang@amd.com>
Subject: [PATCH v11 19/22] drm/amdgpu: implement synchronous TTM eviction for
 SVM BOs
Date: Fri, 27 Nov 2026 16:41:42 +0800
Message-ID: <20261127084149.925625-20-ray.huang@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261127084149.925625-1-ray.huang@amd.com>
References: <20261127084149.925625-1-ray.huang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF000166BB:EE_|DS0PR12MB8294:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d857121-f932-4fda-8ad4-08df4c628089
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|23010399003|6133799003|261009223027099003|22082099003|18002099003|261021121427099003|261022105027099003|921020|261026140227099003|261026121527099003|261028144727099003|56012099006|261021123027099003|261102123227099003|10067099003|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info: nRdBrH6vYvqVshwBgO4g6X2/3l04+0pBmlk+5HPZYCw/fcVV1SvlJOBFaxpXL9ZwJk05HPoyn7XJX0PiOcZ22Y5u9mpETRsSq70Oc8rxncKd7DQ2ezUE8/+qSY+q5Lwbko+jVfLiGTOiwdBUp17/FSRPocpMPBhOW4Dtrk+Xr22rYExXh/Ew9zNsTS3hVtd0PR4RppsymYdMaADrQ9wVAwP9qwFCDSpWx2wYnbigE+NcFgvcjmhUGn0ps0UmoPHVyTGZgv4ybWCgbYFAAxXouK26hqGRyrW4dVVVCMPDuzZ2UeDRNrQWlahhAdmU1jwvv3scpePzol5vgfrkSeLtQiyuqoKnlQct8qdndQBc3Qw/Rm/VJdTxqJXWlvslJt5pzsIY8ygDI+3Ktb4qN1kVuIlm3Ok77uxOYejX6OpGUcafbQh6NiuKeOXD+DvsAaPQf1lspJco0Cn9xEBxxlOoMEwBFp/1t39qa4opT1zeQiFV/nAhpxZGnoJDyUHZ22e/QbfvsPM1KD/+s2D6la64wHlJGCI56jpH0EmI2n5fUdsjgs6EjRsj17flSW0mPQ3wEbXo6b3pvr6Tn6pBGpvlwEOWSqF+1iMFJj8FKvSG+kDYZyn0YnUhO/NgkQPgAlkQJwNBHyAh8RADj9lPYZUMJwFnOY9o6dgXyuVHCI/9gCoofinbKlDOIu/wKyEmk58DzemIMNrT+T5HrAa2pEjqi92utGOBL4wpKab4CJWfmkJt/IiI82lIDzMypSVOjuG3
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(23010399003)(6133799003)(261009223027099003)(22082099003)(18002099003)(261021121427099003)(261022105027099003)(921020)(261026140227099003)(261026121527099003)(261028144727099003)(56012099006)(261021123027099003)(261102123227099003)(10067099003)(11063799006)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +oQ+GNVaRLGVJNrK33yAW5oyDdmM2jfMcG2f9Ly8++Pyr3fGS0dKOeaGRKSik51pJNzyfTfwy8zAsgL+C/7vUVBEd+NRM+7v1zwXYJCuz+Z0aFeCAtUsnmUEZFdu1O/QHU0/B4VQwvvmFo4eqCrdcL9lOlFHIgvZwFPAPQ+AuDIUEGD06hNEyFv00VDb81j8NzFIzXHC0x+JJFS8k8w+EhGT/ssTLqxvHYRpHuj4ch0/wmPqSfVawdzDiAmfbamdDwaCK+T7Ad6X1a4wT3mMld8ijFhD1PoEN3a48A/lfKPm7GXMYGS3ELtGAhEDXJlFhusa+hwqFe9jf3CqmNHAuIj9BKxGkp5VJrgGcCM5tWonvlgMtfMTLRV3vhOQ1eqF3A89vck4S5D0hCC/ypbRDXOqeBaaGZaTipPv43og8S10KP/HbDBtZHHFyfxJsw+c
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 08:43:25.6340 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d857121-f932-4fda-8ad4-08df4c628089
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF000166BB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8294
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
 drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.c | 46 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.h | 12 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c  |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c     | 20 +++++++++
 4 files changed, 81 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.c
index e7d2c6167adb1..5fbc6d1317743 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.c
@@ -64,6 +64,7 @@
 #include <drm/drm_pagemap.h>
 #include <linux/memremap.h>
 #include <linux/migrate.h>
+#include <linux/sched/mm.h>
 
 #include "amdgpu_migrate.h"
 #include "amdgpu.h"
@@ -598,6 +599,51 @@ static const struct drm_pagemap_devmem_ops amdgpu_pagemap_ops = {
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
+	struct mm_struct *mm = sbo->devmem.mm;
+	int r;
+
+	/*
+	 * If the owning process is exiting, there is nothing to migrate; return
+	 * -EBUSY so the TTM eviction LRU walk skips this BO instead of aborting
+	 * the whole walk (which would fail the allocation that triggered the
+	 * eviction). Hold an mm reference across the call so the framework's own
+	 * dead-mm path stays unreachable and any -EFAULT it returns is
+	 * unambiguously a real error.
+	 */
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
index 6aa895f63aeaf..1ddba17712ad3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -44,6 +44,7 @@
 #include "amdgpu_vm.h"
 #include "amdgpu_dma_buf.h"
 #include "kfd_svm.h"
+#include "amdgpu_migrate.h"
 
 /**
  * DOC: amdgpu_object
@@ -95,7 +96,8 @@ bool amdgpu_bo_is_amdgpu_bo(struct ttm_buffer_object *bo)
 {
 	if (bo->destroy == &amdgpu_bo_destroy ||
 	    bo->destroy == &amdgpu_bo_user_destroy ||
-	    bo->destroy == &svm_range_bo_destroy)
+	    bo->destroy == &svm_range_bo_destroy ||
+	    amdgpu_svm_bo_is_svm(bo))
 		return true;
 
 	return false;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 8dfa92967b630..e81bd39ab4ff2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -60,6 +60,7 @@
 #include "amdgpu_hmm.h"
 #include "amdgpu_atomfirmware.h"
 #include "amdgpu_res_cursor.h"
+#include "amdgpu_migrate.h"
 #include "bif/bif_4_1_d.h"
 #include "kfd_svm.h"
 
@@ -123,6 +124,15 @@ static void amdgpu_evict_flags(struct ttm_buffer_object *bo,
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
@@ -611,6 +621,16 @@ static int amdgpu_bo_move(struct ttm_buffer_object *bo, bool evict,
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

