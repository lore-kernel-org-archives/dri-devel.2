Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CC0606A322
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 16:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=mUYdUOxp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E40D810E42D;
	Mon, 16 Nov 2026 16:11:28 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012012.outbound.protection.outlook.com [40.107.209.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB19510F1F6;
 Mon, 16 Nov 2026 16:11:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lju2r4tTT00fVukRlmbTV53nMBI7T8KKPd7JlJx7M3fDaQeOldmd0tQGxF2q/kDM5Y0kfoOekkIHqlDS3jLpP899TqsYr6+ps+6rJUsnT38apo4QVC2bxv0gASGD91NfxcaudwIy6orXbRPbc2Uuz9OhBWbMPY/B9aM1XxPga2XpIjbag1UxSfTXTc+2sJY/BlpVLbNDrKXXrUkAZptXuOwNsc6lSFUvi4mUiHol9BFr2NieDWJEqB0u16EKWTSDv4KTQgX/Cu7tg30IwVcEBOV0zO/P1w3GQ+A4XeQtz2+t1rYhVHq4cJE4lyaq5uNvNt2XuZ6YQtA9yPBqiLcBXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E/4JHD9nD2cFTa90eYhcW8Ic0V2bZbgUfL1/kyLgzSg=;
 b=FP4eu5JyuVPh9JhWWp7LHoPF74oFhd9+EulHDM7ORua2gvBYbqwDXBBCuhaj5oVte74EHs5q14PspDHG48rWEEHWRJKtz1dVD4qzuEMs6mJ4IMX8bIBl+zw1g6ZvWYVXjLsdL8s4BVxi2XB5rgG0aOd9fYtEhTTQjgiCaKcLRFEpS40YBUWL2/gOEV0BAy0Z/2mxTRujy1p/lVQpEca9NIWe3oqEOL+yOvm04RqtHopZIgWN6FxV5mWmgocC9yp32F52+UDI0eCo/SGOPaibAKFj81LXRScMjgSmVU1aRwPVkYjP3SxJPNnzLOXpphid2krDqZ7YU65LUGUmH5u1Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E/4JHD9nD2cFTa90eYhcW8Ic0V2bZbgUfL1/kyLgzSg=;
 b=mUYdUOxpIrvAX+Job9yQC7uGCvUOUOo14beo/Vg5BifQ9AsCvpGTHxufIO7mqk7WSznHmJRk6Aji8BdvHXkqSox+gHPqTRVkNbJsSxYtk6GXeqpKxI7WvBf2DaUnI6iTvBGcO+CG2BVICfkipH5dwopvQxnG5LPJ3T8CfnzAi6w=
Received: from BLAPR05CA0004.namprd05.prod.outlook.com (2603:10b6:208:36e::8)
 by CH4PR12MB088503.namprd12.prod.outlook.com (2603:10b6:610:50a::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 16:11:16 +0000
Received: from LV8PEPF0000005C.namprd02.prod.outlook.com
 (2603:10b6:208:36e:cafe::36) by BLAPR05CA0004.outlook.office365.com
 (2603:10b6:208:36e::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.6 via Frontend Transport; Mon, 16
 Nov 2026 16:11:16 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 LV8PEPF0000005C.mail.protection.outlook.com (10.167.245.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 16 Nov 2026 16:11:15 +0000
Received: from alysaliu-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Mon, 16 Nov
 2026 10:11:14 -0600
From: William Palacek <William.Palacek@amd.com>
To: <dri-devel@lists.freedesktop.org>
CC: <intel-xe@lists.freedesktop.org>, Matthew Auld <matthew.auld@intel.com>,
 Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>, Sanjay Yadav
 <sanjay.kumar.yadav@intel.com>, Joel Fernandes <joelagnelf@nvidia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 <linux-kernel@vger.kernel.org>, William Palacek <William.Palacek@amd.com>
Subject: [PATCH v3 1/2] gpu/buddy: find range-biased blocks in the free trees
Date: Mon, 16 Nov 2026 11:11:01 -0500
Message-ID: <17f2a6366ba845edc799dbeb712c12f8d060afad.1794845083.git.William.Palacek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1794845083.git.William.Palacek@amd.com>
References: <cover.1794845083.git.William.Palacek@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF0000005C:EE_|CH4PR12MB088503:EE_
X-MS-Office365-Filtering-Correlation-Id: 68cf00ce-a266-4757-b0e8-08df43fc3ddc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|36860700016|82310400026|10067099003|11063799006|56012099006|261026121527099003|261026140227099003|261028144727099003|261022105027099003|261021123027099003|261021121427099003|261102123227099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ZcWj5uSmIzkSMSJT4pXHzceEel47tKg5JesaWqLvJhTGSTUBNXGenf9hi2DnRKpnxyie7gPQek7jQN4gIxUT9/QUR35w9/fdLwItgncC5/uArS6uGLajCPqwi03Jf2Xt5/l3wHpQKvl8J8auLaUMyXyPTUSVAYLqxTUM5sQJYGBrnCxauJWmo43TdJSQgc2Qafny4rwoCWVU0pAvSerWqgNZ8J8biNDjTbdeVNfqTKDFK7akzEelbCpGGm5mayQE4pOrvwSrbeJ9XiNk35CJwk5EBsY8eu6HNBRAQKjTgrIpw+8DAIyJI2kwbR5b2Swfi8/f84gZ/vPHRcN/tlOctiInqxr9e3JBI/ColWiR8oFVtBwK0+E5xZOIu6/uRuFCiiTfMg2ra3vpLYQHPDNe9G/dc+C1KmjWYMoMoRVrcr/tlNZuRH0LZ2o87HbP7JpzpQhM7EaZoj7cf9fdy95N9iJqDsX5DtUvdUyLxMqdGV/J8rh8J3diyJzI3FLXgxZBF5BI9pjE96B21TueFAGhr+hlzwoPLBSee160y2zbJqvOHXwJLm1dT9kPvB6TR9NO37f9AZ8V++hCab7jv0Ch+QQF0vQxHyvEitmC4dw3WYA82hTLS8cp8AyAyX+8rpP73LuQflg/2KbVHZfHgRM+Vnw168kZ/ShKSylNp2GGN8fux3xbh6+26jVOz3GhNRepa2KVqmHnYRA4VaKngTKWnQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(10067099003)(11063799006)(56012099006)(261026121527099003)(261026140227099003)(261028144727099003)(261022105027099003)(261021123027099003)(261021121427099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fVSePWkxPlyS3oHTEsAtBmYfGEpeyxqH94pvKL8Ue0MpqBQkRSbHRkf4BVZKEX59uezO4nt4MmIEA6ULt9lFksk65RRSNW0kkbmg6V9ttOllQZx6T5yXC1gz1b4+bjvBOLs7ZbkHxxxkHHAu8M4hxhMj75lkrtvb0UDsDRuMvrKiJSBoK+UKokLMm+sYnNxddZXeI6Kz6nWQRbQmYQk80YAcmrm1/zYZINO/awdS/GVkj0alJE1r2ZhxzOLfbXVMEcYyFuLz/lMrxH5p2/lHZfGfC4SI/ean0OKpIZqzxuKYpMMKyn18/qL69CDzXHyxf6f9cO46O9FGYCgkIW9+n1QGvVxIG/wxe/Q8U+6yakP1AkFkZUHfniFI/5hwLixba9MAI+B44iqgA0HG1vmqXkOvJWDmQ4+s3RLj/i7PuqsVzzzlcFQIMpXQTT1zHW6E
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 16:11:15.8163 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68cf00ce-a266-4757-b0e8-08df43fc3ddc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: LV8PEPF0000005C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR12MB088503
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

__alloc_range_bias() walks the block tree from the roots and visits
every split block overlapping [start, end) until it finds a suitable
free block, so a range-restricted allocation costs time linear in the
number of live allocations in the range. When both clear and dirty
space exist, a request that the strict pass cannot serve walks the
range twice.

amdgpu pays this on every VRAM allocation when memory is partitioned
(NPS2/NPS4): each BO, including the page-table BOs created when memory
is mapped, is restricted to its partition's range, and KFD requests
cleared VRAM. On MI300X in CPX/NPS4 the compute partitions that share a
memory partition also share the VRAM manager lock, so the walk is
serialised across processes. hipMalloc latency grows linearly with the
number of live allocations, and vLLM piecewise graph capture slows down
with every captured graph.

The free trees are sorted by offset, so find the block there instead.
For each order from the requested one up, look up the highest free
block that can hold the request, then split the highest of them down to
the requested order. The strict pass only takes blocks wholly inside
the range whose class suits the request: subtree_block_state lets a
clear request skip subtrees without a clear or mixed block, and a new
subtree_has_dirty augment lets a dirty request skip subtrees that hold
only clear blocks. The fallback pass takes the highest block of either
class and may split one that straddles the range edge. Each lookup is
O(log n) and the walk is gone.

Placement is unchanged. A seeded random workload of 42218 allocations
mixing range, clear and top-down requests and cleared and dirty frees
places every block at the same offset, order and clear state as the
walk.

Filling 1 GiB of a 4 GiB manager with 64 KiB range-biased allocations
that request cleared memory takes 1103 ms before, 2 ms after (KUnit,
UML). With 8192 free cleared 64 KiB blocks interleaved with allocated
ones in the range, 4096 dirty range allocations take 541 to 567 ms
before and 0 ms after, and 4096 cleared ones 106 to 110 ms before and
0 ms after.

On MI300X in CPX/NPS4, with 8000 live 2 MiB hipMalloc allocations on
one partition, the median latency of the last 800 over the first 800 is
1.56x and 7.97x before and 0.52x and 1.06x after (two runs each; the
first run after loading the driver starts slow). vLLM piecewise graph
capture with tensor parallelism over all 64 partitions stays at 4 to 6 s
per graph for all 51 graphs.

Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Signed-off-by: William Palacek <William.Palacek@amd.com>
---

Notes:
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

 drivers/gpu/buddy.c       | 214 +++++++++++++++++++++++++-------------
 include/linux/gpu_buddy.h |   1 +
 2 files changed, 145 insertions(+), 70 deletions(-)

diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
index e7d2212bcec9..baf17700ffba 100644
--- a/drivers/gpu/buddy.c
+++ b/drivers/gpu/buddy.c
@@ -62,6 +62,8 @@ static struct kmem_cache *slab_extents;
  *     of any block in the subtree, maintained as a max augment. A value of
  *     >= MIXED means a clear-or-mixed block exists; == CLEAR means a
  *     fully-clear block exists.
+ *   - subtree_has_dirty: some block in the subtree is not fully clear,
+ *     so range allocations can skip all-clear subtrees for dirty requests.
  *
  * Block classes
  * -------------
@@ -510,9 +512,11 @@ static inline void gpu_buddy_augment_compute(struct gpu_buddy_block *block)
 	struct gpu_buddy_block *right;
 	struct gpu_buddy_block *left;
 	unsigned int max_align;
+	bool has_dirty;
 
 	max_align = gpu_buddy_block_offset_alignment(block);
 	block_state = gpu_block_cached_state(block);
+	has_dirty = block_state != GPU_BLOCK_CLEAR;
 
 	left = rb_entry_safe(block->rb.rb_left, struct gpu_buddy_block, rb);
 	if (left) {
@@ -520,6 +524,7 @@ static inline void gpu_buddy_augment_compute(struct gpu_buddy_block *block)
 			max_align = left->subtree_max_alignment;
 
 		block_state = max(block_state, left->subtree_block_state);
+		has_dirty |= left->subtree_has_dirty;
 	}
 
 	right = rb_entry_safe(block->rb.rb_right, struct gpu_buddy_block, rb);
@@ -528,10 +533,12 @@ static inline void gpu_buddy_augment_compute(struct gpu_buddy_block *block)
 			max_align = right->subtree_max_alignment;
 
 		block_state = max(block_state, right->subtree_block_state);
+		has_dirty |= right->subtree_has_dirty;
 	}
 
 	block->subtree_max_alignment = max_align;
 	block->subtree_block_state = block_state;
+	block->subtree_has_dirty = has_dirty;
 }
 
 static void gpu_buddy_augment_propagate(struct rb_node *rb, struct rb_node *stop)
@@ -540,14 +547,17 @@ static void gpu_buddy_augment_propagate(struct rb_node *rb, struct rb_node *stop
 		struct gpu_buddy_block *block;
 		unsigned int old_align;
 		enum gpu_block_state old_block_state;
+		bool old_has_dirty;
 
 		block = rb_entry(rb, struct gpu_buddy_block, rb);
 		old_align = block->subtree_max_alignment;
 		old_block_state = block->subtree_block_state;
+		old_has_dirty = block->subtree_has_dirty;
 
 		gpu_buddy_augment_compute(block);
 		if (block->subtree_max_alignment == old_align &&
-		    block->subtree_block_state == old_block_state)
+		    block->subtree_block_state == old_block_state &&
+		    block->subtree_has_dirty == old_has_dirty)
 			break;
 
 		rb = rb_parent(&block->rb);
@@ -564,6 +574,7 @@ static void gpu_buddy_augment_copy(struct rb_node *rb_old, struct rb_node *rb_ne
 
 	new->subtree_max_alignment = old->subtree_max_alignment;
 	new->subtree_block_state = old->subtree_block_state;
+	new->subtree_has_dirty = old->subtree_has_dirty;
 }
 
 static void gpu_buddy_augment_rotate(struct rb_node *rb_old, struct rb_node *rb_new)
@@ -576,6 +587,7 @@ static void gpu_buddy_augment_rotate(struct rb_node *rb_old, struct rb_node *rb_
 
 	new->subtree_max_alignment = old->subtree_max_alignment;
 	new->subtree_block_state = old->subtree_block_state;
+	new->subtree_has_dirty = old->subtree_has_dirty;
 
 	gpu_buddy_augment_compute(old);
 }
@@ -695,6 +707,8 @@ static void rbtree_insert(struct gpu_buddy *mm,
 			node->subtree_max_alignment = block_alignment;
 		if (node->subtree_block_state < block_state)
 			node->subtree_block_state = block_state;
+		if (block_state != GPU_BLOCK_CLEAR)
+			node->subtree_has_dirty = true;
 
 		if (gpu_buddy_block_offset(block) < gpu_buddy_block_offset(node))
 			link = &parent->rb_left;
@@ -704,6 +718,7 @@ static void rbtree_insert(struct gpu_buddy *mm,
 
 	block->subtree_max_alignment = block_alignment;
 	block->subtree_block_state = block_state;
+	block->subtree_has_dirty = block_state != GPU_BLOCK_CLEAR;
 	rb_link_node(&block->rb, parent, link);
 	rb_insert_augmented(&block->rb, root, &gpu_buddy_augment_cb);
 }
@@ -1247,96 +1262,155 @@ static bool block_incompatible(struct gpu_buddy_block *block, unsigned int flags
 			     gpu_buddy_block_is_clear(block);
 }
 
-static struct gpu_buddy_block *
-__alloc_range_bias(struct gpu_buddy *mm,
-		   u64 start, u64 end,
-		   unsigned int order,
-		   unsigned long flags,
-		   bool fallback)
+/* Does the subtree at @node hold a block the strict pass may take? */
+static bool range_subtree_ok(struct rb_node *node, unsigned long flags)
 {
-	u64 req_size = mm->chunk_size << order;
-	struct gpu_buddy_block *block;
-	LIST_HEAD(dfs);
-	int err;
-	int i;
+	struct gpu_buddy_block *block = rbtree_get_free_block(node);
 
-	end = end - 1;
+	if (!block)
+		return false;
+	if (flags & GPU_BUDDY_CLEAR_ALLOCATION)
+		return block->subtree_block_state >= GPU_BLOCK_MIXED;
+	return block->subtree_has_dirty;
+}
 
-	/*
-	 * This range-constrained search hands back the highest/right-most
-	 * address that satisfies the request: the roots are seeded high-to-low
-	 * and the right (higher-address) child is descended first, making
-	 * top-down the default placement here.
-	 */
-	for (i = mm->n_roots - 1; i >= 0; --i)
-		list_add_tail(&mm->roots[i]->tmp_link, &dfs);
+/*
+ * Highest-offset free block in @root with offset < @limit that the strict
+ * pass may take (any block when @fallback). Subtrees without such a block
+ * are skipped through the augments, so this is O(log n) per call.
+ */
+static struct gpu_buddy_block *
+rbtree_last_range_block(struct rb_root *root, u64 limit,
+			unsigned long flags, bool fallback)
+{
+	struct rb_node *node = root->rb_node;
+	struct rb_node *prev = NULL;
 
-	do {
-		u64 block_start;
-		u64 block_end;
+	while (node) {
+		if (gpu_buddy_block_offset(rbtree_get_free_block(node)) < limit) {
+			prev = node;
+			node = node->rb_right;
+		} else {
+			node = node->rb_left;
+		}
+	}
 
-		block = list_first_entry_or_null(&dfs,
-						 struct gpu_buddy_block,
-						 tmp_link);
-		if (!block)
-			break;
+	for (node = prev; node; node = rb_parent(node)) {
+		if (fallback ||
+		    !block_incompatible(rbtree_get_free_block(node), flags))
+			return rbtree_get_free_block(node);
 
-		list_del(&block->tmp_link);
+		if (range_subtree_ok(node->rb_left, flags)) {
+			/* The left subtree holds one: take its highest. */
+			node = node->rb_left;
+			while (node) {
+				struct gpu_buddy_block *block = rbtree_get_free_block(node);
 
-		if (gpu_buddy_block_order(block) < order)
-			continue;
+				if (range_subtree_ok(node->rb_right, flags)) {
+					node = node->rb_right;
+					continue;
+				}
+				if (!block_incompatible(block, flags))
+					return block;
+				node = node->rb_left;
+			}
+			return NULL;
+		}
 
-		block_start = gpu_buddy_block_offset(block);
-		block_end = block_start + gpu_buddy_block_size(mm, block) - 1;
+		/* Climb to the next lower ancestor. */
+		while (rb_parent(node) && node == rb_parent(node)->rb_left)
+			node = rb_parent(node);
+	}
 
-		if (!overlaps(start, end, block_start, block_end))
-			continue;
+	return NULL;
+}
 
-		if (gpu_buddy_block_is_allocated(block))
-			continue;
+/*
+ * Return the order-@order block at the highest @req_size-aligned offset in
+ * [@start, @end) that lies inside a free block, splitting as needed. The
+ * strict pass only takes free blocks wholly inside the range whose class
+ * suits @flags; splitting a block that straddles the range edge is left to
+ * the fallback pass, which takes either class.
+ */
+static struct gpu_buddy_block *
+__alloc_range_bias(struct gpu_buddy *mm,
+		   u64 start, u64 end,
+		   unsigned int order,
+		   unsigned long flags,
+		   bool fallback)
+{
+	u64 req_size = mm->chunk_size << order;
+	struct gpu_buddy_block *block = NULL;
+	u64 best = 0;
+	unsigned int i;
+	int err;
 
-		if (block_start < start || block_end > end) {
-			u64 adjusted_start = max(block_start, start);
-			u64 adjusted_end = min(block_end, end);
+	for (i = order; i <= mm->max_order; i++) {
+		struct rb_root *root = &mm->free_tree[i];
+		u64 size = mm->chunk_size << i;
+		struct gpu_buddy_block *found;
+		u64 offset = 0;
 
-			if (round_down(adjusted_end + 1, req_size) <=
-			    round_up(adjusted_start, req_size))
-				continue;
+		if (!fallback) {
+			if (end - start < size)
+				break;
 
-			/*
-			 * Strict pass: don't split a partially-overlapping free
-			 * block; rejecting its child would strand the split. Let
-			 * the fallback pass consume it (either class accepted).
-			 */
-			if (!fallback && gpu_buddy_block_is_free(block))
+			found = rbtree_last_range_block(root, end - size + 1,
+							flags, false);
+			if (!found || gpu_buddy_block_offset(found) < start)
 				continue;
-		}
-
-		if (!fallback && block_incompatible(block, flags))
-			continue;
 
-		if (contains(start, end, block_start, block_end) &&
-		    order == gpu_buddy_block_order(block)) {
-			/*
-			 * Find the free block within the range.
-			 */
-			if (gpu_buddy_block_is_free(block))
-				return block;
+			offset = gpu_buddy_block_offset(found) + size - req_size;
+		} else {
+			/* At most the blocks straddling @end and @start miss. */
+			for (found = rbtree_last_range_block(root, end, flags, true);
+			     found;
+			     found = rbtree_get_free_block(rb_prev(&found->rb))) {
+				u64 lo = max(gpu_buddy_block_offset(found), start);
+				u64 hi = min(gpu_buddy_block_offset(found) + size, end);
+
+				if (hi <= start) {
+					found = NULL;
+					break;
+				}
 
-			continue;
+				if (hi >= lo + req_size) {
+					offset = round_down(hi - req_size, req_size);
+					if (offset >= lo)
+						break;
+				}
+			}
+			if (!found)
+				continue;
 		}
 
-		if (!gpu_buddy_block_is_split(block)) {
-			err = split_block(mm, block);
-			if (unlikely(err))
-				goto err_undo;
+		if (!block || offset > best) {
+			block = found;
+			best = offset;
 		}
+	}
 
-		list_add(&block->left->tmp_link, &dfs);
-		list_add(&block->right->tmp_link, &dfs);
-	} while (1);
+	if (!block)
+		return ERR_PTR(-ENOSPC);
+
+	while (gpu_buddy_block_order(block) > order) {
+		err = split_block(mm, block);
+		if (unlikely(err))
+			goto err_undo;
 
-	return ERR_PTR(-ENOSPC);
+		/*
+		 * Fallback: the child holding @best. Strict: the higher child
+		 * unless its class does not suit, as the old walk did.
+		 */
+		if (fallback)
+			block = best >= gpu_buddy_block_offset(block->right) ?
+				block->right : block->left;
+		else
+			block = block_incompatible(block->right, flags) ?
+				block->left : block->right;
+	}
+
+	return block;
 
 err_undo:
 	/*
diff --git a/include/linux/gpu_buddy.h b/include/linux/gpu_buddy.h
index ddc4eca84175..6abc66125935 100644
--- a/include/linux/gpu_buddy.h
+++ b/include/linux/gpu_buddy.h
@@ -141,6 +141,7 @@ struct gpu_buddy_block {
 	unsigned int subtree_max_alignment;
 	struct list_head tmp_link;
 	bool has_clear;
+	bool subtree_has_dirty;
 };
 
 /* Order-zero must be at least SZ_4K */
-- 
2.43.0

