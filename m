Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E618CD4F2C
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 09:11:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95AF910F3AE;
	Fri, 12 Jun 2026 09:11:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="c/Jl8f4M";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011069.outbound.protection.outlook.com [52.101.57.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E54710F3AC;
 Fri, 12 Jun 2026 09:11:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hJYpCF0ZmqPUWNCpUJYamvvdqAFGTPC7t79jT5of1qQ0aMDWsHh6FOVWJ2rhEF4OGomftD7jrTxaBhtVzGCsl75akni/LvzepNb6l28Pcd5D7xSY8Ygo5d65o5JymtWI0poWfUv1X8jHo6ivnJc8R4kWbz7mdBVPepC/wiQMPSLzdDgjvOHlQgz+B7BRlOSD6N46MMjHhMH6fVuLAt3sIg9APQmVmiJfa9lGJBXhjH6BkgwBblkSeqDu6Xl4m92pqRqwJJRNpyD89ouyxN5GH1JqiwbqHfkc1xqQm6Gt1qyB0Cg4quWYBsQ5ekZOeZ9FaaFPRcWKmL8Xjr3G1a47nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ow0h/3RL4RJ6Y/4DPb0QDXcGhbqlHN/gMfsRsH9mVKU=;
 b=Q6Odtb9QPRrd45Bq7qTHNScu+KOk1HOC/ct2p7Wm5zAZBvdOI99MxAzj4X9+r1xN8JAwnqCdg/XxYi9CAJebRp1RdXB85kRRMyyswSCAAZABsRc5cPlRiTSft/0acyJopzbrU/5s5QrjPdjsR2sTVOFgNRpY1btRSIDa870VVBXzVf8Cz/0KL8+IZ8DwM77CLhpFrxlWHrtpS/jC6g5myeN9HoQ93w16eihE/HES7t3UQgmSbSj8dZfDeLSmnlEtF08kSK867gzzHUMvsI7O3ifJYYIuKcjQBqGvD/z+sC2S1Sc83IQR1kwG3HowUBDbI2eWIkKYueV+RoSi4xIOYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ow0h/3RL4RJ6Y/4DPb0QDXcGhbqlHN/gMfsRsH9mVKU=;
 b=c/Jl8f4MAy9NXqXQZ53YPbWdXto29AHLuoaEnnC7LYlb5ZpfDN4f+H+p+WC7yy09CjMTfMX3vBcJi6FDW5BV0seneM7ZLDe+QmKxoUsk1RHxm0/xCJDzZ+TSbnyDQTc1xrDYPXB4+GkSyZ/h75HEHF2cchnPSv9NPPWt9Z/V5RQ=
Received: from CH0PR04CA0070.namprd04.prod.outlook.com (2603:10b6:610:74::15)
 by BY1PR12MB8445.namprd12.prod.outlook.com (2603:10b6:a03:523::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Fri, 12 Jun
 2026 09:11:29 +0000
Received: from CH1PEPF0000AD7E.namprd04.prod.outlook.com
 (2603:10b6:610:74:cafe::98) by CH0PR04CA0070.outlook.office365.com
 (2603:10b6:610:74::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.15 via Frontend Transport; Fri,
 12 Jun 2026 09:11:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7E.mail.protection.outlook.com (10.167.244.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Fri, 12 Jun 2026 09:11:29 +0000
Received: from hr-amd.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 12 Jun
 2026 04:11:20 -0500
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
Subject: [PATCH v8 18/18] drm/amdgpu: integrate VRAM migration into SVM fault
 and prefetch paths
Date: Fri, 12 Jun 2026 17:09:20 +0800
Message-ID: <20260612090928.29682-19-ray.huang@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260612090928.29682-1-ray.huang@amd.com>
References: <20260612090928.29682-1-ray.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7E:EE_|BY1PR12MB8445:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e3ebd98-126f-4d75-98a6-08dec86296c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|23010399003|921020|22082099003|18002099003|56012099006|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info: fuQkZTAbiZDSjxZ4D4CJSEKwUJOGhKqzh5tpY9cwNwq8ytRC9jRDKUvedjIqWzrwl7o2/qV38inDShG/b9zBN/gdnHrGGOKk+dWRukZvA3MhZiK5sLZXUgtfrCFdZAYcYIJzAiXCydfk9Vh30MQxZv+oo1EbPhnlAEtElf3YREfyFvEUAz9dPL8PTCLppdQD53f+WXm4smi9rjJvojw7tOs45bM601wvCcgw8YDWgOPUyuAsXeTMXT9R0HlcpOvDeMOzgx8XIPXJlXZC4YvOy979UgbBz0+2uBd0kOwMFuZaCD5oLohS9C+HISGBys7hZTA5jqxFFedCpO+3Yls+biLZwnPNS/44C6rAI/i9jJQ1WLX06GU3irevSZCjIQuH8lnAz55Oe1i7Nr7dNfJkxfYxEpMKm1cRiWfB53Mr70eTiQC+39qyxGdDadZ4M3tFwxl5OvUCULlOwoyS8Kc4dKPG4W4aGQVePcp1huM4nmS8qZYKGiQQmvCyLR6qqSl5HyAUi35HcBv/JwIFe0/q1Gwf500RrJx0zhRuyOeogw/KQ7x44ByAaDP5cu16f29MmVaKYFR1R6vyfdvhzk7nc4zCpigAVNsEb2Vh7bDrb+ZWQ4C8xOKhUyqiVaY5Rckz4r7C7BZLJizzjDwBjo03mc5UfWr1zrcTHswxCEXCUToUnqfwxsi1NxckqFAitLSvlvjCRvHs7JSqXICgEZbvq9xosyDwcf7/giu0EsQ+D8OKct6DbAISVf/mqb9cN9+UpSprVmexJfJ0mBVttndVHw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(23010399003)(921020)(22082099003)(18002099003)(56012099006)(5023799004)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ttaawoe8vc7aWUZ/r0+TVemwfu4y+heAQ3IXG6RI/3bqCd/WgufdPpFEyNqN5ccJGEFuvW27ldCr7NZloAi8x43I12DZC72+VnnZ7hBdrfeKjt92uJWiFG78JcvsJvCAMnpCSHDnu0sPUGIN4NtWH3Or57SIFRaDS9/VLNsETx+p7hNUzq6DKzzf2A3zxjDg6gp+hXLo1xSaOHrkr4EQctvS8q2uHGaoJiBLJ9t199t5IPlz6Xo4vm3hGOMKQyTbJKb+to1QDNGrkx+tjnZ58/CTNBTo3uqGYPOnKR1lZ21D8itOigGY9s3YhwnL+6T3kH+F7kkez9O9Yi+sX3z36ThMFCTFbykOcQDgTerZqGhfnfMd2zxwA+qqWQXsQ3jafRTpzOgk7wXA7ws1WXTlk62Qvz80MmCuqB+BDeCBIQq7FJ0Fy0sWuDaXpjAgBx1a
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 09:11:29.4875 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e3ebd98-126f-4d75-98a6-08dec86296c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR12MB8445
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
index 9d25357de5d3c..c785d22fe5bea 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c
@@ -35,6 +35,7 @@
 #include "amdgpu_svm_attr.h"
 #include "amdgpu_svm_fault.h"
 #include "amdgpu_svm_range.h"
+#include "amdgpu_svm_range_migrate.h"
 #include "amdgpu_vm.h"
 
 #if IS_ENABLED(CONFIG_DRM_AMDGPU_SVM)
@@ -308,7 +309,8 @@ bool amdgpu_svm_devmem_possible(struct amdgpu_svm *svm)
 	if (svm->adev->apu_prefer_gtt)
 		return false;
 
-	/* TODO: add amdgpu_pagemap_capable() */
+	if (amdgpu_pagemap_capable(svm))
+		return true;
 
 	return false;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h
index ac84b80f750f8..0cab194263588 100644
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
index a92a1a4f2436f..4bb72d32794cb 100644
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
@@ -160,6 +162,8 @@ static int fault_map_range(struct amdgpu_svm *svm,
 		.check_pages_threshold = devmem_possible ? SZ_64K : 0,
 		.devmem_only = need_vram_migration,
 		.timeslice_ms = need_vram_migration ? 5 : 0,
+		.device_private_page_owner = devmem_possible ?
+			AMDGPU_PGMAP_OWNER(svm->adev) : NULL,
 	};
 	struct amdgpu_svm_range *range;
 	ktime_t timestamp = ktime_get_boottime();
@@ -229,7 +233,12 @@ static int fault_map_range(struct amdgpu_svm *svm,
 	}
 
 	AMDGPU_SVM_RANGE_DEBUG(range, "PAGE FAULT");
-	/* TODO: add migration*/
+	if (need_vram_migration) {
+		AMDGPU_SVM_RANGE_DEBUG(range, "MIGRATE PAGES");
+		ret = amdgpu_svm_range_migrate_to_vram(svm, &range->base);
+		if (ret)
+			return ret;
+	}
 
 	AMDGPU_SVM_RANGE_DEBUG(range, "GET PAGES");
 	ret = amdgpu_svm_range_get_pages(svm, &range->base, &map_ctx);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
index 6ac785a3b5cba..62b4e0c306682 100644
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
 
@@ -275,7 +277,8 @@ amdgpu_svm_range_update_gpu_range(struct amdgpu_svm *svm,
 		unsigned long start_page, last_page;
 		bool is_last_seg;
 
-		if (entry->proto != DRM_INTERCONNECT_SYSTEM)
+		if (entry->proto != DRM_INTERCONNECT_SYSTEM &&
+		    entry->proto != AMDGPU_INTERCONNECT_VRAM)
 			return -EOPNOTSUPP;
 
 		pte_flags = amdgpu_svm_range_attr_pte_flags(svm, attrs,
@@ -427,6 +430,8 @@ amdgpu_svm_range_map_attrs(struct amdgpu_svm *svm,
 		.devmem_possible = devmem_possible,
 		.devmem_only = need_vram_migration,
 		.check_pages_threshold = devmem_possible ? SZ_64K : 0,
+		.device_private_page_owner = devmem_possible ?
+			AMDGPU_PGMAP_OWNER(svm->adev) : NULL,
 	};
 
 	while (addr < end) {
@@ -449,12 +454,24 @@ amdgpu_svm_range_map_attrs(struct amdgpu_svm *svm,
 		if (next_addr <= addr)
 			return -EINVAL;
 
-		if (amdgpu_svm_range_is_valid(svm, range, attrs)) {
+		/*
+		 * Prefetch to device memory should still run migration logic even if
+		 * the current GPU mapping is already valid. This allows prefetch
+		 * requests to actively move backing pages to VRAM instead of being
+		 * skipped by the valid-mapping fast path.
+		 */
+		if (amdgpu_svm_range_is_valid(svm, range, attrs) &&
+		    !need_vram_migration) {
 			addr = next_addr;
 			continue;
 		}
 
-		/* TODO: add migration */
+		if (need_vram_migration) {
+			AMDGPU_SVM_RANGE_DEBUG(range, "MIGRATE PAGES");
+			ret = amdgpu_svm_range_migrate_to_vram(svm, &range->base);
+			if (ret)
+				return ret;
+		}
 
 		AMDGPU_SVM_RANGE_DEBUG(range, "GET PAGES");
 
-- 
2.53.0

