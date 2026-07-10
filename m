Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7FF5C44506
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:55:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B52F10E4EC;
	Fri, 10 Jul 2026 21:54:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="WEVUJyfa";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE65810E1FB;
 Fri, 10 Jul 2026 21:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783720490; x=1815256490;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=CRsufZHSl8mAGIVIzULD/lVBN6+M2i7HeN/b1zpdF34=;
 b=WEVUJyfamb5DAC3WjmK9NykAAt9/5Rl+KaKCSnJqXW2WgPdkEiZPMmXP
 3Gp6S/CoCZgKW35YP3pHnHVfnC2aCLRS/rPUVeIksnpiUCW6QG87KeTsV
 vDJKumHaTilms69YHnGQ5uR7ZY5Re9XFp+UE79NWQQeaiCn2gwk6++rk2
 kiRfuLbYLmCaVIak95OHgCW+l26PHk6r777+gBPh8bB9sae6fIDYamDnK
 XQMWBHxybpNOk+NRafvKl3wObkMf1qoPR8Vh1yyY1YT7WjTFqWGAUnMg9
 R9ryGmffkcOGZMJItZ9cAL/9ZgK9nJxwWHOaUu3YwfBdGAlbTgynsmwPM g==;
X-CSE-ConnectionGUID: iAKPH2haTmuucraMCiaRTw==
X-CSE-MsgGUID: /CC+7av2RTa/6cUBHTV4YA==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="83543086"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="83543086"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2026 14:54:49 -0700
X-CSE-ConnectionGUID: 98yE1KLgQhu6BA+sLgJysw==
X-CSE-MsgGUID: fIgRlXc3RXimCT2VNPf1kw==
X-ExtLoop1: 1
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2026 14:54:49 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: Carlos Santa <carlos.santa@intel.com>, Ryan Neph <ryanneph@google.com>,
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Subject: [PATCH v2 06/33] drm/ttm: Add fault injection for beneficial-order
 allocation failures
Date: Fri, 10 Jul 2026 14:54:15 -0700
Message-Id: <20260710215442.2444235-7-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260710215442.2444235-1-matthew.brost@intel.com>
References: <20260710215442.2444235-1-matthew.brost@intel.com>
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
backup_fault_inject, that forces allocation at (or above) the device's
beneficial order to fail in __ttm_pool_alloc(). When triggered, both the
pool take and the system page allocation are skipped for that order, so
the allocation falls into the existing lower-the-order path that sets
the TTM_TT_FLAG_BENEFICIAL_ORDER_FAILED tt page flag (and bails out with
-ENOMEM for defrag moves).

This lets the TTM_TT_FLAG_BENEFICIAL_ORDER_FAILED tracking and the
driver-side defrag path be exercised deterministically, without having to
drive the system into real memory fragmentation to provoke a sub-optimal
backing.

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
 drivers/gpu/drm/ttm/ttm_pool.c | 35 ++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
index 340855e9bcfe..34f533adb8eb 100644
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
@@ -812,21 +813,34 @@ struct ttm_pool_alloc_iter {
 	unsigned int order;
 	enum ttm_caching page_caching;
 	bool allow_pools;
+	bool fail_beneficial;
 	struct page *p;
 };
 
 /*
  * Acquire a single page for the current order, leaving it in @it->p (NULL on
- * failure). Tries a same-order pool page, then a fresh system allocation.
+ * failure). Tries a same-order pool page, then a fresh system allocation. Fault
+ * injection can force the beneficial-order paths to "fail".
  */
 static void ttm_pool_iter_acquire_page(struct ttm_pool_alloc_iter *it)
 {
 	struct ttm_pool_type *pt;
 
-	/* First, try to allocate a page from a pool if one exists. */
 	it->p = NULL;
+
+	/*
+	 * Fault injection: pretend allocation at (or above) the device's
+	 * beneficial order failed, forcing a sub-optimal backing. Exercises the
+	 * beneficial_order_failed tracking and the driver defrag path without
+	 * driving the system into real fragmentation.
+	 */
+	it->fail_beneficial = IS_ENABLED(CONFIG_FAULT_INJECTION) &&
+		it->beneficial_order && it->order >= it->beneficial_order &&
+		should_fail(&beneficial_order_fault_inject, 1);
+
+	/* First, try to allocate a page from a pool if one exists. */
 	pt = ttm_pool_select_type(it->pool, it->page_caching, it->order);
-	if (!it->p && pt && it->allow_pools)
+	if (!it->p && pt && it->allow_pools && !it->fail_beneficial)
 		it->p = ttm_pool_type_take(pt, ttm_pool_nid(it->pool));
 
 	/*
@@ -834,7 +848,7 @@ static void ttm_pool_iter_acquire_page(struct ttm_pool_alloc_iter *it)
 	 * this also disallows additional pool allocations using write-back
 	 * cached pools of the same order.
 	 */
-	if (!it->p) {
+	if (!it->p && !it->fail_beneficial) {
 		it->page_caching = ttm_cached;
 		it->allow_pools = false;
 		it->p = ttm_pool_alloc_page(it->pool, it->gfp_flags, it->order,
@@ -851,6 +865,9 @@ static void ttm_pool_iter_acquire_page(struct ttm_pool_alloc_iter *it)
  */
 static int ttm_pool_iter_lower_order(struct ttm_pool_alloc_iter *it)
 {
+	bool at_beneficial = it->beneficial_order &&
+			     it->order == it->beneficial_order;
+
 	if (!it->order)
 		return -ENOMEM;
 
@@ -860,13 +877,16 @@ static int ttm_pool_iter_lower_order(struct ttm_pool_alloc_iter *it)
 	 * pages. Record it so the driver can later try to defragment the object
 	 * back to beneficial order.
 	 */
-	if (it->beneficial_order && it->order == it->beneficial_order) {
+	if (it->fail_beneficial || at_beneficial) {
 		it->tt->page_flags |= TTM_TT_FLAG_BENEFICIAL_ORDER_FAILED;
 		if (it->ctx->defrag)
 			return -ENOMEM;
 	}
 
-	it->order--;
+	if (it->fail_beneficial)
+		it->order = it->beneficial_order - 1;
+	else
+		it->order--;
 	it->page_caching = it->tt->caching;
 	it->allow_pools = true;
 
@@ -1536,6 +1556,9 @@ int ttm_pool_mgr_init(unsigned long num_pages)
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

