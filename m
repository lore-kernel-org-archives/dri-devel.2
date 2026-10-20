Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BFD606A319
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 05:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=adfhWPZx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5403010F234;
	Tue, 20 Oct 2026 05:56:13 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010039.outbound.protection.outlook.com [52.101.201.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1C5410E9E3;
 Tue, 20 Oct 2026 05:56:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H/hmm4VGs9NOnGHGGwgDz4voV07GEfQsCbGWt2LfzbQ0u5xUdlRZepZ5AXWRxK/KlmPt0CSxcxwICRk3PRlgRsxUSTKcKHfwbxxoJOcEM+udAUY2f0aJfBRHAdp6wCMUskXys0p11Kd1BAblIi9kqEXosOa0fTKWlb3DFCLS6X/hBCDFeH/cJHFbpHUJErC0B9dhsAUeH9ZT6n9ggFz1+asINwTASqaEhpNAb9+0N+1S9hDoYVGopsW7QPeFczNHY7nVEIvlt8MiCpnc0fv7DVnT+nc/TfKbjUqcOQZX7PkZKMz2YPtwy/lktNQwC0OSaqT9hWu6q6/QKhoxs32IbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gcK1jmEGYsc2hxwwmYKXMIqv0rM+945UmLq+MdYWkJI=;
 b=aEShOQYZ5zaov4oQs36vcNHwpmi6eFYEcnzze4csRElIf9KBUvv6dcOqmUSf4hXK/CjsZavdamt0oOE+5+MJFfGuTYx+u605nsjLfAHxpeuLvYmqGdYNnLXyAi6RrCIERK8a71bOS5HTkjE8acC/hvFtUDaLXDZSmoj74gAzLyWIAtaHUxPhziRKrmtqwmxyyvOz1s0do2a9LJW1bVP/RSTdKCkn4AbogykLVz0TP/bOkLBHoMi9XRPu+PO1Wp8oefXpBTdkW/3LXdOFgeAUQk/ySrm1c9C9t2cbC5sIjsgDI7VOESkhxPRnr/KYZjdVyUTmbVYa8Ev8+ciz/qpIeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gcK1jmEGYsc2hxwwmYKXMIqv0rM+945UmLq+MdYWkJI=;
 b=adfhWPZxt+tjOYuUCPmVlxZaDcNEFj2F4UJB7WrTkQrk/NY7xHrlZ4MkKA2Y6cfIFRVbhMmudIHq4FTBpBe9gZ/63DNDdTn2w0oC42iShVWcDiiXscCmKwoczxFf9z7hVKGvGMXx/oyhsTJJVmK0YqEztzx2NmsYr16wORdEqwo=
Received: from CH2PR04CA0027.namprd04.prod.outlook.com (2603:10b6:610:52::37)
 by PH8PR12MB6723.namprd12.prod.outlook.com (2603:10b6:510:1ce::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.18; Tue, 20 Oct
 2026 05:55:57 +0000
Received: from DS8PEPF000000E3.namprd05.prod.outlook.com
 (2603:10b6:610:52:cafe::41) by CH2PR04CA0027.outlook.office365.com
 (2603:10b6:610:52::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.19 via Frontend Transport; Tue,
 20 Oct 2026 05:55:57 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS8PEPF000000E3.mail.protection.outlook.com (10.167.23.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 20 Oct 2026 05:55:57 +0000
Received: from rtg-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Tue, 20 Oct 2026 00:55:54 -0500
From: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
To: <matthew.auld@intel.com>, <dri-devel@lists.freedesktop.org>,
 <intel-gfx@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>,
 <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <Anand.Raghavendra@amd.com>, Arunpravin Paneer Selvam
 <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH v5 2/2] gpu/buddy: add range-restricted contiguous allocation
 fallback
Date: Tue, 20 Oct 2026 11:25:37 +0530
Message-ID: <20261020055537.1640552-2-arunpravin.paneerselvam@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261020055537.1640552-1-arunpravin.paneerselvam@amd.com>
References: <20261020055537.1640552-1-arunpravin.paneerselvam@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS8PEPF000000E3:EE_|PH8PR12MB6723:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f83ab55-1919-44ad-d4d9-08df2e6ecf7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|23010399003|36860700016|56012099006|11063799006|261009223027099003|10067099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: e1brSBCdNELDSMXNLTTX71Xz9HmsH3oRhmPQeye8H/+hKFrgE0QZO1ZokzJH2sHdFM5x+WQrpU/Ind0phEGg6jfhGkUNUuGSH1qdXY5pZuw6owjdBTpc8oz3tHuZ6ThoddbI2rQX/2i3wXUQxYiD4F5yu7HLtKzbX1Y3ufb3YxSOxg9xYlIlEwIIYxsH26+fGvbWYybCw1n/gNorSKbPRaTZQUIUIJNYwxdb0JCTZrz5HNdr0tU4qevsXEBt447tACBR1d8EpRX7RIhYcUwlMXuPnEf4lyXaGL2Y1aUIrqn6ThQC8tvnN6BrPSA352KGK6ae24BznmmFGq38w6Px2bMnDyyxXS//UcjdG/O7zR/mB/Nt4LDYLO/eTbNWBInCMGTSlQ1fHmNNWK2fSRtr5bXYRklONly7Doc3Sv8hfQi4yqLAM9ZaS9zAFkc0okzsJqL2WIcJQHQ0/bjt8+Q6EdCcCx5/gCXNuEpADAfZWGPT5HH/2U23enw3PUacDZTXli4zmBnPpfZr4A9pUgX4g/Kc9iHHkFNTguT3XExdOHbgl7MhxFLxeI04S1Cd1QHRQaUXf8GWgi0AOAreF+KzZBs1NrYAJ/AF3THwey9lva6d7IAohTFwd3SigueNNtSPbnTHmFHIWFpqLHZXJhMCPiDt0Idi0C6V9FvfBqiLefVMX3jq8mhFZb5cWDawLMqKN8VHAuVr+YTaVQNQqy/Z0w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(23010399003)(36860700016)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xOc5/1J2UgRtOFsun4LtEsLRdX6BmeFwuVAB82VyjvSKCMWkb9mE6207PcAtqEL3UbhzJzGPR3rJDDfSWFxpx+6IAhSq2SDVuuAiJ5E7WTY5TCIIiOJ56BQlR+vs9qT9dYac8oW50SCZfCli+mbL+lWmTMQJHNYIqC+uQRvt7SDKBeym6PwECmf6xXV6FcJT+13DtF8rGM3tY8jDzq0QwiTUV1ij/uWi01MtJ+2eqbO9bMKO5nA9gZtHejes8BVTy0kJY9Y9hjOWqcWNf+K0VoiUkDxMdGF5biW1HCDlv7z6QF5aYiLB9AfAyV3xOdc6yHP+4naEeVZwm9EyeOhR1zGqHWHF5IYMcPJvbCTR0Fl8Z7sK39fr2GPTzvIRZUEProx40rEqwmgMg24DuPn9RjUsNdYXT3Rk4O6pc6L2k4ihu5jN5mgTA+6iYJvSNFp5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 05:55:57.1649 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f83ab55-1919-44ad-d4d9-08df2e6ecf7f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS8PEPF000000E3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6723
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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

v5: make the windowed try-harder search complete so it no longer returns
    a spurious -ENOSPC while a valid placement exists:
 - Descend through the lower orders instead of bailing out at the
   requested order, so smaller free blocks are still considered.
 - Clamp an out-of-range full fill back to range_end so the leftward
   shift re-seats the span inside the window (reported by Sashiko).
 - Add a final sweep of every min_block_size-aligned offset in the
   window, catching a placement inside a larger coalesced block
   (reported by Sashiko).

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
 drivers/gpu/buddy.c                | 131 ++++++++++++-------
 drivers/gpu/tests/gpu_buddy_test.c | 201 ++++++++++++++++++++++++++++-
 2 files changed, 283 insertions(+), 49 deletions(-)

diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
index 91935c71c525..ffa63ecaf235 100644
--- a/drivers/gpu/buddy.c
+++ b/drivers/gpu/buddy.c
@@ -1682,43 +1682,32 @@ static int __gpu_buddy_alloc_range(struct gpu_buddy *mm,
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
+	unsigned int min_order, order;
 	struct rb_root *root;
 	struct rb_node *iter;
 	unsigned long pages;
-	unsigned int order;
 	u64 modify_size;
 	int err;
 
+	min_order = ilog2(min_block_size) - ilog2(mm->chunk_size);
+
 	modify_size = rounddown_pow_of_two(size);
 	pages = modify_size >> ilog2(mm->chunk_size);
 	order = fls(pages) - 1;
-	if (order == 0)
-		return -ENOSPC;
 
+retry_order:
 	root = &mm->free_tree[order];
 	if (RB_EMPTY_ROOT(root))
-		return -ENOSPC;
+		goto next_order;
 
 	iter = rb_last(root);
 	while (iter) {
@@ -1726,25 +1715,42 @@ static int __alloc_contig_try_harder(struct gpu_buddy *mm,
 
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
+		if (!err && rhs_offset + size > range_end) {
+			gpu_buddy_free_list_internal(mm, blocks);
+			filled = range_end - rhs_offset;
+			err = -ENOSPC;
+		}
+		if (!err && IS_ALIGNED(rhs_offset, min_block_size) &&
+		    rhs_offset >= range_start && rhs_offset + size <= range_end)
 			return 0;
+
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
@@ -1756,21 +1762,44 @@ static int __alloc_contig_try_harder(struct gpu_buddy *mm,
 
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
 		iter = rb_prev(iter);
 	}
 
+next_order:
+	if (order > min_order) {
+		order--;
+		goto retry_order;
+	}
+
+	/*
+	 * Last resort: sweep every aligned offset in the window and let
+	 * __gpu_buddy_alloc_range() carve the span from a larger covering block.
+	 */
+	for (aligned = round_up(range_start, min_block_size);
+	     aligned + size <= range_end;
+	     aligned += min_block_size) {
+		err = __gpu_buddy_alloc_range(mm, aligned, size, flags, NULL, blocks);
+		if (!err)
+			return 0;
+		gpu_buddy_free_list_internal(mm, blocks);
+		if (err != -ENOSPC)
+			return err;
+	}
+
 	return -ENOSPC;
 }
 
@@ -2018,11 +2047,18 @@ int gpu_buddy_alloc_blocks(struct gpu_buddy *mm,
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
@@ -2055,9 +2091,14 @@ int gpu_buddy_alloc_blocks(struct gpu_buddy *mm,
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
@@ -2065,9 +2106,9 @@ int gpu_buddy_alloc_blocks(struct gpu_buddy *mm,
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
index 3eaa261571bf..504910559e6c 100644
--- a/drivers/gpu/tests/gpu_buddy_test.c
+++ b/drivers/gpu/tests/gpu_buddy_test.c
@@ -1251,6 +1251,130 @@ static void gpu_test_buddy_alloc_contiguous(struct kunit *test)
 	gpu_buddy_fini(&mm);
 }
 
+/*
+ * Issue a range-restricted contiguous request and assert that it returns an
+ * exact-size, contiguous span confined to [range_start, range_end). Frees the
+ * allocation before returning; the caller owns mm init/fini and any pins.
+ */
+static void check_contig_range_alloc(struct kunit *test, struct gpu_buddy *mm,
+				     u64 range_start, u64 range_end,
+				     u64 size, u64 min, const char *shape)
+{
+	struct gpu_buddy_block *block, *prev;
+	LIST_HEAD(allocated);
+	u64 total;
+
+	KUNIT_ASSERT_FALSE_MSG(test,
+			       gpu_buddy_alloc_blocks(mm, range_start, range_end,
+						      size, min, &allocated,
+						      GPU_BUDDY_CONTIGUOUS_ALLOCATION |
+						      GPU_BUDDY_RANGE_ALLOCATION),
+			       "%s: range-restricted contiguous alloc failed\n",
+			       shape);
+
+	total = 0;
+	prev = NULL;
+	list_for_each_entry(block, &allocated, link) {
+		u64 offset = gpu_buddy_block_offset(block);
+		u64 bsize = gpu_buddy_block_size(mm, block);
+
+		KUNIT_EXPECT_TRUE_MSG(test, offset >= range_start &&
+				      offset + bsize <= range_end,
+				      "%s: block [%llx, %llx) outside range\n",
+				      shape, offset, offset + bsize);
+		if (prev)
+			KUNIT_EXPECT_EQ_MSG(test,
+					    gpu_buddy_block_offset(prev) +
+					    gpu_buddy_block_size(mm, prev),
+					    offset,
+					    "%s: block at %llx not contiguous\n",
+					    shape, offset);
+		prev = block;
+		total += bsize;
+	}
+	KUNIT_EXPECT_EQ_MSG(test, total, size, "%s: wrong total size\n", shape);
+
+	gpu_buddy_free_list(mm, &allocated, 0);
+}
+
+static void gpu_test_buddy_alloc_range_contiguous(struct kunit *test)
+{
+	const unsigned long ps = SZ_4K;
+	struct gpu_buddy mm;
+	LIST_HEAD(pin_lo);
+	LIST_HEAD(pin_hi);
+	LIST_HEAD(barrier);
+
+	/*
+	 * Feature: confine a 12K contiguous request (rounded up to 16K) to
+	 * [0, 32K), which splits into two naturally aligned 16K slots. Pin the
+	 * first page of each ([0, 4K) and [16K, 20K)) so neither slot can
+	 * satisfy the rounded-up 16K alloc, yet a contiguous but 16K-unaligned
+	 * 12K hole remains at offset 4K. The fallback must stitch that hole
+	 * instead of returning -ENOSPC.
+	 */
+	KUNIT_ASSERT_FALSE_MSG(test, gpu_buddy_init(&mm, 16 * ps, ps),
+			       "buddy_init failed\n");
+	KUNIT_ASSERT_FALSE_MSG(test,
+			       gpu_buddy_alloc_blocks(&mm, 0, ps, ps, ps,
+						      &pin_lo, 0),
+			       "failed to pin low page\n");
+	KUNIT_ASSERT_FALSE_MSG(test,
+			       gpu_buddy_alloc_blocks(&mm, 4 * ps, 5 * ps, ps,
+						      ps, &pin_hi, 0),
+			       "failed to pin high page\n");
+	check_contig_range_alloc(test, &mm, 0, 8 * ps, 3 * ps, ps, "feature");
+	gpu_buddy_free_list(&mm, &pin_lo, 0);
+	gpu_buddy_free_list(&mm, &pin_hi, 0);
+	gpu_buddy_fini(&mm);
+
+	/*
+	 * Higher-order: an empty arena coalesces all free
+	 * space into one high-order block, so the anchored search finds no
+	 * block at or below the derived order inside [4K, 20K). The allocator
+	 * must still carve the 12K span out of the larger block.
+	 */
+	KUNIT_ASSERT_FALSE_MSG(test, gpu_buddy_init(&mm, 8 * ps, ps),
+			       "buddy_init failed\n");
+	check_contig_range_alloc(test, &mm, ps, 5 * ps, 3 * ps, ps,
+				 "higher_order");
+	gpu_buddy_fini(&mm);
+
+	/*
+	 * Beyond range_end: pin [8K, 16K) and leave
+	 * [16K, 32K) free, so the only fit inside [12K, 28K) is [16K, 28K) with
+	 * a free page spilling past range_end. The tail coalesces above the
+	 * derived order, so the request must still land on [16K, 28K).
+	 */
+	KUNIT_ASSERT_FALSE_MSG(test, gpu_buddy_init(&mm, 8 * ps, ps),
+			       "buddy_init failed\n");
+	KUNIT_ASSERT_FALSE_MSG(test,
+			       gpu_buddy_alloc_blocks(&mm, 2 * ps, 4 * ps,
+						      2 * ps, ps, &barrier, 0),
+			       "failed to pin barrier\n");
+	check_contig_range_alloc(test, &mm, 3 * ps, 7 * ps, 3 * ps, ps,
+				 "beyond_end");
+	gpu_buddy_free_list(&mm, &barrier, 0);
+	gpu_buddy_fini(&mm);
+
+	/*
+	 * Left shift: pin [28K, 32K) and leave [0, 28K) free. For a 12K request
+	 * in [4K, 20K) the anchored search fills rightward to [16K, 28K), a full
+	 * fill ending past range_end. The overshoot must be clamped so the
+	 * leftward shift finds the valid placement [8K, 20K).
+	 */
+	KUNIT_ASSERT_FALSE_MSG(test, gpu_buddy_init(&mm, 8 * ps, ps),
+			       "buddy_init failed\n");
+	KUNIT_ASSERT_FALSE_MSG(test,
+			       gpu_buddy_alloc_blocks(&mm, 7 * ps, 8 * ps,
+						      ps, ps, &barrier, 0),
+			       "failed to pin barrier\n");
+	check_contig_range_alloc(test, &mm, ps, 5 * ps, 3 * ps, ps,
+				 "left_shift");
+	gpu_buddy_free_list(&mm, &barrier, 0);
+	gpu_buddy_fini(&mm);
+}
+
 static void gpu_test_buddy_alloc_pathological(struct kunit *test)
 {
 	u64 mm_size, size, start = 0;
@@ -1534,10 +1658,13 @@ static void gpu_test_buddy_alloc_exceeds_max_order(struct kunit *test)
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
@@ -1586,6 +1713,70 @@ static void gpu_test_buddy_addr_to_block(struct kunit *test)
 	gpu_buddy_fini(&mm);
 }
 
+static void gpu_test_buddy_alloc_contiguous_descent(struct kunit *test)
+{
+	const unsigned long ps = SZ_4K, mm_size = 16 * ps;
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
+	 * Pin [0, 16K) and [48K, 64K). The remaining [16K, 48K) is free as two
+	 * adjacent 16K halves under different parents; being un-mergeable
+	 * buddies they never coalesce, so free_tree[3] (32K) stays empty. A
+	 * contiguous 32K request with min_block_size 4K therefore has no 32K
+	 * anchor and must descend to order 2 and stitch [16K, 48K).
+	 */
+	KUNIT_ASSERT_FALSE_MSG(test,
+			       gpu_buddy_alloc_blocks(&mm, 0, 4 * ps, 4 * ps,
+						      ps, &pin_lo, 0),
+			       "failed to pin low block\n");
+	KUNIT_ASSERT_FALSE_MSG(test,
+			       gpu_buddy_alloc_blocks(&mm, 12 * ps, 16 * ps,
+						      4 * ps, ps, &pin_hi, 0),
+			       "failed to pin high block\n");
+
+	KUNIT_ASSERT_FALSE_MSG(test,
+			       gpu_buddy_alloc_blocks(&mm, 0, mm_size, 8 * ps,
+						      ps, &allocated,
+						      GPU_BUDDY_CONTIGUOUS_ALLOCATION),
+			       "contiguous alloc failed to descend\n");
+
+	/* The result must be exactly 8*ps, contiguous, within [16K, 48K). */
+	total = 0;
+	prev = NULL;
+	list_for_each_entry(block, &allocated, link) {
+		u64 offset = gpu_buddy_block_offset(block);
+		u64 bsize = gpu_buddy_block_size(&mm, block);
+
+		KUNIT_EXPECT_TRUE_MSG(test, offset >= 4 * ps &&
+				      offset + bsize <= 12 * ps,
+				      "block [%llx, %llx) outside stitched span\n",
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
+	KUNIT_EXPECT_EQ(test, total, 8 * ps);
+
+	gpu_buddy_free_list(&mm, &allocated, 0);
+	gpu_buddy_free_list(&mm, &pin_lo, 0);
+	gpu_buddy_free_list(&mm, &pin_hi, 0);
+	gpu_buddy_fini(&mm);
+}
+
 static int gpu_buddy_suite_init(struct kunit_suite *suite)
 {
 	while (!random_seed)
@@ -1667,6 +1858,8 @@ static struct kunit_case gpu_buddy_tests[] = {
 	KUNIT_CASE(gpu_test_buddy_alloc_pessimistic),
 	KUNIT_CASE(gpu_test_buddy_alloc_pathological),
 	KUNIT_CASE(gpu_test_buddy_alloc_contiguous),
+	KUNIT_CASE(gpu_test_buddy_alloc_range_contiguous),
+	KUNIT_CASE(gpu_test_buddy_alloc_contiguous_descent),
 	KUNIT_CASE(gpu_test_buddy_alloc_clear),
 	KUNIT_CASE(gpu_test_buddy_alloc_range),
 	KUNIT_CASE(gpu_test_buddy_alloc_range_bias),
-- 
2.43.0

