Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0555CC5B56A
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 12:40:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C5B710EB8E;
	Tue, 11 Aug 2026 12:40:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="TlOp12NJ";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 315E510EB8B;
 Tue, 11 Aug 2026 12:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786452037; x=1817988037;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=w1b7MPyQwYUv0BfP8b+DcSsNdYvPfcNImRvtNECFHbE=;
 b=TlOp12NJaqe/ZTtC9g5I+qzCB7aGxqp0zrtDUXLkBwCUyLGpD+gsTinB
 FTXY9AF7gR96mwhiIddwZ0u4WmKU+gZDZxkzZTnVN1fcqzu60QUanj1Q6
 rVfjISSJ3iI9SsU5/jxLOSijg52dJvZqB3AGJDDkwZ1kCUxoUS9D68wpu
 e/9Qu0Z6wyTmv85LlzbsvXbipu7qnrgFKTmb99hrjaE+RITGOjv7VimYI
 8peHDi4CA9EXV/Cx7v18gN0K603ftjZFREv0Putn64RM7pHdKLVjs8Hbw
 Xq8fKXlMsZvmBl0O2xf5lWzWhnIm/q+IQ0MUYwjTLEmNcYlLyX6PCLfGv Q==;
X-CSE-ConnectionGUID: ZPe/IQNWQmKscN9F2c/LvQ==
X-CSE-MsgGUID: aoudtlUqQi69sS21iJC3TA==
X-IronPort-AV: E=McAfee;i="6800,10657,11871"; a="86912990"
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; d="scan'208";a="86912990"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Aug 2026 05:40:37 -0700
X-CSE-ConnectionGUID: 916TqYhFSVOTF4os8dLGEw==
X-CSE-MsgGUID: vFjvZvmkTM62dW6aYIAyAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; d="scan'208";a="265329857"
Received: from tejasupa-desk.iind.intel.com (HELO tejasupa-desk)
 ([10.190.239.37])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Aug 2026 05:40:35 -0700
From: Tejas Upadhyay <tejas.upadhyay@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: himal.prasad.ghimiray@intel.com, Tejas Upadhyay <tejas.upadhyay@intel.com>,
 Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>,
 dri-devel@lists.freedesktop.org,
 Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH V15 02/14] [DO_NOT_MERGE]drm/gpu: Add
 gpu_buddy_allocated_addr_to_block helper
Date: Tue, 11 Aug 2026 18:10:06 +0530
Message-ID: <20260811124016.3614699-18-tejas.upadhyay@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260811124016.3614699-16-tejas.upadhyay@intel.com>
References: <20260811124016.3614699-16-tejas.upadhyay@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Add helper with primary purpose is to efficiently trace a specific
physical memory address back to its corresponding TTM buffer object.

v3:
- use mm->chunk_size minimum allocation granularity (Arun)
v2:
- %s/gpu_buddy_addr_to_block/gpu_buddy_allocated_addr_to_block(MattA)
- remove clear->avail and split nodes check(MattA)
- Adapt lockdep(MattB)

Signed-off-by: Tejas Upadhyay <tejas.upadhyay@intel.com>
Cc: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
Cc: dri-devel@lists.freedesktop.org
Reviewed-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
---
 drivers/gpu/buddy.c       | 53 +++++++++++++++++++++++++++++++++++++++
 include/linux/gpu_buddy.h |  2 ++
 2 files changed, 55 insertions(+)

diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
index dc81fe0301ce..4d5ac375a538 100644
--- a/drivers/gpu/buddy.c
+++ b/drivers/gpu/buddy.c
@@ -630,6 +630,59 @@ void gpu_buddy_free_block(struct gpu_buddy *mm,
 }
 EXPORT_SYMBOL(gpu_buddy_free_block);
 
+/**
+ * gpu_buddy_allocated_addr_to_block - given relative address find the allocated block
+ *
+ * @mm: GPU buddy manager
+ * @addr: Relative address
+ *
+ * Returns:
+ * gpu_buddy_block on success, NULL or error code on failure
+ */
+struct gpu_buddy_block *gpu_buddy_allocated_addr_to_block(struct gpu_buddy *mm, u64 addr)
+{
+	struct gpu_buddy_block *block;
+	LIST_HEAD(dfs);
+	u64 end;
+	int i;
+
+	gpu_buddy_driver_lock_held(mm);
+
+	end = addr + mm->chunk_size - 1;
+	for (i = 0; i < mm->n_roots; ++i)
+		list_add_tail(&mm->roots[i]->tmp_link, &dfs);
+
+	do {
+		u64 block_start;
+		u64 block_end;
+
+		block = list_first_entry_or_null(&dfs,
+						 struct gpu_buddy_block,
+						 tmp_link);
+		if (!block)
+			break;
+
+		list_del(&block->tmp_link);
+
+		block_start = gpu_buddy_block_offset(block);
+		block_end = block_start + gpu_buddy_block_size(mm, block) - 1;
+
+		if (!overlaps(addr, end, block_start, block_end))
+			continue;
+
+		if (gpu_buddy_block_is_allocated(block))
+			return block;
+		else if (gpu_buddy_block_is_free(block))
+			return NULL;
+
+		list_add(&block->right->tmp_link, &dfs);
+		list_add(&block->left->tmp_link, &dfs);
+	} while (1);
+
+	return ERR_PTR(-ENXIO);
+}
+EXPORT_SYMBOL(gpu_buddy_allocated_addr_to_block);
+
 static void __gpu_buddy_free_list(struct gpu_buddy *mm,
 				  struct list_head *objects,
 				  bool mark_clear,
diff --git a/include/linux/gpu_buddy.h b/include/linux/gpu_buddy.h
index e037714563d8..2c36124bb696 100644
--- a/include/linux/gpu_buddy.h
+++ b/include/linux/gpu_buddy.h
@@ -287,6 +287,8 @@ void gpu_buddy_reset_clear(struct gpu_buddy *mm, bool is_clear);
 
 void gpu_buddy_free_block(struct gpu_buddy *mm, struct gpu_buddy_block *block);
 
+struct gpu_buddy_block *gpu_buddy_allocated_addr_to_block(struct gpu_buddy *mm, u64 addr);
+
 void gpu_buddy_free_list(struct gpu_buddy *mm,
 			 struct list_head *objects,
 			 unsigned int flags);
-- 
2.52.0

