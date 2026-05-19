Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63100CD5BA6
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 12:29:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C639010ECA0;
	Tue, 19 May 2026 12:29:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="njoWijeb";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4E8D10EC9B;
 Tue, 19 May 2026 12:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779193745; x=1810729745;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=AwAwKzubBSQb3qB1gIbTDjmSxSJX43XcSCWGkaoDirQ=;
 b=njoWijebYRw3O/8VNfaPLqI0ZwqaId0uc1DBsIjgt9eml0stv0kn5E5j
 CKtMJMm5H3yszPoc52unJvN3H58+S0gQUhxlgTkxAI2yXyQ4uv/GUqNnV
 5kWpNljQQXMJu5h7NdbaOLJHnKUaEuSgoB1RWvi7hdCfwtWKQzrQk0BMg
 CoLl//Y23h0/mE6Kpc1/mInE2d6Pg4RkVq/4DB89YE/k11kv8GhuW/MQw
 jeyTt1oxG21iVd68YF80ZpGoXVDgXDWXUOhjHn3KXNQxxDX7fRdhJn1CF
 Vhc1PXp6AAuPO6i2oxvs5ec46ytPDGmHvnhykefPTEooM0UVDLI5mxGmo w==;
X-CSE-ConnectionGUID: RbTPLNRIS2mo4MmCzPMlGw==
X-CSE-MsgGUID: +yvMk238S3K92fmamS8lSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="79919448"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; d="scan'208";a="79919448"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2026 05:29:05 -0700
X-CSE-ConnectionGUID: 4ZNmBVmuQH2pTU06DWFcaA==
X-CSE-MsgGUID: cXk92Ra2Sc+e+lyGGDXpJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; d="scan'208";a="263261600"
Received: from tejasupa-desk.iind.intel.com (HELO tejasupa-desk)
 ([10.190.239.37])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2026 05:29:03 -0700
From: Tejas Upadhyay <tejas.upadhyay@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: matthew.auld@intel.com, matthew.brost@intel.com,
 thomas.hellstrom@linux.intel.com, himal.prasad.ghimiray@intel.com,
 Tejas Upadhyay <tejas.upadhyay@intel.com>,
 Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>,
 dri-devel@lists.freedesktop.org
Subject: [PATCH V10 08/10] gpu/buddy: Add routine to dump allocated buddy
 blocks
Date: Tue, 19 May 2026 17:58:23 +0530
Message-ID: <20260519122817.45770-20-tejas.upadhyay@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260519122817.45770-12-tejas.upadhyay@intel.com>
References: <20260519122817.45770-12-tejas.upadhyay@intel.com>
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

To implement the ability to see allocated blocks under a specific VRAM
instance in the drm driver, new api is introduced. While existing structs
often show the free block list, this addition provides a comprehensive view
of all currently resident VRAM allocations.

Dump will look like,

[  +0.000003] xe 0000:03:00.0: [drm] 0x00000002f8000000-0x00000002f8800000: 8388608
[  +0.000005] xe 0000:03:00.0: [drm] 0x00000002f8800000-0x00000002f8840000: 262144
[  +0.000004] xe 0000:03:00.0: [drm] 0x00000002f8840000-0x00000002f8860000: 131072
[  +0.000004] xe 0000:03:00.0: [drm] 0x00000002f8860000-0x00000002f8870000: 65536
[  +0.000005] xe 0000:03:00.0: [drm] 0x00000002f9000000-0x00000002f9800000: 8388608
[  +0.000004] xe 0000:03:00.0: [drm] 0x00000002f9800000-0x00000002f9880000: 524288
[  +0.000005] xe 0000:03:00.0: [drm] 0x00000002f9880000-0x00000002f9884000: 16384
[  +0.000004] xe 0000:03:00.0: [drm] 0x00000002f9900000-0x00000002f9980000: 524288
[  +0.000005] xe 0000:03:00.0: [drm] 0x00000002f9980000-0x00000002f9988000: 32768
[  +0.000004] xe 0000:03:00.0: [drm] 0x00000002f9988000-0x00000002f998c000: 16384

v2(MattB):
- Add lockdep assert

Signed-off-by: Tejas Upadhyay <tejas.upadhyay@intel.com>
Cc: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
Cc: dri-devel@lists.freedesktop.org
---
 drivers/gpu/buddy.c       | 43 +++++++++++++++++++++++++++++++++++++++
 include/linux/gpu_buddy.h |  1 +
 2 files changed, 44 insertions(+)

diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
index 9de9872294a6..fcea0d96d8cf 100644
--- a/drivers/gpu/buddy.c
+++ b/drivers/gpu/buddy.c
@@ -10,6 +10,7 @@
 #include <linux/sizes.h>
 
 #include <linux/gpu_buddy.h>
+#include <drm/drm_print.h>
 
 /**
  * gpu_buddy_assert - assert a condition in the buddy allocator
@@ -1294,6 +1295,48 @@ int gpu_buddy_block_trim(struct gpu_buddy *mm,
 }
 EXPORT_SYMBOL(gpu_buddy_block_trim);
 
+/**
+ * gpu_buddy_dump_allocated_blocks - print all allocated blocks in drm buddy
+ *
+ * @mm: DRM buddy manager to look into
+ *
+ * Looks into buddy manager for each block and their status and if allocated
+ * print allocated block range and size
+ *
+ * Returns:
+ * void
+ */
+void gpu_buddy_dump_allocated_blocks(struct gpu_buddy *mm)
+{
+	struct gpu_buddy_block *block;
+	LIST_HEAD(dfs);
+	int i;
+
+	gpu_buddy_driver_lock_held(mm);
+
+	for (i = 0; i < mm->n_roots; ++i)
+		list_add_tail(&mm->roots[i]->tmp_link, &dfs);
+
+	do {
+		block = list_first_entry_or_null(&dfs,
+						 struct gpu_buddy_block,
+						 tmp_link);
+		if (!block)
+			break;
+
+		list_del(&block->tmp_link);
+
+		if (gpu_buddy_block_is_allocated(block))
+			gpu_buddy_block_print(mm, block);
+
+		if (gpu_buddy_block_is_split(block)) {
+			list_add(&block->right->tmp_link, &dfs);
+			list_add(&block->left->tmp_link, &dfs);
+		}
+	} while (1);
+}
+EXPORT_SYMBOL(gpu_buddy_dump_allocated_blocks);
+
 static struct gpu_buddy_block *
 __gpu_buddy_alloc_blocks(struct gpu_buddy *mm,
 			 u64 start, u64 end,
diff --git a/include/linux/gpu_buddy.h b/include/linux/gpu_buddy.h
index e7e22fa05ee2..aaebdceb1c44 100644
--- a/include/linux/gpu_buddy.h
+++ b/include/linux/gpu_buddy.h
@@ -267,6 +267,7 @@ int gpu_buddy_block_trim(struct gpu_buddy *mm,
 			 u64 *start,
 			 u64 new_size,
 			 struct list_head *blocks);
+void gpu_buddy_dump_allocated_blocks(struct gpu_buddy *mm);
 
 void gpu_buddy_reset_clear(struct gpu_buddy *mm, bool is_clear);
 
-- 
2.52.0

