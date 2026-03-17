Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99028FD8745
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 11:30:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1F5810E617;
	Tue, 17 Mar 2026 11:30:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="deDvjGy0";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010013.outbound.protection.outlook.com
 [52.101.193.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1126C10E61F;
 Tue, 17 Mar 2026 11:30:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kG8Iaah9GWFat57i7yMBSGqX+urIGKFRVmHhU4SuIegxgkD8zlLVJ8FIPdmSelG6Y0syHp6ZuxvHn1iRkSe9fFEzZpCyB4Jq3wtHl8IehRfXe3qT63E9hh7Pb3kGgpA5b8+WPmJB8mhFCOrPTwtx5xJ/2mfzuSGoGwc1WGp18MqfcjuPrqIjvF6IjuHF/ht7QsGm4LL2TxGhWpELE3ufNG2heGywDwCCzKi4Sb0t3oLLBcNyaUCv2U/1gJcJ0gJvDT10cVhLr/e2XnC/BylLz5PGZofyjdRFuWWEcwG9NqKQg51iI6zM5jMLHUVBsnEm8QUfz++LXdsaHiVtTiS8HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OUEHYVvBXPXogwdd1Ye5j7CUhGFwxfxM2hF1f8uanic=;
 b=mLt0NhCFYExxBRI1OvBgl+JXPXyXg/7EaI3TQFTfA0Lw8WXh6a1KKVsAFOgUZTajaSoAtlSACuGLpcZRz33pJam4F0tmCmeBTArph2k10MhJGTPKNjuNrfNxMy/Ik58g1G9L57LAaF7taDETIhiufUU22e70NlVA+kXevNJr4v4Hru6/Pu+UKEQsmp+WrPItmzNm4HA3AwnErsOau8Yc98i//igom67WK4HOdNEGI+Sf+WChHX3LeN5GuqPBr++S4mYBKGaj52q3HPEz0paKZ8mJ3HB2VEruzpP4UwZflnKQZxRN4NeeZ7PYW9tmrsWfI6cOhtjP7e1GGWxR0s2KLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OUEHYVvBXPXogwdd1Ye5j7CUhGFwxfxM2hF1f8uanic=;
 b=deDvjGy0JKTxU3DLZ5ALV1dDiQh/y8Qcz9Y3hF03MYwae5QLg9D03j2/cZKqrlC8jloAhMbG0ZJtGOCLYCf2hJH2++vHhR507UmmlqNLio+H1X3WDrxXnSm/mNrIF2TzuRaP+uKdc0ufulVyFaTOswK5I+NnBJyKiF6fqeyiCBA=
Received: from MW4PR04CA0224.namprd04.prod.outlook.com (2603:10b6:303:87::19)
 by DM4PR12MB6112.namprd12.prod.outlook.com (2603:10b6:8:aa::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.16; Tue, 17 Mar 2026 11:30:45 +0000
Received: from SJ5PEPF00000203.namprd05.prod.outlook.com
 (2603:10b6:303:87:cafe::ca) by MW4PR04CA0224.outlook.office365.com
 (2603:10b6:303:87::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.25 via Frontend Transport; Tue,
 17 Mar 2026 11:30:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000203.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 11:30:44 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Mar
 2026 06:30:41 -0500
From: Honglei Huang <honglei1.huang@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <honghuan@amd.com>
Subject: [RFC/POC PATCH 09/12] drm/amdgpu: implement SVM range workers
Date: Tue, 17 Mar 2026 19:29:55 +0800
Message-ID: <20260317112958.2925370-10-honglei1.huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260317112958.2925370-1-honglei1.huang@amd.com>
References: <20260317112958.2925370-1-honglei1.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000203:EE_|DM4PR12MB6112:EE_
X-MS-Office365-Filtering-Correlation-Id: 77f7bf62-fd5d-40c2-a9bb-08de8418a10b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 3qqf9c/RkY+jsXRPUy+Zl+4lw8VgFKW+5OpsjzUxUc7KIYuutck2gkkJAWYHV7m+GgJSmKeHZhuBt9K4Bav10yMGJ6C6UUW7SblYUCOHGYHnNy0ixMHPIHqRWc6qePQUOaWLZArj/CrZaEmuTndMiS6+xHD/TSTpBdCTagBHZbAULqaOJZ1AzV9NQlg5Km0f8uAIGrn5fxH3lD2kf59EsR7Nwri+tFUd3PuDdNU+KzJTQsTSwKM9ob69ee8x6kVwrLA79+xxiW+l/Ajm/BkKxkxrQkPwtG3V94KVnhVg2h2Z/sFHJl6cckmZWZuVgYRQleEbnx0GrttwgWBLzL7afjeJz8otoh6gP2KufT2Ag7zuJgleOcUvQoPnxiBrV+9vcxlayCaa/oNfAXtbspopkqqV8NjobQ3Zo4YlNHHBnhlOIsvCaHueVaxb5DQ28JxoAUtVOm06C44guMzajMzYlifdtQKT8z/4JFvEi7Cwmas+zN1BXQ9hXtFVyTLNT3SEuZpTb+xGnPC77gqlDbvwAljEwH2YzcFRosEhtAeAticw5nEwLbzXY1i1eOp0sNXgWwsXu95gRQF1mOy8zyNaM4Uc68XvUBiQN/NGPyi0MQgy+vZl8XHsuBnqchrH4aRRwSLjFOjcM8eFcT59vAavEy34Tlet/CN9Z3L7iuvAn+Bld0fGGWiGOpR+K9juYZVhrve/3TokdcYaKzAgcKi6JyZmFjkNaIMdE5JiHlLwViqCihGHh/RVT/lwqqx/OfC2WYhvvf9apV4xRbgwvJeLpXvWNJq1Y2bc+CRm6jamthoh7ITKlR+WWUxtf3OaAkiV
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(921020)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4+Xfi1hIBeDDPiJEUHbPjrbyHCQ02s+38vAcVIQGkViFVIJArfthTQfeoU+5378eiIegeET08nON8xuliKhTEBPLR9cQevwz0SVbW+l57XGZFwtMvrhUFOrW/nwc19wsb4Bkr+jUrcwqMokcmaLO2MSf7x67ShzCg8kSdGO78oGO4tOzTKzP8sc4OkpmbZhO6C5+BLkWfiwov9nAecfXPmZDTz9naRDyZ1sRYndqb0BiVkvq9P4+ytSmio3ba2RLDtQ9Cq+12GAVc6tDeI1/68WLNMLk6svKl0RGlg4XjXSgWWOKdFBV7EunptTrPgxvN0QdIytSSpLVDVzlNakxWl8vehfo7VKbMg+t0KfGZUB0gbqONwTwsevZmVLs6AzojXIz18SmsoP6cXKbMYye0X1qbCgtNq2rIGpScjPMAo3EyF/kS1mi2EczOk1nr9rD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 11:30:44.7825 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77f7bf62-fd5d-40c2-a9bb-08de8418a10b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000203.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6112
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

From: Honglei Huang <honghuan@amd.com>

- KFD queue quiesce/resume: reuse kfd api
- GC worker: processes unmap events by clearing attributes and
  rebuilding GPU mappings, queue into restore queue if rebuild failed.
- Restore worker: restore evicted ranges via attr tree lookup
- Flush/sync helpers for orderly shutdown

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c | 404 ++++++++++++++++++
 1 file changed, 404 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
index eba0a52be..472a641fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
@@ -114,6 +114,7 @@ range_pages_valid(struct amdgpu_svm *svm,
 	return drm_gpusvm_range_pages_valid(&svm->gpusvm, range);
 }
 
+
 static int
 amdgpu_svm_range_gpu_unmap_in_notifier(struct amdgpu_svm *svm,
 				      struct drm_gpusvm_range *range,
@@ -246,6 +247,59 @@ amdgpu_svm_range_attr_pte_flags(struct amdgpu_svm *svm,
 	return pte_flags;
 }
 
+	/*
+	* POC/WA: reuse kfd apis for queue quiesce/resume
+	* But kfd apis are for process level, not for GPU VM level
+	* need consider potential issues
+	*/
+void amdgpu_svm_range_restore_begin_compute(struct amdgpu_svm *svm)
+{
+	int ret;
+
+	if (!svm->gpusvm.mm)
+		return;
+
+	if (atomic_cmpxchg(&svm->kfd_queues_quiesced, 0, 1) != 0)
+		return;
+
+	ret = kgd2kfd_quiesce_mm(svm->gpusvm.mm, KFD_QUEUE_EVICTION_TRIGGER_SVM);
+	if (ret == -ESRCH) {
+		AMDGPU_SVM_TRACE("kfd quiesce skipped no KFD process\n");
+		atomic_set(&svm->kfd_queues_quiesced, 0);
+		return;
+	}
+
+	if (ret) {
+		AMDGPU_SVM_TRACE("kfd quiesce failed ret=%d\n", ret);
+		atomic_set(&svm->kfd_queues_quiesced, 0);
+		return;
+	}
+
+	AMDGPU_SVM_TRACE("kfd quiesce ret=%d\n", ret);
+}
+
+void amdgpu_svm_range_restore_end_compute(struct amdgpu_svm *svm)
+{
+	int ret;
+
+	if (atomic_cmpxchg(&svm->kfd_queues_quiesced, 1, 0) != 1)
+		return;
+
+	if (!svm->gpusvm.mm)
+		return;
+
+	ret = kgd2kfd_resume_mm(svm->gpusvm.mm);
+	if (ret == -ESRCH) {
+		AMDGPU_SVM_TRACE("kfd resume skipped no KFD process\n");
+		return;
+	}
+
+	if (ret)
+		AMDGPU_SVM_TRACE("kfd resume failed ret=%d\n", ret);
+	else
+		AMDGPU_SVM_TRACE("kfd resume ret=%d\n", ret);
+}
+
 static int amdgpu_svm_range_lock_vm_pd(struct amdgpu_svm *svm, struct drm_exec *exec)
 {
 	int ret;
@@ -746,6 +800,169 @@ int amdgpu_svm_range_apply_attr_change(struct amdgpu_svm *svm,
 	return amdgpu_svm_range_map_interval(svm, start, last, new_attrs);
 }
 
+static bool
+range_dequeue_locked(struct amdgpu_svm *svm,
+					struct list_head *work_list,
+					bool restore_queue,
+					struct range_pending_op_ctx *op_ctx)
+{
+	struct amdgpu_svm_range *range;
+
+	lockdep_assert_held(&svm->gc_lock);
+
+	range = list_first_entry_or_null(work_list, struct amdgpu_svm_range,
+					 gc_node);
+	if (!range)
+		return false;
+
+	list_del_init(&range->gc_node);
+	if (restore_queue)
+		range->restore_queued = false;
+	else
+		range->gc_queued = false;
+
+	op_ctx->range = range;
+	op_ctx->start = range->pending_start;
+	op_ctx->last = range->pending_last;
+	op_ctx->pending_ops = range->pending_ops;
+
+	range->pending_start = ULONG_MAX;
+	range->pending_last = 0;
+	range->pending_ops = AMDGPU_SVM_RANGE_PENDING_OP_NONE;
+
+	return true;
+}
+
+static void
+range_requeue_restore_locked(struct amdgpu_svm *svm,
+					struct amdgpu_svm_range *range,
+					unsigned long start,
+					unsigned long last)
+{
+	lockdep_assert_held(&svm->gc_lock);
+
+	range->pending_start = min(range->pending_start, start);
+	range->pending_last = max(range->pending_last, last);
+	range->pending_ops |= AMDGPU_SVM_RANGE_PENDING_OP_RESTORE;
+
+	if (!range->gc_queued && !range->restore_queued) {
+		list_add_tail(&range->gc_node, &svm->restore_work_list);
+		range->restore_queued = true;
+	}
+}
+
+static bool
+range_try_dequeue(struct amdgpu_svm_range *range)
+{
+	if (!range->in_queue)
+		return false;
+
+	if (range->gc_queued || range->restore_queued ||
+	    range->pending_start <= range->pending_last ||
+	    range->pending_ops != AMDGPU_SVM_RANGE_PENDING_OP_NONE)
+		return false;
+
+	range->in_queue = false;
+	return true;
+}
+
+static void
+range_put_if_dequeued(struct amdgpu_svm *svm,
+				     struct amdgpu_svm_range *range)
+{
+	bool dequeue;
+
+	spin_lock(&svm->gc_lock);
+	dequeue = range_try_dequeue(range);
+	spin_unlock(&svm->gc_lock);
+
+	if (dequeue)
+		drm_gpusvm_range_put(&range->base);
+}
+
+static void
+amdgpu_svm_range_enqueue(struct amdgpu_svm *svm,
+			 struct amdgpu_svm_range *range,
+			 unsigned long start,
+			 unsigned long last,
+			 enum amdgpu_svm_range_queue_op op)
+{
+	bool queue_gc_work = false;
+	bool queue_restore_work = false;
+
+	if (atomic_read(&svm->exiting))
+		return;
+
+	spin_lock(&svm->gc_lock);
+	if (!range->in_queue) {
+		drm_gpusvm_range_get(&range->base);
+		range->in_queue = true;
+	}
+
+	range->pending_start = min(range->pending_start, start);
+	range->pending_last = max(range->pending_last, last);
+
+	switch (op) {
+	case AMDGPU_SVM_RANGE_OP_UNMAP:
+		range->pending_ops |= AMDGPU_SVM_RANGE_PENDING_OP_UNMAP;
+		if (NEED_REBUILD(svm))
+			range->pending_ops |= AMDGPU_SVM_RANGE_PENDING_OP_RESTORE;
+		break;
+	case AMDGPU_SVM_RANGE_OP_RESTORE:
+		range->pending_ops |= AMDGPU_SVM_RANGE_PENDING_OP_RESTORE;
+		break;
+	}
+
+	if (UNMAP_WORK(range->pending_ops)) {
+		if (range->restore_queued) {
+			list_move_tail(&range->gc_node, &svm->gc_list);
+			range->restore_queued = false;
+			range->gc_queued = true;
+		} else if (!range->gc_queued) {
+			list_add_tail(&range->gc_node, &svm->gc_list);
+			range->gc_queued = true;
+		}
+		queue_gc_work = true;
+	} else if (RESTORE_WORK(range->pending_ops)) {
+		if (!range->gc_queued && !range->restore_queued) {
+			list_add_tail(&range->gc_node, &svm->restore_work_list);
+			range->restore_queued = true;
+		}
+		queue_restore_work = true;
+	}
+
+	spin_unlock(&svm->gc_lock);
+
+	if (queue_gc_work)
+		queue_work(svm->gc_wq, &svm->gc_work);
+	if (queue_restore_work)
+		queue_delayed_work(svm->restore_wq, &svm->restore_work,
+				   msecs_to_jiffies(AMDGPU_SVM_RANGE_RESTORE_DELAY_MS));
+}
+
+static int
+amdgpu_svm_range_process_unmap_interval(struct amdgpu_svm *svm,
+					  unsigned long start, unsigned long last,
+					  bool rebuild)
+{
+	int ret = 0;
+
+	down_write(&svm->svm_lock);
+	/* clean attrs */
+	amdgpu_svm_attr_clear_pages(svm->attr_tree, start, last);
+
+	/* rebuild if needed */
+	if (amdgpu_svm_range_interval_has_range(svm, start, last))
+		ret = amdgpu_svm_range_rebuild_locked(svm, start, last, rebuild);
+
+	up_write(&svm->svm_lock);
+
+	AMDGPU_SVM_TRACE("work=UNMAP ret=%d start=0x%lx last=0x%lx rebuild=%d\n",
+		ret, start, last, rebuild ? 1 : 0);
+
+	return ret;
+}
+
 static void amdgpu_svm_range_begin_restore(struct amdgpu_svm *svm)
 {
 	if (atomic_inc_return(&svm->evicted_ranges) != 1)
@@ -754,6 +971,121 @@ static void amdgpu_svm_range_begin_restore(struct amdgpu_svm *svm)
 	svm->begin_restore(svm);
 }
 
+static void amdgpu_svm_range_restore_worker(struct work_struct *w)
+{
+	struct delayed_work *dwork = to_delayed_work(w);
+	struct amdgpu_svm *svm = container_of(dwork, struct amdgpu_svm, restore_work);
+	unsigned long resched_delay =
+		max_t(unsigned long, 1,
+		      msecs_to_jiffies(AMDGPU_SVM_RANGE_RESTORE_DELAY_MS));
+	struct range_pending_op_ctx op_ctx;
+	int evicted_record;
+	bool need_resched = false;
+	bool has_pending;
+	int ret;
+
+	if (atomic_read(&svm->exiting))
+		return;
+
+	evicted_record = atomic_read(&svm->evicted_ranges);
+	if (!evicted_record)
+		return;
+
+	if (!svm->gpusvm.mm) {
+		atomic_set(&svm->evicted_ranges, 0);
+		svm->end_restore(svm);
+		return;
+	}
+
+	spin_lock(&svm->gc_lock);
+	while (range_dequeue_locked(svm, &svm->restore_work_list,
+				    true, &op_ctx)) {
+		spin_unlock(&svm->gc_lock);
+
+		down_write(&svm->svm_lock);
+		ret = amdgpu_svm_range_map_attr_ranges(svm, op_ctx.start,
+						       op_ctx.last);
+		up_write(&svm->svm_lock);
+
+		if (ret) {
+			AMDGPU_SVM_TRACE("restore work retry ret=%d start=0x%lx last=0x%lx ret=%d\n",
+					 ret, op_ctx.start, op_ctx.last, ret);
+			spin_lock(&svm->gc_lock);
+			range_requeue_restore_locked(svm, op_ctx.range,
+								op_ctx.start, op_ctx.last);
+			spin_unlock(&svm->gc_lock);
+			need_resched = true;
+		}
+
+		range_put_if_dequeued(svm, op_ctx.range);
+		spin_lock(&svm->gc_lock);
+	}
+	spin_unlock(&svm->gc_lock);
+
+	spin_lock(&svm->gc_lock);
+	has_pending = !list_empty(&svm->restore_work_list) ||
+		      !list_empty(&svm->gc_list);
+	spin_unlock(&svm->gc_lock);
+
+	if (!need_resched && !has_pending) {
+
+		drm_gpusvm_notifier_lock(&svm->gpusvm);
+		spin_lock(&svm->gc_lock);
+
+		has_pending = !list_empty(&svm->restore_work_list) || !list_empty(&svm->gc_list);
+
+		spin_unlock(&svm->gc_lock);
+
+		if (!has_pending &&
+			atomic_cmpxchg(&svm->evicted_ranges, evicted_record, 0) == evicted_record) {
+
+			drm_gpusvm_notifier_unlock(&svm->gpusvm);
+			svm->end_restore(svm);
+			return;
+	
+		}
+		drm_gpusvm_notifier_unlock(&svm->gpusvm);
+	}
+
+	queue_delayed_work(svm->restore_wq, &svm->restore_work, resched_delay);
+}
+
+static void amdgpu_svm_range_gc_worker(struct work_struct *w)
+{
+	struct amdgpu_svm *svm = container_of(w, struct amdgpu_svm, gc_work);
+	struct range_pending_op_ctx op_ctx;
+
+	spin_lock(&svm->gc_lock);
+	while (range_dequeue_locked(svm, &svm->gc_list,
+				    false, &op_ctx)) {
+		int ret = 0;
+
+		spin_unlock(&svm->gc_lock);
+
+		if (UNMAP_WORK(op_ctx.pending_ops))
+			ret = amdgpu_svm_range_process_unmap_interval(svm,
+					op_ctx.start, op_ctx.last,
+					NEED_REBUILD(svm));
+
+		if (RESTORE_WORK(op_ctx.pending_ops)) {
+			/* queue into restore wq, if rebuild failed */
+			if (NEED_REBUILD(svm) && !ret)
+				queue_delayed_work(svm->restore_wq,
+					&svm->restore_work,
+					msecs_to_jiffies(AMDGPU_SVM_RANGE_RESTORE_DELAY_MS));
+			else
+				amdgpu_svm_range_enqueue(svm, op_ctx.range,
+							 op_ctx.start,
+							 op_ctx.last,
+							 AMDGPU_SVM_RANGE_OP_RESTORE);
+		}
+
+		range_put_if_dequeued(svm, op_ctx.range);
+		spin_lock(&svm->gc_lock);
+	}
+	spin_unlock(&svm->gc_lock);
+}
+
 void amdgpu_svm_range_invalidate(struct amdgpu_svm *svm,
 				 struct drm_gpusvm_notifier *notifier,
 				 const struct mmu_notifier_range *mmu_range)
@@ -790,3 +1122,75 @@ void amdgpu_svm_range_invalidate(struct amdgpu_svm *svm,
 	amdgpu_svm_range_process_notifier_ranges(svm, notifier, mmu_range,
 						 op, queue_op);
 }
+
+int amdgpu_svm_range_work_init(struct amdgpu_svm *svm)
+{
+	svm->gc_wq = alloc_workqueue(AMDGPU_SVM_RANGE_WQ_NAME,
+					WQ_UNBOUND | WQ_HIGHPRI | WQ_MEM_RECLAIM, 0);
+	if (!svm->gc_wq)
+		return -ENOMEM;
+
+	svm->restore_wq = alloc_ordered_workqueue(AMDGPU_SVM_RESTORE_WQ_NAME,
+						  WQ_HIGHPRI | WQ_MEM_RECLAIM);
+	if (!svm->restore_wq) {
+		destroy_workqueue(svm->gc_wq);
+		svm->gc_wq = NULL;
+		return -ENOMEM;
+	}
+
+	init_rwsem(&svm->svm_lock);
+	spin_lock_init(&svm->gc_lock);
+	INIT_LIST_HEAD(&svm->gc_list);
+	INIT_LIST_HEAD(&svm->restore_work_list);
+	INIT_WORK(&svm->gc_work, amdgpu_svm_range_gc_worker);
+	INIT_DELAYED_WORK(&svm->restore_work, amdgpu_svm_range_restore_worker);
+
+	return 0;
+}
+
+void amdgpu_svm_range_flush(struct amdgpu_svm *svm)
+{
+	flush_work(&svm->gc_work);
+	flush_delayed_work(&svm->restore_work);
+	flush_work(&svm->gc_work);
+}
+
+void amdgpu_svm_range_sync_work(struct amdgpu_svm *svm)
+{
+	amdgpu_svm_range_flush(svm);
+	flush_workqueue(svm->gc_wq);
+	flush_workqueue(svm->restore_wq);
+}
+
+static void
+amdgpu_svm_range_clean_queue(struct amdgpu_svm *svm,
+			     struct list_head *work_list,
+			     bool restore_queue)
+{
+	struct range_pending_op_ctx op_ctx;
+
+	spin_lock(&svm->gc_lock);
+	while (range_dequeue_locked(svm, work_list,
+				    restore_queue, &op_ctx)) {
+		spin_unlock(&svm->gc_lock);
+		range_put_if_dequeued(svm, op_ctx.range);
+		spin_lock(&svm->gc_lock);
+	}
+	spin_unlock(&svm->gc_lock);
+}
+
+void amdgpu_svm_range_work_fini(struct amdgpu_svm *svm)
+{
+	cancel_delayed_work_sync(&svm->restore_work);
+	flush_work(&svm->gc_work);
+	amdgpu_svm_range_clean_queue(svm, &svm->gc_list, false);
+	amdgpu_svm_range_clean_queue(svm, &svm->restore_work_list, true);
+	atomic_set(&svm->evicted_ranges, 0);
+	if (atomic_read(&svm->kfd_queues_quiesced))
+		svm->end_restore(svm);
+
+	destroy_workqueue(svm->restore_wq);
+	svm->restore_wq = NULL;
+	destroy_workqueue(svm->gc_wq);
+	svm->gc_wq = NULL;
+}
-- 
2.34.1

