Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CF11C55ABA
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 09:44:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BECA010E981;
	Tue,  4 Aug 2026 09:44:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="N8BZ9k+7";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010066.outbound.protection.outlook.com [52.101.56.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2A2C10E97F;
 Tue,  4 Aug 2026 09:44:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XsvNQWCqZ/8J2wCiAVU6B6Hv2Zcn/BVxOPwiaRXmww2dMrnYjGkkpX2fowHoP9WGC4lSTrfYOi1GX3O37uphRT1zDvrtBs/2VB3Mvl5PThgDV/7HPK5P2JSzn8XcyE6EPu85LG43AKuhRe9FnkosNe3qr1eWx/vXU5XDkD9Broakp0lAJNy0fq9vOLdC78jTcuW/+Y0stx8wy5QOMYd2AJhG5DjmKYPY+Iho2eLiKDmAX0N/4RrbErJ1+CIChNxWdRkGvN2r5GvXbBn0wtUSaGi2ondsSKKfsHXeIdEX/C50NlKVPn9gwg6iCuIbTVVmYv7vRyT3VT1lxKnjX+eVrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3PxNOgRS3rzkNt+FYxAaRFBt7+Zm+1zWgjaqJAodzXQ=;
 b=uNo0X0BQc7VZ4A3Mx5OYct51LVVT0r7Sw1GO8AQbkG2ksJQ9NQEqyLqJCoeScQ9LGp2/tB9we3Z0aYLgg42f3l7cFHACtL1EdO9qMSbvODL6zvxl1cMWZF/EILKNIJjM+sfg1w0CKhQzpEZk0EROjKchfe+FP/GAaFrBWwqcV1JjxE/dBSmv0iODi113mTUYr93vgQHGX2uU3jIwxbjG2VNpRRi6hawCp5gihV0nViO0Pce0YpA8wkokWNAjNidTYVnNEhf6W6kD23xVTzu0L+n5PaHw1dcE6ASxYpst1anOIzWvdv6Uz8nhstatGgH0bS+20gVuFjf/HfA7uCyR9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3PxNOgRS3rzkNt+FYxAaRFBt7+Zm+1zWgjaqJAodzXQ=;
 b=N8BZ9k+7v8LRZ8QSqdGqE/Rg8ks51RIZ3KtW7Ve0x5+3A+CnMbA8M1ZB7WNVQ9jWUNDBmERgnFRX7b9Xp+VH56AsCMYWnmCmxBVQwfzIVcTSFA/AXBCTNY9tIqYCr5U6b2XNc0Hh0DCAX1uvXrNeyFtL/1RWelmPv2bx1GuGL98=
Received: from MW4PR04CA0080.namprd04.prod.outlook.com (2603:10b6:303:6b::25)
 by DS7PR12MB6335.namprd12.prod.outlook.com (2603:10b6:8:94::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 09:44:29 +0000
Received: from CO1PEPF000066E8.namprd05.prod.outlook.com
 (2603:10b6:303:6b:cafe::3b) by MW4PR04CA0080.outlook.office365.com
 (2603:10b6:303:6b::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.16 via Frontend Transport; Tue, 4
 Aug 2026 09:44:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066E8.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Tue, 4 Aug 2026 09:44:29 +0000
Received: from hr-amd.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 4 Aug
 2026 04:44:24 -0500
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
Subject: [PATCH v9 18/18] drm/amdgpu: integrate VRAM migration into SVM fault
 and prefetch paths
Date: Tue, 4 Aug 2026 17:42:44 +0800
Message-ID: <20260804094246.1719318-19-ray.huang@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260804094246.1719318-1-ray.huang@amd.com>
References: <20260804094246.1719318-1-ray.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E8:EE_|DS7PR12MB6335:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c2ce4d5-5e07-4f6a-77ff-08def20cfa9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|1800799024|82310400026|18002099003|22082099003|5023799004|56012099006|11063799006|10067099003|921020;
X-Microsoft-Antispam-Message-Info: dtSNj1T+FsSAEy48xBA5zvRHBg2U9f3b+jubSnf1JEU5aq/Wg4hMvt/HfOKWK9MZg0khVy+gxa4eVPB4bQpnQcmRMYLYwBuFrzuPXUpREu4jCvm+nJMjZ/ksvrQ5P50IIiN+1gLZyYNsTqjSvy7sLyzyi+0/JvubXctKKv8VfeyHN9yjxKjWd7yLUN/WuLGONQjbQkJO/Zt0jPDgH7SlCUPCzPU7FaStfZB/w+4IwcyYWHS4srEiteShWiyxvbVamVuf2vnKsXYmAn98TioAExFoGR8ZkpUOM9auJWopkOEJBYulKZjVjlVNRsy9qjygqzJxLFWxZYxpcB5vAvOqb0dm3Qur+LYQtgZRnq8B5X6cNGz4djmkvgmN0zwF6UJmmyQoe2+VpmqZ1kKpHZm5jOoPL2x/3K+kbBqxn1p1hF/qaCGS5iHaOEc6Xc3qVez3iLCfuBuZtZ3YkJVBLGcFXPUfpkyjUN/e4ceExbJqgV+/EhJweOkuIxpZhApjRbvktLi5yHu9dzEcmaKAPUz3SXjW50cw+1lJfw6gwIXHIqyKHFcvwe7zpsPrWEhnCBmpPaaQ3GmeDuNu93i6uuOoxEXCJQshisQwvrzUspZ+IkX2FZUkA4Qd98Bpu40Uh6YgL1aJ7B4henAoDTn6mV53S/916S+HPiovLfOb5yhrmqlHH8BLxyQXyyPPs7VoWR5gyDTR2LmsSv41HdTEMuxi9tMAT7noDE+uF8psK2wmbzncRvYR62WMqRyJNHm7fAdQ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(1800799024)(82310400026)(18002099003)(22082099003)(5023799004)(56012099006)(11063799006)(10067099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pb0EvL5zZ4ARIEMu46+v66eJxeDwQAxUJet66SJb9zEZXJAFyoidxvW52hFIMQnB7hmNMOjKYqNQDx4aON3hvba1G0GSRnTXQfPtDkd9e0zKVhcTMn9GiKCJM9Mm6UeUxq2OsC4zTy3P2SV+jGWHVELVV8PmCSsJPOeismGuhzTwJi73tCC9uFhz3G4sE7MONw8cr3ifkoJeqxnVGd2fz7yRNQU5M4GF4fx7/vZvLNhLpIQSpch2221uFGLGXiK17RfQZW5rgU0TMIj1aqojfX9N9xMBjNXt1gPxOg7TlcM+FYmTx7PaDam7ciHGw96dlGquOSV+m7Gc1hKeFKRUANXvF7c3rjNWBiyQhxLnqSfWHriSx1t5yS177ZVLjVzHkcHCD7e9GnCKW6r2esoi37sHUHds6UdPYpa3yok7T5zO8UxHbmXdheHM2x40kAcv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 09:44:29.0064 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c2ce4d5-5e07-4f6a-77ff-08def20cfa9e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6335
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
index ac101574bd61d..8b3747e444f02 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c
@@ -35,6 +35,7 @@
 #include "amdgpu_svm_attr.h"
 #include "amdgpu_svm_fault.h"
 #include "amdgpu_svm_range.h"
+#include "amdgpu_svm_range_migrate.h"
 #include "amdgpu_vm.h"
 
 #if IS_ENABLED(CONFIG_DRM_AMDGPU_SVM)
@@ -314,7 +315,8 @@ bool amdgpu_svm_devmem_possible(struct amdgpu_svm *svm)
 	if (svm->adev->apu_prefer_gtt)
 		return false;
 
-	/* TODO: add amdgpu_pagemap_capable() */
+	if (amdgpu_pagemap_capable(svm))
+		return true;
 
 	return false;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h
index c67f01b3b5d3b..a28cce16cd9ac 100644
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
index f28b3eb14500d..6ac7e583c9bc5 100644
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
@@ -186,6 +188,8 @@ static int fault_map_range(struct amdgpu_svm *svm,
 		.check_pages_threshold = devmem_possible ? SZ_64K : 0,
 		.devmem_only = need_vram_migration,
 		.timeslice_ms = need_vram_migration ? 5 : 0,
+		.device_private_page_owner = devmem_possible ?
+			AMDGPU_PGMAP_OWNER(svm->adev) : NULL,
 	};
 	struct amdgpu_svm_range *range;
 	ktime_t timestamp = ktime_get_boottime();
@@ -255,7 +259,12 @@ static int fault_map_range(struct amdgpu_svm *svm,
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
index ed057545d0964..8ee83904fd532 100644
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
@@ -198,7 +200,8 @@ amdgpu_svm_range_update_gpu_range(struct amdgpu_svm *svm,
 		unsigned long start_page, last_page;
 		bool is_last_seg;
 
-		if (entry->proto != DRM_INTERCONNECT_SYSTEM)
+		if (entry->proto != DRM_INTERCONNECT_SYSTEM &&
+		    entry->proto != AMDGPU_INTERCONNECT_VRAM)
 			return -EOPNOTSUPP;
 
 		pte_flags = amdgpu_svm_range_attr_pte_flags(svm, attrs,
@@ -358,6 +361,8 @@ amdgpu_svm_range_map_attrs(struct amdgpu_svm *svm,
 		.devmem_possible = devmem_possible,
 		.devmem_only = need_vram_migration,
 		.check_pages_threshold = devmem_possible ? SZ_64K : 0,
+		.device_private_page_owner = devmem_possible ?
+			AMDGPU_PGMAP_OWNER(svm->adev) : NULL,
 	};
 
 	while (addr < end) {
@@ -380,12 +385,24 @@ amdgpu_svm_range_map_attrs(struct amdgpu_svm *svm,
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

