Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71057CD5BD2
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 05:50:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B242510F90E;
	Fri, 29 May 2026 05:50:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MZV1Z4cn";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012043.outbound.protection.outlook.com [52.101.48.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6F1C10F915;
 Fri, 29 May 2026 05:50:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n0WBUhDOpCCWOMdlqYhdnnOZEctuRiEyDsC/QEVRhjpBrJwPgouP6LHWqdd+YoTrwFeN0v8JClmVXaKcYNk6W2LHRck/+cFYBF/UEVFc2pV2Uo/1MHLAMEcpPQhJnFZeVbmKIxFk+7hI9vYy/7Bos/qYrE7RGro0NWRW3FVqoxZGyUKFNqWKMNDExIraI6UbWaGml1h4lARyDXJMrcHCletUBZapnIQmm9SPH55djPzka6LwxFWQBvC73d1CO94b0PaOkTBo4fMpDPXvRh/K96Ump8+h1sCXPmHWOxO2hS38u68gARLzt3PrJA3s8FPU18OFM0EAj+qETYhSV/pW/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5AlxkhWrQf7mdBNSYQ6ztIvtAVQx/Ktz9PuPHpqQWXo=;
 b=mdzV6OhTZQarve2Fj05iyHPng3xgISaV0CKdZpHfuPWoi8sENgbOWFSFXmMUuc8bTtqS1YAs1a+FYspXW49JwLOqQ6pvfRwgqCgMeXNP9LmNLdC6+vVHcaU8ofHLa51Y7rL0TUkwTbYLwGv2C+dTwU8d/curl5f6ZgHO0O1AkacYgtqC0tRRX57kVH6ecqIfaENMtphXHkjDL00TL7Rf6Es0qmjE4ueoULhDCBbyW4kLrDMwd2eggk74U4QPW0+W5S0fYuMllIAkECzFEExxA9qbNOXvrcEqqD7hvMGUIvR1Q2OXZSnXPEw6IG6VfgwXcq50vjsVCmS+rVNTDnVxUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5AlxkhWrQf7mdBNSYQ6ztIvtAVQx/Ktz9PuPHpqQWXo=;
 b=MZV1Z4cn46jjzVWlG072mbVK2hZ50Eman6YvlthcLwfHo+ATBiJNbDjavR0u+sccjR9HCfHOVa1NkmoPnSDOpBp9tDFQGqPCxQfU+Gn4EvoJQEp7hJb85zkKVhDpRSyx4/JFvZOZTyqi2aj4CI48aFdyKZnDa8AB9TiHwgjd5ig=
Received: from CH0PR04CA0065.namprd04.prod.outlook.com (2603:10b6:610:74::10)
 by BL3PR12MB6522.namprd12.prod.outlook.com (2603:10b6:208:3be::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Fri, 29 May
 2026 05:50:10 +0000
Received: from CH2PEPF0000013C.namprd02.prod.outlook.com
 (2603:10b6:610:74:cafe::15) by CH0PR04CA0065.outlook.office365.com
 (2603:10b6:610:74::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Fri, 29
 May 2026 05:50:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000013C.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 29 May 2026 05:50:09 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 29 May
 2026 00:50:03 -0500
From: Honglei Huang <honglei1.huang@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>, <Yiru.Ma@amd.com>,
 <sima@ffwll.ch>, <matthew.brost@intel.com>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>, <aliceryhl@google.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <honghuan@amd.com>
Subject: [V2 RFC 5/8] drm/amdgpu: implement xnack-off GC work function
Date: Fri, 29 May 2026 13:49:25 +0800
Message-ID: <20260529054928.596825-6-honglei1.huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260529054928.596825-1-honglei1.huang@amd.com>
References: <20260529054928.596825-1-honglei1.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013C:EE_|BL3PR12MB6522:EE_
X-MS-Office365-Filtering-Correlation-Id: 13dc3233-8b29-4f32-fea8-08debd462502
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|921020|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: aqABRnxpARKjQn03yjGK1UPjaXoXkcdCMsbCS8UpCkS1xZmLfe1Xy/od/yHhzkKw0HkhCwJNhVX1W0XtpN9U45o1uT/BUUh7MEgwYEueOzr72Fb7iVamwHVTJislSj4VpzeSO+pPm+im7nVbxR7+ipQsoHdGn/kMUjWccKi3mDQ+Rf712jWT7KJ/iUBgoSPvi4DMcihhqvV6zWf3Sw5byjVxuuR3Kx7QHyXMQfPuroV336jeQ/fXhwU1D1+1986ASoMbLHELPZO6kD7MTJe3FbQYZOvcYfyPjUn1O9NK5QNN7IRSV2Y/hf8rvrlIUix2LT8awj2iZTUXxVD44D2QlZHvqW6AgLM5Qrreg1czGgSZhBGFE9s0J6JsX9bwDSjELvI7CyIB7alOYz6zvBfas3wyk+3HN2K8NA7G+4PE8efXLo19ey6SfzVw5vEBlPwayxYDl6ysVWzskljCzI877NhPRn5mK8CO6wUMH1BqFfbmjQwGJF046YJvNUH7wsWMaDQQL8u2USntiCQYEFGlJMpZVWkiASZ9xFmSXONdBFAkeC0rDgusOUHF148LTkTOZGY9Ev1x/pXZTZKMvugbxu1xaHN+0pU+25t1v8oX7XGAR0ljcJAO1pocMNP60vOpqPBU0nr6FL7dGcQ3IGX5UuwJV0RwY3ykxP/15Kv9iHOUKjtJjZYnN4tFPZDiuVKS9DMiJSWXWQtjYa1+B2pUxLl12dXj3HVoGz2J3+xa3fvK1ShdZLiBFO9M874ZMODIDJKup/rHDaL1qqXpGVGcyw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(921020)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: iWponXfZR6sXh2NrixeUMdoT+yCPjBXQH4bw0dsYtvlWrIfGVmTe2MXQ4IQHATjMZtP2N+4BtjcviKtzgU+D48+MzaRlJFuvUuQx4SqYLqaWm/hqxE7I/iGV7X7iTYBD/zpb+RbTjE4dwH/owER5Eivd8HzQ553Q9Har43osA9ENoBzZulkGE1Me3JBta5Nvqy7jX4XxRoWFu5Aol2JaMQHWPYq2TP4JZyMf2GfRjkHzhSs+BFv0OiYm0gxkxpcFbldkMwtyXsb+chXJ9Iq6P3UWeA5zQUKs8sgwmi1DZ7chs45YlKjgFKONrhxPCAbuymuPxeboCYyCzvmmfQZihMVj9zBjvQ106wfR3cG/mnEZq5Nw7kKx4bI/PjYrsTENfKqtKNV7GDLZUlw9BwCE/p0KC0pXiHHPwf3Y9pU8eVN8+MU1BHtq8tMKsEkUfpKr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 05:50:09.9195 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13dc3233-8b29-4f32-fea8-08debd462502
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6522
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

Implement the garbage collection work function for xnack-off SVM ranges.
When a range is fully unmapped, the GC worker removes it. When a range
is partially unmapped, it removes the stale range and synchronously
rebuilds the surviving sub-region via svm_restore_map_interval().  The
partial-unmap path evicts VRAM-backed pages back to sysmem via
amdgpu_svm_range_evict() (the devmem-aware wrapper) before remove, so
live data is preserved.

In svm_restore_map_interval(), cache vma->vm_start / vma->vm_end into
local variables before dropping mmap_read_lock so that subsequent
find_vma() and loop condition checks use the cached values rather than
dereferencing a potentially stale vma pointer.  The per-iteration cursor
advance is simplified to "if (seg_last >= last_page) break; cursor =
seg_last + 1;" -- attr_get_bounds() returns the segment containing
cursor, so seg_start <= cursor and the explicit ULONG_MAX guard is
redundant.

Permanent (non-retryable) errors from amdgpu_svm_range_map_attrs() are
classified and skipped with a trace log rather than retried: -ENOENT,
-EFAULT and -EPERM come from hmm_range_fault() and reflect VMA state
that the worker cannot fix (no VMA, non-faultable mapping, RO VMA
written), -EINVAL reflects a sanity-check failure that will not change
on retry, and -EHWPOISON reflects physical page corruption.  All other
non-zero returns (e.g. -EBUSY, -EAGAIN, -ETIME, -ENOMEM) are treated
as transient and saved for the worker to retry.

The helper is named svm_restore_enqueue_unmapped() (rather than
"requeue") to reflect that it inserts ranges into the restore queue
from both the partial-unmap fallback path here and the attr-change
realignment path added later.

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userptr.c | 193 ++++++++++++++++++++
 1 file changed, 193 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userptr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userptr.c
index a76c0401e..829e88635 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userptr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userptr.c
@@ -391,6 +391,199 @@ static void amdgpu_svm_restore_worker(struct work_struct *w)
 
 	queue_delayed_work(svm->restore.wq, &svm->restore.work, resched_delay);
 }
+
+/*
+ * The interval may straddle VMA holes regions with no VMA backing.
+ *
+ *   1. Walk mm's VMA tree with find_vma_intersection() and skip the
+ *      holes between VMAs entirely, map_attrs() would just return
+ *      -EFAULT on a hole.
+ *   2. For each VMA clipped chunk, call amdgpu_svm_range_map_attrs().
+ *      Non-retryable errors are traced and skipped for the current chunk,
+ *      then the next VMA is processed so a single bad page/VMA does not
+ *      abort rebuilding the rest of the interval.
+ */
+static int
+svm_restore_map_attr_segment(struct amdgpu_svm *svm,
+			     struct mm_struct *mm,
+			     const struct amdgpu_svm_attrs *attrs,
+			     unsigned long start,
+			     unsigned long end)
+{
+	unsigned long pos = start;
+	int saved_ret = 0;
+	struct vm_area_struct *vma;
+	unsigned long chunk_start, chunk_end;
+	int ret;
+
+	amdgpu_svm_assert_locked(svm);
+
+	while (pos < end) {
+		mmap_read_lock(mm);
+		vma = find_vma_intersection(mm, pos, end);
+		if (vma) {
+			chunk_start = max(vma->vm_start, pos);
+			chunk_end = min(vma->vm_end, end);
+		}
+		mmap_read_unlock(mm);
+
+		if (!vma)
+			break;
+
+		ret = amdgpu_svm_range_map_attrs(svm, attrs,
+						 chunk_start, chunk_end);
+		if (ret && amdgpu_svm_nonretryable(ret)) {
+			AMDGPU_SVM_TRACE("%s skip non-retryable [0x%lx-0x%lx) ret=%d\n",
+					 __func__, chunk_start, chunk_end, ret);
+		} else if (ret) {
+			AMDGPU_SVM_ERR("%s failed [0x%lx-0x%lx) ret=%d\n",
+				       __func__, chunk_start, chunk_end, ret);
+			saved_ret = ret;
+		}
+
+		pos = chunk_end;
+	}
+
+	return saved_ret;
+}
+
+static int
+svm_restore_map_interval(struct amdgpu_svm *svm,
+			 unsigned long start_page,
+			 unsigned long last_page)
+{
+	struct amdgpu_svm_attr_tree *attr_tree = svm->attr_tree;
+	struct mm_struct *mm = svm->gpusvm.mm;
+	unsigned long cursor = start_page;
+	int saved_ret = 0;
+	int ret;
+
+	amdgpu_svm_assert_locked(svm);
+
+	if (!mmget_not_zero(mm))
+		return -ESRCH;
+
+	while (cursor <= last_page) {
+		struct amdgpu_svm_attr_range *attr_range;
+		struct amdgpu_svm_attrs attrs;
+		unsigned long seg_start, seg_last;
+
+		mutex_lock(&attr_tree->lock);
+		attr_range = amdgpu_svm_attr_get_bounds_locked(attr_tree, cursor,
+							       &seg_start, &seg_last);
+		if (attr_range)
+			attrs = attr_range->attrs;
+		mutex_unlock(&attr_tree->lock);
+
+		seg_last = min(seg_last, last_page);
+		if (attr_range && amdgpu_svm_attr_has_access(attrs.access)) {
+
+			ret = svm_restore_map_attr_segment(svm, mm, &attrs,
+							   cursor << PAGE_SHIFT,
+							   (seg_last + 1) << PAGE_SHIFT);
+			if (ret)
+				saved_ret = ret;
+		}
+
+		if (seg_last >= last_page)
+			break;
+		cursor = seg_last + 1;
+	}
+
+	mmput(mm);
+
+	return saved_ret;
+}
+
+static void
+svm_restore_enqueue_unmapped(struct amdgpu_svm *svm,
+			     unsigned long start_page,
+			     unsigned long last_page)
+{
+	struct drm_gpusvm_notifier *notifier;
+	struct drm_gpusvm_range *r;
+	unsigned long start = start_page << PAGE_SHIFT;
+	unsigned long end = (last_page + 1) << PAGE_SHIFT;
+
+	amdgpu_svm_assert_locked(svm);
+
+	drm_gpusvm_for_each_notifier(notifier, &svm->gpusvm, start, end) {
+		r = NULL;
+		drm_gpusvm_for_each_range(r, notifier, start, end) {
+			struct amdgpu_svm_range *svm_range =
+				to_amdgpu_svm_range(r);
+			unsigned long rs, rl;
+
+			if (READ_ONCE(svm_range->gpu_mapped))
+				continue;
+
+			rs = drm_gpusvm_range_start(r) >> PAGE_SHIFT;
+			rl = (drm_gpusvm_range_end(r) >> PAGE_SHIFT) - 1;
+
+			svm_restore_enqueue_work(svm, svm_range, rs, rl,
+				     AMDGPU_SVM_RANGE_OP_RESTORE);
+		}
+	}
+}
+
+void amdgpu_svm_restore_gc_work_func(struct work_struct *w)
+{
+	struct amdgpu_svm_gc *gc = container_of(w, struct amdgpu_svm_gc, work);
+	struct amdgpu_svm *svm = container_of(gc, struct amdgpu_svm, gc);
+	struct amdgpu_svm_range_op_ctx op_ctx;
+	struct drm_gpusvm_ctx ctx = { .in_notifier = false };
+	unsigned long range_start_page;
+	unsigned long range_last_page;
+	bool partial;
+	int ret;
+
+	spin_lock(&svm->work_lock);
+	while (amdgpu_svm_range_dequeue_locked(svm, &svm->gc.list,
+					       &op_ctx)) {
+		spin_unlock(&svm->work_lock);
+		range_start_page = drm_gpusvm_range_start(&op_ctx.range->base) >> PAGE_SHIFT;
+		range_last_page = (drm_gpusvm_range_end(&op_ctx.range->base) >> PAGE_SHIFT) - 1;
+		partial = op_ctx.range->base.pages.flags.partial_unmap;
+		ret = 0;
+
+		WARN_ON(!UNMAP_WORK(op_ctx.pending_ops));
+
+		down_write(&svm->svm_lock);
+
+		if (partial)
+			amdgpu_svm_range_evict(svm, &op_ctx.range->base);
+
+		amdgpu_svm_range_remove(svm, op_ctx.range, &ctx);
+
+		/* Remove the range immediately prevent the stale range block the
+		 * rebuild.
+		 */
+		drm_gpusvm_range_put(&op_ctx.range->base);
+		op_ctx.range = NULL;
+
+		if (partial) {
+			/* Rebuild the valid area if partial unmap,
+			 * cause gc always remove the entire range.
+			 */
+			ret = svm_restore_map_interval(svm, range_start_page,
+					   range_last_page);
+			if (ret)
+				svm_restore_enqueue_unmapped(
+					svm, range_start_page,
+					range_last_page);
+		}
+
+		up_write(&svm->svm_lock);
+
+		spin_lock(&svm->work_lock);
+	}
+	spin_unlock(&svm->work_lock);
+
+	if (atomic_read(&svm->restore.evicted_ranges))
+		queue_delayed_work(svm->restore.wq, &svm->restore.work,
+				   msecs_to_jiffies(AMDGPU_SVM_RANGE_RESTORE_DELAY_MS));
+}
+
 int amdgpu_svm_restore_init(struct amdgpu_svm *svm,
 			    void (*begin)(struct amdgpu_svm *),
 			    void (*end)(struct amdgpu_svm *))
-- 
2.34.1

