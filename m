Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BC9606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 08:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=L57x9FJ/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10F0111287C;
	Fri, 27 Nov 2026 08:43:10 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011014.outbound.protection.outlook.com [40.107.208.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B710112872;
 Fri, 27 Nov 2026 08:42:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SVC+91SVDu5dcevMACfBTArb2Xn9OpMUK9/fdaIxDwE4j0EeyMf3li6BP9U6y4Rmv8dxVSMuBx4BA3MKbBxqbcVladS5fOUtb2++waUmxHBnZEIEoNKO0TegoqSaiDQ7FvmMNhaDWxk8OZ3yOmTtQAPkt3/Rp1+jCLVg8tPDwpcwHw9JTeV3h/EqCvPhG4lfZfIli0K4CohkCGrgdVpjePaOkjrRaSuQASgG/F4fUHH8bAsaerhPUzS6haTuhQlVzhlzvolxTDcBkFC4XSsivyaUy+/KjM40N5qACSfZkvJk2fXi1qNbKycJWNhVSOb14rLmaq/Dm/KoACUgzG7tpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rxkxwbaWg0t6jBQHt1xd9IjoLUHNHbil18g+U8um5eI=;
 b=gek/WgBWKJW6cuc4MRL3fBvDZs9uLdBsPK/TRw6Kl9QBVWbVbOYk4+KYcjPjcWA53TaigZPzx/Gnh8mXFv4nkxe4rjU3g9iINq+96pNZauCoqt4MwTcxiJHYXLP7QcLsPVPtSmDezixrPYKNbX6+afOnBsMKYCUOMDkOc2TU0t/2vChHC/C0qP6eeUP78LH5wbJuiOFwKsuguf4rKCVAqd4EtQJ2BXyWx0NawP0J+Eg6wIuJnA9+oCCYUn+ZiJhblIIGeGzANDi8MXz/m+O3snAgmyUfQqBEarbl+bYS+jmeMJved7UpcMI4MbH89qlWJTpFMpJASvXMS7M2+y+u6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rxkxwbaWg0t6jBQHt1xd9IjoLUHNHbil18g+U8um5eI=;
 b=L57x9FJ/8ovfvD1oIC9duSoD3mCNgKNaRcPrK7SjEV/wtS5GeCmyQdYJRn4l9F8pVI/w7B0MnGnMr4W8HJKnsHoO/RtHZVuzLOlrtdqd+8SpBdxhTVpd5FoJqaT6jGfx4KJPP9qbAsnNYSL02O+wOQb8gg9rofSNYgF4uiqsaTw=
Received: from CH5P223CA0007.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::18)
 by MW6PR12MB8997.namprd12.prod.outlook.com (2603:10b6:303:23e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Fri, 27 Nov
 2026 08:42:46 +0000
Received: from CH2PEPF000166BB.namprd04.prod.outlook.com
 (2603:10b6:610:1f3:cafe::7c) by CH5P223CA0007.outlook.office365.com
 (2603:10b6:610:1f3::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.10 via Frontend Transport; Fri,
 27 Nov 2026 08:42:45 +0000
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
 15.21.688.5 via Frontend Transport; Fri, 27 Nov 2026 08:42:45 +0000
Received: from hr-amd.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 27 Nov
 2026 02:42:40 -0600
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
 <honghuan@amd.com>
Subject: [PATCH v11 11/22] drm/amdgpu: add SVM ioctl entry and fault handler
 module
Date: Fri, 27 Nov 2026 16:41:34 +0800
Message-ID: <20261127084149.925625-12-ray.huang@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF000166BB:EE_|MW6PR12MB8997:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e60e12e-289a-4fd0-742d-08df4c6268b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|23010399003|82310400026|921020|10067099003|56012099006|11063799006|261022115727099003|261022105027099003|261022113327099003|261021123027099003|261022075727099003|261021121427099003|261026140227099003|261026121527099003|261028144727099003|261102123227099003|261009223327099003|261009220027099003|261009223027099003|261009221227099003|261009221727099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: oNC8QFtOLEpcDuXVzjCk2QI+cuqYUfeIq4GX8Z3hHBm38J4D+oX9uZ94ZL8HSS7rusyvj1kqlT7bADhmfnpNZGNyyB3pvjtmtWn/Wtlcv20CTw6SC3TUVkNkBGnilXLseWIgrYr6iaOPc+JAiJ9JHPD4J7ZQZbUgFyKkRamGl2dqaQMgyYBAXjXl4zbA6ZJG3AnhpfLYZ/KFSFsKmsciZ0VPQu0SpyYMzURmLC7YktkCnPVARpP8HnVRU0tK1TY/n3d4ZxV55cuRDZ2Pg5wGYl270Q0VjbFXZNb2YamOEb4nSakVyuXegp+B+qPuvFDOp+lLIBsVXwQMlCGa1bYhttW/+JO5vaLuhhNG2rm3EATMU8g6lMarLgrAEOMeoxGKitd4sdBf6cEP+NiBj0nf5/wUb4AwuzurDmN+trGIWgX+d3rI4ztlU2CIrLmupHreepieAR0nFkJgLPoBcoQNEtQvIYTOuqyMO/m3CHZvwMcClWczTRLgUdreJAxYFg2DO3YBTzaCDa/uCnJ99t3i2HEBz42SQfeDRaA1GcyrpGZHEux2CQIUbXvWOzP/l2+AQKvhFXWxzkqNQQtRgt+zddgkN/0bidjuAf+16m0JIiqu3XndEp/haCe4ijYqVfu+zI7MYYSCBN9R6VWMreJTBeGBBbcW6/O0o9cqy3yfA0fvDhhAPsbIkDT6+WVCJJ8Kq1mvgCi/tZy7Rn5fowXlFpdBSTqNsYEbFdCTv6gD4j5moWrQLo1Tl0Vh3VCm58IJ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(23010399003)(82310400026)(921020)(10067099003)(56012099006)(11063799006)(261022115727099003)(261022105027099003)(261022113327099003)(261021123027099003)(261022075727099003)(261021121427099003)(261026140227099003)(261026121527099003)(261028144727099003)(261102123227099003)(261009223327099003)(261009220027099003)(261009223027099003)(261009221227099003)(261009221727099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YpJAEJTs2YciLpntBZhw8/8IMxDGIQPAhthMV8UqkJ8MeD0MQqUTopdDA2Boi/YsLp8+dJjC/m4tBHxIEMBO8PVDQaC78QtkBNAGWE9TVsfXjoDXRq6KB5RNq9ndFvvxrUJP8glIoxCVxAXok/klhEYonXN+eskcYcYIgHkVpIZ7Nv/zHgCadokOBhcQ73vhlMZIB+D3igXp1DPvuyvprhTY6wvUqcIIUU6Bhwp+gZhAbG9nr/qmiaN6J1qQRowAW6Ou4LokvHSgeGwUUIpkHKCvvjez8PBLs2fUkhJ85+ZQ+qeZBBFB6xzLNZCYUDFkMVLF6CBYDs5NHCSAFmNsSqrzwC5Ivj5GuK/n172v6a1OettCQXAKbDno+kLvGdCWYvki2GwxfzYzAkz7hoQP02TKF2SrS/DbgFd6EOyWC05+uwsYz/bf5g5Ai9la8tu2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 08:42:45.6557 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e60e12e-289a-4fd0-742d-08df4c6268b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF000166BB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8997
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

Add ioctl entry point and fault handling:

amdgpu_svm.c additions:
- amdgpu_svm_copy_attrs: memdup_user for attribute array
- amdgpu_svm_garbage_collector: dequeue and remove unmapped ranges
- amdgpu_svm_clean_queue: drain work list releasing refs
- amdgpu_svm_gc_work_func: static GC work handler
- amdgpu_svm_gc_init/fini/flush: static workqueue lifecycle
- amdgpu_svm_work_init/work_fini: wrappers for GC lifecycle
- amdgpu_svm_sync_work: wrapper for GC flush
- amdgpu_gem_svm_ioctl: validate args, dispatch
  SET_ATTR/GET_ATTR/RESET_ATTR with copy_to_user for GET

amdgpu_svm_fault.c (new):
- fault_check_allowed: VMA permission check for fault address
- fault_get_unregistered_attrs: create default attr range for
  faulting address not covered by explicit attributes, bounded
  by VMA and granularity alignment
- fault_map_range: fault mapping pipeline with retry, GC,
  permission check, find/insert range, timestamp dedup,
  validity check, get_pages, update_mapping.
- amdgpu_svm_handle_fault: top level entry point from VM fault path

The VM fault path treats zero as a successfully serviced or benignly
dropped fault. Return an error for faults which cannot be serviced so the
caller installs AMDGPU_VM_NORETRY_FLAGS and terminates the faulting wave.

Validate ioctl address-space bounds without overflow and enforce
per-GPU access policy during fault recovery. Missing VMAs are
errors, and a write fault must still have writable pages after
get-pages fallback. Only ALLOW_MIGRATE permits VRAM migration.

On terminal GC removal, clear pending UNMAP work under work_lock
before releasing the processing reference. An invalidation can add
work between dequeue and removal; after removal that work is covered
and must not cause the range to be queued for a second deletion.

Suggested-by: Christian König <christian.koenig@amd.com>
Suggested-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c       | 196 ++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.c | 424 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.h |  38 ++
 3 files changed, 658 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.h

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c
index 24d9f90941f06..cf9c27cb0080f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c
@@ -597,4 +597,200 @@ bool amdgpu_svm_is_enabled(struct amdgpu_vm *vm)
 	return vm->svm;
 }
 
+static int amdgpu_svm_copy_attrs(const struct drm_amdgpu_gem_svm *args,
+				 struct drm_amdgpu_svm_attribute **attrs, size_t *size)
+{
+	if (!args->nattr || args->nattr > AMDGPU_SVM_MAX_ATTRS)
+		return -EINVAL;
+	if (!args->attrs_ptr)
+		return -EINVAL;
+
+	*size = args->nattr * sizeof(**attrs);
+	*attrs = memdup_user(u64_to_user_ptr(args->attrs_ptr), *size);
+
+	return PTR_ERR_OR_ZERO(*attrs);
+}
+
+/**
+ * amdgpu_svm_garbage_collector() - Remove ranges queued for unmapping
+ * @svm: The SVM context.
+ *
+ * Drain the GC list: for each queued range, remove it from the gpusvm trees
+ * and drop the reference held while queued. Caller must hold the SVM lock.
+ *
+ * Return: 0 on success.
+ */
+int amdgpu_svm_garbage_collector(struct amdgpu_svm *svm)
+{
+	struct amdgpu_svm_range_op_ctx op_ctx;
+
+	amdgpu_svm_assert_locked(svm);
+
+	spin_lock(&svm->work_lock);
+	while (amdgpu_svm_range_dequeue_locked(svm, &svm->gc.list, &op_ctx)) {
+		spin_unlock(&svm->work_lock);
+
+		WARN_ON(!(op_ctx.pending_ops & AMDGPU_SVM_RANGE_OP_UNMAP));
+
+		drm_gpusvm_range_remove(&svm->gpusvm, &op_ctx.range->base);
+
+		spin_lock(&svm->work_lock);
+		op_ctx.range->pending_ops = AMDGPU_SVM_RANGE_OP_NONE;
+		spin_unlock(&svm->work_lock);
+
+		amdgpu_svm_range_put_if_dequeued(svm, op_ctx.range);
+		spin_lock(&svm->work_lock);
+	}
+	spin_unlock(&svm->work_lock);
+	return 0;
+}
+
+/**
+ * amdgpu_svm_clean_queue() - Drain a work list, releasing range references
+ * @svm: The SVM context.
+ * @work_list: The work list to drain.
+ *
+ * Dequeue every range on @work_list and drop the reference held while it was
+ * queued, without performing any unmapping. Used during teardown.
+ */
+void amdgpu_svm_clean_queue(struct amdgpu_svm *svm, struct list_head *work_list)
+{
+	struct amdgpu_svm_range_op_ctx op_ctx;
+
+	spin_lock(&svm->work_lock);
+	while (amdgpu_svm_range_dequeue_locked(svm, work_list, &op_ctx)) {
+		spin_unlock(&svm->work_lock);
+		amdgpu_svm_range_put_if_dequeued(svm, op_ctx.range);
+		spin_lock(&svm->work_lock);
+	}
+	spin_unlock(&svm->work_lock);
+}
+
+static void amdgpu_svm_gc_work_func(struct work_struct *w)
+{
+	struct amdgpu_svm_gc *gc = container_of(w, struct amdgpu_svm_gc, work);
+	struct amdgpu_svm *svm = container_of(gc, struct amdgpu_svm, gc);
+
+	amdgpu_svm_lock(svm);
+	amdgpu_svm_garbage_collector(svm);
+	amdgpu_svm_unlock(svm);
+}
+
+static int amdgpu_svm_gc_init(struct amdgpu_svm *svm, void (*gc_work_func)(struct work_struct *))
+{
+	svm->gc.wq =
+		alloc_workqueue(AMDGPU_SVM_GC_WQ_NAME, WQ_UNBOUND | WQ_HIGHPRI | WQ_MEM_RECLAIM, 0);
+	if (!svm->gc.wq)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&svm->gc.list);
+	INIT_WORK(&svm->gc.work, gc_work_func);
+
+	return 0;
+}
+
+static void amdgpu_svm_gc_fini(struct amdgpu_svm *svm)
+{
+	flush_work(&svm->gc.work);
+	amdgpu_svm_clean_queue(svm, &svm->gc.list);
+	destroy_workqueue(svm->gc.wq);
+	svm->gc.wq = NULL;
+}
+
+static void amdgpu_svm_gc_flush(struct amdgpu_svm *svm)
+{
+	flush_work(&svm->gc.work);
+}
+
+static int amdgpu_svm_work_init(struct amdgpu_svm *svm, void (*gc_work_func)(struct work_struct *))
+{
+	int ret;
+
+	init_rwsem(&svm->svm_lock);
+	spin_lock_init(&svm->work_lock);
+
+	ret = amdgpu_svm_gc_init(svm, gc_work_func);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static void amdgpu_svm_work_fini(struct amdgpu_svm *svm)
+{
+	amdgpu_svm_gc_fini(svm);
+}
+
+void amdgpu_svm_sync_work(struct amdgpu_svm *svm)
+{
+	amdgpu_svm_gc_flush(svm);
+}
+
+/**
+ * amdgpu_gem_svm_ioctl() - SVM GEM ioctl entry point
+ * @dev: The DRM device.
+ * @data: The ioctl argument (struct drm_amdgpu_gem_svm).
+ * @filp: The DRM file.
+ *
+ * Validate the arguments and dispatch to the SET_ATTR / GET_ATTR /
+ * RESET_ATTR operation, copying results back to user space for GET.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+int amdgpu_gem_svm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
+{
+	struct amdgpu_fpriv *fpriv = filp->driver_priv;
+	struct drm_amdgpu_gem_svm *args = data;
+	struct drm_amdgpu_svm_attribute *attrs = NULL;
+	struct amdgpu_vm *vm;
+	struct drm_gpusvm *gpusvm;
+	size_t attrs_size = 0;
+	int ret = 0;
+
+	pr_debug("ioctl op=%u va:[0x%llx-0x%llx)-0x%llx nattr=%u\n", args->operation,
+		 args->start_addr, args->start_addr + args->size, args->size, args->nattr);
+
+	vm = &fpriv->vm;
+	if (!amdgpu_svm_is_enabled(vm))
+		return -EOPNOTSUPP;
+
+	if ((args->start_addr & ~PAGE_MASK) || (args->size & ~PAGE_MASK))
+		return -EINVAL;
+
+	if (!args->start_addr || !args->size)
+		return -EINVAL;
+
+	gpusvm = &vm->svm->gpusvm;
+	if (args->start_addr < gpusvm->mm_start || args->size > gpusvm->mm_range ||
+	    args->start_addr - gpusvm->mm_start > gpusvm->mm_range - args->size)
+		return -EINVAL;
+
+	if (args->operation != AMDGPU_SVM_OP_RESET_ATTR) {
+		ret = amdgpu_svm_copy_attrs(args, &attrs, &attrs_size);
+		if (ret)
+			return ret;
+	}
+
+	switch (args->operation) {
+	case AMDGPU_SVM_OP_SET_ATTR:
+		ret = amdgpu_svm_op_set_attr(vm, args->start_addr, args->size, args->nattr, attrs);
+		break;
+	case AMDGPU_SVM_OP_GET_ATTR:
+		ret = amdgpu_svm_op_get_attr(vm, args->start_addr, args->size, args->nattr, attrs,
+					     &args->size);
+		if (!ret && copy_to_user(u64_to_user_ptr(args->attrs_ptr), attrs, attrs_size))
+			ret = -EFAULT;
+		break;
+	case AMDGPU_SVM_OP_RESET_ATTR:
+		ret = amdgpu_svm_op_reset_attr(vm, args->start_addr, args->size);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	kvfree(attrs);
+	return ret;
+}
+
 #endif /* CONFIG_DRM_AMDGPU_SVM */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.c
new file mode 100644
index 0000000000000..aabe11cf88aed
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.c
@@ -0,0 +1,424 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+
+#include "amdgpu_svm.h"
+#include "amdgpu_svm_attr.h"
+#include "amdgpu_svm_fault.h"
+#include "amdgpu_svm_range.h"
+#include "amdgpu.h"
+#include "amdgpu_vm.h"
+#include "amdgpu_gmc.h"
+#include "amdgpu_trace.h"
+
+#include <drm/drm_exec.h>
+#include <drm/drm_gpusvm.h>
+
+#include <linux/delay.h>
+#include <linux/mm.h>
+#include <linux/sched/mm.h>
+
+#if IS_ENABLED(CONFIG_DRM_AMDGPU_SVM)
+
+#define AMDGPU_SVM_RANGE_RETRY_FAULT_PENDING (2UL * NSEC_PER_MSEC)
+
+/**
+ * fault_get_unregistered_attrs() - Create a default attr range for a fault
+ * @svm: The SVM context.
+ * @fault_addr: The faulting address.
+ * @attr_start_page: Lower bound (first page) of the surrounding attribute gap.
+ * @attr_last_page: Upper bound (last page) of the surrounding attribute gap.
+ * @out_attrs: Output, a snapshot of the attributes for the new range.
+ * @out_start_page: Output, first page of the new range.
+ * @out_last_page: Output, last page of the new range.
+ *
+ * For a fault that lands in an address gap not covered by any explicit
+ * attribute range, create a default attribute range. Its bounds are the
+ * faulting page's granularity aligned window, clamped to the CPU VMA and to
+ * the surrounding attribute gap [@attr_start_page, @attr_last_page].
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+static int fault_get_unregistered_attrs(struct amdgpu_svm *svm, unsigned long fault_addr,
+					unsigned long attr_start_page, unsigned long attr_last_page,
+					struct amdgpu_svm_attrs *out_attrs,
+					unsigned long *out_start_page, unsigned long *out_last_page)
+{
+	struct amdgpu_svm_attr_tree *attr_tree = svm->attr_tree;
+	struct amdgpu_svm_attr_range *range;
+	struct amdgpu_svm_attrs attrs;
+	struct mm_struct *mm = svm->gpusvm.mm;
+	struct vm_area_struct *vma;
+	unsigned long fault_page = fault_addr >> PAGE_SHIFT;
+	unsigned long start_page, last_page;
+	unsigned long vma_start_page, vma_last_page;
+
+	amdgpu_svm_attr_set_default(svm, &attrs);
+
+	mmap_read_lock(mm);
+
+	vma = amdgpu_svm_check_vma(mm, fault_addr);
+	if (IS_ERR(vma)) {
+		mmap_read_unlock(mm);
+		pr_debug("get_unregistered_attrs: invalid VMA for fault_addr=0x%lx\n", fault_addr);
+		return PTR_ERR(vma);
+	}
+	vma_start_page = vma->vm_start >> PAGE_SHIFT;
+	vma_last_page = (vma->vm_end >> PAGE_SHIFT) - 1;
+
+	if (vma_is_initial_heap(vma) || vma_is_initial_stack(vma))
+		attrs.preferred_loc = AMDGPU_SVM_LOCATION_SYSMEM;
+
+	mmap_read_unlock(mm);
+
+	start_page = max_t(unsigned long, vma_start_page,
+			   ALIGN_DOWN(fault_page, 1UL << attrs.granularity));
+	last_page = min_t(unsigned long, vma_last_page,
+			  ALIGN(fault_page + 1, 1UL << attrs.granularity) - 1);
+
+	start_page = max(start_page, attr_start_page);
+	last_page = min(last_page, attr_last_page);
+
+	mutex_lock(&attr_tree->lock);
+	range = amdgpu_svm_attr_range_alloc(start_page, last_page, &attrs);
+	if (!range) {
+		mutex_unlock(&attr_tree->lock);
+		return -ENOMEM;
+	}
+	amdgpu_svm_attr_range_insert_locked(attr_tree, range);
+	*out_attrs = range->attrs;
+	*out_start_page = amdgpu_svm_attr_start_page(range);
+	*out_last_page = amdgpu_svm_attr_last_page(range);
+	mutex_unlock(&attr_tree->lock);
+
+	pr_debug("Created unregistered range for fault_addr=0x%lx: attr range=[0x%lx-0x%lx] size: 0x%lx attrs={preferred_loc=%d, prefetch_loc=%d, flags=0x%x, granularity=%u, access=%u}\n",
+		 fault_addr, *out_start_page, *out_last_page + 1,
+		 *out_last_page - *out_start_page + 1, out_attrs->preferred_loc,
+		 out_attrs->prefetch_loc, out_attrs->flags, out_attrs->granularity,
+		 out_attrs->access);
+
+	return 0;
+}
+
+/**
+ * fault_check_allowed() - Verify SVM access and CPU VMA permissions
+ * @svm: The SVM context.
+ * @attrs: Attributes protected by the SVM lock.
+ * @fault_addr: The faulting address.
+ * @write_fault: True if the fault was caused by a write.
+ *
+ * Check that the VMA covering @fault_addr grants the requested access
+ *
+ * Return: 0 if allowed, -EFAULT without a VMA, or -EPERM for denied access.
+ */
+static int fault_check_allowed(struct amdgpu_svm *svm, const struct amdgpu_svm_attrs *attrs,
+			       unsigned long fault_addr, bool write_fault)
+{
+	struct mm_struct *mm = svm->gpusvm.mm;
+	struct vm_area_struct *vma;
+	unsigned long requested = VM_READ;
+	int ret = 0;
+
+	if (!amdgpu_svm_attr_has_access(attrs->access))
+		return -EPERM;
+
+	if (write_fault)
+		requested |= VM_WRITE;
+
+	mmap_read_lock(mm);
+	vma = vma_lookup(mm, fault_addr);
+	if (!vma) {
+		ret = -EFAULT;
+	} else if ((vma->vm_flags & requested) != requested) {
+		pr_err_ratelimited("fault addr 0x%lx no %s permission\n", fault_addr,
+				   write_fault ? "write" : "read");
+		ret = -EPERM;
+	}
+	mmap_read_unlock(mm);
+
+	return ret;
+}
+
+/**
+ * fault_map_range() - Map the faulting range into the GPU page tables
+ * @svm: The SVM context.
+ * @fault_addr: The faulting address.
+ * @attrs: Snapshot of the attributes covering @fault_addr.
+ * @attr_start_page: First page covered by @attrs.
+ * @attr_last_page: Last page covered by @attrs.
+ * @write_fault: True if the fault was caused by a write.
+ *
+ * Run the fault mapping pipeline under the SVM lock: drain the garbage
+ * collector, check VMA permissions, find or insert the gpusvm range, skip
+ * work that a concurrent fault already handled, collect the pages and do
+ * the GPU mapping. Transient failures (HMM retry, changed CPU mappings)
+ * are retried a bounded number of times.
+ *
+ * Return: 0 on success or a benign drop, negative error code on failure.
+ */
+static int fault_map_range(struct amdgpu_svm *svm, unsigned long fault_addr,
+			   const struct amdgpu_svm_attrs *attrs, unsigned long attr_start_page,
+			   unsigned long attr_last_page, bool write_fault)
+{
+	bool devmem_possible = amdgpu_svm_devmem_possible(svm);
+	bool need_vram_migration = attrs->access == AMDGPU_SVM_ACCESS_ALLOW_MIGRATE &&
+				   devmem_possible && amdgpu_svm_attr_prefer_vram(attrs);
+	struct drm_gpusvm_ctx map_ctx = {
+		.read_only = !!(attrs->flags & AMDGPU_SVM_ATTR_BIT_GPU_RO),
+		.devmem_possible = devmem_possible,
+		.check_pages_threshold = devmem_possible ? SZ_64K : 0,
+		.devmem_only = need_vram_migration,
+		.timeslice_ms = need_vram_migration ? 5 : 0,
+	};
+	struct amdgpu_svm_range *range;
+	ktime_t timestamp = ktime_get_boottime();
+	int retry_count = 3;
+	int ret;
+
+	amdgpu_svm_assert_locked(svm);
+	WARN_ON(!svm->xnack_enabled);
+
+retry:
+	ret = amdgpu_svm_garbage_collector(svm);
+	if (ret) {
+		pr_err_ratelimited("fault garbage collector failed: ret=%d, fault_addr=0x%lx\n",
+				   ret, fault_addr);
+		return ret;
+	}
+
+	ret = fault_check_allowed(svm, attrs, fault_addr, write_fault);
+	if (ret)
+		return ret;
+
+	range = amdgpu_svm_range_find_or_insert(svm, fault_addr, attr_start_page << PAGE_SHIFT,
+						(attr_last_page + 1) << PAGE_SHIFT, &map_ctx);
+	if (IS_ERR(range)) {
+		ret = PTR_ERR(range);
+		/*
+		 * -EINVAL: fault_addr out of gpusvm range, or no chunk size
+		 *          fits within VMA/notifier/attr_range bounds.
+		 * -EFAULT: mmget_not_zero failed (mm is dying).
+		 * -ENOENT: No VMA at fault_addr.
+		 */
+		if (ret == -ENOENT)
+			ret = -EFAULT;
+
+		pr_err_ratelimited("map_fault: range_find_or_insert failed: fault=0x%lx ret=%d\n",
+				   fault_addr, ret);
+		return ret;
+	}
+
+	if (write_fault && map_ctx.read_only) {
+		pr_debug("write fault on read-only range: fault=0x%lx range=[0x%lx-0x%lx)\n",
+			 fault_addr, drm_gpusvm_range_start(&range->base),
+			 drm_gpusvm_range_end(&range->base));
+		ret = -EPERM;
+		goto err_out;
+	}
+
+	if (READ_ONCE(range->gpu_mapped) &&
+	    ktime_before(timestamp, ktime_add_ns(range->validate_timestamp,
+						 AMDGPU_SVM_RANGE_RETRY_FAULT_PENDING))) {
+		pr_debug("already restored, skip: fault=0x%lx range=[0x%lx-0x%lx)\n", fault_addr,
+			 drm_gpusvm_range_start(&range->base), drm_gpusvm_range_end(&range->base));
+		goto out;
+	}
+
+	if (amdgpu_svm_range_is_valid(range, attrs)) {
+		pr_debug("valid range, skip: fault=0x%lx range=[0x%lx-0x%lx)\n", fault_addr,
+			 drm_gpusvm_range_start(&range->base), drm_gpusvm_range_end(&range->base));
+		goto out;
+	}
+
+	AMDGPU_SVM_RANGE_TRACE(range, "PAGE FAULT");
+	/* TODO: add migration*/
+
+	AMDGPU_SVM_RANGE_TRACE(range, "GET PAGES");
+	ret = amdgpu_svm_range_get_pages(svm, &range->base, &map_ctx);
+	if (ret == -EOPNOTSUPP || ret == -EFAULT || ret == -EBUSY) {
+		/*
+		 * -EOPNOTSUPP  Mixed page types within range.
+		 * -EFAULT      mm is dying，range was unmapped，DMA mapping failed，
+		 *              devmem_only requested but system page encountered，
+		 *              no VMA, page fault error, bad pte/pmd.
+		 * -EBUSY       HMM retry loop timed out.
+		 * -ENOMEM      PFN or DMA address array allocation failed.
+		 * -EINVAL      hmm_range_fault: invalid VMA type.
+		 */
+		map_ctx.timeslice_ms <<= 1;
+		if (!map_ctx.devmem_only && --retry_count > 0) {
+			pr_debug("retry: get_pages failed %d, left=%d: fault=0x%lx range=[0x%lx-0x%lx)\n",
+				 ret, retry_count, fault_addr, drm_gpusvm_range_start(&range->base),
+				 drm_gpusvm_range_end(&range->base));
+			goto retry;
+		}
+		pr_err_ratelimited("map_fault: get_pages retry exhausted, ret=%d: fault=0x%lx range=[0x%lx-0x%lx)\n",
+				   ret, fault_addr, drm_gpusvm_range_start(&range->base),
+				   drm_gpusvm_range_end(&range->base));
+	}
+
+	if (ret == -EPERM) {
+		/* According to AMD UMD contract, treat -EPERM as a error fault */
+		pr_err_ratelimited("get_pages -EPERM: fault=0x%lx range=[0x%lx-0x%lx)\n",
+				   fault_addr, drm_gpusvm_range_start(&range->base),
+				   drm_gpusvm_range_end(&range->base));
+		return ret;
+	}
+
+	if (ret == -ENOMEM) {
+		pr_err_ratelimited("get_pages -ENOMEM: fault=0x%lx range=[0x%lx-0x%lx)\n",
+				   fault_addr, drm_gpusvm_range_start(&range->base),
+				   drm_gpusvm_range_end(&range->base));
+		return ret;
+	}
+
+	if (ret) {
+		AMDGPU_SVM_RANGE_TRACE(range, "PAGE FAULT - FAIL PAGE COLLECT");
+		goto err_out;
+	}
+
+	if (write_fault && map_ctx.read_only)
+		return -EPERM;
+
+	AMDGPU_SVM_RANGE_TRACE(range, "PAGE FAULT - GPU MAP");
+
+	ret = amdgpu_svm_range_update_mapping(svm, range, attrs, map_ctx.read_only, false, false,
+					      false);
+
+	if (ret)
+		goto err_out;
+
+out:
+	return 0;
+
+err_out:
+	if (ret == -EAGAIN && --retry_count > 0) {
+		map_ctx.timeslice_ms <<= 1;
+		AMDGPU_SVM_RANGE_TRACE(range, "PAGE FAULT - RETRY GPU MAP");
+		goto retry;
+	}
+
+	return ret;
+}
+
+/**
+ * amdgpu_svm_handle_fault() - Top-level SVM retry fault handler
+ * @adev: The amdgpu device.
+ * @pasid: PASID of the faulting context.
+ * @fault_page: Faulting page index.
+ * @write_fault: True if the fault was caused by a write.
+ *
+ * Entry point from the VM fault path. Look up the SVM context, drop the
+ * fault if the context is gone/exiting or the mm is dying, then resolve the covering
+ * attribute range (creating a default one if needed) and map it.
+ *
+ * Return: 0 on success or a dropped fault, negative error code on failure.
+ */
+int amdgpu_svm_handle_fault(struct amdgpu_device *adev, u32 pasid, u64 fault_page, bool write_fault)
+{
+	struct amdgpu_svm *svm;
+	struct amdgpu_svm_attr_range *attr_range;
+	struct amdgpu_svm_attrs attrs;
+	unsigned long attr_start_page, attr_last_page;
+	u64 fault_addr = fault_page << PAGE_SHIFT;
+	struct mm_struct *mm = NULL;
+	int ret;
+
+	if (amdgpu_in_reset(adev))
+		return 0;
+
+	svm = amdgpu_svm_lookup_by_pasid(adev, pasid);
+	if (!svm) {
+		pr_debug("no SVM context for pasid %u, drop fault 0x%llx\n", pasid,
+			 fault_page << PAGE_SHIFT);
+		return 0;
+	}
+
+	if (atomic_read(&svm->exiting)) {
+		pr_debug("SVM context is exiting for pasid %u, drop fault 0x%llx\n", pasid,
+			 fault_page << PAGE_SHIFT);
+		ret = 0;
+		goto out_put;
+	}
+
+	mm = svm->gpusvm.mm;
+	if (!mm || !mmget_not_zero(mm)) {
+		pr_debug("mm dying for pasid %u, drop fault 0x%llx\n", pasid,
+			 fault_page << PAGE_SHIFT);
+		mm = NULL;
+		ret = 0;
+		goto out_put;
+	}
+
+	if (!svm->xnack_enabled) {
+		pr_err_ratelimited("xnack not enabled for pasid %u\n", pasid);
+		ret = -EOPNOTSUPP;
+		goto out_put;
+	}
+
+	amdgpu_svm_lock(svm);
+
+	mutex_lock(&svm->attr_tree->lock);
+	attr_range = amdgpu_svm_attr_get_bounds_locked(svm->attr_tree, fault_page, &attr_start_page,
+						       &attr_last_page);
+	if (attr_range) {
+		attrs = attr_range->attrs;
+		attr_start_page = amdgpu_svm_attr_start_page(attr_range);
+		attr_last_page = amdgpu_svm_attr_last_page(attr_range);
+	}
+	mutex_unlock(&svm->attr_tree->lock);
+	if (!attr_range) {
+		ret = fault_get_unregistered_attrs(svm, fault_addr, attr_start_page, attr_last_page,
+						   &attrs, &attr_start_page, &attr_last_page);
+		if (ret) {
+			if (ret == -EFAULT)
+				goto out_no_vma;
+			goto out_unlock;
+		}
+	}
+	ret = fault_map_range(svm, fault_addr, &attrs, attr_start_page, attr_last_page,
+			      write_fault);
+
+	if (ret == -EAGAIN) {
+		pr_debug("retry fault=0x%llx\n", fault_addr);
+		amdgpu_gmc_filter_faults_remove(adev, fault_addr, pasid);
+		ret = 0;
+	}
+
+	goto out_unlock;
+
+out_no_vma:
+	pr_debug("no VMA for fault=0x%llx (stale retry or GPU NULL deref)\n", fault_addr);
+	ret = -EFAULT;
+
+out_unlock:
+	amdgpu_svm_unlock(svm);
+
+out_put:
+	if (mm)
+		mmput_async(mm);
+	amdgpu_svm_put(svm);
+	return ret;
+}
+
+#endif /* CONFIG_DRM_AMDGPU_SVM */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.h
new file mode 100644
index 0000000000000..0e60c7ba179f8
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0 OR MIT */
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+
+#ifndef __AMDGPU_SVM_FAULT_H__
+#define __AMDGPU_SVM_FAULT_H__
+
+#include <linux/types.h>
+
+struct amdgpu_device;
+struct amdgpu_svm;
+struct amdgpu_svm_attr_range;
+struct amdgpu_svm_attrs;
+
+int amdgpu_svm_handle_fault(struct amdgpu_device *adev, u32 pasid, u64 fault_page,
+			    bool write_fault);
+
+#endif /* __AMDGPU_SVM_FAULT_H__ */
-- 
2.53.0

