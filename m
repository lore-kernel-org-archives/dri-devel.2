Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DC59CD4F5B
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 09:24:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93B1310EBC0;
	Tue, 19 May 2026 09:24:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UbyeTmmu";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012036.outbound.protection.outlook.com [52.101.43.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78B6B10EBCA;
 Tue, 19 May 2026 09:24:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CgT9VNwpgxOvjqepccg9VnEFheOy+ibN/Cz81l52c5GnaYhe9Zy9Gd/eF+ELzzplBSZuWp/0mhPJ9DpZ84yjLBOuurGbgfWFFJHoYNRrCjvMdvMFAoyHZ/xBX/JW6aU8i8IaC6FSuPzNBPcFROXK5XSTP8/V0wHh/kBr6bqFsgCx6g3+UQ5QJCcbe1+zyxF7BvSfyNJ3kMfUQt+nl3K/PkvJZvoimwNypBZb5pNrTHihtrJbgjjftlzj7BYO919cSaTXC9+T7rbid/je3PQ7sT+0QtQUTOcTmTKJ5Sz7RvrV4e8HxoePxUWtQBmxcZQ8sHGOdI+7Vo9m4D/Q1zuGcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+EWfWGo4/LXCmiQOBQ45AD42o3ew7YzSQXvCNhykoK8=;
 b=M6m3xaYi7DcYYfuEA2OJAtARX7nZdpFkr52hqdVNouVjDEIhRSI5G3eVbpy7OEfYAK+r5dNobZo6YiLba21XebhE2e8cafmXdM9IUlfPmBalbNup56fkMm51121wd1QC4bZm/0VzBsBCTC3mW+tYik108xMOKZWPq9DmrF6oHgwRj3pYb/nf8HMvmhZG5m9N3dGcK3k9qhMcfgxobnn5QITtYvqhDVmnpE5ml/Kd+uuwv13lk860tx9lcAWPCoU5kShvpM64sUjn0JjBbj6WZbKJh8v2gH5ZzqQWkuYYHGBeh4TPZL8JeE7mrpyDVS7zZsivz21cRZ0DMFLLWsTCHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+EWfWGo4/LXCmiQOBQ45AD42o3ew7YzSQXvCNhykoK8=;
 b=UbyeTmmu5V9MQ5jSfQnBvnWHiKiiipOCHXM9U+xqTo/xzqeYmeI+9We0K+Lb/cLhxq0JGQ8Q8ZDVpGv1xw6Ym7QVPuWz7bENEkll1FNLvLePlZXUV6mbD+ce7KMRZRZM1843E6N0a5iOBFjSPbjPyxEeZx4Wiv2NOEhXjt46qc8=
Received: from DSZP220CA0010.NAMP220.PROD.OUTLOOK.COM (2603:10b6:5:280::11) by
 PH7PR12MB5593.namprd12.prod.outlook.com (2603:10b6:510:133::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.24; Tue, 19 May 2026 09:23:55 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:5:280:cafe::48) by DSZP220CA0010.outlook.office365.com
 (2603:10b6:5:280::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.14 via Frontend Transport; Tue, 19
 May 2026 09:23:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 09:23:54 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 19 May
 2026 04:23:50 -0500
From: Honglei Huang <honglei1.huang@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>, <Yiru.Ma@amd.com>,
 <sima@ffwll.ch>, <matthew.brost@intel.com>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>, <aliceryhl@google.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <honghuan@amd.com>
Subject: [RFC 5/8] drm/amdgpu: implement xnack-off GC work function
Date: Tue, 19 May 2026 17:23:10 +0800
Message-ID: <20260519092313.3115848-6-honglei1.huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260519092313.3115848-1-honglei1.huang@amd.com>
References: <20260519092313.3115848-1-honglei1.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|PH7PR12MB5593:EE_
X-MS-Office365-Filtering-Correlation-Id: a2202375-1c4f-4412-8c68-08deb588593a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|921020|11063799006|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 4MZiP9lSwe0gUmMDPdf+uk5qTKhjkHEZ7Tbeu6M7vVSKr18jyNJf01rElx5JTid3FrLxkZVLHEpFPeTwQ8MUtWUdWvkU6WQK1PeLkaawjwxuBJByJqrugw+sObBW70tgr04SfYq5jjdXyyxQWV5njie2k3YI9KDe6oS4iDOq87mhrCpoWvLZxFvs0In9wFWzqQ2zvFRk+M0bKgwbJe/0YcrSpherwq2I4kzmXM9L2zF7fJZ99+C51kTuKJEpmXJsa4kVa5+ZK8V5HsjWjt7Tmahtn44CC/5q8CZPpbjQzdXecnd3Hk1ABaeJI8E4ty7mzxqpOlkZp3fA938tGwik+wV8bZ34tz2CChKcW64z7gBBu4I3GRceah0Etr2hIqwqhD/U9ITyL1THxW/36/B9c1HEBic769Pa6hn1HLObG01jK7UOBFusbghIXfWGWs7LvvxaqNPh71yVrFYz/dENOcUPsXXgnYojLRmuLuY907HoL4u6bJNkPJkHeBWod7YRsYiudhU5xMrK32at71Jex5EPgNlsXrQZ8Z47wlRDpgtdkaF7g+Nu2G15oefP/J3TfEELhxkON+qmdLnAi8v6Z+HRKwp7KjcAX8vT74ZbkvtaKL2c1s4RfanCGlI4RyCjmL/OrBqOuNN36L5hCmbKXrgxuqPaoZoCu6R4w0gwnB2JmQS+CPrlxSFCMyrYvROe9fov6AftT2rdkycWNsJnAri1KIyCDy4domJ2xMK3Ucbo3inZ1iVpNhYn9rEIQwkpHezFM0/5gpIJLeV1Mc1fkA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(921020)(11063799006)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: obHJJdEuDP27MyDYGGRWQskZe2Xd8z32J+WxTzTemspFK0wFqygpdh9hguTJxIBBB842sooSJ6vO2gpuUZCnZkluYDSJLTgRRJDigE5N+Bm1BE13uho94SRhfi4UDVhCtekxXMnEwxm2Wx8qS24Ifyu238UuN/0pK67vzvs9ixGxSpPlvsWUgd+Mke/IC5OABkLLIIL/Jigtg2k9G4BH4ndMshL4NqYcPY2XaqM+Ym9bCP9h2GkXXEWcHuhge5ZrepzbTHSFLgGNzYLwP7GiXzptSdDi8bCTXp5lX2IqB8fpagqA6KL2DH5z0+sltQYWHRnJ24jSHt9Y/jyY7d8GX1za2nV3KABnlHgHUhY2P9iqcUTzcpNkfI/EcPlCyNNrnD4T4sa7EESNQmpmXP92k/9pNiMxWPJV+3tBfF1T+uTsxE7mwPfr9EcJN4k9hIMa
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 09:23:54.9565 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2202375-1c4f-4412-8c68-08deb588593a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5593
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_userptr.c | 197 ++++++++++++++++++++
 1 file changed, 197 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userptr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userptr.c
index 89e8b687b..0b02008be 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userptr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userptr.c
@@ -369,6 +369,203 @@ static void amdgpu_svm_restore_worker(struct work_struct *w)
 
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
+ *      Errors that the worker has no way to recover from -ENOENT,
+ *      -EFAULT, -EPERM, -EINVAL, -EHWPOISON are classified as
+ *      permanent: trace and skip the chunk, then continue with the
+ *      next VMA so a single bad page/VMA does not abort the rebuild
+ *      of the remaining interval.
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
+		if (ret == -ENOENT || ret == -EFAULT ||
+		    ret == -EPERM || ret == -EINVAL ||
+		    ret == -EHWPOISON) {
+			AMDGPU_SVM_TRACE("%s skip permanent [0x%lx-0x%lx) ret=%d\n",
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

