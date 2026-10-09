Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0DC5CA6019
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 10:06:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 734CB112013;
	Fri,  9 Oct 2026 10:06:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Q2aE2Ixv";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012030.outbound.protection.outlook.com [52.101.53.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54C6A112013;
 Fri,  9 Oct 2026 10:06:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xntMt/cJuHYHOHNm66hJC+lm36u/lTFmdXE/B9bNJxp9uDrsqwxX6bmyHJk0zacUZbjfLxcVNK8NkMkwovr1xKEC2KGt/JK6fl8NA72p2EBCfS4u/iSfgfq+i2jJkGukgQvc8k6hTt//eSuPJjFL9axNFD8qmkvwON2xGVTZ45EL4BwinnmFkFufT62Cu5npFG2MTTfTG7//SAO/PfOr+56PcTWhHHI8hC4toaZhOe2kTFStj/JG4er6tqPHHohv4U/SD8rJCttmEEM/0knYKBf4SDCNHwbkL3VtFTFGa9LE3ZtOEew0llwgxIeA2u4Irjy6bZNdWP3WGVDmYVNEpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=88u0o0eGuRA3vtkt0CEoB/+aC7fkYzuYga82+YgUFPA=;
 b=SnNC1ikZibgJxPr4Cv/Dbwo5tpahz5Y3jGo9Owsyt0Y4TKoewcvAn8ZHfwg+rEmmtCd9GPtzmGuozSKMyG/ZXVH9mSpzD8Q99ZrUUS5SZBUf2wW/CtNhGWVrT0qEI3IFUt2SaEYKt+Vd+3cvUoSk2szrdWRWrvEGYg0t0W1+Bhv0bTIVEahCmRc72F0ip8FH9yxjHr5ri+P0wgHjgsMtPhq42rX9tkj0ic2Hp2vVG48xQhx4pIMXmqf9w1nl425hKkeAi1Iz3TUNZ0O/+2PDfFiR1jGHjP41CAeE13qaQdViQOPLJtJqM/S13qUOzq+54ELjzegY2KTVJW5a+xM/PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=88u0o0eGuRA3vtkt0CEoB/+aC7fkYzuYga82+YgUFPA=;
 b=Q2aE2IxvjZWw6OKgQDqpBzULAaP3YsdJ9hPjNzuqIEcNZjTQuxtUasOzj1MEy/SbooEk121+/j+bde9zuS0gNAVJPzFBLR6CesfWELgvqTNQpznnGimmXk2wA9wRBcQMxnaeUHouYabSGBcIxWydCU5oCupcjEhCLmcgdJdSv00=
Received: from SA1P222CA0073.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2c1::23)
 by LV1PR12MB123218.namprd12.prod.outlook.com (2603:10b6:408:516::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Fri, 9 Oct
 2026 10:06:05 +0000
Received: from SA2PEPF00003F64.namprd04.prod.outlook.com
 (2603:10b6:806:2c1:cafe::9c) by SA1P222CA0073.outlook.office365.com
 (2603:10b6:806:2c1::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Fri, 9
 Oct 2026 10:06:05 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F64.mail.protection.outlook.com (10.167.248.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 9 Oct 2026 10:06:05 +0000
Received: from rtg-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 05:05:57 -0500
From: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
To: <matthew.auld@intel.com>, <dri-devel@lists.freedesktop.org>,
 <intel-gfx@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>,
 <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <Anand.Raghavendra@amd.com>, Arunpravin Paneer Selvam
 <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH v4 2/3] gpu/buddy: add range-restricted contiguous allocation
 fallback
Date: Fri, 9 Oct 2026 15:35:45 +0530
Message-ID: <20261009100546.1103622-2-arunpravin.paneerselvam@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261009100546.1103622-1-arunpravin.paneerselvam@amd.com>
References: <20261009100546.1103622-1-arunpravin.paneerselvam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F64:EE_|LV1PR12MB123218:EE_
X-MS-Office365-Filtering-Correlation-Id: c245e2c3-ea1d-4ddf-caba-08df25ecee71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|82310400026|1800799024|376014|6133799003|22082099003|18002099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 7C+klXVJgUQKS3oOCma2qdXFrR3k+vPXf0u9yf6+rLFHwYx2JeGlzNv6krgwsmw8QGGWVThNwq5b216AujxiO0RXbJs8+Iu4ctjWUFbgiIjI3HZEYZEmzeZolpmroAuKFMwvmWyF00K9ztwYbWdWiU/ydO33HG2+ZxmDREGfUGUitOfMQyYg15PE8rULHaIeAIL2Nl0r56SvFsWXer+481Tl1pMeqP9FyAeu5y9U69K0vmvTUbbJZACdn26gE2AGiv4tzzpzs/arFkepRqnLvGMgiAcMsMKgqQ3cMkE5Vihfhq+noX5Hq2GlRCTPazzw3iQggQjwTOS/GHE0qA0Xa3g1cAp83h3lZAEg4E9ITvZ7fjZFIqw93tclEuzZs6fhgYNyYdQ61AEMj+M7xiPvXaLQdSsKO15SrNC0JGzTO38mHrkpSH2dvJ8BvzbQUmWZHPiwT5h5PZdXikp7mhF/VTuil6gZkvkm0x+1TPKoAEDp992rckHa0Xo9D10tMqx8D7m1MLDIU1utcSTF1gzD3oRd3G/cR8vP25+z5hwzma0U0Oj+pfR/TD1wsmvDa50LYgMKs0sKSKXEsJ8LUdTcFdlxRFGeKSqP+ZXO3eqmqptC4S77iNRdjarnaJplU1FzmLjniv7bShAM6IvCeRMKJyAQGFZlzcUZ51ub6l8QnQjQiZjYiSj/fbzyeLuR1PiT6ilZ1Ggfmhmcj8xMpVk4ww==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(6133799003)(22082099003)(18002099003)(10067099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zvYaKHeQwT63HFcMDQUPle0kaX6tMQQMph6XysE3lnUZhjhOcFVWtgDXoBfUUX4jQ3oT1Bq3P3wKVv4dHvBCr4v+uXxgrqEhZ/A0p6FZijkcCKGFahOtDt1FyfTkDpw66KvFBVZrQlK4BDiu7CW9RRABLGa7aQZq0i2ACrR6gl1n7RFMaO8stxfXlzHqaD4PpqSNnHew0FqD1Su7mOgPKqAVmkWyHc933xSr7pVM7Ssl63YSzT6msidKDFjmee2TBeCd25oKvWST3NWkpYaJefVZcLd3OY2gCheGY3cDnsiAf29SV4rxm6gFhZDIr0obXQSr4q13Nxj5JWPbijNn3M11VKaLhA2eutjC8lXzgtBdmg5qT99tqUzvCziOW42+O11lL2NoeLcMhYDI5t8tzCceyj4vPGQjgNOSUUlAbP1k5vDEqpXEIGX8kNeXRtYA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 10:06:05.2210 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c245e2c3-ea1d-4ddf-caba-08df25ecee71
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR12MB123218
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
GPU_BUDDY_RANGE_ALLOCATION was set. Extend __alloc_contig_try_harder()
with a [range_start, range_end) window and route the range + contiguous
case through it: each candidate placement is confined to the window and
aligned to min_block_size. Non-range callers pass [0, mm->size), where
the guards are no-ops, so the existing behaviour is unchanged. A KUnit
test covers the fragmentation pattern.

v4:
 - As Matthew pointed out, the Fixes: tag did not fit this patch: it adds
   try-harder range support, a new safety-net feature rather than the fix.
   The root cause is __alloc_range_bias() losing its clear/dirty guard.

v3:
 - Confine the try_harder scan to [range_start, range_end) to avoid
   speculative out-of-window alloc/free.

v2:
 - Drop the split-undo patch; the range-bias search always descends to
   an exact-order block or fails the split (already handled), so the
   extra undo was redundant. (Matthew)

Assisted-by: LLM
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
---
 drivers/gpu/buddy.c                | 95 +++++++++++++++++-------------
 drivers/gpu/tests/gpu_buddy_test.c | 83 ++++++++++++++++++++++++--
 2 files changed, 133 insertions(+), 45 deletions(-)

diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
index 6566bad4fef1..1f648bcfce57 100644
--- a/drivers/gpu/buddy.c
+++ b/drivers/gpu/buddy.c
@@ -1682,26 +1682,14 @@ static int __gpu_buddy_alloc_range(struct gpu_buddy *mm,
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
@@ -1726,25 +1714,36 @@ static int __alloc_contig_try_harder(struct gpu_buddy *mm,
 
 		rhs_offset = gpu_buddy_block_offset(block);
 
+		if (rhs_offset >= range_end) {
+			iter = rb_prev(iter);
+			continue;
+		}
+		if (rhs_offset < range_start)
+			break;
+
 		/* Allocate blocks traversing RHS */
 		err =  __gpu_buddy_alloc_range(mm, rhs_offset, size,
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
@@ -1756,15 +1755,17 @@ static int __alloc_contig_try_harder(struct gpu_buddy *mm,
 
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
@@ -2018,11 +2019,18 @@ int gpu_buddy_alloc_blocks(struct gpu_buddy *mm,
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
@@ -2055,9 +2063,14 @@ int gpu_buddy_alloc_blocks(struct gpu_buddy *mm,
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
@@ -2065,9 +2078,9 @@ int gpu_buddy_alloc_blocks(struct gpu_buddy *mm,
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
index 3eaa261571bf..ec37c11877ed 100644
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
@@ -1667,6 +1741,7 @@ static struct kunit_case gpu_buddy_tests[] = {
 	KUNIT_CASE(gpu_test_buddy_alloc_pessimistic),
 	KUNIT_CASE(gpu_test_buddy_alloc_pathological),
 	KUNIT_CASE(gpu_test_buddy_alloc_contiguous),
+	KUNIT_CASE(gpu_test_buddy_alloc_range_contiguous),
 	KUNIT_CASE(gpu_test_buddy_alloc_clear),
 	KUNIT_CASE(gpu_test_buddy_alloc_range),
 	KUNIT_CASE(gpu_test_buddy_alloc_range_bias),
-- 
2.43.0

