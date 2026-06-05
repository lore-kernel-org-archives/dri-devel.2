Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2346CD6E7C
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 07:55:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3892011A54D;
	Fri,  5 Jun 2026 07:55:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3GdNvSd8";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012051.outbound.protection.outlook.com [52.101.43.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24B0B11A54C;
 Fri,  5 Jun 2026 07:55:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YcuNYqQtyYA1XI7uvBUUp2CjXity26cWE6rPyoLHWXaFsA+AGw5ldvdk7TdrHHQbAWvJpCTs6vflQXAPjOJMR78LYV1iXngQfFyVo9AIiAfgkNn2OhaPTQEkTR3dMET1hLj+B0HQPHDCqppRuzhM0H5QhqUUxWsGg/gUmW9CVRhV8iwpoHfBI+gKQYUJi3DVt08yoiUCW3smQCpwLmVd6ySj5etsBINtYFvIuHOuKertRxDReGzfN+vKia3jt1a+GDoFqF61Xe3uzn8e4HuTB2h3aqhdqJHYxmaz2B+lMiV2I9kq112qA0b9JzXNTfCr3rHnkhMPR0FTRj95HTpYqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VOgK7vXG6qhIQPCHwR/FFboJUp+otxN5DhpsiJV/gr0=;
 b=K6UX334Ig7eJOuzt43kU6dsCk9THTGQPiH3DG2sBQ+3nIQeMQXwOIlR9EXtUiWHiEb1I7UWAHTabLS9UGLD0V6eBAENg9gvLqYHG/qGQL99Xt1AQG7uvcTXN8foX297RtB47Q/bvAoxsIcPDlvIFHrBXXgdwo3unQBMGdWoNz/69jjpicbnwNRg4DiUcV9hQmWAdr+cM/j9sI1HxNZVrAULaFwx4proRXWt29V38ynIR1nJrmwA5qI1DHJuYsZTKvM3vSBJyG6rS2EfukoGR17zd8J08pW2VGBuCGKCga/S0TFGcaSQXP7eox5RxMA1+3EIFtEkXRkPZcLP8ZazPSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VOgK7vXG6qhIQPCHwR/FFboJUp+otxN5DhpsiJV/gr0=;
 b=3GdNvSd82SsmFtQv/peXW/7ibbqXjOR5Rcxap1CW6NGyO2icYMwvDlvau31pYSTK1hV5PtUTu0D7ueMb5xmc/zLZSMhB2y90K3/TT8OYg4vLiAhJJ2GXycRzA1RHIt8icstIMAZMwrbVXicMDc05gIXWhvWWdYO88AAZKS0fXXM=
Received: from BN9PR03CA0525.namprd03.prod.outlook.com (2603:10b6:408:131::20)
 by CY8PR12MB8066.namprd12.prod.outlook.com (2603:10b6:930:70::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 07:54:09 +0000
Received: from BN2PEPF000044A1.namprd02.prod.outlook.com
 (2603:10b6:408:131:cafe::58) by BN9PR03CA0525.outlook.office365.com
 (2603:10b6:408:131::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.8 via Frontend Transport; Fri, 5
 Jun 2026 07:54:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000044A1.mail.protection.outlook.com (10.167.243.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 5 Jun 2026 07:54:08 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 5 Jun
 2026 02:54:08 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 5 Jun
 2026 02:54:08 -0500
Received: from junhua-PC.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 5 Jun 2026 02:54:05 -0500
From: Junhua Shen <Junhua.Shen@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <honglei1.huang@amd.com>, <Lingshan.Zhu@amd.com>, <simona@ffwll.ch>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <Junhua.Shen@amd.com>
Subject: [PATCH v5 7/8] drm/amdgpu: integrate VRAM migration into SVM fault
 and prefetch paths
Date: Fri, 5 Jun 2026 15:53:39 +0800
Message-ID: <20260605075340.20199-8-Junhua.Shen@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260605075340.20199-1-Junhua.Shen@amd.com>
References: <20260605075340.20199-1-Junhua.Shen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A1:EE_|CY8PR12MB8066:EE_
X-MS-Office365-Filtering-Correlation-Id: 5479fd5d-2f3c-4b79-30f5-08dec2d79ff1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|921020|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: jT0ZLQROgSM/Fn1GeiIXu8j/MRuzvnfkyomADF7EMlTPz0rUnpMr6dIG+koHW1PYMIxR3VYXIxq3Q77Fw0tE0IJtbQGXQxv5vzqI5yE3AkILNHG8D+LEgrBVPu8D2joRazjUzVcwqI3knVNRcot6WrJoy4J/nrULM9ILcH8z19uiiKUuitl2j9v/+h1DUVZFA1npnPznM1wWvsXbbjovXnf2REenHQmAt3mRH/cmvU3/1dVSWiEownRGgXkdKJsbNVVneb6N+dstPNmUUZZpqM3Xn/SBqcj1F+NYW98Nq/2HnYXk8+IBBiio8a8UFU4n4oHiAt9ElmCL1gg4IyEo9VjHBupduOKTy4zeYxo4MVbA6d3znNIPWr9D4UMz/qLAdPoIOx2DlPoCT3qQr8R4kazxFCIfYY26XQYT407J6LN6nEsnSSlp8L6R8pazQqqP5loOuUCiq4vwqAkZ65OIfWlCwpS1g0uYjw2jHVp5CiWIPfyAu5viKvjEc/0Vi9yfk6Tnw5kBYIOi4ynTvfoprnBaSCCLPPeZoqKZTORPAPUVsYMa2H9xP40cJoPPFpQ+7J1W1RhBlsvP7GEvTbCfneRdGwDds1GwpwyF5aD3jP5QKs/15fFyFUy1xAAWsrV7n5032N8fWiO21DDj8PPqq0Ax8jpCKXO0g0E1T9Dl+tZg1SqueMVnXreHcFuJbwilHqeJIE2yLJOgy8fhr6SQSjlXE6P0LtFm0BrNQVHJx6Bav+it3xngiE8+RfryggJHZ/r3lp8J3zwcKjDGQp08uw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(921020)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: x+7hg8jx0abibfOyielUjHPU6UulESIitrg31u+6oJCRPZc3N8MzLZKQt40ERDZafPFuCog27CoZ9GPvHkGnEawNq65w0cOkc3N9GP3IrwXZV49Et5bfey4oaSIr2FZTZx46G8SI0SHCSSmRARCxsDDlpy9RJ09s6+bhQIMevoqV6ZGfm3INu1lJSy5vXr3uMG0rByfbmv9ObFXje0yK+YwfXoVAkf+TlFIDL/UxEKjZV5WQ0TZoT4EZsNuQmPR1bHmelOI5zEHAcovPhg5fyC5x3tEJevSEg9NUvFtVLsPBFm40wJ33bJboSs6jyog/qXrZo7abFEdjzNjKKC3HPlXWmeOKI90rgEGnOlMmEgFiZWLtzkF+aN7AllwaesivqENRcU1MT+xMiiwQtapAySw+hMJL96ePZ5Y3rfbwKmBL1sirbGx4hNji7qr6OBEE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 07:54:08.9893 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5479fd5d-2f3c-4b79-30f5-08dec2d79ff1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8066
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

- Call amdgpu_svm_range_migrate_to_vram() before GPU mapping in
  fault and prefetch paths when VRAM is preferred
- Add device_private_page_owner to drm_gpusvm_ctx for devmem awareness
- Allow AMDGPU_INTERCONNECT_VRAM entries in update_gpu_range proto check
- Skip valid-mapping fast path in prefetch when VRAM migration is
  requested, so prefetch can actively move pages to VRAM

Signed-off-by: Junhua Shen <Junhua.Shen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.c | 11 ++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c | 20 ++++++++++++++++---
 2 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.c
index 3f0c010e4e35..2acfcccd062d 100644
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
@@ -229,9 +233,12 @@ static int fault_map_range(struct amdgpu_svm *svm,
 	}
 
 	AMDGPU_SVM_RANGE_DEBUG(range, "PAGE FAULT");
-	/* TODO: add migration*/
+	if (need_vram_migration) {
+		AMDGPU_SVM_RANGE_DEBUG(range, "PAGE FAULT - MIGRATE PAGES");
+		amdgpu_svm_range_migrate_to_vram(svm, &range->base);
+	}
 
-	AMDGPU_SVM_RANGE_DEBUG(range, "GET PAGES");
+	AMDGPU_SVM_RANGE_DEBUG(range, "PAGE FAULT - GET PAGES");
 	ret = amdgpu_svm_range_get_pages(svm, &range->base, &map_ctx);
 	if (ret == -EOPNOTSUPP || ret == -EFAULT) {
 		/*
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
index 21a2b0c49c53..88923e6a0194 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
@@ -26,6 +26,7 @@
 #include "amdgpu_svm_attr.h"
 #include "amdgpu_svm_range.h"
 #include "amdgpu_svm_fault.h"
+#include "amdgpu_svm_range_migrate.h"
 #include "amdgpu_migrate.h"
 #include "amdgpu.h"
 #include "amdgpu_vm.h"
@@ -279,7 +280,8 @@ amdgpu_svm_range_update_gpu_range(struct amdgpu_svm *svm,
 		unsigned long start_page, last_page;
 		bool is_last_seg;
 
-		if (entry->proto != DRM_INTERCONNECT_SYSTEM)
+		if (entry->proto != DRM_INTERCONNECT_SYSTEM &&
+		    entry->proto != AMDGPU_INTERCONNECT_VRAM)
 			return -EOPNOTSUPP;
 
 		pte_flags = amdgpu_svm_range_attr_pte_flags(svm, attrs,
@@ -431,6 +433,8 @@ amdgpu_svm_range_map_attrs(struct amdgpu_svm *svm,
 		.devmem_possible = devmem_possible,
 		.devmem_only = need_vram_migration,
 		.check_pages_threshold = devmem_possible ? SZ_64K : 0,
+		.device_private_page_owner = devmem_possible ?
+			AMDGPU_PGMAP_OWNER(svm->adev) : NULL,
 	};
 
 	while (addr < end) {
@@ -453,12 +457,22 @@ amdgpu_svm_range_map_attrs(struct amdgpu_svm *svm,
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
+			AMDGPU_SVM_RANGE_DEBUG(range, "PREFETCH - MIGRATE PAGES");
+			amdgpu_svm_range_migrate_to_vram(svm, &range->base);
+		}
 
 		AMDGPU_SVM_RANGE_DEBUG(range, "GET PAGES");
 
-- 
2.34.1

