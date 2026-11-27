Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F093E606A31E
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 08:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=MTL+NDCc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E63211287D;
	Fri, 27 Nov 2026 08:43:10 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012057.outbound.protection.outlook.com [52.101.53.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5320D112878;
 Fri, 27 Nov 2026 08:43:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bXcO0Fvtc2ABEmaQWE6ISCGWRxgaoeCCc38AneGO8XfnQloYoLNG5F8KNN183UKVpRRx62sXwdzPZN2aq0wiaV9uiu+RUX16/NoeT2ZPjNtAyp8zKruxl/QdJnsnCV9ghkcB16FvAcyg3neGQWLnjoLyu5SHbRnGpomCSQZIk7rXVy09nD0yacIlBdndoc3HkGu55+lNqVjlhWYUPxNQ+8WkB83mWAOnfyWx9zAzVK0ihA2f+jtYLJ8fWxF35A7wToYhlKfX7iO80mLh/87aUTKXiHU8o6ij/7kUMUGH0YDhu3kDLomQ7XPk2u3NFriNGAQfCi770um0RYAn6lkIxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tAULFPkudazZlg1EuLCzKa+xaU4eVJwFs3sWVZ6v0is=;
 b=MksSQ4v2rN/8/qxOugkrtVx90rRcPHfjfoyGGK3N0FUYvHceIBdYDWMWCn+d4olGx9r/PVyPY5otSlAASaqG0TaAelYNB264HVVEwhgR/4440oeBI9udSoNfK7jvrkwOFEvR/dJwG0Fkf+bgACQoE5SeJmfassxUCXQHi4OpDxqDtPWSx6ORIWfoJmU2z38fm69NUU3jfEoNbGUsQ+S5h99prAUEARGkYEvfAMCdYDrgEjHPQxUYL46hqxPtI/pCtBZ0CXH5HnVpuTYRmxHnlzBg0gZSwsXeF0F5tdyBN/6m6SWZpvZhA+Sd+4CC6tXih38i/O1KKoxVJGwz98s3mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tAULFPkudazZlg1EuLCzKa+xaU4eVJwFs3sWVZ6v0is=;
 b=MTL+NDCcnLuc9B5pOBMWw8vnSTclm9+QCpY3zfGpJVOXh9x/qVvK47g3evAhDf9WTkGfsJ/iXtpEYsLKka30mq7ori46tOaguBGocoJlaCPNonbcF/yGuGgcfLKVNa0Roay1oJRkwWDnbTysQKrUgy5nHEwIFLiYB3U5djM94fU=
Received: from CH5P223CA0014.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::16)
 by DS0PR12MB7850.namprd12.prod.outlook.com (2603:10b6:8:146::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Fri, 27 Nov
 2026 08:42:55 +0000
Received: from CH2PEPF000166BB.namprd04.prod.outlook.com
 (2603:10b6:610:1f3:cafe::75) by CH5P223CA0014.outlook.office365.com
 (2603:10b6:610:1f3::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.10 via Frontend Transport; Fri,
 27 Nov 2026 08:42:55 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF000166BB.mail.protection.outlook.com (10.167.252.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.5 via Frontend Transport; Fri, 27 Nov 2026 08:42:55 +0000
Received: from hr-amd.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 27 Nov
 2026 02:42:50 -0600
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
Subject: [PATCH v11 13/22] drm/amdgpu: make VM eviction lock read/write to
 match notifier lock
Date: Fri, 27 Nov 2026 16:41:36 +0800
Message-ID: <20261127084149.925625-14-ray.huang@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF000166BB:EE_|DS0PR12MB7850:EE_
X-MS-Office365-Filtering-Correlation-Id: 358c772c-8349-406b-bb9e-08df4c626eb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|82310400026|36860700016|22082099003|921020|18002099003|11063799006|56012099006|261009223027099003|10067099003|261028144727099003|261021121427099003|261022105027099003|261022075727099003|261026121527099003|261021123027099003|261102123227099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: 5FWVbE8b8MjFhW28BIjiZL5MiMjxpIJuaIaVrLSD76+OweHD9d5tNAaR67AcZyBQQUGX/osxkOx/NDkcq6ThdvmYihdtAcG4Gvam8GA65UmFqqH2cbjd+/lSzGbu+PU3dP0Ga8S4j9Tk6Ec0cD5cQ8WcCql/A2nOUhpfFyKO2cYAtzvDVwK5QZEdl9iT0jckRgpciWypk6eR/4GtjDvf8Ds7AkOVjxEIjMF4ITGWwao/haO4zL/EHAgjPTb9F4F9Jx2DW9b3uWasw/P5xuCl31b0wCDSnMaPKxhl7OqsPNKhB4nqsUAjaXmzEyc51re934FXxCBcgqWZubHsM2Nn4gLT5Uw3f5ZIxroYUOy93M+KiF48LeN7xdHLT0mmJEQSfDNfOoKSvXlD34FXnTRHpweB0XtCjzYq+JGj883G+c0wlm5HwlchWRfgHjm04abDxHlg9azx0G+Yz240N6i8IKKZwpGEOZxvvcw1vDR2SSmvG97oM5h9gS2nuDNG1AyJry+R9tVu+s/BEdn5fr+fYIx8Spi7zpp2YhAK/Z9KDJOMPK+KFyClw8iJVZFN+ojVU75Q2wrXURgo4rtnNfAWdBtR58CpdmgJ+rRGUvPJK1u/CWNwhvrhJUVc6WEa0ovzEED7Hwa9nJS9ojTiawUUTUmoXkae6NLC6EHmH/XJS1igL9a+RswGJJOxW39VoZVhmgjwKh/AWib6L7aGPW4MhVgiGdauWPlU+yD4b46HlAZUrLjRKLASHBgJJ8qtsf1L
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(82310400026)(36860700016)(22082099003)(921020)(18002099003)(11063799006)(56012099006)(261009223027099003)(10067099003)(261028144727099003)(261021121427099003)(261022105027099003)(261022075727099003)(261026121527099003)(261021123027099003)(261102123227099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: f/9hX1G7DJqB2alf5gpDPCKr/+xVbZKn35AwC1sPdNnT94VyPcKah48kt3PQFoP30H6a4p16DjBtPJWnBMuhdjotl8J1YQCII3gJEmzzs+r5S31tOMUKmeyHIWHlnshpf05QsIudZQHriqAdIMfbtlIhyKGqNpA8Nhh9wE9UW28cBeYiglFJol56XXJD/Gn89BD+sPG3D5axzTfo24BpXivykzj6YeIJTpYoJrXF1d1J9q+MQiI8IEm+ou87PnXcWZ6PtDVzvXO7lzCC4cE+vqaMZe7sc18axVe7Ic+1JLCAkqD+w4cmNoEy5JFHwE7WEgD6LeldcUpv7k4N4LUKCRNtTTn6ze6/3nVarmbKqBM2tzTFu8nst3z8/QNr5xBvYtQrKxQ26SO4YX3G0ouoFgK2XHyZ5bMHOLOfVPmD9YWV9rWxF8LTxFAUepjRkV0w
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 08:42:55.7514 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 358c772c-8349-406b-bb9e-08df4c626eb9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF000166BB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7850
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

Make the VM eviction lock read/write to match the drm_gpusvm notifier
lock. This allows VM updates, MMU notifier invalidation and eviction to
share the same rwsem.

Replace the VM eviction mutex with a selectable rwsem. Updates made with
the root BO reserved take the read side. Updates without the root BO
reservation take the write side, as does eviction. A VM using
drm_gpusvm can use the notifier lock as its eviction lock.

Suggested-by: Christian König <christian.koenig@amd.com>
Suggested-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Yu Huang <Yu.Huang@amd.com>
Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c          |  9 +++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h          |  8 ++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h | 12 ++++++++++--
 3 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 8831eb7c7cbc7..6f7043bdd2020 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -673,7 +673,7 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	 * As soon as all page tables are in place we can start updating them
 	 * again.
 	 */
-	scoped_guard(mutex, &vm->eviction_lock)
+	scoped_guard(rwsem_write, vm->eviction_lock)
 		vm->evicting = false;
 
 	list_for_each_entry_safe(bo_base, tmp, &vm->always_valid.evicted,
@@ -734,7 +734,7 @@ bool amdgpu_vm_ready(struct amdgpu_vm *vm)
 
 	amdgpu_vm_assert_locked(vm);
 
-	scoped_guard(mutex, &vm->eviction_lock)
+	scoped_guard(rwsem_read, vm->eviction_lock)
 		ret = !vm->evicting;
 
 	ret &= list_empty(&vm->kernel.evicted);
@@ -2392,7 +2392,7 @@ bool amdgpu_vm_evictable(struct amdgpu_bo *bo)
 
 	/* Try to block ongoing updates */
 	vm = bo_base->vm;
-	scoped_cond_guard(mutex_try, return false, &vm->eviction_lock) {
+	scoped_cond_guard(rwsem_write_try, return false, vm->eviction_lock) {
 
 		/* Don't evict VM page tables while they are updated */
 		if (!dma_fence_is_signaled(vm->last_unlocked))
@@ -2767,7 +2767,8 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	vm->last_tlb_inv = dma_fence_get_stub();
 	vm->generation = amdgpu_vm_generation(adev, NULL);
 
-	mutex_init(&vm->eviction_lock);
+	init_rwsem(&vm->default_eviction_lock);
+	vm->eviction_lock = &vm->default_eviction_lock;
 	vm->evicting = false;
 	vm->tlb_fence_context = dma_fence_context_alloc(1);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index bf752c6959b5c..05e332c1e01f6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -27,6 +27,7 @@
 #include <linux/idr.h>
 #include <linux/kfifo.h>
 #include <linux/rbtree.h>
+#include <linux/rwsem.h>
 #include <drm/gpu_scheduler.h>
 #include <drm/drm_file.h>
 #include <drm/ttm/ttm_bo.h>
@@ -288,10 +289,9 @@ struct amdgpu_vm {
 	/* tree of virtual addresses mapped */
 	struct rb_root_cached	va;
 
-	/* Lock to prevent eviction while we are updating page tables
-	 * use vm_eviction_lock/unlock(vm)
-	 */
-	struct mutex		eviction_lock;
+	/* SVM can replace this pointer with its notifier lock. */
+	struct rw_semaphore	default_eviction_lock;
+	struct rw_semaphore	*eviction_lock;
 	bool			evicting;
 
 	/* Memory statistics for this vm, protected by stats_lock */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
index 8a0e5fcbd55ba..920d0b3935807 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
@@ -160,7 +160,12 @@ void amdgpu_vm_pt_free_dummies(struct amdgpu_device *adev);
  */
 static inline int amdgpu_vm_begin_critical(struct amdgpu_vm_update_params *p)
 {
-	mutex_lock(&p->vm->eviction_lock);
+	/* Use the write lock to serialize updates when the root BO is unlocked. */
+	if (p->unlocked)
+		down_write(p->vm->eviction_lock);
+	else
+		down_read(p->vm->eviction_lock);
+
 	p->saved_flags = memalloc_noreclaim_save();
 	if (p->vm->evicting)
 		return -EBUSY;
@@ -178,7 +183,10 @@ static inline int amdgpu_vm_begin_critical(struct amdgpu_vm_update_params *p)
 static inline void amdgpu_vm_end_critical(struct amdgpu_vm_update_params *p)
 {
 	memalloc_noreclaim_restore(p->saved_flags);
-	mutex_unlock(&p->vm->eviction_lock);
+	if (p->unlocked)
+		up_write(p->vm->eviction_lock);
+	else
+		up_read(p->vm->eviction_lock);
 }
 
 #endif
-- 
2.53.0

