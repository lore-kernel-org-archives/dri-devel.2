Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBD3FCDE004
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 22:27:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C1A010ECF2;
	Tue, 23 Jun 2026 22:27:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="W3FEx8TU";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08A4310ECD9;
 Tue, 23 Jun 2026 22:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782253660; x=1813789660;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=S7fdS5blOqr7UlrN6VqpboP6T54T6SPgBv/tucOsCCw=;
 b=W3FEx8TUBFSE/bb8ldnWlivVjLXGxpyCT47fGks+5I+dbRsl+F5oELOn
 2xS4H1jpmEwzR4VfJEegn5IaUSNzdBnzf3ZN/xe5szoR+QwcpwSyReXUs
 mOLpmOZTys8f+A3kSCmK8+IomXMui1MJX6HSsmWgt9G3rcao+DtbAyNEI
 BT4tW70koGm+j5lfO3vfLOW6hcQnxq5/6VHXncY/kATis3yVMb4HdfNAl
 pzYp/jdWbo6j5u8gIMP42kcwVSuBbrqlhhc21qSMNys1C56P6y1R0T+N3
 lnQNK31zy8W4VXbr86adOg+iu/Uev18f8DBLnuqQhl6lJ1H0Bs1YLQ5rf w==;
X-CSE-ConnectionGUID: 6J8nhaw4Qf2vwo1CnaGsUA==
X-CSE-MsgGUID: luJBUDkeSzSPVXHdUuuwYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="83048824"
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; d="scan'208";a="83048824"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2026 15:27:39 -0700
X-CSE-ConnectionGUID: RqAJR4MRQ5WNPbLFRtgvDg==
X-CSE-MsgGUID: TZ/JBW/SQMW3VJ2FNOZ3Ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; d="scan'208";a="273335803"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2026 15:27:39 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [RFC PATCH 04/12] drm/ttm: Add fault injection for beneficial-order
 allocation failures
Date: Tue, 23 Jun 2026 15:27:24 -0700
Message-Id: <20260623222732.360872-5-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260623222732.360872-1-matthew.brost@intel.com>
References: <20260623222732.360872-1-matthew.brost@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Add a beneficial_order_fault_inject debugfs fault attribute, mirroring
backup_fault_inject, that forces allocation at the device's beneficial
order to fail in __ttm_pool_alloc(). When triggered, both the pool take
and the system page allocation are skipped for that order, so the
allocation falls into the existing lower-the-order path that records
tt->beneficial_order_failed (and bails out with -ENOMEM for defrag
moves).

This lets the beneficial_order_failed tracking and the driver-side
defrag path be exercised deterministically, without having to drive the
system into real memory fragmentation to provoke a sub-optimal backing.

The knob is registered at
/sys/kernel/debug/ttm/beneficial_order_fault_inject and compiles out
when CONFIG_FAULT_INJECTION is disabled.

Cc: Carlos Santa <carlos.santa@intel.com>
Cc: Ryan Neph <ryanneph@google.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Huang Rui <ray.huang@amd.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Assisted-by: GitHub_Copilot:claude-opus-4.8
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
---
 drivers/gpu/drm/ttm/ttm_pool.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
index 6e9a5481d876..3330df7bc61d 100644
--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c
@@ -53,6 +53,7 @@
 #ifdef CONFIG_FAULT_INJECTION
 #include <linux/fault-inject.h>
 static DECLARE_FAULT_ATTR(backup_fault_inject);
+static DECLARE_FAULT_ATTR(beneficial_order_fault_inject);
 #else
 #define should_fail(...) false
 #endif
@@ -802,11 +803,24 @@ static int __ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
 	     alloc->remaining_pages;
 	     order = ttm_pool_alloc_find_order(order, alloc)) {
 		struct ttm_pool_type *pt;
+		bool fail_beneficial;
+
+		/*
+		 * Fault injection: pretend allocation at the device's
+		 * beneficial order failed, forcing the object to be backed with
+		 * a sub-optimal (smaller order) set of pages. Used to exercise
+		 * the beneficial_order_failed tracking and the driver defrag
+		 * path without having to drive the system into real memory
+		 * fragmentation.
+		 */
+		fail_beneficial = IS_ENABLED(CONFIG_FAULT_INJECTION) &&
+			beneficial_order && order >= beneficial_order &&
+			should_fail(&beneficial_order_fault_inject, 1);
 
 		/* First, try to allocate a page from a pool if one exists. */
 		p = NULL;
 		pt = ttm_pool_select_type(pool, page_caching, order);
-		if (pt && allow_pools)
+		if (pt && allow_pools && !fail_beneficial)
 			p = ttm_pool_type_take(pt, ttm_pool_nid(pool));
 
 		/*
@@ -815,7 +829,7 @@ static int __ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
 		 * write-back cached pools of the same order. Consider removing
 		 * that behaviour.
 		 */
-		if (!p) {
+		if (!p && !fail_beneficial) {
 			page_caching = ttm_cached;
 			allow_pools = false;
 			p = ttm_pool_alloc_page(pool, gfp_flags, order,
@@ -1453,6 +1467,9 @@ int ttm_pool_mgr_init(unsigned long num_pages)
 #ifdef CONFIG_FAULT_INJECTION
 	fault_create_debugfs_attr("backup_fault_inject", ttm_debugfs_root,
 				  &backup_fault_inject);
+	fault_create_debugfs_attr("beneficial_order_fault_inject",
+				  ttm_debugfs_root,
+				  &beneficial_order_fault_inject);
 #endif
 #endif
 
-- 
2.34.1

