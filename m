Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DA2606A331
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 20:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=JYrTEAiW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D75710E60F;
	Wed, 18 Nov 2026 20:17:29 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012036.outbound.protection.outlook.com
 [40.93.195.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05B1E10E60F;
 Wed, 18 Nov 2026 20:17:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RzPcD0CwJeaPHQK7RvoE9rgg5Q4edGPlC2Q+qLsZFbXSwj5tkhtdRyJYpWuYg8hf1KHflU23JowVHxhe+BEk1BxM4u4RgvLM98NqaSspbePuyCgmuts0dZGPQfRTBVo3lwhLCgFRhrgpT9hnI7Nna0aRib7Aswk6udMPIp5RD+wf8Dq+sToVw6j2YUFNsHrHiYGP/y+i+UI9XPa79FyLS/1tLwOKkZpvNH5la7G5kk694PUnxeBZTLAdpPSIs1/fer0HBoE4lUK0VvtUtKPgz4cJHre50zRZ6IHe4jtlJhWinSqI0FRNAEFDcir7taijLD7S6vqtPSxFPLQcvYvwBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EJbbTcnJeRyIA1O3tjjrikw3WZfNSuheDhVkP9cKOgI=;
 b=r0Q6vjqsYUWb1IQd1+qCNwCkUgJR09Jt4E8Bxgqs5al5gMl2Tlt6XNRYxvR950Dw6CEFxdTjQQSoObG9VaIl0dAfaTrfArSMOsaiLAUqprwqvcPYnsM8w60dK30CIYROH8GkXGfJtSHBoBIjBXSvr373tdw0b0KPi3fcD2POSoep1QC4X1f5yRE1BxEsoaY+HIbWAdqc7IWtXL4gibn4NJgRYXOia//VkUHBvoEEIEkFyUiZod7O0hgo4rY1X0Srbyw/xzSwZN9NyQCUpCxxwgxFclTU8swSw0+fJx3QsR3ExZR6fYKa6KR1/deLAXE408OdJC2VBRgsgH8UPnfUzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EJbbTcnJeRyIA1O3tjjrikw3WZfNSuheDhVkP9cKOgI=;
 b=JYrTEAiWQhPVgMtfNCBQAEWyBZsiTxSvCYPZqkWP2R0PEPVquTDHNh7LTGPXl6Q4IBXMtshd3G+rbApUnAV9yZxdDhmKamnjlol1EwZ/7IgxOxCbJwSxh0iaM+UwvKNb9ZAqwdY98PcuJ5u0N/wzAHjcZngTPWd7TQwRDRmQI8g=
Received: from CH0PR03CA0394.namprd03.prod.outlook.com (2603:10b6:610:11b::28)
 by DM6PR12MB4452.namprd12.prod.outlook.com (2603:10b6:5:2a4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 20:17:18 +0000
Received: from CH2PEPF000166BF.namprd04.prod.outlook.com
 (2603:10b6:610:11b:cafe::2f) by CH0PR03CA0394.outlook.office365.com
 (2603:10b6:610:11b::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Wed,
 18 Nov 2026 20:17:18 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF000166BF.mail.protection.outlook.com (10.167.252.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 18 Nov 2026 20:17:18 +0000
Received: from alysaliu-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 18 Nov
 2026 14:17:17 -0600
From: William Palacek <William.Palacek@amd.com>
To: <dri-devel@lists.freedesktop.org>
CC: <intel-xe@lists.freedesktop.org>, Matthew Auld <matthew.auld@intel.com>,
 Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>, Sanjay Yadav
 <sanjay.kumar.yadav@intel.com>, Joel Fernandes <joelagnelf@nvidia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 <linux-kernel@vger.kernel.org>, William Palacek <William.Palacek@amd.com>
Subject: [PATCH v4 1/3] gpu/buddy: find range-biased blocks in the free trees
Date: Wed, 18 Nov 2026 15:16:59 -0500
Message-ID: <2231189efdaf3e3dc8213d5858c1176fd43b9011.1795032989.git.William.Palacek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1795032989.git.William.Palacek@amd.com>
References: <cover.1795032989.git.William.Palacek@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF000166BF:EE_|DM6PR12MB4452:EE_
X-MS-Office365-Filtering-Correlation-Id: 18a08ca0-0851-4406-c041-08df45b0f1cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|1800799024|376014|36860700016|261009223027099003|18002099003|22082099003|261022075727099003|261026121527099003|261021123027099003|261021121427099003|261028144727099003|261022105027099003|261102123227099003|56012099006|261026140227099003|10067099003|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info: QuwGkuZeu0UVrabDC2B6myro41DBFYkHiunGkG+2RY++rTJBgOgLiz7Ps7NU6Z/NZvrk485tGqESkHNBsewh2muSmYYSSRJkddHh4/wJiyNHk54OPiRCZTazsv+KlRg2x0UFSmQpT0m547XIUooKV6NA2G7axnh8zOgRuaQsP3dAgn0QexM2SFoGtuYP93FBfGbTcB+ktfLaoRTR0FiMN11TP5PdLDWjEogtPd+tETxm05MrNW2X/T5qjQIREtTc4N3iAoL1qklzyBWi2QeDmlXyGSQuJWD41N5bwrQM8skFIm8ZJN2/FNj5BpNF0YOh/6O2338fibMOZzZSJ/EWji5zSo9fUhPwhOb/s09PrCcBHn7TV20VWQoYN+ChByDVTcR/PQHw1Hrz5Wr+tDytkKudX+IqOY+Q34OKRimI6jf/z74RfVRXz8pXuRgK7z0hHPEITGYgCVcCgPY4881PdGm9ljVWpPZZBaGxJ+VqkraMFmKPMhZNorNRr3I+O2mLWACsdttPbkl9RoEs64V4CcBYK+AofVtPjng7QenoMInf4/X7fy8sJ+Srkvx7/mkanOfzQUsQqKqPuuVTpMm67GS+1yejAoD8AeYp6P9zb/Ygf8/Kh9fGLYpcGetTWWEEaK4aDiOFae+bDxpAVwLzEoymDFWPicPo1HVWUL3+f84CaH6VZFSr8KShdejsCBoQR+cOgyFic33dgNaiyfeiWQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(1800799024)(376014)(36860700016)(261009223027099003)(18002099003)(22082099003)(261022075727099003)(261026121527099003)(261021123027099003)(261021121427099003)(261028144727099003)(261022105027099003)(261102123227099003)(56012099006)(261026140227099003)(10067099003)(5023799004)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ltm/69KWlp4NrS4AH6XKGJ3jMhXB/BI0wJxfVDc/LHGBKQURWwev4lWWfKO4z8ONcz/4kcosDm7zeSk+B8ef7BuuMKgKW6XqpAQqBGgE2s/T8JLvJLiChZZfE/t/U9iXA5x8bVHhM8WVul2J/oL4mn5zPhQtMDuK4NxjRNI+ligyRT1JBa22sRauqwYxPTafAdTPdc8chAp9LMTuQm7uhakqoMKNRtkt1FCaX+k1G7HyzN6/wnUNgyHQ4f8VhfoQ6iBzPF0SThnHpEbd4WlcRhrZfKucPZqKhdNgBozt7QZAQSCfKuS4UmwftVePI/3YEKmmLZ/2Jmp4xQrlWcPKftLQ/LVwCz1BR17RW741gC/EdL5TsEZ8lPxDLTIa5NwFY5TNCYvI4dzFN17UYOdCtID5YchSCQyCNt2Uv96t9F398pQRNiqRkBDtkIq6A98M
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 20:17:18.2849 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18a08ca0-0851-4406-c041-08df45b0f1cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF000166BF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4452
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

__alloc_range_bias() walks the block tree from the roots. Subtrees
without a free block of the requested order or larger are skipped, but
the strict pass still descends to every free block of the other class
in the range: a dirty request in a range holding many free cleared
blocks visits each of them, and their split ancestors, before it finds
dirty space. amdgpu takes this path for every VRAM allocation when
memory is partitioned (NPS2/NPS4), as each BO is restricted to its
partition's range.

The free trees are sorted by offset, so find the block there instead.
For each order from the requested one up, look up the highest free
block below the range end, step down the tree to the highest one that
can hold the request, and split the highest of them down to the
requested order. The two passes keep the clear/dirty guard: the strict
pass only takes blocks wholly inside the range whose class suits the
request, the fallback pass takes either class and may split a block
straddling the range edge. A clear request without
GPU_BUDDY_TOPDOWN_ALLOCATION first takes the highest clear block in the
range, using subtree_block_state to skip subtrees without one; above the
requested order only wholly-clear blocks are split for it. The walk is
gone.

With 8192 free cleared 64 KiB blocks interleaved with allocated ones in
the range, 4096 dirty range allocations take 402 to 407 ms before and
97 to 145 ms after (KUnit, UML, two runs).

Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Cc: Sanjay Yadav <sanjay.kumar.yadav@intel.com>
Signed-off-by: William Palacek <William.Palacek@amd.com>
---

Notes:
    v4:
    - rebased onto Sanjay's "gpu/buddy: Prune exhausted subtrees in
      range-biased allocation" (5880b69a0b76); patch 2 drops
      subtree_max_free_order, which nothing reads after this patch
    - based on Arun's range guard code: a clear request without
      GPU_BUDDY_TOPDOWN_ALLOCATION first takes the highest clear block in
      the range (Arun)
    - that search stops at the first match instead of scoring every clear
      block, so rbtree_pick_best_class() goes away (Arun)
    - drop the subtree_has_dirty augment; dirty requests step down past
      free clear blocks instead (Arun)
    - return -ENOSPC for start >= end instead of looking up outside the
      range (sashiko)
    - the strict pass always runs, as in Arun's guard code; the one-class
      shortcut from cb0a63f0c96e is dropped (Arun)
    
    v3:
    - rebased onto the merged clear/dirty guard (cb0a63f0c96e) (Arun)
    - take Arun's free-tree lookup and drop the walk instead of narrowing it
      (Arun)
    - strict pass O(log n) for both classes: subtree_block_state for clear
      requests, new subtree_has_dirty augment for dirty ones
    - placement now matches the walk exactly, including the guard
    
    v2:
    - rebased onto drm-misc-next (single free tree) (Arun)
    - take the highest contained block, keeping top-down placement (Arun)

 drivers/gpu/buddy.c | 295 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 220 insertions(+), 75 deletions(-)

diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
index a1e9f5ebe05a..26af5428ff76 100644
--- a/drivers/gpu/buddy.c
+++ b/drivers/gpu/buddy.c
@@ -628,6 +628,26 @@ rbtree_last_free_block(struct rb_root *root)
 	return rbtree_get_free_block(rb_last(root));
 }
 
+/* Return the highest free block with lo <= offset <= hi. */
+static struct gpu_buddy_block *
+rbtree_last_free_block_in(struct rb_root *root, u64 lo, u64 hi)
+{
+	struct gpu_buddy_block *block, *last = NULL;
+	struct rb_node *node = root->rb_node;
+
+	while (node) {
+		block = rbtree_get_free_block(node);
+		if (gpu_buddy_block_offset(block) > hi) {
+			node = node->rb_left;
+		} else {
+			last = block;
+			node = node->rb_right;
+		}
+	}
+
+	return last && gpu_buddy_block_offset(last) >= lo ? last : NULL;
+}
+
 static struct gpu_buddy_block *
 rbtree_last_clear_free_block(struct rb_root *root,
 			     enum gpu_block_state min_block_state)
@@ -666,6 +686,51 @@ rbtree_last_clear_free_block(struct rb_root *root,
 	return block;
 }
 
+static struct gpu_buddy_block *
+rbtree_range_best_block(struct rb_root *root, u64 lo, u64 hi,
+			enum gpu_block_state min_state)
+{
+	struct rb_node *node = root->rb_node;
+	struct gpu_buddy_block *best = NULL;
+	struct rb_node *prev = NULL;
+
+	while (node) {
+		struct gpu_buddy_block *block = rbtree_get_free_block(node);
+		bool pruned = block->subtree_block_state < min_state;
+		u64 off = gpu_buddy_block_offset(block);
+		bool desc_right = !pruned && off <= hi;
+		bool desc_left = !pruned && off >= lo;
+		struct rb_node *next;
+
+		if (prev == rb_parent(node) && desc_right && node->rb_right) {
+			/* First visit: higher offsets first. */
+			next = node->rb_right;
+		} else if (prev && prev == node->rb_left) {
+			next = rb_parent(node);
+		} else {
+			/* Right subtree done: score this node, then go left. */
+			if (!pruned && off >= lo && off <= hi &&
+			    gpu_block_cached_state(block) >= min_state) {
+				if (gpu_block_cached_state(block) == GPU_BLOCK_CLEAR)
+					return block;
+				/* Highest mixed block; only a clear one beats it. */
+				best = block;
+				min_state = GPU_BLOCK_CLEAR;
+			}
+
+			if (desc_left && node->rb_left)
+				next = node->rb_left;
+			else
+				next = rb_parent(node);
+		}
+
+		prev = node;
+		node = next;
+	}
+
+	return best;
+}
+
 static void rbtree_insert(struct gpu_buddy *mm,
 			  struct gpu_buddy_block *block)
 {
@@ -1274,94 +1339,185 @@ static bool block_incompatible(struct gpu_buddy_block *block, unsigned int flags
 }
 
 static struct gpu_buddy_block *
-__alloc_range_bias(struct gpu_buddy *mm,
-		   u64 start, u64 end,
-		   unsigned int order,
-		   unsigned long flags,
-		   bool fallback)
+__alloc_range_clear_block(struct gpu_buddy *mm,
+			  u64 start, u64 end,
+			  unsigned int order,
+			  unsigned long flags)
 {
-	u64 req_size = mm->chunk_size << order;
 	struct gpu_buddy_block *block;
-	LIST_HEAD(dfs);
+	unsigned int tmp;
 	int err;
-	int i;
-
-	end = end - 1;
 
-	/*
-	 * This range-constrained search hands back the highest/right-most
-	 * address that satisfies the request: the roots are seeded high-to-low
-	 * and the right (higher-address) child is descended first, making
-	 * top-down the default placement here.
-	 */
-	for (i = mm->n_roots - 1; i >= 0; --i)
-		list_add_tail(&mm->roots[i]->tmp_link, &dfs);
+	/* Only clear, non-top-down requests benefit from class navigation. */
+	if (!(flags & GPU_BUDDY_CLEAR_ALLOCATION) ||
+	    (flags & GPU_BUDDY_TOPDOWN_ALLOCATION))
+		return NULL;
 
-	do {
-		u64 block_start;
-		u64 block_end;
+	for (tmp = order; tmp <= mm->max_order; ++tmp) {
+		enum gpu_block_state min_state;
+		u64 size;
 
-		block = list_first_entry_or_null(&dfs,
-						 struct gpu_buddy_block,
-						 tmp_link);
-		if (!block)
+		size = mm->chunk_size << tmp;
+		if (size > end - start)
 			break;
 
-		list_del(&block->tmp_link);
+		/*
+		 * At the requested order a clear or mixed block is handed back
+		 * whole (no split). At a higher order only a wholly-clear block
+		 * is accepted, so splitting it down produces clear children and
+		 * never strands a dirty sibling.
+		 */
+		min_state = (tmp == order) ? GPU_BLOCK_MIXED : GPU_BLOCK_CLEAR;
+
+		block = rbtree_range_best_block(&mm->free_tree[tmp],
+						start, end - size, min_state);
+		if (block)
+			goto split_down;
+	}
+
+	return NULL;
+
+split_down:
+	while (gpu_buddy_block_order(block) != order) {
+		err = split_block(mm, block);
+		if (unlikely(err))
+			goto err_undo;
+
+		/*
+		 * The parent is wholly clear above the requested order, so both
+		 * children are clear and fully inside the window; descend the
+		 * higher-address child to match the top-down default placement.
+		 */
+		block = block->right;
+	}
+
+	return block;
+
+err_undo:
+	__gpu_buddy_undo_splits(mm, block);
+	return ERR_PTR(err);
+}
+
+static struct gpu_buddy_block *
+__alloc_range_block(struct gpu_buddy *mm, struct rb_root *root,
+		    u64 start, u64 end, u64 req_size,
+		    bool strict, unsigned long flags,
+		    u64 *out_offset)
+{
+	struct gpu_buddy_block *last = rbtree_last_free_block_in(root, 0, end - 1);
+	struct rb_node *node;
+
+	/* Seek to the highest-offset block below @end, then walk down. */
+	for (node = last ? &last->rb : NULL; node; node = rb_prev(node)) {
+		u64 block_offset, block_end, low, high, offset;
+		struct gpu_buddy_block *block;
+
+		block = rbtree_get_free_block(node);
+		block_offset = gpu_buddy_block_offset(block);
+		block_end = block_offset + gpu_buddy_block_size(mm, block);
+
+		/* Offsets descend; once below the window nothing else fits. */
+		if (block_end <= start)
+			break;
 
-		if (block->subtree_max_free_order < (int)order)
+		if (strict && (block_offset < start || block_end > end))
+			continue;
+		if (strict && block_incompatible(block, flags))
 			continue;
 
-		block_start = gpu_buddy_block_offset(block);
-		block_end = block_start + gpu_buddy_block_size(mm, block) - 1;
+		low = max(block_offset, start);
+		high = min(block_end, end);
+		if (high < req_size)
+			continue;
 
-		if (!overlaps(start, end, block_start, block_end))
+		offset = round_down(high - req_size, req_size);
+		if (offset < low)
 			continue;
 
-		if (block_start < start || block_end > end) {
-			u64 adjusted_start = max(block_start, start);
-			u64 adjusted_end = min(block_end, end);
+		*out_offset = offset;
+		return block;
+	}
 
-			if (round_down(adjusted_end + 1, req_size) <=
-			    round_up(adjusted_start, req_size))
-				continue;
+	return NULL;
+}
 
-			/*
-			 * Strict pass: don't split a partially-overlapping free
-			 * block; rejecting its child would strand the split. Let
-			 * the fallback pass consume it (either class accepted).
-			 */
-			if (!fallback && gpu_buddy_block_is_free(block))
-				continue;
-		}
+static struct gpu_buddy_block *
+__alloc_range_freetree(struct gpu_buddy *mm,
+		       u64 start, u64 end,
+		       unsigned int order,
+		       unsigned long flags)
+{
+	u64 req_size = mm->chunk_size << order;
+	struct gpu_buddy_block *preferred_block;
+	u64 max_offset = 0;
+	unsigned int pass;
+	int err;
 
-		if (!fallback && block_incompatible(block, flags))
-			continue;
+	if (start >= end)
+		return ERR_PTR(-ENOSPC);
 
-		/* Not pruned at @order, so this block itself is FREE */
-		if (contains(start, end, block_start, block_end) &&
-		    order == gpu_buddy_block_order(block))
-			return block;
+	/* Clear, non-top-down: try clear space first, then placement. */
+	if ((flags & GPU_BUDDY_CLEAR_ALLOCATION) &&
+	    !(flags & GPU_BUDDY_TOPDOWN_ALLOCATION)) {
+		preferred_block = __alloc_range_clear_block(mm, start, end,
+							    order, flags);
+		if (IS_ERR(preferred_block))
+			return preferred_block;
+		if (preferred_block)
+			return preferred_block;
+	}
 
-		if (!gpu_buddy_block_is_split(block)) {
-			err = split_block(mm, block);
-			if (unlikely(err))
-				goto err_undo;
+	/* Pass 0: strict (contained, class-match); pass 1: fallback (any). */
+	for (pass = 0; pass < 2; pass++) {
+		bool strict = (pass == 0);
+		unsigned int tmp;
+
+		preferred_block = NULL;
+		for (tmp = order; tmp <= mm->max_order; ++tmp) {
+			struct gpu_buddy_block *block;
+			u64 offset;
+
+			block = __alloc_range_block(mm, &mm->free_tree[tmp],
+						    start, end,
+						    req_size, strict,
+						    flags, &offset);
+			if (block &&
+			    (!preferred_block || offset > max_offset)) {
+				preferred_block = block;
+				max_offset = offset;
+			}
 		}
 
-		list_add(&block->left->tmp_link, &dfs);
-		list_add(&block->right->tmp_link, &dfs);
-	} while (1);
+		if (preferred_block)
+			break;
+	}
 
-	return ERR_PTR(-ENOSPC);
+	if (!preferred_block)
+		return ERR_PTR(-ENOSPC);
 
-err_undo:
 	/*
-	 * We really don't want to leave around a bunch of split blocks, since
-	 * bigger is better, so make sure we merge everything back before we
-	 * free the allocated blocks.
+	 * Split @preferred_block down to the order-@order block covering
+	 * @max_offset.
 	 */
-	__gpu_buddy_undo_splits(mm, block);
+	while (gpu_buddy_block_order(preferred_block) != order) {
+		u64 mid_offset;
+
+		err = split_block(mm, preferred_block);
+		if (unlikely(err))
+			goto err_undo;
+
+		mid_offset = gpu_buddy_block_offset(preferred_block) +
+			     (gpu_buddy_block_size(mm, preferred_block) >> 1);
+		if (max_offset >= mid_offset)
+			preferred_block = preferred_block->right;
+		else
+			preferred_block = preferred_block->left;
+	}
+
+	return preferred_block;
+
+err_undo:
+	__gpu_buddy_undo_splits(mm, preferred_block);
 	return ERR_PTR(err);
 }
 
@@ -1371,18 +1527,7 @@ __gpu_buddy_alloc_range_bias(struct gpu_buddy *mm,
 			     unsigned int order,
 			     unsigned long flags)
 {
-	struct gpu_buddy_block *block;
-	bool fallback;
-
-	fallback = !(gpu_buddy_clear_avail(mm) && mm->dirty.total_dirty);
-
-	block = __alloc_range_bias(mm, start, end, order,
-				   flags, fallback);
-	if (IS_ERR(block) && !fallback)
-		return __alloc_range_bias(mm, start, end, order,
-					  flags, true);
-
-	return block;
+	return __alloc_range_freetree(mm, start, end, order, flags);
 }
 
 /* Return the highest-address free block of at least @order. */
-- 
2.43.0

