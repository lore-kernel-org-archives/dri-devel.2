Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DF4E1073C8B
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 10:07:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 894F910E603;
	Wed,  8 Apr 2026 10:07:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lXBPViHR";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010000.outbound.protection.outlook.com [52.101.56.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 790D110E5FB;
 Wed,  8 Apr 2026 10:07:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ccyKjYNEyekD7nK7ipFJlUs4/F/1kHv7PxW2IMY29vM8S4wZ1WlVghmvKp6D/HFjMjvPUCOEBeBzd/hBtp09kK5hF7x6DR7AJJhitjML32cvxqwQZddXpjMNlOVY75iv87hCdBPzyCuWxiYY6C/RI1OgWh+0jEelXocvoMnci3D4iiE5iWJ6YyOJxng4SoNvUBbrcGL+3qJb+MiNb1OvAAVNAPFOco5OiNBIXFj5L9jP7yHyGHyY1Ud+nB/ALTmtEd4Bt0QXzRodEcbnTtG8vXfXJpprZ+YCFWw53u4utTtdR1qsI2p3arB8U9WG+rormIy5WNxOFrgk1HuCX1hhtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=02sbvyGOWphVk448LzlzXSbn4NroMpjCBhgZX8Z3CYU=;
 b=D6Ox6zfnGgfI8EvM5Zk684Je0gX8+lGzp8yKX8niFgyFVV2zu43HrOG0pVUUk864SBpEg0tLlq28MBi1BD1ktVMJki3bhjjYRs2v722q6icdE80lMy5dyGijo/WzEfz5hi+U9xV3DBy38opSSbEzOpbh3uSBGX88k/Lb+tvUMnA7iH5YIas2zNGhd54yaqLpADXGeMUUs2FlYuJKOKypWUK3FRVJPfmLaLT7fy4zUr4OlC+PCfAPL9xQD1kvdIELbC22TxW5Md6mHbigNz8x3OseLacu/vaEm/mdefHrHOmya7WEROjy1501e1oX7zhvzjkIp66NUIFBNhxb7uYt2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=02sbvyGOWphVk448LzlzXSbn4NroMpjCBhgZX8Z3CYU=;
 b=lXBPViHR6LHJUaDFoM2cTsDrWXdv5+8FG12rDJhIdlT3MdDGL/MXBXQmDSCYjjGGdduTwP+4S8m2cEH8tXAI4zas3ttNS574KmqtZbdLQgaU/S5k3FieF4msoPfd4Xze6XjLfjmQtJ3WXrz1A43BAVHiaEP/4I77Ep2BgGub9BA=
Received: from PH7PR17CA0060.namprd17.prod.outlook.com (2603:10b6:510:325::24)
 by DS5PPFBABE93B01.namprd12.prod.outlook.com (2603:10b6:f:fc00::65f)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Wed, 8 Apr
 2026 10:07:36 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:510:325:cafe::35) by PH7PR17CA0060.outlook.office365.com
 (2603:10b6:510:325::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.32 via Frontend Transport; Wed,
 8 Apr 2026 10:07:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 8 Apr 2026 10:07:35 +0000
Received: from FRAPPELLOUX01-WSLPUB.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 8 Apr 2026 05:07:34 -0500
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 8/8] drm/amdgpu: use DRM_SCHED_PRIORITY_KERNEL for all ttm
 entities
Date: Wed, 8 Apr 2026 12:03:19 +0200
Message-ID: <20260408100327.1372-8-pierre-eric.pelloux-prayer@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260408100327.1372-1-pierre-eric.pelloux-prayer@amd.com>
References: <20260408100327.1372-1-pierre-eric.pelloux-prayer@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|DS5PPFBABE93B01:EE_
X-MS-Office365-Filtering-Correlation-Id: 68012261-02f0-4ccf-e701-08de9556a86c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Ytsck3Dci8jkP5BGVcWN52ZX4Qx/ZMB9QwpAG0wpyjBYJjSviF+bAQN10kr73OHkMWFSK601MYAxOpSZY2D2YsJZoHHFS+tO+vA8JQVmYBooaZaXhe6FqReiv5TZVBm0wqJ1E49ihH1PsBoi7kCDyLQD9zisHpP79OR75GFo0oeKno0HydYcUr5KEBtyTEahvHUOHQXiBFF1LHpXuAOngDlVzoXdUNQxBpTQ/upx0oihNkzujAXndZp9SNIS8TOPM/yxsNOV7g1qJugobbf/z4cOWyLexvc0o8YsVVxaxjILtRtKUohBHKnHoaB1MqTNbMb4c1554RLhISKEwLaPpAFBSR77qBpQpOheYQkToYDGIXtjHOQzHhqcZeSyFNwh8qRj7AoK2lVvXUA6lQsPMQouhhinl0HcTrV7q772hz7FkV+wPCzycdNc4sv61RztwPPTsuyEdizF0bEgwVmvyQPyZmOXh5oQe1Cc9MhIoeUCllMWQD4NFRcfyLHgbVS1I9GgIdd+9rnr/p4WnMcb4g/YVgaUXKgK9IKc4vLtzVfwsLwpxFrgzvkeOD77mL7nnINZ7onQh50T/nXOtUwrqZorpuTjUB1nYJcsJRraJu9XwYOl1o3I7ZHSPRjEU30ZJFsNx1lWzKgykIXr8/XLM6OhAPtq0jc2QsjtBG8pk7KaNeXSLZ7iHn/YTMOuGB1yGz+B1QPP1MujmhDz473wCFvF6+63BfvHa9bb1HtaLDXzATnYD2vYitnrDGbeiDOh2C2bDDW6vXOgRwjMt96mQw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3ok2M2xoM05Khi1oJgWFWh13yiESdQpobSN75/3QOC7E4gu1/u14ewXWiQBsT6KtgZYQAtLs9BhR3s3ZFcSQQA4LhjVgp/9MSN3tUyVCeaNRMmuANhzHfq1uWb2FoZKioHfGvmeH1YNuZPyEUFMIK1gCjjW8ae0zs+DL/jvC1DJ79tRQXOkC34N1rSs8x9t2+GPD75CG3NTLRfY2p26IeEJ6u2u1nIe+okmhAkEbUsSR07uixiXcT0q/GEBLU1ONAzNiybezaxPjAyzl8SyY6VuVKJc4xTjFrvlQCrpAl7iNYsZkAdBcSeMpxSRVnS2grmKJfD619YxXJYqL2flA+2Fq7xjpdgGoKywyIkg1L/JOHmSqIZm62iLNFcppWJsrvGC6ffiUXrnheh1p6lYuHAM7O0rS3cZohWsaY2BPjbfHpYzMA4Y/3lFBClCPNt5Q
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 10:07:35.7769 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68012261-02f0-4ccf-e701-08de9556a86c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFBABE93B01
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

ttm jobs must have higher priority than any userspace jobs.

Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 000f66452b10..1f9423556ab3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -2378,7 +2378,7 @@ void amdgpu_ttm_enable_buffer_funcs(struct amdgpu_device *adev)
 		r = amdgpu_ttm_buffer_entity_init(
 			&adev->mman.gtt_mgr,
 			&adev->mman.clear_entities[i],
-			DRM_SCHED_PRIORITY_NORMAL,
+			DRM_SCHED_PRIORITY_KERNEL,
 			adev->mman.buffer_funcs_scheds,
 			adev->mman.num_buffer_funcs_scheds, 1);
 
@@ -2398,7 +2398,7 @@ void amdgpu_ttm_enable_buffer_funcs(struct amdgpu_device *adev)
 		r = amdgpu_ttm_buffer_entity_init(
 			&adev->mman.gtt_mgr,
 			&adev->mman.move_entities[i],
-			DRM_SCHED_PRIORITY_NORMAL,
+			DRM_SCHED_PRIORITY_KERNEL,
 			adev->mman.buffer_funcs_scheds,
 			adev->mman.num_buffer_funcs_scheds, 2);
 
-- 
2.43.0

