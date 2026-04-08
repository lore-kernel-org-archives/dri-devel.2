Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AB1F1073C85
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 10:05:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFB7A10E5D6;
	Wed,  8 Apr 2026 10:05:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VZTTndjm";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010013.outbound.protection.outlook.com [52.101.56.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BA5410E5D6;
 Wed,  8 Apr 2026 10:05:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ORb7RrQ7EPFmIOc9qZDpmsWqEdtY0nzwhJKy7FscvHZbShi5AO6dE+WhSGZq/UhbXNF9Jtyx9V8pfO5M6x8CfoCKqtTxA3e3FhZkIXuc5kvACRt1DAcoo6sEwh504QqjedUHGeeTySbhWJwnzmOG05aBOKl71AqRz0PpNjIEdIVX5Fj5e5pr/Td78qqXuKKZXcpdYdzgiQ8Y6X51kJSoJYJ7p9gvIEi2SteYmi1nozRH1ca7clRDHGr900I8bWUvU3+iaCmYS026RSyVbl4Ff4EUPMSSjt6igyCOgsinIsl8GTn91vWrbruUNPOBUBwfFLYeagsyklOtlRoWumzlYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mAuToFyrHGw9uc911R0CXxRbei7qMOm0wImhQwQfMeE=;
 b=BgQN94TbQ8+oDNtpLuvecYyJkeH51PdPRot23cOwFI+G1NRZOkoQdrruQIlwGF7VPs7RMgmCH/PtIKJC5KB/LGpBmBBda8gWta+nBhAlCgwSYglRLWef2fPZt3wLCa/EIIuAkXfeeQ4CBA65LLI7TydgK824uG/hcT4yBg67dgXDOZeiS+OiU84YTRWHWdB0jJ+Gy7D/EVDTWE5LKQQZzGhtk8VPYs/C7lgOVQz+yplUqN7NRGC1PUGo+OjmImszo1xOYviB4TCbcNxjaofoIqWwfZPJ8dWNJFOljKzafxFPPRdc8mdvHIXoqfqwOJ/U1ib1BhpbhErWKwN17CGh/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mAuToFyrHGw9uc911R0CXxRbei7qMOm0wImhQwQfMeE=;
 b=VZTTndjm0AsC+MbjKWakDmo7488LXjbnWB52/xHi00Gz7NCIqvD3V5PW6RDQsRVrbkI9bPRFpJ6k3+hYAG+vPhOP1E/DBwf1lTldR0+7v2gVaMhjayAaGnMYgtJiDYy0KD/gpLmcZwYg9sEacsSvJYrvWezQLScZBgVEa4Ux5TE=
Received: from PH8PR02CA0044.namprd02.prod.outlook.com (2603:10b6:510:2da::9)
 by LV2PR12MB999073.namprd12.prod.outlook.com (2603:10b6:408:352::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 8 Apr
 2026 10:05:24 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2603:10b6:510:2da:cafe::81) by PH8PR02CA0044.outlook.office365.com
 (2603:10b6:510:2da::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.37 via Frontend Transport; Wed,
 8 Apr 2026 10:05:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 8 Apr 2026 10:05:24 +0000
Received: from FRAPPELLOUX01-WSLPUB.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 8 Apr 2026 05:05:21 -0500
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 2/8] drm/amdgpu: only use working sdma schedulers for ttm
Date: Wed, 8 Apr 2026 12:03:13 +0200
Message-ID: <20260408100327.1372-2-pierre-eric.pelloux-prayer@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260408100327.1372-1-pierre-eric.pelloux-prayer@amd.com>
References: <20260408100327.1372-1-pierre-eric.pelloux-prayer@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|LV2PR12MB999073:EE_
X-MS-Office365-Filtering-Correlation-Id: c7e8c983-07b9-4f63-cdd0-08de955659e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: ylNubrtqkSV1SVsUp3s/4A7adRjLjRZVn4YVgIE/Y0/3pWCi886wP/JM3XsZGaNNO+LbT5s/55br57xj8o5zNhk9c2hx1jXd9wEnfj1R+aDY/kmDYUlXEA0sawVy/dfW1qdbbKSA1krxVnRBLcGcipHAOwFDlu9lY22eWJZiaiHcOsIyPb8+9ajmFS1mtvINDiA4aKSTVDYCARHNteFEea2pwMaHmS9qIgHIQs6y+W/WPXIk9/tW1myF+gFbeCfWVPYqAMzU3wCra6EyCUkjJ0a3dS63nYnlYvqUwnp3wTJC3eg0U5+3oG0Iedc4+37WhcxRTHWLjvBg2lgbsTgWXX10OUmbBvwhqhOt6KYYnWMMOcmgeYepb9b2nLgQuE/Wy134/N8E2Xnqg2gU5y5JZPuDwSyRw9DCGLLqW+ZXXAyqRp7Xkn4qKqHjXo0JIYwj2Ouyk5Gkt5y2ben+uMyfFu7X6O+U4/KyaoNvHBCK5Jf45BuQjo2b+J44oz6zcD5EVdHpmi/JQMy3xD+x1Bq3RC/XOBo2py7Ay6uI6E4i4Ol7yqaMqIkhu/xu/AuZWaevQCWPgiLwbtyqQJ0yf4Ly6mc8rmd2xgd2NKIklEKdKdyLIJKN5TiHZZy4+eHmHGTfPiEWUKSgea3IHfin4fVB9Z25PgB/W7y8m+5k21v0S+ghAN2+jxuKdRFbqwEv65N59Umt2LlO4bHsmWCGLOAkv+hI/BjLKwdJ5MaCkt4FYNMej1vDGkati8YR23NG1fhQhDbZWJXOQMtsOTu0Ju7B/A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: C4MIfU3K6amWFboCq+9Or7BRlzMR8hIAEtNab53/QhL9u8aj0I5eCrWLvo5cxrXCBSHbnBMFIX7Xyzti8IQRs3ch++Cc0zUY42+WxukX+XYcYVCCpNf11jqceEOUDoHwXBue6QoYgocYIx7w+QqTwStRWc7MdALn9o0Zurl0k8SbtxrJ8g82dydoTQreOUuUzV74YUusvzmHicS6M/+trx6qkgCQoafyTz/M7VVIDRk7EcUvKcAn/gNdTXc9QwgM4NRoF7ekNT2mL+yQoaUY+N5gZCQaZyumqEq0MZ40uI2CR/zY2s85ONoz1Z/PA9htgUrZeDTVlXcYNXxwy8z2eh2wEgzes3hl0HaAEjDVS1Mc9fchZGduPN+VsRB62EG9HmC+HSNSRydJJjp9qp2gFPDEyIWZFpcgBnmHkMu+ny3XP0Z+f7DZWPyBoaYjjuci
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 10:05:24.0482 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7e8c983-07b9-4f63-cdd0-08de955659e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB999073
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

It's possible that some sdma instances aren't working so we shouldn't try
to use them from TTM. To achieve this, delay the call to
amdgpu_sdma_set_buffer_funcs_scheds after the rings have been tested, and
then use the 'ready' property to decide if a sched should be used or not.

Note that currently it's not doing much, because if the ring helper fails
for any ring, the whole sdma block init fails.

---
v5: check buffer_funcs_enabled from amdgpu_ttm_access_memory_sdma
---

Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c  | 23 ++++++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c    | 10 ++++++++--
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c   |  5 +++--
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c   |  5 +++--
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c   |  9 +++++++--
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c |  6 ++++--
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   |  6 ++++--
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   |  9 +++++++--
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c   |  9 +++++++--
 drivers/gpu/drm/amd/amdgpu/si_dma.c      |  9 +++++++--
 12 files changed, 68 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 63ec3938cd41..0e9620df91b7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1560,7 +1560,7 @@ static int amdgpu_ttm_access_memory_sdma(struct ttm_buffer_object *bo,
 	if (!adev->mman.sdma_access_ptr)
 		return -EACCES;
 
-	if (!drm_dev_enter(adev_to_drm(adev), &idx))
+	if (!adev->mman.buffer_funcs_enabled || !drm_dev_enter(adev_to_drm(adev), &idx))
 		return -ENODEV;
 
 	if (write)
@@ -2351,8 +2351,7 @@ void amdgpu_ttm_set_buffer_funcs_status(struct amdgpu_device *adev, bool enable)
 	if (enable) {
 		struct drm_gpu_scheduler *sched;
 
-		if (!adev->mman.num_buffer_funcs_scheds ||
-		    !adev->mman.buffer_funcs_scheds[0]->ready) {
+		if (!adev->mman.num_buffer_funcs_scheds) {
 			dev_warn(adev->dev, "Not enabling DMA transfers for in kernel use");
 			return;
 		}
@@ -2734,16 +2733,26 @@ void amdgpu_sdma_set_buffer_funcs_scheds(struct amdgpu_device *adev,
 {
 	struct drm_gpu_scheduler *sched;
 	struct amdgpu_vmhub *hub;
-	int i;
+	int i, n;
 
 	adev->mman.buffer_funcs = buffer_funcs;
 
-	for (i = 0; i < adev->sdma.num_instances; i++) {
+	for (i = 0, n = 0; i < adev->sdma.num_instances; i++) {
 		if (adev->sdma.has_page_queue)
 			sched = &adev->sdma.instance[i].page.sched;
 		else
 			sched = &adev->sdma.instance[i].ring.sched;
-		adev->mman.buffer_funcs_scheds[i] = sched;
+
+		if (!sched->ready)
+			continue;
+
+		adev->mman.buffer_funcs_scheds[n++] = sched;
+	}
+
+	if (n == 0) {
+		adev->mman.num_buffer_funcs_scheds = 0;
+		drm_warn(&adev->ddev, "No working sdma ring available\n");
+		return;
 	}
 
 	/* Navi1x's workaround requires us to limit to a single SDMA sched
@@ -2751,7 +2760,7 @@ void amdgpu_sdma_set_buffer_funcs_scheds(struct amdgpu_device *adev,
 	 */
 	hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
 	adev->mman.num_buffer_funcs_scheds = hub->sdma_invalidation_workaround ?
-		1 : adev->sdma.num_instances;
+		1 : n;
 }
 
 #if defined(CONFIG_DEBUG_FS)
diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
index 26276dcfd458..120da838ac28 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
@@ -939,7 +939,6 @@ static int cik_sdma_early_init(struct amdgpu_ip_block *ip_block)
 
 	cik_sdma_set_ring_funcs(adev);
 	cik_sdma_set_irq_funcs(adev);
-	cik_sdma_set_buffer_funcs(adev);
 	amdgpu_sdma_set_vm_pte_scheds(adev, &cik_sdma_vm_pte_funcs);
 
 	return 0;
@@ -1000,8 +999,15 @@ static int cik_sdma_sw_fini(struct amdgpu_ip_block *ip_block)
 static int cik_sdma_hw_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
+	int r;
 
-	return cik_sdma_start(adev);
+	r = cik_sdma_start(adev);
+	if (r)
+		return r;
+
+	cik_sdma_set_buffer_funcs(adev);
+
+	return 0;
 }
 
 static int cik_sdma_hw_fini(struct amdgpu_ip_block *ip_block)
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
index c6a059ca59e5..93ec52c1f367 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
@@ -828,7 +828,6 @@ static int sdma_v2_4_early_init(struct amdgpu_ip_block *ip_block)
 		return r;
 
 	sdma_v2_4_set_ring_funcs(adev);
-	sdma_v2_4_set_buffer_funcs(adev);
 	amdgpu_sdma_set_vm_pte_scheds(adev, &sdma_v2_4_vm_pte_funcs);
 	sdma_v2_4_set_irq_funcs(adev);
 
@@ -898,7 +897,9 @@ static int sdma_v2_4_hw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	return r;
+	sdma_v2_4_set_buffer_funcs(adev);
+
+	return 0;
 }
 
 static int sdma_v2_4_hw_fini(struct amdgpu_ip_block *ip_block)
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
index cb516a25210d..3fde9be74690 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
@@ -1108,7 +1108,6 @@ static int sdma_v3_0_early_init(struct amdgpu_ip_block *ip_block)
 		return r;
 
 	sdma_v3_0_set_ring_funcs(adev);
-	sdma_v3_0_set_buffer_funcs(adev);
 	amdgpu_sdma_set_vm_pte_scheds(adev, &sdma_v3_0_vm_pte_funcs);
 	sdma_v3_0_set_irq_funcs(adev);
 
@@ -1184,7 +1183,9 @@ static int sdma_v3_0_hw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	return r;
+	sdma_v3_0_set_buffer_funcs(adev);
+
+	return 0;
 }
 
 static int sdma_v3_0_hw_fini(struct amdgpu_ip_block *ip_block)
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index d56be26f216b..8a2a4e61867e 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -1775,7 +1775,6 @@ static int sdma_v4_0_early_init(struct amdgpu_ip_block *ip_block)
 		adev->sdma.has_page_queue = true;
 
 	sdma_v4_0_set_ring_funcs(adev);
-	sdma_v4_0_set_buffer_funcs(adev);
 	amdgpu_sdma_set_vm_pte_scheds(adev, &sdma_v4_0_vm_pte_funcs);
 	sdma_v4_0_set_irq_funcs(adev);
 	sdma_v4_0_set_ras_funcs(adev);
@@ -1961,6 +1960,7 @@ static int sdma_v4_0_sw_fini(struct amdgpu_ip_block *ip_block)
 static int sdma_v4_0_hw_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
+	int r;
 
 	if (adev->flags & AMD_IS_APU)
 		amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_SDMA, false, 0);
@@ -1968,7 +1968,12 @@ static int sdma_v4_0_hw_init(struct amdgpu_ip_block *ip_block)
 	if (!amdgpu_sriov_vf(adev))
 		sdma_v4_0_init_golden_registers(adev);
 
-	return sdma_v4_0_start(adev);
+	r = sdma_v4_0_start(adev);
+	if (r)
+		return r;
+	sdma_v4_0_set_buffer_funcs(adev);
+
+	return 0;
 }
 
 static int sdma_v4_0_hw_fini(struct amdgpu_ip_block *ip_block)
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 67e9697301b4..88428b88e00f 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1368,7 +1368,6 @@ static int sdma_v4_4_2_early_init(struct amdgpu_ip_block *ip_block)
 		adev->sdma.has_page_queue = true;
 
 	sdma_v4_4_2_set_ring_funcs(adev);
-	sdma_v4_4_2_set_buffer_funcs(adev);
 	amdgpu_sdma_set_vm_pte_scheds(adev, &sdma_v4_4_2_vm_pte_funcs);
 	sdma_v4_4_2_set_irq_funcs(adev);
 	sdma_v4_4_2_set_ras_funcs(adev);
@@ -1568,8 +1567,11 @@ static int sdma_v4_4_2_hw_init(struct amdgpu_ip_block *ip_block)
 		sdma_v4_4_2_inst_init_golden_registers(adev, inst_mask);
 
 	r = sdma_v4_4_2_inst_start(adev, inst_mask, false);
+	if (r)
+		return r;
+	sdma_v4_4_2_set_buffer_funcs(adev);
 
-	return r;
+	return 0;
 }
 
 static int sdma_v4_4_2_hw_fini(struct amdgpu_ip_block *ip_block)
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 86f5eb784d57..fa02907217e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -1373,7 +1373,6 @@ static int sdma_v5_0_early_init(struct amdgpu_ip_block *ip_block)
 		return r;
 
 	sdma_v5_0_set_ring_funcs(adev);
-	sdma_v5_0_set_buffer_funcs(adev);
 	amdgpu_sdma_set_vm_pte_scheds(adev, &sdma_v5_0_vm_pte_funcs);
 	sdma_v5_0_set_irq_funcs(adev);
 	sdma_v5_0_set_mqd_funcs(adev);
@@ -1472,8 +1471,11 @@ static int sdma_v5_0_hw_init(struct amdgpu_ip_block *ip_block)
 	sdma_v5_0_init_golden_registers(adev);
 
 	r = sdma_v5_0_start(adev);
+	if (r)
+		return r;
+	sdma_v5_0_set_buffer_funcs(adev);
 
-	return r;
+	return 0;
 }
 
 static int sdma_v5_0_hw_fini(struct amdgpu_ip_block *ip_block)
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 3fec838374b2..f6ecbc524c9b 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -1264,7 +1264,6 @@ static int sdma_v5_2_early_init(struct amdgpu_ip_block *ip_block)
 		return r;
 
 	sdma_v5_2_set_ring_funcs(adev);
-	sdma_v5_2_set_buffer_funcs(adev);
 	amdgpu_sdma_set_vm_pte_scheds(adev, &sdma_v5_2_vm_pte_funcs);
 	sdma_v5_2_set_irq_funcs(adev);
 	sdma_v5_2_set_mqd_funcs(adev);
@@ -1385,8 +1384,14 @@ static int sdma_v5_2_sw_fini(struct amdgpu_ip_block *ip_block)
 static int sdma_v5_2_hw_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
+	int r;
 
-	return sdma_v5_2_start(adev);
+	r = sdma_v5_2_start(adev);
+	if (r)
+		return r;
+	sdma_v5_2_set_buffer_funcs(adev);
+
+	return 0;
 }
 
 static int sdma_v5_2_hw_fini(struct amdgpu_ip_block *ip_block)
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 064508cecd11..ee83d3e5978e 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1313,7 +1313,6 @@ static int sdma_v6_0_early_init(struct amdgpu_ip_block *ip_block)
 		return r;
 
 	sdma_v6_0_set_ring_funcs(adev);
-	sdma_v6_0_set_buffer_funcs(adev);
 	amdgpu_sdma_set_vm_pte_scheds(adev, &sdma_v6_0_vm_pte_funcs);
 	sdma_v6_0_set_irq_funcs(adev);
 	sdma_v6_0_set_mqd_funcs(adev);
@@ -1477,6 +1476,7 @@ static int sdma_v6_0_hw_init(struct amdgpu_ip_block *ip_block)
 	r = sdma_v6_0_start(adev);
 	if (r)
 		return r;
+	sdma_v6_0_set_buffer_funcs(adev);
 
 	return sdma_v6_0_set_userq_trap_interrupts(adev, true);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index 60447729271e..c8343981c596 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -1299,7 +1299,6 @@ static int sdma_v7_0_early_init(struct amdgpu_ip_block *ip_block)
 	}
 
 	sdma_v7_0_set_ring_funcs(adev);
-	sdma_v7_0_set_buffer_funcs(adev);
 	amdgpu_sdma_set_vm_pte_scheds(adev, &sdma_v7_0_vm_pte_funcs);
 	sdma_v7_0_set_irq_funcs(adev);
 	sdma_v7_0_set_mqd_funcs(adev);
@@ -1432,6 +1431,7 @@ static int sdma_v7_0_hw_init(struct amdgpu_ip_block *ip_block)
 	r = sdma_v7_0_start(adev);
 	if (r)
 		return r;
+	sdma_v7_0_set_buffer_funcs(adev);
 
 	return sdma_v7_0_set_userq_trap_interrupts(adev, true);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
index c3428d2731dc..b1ca95c2623b 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
@@ -1275,7 +1275,6 @@ static int sdma_v7_1_early_init(struct amdgpu_ip_block *ip_block)
 	}
 
 	sdma_v7_1_set_ring_funcs(adev);
-	sdma_v7_1_set_buffer_funcs(adev);
 	amdgpu_sdma_set_vm_pte_scheds(adev, &sdma_v7_1_vm_pte_funcs);
 	sdma_v7_1_set_irq_funcs(adev);
 	sdma_v7_1_set_mqd_funcs(adev);
@@ -1374,10 +1373,16 @@ static int sdma_v7_1_hw_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 	uint32_t inst_mask;
+	int r;
 
 	inst_mask = GENMASK(adev->sdma.num_instances - 1, 0);
 
-	return sdma_v7_1_inst_start(adev, inst_mask);
+	r = sdma_v7_1_inst_start(adev, inst_mask);
+	if (r)
+		return r;
+	sdma_v7_1_set_buffer_funcs(adev);
+
+	return 0;
 }
 
 static int sdma_v7_1_hw_fini(struct amdgpu_ip_block *ip_block)
diff --git a/drivers/gpu/drm/amd/amdgpu/si_dma.c b/drivers/gpu/drm/amd/amdgpu/si_dma.c
index 155067c20a0e..549708075eb4 100644
--- a/drivers/gpu/drm/amd/amdgpu/si_dma.c
+++ b/drivers/gpu/drm/amd/amdgpu/si_dma.c
@@ -487,7 +487,6 @@ static int si_dma_early_init(struct amdgpu_ip_block *ip_block)
 	adev->sdma.num_instances = SDMA_MAX_INSTANCE;
 
 	si_dma_set_ring_funcs(adev);
-	si_dma_set_buffer_funcs(adev);
 	amdgpu_sdma_set_vm_pte_scheds(adev, &si_dma_vm_pte_funcs);
 	si_dma_set_irq_funcs(adev);
 
@@ -543,8 +542,14 @@ static int si_dma_sw_fini(struct amdgpu_ip_block *ip_block)
 static int si_dma_hw_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
+	int r;
 
-	return si_dma_start(adev);
+	r = si_dma_start(adev);
+	if (r)
+		return r;
+	si_dma_set_buffer_funcs(adev);
+
+	return 0;
 }
 
 static int si_dma_hw_fini(struct amdgpu_ip_block *ip_block)
-- 
2.43.0

