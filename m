Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4F1DCD4F35
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 09:58:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B97F210EDA8;
	Wed, 13 May 2026 09:58:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1gqpVT59";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012071.outbound.protection.outlook.com
 [40.93.195.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63DC510EDCC;
 Wed, 13 May 2026 09:58:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u32sFvFE5LAXNHcfDloZdBF5fQS2Ovn0OPjBkBt5CPfAEA8jEg5UXh4ZtkPBzgHx35GyTOEJNpXYn0jJdABXr/iXc1ZBJ/RNYLPAjNmN/WrgWsReeAy/JZ/HQYjEdxJmtr0H3fmC78ZB6cFvUJdhLZug7T9HTszKl+7p/ODahwPWggp2zWbnMke+zZ4ljilgpTrCcOQJz+3yI+pSdECCsNrZKujUkY59FoldUN/anTK2sliM487y+YZHPL3QXkEkOiJj9vmFKf2ancD1qYg/t8EGEHYH5A2rgYaoA1S1edJ1PGbV3tVuZOm0gZYFHuM4RCsXkgtCP4WSDVnmo9a/OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9WcF04G3QlTdL2H24xABUnXHem0M9RkYdvz3iNV6EJk=;
 b=rNMyeHviyFvBZg5AHu4tSJ8gBwNZYQ4eDATeM/8iPH/3Xb108VaeSWJe/UPdoj13qm26igQ6axaN8qWjRj/Mjn7smLH2BpIKd0edJoKkHnGtGnm0IZss5C12sTV4BNd9GzMUqsCAZr/Q6w50aMvawLUCtwmzWKzk2RtSZK59UahnVDdUk/t+lTntOR2q8jC6EWvXaGfLJoMOaI5zff1hoYhVnQpSOq6f5jny6SW41HCbWprjW8IkHCVX1fyfO+VkQ3LRtf9wiCg+0IhurJvRaXKyT+Zpxsx879QxLwWIL2U3zQkOiv9kUyDpGn4DnekG02ks/x048joiiYoUOnm0Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9WcF04G3QlTdL2H24xABUnXHem0M9RkYdvz3iNV6EJk=;
 b=1gqpVT59A1hIHNM9xsca9ZdC5tpXjPNGHTKZSLhCT6vLGn7IE9Vu5ax/6nWHTsMcGdv60vAcz0k5Ph3IqTLBNCnSwv9d2c3CS+ZmLUbWzO2DdpdvL112izW+HxEZ2l4nkEGBcghOfmMqQhea7Lz2i1g8yZp0AaolfgVms6A/f0g=
Received: from DS7P220CA0073.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:259::7) by
 DS0PR12MB9446.namprd12.prod.outlook.com (2603:10b6:8:192::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.23; Wed, 13 May 2026 09:57:58 +0000
Received: from DS2PEPF00003444.namprd04.prod.outlook.com
 (2603:10b6:8:259:cafe::f9) by DS7P220CA0073.outlook.office365.com
 (2603:10b6:8:259::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.12 via Frontend Transport; Wed,
 13 May 2026 09:57:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00003444.mail.protection.outlook.com (10.167.17.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Wed, 13 May 2026 09:57:58 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 13 May
 2026 04:57:58 -0500
Received: from junhua-PC.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 13 May 2026 04:57:55 -0500
From: Junhua Shen <Junhua.Shen@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <honglei1.huang@amd.com>, <Lingshan.Zhu@amd.com>, <simona@ffwll.ch>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <Junhua.Shen@amd.com>
Subject: [PATCH v4 6/6] drm/amdgpu: integrate VRAM migration into SVM range
 map and fault paths
Date: Wed, 13 May 2026 17:57:34 +0800
Message-ID: <20260513095734.69598-7-Junhua.Shen@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260513095734.69598-1-Junhua.Shen@amd.com>
References: <20260513095734.69598-1-Junhua.Shen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003444:EE_|DS0PR12MB9446:EE_
X-MS-Office365-Filtering-Correlation-Id: e3cd8346-a441-4950-6083-08deb0d61cfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|56012099003|921020|18002099003|22082099003|11063799003;
X-Microsoft-Antispam-Message-Info: XXgswftcnj+S5rmEPkD8q+hcYDYAlEOWC1hkUM9sjA8KXAtaONGI11UbAs5KPdWdbdTCwjdY66V/7kJ9wCZsIy6IQU6uX8Vvjn5U58eIwvwnoHZSdffn0A5iR34AarraxsfjWXr+8QM89fhenhgfarzlyxl0t9mnu7C5V4mtUJ/ClMqbdl3RZZUGoZabz8wULKHmAZRNYKdGZbxH6ZzswqIJTXRD/Ogik5Rt+T6JrUsXPaFKT5YrOe3yuICiGNtRjTkAw1WZS8myPFoOInfH6UxgT7iXQpafxBW8Saf/AC6jY6vDj2/guZ/sweyu7xNviZs++vyj9tmtoSaCcAQDtGuMZA4qtZCtLHtvhfU95PRHOewgoYnHtrjMcmoAl1w52ebPdH70XikgAHVmFH/sMIMCDeOyK3O8l2Y0/tJuT8CMMfknCcp8PGtk3Ar1Al7BsPEvKLDKUZ/GZG3w8t+lGkW3/CDaBRX1xTez7UJQ3rdtPDNBOoN/tjwLzjNBeuIc9P0P1tBBLLdIPc0VbSCEq8NnNqGPHM5AE5R24VLl6KvVnjpRUO0AQMmweqn1GBithpNlafk2hMSaJFoSOcSNGkP+wG4cvewLTvYYnWTMcR/E+7cVN09MLmvzoZzaASEQysE6g4c7j6emRtTuwv2SUMHgqsh0YrnsYVxdF4WFmzNG3+DR8OSlrLgeE/baLLfIjaNNYDJqoMEno3oDNFsNmsEKn8jmuwtamB7PZGeRNnjiKn0sR203AfRmlsW7/cYaf+EBSBWajqtZQ8LHRSpEHg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(56012099003)(921020)(18002099003)(22082099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lkYsvV0vXD1uf7HgAftUYFVS5+0TeGd2k0NP4M1CojmO/RMbEv3GCyonlzN61mU373R473pq9W4sLHksaiHb5wFLGRNphOBGBPc9/xo+RjmlOAG5E5cjQaK0rkgiXg1YCM6ijL+mwf5jZNqnYsYjpwUghju2dWp4gAMP2FaolyKEz/zTTaMl7cyotlnZNRumozl1X03me2/QBgSX0Y/35Mkoe/AZvEesFNYRGhmLtdF+vaKT5+/Obv7ffUhL5RRUQIKNvjSr1LCazZRkLMNDvkIZVVNezrmxIv76iUBlmDWLiEuDwmSQGYZTW7gp+Uc+iOvyzESC7KPo5ddjeS5CrybqMzQOUAnwiXxmeXOdLOSzYC7/TYNTGIxnXh9tIyWB1u7rrcpS7MKZfDfqWNCXPDN9AIB71j9OcYkgDdfmL2mVOOvcSwEUWgIDVSdQ4abN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 09:57:58.8373 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3cd8346-a441-4950-6083-08deb0d61cfd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003444.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9446
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

Wire the migration layer into the SVM range map and GPU fault
call chains:

- Add amdgpu_pagemap_capable() guard in amdgpu_svm_attr_devmem_possible()
  to disable devmem when pagemap is not supported
- Add device_private_page_owner to drm_gpusvm_ctx in both prefetch
  and fault map contexts
- Call amdgpu_svm_range_migrate_range() before GPU mapping in both
  fault and prefetch paths to perform VRAM migration when preferred
- Support AMDGPU_INTERCONNECT_VRAM in amdgpu_svm_range_update_gpu_range()
  by clearing AMDGPU_PTE_SYSTEM and AMDGPU_PTE_SNOOPED flags for
  VRAM pages

Signed-off-by: Junhua Shen <Junhua.Shen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c  |  4 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.c |  9 ++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c | 21 +++++++++++++++----
 3 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c
index e50b67540c99..115bda12e625 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c
@@ -25,6 +25,7 @@
 #include "amdgpu_svm.h"
 #include "amdgpu_svm_attr.h"
 #include "amdgpu.h"
+#include "amdgpu_svm_range_migrate.h"
 
 #include <linux/err.h>
 #include <linux/errno.h>
@@ -55,6 +56,9 @@ struct attr_get_ctx {
 bool amdgpu_svm_attr_devmem_possible(struct amdgpu_svm *svm,
 				     const struct amdgpu_svm_attrs *attrs)
 {
+	if (!amdgpu_pagemap_capable(svm))
+		return false;
+
 	if (svm->adev->apu_prefer_gtt)
 		return false;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.c
index 7763eb029eaa..b5d21a66a228 100644
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
@@ -153,13 +155,14 @@ static int amdgpu_svm_range_map_fault(struct amdgpu_svm *svm,
 	const struct amdgpu_svm_attrs *attrs = &attr_range->attrs;
 	bool devmem_possible = amdgpu_svm_attr_devmem_possible(svm, attrs);
 	bool need_vram_migration = amdgpu_svm_attr_prefer_vram(svm, attrs);
-	devmem_possible = false; /* TODO: add migration */
 	struct drm_gpusvm_ctx map_ctx = {
 		.read_only = !!(attrs->flags & AMDGPU_SVM_ATTR_BIT_GPU_RO),
 		.devmem_possible = devmem_possible,
 		.check_pages_threshold = devmem_possible ? SZ_64K : 0,
 		.devmem_only = need_vram_migration && devmem_possible,
 		.timeslice_ms = need_vram_migration && devmem_possible ? 5 : 0,
+		.device_private_page_owner = devmem_possible ?
+			AMDGPU_PGMAP_OWNER(svm->adev) : NULL,
 	};
 	struct amdgpu_svm_range *range;
 	ktime_t timestamp = ktime_get_boottime();
@@ -228,7 +231,9 @@ static int amdgpu_svm_range_map_fault(struct amdgpu_svm *svm,
 	}
 
 	AMDGPU_SVM_RANGE_DEBUG(range, "PAGE FAULT");
-	/* TODO: add migration*/
+	if (need_vram_migration)
+		amdgpu_svm_range_migrate_range(svm, &range->base,
+					      AMDGPU_SVM_MIGRATE_TO_VRAM);
 
 	AMDGPU_SVM_RANGE_DEBUG(range, "GET PAGES");
 	ret = amdgpu_svm_range_get_pages(svm, &range->base, &map_ctx);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
index fe543a16b399..b77f3a52f3ae 100644
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
 
@@ -244,9 +246,11 @@ amdgpu_svm_range_update_gpu_range(struct amdgpu_svm *svm,
 		unsigned long seg_pages = min_t(unsigned long, 1UL << entry->order,
 						npages - mapped_pages);
 		unsigned long start_page, last_page;
+		uint64_t seg_pte_flags = pte_flags;
 		bool is_last_seg;
 
-		if (entry->proto != DRM_INTERCONNECT_SYSTEM)
+		if (entry->proto != DRM_INTERCONNECT_SYSTEM &&
+		    entry->proto != AMDGPU_INTERCONNECT_VRAM)
 			return -EOPNOTSUPP;
 
 		start_page = range_start_page + mapped_pages;
@@ -254,9 +258,13 @@ amdgpu_svm_range_update_gpu_range(struct amdgpu_svm *svm,
 		mapped_pages += seg_pages;
 		is_last_seg = mapped_pages == npages;
 
+		/* For VRAM pages, clear the SYSTEM and SNOOPED bits */
+		if (entry->proto == AMDGPU_INTERCONNECT_VRAM)
+			seg_pte_flags &= ~(AMDGPU_PTE_SYSTEM | AMDGPU_PTE_SNOOPED);
+
 		ret = amdgpu_vm_update_range(svm->adev, svm->vm, false, false,
 					     flush_tlb && is_last_seg, true, NULL,
-					     start_page, last_page, pte_flags,
+					     start_page, last_page, seg_pte_flags,
 					     0, entry->addr, NULL, NULL,
 					     wait_fence && is_last_seg ? fence : NULL);
 		if (ret)
@@ -365,12 +373,13 @@ amdgpu_svm_range_map_attrs(struct amdgpu_svm *svm,
 	int ret;
 	bool devmem_possible = amdgpu_svm_attr_devmem_possible(svm, attrs);
 	bool need_vram_migration = amdgpu_svm_attr_prefer_vram(svm, attrs);
-	devmem_possible = false; /* TODO: add migration */
 	struct drm_gpusvm_ctx map_ctx = {
 		.read_only = !!(attrs->flags & AMDGPU_SVM_ATTR_BIT_GPU_RO),
 		.devmem_possible = devmem_possible,
 		.devmem_only = need_vram_migration && devmem_possible,
 		.check_pages_threshold = devmem_possible ? SZ_64K : 0,
+		.device_private_page_owner = devmem_possible ?
+			AMDGPU_PGMAP_OWNER(svm->adev) : NULL,
 	};
 
 	while (addr < end) {
@@ -399,7 +408,11 @@ amdgpu_svm_range_map_attrs(struct amdgpu_svm *svm,
 			continue;
 		}
 
-		/* TODO: add migration */
+		if (need_vram_migration) {
+			AMDGPU_SVM_RANGE_DEBUG(range, "PREFETCH - MIGRATION PAGES");
+			amdgpu_svm_range_migrate_range(svm, &range->base,
+						      AMDGPU_SVM_MIGRATE_TO_VRAM);
+		}
 
 		AMDGPU_SVM_RANGE_DEBUG(range, "PREFETCH - GET PAGES");
 
-- 
2.34.1

