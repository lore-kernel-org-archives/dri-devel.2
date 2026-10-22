Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E14B606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 05:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Xh75i9FK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD707112315;
	Thu, 22 Oct 2026 05:21:57 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2B6E10E1F9;
 Thu, 22 Oct 2026 05:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792646508; x=1824182508;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=+gmKAgiByhS2dF/IoLFBCIo1Krc1cUo7Cb+YHBixsrg=;
 b=Xh75i9FKOGgYD0Y3CA7q86QKEQDQWSFAdi+HBqcrtOsYistHKuI2sDFq
 P9fIuKfT/J6fFw3MCvC5W++KF5pg/5FTZv0XPsZzeHMsXZJr3ff1O57PS
 NHdYIelfoIyJ8kd5dnaPZQ84AUkHCiSGeWn6YRNXkj6SmLma4a20/S9jR
 wKeQK4p5qdcbBKtLja+RSMoIqxTN+04b52uaBQ9jlGX2fIElKNj4LW+ie
 n+NM4JWlUYnoWIxaJ0kcJVNm+Z31LMZ3HPXXAfgsAkankBKmR5UO0v7Ey
 7CksNp4XzRTqE+7M3fs5QhdpHtv1b1k1hTRiKal6wzUcwNtZhT0ntG1U5 g==;
X-CSE-ConnectionGUID: EeIX8YUWSzqU4uPat+fvRg==
X-CSE-MsgGUID: 5O2fnnQqRGW9lZguGy4kgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1272297"
X-IronPort-AV: E=Sophos;i="6.27,171,1787036400"; 
   d="scan'208";a="1272297"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 22:21:47 -0700
X-CSE-ConnectionGUID: BYjHJBJ3SuCG815K+ETV5g==
X-CSE-MsgGUID: 8PUehVyOTseMbjAscFyWiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,171,1787036400"; 
   d="scan'208";a="3193200"
Received: from yadavs-z690i-a-ultra-plus.iind.intel.com ([10.190.216.90])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 22:21:46 -0700
From: Sanjay Yadav <sanjay.kumar.yadav@intel.com>
To: dri-devel@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org, Matthew Auld <matthew.auld@intel.com>,
 Arun Pravin <arunpravin.paneerselvam@amd.com>,
 Joel Fernandes <joelagnelf@nvidia.com>
Subject: [PATCH v3 1/2] gpu/buddy: Prune exhausted subtrees in range-biased
 allocation
Date: Thu, 22 Oct 2026 10:45:20 +0530
Message-ID: <20261022051518.486064-5-sanjay.kumar.yadav@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261022051518.486064-4-sanjay.kumar.yadav@intel.com>
References: <20261022051518.486064-4-sanjay.kumar.yadav@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

__alloc_range_bias() walks the buddy tree depth-first, higher address
first, and descends every SPLIT block even when nothing below it is
free. Range allocations are placed top-down, so they pack below the
range end and each new one walks every block already allocated there:
O(N) per allocation and O(N^2) for N allocations, under the allocator
lock.

Track in each block the largest order of any FREE block in its subtree
(GPU_BUDDY_NO_FREE_ORDER if none), update it whenever a block changes
state, and skip subtrees that cannot satisfy the requested order.
gpu_buddy_block_trim() detaches the block while re-allocating inside
it, so recompute from the parent once it is reattached.

Skipped subtrees contain no FREE block of the requested order or
larger, so the old walk could neither split nor return anything there.
The remaining blocks are visited in the same order, so the selected
block and placement are unchanged.

Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Arun Pravin <arunpravin.paneerselvam@amd.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>
Assisted-by: LLM
Signed-off-by: Sanjay Yadav <sanjay.kumar.yadav@intel.com>
---
 drivers/gpu/buddy.c       | 31 +++++++++++++++++++++++++++++++
 include/linux/gpu_buddy.h |  7 +++++++
 2 files changed, 38 insertions(+)

diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
index 28cff97d57dc..b77d7f621290 100644
--- a/drivers/gpu/buddy.c
+++ b/drivers/gpu/buddy.c
@@ -602,6 +602,7 @@ static struct gpu_buddy_block *gpu_block_alloc(struct gpu_buddy *mm,
 	block->header = offset;
 	block->header |= order;
 	block->parent = parent;
+	block->subtree_max_free_order = GPU_BUDDY_NO_FREE_ORDER;
 
 	RB_CLEAR_NODE(&block->rb);
 
@@ -717,6 +718,27 @@ static void rbtree_remove(struct gpu_buddy *mm,
 	RB_CLEAR_NODE(&block->rb);
 }
 
+static void update_subtree_max_free_order(struct gpu_buddy_block *block)
+{
+	while (block) {
+		s8 max_free;
+
+		if (gpu_buddy_block_is_free(block))
+			max_free = gpu_buddy_block_order(block);
+		else if (gpu_buddy_block_is_split(block))
+			max_free = max(block->left->subtree_max_free_order,
+				       block->right->subtree_max_free_order);
+		else
+			max_free = GPU_BUDDY_NO_FREE_ORDER;
+
+		if (block->subtree_max_free_order == max_free)
+			break;
+
+		block->subtree_max_free_order = max_free;
+		block = block->parent;
+	}
+}
+
 static void mark_allocated(struct gpu_buddy *mm,
 			   struct gpu_buddy_block *block)
 {
@@ -729,6 +751,7 @@ static void mark_allocated(struct gpu_buddy *mm,
 	mm->used_scoreboard[gpu_buddy_block_order(block)]++;
 
 	rbtree_remove(mm, block);
+	update_subtree_max_free_order(block);
 }
 
 static void __mark_free(struct gpu_buddy *mm,
@@ -750,6 +773,7 @@ static void __mark_free(struct gpu_buddy *mm,
 	mm->free_scoreboard[gpu_buddy_block_order(block)]++;
 
 	rbtree_insert(mm, block);
+	update_subtree_max_free_order(block);
 }
 
 static void mark_free(struct gpu_buddy *mm,
@@ -772,6 +796,7 @@ static void mark_split(struct gpu_buddy *mm,
 	mm->free_scoreboard[gpu_buddy_block_order(block)]--;
 
 	rbtree_remove(mm, block);
+	update_subtree_max_free_order(block);
 }
 
 static inline bool overlaps(u64 s1, u64 e1, u64 s2, u64 e2)
@@ -869,6 +894,8 @@ int gpu_buddy_init(struct gpu_buddy *mm, u64 size, u64 chunk_size)
 
 	size = round_down(size, chunk_size);
 
+	BUILD_BUG_ON(GPU_BUDDY_MAX_ORDER > S8_MAX);
+
 	mm->size = size;
 	mm->avail = size;
 	mm->chunk_size = chunk_size;
@@ -1280,6 +1307,9 @@ __alloc_range_bias(struct gpu_buddy *mm,
 		if (gpu_buddy_block_order(block) < order)
 			continue;
 
+		if (block->subtree_max_free_order < (int)order)
+			continue;
+
 		block_start = gpu_buddy_block_offset(block);
 		block_end = block_start + gpu_buddy_block_size(mm, block) - 1;
 
@@ -1881,6 +1911,7 @@ int gpu_buddy_block_trim(struct gpu_buddy *mm,
 	}
 
 	block->parent = parent;
+	update_subtree_max_free_order(parent);
 	return err;
 }
 EXPORT_SYMBOL(gpu_buddy_block_trim);
diff --git a/include/linux/gpu_buddy.h b/include/linux/gpu_buddy.h
index ddc4eca84175..8037f5a0feb1 100644
--- a/include/linux/gpu_buddy.h
+++ b/include/linux/gpu_buddy.h
@@ -141,8 +141,15 @@ struct gpu_buddy_block {
 	unsigned int subtree_max_alignment;
 	struct list_head tmp_link;
 	bool has_clear;
+	/*
+	 * Largest order of any FREE block in this block's buddy subtree, or
+	 * GPU_BUDDY_NO_FREE_ORDER if none. Protected by the driver lock.
+	 */
+	s8 subtree_max_free_order;
 };
 
+#define GPU_BUDDY_NO_FREE_ORDER (-1)
+
 /* Order-zero must be at least SZ_4K */
 #define GPU_BUDDY_MAX_ORDER (63 - 12)
 
-- 
2.52.0

