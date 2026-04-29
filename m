Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 349F8FF8867
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 04:11:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86B4710EE40;
	Wed, 29 Apr 2026 04:10:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4LdC9trg";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010030.outbound.protection.outlook.com [52.101.85.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD94310ED2D;
 Wed, 29 Apr 2026 04:10:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XqQerafW6Q9TyX5PThMjaoZQbXDDmSrsCGyqPv0XPQZqx7qhBoJDidopDqMqnF4Ie4BJUm4RYl/DRTwjy7uC+WDaSExjK6MbQot9dw7INcjvQiMImcefp6W9i/TFRLXz15p0LzCP3WZ9j10zc3raTzlzzw97oYVD6Ik1rrBNcJxpc9y1E5Vmd3kmHeevE9YmoxNdeMCMGS+oINF7sFICFMjGyfQ7XD5PavYsdcxR1Avpvp7DWExYbUIvkY2fVzXMuXrJrSBkktoAolxyuxCvFsuy9M91hDtQyqAvnXN1wVy8S+TJ1z4JuuiGh++9yJl7V9uPh2As3OhneHXwf7RgZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tiZ2RNQebvFARr826KVagGOo6bF1mU/kh4vZNkFuAAs=;
 b=yHrnUzxV9b3Rz69T8qVoz1rHYZPZXfM8TzsU8OWylp5/HAUoXuOPcnrLQQf7MCAmpSiYuIQg54JfZfwT/vb6+aOTLsVQ5NHRx6fTYLrpBuMHTc3F/pFOz/OR+HW3aRdZ+N+hUoRDq62pXa2/RmuvwRontvDnReFBlazGDnBSbk8nPRc5Q6X1EeyPQ61fXmcSfxIFJ9OLEwLZD7UrNCCF7+n8sGxV1Dj6K2wEpk4bFZUClbM41CThceVMTDhqtQkUt9GbhEXSQ7fzc15OyjsYDgvDBVmUPXuhVVcJJGIypRZLxTkMUuxSc07TOkaITqFagfUCkfms0wQE7vkFFEUC7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tiZ2RNQebvFARr826KVagGOo6bF1mU/kh4vZNkFuAAs=;
 b=4LdC9trgfhrgwFCS69AEi8kuGNl5V4PRB6G4gmt4w4CpRhAG/HIPZxN23KVpWLaPDqK5SSJuXjV026i5IqkYs43vnw9lr1t1MDNMQZgvwn3YKQOakgL/YNywNy6kLvbMTRnMfG8vx9Ql59KDnwcxHAIWSQvMgmABeEJ1MOt+2Pc=
Received: from SA0PR11CA0064.namprd11.prod.outlook.com (2603:10b6:806:d2::9)
 by DS7PR12MB6309.namprd12.prod.outlook.com (2603:10b6:8:96::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.19; Wed, 29 Apr
 2026 04:10:41 +0000
Received: from SA2PEPF00003F64.namprd04.prod.outlook.com
 (2603:10b6:806:d2:cafe::70) by SA0PR11CA0064.outlook.office365.com
 (2603:10b6:806:d2::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.28 via Frontend Transport; Wed,
 29 Apr 2026 04:10:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F64.mail.protection.outlook.com (10.167.248.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 29 Apr 2026 04:10:41 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 28 Apr
 2026 23:10:36 -0500
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 28 Apr
 2026 21:07:26 -0700
From: Honglei Huang <honglei1.huang@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>, <sima@ffwll.ch>,
 <matthew.brost@intel.com>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>, <aliceryhl@google.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <honghuan@amd.com>
Subject: [RFC V4 09/12] drm/amdgpu: implement SVM attribute change and
 invalidation
Date: Wed, 29 Apr 2026 12:06:25 +0800
Message-ID: <20260429040628.853079-10-honglei1.huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260429040628.853079-1-honglei1.huang@amd.com>
References: <20260429040628.853079-1-honglei1.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F64:EE_|DS7PR12MB6309:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c64df2f-8d34-4935-59fc-08dea5a5473e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|921020|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: NqxiMZX4nMPzMNTagni3OwWeYnKocLBw0rAVwtBfKMePoxdcBm0OIMhqIIaP5nZiZelhXawTXmgqoBBhq40lF0hIBDnzp2Jlta04mSnqq4wGHcXvfxQyQ2Ex/Wulci0hmkyxTds4a/iop+EnfBnCIDQ2ukg7V7DiEALVU1qFID8uV1AsYdSqSN4Br0/aFYMKogxwuVDsjWrpqDCxX6359Gov3NnnMDlNP05yVIs/Ze1Th3I7UO0wF669DkZJZfiPrzTH0pv7V2MCIQ3yWB9VQoO8eoGUqepXodAE8YPuqMW0EeYfYHlBLOHcIvTwDWFvf8OEQ2GR2kRJw1A8G+wvEkCAaQvc5NtjJW+AdhNjAFQwcMNczZ5gPche4XQNw/n6LVqeC1Z4Oek8vW7z8yRC7e3/cQqutBWTxhvy7pCFUAQwL+R2CUSq7tvUHiAFpPaJ6oGVfhD5UBh9Bw+fGt7Y74awpWdJVcsQQthvCbK1QI28nCm59F1YR38mSMq9MDlJwCBsCqhpqh9YtyTscV0rqm00l1QEEYkbtupxYN+YfTuVDuwtKD4tOJpWrqV51VySLI3wzTSAP6ZyReSAzXL5NIonrrTd22L03F2LuYzlJJfYGs+iNI4NglUwu7+vxeIcx3PAlbuNnAHTmBTPGiOb+g3ox8bBFMnJ8BMO15Zzs+feFeYW6KyQyhTgEfCsjLRO39QTBj6be/gjwY+N5fugvR6OuMSFkr5UjxCXwHxRyaQDPqEuA+3gYXiaKCtfXEdoQL1HqKLu5pV7S/eF2q3nMjb3VM3FmpuVVCsCp38zliz1ZY6+zaOaBdlJjoL50nRc
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(921020)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vPIPzLhv89dj15i9L2zn1APVZKAj9mqdCttM9QNrGtPuGTCkUOBSTKcHagmqnco7UxgnUkQfXtnUdK1/zNIZ9KBu7UF5TSbUuu7UK6GT+4Zu7/G4Hm4rBjWJM/70SvIOdvlMwJ5cN4McajPkpFnJiQ44zargf7lhWtUysjPoCTxMeGF1ekDVgO1sljesvwYSv3WmDnC1tGXNJ8dmeEnmFtOrWsTgMXEMj+v4SiDBPF0ifQ+Bj+h9mpWWHIAz/Ln0sTwWNyCNS+BjACGYCuqVdycZlGyt0DSt8g6bbN9gxmvIo54+ZAYKbq8w1hDhytFa73wKXa4VM/2BjoTQbCU3cJbp7TrE9FyaBC4OVJnNvWzSvayWOyULoBd8/Ay6OPRiucGvDXVj6+qpr7B0Ld+vhVvv8IA/oQNqECDMgIYP/cxWSrc/BVEnO+9c0jRfwgSl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 04:10:41.6001 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c64df2f-8d34-4935-59fc-08dea5a5473e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6309
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

Add attribute change handler dispatching remap/zap/rebuild per trigger
type, work queue dequeue/release helpers, checkpoint timestamp capture,
and top-level drm_gpusvm_ops.invalidate callback.

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c | 195 ++++++++++++++++++
 1 file changed, 195 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
index 6c6552f31..7e8c2ad9e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
@@ -664,3 +664,198 @@ amdgpu_svm_range_invalidate_interval(struct amdgpu_svm *svm,
 	return 0;
 }
 
+int amdgpu_svm_range_apply_attr_change(struct amdgpu_svm *svm,
+				       uint32_t trigger,
+				       const struct amdgpu_svm_attrs *prev_attrs,
+				       struct amdgpu_svm_attr_range *attr_range)
+{
+	const struct amdgpu_svm_attrs *new_attrs = &attr_range->attrs;
+	unsigned long start_page = amdgpu_svm_attr_start_page(attr_range);
+	unsigned long last_page = amdgpu_svm_attr_last_page(attr_range);
+	bool old_access, new_access;
+	bool update_mapping = false;
+	int ret;
+
+	lockdep_assert_held_write(&svm->svm_lock);
+
+	old_access = range_has_access(prev_attrs->access);
+	new_access = range_has_access(new_attrs->access);
+
+	AMDGPU_SVM_TRACE("attr change trigger=0x%x old_access=%d new_access=%d [0x%lx-0x%lx]-0x%lx, xnack=%d\n",
+			 trigger, old_access, new_access, start_page, last_page, last_page - start_page + 1,
+			 svm->xnack_enabled ? 1 : 0);
+
+	if (trigger & AMDGPU_SVM_ATTR_TRIGGER_ACCESS_CHANGE) {
+		if (!new_access && old_access) {
+			/*
+			 * Do nothing align with kfd svm
+			 * TODO: unmap ranges from GPU that lost access
+			 */
+			AMDGPU_SVM_TRACE("skip unmap ioctl operation [0x%lx-0x%lx]-0x%lx\n",
+					 start_page, last_page, last_page - start_page + 1);
+		} else if (new_access) {
+			if (XNACK_OFF(svm) ||
+			    (new_attrs->flags & AMDGPU_SVM_ATTR_BIT_GPU_ALWAYS_MAPPED))
+				update_mapping = true;
+		}
+	}
+
+	if ((trigger & (AMDGPU_SVM_ATTR_TRIGGER_PTE_FLAG_CHANGE |
+			AMDGPU_SVM_ATTR_TRIGGER_MAPPING_FLAG_CHANGE)) &&
+	    new_access && XNACK_OFF(svm))
+		/* only do mapping update when xnack off */
+		update_mapping = true;
+
+	if (trigger & AMDGPU_SVM_ATTR_TRIGGER_PREFETCH) {
+		/* only do prefetch when xnack on */
+		update_mapping = true;
+	}
+
+	if (!XNACK_OFF(svm) &&
+	    (trigger & AMDGPU_SVM_ATTR_TRIGGER_RANGE_SPLIT)) {
+		AMDGPU_SVM_TRACE("attr split invalidate [0x%lx-0x%lx]-0x%lx\n",
+				 start_page, last_page,
+				 last_page - start_page + 1);
+		ret = amdgpu_svm_range_invalidate_interval(svm, start_page,
+							    last_page);
+		if (ret) {
+			AMDGPU_SVM_ERR("failed to invalidate range for attr split: [0x%lx-0x%lx], ret=%d\n",
+				start_page, last_page, ret);
+			return ret;
+		}
+	}
+
+	if (!update_mapping)
+		return 0;
+
+	return amdgpu_svm_range_map_attr_range(svm, attr_range);
+}
+
+bool
+amdgpu_svm_range_dequeue_locked(struct amdgpu_svm *svm,
+					struct list_head *work_list,
+					struct amdgpu_svm_range_op_ctx *op_ctx)
+{
+	struct amdgpu_svm_range *range;
+
+	lockdep_assert_held(&svm->work_lock);
+
+	range = list_first_entry_or_null(work_list, struct amdgpu_svm_range,
+					work_node);
+	if (!range)
+		return false;
+
+	list_del_init(&range->work_node);
+	range->gc_queued = false;
+
+	op_ctx->range = range;
+	op_ctx->start_page = range->pending_start_page;
+	op_ctx->last_page = range->pending_last_page;
+	op_ctx->pending_ops = range->pending_ops;
+
+	range->pending_start_page = ULONG_MAX;
+	range->pending_last_page = 0;
+	range->pending_ops = AMDGPU_SVM_RANGE_OP_NONE;
+
+	return true;
+}
+
+static bool
+range_try_dequeue(struct amdgpu_svm_range *range)
+{
+	if (!range->in_queue)
+		return false;
+
+	if (range->gc_queued ||
+	    range->pending_start_page <= range->pending_last_page ||
+	    range->pending_ops != AMDGPU_SVM_RANGE_OP_NONE)
+		return false;
+
+	range->in_queue = false;
+	return true;
+}
+
+void
+amdgpu_svm_range_put_if_dequeued(struct amdgpu_svm *svm,
+				     struct amdgpu_svm_range *range)
+{
+	bool dequeue;
+
+	spin_lock(&svm->work_lock);
+	dequeue = range_try_dequeue(range);
+	spin_unlock(&svm->work_lock);
+
+	if (dequeue)
+		drm_gpusvm_range_put(&range->base);
+}
+
+void amdgpu_svm_capture_checkpoint_ts(struct amdgpu_svm *svm)
+{
+	struct amdgpu_device *adev = svm->adev;
+	struct amdgpu_ih_ring *ih;
+	uint32_t checkpoint_wptr;
+
+	if (!adev->irq.retry_cam_enabled && adev->irq.ih1.ring_size) {
+		ih = &adev->irq.ih1;
+		checkpoint_wptr = amdgpu_ih_get_wptr(adev, ih);
+		if (ih->rptr != checkpoint_wptr) {
+			WRITE_ONCE(svm->checkpoint_ts,
+				   amdgpu_ih_decode_iv_ts(adev, ih,
+							  checkpoint_wptr, -1));
+			return;
+		}
+	}
+
+	ih = &adev->irq.ih_soft;
+	checkpoint_wptr = amdgpu_ih_get_wptr(adev, ih);
+	if (ih->rptr != checkpoint_wptr)
+		WRITE_ONCE(svm->checkpoint_ts,
+			   amdgpu_ih_decode_iv_ts(adev, ih,
+						  checkpoint_wptr, -1));
+}
+
+void amdgpu_svm_range_invalidate(struct amdgpu_svm *svm,
+				 struct drm_gpusvm_notifier *notifier,
+				 const struct mmu_notifier_range *mmu_range)
+{
+	struct drm_gpusvm_range *r, *first;
+	uint64_t adj_start = mmu_range->start, adj_end = mmu_range->end;
+	bool needs_flush = false;
+
+	amdgpu_svm_assert_in_notifier(svm);
+
+	AMDGPU_SVM_TRACE("INVALIDATE: pasid=%u, gpusvm=%p, seqno=%lu, [0x%016lx-0x%016lx]-0x%lx, event=%d\n",
+			 svm->vm->pasid, &svm->gpusvm,
+			 notifier->notifier.invalidate_seq,
+			 mmu_range->start, mmu_range->end,
+			 mmu_range->end - mmu_range->start, mmu_range->event);
+
+	if (mmu_range->event == MMU_NOTIFY_RELEASE)
+		return;
+	if (atomic_read(&svm->exiting))
+		return;
+
+	adj_start = max(drm_gpusvm_notifier_start(notifier), adj_start);
+	adj_end = min(drm_gpusvm_notifier_end(notifier), adj_end);
+
+	first = drm_gpusvm_range_find(notifier, adj_start, adj_end);
+	if (!first)
+		return;
+
+	if (mmu_range->event == MMU_NOTIFY_UNMAP)
+		amdgpu_svm_capture_checkpoint_ts(svm);
+
+	r = first;
+	drm_gpusvm_for_each_range(r, notifier, adj_start, adj_end)
+		needs_flush |= amdgpu_svm_range_notifier_event_begin(svm, r,
+								     mmu_range);
+	if (!needs_flush)
+		goto range_notifier_event_end;
+
+	svm->flush_tlb(svm);
+
+range_notifier_event_end:
+	r = first;
+	drm_gpusvm_for_each_range(r, notifier, adj_start, adj_end)
+		amdgpu_svm_range_notifier_event_end(svm, r, mmu_range);
+}
-- 
2.34.1

