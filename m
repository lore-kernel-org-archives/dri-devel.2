Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E244D58B09
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 03:59:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3858310E2B6;
	Mon, 16 Mar 2026 03:59:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="YdHTY2Qi";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBAAF10E2AF;
 Mon, 16 Mar 2026 03:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773633593; x=1805169593;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=lM7yVBNtjUQ4daYcyXeHh74jDYzXneNb6FXu9qEC5I8=;
 b=YdHTY2QiDvE7m1ui5lhBceNzRSVLrjcYr2a/vmJcnR0ZX1Ibdhlo7E/y
 ETQAGH4KAR2VnThcE1oD+hhfv/f8KEYp4P6DpDMZ+jW9Tg5F8N8q5lXgL
 MfHBQgF73XHy7s9nxKR+UYfLRcqBRc8ES+xlr+creRFRG4b91JY4BzM3V
 FBj8PbcuYsaOgSx6iihgvSb8kBOHyTMWPxbNQCEGwuR/0rLfYa8FC9d9c
 Jqo9mA5rQ/scVIOizLd6rPezOhQ47QhU95aL62Fvcg915q6mYhSTRyodT
 q6WSghaq983gzFbg0WQ4XSQ3KhXyWlzWm+PKhROIVUXPx+KhLUyhNC0gm g==;
X-CSE-ConnectionGUID: kAJSiTBVTyWZhhW3sESPrA==
X-CSE-MsgGUID: MOwPvoCaSoeSn30Vw04c5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="78249145"
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; d="scan'208";a="78249145"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Mar 2026 20:59:26 -0700
X-CSE-ConnectionGUID: 72Xp84aoSYOdjJJrflE6YA==
X-CSE-MsgGUID: pGYc5wwMTfSBKUR2hEk/Uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; d="scan'208";a="220827963"
Received: from varungup-desk.iind.intel.com ([10.190.238.71])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Mar 2026 20:59:23 -0700
From: Varun Gupta <varun.gupta@intel.com>
To: dri-devel@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org, christian.koenig@amd.com,
 matthew.auld@intel.com, sanjay.kumar.yadav@intel.com
Subject: [PATCH] drm/ttm: Fix spelling mistakes and comment style in
 ttm_resource.c
Date: Mon, 16 Mar 2026 09:29:15 +0530
Message-ID: <20260316035915.1403424-1-varun.gupta@intel.com>
X-Mailer: git-send-email 2.43.0
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

Correct several spelling mistakes and textual inconsistencies in
kdoc comments and inline comments.

Suggested-by: Sanjay Yadav <sanjay.kumar.yadav@intel.com>
Signed-off-by: Varun Gupta <varun.gupta@intel.com>
---
 drivers/gpu/drm/ttm/ttm_resource.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_resource.c b/drivers/gpu/drm/ttm/ttm_resource.c
index 192fca24f37e..9f36631d48b6 100644
--- a/drivers/gpu/drm/ttm/ttm_resource.c
+++ b/drivers/gpu/drm/ttm/ttm_resource.c
@@ -37,7 +37,7 @@
 #include <drm/drm_print.h>
 #include <drm/drm_util.h>
 
-/* Detach the cursor from the bulk move list*/
+/* Detach the cursor from the bulk move list */
 static void
 ttm_resource_cursor_clear_bulk(struct ttm_resource_cursor *cursor)
 {
@@ -105,9 +105,9 @@ void ttm_resource_cursor_init(struct ttm_resource_cursor *cursor,
  * ttm_resource_cursor_fini() - Finalize the LRU list cursor usage
  * @cursor: The struct ttm_resource_cursor to finalize.
  *
- * The function pulls the LRU list cursor off any lists it was previusly
+ * The function pulls the LRU list cursor off any lists it was previously
  * attached to. Needs to be called with the LRU lock held. The function
- * can be called multiple times after eachother.
+ * can be called multiple times after each other.
  */
 void ttm_resource_cursor_fini(struct ttm_resource_cursor *cursor)
 {
@@ -317,10 +317,10 @@ void ttm_resource_move_to_lru_tail(struct ttm_resource *res)
 }
 
 /**
- * ttm_resource_init - resource object constructure
- * @bo: buffer object this resources is allocated for
+ * ttm_resource_init - resource object constructor
+ * @bo: buffer object this resource is allocated for
  * @place: placement of the resource
- * @res: the resource object to inistilize
+ * @res: the resource object to initialize
  *
  * Initialize a new resource object. Counterpart of ttm_resource_fini().
  */
@@ -435,7 +435,7 @@ EXPORT_SYMBOL(ttm_resource_free);
  * @size: How many bytes the new allocation needs.
  *
  * Test if @res intersects with @place and @size. Used for testing if evictions
- * are valueable or not.
+ * are valuable or not.
  *
  * Returns true if the res placement intersects with @place and @size.
  */
@@ -513,7 +513,7 @@ void ttm_resource_set_bo(struct ttm_resource *res,
  * @bdev: ttm device this manager belongs to
  * @size: size of managed resources in arbitrary units
  *
- * Initialise core parts of a manager object.
+ * Initialize core parts of a manager object.
  */
 void ttm_resource_manager_init(struct ttm_resource_manager *man,
 			       struct ttm_device *bdev,
@@ -536,8 +536,8 @@ EXPORT_SYMBOL(ttm_resource_manager_init);
 /*
  * ttm_resource_manager_evict_all
  *
- * @bdev - device to use
- * @man - manager to use
+ * @bdev: device to use
+ * @man: manager to use
  *
  * Evict all the objects out of a memory manager until it is empty.
  * Part of memory manager cleanup sequence.
@@ -882,7 +882,7 @@ ttm_kmap_iter_linear_io_init(struct ttm_kmap_iter_linear_io *iter_io,
 
 /**
  * ttm_kmap_iter_linear_io_fini - Clean up an iterator for linear io memory
- * @iter_io: The iterator to initialize
+ * @iter_io: The iterator to finalize
  * @bdev: The TTM device
  * @mem: The ttm resource representing the iomap.
  *
@@ -921,15 +921,15 @@ DEFINE_SHOW_ATTRIBUTE(ttm_resource_manager);
 /**
  * ttm_resource_manager_create_debugfs - Create debugfs entry for specified
  * resource manager.
- * @man: The TTM resource manager for which the debugfs stats file be creates
+ * @man: The TTM resource manager for which the debugfs stats file to be created
  * @parent: debugfs directory in which the file will reside
  * @name: The filename to create.
  *
- * This function setups up a debugfs file that can be used to look
+ * This function sets up a debugfs file that can be used to look
  * at debug statistics of the specified ttm_resource_manager.
  */
 void ttm_resource_manager_create_debugfs(struct ttm_resource_manager *man,
-					 struct dentry * parent,
+					 struct dentry *parent,
 					 const char *name)
 {
 #if defined(CONFIG_DEBUG_FS)
-- 
2.43.0

