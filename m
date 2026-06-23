Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 274C2CDE002
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 22:27:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2B4010ECEE;
	Tue, 23 Jun 2026 22:27:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="AwGtVaZD";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A362610E392;
 Tue, 23 Jun 2026 22:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782253659; x=1813789659;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=qjJyWtoYkEQxVJroAOJ9dERDA3rc6CWgB7rorL7bsc4=;
 b=AwGtVaZD27/biT2bos2NJrSBQHf9r86UM1o9bPwkJ9un99VaptlqGw/V
 hdn0VbjpXNVoqZUek4CBCFDfX/AkjTY/xL2DurZ51pEXqI7sDp7yjhHAb
 bNYV8M2kqyVig7c0f6kYIuKwSbBZ9o0WjqMImKI6MCvxTSkFRruy6hyRA
 vQFG+mFFUO3BnS6I13rjAdoUdH80MjPd0Qc/5r1OUz4tcCSyVTOv6Ej7S
 HGz1eFdmOdiowX8u2NFKeMaQxV2TnCI0oFIiPjZmLmzNoChTTBp4W+aj1
 HSUgSAQ3Y1EDLVOaFgse5U+g5lKcfoRElMXy42v4gNrY6O52wQDcz7GKN A==;
X-CSE-ConnectionGUID: BoXqQvEYSKycn+VDdhgQjw==
X-CSE-MsgGUID: qH2A3Ua0TxGx7/gP3oqWyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="83048820"
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; d="scan'208";a="83048820"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2026 15:27:38 -0700
X-CSE-ConnectionGUID: 4WyAs6fAS3qcztYBhxVJow==
X-CSE-MsgGUID: 7D5JvnAOSpuDiG6kglxEcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; d="scan'208";a="273335800"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2026 15:27:39 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [RFC PATCH 01/12] drm/ttm/pool: Allow backing off reclaim at the
 beneficial order
Date: Tue, 23 Jun 2026 15:27:21 -0700
Message-Id: <20260623222732.360872-2-matthew.brost@intel.com>
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

Allocating at the pool's beneficial order normally uses
__GFP_RETRY_MAYFAIL to push hard for a contiguous high-order page. When
beneficial-order allocations have recently been failing, this retry just
burns CPU cycles in direct reclaim/compaction before falling back to a
smaller order anyway.

Add a beneficial_reclaim_backoff flag to struct ttm_operation_ctx and
plumb it through to ttm_pool_alloc_page(). When set, the beneficial
order is treated like the orders we already consider not worth stalling
for: __GFP_RECLAIM is cleared so the allocation skips direct
reclaim/compaction entirely, and the __GFP_NORETRY clearing /
__GFP_RETRY_MAYFAIL promotion is skipped. Together this makes the
allocator back off quickly to a smaller order instead of stalling.

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
 include/drm/ttm/ttm_bo.h       |  6 ++++++
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
index 682ae4f40424..5b95f8f938f7 100644
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
index 8310bc3d55f9..f59c175622d4 100644
--- a/include/drm/ttm/ttm_bo.h
+++ b/include/drm/ttm/ttm_bo.h
@@ -187,6 +187,12 @@ struct ttm_operation_ctx {
 	 * when multiple BOs share the same reservation object @resv.
 	 */
 	bool allow_res_evict;
+	/**
+	 * @beneficial_reclaim_backoff: Backoff from direct reclaim at the pools
+	 * beneficial order. Useful when beneficial order allocation has
+	 * recently failed and backoff from waiting CPU cycles.
+	 */
+	bool beneficial_reclaim_backoff;
 	/**
 	 * @resv: Reservation object to be used together with
 	 * @allow_res_evict.
-- 
2.34.1

