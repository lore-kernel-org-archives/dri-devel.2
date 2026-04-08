Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D54061073C8A
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 10:07:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 304E410E5FD;
	Wed,  8 Apr 2026 10:07:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KfHqwmP2";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010022.outbound.protection.outlook.com [52.101.201.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40D4B10E5FA;
 Wed,  8 Apr 2026 10:07:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c7LubVpdQBlP4kWtgOlSrrQk7luTMgIVouamo69W9BOXKzIdwv9+ytnJgzDx028/t0jYG1n8eFUEugYR9mqfdXcOb4LB8JfhZE4rPqQeAwbpqtkiHGF3PK6b8Qr/Wr3Ph0iU1VBtY8iKRqAVWjH/JO7+7aJhhJfDGkE7wBB1qqxDvPYusCtL9W1EpCzl6gPIoeEFWCs5s2JHEEmDspyigjtgs3Z+jvIl6tOEFY5J1+vrTNGtGTblZt4H5u3h3bBfz51sihBHgRjiJt+LOxdBJp9UqbHRzRyaYPTpbSx4qUkC3ec6YMXB9Mocm4VU07wQf4dY8nAibOgb9nhu9xVQyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qjrREOGjeZUc664yhmfUQ4u7gEWdT/I3o0ZnKpzLNqw=;
 b=MKG8OZjR5f9p8Dn9207DeiJQwGZHi3+RvuNGiH+wuv9sLlfKHuQ5miBs2UriqyS4669gDE1SGQaWj/s9SC+6BgQZsQ7Gdf0U53LzpoiFE68+EXaYwyjtkjKvZp2Qa3eB3MGDIzlvNuQtGO3xwdVhPjJoNU+3Vn5P6PFCLOdpgrrAxVZhF++YD8+zzKlRQMurtJLNKr6EPkrkfSr1NbCJjv6pGm/iLaZlnkf6S9sySZSTyvIfef2PqKNStFXNwvkapGVC8d/JsPxd0K7cfuTA+k8/vjAvdIS1/ebtslDArlInBTBIioVYPCnQxFHD2yf35BxuT58V9m49FxFvqAs74w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qjrREOGjeZUc664yhmfUQ4u7gEWdT/I3o0ZnKpzLNqw=;
 b=KfHqwmP2Iz/+/BeFSP7AD5tGMtvema5RFFoxx5FtjCn1yQfbfw3YqFiDpNDstRY6mrd1XJ+OUWCY2ys0XmMXuQavFa5BMeUbKdxYN5kgwnGU4FVAl4XUMMxRC/vnjFH9jmex55hR8PyARl2PjDiqzLMZBnDb9vTVlAnfUesU6Lo=
Received: from PH7PR02CA0001.namprd02.prod.outlook.com (2603:10b6:510:33d::18)
 by IA0PR12MB8226.namprd12.prod.outlook.com (2603:10b6:208:403::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Wed, 8 Apr
 2026 10:07:33 +0000
Received: from CY4PEPF0000EDD3.namprd03.prod.outlook.com
 (2603:10b6:510:33d:cafe::e) by PH7PR02CA0001.outlook.office365.com
 (2603:10b6:510:33d::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.37 via Frontend Transport; Wed,
 8 Apr 2026 10:07:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD3.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 8 Apr 2026 10:07:32 +0000
Received: from FRAPPELLOUX01-WSLPUB.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 8 Apr 2026 05:07:31 -0500
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 7/8] drm/amdgpu: split amdgpu_ttm_set_buffer_funcs_status
 in 2 funcs
Date: Wed, 8 Apr 2026 12:03:18 +0200
Message-ID: <20260408100327.1372-7-pierre-eric.pelloux-prayer@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD3:EE_|IA0PR12MB8226:EE_
X-MS-Office365-Filtering-Correlation-Id: aa12b3bb-e526-414e-6896-08de9556a6b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: UOCNiFNbAHtzqJkWSqVtGdn91otukDblS7WidLOSR5tr1mbt1AWb6RnAs1ksTcXKu/iNLiyRPpAcLUSFCLuHXcseByyhBkTrcPOy7MVZPEGjdl999W8JhzrXPahTPFyaca7h0laxpNsS/2VmDJQimxJWmo1u+aOBXj5zKBmn/y29B2DxcztlnHwqAwTASO4jw0ldWnwABzKlKBMOtWYNTNPZeDFxSmIXjxH+ZYZJOH40V0MjLSjE2w/e3tUoQ/eNJGHYgdoWfMBLAKTIXBfjDMs96Tngj63wBX74ULVt7dUeNIiZ1J3S1dgOam2285zKj/+nJD/EOYXqWmkfihM1te0muDpqhF6dKcifckzO0qC1iOv1488MQwjpC6CwXUzrJdgvFhwDiLejX7nHx56BTcw7ZHYpnPEp70bVSq4EFfMPbnkwMiGufBU728nkOsUrpNzAuSMWpvHpWVNt/lUaXFCfHnc58HabRS5nbg1eOczaXtbzprmMk+Bal/su4n3v/D361gt1+8epuohRjbYzyX1xLkhtoeds/4cfyfY/jxQnaeJad8XTqoz+XDOwBMF1iFm0SxGoogoIiRVsXkaUUy7VaRNb9sIuA4PO3MjvC9qEUqGRHjVe7XxVNlPImT6f5HI2I4UBXbCkHPmW/4Le/T1xXuogp0DCEjlPBGjuHOEZPj5LxSsD7UIZUjBSV2Ut6BA3XtSiTh6+z+t/Ys+ZlD0QKdZPpul/v1JcRfwabvCEHtqVnJXMc56Xsc20QHkmcz5noqGAF8ABp45gneWQqQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0Q64kHw3aW3UHVNMd5q5osHYl0P/9g5cZPDEhQKtdu17iNdX1lMtJlxqjMfiFMjAk9XytCrgx7qoo6zJp+BL5B1cOu5iUiNgyTm5RirQUc3YtyJHI3yg4gWjWRBf/I2XO6WcdHmpHjMJyA8iAn4W1ZdFb9YUdOmDIiwL6pdXBu9OE0yBhC9FCh2Z0aNSc3WNBr5VGI1Hnkk5LZkYK5O9+ZT+sv2AVIrfS4PbMp93A4ik1mo7f/JyPBrZNrTa12enwXrcmAToYP7iIPp33NfdMfEOpX9QaNSyfkC1nz3ctgzcKcLciz3BAXaQ96kxt1eQ37OZF5o07YTp2mCdwFqA4PP/j3HOof129I6oxzvJyJ+XIWIhAKT+ySQLayrhdUXQ8lxPeoPg2M2ClqDyv94boEsfecnOtoVJ3dfZvJoaw8PxsKX8E/UJ0XD0qFvafYjZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 10:07:32.8933 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa12b3bb-e526-414e-6896-08de9556a6b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8226
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

Makes a code slightly clearer and reduces indentation.

---
v5: use amdgpu_in_reset in amdgpu_ttm_disable_buffer_funcs
---

Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  14 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    | 188 +++++++++++----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h    |   4 +-
 3 files changed, 109 insertions(+), 97 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 4da8de34be3d..a24f52e71850 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2463,7 +2463,7 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 	if (r)
 		goto init_failed;
 
-	amdgpu_ttm_set_buffer_funcs_status(adev, true);
+	amdgpu_ttm_enable_buffer_funcs(adev);
 
 	/* Don't init kfd if whole hive need to be reset during init */
 	if (adev->init_lvl->level != AMDGPU_INIT_LEVEL_MINIMAL_XGMI) {
@@ -3147,7 +3147,7 @@ static int amdgpu_device_ip_suspend(struct amdgpu_device *adev)
 		amdgpu_virt_request_full_gpu(adev, false);
 	}
 
-	amdgpu_ttm_set_buffer_funcs_status(adev, false);
+	amdgpu_ttm_disable_buffer_funcs(adev);
 
 	r = amdgpu_device_ip_suspend_phase1(adev);
 	if (r)
@@ -3362,7 +3362,7 @@ static int amdgpu_device_ip_resume(struct amdgpu_device *adev)
 
 	r = amdgpu_device_ip_resume_phase2(adev);
 
-	amdgpu_ttm_set_buffer_funcs_status(adev, true);
+	amdgpu_ttm_enable_buffer_funcs(adev);
 
 	if (r)
 		return r;
@@ -4215,7 +4215,7 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
 	/* disable ras feature must before hw fini */
 	amdgpu_ras_pre_fini(adev);
 
-	amdgpu_ttm_set_buffer_funcs_status(adev, false);
+	amdgpu_ttm_disable_buffer_funcs(adev);
 
 	/*
 	 * device went through surprise hotplug; we need to destroy topology
@@ -4482,7 +4482,7 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
 	if (r)
 		goto unwind_userq;
 
-	amdgpu_ttm_set_buffer_funcs_status(adev, false);
+	amdgpu_ttm_disable_buffer_funcs(adev);
 
 	amdgpu_fence_driver_hw_fini(adev);
 
@@ -4496,7 +4496,7 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
 	return 0;
 
 unwind_evict:
-	amdgpu_ttm_set_buffer_funcs_status(adev, true);
+	amdgpu_ttm_enable_buffer_funcs(adev);
 	amdgpu_fence_driver_hw_init(adev);
 
 unwind_userq:
@@ -5230,7 +5230,7 @@ int amdgpu_device_reinit_after_reset(struct amdgpu_reset_context *reset_context)
 				if (r)
 					goto out;
 
-				amdgpu_ttm_set_buffer_funcs_status(tmp_adev, true);
+				amdgpu_ttm_enable_buffer_funcs(tmp_adev);
 
 				r = amdgpu_device_ip_resume_phase3(tmp_adev);
 				if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 8d778cbce1aa..000f66452b10 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -2100,7 +2100,7 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 	}
 
 	/* Change the size here instead of the init above so only lpfn is affected */
-	amdgpu_ttm_set_buffer_funcs_status(adev, false);
+	amdgpu_ttm_disable_buffer_funcs(adev);
 #ifdef CONFIG_64BIT
 #ifdef CONFIG_X86
 	if (adev->gmc.xgmi.connected_to_cpu)
@@ -2329,116 +2329,92 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
 }
 
 /**
- * amdgpu_ttm_set_buffer_funcs_status - enable/disable use of buffer functions
+ * amdgpu_ttm_enable_buffer_funcs - enable use of buffer functions
  *
  * @adev: amdgpu_device pointer
- * @enable: true when we can use buffer functions.
  *
- * Enable/disable use of buffer functions during suspend/resume. This should
+ * Enable use of buffer functions during suspend/resume. This should
  * only be called at bootup or when userspace isn't running.
  */
-void amdgpu_ttm_set_buffer_funcs_status(struct amdgpu_device *adev, bool enable)
+void amdgpu_ttm_enable_buffer_funcs(struct amdgpu_device *adev)
 {
 	struct ttm_resource_manager *man = ttm_manager_type(&adev->mman.bdev, TTM_PL_VRAM);
 	u32 num_clear_entities, num_move_entities;
-	uint64_t size;
 	int r, i, j;
 
 	if (!adev->mman.initialized || amdgpu_in_reset(adev) ||
-	    adev->mman.buffer_funcs_enabled == enable || adev->gmc.is_app_apu)
+	    adev->mman.buffer_funcs_enabled || adev->gmc.is_app_apu)
 		return;
 
-	if (enable) {
-		if (!adev->mman.num_buffer_funcs_scheds) {
-			dev_warn(adev->dev, "Not enabling DMA transfers for in kernel use");
-			return;
-		}
+	if (!adev->mman.num_buffer_funcs_scheds) {
+		dev_warn(adev->dev, "Not enabling DMA transfers for in kernel use");
+		return;
+	}
+
+	/* default_entity doesn't need multiple schedulers so pass only 1. */
+	r = amdgpu_ttm_buffer_entity_init(&adev->mman.gtt_mgr,
+						&adev->mman.default_entity,
+						DRM_SCHED_PRIORITY_KERNEL,
+						adev->mman.buffer_funcs_scheds, 1, 0);
+	if (r < 0) {
+		dev_err(adev->dev,
+			"Failed setting up TTM entity (%d)\n", r);
+		return;
+	}
+
+	num_clear_entities = MIN(adev->mman.num_buffer_funcs_scheds, TTM_NUM_MOVE_FENCES);
+	num_move_entities = MIN(adev->mman.num_buffer_funcs_scheds, TTM_NUM_MOVE_FENCES);
+
+	adev->mman.clear_entities = kcalloc(num_clear_entities,
+						sizeof(struct amdgpu_ttm_buffer_entity),
+						GFP_KERNEL);
+	atomic_set(&adev->mman.next_clear_entity, 0);
+	if (!adev->mman.clear_entities)
+		goto error_free_default_entity;
+
+	adev->mman.num_clear_entities = num_clear_entities;
+
+	for (i = 0; i < num_clear_entities; i++) {
+		r = amdgpu_ttm_buffer_entity_init(
+			&adev->mman.gtt_mgr,
+			&adev->mman.clear_entities[i],
+			DRM_SCHED_PRIORITY_NORMAL,
+			adev->mman.buffer_funcs_scheds,
+			adev->mman.num_buffer_funcs_scheds, 1);
 
-		num_clear_entities = MIN(adev->mman.num_buffer_funcs_scheds, TTM_NUM_MOVE_FENCES);
-		num_move_entities = MIN(adev->mman.num_buffer_funcs_scheds, TTM_NUM_MOVE_FENCES);
-		/* default_entity doesn't need multiple schedulers so pass only 1. */
-		r = amdgpu_ttm_buffer_entity_init(&adev->mman.gtt_mgr,
-						  &adev->mman.default_entity,
-						  DRM_SCHED_PRIORITY_KERNEL,
-						  adev->mman.buffer_funcs_scheds, 1, 0);
 		if (r < 0) {
-			dev_err(adev->dev,
-				"Failed setting up TTM entity (%d)\n", r);
-			return;
-		}
-
-		adev->mman.clear_entities = kcalloc(num_clear_entities,
-						    sizeof(struct amdgpu_ttm_buffer_entity),
-						    GFP_KERNEL);
-		atomic_set(&adev->mman.next_clear_entity, 0);
-		if (!adev->mman.clear_entities)
+			for (j = 0; j < i; j++)
+				amdgpu_ttm_buffer_entity_fini(
+					&adev->mman.gtt_mgr, &adev->mman.clear_entities[j]);
+			adev->mman.num_clear_entities = 0;
+			kfree(adev->mman.clear_entities);
 			goto error_free_default_entity;
-
-		adev->mman.num_clear_entities = num_clear_entities;
-
-		for (i = 0; i < num_clear_entities; i++) {
-			r = amdgpu_ttm_buffer_entity_init(
-				&adev->mman.gtt_mgr,
-				&adev->mman.clear_entities[i],
-				DRM_SCHED_PRIORITY_NORMAL,
-				adev->mman.buffer_funcs_scheds,
-				adev->mman.num_buffer_funcs_scheds, 1);
-
-			if (r < 0) {
-				for (j = 0; j < i; j++)
-					amdgpu_ttm_buffer_entity_fini(
-						&adev->mman.gtt_mgr, &adev->mman.clear_entities[j]);
-				kfree(adev->mman.clear_entities);
-				adev->mman.num_clear_entities = 0;
-				adev->mman.clear_entities = NULL;
-				goto error_free_default_entity;
-			}
 		}
+	}
 
-		adev->mman.num_move_entities = num_move_entities;
-		atomic_set(&adev->mman.next_move_entity, 0);
-		for (i = 0; i < num_move_entities; i++) {
-			r = amdgpu_ttm_buffer_entity_init(
-				&adev->mman.gtt_mgr,
-				&adev->mman.move_entities[i],
-				DRM_SCHED_PRIORITY_NORMAL,
-				adev->mman.buffer_funcs_scheds,
-				adev->mman.num_buffer_funcs_scheds, 2);
+	adev->mman.num_move_entities = num_move_entities;
+	atomic_set(&adev->mman.next_move_entity, 0);
+	for (i = 0; i < num_move_entities; i++) {
+		r = amdgpu_ttm_buffer_entity_init(
+			&adev->mman.gtt_mgr,
+			&adev->mman.move_entities[i],
+			DRM_SCHED_PRIORITY_NORMAL,
+			adev->mman.buffer_funcs_scheds,
+			adev->mman.num_buffer_funcs_scheds, 2);
 
-			if (r < 0) {
-				for (j = 0; j < i; j++)
-					amdgpu_ttm_buffer_entity_fini(
-						&adev->mman.gtt_mgr, &adev->mman.move_entities[j]);
-				adev->mman.num_move_entities = 0;
-				goto error_free_clear_entities;
-			}
+		if (r < 0) {
+			for (j = 0; j < i; j++)
+				amdgpu_ttm_buffer_entity_fini(
+					&adev->mman.gtt_mgr,
+					&adev->mman.move_entities[j]);
+			adev->mman.num_move_entities = 0;
+			goto error_free_clear_entities;
 		}
-	} else {
-		amdgpu_ttm_buffer_entity_fini(&adev->mman.gtt_mgr,
-					      &adev->mman.default_entity);
-		for (i = 0; i < adev->mman.num_clear_entities; i++)
-			amdgpu_ttm_buffer_entity_fini(&adev->mman.gtt_mgr,
-						      &adev->mman.clear_entities[i]);
-		for (i = 0; i < adev->mman.num_move_entities; i++)
-			amdgpu_ttm_buffer_entity_fini(&adev->mman.gtt_mgr,
-						      &adev->mman.move_entities[i]);
-		/* Drop all the old fences since re-creating the scheduler entities
-		 * will allocate new contexts.
-		 */
-		ttm_resource_manager_cleanup(man);
-		kfree(adev->mman.clear_entities);
-		adev->mman.clear_entities = NULL;
-		adev->mman.num_clear_entities = 0;
-		adev->mman.num_move_entities = 0;
 	}
 
 	/* this just adjusts TTM size idea, which sets lpfn to the correct value */
-	if (enable)
-		size = adev->gmc.real_vram_size;
-	else
-		size = adev->gmc.visible_vram_size;
-	man->size = size;
-	adev->mman.buffer_funcs_enabled = enable;
+	man->size = adev->gmc.real_vram_size;
+	adev->mman.buffer_funcs_enabled = true;
 
 	return;
 
@@ -2454,6 +2430,42 @@ void amdgpu_ttm_set_buffer_funcs_status(struct amdgpu_device *adev, bool enable)
 				      &adev->mman.default_entity);
 }
 
+/**
+ * amdgpu_ttm_disable_buffer_funcs - disable use of buffer functions
+ *
+ * @adev: amdgpu_device pointer
+ */
+void amdgpu_ttm_disable_buffer_funcs(struct amdgpu_device *adev)
+{
+	struct ttm_resource_manager *man =
+		ttm_manager_type(&adev->mman.bdev, TTM_PL_VRAM);
+	int i;
+
+	if (!adev->mman.buffer_funcs_enabled || amdgpu_in_reset(adev))
+		return;
+
+	amdgpu_ttm_buffer_entity_fini(&adev->mman.gtt_mgr,
+				      &adev->mman.default_entity);
+	for (i = 0; i < adev->mman.num_move_entities; i++)
+		amdgpu_ttm_buffer_entity_fini(&adev->mman.gtt_mgr,
+					      &adev->mman.move_entities[i]);
+	for (i = 0; i < adev->mman.num_clear_entities; i++)
+		amdgpu_ttm_buffer_entity_fini(&adev->mman.gtt_mgr,
+					      &adev->mman.clear_entities[i]);
+	/* Drop all the old fences since re-creating the scheduler entities
+	 * will allocate new contexts.
+	 */
+	ttm_resource_manager_cleanup(man);
+
+	kfree(adev->mman.clear_entities);
+	adev->mman.clear_entities = NULL;
+	adev->mman.num_clear_entities = 0;
+	adev->mman.num_move_entities = 0;
+
+	man->size = adev->gmc.visible_vram_size;
+	adev->mman.buffer_funcs_enabled = false;
+}
+
 static int amdgpu_ttm_prepare_job(struct amdgpu_device *adev,
 				  struct amdgpu_ttm_buffer_entity *entity,
 				  unsigned int num_dw,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index d7b14d5cac77..8a5f34aaabac 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -178,8 +178,8 @@ bool amdgpu_res_cpu_visible(struct amdgpu_device *adev,
 
 int amdgpu_ttm_init(struct amdgpu_device *adev);
 void amdgpu_ttm_fini(struct amdgpu_device *adev);
-void amdgpu_ttm_set_buffer_funcs_status(struct amdgpu_device *adev,
-					bool enable);
+void amdgpu_ttm_enable_buffer_funcs(struct amdgpu_device *adev);
+void amdgpu_ttm_disable_buffer_funcs(struct amdgpu_device *adev);
 int amdgpu_copy_buffer(struct amdgpu_device *adev,
 		       struct amdgpu_ttm_buffer_entity *entity,
 		       uint64_t src_offset,
-- 
2.43.0

