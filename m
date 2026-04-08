Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADD331073C8A
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 10:05:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A254610E5D0;
	Wed,  8 Apr 2026 10:05:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="A1YQAiBT";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010039.outbound.protection.outlook.com [52.101.61.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6D2410E5C6;
 Wed,  8 Apr 2026 10:05:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x0RZKWDaGXtKr2ZNLO/zgEZuGawcsV06dvoEFEL5eXBkWvDprCAo5HfvcKlGc2i26UBHVLyUm5ejUmTSD4oqRqFTJpyfNBdOadLF3VVSz4Achjit9zfa8706U179h0ZuiFWSX6zlmxE++xIg1UuKvuwJib34tMA/OlaLiGU1k8ENUd9n7Eh/FIBGFOS28x6oeg6b5snkVfE+euKpHHnHYQfkc6VFw6/0WMOyWZZc8dXcGH9WhiwMUDtEuSrpxFC6ncbhXp3I0r9IClNPfUM8k03vLpNajcQnV3oBwVz1UrEdkAIOOK+LeKP6Sy+XqP/5ZhDZvjkf3KDKZwrud7XIeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jegV5SxGlRM0+K8aAiQxqQiTZ0EZfwyRmu+CIWHsEsY=;
 b=KfYFbqRNlc0wsiFateuic+CuD9Q6qaOXEYS/LQzrw/zSCVpvQ+6VUlJHleygJiw71dO6djIWadlvRJcZEvjllFFaGk5/gYICnIZw6CHVfetM7x1kJQFQF4e+xFYs+J/Wnc/6PcpSIVpjL39cIG2yySCXlaf6/mBLnMrKoVkzkEH2D7u4A65P/Sw7vxTmC1YTihKJ8XO4Z8swBXqNIcTcdFmR9ezv1IF/SdKtNHrFRfTeaqZ8yAHIXaD8+EoPDlMibagho87LgJJKN0OSmf6nEfBs8JoR07gKZWvj6Gze6UYmsBykdbf5xoyaUMlr6aL9EzY03vPjiBIN72lT8cNqsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jegV5SxGlRM0+K8aAiQxqQiTZ0EZfwyRmu+CIWHsEsY=;
 b=A1YQAiBTrr2aCMSYbgkl7a5BzHdqi1MW3JtZUERh0ypsqhnYruWaFUygkvuhp7qHMY4h5QhG/s5zpdfVrI83WHhvIUbq0vbyhQm8appltxV6oaNFoLe3D5XL8awyWmKTwaz2SYoseoD1XbeFCaR45yWRS8iWgwDrfXg0VE6sez4=
Received: from CY5PR15CA0207.namprd15.prod.outlook.com (2603:10b6:930:82::26)
 by LV9PR12MB9808.namprd12.prod.outlook.com (2603:10b6:408:2e7::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 8 Apr
 2026 10:05:13 +0000
Received: from CY4PEPF0000EDD7.namprd03.prod.outlook.com
 (2603:10b6:930:82:cafe::d7) by CY5PR15CA0207.outlook.office365.com
 (2603:10b6:930:82::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.33 via Frontend Transport; Wed,
 8 Apr 2026 10:05:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD7.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 8 Apr 2026 10:05:12 +0000
Received: from FRAPPELLOUX01-WSLPUB.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 8 Apr 2026 05:05:10 -0500
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Felix Kuehling
 <Felix.Kuehling@amd.com>
CC: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>, "Felix
 Kuehling" <felix.kuehling@amd.com>, <amd-gfx@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 1/8] drm/amdgpu: pass all the sdma scheds to amdgpu_mman
Date: Wed, 8 Apr 2026 12:03:12 +0200
Message-ID: <20260408100327.1372-1-pierre-eric.pelloux-prayer@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD7:EE_|LV9PR12MB9808:EE_
X-MS-Office365-Filtering-Correlation-Id: 71858260-be7d-466d-a3e9-08de95565312
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 90fvwXHdyLd4V72gurPUhiitCGUJyJZXQzyabC5lof/077TxPB2w19lzwkSi9/uqX1ADu3+KXN3jHwTtmq93aBGkk3OdRfX/qo9IzUbpHsIab2a8+K3QSXwKLpxnXsaO4mmpW+gDz7N7RQcHhtUgie5EqM5z152MM5wfCBZz12wLGJJpt630xRULifEuM+0PEeJOZWh75Qp7aPHMtCA5nGSxf7phQQd9SZNfJdUgmJwJrX/NniK5zhmlgxTZ+NEYJbgnlvcbR/7SKfEUvHeXs3vFAA3+uRg0iaf9Arwo31agQv8Xa9wnO/Hq8YO4BPmVwb/ucQqOCW4vv/bM5lMBdDwT/aYKE5E4ehsm6zvFwk+DBUjdwKmU2/cMTG/Xwi+3SGwoyvpQkdLYDRBKRcIkXxSOUiT6KrcRRFss+sIZ0bVOmHNi3FcVu7rj+IEVwtJlkO31MeKi6vpeUYBlq3PFDQnNZn23KmuWGC/BQIzjjkivVaW3HQ3mNfHTddNd8yNiT27Sh4HfU3RydppIk3Hz9rijMwrBwMwEihhFF2cEShZBlWth4iRwEXU4tJ68RGmyBRUqj4ArLgZ2Nz7AhrdhGwOjpfpqSrOwi2/coHX+e0Vxwr0P8BX3otdMFF+aPyzQJS74RB90jKZ6Y+1/Cq2sRXQlFr6ll2Q3O44ic1SMG2QmlnF9wegYuTDhA+ZCfWFWOsNZR3HY6Euu0AiTK3IW7ndb0p9H/OLXXtgoxvrxIH+P9WTYGH0VnkWtNiJzMa4vtU7kcEp0al8ziz2CbWNryQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zufuax2o0c9DJYACIAVyLMCkDFdJ71ZUFVvE0JlUD389jj0c0XSBeUw9UvjHA5Ps4o8HjCGob1/78Z65nrxDIBgm+mkzy9RzPs4ttyl1As7Or7tQSlDkN5CLw00HsmzIRKcoz4CYm7y7I/cTROU7to10709h8c+frsu3hYQc45wNxtp2nMOTPsJyOSbTH7oH1vnJjVTITCyi0K+zxhy1vUw7hodjrDM+6SnAxllKIL7wP2VrTMLB8fD/09uHYvqtVu+NJdRxpKw8VbW8xbIIamaugsGpJdVRq2IwOWkLNKOZdZFsJpQoY6vPWMLaHSEUQp9S32E3ueP1XPkFvs0R9+Piz0AMUB0HY++jevGbORcfIFYQ2eARvPD6UQ56ZLs4p+tBBlRU+tPP4Oe82YrjsMzykGithfrqn9hgqxJQndk/Qc5555TpzHArd2sGv5Ux
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 10:05:12.5767 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71858260-be7d-466d-a3e9-08de95565312
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9808
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

This will allow the use of all of them for clear/fill buffer
operations.
Since drm_sched_entity_init requires a scheduler array, we
store schedulers rather than rings. For the few places that need
access to a ring, we can get it from the sched using container_of.

Since the code is the same for all sdma versions, add a new
helper amdgpu_sdma_set_buffer_funcs_scheds to set buffer_funcs_scheds
based on the number of sdma instances.

Note: the new sched array is identical to the amdgpu_vm_manager one.
These 2 could be merged.

Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Acked-by: Felix Kuehling <felix.kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c    |  4 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    | 36 ++++++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h    |  3 +-
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c      |  3 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c     |  3 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c     |  3 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c     |  8 ++---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c   |  6 +---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c     |  5 +--
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c     |  5 +--
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c     |  3 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c     |  3 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c     |  3 +-
 drivers/gpu/drm/amd/amdgpu/si_dma.c        |  3 +-
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c   |  3 +-
 17 files changed, 52 insertions(+), 43 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 49e7881750fa..e3a8701f0b27 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1467,6 +1467,8 @@ ssize_t amdgpu_get_soft_full_reset_mask(struct amdgpu_ring *ring);
 ssize_t amdgpu_show_reset_mask(char *buf, uint32_t supported_reset);
 void amdgpu_sdma_set_vm_pte_scheds(struct amdgpu_device *adev,
 				   const struct amdgpu_vm_pte_funcs *vm_pte_funcs);
+void amdgpu_sdma_set_buffer_funcs_scheds(struct amdgpu_device *adev,
+					 const struct amdgpu_buffer_funcs *buffer_funcs);
 
 /* atpx handler */
 #if defined(CONFIG_VGA_SWITCHEROO)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 0c0489395edf..4da8de34be3d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3700,7 +3700,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	adev->num_rings = 0;
 	RCU_INIT_POINTER(adev->gang_submit, dma_fence_get_stub());
 	adev->mman.buffer_funcs = NULL;
-	adev->mman.buffer_funcs_ring = NULL;
+	adev->mman.num_buffer_funcs_scheds = 0;
 	adev->vm_manager.vm_pte_funcs = NULL;
 	adev->vm_manager.vm_pte_num_scheds = 0;
 	adev->gmc.gmc_funcs = NULL;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index e9e53c7c37d0..1a253e4257ff 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -708,12 +708,14 @@ int amdgpu_gmc_allocate_vm_inv_eng(struct amdgpu_device *adev)
 void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 			      uint32_t vmhub, uint32_t flush_type)
 {
-	struct amdgpu_ring *ring = adev->mman.buffer_funcs_ring;
+	struct amdgpu_ring *ring;
 	struct amdgpu_vmhub *hub = &adev->vmhub[vmhub];
 	struct dma_fence *fence;
 	struct amdgpu_job *job;
 	int r;
 
+	ring = to_amdgpu_ring(adev->mman.buffer_funcs_scheds[0]);
+
 	if (!hub->sdma_invalidation_workaround || vmid ||
 	    !adev->mman.buffer_funcs_enabled || !adev->ib_pool_ready ||
 	    !ring->sched.ready) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 3c63f87832e4..63ec3938cd41 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -168,7 +168,7 @@ amdgpu_ttm_job_submit(struct amdgpu_device *adev, struct amdgpu_ttm_buffer_entit
 {
 	struct amdgpu_ring *ring;
 
-	ring = adev->mman.buffer_funcs_ring;
+	ring = to_amdgpu_ring(adev->mman.buffer_funcs_scheds[0]);
 	amdgpu_ring_pad_ib(ring, &job->ibs[0]);
 	WARN_ON(job->ibs[0].length_dw > num_dw);
 
@@ -2349,18 +2349,17 @@ void amdgpu_ttm_set_buffer_funcs_status(struct amdgpu_device *adev, bool enable)
 		return;
 
 	if (enable) {
-		struct amdgpu_ring *ring;
 		struct drm_gpu_scheduler *sched;
 
-		if (!adev->mman.buffer_funcs_ring || !adev->mman.buffer_funcs_ring->sched.ready) {
+		if (!adev->mman.num_buffer_funcs_scheds ||
+		    !adev->mman.buffer_funcs_scheds[0]->ready) {
 			dev_warn(adev->dev, "Not enabling DMA transfers for in kernel use");
 			return;
 		}
 
 		num_clear_entities = 1;
 		num_move_entities = 1;
-		ring = adev->mman.buffer_funcs_ring;
-		sched = &ring->sched;
+		sched = adev->mman.buffer_funcs_scheds[0];
 		r = amdgpu_ttm_buffer_entity_init(&adev->mman.gtt_mgr,
 						  &adev->mman.default_entity,
 						  DRM_SCHED_PRIORITY_KERNEL,
@@ -2497,7 +2496,7 @@ int amdgpu_copy_buffer(struct amdgpu_device *adev,
 	unsigned int i;
 	int r;
 
-	ring = adev->mman.buffer_funcs_ring;
+	ring = to_amdgpu_ring(adev->mman.buffer_funcs_scheds[0]);
 
 	if (!ring->sched.ready) {
 		dev_err(adev->dev,
@@ -2730,6 +2729,31 @@ int amdgpu_ttm_evict_resources(struct amdgpu_device *adev, int mem_type)
 	return ttm_resource_manager_evict_all(&adev->mman.bdev, man);
 }
 
+void amdgpu_sdma_set_buffer_funcs_scheds(struct amdgpu_device *adev,
+					 const struct amdgpu_buffer_funcs *buffer_funcs)
+{
+	struct drm_gpu_scheduler *sched;
+	struct amdgpu_vmhub *hub;
+	int i;
+
+	adev->mman.buffer_funcs = buffer_funcs;
+
+	for (i = 0; i < adev->sdma.num_instances; i++) {
+		if (adev->sdma.has_page_queue)
+			sched = &adev->sdma.instance[i].page.sched;
+		else
+			sched = &adev->sdma.instance[i].ring.sched;
+		adev->mman.buffer_funcs_scheds[i] = sched;
+	}
+
+	/* Navi1x's workaround requires us to limit to a single SDMA sched
+	 * for ttm.
+	 */
+	hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
+	adev->mman.num_buffer_funcs_scheds = hub->sdma_invalidation_workaround ?
+		1 : adev->sdma.num_instances;
+}
+
 #if defined(CONFIG_DEBUG_FS)
 
 static int amdgpu_ttm_page_pool_show(struct seq_file *m, void *unused)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index 3b1973611446..a6249252948b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -67,7 +67,8 @@ struct amdgpu_mman {
 
 	/* buffer handling */
 	const struct amdgpu_buffer_funcs	*buffer_funcs;
-	struct amdgpu_ring			*buffer_funcs_ring;
+	struct drm_gpu_scheduler		*buffer_funcs_scheds[AMDGPU_MAX_RINGS];
+	u32					num_buffer_funcs_scheds;
 	bool					buffer_funcs_enabled;
 
 	/* @default_entity: for workarounds, has no gart windows */
diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
index 22780c09177d..26276dcfd458 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
@@ -1340,8 +1340,7 @@ static const struct amdgpu_buffer_funcs cik_sdma_buffer_funcs = {
 
 static void cik_sdma_set_buffer_funcs(struct amdgpu_device *adev)
 {
-	adev->mman.buffer_funcs = &cik_sdma_buffer_funcs;
-	adev->mman.buffer_funcs_ring = &adev->sdma.instance[0].ring;
+	amdgpu_sdma_set_buffer_funcs_scheds(adev, &cik_sdma_buffer_funcs);
 }
 
 const struct amdgpu_ip_block_version cik_sdma_ip_block =
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
index 0090ace49024..c6a059ca59e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
@@ -1235,8 +1235,7 @@ static const struct amdgpu_buffer_funcs sdma_v2_4_buffer_funcs = {
 
 static void sdma_v2_4_set_buffer_funcs(struct amdgpu_device *adev)
 {
-	adev->mman.buffer_funcs = &sdma_v2_4_buffer_funcs;
-	adev->mman.buffer_funcs_ring = &adev->sdma.instance[0].ring;
+	amdgpu_sdma_set_buffer_funcs_scheds(adev, &sdma_v2_4_buffer_funcs);
 }
 
 const struct amdgpu_ip_block_version sdma_v2_4_ip_block = {
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
index 2526d393162a..cb516a25210d 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
@@ -1677,8 +1677,7 @@ static const struct amdgpu_buffer_funcs sdma_v3_0_buffer_funcs = {
 
 static void sdma_v3_0_set_buffer_funcs(struct amdgpu_device *adev)
 {
-	adev->mman.buffer_funcs = &sdma_v3_0_buffer_funcs;
-	adev->mman.buffer_funcs_ring = &adev->sdma.instance[0].ring;
+	amdgpu_sdma_set_buffer_funcs_scheds(adev, &sdma_v3_0_buffer_funcs);
 }
 
 const struct amdgpu_ip_block_version sdma_v3_0_ip_block =
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 44f0f23e1148..d56be26f216b 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -2626,13 +2626,9 @@ static const struct amdgpu_buffer_funcs sdma_v4_4_buffer_funcs = {
 static void sdma_v4_0_set_buffer_funcs(struct amdgpu_device *adev)
 {
 	if (amdgpu_ip_version(adev, SDMA0_HWIP, 0) >= IP_VERSION(4, 4, 0))
-		adev->mman.buffer_funcs = &sdma_v4_4_buffer_funcs;
+		amdgpu_sdma_set_buffer_funcs_scheds(adev, &sdma_v4_4_buffer_funcs);
 	else
-		adev->mman.buffer_funcs = &sdma_v4_0_buffer_funcs;
-	if (adev->sdma.has_page_queue)
-		adev->mman.buffer_funcs_ring = &adev->sdma.instance[0].page;
-	else
-		adev->mman.buffer_funcs_ring = &adev->sdma.instance[0].ring;
+		amdgpu_sdma_set_buffer_funcs_scheds(adev, &sdma_v4_0_buffer_funcs);
 }
 
 static void sdma_v4_0_get_ras_error_count(uint32_t value,
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 78bdfed0a7fd..67e9697301b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -2316,11 +2316,7 @@ static const struct amdgpu_buffer_funcs sdma_v4_4_2_buffer_funcs = {
 
 static void sdma_v4_4_2_set_buffer_funcs(struct amdgpu_device *adev)
 {
-	adev->mman.buffer_funcs = &sdma_v4_4_2_buffer_funcs;
-	if (adev->sdma.has_page_queue)
-		adev->mman.buffer_funcs_ring = &adev->sdma.instance[0].page;
-	else
-		adev->mman.buffer_funcs_ring = &adev->sdma.instance[0].ring;
+	amdgpu_sdma_set_buffer_funcs_scheds(adev, &sdma_v4_4_2_buffer_funcs);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 52f4e9e099cb..86f5eb784d57 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -2052,10 +2052,7 @@ static const struct amdgpu_buffer_funcs sdma_v5_0_buffer_funcs = {
 
 static void sdma_v5_0_set_buffer_funcs(struct amdgpu_device *adev)
 {
-	if (adev->mman.buffer_funcs == NULL) {
-		adev->mman.buffer_funcs = &sdma_v5_0_buffer_funcs;
-		adev->mman.buffer_funcs_ring = &adev->sdma.instance[0].ring;
-	}
+	amdgpu_sdma_set_buffer_funcs_scheds(adev, &sdma_v5_0_buffer_funcs);
 }
 
 const struct amdgpu_ip_block_version sdma_v5_0_ip_block = {
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index b4fb90cc8f7d..3fec838374b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -2056,10 +2056,7 @@ static const struct amdgpu_buffer_funcs sdma_v5_2_buffer_funcs = {
 
 static void sdma_v5_2_set_buffer_funcs(struct amdgpu_device *adev)
 {
-	if (adev->mman.buffer_funcs == NULL) {
-		adev->mman.buffer_funcs = &sdma_v5_2_buffer_funcs;
-		adev->mman.buffer_funcs_ring = &adev->sdma.instance[0].ring;
-	}
+	amdgpu_sdma_set_buffer_funcs_scheds(adev, &sdma_v5_2_buffer_funcs);
 }
 
 const struct amdgpu_ip_block_version sdma_v5_2_ip_block = {
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index b005672f2f96..064508cecd11 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1895,8 +1895,7 @@ static const struct amdgpu_buffer_funcs sdma_v6_0_buffer_funcs = {
 
 static void sdma_v6_0_set_buffer_funcs(struct amdgpu_device *adev)
 {
-	adev->mman.buffer_funcs = &sdma_v6_0_buffer_funcs;
-	adev->mman.buffer_funcs_ring = &adev->sdma.instance[0].ring;
+	amdgpu_sdma_set_buffer_funcs_scheds(adev, &sdma_v6_0_buffer_funcs);
 }
 
 const struct amdgpu_ip_block_version sdma_v6_0_ip_block = {
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index 5679a94d0815..60447729271e 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -1845,8 +1845,7 @@ static const struct amdgpu_buffer_funcs sdma_v7_0_buffer_funcs = {
 
 static void sdma_v7_0_set_buffer_funcs(struct amdgpu_device *adev)
 {
-	adev->mman.buffer_funcs = &sdma_v7_0_buffer_funcs;
-	adev->mman.buffer_funcs_ring = &adev->sdma.instance[0].ring;
+	amdgpu_sdma_set_buffer_funcs_scheds(adev, &sdma_v7_0_buffer_funcs);
 }
 
 const struct amdgpu_ip_block_version sdma_v7_0_ip_block = {
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
index f20e0fc3fc74..c3428d2731dc 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
@@ -1764,8 +1764,7 @@ static const struct amdgpu_buffer_funcs sdma_v7_1_buffer_funcs = {
 
 static void sdma_v7_1_set_buffer_funcs(struct amdgpu_device *adev)
 {
-	adev->mman.buffer_funcs = &sdma_v7_1_buffer_funcs;
-	adev->mman.buffer_funcs_ring = &adev->sdma.instance[0].ring;
+	amdgpu_sdma_set_buffer_funcs_scheds(adev, &sdma_v7_1_buffer_funcs);
 }
 
 const struct amdgpu_ip_block_version sdma_v7_1_ip_block = {
diff --git a/drivers/gpu/drm/amd/amdgpu/si_dma.c b/drivers/gpu/drm/amd/amdgpu/si_dma.c
index 3e58feb2d5e4..155067c20a0e 100644
--- a/drivers/gpu/drm/amd/amdgpu/si_dma.c
+++ b/drivers/gpu/drm/amd/amdgpu/si_dma.c
@@ -833,8 +833,7 @@ static const struct amdgpu_buffer_funcs si_dma_buffer_funcs = {
 
 static void si_dma_set_buffer_funcs(struct amdgpu_device *adev)
 {
-	adev->mman.buffer_funcs = &si_dma_buffer_funcs;
-	adev->mman.buffer_funcs_ring = &adev->sdma.instance[0].ring;
+	amdgpu_sdma_set_buffer_funcs_scheds(adev, &si_dma_buffer_funcs);
 }
 
 const struct amdgpu_ip_block_version si_dma_ip_block =
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 964efa325908..28dc6886c1ff 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -129,13 +129,14 @@ svm_migrate_copy_memory_gart(struct amdgpu_device *adev, dma_addr_t *sys,
 			     struct dma_fence **mfence)
 {
 	const u64 GTT_MAX_PAGES = AMDGPU_GTT_MAX_TRANSFER_SIZE;
-	struct amdgpu_ring *ring = adev->mman.buffer_funcs_ring;
+	struct amdgpu_ring *ring;
 	struct amdgpu_ttm_buffer_entity *entity;
 	u64 gart_s, gart_d;
 	struct dma_fence *next;
 	u64 size;
 	int r;
 
+	ring = to_amdgpu_ring(adev->mman.buffer_funcs_scheds[0]);
 	entity = &adev->mman.move_entities[0];
 
 	mutex_lock(&entity->lock);
-- 
2.43.0

