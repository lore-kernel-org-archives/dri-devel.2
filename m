Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2410F588C4
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 13:14:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 164A110E0C9;
	Mon, 20 Apr 2026 13:14:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="M1qGcb4C";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013050.outbound.protection.outlook.com
 [40.93.196.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A51D10E5C9;
 Mon, 20 Apr 2026 13:14:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uH8XWkX1+o4EwZSsn/yFcSmuxG1uLSsr+WIN8s3MrXvfAVkBMfHLWqapD+/LNUIK4FTT49PZ3kZBiabEkjRuEAypGvrZTPTRGpJ0Ous9VdZE08tQH9FvwYqPw0+AXG20c0rOyA3hD07gdo+JVBZpkaWmmkhvFQe8FFlVgMmmNuMZQud3qTIWpKw4szM088dp/Mfl3EaXKpa61erc4E1cPMnLqyD3hZX8QqG0E2+Ou6UqasgHGThOtWHtIUHK4MTJBfAxMAoewBMF5LCU48Bh43kVEAFUp1Os8VnFnIT7jXryIpH4V2YXu9XG23XDFnQiDNp2d6mKC4jRzZCGmWGN6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=acY8Ds9RdXXitZy8uaMyN6dZ5NDe3DAjgRKH18nUpJU=;
 b=cu4Hc4VtqEwd37EJ1lboOe565o4wD749wAASzlYzhKzoFoylq4g8EtedNmlIB6akAAq9OW/Y2r6nTbGj4O0kbTPnEYD1vhb+DgKvdlAh/C1czIgD9lYoEy2xYPWScw1j/uEgje96955AE2IkG4i/1dXEaR0TMzvrqlwtwU7PAs60Aalp5EKjev22uLPARLDQvEaPIf9YeTZP8g3KewW0Rlugnu86AKSRA2RY/O18Yoou7UHe5rukdpL/zLzLKourOVNGxtywr3o6TXFfaXDmE6d5xCtA0UcfQrKPoGVrGpqKpMsmfEWdNfitPCSVY5/l7iKLjoriNjS39wsBO+Sw4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=acY8Ds9RdXXitZy8uaMyN6dZ5NDe3DAjgRKH18nUpJU=;
 b=M1qGcb4CYK/6FzrZuRAqtZS1ZWTMCFzxaXdEQ7J66mB8GqFQ+zB9Zfjcht9l1/7mr/QkRXpC9JjCIDKjq6jzaGzQFR+cO7HEwOIMokUXwIdWgx58NybwFpeS7fie27GP/wENWtpx1WUK3dci1E7mvJPdcJ1dxFq03KMq0bx6In0=
Received: from CH0PR04CA0032.namprd04.prod.outlook.com (2603:10b6:610:77::7)
 by SA1PR12MB9247.namprd12.prod.outlook.com (2603:10b6:806:3af::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.15; Mon, 20 Apr
 2026 13:14:15 +0000
Received: from CH1PEPF0000AD74.namprd04.prod.outlook.com
 (2603:10b6:610:77:cafe::a7) by CH0PR04CA0032.outlook.office365.com
 (2603:10b6:610:77::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Mon,
 20 Apr 2026 13:14:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD74.mail.protection.outlook.com (10.167.244.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.48 via Frontend Transport; Mon, 20 Apr 2026 13:14:15 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 20 Apr
 2026 08:14:10 -0500
From: Honglei Huang <honglei1.huang@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>, <matthew.brost@intel.com>,
 <rodrigo.vivi@intel.com>, <thomas.hellstrom@linux.intel.com>,
 <dakr@kernel.org>, <aliceryhl@google.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <honghuan@amd.com>, Honghuan He <honghuan.he@amd.com>
Subject: [RFC V3 09/12] drm/amdgpu: implement SVM attribute change and
 invalidation callback
Date: Mon, 20 Apr 2026 21:13:04 +0800
Message-ID: <20260420131307.1816671-10-honglei1.huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260420131307.1816671-1-honglei1.huang@amd.com>
References: <20260420131307.1816671-1-honglei1.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD74:EE_|SA1PR12MB9247:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e4b4633-757f-4b95-0b48-08de9edeb8a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: 3e9asEkpNFi+E9X46qwGKydTdEnwaXTE1O/eGQ8qFtpZr1QNqjCYyWtr/3GgmW7DBVOX3rlqzk/oLvE+xHlgkXltMNQlkBsW25v24QxuQCBxYNkKW/DZN7WaJAds+JsnR6iVNmoFSD4EIBjC9QypoLtpS1jxcKEZyUt81ND29QAZ7qTw63lRXIPL3IJoIWqPM5Ghxb3R8uyGQMJ4IvAL8mP+ZNwOcvjwKj/4MOQnMbUnbxDfQ6Ht3rXAnVvDDsKdz1A3vmNbnaUA5EmTSENlryjvcVpXtBfJ0EnD8wZBQw9Yb6WVMZIPmt5YVGIq9cGNsZeUoGoebWlFD0a9QOC6Yv5tIUcAhzqlY9cFoFsYi+3bz/6lHrb0Bxnpxl7KluACQAkEFq+jT0KGGXYO8Vq1Yu78vXosYB+SXVea/frnnw6mST6m5S6ZdCK+TjGapjgkERnb5Fhi/XfFyOo2dgT9c9VpriI9E78w4BLnekIfEPf6n48U5Vwq7LRr8l4hnThkZg0dPtsAN0o9oOnT+HIdjgxTiNFlYrlSu1p4+gVu+YrIqWCj0AcA5UM+hrU5KVwSd/ddUagO4JA+Vad0ajfSHq0bJBsZjRZHdRNbVXdWFGzAikwONpvMPRy+AzHWofRAtNqa52cgezbL1CEV1T/glgOkJeIVNNptZkb7AnX1XKgxrco37ZYFgOCYxgYTBPkzLrO39n3UzdxqVnwfQtzErMRUlWt7K4z9Vs6C5R24HMG4YARGT9KazOOUagg3K97JcSInOJ5GvfRbGix63519WRsXRswCkAMOxmOnZ2djiu1q1uvnAU8+lfxINoknC97s
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(921020)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: f5Bym64iCwCTfkdPCEbCkB/0RLKI+bdvhDgtFb/0WqGR1+WMU1WYQ0nw9X2HwNYm8NAgDVZCyvcLMaZE2oHdT1wMGq7mNbi1gF5YT7h/2yGSgbs1MZMT/yH7cKfraVMebtF8uuA2p0KUoi+n6IoRqAqrFufX/dvOY7o8vvlgwete/kzna4P2sSZdVQHWv9q4Zl+Cj++El8VPH3SHgA4/s2DiJO/oOuacMZiFiBAvdgW0nYDueklfZcGpXZmI0eoJaEZAa7h/pTnJhJTY6YL18EXr4eLJ9eS9ff30WvFVrjl2kPHspWXNl7hzCN36Py1S7sYp2g0TnQ3awBPgHengoHBIfIRMfQw7BCnsd+STDWE4lz1bqqX6m4uihr4YmDaE9YQ5fnAI9b34UCw49odBzwh/GYmtPRKdxwk+4T2yDETBR2HrJNrzLOirroOckDKl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 13:14:15.0625 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e4b4633-757f-4b95-0b48-08de9edeb8a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD74.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9247
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

Implement attribute change handling, work queue helpers, and the
top-level MMU invalidation callback in amdgpu_svm_range.c.

Attribute change handling:
- amdgpu_svm_range_apply_attr_change(): apply attribute triggers
  to existing GPU ranges. For ACCESS_CHANGE: remap accessible
  ranges or zap PTEs for disabled access. For PTE_FLAG_CHANGE:
  update mappings with new flags. For LOCATION/MAPPING_FLAG
  changes and PREFETCH: remap the full interval. For ATTR_ONLY
  or RANGE_SPLIT with xnack-off: trigger full rebuild. Walk
  gpusvm ranges within attribute range bounds.

Work queue helpers:
- amdgpu_svm_range_dequeue_locked(): dequeue ranges with pending
  operations from the work list for batch processing
- range_try_dequeue(): CAS-based attempt to move a range from
  queued to dequeued state
- amdgpu_svm_range_put_if_dequeued(): release a dequeued range
  back to idle state

Timestamp:
- amdgpu_svm_capture_checkpoint_ts(): capture current ktime for
  fault deduplication

Main invalidation callback:
- amdgpu_svm_range_invalidate(): the drm_gpusvm_ops.invalidate
  callback invoked by MMU notifiers. Iterates all overlapping
  notifier intervals and delegates to
  amdgpu_svm_range_invalidate_interval().

Signed-off-by: Honghuan He <honghuan.he@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c | 195 ++++++++++++++++++
 1 file changed, 195 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
index 2e53b786c..e039784c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
@@ -666,3 +666,198 @@ amdgpu_svm_range_invalidate_interval(struct amdgpu_svm *svm,
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
+			    (new_attrs->flags & AMDGPU_SVM_FLAG_GPU_ALWAYS_MAPPED))
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

