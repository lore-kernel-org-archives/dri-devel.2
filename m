Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89C5606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 08:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=wrfLfh/O
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D42D112886;
	Fri, 27 Nov 2026 08:43:25 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012063.outbound.protection.outlook.com
 [40.93.195.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79270112881;
 Fri, 27 Nov 2026 08:43:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=arXgAyHTqsNyeO8etymaVrJz99EEQlGjp+dhNd0dLiT5OI9Vl4s39hO42s5S0O7ghZGVr1XnDPhX5geNWB3k7TTDatuaFUG98dNMzs14GwICf1gCiHy8EywmmL6O+HsFvDMLUQBMEgs/WGSEI9XgV/GH42Dm1ssPKpnXDpzXD7xf3scU0zo5cYkssHYvEk03Aa6ZSMOEXaXVgoifZXPEOznz8bdw13QkXXGvAAUtmZS2tnfTp6rgrk7+RjpIJHOw4jb0iYdKjBmd1h0fxUP+8owCfrujUI3ES1uglpWZWarcsO7Yr1GiO5HzIyDov7Z2VB91pC61UWwTuuy9iDWhFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1B766K7KHWHjbp/hVP9W7pLbxf+gwEPLXTioQwBQ0qI=;
 b=t58Hbm7n/YtH8UgZK6T3u7/r/tdOSxZwjGOT9n5O04o9Rj72tkWrmApLcyX6TvJyVO7WeN0QuR3chtPKv9hm/FSwdPgKTRicjFRvAwkzktWAFE9tw0UNOtrcrvuiTZKRRSvAMgHVXZZKwEWycrsxUpenKNXaSLaUAc8LRkhGrDA+568w92cqTY/p0VKKPVvHDUkXx9af1Wk5GHQrK6sESN2zhpy2sVs5L6y/MblW6/gzrruQHfv9tMdVPY95nd9A6D3ovKChRK06dNDMFS5mAQ7F+S7WVgM+Ck62WPQx6UNT9RNmYFnh1HDLJKqtl8keIc7o6G810ucHNyzFuDssFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1B766K7KHWHjbp/hVP9W7pLbxf+gwEPLXTioQwBQ0qI=;
 b=wrfLfh/OJ1PbA+3uvbtf1W7tcU6MQ8EAX7/UTpgUBBD3lCd9jI2RiepZVkj0e0DJIacIB2Q1WlQ6gx/mpq0xDYVDYI/pXUWGuqh2iXY7JNxXlMmuk0aAMfBAjosvY3T/kci7WYOX0ZLdk2K/la3CxRoLOahjc4aUPZlF+rKrXu0=
Received: from CH0PR13CA0009.namprd13.prod.outlook.com (2603:10b6:610:b1::14)
 by DS7PR12MB6240.namprd12.prod.outlook.com (2603:10b6:8:94::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Fri, 27 Nov
 2026 08:43:06 +0000
Received: from CH2PEPF000166C1.namprd04.prod.outlook.com
 (2603:10b6:610:b1:cafe::69) by CH0PR13CA0009.outlook.office365.com
 (2603:10b6:610:b1::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.688.5 via Frontend Transport; Fri, 27
 Nov 2026 08:43:06 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF000166C1.mail.protection.outlook.com (10.167.252.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.5 via Frontend Transport; Fri, 27 Nov 2026 08:43:06 +0000
Received: from hr-amd.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 27 Nov
 2026 02:43:00 -0600
From: Huang Rui <ray.huang@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Philip Yang
 <Philip.Yang@amd.com>, Alex Deucher <alexander.deucher@amd.com>, "Felix
 Kuehling" <felix.kuehling@amd.com>, Simona Vetter <simona@ffwll.ch>, "Matthew
 Brost" <matthew.brost@intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Aveline Noir <jm5905938@gmail.com>, <amd-gfx@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>
CC: Xiaogang Chen <xiaogang.chen@amd.com>, Oak Zeng <Oak.Zeng@amd.com>, "Jenny
 Liu" <Jenny-Jing.Liu@amd.com>, Zhu Lingshan <lingshan.zhu@amd.com>,
 "Honglei
 Huang" <honglei1.huang@amd.com>, Junhua Shen <Junhua.Shen@amd.com>, Yiru Ma
 <yiru.ma@amd.com>, Huang Rui <ray.huang@amd.com>, Honglei Huang
 <honghuan@amd.com>, Yu Huang <Yu.Huang@amd.com>
Subject: [PATCH v11 15/22] drm/amdgpu: use drm_gpusvm notifier lock for VM
 eviction
Date: Fri, 27 Nov 2026 16:41:38 +0800
Message-ID: <20261127084149.925625-16-ray.huang@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261127084149.925625-1-ray.huang@amd.com>
References: <20261127084149.925625-1-ray.huang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF000166C1:EE_|DS7PR12MB6240:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d28cfce-b731-4e5c-600c-08df4c6274dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|23010399003|82310400026|921020|10067099003|56012099006|11063799006|261021121427099003|261021123027099003|261022075727099003|261026140227099003|261026121527099003|261009223027099003|261102123227099003|261022105027099003|261028144727099003|7136999003|22082099003|18002099003|11062099010|6133799003;
X-Microsoft-Antispam-Message-Info: UpQUYL3JJuOLdIA6N3IuuhWGmfTNH+iOtvhWUYiRLpiIKgqNqVzcTmaY3QbJ5/Lgkh6apHfbn39pM9EvZtEZUdZqVPiu2iJR6HpkaCKvOLyKeoP6vP3om8Y9kcC4+eBPdgYL5WcO7K6VvIgD4CsJY3vBKeSgxnsFyCVBUSBPXPstqe1yZHltGAYWMykj3QuH8bpbJu+WGtm8Pu0x4M8g+5vb/YLoyabGjHIuyLInyPMEqqXjA4q9ZT5GhHPvz46Bq9xy1TU5F6PKzKtCePzs2z5IjyDx9zCLB1JxOh322YsvmyQEJp9J6q8tlRDe+t13sOvu1upBKaL1SeYnnpBimu9NRduVMsFF2Je7J4vPbNNuELaecCjr4eBH6aYrjDX16/CMCWNMErsO5C5OL4twSAToy0bdOMkD2q8rb5aR7HVSm95F3VG/9suJg1E927p6IaIWnlH+N8/IzCaA7pZljjhpnpK6WvGbWnOL5RtMPAYj7vme0o5aFR5OwlNccRM+b6v0jGFKJIq7fuXirpcp68v+opsVRWYxWlzGXniPpjmnaWW2vAcHyVNTgcfWgJwfZIILtXpqlixyX8G52HOyTdcRoq1lw6/ju3/mOzK7tMSvdI0RWpkLedbRQakRRqJ1RuY2uqUKs/059T3QuVwzydD5snXb/Gt5BwR9kneacqTGCgK9RSFM/S5k1D5f7UwGK5XYjt1eAm0h2XPUnQfV1M9FJQaYAroOMH/WVtupmHaI25NeqKo06HUxY2ynM7WH
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(23010399003)(82310400026)(921020)(10067099003)(56012099006)(11063799006)(261021121427099003)(261021123027099003)(261022075727099003)(261026140227099003)(261026121527099003)(261009223027099003)(261102123227099003)(261022105027099003)(261028144727099003)(7136999003)(22082099003)(18002099003)(11062099010)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Zg1cPqPYpkUC3MBDWB4VZjXhDS50CHQ3Lyy/O79MJuNnTfhNSWnf+JOhro6Q1itRAChvNv7epvuLwuLTq9x/jKlCoAqm7L/7CCMe4ZomCPZk2qhhODN6k5hc9FnekI1BFGeflY2MbD7q/rmul7HWWvOrrKdA7VwlNxI0yXHqkKzLMP1VyEUtx+9HpC6zAyklGVQNFBb5GGIianYo0xa3LdzzCZKcMAM9zbba5igsQUIgkOge+Xshof3fdjZ8+GD2U9yiTbT3A6uaWutECI8Hg5jQrRsMdcKyr1Qwqj7qSHSHBk7XnrmJhzhhN3C4ZqP8ubwlZJy4EnAVI3hIRnyjaUJrCOWDiLAb8fk/t5Q8TRIVNlmsW4qyjp4utKx1Mlce9z+6GJBzPyJVoSNKxcruqm3GagwSETmNiDNrwrjiJYlklFEqY1J3smqT6+BY79yP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 08:43:06.0513 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d28cfce-b731-4e5c-600c-08df4c6274dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF000166C1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6240
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Honglei Huang <honghuan@amd.com>

Use the GPUSVM notifier semaphore as the eviction lock for an SVM
compute VM, so page-table updates, MMU invalidation and BO eviction
share one serialization mechanism.

Pass the caller-held lock to the VM update helpers. Keep range
validation, PTE/PDE updates and mapping-state publication under the
notifier lock; wait for update fences and perform the compute TLB
flush after releasing it. Publish the lock alias before the SVM
context, and restore the default lock before unpublishing the context
during teardown.

Suggested-by: Christian König <christian.koenig@amd.com>
Suggested-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Yu Huang <Yu.Huang@amd.com>
Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c       | 37 ++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c | 42 +++++++------------
 2 files changed, 44 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c
index cf9c27cb0080f..8036ee189269f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c
@@ -157,10 +157,13 @@ struct amdgpu_svm *amdgpu_svm_lookup_by_pasid(struct amdgpu_device *adev, u32 pa
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
@@ -465,6 +468,8 @@ static int amdgpu_svm_init_compute(struct amdgpu_device *adev, struct amdgpu_vm
 	struct amdgpu_svm *svm;
 	int ret;
 
+	dma_resv_assert_held(vm->root.bo->tbo.base.resv);
+
 	if (vm->svm)
 		return 0;
 
@@ -496,7 +501,9 @@ static int amdgpu_svm_init_compute(struct amdgpu_device *adev, struct amdgpu_vm
 		 1UL << (svm->default_granularity + PAGE_SHIFT),
 		 svm->xnack_enabled ? "enabled" : "disabled");
 
-	vm->svm = svm;
+	vm->eviction_lock = &svm->gpusvm.notifier_lock;
+	/* Publish the context after its notifier lock alias. */
+	smp_store_release(&vm->svm, svm);
 	return 0;
 
 err_free:
@@ -570,31 +577,43 @@ void amdgpu_svm_close(struct amdgpu_vm *vm)
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
-	return vm->svm;
+	/* Pairs with publishing vm->svm after its lock alias is initialized. */
+	return smp_load_acquire(&vm->svm);
 }
 
 static int amdgpu_svm_copy_attrs(const struct drm_amdgpu_gem_svm *args,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
index 6cc491cdc3ca5..adb9a0730ebf4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
@@ -66,16 +66,13 @@ int amdgpu_svm_range_zap_ptes(struct amdgpu_svm *svm, struct amdgpu_svm_range *r
 			      unsigned long start_page, unsigned long last_page)
 {
 	struct dma_fence *fence = NULL;
-	unsigned int flags;
 	int ret;
 
 	if (last_page < start_page)
 		return 0;
 
-	flags = memalloc_noreclaim_save();
-	ret = amdgpu_vm_unmap_range(svm->adev, svm->vm, true, NULL, start_page, last_page, NULL,
-				    &fence);
-	memalloc_noreclaim_restore(flags);
+	ret = amdgpu_vm_unmap_range(svm->adev, svm->vm, true, NULL, start_page, last_page,
+				    svm->vm->eviction_lock, &fence);
 
 	if (fence) {
 		dma_fence_wait(fence, false);
@@ -139,17 +136,9 @@ int amdgpu_svm_range_update_gpu_range(struct amdgpu_svm *svm, struct amdgpu_svm_
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
 		ret = amdgpu_vm_map_range(svm->adev, svm->vm, flush_tlb && is_last_seg, true, NULL,
 					  start_page, last_page, pte_flags, 0, dst, NULL, NULL,
-					  NULL, NULL, NULL,
+					  NULL, svm->vm->eviction_lock, base,
 					  wait_fence && is_last_seg ? fence : NULL);
 		if (ret)
 			return ret;
@@ -231,7 +220,6 @@ int amdgpu_svm_range_update_mapping(struct amdgpu_svm *svm, struct amdgpu_svm_ra
 	struct drm_exec exec;
 	struct dma_fence *fence = NULL;
 	unsigned int exec_flags = DRM_EXEC_IGNORE_DUPLICATES;
-	unsigned int flags;
 	int ret;
 
 	if (intr)
@@ -246,7 +234,6 @@ int amdgpu_svm_range_update_mapping(struct amdgpu_svm *svm, struct amdgpu_svm_ra
 		}
 	}
 
-	flags = memalloc_noreclaim_save();
 	drm_gpusvm_notifier_lock(&svm->gpusvm);
 
 	if (!amdgpu_svm_range_pages_valid(svm, range)) {
@@ -257,24 +244,24 @@ int amdgpu_svm_range_update_mapping(struct amdgpu_svm *svm, struct amdgpu_svm_ra
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
+		ret = amdgpu_vm_update_pdes(svm->adev, svm->vm, svm->vm->eviction_lock);
 
 	if (!ret) {
-		if (flush_tlb)
-			ret = amdgpu_svm_flush_tlb(svm);
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
+		ret = amdgpu_svm_flush_tlb(svm);
+
 	drm_exec_fini(&exec);
 	return ret;
 }
@@ -510,6 +497,8 @@ int amdgpu_svm_range_invalidate_interval(struct amdgpu_svm *svm, unsigned long s
 									  "ATTR DESTROY" :
 									  "ATTR ZAP PTE");
 
+				/* Use the unified eviction/MMU notifier lock for PTE zaps. */
+				down_write(svm->vm->eviction_lock);
 				ret = amdgpu_svm_range_zap_ptes(svm, svm_range,
 								drm_gpusvm_range_start(range) >>
 									PAGE_SHIFT,
@@ -518,6 +507,7 @@ int amdgpu_svm_range_invalidate_interval(struct amdgpu_svm *svm, unsigned long s
 									1);
 				if (!ret)
 					ret = amdgpu_svm_flush_tlb(svm);
+				up_write(svm->vm->eviction_lock);
 				if (ret < 0) {
 					drm_exec_fini(&exec);
 					return ret;
-- 
2.53.0

