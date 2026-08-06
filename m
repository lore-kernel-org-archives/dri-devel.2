Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 492CCC56205
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 05:36:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A1E010E2C6;
	Thu,  6 Aug 2026 05:36:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="J1Y2HiP+";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3ADC210E2C6;
 Thu,  6 Aug 2026 05:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785994597; x=1817530597;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=w1b7MPyQwYUv0BfP8b+DcSsNdYvPfcNImRvtNECFHbE=;
 b=J1Y2HiP+er8qNH9ki08to9MRlFxHEmP8gJTE4giTGHVL8OlsRLqaZhEg
 1UgbfEuJWwND21Dfkzj/b3Nj42AfjHV6nd/gG5kr0bvckH+z4WVcefb3X
 462BruymaY5i7L1wUp2uKSeJTUPnsPAbOPct8Dh17h3IJpUMjWVk8Zw0q
 e0NkBoSFTWyHGgP1pFf+KAnqdjgkP1bgGV/B+KFDJHx6YSl1Zvqon8FyO
 hcg465Nihj7Ib0OwaKmftDT3hH7+sX4lomdu+2Ywc6ZADxvevHu+qrViO
 yEUmE94UjZhKAT1a6DqVJ3Qh7179bknO70AXMHL9jlcRs1WMQ8hAYQc1Z g==;
X-CSE-ConnectionGUID: fzlzUCmnSoaJiLBsKtqvSg==
X-CSE-MsgGUID: KSf9LhNQQKWJS40wB3G+9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="96928695"
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; d="scan'208";a="96928695"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Aug 2026 22:36:37 -0700
X-CSE-ConnectionGUID: jrynypNJSFqOJUMWajhozA==
X-CSE-MsgGUID: m0THfvigQl2dQIeh/7O6WA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; d="scan'208";a="265487069"
Received: from tejasupa-desk.iind.intel.com (HELO tejasupa-desk)
 ([10.190.239.37])
 by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Aug 2026 22:36:36 -0700
From: Tejas Upadhyay <tejas.upadhyay@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: matthew.auld@intel.com, arunpravin.paneerselvam@amd.com,
 Tejas Upadhyay <tejas.upadhyay@intel.com>,
 Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH V4 1/2] drm/gpu: Add gpu_buddy_allocated_addr_to_block helper
Date: Thu,  6 Aug 2026 11:06:25 +0530
Message-ID: <20260806053624.3215216-5-tejas.upadhyay@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260806053624.3215216-4-tejas.upadhyay@intel.com>
References: <20260806053624.3215216-4-tejas.upadhyay@intel.com>
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

