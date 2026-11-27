Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095AC606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 08:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=HMBBY274
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FA2711289B;
	Fri, 27 Nov 2026 08:43:57 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010025.outbound.protection.outlook.com [52.101.56.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1EB4112893;
 Fri, 27 Nov 2026 08:43:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=amarvqcZ3soCha3bkkd8QnVwxm/gdCepbcCtsC2Z7+poJ0Te80X+R+UJhcwIsq/QStzBox+KpM4jKK2/AkewWrvonAUdtEjX5EEbMJm85DExNu4MrQv7LsJ7yVKrcwMXjekpjQebOf20TODY/aTPyOKkY0GH/28CQ92VichG4LRImmSUHhFYOmZ8EivA/P75zOp5cyeXx9MHeI8hbLKebTgh1Nsj8J3cWYmRKj9nc/pHRffF+bHe7FfK5YBt36rYw8yV6w6MifHDNSVg42SCLLbADjyn6kCBgAa5bsRJzEv0fq+L6WslIhl2O+sYDzTMv9ikK9tQeVRhlkfBf1eLjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g3xaGJxLAx+ZPojwstDflOpqi8gIugrOhTdjwj23voI=;
 b=BEINoGzfMUoJTFDit6qoqUIn/Ja+gqiWbKxNR0EVDZ0hJ4h+d4eGxeALXyp607qfBXSOL85Dqp1auqZycscwc/ulkB43KrKLZkIBQDcDBrmQyRl6HOOjgKwcAa89VHIS94VQup/Hv8qXdYovuRw5wS8ELoKoC3DxkDpOb2QpGZ1m8s7QcjiGrZdxDScQ7qk3fD1RnxnDeC/ffzTS+eSUwkx7Z5HrDhGUoPMbkPKPCOlQZ/8OKUw2n9xh95uorWppPbe/sQwTz1MdpX/qfmfjXWrNdIZCE6kYD5L+IyRA6UayCaM8OKx6m8M9p28X14TKdRdLlcTQt+SfY7zfauIGcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g3xaGJxLAx+ZPojwstDflOpqi8gIugrOhTdjwj23voI=;
 b=HMBBY274xHKn+I2EgDOzRYqi9CnLTMwS9MwNHdR+MdhiJlC2oDB+VAWLgA8hDKnUw/FyLw7Vi0MsunS5OeAExA61QQshQMcc/ju8AsHjVksjNyTAb38Pt3t0IPtbNp2fJrsvL0gEV5tE9UaHT6GKvDpHS7C78CrPXhxXqDdZ4Pg=
Received: from CH0PR13CA0017.namprd13.prod.outlook.com (2603:10b6:610:b1::22)
 by PH8PR12MB7112.namprd12.prod.outlook.com (2603:10b6:510:22c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.5; Fri, 27 Nov
 2026 08:43:42 +0000
Received: from CH2PEPF000166C1.namprd04.prod.outlook.com
 (2603:10b6:610:b1:cafe::78) by CH0PR13CA0017.outlook.office365.com
 (2603:10b6:610:b1::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.688.4 via Frontend Transport; Fri, 27
 Nov 2026 08:43:41 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF000166C1.mail.protection.outlook.com (10.167.252.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.5 via Frontend Transport; Fri, 27 Nov 2026 08:43:41 +0000
Received: from hr-amd.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 27 Nov
 2026 02:43:35 -0600
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
Subject: [PATCH v11 22/22] drm/amdgpu: integrate VRAM migration into SVM fault
 and prefetch paths
Date: Fri, 27 Nov 2026 16:41:45 +0800
Message-ID: <20261127084149.925625-23-ray.huang@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261127084149.925625-1-ray.huang@amd.com>
References: <20261127084149.925625-1-ray.huang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF000166C1:EE_|PH8PR12MB7112:EE_
X-MS-Office365-Filtering-Correlation-Id: 8aa241e3-aabe-461a-8787-08df4c628a23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|23010399003|376014|36860700016|18002099003|22082099003|921020|56012099006|5023799004|261022075727099003|11063799006|261026121527099003|261021123027099003|261102123227099003|261009223027099003|261021121427099003|10067099003;
X-Microsoft-Antispam-Message-Info: w2fOXYmiwGZ3CkAt6pzBJOdLItK9rjGuy7wyW0ytFvhnO3aiHV40rlZddzkoJ6aYOTnDAe81n733CWBKBEq9ABWW3t8XosyTcl1z9hiKApHGae1qBlCzj6gQauMLggD3Xfwk2jahKE9jq++jPJ2ElrQRIUulZljiVrKF+9IR7GNx18YoHBJq6QwmF26WjQsIsnR0NOgerl1bj7Y1dfxzAdpwLSAKKzb3nOAgWvtxg2ubrBRMTMtrq1EibkxHjUaxdQjCOojOJK/FpbXT0zcSqVl1lYTElm0XiTmxbpTAktGmNdc+YpwirTtBlPMCzwzuadrWNX+pu3+sgGpxphO1VtBMugQz6ri9mCV7uLskoPUpIIzWiEeRPw4weDYng8ZeDi4Q0wyArNmO80aXuRp4lABVSKeDgUr8LkwwQLnNzYzbIzg/l9VCX+O670D7HJmNpXwUbGJy2rGLehlcA5DULk21qgdw9NxhOuB7JL9qkLkg1U2sE3J/KQB9i3L7PyqsA843y/hrNbnED67ZpuXXTfnsNaaPXXxi7k6xBW27pkJaKcCtrA8q4UCBPZeePtUyeU/L2Qv42lGWKGx7LswRgbZCksTGJYUwqmdlq5sjNNAxspthmWeDRTWzEvdayAjxIVWg/KjW58BRfFEk5kubQl/YweowwfuP9CkocQNe/1hX8j2obbvALEsDJ5ZZr9zk/Yyn83HyYKPQt6Jhyx7Zbg3GW/ZxU77vC8gFRQe1qwB18I5zSwNiqPuQ+18tYvgg
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(23010399003)(376014)(36860700016)(18002099003)(22082099003)(921020)(56012099006)(5023799004)(261022075727099003)(11063799006)(261026121527099003)(261021123027099003)(261102123227099003)(261009223027099003)(261021121427099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: f8enatE0mgqrgWTYhUygz5dOsN6PYJbebBih1VWAf6AKabfjihhx1oO7Qkd33aqCkdGAxTgEvgAyOZ8gNlf8pfFZnFuLQqQ2iLY2QUtVHV+lHtkb7lyiFYgPH+TIZ0mPy3nQwwNceafPDQCnNDwQ+N70rJCYarZGGyJWErAzdft2zLHtE3UXE3AT40T5gLZ0MTkEvuAgjLkGjOIRGn5Tt81fAySp/XFvqdwAdhZykL64V4pdcHIeDT7i1WAyBJsZeWj14IV8jJMYPMhVRtMz80FMeufhsWRf8zF9nYO5YmBIvY61NGuHzCKVExbr5Pj4KjgbWXj28fatSJ4jxT6JBic2JAiV0wZ6GFeA01BMOtY1R/+pEw/4NiIWA6ARYtgtxeNgqRiSW4zt7JXlsC8T+CT89ZEwW3MSiOXhpWLepByd5uDwWs7ns0/+jtSqNy//
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 08:43:41.7437 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aa241e3-aabe-461a-8787-08df4c628a23
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF000166C1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7112
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c       |  4 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h       |  3 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.c | 11 ++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c | 32 ++++++++++++++++---
 4 files changed, 41 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c
index 8036ee189269f..206a0364b07c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c
@@ -35,6 +35,7 @@
 #include "amdgpu_svm_attr.h"
 #include "amdgpu_svm_fault.h"
 #include "amdgpu_svm_range.h"
+#include "amdgpu_svm_range_migrate.h"
 #include "amdgpu_vm.h"
 
 #if IS_ENABLED(CONFIG_DRM_AMDGPU_SVM)
@@ -300,7 +301,8 @@ bool amdgpu_svm_devmem_possible(struct amdgpu_svm *svm)
 	if (svm->adev->apu_prefer_gtt)
 		return false;
 
-	/* TODO: add amdgpu_pagemap_capable() */
+	if (amdgpu_pagemap_capable(svm))
+		return true;
 
 	return false;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h
index e8a9df974988e..48f0a399d5324 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h
@@ -45,9 +45,6 @@ struct amdgpu_svm_attrs;
 struct drm_device;
 struct drm_file;
 
-#define AMDGPU_INTERCONNECT_VRAM DRM_INTERCONNECT_DRIVER
-#define AMDGPU_INTERCONNECT_P2P (AMDGPU_INTERCONNECT_VRAM + 1)
-
 enum amdgpu_svm_xnack_mode {
 	AMDGPU_SVM_XNACK_OFF,
 	AMDGPU_SVM_XNACK_ON,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.c
index aabe11cf88aed..6ef3f2a5c54e2 100644
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
@@ -189,6 +191,8 @@ static int fault_map_range(struct amdgpu_svm *svm, unsigned long fault_addr,
 		.check_pages_threshold = devmem_possible ? SZ_64K : 0,
 		.devmem_only = need_vram_migration,
 		.timeslice_ms = need_vram_migration ? 5 : 0,
+		.device_private_page_owner = devmem_possible ?
+			AMDGPU_PGMAP_OWNER(svm->adev) : NULL,
 	};
 	struct amdgpu_svm_range *range;
 	ktime_t timestamp = ktime_get_boottime();
@@ -251,7 +255,12 @@ static int fault_map_range(struct amdgpu_svm *svm, unsigned long fault_addr,
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
index adb9a0730ebf4..fe2a46f608a95 100644
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
@@ -125,11 +127,19 @@ int amdgpu_svm_range_update_gpu_range(struct amdgpu_svm *svm, struct amdgpu_svm_
 		unsigned long start_page, last_page;
 		bool is_last_seg;
 
-		if (entry->proto != DRM_INTERCONNECT_SYSTEM)
+		if (entry->proto == DRM_INTERCONNECT_SYSTEM) {
+			pte_mem.mem_type = TTM_PL_TT;
+			pte_flags |= AMDGPU_PTE_SYSTEM | AMDGPU_PTE_SNOOPED;
+		} else if (entry->proto == AMDGPU_INTERCONNECT_VRAM) {
+			pte_mem.mem_type = TTM_PL_VRAM;
+		} else {
 			return -EOPNOTSUPP;
-		pte_flags |= AMDGPU_PTE_SYSTEM | AMDGPU_PTE_SNOOPED;
+		}
 
-		amdgpu_gmc_get_vm_pte(svm->adev, svm->vm, &pte_mem, vm_flags, &dst, &pte_flags);
+		/* VRAM entries already carry vram_base_offset from device_map */
+		amdgpu_gmc_get_vm_pte(svm->adev, svm->vm, &pte_mem, vm_flags,
+				      entry->proto == AMDGPU_INTERCONNECT_VRAM ? NULL : &dst,
+				      &pte_flags);
 
 		start_page = range_start_page + mapped_pages;
 		last_page = start_page + seg_pages - 1;
@@ -280,6 +290,8 @@ int amdgpu_svm_range_map_attrs(struct amdgpu_svm *svm, const struct amdgpu_svm_a
 		.devmem_possible = devmem_possible,
 		.devmem_only = need_vram_migration,
 		.check_pages_threshold = devmem_possible ? SZ_64K : 0,
+		.device_private_page_owner = devmem_possible ?
+			AMDGPU_PGMAP_OWNER(svm->adev) : NULL,
 	};
 
 	if (!amdgpu_svm_attr_has_access(attrs->access))
@@ -302,7 +314,14 @@ int amdgpu_svm_range_map_attrs(struct amdgpu_svm *svm, const struct amdgpu_svm_a
 		if (next_addr <= addr)
 			return -EINVAL;
 
-		if (amdgpu_svm_range_is_valid(range, attrs) && !prefetch_sysmem) {
+		/*
+		 * Prefetch to device memory should still run migration logic even if
+		 * the current GPU mapping is already valid. This allows prefetch
+		 * requests to actively move backing pages to VRAM instead of being
+		 * skipped by the valid-mapping fast path.
+		 */
+		if (amdgpu_svm_range_is_valid(range, attrs) && !prefetch_sysmem &&
+		    !need_vram_migration) {
 			addr = next_addr;
 			continue;
 		}
@@ -311,6 +330,11 @@ int amdgpu_svm_range_map_attrs(struct amdgpu_svm *svm, const struct amdgpu_svm_a
 			ret = drm_gpusvm_range_evict(&svm->gpusvm, &range->base);
 			if (ret)
 				return ret;
+		} else if (need_vram_migration) {
+			AMDGPU_SVM_RANGE_TRACE(range, "MIGRATE PAGES");
+			ret = amdgpu_svm_range_migrate_to_vram(svm, &range->base);
+			if (ret)
+				return ret;
 		}
 
 		AMDGPU_SVM_RANGE_TRACE(range, "GET PAGES");
-- 
2.53.0

