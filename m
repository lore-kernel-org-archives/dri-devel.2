Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B5B2E7E345
	for <dri-devel@archiver.kernel.org>; Fri,  3 Apr 2026 08:36:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB1DA10F3CD;
	Fri,  3 Apr 2026 08:36:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dYwxIlX4";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012003.outbound.protection.outlook.com [52.101.48.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8102110F3CC;
 Fri,  3 Apr 2026 08:36:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lIjenz8jPWs01m7tD5mJ/JtbLP6JEcXU6qOU5zoqiLB6GCigA5R8AezzoNojwbQ81grK/03STKnRy6FqWKdw/DLvuqfTg6r/uicGZ1YZ7hjp4pqh0NW64TIxhUd0PKz60WGAdUhClvZJ0ER/T7DhuiX7BDjeryajc3yHXRXxf+eqKYx7/5oSDigkBEdrtlsE9BzOQWpALW+xb/lZ5TW4/9tB+BbK9DU7o/fzJ2ysQNWHiPjT3aMuBoZs9gcAmzvsCTrGWGktbFnmgZfVtq4SN2oyPhd4ZJljdyvJaw9ESvDb509EcpApZZI2rJUM9fj9nYe58D3biCSpW+fiZl0QUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o2wg8M59vQqRPKgeG1nXqqPitek2f2Qi4IqV5Psvf+I=;
 b=ggE4wnTZMXOPZTsyTvaXnNrVWT2dWZNqP6tmR935NzCMnlCqPOamKah/KY7tOg7RPW2OREgcHxCGNYu2IoJNewXb68yGW/ZI1SnH63FbQllFJ+deiMzMjoivu29NS+460wZlba85w69d4ysE+MnIUIOmPo9wLJhg4Q2OMGO3hF6d0uqkBI6Ri6cFtbAyFJjDRvOpi1mQElyz20mz5i70cK4RtWC/qwi24XZwSCZSnZX05Ob3hctVrwKv4ZlPdV6uTpshLRUHLxscrhocIvXEuZv5bRnOOhBj3265VKVKl+4uWNWBXUecrRcagUAeEb7kun6gRTT3eJ9SkSkwMRX0kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o2wg8M59vQqRPKgeG1nXqqPitek2f2Qi4IqV5Psvf+I=;
 b=dYwxIlX4pmISsiYWnuzbeiSvXWT7Vc8+vDMZ3g7ODA5DWALoBVYHJQPsK/GGsfOS3Dweylj5q563rT1xMW/aI8RvyEjlUTZ43tjeqpqsElyHSqcZrLXBujUhiCt82Lz5IJhUAXadmNoUVClreSfiz/1NLxrkUECAKW8voDlXlSk=
Received: from BY5PR17CA0056.namprd17.prod.outlook.com (2603:10b6:a03:167::33)
 by SA3PR12MB8763.namprd12.prod.outlook.com (2603:10b6:806:312::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Fri, 3 Apr
 2026 08:36:37 +0000
Received: from SJ1PEPF00002319.namprd03.prod.outlook.com
 (2603:10b6:a03:167:cafe::a2) by BY5PR17CA0056.outlook.office365.com
 (2603:10b6:a03:167::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.18 via Frontend Transport; Fri,
 3 Apr 2026 08:36:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002319.mail.protection.outlook.com (10.167.242.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Fri, 3 Apr 2026 08:36:37 +0000
Received: from FRAPPELLOUX01-WSLPUB.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 3 Apr 2026 03:36:35 -0500
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Felix Kuehling
 <Felix.Kuehling@amd.com>
CC: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>, "Felix
 Kuehling" <felix.kuehling@amd.com>, <amd-gfx@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 1/7] drm/amdgpu: pass all the sdma scheds to amdgpu_mman
Date: Fri, 3 Apr 2026 10:35:49 +0200
Message-ID: <20260403083602.1771-1-pierre-eric.pelloux-prayer@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002319:EE_|SA3PR12MB8763:EE_
X-MS-Office365-Filtering-Correlation-Id: 07de9dcd-e23a-4a2d-d7de-08de915c1ed4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: tVs8Kp/NVPsjedf2eQqrZHn1kPF7X1Kk5lybXIYG6LYf2q0Q3taruoc8xiZB1AfLHTD8cRFymVazMfDVsyTFYMMO4rWJuXJ+dvftTZoXedozzEQ/6nfeR6/XaZlokJHDvdDb4uSiyUZXC4reFsv5Xs4WD2FadseYzHAR31qiHRXSHDG60gq9pj/O/k1RfHriq61dWb2v4whwOLYUllHtCTBIgUEx6Vn0nPayE4iVMaTsV3OawbLH/jG2dKX2PlLBhOGYQdxIQE9fRmLIVwA4d5+bANulckcg6YEJoJtB4OmI0gjM67w2GnIGV8vNJ6vCyEPWDfehrF76BIgG4WFovBMnLmvZtYXoYzTgJoc1i2Kif5GZg9DmrhiqanTGdR0Xs2dYUsldaliTrXHquGiiNcDxQop8eoKtm5SL2Q4JXVnl6k1Ytt7D4q/0oq4h47GpBxXHRMtYxgTbvgTfhcgPUd7hkr7q8bueaLC0l6clDDDxoRnAd2RLUp2qBasOOwSrALL+F/cRQCTXuCnXndQLbKLCG3kOzDNIzZ/Jg2LhgCm7ygtdG2LC25ZKafhkaCTlwL2RGPCmdRd1lXSbs0kvm3hUkQz84TWgbXrlrCJGLzY5s3FU2REB4i2e91wSASOKNIVWMkbkJ3uVghjJwAF5nAvjj6TGQSBaSTEY9E6Wn3Y7tSiCKQRNyGk2kt5gP5UPIGUB43dHRij1IFTy/IzUbE99q0Not/d/w9x3r4r1gCjQCDLHsxu0AhpUeVQSVv35nqxpqWd3lFIOpH4y1HaNPg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TmGQApGZT4HfFTdJ/gjCI9ZCOFfdc+9k9gvTNvuUkiWfi67XXraJ409qj6n9e/YI6tKkJLlY/u1ewTRvwm4nqRzTTYg9slicQhDabjPIjrjwLJqQH5Q61FpnmgnYRx6javghllFl8Q1NWMRAk+nxMP6MsGgH8pO3ui4Y1ShG3ZXe6whMShBjFs0MiSeY0yKU4N2ICYkUb8xCS9YBvl/OCqbrj7gi/QR1rOw3KT6mN4QbNmB99LDe7V8mfq1AIhImx4gRR0G6r/amD8+RwLeJTCnAQrL966ISUR+i01S3vod5d+RMq5Q5tYhJly+zLDb5kKiAvQKQdDili79LOwN9fCs4/KhNAoQYQIFryPqVSeYLe0ecE68G6J54QgjuCx5fesp/MVbfu0zkcMkSbGy6fQslImqok0IqqOecQErdGWlVoexWWDzKxQyKp+WD3kSa
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 08:36:37.2378 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07de9dcd-e23a-4a2d-d7de-08de915c1ed4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002319.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8763
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    | 32 ++++++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h    |  3 +-
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c      |  3 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c     |  3 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c     |  3 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c     |  8 ++----
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c   |  6 +---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c     |  5 +---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c     |  5 +---
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c     |  3 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c     |  3 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c     |  3 +-
 drivers/gpu/drm/amd/amdgpu/si_dma.c        |  3 +-
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c   |  3 +-
 17 files changed, 48 insertions(+), 43 deletions(-)

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
index 3c63f87832e4..4ba7321b75e3 100644
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
@@ -2730,6 +2729,27 @@ int amdgpu_ttm_evict_resources(struct amdgpu_device *adev, int mem_type)
 	return ttm_resource_manager_evict_all(&adev->mman.bdev, man);
 }
 
+void amdgpu_sdma_set_buffer_funcs_scheds(struct amdgpu_device *adev,
+					 const struct amdgpu_buffer_funcs *buffer_funcs)
+{
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
+	struct drm_gpu_scheduler *sched;
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

