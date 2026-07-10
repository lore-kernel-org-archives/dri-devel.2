Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 350FEC44501
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:54:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3562010E252;
	Fri, 10 Jul 2026 21:54:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="GY1NOWyu";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C32E410E1FB;
 Fri, 10 Jul 2026 21:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783720489; x=1815256489;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=uANo8AU2qjxG7dyQS1UjyUtkgRaIVCXKH5biwxrC45c=;
 b=GY1NOWyukQCRAYqybDf2QFStgo4dVUj67hIqKLC4YjtCS8DBxo2LmKQv
 SFfWOoLWs0oDDZfWyBrWGvtCpXk9kDFtO13wydlCqrfllTdP8zSMLwbeb
 wD0Letg1IPPapu+XIk9Vc2lAx6V4lV2+XL/YJRFt0mu3pQbieKjz/V1HH
 ZgxCNdSsFz0CMLNSmVm9El1qrKSe0Lz0lFZQYTnigYHw3olyqtTWrKEkA
 4kjUYiQnLT2f0H27pjllds7817a9fxeRGzRz0Uwc6invo2NfZvG8C5RWk
 YqIgBzOZCsYOZR9OUXnMvBEZoWzPlJAeQCRuJxxoxzBbSKdnfyjQ+BUsj w==;
X-CSE-ConnectionGUID: 7MKXxPOrRIm4/O0vs2YzmQ==
X-CSE-MsgGUID: YqR1YG1DSAuTbSHmPTmmNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="83543045"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="83543045"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2026 14:54:48 -0700
X-CSE-ConnectionGUID: URlHXn9+Qb+a3/Mw346sNw==
X-CSE-MsgGUID: ZLa++p9jShmDFJVbr8ZY8Q==
X-ExtLoop1: 1
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2026 14:54:47 -0700
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
Subject: [PATCH v2 01/33] drm/ttm/pool: Allow backing off reclaim at the
 beneficial order
Date: Fri, 10 Jul 2026 14:54:10 -0700
Message-Id: <20260710215442.2444235-2-matthew.brost@intel.com>
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

Allocating at the pool's beneficial order normally uses
__GFP_RETRY_MAYFAIL to push hard for a contiguous high-order page. When
beneficial-order allocations have recently been failing, this retry just
burns CPU cycles in reclaim/compaction before falling back to a smaller
order anyway.

Add a beneficial_reclaim_backoff flag to struct ttm_operation_ctx and
plumb it through to ttm_pool_alloc_page(). When set, the beneficial
order is treated like the orders we already consider not worth stalling
for: __GFP_RECLAIM is cleared so the allocation skips reclaim/compaction
entirely, and the __GFP_NORETRY clearing / __GFP_RETRY_MAYFAIL promotion
is skipped. Together this makes the allocator back off quickly to a
smaller order instead of stalling.

This is a no-op until a caller opts in.

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
 drivers/gpu/drm/ttm/ttm_pool.c | 12 ++++++++----
 include/drm/ttm/ttm_bo.h       |  7 +++++++
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
index 3d5f2ae0a456..dbe977412a81 100644
--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c
@@ -145,7 +145,8 @@ static int ttm_pool_nid(struct ttm_pool *pool)
 
 /* Allocate pages of size 1 << order with the given gfp_flags */
 static struct page *ttm_pool_alloc_page(struct ttm_pool *pool, gfp_t gfp_flags,
-					unsigned int order)
+					unsigned int order,
+					bool beneficial_reclaim_backoff)
 {
 	const unsigned int beneficial_order = ttm_pool_beneficial_order(pool);
 	unsigned long attr = DMA_ATTR_FORCE_CONTIGUOUS;
@@ -165,10 +166,12 @@ static struct page *ttm_pool_alloc_page(struct ttm_pool *pool, gfp_t gfp_flags,
 	 * Do not add latency to the allocation path for allocations orders
 	 * device tolds us do not bring them additional performance gains.
 	 */
-	if (order && beneficial_order && order != beneficial_order)
+	if (order && (beneficial_reclaim_backoff ||
+		      (beneficial_order && order != beneficial_order)))
 		gfp_flags &= ~__GFP_RECLAIM;
 
-	if (beneficial_order && order == beneficial_order) {
+	if (!beneficial_reclaim_backoff &&
+	    beneficial_order && order == beneficial_order) {
 		gfp_flags &= ~__GFP_NORETRY;
 		gfp_flags |= __GFP_RETRY_MAYFAIL;
 	}
@@ -814,7 +817,8 @@ static int __ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
 		if (!p) {
 			page_caching = ttm_cached;
 			allow_pools = false;
-			p = ttm_pool_alloc_page(pool, gfp_flags, order);
+			p = ttm_pool_alloc_page(pool, gfp_flags, order,
+						ctx->beneficial_reclaim_backoff);
 		}
 		/* If that fails, lower the order if possible and retry. */
 		if (!p) {
diff --git a/include/drm/ttm/ttm_bo.h b/include/drm/ttm/ttm_bo.h
index 8310bc3d55f9..fd814b5cf535 100644
--- a/include/drm/ttm/ttm_bo.h
+++ b/include/drm/ttm/ttm_bo.h
@@ -187,6 +187,13 @@ struct ttm_operation_ctx {
 	 * when multiple BOs share the same reservation object @resv.
 	 */
 	bool allow_res_evict;
+	/**
+	 * @beneficial_reclaim_backoff: Back off from direct reclaim at the
+	 * pool's beneficial order. Useful when beneficial-order allocation has
+	 * recently been failing, to avoid burning CPU cycles in
+	 * reclaim/compaction before falling back to a smaller order anyway.
+	 */
+	bool beneficial_reclaim_backoff;
 	/**
 	 * @resv: Reservation object to be used together with
 	 * @allow_res_evict.
-- 
2.34.1

