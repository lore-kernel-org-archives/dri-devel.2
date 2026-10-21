Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBE6606A319
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 03:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=YJhw1HWv
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B43810F8B0;
	Wed, 21 Oct 2026 03:01:17 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011036.outbound.protection.outlook.com [40.107.208.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7454010F8AC;
 Wed, 21 Oct 2026 03:01:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wu1NNcrSakfc3hZxSqotDk9nk0WBUb0diHEz587HMXK2MUuaFzDqB1X5RtwYPrlVza/AfXeLjbka5hprRK0nmUe0ozE/DnigGKH1AmfQ6hwSvTJlG6+Z7P1mntze0SfFJMfcy7/aXsBMmyywIo3Iayig/Q2Ce+WIMbZ5WcyiD4XVkWb1YAKgy5Jfaa8jz6i1ijAK5leIguV1p3rOG6RxLh+/zR9oP3J0vTSK0YMveK8xXjvrs3KfcKnagYj4JSSCSjWl+g4cAjgtT6X8H8c2OIfKI3Bv/mLOuWoQEQHOpUW1Qcb/iLPaEcFwnHkFxn4BN6z9oRU/70XmO8AyTP6Uag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ArskFdTslh2PaCGlEgjSmgw/rAcf5Bj77alrRhMJi5g=;
 b=Mwvpdh9W9NbB3+PS6/9b45s+lqVQlJBEaT998JBtmRaweUoazXUALV8fsrqLWC0FJttgCx8uikt755j6HRowjBQOgaU7LFUrqmjZq0BUoztZZVeUztYPoAuuoP7PWpTZP1QEgd89AnLCEkRpNJlgYBi8USN8iw3M4ZoVAkJXvDVHtdx/W2zpJntiDrhQb9IAXrMxRmAje47ei3zUXIrRKUrbFxulD7QR6G9sLCZI9vjeyHPg+hpBr/RosO5hNe7mNhUo9bYQS8qEEx2OIXigDwHMhBONopyaVLQL/5SESav5bGak10A309vaDjfqa5gyLkjXD2auAWcOdQtJWDK74g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ArskFdTslh2PaCGlEgjSmgw/rAcf5Bj77alrRhMJi5g=;
 b=YJhw1HWv2kpGFRbzPhh2oa1pOL5qUr0o8nVfXJu6M0mjRaeCYRjy/WnYo8NcXQZrRCDH5syVCG7GX41+mqaIFWciyXbWrDHB6fXyC9rNQtWNASJEJ9JFfzwswSwGSAcw8x0IR6o+JhQWPgwzOUduhXDL9xV6fsvkg8ie2Qsk0lo=
Received: from SJ0PR03CA0275.namprd03.prod.outlook.com (2603:10b6:a03:39e::10)
 by PH7PR12MB7795.namprd12.prod.outlook.com (2603:10b6:510:278::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 03:01:00 +0000
Received: from SJ5PEPF000001D2.namprd05.prod.outlook.com
 (2603:10b6:a03:39e:cafe::5a) by SJ0PR03CA0275.outlook.office365.com
 (2603:10b6:a03:39e::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.20 via Frontend Transport; Wed,
 21 Oct 2026 03:01:00 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D2.mail.protection.outlook.com (10.167.242.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 03:01:00 +0000
Received: from hr-amd.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 20 Oct
 2026 22:00:55 -0500
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
Subject: [PATCH v10 19/22] drm/amdgpu: implement synchronous TTM eviction for
 SVM BOs
Date: Wed, 21 Oct 2026 10:58:58 +0800
Message-ID: <20261021025915.2433837-20-ray.huang@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021025915.2433837-1-ray.huang@amd.com>
References: <20261021025915.2433837-1-ray.huang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D2:EE_|PH7PR12MB7795:EE_
X-MS-Office365-Filtering-Correlation-Id: ec25abb7-2a52-448f-9595-08df2f1f8979
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|23010399003|36860700016|921020|11063799006|5023799004|260925022911599003|260925021911599003|260925021311599003|261009223027099003|10067099003|22082099003|56012099006|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: injE0Q6VVLKSRRgM63yYbvGuir05qBgLNOBgAMp/vrgbWGrXFCFYe7J02cxcw0HWU0RNt2T0NwmJuY057VwLZgVxwXN0O4QChtrYcxSw/1zPLJDW5jvufa8bGpyV78xznTcQ3AMekEBJ34q9VHAvfW/cigMjP8qqnOO5GXg5frlXOQ/1/c/Hjvtv4hvuMUwvFE1BA0Wd+MZYMrU0AX5wHQniSeh0Ma+jKG4WoqjhbT0n1IBexL0U4cu8JGlZgoRxdyO/JKip474t/UI6IZgSSM8l3ZkH3NApUIacRCNMLu3cNN0Foz+HvXGG1970QOQpikVyaNPcQEbS4I2+XXY+7/nXz54xD2/0X2snIlZnriVPy/IzJHz3/+y5ii1Pc+bApVKTnOcQWgbNoG44ggHa4+eWrnukz+mgu6NEZs0tPDSoPRRycaHA0TecvU+hjj4YDVe3srnoOImOrjoRWf+Xeq8JfQ+5jV0Use94ZKOCXnQ1GAZxTR/c7/ktkE8bW6CMJrGhqrwlsmiYqfeyDVT0B1XmlF/IYGn+bByKwbcjh0HWbLRn3iKAdvvRaRVa44b1wiOXPX2eRjxy5li3tRZgx8T/bcwXUpD4ftjd/FqVHR41XsZkJWcEyza8FZ/6rfcUsW3CkpM4RoJwiYQBEpGsa79NESRlKX9RuWsiAI5U1z2eSBKSAEhui7Iu4IMyDgjOTx4H0md9zgg8Z1Oh6Gic9LuwfiXxYWY7eZnI4njhx2RGTSIGZHtQ9QmHb1hUXcMb
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(23010399003)(36860700016)(921020)(11063799006)(5023799004)(260925022911599003)(260925021911599003)(260925021311599003)(261009223027099003)(10067099003)(22082099003)(56012099006)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PHDIRl8YfnlmHdpVOEqsxihUJCdILPf01lOKrW1B67RacWA2obCWBWXlHzRoYnP5yEATIqth33DsnP3Cev0UGv29gBtPGSqcqrrhkUm7SR2ZfxaHJiHmoJHE5PfpGYGt9ITEcNUT/dp8iiW8LEQfpoCyNjrZn81c87SJHsjc2m4VhIm2qiC2H1oqZANqNyXOtmXYS05x1NftVk1xtSCYVZTHmM8hYWVMvCfB6IZTTAeap5kPcvs9+g23DOkMGxfO37mM55kpMej5Uuqvb1EbsOzPtnQPuM+yMdL63BbHv7IzdpfwPVIj2hqhMC6YGN0z5ixbhFnov0N5lPE3CTbUAdI2JWYerHL1jWtuPofa1YGOkKwPi4tT8kQRbEafFBphE1MBGH1X6IMLM3qen62V7ecsNGJDr2eTZRTziJybswReRTQYViylBvJvh7bnq57v
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 03:01:00.6194 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec25abb7-2a52-448f-9595-08df2f1f8979
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7795
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index 20daf2922e0f6..cd7483ad3cc3d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.c
@@ -64,6 +64,7 @@
 #include <drm/drm_pagemap.h>
 #include <linux/memremap.h>
 #include <linux/migrate.h>
+#include <linux/sched/mm.h>
 
 #include "amdgpu_migrate.h"
 #include "amdgpu.h"
@@ -597,6 +598,51 @@ static const struct drm_pagemap_devmem_ops amdgpu_pagemap_ops = {
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
index fc6d3fa62d794..2615946165bb1 100644
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
index 3d620ec2937f4..6f1b109b3fd83 100644
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
@@ -610,6 +620,16 @@ static int amdgpu_bo_move(struct ttm_buffer_object *bo, bool evict,
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

