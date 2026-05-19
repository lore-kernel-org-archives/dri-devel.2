Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12A30CD4851
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 09:24:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D20010EBD5;
	Tue, 19 May 2026 09:24:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="osG2R6Ko";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010039.outbound.protection.outlook.com
 [52.101.193.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A60A410EBD5;
 Tue, 19 May 2026 09:24:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gZeRBR9DB8ekuA8vCGLbCAgIbdFZjkNgdCftavZirLFRVzEqTGlCIm6nJnm59nTLMkynIGlz9+BF60SF7aAtFW1+Rx0QbDSRh1LyyHp8meqswfzKWqMrsHGI5nTH5DWAe8VNK56ozOSYGGrhPRudCJbTw2HvH+hWYrcYDushwY+lkl4K4GCy9Ak4bYPUZ7lCrZPDjp8EoTMtpaC0OmpiTHeeQUkWHmBABhGFH/4iIhoc4LSO4pNO9ZNOJy5A40ziTXU/eYfMrWv841N7XQfZPYj+1klRwoLZ8BGUD2WpNempIjyJUUla0sUtWOVcUl7x7+Lp4nWhD1HsBPOSpfEYqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CjI2b3sRF6GhepfCRPi3bZJGFY1TP8mcPV80TGkbu50=;
 b=IHA5osqEe6xo8q72qmeB60sr8Ofc3WKCGu4+s2W5mX8uyQVvP17HM5mFGTXCnpOu38i7grWsJ5hMTAviuF9djJmFKcj+yvvcoJIwshg8sxWwLHl9vKXYfyMlO/df6Mipomg3MzmiX5chuseMLUfSKOxbzYlPv1zXld2Rhm8m5oRO7onggVE1gor5vb6vhf/d4F+cEuvlrlDXUTREnrAejvtyZWmA3Hs6EhuqvoI73g5os2JHZYbZDJvdWlzOurNMl/IVBnBJiB1LeV7fRnTovG/a0pru4FQFktxsQhnlurc5Vc1hgC+yDKuEN126LeaWxwUtfsq+Nu9Hg5kXk6Zb3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CjI2b3sRF6GhepfCRPi3bZJGFY1TP8mcPV80TGkbu50=;
 b=osG2R6Koei+bZjtBrI2Yopsx0Dz4x5ti407QmF8+h9sbG2sXxoSIW5h4q5h6WYX1UBo4rwOnT3EAZq5YXk4x0u3TOBary0YBkF/sP6VVGIa0cOTJhtfGOa3MHuDU4R2J+G1N4OkCFWo2DQJ48dPL+6WWaEGMg4ygwiywnqENTrk=
Received: from DS1P220CA0014.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:455::18) by
 PH8PR12MB6700.namprd12.prod.outlook.com (2603:10b6:510:1cf::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Tue, 19 May
 2026 09:24:04 +0000
Received: from DS3PEPF000099DD.namprd04.prod.outlook.com
 (2603:10b6:8:455:cafe::19) by DS1P220CA0014.outlook.office365.com
 (2603:10b6:8:455::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.14 via Frontend Transport; Tue, 19
 May 2026 09:24:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099DD.mail.protection.outlook.com (10.167.17.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 09:24:04 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 19 May
 2026 04:23:59 -0500
From: Honglei Huang <honglei1.huang@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>, <Yiru.Ma@amd.com>,
 <sima@ffwll.ch>, <matthew.brost@intel.com>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>, <aliceryhl@google.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <honghuan@amd.com>
Subject: [RFC 7/8] drm/amdgpu: add xnack-off attr change boundary realign
 helper
Date: Tue, 19 May 2026 17:23:12 +0800
Message-ID: <20260519092313.3115848-8-honglei1.huang@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DD:EE_|PH8PR12MB6700:EE_
X-MS-Office365-Filtering-Correlation-Id: 687d52e4-e3e4-48f1-678a-08deb5885ecd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|56012099003|22082099003|18002099003|11063799006|921020;
X-Microsoft-Antispam-Message-Info: 4yt8SSYe0gKtoGxv4t5YPD+ATKEfHbwNjHrlSvH5fENEfDoMOTsofx4f6gszfjvbuKNROdrtQjkW8PblHfbfXoBcGfkRXRWTwhiGySDUxZHTnkTX0n/U6Go72Y3hnS/OzGQLV9qv62cXQbqfvu1z6YUny0Ixp0qZoq/EwKK2IrMSO5+EDjRkyHTc4SgPCdv5vYWk8SNHewccJbyp4GxliZwrx6CCI4LPmzF5a3BYy5GfUlAuLee1RcCgMM6+SPCkRWOGEGE1GV7jhbujvz8O+cn1ux6y9195mno4pIMcWfSe8gB3BdY0KXbSVGJo14VZv5amMoKKce8J9M+xn7+ShILTaBI7DLPtmXt3oRl6lYm4ko9lFgfJu5scP5v4hu7b3jr4cvIVyRuJuG8VYXD3rAAYqjqosqgNF2jPrwjE4Bo6GI8PdQLG4atkHsy1TT3gcE7fBdr5cmyX8TZ9AAzi4s+wWPL91fyFouXEQDIchcJH5PrhZmqzvMv31WKgRwTuIWjDLs+QKIZCbL5zfgbHM3AWMFlK8ltJxkXSFZG53d+asKATE4HYwpceLUv5SFCS7yBg+YqAOU6Rnv2ddPAOcKkJQLQDDk9TdK+lHvK4TNc1cpSSgsBmrrk2P5aEdU4KKGEZb9bKW194IJzMsAT7uuZzyu+2yTqouI8QukKMTwPXOt8+Q1fWYE5x1h0uXFiurjJno/n0Cg9kXotwlZOxE5GZpMRUVJlGIlvydVEoBSCETrw67SxPSAN2SCzBbsvhJyvaq3wrZIoXSWne1h/1Vg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(56012099003)(22082099003)(18002099003)(11063799006)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TVsjVn7nd0YKNUuPsPU627lqP3lRoQk+3Z56A/31c1krXr1omhAVHXIQfNmhlHvkBTDCMouh3FOkPzFQKkbapGdTnrQsYrYYk0pPzO70yFjv86A1AMk3HQ1YJsxB8t/8/4Ssd7MhIERjyhuS39qvQuPymwPDiTF2QZgpU5chafZSausnQikklzn9cMscgXdGCU1eyjCZFgLWFHyPOtNLR3TjhASkyu+wb7GbXDidhvNa00XNDvgeDMe+KZadUuKWnZ2ye9jlM6RLKOTeyvnr903yds/TurwWizp1HjspVUTtJOERydFQF+f8nOtj0qqd4oCsifGuUq6FIn9L9F5Hknky9yYZr5ocB8y9S0Sgh2bJXHjhuGhORIbc85rGpLjD2q8smY9Peq/VNo6rOlTF/v8bC6PZkgs/VyWZf+rGpk0h+h0Ejmtz6CJf2lBq4aYm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 09:24:04.3090 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 687d52e4-e3e4-48f1-678a-08deb5885ecd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6700
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
index 34b3b4149..040406a28 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userptr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userptr.c
@@ -29,6 +29,7 @@
 #include "amdgpu.h"
 #include "amdgpu_amdkfd.h"
 
+#include <drm/drm_exec.h>
 #include <drm/drm_gpusvm.h>
 
 #include <uapi/linux/kfd_ioctl.h>
@@ -477,6 +478,85 @@ svm_restore_map_interval(struct amdgpu_svm *svm,
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
@@ -566,6 +646,155 @@ void amdgpu_svm_restore_gc_work_func(struct work_struct *w)
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

