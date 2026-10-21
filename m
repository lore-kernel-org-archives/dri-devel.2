Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1653E606A31A
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 03:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=pMCk/U5C
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65E2210F8AE;
	Wed, 21 Oct 2026 03:01:00 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013063.outbound.protection.outlook.com
 [40.107.201.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C068510F8A5;
 Wed, 21 Oct 2026 03:00:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bPSRLOsVtMl+yJfTFDBmc/1vW1jDoB0hUm0CYWN0iea31LlqaUmnRoimaMn+ErPyr6xDGiZpbeWo2vD66Fe3Gevc82z5hMYAS+8V3hYHWEtw5z1dkTMq5EMrnO0vVfbkgxbRdLR1wuQKnoVxOghgCYSnlAHRDVY9yy082wjc8/X6IDO0jZuIP1txdjgXirO8xmmFDPgTD/o9uaXnujTeYy/XcpXut803conaSZQ0iXYkMSh/zi64RCE22WYhoHPow3fC32a+YbkKiewgwd37ol1l9wC93+OSsESb9+XzSQPveHwro14NUQxICY18OFyRFgUWx2XI1UDAdEYMyeDi6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tdkgi34i1ilMmzry/pCXmKEQCwkewR772fwrsilAkGM=;
 b=KGpbp6eSm1yiZ3NDxl0XoLYkBGPJC7cvCBi28tfnCnjZu7sDdW5Hrgbk0lzK8qSnME4FSfl5yJ9Hp5l3eS0y7WxB/AOd/1XTLChzidIIZ67F8UlKhorNVQEkkKZknP36Q8fvmRjmCHX6n+9/Gs+hZk3TPOXpWsPsQUJj9tFmZUBHo9nRq7NP7q+A8Yh30XaOIHg9Zjc/5ElL0WnBxX07UCjmCpUMhw13rPDdFIWIlfXbiAk2BaswTZLFVGCytrhqkkkKaD7NU3CHLtoyahyJi/F6hjntLD96adxURWtYNwilnKhDVZeUv4kG33GhYaC3DTOu9+u/y2rQa3fLERYqCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tdkgi34i1ilMmzry/pCXmKEQCwkewR772fwrsilAkGM=;
 b=pMCk/U5CmzMi1jdsNZq+vRMHHEXkO7khlCVwk1m5hiP0z5tHvkUFuwPBPw01M2hYTVZq+ZQkV/wOjDlGoY3Bwg73vCzXFVqPkufznOCsbsiC0G+OLbRJprUk3qKjJ4MFfBIDTvxAs4yzMhjMRevsn99iJy6EdwzMUJGBkHGWEVc=
Received: from SJ0PR03CA0160.namprd03.prod.outlook.com (2603:10b6:a03:338::15)
 by IA0PR12MB7604.namprd12.prod.outlook.com (2603:10b6:208:438::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 21 Oct
 2026 03:00:46 +0000
Received: from SJ5PEPF000001D5.namprd05.prod.outlook.com
 (2603:10b6:a03:338:cafe::7b) by SJ0PR03CA0160.outlook.office365.com
 (2603:10b6:a03:338::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Wed, 21
 Oct 2026 03:00:46 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D5.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 03:00:46 +0000
Received: from hr-amd.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 20 Oct
 2026 22:00:36 -0500
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
Subject: [PATCH v10 15/22] drm/amdgpu: use drm_gpusvm notifier lock for VM
 eviction
Date: Wed, 21 Oct 2026 10:58:54 +0800
Message-ID: <20261021025915.2433837-16-ray.huang@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D5:EE_|IA0PR12MB7604:EE_
X-MS-Office365-Filtering-Correlation-Id: ecf9f915-6087-4337-8494-08df2f1f810a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|23010399003|376014|36860700016|18002099003|6133799003|11062099010|7136999003|22082099003|261009223027099003|10067099003|11063799006|921020|56012099006;
X-Microsoft-Antispam-Message-Info: JECV+OI2j3ivFGZ5dBsEW3qWtJ/vHH6pyESu5HXSSrFX0yzOzFHS92rdd8FMA9lAN7iBDyd30F5iEWu0O3AxAb81J7GbBIPkLaq8mqHFuPhE7BNNgIWkZfI9YZRvHeF3WleEWIBGycNmOJ/OT2eI+ZAYefk0Fqyio6BvjelGQcVyEA96k6vnl46MaUOMI6A6YU8VvJg6LI4s6BDfvnqIsBj2daEd0n1UJzwEPZHGXKIKok48XFxd1wgEt1+/q3ZJ1yS8B4AjpwJHen7mZBBOooP+3+nYK127cCJiQgWulEE1519G7enFwu+KWZLUGDHJiaMBdVCIUznWH8S9B8MQroIQ92vq5jqK6fGdiwcFKC6n1T0fW2vxOwbywp3euoHUPbrmJwMF9II2HqaAGiBd9APS+vXFnsEjLo0jBKvsHkRSt1J7zkfCkgF7Y/CUyzt7TbPStMYukjiqFoxH+R3s9d2Vl8IZQpbq1JwRtKeeUWV1zukyE31kn7sKdYfLV7JmMR+ZAJgdnZhDLY6a3PmW3Koe0Vvv5GBla05C8rnbfxHyMPK85uHjZWlmgmX46+P+oxqd4UUwpegNAL6RFUn749BSXAjHE1CG7QeH98LMBIfci71XtujMViCJrcmaKqEu431cIQhvuE1e49CV/CcMmVOmeWp26MrWuvB37sFfa5hwFpETxB6AgsiBM8UU9cFolc7taTywWlZXNL/WlOurSptmPAJk9vYAF9/fqFTWlqk7nC2hyJ1mwECJAy0rwx+m
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(23010399003)(376014)(36860700016)(18002099003)(6133799003)(11062099010)(7136999003)(22082099003)(261009223027099003)(10067099003)(11063799006)(921020)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: QXUJyDYE+HIEN5Xyhd8bUg7juEzUMgjWhtaUUVuoXjQL4fXRYqxHNtyXuuMJkI9V89lLTpo8sYnxKkxKyVMuIRfcRqVWdi0/9cr8PUKY56Oybd6jDCQ/JwiiVsTxXEheoTD9TrXhyfABCnBc3jO4rNBDEqpA6zfnRL3RX29kxQqemMUY40U3QXggYoJ5dZQ/OSq/567joXvwVxwUxF7UngRx0TCr7H9mZbtMjqLtcQJyISGOaQO+fNrnaeBsivvfPYK/A2KS/zeagmo4ZiX1I7pzFT0Xuqa5yWJou8qSVxsSQyhle9tT+169+DrEa13zSIEk+aOSufDXiaG4WVjVs9K0T9F1tLNLjr8Smra6EnwPCOP87q6aazw7zJvCi6t0D5eb6MJkXFdmHL5stX/On61IsH/Qc5f2XxwIXxSCMrTXsC57Pa2OIl3sUWrIIB7u
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 03:00:46.4625 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ecf9f915-6087-4337-8494-08df2f1f810a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7604
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Honglei Huang <honghuan@amd.com>

Make amdgpu_vm's eviction lock a read/write semaphore so it can be
shared with drm_gpusvm's notifier lock: VM updates and eviction take
it for read, MMU notifier invalidation and eviction take it for write.

Pass the held eviction lock through to amdgpu_vm_update_pdes() in the
SVM context so callers that already hold it do not try to reacquire it.

Fix the eviction_lock argument at this call site: it must be the
3-argument form (adev, vm, eviction_lock) introduced by "recheck range
validity after page table allocation" - a stray leftover 4th argument
(an old "immediate" bool) was being passed here, which would otherwise
fail to build.

Suggested-by: Christian König <christian.koenig@amd.com>
Suggested-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Yu Huang <Yu.Huang@amd.com>
Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c       | 37 ++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c | 51 ++++++++-----------
 2 files changed, 49 insertions(+), 39 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c
index c7810e6d3035f..5ae8a649644ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c
@@ -157,10 +157,13 @@ amdgpu_svm_lookup_by_pasid(struct amdgpu_device *adev, uint32_t pasid)
 	amdgpu_pasid_lock(&irqflags);
 	fpriv = amdgpu_pasid_get_fpriv_locked(pasid);
 	vm = fpriv ? &fpriv->vm : NULL;
-	if (vm && vm->svm) {
-		svm = vm->svm;
+	/*
+	 * eviction_lock changes when SVM is enabled, so acquire vm->svm
+	 * after the new lock alias is published.
+	 */
+	svm = vm ? smp_load_acquire(&vm->svm) : NULL;
+	if (svm)
 		kref_get(&svm->refcount);
-	}
 	amdgpu_pasid_unlock(irqflags);
 
 	return svm;
@@ -501,6 +504,8 @@ static int amdgpu_svm_init_compute(struct amdgpu_device *adev,
 	struct amdgpu_svm *svm;
 	int ret;
 
+	dma_resv_assert_held(vm->root.bo->tbo.base.resv);
+
 	if (vm->svm)
 		return 0;
 
@@ -535,7 +540,9 @@ static int amdgpu_svm_init_compute(struct amdgpu_device *adev,
 	       1UL << (svm->default_granularity + PAGE_SHIFT),
 	       svm->xnack_enabled ? "enabled" : "disabled");
 
-	vm->svm = svm;
+	vm->eviction_lock = &svm->gpusvm.notifier_lock;
+	/* Publish the context after its notifier lock alias. */
+	smp_store_release(&vm->svm, svm);
 	return 0;
 
 err_free:
@@ -611,31 +618,43 @@ void amdgpu_svm_close(struct amdgpu_vm *vm)
  * amdgpu_svm_fini() - Finalize and release a VM's SVM context
  * @vm: The VM whose SVM context is being torn down.
  *
- * Close the context, tear down the embedded drm_gpusvm under the SVM lock,
- * destroy the attribute tree and work queues, and drop the context
- * reference. Safe to call on a VM without an SVM context.
+ * Tear down the embedded drm_gpusvm, attribute tree and work queues, and drop
+ * the context reference.
  */
 void amdgpu_svm_fini(struct amdgpu_vm *vm)
 {
 	struct amdgpu_svm *svm = vm->svm;
+	struct amdgpu_bo *root;
 
 	if (!svm)
 		return;
 
 	amdgpu_svm_close(vm);
 	amdgpu_svm_lock(svm);
+
+	root = amdgpu_bo_ref(vm->root.bo);
+	amdgpu_bo_reserve(root, true);
+
 	drm_gpusvm_fini(&svm->gpusvm);
+
+	vm->eviction_lock = &vm->default_eviction_lock;
+	/* Publish the lock reset before making SVM unavailable. */
+	smp_store_release(&vm->svm, NULL);
+
 	amdgpu_svm_unlock(svm);
 
 	amdgpu_svm_attr_tree_destroy(svm->attr_tree);
 	amdgpu_svm_work_fini(svm);
-	vm->svm = NULL;
 	amdgpu_svm_put(svm);
+
+	amdgpu_bo_unreserve(root);
+	amdgpu_bo_unref(&root);
 }
 
 bool amdgpu_svm_is_enabled(struct amdgpu_vm *vm)
 {
-	return vm->svm != NULL;
+	/* Pairs with publishing vm->svm after its lock alias is initialized. */
+	return smp_load_acquire(&vm->svm) != NULL;
 }
 
 static int amdgpu_svm_copy_attrs(const struct drm_amdgpu_gem_svm *args,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
index a1aa84974a43a..787afe0767e5a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
@@ -65,16 +65,14 @@ amdgpu_svm_range_zap_ptes(struct amdgpu_svm *svm,
 			  unsigned long last_page)
 {
 	struct dma_fence *fence = NULL;
-	unsigned int flags;
 	int ret;
 
 	if (last_page < start_page)
 		return 0;
 
-	flags = memalloc_noreclaim_save();
 	ret = amdgpu_vm_unmap_range(svm->adev, svm->vm, true, NULL,
-				    start_page, last_page, NULL, &fence);
-	memalloc_noreclaim_restore(flags);
+				    start_page, last_page,
+				    svm->vm->eviction_lock, &fence);
 
 	if (fence) {
 		dma_fence_wait(fence, false);
@@ -210,20 +208,11 @@ amdgpu_svm_range_update_gpu_range(struct amdgpu_svm *svm,
 		mapped_pages += seg_pages;
 		is_last_seg = mapped_pages == npages;
 
-		/*
-		 * The struct hmm_range hmm_range field inside amdgpu_hmm_range
-		 * is drm_gpusvm internal state. It is not exposed to the
-		 * implementing driver and is managed entirely by the framework
-		 * as part of the framework logic. This amdgpu_vm_map_range call
-		 * always runs inside the drm_gpusvm notifier, so omitting
-		 * hmm_range here is safe.
-		 */
-		ret = amdgpu_vm_map_range(svm->adev, svm->vm,
-					  flush_tlb && is_last_seg, true, NULL,
-					  start_page, last_page, pte_flags,
-					  0, entry->addr, NULL, NULL, NULL,
-					  NULL, NULL,
-					  wait_fence && is_last_seg ? fence : NULL);
+		ret = amdgpu_vm_map_range(
+			svm->adev, svm->vm, flush_tlb && is_last_seg, true,
+			NULL, start_page, last_page, pte_flags, 0, entry->addr,
+			NULL, NULL, NULL, svm->vm->eviction_lock, base,
+			wait_fence && is_last_seg ? fence : NULL);
 		if (ret)
 			return ret;
 	}
@@ -308,14 +297,12 @@ int amdgpu_svm_range_update_mapping(struct amdgpu_svm *svm,
 {
 	struct drm_exec exec;
 	struct dma_fence *fence = NULL;
-	unsigned int flags;
 	int ret;
 
 	ret = amdgpu_svm_range_lock_vm_pd(svm, &exec, intr);
 	if (ret)
 		return ret;
 
-	flags = memalloc_noreclaim_save();
 	drm_gpusvm_notifier_lock(&svm->gpusvm);
 
 	if (!amdgpu_svm_range_pages_valid(svm, range)) {
@@ -327,24 +314,25 @@ int amdgpu_svm_range_update_mapping(struct amdgpu_svm *svm,
 							wait, wait ? &fence : NULL);
 	}
 
-	drm_gpusvm_notifier_unlock(&svm->gpusvm);
-	memalloc_noreclaim_restore(flags);
-
-	if (!ret && fence)
-		dma_fence_wait(fence, intr);
-	dma_fence_put(fence);
-
 	if (!ret)
-		ret = amdgpu_vm_update_pdes(svm->adev, svm->vm, NULL);
+		ret = amdgpu_vm_update_pdes(svm->adev, svm->vm,
+					    svm->vm->eviction_lock);
 
 	if (!ret) {
-		if (flush_tlb)
-			amdgpu_svm_flush_tlb(svm);
 		WRITE_ONCE(range->attr_flags, attrs->flags);
 		WRITE_ONCE(range->gpu_mapped, true);
 		range->validate_timestamp = ktime_get_boottime();
 	}
 
+	drm_gpusvm_notifier_unlock(&svm->gpusvm);
+
+	if (!ret && fence)
+		dma_fence_wait(fence, intr);
+	dma_fence_put(fence);
+
+	if (!ret && flush_tlb)
+		amdgpu_svm_flush_tlb(svm);
+
 	drm_exec_fini(&exec);
 	return ret;
 }
@@ -585,9 +573,12 @@ amdgpu_svm_range_invalidate_interval(struct amdgpu_svm *svm,
 					crosses_boundary ? "ATTR DESTROY" :
 							   "ATTR ZAP PTE");
 
+				/* Use the unified eviction/MMU notifier lock for PTE zaps. */
+				down_write(svm->vm->eviction_lock);
 				ret = amdgpu_svm_range_zap_ptes(svm, svm_range,
 						drm_gpusvm_range_start(range) >> PAGE_SHIFT,
 						(drm_gpusvm_range_end(range) >> PAGE_SHIFT) - 1);
+				up_write(svm->vm->eviction_lock);
 				if (ret < 0) {
 					drm_exec_fini(&exec);
 					return ret;
-- 
2.53.0

