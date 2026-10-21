Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD3D606A31A
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 03:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=AQJLaCiI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBF5D10F8B9;
	Wed, 21 Oct 2026 03:02:37 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012002.outbound.protection.outlook.com [52.101.53.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28F3610F8BA;
 Wed, 21 Oct 2026 03:02:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KEuEZENDwEQ2664iTolG09QF2ah163PaeeR+Bonc6WwiKfLU9ejwfOE/5pxP4aZueIhkmPHiH12Wv/rlOHNUema2wXOCOpXVCnaR6juSQWYx5jFMT2Qu+ridCUHXqaRiGfJfoumXksjE3HNuZqh5VJD9JMc/ttwcJFhv7gdSQJc7FDa9rA93SYphDa3xaPNVBjLxnV3D2MPmTssoF3+dxBFGgtKJUALl1HcyvISjdGoa+JaVCbeyots5NE1JCulaz7Z0gwnCBxLWttU+Y563eOr9SrRM0gZulP1hLY4rvp35jyNt1tFGW4Xe+XRXSlT01DyegDUXPZ0CWj4WETrMTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LBwI/SqG2Sudc5OjxOCA7IMCNKxPunbWV/Epvj8I5+0=;
 b=PohPynSYkY4C70L+jtklDrchmUAX/nVM/p3i/lL4vlKab2IZfFkcHKBHlO+JZcRw/GLwNJe/+XnCc49wm/yEk4pStvrgn6HLpNWpijJW6BrhoTm9A+Aru/5/TGw6kU8nbb3AQIzWiGD199l0Qv9pz+rn1R2F+8jCiFiJWgCWFK0/ri+U6lNs4C+p8RGC5Xr3atLnK9RgR6ghgVFClW025rx9zhSGKQxH3w3LHJoTjKZptZSJI0uDUtjpH2tEX9RLzMaLUt5+pFRpNkMZqS6ztSjXdo8log2Uo22MRLyjtoKP22cb1Pc/beMmo0DjkqJ12CUaWrrbxtobubGCEk/gvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LBwI/SqG2Sudc5OjxOCA7IMCNKxPunbWV/Epvj8I5+0=;
 b=AQJLaCiIFy95ITZCAhr6u/83h5ZVvWxjeuXL1Y8TDm8gA4G1zQSjt56uaj2l0QNn9DGKfyG1GC+PmbsTnCqEmoLWzLOErabFGybAO7RamLERREXGOOykyU2gvJ2ChjMXzk+jUMd7wZnvN7y9tQymEi0U6/gBe05iBtYhrXfFjMs=
Received: from SJ0PR13CA0113.namprd13.prod.outlook.com (2603:10b6:a03:2c5::28)
 by PH7PR12MB6719.namprd12.prod.outlook.com (2603:10b6:510:1b2::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 03:02:26 +0000
Received: from SJ5PEPF000001D0.namprd05.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::6e) by SJ0PR13CA0113.outlook.office365.com
 (2603:10b6:a03:2c5::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.15 via Frontend Transport; Wed,
 21 Oct 2026 03:02:25 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D0.mail.protection.outlook.com (10.167.242.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 03:02:25 +0000
Received: from hr-amd.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 20 Oct
 2026 22:02:14 -0500
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
Subject: [PATCH v10 22/22] drm/amdgpu: integrate VRAM migration into SVM fault
 and prefetch paths
Date: Wed, 21 Oct 2026 10:59:01 +0800
Message-ID: <20261021025915.2433837-23-ray.huang@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021025915.2433837-1-ray.huang@amd.com>
References: <20261021025915.2433837-1-ray.huang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D0:EE_|PH7PR12MB6719:EE_
X-MS-Office365-Filtering-Correlation-Id: a300e6e5-7eb2-4ca6-3e23-08df2f1fbc4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|36860700016|82310400026|260925021311599003|56012099006|921020|260925022911599003|260925021911599003|11063799006|5023799004|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: V6aWlCdohFbHh5wH32Lt+SqlTRsuH6u9js5UKux4l12EigLfUHW+99iMNsfbxHA1XhvEprqP/AdQ5+lsDOe+TMPr+LhhZjUPJbYIKTSEig/LDS3+C/nCn3ZVEcZK5tshSgILF+BWt86+fBupTVNMqVqKtV42Oq+UdhAbvXORz3E+HdUIXrSsSTSHWFiwFRD8d2n30L6ppzwu2Ffvw2hzDZYfv7xYiFSC5dOHBN4eoF+1SgVMYT0CoeT8mW2XgyaZC2gjyqGh2lwDDckXWbYaev0jxkaptrfIBGYToru9L+GY4F7tw248E9UGGaro7sAdweokZMIDSgkTP7wElPQH+BykEoiEisyfuLSULSzyhljRyzpPCU2K0iErDnQHcIQjv6E7f52gmq/W6IVYxaD6ns24SFLrGasy2/KF8cJljzXfsYscckoU+yQp6Gl2pvGdf3dZ6G5FMEB/TYZbp/ugraDZ7AbwKMBZ4z4Um241LC9DNj28fcJEwk7hBZpxbmYDp+gYtfGVTQ/MLBGMwLc64YR+URHXeBOW4OwFx50dUaqZ0DGhSQlTkCQ6zOYgwU0Ogkk1t4Qfv83h+lyzT9D9SpfmwECbTsVj1vBRbQ2Yy+0xwRqoeaBirRcitKACI/MFd2gml1OJ9xWLcetNb7FKzAr9RVwX9FZ5fqgZ+LdCsgYX2FQDL3p1gsu9NDThN/vZs+hHXfSPLw2JDoHvpPeauqvquwmK06iZeum7wEYS70SMlNt07ZYyzAMXlXzK6aIk
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(36860700016)(82310400026)(260925021311599003)(56012099006)(921020)(260925022911599003)(260925021911599003)(11063799006)(5023799004)(261009223027099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jmS9MB7xZL1uPy5/moZAjvzQOm8NltEsb9dGZhX01tS7ze1F+2h1xRBJEZKDNmMyP4S9lUqfbLAjE4O8T5Yw+uoUOlpQgsTZxjh+AzGvPjbJwamuCF9GhwMoW4TE//JqiWer7Rr8ltnpcPbst5PaR95Q9B2J3nH2hfQRs5hMDr0P2lMGuLunzNqsr/D1WgewRNKhsXRGEq0Opf4/JjlSZcFbdMADpk2mSIbqRjNhJ7k1YIbMCAwvcZ61+GkLFM3gCy5qfBUl1Rqfug355YmDVz49A/EKK+ew0MYI1cIBLDVD1pHfOpAlSYmfrDJFxRkawqNtDnDgdEigY2JZnKR6Kx7J5T4uhDQ4fsxcrHjJi/qjjnZDe+1CPmz+bo33ZJsxF0TsesemVq1zF5TzmJLqR/I95vRp8+8zJ9gLwaNK3v0U66p95i8dTwSJnkPOlI5u
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 03:02:25.8451 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a300e6e5-7eb2-4ca6-3e23-08df2f1fbc4f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6719
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

- Call amdgpu_svm_range_migrate_to_vram() before GPU mapping in
  fault and prefetch paths when VRAM migration is needed
- Set device_private_page_owner in drm_gpusvm_ctx for devmem awareness
- Allow AMDGPU_INTERCONNECT_VRAM entries in update_gpu_range proto check
- Skip valid-mapping fast path in prefetch when VRAM migration is
  requested, so prefetch can actively move pages to VRAM
- Enable amdgpu_pagemap_capable() check in amdgpu_svm_devmem_possible()
- Move AMDGPU_INTERCONNECT_VRAM/P2P defines to migration header

Signed-off-by: Junhua Shen <Junhua.Shen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c       |  4 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h       |  3 ---
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.c | 11 ++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c | 23 ++++++++++++++++---
 4 files changed, 33 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c
index 5ae8a649644ec..31d0786012934 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c
@@ -35,6 +35,7 @@
 #include "amdgpu_svm_attr.h"
 #include "amdgpu_svm_fault.h"
 #include "amdgpu_svm_range.h"
+#include "amdgpu_svm_range_migrate.h"
 #include "amdgpu_vm.h"
 
 #if IS_ENABLED(CONFIG_DRM_AMDGPU_SVM)
@@ -320,7 +321,8 @@ bool amdgpu_svm_devmem_possible(struct amdgpu_svm *svm)
 	if (svm->adev->apu_prefer_gtt)
 		return false;
 
-	/* TODO: add amdgpu_pagemap_capable() */
+	if (amdgpu_pagemap_capable(svm))
+		return true;
 
 	return false;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h
index cfdc4e6d045b7..e3ebd865d0732 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h
@@ -45,9 +45,6 @@ struct amdgpu_svm_attrs;
 struct drm_device;
 struct drm_file;
 
-#define AMDGPU_INTERCONNECT_VRAM	DRM_INTERCONNECT_DRIVER
-#define AMDGPU_INTERCONNECT_P2P		(AMDGPU_INTERCONNECT_VRAM + 1)
-
 enum amdgpu_svm_xnack_mode {
 	AMDGPU_SVM_XNACK_OFF,
 	AMDGPU_SVM_XNACK_ON,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.c
index 2dd77fe78303c..c135a3f74d313 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.c
@@ -26,6 +26,8 @@
 #include "amdgpu_svm_attr.h"
 #include "amdgpu_svm_fault.h"
 #include "amdgpu_svm_range.h"
+#include "amdgpu_svm_range_migrate.h"
+#include "amdgpu_migrate.h"
 #include "amdgpu.h"
 #include "amdgpu_vm.h"
 #include "amdgpu_gmc.h"
@@ -193,6 +195,8 @@ static int fault_map_range(struct amdgpu_svm *svm,
 		.check_pages_threshold = devmem_possible ? SZ_64K : 0,
 		.devmem_only = need_vram_migration,
 		.timeslice_ms = need_vram_migration ? 5 : 0,
+		.device_private_page_owner = devmem_possible ?
+			AMDGPU_PGMAP_OWNER(svm->adev) : NULL,
 	};
 	struct amdgpu_svm_range *range;
 	ktime_t timestamp = ktime_get_boottime();
@@ -265,7 +269,12 @@ static int fault_map_range(struct amdgpu_svm *svm,
 	}
 
 	AMDGPU_SVM_RANGE_TRACE(range, "PAGE FAULT");
-	/* TODO: add migration*/
+	if (need_vram_migration) {
+		AMDGPU_SVM_RANGE_TRACE(range, "MIGRATE PAGES");
+		ret = amdgpu_svm_range_migrate_to_vram(svm, &range->base);
+		if (ret)
+			return ret;
+	}
 
 	AMDGPU_SVM_RANGE_TRACE(range, "GET PAGES");
 	ret = amdgpu_svm_range_get_pages(svm, &range->base, &map_ctx);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
index 787afe0767e5a..2bcd9cbeb3037 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
@@ -26,6 +26,8 @@
 #include "amdgpu_svm_attr.h"
 #include "amdgpu_svm_range.h"
 #include "amdgpu_svm_fault.h"
+#include "amdgpu_svm_range_migrate.h"
+#include "amdgpu_migrate.h"
 #include "amdgpu.h"
 #include "amdgpu_vm.h"
 #include "amdgpu_trace.h"
@@ -196,7 +198,8 @@ amdgpu_svm_range_update_gpu_range(struct amdgpu_svm *svm,
 		unsigned long start_page, last_page;
 		bool is_last_seg;
 
-		if (entry->proto != DRM_INTERCONNECT_SYSTEM)
+		if (entry->proto != DRM_INTERCONNECT_SYSTEM &&
+		    entry->proto != AMDGPU_INTERCONNECT_VRAM)
 			return -EOPNOTSUPP;
 
 		pte_flags = amdgpu_svm_range_attr_pte_flags(svm, attrs,
@@ -351,6 +354,8 @@ amdgpu_svm_range_map_attrs(struct amdgpu_svm *svm,
 		.devmem_possible = devmem_possible,
 		.devmem_only = need_vram_migration,
 		.check_pages_threshold = devmem_possible ? SZ_64K : 0,
+		.device_private_page_owner = devmem_possible ?
+			AMDGPU_PGMAP_OWNER(svm->adev) : NULL,
 	};
 
 	while (addr < end) {
@@ -372,12 +377,24 @@ amdgpu_svm_range_map_attrs(struct amdgpu_svm *svm,
 		if (next_addr <= addr)
 			return -EINVAL;
 
-		if (amdgpu_svm_range_is_valid(range, attrs)) {
+		/*
+		 * Prefetch to device memory should still run migration logic even if
+		 * the current GPU mapping is already valid. This allows prefetch
+		 * requests to actively move backing pages to VRAM instead of being
+		 * skipped by the valid-mapping fast path.
+		 */
+		if (amdgpu_svm_range_is_valid(range, attrs) &&
+		    !need_vram_migration) {
 			addr = next_addr;
 			continue;
 		}
 
-		/* TODO: add migration */
+		if (need_vram_migration) {
+			AMDGPU_SVM_RANGE_TRACE(range, "MIGRATE PAGES");
+			ret = amdgpu_svm_range_migrate_to_vram(svm, &range->base);
+			if (ret)
+				return ret;
+		}
 
 		AMDGPU_SVM_RANGE_TRACE(range, "GET PAGES");
 
-- 
2.53.0

