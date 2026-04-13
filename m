Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58CB3EBFD36
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 10:31:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF12010E3F7;
	Mon, 13 Apr 2026 10:31:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="q2lPTx75";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010005.outbound.protection.outlook.com [52.101.56.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7F9610E3FF;
 Mon, 13 Apr 2026 10:31:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EzJvnwn03SbvkAoGPzoMRZ+DYEx2FkQ0zUVFE+sIxcszYwk96tt9ZbNZVfA+Tg+epZ+NvqP5MbBAIINjX71jmI0jqafcYSkY49gRyHNvIJo+JNxK9Try6XfwcprN0OwOkzzRreT4KJsKQtKOf/nVH0WL6bb7HTd90cb81/5XZHoxuETaE9Ro14f+y7uLf7CrtZjhqBKN1cblzQkbzCuK+khRwks1yjiJKAnshsFUGkV7zyonAy2jgprYkw6TmQfex6CHJyVCzclJgJn2FY1n3+RjjT/tujsjmOODHPlYtr2vbW/jPcBOxxHei8+DqoDzQqcrcgG/SkDlmbY2HILGfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hEsaIBgCGOYdU7tFl/WB6YOsrL3iZYhdqa9sAVn3frk=;
 b=HzLNtRJxu79eTvB5wDXAeuZ3JTBs72VWADQ+82dNACh7g21+XH1984Wjmi2jMwZYr/fb6zNplynrwwNh9Sq50A3F/o5qep+fgVYD+n8509qub2uqzrt/k2RqwqaXo5yahX/9pedQYnnNayByMI4lfJJ2Pbdgg5icjDZowSrYDmsGzy5/KF6YAaumtRs36Jtpik1XSJO6xBpoW/zO+Nr28LKJobtu7RNibTpDzhJeSI58vLt3MdbP4lF1LvlTyvUWk1apkbKvMVuhivoHA8xWe68mEygVfJKA2RLb6YG8NN2Y444Vf3MzepzGvBzyDhk49fotLWoPC0585AY2ZhlUnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hEsaIBgCGOYdU7tFl/WB6YOsrL3iZYhdqa9sAVn3frk=;
 b=q2lPTx75lPG9oM9g61PQsrZEcrZpR9u731zaCCdcW+wawdeNXWbPQ0ip8OVYhjjO5KEzr5oxiAD6856tt59TCFBN303qvv+Oa5sL4kW/f33HoPCVBBeU3Jj0GaVpaLRsltLZ5VLV8jgJzjuu3nlql17WYSbK1Gq6TImm0/fSnH0=
Received: from MN0PR03CA0025.namprd03.prod.outlook.com (2603:10b6:208:52f::9)
 by PH7PR12MB5904.namprd12.prod.outlook.com (2603:10b6:510:1d8::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Mon, 13 Apr
 2026 10:30:54 +0000
Received: from BN1PEPF00006002.namprd05.prod.outlook.com
 (2603:10b6:208:52f:cafe::a5) by MN0PR03CA0025.outlook.office365.com
 (2603:10b6:208:52f::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Mon,
 13 Apr 2026 10:30:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00006002.mail.protection.outlook.com (10.167.243.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Mon, 13 Apr 2026 10:30:53 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 13 Apr
 2026 05:30:52 -0500
Received: from junhua-PC.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 13 Apr 2026 05:30:49 -0500
From: Junhua Shen <Junhua.Shen@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <honglei1.huang@amd.com>, <Lingshan.Zhu@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <junhshen@amd.com>, Junhua Shen <Junhua.Shen@amd.com>
Subject: [PATCH v2 5/5] drm/amdgpu: integrate VRAM migration into SVM range
 map path
Date: Mon, 13 Apr 2026 18:30:31 +0800
Message-ID: <20260413103031.181953-6-Junhua.Shen@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260413103031.181953-1-Junhua.Shen@amd.com>
References: <20260413103031.181953-1-Junhua.Shen@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006002:EE_|PH7PR12MB5904:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c39d355-b603-4c00-4685-08de9947bd7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|56012099003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K2NHckRDc1ZOalBHa0tzemh4RTg4c0JlQWNXWE9BZUZOcllzUGFJcWgvOWts?=
 =?utf-8?B?L0M0WnlBT0p6TU5sNDZDRllrdUdORUxwMnpCOWsyWW9SL3QxQnN0bDVUU29l?=
 =?utf-8?B?N2dmZEFrL2FuZlp2bGdOS2UzU2p6K1ZDaUlMTE1hWittTzJGMjlJT2RvZmZW?=
 =?utf-8?B?eFVyb1lJaktJT0puVkZmVFRROW10RmRhM3luZzZqN0ZpWHZUTjY1UWhZRUh2?=
 =?utf-8?B?dGM5aVZxOHNCY2c1K0hsVjBNNE0ybi92MEpHUmVlRzhtL1pMbDZXQ2Z2L0do?=
 =?utf-8?B?bDNJd0xrUk9sZ1ViaE5JZTM3M1ZSOGdQdktRd2xNT2g1U09MYzczWHFPSWRy?=
 =?utf-8?B?KzBCNHdJUkV3Tkg4MGRPekVVU1l0VDZzSWI4SlpIU2t0ckd5YXI1R1VyR2RO?=
 =?utf-8?B?aU42djRaYTRURzZnODc3N05MRlFObkpDblZGMmlzZ0FSdzI4bGVtY2tudmQw?=
 =?utf-8?B?RnE0dGJMU0pveGNXTHZMcmZZV2FXTUs4MFJQcERyQXpTK3dudWl2cmhCQnVy?=
 =?utf-8?B?Q2twLzJIUVZoQ25QU2ZEZmRaMlY4eGU3Qk5qQkN3bTdpQjhWT3ZNVXJJd1ZV?=
 =?utf-8?B?aTV4YytoRkhCSGJRV2U1THk3VkhnNGJuZWNKQk9rcEZzdkVua04rbjE4MGxY?=
 =?utf-8?B?U0d3MGdXd0owdWQ2RkJxdGlKTk5kYTh6VDBzbEhsTjdqQUNBWkNEQUxwNnZs?=
 =?utf-8?B?cnFpRXM1WWdSRW4wV3RXcmRYVE5VaDRJb0V5Ti83K3MyTjZWZXFvSTJDL0I3?=
 =?utf-8?B?WUdsbWdwT3c5YmwxNHBjb3lJN3Y4RjBYNk9EanRTSytsaVc1WXd2SFQ4T3lS?=
 =?utf-8?B?REpoWXh6enlVdmwxTHhXZDRZeXBOcDJmYjVnRmt1c3JlWjhKMWl3bmNmek82?=
 =?utf-8?B?am9FZmNqZUZFOUNxZUU0c3E2RUxTcndoQVVNTmlXcUlPTkQ4VXlxd0cvWFZJ?=
 =?utf-8?B?OFl4UU9pSGNhaXl4MDNyYUc5SS8rUFNRbDFRZ0dUKy9VRGdkd2ZsNlU1MzhV?=
 =?utf-8?B?L2VtTVM3M2JlYVNZOUdzMjJ1TEZ4TnJWWFNjMi9ZS1BqaDBQYXROaXZmaE5Q?=
 =?utf-8?B?dWJxVU0zOVZHZEVMTFpyN3M5L1pVMXJTazhObUFoc1RIdUNLVyt6bGJxTndR?=
 =?utf-8?B?bTZ6MjdtdDdWd05wR1FzejRCdy91b2hxbzlMbStGa0FYMWtBd3FZZFhuNjBR?=
 =?utf-8?B?K1ptYzExRkFPUUQ1SmxqOW8xZy9FRGdyRFN1bmZHNXZ6Q2h1MnNLVXBKdHlZ?=
 =?utf-8?B?bS9GY1hyTFRKM2VJRlJKS0NnY05SbFV6Nyt6NmZ5aG5WVFphVlBIUW0xZ0JD?=
 =?utf-8?B?bFNmTWx6Y1A0bmlMSDEyZjBzOXdWZllHSFN1bGp0UUlBYVFRREdlVDlGbGx3?=
 =?utf-8?B?dVNwUk15UUFxRmhneGhiTXJvVWFrcVhHMG5iblNlZHBHcDNpUmpCSG5TbkYz?=
 =?utf-8?B?RGRWUklRSmduWng4MHJ6SERUcnZUbXNUcHNoODJPaHBEaHBHQWw2M2dnSWxn?=
 =?utf-8?B?Z2UzRTAyNEdYL1FLR1JSbTJsRW8vSk9KN2ZYQ2swS3BHdVdzVzQ0Z3JFKzcw?=
 =?utf-8?B?VkMzMmJ6QkpqdzVxTFpMSmlNNzQxT0lmNkZVNjFRNEJCUndjVlJuc1V3eDB4?=
 =?utf-8?B?bWw3aisvc3Zjb3Z5YUlmWE9QMGNBb3d4ZS9OU2ZtcEVabDV4SEV2dFc4ei9X?=
 =?utf-8?B?dDRwMVBOZ2U3TDRTNitRdm9vNXhjQStvc1JqNDJUTEFjZzhtQ1h0QlFSdUho?=
 =?utf-8?B?Y21tLzR1SzMrWThmNVg4R1FVYm4vdlMvRWowVStsbFhabzFGOG1BMXZDVUhs?=
 =?utf-8?B?RGF2YmtHc3dZZlhMK0pjRkUxQ3BqYmgvUXpPT0IzbC90MlNUY08weHhkYUtv?=
 =?utf-8?Q?VSWnoeJ5UJgK2?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(56012099003)(22082099003)(18002099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: h44qGDIuGMA0pOS7y0EAnu72g4EGafEDd+ddMm3UJjhtkgsuODvlrfB2I5+yt3eXLzScNktD+yhKVpvyHT9gOv65uoI/feSzPHDebS0QFIpg7oLi40P3De/Wv9b1O20igAaueFYA6cPrSTzcBHaByMky+o1jvPVQNcbaDrgiCXMYxdT15LORTQ+0KjLIv5igLwsF4NWCKzNnbDTM1ntoubfwkmON/w5SQZPnyQBK5Whq1LF4YPch6bCJklDvViCfUbW8/EdWady4tH+6YzsoFMCG1PXVTcmi+IZLQYtw7EOsba4e7HAPyZ7fubxyqRJOBHNMZe+6FVLe2eYJXl/mQ3wP0eYxFaGNz4wph+ppD2kgbPLX753+75raFwQuFgEeDCwCNA55j21ibVQcpp8gAPiSBY0mqNd4YoAVdb04GDCaYPYIMDN4AvQ3VXfrV4I9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 10:30:53.3401 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c39d355-b603-4c00-4685-08de9947bd7a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006002.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5904
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

Embed VRAM migration directly into the per-range map loop.

Introduce enum amdgpu_svm_migrate_mode to carry migration intent
through the map_attr_ranges -> map_interval -> map call chain:

  MIGRATE_PREFERRED - follow preferred_loc
  MIGRATE_TO_VRAM   - one-shot prefetch, force VRAM migration
  MIGRATE_TO_SYSMEM - evict VRAM pages to system memory
  MIGRATE_NONE      - suppress migration (restore worker)

Inside per-range's map loop, call amdgpu_svm_range_migrate_range()
which handles both migration directions on each drm_gpusvm_range:
  - TO_VRAM:   migrate to VRAM via drm_pagemap_populate_mm()
  - TO_SYSMEM: evict VRAM via drm_gpusvm_range_evict()

Signed-off-by: Junhua Shen <Junhua.Shen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile           |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c       |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c | 143 +++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h |   5 +-
 .../drm/amd/amdgpu/amdgpu_svm_range_migrate.c | 195 ++++++++++++++++++
 .../drm/amd/amdgpu/amdgpu_svm_range_migrate.h |  53 +++++
 6 files changed, 338 insertions(+), 68 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range_migrate.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range_migrate.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index e64abb5c8ab8..cf4f453b7e68 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -323,14 +323,14 @@ amdgpu-$(CONFIG_HMM_MIRROR) += amdgpu_hmm.o
 
 # svm support
 amdgpu-$(CONFIG_DRM_AMDGPU_SVM) += amdgpu_svm.o amdgpu_svm_attr.o \
-	amdgpu_svm_range.o amdgpu_migrate.o
+	amdgpu_svm_range.o amdgpu_svm_range_migrate.o amdgpu_migrate.o
 
 .PHONY: clean-svm
 clean-svm:
 	rm -f $(obj)/amdgpu_svm.o $(obj)/amdgpu_svm_attr.o $(obj)/amdgpu_svm_range.o \
-	      $(obj)/amdgpu_migrate.o \
+	      $(obj)/amdgpu_svm_range_migrate.o $(obj)/amdgpu_migrate.o \
 	      $(obj)/.amdgpu_svm.o.cmd $(obj)/.amdgpu_svm_attr.o.cmd $(obj)/.amdgpu_svm_range.o.cmd \
-	      $(obj)/.amdgpu_migrate.o.cmd
+	      $(obj)/.amdgpu_svm_range_migrate.o.cmd $(obj)/.amdgpu_migrate.o.cmd
 
 include $(FULL_AMD_PATH)/pm/Makefile
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c
index 05a94a790e79..0310fda2b061 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c
@@ -32,6 +32,7 @@
 #include "amdgpu_svm.h"
 #include "amdgpu_svm_attr.h"
 #include "amdgpu_svm_range.h"
+#include "amdgpu_svm_range_migrate.h"
 #include "amdgpu_vm.h"
 
 #if IS_ENABLED(CONFIG_DRM_AMDGPU_SVM)
@@ -342,7 +343,8 @@ int amdgpu_svm_handle_fault(struct amdgpu_device *adev, uint32_t pasid,
 	AMDGPU_SVM_TRACE("handle_fault: map_attr page=0x%lx\n", fault_page);
 
 	down_write(&svm->svm_lock);
-	ret = amdgpu_svm_range_map_attr_ranges(svm, fault_page, fault_page);
+	ret = amdgpu_svm_range_map_attr_ranges(svm, fault_page, fault_page,
+					       AMDGPU_SVM_MIGRATE_PREFERRED);
 	up_write(&svm->svm_lock);
 
 	if (ret)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
index 472a641fb836..0aa147df621a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
@@ -25,6 +25,7 @@
 #include "amdgpu_svm.h"
 #include "amdgpu_svm_attr.h"
 #include "amdgpu_svm_range.h"
+#include "amdgpu_migrate.h"
 #include "amdgpu.h"
 #include "amdgpu_amdkfd.h"
 #include "amdgpu_vm.h"
@@ -75,6 +76,13 @@ amdgpu_svm_range_enqueue(struct amdgpu_svm *svm,
 			 unsigned long last,
 			 enum amdgpu_svm_range_queue_op op);
 
+static bool
+prefetch_loc_is_vram(const struct amdgpu_svm_attrs *attrs)
+{
+	return attrs->prefetch_loc != AMDGPU_SVM_LOCATION_SYSMEM &&
+	       attrs->prefetch_loc != AMDGPU_SVM_LOCATION_UNDEFINED;
+}
+
 static inline bool
 range_has_access(enum amdgpu_svm_attr_access access)
 {
@@ -114,7 +122,6 @@ range_pages_valid(struct amdgpu_svm *svm,
 	return drm_gpusvm_range_pages_valid(&svm->gpusvm, range);
 }
 
-
 static int
 amdgpu_svm_range_gpu_unmap_in_notifier(struct amdgpu_svm *svm,
 				      struct drm_gpusvm_range *range,
@@ -247,11 +254,11 @@ amdgpu_svm_range_attr_pte_flags(struct amdgpu_svm *svm,
 	return pte_flags;
 }
 
-	/*
-	* POC/WA: reuse kfd apis for queue quiesce/resume
-	* But kfd apis are for process level, not for GPU VM level
-	* need consider potential issues
-	*/
+/*
+ * POC/WA: reuse kfd apis for queue quiesce/resume
+ * But kfd apis are for process level, not for GPU VM level
+ * need consider potential issues
+ */
 void amdgpu_svm_range_restore_begin_compute(struct amdgpu_svm *svm)
 {
 	int ret;
@@ -317,39 +324,6 @@ static int amdgpu_svm_range_lock_vm_pd(struct amdgpu_svm *svm, struct drm_exec *
 	return 0;
 }
 
-static int
-amdgpu_svm_range_update_gpu(struct amdgpu_svm *svm, unsigned long start_page,
-			   unsigned long last_page, uint64_t pte_flags,
-			   dma_addr_t *pages_addr, bool flush_tlb,
-			   bool update_pdes, bool wait_fence)
-{
-	struct drm_exec exec;
-	struct dma_fence *fence = NULL;
-	int ret;
-
-	ret = amdgpu_svm_range_lock_vm_pd(svm, &exec);
-	if (ret)
-		return ret;
-
-	ret = amdgpu_vm_update_range(svm->adev, svm->vm, false, false,
-				     flush_tlb, true,
-				     NULL, start_page, last_page, pte_flags, 0, 0,
-				     NULL, pages_addr, wait_fence ? &fence : NULL);
-	if (!ret && wait_fence && fence) {
-		ret = dma_fence_wait(fence, false);
-		if (ret < 0)
-			AMDGPU_SVM_TRACE("wait unmap fence failed: ret=%d [0x%lx-0x%lx]-0x%lx\n",
-					 ret, start_page, last_page,
-					 last_page - start_page + 1);
-	}
-	if (!ret && update_pdes)
-		ret = amdgpu_vm_update_pdes(svm->adev, svm->vm, false);
-
-	dma_fence_put(fence);
-	drm_exec_fini(&exec);
-	return ret;
-}
-
 static int
 amdgpu_svm_range_update_gpu_range(struct amdgpu_svm *svm,
 				  struct drm_gpusvm_range *range,
@@ -376,9 +350,11 @@ amdgpu_svm_range_update_gpu_range(struct amdgpu_svm *svm,
 						npages - mapped_pages);
 		dma_addr_t seg_addr = entry->addr;
 		unsigned long start_page, last_page;
+		uint64_t seg_pte_flags;
 		bool is_last_seg;
 
-		if (entry->proto != DRM_INTERCONNECT_SYSTEM)
+		if (entry->proto != DRM_INTERCONNECT_SYSTEM &&
+		    entry->proto != AMDGPU_INTERCONNECT_VRAM)
 			return -EOPNOTSUPP;
 
 		while (mapped_pages + seg_pages < npages) {
@@ -399,9 +375,20 @@ amdgpu_svm_range_update_gpu_range(struct amdgpu_svm *svm,
 		last_page = start_page + seg_pages - 1;
 		is_last_seg = mapped_pages + seg_pages == npages;
 
+		/*
+		 * For VRAM pages, device_map() already returned the MC
+		 * address in seg_addr.  Clear the SYSTEM and SNOOPED bits
+		 * since this is local VRAM, not DMA-mapped system memory.
+		 */
+		if (entry->proto == AMDGPU_INTERCONNECT_VRAM)
+			seg_pte_flags = pte_flags & ~(AMDGPU_PTE_SYSTEM |
+						      AMDGPU_PTE_SNOOPED);
+		else
+			seg_pte_flags = pte_flags;
+
 		ret = amdgpu_vm_update_range(svm->adev, svm->vm, false, false,
 					     flush_tlb && is_last_seg, true, NULL,
-					     start_page, last_page, pte_flags,
+					     start_page, last_page, seg_pte_flags,
 					     0, seg_addr, NULL, NULL,
 					     wait_fence && is_last_seg ? fence : NULL);
 		if (ret)
@@ -419,7 +406,8 @@ amdgpu_svm_range_map(struct amdgpu_svm *svm,
 		       unsigned long end,
 		       const struct amdgpu_svm_attrs *attrs,
 		       const struct drm_gpusvm_ctx *gpusvm_ctx,
-		       uint64_t pte_flags)
+		       uint64_t pte_flags,
+		       enum amdgpu_svm_migrate_mode migrate_mode)
 {
 	unsigned long addr = start;
 	int ret;
@@ -462,6 +450,10 @@ amdgpu_svm_range_map(struct amdgpu_svm *svm,
 		if (next_addr <= addr)
 			return -EINVAL;
 
+		/* Per-range migration */
+		amdgpu_svm_range_migrate_range(svm, range, attrs,
+					       migrate_mode);
+
 		range_pte_flags = map_ctx.read_only ?
 			(pte_flags & ~AMDGPU_PTE_WRITEABLE) : pte_flags;
 
@@ -529,10 +521,16 @@ amdgpu_svm_range_map(struct amdgpu_svm *svm,
 static int
 amdgpu_svm_range_map_interval(struct amdgpu_svm *svm, unsigned long start_page,
 				unsigned long last_page,
-				const struct amdgpu_svm_attrs *attrs)
+				const struct amdgpu_svm_attrs *attrs,
+				enum amdgpu_svm_migrate_mode migrate_mode)
 {
+	bool hw_devmem = amdgpu_pagemap_capable(svm);
+
 	struct drm_gpusvm_ctx gpusvm_ctx = {
 		.read_only = !!(attrs->flags & AMDGPU_SVM_FLAG_GPU_RO),
+		.devmem_possible = hw_devmem,
+		.device_private_page_owner = hw_devmem ?
+			AMDGPU_SVM_PGMAP_OWNER(svm->adev) : NULL,
 	};
 	unsigned long start = start_page << PAGE_SHIFT;
 	unsigned long end = (last_page + 1) << PAGE_SHIFT;
@@ -542,7 +540,7 @@ amdgpu_svm_range_map_interval(struct amdgpu_svm *svm, unsigned long start_page,
 	pte_flags = amdgpu_svm_range_attr_pte_flags(svm, attrs);
 
 	ret = amdgpu_svm_range_map(svm, start, end, attrs, &gpusvm_ctx,
-				   pte_flags);
+				   pte_flags, migrate_mode);
 	if (ret)
 		AMDGPU_SVM_TRACE("map_interval failed: ret=%d [0x%lx-0x%lx)-0x%lx\n",
 				 ret, start, end, end - start);
@@ -553,7 +551,8 @@ amdgpu_svm_range_map_interval(struct amdgpu_svm *svm, unsigned long start_page,
 int
 amdgpu_svm_range_map_attr_ranges(struct amdgpu_svm *svm,
 				 unsigned long start_page,
-				 unsigned long last_page)
+				 unsigned long last_page,
+				 enum amdgpu_svm_migrate_mode migrate_mode)
 {
 	lockdep_assert_held_write(&svm->svm_lock);
 
@@ -573,9 +572,10 @@ amdgpu_svm_range_map_attr_ranges(struct amdgpu_svm *svm,
 
 		seg_last = min(seg_last, last_page);
 		if (range_has_access(attrs.access)) {
-			/* map may fail here cause no vma or access deny */
-			ret = amdgpu_svm_range_map_interval(svm, cursor, seg_last,
-							    &attrs);
+			ret = amdgpu_svm_range_map_interval(svm, cursor,
+							    seg_last,
+							    &attrs,
+							    migrate_mode);
 			if (ret)
 				return ret;
 		}
@@ -657,7 +657,6 @@ static int amdgpu_svm_range_rebuild_locked(struct amdgpu_svm *svm,
 	unsigned long rebuild_start = start_page;
 	unsigned long rebuild_last = last_page;
 	bool removed;
-	int ret;
 
 	lockdep_assert_held_write(&svm->svm_lock);
 
@@ -673,14 +672,10 @@ static int amdgpu_svm_range_rebuild_locked(struct amdgpu_svm *svm,
 	/* scan rebuild start end to build the extra removed ranges */
 	if (rebuild)
 		return amdgpu_svm_range_map_attr_ranges(svm, rebuild_start,
-							rebuild_last);
+							rebuild_last,
+							AMDGPU_SVM_MIGRATE_PREFERRED);
 
-	ret = amdgpu_svm_range_update_gpu(svm, rebuild_start, rebuild_last,
-					  0, NULL, true, true, true);
-	if (!ret)
-		svm->flush_tlb(svm);
-
-	return ret;
+	return 0;
 }
 
 static void
@@ -706,10 +701,11 @@ amdgpu_svm_range_process_notifier_ranges(struct amdgpu_svm *svm,
 		if (clear_pte) {
 			amdgpu_svm_range_gpu_unmap_in_notifier(svm, range,
 									   mmu_range);
-			range_invalidate_gpu_mapping(range);
 		}
 
 		drm_gpusvm_range_unmap_pages(&svm->gpusvm, range, &ctx);
+		range_invalidate_gpu_mapping(range);
+
 		if (is_unmap)
 			drm_gpusvm_range_set_unmapped(range, mmu_range);
 
@@ -758,6 +754,7 @@ int amdgpu_svm_range_apply_attr_change(struct amdgpu_svm *svm,
 {
 	lockdep_assert_held_write(&svm->svm_lock);
 
+	enum amdgpu_svm_migrate_mode migrate_mode = AMDGPU_SVM_MIGRATE_PREFERRED;
 	bool old_access, new_access;
 	bool update_mapping = false;
 
@@ -789,15 +786,26 @@ int amdgpu_svm_range_apply_attr_change(struct amdgpu_svm *svm,
 		update_mapping = true;
 
 	if (trigger & AMDGPU_SVM_ATTR_TRIGGER_LOCATION_CHANGE) {
-		/* TODO: add migration */
+		if (new_access) {
+			if (prefetch_loc_is_vram(new_attrs)) {
+				migrate_mode = AMDGPU_SVM_MIGRATE_TO_VRAM;
+				update_mapping = true;
+			} else if (new_attrs->prefetch_loc ==
+				       AMDGPU_SVM_LOCATION_SYSMEM) {
+				migrate_mode = AMDGPU_SVM_MIGRATE_TO_SYSMEM;
+				update_mapping = true;
+			} else {
+				AMDGPU_SVM_TRACE("no migration [0x%lx-0x%lx]\n",
+						 start, last);
+			}
+		}
 	}
 
 	if (!update_mapping)
 		return 0;
 
-	AMDGPU_SVM_TRACE("mapping update: remap interval [0x%lx-0x%lx]-0x%lx\n",
-			 start, last, last - start + 1);
-	return amdgpu_svm_range_map_interval(svm, start, last, new_attrs);
+	return amdgpu_svm_range_map_interval(svm, start, last, new_attrs,
+					     migrate_mode);
 }
 
 static bool
@@ -1004,7 +1012,8 @@ static void amdgpu_svm_range_restore_worker(struct work_struct *w)
 
 		down_write(&svm->svm_lock);
 		ret = amdgpu_svm_range_map_attr_ranges(svm, op_ctx.start,
-						       op_ctx.last);
+						       op_ctx.last,
+						       AMDGPU_SVM_MIGRATE_NONE);
 		up_write(&svm->svm_lock);
 
 		if (ret) {
@@ -1042,7 +1051,6 @@ static void amdgpu_svm_range_restore_worker(struct work_struct *w)
 			drm_gpusvm_notifier_unlock(&svm->gpusvm);
 			svm->end_restore(svm);
 			return;
-	
 		}
 		drm_gpusvm_notifier_unlock(&svm->gpusvm);
 	}
@@ -1099,6 +1107,15 @@ void amdgpu_svm_range_invalidate(struct amdgpu_svm *svm,
 	if (atomic_read(&svm->exiting))
 		return;
 
+	/*
+	 * Skip migration events that we initiated ourselves via
+	 * drm_pagemap_populate_mm() (RAM→VRAM prefetch).
+	 */
+	if (mmu_range->event == MMU_NOTIFY_MIGRATE &&
+	    mmu_range->owner == AMDGPU_SVM_PGMAP_OWNER(svm->adev) &&
+	    atomic_read(&svm->in_populate))
+		return;
+
 	if (!drm_gpusvm_range_find(notifier, mmu_range->start,
 				    mmu_range->end))
 		return;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h
index 18bf3dad13fd..0065ae50c700 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h
@@ -30,6 +30,8 @@
 #include <linux/list.h>
 #include <linux/types.h>
 
+#include "amdgpu_svm_range_migrate.h"
+
 struct amdgpu_svm;
 struct amdgpu_svm_attrs;
 struct drm_gpusvm_notifier;
@@ -62,7 +64,8 @@ void amdgpu_svm_range_flush(struct amdgpu_svm *svm);
 void amdgpu_svm_range_sync_work(struct amdgpu_svm *svm);
 int amdgpu_svm_range_map_attr_ranges(struct amdgpu_svm *svm,
 				     unsigned long start_page,
-				     unsigned long last_page);
+				     unsigned long last_page,
+				     enum amdgpu_svm_migrate_mode migrate_mode);
 int amdgpu_svm_range_apply_attr_change(
 	struct amdgpu_svm *svm, unsigned long start, unsigned long last,
 	uint32_t trigger, const struct amdgpu_svm_attrs *prev_attrs,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range_migrate.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range_migrate.c
new file mode 100644
index 000000000000..e7a2a11858f6
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range_migrate.c
@@ -0,0 +1,195 @@
+/* SPDX-License-Identifier: GPL-2.0 OR MIT */
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+#include <drm/drm_pagemap.h>
+
+#include "amdgpu_svm.h"
+#include "amdgpu_svm_attr.h"
+#include "amdgpu_svm_range.h"
+#include "amdgpu_svm_range_migrate.h"
+#include "amdgpu.h"
+
+static bool
+range_in_vram(struct drm_gpusvm_range *range)
+{
+	struct drm_gpusvm_pages_flags flags = {
+		/* Pairs with WRITE_ONCE in drm_gpusvm_get_pages() */
+		.__flags = READ_ONCE(range->pages.flags.__flags),
+	};
+
+	return flags.has_devmem_pages;
+}
+
+static bool
+preferred_loc_is_vram(const struct amdgpu_svm_attrs *attrs)
+{
+	return attrs->preferred_loc != AMDGPU_SVM_LOCATION_SYSMEM &&
+	       attrs->preferred_loc != AMDGPU_SVM_LOCATION_UNDEFINED;
+}
+
+static struct drm_pagemap *
+amdgpu_svm_get_dpagemap(struct amdgpu_svm *svm)
+{
+	struct amdgpu_pagemap *apagemap = &svm->adev->kfd.apagemap;
+
+	if (!apagemap->initialized)
+		return NULL;
+
+	return &apagemap->dpagemap;
+}
+
+/**
+ * range_needs_migrate_to_vram - Per-range VRAM migration check
+ * @svm: Pointer to the AMDGPU SVM structure
+ * @range: Pointer to the GPU SVM range
+ * @attrs: Current SVM attributes for this address range
+ * @mode: Migration mode (POLICY, TO_VRAM, or NONE)
+ *
+ * Three-level decision:
+ *   1. Capability:  range->migrate_devmem (hardware, set at creation, stable)
+ *   2. Command:     mode==TO_VRAM (one-shot prefetch_loc override)
+ *   3. Policy:      preferred_loc (persistent user intent, when mode==POLICY)
+ *
+ * Return: true if range should be migrated to VRAM
+ */
+static bool
+range_needs_migrate_to_vram(struct amdgpu_svm *svm,
+			    struct drm_gpusvm_range *range,
+			    const struct amdgpu_svm_attrs *attrs,
+			    enum amdgpu_svm_migrate_mode mode)
+{
+	/* Capability: hardware must support VRAM for this range */
+	if (!range->pages.flags.migrate_devmem)
+		return false;
+
+	/* Suppress: post-evict remap or evict-to-SYSMEM — no VRAM migration */
+	if (mode == AMDGPU_SVM_MIGRATE_NONE ||
+	    mode == AMDGPU_SVM_MIGRATE_TO_SYSMEM)
+		return false;
+
+	/* Already backed by VRAM — no migration needed */
+	if (range_in_vram(range))
+		return false;
+
+	/* Command: prefetch overrides policy — migrate unconditionally */
+	if (mode == AMDGPU_SVM_MIGRATE_TO_VRAM)
+		return true;
+
+	/* Policy: only migrate if preferred_loc targets VRAM */
+	return preferred_loc_is_vram(attrs);
+}
+
+/**
+ * amdgpu_svm_range_migrate_to_vram - Migrate a single range's pages to VRAM
+ * @svm: Pointer to the AMDGPU SVM structure
+ * @range: Pointer to the GPU SVM range to migrate
+ *
+ * The in_populate flag is set around populate_mm to tell the mmu_notifier
+ * handler to skip the self-migration event. After successful migration,
+ * the range's cached DMA addresses and gpu_mapped state are explicitly
+ * invalidated so that the subsequent get_pages() call will re-fault with
+ * fresh VRAM DMA addresses.
+ *
+ * Handles one retry-able error case:
+ *  - -EBUSY: the range already has device-private pages from a different
+ *            allocation. Evict those pages to RAM first and retry.
+ *
+ * Return: 0 on success, negative errno on failure
+ */
+static int
+amdgpu_svm_range_migrate_to_vram(struct amdgpu_svm *svm,
+				  struct drm_gpusvm_range *range)
+{
+	struct drm_pagemap *dpagemap = amdgpu_svm_get_dpagemap(svm);
+	struct drm_gpusvm_ctx ctx = { .in_notifier = false };
+	unsigned long start = drm_gpusvm_range_start(range);
+	unsigned long end = drm_gpusvm_range_end(range);
+	int ret, retries = 3;
+
+	if (!dpagemap)
+		return -ENODEV;
+
+	do {
+		atomic_set(&svm->in_populate, 1);
+		ret = drm_pagemap_populate_mm(dpagemap,
+					  start, end, svm->gpusvm.mm, 0);
+		atomic_set(&svm->in_populate, 0);
+
+		if (ret == -EBUSY && retries) {
+			AMDGPU_SVM_TRACE("migrate_to_vram -EBUSY, evicting [0x%lx-0x%lx]\n",
+				 start, end);
+			drm_gpusvm_range_evict(&svm->gpusvm, range);
+		} else if (ret) {
+			break;
+		}
+	} while (ret && retries--);
+
+	if (ret) {
+		AMDGPU_SVM_TRACE("migrate_to_vram failed: ret=%d [0x%lx-0x%lx]\n",
+				 ret, start, end);
+		return ret;
+	}
+
+	drm_gpusvm_range_unmap_pages(&svm->gpusvm, range, &ctx);
+	WRITE_ONCE(to_amdgpu_svm_range(range)->gpu_mapped, false);
+
+	return 0;
+}
+
+bool
+amdgpu_pagemap_capable(struct amdgpu_svm *svm)
+{
+	if (svm->adev->gmc.is_app_apu)
+		return false;
+
+	if (!amdgpu_svm_get_dpagemap(svm))
+		return false;
+
+	return true;
+}
+
+/**
+ * amdgpu_svm_range_migrate_range - Per-range migration for the map path
+ * @svm: Pointer to the AMDGPU SVM structure
+ * @range: The GPU SVM range to migrate
+ * @attrs: Current SVM attributes
+ * @migrate_mode: Migration intent
+ * @devmem_possible: Whether hardware supports device memory for this range
+ */
+int
+amdgpu_svm_range_migrate_range(struct amdgpu_svm *svm,
+			       struct drm_gpusvm_range *range,
+			       const struct amdgpu_svm_attrs *attrs,
+			       enum amdgpu_svm_migrate_mode migrate_mode)
+{
+	/* VRAM migration (TO_VRAM or POLICY with preferred_loc=VRAM) */
+	if (range_needs_migrate_to_vram(svm, range, attrs, migrate_mode))
+		return amdgpu_svm_range_migrate_to_vram(svm, range);
+
+	/* VRAM eviction (prefetch-to-SYSMEM) */
+	if (migrate_mode == AMDGPU_SVM_MIGRATE_TO_SYSMEM &&
+	    range_in_vram(range))
+		return drm_gpusvm_range_evict(&svm->gpusvm, range);
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range_migrate.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range_migrate.h
new file mode 100644
index 000000000000..df14b0bc64da
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range_migrate.h
@@ -0,0 +1,53 @@
+/* SPDX-License-Identifier: GPL-2.0 OR MIT */
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+
+#ifndef __AMDGPU_SVM_RANGE_MIGRATE_H__
+#define __AMDGPU_SVM_RANGE_MIGRATE_H__
+
+struct amdgpu_svm;
+struct amdgpu_svm_attrs;
+struct drm_gpusvm_range;
+
+/**
+ * enum amdgpu_svm_migrate_mode - Migration intent for map paths
+ * @AMDGPU_SVM_MIGRATE_PREFERRED: Follow preferred_loc to decide migration
+ * @AMDGPU_SVM_MIGRATE_TO_VRAM: Force VRAM migration (prefetch-to-VRAM, one-shot)
+ * @AMDGPU_SVM_MIGRATE_TO_SYSMEM: Evict VRAM pages to system memory, then remap
+ * @AMDGPU_SVM_MIGRATE_NONE: Suppress all migration (post-evict remap —
+ *			      just map existing SYSMEM pages to GPU)
+ */
+enum amdgpu_svm_migrate_mode {
+	AMDGPU_SVM_MIGRATE_PREFERRED,
+	AMDGPU_SVM_MIGRATE_TO_VRAM,
+	AMDGPU_SVM_MIGRATE_TO_SYSMEM,
+	AMDGPU_SVM_MIGRATE_NONE,
+};
+
+bool amdgpu_pagemap_capable(struct amdgpu_svm *svm);
+int amdgpu_svm_range_migrate_range(struct amdgpu_svm *svm,
+				    struct drm_gpusvm_range *range,
+				    const struct amdgpu_svm_attrs *attrs,
+				    enum amdgpu_svm_migrate_mode migrate_mode);
+
+#endif /* __AMDGPU_SVM_RANGE_MIGRATE_H__ */
-- 
2.34.1

