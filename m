Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03B1606A31A
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 03:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=UqzjrLf3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F289510F8A8;
	Wed, 21 Oct 2026 03:00:47 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013061.outbound.protection.outlook.com
 [40.93.201.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E5AD10F8A1;
 Wed, 21 Oct 2026 03:00:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QHy7w9rTU6sPPzKbMg3WOXdh2um7Yo4S9v78LyCLjKyKGenKErGuM7bpFOXDGy2zZjfYtCrac88so3AwrbZuIGDD58KaVFNqmIBGL0CB3GtECze+sIODaAgZR9nWrFynDhL0lPKd42hlcQBrcePjrX0UFyQnXhNjvMd7Fv2JlSxFDGqCp2MmUGz0D93O0kCSGTz0eHad53pMfqraAG68UHj7JpN2LzEPucSBKZahIyuw6ynGcqAY+Yn5PYd0kKkT3R+JkO7GE2y91vACH6hkQP4mwuJSK+hC48d0hEfm8DPyROoOx8fC91uhjceP9zv8o6kzWt7OpoBYOdoJtLG+Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zBW7mo1kkjSAydza/qk1vxHI9S5sQbOwz08d2X6YA94=;
 b=L4jTaVeUgxBRMvZJi++XLkhIqwFYnY0RO7UaW00t9RULVj8HJx68mIdUF9qGwuA6pj+dXDZbclfL2p9aHL5f34o4FFxHAYlpgzM3alNT8viY4oVLviqA2iRAF5v77PLEtt2BCPc4q+NSSprks16ja4TVenwpcscdbj9XgmMP2tMuvDKfdvDroe3wGahYTrblX7DdvpDiDn7YzWsAjKtAvyhkvamtnZIk7NM4ArSKtjDuBT9KGznHb/PCLnC9byuyyEO2zORAjTmfrZh8vs9NBIzF13PfnA+wJoUb5QDEwezopT+KY7h8+Q8Wp24MhL0qF9lWAHkhvzcvLcKBCD86ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zBW7mo1kkjSAydza/qk1vxHI9S5sQbOwz08d2X6YA94=;
 b=UqzjrLf3qYTguGJCEGZQ+yo60CI3dqc6q4oXaDe10WbI0kCB0dW0imWce7q2wZpdrzWL3kB4KruORh+rgzdRZJFo4jbtCe70rQ60zTuV4Hg75y76FwUI41TsMTgoNTIItn1JD8maFoanYAyazhF5Z7GqmdFOTKH7GeQFk0xwtmk=
Received: from SJ0PR03CA0177.namprd03.prod.outlook.com (2603:10b6:a03:338::32)
 by BN5PR12MB9509.namprd12.prod.outlook.com (2603:10b6:408:2a8::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 03:00:31 +0000
Received: from SJ5PEPF000001D5.namprd05.prod.outlook.com
 (2603:10b6:a03:338:cafe::a4) by SJ0PR03CA0177.outlook.office365.com
 (2603:10b6:a03:338::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.19 via Frontend Transport; Wed,
 21 Oct 2026 03:00:31 +0000
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
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 03:00:31 +0000
Received: from hr-amd.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 20 Oct
 2026 22:00:26 -0500
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
Subject: [PATCH v10 13/22] drm/amdgpu: make VM eviction lock read/write to
 match notifier lock
Date: Wed, 21 Oct 2026 10:58:52 +0800
Message-ID: <20261021025915.2433837-14-ray.huang@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D5:EE_|BN5PR12MB9509:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e97eed7-2085-46a7-fca9-08df2f1f7802
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|36860700016|82310400026|921020|56012099006|11063799006|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: zWpctLzCguJuASo4sNsMGbQLcZP3xTn7jC3Hfem10LmzzFHwD/Bi/H1lhfl3CCF4BcHmH4dyIcm9WD+WnhxqWH4LutbyNYmmxGLNp4WQXl6uIwyIkZvGZ0PleJ3NmJGqMC4C8uOFeJ6wm8Gt9FEPJpBt7ODejS10B+axV1JQzPwHIB24N1D4ajyJAUT5Vt9uswQpPUDWZh+CCtZ5XMpgj4RY47XZMU4Jk3FjYWra/yfCXS17LiRk+wjEZsxB//58WvRDV1jXZtfTyNtMJB7dB6h9lUgkNPyu8XPFbfKtgSGxKmTCl/BSEhzYLJm0HwdO481u68914KWJzn0mJFQMvUf/9cLrYl2d7cGDZwIq2/xsA3UuG2gr+SfbpMDg4Hye8Bu4XO9W685wZSgjRUreGFArPeF8GqQR6X88AjF2gSUVCTzju3lrdteCxp9apOBApfFIXBcgJxcwN5f04ALnZT7HvAzoYIP4H0UNOUCoBWDlDDdUh8tUA1a+PiB/zRdn9oEuTnnEirYKw4171csbFzSziLYDCIVWuXYKjkUZzXtgfuTUOpKwyEM6WNZw4+z8AIxUl75FB+3ezNfe41g1AO9lOwNhT9UU5hF8Sdj2eqMgf7Vihudi/s1YTwUpsoWfM4/gH/kSi5rAuwjrLZcsfhJJDPeP0mqVNMLBCkthTyOwJ7IATHC3E4Iez+0lDlCQZK3p69j91xnSaL7CFta0FuIcmbXGyXkkO33lLymTczx+jABEDv3Idrb7Fg0UmIlu
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(36860700016)(82310400026)(921020)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JofTgadiSIIhmruuybpXTEIBZ/+9WaGxMDZ8P+yTZ/97TQq+YoALwvnxkoB3BpPjy+oVoLF5HfAGcFYlZkVrOSnvxPGsqg/6zJbGXiiUyaFSRZTyYTUJJ3W25Y1fB2Zdfgh4Z1MI24H1ho9lJky1D3NLsP+gUjVLTnUxxBN3h0S18Y3nisXWUGuMp3eGSzBy6cWbew6OBpsfbFAhALevR/tBylFDnfyVEd6E8myEQ2q068tdD+T1I/JVBe2x8TRmwhHl0RdNYaL6AejS16WR8a5qnTWMd11KOHeJYOFyfvC2WG/wjbE0P4PKGRoVxJNKQE0jNGqXScSlqIGRr+MygHFR2MQD4NzfjskV8eQc9TzALs+J+T6vNiV/IxXbt+YSZrVJhh3Pdyycc1HtB9KVv3K4q9aRlShXAWwv7NEuc7VWFTLafIQwzK+Nja588Ts4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 03:00:31.3175 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e97eed7-2085-46a7-fca9-08df2f1f7802
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9509
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
index 77f1794eb5011..e851912999a51 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -617,7 +617,7 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	 * As soon as all page tables are in place we can start updating them
 	 * again.
 	 */
-	scoped_guard(mutex, &vm->eviction_lock)
+	scoped_guard(rwsem_write, vm->eviction_lock)
 		vm->evicting = false;
 
 	list_for_each_entry_safe(bo_base, tmp, &vm->always_valid.evicted,
@@ -678,7 +678,7 @@ bool amdgpu_vm_ready(struct amdgpu_vm *vm)
 
 	amdgpu_vm_assert_locked(vm);
 
-	scoped_guard(mutex, &vm->eviction_lock)
+	scoped_guard(rwsem_read, vm->eviction_lock)
 		ret = !vm->evicting;
 
 	ret &= list_empty(&vm->kernel.evicted);
@@ -2357,7 +2357,7 @@ bool amdgpu_vm_evictable(struct amdgpu_bo *bo)
 
 	/* Try to block ongoing updates */
 	vm = bo_base->vm;
-	scoped_cond_guard(mutex_try, return false, &vm->eviction_lock) {
+	scoped_cond_guard(rwsem_write_try, return false, vm->eviction_lock) {
 
 		/* Don't evict VM page tables while they are updated */
 		if (!dma_fence_is_signaled(vm->last_unlocked))
@@ -2713,7 +2713,8 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	vm->last_tlb_flush = dma_fence_get_stub();
 	vm->generation = amdgpu_vm_generation(adev, NULL);
 
-	mutex_init(&vm->eviction_lock);
+	init_rwsem(&vm->default_eviction_lock);
+	vm->eviction_lock = &vm->default_eviction_lock;
 	vm->evicting = false;
 	vm->tlb_fence_context = dma_fence_context_alloc(1);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index b435e393be154..ffdfaadc90544 100644
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

