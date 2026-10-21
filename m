Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405CC606A319
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 03:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=u6QYu/BX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 817A110F8A9;
	Wed, 21 Oct 2026 03:00:53 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010015.outbound.protection.outlook.com [52.101.201.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23D0010F8A4;
 Wed, 21 Oct 2026 03:00:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pw6HAvzwpqYW6MpqN6fGhlFg3pkkOao+wcaTwiWKYgswRLFDIAw7ADcaeBfewz1b2oDwwBLq/EOfdVjLnt60IrVSq68ciMEuLlyOmiQeXJmQJGYVVaRhwCwtsTZtW/fsKBGTpE7TWnc4dzWi/0yRIKYXdHKIwxwK/howwcoryoqKI7EyWV1P/0ql+fG8FtePVKg/bdRaCvCp7WvGZlVbYvzb0nxfUT+8/8ikNUrg4LrHYg6oF2OSmB7MzvfkBDv70Jedj9YdFi5kDiLaOsTnO1zqe823EmEQ9xm+8h9A+e7SJLgYwic+y6kTo2TO769nvdH02Pl129fNFlU5zk+sSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HH9P+Iiq/uyyPDaqk9LRXGG8XyrnYj7Rxfk1G/83meQ=;
 b=eEuCtCIQAay6JaZMPeTV3Lnkg27DRNFetHkgzgtOFc30kXhaOQ/cRpaqZdVVxXSPF4SbPWvpbR7ZTU+FNvPw0gfN0zPYnr/+tLK5wiYUoLJDc2Wxvukb88I1gyPDIOfFrcH7f8d7BWz7TNqRviF0f5vpqgbpfXt26NQ+r9hHbaFvC4yXrwO6OAB+iRlWIFiLwJsXCFKDy4cYp0rECFpzclkmiyXQKdkYnwtxI+UFRLmw/rKlxSedPjzF4kgnlyO08cVIPTFVx3+QnpkJicL9vQ8ekyPVM/qpSaYVDq/vYT52IChU48C6jYkuTaMKZP8+n74azqZTrbP6aXQiHYMgmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HH9P+Iiq/uyyPDaqk9LRXGG8XyrnYj7Rxfk1G/83meQ=;
 b=u6QYu/BXXSaLphg6tTcycKYBTDEZTMGGdIopHtPqCzdabb99kWXhzQJXeJs9P/zSxzGLl/I7V6gk5w7P0dyx69+ETf+NbGmz+dFLFhL8oTkoCfS6csHy6e48x1noMAgQjAUOwQnP4seUOC36Y17yws35UtTUP7F5dGsv0dUprgA=
Received: from PH0PR07CA0082.namprd07.prod.outlook.com (2603:10b6:510:f::27)
 by CY5PR12MB6226.namprd12.prod.outlook.com (2603:10b6:930:22::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.17; Wed, 21 Oct
 2026 03:00:37 +0000
Received: from SJ5PEPF000001D1.namprd05.prod.outlook.com
 (2603:10b6:510:f:cafe::4c) by PH0PR07CA0082.outlook.office365.com
 (2603:10b6:510:f::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.20 via Frontend Transport; Wed,
 21 Oct 2026 03:00:37 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D1.mail.protection.outlook.com (10.167.242.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 03:00:36 +0000
Received: from hr-amd.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 20 Oct
 2026 22:00:31 -0500
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
 <yiru.ma@amd.com>, Huang Rui <ray.huang@amd.com>, Honglei Huang
 <honghuan@amd.com>, Yu Huang <Yu.Huang@amd.com>
Subject: [PATCH v10 14/22] drm/amdgpu: recheck range validity after page table
 allocation
Date: Wed, 21 Oct 2026 10:58:53 +0800
Message-ID: <20261021025915.2433837-15-ray.huang@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021025915.2433837-1-ray.huang@amd.com>
References: <20261021025915.2433837-1-ray.huang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D1:EE_|CY5PR12MB6226:EE_
X-MS-Office365-Filtering-Correlation-Id: 03f0b729-8940-49f5-e9b8-08df2f1f7b65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|23010399003|6133799003|18002099003|22082099003|10067099003|3023799007|921020|5023799004|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: zbFC5m9fy7xAP66FVDDUY4ERfmORqguQRNcuv/SvCLgWxxKJkBE5gtJHsSIIecxVxrkK3AE0tZoGWdSL3kfjY/xIGFVqZ8cWWL2kXd5EhiES9Mrsi2bFSMIh3DOwkqTaNbINKc816DxJnr+ZgoiyFtXP+MhEVE+ehiEp3zFO35WN5RSvNUbtAeir4pdtRCAiDr8KPAVqmBfV4KlhGSYXuxdS6fXThcDQi+kcjh1G3e8YGlaztcexaeucjWH5Q1+UFy8RhXo9vdM3fOkbH9pM1+i8etrv34WQPqEHNhRKBkcdnW0VrC2YD03PwOtbqMU2/0PPWAguP4UEsEioRHUCKeFbQJlBaOAB+woxNXHzwfnqm8OxjeetXK3Gli9bDTLR8AEFnipb2J1I4AzifP8RRQ4r/GD3Y/ImBpJvvVO3I0wiEbmlW4qXOJnCQyT5roo4fHpyIVvzcqk8yAsq33VcAvTawCqMxSnVkqL1YDj4M1PfIEyghvB+ImRPq/WGoEOCXVeV1AeeNn398n8HKfEQMpLxnL+R46/OFEHP4O/CLYNcWgEbTNlVh+fOtMK3I5igHCFt612AbEBxNh2O0QodJuQWn+fJD5zLwz7P1P30r7D6/OJKpNmZVYGKFVmSkar9fyNTZspOSwGu9dEw12McRWZAMsyPhZcm/+Ijaa+/2VTplB+3EP1JRfYOAo8FpYv/90mOrL+SJn3EVNiJa67vShF6UNbU8oB9wdS9fuKNE2dvQaYx9Juoh9mVakouTn1p
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(23010399003)(6133799003)(18002099003)(22082099003)(10067099003)(3023799007)(921020)(5023799004)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kKmAOTrYXfmj++eRpIipXXq/0+AIZsrCBO/LMj8pXN2s+OzXwjuAg0m3/zcJ2iq1RL5l5Db2W51pTxwLhCISLwsirm4EuUyYdwkDZei38We3J1dNrBWno6VZ9neXsIllXeL8Jj+gqh2rNoa16wy15xlYBkZcUnvhEah8DAQRyrGWlA5ms2thaPXJ+cAdiG6tCztOkgXuJD+6Y9P4D9L1xuJlpG8/aiIne7VZ0r+VQ0a4MiKlFH7OdXp3Ps7hKuJsQhNYohlFVCB64haUIhCO0QYAbQ+bbprj0M18J6y/wPPV6iPk0+pVRDDkWI/8ROiTCI1a2fkBI1vaVbt3uFpyI71iUzmmFODmgYQdp5yGgqjKayGCwWp2cmgmgorlYO3vQ+Pv2rqkq0Mw7n0pZXTWuLqVtBW6qeIRCjbi92Z06NQ6twc7PBnPFq/D+2mx23da
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 03:00:36.9411 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03f0b729-8940-49f5-e9b8-08df2f1f7b65
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6226
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Honglei Huang <honghuan@amd.com>

The notifier and eviction locks need to be the same lock. Page table
allocation can enter memory reclaim, and reclaim can invoke an MMU
notifier that takes the same lock. Release the lock before allocating
page tables to avoid a deadlock.

Dropping the lock allows an unmap operation to invalidate the range
concurrently. Recheck the HMM or GPU SVM range after reacquiring the
lock and return -EAGAIN if its sequence number has changed.

Allow callers that already hold the eviction lock to pass it to the VM
update helpers. Drop the lock around amdgpu_vm_pt_create() and reacquire
it before continuing. Callers that pass NULL retain the existing
internal locking path.

Update the remaining amdgpu_vm_update_pdes() call sites (amdkfd_gpuvm.c,
cs.c, gem.c, userq.c) and amdgpu_ualink.c's update_pdes/map_range call
sites to pass NULL, since these callers do not hold the eviction lock
externally. amdgpu_ualink.c only exists on top of amd-staging-drm-next
and was never covered by the original patch against the old base.

Drop the now-unused error_free_pt label in amdgpu_vm_pt_alloc(): the
r2-failure path was reworked to use amdgpu_vm_update_unlock()/relock()
instead of a goto, leaving error_free_pt reachable only by fallthrough
from error_unpin.

Suggested-by: Christian König <christian.koenig@amd.com>
Suggested-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Yu Huang <Yu.Huang@amd.com>
Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c        |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c |  7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c    | 24 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        | 79 ++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |  9 ++-
 .../gpu/drm/amd/amdgpu/amdgpu_vm_internal.h   | 28 +++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c     | 32 ++++++--
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c          |  7 +-
 11 files changed, 131 insertions(+), 63 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index cb46111b2dc8c..321f23cba15c3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -503,7 +503,7 @@ static int vm_update_pds(struct amdgpu_vm *vm, struct amdgpu_sync *sync)
 	struct amdgpu_device *adev = amdgpu_ttm_adev(pd->tbo.bdev);
 	int ret;
 
-	ret = amdgpu_vm_update_pdes(adev, vm);
+	ret = amdgpu_vm_update_pdes(adev, vm, NULL);
 	if (ret)
 		return ret;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 9e0b9a50d2e72..90829b6adb1f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1184,7 +1184,7 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
 	if (r)
 		return r;
 
-	r = amdgpu_vm_update_pdes(adev, vm);
+	r = amdgpu_vm_update_pdes(adev, vm, NULL);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 907b25397a621..669ca9d1de82a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -804,7 +804,7 @@ amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
 	}
 
 	/* Always update PDEs after we touched the mappings. */
-	r = amdgpu_vm_update_pdes(adev, vm);
+	r = amdgpu_vm_update_pdes(adev, vm, NULL);
 	if (r)
 		goto error;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
index 62c78c3ce6762..a1aa84974a43a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
@@ -72,8 +72,8 @@ amdgpu_svm_range_zap_ptes(struct amdgpu_svm *svm,
 		return 0;
 
 	flags = memalloc_noreclaim_save();
-	ret = amdgpu_vm_unmap_range(svm->adev, svm->vm, NULL,
-				    start_page, last_page, 0, &fence);
+	ret = amdgpu_vm_unmap_range(svm->adev, svm->vm, true, NULL,
+				    start_page, last_page, NULL, &fence);
 	memalloc_noreclaim_restore(flags);
 
 	if (fence) {
@@ -222,6 +222,7 @@ amdgpu_svm_range_update_gpu_range(struct amdgpu_svm *svm,
 					  flush_tlb && is_last_seg, true, NULL,
 					  start_page, last_page, pte_flags,
 					  0, entry->addr, NULL, NULL, NULL,
+					  NULL, NULL,
 					  wait_fence && is_last_seg ? fence : NULL);
 		if (ret)
 			return ret;
@@ -334,7 +335,7 @@ int amdgpu_svm_range_update_mapping(struct amdgpu_svm *svm,
 	dma_fence_put(fence);
 
 	if (!ret)
-		ret = amdgpu_vm_update_pdes(svm->adev, svm->vm, false);
+		ret = amdgpu_vm_update_pdes(svm->adev, svm->vm, NULL);
 
 	if (!ret) {
 		if (flush_tlb)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index de913131a246f..eecc85caadcd2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -2051,14 +2051,14 @@ static int amdgpu_ualink_unmap_npa_addr(struct amdgpu_device *adev,
 
 	r = amdgpu_vm_map_range(adev, vm, true, false, NULL, npa_addr,
 				npa_addr + size - 1, pte_value, 0, 0, NULL,
-				NULL, NULL, &vm->last_update);
+				NULL, NULL, NULL, NULL, &vm->last_update);
 	if (r) {
 		dev_err(adev->dev,
 			"Failed to unmap NPA addr (%llx) from NPA VM\n", npa_addr);
 		goto out;
 	}
 
-	r = amdgpu_vm_update_pdes(adev, vm);
+	r = amdgpu_vm_update_pdes(adev, vm, NULL);
 	if (r) {
 		dev_err(adev->dev,
 			"Failed %d to update page directories during unmapping NPA: 0x%llx\n",
@@ -2104,7 +2104,7 @@ static int amdgpu_ualink_map_npa_addr(struct amdgpu_device *adev, u64 npa_addr,
 	r = amdgpu_vm_map_range(adev, vm, true, false, NULL, npa_addr,
 				npa_addr + size - 1, pte_flags, offset,
 				adev->vm_manager.vram_base_offset,
-				bo->tbo.resource, NULL, NULL, &vm->last_update);
+				bo->tbo.resource, NULL, NULL, NULL, NULL, &vm->last_update);
 	if (r) {
 		dev_warn(adev->dev,
 			"Failed to map NPA addr (%llx) into NPA VM\n", npa_addr);
@@ -2112,7 +2112,7 @@ static int amdgpu_ualink_map_npa_addr(struct amdgpu_device *adev, u64 npa_addr,
 		goto out;
 	}
 
-	r = amdgpu_vm_update_pdes(adev, vm);
+	r = amdgpu_vm_update_pdes(adev, vm, NULL);
 	if (r) {
 		dev_err(adev->dev,
 			"failed %d to update page directories for NPA: 0x%llx\n",
@@ -2610,7 +2610,7 @@ static void amdgpu_ualink_force_retry_rpcs(struct amdgpu_device *adev,
 					pte_flags, 0,
 					adev->vm_manager.vram_base_offset,
 					bo->tbo.resource, NULL, NULL,
-					&vm->last_update);
+					NULL, NULL, &vm->last_update);
 
 		if (r)
 			dev_warn(adev->dev,
@@ -2621,7 +2621,7 @@ static void amdgpu_ualink_force_retry_rpcs(struct amdgpu_device *adev,
 			break;
 	}
 
-	r = amdgpu_vm_update_pdes(adev, vm);
+	r = amdgpu_vm_update_pdes(adev, vm, NULL);
 	if (r) {
 		dev_err(adev->dev,
 			"Failed %d to update page directories during force retry rpcs\n",
@@ -2746,7 +2746,7 @@ static void amdgpu_ualink_unmap_all_npa_addr(struct amdgpu_device *adev,
 		r = amdgpu_vm_map_range(adev, vm, true, false, NULL,
 					npa_addr, npa_addr + size - 1,
 					pte_value, 0, 0, NULL, NULL, NULL,
-					&vm->last_update);
+					NULL, NULL, &vm->last_update);
 
 		if (r)
 			dev_err(adev->dev,
@@ -2758,7 +2758,7 @@ static void amdgpu_ualink_unmap_all_npa_addr(struct amdgpu_device *adev,
 			break;
 	}
 
-	r = amdgpu_vm_update_pdes(adev, vm);
+	r = amdgpu_vm_update_pdes(adev, vm, NULL);
 	if (r) {
 		dev_err(adev->dev,
 			"Failed %d to update page directories during all NPA addresses unmapping\n",
@@ -4527,7 +4527,7 @@ static int amdgpu_ualink_npa_vm_map_range(struct amdgpu_device *adev, struct amd
 				npa_in_pages, npa_in_pages + size_in_pages - 1,
 				pte_flags, offset, adev->vm_manager.vram_base_offset,
 				bo->tbo.resource, NULL, NULL,
-				&npa_vm->last_update);
+				NULL, NULL, &npa_vm->last_update);
 	if (r)
 		dev_dbg(adev->dev, "failed %d to map npa 0x%llx to NPA VM\n", r,
 			npa_in_pages << AMDGPU_GPU_PAGE_SHIFT);
@@ -4561,7 +4561,7 @@ static int amdgpu_ualink_npa_vm_unmap_range(struct amdgpu_device *adev, struct a
 	r = amdgpu_vm_map_range(adev, npa_vm, true, false, NULL,
 				npa_in_pages, npa_in_pages + size_in_pages - 1,
 				pte_flags, offset, 0, bo->tbo.resource, NULL,
-				NULL, &npa_vm->last_update);
+				NULL, NULL, NULL, &npa_vm->last_update);
 	if (r)
 		dev_dbg(adev->dev, "failed %d to unmap npa 0x%llx from NPA VM\n", r,
 			npa_in_pages << AMDGPU_GPU_PAGE_SHIFT);
@@ -4828,7 +4828,7 @@ static void amdgpu_ualink_metadata_npa_unmapping(struct amdgpu_device *adev)
 		}
 	}
 
-	r = amdgpu_vm_update_pdes(adev, &adev->ualink.npa_vm);
+	r = amdgpu_vm_update_pdes(adev, &adev->ualink.npa_vm, NULL);
 	if (r) {
 		dev_dbg(adev->dev, "failed %d to update directories\n", r);
 		goto out_unreserve;
@@ -4971,7 +4971,7 @@ static int amdgpu_ualink_metadata_npa_mapping(struct amdgpu_device *adev)
 		}
 	}
 
-	r = amdgpu_vm_update_pdes(adev, &adev->ualink.npa_vm);
+	r = amdgpu_vm_update_pdes(adev, &adev->ualink.npa_vm, NULL);
 	if (r) {
 		dev_dbg(adev->dev, "failed %d to update directories\n", r);
 		goto error_npa_mapping;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 5df3c9af2667c..53c3259c6a189 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1169,7 +1169,7 @@ amdgpu_userq_vm_validate_and_restore_queue(struct amdgpu_userq_mgr *uq_mgr)
 		goto retry_lock;
 	}
 
-	ret = amdgpu_vm_update_pdes(adev, vm);
+	ret = amdgpu_vm_update_pdes(adev, vm, NULL);
 	if (ret)
 		goto unlock_all;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index e851912999a51..81a83e6b76e00 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -985,13 +985,15 @@ uint64_t amdgpu_vm_map_gart(const dma_addr_t *pages_addr, uint64_t addr)
  *
  * @adev: amdgpu_device pointer
  * @vm: requested vm
+ * @eviction_lock: optional caller-held eviction lock
  *
  * Makes sure all directories are up to date.
  *
  * Returns:
  * 0 for success, error for failure.
  */
-int amdgpu_vm_update_pdes(struct amdgpu_device *adev, struct amdgpu_vm *vm)
+int amdgpu_vm_update_pdes(struct amdgpu_device *adev, struct amdgpu_vm *vm,
+			  struct rw_semaphore *eviction_lock)
 {
 	struct amdgpu_vm_update_params params;
 	struct amdgpu_vm_bo_base *entry, *tmp;
@@ -1010,6 +1012,16 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 	params.adev = adev;
 	params.vm = vm;
 
+	/*
+	 * Keep PDE updates under the SVM eviction lock so MMU notifier
+	 * invalidation won't happen between the PTE and PDE updates.
+	 */
+	params.eviction_lock = eviction_lock;
+
+	r = amdgpu_vm_begin_critical(&params);
+	if (r)
+		goto error;
+
 	r = vm->update_funcs->prepare(&params, NULL,
 				      AMDGPU_KERNEL_JOB_ID_VM_UPDATE_PDES);
 	if (r)
@@ -1036,6 +1048,7 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 		amdgpu_vm_bo_idle(entry);
 
 error:
+	amdgpu_vm_end_critical(&params);
 	drm_dev_exit(idx);
 	return r;
 }
@@ -1116,6 +1129,8 @@ amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *params,
  * @res: ttm_resource to map
  * @pages_addr: DMA addresses to use for mapping
  * @hmm_range: to check validity of DMA addresses
+ * @eviction_lock: optional caller-held eviction lock
+ * @gpusvm_range: optional SVM range to revalidate
  * @fence: optional resulting fence
  *
  * Fill in the page table entries between @start and @last. Allocate and free
@@ -1131,6 +1146,8 @@ int amdgpu_vm_map_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 			uint64_t vram_base, struct ttm_resource *res,
 			dma_addr_t *pages_addr,
 			struct amdgpu_hmm_range *hmm_range,
+			struct rw_semaphore *eviction_lock,
+			struct drm_gpusvm_range *gpusvm_range,
 			struct dma_fence **fence)
 {
 	struct amdgpu_vm_tlb_seq_struct *tlb_cb;
@@ -1143,10 +1160,25 @@ int amdgpu_vm_map_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	if (!drm_dev_enter(adev_to_drm(adev), &idx))
 		return -ENODEV;
 
+	memset(&params, 0, sizeof(params));
+	params.adev = adev;
+	params.vm = vm;
+	params.pages_addr = pages_addr;
+	params.hmm_range = hmm_range;
+	params.eviction_lock = eviction_lock;
+	params.gpusvm_range = gpusvm_range;
+	params.override_pte = allow_override && adev->gmc.override_pte;
+	INIT_LIST_HEAD(&params.tlb_flush_waitlist);
+
+	/* Enter noreclaim before allocating the small tlb_cb. */
+	r = amdgpu_vm_begin_critical(&params);
+	if (r)
+		goto error_critical;
+
 	tlb_cb = kmalloc_obj(*tlb_cb);
 	if (!tlb_cb) {
-		drm_dev_exit(idx);
-		return -ENOMEM;
+		r = -ENOMEM;
+		goto error_critical;
 	}
 
 	/* Vega20+XGMI where PTEs get inadvertently cached in L2 texture cache,
@@ -1160,18 +1192,7 @@ int amdgpu_vm_map_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	 */
 	flush_tlb |= amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(9, 0, 0);
 
-	memset(&params, 0, sizeof(params));
-	params.adev = adev;
-	params.vm = vm;
-	params.pages_addr = pages_addr;
-	params.hmm_range = hmm_range;
 	params.needs_flush = flush_tlb;
-	params.override_pte = allow_override && adev->gmc.override_pte;
-	INIT_LIST_HEAD(&params.tlb_flush_waitlist);
-
-	r = amdgpu_vm_begin_critical(&params);
-	if (r)
-		goto error_free;
 
 	if (!dma_fence_is_signaled(vm->last_unlocked)) {
 		struct dma_fence *tmp = dma_fence_get_stub();
@@ -1255,6 +1276,7 @@ int amdgpu_vm_map_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 error_free:
 	kfree(tlb_cb);
+error_critical:
 	amdgpu_vm_end_critical(&params);
 	drm_dev_exit(idx);
 	return r;
@@ -1269,6 +1291,7 @@ int amdgpu_vm_map_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
  * @sync: fences we need to sync to
  * @start: start of unmapped range
  * @last: last unmapped entry
+ * @eviction_lock: optional caller-held eviction lock
  * @fence: optional resulting fence
  *
  * Fill in the page table entries between @start and @last with a fixed flags
@@ -1281,6 +1304,7 @@ int amdgpu_vm_map_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 int amdgpu_vm_unmap_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 			  bool unlocked, struct amdgpu_sync *sync,
 			  uint64_t start, uint64_t last,
+			  struct rw_semaphore *eviction_lock,
 			  struct dma_fence **fence)
 {
 	struct amdgpu_vm_manager *vm_mgr = &adev->vm_manager;
@@ -1292,22 +1316,24 @@ int amdgpu_vm_unmap_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	if (!drm_dev_enter(adev_to_drm(adev), &idx))
 		return -ENODEV;
 
-	tlb_cb = kmalloc(sizeof(*tlb_cb), GFP_KERNEL);
-	if (!tlb_cb) {
-		drm_dev_exit(idx);
-		return -ENOMEM;
-	}
-
 	memset(&params, 0, sizeof(params));
 	params.adev = adev;
 	params.vm = vm;
 	params.needs_flush = true;
 	params.unlocked = unlocked;
+	params.eviction_lock = eviction_lock;
 	INIT_LIST_HEAD(&params.tlb_flush_waitlist);
 
+	/* Enter noreclaim before allocating the small tlb_cb. */
 	r = amdgpu_vm_begin_critical(&params);
 	if (r)
-		goto error_end_critical;
+		goto error_critical;
+
+	tlb_cb = kmalloc_obj(*tlb_cb);
+	if (!tlb_cb) {
+		r = -ENOMEM;
+		goto error_critical;
+	}
 
 	r = vm->update_funcs->prepare(&params, sync,
 				      AMDGPU_KERNEL_JOB_ID_VM_UNMAP_RANGE);
@@ -1329,8 +1355,7 @@ int amdgpu_vm_unmap_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 error_free:
 	kfree(tlb_cb);
-
-error_end_critical:
+error_critical:
 	amdgpu_vm_end_critical(&params);
 	drm_dev_exit(idx);
 	return r;
@@ -1468,7 +1493,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
 					mapping->start, mapping->last,
 					update_flags, mapping->offset,
 					vram_base, mem, pages_addr, NULL,
-					last_update);
+					NULL, NULL, last_update);
 		if (r)
 			goto error_free;
 	}
@@ -1675,8 +1700,9 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
 			struct amdgpu_bo_va_mapping, list);
 		list_del(&mapping->list);
 
-		r = amdgpu_vm_unmap_range(adev, vm, false, &sync,
-					  mapping->start, mapping->last, &f);
+                r = amdgpu_vm_unmap_range(adev, vm, false, &sync,
+                                          mapping->start, mapping->last,
+                                          NULL, &f);
 		amdgpu_vm_free_mapping(adev, vm, mapping, f);
 		if (r) {
 			dma_fence_put(f);
@@ -2897,7 +2923,6 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 
 	amdgpu_svm_close(vm);
 	amdgpu_svm_fini(vm);
-
 	amdgpu_amdkfd_gpuvm_destroy_cb(adev, vm);
 
 	root = amdgpu_bo_ref(vm->root.bo);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index ffdfaadc90544..574c1af58c2a2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -39,6 +39,7 @@
 #include "amdgpu_ttm.h"
 
 struct drm_exec;
+struct drm_gpusvm_range;
 
 struct amdgpu_bo_va;
 struct amdgpu_job;
@@ -289,7 +290,7 @@ struct amdgpu_vm {
 	/* tree of virtual addresses mapped */
 	struct rb_root_cached	va;
 
-	/* SVM can replace this pointer with its notifier lock. */
+	/* SVM uses gpusvm.notifier_lock, other VMs use default_eviction_lock. */
 	struct rw_semaphore	default_eviction_lock;
 	struct rw_semaphore	*eviction_lock;
 	bool			evicting;
@@ -455,7 +456,8 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 		     bool *need_pipe_sync, bool *emit_spm_needed,
 		     bool *emit_gds_needed);
-int amdgpu_vm_update_pdes(struct amdgpu_device *adev, struct amdgpu_vm *vm);
+int amdgpu_vm_update_pdes(struct amdgpu_device *adev, struct amdgpu_vm *vm,
+			  struct rw_semaphore *eviction_lock);
 int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
 			  struct amdgpu_vm *vm,
 			  struct dma_fence **fence);
@@ -475,10 +477,13 @@ int amdgpu_vm_map_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 			uint64_t vram_base, struct ttm_resource *res,
 			dma_addr_t *pages_addr,
 			struct amdgpu_hmm_range *hmm_range,
+			struct rw_semaphore *eviction_lock,
+			struct drm_gpusvm_range *gpusvm_range,
 			struct dma_fence **fence);
 int amdgpu_vm_unmap_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 			  bool unlocked, struct amdgpu_sync *sync,
 			  uint64_t start, uint64_t last,
+			  struct rw_semaphore *eviction_lock,
 			  struct dma_fence **fence);
 int amdgpu_vm_bo_update(struct amdgpu_device *adev,
 			struct amdgpu_bo_va *bo_va,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
index 920d0b3935807..ffb8f824af9b5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
@@ -24,6 +24,7 @@
 #ifndef __AMDGPU_VM_INTERNAL_H__
 #define __AMDGPU_VM_INTERNAL_H__
 
+#include <drm/drm_gpusvm.h>
 #include <linux/types.h>
 #include <linux/list.h>
 #include "amdgpu_hmm.h"
@@ -80,6 +81,12 @@ struct amdgpu_vm_update_params {
 	 */
 	struct amdgpu_hmm_range *hmm_range;
 
+	/** @eviction_lock: Optional caller-held eviction lock. */
+	struct rw_semaphore *eviction_lock;
+
+	/** @gpusvm_range: Optional SVM range to revalidate after taking the lock. */
+	struct drm_gpusvm_range *gpusvm_range;
+
 	/**
 	 * @job: job to used for hw submission
 	 */
@@ -152,6 +159,7 @@ void amdgpu_vm_pt_free_dummies(struct amdgpu_device *adev);
  *
  * Serialize all updates, check parameters and make sure that memory allocations
  * don't enter the reclaim path so that we don't deadlock with MMU notifiers.
+ * A non-NULL eviction_lock means the caller already holds the selected lock.
  *
  * Returns:
  *
@@ -161,7 +169,9 @@ void amdgpu_vm_pt_free_dummies(struct amdgpu_device *adev);
 static inline int amdgpu_vm_begin_critical(struct amdgpu_vm_update_params *p)
 {
 	/* Use the write lock to serialize updates when the root BO is unlocked. */
-	if (p->unlocked)
+	if (p->eviction_lock)
+		lockdep_assert_held(p->eviction_lock);
+	else if (p->unlocked)
 		down_write(p->vm->eviction_lock);
 	else
 		down_read(p->vm->eviction_lock);
@@ -171,6 +181,10 @@ static inline int amdgpu_vm_begin_critical(struct amdgpu_vm_update_params *p)
 		return -EBUSY;
 	if (p->hmm_range && !amdgpu_hmm_range_valid(p->hmm_range))
 		return -EAGAIN;
+	if (p->gpusvm_range &&
+	    !drm_gpusvm_range_pages_valid(p->gpusvm_range->gpusvm,
+					   p->gpusvm_range))
+		return -EAGAIN;
 	return 0;
 }
 
@@ -178,15 +192,17 @@ static inline int amdgpu_vm_begin_critical(struct amdgpu_vm_update_params *p)
  * amdgpu_vm_end_critical - end the critical section of the update
  * @p: The update parameters
  *
- * Restore the GFP flags and drop the lock.
+ * Restore the GFP flags.
  */
 static inline void amdgpu_vm_end_critical(struct amdgpu_vm_update_params *p)
 {
 	memalloc_noreclaim_restore(p->saved_flags);
-	if (p->unlocked)
-		up_write(p->vm->eviction_lock);
-	else
-		up_read(p->vm->eviction_lock);
+	if (!p->eviction_lock) {
+		if (p->unlocked)
+			up_write(p->vm->eviction_lock);
+		else
+			up_read(p->vm->eviction_lock);
+	}
 }
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index dea80796f1393..68a94c4a2dd68 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -505,6 +505,23 @@ int amdgpu_vm_pt_create(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	return 0;
 }
 
+static void amdgpu_vm_update_unlock(struct amdgpu_vm_update_params *p)
+{
+	amdgpu_vm_end_critical(p);
+	if (p->eviction_lock) {
+		lockdep_assert_held_read(p->eviction_lock);
+		up_read(p->eviction_lock);
+	}
+}
+
+static int amdgpu_vm_update_relock(struct amdgpu_vm_update_params *p)
+{
+	if (p->eviction_lock)
+		down_read(p->eviction_lock);
+
+	return amdgpu_vm_begin_critical(p);
+}
+
 /**
  * amdgpu_vm_pt_alloc - Allocate a specific page table
  *
@@ -528,19 +545,23 @@ static int amdgpu_vm_pt_alloc(struct amdgpu_vm_update_params *p,
 	if (entry->bo)
 		return 0;
 
-	amdgpu_vm_end_critical(p);
+	amdgpu_vm_update_unlock(p);
 	r = amdgpu_vm_pt_create(p->adev, p->vm, cursor->level,
 				&pt, p->vm->root.bo->xcp_id);
-	r2 = amdgpu_vm_begin_critical(p);
+	r2 = amdgpu_vm_update_relock(p);
 	if (r)
 		return r;
-	if (r2)
-		goto error_free_pt;
+	pt_bo = &pt->bo;
+	if (r2) {
+		amdgpu_vm_update_unlock(p);
+		amdgpu_bo_unref(&pt_bo);
+		(void)amdgpu_vm_update_relock(p);
+		return r2;
+	}
 
 	/* Keep a reference to the root directory to avoid
 	 * freeing them up in the wrong order.
 	 */
-	pt_bo = &pt->bo;
 	pt_bo->parent = amdgpu_bo_ref(cursor->parent->bo);
 	amdgpu_vm_bo_base_init(entry, p->vm, pt_bo);
 	r = amdgpu_vm_pt_clear(p->adev, p->vm, pt);
@@ -552,7 +573,6 @@ static int amdgpu_vm_pt_alloc(struct amdgpu_vm_update_params *p,
 error_unpin:
 	if (p->vm->is_npa)
 		amdgpu_bo_unpin(pt_bo);
-error_free_pt:
 	amdgpu_bo_unref(&pt_bo);
 	return r;
 }
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 3d90257e68ab6..d22a40af379f1 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1411,7 +1411,7 @@ svm_range_unmap_from_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	}
 
 	return amdgpu_vm_unmap_range(adev, vm, true, NULL, gpu_start, gpu_end,
-				     fence);
+				     NULL, fence);
 }
 
 static int
@@ -1526,7 +1526,8 @@ svm_range_map_to_gpu(struct kfd_process_device *pdd, struct svm_range *prange,
 					gpu_start, gpu_end, pte_flags,
 					(last_start - prange->start) << PAGE_SHIFT,
 					bo_adev ? bo_adev->vm_manager.vram_base_offset : 0,
-					NULL, dma_addr, hmm_range, &vm->last_update);
+					NULL, dma_addr, hmm_range,
+					NULL, NULL, &vm->last_update);
 
 		for (j = last_start - prange->start; j <= i; j++)
 			dma_addr[j] |= last_domain;
@@ -1538,7 +1539,7 @@ svm_range_map_to_gpu(struct kfd_process_device *pdd, struct svm_range *prange,
 		last_start = prange->start + i + 1;
 	}
 
-	r = amdgpu_vm_update_pdes(adev, vm);
+	r = amdgpu_vm_update_pdes(adev, vm, NULL);
 	if (r) {
 		pr_debug("failed %d to update directories 0x%lx\n", r,
 			 prange->start);
-- 
2.53.0

