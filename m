Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC85ACD8C80
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 12:39:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9043112AEB;
	Fri,  5 Jun 2026 12:39:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="MM6yY/az";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 658AD112AEA;
 Fri,  5 Jun 2026 12:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780663143; x=1812199143;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ls7YEoIFO4BgjEcCD5rPELKLv7OgmY4qkjTWsRyKaMM=;
 b=MM6yY/azgxSv8PGpC60lkkz/U2a7q90LLen6ukiQ0t914hNUq8cHCl9a
 5w93JdxNhAku6GLSJQrY8wCn3XFAaF9bJ8gOCOG1ZtE4ccUB6ZAWo1TD7
 TId8NWgusgkEMkEN7/w4ppJ1T6VSxT1T3YIVJDnzl4dTfyZs2lPMC1jtq
 eg4PO/RJuNKzRMvrHT5G+GNseNc4mXAhp2C2r/tHdyJWyaSgiZChL7UO3
 KRaka+UX4mbWdlXZEzlURBAgx59CKa4i1xRYntZff3J4NyczLe+vFNYBm
 U711F8mnqSmqJgSIbQyz3sFVhSa4D8jsLRhfxu58/PpWAm/GqZjv24eCS g==;
X-CSE-ConnectionGUID: kxMe2UKoQeKZ14008d5/uw==
X-CSE-MsgGUID: 8HxhJ7ddQ3+pUW0An1C68A==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="106937341"
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; d="scan'208";a="106937341"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2026 05:39:03 -0700
X-CSE-ConnectionGUID: rRsiIl7/R2evd8PVTf22zQ==
X-CSE-MsgGUID: fFgB/CprS0iAaPLramUV0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; d="scan'208";a="249938908"
Received: from tejasupa-desk.iind.intel.com (HELO tejasupa-desk)
 ([10.190.239.37])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2026 05:39:01 -0700
From: Tejas Upadhyay <tejas.upadhyay@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: matthew.auld@intel.com, matthew.brost@intel.com,
 thomas.hellstrom@linux.intel.com, himal.prasad.ghimiray@intel.com,
 Tejas Upadhyay <tejas.upadhyay@intel.com>,
 Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>,
 dri-devel@lists.freedesktop.org
Subject: [PATCH V11 03/12] drm/gpu: Add gpu_buddy_allocated_addr_to_block
 helper
Date: Fri,  5 Jun 2026 18:08:41 +0530
Message-ID: <20260605123839.236021-17-tejas.upadhyay@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260605123839.236021-14-tejas.upadhyay@intel.com>
References: <20260605123839.236021-14-tejas.upadhyay@intel.com>
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
---
 drivers/gpu/buddy.c       | 53 +++++++++++++++++++++++++++++++++++++++
 include/linux/gpu_buddy.h |  2 ++
 2 files changed, 55 insertions(+)

diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
index eb1457376307..315f860f4346 100644
--- a/drivers/gpu/buddy.c
+++ b/drivers/gpu/buddy.c
@@ -594,6 +594,59 @@ void gpu_buddy_free_block(struct gpu_buddy *mm,
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
index 71941a039648..e7e22fa05ee2 100644
--- a/include/linux/gpu_buddy.h
+++ b/include/linux/gpu_buddy.h
@@ -272,6 +272,8 @@ void gpu_buddy_reset_clear(struct gpu_buddy *mm, bool is_clear);
 
 void gpu_buddy_free_block(struct gpu_buddy *mm, struct gpu_buddy_block *block);
 
+struct gpu_buddy_block *gpu_buddy_allocated_addr_to_block(struct gpu_buddy *mm, u64 addr);
+
 void gpu_buddy_free_list(struct gpu_buddy *mm,
 			 struct list_head *objects,
 			 unsigned int flags);
-- 
2.52.0

