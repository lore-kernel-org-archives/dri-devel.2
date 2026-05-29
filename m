Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF893CD5BD2
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 05:50:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 251F210F911;
	Fri, 29 May 2026 05:50:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CLieLTFV";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010063.outbound.protection.outlook.com [52.101.56.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5780210F902;
 Fri, 29 May 2026 05:50:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hFSTrjjy61oAQ0y1FwZlYxVIOaSrWSEsdzaea3cQxvTuzL45dnP+AkSbIhsJ74CyarS8nM14a8WpI1yx9lwITP3ctI7Lq7JkvOgZKqFfE1icZRBonMrkEnBD4KaeNfia0CmgbTAHFOUnehG8sMxCg+N72QcT7IEQrnTggxm/VdUUiOWiOwi8pOWGfjBdpsw0BVUu8UsrcPvaDcV+1hcZntTuWysIDmmz8ZKCW/BHnclrydB/GF3VNVuxvhJNRKIP3IzMj/NDy9WTCEsK1Sqs0toc6u6NrHLdjjVRwOovSZhfkJp5t4F/QajCozD3KI8rnzw9yZQ62KHlAAYBk68ymw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x/HwlwipfPTAlQOWAz9n+epkgCWa1pf0pgNW2jrYAI4=;
 b=uyeA5m4MUoCrQ2sT/FZz7cawCs1HTxClNOsjrn+6v3Yz0SWDM/g4jUeLwGRNJCWxiWTTg8gfq33+2uAQcthI8zXCMmmRMA5u4J9Jd7CMVfB/Kr3mUweoMXjgVDKyB/CPZ92+5iFsl8LY/ErrHbrsfG6TDd1YSjeWqBSaQ11W16ojLIQyWPt7VEfWHRqyyO++zxJkDssSvuS+mUK99EJXIRubMCbIMrhbEuQtWOn9UAGBFrBE2jVG8D+8VDIi7Zjk3TXZjNrVGbVhd4iiVPf9HJ/PcDryX3Zo7jt9DlHFdiFt3R+z/CAEjBuJ/2cBGLci9sluLbBh0mDJQWkiI0AnVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x/HwlwipfPTAlQOWAz9n+epkgCWa1pf0pgNW2jrYAI4=;
 b=CLieLTFVn/aFX3/3Z4PwIq+pVEHKr6N778mlOfHzHD/M+TlV+4r372bqZulz1BlPjIKU1fmVyNYLnkBRjgN3oo4xeEVhqmENcA4gXT7HlSz7ELtF5cOaXIexN9Lo4QDp/EBh7/kKqpmgYmSziipSXiPYSJNnKkce0qfOg2JCzxQ=
Received: from CH2PR11CA0023.namprd11.prod.outlook.com (2603:10b6:610:54::33)
 by PH7PR12MB5856.namprd12.prod.outlook.com (2603:10b6:510:1d7::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Fri, 29 May
 2026 05:50:17 +0000
Received: from CH2PEPF0000013B.namprd02.prod.outlook.com
 (2603:10b6:610:54:cafe::68) by CH2PR11CA0023.outlook.office365.com
 (2603:10b6:610:54::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Fri, 29
 May 2026 05:50:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000013B.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 29 May 2026 05:50:17 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 29 May
 2026 00:50:12 -0500
From: Honglei Huang <honglei1.huang@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>, <Yiru.Ma@amd.com>,
 <sima@ffwll.ch>, <matthew.brost@intel.com>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>, <aliceryhl@google.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <honghuan@amd.com>
Subject: [V2 RFC 7/8] drm/amdgpu: add xnack-off attr change boundary realign
 helper
Date: Fri, 29 May 2026 13:49:27 +0800
Message-ID: <20260529054928.596825-8-honglei1.huang@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013B:EE_|PH7PR12MB5856:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c5d5faa-f6b3-43c7-7bd3-08debd462987
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|921020|22082099003|18002099003|56012099006|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info: glNTI6LpmoEIP4oYKnsiCh/FUC3Za4jviwGVlTg9BhIOfMD1HqlJszxyqp3F3Y8VVaBnNG32zHmu/BiFcBVwtrKtps1Fb/R0Q1HxCmi2vRaaSzhLNaLqzsa/dMhJLlZzj294DX71aPiyzIyLhCHwxUfKB+UCz5QwakltKejw5a/TAlMAJRGCnzptyUbi4vaI/4nuplh3K0tL5WnvnfDH63oeXW6NKFeQhhbwxFtRNRwlNYumsq0IDtVene7ZLrAnKlJKGOCNPn9CNLLrMSvW8tI0JN2jZaAKnKcuttCeHUVxSdNXAn15b6DTcVOlZ0QARjj399tvBxP+OU5HzYwgswbLCY0QIHTpDWpmcSVl4BhhVVUyJ3QRfkEFag2CU3q5HyLad/y8TCazOc5niiYM9aUTf/O6KDqq/BZTcaQVmKx/q9Z9Cjd5qBJGf2rJOAN3Es7f2E/H/FeG3JUEL9tq43UNoDjtby0eH/YwhoRfKBTVgQMFL6DKazku4f9Xid2K4WBJ7xwuOxTL2S3MzlehwAcfq+u0IXho988kEKY26wTrdEGlrUEAHKHGrlcKBuiOajQqsj6W90a63VehnCylrjybGGO5hAVSMrKCAr5eR7tgSCZzNVFEE95SvFXQx2UYjjsy/nMM+8Gk5T+CoGqKHJA9/7Lmd0SxbU0DMdDqyN72t6Im3hPakZ4T777Ha2IPwwkWnYAY2si4k/qYOId3XlYsh3TLZiTGdlQ5+Et62LIIQmLS6KNEMbUh4bwiUl/ORSQJrDOMJBPfY7AjteKwtQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(921020)(22082099003)(18002099003)(56012099006)(6133799003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kWDFo9DvKD40zMHCTefL7lu4A9Zj1ChiSL7dlyhof9qWKiy1NTA2tRcb8f7/4nkHtH9yoJ8HQ4XZct0YyV3H7RzXR2KoSG+MFYTEfPUn8MNw4gsLt1SELGiCE4C6XV922rTV6LF9VCYiq4CtlPTNJQ58Hw0BzJisYChuzKegGbOgu5/8fMd3fNWX9Zw5UO+L8UZh4VLh/dVk2hNs9sICI9SSR5RpsGnhMi4DdkBf2N+47pGxMaNZrwjY/LFsnu9DBfghb+pekFpuhYutpCWX0raoWRSEx3EYvbcEPvJ23qi9dCxUA1Bqw8jrd18RKGdQO+KoROppFLCf13BmGbO0Ul5I+v39J69OoxNLkTEpksg+P7RUCoVnQY3pLLEZ05YEVWd5fouEpnWGRMm070BKG8nsYKkzAKn9G2lCiLJ99LY+eIgRlPSC67dX/IOohO4X
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 05:50:17.4988 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c5d5faa-f6b3-43c7-7bd3-08debd462987
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5856
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

amdgpu_userptr.c:
- svm_restore_find_or_insert_by_attrs / svm_restore_find_or_insert:
  insert empty placeholder drm_gpusvm_ranges over [start, end) using
  attrs from the attr tree (no get_pages, no PTE update).
- svm_restore_realign_boundary: locate the (at most two) crossing
  ranges via O(log N) interval-tree lookups, evict devmem pages,
  zap PTEs and remove the ranges under drm_exec, then re-insert the
  head/tail residue as placeholders and enqueue them to the restore
  worker. If any crossing range was GPU-mapped, join the eviction
  window and report it back so the caller kicks the worker.
- amdgpu_svm_map_attrs_with_restore: one-stop helper that realigns
  the boundary, maps the requested interval with the new attrs,
  and kicks the restore worker if the eviction counter was touched.

amdgpu_userptr.h:
- Declare amdgpu_svm_map_attrs_with_restore() and forward-declare
  struct amdgpu_svm_attrs.

No in-tree caller yet; wired up in the next commit.

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userptr.c | 229 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userptr.h |   5 +
 2 files changed, 234 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userptr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userptr.c
index 22f19dcc6..4582fb945 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userptr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userptr.c
@@ -29,6 +29,7 @@
 #include "amdgpu.h"
 #include "amdgpu_amdkfd.h"
 
+#include <drm/drm_exec.h>
 #include <drm/drm_gpusvm.h>
 
 #include <uapi/linux/kfd_ioctl.h>
@@ -495,6 +496,85 @@ svm_restore_map_interval(struct amdgpu_svm *svm,
 	return saved_ret;
 }
 
+static int
+svm_restore_find_or_insert_by_attrs(struct amdgpu_svm *svm,
+			  const struct amdgpu_svm_attrs *attrs,
+			  unsigned long start, unsigned long end)
+{
+	unsigned long addr = start;
+	bool devmem_possible = amdgpu_svm_attr_devmem_possible(svm, attrs);
+	bool need_vram_migration = amdgpu_svm_attr_prefer_vram(svm, attrs);
+	struct drm_gpusvm_ctx map_ctx = {
+		.read_only = !!(attrs->flags & AMDGPU_SVM_ATTR_BIT_GPU_RO),
+		.devmem_possible = devmem_possible,
+		.devmem_only = need_vram_migration && devmem_possible,
+		.check_pages_threshold = devmem_possible ? SZ_64K : 0,
+	};
+
+	while (addr < end) {
+		struct amdgpu_svm_range *range;
+		unsigned long next_addr;
+
+		range = amdgpu_svm_range_find_or_insert(svm, addr, addr, end,
+							&map_ctx);
+		if (IS_ERR(range)) {
+			AMDGPU_SVM_ERR("find_or_insert failed at 0x%lx [0x%lx-0x%lx) ret=%ld\n",
+				       addr, start, end, PTR_ERR(range));
+			return PTR_ERR(range);
+		}
+
+		next_addr = drm_gpusvm_range_end(&range->base);
+		if (next_addr <= addr)
+			return -EINVAL;
+
+		addr = next_addr;
+	}
+
+	return 0;
+}
+
+static int
+svm_restore_find_or_insert(struct amdgpu_svm *svm,
+			   unsigned long start_page,
+			   unsigned long last_page)
+{
+	struct amdgpu_svm_attr_tree *attr_tree = svm->attr_tree;
+	unsigned long cursor = start_page;
+	int ret = 0;
+
+	amdgpu_svm_assert_locked(svm);
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
+			int ret;
+
+			ret = svm_restore_find_or_insert_by_attrs(svm, &attrs,
+					cursor << PAGE_SHIFT,
+					(seg_last + 1) << PAGE_SHIFT);
+			if (ret)
+				return ret;
+		}
+
+		if (seg_last >= last_page)
+			break;
+		cursor = seg_last + 1;
+	}
+
+	return ret;
+}
+
 static void
 svm_restore_enqueue_unmapped(struct amdgpu_svm *svm,
 			     unsigned long start_page,
@@ -584,6 +664,155 @@ void amdgpu_svm_restore_gc_work_func(struct work_struct *w)
 				   msecs_to_jiffies(AMDGPU_SVM_RANGE_RESTORE_DELAY_MS));
 }
 
+/*
+ * Because a range cannot be split, when the user sets a new attribute over
+ * an existing range it may result in at most two crossing ranges that
+ * straddle the new boundary. The crossing ranges need to be destroyed and
+ * rebuilt with the new attr boundary.
+ * See below:
+ * [old attr] [new attr] [old attr]
+ * [     range1  ][   range 2     ]
+ */
+static int
+svm_restore_realign_boundary(struct amdgpu_svm *svm,
+			     unsigned long start_page,
+			     unsigned long last_page,
+			     bool *eviction_taken)
+{
+	unsigned long start = start_page << PAGE_SHIFT;
+	unsigned long end = (last_page + 1) << PAGE_SHIFT;
+	unsigned long head_start_page = start_page;
+	unsigned long tail_last_page = last_page;
+	struct drm_gpusvm_ctx ctx = { .in_notifier = false };
+	struct drm_gpusvm_notifier *notifier;
+	struct drm_gpusvm_range *head = NULL, *tail = NULL;
+	struct drm_gpusvm_range *crossings[2];
+	struct drm_exec exec;
+	bool needs_flush = false;
+	int i, ret;
+
+	amdgpu_svm_assert_locked(svm);
+
+	*eviction_taken = false;
+
+	notifier = drm_gpusvm_notifier_find(&svm->gpusvm, start, start + 1);
+	if (notifier) {
+		head = drm_gpusvm_range_find(notifier, start, start + 1);
+		if (head && drm_gpusvm_range_start(head) >= start)
+			head = NULL;
+	}
+
+	notifier = drm_gpusvm_notifier_find(&svm->gpusvm, end - 1, end);
+	if (notifier) {
+		tail = drm_gpusvm_range_find(notifier, end - 1, end);
+		if (tail == head)
+			tail = NULL;
+		else if (tail && drm_gpusvm_range_end(tail) <= end)
+			tail = NULL;
+	}
+
+	if (!head && !tail)
+		return 0;
+
+	if (head)
+		head_start_page = drm_gpusvm_range_start(head) >> PAGE_SHIFT;
+	if (tail)
+		tail_last_page = (drm_gpusvm_range_end(tail) >> PAGE_SHIFT) - 1;
+
+	if ((head && READ_ONCE(to_amdgpu_svm_range(head)->gpu_mapped)) ||
+		(tail && READ_ONCE(to_amdgpu_svm_range(tail)->gpu_mapped))) {
+		/* Stop queue if any crossing range*/
+		svm_restore_eviction_begin(svm);
+		*eviction_taken = true;
+	}
+
+	ret = amdgpu_svm_range_lock_vm_pd(svm, &exec, true);
+	if (ret)
+		return ret;
+
+	crossings[0] = head;
+	crossings[1] = tail;
+
+	for (i = 0; i < ARRAY_SIZE(crossings); i++) {
+		struct drm_gpusvm_range *r = crossings[i];
+		struct amdgpu_svm_range *svm_range;
+		unsigned long rs, rl;
+
+		if (!r)
+			continue;
+
+		svm_range = to_amdgpu_svm_range(r);
+		rs = drm_gpusvm_range_start(r) >> PAGE_SHIFT;
+		rl = (drm_gpusvm_range_end(r) >> PAGE_SHIFT) - 1;
+
+		amdgpu_svm_range_evict(svm, r);
+
+		if (svm_range->gpu_mapped) {
+			AMDGPU_SVM_RANGE_DEBUG(svm_range, "ATTR DESTROY");
+
+			ret = amdgpu_svm_range_zap_ptes(svm, svm_range, rs, rl);
+			if (ret < 0) {
+				AMDGPU_SVM_TRACE("zap failed ret=%d [0x%lx-0x%lx]\n",
+						 ret, rs, rl);
+				drm_exec_fini(&exec);
+				return ret;
+			}
+			needs_flush = true;
+		}
+
+		amdgpu_svm_range_remove(svm, svm_range, &ctx);
+	}
+
+	drm_exec_fini(&exec);
+
+	if (needs_flush)
+		svm->flush_tlb(svm);
+
+	/* Insert the range only and queue to restore worker here.
+	 * Cause the get pages may fail and need retry.
+	 * So doing the restore asynchronously in worker to avoid the complex
+	 * retry logic in ioctl path, and avoid the complex resume
+	 * synchronization logic between ioctl and worker.
+	 */
+	if (head_start_page < start_page) {
+		svm_restore_find_or_insert(svm, head_start_page, start_page - 1);
+		svm_restore_enqueue_unmapped(svm, head_start_page, start_page - 1);
+	}
+	if (tail_last_page > last_page) {
+		svm_restore_find_or_insert(svm, last_page + 1, tail_last_page);
+		svm_restore_enqueue_unmapped(svm, last_page + 1, tail_last_page);
+	}
+
+	return 0;
+}
+
+int
+amdgpu_svm_map_attrs_with_restore(struct amdgpu_svm *svm,
+				  const struct amdgpu_svm_attrs *new_attrs,
+				  unsigned long start_page,
+				  unsigned long last_page)
+{
+	bool eviction_taken = false;
+	int ret;
+
+	/* Check the boundary */
+	ret = svm_restore_realign_boundary(svm, start_page, last_page,
+					   &eviction_taken);
+	if (ret)
+		goto out;
+
+	/* Map the user requested interval with the new attributes */
+	ret = amdgpu_svm_range_map_attrs(svm, new_attrs,
+					 start_page << PAGE_SHIFT,
+					 (last_page + 1) << PAGE_SHIFT);
+
+out:
+	if (eviction_taken)
+		mod_delayed_work(svm->restore.wq, &svm->restore.work, 0);
+
+	return ret;
+}
+
 void amdgpu_svm_quiesce_compute(struct amdgpu_svm *svm)
 {
 	struct mm_struct *mm = svm->gpusvm.mm;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userptr.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userptr.h
index a8f76f785..a769f4915 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userptr.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userptr.h
@@ -59,5 +59,10 @@ void amdgpu_svm_restore_invalidate(struct amdgpu_svm *svm,
 				   uint64_t adj_start, uint64_t adj_end);
 void amdgpu_svm_quiesce_compute(struct amdgpu_svm *svm);
 void amdgpu_svm_resume_compute(struct amdgpu_svm *svm);
+struct amdgpu_svm_attrs;
+int amdgpu_svm_map_attrs_with_restore(struct amdgpu_svm *svm,
+				      const struct amdgpu_svm_attrs *new_attrs,
+				      unsigned long start_page,
+				      unsigned long last_page);
 
 #endif /* __AMDGPU_USERPTR_H__ */
-- 
2.34.1

