Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B484BCA5FA6
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 17:52:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECBA510EB49;
	Mon, 28 Sep 2026 17:52:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3brN1bpP";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010054.outbound.protection.outlook.com [52.101.61.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21BD810E098;
 Mon, 28 Sep 2026 17:52:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CzKuJzOeMKRThyZbjuPJeaRjTRAAY9aK2h2qd+xymmJeJ1xFqcw+QUzvM3VOUPtN2ieLxArtvH2HVbcyGGYqY8GaY+p9onYVB9z/ITmEjV9BA+f2Q/XYXem999g6Z68+IQSLUOakxYS3Jx/fa5EO7Zw39sIbKhm8U8It7Ry63yz5pBb0QogeJIsV2K8VS1f430vB0xOogCoM5qZye8oxNE+Mq4P7yJz0BxVdC2gi4+CXWG0BpJ3dMU/ZzjI/p4buA6IkILYLjuzJQYhtI2bsfb4ZY3SKdxrNNst2B7pzzSwkdPsm/0Iqv1tHTO7vVSg0JTjr63wAHTed8QiC9z8c9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fPYWdoc+lwcTWj75RvhrSGjbxg1Cgqx98lwlbYQTMKo=;
 b=pu+NoqYhcJCoyseC5x1GCJGpiFKlwJUaQSTNeWza+BOJbbTJY7LWp5+OlHB1e19YJ7E/6/7jA0vZ5GFFB0LrcfDr4cfnqA3gVt7WR1CwhtmVdCTXHuPJRNSvk3rC8e/cLIhHrgQLDrdRjqDDZeHxcdVWKWXMKBdtmS2hhdJ74C42TLD9LC3QeZAzI6tFwxK7Z1dCYqYGDnpdQ3sjt9aKP1+nhjua9glvbTj1B3ZzRwZsr0L0rcV3JPm6ZjZT9I+HwQs7f/OjVbP8AfTuYGE9lWF2spRXC9pjHWhW64StQ6aGvmOZ89ERW1zcT3m4cy/16ORGgIDaRX33BiIAexo/LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fPYWdoc+lwcTWj75RvhrSGjbxg1Cgqx98lwlbYQTMKo=;
 b=3brN1bpP3dLWsOHrtrixtyWQcGFjBnJ8FP4EdbsV/pDjnSNvzDb+nUgNv2vtAtYOGVwaEIv95MdbMSDAsnPVd3JBzQDCYVTfq2BBKxW+3RuPLu75GAZzRFyKw51PkYXAR4MhQNnxJVUn1DHoff42OwKzfWxCXLeDw/94aP7Ij70=
Received: from MN2PR15CA0048.namprd15.prod.outlook.com (2603:10b6:208:237::17)
 by SA3PR12MB8809.namprd12.prod.outlook.com (2603:10b6:806:31f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Mon, 28 Sep
 2026 17:51:58 +0000
Received: from BN1PEPF00018547.namprd05.prod.outlook.com
 (2603:10b6:208:237:cafe::70) by MN2PR15CA0048.outlook.office365.com
 (2603:10b6:208:237::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.24 via Frontend Transport; Mon,
 28 Sep 2026 17:51:58 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00018547.mail.protection.outlook.com (10.167.248.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Mon, 28 Sep 2026 17:51:58 +0000
Received: from rtg-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 28 Sep 2026 12:51:54 -0500
From: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
To: <matthew.auld@intel.com>, <dri-devel@lists.freedesktop.org>,
 <intel-gfx@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>,
 <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <Anand.Raghavendra@amd.com>, Arunpravin Paneer Selvam
 <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH 2/2] gpu/buddy: add range-restricted contiguous allocation
 fallback
Date: Mon, 28 Sep 2026 23:21:28 +0530
Message-ID: <20260928175128.257266-2-arunpravin.paneerselvam@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260928175128.257266-1-arunpravin.paneerselvam@amd.com>
References: <20260928175128.257266-1-arunpravin.paneerselvam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00018547:EE_|SA3PR12MB8809:EE_
X-MS-Office365-Filtering-Correlation-Id: 63a1924d-35f1-448a-ea1d-08df1d893167
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|23010399003|376014|10067099003|11063799006|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: rlNo8SHu8zJVAdwgEz9D85YSeVYI35V0mGBh323z3WSKoI9xgHZYYs9voy/og2klRhk7YDTZPDtOsAaRIIqLOtpRBnjPLSTrvJX/m7lYIUYkrp8XSkd9D8kn+SF2hqbtGLOc3WZpG3EtrVc08oigSshq3KGuaqmNuIM45OTtXFST+eKrU3iDoztfFfn2dS1mDOk49ud7dehIZ2RgXTYga7aYJjZNTWEk76iS05X9+TIfpCSwyIQPyMucJwklPTxwZIHQZO7IsgYALwf1gA8IzCL+p3BUP+teP26OUXnoKBDWawSQyFTp9c+Z9mqCsXvdmxnFJTDqq8mg249gd5oRzsm67+QG/kKTYTRrEGhplTA5PEifmItAv3UlhjzrGXp9N0ejym9t2GRkHPYPu8Gc+AfKS6Tw4sqpvb+eHU30xr1AKQ7kJLOpjVeB8nrSSY+p9B75ro4umSXkccJ8Okv1IxCw2cCAUdcuRWK7XLQBpgbl0v14AwrchdScAz8o88/iRDE2e5aDf8CRVDHA61j6v26F2fQLFJwpBXJUT9lIUvQ3lUNrrf94VsXc7AHmIQ8sX7J7cKpyYB2YQoLDicGS9+bhtyshw7SU2IhycVuhIREnW0272F36eCdl818BOvqwFlTUxKm666o/Iw6iXgeipPy4MguhVtp4OZN3SHu4lsYsZsiNRF2Xepro+WfsxWfriuQQsF2R1zWvJiIrKiapxA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(376014)(10067099003)(11063799006)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wAbmt2a9qRArQgCPYhLkhRQeZJO+l1FpN2dq2OF+NxCr67dI46342ztVot4U9rigaPMTCGVjsTh1O87oHwC8R69XdFLF7FWZyuYG5M/hVtndfCNSwJOs+gZhEIrQWcpi8xDSs4x2ma9wpmqOymOnZlxolU5b4Q2TayqUS3M8OCfKmsx9H04nYvvfvY8OQNXkg2vvm/ckg64g4r3WlQwoMBcE6GUAdAyjZkpXAQbVKnFKRUEFQ1BLk6iLlNAaCs7wekpqhglla+C3kLjydWJHeCF4coRJQN+qWAhTAUViSK3VeeZvjX1BLEYsyEcjsr53gxLEDHOfIC7IellXJ12vP/dne2pxNff88m7RTe/CGs/R5i+6HraY6eig6T+pTJlpVTJTyeE4TY8gwSyRITG6EjZkN2Cs5IivMIVvjIUjDLJ+3NTpX2wisH51rXMc3vlb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 17:51:58.6092 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63a1924d-35f1-448a-ea1d-08df1d893167
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00018547.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8809
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

From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>

A range + contiguous allocation (e.g. a scanout FB confined to the
CPU-visible VRAM aperture) rounds its size up to a power of two and
requires a naturally aligned free block of that size; on a fragmented
aperture no such aligned block may exist even though enough contiguous
space is free, so the allocation fails with -ENOSPC.

The non-range contiguous path already recovers from this via
__alloc_contig_try_harder(), which stitches an exact-size span from
smaller adjacent blocks, but that fallback was unreachable once
GPU_BUDDY_RANGE_ALLOCATION was set. Give __alloc_contig_try_harder()
a [range_start, range_end) window and route the range + contiguous
case through it: each candidate placement is confined to the window
and aligned to min_block_size. Non-range callers pass [0, mm->size),
where the guards are no-ops, so the existing behaviour is unchanged.
A KUnit regression test covers the fragmentation pattern.

Resolves the igt@kms_plane@plane-panning-bottom-right@pipe-a/pipe-b
regression.

Fixes: 1ad5e807f716 ("gpu/buddy: replace dual-tree/force_merge with decoupled dirty tracker")
Assisted-by: Claude:claude-opus-4-8
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
---
 drivers/gpu/buddy.c                | 88 ++++++++++++++++--------------
 drivers/gpu/tests/gpu_buddy_test.c | 83 ++++++++++++++++++++++++++--
 2 files changed, 126 insertions(+), 45 deletions(-)

diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
index b741160d3d16..de1d5b225cff 100644
--- a/drivers/gpu/buddy.c
+++ b/drivers/gpu/buddy.c
@@ -1737,26 +1737,14 @@ static int __gpu_buddy_alloc_range(struct gpu_buddy *mm,
 			     blocks, total_allocated_on_err);
 }
 
-static int __alloc_contig_aligned_retry(struct gpu_buddy *mm,
-					u64 unaligned_offset,
-					u64 size,
-					u64 min_block_size,
-					unsigned long flags,
-					struct list_head *blocks)
-{
-	u64 aligned_offset = round_down(unaligned_offset, min_block_size);
-
-	return __gpu_buddy_alloc_range(mm, aligned_offset, size, flags,
-				       NULL, blocks);
-}
-
 static int __alloc_contig_try_harder(struct gpu_buddy *mm,
+				     u64 range_start, u64 range_end,
 				     u64 size,
 				     u64 min_block_size,
 				     unsigned long flags,
 				     struct list_head *blocks)
 {
-	u64 rhs_offset, lhs_offset, filled;
+	u64 rhs_offset, lhs_offset, filled, aligned;
 	struct gpu_buddy_block *block;
 	struct rb_root *root;
 	struct rb_node *iter;
@@ -1786,20 +1774,24 @@ static int __alloc_contig_try_harder(struct gpu_buddy *mm,
 					       flags, &filled, blocks);
 		if (err && err != -ENOSPC)
 			return err;
-		if (!err && IS_ALIGNED(rhs_offset, min_block_size))
+		if (!err && IS_ALIGNED(rhs_offset, min_block_size) &&
+		    rhs_offset >= range_start && rhs_offset + size <= range_end)
 			return 0;
 		if (!err) {
 			/* Allocate the unaligned RHS offset using round_down */
 			gpu_buddy_free_list_internal(mm, blocks);
-			err = __alloc_contig_aligned_retry(mm, rhs_offset,
-							   size,
-							   min_block_size,
-							   flags, blocks);
-			if (!err)
-				return 0;
-			if (err != -ENOSPC) {
-				gpu_buddy_free_list_internal(mm, blocks);
-				return err;
+
+			aligned = round_down(rhs_offset, min_block_size);
+			if (aligned >= range_start &&
+			    aligned + size <= range_end) {
+				err = __gpu_buddy_alloc_range(mm, aligned, size,
+							      flags, NULL, blocks);
+				if (!err)
+					return 0;
+				if (err != -ENOSPC) {
+					gpu_buddy_free_list_internal(mm, blocks);
+					return err;
+				}
 			}
 			goto next;
 		}
@@ -1811,15 +1803,17 @@ static int __alloc_contig_try_harder(struct gpu_buddy *mm,
 
 		/* Allocate the unaligned LHS offset using round_down */
 		gpu_buddy_free_list_internal(mm, blocks);
-		err = __alloc_contig_aligned_retry(mm, lhs_offset,
-						   size,
-						   min_block_size,
-						   flags, blocks);
-		if (!err)
-			return 0;
-		if (err != -ENOSPC) {
-			gpu_buddy_free_list_internal(mm, blocks);
-			return err;
+
+		aligned = round_down(lhs_offset, min_block_size);
+		if (aligned >= range_start && aligned + size <= range_end) {
+			err = __gpu_buddy_alloc_range(mm, aligned, size,
+						      flags, NULL, blocks);
+			if (!err)
+				return 0;
+			if (err != -ENOSPC) {
+				gpu_buddy_free_list_internal(mm, blocks);
+				return err;
+			}
 		}
 next:
 		gpu_buddy_free_list_internal(mm, blocks);
@@ -2073,11 +2067,18 @@ int gpu_buddy_alloc_blocks(struct gpu_buddy *mm,
 	min_order = ilog2(min_block_size) - ilog2(mm->chunk_size);
 
 	if (order > mm->max_order || size > mm->size) {
-		if ((flags & GPU_BUDDY_CONTIGUOUS_ALLOCATION) &&
-		    !(flags & GPU_BUDDY_RANGE_ALLOCATION))
-			return __alloc_contig_try_harder(mm, original_size,
+		if (flags & GPU_BUDDY_CONTIGUOUS_ALLOCATION) {
+			u64 range_start, range_end;
+
+			range_start = (flags & GPU_BUDDY_RANGE_ALLOCATION) ? start : 0;
+			range_end = (flags & GPU_BUDDY_RANGE_ALLOCATION) ? end : mm->size;
+
+			return __alloc_contig_try_harder(mm, range_start,
+							 range_end,
+							 original_size,
 							 original_min_size,
 							 flags, blocks);
+		}
 
 		return -EINVAL;
 	}
@@ -2110,9 +2111,14 @@ int gpu_buddy_alloc_blocks(struct gpu_buddy *mm,
 			 * Try contiguous block allocation through
 			 * try harder method.
 			 */
-			if (flags & GPU_BUDDY_CONTIGUOUS_ALLOCATION &&
-			    !(flags & GPU_BUDDY_RANGE_ALLOCATION)) {
-				err = __alloc_contig_try_harder(mm,
+			if (flags & GPU_BUDDY_CONTIGUOUS_ALLOCATION) {
+				u64 range_start, range_end;
+
+				range_start = (flags & GPU_BUDDY_RANGE_ALLOCATION) ? start : 0;
+				range_end = (flags & GPU_BUDDY_RANGE_ALLOCATION) ? end : mm->size;
+
+				err = __alloc_contig_try_harder(mm, range_start,
+								range_end,
 								original_size,
 								original_min_size,
 								flags,
@@ -2120,9 +2126,9 @@ int gpu_buddy_alloc_blocks(struct gpu_buddy *mm,
 				if (!err)
 					return 0;
 				if (err != -ENOSPC)
-					return err;
-				goto err_free;
+					goto err_free;
 			}
+
 			err = -ENOSPC;
 			goto err_free;
 		} while (1);
diff --git a/drivers/gpu/tests/gpu_buddy_test.c b/drivers/gpu/tests/gpu_buddy_test.c
index b75d32ca6ca0..2c445870b808 100644
--- a/drivers/gpu/tests/gpu_buddy_test.c
+++ b/drivers/gpu/tests/gpu_buddy_test.c
@@ -1251,6 +1251,77 @@ static void gpu_test_buddy_alloc_contiguous(struct kunit *test)
 	gpu_buddy_fini(&mm);
 }
 
+static void gpu_test_buddy_alloc_range_contiguous(struct kunit *test)
+{
+	const unsigned long ps = SZ_4K, mm_size = 16 * ps;
+	const unsigned long range_end = 8 * ps;
+	struct gpu_buddy_block *block, *prev;
+	LIST_HEAD(allocated);
+	struct gpu_buddy mm;
+	LIST_HEAD(pin_lo);
+	LIST_HEAD(pin_hi);
+	u64 total;
+
+	KUNIT_ASSERT_FALSE_MSG(test, gpu_buddy_init(&mm, mm_size, ps),
+			       "buddy_init failed\n");
+
+	/*
+	 * Idea is to confine the test to the sub-range [0, 32K), which a 12K
+	 * contiguous request (rounded up to 16K) splits into two naturally
+	 * aligned 16K slots: [0, 16K) and [16K, 32K). We pin the first 4K page
+	 * of each slot ([0, 4K) and [16K, 20K)) so that neither aligned slot
+	 * can satisfy the rounded-up 16K allocation, yet the freed remainder
+	 * still leaves a contiguous 12K hole at offset 4K, which is page-aligned
+	 * but not 16K-aligned. A 12K contiguous+range allocation must therefore
+	 * fall back to stitching that span instead of returning -ENOSPC.
+	 */
+	KUNIT_ASSERT_FALSE_MSG(test,
+			       gpu_buddy_alloc_blocks(&mm, 0, ps, ps, ps,
+						      &pin_lo, 0),
+			       "failed to pin low page\n");
+	KUNIT_ASSERT_FALSE_MSG(test,
+			       gpu_buddy_alloc_blocks(&mm, 4 * ps, 5 * ps, ps,
+						      ps, &pin_hi, 0),
+			       "failed to pin high page\n");
+
+	/* No aligned 16K block is free; the range-aware fallback must stitch
+	 * the unaligned [ps, 4*ps) hole instead of returning -ENOSPC.
+	 */
+	KUNIT_ASSERT_FALSE_MSG(test,
+			       gpu_buddy_alloc_blocks(&mm, 0, range_end, 3 * ps,
+						      ps, &allocated,
+						      GPU_BUDDY_CONTIGUOUS_ALLOCATION |
+						      GPU_BUDDY_RANGE_ALLOCATION),
+			       "range-restricted contiguous alloc failed\n");
+
+	/* The result must be exactly 3*ps, contiguous, and inside the range. */
+	total = 0;
+	prev = NULL;
+	list_for_each_entry(block, &allocated, link) {
+		u64 offset = gpu_buddy_block_offset(block);
+		u64 bsize = gpu_buddy_block_size(&mm, block);
+
+		KUNIT_EXPECT_TRUE_MSG(test, offset + bsize <= range_end,
+				      "block [%llx, %llx) outside range\n",
+				      offset, offset + bsize);
+		if (prev)
+			KUNIT_EXPECT_EQ_MSG(test,
+					    gpu_buddy_block_offset(prev) +
+					    gpu_buddy_block_size(&mm, prev),
+					    offset,
+					    "block at %llx not contiguous\n",
+					    offset);
+		prev = block;
+		total += bsize;
+	}
+	KUNIT_EXPECT_EQ(test, total, 3 * ps);
+
+	gpu_buddy_free_list(&mm, &allocated, 0);
+	gpu_buddy_free_list(&mm, &pin_lo, 0);
+	gpu_buddy_free_list(&mm, &pin_hi, 0);
+	gpu_buddy_fini(&mm);
+}
+
 static void gpu_test_buddy_alloc_pathological(struct kunit *test)
 {
 	u64 mm_size, size, start = 0;
@@ -1534,10 +1605,13 @@ static void gpu_test_buddy_alloc_exceeds_max_order(struct kunit *test)
 				     GPU_BUDDY_RANGE_ALLOCATION);
 	KUNIT_EXPECT_EQ(test, err, -EINVAL);
 
-	/* CONTIGUOUS + RANGE should return -EINVAL (no try_harder for RANGE) */
-	err = gpu_buddy_alloc_blocks(&mm, 0, mm_size, size, SZ_4K, &blocks,
-				     GPU_BUDDY_CONTIGUOUS_ALLOCATION | GPU_BUDDY_RANGE_ALLOCATION);
-	KUNIT_EXPECT_EQ(test, err, -EINVAL);
+	/* CONTIGUOUS + RANGE should succeed via the range-aware try_harder */
+	KUNIT_ASSERT_FALSE_MSG(test, gpu_buddy_alloc_blocks(&mm, 0, mm_size, size,
+							    SZ_4K, &blocks,
+							    GPU_BUDDY_CONTIGUOUS_ALLOCATION |
+							    GPU_BUDDY_RANGE_ALLOCATION),
+			       "range contiguous alloc hit an error size=%llu\n", size);
+	gpu_buddy_free_list(&mm, &blocks, 0);
 
 	gpu_buddy_fini(&mm);
 }
@@ -1603,6 +1677,7 @@ static struct kunit_case gpu_buddy_tests[] = {
 	KUNIT_CASE(gpu_test_buddy_alloc_pessimistic),
 	KUNIT_CASE(gpu_test_buddy_alloc_pathological),
 	KUNIT_CASE(gpu_test_buddy_alloc_contiguous),
+	KUNIT_CASE(gpu_test_buddy_alloc_range_contiguous),
 	KUNIT_CASE(gpu_test_buddy_alloc_clear),
 	KUNIT_CASE(gpu_test_buddy_alloc_range),
 	KUNIT_CASE(gpu_test_buddy_alloc_range_bias),
-- 
2.43.0

