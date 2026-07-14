Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66569C43458
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 09:57:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0DC010E564;
	Tue, 14 Jul 2026 09:57:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IGF6RV1B";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010070.outbound.protection.outlook.com [52.101.201.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5B2810E564;
 Tue, 14 Jul 2026 09:57:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GEF6XH9FuEz3ydwGxOXxuw0ehk20J6vNZa9C7prdfORmu7uwYK5C9mddV3kCNzYFPsiHNF7K/eYwa2NkWbLFbqSpI6l3PsOCSQ1D7VQZlhmYqBqumtV0YIUPF0DoAnmh4TSDJ2COanLWLsUmizHw5k941GfWiMVpX1Eff5ehBx/pwW9E8DGqDF5pj9gvPtZFPDPQg0TWc3VLIFMvnI2c5ivN93ubKfd9tawzxkPpitTVj3Hn4lNT1L3CY0LCkjALqf0iI7l48YERuxDyRV4GzlyO5wcbtJ9zGkuc3nSqqHRwWZv5lvfL76vFuXQV0TxRJE/TzXK1nIqTKOB8lm0/lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P3xb/hgdZYRONhXD1ZvAktjrNzAd4lbATorulLbxYIE=;
 b=YH/O1+nM/o1s3kAfudRxrEF9GA+W2JzEGfcOqO6IqMysbZpWTHFUffvx4XkY27PDyj80lNFVN7LYxNxWoSost5k3v8gYgi+eZyzYD7cQ3o52wTw8bFYfA1PgjhNu7I/639kGrlwFKveWgjtXGcDTIyZhn4EmAiiMjrhcthuCBFlZck44x/bM18vKzgbj1I0fLGc5zFI86IP3v5ORvMwvfdhG4jdJnJWNToS2CTVV8ac0PatCxZ2+oiywWWhYNkxzoXbokj8sEFoPhz2is5NBfc0JhNiVleaB1kQrdxlNITSfE4SOeJhEb64gAaAaqlqOhJy9sQJEd9CTiTjDhYaJvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P3xb/hgdZYRONhXD1ZvAktjrNzAd4lbATorulLbxYIE=;
 b=IGF6RV1BZ5XSSUmqVYieByxq0Xv4yMEdD02xSxbwz3TPPq+O34tun7wViOy9xlJoLbKIH4/Ld0s8rrTic9hDH73ZiJIOQ4+U+7EuVct0f2UtjtNOr46H0wP16Kbm05zZLPSGcALMN4AFwISo7RH5118/+1Jkv2HalhhAeYZkCZ8=
Received: from BY5PR04CA0003.namprd04.prod.outlook.com (2603:10b6:a03:1d0::13)
 by MW4PR12MB5643.namprd12.prod.outlook.com (2603:10b6:303:188::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Tue, 14 Jul
 2026 09:57:02 +0000
Received: from SJ1PEPF00001CE8.namprd03.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::85) by BY5PR04CA0003.outlook.office365.com
 (2603:10b6:a03:1d0::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.9 via Frontend Transport; Tue, 14
 Jul 2026 09:57:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE8.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Tue, 14 Jul 2026 09:57:01 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 14 Jul
 2026 04:57:00 -0500
Received: from yocto.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 14 Jul 2026 04:56:58 -0500
From: Kunal Zodape <kunal.devanandzodape@amd.com>
To: Felix Kuehling <Felix.Kuehling@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, Kunal Zodape <kunal.devanandzodape@amd.com>
Subject: [PATCH] drm/amdkfd: remove kfd_queue_buffer_put() wrapper
Date: Tue, 14 Jul 2026 09:56:35 +0000
Message-ID: <20260714095635.3113246-1-kunal.devanandzodape@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE8:EE_|MW4PR12MB5643:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b99315c-1ee0-4a25-785e-08dee18e4092
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|1800799024|376014|36860700016|5023799004|11063799006|18002099003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: ysA59stWSH0lyiJJ9/rEXa6gQMc9iUncwOtinHpPcyUv5DLMQEumxTZ5cHej29yax3PDDYmpy4XX40R3ybJm5Jq0iCs8RzNS/8fHIzIFJWheBxczF9si9hmbjoX9PHNttCrCjbq3a5HssINMPZg2GLcgVpVYh3AHxipn1DgYmvmxENDjjnieK8VOBtX7S9MUJA/519TgQl7ffRdWkz29S9/Q3dSnfkYg+CgzCI1Xe20c2ox1dO/UpeVXrXVlXi8orRYnJeXDYZD0icbv54IQbTTQK4Vhmy1tDfobix+6sKfrGCvd9GcCw/zeF+XOU/iwA79nz44Db+6iH4LDVS+DRs4Mz/0Pq4yO1DgrI4g93rVDBK8URWorJAfnK5IFyB7iATVnCLz586eRRlz6E0rtoUgSz7fndMGUwUs4V+KmK1r2iJo+QUJ4ngHHmpwFB6oCpTQ5NLURa046FaUiGS4SfXmcah55ifBFxPAA8OttJm8XHftNUHfINT9qCh2SbLM12NVVD9HKVNSH8q0qQjwr8LjIYB22XCvlNhbZgD8f7I+JXQgsKqZXyzcpWO9FvWv9OojHJdfksy/Y5oYrnvwra9tNhuJujo4Z/Gn4UX7Q1BIYkjf3baHlVTjvgDLDsQWhXNo3Bv7Zt6knrLrGmAOCXAFBuQMV8/AhXyEkNpU6zgraQHV2gWgS4IQW4Vs3uv+C
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(1800799024)(376014)(36860700016)(5023799004)(11063799006)(18002099003)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HdVUO7k0y9SLmzmlRLDAqi9TZtKMYvu9tFGQr6fYPbjXR3FBA82FuyLz+gGFC0yqqOgtwNcOUkCg5xVyYg2yQzcgcCO+t422JQgpJpRNAd3gyMXYvvtW01uxxp/21LnImGAYJ2gyWMMrbCUBYm4MyONuF5/MB+8ilmzp6NV5nJ4uqZanK6PdtN7rJWuf4fILhjLWH7WyX/ifbGU1FB53YNC0Ra/rrvbX05aD2Ik+dCjd+6uVi5q0JER4RzameO5Zf5IwXFUHr5PxDvmztOOgbeP1igARCeZLwEdAdR60M05RecZkZ7EyMN47M5cTubxUf8BwuN2fMLrXKfdWFP7oo6NOM8CBI6BgZmvb0OfCobTIgJI/pNTLIUMWh5/HwdhZCuWrGetRhIzUIEfQeFqotgLRk7O/M8CYOR1qsD+IQamKSHFRf8uALm3O0JEfN+hL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 09:57:01.6864 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b99315c-1ee0-4a25-785e-08dee18e4092
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5643
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

kfd_queue_buffer_put() was a trivial one-line wrapper that simply
forwarded its argument to amdgpu_bo_unref(). A FIXME comment already
noted that callers should invoke amdgpu_bo_unref() directly.

Drop the wrapper and its declaration, and call amdgpu_bo_unref()
directly at all call sites. No functional change intended.

Signed-off-by: Kunal Zodape <kunal.devanandzodape@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h            |  1 -
 .../drm/amd/amdkfd/kfd_process_queue_manager.c   |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c           | 16 +++++-----------
 3 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 448b013f8..05127efc3 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1367,7 +1367,6 @@ void print_queue_properties(struct queue_properties *q);
 void print_queue(struct queue *q);
 int kfd_queue_buffer_get(struct amdgpu_vm *vm, void __user *addr, struct amdgpu_bo **pbo,
 			 u64 expected_size);
-void kfd_queue_buffer_put(struct amdgpu_bo **bo);
 int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_properties *properties);
 int kfd_queue_release_buffers(struct kfd_process_device *pdd, struct queue_properties *properties);
 void kfd_queue_unref_bo_va(struct amdgpu_vm *vm, struct amdgpu_bo **bo);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index feb70face..a9375f7a2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -604,7 +604,7 @@ int pqm_update_queue_properties(struct process_queue_manager *pqm,
 		}
 
 		kfd_queue_unref_bo_va(vm, &pqn->q->properties.ring_bo);
-		kfd_queue_buffer_put(&pqn->q->properties.ring_bo);
+		amdgpu_bo_unref(&pqn->q->properties.ring_bo);
 		amdgpu_bo_unreserve(vm->root.bo);
 
 		pqn->q->properties.ring_bo = p->ring_bo;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
index 9d4838461..df65c15d8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
@@ -224,12 +224,6 @@ int kfd_queue_buffer_get(struct amdgpu_vm *vm, void __user *addr, struct amdgpu_
 	return -EINVAL;
 }
 
-/* FIXME: remove this function, just call amdgpu_bo_unref directly */
-void kfd_queue_buffer_put(struct amdgpu_bo **bo)
-{
-	amdgpu_bo_unref(bo);
-}
-
 int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_properties *properties)
 {
 	struct kfd_topology_device *topo_dev;
@@ -346,11 +340,11 @@ int kfd_queue_release_buffers(struct kfd_process_device *pdd, struct queue_prope
 	struct kfd_topology_device *topo_dev;
 	u32 total_cwsr_size;
 
-	kfd_queue_buffer_put(&properties->wptr_bo);
-	kfd_queue_buffer_put(&properties->rptr_bo);
-	kfd_queue_buffer_put(&properties->ring_bo);
-	kfd_queue_buffer_put(&properties->eop_buf_bo);
-	kfd_queue_buffer_put(&properties->cwsr_bo);
+	amdgpu_bo_unref(&properties->wptr_bo);
+	amdgpu_bo_unref(&properties->rptr_bo);
+	amdgpu_bo_unref(&properties->ring_bo);
+	amdgpu_bo_unref(&properties->eop_buf_bo);
+	amdgpu_bo_unref(&properties->cwsr_bo);
 
 	topo_dev = kfd_topology_device_by_id(pdd->dev->id);
 	if (!topo_dev)
-- 
2.17.1

